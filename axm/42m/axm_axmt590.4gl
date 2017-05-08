#該程式未解開Section, 採用最新樣板產出!
{<section id="axmt590.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0024(2017-02-15 18:00:23), PR版次:0024(2017-02-16 19:55:21)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000335
#+ Filename...: axmt590
#+ Description: 出貨簽退單維護作業
#+ Creator....: 04543(2014-04-20 00:00:00)
#+ Modifier...: 08992 -SD/PR- 08992
 
{</section>}
 
{<section id="axmt590.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#150721-00001#1   2016/01/08 By earl      控制組過濾、單據別與客戶預設資料調整
#160314-00008#1   2016/03/16 By catmoon   批/序號3:不控管時,修改儲位/批號時沒有更新到inao_t
#160316-00007#5   2016/03/16 By lixh      制造批序号相关程式请加上对库存管理特征的处理
#160308-00010#5   2016/03/31 By Jessica   1.補上BPM簽核功能鈕控制 2.已拒絕、已抽單單據，修改時報錯:單據狀態不是N，不能修改
#160325-00003#1   2016/05/30 By shiun     修改儲位說明顯示規則
#160519-00022#13  2016/07/14 By 02040     借貨還量單需依料號控卡批號是否可以輸入，簽退單批號不可輸入
#160705-00042#12  2016/07/15 By 02159     把gzcb002=固定寫死的作業代號改成g_prog,然後gzcb_t要多JOIN gzzz_t
#160519-00008#12  2016/07/19 By 02097     单据上库存管理特征栏位依依料件设定控管
#160510-00043#2   2016/07/25 By 02097     T類作業在browser_fill()組SQL前,呼叫s_aooi200_filter_slip將回傳條件組進去g_wc中
#160812-00017#6   2016/08/19 By 06814     在satatchange( )的FUNCTION中，有RETURN指令但沒有加上transaction_end( ) 
#                                         造成transaction沒有結束就直接RETURN
#160818-00017#43  2016/08/29 By lixh      单据类作业修改，删除时需重新检查状态
#161109-00085#4   2016/11/10 By lienjunqi 整批調整系統星號寫法
#161109-00085#65  2016/12/01 By 08171     整批調整系統星號寫法
#161207-00033#18  2016/12/20 By 08993     1.一次性交易對象名稱顯示要改抓pmak003  2.按作廢時，狀態應不做任何動作(RETURN)
#161221-00064#18  2017/01/10 By zhujing   增加pmao000(1-采购，2-销售),用于区分axmi120和apmi120数据显示
#170111-00020#1   2017/01/17 By 09042     增加呼叫axmr590报表功能  
#161031-00025#28  2017/02/07 By 08992     1.將aooi360_01以嵌入的方式，用頁籤放在axmt590單頭多帳期頁籤與異動資訊頁籤中間
#                                           要可修改
#                                           控制類型 =3:內部資訊傳遞 取消不要了
#                                           項次固定寫入0
#                                         2.原axmt590的備註action，改為確認後可執行，直接修改單頭新的"備註"頁籤
#                                         3.axmt590單身最後面增加顯示"長備註"欄位，一樣抓取aooi360的備註顯示
#                                           項次 = 單身項次
#                                           控制類型 = 列印在後
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"
IMPORT FGL sub_s_lot
IMPORT FGL aoo_aooi360_01   #161031-00025#28
#end add-point 
 
SCHEMA ds 
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔 name="global.inc"
#161031-00025#28-s
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
#161031-00025#28-e
#end add-point
 
#單頭 type 宣告
PRIVATE type type_g_xmdk_m        RECORD
       xmdk000 LIKE xmdk_t.xmdk000, 
   xmdksite LIKE xmdk_t.xmdksite, 
   xmdkdocno LIKE xmdk_t.xmdkdocno, 
   xmdkdocno_desc LIKE type_t.chr80, 
   xmdkdocdt LIKE xmdk_t.xmdkdocdt, 
   xmdk001 LIKE xmdk_t.xmdk001, 
   xmdk003 LIKE xmdk_t.xmdk003, 
   xmdk003_desc LIKE type_t.chr80, 
   xmdk004 LIKE xmdk_t.xmdk004, 
   xmdk004_desc LIKE type_t.chr80, 
   xmdkstus LIKE xmdk_t.xmdkstus, 
   xmdk081 LIKE xmdk_t.xmdk081, 
   xmdk005 LIKE xmdk_t.xmdk005, 
   xmdk006 LIKE xmdk_t.xmdk006, 
   xmdk002 LIKE xmdk_t.xmdk002, 
   xmdk007 LIKE xmdk_t.xmdk007, 
   xmdk007_desc LIKE type_t.chr80, 
   xmdk009 LIKE xmdk_t.xmdk009, 
   xmdk009_desc LIKE type_t.chr80, 
   xmdk008 LIKE xmdk_t.xmdk008, 
   xmdk008_desc LIKE type_t.chr80, 
   xmdkownid LIKE xmdk_t.xmdkownid, 
   xmdkownid_desc LIKE type_t.chr80, 
   xmdkowndp LIKE xmdk_t.xmdkowndp, 
   xmdkowndp_desc LIKE type_t.chr80, 
   xmdkcrtid LIKE xmdk_t.xmdkcrtid, 
   xmdkcrtid_desc LIKE type_t.chr80, 
   xmdkcrtdp LIKE xmdk_t.xmdkcrtdp, 
   xmdkcrtdp_desc LIKE type_t.chr80, 
   xmdkcrtdt LIKE xmdk_t.xmdkcrtdt, 
   xmdkmodid LIKE xmdk_t.xmdkmodid, 
   xmdkmodid_desc LIKE type_t.chr80, 
   xmdkmoddt LIKE xmdk_t.xmdkmoddt, 
   xmdkcnfid LIKE xmdk_t.xmdkcnfid, 
   xmdkcnfid_desc LIKE type_t.chr80, 
   xmdkcnfdt LIKE xmdk_t.xmdkcnfdt, 
   xmdkpstid LIKE xmdk_t.xmdkpstid, 
   xmdkpstid_desc LIKE type_t.chr80, 
   xmdkpstdt LIKE xmdk_t.xmdkpstdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_xmdl_d        RECORD
       xmdlsite LIKE xmdl_t.xmdlsite, 
   xmdlseq LIKE xmdl_t.xmdlseq, 
   xmdl001 LIKE xmdl_t.xmdl001, 
   xmdl002 LIKE xmdl_t.xmdl002, 
   xmdl003 LIKE xmdl_t.xmdl003, 
   xmdl004 LIKE xmdl_t.xmdl004, 
   xmdl005 LIKE xmdl_t.xmdl005, 
   xmdl006 LIKE xmdl_t.xmdl006, 
   xmda033 LIKE type_t.chr500, 
   xmdl007 LIKE xmdl_t.xmdl007, 
   xmdl008 LIKE xmdl_t.xmdl008, 
   xmdl008_desc LIKE type_t.chr500, 
   xmdl008_desc_desc LIKE type_t.chr500, 
   xmdl009 LIKE xmdl_t.xmdl009, 
   xmdl009_desc LIKE type_t.chr500, 
   xmdl033 LIKE xmdl_t.xmdl033, 
   xmdl033_desc LIKE type_t.chr500, 
   xmdl033_desc_desc LIKE type_t.chr500, 
   xmdl011 LIKE xmdl_t.xmdl011, 
   xmdl011_desc LIKE type_t.chr500, 
   xmdl012 LIKE xmdl_t.xmdl012, 
   xmdl017 LIKE xmdl_t.xmdl017, 
   xmdl017_desc LIKE type_t.chr500, 
   xmdl092 LIKE xmdl_t.xmdl092, 
   xmdl018 LIKE xmdl_t.xmdl018, 
   xmdl081 LIKE xmdl_t.xmdl081, 
   xmdl019 LIKE xmdl_t.xmdl019, 
   xmdl019_desc LIKE type_t.chr500, 
   xmdl093 LIKE xmdl_t.xmdl093, 
   xmdl020 LIKE xmdl_t.xmdl020, 
   xmdl082 LIKE xmdl_t.xmdl082, 
   xmdl084 LIKE xmdl_t.xmdl084, 
   xmdl084_desc LIKE type_t.chr500, 
   xmdl010 LIKE xmdl_t.xmdl010, 
   xmdl013 LIKE xmdl_t.xmdl013, 
   xmdl014 LIKE xmdl_t.xmdl014, 
   xmdl014_desc LIKE type_t.chr500, 
   xmdl015 LIKE xmdl_t.xmdl015, 
   xmdl015_desc LIKE type_t.chr500, 
   xmdl016 LIKE xmdl_t.xmdl016, 
   xmdl052 LIKE xmdl_t.xmdl052, 
   xmdl021 LIKE xmdl_t.xmdl021, 
   xmdl021_desc LIKE type_t.chr500, 
   xmdl022 LIKE xmdl_t.xmdl022, 
   xmdl083 LIKE xmdl_t.xmdl083, 
   xmdl030 LIKE xmdl_t.xmdl030, 
   xmdl030_desc LIKE type_t.chr500, 
   xmdl031 LIKE xmdl_t.xmdl031, 
   xmdl031_desc LIKE type_t.chr500, 
   xmdl032 LIKE xmdl_t.xmdl032, 
   xmdl032_desc LIKE type_t.chr500, 
   xmdl051 LIKE xmdl_t.xmdl051, 
   xmdl089 LIKE xmdl_t.xmdl089, 
   xmdl090 LIKE xmdl_t.xmdl090, 
   xmdl091 LIKE xmdl_t.xmdl091, 
   ooff013 LIKE type_t.chr500
       END RECORD
PRIVATE TYPE type_g_xmdl3_d RECORD
       xmdmsite LIKE xmdm_t.xmdmsite, 
   xmdmseq LIKE xmdm_t.xmdmseq, 
   xmdmseq1 LIKE xmdm_t.xmdmseq1, 
   xmdm001 LIKE xmdm_t.xmdm001, 
   xmdm001_desc LIKE type_t.chr500, 
   xmdm001_desc_desc LIKE type_t.chr500, 
   xmdm002 LIKE xmdm_t.xmdm002, 
   xmdm002_desc LIKE type_t.chr500, 
   xmdm003 LIKE xmdm_t.xmdm003, 
   xmdm004 LIKE xmdm_t.xmdm004, 
   xmdm005 LIKE xmdm_t.xmdm005, 
   xmdm005_desc LIKE type_t.chr500, 
   xmdm006 LIKE xmdm_t.xmdm006, 
   xmdm006_desc LIKE type_t.chr500, 
   xmdm007 LIKE xmdm_t.xmdm007, 
   xmdm033 LIKE xmdm_t.xmdm033, 
   xmdm008 LIKE xmdm_t.xmdm008, 
   xmdm008_desc LIKE type_t.chr500, 
   xmdm031 LIKE xmdm_t.xmdm031, 
   xmdm010 LIKE xmdm_t.xmdm010, 
   xmdm010_desc LIKE type_t.chr500, 
   xmdm032 LIKE xmdm_t.xmdm032
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_xmdkdocno LIKE xmdk_t.xmdkdocno,
      b_xmdk001 LIKE xmdk_t.xmdk001,
      b_xmdk003 LIKE xmdk_t.xmdk003,
   b_xmdk003_desc LIKE type_t.chr80,
      b_xmdk004 LIKE xmdk_t.xmdk004,
   b_xmdk004_desc LIKE type_t.chr80,
      b_xmdk006 LIKE xmdk_t.xmdk006,
      b_xmdk007 LIKE xmdk_t.xmdk007,
   b_xmdk007_desc LIKE type_t.chr80,
      b_xmdk008 LIKE xmdk_t.xmdk008,
   b_xmdk008_desc LIKE type_t.chr80,
      b_xmdk009 LIKE xmdk_t.xmdk009,
   b_xmdk009_desc LIKE type_t.chr80
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_acc_type            LIKE gzcb_t.gzcb002

#add by lixh 20150915
GLOBALS
   DEFINE g_d_idx_display   LIKE type_t.num5   #製造批序號明細所在筆數
   DEFINE g_d_cnt_display   LIKE type_t.num5   #製造批序號明細總筆數
   DEFINE g_appoint_idx     LIKE type_t.num5   #指定進入單身行數
   
 TYPE type_g_inao_d        RECORD
    inaoseq       LIKE inao_t.inaoseq,
    inaoseq1      LIKE inao_t.inaoseq1,
    inaoseq2      LIKE inao_t.inaoseq2,
    inao001       LIKE inao_t.inao001,
    inao001_desc  LIKE imaal_t.imaal003,
    inao001_desc2 LIKE imaal_t.imaal004,
    inao008       LIKE inao_t.inao008,
    inao009       LIKE inao_t.inao009,
    inao010       LIKE inao_t.inao010,
    inao012       LIKE inao_t.inao012
       END RECORD
DEFINE g_inao_d          DYNAMIC ARRAY OF type_g_inao_d      
END GLOBALS
#add by lixh 20150915
DEFINE g_slip_wc          STRING     #160510-00043#2
DEFINE g_detail_id          STRING           #紀錄停留在哪個Page #161031-00025#28 add
#end add-point
       
#模組變數(Module Variables)
DEFINE g_xmdk_m          type_g_xmdk_m
DEFINE g_xmdk_m_t        type_g_xmdk_m
DEFINE g_xmdk_m_o        type_g_xmdk_m
DEFINE g_xmdk_m_mask_o   type_g_xmdk_m #轉換遮罩前資料
DEFINE g_xmdk_m_mask_n   type_g_xmdk_m #轉換遮罩後資料
 
   DEFINE g_xmdkdocno_t LIKE xmdk_t.xmdkdocno
 
 
DEFINE g_xmdl_d          DYNAMIC ARRAY OF type_g_xmdl_d
DEFINE g_xmdl_d_t        type_g_xmdl_d
DEFINE g_xmdl_d_o        type_g_xmdl_d
DEFINE g_xmdl_d_mask_o   DYNAMIC ARRAY OF type_g_xmdl_d #轉換遮罩前資料
DEFINE g_xmdl_d_mask_n   DYNAMIC ARRAY OF type_g_xmdl_d #轉換遮罩後資料
DEFINE g_xmdl3_d          DYNAMIC ARRAY OF type_g_xmdl3_d
DEFINE g_xmdl3_d_t        type_g_xmdl3_d
DEFINE g_xmdl3_d_o        type_g_xmdl3_d
DEFINE g_xmdl3_d_mask_o   DYNAMIC ARRAY OF type_g_xmdl3_d #轉換遮罩前資料
DEFINE g_xmdl3_d_mask_n   DYNAMIC ARRAY OF type_g_xmdl3_d #轉換遮罩後資料
 
 
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
 
{<section id="axmt590.main" >}
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
   CALL cl_ap_init("axm","")
 
   #add-point:作業初始化 name="main.init"
   
   LET g_errshow = '1'                        
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
                           
   #end add-point
   LET g_forupd_sql = " SELECT xmdk000,xmdksite,xmdkdocno,'',xmdkdocdt,xmdk001,xmdk003,'',xmdk004,'', 
       xmdkstus,xmdk081,xmdk005,xmdk006,xmdk002,xmdk007,'',xmdk009,'',xmdk008,'',xmdkownid,'',xmdkowndp, 
       '',xmdkcrtid,'',xmdkcrtdp,'',xmdkcrtdt,xmdkmodid,'',xmdkmoddt,xmdkcnfid,'',xmdkcnfdt,xmdkpstid, 
       '',xmdkpstdt", 
                      " FROM xmdk_t",
                      " WHERE xmdkent= ? AND xmdkdocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
                           
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axmt590_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.xmdk000,t0.xmdksite,t0.xmdkdocno,t0.xmdkdocdt,t0.xmdk001,t0.xmdk003, 
       t0.xmdk004,t0.xmdkstus,t0.xmdk081,t0.xmdk005,t0.xmdk006,t0.xmdk002,t0.xmdk007,t0.xmdk009,t0.xmdk008, 
       t0.xmdkownid,t0.xmdkowndp,t0.xmdkcrtid,t0.xmdkcrtdp,t0.xmdkcrtdt,t0.xmdkmodid,t0.xmdkmoddt,t0.xmdkcnfid, 
       t0.xmdkcnfdt,t0.xmdkpstid,t0.xmdkpstdt,t1.ooag011 ,t2.ooefl003 ,t3.pmaal004 ,t4.pmaal004 ,t5.pmaal004 , 
       t6.ooag011 ,t7.ooefl003 ,t8.ooag011 ,t9.ooefl003 ,t10.ooag011 ,t11.ooag011 ,t12.ooag011",
               " FROM xmdk_t t0",
                              " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.xmdk003  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.xmdk004 AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t3 ON t3.pmaalent="||g_enterprise||" AND t3.pmaal001=t0.xmdk007 AND t3.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t4 ON t4.pmaalent="||g_enterprise||" AND t4.pmaal001=t0.xmdk009 AND t4.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t5 ON t5.pmaalent="||g_enterprise||" AND t5.pmaal001=t0.xmdk008 AND t5.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.xmdkownid  ",
               " LEFT JOIN ooefl_t t7 ON t7.ooeflent="||g_enterprise||" AND t7.ooefl001=t0.xmdkowndp AND t7.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=t0.xmdkcrtid  ",
               " LEFT JOIN ooefl_t t9 ON t9.ooeflent="||g_enterprise||" AND t9.ooefl001=t0.xmdkcrtdp AND t9.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t10 ON t10.ooagent="||g_enterprise||" AND t10.ooag001=t0.xmdkmodid  ",
               " LEFT JOIN ooag_t t11 ON t11.ooagent="||g_enterprise||" AND t11.ooag001=t0.xmdkcnfid  ",
               " LEFT JOIN ooag_t t12 ON t12.ooagent="||g_enterprise||" AND t12.ooag001=t0.xmdkpstid  ",
 
               " WHERE t0.xmdkent = " ||g_enterprise|| " AND t0.xmdkdocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE axmt590_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
                                                      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axmt590 WITH FORM cl_ap_formpath("axm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axmt590_init()   
 
      #進入選單 Menu (="N")
      CALL axmt590_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      #add by lixh 20150915
      CALL s_lot_ins_drop_tmp() 
      CALL s_lot_sel_drop_tmp() 
      #add by lixh 20150915      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axmt590
      
   END IF 
   
   CLOSE axmt590_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL axmt540_01_drop_temp_table()
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="axmt590.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION axmt590_init()
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
      CALL cl_set_combo_scc_part('xmdkstus','13','N,Y,S,A,D,R,W,UH,H,Z,X')
 
      CALL cl_set_combo_scc('xmdk000','2077') 
   CALL cl_set_combo_scc('xmdk002','2063') 
   CALL cl_set_combo_scc('xmdl007','2055') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
   CALL g_idx_group.addAttribute("'2',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   #161031-00025#28-s
   #子程式畫面取代主程式元件
   CALL cl_ui_replace_sub_window(cl_ap_formpath("aoo", "aooi360_01"), "grid_remarks", "Table", "s_detail1_aooi360_01")
   CALL cl_set_combo_scc_part('ooff012','11','1,2,4')
   CALL cl_set_comp_visible("ooff003",FALSE)
   #161031-00025#28-e       
   CALL cl_set_combo_scc_part('xmdkstus','13','N,X,Y,A,D,R,W')

   CALL axmt540_01_create_temp_table() RETURNING l_success

   #判斷據點參數若不使用產品特徵時，則產品特徵需隱藏不可以維護(據點參數:S-BAS-0036)
   IF cl_get_para(g_enterprise,g_site,'S-BAS-0036') = 'N' THEN
      CALL cl_set_comp_visible("xmdl009,xmdl009_desc,xmdm002,xmdm002_desc",FALSE)
   END IF

   #判斷據點參數若不使用參考單位時，則參考單位、數量需隱藏不可以維護(據點參數:S-BAS-0028)
   IF cl_get_para(g_enterprise,g_site,'S-BAS-0028') = 'N' THEN
      CALL cl_set_comp_visible("xmdl019,xmdl019_desc,xmdl020,xmdl082,xmdm010,xmdm010_desc,xmdm032",FALSE)           
   END IF

   #整體參數未使用採購計價單位
   IF cl_get_para(g_enterprise,g_site,'S-BAS-0007') = "N" THEN
      CALL cl_set_comp_visible("xmdl021,xmdl021_desc,xmdl022,xmdl083",FALSE)      
   END IF
   
   #add by lixh 20150915
   CALL cl_ui_replace_sub_window(cl_ap_formpath("sub", "s_lot_s01"), "grid_s_lot", "Table", "s_detail1_s_lot_s01")
   CALL s_lot_ins_create_tmp()
   CALL s_lot_sel_create_tmp()
   #add by lixh 20150915 
   
   #隱藏、替換畫面說明 
   CALL axmt590_window_show(g_argv[01])
   CALL s_aooi200_filter_slip('xmdkdocno') RETURNING g_slip_wc    #160510-00043#2
   #end add-point
   
   #初始化搜尋條件
   CALL axmt590_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="axmt590.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION axmt590_ui_dialog()
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
   DEFINE l_success LIKE type_t.num5 
   DEFINE r_success  LIKE type_t.num5
   DEFINE l_sql      STRING
   #mod--161109-00085#4-s
   #DEFINE l_inao     RECORD LIKE inao_t.*
   DEFINE l_inao RECORD  #製造批序號庫存異動明細檔
       inaoent LIKE inao_t.inaoent, #企業編號      
       inaosite LIKE inao_t.inaosite, #營運據點
       inaodocno LIKE inao_t.inaodocno, #單號
       inaoseq LIKE inao_t.inaoseq, #項次
       inaoseq1 LIKE inao_t.inaoseq1, #項序
       inaoseq2 LIKE inao_t.inaoseq2, #序號
       inao000 LIKE inao_t.inao000, #資料類型
       inao001 LIKE inao_t.inao001, #料件編號
       inao002 LIKE inao_t.inao002, #產品特徵
       inao003 LIKE inao_t.inao003, #庫存管理特徵
       inao004 LIKE inao_t.inao004, #包裝容器編號
       inao005 LIKE inao_t.inao005, #庫位
       inao006 LIKE inao_t.inao006, #儲位
       inao007 LIKE inao_t.inao007, #批號
       inao008 LIKE inao_t.inao008, #製造批號
       inao009 LIKE inao_t.inao009, #製造序號
       inao010 LIKE inao_t.inao010, #製造日期
       inao011 LIKE inao_t.inao011, #有效日期
       inao012 LIKE inao_t.inao012, #數量
       inao013 LIKE inao_t.inao013, #出入庫碼
       #161109-00085#65 --s add
       inaoud001 LIKE inao_t.inaoud001, #自定義欄位(文字)001
       inaoud002 LIKE inao_t.inaoud002, #自定義欄位(文字)002
       inaoud003 LIKE inao_t.inaoud003, #自定義欄位(文字)003
       inaoud004 LIKE inao_t.inaoud004, #自定義欄位(文字)004
       inaoud005 LIKE inao_t.inaoud005, #自定義欄位(文字)005
       inaoud006 LIKE inao_t.inaoud006, #自定義欄位(文字)006
       inaoud007 LIKE inao_t.inaoud007, #自定義欄位(文字)007
       inaoud008 LIKE inao_t.inaoud008, #自定義欄位(文字)008
       inaoud009 LIKE inao_t.inaoud009, #自定義欄位(文字)009
       inaoud010 LIKE inao_t.inaoud010, #自定義欄位(文字)010
       inaoud011 LIKE inao_t.inaoud011, #自定義欄位(數字)011
       inaoud012 LIKE inao_t.inaoud012, #自定義欄位(數字)012
       inaoud013 LIKE inao_t.inaoud013, #自定義欄位(數字)013
       inaoud014 LIKE inao_t.inaoud014, #自定義欄位(數字)014
       inaoud015 LIKE inao_t.inaoud015, #自定義欄位(數字)015
       inaoud016 LIKE inao_t.inaoud016, #自定義欄位(數字)016
       inaoud017 LIKE inao_t.inaoud017, #自定義欄位(數字)017
       inaoud018 LIKE inao_t.inaoud018, #自定義欄位(數字)018
       inaoud019 LIKE inao_t.inaoud019, #自定義欄位(數字)019
       inaoud020 LIKE inao_t.inaoud020, #自定義欄位(數字)020
       inaoud021 LIKE inao_t.inaoud021, #自定義欄位(日期時間)021
       inaoud022 LIKE inao_t.inaoud022, #自定義欄位(日期時間)022
       inaoud023 LIKE inao_t.inaoud023, #自定義欄位(日期時間)023
       inaoud024 LIKE inao_t.inaoud024, #自定義欄位(日期時間)024
       inaoud025 LIKE inao_t.inaoud025, #自定義欄位(日期時間)025
       inaoud026 LIKE inao_t.inaoud026, #自定義欄位(日期時間)026
       inaoud027 LIKE inao_t.inaoud027, #自定義欄位(日期時間)027
       inaoud028 LIKE inao_t.inaoud028, #自定義欄位(日期時間)028
       inaoud029 LIKE inao_t.inaoud029, #自定義欄位(日期時間)029
       inaoud030 LIKE inao_t.inaoud030, #自定義欄位(日期時間)030
       #161109-00085#65 --e add
       inao014 LIKE inao_t.inao014, #庫存單位          
       inao020 LIKE inao_t.inao020, #檢驗合格量
       inao021 LIKE inao_t.inao021, #已入庫/出貨/簽收量
       inao022 LIKE inao_t.inao022, #已驗退/簽退量
       inao023 LIKE inao_t.inao023, #已倉退/銷退量
       inao024 LIKE inao_t.inao024, #已轉QC量
       inao025 LIKE inao_t.inao025 #已退品量
               END RECORD
   #mod--161109-00085#4-e
   
   DEFINE l_num      LIKE inao_t.inao012
   DEFINE l_sum_inao012   LIKE inao_t.inao012
   DEFINE l_imaf053  LIKE imaf_t.imaf053
   DEFINE l_imaf054  LIKE imaf_t.imaf054   
   DEFINE l_imaf071  LIKE imaf_t.imaf071
   DEFINE l_imaf081  LIKE imaf_t.imaf081
   DEFINE l_xmdl001  LIKE xmdl_t.xmdl001
   DEFINE l_xmdl002  LIKE xmdl_t.xmdl002
   DEFINE l_cnt      LIKE type_t.num5   
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
            CALL axmt590_insert()
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
         INITIALIZE g_xmdk_m.* TO NULL
         CALL g_xmdl_d.clear()
         CALL g_xmdl3_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL axmt590_init()
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
               
               CALL axmt590_fetch('') # reload data
               LET l_ac = 1
               CALL axmt590_ui_detailshow() #Setting the current row 
         
               CALL axmt590_idx_chk()
               #NEXT FIELD xmdlseq
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_xmdl_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL axmt590_idx_chk()
               #確定當下選擇的筆數
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[1] = l_ac
               CALL g_idx_group.addAttribute("'1',",l_ac)
               
               #add-point:page1, before row動作 name="ui_dialog.page1.before_row"
               #add by lixh 20150915
               CALL axmt590_set_act_visible_b()
               CALL axmt590_set_act_no_visible_b()
               IF g_xmdl_d[g_detail_idx].xmdl013 = 'Y' THEN
                  CALL cl_set_act_visible("s_lot_sel",FALSE)
               END IF
               CALL s_lot_b_fill('1',g_site,'2',g_xmdk_m.xmdkdocno,g_xmdl_d[g_detail_idx].xmdlseq,1,'1')  
               #add by lixh 20150915
               #單身Action隱藏
               CALL axmt590_detail_action_hidden(l_ac)

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
               CALL axmt590_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               CALL cl_set_act_visible("s_lot_sel",TRUE)    #add by lixh 20150915
               #單身Action隱藏
               CALL axmt590_detail_action_hidden(l_ac)

               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION s_lot_sel
            LET g_action_choice="s_lot_sel"
            IF cl_auth_chk_act("s_lot_sel") THEN
               
               #add-point:ON ACTION s_lot_sel name="menu.detail_show.page1.s_lot_sel"
               IF cl_null(g_detail_idx) OR g_detail_idx = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'abm-00073'
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()               
                  EXIT DIALOG
               END IF
    
               IF NOT cl_null(g_xmdl_d[g_detail_idx].xmdlseq) THEN
                  LET l_success = ''
                  LET r_success = TRUE
                  CALL s_transaction_begin() 
                  
                  SELECT xmdl001,xmdl002 INTO l_xmdl001,l_xmdl002 FROM xmdl_t
                   WHERE xmdlent = g_enterprise
                     AND xmdldocno = g_xmdk_m.xmdkdocno
                     AND xmdlseq = g_xmdl_d[g_detail_idx].xmdlseq
                   
                  #複製出貨單批序號數量  
                  IF NOT s_axmt540_inao_copy_3(l_xmdl001,l_xmdl002,'2',g_xmdk_m.xmdkdocno,g_xmdl_d[g_detail_idx].xmdlseq,'1',g_xmdl_d[g_detail_idx].xmdl016) THEN 
                     LET r_success = FALSE
                  END IF                  
                  
                  IF NOT r_success THEN
                     CALL s_transaction_end('N','0')
                     EXIT DIALOG
                  END IF   
                  
                  CALL s_lot_sel('2','2',g_site,g_xmdk_m.xmdkdocno,g_xmdl_d[g_detail_idx].xmdlseq,'1',g_xmdl_d[g_detail_idx].xmdl008,g_xmdl_d[g_detail_idx].xmdl009,g_xmdl_d[g_detail_idx].xmdl052,g_xmdl_d[g_detail_idx].xmdl014,
                                 g_xmdl_d[g_detail_idx].xmdl015,g_xmdl_d[g_detail_idx].xmdl016,g_xmdl_d[g_detail_idx].xmdl017,g_xmdl_d[g_detail_idx].xmdl081,'1','axmt590','','','','','0')
                       RETURNING l_success                                                
                  IF NOT l_success THEN 
                     LET r_success = FALSE
                  END IF  

                  #回寫出貨單(增加)
                  IF NOT s_axmt540_update_inao_3(g_xmdk_m.xmdkdocno,g_xmdl_d[g_detail_idx].xmdlseq,'1',g_xmdl_d[g_detail_idx].xmdl016,l_xmdl001,l_xmdl002,'1') THEN
                     LET r_success = FALSE
                  END IF                                       
                  #刪除inao000 = '1' 的资料
                  DELETE FROM inao_t WHERE inaoent = g_enterprise
                                       AND inaodocno = g_xmdk_m.xmdkdocno
                                       AND inaoseq = g_xmdl_d[g_detail_idx].xmdlseq
                                       AND inaoseq1 = 1
                                       AND inao000 = '1' 
                                       AND inao013 = '1'       
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = 'foreach:' 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET r_success = FALSE
                  END IF                                        
               END IF

               SELECT SUM(inao012) INTO l_sum_inao012 FROM inao_t
                WHERE inaoent = g_enterprise
                  AND inaodocno = g_xmdk_m.xmdkdocno
                  AND inaoseq = g_xmdl_d[g_detail_idx].xmdlseq
                  AND inaoseq1 = 1
                  AND inao000 = '2' 
                  AND inao013 = '1'
                  
               #add by lixh 20151022
               SELECT imaf053,imaf054,imaf071,imaf081 INTO l_imaf053,l_imaf054,l_imaf071,l_imaf081 FROM imaf_t
                WHERE imafent = g_enterprise
                  AND imafsite = g_site
                  AND imaf001 = g_xmdl_d[g_detail_idx].xmdl017
               IF l_imaf071 = '1' OR l_imaf081 = '1' THEN
                  IF l_imaf054 = 'N' THEN
                     CALL s_aooi250_convert_qty(g_xmdl_d[g_detail_idx].xmdl008,l_imaf053,
                                                g_xmdl_d[g_detail_idx].xmdl017,l_sum_inao012)
                         RETURNING r_success,l_sum_inao012                      
                  END IF
               END IF               
               #add by lixh 20151022
               
               IF cl_null(l_sum_inao012) THEN LET l_sum_inao012 = 0 END IF
               IF l_sum_inao012 <> g_xmdl_d[g_detail_idx].xmdl081 THEN
                  IF cl_ask_confirm('ain-00249') THEN
                     LET g_xmdl_d[g_detail_idx].xmdl081 = l_sum_inao012
                     #換算參考數量
                     CALL s_aooi250_convert_qty(g_xmdl_d[g_detail_idx].xmdl008,g_xmdl_d[g_detail_idx].xmdl017,
                                                g_xmdl_d[g_detail_idx].xmdl019,g_xmdl_d[g_detail_idx].xmdl082)
                         RETURNING r_success,g_xmdl_d[g_detail_idx].xmdl082     
                         
                     UPDATE xmdl_t SET xmdl081 = g_xmdl_d[g_detail_idx].xmdl081,
                                       xmdl082 = g_xmdl_d[g_detail_idx].xmdl082
                      WHERE xmdlent = g_enterprise
                        AND xmdldocno = g_xmdk_m.xmdkdocno
                        AND xmdlseq = g_xmdl_d[g_detail_idx].xmdlseq
                        
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = 'foreach:' 
                        LET g_errparam.code   = SQLCA.sqlcode 
                        LET g_errparam.popup  = TRUE 
                        CALL cl_err()
                        LET r_success = FALSE
                     END IF                         
                  END IF
               END IF 
               
               IF r_success THEN
                  CALL s_transaction_end('Y','0')
               ELSE
               #回寫出貨單                     
                  CALL s_transaction_end('N','0')
               END IF
               EXIT DIALOG
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION axmt590_call_axmt540_01
            LET g_action_choice="axmt590_call_axmt540_01"
            IF cl_auth_chk_act("axmt590_call_axmt540_01") THEN
               
               #add-point:ON ACTION axmt590_call_axmt540_01 name="menu.detail_show.page1.axmt590_call_axmt540_01"

               CALL axmt590_call_axmt540_01()

               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION detail_qrystr
               MENU "" ATTRIBUTE(STYLE="popup")
                  #add-point:ON ACTION detail_qrystr相關動作 name="menu.detail_show.page1_sub.detail_qrystr"
                  BEFORE MENU
                     IF cl_null(g_xmdl_d[l_ac].xmdl001) THEN
                        HIDE OPTION "prog_axmt540"
                     END IF
                     IF cl_null(g_xmdl_d[l_ac].xmdl003) THEN
                        HIDE OPTION "prog_axmt500"
                     END IF
                     IF cl_null(g_xmdl_d[l_ac].xmdl001) AND cl_null(g_xmdl_d[l_ac].xmdl003) THEN
                        EXIT MENU
                     END IF
                  #END add-point
                                 #應用 a43 樣板自動產生(Version:4)
               ON ACTION prog_axmt540
                  LET g_action_choice="prog_axmt540"
                  IF cl_auth_chk_act("prog_axmt540") THEN
                     
                     #add-point:ON ACTION prog_axmt540 name="menu.detail_show.page1_sub.prog_axmt540"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               CALL axmt590_qrystr(g_xmdl_d[l_ac].xmdl001)               
                     #END add-point
                     
                  END IF
 
 
 
               #應用 a43 樣板自動產生(Version:4)
               ON ACTION prog_axmt500
                  LET g_action_choice="prog_axmt500"
                  IF cl_auth_chk_act("prog_axmt500") THEN
                     
                     #add-point:ON ACTION prog_axmt500 name="menu.detail_show.page1_sub.prog_axmt500"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               CALL axmt590_qrystr(g_xmdl_d[l_ac].xmdl003)
                     #END add-point
                     
                  END IF
 
 
 
 
               END MENU
 
 
 
               #add-point:ON ACTION detail_qrystr name="menu.detail_show.page1.detail_qrystr"
               
               #END add-point
 
 
 
 
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
                                                                                                            
            #end add-point
               
         END DISPLAY
        
         #第一階單身段落
         DISPLAY ARRAY g_xmdl3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL axmt590_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[2] = l_ac
               CALL g_idx_group.addAttribute("'2',",l_ac)
               
               #add-point:page2, before row動作 name="ui_dialog.body3.before_row"
               #add by lixh 20150915
               CALL axmt590_set_act_visible_b()
               CALL axmt590_set_act_no_visible_b()
               IF g_xmdl_d[g_detail_idx].xmdl013 = 'Y' THEN
                  #CALL cl_set_act_visible("s_lot_sel",FALSE)
                  CALL cl_set_act_visible("s_lot_sel",TRUE)    #add by lixh 20151208
               END IF
               CALL s_lot_b_fill('1',g_site,'2',g_xmdk_m.xmdkdocno,g_xmdl3_d[g_detail_idx].xmdmseq,g_xmdl3_d[g_detail_idx].xmdmseq1,'1')  
               #add by lixh 20150915                                                                                                                                       
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_current_page = 2
               #顯示單身筆數
               CALL axmt590_idx_chk()
               #add-point:page2自定義行為 name="ui_dialog.body3.before_display"
               CALL cl_set_act_visible("s_lot_sel",TRUE)   #add by lixh 20150915
               CALL axmt590_show()

               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION s_lot_sel
            LET g_action_choice="s_lot_sel"
            IF cl_auth_chk_act("s_lot_sel") THEN
               
               #add-point:ON ACTION s_lot_sel name="menu.detail_show.page2.s_lot_sel"
               IF cl_null(g_detail_idx) OR g_detail_idx = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'abm-00073'
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()               
                  EXIT DIALOG
               END IF
   
               IF NOT cl_null(g_xmdl3_d[g_detail_idx].xmdmseq) THEN               
                  LET l_success = ''
                  LET r_success = TRUE
                  CALL s_transaction_begin() 
                  LET l_cnt = 0
                  
                  SELECT xmdl001,xmdl002 INTO l_xmdl001,l_xmdl002 FROM xmdl_t
                   WHERE xmdlent = g_enterprise
                     AND xmdldocno = g_xmdk_m.xmdkdocno
                     AND xmdlseq = g_xmdl3_d[g_detail_idx].xmdmseq
                     
                  #複製出貨單批序號數量  
                  IF NOT s_axmt540_inao_copy_3(l_xmdl001,l_xmdl002,'2',g_xmdk_m.xmdkdocno,g_xmdl3_d[g_detail_idx].xmdmseq,g_xmdl3_d[g_detail_idx].xmdmseq1,g_xmdl3_d[g_detail_idx].xmdm007) THEN 
                     LET r_success = FALSE
                  END IF                  
                  
                  IF NOT r_success THEN
                     CALL s_transaction_end('N','0')
                     EXIT DIALOG
                  END IF   
                  
                  CALL s_lot_sel('2','2',g_site,g_xmdk_m.xmdkdocno,g_xmdl3_d[g_detail_idx].xmdmseq,g_xmdl3_d[g_detail_idx].xmdmseq1,g_xmdl3_d[g_detail_idx].xmdm001,g_xmdl3_d[g_detail_idx].xmdm002,g_xmdl3_d[g_detail_idx].xmdm033,g_xmdl3_d[g_detail_idx].xmdm005,
                                 g_xmdl3_d[g_detail_idx].xmdm006,g_xmdl3_d[g_detail_idx].xmdm007,g_xmdl3_d[g_detail_idx].xmdm008,g_xmdl3_d[g_detail_idx].xmdm031,'1','axmt590','','','','','0')
                       RETURNING l_success                                                
                  IF NOT l_success THEN 
                     LET r_success = FALSE
                  END IF  

                  #回寫出貨單(增加)
                  IF NOT s_axmt540_update_inao_3(g_xmdk_m.xmdkdocno,g_xmdl3_d[g_detail_idx].xmdmseq,g_xmdl3_d[g_detail_idx].xmdmseq1,g_xmdl3_d[g_detail_idx].xmdm007,l_xmdl001,l_xmdl002,'1') THEN
                     LET r_success = FALSE
                  END IF                                       
                  #刪除inao000 = '1' 的资料
                  DELETE FROM inao_t WHERE inaoent = g_enterprise
                                       AND inaodocno = g_xmdk_m.xmdkdocno
                                       AND inaoseq = g_xmdl3_d[g_detail_idx].xmdmseq
                                       AND inaoseq1 = g_xmdl3_d[g_detail_idx].xmdmseq1
                                       AND inao000 = '1' 
                                       AND inao013 = '1'       
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = 'foreach:' 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET r_success = FALSE
                  END IF                                        
               END IF

               SELECT SUM(inao012) INTO l_sum_inao012 FROM inao_t
                WHERE inaoent = g_enterprise
                  AND inaodocno = g_xmdk_m.xmdkdocno
                  AND inaoseq = g_xmdl3_d[g_detail_idx].xmdmseq
                  AND inaoseq1 = g_xmdl3_d[g_detail_idx].xmdmseq1
                  AND inao000 = '2' 
                  AND inao013 = '1'
                  
               IF cl_null(l_sum_inao012) THEN LET l_sum_inao012 = 0 END IF
               IF l_sum_inao012 <> g_xmdl3_d[g_detail_idx].xmdm031 THEN
                  IF cl_ask_confirm('ain-00249') THEN
                     LET g_xmdl3_d[g_detail_idx].xmdm031 = l_sum_inao012
                     #換算參考數量
                     CALL s_aooi250_convert_qty(g_xmdl3_d[g_detail_idx].xmdm008,g_xmdl3_d[g_detail_idx].xmdm031,
                                                g_xmdl3_d[g_detail_idx].xmdm010,g_xmdl3_d[g_detail_idx].xmdm032)
                         RETURNING r_success,g_xmdl3_d[g_detail_idx].xmdm032     
                         
                     UPDATE xmdm_t SET xmdm031 = g_xmdl3_d[g_detail_idx].xmdm031,
                                       xmdm032 = g_xmdl3_d[g_detail_idx].xmdm032
                      WHERE xmdment = g_enterprise
                        AND xmdmdocno = g_xmdk_m.xmdkdocno
                        AND xmdmseq = g_xmdl3_d[g_detail_idx].xmdmseq
                        AND xmdmseq1 = g_xmdl3_d[g_detail_idx].xmdmseq1
                        
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = 'foreach:' 
                        LET g_errparam.code   = SQLCA.sqlcode 
                        LET g_errparam.popup  = TRUE 
                        CALL cl_err()
                        LET r_success = FALSE
                     END IF                         
                  END IF
               END IF 
               
               IF r_success THEN
                  CALL s_transaction_end('Y','0')
               ELSE
               #回寫出貨單                     
                  CALL s_transaction_end('N','0')
               END IF
               EXIT DIALOG
               #END add-point
               
            END IF
 
 
 
 
         
            #add-point:page2自定義行為 name="ui_dialog.body3.action"
                                                                                                            
            #end add-point
         
         END DISPLAY
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         SUBDIALOG sub_s_lot.s_lot_display      #add by lixh 20150915   
         SUBDIALOG aoo_aooi360_01.aooi360_01_display     #161031-00025#28 add          
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
      
         BEFORE DIALOG
            #先填充browser資料
            CALL axmt590_browser_fill("")
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
               CALL axmt590_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL axmt590_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL axmt590_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #150721-00001#1  2016/01/08 By earl mod s
            CALL axmt590_set_act_visible()
            CALL axmt590_set_act_no_visible()
            
            #CALL cl_set_act_visible("insert,delete,reproduce", FALSE)
            #150721-00001#1  2016/01/08 By earl mod e
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         #161031-00025#28-s
         ON ACTION remarks_page
            LET g_detail_id = "remarks_page"
            NEXT FIELD ooff012
         #161031-00025#28-e
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL axmt590_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL axmt590_set_act_visible()   
            CALL axmt590_set_act_no_visible()
            IF NOT (g_xmdk_m.xmdkdocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " xmdkent = " ||g_enterprise|| " AND",
                                  " xmdkdocno = '", g_xmdk_m.xmdkdocno, "' "
 
               #填到對應位置
               CALL axmt590_browser_fill("")
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
                     WHEN la_wc[li_idx].tableid = "xmdk_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "xmdl_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "xmdm_t" 
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
               CALL axmt590_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                     WHEN la_wc[li_idx].tableid = "xmdk_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "xmdl_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "xmdm_t" 
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
                  CALL axmt590_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL axmt590_fetch("F")
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
               CALL axmt590_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL axmt590_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axmt590_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL axmt590_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axmt590_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL axmt590_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axmt590_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL axmt590_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axmt590_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL axmt590_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axmt590_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_xmdl_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_xmdl3_d)
                  LET g_export_id[2]   = "s_detail3"
 
                  #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
                  #161031-00025#28-s
                  LET g_export_node[3] = base.typeInfo.create(g_ooff_d4)
                  LET g_export_id[3]   = "s_detail1_aooi360_01"
                  #161031-00025#28-e
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
               NEXT FIELD xmdlseq
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
               CALL axmt590_modify()
               #add-point:ON ACTION modify name="menu.modify"

               LET g_aw = "s_detail1"   #直接進單身
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL axmt590_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
                                                                                                                                       
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION axmt590_change_warehouse
            LET g_action_choice="axmt590_change_warehouse"
            IF cl_auth_chk_act("axmt590_change_warehouse") THEN
               
               #add-point:ON ACTION axmt590_change_warehouse name="menu.axmt590_change_warehouse"
               
               CALL s_transaction_begin()
               IF NOT axmt590_change_warehouse(g_xmdk_m.xmdkdocno) THEN
                  CALL s_transaction_end('N','0') 
               ELSE
                  CALL s_transaction_end('Y','0') 
               END IF
               
               CALL axmt590_show()
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL axmt590_delete()
               #add-point:ON ACTION delete name="menu.delete"
                                                                                                                                       
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL axmt590_insert()
               #add-point:ON ACTION insert name="menu.insert"
                                                                                                                                       
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_memo
            LET g_action_choice="open_memo"
            IF cl_auth_chk_act("open_memo") THEN
               
               #add-point:ON ACTION open_memo name="menu.open_memo"
               
               #CALL aooi360_02('6',g_prog,g_xmdk_m.xmdkdocno,'','','','','','','','','4')
               #161031-00025#28-s
               IF NOT cl_null(g_xmdk_m.xmdkdocno) THEN
                  CALL axmt590_remaks()
               END IF
               #161031-00025#28-e
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION axmt590_create_qc
            LET g_action_choice="axmt590_create_qc"
            IF cl_auth_chk_act("axmt590_create_qc") THEN
               
               #add-point:ON ACTION axmt590_create_qc name="menu.axmt590_create_qc"
               #產生RQC 

               CALL s_transaction_begin()

               CALL s_axmt590_create_qc(g_xmdk_m.xmdkdocno) RETURNING l_success

               IF l_success THEN
                  CALL s_transaction_end('Y','0')
                  CALL cl_ask_confirm3('ain-00399','')   #QC單產生成功！  
               ELSE
                  CALL s_transaction_end('N','0')
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               LET g_rep_wc = "xmdkent ="|| g_enterprise ||"  AND xmdkdocno ='"|| g_xmdk_m.xmdkdocno||"'"   #170111-00020#1 add                                                                                                                                       
               #END add-point
               &include "erp/axm/axmt590_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
 
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               LET g_rep_wc = "xmdkent ="|| g_enterprise ||"  AND xmdkdocno ='"|| g_xmdk_m.xmdkdocno||"'"   #170111-00020#1 add                                                                                                   
               #END add-point
               &include "erp/axm/axmt590_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
 
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL axmt590_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
                                                                                                                                       
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL axmt590_query()
               #add-point:ON ACTION query name="menu.query"
                                                                                                                                       
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail3",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_xmdk003
            LET g_action_choice="prog_xmdk003"
            IF cl_auth_chk_act("prog_xmdk003") THEN
               
               #add-point:ON ACTION prog_xmdk003 name="menu.prog_xmdk003"
               CALL cl_user_contact("aooi130", "ooag_t", "ooag002", "ooag001",g_xmdk_m.xmdk003)
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_xmdk081
            LET g_action_choice="prog_xmdk081"
            IF cl_auth_chk_act("prog_xmdk081") THEN
               
               #add-point:ON ACTION prog_xmdk081 name="menu.prog_xmdk081"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               CALL axmt590_qrystr(g_xmdk_m.xmdk081)
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_xmdk005
            LET g_action_choice="prog_xmdk005"
            IF cl_auth_chk_act("prog_xmdk005") THEN
               
               #add-point:ON ACTION prog_xmdk005 name="menu.prog_xmdk005"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               CALL axmt590_qrystr(g_xmdk_m.xmdk005)
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_xmdk006
            LET g_action_choice="prog_xmdk006"
            IF cl_auth_chk_act("prog_xmdk006") THEN
               
               #add-point:ON ACTION prog_xmdk006 name="menu.prog_xmdk006"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               CALL axmt590_qrystr(g_xmdk_m.xmdk006)
               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL axmt590_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL axmt590_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL axmt590_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_xmdk_m.xmdkdocdt)
 
 
 
         
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
 
{<section id="axmt590.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION axmt590_browser_fill(ps_page_action)
   #add-point:browser_fill段define(客製用) name="browser_fill.define_customerization"
   
   #end add-point  
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   DEFINE l_pmak003  LIKE pmak_t.pmak003   #一次性交易對象名稱   #161207-00033#18 add                            
   #end add-point    
   
   #add-point:Function前置處理 name="browser_fill.before_browser_fill"
   #161031-00025#28-s
   IF cl_null(g_add_browse) THEN
      CALL aooi360_01_clear_detail()   #清除备注单身
   END IF
   #161031-00025#28-e
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

   CASE g_argv[01]
      WHEN '0'     #出貨簽退單  
         LET l_wc = l_wc, " AND xmdksite = '",g_site,"'",
                          " AND xmdk000 = '5'"
      WHEN '1'     #借貨還量單  
         LET l_wc = l_wc, " AND xmdksite = '",g_site,"'",
                          " AND xmdk000 = '8'"
      OTHERWISE    #預設 出貨簽退單  
         LET l_wc = l_wc, " AND xmdksite = '",g_site,"'",
                          " AND xmdk000 = '5'"
   END CASE
   #160510-00043#2--(S)
   IF NOT cl_null(g_slip_wc) THEN
      LET l_wc = l_wc," AND ",g_slip_wc
   END IF   
   #160510-00043#2--(E)
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT xmdkdocno ",
                      " FROM xmdk_t ",
                      " ",
                      " LEFT JOIN xmdl_t ON xmdlent = xmdkent AND xmdkdocno = xmdldocno ", "  ",
                      #add-point:browser_fill段sql(xmdl_t1) name="browser_fill.cnt.join.}"
                      " LEFT JOIN xmda_t ON xmdaent = xmdkent AND xmdadocno = xmdl003 ",      #150120新增"客戶訂單號碼"  earl
                      #end add-point
                      " LEFT JOIN xmdm_t ON xmdment = xmdkent AND xmdkdocno = xmdmdocno", "  ",
                      #add-point:browser_fill段sql(xmdm_t1) name="browser_fill.cnt.join.xmdm_t1"
                      " AND xmdmseq = xmdlseq ",
                      " LEFT JOIN ooff_t ON ooffent = xmdkent AND ooff001 = '7' 
                        AND ooff002 = '",g_prog,"' AND xmdkdocno = ooff003  AND ooff004 = xmdlseq ",  "  ",   #161031-00025#28 add
                      #end add-point
 
 
 
                      " ", 
                      " ", 
                      " ",                      
 
 
 
                      " WHERE xmdkent = " ||g_enterprise|| " AND xmdlent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("xmdk_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT xmdkdocno ",
                      " FROM xmdk_t ", 
                      "  ",
                      "  ",
                      " WHERE xmdkent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("xmdk_t")
   END IF
   
   #add-point:browser_fill,cnt wc name="browser_fill.cnt_sqlwc"
   #161031-00025#28-s
   IF NOT cl_null(g_wc2_i36001) AND g_wc2_i36001 <> " 1=1" THEN
      LET l_sub_sql = l_sub_sql CLIPPED, " AND EXISTS (SELECT ooff003 FROM ooff_t 
                                                        WHERE ooffent = ",g_enterprise," AND ooff001 = '6' 
                                                          AND ooff002 = '",g_prog,"' AND ooff003 = xmdkdocno
                                                          AND ooff004 = '0' AND ",g_wc2_i36001 CLIPPED ,")" 
   END IF                                                    
   #161031-00025#28-e
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
      INITIALIZE g_xmdk_m.* TO NULL
      CALL g_xmdl_d.clear()        
      CALL g_xmdl3_d.clear() 
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.xmdkdocno,t0.xmdk001,t0.xmdk003,t0.xmdk004,t0.xmdk006,t0.xmdk007,t0.xmdk008,t0.xmdk009 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.xmdkstus,t0.xmdkdocno,t0.xmdk001,t0.xmdk003,t0.xmdk004,t0.xmdk006, 
          t0.xmdk007,t0.xmdk008,t0.xmdk009,t1.ooag011 ,t2.ooefl003 ,t3.pmaal004 ,t4.pmaal004 ,t5.pmaal004 ", 
 
                  " FROM xmdk_t t0",
                  "  ",
                  "  LEFT JOIN xmdl_t ON xmdlent = xmdkent AND xmdkdocno = xmdldocno ", "  ", 
                  #add-point:browser_fill段sql(xmdl_t1) name="browser_fill.join.xmdl_t1"
               "  LEFT JOIN xmda_t ON xmdaent = xmdkent AND xmdadocno = xmdl003 ",      #150120新增"客戶訂單號碼"  earl
                  #end add-point
                  "  LEFT JOIN xmdm_t ON xmdment = xmdkent AND xmdkdocno = xmdmdocno", "  ", 
                  #add-point:browser_fill段sql(xmdm_t1) name="browser_fill.join.xmdm_t1"
               " AND xmdmseq = xmdlseq ",
               " LEFT JOIN ooff_t ON ooffent = xmdkent AND ooff001 = '7' 
                 AND ooff002 = '",g_prog,"' AND xmdkdocno = ooff003  AND ooff004 = xmdlseq ",  "  ",   #161031-00025#28 add               
                  #end add-point
 
 
 
                  " ", 
                  " ",                      
 
 
 
                                 " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.xmdk003  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.xmdk004 AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t3 ON t3.pmaalent="||g_enterprise||" AND t3.pmaal001=t0.xmdk007 AND t3.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t4 ON t4.pmaalent="||g_enterprise||" AND t4.pmaal001=t0.xmdk008 AND t4.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t5 ON t5.pmaalent="||g_enterprise||" AND t5.pmaal001=t0.xmdk009 AND t5.pmaal002='"||g_dlang||"' ",
 
                  " WHERE t0.xmdkent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("xmdk_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.xmdkstus,t0.xmdkdocno,t0.xmdk001,t0.xmdk003,t0.xmdk004,t0.xmdk006, 
          t0.xmdk007,t0.xmdk008,t0.xmdk009,t1.ooag011 ,t2.ooefl003 ,t3.pmaal004 ,t4.pmaal004 ,t5.pmaal004 ", 
 
                  " FROM xmdk_t t0",
                  "  ",
                                 " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.xmdk003  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.xmdk004 AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t3 ON t3.pmaalent="||g_enterprise||" AND t3.pmaal001=t0.xmdk007 AND t3.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t4 ON t4.pmaalent="||g_enterprise||" AND t4.pmaal001=t0.xmdk008 AND t4.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t5 ON t5.pmaalent="||g_enterprise||" AND t5.pmaal001=t0.xmdk009 AND t5.pmaal002='"||g_dlang||"' ",
 
                  " WHERE t0.xmdkent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("xmdk_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   #161031-00025#28-s
   IF NOT cl_null(g_wc2_i36001) AND g_wc2_i36001 <> " 1=1" THEN
      LET g_sql = g_sql CLIPPED, " AND EXISTS (SELECT ooff003 FROM ooff_t 
                                                        WHERE ooffent = ",g_enterprise," AND ooff001 = '6' 
                                                          AND ooff002 = '",g_prog,"' AND ooff003 = xmdkdocno
                                                          AND ooff004 = '0' AND ",g_wc2_i36001 CLIPPED ,")" 
   END IF                                                    
   #161031-00025#28-e
   #end add-point
   LET g_sql = g_sql, " ORDER BY xmdkdocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
                           
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"xmdk_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
                           
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_xmdkdocno,g_browser[g_cnt].b_xmdk001, 
          g_browser[g_cnt].b_xmdk003,g_browser[g_cnt].b_xmdk004,g_browser[g_cnt].b_xmdk006,g_browser[g_cnt].b_xmdk007, 
          g_browser[g_cnt].b_xmdk008,g_browser[g_cnt].b_xmdk009,g_browser[g_cnt].b_xmdk003_desc,g_browser[g_cnt].b_xmdk004_desc, 
          g_browser[g_cnt].b_xmdk007_desc,g_browser[g_cnt].b_xmdk008_desc,g_browser[g_cnt].b_xmdk009_desc 
 
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "Foreach:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
      
         #add-point:browser_fill段reference name="browser_fill.reference"
         #161207-00033#18-s add
         #一次性交易對象全名
         CALL s_desc_axm_get_oneturn_guest_desc('4',g_browser[g_cnt].b_xmdkdocno)
              RETURNING l_pmak003
         
         IF NOT cl_null(l_pmak003) THEN
            LET g_browser[g_cnt].b_xmdk007_desc = l_pmak003
            IF g_browser[g_cnt].b_xmdk008 = g_browser[g_cnt].b_xmdk007 THEN   #帳款客戶
               LET g_browser[g_cnt].b_xmdk008_desc = g_browser[g_cnt].b_xmdk007_desc
            END IF
            IF g_browser[g_cnt].b_xmdk009 = g_browser[g_cnt].b_xmdk007 THEN   #收貨客戶
               LET g_browser[g_cnt].b_xmdk009_desc = g_browser[g_cnt].b_xmdk007_desc
            END IF
         END IF
         #161207-00033#18-e add                                                               
         #end add-point
      
         #遮罩相關處理
         CALL axmt590_browser_mask()
      
               #應用 a24 樣板自動產生(Version:3)
      #browser顯示圖片
      CASE g_browser[g_cnt].b_statepic
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/unconfirmed.png"
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/confirmed.png"
         WHEN "S"
            LET g_browser[g_cnt].b_statepic = "stus/16/posted.png"
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
   
   IF cl_null(g_browser[g_cnt].b_xmdkdocno) THEN
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
 
{<section id="axmt590.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION axmt590_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
                           
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_xmdk_m.xmdkdocno = g_browser[g_current_idx].b_xmdkdocno   
 
   EXECUTE axmt590_master_referesh USING g_xmdk_m.xmdkdocno INTO g_xmdk_m.xmdk000,g_xmdk_m.xmdksite, 
       g_xmdk_m.xmdkdocno,g_xmdk_m.xmdkdocdt,g_xmdk_m.xmdk001,g_xmdk_m.xmdk003,g_xmdk_m.xmdk004,g_xmdk_m.xmdkstus, 
       g_xmdk_m.xmdk081,g_xmdk_m.xmdk005,g_xmdk_m.xmdk006,g_xmdk_m.xmdk002,g_xmdk_m.xmdk007,g_xmdk_m.xmdk009, 
       g_xmdk_m.xmdk008,g_xmdk_m.xmdkownid,g_xmdk_m.xmdkowndp,g_xmdk_m.xmdkcrtid,g_xmdk_m.xmdkcrtdp, 
       g_xmdk_m.xmdkcrtdt,g_xmdk_m.xmdkmodid,g_xmdk_m.xmdkmoddt,g_xmdk_m.xmdkcnfid,g_xmdk_m.xmdkcnfdt, 
       g_xmdk_m.xmdkpstid,g_xmdk_m.xmdkpstdt,g_xmdk_m.xmdk003_desc,g_xmdk_m.xmdk004_desc,g_xmdk_m.xmdk007_desc, 
       g_xmdk_m.xmdk009_desc,g_xmdk_m.xmdk008_desc,g_xmdk_m.xmdkownid_desc,g_xmdk_m.xmdkowndp_desc,g_xmdk_m.xmdkcrtid_desc, 
       g_xmdk_m.xmdkcrtdp_desc,g_xmdk_m.xmdkmodid_desc,g_xmdk_m.xmdkcnfid_desc,g_xmdk_m.xmdkpstid_desc 
 
   
   CALL axmt590_xmdk_t_mask()
   CALL axmt590_show()
      
END FUNCTION
 
{</section>}
 
{<section id="axmt590.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION axmt590_ui_detailshow()
   #add-point:ui_detailshow段define(客製用) name="ui_detailshow.define_customerization"
   
   #end add-point    
   #add-point:ui_detailshow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_detailshow.define"
                           
   #end add-point    
 
   #add-point:Function前置處理 name="ui_detailshow.before"
                           
   #end add-point    
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
      CALL g_curr_diag.setCurrentRow("s_detail3",g_detail_idx)
 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
                           
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="axmt590.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION axmt590_ui_browser_refresh()
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
      IF g_browser[l_i].b_xmdkdocno = g_xmdk_m.xmdkdocno 
 
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
 
{<section id="axmt590.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION axmt590_construct()
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
   DEFINE l_form_wc   STRING    #150120新增"客戶訂單號碼"  earl
   #end add-point    
   
   #add-point:Function前置處理  name="cs.pre_function"
   CALL aooi360_01_clear_detail()   #清除备注单身  #161031-00025#28
   #end add-point
    
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_xmdk_m.* TO NULL
   CALL g_xmdl_d.clear()        
   CALL g_xmdl3_d.clear() 
 
   
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
      CONSTRUCT BY NAME g_wc ON xmdk000,xmdksite,xmdkdocno,xmdkdocdt,xmdk001,xmdk003,xmdk004,xmdkstus, 
          xmdk081,xmdk005,xmdk006,xmdk002,xmdk007,xmdk009,xmdk008,xmdkownid,xmdkowndp,xmdkcrtid,xmdkcrtdp, 
          xmdkcrtdt,xmdkmodid,xmdkmoddt,xmdkcnfid,xmdkcnfdt,xmdkpstid,xmdkpstdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
                                                                                                            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<xmdkcrtdt>>----
         AFTER FIELD xmdkcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<xmdkmoddt>>----
         AFTER FIELD xmdkmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<xmdkcnfdt>>----
         AFTER FIELD xmdkcnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<xmdkpstdt>>----
         AFTER FIELD xmdkpstdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
 
 
            
         #一般欄位開窗相關處理    
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdk000
            #add-point:BEFORE FIELD xmdk000 name="construct.b.xmdk000"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdk000
            
            #add-point:AFTER FIELD xmdk000 name="construct.a.xmdk000"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdk000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdk000
            #add-point:ON ACTION controlp INFIELD xmdk000 name="construct.c.xmdk000"
                                                                                                            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdksite
            #add-point:BEFORE FIELD xmdksite name="construct.b.xmdksite"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdksite
            
            #add-point:AFTER FIELD xmdksite name="construct.a.xmdksite"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdksite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdksite
            #add-point:ON ACTION controlp INFIELD xmdksite name="construct.c.xmdksite"
                                                                                                            
            #END add-point
 
 
         #Ctrlp:construct.c.xmdkdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdkdocno
            #add-point:ON ACTION controlp INFIELD xmdkdocno name="construct.c.xmdkdocno"
            
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            
            CASE g_argv[01]
               WHEN '0'
                  LET g_qryparam.arg1 = '5'     #出貨簽退單  
               WHEN '1'
                  LET g_qryparam.arg1 = '8'     #借貨還量單  
               OTHERWISE     #預設 出貨簽退單  
                  LET g_qryparam.arg1 = '5'     #出貨簽退單  
            END CASE 
            #160510-00043#2--(S)
            IF NOT cl_null(g_slip_wc) THEN
               LET g_qryparam.where = g_slip_wc
            END IF   
            #160510-00043#2--(E)
            CALL q_xmdkdocno_2()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdkdocno  #顯示到畫面上

            NEXT FIELD xmdkdocno                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdkdocno
            #add-point:BEFORE FIELD xmdkdocno name="construct.b.xmdkdocno"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdkdocno
            
            #add-point:AFTER FIELD xmdkdocno name="construct.a.xmdkdocno"
                                                                                                            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdkdocdt
            #add-point:BEFORE FIELD xmdkdocdt name="construct.b.xmdkdocdt"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdkdocdt
            
            #add-point:AFTER FIELD xmdkdocdt name="construct.a.xmdkdocdt"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdkdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdkdocdt
            #add-point:ON ACTION controlp INFIELD xmdkdocdt name="construct.c.xmdkdocdt"
                                                                                                            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdk001
            #add-point:BEFORE FIELD xmdk001 name="construct.b.xmdk001"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdk001
            
            #add-point:AFTER FIELD xmdk001 name="construct.a.xmdk001"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdk001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdk001
            #add-point:ON ACTION controlp INFIELD xmdk001 name="construct.c.xmdk001"
                                                                                                            
            #END add-point
 
 
         #Ctrlp:construct.c.xmdk003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdk003
            #add-point:ON ACTION controlp INFIELD xmdk003 name="construct.c.xmdk003"
            
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdk003  #顯示到畫面上

            NEXT FIELD xmdk003                     #返回原欄位

            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdk003
            #add-point:BEFORE FIELD xmdk003 name="construct.b.xmdk003"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdk003
            
            #add-point:AFTER FIELD xmdk003 name="construct.a.xmdk003"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdk004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdk004
            #add-point:ON ACTION controlp INFIELD xmdk004 name="construct.c.xmdk004"
            
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdk004  #顯示到畫面上

            NEXT FIELD xmdk004                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdk004
            #add-point:BEFORE FIELD xmdk004 name="construct.b.xmdk004"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdk004
            
            #add-point:AFTER FIELD xmdk004 name="construct.a.xmdk004"
                                                                                                            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdkstus
            #add-point:BEFORE FIELD xmdkstus name="construct.b.xmdkstus"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdkstus
            
            #add-point:AFTER FIELD xmdkstus name="construct.a.xmdkstus"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdkstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdkstus
            #add-point:ON ACTION controlp INFIELD xmdkstus name="construct.c.xmdkstus"
                                                                                                            
            #END add-point
 
 
         #Ctrlp:construct.c.xmdk081
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdk081
            #add-point:ON ACTION controlp INFIELD xmdk081 name="construct.c.xmdk081"

            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            
            CASE g_argv[01]
               WHEN '0'
                  LET g_qryparam.arg1 = '4'     #簽收單 
               WHEN '1'
                  LET g_qryparam.arg1 = '7'     #借貨還價單 
               OTHERWISE     #預設 簽收單  
                  LET g_qryparam.arg1 = '4'     #簽收單 
            END CASE
            
            CALL q_xmdkdocno_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdk081  #顯示到畫面上
            NEXT FIELD xmdk081                     #返回原欄位
    

            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdk081
            #add-point:BEFORE FIELD xmdk081 name="construct.b.xmdk081"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdk081
            
            #add-point:AFTER FIELD xmdk081 name="construct.a.xmdk081"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdk005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdk005
            #add-point:ON ACTION controlp INFIELD xmdk005 name="construct.c.xmdk005"
            
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE

            CASE g_argv[01]
               WHEN '0'     #簽收訂單  
                  LET g_qryparam.where = "xmdk002 = '3' "
               WHEN '1'     #借貨訂單  
                  LET g_qryparam.where = "xmdk002 = '8' "
               OTHERWISE    #預設 簽收訂單  
                  LET g_qryparam.where = "xmdk002 = '3' "
            END CASE 

            CALL q_xmdkdocno_3()                       #呼叫開窗
            
            DISPLAY g_qryparam.return1 TO xmdk005  #顯示到畫面上

            NEXT FIELD xmdk005                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdk005
            #add-point:BEFORE FIELD xmdk005 name="construct.b.xmdk005"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdk005
            
            #add-point:AFTER FIELD xmdk005 name="construct.a.xmdk005"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdk006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdk006
            #add-point:ON ACTION controlp INFIELD xmdk006 name="construct.c.xmdk006"
            
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE 
            #如果是簽退單，則不需看見借貨訂單 
            #如果是還量單，則只需看借貨訂單的資料 
            CASE g_argv[01]
               WHEN '0'
                  LET g_qryparam.where = " xmda005 <> '8' "
               WHEN '1' 
                  LET g_qryparam.where = " xmda005 = '8' " 

               OTHERWISE 
                  LET g_qryparam.where = " xmda005 <> '8' "

            END CASE 
            CALL q_xmdadocno_2()                   #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdk006  #顯示到畫面上

            NEXT FIELD xmdk006                     #返回原欄位
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdk006
            #add-point:BEFORE FIELD xmdk006 name="construct.b.xmdk006"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdk006
            
            #add-point:AFTER FIELD xmdk006 name="construct.a.xmdk006"
                                                                                                            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdk002
            #add-point:BEFORE FIELD xmdk002 name="construct.b.xmdk002"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdk002
            
            #add-point:AFTER FIELD xmdk002 name="construct.a.xmdk002"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdk002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdk002
            #add-point:ON ACTION controlp INFIELD xmdk002 name="construct.c.xmdk002"
                                                                                                            
            #END add-point
 
 
         #Ctrlp:construct.c.xmdk007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdk007
            #add-point:ON ACTION controlp INFIELD xmdk007 name="construct.c.xmdk007"
            
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.arg1 = g_site

            CALL q_pmaa001_6()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdk007  #顯示到畫面上

            NEXT FIELD xmdk007                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdk007
            #add-point:BEFORE FIELD xmdk007 name="construct.b.xmdk007"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdk007
            
            #add-point:AFTER FIELD xmdk007 name="construct.a.xmdk007"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdk009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdk009
            #add-point:ON ACTION controlp INFIELD xmdk009 name="construct.c.xmdk009"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.arg2 = g_site

            CALL q_pmac002_6()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdk009  #顯示到畫面上

            NEXT FIELD xmdk009                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdk009
            #add-point:BEFORE FIELD xmdk009 name="construct.b.xmdk009"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdk009
            
            #add-point:AFTER FIELD xmdk009 name="construct.a.xmdk009"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdk008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdk008
            #add-point:ON ACTION controlp INFIELD xmdk008 name="construct.c.xmdk008"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.arg2 = g_site

            CALL q_pmac002_5()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdk008  #顯示到畫面上

            NEXT FIELD xmdk008                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdk008
            #add-point:BEFORE FIELD xmdk008 name="construct.b.xmdk008"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdk008
            
            #add-point:AFTER FIELD xmdk008 name="construct.a.xmdk008"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdkownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdkownid
            #add-point:ON ACTION controlp INFIELD xmdkownid name="construct.c.xmdkownid"
           
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdkownid  #顯示到畫面上

            NEXT FIELD xmdkownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdkownid
            #add-point:BEFORE FIELD xmdkownid name="construct.b.xmdkownid"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdkownid
            
            #add-point:AFTER FIELD xmdkownid name="construct.a.xmdkownid"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdkowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdkowndp
            #add-point:ON ACTION controlp INFIELD xmdkowndp name="construct.c.xmdkowndp"
            
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdkowndp  #顯示到畫面上

            NEXT FIELD xmdkowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdkowndp
            #add-point:BEFORE FIELD xmdkowndp name="construct.b.xmdkowndp"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdkowndp
            
            #add-point:AFTER FIELD xmdkowndp name="construct.a.xmdkowndp"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdkcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdkcrtid
            #add-point:ON ACTION controlp INFIELD xmdkcrtid name="construct.c.xmdkcrtid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdkcrtid  #顯示到畫面上

            NEXT FIELD xmdkcrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdkcrtid
            #add-point:BEFORE FIELD xmdkcrtid name="construct.b.xmdkcrtid"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdkcrtid
            
            #add-point:AFTER FIELD xmdkcrtid name="construct.a.xmdkcrtid"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdkcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdkcrtdp
            #add-point:ON ACTION controlp INFIELD xmdkcrtdp name="construct.c.xmdkcrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdkcrtdp  #顯示到畫面上

            NEXT FIELD xmdkcrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdkcrtdp
            #add-point:BEFORE FIELD xmdkcrtdp name="construct.b.xmdkcrtdp"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdkcrtdp
            
            #add-point:AFTER FIELD xmdkcrtdp name="construct.a.xmdkcrtdp"
                                                                                                            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdkcrtdt
            #add-point:BEFORE FIELD xmdkcrtdt name="construct.b.xmdkcrtdt"
                                                                                                            
            #END add-point
 
 
         #Ctrlp:construct.c.xmdkmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdkmodid
            #add-point:ON ACTION controlp INFIELD xmdkmodid name="construct.c.xmdkmodid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdkmodid  #顯示到畫面上

            NEXT FIELD xmdkmodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdkmodid
            #add-point:BEFORE FIELD xmdkmodid name="construct.b.xmdkmodid"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdkmodid
            
            #add-point:AFTER FIELD xmdkmodid name="construct.a.xmdkmodid"
                                                                                                            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdkmoddt
            #add-point:BEFORE FIELD xmdkmoddt name="construct.b.xmdkmoddt"
                                                                                                            
            #END add-point
 
 
         #Ctrlp:construct.c.xmdkcnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdkcnfid
            #add-point:ON ACTION controlp INFIELD xmdkcnfid name="construct.c.xmdkcnfid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdkcnfid  #顯示到畫面上

            NEXT FIELD xmdkcnfid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdkcnfid
            #add-point:BEFORE FIELD xmdkcnfid name="construct.b.xmdkcnfid"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdkcnfid
            
            #add-point:AFTER FIELD xmdkcnfid name="construct.a.xmdkcnfid"
                                                                                                            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdkcnfdt
            #add-point:BEFORE FIELD xmdkcnfdt name="construct.b.xmdkcnfdt"
                                                                                                            
            #END add-point
 
 
         #Ctrlp:construct.c.xmdkpstid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdkpstid
            #add-point:ON ACTION controlp INFIELD xmdkpstid name="construct.c.xmdkpstid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdkpstid  #顯示到畫面上

            NEXT FIELD xmdkpstid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdkpstid
            #add-point:BEFORE FIELD xmdkpstid name="construct.b.xmdkpstid"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdkpstid
            
            #add-point:AFTER FIELD xmdkpstid name="construct.a.xmdkpstid"
                                                                                                            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdkpstdt
            #add-point:BEFORE FIELD xmdkpstdt name="construct.b.xmdkpstdt"
                                                                                                            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON xmdlsite,xmdlseq,xmdl001,xmdl002,xmdl003,xmdl004,xmdl005,xmdl006,xmdl007, 
          xmdl008,xmdl009,xmdl009_desc,xmdl033,xmdl011,xmdl012,xmdl017,xmdl092,xmdl018,xmdl081,xmdl019, 
          xmdl093,xmdl020,xmdl082,xmdl084,xmdl084_desc,xmdl010,xmdl013,xmdl014,xmdl015,xmdl016,xmdl052, 
          xmdl021,xmdl022,xmdl083,xmdl030,xmdl031,xmdl032,xmdl051,xmdl089,xmdl090,xmdl091,ooff013
           FROM s_detail1[1].xmdlsite,s_detail1[1].xmdlseq,s_detail1[1].xmdl001,s_detail1[1].xmdl002, 
               s_detail1[1].xmdl003,s_detail1[1].xmdl004,s_detail1[1].xmdl005,s_detail1[1].xmdl006,s_detail1[1].xmdl007, 
               s_detail1[1].xmdl008,s_detail1[1].xmdl009,s_detail1[1].xmdl009_desc,s_detail1[1].xmdl033, 
               s_detail1[1].xmdl011,s_detail1[1].xmdl012,s_detail1[1].xmdl017,s_detail1[1].xmdl092,s_detail1[1].xmdl018, 
               s_detail1[1].xmdl081,s_detail1[1].xmdl019,s_detail1[1].xmdl093,s_detail1[1].xmdl020,s_detail1[1].xmdl082, 
               s_detail1[1].xmdl084,s_detail1[1].xmdl084_desc,s_detail1[1].xmdl010,s_detail1[1].xmdl013, 
               s_detail1[1].xmdl014,s_detail1[1].xmdl015,s_detail1[1].xmdl016,s_detail1[1].xmdl052,s_detail1[1].xmdl021, 
               s_detail1[1].xmdl022,s_detail1[1].xmdl083,s_detail1[1].xmdl030,s_detail1[1].xmdl031,s_detail1[1].xmdl032, 
               s_detail1[1].xmdl051,s_detail1[1].xmdl089,s_detail1[1].xmdl090,s_detail1[1].xmdl091,s_detail1[1].ooff013 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
                                                                                                            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdlsite
            #add-point:BEFORE FIELD xmdlsite name="construct.b.page1.xmdlsite"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdlsite
            
            #add-point:AFTER FIELD xmdlsite name="construct.a.page1.xmdlsite"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmdlsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdlsite
            #add-point:ON ACTION controlp INFIELD xmdlsite name="construct.c.page1.xmdlsite"
                                                                                                            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdlseq
            #add-point:BEFORE FIELD xmdlseq name="construct.b.page1.xmdlseq"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdlseq
            
            #add-point:AFTER FIELD xmdlseq name="construct.a.page1.xmdlseq"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmdlseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdlseq
            #add-point:ON ACTION controlp INFIELD xmdlseq name="construct.c.page1.xmdlseq"
                                                                                                            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.xmdl001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdl001
            #add-point:ON ACTION controlp INFIELD xmdl001 name="construct.c.page1.xmdl001"
            
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE

            CASE g_argv[01]
               WHEN '0'     #簽收訂單  
                  LET g_qryparam.where = "xmdk002 = '3' "
               WHEN '1'     #借貨訂單  
                  LET g_qryparam.where = "xmdk002 = '8' "
               OTHERWISE    #預設 簽收訂單  
                  LET g_qryparam.where = "xmdk002 = '3' "
            END CASE

            CALL q_xmdkdocno_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdl001  #顯示到畫面上

            NEXT FIELD xmdl001                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdl001
            #add-point:BEFORE FIELD xmdl001 name="construct.b.page1.xmdl001"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdl001
            
            #add-point:AFTER FIELD xmdl001 name="construct.a.page1.xmdl001"
                                                                                                            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdl002
            #add-point:BEFORE FIELD xmdl002 name="construct.b.page1.xmdl002"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdl002
            
            #add-point:AFTER FIELD xmdl002 name="construct.a.page1.xmdl002"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmdl002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdl002
            #add-point:ON ACTION controlp INFIELD xmdl002 name="construct.c.page1.xmdl002"
                                                                                                            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.xmdl003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdl003
            #add-point:ON ACTION controlp INFIELD xmdl003 name="construct.c.page1.xmdl003"
            
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xmdadocno_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdl003  #顯示到畫面上

            NEXT FIELD xmdl003                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdl003
            #add-point:BEFORE FIELD xmdl003 name="construct.b.page1.xmdl003"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdl003
            
            #add-point:AFTER FIELD xmdl003 name="construct.a.page1.xmdl003"
                                                                                                            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdl004
            #add-point:BEFORE FIELD xmdl004 name="construct.b.page1.xmdl004"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdl004
            
            #add-point:AFTER FIELD xmdl004 name="construct.a.page1.xmdl004"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmdl004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdl004
            #add-point:ON ACTION controlp INFIELD xmdl004 name="construct.c.page1.xmdl004"
                                                                                                            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdl005
            #add-point:BEFORE FIELD xmdl005 name="construct.b.page1.xmdl005"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdl005
            
            #add-point:AFTER FIELD xmdl005 name="construct.a.page1.xmdl005"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmdl005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdl005
            #add-point:ON ACTION controlp INFIELD xmdl005 name="construct.c.page1.xmdl005"
                                                                                                            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdl006
            #add-point:BEFORE FIELD xmdl006 name="construct.b.page1.xmdl006"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdl006
            
            #add-point:AFTER FIELD xmdl006 name="construct.a.page1.xmdl006"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmdl006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdl006
            #add-point:ON ACTION controlp INFIELD xmdl006 name="construct.c.page1.xmdl006"
                                                                                                            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdl007
            #add-point:BEFORE FIELD xmdl007 name="construct.b.page1.xmdl007"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdl007
            
            #add-point:AFTER FIELD xmdl007 name="construct.a.page1.xmdl007"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmdl007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdl007
            #add-point:ON ACTION controlp INFIELD xmdl007 name="construct.c.page1.xmdl007"
                                                                                                            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.xmdl008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdl008
            #add-point:ON ACTION controlp INFIELD xmdl008 name="construct.c.page1.xmdl008"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imaf001_15()                    #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdl008  #顯示到畫面上

            NEXT FIELD xmdl008                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdl008
            #add-point:BEFORE FIELD xmdl008 name="construct.b.page1.xmdl008"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdl008
            
            #add-point:AFTER FIELD xmdl008 name="construct.a.page1.xmdl008"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmdl009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdl009
            #add-point:ON ACTION controlp INFIELD xmdl009 name="construct.c.page1.xmdl009"

            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE

            CASE g_argv[01]
               WHEN '0'     #簽退單  
                  LET g_qryparam.arg1 = '5'
               WHEN '1'     #借貨還量單  
                  LET g_qryparam.arg1 = '8'
               OTHERWISE    #預設 簽退單  
                  LET g_qryparam.arg1 = '5'
            END CASE

            CALL q_xmdl009()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdl009  #顯示到畫面上

            NEXT FIELD xmdl009                    #返回原欄位
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdl009
            #add-point:BEFORE FIELD xmdl009 name="construct.b.page1.xmdl009"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdl009
            
            #add-point:AFTER FIELD xmdl009 name="construct.a.page1.xmdl009"
                                                                                                            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdl009_desc
            #add-point:BEFORE FIELD xmdl009_desc name="construct.b.page1.xmdl009_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdl009_desc
            
            #add-point:AFTER FIELD xmdl009_desc name="construct.a.page1.xmdl009_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmdl009_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdl009_desc
            #add-point:ON ACTION controlp INFIELD xmdl009_desc name="construct.c.page1.xmdl009_desc"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.xmdl033
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdl033
            #add-point:ON ACTION controlp INFIELD xmdl033 name="construct.c.page1.xmdl033"
            
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmao004_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdl033  #顯示到畫面上

            NEXT FIELD xmdl033                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdl033
            #add-point:BEFORE FIELD xmdl033 name="construct.b.page1.xmdl033"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdl033
            
            #add-point:AFTER FIELD xmdl033 name="construct.a.page1.xmdl033"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmdl011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdl011
            #add-point:ON ACTION controlp INFIELD xmdl011 name="construct.c.page1.xmdl011"
            
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.arg1 = '221'

            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdl011  #顯示到畫面上

            NEXT FIELD xmdl011                     #返回原欄位

            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdl011
            #add-point:BEFORE FIELD xmdl011 name="construct.b.page1.xmdl011"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdl011
            
            #add-point:AFTER FIELD xmdl011 name="construct.a.page1.xmdl011"
                                                                                                            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdl012
            #add-point:BEFORE FIELD xmdl012 name="construct.b.page1.xmdl012"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdl012
            
            #add-point:AFTER FIELD xmdl012 name="construct.a.page1.xmdl012"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmdl012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdl012
            #add-point:ON ACTION controlp INFIELD xmdl012 name="construct.c.page1.xmdl012"
                                                                                                            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.xmdl017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdl017
            #add-point:ON ACTION controlp INFIELD xmdl017 name="construct.c.page1.xmdl017"
            
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdl017  #顯示到畫面上

            NEXT FIELD xmdl017                     #返回原欄位

            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdl017
            #add-point:BEFORE FIELD xmdl017 name="construct.b.page1.xmdl017"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdl017
            
            #add-point:AFTER FIELD xmdl017 name="construct.a.page1.xmdl017"
                                                                                                            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdl092
            #add-point:BEFORE FIELD xmdl092 name="construct.b.page1.xmdl092"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdl092
            
            #add-point:AFTER FIELD xmdl092 name="construct.a.page1.xmdl092"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmdl092
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdl092
            #add-point:ON ACTION controlp INFIELD xmdl092 name="construct.c.page1.xmdl092"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdl018
            #add-point:BEFORE FIELD xmdl018 name="construct.b.page1.xmdl018"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdl018
            
            #add-point:AFTER FIELD xmdl018 name="construct.a.page1.xmdl018"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmdl018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdl018
            #add-point:ON ACTION controlp INFIELD xmdl018 name="construct.c.page1.xmdl018"
                                                                                                            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdl081
            #add-point:BEFORE FIELD xmdl081 name="construct.b.page1.xmdl081"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdl081
            
            #add-point:AFTER FIELD xmdl081 name="construct.a.page1.xmdl081"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmdl081
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdl081
            #add-point:ON ACTION controlp INFIELD xmdl081 name="construct.c.page1.xmdl081"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.xmdl019
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdl019
            #add-point:ON ACTION controlp INFIELD xmdl019 name="construct.c.page1.xmdl019"
            
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdl019  #顯示到畫面上

            NEXT FIELD xmdl019                     #返回原欄位

            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdl019
            #add-point:BEFORE FIELD xmdl019 name="construct.b.page1.xmdl019"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdl019
            
            #add-point:AFTER FIELD xmdl019 name="construct.a.page1.xmdl019"
                                                                                                            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdl093
            #add-point:BEFORE FIELD xmdl093 name="construct.b.page1.xmdl093"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdl093
            
            #add-point:AFTER FIELD xmdl093 name="construct.a.page1.xmdl093"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmdl093
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdl093
            #add-point:ON ACTION controlp INFIELD xmdl093 name="construct.c.page1.xmdl093"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdl020
            #add-point:BEFORE FIELD xmdl020 name="construct.b.page1.xmdl020"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdl020
            
            #add-point:AFTER FIELD xmdl020 name="construct.a.page1.xmdl020"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmdl020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdl020
            #add-point:ON ACTION controlp INFIELD xmdl020 name="construct.c.page1.xmdl020"
                                                                                                            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdl082
            #add-point:BEFORE FIELD xmdl082 name="construct.b.page1.xmdl082"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdl082
            
            #add-point:AFTER FIELD xmdl082 name="construct.a.page1.xmdl082"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmdl082
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdl082
            #add-point:ON ACTION controlp INFIELD xmdl082 name="construct.c.page1.xmdl082"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.xmdl084
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdl084
            #add-point:ON ACTION controlp INFIELD xmdl084 name="construct.c.page1.xmdl084"
            #此段落由子樣板a08產生
            #開窗c段             
            LET l_gzcb004 = ''
            #160705-00042#12 160715 by sakura mark(S)            
            #SELECT gzcb004
            #  INTO l_gzcb004
            #  FROM gzcb_t
            # WHERE gzcb001 = '24'
            #   AND gzcb002 = g_acc_type
            #160705-00042#12 160715 by sakura mark(E)
            #160705-00042#12 160715 by sakura add(S)               
            SELECT gzcb004
              INTO l_gzcb004
              FROM gzcb_t,gzzz_t 
             WHERE gzcb001 = '24' 
               AND gzcb002 = gzzz006 
               AND gzzz001 = g_acc_type
            #160705-00042#12 160715 by sakura add(E)               
            
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE

			   LET g_qryparam.arg1 = l_gzcb004
            
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdl084  #顯示到畫面上

            NEXT FIELD xmdl084                    #返回原欄位

            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdl084
            #add-point:BEFORE FIELD xmdl084 name="construct.b.page1.xmdl084"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdl084
            
            #add-point:AFTER FIELD xmdl084 name="construct.a.page1.xmdl084"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdl084_desc
            #add-point:BEFORE FIELD xmdl084_desc name="construct.b.page1.xmdl084_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdl084_desc
            
            #add-point:AFTER FIELD xmdl084_desc name="construct.a.page1.xmdl084_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmdl084_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdl084_desc
            #add-point:ON ACTION controlp INFIELD xmdl084_desc name="construct.c.page1.xmdl084_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdl010
            #add-point:BEFORE FIELD xmdl010 name="construct.b.page1.xmdl010"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdl010
            
            #add-point:AFTER FIELD xmdl010 name="construct.a.page1.xmdl010"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmdl010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdl010
            #add-point:ON ACTION controlp INFIELD xmdl010 name="construct.c.page1.xmdl010"
                                                                                                            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdl013
            #add-point:BEFORE FIELD xmdl013 name="construct.b.page1.xmdl013"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdl013
            
            #add-point:AFTER FIELD xmdl013 name="construct.a.page1.xmdl013"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmdl013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdl013
            #add-point:ON ACTION controlp INFIELD xmdl013 name="construct.c.page1.xmdl013"
                                                                                                            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.xmdl014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdl014
            #add-point:ON ACTION controlp INFIELD xmdl014 name="construct.c.page1.xmdl014"

            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE

            CALL q_inaa001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdl014  #顯示到畫面上

            NEXT FIELD xmdl014                     #返回原欄位

            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdl014
            #add-point:BEFORE FIELD xmdl014 name="construct.b.page1.xmdl014"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdl014
            
            #add-point:AFTER FIELD xmdl014 name="construct.a.page1.xmdl014"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmdl015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdl015
            #add-point:ON ACTION controlp INFIELD xmdl015 name="construct.c.page1.xmdl015"
            
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE

            CALL q_inab002_5()                           #呼叫開窗
            
            DISPLAY g_qryparam.return1 TO xmdl015  #顯示到畫面上

            NEXT FIELD xmdl015                     #返回原欄位

            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdl015
            #add-point:BEFORE FIELD xmdl015 name="construct.b.page1.xmdl015"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdl015
            
            #add-point:AFTER FIELD xmdl015 name="construct.a.page1.xmdl015"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmdl016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdl016
            #add-point:ON ACTION controlp INFIELD xmdl016 name="construct.c.page1.xmdl016"
            
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            
            LET g_qryparam.arg1 = g_site

            CALL q_inad003()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdl016  #顯示到畫面上

            NEXT FIELD xmdl016                     #返回原欄位                                                                                                          
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdl016
            #add-point:BEFORE FIELD xmdl016 name="construct.b.page1.xmdl016"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdl016
            
            #add-point:AFTER FIELD xmdl016 name="construct.a.page1.xmdl016"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmdl052
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdl052
            #add-point:ON ACTION controlp INFIELD xmdl052 name="construct.c.page1.xmdl052"
            
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            
            LET g_qryparam.arg1 = g_site

            CALL q_xmdl052()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdl052  #顯示到畫面上

            NEXT FIELD xmdl052                     #返回原欄位
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdl052
            #add-point:BEFORE FIELD xmdl052 name="construct.b.page1.xmdl052"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdl052
            
            #add-point:AFTER FIELD xmdl052 name="construct.a.page1.xmdl052"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmdl021
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdl021
            #add-point:ON ACTION controlp INFIELD xmdl021 name="construct.c.page1.xmdl021"
            
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdl021  #顯示到畫面上

            NEXT FIELD xmdl021                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdl021
            #add-point:BEFORE FIELD xmdl021 name="construct.b.page1.xmdl021"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdl021
            
            #add-point:AFTER FIELD xmdl021 name="construct.a.page1.xmdl021"
                                                                                                            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdl022
            #add-point:BEFORE FIELD xmdl022 name="construct.b.page1.xmdl022"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdl022
            
            #add-point:AFTER FIELD xmdl022 name="construct.a.page1.xmdl022"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmdl022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdl022
            #add-point:ON ACTION controlp INFIELD xmdl022 name="construct.c.page1.xmdl022"
                                                                                                            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdl083
            #add-point:BEFORE FIELD xmdl083 name="construct.b.page1.xmdl083"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdl083
            
            #add-point:AFTER FIELD xmdl083 name="construct.a.page1.xmdl083"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmdl083
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdl083
            #add-point:ON ACTION controlp INFIELD xmdl083 name="construct.c.page1.xmdl083"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.xmdl030
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdl030
            #add-point:ON ACTION controlp INFIELD xmdl030 name="construct.c.page1.xmdl030"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pjba001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdl030  #顯示到畫面上
            NEXT FIELD xmdl030                     #返回原欄位
                                                                                                                
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdl030
            #add-point:BEFORE FIELD xmdl030 name="construct.b.page1.xmdl030"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdl030
            
            #add-point:AFTER FIELD xmdl030 name="construct.a.page1.xmdl030"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmdl031
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdl031
            #add-point:ON ACTION controlp INFIELD xmdl031 name="construct.c.page1.xmdl031"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pjbb002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdl031  #顯示到畫面上
            NEXT FIELD xmdl031                     #返回原欄位
     
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdl031
            #add-point:BEFORE FIELD xmdl031 name="construct.b.page1.xmdl031"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdl031
            
            #add-point:AFTER FIELD xmdl031 name="construct.a.page1.xmdl031"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmdl032
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdl032
            #add-point:ON ACTION controlp INFIELD xmdl032 name="construct.c.page1.xmdl032"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pjbm002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdl032  #顯示到畫面上
            NEXT FIELD xmdl032                     #返回原欄位
                                                                                                                
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdl032
            #add-point:BEFORE FIELD xmdl032 name="construct.b.page1.xmdl032"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdl032
            
            #add-point:AFTER FIELD xmdl032 name="construct.a.page1.xmdl032"
                                                                                                            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdl051
            #add-point:BEFORE FIELD xmdl051 name="construct.b.page1.xmdl051"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdl051
            
            #add-point:AFTER FIELD xmdl051 name="construct.a.page1.xmdl051"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmdl051
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdl051
            #add-point:ON ACTION controlp INFIELD xmdl051 name="construct.c.page1.xmdl051"
                                                                                                            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdl089
            #add-point:BEFORE FIELD xmdl089 name="construct.b.page1.xmdl089"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdl089
            
            #add-point:AFTER FIELD xmdl089 name="construct.a.page1.xmdl089"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmdl089
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdl089
            #add-point:ON ACTION controlp INFIELD xmdl089 name="construct.c.page1.xmdl089"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdl090
            #add-point:BEFORE FIELD xmdl090 name="construct.b.page1.xmdl090"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdl090
            
            #add-point:AFTER FIELD xmdl090 name="construct.a.page1.xmdl090"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmdl090
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdl090
            #add-point:ON ACTION controlp INFIELD xmdl090 name="construct.c.page1.xmdl090"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdl091
            #add-point:BEFORE FIELD xmdl091 name="construct.b.page1.xmdl091"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdl091
            
            #add-point:AFTER FIELD xmdl091 name="construct.a.page1.xmdl091"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmdl091
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdl091
            #add-point:ON ACTION controlp INFIELD xmdl091 name="construct.c.page1.xmdl091"
            
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
 
 
   
       
      END CONSTRUCT
      
      CONSTRUCT g_wc2_table2 ON xmdmsite,xmdmseq,xmdmseq1,xmdm001,xmdm002,xmdm002_desc,xmdm003,xmdm004, 
          xmdm005,xmdm006,xmdm007,xmdm033,xmdm008,xmdm031,xmdm010,xmdm032
           FROM s_detail3[1].xmdmsite,s_detail3[1].xmdmseq,s_detail3[1].xmdmseq1,s_detail3[1].xmdm001, 
               s_detail3[1].xmdm002,s_detail3[1].xmdm002_desc,s_detail3[1].xmdm003,s_detail3[1].xmdm004, 
               s_detail3[1].xmdm005,s_detail3[1].xmdm006,s_detail3[1].xmdm007,s_detail3[1].xmdm033,s_detail3[1].xmdm008, 
               s_detail3[1].xmdm031,s_detail3[1].xmdm010,s_detail3[1].xmdm032
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body2.before_construct"
                                                                                                            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdmsite
            #add-point:BEFORE FIELD xmdmsite name="construct.b.page3.xmdmsite"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdmsite
            
            #add-point:AFTER FIELD xmdmsite name="construct.a.page3.xmdmsite"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.xmdmsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdmsite
            #add-point:ON ACTION controlp INFIELD xmdmsite name="construct.c.page3.xmdmsite"
                                                                                                            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdmseq
            #add-point:BEFORE FIELD xmdmseq name="construct.b.page3.xmdmseq"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdmseq
            
            #add-point:AFTER FIELD xmdmseq name="construct.a.page3.xmdmseq"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.xmdmseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdmseq
            #add-point:ON ACTION controlp INFIELD xmdmseq name="construct.c.page3.xmdmseq"
                                                                                                            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdmseq1
            #add-point:BEFORE FIELD xmdmseq1 name="construct.b.page3.xmdmseq1"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdmseq1
            
            #add-point:AFTER FIELD xmdmseq1 name="construct.a.page3.xmdmseq1"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.xmdmseq1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdmseq1
            #add-point:ON ACTION controlp INFIELD xmdmseq1 name="construct.c.page3.xmdmseq1"
                                                                                                            
            #END add-point
 
 
         #Ctrlp:construct.c.page3.xmdm001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdm001
            #add-point:ON ACTION controlp INFIELD xmdm001 name="construct.c.page3.xmdm001"
            
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imaf001_15()                    #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdm001  #顯示到畫面上

            NEXT FIELD xmdm001                     #返回原欄位         
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdm001
            #add-point:BEFORE FIELD xmdm001 name="construct.b.page3.xmdm001"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdm001
            
            #add-point:AFTER FIELD xmdm001 name="construct.a.page3.xmdm001"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.xmdm002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdm002
            #add-point:ON ACTION controlp INFIELD xmdm002 name="construct.c.page3.xmdm002"
            
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE

            CASE g_argv[01]
               WHEN '0'     #簽退單  
                  LET g_qryparam.arg1 = '5'
               WHEN '1'     #借貨還量單  
                  LET g_qryparam.arg1 = '8'
               OTHERWISE    #預設走簽退單  
                  LET g_qryparam.arg1 = '5'
            END CASE

            CALL q_xmdl009()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdm002  #顯示到畫面上

            NEXT FIELD xmdm002                    #返回原欄位
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdm002
            #add-point:BEFORE FIELD xmdm002 name="construct.b.page3.xmdm002"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdm002
            
            #add-point:AFTER FIELD xmdm002 name="construct.a.page3.xmdm002"
                                                                                                            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdm002_desc
            #add-point:BEFORE FIELD xmdm002_desc name="construct.b.page3.xmdm002_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdm002_desc
            
            #add-point:AFTER FIELD xmdm002_desc name="construct.a.page3.xmdm002_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.xmdm002_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdm002_desc
            #add-point:ON ACTION controlp INFIELD xmdm002_desc name="construct.c.page3.xmdm002_desc"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page3.xmdm003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdm003
            #add-point:ON ACTION controlp INFIELD xmdm003 name="construct.c.page3.xmdm003"
            
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.arg1 = '221'

            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdm003  #顯示到畫面上

            NEXT FIELD xmdm003                     #返回原欄位

            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdm003
            #add-point:BEFORE FIELD xmdm003 name="construct.b.page3.xmdm003"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdm003
            
            #add-point:AFTER FIELD xmdm003 name="construct.a.page3.xmdm003"
                                                                                                            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdm004
            #add-point:BEFORE FIELD xmdm004 name="construct.b.page3.xmdm004"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdm004
            
            #add-point:AFTER FIELD xmdm004 name="construct.a.page3.xmdm004"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.xmdm004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdm004
            #add-point:ON ACTION controlp INFIELD xmdm004 name="construct.c.page3.xmdm004"
                                                                                                            
            #END add-point
 
 
         #Ctrlp:construct.c.page3.xmdm005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdm005
            #add-point:ON ACTION controlp INFIELD xmdm005 name="construct.c.page3.xmdm005"
            
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
			
            CALL q_inaa001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdm005  #顯示到畫面上

            NEXT FIELD xmdm005                     #返回原欄位

            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdm005
            #add-point:BEFORE FIELD xmdm005 name="construct.b.page3.xmdm005"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdm005
            
            #add-point:AFTER FIELD xmdm005 name="construct.a.page3.xmdm005"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.xmdm006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdm006
            #add-point:ON ACTION controlp INFIELD xmdm006 name="construct.c.page3.xmdm006"
            
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE

            CALL q_inab002_5()                           #呼叫開窗

            DISPLAY g_qryparam.return1 TO xmdm006  #顯示到畫面上

            NEXT FIELD xmdm006                     #返回原欄位

            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdm006
            #add-point:BEFORE FIELD xmdm006 name="construct.b.page3.xmdm006"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdm006
            
            #add-point:AFTER FIELD xmdm006 name="construct.a.page3.xmdm006"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.xmdm007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdm007
            #add-point:ON ACTION controlp INFIELD xmdm007 name="construct.c.page3.xmdm007"
            
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.arg1 = g_site

            CALL q_inad003()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdm007  #顯示到畫面上

            NEXT FIELD xmdm007                     #返回原欄位     
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdm007
            #add-point:BEFORE FIELD xmdm007 name="construct.b.page3.xmdm007"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdm007
            
            #add-point:AFTER FIELD xmdm007 name="construct.a.page3.xmdm007"
                                                                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.xmdm033
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdm033
            #add-point:ON ACTION controlp INFIELD xmdm033 name="construct.c.page3.xmdm033"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xmdl052()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdm033  #顯示到畫面上
            NEXT FIELD xmdm033                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdm033
            #add-point:BEFORE FIELD xmdm033 name="construct.b.page3.xmdm033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdm033
            
            #add-point:AFTER FIELD xmdm033 name="construct.a.page3.xmdm033"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.xmdm008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdm008
            #add-point:ON ACTION controlp INFIELD xmdm008 name="construct.c.page3.xmdm008"
            
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdm008  #顯示到畫面上

            NEXT FIELD xmdm008                     #返回原欄位

            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdm008
            #add-point:BEFORE FIELD xmdm008 name="construct.b.page3.xmdm008"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdm008
            
            #add-point:AFTER FIELD xmdm008 name="construct.a.page3.xmdm008"
                                                                                                            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdm031
            #add-point:BEFORE FIELD xmdm031 name="construct.b.page3.xmdm031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdm031
            
            #add-point:AFTER FIELD xmdm031 name="construct.a.page3.xmdm031"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.xmdm031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdm031
            #add-point:ON ACTION controlp INFIELD xmdm031 name="construct.c.page3.xmdm031"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page3.xmdm010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdm010
            #add-point:ON ACTION controlp INFIELD xmdm010 name="construct.c.page3.xmdm010"
            
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdm010  #顯示到畫面上

            NEXT FIELD xmdm010                     #返回原欄位

            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdm010
            #add-point:BEFORE FIELD xmdm010 name="construct.b.page3.xmdm010"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdm010
            
            #add-point:AFTER FIELD xmdm010 name="construct.a.page3.xmdm010"
                                                                                                            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdm032
            #add-point:BEFORE FIELD xmdm032 name="construct.b.page3.xmdm032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdm032
            
            #add-point:AFTER FIELD xmdm032 name="construct.a.page3.xmdm032"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.xmdm032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdm032
            #add-point:ON ACTION controlp INFIELD xmdm032 name="construct.c.page3.xmdm032"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
 
      
 
      
      #add-point:cs段add_cs(本段內只能出現新的CONSTRUCT指令) name="cs.add_cs"
      #150120新增"客戶訂單號碼"  earl(s)
      CONSTRUCT l_form_wc ON xmda033 FROM s_detail1[1].xmda033
                      
         BEFORE CONSTRUCT
      
         ON ACTION controlp INFIELD xmda033
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
	   		LET g_qryparam.reqry = FALSE
            CALL q_xmda033()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmda033  #顯示到畫面上
            NEXT FIELD xmda033
      
      END CONSTRUCT
      #150120新增"客戶訂單號碼"  earl(e)
      SUBDIALOG aoo_aooi360_01.aooi360_01_construct   #备注单身  #161031-00025#28
      #end add-point
 
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:cs段b_dialog name="cs.b_dialog"
         
         #沒加的話第一個頁籤會無法construct
         LET g_xmdl_d[1].xmdlseq = ""
         DISPLAY ARRAY g_xmdl_d TO s_detail1.*
            BEFORE DISPLAY
               EXIT DISPLAY
         END DISPLAY

         #沒加的話第二個頁籤會無法construct
         LET g_xmdl3_d[1].xmdmseq = ""
         DISPLAY ARRAY g_xmdl3_d TO s_detail3.*
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
            INITIALIZE g_wc2_table2 TO NULL
 
 
            FOR li_idx = 1 TO la_wc.getLength()
               CASE
                  WHEN la_wc[li_idx].tableid = "xmdk_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "xmdl_t" 
                     LET g_wc2_table1 = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "xmdm_t" 
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
   #150120新增"客戶訂單號碼"  earl(s)
   IF l_form_wc <> " 1=1" THEN
      LET g_wc2 = g_wc2," AND ",l_form_wc
      LET g_wc2_table1 = g_wc2_table1," AND xmdl003 IN (SELECT xmdadocno",
                                      "                   FROM xmda_t",
                                      "                  WHERE xmdaent = ",g_enterprise,
                                      "                    AND ",l_form_wc,")"
   END IF
   #150120新增"客戶訂單號碼"  earl(e)
   
   #xmdl
   IF (NOT cl_null(g_wc2_table2) AND g_wc2_table2.trim() <> '1=1') THEN
      LET g_wc2_table1 = g_wc2_table1," AND xmdlseq IN (SELECT xmdmseq",
                                      "                  FROM xmdm_t",
                                      "                 WHERE xmdment = xmdlent",
                                      "                   AND xmdmdocno = xmdldocno",
                                      "                   AND ",g_wc2_table2,")"
   END IF
   
   #xmdm
   IF (NOT cl_null(g_wc2_table1) AND g_wc2_table1.trim() <> '1=1') THEN
      LET g_wc2_table2 = g_wc2_table2," AND xmdmseq IN (SELECT xmdlseq",
                                      "                  FROM xmdl_t",
                                      "                 WHERE xmdlent = xmdment",
                                      "                   AND xmdldocno = xmdmdocno",
                                      "                   AND ",g_wc2_table1,")"
   END IF
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="axmt590.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION axmt590_filter()
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
      CONSTRUCT g_wc_filter ON xmdkdocno,xmdk001,xmdk003,xmdk004,xmdk006,xmdk007,xmdk008,xmdk009
                          FROM s_browse[1].b_xmdkdocno,s_browse[1].b_xmdk001,s_browse[1].b_xmdk003,s_browse[1].b_xmdk004, 
                              s_browse[1].b_xmdk006,s_browse[1].b_xmdk007,s_browse[1].b_xmdk008,s_browse[1].b_xmdk009 
 
 
         BEFORE CONSTRUCT
               DISPLAY axmt590_filter_parser('xmdkdocno') TO s_browse[1].b_xmdkdocno
            DISPLAY axmt590_filter_parser('xmdk001') TO s_browse[1].b_xmdk001
            DISPLAY axmt590_filter_parser('xmdk003') TO s_browse[1].b_xmdk003
            DISPLAY axmt590_filter_parser('xmdk004') TO s_browse[1].b_xmdk004
            DISPLAY axmt590_filter_parser('xmdk006') TO s_browse[1].b_xmdk006
            DISPLAY axmt590_filter_parser('xmdk007') TO s_browse[1].b_xmdk007
            DISPLAY axmt590_filter_parser('xmdk008') TO s_browse[1].b_xmdk008
            DISPLAY axmt590_filter_parser('xmdk009') TO s_browse[1].b_xmdk009
      
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
 
      CALL axmt590_filter_show('xmdkdocno')
   CALL axmt590_filter_show('xmdk001')
   CALL axmt590_filter_show('xmdk003')
   CALL axmt590_filter_show('xmdk004')
   CALL axmt590_filter_show('xmdk006')
   CALL axmt590_filter_show('xmdk007')
   CALL axmt590_filter_show('xmdk008')
   CALL axmt590_filter_show('xmdk009')
 
END FUNCTION
 
{</section>}
 
{<section id="axmt590.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION axmt590_filter_parser(ps_field)
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
 
{<section id="axmt590.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION axmt590_filter_show(ps_field)
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
   LET ls_condition = axmt590_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="axmt590.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION axmt590_query()
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
   CALL g_xmdl_d.clear()
   CALL g_xmdl3_d.clear()
 
   
   #add-point:query段other name="query.other"
   CALL aooi360_01_clear_detail()   #清除备注单身  #161031-00025#28 add                           
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL axmt590_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL axmt590_browser_fill("")
      CALL axmt590_fetch("")
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
      CALL axmt590_filter_show('xmdkdocno')
   CALL axmt590_filter_show('xmdk001')
   CALL axmt590_filter_show('xmdk003')
   CALL axmt590_filter_show('xmdk004')
   CALL axmt590_filter_show('xmdk006')
   CALL axmt590_filter_show('xmdk007')
   CALL axmt590_filter_show('xmdk008')
   CALL axmt590_filter_show('xmdk009')
   CALL axmt590_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL axmt590_fetch("F") 
      #顯示單身筆數
      CALL axmt590_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="axmt590.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION axmt590_fetch(p_flag)
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
   
   LET g_xmdk_m.xmdkdocno = g_browser[g_current_idx].b_xmdkdocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE axmt590_master_referesh USING g_xmdk_m.xmdkdocno INTO g_xmdk_m.xmdk000,g_xmdk_m.xmdksite, 
       g_xmdk_m.xmdkdocno,g_xmdk_m.xmdkdocdt,g_xmdk_m.xmdk001,g_xmdk_m.xmdk003,g_xmdk_m.xmdk004,g_xmdk_m.xmdkstus, 
       g_xmdk_m.xmdk081,g_xmdk_m.xmdk005,g_xmdk_m.xmdk006,g_xmdk_m.xmdk002,g_xmdk_m.xmdk007,g_xmdk_m.xmdk009, 
       g_xmdk_m.xmdk008,g_xmdk_m.xmdkownid,g_xmdk_m.xmdkowndp,g_xmdk_m.xmdkcrtid,g_xmdk_m.xmdkcrtdp, 
       g_xmdk_m.xmdkcrtdt,g_xmdk_m.xmdkmodid,g_xmdk_m.xmdkmoddt,g_xmdk_m.xmdkcnfid,g_xmdk_m.xmdkcnfdt, 
       g_xmdk_m.xmdkpstid,g_xmdk_m.xmdkpstdt,g_xmdk_m.xmdk003_desc,g_xmdk_m.xmdk004_desc,g_xmdk_m.xmdk007_desc, 
       g_xmdk_m.xmdk009_desc,g_xmdk_m.xmdk008_desc,g_xmdk_m.xmdkownid_desc,g_xmdk_m.xmdkowndp_desc,g_xmdk_m.xmdkcrtid_desc, 
       g_xmdk_m.xmdkcrtdp_desc,g_xmdk_m.xmdkmodid_desc,g_xmdk_m.xmdkcnfid_desc,g_xmdk_m.xmdkpstid_desc 
 
   
   #遮罩相關處理
   LET g_xmdk_m_mask_o.* =  g_xmdk_m.*
   CALL axmt590_xmdk_t_mask()
   LET g_xmdk_m_mask_n.* =  g_xmdk_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL axmt590_set_act_visible()   
   CALL axmt590_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
 
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #160308-00010#5 add ---(S)---
   IF g_xmdk_m.xmdkstus NOT MATCHES '[NDR]' THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF
   #160308-00010#5 add ---(E)---
   
   #end add-point
   
   #保存單頭舊值
   LET g_xmdk_m_t.* = g_xmdk_m.*
   LET g_xmdk_m_o.* = g_xmdk_m.*
   
   LET g_data_owner = g_xmdk_m.xmdkownid      
   LET g_data_dept  = g_xmdk_m.xmdkowndp
   
   #重新顯示   
   CALL axmt590_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="axmt590.insert" >}
#+ 資料新增
PRIVATE FUNCTION axmt590_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
                           
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_xmdl_d.clear()   
   CALL g_xmdl3_d.clear()  
 
 
   INITIALIZE g_xmdk_m.* TO NULL             #DEFAULT 設定
   
   LET g_xmdkdocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   CALL aooi360_01_clear_detail()   #清除备注单身  #161031-00025#28
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_xmdk_m.xmdkownid = g_user
      LET g_xmdk_m.xmdkowndp = g_dept
      LET g_xmdk_m.xmdkcrtid = g_user
      LET g_xmdk_m.xmdkcrtdp = g_dept 
      LET g_xmdk_m.xmdkcrtdt = cl_get_current()
      LET g_xmdk_m.xmdkmodid = g_user
      LET g_xmdk_m.xmdkmoddt = cl_get_current()
      LET g_xmdk_m.xmdkstus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_xmdk_m.xmdk000 = "5"
      LET g_xmdk_m.xmdk002 = "1"
 
  
      #add-point:單頭預設值 name="insert.default"
      #雖然說此作業不可新增，但為了保險，還是加上判斷 
      IF g_argv[01] = '1' THEN
         LET g_xmdk_m.xmdk000 = '8'     #借貨出貨  
         LET g_xmdk_m.xmdk002 = '8'     #借貨訂單  
      END IF
      #161031-00025#28-s
      LET g_ooff001_d = '6'   #6.單據單頭備註
      LET g_ooff002_d = g_prog
      LET g_ooff003_d = ''    #单号
      LET g_ooff004_d = '0'     #项次
      LET g_ooff005_d = ' '
      LET g_ooff006_d = ' '
      LET g_ooff007_d = ' '
      LET g_ooff008_d = ' '
      LET g_ooff009_d = ' '
      LET g_ooff010_d = ' '
      LET g_ooff011_d = ' '
      #161031-00025#28-e
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_xmdk_m_t.* = g_xmdk_m.*
      LET g_xmdk_m_o.* = g_xmdk_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_xmdk_m.xmdkstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "S"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/posted.png")
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
         WHEN "Z"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unposted.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
    
      CALL axmt590_input("a")
      
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
         INITIALIZE g_xmdk_m.* TO NULL
         INITIALIZE g_xmdl_d TO NULL
         INITIALIZE g_xmdl3_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL axmt590_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_xmdl_d.clear()
      #CALL g_xmdl3_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL axmt590_set_act_visible()   
   CALL axmt590_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_xmdkdocno_t = g_xmdk_m.xmdkdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " xmdkent = " ||g_enterprise|| " AND",
                      " xmdkdocno = '", g_xmdk_m.xmdkdocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL axmt590_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE axmt590_cl
   
   CALL axmt590_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE axmt590_master_referesh USING g_xmdk_m.xmdkdocno INTO g_xmdk_m.xmdk000,g_xmdk_m.xmdksite, 
       g_xmdk_m.xmdkdocno,g_xmdk_m.xmdkdocdt,g_xmdk_m.xmdk001,g_xmdk_m.xmdk003,g_xmdk_m.xmdk004,g_xmdk_m.xmdkstus, 
       g_xmdk_m.xmdk081,g_xmdk_m.xmdk005,g_xmdk_m.xmdk006,g_xmdk_m.xmdk002,g_xmdk_m.xmdk007,g_xmdk_m.xmdk009, 
       g_xmdk_m.xmdk008,g_xmdk_m.xmdkownid,g_xmdk_m.xmdkowndp,g_xmdk_m.xmdkcrtid,g_xmdk_m.xmdkcrtdp, 
       g_xmdk_m.xmdkcrtdt,g_xmdk_m.xmdkmodid,g_xmdk_m.xmdkmoddt,g_xmdk_m.xmdkcnfid,g_xmdk_m.xmdkcnfdt, 
       g_xmdk_m.xmdkpstid,g_xmdk_m.xmdkpstdt,g_xmdk_m.xmdk003_desc,g_xmdk_m.xmdk004_desc,g_xmdk_m.xmdk007_desc, 
       g_xmdk_m.xmdk009_desc,g_xmdk_m.xmdk008_desc,g_xmdk_m.xmdkownid_desc,g_xmdk_m.xmdkowndp_desc,g_xmdk_m.xmdkcrtid_desc, 
       g_xmdk_m.xmdkcrtdp_desc,g_xmdk_m.xmdkmodid_desc,g_xmdk_m.xmdkcnfid_desc,g_xmdk_m.xmdkpstid_desc 
 
   
   
   #遮罩相關處理
   LET g_xmdk_m_mask_o.* =  g_xmdk_m.*
   CALL axmt590_xmdk_t_mask()
   LET g_xmdk_m_mask_n.* =  g_xmdk_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_xmdk_m.xmdk000,g_xmdk_m.xmdksite,g_xmdk_m.xmdkdocno,g_xmdk_m.xmdkdocno_desc,g_xmdk_m.xmdkdocdt, 
       g_xmdk_m.xmdk001,g_xmdk_m.xmdk003,g_xmdk_m.xmdk003_desc,g_xmdk_m.xmdk004,g_xmdk_m.xmdk004_desc, 
       g_xmdk_m.xmdkstus,g_xmdk_m.xmdk081,g_xmdk_m.xmdk005,g_xmdk_m.xmdk006,g_xmdk_m.xmdk002,g_xmdk_m.xmdk007, 
       g_xmdk_m.xmdk007_desc,g_xmdk_m.xmdk009,g_xmdk_m.xmdk009_desc,g_xmdk_m.xmdk008,g_xmdk_m.xmdk008_desc, 
       g_xmdk_m.xmdkownid,g_xmdk_m.xmdkownid_desc,g_xmdk_m.xmdkowndp,g_xmdk_m.xmdkowndp_desc,g_xmdk_m.xmdkcrtid, 
       g_xmdk_m.xmdkcrtid_desc,g_xmdk_m.xmdkcrtdp,g_xmdk_m.xmdkcrtdp_desc,g_xmdk_m.xmdkcrtdt,g_xmdk_m.xmdkmodid, 
       g_xmdk_m.xmdkmodid_desc,g_xmdk_m.xmdkmoddt,g_xmdk_m.xmdkcnfid,g_xmdk_m.xmdkcnfid_desc,g_xmdk_m.xmdkcnfdt, 
       g_xmdk_m.xmdkpstid,g_xmdk_m.xmdkpstid_desc,g_xmdk_m.xmdkpstdt
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_xmdk_m.xmdkownid      
   LET g_data_dept  = g_xmdk_m.xmdkowndp
   
   #功能已完成,通報訊息中心
   CALL axmt590_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="axmt590.modify" >}
#+ 資料修改
PRIVATE FUNCTION axmt590_modify()
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
   LET g_xmdk_m_t.* = g_xmdk_m.*
   LET g_xmdk_m_o.* = g_xmdk_m.*
   
   IF g_xmdk_m.xmdkdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_xmdkdocno_t = g_xmdk_m.xmdkdocno
 
   CALL s_transaction_begin()
   
   OPEN axmt590_cl USING g_enterprise,g_xmdk_m.xmdkdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axmt590_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE axmt590_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE axmt590_master_referesh USING g_xmdk_m.xmdkdocno INTO g_xmdk_m.xmdk000,g_xmdk_m.xmdksite, 
       g_xmdk_m.xmdkdocno,g_xmdk_m.xmdkdocdt,g_xmdk_m.xmdk001,g_xmdk_m.xmdk003,g_xmdk_m.xmdk004,g_xmdk_m.xmdkstus, 
       g_xmdk_m.xmdk081,g_xmdk_m.xmdk005,g_xmdk_m.xmdk006,g_xmdk_m.xmdk002,g_xmdk_m.xmdk007,g_xmdk_m.xmdk009, 
       g_xmdk_m.xmdk008,g_xmdk_m.xmdkownid,g_xmdk_m.xmdkowndp,g_xmdk_m.xmdkcrtid,g_xmdk_m.xmdkcrtdp, 
       g_xmdk_m.xmdkcrtdt,g_xmdk_m.xmdkmodid,g_xmdk_m.xmdkmoddt,g_xmdk_m.xmdkcnfid,g_xmdk_m.xmdkcnfdt, 
       g_xmdk_m.xmdkpstid,g_xmdk_m.xmdkpstdt,g_xmdk_m.xmdk003_desc,g_xmdk_m.xmdk004_desc,g_xmdk_m.xmdk007_desc, 
       g_xmdk_m.xmdk009_desc,g_xmdk_m.xmdk008_desc,g_xmdk_m.xmdkownid_desc,g_xmdk_m.xmdkowndp_desc,g_xmdk_m.xmdkcrtid_desc, 
       g_xmdk_m.xmdkcrtdp_desc,g_xmdk_m.xmdkmodid_desc,g_xmdk_m.xmdkcnfid_desc,g_xmdk_m.xmdkpstid_desc 
 
   
   #檢查是否允許此動作
   IF NOT axmt590_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_xmdk_m_mask_o.* =  g_xmdk_m.*
   CALL axmt590_xmdk_t_mask()
   LET g_xmdk_m_mask_n.* =  g_xmdk_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
   #LET l_wc2_table2 = g_wc2_table2
   #LET l_wc2_table2 = " 1=1"
 
 
 
   
   CALL axmt590_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
   #LET  g_wc2_table2 = l_wc2_table2 
 
 
 
    
   WHILE TRUE
      LET g_xmdkdocno_t = g_xmdk_m.xmdkdocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_xmdk_m.xmdkmodid = g_user 
LET g_xmdk_m.xmdkmoddt = cl_get_current()
LET g_xmdk_m.xmdkmodid_desc = cl_get_username(g_xmdk_m.xmdkmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      #「D抽單 / R已拒絕」狀況碼更改資料後，需還原為「N未確認」
      IF g_xmdk_m.xmdkstus MATCHES "[DR]" THEN 
         LET g_xmdk_m.xmdkstus = "N"
      END IF   
      
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL axmt590_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      #160308-00010#5 add ---(S)---
      IF (g_update OR NOT INT_FLAG) AND g_xmdk_m.xmdkstus = "N" THEN
         UPDATE xmdk_t SET xmdkstus = g_xmdk_m.xmdkstus
                     WHERE xmdkent = g_enterprise AND xmdkdocno = g_xmdkdocno_t
      END IF
      #160308-00010#5 add ---(E)---   
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE xmdk_t SET (xmdkmodid,xmdkmoddt) = (g_xmdk_m.xmdkmodid,g_xmdk_m.xmdkmoddt)
          WHERE xmdkent = g_enterprise AND xmdkdocno = g_xmdkdocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_xmdk_m.* = g_xmdk_m_t.*
            CALL axmt590_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_xmdk_m.xmdkdocno != g_xmdk_m_t.xmdkdocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
                                                                                 
         #end add-point
         
         #更新單身key值
         UPDATE xmdl_t SET xmdldocno = g_xmdk_m.xmdkdocno
 
          WHERE xmdlent = g_enterprise AND xmdldocno = g_xmdk_m_t.xmdkdocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
                                                                                 
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "xmdl_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xmdl_t:",SQLERRMESSAGE 
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
         
         UPDATE xmdm_t
            SET xmdmdocno = g_xmdk_m.xmdkdocno
 
          WHERE xmdment = g_enterprise AND
                xmdmdocno = g_xmdkdocno_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update2"
                                                                                 
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "xmdm_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xmdm_t:",SQLERRMESSAGE 
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
   CALL axmt590_set_act_visible()   
   CALL axmt590_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " xmdkent = " ||g_enterprise|| " AND",
                      " xmdkdocno = '", g_xmdk_m.xmdkdocno, "' "
 
   #填到對應位置
   CALL axmt590_browser_fill("")
 
   CLOSE axmt590_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL axmt590_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="axmt590.input" >}
#+ 資料輸入
PRIVATE FUNCTION axmt590_input(p_cmd)
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
   
   DEFINE l_success    LIKE type_t.num5
   DEFINE l_rollback   LIKE type_t.num5 
   DEFINE l_xmdl014    LIKE xmdl_t.xmdl014
   DEFINE l_xmdl015    LIKE xmdl_t.xmdl015
   DEFINE l_xmdl016    LIKE xmdl_t.xmdl016
   DEFINE l_xmdl052    LIKE xmdl_t.xmdl052   
   
   DEFINE l_type       LIKE type_t.chr1
   DEFINE r_success    LIKE type_t.num5
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
   DISPLAY BY NAME g_xmdk_m.xmdk000,g_xmdk_m.xmdksite,g_xmdk_m.xmdkdocno,g_xmdk_m.xmdkdocno_desc,g_xmdk_m.xmdkdocdt, 
       g_xmdk_m.xmdk001,g_xmdk_m.xmdk003,g_xmdk_m.xmdk003_desc,g_xmdk_m.xmdk004,g_xmdk_m.xmdk004_desc, 
       g_xmdk_m.xmdkstus,g_xmdk_m.xmdk081,g_xmdk_m.xmdk005,g_xmdk_m.xmdk006,g_xmdk_m.xmdk002,g_xmdk_m.xmdk007, 
       g_xmdk_m.xmdk007_desc,g_xmdk_m.xmdk009,g_xmdk_m.xmdk009_desc,g_xmdk_m.xmdk008,g_xmdk_m.xmdk008_desc, 
       g_xmdk_m.xmdkownid,g_xmdk_m.xmdkownid_desc,g_xmdk_m.xmdkowndp,g_xmdk_m.xmdkowndp_desc,g_xmdk_m.xmdkcrtid, 
       g_xmdk_m.xmdkcrtid_desc,g_xmdk_m.xmdkcrtdp,g_xmdk_m.xmdkcrtdp_desc,g_xmdk_m.xmdkcrtdt,g_xmdk_m.xmdkmodid, 
       g_xmdk_m.xmdkmodid_desc,g_xmdk_m.xmdkmoddt,g_xmdk_m.xmdkcnfid,g_xmdk_m.xmdkcnfid_desc,g_xmdk_m.xmdkcnfdt, 
       g_xmdk_m.xmdkpstid,g_xmdk_m.xmdkpstid_desc,g_xmdk_m.xmdkpstdt
   
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
   LET g_forupd_sql = "SELECT xmdlsite,xmdlseq,xmdl001,xmdl002,xmdl003,xmdl004,xmdl005,xmdl006,xmdl007, 
       xmdl008,xmdl009,xmdl033,xmdl011,xmdl012,xmdl017,xmdl092,xmdl018,xmdl081,xmdl019,xmdl093,xmdl020, 
       xmdl082,xmdl084,xmdl010,xmdl013,xmdl014,xmdl015,xmdl016,xmdl052,xmdl021,xmdl022,xmdl083,xmdl030, 
       xmdl031,xmdl032,xmdl051,xmdl089,xmdl090,xmdl091 FROM xmdl_t WHERE xmdlent=? AND xmdldocno=? AND  
       xmdlseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
                           
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axmt590_bcl CURSOR FROM g_forupd_sql
   
   #add-point:input段define_sql name="input.define_sql2"
                           
   #end add-point    
   LET g_forupd_sql = "SELECT xmdmsite,xmdmseq,xmdmseq1,xmdm001,xmdm002,xmdm003,xmdm004,xmdm005,xmdm006, 
       xmdm007,xmdm033,xmdm008,xmdm031,xmdm010,xmdm032 FROM xmdm_t WHERE xmdment=? AND xmdmdocno=? AND  
       xmdmseq=? AND xmdmseq1=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql2"
                           
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axmt590_bcl2 CURSOR FROM g_forupd_sql
 
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
                           
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL axmt590_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   #將單身輸入權限放入共用變數給嵌入的子程式用, 若子程式要自己控管, 還是可以從子程式中覆蓋掉值
   #161031-00025#28-s
   LET g_detail_insert = l_allow_insert
   LET g_detail_delete = l_allow_delete
   #161031-00025#28-e                           
   #end add-point
   CALL axmt590_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_xmdk_m.xmdk001,g_xmdk_m.xmdkstus
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   LET l_allow_insert = FALSE
   LET l_allow_delete = FALSE                   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="axmt590.input.head" >}
      #單頭段
      INPUT BY NAME g_xmdk_m.xmdk001,g_xmdk_m.xmdkstus 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN axmt590_cl USING g_enterprise,g_xmdk_m.xmdkdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN axmt590_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE axmt590_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL axmt590_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"

            CALL cl_showmsg_init()

            #end add-point
            CALL axmt590_set_no_entry(p_cmd)
    
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdk001
            #add-point:BEFORE FIELD xmdk001 name="input.b.xmdk001"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdk001
            
            #add-point:AFTER FIELD xmdk001 name="input.a.xmdk001"
            IF NOT cl_null(g_xmdk_m.xmdk001) THEN
               IF g_xmdk_m.xmdk001 <> g_xmdk_m_o.xmdk001 OR cl_null(g_xmdk_m_o.xmdk001) THEN
                  #151120-00003#1 20151120 mark by beckxie---S
                  #IF g_xmdk_m.xmdk001 < g_xmdk_m.xmdkdocdt THEN
                  #   INITIALIZE g_errparam TO NULL
                  #   CASE g_argv[01]
                  #      WHEN '0'
                  #         LET g_errparam.code = 'axm-00269'         #簽退日期不可小於單據日期！
                  #      WHEN '1'
                  #         LET g_errparam.code = 'axm-00267'         #扣帳日期不可小於單據日期！  
                  #      OTHERWISE
                  #   END CASE
                  #   LET g_errparam.extend = g_xmdk_m.xmdk001
                  #   LET g_errparam.popup = TRUE
                  #   CALL cl_err()
                  #
                  #   LET g_xmdk_m.xmdk001 = g_xmdk_m_o.xmdk001
                  #   NEXT FIELD CURRENT
                  #END IF
                  #151120-00003#1 20151120 mark by beckxie---E
               END IF
            END IF
            
            LET g_xmdk_m_o.xmdk001 = g_xmdk_m.xmdk001
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdk001
            #add-point:ON CHANGE xmdk001 name="input.g.xmdk001"
                                                                                                            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdkstus
            #add-point:BEFORE FIELD xmdkstus name="input.b.xmdkstus"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdkstus
            
            #add-point:AFTER FIELD xmdkstus name="input.a.xmdkstus"
                                                                                                            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdkstus
            #add-point:ON CHANGE xmdkstus name="input.g.xmdkstus"
                                                                                                            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.xmdk001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdk001
            #add-point:ON ACTION controlp INFIELD xmdk001 name="input.c.xmdk001"
                                                                                                            
            #END add-point
 
 
         #Ctrlp:input.c.xmdkstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdkstus
            #add-point:ON ACTION controlp INFIELD xmdkstus name="input.c.xmdkstus"
                                                                                                            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_xmdk_m.xmdkdocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
 
               #end add-point
               
               INSERT INTO xmdk_t (xmdkent,xmdk000,xmdksite,xmdkdocno,xmdkdocdt,xmdk001,xmdk003,xmdk004, 
                   xmdkstus,xmdk081,xmdk005,xmdk006,xmdk002,xmdk007,xmdk009,xmdk008,xmdkownid,xmdkowndp, 
                   xmdkcrtid,xmdkcrtdp,xmdkcrtdt,xmdkmodid,xmdkmoddt,xmdkcnfid,xmdkcnfdt,xmdkpstid,xmdkpstdt) 
 
               VALUES (g_enterprise,g_xmdk_m.xmdk000,g_xmdk_m.xmdksite,g_xmdk_m.xmdkdocno,g_xmdk_m.xmdkdocdt, 
                   g_xmdk_m.xmdk001,g_xmdk_m.xmdk003,g_xmdk_m.xmdk004,g_xmdk_m.xmdkstus,g_xmdk_m.xmdk081, 
                   g_xmdk_m.xmdk005,g_xmdk_m.xmdk006,g_xmdk_m.xmdk002,g_xmdk_m.xmdk007,g_xmdk_m.xmdk009, 
                   g_xmdk_m.xmdk008,g_xmdk_m.xmdkownid,g_xmdk_m.xmdkowndp,g_xmdk_m.xmdkcrtid,g_xmdk_m.xmdkcrtdp, 
                   g_xmdk_m.xmdkcrtdt,g_xmdk_m.xmdkmodid,g_xmdk_m.xmdkmoddt,g_xmdk_m.xmdkcnfid,g_xmdk_m.xmdkcnfdt, 
                   g_xmdk_m.xmdkpstid,g_xmdk_m.xmdkpstdt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_xmdk_m:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭新增中 name="input.head.m_insert"
               LET g_ooff003_d = g_xmdk_m.xmdkdocno   #161031-00025#28 add                                                                                                                                         
               #end add-point
               
               
               
               
               #add-point:單頭新增後 name="input.head.a_insert"
 
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL axmt590_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL axmt590_b_fill()
                  CALL axmt590_b_fill2('0')
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
               CALL axmt590_xmdk_t_mask_restore('restore_mask_o')
               
               UPDATE xmdk_t SET (xmdk000,xmdksite,xmdkdocno,xmdkdocdt,xmdk001,xmdk003,xmdk004,xmdkstus, 
                   xmdk081,xmdk005,xmdk006,xmdk002,xmdk007,xmdk009,xmdk008,xmdkownid,xmdkowndp,xmdkcrtid, 
                   xmdkcrtdp,xmdkcrtdt,xmdkmodid,xmdkmoddt,xmdkcnfid,xmdkcnfdt,xmdkpstid,xmdkpstdt) = (g_xmdk_m.xmdk000, 
                   g_xmdk_m.xmdksite,g_xmdk_m.xmdkdocno,g_xmdk_m.xmdkdocdt,g_xmdk_m.xmdk001,g_xmdk_m.xmdk003, 
                   g_xmdk_m.xmdk004,g_xmdk_m.xmdkstus,g_xmdk_m.xmdk081,g_xmdk_m.xmdk005,g_xmdk_m.xmdk006, 
                   g_xmdk_m.xmdk002,g_xmdk_m.xmdk007,g_xmdk_m.xmdk009,g_xmdk_m.xmdk008,g_xmdk_m.xmdkownid, 
                   g_xmdk_m.xmdkowndp,g_xmdk_m.xmdkcrtid,g_xmdk_m.xmdkcrtdp,g_xmdk_m.xmdkcrtdt,g_xmdk_m.xmdkmodid, 
                   g_xmdk_m.xmdkmoddt,g_xmdk_m.xmdkcnfid,g_xmdk_m.xmdkcnfdt,g_xmdk_m.xmdkpstid,g_xmdk_m.xmdkpstdt) 
 
                WHERE xmdkent = g_enterprise AND xmdkdocno = g_xmdkdocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "xmdk_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
                                                                                                                                       
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL axmt590_xmdk_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_xmdk_m_t)
               LET g_log2 = util.JSON.stringify(g_xmdk_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
                                                                                                                                       
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_xmdkdocno_t = g_xmdk_m.xmdkdocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="axmt590.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_xmdl_d FROM s_detail1.*
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
               
               #END add-point
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION axmt590_call_axmt540_01
            LET g_action_choice="axmt590_call_axmt540_01"
            IF cl_auth_chk_act("axmt590_call_axmt540_01") THEN
               
               #add-point:ON ACTION axmt590_call_axmt540_01 name="input.detail_input.page1.axmt590_call_axmt540_01"
               CALL axmt540_01('5',g_xmdk_m.xmdksite,'',g_xmdk_m.xmdkdocno,
                               g_xmdl_d[l_ac].xmdlseq,g_xmdl_d[l_ac].xmdl008,g_xmdl_d[l_ac].xmdl009,
                               g_xmdl_d[l_ac].xmdl011,g_xmdl_d[l_ac].xmdl012,
                               g_xmdl_d[l_ac].xmdl017,g_xmdl_d[l_ac].xmdl018,g_xmdl_d[l_ac].xmdl081,
                               g_xmdl_d[l_ac].xmdl019,g_xmdl_d[l_ac].xmdl020,g_xmdl_d[l_ac].xmdl082,
                               g_xmdl_d[l_ac].xmdl001,g_xmdl_d[l_ac].xmdl002,g_xmdl_d[l_ac].xmdl003,g_xmdl_d[l_ac].xmdl004,g_xmdl_d[l_ac].xmdl030)
                               RETURNING l_success,l_rollback,l_xmdl014,l_xmdl015,l_xmdl016,l_xmdl052
                               
               IF l_rollback THEN  #多庫儲批資料錯誤必須rollback
                  CLOSE axmt590_cl
                  CALL s_transaction_end('N','0')
                  RETURN
               END IF

               IF l_success THEN
                  IF NOT cl_null(l_xmdl016) THEN  #只有一筆
                     LET g_xmdl_d[l_ac].xmdl013 = 'N'
                     LET g_xmdl_d[l_ac].xmdl014 = l_xmdl014
                     LET g_xmdl_d[l_ac].xmdl015 = l_xmdl015
                     LET g_xmdl_d[l_ac].xmdl016 = l_xmdl016
                     LET g_xmdl_d[l_ac].xmdl052 = l_xmdl052
                  ELSE
                     LET g_xmdl_d[l_ac].xmdl013 = 'Y'
                     LET g_xmdl_d[l_ac].xmdl014 = ' '
                     LET g_xmdl_d[l_ac].xmdl015 = ' '
                     LET g_xmdl_d[l_ac].xmdl016 = ' '
                     LET g_xmdl_d[l_ac].xmdl052 = ' '
                  END IF

                  CALL s_desc_get_stock_desc(g_xmdl_d[l_ac].xmdlsite,g_xmdl_d[l_ac].xmdl014) RETURNING g_xmdl_d[l_ac].xmdl014_desc
                  CALL s_desc_get_locator_desc(g_xmdl_d[l_ac].xmdlsite,g_xmdl_d[l_ac].xmdl014,g_xmdl_d[l_ac].xmdl015) RETURNING g_xmdl_d[l_ac].xmdl015_desc
               END IF

               #END add-point
            END IF
 
 
 
 
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_xmdl_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL axmt590_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_xmdl_d.getLength()
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
            OPEN axmt590_cl USING g_enterprise,g_xmdk_m.xmdkdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN axmt590_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE axmt590_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_xmdl_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_xmdl_d[l_ac].xmdlseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_xmdl_d_t.* = g_xmdl_d[l_ac].*  #BACKUP
               LET g_xmdl_d_o.* = g_xmdl_d[l_ac].*  #BACKUP
               CALL axmt590_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
          
               #end add-point  
               CALL axmt590_set_no_entry_b(l_cmd)
               IF NOT axmt590_lock_b("xmdl_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH axmt590_bcl INTO g_xmdl_d[l_ac].xmdlsite,g_xmdl_d[l_ac].xmdlseq,g_xmdl_d[l_ac].xmdl001, 
                      g_xmdl_d[l_ac].xmdl002,g_xmdl_d[l_ac].xmdl003,g_xmdl_d[l_ac].xmdl004,g_xmdl_d[l_ac].xmdl005, 
                      g_xmdl_d[l_ac].xmdl006,g_xmdl_d[l_ac].xmdl007,g_xmdl_d[l_ac].xmdl008,g_xmdl_d[l_ac].xmdl009, 
                      g_xmdl_d[l_ac].xmdl033,g_xmdl_d[l_ac].xmdl011,g_xmdl_d[l_ac].xmdl012,g_xmdl_d[l_ac].xmdl017, 
                      g_xmdl_d[l_ac].xmdl092,g_xmdl_d[l_ac].xmdl018,g_xmdl_d[l_ac].xmdl081,g_xmdl_d[l_ac].xmdl019, 
                      g_xmdl_d[l_ac].xmdl093,g_xmdl_d[l_ac].xmdl020,g_xmdl_d[l_ac].xmdl082,g_xmdl_d[l_ac].xmdl084, 
                      g_xmdl_d[l_ac].xmdl010,g_xmdl_d[l_ac].xmdl013,g_xmdl_d[l_ac].xmdl014,g_xmdl_d[l_ac].xmdl015, 
                      g_xmdl_d[l_ac].xmdl016,g_xmdl_d[l_ac].xmdl052,g_xmdl_d[l_ac].xmdl021,g_xmdl_d[l_ac].xmdl022, 
                      g_xmdl_d[l_ac].xmdl083,g_xmdl_d[l_ac].xmdl030,g_xmdl_d[l_ac].xmdl031,g_xmdl_d[l_ac].xmdl032, 
                      g_xmdl_d[l_ac].xmdl051,g_xmdl_d[l_ac].xmdl089,g_xmdl_d[l_ac].xmdl090,g_xmdl_d[l_ac].xmdl091 
 
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_xmdl_d_t.xmdlseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_xmdl_d_mask_o[l_ac].* =  g_xmdl_d[l_ac].*
                  CALL axmt590_xmdl_t_mask()
                  LET g_xmdl_d_mask_n[l_ac].* =  g_xmdl_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL axmt590_show()
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
            INITIALIZE g_xmdl_d[l_ac].* TO NULL 
            INITIALIZE g_xmdl_d_t.* TO NULL 
            INITIALIZE g_xmdl_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_xmdl_d[l_ac].xmdl007 = "1"
      LET g_xmdl_d[l_ac].xmdl092 = "0"
      LET g_xmdl_d[l_ac].xmdl018 = "0"
      LET g_xmdl_d[l_ac].xmdl081 = "0"
      LET g_xmdl_d[l_ac].xmdl093 = "0"
      LET g_xmdl_d[l_ac].xmdl020 = "0"
      LET g_xmdl_d[l_ac].xmdl082 = "0"
      LET g_xmdl_d[l_ac].xmdl013 = "N"
      LET g_xmdl_d[l_ac].xmdl022 = "0"
      LET g_xmdl_d[l_ac].xmdl083 = "0"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            
            #end add-point
            LET g_xmdl_d_t.* = g_xmdl_d[l_ac].*     #新輸入資料
            LET g_xmdl_d_o.* = g_xmdl_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL axmt590_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
                                                                 
            #end add-point
            CALL axmt590_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xmdl_d[li_reproduce_target].* = g_xmdl_d[li_reproduce].*
 
               LET g_xmdl_d[li_reproduce_target].xmdlseq = NULL
 
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
            SELECT COUNT(1) INTO l_count FROM xmdl_t 
             WHERE xmdlent = g_enterprise AND xmdldocno = g_xmdk_m.xmdkdocno
 
               AND xmdlseq = g_xmdl_d[l_ac].xmdlseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
                                                                                                                                       
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xmdk_m.xmdkdocno
               LET gs_keys[2] = g_xmdl_d[g_detail_idx].xmdlseq
               CALL axmt590_insert_b('xmdl_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               #161031-00025#28-s
               IF NOT cl_null(g_xmdl_d[l_ac].ooff013) THEN
                  CALL s_aooi360_gen('7',g_prog,g_xmdk_m.xmdkdocno,g_xmdl_d[l_ac].xmdlseq,'','','','','','','','1',g_xmdl_d[l_ac].ooff013) RETURNING l_success
               END IF
               #161031-00025#28-e                                                                                                                                        
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_xmdl_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xmdl_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL axmt590_b_fill()
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
               LET gs_keys[01] = g_xmdk_m.xmdkdocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_xmdl_d_t.xmdlseq
 
            
               #刪除同層單身
               IF NOT axmt590_delete_b('xmdl_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE axmt590_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT axmt590_key_delete_b(gs_keys,'xmdl_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE axmt590_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               #161031-00025#28-s
               CALL s_aooi360_del('7',g_prog,g_xmdk_m.xmdkdocno,g_xmdl_d_t.xmdlseq,'','','','','','','','1') RETURNING l_success
               #161031-00025#28-e                                                                                                                                       
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE axmt590_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
 
               #end add-point
               LET l_count = g_xmdl_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
 
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_xmdl_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdl009
            
            #add-point:AFTER FIELD xmdl009 name="input.a.page1.xmdl009"
           
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdl009
            #add-point:BEFORE FIELD xmdl009 name="input.b.page1.xmdl009"
 
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdl009
            #add-point:ON CHANGE xmdl009 name="input.g.page1.xmdl009"
                                                                                                            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdl009_desc
            #add-point:BEFORE FIELD xmdl009_desc name="input.b.page1.xmdl009_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdl009_desc
            
            #add-point:AFTER FIELD xmdl009_desc name="input.a.page1.xmdl009_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdl009_desc
            #add-point:ON CHANGE xmdl009_desc name="input.g.page1.xmdl009_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdl092
            #add-point:BEFORE FIELD xmdl092 name="input.b.page1.xmdl092"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdl092
            
            #add-point:AFTER FIELD xmdl092 name="input.a.page1.xmdl092"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdl092
            #add-point:ON CHANGE xmdl092 name="input.g.page1.xmdl092"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdl093
            #add-point:BEFORE FIELD xmdl093 name="input.b.page1.xmdl093"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdl093
            
            #add-point:AFTER FIELD xmdl093 name="input.a.page1.xmdl093"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdl093
            #add-point:ON CHANGE xmdl093 name="input.g.page1.xmdl093"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdl084
            
            #add-point:AFTER FIELD xmdl084 name="input.a.page1.xmdl084"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdl084
            #add-point:BEFORE FIELD xmdl084 name="input.b.page1.xmdl084"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdl084
            #add-point:ON CHANGE xmdl084 name="input.g.page1.xmdl084"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdl084_desc
            #add-point:BEFORE FIELD xmdl084_desc name="input.b.page1.xmdl084_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdl084_desc
            
            #add-point:AFTER FIELD xmdl084_desc name="input.a.page1.xmdl084_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdl084_desc
            #add-point:ON CHANGE xmdl084_desc name="input.g.page1.xmdl084_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdl014
            
            #add-point:AFTER FIELD xmdl014 name="input.a.page1.xmdl014"
            CALL s_desc_get_stock_desc(g_xmdl_d[l_ac].xmdlsite,g_xmdl_d[l_ac].xmdl014) RETURNING g_xmdl_d[l_ac].xmdl014_desc            

            IF NOT cl_null(g_xmdl_d[l_ac].xmdl014) THEN
               IF g_xmdl_d[l_ac].xmdl014 <> g_xmdl_d_o.xmdl014 OR cl_null(g_xmdl_d_o.xmdl014) THEN

                  IF NOT axmt590_xmdl014_chk() THEN
                     LET g_xmdl_d[l_ac].xmdl014 = g_xmdl_d_o.xmdl014                     
                     CALL s_desc_get_stock_desc(g_xmdl_d[l_ac].xmdlsite,g_xmdl_d[l_ac].xmdl014) RETURNING g_xmdl_d[l_ac].xmdl014_desc
                     
                     NEXT FIELD CURRENT
                  END IF

                  #檢查儲位
                  IF NOT s_axmt590_xmdl015_chk(g_xmdl_d[l_ac].xmdl014,g_xmdl_d[l_ac].xmdl015) THEN
                     LET g_xmdl_d[l_ac].xmdl014 = g_xmdl_d_o.xmdl014
                     CALL s_desc_get_stock_desc(g_xmdl_d[l_ac].xmdlsite,g_xmdl_d[l_ac].xmdl014) RETURNING g_xmdl_d[l_ac].xmdl014_desc
                     #add--160325-00003 By shiun--(S)
                     LET g_xmdl_d[l_ac].xmdl015 = g_xmdl_d_o.xmdl015
                     CALL s_desc_get_locator_desc(g_xmdl_d[l_ac].xmdlsite,g_xmdl_d[l_ac].xmdl014,g_xmdl_d[l_ac].xmdl015) RETURNING g_xmdl_d[l_ac].xmdl015_desc
                     #add--160325-00003 By shiun--(E)

                     NEXT FIELD CURRENT
                  END IF

                  #儲位控管若為5.不使用儲位控管
                  IF NOT s_axmt540_inaa007_chk(g_xmdl_d[l_ac].xmdl014) THEN
                     LET g_xmdl_d[l_ac].xmdl015 = ''
                     LET g_xmdl_d_o.xmdl015 = g_xmdl_d[l_ac].xmdl015
                     CALL s_desc_get_locator_desc(g_xmdl_d[l_ac].xmdlsite,g_xmdl_d[l_ac].xmdl014,g_xmdl_d[l_ac].xmdl015) RETURNING g_xmdl_d[l_ac].xmdl015_desc
                  END IF   

                  #add by lixh 20151112
                 #IF s_lot_batch_number(g_xmdl_d[l_ac].xmdl008,g_site) THEN      #160314-00008#1 mark
                  IF s_lot_batch_number_1n3(g_xmdl_d[l_ac].xmdl008,g_site) THEN  #160314-00008#1 add
                     CALL s_lot_upd_inao(g_xmdk_m.xmdkdocno,g_xmdl_d[g_detail_idx].xmdlseq,'1','2',g_xmdl_d[l_ac].xmdl014,g_xmdl_d[l_ac].xmdl015,g_xmdl_d[l_ac].xmdl016,g_site,g_xmdl_d[l_ac].xmdl052)   #160316-00007#5 add by lixh 20160316
                          RETURNING r_success 
                     IF NOT r_success THEN
                        NEXT FIELD xmdl014
                     END IF
                  END IF                        
                  #add by lixh 20151112
               END IF
            END IF            

            LET g_xmdl_d_o.xmdl014 = g_xmdl_d[l_ac].xmdl014

            CALL axmt590_set_entry_b(l_cmd)
            CALL axmt590_set_no_entry_b(l_cmd) 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdl014
            #add-point:BEFORE FIELD xmdl014 name="input.b.page1.xmdl014"
                                                                                                            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdl014
            #add-point:ON CHANGE xmdl014 name="input.g.page1.xmdl014"
                                                                                                            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdl015
            
            #add-point:AFTER FIELD xmdl015 name="input.a.page1.xmdl015"
            CALL s_desc_get_locator_desc(g_xmdl_d[l_ac].xmdlsite,g_xmdl_d[l_ac].xmdl014,g_xmdl_d[l_ac].xmdl015) RETURNING g_xmdl_d[l_ac].xmdl015_desc 
           
            IF NOT cl_null(g_xmdl_d[l_ac].xmdl015) THEN
               IF g_xmdl_d[l_ac].xmdl015 <> g_xmdl_d_o.xmdl015 OR cl_null(g_xmdl_d_o.xmdl015) THEN
               
                  IF NOT s_axmt590_xmdl015_chk(g_xmdl_d[l_ac].xmdl014,g_xmdl_d[l_ac].xmdl015) THEN
                     LET g_xmdl_d[l_ac].xmdl015 = g_xmdl_d_t.xmdl015

                     CALL s_desc_get_locator_desc(g_xmdl_d[l_ac].xmdlsite,g_xmdl_d[l_ac].xmdl014,g_xmdl_d[l_ac].xmdl015) RETURNING g_xmdl_d[l_ac].xmdl015_desc 

                     NEXT FIELD xmdl015
                  END IF
                  
                  #add by lixh 20151112
                 #IF s_lot_batch_number(g_xmdl_d[l_ac].xmdl008,g_site) THEN     #160314-00008#1 mark
                  IF s_lot_batch_number_1n3(g_xmdl_d[l_ac].xmdl008,g_site) THEN #160314-00008#1 add
                     CALL s_lot_upd_inao(g_xmdk_m.xmdkdocno,g_xmdl_d[g_detail_idx].xmdlseq,'1','2',g_xmdl_d[l_ac].xmdl014,g_xmdl_d[l_ac].xmdl015,g_xmdl_d[l_ac].xmdl016,g_site,g_xmdl_d[l_ac].xmdl052)  #160316-00007#5 add by lixh 20160316
                          RETURNING r_success 
                     IF NOT r_success THEN
                        NEXT FIELD xmdl015
                     END IF
                  END IF   
                  #add by lixh 20151112                
               END IF
            END IF
            
            LET g_xmdl_d_o.xmdl015 = g_xmdl_d[l_ac].xmdl015
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdl015
            #add-point:BEFORE FIELD xmdl015 name="input.b.page1.xmdl015"
                                                                                                            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdl015
            #add-point:ON CHANGE xmdl015 name="input.g.page1.xmdl015"
                                                                                                            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdl016
            #add-point:BEFORE FIELD xmdl016 name="input.b.page1.xmdl016"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdl016
            
            #add-point:AFTER FIELD xmdl016 name="input.a.page1.xmdl016"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdl016
            #add-point:ON CHANGE xmdl016 name="input.g.page1.xmdl016"
                                                                                                            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdl051
            #add-point:BEFORE FIELD xmdl051 name="input.b.page1.xmdl051"
                                                                                                            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdl051
            
            #add-point:AFTER FIELD xmdl051 name="input.a.page1.xmdl051"
                                                                                                            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdl051
            #add-point:ON CHANGE xmdl051 name="input.g.page1.xmdl051"
                                                                                                            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdl089
            #add-point:BEFORE FIELD xmdl089 name="input.b.page1.xmdl089"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdl089
            
            #add-point:AFTER FIELD xmdl089 name="input.a.page1.xmdl089"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdl089
            #add-point:ON CHANGE xmdl089 name="input.g.page1.xmdl089"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdl090
            #add-point:BEFORE FIELD xmdl090 name="input.b.page1.xmdl090"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdl090
            
            #add-point:AFTER FIELD xmdl090 name="input.a.page1.xmdl090"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdl090
            #add-point:ON CHANGE xmdl090 name="input.g.page1.xmdl090"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdl091
            #add-point:BEFORE FIELD xmdl091 name="input.b.page1.xmdl091"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdl091
            
            #add-point:AFTER FIELD xmdl091 name="input.a.page1.xmdl091"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdl091
            #add-point:ON CHANGE xmdl091 name="input.g.page1.xmdl091"
            
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
 
 
 
                  #Ctrlp:input.c.page1.xmdl009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdl009
            #add-point:ON ACTION controlp INFIELD xmdl009 name="input.c.page1.xmdl009"
 
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdl009_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdl009_desc
            #add-point:ON ACTION controlp INFIELD xmdl009_desc name="input.c.page1.xmdl009_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdl092
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdl092
            #add-point:ON ACTION controlp INFIELD xmdl092 name="input.c.page1.xmdl092"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdl093
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdl093
            #add-point:ON ACTION controlp INFIELD xmdl093 name="input.c.page1.xmdl093"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdl084
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdl084
            #add-point:ON ACTION controlp INFIELD xmdl084 name="input.c.page1.xmdl084"
 
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdl084_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdl084_desc
            #add-point:ON ACTION controlp INFIELD xmdl084_desc name="input.c.page1.xmdl084_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdl014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdl014
            #add-point:ON ACTION controlp INFIELD xmdl014 name="input.c.page1.xmdl014"
            #得出來源成本庫否
            CALL s_axmt600_warehouse_cost(g_xmdl_d[l_ac].xmdl001,g_xmdl_d[l_ac].xmdl002)
            RETURNING l_type                  
            
		      INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		      LET g_qryparam.reqry = FALSE
               
            LET g_qryparam.default1 = g_xmdl_d[l_ac].xmdl014             #給予default值                        

            #串上成本庫否
            IF NOT cl_null(l_type) THEN
               LET g_qryparam.where = "inaa010 = '",l_type,"'"
            END IF

            CALL q_inaa001_2()                                           #呼叫開窗

            LET g_xmdl_d[l_ac].xmdl014 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_xmdl_d[l_ac].xmdl014 TO xmdl014              #顯示到畫面上
            
            CALL s_desc_get_stock_desc(g_xmdl_d[l_ac].xmdlsite,g_xmdl_d[l_ac].xmdl014) RETURNING g_xmdl_d[l_ac].xmdl014_desc
#            CALL s_desc_get_locator_desc(g_xmdk_m.xmdksite,g_xmdl_d[l_ac].xmdl014,g_xmdl_d[l_ac].xmdl015) RETURNING g_xmdl_d[l_ac].xmdl015_desc   #mark--160325-00003 By shiun
            NEXT FIELD xmdl014                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdl015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdl015
            #add-point:ON ACTION controlp INFIELD xmdl015 name="input.c.page1.xmdl015"
            
            IF cl_null(g_xmdl_d[l_ac].xmdl014) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'sub-00126'   #庫位不可為空
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

               NEXT FIELD xmdl014
            END IF
            
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
			
			   LET g_qryparam.arg1 = g_xmdl_d[l_ac].xmdl014
			
			   LET g_qryparam.default1 = g_xmdl_d[l_ac].xmdl015
            
            CALL q_inab002_5()                                           #呼叫開窗

            LET g_xmdl_d[l_ac].xmdl015 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_xmdl_d[l_ac].xmdl015 TO xmdl015              #顯示到畫面上
            
            CALL s_desc_get_locator_desc(g_xmdk_m.xmdksite,g_xmdl_d[l_ac].xmdl014,g_xmdl_d[l_ac].xmdl015) RETURNING g_xmdl_d[l_ac].xmdl015_desc
            NEXT FIELD xmdl015                          #返回原欄位

            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdl016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdl016
            #add-point:ON ACTION controlp INFIELD xmdl016 name="input.c.page1.xmdl016"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdl051
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdl051
            #add-point:ON ACTION controlp INFIELD xmdl051 name="input.c.page1.xmdl051"
                                                                                                            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdl089
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdl089
            #add-point:ON ACTION controlp INFIELD xmdl089 name="input.c.page1.xmdl089"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdl090
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdl090
            #add-point:ON ACTION controlp INFIELD xmdl090 name="input.c.page1.xmdl090"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdl091
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdl091
            #add-point:ON ACTION controlp INFIELD xmdl091 name="input.c.page1.xmdl091"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.ooff013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooff013
            #add-point:ON ACTION controlp INFIELD ooff013 name="input.c.page1.ooff013"
            #161031-00025#28-s
            IF NOT cl_null(g_xmdk_m.xmdkdocno) AND l_ac > 0 THEN
               CALL aooi360_02('7',g_prog,g_xmdk_m.xmdkdocno,g_xmdl_d[l_ac].xmdlseq,'','','','','','','','1')
               CALL s_aooi360_sel('7',g_prog,g_xmdk_m.xmdkdocno,g_xmdl_d[l_ac].xmdlseq,'','','','','','','','1') RETURNING l_success,g_xmdl_d[l_ac].ooff013
               LET g_ooff001_d = '6'   #6.單據單頭備註
               LET g_ooff002_d = g_prog
               LET g_ooff003_d = g_xmdk_m.xmdkdocno   #单号
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
            #161031-00025#28-e
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_xmdl_d[l_ac].* = g_xmdl_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE axmt590_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_xmdl_d[l_ac].xmdlseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_xmdl_d[l_ac].* = g_xmdl_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               CALL axmt590_row_default()
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL axmt590_xmdl_t_mask_restore('restore_mask_o')
      
               UPDATE xmdl_t SET (xmdldocno,xmdlsite,xmdlseq,xmdl001,xmdl002,xmdl003,xmdl004,xmdl005, 
                   xmdl006,xmdl007,xmdl008,xmdl009,xmdl033,xmdl011,xmdl012,xmdl017,xmdl092,xmdl018,xmdl081, 
                   xmdl019,xmdl093,xmdl020,xmdl082,xmdl084,xmdl010,xmdl013,xmdl014,xmdl015,xmdl016,xmdl052, 
                   xmdl021,xmdl022,xmdl083,xmdl030,xmdl031,xmdl032,xmdl051,xmdl089,xmdl090,xmdl091) = (g_xmdk_m.xmdkdocno, 
                   g_xmdl_d[l_ac].xmdlsite,g_xmdl_d[l_ac].xmdlseq,g_xmdl_d[l_ac].xmdl001,g_xmdl_d[l_ac].xmdl002, 
                   g_xmdl_d[l_ac].xmdl003,g_xmdl_d[l_ac].xmdl004,g_xmdl_d[l_ac].xmdl005,g_xmdl_d[l_ac].xmdl006, 
                   g_xmdl_d[l_ac].xmdl007,g_xmdl_d[l_ac].xmdl008,g_xmdl_d[l_ac].xmdl009,g_xmdl_d[l_ac].xmdl033, 
                   g_xmdl_d[l_ac].xmdl011,g_xmdl_d[l_ac].xmdl012,g_xmdl_d[l_ac].xmdl017,g_xmdl_d[l_ac].xmdl092, 
                   g_xmdl_d[l_ac].xmdl018,g_xmdl_d[l_ac].xmdl081,g_xmdl_d[l_ac].xmdl019,g_xmdl_d[l_ac].xmdl093, 
                   g_xmdl_d[l_ac].xmdl020,g_xmdl_d[l_ac].xmdl082,g_xmdl_d[l_ac].xmdl084,g_xmdl_d[l_ac].xmdl010, 
                   g_xmdl_d[l_ac].xmdl013,g_xmdl_d[l_ac].xmdl014,g_xmdl_d[l_ac].xmdl015,g_xmdl_d[l_ac].xmdl016, 
                   g_xmdl_d[l_ac].xmdl052,g_xmdl_d[l_ac].xmdl021,g_xmdl_d[l_ac].xmdl022,g_xmdl_d[l_ac].xmdl083, 
                   g_xmdl_d[l_ac].xmdl030,g_xmdl_d[l_ac].xmdl031,g_xmdl_d[l_ac].xmdl032,g_xmdl_d[l_ac].xmdl051, 
                   g_xmdl_d[l_ac].xmdl089,g_xmdl_d[l_ac].xmdl090,g_xmdl_d[l_ac].xmdl091)
                WHERE xmdlent = g_enterprise AND xmdldocno = g_xmdk_m.xmdkdocno 
 
                  AND xmdlseq = g_xmdl_d_t.xmdlseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #新增多庫儲批
               CALL axmt540_01_xmdm_modify('5',g_xmdl_d[l_ac].xmdlseq,g_xmdk_m.xmdksite,g_xmdk_m.xmdkdocno,g_xmdl_d[l_ac].xmdlseq,
                                           g_xmdl_d[l_ac].xmdl008,g_xmdl_d[l_ac].xmdl009,g_xmdl_d[l_ac].xmdl011,g_xmdl_d[l_ac].xmdl012,
                                           g_xmdl_d[l_ac].xmdl014,g_xmdl_d[l_ac].xmdl015,g_xmdl_d[l_ac].xmdl016,g_xmdl_d[l_ac].xmdl052,
                                           g_xmdl_d[l_ac].xmdl017,g_xmdl_d[l_ac].xmdl018,g_xmdl_d[l_ac].xmdl019,g_xmdl_d[l_ac].xmdl020,
                                           g_xmdl_d[l_ac].xmdl081,g_xmdl_d[l_ac].xmdl082) RETURNING l_success
               IF NOT l_success THEN
                  CALL s_transaction_end('N','0')
                  LET g_xmdl_d[l_ac].* = g_xmdl_d_t.*
               END IF               
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_xmdl_d[l_ac].* = g_xmdl_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xmdl_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_xmdl_d[l_ac].* = g_xmdl_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xmdl_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xmdk_m.xmdkdocno
               LET gs_keys_bak[1] = g_xmdkdocno_t
               LET gs_keys[2] = g_xmdl_d[g_detail_idx].xmdlseq
               LET gs_keys_bak[2] = g_xmdl_d_t.xmdlseq
               CALL axmt590_update_b('xmdl_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL axmt590_xmdl_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_xmdl_d[g_detail_idx].xmdlseq = g_xmdl_d_t.xmdlseq 
 
                  ) THEN
                  LET gs_keys[01] = g_xmdk_m.xmdkdocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_xmdl_d_t.xmdlseq
 
                  CALL axmt590_key_update_b(gs_keys,'xmdl_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_xmdk_m),util.JSON.stringify(g_xmdl_d_t)
               LET g_log2 = util.JSON.stringify(g_xmdk_m),util.JSON.stringify(g_xmdl_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               #161031-00025#28-s
               CALL s_aooi360_del('7',g_prog,g_xmdk_m.xmdkdocno,g_xmdl_d_t.xmdlseq,'','','','','','','','1') RETURNING l_success
               IF NOT cl_null(g_xmdl_d[l_ac].ooff013) THEN
                  CALL s_aooi360_gen('7',g_prog,g_xmdk_m.xmdkdocno,g_xmdl_d[l_ac].xmdlseq,'','','','','','','','1',g_xmdl_d[l_ac].ooff013) RETURNING l_success
               END IF
               #161031-00025#28-e                                                                                                                                       
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
 
            #end add-point
            CALL axmt590_unlock_b("xmdl_t","'1'")
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            #add-point:單身after_row2 name="input.body.after_row2"
            
            #end add-point
              
         AFTER INPUT
            #add-point:input段after input  name="input.body.after_input"
            
            CALL axmt590_b_fill()
            
            #end add-point 
    
         ON ACTION controlo    
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_xmdl_d[li_reproduce_target].* = g_xmdl_d[li_reproduce].*
 
               LET g_xmdl_d[li_reproduce_target].xmdlseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_xmdl_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_xmdl_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
 
      DISPLAY ARRAY g_xmdl3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
    
         BEFORE ROW
            CALL axmt590_idx_chk()
            LET l_ac = DIALOG.getCurrentRow("s_detail3")
            LET g_detail_idx = l_ac
            
            #add-point:page2, before row動作 name="input.body3.before_row"
            
            CALL axmt590_show()
            
            #end add-point
            
         BEFORE DISPLAY
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2',"))
            END IF
            LET g_loc = 'm'
            LET l_ac = DIALOG.getCurrentRow("s_detail3")
            CALL axmt590_idx_chk()
            LET g_current_page = 2
      
         #add-point:page2自定義行為 name="input.body3.action"
         
         #end add-point
      
      END DISPLAY
 
 
 
{</section>}
 
{<section id="axmt590.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      SUBDIALOG aoo_aooi360_01.aooi360_01_input   #备注单身  #161031-00025#28                                                      
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
         #161031-00025#28-s
         #為了修改功能doubleClick可以直接進入單身, 需指定要進入哪一個單身
         IF NOT cl_null(p_cmd) AND p_cmd != 'a' THEN
            CASE g_aw
               WHEN "s_detail1_aooi360_01"
                  NEXT FIELD ooff012     
            END CASE
         END IF
         #161031-00025#28-e                                                                                 
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1',"))      
         CALL DIALOG.setCurrentRow("s_detail3",g_idx_group.getValue("'2',"))
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            
            #end add-point  
            NEXT FIELD xmdkdocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD xmdlsite
               WHEN "s_detail3"
                  NEXT FIELD xmdmsite
 
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
         CALL g_curr_diag.setCurrentRow("s_detail3",1)
 
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
         CALL g_curr_diag.setCurrentRow("s_detail3",1)
 
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
    
   #add-point:input段after input  name="input.after_input"
 
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="axmt590.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION axmt590_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   DEFINE l_success LIKE type_t.num5
   DEFINE l_pmak003 LIKE pmak_t.pmak003   #一次性交易對象名稱   #161207-00033#18 add
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   LET g_xmdk_m_o.* = g_xmdk_m.*      #保存單頭舊值                     
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL axmt590_b_fill() #單身填充
      CALL axmt590_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL axmt590_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   CALL　axmt590_get_pmak003()  #161207-00033#18-add
   
   CALL s_aooi200_get_slip_desc(g_xmdk_m.xmdkdocno) RETURNING g_xmdk_m.xmdkdocno_desc
   DISPLAY BY NAME g_xmdk_m.xmdkdocno_desc

   #end add-point
   
   #遮罩相關處理
   LET g_xmdk_m_mask_o.* =  g_xmdk_m.*
   CALL axmt590_xmdk_t_mask()
   LET g_xmdk_m_mask_n.* =  g_xmdk_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_xmdk_m.xmdk000,g_xmdk_m.xmdksite,g_xmdk_m.xmdkdocno,g_xmdk_m.xmdkdocno_desc,g_xmdk_m.xmdkdocdt, 
       g_xmdk_m.xmdk001,g_xmdk_m.xmdk003,g_xmdk_m.xmdk003_desc,g_xmdk_m.xmdk004,g_xmdk_m.xmdk004_desc, 
       g_xmdk_m.xmdkstus,g_xmdk_m.xmdk081,g_xmdk_m.xmdk005,g_xmdk_m.xmdk006,g_xmdk_m.xmdk002,g_xmdk_m.xmdk007, 
       g_xmdk_m.xmdk007_desc,g_xmdk_m.xmdk009,g_xmdk_m.xmdk009_desc,g_xmdk_m.xmdk008,g_xmdk_m.xmdk008_desc, 
       g_xmdk_m.xmdkownid,g_xmdk_m.xmdkownid_desc,g_xmdk_m.xmdkowndp,g_xmdk_m.xmdkowndp_desc,g_xmdk_m.xmdkcrtid, 
       g_xmdk_m.xmdkcrtid_desc,g_xmdk_m.xmdkcrtdp,g_xmdk_m.xmdkcrtdp_desc,g_xmdk_m.xmdkcrtdt,g_xmdk_m.xmdkmodid, 
       g_xmdk_m.xmdkmodid_desc,g_xmdk_m.xmdkmoddt,g_xmdk_m.xmdkcnfid,g_xmdk_m.xmdkcnfid_desc,g_xmdk_m.xmdkcnfdt, 
       g_xmdk_m.xmdkpstid,g_xmdk_m.xmdkpstid_desc,g_xmdk_m.xmdkpstdt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_xmdk_m.xmdkstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "S"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/posted.png")
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
         WHEN "Z"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unposted.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_xmdl_d.getLength()
      #add-point:show段單身reference name="show.body.reference"

#150123改至b_fill
#      CALL axmt590_xmdl084_ref()
#
#      #產品特徵
#      CALL s_feature_description(g_xmdl_d[l_ac].xmdl008,g_xmdl_d[l_ac].xmdl009) RETURNING l_success,g_xmdl_d[l_ac].xmdl009_desc
#      DISPLAY BY NAME g_xmdl_d[l_ac].xmdl009_desc
#
#      #150120新增"客戶訂單號碼"  earl(s)
#      SELECT xmda033 INTO g_xmdl_d[l_ac].xmda033
#        FROM xmda_t
#       WHERE xmdaent = g_enterprise
#         AND xmdadocno = g_xmdl_d[l_ac].xmdl003
#      #150120新增"客戶訂單號碼"  earl(e)
      
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_xmdl3_d.getLength()
      #add-point:show段單身reference name="show.body3.reference"

#150123改至b_fill
#      #產品特徵
#      CALL s_feature_description(g_xmdl3_d[l_ac].xmdm001,g_xmdl3_d[l_ac].xmdm002) RETURNING l_success,g_xmdl3_d[l_ac].xmdm002_desc
#      DISPLAY BY NAME g_xmdl3_d[l_ac].xmdm002_desc

      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other name="show.other"
                           
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL axmt590_detail_show()
 
   #add-point:show段之後 name="show.after"
   IF g_xmdl_d.getLength() > 0 THEN
      IF cl_null(g_xmdl_d[g_xmdl_d.getLength()].xmdlseq) THEN
         CALL g_xmdl_d.deleteElement(g_xmdl_d.getLength())
      END IF
   END IF                
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="axmt590.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION axmt590_detail_show()
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
 
{<section id="axmt590.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION axmt590_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE xmdk_t.xmdkdocno 
   DEFINE l_oldno     LIKE xmdk_t.xmdkdocno 
 
   DEFINE l_master    RECORD LIKE xmdk_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE xmdl_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE xmdm_t.* #此變數樣板目前無使用
 
 
 
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
   
   IF g_xmdk_m.xmdkdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_xmdkdocno_t = g_xmdk_m.xmdkdocno
 
    
   LET g_xmdk_m.xmdkdocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_xmdk_m.xmdkownid = g_user
      LET g_xmdk_m.xmdkowndp = g_dept
      LET g_xmdk_m.xmdkcrtid = g_user
      LET g_xmdk_m.xmdkcrtdp = g_dept 
      LET g_xmdk_m.xmdkcrtdt = cl_get_current()
      LET g_xmdk_m.xmdkmodid = g_user
      LET g_xmdk_m.xmdkmoddt = cl_get_current()
      LET g_xmdk_m.xmdkstus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
 
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_xmdk_m.xmdkstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "S"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/posted.png")
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
         WHEN "Z"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unposted.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
      LET g_xmdk_m.xmdkdocno_desc = ''
   DISPLAY BY NAME g_xmdk_m.xmdkdocno_desc
 
   
   CALL axmt590_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_xmdk_m.* TO NULL
      INITIALIZE g_xmdl_d TO NULL
      INITIALIZE g_xmdl3_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL axmt590_show()
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
   CALL axmt590_set_act_visible()   
   CALL axmt590_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_xmdkdocno_t = g_xmdk_m.xmdkdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " xmdkent = " ||g_enterprise|| " AND",
                      " xmdkdocno = '", g_xmdk_m.xmdkdocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL axmt590_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
                           
   #end add-point
   
   CALL axmt590_idx_chk()
   
   LET g_data_owner = g_xmdk_m.xmdkownid      
   LET g_data_dept  = g_xmdk_m.xmdkowndp
   
   #功能已完成,通報訊息中心
   CALL axmt590_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="axmt590.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION axmt590_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE xmdl_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE xmdm_t.* #此變數樣板目前無使用
 
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
                           
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE axmt590_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
                           
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM xmdl_t
    WHERE xmdlent = g_enterprise AND xmdldocno = g_xmdkdocno_t
 
    INTO TEMP axmt590_detail
 
   #將key修正為調整後   
   UPDATE axmt590_detail 
      #更新key欄位
      SET xmdldocno = g_xmdk_m.xmdkdocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO xmdl_t SELECT * FROM axmt590_detail
   
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
   DROP TABLE axmt590_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
                           
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table2.b_insert"
                           
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM xmdm_t 
    WHERE xmdment = g_enterprise AND xmdmdocno = g_xmdkdocno_t
 
    INTO TEMP axmt590_detail
 
   #將key修正為調整後   
   UPDATE axmt590_detail SET xmdmdocno = g_xmdk_m.xmdkdocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table2.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO xmdm_t SELECT * FROM axmt590_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table2.m_insert"
                           
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE axmt590_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table2.a_insert"
                           
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_xmdkdocno_t = g_xmdk_m.xmdkdocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="axmt590.delete" >}
#+ 資料刪除
PRIVATE FUNCTION axmt590_delete()
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
   
   IF g_xmdk_m.xmdkdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN axmt590_cl USING g_enterprise,g_xmdk_m.xmdkdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axmt590_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE axmt590_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE axmt590_master_referesh USING g_xmdk_m.xmdkdocno INTO g_xmdk_m.xmdk000,g_xmdk_m.xmdksite, 
       g_xmdk_m.xmdkdocno,g_xmdk_m.xmdkdocdt,g_xmdk_m.xmdk001,g_xmdk_m.xmdk003,g_xmdk_m.xmdk004,g_xmdk_m.xmdkstus, 
       g_xmdk_m.xmdk081,g_xmdk_m.xmdk005,g_xmdk_m.xmdk006,g_xmdk_m.xmdk002,g_xmdk_m.xmdk007,g_xmdk_m.xmdk009, 
       g_xmdk_m.xmdk008,g_xmdk_m.xmdkownid,g_xmdk_m.xmdkowndp,g_xmdk_m.xmdkcrtid,g_xmdk_m.xmdkcrtdp, 
       g_xmdk_m.xmdkcrtdt,g_xmdk_m.xmdkmodid,g_xmdk_m.xmdkmoddt,g_xmdk_m.xmdkcnfid,g_xmdk_m.xmdkcnfdt, 
       g_xmdk_m.xmdkpstid,g_xmdk_m.xmdkpstdt,g_xmdk_m.xmdk003_desc,g_xmdk_m.xmdk004_desc,g_xmdk_m.xmdk007_desc, 
       g_xmdk_m.xmdk009_desc,g_xmdk_m.xmdk008_desc,g_xmdk_m.xmdkownid_desc,g_xmdk_m.xmdkowndp_desc,g_xmdk_m.xmdkcrtid_desc, 
       g_xmdk_m.xmdkcrtdp_desc,g_xmdk_m.xmdkmodid_desc,g_xmdk_m.xmdkcnfid_desc,g_xmdk_m.xmdkpstid_desc 
 
   
   
   #檢查是否允許此動作
   IF NOT axmt590_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_xmdk_m_mask_o.* =  g_xmdk_m.*
   CALL axmt590_xmdk_t_mask()
   LET g_xmdk_m_mask_n.* =  g_xmdk_m.*
   
   CALL axmt590_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
                                                      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL axmt590_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_xmdkdocno_t = g_xmdk_m.xmdkdocno
 
 
      DELETE FROM xmdk_t
       WHERE xmdkent = g_enterprise AND xmdkdocno = g_xmdk_m.xmdkdocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
                                                      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_xmdk_m.xmdkdocno,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"

      IF NOT s_aooi200_del_docno(g_xmdk_m.xmdkdocno,g_xmdk_m.xmdkdocdt) THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      #161031-00025#28-s mrak
      #刪除備註
#      CALL s_aooi360_del('6',g_prog,g_xmdk_m.xmdkdocno,'','','','','','','','','4') RETURNING l_success
#      IF NOT l_success THEN
#         CALL s_transaction_end('N','0')
#         RETURN
#      END IF
      #161031-00025#28-e mrak
      #161031-00025#28-s
      #单头的aooi360_01的备注单身资料同步删除
      DELETE FROM ooff_t
       WHERE ooffent = g_enterprise AND ooff001 IN ('6','7')
         AND ooff002 = g_prog AND ooff003 = g_xmdk_m.xmdkdocno
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_xmdk_m.xmdkdocno,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         CALL s_transaction_end('N','0')
         RETURN
      END IF   
      CALL aooi360_01_clear_detail()   #清除备注单身  
      #161031-00025#28-e      
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
                                                      
      #end add-point
      
      DELETE FROM xmdl_t
       WHERE xmdlent = g_enterprise AND xmdldocno = g_xmdk_m.xmdkdocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
                                                      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xmdl_t:",SQLERRMESSAGE 
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
      DELETE FROM xmdm_t
       WHERE xmdment = g_enterprise AND
             xmdmdocno = g_xmdk_m.xmdkdocno
      #add-point:單身刪除中 name="delete.body.m_delete2"
                                                      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xmdm_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete2"
                                                      
      #end add-point
 
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_xmdk_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE axmt590_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_xmdl_d.clear() 
      CALL g_xmdl3_d.clear()       
 
     
      CALL axmt590_ui_browser_refresh()  
      #CALL axmt590_ui_headershow()  
      #CALL axmt590_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL axmt590_browser_fill("")
         CALL axmt590_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE axmt590_cl
 
   #功能已完成,通報訊息中心
   CALL axmt590_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="axmt590.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axmt590_b_fill()
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
   CALL g_xmdl_d.clear()
   CALL g_xmdl3_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
 
   #end add-point
   
   #判斷是否填充
   IF axmt590_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT xmdlsite,xmdlseq,xmdl001,xmdl002,xmdl003,xmdl004,xmdl005,xmdl006, 
             xmdl007,xmdl008,xmdl009,xmdl033,xmdl011,xmdl012,xmdl017,xmdl092,xmdl018,xmdl081,xmdl019, 
             xmdl093,xmdl020,xmdl082,xmdl084,xmdl010,xmdl013,xmdl014,xmdl015,xmdl016,xmdl052,xmdl021, 
             xmdl022,xmdl083,xmdl030,xmdl031,xmdl032,xmdl051,xmdl089,xmdl090,xmdl091 ,t1.imaal003 ,t2.imaal004 , 
             t5.oocql004 ,t6.oocal003 ,t7.oocal003 ,t8.inayl003 ,t9.inab003 ,t10.oocal003 ,t11.pjbal003 , 
             t12.pjbbl004 ,t13.pjbml004 FROM xmdl_t",   
                     " INNER JOIN xmdk_t ON xmdkent = " ||g_enterprise|| " AND xmdkdocno = xmdldocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN imaal_t t1 ON t1.imaalent="||g_enterprise||" AND t1.imaal001=xmdl008 AND t1.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t2 ON t2.imaalent="||g_enterprise||" AND t2.imaal001=xmdl008 AND t2.imaal002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t5 ON t5.oocqlent="||g_enterprise||" AND t5.oocql001='221' AND t5.oocql002=xmdl011 AND t5.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t6 ON t6.oocalent="||g_enterprise||" AND t6.oocal001=xmdl017 AND t6.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t7 ON t7.oocalent="||g_enterprise||" AND t7.oocal001=xmdl019 AND t7.oocal002='"||g_dlang||"' ",
               " LEFT JOIN inayl_t t8 ON t8.inaylent="||g_enterprise||" AND t8.inayl001=xmdl014 AND t8.inayl002='"||g_dlang||"' ",
               " LEFT JOIN inab_t t9 ON t9.inabent="||g_enterprise||" AND t9.inabsite=xmdlsite AND t9.inab001=xmdl014 AND t9.inab002=xmdl015  ",
               " LEFT JOIN oocal_t t10 ON t10.oocalent="||g_enterprise||" AND t10.oocal001=xmdl021 AND t10.oocal002='"||g_dlang||"' ",
               " LEFT JOIN pjbal_t t11 ON t11.pjbalent="||g_enterprise||" AND t11.pjbal001=xmdl030 AND t11.pjbal002='"||g_dlang||"' ",
               " LEFT JOIN pjbbl_t t12 ON t12.pjbblent="||g_enterprise||" AND t12.pjbbl001=xmdl030 AND t12.pjbbl002=xmdl031 AND t12.pjbbl003='"||g_dlang||"' ",
               " LEFT JOIN pjbml_t t13 ON t13.pjbmlent="||g_enterprise||" AND t13.pjbml001=xmdl030 AND t13.pjbml002=xmdl032 AND t13.pjbml003='"||g_dlang||"' ",
 
                     " WHERE xmdlent=? AND xmdldocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         #161031-00025#28-s
         LET g_sql = "SELECT  DISTINCT xmdlsite,xmdlseq,xmdl001,xmdl002,xmdl003,xmdl004,xmdl005,xmdl006, 
             xmdl007,xmdl008,xmdl009,xmdl033,xmdl011,xmdl012,xmdl017,xmdl092,xmdl018,xmdl081,xmdl019, 
             xmdl093,xmdl020,xmdl082,xmdl084,xmdl010,xmdl013,xmdl014,xmdl015,xmdl016,xmdl052,xmdl021, 
             xmdl022,xmdl083,xmdl030,xmdl031,xmdl032,xmdl051,xmdl089,xmdl090,xmdl091 ,t1.imaal003 ,t2.imaal004 , 
             t5.oocql004 ,t6.oocal003 ,t7.oocal003 ,t8.inayl003 ,t9.inab003 ,t10.oocal003 ,t11.pjbal003 , 
             t12.pjbbl004 ,t13.pjbml004 FROM xmdl_t",   
                     " INNER JOIN xmdk_t ON xmdkent = " ||g_enterprise|| " AND xmdkdocno = xmdldocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN imaal_t t1 ON t1.imaalent="||g_enterprise||" AND t1.imaal001=xmdl008 AND t1.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t2 ON t2.imaalent="||g_enterprise||" AND t2.imaal001=xmdl008 AND t2.imaal002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t5 ON t5.oocqlent="||g_enterprise||" AND t5.oocql001='221' AND t5.oocql002=xmdl011 AND t5.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t6 ON t6.oocalent="||g_enterprise||" AND t6.oocal001=xmdl017 AND t6.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t7 ON t7.oocalent="||g_enterprise||" AND t7.oocal001=xmdl019 AND t7.oocal002='"||g_dlang||"' ",
               " LEFT JOIN inayl_t t8 ON t8.inaylent="||g_enterprise||" AND t8.inayl001=xmdl014 AND t8.inayl002='"||g_dlang||"' ",
               " LEFT JOIN inab_t t9 ON t9.inabent="||g_enterprise||" AND t9.inabsite=xmdlsite AND t9.inab001=xmdl014 AND t9.inab002=xmdl015  ",
               " LEFT JOIN oocal_t t10 ON t10.oocalent="||g_enterprise||" AND t10.oocal001=xmdl021 AND t10.oocal002='"||g_dlang||"' ",
               " LEFT JOIN pjbal_t t11 ON t11.pjbalent="||g_enterprise||" AND t11.pjbal001=xmdl030 AND t11.pjbal002='"||g_dlang||"' ",
               " LEFT JOIN pjbbl_t t12 ON t12.pjbblent="||g_enterprise||" AND t12.pjbbl001=xmdl030 AND t12.pjbbl002=xmdl031 AND t12.pjbbl003='"||g_dlang||"' ",
               " LEFT JOIN pjbml_t t13 ON t13.pjbmlent="||g_enterprise||" AND t13.pjbml001=xmdl030 AND t13.pjbml002=xmdl032 AND t13.pjbml003='"||g_dlang||"' ",
               " LEFT JOIN ooff_t  ON ooffent="||g_enterprise||" AND ooff002 = '",g_prog,"' AND ooff003 = xmdldocno AND ooff004 = xmdlseq",  
                     " WHERE xmdlent=? AND xmdldocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料 
         #161031-00025#28-e         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY xmdl_t.xmdlseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
                                                      
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE axmt590_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR axmt590_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_xmdk_m.xmdkdocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_xmdk_m.xmdkdocno INTO g_xmdl_d[l_ac].xmdlsite,g_xmdl_d[l_ac].xmdlseq, 
          g_xmdl_d[l_ac].xmdl001,g_xmdl_d[l_ac].xmdl002,g_xmdl_d[l_ac].xmdl003,g_xmdl_d[l_ac].xmdl004, 
          g_xmdl_d[l_ac].xmdl005,g_xmdl_d[l_ac].xmdl006,g_xmdl_d[l_ac].xmdl007,g_xmdl_d[l_ac].xmdl008, 
          g_xmdl_d[l_ac].xmdl009,g_xmdl_d[l_ac].xmdl033,g_xmdl_d[l_ac].xmdl011,g_xmdl_d[l_ac].xmdl012, 
          g_xmdl_d[l_ac].xmdl017,g_xmdl_d[l_ac].xmdl092,g_xmdl_d[l_ac].xmdl018,g_xmdl_d[l_ac].xmdl081, 
          g_xmdl_d[l_ac].xmdl019,g_xmdl_d[l_ac].xmdl093,g_xmdl_d[l_ac].xmdl020,g_xmdl_d[l_ac].xmdl082, 
          g_xmdl_d[l_ac].xmdl084,g_xmdl_d[l_ac].xmdl010,g_xmdl_d[l_ac].xmdl013,g_xmdl_d[l_ac].xmdl014, 
          g_xmdl_d[l_ac].xmdl015,g_xmdl_d[l_ac].xmdl016,g_xmdl_d[l_ac].xmdl052,g_xmdl_d[l_ac].xmdl021, 
          g_xmdl_d[l_ac].xmdl022,g_xmdl_d[l_ac].xmdl083,g_xmdl_d[l_ac].xmdl030,g_xmdl_d[l_ac].xmdl031, 
          g_xmdl_d[l_ac].xmdl032,g_xmdl_d[l_ac].xmdl051,g_xmdl_d[l_ac].xmdl089,g_xmdl_d[l_ac].xmdl090, 
          g_xmdl_d[l_ac].xmdl091,g_xmdl_d[l_ac].xmdl008_desc,g_xmdl_d[l_ac].xmdl008_desc_desc,g_xmdl_d[l_ac].xmdl011_desc, 
          g_xmdl_d[l_ac].xmdl017_desc,g_xmdl_d[l_ac].xmdl019_desc,g_xmdl_d[l_ac].xmdl014_desc,g_xmdl_d[l_ac].xmdl015_desc, 
          g_xmdl_d[l_ac].xmdl021_desc,g_xmdl_d[l_ac].xmdl030_desc,g_xmdl_d[l_ac].xmdl031_desc,g_xmdl_d[l_ac].xmdl032_desc  
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
         CALL axmt590_xmdl084_ref()

         #產品特徵
         CALL s_feature_description(g_xmdl_d[l_ac].xmdl008,g_xmdl_d[l_ac].xmdl009) RETURNING l_success,g_xmdl_d[l_ac].xmdl009_desc
         CALL s_lot_b_fill('1',g_site,'2',g_xmdk_m.xmdkdocno,g_xmdl_d[l_ac].xmdlseq,'1','1')    #add by lixh 20150915
         #150120新增"客戶訂單號碼"  earl(s)
         SELECT xmda033 INTO g_xmdl_d[l_ac].xmda033
           FROM xmda_t
          WHERE xmdaent = g_enterprise
            AND xmdadocno = g_xmdl_d[l_ac].xmdl003
         #150120新增"客戶訂單號碼"  earl(e)
      
         #add by lixiang 2015/06/18--s--
         CALL s_desc_get_project_desc(g_xmdl_d[l_ac].xmdl030) RETURNING g_xmdl_d[l_ac].xmdl030_desc
         DISPLAY BY NAME g_xmdl_d[l_ac].xmdl030_desc

         CALL s_desc_get_wbs_desc(g_xmdl_d[l_ac].xmdl030,g_xmdl_d[l_ac].xmdl031) RETURNING g_xmdl_d[l_ac].xmdl031_desc
         DISPLAY BY NAME g_xmdl_d[l_ac].xmdl031_desc

         CALL s_desc_get_activity_desc(g_xmdl_d[l_ac].xmdl030,g_xmdl_d[l_ac].xmdl032) RETURNING g_xmdl_d[l_ac].xmdl032_desc
         DISPLAY BY NAME g_xmdl_d[l_ac].xmdl032_desc
         #add by lixiang 2015/06/18--e--
         
         #150814 By TSD.david------(S)
         SELECT pmao009,pmao010
           INTO g_xmdl_d[l_ac].xmdl033_desc,g_xmdl_d[l_ac].xmdl033_desc_desc
           FROM pmao_t
          WHERE pmaoent = g_enterprise
            AND pmao001 = g_xmdk_m.xmdk007
            AND pmao002 = g_xmdl_d[l_ac].xmdl008
            AND pmao003 = g_xmdl_d[l_ac].xmdl009
            AND pmao004 = g_xmdl_d[l_ac].xmdl033   
            AND pmao000 = '2' #161221-00064#18 add            
         DISPLAY BY NAME g_xmdl_d[l_ac].xmdl033_desc,g_xmdl_d[l_ac].xmdl033_desc_desc
         #150814 By TSD.david------(E)
         #161031-00025#28-s
         CALL s_aooi360_sel('7',g_prog,g_xmdk_m.xmdkdocno,g_xmdl_d[l_ac].xmdlseq,'','','','','','','','1') RETURNING l_success,g_xmdl_d[l_ac].ooff013
         #161031-00025#28-e
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
   IF axmt590_fill_chk(2) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body2.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT xmdmsite,xmdmseq,xmdmseq1,xmdm001,xmdm002,xmdm003,xmdm004,xmdm005, 
             xmdm006,xmdm007,xmdm033,xmdm008,xmdm031,xmdm010,xmdm032 ,t14.imaal003 ,t15.imaal004 ,t16.inayl003 , 
             t17.inab003 ,t18.oocal003 ,t19.oocal003 FROM xmdm_t",   
                     " INNER JOIN  xmdk_t ON xmdkent = " ||g_enterprise|| " AND xmdkdocno = xmdmdocno ",
 
                     "",
                     
                                    " LEFT JOIN imaal_t t14 ON t14.imaalent="||g_enterprise||" AND t14.imaal001=xmdm001 AND t14.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t15 ON t15.imaalent="||g_enterprise||" AND t15.imaal001=xmdm001 AND t15.imaal002='"||g_dlang||"' ",
               " LEFT JOIN inayl_t t16 ON t16.inaylent="||g_enterprise||" AND t16.inayl001=xmdm005 AND t16.inayl002='"||g_dlang||"' ",
               " LEFT JOIN inab_t t17 ON t17.inabent="||g_enterprise||" AND t17.inabsite=xmdmsite AND t17.inab001=xmdm005 AND t17.inab002=xmdm006  ",
               " LEFT JOIN oocal_t t18 ON t18.oocalent="||g_enterprise||" AND t18.oocal001=xmdm008 AND t18.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t19 ON t19.oocalent="||g_enterprise||" AND t19.oocal001=xmdm010 AND t19.oocal002='"||g_dlang||"' ",
 
                     " WHERE xmdment=? AND xmdmdocno=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body2.fill_sql"
                                                      
         #end add-point
         IF NOT cl_null(g_wc2_table2) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY xmdm_t.xmdmseq,xmdm_t.xmdmseq1"
         
         #add-point:單身填充控制 name="b_fill.sql2"
                                                      
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE axmt590_pb2 FROM g_sql
         DECLARE b_fill_cs2 CURSOR FOR axmt590_pb2
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs2 USING g_enterprise,g_xmdk_m.xmdkdocno   #(ver:78)
                                               
      FOREACH b_fill_cs2 USING g_enterprise,g_xmdk_m.xmdkdocno INTO g_xmdl3_d[l_ac].xmdmsite,g_xmdl3_d[l_ac].xmdmseq, 
          g_xmdl3_d[l_ac].xmdmseq1,g_xmdl3_d[l_ac].xmdm001,g_xmdl3_d[l_ac].xmdm002,g_xmdl3_d[l_ac].xmdm003, 
          g_xmdl3_d[l_ac].xmdm004,g_xmdl3_d[l_ac].xmdm005,g_xmdl3_d[l_ac].xmdm006,g_xmdl3_d[l_ac].xmdm007, 
          g_xmdl3_d[l_ac].xmdm033,g_xmdl3_d[l_ac].xmdm008,g_xmdl3_d[l_ac].xmdm031,g_xmdl3_d[l_ac].xmdm010, 
          g_xmdl3_d[l_ac].xmdm032,g_xmdl3_d[l_ac].xmdm001_desc,g_xmdl3_d[l_ac].xmdm001_desc_desc,g_xmdl3_d[l_ac].xmdm005_desc, 
          g_xmdl3_d[l_ac].xmdm006_desc,g_xmdl3_d[l_ac].xmdm008_desc,g_xmdl3_d[l_ac].xmdm010_desc   #(ver:78) 
 
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill2.fill"
      
         #產品特徵
         CALL s_feature_description(g_xmdl3_d[l_ac].xmdm001,g_xmdl3_d[l_ac].xmdm002) RETURNING l_success,g_xmdl3_d[l_ac].xmdm002_desc
         CALL s_lot_b_fill('1',g_site,'2',g_xmdk_m.xmdkdocno,g_xmdl3_d[l_ac].xmdmseq,g_xmdl3_d[l_ac].xmdmseq1,'1')   #add by lixh 20150915
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
   #161031-00025#28-s
   LET g_ooff001_d = '6'   #6.單據單頭備註
   LET g_ooff002_d = g_prog
   LET g_ooff003_d = g_xmdk_m.xmdkdocno   #单号
   LET g_ooff004_d = '0'     #项次
   LET g_ooff005_d = ' '
   LET g_ooff006_d = ' '
   LET g_ooff007_d = ' '
   LET g_ooff008_d = ' '
   LET g_ooff009_d = ' '
   LET g_ooff010_d = ' '
   LET g_ooff011_d = ' '
   CALL aooi360_01_b_fill(g_ooff001_d,g_ooff002_d,g_ooff003_d,g_ooff004_d,g_ooff005_d,g_ooff006_d,g_ooff007_d,g_ooff008_d,g_ooff009_d,g_ooff010_d,g_ooff011_d)   #备注单身 
   #161031-00025#28-e                                                       
   #end add-point
   
   CALL g_xmdl_d.deleteElement(g_xmdl_d.getLength())
   CALL g_xmdl3_d.deleteElement(g_xmdl3_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE axmt590_pb
   FREE axmt590_pb2
 
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_xmdl_d.getLength()
      LET g_xmdl_d_mask_o[l_ac].* =  g_xmdl_d[l_ac].*
      CALL axmt590_xmdl_t_mask()
      LET g_xmdl_d_mask_n[l_ac].* =  g_xmdl_d[l_ac].*
   END FOR
   
   LET g_xmdl3_d_mask_o.* =  g_xmdl3_d.*
   FOR l_ac = 1 TO g_xmdl3_d.getLength()
      LET g_xmdl3_d_mask_o[l_ac].* =  g_xmdl3_d[l_ac].*
      CALL axmt590_xmdm_t_mask()
      LET g_xmdl3_d_mask_n[l_ac].* =  g_xmdl3_d[l_ac].*
   END FOR
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="axmt590.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION axmt590_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM xmdl_t
       WHERE xmdlent = g_enterprise AND
         xmdldocno = ps_keys_bak[1] AND xmdlseq = ps_keys_bak[2]
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
         CALL g_xmdl_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete2"
                                                      
      #end add-point    
      DELETE FROM xmdm_t
       WHERE xmdment = g_enterprise AND
             xmdmdocno = ps_keys_bak[1] AND xmdmseq = ps_keys_bak[2] AND xmdmseq1 = ps_keys_bak[3]
      #add-point:delete_b段刪除中 name="delete_b.m_delete2"
                                                      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xmdm_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_xmdl3_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete2"
                                                      
      #end add-point    
   END IF
 
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
                           
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="axmt590.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION axmt590_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO xmdl_t
                  (xmdlent,
                   xmdldocno,
                   xmdlseq
                   ,xmdlsite,xmdl001,xmdl002,xmdl003,xmdl004,xmdl005,xmdl006,xmdl007,xmdl008,xmdl009,xmdl033,xmdl011,xmdl012,xmdl017,xmdl092,xmdl018,xmdl081,xmdl019,xmdl093,xmdl020,xmdl082,xmdl084,xmdl010,xmdl013,xmdl014,xmdl015,xmdl016,xmdl052,xmdl021,xmdl022,xmdl083,xmdl030,xmdl031,xmdl032,xmdl051,xmdl089,xmdl090,xmdl091) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_xmdl_d[g_detail_idx].xmdlsite,g_xmdl_d[g_detail_idx].xmdl001,g_xmdl_d[g_detail_idx].xmdl002, 
                       g_xmdl_d[g_detail_idx].xmdl003,g_xmdl_d[g_detail_idx].xmdl004,g_xmdl_d[g_detail_idx].xmdl005, 
                       g_xmdl_d[g_detail_idx].xmdl006,g_xmdl_d[g_detail_idx].xmdl007,g_xmdl_d[g_detail_idx].xmdl008, 
                       g_xmdl_d[g_detail_idx].xmdl009,g_xmdl_d[g_detail_idx].xmdl033,g_xmdl_d[g_detail_idx].xmdl011, 
                       g_xmdl_d[g_detail_idx].xmdl012,g_xmdl_d[g_detail_idx].xmdl017,g_xmdl_d[g_detail_idx].xmdl092, 
                       g_xmdl_d[g_detail_idx].xmdl018,g_xmdl_d[g_detail_idx].xmdl081,g_xmdl_d[g_detail_idx].xmdl019, 
                       g_xmdl_d[g_detail_idx].xmdl093,g_xmdl_d[g_detail_idx].xmdl020,g_xmdl_d[g_detail_idx].xmdl082, 
                       g_xmdl_d[g_detail_idx].xmdl084,g_xmdl_d[g_detail_idx].xmdl010,g_xmdl_d[g_detail_idx].xmdl013, 
                       g_xmdl_d[g_detail_idx].xmdl014,g_xmdl_d[g_detail_idx].xmdl015,g_xmdl_d[g_detail_idx].xmdl016, 
                       g_xmdl_d[g_detail_idx].xmdl052,g_xmdl_d[g_detail_idx].xmdl021,g_xmdl_d[g_detail_idx].xmdl022, 
                       g_xmdl_d[g_detail_idx].xmdl083,g_xmdl_d[g_detail_idx].xmdl030,g_xmdl_d[g_detail_idx].xmdl031, 
                       g_xmdl_d[g_detail_idx].xmdl032,g_xmdl_d[g_detail_idx].xmdl051,g_xmdl_d[g_detail_idx].xmdl089, 
                       g_xmdl_d[g_detail_idx].xmdl090,g_xmdl_d[g_detail_idx].xmdl091)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
                                                      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xmdl_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_xmdl_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
                                                      
      #end add-point 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert2"
                                                      
      #end add-point 
      INSERT INTO xmdm_t
                  (xmdment,
                   xmdmdocno,
                   xmdmseq,xmdmseq1
                   ,xmdmsite,xmdm001,xmdm002,xmdm003,xmdm004,xmdm005,xmdm006,xmdm007,xmdm033,xmdm008,xmdm031,xmdm010,xmdm032) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_xmdl3_d[g_detail_idx].xmdmsite,g_xmdl3_d[g_detail_idx].xmdm001,g_xmdl3_d[g_detail_idx].xmdm002, 
                       g_xmdl3_d[g_detail_idx].xmdm003,g_xmdl3_d[g_detail_idx].xmdm004,g_xmdl3_d[g_detail_idx].xmdm005, 
                       g_xmdl3_d[g_detail_idx].xmdm006,g_xmdl3_d[g_detail_idx].xmdm007,g_xmdl3_d[g_detail_idx].xmdm033, 
                       g_xmdl3_d[g_detail_idx].xmdm008,g_xmdl3_d[g_detail_idx].xmdm031,g_xmdl3_d[g_detail_idx].xmdm010, 
                       g_xmdl3_d[g_detail_idx].xmdm032)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert2"
                                                      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xmdm_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_xmdl3_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert2"
                                                      
      #end add-point
   END IF
 
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
                           
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="axmt590.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION axmt590_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "xmdl_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
                                                      
      #end add-point 
      
      #將遮罩欄位還原
      CALL axmt590_xmdl_t_mask_restore('restore_mask_o')
               
      UPDATE xmdl_t 
         SET (xmdldocno,
              xmdlseq
              ,xmdlsite,xmdl001,xmdl002,xmdl003,xmdl004,xmdl005,xmdl006,xmdl007,xmdl008,xmdl009,xmdl033,xmdl011,xmdl012,xmdl017,xmdl092,xmdl018,xmdl081,xmdl019,xmdl093,xmdl020,xmdl082,xmdl084,xmdl010,xmdl013,xmdl014,xmdl015,xmdl016,xmdl052,xmdl021,xmdl022,xmdl083,xmdl030,xmdl031,xmdl032,xmdl051,xmdl089,xmdl090,xmdl091) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_xmdl_d[g_detail_idx].xmdlsite,g_xmdl_d[g_detail_idx].xmdl001,g_xmdl_d[g_detail_idx].xmdl002, 
                  g_xmdl_d[g_detail_idx].xmdl003,g_xmdl_d[g_detail_idx].xmdl004,g_xmdl_d[g_detail_idx].xmdl005, 
                  g_xmdl_d[g_detail_idx].xmdl006,g_xmdl_d[g_detail_idx].xmdl007,g_xmdl_d[g_detail_idx].xmdl008, 
                  g_xmdl_d[g_detail_idx].xmdl009,g_xmdl_d[g_detail_idx].xmdl033,g_xmdl_d[g_detail_idx].xmdl011, 
                  g_xmdl_d[g_detail_idx].xmdl012,g_xmdl_d[g_detail_idx].xmdl017,g_xmdl_d[g_detail_idx].xmdl092, 
                  g_xmdl_d[g_detail_idx].xmdl018,g_xmdl_d[g_detail_idx].xmdl081,g_xmdl_d[g_detail_idx].xmdl019, 
                  g_xmdl_d[g_detail_idx].xmdl093,g_xmdl_d[g_detail_idx].xmdl020,g_xmdl_d[g_detail_idx].xmdl082, 
                  g_xmdl_d[g_detail_idx].xmdl084,g_xmdl_d[g_detail_idx].xmdl010,g_xmdl_d[g_detail_idx].xmdl013, 
                  g_xmdl_d[g_detail_idx].xmdl014,g_xmdl_d[g_detail_idx].xmdl015,g_xmdl_d[g_detail_idx].xmdl016, 
                  g_xmdl_d[g_detail_idx].xmdl052,g_xmdl_d[g_detail_idx].xmdl021,g_xmdl_d[g_detail_idx].xmdl022, 
                  g_xmdl_d[g_detail_idx].xmdl083,g_xmdl_d[g_detail_idx].xmdl030,g_xmdl_d[g_detail_idx].xmdl031, 
                  g_xmdl_d[g_detail_idx].xmdl032,g_xmdl_d[g_detail_idx].xmdl051,g_xmdl_d[g_detail_idx].xmdl089, 
                  g_xmdl_d[g_detail_idx].xmdl090,g_xmdl_d[g_detail_idx].xmdl091) 
         WHERE xmdlent = g_enterprise AND xmdldocno = ps_keys_bak[1] AND xmdlseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
                                                      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xmdl_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xmdl_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL axmt590_xmdl_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
                                                      
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
   
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "xmdm_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update2"
                                                      
      #end add-point  
      
      #將遮罩欄位還原
      CALL axmt590_xmdm_t_mask_restore('restore_mask_o')
               
      UPDATE xmdm_t 
         SET (xmdmdocno,
              xmdmseq,xmdmseq1
              ,xmdmsite,xmdm001,xmdm002,xmdm003,xmdm004,xmdm005,xmdm006,xmdm007,xmdm033,xmdm008,xmdm031,xmdm010,xmdm032) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_xmdl3_d[g_detail_idx].xmdmsite,g_xmdl3_d[g_detail_idx].xmdm001,g_xmdl3_d[g_detail_idx].xmdm002, 
                  g_xmdl3_d[g_detail_idx].xmdm003,g_xmdl3_d[g_detail_idx].xmdm004,g_xmdl3_d[g_detail_idx].xmdm005, 
                  g_xmdl3_d[g_detail_idx].xmdm006,g_xmdl3_d[g_detail_idx].xmdm007,g_xmdl3_d[g_detail_idx].xmdm033, 
                  g_xmdl3_d[g_detail_idx].xmdm008,g_xmdl3_d[g_detail_idx].xmdm031,g_xmdl3_d[g_detail_idx].xmdm010, 
                  g_xmdl3_d[g_detail_idx].xmdm032) 
         WHERE xmdment = g_enterprise AND xmdmdocno = ps_keys_bak[1] AND xmdmseq = ps_keys_bak[2] AND xmdmseq1 = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update2"
                                                      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xmdm_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xmdm_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL axmt590_xmdm_t_mask_restore('restore_mask_n')
 
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
 
{<section id="axmt590.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION axmt590_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="axmt590.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION axmt590_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="axmt590.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION axmt590_lock_b(ps_table,ps_page)
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
   #CALL axmt590_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "xmdl_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN axmt590_bcl USING g_enterprise,
                                       g_xmdk_m.xmdkdocno,g_xmdl_d[g_detail_idx].xmdlseq     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "axmt590_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
                                    
   #鎖定整組table
   #LET ls_group = "'2',"
   #僅鎖定自身table
   LET ls_group = "xmdm_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN axmt590_bcl2 USING g_enterprise,
                                             g_xmdk_m.xmdkdocno,g_xmdl3_d[g_detail_idx].xmdmseq,g_xmdl3_d[g_detail_idx].xmdmseq1 
 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "axmt590_bcl2:",SQLERRMESSAGE 
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
 
{<section id="axmt590.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION axmt590_unlock_b(ps_table,ps_page)
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
      CLOSE axmt590_bcl
   END IF
   
   LET ls_group = "'2',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE axmt590_bcl2
   END IF
 
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
                           
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="axmt590.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION axmt590_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
                           
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("xmdkdocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("xmdkdocno",TRUE)
      CALL cl_set_comp_entry("xmdkdocdt",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
                                                      
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   CALL cl_set_comp_entry("xmdk001",TRUE)               
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="axmt590.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION axmt590_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
 
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("xmdkdocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
                                                      
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("xmdkdocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("xmdkdocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   IF p_cmd <> 'c' THEN   #單據確認
      CALL cl_set_comp_entry("xmdk001",FALSE)
   END IF
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="axmt590.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION axmt590_set_entry_b(p_cmd)
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
   CALL cl_set_comp_entry("xmdl014,xmdl015",TRUE)
   CALL cl_set_comp_entry("xmdl016",TRUE)           #160519-00022#13 add
   CALL cl_set_comp_entry("xmdl052",TRUE)       #160519-00008#12
   CALL cl_set_comp_required("xmdl052",TRUE)    #160519-00008#12
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="axmt590.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION axmt590_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define(客製用) name="set_no_entry_b.define_customerization"
   
   #end add-point    
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   DEFINE l_imaf055    LIKE imaf_t.imaf055  #160519-00022#13 add
   DEFINE l_imaf061    LIKE imaf_t.imaf061  #160519-00022#13 add
   #end add-point    
   
   #add-point:Function前置處理  name="set_no_entry_b.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("",FALSE)
      #add-point:set_no_entry_b段欄位控制 name="set_no_entry_b.field_control"
      
      #end add-point 
   END IF 
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b"
   IF g_xmdl_d[l_ac].xmdl013 = 'Y' THEN
      CALL cl_set_comp_entry("xmdl014,xmdl015",FALSE)
   END IF
   
   #儲位控管若為5.不使用儲位控管  
   IF NOT s_axmt540_inaa007_chk(g_xmdl_d[l_ac].xmdl014) THEN
      CALL cl_set_comp_entry("xmdl015",FALSE)
   END IF
   #160519-00008#12
   CALL s_axmt540_get_imaf(g_xmdl_d[l_ac].xmdl008) RETURNING l_imaf055,l_imaf061
   IF l_imaf055 <> '1' THEN
      CALL cl_set_comp_required("xmdl052",FALSE)
   END IF
   CASE l_imaf055
       WHEN '2'  #不可有庫存管理特徵
          LET g_xmdl_d[l_ac].xmdl052 = ''
          CALL cl_set_comp_entry("xmdl052",FALSE)            
          CALL cl_set_comp_required("xmdl052",FALSE)
   END CASE
   #160519-00008#12
   #160519-00022#13-s-add
   IF g_argv[01] = '1' THEN
      CALL s_axmt540_get_imaf(g_xmdl_d[l_ac].xmdl008) RETURNING l_imaf055,l_imaf061
      #160519-00008#12--mark
      #CASE l_imaf055
      #    WHEN '1'  #必須有庫存管理特徵
      #       CALL cl_set_comp_required("xmdl052",TRUE)
      #    WHEN '2'  #不可有庫存管理特徵
      #       CALL cl_set_comp_entry("xmdl052",FALSE)            
      #END CASE
      #160519-00008#12--mark
      #檢查料件是否使用批號
      CASE l_imaf061
         WHEN '1'  #必須有批號
            CALL cl_set_comp_required("xmdl016",TRUE)
         WHEN '2'  #不可有批號
            CALL cl_set_comp_entry("xmdl016",FALSE)
      END CASE
   ELSE
      CALL cl_set_comp_entry("xmdl016",FALSE)
   END IF   
   #160519-00022#13-e-add
   
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="axmt590.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION axmt590_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"

   #150721-00001#1  2016/01/08 By earl mod s
   #整體單據Action控制
   CALL cl_set_act_visible("insert", TRUE)
   
   IF NOT cl_null(g_xmdk_m.xmdkdocno) THEN
      CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
      CALL cl_set_act_visible("axmt590_change_warehouse,axmt590_create_qc",TRUE)
      CALL cl_set_act_visible("axmt590_call_axmt540_01,s_lot_sel",TRUE)
   END IF
   #150721-00001#1  2016/01/08 By earl mod e

   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="axmt590.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION axmt590_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   #150721-00001#1  2016/01/08 By earl add s
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_flag        LIKE type_t.num5
   #150721-00001#1  2016/01/08 By earl add e
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   CALL cl_set_act_visible("insert,delete,reproduce",FALSE)
   
   CASE g_xmdk_m.xmdkstus         
      WHEN 'Y'   #已確認         
         CALL cl_set_act_visible("modify,modify_detail",FALSE)
         CALL cl_set_act_visible("axmt590_change_warehouse",FALSE)

      WHEN 'X'   #作廢
         CALL cl_set_act_visible("modify,modify_detail",FALSE)
         CALL cl_set_act_visible("axmt590_change_warehouse",FALSE)
                  
      WHEN 'W'   #送簽中
         CALL cl_set_act_visible("modify,modify_detail",FALSE)
         CALL cl_set_act_visible("axmt590_change_warehouse",FALSE)
         
      WHEN 'A'   #已核准
         CALL cl_set_act_visible("modify,modify_detail",FALSE)
         CALL cl_set_act_visible("axmt590_change_warehouse",FALSE)

      #WHEN 'H'   #留置
      #WHEN 'S'   #已扣帳
      #WHEN 'N'   #未確認
      #WHEN 'D'   #抽單
      #WHEN 'R'   #已拒絕
      
   END CASE   
   
   #150721-00001#1  2016/01/08 By earl add s
   CALL s_control_chk_group('5','2',g_user,g_dept,g_site,'','','','') RETURNING l_success,l_flag
   IF NOT l_success OR NOT l_flag THEN    #處理狀態為FALSE 或 不在控制組範圍內
      CALL cl_set_act_visible("insert", FALSE)
      CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", FALSE)
      CALL cl_set_act_visible("axmt590_change_warehouse,axmt590_create_qc",FALSE)
      CALL cl_set_act_visible("axmt590_call_axmt540_01,s_lot_sel",FALSE)
   END IF
   #150721-00001#1  2016/01/08 By earl add e
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="axmt590.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION axmt590_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   CALL cl_set_act_visible("s_lot_sel",TRUE)  #add by lixh 20150915 
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="axmt590.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION axmt590_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   DEFINE  l_imaf071      LIKE imaf_t.imaf071
   DEFINE  l_imaf081      LIKE imaf_t.imaf081
   #150721-00001#1  2016/01/08 By earl add s
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_flag        LIKE type_t.num5
   #150721-00001#1  2016/01/08 By earl add e
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
      
   IF g_xmdk_m.xmdkstus <> 'N' THEN
      CALL cl_set_act_visible("s_lot_sel",FALSE)
   END IF   

   IF g_detail_idx <> 0 THEN
      IF NOT cl_null(g_xmdl_d[g_detail_idx].xmdl008) THEN
         SELECT imaf071,imaf081 INTO l_imaf071,l_imaf081 FROM imaf_t
          WHERE imafent = g_enterprise
            AND imafsite = g_site
            AND imaf001 = g_xmdl_d[g_detail_idx].xmdl008
         IF l_imaf071 = '2' AND l_imaf081 = '2' THEN
            CALL cl_set_act_visible("s_lot_sel",FALSE)
         END IF         
      END IF
   END IF
   
   #150721-00001#1  2016/01/08 By earl add s
   CALL s_control_chk_group('5','2',g_user,g_dept,g_site,'','','','') RETURNING l_success,l_flag
   IF NOT l_success OR NOT l_flag THEN    #處理狀態為FALSE 或 不在控制組範圍內
      CALL cl_set_act_visible("s_lot_sel",FALSE)
   END IF
   #150721-00001#1  2016/01/08 By earl add e
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="axmt590.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION axmt590_default_search()
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
      LET ls_wc = ls_wc, " xmdkdocno = '", g_argv[01], "' AND "
   END IF
   
 
   
   #add-point:default_search段after sql name="default_search.after_sql"
   #g_argv[01]：0為簽退單 1為借貨還量單  
   #g_argv[02]：單號 
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " xmdkdocno = '", g_argv[01], "' AND "
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
               WHEN la_wc[li_idx].tableid = "xmdk_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "xmdl_t" 
                  LET g_wc2_table1 = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "xmdm_t" 
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
 
{<section id="axmt590.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION axmt590_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_success LIKE type_t.num5
   DEFINE l_pmak003 LIKE pmak_t.pmak003   #一次性交易對象名稱   #161207-00033#18 add 
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   #161207-00033#18-s-add
   IF g_xmdk_m.xmdkstus = 'X' THEN
      RETURN
   END IF 
   #161207-00033#18-e-add
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_xmdk_m.xmdkdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN axmt590_cl USING g_enterprise,g_xmdk_m.xmdkdocno
   IF STATUS THEN
      CLOSE axmt590_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axmt590_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE axmt590_master_referesh USING g_xmdk_m.xmdkdocno INTO g_xmdk_m.xmdk000,g_xmdk_m.xmdksite, 
       g_xmdk_m.xmdkdocno,g_xmdk_m.xmdkdocdt,g_xmdk_m.xmdk001,g_xmdk_m.xmdk003,g_xmdk_m.xmdk004,g_xmdk_m.xmdkstus, 
       g_xmdk_m.xmdk081,g_xmdk_m.xmdk005,g_xmdk_m.xmdk006,g_xmdk_m.xmdk002,g_xmdk_m.xmdk007,g_xmdk_m.xmdk009, 
       g_xmdk_m.xmdk008,g_xmdk_m.xmdkownid,g_xmdk_m.xmdkowndp,g_xmdk_m.xmdkcrtid,g_xmdk_m.xmdkcrtdp, 
       g_xmdk_m.xmdkcrtdt,g_xmdk_m.xmdkmodid,g_xmdk_m.xmdkmoddt,g_xmdk_m.xmdkcnfid,g_xmdk_m.xmdkcnfdt, 
       g_xmdk_m.xmdkpstid,g_xmdk_m.xmdkpstdt,g_xmdk_m.xmdk003_desc,g_xmdk_m.xmdk004_desc,g_xmdk_m.xmdk007_desc, 
       g_xmdk_m.xmdk009_desc,g_xmdk_m.xmdk008_desc,g_xmdk_m.xmdkownid_desc,g_xmdk_m.xmdkowndp_desc,g_xmdk_m.xmdkcrtid_desc, 
       g_xmdk_m.xmdkcrtdp_desc,g_xmdk_m.xmdkmodid_desc,g_xmdk_m.xmdkcnfid_desc,g_xmdk_m.xmdkpstid_desc 
 
   
 
   #檢查是否允許此動作
   IF NOT axmt590_action_chk() THEN
      CLOSE axmt590_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_xmdk_m.xmdk000,g_xmdk_m.xmdksite,g_xmdk_m.xmdkdocno,g_xmdk_m.xmdkdocno_desc,g_xmdk_m.xmdkdocdt, 
       g_xmdk_m.xmdk001,g_xmdk_m.xmdk003,g_xmdk_m.xmdk003_desc,g_xmdk_m.xmdk004,g_xmdk_m.xmdk004_desc, 
       g_xmdk_m.xmdkstus,g_xmdk_m.xmdk081,g_xmdk_m.xmdk005,g_xmdk_m.xmdk006,g_xmdk_m.xmdk002,g_xmdk_m.xmdk007, 
       g_xmdk_m.xmdk007_desc,g_xmdk_m.xmdk009,g_xmdk_m.xmdk009_desc,g_xmdk_m.xmdk008,g_xmdk_m.xmdk008_desc, 
       g_xmdk_m.xmdkownid,g_xmdk_m.xmdkownid_desc,g_xmdk_m.xmdkowndp,g_xmdk_m.xmdkowndp_desc,g_xmdk_m.xmdkcrtid, 
       g_xmdk_m.xmdkcrtid_desc,g_xmdk_m.xmdkcrtdp,g_xmdk_m.xmdkcrtdp_desc,g_xmdk_m.xmdkcrtdt,g_xmdk_m.xmdkmodid, 
       g_xmdk_m.xmdkmodid_desc,g_xmdk_m.xmdkmoddt,g_xmdk_m.xmdkcnfid,g_xmdk_m.xmdkcnfid_desc,g_xmdk_m.xmdkcnfdt, 
       g_xmdk_m.xmdkpstid,g_xmdk_m.xmdkpstid_desc,g_xmdk_m.xmdkpstdt
 
   CASE g_xmdk_m.xmdkstus
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
      WHEN "S"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/posted.png")
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
      WHEN "Z"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/unposted.png")
      WHEN "X"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
      
   END CASE
 
   #add-point:資料刷新後 name="statechange.after_refresh"
   CALL axmt590_get_pmak003()  #161207-00033#18-add
   #end add-point
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_xmdk_m.xmdkstus
            
            WHEN "N"
               HIDE OPTION "unconfirmed"
            WHEN "Y"
               HIDE OPTION "confirmed"
            WHEN "S"
               HIDE OPTION "posted"
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
            WHEN "Z"
               HIDE OPTION "unposted"
            WHEN "X"
               HIDE OPTION "invalid"
         END CASE
     
      #add-point:menu前 name="statechange.before_menu"
      #approved    已核准(不卡)
      #rejection   已拒絕(不卡)
      #signing     提交
      #withdraw    抽單
      
      #confirmed   確認
      #unconfirmed 取消確認
      #posted      過帳
      #unposted    取消過帳
      #invalid     作廢
      #unhold      取消留置
      #hold        留置

      CALL cl_set_act_visible("signing,withdraw",FALSE)
      CALL cl_set_act_visible("confirmed,unconfirmed,invalid",TRUE)                               #160308-00010#5 add
      #CALL cl_set_act_visible("confirmed,unconfirmed,posted,unposted,invalid,unhold,hold",FALSE) #160308-00010#5 mark

      CASE g_xmdk_m.xmdkstus
         WHEN "N"   #未確認         
            CALL cl_set_act_visible("unconfirmed,posted,unposted,unhold,hold",FALSE) #160308-00010#5 add            
            #CALL cl_set_act_visible("confirmed",TRUE)                               #160308-00010#5 mark

            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            IF cl_bpm_chk() THEN
               CALL cl_set_act_visible("signing",TRUE)
               CALL cl_set_act_visible("confirmed",FALSE)
            END IF  

         WHEN "X"   #作廢
            CALL cl_set_act_visible("confirmed,unconfirmed,invalid,posted,unposted,unhold,hold",FALSE)  #160308-00010#5 add
            #RETURN                                                                                     #160308-00010#5 mark

         WHEN "Y"   #已確認
            CALL cl_set_act_visible("invalid,confirmed,posted,unposted,unhold,hold",FALSE)     #160308-00010#5 add
            #CALL cl_set_act_visible("unconfirmed",TRUE)                                       #160308-00010#5 mark

         WHEN "A"   #已核准
            CALL cl_set_act_visible("confirmed ",TRUE)
             CALL cl_set_act_visible("unconfirmed,invalid,posted,unposted,unhold,hold",FALSE)  #160308-00010#5 add

         WHEN "R"   #已拒絕         
            CALL cl_set_act_visible("confirmed,unconfirmed,posted,unposted,unhold,hold",FALSE) #160308-00010#5 add

            #160308-00010#5 mark ---(S)---
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            #CALL cl_set_act_visible("confirmed",TRUE)
            #
            #IF cl_bpm_chk() THEN
            #   CALL cl_set_act_visible("signing",TRUE)
            #   CALL cl_set_act_visible("confirmed",FALSE)
            #END IF
            #160308-00010#5 mark ---(E)--- 

         WHEN "D"   #抽單         
            CALL cl_set_act_visible("confirmed,unconfirmed,posted,unposted,unhold,hold",FALSE) #160308-00010#5 add
            
            #160308-00010#5 mark ---(S)---
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            #CALL cl_set_act_visible("confirmed",TRUE)
            #
            #IF cl_bpm_chk() THEN
            #   CALL cl_set_act_visible("signing",TRUE)
            #   CALL cl_set_act_visible("confirmed",FALSE)
            #END IF
            #160308-00010#5 mark ---(E)--- 
            
         WHEN "W"   #送簽中
            CALL cl_set_act_visible("withdraw",TRUE) 
            CALL cl_set_act_visible("unconfirmed,invalid,confirmed,posted,unposted,unhold,hold",FALSE) #160308-00010#5 add
            
#         WHEN "S"   #已過帳
#         WHEN "H"  #留置
#         WHEN "UH" #取消留置
#         WHEN "Z"  #扣帳還原

      END CASE
      
      #end add-point
      
      #應用 a36 樣板自動產生(Version:5)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT axmt590_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE axmt590_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT axmt590_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE axmt590_cl
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
      ON ACTION unposted
         IF cl_auth_chk_act("unposted") THEN
            LET lc_state = "Z"
            #add-point:action控制 name="statechange.unposted"
            
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
      AND lc_state <> "A"
      AND lc_state <> "D"
      AND lc_state <> "R"
      AND lc_state <> "W"
      AND lc_state <> "UH"
      AND lc_state <> "H"
      AND lc_state <> "Z"
      AND lc_state <> "X"
      ) OR 
      g_xmdk_m.xmdkstus = lc_state OR cl_null(lc_state) THEN
      CLOSE axmt590_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   CALL cl_err_collect_init()
   
   CASE lc_state
      WHEN 'Y'
         CALL s_axmt590_conf_chk(g_xmdk_m.xmdkdocno) RETURNING l_success
         IF NOT l_success THEN
            CALL s_transaction_end('N','0')   #160812-00017#6 20160819 add by beckxie
            CALL cl_err_collect_show()
            RETURN
         ELSE
            IF NOT cl_ask_confirm('aim-00108') THEN
               CALL s_transaction_end('N','0')   #160812-00017#6 20160819 add by beckxie
               CALL cl_err_collect_show()
               RETURN
            ELSE
               CALL s_transaction_begin()
               IF NOT axmt590_conf_input() THEN   #Input
                  CALL s_transaction_end('N','0')
                  CALL cl_err_collect_show()
                  RETURN
               END IF
               CALL s_axmt590_conf_upd(g_xmdk_m.xmdkdocno) RETURNING l_success
               IF NOT l_success THEN
                  CALL s_transaction_end('N','0')
                  CALL cl_err_collect_show()
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
            END IF
         END IF
              
      WHEN 'N'
         CALL s_axmt590_unconf_chk(g_xmdk_m.xmdkdocno) RETURNING l_success
         IF NOT l_success THEN
            CALL s_transaction_end('N','0')   #160812-00017#6 20160819 add by beckxie
            CALL cl_err_collect_show()
            RETURN
         ELSE
            IF NOT cl_ask_confirm('aim-00110') THEN
               CALL s_transaction_end('N','0')   #160812-00017#6 20160819 add by beckxie
               CALL cl_err_collect_show()
               RETURN
            ELSE
               CALL s_transaction_begin()
               CALL s_axmt590_unconf_upd(g_xmdk_m.xmdkdocno) RETURNING l_success
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
   
   LET g_xmdk_m.xmdkmodid = g_user
   LET g_xmdk_m.xmdkmoddt = cl_get_current()
   LET g_xmdk_m.xmdkstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE xmdk_t 
      SET (xmdkstus,xmdkmodid,xmdkmoddt) 
        = (g_xmdk_m.xmdkstus,g_xmdk_m.xmdkmodid,g_xmdk_m.xmdkmoddt)     
    WHERE xmdkent = g_enterprise AND xmdkdocno = g_xmdk_m.xmdkdocno
 
    
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
         WHEN "Z"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unposted.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
    
      #撈取異動後的資料
      EXECUTE axmt590_master_referesh USING g_xmdk_m.xmdkdocno INTO g_xmdk_m.xmdk000,g_xmdk_m.xmdksite, 
          g_xmdk_m.xmdkdocno,g_xmdk_m.xmdkdocdt,g_xmdk_m.xmdk001,g_xmdk_m.xmdk003,g_xmdk_m.xmdk004,g_xmdk_m.xmdkstus, 
          g_xmdk_m.xmdk081,g_xmdk_m.xmdk005,g_xmdk_m.xmdk006,g_xmdk_m.xmdk002,g_xmdk_m.xmdk007,g_xmdk_m.xmdk009, 
          g_xmdk_m.xmdk008,g_xmdk_m.xmdkownid,g_xmdk_m.xmdkowndp,g_xmdk_m.xmdkcrtid,g_xmdk_m.xmdkcrtdp, 
          g_xmdk_m.xmdkcrtdt,g_xmdk_m.xmdkmodid,g_xmdk_m.xmdkmoddt,g_xmdk_m.xmdkcnfid,g_xmdk_m.xmdkcnfdt, 
          g_xmdk_m.xmdkpstid,g_xmdk_m.xmdkpstdt,g_xmdk_m.xmdk003_desc,g_xmdk_m.xmdk004_desc,g_xmdk_m.xmdk007_desc, 
          g_xmdk_m.xmdk009_desc,g_xmdk_m.xmdk008_desc,g_xmdk_m.xmdkownid_desc,g_xmdk_m.xmdkowndp_desc, 
          g_xmdk_m.xmdkcrtid_desc,g_xmdk_m.xmdkcrtdp_desc,g_xmdk_m.xmdkmodid_desc,g_xmdk_m.xmdkcnfid_desc, 
          g_xmdk_m.xmdkpstid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_xmdk_m.xmdk000,g_xmdk_m.xmdksite,g_xmdk_m.xmdkdocno,g_xmdk_m.xmdkdocno_desc, 
          g_xmdk_m.xmdkdocdt,g_xmdk_m.xmdk001,g_xmdk_m.xmdk003,g_xmdk_m.xmdk003_desc,g_xmdk_m.xmdk004, 
          g_xmdk_m.xmdk004_desc,g_xmdk_m.xmdkstus,g_xmdk_m.xmdk081,g_xmdk_m.xmdk005,g_xmdk_m.xmdk006, 
          g_xmdk_m.xmdk002,g_xmdk_m.xmdk007,g_xmdk_m.xmdk007_desc,g_xmdk_m.xmdk009,g_xmdk_m.xmdk009_desc, 
          g_xmdk_m.xmdk008,g_xmdk_m.xmdk008_desc,g_xmdk_m.xmdkownid,g_xmdk_m.xmdkownid_desc,g_xmdk_m.xmdkowndp, 
          g_xmdk_m.xmdkowndp_desc,g_xmdk_m.xmdkcrtid,g_xmdk_m.xmdkcrtid_desc,g_xmdk_m.xmdkcrtdp,g_xmdk_m.xmdkcrtdp_desc, 
          g_xmdk_m.xmdkcrtdt,g_xmdk_m.xmdkmodid,g_xmdk_m.xmdkmodid_desc,g_xmdk_m.xmdkmoddt,g_xmdk_m.xmdkcnfid, 
          g_xmdk_m.xmdkcnfid_desc,g_xmdk_m.xmdkcnfdt,g_xmdk_m.xmdkpstid,g_xmdk_m.xmdkpstid_desc,g_xmdk_m.xmdkpstdt 
 
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   CALL axmt590_get_pmak003()  #161207-00033#18-add

   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"

   #單身Action隱藏
   CALL axmt590_detail_action_hidden(g_detail_idx)

   #end add-point  
 
   CLOSE axmt590_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL axmt590_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axmt590.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION axmt590_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
                           
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_xmdl_d.getLength() THEN
         LET g_detail_idx = g_xmdl_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_xmdl_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_xmdl_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx > g_xmdl3_d.getLength() THEN
         LET g_detail_idx = g_xmdl3_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_xmdl3_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_xmdl3_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"

   #單身Action隱藏
   CALL axmt590_detail_action_hidden(g_detail_idx)

   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axmt590.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axmt590_b_fill2(pi_idx)
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
   
   CALL axmt590_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="axmt590.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION axmt590_fill_chk(ps_idx)
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
 
{<section id="axmt590.status_show" >}
PRIVATE FUNCTION axmt590_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axmt590.mask_functions" >}
&include "erp/axm/axmt590_mask.4gl"
 
{</section>}
 
{<section id="axmt590.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION axmt590_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
   LET g_wc2_table2 = " 1=1"
 
 
   CALL axmt590_show()
   CALL axmt590_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   #確認前檢核段
   IF NOT s_axmt590_conf_chk(g_xmdk_m.xmdkdocno) THEN
      CLOSE axmt590_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_xmdk_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_xmdl_d))
   CALL cl_bpm_set_detail_data("s_detail3", util.JSONArray.fromFGL(g_xmdl3_d))
 
 
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
   #CALL axmt590_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL axmt590_ui_headershow()
   CALL axmt590_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION axmt590_draw_out()
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
   CALL axmt590_ui_headershow()  
   CALL axmt590_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="axmt590.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION axmt590_set_pk_array()
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
   LET g_pk_array[1].values = g_xmdk_m.xmdkdocno
   LET g_pk_array[1].column = 'xmdkdocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axmt590.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="axmt590.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION axmt590_msgcentre_notify(lc_state)
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
   CALL axmt590_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_xmdk_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axmt590.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION axmt590_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#43-s
   SELECT xmdkstus INTO g_xmdk_m.xmdkstus FROM xmdk_t
    WHERE xmdkent = g_enterprise
      AND xmdksite = g_site
      AND xmdkdocno = g_xmdk_m.xmdkdocno
   IF (g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail")  THEN
     LET g_errno = NULL
     CASE g_xmdk_m.xmdkstus
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
        WHEN 'UH'
           LET g_errno = 'sub-01358'
        WHEN 'H'
           LET g_errno = 'sub-01348'
     END CASE

     IF NOT cl_null(g_errno) THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = g_errno
        LET g_errparam.extend = g_xmdk_m.xmdkdocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL axmt590_set_act_visible()
        CALL axmt590_set_act_no_visible()
        CALL axmt590_show()
        RETURN FALSE
     END IF
   END IF      
   #160818-00017#43-e
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="axmt590.other_function" readonly="Y" >}

PRIVATE FUNCTION axmt590_xmdl014_chk()
   DEFINE r_success    LIKE type_t.num5
   DEFINE l_type       LIKE type_t.chr1
   DEFINE l_success    LIKE type_t.num5
   DEFINE l_flag       LIKE type_t.num5
   
   LET r_success = TRUE
   
   IF NOT cl_null(g_xmdl_d[l_ac].xmdl014)THEN
   
      #得出來源成本庫否
      CALL s_axmt600_warehouse_cost(g_xmdl_d[l_ac].xmdl001,g_xmdl_d[l_ac].xmdl002)
      RETURNING l_type                  
                     
      #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
      INITIALIZE g_chkparam.* TO NULL
     
      #替換錯誤訊息
      LET g_chkparam.err_str[1] = "axm-00197:axm-00387"
               
      #設定g_chkparam.*的參數
      LET g_chkparam.arg1 = g_xmdk_m.xmdksite
      LET g_chkparam.arg2 = g_xmdl_d[l_ac].xmdl014    #庫位
      LET g_chkparam.arg3 = l_type
               
      #呼叫檢查存在並帶值的library
      IF NOT cl_chk_exist("v_inaa001_6") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
      
      #150721-00001#1  2016/01/08 By earl mod s      
      #檢核輸入的庫位(From)是否在單據別限制範圍內
      IF NOT cl_null(g_xmdk_m.xmdkdocno) THEN
         CALL s_control_chk_doc('6',g_xmdk_m.xmdkdocno,g_xmdl_d[l_ac].xmdl014,'','','','')
         RETURNING l_success,l_flag
         
         IF NOT l_success OR NOT l_flag THEN
            LET r_success = FALSE
            RETURN r_success
         END IF
      END IF
      #150721-00001#1  2016/01/08 By earl mod e
      
   END IF

   RETURN r_success   
END FUNCTION

PRIVATE FUNCTION axmt590_xmdl084_ref()
   DEFINE l_gzcb004     LIKE gzcb_t.gzcb004
   
   LET l_gzcb004 = ''
   #160705-00042#12 160715 by sakura mark(S)   
   #SELECT gzcb004
   #  INTO l_gzcb004
   #  FROM gzcb_t
   # WHERE gzcb001 = '24'
   #   AND gzcb002 = g_acc_type
   #160705-00042#12 160715 by sakura mark(E)
   #160705-00042#12 160715 by sakura add(S)      
   SELECT gzcb004
     INTO l_gzcb004
     FROM gzcb_t,gzzz_t 
    WHERE gzcb001 = '24' 
      AND gzcb002 = gzzz006 
      AND gzzz001 = g_acc_type
   #160705-00042#12 160715 by sakura add(E)      
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = l_gzcb004
   LET g_ref_fields[2] = g_xmdl_d[l_ac].xmdl084
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=? AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xmdl_d[l_ac].xmdl084_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xmdl_d[l_ac].xmdl084_desc
END FUNCTION

################################################################################
# Descriptions...: 整批調整庫位/儲位
# Memo...........:
# Usage..........: CALL axmt590_change_warehouse(p_xmdkdocno)
#                  RETURNING r_success
# Input parameter: p_xmdkdocno  單據單號
#                : 
# Return code....: r_success    執行結果
#                : 
# Date & Author..: 140422 By earl
# Modify.........:
################################################################################
PRIVATE FUNCTION axmt590_change_warehouse(p_xmdkdocno)
   DEFINE p_xmdkdocno   LIKE xmdk_t.xmdkdocno
   DEFINE r_success     LIKE type_t.num5
   DEFINE l_sql         STRING
   DEFINE l_xmdlseq     LIKE xmdl_t.xmdlseq
   DEFINE l_xmdl013     LIKE xmdl_t.xmdl013
   DEFINE l_xmdl008     LIKE xmdl_t.xmdl008
   DEFINE l_xmdl009     LIKE xmdl_t.xmdl009
   DEFINE l_xmdl014     LIKE xmdl_t.xmdl014
   DEFINE l_xmdl015     LIKE xmdl_t.xmdl015
   DEFINE l_xmdl016     LIKE xmdl_t.xmdl016
   DEFINE l_xmdl017     LIKE xmdl_t.xmdl017
   DEFINE l_xmdl052     LIKE xmdl_t.xmdl052
   DEFINE l_xmdmseq1    LIKE xmdm_t.xmdmseq1
   DEFINE l_xmdm001     LIKE xmdm_t.xmdm001
   DEFINE l_xmdm002     LIKE xmdm_t.xmdm002
   DEFINE l_xmdm005     LIKE xmdm_t.xmdm005
   DEFINE l_xmdm006     LIKE xmdm_t.xmdm006
   DEFINE l_xmdm007     LIKE xmdm_t.xmdm007
   DEFINE l_xmdm008     LIKE xmdm_t.xmdm008
   DEFINE l_xmdm033     LIKE xmdm_t.xmdm033
   DEFINE l_type        LIKE type_t.chr1
   DEFINE l_change   RECORD
             a_inaa001       LIKE inaa_t.inaa001,
             a_inaa001_desc  LIKE type_t.chr80,
             a_inab002       LIKE inab_t.inab002,
             a_inab002_desc  LIKE type_t.chr80,
             b_inaa001       LIKE inaa_t.inaa001,
             b_inaa001_desc  LIKE type_t.chr80,
             b_inab002       LIKE inab_t.inab002,
             b_inab002_desc  LIKE type_t.chr80
                     END RECORD
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_flag        LIKE type_t.num5
   
   LET r_success = TRUE
   
   IF cl_null(p_xmdkdocno) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00324'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF  
   
   OPEN WINDOW w_axmt590_s01 WITH FORM cl_ap_formpath("axm",'axmt590_s01')
   
   INITIALIZE l_change.* TO NULL
   INPUT BY NAME l_change.a_inaa001,l_change.a_inab002,l_change.b_inaa001,l_change.b_inab002 WITHOUT DEFAULTS
      BEFORE INPUT
      
      AFTER FIELD a_inaa001
         #庫位
         IF NOT cl_null(l_change.a_inaa001) THEN 
            #150721-00001#1  2016/01/08 By earl mod s            
            #檢核輸入的庫位(From)是否在單據別限制範圍內
            CALL s_control_chk_doc('6',p_xmdkdocno,l_change.a_inaa001,'','','','')
            RETURNING l_success,l_flag
               
            IF NOT l_success OR NOT l_flag THEN
               LET l_change.a_inaa001 = ''

               CALL s_desc_get_stock_desc(g_site,l_change.a_inaa001) RETURNING l_change.a_inaa001_desc
               DISPLAY BY NAME l_change.a_inaa001_desc
                                    
               NEXT FIELD CURRENT
            END IF
            #150721-00001#1  2016/01/08 By earl mod e
      
            IF NOT s_axmt590_inaa001_chk(l_change.a_inaa001,'Y') THEN
               LET l_change.a_inaa001 = ''

               CALL s_desc_get_stock_desc(g_site,l_change.a_inaa001) RETURNING l_change.a_inaa001_desc
               DISPLAY BY NAME l_change.a_inaa001_desc
                                    
               NEXT FIELD CURRENT
            END IF
         END IF
         
         #儲位
         IF NOT s_axmt590_xmdl015_chk(l_change.a_inaa001,l_change.a_inab002) THEN
            NEXT FIELD a_inab002
         END IF      
      
      AFTER FIELD a_inab002
         #儲位
         IF NOT cl_null(l_change.a_inab002) THEN
            IF NOT s_axmt590_xmdl015_chk(l_change.a_inaa001,l_change.a_inab002) THEN
               LET l_change.a_inab002 = ''

               CALL s_desc_get_locator_desc(g_site,l_change.a_inaa001,l_change.a_inab002) RETURNING l_change.a_inab002_desc
               DISPLAY BY NAME l_change.a_inab002_desc

               NEXT FIELD CURRENT
            END IF                        
         END IF
            
      AFTER FIELD b_inaa001
         #庫位
         IF NOT cl_null(l_change.b_inaa001) THEN
            #150721-00001#1  2016/01/08 By earl mod s            
            #檢核輸入的庫位(From)是否在單據別限制範圍內
            CALL s_control_chk_doc('6',p_xmdkdocno,l_change.b_inaa001,'','','','')
            RETURNING l_success,l_flag
               
            IF NOT l_success OR NOT l_flag THEN
               LET l_change.b_inaa001 = ''

               CALL s_desc_get_stock_desc(g_site,l_change.b_inaa001) RETURNING l_change.b_inaa001_desc
               DISPLAY BY NAME l_change.b_inaa001_desc
                     
               NEXT FIELD CURRENT
            END IF
            #150721-00001#1  2016/01/08 By earl mod e
         
            IF NOT s_axmt590_inaa001_chk(l_change.b_inaa001,'N') THEN
               LET l_change.b_inaa001 = ''

               CALL s_desc_get_stock_desc(g_site,l_change.b_inaa001) RETURNING l_change.b_inaa001_desc
               DISPLAY BY NAME l_change.b_inaa001_desc
                     
               NEXT FIELD CURRENT
            END IF
         END IF
         
         #儲位
         IF NOT s_axmt590_xmdl015_chk(l_change.b_inaa001,l_change.b_inab002) THEN
            NEXT FIELD b_inab002
         END IF 
         
      AFTER FIELD b_inab002
         #儲位
         IF NOT cl_null(l_change.b_inab002) THEN
            IF NOT s_axmt590_xmdl015_chk(l_change.b_inaa001,l_change.b_inab002) THEN
               LET l_change.b_inab002 = ''

               CALL s_desc_get_locator_desc(g_site,l_change.b_inaa001,l_change.b_inab002) RETURNING l_change.b_inab002_desc
               DISPLAY BY NAME l_change.b_inab002_desc

               NEXT FIELD CURRENT
            END IF
         END IF
         
      ON ACTION controlp INFIELD a_inaa001
         #開窗i段
			INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE
			
			LET g_qryparam.where = "inaa010 = 'Y'"      #成本庫
			
			LET g_qryparam.default1 = l_change.a_inaa001
            
         CALL q_inaa001_2()                                       #呼叫開窗

         LET l_change.a_inaa001 = g_qryparam.return1              #將開窗取得的值回傳到變數

         DISPLAY l_change.a_inaa001 TO a_inaa001                  #顯示到畫面上
         
         CALL s_desc_get_stock_desc(g_site,l_change.a_inaa001) RETURNING l_change.a_inaa001_desc
         DISPLAY BY NAME l_change.a_inaa001_desc         

         NEXT FIELD a_inaa001                          #返回原欄位
            
      ON ACTION controlp INFIELD a_inab002
         #開窗i段
			INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE
			
			LET g_qryparam.arg1 = l_change.a_inaa001
			
			LET g_qryparam.default1 = l_change.a_inab002
            
         CALL q_inab002_5()                                           #呼叫開窗

         LET l_change.a_inab002 = g_qryparam.return1              #將開窗取得的值回傳到變數

         DISPLAY l_change.a_inab002 TO a_inab002              #顯示到畫面上

         CALL s_desc_get_locator_desc(g_site,l_change.a_inaa001,l_change.a_inab002) RETURNING l_change.a_inab002_desc
         DISPLAY BY NAME l_change.a_inab002_desc

         NEXT FIELD a_inab002                          #返回原欄位
                        
      ON ACTION controlp INFIELD b_inaa001
         #開窗i段
			INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE
			
			LET g_qryparam.where = "inaa010 = 'N'"      #非成本庫
			
			LET g_qryparam.default1 = l_change.b_inaa001
            
         CALL q_inaa001_2()                                       #呼叫開窗

         LET l_change.b_inaa001 = g_qryparam.return1              #將開窗取得的值回傳到變數

         DISPLAY l_change.b_inaa001 TO b_inaa001                  #顯示到畫面上

         CALL s_desc_get_stock_desc(g_site,l_change.b_inaa001) RETURNING l_change.b_inaa001_desc
         DISPLAY BY NAME l_change.b_inaa001_desc

         NEXT FIELD b_inaa001                          #返回原欄位
         
      ON ACTION controlp INFIELD b_inab002
         #開窗i段
			INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE
			
			LET g_qryparam.arg1 = l_change.b_inaa001
			
			LET g_qryparam.default1 = l_change.b_inab002
            
         CALL q_inab002_5()                                           #呼叫開窗

         LET l_change.b_inab002 = g_qryparam.return1              #將開窗取得的值回傳到變數

         DISPLAY l_change.b_inab002 TO b_inab002              #顯示到畫面上


         CALL s_desc_get_locator_desc(g_site,l_change.b_inaa001,l_change.b_inab002) RETURNING l_change.b_inab002_desc
         DISPLAY BY NAME l_change.b_inab002_desc

         NEXT FIELD b_inab002                          #返回原欄位
      
      ON ACTION accept
         ACCEPT INPUT
         
      ON ACTION cancel
         EXIT INPUT

      ON ACTION exit
         EXIT INPUT
      
      AFTER INPUT
         IF cl_null(l_change.a_inab002) THEN
            LET l_change.a_inab002 = ' '
         END IF
         
         IF cl_null(l_change.b_inab002) THEN
            LET l_change.b_inab002 = ' '
         END IF
   END INPUT
   
   CLOSE WINDOW w_axmt590_s01   
   
   IF INT_FLAG THEN    #user取消
      LET INT_FLAG = FALSE
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   LET l_sql = "SELECT xmdlseq,xmdl013,xmdl008,xmdl009,xmdl014,xmdl015,xmdl016,xmdl017,xmdl052",
               "  FROM xmdl_t",
               " WHERE xmdlent = '",g_enterprise,"'",
               "   AND xmdldocno = '",p_xmdkdocno,"'"
   PREPARE axmt590_pre1 FROM l_sql
   DECLARE axmt590_cs1 CURSOR FOR axmt590_pre1
   
   LET l_sql = "SELECT xmdmseq1,xmdm001,xmdm002,xmdm005,xmdm006,xmdm007,xmdm008,xmdm033",
               "  FROM xmdm_t",
               " WHERE xmdment = '",g_enterprise,"'",               
               "   AND xmdmdocno = '",p_xmdkdocno,"'",
               "   AND xmdmseq = ?"
   PREPARE axmt590_pre2 FROM l_sql
   DECLARE axmt590_cs2 CURSOR FOR axmt590_pre2
      
   FOREACH axmt590_cs1 INTO l_xmdlseq,l_xmdl013,l_xmdl008,l_xmdl009,l_xmdl014,l_xmdl015,l_xmdl016,l_xmdl017,l_xmdl052
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET INT_FLAG = TRUE
         EXIT FOREACH
      END IF

      CALL s_axmt540_inag012_chk(g_site,l_xmdl008,l_xmdl009,l_xmdl052,l_xmdl014,l_xmdl015,l_xmdl016,l_xmdl017)
      RETURNING l_type

      IF l_type = 'Y' THEN
         LET l_xmdl014 = l_change.a_inaa001
         LET l_xmdl015 = l_change.a_inab002
      ELSE
         LET l_xmdl014 = l_change.b_inaa001
         LET l_xmdl015 = l_change.b_inab002  
      END IF

      UPDATE xmdl_t
         SET xmdl014 = l_xmdl014,
             xmdl015 = l_xmdl015
       WHERE xmdlent = g_enterprise
         AND xmdldocno = p_xmdkdocno
         AND xmdlseq = l_xmdlseq
            
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "UPDATE:"
            LET g_errparam.popup = TRUE
            CALL cl_err()

         LET INT_FLAG = TRUE
         EXIT FOREACH
      END IF

      #多庫儲批
      OPEN axmt590_cs2 USING l_xmdlseq
      FOREACH axmt590_cs2 INTO l_xmdmseq1,l_xmdm001,l_xmdm002,l_xmdm005,l_xmdm006,l_xmdm007,l_xmdm008,l_xmdm033
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH:"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            LET INT_FLAG = TRUE
            EXIT FOREACH
         END IF
         
         CALL s_axmt540_inag012_chk(g_site,l_xmdm001,l_xmdm002,l_xmdm033,l_xmdm005,l_xmdm006,l_xmdm007,l_xmdm008)
         RETURNING l_type
         
         IF l_type = 'Y' THEN   #成本倉
            LET l_xmdm005 = l_change.a_inaa001
            LET l_xmdm006 = l_change.a_inab002
         ELSE
            LET l_xmdm005 = l_change.b_inaa001
            LET l_xmdm006 = l_change.b_inab002
         END IF
         
         UPDATE xmdm_t
            SET xmdm005 = l_xmdm005,
                xmdm006 = l_xmdm006
          WHERE xmdment = g_enterprise
            AND xmdmdocno = p_xmdkdocno
            AND xmdmseq = l_xmdlseq
            AND xmdmseq1 = l_xmdmseq1
            
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "UPDATE:"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            LET INT_FLAG = TRUE
            EXIT FOREACH
         END IF
         
      END FOREACH
      IF INT_FLAG THEN
         EXIT FOREACH
      END IF
  
   END FOREACH

   CLOSE axmt590_cs1
   FREE axmt590_pre1
   CLOSE axmt590_cs2
   FREE axmt590_pre2
      
   IF INT_FLAG THEN
      LET INT_FLAG = FALSE
      LET r_success = FALSE
      RETURN r_success
   ELSE
      RETURN r_success
   END IF
   
END FUNCTION

################################################################################
# Descriptions...: 簽退單確認input
# Memo...........:
# Usage..........: CALL axmt590_conf_input()
#                  RETURNING r_success
# Input parameter: 
#                : 
# Return code....: r_success  執行結果
#                : 
# Date & Author..: 140422 By earl
# Modify.........:
################################################################################
PRIVATE FUNCTION axmt590_conf_input()
   DEFINE r_success       LIKE type_t.num5
   DEFINE l_para_data     LIKE type_t.chr80          #接參數用
   
   LET r_success = TRUE
   
   INPUT BY NAME g_xmdk_m.xmdk001 ATTRIBUTE(WITHOUT DEFAULTS)

      BEFORE INPUT
         CALL axmt590_set_entry('c')
         CALL axmt590_set_no_entry('c')
         
         IF cl_null(g_xmdk_m.xmdk001) THEN
            LET g_xmdk_m.xmdk001 = cl_get_current()
         END IF
         DISPLAY BY NAME g_xmdk_m.xmdk001

      AFTER FIELD xmdk001
         IF NOT cl_null(g_xmdk_m.xmdk001) THEN
            #151120-00003#1 20151120 mark by beckxie---S
            #IF g_xmdk_m.xmdk001 < g_xmdk_m.xmdkdocdt THEN
            #   INITIALIZE g_errparam TO NULL
            #   CASE g_argv[01]
            #      WHEN '0'
            #         LET g_errparam.code = 'axm-00269'     #簽退日期不可小於單據日期！ 
            #      WHEN '1'
            #         LET g_errparam.code = 'axm-00267'     #扣帳日期不可小於單據日期！ 
            #      OTHERWISE
            #         LET g_errparam.code = 'axm-00269'     #簽退日期不可小於單據日期！ 
            #   END CASE
            #   LET g_errparam.extend = g_xmdk_m.xmdk001
            #   LET g_errparam.popup = TRUE
            #   CALL cl_err()
            #
            #   LET g_xmdk_m.xmdk001 = g_xmdk_m_t.xmdk001
            #   NEXT FIELD CURRENT
            #END IF
            #151120-00003#1 20151120 mark by beckxie---E      
            CALL cl_get_para(g_enterprise,g_site,'S-MFG-0031') RETURNING l_para_data
            IF g_xmdk_m.xmdk001 <= l_para_data THEN
               INITIALIZE g_errparam TO NULL 
               CASE g_argv[01] 
                  WHEN '0' 
                     LET g_errparam.code = 'axm-00616'    #簽退日期小於關帳日期，請重新輸入！
                  WHEN '1' 
                     LET g_errparam.code = 'axm-00077' 
                  OTHERWISE 
                     LET g_errparam.code = 'axm-00616' 
               END CASE 
               LET g_errparam.extend = g_xmdk_m.xmdk001
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_xmdk_m.xmdk001 = g_xmdk_m_t.xmdk001
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

   IF INT_FLAG THEN
      LET INT_FLAG = FALSE
      LET r_success = FALSE
      RETURN r_success
   END IF

   UPDATE xmdk_t
      SET xmdk001 = g_xmdk_m.xmdk001
    WHERE xmdkent = g_enterprise
      AND xmdkdocno = g_xmdk_m.xmdkdocno

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
# Descriptions...: 單身Action隱藏
# Memo...........:
# Usage..........: CALL axmt590_detail_action_hidden(p_ac)
#                 
# Input parameter: p_ac   單身所在項次
#                : 
# Return code....: 
#                : 
# Date & Author..: 140930 By earl
# Modify.........:
################################################################################
PRIVATE FUNCTION axmt590_detail_action_hidden(p_ac)
   DEFINE p_ac       LIKE type_t.num5

   DEFINE l_n        LIKE type_t.num5

   DEFINE l_xmah001  LIKE xmah_t.xmah001

   CALL cl_set_act_visible("axmt590_call_axmt540_01",FALSE)  #多庫儲批

   IF g_xmdk_m.xmdkstus = 'N' OR
      g_xmdk_m.xmdkstus = 'D' OR
      g_xmdk_m.xmdkstus = 'R' OR
      g_xmdk_m.xmdkstus = 'A' THEN

      IF NOT cl_null(p_ac) AND p_ac > 0 THEN
         CALL cl_set_act_visible("axmt590_call_axmt540_01",TRUE)
      END IF
      
   END IF
END FUNCTION

################################################################################
# Descriptions...: 修改多庫儲批Action
# Memo...........:
# Usage..........: CALL axmt590_call_axmt540_01()
#                  
# Input parameter: 
#                : 
# Return code....: 
#                : 
# Date & Author..: 140930 By earl
# Modify.........:
################################################################################
PRIVATE FUNCTION axmt590_call_axmt540_01()
   DEFINE l_success  LIKE type_t.num5
   DEFINE l_rollback LIKE type_t.num5 
   DEFINE l_xmdl014  LIKE xmdl_t.xmdl014
   DEFINE l_xmdl015  LIKE xmdl_t.xmdl015
   DEFINE l_xmdl016  LIKE xmdl_t.xmdl016
   DEFINE l_xmdl052  LIKE xmdl_t.xmdl052

   CALL s_transaction_begin()
   
   OPEN axmt590_cl USING g_enterprise,g_xmdk_m.xmdkdocno
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "OPEN axmt590_cl:"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      CLOSE axmt590_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF

   #開啟多庫儲批
   CALL axmt540_01('5',g_xmdk_m.xmdksite,'',g_xmdk_m.xmdkdocno,
                   g_xmdl_d[g_detail_idx].xmdlseq,g_xmdl_d[g_detail_idx].xmdl008,g_xmdl_d[g_detail_idx].xmdl009,
                   g_xmdl_d[g_detail_idx].xmdl011,g_xmdl_d[g_detail_idx].xmdl012,
                   g_xmdl_d[g_detail_idx].xmdl017,g_xmdl_d[g_detail_idx].xmdl018,g_xmdl_d[g_detail_idx].xmdl081,                               
                   g_xmdl_d[g_detail_idx].xmdl019,g_xmdl_d[g_detail_idx].xmdl020,g_xmdl_d[g_detail_idx].xmdl082,
                   g_xmdl_d[g_detail_idx].xmdl001,g_xmdl_d[g_detail_idx].xmdl002,g_xmdl_d[g_detail_idx].xmdl003,g_xmdl_d[g_detail_idx].xmdl004,g_xmdl_d[g_detail_idx].xmdl030)
                   RETURNING l_success,l_rollback,l_xmdl014,l_xmdl015,l_xmdl016,l_xmdl052
                   
   IF l_rollback OR NOT l_success THEN
      CLOSE axmt590_cl
      CALL s_transaction_end('N','0')
      RETURN
      
   ELSE
   
      IF NOT cl_null(l_xmdl014) THEN  #只有一筆         
         UPDATE xmdl_t
            SET xmdl013 = 'N',
                xmdl014 = l_xmdl014,
                xmdl015 = l_xmdl015,
                xmdl016 = l_xmdl016,
                xmdl052 = l_xmdl052
          WHERE xmdlent = g_enterprise
            AND xmdldocno = g_xmdk_m.xmdkdocno
            AND xmdlseq = g_xmdl_d[g_detail_idx].xmdlseq                     
            
      ELSE
      
         UPDATE xmdl_t
            SET xmdl013 = 'Y',
                xmdl014 = ' ',
                xmdl015 = ' ',
                xmdl016 = ' ',
                xmdl052 = ' '
          WHERE xmdlent = g_enterprise
            AND xmdldocno = g_xmdk_m.xmdkdocno
            AND xmdlseq = g_xmdl_d[g_detail_idx].xmdlseq      
      END IF
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  SQLCA.sqlcode
         LET g_errparam.extend = "UPDATE:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
     
         CLOSE axmt590_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF

   END IF

   CLOSE axmt590_cl
   CALL s_transaction_end('Y','0')
   
   CALL axmt590_show()
END FUNCTION

PRIVATE FUNCTION axmt590_row_default()
   
   #先將可能為NULL欄位預設為' '
   IF cl_null(g_xmdl_d[l_ac].xmdl009) THEN LET g_xmdl_d[l_ac].xmdl009 = ' ' END IF  #產品特徵
   IF cl_null(g_xmdl_d[l_ac].xmdl014) THEN LET g_xmdl_d[l_ac].xmdl014 = ' ' END IF  #庫位
   IF cl_null(g_xmdl_d[l_ac].xmdl015) THEN LET g_xmdl_d[l_ac].xmdl015 = ' ' END IF  #儲位
   IF cl_null(g_xmdl_d[l_ac].xmdl016) THEN LET g_xmdl_d[l_ac].xmdl016 = ' ' END IF  #批號 
   
END FUNCTION

################################################################################
# Descriptions...: 隱藏、替換畫面說明
# Memo...........:
# Usage..........: CALL axmt590_window_show(p_control)
# Input parameter:p_control：0.簽退單 1.借貨還量單
# Date & Author..: 2015/03/02 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION axmt590_window_show(p_control)
   DEFINE p_control     LIKE type_t.chr5
   DEFINE l_gzze003     LIKE gzze_t.gzze003

   CASE p_control
      WHEN '0'     #簽退單  
         CALL cl_set_comp_visible("xmdl089,xmdl090,xmdl091,xmdl092,xmdl093",FALSE) 
         CALL cl_set_act_visible_toolbaritem('axmt590_create_qc',FALSE)
         LET g_acc_type = 'axmt590'
      WHEN '1'     #借貨還量單   
         CALL cl_set_comp_visible("xmdl020",TRUE)

         CALL cl_getmsg('axm-00596',g_dlang) RETURNING l_gzze003     #借貨還量單號  
         CALL cl_set_comp_att_text('xmdkdocno',l_gzze003)

         CALL cl_getmsg('axm-00599',g_dlang) RETURNING l_gzze003     #扣帳日期 
         CALL cl_set_comp_att_text('xmdk001',l_gzze003)

         CALL cl_getmsg('axm-00531',g_dlang) RETURNING l_gzze003     #借貨還價單號 
         CALL cl_set_comp_att_text('xmdk081',l_gzze003)

         CALL cl_getmsg('axm-00533',g_dlang) RETURNING l_gzze003     #借貨出貨單號 
         CALL cl_set_comp_att_text('xmdk005',l_gzze003)

         CALL cl_getmsg('axm-00534',g_dlang) RETURNING l_gzze003     #借貨訂單單號 
         CALL cl_set_comp_att_text('xmdk006',l_gzze003)

         CALL cl_getmsg('axm-00535',g_dlang) RETURNING l_gzze003     #借貨還價數量  
         CALL cl_set_comp_att_text('xmdl018',l_gzze003) 
         
         CALL cl_getmsg('axm-00538',g_dlang) RETURNING l_gzze003     #借貨還價參考數量 
         CALL cl_set_comp_att_text('xmdl020',l_gzze003)

         CALL cl_getmsg('axm-00597',g_dlang) RETURNING l_gzze003     #還量QC合格數量 
         CALL cl_set_comp_att_text('xmdl081',l_gzze003)
         CALL cl_set_comp_att_text('xmdm031',l_gzze003)

         CALL cl_getmsg('axm-00598',g_dlang) RETURNING l_gzze003     #還量QC參考數量  
         CALL cl_set_comp_att_text('xmdl082',l_gzze003)
         CALL cl_set_comp_att_text('xmdm032',l_gzze003)

         CALL cl_getmsg('axm-00537',g_dlang) RETURNING l_gzze003     #借貨還價理由碼 
         CALL cl_set_comp_att_text('xmdl084',l_gzze003)

         LET g_acc_type = 'axmt591'

      OTHERWISE
         CALL cl_set_comp_visible("xmdl089,xmdl090,xmdl091,xmdl092,xmdl093",FALSE) 
         CALL cl_set_act_visible_toolbaritem('axmt590_create_qc',FALSE)
         LET g_acc_type = 'axmt590'

   END CASE
END FUNCTION

################################################################################
# Descriptions...: 串查單號
# Memo...........:
# Usage..........: CALL axmt590_qrystr(p_docno)
# Input parameter: p_docno   查詢單號
# Date & Author..: 2015/04/29 By Shiun
# Modify.........:
################################################################################
PRIVATE FUNCTION axmt590_qrystr(p_docno)
   DEFINE p_docno LIKE xmdk_t.xmdkdocno
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
# Descriptions...: 取得一次性交易對象說明
# Memo...........:
# Usage..........: CALL axmt590_get_pmak003()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/12/28 By dorislai(#161207-00033#18)
# Modify.........:
################################################################################
PRIVATE FUNCTION axmt590_get_pmak003()
   DEFINE   l_pmak003   LIKE  pmak_t.pmak003
   DEFINE   l_pmaa004   LIKE  pmaa_t.pmaa004
   
   LET l_pmak003 = ''
   LET l_pmaa004 = ''
   SELECT pmaa004 INTO l_pmaa004
     FROM pmaa_t
    WHERE pmaaent = g_enterprise AND pmaa001 = g_xmdk_m.xmdk007
   
   IF l_pmaa004 = '2' THEN   
      CALL s_desc_axm_get_oneturn_guest_desc('4',g_xmdk_m.xmdkdocno)
             RETURNING l_pmak003              
      IF NOT cl_null(l_pmak003) THEN
         LET g_xmdk_m.xmdk007_desc = l_pmak003
         IF g_xmdk_m.xmdk009 = g_xmdk_m.xmdk007 THEN   #收貨客戶
            LET g_xmdk_m.xmdk009_desc = g_xmdk_m.xmdk007_desc
         END IF          
         IF g_xmdk_m.xmdk008 = g_xmdk_m.xmdk007 THEN   #帳款客戶
            LET g_xmdk_m.xmdk008_desc = g_xmdk_m.xmdk007_desc
         END IF
         DISPLAY BY NAME g_xmdk_m.xmdk007_desc,g_xmdk_m.xmdk008_desc,g_xmdk_m.xmdk009_desc     
      END IF    
   END IF

END FUNCTION

################################################################################
#161031-00025#28 add
#維護備註單身
################################################################################
PRIVATE FUNCTION axmt590_remaks()

   IF g_xmdk_m.xmdkdocno IS NULL THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()
      RETURN
   END IF
       
   CALL s_transaction_begin()
   
   OPEN axmt590_cl USING g_enterprise,g_xmdk_m.xmdkdocno

   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "OPEN axmt590_cl:"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CLOSE axmt590_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #鎖住將被更改的資料
   FETCH axmt590_cl INTO g_xmdk_m.xmdk000,g_xmdk_m.xmdksite,g_xmdk_m.xmdkdocno,g_xmdk_m.xmdkdocno_desc,g_xmdk_m.xmdkdocdt, 
       g_xmdk_m.xmdk001,g_xmdk_m.xmdk003,g_xmdk_m.xmdk003_desc,g_xmdk_m.xmdk004,g_xmdk_m.xmdk004_desc, 
       g_xmdk_m.xmdkstus,g_xmdk_m.xmdk081,g_xmdk_m.xmdk005,g_xmdk_m.xmdk006,g_xmdk_m.xmdk002,g_xmdk_m.xmdk007, 
       g_xmdk_m.xmdk007_desc,g_xmdk_m.xmdk009,g_xmdk_m.xmdk009_desc,g_xmdk_m.xmdk008,g_xmdk_m.xmdk008_desc, 
       g_xmdk_m.xmdkownid,g_xmdk_m.xmdkownid_desc,g_xmdk_m.xmdkowndp,g_xmdk_m.xmdkowndp_desc,g_xmdk_m.xmdkcrtid, 
       g_xmdk_m.xmdkcrtid_desc,g_xmdk_m.xmdkcrtdp,g_xmdk_m.xmdkcrtdp_desc,g_xmdk_m.xmdkcrtdt,g_xmdk_m.xmdkmodid, 
       g_xmdk_m.xmdkmodid_desc,g_xmdk_m.xmdkmoddt,g_xmdk_m.xmdkcnfid,g_xmdk_m.xmdkcnfid_desc,g_xmdk_m.xmdkcnfdt, 
       g_xmdk_m.xmdkpstid,g_xmdk_m.xmdkpstid_desc,g_xmdk_m.xmdkpstdt
       
   #資料被他人LOCK, 或是sql執行時出現錯誤
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = g_xmdk_m.xmdkdocno
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      CLOSE axmt590_cl
      CALL s_transaction_end('N','0')
      RETURN 
   END IF
 
   #檢查是否允許此動作
   IF NOT axmt590_action_chk() THEN
      CLOSE axmt590_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   LET g_detail_insert = cl_auth_detail_input("insert")
   LET g_detail_delete = cl_auth_detail_input("delete")
   
   LET g_ooff001_d = '6'   #6.單據單頭備註
   LET g_ooff002_d = g_prog   
   LET g_ooff003_d = g_xmdk_m.xmdkdocno   #单号  
   LET g_ooff004_d = '0'    #项次
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
         LET g_detail_idx_list[3] = 1
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
         CALL g_curr_diag.setCurrentRow("s_detail3",1)
 
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
         LET g_detail_idx_list[3] = 1
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
         CALL g_curr_diag.setCurrentRow("s_detail3",1)
 
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
    
   CLOSE axmt590_cl
   
   CALL s_transaction_end('Y','0')
   
   CALL aooi360_01_b_fill(g_ooff001_d,g_ooff002_d,g_ooff003_d,g_ooff004_d,g_ooff005_d,g_ooff006_d,g_ooff007_d,g_ooff008_d,g_ooff009_d,g_ooff010_d,g_ooff011_d)   #备注单身
   
END FUNCTION

 
{</section>}
 
