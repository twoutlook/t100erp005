#該程式未解開Section, 採用最新樣板產出!
{<section id="aglt501.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0010(2015-03-18 14:32:30), PR版次:0010(2016-12-20 18:51:13)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000068
#+ Filename...: aglt501
#+ Description: 合併報表公司科目餘額暫存資料維護作業-非T100公司
#+ Creator....: 03080(2015-03-03 18:20:08)
#+ Modifier...: 03080 -SD/PR- 08171
 
{</section>}
 
{<section id="aglt501.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#160321-00016#31   2016/03/25  By Jessy         修正azzi920重複定義之錯誤訊息
#160816-00068#6    2016/08/16  By earl          調整transaction
#160818-00017#15   2016/08/24  By 07900         删除修改未重新判断状态码
#160913-00017#4    2016/09/21  By 07900         AGL模组调整交易客商开窗
#161021-00037#4    2016/10/24  By 06821         組織類型與職能開窗調整
#161111-00028#9    2016/11/24  by 02481         标准程式定义采用宣告模式,弃用.*写法
#160824-00007#260  2016/12/20  By 08171         新舊值調整
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
PRIVATE type type_g_glfg_m        RECORD
       glfg001 LIKE glfg_t.glfg001, 
   glfg001_desc LIKE type_t.chr80, 
   glfg002 LIKE glfg_t.glfg002, 
   glfg002_desc LIKE type_t.chr80, 
   glfg005 LIKE glfg_t.glfg005, 
   glfg006 LIKE glfg_t.glfg006, 
   glfg007 LIKE glfg_t.glfg007, 
   glfg008 LIKE glfg_t.glfg008, 
   glfg009 LIKE glfg_t.glfg009, 
   glfgstus LIKE glfg_t.glfgstus, 
   glfgownid LIKE glfg_t.glfgownid, 
   glfgownid_desc LIKE type_t.chr80, 
   glfgowndp LIKE glfg_t.glfgowndp, 
   glfgowndp_desc LIKE type_t.chr80, 
   glfgcrtid LIKE glfg_t.glfgcrtid, 
   glfgcrtid_desc LIKE type_t.chr80, 
   glfgcrtdp LIKE glfg_t.glfgcrtdp, 
   glfgcrtdp_desc LIKE type_t.chr80, 
   glfgcrtdt LIKE glfg_t.glfgcrtdt, 
   glfgmodid LIKE glfg_t.glfgmodid, 
   glfgmodid_desc LIKE type_t.chr80, 
   glfgmoddt LIKE glfg_t.glfgmoddt, 
   glfgcnfid LIKE glfg_t.glfgcnfid, 
   glfgcnfid_desc LIKE type_t.chr80, 
   glfgcnfdt LIKE glfg_t.glfgcnfdt, 
   l_gldh008 LIKE type_t.chr100, 
   l_gldh009 LIKE type_t.chr100, 
   l_gldh010 LIKE type_t.chr100, 
   l_gldh011 LIKE type_t.chr100, 
   l_gldh012 LIKE type_t.chr100, 
   l_gldh013 LIKE type_t.chr100, 
   l_gldh014 LIKE type_t.chr100, 
   l_gldh015 LIKE type_t.chr100, 
   l_gldh016 LIKE type_t.chr100, 
   l_gldh017 LIKE type_t.chr100, 
   l_gldh018 LIKE type_t.chr100, 
   l_gldh019 LIKE type_t.chr100, 
   l_gldh020 LIKE type_t.chr100, 
   l_gldh021 LIKE type_t.chr100
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_gldh_d        RECORD
       gldh007 LIKE gldh_t.gldh007, 
   gldh003 LIKE gldh_t.gldh003, 
   gldh004 LIKE gldh_t.gldh004, 
   gldh025 LIKE gldh_t.gldh025, 
   gldh026 LIKE gldh_t.gldh026, 
   gldh028 LIKE gldh_t.gldh028, 
   gldh029 LIKE gldh_t.gldh029, 
   gldh031 LIKE gldh_t.gldh031, 
   gldh032 LIKE gldh_t.gldh032, 
   gldh008 LIKE gldh_t.gldh008, 
   gldh009 LIKE gldh_t.gldh009, 
   gldh010 LIKE gldh_t.gldh010, 
   gldh011 LIKE gldh_t.gldh011, 
   gldh012 LIKE gldh_t.gldh012, 
   gldh013 LIKE gldh_t.gldh013, 
   gldh014 LIKE gldh_t.gldh014, 
   gldh015 LIKE gldh_t.gldh015, 
   gldh016 LIKE gldh_t.gldh016, 
   gldh017 LIKE gldh_t.gldh017, 
   gldh018 LIKE gldh_t.gldh018, 
   gldh019 LIKE gldh_t.gldh019, 
   gldh020 LIKE gldh_t.gldh020, 
   gldh021 LIKE gldh_t.gldh021, 
   gldh022 LIKE gldh_t.gldh022, 
   gldh023 LIKE gldh_t.gldh023, 
   gldh024 LIKE gldh_t.gldh024, 
   gldh027 LIKE gldh_t.gldh027, 
   gldh030 LIKE gldh_t.gldh030
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_glfg001 LIKE glfg_t.glfg001,
      b_glfg002 LIKE glfg_t.glfg002,
      b_glfg005 LIKE glfg_t.glfg005,
      b_glfg006 LIKE glfg_t.glfg006
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_gldh_ar DYNAMIC ARRAY OF RECORD
          chr       LIKE type_t.chr1000,
          dat       LIKE type_t.dat
          END RECORD
DEFINE g_aglt501_01 DYNAMIC ARRAY OF RECORD
          chr       LIKE type_t.chr1000,
          dat       LIKE type_t.dat
          END RECORD
#161111-00028#9---modify---begin----------          
#DEFINE g_glaa      RECORD LIKE glaa_t.*    #帳套設定
#DEFINE g_glda      RECORD LIKE glda_t.*    #個體公司基本資料
#DEFINE g_glad      RECORD LIKE glad_t.*    #會科設定
DEFINE g_glad RECORD  #帳套科目管理設定檔
       gladent LIKE glad_t.gladent, #企業編號
       gladownid LIKE glad_t.gladownid, #資料所有者
       gladowndp LIKE glad_t.gladowndp, #資料所屬部門
       gladcrtid LIKE glad_t.gladcrtid, #資料建立者
       gladcrtdp LIKE glad_t.gladcrtdp, #資料建立部門
       gladcrtdt LIKE glad_t.gladcrtdt, #資料創建日
       gladmodid LIKE glad_t.gladmodid, #資料修改者
       gladmoddt LIKE glad_t.gladmoddt, #最近修改日
       gladstus LIKE glad_t.gladstus, #狀態碼
       gladld LIKE glad_t.gladld, #帳套
       glad001 LIKE glad_t.glad001, #會計科目編號
       glad002 LIKE glad_t.glad002, #是否按餘額類型產生分錄
       glad003 LIKE glad_t.glad003, #啟用傳票項次細項立沖
       glad004 LIKE glad_t.glad004, #傳票項次異動別
       glad005 LIKE glad_t.glad005, #是否啟用數量金額式
       glad006 LIKE glad_t.glad006, #借方現金變動碼
       glad007 LIKE glad_t.glad007, #啟用部門管理
       glad008 LIKE glad_t.glad008, #啟用利潤成本管理
       glad009 LIKE glad_t.glad009, #啟用區域管理
       glad010 LIKE glad_t.glad010, #啟用收付款客商管理
       glad011 LIKE glad_t.glad011, #啟用客群管理
       glad012 LIKE glad_t.glad012, #啟用產品類別管理
       glad013 LIKE glad_t.glad013, #啟用人員管理
       glad014 LIKE glad_t.glad014, #no use
       glad015 LIKE glad_t.glad015, #啟用專案管理
       glad016 LIKE glad_t.glad016, #啟用WBS管理
       glad017 LIKE glad_t.glad017, #啟用自由核算項一
       glad0171 LIKE glad_t.glad0171, #自由核算項一類型編號
       glad0172 LIKE glad_t.glad0172, #自由核算項一控制方式
       glad018 LIKE glad_t.glad018, #啟用自由核算項二
       glad0181 LIKE glad_t.glad0181, #自由核算項二類型編號
       glad0182 LIKE glad_t.glad0182, #自由核算項二控制方式
       glad019 LIKE glad_t.glad019, #啟用自由核算項三
       glad0191 LIKE glad_t.glad0191, #自由核算項三類型編號
       glad0192 LIKE glad_t.glad0192, #自由核算項三控制方式
       glad020 LIKE glad_t.glad020, #啟用自由核算項四
       glad0201 LIKE glad_t.glad0201, #自由核算項四類型編號
       glad0202 LIKE glad_t.glad0202, #自由核算項四控制方式
       glad021 LIKE glad_t.glad021, #啟用自由核算項五
       glad0211 LIKE glad_t.glad0211, #自由核算項五類型編號
       glad0212 LIKE glad_t.glad0212, #自由核算項五控制方式
       glad022 LIKE glad_t.glad022, #啟用自由核算項六
       glad0221 LIKE glad_t.glad0221, #自由核算項六類型編號
       glad0222 LIKE glad_t.glad0222, #自由核算項六控制方式
       glad023 LIKE glad_t.glad023, #啟用自由核算項七
       glad0231 LIKE glad_t.glad0231, #自由核算項七類型編號
       glad0232 LIKE glad_t.glad0232, #自由核算項七控制方式
       glad024 LIKE glad_t.glad024, #啟用自由核算項八
       glad0241 LIKE glad_t.glad0241, #自由核算項八類型編號
       glad0242 LIKE glad_t.glad0242, #自由核算項八控制方式
       glad025 LIKE glad_t.glad025, #啟用自由核算項九
       glad0251 LIKE glad_t.glad0251, #自由核算項九類型編號
       glad0252 LIKE glad_t.glad0252, #自由核算項九控制方式
       glad026 LIKE glad_t.glad026, #啟用自由核算項十
       glad0261 LIKE glad_t.glad0261, #自由核算項十類型編號
       glad0262 LIKE glad_t.glad0262, #自由核算項十控制方式
       glad027 LIKE glad_t.glad027, #啟用帳款客商管理
       glad030 LIKE glad_t.glad030, #是否進行預算管控
       glad031 LIKE glad_t.glad031, #啟用經營方式管理
       glad032 LIKE glad_t.glad032, #啟用渠道管理
       glad033 LIKE glad_t.glad033, #啟用品牌管理
       glad034 LIKE glad_t.glad034, #科目做多幣別管理
       glad035 LIKE glad_t.glad035, #是否是子系統科目
       glad036 LIKE glad_t.glad036  #貸方現金變動碼
       END RECORD

DEFINE g_glda RECORD  #個體公司基本資料檔
       gldaent LIKE glda_t.gldaent, #企業編號
       gldaownid LIKE glda_t.gldaownid, #資料所有者
       gldaowndp LIKE glda_t.gldaowndp, #資料所屬部門
       gldacrtid LIKE glda_t.gldacrtid, #資料建立者
       gldacrtdp LIKE glda_t.gldacrtdp, #資料建立部門
       gldacrtdt LIKE glda_t.gldacrtdt, #資料創建日
       gldamodid LIKE glda_t.gldamodid, #資料修改者
       gldamoddt LIKE glda_t.gldamoddt, #最近修改日
       gldastus LIKE glda_t.gldastus, #狀態碼
       glda001 LIKE glda_t.glda001, #公司編號
       glda002 LIKE glda_t.glda002, #使用T100
       glda003 LIKE glda_t.glda003, #法人營運據點編號
       glda004 LIKE glda_t.glda004  #關係人編號
       END RECORD

DEFINE g_glaa RECORD  #帳套資料檔
       glaaent LIKE glaa_t.glaaent, #企業編號
       glaaownid LIKE glaa_t.glaaownid, #資料所有者
       glaaowndp LIKE glaa_t.glaaowndp, #資料所屬部門
       glaacrtid LIKE glaa_t.glaacrtid, #資料建立者
       glaacrtdp LIKE glaa_t.glaacrtdp, #資料建立部門
       glaacrtdt LIKE glaa_t.glaacrtdt, #資料創建日
       glaamodid LIKE glaa_t.glaamodid, #資料修改者
       glaamoddt LIKE glaa_t.glaamoddt, #最近修改日
       glaastus LIKE glaa_t.glaastus, #狀態碼
       glaald LIKE glaa_t.glaald, #帳套編號
       glaacomp LIKE glaa_t.glaacomp, #歸屬法人
       glaa001 LIKE glaa_t.glaa001, #使用幣別
       glaa002 LIKE glaa_t.glaa002, #匯率參照表號
       glaa003 LIKE glaa_t.glaa003, #會計週期參照表號
       glaa004 LIKE glaa_t.glaa004, #會計科目參照表號
       glaa005 LIKE glaa_t.glaa005, #現金變動參照表號
       glaa006 LIKE glaa_t.glaa006, #月結方式
       glaa007 LIKE glaa_t.glaa007, #年結方式
       glaa008 LIKE glaa_t.glaa008, #平行記帳否
       glaa009 LIKE glaa_t.glaa009, #傳票登入方式
       glaa010 LIKE glaa_t.glaa010, #現行年度
       glaa011 LIKE glaa_t.glaa011, #現行期別
       glaa012 LIKE glaa_t.glaa012, #最後過帳日期
       glaa013 LIKE glaa_t.glaa013, #關帳日期
       glaa014 LIKE glaa_t.glaa014, #主帳套
       glaa015 LIKE glaa_t.glaa015, #啟用本位幣二
       glaa016 LIKE glaa_t.glaa016, #本位幣二
       glaa017 LIKE glaa_t.glaa017, #本位幣二換算基準
       glaa018 LIKE glaa_t.glaa018, #本位幣二匯率採用
       glaa019 LIKE glaa_t.glaa019, #啟用本位幣三
       glaa020 LIKE glaa_t.glaa020, #本位幣三
       glaa021 LIKE glaa_t.glaa021, #本位幣三換算基準
       glaa022 LIKE glaa_t.glaa022, #本位幣三匯率採用
       glaa023 LIKE glaa_t.glaa023, #次帳套帳務產生時機
       glaa024 LIKE glaa_t.glaa024, #單據別參照表號
       glaa025 LIKE glaa_t.glaa025, #本位幣一匯率採用
       glaa026 LIKE glaa_t.glaa026, #幣別參照表號
       glaa100 LIKE glaa_t.glaa100, #傳票輸入時自動按缺號產生
       glaa101 LIKE glaa_t.glaa101, #傳票總號輸入時機
       glaa102 LIKE glaa_t.glaa102, #傳票成立時,借貸不平衡的處理方式
       glaa103 LIKE glaa_t.glaa103, #未列印的傳票可否進行過帳
       glaa111 LIKE glaa_t.glaa111, #應計調整單別
       glaa112 LIKE glaa_t.glaa112, #期末結轉單別
       glaa113 LIKE glaa_t.glaa113, #年底結轉單別
       glaa120 LIKE glaa_t.glaa120, #成本計算類型
       glaa121 LIKE glaa_t.glaa121, #子模組啟用分錄底稿
       glaa122 LIKE glaa_t.glaa122, #總帳可維護資金異動明細
       glaa027 LIKE glaa_t.glaa027, #單據據點編號
       glaa130 LIKE glaa_t.glaa130, #合併帳套否
       glaa131 LIKE glaa_t.glaa131, #分層合併
       glaa132 LIKE glaa_t.glaa132, #平均匯率計算方式
       glaa133 LIKE glaa_t.glaa133, #非T100公司匯入餘額類型
       glaa134 LIKE glaa_t.glaa134, #合併科目轉換依據異動碼設定值
       glaa135 LIKE glaa_t.glaa135, #現流表間接法群組參照表號
       glaa136 LIKE glaa_t.glaa136, #應收帳款核銷限定己立帳傳票
       glaa137 LIKE glaa_t.glaa137, #應付帳款核銷限定已立帳傳票
       glaa138 LIKE glaa_t.glaa138, #合併報表編制期別
       glaa139 LIKE glaa_t.glaa139, #遞延收入(負債)管理產生否
       glaa140 LIKE glaa_t.glaa140, #無原出貨單的遞延負債減項者,是否仍立遞延收入管理?
       glaa123 LIKE glaa_t.glaa123, #應收帳款核銷可維護資金異動明細
       glaa124 LIKE glaa_t.glaa124, #應付帳款核銷可維護資金異動明細
       glaa028 LIKE glaa_t.glaa028  #匯率來源
END RECORD
#161111-00028#9---modify---end----------
DEFINE g_gldh007_t LIKE gldh_t.gldh007     #存舊值判斷是否變 
#end add-point
       
#模組變數(Module Variables)
DEFINE g_glfg_m          type_g_glfg_m
DEFINE g_glfg_m_t        type_g_glfg_m
DEFINE g_glfg_m_o        type_g_glfg_m
DEFINE g_glfg_m_mask_o   type_g_glfg_m #轉換遮罩前資料
DEFINE g_glfg_m_mask_n   type_g_glfg_m #轉換遮罩後資料
 
   DEFINE g_glfg001_t LIKE glfg_t.glfg001
DEFINE g_glfg002_t LIKE glfg_t.glfg002
DEFINE g_glfg005_t LIKE glfg_t.glfg005
DEFINE g_glfg006_t LIKE glfg_t.glfg006
 
 
DEFINE g_gldh_d          DYNAMIC ARRAY OF type_g_gldh_d
DEFINE g_gldh_d_t        type_g_gldh_d
DEFINE g_gldh_d_o        type_g_gldh_d
DEFINE g_gldh_d_mask_o   DYNAMIC ARRAY OF type_g_gldh_d #轉換遮罩前資料
DEFINE g_gldh_d_mask_n   DYNAMIC ARRAY OF type_g_gldh_d #轉換遮罩後資料
 
 
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
 
{<section id="aglt501.main" >}
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
   CALL cl_ap_init("agl","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT glfg001,'',glfg002,'',glfg005,glfg006,glfg007,glfg008,glfg009,glfgstus, 
       glfgownid,'',glfgowndp,'',glfgcrtid,'',glfgcrtdp,'',glfgcrtdt,glfgmodid,'',glfgmoddt,glfgcnfid, 
       '',glfgcnfdt,'','','','','','','','','','','','','',''", 
                      " FROM glfg_t",
                      " WHERE glfgent= ? AND glfg001=? AND glfg002=? AND glfg005=? AND glfg006=? FOR  
                          UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aglt501_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.glfg001,t0.glfg002,t0.glfg005,t0.glfg006,t0.glfg007,t0.glfg008,t0.glfg009, 
       t0.glfgstus,t0.glfgownid,t0.glfgowndp,t0.glfgcrtid,t0.glfgcrtdp,t0.glfgcrtdt,t0.glfgmodid,t0.glfgmoddt, 
       t0.glfgcnfid,t0.glfgcnfdt,t1.ooag011 ,t2.ooefl003 ,t3.ooag011 ,t4.ooefl003 ,t5.ooag011 ,t6.ooag011", 
 
               " FROM glfg_t t0",
                              " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.glfgownid  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.glfgowndp AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.glfgcrtid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.glfgcrtdp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.glfgmodid  ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.glfgcnfid  ",
 
               " WHERE t0.glfgent = " ||g_enterprise|| " AND t0.glfg001 = ? AND t0.glfg002 = ? AND t0.glfg005 = ? AND t0.glfg006 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aglt501_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aglt501 WITH FORM cl_ap_formpath("agl",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aglt501_init()   
 
      #進入選單 Menu (="N")
      CALL aglt501_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aglt501
      
   END IF 
   
   CLOSE aglt501_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aglt501.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aglt501_init()
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
      CALL cl_set_combo_scc_part('glfgstus','13','N,Y')
 
   
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL s_fin_set_comp_scc('glfg005','43')   #年度
   CALL s_fin_set_comp_scc('glfg006','111')  #期別
   CALL cl_set_combo_scc('l_gldh016','6013') #經營方式
   #end add-point
   
   #初始化搜尋條件
   CALL aglt501_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="aglt501.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION aglt501_ui_dialog()
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
   DEFINE l_count   LIKE type_t.num5
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
            CALL aglt501_insert()
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
         INITIALIZE g_glfg_m.* TO NULL
         CALL g_gldh_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL aglt501_init()
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
               
               CALL aglt501_fetch('') # reload data
               LET l_ac = 1
               CALL aglt501_ui_detailshow() #Setting the current row 
         
               CALL aglt501_idx_chk()
               #NEXT FIELD gldh003
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_gldh_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aglt501_idx_chk()
               #確定當下選擇的筆數
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[1] = l_ac
               CALL g_idx_group.addAttribute("'1',",l_ac)
               
               #add-point:page1, before row動作 name="ui_dialog.page1.before_row"
               CALL aglt501_otherdetail_show(l_ac)
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
               CALL aglt501_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aglt501
            LET g_action_choice="open_aglt501"
            IF cl_auth_chk_act("open_aglt501") THEN
               
               #add-point:ON ACTION open_aglt501 name="menu.detail_show.page1.open_aglt501"
               IF NOT cl_null(l_ac) AND l_ac >= 1 THEN
                  #KEY不為空  用KEY值重刷單頭確認stus
                  IF NOT cl_null(g_glfg_m.glfg001) AND NOT cl_null(g_glfg_m.glfg002)
                     AND NOT cl_null(g_glfg_m.glfg005) AND NOT cl_null(g_glfg_m.glfg006)THEN                  
                     #檢核確認否
                     SELECT glfgstus INTO g_glfg_m.glfgstus FROM glfg_t
                      WHERE glfgent = g_enterprise
                        AND glfg001 = g_glfg_m.glfg001
                        AND glfg002 = g_glfg_m.glfg002
                        AND glfg005 = g_glfg_m.glfg005
                        AND glfg006 = g_glfg_m.glfg006
                     #無單身也不可維護
                     LET l_count = NULL
                     SELECT COUNT(*) INTO l_count FROM gldh_t
                      WHERE gldhent = g_enterprise
                        AND gldh001 = g_glfg_m.glfg001
                        AND gldh002 = g_glfg_m.glfg002
                        AND gldh005 = g_glfg_m.glfg005
                        AND gldh006 = g_glfg_m.glfg006                      
                     IF cl_null(l_count)THEN LET l_count = 0 END IF
                     CASE
                        WHEN g_glfg_m.glfgstus = 'Y' 
                           INITIALIZE g_errparam.* TO NULL
                           LET g_errparam.code = 'agl-00323'
                           LET g_errparam.extend = ''
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                        WHEN l_count = 0 
                           INITIALIZE g_errparam.* TO NULL
                           LET g_errparam.code = 'agl-00336'
                           LET g_errparam.extend = ''
                           LET g_errparam.popup = TRUE
                           CALL cl_err()                           
                        OTHERWISE
                           CALL s_fin_sel_glad(g_glfg_m.glfg002,g_gldh_d[l_ac].gldh003,'ALL') RETURNING g_glad.*
                           IF g_glda.glda002 = 'Y' 
                              AND (g_glad.glad007 = 'N' OR cl_null(g_glad.glad007))
                              AND (g_glad.glad008 = 'N' OR cl_null(g_glad.glad008))
                              AND (g_glad.glad009 = 'N' OR cl_null(g_glad.glad009))
                              AND (g_glad.glad010 = 'N' OR cl_null(g_glad.glad010))
                              AND (g_glad.glad027 = 'N' OR cl_null(g_glad.glad027))
                              AND (g_glad.glad011 = 'N' OR cl_null(g_glad.glad011))
                              AND (g_glad.glad012 = 'N' OR cl_null(g_glad.glad012))
                              AND (g_glad.glad031 = 'N' OR cl_null(g_glad.glad031))
                              AND (g_glad.glad032 = 'N' OR cl_null(g_glad.glad032))
                              AND (g_glad.glad033 = 'N' OR cl_null(g_glad.glad033))
                              AND (g_glad.glad013 = 'N' OR cl_null(g_glad.glad013))
                              AND (g_glad.glad015 = 'N' OR cl_null(g_glad.glad015))
                              AND (g_glad.glad016 = 'N' OR cl_null(g_glad.glad016)) THEN
                              INITIALIZE g_errparam.* TO NULL
                              LET g_errparam.code = 'agl-00315'
                              LET g_errparam.extend  = ''
                              LET g_errparam.popup = TRUE
                              CALL cl_err()
                              
                           ELSE
                              LET g_gldh007_t = g_gldh_d[l_ac].gldh007
                              #核算項維護
                              CALL aglt501_open_aglt501_01(l_ac)
                              #組複合KEY                  
                              CALL aglt501_get_gldh0072(l_ac)RETURNING g_gldh_d[l_ac].gldh007
                              IF g_gldh007_t <> g_gldh_d[l_ac].gldh007 THEN
                                 #檢核單身KEY是否重複
                                 LET l_count = 1
                                 SELECT COUNT(*) INTO l_count FROM gldh_t 
                                  WHERE gldhent = g_enterprise AND gldh001 = g_glfg_m.glfg001
                                    AND gldh002 = g_glfg_m.glfg002
                                    AND gldh005 = g_glfg_m.glfg005
                                    AND gldh006 = g_glfg_m.glfg006
                                    AND gldh003 = g_gldh_d[l_ac].gldh003
                                    AND gldh007 = g_gldh_d[l_ac].gldh007
                                 IF l_count > 0 THEN
                                    INITIALIZE g_errparam.* TO NULL
                                    LET g_errparam.code = 'std-00004'
                                    LET g_errparam.extend = ''
                                    LET g_errparam.popup = TRUE
                                    CALL cl_err()
                                    CALL aglt501_b_fill()    #單身重新刷新
                                 ELSE
                                    #沒重複再UPDATE
                                    UPDATE gldh_t SET gldh007 = g_gldh_d[l_ac].gldh007,
                                                      gldh008 = g_gldh_d[l_ac].gldh008,
                                                      gldh009 = g_gldh_d[l_ac].gldh009,
                                                      gldh010 = g_gldh_d[l_ac].gldh010,
                                                      gldh011 = g_gldh_d[l_ac].gldh011,
                                                      gldh012 = g_gldh_d[l_ac].gldh012,
                                                      gldh013 = g_gldh_d[l_ac].gldh013,
                                                      gldh014 = g_gldh_d[l_ac].gldh014,
                                                      gldh015 = g_gldh_d[l_ac].gldh015,
                                                      gldh016 = g_gldh_d[l_ac].gldh016,
                                                      gldh017 = g_gldh_d[l_ac].gldh017,
                                                      gldh018 = g_gldh_d[l_ac].gldh018,
                                                      gldh019 = g_gldh_d[l_ac].gldh019,
                                                      gldh020 = g_gldh_d[l_ac].gldh020,
                                                      gldh021 = g_gldh_d[l_ac].gldh021                               
                                     WHERE gldhent = g_enterprise AND gldh001 = g_glfg_m.glfg001
                                       AND gldh002 = g_glfg_m.glfg002
                                       AND gldh005 = g_glfg_m.glfg005
                                       AND gldh006 = g_glfg_m.glfg006
                                       AND gldh003 = g_gldh_d[l_ac].gldh003
                                       AND gldh007 = g_gldh007_t      
                                    IF SQLCA.SQLCODE THEN
                                       INITIALIZE g_errparam.* TO NULL
                                       LET g_errparam.code = SQLCA.SQLCODE
                                       LET g_errparam.extend = ''
                                       LET g_errparam.popup = TRUE
                                       CALL cl_err()
                                       CALL aglt501_b_fill()    #單身重新刷新                                                               
                                    END IF
                                 END IF                                                                        
                              END IF
                           END IF
                     END CASE
                     CALL aglt501_otherdetail_show(l_ac)
                  END IF
               END IF
               #END add-point
               
            END IF
 
 
 
 
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
      
         BEFORE DIALOG
            #先填充browser資料
            CALL aglt501_browser_fill("")
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
               CALL aglt501_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL aglt501_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL aglt501_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL aglt501_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL aglt501_set_act_visible()   
            CALL aglt501_set_act_no_visible()
            IF NOT (g_glfg_m.glfg001 IS NULL
              OR g_glfg_m.glfg002 IS NULL
              OR g_glfg_m.glfg005 IS NULL
              OR g_glfg_m.glfg006 IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " glfgent = " ||g_enterprise|| " AND",
                                  " glfg001 = '", g_glfg_m.glfg001, "' "
                                  ," AND glfg002 = '", g_glfg_m.glfg002, "' "
                                  ," AND glfg005 = '", g_glfg_m.glfg005, "' "
                                  ," AND glfg006 = '", g_glfg_m.glfg006, "' "
 
               #填到對應位置
               CALL aglt501_browser_fill("")
            END IF
         
          
         #查詢方案選擇 
         ON ACTION queryplansel
            CALL cl_dlg_qryplan_select() RETURNING ls_wc
            #不是空條件才寫入g_wc跟重新找資料
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "glfg_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "gldh_t" 
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
               CALL aglt501_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                     WHEN la_wc[li_idx].tableid = "glfg_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "gldh_t" 
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
                  CALL aglt501_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL aglt501_fetch("F")
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
               CALL aglt501_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL aglt501_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aglt501_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL aglt501_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aglt501_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL aglt501_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aglt501_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL aglt501_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aglt501_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL aglt501_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aglt501_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_gldh_d)
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
               NEXT FIELD gldh003
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
               CALL aglt501_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL aglt501_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL aglt501_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aglt501_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL aglt501_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aglt501_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL aglt501_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aglt501_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aglt501_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow('')
 
 
 
         
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
 
{<section id="aglt501.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION aglt501_browser_fill(ps_page_action)
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
      LET l_sub_sql = " SELECT DISTINCT glfg001,glfg002,glfg005,glfg006 ",
                      " FROM glfg_t ",
                      " ",
                      " LEFT JOIN gldh_t ON gldhent = glfgent AND glfg001 = gldh001 AND glfg002 = gldh002 AND glfg005 = gldh005 AND glfg006 = gldh006 ", "  ",
                      #add-point:browser_fill段sql(gldh_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
 
                      " ", 
                      " ", 
 
 
                      " WHERE glfgent = " ||g_enterprise|| " AND gldhent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("glfg_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT glfg001,glfg002,glfg005,glfg006 ",
                      " FROM glfg_t ", 
                      "  ",
                      "  ",
                      " WHERE glfgent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("glfg_t")
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
      INITIALIZE g_glfg_m.* TO NULL
      CALL g_gldh_d.clear()        
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.glfg001,t0.glfg002,t0.glfg005,t0.glfg006 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.glfgstus,t0.glfg001,t0.glfg002,t0.glfg005,t0.glfg006 ",
                  " FROM glfg_t t0",
                  "  ",
                  "  LEFT JOIN gldh_t ON gldhent = glfgent AND glfg001 = gldh001 AND glfg002 = gldh002 AND glfg005 = gldh005 AND glfg006 = gldh006 ", "  ", 
                  #add-point:browser_fill段sql(gldh_t1) name="browser_fill.join.gldh_t1"
                  
                  #end add-point
 
 
                  " ", 
 
 
                  
                  " WHERE t0.glfgent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("glfg_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.glfgstus,t0.glfg001,t0.glfg002,t0.glfg005,t0.glfg006 ",
                  " FROM glfg_t t0",
                  "  ",
                  
                  " WHERE t0.glfgent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("glfg_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY glfg001,glfg002,glfg005,glfg006 ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"glfg_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_glfg001,g_browser[g_cnt].b_glfg002, 
          g_browser[g_cnt].b_glfg005,g_browser[g_cnt].b_glfg006
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
         CALL aglt501_browser_mask()
      
               #應用 a24 樣板自動產生(Version:3)
      #browser顯示圖片
      CASE g_browser[g_cnt].b_statepic
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/unconfirmed.png"
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/confirmed.png"
         
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
   
   IF cl_null(g_browser[g_cnt].b_glfg001) THEN
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
 
{<section id="aglt501.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION aglt501_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_glfg_m.glfg001 = g_browser[g_current_idx].b_glfg001   
   LET g_glfg_m.glfg002 = g_browser[g_current_idx].b_glfg002   
   LET g_glfg_m.glfg005 = g_browser[g_current_idx].b_glfg005   
   LET g_glfg_m.glfg006 = g_browser[g_current_idx].b_glfg006   
 
   EXECUTE aglt501_master_referesh USING g_glfg_m.glfg001,g_glfg_m.glfg002,g_glfg_m.glfg005,g_glfg_m.glfg006 INTO g_glfg_m.glfg001, 
       g_glfg_m.glfg002,g_glfg_m.glfg005,g_glfg_m.glfg006,g_glfg_m.glfg007,g_glfg_m.glfg008,g_glfg_m.glfg009, 
       g_glfg_m.glfgstus,g_glfg_m.glfgownid,g_glfg_m.glfgowndp,g_glfg_m.glfgcrtid,g_glfg_m.glfgcrtdp, 
       g_glfg_m.glfgcrtdt,g_glfg_m.glfgmodid,g_glfg_m.glfgmoddt,g_glfg_m.glfgcnfid,g_glfg_m.glfgcnfdt, 
       g_glfg_m.glfgownid_desc,g_glfg_m.glfgowndp_desc,g_glfg_m.glfgcrtid_desc,g_glfg_m.glfgcrtdp_desc, 
       g_glfg_m.glfgmodid_desc,g_glfg_m.glfgcnfid_desc
   
   CALL aglt501_glfg_t_mask()
   CALL aglt501_show()
      
END FUNCTION
 
{</section>}
 
{<section id="aglt501.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION aglt501_ui_detailshow()
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
 
{<section id="aglt501.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION aglt501_ui_browser_refresh()
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
      IF g_browser[l_i].b_glfg001 = g_glfg_m.glfg001 
         AND g_browser[l_i].b_glfg002 = g_glfg_m.glfg002 
         AND g_browser[l_i].b_glfg005 = g_glfg_m.glfg005 
         AND g_browser[l_i].b_glfg006 = g_glfg_m.glfg006 
 
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
 
{<section id="aglt501.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION aglt501_construct()
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
   DEFINE l_wc2_dummy STRING
   #end add-point    
   
   #add-point:Function前置處理  name="cs.pre_function"
   
   #end add-point
    
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_glfg_m.* TO NULL
   CALL g_gldh_d.clear()        
 
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前 name="cs.before_construct"
   CALL cl_set_comp_visible("glfg008,glfg009,gldh028,gldh029,gldh031,gldh032",TRUE)
   CALL cl_set_comp_visible("lbl_glfg008,lbl_glfg009",TRUE)
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON glfg001,glfg002,glfg005,glfg006,glfg007,glfg008,glfg009,glfgstus,glfgownid, 
          glfgowndp,glfgcrtid,glfgcrtdp,glfgcrtdt,glfgmodid,glfgmoddt,glfgcnfid,glfgcnfdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<glfgcrtdt>>----
         AFTER FIELD glfgcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<glfgmoddt>>----
         AFTER FIELD glfgmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<glfgcnfdt>>----
         AFTER FIELD glfgcnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<glfgpstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glfg001
            #add-point:BEFORE FIELD glfg001 name="construct.b.glfg001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glfg001
            
            #add-point:AFTER FIELD glfg001 name="construct.a.glfg001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glfg001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glfg001
            #add-point:ON ACTION controlp INFIELD glfg001 name="construct.c.glfg001"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_glda001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glfg001  #顯示到畫面上
            NEXT FIELD glfg001
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glfg002
            #add-point:BEFORE FIELD glfg002 name="construct.b.glfg002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glfg002
            
            #add-point:AFTER FIELD glfg002 name="construct.a.glfg002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glfg002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glfg002
            #add-point:ON ACTION controlp INFIELD glfg002 name="construct.c.glfg002"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_grup
            CALL q_gldc003()
            DISPLAY g_qryparam.return1 TO glfg002
            NEXT FIELD glfg002
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glfg005
            #add-point:BEFORE FIELD glfg005 name="construct.b.glfg005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glfg005
            
            #add-point:AFTER FIELD glfg005 name="construct.a.glfg005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glfg005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glfg005
            #add-point:ON ACTION controlp INFIELD glfg005 name="construct.c.glfg005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glfg006
            #add-point:BEFORE FIELD glfg006 name="construct.b.glfg006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glfg006
            
            #add-point:AFTER FIELD glfg006 name="construct.a.glfg006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glfg006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glfg006
            #add-point:ON ACTION controlp INFIELD glfg006 name="construct.c.glfg006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glfg007
            #add-point:BEFORE FIELD glfg007 name="construct.b.glfg007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glfg007
            
            #add-point:AFTER FIELD glfg007 name="construct.a.glfg007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glfg007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glfg007
            #add-point:ON ACTION controlp INFIELD glfg007 name="construct.c.glfg007"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glfg007  #顯示到畫面上
            NEXT FIELD glfg007  
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glfg008
            #add-point:BEFORE FIELD glfg008 name="construct.b.glfg008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glfg008
            
            #add-point:AFTER FIELD glfg008 name="construct.a.glfg008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glfg008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glfg008
            #add-point:ON ACTION controlp INFIELD glfg008 name="construct.c.glfg008"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glfg008  #顯示到畫面上
            NEXT FIELD glfg008
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glfg009
            #add-point:BEFORE FIELD glfg009 name="construct.b.glfg009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glfg009
            
            #add-point:AFTER FIELD glfg009 name="construct.a.glfg009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glfg009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glfg009
            #add-point:ON ACTION controlp INFIELD glfg009 name="construct.c.glfg009"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glfg009  #顯示到畫面上
            NEXT FIELD glfg009
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glfgstus
            #add-point:BEFORE FIELD glfgstus name="construct.b.glfgstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glfgstus
            
            #add-point:AFTER FIELD glfgstus name="construct.a.glfgstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glfgstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glfgstus
            #add-point:ON ACTION controlp INFIELD glfgstus name="construct.c.glfgstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.glfgownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glfgownid
            #add-point:ON ACTION controlp INFIELD glfgownid name="construct.c.glfgownid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glfgownid  #顯示到畫面上
            NEXT FIELD glfgownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glfgownid
            #add-point:BEFORE FIELD glfgownid name="construct.b.glfgownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glfgownid
            
            #add-point:AFTER FIELD glfgownid name="construct.a.glfgownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glfgowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glfgowndp
            #add-point:ON ACTION controlp INFIELD glfgowndp name="construct.c.glfgowndp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glfgowndp  #顯示到畫面上
            NEXT FIELD glfgowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glfgowndp
            #add-point:BEFORE FIELD glfgowndp name="construct.b.glfgowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glfgowndp
            
            #add-point:AFTER FIELD glfgowndp name="construct.a.glfgowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glfgcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glfgcrtid
            #add-point:ON ACTION controlp INFIELD glfgcrtid name="construct.c.glfgcrtid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glfgcrtid  #顯示到畫面上
            NEXT FIELD glfgcrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glfgcrtid
            #add-point:BEFORE FIELD glfgcrtid name="construct.b.glfgcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glfgcrtid
            
            #add-point:AFTER FIELD glfgcrtid name="construct.a.glfgcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glfgcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glfgcrtdp
            #add-point:ON ACTION controlp INFIELD glfgcrtdp name="construct.c.glfgcrtdp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glfgcrtdp  #顯示到畫面上
            NEXT FIELD glfgcrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glfgcrtdp
            #add-point:BEFORE FIELD glfgcrtdp name="construct.b.glfgcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glfgcrtdp
            
            #add-point:AFTER FIELD glfgcrtdp name="construct.a.glfgcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glfgcrtdt
            #add-point:BEFORE FIELD glfgcrtdt name="construct.b.glfgcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.glfgmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glfgmodid
            #add-point:ON ACTION controlp INFIELD glfgmodid name="construct.c.glfgmodid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glfgmodid  #顯示到畫面上
            NEXT FIELD glfgmodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glfgmodid
            #add-point:BEFORE FIELD glfgmodid name="construct.b.glfgmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glfgmodid
            
            #add-point:AFTER FIELD glfgmodid name="construct.a.glfgmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glfgmoddt
            #add-point:BEFORE FIELD glfgmoddt name="construct.b.glfgmoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.glfgcnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glfgcnfid
            #add-point:ON ACTION controlp INFIELD glfgcnfid name="construct.c.glfgcnfid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glfgcnfid  #顯示到畫面上
            NEXT FIELD glfgcnfid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glfgcnfid
            #add-point:BEFORE FIELD glfgcnfid name="construct.b.glfgcnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glfgcnfid
            
            #add-point:AFTER FIELD glfgcnfid name="construct.a.glfgcnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glfgcnfdt
            #add-point:BEFORE FIELD glfgcnfdt name="construct.b.glfgcnfdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON gldh003,gldh004,gldh025,gldh026,gldh028,gldh029,gldh031,gldh032,gldh008, 
          gldh009,gldh010,gldh011,gldh012,gldh013,gldh014,gldh015,gldh016,gldh017,gldh018,gldh019,gldh020, 
          gldh021,gldh022,gldh023,gldh024,gldh027,gldh030
           FROM s_detail1[1].gldh003,s_detail1[1].gldh004,s_detail1[1].gldh025,s_detail1[1].gldh026, 
               s_detail1[1].gldh028,s_detail1[1].gldh029,s_detail1[1].gldh031,s_detail1[1].gldh032,s_detail1[1].gldh008, 
               s_detail1[1].gldh009,s_detail1[1].gldh010,s_detail1[1].gldh011,s_detail1[1].gldh012,s_detail1[1].gldh013, 
               s_detail1[1].gldh014,s_detail1[1].gldh015,s_detail1[1].gldh016,s_detail1[1].gldh017,s_detail1[1].gldh018, 
               s_detail1[1].gldh019,s_detail1[1].gldh020,s_detail1[1].gldh021,s_detail1[1].gldh022,s_detail1[1].gldh023, 
               s_detail1[1].gldh024,s_detail1[1].gldh027,s_detail1[1].gldh030
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldh003
            #add-point:BEFORE FIELD gldh003 name="construct.b.page1.gldh003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldh003
            
            #add-point:AFTER FIELD gldh003 name="construct.a.page1.gldh003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gldh003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldh003
            #add-point:ON ACTION controlp INFIELD gldh003 name="construct.c.page1.gldh003"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " glac003 <>'1' AND glac006 = '1'"
            CALL aglt310_04()
            DISPLAY g_qryparam.return1 TO gldh003  #顯示到畫面上
            NEXT FIELD gldh003                  
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldh004
            #add-point:BEFORE FIELD gldh004 name="construct.b.page1.gldh004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldh004
            
            #add-point:AFTER FIELD gldh004 name="construct.a.page1.gldh004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gldh004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldh004
            #add-point:ON ACTION controlp INFIELD gldh004 name="construct.c.page1.gldh004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldh025
            #add-point:BEFORE FIELD gldh025 name="construct.b.page1.gldh025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldh025
            
            #add-point:AFTER FIELD gldh025 name="construct.a.page1.gldh025"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gldh025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldh025
            #add-point:ON ACTION controlp INFIELD gldh025 name="construct.c.page1.gldh025"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldh026
            #add-point:BEFORE FIELD gldh026 name="construct.b.page1.gldh026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldh026
            
            #add-point:AFTER FIELD gldh026 name="construct.a.page1.gldh026"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gldh026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldh026
            #add-point:ON ACTION controlp INFIELD gldh026 name="construct.c.page1.gldh026"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldh028
            #add-point:BEFORE FIELD gldh028 name="construct.b.page1.gldh028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldh028
            
            #add-point:AFTER FIELD gldh028 name="construct.a.page1.gldh028"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gldh028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldh028
            #add-point:ON ACTION controlp INFIELD gldh028 name="construct.c.page1.gldh028"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldh029
            #add-point:BEFORE FIELD gldh029 name="construct.b.page1.gldh029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldh029
            
            #add-point:AFTER FIELD gldh029 name="construct.a.page1.gldh029"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gldh029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldh029
            #add-point:ON ACTION controlp INFIELD gldh029 name="construct.c.page1.gldh029"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldh031
            #add-point:BEFORE FIELD gldh031 name="construct.b.page1.gldh031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldh031
            
            #add-point:AFTER FIELD gldh031 name="construct.a.page1.gldh031"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gldh031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldh031
            #add-point:ON ACTION controlp INFIELD gldh031 name="construct.c.page1.gldh031"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldh032
            #add-point:BEFORE FIELD gldh032 name="construct.b.page1.gldh032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldh032
            
            #add-point:AFTER FIELD gldh032 name="construct.a.page1.gldh032"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gldh032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldh032
            #add-point:ON ACTION controlp INFIELD gldh032 name="construct.c.page1.gldh032"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldh008
            #add-point:BEFORE FIELD gldh008 name="construct.b.page1.gldh008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldh008
            
            #add-point:AFTER FIELD gldh008 name="construct.a.page1.gldh008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gldh008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldh008
            #add-point:ON ACTION controlp INFIELD gldh008 name="construct.c.page1.gldh008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldh009
            #add-point:BEFORE FIELD gldh009 name="construct.b.page1.gldh009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldh009
            
            #add-point:AFTER FIELD gldh009 name="construct.a.page1.gldh009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gldh009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldh009
            #add-point:ON ACTION controlp INFIELD gldh009 name="construct.c.page1.gldh009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldh010
            #add-point:BEFORE FIELD gldh010 name="construct.b.page1.gldh010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldh010
            
            #add-point:AFTER FIELD gldh010 name="construct.a.page1.gldh010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gldh010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldh010
            #add-point:ON ACTION controlp INFIELD gldh010 name="construct.c.page1.gldh010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldh011
            #add-point:BEFORE FIELD gldh011 name="construct.b.page1.gldh011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldh011
            
            #add-point:AFTER FIELD gldh011 name="construct.a.page1.gldh011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gldh011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldh011
            #add-point:ON ACTION controlp INFIELD gldh011 name="construct.c.page1.gldh011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldh012
            #add-point:BEFORE FIELD gldh012 name="construct.b.page1.gldh012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldh012
            
            #add-point:AFTER FIELD gldh012 name="construct.a.page1.gldh012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gldh012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldh012
            #add-point:ON ACTION controlp INFIELD gldh012 name="construct.c.page1.gldh012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldh013
            #add-point:BEFORE FIELD gldh013 name="construct.b.page1.gldh013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldh013
            
            #add-point:AFTER FIELD gldh013 name="construct.a.page1.gldh013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gldh013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldh013
            #add-point:ON ACTION controlp INFIELD gldh013 name="construct.c.page1.gldh013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldh014
            #add-point:BEFORE FIELD gldh014 name="construct.b.page1.gldh014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldh014
            
            #add-point:AFTER FIELD gldh014 name="construct.a.page1.gldh014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gldh014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldh014
            #add-point:ON ACTION controlp INFIELD gldh014 name="construct.c.page1.gldh014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldh015
            #add-point:BEFORE FIELD gldh015 name="construct.b.page1.gldh015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldh015
            
            #add-point:AFTER FIELD gldh015 name="construct.a.page1.gldh015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gldh015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldh015
            #add-point:ON ACTION controlp INFIELD gldh015 name="construct.c.page1.gldh015"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldh016
            #add-point:BEFORE FIELD gldh016 name="construct.b.page1.gldh016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldh016
            
            #add-point:AFTER FIELD gldh016 name="construct.a.page1.gldh016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gldh016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldh016
            #add-point:ON ACTION controlp INFIELD gldh016 name="construct.c.page1.gldh016"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldh017
            #add-point:BEFORE FIELD gldh017 name="construct.b.page1.gldh017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldh017
            
            #add-point:AFTER FIELD gldh017 name="construct.a.page1.gldh017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gldh017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldh017
            #add-point:ON ACTION controlp INFIELD gldh017 name="construct.c.page1.gldh017"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldh018
            #add-point:BEFORE FIELD gldh018 name="construct.b.page1.gldh018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldh018
            
            #add-point:AFTER FIELD gldh018 name="construct.a.page1.gldh018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gldh018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldh018
            #add-point:ON ACTION controlp INFIELD gldh018 name="construct.c.page1.gldh018"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldh019
            #add-point:BEFORE FIELD gldh019 name="construct.b.page1.gldh019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldh019
            
            #add-point:AFTER FIELD gldh019 name="construct.a.page1.gldh019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gldh019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldh019
            #add-point:ON ACTION controlp INFIELD gldh019 name="construct.c.page1.gldh019"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldh020
            #add-point:BEFORE FIELD gldh020 name="construct.b.page1.gldh020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldh020
            
            #add-point:AFTER FIELD gldh020 name="construct.a.page1.gldh020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gldh020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldh020
            #add-point:ON ACTION controlp INFIELD gldh020 name="construct.c.page1.gldh020"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldh021
            #add-point:BEFORE FIELD gldh021 name="construct.b.page1.gldh021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldh021
            
            #add-point:AFTER FIELD gldh021 name="construct.a.page1.gldh021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gldh021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldh021
            #add-point:ON ACTION controlp INFIELD gldh021 name="construct.c.page1.gldh021"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldh022
            #add-point:BEFORE FIELD gldh022 name="construct.b.page1.gldh022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldh022
            
            #add-point:AFTER FIELD gldh022 name="construct.a.page1.gldh022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gldh022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldh022
            #add-point:ON ACTION controlp INFIELD gldh022 name="construct.c.page1.gldh022"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldh023
            #add-point:BEFORE FIELD gldh023 name="construct.b.page1.gldh023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldh023
            
            #add-point:AFTER FIELD gldh023 name="construct.a.page1.gldh023"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gldh023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldh023
            #add-point:ON ACTION controlp INFIELD gldh023 name="construct.c.page1.gldh023"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldh024
            #add-point:BEFORE FIELD gldh024 name="construct.b.page1.gldh024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldh024
            
            #add-point:AFTER FIELD gldh024 name="construct.a.page1.gldh024"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gldh024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldh024
            #add-point:ON ACTION controlp INFIELD gldh024 name="construct.c.page1.gldh024"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldh027
            #add-point:BEFORE FIELD gldh027 name="construct.b.page1.gldh027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldh027
            
            #add-point:AFTER FIELD gldh027 name="construct.a.page1.gldh027"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gldh027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldh027
            #add-point:ON ACTION controlp INFIELD gldh027 name="construct.c.page1.gldh027"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldh030
            #add-point:BEFORE FIELD gldh030 name="construct.b.page1.gldh030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldh030
            
            #add-point:AFTER FIELD gldh030 name="construct.a.page1.gldh030"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gldh030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldh030
            #add-point:ON ACTION controlp INFIELD gldh030 name="construct.c.page1.gldh030"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
 
      
 
      
      #add-point:cs段add_cs(本段內只能出現新的CONSTRUCT指令) name="cs.add_cs"
      CONSTRUCT l_wc2_dummy ON gldh008, 
          gldh009,gldh010,gldh011,gldh012,
          gldh013,gldh014,gldh015,gldh016,
          gldh017,gldh018,gldh019,gldh020, 
          gldh021
           FROM l_gldh008, 
          l_gldh009,l_gldh010,l_gldh011,l_gldh012,
          l_gldh013,l_gldh014,l_gldh015,l_gldh016,
          l_gldh017,l_gldh018,l_gldh019,l_gldh020, 
          l_gldh021
         ON ACTION controlp INFIELD l_gldh008
            #營運據點
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #CALL q_ooef001()    #161021-00037#4 mark
            CALL q_ooef001_01()  #161021-00037#4 add                      
            DISPLAY g_qryparam.return1 TO l_gldh008  
            NEXT FIELD l_gldh008                    
         ON ACTION controlp INFIELD l_gldh009
            #部門
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "ooegstus='Y'"
            CALL q_ooeg001_4()                          
            DISPLAY g_qryparam.return1 TO l_gldh009  
            NEXT FIELD l_gldh009                    
         ON ACTION controlp INFIELD l_gldh010
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "ooegstus='Y' AND ooeg003 IN ('1','2','3')"
            CALL q_ooeg001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO l_gldh010      #顯示到畫面上
            NEXT FIELD l_gldh010 
         ON ACTION controlp INFIELD l_gldh011
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_287()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO l_gldh011      #顯示到畫面上
            NEXT FIELD l_gldh011          
         
         ON ACTION controlp INFIELD l_gldh012
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_25()      #160913-00017#4  add
            #CALL q_pmaa001()        #160913-00017#4  mark               #呼叫開窗      
            DISPLAY g_qryparam.return1 TO l_gldh012     
            NEXT FIELD l_gldh012         
         ON ACTION controlp INFIELD l_gldh013
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            CALL q_pmaa001_25()      #160913-00017#4  add
            #CALL q_pmaa001()        #160913-00017#4  mark               #呼叫開窗                        
            DISPLAY g_qryparam.return1 TO l_gldh013      
            NEXT FIELD l_gldh013                        
         ON ACTION controlp INFIELD l_gldh014
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            CALL q_oocq002_281()                       
            DISPLAY g_qryparam.return1 TO l_gldh014     
            NEXT FIELD l_gldh014                        
         ON ACTION controlp INFIELD l_gldh015
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            CALL q_rtax001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO l_gldh015      #顯示到畫面上
            NEXT FIELD l_gldh015
    
         ON ACTION controlp INFIELD l_gldh017
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            LET g_qryparam.where = " oojdstus='Y' "
            CALL q_oojd001_2()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO l_gldh017     #顯示到畫面上
            NEXT FIELD l_gldh017                         #返回原欄位
         ON ACTION controlp INFIELD l_gldh018
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            CALL q_oocq002_2002()                            #呼叫開窗
            DISPLAY g_qryparam.return1 TO l_gldh018      #顯示到畫面上
            NEXT FIELD l_gldh018                        #返回原欄位
         ON ACTION controlp INFIELD l_gldh019
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            CALL q_ooag001_8()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO l_gldh019      #顯示到畫面上
            NEXT FIELD l_gldh019
         ON ACTION controlp INFIELD l_gldh020
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            CALL q_pjba001()                          #呼叫開窗
            DISPLAY g_qryparam.return1 TO l_gldh020     #顯示到畫面上
            NEXT FIELD l_gldh020
         ON ACTION controlp INFIELD l_gldh021
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            LET g_qryparam.where = "pjbb012='1' "
            CALL q_pjbb002()                          #呼叫開窗
            DISPLAY g_qryparam.return1 TO l_gldh021     #顯示到畫面上
            NEXT FIELD l_gldh021
      END CONSTRUCT
      #end add-point
 
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:cs段b_dialog name="cs.b_dialog"
         LET g_gldh_d[1].gldh003 = ''
         DISPLAY ARRAY g_gldh_d TO s_detail1.*
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
                  WHEN la_wc[li_idx].tableid = "glfg_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "gldh_t" 
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
   IF NOT cl_null(l_wc2_dummy)THEN
      LET g_wc2 = g_wc2 CLIPPED," AND ",l_wc2_dummy CLIPPED
   END IF
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aglt501.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION aglt501_filter()
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
      CONSTRUCT g_wc_filter ON glfg001,glfg002,glfg005,glfg006
                          FROM s_browse[1].b_glfg001,s_browse[1].b_glfg002,s_browse[1].b_glfg005,s_browse[1].b_glfg006 
 
 
         BEFORE CONSTRUCT
               DISPLAY aglt501_filter_parser('glfg001') TO s_browse[1].b_glfg001
            DISPLAY aglt501_filter_parser('glfg002') TO s_browse[1].b_glfg002
            DISPLAY aglt501_filter_parser('glfg005') TO s_browse[1].b_glfg005
            DISPLAY aglt501_filter_parser('glfg006') TO s_browse[1].b_glfg006
      
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
 
      CALL aglt501_filter_show('glfg001')
   CALL aglt501_filter_show('glfg002')
   CALL aglt501_filter_show('glfg005')
   CALL aglt501_filter_show('glfg006')
 
END FUNCTION
 
{</section>}
 
{<section id="aglt501.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION aglt501_filter_parser(ps_field)
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
 
{<section id="aglt501.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION aglt501_filter_show(ps_field)
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
   LET ls_condition = aglt501_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aglt501.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION aglt501_query()
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
   CALL g_gldh_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL aglt501_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL aglt501_browser_fill("")
      CALL aglt501_fetch("")
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
      CALL aglt501_filter_show('glfg001')
   CALL aglt501_filter_show('glfg002')
   CALL aglt501_filter_show('glfg005')
   CALL aglt501_filter_show('glfg006')
   CALL aglt501_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL aglt501_fetch("F") 
      #顯示單身筆數
      CALL aglt501_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aglt501.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION aglt501_fetch(p_flag)
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
   
   LET g_glfg_m.glfg001 = g_browser[g_current_idx].b_glfg001
   LET g_glfg_m.glfg002 = g_browser[g_current_idx].b_glfg002
   LET g_glfg_m.glfg005 = g_browser[g_current_idx].b_glfg005
   LET g_glfg_m.glfg006 = g_browser[g_current_idx].b_glfg006
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE aglt501_master_referesh USING g_glfg_m.glfg001,g_glfg_m.glfg002,g_glfg_m.glfg005,g_glfg_m.glfg006 INTO g_glfg_m.glfg001, 
       g_glfg_m.glfg002,g_glfg_m.glfg005,g_glfg_m.glfg006,g_glfg_m.glfg007,g_glfg_m.glfg008,g_glfg_m.glfg009, 
       g_glfg_m.glfgstus,g_glfg_m.glfgownid,g_glfg_m.glfgowndp,g_glfg_m.glfgcrtid,g_glfg_m.glfgcrtdp, 
       g_glfg_m.glfgcrtdt,g_glfg_m.glfgmodid,g_glfg_m.glfgmoddt,g_glfg_m.glfgcnfid,g_glfg_m.glfgcnfdt, 
       g_glfg_m.glfgownid_desc,g_glfg_m.glfgowndp_desc,g_glfg_m.glfgcrtid_desc,g_glfg_m.glfgcrtdp_desc, 
       g_glfg_m.glfgmodid_desc,g_glfg_m.glfgcnfid_desc
   
   #遮罩相關處理
   LET g_glfg_m_mask_o.* =  g_glfg_m.*
   CALL aglt501_glfg_t_mask()
   LET g_glfg_m_mask_n.* =  g_glfg_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aglt501_set_act_visible()   
   CALL aglt501_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   IF g_glfg_m.glfgstus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF

   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_glfg_m_t.* = g_glfg_m.*
   LET g_glfg_m_o.* = g_glfg_m.*
   
   LET g_data_owner = g_glfg_m.glfgownid      
   LET g_data_dept  = g_glfg_m.glfgowndp
   
   #重新顯示   
   CALL aglt501_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="aglt501.insert" >}
#+ 資料新增
PRIVATE FUNCTION aglt501_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_gldh_d.clear()   
 
 
   INITIALIZE g_glfg_m.* TO NULL             #DEFAULT 設定
   
   LET g_glfg001_t = NULL
   LET g_glfg002_t = NULL
   LET g_glfg005_t = NULL
   LET g_glfg006_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_glfg_m.glfgownid = g_user
      LET g_glfg_m.glfgowndp = g_dept
      LET g_glfg_m.glfgcrtid = g_user
      LET g_glfg_m.glfgcrtdp = g_dept 
      LET g_glfg_m.glfgcrtdt = cl_get_current()
      LET g_glfg_m.glfgmodid = g_user
      LET g_glfg_m.glfgmoddt = cl_get_current()
      LET g_glfg_m.glfgstus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_glfg_m.glfg005 = "0"
      LET g_glfg_m.glfg006 = "0"
 
  
      #add-point:單頭預設值 name="insert.default"
      #輸入資料時的當下年度月份
      LET g_glfg_m.glfg005 = YEAR(g_today)
      LET g_glfg_m.glfg006 = MONTH(g_today)
      
      DISPLAY BY NAME g_glfg_m.glfg005,g_glfg_m.glfg006   #140806-00012#6   150224 By albireo
      LET g_glfg_m_t.* =g_glfg_m.*
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_glfg_m_t.* = g_glfg_m.*
      LET g_glfg_m_o.* = g_glfg_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_glfg_m.glfgstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         
      END CASE
 
 
 
    
      CALL aglt501_input("a")
      
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
         INITIALIZE g_glfg_m.* TO NULL
         INITIALIZE g_gldh_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL aglt501_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_gldh_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aglt501_set_act_visible()   
   CALL aglt501_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_glfg001_t = g_glfg_m.glfg001
   LET g_glfg002_t = g_glfg_m.glfg002
   LET g_glfg005_t = g_glfg_m.glfg005
   LET g_glfg006_t = g_glfg_m.glfg006
 
   
   #組合新增資料的條件
   LET g_add_browse = " glfgent = " ||g_enterprise|| " AND",
                      " glfg001 = '", g_glfg_m.glfg001, "' "
                      ," AND glfg002 = '", g_glfg_m.glfg002, "' "
                      ," AND glfg005 = '", g_glfg_m.glfg005, "' "
                      ," AND glfg006 = '", g_glfg_m.glfg006, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aglt501_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE aglt501_cl
   
   CALL aglt501_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE aglt501_master_referesh USING g_glfg_m.glfg001,g_glfg_m.glfg002,g_glfg_m.glfg005,g_glfg_m.glfg006 INTO g_glfg_m.glfg001, 
       g_glfg_m.glfg002,g_glfg_m.glfg005,g_glfg_m.glfg006,g_glfg_m.glfg007,g_glfg_m.glfg008,g_glfg_m.glfg009, 
       g_glfg_m.glfgstus,g_glfg_m.glfgownid,g_glfg_m.glfgowndp,g_glfg_m.glfgcrtid,g_glfg_m.glfgcrtdp, 
       g_glfg_m.glfgcrtdt,g_glfg_m.glfgmodid,g_glfg_m.glfgmoddt,g_glfg_m.glfgcnfid,g_glfg_m.glfgcnfdt, 
       g_glfg_m.glfgownid_desc,g_glfg_m.glfgowndp_desc,g_glfg_m.glfgcrtid_desc,g_glfg_m.glfgcrtdp_desc, 
       g_glfg_m.glfgmodid_desc,g_glfg_m.glfgcnfid_desc
   
   
   #遮罩相關處理
   LET g_glfg_m_mask_o.* =  g_glfg_m.*
   CALL aglt501_glfg_t_mask()
   LET g_glfg_m_mask_n.* =  g_glfg_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_glfg_m.glfg001,g_glfg_m.glfg001_desc,g_glfg_m.glfg002,g_glfg_m.glfg002_desc,g_glfg_m.glfg005, 
       g_glfg_m.glfg006,g_glfg_m.glfg007,g_glfg_m.glfg008,g_glfg_m.glfg009,g_glfg_m.glfgstus,g_glfg_m.glfgownid, 
       g_glfg_m.glfgownid_desc,g_glfg_m.glfgowndp,g_glfg_m.glfgowndp_desc,g_glfg_m.glfgcrtid,g_glfg_m.glfgcrtid_desc, 
       g_glfg_m.glfgcrtdp,g_glfg_m.glfgcrtdp_desc,g_glfg_m.glfgcrtdt,g_glfg_m.glfgmodid,g_glfg_m.glfgmodid_desc, 
       g_glfg_m.glfgmoddt,g_glfg_m.glfgcnfid,g_glfg_m.glfgcnfid_desc,g_glfg_m.glfgcnfdt,g_glfg_m.l_gldh008, 
       g_glfg_m.l_gldh009,g_glfg_m.l_gldh010,g_glfg_m.l_gldh011,g_glfg_m.l_gldh012,g_glfg_m.l_gldh013, 
       g_glfg_m.l_gldh014,g_glfg_m.l_gldh015,g_glfg_m.l_gldh016,g_glfg_m.l_gldh017,g_glfg_m.l_gldh018, 
       g_glfg_m.l_gldh019,g_glfg_m.l_gldh020,g_glfg_m.l_gldh021
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_glfg_m.glfgownid      
   LET g_data_dept  = g_glfg_m.glfgowndp
   
   #功能已完成,通報訊息中心
   CALL aglt501_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="aglt501.modify" >}
#+ 資料修改
PRIVATE FUNCTION aglt501_modify()
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
   LET g_glfg_m_t.* = g_glfg_m.*
   LET g_glfg_m_o.* = g_glfg_m.*
   
   IF g_glfg_m.glfg001 IS NULL
   OR g_glfg_m.glfg002 IS NULL
   OR g_glfg_m.glfg005 IS NULL
   OR g_glfg_m.glfg006 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_glfg001_t = g_glfg_m.glfg001
   LET g_glfg002_t = g_glfg_m.glfg002
   LET g_glfg005_t = g_glfg_m.glfg005
   LET g_glfg006_t = g_glfg_m.glfg006
 
   CALL s_transaction_begin()
   
   OPEN aglt501_cl USING g_enterprise,g_glfg_m.glfg001,g_glfg_m.glfg002,g_glfg_m.glfg005,g_glfg_m.glfg006
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aglt501_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE aglt501_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aglt501_master_referesh USING g_glfg_m.glfg001,g_glfg_m.glfg002,g_glfg_m.glfg005,g_glfg_m.glfg006 INTO g_glfg_m.glfg001, 
       g_glfg_m.glfg002,g_glfg_m.glfg005,g_glfg_m.glfg006,g_glfg_m.glfg007,g_glfg_m.glfg008,g_glfg_m.glfg009, 
       g_glfg_m.glfgstus,g_glfg_m.glfgownid,g_glfg_m.glfgowndp,g_glfg_m.glfgcrtid,g_glfg_m.glfgcrtdp, 
       g_glfg_m.glfgcrtdt,g_glfg_m.glfgmodid,g_glfg_m.glfgmoddt,g_glfg_m.glfgcnfid,g_glfg_m.glfgcnfdt, 
       g_glfg_m.glfgownid_desc,g_glfg_m.glfgowndp_desc,g_glfg_m.glfgcrtid_desc,g_glfg_m.glfgcrtdp_desc, 
       g_glfg_m.glfgmodid_desc,g_glfg_m.glfgcnfid_desc
   
   #檢查是否允許此動作
   IF NOT aglt501_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_glfg_m_mask_o.* =  g_glfg_m.*
   CALL aglt501_glfg_t_mask()
   LET g_glfg_m_mask_n.* =  g_glfg_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
 
   
   CALL aglt501_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
 
    
   WHILE TRUE
      LET g_glfg001_t = g_glfg_m.glfg001
      LET g_glfg002_t = g_glfg_m.glfg002
      LET g_glfg005_t = g_glfg_m.glfg005
      LET g_glfg006_t = g_glfg_m.glfg006
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_glfg_m.glfgmodid = g_user 
LET g_glfg_m.glfgmoddt = cl_get_current()
LET g_glfg_m.glfgmodid_desc = cl_get_username(g_glfg_m.glfgmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      #「D抽單 / R已拒絕」狀況碼更改資料後，需還原為「N未確認」
      IF g_glfg_m.glfgstus MATCHES "[DR]" THEN 
         LET g_glfg_m.glfgstus = "N"
      END IF
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL aglt501_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE glfg_t SET (glfgmodid,glfgmoddt) = (g_glfg_m.glfgmodid,g_glfg_m.glfgmoddt)
          WHERE glfgent = g_enterprise AND glfg001 = g_glfg001_t
            AND glfg002 = g_glfg002_t
            AND glfg005 = g_glfg005_t
            AND glfg006 = g_glfg006_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_glfg_m.* = g_glfg_m_t.*
            CALL aglt501_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_glfg_m.glfg001 != g_glfg_m_t.glfg001
      OR g_glfg_m.glfg002 != g_glfg_m_t.glfg002
      OR g_glfg_m.glfg005 != g_glfg_m_t.glfg005
      OR g_glfg_m.glfg006 != g_glfg_m_t.glfg006
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE gldh_t SET gldh001 = g_glfg_m.glfg001
                                       ,gldh002 = g_glfg_m.glfg002
                                       ,gldh005 = g_glfg_m.glfg005
                                       ,gldh006 = g_glfg_m.glfg006
 
          WHERE gldhent = g_enterprise AND gldh001 = g_glfg_m_t.glfg001
            AND gldh002 = g_glfg_m_t.glfg002
            AND gldh005 = g_glfg_m_t.glfg005
            AND gldh006 = g_glfg_m_t.glfg006
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "gldh_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "gldh_t:",SQLERRMESSAGE 
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
   CALL aglt501_set_act_visible()   
   CALL aglt501_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " glfgent = " ||g_enterprise|| " AND",
                      " glfg001 = '", g_glfg_m.glfg001, "' "
                      ," AND glfg002 = '", g_glfg_m.glfg002, "' "
                      ," AND glfg005 = '", g_glfg_m.glfg005, "' "
                      ," AND glfg006 = '", g_glfg_m.glfg006, "' "
 
   #填到對應位置
   CALL aglt501_browser_fill("")
 
   CLOSE aglt501_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aglt501_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="aglt501.input" >}
#+ 資料輸入
PRIVATE FUNCTION aglt501_input(p_cmd)
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
   DEFINE  l_desc                LIKE type_t.chr100   #說明
   
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
   DISPLAY BY NAME g_glfg_m.glfg001,g_glfg_m.glfg001_desc,g_glfg_m.glfg002,g_glfg_m.glfg002_desc,g_glfg_m.glfg005, 
       g_glfg_m.glfg006,g_glfg_m.glfg007,g_glfg_m.glfg008,g_glfg_m.glfg009,g_glfg_m.glfgstus,g_glfg_m.glfgownid, 
       g_glfg_m.glfgownid_desc,g_glfg_m.glfgowndp,g_glfg_m.glfgowndp_desc,g_glfg_m.glfgcrtid,g_glfg_m.glfgcrtid_desc, 
       g_glfg_m.glfgcrtdp,g_glfg_m.glfgcrtdp_desc,g_glfg_m.glfgcrtdt,g_glfg_m.glfgmodid,g_glfg_m.glfgmodid_desc, 
       g_glfg_m.glfgmoddt,g_glfg_m.glfgcnfid,g_glfg_m.glfgcnfid_desc,g_glfg_m.glfgcnfdt,g_glfg_m.l_gldh008, 
       g_glfg_m.l_gldh009,g_glfg_m.l_gldh010,g_glfg_m.l_gldh011,g_glfg_m.l_gldh012,g_glfg_m.l_gldh013, 
       g_glfg_m.l_gldh014,g_glfg_m.l_gldh015,g_glfg_m.l_gldh016,g_glfg_m.l_gldh017,g_glfg_m.l_gldh018, 
       g_glfg_m.l_gldh019,g_glfg_m.l_gldh020,g_glfg_m.l_gldh021
   
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
   LET g_forupd_sql = "SELECT gldh007,gldh003,gldh004,gldh025,gldh026,gldh028,gldh029,gldh031,gldh032, 
       gldh008,gldh009,gldh010,gldh011,gldh012,gldh013,gldh014,gldh015,gldh016,gldh017,gldh018,gldh019, 
       gldh020,gldh021,gldh022,gldh023,gldh024,gldh027,gldh030 FROM gldh_t WHERE gldhent=? AND gldh001=?  
       AND gldh002=? AND gldh005=? AND gldh006=? AND gldh003=? AND gldh007=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aglt501_bcl CURSOR FROM g_forupd_sql
   
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL aglt501_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL aglt501_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_glfg_m.glfg001,g_glfg_m.glfg002,g_glfg_m.glfg005,g_glfg_m.glfg006,g_glfg_m.glfg007, 
       g_glfg_m.glfg008,g_glfg_m.glfg009,g_glfg_m.glfgstus,g_glfg_m.l_gldh008,g_glfg_m.l_gldh009,g_glfg_m.l_gldh010, 
       g_glfg_m.l_gldh011,g_glfg_m.l_gldh012,g_glfg_m.l_gldh013,g_glfg_m.l_gldh014,g_glfg_m.l_gldh015, 
       g_glfg_m.l_gldh016,g_glfg_m.l_gldh017,g_glfg_m.l_gldh018,g_glfg_m.l_gldh019,g_glfg_m.l_gldh020, 
       g_glfg_m.l_gldh021
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="aglt501.input.head" >}
      #單頭段
      INPUT BY NAME g_glfg_m.glfg001,g_glfg_m.glfg002,g_glfg_m.glfg005,g_glfg_m.glfg006,g_glfg_m.glfg007, 
          g_glfg_m.glfg008,g_glfg_m.glfg009,g_glfg_m.glfgstus,g_glfg_m.l_gldh008,g_glfg_m.l_gldh009, 
          g_glfg_m.l_gldh010,g_glfg_m.l_gldh011,g_glfg_m.l_gldh012,g_glfg_m.l_gldh013,g_glfg_m.l_gldh014, 
          g_glfg_m.l_gldh015,g_glfg_m.l_gldh016,g_glfg_m.l_gldh017,g_glfg_m.l_gldh018,g_glfg_m.l_gldh019, 
          g_glfg_m.l_gldh020,g_glfg_m.l_gldh021 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN aglt501_cl USING g_enterprise,g_glfg_m.glfg001,g_glfg_m.glfg002,g_glfg_m.glfg005,g_glfg_m.glfg006
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aglt501_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aglt501_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL aglt501_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            
            #end add-point
            CALL aglt501_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glfg001
            
            #add-point:AFTER FIELD glfg001 name="input.a.glfg001"
            #應用 a05 樣板自動產生(Version:2)
            LET g_glfg_m.glfg001_desc = ' '
            DISPLAY BY NAME g_glfg_m.glfg001_desc
            IF NOT cl_null(g_glfg_m.glfg001) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_glfg_m.glfg001 != g_glfg_m_t.glfg001 OR g_glfg_m_t.glfg001 IS NULL )) THEN #160824-00007#260 161220 By 08171 mark
               IF cl_null(g_glfg_m_o.glfg001) OR g_glfg_m.glfg001 != g_glfg_m_o.glfg001 THEN #160824-00007#260 161220 By 08171 add
                 
                  CALL s_merge_glda001_chk(g_glfg_m.glfg001)RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                    #LET g_glfg_m.glfg001 = g_glfg_m_t.glfg001 #160824-00007#260 161220 By 08171 mark
                     LET g_glfg_m.glfg001 = g_glfg_m_o.glfg001 #160824-00007#260 161220 By 08171 add
                     LET g_glfg_m.glfg001_desc = s_desc_glda001_desc(g_glfg_m.glfg001)
                     DISPLAY BY NAME g_glfg_m.glfg001,g_glfg_m.glfg001_desc
                     NEXT FIELD CURRENT
                  END IF
                  
                  SELECT glda002 INTO g_glda.glda002 FROM glda_t
                   WHERE gldaent = g_enterprise
                     AND glda001 = g_glfg_m.glfg001
                  IF g_glda.glda002 = 'Y' THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'agl-00324'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                    #LET g_glfg_m.glfg001 = g_glfg_m_t.glfg001 #160824-00007#260 161220 By 08171 mark
                     LET g_glfg_m.glfg001 = g_glfg_m_o.glfg001 #160824-00007#260 161220 By 08171 add
                     LET g_glfg_m.glfg001_desc = s_desc_glda001_desc(g_glfg_m.glfg001)
                     DISPLAY BY NAME g_glfg_m.glfg001,g_glfg_m.glfg001_desc
                     NEXT FIELD CURRENT                     
                  END IF
                  
                  #有基本資料維護作業後,會預帶帳別
                  #要補帳別檢核
                  #先做預帶三幣別的邏輯
                  IF NOT cl_null(g_glfg_m.glfg002)THEN
                     CALL s_ld_sel_glaa(g_glfg_m.glfg002,'ALL') RETURNING g_glaa.*
                     LET g_glfg_m.glfg007 = '' #160824-00007#260 161220 By 08171 add
                     LET g_glfg_m.glfg007 = g_glaa.glaa001
                     IF g_glaa.glaa015 = 'Y' THEN
                        LET g_glfg_m.glfg008 = '' #160824-00007#260 161220 By 08171 add
                        LET g_glfg_m.glfg008 = g_glaa.glaa016
                     ELSE
                        LET g_glfg_m.glfg008 = ''
                     END IF
                     IF g_glaa.glaa019 = 'Y' THEN
                        LET g_glfg_m.glfg009 = '' #160824-00007#260 161220 By 08171 add
                        LET g_glfg_m.glfg009 = g_glaa.glaa020
                     ELSE
                        LEt g_glfg_m.glfg009 = ''
                     END IF
                  END IF
                  DISPLAY BY NAME g_glfg_m.glfg007,g_glfg_m.glfg008,g_glfg_m.glfg009
                  CALL aglt501_set_visible()
               END IF
            END IF
            LET g_glfg_m.glfg001_desc = s_desc_glda001_desc(g_glfg_m.glfg001)
            DISPLAY BY NAME g_glfg_m.glfg001,g_glfg_m.glfg001_desc
            
            LET g_glfg_m_o.* = g_glfg_m.* #160824-00007#260 161220 By 08171 add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glfg001
            #add-point:BEFORE FIELD glfg001 name="input.b.glfg001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glfg001
            #add-point:ON CHANGE glfg001 name="input.g.glfg001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glfg002
            
            #add-point:AFTER FIELD glfg002 name="input.a.glfg002"
            #應用 a05 樣板自動產生(Version:2)
            LET g_glfg_m.glfg002_desc = NULL
            DISPLAY BY NAME g_glfg_m.glfg002_desc
            IF NOT cl_null(g_glfg_m.glfg002) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_glfg_m.glfg002 != g_glfg_m_t.glfg002 OR g_glfg_m_t.glfg002 IS NULL )) THEN #160824-00007#260 161220 By 08171 mark
               IF cl_null(g_glfg_m_o.glfg002) OR g_glfg_m.glfg002 != g_glfg_m_o.glfg002 THEN #160824-00007#260 161220 By 08171 add
                  #CALL s_merge_ld_with_comp_chk(g_glfg_m.glfg002,g_glfg_m.glfg001,g_user,2)RETURNING g_sub_success,g_errno   #albireo 160222
                  CALL s_merge_ld_with_comp_chk(g_glfg_m.glfg002,g_glfg_m.glfg001,g_user,4)RETURNING g_sub_success,g_errno   #albireo 160222   #不限制為下層公司的個體帳別
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                    #LET g_glfg_m.glfg002 = g_glfg_m_t.glfg002 #160824-00007#260 161220 By 08171 mark
                     LET g_glfg_m.glfg002 = g_glfg_m_o.glfg002 #160824-00007#260 161220 By 08171 add
                     CALL s_desc_get_ld_desc(g_glfg_m.glfg002) RETURNING g_glfg_m.glfg002_desc
                     DISPLAY BY NAME g_glfg_m.glfg002
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            
            #檢核排除中間層在單身打的合併帳別-----s
            #" AND glaald NOT IN (SELECT gldbld FROM gldb_t WHERE gldbent = ",g_enterprise,") "
            LET l_count = NULL
            SELECT COUNT(*) INTO l_count FROM gldb_t
             WHERE gldbent = g_enterprise
               AND gldbld  = g_glfg_m.glfg002
            IF cl_null(l_count)THEN LET l_count = 0 END IF
             
            IF l_count > 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'agl-00401'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
              #LET g_glfg_m.glfg002 = g_glfg_m_t.glfg002 #160824-00007#260 161220 By 08171 mark
               LET g_glfg_m.glfg002 = g_glfg_m_o.glfg002 #160824-00007#260 161220 By 08171 add
               CALL s_desc_get_ld_desc(g_glfg_m.glfg002) RETURNING g_glfg_m.glfg002_desc
               DISPLAY BY NAME g_glfg_m.glfg002
               NEXT FIELD CURRENT
            END IF
            #檢核排除中間層在單身打的合併帳別-----e
            
            IF NOT cl_null(g_glfg_m.glfg002)THEN
               CALL s_ld_sel_glaa(g_glfg_m.glfg002,'ALL') RETURNING g_glaa.*
               LET g_glfg_m.glfg007 = '' #160824-00007#260 161220 By 08171 add
               LET g_glfg_m.glfg007 = g_glaa.glaa001
               IF g_glaa.glaa015 = 'Y' THEN
                  LET g_glfg_m.glfg008 = '' #160824-00007#260 161220 By 08171 add
                  LET g_glfg_m.glfg008 = g_glaa.glaa016
               ELSE
                  LET g_glfg_m.glfg008 = ''
               END IF
               IF g_glaa.glaa019 = 'Y' THEN
                  LET g_glfg_m.glfg009 = '' #160824-00007#260 161220 By 08171 add
                  LET g_glfg_m.glfg009 = g_glaa.glaa020
               ELSE
                  LET g_glfg_m.glfg009 = ''
               END IF
            END IF
            CALL aglt501_set_visible()
            CALL s_desc_get_ld_desc(g_glfg_m.glfg002) RETURNING g_glfg_m.glfg002_desc
            DISPLAY BY NAME g_glfg_m.glfg007,g_glfg_m.glfg008,g_glfg_m.glfg009,g_glfg_m.glfg002_desc
            LET g_glfg_m_o.* = g_glfg_m.* #160824-00007#260 161220 By 08171 add

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glfg002
            #add-point:BEFORE FIELD glfg002 name="input.b.glfg002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glfg002
            #add-point:ON CHANGE glfg002 name="input.g.glfg002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glfg005
            #add-point:BEFORE FIELD glfg005 name="input.b.glfg005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glfg005
            
            #add-point:AFTER FIELD glfg005 name="input.a.glfg005"
            #應用 a05 樣板自動產生(Version:2)




            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glfg005
            #add-point:ON CHANGE glfg005 name="input.g.glfg005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glfg006
            #add-point:BEFORE FIELD glfg006 name="input.b.glfg006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glfg006
            
            #add-point:AFTER FIELD glfg006 name="input.a.glfg006"
            #應用 a05 樣板自動產生(Version:2)



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glfg006
            #add-point:ON CHANGE glfg006 name="input.g.glfg006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glfg007
            #add-point:BEFORE FIELD glfg007 name="input.b.glfg007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glfg007
            
            #add-point:AFTER FIELD glfg007 name="input.a.glfg007"
            LET g_gldh_d_o.* = g_gldh_d[l_ac].* #160824-00007#260 161220 By 08171 add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glfg007
            #add-point:ON CHANGE glfg007 name="input.g.glfg007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glfg008
            #add-point:BEFORE FIELD glfg008 name="input.b.glfg008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glfg008
            
            #add-point:AFTER FIELD glfg008 name="input.a.glfg008"
            LET g_gldh_d_o.* = g_gldh_d[l_ac].* #160824-00007#260 161220 By 08171 add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glfg008
            #add-point:ON CHANGE glfg008 name="input.g.glfg008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glfg009
            #add-point:BEFORE FIELD glfg009 name="input.b.glfg009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glfg009
            
            #add-point:AFTER FIELD glfg009 name="input.a.glfg009"
            LET g_gldh_d_o.* = g_gldh_d[l_ac].* #160824-00007#260 161220 By 08171 add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glfg009
            #add-point:ON CHANGE glfg009 name="input.g.glfg009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glfgstus
            #add-point:BEFORE FIELD glfgstus name="input.b.glfgstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glfgstus
            
            #add-point:AFTER FIELD glfgstus name="input.a.glfgstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glfgstus
            #add-point:ON CHANGE glfgstus name="input.g.glfgstus"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_gldh008
            #add-point:BEFORE FIELD l_gldh008 name="input.b.l_gldh008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_gldh008
            
            #add-point:AFTER FIELD l_gldh008 name="input.a.l_gldh008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_gldh008
            #add-point:ON CHANGE l_gldh008 name="input.g.l_gldh008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_gldh009
            #add-point:BEFORE FIELD l_gldh009 name="input.b.l_gldh009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_gldh009
            
            #add-point:AFTER FIELD l_gldh009 name="input.a.l_gldh009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_gldh009
            #add-point:ON CHANGE l_gldh009 name="input.g.l_gldh009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_gldh010
            #add-point:BEFORE FIELD l_gldh010 name="input.b.l_gldh010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_gldh010
            
            #add-point:AFTER FIELD l_gldh010 name="input.a.l_gldh010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_gldh010
            #add-point:ON CHANGE l_gldh010 name="input.g.l_gldh010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_gldh011
            #add-point:BEFORE FIELD l_gldh011 name="input.b.l_gldh011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_gldh011
            
            #add-point:AFTER FIELD l_gldh011 name="input.a.l_gldh011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_gldh011
            #add-point:ON CHANGE l_gldh011 name="input.g.l_gldh011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_gldh012
            #add-point:BEFORE FIELD l_gldh012 name="input.b.l_gldh012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_gldh012
            
            #add-point:AFTER FIELD l_gldh012 name="input.a.l_gldh012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_gldh012
            #add-point:ON CHANGE l_gldh012 name="input.g.l_gldh012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_gldh013
            #add-point:BEFORE FIELD l_gldh013 name="input.b.l_gldh013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_gldh013
            
            #add-point:AFTER FIELD l_gldh013 name="input.a.l_gldh013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_gldh013
            #add-point:ON CHANGE l_gldh013 name="input.g.l_gldh013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_gldh014
            #add-point:BEFORE FIELD l_gldh014 name="input.b.l_gldh014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_gldh014
            
            #add-point:AFTER FIELD l_gldh014 name="input.a.l_gldh014"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_gldh014
            #add-point:ON CHANGE l_gldh014 name="input.g.l_gldh014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_gldh015
            #add-point:BEFORE FIELD l_gldh015 name="input.b.l_gldh015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_gldh015
            
            #add-point:AFTER FIELD l_gldh015 name="input.a.l_gldh015"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_gldh015
            #add-point:ON CHANGE l_gldh015 name="input.g.l_gldh015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_gldh016
            #add-point:BEFORE FIELD l_gldh016 name="input.b.l_gldh016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_gldh016
            
            #add-point:AFTER FIELD l_gldh016 name="input.a.l_gldh016"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_gldh016
            #add-point:ON CHANGE l_gldh016 name="input.g.l_gldh016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_gldh017
            #add-point:BEFORE FIELD l_gldh017 name="input.b.l_gldh017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_gldh017
            
            #add-point:AFTER FIELD l_gldh017 name="input.a.l_gldh017"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_gldh017
            #add-point:ON CHANGE l_gldh017 name="input.g.l_gldh017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_gldh018
            #add-point:BEFORE FIELD l_gldh018 name="input.b.l_gldh018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_gldh018
            
            #add-point:AFTER FIELD l_gldh018 name="input.a.l_gldh018"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_gldh018
            #add-point:ON CHANGE l_gldh018 name="input.g.l_gldh018"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_gldh019
            #add-point:BEFORE FIELD l_gldh019 name="input.b.l_gldh019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_gldh019
            
            #add-point:AFTER FIELD l_gldh019 name="input.a.l_gldh019"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_gldh019
            #add-point:ON CHANGE l_gldh019 name="input.g.l_gldh019"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_gldh020
            #add-point:BEFORE FIELD l_gldh020 name="input.b.l_gldh020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_gldh020
            
            #add-point:AFTER FIELD l_gldh020 name="input.a.l_gldh020"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_gldh020
            #add-point:ON CHANGE l_gldh020 name="input.g.l_gldh020"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_gldh021
            #add-point:BEFORE FIELD l_gldh021 name="input.b.l_gldh021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_gldh021
            
            #add-point:AFTER FIELD l_gldh021 name="input.a.l_gldh021"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_gldh021
            #add-point:ON CHANGE l_gldh021 name="input.g.l_gldh021"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.glfg001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glfg001
            #add-point:ON ACTION controlp INFIELD glfg001 name="input.c.glfg001"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_glfg_m.glfg001
            LET g_qryparam.where = "gldastus = 'Y' AND glda002 = 'N' "
            CALL q_glda001()
            LET g_glfg_m.glfg001 = g_qryparam.return1
            CALL s_desc_glda001_desc(g_glfg_m.glfg001) RETURNING g_glfg_m.glfg001_desc
            DISPLAY BY NAME g_glfg_m.glfg001,g_glfg_m.glfg001_desc
            NEXT FIELD glfg001
            #END add-point
 
 
         #Ctrlp:input.c.glfg002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glfg002
            #add-point:ON ACTION controlp INFIELD glfg002 name="input.c.glfg002"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_glfg_m.glfg002
            LET g_qryparam.arg1 = g_user                                 #人員權限
            LET g_qryparam.arg2 = g_dept              #部門權限
            LET g_qryparam.where = " glaald IN (SELECT gldc003 FROM gldc_t WHERE gldc002 = '",g_glfg_m.glfg001,"' ) ",
                                   " AND glaald NOT IN (SELECT gldbld FROM gldb_t WHERE gldbent = ",g_enterprise,") "
            CALL q_gldc003()
            LET g_glfg_m.glfg002 = g_qryparam.return1
            CALL s_desc_get_ld_desc(g_glfg_m.glfg002) RETURNING g_glfg_m.glfg002_desc
            DISPLAY BY NAME g_glfg_m.glfg002,g_glfg_m.glfg002_desc
            NEXT FIELD glfg002
            #END add-point
 
 
         #Ctrlp:input.c.glfg005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glfg005
            #add-point:ON ACTION controlp INFIELD glfg005 name="input.c.glfg005"
            
            #END add-point
 
 
         #Ctrlp:input.c.glfg006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glfg006
            #add-point:ON ACTION controlp INFIELD glfg006 name="input.c.glfg006"
            
            #END add-point
 
 
         #Ctrlp:input.c.glfg007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glfg007
            #add-point:ON ACTION controlp INFIELD glfg007 name="input.c.glfg007"
            
            #END add-point
 
 
         #Ctrlp:input.c.glfg008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glfg008
            #add-point:ON ACTION controlp INFIELD glfg008 name="input.c.glfg008"
            
            #END add-point
 
 
         #Ctrlp:input.c.glfg009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glfg009
            #add-point:ON ACTION controlp INFIELD glfg009 name="input.c.glfg009"
            
            #END add-point
 
 
         #Ctrlp:input.c.glfgstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glfgstus
            #add-point:ON ACTION controlp INFIELD glfgstus name="input.c.glfgstus"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_gldh008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_gldh008
            #add-point:ON ACTION controlp INFIELD l_gldh008 name="input.c.l_gldh008"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_gldh009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_gldh009
            #add-point:ON ACTION controlp INFIELD l_gldh009 name="input.c.l_gldh009"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_gldh010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_gldh010
            #add-point:ON ACTION controlp INFIELD l_gldh010 name="input.c.l_gldh010"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_gldh011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_gldh011
            #add-point:ON ACTION controlp INFIELD l_gldh011 name="input.c.l_gldh011"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_gldh012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_gldh012
            #add-point:ON ACTION controlp INFIELD l_gldh012 name="input.c.l_gldh012"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_gldh013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_gldh013
            #add-point:ON ACTION controlp INFIELD l_gldh013 name="input.c.l_gldh013"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_gldh014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_gldh014
            #add-point:ON ACTION controlp INFIELD l_gldh014 name="input.c.l_gldh014"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_gldh015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_gldh015
            #add-point:ON ACTION controlp INFIELD l_gldh015 name="input.c.l_gldh015"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_gldh016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_gldh016
            #add-point:ON ACTION controlp INFIELD l_gldh016 name="input.c.l_gldh016"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_gldh017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_gldh017
            #add-point:ON ACTION controlp INFIELD l_gldh017 name="input.c.l_gldh017"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_gldh018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_gldh018
            #add-point:ON ACTION controlp INFIELD l_gldh018 name="input.c.l_gldh018"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_gldh019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_gldh019
            #add-point:ON ACTION controlp INFIELD l_gldh019 name="input.c.l_gldh019"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_gldh020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_gldh020
            #add-point:ON ACTION controlp INFIELD l_gldh020 name="input.c.l_gldh020"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_gldh021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_gldh021
            #add-point:ON ACTION controlp INFIELD l_gldh021 name="input.c.l_gldh021"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_glfg_m.glfg001,g_glfg_m.glfg002,g_glfg_m.glfg005,g_glfg_m.glfg006
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            #確認資料無重複
            IF NOT cl_null(g_glfg_m.glfg001) AND NOT cl_null(g_glfg_m.glfg002) AND NOT cl_null(g_glfg_m.glfg005) AND NOT cl_null(g_glfg_m.glfg006) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_glfg_m.glfg001 != g_glfg001_t  OR g_glfg_m.glfg002 != g_glfg002_t  OR g_glfg_m.glfg005 != g_glfg005_t  OR g_glfg_m.glfg006 != g_glfg006_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM glfg_t WHERE "||"glfgent = '" ||g_enterprise|| "' AND "||"glfg001 = '"||g_glfg_m.glfg001 ||"' AND "|| "glfg002 = '"||g_glfg_m.glfg002 ||"' AND "|| "glfg005 = '"||g_glfg_m.glfg005 ||"' AND "|| "glfg006 = '"||g_glfg_m.glfg006 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               
               #end add-point
               
               INSERT INTO glfg_t (glfgent,glfg001,glfg002,glfg005,glfg006,glfg007,glfg008,glfg009,glfgstus, 
                   glfgownid,glfgowndp,glfgcrtid,glfgcrtdp,glfgcrtdt,glfgmodid,glfgmoddt,glfgcnfid,glfgcnfdt) 
 
               VALUES (g_enterprise,g_glfg_m.glfg001,g_glfg_m.glfg002,g_glfg_m.glfg005,g_glfg_m.glfg006, 
                   g_glfg_m.glfg007,g_glfg_m.glfg008,g_glfg_m.glfg009,g_glfg_m.glfgstus,g_glfg_m.glfgownid, 
                   g_glfg_m.glfgowndp,g_glfg_m.glfgcrtid,g_glfg_m.glfgcrtdp,g_glfg_m.glfgcrtdt,g_glfg_m.glfgmodid, 
                   g_glfg_m.glfgmoddt,g_glfg_m.glfgcnfid,g_glfg_m.glfgcnfdt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_glfg_m:",SQLERRMESSAGE 
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
                  CALL aglt501_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL aglt501_b_fill()
                  CALL aglt501_b_fill2('0')
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
               CALL aglt501_glfg_t_mask_restore('restore_mask_o')
               
               UPDATE glfg_t SET (glfg001,glfg002,glfg005,glfg006,glfg007,glfg008,glfg009,glfgstus,glfgownid, 
                   glfgowndp,glfgcrtid,glfgcrtdp,glfgcrtdt,glfgmodid,glfgmoddt,glfgcnfid,glfgcnfdt) = (g_glfg_m.glfg001, 
                   g_glfg_m.glfg002,g_glfg_m.glfg005,g_glfg_m.glfg006,g_glfg_m.glfg007,g_glfg_m.glfg008, 
                   g_glfg_m.glfg009,g_glfg_m.glfgstus,g_glfg_m.glfgownid,g_glfg_m.glfgowndp,g_glfg_m.glfgcrtid, 
                   g_glfg_m.glfgcrtdp,g_glfg_m.glfgcrtdt,g_glfg_m.glfgmodid,g_glfg_m.glfgmoddt,g_glfg_m.glfgcnfid, 
                   g_glfg_m.glfgcnfdt)
                WHERE glfgent = g_enterprise AND glfg001 = g_glfg001_t
                  AND glfg002 = g_glfg002_t
                  AND glfg005 = g_glfg005_t
                  AND glfg006 = g_glfg006_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "glfg_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL aglt501_glfg_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_glfg_m_t)
               LET g_log2 = util.JSON.stringify(g_glfg_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_glfg001_t = g_glfg_m.glfg001
            LET g_glfg002_t = g_glfg_m.glfg002
            LET g_glfg005_t = g_glfg_m.glfg005
            LET g_glfg006_t = g_glfg_m.glfg006
 
            
      END INPUT
   
 
{</section>}
 
{<section id="aglt501.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_gldh_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aglt501
            LET g_action_choice="open_aglt501"
            IF cl_auth_chk_act("open_aglt501") THEN
               
               #add-point:ON ACTION open_aglt501 name="input.detail_input.page1.open_aglt501"
               #科目不為空才可打核算項
               IF NOT cl_null(g_gldh_d[l_ac].gldh003)THEN
                  #用會科給核算項預設值
                  CALL s_fin_sel_glad(g_glfg_m.glfg002,g_gldh_d[l_ac].gldh003,'ALL') RETURNING g_glad.*
                  IF g_glda.glda002 = 'Y' 
                     AND (g_glad.glad007 = 'N' OR cl_null(g_glad.glad007))
                     AND (g_glad.glad008 = 'N' OR cl_null(g_glad.glad008))
                     AND (g_glad.glad009 = 'N' OR cl_null(g_glad.glad009))
                     AND (g_glad.glad010 = 'N' OR cl_null(g_glad.glad010))
                     AND (g_glad.glad027 = 'N' OR cl_null(g_glad.glad027))
                     AND (g_glad.glad011 = 'N' OR cl_null(g_glad.glad011))
                     AND (g_glad.glad012 = 'N' OR cl_null(g_glad.glad012))
                     AND (g_glad.glad031 = 'N' OR cl_null(g_glad.glad031))
                     AND (g_glad.glad032 = 'N' OR cl_null(g_glad.glad032))
                     AND (g_glad.glad033 = 'N' OR cl_null(g_glad.glad033))
                     AND (g_glad.glad013 = 'N' OR cl_null(g_glad.glad013))
                     AND (g_glad.glad015 = 'N' OR cl_null(g_glad.glad015))
                     AND (g_glad.glad016 = 'N' OR cl_null(g_glad.glad016)) THEN
                     INITIALIZE g_errparam.* TO NULL
                     LET g_errparam.code = 'agl-00315'
                     LET g_errparam.extend  = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     
                  ELSE
                     #核算項維護
                     CALL aglt501_open_aglt501_01(l_ac)
                     #組複合KEY                  
                     CALL aglt501_get_gldh0072(l_ac)RETURNING g_gldh_d[l_ac].gldh007
                     DISPLAY BY NAME g_gldh_d[l_ac].gldh003,g_gldh_d[l_ac].gldh007,g_gldh_d[l_ac].gldh008,g_gldh_d[l_ac].gldh009,
                                     g_gldh_d[l_ac].gldh010,g_gldh_d[l_ac].gldh011,g_gldh_d[l_ac].gldh012,
                                     g_gldh_d[l_ac].gldh013,g_gldh_d[l_ac].gldh014,g_gldh_d[l_ac].gldh015,
                                     g_gldh_d[l_ac].gldh016,g_gldh_d[l_ac].gldh017,g_gldh_d[l_ac].gldh018,
                                     g_gldh_d[l_ac].gldh019,g_gldh_d[l_ac].gldh020,g_gldh_d[l_ac].gldh021
                  END IF
                  CALL aglt501_otherdetail_show(l_ac)
                  NEXT FIELD gldh003
               ELSE
                  #請先輸入科目在執行核算項維護
                  INITIALIZE g_errparam.* TO NULL
                  LET g_errparam.code = 'agl-00314'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
               END IF
               #END add-point
            END IF
 
 
 
 
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_gldh_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aglt501_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_gldh_d.getLength()
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
            OPEN aglt501_cl USING g_enterprise,g_glfg_m.glfg001,g_glfg_m.glfg002,g_glfg_m.glfg005,g_glfg_m.glfg006
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aglt501_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aglt501_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_gldh_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_gldh_d[l_ac].gldh003 IS NOT NULL
               AND g_gldh_d[l_ac].gldh007 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_gldh_d_t.* = g_gldh_d[l_ac].*  #BACKUP
               LET g_gldh_d_o.* = g_gldh_d[l_ac].*  #BACKUP
               CALL aglt501_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL aglt501_set_no_entry_b(l_cmd)
               IF NOT aglt501_lock_b("gldh_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aglt501_bcl INTO g_gldh_d[l_ac].gldh007,g_gldh_d[l_ac].gldh003,g_gldh_d[l_ac].gldh004, 
                      g_gldh_d[l_ac].gldh025,g_gldh_d[l_ac].gldh026,g_gldh_d[l_ac].gldh028,g_gldh_d[l_ac].gldh029, 
                      g_gldh_d[l_ac].gldh031,g_gldh_d[l_ac].gldh032,g_gldh_d[l_ac].gldh008,g_gldh_d[l_ac].gldh009, 
                      g_gldh_d[l_ac].gldh010,g_gldh_d[l_ac].gldh011,g_gldh_d[l_ac].gldh012,g_gldh_d[l_ac].gldh013, 
                      g_gldh_d[l_ac].gldh014,g_gldh_d[l_ac].gldh015,g_gldh_d[l_ac].gldh016,g_gldh_d[l_ac].gldh017, 
                      g_gldh_d[l_ac].gldh018,g_gldh_d[l_ac].gldh019,g_gldh_d[l_ac].gldh020,g_gldh_d[l_ac].gldh021, 
                      g_gldh_d[l_ac].gldh022,g_gldh_d[l_ac].gldh023,g_gldh_d[l_ac].gldh024,g_gldh_d[l_ac].gldh027, 
                      g_gldh_d[l_ac].gldh030
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_gldh_d_t.gldh003,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_gldh_d_mask_o[l_ac].* =  g_gldh_d[l_ac].*
                  CALL aglt501_gldh_t_mask()
                  LET g_gldh_d_mask_n[l_ac].* =  g_gldh_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aglt501_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            CALL s_fin_sel_glad(g_glfg_m.glfg002,g_gldh_d[l_ac].gldh003,'ALL') RETURNING g_glad.*
           #161111-00028#9---modify---begin----------
           #SELECT * INTO g_glda.* 
            SELECT gldaent,gldaownid,gldaowndp,gldacrtid,gldacrtdp,gldacrtdt,gldamodid,
                   gldamoddt,gldastus,glda001,glda002,glda003,glda004 INTO g_glda.* 
           #161111-00028#9---modify---end----------
            FROM glda_t
             WHERE gldaent = g_enterprise
               AND glda001 = g_glfg_m.glfg001
            CALL aglt501_otherdetail_show(l_ac)
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
            INITIALIZE g_gldh_d[l_ac].* TO NULL 
            INITIALIZE g_gldh_d_t.* TO NULL 
            INITIALIZE g_gldh_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_gldh_d[l_ac].gldh025 = "0"
      LET g_gldh_d[l_ac].gldh026 = "0"
      LET g_gldh_d[l_ac].gldh028 = "0"
      LET g_gldh_d[l_ac].gldh029 = "0"
      LET g_gldh_d[l_ac].gldh031 = "0"
      LET g_gldh_d[l_ac].gldh032 = "0"
      LET g_gldh_d[l_ac].gldh022 = "0"
      LET g_gldh_d[l_ac].gldh023 = "0"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            #單頭幣別給值
            LET g_gldh_d[l_ac].gldh024 = g_glfg_m.glfg007
            LET g_gldh_d[l_ac].gldh027 = g_glfg_m.glfg008
            LET g_gldh_d[l_ac].gldh030 = g_glfg_m.glfg009
            
            #核算項給預設值  #不用科目就能預設的值
            #營運據點
            #依單頭帳套所屬法人帶預設值到營運據點,核算項中的營運據點預設值也是來自此處
            IF cl_null(g_gldh_d[l_ac].gldh008) THEN
               LET g_gldh_d[l_ac].gldh008 = g_glaa.glaacomp
            END IF
            
            #end add-point
            LET g_gldh_d_t.* = g_gldh_d[l_ac].*     #新輸入資料
            LET g_gldh_d_o.* = g_gldh_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aglt501_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL aglt501_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_gldh_d[li_reproduce_target].* = g_gldh_d[li_reproduce].*
 
               LET g_gldh_d[li_reproduce_target].gldh003 = NULL
               LET g_gldh_d[li_reproduce_target].gldh007 = NULL
 
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
            #組合出複合KEY          
            CALL aglt501_get_gldh0072(l_ac)RETURNING g_gldh_d[l_ac].gldh007
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM gldh_t 
             WHERE gldhent = g_enterprise AND gldh001 = g_glfg_m.glfg001
               AND gldh002 = g_glfg_m.glfg002
               AND gldh005 = g_glfg_m.glfg005
               AND gldh006 = g_glfg_m.glfg006
 
               AND gldh003 = g_gldh_d[l_ac].gldh003
               AND gldh007 = g_gldh_d[l_ac].gldh007
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_glfg_m.glfg001
               LET gs_keys[2] = g_glfg_m.glfg002
               LET gs_keys[3] = g_glfg_m.glfg005
               LET gs_keys[4] = g_glfg_m.glfg006
               LET gs_keys[5] = g_gldh_d[g_detail_idx].gldh003
               LET gs_keys[6] = g_gldh_d[g_detail_idx].gldh007
               CALL aglt501_insert_b('gldh_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_gldh_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "gldh_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aglt501_b_fill()
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
               LET gs_keys[01] = g_glfg_m.glfg001
               LET gs_keys[gs_keys.getLength()+1] = g_glfg_m.glfg002
               LET gs_keys[gs_keys.getLength()+1] = g_glfg_m.glfg005
               LET gs_keys[gs_keys.getLength()+1] = g_glfg_m.glfg006
 
               LET gs_keys[gs_keys.getLength()+1] = g_gldh_d_t.gldh003
               LET gs_keys[gs_keys.getLength()+1] = g_gldh_d_t.gldh007
 
            
               #刪除同層單身
               IF NOT aglt501_delete_b('gldh_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aglt501_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aglt501_key_delete_b(gs_keys,'gldh_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aglt501_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE aglt501_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_gldh_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_gldh_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldh007
            #add-point:BEFORE FIELD gldh007 name="input.b.page1.gldh007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldh007
            
            #add-point:AFTER FIELD gldh007 name="input.a.page1.gldh007"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_glfg_m.glfg001 IS NOT NULL AND g_glfg_m.glfg002 IS NOT NULL AND g_glfg_m.glfg005 IS NOT NULL AND g_glfg_m.glfg006 IS NOT NULL AND g_gldh_d[g_detail_idx].gldh003 IS NOT NULL AND g_gldh_d[g_detail_idx].gldh007 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_glfg_m.glfg001 != g_glfg001_t OR g_glfg_m.glfg002 != g_glfg002_t OR g_glfg_m.glfg005 != g_glfg005_t OR g_glfg_m.glfg006 != g_glfg006_t OR g_gldh_d[g_detail_idx].gldh003 != g_gldh_d_t.gldh003 OR g_gldh_d[g_detail_idx].gldh007 != g_gldh_d_t.gldh007)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gldh_t WHERE "||"gldhent = '" ||g_enterprise|| "' AND "||"gldh001 = '"||g_glfg_m.glfg001 ||"' AND "|| "gldh002 = '"||g_glfg_m.glfg002 ||"' AND "|| "gldh005 = '"||g_glfg_m.glfg005 ||"' AND "|| "gldh006 = '"||g_glfg_m.glfg006 ||"' AND "|| "gldh003 = '"||g_gldh_d[g_detail_idx].gldh003 ||"' AND "|| "gldh007 = '"||g_gldh_d[g_detail_idx].gldh007 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldh007
            #add-point:ON CHANGE gldh007 name="input.g.page1.gldh007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldh003
            #add-point:BEFORE FIELD gldh003 name="input.b.page1.gldh003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldh003
            
            #add-point:AFTER FIELD gldh003 name="input.a.page1.gldh003"
            #應用 a05 樣板自動產生(Version:2)
            
            IF NOT cl_null(g_gldh_d[l_ac].gldh003) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_gldh_d[l_ac].gldh003 != g_gldh_d_t.gldh003 OR g_gldh_d_t.gldh003 IS NULL )) THEN  #160824-00007#260 161220 By 08171 mark
               IF cl_null(g_gldh_d_o.gldh003) OR g_gldh_d[l_ac].gldh003 != g_gldh_d_o.gldh003 THEN #160824-00007#260 161220 By 08171 add
                  #SA 150304-----s
                  #(非T100公司)都幫它打開之後,然後都先不予以控卡  
                  #後續如果輔導時有強制要讓此非T100公司一定要在某個帳套裡設好一套會科
                  #就用單頭的那個帳套去找到參照表，再進行控卡
                  #SA------------e 
                  
                  IF g_glda.glda002 = 'Y' THEN
                     CALL s_merge_glac002_chk(g_glaa.glaa004,g_gldh_d[l_ac].gldh003)    
                        RETURNING g_sub_success,g_errno
                     IF NOT g_sub_success THEN
                        INITIALIZE g_errparam.* TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = ''
                        #160321-00016#31 --s add
                        IF g_errno = 'sub-01302' THEN
                           LET g_errparam.replace[1] = 'agli020'
                           LET g_errparam.replace[2] = cl_get_progname('agli020',g_lang,"2")
                           LET g_errparam.exeprog = 'agli020'
                        END IF
                        #160321-00016#31 --e add
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                       #LET g_gldh_d[l_ac].gldh003 = g_gldh_d_t.gldh003 #160824-00007#260 161220 By 08171 mark
                        LET g_gldh_d[l_ac].gldh003 = g_gldh_d_o.gldh003 #160824-00007#260 161220 By 08171 add
                        LET g_gldh_d[l_ac].gldh004 =  s_desc_get_account_desc(g_glfg_m.glfg002,g_gldh_d[l_ac].gldh003)
                        DISPLAY BY NAME g_gldh_d[l_ac].gldh003,g_gldh_d[l_ac].gldh004
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  
                  IF g_glda.glda002 = 'Y' 
                     AND (g_glad.glad007 = 'N' OR cl_null(g_glad.glad007))
                     AND (g_glad.glad008 = 'N' OR cl_null(g_glad.glad008))
                     AND (g_glad.glad009 = 'N' OR cl_null(g_glad.glad009))
                     AND (g_glad.glad010 = 'N' OR cl_null(g_glad.glad010))
                     AND (g_glad.glad027 = 'N' OR cl_null(g_glad.glad027))
                     AND (g_glad.glad011 = 'N' OR cl_null(g_glad.glad011))
                     AND (g_glad.glad012 = 'N' OR cl_null(g_glad.glad012))
                     AND (g_glad.glad031 = 'N' OR cl_null(g_glad.glad031))
                     AND (g_glad.glad032 = 'N' OR cl_null(g_glad.glad032))
                     AND (g_glad.glad033 = 'N' OR cl_null(g_glad.glad033))
                     AND (g_glad.glad013 = 'N' OR cl_null(g_glad.glad013))
                     AND (g_glad.glad015 = 'N' OR cl_null(g_glad.glad015))
                     AND (g_glad.glad016 = 'N' OR cl_null(g_glad.glad016)) THEN
                  ELSE
                     #核算項維護
                     CALL aglt501_open_aglt501_01(l_ac)
                     #組複合KEY   
                     LET g_gldh_d[l_ac].gldh007 = '' #160824-00007#260 161220 By 08171 add                     
                     CALL aglt501_get_gldh0072(l_ac)RETURNING g_gldh_d[l_ac].gldh007
                     DISPLAY BY NAME g_gldh_d[l_ac].gldh003,g_gldh_d[l_ac].gldh007,g_gldh_d[l_ac].gldh008,g_gldh_d[l_ac].gldh009,
                                     g_gldh_d[l_ac].gldh010,g_gldh_d[l_ac].gldh011,g_gldh_d[l_ac].gldh012,
                                     g_gldh_d[l_ac].gldh013,g_gldh_d[l_ac].gldh014,g_gldh_d[l_ac].gldh015,
                                     g_gldh_d[l_ac].gldh016,g_gldh_d[l_ac].gldh017,g_gldh_d[l_ac].gldh018,
                                     g_gldh_d[l_ac].gldh019,g_gldh_d[l_ac].gldh020,g_gldh_d[l_ac].gldh021
                  END IF
                  CALL aglt501_otherdetail_show(l_ac)
                  
                  #會科說明替換
                  LET l_desc =  s_desc_get_account_desc(g_glfg_m.glfg002,g_gldh_d[l_ac].gldh003)
                  IF NOT cl_null(l_desc)THEN
                     LET g_gldh_d[l_ac].gldh004 = l_desc
                     DISPLAY BY NAME g_gldh_d[l_ac].gldh004
                  END IF
               END IF
            END IF
            
            #確認資料無重複
            IF g_glfg_m.glfg001 IS NOT NULL AND g_glfg_m.glfg002 IS NOT NULL AND g_glfg_m.glfg005 IS NOT NULL AND g_glfg_m.glfg006 IS NOT NULL AND g_gldh_d[g_detail_idx].gldh003 IS NOT NULL AND g_gldh_d[g_detail_idx].gldh007 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_glfg_m.glfg001 != g_glfg001_t OR g_glfg_m.glfg002 != g_glfg002_t OR g_glfg_m.glfg005 != g_glfg005_t OR g_glfg_m.glfg006 != g_glfg006_t OR g_gldh_d[g_detail_idx].gldh003 != g_gldh_d_t.gldh003 OR g_gldh_d[g_detail_idx].gldh007 != g_gldh_d_t.gldh007)) THEN                  
                  LET l_count = 1
                  SELECT COUNT(*) INTO l_count FROM gldh_t 
                   WHERE gldhent = g_enterprise AND gldh001 = g_glfg_m.glfg001
                     AND gldh002 = g_glfg_m.glfg002
                     AND gldh005 = g_glfg_m.glfg005
                     AND gldh006 = g_glfg_m.glfg006
                     AND gldh003 = g_gldh_d[l_ac].gldh003
                     AND gldh007 = g_gldh_d[l_ac].gldh007
                  IF l_count > 0 THEN
                     INITIALIZE g_errparam.* TO NULL
                     LET g_errparam.code = 'std-00004'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  END IF                  
               END IF
            END IF

            LET g_gldh_d_o.* = g_gldh_d[l_ac].* #160824-00007#260 161220 By 08171 add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldh003
            #add-point:ON CHANGE gldh003 name="input.g.page1.gldh003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldh004
            #add-point:BEFORE FIELD gldh004 name="input.b.page1.gldh004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldh004
            
            #add-point:AFTER FIELD gldh004 name="input.a.page1.gldh004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldh004
            #add-point:ON CHANGE gldh004 name="input.g.page1.gldh004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldh025
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_gldh_d[l_ac].gldh025,"0","1","","","azz-00079",1) THEN
               NEXT FIELD gldh025
            END IF 
 
 
 
            #add-point:AFTER FIELD gldh025 name="input.a.page1.gldh025"
            IF NOT cl_null(g_gldh_d[l_ac].gldh025) THEN 
               CALL s_curr_round_ld('1',g_glfg_m.glfg002,g_glfg_m.glfg007,g_gldh_d[l_ac].gldh025,2) RETURNING g_sub_success,g_errno,g_gldh_d[l_ac].gldh025
            ELSE
               LET g_gldh_d[l_ac].gldh025 = 0
               DISPLAY BY NAME g_gldh_d[l_ac].gldh025
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldh025
            #add-point:BEFORE FIELD gldh025 name="input.b.page1.gldh025"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldh025
            #add-point:ON CHANGE gldh025 name="input.g.page1.gldh025"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldh026
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_gldh_d[l_ac].gldh026,"0","1","","","azz-00079",1) THEN
               NEXT FIELD gldh026
            END IF 
 
 
 
            #add-point:AFTER FIELD gldh026 name="input.a.page1.gldh026"
            IF NOT cl_null(g_gldh_d[l_ac].gldh026) THEN
               CALL s_curr_round_ld('1',g_glfg_m.glfg002,g_glfg_m.glfg007,g_gldh_d[l_ac].gldh026,2) RETURNING g_sub_success,g_errno,g_gldh_d[l_ac].gldh026
               DISPLAY BY NAME g_gldh_d[l_ac].gldh026
            ELSE            
               LET g_gldh_d[l_ac].gldh026 = 0
               DISPLAY BY NAME g_gldh_d[l_ac].gldh026  
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldh026
            #add-point:BEFORE FIELD gldh026 name="input.b.page1.gldh026"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldh026
            #add-point:ON CHANGE gldh026 name="input.g.page1.gldh026"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldh028
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_gldh_d[l_ac].gldh028,"0","1","","","azz-00079",1) THEN
               NEXT FIELD gldh028
            END IF 
 
 
 
            #add-point:AFTER FIELD gldh028 name="input.a.page1.gldh028"
            IF NOT cl_null(g_gldh_d[l_ac].gldh028) THEN 
               CALL s_curr_round_ld('1',g_glfg_m.glfg002,g_glfg_m.glfg008,g_gldh_d[l_ac].gldh028,2) RETURNING g_sub_success,g_errno,g_gldh_d[l_ac].gldh028
               DISPLAY BY NAME g_gldh_d[l_ac].gldh028
            ELSE
               LET g_gldh_d[l_ac].gldh028 = 0
               DISPLAY BY NAME g_gldh_d[l_ac].gldh028  
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldh028
            #add-point:BEFORE FIELD gldh028 name="input.b.page1.gldh028"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldh028
            #add-point:ON CHANGE gldh028 name="input.g.page1.gldh028"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldh029
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_gldh_d[l_ac].gldh029,"0","1","","","azz-00079",1) THEN
               NEXT FIELD gldh029
            END IF 
 
 
 
            #add-point:AFTER FIELD gldh029 name="input.a.page1.gldh029"
            IF NOT cl_null(g_gldh_d[l_ac].gldh029) THEN
               CALL s_curr_round_ld('1',g_glfg_m.glfg002,g_glfg_m.glfg008,g_gldh_d[l_ac].gldh029,2) RETURNING g_sub_success,g_errno,g_gldh_d[l_ac].gldh029
               DISPLAY BY NAME g_gldh_d[l_ac].gldh029
            ELSE
               LET g_gldh_d[l_ac].gldh029 = 0
               DISPLAY BY NAME g_gldh_d[l_ac].gldh029               
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldh029
            #add-point:BEFORE FIELD gldh029 name="input.b.page1.gldh029"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldh029
            #add-point:ON CHANGE gldh029 name="input.g.page1.gldh029"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldh031
            #add-point:BEFORE FIELD gldh031 name="input.b.page1.gldh031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldh031
            
            #add-point:AFTER FIELD gldh031 name="input.a.page1.gldh031"
            IF NOT cl_null(g_gldh_d[l_ac].gldh031)THEN 
               IF NOT cl_ap_chk_range(g_gldh_d[l_ac].gldh031,"0","1","","","azz-00079",1) THEN
                  NEXT FIELD gldh031
               END IF 
               CALL s_curr_round_ld('1',g_glfg_m.glfg002,g_glfg_m.glfg009,g_gldh_d[l_ac].gldh031,2) RETURNING g_sub_success,g_errno,g_gldh_d[l_ac].gldh031
               DISPLAY BY NAME g_gldh_d[l_ac].gldh031
            ELSE
               LET g_gldh_d[l_ac].gldh031 = 0
               DISPLAY BY NAME g_gldh_d[l_ac].gldh031
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldh031
            #add-point:ON CHANGE gldh031 name="input.g.page1.gldh031"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldh032
            #add-point:BEFORE FIELD gldh032 name="input.b.page1.gldh032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldh032
            
            #add-point:AFTER FIELD gldh032 name="input.a.page1.gldh032"
            IF NOT cl_null(g_gldh_d[l_ac].gldh032)THEN
               IF NOT cl_ap_chk_range(g_gldh_d[l_ac].gldh032,"0","1","","","azz-00079",1) THEN
                  NEXT FIELD gldh032
               END IF
               CALL s_curr_round_ld('1',g_glfg_m.glfg002,g_glfg_m.glfg009,g_gldh_d[l_ac].gldh032,2) RETURNING g_sub_success,g_errno,g_gldh_d[l_ac].gldh032
               DISPLAY BY NAME g_gldh_d[l_ac].gldh032
            ELSE
               LET g_gldh_d[l_ac].gldh032 = 0
               DISPLAY BY NAME g_gldh_d[l_ac].gldh032               
            END IF
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldh032
            #add-point:ON CHANGE gldh032 name="input.g.page1.gldh032"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldh008
            #add-point:BEFORE FIELD gldh008 name="input.b.page1.gldh008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldh008
            
            #add-point:AFTER FIELD gldh008 name="input.a.page1.gldh008"


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldh008
            #add-point:ON CHANGE gldh008 name="input.g.page1.gldh008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldh009
            #add-point:BEFORE FIELD gldh009 name="input.b.page1.gldh009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldh009
            
            #add-point:AFTER FIELD gldh009 name="input.a.page1.gldh009"


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldh009
            #add-point:ON CHANGE gldh009 name="input.g.page1.gldh009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldh010
            #add-point:BEFORE FIELD gldh010 name="input.b.page1.gldh010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldh010
            
            #add-point:AFTER FIELD gldh010 name="input.a.page1.gldh010"


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldh010
            #add-point:ON CHANGE gldh010 name="input.g.page1.gldh010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldh011
            #add-point:BEFORE FIELD gldh011 name="input.b.page1.gldh011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldh011
            
            #add-point:AFTER FIELD gldh011 name="input.a.page1.gldh011"


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldh011
            #add-point:ON CHANGE gldh011 name="input.g.page1.gldh011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldh012
            #add-point:BEFORE FIELD gldh012 name="input.b.page1.gldh012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldh012
            
            #add-point:AFTER FIELD gldh012 name="input.a.page1.gldh012"


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldh012
            #add-point:ON CHANGE gldh012 name="input.g.page1.gldh012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldh013
            #add-point:BEFORE FIELD gldh013 name="input.b.page1.gldh013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldh013
            
            #add-point:AFTER FIELD gldh013 name="input.a.page1.gldh013"


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldh013
            #add-point:ON CHANGE gldh013 name="input.g.page1.gldh013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldh014
            #add-point:BEFORE FIELD gldh014 name="input.b.page1.gldh014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldh014
            
            #add-point:AFTER FIELD gldh014 name="input.a.page1.gldh014"


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldh014
            #add-point:ON CHANGE gldh014 name="input.g.page1.gldh014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldh015
            #add-point:BEFORE FIELD gldh015 name="input.b.page1.gldh015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldh015
            
            #add-point:AFTER FIELD gldh015 name="input.a.page1.gldh015"


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldh015
            #add-point:ON CHANGE gldh015 name="input.g.page1.gldh015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldh016
            #add-point:BEFORE FIELD gldh016 name="input.b.page1.gldh016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldh016
            
            #add-point:AFTER FIELD gldh016 name="input.a.page1.gldh016"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldh016
            #add-point:ON CHANGE gldh016 name="input.g.page1.gldh016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldh017
            #add-point:BEFORE FIELD gldh017 name="input.b.page1.gldh017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldh017
            
            #add-point:AFTER FIELD gldh017 name="input.a.page1.gldh017"


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldh017
            #add-point:ON CHANGE gldh017 name="input.g.page1.gldh017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldh018
            #add-point:BEFORE FIELD gldh018 name="input.b.page1.gldh018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldh018
            
            #add-point:AFTER FIELD gldh018 name="input.a.page1.gldh018"


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldh018
            #add-point:ON CHANGE gldh018 name="input.g.page1.gldh018"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldh019
            #add-point:BEFORE FIELD gldh019 name="input.b.page1.gldh019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldh019
            
            #add-point:AFTER FIELD gldh019 name="input.a.page1.gldh019"


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldh019
            #add-point:ON CHANGE gldh019 name="input.g.page1.gldh019"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldh020
            #add-point:BEFORE FIELD gldh020 name="input.b.page1.gldh020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldh020
            
            #add-point:AFTER FIELD gldh020 name="input.a.page1.gldh020"


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldh020
            #add-point:ON CHANGE gldh020 name="input.g.page1.gldh020"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldh021
            #add-point:BEFORE FIELD gldh021 name="input.b.page1.gldh021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldh021
            
            #add-point:AFTER FIELD gldh021 name="input.a.page1.gldh021"


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldh021
            #add-point:ON CHANGE gldh021 name="input.g.page1.gldh021"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldh022
            #add-point:BEFORE FIELD gldh022 name="input.b.page1.gldh022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldh022
            
            #add-point:AFTER FIELD gldh022 name="input.a.page1.gldh022"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldh022
            #add-point:ON CHANGE gldh022 name="input.g.page1.gldh022"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldh023
            #add-point:BEFORE FIELD gldh023 name="input.b.page1.gldh023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldh023
            
            #add-point:AFTER FIELD gldh023 name="input.a.page1.gldh023"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldh023
            #add-point:ON CHANGE gldh023 name="input.g.page1.gldh023"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldh024
            #add-point:BEFORE FIELD gldh024 name="input.b.page1.gldh024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldh024
            
            #add-point:AFTER FIELD gldh024 name="input.a.page1.gldh024"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldh024
            #add-point:ON CHANGE gldh024 name="input.g.page1.gldh024"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldh027
            #add-point:BEFORE FIELD gldh027 name="input.b.page1.gldh027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldh027
            
            #add-point:AFTER FIELD gldh027 name="input.a.page1.gldh027"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldh027
            #add-point:ON CHANGE gldh027 name="input.g.page1.gldh027"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gldh030
            #add-point:BEFORE FIELD gldh030 name="input.b.page1.gldh030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gldh030
            
            #add-point:AFTER FIELD gldh030 name="input.a.page1.gldh030"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gldh030
            #add-point:ON CHANGE gldh030 name="input.g.page1.gldh030"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.gldh007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldh007
            #add-point:ON ACTION controlp INFIELD gldh007 name="input.c.page1.gldh007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldh003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldh003
            #add-point:ON ACTION controlp INFIELD gldh003 name="input.c.page1.gldh003"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_gldh_d[l_ac].gldh003
            LET g_qryparam.where = "glac001 = '",g_glaa.glaa004,"' AND  glac003 <>'1' AND glac006 = '1' "
            CALL aglt310_04()
            LET g_gldh_d[l_ac].gldh003 = g_qryparam.return1
            DISPLAY BY NAME g_gldh_d[l_ac].gldh003
            NEXT FIELD gldh003
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldh004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldh004
            #add-point:ON ACTION controlp INFIELD gldh004 name="input.c.page1.gldh004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldh025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldh025
            #add-point:ON ACTION controlp INFIELD gldh025 name="input.c.page1.gldh025"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldh026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldh026
            #add-point:ON ACTION controlp INFIELD gldh026 name="input.c.page1.gldh026"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldh028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldh028
            #add-point:ON ACTION controlp INFIELD gldh028 name="input.c.page1.gldh028"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldh029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldh029
            #add-point:ON ACTION controlp INFIELD gldh029 name="input.c.page1.gldh029"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldh031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldh031
            #add-point:ON ACTION controlp INFIELD gldh031 name="input.c.page1.gldh031"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldh032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldh032
            #add-point:ON ACTION controlp INFIELD gldh032 name="input.c.page1.gldh032"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldh008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldh008
            #add-point:ON ACTION controlp INFIELD gldh008 name="input.c.page1.gldh008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldh009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldh009
            #add-point:ON ACTION controlp INFIELD gldh009 name="input.c.page1.gldh009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldh010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldh010
            #add-point:ON ACTION controlp INFIELD gldh010 name="input.c.page1.gldh010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldh011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldh011
            #add-point:ON ACTION controlp INFIELD gldh011 name="input.c.page1.gldh011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldh012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldh012
            #add-point:ON ACTION controlp INFIELD gldh012 name="input.c.page1.gldh012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldh013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldh013
            #add-point:ON ACTION controlp INFIELD gldh013 name="input.c.page1.gldh013"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldh014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldh014
            #add-point:ON ACTION controlp INFIELD gldh014 name="input.c.page1.gldh014"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldh015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldh015
            #add-point:ON ACTION controlp INFIELD gldh015 name="input.c.page1.gldh015"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldh016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldh016
            #add-point:ON ACTION controlp INFIELD gldh016 name="input.c.page1.gldh016"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldh017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldh017
            #add-point:ON ACTION controlp INFIELD gldh017 name="input.c.page1.gldh017"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldh018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldh018
            #add-point:ON ACTION controlp INFIELD gldh018 name="input.c.page1.gldh018"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldh019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldh019
            #add-point:ON ACTION controlp INFIELD gldh019 name="input.c.page1.gldh019"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldh020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldh020
            #add-point:ON ACTION controlp INFIELD gldh020 name="input.c.page1.gldh020"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldh021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldh021
            #add-point:ON ACTION controlp INFIELD gldh021 name="input.c.page1.gldh021"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldh022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldh022
            #add-point:ON ACTION controlp INFIELD gldh022 name="input.c.page1.gldh022"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldh023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldh023
            #add-point:ON ACTION controlp INFIELD gldh023 name="input.c.page1.gldh023"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldh024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldh024
            #add-point:ON ACTION controlp INFIELD gldh024 name="input.c.page1.gldh024"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldh027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldh027
            #add-point:ON ACTION controlp INFIELD gldh027 name="input.c.page1.gldh027"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gldh030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gldh030
            #add-point:ON ACTION controlp INFIELD gldh030 name="input.c.page1.gldh030"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_gldh_d[l_ac].* = g_gldh_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aglt501_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_gldh_d[l_ac].gldh003 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_gldh_d[l_ac].* = g_gldh_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               #組合複合KEY
               CALL aglt501_get_gldh0072(l_ac)RETURNING g_gldh_d[l_ac].gldh007
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL aglt501_gldh_t_mask_restore('restore_mask_o')
      
               UPDATE gldh_t SET (gldh001,gldh002,gldh005,gldh006,gldh007,gldh003,gldh004,gldh025,gldh026, 
                   gldh028,gldh029,gldh031,gldh032,gldh008,gldh009,gldh010,gldh011,gldh012,gldh013,gldh014, 
                   gldh015,gldh016,gldh017,gldh018,gldh019,gldh020,gldh021,gldh022,gldh023,gldh024,gldh027, 
                   gldh030) = (g_glfg_m.glfg001,g_glfg_m.glfg002,g_glfg_m.glfg005,g_glfg_m.glfg006,g_gldh_d[l_ac].gldh007, 
                   g_gldh_d[l_ac].gldh003,g_gldh_d[l_ac].gldh004,g_gldh_d[l_ac].gldh025,g_gldh_d[l_ac].gldh026, 
                   g_gldh_d[l_ac].gldh028,g_gldh_d[l_ac].gldh029,g_gldh_d[l_ac].gldh031,g_gldh_d[l_ac].gldh032, 
                   g_gldh_d[l_ac].gldh008,g_gldh_d[l_ac].gldh009,g_gldh_d[l_ac].gldh010,g_gldh_d[l_ac].gldh011, 
                   g_gldh_d[l_ac].gldh012,g_gldh_d[l_ac].gldh013,g_gldh_d[l_ac].gldh014,g_gldh_d[l_ac].gldh015, 
                   g_gldh_d[l_ac].gldh016,g_gldh_d[l_ac].gldh017,g_gldh_d[l_ac].gldh018,g_gldh_d[l_ac].gldh019, 
                   g_gldh_d[l_ac].gldh020,g_gldh_d[l_ac].gldh021,g_gldh_d[l_ac].gldh022,g_gldh_d[l_ac].gldh023, 
                   g_gldh_d[l_ac].gldh024,g_gldh_d[l_ac].gldh027,g_gldh_d[l_ac].gldh030)
                WHERE gldhent = g_enterprise AND gldh001 = g_glfg_m.glfg001 
                  AND gldh002 = g_glfg_m.glfg002 
                  AND gldh005 = g_glfg_m.glfg005 
                  AND gldh006 = g_glfg_m.glfg006 
 
                  AND gldh003 = g_gldh_d_t.gldh003 #項次   
                  AND gldh007 = g_gldh_d_t.gldh007  
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_gldh_d[l_ac].* = g_gldh_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gldh_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_gldh_d[l_ac].* = g_gldh_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gldh_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_glfg_m.glfg001
               LET gs_keys_bak[1] = g_glfg001_t
               LET gs_keys[2] = g_glfg_m.glfg002
               LET gs_keys_bak[2] = g_glfg002_t
               LET gs_keys[3] = g_glfg_m.glfg005
               LET gs_keys_bak[3] = g_glfg005_t
               LET gs_keys[4] = g_glfg_m.glfg006
               LET gs_keys_bak[4] = g_glfg006_t
               LET gs_keys[5] = g_gldh_d[g_detail_idx].gldh003
               LET gs_keys_bak[5] = g_gldh_d_t.gldh003
               LET gs_keys[6] = g_gldh_d[g_detail_idx].gldh007
               LET gs_keys_bak[6] = g_gldh_d_t.gldh007
               CALL aglt501_update_b('gldh_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL aglt501_gldh_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_gldh_d[g_detail_idx].gldh003 = g_gldh_d_t.gldh003 
                  AND g_gldh_d[g_detail_idx].gldh007 = g_gldh_d_t.gldh007 
 
                  ) THEN
                  LET gs_keys[01] = g_glfg_m.glfg001
                  LET gs_keys[gs_keys.getLength()+1] = g_glfg_m.glfg002
                  LET gs_keys[gs_keys.getLength()+1] = g_glfg_m.glfg005
                  LET gs_keys[gs_keys.getLength()+1] = g_glfg_m.glfg006
 
                  LET gs_keys[gs_keys.getLength()+1] = g_gldh_d_t.gldh003
                  LET gs_keys[gs_keys.getLength()+1] = g_gldh_d_t.gldh007
 
                  CALL aglt501_key_update_b(gs_keys,'gldh_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_glfg_m),util.JSON.stringify(g_gldh_d_t)
               LET g_log2 = util.JSON.stringify(g_glfg_m),util.JSON.stringify(g_gldh_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL aglt501_unlock_b("gldh_t","'1'")
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
               LET g_gldh_d[li_reproduce_target].* = g_gldh_d[li_reproduce].*
 
               LET g_gldh_d[li_reproduce_target].gldh003 = NULL
               LET g_gldh_d[li_reproduce_target].gldh007 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_gldh_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_gldh_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
 
 
 
 
{</section>}
 
{<section id="aglt501.input.other" >}
      
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
            NEXT FIELD glfg001
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD gldh007
 
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
   CALL aglt501_otherdetail_show(l_ac)
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="aglt501.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION aglt501_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL aglt501_b_fill() #單身填充
      CALL aglt501_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL aglt501_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   #161111-00028#9---modify---begin----------
   #SELECT * INTO g_glda.* 
   SELECT gldaent,gldaownid,gldaowndp,gldacrtid,gldacrtdp,gldacrtdt,gldamodid,
          gldamoddt,gldastus,glda001,glda002,glda003,glda004 INTO g_glda.* 
   #161111-00028#9---modify---end----------
           
   FROM glda_t
    WHERE gldaent = g_enterprise
      AND glda001 = g_glfg_m.glfg001
   LET g_glfg_m.glfg001_desc = s_desc_glda001_desc(g_glfg_m.glfg001)
   CALL s_desc_get_ld_desc(g_glfg_m.glfg002) RETURNING g_glfg_m.glfg002_desc
   #end add-point
   
   #遮罩相關處理
   LET g_glfg_m_mask_o.* =  g_glfg_m.*
   CALL aglt501_glfg_t_mask()
   LET g_glfg_m_mask_n.* =  g_glfg_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_glfg_m.glfg001,g_glfg_m.glfg001_desc,g_glfg_m.glfg002,g_glfg_m.glfg002_desc,g_glfg_m.glfg005, 
       g_glfg_m.glfg006,g_glfg_m.glfg007,g_glfg_m.glfg008,g_glfg_m.glfg009,g_glfg_m.glfgstus,g_glfg_m.glfgownid, 
       g_glfg_m.glfgownid_desc,g_glfg_m.glfgowndp,g_glfg_m.glfgowndp_desc,g_glfg_m.glfgcrtid,g_glfg_m.glfgcrtid_desc, 
       g_glfg_m.glfgcrtdp,g_glfg_m.glfgcrtdp_desc,g_glfg_m.glfgcrtdt,g_glfg_m.glfgmodid,g_glfg_m.glfgmodid_desc, 
       g_glfg_m.glfgmoddt,g_glfg_m.glfgcnfid,g_glfg_m.glfgcnfid_desc,g_glfg_m.glfgcnfdt,g_glfg_m.l_gldh008, 
       g_glfg_m.l_gldh009,g_glfg_m.l_gldh010,g_glfg_m.l_gldh011,g_glfg_m.l_gldh012,g_glfg_m.l_gldh013, 
       g_glfg_m.l_gldh014,g_glfg_m.l_gldh015,g_glfg_m.l_gldh016,g_glfg_m.l_gldh017,g_glfg_m.l_gldh018, 
       g_glfg_m.l_gldh019,g_glfg_m.l_gldh020,g_glfg_m.l_gldh021
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_glfg_m.glfgstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         
      END CASE
 
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_gldh_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      
      #end add-point
   END FOR
   
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL aglt501_detail_show()
 
   #add-point:show段之後 name="show.after"
   CALL aglt501_set_visible()
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aglt501.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION aglt501_detail_show()
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
 
{<section id="aglt501.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION aglt501_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE glfg_t.glfg001 
   DEFINE l_oldno     LIKE glfg_t.glfg001 
   DEFINE l_newno02     LIKE glfg_t.glfg002 
   DEFINE l_oldno02     LIKE glfg_t.glfg002 
   DEFINE l_newno03     LIKE glfg_t.glfg005 
   DEFINE l_oldno03     LIKE glfg_t.glfg005 
   DEFINE l_newno04     LIKE glfg_t.glfg006 
   DEFINE l_oldno04     LIKE glfg_t.glfg006 
 
   DEFINE l_master    RECORD LIKE glfg_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE gldh_t.* #此變數樣板目前無使用
 
 
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
   
   IF g_glfg_m.glfg001 IS NULL
   OR g_glfg_m.glfg002 IS NULL
   OR g_glfg_m.glfg005 IS NULL
   OR g_glfg_m.glfg006 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_glfg001_t = g_glfg_m.glfg001
   LET g_glfg002_t = g_glfg_m.glfg002
   LET g_glfg005_t = g_glfg_m.glfg005
   LET g_glfg006_t = g_glfg_m.glfg006
 
    
   LET g_glfg_m.glfg001 = ""
   LET g_glfg_m.glfg002 = ""
   LET g_glfg_m.glfg005 = ""
   LET g_glfg_m.glfg006 = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_glfg_m.glfgownid = g_user
      LET g_glfg_m.glfgowndp = g_dept
      LET g_glfg_m.glfgcrtid = g_user
      LET g_glfg_m.glfgcrtdp = g_dept 
      LET g_glfg_m.glfgcrtdt = cl_get_current()
      LET g_glfg_m.glfgmodid = g_user
      LET g_glfg_m.glfgmoddt = cl_get_current()
      LET g_glfg_m.glfgstus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_glfg_m.glfgstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
      LET g_glfg_m.glfg001_desc = ''
   DISPLAY BY NAME g_glfg_m.glfg001_desc
   LET g_glfg_m.glfg002_desc = ''
   DISPLAY BY NAME g_glfg_m.glfg002_desc
 
   
   CALL aglt501_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_glfg_m.* TO NULL
      INITIALIZE g_gldh_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL aglt501_show()
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
   CALL aglt501_set_act_visible()   
   CALL aglt501_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_glfg001_t = g_glfg_m.glfg001
   LET g_glfg002_t = g_glfg_m.glfg002
   LET g_glfg005_t = g_glfg_m.glfg005
   LET g_glfg006_t = g_glfg_m.glfg006
 
   
   #組合新增資料的條件
   LET g_add_browse = " glfgent = " ||g_enterprise|| " AND",
                      " glfg001 = '", g_glfg_m.glfg001, "' "
                      ," AND glfg002 = '", g_glfg_m.glfg002, "' "
                      ," AND glfg005 = '", g_glfg_m.glfg005, "' "
                      ," AND glfg006 = '", g_glfg_m.glfg006, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aglt501_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL aglt501_idx_chk()
   
   LET g_data_owner = g_glfg_m.glfgownid      
   LET g_data_dept  = g_glfg_m.glfgowndp
   
   #功能已完成,通報訊息中心
   CALL aglt501_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="aglt501.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION aglt501_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE gldh_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE aglt501_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM gldh_t
    WHERE gldhent = g_enterprise AND gldh001 = g_glfg001_t
     AND gldh002 = g_glfg002_t
     AND gldh005 = g_glfg005_t
     AND gldh006 = g_glfg006_t
 
    INTO TEMP aglt501_detail
 
   #將key修正為調整後   
   UPDATE aglt501_detail 
      #更新key欄位
      SET gldh001 = g_glfg_m.glfg001
          , gldh002 = g_glfg_m.glfg002
          , gldh005 = g_glfg_m.glfg005
          , gldh006 = g_glfg_m.glfg006
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO gldh_t SELECT * FROM aglt501_detail
   
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
   DROP TABLE aglt501_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_glfg001_t = g_glfg_m.glfg001
   LET g_glfg002_t = g_glfg_m.glfg002
   LET g_glfg005_t = g_glfg_m.glfg005
   LET g_glfg006_t = g_glfg_m.glfg006
 
   
END FUNCTION
 
{</section>}
 
{<section id="aglt501.delete" >}
#+ 資料刪除
PRIVATE FUNCTION aglt501_delete()
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
   
   IF g_glfg_m.glfg001 IS NULL
   OR g_glfg_m.glfg002 IS NULL
   OR g_glfg_m.glfg005 IS NULL
   OR g_glfg_m.glfg006 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN aglt501_cl USING g_enterprise,g_glfg_m.glfg001,g_glfg_m.glfg002,g_glfg_m.glfg005,g_glfg_m.glfg006
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aglt501_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE aglt501_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aglt501_master_referesh USING g_glfg_m.glfg001,g_glfg_m.glfg002,g_glfg_m.glfg005,g_glfg_m.glfg006 INTO g_glfg_m.glfg001, 
       g_glfg_m.glfg002,g_glfg_m.glfg005,g_glfg_m.glfg006,g_glfg_m.glfg007,g_glfg_m.glfg008,g_glfg_m.glfg009, 
       g_glfg_m.glfgstus,g_glfg_m.glfgownid,g_glfg_m.glfgowndp,g_glfg_m.glfgcrtid,g_glfg_m.glfgcrtdp, 
       g_glfg_m.glfgcrtdt,g_glfg_m.glfgmodid,g_glfg_m.glfgmoddt,g_glfg_m.glfgcnfid,g_glfg_m.glfgcnfdt, 
       g_glfg_m.glfgownid_desc,g_glfg_m.glfgowndp_desc,g_glfg_m.glfgcrtid_desc,g_glfg_m.glfgcrtdp_desc, 
       g_glfg_m.glfgmodid_desc,g_glfg_m.glfgcnfid_desc
   
   
   #檢查是否允許此動作
   IF NOT aglt501_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_glfg_m_mask_o.* =  g_glfg_m.*
   CALL aglt501_glfg_t_mask()
   LET g_glfg_m_mask_n.* =  g_glfg_m.*
   
   CALL aglt501_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aglt501_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_glfg001_t = g_glfg_m.glfg001
      LET g_glfg002_t = g_glfg_m.glfg002
      LET g_glfg005_t = g_glfg_m.glfg005
      LET g_glfg006_t = g_glfg_m.glfg006
 
 
      DELETE FROM glfg_t
       WHERE glfgent = g_enterprise AND glfg001 = g_glfg_m.glfg001
         AND glfg002 = g_glfg_m.glfg002
         AND glfg005 = g_glfg_m.glfg005
         AND glfg006 = g_glfg_m.glfg006
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_glfg_m.glfg001,":",SQLERRMESSAGE  
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
      
      DELETE FROM gldh_t
       WHERE gldhent = g_enterprise AND gldh001 = g_glfg_m.glfg001
         AND gldh002 = g_glfg_m.glfg002
         AND gldh005 = g_glfg_m.glfg005
         AND gldh006 = g_glfg_m.glfg006
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "gldh_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      
      #end add-point
      
            
                                                               
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_glfg_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE aglt501_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_gldh_d.clear() 
 
     
      CALL aglt501_ui_browser_refresh()  
      #CALL aglt501_ui_headershow()  
      #CALL aglt501_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL aglt501_browser_fill("")
         CALL aglt501_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE aglt501_cl
 
   #功能已完成,通報訊息中心
   CALL aglt501_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="aglt501.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aglt501_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_gldh_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF aglt501_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT gldh007,gldh003,gldh004,gldh025,gldh026,gldh028,gldh029,gldh031, 
             gldh032,gldh008,gldh009,gldh010,gldh011,gldh012,gldh013,gldh014,gldh015,gldh016,gldh017, 
             gldh018,gldh019,gldh020,gldh021,gldh022,gldh023,gldh024,gldh027,gldh030  FROM gldh_t",  
               
                     " INNER JOIN glfg_t ON glfgent = " ||g_enterprise|| " AND glfg001 = gldh001 ",
                     " AND glfg002 = gldh002 ",
                     " AND glfg005 = gldh005 ",
                     " AND glfg006 = gldh006 ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                     
                     " WHERE gldhent=? AND gldh001=? AND gldh002=? AND gldh005=? AND gldh006=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY gldh_t.gldh003,gldh_t.gldh007"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aglt501_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR aglt501_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_glfg_m.glfg001,g_glfg_m.glfg002,g_glfg_m.glfg005,g_glfg_m.glfg006   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_glfg_m.glfg001,g_glfg_m.glfg002,g_glfg_m.glfg005,g_glfg_m.glfg006 INTO g_gldh_d[l_ac].gldh007, 
          g_gldh_d[l_ac].gldh003,g_gldh_d[l_ac].gldh004,g_gldh_d[l_ac].gldh025,g_gldh_d[l_ac].gldh026, 
          g_gldh_d[l_ac].gldh028,g_gldh_d[l_ac].gldh029,g_gldh_d[l_ac].gldh031,g_gldh_d[l_ac].gldh032, 
          g_gldh_d[l_ac].gldh008,g_gldh_d[l_ac].gldh009,g_gldh_d[l_ac].gldh010,g_gldh_d[l_ac].gldh011, 
          g_gldh_d[l_ac].gldh012,g_gldh_d[l_ac].gldh013,g_gldh_d[l_ac].gldh014,g_gldh_d[l_ac].gldh015, 
          g_gldh_d[l_ac].gldh016,g_gldh_d[l_ac].gldh017,g_gldh_d[l_ac].gldh018,g_gldh_d[l_ac].gldh019, 
          g_gldh_d[l_ac].gldh020,g_gldh_d[l_ac].gldh021,g_gldh_d[l_ac].gldh022,g_gldh_d[l_ac].gldh023, 
          g_gldh_d[l_ac].gldh024,g_gldh_d[l_ac].gldh027,g_gldh_d[l_ac].gldh030   #(ver:78)
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
   CALL aglt501_otherdetail_show(1)
   #end add-point
   
   CALL g_gldh_d.deleteElement(g_gldh_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE aglt501_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_gldh_d.getLength()
      LET g_gldh_d_mask_o[l_ac].* =  g_gldh_d[l_ac].*
      CALL aglt501_gldh_t_mask()
      LET g_gldh_d_mask_n[l_ac].* =  g_gldh_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="aglt501.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION aglt501_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM gldh_t
       WHERE gldhent = g_enterprise AND
         gldh001 = ps_keys_bak[1] AND gldh002 = ps_keys_bak[2] AND gldh005 = ps_keys_bak[3] AND gldh006 = ps_keys_bak[4] AND gldh003 = ps_keys_bak[5] AND gldh007 = ps_keys_bak[6]
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
         CALL g_gldh_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aglt501.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION aglt501_insert_b(ps_table,ps_keys,ps_page)
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
      IF cl_null(g_gldh_d[g_detail_idx].gldh008)THEN LET g_gldh_d[g_detail_idx].gldh008 = ' ' END IF
      IF cl_null(g_gldh_d[g_detail_idx].gldh009)THEN LET g_gldh_d[g_detail_idx].gldh009 = ' ' END IF
      IF cl_null(g_gldh_d[g_detail_idx].gldh010)THEN LET g_gldh_d[g_detail_idx].gldh010 = ' ' END IF
      
      IF cl_null(g_gldh_d[g_detail_idx].gldh011)THEN LET g_gldh_d[g_detail_idx].gldh011 = ' ' END IF
      IF cl_null(g_gldh_d[g_detail_idx].gldh012)THEN LET g_gldh_d[g_detail_idx].gldh012 = ' ' END IF
      IF cl_null(g_gldh_d[g_detail_idx].gldh013)THEN LET g_gldh_d[g_detail_idx].gldh013 = ' ' END IF
      IF cl_null(g_gldh_d[g_detail_idx].gldh014)THEN LET g_gldh_d[g_detail_idx].gldh014 = ' ' END IF
      IF cl_null(g_gldh_d[g_detail_idx].gldh015)THEN LET g_gldh_d[g_detail_idx].gldh015 = ' ' END IF
      IF cl_null(g_gldh_d[g_detail_idx].gldh016)THEN LET g_gldh_d[g_detail_idx].gldh016 = ' ' END IF
      IF cl_null(g_gldh_d[g_detail_idx].gldh017)THEN LET g_gldh_d[g_detail_idx].gldh017 = ' ' END IF
      IF cl_null(g_gldh_d[g_detail_idx].gldh018)THEN LET g_gldh_d[g_detail_idx].gldh018 = ' ' END IF
      IF cl_null(g_gldh_d[g_detail_idx].gldh019)THEN LET g_gldh_d[g_detail_idx].gldh019 = ' ' END IF
      IF cl_null(g_gldh_d[g_detail_idx].gldh020)THEN LET g_gldh_d[g_detail_idx].gldh020 = ' ' END IF

      IF cl_null(g_gldh_d[g_detail_idx].gldh021)THEN LET g_gldh_d[g_detail_idx].gldh021 = ' ' END IF
      #end add-point 
      INSERT INTO gldh_t
                  (gldhent,
                   gldh001,gldh002,gldh005,gldh006,
                   gldh003,gldh007
                   ,gldh004,gldh025,gldh026,gldh028,gldh029,gldh031,gldh032,gldh008,gldh009,gldh010,gldh011,gldh012,gldh013,gldh014,gldh015,gldh016,gldh017,gldh018,gldh019,gldh020,gldh021,gldh022,gldh023,gldh024,gldh027,gldh030) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4],ps_keys[5],ps_keys[6]
                   ,g_gldh_d[g_detail_idx].gldh004,g_gldh_d[g_detail_idx].gldh025,g_gldh_d[g_detail_idx].gldh026, 
                       g_gldh_d[g_detail_idx].gldh028,g_gldh_d[g_detail_idx].gldh029,g_gldh_d[g_detail_idx].gldh031, 
                       g_gldh_d[g_detail_idx].gldh032,g_gldh_d[g_detail_idx].gldh008,g_gldh_d[g_detail_idx].gldh009, 
                       g_gldh_d[g_detail_idx].gldh010,g_gldh_d[g_detail_idx].gldh011,g_gldh_d[g_detail_idx].gldh012, 
                       g_gldh_d[g_detail_idx].gldh013,g_gldh_d[g_detail_idx].gldh014,g_gldh_d[g_detail_idx].gldh015, 
                       g_gldh_d[g_detail_idx].gldh016,g_gldh_d[g_detail_idx].gldh017,g_gldh_d[g_detail_idx].gldh018, 
                       g_gldh_d[g_detail_idx].gldh019,g_gldh_d[g_detail_idx].gldh020,g_gldh_d[g_detail_idx].gldh021, 
                       g_gldh_d[g_detail_idx].gldh022,g_gldh_d[g_detail_idx].gldh023,g_gldh_d[g_detail_idx].gldh024, 
                       g_gldh_d[g_detail_idx].gldh027,g_gldh_d[g_detail_idx].gldh030)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "gldh_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_gldh_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="aglt501.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION aglt501_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "gldh_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      IF cl_null(g_gldh_d[g_detail_idx].gldh008)THEN LET g_gldh_d[g_detail_idx].gldh008 = ' ' END IF
      IF cl_null(g_gldh_d[g_detail_idx].gldh009)THEN LET g_gldh_d[g_detail_idx].gldh009 = ' ' END IF
      IF cl_null(g_gldh_d[g_detail_idx].gldh010)THEN LET g_gldh_d[g_detail_idx].gldh010 = ' ' END IF
      
      IF cl_null(g_gldh_d[g_detail_idx].gldh011)THEN LET g_gldh_d[g_detail_idx].gldh011 = ' ' END IF
      IF cl_null(g_gldh_d[g_detail_idx].gldh012)THEN LET g_gldh_d[g_detail_idx].gldh012 = ' ' END IF
      IF cl_null(g_gldh_d[g_detail_idx].gldh013)THEN LET g_gldh_d[g_detail_idx].gldh013 = ' ' END IF
      IF cl_null(g_gldh_d[g_detail_idx].gldh014)THEN LET g_gldh_d[g_detail_idx].gldh014 = ' ' END IF
      IF cl_null(g_gldh_d[g_detail_idx].gldh015)THEN LET g_gldh_d[g_detail_idx].gldh015 = ' ' END IF
      IF cl_null(g_gldh_d[g_detail_idx].gldh016)THEN LET g_gldh_d[g_detail_idx].gldh016 = ' ' END IF
      IF cl_null(g_gldh_d[g_detail_idx].gldh017)THEN LET g_gldh_d[g_detail_idx].gldh017 = ' ' END IF
      IF cl_null(g_gldh_d[g_detail_idx].gldh018)THEN LET g_gldh_d[g_detail_idx].gldh018 = ' ' END IF
      IF cl_null(g_gldh_d[g_detail_idx].gldh019)THEN LET g_gldh_d[g_detail_idx].gldh019 = ' ' END IF
      IF cl_null(g_gldh_d[g_detail_idx].gldh020)THEN LET g_gldh_d[g_detail_idx].gldh020 = ' ' END IF

      IF cl_null(g_gldh_d[g_detail_idx].gldh021)THEN LET g_gldh_d[g_detail_idx].gldh021 = ' ' END IF
      #end add-point 
      
      #將遮罩欄位還原
      CALL aglt501_gldh_t_mask_restore('restore_mask_o')
               
      UPDATE gldh_t 
         SET (gldh001,gldh002,gldh005,gldh006,
              gldh003,gldh007
              ,gldh004,gldh025,gldh026,gldh028,gldh029,gldh031,gldh032,gldh008,gldh009,gldh010,gldh011,gldh012,gldh013,gldh014,gldh015,gldh016,gldh017,gldh018,gldh019,gldh020,gldh021,gldh022,gldh023,gldh024,gldh027,gldh030) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4],ps_keys[5],ps_keys[6]
              ,g_gldh_d[g_detail_idx].gldh004,g_gldh_d[g_detail_idx].gldh025,g_gldh_d[g_detail_idx].gldh026, 
                  g_gldh_d[g_detail_idx].gldh028,g_gldh_d[g_detail_idx].gldh029,g_gldh_d[g_detail_idx].gldh031, 
                  g_gldh_d[g_detail_idx].gldh032,g_gldh_d[g_detail_idx].gldh008,g_gldh_d[g_detail_idx].gldh009, 
                  g_gldh_d[g_detail_idx].gldh010,g_gldh_d[g_detail_idx].gldh011,g_gldh_d[g_detail_idx].gldh012, 
                  g_gldh_d[g_detail_idx].gldh013,g_gldh_d[g_detail_idx].gldh014,g_gldh_d[g_detail_idx].gldh015, 
                  g_gldh_d[g_detail_idx].gldh016,g_gldh_d[g_detail_idx].gldh017,g_gldh_d[g_detail_idx].gldh018, 
                  g_gldh_d[g_detail_idx].gldh019,g_gldh_d[g_detail_idx].gldh020,g_gldh_d[g_detail_idx].gldh021, 
                  g_gldh_d[g_detail_idx].gldh022,g_gldh_d[g_detail_idx].gldh023,g_gldh_d[g_detail_idx].gldh024, 
                  g_gldh_d[g_detail_idx].gldh027,g_gldh_d[g_detail_idx].gldh030) 
         WHERE gldhent = g_enterprise AND gldh001 = ps_keys_bak[1] AND gldh002 = ps_keys_bak[2] AND gldh005 = ps_keys_bak[3] AND gldh006 = ps_keys_bak[4] AND gldh003 = ps_keys_bak[5] AND gldh007 = ps_keys_bak[6]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "gldh_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "gldh_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aglt501_gldh_t_mask_restore('restore_mask_n')
               
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
 
{<section id="aglt501.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION aglt501_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="aglt501.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION aglt501_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="aglt501.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION aglt501_lock_b(ps_table,ps_page)
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
   #CALL aglt501_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "gldh_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN aglt501_bcl USING g_enterprise,
                                       g_glfg_m.glfg001,g_glfg_m.glfg002,g_glfg_m.glfg005,g_glfg_m.glfg006, 
                                           g_gldh_d[g_detail_idx].gldh003,g_gldh_d[g_detail_idx].gldh007  
                                               
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aglt501_bcl:",SQLERRMESSAGE 
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
 
{<section id="aglt501.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION aglt501_unlock_b(ps_table,ps_page)
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
      CLOSE aglt501_bcl
   END IF
   
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="aglt501.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION aglt501_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("glfg001,glfg002,glfg005,glfg006",TRUE)
      CALL cl_set_comp_entry("",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aglt501.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION aglt501_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("glfg001,glfg002,glfg005,glfg006",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aglt501.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION aglt501_set_entry_b(p_cmd)
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
 
{<section id="aglt501.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION aglt501_set_no_entry_b(p_cmd)
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
   
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="aglt501.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION aglt501_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aglt501.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION aglt501_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:1)
   IF g_glfg_m.glfgstus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF


   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aglt501.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION aglt501_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aglt501.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION aglt501_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aglt501.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aglt501_default_search()
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
      LET ls_wc = ls_wc, " glfg001 = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " glfg002 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " glfg005 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET ls_wc = ls_wc, " glfg006 = '", g_argv[04], "' AND "
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
               WHEN la_wc[li_idx].tableid = "glfg_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "gldh_t" 
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
 
{<section id="aglt501.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION aglt501_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_glfg_m.glfg001 IS NULL
      OR g_glfg_m.glfg002 IS NULL      OR g_glfg_m.glfg005 IS NULL      OR g_glfg_m.glfg006 IS NULL
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN aglt501_cl USING g_enterprise,g_glfg_m.glfg001,g_glfg_m.glfg002,g_glfg_m.glfg005,g_glfg_m.glfg006
   IF STATUS THEN
      CLOSE aglt501_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aglt501_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE aglt501_master_referesh USING g_glfg_m.glfg001,g_glfg_m.glfg002,g_glfg_m.glfg005,g_glfg_m.glfg006 INTO g_glfg_m.glfg001, 
       g_glfg_m.glfg002,g_glfg_m.glfg005,g_glfg_m.glfg006,g_glfg_m.glfg007,g_glfg_m.glfg008,g_glfg_m.glfg009, 
       g_glfg_m.glfgstus,g_glfg_m.glfgownid,g_glfg_m.glfgowndp,g_glfg_m.glfgcrtid,g_glfg_m.glfgcrtdp, 
       g_glfg_m.glfgcrtdt,g_glfg_m.glfgmodid,g_glfg_m.glfgmoddt,g_glfg_m.glfgcnfid,g_glfg_m.glfgcnfdt, 
       g_glfg_m.glfgownid_desc,g_glfg_m.glfgowndp_desc,g_glfg_m.glfgcrtid_desc,g_glfg_m.glfgcrtdp_desc, 
       g_glfg_m.glfgmodid_desc,g_glfg_m.glfgcnfid_desc
   
 
   #檢查是否允許此動作
   IF NOT aglt501_action_chk() THEN
      CLOSE aglt501_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_glfg_m.glfg001,g_glfg_m.glfg001_desc,g_glfg_m.glfg002,g_glfg_m.glfg002_desc,g_glfg_m.glfg005, 
       g_glfg_m.glfg006,g_glfg_m.glfg007,g_glfg_m.glfg008,g_glfg_m.glfg009,g_glfg_m.glfgstus,g_glfg_m.glfgownid, 
       g_glfg_m.glfgownid_desc,g_glfg_m.glfgowndp,g_glfg_m.glfgowndp_desc,g_glfg_m.glfgcrtid,g_glfg_m.glfgcrtid_desc, 
       g_glfg_m.glfgcrtdp,g_glfg_m.glfgcrtdp_desc,g_glfg_m.glfgcrtdt,g_glfg_m.glfgmodid,g_glfg_m.glfgmodid_desc, 
       g_glfg_m.glfgmoddt,g_glfg_m.glfgcnfid,g_glfg_m.glfgcnfid_desc,g_glfg_m.glfgcnfdt,g_glfg_m.l_gldh008, 
       g_glfg_m.l_gldh009,g_glfg_m.l_gldh010,g_glfg_m.l_gldh011,g_glfg_m.l_gldh012,g_glfg_m.l_gldh013, 
       g_glfg_m.l_gldh014,g_glfg_m.l_gldh015,g_glfg_m.l_gldh016,g_glfg_m.l_gldh017,g_glfg_m.l_gldh018, 
       g_glfg_m.l_gldh019,g_glfg_m.l_gldh020,g_glfg_m.l_gldh021
 
   CASE g_glfg_m.glfgstus
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
      
   END CASE
 
   #add-point:資料刷新後 name="statechange.after_refresh"
   
   #end add-point
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_glfg_m.glfgstus
            
            WHEN "N"
               HIDE OPTION "unconfirmed"
            WHEN "Y"
               HIDE OPTION "confirmed"
         END CASE
     
      #add-point:menu前 name="statechange.before_menu"
      CALL cl_set_act_visible("signing,withdraw",FALSE)
      CALL cl_set_act_visible("unconfirmed,invalid,confirmed",TRUE)
      CALL cl_set_act_visible("closed",FALSE)

      CASE g_glfg_m.glfgstus
         WHEN "N"  
            CALL cl_set_act_visible("unconfirmed,hold",FALSE)
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            IF cl_bpm_chk() THEN
                CALL cl_set_act_visible("signing",TRUE)
                CALL cl_set_act_visible("confirmed",FALSE)
            END IF
 
         WHEN "R"   #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed,hold",FALSE)

         WHEN "D"   #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed,hold",FALSE) 
          
         WHEN "X"
            CALL cl_set_act_visible("unconfirmed,invalid,confirmed,hold",FALSE)

         WHEN "Y"
            CALL cl_set_act_visible("invalid,confirmed,hold",FALSE)
         
         WHEN "W"    #只能顯示抽單;其餘應用功能皆隱藏
             CALL cl_set_act_visible("withdraw",TRUE)  
             CALL cl_set_act_visible("unconfirmed,invalid,confirmed,hold",FALSE)
         
         WHEN "A"     #只能顯示確認; 其餘應用功能皆隱藏
             CALL cl_set_act_visible("confirmed ",TRUE)  
             CALL cl_set_act_visible("unconfirmed,invalid,hold",FALSE)

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
 
      #add-point:stus控制 name="statechange.more_control"
      
      #end add-point
      
   END MENU
   
   #確認被選取的狀態碼在清單中
   IF (lc_state <> "N" 
      AND lc_state <> "Y"
      ) OR 
      g_glfg_m.glfgstus = lc_state OR cl_null(lc_state) THEN
      CLOSE aglt501_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   IF lc_state = 'Y' THEN
      CALL s_aglt501_prepare_declare()
      CALL cl_err_collect_init()
      #核算項檢核
      CALL s_aglt501_conf_chk(g_glfg_m.glfg001,g_glfg_m.glfg002,g_glfg_m.glfg005,g_glfg_m.glfg006)
         RETURNING g_sub_success
      IF NOT g_sub_success THEN
         CALL cl_err_collect_show()
         CALL s_transaction_end('N','0')   #160816-00068#6 add
         RETURN
      ELSE  
         IF NOT cl_ask_confirm('aim-00108') THEN
            CALL cl_err_collect_show()
            CALL s_transaction_end('N','0')   #160816-00068#6 add
            RETURN
         ELSE      
            CALL s_aglt501_conf_upd(g_glfg_m.glfg001,g_glfg_m.glfg002,g_glfg_m.glfg005,g_glfg_m.glfg006)
               RETURNING g_sub_success
            IF NOT g_sub_success THEN
               CALL cl_err_collect_show()
               CALL s_transaction_end('N','0')   #160816-00068#6 add
               RETURN
            END IF
            CALL cl_err_collect_show()
         END IF
      END IF
   END IF
   
   IF lc_state = 'N' THEN
      CALL cl_err_collect_init()
      CALL s_aglt501_unconf_chk(g_glfg_m.glfg001,g_glfg_m.glfg002,g_glfg_m.glfg005,g_glfg_m.glfg006)
         RETURNING g_sub_success
      IF NOT g_sub_success THEN  
         CALL cl_err_collect_show()
         CALL s_transaction_end('N','0')   #160816-00068#6 add
         RETURN
      ELSE
         IF NOT cl_ask_confirm('aim-00110') THEN
            CALL cl_err_collect_show()
            CALL s_transaction_end('N','0')   #160816-00068#6 add
            RETURN
         ELSE
            CALL s_aglt501_unconf_upd(g_glfg_m.glfg001,g_glfg_m.glfg002,g_glfg_m.glfg005,g_glfg_m.glfg006)
               RETURNING g_sub_success
            IF NOT g_sub_success THEN
               CALL cl_err_collect_show()
               CALL s_transaction_end('N','0')   #160816-00068#6 add
               RETURN
            END IF
            CALL cl_err_collect_show()
         END IF
      END IF
   END IF
   #end add-point
   
   LET g_glfg_m.glfgmodid = g_user
   LET g_glfg_m.glfgmoddt = cl_get_current()
   LET g_glfg_m.glfgstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE glfg_t 
      SET (glfgstus,glfgmodid,glfgmoddt) 
        = (g_glfg_m.glfgstus,g_glfg_m.glfgmodid,g_glfg_m.glfgmoddt)     
    WHERE glfgent = g_enterprise AND glfg001 = g_glfg_m.glfg001
      AND glfg002 = g_glfg_m.glfg002      AND glfg005 = g_glfg_m.glfg005      AND glfg006 = g_glfg_m.glfg006
    
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
         
      END CASE
    
      #撈取異動後的資料
      EXECUTE aglt501_master_referesh USING g_glfg_m.glfg001,g_glfg_m.glfg002,g_glfg_m.glfg005,g_glfg_m.glfg006 INTO g_glfg_m.glfg001, 
          g_glfg_m.glfg002,g_glfg_m.glfg005,g_glfg_m.glfg006,g_glfg_m.glfg007,g_glfg_m.glfg008,g_glfg_m.glfg009, 
          g_glfg_m.glfgstus,g_glfg_m.glfgownid,g_glfg_m.glfgowndp,g_glfg_m.glfgcrtid,g_glfg_m.glfgcrtdp, 
          g_glfg_m.glfgcrtdt,g_glfg_m.glfgmodid,g_glfg_m.glfgmoddt,g_glfg_m.glfgcnfid,g_glfg_m.glfgcnfdt, 
          g_glfg_m.glfgownid_desc,g_glfg_m.glfgowndp_desc,g_glfg_m.glfgcrtid_desc,g_glfg_m.glfgcrtdp_desc, 
          g_glfg_m.glfgmodid_desc,g_glfg_m.glfgcnfid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_glfg_m.glfg001,g_glfg_m.glfg001_desc,g_glfg_m.glfg002,g_glfg_m.glfg002_desc, 
          g_glfg_m.glfg005,g_glfg_m.glfg006,g_glfg_m.glfg007,g_glfg_m.glfg008,g_glfg_m.glfg009,g_glfg_m.glfgstus, 
          g_glfg_m.glfgownid,g_glfg_m.glfgownid_desc,g_glfg_m.glfgowndp,g_glfg_m.glfgowndp_desc,g_glfg_m.glfgcrtid, 
          g_glfg_m.glfgcrtid_desc,g_glfg_m.glfgcrtdp,g_glfg_m.glfgcrtdp_desc,g_glfg_m.glfgcrtdt,g_glfg_m.glfgmodid, 
          g_glfg_m.glfgmodid_desc,g_glfg_m.glfgmoddt,g_glfg_m.glfgcnfid,g_glfg_m.glfgcnfid_desc,g_glfg_m.glfgcnfdt, 
          g_glfg_m.l_gldh008,g_glfg_m.l_gldh009,g_glfg_m.l_gldh010,g_glfg_m.l_gldh011,g_glfg_m.l_gldh012, 
          g_glfg_m.l_gldh013,g_glfg_m.l_gldh014,g_glfg_m.l_gldh015,g_glfg_m.l_gldh016,g_glfg_m.l_gldh017, 
          g_glfg_m.l_gldh018,g_glfg_m.l_gldh019,g_glfg_m.l_gldh020,g_glfg_m.l_gldh021
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE aglt501_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aglt501_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aglt501.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION aglt501_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_gldh_d.getLength() THEN
         LET g_detail_idx = g_gldh_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_gldh_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_gldh_d.getLength() TO FORMONLY.cnt
   END IF
   
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aglt501.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aglt501_b_fill2(pi_idx)
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
   
   CALL aglt501_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="aglt501.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION aglt501_fill_chk(ps_idx)
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
 
{<section id="aglt501.status_show" >}
PRIVATE FUNCTION aglt501_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aglt501.mask_functions" >}
&include "erp/agl/aglt501_mask.4gl"
 
{</section>}
 
{<section id="aglt501.signature" >}
   
 
{</section>}
 
{<section id="aglt501.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION aglt501_set_pk_array()
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
   LET g_pk_array[1].values = g_glfg_m.glfg001
   LET g_pk_array[1].column = 'glfg001'
   LET g_pk_array[2].values = g_glfg_m.glfg002
   LET g_pk_array[2].column = 'glfg002'
   LET g_pk_array[3].values = g_glfg_m.glfg005
   LET g_pk_array[3].column = 'glfg005'
   LET g_pk_array[4].values = g_glfg_m.glfg006
   LET g_pk_array[4].column = 'glfg006'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aglt501.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="aglt501.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION aglt501_msgcentre_notify(lc_state)
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
   CALL aglt501_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_glfg_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aglt501.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION aglt501_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#15   2016/08/24  By 07900 --add--s--
   SELECT glfgstus INTO g_glfg_m.glfgstus
     FROM glfg_t
    WHERE glfgent = g_enterprise
      AND glfg001 = g_glfg_m.glfg001
      AND glfg002 = g_glfg_m.glfg002
      AND glfg005 = g_glfg_m.glfg005
      AND glfg006 = g_glfg_m.glfg006

   IF (g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail")  THEN
     LET g_errno = NULL
     CASE g_glfg_m.glfgstus
       
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
        LET g_errparam.extend = g_glfg_m.glfg001
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL aglt501_set_act_visible()
        CALL aglt501_set_act_no_visible()
        CALL aglt501_show()
        RETURN FALSE
     END IF
   END IF
   
   #160818-00017#15   2016/08/24  By 07900 --add--e--
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aglt501.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 取得key值
# Memo...........:
# Date & Author..: 150304 By albireo
# Modify.........:
################################################################################
PRIVATE FUNCTION aglt501_get_gldh007(p_gldh_ar)
   DEFINE p_gldh_ar DYNAMIC ARRAY OF RECORD
          chr       LIKE type_t.chr1000,
          dat       LIKE type_t.dat
          END RECORD
   DEFINE l_gldh007 LIKE gldh_t.gldh007
   #161111-00028#9---modify---begin----------
   #DEFINE l_gldh    RECORD LIKE gldh_t.*
   DEFINE l_gldh RECORD  #非T100公司科目餘額暫存資料
       gldhent LIKE gldh_t.gldhent, #企業編號
       gldh001 LIKE gldh_t.gldh001, #公司編號
       gldh002 LIKE gldh_t.gldh002, #帳套
       gldh003 LIKE gldh_t.gldh003, #科目編號
       gldh004 LIKE gldh_t.gldh004, #科目名稱
       gldh005 LIKE gldh_t.gldh005, #年度
       gldh006 LIKE gldh_t.gldh006, #期別
       gldh007 LIKE gldh_t.gldh007, #組合要素(key)
       gldh008 LIKE gldh_t.gldh008, #營運據點
       gldh009 LIKE gldh_t.gldh009, #部門
       gldh010 LIKE gldh_t.gldh010, #利潤/成本中心
       gldh011 LIKE gldh_t.gldh011, #區域
       gldh012 LIKE gldh_t.gldh012, #收付款客商
       gldh013 LIKE gldh_t.gldh013, #帳款客商
       gldh014 LIKE gldh_t.gldh014, #客群
       gldh015 LIKE gldh_t.gldh015, #產品類別
       gldh016 LIKE gldh_t.gldh016, #經營方式
       gldh017 LIKE gldh_t.gldh017, #渠道
       gldh018 LIKE gldh_t.gldh018, #品牌
       gldh019 LIKE gldh_t.gldh019, #人員
       gldh020 LIKE gldh_t.gldh020, #專案編號
       gldh021 LIKE gldh_t.gldh021, #WBS
       gldh022 LIKE gldh_t.gldh022, #借方筆數
       gldh023 LIKE gldh_t.gldh023, #貸方筆數
       gldh024 LIKE gldh_t.gldh024, #幣別(記帳幣)
       gldh025 LIKE gldh_t.gldh025, #借方金額(記帳幣)
       gldh026 LIKE gldh_t.gldh026, #貸方金額(記帳幣)
       gldh027 LIKE gldh_t.gldh027, #幣別(功能幣)
       gldh028 LIKE gldh_t.gldh028, #借方金額(功能幣)
       gldh029 LIKE gldh_t.gldh029, #貸方金額(功能幣)
       gldh030 LIKE gldh_t.gldh030, #幣別(報告幣)
       gldh031 LIKE gldh_t.gldh031, #借方金額(報告幣)
       gldh032 LIKE gldh_t.gldh032  #貸方金額(報告幣)
       END RECORD

   #161111-00028#9---modify---end----------
   #-----array值說明-----s
   # [1].chr = gldh008
   # [2].chr = gldh009
   # [3].chr = gldh010
   # [4].chr = gldh011
   # [5].chr = gldh012
   # [6].chr = gldh013
   # [7].chr = gldh014
   # [8].chr = gldh015
   # [9].chr = gldh016
   # [10].chr = gldh017
   # [11].chr = gldh018
   # [12].chr = gldh019
   # [13].chr = gldh020
   # [14].chr = gldh021
   #---------------------e
   INITIALIZE l_gldh.* TO NULL
   LET l_gldh007 = NULL
   
   LET l_gldh.gldh008 = p_gldh_ar[1].chr 
   LET l_gldh.gldh009 = p_gldh_ar[2].chr 
   LET l_gldh.gldh010 = p_gldh_ar[3].chr 
   LET l_gldh.gldh011 = p_gldh_ar[4].chr 
   LET l_gldh.gldh012 = p_gldh_ar[5].chr 
   LET l_gldh.gldh013 = p_gldh_ar[6].chr 
   LET l_gldh.gldh014 = p_gldh_ar[7].chr 
   LET l_gldh.gldh015 = p_gldh_ar[8].chr 
   LET l_gldh.gldh016 = p_gldh_ar[9].chr 
   LET l_gldh.gldh017 = p_gldh_ar[10].chr
   LET l_gldh.gldh018 = p_gldh_ar[11].chr
   LET l_gldh.gldh019 = p_gldh_ar[12].chr
   LET l_gldh.gldh020 = p_gldh_ar[13].chr
   LET l_gldh.gldh021 = p_gldh_ar[14].chr
   
   LET l_gldh007 = "gldh008 ='", l_gldh.gldh008,"',",                
                   "gldh009 ='", l_gldh.gldh009,"',",
                   "gldh010 ='", l_gldh.gldh010,"',",
                   "gldh011 ='", l_gldh.gldh011,"',",
                   "gldh012 ='", l_gldh.gldh012,"',",
                   "gldh013 ='", l_gldh.gldh013,"',",
                   "gldh014 ='", l_gldh.gldh014,"',",
                   "gldh015 ='", l_gldh.gldh015,"',",
                   "gldh016 ='", l_gldh.gldh016,"',",
                   "gldh017 ='", l_gldh.gldh017,"',",
                   "gldh018 ='", l_gldh.gldh018,"',",
                   "gldh019 ='", l_gldh.gldh019,"',",
                   "gldh020 ='", l_gldh.gldh020,"',",
                   "gldh021 ='", l_gldh.gldh021,"'"
   RETURN l_gldh007
END FUNCTION

################################################################################
# Descriptions...: 單身取得key值
# Date & Author..: 150304 By albireo
# Modify.........:
################################################################################
PRIVATE FUNCTION aglt501_get_gldh0072(p_ac)
   DEFINE p_ac   LIKE type_t.num10
   DEFINE l_gldh007   LIKE gldh_t.gldh007
   
   CALL g_gldh_ar.clear()
   LET g_gldh_ar[1].chr  = g_gldh_d[p_ac].gldh008
   LET g_gldh_ar[2].chr  = g_gldh_d[p_ac].gldh009
   LET g_gldh_ar[3].chr  = g_gldh_d[p_ac].gldh010
   LET g_gldh_ar[4].chr  = g_gldh_d[p_ac].gldh011
   LET g_gldh_ar[5].chr  = g_gldh_d[p_ac].gldh012
   LET g_gldh_ar[6].chr  = g_gldh_d[p_ac].gldh013
   LET g_gldh_ar[7].chr  = g_gldh_d[p_ac].gldh014
   LET g_gldh_ar[8].chr  = g_gldh_d[p_ac].gldh015
   LET g_gldh_ar[9].chr  = g_gldh_d[p_ac].gldh016
   LET g_gldh_ar[10].chr = g_gldh_d[p_ac].gldh017
   LET g_gldh_ar[11].chr = g_gldh_d[p_ac].gldh018
   LET g_gldh_ar[12].chr = g_gldh_d[p_ac].gldh019
   LET g_gldh_ar[13].chr = g_gldh_d[p_ac].gldh020
   LET g_gldh_ar[14].chr = g_gldh_d[p_ac].gldh021
   CALL aglt501_get_gldh007(g_gldh_ar)RETURNING l_gldh007
   
   RETURN l_gldh007
   
END FUNCTION

PRIVATE FUNCTION aglt501_set_visible()
   CALL s_ld_sel_glaa(g_glfg_m.glfg002,'ALL') RETURNING g_glaa.*
   CALL cl_set_comp_visible("glfg008,glfg009,gldh028,gldh029,gldh031,gldh032",FALSE)
   CALL cl_set_comp_visible("lbl_glfg008,lbl_glfg009",FALSE)
   IF g_glaa.glaa015 = 'Y' THEN
      CALL cl_set_comp_visible("glfg008,gldh028,gldh029",TRUE)
      CALL cl_set_comp_visible("lbl_glfg008",TRUE)
   END IF
   IF g_glaa.glaa019 = 'Y' THEN
      CALL cl_set_comp_visible("glfg009,gldh031,gldh032",TRUE)
      CALL cl_set_comp_visible("lbl_glfg009",TRUE)
   END IF
END FUNCTION

################################################################################
# Descriptions...: 固定核算項凍結窗格顯示
# Memo...........:
# Date & Author..: 150304 By albireo
# Modify.........:
################################################################################
PRIVATE FUNCTION aglt501_otherdetail_show(p_ac)
   DEFINE p_ac   LIKE type_t.num10
   IF cl_null(p_ac) OR p_ac <= 0 THEN RETURN END IF
   LET g_glfg_m.l_gldh008 = g_gldh_d[p_ac].gldh008
   LET g_glfg_m.l_gldh008 = s_desc_show1(g_glfg_m.l_gldh008,s_desc_get_department_desc(g_glfg_m.l_gldh008))
   LET g_glfg_m.l_gldh009 = g_gldh_d[p_ac].gldh009
   LET g_glfg_m.l_gldh009 = s_desc_show1(g_glfg_m.l_gldh009,s_desc_get_department_desc(g_glfg_m.l_gldh009))
   LET g_glfg_m.l_gldh010 = g_gldh_d[p_ac].gldh010
   LET g_glfg_m.l_gldh010  = s_desc_show1(g_glfg_m.l_gldh010 ,s_desc_get_department_desc(g_glfg_m.l_gldh010))
   LET g_glfg_m.l_gldh011 = g_gldh_d[p_ac].gldh011
   LET g_glfg_m.l_gldh011 = s_desc_show1(g_glfg_m.l_gldh011,s_desc_get_acc_desc('287',g_glfg_m.l_gldh011))
   LET g_glfg_m.l_gldh012 = g_gldh_d[p_ac].gldh012
   LET g_glfg_m.l_gldh012 = s_desc_show1(g_glfg_m.l_gldh012,s_desc_get_trading_partner_abbr_desc(g_glfg_m.l_gldh012))
   LET g_glfg_m.l_gldh013 = g_gldh_d[p_ac].gldh013
   LET g_glfg_m.l_gldh013 = s_desc_show1(g_glfg_m.l_gldh013,s_desc_get_trading_partner_abbr_desc(g_glfg_m.l_gldh013))
   LET g_glfg_m.l_gldh014 = g_gldh_d[p_ac].gldh014
   LET g_glfg_m.l_gldh014 = s_desc_show1(g_glfg_m.l_gldh014,s_desc_get_acc_desc('281',g_glfg_m.l_gldh014))   
   LET g_glfg_m.l_gldh015 = g_gldh_d[p_ac].gldh015
   LET g_glfg_m.l_gldh015 = s_desc_show1(g_glfg_m.l_gldh015,s_desc_get_rtaxl003_desc(g_glfg_m.l_gldh015))   
   LET g_glfg_m.l_gldh016 = g_gldh_d[p_ac].gldh016
   
   LET g_glfg_m.l_gldh017 = g_gldh_d[p_ac].gldh017
   LET g_glfg_m.l_gldh017 = s_desc_show1(g_glfg_m.l_gldh017,s_desc_get_oojdl003_desc(g_glfg_m.l_gldh017))   

   LET g_glfg_m.l_gldh018 = g_gldh_d[p_ac].gldh018
   LET g_glfg_m.l_gldh018 = s_desc_show1(g_glfg_m.l_gldh018,s_desc_get_acc_desc('2002',g_glfg_m.l_gldh018)) 
   LET g_glfg_m.l_gldh019 = g_gldh_d[p_ac].gldh019
   LET g_glfg_m.l_gldh019 = s_desc_show1(g_glfg_m.l_gldh019,s_desc_get_person_desc(g_glfg_m.l_gldh019)) 
   LET g_glfg_m.l_gldh020 = g_gldh_d[p_ac].gldh020
    
   LET g_glfg_m.l_gldh021 = g_gldh_d[p_ac].gldh021
   LET g_glfg_m.l_gldh021 = s_desc_show1(g_glfg_m.l_gldh021,s_desc_get_pjbbl004_desc(g_glfg_m.l_gldh020,g_glfg_m.l_gldh021)) 
   LET g_glfg_m.l_gldh020 = s_desc_show1(g_glfg_m.l_gldh020,s_desc_get_project_desc(g_glfg_m.l_gldh020))
   DISPLAY BY NAME g_glfg_m.l_gldh008,g_glfg_m.l_gldh009,g_glfg_m.l_gldh010,
                   g_glfg_m.l_gldh011,g_glfg_m.l_gldh012,g_glfg_m.l_gldh013,
                   g_glfg_m.l_gldh014,g_glfg_m.l_gldh015,g_glfg_m.l_gldh016,
                   g_glfg_m.l_gldh017,g_glfg_m.l_gldh018,g_glfg_m.l_gldh019,
                   g_glfg_m.l_gldh020,g_glfg_m.l_gldh021
END FUNCTION

################################################################################
# Descriptions...: 開啟核算項修改子程式
# Memo...........:
# Date & Author..: 150309 By albireo
# Modify.........:
################################################################################
PRIVATE FUNCTION aglt501_open_aglt501_01(p_ac)
   DEFINE p_ac   LIKE type_t.num10
   #用會科給核算項預設值
   CALL s_fin_sel_glad(g_glfg_m.glfg002,g_gldh_d[p_ac].gldh003,'ALL') RETURNING g_glad.*
   #部門
   IF g_glad.glad007 = 'Y' THEN
      IF cl_null(g_gldh_d[p_ac].gldh009) THEN
         LET g_gldh_d[p_ac].gldh009 = ''
         SELECT ooag003 INTO g_gldh_d[p_ac].gldh009 FROM ooag_t
          WHERE ooagent = g_enterprise
            AND ooag001 = g_user
      END IF
   END IF
   #利潤/成本中心
   IF g_glad.glad008 = 'Y' THEN
      IF cl_null(g_gldh_d[p_ac].gldh010) THEN
         IF NOT cl_null(g_gldh_d[p_ac].gldh009) THEN
            SELECT ooeg004 INTO g_gldh_d[p_ac].gldh010 FROM ooeg_t WHERE ooegent = g_enterprise AND ooeg001 = g_gldh_d[l_ac].gldh009
         ELSE
            SELECT ooeg004 INTO g_gldh_d[p_ac].gldh010 FROM ooeg_t,ooag_t
             WHERE ooegent = ooagent 
               AND ooeg001 = ooag003
               AND ooagent = g_enterprise
               AND ooag001 = g_user
         END IF
      END IF
   END IF
     
   #人員
   IF g_glad.glad013='Y' THEN
      IF cl_null(g_gldh_d[p_ac].gldh019) THEN
         LET g_gldh_d[p_ac].gldh019=g_user
      END IF
   END IF
     
   #開啟子程式 輸入固定核算資料 傳入ARRAY 輸入資料 回傳ARRAY
   CALL g_aglt501_01.clear()
   LET g_aglt501_01[1].chr  = g_glfg_m.glfg001
   LET g_aglt501_01[2].chr  = g_glfg_m.glfg002
   LET g_aglt501_01[3].chr  = g_gldh_d[p_ac].gldh003
   LET g_aglt501_01[5].chr  = g_glfg_m.glfg005
   LET g_aglt501_01[6].chr  = g_glfg_m.glfg006
   LET g_aglt501_01[8].chr  = g_gldh_d[p_ac].gldh008
   LET g_aglt501_01[9].chr  = g_gldh_d[p_ac].gldh009
   LET g_aglt501_01[10].chr = g_gldh_d[p_ac].gldh010
   LET g_aglt501_01[11].chr = g_gldh_d[p_ac].gldh011
   LET g_aglt501_01[12].chr = g_gldh_d[p_ac].gldh012
   LET g_aglt501_01[13].chr = g_gldh_d[p_ac].gldh013
   LET g_aglt501_01[14].chr = g_gldh_d[p_ac].gldh014
   LET g_aglt501_01[15].chr = g_gldh_d[p_ac].gldh015
   LET g_aglt501_01[16].chr = g_gldh_d[p_ac].gldh016
   LET g_aglt501_01[17].chr = g_gldh_d[p_ac].gldh017
   LET g_aglt501_01[18].chr = g_gldh_d[p_ac].gldh018
   LET g_aglt501_01[19].chr = g_gldh_d[p_ac].gldh019
   LET g_aglt501_01[20].chr = g_gldh_d[p_ac].gldh020
   LET g_aglt501_01[21].chr = g_gldh_d[p_ac].gldh021
   CALL aglt501_01(g_aglt501_01)RETURNING g_aglt501_01
   LET  g_gldh_d[p_ac].gldh008 = g_aglt501_01[8].chr 
   LET  g_gldh_d[p_ac].gldh009 = g_aglt501_01[9].chr 
   LET  g_gldh_d[p_ac].gldh010 = g_aglt501_01[10].chr
   LET  g_gldh_d[p_ac].gldh011 = g_aglt501_01[11].chr
   LET  g_gldh_d[p_ac].gldh012 = g_aglt501_01[12].chr
   LET  g_gldh_d[p_ac].gldh013 = g_aglt501_01[13].chr
   LET  g_gldh_d[p_ac].gldh014 = g_aglt501_01[14].chr
   LET  g_gldh_d[p_ac].gldh015 = g_aglt501_01[15].chr
   LET  g_gldh_d[p_ac].gldh016 = g_aglt501_01[16].chr
   LET  g_gldh_d[p_ac].gldh017 = g_aglt501_01[17].chr
   LET  g_gldh_d[p_ac].gldh018 = g_aglt501_01[18].chr
   LET  g_gldh_d[p_ac].gldh019 = g_aglt501_01[19].chr
   LET  g_gldh_d[p_ac].gldh020 = g_aglt501_01[20].chr
   LET  g_gldh_d[p_ac].gldh021 = g_aglt501_01[21].chr
END FUNCTION

 
{</section>}
 
