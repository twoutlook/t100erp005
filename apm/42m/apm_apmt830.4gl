#該程式未解開Section, 採用最新樣板產出!
{<section id="apmt830.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0024(2017-01-17 14:40:27), PR版次:0024(2017-02-22 14:47:47)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000365
#+ Filename...: apmt830
#+ Description: 要貨單維護作業
#+ Creator....: 06137(2015-03-20 16:47:58)
#+ Modifier...: 08172 -SD/PR- 08171
 
{</section>}
 
{<section id="apmt830.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#151224-00025#3   2015/12/24  By fionchen 產品特徵欄位若無開窗輸入反而自行手動輸入時,則無法新增至inam_t
#160314-00009#4   2016/03/16  By zhujing  各程式增加产品特征是否需要自动开窗的程式段处理
#160318-00005#37  2016/03/29  By 07900    重复错误讯息修改
#160318-00025#21  2016/04/20  BY 07900    校验代码重复错误讯息的修改
#160816-00068#15  2016/08/18  By earl     調整transaction
#160818-00017#28  2016/08/24  By 08742    删除修改未重新判断状态码
#160831-00018#1   2016/09/01  By 06814    1.單頭來源類型字段中，
#                                           要貨單不會用到的選項需隱藏(2.銷售訂單3.銷售預測4.鋪貨申請5.專案項目)
#                                         2.查詢資料時，單別的單據性質為請購單的單據資料過濾掉不顯示。
#160824-00007#18  2016/09/14  By 06814    舊值備份處理
#160919-00053#1   2016/09/20  By 06814    單身商品依產品特徵自動產生多筆單身時,緊急度欄位需賦值
#161016-00001#1   2016/10/10  by 08742    新增加的前端单号字段
#161017-00029#1   2016/10/18  by 08742    1.录入条码或开窗选择条码后，需要根据条码带出产品特征imay019，
#                                         2.录入产品特征或开窗选择产品特征后，需要根据商品和产品特征带出条码imay003
#161021-00023#4   2016/10/21  by 08172    新增前端类型
#161129-00067#2   2016/11/30  by 08172    单身标牌价名称改为预计销货价格，此字段取值由imaa157改为imaa116
#161124-00039#1   2016/12/06  by geza     使用inax计算可用库存
#161214-00004#3   2016/12/21  by sunxh    单身大类取值逻辑改为该条明细商品对应品类的一级品类，对应说明栏位逻辑做对应改动
#161220-00059#2   2016/12/21  by 08172    1.新增一个'TJ已提交'的单据状态，用于门店系统上传单据状态赋值；
#                                         'TJ-已提交'状态的单据允许修改，但在修改状态下只允许修改要货量与备注信息，其他字段不允许修改。
#                                          在此状态下可审核可取消审核，前端单号不为空时不能删除(提示报错)，可复制单前端类型和前端单号要清空。
#                                         2.单身增加pmdb261门店要货量
#170116-00018#1   2017/01/16  by 08172    当当单头配送仓为空时单身新增时预带配送仓
#161228-00033#3   2017/02/08  by sakura   為了客戶DB種類的相容性:rownum寫法的改寫
#170216-00051#1   2017/02/17  by 06814    查詢資料時,將pmda200=4.鋪貨申請 的資料開放出來
#170217-00003#1   2017/02/20  By 08171    單身庫位編號依收貨組織校驗
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
PRIVATE type type_g_pmda_m        RECORD
       pmdasite LIKE pmda_t.pmdasite, 
   pmdasite_desc LIKE type_t.chr80, 
   pmda200 LIKE pmda_t.pmda200, 
   pmdadocdt LIKE pmda_t.pmdadocdt, 
   pmdadocno LIKE pmda_t.pmdadocno, 
   pmda001 LIKE pmda_t.pmda001, 
   pmda002 LIKE pmda_t.pmda002, 
   pmda002_desc LIKE type_t.chr80, 
   pmda003 LIKE pmda_t.pmda003, 
   pmda003_desc LIKE type_t.chr80, 
   pmdastus LIKE pmda_t.pmdastus, 
   pmda202 LIKE pmda_t.pmda202, 
   pmda202_desc LIKE type_t.chr80, 
   pmda201 LIKE pmda_t.pmda201, 
   pmda203 LIKE pmda_t.pmda203, 
   pmda203_desc LIKE type_t.chr80, 
   pmda207 LIKE pmda_t.pmda207, 
   pmda007 LIKE pmda_t.pmda007, 
   pmda006 LIKE pmda_t.pmda006, 
   pmda004 LIKE pmda_t.pmda004, 
   pmda020 LIKE pmda_t.pmda020, 
   pmda028 LIKE pmda_t.pmda028, 
   pmda027 LIKE pmda_t.pmda027, 
   pmda204 LIKE pmda_t.pmda204, 
   pmda204_desc LIKE type_t.chr80, 
   pmda205 LIKE pmda_t.pmda205, 
   pmda205_desc LIKE type_t.chr80, 
   pmda206 LIKE pmda_t.pmda206, 
   pmda206_desc LIKE type_t.chr80, 
   pmda021 LIKE pmda_t.pmda021, 
   pmda021_desc LIKE type_t.chr80, 
   pmda208 LIKE pmda_t.pmda208, 
   l_amts LIKE type_t.chr500, 
   pmda022 LIKE pmda_t.pmda022, 
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
   pmdacnfdt LIKE pmda_t.pmdacnfdt, 
   pmdapstid LIKE pmda_t.pmdapstid, 
   pmdapstid_desc LIKE type_t.chr80, 
   pmdapstdt LIKE pmda_t.pmdapstdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_pmdb_d        RECORD
       pmdbseq LIKE pmdb_t.pmdbseq, 
   pmdb001 LIKE pmdb_t.pmdb001, 
   pmdb002 LIKE pmdb_t.pmdb002, 
   pmdb003 LIKE pmdb_t.pmdb003, 
   pmdbsite LIKE pmdb_t.pmdbsite, 
   pmdbsite_desc LIKE type_t.chr500, 
   pmdb200 LIKE pmdb_t.pmdb200, 
   pmdb004 LIKE pmdb_t.pmdb004, 
   pmdb004_desc LIKE type_t.chr500, 
   pmdb004_desc_desc LIKE type_t.chr500, 
   pmdb005 LIKE pmdb_t.pmdb005, 
   pmdb005_desc LIKE type_t.chr500, 
   imaa154 LIKE type_t.chr500, 
   imaa155 LIKE type_t.chr500, 
   imaa156 LIKE type_t.chr500, 
   imaa132 LIKE type_t.chr500, 
   imaa132_desc LIKE type_t.chr500, 
   rtaw001 LIKE type_t.chr500, 
   imaa128_desc LIKE type_t.chr500, 
   imaa009 LIKE type_t.chr500, 
   imaa009_desc LIKE type_t.chr500, 
   imaa116 LIKE type_t.chr500, 
   pmdb033 LIKE pmdb_t.pmdb033, 
   pmdb037 LIKE pmdb_t.pmdb037, 
   pmdb037_desc LIKE type_t.chr500, 
   pmdb260 LIKE pmdb_t.pmdb260, 
   pmdb260_desc LIKE type_t.chr500, 
   pmdb038 LIKE pmdb_t.pmdb038, 
   pmdb038_desc LIKE type_t.chr500, 
   pmdb227 LIKE pmdb_t.pmdb227, 
   pmdb201 LIKE pmdb_t.pmdb201, 
   pmdb201_desc LIKE type_t.chr500, 
   pmdb202 LIKE pmdb_t.pmdb202, 
   pmdb212 LIKE pmdb_t.pmdb212, 
   pmdb007 LIKE pmdb_t.pmdb007, 
   pmdb007_desc LIKE type_t.chr500, 
   pmdb213 LIKE pmdb_t.pmdb213, 
   pmdb261 LIKE pmdb_t.pmdb261, 
   pmdb006 LIKE pmdb_t.pmdb006, 
   l_amtr LIKE type_t.num20_6, 
   pmdb253 LIKE pmdb_t.pmdb253, 
   pmdb258 LIKE pmdb_t.pmdb258, 
   pmdb254 LIKE pmdb_t.pmdb254, 
   pmdb255 LIKE pmdb_t.pmdb255, 
   pmdb256 LIKE pmdb_t.pmdb256, 
   pmdb257 LIKE pmdb_t.pmdb257, 
   pmdb259 LIKE pmdb_t.pmdb259, 
   pmdb252 LIKE pmdb_t.pmdb252, 
   l_pmdb252 LIKE type_t.num20_6, 
   pmdb207 LIKE pmdb_t.pmdb207, 
   pmdb015 LIKE pmdb_t.pmdb015, 
   pmdb015_desc LIKE type_t.chr500, 
   pmdb049 LIKE pmdb_t.pmdb049, 
   pmdb030 LIKE pmdb_t.pmdb030, 
   pmdb048 LIKE pmdb_t.pmdb048, 
   pmdb048_desc LIKE type_t.chr500, 
   pmdb208 LIKE pmdb_t.pmdb208, 
   pmdb209 LIKE pmdb_t.pmdb209, 
   pmdb209_desc LIKE type_t.chr500, 
   pmdb206 LIKE pmdb_t.pmdb206, 
   pmdb206_desc LIKE type_t.chr500, 
   pmdb210 LIKE pmdb_t.pmdb210, 
   pmdb211 LIKE pmdb_t.pmdb211, 
   pmdb205 LIKE pmdb_t.pmdb205, 
   pmdb205_desc LIKE type_t.chr500, 
   pmdb203 LIKE pmdb_t.pmdb203, 
   pmdb203_desc LIKE type_t.chr500, 
   pmdb204 LIKE pmdb_t.pmdb204, 
   pmdb204_desc LIKE type_t.chr500, 
   pmdb032 LIKE pmdb_t.pmdb032, 
   pmdb051 LIKE pmdb_t.pmdb051, 
   pmdb051_desc LIKE type_t.chr500
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_pmdasite LIKE pmda_t.pmdasite,
   b_pmdasite_desc LIKE type_t.chr80,
      b_pmda200 LIKE pmda_t.pmda200,
      b_pmdadocdt LIKE pmda_t.pmdadocdt,
      b_pmdadocno LIKE pmda_t.pmdadocno,
      b_pmda001 LIKE pmda_t.pmda001,
      b_pmda002 LIKE pmda_t.pmda002,
   b_pmda002_desc LIKE type_t.chr80,
      b_pmda003 LIKE pmda_t.pmda003,
   b_pmda003_desc LIKE type_t.chr80,
      b_pmda202 LIKE pmda_t.pmda202,
   b_pmda202_desc LIKE type_t.chr80,
      b_pmda201 LIKE pmda_t.pmda201,
      b_pmda203 LIKE pmda_t.pmda203,
   b_pmda203_desc LIKE type_t.chr80,
      b_pmda207 LIKE pmda_t.pmda207,
      b_pmda204 LIKE pmda_t.pmda204,
   b_pmda204_desc LIKE type_t.chr80,
      b_pmda205 LIKE pmda_t.pmda205,
   b_pmda205_desc LIKE type_t.chr80,
      b_pmda206 LIKE pmda_t.pmda206,
   b_pmda206_desc LIKE type_t.chr80,
      b_pmda021 LIKE pmda_t.pmda021,
   b_pmda021_desc LIKE type_t.chr80,
      b_pmda022 LIKE pmda_t.pmda022,
      b_pmda208 LIKE pmda_t.pmda208
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_ooef004             LIKE ooef_t.ooef004
DEFINE g_site_flag           LIKE type_t.num5
DEFINE g_docno_wc            STRING                #160831-00018#1 20160901 add by beckxie
DEFINE g_master_idx          LIKE type_t.num10     #161220-00059#2 by 08172
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
 
{<section id="apmt830.main" >}
#應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success LIKE type_t.num5 #150308-00001#1  By Ken 150309
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("apm","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT pmdasite,'',pmda200,pmdadocdt,pmdadocno,pmda001,pmda002,'',pmda003,'', 
       pmdastus,pmda202,'',pmda201,pmda203,'',pmda207,pmda007,pmda006,pmda004,pmda020,pmda028,pmda027, 
       pmda204,'',pmda205,'',pmda206,'',pmda021,'',pmda208,'',pmda022,pmdaownid,'',pmdaowndp,'',pmdacrtid, 
       '',pmdacrtdp,'',pmdacrtdt,pmdamodid,'',pmdamoddt,pmdacnfid,'',pmdacnfdt,pmdapstid,'',pmdapstdt", 
        
                      " FROM pmda_t",
                      " WHERE pmdaent= ? AND pmdadocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE apmt830_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.pmdasite,t0.pmda200,t0.pmdadocdt,t0.pmdadocno,t0.pmda001,t0.pmda002, 
       t0.pmda003,t0.pmdastus,t0.pmda202,t0.pmda201,t0.pmda203,t0.pmda207,t0.pmda007,t0.pmda006,t0.pmda004, 
       t0.pmda020,t0.pmda028,t0.pmda027,t0.pmda204,t0.pmda205,t0.pmda206,t0.pmda021,t0.pmda208,t0.pmda022, 
       t0.pmdaownid,t0.pmdaowndp,t0.pmdacrtid,t0.pmdacrtdp,t0.pmdacrtdt,t0.pmdamodid,t0.pmdamoddt,t0.pmdacnfid, 
       t0.pmdacnfdt,t0.pmdapstid,t0.pmdapstdt,t1.ooefl003 ,t2.ooag011 ,t3.ooefl003 ,t4.rtaxl003 ,t5.ooefl003 , 
       t6.ooefl003 ,t7.ooefl003 ,t8.inayl003 ,t9.oocql004 ,t10.ooag011 ,t11.ooefl003 ,t12.ooag011 ,t13.ooefl003 , 
       t14.ooag011 ,t15.ooag011 ,t16.ooag011",
               " FROM pmda_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.pmdasite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.pmda002  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.pmda003 AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN rtaxl_t t4 ON t4.rtaxlent="||g_enterprise||" AND t4.rtaxl001=t0.pmda202 AND t4.rtaxl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.pmda203 AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent="||g_enterprise||" AND t6.ooefl001=t0.pmda204 AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t7 ON t7.ooeflent="||g_enterprise||" AND t7.ooefl001=t0.pmda205 AND t7.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN inayl_t t8 ON t8.inaylent="||g_enterprise||" AND t8.inayl001=t0.pmda206 AND t8.inayl002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t9 ON t9.oocqlent="||g_enterprise||" AND t9.oocql001='263' AND t9.oocql002=t0.pmda021 AND t9.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t10 ON t10.ooagent="||g_enterprise||" AND t10.ooag001=t0.pmdaownid  ",
               " LEFT JOIN ooefl_t t11 ON t11.ooeflent="||g_enterprise||" AND t11.ooefl001=t0.pmdaowndp AND t11.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t12 ON t12.ooagent="||g_enterprise||" AND t12.ooag001=t0.pmdacrtid  ",
               " LEFT JOIN ooefl_t t13 ON t13.ooeflent="||g_enterprise||" AND t13.ooefl001=t0.pmdacrtdp AND t13.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t14 ON t14.ooagent="||g_enterprise||" AND t14.ooag001=t0.pmdamodid  ",
               " LEFT JOIN ooag_t t15 ON t15.ooagent="||g_enterprise||" AND t15.ooag001=t0.pmdacnfid  ",
               " LEFT JOIN ooag_t t16 ON t16.ooagent="||g_enterprise||" AND t16.ooag001=t0.pmdapstid  ",
 
               " WHERE t0.pmdaent = " ||g_enterprise|| " AND t0.pmdadocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE apmt830_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_apmt830 WITH FORM cl_ap_formpath("apm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL apmt830_init()   
 
      #進入選單 Menu (="N")
      CALL apmt830_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_apmt830
      
   END IF 
   
   CLOSE apmt830_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success #150308-00001#1  By Ken 150309
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="apmt830.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION apmt830_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point    
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success LIKE type_t.num5 #150308-00001#1  By Ken 150309
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
      CALL cl_set_combo_scc_part('pmdastus','13','Y,N,TJ,C,A,D,R,W,UH,H,X')
 
      CALL cl_set_combo_scc('pmda200','6552') 
   CALL cl_set_combo_scc('pmda201','6014') 
   CALL cl_set_combo_scc('pmda028','6971') 
   CALL cl_set_combo_scc('pmdb033','2036') 
   CALL cl_set_combo_scc('pmdb207','6014') 
   CALL cl_set_combo_scc('pmdb208','6013') 
   CALL cl_set_combo_scc('pmdb032','2035') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   
   CALL s_aooi500_create_temp() RETURNING l_success #150308-00001#1  By Ken 150309   
   #CALL cl_set_combo_scc('b_pmda200','6552')                   #160831-00018#1 20160901 mark by beckxie
   #170216-00051#1 20170217 mark by beckxie---S
   #CALL cl_set_combo_scc_part('pmda200','6552','0,1,6,7,8')     #160831-00018#1 20160901  add by beckxie
   #CALL cl_set_combo_scc_part('b_pmda200','6552','0,1,6,7,8')   #160831-00018#1 20160901  add by beckxie
   #170216-00051#1 20170217 mark by beckxie---E
   #170216-00051#1 20170217 add by beckxie---S
   CALL cl_set_combo_scc_part('pmda200','6552','0,1,4,6,7,8')
   CALL cl_set_combo_scc_part('b_pmda200','6552','0,1,4,6,7,8')
   #170216-00051#1 20170217 add by beckxie---E
   CALL cl_set_combo_scc('b_pmda201','6014')
   #161220-00059#2 -s by 08172   
#   CALL cl_set_combo_scc_part('pmdastus','13','N,Y,A,D,R,W,X')
   CALL cl_set_combo_scc_part('pmdastus','13','N,Y,A,D,R,W,TJ,X')
   #161220-00059#2 -e by 08172 
   LET g_errshow = 1
   
   #160314-00009#4 zhujing add 2016-3-16---(S)
   #判斷據點參數若不使用產品特徵時，則產品特徵需隱藏不可以維護(據點參數:S-BAS-0036)
   IF cl_get_para(g_enterprise,g_site,'S-BAS-0036') = 'N' THEN
      CALL cl_set_comp_visible("pmdb005,pmdb005_desc",FALSE)
   END IF
   #160314-00009#4 zhujing add 2016-3-16---(E)
   
   #LET g_prog = 'apmt830' #暫時使用
   
   #end add-point
   
   #初始化搜尋條件
   CALL apmt830_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="apmt830.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION apmt830_ui_dialog()
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
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_wc          STRING
   DEFINE l_pr   RECORD
            pmdasite   LIKE pmda_t.pmdasite ,
            pmdadocno  LIKE pmda_t.pmdadocno,
            pmdadocdt  LIKE pmda_t.pmdadocdt,
            pmda207    LIKE pmda_t.pmda207,
            pmda203    LIKE pmda_t.pmda203,
            pmda002    LIKE pmda_t.pmda002,
            pmda003    LIKE pmda_t.pmda003,
            pmda021    LIKE pmda_t.pmda021,
            pmda201    LIKE pmda_t.pmda201,
            pmda204    LIKE pmda_t.pmda204,
            pmda205    LIKE pmda_t.pmda205
                END RECORD
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
            CALL apmt830_insert()
            #add-point:ON ACTION insert name="menu.default.insert"
            
            #END add-point
         END IF
 
      #add-point:action default自訂 name="ui_dialog.action_default"
      
      #end add-point
      OTHERWISE
   END CASE
 
 
 
   
   LET lb_first = TRUE
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   #150324-00006#14 2015/04/09 By pomelo add(S)
   LET g_forupd_sql = "SELECT pmdbseq,pmdb001,pmdb002,pmdb003,pmdbsite,pmdb200,pmdb004,pmdb005,pmdb033, 
       pmdb037,pmdb260,pmdb038,pmdb201,pmdb202,pmdb212,pmdb007,pmdb006,pmdb253,pmdb258,pmdb254,pmdb255, 
       pmdb256,pmdb257,pmdb259,pmdb252,pmdb207,pmdb015,pmdb049,pmdb030,pmdb048,pmdb208,pmdb209,pmdb206, 
       pmdb210,pmdb211,pmdb205,pmdb203,pmdb204,pmdb032,pmdb051 FROM pmdb_t WHERE pmdbent=? AND pmdbdocno=?  
       AND pmdbseq=? FOR UPDATE"
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE apmt830_upd_pmdb033 CURSOR FROM g_forupd_sql
   #150324-00006#14 2015/04/09 By pomelo add(E)
   #end add-point
   
   WHILE TRUE 
   
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_pmda_m.* TO NULL
         CALL g_pmdb_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL apmt830_init()
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
               
               CALL apmt830_fetch('') # reload data
               LET l_ac = 1
               CALL apmt830_ui_detailshow() #Setting the current row 
         
               CALL apmt830_idx_chk()
               #NEXT FIELD pmdbseq
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_pmdb_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL apmt830_idx_chk()
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
               CALL apmt830_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               #150416-00001#1 150818 by sakura add(S)
               CALL apmt830_set_act_visible_b()
               CALL apmt830_set_act_no_visible_b()               
               #150416-00001#1 150818 by sakura add(E)
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION detail_qrystr
               MENU "" ATTRIBUTE(STYLE="popup")
                  #add-point:ON ACTION detail_qrystr相關動作 name="menu.detail_show.page1_sub.detail_qrystr"
                  #150416-00001#1 150818 by sakura add(S)
                  BEFORE MENU
                    IF g_detail_idx = 0 THEN
                       HIDE OPTION "prog_artt770"
                       EXIT MENU
                    ELSE
					   IF cl_null(g_pmdb_d[g_detail_idx].pmdb001) THEN
                          HIDE OPTION "prog_artt770"
                          EXIT MENU
                       END IF                                         
                    END IF                  
                  #150416-00001#1 150818 by sakura add(E)
                  #END add-point
                                 #應用 a43 樣板自動產生(Version:4)
               ON ACTION prog_artt770
                  LET g_action_choice="prog_artt770"
                  IF cl_auth_chk_act("prog_artt770") THEN
                     
                     #add-point:ON ACTION prog_artt770 name="menu.detail_show.page1_sub.prog_artt770"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               INITIALIZE la_param.* TO NULL
               #150416-00001#1 150818 by sakura add(S)
               CASE g_pmda_m.pmda200
                  WHEN '1'
                     LET la_param.prog     = 'artt770'
                  WHEN '2'
                     LET la_param.prog     = 'adbt500'
                  WHEN '4'
                     LET la_param.prog     = 'apmt832'
                  WHEN '6'
                     LET la_param.prog     = 'artt405'
                  OTHERWISE
                     EXIT DIALOG                     
               END CASE               
               #150416-00001#1 150818 by sakura add(E)
               LET la_param.param[1] = g_pmdb_d[l_ac].pmdb001

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
         
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
      
         BEFORE DIALOG
            #先填充browser資料
            CALL apmt830_browser_fill("")
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
               CALL apmt830_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL apmt830_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL apmt830_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL apmt830_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL apmt830_set_act_visible()   
            CALL apmt830_set_act_no_visible()
            IF NOT (g_pmda_m.pmdadocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " pmdaent = " ||g_enterprise|| " AND",
                                  " pmdadocno = '", g_pmda_m.pmdadocno, "' "
 
               #填到對應位置
               CALL apmt830_browser_fill("")
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
               CALL apmt830_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                  CALL apmt830_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL apmt830_fetch("F")
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
               CALL apmt830_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL apmt830_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apmt830_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL apmt830_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apmt830_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL apmt830_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apmt830_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL apmt830_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apmt830_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL apmt830_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apmt830_idx_chk()
          
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
               CALL apmt830_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL apmt830_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL apmt830_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL apmt830_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION upd_pmdb033
            LET g_action_choice="upd_pmdb033"
            IF cl_auth_chk_act("upd_pmdb033") THEN
               
               #add-point:ON ACTION upd_pmdb033 name="menu.upd_pmdb033"
               #150324-00006#14 2015/04/09 By pomelo add(S)
               CALL apmt830_upd_pmdb033()
               #150324-00006#14 2015/04/09 By pomelo add(E)
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               LET g_rep_wc = " pmdaent = "|| g_enterprise ||" AND pmdadocno = '"||g_pmda_m.pmdadocno||"'" #150324-00006#4 150331
               #END add-point
               &include "erp/apm/apmt830_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               LET g_rep_wc = " pmdaent = "|| g_enterprise ||" AND pmdadocno = '"||g_pmda_m.pmdadocno||"'" #150324-00006#4 150331
               #END add-point
               &include "erp/apm/apmt830_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL apmt830_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_s_apmp841_2
            LET g_action_choice="open_s_apmp841_2"
            IF cl_auth_chk_act("open_s_apmp841_2") THEN
               
               #add-point:ON ACTION open_s_apmp841_2 name="menu.open_s_apmp841_2"
               #150521-00028#1 Add By Ken(S) 150724
               IF NOT apmt830_pmdadocno_chk(g_pmda_m.pmdadocno) THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "apm-00979" 
                  LET g_errparam.popup  = TRUE
                  LET g_errparam.replace[1] = g_pmda_m.pmdadocno           
                  CALL cl_err()     
                  EXIT DIALOG                  
               END IF 
               #150521-00028#1 Add By Ken(E) 150724
               
               IF g_pmda_m.pmdastus = 'Y' THEN
                  CALL s_apmp841_create_tmp() RETURNING l_success
                  CALL s_transaction_begin()
                  CALL cl_err_collect_init()
                  
                  LET l_pr.pmdasite  = g_pmda_m.pmdasite
                  LET l_pr.pmdadocno = g_pmda_m.pmdadocno
                  LET l_pr.pmdadocdt = g_pmda_m.pmdadocdt
                  LET l_pr.pmda207   = g_pmda_m.pmda207
                  LET l_pr.pmda203   = g_pmda_m.pmda203
                  LET l_pr.pmda002   = g_pmda_m.pmda002
                  LET l_pr.pmda003   = g_pmda_m.pmda003
                  LET l_pr.pmda021   = g_pmda_m.pmda021
                  #LET l_pr.pmda201   = g_pmda_m.pmda201
                  LET l_pr.pmda201   = 0 #自訂貨
                  LET l_pr.pmda204   = g_pmda_m.pmda204
                  LET l_pr.pmda205   = g_pmda_m.pmda205
                  
                  CALL s_apmp841_2(l_pr.*) RETURNING l_success,l_wc
                  IF l_success THEN
                     CALL cl_err_collect_show()
                     CALL s_transaction_end('Y',0)
                     IF NOT cl_null(l_wc) THEN
                        IF NOT cl_null(l_wc) THEN
                           LET la_param.prog = 'apmt840'
                           LET la_param.param[1] = ''
                           LET la_param.param[2] = l_wc
                           LET ls_js = util.JSON.stringify(la_param)
                           CALL cl_cmdrun(ls_js)
                        END IF               
                     END IF
                  ELSE
                     CALL cl_err_collect_show()
                     CALL s_transaction_end('N',0)
                  END IF
               ELSE
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "-100" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()               
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL apmt830_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_pmda002
            LET g_action_choice="prog_pmda002"
            IF cl_auth_chk_act("prog_pmda002") THEN
               
               #add-point:ON ACTION prog_pmda002 name="menu.prog_pmda002"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               #150721-00002#1 150721 by sakura mark(S)
               #INITIALIZE la_param.* TO NULL
               #LET la_param.prog     = 'cl_user_contact("aooi130",'
               #LET la_param.param[1] = "ooag_t"
               #LET la_param.param[2] =  "ooag002"
               #LET la_param.param[3] =  "ooag001")
               #LET ls_js = util.JSON.stringify(la_param)
               #CALL cl_cmdrun_wait(ls_js)
               #150721-00002#1 150721 by sakura mark(E)
               CALL cl_user_contact("aooi130", "ooag_t", "ooag002", "ooag001",g_pmda_m.pmda002)   #150721-00002#1 150721 by sakura add
 


               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL apmt830_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL apmt830_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL apmt830_set_pk_array()
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
 
{<section id="apmt830.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION apmt830_browser_fill(ps_page_action)
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
   DEFINE l_oobx001         LIKE oobx_t.oobx001   #160831-00018#1 20160901 add by beckxie
   #end add-point    
   
   #add-point:Function前置處理 name="browser_fill.before_browser_fill"
   CALL s_aooi500_sql_where(g_prog,'pmdasite') RETURNING l_where
   #160831-00018#1 20160901 add by beckxie---S
   #將請購單的單據濾除
   DECLARE apmt830_docnowc_cs
   CURSOR FOR SELECT DISTINCT oobx001
                FROM oobx_t
               WHERE oobxent = g_enterprise 
                 AND oobx003 = 'apmt400'
   #組濾除的wc
   LET g_docno_wc =""
   FOREACH apmt830_docnowc_cs INTO l_oobx001
      LET g_docno_wc = g_docno_wc," AND pmdadocno NOT LIKE '%"||l_oobx001||"-%'"
   END FOREACH
   #DISPLAY "g_docno_wc :",g_docno_wc 
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1 " , g_docno_wc
   ELSE
      LET g_wc = g_wc , g_docno_wc
   END IF
   #LET g_wc = g_wc , " AND pmda200 IN ('0','1','6','7','8') "      #170216-00051#1 20170217 mark by beckxie
   LET g_wc = g_wc , " AND pmda200 IN ('0','1','4','6','7','8') "   #170216-00051#1 20170217 add by beckxie
   #160831-00018#1 20160901 add by beckxie---E
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
      LET l_sub_sql = " SELECT DISTINCT pmdadocno ",
                      " FROM pmda_t ",
                      " ",
                      " LEFT JOIN pmdb_t ON pmdbent = pmdaent AND pmdadocno = pmdbdocno ", "  ",
                      #add-point:browser_fill段sql(pmdb_t1) name="browser_fill.cnt.join.}"
                      #161214-00004#3 add by sunxh 161220(S)
                      " LEFT JOIN imaa_t ON imaaent = pmdaent  ", "  ",
                      #161214-00004#3 add by sunxh 161220(E)
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
   LET l_sub_sql = l_sub_sql," AND ", l_where
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
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.pmdasite,t0.pmda200,t0.pmdadocdt,t0.pmdadocno,t0.pmda001,t0.pmda002,t0.pmda003,t0.pmda202,t0.pmda201,t0.pmda203,t0.pmda207,t0.pmda204,t0.pmda205,t0.pmda206,t0.pmda021,t0.pmda022,t0.pmda208 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.pmdastus,t0.pmdasite,t0.pmda200,t0.pmdadocdt,t0.pmdadocno,t0.pmda001, 
          t0.pmda002,t0.pmda003,t0.pmda202,t0.pmda201,t0.pmda203,t0.pmda207,t0.pmda204,t0.pmda205,t0.pmda206, 
          t0.pmda021,t0.pmda022,t0.pmda208,t1.ooefl003 ,t2.ooag011 ,t3.ooefl003 ,t4.rtaxl003 ,t5.ooefl003 , 
          t6.ooefl003 ,t7.ooefl003 ,t8.inayl003 ,t9.oocql004 ",
                  " FROM pmda_t t0",
                  "  ",
                  "  LEFT JOIN pmdb_t ON pmdbent = pmdaent AND pmdadocno = pmdbdocno ", "  ", 
                  #add-point:browser_fill段sql(pmdb_t1) name="browser_fill.join.pmdb_t1"
                  #161214-00004#3 add by sunxh 161220(S)
                  " LEFT JOIN imaa_t ON imaaent = pmdaent AND IMAA001 = PMDB004 ", "  ",
                   #161214-00004#3 add by sunxh 161220(E)
                  #end add-point
 
 
                  " ", 
 
 
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.pmdasite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.pmda002  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.pmda003 AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN rtaxl_t t4 ON t4.rtaxlent="||g_enterprise||" AND t4.rtaxl001=t0.pmda202 AND t4.rtaxl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.pmda203 AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent="||g_enterprise||" AND t6.ooefl001=t0.pmda204 AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t7 ON t7.ooeflent="||g_enterprise||" AND t7.ooefl001=t0.pmda205 AND t7.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN inayl_t t8 ON t8.inaylent="||g_enterprise||" AND t8.inayl001=t0.pmda206 AND t8.inayl002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t9 ON t9.oocqlent="||g_enterprise||" AND t9.oocql001='263' AND t9.oocql002=t0.pmda021 AND t9.oocql003='"||g_dlang||"' ",
 
                  " WHERE t0.pmdaent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("pmda_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.pmdastus,t0.pmdasite,t0.pmda200,t0.pmdadocdt,t0.pmdadocno,t0.pmda001, 
          t0.pmda002,t0.pmda003,t0.pmda202,t0.pmda201,t0.pmda203,t0.pmda207,t0.pmda204,t0.pmda205,t0.pmda206, 
          t0.pmda021,t0.pmda022,t0.pmda208,t1.ooefl003 ,t2.ooag011 ,t3.ooefl003 ,t4.rtaxl003 ,t5.ooefl003 , 
          t6.ooefl003 ,t7.ooefl003 ,t8.inayl003 ,t9.oocql004 ",
                  " FROM pmda_t t0",
                  "  ",
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.pmdasite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.pmda002  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.pmda003 AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN rtaxl_t t4 ON t4.rtaxlent="||g_enterprise||" AND t4.rtaxl001=t0.pmda202 AND t4.rtaxl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.pmda203 AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent="||g_enterprise||" AND t6.ooefl001=t0.pmda204 AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t7 ON t7.ooeflent="||g_enterprise||" AND t7.ooefl001=t0.pmda205 AND t7.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN inayl_t t8 ON t8.inaylent="||g_enterprise||" AND t8.inayl001=t0.pmda206 AND t8.inayl002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t9 ON t9.oocqlent="||g_enterprise||" AND t9.oocql001='263' AND t9.oocql002=t0.pmda021 AND t9.oocql003='"||g_dlang||"' ",
 
                  " WHERE t0.pmdaent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("pmda_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   LET g_sql = g_sql," AND ", l_where
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
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_pmdasite,g_browser[g_cnt].b_pmda200, 
          g_browser[g_cnt].b_pmdadocdt,g_browser[g_cnt].b_pmdadocno,g_browser[g_cnt].b_pmda001,g_browser[g_cnt].b_pmda002, 
          g_browser[g_cnt].b_pmda003,g_browser[g_cnt].b_pmda202,g_browser[g_cnt].b_pmda201,g_browser[g_cnt].b_pmda203, 
          g_browser[g_cnt].b_pmda207,g_browser[g_cnt].b_pmda204,g_browser[g_cnt].b_pmda205,g_browser[g_cnt].b_pmda206, 
          g_browser[g_cnt].b_pmda021,g_browser[g_cnt].b_pmda022,g_browser[g_cnt].b_pmda208,g_browser[g_cnt].b_pmdasite_desc, 
          g_browser[g_cnt].b_pmda002_desc,g_browser[g_cnt].b_pmda003_desc,g_browser[g_cnt].b_pmda202_desc, 
          g_browser[g_cnt].b_pmda203_desc,g_browser[g_cnt].b_pmda204_desc,g_browser[g_cnt].b_pmda205_desc, 
          g_browser[g_cnt].b_pmda206_desc,g_browser[g_cnt].b_pmda021_desc
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
         CALL apmt830_browser_mask()
      
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
 
{<section id="apmt830.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION apmt830_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_pmda_m.pmdadocno = g_browser[g_current_idx].b_pmdadocno   
 
   EXECUTE apmt830_master_referesh USING g_pmda_m.pmdadocno INTO g_pmda_m.pmdasite,g_pmda_m.pmda200, 
       g_pmda_m.pmdadocdt,g_pmda_m.pmdadocno,g_pmda_m.pmda001,g_pmda_m.pmda002,g_pmda_m.pmda003,g_pmda_m.pmdastus, 
       g_pmda_m.pmda202,g_pmda_m.pmda201,g_pmda_m.pmda203,g_pmda_m.pmda207,g_pmda_m.pmda007,g_pmda_m.pmda006, 
       g_pmda_m.pmda004,g_pmda_m.pmda020,g_pmda_m.pmda028,g_pmda_m.pmda027,g_pmda_m.pmda204,g_pmda_m.pmda205, 
       g_pmda_m.pmda206,g_pmda_m.pmda021,g_pmda_m.pmda208,g_pmda_m.pmda022,g_pmda_m.pmdaownid,g_pmda_m.pmdaowndp, 
       g_pmda_m.pmdacrtid,g_pmda_m.pmdacrtdp,g_pmda_m.pmdacrtdt,g_pmda_m.pmdamodid,g_pmda_m.pmdamoddt, 
       g_pmda_m.pmdacnfid,g_pmda_m.pmdacnfdt,g_pmda_m.pmdapstid,g_pmda_m.pmdapstdt,g_pmda_m.pmdasite_desc, 
       g_pmda_m.pmda002_desc,g_pmda_m.pmda003_desc,g_pmda_m.pmda202_desc,g_pmda_m.pmda203_desc,g_pmda_m.pmda204_desc, 
       g_pmda_m.pmda205_desc,g_pmda_m.pmda206_desc,g_pmda_m.pmda021_desc,g_pmda_m.pmdaownid_desc,g_pmda_m.pmdaowndp_desc, 
       g_pmda_m.pmdacrtid_desc,g_pmda_m.pmdacrtdp_desc,g_pmda_m.pmdamodid_desc,g_pmda_m.pmdacnfid_desc, 
       g_pmda_m.pmdapstid_desc
   
   CALL apmt830_pmda_t_mask()
   CALL apmt830_show()
      
END FUNCTION
 
{</section>}
 
{<section id="apmt830.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION apmt830_ui_detailshow()
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
 
{<section id="apmt830.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION apmt830_ui_browser_refresh()
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
 
{<section id="apmt830.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION apmt830_construct()
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
   INITIALIZE g_pmda_m.* TO NULL
   CALL g_pmdb_d.clear()        
 
   
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
      CONSTRUCT BY NAME g_wc ON pmdasite,pmda200,pmdadocdt,pmdadocno,pmda001,pmda002,pmda003,pmdastus, 
          pmda202,pmda201,pmda203,pmda207,pmda007,pmda006,pmda004,pmda020,pmda028,pmda027,pmda204,pmda205, 
          pmda206,pmda021,pmda208,pmda022,pmdaownid,pmdaowndp,pmdacrtid,pmdacrtdp,pmdacrtdt,pmdamodid, 
          pmdamoddt,pmdacnfid,pmdacnfdt,pmdapstid,pmdapstdt
 
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
         AFTER FIELD pmdapstdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.pmdasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdasite
            #add-point:ON ACTION controlp INFIELD pmdasite name="construct.c.pmdasite"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'pmdasite',g_site,'c') #150308-00001#1  By Ken add 'c' 150309
            CALL q_ooef001_24()   
            DISPLAY g_qryparam.return1 TO pmdasite  #顯示到畫面上
            NEXT FIELD pmdasite                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdasite
            #add-point:BEFORE FIELD pmdasite name="construct.b.pmdasite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdasite
            
            #add-point:AFTER FIELD pmdasite name="construct.a.pmdasite"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmda200
            #add-point:BEFORE FIELD pmda200 name="construct.b.pmda200"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmda200
            
            #add-point:AFTER FIELD pmda200 name="construct.a.pmda200"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmda200
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmda200
            #add-point:ON ACTION controlp INFIELD pmda200 name="construct.c.pmda200"
            
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
 
 
         #Ctrlp:construct.c.pmdadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdadocno
            #add-point:ON ACTION controlp INFIELD pmdadocno name="construct.c.pmdadocno"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " 1=1 ",g_docno_wc   #160831-00018#1 20160901 add by beckxie
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
 
 
         #Ctrlp:construct.c.pmda002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmda002
            #add-point:ON ACTION controlp INFIELD pmda002 name="construct.c.pmda002"
            #應用 a08 樣板自動產生(Version:2)
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
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #CALL q_ooeg001()                           #呼叫開窗   #160303-00028#9 dongsz mark
            CALL q_ooeg001_9()             #呼叫開窗   #160303-00028#9 dongsz add
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
 
 
         #Ctrlp:construct.c.pmda202
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmda202
            #add-point:ON ACTION controlp INFIELD pmda202 name="construct.c.pmda202"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
			   CALL cl_get_para(g_enterprise,g_site,'E-CIR-0001') RETURNING l_sys #取得品類層級
            #給予arg
            LET g_qryparam.arg1 = l_sys #            
            CALL q_rtax001_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmda202  #顯示到畫面上
            NEXT FIELD pmda202                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmda202
            #add-point:BEFORE FIELD pmda202 name="construct.b.pmda202"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmda202
            
            #add-point:AFTER FIELD pmda202 name="construct.a.pmda202"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmda201
            #add-point:BEFORE FIELD pmda201 name="construct.b.pmda201"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmda201
            
            #add-point:AFTER FIELD pmda201 name="construct.a.pmda201"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmda201
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmda201
            #add-point:ON ACTION controlp INFIELD pmda201 name="construct.c.pmda201"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmda203
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmda203
            #add-point:ON ACTION controlp INFIELD pmda203 name="construct.c.pmda203"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            
            ##判斷aooi500是否有設定
            #IF s_aooi500_setpoint(g_prog,'pmda203') THEN
            #   LET g_qryparam.where = s_aooi500_q_where(g_prog,'pmda203',g_site,'c') #150308-00001#1  By Ken add 'c' 150309
            #   CALL q_ooef001_24()
            #ELSE    
            #   LET g_qryparam.arg1 = '2'
            #   LET g_qryparam.where = "ooef201 = 'Y'" #營運據點
            #   CALL q_ooef001()  
            #END IF            

            LET g_qryparam.where = s_aooi500_q_where(g_prog,'pmdbsite',g_site,'c') #150308-00001#1  By Ken add 'c' 150309
            CALL q_ooef001_24()                              #呼叫開窗

            DISPLAY g_qryparam.return1 TO pmda203  #顯示到畫面上
            NEXT FIELD pmda203                     #返回原欄位

            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmda203
            #add-point:BEFORE FIELD pmda203 name="construct.b.pmda203"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmda203
            
            #add-point:AFTER FIELD pmda203 name="construct.a.pmda203"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmda207
            #add-point:BEFORE FIELD pmda207 name="construct.b.pmda207"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmda207
            
            #add-point:AFTER FIELD pmda207 name="construct.a.pmda207"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmda207
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmda207
            #add-point:ON ACTION controlp INFIELD pmda207 name="construct.c.pmda207"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmda007
            #add-point:BEFORE FIELD pmda007 name="construct.b.pmda007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmda007
            
            #add-point:AFTER FIELD pmda007 name="construct.a.pmda007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmda007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmda007
            #add-point:ON ACTION controlp INFIELD pmda007 name="construct.c.pmda007"
 
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
         BEFORE FIELD pmda028
            #add-point:BEFORE FIELD pmda028 name="construct.b.pmda028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmda028
            
            #add-point:AFTER FIELD pmda028 name="construct.a.pmda028"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmda028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmda028
            #add-point:ON ACTION controlp INFIELD pmda028 name="construct.c.pmda028"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmda027
            #add-point:BEFORE FIELD pmda027 name="construct.b.pmda027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmda027
            
            #add-point:AFTER FIELD pmda027 name="construct.a.pmda027"
           
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmda027
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmda027
            #add-point:ON ACTION controlp INFIELD pmda027 name="construct.c.pmda027"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pmda027()
            DISPLAY g_qryparam.return1 TO pmda027  #顯示到畫面上
            NEXT FIELD pmda027
            #END add-point
 
 
         #Ctrlp:construct.c.pmda204
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmda204
            #add-point:ON ACTION controlp INFIELD pmda204 name="construct.c.pmda204"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            
            #判斷aooi500是否有設定
            IF s_aooi500_setpoint(g_prog,'pmda204') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'pmda204',g_site,'c') #150308-00001#1  By Ken add 'c' 150309
               CALL q_ooef001_24()
            ELSE    
               LET g_qryparam.where = "ooef303 = 'Y'" #採購中心
               CALL q_ooef001()  
            END IF  
            
            DISPLAY g_qryparam.return1 TO pmda204  #顯示到畫面上
            NEXT FIELD pmda204                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmda204
            #add-point:BEFORE FIELD pmda204 name="construct.b.pmda204"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmda204
            
            #add-point:AFTER FIELD pmda204 name="construct.a.pmda204"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmda205
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmda205
            #add-point:ON ACTION controlp INFIELD pmda205 name="construct.c.pmda205"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            
            #判斷aooi500是否有設定
            IF s_aooi500_setpoint(g_prog,'pmda205') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'pmda205',g_site,'c') #150308-00001#1  By Ken add 'c' 150309
               CALL q_ooef001_24()
            ELSE    
               LET g_qryparam.where = "ooef302 = 'Y'" #配送中心
               CALL q_ooef001()  
            END IF   
            DISPLAY g_qryparam.return1 TO pmda205  #顯示到畫面上
            NEXT FIELD pmda205                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmda205
            #add-point:BEFORE FIELD pmda205 name="construct.b.pmda205"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmda205
            
            #add-point:AFTER FIELD pmda205 name="construct.a.pmda205"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmda206
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmda206
            #add-point:ON ACTION controlp INFIELD pmda206 name="construct.c.pmda206"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inaa001_6()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmda206  #顯示到畫面上
            NEXT FIELD pmda206                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmda206
            #add-point:BEFORE FIELD pmda206 name="construct.b.pmda206"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmda206
            
            #add-point:AFTER FIELD pmda206 name="construct.a.pmda206"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmda021
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmda021
            #add-point:ON ACTION controlp INFIELD pmda021 name="construct.c.pmda021"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
			   LET g_qryparam.arg1 = '263'            
            CALL q_oocq002()                           #呼叫開窗
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
         BEFORE FIELD pmda208
            #add-point:BEFORE FIELD pmda208 name="construct.b.pmda208"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmda208
            
            #add-point:AFTER FIELD pmda208 name="construct.a.pmda208"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmda208
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmda208
            #add-point:ON ACTION controlp INFIELD pmda208 name="construct.c.pmda208"
            
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
 
 
         #Ctrlp:construct.c.pmdaownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdaownid
            #add-point:ON ACTION controlp INFIELD pmdaownid name="construct.c.pmdaownid"
            #應用 a08 樣板自動產生(Version:2)
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
            #應用 a08 樣板自動產生(Version:2)
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
            #應用 a08 樣板自動產生(Version:2)
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
            #應用 a08 樣板自動產生(Version:2)
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
            #應用 a08 樣板自動產生(Version:2)
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
            #應用 a08 樣板自動產生(Version:2)
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
 
 
         #Ctrlp:construct.c.pmdapstid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdapstid
            #add-point:ON ACTION controlp INFIELD pmdapstid name="construct.c.pmdapstid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdapstid  #顯示到畫面上
            NEXT FIELD pmdapstid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdapstid
            #add-point:BEFORE FIELD pmdapstid name="construct.b.pmdapstid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdapstid
            
            #add-point:AFTER FIELD pmdapstid name="construct.a.pmdapstid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdapstdt
            #add-point:BEFORE FIELD pmdapstdt name="construct.b.pmdapstdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON pmdbseq,pmdb001,pmdb002,pmdb003,pmdbsite,pmdb200,pmdb004,pmdb005,pmdb005_desc, 
          imaa154,imaa155,imaa156,imaa132,rtaw001,imaa009,imaa116,pmdb033,pmdb037,pmdb260,pmdb038,pmdb227, 
          pmdb201,pmdb202,pmdb212,pmdb007,pmdb261,pmdb006,pmdb253,pmdb258,pmdb254,pmdb255,pmdb256,pmdb257, 
          pmdb259,pmdb252,pmdb207,pmdb015,pmdb049,pmdb030,pmdb048,pmdb208,pmdb209,pmdb206,pmdb210,pmdb211, 
          pmdb205,pmdb203,pmdb204,pmdb032,pmdb051
           FROM s_detail1[1].pmdbseq,s_detail1[1].pmdb001,s_detail1[1].pmdb002,s_detail1[1].pmdb003, 
               s_detail1[1].pmdbsite,s_detail1[1].pmdb200,s_detail1[1].pmdb004,s_detail1[1].pmdb005, 
               s_detail1[1].pmdb005_desc,s_detail1[1].imaa154,s_detail1[1].imaa155,s_detail1[1].imaa156, 
               s_detail1[1].imaa132,s_detail1[1].rtaw001,s_detail1[1].imaa009,s_detail1[1].imaa116,s_detail1[1].pmdb033, 
               s_detail1[1].pmdb037,s_detail1[1].pmdb260,s_detail1[1].pmdb038,s_detail1[1].pmdb227,s_detail1[1].pmdb201, 
               s_detail1[1].pmdb202,s_detail1[1].pmdb212,s_detail1[1].pmdb007,s_detail1[1].pmdb261,s_detail1[1].pmdb006, 
               s_detail1[1].pmdb253,s_detail1[1].pmdb258,s_detail1[1].pmdb254,s_detail1[1].pmdb255,s_detail1[1].pmdb256, 
               s_detail1[1].pmdb257,s_detail1[1].pmdb259,s_detail1[1].pmdb252,s_detail1[1].pmdb207,s_detail1[1].pmdb015, 
               s_detail1[1].pmdb049,s_detail1[1].pmdb030,s_detail1[1].pmdb048,s_detail1[1].pmdb208,s_detail1[1].pmdb209, 
               s_detail1[1].pmdb206,s_detail1[1].pmdb210,s_detail1[1].pmdb211,s_detail1[1].pmdb205,s_detail1[1].pmdb203, 
               s_detail1[1].pmdb204,s_detail1[1].pmdb032,s_detail1[1].pmdb051
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
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
 
 
         #Ctrlp:construct.c.page1.pmdb001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb001
            #add-point:ON ACTION controlp INFIELD pmdb001 name="construct.c.page1.pmdb001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pmcz024()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdb001  #顯示到畫面上
            NEXT FIELD pmdb001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb001
            #add-point:BEFORE FIELD pmdb001 name="construct.b.page1.pmdb001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb001
            
            #add-point:AFTER FIELD pmdb001 name="construct.a.page1.pmdb001"
            
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
 
 
         #Ctrlp:construct.c.page1.pmdbsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdbsite
            #add-point:ON ACTION controlp INFIELD pmdbsite name="construct.c.page1.pmdbsite"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'pmdbsite',g_site,'c') #150308-00001#1  By Ken add 'c' 150309
            CALL q_ooef001_24()                              #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdbsite  #顯示到畫面上
            NEXT FIELD pmdbsite                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdbsite
            #add-point:BEFORE FIELD pmdbsite name="construct.b.page1.pmdbsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdbsite
            
            #add-point:AFTER FIELD pmdbsite name="construct.a.page1.pmdbsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdb200
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb200
            #add-point:ON ACTION controlp INFIELD pmdb200 name="construct.c.page1.pmdb200"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imay003_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdb200  #顯示到畫面上
            NEXT FIELD pmdb200                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb200
            #add-point:BEFORE FIELD pmdb200 name="construct.b.page1.pmdb200"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb200
            
            #add-point:AFTER FIELD pmdb200 name="construct.a.page1.pmdb200"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdb004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb004
            #add-point:ON ACTION controlp INFIELD pmdb004 name="construct.c.page1.pmdb004"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                           #呼叫開窗
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
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb005
            #add-point:ON ACTION controlp INFIELD pmdb005 name="construct.c.page1.pmdb005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb005_desc
            #add-point:BEFORE FIELD pmdb005_desc name="construct.b.page1.pmdb005_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb005_desc
            
            #add-point:AFTER FIELD pmdb005_desc name="construct.a.page1.pmdb005_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdb005_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb005_desc
            #add-point:ON ACTION controlp INFIELD pmdb005_desc name="construct.c.page1.pmdb005_desc"
            
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
         BEFORE FIELD imaa155
            #add-point:BEFORE FIELD imaa155 name="construct.b.page1.imaa155"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa155
            
            #add-point:AFTER FIELD imaa155 name="construct.a.page1.imaa155"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.imaa155
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa155
            #add-point:ON ACTION controlp INFIELD imaa155 name="construct.c.page1.imaa155"
            
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
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa132
            #add-point:ON ACTION controlp INFIELD imaa132 name="construct.c.page1.imaa132"
            
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
            #161214-00004#3 20161221 add by sunxh(S)
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '1'
            CALL q_rtax001_3()                            #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtaw001  #顯示到畫面上

            NEXT FIELD rtaw001
            #161214-00004#3 20161221 add by sunxh(E)
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
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa009
            #add-point:ON ACTION controlp INFIELD imaa009 name="construct.c.page1.imaa009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa116
            #add-point:BEFORE FIELD imaa116 name="construct.b.page1.imaa116"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa116
            
            #add-point:AFTER FIELD imaa116 name="construct.a.page1.imaa116"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.imaa116
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa116
            #add-point:ON ACTION controlp INFIELD imaa116 name="construct.c.page1.imaa116"
            
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
 
 
         #Ctrlp:construct.c.page1.pmdb037
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb037
            #add-point:ON ACTION controlp INFIELD pmdb037 name="construct.c.page1.pmdb037"
            #應用 a08 樣板自動產生(Version:2)          
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            
            #判斷aooi500是否有設定
            IF s_aooi500_setpoint(g_prog,'pmdb037') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'pmdb037',g_site,'c') #150308-00001#1  By Ken add 'c' 150309
               CALL q_ooef001_24()
            ELSE    
               LET g_qryparam.arg1 = g_pmdb_d[l_ac].pmdbsite
               LET g_qryparam.arg2 = 8
               CALL q_ooed004_3()
               #LET g_qryparam.where = "ooef201 = 'Y'" #營運據點
               #CALL q_ooef001()  
            END IF   

            DISPLAY g_qryparam.return1 TO pmdb037  #顯示到畫面上
            NEXT FIELD pmdb037                     #返回原欄位            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb037
            #add-point:BEFORE FIELD pmdb037 name="construct.b.page1.pmdb037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb037
            
            #add-point:AFTER FIELD pmdb037 name="construct.a.page1.pmdb037"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb260
            #add-point:BEFORE FIELD pmdb260 name="construct.b.page1.pmdb260"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb260
            
            #add-point:AFTER FIELD pmdb260 name="construct.a.page1.pmdb260"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdb260
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb260
            #add-point:ON ACTION controlp INFIELD pmdb260 name="construct.c.page1.pmdb260"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            
            LET g_qryparam.arg1 = g_pmda_m.pmdadocdt #
            #CALL q_ooeg001()                           #呼叫開窗   #160303-00028#9 dongsz mark
            CALL q_ooeg001_9()                           #呼叫開窗   #160303-00028#9 dongsz add
            DISPLAY g_qryparam.return1 TO pmdb260  #顯示到畫面上
            NEXT FIELD pmdb260                     #返回原欄位
            #END add-point
 
 
         #Ctrlp:construct.c.page1.pmdb038
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb038
            #add-point:ON ACTION controlp INFIELD pmdb038 name="construct.c.page1.pmdb038"
            #應用 a08 樣板自動產生(Version:2)
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
            #add-point:BEFORE FIELD pmdb038 name="construct.b.page1.pmdb038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb038
            
            #add-point:AFTER FIELD pmdb038 name="construct.a.page1.pmdb038"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb227
            #add-point:BEFORE FIELD pmdb227 name="construct.b.page1.pmdb227"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb227
            
            #add-point:AFTER FIELD pmdb227 name="construct.a.page1.pmdb227"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdb227
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb227
            #add-point:ON ACTION controlp INFIELD pmdb227 name="construct.c.page1.pmdb227"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.pmdb201
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb201
            #add-point:ON ACTION controlp INFIELD pmdb201 name="construct.c.page1.pmdb201"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdb201  #顯示到畫面上
            NEXT FIELD pmdb201                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb201
            #add-point:BEFORE FIELD pmdb201 name="construct.b.page1.pmdb201"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb201
            
            #add-point:AFTER FIELD pmdb201 name="construct.a.page1.pmdb201"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb202
            #add-point:BEFORE FIELD pmdb202 name="construct.b.page1.pmdb202"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb202
            
            #add-point:AFTER FIELD pmdb202 name="construct.a.page1.pmdb202"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdb202
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb202
            #add-point:ON ACTION controlp INFIELD pmdb202 name="construct.c.page1.pmdb202"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb212
            #add-point:BEFORE FIELD pmdb212 name="construct.b.page1.pmdb212"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb212
            
            #add-point:AFTER FIELD pmdb212 name="construct.a.page1.pmdb212"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdb212
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb212
            #add-point:ON ACTION controlp INFIELD pmdb212 name="construct.c.page1.pmdb212"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.pmdb007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb007
            #add-point:ON ACTION controlp INFIELD pmdb007 name="construct.c.page1.pmdb007"
            #應用 a08 樣板自動產生(Version:2)
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
         BEFORE FIELD pmdb261
            #add-point:BEFORE FIELD pmdb261 name="construct.b.page1.pmdb261"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb261
            
            #add-point:AFTER FIELD pmdb261 name="construct.a.page1.pmdb261"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdb261
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb261
            #add-point:ON ACTION controlp INFIELD pmdb261 name="construct.c.page1.pmdb261"
            
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
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb253
            #add-point:BEFORE FIELD pmdb253 name="construct.b.page1.pmdb253"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb253
            
            #add-point:AFTER FIELD pmdb253 name="construct.a.page1.pmdb253"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdb253
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb253
            #add-point:ON ACTION controlp INFIELD pmdb253 name="construct.c.page1.pmdb253"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb258
            #add-point:BEFORE FIELD pmdb258 name="construct.b.page1.pmdb258"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb258
            
            #add-point:AFTER FIELD pmdb258 name="construct.a.page1.pmdb258"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdb258
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb258
            #add-point:ON ACTION controlp INFIELD pmdb258 name="construct.c.page1.pmdb258"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb254
            #add-point:BEFORE FIELD pmdb254 name="construct.b.page1.pmdb254"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb254
            
            #add-point:AFTER FIELD pmdb254 name="construct.a.page1.pmdb254"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdb254
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb254
            #add-point:ON ACTION controlp INFIELD pmdb254 name="construct.c.page1.pmdb254"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb255
            #add-point:BEFORE FIELD pmdb255 name="construct.b.page1.pmdb255"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb255
            
            #add-point:AFTER FIELD pmdb255 name="construct.a.page1.pmdb255"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdb255
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb255
            #add-point:ON ACTION controlp INFIELD pmdb255 name="construct.c.page1.pmdb255"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb256
            #add-point:BEFORE FIELD pmdb256 name="construct.b.page1.pmdb256"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb256
            
            #add-point:AFTER FIELD pmdb256 name="construct.a.page1.pmdb256"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdb256
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb256
            #add-point:ON ACTION controlp INFIELD pmdb256 name="construct.c.page1.pmdb256"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb257
            #add-point:BEFORE FIELD pmdb257 name="construct.b.page1.pmdb257"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb257
            
            #add-point:AFTER FIELD pmdb257 name="construct.a.page1.pmdb257"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdb257
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb257
            #add-point:ON ACTION controlp INFIELD pmdb257 name="construct.c.page1.pmdb257"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb259
            #add-point:BEFORE FIELD pmdb259 name="construct.b.page1.pmdb259"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb259
            
            #add-point:AFTER FIELD pmdb259 name="construct.a.page1.pmdb259"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdb259
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb259
            #add-point:ON ACTION controlp INFIELD pmdb259 name="construct.c.page1.pmdb259"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb252
            #add-point:BEFORE FIELD pmdb252 name="construct.b.page1.pmdb252"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb252
            
            #add-point:AFTER FIELD pmdb252 name="construct.a.page1.pmdb252"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdb252
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb252
            #add-point:ON ACTION controlp INFIELD pmdb252 name="construct.c.page1.pmdb252"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb207
            #add-point:BEFORE FIELD pmdb207 name="construct.b.page1.pmdb207"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb207
            
            #add-point:AFTER FIELD pmdb207 name="construct.a.page1.pmdb207"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdb207
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb207
            #add-point:ON ACTION controlp INFIELD pmdb207 name="construct.c.page1.pmdb207"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.pmdb015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb015
            #add-point:ON ACTION controlp INFIELD pmdb015 name="construct.c.page1.pmdb015"
            #應用 a08 樣板自動產生(Version:2)
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
            #add-point:BEFORE FIELD pmdb015 name="construct.b.page1.pmdb015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb015
            
            #add-point:AFTER FIELD pmdb015 name="construct.a.page1.pmdb015"
            
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
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
			   LET g_qryparam.arg1 = '274'            
            CALL q_oocq002()                           #呼叫開窗
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
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb208
            #add-point:BEFORE FIELD pmdb208 name="construct.b.page1.pmdb208"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb208
            
            #add-point:AFTER FIELD pmdb208 name="construct.a.page1.pmdb208"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdb208
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb208
            #add-point:ON ACTION controlp INFIELD pmdb208 name="construct.c.page1.pmdb208"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.pmdb209
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb209
            #add-point:ON ACTION controlp INFIELD pmdb209 name="construct.c.page1.pmdb209"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_staa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdb209  #顯示到畫面上
            NEXT FIELD pmdb209                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb209
            #add-point:BEFORE FIELD pmdb209 name="construct.b.page1.pmdb209"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb209
            
            #add-point:AFTER FIELD pmdb209 name="construct.a.page1.pmdb209"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdb206
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb206
            #add-point:ON ACTION controlp INFIELD pmdb206 name="construct.c.page1.pmdb206"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdb206  #顯示到畫面上
            NEXT FIELD pmdb206                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb206
            #add-point:BEFORE FIELD pmdb206 name="construct.b.page1.pmdb206"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb206
            
            #add-point:AFTER FIELD pmdb206 name="construct.a.page1.pmdb206"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb210
            #add-point:BEFORE FIELD pmdb210 name="construct.b.page1.pmdb210"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb210
            
            #add-point:AFTER FIELD pmdb210 name="construct.a.page1.pmdb210"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdb210
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb210
            #add-point:ON ACTION controlp INFIELD pmdb210 name="construct.c.page1.pmdb210"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb211
            #add-point:BEFORE FIELD pmdb211 name="construct.b.page1.pmdb211"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb211
            
            #add-point:AFTER FIELD pmdb211 name="construct.a.page1.pmdb211"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdb211
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb211
            #add-point:ON ACTION controlp INFIELD pmdb211 name="construct.c.page1.pmdb211"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.pmdb205
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb205
            #add-point:ON ACTION controlp INFIELD pmdb205 name="construct.c.page1.pmdb205"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
           
            #判斷aooi500是否有設定
            IF s_aooi500_setpoint(g_prog,'pmdb205') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'pmdb205',g_site,'c') #150308-00001#1  By Ken add 'c' 150309
               CALL q_ooef001_24()
            ELSE    
               LET g_qryparam.where = "ooef303 = 'Y'" #採購中心
               CALL q_ooef001()  
            END IF            
            DISPLAY g_qryparam.return1 TO pmdb205  #顯示到畫面上

            NEXT FIELD pmdb205                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb205
            #add-point:BEFORE FIELD pmdb205 name="construct.b.page1.pmdb205"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb205
            
            #add-point:AFTER FIELD pmdb205 name="construct.a.page1.pmdb205"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdb203
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb203
            #add-point:ON ACTION controlp INFIELD pmdb203 name="construct.c.page1.pmdb203"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE        
            
            #判斷aooi500是否有設定
            IF s_aooi500_setpoint(g_prog,'pmdb203') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'pmdb203',g_site,'c') #150308-00001#1  By Ken add 'c' 150309
               CALL q_ooef001_24()
            ELSE    
               LET g_qryparam.where = "ooef302 = 'Y'" #配送中心
               CALL q_ooef001()  
            END IF   
            DISPLAY g_qryparam.return1 TO pmdb203  #顯示到畫面上

            NEXT FIELD pmdb203                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb203
            #add-point:BEFORE FIELD pmdb203 name="construct.b.page1.pmdb203"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb203
            
            #add-point:AFTER FIELD pmdb203 name="construct.a.page1.pmdb203"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdb204
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb204
            #add-point:ON ACTION controlp INFIELD pmdb204 name="construct.c.page1.pmdb204"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inaa001_6()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdb204  #顯示到畫面上
            NEXT FIELD pmdb204                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb204
            #add-point:BEFORE FIELD pmdb204 name="construct.b.page1.pmdb204"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb204
            
            #add-point:AFTER FIELD pmdb204 name="construct.a.page1.pmdb204"
            
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
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '258'
            CALL q_oocq002()                           #呼叫開窗
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
            
 
 
   
       
      END CONSTRUCT
      
 
      
 
      
      #add-point:cs段add_cs(本段內只能出現新的CONSTRUCT指令) name="cs.add_cs"
      
      #end add-point
 
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:cs段b_dialog name="cs.b_dialog"
         #161214-00004#3 by sunxh 161214(S)
         LET g_pmdb_d[1].pmdbseq = ""
         DISPLAY ARRAY g_pmdb_d TO s_detail1.*
            BEFORE DISPLAY
               EXIT DISPLAY
         END DISPLAY
         #161214-00004#3 by sunxh 161214(E)
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
 
{<section id="apmt830.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION apmt830_filter()
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
      CONSTRUCT g_wc_filter ON pmdasite,pmda200,pmdadocdt,pmdadocno,pmda001,pmda002,pmda003,pmda202, 
          pmda201,pmda203,pmda207,pmda204,pmda205,pmda206,pmda021,pmda022,pmda208
                          FROM s_browse[1].b_pmdasite,s_browse[1].b_pmda200,s_browse[1].b_pmdadocdt, 
                              s_browse[1].b_pmdadocno,s_browse[1].b_pmda001,s_browse[1].b_pmda002,s_browse[1].b_pmda003, 
                              s_browse[1].b_pmda202,s_browse[1].b_pmda201,s_browse[1].b_pmda203,s_browse[1].b_pmda207, 
                              s_browse[1].b_pmda204,s_browse[1].b_pmda205,s_browse[1].b_pmda206,s_browse[1].b_pmda021, 
                              s_browse[1].b_pmda022,s_browse[1].b_pmda208
 
         BEFORE CONSTRUCT
               DISPLAY apmt830_filter_parser('pmdasite') TO s_browse[1].b_pmdasite
            DISPLAY apmt830_filter_parser('pmda200') TO s_browse[1].b_pmda200
            DISPLAY apmt830_filter_parser('pmdadocdt') TO s_browse[1].b_pmdadocdt
            DISPLAY apmt830_filter_parser('pmdadocno') TO s_browse[1].b_pmdadocno
            DISPLAY apmt830_filter_parser('pmda001') TO s_browse[1].b_pmda001
            DISPLAY apmt830_filter_parser('pmda002') TO s_browse[1].b_pmda002
            DISPLAY apmt830_filter_parser('pmda003') TO s_browse[1].b_pmda003
            DISPLAY apmt830_filter_parser('pmda202') TO s_browse[1].b_pmda202
            DISPLAY apmt830_filter_parser('pmda201') TO s_browse[1].b_pmda201
            DISPLAY apmt830_filter_parser('pmda203') TO s_browse[1].b_pmda203
            DISPLAY apmt830_filter_parser('pmda207') TO s_browse[1].b_pmda207
            DISPLAY apmt830_filter_parser('pmda204') TO s_browse[1].b_pmda204
            DISPLAY apmt830_filter_parser('pmda205') TO s_browse[1].b_pmda205
            DISPLAY apmt830_filter_parser('pmda206') TO s_browse[1].b_pmda206
            DISPLAY apmt830_filter_parser('pmda021') TO s_browse[1].b_pmda021
            DISPLAY apmt830_filter_parser('pmda022') TO s_browse[1].b_pmda022
            DISPLAY apmt830_filter_parser('pmda208') TO s_browse[1].b_pmda208
      
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
 
      CALL apmt830_filter_show('pmdasite')
   CALL apmt830_filter_show('pmda200')
   CALL apmt830_filter_show('pmdadocdt')
   CALL apmt830_filter_show('pmdadocno')
   CALL apmt830_filter_show('pmda001')
   CALL apmt830_filter_show('pmda002')
   CALL apmt830_filter_show('pmda003')
   CALL apmt830_filter_show('pmda202')
   CALL apmt830_filter_show('pmda201')
   CALL apmt830_filter_show('pmda203')
   CALL apmt830_filter_show('pmda207')
   CALL apmt830_filter_show('pmda204')
   CALL apmt830_filter_show('pmda205')
   CALL apmt830_filter_show('pmda206')
   CALL apmt830_filter_show('pmda021')
   CALL apmt830_filter_show('pmda022')
   CALL apmt830_filter_show('pmda208')
 
END FUNCTION
 
{</section>}
 
{<section id="apmt830.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION apmt830_filter_parser(ps_field)
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
 
{<section id="apmt830.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION apmt830_filter_show(ps_field)
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
   LET ls_condition = apmt830_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="apmt830.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION apmt830_query()
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
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL apmt830_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL apmt830_browser_fill("")
      CALL apmt830_fetch("")
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
      CALL apmt830_filter_show('pmdasite')
   CALL apmt830_filter_show('pmda200')
   CALL apmt830_filter_show('pmdadocdt')
   CALL apmt830_filter_show('pmdadocno')
   CALL apmt830_filter_show('pmda001')
   CALL apmt830_filter_show('pmda002')
   CALL apmt830_filter_show('pmda003')
   CALL apmt830_filter_show('pmda202')
   CALL apmt830_filter_show('pmda201')
   CALL apmt830_filter_show('pmda203')
   CALL apmt830_filter_show('pmda207')
   CALL apmt830_filter_show('pmda204')
   CALL apmt830_filter_show('pmda205')
   CALL apmt830_filter_show('pmda206')
   CALL apmt830_filter_show('pmda021')
   CALL apmt830_filter_show('pmda022')
   CALL apmt830_filter_show('pmda208')
   CALL apmt830_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL apmt830_fetch("F") 
      #顯示單身筆數
      CALL apmt830_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="apmt830.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION apmt830_fetch(p_flag)
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
   
   LET g_pmda_m.pmdadocno = g_browser[g_current_idx].b_pmdadocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE apmt830_master_referesh USING g_pmda_m.pmdadocno INTO g_pmda_m.pmdasite,g_pmda_m.pmda200, 
       g_pmda_m.pmdadocdt,g_pmda_m.pmdadocno,g_pmda_m.pmda001,g_pmda_m.pmda002,g_pmda_m.pmda003,g_pmda_m.pmdastus, 
       g_pmda_m.pmda202,g_pmda_m.pmda201,g_pmda_m.pmda203,g_pmda_m.pmda207,g_pmda_m.pmda007,g_pmda_m.pmda006, 
       g_pmda_m.pmda004,g_pmda_m.pmda020,g_pmda_m.pmda028,g_pmda_m.pmda027,g_pmda_m.pmda204,g_pmda_m.pmda205, 
       g_pmda_m.pmda206,g_pmda_m.pmda021,g_pmda_m.pmda208,g_pmda_m.pmda022,g_pmda_m.pmdaownid,g_pmda_m.pmdaowndp, 
       g_pmda_m.pmdacrtid,g_pmda_m.pmdacrtdp,g_pmda_m.pmdacrtdt,g_pmda_m.pmdamodid,g_pmda_m.pmdamoddt, 
       g_pmda_m.pmdacnfid,g_pmda_m.pmdacnfdt,g_pmda_m.pmdapstid,g_pmda_m.pmdapstdt,g_pmda_m.pmdasite_desc, 
       g_pmda_m.pmda002_desc,g_pmda_m.pmda003_desc,g_pmda_m.pmda202_desc,g_pmda_m.pmda203_desc,g_pmda_m.pmda204_desc, 
       g_pmda_m.pmda205_desc,g_pmda_m.pmda206_desc,g_pmda_m.pmda021_desc,g_pmda_m.pmdaownid_desc,g_pmda_m.pmdaowndp_desc, 
       g_pmda_m.pmdacrtid_desc,g_pmda_m.pmdacrtdp_desc,g_pmda_m.pmdamodid_desc,g_pmda_m.pmdacnfid_desc, 
       g_pmda_m.pmdapstid_desc
   
   #遮罩相關處理
   LET g_pmda_m_mask_o.* =  g_pmda_m.*
   CALL apmt830_pmda_t_mask()
   LET g_pmda_m_mask_n.* =  g_pmda_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL apmt830_set_act_visible()   
   CALL apmt830_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_pmda_m_t.* = g_pmda_m.*
   LET g_pmda_m_o.* = g_pmda_m.*
   
   LET g_data_owner = g_pmda_m.pmdaownid      
   LET g_data_dept  = g_pmda_m.pmdaowndp
   
   #重新顯示   
   CALL apmt830_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="apmt830.insert" >}
#+ 資料新增
PRIVATE FUNCTION apmt830_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   DEFINE l_success     LIKE type_t.num5 
   DEFINE r_insert      LIKE type_t.num5  
   DEFINE l_n           LIKE type_t.num5
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_pmdb_d.clear()   
 
 
   INITIALIZE g_pmda_m.* TO NULL             #DEFAULT 設定
   
   LET g_pmdadocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
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
            LET g_pmda_m.pmda200 = "0"
      LET g_pmda_m.pmda001 = "0"
      LET g_pmda_m.pmda004 = "N"
      LET g_pmda_m.pmda020 = "Y"
      LET g_pmda_m.pmda208 = "0"
 
  
      #add-point:單頭預設值 name="insert.default"
      #要貨組織
      CALL s_aooi500_default(g_prog,'pmdasite',g_pmda_m.pmdasite) RETURNING r_insert,g_pmda_m.pmdasite
      IF NOT r_insert THEN
         RETURN 
      END IF
      CALL s_desc_get_department_desc(g_pmda_m.pmdasite) RETURNING g_pmda_m.pmdasite_desc
      DISPLAY BY NAME g_pmda_m.pmdasite_desc
      
      #要貨單別
      CALL s_arti200_get_def_doc_type(g_pmda_m.pmdasite,g_prog,'1') RETURNING l_success,g_pmda_m.pmdadocno
      DISPLAY BY NAME g_pmda_m.pmdadocno
      
      #單據日期
      LET g_pmda_m.pmdadocdt = g_today
      
      #申請人員
      LET g_pmda_m.pmda002 = g_user
      CALL s_desc_get_person_desc(g_pmda_m.pmda002) RETURNING g_pmda_m.pmda002_desc
      DISPLAY BY NAME g_pmda_m.pmda002_desc      
      
      #申請部門
      LET g_pmda_m.pmda003 = g_dept
      CALL s_desc_get_department_desc(g_pmda_m.pmda003) RETURNING g_pmda_m.pmda003_desc
      DISPLAY BY NAME g_pmda_m.pmda003_desc  
      
      #150512-00026#1 Add-S By Ken 150522 
      #預設arti204部門品類預設值
      SELECT COUNT(*) INTO l_n
        FROM rtaz_t
       WHERE rtazent = g_enterprise
         AND rtaz001 = g_prog
         AND rtazstus = 'Y'
      IF l_n > 0 THEN
         SELECT COUNT(*) INTO l_n
           FROM rtay_t,rtax_t
          WHERE rtayent = g_enterprise
            AND rtayent = rtaxent
            AND rtay001 = g_pmda_m.pmda003
            AND rtax001 = rtay002
            AND rtax002 = '2'
            AND rtaystus = rtaxstus
            AND rtaystus = 'Y'
         IF l_n = 1 THEN
            SELECT rtay002 INTO g_pmda_m.pmda202
              FROM rtay_t,rtax_t
             WHERE rtayent = g_enterprise
               AND rtayent = rtaxent
               AND rtay001 = g_pmda_m.pmda003
               AND rtax001 = rtay002
               AND rtax002 = '2'
               AND rtaystus = rtaxstus
               AND rtaystus = 'Y'
         END IF
      END IF
      CALL s_desc_get_rtaxl003_desc(g_pmda_m.pmda202) RETURNING g_pmda_m.pmda202_desc
      DISPLAY BY NAME g_pmda_m.pmda202_desc       
      #150512-00026#1 Add-E By Ken 150522 
      
      #費用部門(畫面隱藏)
      LET g_pmda_m.pmda007 = g_pmda_m.pmda003
      
      #預算控管否(畫面隱藏)
      LET g_pmda_m.pmda006 = 'N'
      
      #單價為必要輸入(畫面隱藏)
      LET g_pmda_m.pmda004 = 'N'
      
      #納入 MPS/MRP計算(畫面隱藏)
      LET g_pmda_m.pmda020 = 'Y' 

      LET g_site_flag = FALSE
      LET g_pmda_m_t.* = g_pmda_m.*  #備份舊值
      
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
 
 
 
    
      CALL apmt830_input("a")
      
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
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL apmt830_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_pmdb_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL apmt830_set_act_visible()   
   CALL apmt830_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_pmdadocno_t = g_pmda_m.pmdadocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " pmdaent = " ||g_enterprise|| " AND",
                      " pmdadocno = '", g_pmda_m.pmdadocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL apmt830_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE apmt830_cl
   
   CALL apmt830_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE apmt830_master_referesh USING g_pmda_m.pmdadocno INTO g_pmda_m.pmdasite,g_pmda_m.pmda200, 
       g_pmda_m.pmdadocdt,g_pmda_m.pmdadocno,g_pmda_m.pmda001,g_pmda_m.pmda002,g_pmda_m.pmda003,g_pmda_m.pmdastus, 
       g_pmda_m.pmda202,g_pmda_m.pmda201,g_pmda_m.pmda203,g_pmda_m.pmda207,g_pmda_m.pmda007,g_pmda_m.pmda006, 
       g_pmda_m.pmda004,g_pmda_m.pmda020,g_pmda_m.pmda028,g_pmda_m.pmda027,g_pmda_m.pmda204,g_pmda_m.pmda205, 
       g_pmda_m.pmda206,g_pmda_m.pmda021,g_pmda_m.pmda208,g_pmda_m.pmda022,g_pmda_m.pmdaownid,g_pmda_m.pmdaowndp, 
       g_pmda_m.pmdacrtid,g_pmda_m.pmdacrtdp,g_pmda_m.pmdacrtdt,g_pmda_m.pmdamodid,g_pmda_m.pmdamoddt, 
       g_pmda_m.pmdacnfid,g_pmda_m.pmdacnfdt,g_pmda_m.pmdapstid,g_pmda_m.pmdapstdt,g_pmda_m.pmdasite_desc, 
       g_pmda_m.pmda002_desc,g_pmda_m.pmda003_desc,g_pmda_m.pmda202_desc,g_pmda_m.pmda203_desc,g_pmda_m.pmda204_desc, 
       g_pmda_m.pmda205_desc,g_pmda_m.pmda206_desc,g_pmda_m.pmda021_desc,g_pmda_m.pmdaownid_desc,g_pmda_m.pmdaowndp_desc, 
       g_pmda_m.pmdacrtid_desc,g_pmda_m.pmdacrtdp_desc,g_pmda_m.pmdamodid_desc,g_pmda_m.pmdacnfid_desc, 
       g_pmda_m.pmdapstid_desc
   
   
   #遮罩相關處理
   LET g_pmda_m_mask_o.* =  g_pmda_m.*
   CALL apmt830_pmda_t_mask()
   LET g_pmda_m_mask_n.* =  g_pmda_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_pmda_m.pmdasite,g_pmda_m.pmdasite_desc,g_pmda_m.pmda200,g_pmda_m.pmdadocdt,g_pmda_m.pmdadocno, 
       g_pmda_m.pmda001,g_pmda_m.pmda002,g_pmda_m.pmda002_desc,g_pmda_m.pmda003,g_pmda_m.pmda003_desc, 
       g_pmda_m.pmdastus,g_pmda_m.pmda202,g_pmda_m.pmda202_desc,g_pmda_m.pmda201,g_pmda_m.pmda203,g_pmda_m.pmda203_desc, 
       g_pmda_m.pmda207,g_pmda_m.pmda007,g_pmda_m.pmda006,g_pmda_m.pmda004,g_pmda_m.pmda020,g_pmda_m.pmda028, 
       g_pmda_m.pmda027,g_pmda_m.pmda204,g_pmda_m.pmda204_desc,g_pmda_m.pmda205,g_pmda_m.pmda205_desc, 
       g_pmda_m.pmda206,g_pmda_m.pmda206_desc,g_pmda_m.pmda021,g_pmda_m.pmda021_desc,g_pmda_m.pmda208, 
       g_pmda_m.l_amts,g_pmda_m.pmda022,g_pmda_m.pmdaownid,g_pmda_m.pmdaownid_desc,g_pmda_m.pmdaowndp, 
       g_pmda_m.pmdaowndp_desc,g_pmda_m.pmdacrtid,g_pmda_m.pmdacrtid_desc,g_pmda_m.pmdacrtdp,g_pmda_m.pmdacrtdp_desc, 
       g_pmda_m.pmdacrtdt,g_pmda_m.pmdamodid,g_pmda_m.pmdamodid_desc,g_pmda_m.pmdamoddt,g_pmda_m.pmdacnfid, 
       g_pmda_m.pmdacnfid_desc,g_pmda_m.pmdacnfdt,g_pmda_m.pmdapstid,g_pmda_m.pmdapstid_desc,g_pmda_m.pmdapstdt 
 
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_pmda_m.pmdaownid      
   LET g_data_dept  = g_pmda_m.pmdaowndp
   
   #功能已完成,通報訊息中心
   CALL apmt830_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="apmt830.modify" >}
#+ 資料修改
PRIVATE FUNCTION apmt830_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point    
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   DEFINE l_wc2_table1          STRING
 
 
   #add-point:modify段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="modify.pre_function"
   #161220-00059#2 -s by 08172
   IF g_pmda_m.pmdastus = 'TJ' THEN
      #保存單頭舊值
      LET g_pmda_m_t.* = g_pmda_m.*
      LET g_pmda_m_o.* = g_pmda_m.*
      
      IF g_pmda_m.pmdadocno IS NULL
      
      THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = "std-00003" 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN
      END IF
      
      ERROR ""
      
      LET g_pmdadocno_t = g_pmda_m.pmdadocno
      
      CALL s_transaction_begin()
      
      OPEN apmt830_cl USING g_enterprise,g_pmda_m.pmdadocno
      IF STATUS THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "OPEN apmt830_cl:" 
         LET g_errparam.code   = STATUS 
         LET g_errparam.popup  = TRUE 
         CLOSE apmt830_cl
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #顯示最新的資料
      EXECUTE apmt830_master_referesh USING g_pmda_m.pmdadocno INTO g_pmda_m.pmdasite,g_pmda_m.pmda200, 
          g_pmda_m.pmdadocdt,g_pmda_m.pmdadocno,g_pmda_m.pmda001,g_pmda_m.pmda002,g_pmda_m.pmda003,g_pmda_m.pmdastus, 
          g_pmda_m.pmda202,g_pmda_m.pmda201,g_pmda_m.pmda203,g_pmda_m.pmda207,g_pmda_m.pmda007,g_pmda_m.pmda006, 
          g_pmda_m.pmda004,g_pmda_m.pmda020,g_pmda_m.pmda028,g_pmda_m.pmda027,g_pmda_m.pmda204,g_pmda_m.pmda205, 
          g_pmda_m.pmda206,g_pmda_m.pmda021,g_pmda_m.pmda208,g_pmda_m.pmda022,g_pmda_m.pmdaownid,g_pmda_m.pmdaowndp, 
          g_pmda_m.pmdacrtid,g_pmda_m.pmdacrtdp,g_pmda_m.pmdacrtdt,g_pmda_m.pmdamodid,g_pmda_m.pmdamoddt, 
          g_pmda_m.pmdacnfid,g_pmda_m.pmdacnfdt,g_pmda_m.pmdapstid,g_pmda_m.pmdapstdt,g_pmda_m.pmdasite_desc, 
          g_pmda_m.pmda002_desc,g_pmda_m.pmda003_desc,g_pmda_m.pmda202_desc,g_pmda_m.pmda203_desc,g_pmda_m.pmda204_desc, 
          g_pmda_m.pmda205_desc,g_pmda_m.pmda206_desc,g_pmda_m.pmda021_desc,g_pmda_m.pmdaownid_desc,g_pmda_m.pmdaowndp_desc, 
          g_pmda_m.pmdacrtid_desc,g_pmda_m.pmdacrtdp_desc,g_pmda_m.pmdamodid_desc,g_pmda_m.pmdacnfid_desc, 
          g_pmda_m.pmdapstid_desc
      
      #檢查是否允許此動作
      IF NOT apmt830_action_chk() THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      
      #遮罩相關處理
      LET g_pmda_m_mask_o.* =  g_pmda_m.*
      CALL apmt830_pmda_t_mask()
      LET g_pmda_m_mask_n.* =  g_pmda_m.*
      CALL apmt830_show()
      
      
      
      WHILE TRUE
         LET g_pmdadocno_t = g_pmda_m.pmdadocno
         
         
         #寫入修改者/修改日期資訊(單頭)
         LET g_pmda_m.pmdamodid = g_user 
         LET g_pmda_m.pmdamoddt = cl_get_current()
         LET g_pmda_m.pmdamodid_desc = cl_get_username(g_pmda_m.pmdamodid)
         
         #add-point:modify段修改前 name="modify.before_input"
         #「D抽單 / R已拒絕」狀況碼更改資料後，需還原為「N未確認」
         IF g_pmda_m.pmdastus MATCHES "[DR]" THEN
            LET g_pmda_m.pmdastus = "N"
         END IF
         #end add-point
         
         IF NOT apmt830_committed_input()  THEN
            CALL s_transaction_end('N','0')
         END IF
         
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
               CALL apmt830_show()
            END IF
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = '' 
            LET g_errparam.code   = 9001 
            LET g_errparam.popup  = FALSE 
            CALL cl_err()
            RETURN
         END IF 
                  
         EXIT WHILE
      END WHILE
 
      CLOSE apmt830_cl
      
      CALL s_transaction_end('Y','0')
      RETURN      
   END IF
   #161220-00059#2 -e by 08172
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
   
   OPEN apmt830_cl USING g_enterprise,g_pmda_m.pmdadocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN apmt830_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE apmt830_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE apmt830_master_referesh USING g_pmda_m.pmdadocno INTO g_pmda_m.pmdasite,g_pmda_m.pmda200, 
       g_pmda_m.pmdadocdt,g_pmda_m.pmdadocno,g_pmda_m.pmda001,g_pmda_m.pmda002,g_pmda_m.pmda003,g_pmda_m.pmdastus, 
       g_pmda_m.pmda202,g_pmda_m.pmda201,g_pmda_m.pmda203,g_pmda_m.pmda207,g_pmda_m.pmda007,g_pmda_m.pmda006, 
       g_pmda_m.pmda004,g_pmda_m.pmda020,g_pmda_m.pmda028,g_pmda_m.pmda027,g_pmda_m.pmda204,g_pmda_m.pmda205, 
       g_pmda_m.pmda206,g_pmda_m.pmda021,g_pmda_m.pmda208,g_pmda_m.pmda022,g_pmda_m.pmdaownid,g_pmda_m.pmdaowndp, 
       g_pmda_m.pmdacrtid,g_pmda_m.pmdacrtdp,g_pmda_m.pmdacrtdt,g_pmda_m.pmdamodid,g_pmda_m.pmdamoddt, 
       g_pmda_m.pmdacnfid,g_pmda_m.pmdacnfdt,g_pmda_m.pmdapstid,g_pmda_m.pmdapstdt,g_pmda_m.pmdasite_desc, 
       g_pmda_m.pmda002_desc,g_pmda_m.pmda003_desc,g_pmda_m.pmda202_desc,g_pmda_m.pmda203_desc,g_pmda_m.pmda204_desc, 
       g_pmda_m.pmda205_desc,g_pmda_m.pmda206_desc,g_pmda_m.pmda021_desc,g_pmda_m.pmdaownid_desc,g_pmda_m.pmdaowndp_desc, 
       g_pmda_m.pmdacrtid_desc,g_pmda_m.pmdacrtdp_desc,g_pmda_m.pmdamodid_desc,g_pmda_m.pmdacnfid_desc, 
       g_pmda_m.pmdapstid_desc
   
   #檢查是否允許此動作
   IF NOT apmt830_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_pmda_m_mask_o.* =  g_pmda_m.*
   CALL apmt830_pmda_t_mask()
   LET g_pmda_m_mask_n.* =  g_pmda_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
 
   
   CALL apmt830_show()
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
      #「D抽單 / R已拒絕」狀況碼更改資料後，需還原為「N未確認」
      IF g_pmda_m.pmdastus MATCHES "[DR]" THEN
         LET g_pmda_m.pmdastus = "N"
      END IF
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL apmt830_input("u")
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
            CALL apmt830_show()
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
   CALL apmt830_set_act_visible()   
   CALL apmt830_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " pmdaent = " ||g_enterprise|| " AND",
                      " pmdadocno = '", g_pmda_m.pmdadocno, "' "
 
   #填到對應位置
   CALL apmt830_browser_fill("")
 
   CLOSE apmt830_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL apmt830_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="apmt830.input" >}
#+ 資料輸入
PRIVATE FUNCTION apmt830_input(p_cmd)
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
   DEFINE l_sys                 LIKE type_t.num5   
   DEFINE l_success             LIKE type_t.num5
   DEFINE l_errno               LIKE type_t.chr10 
   DEFINE l_pmdb004             LIKE pmdb_t.pmdb004 
   DEFINE l_pmdb006             LIKE pmdb_t.pmdb006 
   DEFINE l_pmdb212             LIKE pmdb_t.pmdb212  

   #ken---add---s 
   DEFINE  l_imaa005            LIKE imaa_t.imaa005     #ken---add
   DEFINE  l_inam       DYNAMIC ARRAY OF RECORD   #記錄產品特徵
           inam001      LIKE inam_t.inam001,
           inam002      LIKE inam_t.inam002,
           inam004      LIKE inam_t.inam004
                        END RECORD

   DEFINE  l_pmdbseq    LIKE pmdb_t.pmdbseq
   #記錄產品特徵多筆輸入時RECORD
   DEFINE  l_pmdb       RECORD
           pmdbent      LIKE pmdb_t.pmdbent,
           pmdbdocno    LIKE pmdb_t.pmdbdocno,
           pmdbseq      LIKE pmdb_t.pmdbseq,    #項次
           pmdbsite     LIKE pmdb_t.pmdbsite,   #需求組織
           pmdb001      LIKE pmdb_t.pmdb001,    #來源單號
           pmdb002      LIKE pmdb_t.pmdb002,    #來源項次
           pmdb003      LIKE pmdb_t.pmdb003,    #來源項序
           pmdb200      LIKE pmdb_t.pmdb200,    #商品條碼
           pmdb004      LIKE pmdb_t.pmdb004,    #商品編號
           pmdb005      LIKE pmdb_t.pmdb005,    #產品特徵
           pmdb033      LIKE pmdb_t.pmdb033,    #緊急度  #160919-00053#1 20160920 add by beckxie
           pmdb037      LIKE pmdb_t.pmdb037,    #收貨組織
           pmdb260      LIKE pmdb_t.pmdb260,    #收貨部門
           pmdb038      LIKE pmdb_t.pmdb038,    #庫位編號
           pmdb201      LIKE pmdb_t.pmdb201,    #包裝單位
           pmdb202      LIKE pmdb_t.pmdb202,    #件裝數
           pmdb212      LIKE pmdb_t.pmdb212,    #要貨件數
           pmdb007      LIKE pmdb_t.pmdb007,    #要貨單位
           pmdb006      LIKE pmdb_t.pmdb006,    #要貨數量
           pmdb253      LIKE pmdb_t.pmdb253,    #入庫在途量
           pmdb258      LIKE pmdb_t.pmdb258,    #要貨在途量
           pmdb254      LIKE pmdb_t.pmdb254,    #前一週銷量
           pmdb255      LIKE pmdb_t.pmdb255,    #前二週銷量
           pmdb256      LIKE pmdb_t.pmdb256,    #前三週銷量
           pmdb257      LIKE pmdb_t.pmdb257,    #前四周銷量
           pmdb259      LIKE pmdb_t.pmdb259,    #周平均銷量
           pmdb252      LIKE pmdb_t.pmdb252,    #現有庫存
           pmdb207      LIKE pmdb_t.pmdb207,    #採購方式
           pmdb015      LIKE pmdb_t.pmdb015,    #供應商編號
           pmdb049      LIKE pmdb_t.pmdb049,    #已轉採購量/配送量
           pmdb030      LIKE pmdb_t.pmdb030,    #需求日期
           pmdb048      LIKE pmdb_t.pmdb048,    #收貨時段
           pmdb208      LIKE pmdb_t.pmdb208,    #經營方式
           pmdb209      LIKE pmdb_t.pmdb209,    #結算方式
           pmdb206      LIKE pmdb_t.pmdb206,    #採購員
           pmdb210      LIKE pmdb_t.pmdb210,    #促銷開始日
           pmdb211      LIKE pmdb_t.pmdb211,    #促銷結束日
           pmdb205      LIKE pmdb_t.pmdb205,    #採購中心
           pmdb203      LIKE pmdb_t.pmdb203,    #配送中心
           pmdb204      LIKE pmdb_t.pmdb204,    #配送倉庫
           pmdb032      LIKE pmdb_t.pmdb032,    #行狀態
           pmdb051      LIKE pmdb_t.pmdb051,    #結案/留置理由碼
           pmdb227      LIKE pmdb_t.pmdb227,    #補貨規格說明   #150710-00016#3 Add By Ken 150714
           pmdb261      LIKE pmdb_t.pmdb261     #门店要货量     #161220-00059#2 by 08172
                        END RECORD
   #ken---add---e
   DEFINE r_success              LIKE type_t.num5    #2015/03/19  geza
   #150324-00006#13 2015/04/06 By pomelo add(S)
   DEFINE l_pmeusite    LIKE pmeu_t.pmeusite    #要貨組織
   DEFINE l_pmeu001     LIKE pmeu_t.pmeu001     #要貨部門
   DEFINE l_auto_detail LIKE type_t.chr1        #記錄進到單身是否已有詢問過自動產生單身
   #150324-00006#13 2015/04/06 By pomelo add(E)
   DEFINE l_inaasite    LIKE inaa_t.inaasite    #170116-00018#1 add by 08172
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
   DISPLAY BY NAME g_pmda_m.pmdasite,g_pmda_m.pmdasite_desc,g_pmda_m.pmda200,g_pmda_m.pmdadocdt,g_pmda_m.pmdadocno, 
       g_pmda_m.pmda001,g_pmda_m.pmda002,g_pmda_m.pmda002_desc,g_pmda_m.pmda003,g_pmda_m.pmda003_desc, 
       g_pmda_m.pmdastus,g_pmda_m.pmda202,g_pmda_m.pmda202_desc,g_pmda_m.pmda201,g_pmda_m.pmda203,g_pmda_m.pmda203_desc, 
       g_pmda_m.pmda207,g_pmda_m.pmda007,g_pmda_m.pmda006,g_pmda_m.pmda004,g_pmda_m.pmda020,g_pmda_m.pmda028, 
       g_pmda_m.pmda027,g_pmda_m.pmda204,g_pmda_m.pmda204_desc,g_pmda_m.pmda205,g_pmda_m.pmda205_desc, 
       g_pmda_m.pmda206,g_pmda_m.pmda206_desc,g_pmda_m.pmda021,g_pmda_m.pmda021_desc,g_pmda_m.pmda208, 
       g_pmda_m.l_amts,g_pmda_m.pmda022,g_pmda_m.pmdaownid,g_pmda_m.pmdaownid_desc,g_pmda_m.pmdaowndp, 
       g_pmda_m.pmdaowndp_desc,g_pmda_m.pmdacrtid,g_pmda_m.pmdacrtid_desc,g_pmda_m.pmdacrtdp,g_pmda_m.pmdacrtdp_desc, 
       g_pmda_m.pmdacrtdt,g_pmda_m.pmdamodid,g_pmda_m.pmdamodid_desc,g_pmda_m.pmdamoddt,g_pmda_m.pmdacnfid, 
       g_pmda_m.pmdacnfid_desc,g_pmda_m.pmdacnfdt,g_pmda_m.pmdapstid,g_pmda_m.pmdapstid_desc,g_pmda_m.pmdapstdt 
 
   
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
   LET l_auto_detail = 'Y'   #150324-00006#13 2015/04/06 By pomelo add
   #end add-point 
   LET g_forupd_sql = "SELECT pmdbseq,pmdb001,pmdb002,pmdb003,pmdbsite,pmdb200,pmdb004,pmdb005,pmdb033, 
       pmdb037,pmdb260,pmdb038,pmdb227,pmdb201,pmdb202,pmdb212,pmdb007,pmdb213,pmdb261,pmdb006,pmdb253, 
       pmdb258,pmdb254,pmdb255,pmdb256,pmdb257,pmdb259,pmdb252,pmdb207,pmdb015,pmdb049,pmdb030,pmdb048, 
       pmdb208,pmdb209,pmdb206,pmdb210,pmdb211,pmdb205,pmdb203,pmdb204,pmdb032,pmdb051 FROM pmdb_t WHERE  
       pmdbent=? AND pmdbdocno=? AND pmdbseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE apmt830_bcl CURSOR FROM g_forupd_sql
   
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL apmt830_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL apmt830_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_pmda_m.pmdasite,g_pmda_m.pmda200,g_pmda_m.pmdadocdt,g_pmda_m.pmdadocno,g_pmda_m.pmda001, 
       g_pmda_m.pmda002,g_pmda_m.pmda003,g_pmda_m.pmdastus,g_pmda_m.pmda202,g_pmda_m.pmda201,g_pmda_m.pmda203, 
       g_pmda_m.pmda207,g_pmda_m.pmda007,g_pmda_m.pmda006,g_pmda_m.pmda004,g_pmda_m.pmda020,g_pmda_m.pmda028, 
       g_pmda_m.pmda204,g_pmda_m.pmda205,g_pmda_m.pmda206,g_pmda_m.pmda021,g_pmda_m.pmda208,g_pmda_m.pmda022 
 
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
 
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="apmt830.input.head" >}
      #單頭段
      INPUT BY NAME g_pmda_m.pmdasite,g_pmda_m.pmda200,g_pmda_m.pmdadocdt,g_pmda_m.pmdadocno,g_pmda_m.pmda001, 
          g_pmda_m.pmda002,g_pmda_m.pmda003,g_pmda_m.pmdastus,g_pmda_m.pmda202,g_pmda_m.pmda201,g_pmda_m.pmda203, 
          g_pmda_m.pmda207,g_pmda_m.pmda007,g_pmda_m.pmda006,g_pmda_m.pmda004,g_pmda_m.pmda020,g_pmda_m.pmda028, 
          g_pmda_m.pmda204,g_pmda_m.pmda205,g_pmda_m.pmda206,g_pmda_m.pmda021,g_pmda_m.pmda208,g_pmda_m.pmda022  
 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN apmt830_cl USING g_enterprise,g_pmda_m.pmdadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN apmt830_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE apmt830_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL apmt830_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
 
            #end add-point
            CALL apmt830_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdasite
            
            #add-point:AFTER FIELD pmdasite name="input.a.pmdasite"
             IF NOT cl_null(g_pmda_m.pmdasite) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_pmda_m.pmdasite != g_pmda_m_t.pmdasite OR g_pmda_m_t.pmdasite IS NULL )) THEN   #160824-00007#18 20160914 mark by beckxie
               IF g_pmda_m.pmdasite != g_pmda_m_o.pmdasite OR cl_null(g_pmda_m_o.pmdasite) THEN   #160824-00007#18 20160914 add by beckxie
                  CALL s_aooi500_chk(g_prog,'pmdasite',g_pmda_m.pmdasite,g_pmda_m.pmdasite) RETURNING l_success,l_errno
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ''
                     LET g_errparam.code   = l_errno
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                  
                     #LET g_pmda_m.pmdasite = g_pmda_m_t.pmdasite   #160824-00007#18 20160914 mark by beckxie
                     LET g_pmda_m.pmdasite = g_pmda_m_o.pmdasite    #160824-00007#18 20160914 add by beckxie
                     
                     CALL s_desc_get_department_desc(g_pmda_m.pmdasite) RETURNING g_pmda_m.pmdasite_desc
                     DISPLAY BY NAME g_pmda_m.pmdasite_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            ELSE
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = ''
               LET g_errparam.code   = 'axc-00120'
               LET g_errparam.popup  = TRUE
               CALL cl_err()

               #LET g_pmda_m.pmdasite = g_pmda_m_t.pmdasite   #160824-00007#18 20160914 mark by beckxie
               LET g_pmda_m.pmdasite = g_pmda_m_o.pmdasite    #160824-00007#18 20160914 add by beckxie
               CALL s_desc_get_department_desc(g_pmda_m.pmdasite) RETURNING g_pmda_m.pmdasite_desc
               DISPLAY BY NAME g_pmda_m.pmdasite_desc
               NEXT FIELD CURRENT
            END IF
            LET g_pmda_m_o.pmdasite = g_pmda_m.pmdasite    #160824-00007#18 20160914 add by beckxie
            CALL s_desc_get_department_desc(g_pmda_m.pmdasite) RETURNING g_pmda_m.pmdasite_desc
            DISPLAY BY NAME g_pmda_m.pmdasite_desc
            LET g_site_flag = TRUE
            CALL apmt830_set_entry(p_cmd)
            CALL apmt830_set_no_entry(p_cmd)            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdasite
            #add-point:BEFORE FIELD pmdasite name="input.b.pmdasite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdasite
            #add-point:ON CHANGE pmdasite name="input.g.pmdasite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmda200
            #add-point:BEFORE FIELD pmda200 name="input.b.pmda200"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmda200
            
            #add-point:AFTER FIELD pmda200 name="input.a.pmda200"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmda200
            #add-point:ON CHANGE pmda200 name="input.g.pmda200"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdadocdt
            #add-point:BEFORE FIELD pmdadocdt name="input.b.pmdadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdadocdt
            
            #add-point:AFTER FIELD pmdadocdt name="input.a.pmdadocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdadocdt
            #add-point:ON CHANGE pmdadocdt name="input.g.pmdadocdt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdadocno
            #add-point:BEFORE FIELD pmdadocno name="input.b.pmdadocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdadocno
            
            #add-point:AFTER FIELD pmdadocno name="input.a.pmdadocno"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  NOT cl_null(g_pmda_m.pmdadocno) THEN  
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmda_m.pmdadocno != g_pmdadocno_t )) THEN
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pmda_t WHERE "||"pmdaent = '" ||g_enterprise|| "' AND "||"pmdadocno = '"||g_pmda_m.pmdadocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT s_aooi200_chk_slip(g_pmda_m.pmdasite,'',g_pmda_m.pmdadocno,g_prog) THEN
                     LET g_pmda_m.pmdadocno = g_pmdadocno_t
                     NEXT FIELD CURRENT
                  END IF  
               END IF                  
            END IF
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
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmda002
            
            #add-point:AFTER FIELD pmda002 name="input.a.pmda002"
            IF NOT cl_null(g_pmda_m.pmda002) THEN 
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_pmda_m.pmda002 != g_pmda_m_t.pmda002 OR g_pmda_m_t.pmda002 IS NULL )) THEN   #160824-00007#18 20160914 mark by beckxie
               IF g_pmda_m.pmda002 != g_pmda_m_o.pmda002 OR cl_null(g_pmda_m.pmda002) THEN   #160824-00007#18 20160914 add by beckxie
                  INITIALIZE g_chkparam.* TO NULL
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_pmda_m.pmda002
                  #160318-00025#21  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
                  #160318-00025#21  by 07900 --add-end 
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_ooag001") THEN
                     #LET g_pmda_m.pmda002 = g_pmda_m_t.pmda002   #160824-00007#18 20160914 mark by beckxie
                     LET g_pmda_m.pmda002 = g_pmda_m_o.pmda002    #160824-00007#18 20160914 add by beckxie
                     CALL s_desc_get_person_desc(g_pmda_m.pmda002) RETURNING g_pmda_m.pmda002_desc
                     DISPLAY BY NAME g_pmda_m.pmda002_desc 
                     #檢查失敗時後續處理
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF 
            LET g_pmda_m_o.pmda002 = g_pmda_m.pmda002    #160824-00007#18 20160914 add by beckxie
            CALL s_desc_get_person_desc(g_pmda_m.pmda002) RETURNING g_pmda_m.pmda002_desc
            DISPLAY BY NAME g_pmda_m.pmda002_desc                        
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
            IF NOT cl_null(g_pmda_m.pmda003) THEN                
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_pmda_m.pmda003 != g_pmda_m_t.pmda003 OR g_pmda_m_t.pmda003 IS NULL )) THEN   #160824-00007#18 20160914 mark by beckxie
               IF g_pmda_m.pmda003 != g_pmda_m_o.pmda003 OR cl_null(g_pmda_m_o.pmda003) THEN   #160824-00007#18 20160914 add by beckxie
                  INITIALIZE g_chkparam.* TO NULL
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_pmda_m.pmda003
                  LET g_chkparam.arg2 = g_pmda_m.pmdadocdt
                  #160318-00025#21  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
                  #160318-00025#21  by 07900 --add-end  
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_ooeg001") THEN
                     #LET g_pmda_m.pmda003 = g_pmda_m_t.pmda003   #160824-00007#18 20160914 mark by beckxie
                     LET g_pmda_m.pmda003 = g_pmda_m_o.pmda003    #160824-00007#18 20160914 add by beckxie
                     CALL s_desc_get_department_desc(g_pmda_m.pmda003) RETURNING g_pmda_m.pmda003_desc 
                     DISPLAY BY NAME g_pmda_m.pmda003_desc
                     #檢查失敗時後續處理
                     NEXT FIELD CURRENT
                  END IF
               END IF
               #150512-00026#1 Add-S By Ken 150522
               IF NOT cl_null(g_pmda_m.pmda202) THEN
                  #檢查是否屬於arti204設置的部門品類
                  LET l_n = 0
                  SELECT COUNT(*) INTO l_n FROM rtaz_t
                   WHERE rtazent = g_enterprise
                     AND rtaz001 = g_prog
                     AND rtazstus = 'Y'
                  IF l_n > 0 THEN
                     #當rtaz_t設定該程式代號 代表 該程式受arti204的控管
                     SELECT COUNT(*) INTO l_n FROM rtay_t
                      WHERE rtayent = g_enterprise
                        AND rtay001 = g_pmda_m.pmda003
                        AND rtay002 = g_pmda_m.pmda202
                        AND rtaystus = 'Y'
                     IF l_n < 1 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'apr-00357'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                  
                        #LET g_pmda_m.pmda003 = g_pmda_m_t.pmda003   #160824-00007#18 20160914 mark by beckxie
                        LET g_pmda_m.pmda003 = g_pmda_m_o.pmda003    #160824-00007#18 20160914 add by beckxie
                        DISPLAY BY NAME g_pmda_m.pmda003
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
               #150512-00026#1 Add-E By Ken 150522               
            END IF 
            LET g_pmda_m_o.pmda003 = g_pmda_m.pmda003    #160824-00007#18 20160914 add by beckxie
            CALL s_desc_get_department_desc(g_pmda_m.pmda003) RETURNING g_pmda_m.pmda003_desc
            DISPLAY BY NAME g_pmda_m.pmda003_desc
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
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmda202
            
            #add-point:AFTER FIELD pmda202 name="input.a.pmda202"
            
            LET g_pmda_m.pmda202_desc = ''
            DISPLAY BY NAME g_pmda_m.pmda202_desc    
            IF NOT cl_null(g_pmda_m.pmda202) THEN             
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_pmda_m.pmda202 != g_pmda_m_t.pmda202 OR g_pmda_m_t.pmda202 IS NULL )) THEN   #160824-00007#18 20160914 mark by beckxie
               IF g_pmda_m.pmda202 != g_pmda_m_o.pmda202 OR cl_null(g_pmda_m_o.pmda202) THEN   #160824-00007#18 20160914 add by beckxie
                 INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_pmda_m.pmda202
                  CALL cl_get_para(g_enterprise,g_site,'E-CIR-0001') RETURNING l_sys
                  LET g_chkparam.arg2 = l_sys
                  #160318-00025#21  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="ast-00215:sub-01302|arti202|",cl_get_progname("arti202",g_lang,"2"),"|:EXEPROGarti202"
                  #160318-00025#21  by 07900 --add-end  
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_rtax001_2") THEN
                     #LET g_pmda_m.pmda202 = g_pmda_m_t.pmda202   #160824-00007#18 20160914 mark by beckxie
                     LET g_pmda_m.pmda202 = g_pmda_m_o.pmda202    #160824-00007#18 20160914 add by beckxie
                     CALL s_desc_get_rtaxl003_desc(g_pmda_m.pmda202) RETURNING g_pmda_m.pmda202_desc
                     DISPLAY BY NAME g_pmda_m.pmda202_desc
                     #檢查失敗時後續處理
                     NEXT FIELD CURRENT
                  END IF
               END IF
               #150512-00026#1 Add-S By Ken 150522
               IF NOT cl_null(g_pmda_m.pmda003) THEN
                  #檢查是否屬於arti204設置的部門品類
                  LET l_n = 0
                  SELECT COUNT(*) INTO l_n FROM rtaz_t
                   WHERE rtazent = g_enterprise
                     AND rtaz001 = g_prog
                     AND rtazstus = 'Y'
                  IF l_n > 0 THEN
                     #當rtaz_t設定該程式代號 代表 該程式受arti204的控管
                     SELECT COUNT(*) INTO l_n FROM rtay_t
                      WHERE rtayent = g_enterprise
                        AND rtay001 = g_pmda_m.pmda003
                        AND rtay002 = g_pmda_m.pmda202
                        AND rtaystus = 'Y'
                     IF l_n < 1 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'apr-00357'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                  
                        #LET g_pmda_m.pmda202 = g_pmda_m_t.pmda202   #160824-00007#18 20160914 mark by beckxie
                        LET g_pmda_m.pmda202 = g_pmda_m_o.pmda202    #160824-00007#18 20160914 add by beckxie
                        DISPLAY BY NAME g_pmda_m.pmda202
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
               #150512-00026#1 Add-E By Ken 150522                  
            END IF         
            LET g_pmda_m_o.pmda202 = g_pmda_m.pmda202   #160824-00007#18 20160914 add by beckxie
            CALL s_desc_get_rtaxl003_desc(g_pmda_m.pmda202) RETURNING g_pmda_m.pmda202_desc
            DISPLAY BY NAME g_pmda_m.pmda202_desc   
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmda202
            #add-point:BEFORE FIELD pmda202 name="input.b.pmda202"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmda202
            #add-point:ON CHANGE pmda202 name="input.g.pmda202"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmda201
            #add-point:BEFORE FIELD pmda201 name="input.b.pmda201"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmda201
            
            #add-point:AFTER FIELD pmda201 name="input.a.pmda201"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmda201
            #add-point:ON CHANGE pmda201 name="input.g.pmda201"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmda203
            
            #add-point:AFTER FIELD pmda203 name="input.a.pmda203"
            LET g_pmda_m.pmda203_desc = ' '
            DISPLAY BY NAME g_pmda_m.pmda203_desc
            IF NOT cl_null(g_pmda_m.pmda203) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_pmda_m.pmda203 != g_pmda_m_t.pmda203 OR g_pmda_m_t.pmda203 IS NULL )) THEN   #160824-00007#18 20160914 mark by beckxie
               IF g_pmda_m.pmda203 != g_pmda_m_o.pmda203 OR cl_null(g_pmda_m_o.pmda203) THEN   #160824-00007#18 20160914 add by beckxie
                  CALL s_aooi500_chk(g_prog,'pmdbsite',g_pmda_m.pmda203,g_pmda_m.pmdasite) RETURNING l_success,l_errno
                   IF NOT l_success THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.extend = ''
                      LET g_errparam.code   = l_errno
                      LET g_errparam.popup  = TRUE
                      CALL cl_err()
                  
                      #LET g_pmda_m.pmda203 = g_pmda_m_t.pmda203   #160824-00007#18 20160914 mark by beckxie
                      LET g_pmda_m.pmda203 = g_pmda_m_o.pmda203   #160824-00007#18 20160914 add by beckxie
                      CALL s_desc_get_department_desc(g_pmda_m.pmda203) RETURNING g_pmda_m.pmda203_desc
                      DISPLAY BY NAME g_pmda_m.pmda203_desc  
                      NEXT FIELD CURRENT
                  END IF
                  #IF s_aooi500_setpoint(g_prog,'pmda203') THEN
                  #   CALL s_aooi500_chk(g_prog,'pmda203',g_pmda_m.pmda203,g_pmda_m.pmdasite)
                  #      RETURNING l_success,l_errno
                  #   IF NOT l_success THEN
                  #      INITIALIZE g_errparam TO NULL
                  #      LET g_errparam.extend = ""
                  #      LET g_errparam.code   = l_errno
                  #      LET g_errparam.popup  = TRUE
                  #      CALL cl_err()
                  #      LET g_pmda_m.pmda203 = g_pmda_m_t.pmda203
                  #      CALL s_desc_get_department_desc(g_pmda_m.pmda203)
                  #          RETURNING g_pmda_m.pmda203_desc
                  #      DISPLAY BY NAME g_pmda_m.pmda203_desc  
                  #      NEXT FIELD CURRENT
                  #   END IF
                  #ELSE            
                  #   INITIALIZE g_chkparam.* TO NULL
                  #   LET g_errshow = '1'
                  #   LET g_chkparam.arg1 = g_pmda_m.pmda203
                  #   LET g_chkparam.arg2 = '8'
                  #   LET g_chkparam.arg3 = g_pmda_m.pmdasite
                  #   IF NOT cl_chk_exist("v_ooed004") THEN
                  #      LET g_pmda_m.pmda203 = g_pmda_m_t.pmda203
                  #      CALL s_desc_get_department_desc(g_pmda_m.pmda203)
                  #          RETURNING g_pmda_m.pmda203_desc
                  #      DISPLAY BY NAME g_pmda_m.pmda203_desc  
                  #      NEXT FIELD CURRENT
                  #   END IF
                  #END IF
               END IF
            END IF
            LET g_pmda_m_o.pmda203 = g_pmda_m.pmda203   #160824-00007#18 20160914 add by beckxie
            CALL s_desc_get_department_desc(g_pmda_m.pmda203) RETURNING g_pmda_m.pmda203_desc
            DISPLAY BY NAME g_pmda_m.pmda203_desc                
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmda203
            #add-point:BEFORE FIELD pmda203 name="input.b.pmda203"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmda203
            #add-point:ON CHANGE pmda203 name="input.g.pmda203"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmda207
            #add-point:BEFORE FIELD pmda207 name="input.b.pmda207"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmda207
            
            #add-point:AFTER FIELD pmda207 name="input.a.pmda207"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmda207
            #add-point:ON CHANGE pmda207 name="input.g.pmda207"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmda007
            #add-point:BEFORE FIELD pmda007 name="input.b.pmda007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmda007
            
            #add-point:AFTER FIELD pmda007 name="input.a.pmda007"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmda007
            #add-point:ON CHANGE pmda007 name="input.g.pmda007"
            
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
         BEFORE FIELD pmda028
            #add-point:BEFORE FIELD pmda028 name="input.b.pmda028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmda028
            
            #add-point:AFTER FIELD pmda028 name="input.a.pmda028"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmda028
            #add-point:ON CHANGE pmda028 name="input.g.pmda028"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmda204
            
            #add-point:AFTER FIELD pmda204 name="input.a.pmda204"
            LET g_pmda_m.pmda204_desc = ''
            DISPLAY BY NAME g_pmda_m.pmda204_desc
            IF NOT cl_null(g_pmda_m.pmda204) THEN 
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_pmda_m.pmda204 != g_pmda_m_t.pmda204 OR g_pmda_m_t.pmda204 IS NULL )) THEN   #160824-00007#18 20160914 mark by beckxie
               IF g_pmda_m.pmda204 != g_pmda_m_o.pmda204 OR cl_null(g_pmda_m_o.pmda204) THEN   #160824-00007#18 20160914 add by beckxie
                  IF s_aooi500_setpoint(g_prog,'pmda204') THEN
                     CALL s_aooi500_chk(g_prog,'pmda204',g_pmda_m.pmda204,g_pmda_m.pmdasite)
                        RETURNING l_success,l_errno
                     IF NOT l_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = ""
                        LET g_errparam.code   = l_errno
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()
                        #LET g_pmda_m.pmda204 = g_pmda_m_t.pmda204   #160824-00007#18 20160914 mark by beckxie
                        LET g_pmda_m.pmda204 = g_pmda_m_o.pmda204    #160824-00007#18 20160914 add by beckxie
                        CALL s_desc_get_department_desc(g_pmda_m.pmda204) RETURNING g_pmda_m.pmda204_desc
                        DISPLAY BY NAME g_pmda_m.pmda204_desc 
                        NEXT FIELD CURRENT
                     END IF
                  ELSE
                     INITIALIZE g_chkparam.* TO NULL
                     LET g_chkparam.arg1 = g_pmda_m.pmda204
                     IF NOT cl_chk_exist("v_ooef001_34") THEN
                        #LET g_pmda_m.pmda204 = g_pmda_m_t.pmda204   #160824-00007#18 20160914 mark by beckxie
                        LET g_pmda_m.pmda204 = g_pmda_m_o.pmda204    #160824-00007#18 20160914 add by beckxie
                        CALL s_desc_get_department_desc(g_pmda_m.pmda204)
                            RETURNING g_pmda_m.pmda204_desc
                        DISPLAY BY NAME g_pmda_m.pmda204_desc 
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF 
            LET g_pmda_m_o.pmda204 = g_pmda_m.pmda204   #160824-00007#18 20160914 add by beckxie
            CALL s_desc_get_department_desc(g_pmda_m.pmda204) RETURNING g_pmda_m.pmda204_desc
            DISPLAY BY NAME g_pmda_m.pmda204_desc            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmda204
            #add-point:BEFORE FIELD pmda204 name="input.b.pmda204"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmda204
            #add-point:ON CHANGE pmda204 name="input.g.pmda204"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmda205
            
            #add-point:AFTER FIELD pmda205 name="input.a.pmda205"
            LET g_pmda_m.pmda205_desc = ''            
            DISPLAY BY NAME  g_pmda_m.pmda205_desc
            IF NOT cl_null(g_pmda_m.pmda205) THEN 
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_pmda_m.pmda205 != g_pmda_m_t.pmda205 OR g_pmda_m_t.pmda205 IS NULL )) THEN   #160824-00007#18 20160914 add by beckxie
               IF g_pmda_m.pmda205 != g_pmda_m_o.pmda205 OR cl_null(g_pmda_m_o.pmda205) THEN   #160824-00007#18 20160914 add by beckxie
                  IF s_aooi500_setpoint(g_prog,'pmda205') THEN
                     CALL s_aooi500_chk(g_prog,'pmda205',g_pmda_m.pmda205,g_pmda_m.pmdasite)
                        RETURNING l_success,l_errno
                     IF NOT l_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = ""
                        LET g_errparam.code   = l_errno
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()
                        #LET g_pmda_m.pmda205 = g_pmda_m_t.pmda205   #160824-00007#18 20160914 mark by beckxie
                        LET g_pmda_m.pmda205 = g_pmda_m_o.pmda205   #160824-00007#18 20160914 add by beckxie
                        CALL s_desc_get_department_desc(g_pmda_m.pmda205) RETURNING g_pmda_m.pmda205_desc
                        DISPLAY BY NAME g_pmda_m.pmda205_desc  
                        NEXT FIELD CURRENT
                     END IF
                  ELSE
                     INITIALIZE g_chkparam.* TO NULL
                     LET g_chkparam.arg1 = g_pmda_m.pmda205
                     IF NOT cl_chk_exist("v_ooef001_33") THEN
                        #LET g_pmda_m.pmda205 = g_pmda_m_t.pmda205   #160824-00007#18 20160914 mark by beckxie
                        LET g_pmda_m.pmda205 = g_pmda_m_o.pmda205   #160824-00007#18 20160914 add by beckxie
                        CALL s_desc_get_department_desc(g_pmda_m.pmda205) RETURNING g_pmda_m.pmda205_desc
                        DISPLAY BY NAME g_pmda_m.pmda205_desc  
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            #160426-00008#1 160505 by sakura add(S)
            ELSE
               LET g_pmda_m.pmda206 = ''
               LET g_pmda_m_o.pmda206 = g_pmda_m.pmda206   #160824-00007#18 20160914 add by beckxie
               LET g_pmda_m.pmda206_desc = ''
            #160426-00008#1 160505 by sakura add(E)               
            END IF 
            LET g_pmda_m_o.pmda205 = g_pmda_m.pmda205   #160824-00007#18 20160914 add by beckxie
            CALL s_desc_get_department_desc(g_pmda_m.pmda205) RETURNING g_pmda_m.pmda205_desc
            DISPLAY BY NAME g_pmda_m.pmda205_desc
            CALL apmt830_set_entry(p_cmd)
            CALL apmt830_set_no_entry(p_cmd)            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmda205
            #add-point:BEFORE FIELD pmda205 name="input.b.pmda205"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmda205
            #add-point:ON CHANGE pmda205 name="input.g.pmda205"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmda206
            
            #add-point:AFTER FIELD pmda206 name="input.a.pmda206"
            LET g_pmda_m.pmda206_desc= ''
            DISPLAY BY NAME g_pmda_m.pmda206_desc
            IF NOT cl_null(g_pmda_m.pmda206) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_pmda_m.pmda206 != g_pmda_m_t.pmda206 OR g_pmda_m_t.pmda206 IS NULL )) THEN   #160824-00007#18 20160914 mark by beckxie
               IF g_pmda_m.pmda206 != g_pmda_m_o.pmda206 OR g_pmda_m_o.pmda206 IS NULL THEN   #160824-00007#18 20160914 add by beckxie
                  IF NOT apmt830_pmda206_chk() THEN
                     #LET g_pmda_m.pmda206 = g_pmda_m_t.pmda206   #160824-00007#18 20160914 mark by beckxie
                     LET g_pmda_m.pmda206 = g_pmda_m_o.pmda206    #160824-00007#18 20160914 add by beckxie
                     CALL s_desc_get_stock_desc(g_pmda_m.pmda205,g_pmda_m.pmda206) RETURNING  g_pmda_m.pmda206_desc 
                     DISPLAY BY NAME g_pmda_m.pmda206_desc
                     NEXT FIELD pmda206
                  END IF
               END IF
            END IF
            LET g_pmda_m_o.pmda206 = g_pmda_m.pmda206   #160824-00007#18 20160914 add by beckxie
            CALL s_desc_get_stock_desc(g_pmda_m.pmda205,g_pmda_m.pmda206) RETURNING  g_pmda_m.pmda206_desc
            DISPLAY BY NAME g_pmda_m.pmda206_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmda206
            #add-point:BEFORE FIELD pmda206 name="input.b.pmda206"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmda206
            #add-point:ON CHANGE pmda206 name="input.g.pmda206"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmda021
            
            #add-point:AFTER FIELD pmda021 name="input.a.pmda021"
            LET g_pmda_m.pmda021_desc = ''
            DISPLAY BY NAME g_pmda_m.pmda021_desc
            IF NOT cl_null(g_pmda_m.pmda021) THEN           
             # IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_pmda_m.pmda021 != g_pmda_m_o.pmda021 OR g_pmda_m_o.pmda021 IS NULL )) THEN   #150521-00015#2 15/05/28 s983961---mark               
                 IF g_pmda_m.pmda021 != g_pmda_m_o.pmda021 OR cl_null(g_pmda_m_o.pmda021) THEN   #150521-00015#2 15/05/28 s983961---add
                     IF NOT s_azzi650_chk_exist('263',g_pmda_m.pmda021) THEN
                        LET g_pmda_m.pmda021 = g_pmda_m_o.pmda021
                        CALL s_desc_get_acc_desc('263',g_pmda_m.pmda021) RETURNING g_pmda_m.pmda021_desc
                        DISPLAY BY NAME g_pmda_m.pmda021_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
              # END IF  #150521 s983961---mark 
            END IF
            LET g_pmda_m_o.pmda021 = g_pmda_m.pmda021
            CALL s_desc_get_acc_desc('263',g_pmda_m.pmda021) RETURNING g_pmda_m.pmda021_desc
            DISPLAY BY NAME g_pmda_m.pmda021_desc            
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
         BEFORE FIELD pmda208
            #add-point:BEFORE FIELD pmda208 name="input.b.pmda208"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmda208
            
            #add-point:AFTER FIELD pmda208 name="input.a.pmda208"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmda208
            #add-point:ON CHANGE pmda208 name="input.g.pmda208"
            
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
 
 
 #欄位檢查
                  #Ctrlp:input.c.pmdasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdasite
            #add-point:ON ACTION controlp INFIELD pmdasite name="input.c.pmdasite"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmda_m.pmdasite             #給予default值
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'pmdasite',g_pmda_m.pmdasite,'i') #150308-00001#1  By Ken add 'i' 150309
            CALL q_ooef001_24()
            LET g_pmda_m.pmdasite = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmda_m.pmdasite TO pmdasite              #顯示到畫面上
            CALL s_desc_get_department_desc(g_pmda_m.pmdasite) RETURNING g_pmda_m.pmdasite_desc
            DISPLAY BY NAME g_pmda_m.pmdasite_desc
            NEXT FIELD pmdasite


            #END add-point
 
 
         #Ctrlp:input.c.pmda200
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmda200
            #add-point:ON ACTION controlp INFIELD pmda200 name="input.c.pmda200"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmdadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdadocdt
            #add-point:ON ACTION controlp INFIELD pmdadocdt name="input.c.pmdadocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmdadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdadocno
            #add-point:ON ACTION controlp INFIELD pmdadocno name="input.c.pmdadocno"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmda_m.pmdadocno             #給予default值

            #抓單據別參照表
            LET g_ooef004 = ''
            SELECT ooef004 INTO g_ooef004 FROM ooef_t
             WHERE ooefent = g_enterprise
               AND ooef001 = g_pmda_m.pmdasite
            IF cl_null(g_ooef004) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'art-00007'
               LET g_errparam.extend = g_pmda_m.pmdasite
               LET g_errparam.popup = TRUE
               CALL cl_err()            
            END IF 

            #給予arg
            LET g_qryparam.arg1 = g_ooef004
            LET g_qryparam.arg2 = g_prog

            CALL q_ooba002_1()                                #呼叫開窗

            LET g_pmda_m.pmdadocno = g_qryparam.return1              

            DISPLAY g_pmda_m.pmdadocno TO pmdadocno              #

            NEXT FIELD pmdadocno                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmda001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmda001
            #add-point:ON ACTION controlp INFIELD pmda001 name="input.c.pmda001"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmda002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmda002
            #add-point:ON ACTION controlp INFIELD pmda002 name="input.c.pmda002"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmda_m.pmda002             #給予default值
            CALL q_ooag001()                                #呼叫開窗
            LET g_pmda_m.pmda002 = g_qryparam.return1              
            DISPLAY g_pmda_m.pmda002 TO pmda002              #
            CALL s_desc_get_person_desc(g_pmda_m.pmda002) RETURNING g_pmda_m.pmda002_desc
            DISPLAY BY NAME g_pmda_m.pmda002_desc             
            NEXT FIELD pmda002                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.pmda003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmda003
            #add-point:ON ACTION controlp INFIELD pmda003 name="input.c.pmda003"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmda_m.pmda003             #給予default值          
            LET g_qryparam.arg1 = g_pmda_m.pmdadocdt 
            #CALL q_ooeg001()                                #呼叫開窗  #160303-00028#9 dongsz mark
            CALL q_ooeg001_9()    #呼叫開窗  #160303-00028#9 dongsz add
            LET g_pmda_m.pmda003 = g_qryparam.return1              
            DISPLAY g_pmda_m.pmda003 TO pmda003    
            CALL s_desc_get_department_desc(g_pmda_m.pmda003) RETURNING g_pmda_m.pmda003_desc 
            DISPLAY BY NAME g_pmda_m.pmda003_desc            
            NEXT FIELD pmda003                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.pmdastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdastus
            #add-point:ON ACTION controlp INFIELD pmdastus name="input.c.pmdastus"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmda202
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmda202
            #add-point:ON ACTION controlp INFIELD pmda202 name="input.c.pmda202"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmda_m.pmda202             #給予default值
			   CALL cl_get_para(g_enterprise,g_site,'E-CIR-0001') RETURNING l_sys #取得品類層級
            LET g_qryparam.arg1 = l_sys #
            #150512-00026#1 Add-S By Ken 150522
            SELECT COUNT(*) INTO l_n
              FROM rtaz_t
             WHERE rtazent = g_enterprise
               AND rtaz001 = g_prog
               AND rtazstus = 'Y'
            IF l_n > 0 THEN
               LET g_qryparam.where = " rtax001 IN (SELECT rtay002 FROM rtay_t WHERE rtayent = ",g_enterprise," ",
                                      "                AND rtay001 = '",g_pmda_m.pmda003,"' AND rtaystus = 'Y') "
            END IF
            #150512-00026#1 Add-E By Ken 150522
            CALL q_rtax001_3()                                #呼叫開窗
            LET g_pmda_m.pmda202 = g_qryparam.return1              
            DISPLAY g_pmda_m.pmda202 TO pmda202              #
            CALL s_desc_get_rtaxl003_desc(g_pmda_m.pmda202) RETURNING g_pmda_m.pmda202_desc
            DISPLAY BY NAME g_pmda_m.pmda202_desc              
            NEXT FIELD pmda202                          #返回原欄位
          
            #END add-point
 
 
         #Ctrlp:input.c.pmda201
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmda201
            #add-point:ON ACTION controlp INFIELD pmda201 name="input.c.pmda201"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmda203
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmda203
            #add-point:ON ACTION controlp INFIELD pmda203 name="input.c.pmda203"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmda_m.pmda203             #給予default值
            
            #IF s_aooi500_setpoint(g_prog,'pmda203') THEN
            #   LET g_qryparam.where = s_aooi500_q_where(g_prog,'pmda203',g_pmda_m.pmdasite,'i') #150308-00001#1  By Ken add 'i' 150309
            #   CALL q_ooef001_24()
            #ELSE    
            #   LET g_qryparam.arg1 = g_pmda_m.pmdasite#
            #   LET g_qryparam.arg2 = "8" #            
            #   CALL q_ooed004()                                #呼叫開窗 
            #END IF  

            LET g_qryparam.where = s_aooi500_q_where(g_prog,'pmdbsite',g_pmda_m.pmdasite,'i') #150308-00001#1  By Ken add 'i' 150309
            CALL q_ooef001_24()   #呼叫開窗

            LET g_pmda_m.pmda203 = g_qryparam.return1              
            DISPLAY g_pmda_m.pmda203 TO pmda203  
            CALL s_desc_get_department_desc(g_pmda_m.pmda203)
                RETURNING g_pmda_m.pmda203_desc
            DISPLAY BY NAME g_pmda_m.pmda203_desc    
            NEXT FIELD pmda203                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmda207
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmda207
            #add-point:ON ACTION controlp INFIELD pmda207 name="input.c.pmda207"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmda007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmda007
            #add-point:ON ACTION controlp INFIELD pmda007 name="input.c.pmda007"
 
            #END add-point
 
 
         #Ctrlp:input.c.pmda006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmda006
            #add-point:ON ACTION controlp INFIELD pmda006 name="input.c.pmda006"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmda004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmda004
            #add-point:ON ACTION controlp INFIELD pmda004 name="input.c.pmda004"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmda020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmda020
            #add-point:ON ACTION controlp INFIELD pmda020 name="input.c.pmda020"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmda028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmda028
            #add-point:ON ACTION controlp INFIELD pmda028 name="input.c.pmda028"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmda204
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmda204
            #add-point:ON ACTION controlp INFIELD pmda204 name="input.c.pmda204"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmda_m.pmda204             #給予default值
            IF s_aooi500_setpoint(g_prog,'pmda204') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'pmda204',g_pmda_m.pmdasite,'i') #150308-00001#1  By Ken add 'i' 150309
               CALL q_ooef001_24()
            ELSE    
               LET g_qryparam.where = "ooef303 = 'Y'"
               CALL q_ooef001()                                #呼叫開窗          
            END IF   
            LET g_pmda_m.pmda204 = g_qryparam.return1              
            DISPLAY g_pmda_m.pmda204 TO pmda204   
            CALL s_desc_get_department_desc(g_pmda_m.pmda204) RETURNING g_pmda_m.pmda204_desc
            DISPLAY BY NAME g_pmda_m.pmda204_desc             
            NEXT FIELD pmda204                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.pmda205
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmda205
            #add-point:ON ACTION controlp INFIELD pmda205 name="input.c.pmda205"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmda_m.pmda205             #給予default值
           
            IF s_aooi500_setpoint(g_prog,'pmda205') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'pmda205',g_pmda_m.pmdasite,'i') #150308-00001#1  By Ken add 'i' 150309
               CALL q_ooef001_24()
            ELSE    
               LET g_qryparam.where = "ooef302 = 'Y'"
               CALL q_ooef001()                                #呼叫開窗          
            END IF   
            LET g_pmda_m.pmda205 = g_qryparam.return1              
            CALL s_desc_get_department_desc(g_pmda_m.pmda205) RETURNING g_pmda_m.pmda205_desc
            DISPLAY BY NAME g_pmda_m.pmda205_desc             
            DISPLAY g_pmda_m.pmda205 TO pmda205   
            
            NEXT FIELD pmda205                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.pmda206
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmda206
            #add-point:ON ACTION controlp INFIELD pmda206 name="input.c.pmda206"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmda_m.pmda206             #給予default值
            LET g_qryparam.arg1 = g_pmda_m.pmda205
            CALL q_inaa001_6()                                #呼叫開窗
            LET g_pmda_m.pmda206 = g_qryparam.return1              
            DISPLAY g_pmda_m.pmda206 TO pmda206  
            CALL s_desc_get_stock_desc(g_pmda_m.pmda205,g_pmda_m.pmda206) RETURNING  g_pmda_m.pmda206_desc 
            DISPLAY BY NAME g_pmda_m.pmda206_desc            
            NEXT FIELD pmda206                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.pmda021
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmda021
            #add-point:ON ACTION controlp INFIELD pmda021 name="input.c.pmda021"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmda_m.pmda021             #給予default值
            LET g_qryparam.default2 = "" #g_pmda_m.oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "263"
            CALL q_oocq002()                                #呼叫開窗
            LET g_pmda_m.pmda021 = g_qryparam.return1              
            DISPLAY g_pmda_m.pmda021 TO pmda021   
            CALL s_desc_get_acc_desc('263',g_pmda_m.pmda021) RETURNING g_pmda_m.pmda021_desc
            DISPLAY BY NAME g_pmda_m.pmda021_desc            
            NEXT FIELD pmda021                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.pmda208
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmda208
            #add-point:ON ACTION controlp INFIELD pmda208 name="input.c.pmda208"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmda022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmda022
            #add-point:ON ACTION controlp INFIELD pmda022 name="input.c.pmda022"
            
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
               CALL s_aooi200_gen_docno(g_site,g_pmda_m.pmdadocno,g_pmda_m.pmdadocdt,g_prog) 
                  RETURNING l_success,g_pmda_m.pmdadocno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apm-00003'
                  LET g_errparam.extend = g_pmda_m.pmdadocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD pmdadocno           
               END IF
               #end add-point
               
               INSERT INTO pmda_t (pmdaent,pmdasite,pmda200,pmdadocdt,pmdadocno,pmda001,pmda002,pmda003, 
                   pmdastus,pmda202,pmda201,pmda203,pmda207,pmda007,pmda006,pmda004,pmda020,pmda028, 
                   pmda027,pmda204,pmda205,pmda206,pmda021,pmda208,pmda022,pmdaownid,pmdaowndp,pmdacrtid, 
                   pmdacrtdp,pmdacrtdt,pmdamodid,pmdamoddt,pmdacnfid,pmdacnfdt,pmdapstid,pmdapstdt)
               VALUES (g_enterprise,g_pmda_m.pmdasite,g_pmda_m.pmda200,g_pmda_m.pmdadocdt,g_pmda_m.pmdadocno, 
                   g_pmda_m.pmda001,g_pmda_m.pmda002,g_pmda_m.pmda003,g_pmda_m.pmdastus,g_pmda_m.pmda202, 
                   g_pmda_m.pmda201,g_pmda_m.pmda203,g_pmda_m.pmda207,g_pmda_m.pmda007,g_pmda_m.pmda006, 
                   g_pmda_m.pmda004,g_pmda_m.pmda020,g_pmda_m.pmda028,g_pmda_m.pmda027,g_pmda_m.pmda204, 
                   g_pmda_m.pmda205,g_pmda_m.pmda206,g_pmda_m.pmda021,g_pmda_m.pmda208,g_pmda_m.pmda022, 
                   g_pmda_m.pmdaownid,g_pmda_m.pmdaowndp,g_pmda_m.pmdacrtid,g_pmda_m.pmdacrtdp,g_pmda_m.pmdacrtdt, 
                   g_pmda_m.pmdamodid,g_pmda_m.pmdamoddt,g_pmda_m.pmdacnfid,g_pmda_m.pmdacnfdt,g_pmda_m.pmdapstid, 
                   g_pmda_m.pmdapstdt) 
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
               
               #end add-point
               
               
               
               
               #add-point:單頭新增後 name="input.head.a_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL apmt830_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL apmt830_b_fill()
                  CALL apmt830_b_fill2('0')
               END IF
               
               #add-point:單頭新增後 name="input.head.a_insert2"
               #150324-00006#13 2015/04/06 By pomelo add(S)
               LET l_cnt = 0
               SELECT COUNT(pmdbseq) INTO l_cnt
                 FROM pmdb_t
                WHERE pmdbent = g_enterprise
                  AND pmdbdocno = g_pmda_m.pmdadocno
               IF l_cnt = 0 THEN                  
                  LET l_pmeusite = ''
                  LET l_pmeu001 = ''
                  CALL apmt830_get_pmeu() RETURNING l_pmeusite,l_pmeu001
                  IF NOT cl_null(l_pmeusite) THEN
                     #是否依要貨組織預設要貨資料整批產生要貨單身子作業自動產生單身?
                     IF cl_ask_confirm('apm-00877') THEN
                        CALL apmt830_01(g_pmda_m.pmdadocno,l_pmeusite,l_pmeu001)
                        CALL apmt830_b_fill()
                     END IF                     
                  #150504-00024#1 Add-S By Ken 150528
                  ELSE
                     #是否依供應商資料整批產生要貨單身?
                     IF cl_ask_confirm('apm-00928') THEN
                        CALL apmt830_02('1',g_pmda_m.pmdadocno,g_pmda_m.pmdadocdt,g_pmda_m.pmdasite)
                        CALL apmt830_b_fill()
                        LET INT_FLAG = 0
                     END IF                  
                  END IF
                  #150504-00024#1 Add-E By Ken 150528
                  LET l_auto_detail = 'N'
               END IF
               #150324-00006#13 2015/04/06 By pomelo add(E)
               #end add-point
               
               LET g_master_insert = TRUE
               
               LET p_cmd = 'u'
            ELSE
               CALL s_transaction_begin()
            
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL apmt830_pmda_t_mask_restore('restore_mask_o')
               
               UPDATE pmda_t SET (pmdasite,pmda200,pmdadocdt,pmdadocno,pmda001,pmda002,pmda003,pmdastus, 
                   pmda202,pmda201,pmda203,pmda207,pmda007,pmda006,pmda004,pmda020,pmda028,pmda027,pmda204, 
                   pmda205,pmda206,pmda021,pmda208,pmda022,pmdaownid,pmdaowndp,pmdacrtid,pmdacrtdp,pmdacrtdt, 
                   pmdamodid,pmdamoddt,pmdacnfid,pmdacnfdt,pmdapstid,pmdapstdt) = (g_pmda_m.pmdasite, 
                   g_pmda_m.pmda200,g_pmda_m.pmdadocdt,g_pmda_m.pmdadocno,g_pmda_m.pmda001,g_pmda_m.pmda002, 
                   g_pmda_m.pmda003,g_pmda_m.pmdastus,g_pmda_m.pmda202,g_pmda_m.pmda201,g_pmda_m.pmda203, 
                   g_pmda_m.pmda207,g_pmda_m.pmda007,g_pmda_m.pmda006,g_pmda_m.pmda004,g_pmda_m.pmda020, 
                   g_pmda_m.pmda028,g_pmda_m.pmda027,g_pmda_m.pmda204,g_pmda_m.pmda205,g_pmda_m.pmda206, 
                   g_pmda_m.pmda021,g_pmda_m.pmda208,g_pmda_m.pmda022,g_pmda_m.pmdaownid,g_pmda_m.pmdaowndp, 
                   g_pmda_m.pmdacrtid,g_pmda_m.pmdacrtdp,g_pmda_m.pmdacrtdt,g_pmda_m.pmdamodid,g_pmda_m.pmdamoddt, 
                   g_pmda_m.pmdacnfid,g_pmda_m.pmdacnfdt,g_pmda_m.pmdapstid,g_pmda_m.pmdapstdt)
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
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL apmt830_pmda_t_mask_restore('restore_mask_n')
               
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
 
{<section id="apmt830.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_pmdb_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_pmdb_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL apmt830_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_pmdb_d.getLength()
            #add-point:資料輸入前 name="input.d.before_input"
            #150324-00006#13 2015/04/06 By pomelo add(S)
            LET l_cnt = 0
            SELECT COUNT(pmdbseq) INTO l_cnt
              FROM pmdb_t
             WHERE pmdbent = g_enterprise
               AND pmdbdocno = g_pmda_m.pmdadocno
            IF l_cnt = 0 AND l_auto_detail = 'Y' THEN
               LET l_pmeusite = ''
               LET l_pmeu001 = ''
               CALL apmt830_get_pmeu() RETURNING l_pmeusite,l_pmeu001
               IF NOT cl_null(l_pmeusite) THEN
                  #是否依要貨組織預設要貨資料整批產生要貨單身子作業自動產生單身?
                  IF cl_ask_confirm('apm-00877') THEN
                     CALL apmt830_01(g_pmda_m.pmdadocno,l_pmeusite,l_pmeu001)
                     CALL apmt830_b_fill()
                  END IF
               #150504-00024#1 Add-S By Ken 150528
               ELSE
                  #是否依供應商資料整批產生要貨單身?
                  IF cl_ask_confirm('apm-00928') THEN
                     CALL apmt830_02('1',g_pmda_m.pmdadocno,g_pmda_m.pmdadocdt,g_pmda_m.pmdasite)
                     CALL apmt830_b_fill()
                     LET INT_FLAG = 0
                  END IF                  
               END IF
               #150504-00024#1 Add-E By Ken 150528               
            END IF
            #150324-00006#13 2015/04/06 By pomelo add(E)
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
            OPEN apmt830_cl USING g_enterprise,g_pmda_m.pmdadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN apmt830_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE apmt830_cl
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
               CALL apmt830_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               #add-S By Ken 150318
               CALL apmt830_set_no_required_b(l_cmd)
               CALL apmt830_set_required_b(l_cmd)
               #add-E  
               #end add-point  
               CALL apmt830_set_no_entry_b(l_cmd)
               IF NOT apmt830_lock_b("pmdb_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH apmt830_bcl INTO g_pmdb_d[l_ac].pmdbseq,g_pmdb_d[l_ac].pmdb001,g_pmdb_d[l_ac].pmdb002, 
                      g_pmdb_d[l_ac].pmdb003,g_pmdb_d[l_ac].pmdbsite,g_pmdb_d[l_ac].pmdb200,g_pmdb_d[l_ac].pmdb004, 
                      g_pmdb_d[l_ac].pmdb005,g_pmdb_d[l_ac].pmdb033,g_pmdb_d[l_ac].pmdb037,g_pmdb_d[l_ac].pmdb260, 
                      g_pmdb_d[l_ac].pmdb038,g_pmdb_d[l_ac].pmdb227,g_pmdb_d[l_ac].pmdb201,g_pmdb_d[l_ac].pmdb202, 
                      g_pmdb_d[l_ac].pmdb212,g_pmdb_d[l_ac].pmdb007,g_pmdb_d[l_ac].pmdb213,g_pmdb_d[l_ac].pmdb261, 
                      g_pmdb_d[l_ac].pmdb006,g_pmdb_d[l_ac].pmdb253,g_pmdb_d[l_ac].pmdb258,g_pmdb_d[l_ac].pmdb254, 
                      g_pmdb_d[l_ac].pmdb255,g_pmdb_d[l_ac].pmdb256,g_pmdb_d[l_ac].pmdb257,g_pmdb_d[l_ac].pmdb259, 
                      g_pmdb_d[l_ac].pmdb252,g_pmdb_d[l_ac].pmdb207,g_pmdb_d[l_ac].pmdb015,g_pmdb_d[l_ac].pmdb049, 
                      g_pmdb_d[l_ac].pmdb030,g_pmdb_d[l_ac].pmdb048,g_pmdb_d[l_ac].pmdb208,g_pmdb_d[l_ac].pmdb209, 
                      g_pmdb_d[l_ac].pmdb206,g_pmdb_d[l_ac].pmdb210,g_pmdb_d[l_ac].pmdb211,g_pmdb_d[l_ac].pmdb205, 
                      g_pmdb_d[l_ac].pmdb203,g_pmdb_d[l_ac].pmdb204,g_pmdb_d[l_ac].pmdb032,g_pmdb_d[l_ac].pmdb051 
 
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
                  CALL apmt830_pmdb_t_mask()
                  LET g_pmdb_d_mask_n[l_ac].* =  g_pmdb_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL apmt830_show()
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
            INITIALIZE g_pmdb_d[l_ac].* TO NULL 
            INITIALIZE g_pmdb_d_t.* TO NULL 
            INITIALIZE g_pmdb_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_pmdb_d[l_ac].pmdb033 = "1"
      LET g_pmdb_d[l_ac].pmdb202 = "0"
      LET g_pmdb_d[l_ac].pmdb212 = "0"
      LET g_pmdb_d[l_ac].pmdb213 = "0"
      LET g_pmdb_d[l_ac].pmdb261 = "0"
      LET g_pmdb_d[l_ac].pmdb006 = "0"
      LET g_pmdb_d[l_ac].pmdb253 = "0"
      LET g_pmdb_d[l_ac].pmdb258 = "0"
      LET g_pmdb_d[l_ac].pmdb254 = "0"
      LET g_pmdb_d[l_ac].pmdb255 = "0"
      LET g_pmdb_d[l_ac].pmdb256 = "0"
      LET g_pmdb_d[l_ac].pmdb257 = "0"
      LET g_pmdb_d[l_ac].pmdb259 = "0"
      LET g_pmdb_d[l_ac].pmdb252 = "0"
      LET g_pmdb_d[l_ac].l_pmdb252 = "0"
      LET g_pmdb_d[l_ac].pmdb049 = "0"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            #項次加1
            SELECT MAX(pmdbseq)+1 INTO g_pmdb_d[l_ac].pmdbseq
              FROM pmdb_t
             WHERE pmdbent = g_enterprise
               AND pmdbdocno = g_pmda_m.pmdadocno
            IF cl_null(g_pmdb_d[l_ac].pmdbseq) OR g_pmdb_d[l_ac].pmdbseq = 0 THEN
               LET g_pmdb_d[l_ac].pmdbseq = 1
            END IF            
            
            #單頭需求組織(pmda203)非空白時，Default = pmda203，且不可修改
            IF NOT cl_null(g_pmda_m.pmda203) THEN
               LET g_pmdb_d[l_ac].pmdbsite = g_pmda_m.pmda203
            ELSE
               #LET g_pmdb_d[l_ac].pmdbsite =g_site    #151113-00003#11 151130 By pomelo mark
               LET g_pmdb_d[l_ac].pmdbsite = g_pmda_m.pmdasite #151113-00003#11 151130 By pomelo add
            END IF
            CALL s_desc_get_department_desc(g_pmdb_d[l_ac].pmdbsite) RETURNING g_pmdb_d[l_ac].pmdbsite_desc            
  
            #收貨組織預設 = 需求組織  
            LET g_pmdb_d[l_ac].pmdb037 = g_pmdb_d[l_ac].pmdbsite
            CALL s_desc_get_department_desc(g_pmdb_d[l_ac].pmdb037) RETURNING g_pmdb_d[l_ac].pmdb037_desc 
            
            #單身行狀態預設為1
            LET g_pmdb_d[l_ac].pmdb032 = '1' #ken 需求單號：141009-00031 項次：30
            
            #當單頭有指定採購中心時，單身採購中心預設為採購配送中心
            IF NOT cl_null(g_pmda_m.pmda204) THEN
               LET g_pmdb_d[l_ac].pmdb205 = g_pmda_m.pmda204
            END IF            
            
            #取單身採購中心的說明
            CALL s_desc_get_department_desc(g_pmdb_d[l_ac].pmdb205)
                RETURNING g_pmdb_d[l_ac].pmdb205_desc            
            
            #當單頭有指定配送中心時，單身配送中心預設為單頭配送中心
            IF NOT cl_null(g_pmda_m.pmda205) THEN
               LET g_pmdb_d[l_ac].pmdb203 = g_pmda_m.pmda205
            END IF 
            
            #取單身配送中心的說明
            CALL s_desc_get_department_desc(g_pmdb_d[l_ac].pmdb203)
               RETURNING g_pmdb_d[l_ac].pmdb203_desc            
            
            #當單頭有指定配送倉時，單身等於單頭的配送倉且不可修改
            IF NOT cl_null(g_pmda_m.pmda206) THEN
               LET g_pmdb_d[l_ac].pmdb204 = g_pmda_m.pmda206
            END IF             
            
            #取單身配送倉的說明
            CALL s_desc_get_stock_desc(g_pmdb_d[l_ac].pmdb203,g_pmdb_d[l_ac].pmdb204) 
               RETURNING  g_pmdb_d[l_ac].pmdb204_desc          
            
            #151113-00003#11 By 151130 By pomelo add(S)
            IF NOT cl_null(g_pmda_m.pmda207) THEN
               LET g_pmdb_d[l_ac].pmdb030 = g_pmda_m.pmda207
            END IF
            #151113-00003#11 By 151130 By pomelo add(E)
            #end add-point
            LET g_pmdb_d_t.* = g_pmdb_d[l_ac].*     #新輸入資料
            LET g_pmdb_d_o.* = g_pmdb_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL apmt830_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            #add-S By Ken 150318
            CALL apmt830_set_no_required_b(l_cmd)
            CALL apmt830_set_required_b(l_cmd)
            #add-E             
            #end add-point
            CALL apmt830_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_pmdb_d[li_reproduce_target].* = g_pmdb_d[li_reproduce].*
 
               LET g_pmdb_d[li_reproduce_target].pmdbseq = NULL
 
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
            #ken---add---s 產品特徵
            #料件有使用產品特徴則不可空白
            LET l_imaa005 = ''
            CALL apmt830_get_imaa005(g_pmdb_d[l_ac].pmdb004) RETURNING l_imaa005
            IF NOT cl_null(l_imaa005) THEN
               IF cl_null(g_pmdb_d[l_ac].pmdb005) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'sub-00124'
                  LET g_errparam.extend = g_pmda_m.pmdadocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD pmdb005               
               END IF
            ELSE 
               IF cl_null(g_pmdb_d[l_ac].pmdb005) THEN
                  LET g_pmdb_d[l_ac].pmdb005 = ' ' 
               END IF          
            END IF      
            #ken---add---e
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM pmdb_t 
             WHERE pmdbent = g_enterprise AND pmdbdocno = g_pmda_m.pmdadocno
 
               AND pmdbseq = g_pmdb_d[l_ac].pmdbseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_pmda_m.pmdadocno
               LET gs_keys[2] = g_pmdb_d[g_detail_idx].pmdbseq
               CALL apmt830_insert_b('pmdb_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
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
               #CALL apmt830_b_fill()
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               #單身要貨件數加總 Update到單頭包裝總數量
               CALL apmt830_pmdb212_sum()
               #SELECT SUM(pmdb212) INTO g_pmda_m.pmda208 FROM pmdb_t  
               # WHERE pmdbent = g_enterprise AND pmdbdocno = g_pmda_m.pmdadocno 
               #DISPLAY BY NAME g_pmda_m.pmda208
               
               #ken---add---s 產品特徵 多筆同時輸入後 寫入到單身
               INITIALIZE l_pmdb.* TO NULL               
               SELECT pmdbent, pmdbsite,pmdb001, pmdb002, 
                      pmdb003, pmdb200, pmdb004, pmdb005,
                      pmdb037, pmdb260, pmdb038, pmdb201,
                      pmdb202, pmdb212, pmdb007, pmdb006,         
                      pmdb253, pmdb258, pmdb254, pmdb255,         
                      pmdb256, pmdb257, pmdb259, pmdb252,         
                      pmdb207, pmdb015, pmdb049, pmdb030,         
                      pmdb048, pmdb208, pmdb209, pmdb206,         
                      pmdb210, pmdb211, pmdb205, pmdb203,         
                      pmdb204, pmdb032, pmdb051, pmdbdocno,
                      #160919-00053#1 20160920 modify(add pmdb033) by beckxie---S
                      #pmdb227  #補貨規格說明   #150710-00016#3 Add By Ken 150714 
                      pmdb227, pmdb033,  #補貨規格說明   #150710-00016#3 Add By Ken 150714  
                      #160919-00053#1 20160920 modify(add pmdb033) by beckxie---E
                      pmdb261   #161220-00059#2 by 08172
                INTO  l_pmdb.pmdbent, l_pmdb.pmdbsite,l_pmdb.pmdb001, l_pmdb.pmdb002,  
                      l_pmdb.pmdb003, l_pmdb.pmdb200, l_pmdb.pmdb004, l_pmdb.pmdb005,  
                      l_pmdb.pmdb037, l_pmdb.pmdb260, l_pmdb.pmdb038, l_pmdb.pmdb201,  
                      l_pmdb.pmdb202, l_pmdb.pmdb212, l_pmdb.pmdb007, l_pmdb.pmdb006,  
                      l_pmdb.pmdb253, l_pmdb.pmdb258, l_pmdb.pmdb254, l_pmdb.pmdb255,  
                      l_pmdb.pmdb256, l_pmdb.pmdb257, l_pmdb.pmdb259, l_pmdb.pmdb252,  
                      l_pmdb.pmdb207, l_pmdb.pmdb015, l_pmdb.pmdb049, l_pmdb.pmdb030,  
                      l_pmdb.pmdb048, l_pmdb.pmdb208, l_pmdb.pmdb209, l_pmdb.pmdb206,  
                      l_pmdb.pmdb210, l_pmdb.pmdb211, l_pmdb.pmdb205, l_pmdb.pmdb203,  
                      l_pmdb.pmdb204, l_pmdb.pmdb032, l_pmdb.pmdb051, l_pmdb.pmdbdocno,
                      #160919-00053#1 20160920 modify(add pmdb033) by beckxie---S
                      #l_pmdb.pmdb227  #補貨規格說明   #150710-00016#3 Add By Ken 150714
                      l_pmdb.pmdb227, l_pmdb.pmdb033, #補貨規格說明   #150710-00016#3 Add By Ken 150714
                      #160919-00053#1 20160920 modify(add pmdb033) by beckxie---E
                      l_pmdb.pmdb261    #161220-00059#2 by 08172
                 FROM pmdb_t 
                WHERE pmdbent = g_enterprise
                  AND pmdbdocno = g_pmda_m.pmdadocno
                  AND pmdbseq = g_pmdb_d[l_ac].pmdbseq
                  
               IF l_inam.getLength() > 1 THEN  #因為第一筆資料已呈現在畫面並寫入DB, 從第二筆開始處理           
                  LET l_pmdbseq = ''
                  SELECT MAX(pmdbseq) INTO l_pmdbseq
                    FROM pmdb_t
                   WHERE pmdbent   = g_enterprise
                     AND pmdbdocno = g_pmda_m.pmdadocno
                  
                  FOR l_i = 2 TO l_inam.getLength() 
                     IF cl_null(l_pmdbseq) OR l_pmdbseq = 0 THEN
                        LET l_pmdbseq = 1
                     ELSE
                        LET l_pmdbseq = l_pmdbseq + 1             
                     END IF                   
                     LET l_pmdb.pmdb005 = l_inam[l_i].inam002
                     LET l_pmdb.pmdb006 = l_inam[l_i].inam004
                     
                     #150415-00003#1 Modify-s By Ken 150416 產品特徵多筆輸入回傳計算數量異常修正
                     #LET g_pmdb_d[l_ac].pmdb006 = l_pmdb.pmdb006
                     #單位間的轉換數量
                     #當要貨數量為空
                     IF cl_null(l_pmdb.pmdb006) THEN
                        #當包裝數量(要貨件數)為空
                        IF cl_null(g_pmdb_d[l_ac].pmdb212) THEN
                           RETURN
                        ELSE
                           #當要貨數量為空，由包裝數量(要貨件數)轉換成要貨數量
                           CALL s_aooi250_convert_qty(g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb201,g_pmdb_d[l_ac].pmdb007,g_pmdb_d[l_ac].pmdb212)
                               RETURNING l_success,l_pmdb.pmdb006
                        END IF
                     ELSE
                        #當要貨數量有值，由要貨數量轉換成包裝數量(要貨件數)
                        CALL s_aooi250_convert_qty(g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb007,g_pmdb_d[l_ac].pmdb201,l_pmdb.pmdb006)
                            RETURNING l_success,l_pmdb.pmdb212
                     END IF                     
                     
                     #CALL apmt830_num_change()                     
                     #LET l_pmdb.pmdb212 = g_pmdb_d[l_ac].pmdb212

                     #要貨在途量計算
                     #CALL s_apmt830_sum_pmdb258(g_pmdb_d[l_ac].pmdbsite,g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb005)
                     #   RETURNING g_pmdb_d[l_ac].pmdb258  
                     CALL s_apmt830_sum_pmdb258(g_pmdb_d[l_ac].pmdbsite,g_pmdb_d[l_ac].pmdb004,l_pmdb.pmdb005)
                        RETURNING l_pmdb.pmdb258
                     
                     #前一、二、三、四週銷量及週平均銷量計算
                     #CALL apmt830_daily_sale_all(g_pmdb_d[l_ac].pmdbsite,g_pmda_m.pmdadocdt,g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb005)
                     #   RETURNING g_pmdb_d[l_ac].pmdb254,g_pmdb_d[l_ac].pmdb255,g_pmdb_d[l_ac].pmdb256,g_pmdb_d[l_ac].pmdb257,g_pmdb_d[l_ac].pmdb259
                     CALL apmt830_daily_sale_all(g_pmdb_d[l_ac].pmdbsite,g_pmda_m.pmdadocdt,g_pmdb_d[l_ac].pmdb004,l_pmdb.pmdb005)
                        RETURNING l_pmdb.pmdb254,l_pmdb.pmdb255,l_pmdb.pmdb256,l_pmdb.pmdb257,l_pmdb.pmdb259                     
                     
                     #可用庫存量
                     #CALL s_apmt840_sum_inag008(g_pmdb_d[l_i].pmdbsite,g_pmdb_d[l_i].pmdb004,g_pmdb_d[l_i].pmdb005) #150401-00005#3 sakura add pmdb005
                     #   RETURNING g_pmdb_d[l_ac].pmdb252
#                     CALL s_apmt840_sum_inag008(g_pmdb_d[l_ac].pmdbsite,g_pmdb_d[l_ac].pmdb004,l_pmdb.pmdb005) #150401-00005#3 sakura add pmdb005
#                        RETURNING l_pmdb.pmdb252  #mark by geza 201611206 161124-00039#1
                     #150415-00003#1 Modify-e 
                     
                     #add by geza 201611206 161124-00039#1(S)
                     CALL apmt830_sum_inag009(g_pmdb_d[l_ac].pmdbsite,g_pmdb_d[l_ac].pmdb004,l_pmdb.pmdb005)  
                        RETURNING l_pmdb.pmdb252
                     #add by geza 201611206 161124-00039#1(E)
                     
                     #150413-00018#1 20150414 pomelo add(S)
                     #入庫在途量計算
                     CALL s_apmt840_sum_in_way(g_pmdb_d[l_ac].pmdbsite,g_pmdb_d[l_ac].pmdb004,l_pmdb.pmdb005)
                        RETURNING l_pmdb.pmdb253
                     #150413-00018#1 20150414 pomelo add(E)
                     
                     #161228-00033#3 by sakura mark(S)
                     #161017-00029#1 16/10/18 by 08742 -S
                     #SELECT imay003 INTO  l_pmdb.pmdb200
                     #  FROM imay_t
                     # WHERE imayent = g_enterprise
                     #   AND imay019 = l_pmdb.pmdb005
                     #   AND imay001 = l_pmdb.pmdb004
                     #   AND ROWNUM = 1  
                     #IF sqlca.sqlcode = 100 THEN 
                     #   SELECT imay003 INTO  l_pmdb.pmdb200
                     #     FROM imay_t
                     #    WHERE imayent = g_enterprise
                     #      AND imay006='Y'
                     #      AND imay001 = l_pmdb.pmdb004
                     #END IF                      
                     #161017-00029#1 16/10/18 by 08742 -E
                     #161228-00033#3 by sakura mark(E)
                     
                     #161228-00033#3 by sakura add(S)
                     LET l_pmdb.pmdb200 = ''
                     LET g_sql = "SELECT imay003 ",
                                 "  FROM imay_t ",
                                 " WHERE imayent = ",g_enterprise,
                                 "   AND imay019 = '",l_pmdb.pmdb005,"'",
                                 "   AND imay001 = '",l_pmdb.pmdb004,"'"
                     PREPARE apmt830_sel_imay003_pre FROM g_sql
                     DECLARE apmt830_sel_imay003_cur SCROLL CURSOR FOR apmt830_sel_imay003_pre   
                     OPEN apmt830_sel_imay003_cur
                     FETCH FIRST apmt830_sel_imay003_cur INTO l_pmdb.pmdb200
                     CLOSE apmt830_sel_imay003_cur               
                     FREE  apmt830_sel_imay003_pre
                     
                     IF cl_null(l_pmdb.pmdb200) THEN
                        LET l_pmdb.pmdb200 = ''
                        SELECT imay003 INTO  l_pmdb.pmdb200
                          FROM imay_t
                         WHERE imayent = g_enterprise
                           AND imay006 = 'Y'
                           AND imay001 = l_pmdb.pmdb004                     
                     END IF
                     #161228-00033#3 by sakura add(E)                     
                     
                     
                     INSERT INTO pmdb_t (pmdbent, pmdbsite,pmdb001, pmdb002, 
                                         pmdb003, pmdb200, pmdb004, pmdb005,
                                         pmdb037, pmdb260, pmdb038, pmdb201,
                                         pmdb202, pmdb212, pmdb007, pmdb006,         
                                         pmdb253, pmdb258, pmdb254, pmdb255,         
                                         pmdb256, pmdb257, pmdb259, pmdb252,         
                                         pmdb207, pmdb015, pmdb049, pmdb030,         
                                         pmdb048, pmdb208, pmdb209, pmdb206,         
                                         pmdb210, pmdb211, pmdb205, pmdb203,         
                                         pmdb204, pmdb032, pmdb051, pmdbdocno, pmdbseq,
                                         #160919-00053#1 20160920 modify(add pmdb033) by beckxie---S
                                         #pmdb227) #補貨規格說明   #150710-00016#3 Add By Ken 150714
                                         pmdb227, pmdb033,pmdb261) #補貨規格說明   #150710-00016#3 Add By Ken 150714  #161220-00059#2 add pmdb261 by 08172
                                         #160919-00053#1 20160920 modify(add pmdb033) by beckxie---E
                         VALUES(l_pmdb.pmdbent, l_pmdb.pmdbsite,l_pmdb.pmdb001, l_pmdb.pmdb002,  
                                l_pmdb.pmdb003, l_pmdb.pmdb200, l_pmdb.pmdb004, l_pmdb.pmdb005,  
                                l_pmdb.pmdb037, l_pmdb.pmdb260, l_pmdb.pmdb038, l_pmdb.pmdb201,  
                                l_pmdb.pmdb202, l_pmdb.pmdb212, l_pmdb.pmdb007, l_pmdb.pmdb006,  
                                l_pmdb.pmdb253, l_pmdb.pmdb258, l_pmdb.pmdb254, l_pmdb.pmdb255,  
                                l_pmdb.pmdb256, l_pmdb.pmdb257, l_pmdb.pmdb259, l_pmdb.pmdb252,  
                                l_pmdb.pmdb207, l_pmdb.pmdb015, l_pmdb.pmdb049, l_pmdb.pmdb030,  
                                l_pmdb.pmdb048, l_pmdb.pmdb208, l_pmdb.pmdb209, l_pmdb.pmdb206,  
                                l_pmdb.pmdb210, l_pmdb.pmdb211, l_pmdb.pmdb205, l_pmdb.pmdb203,  
                                l_pmdb.pmdb204, l_pmdb.pmdb032, l_pmdb.pmdb051, l_pmdb.pmdbdocno, l_pmdbseq,
                                #160919-00053#1 20160920 modify(add pmdb033) by beckxie---S
                                l_pmdb.pmdb227, l_pmdb.pmdb033, l_pmdb.pmdb261 ) #補貨規格說明   #150710-00016#3 Add By Ken 150714  #161220-00059#2 add pmdb261 by 08172
                                #160919-00053#1 20160920 modify(add pmdb033) by beckxie---E
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = "pmdb_t"
                        LET g_errparam.popup = FALSE
                        CALL cl_err()
                     END IF
                  END FOR
                  LET g_rec_b = l_inam.getLength() - 1                  
                  CALL l_inam.clear() #150416-00013#1 Add By Ken 150423
               END IF
               CALL apmt830_b_fill() 
               #ken---add---e   
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
               LET gs_keys[01] = g_pmda_m.pmdadocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_pmdb_d_t.pmdbseq
 
            
               #刪除同層單身
               IF NOT apmt830_delete_b('pmdb_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE apmt830_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT apmt830_key_delete_b(gs_keys,'pmdb_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE apmt830_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE apmt830_bcl
            
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
         BEFORE FIELD pmdbseq
            #add-point:BEFORE FIELD pmdbseq name="input.b.page1.pmdbseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdbseq
            
            #add-point:AFTER FIELD pmdbseq name="input.a.page1.pmdbseq"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_pmda_m.pmdadocno IS NOT NULL AND g_pmdb_d[g_detail_idx].pmdbseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_pmda_m.pmdadocno != g_pmdadocno_t OR g_pmdb_d[g_detail_idx].pmdbseq != g_pmdb_d_t.pmdbseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pmdb_t WHERE "||"pmdbent = '" ||g_enterprise|| "' AND "||"pmdbdocno = '"||g_pmda_m.pmdadocno ||"' AND "|| "pmdbseq = '"||g_pmdb_d[g_detail_idx].pmdbseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


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
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdbsite
            
            #add-point:AFTER FIELD pmdbsite name="input.a.page1.pmdbsite"
            LET g_pmdb_d[l_ac].pmdbsite_desc = ''
            IF NOT cl_null(g_pmdb_d[l_ac].pmdbsite) THEN
               #IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_pmdb_d[l_ac].pmdbsite != g_pmdb_d_o.pmdbsite OR g_pmdb_d_o.pmdbsite IS NULL )) THEN   #150427-00012#5 150529 s983961---mark    
                IF g_pmdb_d[l_ac].pmdbsite != g_pmdb_d_o.pmdbsite OR cl_null(g_pmdb_d_o.pmdbsite)  THEN    #150427-00012#5 150529 s983961---add                
                  CALL s_aooi500_chk(g_prog,'pmdbsite',g_pmdb_d[l_ac].pmdbsite,g_pmda_m.pmdasite) RETURNING l_success,l_errno
                   IF NOT l_success THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.extend = ''
                      LET g_errparam.code   = l_errno
                      LET g_errparam.popup  = TRUE
                      CALL cl_err()
                  
                      LET g_pmdb_d[l_ac].pmdbsite = g_pmdb_d_o.pmdbsite
                      CALL s_desc_get_department_desc(g_pmdb_d[l_ac].pmdbsite) RETURNING g_pmdb_d[l_ac].pmdbsite_desc
                      NEXT FIELD CURRENT
                  END IF
                  #150413-00018#1 20150414 pomelo add(S)
                  #要貨在途量計算
                  CALL s_apmt830_sum_pmdb258(g_pmdb_d[l_ac].pmdbsite,g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb005)
                     RETURNING g_pmdb_d[l_ac].pmdb258
                  
                  #前一、二、三、四週銷量及週平均銷量計算
                  CALL apmt830_daily_sale_all(g_pmdb_d[l_ac].pmdbsite,g_pmda_m.pmdadocdt,g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb005)
                     RETURNING g_pmdb_d[l_ac].pmdb254,g_pmdb_d[l_ac].pmdb255,g_pmdb_d[l_ac].pmdb256,g_pmdb_d[l_ac].pmdb257,g_pmdb_d[l_ac].pmdb259
                  
                  #入庫在途量計算
                  CALL s_apmt840_sum_in_way(g_pmdb_d[l_ac].pmdbsite,g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb005)
                     RETURNING g_pmdb_d[l_ac].pmdb253
                  #150413-00018#1 20150414 pomelo add(E)
                  
                  #151113-00003#11 By 151130 By pomelo add(S)
                  IF g_pmdb_d_o.pmdbsite = g_pmdb_d_o.pmdb037 OR cl_null(g_pmdb_d_o.pmdb037) THEN
                     LET g_pmdb_d[l_ac].pmdb037 = g_pmdb_d[l_ac].pmdbsite
                     CALL s_desc_get_department_desc(g_pmdb_d[l_ac].pmdb037) RETURNING g_pmdb_d[l_ac].pmdb037_desc
                     LET g_pmdb_d_o.pmdb037 = g_pmdb_d[l_ac].pmdb037
                  END IF
                  #151113-00003#11 By 151130 By pomelo add(E)
               END IF               
            END IF 
            #170116-00018#1 -s 20170116 add by 08172
            IF cl_null(g_pmda_m.pmda206) THEN
               IF cl_null(g_pmdb_d_o.pmdbsite) OR (NOT cl_null(g_pmdb_d_o.pmdbsite) AND g_pmdb_d[l_ac].pmdbsite <> g_pmdb_d_o.pmdbsite )THEN
                  CALL apmt830_get_inaa001(g_pmdb_d[l_ac].pmdb203,g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdbsite)         
                            RETURNING g_pmdb_d[l_ac].pmdb204
                  #取單身配送倉的說明
                  CALL s_desc_get_stock_desc(g_pmdb_d[l_ac].pmdb203,g_pmdb_d[l_ac].pmdb204) 
                     RETURNING  g_pmdb_d[l_ac].pmdb204_desc                             
               END IF
            END IF
            #170116-00018#1 -e 20170116 add by 08172            
            LET g_pmdb_d_o.pmdbsite = g_pmdb_d[l_ac].pmdbsite
            #150427-00012#5 150603 s983961---add(s)
            LET g_pmdb_d_o.pmdb258  = g_pmdb_d[l_ac].pmdb258    
            LET g_pmdb_d_o.pmdb253  = g_pmdb_d[l_ac].pmdb253
            LET g_pmdb_d_o.pmdb254  = g_pmdb_d[l_ac].pmdb254
            LET g_pmdb_d_o.pmdb255  = g_pmdb_d[l_ac].pmdb255
            LET g_pmdb_d_o.pmdb256  = g_pmdb_d[l_ac].pmdb256
            LET g_pmdb_d_o.pmdb257  = g_pmdb_d[l_ac].pmdb257
            LET g_pmdb_d_o.pmdb259  = g_pmdb_d[l_ac].pmdb259   
            #150427-00012#5 150603 s983961---add(e) 
            CALL s_desc_get_department_desc(g_pmdb_d[l_ac].pmdbsite) RETURNING g_pmdb_d[l_ac].pmdbsite_desc          
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdbsite
            #add-point:BEFORE FIELD pmdbsite name="input.b.page1.pmdbsite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdbsite
            #add-point:ON CHANGE pmdbsite name="input.g.page1.pmdbsite"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb200
            
            #add-point:AFTER FIELD pmdb200 name="input.a.page1.pmdb200"
           IF NOT cl_null(g_pmdb_d[l_ac].pmdb200) THEN
              #IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_pmdb_d[l_ac].pmdb200 != g_pmdb_d_o.pmdb200 OR g_pmdb_d_o.pmdb200 IS NULL )) THEN  #150427-00012#5 150529 s983961---mark  
               IF g_pmdb_d[l_ac].pmdb200 != g_pmdb_d_o.pmdb200 OR cl_null(g_pmdb_d_o.pmdb200)  THEN   #150427-00012#5 150529 s983961---add             
                 INITIALIZE g_chkparam.* TO NULL
                 LET g_errshow = '1'
                 LET g_chkparam.arg1 = g_pmdb_d[l_ac].pmdb200
                 IF NOT cl_chk_exist("v_imay003_1") THEN  #條碼校驗  原不排除非主條碼
                 #IF NOT cl_chk_exist("v_imay003") THEN
                    LET g_pmdb_d[l_ac].pmdb200 = g_pmdb_d_o.pmdb200         
                    NEXT FIELD pmdb200 
                 ELSE   
                    SELECT  imay001 INTO  g_pmdb_d[l_ac].pmdb004 FROM imay_t
                     WHERE  imayent = g_enterprise AND imay003 =  g_pmdb_d[l_ac].pmdb200                  
                    IF NOT apmt830_pmdb004_chk() THEN
                       LET g_pmdb_d[l_ac].pmdb200 = g_pmdb_d_o.pmdb200
                       LET g_pmdb_d[l_ac].pmdb004 = g_pmdb_d_o.pmdb004   
                       NEXT FIELD pmdb200 
                    END IF                     
                 END IF 
                 
                 #商品生命周期的判断  2015/03/19  geza
                 #CALL s_life_cycle_chk(g_prog,g_pmda_m.pmdasite,'1',g_pmdb_d[l_ac].pmdb004) RETURNING r_success   #150616-00035#78-mark by dongsz
                 CALL s_life_cycle_chk(g_prog,g_pmda_m.pmdasite,'1',g_pmdb_d[l_ac].pmdb004,'','') RETURNING r_success   #150616-00035#78-add by dongsz
                 IF r_success = FALSE THEN 
                    LET g_pmdb_d[l_ac].pmdb200 = g_pmdb_d_o.pmdb200
                    LET g_pmdb_d[l_ac].pmdb004 = g_pmdb_d_o.pmdb004
                             
                    NEXT FIELD CURRENT
                 END IF                      
                 
                 #可用庫存量
                 #CALL s_apmt840_sum_inag008(g_pmdb_d[l_ac].pmdbsite,g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb005) #150401-00005#3 sakura add pmdb005
                 #   RETURNING g_pmdb_d[l_ac].pmdb252  #mark by geza 201611206 161124-00039#1
                 #add by geza 201611206 161124-00039#1(S)
                 CALL apmt830_sum_inag009(g_pmdb_d[l_ac].pmdbsite,g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb005)  
                    RETURNING g_pmdb_d[l_ac].pmdb252
                 #add by geza 201611206 161124-00039#1(E)
                 #入庫在途量計算
                 #CALL s_apmt840_sum_in_way(g_pmdb_d[l_ac].pmdbsite,g_pmdb_d[l_ac].pmdb200)                        #150413-00018#1 sakura mark
                 CALL s_apmt840_sum_in_way(g_pmdb_d[l_ac].pmdbsite,g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb005)  #150413-00018#1 sakura add
                    RETURNING g_pmdb_d[l_ac].pmdb253
                                 
                 #要貨在途量計算
                 CALL s_apmt830_sum_pmdb258(g_pmdb_d[l_ac].pmdbsite,g_pmdb_d[l_ac].pmdb004,' ')
                    RETURNING g_pmdb_d[l_ac].pmdb258  
                    
                 #前一、二、三、四週銷量及週平均銷量計算
                 CALL apmt830_daily_sale_all(g_pmdb_d[l_ac].pmdbsite,g_pmda_m.pmdadocdt,g_pmdb_d[l_ac].pmdb004,' ')
                    RETURNING g_pmdb_d[l_ac].pmdb254,g_pmdb_d[l_ac].pmdb255,g_pmdb_d[l_ac].pmdb256,g_pmdb_d[l_ac].pmdb257,g_pmdb_d[l_ac].pmdb259      
                                  
                 #取得商品編號相關資訊
                 CALL apmt830_pmdb004_other()
              END IF
              #170116-00018#1 -s 20170116 add by 08172
              IF cl_null(g_pmda_m.pmda206) THEN
                 IF cl_null(g_pmdb_d_o.pmdb004) OR (g_pmdb_d[l_ac].pmdb004 <> g_pmdb_d_o.pmdb004 AND NOT cl_null(g_pmdb_d_o.pmdb004)) THEN
                    CALL apmt830_get_inaa001(g_pmdb_d[l_ac].pmdb203,g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdbsite)         
                              RETURNING g_pmdb_d[l_ac].pmdb204 
                    #取單身配送倉的說明
                    CALL s_desc_get_stock_desc(g_pmdb_d[l_ac].pmdb203,g_pmdb_d[l_ac].pmdb204) 
                       RETURNING  g_pmdb_d[l_ac].pmdb204_desc  
                 END IF
              END IF
              #170116-00018#1 -e 20170116 add by 08172
            END IF
               LET g_pmdb_d_o.pmdb200 = g_pmdb_d[l_ac].pmdb200
               LET g_pmdb_d_o.pmdb004 = g_pmdb_d[l_ac].pmdb004
               #150427-00012#5 15/06/03 s983961---add(s) 
               LET g_pmdb_d_o.pmdb258  = g_pmdb_d[l_ac].pmdb258   
               LET g_pmdb_d_o.pmdb252  = g_pmdb_d[l_ac].pmdb252
               LET g_pmdb_d_o.pmdb253  = g_pmdb_d[l_ac].pmdb253
               LET g_pmdb_d_o.pmdb254  = g_pmdb_d[l_ac].pmdb254
               LET g_pmdb_d_o.pmdb255  = g_pmdb_d[l_ac].pmdb255
               LET g_pmdb_d_o.pmdb256  = g_pmdb_d[l_ac].pmdb256
               LET g_pmdb_d_o.pmdb257  = g_pmdb_d[l_ac].pmdb257
               LET g_pmdb_d_o.pmdb259  = g_pmdb_d[l_ac].pmdb259  
               #150427-00012#5 15/06/03 s983961---add(e)                
            CALL s_desc_get_item_desc(g_pmdb_d[l_ac].pmdb004) 
               RETURNING g_pmdb_d[l_ac].pmdb004_desc,g_pmdb_d[l_ac].pmdb004_desc_desc 
            #161017-00029#1 16/10/18 by 08742 -S
            SELECT imay019 INTO  g_pmdb_d[l_ac].pmdb005
              FROM imay_t
             WHERE imayent = g_enterprise
               AND imay003 = g_pmdb_d[l_ac].pmdb200
            CALL s_feature_description(g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb005)
               RETURNING l_success,g_pmdb_d[l_ac].pmdb005_desc
            #161017-00029#1 16/10/18 by 08742 -E
            #170116-00018#1 -s mark by 08172
            #add by geza 20161029 #161027-00055#2(S)
#            IF g_pmdb_d[l_ac].pmdb004 IS NOT NULL AND g_pmdb_d[l_ac].pmdb005 IS NOT NULL AND g_pmdb_d[l_ac].pmdb203 IS NOT NULL THEN
#               #CALL apmt830_pmdb215_count(g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb203,g_pmdb_d[l_ac].pmdb005) RETURNING g_pmdb_d[l_ac].l_pmdb252 #mark by geza 20161209 161124-00039#1
#               CALL apmt830_pmdb215_count(g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb203,g_pmdb_d[l_ac].pmdb005,'',g_pmdb_d[l_ac].pmdbsite) RETURNING g_pmdb_d[l_ac].l_pmdb252 #add by geza 20161209 161124-00039#1
#            ELSE
#               LET g_pmdb_d[l_ac].l_pmdb252 = 0           
#            END IF   
            #add by geza 20161029 #161027-00055#2(E) 
            #170116-00018#1 -e mark by 08172
            #170116-00018#1 -s add by 08172
            IF g_pmdb_d[l_ac].pmdb004 IS NOT NULL AND g_pmdb_d[l_ac].pmdb005 IS NOT NULL AND  g_pmdb_d[l_ac].pmdb007 IS NOT NULL
               AND g_pmdb_d[l_ac].pmdb203 IS NOT NULL AND g_pmdb_d[l_ac].pmdb204 IS NOT NULL THEN
               CALL apmt830_inas011_count(g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb005,g_pmdb_d[l_ac].pmdb007,g_pmdb_d[l_ac].pmdb203,g_pmdb_d[l_ac].pmdb204)   
                    RETURNING g_pmdb_d[l_ac].l_pmdb252               
            ELSE 
               LET g_pmdb_d[l_ac].l_pmdb252 = ''
            END IF
            #170116-00018#1 -e add by 08172
            #161214-00004#3 161221 by sunxh(S)
            CALL apmt830_get_imaa(g_pmdb_d[l_ac].pmdb004)
            RETURNING g_pmdb_d[l_ac].imaa154,g_pmdb_d[l_ac].imaa155,g_pmdb_d[l_ac].imaa156,g_pmdb_d[l_ac].imaa132,g_pmdb_d[l_ac].rtaw001,g_pmdb_d[l_ac].imaa116
            CALL s_desc_get_rtaxl003_desc(g_pmdb_d[l_ac].rtaw001) RETURNING g_pmdb_d[l_ac].imaa128_desc
            CALL s_desc_get_acc_desc('2006',g_pmdb_d[l_ac].imaa132) RETURNING g_pmdb_d[l_ac].imaa132_desc
            #161214-00004#3 161221 by sunxh(E)
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb200
            #add-point:BEFORE FIELD pmdb200 name="input.b.page1.pmdb200"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdb200
            #add-point:ON CHANGE pmdb200 name="input.g.page1.pmdb200"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb004
            
            #add-point:AFTER FIELD pmdb004 name="input.a.page1.pmdb004"
            LET g_pmdb_d[l_ac].pmdb004_desc= '' #品名
            LET g_pmdb_d[l_ac].pmdb004_desc_desc  = ''    #規格
            IF NOT cl_null(g_pmdb_d[l_ac].pmdb004) THEN 
              #IF (g_pmdb_d[l_ac].pmdb004 != g_pmdb_d_o.pmdb004 OR g_pmdb_d_o.pmdb004 IS NULL ) THEN   #150603 s983961---mark                                                                                                               
              IF g_pmdb_d[l_ac].pmdb004 != g_pmdb_d_o.pmdb004 OR cl_null(g_pmdb_d_o.pmdb004) THEN   #150603 s983961---add
                IF g_pmda_m.pmda201 = '' THEN
                    LET g_pmdb_d[l_ac].pmdb207 = ''
                 ELSE
                    CALL apmt830_get_rtdx027(g_pmdb_d[l_ac].pmdbsite,g_pmdb_d[l_ac].pmdb004) 
                       RETURNING g_pmdb_d[l_ac].pmdb207                       
                 END IF         
                 
                 
                 
                 
                 IF NOT apmt830_pmdb004_chk() THEN  
                    LET g_pmdb_d[l_ac].pmdb004 = g_pmdb_d_o.pmdb004
  
                    #品名、規格
                    CALL s_desc_get_item_desc(g_pmdb_d[l_ac].pmdb004) 
                       RETURNING g_pmdb_d[l_ac].pmdb004_desc,g_pmdb_d[l_ac].pmdb004_desc_desc 
                    NEXT FIELD pmdb004
                    
                 #150519-00029# Mark By Ken 150521  只要有進商品校驗一律重新抓主條碼
                 ELSE
                    CALL apmt830_get_pmdb200(g_pmdb_d[l_ac].pmdb004) 
                       RETURNING g_pmdb_d[l_ac].pmdb200
                       #161017-00029#1 16/10/20 by 08742 -S
                       #IF l_cmd='u' THEN
                       IF NOT cl_null(g_pmdb_d[l_ac].pmdb005) THEN
                       LET g_pmdb_d[l_ac].pmdb005 = ' '
                          SELECT imay019 INTO  g_pmdb_d[l_ac].pmdb005
                            FROM imay_t
                           WHERE imayent = g_enterprise
                             AND imay003 = g_pmdb_d[l_ac].pmdb200                       
                          CALL s_feature_description(g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb005)
                             RETURNING l_success,g_pmdb_d[l_ac].pmdb005_desc
                       END IF 
                       #161017-00029#1 16/10/20 by 08742 -E
                       
                 #150519-00029# Mark By Ken 150521
                 END IF
                 
                 
                 #商品生命周期的判断  2015/03/19  geza
                 #CALL s_life_cycle_chk(g_prog,g_pmda_m.pmdasite,'1',g_pmdb_d[l_ac].pmdb004) RETURNING r_success   #150616-00035#78-mark by dongsz
                 CALL s_life_cycle_chk(g_prog,g_pmda_m.pmdasite,'1',g_pmdb_d[l_ac].pmdb004,'','') RETURNING r_success   #150616-00035#78-add by dongsz
                 IF r_success = FALSE THEN 
                    LET g_pmdb_d[l_ac].pmdb004 = g_pmdb_d_o.pmdb004
         
                    #品名、規格
                    CALL s_desc_get_item_desc(g_pmdb_d[l_ac].pmdb004) 
                       RETURNING g_pmdb_d[l_ac].pmdb004_desc,g_pmdb_d[l_ac].pmdb004_desc_desc                      
                    NEXT FIELD CURRENT
                 END IF                   
 
                 #可用庫存量
                 #CALL s_apmt840_sum_inag008(g_pmdb_d[l_ac].pmdbsite,g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb005) #150401-00005#3 sakura add pmdb005
                 #   RETURNING g_pmdb_d[l_ac].pmdb252  #mark by geza 201611206 161124-00039#1 
                 
                 #add by geza 201611206 161124-00039#1(S)
                 CALL apmt830_sum_inag009(g_pmdb_d[l_ac].pmdbsite,g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb005)  
                    RETURNING g_pmdb_d[l_ac].pmdb252
                 #add by geza 201611206 161124-00039#1(E)
                 
                 #入庫在途量計算
                 #CALL s_apmt840_sum_in_way(g_pmdb_d[l_ac].pmdbsite,g_pmdb_d[l_ac].pmdb200)                       #150413-00018#1 sakura mark
                 CALL s_apmt840_sum_in_way(g_pmdb_d[l_ac].pmdbsite,g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb005) #150413-00018#1 sakura add
                    RETURNING g_pmdb_d[l_ac].pmdb253
                                 
                 #要貨在途量計算
                 CALL s_apmt830_sum_pmdb258(g_pmdb_d[l_ac].pmdbsite,g_pmdb_d[l_ac].pmdb004,' ')
                    RETURNING g_pmdb_d[l_ac].pmdb258  
                    
                 #前一、二、三、四週銷量及週平均銷量計算
                 CALL apmt830_daily_sale_all(g_pmdb_d[l_ac].pmdbsite,g_pmda_m.pmdadocdt,g_pmdb_d[l_ac].pmdb004,' ')
                    RETURNING g_pmdb_d[l_ac].pmdb254,g_pmdb_d[l_ac].pmdb255,g_pmdb_d[l_ac].pmdb256,g_pmdb_d[l_ac].pmdb257,g_pmdb_d[l_ac].pmdb259      
                 
                 #取得商品編號相關資訊
                 ##150521-00015#2 15/05/28 s983961---add(s) 帶補貨規格級別為S-CIR-1001的條碼
                 #CALL cl_get_para(g_enterprise,g_pmdb_d[l_ac].pmdbsite,'S-CIR-1001') RETURNING l_sys2
                 #SELECT imaz003 INTO l_imaz003 
                 #  FROM imaz_t
                 # WHERE imazent = g_enterprise 
                 #   AND imaz001 =  g_pmdb_d[l_ac].pmdb004
                 #   AND imaz002 = l_sys2   
                 #IF NOT cl_null(l_imaz003) THEN               #06/08 先判斷是否有 補貨規格級別 條碼                 
                 #  LET g_pmdb_d[l_ac].pmdb200 = l_imaz003     #06/08 有抓到再更新 g_pmdb_d[l_ac].pmdb200
                 #END IF
                 ##150521-00015#2 15/05/28 s983961---add(e)
                 CALL apmt830_pmdb004_other()                 
              END IF             
            END IF
            #170116-00018#1 -s 20170116 add by 08172
            IF cl_null(g_pmda_m.pmda206) THEN
               IF cl_null(g_pmdb_d_o.pmdb004) OR (g_pmdb_d[l_ac].pmdb004 <> g_pmdb_d_o.pmdb004 AND NOT cl_null(g_pmdb_d_o.pmdb004)) THEN
                  CALL apmt830_get_inaa001(g_pmdb_d[l_ac].pmdb203,g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdbsite)         
                            RETURNING g_pmdb_d[l_ac].pmdb204 
                  #取單身配送倉的說明
                  CALL s_desc_get_stock_desc(g_pmdb_d[l_ac].pmdb203,g_pmdb_d[l_ac].pmdb204) 
                     RETURNING  g_pmdb_d[l_ac].pmdb204_desc  
               END IF
            END IF
            #170116-00018#1 -e 20170116 add by 08172            
            LET g_pmdb_d_o.pmdb200 = g_pmdb_d[l_ac].pmdb200
            LET g_pmdb_d_o.pmdb004 = g_pmdb_d[l_ac].pmdb004 
            #150427-00012#5 15/06/03 s983961---add(s)
            LET g_pmdb_d_o.pmdb207 = g_pmdb_d[l_ac].pmdb207    
            LET g_pmdb_d_o.pmdb258 = g_pmdb_d[l_ac].pmdb258   
            LET g_pmdb_d_o.pmdb252 = g_pmdb_d[l_ac].pmdb252
            LET g_pmdb_d_o.pmdb253 = g_pmdb_d[l_ac].pmdb253
            LET g_pmdb_d_o.pmdb254 = g_pmdb_d[l_ac].pmdb254
            LET g_pmdb_d_o.pmdb255 = g_pmdb_d[l_ac].pmdb255
            LET g_pmdb_d_o.pmdb256 = g_pmdb_d[l_ac].pmdb256
            LET g_pmdb_d_o.pmdb257 = g_pmdb_d[l_ac].pmdb257
            LET g_pmdb_d_o.pmdb259 = g_pmdb_d[l_ac].pmdb259    
            #150427-00012#5 15/06/03 s983961---add(e)                   
             
            #品名、規格
            CALL s_desc_get_item_desc(g_pmdb_d[l_ac].pmdb004) 
               RETURNING g_pmdb_d[l_ac].pmdb004_desc,g_pmdb_d[l_ac].pmdb004_desc_desc 
            CALL apmt830_set_entry_b(l_cmd)
            #add-S By Ken 150318
            CALL apmt830_set_no_required_b(l_cmd)
            CALL apmt830_set_required_b(l_cmd)
            #add-E
            CALL apmt830_set_no_entry_b(l_cmd)  
            #170116-00018#1 -s mark by 08172
            #add by geza 20161029 #161027-00055#2(S)
#            IF g_pmdb_d[l_ac].pmdb004 IS NOT NULL AND g_pmdb_d[l_ac].pmdb005 IS NOT NULL AND g_pmdb_d[l_ac].pmdb203 IS NOT NULL THEN
#               #CALL apmt830_pmdb215_count(g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb203,g_pmdb_d[l_ac].pmdb005) RETURNING g_pmdb_d[l_ac].l_pmdb252 #mark by geza 20161209 161124-00039#1
#               CALL apmt830_pmdb215_count(g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb203,g_pmdb_d[l_ac].pmdb005,'',g_pmdb_d[l_ac].pmdbsite) RETURNING g_pmdb_d[l_ac].l_pmdb252 #add by geza 20161209 161124-00039#1
#            ELSE
#               LET g_pmdb_d[l_ac].l_pmdb252 = 0           
#            END IF   
            #add by geza 20161029 #161027-00055#2(E)
            #170116-00018#1 -e mark by 08172
            #170116-00018#1 -s add by 08172
            IF g_pmdb_d[l_ac].pmdb004 IS NOT NULL AND g_pmdb_d[l_ac].pmdb005 IS NOT NULL AND  g_pmdb_d[l_ac].pmdb007 IS NOT NULL
               AND g_pmdb_d[l_ac].pmdb203 IS NOT NULL AND g_pmdb_d[l_ac].pmdb204 IS NOT NULL THEN
               CALL apmt830_inas011_count(g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb005,g_pmdb_d[l_ac].pmdb007,g_pmdb_d[l_ac].pmdb203,g_pmdb_d[l_ac].pmdb204)   
                    RETURNING g_pmdb_d[l_ac].l_pmdb252               
            ELSE 
               LET g_pmdb_d[l_ac].l_pmdb252 = ''
            END IF
            #170116-00018#1 -e add by 08172
           #add by guomy 2015/11/4根据要货组织+商品编号+单据日期取门店商品清单151104-00005#1
           # 若单据日期在促销进价开始日期（rtdx041）和促销结束日期(rtdx042)内，
           # 则取促销进价（rtdx032），反之取最新进价(rtdx034) 
           IF NOT cl_null(g_pmdb_d[l_ac].pmdb004) THEN
               LET l_cnt = 0 
              SELECT count(*) INTO l_cnt
                FROM rtdx_t
               WHERE rtdxent = g_enterprise 
                 AND rtdxsite = g_pmda_m.pmdasite
                 AND rtdx001 = g_pmdb_d[l_ac].pmdb004
                 AND g_pmda_m.pmdadocdt BETWEEN rtdx041 AND rtdx042 
                 
              IF l_cnt = 0  THEN
                 SELECT rtdx034 INTO g_pmdb_d[l_ac].pmdb213
                   FROM rtdx_t
                  WHERE rtdxent = g_enterprise 
                    AND rtdxsite = g_pmda_m.pmdasite
                    AND rtdx001 = g_pmdb_d[l_ac].pmdb004 
              ELSE
                 SELECT rtdx032 INTO g_pmdb_d[l_ac].pmdb213
                   FROM rtdx_t
                  WHERE rtdxent = g_enterprise 
                    AND rtdxsite = g_pmda_m.pmdasite
                    AND rtdx001 = g_pmdb_d[l_ac].pmdb004                            
              END IF 
                                  
              DISPLAY BY NAME g_pmdb_d[l_ac].pmdb213
           END IF 
           #add by guomy ===end  ------------------------
           #161214-00004#3 add by sunxh 161221(S)
           CALL apmt830_get_imaa(g_pmdb_d[l_ac].pmdb004)
           RETURNING g_pmdb_d[l_ac].imaa154,g_pmdb_d[l_ac].imaa155,g_pmdb_d[l_ac].imaa156,g_pmdb_d[l_ac].imaa132,g_pmdb_d[l_ac].rtaw001,g_pmdb_d[l_ac].imaa116
           CALL s_desc_get_rtaxl003_desc(g_pmdb_d[l_ac].rtaw001) RETURNING g_pmdb_d[l_ac].imaa128_desc
           CALL s_desc_get_acc_desc('2006',g_pmdb_d[l_ac].imaa132) RETURNING g_pmdb_d[l_ac].imaa132_desc
           #161214-00004#3 add by sunxh 161221(E)
           
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
            #ken---add---s 產品特徵
            LET g_pmdb_d[l_ac].pmdb005_desc = ''           
            IF NOT cl_null(g_pmdb_d[l_ac].pmdb005) THEN 
               IF g_pmdb_d[l_ac].pmdb005 != g_pmdb_d_o.pmdb005 OR g_pmdb_d_o.pmdb005 IS NULL THEN 
                  IF NOT s_feature_check(g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb005) THEN
                     LET g_pmdb_d[l_ac].pmdb005 = g_pmdb_d_o.pmdb005
                     LET g_pmdb_d[l_ac].pmdb006 = g_pmdb_d_o.pmdb006   #150427-00012#5 150604 s983961---add(s) 
                     CALL s_feature_description(g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb005) 
                        RETURNING l_success,g_pmdb_d[l_ac].pmdb005_desc
                     NEXT FIELD CURRENT
                  END IF
                  #151224-00025#3 add start ------------------------
                  IF NOT s_feature_direct_input(g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb005,g_pmdb_d_o.pmdb005,g_pmda_m.pmdadocno,g_pmda_m.pmdasite) THEN
                     NEXT FIELD CURRENT
                  END IF
                  #151224-00025#3 add end   ------------------------
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
                  LET g_pmdb_d[l_ac].pmdb005 = ' '
               END IF
            END IF
         
            #要貨在途量計算
            CALL s_apmt830_sum_pmdb258(g_pmdb_d[l_ac].pmdbsite,g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb005)
               RETURNING g_pmdb_d[l_ac].pmdb258  
            
            #前一、二、三、四週銷量及週平均銷量計算
            CALL apmt830_daily_sale_all(g_pmdb_d[l_ac].pmdbsite,g_pmda_m.pmdadocdt,g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb005)
               RETURNING g_pmdb_d[l_ac].pmdb254,g_pmdb_d[l_ac].pmdb255,g_pmdb_d[l_ac].pmdb256,g_pmdb_d[l_ac].pmdb257,g_pmdb_d[l_ac].pmdb259
            
            #可用庫存量
            #CALL s_apmt840_sum_inag008(g_pmdb_d[l_ac].pmdbsite,g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb005) #150401-00005#3 sakura add pmdb005
            #   RETURNING g_pmdb_d[l_ac].pmdb252    #mark by geza 201611206 161124-00039#1
            #add by geza 201611206 161124-00039#1(S)
            CALL apmt830_sum_inag009(g_pmdb_d[l_ac].pmdbsite,g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb005)  
               RETURNING g_pmdb_d[l_ac].pmdb252
            #add by geza 201611206 161124-00039#1(E)     
           #150413-00018#1 20150414 pomelo add(S)
           #入庫在途量計算
           CALL s_apmt840_sum_in_way(g_pmdb_d[l_ac].pmdbsite,g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb005)
              RETURNING g_pmdb_d[l_ac].pmdb253
           #150413-00018#1 20150414 pomelo add(E)
           
            ##現有庫存計算
            #CALL s_inventory_get_inag008_2(g_pmdb_d[l_ac].pmdbsite,g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb005,'','','','',g_pmdb_d[l_ac].pmdb007)
            #   RETURNING l_success,g_pmdb_d[l_ac].pmdb252
            #IF NOT l_success THEN
            #   NEXT FIELD pmdb005
            #END IF

            LET g_pmdb_d_o.pmdb005 = g_pmdb_d[l_ac].pmdb005
            #150427-00012#5 15/06/04 s983961---add(s) 
            LET g_pmdb_d_o.pmdb006 = g_pmdb_d[l_ac].pmdb006   
            LET g_pmdb_d_o.pmdb258 = g_pmdb_d[l_ac].pmdb258   
            LET g_pmdb_d_o.pmdb252 = g_pmdb_d[l_ac].pmdb252
            LET g_pmdb_d_o.pmdb253 = g_pmdb_d[l_ac].pmdb253
            LET g_pmdb_d_o.pmdb254 = g_pmdb_d[l_ac].pmdb254
            LET g_pmdb_d_o.pmdb255 = g_pmdb_d[l_ac].pmdb255
            LET g_pmdb_d_o.pmdb256 = g_pmdb_d[l_ac].pmdb256
            LET g_pmdb_d_o.pmdb257 = g_pmdb_d[l_ac].pmdb257
            LET g_pmdb_d_o.pmdb259 = g_pmdb_d[l_ac].pmdb259   
            #150427-00012#5 15/06/04 s983961---add(e) 
            CALL s_feature_description(g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb005) 
               RETURNING l_success,g_pmdb_d[l_ac].pmdb005_desc          
            #ken---add---e
            
            #161228-00033#3 by sakura mark(S)
            #161017-00029#1 16/10/18 by 08742 -S
            #SELECT imay003 INTO  g_pmdb_d[l_ac].pmdb200
            #  FROM imay_t
            # WHERE imayent = g_enterprise
            #   AND imay019 = g_pmdb_d[l_ac].pmdb005
            #   AND imay001 = g_pmdb_d[l_ac].pmdb004
            #   AND ROWNUM = 1
            #IF sqlca.sqlcode = 100 THEN
            #   SELECT imay003 INTO  g_pmdb_d[l_ac].pmdb200
            #    FROM imay_t
            #   WHERE imayent = g_enterprise
            #     AND imay006='Y'
            #     AND imay001 = g_pmdb_d[l_ac].pmdb004
            #END IF
            #CALL s_feature_description(g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb005)
            #   RETURNING l_success,g_pmdb_d[l_ac].pmdb005_desc
            #161017-00029#1 16/10/18 by 08742 -E
            #161228-00033#3 by sakura mark(E)
            
            #161228-00033#3 by sakura add(S)
            LET g_pmdb_d[l_ac].pmdb200 = ''
            LET g_sql = "SELECT imay003 ",
                        "  FROM imay_t ",
                        " WHERE imayent = ",g_enterprise,
                        "   AND imay019 = '",g_pmdb_d[l_ac].pmdb005,"'",
                        "   AND imay001 = '",g_pmdb_d[l_ac].pmdb004,"'"
            PREPARE apmt830_sel_imay003_pre1 FROM g_sql
            DECLARE apmt830_sel_imay003_cur1 SCROLL CURSOR FOR apmt830_sel_imay003_pre1   
            OPEN apmt830_sel_imay003_cur1
            FETCH FIRST apmt830_sel_imay003_cur1 INTO g_pmdb_d[l_ac].pmdb200
            CLOSE apmt830_sel_imay003_cur1               
            FREE  apmt830_sel_imay003_pre1
            
            IF cl_null(g_pmdb_d[l_ac].pmdb200) THEN
               LET g_pmdb_d[l_ac].pmdb200 = ''
               SELECT imay003 INTO  g_pmdb_d[l_ac].pmdb200
                FROM imay_t
               WHERE imayent = g_enterprise
                 AND imay006='Y'
                 AND imay001 = g_pmdb_d[l_ac].pmdb004
            END IF
            
            CALL s_feature_description(g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb005)
               RETURNING l_success,g_pmdb_d[l_ac].pmdb005_desc            
            #161228-00033#3 by sakura add(E)
            
            #170116-00018#1 -s mark by 08172
            #add by geza 20161029 #161027-00055#2(S)
#            IF g_pmdb_d[l_ac].pmdb004 IS NOT NULL AND g_pmdb_d[l_ac].pmdb005 IS NOT NULL AND g_pmdb_d[l_ac].pmdb203 IS NOT NULL THEN
#               #CALL apmt830_pmdb215_count(g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb203,g_pmdb_d[l_ac].pmdb005) RETURNING g_pmdb_d[l_ac].l_pmdb252 #mark by geza 20161209 161124-00039#1
#               CALL apmt830_pmdb215_count(g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb203,g_pmdb_d[l_ac].pmdb005,'',g_pmdb_d[l_ac].pmdbsite) RETURNING g_pmdb_d[l_ac].l_pmdb252 #add by geza 20161209 161124-00039#1
#            ELSE
#               LET g_pmdb_d[l_ac].l_pmdb252 = 0           
#            END IF   
            #add by geza 20161029 #161027-00055#2(E)
            #170116-00018#1 -e mark by 08172
            #170116-00018#1 -s add by 08172
            IF g_pmdb_d[l_ac].pmdb004 IS NOT NULL AND g_pmdb_d[l_ac].pmdb005 IS NOT NULL AND  g_pmdb_d[l_ac].pmdb007 IS NOT NULL
               AND g_pmdb_d[l_ac].pmdb203 IS NOT NULL AND g_pmdb_d[l_ac].pmdb204 IS NOT NULL THEN
               CALL apmt830_inas011_count(g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb005,g_pmdb_d[l_ac].pmdb007,g_pmdb_d[l_ac].pmdb203,g_pmdb_d[l_ac].pmdb204)   
                    RETURNING g_pmdb_d[l_ac].l_pmdb252               
            ELSE 
               LET g_pmdb_d[l_ac].l_pmdb252 = ''
            END IF
            #170116-00018#1 -e add by 08172
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb005
            #add-point:BEFORE FIELD pmdb005 name="input.b.page1.pmdb005"
            #160314-00009#4   marked by zhujing 2016-3-16----(S)
            #ken---add---s 產品特徵
#            LET l_imaa005 = ''
#            CALL apmt830_get_imaa005(g_pmdb_d[l_ac].pmdb004) RETURNING l_imaa005
            #160314-00009#4   marked by zhujing 2016-3-16----(E)  
            #使用產品特徵 
            IF cl_get_para(g_enterprise,g_pmdb_d[l_ac].pmdbsite,'S-BAS-0036') = 'Y' THEN 
#               IF NOT cl_null(l_imaa005) THEN      #160314-00009#4   marked by zhujing 2016-3-16
               IF s_feature_auto_chk(g_pmdb_d[l_ac].pmdb004) AND cl_null(g_pmdb_d[l_ac].pmdb005) THEN    #160314-00009#4   mod by zhujing 2016-3-16
                  CALL l_inam.clear()            
                  CALL s_feature(l_cmd,g_pmdb_d[l_ac].pmdb004,'','',g_pmdb_d[l_ac].pmdbsite,g_pmda_m.pmdadocno) RETURNING l_success,l_inam
                  LET g_pmdb_d[l_ac].pmdb005 = l_inam[1].inam002
                  LET g_pmdb_d[l_ac].pmdb006 = l_inam[1].inam004
                  #單位間的轉換數量
                  CALL apmt830_num_change()  
                  
                  #150413-00018#1 20150414 pomelo add(S)
                  #要貨在途量計算
                  CALL s_apmt830_sum_pmdb258(g_pmdb_d[l_ac].pmdbsite,g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb005)
                     RETURNING g_pmdb_d[l_ac].pmdb258
                  
                  #前一、二、三、四週銷量及週平均銷量計算
                  CALL apmt830_daily_sale_all(g_pmdb_d[l_ac].pmdbsite,g_pmda_m.pmdadocdt,g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb005)
                     RETURNING g_pmdb_d[l_ac].pmdb254,g_pmdb_d[l_ac].pmdb255,g_pmdb_d[l_ac].pmdb256,g_pmdb_d[l_ac].pmdb257,g_pmdb_d[l_ac].pmdb259
                  
                  #入庫在途量計算
                  CALL s_apmt840_sum_in_way(g_pmdb_d[l_ac].pmdbsite,g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb005)
                     RETURNING g_pmdb_d[l_ac].pmdb253
                  #150413-00018#1 20150414 pomelo add(E)
               END IF
            END IF            
            #ken---add---e
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdb005
            #add-point:ON CHANGE pmdb005 name="input.g.page1.pmdb005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb005_desc
            #add-point:BEFORE FIELD pmdb005_desc name="input.b.page1.pmdb005_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb005_desc
            
            #add-point:AFTER FIELD pmdb005_desc name="input.a.page1.pmdb005_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdb005_desc
            #add-point:ON CHANGE pmdb005_desc name="input.g.page1.pmdb005_desc"
            
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
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa155
            #add-point:BEFORE FIELD imaa155 name="input.b.page1.imaa155"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa155
            
            #add-point:AFTER FIELD imaa155 name="input.a.page1.imaa155"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa155
            #add-point:ON CHANGE imaa155 name="input.g.page1.imaa155"
            
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
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pmdb_d[l_ac].imaa132
            CALL ap_ref_array2(g_ref_fields,"SELECT oocq004 FROM oocq_t WHERE oocqent="||g_enterprise||" AND occq002=? ","") RETURNING g_rtn_fields
            LET g_pmdb_d[l_ac].imaa132_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pmdb_d[l_ac].imaa132_desc


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
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa009
            
            #add-point:AFTER FIELD imaa009 name="input.a.page1.imaa009"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pmdb_d[l_ac].imaa009
            CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_pmdb_d[l_ac].imaa009_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pmdb_d[l_ac].imaa009_desc


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
         BEFORE FIELD imaa116
            #add-point:BEFORE FIELD imaa116 name="input.b.page1.imaa116"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa116
            
            #add-point:AFTER FIELD imaa116 name="input.a.page1.imaa116"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa116
            #add-point:ON CHANGE imaa116 name="input.g.page1.imaa116"
            
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
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb037
            
            #add-point:AFTER FIELD pmdb037 name="input.a.page1.pmdb037"
            LET g_pmdb_d[l_ac].pmdb037_desc = ' '
            IF NOT cl_null(g_pmdb_d[l_ac].pmdb037) THEN 
               #IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_pmdb_d[l_ac].pmdb037 != g_pmdb_d_o.pmdb037 OR g_pmdb_d_o.pmdb037 IS NULL )) THEN   #150427-00012#5 150603 s983961---mark
                IF g_pmdb_d[l_ac].pmdb037 != g_pmdb_d_o.pmdb037 OR cl_null(g_pmdb_d_o.pmdb037) THEN   #150427-00012#5 150603 s983961---add
                  IF s_aooi500_setpoint(g_prog,'pmdb037') THEN
                     CALL s_aooi500_chk(g_prog,'pmdb037',g_pmdb_d[l_ac].pmdb037,g_pmda_m.pmdasite)
                        RETURNING l_success,l_errno
                     IF NOT l_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = ""
                        LET g_errparam.code   = l_errno
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()
                        LET g_pmdb_d[l_ac].pmdb037 = g_pmdb_d_o.pmdb037
                        CALL s_desc_get_department_desc(g_pmdb_d[l_ac].pmdb037) RETURNING g_pmdb_d[l_ac].pmdb037_desc
                        NEXT FIELD CURRENT
                     END IF
                  ELSE
                     #此段落由子樣板a19產生
                     #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                     INITIALIZE g_chkparam.* TO NULL
                     LET g_errshow = '1'
                     LET g_chkparam.arg1 = g_pmdb_d[l_ac].pmdb037
                     LET g_chkparam.arg2 = '8'
                     #LET g_chkparam.arg3 = g_site
                     LET g_chkparam.arg3 = g_pmdb_d[l_ac].pmdbsite
                     IF NOT cl_chk_exist("v_ooed004") THEN
                        LET g_pmdb_d[l_ac].pmdb037 = g_pmdb_d_o.pmdb037
                        CALL s_desc_get_department_desc(g_pmdb_d[l_ac].pmdb037) RETURNING g_pmdb_d[l_ac].pmdb037_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  #170217-00003#1 2017/02/18 By 08171 --s add
                  #當收貨組織有改變時，會帶出那個組織的預設倉庫
                  LET g_pmdb_d[l_ac].pmdb038 = s_apmt860_warehouse_default(g_pmdb_d[l_ac].pmdb037,g_pmdb_d[l_ac].pmdb004)
                  #170217-00003#1 2017/02/18 By 08171 --e add
               END IF                  
            ELSE
               LET g_pmdb_d[l_ac].pmdb038 = ''
               LET g_pmdb_d[l_ac].pmdb038_desc = ''
            END IF 
           #LET g_pmdb_d_o.pmdb037 = g_pmdb_d[l_ac].pmdb037 #170217-00003#1 2017/02/18 By 08171 mark
            LET g_pmdb_d_o.* = g_pmdb_d[l_ac].* #170217-00003#1 2017/02/18 By 08171  add
            CALL s_desc_get_department_desc(g_pmdb_d[l_ac].pmdb037) RETURNING g_pmdb_d[l_ac].pmdb037_desc            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb037
            #add-point:BEFORE FIELD pmdb037 name="input.b.page1.pmdb037"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdb037
            #add-point:ON CHANGE pmdb037 name="input.g.page1.pmdb037"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb260
            
            #add-point:AFTER FIELD pmdb260 name="input.a.page1.pmdb260"
            LET g_pmdb_d[l_ac].pmdb260_desc = ''
            IF NOT cl_null(g_pmdb_d[l_ac].pmdb260) THEN 
               #IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_pmdb_d[l_ac].pmdb260 != g_pmdb_d_o.pmdb260 OR g_pmdb_d_o.pmdb260 IS NULL )) THEN   #150427-00012#5 150529 s983961---mark 
                IF g_pmdb_d[l_ac].pmdb260 != g_pmdb_d_o.pmdb260 OR cl_null(g_pmdb_d_o.pmdb260)  THEN  #150427-00012#5 150529 s983961---add  
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_pmdb_d[l_ac].pmdb260
                  LET g_chkparam.arg2 = g_pmda_m.pmdadocdt
                  #160318-00025#21  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
                  #160318-00025#21  by 07900 --add-end 
                  IF NOT cl_chk_exist("v_ooeg001") THEN
                     LET g_pmdb_d[l_ac].pmdb260 = g_pmdb_d_o.pmdb260
                     CALL s_desc_get_department_desc(g_pmdb_d[l_ac].pmdb260) RETURNING g_pmdb_d[l_ac].pmdb260_desc
                     #檢查失敗時後續處理
                     NEXT FIELD CURRENT
                  END IF       
               END IF                  
            END IF 
            
            LET g_pmdb_d_o.pmdb260 = g_pmdb_d[l_ac].pmdb260 
            CALL s_desc_get_department_desc(g_pmdb_d[l_ac].pmdb260) RETURNING g_pmdb_d[l_ac].pmdb260_desc            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb260
            #add-point:BEFORE FIELD pmdb260 name="input.b.page1.pmdb260"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdb260
            #add-point:ON CHANGE pmdb260 name="input.g.page1.pmdb260"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb038
            
            #add-point:AFTER FIELD pmdb038 name="input.a.page1.pmdb038"
            IF NOT cl_null(g_pmdb_d[l_ac].pmdb038) THEN 
               #IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_pmdb_d[l_ac].pmdb038 != g_pmdb_d_t.pmdb038 OR g_pmdb_d_t.pmdb038 IS NULL )) THEN   #160824-00007#18 20160914 mark by beckxie
               IF g_pmdb_d[l_ac].pmdb038 != g_pmdb_d_o.pmdb038 OR g_pmdb_d_o.pmdb038 IS NULL THEN   #160824-00007#18 20160914 add by beckxie
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_pmdb_d[l_ac].pmdb037
                  LET g_chkparam.arg2 = g_pmdb_d[l_ac].pmdb038
                     
                  IF NOT cl_chk_exist("v_inaa001_1") THEN
                     #LET g_pmdb_d[l_ac].pmdb038 = g_pmdb_d_t.pmdb038   #160824-00007#18 20160914 mark by beckxie
                     LET g_pmdb_d[l_ac].pmdb038 = g_pmdb_d_o.pmdb038   #160824-00007#18 20160914 add by beckxie
                     CALL s_desc_get_stock_desc('',g_pmdb_d[l_ac].pmdb038) RETURNING  g_pmdb_d[l_ac].pmdb038_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
           #LET g_pmdb_d_o.pmdb038 = g_pmdb_d[l_ac].pmdb038    #160824-00007#18 20160914 add by beckxie #170217-00003#1 2017/02/18 By 08171 mark
            LET g_pmdb_d_o.* = g_pmdb_d[l_ac].* #170217-00003#1 2017/02/18 By 08171  add
            CALL s_desc_get_stock_desc('',g_pmdb_d[l_ac].pmdb038) RETURNING  g_pmdb_d[l_ac].pmdb038_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb038
            #add-point:BEFORE FIELD pmdb038 name="input.b.page1.pmdb038"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdb038
            #add-point:ON CHANGE pmdb038 name="input.g.page1.pmdb038"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb227
            #add-point:BEFORE FIELD pmdb227 name="input.b.page1.pmdb227"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb227
            
            #add-point:AFTER FIELD pmdb227 name="input.a.page1.pmdb227"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdb227
            #add-point:ON CHANGE pmdb227 name="input.g.page1.pmdb227"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb201
            
            #add-point:AFTER FIELD pmdb201 name="input.a.page1.pmdb201"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pmdb_d[l_ac].pmdb201
            CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_pmdb_d[l_ac].pmdb201_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pmdb_d[l_ac].pmdb201_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb201
            #add-point:BEFORE FIELD pmdb201 name="input.b.page1.pmdb201"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdb201
            #add-point:ON CHANGE pmdb201 name="input.g.page1.pmdb201"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb202
            #add-point:BEFORE FIELD pmdb202 name="input.b.page1.pmdb202"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb202
            
            #add-point:AFTER FIELD pmdb202 name="input.a.page1.pmdb202"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdb202
            #add-point:ON CHANGE pmdb202 name="input.g.page1.pmdb202"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb212
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmdb_d[l_ac].pmdb212,"0","0","","","azz-00079",1) THEN
               NEXT FIELD pmdb212
            END IF 
 
 
 
            #add-point:AFTER FIELD pmdb212 name="input.a.page1.pmdb212"
            IF NOT cl_null(g_pmdb_d[l_ac].pmdb212) THEN
               #IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_pmdb_d[l_ac].pmdb212 != g_pmdb_d_o.pmdb212 OR g_pmdb_d_o.pmdb212 IS NULL )) THEN   #150427-00012#5 150529 s983961---mark  
               IF g_pmdb_d[l_ac].pmdb212 != g_pmdb_d_o.pmdb212 OR cl_null(g_pmdb_d_o.pmdb212) THEN    #150427-00012#5 150529 s983961---add                            
                  #對要貨件數進行取位
                  CALL s_aooi250_take_decimals(g_pmdb_d[l_ac].pmdb201,g_pmdb_d[l_ac].pmdb212) 
                     RETURNING l_success,g_pmdb_d[l_ac].pmdb212
                  #換算要貨數量
                  IF NOT cl_null(g_pmdb_d[l_ac].pmdb007) THEN
                     CALL s_aooi250_convert_qty(g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb201,g_pmdb_d[l_ac].pmdb007,g_pmdb_d[l_ac].pmdb212)
                        RETURNING l_success,g_pmdb_d[l_ac].pmdb006
                     #161220-00059#2 -s by 08172
                     IF cl_null(g_pmda_m.pmda027) THEN
                        LET g_pmdb_d[l_ac].pmdb261 = g_pmdb_d[l_ac].pmdb006
                     END IF
                     #161220-00059#2 -e by 08172
                  END IF                  
               END IF 
            END IF
            LET g_pmdb_d_o.pmdb212 = g_pmdb_d[l_ac].pmdb212
            LET g_pmdb_d_o.pmdb006 = g_pmdb_d[l_ac].pmdb006   #150427-00012#5 150529 s983961---add      
            CALL apmt830_set_entry_b(l_cmd)
            #add-S By Ken 150318
            CALL apmt830_set_no_required_b(l_cmd)
            CALL apmt830_set_required_b(l_cmd)
            #add-E            
            CALL apmt830_set_no_entry_b(l_cmd)               
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb212
            #add-point:BEFORE FIELD pmdb212 name="input.b.page1.pmdb212"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdb212
            #add-point:ON CHANGE pmdb212 name="input.g.page1.pmdb212"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb007
            
            #add-point:AFTER FIELD pmdb007 name="input.a.page1.pmdb007"
            LET g_pmdb_d[l_ac].pmdb007_desc = ''
            IF NOT cl_null(g_pmdb_d[l_ac].pmdb007) THEN    
               #IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_pmdb_d[l_ac].pmdb007 != g_pmdb_d_o.pmdb007 OR g_pmdb_d_o.pmdb007 IS NULL )) THEN   #150427-00012#5 150529 s983961---mark                 
               IF g_pmdb_d[l_ac].pmdb007 != g_pmdb_d_o.pmdb007 OR g_pmdb_d_o.pmdb007 IS NULL THEN  #150427-00012#5 150529 s983961---add   
                  INITIALIZE g_chkparam.* TO NULL                
                  LET g_chkparam.arg1 = g_pmdb_d[l_ac].pmdb007 
                  #160318-00025#21  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aim-00005:sub-01302|aooi250|",cl_get_progname("aooi250",g_lang,"2"),"|:EXEPROGaooi250"
                 #160318-00025#21  by 07900 --add-end                    
                  IF NOT cl_chk_exist("v_ooca001") THEN
                     LET g_pmdb_d[l_ac].pmdb007 = g_pmdb_d_o.pmdb007
            
                     CALL s_desc_get_unit_desc(g_pmdb_d[l_ac].pmdb007) RETURNING g_pmdb_d[l_ac].pmdb007_desc     
                     #檢查失敗時後續處理
                     NEXT FIELD CURRENT
                  ELSE
                     IF NOT cl_null(g_pmdb_d[l_ac].pmdb212) THEN
                        #對要貨件數進行取位
                        CALL s_aooi250_take_decimals(g_pmdb_d[l_ac].pmdb201,g_pmdb_d[l_ac].pmdb212) RETURNING l_success,g_pmdb_d[l_ac].pmdb212
                        #換算要貨數量
                        CALL s_aooi250_convert_qty(g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb201,g_pmdb_d[l_ac].pmdb007,g_pmdb_d[l_ac].pmdb212)
                            RETURNING l_success,g_pmdb_d[l_ac].pmdb006                         
                     END IF                                              
                  END IF
               END IF
            END IF
            LET g_pmdb_d_o.pmdb007 = g_pmdb_d[l_ac].pmdb007 
            LET g_pmdb_d_o.pmdb006 = g_pmdb_d[l_ac].pmdb006   #150427-00012#5 150529 s983961---add    
            CALL s_desc_get_unit_desc(g_pmdb_d[l_ac].pmdb007) RETURNING g_pmdb_d[l_ac].pmdb007_desc
            CALL apmt830_set_entry_b(l_cmd)
            #add-S By Ken 150318
            CALL apmt830_set_no_required_b(l_cmd)
            CALL apmt830_set_required_b(l_cmd)
            #add-E            
            CALL apmt830_set_no_entry_b(l_cmd)            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb007
            #add-point:BEFORE FIELD pmdb007 name="input.b.page1.pmdb007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdb007
            #add-point:ON CHANGE pmdb007 name="input.g.page1.pmdb007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb261
            #add-point:BEFORE FIELD pmdb261 name="input.b.page1.pmdb261"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb261
            
            #add-point:AFTER FIELD pmdb261 name="input.a.page1.pmdb261"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdb261
            #add-point:ON CHANGE pmdb261 name="input.g.page1.pmdb261"
            
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
               #IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_pmdb_d[l_ac].pmdb006 != g_pmdb_d_o.pmdb006 OR g_pmdb_d_o.pmdb006 IS NULL )) THEN  #150427-00012#5 150529 s983961---mark                              
               IF g_pmdb_d[l_ac].pmdb006 <> g_pmdb_d_o.pmdb006 OR cl_null(g_pmdb_d_o.pmdb006) THEN   #150427-00012#5 150529 s983961---add              
                  #對要貨數量進行取位
                  CALL s_aooi250_take_decimals(g_pmdb_d[l_ac].pmdb007,g_pmdb_d[l_ac].pmdb006) 
                     RETURNING l_success,g_pmdb_d[l_ac].pmdb006
                  #換算要貨件數
                  IF NOT cl_null(g_pmdb_d[l_ac].pmdb007) THEN
                     CALL s_aooi250_convert_qty(g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb007,g_pmdb_d[l_ac].pmdb201,g_pmdb_d[l_ac].pmdb006)
                         RETURNING l_success,g_pmdb_d[l_ac].pmdb212
                  END IF
                  #161220-00059#2 -s by 08172
                  IF cl_null(g_pmda_m.pmda027) THEN
                     LET g_pmdb_d[l_ac].pmdb261 = g_pmdb_d[l_ac].pmdb006
                     CALL s_aooi250_take_decimals(g_pmdb_d[l_ac].pmdb007,g_pmdb_d[l_ac].pmdb261) 
                     RETURNING l_success,g_pmdb_d[l_ac].pmdb261
                     DISPLAY BY NAME g_pmdb_d[l_ac].pmdb261
                  END IF
                  #161220-00059#2 -e by 08172
               END IF                  
            END IF
            LET g_pmdb_d_o.pmdb006 = g_pmdb_d[l_ac].pmdb006            
            LET g_pmdb_d_o.pmdb261 = g_pmdb_d[l_ac].pmdb261      #161220-00059#2 by 08172         
            IF cl_null(g_pmdb_d[l_ac].pmdb006) THEN
               LET g_pmdb_d[l_ac].pmdb212 = null
            END IF            
            LET g_pmdb_d_o.pmdb212 = g_pmdb_d[l_ac].pmdb212   #150427-00012#5 150529 s983961---add  
            CALL apmt830_set_entry_b(l_cmd)
            #add-S By Ken 150318
            CALL apmt830_set_no_required_b(l_cmd)
            CALL apmt830_set_required_b(l_cmd)
            #add-E            
            CALL apmt830_set_no_entry_b(l_cmd)
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb006
            #add-point:BEFORE FIELD pmdb006 name="input.b.page1.pmdb006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdb006
            #add-point:ON CHANGE pmdb006 name="input.g.page1.pmdb006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb253
            #add-point:BEFORE FIELD pmdb253 name="input.b.page1.pmdb253"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb253
            
            #add-point:AFTER FIELD pmdb253 name="input.a.page1.pmdb253"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdb253
            #add-point:ON CHANGE pmdb253 name="input.g.page1.pmdb253"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb258
            #add-point:BEFORE FIELD pmdb258 name="input.b.page1.pmdb258"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb258
            
            #add-point:AFTER FIELD pmdb258 name="input.a.page1.pmdb258"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdb258
            #add-point:ON CHANGE pmdb258 name="input.g.page1.pmdb258"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb254
            #add-point:BEFORE FIELD pmdb254 name="input.b.page1.pmdb254"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb254
            
            #add-point:AFTER FIELD pmdb254 name="input.a.page1.pmdb254"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdb254
            #add-point:ON CHANGE pmdb254 name="input.g.page1.pmdb254"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb255
            #add-point:BEFORE FIELD pmdb255 name="input.b.page1.pmdb255"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb255
            
            #add-point:AFTER FIELD pmdb255 name="input.a.page1.pmdb255"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdb255
            #add-point:ON CHANGE pmdb255 name="input.g.page1.pmdb255"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb256
            #add-point:BEFORE FIELD pmdb256 name="input.b.page1.pmdb256"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb256
            
            #add-point:AFTER FIELD pmdb256 name="input.a.page1.pmdb256"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdb256
            #add-point:ON CHANGE pmdb256 name="input.g.page1.pmdb256"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb257
            #add-point:BEFORE FIELD pmdb257 name="input.b.page1.pmdb257"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb257
            
            #add-point:AFTER FIELD pmdb257 name="input.a.page1.pmdb257"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdb257
            #add-point:ON CHANGE pmdb257 name="input.g.page1.pmdb257"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb259
            #add-point:BEFORE FIELD pmdb259 name="input.b.page1.pmdb259"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb259
            
            #add-point:AFTER FIELD pmdb259 name="input.a.page1.pmdb259"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdb259
            #add-point:ON CHANGE pmdb259 name="input.g.page1.pmdb259"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb252
            #add-point:BEFORE FIELD pmdb252 name="input.b.page1.pmdb252"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb252
            
            #add-point:AFTER FIELD pmdb252 name="input.a.page1.pmdb252"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdb252
            #add-point:ON CHANGE pmdb252 name="input.g.page1.pmdb252"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb207
            #add-point:BEFORE FIELD pmdb207 name="input.b.page1.pmdb207"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb207
            
            #add-point:AFTER FIELD pmdb207 name="input.a.page1.pmdb207"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdb207
            #add-point:ON CHANGE pmdb207 name="input.g.page1.pmdb207"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb015
            
            #add-point:AFTER FIELD pmdb015 name="input.a.page1.pmdb015"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pmdb_d[l_ac].pmdb015
            CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_pmdb_d[l_ac].pmdb015_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pmdb_d[l_ac].pmdb015_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb015
            #add-point:BEFORE FIELD pmdb015 name="input.b.page1.pmdb015"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdb015
            #add-point:ON CHANGE pmdb015 name="input.g.page1.pmdb015"
            
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
         BEFORE FIELD pmdb030
            #add-point:BEFORE FIELD pmdb030 name="input.b.page1.pmdb030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb030
            
            #add-point:AFTER FIELD pmdb030 name="input.a.page1.pmdb030"
            IF NOT cl_null(g_pmdb_d[l_ac].pmdb030) THEN
               #IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_pmdb_d[l_ac].pmdb030 != g_pmdb_d_t.pmdb030 OR g_pmdb_d_t.pmdb030 IS NULL )) THEN   #160824-00007#18 20160914 mark by beckxie
               IF g_pmdb_d[l_ac].pmdb030 != g_pmdb_d_o.pmdb030 OR cl_null(g_pmdb_d_o.pmdb030) THEN   #160824-00007#18 20160914 add by beckxie
                  IF NOT cl_null(g_pmda_m.pmda207) AND g_pmdb_d[l_ac].pmdb030 > g_pmda_m.pmda207 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'apm-00346'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                  
                     #LET g_pmdb_d[l_ac].pmdb030 = g_pmdb_d_t.pmdb030   #160824-00007#18 20160914 mark by beckxie
                     LET g_pmdb_d[l_ac].pmdb030 = g_pmdb_d_o.pmdb030    #160824-00007#18 20160914 add by beckxie
                     NEXT FIELD pmdb030
                  END IF
                  IF NOT cl_null(g_pmdb_d[l_ac].pmdb210) AND g_pmdb_d[l_ac].pmdb030 >g_pmdb_d[l_ac].pmdb210  THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = 'apm-00347'
                      LET g_errparam.extend = ''
                      LET g_errparam.popup = TRUE
                      CALL cl_err()
                  
                      #LET g_pmdb_d[l_ac].pmdb030 = g_pmdb_d_t.pmdb030   #160824-00007#18 20160914 mark by beckxie
                      LET g_pmdb_d[l_ac].pmdb030 = g_pmdb_d_o.pmdb030    #160824-00007#18 20160914 add by beckxie
                     NEXT FIELD pmdb030
                  END IF
               END IF
            END IF
            LET g_pmdb_d_o.pmdb030 = g_pmdb_d[l_ac].pmdb030     #160824-00007#18 20160914 add by beckxie
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdb030
            #add-point:ON CHANGE pmdb030 name="input.g.page1.pmdb030"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb048
            
            #add-point:AFTER FIELD pmdb048 name="input.a.page1.pmdb048"
            IF NOT cl_null(g_pmdb_d[l_ac].pmdb048) THEN    
               #IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_pmdb_d[l_ac].pmdb048 != g_pmdb_d_t.pmdb048 OR g_pmdb_d_t.pmdb048 IS NULL )) THEN   #160824-00007#18 20160914 mark by beckxie
               IF g_pmdb_d[l_ac].pmdb048 != g_pmdb_d_o.pmdb048 OR cl_null(g_pmdb_d_o.pmdb048) THEN   #160824-00007#18 20160914 add by beckxie
                  IF NOT s_azzi650_chk_exist('274',g_pmdb_d[l_ac].pmdb048) THEN
                     #LET g_pmdb_d[l_ac].pmdb048 =  g_pmdb_d_t.pmdb048   #160824-00007#18 20160914 mark by beckxie
                     LET g_pmdb_d[l_ac].pmdb048 =  g_pmdb_d_o.pmdb048    #160824-00007#18 20160914 add by beckxie
                     CALL s_desc_get_acc_desc('274',g_pmdb_d[l_ac].pmdb048) RETURNING g_pmdb_d[l_ac].pmdb048_desc
                     NEXT FIELD pmdb048
                  END IF 
               END IF
            END IF   
            LET g_pmdb_d_o.pmdb048 = g_pmdb_d[l_ac].pmdb048    #160824-00007#18 20160914 add by beckxie
            CALL s_desc_get_acc_desc('274',g_pmdb_d[l_ac].pmdb048) RETURNING g_pmdb_d[l_ac].pmdb048_desc            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb048
            #add-point:BEFORE FIELD pmdb048 name="input.b.page1.pmdb048"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdb048
            #add-point:ON CHANGE pmdb048 name="input.g.page1.pmdb048"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb208
            #add-point:BEFORE FIELD pmdb208 name="input.b.page1.pmdb208"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb208
            
            #add-point:AFTER FIELD pmdb208 name="input.a.page1.pmdb208"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdb208
            #add-point:ON CHANGE pmdb208 name="input.g.page1.pmdb208"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb209
            
            #add-point:AFTER FIELD pmdb209 name="input.a.page1.pmdb209"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pmdb_d[l_ac].pmdb209
            CALL ap_ref_array2(g_ref_fields,"SELECT staal003 FROM staal_t WHERE staalent='"||g_enterprise||"' AND staal001=? AND staal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_pmdb_d[l_ac].pmdb209_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pmdb_d[l_ac].pmdb209_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb209
            #add-point:BEFORE FIELD pmdb209 name="input.b.page1.pmdb209"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdb209
            #add-point:ON CHANGE pmdb209 name="input.g.page1.pmdb209"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb206
            
            #add-point:AFTER FIELD pmdb206 name="input.a.page1.pmdb206"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pmdb_d[l_ac].pmdb206
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_pmdb_d[l_ac].pmdb206_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pmdb_d[l_ac].pmdb206_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb206
            #add-point:BEFORE FIELD pmdb206 name="input.b.page1.pmdb206"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdb206
            #add-point:ON CHANGE pmdb206 name="input.g.page1.pmdb206"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb210
            #add-point:BEFORE FIELD pmdb210 name="input.b.page1.pmdb210"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb210
            
            #add-point:AFTER FIELD pmdb210 name="input.a.page1.pmdb210"
            IF NOT cl_null(g_pmdb_d[l_ac].pmdb210) THEN
               #IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_pmdb_d[l_ac].pmdb210 != g_pmdb_d_t.pmdb210 OR g_pmdb_d_t.pmdb210 IS NULL )) THEN   #160824-00007#18 20160914 mark by beckxie
               IF g_pmdb_d[l_ac].pmdb210 != g_pmdb_d_o.pmdb210 OR cl_null(g_pmdb_d_o.pmdb210) THEN   #160824-00007#18 20160914 add by beckxie
                  IF NOT cl_null(g_pmdb_d[l_ac].pmdb030) AND g_pmdb_d[l_ac].pmdb030 >g_pmdb_d[l_ac].pmdb210  THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'apm-00345'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                  
                     #LET g_pmdb_d[l_ac].pmdb210 = g_pmdb_d_t.pmdb210   #160824-00007#18 20160914 mark by beckxie
                     LET g_pmdb_d[l_ac].pmdb210 = g_pmdb_d_o.pmdb210    #160824-00007#18 20160914 add by beckxie
                     NEXT FIELD pmdb210
                  END IF
                  IF NOT cl_null(g_pmdb_d[l_ac].pmdb211) AND g_pmdb_d[l_ac].pmdb210 > g_pmdb_d[l_ac].pmdb211  THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'apm-00343'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #LET g_pmdb_d[l_ac].pmdb210 = g_pmdb_d_t.pmdb210   #160824-00007#18 20160914 mark by beckxie
                     LET g_pmdb_d[l_ac].pmdb210 = g_pmdb_d_o.pmdb210   #160824-00007#18 20160914 add by beckxie
                     NEXT FIELD pmdb210
                  END IF 
               END IF                  
            END IF
            #add-S By Ken 150318
            LET g_pmdb_d_o.pmdb210 = g_pmdb_d[l_ac].pmdb210  #160824-00007#18 20160914 add by beckxie
            CALL apmt830_set_entry_b(l_cmd)
            CALL apmt830_set_no_required_b(l_cmd)
            CALL apmt830_set_required_b(l_cmd)
            CALL apmt830_set_no_entry_b(l_cmd)
            #add-E
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdb210
            #add-point:ON CHANGE pmdb210 name="input.g.page1.pmdb210"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb211
            #add-point:BEFORE FIELD pmdb211 name="input.b.page1.pmdb211"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb211
            
            #add-point:AFTER FIELD pmdb211 name="input.a.page1.pmdb211"
            IF NOT cl_null(g_pmdb_d[l_ac].pmdb211) THEN
               #IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_pmdb_d[l_ac].pmdb211 != g_pmdb_d_t.pmdb211 OR g_pmdb_d_t.pmdb211 IS NULL )) THEN   #160824-00007#18 20160914 mark by beckxie
               IF g_pmdb_d[l_ac].pmdb211 != g_pmdb_d_o.pmdb211 OR cl_null(g_pmdb_d_o.pmdb211) THEN   #160824-00007#18 20160914 add by beckxie
                  IF NOT cl_null(g_pmdb_d[l_ac].pmdb210) AND g_pmdb_d[l_ac].pmdb210 > g_pmdb_d[l_ac].pmdb211  THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'apm-00344'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                  
                     #LET g_pmdb_d[l_ac].pmdb211 = g_pmdb_d_t.pmdb211   #160824-00007#18 20160914 mark by beckxie
                     LET g_pmdb_d[l_ac].pmdb211 = g_pmdb_d_o.pmdb211    #160824-00007#18 20160914 add by beckxie
                     NEXT FIELD pmdb211
                  END IF
               END IF                  
            END IF 
            #add-S By Ken 150318
            LET g_pmdb_d_o.pmdb211 = g_pmdb_d[l_ac].pmdb211   #160824-00007#18 20160914 add by beckxie
            CALL apmt830_set_entry_b(l_cmd)
            CALL apmt830_set_no_required_b(l_cmd)
            CALL apmt830_set_required_b(l_cmd)
            CALL apmt830_set_no_entry_b(l_cmd)
            #add-E            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdb211
            #add-point:ON CHANGE pmdb211 name="input.g.page1.pmdb211"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb205
            
            #add-point:AFTER FIELD pmdb205 name="input.a.page1.pmdb205"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pmdb_d[l_ac].pmdb205
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_pmdb_d[l_ac].pmdb205_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pmdb_d[l_ac].pmdb205_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb205
            #add-point:BEFORE FIELD pmdb205 name="input.b.page1.pmdb205"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdb205
            #add-point:ON CHANGE pmdb205 name="input.g.page1.pmdb205"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb203
            
            #add-point:AFTER FIELD pmdb203 name="input.a.page1.pmdb203"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pmdb_d[l_ac].pmdb203
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_pmdb_d[l_ac].pmdb203_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pmdb_d[l_ac].pmdb203_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb203
            #add-point:BEFORE FIELD pmdb203 name="input.b.page1.pmdb203"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdb203
            #add-point:ON CHANGE pmdb203 name="input.g.page1.pmdb203"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb204
            
            #add-point:AFTER FIELD pmdb204 name="input.a.page1.pmdb204"
            #170116-00018#1 -s 20170116 add by 08172
            IF NOT cl_null(g_pmdb_d[l_ac].pmdb204) THEN
               IF NOT cl_null(g_pmdb_d[l_ac].pmdb203) THEN
                  INITIALIZE g_chkparam.* TO NULL               
                  LET g_chkparam.arg1 = g_pmdb_d[l_ac].pmdb203   
                  LET g_chkparam.arg2 = g_pmdb_d[l_ac].pmdb204
                  IF NOT cl_chk_exist("v_inaa001") THEN
                     LET g_pmdb_d[l_ac].pmdb204 = g_pmdb_d_o.pmdb204
                     CALL s_desc_get_stock_desc(g_pmdb_d[l_ac].pmdb203,g_pmdb_d[l_ac].pmdb204) RETURNING  g_pmdb_d[l_ac].pmdb204_desc             
                     NEXT FIELD CURRENT
                  END IF
               ELSE
                  SELECT COUNT(1) INTO l_cnt
                    FROM inaa_t
                   WHERE inaaent = g_enterprise
                     AND inaa001 = g_pmdb_d[l_ac].pmdb204
                     AND inaastus = 'Y'
                  IF l_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'abm-00044'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_pmdb_d[l_ac].pmdb204 = g_pmdb_d_o.pmdb204
                     CALL s_desc_get_stock_desc(g_pmdb_d[l_ac].pmdb203,g_pmdb_d[l_ac].pmdb204) RETURNING  g_pmdb_d[l_ac].pmdb204_desc             
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_pmdb_d_o.pmdb204 = g_pmdb_d[l_ac].pmdb204
            #170116-00018#1 -e 20170116 add by 08172
            CALL s_desc_get_stock_desc(g_pmdb_d[l_ac].pmdb203,g_pmdb_d[l_ac].pmdb204) RETURNING  g_pmdb_d[l_ac].pmdb204_desc             
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb204
            #add-point:BEFORE FIELD pmdb204 name="input.b.page1.pmdb204"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdb204
            #add-point:ON CHANGE pmdb204 name="input.g.page1.pmdb204"
            
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
            #141009-00031#30 By Ken-S
            IF NOT cl_null(g_pmdb_d[l_ac].pmdb051) THEN    
               #IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_pmdb_d[l_ac].pmdb051 != g_pmdb_d_t.pmdb051 OR g_pmdb_d_t.pmdb051 IS NULL )) THEN   #160824-00007#18 20160914 mark by beckxie
               IF g_pmdb_d[l_ac].pmdb051 != g_pmdb_d_o.pmdb051 OR cl_null(g_pmdb_d_t.pmdb051) THEN   #160824-00007#18 20160914 add by beckxie
                  IF NOT s_azzi650_chk_exist('258',g_pmdb_d[l_ac].pmdb051) THEN
                     #LET g_pmdb_d[l_ac].pmdb051 =  g_pmdb_d_t.pmdb051   #160824-00007#18 20160914 mark by beckxie
                     LET g_pmdb_d[l_ac].pmdb051 =  g_pmdb_d_o.pmdb051    #160824-00007#18 20160914 add by beckxie
                     CALL s_desc_get_acc_desc('258',g_pmdb_d[l_ac].pmdb051) RETURNING g_pmdb_d[l_ac].pmdb051_desc
                     NEXT FIELD pmdb051
                  END IF 
               END IF
            END IF               
            LET g_pmdb_d_o.pmdb051 = g_pmdb_d[l_ac].pmdb051   #160824-00007#18 20160914 add by beckxie
            CALL s_desc_get_acc_desc('258',g_pmdb_d[l_ac].pmdb051) RETURNING g_pmdb_d[l_ac].pmdb051_desc
            #141009-00031#30 By Ken-E                     
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb051
            #add-point:BEFORE FIELD pmdb051 name="input.b.page1.pmdb051"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdb051
            #add-point:ON CHANGE pmdb051 name="input.g.page1.pmdb051"
            
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
 
 
         #Ctrlp:input.c.page1.pmdbsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdbsite
            #add-point:ON ACTION controlp INFIELD pmdbsite name="input.c.page1.pmdbsite"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmdb_d[l_ac].pmdbsite             #給予default值
            LET g_qryparam.default2 = "" #g_pmdb_d[l_ac].ooefl003 #說明(簡稱)

            LET g_qryparam.where = s_aooi500_q_where(g_prog,'pmdbsite',g_pmda_m.pmdasite,'i') #150308-00001#1  By Ken add 'i' 150309
            CALL q_ooef001_24()   #呼叫開窗

            LET g_pmdb_d[l_ac].pmdbsite = g_qryparam.return1              
            DISPLAY g_pmdb_d[l_ac].pmdbsite TO pmdbsite              #
            CALL s_desc_get_department_desc(g_pmdb_d[l_ac].pmdbsite) 
               RETURNING g_pmdb_d[l_ac].pmdbsite_desc            
            NEXT FIELD pmdbsite                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdb200
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb200
            #add-point:ON ACTION controlp INFIELD pmdb200 name="input.c.page1.pmdb200"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmdb_d[l_ac].pmdb200             #給予default值
            LET g_qryparam.arg1 =  g_pmdb_d[l_ac].pmdbsite
            LET g_qryparam.arg2 = g_pmda_m.pmdadocdt 
            #給予arg
            IF NOT cl_null(g_pmda_m.pmda202) THEN
               CALL cl_get_para(g_enterprise,g_site,'E-CIR-0001') RETURNING l_sys
               LET g_qryparam.where = " imaa009 IN (SELECT DISTINCT rtax001 FROM rtax_t ",
                                      "              WHERE rtaxent ='",g_enterprise,"' AND rtax004 >='",l_sys,"' AND rtaxstus = 'Y'",
                                      #"              START WITH rtax003 = '",g_pmda_m.pmda202,"' AND rtaxstus = 'Y' CONNECT BY nocycle PRIOR rtax001 = rtax003 )"    #150507-00008#1 150507 by lori522612 mark                                    
                                      "              START WITH rtax003 = '",g_pmda_m.pmda202,"' ",   #150507-00008#1 150507 by lori522612 add
                                      "              CONNECT BY NOCYCLE PRIOR rtax001 = rtax003 ",#150507-00008#1 150507 by lori522612 add
                                      "              UNION ",
                                      "             SELECT DISTINCT rtax001",
                                      "                        FROM rtax_t ",
                                      "                       WHERE rtaxent =",g_enterprise,
                                      "                         AND rtax004 = ",l_sys,
                                      "                         AND rtax005 = 0 ",
                                      "                         AND rtaxstus = 'Y' ",
                                      "                         AND rtax001 = '",g_pmda_m.pmda202,"' )"    
            END IF
            IF NOT cl_null(g_pmda_m.pmda201) THEN
               IF NOT cl_null(g_qryparam.where) THEN
                  LET g_qryparam.where = g_qryparam.where," AND rtdx027 = '",g_pmda_m.pmda201,"'"
               ELSE
                  LET g_qryparam.where = " rtdx027 = '",g_pmda_m.pmda201,"'"
               END IF
            END IF 
            
             IF NOT cl_null(g_pmda_m.pmda204) THEN
               IF NOT cl_null(g_qryparam.where) THEN
                  LET g_qryparam.where = g_qryparam.where," AND rtdx028 = '",g_pmda_m.pmda204,"'"
               ELSE
                  LET g_qryparam.where = " rtdx028 = '",g_pmda_m.pmda204,"'"
               END IF
            END IF            
            IF NOT cl_null(g_pmda_m.pmda205) THEN
               IF NOT cl_null(g_qryparam.where) THEN
                  LET g_qryparam.where = g_qryparam.where," AND rtdx029 = '",g_pmda_m.pmda205,"'"
               ELSE
                  LET g_qryparam.where = " rtdx029 = '",g_pmda_m.pmda205,"'"
               END IF
            END IF             
            #150126-00028#14 By benson ---- S
            IF cl_null(g_qryparam.where) THEN
               LET g_qryparam.where = s_arti204_control_where(g_prog,g_pmda_m.pmda003,'1')
            ELSE
               LET g_qryparam.where = g_qryparam.where CLIPPED," AND ",s_arti204_control_where(g_prog,g_pmda_m.pmda003,'1')
            END IF           
            #150126-00028#14 By benson ---- E        
            #加上協議日期條件
            #150424-00021#1 Modify-S By Ken 150430
            
            #LET g_qryparam.where = g_qryparam.where CLIPPED," AND (imaf153 IS NULL OR  EXISTS(SELECT 1 FROM stan_t,star_t,stas_t WHERE stan001 = star004 AND star001 = stas001
            #   AND stas003 =rtdx001 AND star003 = imaf153 AND starstus = 'Y' AND to_date('", g_pmda_m.pmdadocdt ,"','YYYY/MM/DD') between stan017 AND stan018 AND imaf153 IS NOT NULL  )) "                        
            
            
            #LET g_qryparam.where = g_qryparam.where CLIPPED," AND (rtdx031 IS NULL OR  EXISTS(SELECT 1 FROM stan_t,star_t,stas_t WHERE stan001 = star004 AND star001 = stas001
            #   AND stas003 =rtdx001 AND star003 = rtdx031 AND starstus = 'Y' AND to_date('", g_pmda_m.pmdadocdt ,"','YYYY/MM/DD') between stan017 AND stan018 AND rtdx031 IS NOT NULL  )) "            
            #150424-00021#1 Modify-E
            CALL q_imay003_5()                              #呼叫開窗
            #CALL q_rtdx002()  #Mark 150521
            LET g_pmdb_d[l_ac].pmdb200 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmdb_d[l_ac].pmdb200 TO pmdb200              #顯示到畫面上

            NEXT FIELD pmdb200                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdb004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb004
            #add-point:ON ACTION controlp INFIELD pmdb004 name="input.c.page1.pmdb004"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmdb_d[l_ac].pmdb004             #給予default值

            #給予arg
            LET g_qryparam.arg1 =  g_pmdb_d[l_ac].pmdbsite
            LET g_qryparam.arg2 = g_pmda_m.pmdadocdt
            IF NOT cl_null(g_pmda_m.pmda202) THEN
               CALL cl_get_para(g_enterprise,g_site,'E-CIR-0001') RETURNING l_sys
               LET g_qryparam.where = " imaa009 IN (SELECT DISTINCT rtax001 FROM rtax_t ",
                                      "              WHERE rtaxent ='",g_enterprise,"' AND rtax004 >='",l_sys,"' AND rtaxstus = 'Y'",
                                      #"              START WITH rtax003 = '",g_pmda_m.pmda202,"' AND rtaxstus = 'Y' CONNECT BY nocycle PRIOR rtax001 = rtax003 )"       #150507-00008#1 150507 by lori522612 mark                                         
                                      "              START WITH rtax003 = '",g_pmda_m.pmda202,"' ",      #150507-00008#1 150507 by lori522612 add
                                      "              CONNECT BY NOCYCLE PRIOR rtax001 = rtax003 ",       #150507-00008#1 150507 by lori522612 add
                                      "              UNION ",
                                      "             SELECT DISTINCT rtax001",
                                      "                        FROM rtax_t ",
                                      "                       WHERE rtaxent =",g_enterprise,
                                      "                         AND rtax004 = ",l_sys,
                                      "                         AND rtax005 = 0 ",
                                      "                         AND rtaxstus = 'Y' ",
                                      "                         AND rtax001 = '",g_pmda_m.pmda202,"' )"                                       
            END IF
            IF NOT cl_null(g_pmda_m.pmda201) THEN
               IF NOT cl_null(g_qryparam.where) THEN
                  LET g_qryparam.where = g_qryparam.where," AND rtdx027 = '",g_pmda_m.pmda201,"'"
               ELSE
                  LET g_qryparam.where = " rtdx027 = '",g_pmda_m.pmda201,"'"
               END IF
            END IF 
            
             IF NOT cl_null(g_pmda_m.pmda204) THEN
               IF NOT cl_null(g_qryparam.where) THEN
                  LET g_qryparam.where = g_qryparam.where," AND rtdx028 = '",g_pmda_m.pmda204,"'"
               ELSE
                  LET g_qryparam.where = " rtdx028 = '",g_pmda_m.pmda204,"'"
               END IF
            END IF            
            IF NOT cl_null(g_pmda_m.pmda205) THEN
               IF NOT cl_null(g_qryparam.where) THEN
                  LET g_qryparam.where = g_qryparam.where," AND rtdx029 = '",g_pmda_m.pmda205,"'"
               ELSE
                  LET g_qryparam.where = " rtdx029 = '",g_pmda_m.pmda205,"'"
               END IF
            END IF 
            #150126-00028#14 By benson ---- S
            IF cl_null(g_qryparam.where) THEN
               LET g_qryparam.where = s_arti204_control_where(g_prog,g_pmda_m.pmda003,'1')
            ELSE
               LET g_qryparam.where = g_qryparam.where CLIPPED," AND ",s_arti204_control_where(g_prog,g_pmda_m.pmda003,'1')
            END IF
            #150126-00028#14 By benson ---- E
            CALL q_rtdx001_15()                                #呼叫開窗
            LET g_pmdb_d[l_ac].pmdb004 = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_pmdb_d[l_ac].pmdb004 TO pmdb004              #顯示到畫面上
            #品名、規格
            CALL s_desc_get_item_desc(g_pmdb_d[l_ac].pmdb004) 
               RETURNING g_pmdb_d[l_ac].pmdb004_desc,g_pmdb_d[l_ac].pmdb004_desc_desc 
            NEXT FIELD pmdb004                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdb005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb005
            #add-point:ON ACTION controlp INFIELD pmdb005 name="input.c.page1.pmdb005"
            #ken---add---s 產品特徵
            LET l_imaa005 = ''
            CALL apmt830_get_imaa005(g_pmdb_d[l_ac].pmdb004) RETURNING l_imaa005
               
            IF NOT cl_null(l_imaa005) THEN
               IF l_cmd = 'a' THEN            
                  CALL l_inam.clear()            
                  CALL s_feature(l_cmd,g_pmdb_d[l_ac].pmdb004,'','',g_site,g_pmda_m.pmdadocno) 
                     RETURNING l_success,l_inam
                  LET g_pmdb_d[l_ac].pmdb005 = l_inam[1].inam002
                  LET g_pmdb_d[l_ac].pmdb006 = l_inam[1].inam004
                  
                  #單位間的轉換數量
                  CALL apmt830_num_change() 
                  
               END IF
               IF l_cmd = 'u' THEN
                  CALL s_feature_single(g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb005,g_site,g_pmda_m.pmdadocno)
                     RETURNING l_success,g_pmdb_d[l_ac].pmdb005
                  CALL s_feature_description(g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb005) 
                     RETURNING l_success,g_pmdb_d[l_ac].pmdb005_desc
               END IF
            END IF                          
            #ken---add---e
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdb005_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb005_desc
            #add-point:ON ACTION controlp INFIELD pmdb005_desc name="input.c.page1.pmdb005_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.imaa154
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa154
            #add-point:ON ACTION controlp INFIELD imaa154 name="input.c.page1.imaa154"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.imaa155
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa155
            #add-point:ON ACTION controlp INFIELD imaa155 name="input.c.page1.imaa155"
            
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
 
 
         #Ctrlp:input.c.page1.rtaw001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtaw001
            #add-point:ON ACTION controlp INFIELD rtaw001 name="input.c.page1.rtaw001"
 
            #END add-point
 
 
         #Ctrlp:input.c.page1.imaa009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa009
            #add-point:ON ACTION controlp INFIELD imaa009 name="input.c.page1.imaa009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.imaa116
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa116
            #add-point:ON ACTION controlp INFIELD imaa116 name="input.c.page1.imaa116"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdb033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb033
            #add-point:ON ACTION controlp INFIELD pmdb033 name="input.c.page1.pmdb033"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdb037
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb037
            #add-point:ON ACTION controlp INFIELD pmdb037 name="input.c.page1.pmdb037"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmdb_d[l_ac].pmdb037             #給予default值
            #ken---add---S aooi500
            IF s_aooi500_setpoint(g_prog,'pmdb037') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'pmdb037',g_pmda_m.pmdasite,'i') #150308-00001#1  By Ken add 'i' 150309
               CALL q_ooef001_24()
            ELSE    
               LET g_qryparam.arg1 = g_pmdb_d[l_ac].pmdbsite
               LET g_qryparam.arg2 = 8
               CALL q_ooed004_3()               
               #LET g_qryparam.where = "ooef201 = 'Y'"          
               #CALL q_ooef001()                                #呼叫開窗 
            END IF   
            #ken---add---E            
            LET g_pmdb_d[l_ac].pmdb037 = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_pmdb_d[l_ac].pmdb037 TO pmdb037              #顯示到畫面上
            CALL s_desc_get_department_desc(g_pmdb_d[l_ac].pmdb037) RETURNING g_pmdb_d[l_ac].pmdb037_desc            
            NEXT FIELD pmdb037                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdb260
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb260
            #add-point:ON ACTION controlp INFIELD pmdb260 name="input.c.page1.pmdb260"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmdb_d[l_ac].pmdb260             #給予default值
            #給予arg
            LET g_qryparam.arg1 = g_pmda_m.pmdadocdt #
            #CALL q_ooeg001()                                #呼叫開窗  #160303-00028#9 dongsz mark
            CALL q_ooeg001_9()      #呼叫開窗  #160303-00028#9 dongsz add
            LET g_pmdb_d[l_ac].pmdb260 = g_qryparam.return1              
            DISPLAY g_pmdb_d[l_ac].pmdb260 TO pmdb260              #
            CALL s_desc_get_department_desc(g_pmdb_d[l_ac].pmdb260) RETURNING g_pmdb_d[l_ac].pmdb260_desc  #ken
            NEXT FIELD pmdb260                          #返回原欄位 
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdb038
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb038
            #add-point:ON ACTION controlp INFIELD pmdb038 name="input.c.page1.pmdb038"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmdb_d[l_ac].pmdb038             #給予default值
            #給予arg
            LET g_qryparam.arg1 = g_pmdb_d[l_ac].pmdb037  #


            CALL q_inaa001_6()                                #呼叫開窗

            LET g_pmdb_d[l_ac].pmdb038 = g_qryparam.return1               
            DISPLAY g_pmdb_d[l_ac].pmdb038 TO pmdb038              
            CALL s_desc_get_stock_desc('',g_pmdb_d[l_ac].pmdb038) RETURNING  g_pmdb_d[l_ac].pmdb038_desc            
            NEXT FIELD pmdb038                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdb227
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb227
            #add-point:ON ACTION controlp INFIELD pmdb227 name="input.c.page1.pmdb227"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdb201
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb201
            #add-point:ON ACTION controlp INFIELD pmdb201 name="input.c.page1.pmdb201"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmdb_d[l_ac].pmdb201             #給予default值
            LET g_qryparam.arg1 = "" 
            CALL q_ooca001_1()                                #呼叫開窗
            LET g_pmdb_d[l_ac].pmdb201 = g_qryparam.return1              
            DISPLAY g_pmdb_d[l_ac].pmdb201 TO pmdb201              #
            NEXT FIELD pmdb201                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdb202
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb202
            #add-point:ON ACTION controlp INFIELD pmdb202 name="input.c.page1.pmdb202"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdb212
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb212
            #add-point:ON ACTION controlp INFIELD pmdb212 name="input.c.page1.pmdb212"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdb007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb007
            #add-point:ON ACTION controlp INFIELD pmdb007 name="input.c.page1.pmdb007"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmdb_d[l_ac].pmdb007             #給予default值
            LET g_qryparam.arg1 = "" #s
            CALL q_ooca001_1()                                #呼叫開窗
            LET g_pmdb_d[l_ac].pmdb007 = g_qryparam.return1              
            DISPLAY g_pmdb_d[l_ac].pmdb007 TO pmdb007   
            CALL s_desc_get_unit_desc(g_pmdb_d[l_ac].pmdb007) RETURNING g_pmdb_d[l_ac].pmdb007_desc                 
            NEXT FIELD pmdb007                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdb261
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb261
            #add-point:ON ACTION controlp INFIELD pmdb261 name="input.c.page1.pmdb261"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdb006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb006
            #add-point:ON ACTION controlp INFIELD pmdb006 name="input.c.page1.pmdb006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdb253
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb253
            #add-point:ON ACTION controlp INFIELD pmdb253 name="input.c.page1.pmdb253"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdb258
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb258
            #add-point:ON ACTION controlp INFIELD pmdb258 name="input.c.page1.pmdb258"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdb254
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb254
            #add-point:ON ACTION controlp INFIELD pmdb254 name="input.c.page1.pmdb254"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdb255
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb255
            #add-point:ON ACTION controlp INFIELD pmdb255 name="input.c.page1.pmdb255"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdb256
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb256
            #add-point:ON ACTION controlp INFIELD pmdb256 name="input.c.page1.pmdb256"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdb257
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb257
            #add-point:ON ACTION controlp INFIELD pmdb257 name="input.c.page1.pmdb257"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdb259
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb259
            #add-point:ON ACTION controlp INFIELD pmdb259 name="input.c.page1.pmdb259"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdb252
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb252
            #add-point:ON ACTION controlp INFIELD pmdb252 name="input.c.page1.pmdb252"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdb207
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb207
            #add-point:ON ACTION controlp INFIELD pmdb207 name="input.c.page1.pmdb207"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdb015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb015
            #add-point:ON ACTION controlp INFIELD pmdb015 name="input.c.page1.pmdb015"
 
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdb049
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb049
            #add-point:ON ACTION controlp INFIELD pmdb049 name="input.c.page1.pmdb049"
            
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
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmdb_d[l_ac].pmdb048             #給予default值
            LET g_qryparam.arg1 = "274" #s
            CALL q_oocq002()                                #呼叫開窗
            LET g_pmdb_d[l_ac].pmdb048 = g_qryparam.return1              
            DISPLAY g_pmdb_d[l_ac].pmdb048 TO pmdb048      
            CALL s_desc_get_acc_desc('274',g_pmdb_d[l_ac].pmdb048) RETURNING g_pmdb_d[l_ac].pmdb048_desc
            NEXT FIELD pmdb048                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdb208
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb208
            #add-point:ON ACTION controlp INFIELD pmdb208 name="input.c.page1.pmdb208"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdb209
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb209
            #add-point:ON ACTION controlp INFIELD pmdb209 name="input.c.page1.pmdb209"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdb206
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb206
            #add-point:ON ACTION controlp INFIELD pmdb206 name="input.c.page1.pmdb206"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdb210
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb210
            #add-point:ON ACTION controlp INFIELD pmdb210 name="input.c.page1.pmdb210"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdb211
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb211
            #add-point:ON ACTION controlp INFIELD pmdb211 name="input.c.page1.pmdb211"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdb205
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb205
            #add-point:ON ACTION controlp INFIELD pmdb205 name="input.c.page1.pmdb205"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdb203
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb203
            #add-point:ON ACTION controlp INFIELD pmdb203 name="input.c.page1.pmdb203"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdb204
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb204
            #add-point:ON ACTION controlp INFIELD pmdb204 name="input.c.page1.pmdb204"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE            
            LET g_qryparam.default1 = g_pmdb_d[l_ac].pmdb204             #給予default值
            LET g_qryparam.arg1 = g_pmdb_d[l_ac].pmdb203 #      
            CALL q_inaa001_6()                                #呼叫開窗 
            LET g_pmdb_d[l_ac].pmdb204 = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_pmdb_d[l_ac].pmdb204 TO pmdb204              #顯示到畫面上
            CALL s_desc_get_stock_desc(g_pmdb_d[l_ac].pmdb203,g_pmdb_d[l_ac].pmdb204) RETURNING  g_pmdb_d[l_ac].pmdb204_desc             
            NEXT FIELD pmdb204                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdb032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb032
            #add-point:ON ACTION controlp INFIELD pmdb032 name="input.c.page1.pmdb032"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdb051
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb051
            #add-point:ON ACTION controlp INFIELD pmdb051 name="input.c.page1.pmdb051"
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pmdb_d[l_ac].pmdb051             #給予default值
            LET g_qryparam.arg1 = "258" 
            CALL q_oocq002()                                #呼叫開窗
            LET g_pmdb_d[l_ac].pmdb051 = g_qryparam.return1              
            DISPLAY g_pmdb_d[l_ac].pmdb051 TO pmdb051   
            CALL s_desc_get_acc_desc('258',g_pmdb_d[l_ac].pmdb051) RETURNING g_pmdb_d[l_ac].pmdb051_desc
            NEXT FIELD pmdb051                          #返回原欄位
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_pmdb_d[l_ac].* = g_pmdb_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE apmt830_bcl
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
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL apmt830_pmdb_t_mask_restore('restore_mask_o')
      
               UPDATE pmdb_t SET (pmdbdocno,pmdbseq,pmdb001,pmdb002,pmdb003,pmdbsite,pmdb200,pmdb004, 
                   pmdb005,pmdb033,pmdb037,pmdb260,pmdb038,pmdb227,pmdb201,pmdb202,pmdb212,pmdb007,pmdb213, 
                   pmdb261,pmdb006,pmdb253,pmdb258,pmdb254,pmdb255,pmdb256,pmdb257,pmdb259,pmdb252,pmdb207, 
                   pmdb015,pmdb049,pmdb030,pmdb048,pmdb208,pmdb209,pmdb206,pmdb210,pmdb211,pmdb205,pmdb203, 
                   pmdb204,pmdb032,pmdb051) = (g_pmda_m.pmdadocno,g_pmdb_d[l_ac].pmdbseq,g_pmdb_d[l_ac].pmdb001, 
                   g_pmdb_d[l_ac].pmdb002,g_pmdb_d[l_ac].pmdb003,g_pmdb_d[l_ac].pmdbsite,g_pmdb_d[l_ac].pmdb200, 
                   g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb005,g_pmdb_d[l_ac].pmdb033,g_pmdb_d[l_ac].pmdb037, 
                   g_pmdb_d[l_ac].pmdb260,g_pmdb_d[l_ac].pmdb038,g_pmdb_d[l_ac].pmdb227,g_pmdb_d[l_ac].pmdb201, 
                   g_pmdb_d[l_ac].pmdb202,g_pmdb_d[l_ac].pmdb212,g_pmdb_d[l_ac].pmdb007,g_pmdb_d[l_ac].pmdb213, 
                   g_pmdb_d[l_ac].pmdb261,g_pmdb_d[l_ac].pmdb006,g_pmdb_d[l_ac].pmdb253,g_pmdb_d[l_ac].pmdb258, 
                   g_pmdb_d[l_ac].pmdb254,g_pmdb_d[l_ac].pmdb255,g_pmdb_d[l_ac].pmdb256,g_pmdb_d[l_ac].pmdb257, 
                   g_pmdb_d[l_ac].pmdb259,g_pmdb_d[l_ac].pmdb252,g_pmdb_d[l_ac].pmdb207,g_pmdb_d[l_ac].pmdb015, 
                   g_pmdb_d[l_ac].pmdb049,g_pmdb_d[l_ac].pmdb030,g_pmdb_d[l_ac].pmdb048,g_pmdb_d[l_ac].pmdb208, 
                   g_pmdb_d[l_ac].pmdb209,g_pmdb_d[l_ac].pmdb206,g_pmdb_d[l_ac].pmdb210,g_pmdb_d[l_ac].pmdb211, 
                   g_pmdb_d[l_ac].pmdb205,g_pmdb_d[l_ac].pmdb203,g_pmdb_d[l_ac].pmdb204,g_pmdb_d[l_ac].pmdb032, 
                   g_pmdb_d[l_ac].pmdb051)
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
               CALL apmt830_update_b('pmdb_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL apmt830_pmdb_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_pmdb_d[g_detail_idx].pmdbseq = g_pmdb_d_t.pmdbseq 
 
                  ) THEN
                  LET gs_keys[01] = g_pmda_m.pmdadocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_pmdb_d_t.pmdbseq
 
                  CALL apmt830_key_update_b(gs_keys,'pmdb_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_pmda_m),util.JSON.stringify(g_pmdb_d_t)
               LET g_log2 = util.JSON.stringify(g_pmda_m),util.JSON.stringify(g_pmdb_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               ##單身要貨件數加總 Update到單頭包裝總數量
               #CALL apmt830_pmdb212_sum()              
               #SELECT SUM(pmdb212) INTO g_pmda_m.pmda208 FROM pmdb_t  
               # WHERE pmdbent = g_enterprise AND pmdbdocno = g_pmda_m.pmdadocno 
               #DISPLAY BY NAME g_pmda_m.pmda208
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            #單頭包裝總數量更新
            CALL apmt830_pmdb212_sum()
            
            UPDATE pmda_t 
              SET pmda208 = g_pmda_m.pmda208      
            WHERE pmdaent = g_enterprise AND pmdadocno = g_pmda_m.pmdadocno
            IF SQLCA.sqlcode THEN
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = SQLCA.sqlcode
              LET g_errparam.extend = "pmda_t"
              LET g_errparam.popup = FALSE
              CALL cl_err()
            END IF    
            #end add-point
            CALL apmt830_unlock_b("pmdb_t","'1'")
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
      
 
      
 
 
 
 
{</section>}
 
{<section id="apmt830.input.other" >}
      
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
            NEXT FIELD pmdasite  #ken20150306
            #end add-point  
            NEXT FIELD pmdadocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD pmdbseq
 
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
 
{<section id="apmt830.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION apmt830_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL apmt830_b_fill() #單身填充
      CALL apmt830_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL apmt830_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   #單身要貨件數加總 Update到單頭包裝總數量
   CALL apmt830_pmdb212_sum()
  #Add By baogc 20151104 Begin ---
   #汇总单身参考金额
   SELECT SUM(COALESCE(pmdb213*pmdb006,0)) INTO g_pmda_m.l_amts
     FROM pmdb_t
    WHERE pmdbent = g_enterprise AND pmdbdocno = g_pmda_m.pmdadocno
  #Add By baogc 20151104 End   ---
   #end add-point
   
   #遮罩相關處理
   LET g_pmda_m_mask_o.* =  g_pmda_m.*
   CALL apmt830_pmda_t_mask()
   LET g_pmda_m_mask_n.* =  g_pmda_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_pmda_m.pmdasite,g_pmda_m.pmdasite_desc,g_pmda_m.pmda200,g_pmda_m.pmdadocdt,g_pmda_m.pmdadocno, 
       g_pmda_m.pmda001,g_pmda_m.pmda002,g_pmda_m.pmda002_desc,g_pmda_m.pmda003,g_pmda_m.pmda003_desc, 
       g_pmda_m.pmdastus,g_pmda_m.pmda202,g_pmda_m.pmda202_desc,g_pmda_m.pmda201,g_pmda_m.pmda203,g_pmda_m.pmda203_desc, 
       g_pmda_m.pmda207,g_pmda_m.pmda007,g_pmda_m.pmda006,g_pmda_m.pmda004,g_pmda_m.pmda020,g_pmda_m.pmda028, 
       g_pmda_m.pmda027,g_pmda_m.pmda204,g_pmda_m.pmda204_desc,g_pmda_m.pmda205,g_pmda_m.pmda205_desc, 
       g_pmda_m.pmda206,g_pmda_m.pmda206_desc,g_pmda_m.pmda021,g_pmda_m.pmda021_desc,g_pmda_m.pmda208, 
       g_pmda_m.l_amts,g_pmda_m.pmda022,g_pmda_m.pmdaownid,g_pmda_m.pmdaownid_desc,g_pmda_m.pmdaowndp, 
       g_pmda_m.pmdaowndp_desc,g_pmda_m.pmdacrtid,g_pmda_m.pmdacrtid_desc,g_pmda_m.pmdacrtdp,g_pmda_m.pmdacrtdp_desc, 
       g_pmda_m.pmdacrtdt,g_pmda_m.pmdamodid,g_pmda_m.pmdamodid_desc,g_pmda_m.pmdamoddt,g_pmda_m.pmdacnfid, 
       g_pmda_m.pmdacnfid_desc,g_pmda_m.pmdacnfdt,g_pmda_m.pmdapstid,g_pmda_m.pmdapstid_desc,g_pmda_m.pmdapstdt 
 
   
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
      
      #end add-point
   END FOR
   
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL apmt830_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="apmt830.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION apmt830_detail_show()
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
 
{<section id="apmt830.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION apmt830_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE pmda_t.pmdadocno 
   DEFINE l_oldno     LIKE pmda_t.pmdadocno 
 
   DEFINE l_master    RECORD LIKE pmda_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE pmdb_t.* #此變數樣板目前無使用
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   DEFINE l_success     LIKE type_t.num5 
   DEFINE r_insert      LIKE type_t.num5 
   #end add-point   
   
   #add-point:Function前置處理  name="reproduce.pre_function"
   #161220-00059#2 -s by 08172
   LET g_pmda_m.pmda027 = ''    
   LET g_pmda_m.pmda028 = ''  
   #161220-00059#2 -e by 08172
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
   #要貨組織
   CALL s_aooi500_default(g_prog,'pmdasite',g_pmda_m.pmdasite) RETURNING r_insert,g_pmda_m.pmdasite
   IF NOT r_insert THEN
      RETURN 
   END IF
   CALL s_desc_get_department_desc(g_pmda_m.pmdasite) RETURNING g_pmda_m.pmdasite_desc
   DISPLAY BY NAME g_pmda_m.pmdasite_desc
   
   #要貨單別
   CALL s_arti200_get_def_doc_type(g_pmda_m.pmdasite,g_prog,'1') RETURNING l_success,g_pmda_m.pmdadocno
   DISPLAY BY NAME g_pmda_m.pmdadocno
   
   #單據日期
   LET g_pmda_m.pmdadocdt = g_today
   
   #申請人員
   LET g_pmda_m.pmda002 = g_user
   CALL s_desc_get_person_desc(g_pmda_m.pmda002) RETURNING g_pmda_m.pmda002_desc
   DISPLAY BY NAME g_pmda_m.pmda002_desc      
   
   #申請部門
   LET g_pmda_m.pmda003 = g_dept
   CALL s_desc_get_department_desc(g_pmda_m.pmda003) RETURNING g_pmda_m.pmda003_desc
   DISPLAY BY NAME g_pmda_m.pmda003_desc  
   
   #費用部門(畫面隱藏)
   LET g_pmda_m.pmda007 = g_pmda_m.pmda003
   
   #預算控管否(畫面隱藏)
   LET g_pmda_m.pmda006 = 'N'
   
   #單價為必要輸入(畫面隱藏)
   LET g_pmda_m.pmda004 = 'N'
   
   #納入 MPS/MRP計算(畫面隱藏)
   LET g_pmda_m.pmda020 = 'Y' 
   
   
   LET g_pmda_m.pmda001 = 0 #150420-00003#1 Add By Ken 150421
   
   LET g_pmda_m.pmda200 = '0'   #160623-00029#1 160624 by sakua add
   
   LET g_site_flag = FALSE
   LET g_pmda_m_t.* = g_pmda_m.*  #備份舊值   
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
   
   
   CALL apmt830_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_pmda_m.* TO NULL
      INITIALIZE g_pmdb_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL apmt830_show()
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
   CALL apmt830_set_act_visible()   
   CALL apmt830_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_pmdadocno_t = g_pmda_m.pmdadocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " pmdaent = " ||g_enterprise|| " AND",
                      " pmdadocno = '", g_pmda_m.pmdadocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL apmt830_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL apmt830_idx_chk()
   
   LET g_data_owner = g_pmda_m.pmdaownid      
   LET g_data_dept  = g_pmda_m.pmdaowndp
   
   #功能已完成,通報訊息中心
   CALL apmt830_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="apmt830.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION apmt830_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE pmdb_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
 
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE apmt830_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM pmdb_t
    WHERE pmdbent = g_enterprise AND pmdbdocno = g_pmdadocno_t
 
    INTO TEMP apmt830_detail
 
   #將key修正為調整後   
   UPDATE apmt830_detail 
      #更新key欄位
      SET pmdbdocno = g_pmda_m.pmdadocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   #150401-00002#1 Add By Ken 150413      
   UPDATE apmt830_detail 
      SET pmdb049 = 0, pmdb032 = '1',
          pmdb001 = null, pmdb002 = null , pmdb003 = null   #160623-00029#1 160624 by sakua add
    WHERE pmdbent = g_enterprise
      AND pmdbdocno = g_pmda_m.pmdadocno
   #150401-00002#1   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO pmdb_t SELECT * FROM apmt830_detail
   
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
   DROP TABLE apmt830_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_pmdadocno_t = g_pmda_m.pmdadocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="apmt830.delete" >}
#+ 資料刪除
PRIVATE FUNCTION apmt830_delete()
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
 
   OPEN apmt830_cl USING g_enterprise,g_pmda_m.pmdadocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN apmt830_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE apmt830_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE apmt830_master_referesh USING g_pmda_m.pmdadocno INTO g_pmda_m.pmdasite,g_pmda_m.pmda200, 
       g_pmda_m.pmdadocdt,g_pmda_m.pmdadocno,g_pmda_m.pmda001,g_pmda_m.pmda002,g_pmda_m.pmda003,g_pmda_m.pmdastus, 
       g_pmda_m.pmda202,g_pmda_m.pmda201,g_pmda_m.pmda203,g_pmda_m.pmda207,g_pmda_m.pmda007,g_pmda_m.pmda006, 
       g_pmda_m.pmda004,g_pmda_m.pmda020,g_pmda_m.pmda028,g_pmda_m.pmda027,g_pmda_m.pmda204,g_pmda_m.pmda205, 
       g_pmda_m.pmda206,g_pmda_m.pmda021,g_pmda_m.pmda208,g_pmda_m.pmda022,g_pmda_m.pmdaownid,g_pmda_m.pmdaowndp, 
       g_pmda_m.pmdacrtid,g_pmda_m.pmdacrtdp,g_pmda_m.pmdacrtdt,g_pmda_m.pmdamodid,g_pmda_m.pmdamoddt, 
       g_pmda_m.pmdacnfid,g_pmda_m.pmdacnfdt,g_pmda_m.pmdapstid,g_pmda_m.pmdapstdt,g_pmda_m.pmdasite_desc, 
       g_pmda_m.pmda002_desc,g_pmda_m.pmda003_desc,g_pmda_m.pmda202_desc,g_pmda_m.pmda203_desc,g_pmda_m.pmda204_desc, 
       g_pmda_m.pmda205_desc,g_pmda_m.pmda206_desc,g_pmda_m.pmda021_desc,g_pmda_m.pmdaownid_desc,g_pmda_m.pmdaowndp_desc, 
       g_pmda_m.pmdacrtid_desc,g_pmda_m.pmdacrtdp_desc,g_pmda_m.pmdamodid_desc,g_pmda_m.pmdacnfid_desc, 
       g_pmda_m.pmdapstid_desc
   
   
   #檢查是否允許此動作
   IF NOT apmt830_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_pmda_m_mask_o.* =  g_pmda_m.*
   CALL apmt830_pmda_t_mask()
   LET g_pmda_m_mask_n.* =  g_pmda_m.*
   
   CALL apmt830_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   #161220-00059#2 -s by 08172
   IF NOT cl_null(g_pmda_m.pmda027) THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "apm-01147" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   #161220-00059#2 -e by 08172
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL apmt830_set_pk_array()
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
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
      
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
      
      #end add-point
      
            
                                                               
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_pmda_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE apmt830_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_pmdb_d.clear() 
 
     
      CALL apmt830_ui_browser_refresh()  
      #CALL apmt830_ui_headershow()  
      #CALL apmt830_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL apmt830_browser_fill("")
         CALL apmt830_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE apmt830_cl
 
   #功能已完成,通報訊息中心
   CALL apmt830_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="apmt830.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION apmt830_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_success     LIKE type_t.num5
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_pmdb_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF apmt830_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT pmdbseq,pmdb001,pmdb002,pmdb003,pmdbsite,pmdb200,pmdb004,pmdb005, 
             pmdb033,pmdb037,pmdb260,pmdb038,pmdb227,pmdb201,pmdb202,pmdb212,pmdb007,pmdb213,pmdb261, 
             pmdb006,pmdb253,pmdb258,pmdb254,pmdb255,pmdb256,pmdb257,pmdb259,pmdb252,pmdb207,pmdb015, 
             pmdb049,pmdb030,pmdb048,pmdb208,pmdb209,pmdb206,pmdb210,pmdb211,pmdb205,pmdb203,pmdb204, 
             pmdb032,pmdb051 ,t1.ooefl003 ,t2.imaal003 ,t3.imaal004 ,t6.ooefl003 ,t7.ooefl003 ,t8.inayl003 , 
             t9.oocal003 ,t10.oocal003 ,t11.pmaal004 ,t12.oocql004 ,t13.staal003 ,t14.ooag011 ,t15.ooefl003 , 
             t16.ooefl003 ,t17.inayl003 ,t18.oocql004 FROM pmdb_t",   
                     " INNER JOIN pmda_t ON pmdaent = " ||g_enterprise|| " AND pmdadocno = pmdbdocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=pmdbsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t2 ON t2.imaalent="||g_enterprise||" AND t2.imaal001=pmdb004 AND t2.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t3 ON t3.imaalent="||g_enterprise||" AND t3.imaal001=pmdb004 AND t3.imaal002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent="||g_enterprise||" AND t6.ooefl001=pmdb037 AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t7 ON t7.ooeflent="||g_enterprise||" AND t7.ooefl001=pmdb260 AND t7.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN inayl_t t8 ON t8.inaylent="||g_enterprise||" AND t8.inayl001=pmdb038 AND t8.inayl002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t9 ON t9.oocalent="||g_enterprise||" AND t9.oocal001=pmdb201 AND t9.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t10 ON t10.oocalent="||g_enterprise||" AND t10.oocal001=pmdb007 AND t10.oocal002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t11 ON t11.pmaalent="||g_enterprise||" AND t11.pmaal001=pmdb015 AND t11.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t12 ON t12.oocqlent="||g_enterprise||" AND t12.oocql001='274' AND t12.oocql002=pmdb048 AND t12.oocql002='"||g_dlang||"' ",
               " LEFT JOIN staal_t t13 ON t13.staalent="||g_enterprise||" AND t13.staal001=pmdb209 AND t13.staal002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t14 ON t14.ooagent="||g_enterprise||" AND t14.ooag001=pmdb206  ",
               " LEFT JOIN ooefl_t t15 ON t15.ooeflent="||g_enterprise||" AND t15.ooefl001=pmdb205 AND t15.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t16 ON t16.ooeflent="||g_enterprise||" AND t16.ooefl001=pmdb203 AND t16.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN inayl_t t17 ON t17.inaylent="||g_enterprise||" AND t17.inayl001=pmdb204 AND t17.inayl002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t18 ON t18.oocqlent="||g_enterprise||" AND t18.oocql001='265' AND t18.oocql002=pmdb051 AND t18.oocql003='"||g_dlang||"' ",
 
                     " WHERE pmdbent=? AND pmdbdocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         ##161214-00004#3 add by sunxh 161220(S)  #161220-00059#2 add pmdb261 by 08172
         LET g_sql = "SELECT  DISTINCT pmdbseq,pmdb001,pmdb002,pmdb003,pmdbsite,pmdb200,pmdb004,pmdb005, 
             pmdb033,pmdb037,pmdb260,pmdb038,pmdb227,pmdb201,pmdb202,pmdb212,pmdb007,pmdb213,pmdb261,pmdb006, 
             pmdb253,pmdb258,pmdb254,pmdb255,pmdb256,pmdb257,pmdb259,pmdb252,pmdb207,pmdb015,pmdb049, 
             pmdb030,pmdb048,pmdb208,pmdb209,pmdb206,pmdb210,pmdb211,pmdb205,pmdb203,pmdb204,pmdb032, 
             pmdb051 ,t1.ooefl003 ,t2.imaal003 ,t3.imaal004 ,t7.ooefl003 ,t8.ooefl003 ,t9.inayl003 , 
             t10.oocal003 ,t11.oocal003 ,t12.pmaal004 ,t13.oocql004 ,t14.staal003 ,t15.ooag011 ,t16.ooefl003 , 
             t17.ooefl003 ,t18.inayl003 ,t19.oocql004 FROM pmdb_t",   
                     " INNER JOIN pmda_t ON pmdaent = " ||g_enterprise|| " AND pmdadocno = pmdbdocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
               " LEFT JOIN imaa_t ON imaaent = pmdaent AND IMAA001 = PMDB004 ", "  ",
               " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=pmdbsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t2 ON t2.imaalent="||g_enterprise||" AND t2.imaal001=pmdb004 AND t2.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t3 ON t3.imaalent="||g_enterprise||" AND t3.imaal001=pmdb004 AND t3.imaal002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t7 ON t7.ooeflent="||g_enterprise||" AND t7.ooefl001=pmdb037 AND t7.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t8 ON t8.ooeflent="||g_enterprise||" AND t8.ooefl001=pmdb260 AND t8.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN inayl_t t9 ON t9.inaylent="||g_enterprise||" AND t9.inayl001=pmdb038 AND t9.inayl002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t10 ON t10.oocalent="||g_enterprise||" AND t10.oocal001=pmdb201 AND t10.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t11 ON t11.oocalent="||g_enterprise||" AND t11.oocal001=pmdb007 AND t11.oocal002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t12 ON t12.pmaalent="||g_enterprise||" AND t12.pmaal001=pmdb015 AND t12.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t13 ON t13.oocqlent="||g_enterprise||" AND t13.oocql001='274' AND t13.oocql002=pmdb048 AND t13.oocql002='"||g_dlang||"' ",
               " LEFT JOIN staal_t t14 ON t14.staalent="||g_enterprise||" AND t14.staal001=pmdb209 AND t14.staal002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t15 ON t15.ooagent="||g_enterprise||" AND t15.ooag001=pmdb206  ",
               " LEFT JOIN ooefl_t t16 ON t16.ooeflent="||g_enterprise||" AND t16.ooefl001=pmdb205 AND t16.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t17 ON t17.ooeflent="||g_enterprise||" AND t17.ooefl001=pmdb203 AND t17.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN inayl_t t18 ON t18.inaylent="||g_enterprise||" AND t18.inayl001=pmdb204 AND t18.inayl002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t19 ON t19.oocqlent="||g_enterprise||" AND t19.oocql001='265' AND t19.oocql002=pmdb051 AND t19.oocql003='"||g_dlang||"' ",
 
                     " WHERE pmdbent=? AND pmdbdocno=?"
         #161214-00004#3 add by sunxh 161220(E)            
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY pmdb_t.pmdbseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE apmt830_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR apmt830_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_pmda_m.pmdadocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_pmda_m.pmdadocno INTO g_pmdb_d[l_ac].pmdbseq,g_pmdb_d[l_ac].pmdb001, 
          g_pmdb_d[l_ac].pmdb002,g_pmdb_d[l_ac].pmdb003,g_pmdb_d[l_ac].pmdbsite,g_pmdb_d[l_ac].pmdb200, 
          g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb005,g_pmdb_d[l_ac].pmdb033,g_pmdb_d[l_ac].pmdb037, 
          g_pmdb_d[l_ac].pmdb260,g_pmdb_d[l_ac].pmdb038,g_pmdb_d[l_ac].pmdb227,g_pmdb_d[l_ac].pmdb201, 
          g_pmdb_d[l_ac].pmdb202,g_pmdb_d[l_ac].pmdb212,g_pmdb_d[l_ac].pmdb007,g_pmdb_d[l_ac].pmdb213, 
          g_pmdb_d[l_ac].pmdb261,g_pmdb_d[l_ac].pmdb006,g_pmdb_d[l_ac].pmdb253,g_pmdb_d[l_ac].pmdb258, 
          g_pmdb_d[l_ac].pmdb254,g_pmdb_d[l_ac].pmdb255,g_pmdb_d[l_ac].pmdb256,g_pmdb_d[l_ac].pmdb257, 
          g_pmdb_d[l_ac].pmdb259,g_pmdb_d[l_ac].pmdb252,g_pmdb_d[l_ac].pmdb207,g_pmdb_d[l_ac].pmdb015, 
          g_pmdb_d[l_ac].pmdb049,g_pmdb_d[l_ac].pmdb030,g_pmdb_d[l_ac].pmdb048,g_pmdb_d[l_ac].pmdb208, 
          g_pmdb_d[l_ac].pmdb209,g_pmdb_d[l_ac].pmdb206,g_pmdb_d[l_ac].pmdb210,g_pmdb_d[l_ac].pmdb211, 
          g_pmdb_d[l_ac].pmdb205,g_pmdb_d[l_ac].pmdb203,g_pmdb_d[l_ac].pmdb204,g_pmdb_d[l_ac].pmdb032, 
          g_pmdb_d[l_ac].pmdb051,g_pmdb_d[l_ac].pmdbsite_desc,g_pmdb_d[l_ac].pmdb004_desc,g_pmdb_d[l_ac].pmdb004_desc_desc, 
          g_pmdb_d[l_ac].pmdb037_desc,g_pmdb_d[l_ac].pmdb260_desc,g_pmdb_d[l_ac].pmdb038_desc,g_pmdb_d[l_ac].pmdb201_desc, 
          g_pmdb_d[l_ac].pmdb007_desc,g_pmdb_d[l_ac].pmdb015_desc,g_pmdb_d[l_ac].pmdb048_desc,g_pmdb_d[l_ac].pmdb209_desc, 
          g_pmdb_d[l_ac].pmdb206_desc,g_pmdb_d[l_ac].pmdb205_desc,g_pmdb_d[l_ac].pmdb203_desc,g_pmdb_d[l_ac].pmdb204_desc, 
          g_pmdb_d[l_ac].pmdb051_desc   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill.fill"
         ##產品特徵說明
         CALL s_feature_description(g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb005) 
            RETURNING l_success,g_pmdb_d[l_ac].pmdb005_desc
         
         ##品名、規格
         #CALL s_desc_get_item_desc(g_pmdb_d[l_ac].pmdb004) RETURNING g_pmdb_d[l_ac].pmdb004_desc,g_pmdb_d[l_ac].pmdb004_desc_desc 
         #DISPLAY BY NAME g_pmdb_d[l_ac].pmdb004_desc,g_pmdb_d[l_ac].pmdb004_desc_desc  
         
         #品類編號
         CALL apmt830_get_imaa009(g_pmdb_d[l_ac].pmdb004) 
            RETURNING g_pmdb_d[l_ac].imaa009
         
         #品類說明
         CALL s_desc_get_rtaxl003_desc(g_pmdb_d[l_ac].imaa009) 
            RETURNING g_pmdb_d[l_ac].imaa009_desc
         
         #要貨單位說明
         CALL s_desc_get_unit_desc(g_pmdb_d[l_ac].pmdb007) 
            RETURNING g_pmdb_d[l_ac].pmdb007_desc
         
         #包裝單位說明
         CALL s_desc_get_unit_desc(g_pmdb_d[l_ac].pmdb201) 
            RETURNING g_pmdb_d[l_ac].pmdb201_desc 
         
         #收貨時段說明
         CALL s_desc_get_acc_desc('274',g_pmdb_d[l_ac].pmdb048) 
            RETURNING g_pmdb_d[l_ac].pmdb048_desc  
         
         #採購員全名
         CALL s_desc_get_person_desc(g_pmdb_d[l_ac].pmdb206) 
            RETURNING g_pmdb_d[l_ac].pmdb206_desc
         
         #結案理由碼說明
         CALL s_desc_get_acc_desc('258',g_pmdb_d[l_ac].pmdb051) 
            RETURNING g_pmdb_d[l_ac].pmdb051_desc
         
        #Add By baogc 20151104 Begin ---
         #参考金额
         LET g_pmdb_d[l_ac].l_amtr = g_pmdb_d[l_ac].pmdb213 * g_pmdb_d[l_ac].pmdb006
         #Add By baogc 20151104 End   ---
         #170116-00018#1 -s mark by 08172
         #add by geza 20161029 #161027-00055#2(S)
#         IF g_pmdb_d[l_ac].pmdb004 IS NOT NULL AND g_pmdb_d[l_ac].pmdb005 IS NOT NULL AND g_pmdb_d[l_ac].pmdb203 IS NOT NULL THEN
#            #CALL apmt830_pmdb215_count(g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb203,g_pmdb_d[l_ac].pmdb005) RETURNING g_pmdb_d[l_ac].l_pmdb252 #mark by geza 20161209 161124-00039#1
#            CALL apmt830_pmdb215_count(g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb203,g_pmdb_d[l_ac].pmdb005,'',g_pmdb_d[l_ac].pmdbsite) RETURNING g_pmdb_d[l_ac].l_pmdb252 #add by geza 20161209 161124-00039#1
#         ELSE
#            LET g_pmdb_d[l_ac].l_pmdb252 = 0           
#         END IF   
         #add by geza 20161029 #161027-00055#2(E)
         #170116-00018#1 -e mark by 08172
         #170116-00018#1 -s add by 08172
         IF g_pmdb_d[l_ac].pmdb004 IS NOT NULL AND g_pmdb_d[l_ac].pmdb005 IS NOT NULL AND  g_pmdb_d[l_ac].pmdb007 IS NOT NULL
            AND g_pmdb_d[l_ac].pmdb203 IS NOT NULL AND g_pmdb_d[l_ac].pmdb204 IS NOT NULL THEN
            CALL apmt830_inas011_count(g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb005,g_pmdb_d[l_ac].pmdb007,g_pmdb_d[l_ac].pmdb203,g_pmdb_d[l_ac].pmdb204)   
                 RETURNING g_pmdb_d[l_ac].l_pmdb252               
         ELSE 
            LET g_pmdb_d[l_ac].l_pmdb252 = ''
         END IF
         #170116-00018#1 -e add by 08172
         #No:161030----------------begin      #add by stcshy 161030
         CALL apmt830_get_imaa(g_pmdb_d[l_ac].pmdb004)
            #161214-00004#3 mod by sunxh 161221(S) #修改大类
            RETURNING g_pmdb_d[l_ac].imaa154,g_pmdb_d[l_ac].imaa155,g_pmdb_d[l_ac].imaa156,g_pmdb_d[l_ac].imaa132,g_pmdb_d[l_ac].rtaw001,g_pmdb_d[l_ac].imaa116
            #161214-00004#3 mod by sunxh 161221(S)
            #161129-00067#2 -s by 08172                     
#            RETURNING g_pmdb_d[l_ac].imaa154,g_pmdb_d[l_ac].imaa155,g_pmdb_d[l_ac].imaa156,g_pmdb_d[l_ac].imaa132,g_pmdb_d[l_ac].imaa128,g_pmdb_d[l_ac].imaa116
#            RETURNING g_pmdb_d[l_ac].imaa154,g_pmdb_d[l_ac].imaa155,g_pmdb_d[l_ac].imaa156,g_pmdb_d[l_ac].imaa132,g_pmdb_d[l_ac].imaa128,g_pmdb_d[l_ac].imaa157
            #161129-00067#2 -e by 08172
         #161214-00004#3 161221 by sunxh(S)
         CALL s_desc_get_rtaxl003_desc(g_pmdb_d[l_ac].rtaw001) RETURNING g_pmdb_d[l_ac].imaa128_desc
         #161214-00004#3 161221 by sunxh(E)         
#         CALL s_desc_get_acc_desc('2004',g_pmdb_d[l_ac].imaa128) RETURNING g_pmdb_d[l_ac].imaa128_desc
         CALL s_desc_get_acc_desc('2006',g_pmdb_d[l_ac].imaa132) RETURNING g_pmdb_d[l_ac].imaa132_desc
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
    
 
   
   #add-point:browser_fill段其他table處理 name="browser_fill.other_fill"
 
   #end add-point
   
   CALL g_pmdb_d.deleteElement(g_pmdb_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE apmt830_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_pmdb_d.getLength()
      LET g_pmdb_d_mask_o[l_ac].* =  g_pmdb_d[l_ac].*
      CALL apmt830_pmdb_t_mask()
      LET g_pmdb_d_mask_n[l_ac].* =  g_pmdb_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="apmt830.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION apmt830_delete_b(ps_table,ps_keys_bak,ps_page)
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
 
   END IF
   
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
 
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="apmt830.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION apmt830_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO pmdb_t
                  (pmdbent,
                   pmdbdocno,
                   pmdbseq
                   ,pmdb001,pmdb002,pmdb003,pmdbsite,pmdb200,pmdb004,pmdb005,pmdb033,pmdb037,pmdb260,pmdb038,pmdb227,pmdb201,pmdb202,pmdb212,pmdb007,pmdb213,pmdb261,pmdb006,pmdb253,pmdb258,pmdb254,pmdb255,pmdb256,pmdb257,pmdb259,pmdb252,pmdb207,pmdb015,pmdb049,pmdb030,pmdb048,pmdb208,pmdb209,pmdb206,pmdb210,pmdb211,pmdb205,pmdb203,pmdb204,pmdb032,pmdb051) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_pmdb_d[g_detail_idx].pmdb001,g_pmdb_d[g_detail_idx].pmdb002,g_pmdb_d[g_detail_idx].pmdb003, 
                       g_pmdb_d[g_detail_idx].pmdbsite,g_pmdb_d[g_detail_idx].pmdb200,g_pmdb_d[g_detail_idx].pmdb004, 
                       g_pmdb_d[g_detail_idx].pmdb005,g_pmdb_d[g_detail_idx].pmdb033,g_pmdb_d[g_detail_idx].pmdb037, 
                       g_pmdb_d[g_detail_idx].pmdb260,g_pmdb_d[g_detail_idx].pmdb038,g_pmdb_d[g_detail_idx].pmdb227, 
                       g_pmdb_d[g_detail_idx].pmdb201,g_pmdb_d[g_detail_idx].pmdb202,g_pmdb_d[g_detail_idx].pmdb212, 
                       g_pmdb_d[g_detail_idx].pmdb007,g_pmdb_d[g_detail_idx].pmdb213,g_pmdb_d[g_detail_idx].pmdb261, 
                       g_pmdb_d[g_detail_idx].pmdb006,g_pmdb_d[g_detail_idx].pmdb253,g_pmdb_d[g_detail_idx].pmdb258, 
                       g_pmdb_d[g_detail_idx].pmdb254,g_pmdb_d[g_detail_idx].pmdb255,g_pmdb_d[g_detail_idx].pmdb256, 
                       g_pmdb_d[g_detail_idx].pmdb257,g_pmdb_d[g_detail_idx].pmdb259,g_pmdb_d[g_detail_idx].pmdb252, 
                       g_pmdb_d[g_detail_idx].pmdb207,g_pmdb_d[g_detail_idx].pmdb015,g_pmdb_d[g_detail_idx].pmdb049, 
                       g_pmdb_d[g_detail_idx].pmdb030,g_pmdb_d[g_detail_idx].pmdb048,g_pmdb_d[g_detail_idx].pmdb208, 
                       g_pmdb_d[g_detail_idx].pmdb209,g_pmdb_d[g_detail_idx].pmdb206,g_pmdb_d[g_detail_idx].pmdb210, 
                       g_pmdb_d[g_detail_idx].pmdb211,g_pmdb_d[g_detail_idx].pmdb205,g_pmdb_d[g_detail_idx].pmdb203, 
                       g_pmdb_d[g_detail_idx].pmdb204,g_pmdb_d[g_detail_idx].pmdb032,g_pmdb_d[g_detail_idx].pmdb051) 
 
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
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      UPDATE pmdb_t 
         SET pmdb019 = 0,
             pmdb020 = 0,
             pmdb021 = 0,
             pmdb046 = g_pmda_m.pmda003,
             pmdb250 = 0,
             pmdb251 = 0,
             pmdb044 = 'Y'             
       WHERE pmdbent = g_enterprise AND pmdbdocno = ps_keys[1] AND pmdbseq = ps_keys[2]
       IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "pmdb_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
       END IF
          
      #end add-point 
   END IF
   
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="apmt830.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION apmt830_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "pmdb_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL apmt830_pmdb_t_mask_restore('restore_mask_o')
               
      UPDATE pmdb_t 
         SET (pmdbdocno,
              pmdbseq
              ,pmdb001,pmdb002,pmdb003,pmdbsite,pmdb200,pmdb004,pmdb005,pmdb033,pmdb037,pmdb260,pmdb038,pmdb227,pmdb201,pmdb202,pmdb212,pmdb007,pmdb213,pmdb261,pmdb006,pmdb253,pmdb258,pmdb254,pmdb255,pmdb256,pmdb257,pmdb259,pmdb252,pmdb207,pmdb015,pmdb049,pmdb030,pmdb048,pmdb208,pmdb209,pmdb206,pmdb210,pmdb211,pmdb205,pmdb203,pmdb204,pmdb032,pmdb051) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_pmdb_d[g_detail_idx].pmdb001,g_pmdb_d[g_detail_idx].pmdb002,g_pmdb_d[g_detail_idx].pmdb003, 
                  g_pmdb_d[g_detail_idx].pmdbsite,g_pmdb_d[g_detail_idx].pmdb200,g_pmdb_d[g_detail_idx].pmdb004, 
                  g_pmdb_d[g_detail_idx].pmdb005,g_pmdb_d[g_detail_idx].pmdb033,g_pmdb_d[g_detail_idx].pmdb037, 
                  g_pmdb_d[g_detail_idx].pmdb260,g_pmdb_d[g_detail_idx].pmdb038,g_pmdb_d[g_detail_idx].pmdb227, 
                  g_pmdb_d[g_detail_idx].pmdb201,g_pmdb_d[g_detail_idx].pmdb202,g_pmdb_d[g_detail_idx].pmdb212, 
                  g_pmdb_d[g_detail_idx].pmdb007,g_pmdb_d[g_detail_idx].pmdb213,g_pmdb_d[g_detail_idx].pmdb261, 
                  g_pmdb_d[g_detail_idx].pmdb006,g_pmdb_d[g_detail_idx].pmdb253,g_pmdb_d[g_detail_idx].pmdb258, 
                  g_pmdb_d[g_detail_idx].pmdb254,g_pmdb_d[g_detail_idx].pmdb255,g_pmdb_d[g_detail_idx].pmdb256, 
                  g_pmdb_d[g_detail_idx].pmdb257,g_pmdb_d[g_detail_idx].pmdb259,g_pmdb_d[g_detail_idx].pmdb252, 
                  g_pmdb_d[g_detail_idx].pmdb207,g_pmdb_d[g_detail_idx].pmdb015,g_pmdb_d[g_detail_idx].pmdb049, 
                  g_pmdb_d[g_detail_idx].pmdb030,g_pmdb_d[g_detail_idx].pmdb048,g_pmdb_d[g_detail_idx].pmdb208, 
                  g_pmdb_d[g_detail_idx].pmdb209,g_pmdb_d[g_detail_idx].pmdb206,g_pmdb_d[g_detail_idx].pmdb210, 
                  g_pmdb_d[g_detail_idx].pmdb211,g_pmdb_d[g_detail_idx].pmdb205,g_pmdb_d[g_detail_idx].pmdb203, 
                  g_pmdb_d[g_detail_idx].pmdb204,g_pmdb_d[g_detail_idx].pmdb032,g_pmdb_d[g_detail_idx].pmdb051)  
 
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
      CALL apmt830_pmdb_t_mask_restore('restore_mask_n')
               
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
 
{<section id="apmt830.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION apmt830_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="apmt830.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION apmt830_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="apmt830.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION apmt830_lock_b(ps_table,ps_page)
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
   #CALL apmt830_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "pmdb_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN apmt830_bcl USING g_enterprise,
                                       g_pmda_m.pmdadocno,g_pmdb_d[g_detail_idx].pmdbseq     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "apmt830_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
                                    
 
   
 
   
   #add-point:lock_b段other name="lock_b.other"
   #150324-00006#14 2015/04/09 By pomelo add(S)
   LET ls_group = "pmdb_t1"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN apmt830_upd_pmdb033 USING g_enterprise,g_pmda_m.pmdadocno,g_pmdb_d[g_detail_idx].pmdbseq     
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "apmt830_upd_pmdb033" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
   #150324-00006#14 2015/04/09 By pomelo add(E)
   #end add-point  
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="apmt830.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION apmt830_unlock_b(ps_table,ps_page)
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
      CLOSE apmt830_bcl
   END IF
   
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   #150324-00006#14 2015/04/09 By pomelo add(S)
   LET ls_group = "'1',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE apmt830_upd_pmdb033
   END IF
   #150324-00006#14 2015/04/09 By pomelo add(E)
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="apmt830.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION apmt830_set_entry(p_cmd)
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
      CALL cl_set_comp_entry("pmdadocdt",TRUE) 
      CALL cl_set_comp_entry("pmdasite",TRUE) 
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   IF g_pmdb_d.getLength() = 0 THEN
      CALL cl_set_comp_entry("pmda202,pmda201,pmda203,pmda204,pmda205,pmda206",TRUE)
   END IF   
   CALL cl_set_comp_entry("pmda206",TRUE)
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="apmt830.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION apmt830_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
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
      CALL cl_set_comp_entry("pmdadocdt",FALSE)  
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
   IF g_pmdb_d.getLength() > 0 THEN
      CALL cl_set_comp_entry("pmda202,pmda201,pmda203,pmda204,pmda205,pmda206",FALSE)
   END IF

   IF NOT s_aooi500_comp_entry(g_prog,'pmdasite') OR g_site_flag THEN
      CALL cl_set_comp_entry("pmdasite",FALSE)
   END IF
   
   IF cl_null(g_pmda_m.pmda205) THEN
      CALL cl_set_comp_entry("pmda206",FALSE)
   END IF
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="apmt830.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION apmt830_set_entry_b(p_cmd)
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
   IF cl_null(g_pmda_m.pmda203) THEN
      CALL cl_set_comp_entry("pmdbsite",TRUE)
   END IF
   IF cl_null(g_pmda_m.pmda206) THEN
      CALL cl_set_comp_entry("pmdb204",TRUE)
   END IF

   CALL cl_set_comp_entry("pmdb212",TRUE)   #ken
   CALL cl_set_comp_entry("pmdb005",TRUE)   #產品特徵 ken
   
   #150324-00006#14 2015/04/09 By pomelo add(S)
   IF g_action_choice = 'upd_pmdb033' THEN
      CALL cl_set_comp_entry("pmdbseq",TRUE)     #項次
      CALL cl_set_comp_entry("pmdbsite",TRUE)    #要貨組織
      CALL cl_set_comp_entry("pmdb200",TRUE)     #商品條碼
      CALL cl_set_comp_entry("pmdb004",TRUE)     #商品編號
      CALL cl_set_comp_entry("pmdb005",TRUE)     #產品特徵
      CALL cl_set_comp_entry("pmdb037",TRUE)     #收貨組織
      CALL cl_set_comp_entry("pmdb260",TRUE)     #收貨部門
      CALL cl_set_comp_entry("pmdb038",TRUE)     #庫位
      CALL cl_set_comp_entry("pmdb212",TRUE)     #包裝數量
      CALL cl_set_comp_entry("pmdb007",TRUE)     #要貨單位
      CALL cl_set_comp_entry("pmdb006",TRUE)     #要貨數量
      CALL cl_set_comp_entry("pmdb030",TRUE)     #需求數量
      CALL cl_set_comp_entry("pmdb048",TRUE)     #收貨時段
      CALL cl_set_comp_entry("pmdb210",TRUE)     #促銷開始日
      CALL cl_set_comp_entry("pmdb211",TRUE)     #促銷結束日
      CALL cl_set_comp_entry("pmdb204",TRUE)     #配送倉庫
      CALL cl_set_comp_entry("pmdb051",TRUE)     #結案/留置原因碼
      CALL cl_set_comp_entry("pmdb033",TRUE)     #緊急度
   END IF
   #150324-00006#14 2015/04/09 By pomelo add(E)
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="apmt830.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION apmt830_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define(客製用) name="set_no_entry_b.define_customerization"
   
   #end add-point    
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   DEFINE l_imaa005   LIKE inaa_t.inaa005 #ken---add
   #end add-point    
   
   #add-point:Function前置處理  name="set_no_entry_b.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("",FALSE)
      #add-point:set_no_entry_b段欄位控制 name="set_no_entry_b.field_control"
      
      #end add-point 
   END IF 
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b"
   IF NOT cl_null(g_pmda_m.pmda203) THEN
      CALL cl_set_comp_entry("pmdbsite",FALSE)
   END IF
   IF NOT cl_null(g_pmda_m.pmda206) THEN
      CALL cl_set_comp_entry("pmdb204",FALSE)
   END IF
  
   IF NOT cl_null(g_pmdb_d[l_ac].pmdb006)  THEN
     CALL cl_set_comp_entry("pmdb212",FALSE)
   END IF
   #ken---add---s
   #料件不使用產品特徵時，產品特徵欄位不可錄入
   LET l_imaa005 = ''
   CALL apmt830_get_imaa005(g_pmdb_d[l_ac].pmdb004) RETURNING l_imaa005
   IF cl_null(l_imaa005) THEN
      CALL cl_set_comp_entry("pmdb005",FALSE)
      LET g_pmdb_d[l_ac].pmdb005 = ' '
   END IF
   #ken---add---e   
   #150324-00006#14 2015/04/09 By pomelo add(S)
   IF g_action_choice = 'upd_pmdb033' THEN
      CALL cl_set_comp_entry("pmdbseq",FALSE)     #項次
      CALL cl_set_comp_entry("pmdbsite",FALSE)    #要貨組織
      CALL cl_set_comp_entry("pmdb200",FALSE)     #商品條碼
      CALL cl_set_comp_entry("pmdb004",FALSE)     #商品編號
      CALL cl_set_comp_entry("pmdb005",FALSE)     #產品特徵
      CALL cl_set_comp_entry("pmdb037",FALSE)     #收貨組織
      CALL cl_set_comp_entry("pmdb260",FALSE)     #收貨部門
      CALL cl_set_comp_entry("pmdb038",FALSE)     #庫位
      CALL cl_set_comp_entry("pmdb212",FALSE)     #包裝數量
      CALL cl_set_comp_entry("pmdb007",FALSE)     #要貨單位
      CALL cl_set_comp_entry("pmdb006",FALSE)     #要貨數量
      CALL cl_set_comp_entry("pmdb030",FALSE)     #需求數量
      CALL cl_set_comp_entry("pmdb048",FALSE)     #收貨時段
      CALL cl_set_comp_entry("pmdb210",FALSE)     #促銷開始日
      CALL cl_set_comp_entry("pmdb211",FALSE)     #促銷結束日
      CALL cl_set_comp_entry("pmdb204",FALSE)     #配送倉庫
      CALL cl_set_comp_entry("pmdb051",FALSE)     #結案/留置原因碼
   ELSE
      CALL cl_set_comp_entry("pmdb033",FALSE)     #緊急度
   END IF
   #150324-00006#14 2015/04/09 By pomelo add(E)
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="apmt830.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION apmt830_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   CALL cl_set_act_visible("open_s_apmp841_2",TRUE)
   CALL cl_set_act_visible("upd_pmdb033",TRUE)      #維護緊急度 150324-00006#14 2015/04/09 By pomelo add
   CALL apmt830_set_act_visible_b()   #150416-00001#1 150818 by sakura add
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="apmt830.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION apmt830_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   DEFINE l_cnt        LIKE type_t.num5   #150324-00006#14 2015/04/09 By pomelo add
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:1)
   IF g_pmda_m.pmdastus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF
   #161220-00059#2 -s by 08172
   IF g_pmda_m.pmdastus = 'TJ' THEN
      CALL cl_set_act_visible("modify,delete,modify_detail", TRUE)     
   END IF
   #161220-00059#2 -e by 08172
   #ken---add---s 需求單號：141009-00031 項次：20
   IF g_pmda_m.pmdastus <> 'Y' THEN   
      CALL cl_set_act_visible("open_s_apmp841_2", FALSE) 
   END IF
   
   IF apmt830_pmdb207_chk() THEN
      CALL cl_set_act_visible("open_s_apmp841_2", FALSE) 
   END IF 
   #ken---add---e
   
   
   #150324-00006#14 2015/04/09 By pomelo add(S)
   LET l_cnt = 0
   SELECT COUNT(pmdbseq) INTO l_cnt
     FROM pmdb_t
    WHERE pmdbent = g_enterprise
      AND pmdbdocno = g_pmda_m.pmdadocno
      AND COALESCE(pmdb032,'-1') = '1' 
   
   #單身沒有行狀態 = 1.一般的資料 或 狀態碼 != N.未確認，不可以維護緊急度
   IF l_cnt = 0 OR g_pmda_m.pmdastus != 'N' THEN
      CALL cl_set_act_visible("upd_pmdb033",FALSE)
   END IF
   #150324-00006#14 2015/04/09 By pomelo add(E)
   CALL apmt830_set_act_no_visible_b()   #150416-00001#1 150818 by sakura add
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="apmt830.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION apmt830_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   CALL cl_set_act_visible("detail_qrystr",TRUE)   #150416-00001#1 150818 by sakura add
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="apmt830.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION apmt830_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   DEFINE l_cnt          LIKE type_t.num5   #150416-00001#1 150818 by sakura add
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   #150416-00001#1 150818 by sakura add(S)
   LET l_cnt = 0
   SELECT COUNT(pmdb001) INTO l_cnt
     FROM pmdb_t
    WHERE pmdbent = g_enterprise
      AND pmdbdocno = g_pmda_m.pmdadocno
   IF l_cnt = 0 THEN
      CALL cl_set_act_visible("detail_qrystr",FALSE)
   END IF
   #150416-00001#1 150818 by sakura add(E)
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="apmt830.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION apmt830_default_search()
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
   
   #end add-point  
 
   IF g_wc.getIndexOf(" 1=2", 1) THEN
      LET g_default = TRUE
   END IF
 
 
END FUNCTION
 
{</section>}
 
{<section id="apmt830.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION apmt830_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_success LIKE type_t.chr5
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
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
   
   OPEN apmt830_cl USING g_enterprise,g_pmda_m.pmdadocno
   IF STATUS THEN
      CLOSE apmt830_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN apmt830_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE apmt830_master_referesh USING g_pmda_m.pmdadocno INTO g_pmda_m.pmdasite,g_pmda_m.pmda200, 
       g_pmda_m.pmdadocdt,g_pmda_m.pmdadocno,g_pmda_m.pmda001,g_pmda_m.pmda002,g_pmda_m.pmda003,g_pmda_m.pmdastus, 
       g_pmda_m.pmda202,g_pmda_m.pmda201,g_pmda_m.pmda203,g_pmda_m.pmda207,g_pmda_m.pmda007,g_pmda_m.pmda006, 
       g_pmda_m.pmda004,g_pmda_m.pmda020,g_pmda_m.pmda028,g_pmda_m.pmda027,g_pmda_m.pmda204,g_pmda_m.pmda205, 
       g_pmda_m.pmda206,g_pmda_m.pmda021,g_pmda_m.pmda208,g_pmda_m.pmda022,g_pmda_m.pmdaownid,g_pmda_m.pmdaowndp, 
       g_pmda_m.pmdacrtid,g_pmda_m.pmdacrtdp,g_pmda_m.pmdacrtdt,g_pmda_m.pmdamodid,g_pmda_m.pmdamoddt, 
       g_pmda_m.pmdacnfid,g_pmda_m.pmdacnfdt,g_pmda_m.pmdapstid,g_pmda_m.pmdapstdt,g_pmda_m.pmdasite_desc, 
       g_pmda_m.pmda002_desc,g_pmda_m.pmda003_desc,g_pmda_m.pmda202_desc,g_pmda_m.pmda203_desc,g_pmda_m.pmda204_desc, 
       g_pmda_m.pmda205_desc,g_pmda_m.pmda206_desc,g_pmda_m.pmda021_desc,g_pmda_m.pmdaownid_desc,g_pmda_m.pmdaowndp_desc, 
       g_pmda_m.pmdacrtid_desc,g_pmda_m.pmdacrtdp_desc,g_pmda_m.pmdamodid_desc,g_pmda_m.pmdacnfid_desc, 
       g_pmda_m.pmdapstid_desc
   
 
   #檢查是否允許此動作
   IF NOT apmt830_action_chk() THEN
      CLOSE apmt830_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_pmda_m.pmdasite,g_pmda_m.pmdasite_desc,g_pmda_m.pmda200,g_pmda_m.pmdadocdt,g_pmda_m.pmdadocno, 
       g_pmda_m.pmda001,g_pmda_m.pmda002,g_pmda_m.pmda002_desc,g_pmda_m.pmda003,g_pmda_m.pmda003_desc, 
       g_pmda_m.pmdastus,g_pmda_m.pmda202,g_pmda_m.pmda202_desc,g_pmda_m.pmda201,g_pmda_m.pmda203,g_pmda_m.pmda203_desc, 
       g_pmda_m.pmda207,g_pmda_m.pmda007,g_pmda_m.pmda006,g_pmda_m.pmda004,g_pmda_m.pmda020,g_pmda_m.pmda028, 
       g_pmda_m.pmda027,g_pmda_m.pmda204,g_pmda_m.pmda204_desc,g_pmda_m.pmda205,g_pmda_m.pmda205_desc, 
       g_pmda_m.pmda206,g_pmda_m.pmda206_desc,g_pmda_m.pmda021,g_pmda_m.pmda021_desc,g_pmda_m.pmda208, 
       g_pmda_m.l_amts,g_pmda_m.pmda022,g_pmda_m.pmdaownid,g_pmda_m.pmdaownid_desc,g_pmda_m.pmdaowndp, 
       g_pmda_m.pmdaowndp_desc,g_pmda_m.pmdacrtid,g_pmda_m.pmdacrtid_desc,g_pmda_m.pmdacrtdp,g_pmda_m.pmdacrtdp_desc, 
       g_pmda_m.pmdacrtdt,g_pmda_m.pmdamodid,g_pmda_m.pmdamodid_desc,g_pmda_m.pmdamoddt,g_pmda_m.pmdacnfid, 
       g_pmda_m.pmdacnfid_desc,g_pmda_m.pmdacnfdt,g_pmda_m.pmdapstid,g_pmda_m.pmdapstid_desc,g_pmda_m.pmdapstdt 
 
 
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
      CALL cl_set_act_visible("signing,withdraw",FALSE)
      CASE g_pmda_m.pmdastus  
         WHEN "N"
            HIDE OPTION "closed"
            HIDE OPTION "approved"
            HIDE OPTION "withdraw"
            HIDE OPTION "rejection"
            HIDE OPTION "signing"
            HIDE OPTION "unhold"
            HIDE OPTION "hold"
            HIDE OPTION "committed"  #161220-00059#2 by 08172
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            IF cl_bpm_chk() THEN
               CALL cl_set_act_visible("signing",TRUE)
               CALL cl_set_act_visible("confirmed",FALSE)
            END IF
         WHEN "R"    #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("committed",TRUE)  #161220-00059#2 by 08172
            CALL cl_set_act_visible("confirmed,unconfirmed,hold",FALSE)
         WHEN "D"    #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("committed",TRUE)  #161220-00059#2 by 08172
            CALL cl_set_act_visible("confirmed,unconfirmed,hold",FALSE)
         WHEN "X"
            CALL s_transaction_end('N','0')   #160816-00068#15
            RETURN
         WHEN "Y"   
            HIDE OPTION "invalid"         
            HIDE OPTION "closed"
            HIDE OPTION "approved"
            HIDE OPTION "withdraw"
            HIDE OPTION "rejection"
            HIDE OPTION "signing"
            HIDE OPTION "unhold"
            HIDE OPTION "hold"
            HIDE OPTION "committed"  #161220-00059#2 by 08172                      
         WHEN "W"    #只能顯示抽單;其餘應用功能皆隱藏
            CALL cl_set_act_visible("withdraw",TRUE)
            CALL cl_set_act_visible("unconfirmed,invalid,confirmed,hold",FALSE)
            CALL cl_set_act_visible("committed",TRUE)  #161220-00059#2 by 08172
         WHEN "A"    #只能顯示確認; 其餘應用功能皆隱藏
            CALL cl_set_act_visible("confirmed",TRUE)
            CALL cl_set_act_visible("unconfirmed,invalid,hold",FALSE)
            CALL cl_set_act_visible("committed",TRUE)  #161220-00059#2 by 08172
         #161220-00059#2 -s by 08172
         WHEN "TJ"
            HIDE OPTION "closed"
            HIDE OPTION "approved"
            HIDE OPTION "withdraw"
            HIDE OPTION "rejection"
            HIDE OPTION "signing"
            HIDE OPTION "unhold"
            HIDE OPTION "hold"
            HIDE OPTION "invalid"
            HIDE OPTION "committed"
         #161220-00059#2 -e by 08172
      END CASE
      #end add-point
      
      #應用 a36 樣板自動產生(Version:5)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT apmt830_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE apmt830_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT apmt830_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE apmt830_cl
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
      CLOSE apmt830_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   LET l_success = TRUE
   CASE lc_state 
      WHEN 'Y'       
         CALL s_apmt830_conf_chk(g_pmda_m.pmdadocno) RETURNING l_success,g_errno
         IF l_success THEN
            IF cl_ask_confirm('aim-00108') THEN
               CALL s_transaction_begin()
               CALL s_apmt830_conf_upd(g_pmda_m.pmdadocno) RETURNING l_success
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_pmda_m.pmdadocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                   CALL s_transaction_end('Y','1')
               END IF
            ELSE
               CALL s_transaction_end('N','0')   #160816-00068#15
               RETURN            
            END IF
         ELSE
            IF NOT cl_null(g_errno) THEN
               INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_pmda_m.pmdadocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

            END IF
            CALL s_transaction_end('N','0')   #160816-00068#15
            RETURN            
         END IF         
      WHEN 'X'
         CALL s_apmt830_void_chk(g_pmda_m.pmdadocno) RETURNING l_success,g_errno
         IF l_success THEN
            IF cl_ask_confirm('lib-016') THEN
               CALL s_transaction_begin()
               CALL s_apmt830_void_upd(g_pmda_m.pmdadocno) RETURNING l_success
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_pmda_m.pmdadocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','1')
               END IF
            ELSE
               CALL s_transaction_end('N','0')   #160816-00068#15
               RETURN
            END IF
         ELSE
            INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_pmda_m.pmdadocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
            CALL s_transaction_end('N','0')   #160816-00068#15
            RETURN    
         END IF
      #ken---add---S 150107-00009#17
      WHEN 'N'  
         CALL s_apmt830_unconf_chk(g_pmda_m.pmdadocno) RETURNING l_success
         IF l_success THEN
            IF cl_ask_confirm('aim-00110') THEN
               CALL s_transaction_begin()
               CALL s_apmt830_unconf_upd(g_pmda_m.pmdadocno) RETURNING l_success
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_pmda_m.pmdadocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','1')
               END IF
            ELSE
               CALL s_transaction_end('N','0')   #160816-00068#15
               RETURN
            END IF
         ELSE
            INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_pmda_m.pmdadocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
            CALL s_transaction_end('N','0')   #160816-00068#15
            RETURN    
         END IF
      #ken---add---E
   END CASE	      
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
      EXECUTE apmt830_master_referesh USING g_pmda_m.pmdadocno INTO g_pmda_m.pmdasite,g_pmda_m.pmda200, 
          g_pmda_m.pmdadocdt,g_pmda_m.pmdadocno,g_pmda_m.pmda001,g_pmda_m.pmda002,g_pmda_m.pmda003,g_pmda_m.pmdastus, 
          g_pmda_m.pmda202,g_pmda_m.pmda201,g_pmda_m.pmda203,g_pmda_m.pmda207,g_pmda_m.pmda007,g_pmda_m.pmda006, 
          g_pmda_m.pmda004,g_pmda_m.pmda020,g_pmda_m.pmda028,g_pmda_m.pmda027,g_pmda_m.pmda204,g_pmda_m.pmda205, 
          g_pmda_m.pmda206,g_pmda_m.pmda021,g_pmda_m.pmda208,g_pmda_m.pmda022,g_pmda_m.pmdaownid,g_pmda_m.pmdaowndp, 
          g_pmda_m.pmdacrtid,g_pmda_m.pmdacrtdp,g_pmda_m.pmdacrtdt,g_pmda_m.pmdamodid,g_pmda_m.pmdamoddt, 
          g_pmda_m.pmdacnfid,g_pmda_m.pmdacnfdt,g_pmda_m.pmdapstid,g_pmda_m.pmdapstdt,g_pmda_m.pmdasite_desc, 
          g_pmda_m.pmda002_desc,g_pmda_m.pmda003_desc,g_pmda_m.pmda202_desc,g_pmda_m.pmda203_desc,g_pmda_m.pmda204_desc, 
          g_pmda_m.pmda205_desc,g_pmda_m.pmda206_desc,g_pmda_m.pmda021_desc,g_pmda_m.pmdaownid_desc, 
          g_pmda_m.pmdaowndp_desc,g_pmda_m.pmdacrtid_desc,g_pmda_m.pmdacrtdp_desc,g_pmda_m.pmdamodid_desc, 
          g_pmda_m.pmdacnfid_desc,g_pmda_m.pmdapstid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_pmda_m.pmdasite,g_pmda_m.pmdasite_desc,g_pmda_m.pmda200,g_pmda_m.pmdadocdt,g_pmda_m.pmdadocno, 
          g_pmda_m.pmda001,g_pmda_m.pmda002,g_pmda_m.pmda002_desc,g_pmda_m.pmda003,g_pmda_m.pmda003_desc, 
          g_pmda_m.pmdastus,g_pmda_m.pmda202,g_pmda_m.pmda202_desc,g_pmda_m.pmda201,g_pmda_m.pmda203, 
          g_pmda_m.pmda203_desc,g_pmda_m.pmda207,g_pmda_m.pmda007,g_pmda_m.pmda006,g_pmda_m.pmda004, 
          g_pmda_m.pmda020,g_pmda_m.pmda028,g_pmda_m.pmda027,g_pmda_m.pmda204,g_pmda_m.pmda204_desc, 
          g_pmda_m.pmda205,g_pmda_m.pmda205_desc,g_pmda_m.pmda206,g_pmda_m.pmda206_desc,g_pmda_m.pmda021, 
          g_pmda_m.pmda021_desc,g_pmda_m.pmda208,g_pmda_m.l_amts,g_pmda_m.pmda022,g_pmda_m.pmdaownid, 
          g_pmda_m.pmdaownid_desc,g_pmda_m.pmdaowndp,g_pmda_m.pmdaowndp_desc,g_pmda_m.pmdacrtid,g_pmda_m.pmdacrtid_desc, 
          g_pmda_m.pmdacrtdp,g_pmda_m.pmdacrtdp_desc,g_pmda_m.pmdacrtdt,g_pmda_m.pmdamodid,g_pmda_m.pmdamodid_desc, 
          g_pmda_m.pmdamoddt,g_pmda_m.pmdacnfid,g_pmda_m.pmdacnfid_desc,g_pmda_m.pmdacnfdt,g_pmda_m.pmdapstid, 
          g_pmda_m.pmdapstid_desc,g_pmda_m.pmdapstdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE apmt830_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL apmt830_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="apmt830.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION apmt830_idx_chk()
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
   
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="apmt830.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION apmt830_b_fill2(pi_idx)
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
   
   CALL apmt830_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="apmt830.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION apmt830_fill_chk(ps_idx)
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
 
{<section id="apmt830.status_show" >}
PRIVATE FUNCTION apmt830_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="apmt830.mask_functions" >}
&include "erp/apm/apmt830_mask.4gl"
 
{</section>}
 
{<section id="apmt830.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION apmt830_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   DEFINE l_success  LIKE type_t.chr2
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
 
 
   CALL apmt830_show()
   CALL apmt830_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   CALL s_apmt830_conf_chk(g_pmda_m.pmdadocno) RETURNING l_success,g_errno
   IF NOT l_success THEN
      CLOSE apmt830_cl
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
   #CALL apmt830_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL apmt830_ui_headershow()
   CALL apmt830_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION apmt830_draw_out()
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
   CALL apmt830_ui_headershow()  
   CALL apmt830_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="apmt830.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION apmt830_set_pk_array()
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
 
{<section id="apmt830.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="apmt830.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION apmt830_msgcentre_notify(lc_state)
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
   CALL apmt830_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_pmda_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="apmt830.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION apmt830_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#28 add-S
   SELECT pmdastus  INTO g_pmda_m.pmdastus
     FROM pmda_t
    WHERE pmdaent = g_enterprise
      AND pmdadocno = g_pmda_m.pmdadocno

   IF(g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail")  THEN
     LET g_errno = NULL
     CASE g_pmda_m.pmdastus
        WHEN 'C'
           LET g_errno = 'ain-00197'
        WHEN 'W'
           LET g_errno = 'sub-00180'
        WHEN 'X'
           LET g_errno = 'sub-00229'
        WHEN 'Y'
           LET g_errno = 'sub-00178'
        WHEN 'H'
           LET g_errno = 'sub-01348'
        WHEN 'UH'
           LET g_errno = 'sub-01358'
     END CASE

     IF NOT cl_null(g_errno) THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = g_errno
        LET g_errparam.extend = g_pmda_m.pmdadocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL apmt830_set_act_visible()
        CALL apmt830_set_act_no_visible()
        CALL apmt830_show()
        RETURN FALSE
     END IF
   END IF
   #160818-00017#28 add-E
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="apmt830.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 檢查配送倉是否存在此配送中心及是否為有效資料
# Memo...........:
# Usage..........: CALL apmt830_pmda206_chk()
#                  RETURNING TRUN(FALSE)
# Return code....: TRUE(FALSE)
# Date & Author..: 2015-03-06 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt830_pmda206_chk()
DEFINE l_inaastus  LIKE inaa_t.inaastus

   IF NOT cl_null(g_pmda_m.pmda205) THEN
      SELECT inaastus INTO l_inaastus FROM inaa_t
       WHERE inaaent = g_enterprise AND inaa001 = g_pmda_m.pmda206
        AND inaasite = g_pmda_m.pmda205
      IF cl_null(l_inaastus) OR STATUS = 100 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'apm-00316'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      ELSE
         IF l_inaastus = 'N' THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'sub-01302'  #aim-00065  #160318-00005#37  By 07900--mod
            LET g_errparam.extend = ''
            #160318-00005#317  By 07900 --add-str
            LET g_errparam.replace[1] ='aini001'
            LET g_errparam.replace[2] = cl_get_progname("aini001",g_lang,"2")
            LET g_errparam.exeprog ='aini001'
            #160318-00005#37  By 07900 --add-end
            LET g_errparam.popup = TRUE
            CALL cl_err()

            RETURN FALSE
         END IF
      END IF 
   END IF
   RETURN TRUE
END FUNCTION

################################################################################
# Descriptions...: 檢查商品編號是否符合相關條件
# Memo...........: 
# Usage..........: CALL apmt830_pmdb004_chk()
#                  RETURNING TRUE(FALSE)
# Input parameter: 無
# Return code....: TRUE(FALSE)
# Date & Author..: 2015-03-10 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt830_pmdb004_chk()
DEFINE l_n         LIKE type_t.num5
DEFINE l_sys       LIKE type_t.num5
DEFINE l_pmdb015   LIKE pmdb_t.pmdb015
DEFINE l_star004   LIKE star_t.star004
DEFINE l_stan017   LIKE stan_t.stan017
DEFINE l_stan018   LIKE stan_t.stan018
DEFINE l_starstus  LIKE star_t.starstus
DEFINE l_rtdxstus  LIKE rtdx_t.rtdxstus
DEFINE l_pmdb004   LIKE pmdb_t.pmdb004
DEFINE l_rtdx027   LIKE rtdx_t.rtdx027  #採購方式
DEFINE l_sql       STRING 

#.輸入值須存在[T:料件基本資料檔].[C:料件編號]，且[C:資料狀態]為確認
#检查是否存在门店清单是否有效
#检查条码是否有效
   #INITIALIZE g_chkparam.* TO NULL
   #LET g_errshow = '1'
   #LET g_chkparam.arg1 = g_pmdb_d[l_ac].pmdb004
   #LET g_chkparam.arg1 = g_pmdb_d[l_ac].pmdbsite
   #IF NOT cl_chk_exist("v_rtdx001_1") THEN
   #   RETURN FALSE
   #END IF


   SELECT rtdxstus  INTO l_rtdxstus FROM rtdx_t LEFT JOIN imaa_t ON rtdx001=imaa001 AND rtdxent=imaaent  LEFT JOIN imay_t ON rtdx002=imay003 AND imay001=rtdx001 AND imayent =rtdxent 
    WHERE rtdx001 =  g_pmdb_d[l_ac].pmdb004 AND rtdxsite = g_pmdb_d[l_ac].pmdbsite  AND rtdxent = g_enterprise 
   #檢查輸入的商品編號存不存在相應門店的[門店清單檔rtdx_t]中!
   IF STATUS = 100 OR cl_null(l_rtdxstus) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'art-00151'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE
   ELSE
      #檢查輸入的商品編號在相應門店的[門店清單檔rtdx_t]中是否有效!  
      IF l_rtdxstus <>'Y' THEN 
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'art-00156'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF
   END IF  
   
   SELECT COUNT(*) INTO l_n  FROM rtdx_t LEFT JOIN imaa_t ON rtdx001=imaa001 AND rtdxent=imaaent  LEFT JOIN imay_t ON rtdx002=imay003 AND imay001=rtdx001 AND imayent =rtdxent 
    WHERE rtdx001 =  g_pmdb_d[l_ac].pmdb004 AND rtdxsite = g_pmdb_d[l_ac].pmdbsite  AND rtdxent = g_enterprise 
     AND imaastus <> 'Y' 
   IF l_n > 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'art-00126'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE  
   END IF 
     
 
   SELECT COUNT(*) INTO l_n  FROM rtdx_t LEFT JOIN imaa_t ON rtdx001=imaa001 AND rtdxent=imaaent  LEFT JOIN imay_t ON rtdx002=imay003 AND imay001=rtdx001 AND imayent =rtdxent 
    WHERE rtdx001 =  g_pmdb_d[l_ac].pmdb004 AND rtdxsite = g_pmdb_d[l_ac].pmdbsite  AND rtdxent = g_enterprise 
     AND imaystus <> 'Y'
     
   IF l_n > 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'art-00262'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE  
   END IF
   
   #若單頭有指定"採購類型"時，輸入的商品對應的採購類型應等於單頭的採購類型(由門店清單中抓取採購類型)
   IF NOT cl_null(g_pmda_m.pmda201) THEN    
      SELECT COUNT(*) INTO l_n FROM rtdx_t 
       WHERE rtdxent = g_enterprise AND rtdx001 = g_pmdb_d[l_ac].pmdb004 AND rtdx027 = g_pmda_m.pmda201 AND rtdxsite = g_pmdb_d[l_ac].pmdbsite
      IF l_n = 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'apm-00327'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF
   #160921-00037#1 20160922 add by beckxie---S
   ELSE
      #此商品在商品清單中的採購方式不可為空
      LET l_n = 0
      SELECT COUNT(*) INTO l_n FROM rtdx_t 
       WHERE rtdxent = g_enterprise 
         AND rtdxsite = g_pmdb_d[l_ac].pmdbsite
         AND rtdx001 = g_pmdb_d[l_ac].pmdb004 
         AND rtdx027 IS NOT NULL 
      IF l_n = 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'apm-01128'   #此商品[ %1 ] 在 [商品清單查詢作業] 中的採購方式為空！
         LET g_errparam.extend = ''
         LET g_errparam.replace[1] = g_pmdb_d[l_ac].pmdb004 
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN FALSE
      END IF
   #160921-00037#1 20160922 add by beckxie---E
   END IF

   #若單頭有指定"採購中心"時，輸入商品對應的採購中心應等於單頭的採購中心(由門店清單中抓取採購中心)
   IF NOT cl_null(g_pmda_m.pmda204) THEN
      SELECT COUNT(*) INTO l_n FROM rtdx_t 
       WHERE rtdxent = g_enterprise AND rtdx001 = g_pmdb_d[l_ac].pmdb004 AND rtdx028 = g_pmda_m.pmda204
      IF l_n = 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'apm-00328'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF
   END IF

   #若單頭有指定"配送中心"時，輸入商品對應的配送中心應等於單頭的配送中心(由門店清單中抓取配送中心)
   IF NOT cl_null(g_pmda_m.pmda205) THEN
      SELECT COUNT(*) INTO l_n FROM rtdx_t 
       WHERE rtdxent = g_enterprise AND rtdx001 = g_pmdb_d[l_ac].pmdb004 AND rtdx029 = g_pmda_m.pmda205
      IF l_n = 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'apm-00329'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF
   END IF

   #若單頭有指定所屬品類。輸入商品必須存在所屬品類或者其下級
   CALL cl_get_para(g_enterprise,g_site,'E-CIR-0001') RETURNING l_sys
   IF NOT cl_null(g_pmda_m.pmda202) THEN
      LET l_sql = " SELECT COUNT(*) FROM imaa_t ",
                 "  WHERE imaaent = '",g_enterprise,"' AND imaa001 = '",g_pmdb_d[l_ac].pmdb004,"'",
                 "   AND imaa009 IN (SELECT DISTINCT rtax001 FROM rtax_t",
                 "                    WHERE rtaxent = '",g_enterprise,"' AND rtax004 >='",l_sys,"' AND rtaxstus = 'Y'",
                 #"                    START WITH rtax003 = '", g_pmda_m.pmda202,"' AND  rtaxstus = 'Y' CONNECT BY nocycle PRIOR rtax001 = rtax003 )"   #150507-00008#1 150507 by lori522612 mark
                 "                    START WITH rtax003 = '", g_pmda_m.pmda202,"' ",   #150507-00008#1 150507 by lori522612 add
                 "                    CONNECT BY NOCYCLE PRIOR rtax001 = rtax003 ",     #150507-00008#1 150507 by lori522612 add
                 "                    UNION ",
                 "                   SELECT DISTINCT rtax001",
                 "                              FROM rtax_t ",
                 "                             WHERE rtaxent =",g_enterprise,
                 "                               AND rtax004 = ",l_sys,
                 "                               AND rtax005 = 0 ",
                 "                               AND rtaxstus = 'Y' ",
                 "                               AND rtax001 = '",g_pmda_m.pmda202,"' )"                  
      #SELECT COUNT(*) INTO l_n FROM imaa_t 
      # WHERE imaaent = g_enterprise AND imaa001 = g_pmdb_d[l_ac].pmdb004
      #   AND imaa009 IN (SELECT DISTINCT rtax001 FROM rtax_t 
      #                    WHERE rtaxent =g_enterprise AND rtax004 >=l_sys AND rtaxstus = 'Y' 
      #                     START WITH rtax003 = g_pmda_m.pmda202 AND rtaxstus = 'Y' CONNECT BY nocycle PRIOR rtax001 = rtax003 )
      
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

   #150416-00013#1 Add By Ken 150423
   #先抓取採購方式; rtdx027 用來判斷是否需要有主供應商(採購方式為2:統採配送時主供應商可為空)
   SELECT rtdx027  INTO l_rtdx027 FROM rtdx_t 
    WHERE rtdxent = g_enterprise AND rtdxsite = g_pmdb_d[l_ac].pmdbsite AND rtdx001 =  g_pmdb_d[l_ac].pmdb004
   #150416-00013#1

   ##先抓取供應商; rtdx031 已改no use
   #SELECT rtdx031  INTO  l_pmdb015 FROM rtdx_t 
   # WHERE rtdxent = g_enterprise AND rtdxsite = g_pmdb_d[l_ac].pmdbsite AND rtdx001 =  g_pmdb_d[l_ac].pmdb004
   
    #先抓取供應商 
   SELECT imaf153  INTO  l_pmdb015 FROM imaf_t 
    WHERE imafent = g_enterprise AND imafsite = g_pmdb_d[l_ac].pmdbsite AND imaf001 =  g_pmdb_d[l_ac].pmdb004
   
   IF NOT cl_null(l_pmdb015) THEN
     #160921-00037#1 20160922 mark by beckxie---S
     #改為不需檢核採購協議
     ##根據根據供應商+商品 和單據日期抓取屬於哪個區間的合同    
     #SELECT COUNT(*) INTO l_n FROM  stan_t,star_t,stas_t 
     # WHERE starent = stasent AND star001 = stas001 AND stan001 = star004 
     #   AND starsite = stassite  #add by geza 20150603 
     #   AND stanent = starent AND stanent = g_enterprise 
     #   AND starsite = g_pmdb_d[l_ac].pmdbsite  #add by geza 20150603
     #   AND stas003 = g_pmdb_d[l_ac].pmdb004 AND star003 = l_pmdb015
     #IF l_n = 0 THEN
     #   INITIALIZE g_errparam TO NULL
     #   LET g_errparam.code = 'apm-00468'
     #   LET g_errparam.extend = ''
     #   LET g_errparam.popup = TRUE
     #   CALL cl_err()
     #   #不存在采购协议
     #   RETURN FALSE  
     #END IF
     #
     #SELECT DISTINCT star004,starstus INTO l_star004,l_starstus FROM stan_t,star_t,stas_t 
     # WHERE starent = stasent AND star001 = stas001 AND stan001 = star004 
     #   AND starsite = stassite  #add by geza 20150603 
     #   AND stanent = starent AND stanent = g_enterprise 
     #   AND starsite = g_pmdb_d[l_ac].pmdbsite  #add by geza 20150603
     #   AND stas003 = g_pmdb_d[l_ac].pmdb004 AND star003 = l_pmdb015 
     #   #AND g_pmda_m.pmdadocdt BETWEEN stan017 AND stan018   #160104-00014#1 20160105 mark by beckxie
     #   AND g_pmda_m.pmdadocdt BETWEEN stas018 AND stas019   #160104-00014#1 20160105  add by beckxie
     #
     #IF cl_null(l_star004) THEN
     #   INITIALIZE g_errparam TO NULL
     #   LET g_errparam.code = 'apm-00333'
     #   LET g_errparam.extend = ''
     #   LET g_errparam.popup = TRUE
     #   CALL cl_err()
     #   #不在生效範圍之內
     #   RETURN FALSE
     #END IF 
     #IF l_starstus <> 'Y' THEN
     #   INITIALIZE g_errparam TO NULL
     #   LET g_errparam.code = 'apm-00334'
     #   LET g_errparam.extend = ''
     #   LET g_errparam.popup = TRUE
     #   CALL cl_err()
     #  #作廢
     #   RETURN FALSE
     #END IF
     #160921-00037#1 20160922 mark by beckxie---E
   ELSE
      #用來判斷是否需要有主供應商(採購方式為2:統採配送時主供應商可為空)
      IF l_rtdx027 <> '2' THEN
         #artq400 主要供應商找不到
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'apm-00846'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN FALSE 
      END IF          
   END IF
   
   #IF NOT cl_null(g_pmdb_d[l_ac].pmdb200) THEN
   #   SELECT DISTINCT imay001 INTO l_pmdb004 FROM imay_t
   #    WHERE imayent = g_enterprise AND imay003 = g_pmdb_d[l_ac].pmdb200
   #         
   #   IF g_pmdb_d[l_ac].pmdb004 <> l_pmdb004 THEN
   #     CALL apmt830_get_pmdb200(g_pmdb_d[l_ac].pmdb004) RETURNING g_pmdb_d[l_ac].pmdb200  
   #        
   #     # INITIALIZE g_errparam TO NULL
   #     # LET g_errparam.code = 'art-00274'
   #     # LET g_errparam.extend = ''
   #     # LET g_errparam.popup = TRUE
   #     # CALL cl_err()
   #   
   #      RETURN FALSE
   #   
   #   END IF
   #END IF
   
   #150126-00028#14 By benson ---- S
   IF NOT s_arti204_control_check(g_prog,g_pmda_m.pmda003,g_pmdb_d[l_ac].pmdb004,'') THEN
      RETURN FALSE
   END IF
   #150126-00028#14 By benson ---- E
   RETURN TRUE
END FUNCTION

################################################################################
# Descriptions...: 取得商品編號相關資訊
# Memo...........:
# Usage..........: CALL apmt830_pmdb004_other()
# Input parameter: 
# Return code....: 無
# Date & Author..: 2015-03-10 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt830_pmdb004_other()
DEFINE l_sys2         LIKE type_t.num5    #補貨規格的參數
DEFINE l_imaz004      LIKE imaz_t.imaz004
DEFINE l_imaz005      LIKE imaz_t.imaz005
DEFINE l_imaz006      LIKE imaz_t.imaz006
   
   #先清空原本帶值欄位資料   
   LET g_pmdb_d[l_ac].imaa009 = ''     #品類
   LET g_pmdb_d[l_ac].imaa009_desc=''  #品類說明
   LET g_pmdb_d[l_ac].pmdb201 = ''     #包裝單位
   LET g_pmdb_d[l_ac].pmdb202 = ''     #件裝數
   LET g_pmdb_d[l_ac].pmdb015 = ''     #供應商 
   LET g_pmdb_d[l_ac].pmdb015_desc = ''#供應商說明 
   LET g_pmdb_d[l_ac].pmdb208 = ''     #經營方式
   LET g_pmdb_d[l_ac].pmdb209 =''      #結算方式
   LET g_pmdb_d[l_ac].pmdb209_desc ='' #結算方式說明
   LET g_pmdb_d[l_ac].pmdb206 =''      #採購員
   LET g_pmdb_d[l_ac].pmdb206_desc ='' #採購員全名
   LET g_pmdb_d[l_ac].pmdb205 =''      #採購中心
   LET g_pmdb_d[l_ac].pmdb205_desc ='' #採購中心說明
   LET g_pmdb_d[l_ac].pmdb203 =''      #配送中心
   LET g_pmdb_d[l_ac].pmdb203_desc ='' #配送中心說明
   LET g_pmdb_d[l_ac].pmdb212 = ''     #要貨件數
   LET g_pmdb_d[l_ac].pmdb006 = ''     #需求數量 
   LET g_pmdb_d[l_ac].pmdb007 = ''     #單位
   #LET g_pmdb_d[l_ac].pmdb005 = ''     #產品特徵       #161017-00029#1 16/10/20 by 08742 mark
   #LET g_pmdb_d[l_ac].pmdb005_desc = ''#產品特徵說明   #161017-00029#1 16/10/20 by 08742 mark
   LET g_pmdb_d[l_ac].pmdb227 = ''  #補貨規格說明
   
   
   #150710-00016#3 Add By Ken 150713(S) 取商品符合補貨規格的包裝單位、件裝數、補貨規格
   CALL cl_get_para(g_enterprise,g_pmdb_d[l_ac].pmdbsite,'S-CIR-1001') RETURNING l_sys2
   SELECT imaz004,imaz005,imaz006 INTO l_imaz004,l_imaz005,l_imaz006
     FROM imaz_t
    WHERE imazent = g_enterprise 
      AND imaz001 = g_pmdb_d[l_ac].pmdb004
      AND imaz002 = l_sys2   
   #150710-00016#3 Add By Ken 150713(E) 
   
   IF cl_null(g_pmdb_d[l_ac].pmdb200) THEN 
      #帶出條碼
      SELECT rtdx002 INTO g_pmdb_d[l_ac].pmdb200  
        FROM rtdx_t 
       WHERE rtdxent = g_enterprise 
         AND rtdxsite = g_pmdb_d[l_ac].pmdbsite 
         AND rtdx001 =  g_pmdb_d[l_ac].pmdb004 
      #SELECT imay003 INTO g_pmdb_d[l_ac].pmdb200 FROM imay_t WHERE imayent= g_enterprise AND imay001 = g_pmdb_d[l_ac].pmdb004 AND imay006 = 'Y'
   END IF 
   
   #品類編號
   CALL apmt830_get_imaa009(g_pmdb_d[l_ac].pmdb004) RETURNING g_pmdb_d[l_ac].imaa009
   DISPLAY BY NAME g_pmdb_d[l_ac].imaa009                    
   
   #品類說明
   CALL s_desc_get_rtaxl003_desc(g_pmdb_d[l_ac].imaa009) RETURNING g_pmdb_d[l_ac].imaa009_desc
   DISPLAY BY NAME g_pmdb_d[l_ac].imaa009_desc   

   #No:161030----------------begin      #add by stcshy 161030
   CALL apmt830_get_imaa(g_pmdb_d[l_ac].pmdb004) 
      #161214-00004#3 add by sunxh 161221(S)
      RETURNING g_pmdb_d[l_ac].imaa154,g_pmdb_d[l_ac].imaa155,g_pmdb_d[l_ac].imaa156,g_pmdb_d[l_ac].imaa132,g_pmdb_d[l_ac].rtaw001,g_pmdb_d[l_ac].imaa116
      #161214-00004#3 add by sunxh 161221(E)
      #161129-00067#2 -s by 08172
#      RETURNING g_pmdb_d[l_ac].imaa154,g_pmdb_d[l_ac].imaa155,g_pmdb_d[l_ac].imaa156,g_pmdb_d[l_ac].imaa132,g_pmdb_d[l_ac].imaa128,g_pmdb_d[l_ac].imaa116
#      RETURNING g_pmdb_d[l_ac].imaa154,g_pmdb_d[l_ac].imaa155,g_pmdb_d[l_ac].imaa156,g_pmdb_d[l_ac].imaa132,g_pmdb_d[l_ac].imaa128,g_pmdb_d[l_ac].imaa157
      #161129-00067#2 -e by 08172
   #161214-00004#3 add by sunxh 161221(S)
   CALL s_desc_get_rtaxl003_desc(g_pmdb_d[l_ac].rtaw001) RETURNING g_pmdb_d[l_ac].imaa128_desc
   #161214-00004#3 add by sunxh 161221(E)
#   CALL s_desc_get_acc_desc('2004',g_pmdb_d[l_ac].imaa128) RETURNING g_pmdb_d[l_ac].imaa128_desc
   CALL s_desc_get_acc_desc('2006',g_pmdb_d[l_ac].imaa132) RETURNING g_pmdb_d[l_ac].imaa132_desc
   #No:161030------------------end
   
   #150710-00016#3 Add By Ken 150713(S) 如補貨規格有符合 則使用補貨規格的包裝單位、件裝數、補貨規格，沒有的話則帶主條碼的包裝單位、件裝數
   IF NOT cl_null(l_imaz004) THEN
      LET g_pmdb_d[l_ac].pmdb201 = l_imaz004
      LET g_pmdb_d[l_ac].pmdb202 = l_imaz005
      LET g_pmdb_d[l_ac].pmdb227 = l_imaz006
   ELSE
      SELECT imay004,imay005 
        INTO g_pmdb_d[l_ac].pmdb201,g_pmdb_d[l_ac].pmdb202 
        FROM imay_t 
       WHERE imayent= g_enterprise 
         AND imay001 = g_pmdb_d[l_ac].pmdb004 
         AND imay003 = g_pmdb_d[l_ac].pmdb200   
   END IF
   #150710-00016#3 Add By Ken 150713 (E)
   
   #IF NOT cl_null(l_imaz003) THEN #150521-00015#2 15/05/28 s983961---add(S) #06/08先判斷是否有 補貨規格級別 條碼 
   #抓取大補貨規格的包裝單位,件裝數
   #  SELECT imaz004,imaz005 INTO g_pmdb_d[l_ac].pmdb201,g_pmdb_d[l_ac].pmdb202 FROM imaz_t WHERE imazent= g_enterprise AND imaz001 = g_pmdb_d[l_ac].pmdb004 AND imaz003 = g_pmdb_d[l_ac].pmdb200
   #ELSE          
   #抓取主條碼的包裝單位,件裝數   
   #150521-00015#2 15/05/28 s983961---add(E)
   #  SELECT imay004,imay005 INTO g_pmdb_d[l_ac].pmdb201,g_pmdb_d[l_ac].pmdb202 FROM imay_t WHERE imayent= g_enterprise AND imay001 = g_pmdb_d[l_ac].pmdb004 AND imay003 = g_pmdb_d[l_ac].pmdb200   
   #SELECT rtdx004,rtdx005 INTO g_pmdb_d[l_ac].pmdb201,g_pmdb_d[l_ac].pmdb202 FROM rtdx_t 
   # WHERE rtdxent = g_enterprise AND rtdxsite = g_pmdb_d[l_ac].pmdbsite AND rtdx001 =  g_pmdb_d[l_ac].pmdb004
   #END IF 
   
   #包裝單位說明
   CALL s_desc_get_unit_desc(g_pmdb_d[l_ac].pmdb201) RETURNING g_pmdb_d[l_ac].pmdb201_desc
   DISPLAY BY NAME g_pmdb_d[l_ac].pmdb201_desc  

   #要貨單位預設抓 庫存單位
   SELECT imaa104 INTO  g_pmdb_d[l_ac].pmdb007 FROM imaa_t WHERE imaaent = g_enterprise AND imaa001 =  g_pmdb_d[l_ac].pmdb004
   
   #要貨單位說明
   CALL s_desc_get_unit_desc(g_pmdb_d[l_ac].pmdb007) RETURNING g_pmdb_d[l_ac].pmdb007_desc
   DISPLAY BY NAME g_pmdb_d[l_ac].pmdb007_desc 
   
    
   #帶出採購類型，經營方式，採購中心，配送中心
   SELECT rtdx027,rtdx003,rtdx028,rtdx029 
    INTO g_pmdb_d[l_ac].pmdb207,g_pmdb_d[l_ac].pmdb208,g_pmdb_d[l_ac].pmdb205,g_pmdb_d[l_ac].pmdb203 FROM rtdx_t 
    WHERE rtdxent = g_enterprise AND rtdxsite = g_pmdb_d[l_ac].pmdbsite AND rtdx001 =  g_pmdb_d[l_ac].pmdb004
   
   #帶出採購中心名稱
   SELECT ooefl003 INTO g_pmdb_d[l_ac].pmdb205_desc FROM ooefl_t 
    WHERE ooeflent = g_enterprise AND ooefl001 = g_pmdb_d[l_ac].pmdb205 AND ooefl002 = g_dlang
   
   #帶出配送中心名稱
   SELECT ooefl003 INTO g_pmdb_d[l_ac].pmdb203_desc FROM ooefl_t 
    WHERE ooeflent = g_enterprise AND ooefl001 = g_pmdb_d[l_ac].pmdb203 AND ooefl002 = g_dlang 
    
   #帶出供應商
   SELECT imaf153
    INTO g_pmdb_d[l_ac].pmdb015 FROM imaf_t 
    WHERE imafent =  g_enterprise AND imafsite = g_pmdb_d[l_ac].pmdbsite AND imaf001 =  g_pmdb_d[l_ac].pmdb004
   
   #帶出供應商名稱
   SELECT pmaal004 INTO g_pmdb_d[l_ac].pmdb015_desc FROM pmaal_t
    WHERE pmaalent = g_enterprise AND pmaal001 =  g_pmdb_d[l_ac].pmdb015 AND pmaal002 = g_dlang
      
   IF NOT cl_null(g_pmdb_d[l_ac].pmdb015) THEN   
      #[C:結算方式]= [T:採購協議單頭檔].[C:結算方式](由單身生效的商品回找單頭)

      SELECT DISTINCT star006,stas009 INTO g_pmdb_d[l_ac].pmdb209,g_pmdb_d[l_ac].pmdb206 FROM stan_t,star_t,stas_t 
       WHERE starent = stasent AND star001 = stas001 AND starsite = stassite # add by geza 20150604 starsite,stassite
         AND stanent = starent AND stan001 = star004 AND stanent = g_enterprise AND starsite = g_pmdb_d[l_ac].pmdbsite  # add by geza 20150604 starsite
         AND stas003 = g_pmdb_d[l_ac].pmdb004 AND star003 = g_pmdb_d[l_ac].pmdb015 AND starstus = 'Y'
         #AND g_pmda_m.pmdadocdt BETWEEN stan017 AND stan018   #160104-00014#1 20160105 mark by beckxie
         AND g_pmda_m.pmdadocdt BETWEEN stas018 AND stas019    #160104-00014#1 20160105  add by beckxie
      
      SELECT staal003 INTO  g_pmdb_d[l_ac].pmdb209_desc FROM staal_t
       WHERE staalent = g_enterprise AND staal001 = g_pmdb_d[l_ac].pmdb209 AND staal002 = g_dlang
    
     #[C:採購員]=[T:採購協議單身檔].[C:採購員] (抓取生效的協議資料)並自動帶出姓名
     CALL s_desc_get_person_desc(g_pmdb_d[l_ac].pmdb206) RETURNING g_pmdb_d[l_ac].pmdb206_desc
   END IF
   
   
END FUNCTION

################################################################################
# Descriptions...: 檢查單身採購方式 是否有自訂貨
# Memo...........: 如有自訂貨筆數 回傳FALSE 無的話回傳TRUE
# Usage..........: CALL apmt830_pmdb207_chk()
#                  RETURNING 
# Input parameter: 
# Return code....: 
#                : 
# Date & Author..: 2015-01-07 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt830_pmdb207_chk()
DEFINE  l_n LIKE type_t.num5

   SELECT COUNT(*) INTO l_n FROM pmdb_t
    WHERE pmdbdocno = g_pmda_m.pmdadocno AND pmdbent = g_enterprise AND pmdb207 = '0'
    
   IF l_n > 0 THEN
      RETURN FALSE
   END IF
   RETURN TRUE
END FUNCTION

################################################################################
# Descriptions...: 單身要貨件數加總 顯示到單頭包裝總數量
# Memo...........:
# Usage..........: CALL apmt830_pmdb212_sum()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2015-03-13 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt830_pmdb212_sum()
   SELECT SUM(pmdb212) INTO g_pmda_m.pmda208 FROM pmdb_t  
    WHERE pmdbent = g_enterprise AND pmdbdocno = g_pmda_m.pmdadocno 
   DISPLAY BY NAME g_pmda_m.pmda208
END FUNCTION

################################################################################
# Descriptions...: 取得商品採購方式
# Memo...........:
# Usage..........: CALL apmt830_get_rtdx027(p_pmdbsite,p_pmdb004)
#                  RETURNING r_rtdx027
# Input parameter: p_pmdbsite     需求組織
#                : p_pmdb004      商品編號
# Return code....: r_rtdx027      採購方式
# Date & Author..: 2015-01-30 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt830_get_rtdx027(p_pmdbsite,p_pmdb004)
DEFINE p_pmdbsite      LIKE pmdb_t.pmdbsite
DEFINE p_pmdb004       LIKE pmdb_t.pmdb004
DEFINE r_rtdx027       LIKE rtdx_t.rtdx027

   LET r_rtdx027 = ''
   SELECT rtdx027 INTO r_rtdx027 
     FROM rtdx_t 
    WHERE rtdxent  = g_enterprise 
      AND rtdxsite = p_pmdbsite
      AND rtdx001  = p_pmdb004
      
   RETURN r_rtdx027 
END FUNCTION

################################################################################
# Descriptions...: 取得品類編號
# Memo...........:
# Usage..........: CALL apmt830_get_imaa009(p_pmdb004)
#                  RETURNING r_imaa009
# Input parameter: p_pmdb004      商品編號
# Return code....: r_imaa009      品類編號
# Date & Author..: 2015-03-06 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt830_get_imaa009(p_pmdb004)
DEFINE p_pmdb004      LIKE pmdb_t.pmdb004
DEFINE r_imaa009      LIKE imaa_t.imaa009

   LET r_imaa009 = ''
   SELECT imaa009 INTO r_imaa009 
     FROM imaa_t 
    WHERE imaaent = g_enterprise 
      AND imaa001 = p_pmdb004
              
   RETURN r_imaa009
END FUNCTION

################################################################################
# Descriptions...: 取得產品特徵類別
# Memo...........:
# Usage..........: CALL apmt830_get_imaa005(p_imaa001)
#                  RETURNING r_imaa005
# Input parameter: p_imaa001   商品編號
# Return code....: r_imaa005   產品特徵類別
# Date & Author..: 2015/01/23 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt830_get_imaa005(p_imaa001)
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
# Descriptions...: 單位與要貨數量轉換
# Memo...........: 當要貨數量有值，由要貨數量轉換成包裝數量(要貨件數)
#                  當要貨數量為空，由包裝數量(要貨件數)轉換成要貨數量
# Usage..........: CALL apmt830_num_change()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2015/01/23 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt830_num_change()
DEFINE l_success        LIKE type_t.num5

    #當包裝單位或要貨單位都為空，表示無法轉換
    IF cl_null(g_pmdb_d[l_ac].pmdb201) OR cl_null(g_pmdb_d[l_ac].pmdb007) THEN
       RETURN
    END IF
    
    #當要貨數量為空
    IF cl_null(g_pmdb_d[l_ac].pmdb006) THEN
       #當包裝數量(要貨件數)為空
       IF cl_null(g_pmdb_d[l_ac].pmdb212) THEN
          RETURN
       ELSE
          #當要貨數量為空，由包裝數量(要貨件數)轉換成要貨數量
          CALL s_aooi250_convert_qty(g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb201,g_pmdb_d[l_ac].pmdb007,g_pmdb_d[l_ac].pmdb212)
              RETURNING l_success,g_pmdb_d[l_ac].pmdb006
       END IF
    ELSE
       #當要貨數量有值，由要貨數量轉換成包裝數量(要貨件數)
       CALL s_aooi250_convert_qty(g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb007,g_pmdb_d[l_ac].pmdb201,g_pmdb_d[l_ac].pmdb006)
           RETURNING l_success,g_pmdb_d[l_ac].pmdb212
    END IF
END FUNCTION

################################################################################
# Descriptions...: 計算前一、二、三、四週銷量及周平均銷量
# Memo...........: 使用 CALL s_daily_sale(p_debasite,p_date,p_s_days,p_e_days,p_deba009,p_deba043) 計算各週銷量
# Usage..........: CALL apmt830_daily_sale_all(p_pmdbsite,p_date,p_pmdb004,p_pmdb005)
#                  RETURNING r_pmdb254,r_pmdb255,r_pmdb256,r_pmdb257,r_pmdb259
# Input parameter: p_pmdbsite   需求組織
#                : p_date       單據日期
#                : p_pmdb004    商品編號
#                : p_pmdb005    產品特徵
# Return code....: r_pmdb254    前一週銷量
#                : r_pmdb255    前二週銷量
#                : r_pmdb256    前三週銷量
#                : r_pmdb257    前四週銷量
#                : r_pmdb259    週平均銷量
# Date & Author..: 2014-12-04 By ken
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt830_daily_sale_all(p_pmdbsite,p_date,p_pmdb004,p_pmdb005)
   DEFINE p_pmdbsite     LIKE pmdb_t.pmdbsite    #需求組織
   DEFINE p_date         LIKE pmda_t.pmdadocdt   #單據日期
   DEFINE p_pmdb004      LIKE pmdb_t.pmdb004     #商品編號
   DEFINE p_pmdb005      LIKE pmdb_t.pmdb005     #產品特徵
   DEFINE r_pmdb254      LIKE pmdb_t.pmdb254     #前一週銷量
   DEFINE r_pmdb255      LIKE pmdb_t.pmdb255     #前二週銷量
   DEFINE r_pmdb256      LIKE pmdb_t.pmdb256     #前三週銷量
   DEFINE r_pmdb257      LIKE pmdb_t.pmdb257     #前四週銷量
   DEFINE r_pmdb259      LIKE pmdb_t.pmdb259     #週平均銷量
   
   LET r_pmdb254 = 0
   LET r_pmdb255 = 0
   LET r_pmdb256 = 0
   LET r_pmdb257 = 0
   LET r_pmdb259 = 0
   
   IF p_pmdb004 IS NOT NULL THEN
      CALL s_daily_sale(p_pmdbsite,p_date,1,7,p_pmdb004,p_pmdb005)
         RETURNING r_pmdb254
      CALL s_daily_sale(p_pmdbsite,p_date,8,14,p_pmdb004,p_pmdb005)
         RETURNING r_pmdb255
      CALL s_daily_sale(p_pmdbsite,p_date,15,21,p_pmdb004,p_pmdb005)
         RETURNING r_pmdb256
      CALL s_daily_sale(p_pmdbsite,p_date,22,28,p_pmdb004,p_pmdb005)
         RETURNING r_pmdb257
      
      LET r_pmdb259 = (r_pmdb254 + r_pmdb255 + r_pmdb256 + r_pmdb257)/4
   END IF 
   RETURN r_pmdb254,r_pmdb255,r_pmdb256,r_pmdb257,r_pmdb259 
END FUNCTION

################################################################################
# Descriptions...: 由商品編號取得條碼(主條碼)
# Memo...........:
# Usage..........: CALL apmt830_get_pmdb200(p_pmdb004)
#                  RETURNING r_pmdb200
# Input parameter: p_pmdb004        商品編號
# Return code....: r_pmdb200        商品條碼   
# Date & Author..: 2015-03-16 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt830_get_pmdb200(p_pmdb004)
DEFINE p_pmdb004      LIKE pmdb_t.pmdb004
DEFINE r_pmdb200      LIKE pmdb_t.pmdb200

   LET r_pmdb200 = ''
   SELECT imaa014 INTO r_pmdb200 
     FROM imaa_t 
    WHERE imaaent = g_enterprise 
      AND imaa001 = p_pmdb004
      
   RETURN r_pmdb200 
END FUNCTION

################################################################################
# Descriptions...: 控制單身欄位為必填
# Memo...........:
# Usage..........: apmt830_set_required_b(p_cmd)
# Input parameter: p_cmd          單身輸入狀態
# Return code....: 無
# Date & Author..: 2015-03-18 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt830_set_required_b(p_cmd)
DEFINE p_cmd     LIKE type_t.chr1
   IF NOT cl_null(g_pmdb_d[l_ac].pmdb210) THEN  #(當促銷開始日期非空白時，促銷結束日不可空白)
      CALL cl_set_comp_required("pmdb211",TRUE)
   END IF
   IF NOT cl_null(g_pmdb_d[l_ac].pmdb211) THEN  #(當促銷結束日期非空白時，促銷開始日不可空白)
      CALL cl_set_comp_required("pmdb210",TRUE) 
   END IF
END FUNCTION

################################################################################
# Descriptions...: 控制單身欄位為非必填
# Memo...........:
# Usage..........: apmt830_set_no_required_b(p_cmd)
# Input parameter: p_cmd          單身輸入狀態
# Return code....: 無
# Date & Author..: 2015-03-18 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt830_set_no_required_b(p_cmd)
DEFINE p_cmd     LIKE type_t.chr1
   CALL cl_set_comp_required("pmdb211",FALSE) 
   CALL cl_set_comp_required("pmdb210",FALSE) 
END FUNCTION

################################################################################
# Descriptions...: 是否有要貨組織預設要貨資料
# Memo...........:
# Usage..........: CALL apmt830_get_pmeu()
#                     RETURNING r_pmeusite,r_pmeu001
# Input parameter: 無
# Return code....: r_pmeusite     要貨組織
#                : r_pmeu001      要貨部門
# Date & Author..: 2015/04/06 By pomelo   150324-00006#13
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt830_get_pmeu()
DEFINE r_pmeusite        LIKE pmeu_t.pmeusite
DEFINE r_pmeu001         LIKE pmeu_t.pmeu001
DEFINE l_cnt             LIKE type_t.num5
DEFINE l_sys             LIKE type_t.num5 
DEFINE l_sql             STRING

   LET r_pmeusite = ''
   LET r_pmeu001 = ''
   
   LET l_sql = "SELECT COUNT(pmeuseq)",
               #150424-00021#1 Modify-S By Ken 150506
               #"  FROM imaa_t,imay_t,rtdx_t,pmeu_t",
               "  FROM imaa_t,imay_t,rtdx_t,pmeu_t,imaf_t",
               #150424-00021#1 Modify-E By Ken 150506
               " WHERE pmeuent = rtdxent",
               "   AND pmeusite = rtdxsite",
               "   AND pmeu003 = rtdx001",
               "   AND rtdxent = imaaent",
               "   AND rtdx001 = imaa001",
               "   AND rtdxent = imayent",
               "   AND rtdx001 = imay001",
               "   AND rtdx002 = imay003",
               #150424-00021#1 Add-S By Ken 150506
               "   AND rtdxent = imafent ",
               "   AND rtdxsite= imafsite ",
               "   AND rtdx001 = imaf001 ",
               #150424-00021#1 Add-E By Ken 150506
               "   AND pmeuent = ",g_enterprise,
               "   AND pmeusite = ?",
               "   AND pmeu001 = ?",
               "   AND imaastus = 'Y'",
               "   AND imaystus = 'Y'",
               "   AND rtdxstus = 'Y'",
               #150424-00021#1 Modify-S By Ken 150506
               #"   AND (COALESCE(rtdx031,'-1') = '-1'",
               "   AND (COALESCE(imaf153,'-1') = '-1'",
               #150424-00021#1 Modify-E By Ken 150506
               "    OR EXISTS (SELECT 1",
               "                 FROM stan_t, star_t, stas_t",
               "                WHERE stanent = starent",
               "                  AND stan001 = star004",
               "                  AND starent = stasent",
               "                  AND star001 = stas001",
               "                  AND starsite = stassite", #150529 by s983961 add
               "                  AND starsite = rtdxsite", #150604 by geza add
               "                  AND stasent = rtdxent",
               "                  AND stas003 = rtdx001",
               #150424-00021#1 Modify-S By Ken 150506
               #"                  AND star003 = rtdx031",
               "                  AND star003 = imaf153",
               #150424-00021#1 Modify-E By Ken 150506
               "                  AND starstus = 'Y'",
               #"                  AND '",g_pmda_m.pmdadocdt,"' BETWEEN stan017 AND stan018",   #160104-00014#1 20160105 mark by beckxie
               "                  AND '",g_pmda_m.pmdadocdt,"' BETWEEN stas018 AND stas019",    #160104-00014#1 20160105  add by beckxie
               #150424-00021#1 Modify-S By Ken 150506
               #"                  AND COALESCE(rtdx031,'-1') != '-1'))"
               "                  AND COALESCE(imaf153,'-1') != '-1'))"
               #150424-00021#1 Modify-E By Ken 150506
               
   #品類設定加上部門過濾該作業可使用的商品
   LET l_sql = l_sql," AND ",s_arti204_control_where(g_prog,g_pmda_m.pmda003,'1')
   
   #採購方式
   IF NOT cl_null(g_pmda_m.pmda201) THEN
      LET l_sql = l_sql," AND rtdx027 = '",g_pmda_m.pmda201,"'"
   END IF
   
   #所屬品類
   IF NOT cl_null(g_pmda_m.pmda202) THEN
      LET l_sys = 0
      CALL cl_get_para(g_enterprise,g_site,'E-CIR-0001') RETURNING l_sys
      LET l_sql = l_sql," AND imaa009 IN (SELECT DISTINCT rtax001",
                        "                   FROM rtax_t ",
                        "                  WHERE rtaxent =",g_enterprise,
                        "                    AND rtax004 >= ",l_sys,
                        "                    AND rtaxstus = 'Y'",
                        "                  START WITH rtax003 = '",g_pmda_m.pmda202,"'",
                        #"                    AND rtaxstus = 'Y'",   #150507-00008#1 150507 by lori522612 mark
                        "                CONNECT BY NOCYCLE PRIOR rtax001 = rtax003 ",
                        "                  UNION ",
                        "                 SELECT DISTINCT rtax001",
                        "                            FROM rtax_t ",
                        "                           WHERE rtaxent =",g_enterprise,
                        "                             AND rtax004 = ",l_sys,
                        "                             AND rtax005 = 0 ",
                        "                             AND rtaxstus = 'Y' ",
                        "                             AND rtax001 = '",g_pmda_m.pmda202,"' )"                          
   END IF
   
   #採購中心
   IF NOT cl_null(g_pmda_m.pmda204) THEN
      LET l_sql = l_sql," AND rtdx028 = '",g_pmda_m.pmda204,"'"
   END IF
   
   #配送中心
   IF NOT cl_null(g_pmda_m.pmda205) THEN
      LET l_sql = l_sql," AND rtdx029 = '",g_pmda_m.pmda205,"'"
   END IF
   
   PREPARE apmt830_pmeu_chk FROM l_sql
   
   #用要貨組織+要貨部門是否可以取的資料
   LET l_cnt = 0
   EXECUTE apmt830_pmeu_chk USING g_pmda_m.pmdasite,g_pmda_m.pmda003
      INTO l_cnt
      
   IF l_cnt = 0 THEN
      #用要貨組織+要貨部門 = ' '是否可以取的資料
      LET l_cnt = 0
      EXECUTE apmt830_pmeu_chk USING g_pmda_m.pmdasite,' '
         INTO l_cnt
      IF l_cnt >= 1 THEN
         LET r_pmeusite = g_pmda_m.pmdasite
         LET r_pmeu001 = ' '
      END IF
   ELSE
      LET r_pmeusite = g_pmda_m.pmdasite
      LET r_pmeu001 = g_pmda_m.pmda003
   END IF
   
   RETURN r_pmeusite,r_pmeu001
END FUNCTION

################################################################################
# Descriptions...: 維護緊急度
# Memo...........:
# Usage..........: CALL apmt830_upd_pmdb033()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2015/04/09 By pomelo 150324-00006#14
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt830_upd_pmdb033()
DEFINE l_insert      BOOLEAN
DEFINE l_lock_sw     LIKE type_t.chr1                #單身鎖住否
DEFINE ls_keys       DYNAMIC ARRAY OF VARCHAR(500)
DEFINE l_n           LIKE type_t.num5
DEFINE l_cmd         LIKE type_t.chr1

   IF g_pmda_m.pmdadocno IS NULL THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ""
      LET g_errparam.code   = "std-00003"
      LET g_errparam.popup  = FALSE
      CALL cl_err()
      RETURN
   END IF
   
   CALL apmt830_show()
   
   LET g_pmdadocno_t = g_pmda_m.pmdadocno
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      INPUT ARRAY g_pmdb_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = FALSE,
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
         BEFORE INPUT
            CALL apmt830_b_fill()
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_detail_idx)
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_pmdb_d.getLength()
            
         BEFORE ROW
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac

            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx

            CALL s_transaction_begin()
            OPEN apmt830_cl USING g_enterprise,g_pmda_m.pmdadocno
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = "OPEN apmt830_cl:"
               LET g_errparam.code   = STATUS
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               CLOSE apmt830_cl
               CALL s_transaction_end('N','0')
               RETURN
            END IF

            LET g_rec_b = g_pmdb_d.getLength()
            IF g_rec_b >= l_ac AND g_pmdb_d[l_ac].pmdbseq IS NOT NULL THEN
               LET l_cmd='u'
               LET g_pmdb_d_t.* = g_pmdb_d[l_ac].*  #BACKUP
               LET g_pmdb_d_o.* = g_pmdb_d[l_ac].*  #BACKUP
               CALL apmt830_set_entry_b(l_cmd)
               CALL apmt830_set_no_entry_b(l_cmd)
               IF NOT apmt830_lock_b("pmdb_t1","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH apmt830_upd_pmdb033 INTO g_pmdb_d[l_ac].pmdbseq,g_pmdb_d[l_ac].pmdb001,g_pmdb_d[l_ac].pmdb002, 
                      g_pmdb_d[l_ac].pmdb003,g_pmdb_d[l_ac].pmdbsite,g_pmdb_d[l_ac].pmdb200,g_pmdb_d[l_ac].pmdb004, 
                      g_pmdb_d[l_ac].pmdb005,g_pmdb_d[l_ac].pmdb033,g_pmdb_d[l_ac].pmdb037,g_pmdb_d[l_ac].pmdb260, 
                      g_pmdb_d[l_ac].pmdb038,g_pmdb_d[l_ac].pmdb201,g_pmdb_d[l_ac].pmdb202,g_pmdb_d[l_ac].pmdb212, 
                      g_pmdb_d[l_ac].pmdb007,g_pmdb_d[l_ac].pmdb006,g_pmdb_d[l_ac].pmdb253,g_pmdb_d[l_ac].pmdb258, 
                      g_pmdb_d[l_ac].pmdb254,g_pmdb_d[l_ac].pmdb255,g_pmdb_d[l_ac].pmdb256,g_pmdb_d[l_ac].pmdb257, 
                      g_pmdb_d[l_ac].pmdb259,g_pmdb_d[l_ac].pmdb252,g_pmdb_d[l_ac].pmdb207,g_pmdb_d[l_ac].pmdb015, 
                      g_pmdb_d[l_ac].pmdb049,g_pmdb_d[l_ac].pmdb030,g_pmdb_d[l_ac].pmdb048,g_pmdb_d[l_ac].pmdb208, 
                      g_pmdb_d[l_ac].pmdb209,g_pmdb_d[l_ac].pmdb206,g_pmdb_d[l_ac].pmdb210,g_pmdb_d[l_ac].pmdb211, 
                      g_pmdb_d[l_ac].pmdb205,g_pmdb_d[l_ac].pmdb203,g_pmdb_d[l_ac].pmdb204,g_pmdb_d[l_ac].pmdb032, 
                      g_pmdb_d[l_ac].pmdb051
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = g_pmdb_d_t.pmdbseq
                     LET g_errparam.code   = SQLCA.sqlcode
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  #遮罩相關處理
                  LET g_pmdb_d_mask_o[l_ac].* =  g_pmdb_d[l_ac].*
                  CALL apmt830_pmdb_t_mask()
                  LET g_pmdb_d_mask_n[l_ac].* =  g_pmdb_d[l_ac].*
                  LET g_bfill = "N"
                  CALL apmt830_show()
                  LET g_bfill = "Y"
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            
         AFTER FIELD pmdb033
         
         ON CHANGE pmdb033
            IF g_pmdb_d[l_ac].pmdb033 = 'Y' THEN
               #此項次的行狀態 != 1.一般，不可以修改緊急度！
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "apm-00882"
               LET g_errparam.extend = ""
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_pmdb_d[l_ac].pmdb032 = g_pmdb_d_t.pmdb033
               NEXT FIELD CURRENT
            END IF
         
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ''
               LET g_errparam.code   = 9001
               LET g_errparam.popup  = FALSE
               CALL cl_err()
               LET INT_FLAG = 0
               LET g_pmdb_d[l_ac].* = g_pmdb_d_t.*
               CLOSE apmt830_upd_pmdb033
               CALL s_transaction_end('N','0')
               EXIT DIALOG
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = g_pmdb_d[l_ac].pmdbseq
               LET g_errparam.code   = -263
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               LET g_pmdb_d[l_ac].* = g_pmdb_d_t.*
            ELSE
               #將遮罩欄位還原
               CALL apmt830_pmdb_t_mask_restore('restore_mask_o')
            
               UPDATE pmdb_t SET (pmdbdocno,pmdbseq,pmdb001,pmdb002,pmdb003,pmdbsite,pmdb200,pmdb004, 
                   pmdb005,pmdb033,pmdb037,pmdb260,pmdb038,pmdb201,pmdb202,pmdb212,pmdb007,pmdb006,pmdb253, 
                   pmdb258,pmdb254,pmdb255,pmdb256,pmdb257,pmdb259,pmdb252,pmdb207,pmdb015,pmdb049,pmdb030, 
                   pmdb048,pmdb208,pmdb209,pmdb206,pmdb210,pmdb211,pmdb205,pmdb203,pmdb204,pmdb032,pmdb051) = (g_pmda_m.pmdadocno, 
                   g_pmdb_d[l_ac].pmdbseq,g_pmdb_d[l_ac].pmdb001,g_pmdb_d[l_ac].pmdb002,g_pmdb_d[l_ac].pmdb003, 
                   g_pmdb_d[l_ac].pmdbsite,g_pmdb_d[l_ac].pmdb200,g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb005, 
                   g_pmdb_d[l_ac].pmdb033,g_pmdb_d[l_ac].pmdb037,g_pmdb_d[l_ac].pmdb260,g_pmdb_d[l_ac].pmdb038, 
                   g_pmdb_d[l_ac].pmdb201,g_pmdb_d[l_ac].pmdb202,g_pmdb_d[l_ac].pmdb212,g_pmdb_d[l_ac].pmdb007, 
                   g_pmdb_d[l_ac].pmdb006,g_pmdb_d[l_ac].pmdb253,g_pmdb_d[l_ac].pmdb258,g_pmdb_d[l_ac].pmdb254, 
                   g_pmdb_d[l_ac].pmdb255,g_pmdb_d[l_ac].pmdb256,g_pmdb_d[l_ac].pmdb257,g_pmdb_d[l_ac].pmdb259, 
                   g_pmdb_d[l_ac].pmdb252,g_pmdb_d[l_ac].pmdb207,g_pmdb_d[l_ac].pmdb015,g_pmdb_d[l_ac].pmdb049, 
                   g_pmdb_d[l_ac].pmdb030,g_pmdb_d[l_ac].pmdb048,g_pmdb_d[l_ac].pmdb208,g_pmdb_d[l_ac].pmdb209, 
                   g_pmdb_d[l_ac].pmdb206,g_pmdb_d[l_ac].pmdb210,g_pmdb_d[l_ac].pmdb211,g_pmdb_d[l_ac].pmdb205, 
                   g_pmdb_d[l_ac].pmdb203,g_pmdb_d[l_ac].pmdb204,g_pmdb_d[l_ac].pmdb032,g_pmdb_d[l_ac].pmdb051) 

                WHERE pmdbent = g_enterprise AND pmdbdocno = g_pmda_m.pmdadocno 
 
                  AND pmdbseq = g_pmdb_d_t.pmdbseq #項次   
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = "pmdb_t"
                     LET g_errparam.code   = "std-00009"
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     LET g_pmdb_d[l_ac].* = g_pmdb_d_t.*
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = "pmdb_t"
                     LET g_errparam.code   = SQLCA.sqlcode
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     LET g_pmdb_d[l_ac].* = g_pmdb_d_t.*
                  OTHERWISE
                     INITIALIZE gs_keys TO NULL
                     LET gs_keys[1] = g_pmda_m.pmdadocno
                     LET gs_keys_bak[1] = g_pmdadocno_t
                     LET gs_keys[2] = g_pmdb_d[g_detail_idx].pmdbseq
                     LET gs_keys_bak[2] = g_pmdb_d_t.pmdbseq
                     CALL apmt830_update_b('pmdb_t1',gs_keys,gs_keys_bak,"'1'")
               END CASE
            END IF
         
            #將遮罩欄位進行遮蔽
            CALL apmt830_pmdb_t_mask_restore('restore_mask_n')
         
            #判斷key是否有改變
            INITIALIZE gs_keys TO NULL
            IF NOT(g_pmdb_d[g_detail_idx].pmdbseq = g_pmdb_d_t.pmdbseq) THEN
               LET gs_keys[01] = g_pmda_m.pmdadocno
               LET gs_keys[gs_keys.getLength()+1] = g_pmdb_d_t.pmdbseq
               CALL apmt830_key_update_b(gs_keys,'pmdb_t1')
            END IF
         
            #修改歷程記錄
            LET g_log1 = util.JSON.stringify(g_pmda_m),util.JSON.stringify(g_pmdb_d_t)
            LET g_log2 = util.JSON.stringify(g_pmda_m),util.JSON.stringify(g_pmdb_d[l_ac])
            IF NOT cl_log_modified_record(g_log1,g_log2) THEN
               CALL s_transaction_end('N','0')
            END IF
         
         AFTER ROW
            CALL apmt830_unlock_b("pmdb_t1","'1'")
            CALL s_transaction_end('Y','0')
            
         AFTER INPUT
         
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
   
   CALL apmt830_b_fill()
   CLOSE apmt830_cl
   LET INT_FLAG = FALSE
END FUNCTION

################################################################################
# Descriptions...: 由條碼取的商品編號
# Memo...........:
# Usage..........: CALL apmt830_get_pmdb004(p_pmdb200)
#                  RETURNING r_pmdb004
# Input parameter: p_pmdb200      商品多條碼
# Return code....: r_pmdb004      商品編號
# Date & Author..: 2015/05/21 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt830_get_pmdb004(p_pmdb200)
DEFINE p_pmdb200      LIKE pmdb_t.pmdb200
DEFINE r_pmdb004      LIKE pmdb_t.pmdb004

   LET r_pmdb004 = ''
   SELECT imay001 INTO r_pmdb004 
     FROM imay_t 
    WHERE imayent = g_enterprise 
      AND imay003 = p_pmdb200
      
   RETURN r_pmdb004 
END FUNCTION

################################################################################
# Descriptions...: 檢查要貨單是否已經有轉採購單(狀態不為作廢)
# Memo...........:
# Usage..........: CALL apmt830_pmdadocno_chk(p_pmdadocno)
#                  RETURNING r_success
# Input parameter: p_pmdadocno    要貨單號
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 2015/05/25 By Ken  #150521-00028#1
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt830_pmdadocno_chk(p_pmdadocno)
DEFINE p_pmdadocno            LIKE pmda_t.pmdadocno
DEFINE l_pmdbdocno            LIKE pmdb_t.pmdbdocno
DEFINE l_pmdbseq              LIKE pmdb_t.pmdbseq
DEFINE l_pmdb006              LIKE pmdb_t.pmdb006
DEFINE l_pmdp023              LIKE pmdp_t.pmdp023
DEFINE l_pmdbcnt              LIKE type_t.num5
DEFINE l_cnt                  LIKE type_t.num5
DEFINE l_sql                  STRING
DEFINE r_success              LIKE type_t.num5

   LET r_success = TRUE
   LET l_pmdbcnt = 0
   LET l_cnt = 0
   
   LET l_sql = " SELECT pmdp023 ", 
               "   FROM pmdl_t,pmdn_t,pmdp_t ",
               "  WHERE pmdlent   = pmdnent ",
               "    AND pmdldocno = pmdndocno ",
               "    AND pmdlent   = pmdpent ",
               "    AND pmdndocno = pmdpdocno ",
               "    AND pmdnseq   = pmdpseq ",
               "    AND pmdlstus != 'X' ",
               "    AND pmdp003   = ? ",
               "    AND pmdp004   = ? "
   PREPARE pmdp023_pre FROM l_sql
                      
   LET l_sql = " SELECT pmdbdocno,pmdbseq,pmdb006 ",
               "   FROM pmdb_t ",
               "  WHERE pmdbent = ",g_enterprise,
               "    AND pmdbdocno = '",p_pmdadocno,"'",
               "    AND pmdb207 = '0' "
   PREPARE pmdadocno_chk_pre FROM l_sql
   DECLARE pmdadocno_chk_cur CURSOR FOR pmdadocno_chk_pre
   FOREACH pmdadocno_chk_cur INTO l_pmdbdocno,l_pmdbseq,l_pmdb006
      LET l_pmdbcnt = l_pmdbcnt + 1     #要拋轉的要貨單單身筆數
      EXECUTE pmdp023_pre USING l_pmdbdocno,l_pmdbseq INTO l_pmdp023
      IF l_pmdb006 = l_pmdp023 THEN
         LET l_cnt = l_cnt + 1          #要貨單的要貨數量與關聯單的要貨量一樣時+1
      END IF
   END FOREACH
      
  IF l_pmdbcnt = l_cnt THEN
     LET r_success = FALSE
  END IF
  
  RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 配送仓可用库存计算
# Memo...........:
# Usage..........: CALL apmt830_pmdb215_count(p_imaa001,p_site,p_imay012,p_inag003,p_pmdbsite)
#                  RETURNING 回传参数
# Input parameter: p_imaa001 料号
#                : p_site    配送中心
#                : p_imay012 产品特征
#                : p_inag003 库存管理特征
#                : p_pmdbsite 需求组织
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 20161029 By geza
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt830_pmdb215_count(p_imaa001,p_site,p_imay012,p_inag003,p_pmdbsite)
DEFINE p_imaa001             LIKE imaa_t.imaa001     #料号
DEFINE p_site                LIKE pmda_t.pmdasite    #配送中心
DEFINE p_imay012             LIKE imay_t.imay012     #产品特征
DEFINE l_amount              LIKE inag_t.inag009     #数量   
DEFINE l_inag009             LIKE inag_t.inag009     #数量
DEFINE p_inag003             LIKE inag_t.inag003     #库存管理特征
DEFINE p_pmdbsite            LIKE pmda_t.pmdasite    #需求组织
DEFINE p_inag004             LIKE inag_t.inag004     #库位
DEFINE p_inag007             LIKE inag_t.inag007     #库存单位
DEFINE l_inaasite            LIKE inaa_t.inaasite
DEFINE l_rtdx029             LIKE rtdx_t.rtdx029
   #抓取库位
   CALL s_aint700_adbi261_inv_scope_def(p_site,p_imaa001,p_pmdbsite,'Y')         
               RETURNING l_inaasite,p_inag004 #add by geza 201611206 161124-00039#1
   #抓库存单位
   LET p_inag007 =''
   SELECT imaa104 INTO p_inag007
     FROM imaa_t
    WHERE imaaent = g_enterprise
      AND imaa001 = p_imaa001             
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
   
   #CALL s_get_inag009_valid(p_site,p_imaa001,p_imay012,l_amount,'2') RETURNING l_inag009 #mark by geza 20161208 #161124-00039#1
   CALL s_get_inag009_valid(p_pmdbsite,p_imaa001,p_imay012,l_amount,'2',p_inag003,p_inag004,p_inag007,p_site) RETURNING l_inag009 #add by geza 20161208 #161124-00039#1
   
   
   RETURN  l_inag009  
END FUNCTION
################################################################################
# Descriptions...: 取得年份、季节、性别、上下装、大类、吊牌价
# Memo...........:
# Usage..........: CALL apmt830_get_imaa(p_imaa001)
#                  RETURNING r_imaa154,r_imaa155,r_imaa156,r_imaa132,r_imaa128,r_imaa157
# Input parameter: p_imaa001      商品編號
# Return code....: r_imaa154      年份
#                  r_imaa155      季节
#                  r_imaa156      性别
#                  r_imaa132      上下装
#                  r_imaa128      大类
#                  r_imaa157      吊牌价
# Date & Author..: 2016-10-30 By stcshy
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt830_get_imaa(p_imaa001)
DEFINE p_imaa001          LIKE imaa_t.imaa001
DEFINE r_imaa154          LIKE imaa_t.imaa154
DEFINE r_imaa155          LIKE imaa_t.imaa155
DEFINE r_imaa156          LIKE imaa_t.imaa156
DEFINE r_imaa132          LIKE imaa_t.imaa132
DEFINE r_imaa128          LIKE imaa_t.imaa128
#DEFINE r_imaa157          LIKE imaa_t.imaa157  #161129-00067#2 by 08172
DEFINE r_imaa116          LIKE imaa_t.imaa116   #161129-00067#2 by 08172
DEFINE r_rtaw001          LIKE rtaw_t.rtaw001 #add by sunxh 161221 #161214-00004#3
DEFINE r_imaa009          LIKE imaa_t.imaa009 #add by sunxh 161221 #161214-00004#3

   LET r_imaa154=NULL
   LET r_imaa155=NULL
   LET r_imaa156=NULL
   LET r_imaa132=NULL
   LET r_imaa128=NULL
   LET r_rtaw001=NULL #add by sunxh 20161221 #161214-00004#3  
   LET r_imaa009=NULL 
   #161129-00067#2 -s by 08172
   LET r_imaa116=NULL
#   LET r_imaa157=NULL
   
#   SELECT imaa154,imaa155,imaa156,imaa132,imaa128,imaa157 INTO r_imaa154,r_imaa155,r_imaa156,r_imaa132,r_imaa128,r_imaa157 FROM imaa_t 
   SELECT imaa154,imaa155,imaa156,imaa132,imaa128,imaa116 INTO r_imaa154,r_imaa155,r_imaa156,r_imaa132,r_imaa128,r_imaa116 FROM imaa_t 
   #161129-00067#2 -e by 08172
    WHERE imaaent = g_enterprise AND imaa001 = p_imaa001
   
   #161214-00004#3 mod by sunxh 161221(S)
   SELECT imaa009 into r_imaa009 FROM imaa_t
   WHERE imaaent = g_enterprise AND imaa001 = p_imaa001
   #抓取大類
   SELECT rtaw001 INTO r_rtaw001
     FROM rtaw_t 
    WHERE rtawent = g_enterprise
      AND rtaw003 = '1'
      AND rtaw002 = r_imaa009
   #161214-00004#3 mod by sunxh 161221(E)
   
   RETURN r_imaa154,r_imaa155,r_imaa156,r_imaa132,r_rtaw001,r_imaa116  #161214-00004#3 mod by sunxh 161221
   #161129-00067#2 -s by 08172
#   RETURN r_imaa154,r_imaa155,r_imaa156,r_imaa132,r_imaa128,r_imaa157
#   RETURN r_imaa154,r_imaa155,r_imaa156,r_imaa132,r_imaa128,r_imaa116
   #161129-00067#2 -e by 08172
END FUNCTION

################################################################################
# Descriptions...: 依收貨組織+商品編號+库位 抓取庫存量
# Memo...........:
# Usage..........: CALL apmt830_sum_inag009(p_inagsite,p_inag001,p_inag002)
#                     RETURNING r_inag008
# Input parameter: p_inagsite     營運組織
#                : p_inag001      商品編號
#                : p_inag002      產品特徵
# Return code....: r_inag008      庫存量
# Date & Author..: 2016/12/12     geza
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt830_sum_inag009(p_inagsite,p_inag001,p_inag002)
DEFINE p_inagsite         LIKE inag_t.inagsite
DEFINE p_inag001          LIKE inag_t.inag001
DEFINE p_inag002          LIKE inag_t.inag002
DEFINE r_inag009          LIKE inag_t.inag009
DEFINE l_ooef123          LIKE ooef_t.ooef123

   WHENEVER ERROR CONTINUE
    
   LET r_inag009 = 0
   IF cl_null(p_inagsite) OR cl_null(p_inag001) THEN
      RETURN r_inag009
   END IF
   LET l_ooef123 =''
   SELECT ooef123 INTO l_ooef123
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = p_inagsite
      AND ooefstus = 'Y'
   
   SELECT COALESCE(SUM(inag009),0) INTO r_inag009
     FROM inag_t
    WHERE inagent = g_enterprise
      AND inagsite = p_inagsite
      AND inag001 = p_inag001
      AND inag002 = COALESCE(p_inag002,inag002)
      AND inag004 = l_ooef123
     # AND inag010 = 'Y'        
      
   RETURN r_inag009
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apmt830_committed_input()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: #161220-00059#2 2016/12/21 by 08172
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt830_committed_input()
   DEFINE r_success     LIKE type_t.num5
   LET r_success = TRUE
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      INPUT BY NAME g_pmda_m.pmda022  ATTRIBUTE(WITHOUT DEFAULTS)
         AFTER FIELD pmda022
            DISPLAY BY NAME g_pmda_m.pmda022         
         AFTER INPUT
            CALL s_transaction_begin()
            UPDATE pmda_t 
               SET pmda022 = g_pmda_m.pmda022
             WHERE pmdaent = g_enterprise
               AND pmdadocno = g_pmda_m.pmdadocno
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "upd pmda022"
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CALL s_transaction_end('N','0')
               LET r_success = FALSE
               RETURN r_success
            END IF
            CALL s_transaction_end('Y','0')
      END INPUT
      
      INPUT ARRAY g_pmdb_d FROM s_detail1.*
            ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                     INSERT ROW = FALSE, 
                     DELETE ROW = FALSE,
                     APPEND ROW = FALSE)
            
         BEFORE INPUT
            LET g_current_page = 1
            CALL cl_set_act_visible("filter",FALSE)
            IF g_pmda_m.pmdastus = 'TJ' THEN
               CALL cl_set_comp_entry("pmdbseq",FALSE)     #項次
               CALL cl_set_comp_entry("pmdbsite",FALSE)    #要貨組織
               CALL cl_set_comp_entry("pmdb200",FALSE)     #商品條碼
               CALL cl_set_comp_entry("pmdb004",FALSE)     #商品編號
               CALL cl_set_comp_entry("pmdb005",FALSE)     #產品特徵
               CALL cl_set_comp_entry("pmdb037",FALSE)     #收貨組織
               CALL cl_set_comp_entry("pmdb260",FALSE)     #收貨部門
               CALL cl_set_comp_entry("pmdb038",FALSE)     #庫位
               CALL cl_set_comp_entry("pmdb212",FALSE)     #包裝數量
               CALL cl_set_comp_entry("pmdb007",FALSE)     #要貨單位
               CALL cl_set_comp_entry("pmdb006",TRUE)     #要貨數量
               CALL cl_set_comp_entry("pmdb030",FALSE)     #需求數量
               CALL cl_set_comp_entry("pmdb048",FALSE)     #收貨時段
               CALL cl_set_comp_entry("pmdb210",FALSE)     #促銷開始日
               CALL cl_set_comp_entry("pmdb211",FALSE)     #促銷結束日
               CALL cl_set_comp_entry("pmdb204",FALSE)     #配送倉庫
               CALL cl_set_comp_entry("pmdb051",FALSE)     #結案/留置原因碼
               CALL cl_set_comp_entry("pmdb033",FALSE)     #緊急度
               CALL cl_set_comp_entry("pmdb213",FALSE)     #参考进价
            END IF
            
         BEFORE ROW
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            LET l_ac = g_detail_idx
            DISPLAY g_detail_idx TO FORMONLY.h_index
            DISPLAY g_pmdb_d.getLength() TO FORMONLY.h_count
            CALL apmt830_b_fill()
            LET g_pmdb_d_t.* = g_pmdb_d[g_detail_idx].*
            CALL s_transaction_begin()
         AFTER FIELD pmdb006
            #對要貨數量進行取位
            CALL s_aooi250_take_decimals(g_pmdb_d[l_ac].pmdb007,g_pmdb_d[l_ac].pmdb006) 
               RETURNING r_success,g_pmdb_d[l_ac].pmdb006
            #換算要貨件數
            IF NOT cl_null(g_pmdb_d[l_ac].pmdb007) THEN
               CALL s_aooi250_convert_qty(g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb007,g_pmdb_d[l_ac].pmdb201,g_pmdb_d[l_ac].pmdb006)
                   RETURNING r_success,g_pmdb_d[l_ac].pmdb212
            END IF     
            IF cl_null(g_pmdb_d[l_ac].pmdb006) THEN
               LET g_pmdb_d[l_ac].pmdb212 = null
            END IF
         AFTER ROW
            UPDATE pmdb_t 
               SET pmdb006 = g_pmdb_d[l_ac].pmdb006,pmdb212 = g_pmdb_d[l_ac].pmdb212
             WHERE pmdbent = g_enterprise
               AND pmdbdocno = g_pmda_m.pmdadocno
               AND pmdbseq = g_pmdb_d[l_ac].pmdbseq
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "upd pmdb006"
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CALL s_transaction_end('N','0')
               LET r_success = FALSE
               RETURN r_success
            END IF
            CALL s_transaction_end('Y','0')
     END INPUT
     ON ACTION accept
         ACCEPT DIALOG
      
      ON ACTION cancel
         LET INT_FLAG = TRUE
         EXIT DIALOG
      
      ON ACTION exit
         LET INT_FLAG = TRUE
         EXIT DIALOG
      
      ON ACTION close
         LET INT_FLAG = TRUE
         EXIT DIALOG
   END DIALOG
   
   IF INT_FLAG THEN
      LET INT_FLAG = FALSE
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   
   IF g_pmda_m.pmdastus = 'TJ' THEN
      CALL cl_set_comp_entry("pmdbseq",TRUE)     #項次
      CALL cl_set_comp_entry("pmdbsite",TRUE)    #要貨組織
      CALL cl_set_comp_entry("pmdb200",TRUE)     #商品條碼
      CALL cl_set_comp_entry("pmdb004",TRUE)     #商品編號
      CALL cl_set_comp_entry("pmdb005",TRUE)     #產品特徵
      CALL cl_set_comp_entry("pmdb037",TRUE)     #收貨組織
      CALL cl_set_comp_entry("pmdb260",TRUE)     #收貨部門
      CALL cl_set_comp_entry("pmdb038",TRUE)     #庫位
      CALL cl_set_comp_entry("pmdb212",TRUE)     #包裝數量
      CALL cl_set_comp_entry("pmdb007",TRUE)     #要貨單位
      CALL cl_set_comp_entry("pmdb006",TRUE)     #要貨數量
      CALL cl_set_comp_entry("pmdb030",TRUE)     #需求數量
      CALL cl_set_comp_entry("pmdb048",TRUE)     #收貨時段
      CALL cl_set_comp_entry("pmdb210",TRUE)     #促銷開始日
      CALL cl_set_comp_entry("pmdb211",TRUE)     #促銷結束日
      CALL cl_set_comp_entry("pmdb204",TRUE)     #配送倉庫
      CALL cl_set_comp_entry("pmdb051",TRUE)     #結案/留置原因碼
      CALL cl_set_comp_entry("pmdb033",TRUE)     #緊急度
      CALL cl_set_comp_entry("pmdb213",TRUE)     #参考进价
   END IF
   CALL apmt830_b_fill() 
   
   RETURN r_success     
END FUNCTION

################################################################################
# Descriptions...: 配送仓预计可用量
# Memo...........:
# Usage..........: CALL apmt830_inas011_count(p_pmdb004,p_pmdb005,p_pmdb007,p_pmdb203,p_pmdb204)
#                  RETURNING r_amount
# Input parameter: p_pmdb004     商品编号
#                : p_pmdb005     商品特征
#                : p_pmdb007     单位
#                : p_pmdb203     配送中心
#                : p_pmdb204     配送仓库
# Return code....: r_amount      配送仓预计可用量
# Date & Author..: #170116-00018#1 20170116 by 08172 
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt830_inas011_count(p_pmdb004,p_pmdb005,p_pmdb007,p_pmdb203,p_pmdb204)
   DEFINE p_pmdb004     LIKE pmdb_t.pmdb004
   DEFINE p_pmdb005     LIKE pmdb_t.pmdb005
   DEFINE p_pmdb007     LIKE pmdb_t.pmdb007
   DEFINE p_pmdb203     LIKE pmdb_t.pmdb203
   DEFINE p_pmdb204     LIKE pmdb_t.pmdb204
   DEFINE r_amount      LIKE inag_t.inag009
   DEFINE l_sql         STRING
   DEFINE l_inas011     LIKE inas_t.inas011
   DEFINE l_amount      LIKE inag_t.inag009
   
   #抓库存
   LET l_amount = 0
   SELECT SUM(inag009) INTO l_amount
     FROM inag_t
    WHERE inagent = g_enterprise
      AND inag001 = p_pmdb004
      AND inag002 = p_pmdb005
      AND inag004 = p_pmdb204 
      AND inag007 = p_pmdb007 
      AND inagsite = p_pmdb203 
      
   LET l_sql = " SELECT COALESCE(SUM(inas011),0) ",
               "   FROM inas_t",
               "  WHERE inasent = ",g_enterprise,
               "    AND inassite = '",p_pmdb203,"'",
               "    AND inas009 = '",p_pmdb004,"'",
               "    AND inas010 = '",p_pmdb005,"'",
               "    AND inas013 = '",p_pmdb007,"'"
   PREPARE apmt830_inas011_count_pr FROM l_sql
   EXECUTE apmt830_inas011_count_pr INTO l_inas011   
   LET r_amount = l_amount-l_inas011
   
   RETURN r_amount
END FUNCTION

################################################################################
# Descriptions...: 配送仓取值
# Memo...........:
# Usage..........: CALL apmt830_get_inaa001(p_pmdb203,p_pmdb004,p_pmdbsite)
#                  RETURNING r_pmdb204
# Input parameter: p_pmdb203      配送中心
#                : p_pmdb004      商品编号
#                : p_pmdbsite     需求组织
# Return code....: r_pmdb204      配送仓
# Date & Author..: #170116-00018#1 20170117 by 08172
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt830_get_inaa001(p_pmdb203,p_pmdb004,p_pmdbsite)
   DEFINE p_pmdb203    LIKE pmdb_t.pmdb203
   DEFINE p_pmdb004    LIKE pmdb_t.pmdb204
   DEFINE p_pmdbsite   LIKE pmdb_t.pmdbsite
   DEFINE r_pmdb204    LIKE pmdb_t.pmdb204
   DEFINE l_sql        STRING
   DEFINE l_sel_sql    STRING
   DEFINE l_sql3       STRING
   DEFINE l_inaasite   LIKE inaa_t.inaasite
   DEFINE l_inaa142    LIKE inaa_t.inaa142
   DEFINE l_inaa010    LIKE inaa_t.inaa010
   
   #抓取库位
   LET l_sel_sql = "SELECT UNIQUE inaasite, inaa001,inaa142,inaa010 " 
   LET l_sql3 = s_aint700_adbi261_sql('N','Y')  
   LET l_sql = l_sel_sql,l_sql3
   PREPARE apmt830_adbi261_sel_pr FROM l_sql
   DECLARE apmt830_adbi261_sel_cur SCROLL CURSOR FOR apmt830_adbi261_sel_pr
   OPEN apmt830_adbi261_sel_cur USING p_pmdb203,p_pmdb004,p_pmdbsite
   FETCH FIRST apmt830_adbi261_sel_cur INTO l_inaasite,r_pmdb204,l_inaa142,l_inaa010
   CLOSE apmt830_adbi261_sel_cur
   
   RETURN r_pmdb204
END FUNCTION

 
{</section>}
 
