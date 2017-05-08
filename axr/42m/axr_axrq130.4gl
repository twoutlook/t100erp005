#該程式未解開Section, 採用最新樣板產出!
{<section id="axrq130.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:35(2017-01-17 14:38:45), PR版次:0035(2017-02-17 16:39:10)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000147
#+ Filename...: axrq130
#+ Description: 出貨立帳匹配查詢作業
#+ Creator....: 01531(2014-07-18 13:51:56)
#+ Modifier...: 02114 -SD/PR- 01531
 
{</section>}
 
{<section id="axrq130.global" >}
#應用 q01 樣板自動產生(Version:34)
#add-point:填寫註解說明 name="global.memo"
#150309-00036#1   2015/04/01 By 01727 銷退單立帳條件sql統一:
#                                     1.統一加入 AND xmdk000 IN ('1','2','3','6')
#                                     2.銷退單條件增加排除xmdk082
#                                     OR (xmdk000 = 6 AND xmdk082<>'5') )
#150902-00001#2   2015/09/08 By apo   增加訂單單號/項次/發票號碼
#150924-00012#2   2015/10/05 By Jessy 增加一欄應付帳款單號在單身的最後一欄位,XG報表輸出亦須增加列印
#151016           151016     By albireo 單身單號欄位增加篩選非作廢
#151019-00009#2   2015/10/21 By Jessy 增加暫估單號顯示,XG報表輸出亦須增加列印
#151102-00008#2   2015/11/03 By Jessy 1.增加子件特性欄位,XG報表輸出亦須增加列印 2.單頭增加條件: 己立暫估未立帳款的勾選項 3.axrq130:取帳款單號沒有排除作廢單,原本的收入科目glcc003,改取帳款單身的收入科目xrcb021顯示，取單身原則:AND xrcastus<>'X' AND xrcb023<>'Y'
#151123-00013#6   2015/11/27  By 01727    簽收訂單則取出貨簽收單,一般訂單則取出貨單
#151203-00013#1   2015/12/03 By Jessy 成本分群之後加入【價格群組pmma091】及說明,xg同步增加
#151203-00013#5   2015/12/07 By Jessy 交易對象欄位xmdk007請拆為交易對象/交易對象名稱兩欄;列印報表不需調整,只是為了匯excel而改為分開顯示
#151231-00010#7   2016/02/23 By yangtt  增加控制組/若單頭沒有帳套條件的開窗,都限制取目前所在據點對應的法人串 pmabsite/若input 條件有帳套就以帳套對應法人串 pmabsite
#160418-00003#1   2016/04/18 By 01727   axrq130查詢效能優化
#160505-00007#21  2016/05/27 By 02599   程式优化
#160613-00022#1   2016/06/13 By 01727   axrq130銷退單沒有考到過帳否
#160518-00075#4   2016/07/18 By 01531   (依單別參數作權限管理)aooi200的控制組設定, 取7/8 設定的部門及人員
#160727-00019#6   2016/07/28 By 08734   axrq130_print_tmp ——> axrq130_tmp01
#160802-00036#1   2016/08/03 By 01727   1.未(已) 匹配名詞 + 帳款二字
#                                       2.增加 "未立帳且未立暫估"
#                                          axrq130 邏輯: 取入庫單"立帳數量xmdl038 = 0 "  and "暫估數量xmdl053 =0" 
#                                          axrq140 邏輯: 取入庫單"已開發票數量xmdl047  =0 "  and "暫估數量xmdl053 =0" 
#160811-00009#2   2016/08/17 By 01531    账务中心/法人/账套权限控管
#160909-00015#2   2016/09/18 By 01727    以查詢出來的未沖暫估數量 * 暫估單價 取暫估單上之稅別推算出上述三個金額
#161017-00011#1   2016/10/20 By 01727    财务权限问题修正
#161021-00050#4   2016/10/24 By 08729    處理組織開窗
#161111-00049#1   2016/11/12 By 01727    控制组权限修改
#161128-00061#4   2016/12/01 by 02481    标准程式定义采用宣告模式,弃用.*写法
#161201-00035#1   2016/12/02 By 01727    发票号码取值错误
#161207-00015#1   2016/12/07 By 01727    axrq140立账本币金额未计算
#161219-00056#1   2016/12/20 By 02114    axrq130, 應收單已作廢還會在axrq130未匹配查詢中出現，如KXR01-16120007這張單據。
#                                        其實該單據對應的來源單都已完成應收立帳==>原本立帳那一張已作廢,應該是顯示的問題
#161226-00063#1   2016/12/29 By 02114    小计行没有小计成功,勾选小计后,总计数翻倍
#170109-00006#1   2017/01/09 By 02114    修改取账务中心下各据点的sub
#161206-00017#1   2017/01/17 By 02114    增加立账汇率,出货数量,计价数量
#170122-00008#1   2017/01/22 By 01531    SQL语句补ENT条件
#170213-00036#1   2017/02/13 By 02599    xmdl0271,xmdl0281,xmdl0291 計算金額後按照本幣取位
#170215-00042#1   2017/02/16 By 01531    完善#170109-00006#1调整
#170217-00038#1   2017/02/17 By 01531    已有立暫估, 但未沖暫估數, 未計算出來

#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔 name="global.inc"
GLOBALS "../../cfg/top_report.inc"
#end add-point
 
#單身 type 宣告
PRIVATE TYPE type_g_xmdk_d RECORD
       
       sel LIKE type_t.chr1, 
   xmdksite LIKE type_t.chr500, 
   xmdk007 LIKE xmdk_t.xmdk007, 
   xmdk007_desc LIKE type_t.chr500, 
   xmdk000 LIKE xmdk_t.xmdk000, 
   xmdkdocdt LIKE xmdk_t.xmdkdocdt, 
   xmdk001 LIKE xmdk_t.xmdk001, 
   xmdldocno LIKE xmdl_t.xmdldocno, 
   xmdlseq LIKE xmdl_t.xmdlseq, 
   xmdk003 LIKE xmdk_t.xmdk003, 
   xmdk003_desc LIKE type_t.chr500, 
   xmdk004 LIKE xmdk_t.xmdk004, 
   xmdk004_desc LIKE type_t.chr500, 
   xmdl014 LIKE xmdl_t.xmdl014, 
   xmdl014_desc LIKE type_t.chr500, 
   xmdl008 LIKE xmdl_t.xmdl008, 
   imaal003 LIKE imaal_t.imaal003, 
   imaal004 LIKE imaal_t.imaal004, 
   xmdl007 LIKE xmdl_t.xmdl007, 
   imag011 LIKE imag_t.imag011, 
   imag011_desc LIKE type_t.chr500, 
   pmaa091 LIKE pmaa_t.pmaa091, 
   pmaa091_desc LIKE type_t.chr500, 
   glcc003 LIKE glcc_t.glcc003, 
   glcc003_desc LIKE type_t.chr500, 
   xmdl018 LIKE xmdl_t.xmdl018, 
   xmdl022 LIKE xmdl_t.xmdl022, 
   xmdl038 LIKE xmdl_t.xmdl038, 
   l_xmdl0381 LIKE type_t.num20_6, 
   xmdl053 LIKE xmdl_t.xmdl053, 
   xmdl047 LIKE xmdl_t.xmdl047, 
   l_xmdl022diff LIKE type_t.num20_6, 
   xmdk016 LIKE xmdk_t.xmdk016, 
   xmdl003 LIKE xmdl_t.xmdl003, 
   xmdl004 LIKE xmdl_t.xmdl004, 
   xmdl049 LIKE xmdl_t.xmdl049, 
   xmdk017 LIKE xmdk_t.xmdk017, 
   xmdl025 LIKE xmdl_t.xmdl025, 
   xmdl026 LIKE xmdl_t.xmdl026, 
   xmdl024 LIKE xmdl_t.xmdl024, 
   l_xmdl0272 LIKE type_t.num20_6, 
   l_xmdl0292 LIKE type_t.num20_6, 
   l_xmdl0282 LIKE type_t.num20_6, 
   xmdl027 LIKE xmdl_t.xmdl027, 
   xmdl029 LIKE xmdl_t.xmdl029, 
   xmdl028 LIKE xmdl_t.xmdl028, 
   xrcb103 LIKE xrcb_t.xrcb103, 
   xrcb104 LIKE xrcb_t.xrcb104, 
   xrcb105 LIKE xrcb_t.xrcb105, 
   xrcf103 LIKE xrcf_t.xrcf103, 
   xrcf104 LIKE xrcf_t.xrcf104, 
   xrcf105 LIKE xrcf_t.xrcf105, 
   l_xrcb103diff LIKE type_t.num20_6, 
   l_xrcb104diff LIKE type_t.num20_6, 
   l_xrcb105diff LIKE type_t.num20_6, 
   l_xmdl0271 LIKE type_t.num20_6, 
   l_xmdl0291 LIKE type_t.num20_6, 
   l_xmdl0281 LIKE type_t.num20_6, 
   xrca101 LIKE xrca_t.xrca101, 
   xrcb113 LIKE xrcb_t.xrcb113, 
   xrcb114 LIKE xrcb_t.xrcb114, 
   xrcb115 LIKE xrcb_t.xrcb115, 
   xrcadocno LIKE xrca_t.xrcadocno, 
   xrcad2 LIKE type_t.chr20
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
TYPE type_g_xrca_m   RECORD
        xrcasite        LIKE xrca_t.xrcasite,
        xrcasite_desc   LIKE ooefl_t.ooefl003,
        xrcald          LIKE xrca_t.xrcald,
        xrcald_desc     LIKE glaal_t.glaal002,
        xrcacomp        LIKE type_t.chr80,
        type            LIKE type_t.chr1,
        type1           LIKE type_t.chr1,   #160802-00036#1 Add
        b_check         LIKE type_t.chr1
                     END RECORD
DEFINE g_xrca_m      type_g_xrca_m
DEFINE g_xrcacomp    LIKE xrca_t.xrcacomp

#161128-00061#4-----modify--begin----------
#DEFINE g_glaa              RECORD LIKE glaa_t.* #160811-00009#4 
DEFINE g_glaa  RECORD  #帳套資料檔
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
#161128-00061#4-----modify--end----------
DEFINE g_flag        LIKE type_t.chr1
DEFINE g_wc1         STRING
DEFINE g_ooef019 LIKE ooef_t.ooef019

DEFINE g_detail_idx3          LIKE type_t.num5
DEFINE g_detail_idx4          LIKE type_t.num5
#12/24
DEFINE g_wc_xmdlsite          STRING
DEFINE g_xrcasite_t           LIKE xrca_t.xrcasite
DEFINE g_xrcald_t             LIKE xrca_t.xrcald
DEFINE g_sql_ctrl       STRING                #151231-00010#7
DEFINE g_sql_ctr2       STRING                #160518-00075#4
DEFINE g_sql_ctr3       STRING                #160518-00075#4
DEFINE g_ooef004        LIKE ooef_t.ooef004   #160518-00075#4
DEFINE l_site_len       LIKE type_t.num5      #SITE段长度 #160518-00075#4
DEFINE l_slip_len       LIKE type_t.num5      #单别段长度 #160518-00075#4
DEFINE l_i              LIKE type_t.num5      #160518-00075#4
DEFINE l_j              LIKE type_t.num5      #160518-00075#4
DEFINE g_sql_ctrl2      STRING                #161111-00049#1 Add 料件控制组
#end add-point
 
#模組變數(Module Variables)
DEFINE g_xmdk_d            DYNAMIC ARRAY OF type_g_xmdk_d
DEFINE g_xmdk_d_t          type_g_xmdk_d
 
 
 
 
DEFINE g_wc                  STRING                        #儲存 user 的查詢條件
DEFINE g_wc_t                STRING                        #儲存 user 的查詢條件
DEFINE g_wc2                 STRING
DEFINE g_wc_filter           STRING
DEFINE g_wc_filter_t         STRING
DEFINE g_sql                 STRING                        #組 sql 用 
DEFINE g_forupd_sql          STRING                        #SELECT ... FOR UPDATE  SQL    
DEFINE g_cnt                 LIKE type_t.num10              
DEFINE l_ac                  LIKE type_t.num10             #目前處理的ARRAY CNT 
DEFINE g_curr_diag           ui.Dialog                     #Current Dialog     
DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
DEFINE g_current_page        LIKE type_t.num5              #目前所在頁數
DEFINE g_current_row         LIKE type_t.num10             #目前所在筆數
DEFINE g_current_idx         LIKE type_t.num10
DEFINE g_detail_cnt          LIKE type_t.num10             #單身 總筆數(所有資料)
DEFINE g_page                STRING                        #第幾頁
DEFINE g_ch                  base.Channel                  #外串程式用
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_error_show          LIKE type_t.num5
DEFINE g_row_index           LIKE type_t.num10
DEFINE g_master_idx          LIKE type_t.num10
DEFINE g_detail_idx          LIKE type_t.num10             #單身 所在筆數(所有資料)
DEFINE g_detail_idx2         LIKE type_t.num10
DEFINE g_hyper_url           STRING                        #hyperlink的主要網址
DEFINE g_qbe_hidden          LIKE type_t.num5              #qbe頁籤折疊
DEFINE g_tot_cnt             LIKE type_t.num10             #計算總筆數
DEFINE g_num_in_page         LIKE type_t.num10             #每頁筆數
DEFINE g_page_act_list       STRING                        #分頁ACTION清單
DEFINE g_current_row_tot     LIKE type_t.num10             #目前所在總筆數
DEFINE g_page_start_num      LIKE type_t.num10             #目前頁面起始筆數
DEFINE g_page_end_num        LIKE type_t.num10             #目前頁面結束筆數
 
#多table用wc
DEFINE g_wc_table           STRING
DEFINE g_detail_page_action STRING
DEFINE g_pagestart          LIKE type_t.num10
 
 
 
DEFINE g_wc_filter_table           STRING
 
 
 
#add-point:自定義模組變數-客製(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="axrq130.main" >}
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
   CALL cl_ap_init("axr","")
 
   #add-point:作業初始化 name="main.init"
   #160518-00075#4 add s--- 
   #用g_site的單別參照表
   SELECT ooef004 INTO g_ooef004 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site

   CALL s_control_get_docno_sql_q(g_user,g_dept,g_ooef004) RETURNING g_sub_success,g_sql_ctr2,g_sql_ctr3 
     
   #SITE 长度
   LET l_site_len = cl_get_para(g_enterprise,g_site,'E-COM-0003')
   
   #单别长度
   LET l_slip_len = cl_get_para(g_enterprise,g_site,'E-COM-0001')
   
   #第一个分隔符
   IF cl_get_para(g_enterprise,g_site,'E-COM-0008') = '1' THEN    #据点+单别
      LET l_i = l_site_len + 2
      LET l_j = l_slip_len
   ELSE
      LET l_i = 1
      LET l_j = l_slip_len
   END IF    

   #160518-00075#4 add e---
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " ", 
                      " FROM ",
                      " "
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axrq130_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE axrq130_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axrq130_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axrq130 WITH FORM cl_ap_formpath("axr",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axrq130_init()   
 
      #進入選單 Menu (="N")
      CALL axrq130_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      DROP TABLE s_fin_tmp1
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axrq130
      
   END IF 
   
   CLOSE axrq130_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
    DROP TABLE axrq130_tmp01; #160505-00007#21         #160727-00019#6   2016/07/28 By 08734   axrq130_print_tmp ——> axrq130_tmp01
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="axrq130.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION axrq130_init()
   #add-point:init段define-客製 name="init.define_customerization"
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_title      LIKE gzzd_t.gzzd005
   #end add-point
 
   #add-point:FUNCTION前置處理 name="init.before_function"
   
   #end add-point
 
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1" 
   LET g_error_show  = 1
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   
      CALL cl_set_combo_scc('b_xmdk000','2077') 
   CALL cl_set_combo_scc('b_xmdl007','2055') 
  
 
   #add-point:畫面資料初始化 name="init.init"
   #151231-00010#7(S)
   LET g_sql_ctrl = NULL
   CALL s_control_get_customer_sql('2',g_site,g_user,g_dept,'') RETURNING g_sub_success,g_sql_ctrl
   #151231-00010#7(E)
   IF g_argv[1] = '2' THEN   #axrq140
      CALL cl_set_comp_visible('lbl_xrcald,xrcald,xrcald_desc,xrcacomp',FALSE)
     #CALL cl_set_comp_visible('b_xmdl038,b_xmdl053,b_xrcf103,b_xrcf104,b_xrcf105,b_xrcb113,b_xrcb114,b_xrcb115',FALSE)
      SELECT gzzd005 INTO l_title FROM gzzd_t
       WHERE gzzdstus = 'Y'
         AND gzzd001  = 'axrq130'
         AND gzzd002  = g_lang
         AND gzzd003  = 'lbl_xmdl047_title'
      CALL cl_set_comp_att_text('b_xmdl047',l_title)
      #LET g_xg_fieldname[27] = l_title     #161206-00017#1 mark lujh
      LET g_xg_fieldname[28] = l_title      #161206-00017#1 add lujh
      SELECT gzzd005 INTO l_title FROM gzzd_t
       WHERE gzzdstus = 'Y'
         AND gzzd001  = 'axrq130'
         AND gzzd002  = g_lang
         AND gzzd003  = 'lbl_xrcb103_title'
      CALL cl_set_comp_att_text('b_xrcb103',l_title)
      #LET g_xg_fieldname[40] = l_title   #161206-00017#1 mark lujh
      LET g_xg_fieldname[41] = l_title    #161206-00017#1 add lujh
      SELECT gzzd005 INTO l_title FROM gzzd_t
       WHERE gzzdstus = 'Y'
         AND gzzd001  = 'axrq130'
         AND gzzd002  = g_lang
         AND gzzd003  = 'lbl_xrcb104_title'
      CALL cl_set_comp_att_text('b_xrcb104',l_title)
      #LET g_xg_fieldname[41] = l_title   #161206-00017#1 mark lujh
      LET g_xg_fieldname[42] = l_title    #161206-00017#1 add lujh
      SELECT gzzd005 INTO l_title FROM gzzd_t
       WHERE gzzdstus = 'Y'
         AND gzzd001  = 'axrq130'
         AND gzzd002  = g_lang
         AND gzzd003  = 'lbl_xrcb105_title'
      CALL cl_set_comp_att_text('b_xrcb105',l_title)
      #LET g_xg_fieldname[42] = l_title   #161206-00017#1 mark lujh
      LET g_xg_fieldname[43] = l_title    #161206-00017#1 add lujh
  #160802-00036#1 Add  ---(S)---
      SELECT gzzd006 INTO l_title FROM gzzd_t
       WHERE gzzdstus = 'Y'
         AND gzzd001  = 'axrq130'
         AND gzzd002  = g_lang
         AND gzzd003  = 'lbl_xmdl027'
      CALL cl_set_comp_att_text('b_xmdl027',l_title)

      SELECT gzzd006 INTO l_title FROM gzzd_t
       WHERE gzzdstus = 'Y'
         AND gzzd001  = 'axrq130'
         AND gzzd002  = g_lang
         AND gzzd003  = 'lbl_xmdl028'
      CALL cl_set_comp_att_text('b_xmdl028',l_title)

      SELECT gzzd006 INTO l_title FROM gzzd_t
       WHERE gzzdstus = 'Y'
         AND gzzd001  = 'axrq130'
         AND gzzd002  = g_lang
         AND gzzd003  = 'lbl_xmdl029'
      CALL cl_set_comp_att_text('b_xmdl029',l_title)

      SELECT gzzd006 INTO l_title FROM gzzd_t
       WHERE gzzdstus = 'Y'
         AND gzzd001  = 'axrq130'
         AND gzzd002  = g_lang
         AND gzzd003  = 'lbl_xmdl0271'
      CALL cl_set_comp_att_text('l_xmdl0271',l_title)

      SELECT gzzd006 INTO l_title FROM gzzd_t
       WHERE gzzdstus = 'Y'
         AND gzzd001  = 'axrq130'
         AND gzzd002  = g_lang
         AND gzzd003  = 'lbl_xmdl0281'
      CALL cl_set_comp_att_text('l_xmdl0281',l_title)

      SELECT gzzd006 INTO l_title FROM gzzd_t
       WHERE gzzdstus = 'Y'
         AND gzzd001  = 'axrq130'
         AND gzzd002  = g_lang
         AND gzzd003  = 'lbl_xmdl0291'
      CALL cl_set_comp_att_text('l_xmdl0291',l_title)

      CALL cl_set_comp_visible('Grid_gen1',FALSE)
      CALL cl_set_comp_visible('Grid_gen3',TRUE)
   ELSE
      CALL cl_set_comp_visible('Grid_gen3',FALSE)
      CALL cl_set_comp_visible('Grid_gen1',TRUE)
  #160802-00036#1 Add  ---(E)---
   END IF
   
   CALL axrq130_def()
   CALL cl_set_combo_scc("b_xmdk000_1",2063)
   CALL cl_set_combo_scc("xmdk002",2063)
   CALL s_fin_create_account_center_tmp()   
   
   CALL axrq130_create_tmp() #160505-00007#21 
   #end add-point
 
   CALL axrq130_default_search()
END FUNCTION
 
{</section>}
 
{<section id="axrq130.default_search" >}
PRIVATE FUNCTION axrq130_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
 
   #add-point:default_search段開始前 name="default_search.before"
 
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " xmdkdocno = '", g_argv[01], "' AND "
   END IF
 
 
 
 
 
 
 
   IF NOT cl_null(g_wc) THEN
      LET g_wc = g_wc.subString(1,g_wc.getLength()-5)
   ELSE
      #預設查詢條件
      LET g_wc = " 1=2"
   END IF
 
   #add-point:default_search段結束前 name="default_search.after"
   LET g_wc = " 1=2"
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axrq130.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axrq130_ui_dialog() 
   #add-point:ui_dialog段define-客製 name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit   LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx    LIKE type_t.num10
   DEFINE ls_result STRING
   DEFINE ls_wc     STRING
   DEFINE lc_action_choice_old   STRING
   DEFINE ls_js     STRING
   DEFINE la_param  RECORD
                    prog       STRING,
                    actionid   STRING,
                    background LIKE type_t.chr1,
                    param      DYNAMIC ARRAY OF STRING
                    END RECORD
   #add-point:ui_dialog段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_dialog.define"
   DEFINE l_s               LIKE type_t.chr1
   DEFINE l_success         LIKE type_t.chr1
   DEFINE l_cnt             LIKE type_t.num5

   DEFINE l_str            STRING
   DEFINE l_num            LIKE type_t.num5
   DEFINE l_date           LIKE glav_t.glav004
   DEFINE l_pdate_s        LIKE glav_t.glav004
   DEFINE l_pdate_e        LIKE glav_t.glav004
   DEFINE l_glaa003        LIKE glaa_t.glaa003
   #end add-point
   
 
   #add-point:FUNCTION前置處理 name="ui_dialog.before_function"
   
   #end add-point
 
   CALL cl_set_act_visible("accept,cancel", FALSE)
   CALL cl_get_num_in_page() RETURNING g_num_in_page
 
   LET li_exit = FALSE
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   LET g_current_idx = 1
   LET g_action_choice = " "
   LET lc_action_choice_old = ""
   LET g_current_row_tot = 0
   LET g_page_start_num = 1
   LET g_page_end_num = g_num_in_page
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   LET l_ac = 1
 
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   CALL axrq130_def()
   CALL s_axrt300_sel_ld(g_xrca_m.xrcald) RETURNING l_success,g_flag
   #end add-point
 
   
   CALL axrq130_b_fill()
  
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_xmdk_d.clear()
 
         LET g_wc  = " 1=2"
         LET g_wc2 = " 1=1"
         LET g_action_choice = ""
         LET g_detail_page_action = "detail_first"
         LET g_pagestart = 1
         LET g_current_row_tot = 0
         LET g_page_start_num = 1
         LET g_page_end_num = g_num_in_page
         LET g_detail_idx = 1
         LET g_detail_idx2 = 1
 
         CALL axrq130_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"
         INPUT BY NAME g_xrca_m.xrcasite,g_xrca_m.xrcald,g_xrca_m.type,g_xrca_m.type1,g_xrca_m.b_check   #160802-00036#1 Add  g_xrca_m.type1
         
            BEFORE INPUT 
              CALL axrq130_def()
               
            AFTER FIELD xrcald  
              IF NOT cl_null(g_xrca_m.xrcald) THEN 
                 CALL s_axrt300_site_geared_ld(g_xrca_m.xrcasite,g_xrca_m.xrcald,g_user,g_today,'ld')
                    RETURNING l_success,g_xrca_m.xrcasite,g_xrca_m.xrcasite_desc,g_xrca_m.xrcald,g_xrca_m.xrcald_desc
                 DISPLAY BY NAME g_xrca_m.xrcasite,g_xrca_m.xrcasite_desc
                 DISPLAY BY NAME g_xrca_m.xrcald,g_xrca_m.xrcald_desc
                 DISPLAY BY NAME g_xrca_m.xrcacomp
                 IF NOT l_success THEN
                   #161128-00061#4-----modify--begin----------
                   #SELECT * INTO g_glaa.* 
                    SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,
                           glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,glaa011,
                           glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,glaa023,
                           glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,glaa113,glaa120,glaa121,
                           glaa122,glaa027,glaa130,glaa131,glaa132,glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,
                           glaa140,glaa123,glaa124,glaa028 INTO g_glaa.* 
                   #161128-00061#4----modify--end----------
                    FROM FROM glaa_t WHERE glaaent = g_enterprise AND glaald  = g_xrca_m.xrcald
                    NEXT FIELD CURRENT
                 END IF
              ELSE
                 LET g_xrca_m.xrcald_desc = ''
              END IF
              #161128-00061#4-----modify--begin----------
              #SELECT * INTO g_glaa.* 
               SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,
                      glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,glaa011,
                      glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,glaa023,
                      glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,glaa113,glaa120,glaa121,
                      glaa122,glaa027,glaa130,glaa131,glaa132,glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,
                      glaa140,glaa123,glaa124,glaa028 INTO g_glaa.* 
              #161128-00061#4----modify--end----------
              FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_xrca_m.xrcald
              IF NOT cl_null(g_glaa.glaacomp) THEN
                 CALL s_axrt300_xrca_ref('xrcasite',g_glaa.glaacomp,'','') RETURNING l_success,g_xrca_m.xrcacomp
                 LET g_xrca_m.xrcacomp = g_glaa.glaacomp,'(', g_xrca_m.xrcacomp , ')'
              ELSE
                 LET g_xrca_m.xrcacomp = ''
              END IF
             #161111-00049#1 Add  ---(S)---
              CALL s_control_get_customer_sql_pmab('4',g_site,g_user,g_dept,'',g_glaa.glaacomp) RETURNING g_sub_success,g_sql_ctrl
              LET g_sql_ctrl2 = NULL
              CALL s_control_get_item_sql('2',g_glaa.glaacomp,g_user,g_dept,'') RETURNING g_sub_success,g_sql_ctrl2
             #161111-00049#1 Add  ---(E)---
              DISPLAY BY NAME g_xrca_m.xrcasite,g_xrca_m.xrcasite_desc
              DISPLAY BY NAME g_xrca_m.xrcald,g_xrca_m.xrcald_desc
              DISPLAY BY NAME g_xrca_m.xrcacomp
              
              
            

           AFTER FIELD xrcasite
              IF NOT cl_null(g_xrca_m.xrcasite) THEN
                 #161021-00050#4-add(s)
                 CALL s_fin_account_center_with_ld_chk(g_xrca_m.xrcasite,g_xrca_m.xrcald,g_user,'3','N','',g_today) RETURNING l_success,g_errno
                    IF NOT cl_null(g_errno) THEN
                       INITIALIZE g_errparam TO NULL
                       LET g_errparam.code = g_errno
                       LET g_errparam.extend = g_xrca_m.xrcasite
                       LET g_errparam.popup = TRUE
                       CALL cl_err()
                       LET g_xrca_m.xrcasite = ''
                       LET g_xrca_m.xrcald = ''
                       LET g_xrca_m.xrcasite_desc = ''
                       LET g_xrca_m.xrcald_desc = ''
                       DISPLAY BY NAME g_xrca_m.xrcasite,g_xrca_m.xrcasite_desc
                       DISPLAY BY NAME g_xrca_m.xrcald,g_xrca_m.xrcald_desc
                       NEXT FIELD CURRENT
                    END IF
                 #161021-00050#4-add(e)
                 CALL s_axrt300_site_geared_ld(g_xrca_m.xrcasite,g_xrca_m.xrcald,g_user,g_today,'site')
                    RETURNING l_success,g_xrca_m.xrcasite,g_xrca_m.xrcasite_desc,g_xrca_m.xrcald,g_xrca_m.xrcald_desc
                 DISPLAY BY NAME g_xrca_m.xrcasite,g_xrca_m.xrcasite_desc
                 DISPLAY BY NAME g_xrca_m.xrcald,g_xrca_m.xrcald_desc
                 DISPLAY BY NAME g_xrca_m.xrcacomp
                 IF NOT l_success THEN NEXT FIELD CURRENT END IF
              ELSE
                 LET g_xrca_m.xrcasite_desc = ''
              END IF
              #161128-00061#4-----modify--begin----------
              #SELECT * INTO g_glaa.* 
               SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,
                      glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,glaa011,
                      glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,glaa023,
                      glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,glaa113,glaa120,glaa121,
                      glaa122,glaa027,glaa130,glaa131,glaa132,glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,
                      glaa140,glaa123,glaa124,glaa028 INTO g_glaa.* 
              #161128-00061#4----modify--end---------- 
              FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_xrca_m.xrcald
              IF NOT cl_null(g_glaa.glaacomp) THEN
                 CALL s_axrt300_xrca_ref('xrcasite',g_glaa.glaacomp,'','') RETURNING l_success,g_xrca_m.xrcacomp
                 LET g_xrca_m.xrcacomp = g_glaa.glaacomp,'(', g_xrca_m.xrcacomp , ')'
              ELSE
                 LET g_xrca_m.xrcacomp = ''
              END IF
              #161111-00049#1 Add  ---(S)---
               CALL s_control_get_customer_sql_pmab('4',g_site,g_user,g_dept,'',g_glaa.glaacomp) RETURNING g_sub_success,g_sql_ctrl
               LET g_sql_ctrl2 = NULL
               CALL s_control_get_item_sql('2',g_glaa.glaacomp,g_user,g_dept,'') RETURNING g_sub_success,g_sql_ctrl2
              #161111-00049#1 Add  ---(E)---
              DISPLAY BY NAME g_xrca_m.xrcasite,g_xrca_m.xrcasite_desc
              DISPLAY BY NAME g_xrca_m.xrcald,g_xrca_m.xrcald_desc
              DISPLAY BY NAME g_xrca_m.xrcacomp

           ON CHANGE b_check
             #160802-00036#1 Mark ---(S)---
             #IF NOT cl_null(g_xrca_m.b_check) THEN
             #   CALL axrq130_b_fill()
             #END IF
             #160802-00036#1 Mark ---(E)---

           ON CHANGE type
              IF NOT cl_null(g_xrca_m.type) THEN
                 CALL cl_set_comp_visible('b_xmdl027,b_xmdl029,b_xdl028,l_xmdl0271,l_xmdl0291,l_xdl0281',TRUE)
                 IF g_xrca_m.type = '2' THEN
                    CALL cl_set_comp_visible('b_xmdl027,b_xmdl029,b_xdl028,l_xmdl0271,l_xmdl0291,l_xmdl0281',FALSE)
                 END IF
                #160802-00036#1 Mark ---(S)---
                #CALL axrq130_b_fill()
                #160802-00036#1 Mark ---(E)---
              END IF

           #160802-00036#1 Add  ---(S)---
           ON CHANGE type1
              LET g_xrca_m.type = g_xrca_m.type1
           #160802-00036#1 Add  ---(E)---

           ON ACTION controlp INFIELD xrcald
              #取得帳務組織下所屬成員
              CALL s_fin_account_center_sons_query('3',g_xrca_m.xrcasite,g_today,'1')
              #取得帳務組織下所屬成員之帳別   
              #CALL s_fin_account_center_comp_str() RETURNING ls_wc   #170109-00006#1 mark lujh
              CALL s_fin_account_center_sons_str() RETURNING ls_wc    #170109-00006#1 add lujh
              #將取回的字串轉換為SQL條件
              CALL axrq130_get_ooef001_wc(ls_wc) RETURNING ls_wc  
              #開窗i段
			     INITIALIZE g_qryparam.* TO NULL
              LET g_qryparam.state = 'i'
			     LET g_qryparam.reqry = FALSE
              LET g_qryparam.default1 = g_xrca_m.xrcald             #給予default值
#160811-00009#2 mark s---
#              IF NOT cl_null(ls_wc) AND ls_wc <> '(\'\')' THEN
#                 LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') AND glaacomp IN ",ls_wc,""
#              ELSE
#                 LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y')"
#              END IF
#160811-00009#2 mark e---
              LET g_qryparam.arg1 = g_user
              LET g_qryparam.arg2 = g_dept
              LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') AND glaacomp IN ",ls_wc,"" #160811-00009#2
              CALL  q_authorised_ld()                                  #呼叫開窗
              LET g_xrca_m.xrcald = g_qryparam.return1       #將開窗取得的值回傳到變數
              IF NOT cl_null(g_xrca_m.xrcald) THEN
                 CALL s_axrt300_site_geared_ld(g_xrca_m.xrcasite,g_xrca_m.xrcald,g_user,g_today,'ld')
                    RETURNING l_success,g_xrca_m.xrcasite,g_xrca_m.xrcasite_desc,g_xrca_m.xrcald,g_xrca_m.xrcald_desc
                 #161128-00061#4-----modify--begin----------
                 #SELECT * INTO g_glaa.* 
                  SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,
                         glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,glaa011,
                         glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,glaa023,
                         glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,glaa113,glaa120,glaa121,
                         glaa122,glaa027,glaa130,glaa131,glaa132,glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,
                         glaa140,glaa123,glaa124,glaa028 INTO g_glaa.* 
                 #161128-00061#4----modify--end---------- 
                 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_xrca_m.xrcald
                 IF NOT cl_null(g_glaa.glaacomp) THEN
                    CALL s_axrt300_xrca_ref('xrcasite',g_glaa.glaacomp,'','') RETURNING l_success,g_xrca_m.xrcacomp
                    LET g_xrca_m.xrcacomp = g_glaa.glaacomp,'(', g_xrca_m.xrcacomp , ')'
                 ELSE
                    LET g_xrca_m.xrcacomp = ''
                 END IF
              END IF
              DISPLAY BY NAME g_xrca_m.xrcald,g_xrca_m.xrcald_desc,g_xrca_m.xrcacomp
              NEXT FIELD xrcald                              #返回原欄位  
        
           ON ACTION controlp INFIELD xrcasite
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xrca_m.xrcasite             #給予default值
            #LET g_qryparam.where = " ooef201 = 'Y' " #160811-00009#2 mark

            #給予arg

            #CALL q_ooef001()                              #呼叫開窗 #161021-00050#4 mark
            CALL q_ooef001_46()                                     #161021-00050#4 add
            LET g_xrca_m.xrcasite = g_qryparam.return1              #將開窗取得的值回傳到變數
            CALL s_axrt300_xrca_ref('xrcasite',g_xrca_m.xrcasite,'','') RETURNING l_success,g_xrca_m.xrcasite_desc
            IF NOT cl_null(g_xrca_m.xrcasite) THEN
               CALL s_axrt300_site_geared_ld(g_xrca_m.xrcasite,g_xrca_m.xrcald,g_user,g_today,'site')
                  RETURNING l_success,g_xrca_m.xrcasite,g_xrca_m.xrcasite_desc,g_xrca_m.xrcald,g_xrca_m.xrcald_desc
               #161128-00061#4-----modify--begin----------
               #SELECT * INTO g_glaa.* 
                SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,
                       glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,glaa011,
                       glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,glaa023,
                       glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,glaa113,glaa120,glaa121,
                       glaa122,glaa027,glaa130,glaa131,glaa132,glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,
                       glaa140,glaa123,glaa124,glaa028 INTO g_glaa.* 
               #161128-00061#4----modify--end---------- 
               FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_xrca_m.xrcald
               IF NOT cl_null(g_glaa.glaacomp) THEN
                  CALL s_axrt300_xrca_ref('xrcasite',g_glaa.glaacomp,'','') RETURNING l_success,g_xrca_m.xrcacomp
                  LET g_xrca_m.xrcacomp = g_glaa.glaacomp,'(', g_xrca_m.xrcacomp , ')'
               ELSE
                  LET g_xrca_m.xrcacomp = ''
               END IF
            END IF
            DISPLAY BY NAME g_xrca_m.xrcasite,g_xrca_m.xrcasite_desc
            DISPLAY BY NAME g_xrca_m.xrcald,g_xrca_m.xrcald_desc
            DISPLAY BY NAME g_xrca_m.xrcacomp
            DISPLAY BY NAME g_xrca_m.xrcasite,g_xrca_m.xrcasite_desc

              
        END INPUT
        
         CONSTRUCT BY NAME g_wc ON xmdk007,xmdkdocdt,xmdk001,xmdk003,xmdl003,xmdldocno
           
            BEFORE CONSTRUCT
               CALL cl_qbe_init()
        
            ON ACTION controlp INFIELD xmdk007              #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE  
               LET g_qryparam.arg1  = 'ALL'               
               #151231-00010#7--(S)
               LET g_qryparam.where = " pmaa001 IN (SELECT pmab001 FROM pmab_t WHERE pmabent = ",g_enterprise,
                                                   " AND pmabsite IN (SELECT ooef001 FROM ooef_t,glaa_t WHERE ooefent = glaaent AND glaacomp = ooef017 AND glaaent = ",g_enterprise," AND glaald = '",g_xrca_m.xrcald,"')) "
               IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
                  LET g_qryparam.where = g_qryparam.where ," AND pmaa001 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"
               END IF
               #151231-00010#7--(E)
              #CALL q_pmaa001_6()                           #呼叫開窗   #161111-00049#1 Mark
              #161111-00049#1 Add  ---(S)---
               LET g_qryparam.arg1="('2','3')"
               CALL q_pmaa001_1()
              #161111-00049#1 Add  ---(E)---
               DISPLAY g_qryparam.return1 TO xmdk007        #顯示到畫面上
               NEXT FIELD xmdk007                           #返回原欄位

            ON ACTION controlp INFIELD xmdk003              #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE      
               CALL q_ooag001_6()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmdk003        #顯示到畫面上
               NEXT FIELD xmdk003                           #返回原欄位

            ON ACTION controlp INFIELD xmdl003              #開窗c段
               #取得帳務組織下所屬成員
               CALL s_fin_account_center_sons_query('3',g_xrca_m.xrcasite,g_today,'1')
               #取得帳務組織下所屬成員之帳別   
               #CALL s_fin_account_center_comp_str() RETURNING ls_wc   #170109-00006#1 mark lujh
               CALL s_fin_account_center_sons_str() RETURNING ls_wc    #170109-00006#1 add lujh
               #將取回的字串轉換為SQL條件
               CALL axrq130_get_ooef001_wc(ls_wc) RETURNING ls_wc  

               CALL s_axrt300_sel_ld(g_xrca_m.xrcald) RETURNING l_success,l_s
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               
               IF g_argv[1] = '1' THEN
                  LET g_qryparam.arg1 = "('",g_xrca_m.xrcasite,"')"
               ELSE
                  LET g_qryparam.arg1  = ls_wc
               END IF

               LET g_qryparam.arg2  = l_s
               CALL q_xmdl003()                             #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmdl003        #顯示到畫面上
               NEXT FIELD xmdl003                           #返回原欄位

            ON ACTION controlp INFIELD xmdldocno            #開窗c段
               #取得帳務組織下所屬成員
               CALL s_fin_account_center_sons_query('3',g_xrca_m.xrcasite,g_today,'1')
               #取得帳務組織下所屬成員之帳別   
               #CALL s_fin_account_center_comp_str() RETURNING ls_wc   #170109-00006#1 mark lujh
               CALL s_fin_account_center_sons_str() RETURNING ls_wc    #170109-00006#1 add lujh
               #將取回的字串轉換為SQL條件
               CALL axrq130_get_ooef001_wc(ls_wc) RETURNING ls_wc  

               CALL s_axrt300_sel_ld(g_xrca_m.xrcald) RETURNING l_success,l_s
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1  = l_s
               
               IF g_argv[1] = '1' THEN
                  LET g_qryparam.arg2 = "('",g_xrca_m.xrcasite,"')"
               ELSE
                  LET g_qryparam.arg2  = ls_wc
               END IF
               #151231-00010#7--(S)
               LET g_qryparam.where = " xmdk007 IN (SELECT pmab001 FROM pmab_t WHERE pmabent = ",g_enterprise,
                                      " AND pmabsite IN (SELECT ooef001 FROM ooef_t,glaa_t WHERE ooefent = glaaent AND glaacomp = ooef017 AND glaaent = ",g_enterprise," AND glaald = '",g_xrca_m.xrcald,"')) "
               IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
                  LET g_qryparam.where = g_qryparam.where  ," AND xmdk007 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"
               END IF
               #151231-00010#7--(E)
               #160518-00075#4 add s---            
               IF NOT cl_null(g_sql_ctr2) AND NOT cl_null(g_sql_ctr3) THEN
                  LET g_qryparam.where = g_qryparam.where," AND (substr(xmdkdocno,",l_i,",",l_j,") ",g_sql_ctr2," OR substr(xmdkdocno,",l_i,",",l_j,") ",g_sql_ctr3,")"
               END IF
               #160518-00075#4 add e---                        
               

               CALL q_xmdl_10()                             #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmdldocno      #顯示到畫面上
               NEXT FIELD xmdldocno                         #返回原欄位
        
         END CONSTRUCT 
         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
         
         #end add-point
     
         DISPLAY ARRAY g_xmdk_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL axrq130_detail_action_trans()
 
               LET g_master_idx = l_ac
               #為避免按上下筆時影響執行效能，所以做一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL axrq130_b_fill2()
               LET g_action_choice = lc_action_choice_old
 
               #add-point:input段before row name="input.body.before_row"
               
               #end add-point
 
            
 
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
 
         #add-point:第一頁籤程式段mark結束用 name="ui_dialog.page1.mark.end"
         
         #end add-point
 
 
 
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
 
         #end add-point
 
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL axrq130_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            CALL axrq130_def()
            IF NOT cl_null(g_xrca_m.xrcald) THEN
               CALL s_ld_sel_glaa(g_xrca_m.xrcald,'glaa003')
                    RETURNING g_success,l_glaa003

               CALL s_get_accdate(l_glaa003,g_today,'','')
                        RETURNING g_success,g_errno,l_num,
                                  l_num,l_date,l_date,
                                  l_num,l_pdate_s,l_pdate_e,
                                  l_num,l_date,l_date
               LET l_str = l_pdate_s,":",l_pdate_e
               DISPLAY l_str TO xmdkdocdt    #顯示到畫面上
               LET g_wc = " xmdkdocdt BETWEEN TO_DATE('",l_pdate_s," 00:00:00','YYYY-MM-DD HH24:MI:SS') AND TO_DATE('",l_pdate_e,"','YYYY-MM-DD HH24:MI:SS')"
            END IF
            IF g_wc = " 1=2" THEN LET g_wc = " 1=1" END IF
            #end add-point
            NEXT FIELD xrcasite
 
         AFTER DIALOG
            #add-point:ui_dialog段 after dialog name="ui_dialog.after_dialog"
            
            #end add-point
            
         ON ACTION exit
            LET g_action_choice="exit"
            LET INT_FLAG = FALSE
            LET li_exit = TRUE
            EXIT DIALOG 
      
         ON ACTION close
            LET INT_FLAG=FALSE
            LET li_exit = TRUE
            EXIT DIALOG
 
         ON ACTION accept
            INITIALIZE g_wc_filter TO NULL
            IF cl_null(g_wc) THEN
               LET g_wc = " 1=1"
            END IF
 
 
         
            IF cl_null(g_wc2) THEN
               LET g_wc2 = " 1=1"
            END IF
 
 
 
            #add-point:ON ACTION accept name="ui_dialog.accept"
            
            #end add-point
 
            LET g_detail_idx = 1
            LET g_detail_idx2 = 1
            CALL axrq130_b_fill()
 
            IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ""
               LET g_errparam.code   = -100
               LET g_errparam.popup  = TRUE
               CALL cl_err()
            END IF
 
 
         ON ACTION agendum   # 待辦事項
            #add-point:ON ACTION agendum name="ui_dialog.agendum"
            
            #end add-point
            CALL cl_user_overview()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_xmdk_d)
               LET g_export_id[1]   = "s_detail1"
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
         ON ACTION datarefresh   # 重新整理
            CALL axrq130_b_fill()
 
         ON ACTION qbehidden     #qbe頁籤折疊
            IF g_qbe_hidden THEN
               CALL gfrm_curr.setElementHidden("qbe",0)
               CALL gfrm_curr.setElementImage("qbehidden","16/mainhidden.png")
               LET g_qbe_hidden = 0     #visible
            ELSE
               CALL gfrm_curr.setElementHidden("qbe",1)
               CALL gfrm_curr.setElementImage("qbehidden","16/worksheethidden.png")
               LET g_qbe_hidden = 1     #hidden
            END IF
 
         ON ACTION detail_first               #page first
            LET g_action_choice = "detail_first"
            LET g_detail_page_action = "detail_first"
            CALL axrq130_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL axrq130_b_fill()
 
         ON ACTION detail_next               #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL axrq130_b_fill()
 
         ON ACTION detail_last               #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL axrq130_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_xmdk_d.getLength()
               LET g_xmdk_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_xmdk_d.getLength()
               LET g_xmdk_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_xmdk_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_xmdk_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_xmdk_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_xmdk_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
 
 
 
 
 
         #應用 qs16 樣板自動產生(Version:3)
         ON ACTION filter
            LET g_action_choice="filter"
            CALL axrq130_filter()
            #add-point:ON ACTION filter name="menu.filter"
            
            #END add-point
            EXIT DIALOG
 
 
 
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               CALL axrq130_x01('1=1','axrq130_tmp01',g_xrca_m.type,g_argv[1],g_xrca_m.xrcald)     #160727-00019#6   2016/07/28 By 08734   axrq130_print_tmp ——> axrq130_tmp01
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               CALL axrq130_x01('1=1','axrq130_tmp01',g_xrca_m.type,g_argv[1],g_xrca_m.xrcald)     #160727-00019#6   2016/07/28 By 08734   axrq130_print_tmp ——> axrq130_tmp01
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION datainfo
            LET g_action_choice="datainfo"
            IF cl_auth_chk_act("datainfo") THEN
               
               #add-point:ON ACTION datainfo name="menu.datainfo"
               
               #END add-point
               
               
            END IF
 
 
 
 
      
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
 
         #add-point:查詢方案相關ACTION設定前 name="ui_dialog.set_qbe_action_before"
         
         #end add-point
 
         ON ACTION qbeclear   # 條件清除
            CLEAR FORM
            #add-point:條件清除後 name="ui_dialog.qbeclear"
            
            #end add-point
 
         #add-point:查詢方案相關ACTION設定後 name="ui_dialog.set_qbe_action_after"
         INITIALIZE g_xrca_m.* TO NULL
         CALL axrq130_def()
         #end add-point
 
      END DIALOG 
   
   END WHILE
 
END FUNCTION
 
{</section>}
 
{<section id="axrq130.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axrq130_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE l_pid           LIKE type_t.chr50
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   IF g_wc = " 1=2" THEN RETURN END IF
   CALL axrq130_b_fill3()
   RETURN
   #end add-point
 
 
   IF cl_null(g_wc_filter) THEN
      LET g_wc_filter = " 1=1"
   END IF
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
 
   LET ls_wc = g_wc, " AND ", g_wc2, " AND ", g_wc_filter, cl_sql_auth_filter()   #(ver:34) add cl_sql_auth_filter()
 
   CALL g_xmdk_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1
 
   # b_fill段sql組成及FOREACH撰寫
   #應用 qs04 樣板自動產生(Version:9)
   #+ b_fill段資料取得(包含sql組成及FOREACH段撰寫)
   LET ls_sql_rank = "SELECT  UNIQUE '','',xmdk007,'',xmdk000,xmdkdocdt,xmdk001,'','',xmdk003,'',xmdk004, 
       '','','','','','','','','','','','','','','','','','','','',xmdk016,'','','',xmdk017,'','','', 
       '','','','','','','','','','','','','','','','','','','','','','','',''  ,DENSE_RANK() OVER( ORDER BY xmdk_t.xmdkdocno) AS RANK FROM xmdk_t", 
 
 
 
                     "",
                     " WHERE xmdkent= ? AND 1=1 AND ", ls_wc
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("xmdk_t"),
                     " ORDER BY xmdk_t.xmdkdocno"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   
   #end add-point
 
   LET g_sql = "SELECT COUNT(1) FROM (",ls_sql_rank,")"
 
   PREPARE b_fill_cnt_pre FROM g_sql  #總筆數
   EXECUTE b_fill_cnt_pre USING g_enterprise INTO g_tot_cnt
   FREE b_fill_cnt_pre
 
   #add-point:b_fill段rank_sql_after_count name="b_fill.rank_sql_after_count"
   
   #end add-point
 
   CASE g_detail_page_action
      WHEN "detail_first"
          LET g_pagestart = 1
 
      WHEN "detail_previous"
          LET g_pagestart = g_pagestart - g_num_in_page
          IF g_pagestart < 1 THEN
              LET g_pagestart = 1
          END IF
 
      WHEN "detail_next"
         LET g_pagestart = g_pagestart + g_num_in_page
         IF g_pagestart > g_tot_cnt THEN
            LET g_pagestart = g_tot_cnt - (g_tot_cnt mod g_num_in_page) + 1
            WHILE g_pagestart > g_tot_cnt
               LET g_pagestart = g_pagestart - g_num_in_page
            END WHILE
         END IF
 
      WHEN "detail_last"
         LET g_pagestart = g_tot_cnt - (g_tot_cnt mod g_num_in_page) + 1
         WHILE g_pagestart > g_tot_cnt
            LET g_pagestart = g_pagestart - g_num_in_page
         END WHILE
 
      OTHERWISE
         LET g_pagestart = 1
 
   END CASE
 
   LET g_sql = "SELECT '','',xmdk007,'',xmdk000,xmdkdocdt,xmdk001,'','',xmdk003,'',xmdk004,'','','', 
       '','','','','','','','','','','','','','','','','',xmdk016,'','','',xmdk017,'','','','','','', 
       '','','','','','','','','','','','','','','','','','','','',''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE axrq130_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR axrq130_pb
 
   OPEN b_fill_curs USING g_enterprise
 
   FOREACH b_fill_curs INTO g_xmdk_d[l_ac].sel,g_xmdk_d[l_ac].xmdksite,g_xmdk_d[l_ac].xmdk007,g_xmdk_d[l_ac].xmdk007_desc, 
       g_xmdk_d[l_ac].xmdk000,g_xmdk_d[l_ac].xmdkdocdt,g_xmdk_d[l_ac].xmdk001,g_xmdk_d[l_ac].xmdldocno, 
       g_xmdk_d[l_ac].xmdlseq,g_xmdk_d[l_ac].xmdk003,g_xmdk_d[l_ac].xmdk003_desc,g_xmdk_d[l_ac].xmdk004, 
       g_xmdk_d[l_ac].xmdk004_desc,g_xmdk_d[l_ac].xmdl014,g_xmdk_d[l_ac].xmdl014_desc,g_xmdk_d[l_ac].xmdl008, 
       g_xmdk_d[l_ac].imaal003,g_xmdk_d[l_ac].imaal004,g_xmdk_d[l_ac].xmdl007,g_xmdk_d[l_ac].imag011, 
       g_xmdk_d[l_ac].imag011_desc,g_xmdk_d[l_ac].pmaa091,g_xmdk_d[l_ac].pmaa091_desc,g_xmdk_d[l_ac].glcc003, 
       g_xmdk_d[l_ac].glcc003_desc,g_xmdk_d[l_ac].xmdl018,g_xmdk_d[l_ac].xmdl022,g_xmdk_d[l_ac].xmdl038, 
       g_xmdk_d[l_ac].l_xmdl0381,g_xmdk_d[l_ac].xmdl053,g_xmdk_d[l_ac].xmdl047,g_xmdk_d[l_ac].l_xmdl022diff, 
       g_xmdk_d[l_ac].xmdk016,g_xmdk_d[l_ac].xmdl003,g_xmdk_d[l_ac].xmdl004,g_xmdk_d[l_ac].xmdl049,g_xmdk_d[l_ac].xmdk017, 
       g_xmdk_d[l_ac].xmdl025,g_xmdk_d[l_ac].xmdl026,g_xmdk_d[l_ac].xmdl024,g_xmdk_d[l_ac].l_xmdl0272, 
       g_xmdk_d[l_ac].l_xmdl0292,g_xmdk_d[l_ac].l_xmdl0282,g_xmdk_d[l_ac].xmdl027,g_xmdk_d[l_ac].xmdl029, 
       g_xmdk_d[l_ac].xmdl028,g_xmdk_d[l_ac].xrcb103,g_xmdk_d[l_ac].xrcb104,g_xmdk_d[l_ac].xrcb105,g_xmdk_d[l_ac].xrcf103, 
       g_xmdk_d[l_ac].xrcf104,g_xmdk_d[l_ac].xrcf105,g_xmdk_d[l_ac].l_xrcb103diff,g_xmdk_d[l_ac].l_xrcb104diff, 
       g_xmdk_d[l_ac].l_xrcb105diff,g_xmdk_d[l_ac].l_xmdl0271,g_xmdk_d[l_ac].l_xmdl0291,g_xmdk_d[l_ac].l_xmdl0281, 
       g_xmdk_d[l_ac].xrca101,g_xmdk_d[l_ac].xrcb113,g_xmdk_d[l_ac].xrcb114,g_xmdk_d[l_ac].xrcb115,g_xmdk_d[l_ac].xrcadocno, 
       g_xmdk_d[l_ac].xrcad2
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
 
      #end add-point
 
      CALL axrq130_detail_show("'1'")
 
      CALL axrq130_xmdk_t_mask()
 
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend =  "" 
            LET g_errparam.code   =  9035 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
 
         END IF
         EXIT FOREACH
      END IF
      LET l_ac = l_ac + 1
 
   END FOREACH
 
 
 
 
 
   #應用 qs05 樣板自動產生(Version:4)
   #+ b_fill段其他table資料取得(包含sql組成及資料填充)
 
 
 
 
 
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
 
   CALL g_xmdk_d.deleteElement(g_xmdk_d.getLength())
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
 
   LET g_error_show = 0
 
   LET g_detail_cnt = g_xmdk_d.getLength()
   LET l_ac = g_cnt
   LET g_cnt = 0
 
   #應用 qs06 樣板自動產生(Version:3)
   #+ b_fill段CURSOR釋放
   CLOSE b_fill_curs
   FREE axrq130_pb
 
 
 
 
 
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL axrq130_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL axrq130_detail_action_trans()
 
   LET l_ac = 1
   IF g_xmdk_d.getLength() > 0 THEN
      CALL axrq130_b_fill2()
   END IF
 
      CALL axrq130_filter_show('xmdk007','b_xmdk007')
   CALL axrq130_filter_show('xmdk000','b_xmdk000')
   CALL axrq130_filter_show('xmdkdocdt','b_xmdkdocdt')
   CALL axrq130_filter_show('xmdk001','b_xmdk001')
   CALL axrq130_filter_show('xmdldocno','b_xmdldocno')
   CALL axrq130_filter_show('xmdlseq','b_xmdlseq')
   CALL axrq130_filter_show('xmdl014','b_xmdl014')
   CALL axrq130_filter_show('xmdl008','b_xmdl008')
   CALL axrq130_filter_show('xmdl007','b_xmdl007')
   CALL axrq130_filter_show('glcc003','b_glcc003')
   CALL axrq130_filter_show('xmdl018','b_xmdl018')
   CALL axrq130_filter_show('xmdl022','b_xmdl022')
   CALL axrq130_filter_show('xmdl038','b_xmdl038')
   CALL axrq130_filter_show('xmdl053','b_xmdl053')
   CALL axrq130_filter_show('xmdl047','b_xmdl047')
   CALL axrq130_filter_show('xmdk016','b_xmdk016')
   CALL axrq130_filter_show('xmdl003','b_xmdl003')
   CALL axrq130_filter_show('xmdl004','b_xmdl004')
   CALL axrq130_filter_show('xmdl049','b_xmdl049')
   CALL axrq130_filter_show('xmdk017','b_xmdk017')
   CALL axrq130_filter_show('xmdl025','b_xmdl025')
   CALL axrq130_filter_show('xmdl026','b_xmdl026')
   CALL axrq130_filter_show('xmdl024','b_xmdl024')
   CALL axrq130_filter_show('xmdl027','b_xmdl027')
   CALL axrq130_filter_show('xmdl029','b_xmdl029')
   CALL axrq130_filter_show('xmdl028','b_xmdl028')
   CALL axrq130_filter_show('xrcb103','b_xrcb103')
   CALL axrq130_filter_show('xrcb104','b_xrcb104')
   CALL axrq130_filter_show('xrcb105','b_xrcb105')
   CALL axrq130_filter_show('xrcf103','b_xrcf103')
   CALL axrq130_filter_show('xrcf104','b_xrcf104')
   CALL axrq130_filter_show('xrcf105','b_xrcf105')
   CALL axrq130_filter_show('xrca101','b_xrca101')
   CALL axrq130_filter_show('xrcb113','b_xrcb113')
   CALL axrq130_filter_show('xrcb114','b_xrcb114')
   CALL axrq130_filter_show('xrcb115','b_xrcb115')
   CALL axrq130_filter_show('xrcadocno','b_xrcadocno')
 
 
END FUNCTION
 
{</section>}
 
{<section id="axrq130.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axrq130_b_fill2()
   #add-point:b_fill2段define-客製 name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
 
   #end add-point
 
   #add-point:FUNCTION前置處理 name="b_fill2.before_function"
   
   #end add-point
 
   LET li_ac = l_ac
 
   #單身組成
   #應用 qs07 樣板自動產生(Version:7)
   #+ b_fill2段table資料取得(包含sql組成及資料填充)
 
   #add-point:陣列清空 name="b_fill2.array_clear"
 
   #end add-point
 
 
 
 
   #add-point:陣列長度調整 name="b_fill2.array_deleteElement"
 
   #end add-point
 
 
   DISPLAY li_ac TO FORMONLY.cnt
   LET g_detail_idx2 = 1
   DISPLAY g_detail_idx2 TO FORMONLY.idx
 
 
 
 
 
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
 
   LET l_ac = li_ac
 
END FUNCTION
 
{</section>}
 
{<section id="axrq130.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION axrq130_detail_show(ps_page)
   #add-point:show段define-客製 name="detail_show.define_customerization"
   
   #end add-point
   DEFINE ps_page    STRING
   DEFINE ls_sql     STRING
   #add-point:show段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_show.define"
   
   #end add-point
 
   #add-point:detail_show段之前 name="detail_show.before"
   
   #end add-point
 
   
 
   #讀入ref值
   IF ps_page.getIndexOf("'1'",1) > 0 THEN
      #帶出公用欄位reference值page1
      
 
      #add-point:show段單身reference name="detail_show.body.reference"
      
      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axrq130.filter" >}
#應用 qs13 樣板自動產生(Version:8)
#+ filter段相關程式段
#+ filter過濾功能
PRIVATE FUNCTION axrq130_filter()
   #add-point:filter段define-客製 name="filter.define_customerization"
   
   #end add-point
   DEFINE  ls_result   STRING
   #add-point:filter段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter.define"
   DEFINE l_ld_str      STRING                #161111-00049#1 Add
   DEFINE l_glaa004     LIKE glaa_t.glaa004   #161111-00049#1 Add

   #end add-point
 
   #add-point:FUNCTION前置處理 name="filter.before_function"
   
   #end add-point
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", TRUE)
 
   
 
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
 
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   #應用 qs08 樣板自動產生(Version:5)
   #+ filter段DIALOG段的組成
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單頭
      CONSTRUCT g_wc_filter ON xmdk007,xmdk000,xmdkdocdt,xmdk001,xmdldocno,xmdlseq,xmdl014,xmdl008,xmdl007, 
          glcc003,xmdl018,xmdl022,xmdl038,xmdl053,xmdl047,xmdk016,xmdl003,xmdl004,xmdl049,xmdk017,xmdl025, 
          xmdl026,xmdl024,xmdl027,xmdl029,xmdl028,xrcb103,xrcb104,xrcb105,xrcf103,xrcf104,xrcf105,xrca101, 
          xrcb113,xrcb114,xrcb115,xrcadocno
                          FROM s_detail1[1].b_xmdk007,s_detail1[1].b_xmdk000,s_detail1[1].b_xmdkdocdt, 
                              s_detail1[1].b_xmdk001,s_detail1[1].b_xmdldocno,s_detail1[1].b_xmdlseq, 
                              s_detail1[1].b_xmdl014,s_detail1[1].b_xmdl008,s_detail1[1].b_xmdl007,s_detail1[1].b_glcc003, 
                              s_detail1[1].b_xmdl018,s_detail1[1].b_xmdl022,s_detail1[1].b_xmdl038,s_detail1[1].b_xmdl053, 
                              s_detail1[1].b_xmdl047,s_detail1[1].b_xmdk016,s_detail1[1].b_xmdl003,s_detail1[1].b_xmdl004, 
                              s_detail1[1].b_xmdl049,s_detail1[1].b_xmdk017,s_detail1[1].b_xmdl025,s_detail1[1].b_xmdl026, 
                              s_detail1[1].b_xmdl024,s_detail1[1].b_xmdl027,s_detail1[1].b_xmdl029,s_detail1[1].b_xmdl028, 
                              s_detail1[1].b_xrcb103,s_detail1[1].b_xrcb104,s_detail1[1].b_xrcb105,s_detail1[1].b_xrcf103, 
                              s_detail1[1].b_xrcf104,s_detail1[1].b_xrcf105,s_detail1[1].b_xrca101,s_detail1[1].b_xrcb113, 
                              s_detail1[1].b_xrcb114,s_detail1[1].b_xrcb115,s_detail1[1].b_xrcadocno 
 
 
         BEFORE CONSTRUCT
                     DISPLAY axrq130_filter_parser('xmdk007') TO s_detail1[1].b_xmdk007
            DISPLAY axrq130_filter_parser('xmdk000') TO s_detail1[1].b_xmdk000
            DISPLAY axrq130_filter_parser('xmdkdocdt') TO s_detail1[1].b_xmdkdocdt
            DISPLAY axrq130_filter_parser('xmdk001') TO s_detail1[1].b_xmdk001
            DISPLAY axrq130_filter_parser('xmdldocno') TO s_detail1[1].b_xmdldocno
            DISPLAY axrq130_filter_parser('xmdlseq') TO s_detail1[1].b_xmdlseq
            DISPLAY axrq130_filter_parser('xmdl014') TO s_detail1[1].b_xmdl014
            DISPLAY axrq130_filter_parser('xmdl008') TO s_detail1[1].b_xmdl008
            DISPLAY axrq130_filter_parser('xmdl007') TO s_detail1[1].b_xmdl007
            DISPLAY axrq130_filter_parser('glcc003') TO s_detail1[1].b_glcc003
            DISPLAY axrq130_filter_parser('xmdl018') TO s_detail1[1].b_xmdl018
            DISPLAY axrq130_filter_parser('xmdl022') TO s_detail1[1].b_xmdl022
            DISPLAY axrq130_filter_parser('xmdl038') TO s_detail1[1].b_xmdl038
            DISPLAY axrq130_filter_parser('xmdl053') TO s_detail1[1].b_xmdl053
            DISPLAY axrq130_filter_parser('xmdl047') TO s_detail1[1].b_xmdl047
            DISPLAY axrq130_filter_parser('xmdk016') TO s_detail1[1].b_xmdk016
            DISPLAY axrq130_filter_parser('xmdl003') TO s_detail1[1].b_xmdl003
            DISPLAY axrq130_filter_parser('xmdl004') TO s_detail1[1].b_xmdl004
            DISPLAY axrq130_filter_parser('xmdl049') TO s_detail1[1].b_xmdl049
            DISPLAY axrq130_filter_parser('xmdk017') TO s_detail1[1].b_xmdk017
            DISPLAY axrq130_filter_parser('xmdl025') TO s_detail1[1].b_xmdl025
            DISPLAY axrq130_filter_parser('xmdl026') TO s_detail1[1].b_xmdl026
            DISPLAY axrq130_filter_parser('xmdl024') TO s_detail1[1].b_xmdl024
            DISPLAY axrq130_filter_parser('xmdl027') TO s_detail1[1].b_xmdl027
            DISPLAY axrq130_filter_parser('xmdl029') TO s_detail1[1].b_xmdl029
            DISPLAY axrq130_filter_parser('xmdl028') TO s_detail1[1].b_xmdl028
            DISPLAY axrq130_filter_parser('xrcb103') TO s_detail1[1].b_xrcb103
            DISPLAY axrq130_filter_parser('xrcb104') TO s_detail1[1].b_xrcb104
            DISPLAY axrq130_filter_parser('xrcb105') TO s_detail1[1].b_xrcb105
            DISPLAY axrq130_filter_parser('xrcf103') TO s_detail1[1].b_xrcf103
            DISPLAY axrq130_filter_parser('xrcf104') TO s_detail1[1].b_xrcf104
            DISPLAY axrq130_filter_parser('xrcf105') TO s_detail1[1].b_xrcf105
            DISPLAY axrq130_filter_parser('xrca101') TO s_detail1[1].b_xrca101
            DISPLAY axrq130_filter_parser('xrcb113') TO s_detail1[1].b_xrcb113
            DISPLAY axrq130_filter_parser('xrcb114') TO s_detail1[1].b_xrcb114
            DISPLAY axrq130_filter_parser('xrcb115') TO s_detail1[1].b_xrcb115
            DISPLAY axrq130_filter_parser('xrcadocno') TO s_detail1[1].b_xrcadocno
 
 
         #單身公用欄位開窗相關處理
         
 
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<xmdksite>>----
         #----<<b_xmdk007>>----
         #Ctrlp:construct.c.page1.b_xmdk007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmdk007
            #add-point:ON ACTION controlp INFIELD b_xmdk007 name="construct.c.filter.page1.b_xmdk007"
            #161111-00049#1 Add  ---(S)---
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE  
            LET g_qryparam.arg1  = 'ALL'    
            LET g_qryparam.where = " pmaa001 IN (SELECT pmab001 FROM pmab_t WHERE pmabent = ",g_enterprise,
                                                " AND pmabsite IN (SELECT ooef001 FROM ooef_t,glaa_t WHERE ooefent = glaaent AND glaacomp = ooef017 AND glaaent = ",g_enterprise," AND glaald = '",g_xrca_m.xrcald,"')) "
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_qryparam.where ," AND pmaa001 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"
            END IF
            LET g_qryparam.arg1="('2','3')"
            CALL q_pmaa001_1()
            DISPLAY g_qryparam.return1 TO b_xmdk007        #顯示到畫面上
            NEXT FIELD b_xmdk007                           #返回原欄位
            #161111-00049#1 Add  ---(E)---
            #END add-point
 
 
         #----<<xmdk007_desc>>----
         #----<<b_xmdk000>>----
         #Ctrlp:construct.c.filter.page1.b_xmdk000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmdk000
            #add-point:ON ACTION controlp INFIELD b_xmdk000 name="construct.c.filter.page1.b_xmdk000"
            
            #END add-point
 
 
         #----<<b_xmdkdocdt>>----
         #Ctrlp:construct.c.filter.page1.b_xmdkdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmdkdocdt
            #add-point:ON ACTION controlp INFIELD b_xmdkdocdt name="construct.c.filter.page1.b_xmdkdocdt"
            
            #END add-point
 
 
         #----<<b_xmdk001>>----
         #Ctrlp:construct.c.filter.page1.b_xmdk001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmdk001
            #add-point:ON ACTION controlp INFIELD b_xmdk001 name="construct.c.filter.page1.b_xmdk001"
            
            #END add-point
 
 
         #----<<b_xmdldocno>>----
         #Ctrlp:construct.c.filter.page1.b_xmdldocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmdldocno
            #add-point:ON ACTION controlp INFIELD b_xmdldocno name="construct.c.filter.page1.b_xmdldocno"
            
            #END add-point
 
 
         #----<<b_xmdlseq>>----
         #Ctrlp:construct.c.filter.page1.b_xmdlseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmdlseq
            #add-point:ON ACTION controlp INFIELD b_xmdlseq name="construct.c.filter.page1.b_xmdlseq"
            
            #END add-point
 
 
         #----<<b_xmdk003>>----
         #----<<b_xmdk003_desc>>----
         #----<<b_xmdk004>>----
         #----<<b_xmdk004_desc>>----
         #----<<b_xmdl014>>----
         #Ctrlp:construct.c.page1.b_xmdl014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmdl014
            #add-point:ON ACTION controlp INFIELD b_xmdl014 name="construct.c.filter.page1.b_xmdl014"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inaa001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xmdl014  #顯示到畫面上
            NEXT FIELD b_xmdl014                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_xmdl014_desc>>----
         #----<<b_xmdl008>>----
         #Ctrlp:construct.c.page1.b_xmdl008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmdl008
            #add-point:ON ACTION controlp INFIELD b_xmdl008 name="construct.c.filter.page1.b_xmdl008"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
           #CALL q_imaa001()                           #呼叫開窗    #161111-00049#1 Mark
		  	   #161111-00049#1 Add  ---(S)---
            LET g_qryparam.arg1 = g_glaa.glaacomp
            IF NOT cl_null(g_sql_ctrl2) AND NOT g_sql_ctrl2 = ' 1=1'  THEN
               LET g_qryparam.where = g_sql_ctrl2
            END IF
            LET g_qryparam.arg1 = g_glaa.glaacomp
            CALL q_imaf001_7()                                     #呼叫開窗
		  	   #161111-00049#1 Add  ---(E)---
            DISPLAY g_qryparam.return1 TO b_xmdl008  #顯示到畫面上
            NEXT FIELD b_xmdl008                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_imaal003>>----
         #----<<b_imaal004>>----
         #----<<b_xmdl007>>----
         #Ctrlp:construct.c.filter.page1.b_xmdl007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmdl007
            #add-point:ON ACTION controlp INFIELD b_xmdl007 name="construct.c.filter.page1.b_xmdl007"
            
            #END add-point
 
 
         #----<<b_imag011>>----
         #----<<imag011_desc>>----
         #----<<b_pmaa091>>----
         #----<<pmaa091_desc>>----
         #----<<b_glcc003>>----
         #Ctrlp:construct.c.filter.page1.b_glcc003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glcc003
            #add-point:ON ACTION controlp INFIELD b_glcc003 name="construct.c.filter.page1.b_glcc003"
            #161111-00049#1 Add  ---(S)---
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            SELECT glaa004 INTO l_glaa004 FROM glaa_t WHERE glaaent = g_enterprise
               AND glaacomp IN (SELECT glaacomp FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_xrca_m.xrcald)
               AND glaa014 = 'Y'
			   LET g_qryparam.where = " glac001 = '",l_glaa004,"'"
            CALL aglt310_04()                        #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glcc003  #顯示到畫面上

            NEXT FIELD b_glcc003                     #返回原欄位
            #161111-00049#1 Add  ---(E)---

            #END add-point
 
 
         #----<<glcc003_desc>>----
         #----<<b_xmdl018>>----
         #Ctrlp:construct.c.filter.page1.b_xmdl018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmdl018
            #add-point:ON ACTION controlp INFIELD b_xmdl018 name="construct.c.filter.page1.b_xmdl018"
            
            #END add-point
 
 
         #----<<b_xmdl022>>----
         #Ctrlp:construct.c.filter.page1.b_xmdl022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmdl022
            #add-point:ON ACTION controlp INFIELD b_xmdl022 name="construct.c.filter.page1.b_xmdl022"
            
            #END add-point
 
 
         #----<<b_xmdl038>>----
         #Ctrlp:construct.c.filter.page1.b_xmdl038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmdl038
            #add-point:ON ACTION controlp INFIELD b_xmdl038 name="construct.c.filter.page1.b_xmdl038"
            
            #END add-point
 
 
         #----<<l_xmdl0381>>----
         #----<<b_xmdl053>>----
         #Ctrlp:construct.c.filter.page1.b_xmdl053
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmdl053
            #add-point:ON ACTION controlp INFIELD b_xmdl053 name="construct.c.filter.page1.b_xmdl053"
            
            #END add-point
 
 
         #----<<b_xmdl047>>----
         #Ctrlp:construct.c.filter.page1.b_xmdl047
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmdl047
            #add-point:ON ACTION controlp INFIELD b_xmdl047 name="construct.c.filter.page1.b_xmdl047"
            
            #END add-point
 
 
         #----<<l_xmdl022diff>>----
         #----<<b_xmdk016>>----
         #Ctrlp:construct.c.page1.b_xmdk016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmdk016
            #add-point:ON ACTION controlp INFIELD b_xmdk016 name="construct.c.filter.page1.b_xmdk016"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xmdk016  #顯示到畫面上
            NEXT FIELD b_xmdk016                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_xmdl003>>----
         #Ctrlp:construct.c.filter.page1.b_xmdl003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmdl003
            #add-point:ON ACTION controlp INFIELD b_xmdl003 name="construct.c.filter.page1.b_xmdl003"
            
            #END add-point
 
 
         #----<<b_xmdl004>>----
         #Ctrlp:construct.c.filter.page1.b_xmdl004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmdl004
            #add-point:ON ACTION controlp INFIELD b_xmdl004 name="construct.c.filter.page1.b_xmdl004"
            
            #END add-point
 
 
         #----<<b_xmdl049>>----
         #Ctrlp:construct.c.filter.page1.b_xmdl049
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmdl049
            #add-point:ON ACTION controlp INFIELD b_xmdl049 name="construct.c.filter.page1.b_xmdl049"
            
            #END add-point
 
 
         #----<<b_xmdk017>>----
         #Ctrlp:construct.c.filter.page1.b_xmdk017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmdk017
            #add-point:ON ACTION controlp INFIELD b_xmdk017 name="construct.c.filter.page1.b_xmdk017"
            
            #END add-point
 
 
         #----<<b_xmdl025>>----
         #Ctrlp:construct.c.page1.b_xmdl025
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmdl025
            #add-point:ON ACTION controlp INFIELD b_xmdl025 name="construct.c.filter.page1.b_xmdl025"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oodb002_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xmdl025  #顯示到畫面上
            NEXT FIELD b_xmdl025                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_xmdl026>>----
         #Ctrlp:construct.c.filter.page1.b_xmdl026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmdl026
            #add-point:ON ACTION controlp INFIELD b_xmdl026 name="construct.c.filter.page1.b_xmdl026"
            
            #END add-point
 
 
         #----<<b_xmdl024>>----
         #Ctrlp:construct.c.filter.page1.b_xmdl024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmdl024
            #add-point:ON ACTION controlp INFIELD b_xmdl024 name="construct.c.filter.page1.b_xmdl024"
            
            #END add-point
 
 
         #----<<l_xmdl0272>>----
         #----<<l_xmdl0292>>----
         #----<<l_xmdl0282>>----
         #----<<b_xmdl027>>----
         #Ctrlp:construct.c.filter.page1.b_xmdl027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmdl027
            #add-point:ON ACTION controlp INFIELD b_xmdl027 name="construct.c.filter.page1.b_xmdl027"
            
            #END add-point
 
 
         #----<<b_xmdl029>>----
         #Ctrlp:construct.c.filter.page1.b_xmdl029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmdl029
            #add-point:ON ACTION controlp INFIELD b_xmdl029 name="construct.c.filter.page1.b_xmdl029"
            
            #END add-point
 
 
         #----<<b_xmdl028>>----
         #Ctrlp:construct.c.filter.page1.b_xmdl028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmdl028
            #add-point:ON ACTION controlp INFIELD b_xmdl028 name="construct.c.filter.page1.b_xmdl028"
            
            #END add-point
 
 
         #----<<b_xrcb103>>----
         #Ctrlp:construct.c.filter.page1.b_xrcb103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrcb103
            #add-point:ON ACTION controlp INFIELD b_xrcb103 name="construct.c.filter.page1.b_xrcb103"
            
            #END add-point
 
 
         #----<<b_xrcb104>>----
         #Ctrlp:construct.c.filter.page1.b_xrcb104
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrcb104
            #add-point:ON ACTION controlp INFIELD b_xrcb104 name="construct.c.filter.page1.b_xrcb104"
            
            #END add-point
 
 
         #----<<b_xrcb105>>----
         #Ctrlp:construct.c.filter.page1.b_xrcb105
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrcb105
            #add-point:ON ACTION controlp INFIELD b_xrcb105 name="construct.c.filter.page1.b_xrcb105"
            
            #END add-point
 
 
         #----<<b_xrcf103>>----
         #Ctrlp:construct.c.filter.page1.b_xrcf103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrcf103
            #add-point:ON ACTION controlp INFIELD b_xrcf103 name="construct.c.filter.page1.b_xrcf103"
            
            #END add-point
 
 
         #----<<b_xrcf104>>----
         #Ctrlp:construct.c.filter.page1.b_xrcf104
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrcf104
            #add-point:ON ACTION controlp INFIELD b_xrcf104 name="construct.c.filter.page1.b_xrcf104"
            
            #END add-point
 
 
         #----<<b_xrcf105>>----
         #Ctrlp:construct.c.filter.page1.b_xrcf105
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrcf105
            #add-point:ON ACTION controlp INFIELD b_xrcf105 name="construct.c.filter.page1.b_xrcf105"
            
            #END add-point
 
 
         #----<<l_xrcb103diff>>----
         #----<<l_xrcb104diff>>----
         #----<<l_xrcb105diff>>----
         #----<<l_xmdl0271>>----
         #----<<l_xmdl0291>>----
         #----<<l_xmdl0281>>----
         #----<<b_xrca101>>----
         #Ctrlp:construct.c.filter.page1.b_xrca101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrca101
            #add-point:ON ACTION controlp INFIELD b_xrca101 name="construct.c.filter.page1.b_xrca101"
            
            #END add-point
 
 
         #----<<b_xrcb113>>----
         #Ctrlp:construct.c.filter.page1.b_xrcb113
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrcb113
            #add-point:ON ACTION controlp INFIELD b_xrcb113 name="construct.c.filter.page1.b_xrcb113"
            
            #END add-point
 
 
         #----<<b_xrcb114>>----
         #Ctrlp:construct.c.filter.page1.b_xrcb114
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrcb114
            #add-point:ON ACTION controlp INFIELD b_xrcb114 name="construct.c.filter.page1.b_xrcb114"
            
            #END add-point
 
 
         #----<<b_xrcb115>>----
         #Ctrlp:construct.c.filter.page1.b_xrcb115
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrcb115
            #add-point:ON ACTION controlp INFIELD b_xrcb115 name="construct.c.filter.page1.b_xrcb115"
            
            #END add-point
 
 
         #----<<b_xrcadocno>>----
         #Ctrlp:construct.c.page1.b_xrcadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrcadocno
            #add-point:ON ACTION controlp INFIELD b_xrcadocno name="construct.c.filter.page1.b_xrcadocno"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " xrcald = '",g_xrca_m.xrcald,"'"             #161111-00049#1 Add
            CALL q_xrcadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xrcadocno  #顯示到畫面上
            NEXT FIELD b_xrcadocno                     #返回原欄位

            #END add-point
 
 
         #----<<b_xrcad2>>----
 
 
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
 
 
 
 
 
   
 
   #add-point:離開DIALOG後相關處理 name="filter.after_dialog"
   
   #end add-point
 
   IF NOT INT_FLAG THEN
      LET g_wc_filter = g_wc_filter, " "
   ELSE
      LET g_wc_filter = g_wc_filter_t
   END IF
 
      CALL axrq130_filter_show('xmdk007','b_xmdk007')
   CALL axrq130_filter_show('xmdk000','b_xmdk000')
   CALL axrq130_filter_show('xmdkdocdt','b_xmdkdocdt')
   CALL axrq130_filter_show('xmdk001','b_xmdk001')
   CALL axrq130_filter_show('xmdldocno','b_xmdldocno')
   CALL axrq130_filter_show('xmdlseq','b_xmdlseq')
   CALL axrq130_filter_show('xmdl014','b_xmdl014')
   CALL axrq130_filter_show('xmdl008','b_xmdl008')
   CALL axrq130_filter_show('xmdl007','b_xmdl007')
   CALL axrq130_filter_show('glcc003','b_glcc003')
   CALL axrq130_filter_show('xmdl018','b_xmdl018')
   CALL axrq130_filter_show('xmdl022','b_xmdl022')
   CALL axrq130_filter_show('xmdl038','b_xmdl038')
   CALL axrq130_filter_show('xmdl053','b_xmdl053')
   CALL axrq130_filter_show('xmdl047','b_xmdl047')
   CALL axrq130_filter_show('xmdk016','b_xmdk016')
   CALL axrq130_filter_show('xmdl003','b_xmdl003')
   CALL axrq130_filter_show('xmdl004','b_xmdl004')
   CALL axrq130_filter_show('xmdl049','b_xmdl049')
   CALL axrq130_filter_show('xmdk017','b_xmdk017')
   CALL axrq130_filter_show('xmdl025','b_xmdl025')
   CALL axrq130_filter_show('xmdl026','b_xmdl026')
   CALL axrq130_filter_show('xmdl024','b_xmdl024')
   CALL axrq130_filter_show('xmdl027','b_xmdl027')
   CALL axrq130_filter_show('xmdl029','b_xmdl029')
   CALL axrq130_filter_show('xmdl028','b_xmdl028')
   CALL axrq130_filter_show('xrcb103','b_xrcb103')
   CALL axrq130_filter_show('xrcb104','b_xrcb104')
   CALL axrq130_filter_show('xrcb105','b_xrcb105')
   CALL axrq130_filter_show('xrcf103','b_xrcf103')
   CALL axrq130_filter_show('xrcf104','b_xrcf104')
   CALL axrq130_filter_show('xrcf105','b_xrcf105')
   CALL axrq130_filter_show('xrca101','b_xrca101')
   CALL axrq130_filter_show('xrcb113','b_xrcb113')
   CALL axrq130_filter_show('xrcb114','b_xrcb114')
   CALL axrq130_filter_show('xrcb115','b_xrcb115')
   CALL axrq130_filter_show('xrcadocno','b_xrcadocno')
 
 
   CALL axrq130_b_fill()
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="axrq130.filter_parser" >}
#應用 qs14 樣板自動產生(Version:6)
#+ filter pasara段
#+ filter欄位解析
PRIVATE FUNCTION axrq130_filter_parser(ps_field)
   #add-point:filter段define-客製 name="filter_parser.define_customerization"
   
   #end add-point
   {<Local define>}
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num5
   DEFINE li_tmp2    LIKE type_t.num5
   DEFINE ls_var     STRING
   {</Local define>}
   #add-point:filter段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter_parser.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="filter_parser.before_function"
   
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
 
{<section id="axrq130.filter_show" >}
#應用 qs15 樣板自動產生(Version:6)
#+ filter標題欄位顯示搜尋條件
PRIVATE FUNCTION axrq130_filter_show(ps_field,ps_object)
   #add-point:filter_show段define-客製 name="filter_show.define_customerization"
   
   #end add-point
   DEFINE ps_field         STRING
   DEFINE ps_object        STRING
   DEFINE lnode_item       om.DomNode
   DEFINE ls_title         STRING
   DEFINE ls_name          STRING
   DEFINE ls_condition     STRING
   #add-point:filter_show段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter_show.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="filter_show.before_function"
   
   #end add-point
 
   LET ls_name = "formonly.", ps_object
 
 
   LET lnode_item = gfrm_curr.findNode("TableColumn", ls_name)
   LET ls_title = lnode_item.getAttribute("text")
   IF ls_title.getIndexOf('※',1) > 0 THEN
      LET ls_title = ls_title.subString(1,ls_title.getIndexOf('※',1)-1)
   END IF
 
   #顯示資料組合
   LET ls_condition = axrq130_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
 
{</section>}
 
{<section id="axrq130.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION axrq130_detail_action_trans()
   #add-point:detail_action_trans段define-客製 name="detail_action_trans.define_customerization"
   
   #end add-point
   #add-point:detail_action_trans段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_action_trans.define"
   
   #end add-point
 
 
   #add-point:FUNCTION前置處理 name="detail_action_trans.before_function"
   
   #end add-point
 
   #因應單身切頁功能，筆數計算方式調整
   LET g_current_row_tot = g_pagestart + g_detail_idx - 1
   DISPLAY g_current_row_tot TO FORMONLY.h_index
   DISPLAY g_tot_cnt TO FORMONLY.h_count
 
   #顯示單身頁面的起始與結束筆數
   LET g_page_start_num = g_pagestart
   LET g_page_end_num = g_pagestart + g_num_in_page - 1
   DISPLAY g_page_start_num TO FORMONLY.p_start
   DISPLAY g_page_end_num TO FORMONLY.p_end
 
   #目前不支援跳頁功能
   LET g_page_act_list = "detail_first,detail_previous,'',detail_next,detail_last"
   CALL cl_navigator_detail_page_setting(g_page_act_list,g_current_row_tot,g_pagestart,g_num_in_page,g_tot_cnt)
 
END FUNCTION
 
{</section>}
 
{<section id="axrq130.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION axrq130_detail_index_setting()
   #add-point:detail_index_setting段define-客製 name="detail_index_setting.define_customerization"
   
   #end add-point
   DEFINE li_redirect     BOOLEAN
   DEFINE ldig_curr       ui.Dialog
   #add-point:detail_index_setting段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_index_setting.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="detail_index_setting.before_function"
   
   #end add-point
 
   IF g_curr_diag IS NOT NULL THEN
      CASE
         WHEN g_curr_diag.getCurrentRow("s_detail1") <= "0"
            LET g_detail_idx = 1
            IF g_xmdk_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_xmdk_d.getLength() AND g_xmdk_d.getLength() > 0
            LET g_detail_idx = g_xmdk_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_xmdk_d.getLength() THEN
               LET g_detail_idx = g_xmdk_d.getLength()
            END IF
            LET li_redirect = TRUE
      END CASE
   END IF
 
   IF li_redirect THEN
      LET ldig_curr = ui.Dialog.getCurrent()
      CALL ldig_curr.setCurrentRow("s_detail1", g_detail_idx)
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="axrq130.mask_functions" >}
 &include "erp/axr/axrq130_mask.4gl"
 
{</section>}
 
{<section id="axrq130.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 獲取預設帳務中心、帳套及法人
# Memo...........:
# Usage..........: CALL axrq130_def()
# Input parameter:  
# Return code....:  
# Date & Author..: 2014/7/18 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION axrq130_def()
   DEFINE l_sql         STRING
   DEFINE l_xrcasite    LIKE xrca_t.xrcasite
   DEFINE l_success     LIKE type_t.chr1
   DEFINE l_cnt         LIKE type_t.num5
   DEFINE l_ooefl003    LIKE ooefl_t.ooefl003
   
   IF cl_null(g_xrca_m.xrcasite) OR cl_null(g_xrca_m.xrcald) THEN
      #帳務中心
      #取得預設的帳務中心,因新增階段的時候,並不會知道site,所以以登入人員做為依據
      CALL s_fin_get_account_center('',g_user,'3',g_today) RETURNING l_success,g_xrca_m.xrcasite,g_errno
      #該帳務中心與帳別無法勾稽到,以登入人員g_user取得預設帳別/法人
      CALL s_fin_orga_get_comp_ld(g_xrca_m.xrcasite) RETURNING l_success,g_errno,g_xrca_m.xrcacomp,g_xrca_m.xrcald   

      #若取不出資料，則預設帳別/法人為空
      IF NOT l_success THEN
         LET g_xrca_m.xrcald   = ''
         LET g_xrca_m.xrcacomp = ''
      END IF

      #用帳務中心取得帳別與法人
      IF cl_null(g_xrca_m.xrcald) THEN
         CALL s_fin_orga_get_comp_ld(g_xrca_m.xrcasite) RETURNING l_success,g_errno,g_xrca_m.xrcacomp,g_xrca_m.xrcald
         CALL s_fin_account_center_with_ld_chk(g_xrca_m.xrcasite,g_xrca_m.xrcald,g_user,'3','N','',g_today) RETURNING l_success,g_errno
      END IF

      #若取不出資料,則不預設帳別
      IF NOT l_success THEN
         LET g_xrca_m.xrcald   = ''
      END IF

      CALL s_axrt300_xrca_ref('xrcald',g_xrca_m.xrcald,'','') RETURNING l_success,g_xrca_m.xrcald_desc
      #161128-00061#4-----modify--begin----------
      #SELECT * INTO g_glaa.* 
       SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,
              glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,glaa011,
              glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,glaa023,
              glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,glaa113,glaa120,glaa121,
              glaa122,glaa027,glaa130,glaa131,glaa132,glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,
              glaa140,glaa123,glaa124,glaa028 INTO g_glaa.* 
      #161128-00061#4----modify--end---------- 
      FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_xrca_m.xrcald
     #161111-00049#1 Add  ---(S)---
      CALL s_control_get_customer_sql_pmab('4',g_site,g_user,g_dept,'',g_glaa.glaacomp) RETURNING g_sub_success,g_sql_ctrl
      LET g_sql_ctrl2 = NULL
      CALL s_control_get_item_sql('2',g_glaa.glaacomp,g_user,g_dept,'') RETURNING g_sub_success,g_sql_ctrl2
     #161111-00049#1 Add  ---(E)---
      CALL s_axrt300_xrca_ref('xrcasite',g_xrca_m.xrcasite,'','') RETURNING l_success,g_xrca_m.xrcasite_desc
      DISPLAY BY NAME g_xrca_m.xrcasite,g_xrca_m.xrcasite_desc,g_xrca_m.xrcald,g_xrca_m.xrcald_desc
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_glaa.glaacomp
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_xrca_m.xrcacomp = g_glaa.glaacomp,'(', g_rtn_fields[1] , ')'
      DISPLAY g_xrca_m.xrcasite TO xrcasite
      DISPLAY g_xrca_m.xrcasite_desc TO xrcasite_desc 
      DISPLAY g_xrca_m.xrcald TO xrcald 
      DISPLAY g_xrca_m.xrcald_desc TO xrcald_desc
      DISPLAY g_xrca_m.xrcacomp TO xrcacomp   
   END IF

   IF cl_null(g_xrca_m.type)  THEN LET g_xrca_m.type = '1' END IF
   LET g_xrca_m.type1 = g_xrca_m.type   #160802-00036#1 Add

   IF cl_null(g_xrca_m.b_check)  THEN LET g_xrca_m.b_check = 'N' END IF

   #14/12/23
   LET g_xrcasite_t = g_xrca_m.xrcasite
   LET g_xrcald_t = g_xrca_m.xrcald
   #14/12/23

   DISPLAY  g_xrca_m.type TO type
END FUNCTION

################################################################################
# Descriptions...:  
# Memo...........:
# Usage..........: CALL axrq130_get_wc()
# Input parameter:  
# Return code....:  
# Date & Author..: 2014/7/18 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION axrq130_get_wc()
   DEFINE l_success   LIKE type_t.chr1
   DEFINE ls_wc       STRING
   DEFINE ls_wc1      STRING

   #取得帳務組織下所屬成員
   CALL s_fin_account_center_sons_query('3',g_xrca_m.xrcasite,g_today,'1')
   #取得帳務組織下所屬成員之帳別   
   #CALL s_fin_account_center_comp_str() RETURNING ls_wc   #170109-00006#1 mark lujh
   CALL s_fin_account_center_sons_str() RETURNING ls_wc    #170109-00006#1 add lujh
   #將取回的字串轉換為SQL條件
   CALL axrq130_get_ooef001_wc(ls_wc) RETURNING ls_wc  

  #g_xrca_m.type:
  #1 未匹配账款
  #2 已匹配账款
  #3 全部
  #4 已立暫估未立帳
  #5 未立暫估且未立帳

   CALL s_axrt300_sel_ld(g_xrca_m.xrcald) RETURNING l_success,g_flag
   LET ls_wc1 = ""
   LET g_wc1 = ""
   CASE
      WHEN g_argv[1] = '1'   #axrq130
         #出貨單、銷售單
         CASE g_xrca_m.type 
           WHEN '1' 
              IF g_flag = '1' THEN LET ls_wc1 = ' AND CASE WHEN xmdl022 IS NULL THEN 0 ELSE xmdl022 END <> CASE WHEN xmdl038 IS NULL THEN 0 ELSE xmdl038 END ' END IF
              IF g_flag = '2' THEN LET ls_wc1 = ' AND CASE WHEN xmdl022 IS NULL THEN 0 ELSE xmdl022 END <> CASE WHEN xmdl039 IS NULL THEN 0 ELSE xmdl039 END ' END IF
              IF g_flag = '3' THEN LET ls_wc1 = ' AND CASE WHEN xmdl022 IS NULL THEN 0 ELSE xmdl022 END <> CASE WHEN xmdl040 IS NULL THEN 0 ELSE xmdl040 END ' END IF         
           WHEN '2' 
              IF g_flag = '1' THEN LET ls_wc1 = ' AND CASE WHEN xmdl038 IS NULL THEN 0 ELSE xmdl038 END > 0 ' END IF
              IF g_flag = '2' THEN LET ls_wc1 = ' AND CASE WHEN xmdl039 IS NULL THEN 0 ELSE xmdl039 END > 0 ' END IF
              IF g_flag = '3' THEN LET ls_wc1 = ' AND CASE WHEN xmdl040 IS NULL THEN 0 ELSE xmdl040 END > 0 ' END IF        
           WHEN '3' LET ls_wc1 = ' AND CASE WHEN xmdl022 IS NULL THEN 0 ELSE xmdl022 END <> 0'
           WHEN '4' 
              #151102-00008#2---s
              IF g_flag = '1' THEN LET ls_wc1 = ' AND CASE WHEN xmdl022 IS NULL THEN 0 ELSE xmdl022 END <> CASE WHEN xmdl038 IS NULL THEN 0 ELSE xmdl038 END AND CASE WHEN xmdl053 IS NULL THEN 0 ELSE xmdl053 END <> 0 ' END IF
              IF g_flag = '2' THEN LET ls_wc1 = ' AND CASE WHEN xmdl022 IS NULL THEN 0 ELSE xmdl022 END <> CASE WHEN xmdl039 IS NULL THEN 0 ELSE xmdl039 END AND CASE WHEN xmdl054 IS NULL THEN 0 ELSE xmdl054 END <> 0 ' END IF
              IF g_flag = '3' THEN LET ls_wc1 = ' AND CASE WHEN xmdl022 IS NULL THEN 0 ELSE xmdl022 END <> CASE WHEN xmdl040 IS NULL THEN 0 ELSE xmdl040 END AND CASE WHEN xmdl055 IS NULL THEN 0 ELSE xmdl055 END <> 0 ' END IF 
              #151102-00008#2---e
          #160802-00036#1 Add  ---(S)---
           WHEN '5'
              IF g_flag = '1' THEN LET ls_wc1 = ' AND CASE WHEN xmdl038 IS NULL THEN 0 ELSE xmdl038 END = 0 AND CASE WHEN xmdl053 IS NULL THEN 0 ELSE xmdl053 END = 0 ' END IF
              IF g_flag = '2' THEN LET ls_wc1 = ' AND CASE WHEN xmdl039 IS NULL THEN 0 ELSE xmdl039 END = 0 AND CASE WHEN xmdl054 IS NULL THEN 0 ELSE xmdl054 END = 0 ' END IF
              IF g_flag = '3' THEN LET ls_wc1 = ' AND CASE WHEN xmdl040 IS NULL THEN 0 ELSE xmdl040 END = 0 AND CASE WHEN xmdl055 IS NULL THEN 0 ELSE xmdl055 END = 0 ' END IF 
          #160802-00036#1 Add  ---(E)---
         END CASE
      WHEN g_argv[1] = '2'   #axrq140
         #出貨單、銷售單
         CASE g_xrca_m.type 
           WHEN '1' 
              LET ls_wc1 = ' AND CASE WHEN xmdl022 IS NULL THEN 0 ELSE xmdl022 END <> CASE WHEN xmdl047 IS NULL THEN 0 ELSE xmdl047 END '        
           WHEN '2' 
              LET ls_wc1 = ' AND CASE WHEN xmdl047 IS NULL THEN 0 ELSE xmdl047 END > 0 '     
           WHEN '3' LET ls_wc1 = ' AND CASE WHEN xmdl022 IS NULL THEN 0 ELSE xmdl022 END <> 0'
           WHEN '4' 
              LET ls_wc1 = ' AND CASE WHEN xmdl022 IS NULL THEN 0 ELSE xmdl022 END <> CASE WHEN xmdl047 IS NULL THEN 0 ELSE xmdl047 END AND CASE WHEN xmdl053 IS NULL THEN 0 ELSE xmdl053 END <> 0  '        #151102-00008#2      
          #160802-00036#1 Add  ---(S)---
           WHEN '5'
              LET ls_wc1 = ' AND CASE WHEN xmdl047 IS NULL THEN 0 ELSE xmdl047 END = 0 AND CASE WHEN xmdl053 IS NULL THEN 0 ELSE xmdl053 END = 0 '
          #160802-00036#1 Add  ---(E)---
         END CASE
   END CASE

   IF cl_null(g_wc_filter) THEN
      LET g_wc_filter = " 1=1"
   END IF

   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   
   IF g_argv[1] = '1' THEN 
      #LET g_wc1 = g_wc,ls_wc1," AND xmdksite IN ('",g_xrca_m.xrcasite, "') AND xmdksite IN ",ls_wc #,"AND ", g_wc_filter CLIPPED   #161017-00011#1   Add CLIPPED," AND xmdksite IN ",ls_wc #161111-00049#1 Mark #170215-00042#1 mark
      LET g_wc1 = g_wc,ls_wc1," AND xmdksite IN ",ls_wc #,"AND ", g_wc_filter CLIPPED   #161017-00011#1   Add CLIPPED," AND xmdksite IN ",ls_wc #161111-00049#1 Mark #170215-00042#1 add
   ELSE
      LET g_wc1 = g_wc,ls_wc1," AND xmdksite IN ",ls_wc   #, " AND ", g_wc_filter   #161111-00049#1 Mark
   END IF
   #151231-00010#7--(S)
   IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
      LET g_wc1 = g_wc1,"AND xmdk007 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"
   END IF
   #151231-00010#7--(E)
END FUNCTION

################################################################################
# Descriptions...: 發票查詢條件調整
# Memo...........:
# Usage..........: CALL axrq130_mod_wc(p_wc)
# Input parameter:  
# Return code....:  
# Date & Author..: 2014/7/20 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION axrq130_mod_wc(p_wc)
DEFINE l_string       STRING 
DEFINE l_xmdk003      STRING
DEFINE l_xmdk002      STRING
DEFINE tok            base.stringtokenizer
DEFINE p_wc           STRING


      LET p_wc = cl_replace_str(p_wc,"and","||")
      LET tok = base.StringTokenizer.create(p_wc,"||")
      WHILE tok.hasMoreTokens()
         LET l_string = tok.nextToken()
         LET l_string = l_string.trim()
         IF l_string MATCHES '*xmdk003*' THEN
            LET l_xmdk003 = l_string
            LET p_wc = cl_replace_str(p_wc,l_xmdk003," 1=1")
         END IF
         IF l_string MATCHES '*xmdk002*' THEN
            LET l_xmdk002 = l_string
            LET p_wc = cl_replace_str(p_wc,l_xmdk002," 1=1")
         END IF
      END WHILE   
      
      RETURN p_wc
END FUNCTION

################################################################################
# Descriptions...: 獲取主帳套、帳套二、帳套三
# Memo...........:
# Usage..........: CALL  
# Input parameter:  
# Return code....:  
# Date & Author..:  2014/7/20 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION axrq130_sel_ld(p_ld)
DEFINE p_ld            LIKE xrca_t.xrcald
DEFINE l_ooab002       LIKE ooab_t.ooab002
DEFINE l_count         LIKE type_t.num5
   
   SELECT COUNT(1) INTO l_count FROM glaa_t #170213-00036#1 mod *-->1
    WHERE glaaent = g_enterprise
      AND glaald  = p_ld

   IF l_count > 0 THEN RETURN '1' END IF
   
   CALL cl_get_para(g_enterprise,g_xrca_m.xrcacomp,'S-FIN-0001') RETURNING l_ooab002

   IF l_ooab002 = p_ld THEN RETURN '2' END IF

   CALL cl_get_para(g_enterprise,g_xrca_m.xrcacomp,'S-FIN-0002') RETURNING l_ooab002

   IF l_ooab002 = p_ld THEN RETURN '3' END IF
   
   
END FUNCTION
################################################################################
# Descriptions...: sub產生的數據集轉換
# Memo...........: DSCNJ,DSCTP,DSCTC --> ('DSCNJ','DSCTP','DSCTC')
# Usage..........: CALL axrq130_get_ooef001_wc(p_wc)
#                  RETURNING r_wc
# Input parameter: p_wc           sub产生的数据集
# Return code....: r_wc           SQ可用的数据集
# Date & Author..: 2014/12/08 By zhangweib
# Modify.........:
################################################################################
PRIVATE FUNCTION axrq130_get_ooef001_wc(p_wc)
   DEFINE p_wc       STRING
   DEFINE r_wc       STRING
   DEFINE tok        base.StringTokenizer
   DEFINE l_str      STRING

   LET tok = base.StringTokenizer.create(p_wc,",")
   WHILE tok.hasMoreTokens()
      IF cl_null(l_str) THEN
         LET l_str = tok.nextToken()
      ELSE
         LET l_str = l_str,"','",tok.nextToken()
      END IF      
   END WHILE   
   LET r_wc = "('",l_str,"')"
   
   RETURN r_wc

END FUNCTION

################################################################################
# Descriptions...: 新建臨時表
# Modify.........:
################################################################################
PRIVATE FUNCTION axrq130_create_tmp()
  DROP TABLE axrq130_tmp01;                 #160727-00019#6   2016/07/28 By 08734   axrq130_print_tmp ——> axrq130_tmp01
      CREATE TEMP TABLE axrq130_tmp01(      #160727-00019#6   2016/07/28 By 08734   axrq130_print_tmp ——> axrq130_tmp01
   xrcasite_desc  VARCHAR(500),
   xrcald_desc  VARCHAR(500),   
   xmdksite  VARCHAR(80), 
   xmdk007  VARCHAR(80), 
   xmdk000  VARCHAR(80), 
   xmdkdocdt  DATE, 
   xmdk001  DATE, 
   xmdldocno  VARCHAR(20), 
   xmdlseq  INTEGER, 
   xmdk003  VARCHAR(20), 
   xmdk003_desc  VARCHAR(500), 
   xmdk004  VARCHAR(10), 
   xmdk004_desc  VARCHAR(500), 
   xmdl014  VARCHAR(10), 
   xmdl014_desc  VARCHAR(500), 
   xmdl008  VARCHAR(40), 
   imaal003  VARCHAR(255), 
   imaal004  VARCHAR(255), 
   l_xmdl007_desc  VARCHAR(500),          #151102-00008#2 add
   imag011  VARCHAR(10), 
   imag011_desc  VARCHAR(500), 
   pmaa091  VARCHAR(10),                #151203-00013#1 add
   pmaa091_desc  VARCHAR(500),            #151203-00013#1 add 
   glcc003  VARCHAR(24), 
   glcc003_desc  VARCHAR(500), 
   xmdl018  DECIMAL(20,6),                #161206-00017#1 add lujh
   xmdl022  DECIMAL(20,6), 
   xmdl038  DECIMAL(20,6), 
   l_xmdl0381  DECIMAL(20,6), 
   xmdl053  DECIMAL(20,6), 
   xmdl047  DECIMAL(20,6), 
   l_xmdl022diff  DECIMAL(20,6), 
   xmdk016  VARCHAR(10), 
   xmdl003  VARCHAR(20),        #150902-00001#2
   xmdl004  INTEGER,        #150902-00001#2
   xmdl049  VARCHAR(20),        #150902-00001#2
   xmdk017  DECIMAL(20,10), 
   xmdl025  VARCHAR(10), 
   xmdl026  DECIMAL(5,2), 
   xmdl024  DECIMAL(20,6), 
   l_xmdl0272  DECIMAL(20,6), 
   l_xmdl0292  DECIMAL(20,6), 
   l_xmdl0282  DECIMAL(20,6), 
   xmdl027  DECIMAL(20,6), 
   xmdl029  DECIMAL(20,6), 
   xmdl028  DECIMAL(20,6), 
   xrcb103  DECIMAL(20,6), 
   xrcb104  DECIMAL(20,6), 
   xrcb105  DECIMAL(20,6), 
   xrcf103  DECIMAL(20,6), 
   xrcf104  DECIMAL(20,6), 
   xrcf105  DECIMAL(20,6), 
   l_xrcb103diff  DECIMAL(20,6), 
   l_xrcb104diff  DECIMAL(20,6), 
   l_xrcb105diff  DECIMAL(20,6), 
   l_xmdl0271  DECIMAL(20,6), 
   l_xmdl0291  DECIMAL(20,6), 
   l_xmdl0281  DECIMAL(20,6), 
   xrca101  DECIMAL(20,10),           #161206-00017#1 add lujh
   xrcb113  DECIMAL(20,6), 
   xrcb114  DECIMAL(20,6), 
   xrcb115  DECIMAL(20,6),
   xrcadocno  VARCHAR(20),       #150924-00012#2
   xrcad2     VARCHAR(20),       #151019-00009#2
   l_argv1  VARCHAR(1)     #记录是axrq130|axrq140
   )
END FUNCTION

################################################################################
# Descriptions...: 描述说明
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
PRIVATE FUNCTION axrq130_b_ins_tmp(l_xrcasite_desc,l_xrcald_desc,l_xmdl038,l_xmdl053)
   DEFINE l_xmdl038       STRING
   DEFINE l_xrcasite_desc LIKE type_t.chr500
   DEFINE l_xrcald_desc   LIKE type_t.chr500
   DEFINE l_xmdl053       STRING
   DEFINE ls_wc           STRING
   DEFINE l_wc            STRING
   DEFINE ls_sql          RECORD
             xmdk000_desc    STRING,
             xmdk007_desc    STRING,
             xmdksite_desc   STRING,
             xmdk003_desc    STRING,
             xmdk004_desc    STRING,
             xmdl014_desc    STRING,
             imaal003        STRING,
             imaal004        STRING,
             imag011         STRING,
             pmaa091         STRING,
             xrcb021         STRING,
             xrcb021_desc    STRING,
             xmdl049         STRING,
             doc1            STRING,
             doc2            STRING,
             ctr2            STRING, #160518-00075#4
             ctr3            STRING  #160518-00075#4 
                          END RECORD
   DEFINE l_ooef004       LIKE ooef_t.ooef004 #160518-00075#4                          
   DEFINE l_ooaj004       LIKE ooaj_t.ooaj004 #170213-00036#1 add
   
  LET g_success='Y'

  #160418-00003#1 Add  ---(S)---
  #單據類別說明
   LET ls_sql.xmdk000_desc= "(SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl002 = xmdk000 AND gzcbl003 = '",g_lang,"' AND gzcbl001 = '2077')"

  #來源組織名稱
   LET ls_sql.xmdksite_desc= "(SELECT xmdksite||'('||ooefl003||')' FROM ooefl_t WHERE ooeflent = '",g_enterprise,"' AND ooefl001 = xmdksite AND ooefl002 = '",g_lang,"')"
   LET ls_sql.xmdksite_desc= "CASE WHEN ",ls_sql.xmdksite_desc," IS NULL THEN xmdksite ELSE ",ls_sql.xmdksite_desc," END"

  #交易對象名稱
   LET ls_sql.xmdk007_desc = "(SELECT CASE WHEN pmaal004 IS NULL THEN ' ' ELSE pmaal004 END FROM pmaal_t WHERE pmaalent = '",g_enterprise,"' AND pmaal001 =  xmdk007 AND pmaal002 = '",g_lang,"')"

  #人員名稱
   LET ls_sql.xmdk003_desc = "(SELECT  ooag011 FROM  ooag_t WHERE  ooagent = '",g_enterprise,"' AND  ooag001 =  xmdk003)"

  #部門名稱
   LET ls_sql.xmdk004_desc = "(SELECT ooefl003 FROM ooefl_t WHERE ooeflent = '",g_enterprise,"' AND ooefl001 =  xmdk004 AND ooefl002 = '",g_lang,"')"

  #倉庫說明
   LET ls_sql.xmdl014_desc = "(SELECT inayl003 FROM inayl_t WHERE inaylent = '",g_enterprise,"' AND inayl001 =  xmdl014 AND inayl002 = '",g_lang,"')"

  #品名
   LET ls_sql.imaal003     = "(SELECT imaal003 FROM imaal_t WHERE imaalent = '",g_enterprise,"' AND imaal001 =  xmdl008 AND imaal002 = '",g_lang,"')"

  #規格
   LET ls_sql.imaal004     = "(SELECT imaal004 FROM imaal_t WHERE imaalent = '",g_enterprise,"' AND imaal001 =  xmdl008 AND imaal002 = '",g_lang,"')"

  #科目編號
   LET ls_sql.xrcb021      = "(SELECT xrcb021 FROM xrca_t, xrcb_t WHERE xrcbent = xrcaent ",
                             "    AND xrcbld = xrcald   AND xrcald = '",g_xrca_m.xrcald,"'",
                             "    AND xrcb023 <> 'Y'    AND xrcaent = '",g_enterprise,"'  ",
                             "    AND xrcastus <> 'X'   AND xrcb002 = xmdldocno           ",
                             "    AND xrcb003 = xmdlseq AND xrcbdocno = xrcadocno         ",
                             "    AND ROWNUM = 1)                                         " CLIPPED

  #財務分群
   LET ls_sql.imag011      = "(SELECT imag011 FROM imag_t WHERE imagent = ",g_enterprise," AND imagsite = '",g_glaa.glaacomp,"' AND imag001 = xmdl008)"

  #價格群組
   LET ls_sql.pmaa091      = "(SELECT pmaa091 FROM pmaa_t WHERE pmaaent = '",g_enterprise,"' AND pmaa001 = xmdk007)"

  #發票號碼
  #LET ls_sql.xmdl049      = "(CASE WHEN (xmdk000 IN ('1', '2', '3')) THEN xmdk037 WHEN (xmdk000 ='6') THEN xmdl049 END)"   #161201-00035#1 Mark
  #161201-00035#1 Add  ---(S)---
   LET ls_sql.xmdl049      = "(SELECT DISTINCT isaf011 FROM isaf_t,isag_t WHERE isafent = isagent AND isafent = ",g_enterprise," AND isafdocno = isagdocno AND isafcomp = isagcomp AND isag002 = xmdkdocno AND isag003 = xmdlseq AND ROWNUM = 1)"
  #161201-00035#1 Add  ---(E)---


  #應收單號
   LET ls_sql.doc1         = "(SELECT xrcadocno FROM xrca_t,xrcb_t                                    ",
                             "  WHERE xrcaent = ",g_enterprise," AND xrcbent = xrcaent AND rownum = 1 ",
                             "    AND xrcbld = xrcald AND xrcbdocno = xrcadocno                       ",
                             "    AND xrcastus <> 'X'                                                 ",   #161219-00056#1 add lujh
                             "    AND xrcald = '",g_xrca_m.xrcald,"'                                  ",
                             "    AND xrcb002 = xmdkdocno AND xrcb003 = xmdlseq                       ",
                             "    AND xrca001 NOT IN ('01','02','03','04'))                           "

  #應收單號
   LET ls_sql.doc2         = "(SELECT xrcadocno FROM xrca_t,xrcb_t                                    ",
                             "  WHERE xrcaent = ",g_enterprise," AND xrcbent = xrcaent AND rownum = 1 ",
                             "    AND xrcbld = xrcald AND xrcbdocno = xrcadocno                       ",
                             "    AND xrcastus <> 'X'                                                 ",   #161219-00056#1 add lujh
                             "    AND xrcald = '",g_xrca_m.xrcald,"'                                  ",
                             "    AND xrcb002 = xmdkdocno AND xrcb003 = xmdlseq                       ",
                             "    AND xrca001 IN ('01','02','03','04'))                               "

   #160418-00003#1 Add  ---(E)---
   
   #160518-00075#4 add s---
   SELECT ooef004 INTO l_ooef004 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_xrca_m.xrcasite
   #出货单限定单别
   CALL s_control_get_docno_sql_q(g_user,g_dept,l_ooef004) RETURNING g_sub_success,g_sql_ctr2,g_sql_ctr3
   LET ls_sql.ctr2 = g_sql_ctr2  
   LET ls_sql.ctr3 = g_sql_ctr3    
   #160518-00075#4 add e---

  #1.将主要数据大SQL一次性写入临时表
  LET g_sql ="INSERT INTO axrq130_tmp01(",          #160727-00019#6   2016/07/28 By 08734   axrq130_print_tmp ——> axrq130_tmp01   #161206-00017#1 add xmdl018,xrca101 lujh
              "l_xmdl0272,xmdk000,xmdk001,xmdk003,xmdk007,xmdk016,xmdk017,xmdkdocdt,xmdldocno,
               l_xmdl0292,xmdlseq,xmdl003,xmdl004,xmdl018,xmdl022,xmdl024,xmdl025,xmdl026,  xmdl027,  
               l_xmdl0282,xmdl029,xmdl047,xmdl028,xmdk004,xmdl014,xmdl008,l_xmdl007_desc,l_argv1,
               l_xrcb103diff,l_xmdl0271,xrcb103,xrcb104,xrcb105,
               l_xrcb104diff,l_xmdl0291,xrcf103,xrcf104,xrcf105,
               l_xrcb105diff,l_xmdl0281,xrca101,xrcb113,xrcb114,xrcb115,     
               xrcasite_desc,xrcald_desc, xmdksite,     
               xmdk003_desc, xmdk004_desc,xmdl014_desc,
               imaal003,     imaal004,    imag011,
               pmaa091,      glcc003,     xmdl038,     
               l_xmdl0381,   xmdl053,     xmdl049,    
               xrcadocno,    xrcad2       )
       SELECT xmdl027,xmdk000,xmdk001,xmdk003,xmdk007,xmdk016,xmdk017,xmdkdocdt,xmdldocno,",
              #160505-00007#21--mod--str--
#              xmdl028,xmdlseq,xmdl003,xmdl004,xmdl022,xmdl024,xmdl025,xmdl026,  xmdl027,",
#              xmdl029,xmdl029,xmdl047,xmdl028,xmdk004,xmdl014,xmdl008,xmdl007,  '1',  
              "xmdl029,xmdlseq,xmdl003,xmdl004,xmdl018,xmdl022,xmdl024,xmdl025,xmdl026,  xmdl027,",   #161206-00017#1 add xmdl018 lujh
              "xmdl028,xmdl029,",
              "(CASE WHEN RTRIM(xmdl047) IS NULL THEN 0 ELSE xmdl047 END),",
              "xmdl028,xmdk004,xmdl014,xmdl008,xmdl007,  '1',0,",   #161206-00017#1 add 0 lujh
              #160505-00007#21--mod--end
              "0,0,0,0,0, 0,0,0,0,0, 0,0,0,0,0,",
              ls_sql.xmdk007_desc,",",ls_sql.xmdk000_desc,",",ls_sql.xmdksite_desc,",",
				  ls_sql.xmdk003_desc,",",ls_sql.xmdk004_desc,",",ls_sql.xmdl014_desc, ",",
				  ls_sql.imaal003,    ",",ls_sql.imaal004,    ",",ls_sql.imag011,      ",",
              ls_sql.pmaa091,     ",",ls_sql.xrcb021,     ",",l_xmdl038,           ",",
              l_xmdl038,          ",",l_xmdl053,          ",",ls_sql.xmdl049,      ",",
              ls_sql.doc1,        ",",ls_sql.doc2,
         " FROM xmdk_t,xmdl_t WHERE xmdkent = xmdlent   AND xmdldocno = xmdkdocno ",
         "  AND xmdkent = '",g_enterprise,"'           AND ",g_wc1,
         "  AND ((xmdk000 IN ('1', '2', '3') AND xmdkstus = 'S' AND xmdk002 = '1') OR ",
         "       (xmdk000 IN ('4', '5') AND xmdkstus = 'Y' AND xmdk002 = '3') OR ",
         "       (xmdk000 = '6' AND xmdk082 <> '5' AND xmdkstus = 'S' ) )",
         "  AND (substr(xmdkdocno,",l_i,",",l_j,") ",ls_sql.ctr2," OR substr(xmdkdocno,",l_i,",",l_j,") ",ls_sql.ctr3,")" , #160518-00075#4 add    
         "ORDER BY xmdk007,xmdk000,xmdkdocdt,xmdk001,xmdldocno"        #160613-00022#1  2736行 Add AND xmdkstus = 'S'
  PREPARE axrq130_pre01 FROM g_sql
  EXECUTE axrq130_pre01
  IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'axrq130_pre01'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_success='N'
      RETURN
  END IF
  
  #2.更新imag011_desc财务分群名称
  LET g_sql = " MERGE INTO axrq130_tmp01 o ",            #160727-00019#6   2016/07/28 By 08734   axrq130_print_tmp ——> axrq130_tmp01
              " USING (SELECT oocql002,oocql004 n1 FROM oocql_t ",
              "         WHERE oocqlent='"||g_enterprise||"' AND oocql001='206'  ",
              "           AND oocql003='"||g_dlang||"') n",
              " ON (o.imag011=n.oocql002)",
              " WHEN MATCHED THEN ",
              " UPDATE SET imag011_desc = n.n1 " 
  PREPARE axrq130_pre02 FROM g_sql
  EXECUTE axrq130_pre02
  IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'axrq130_pre02'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_success='N'
      RETURN
  END IF
  #4.更新税别xmdl025
  LET g_sql = " MERGE INTO axrq130_tmp01 o ",                 #160727-00019#6   2016/07/28 By 08734   axrq130_print_tmp ——> axrq130_tmp01
              " USING (SELECT xmdkdocno,xmdk012 n1 FROM xmdk_t ",
              "         WHERE xmdkent='"||g_enterprise||"') n",
              " ON (o.xmdldocno=n.xmdkdocno)",
              " WHEN MATCHED THEN ",
              " UPDATE SET xmdl025 = n.n1 " ,
              " WHERE TRIM(o.xmdl025) IS NULL "
  PREPARE axrq130_pre04 FROM g_sql 
  EXECUTE axrq130_pre04
  IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'axrq130_pre04'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_success='N'
      RETURN
  END IF
  
  #價格群組說明
  LET g_sql = " MERGE INTO axrq130_tmp01 o ",              #160727-00019#6   2016/07/28 By 08734   axrq130_print_tmp ——> axrq130_tmp01
              " USING (SELECT oocql002,oocql004 n1 FROM oocql_t ",
              "         WHERE oocqlent='"||g_enterprise||"' AND oocql001='283'  ",
              "           AND oocql003='"||g_dlang||"') n",
              " ON (o.pmaa091=n.oocql002)",
              " WHEN MATCHED THEN ",
              " UPDATE SET pmaa091_desc = n.n1 " 
  PREPARE axrq130_pre021 FROM g_sql
  EXECUTE axrq130_pre021
  IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'axrq130_pre02'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_success='N'
      RETURN
  END IF

  #5.更新 冲销数量,原币未税金额，原币税额，原币含税金额 
  #立暫估數量
  #立暂估数 - 已沖暫估數量(已確認)
  #160802-00036#1 Mark ---(S)---
 #LET g_sql = " MERGE INTO axrq130_tmp01 o ",              #160727-00019#6   2016/07/28 By 08734   axrq130_print_tmp ——> axrq130_tmp01
 #            " USING (SELECT xrcb002,xrcb003,
 #                            NVL(TRIM(CASE WHEN SUM (xrcf007) IS NULL THEN 0 ELSE SUM(xrcf007) END),0) n1,
 #                            NVL(TRIM(SUM(xrcf103)),0) n2,NVL(TRIM(SUM(xrcf104)),0) n3,NVL(TRIM(SUM(xrcf105)),0) n4
 #                      FROM xrcf_t,xrca_t,
 #                          (SELECT xrcb002,xrcb003,xrcbdocno docno, xrcbseq seq
 #                            FROM xrca_t, xrcb_t
 #                           WHERE xrcaent = xrcbent
 #                             AND xrcald = xrcbld
 #                             AND xrcadocno = xrcbdocno
 #                             AND xrca001 IN ('01', '02', '03', '04')
 #                             AND xrcald = '",g_xrca_m.xrcald,"'
 #                             AND xrcaent = ",g_enterprise,")
 #                      WHERE     xrcfent = xrcaent
 #                       AND xrcfdocno = xrcadocno
 #                       AND xrcfld = xrcald
 #                       AND xrcald = '",g_xrca_m.xrcald,"'
 #                       AND xrcaent = ",g_enterprise,
 #            "          AND xrcf008 = docno
 #                       AND xrcf009 = seq
 #                       AND xrcastus = 'Y' GROUP BY xrcb002,xrcb003) n",
 #            " ON (o.xmdldocno=n.xrcb002 AND o.xmdlseq=n.xrcb003 )",
 #            " WHEN MATCHED THEN ",
 #            " UPDATE SET o.xmdl053 = o.xmdl053 - n.n1,",
 #            "            o.xrcf103 = n.n2,",
 #            "            o.xrcf104 = n.n3,",
 #            "            o.xrcf105 = n.n4 ",
 #            " WHERE o.xmdl053 > 0" #出貨/銷退單有立暫估數才做暫估數量的計算
  #160802-00036#1 Mark ---(E)---
#170217-00038#1 mark s---  
#  #160802-00036#1 Add  ---(S)---
#  LET g_sql = " MERGE INTO axrq130_tmp01 o ",
#              " USING (SELECT a.xrcb002,a.xrcb003,",
#              "               CASE WHEN b.xrcb007 - a.xrcb007 < 0 THEN 0 ELSE b.xrcb007 - a.xrcb007 END n1,",
#              #160909-00015#2 Mark ---(S)---
#             #"               CASE WHEN b.xrcb103 - a.xrcb103 < 0 THEN 0 ELSE b.xrcb103 - a.xrcb103 END n2,",
#             #"               CASE WHEN b.xrcb104 - a.xrcb104 < 0 THEN 0 ELSE b.xrcb104 - a.xrcb104 END n3,",
#             #"               CASE WHEN b.xrcb105 - a.xrcb105 < 0 THEN 0 ELSE b.xrcb105 - a.xrcb105 END n4 ",
#              #160909-00015#2 Mark ---(E)---
#              #160909-00015#2 Add  ---(S)---
#              "               CASE WHEN b.xrcb007 - a.xrcb007 < 0 THEN 0 ELSE b.xrcb007 - a.xrcb007 END / b.xrcb007 *  b.xrcb103 n2,",
#              "               CASE WHEN b.xrcb007 - a.xrcb007 < 0 THEN 0 ELSE b.xrcb007 - a.xrcb007 END / b.xrcb007 *  b.xrcb104 n3,",
#              "               CASE WHEN b.xrcb007 - a.xrcb007 < 0 THEN 0 ELSE b.xrcb007 - a.xrcb007 END / b.xrcb007 *  b.xrcb105 n4 ",
#              #160909-00015#2 Add  ---(E)---
#              "         FROM (  SELECT xrcb002,xrcb003,SUM (xrcb007) xrcb007,SUM (xrcb103) xrcb103,        ",
#              "                        SUM (xrcb104) xrcb104,SUM (xrcb105) xrcb105                         ",
#              "                   FROM xrcb_t, xrca_t                                                      ",
#              "                  WHERE     xrcaent = xrcbent  AND xrcald = xrcbld                          ",
#              "                    AND xrcb002 IS NOT NULL    AND xrcb003 IS NOT NULL                      ",
#              "                    AND xrcb023 = 'Y'          AND xrcastus = 'Y'                           ",
#              "                    AND xrcadocno = xrcbdocno                                               ",
#              "                    AND xrca001 NOT IN ('01', '02', '03', '04')                             ",
#              "                    AND xrcald  = '",g_xrca_m.xrcald,"'                                     ",
#              "                    AND xrcaent = '",g_enterprise,"'                                        ",
#              "                  GROUP BY xrcb002, xrcb003) a,                                             ",
#              "              (  SELECT xrcb002,xrcb003,SUM (xrcb007) xrcb007,SUM (xrcb103) xrcb103,        ",
#              "                        SUM (xrcb104) xrcb104,SUM (xrcb105) xrcb105                         ",
#              "                   FROM xrcb_t, xrca_t                                                      ",
#              "                  WHERE     xrcaent = xrcbent  AND xrcald = xrcbld                          ",
#              "                    AND xrcb002 IS NOT NULL    AND xrcb003 IS NOT NULL                      ",
#              "                    AND xrcadocno = xrcbdocno  AND xrcastus = 'Y'                           ",
#              "                    AND xrca001 IN ('01', '02', '03', '04')                                 ",
#              "                    AND xrcald  = '",g_xrca_m.xrcald,"'                                     ",
#              "                    AND xrcaent = '",g_enterprise,"'                                        ",
#              "                  GROUP BY xrcb002, xrcb003) b                                              ",
#              " WHERE a.xrcb002 = b.xrcb002 AND a.xrcb003 = b.xrcb003) n",
#              " ON (o.xmdldocno=n.xrcb002 AND o.xmdlseq=n.xrcb003 )",
#              " WHEN MATCHED THEN ",
#              " UPDATE SET o.xmdl053 = n.n1,",
#              "            o.xrcf103 = n.n2,",
#              "            o.xrcf104 = n.n3,",
#              "            o.xrcf105 = n.n4 ",
#              " WHERE o.xmdl053 > 0" #出貨/銷退單有立暫估數才做暫估數量的計算
#  #160802-00036#1 Add  ---(E)---
#170217-00038#1 mark e---
#170217-00038#1 add s--- 
  LET g_sql = " MERGE INTO axrq130_tmp01 o ",
              " USING (SELECT b.xrcb002,b.xrcb003,",
              "               CASE WHEN b.xrcb007 - a.xrcb007 < 0 THEN 0 ELSE b.xrcb007 - a.xrcb007 END n1,",
              #160909-00015#2 Mark ---(S)---
             #"               CASE WHEN b.xrcb103 - a.xrcb103 < 0 THEN 0 ELSE b.xrcb103 - a.xrcb103 END n2,",
             #"               CASE WHEN b.xrcb104 - a.xrcb104 < 0 THEN 0 ELSE b.xrcb104 - a.xrcb104 END n3,",
             #"               CASE WHEN b.xrcb105 - a.xrcb105 < 0 THEN 0 ELSE b.xrcb105 - a.xrcb105 END n4 ",
              #160909-00015#2 Mark ---(E)---
              #160909-00015#2 Add  ---(S)---
              "               CASE WHEN b.xrcb007 - a.xrcb007 < 0 THEN 0 ELSE CASE WHEN a.xrcb007 IS NULL THEN b.xrcb007 ELSE b.xrcb007 - a.xrcb007 END END / b.xrcb007 *  b.xrcb103 n2,",
              "               CASE WHEN b.xrcb007 - a.xrcb007 < 0 THEN 0 ELSE CASE WHEN a.xrcb007 IS NULL THEN b.xrcb007 ELSE b.xrcb007 - a.xrcb007 END END / b.xrcb007 *  b.xrcb104 n3,",
              "               CASE WHEN b.xrcb007 - a.xrcb007 < 0 THEN 0 ELSE CASE WHEN a.xrcb007 IS NULL THEN b.xrcb007 ELSE b.xrcb007 - a.xrcb007 END END / b.xrcb007 *  b.xrcb105 n4 ",
              #160909-00015#2 Add  ---(E)---
              "         FROM (  SELECT xrcb002,xrcb003,SUM (xrcb007) xrcb007,SUM (xrcb103) xrcb103,        ",
              "                        SUM (xrcb104) xrcb104,SUM (xrcb105) xrcb105                         ",
              "                   FROM xrcb_t, xrca_t                                                      ",
              "                  WHERE     xrcaent = xrcbent  AND xrcald = xrcbld                          ",
              "                    AND xrcb002 IS NOT NULL    AND xrcb003 IS NOT NULL                      ",
              "                    AND xrcadocno = xrcbdocno  AND xrcastus = 'Y'                           ",
              "                    AND xrca001 IN ('01', '02', '03', '04')                                 ",
              "                    AND xrcald  = '",g_xrca_m.xrcald,"'                                     ",
              "                    AND xrcaent = '",g_enterprise,"'                                        ",
              "                  GROUP BY xrcb002, xrcb003) b  LEFT OUTER JOIN                             ",
              "              (  SELECT xrcb002,xrcb003,SUM (xrcb007) xrcb007,SUM (xrcb103) xrcb103,        ",
              "                        SUM (xrcb104) xrcb104,SUM (xrcb105) xrcb105                         ",
              "                   FROM xrcb_t, xrca_t                                                      ",
              "                  WHERE     xrcaent = xrcbent  AND xrcald = xrcbld                          ",
              "                    AND xrcb002 IS NOT NULL    AND xrcb003 IS NOT NULL                      ",
              "                    AND xrcb023 = 'Y'          AND xrcastus = 'Y'                           ",
              "                    AND xrcadocno = xrcbdocno                                               ",
              "                    AND xrca001 NOT IN ('01', '02', '03', '04')                             ",
              "                    AND xrcald  = '",g_xrca_m.xrcald,"'                                     ",
              "                    AND xrcaent = '",g_enterprise,"'                                        ",
              "                  GROUP BY xrcb002, xrcb003) a                                              ",
              " ON a.xrcb002 = b.xrcb002 AND a.xrcb003 = b.xrcb003) n",
              " ON (o.xmdldocno=n.xrcb002 AND o.xmdlseq=n.xrcb003 )",
              " WHEN MATCHED THEN ",
              " UPDATE SET o.xmdl053 = n.n1,",
              "            o.xrcf103 = n.n2,",
              "            o.xrcf104 = n.n3,",
              "            o.xrcf105 = n.n4 ",
              " WHERE o.xmdl053 > 0" #出貨/銷退單有立暫估數才做暫估數量的計算
#170217-00038#1 add e---  
  PREPARE axrq130_pre05 FROM g_sql
  EXECUTE axrq130_pre05
  IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'axrq130_pre05'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_success='N'
      RETURN
  END IF
  
  #6.已立帳金額
  IF g_argv[1] = '1' THEN
    LET g_sql = 
              " MERGE INTO axrq130_tmp01 o ",             #160727-00019#6   2016/07/28 By 08734   axrq130_print_tmp ——> axrq130_tmp01
              " USING (SELECT xrca101 n7,xrcb002,xrcb003,",  #161206-00017#1 add xrca101 lujh
              "               NVL(TRIM(SUM(xrcb103)),0) n1,NVL(TRIM(SUM(xrcb104)),0) n2,NVL(TRIM(SUM(xrcb105)),0) n3,",
              "               NVL(TRIM(SUM(xrcb113)),0) n4,NVL(TRIM(SUM(xrcb114)),0) n5,NVL(TRIM(SUM(xrcb115)),0) n6 ",
              "          FROM xrcb_t,xrca_t ",
              "         WHERE xrcaent = xrcbent AND xrcaent = ",g_enterprise,"
                          AND xrcald  = xrcbld  AND xrcald  = '",g_xrca_m.xrcald,"'
                          AND xrcadocno = xrcbdocno
                          AND xrca001 NOT IN ('01','02','03','04')
                          AND xrcastus <> 'X' GROUP BY xrca101,xrcb002,xrcb003) n",
              " ON (o.xmdldocno=n.xrcb002 AND o.xmdlseq=n.xrcb003)",
              " WHEN MATCHED THEN ",
              " UPDATE SET o.xrcb103 = n.n1,",
              "            o.xrcb104 = n.n2,", 
              "            o.xrcb105 = n.n3,", 
              "            o.xrcb113 = n.n4,", 
              "            o.xrcb114 = n.n5,", 
              "            o.xrcb115 = n.n6,",
              "            o.xrca101 = n.n7 "   #161206-00017#1 add lujh 
              
  ELSE     
    #161207-00015#1 Add  ---(S)---
    LET g_sql = 
              " MERGE INTO axrq130_tmp01 o ",
              " USING (SELECT xrca101 n4,xrcb002,xrcb003,",   #161206-00017#1 add xrca101 lujh
              "               NVL(TRIM(SUM(xrcb113)),0) n1,NVL(TRIM(SUM(xrcb114)),0) n2,NVL(TRIM(SUM(xrcb115)),0) n3 ",
              "          FROM xrcb_t,xrca_t ",
              "         WHERE xrcaent = xrcbent AND xrcaent = ",g_enterprise,"
                          AND xrcald  = xrcbld  AND xrcald  = '",g_xrca_m.xrcald,"'
                          AND xrcadocno = xrcbdocno
                          AND xrca001 NOT IN ('01','02','03','04')
                          AND xrcastus <> 'X' GROUP BY xrca101,xrcb002,xrcb003) n",
              " ON (o.xmdldocno=n.xrcb002 AND o.xmdlseq=n.xrcb003)",
              " WHEN MATCHED THEN ",
              " UPDATE SET o.xrcb113 = n.n1,", 
              "            o.xrcb114 = n.n2,", 
              "            o.xrcb115 = n.n3,",
              "            o.xrca101 = n.n4 "   #161206-00017#1 add lujh
  PREPARE axrq130_pre07 FROM g_sql
  EXECUTE axrq130_pre07
  IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'axrq130_pre07'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_success='N'
      RETURN
  END IF
    #161207-00015#1 Add  ---(E)---
    LET g_sql = 
              " MERGE INTO axrq130_tmp01 o ",             #160727-00019#6   2016/07/28 By 08734   axrq130_print_tmp ——> axrq130_tmp01
              " USING (SELECT isag002,isag003,NVL(TRIM(SUM(isag103)),0) n1,NVL(TRIM(SUM(isag104)),0) n2,NVL(TRIM(SUM(isag105)),0) n3 ",
              "          FROM isag_t ",
              "         WHERE isagent = ",g_enterprise,  #170122-00008#1 add
              "          GROUP BY isag002,isag003) n",
              " ON (o.xmdldocno=n.isag002 AND o.xmdlseq=n.isag003)",  
              " WHEN MATCHED THEN ",
              " UPDATE SET o.xrcb103 = n.n1,",
              "            o.xrcb104 = n.n2,", 
              "            o.xrcb105 = n.n3"     
  END IF 
  PREPARE axrq130_pre06 FROM g_sql
  EXECUTE axrq130_pre06
  IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'axrq130_pre06'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_success='N'
      RETURN
  END IF

  #160909-00015#2 Mark ---(S)---
  #7.暂估金额
  # LET g_sql = " MERGE INTO axrq130_tmp01 o ",              #160727-00019#6   2016/07/28 By 08734   axrq130_print_tmp ——> axrq130_tmp01
  #            " USING (SELECT xrcb002,xrcb003,NVL(TRIM(SUM(xrcb103)),0) n1,NVL(TRIM(SUM(xrcb104)),0) n2,NVL(TRIM(SUM(xrcb105)),0) n3 ",
  #            "          FROM xrcb_t,xrca_t ",
  #            "         WHERE xrcaent = xrcbent AND xrcaent = ",g_enterprise,"
  #                        AND xrcald  = xrcbld  AND xrcald  = '",g_xrca_m.xrcald,"'
  #                        AND xrcadocno = xrcbdocno
  #                        AND xrca001 IN ('01','02','03','04')
  #                        GROUP BY xrcb002,xrcb003) n",
  #            " ON (o.xmdldocno=n.xrcb002 AND o.xmdlseq=n.xrcb003)",
  #            " WHEN MATCHED THEN ",
  #            " UPDATE SET o.xrcf103 = n.n1-o.xrcf103,",
  #            "            o.xrcf104 = n.n2-o.xrcf104,",  
  #            "            o.xrcf105 = n.n3-o.xrcf105"  
  # PREPARE axrq130_pre07 FROM g_sql
  # EXECUTE axrq130_pre07
  # IF SQLCA.sqlcode THEN
  #    INITIALIZE g_errparam TO NULL
  #    LET g_errparam.code = SQLCA.sqlcode
  #    LET g_errparam.extend = 'axrq130_pre07'
  #    LET g_errparam.popup = TRUE
  #    CALL cl_err()
  #    LET g_success='N'
  #    RETURN
  #END IF   
  #160909-00015#2 Mark ---(S)---

   #160505-00007#21--add--str--
   #程式优化：b_fill3单身中计算金额部分拿到这里直接异动临时表值
   CASE
      WHEN g_argv[1] = '1'   #axrq130
         #未匹配數量
         UPDATE axrq130_tmp01 SET xmdl038 = xmdl022 - xmdl038              #160727-00019#6   2016/07/28 By 08734   axrq130_print_tmp ——> axrq130_tmp01
         #差異數量 = 計價數量 - 立帳數量 - 已開發票數量 - 立暫估數量
         UPDATE axrq130_tmp01 SET l_xmdl022diff = xmdl022 - l_xmdl0381 - xmdl053           #160727-00019#6   2016/07/28 By 08734   axrq130_print_tmp ——> axrq130_tmp01
      WHEN g_argv[1] = '2'   #axrq140
         #未匹配數量
         UPDATE axrq130_tmp01 SET xmdl038 = xmdl022 - xmdl047           #160727-00019#6   2016/07/28 By 08734   axrq130_print_tmp ——> axrq130_tmp01
         #差異數量 = 計價數量 - 立帳數量 - 已開發票數量 - 立暫估數量
         UPDATE axrq130_tmp01 SET l_xmdl022diff = xmdl022 - xmdl047     #160727-00019#6   2016/07/28 By 08734   axrq130_print_tmp ——> axrq130_tmp01
   END CASE

   #未匹配金額
   UPDATE axrq130_tmp01 SET xmdl027 = xmdl027 * (xmdl038 / xmdl022),         #160727-00019#6   2016/07/28 By 08734   axrq130_print_tmp ——> axrq130_tmp01
                                xmdl028 = xmdl028 * (xmdl038 / xmdl022),
                                xmdl029 = xmdl029 * (xmdl038 / xmdl022)
   WHERE xmdl025 IS NOT NULL AND xmdl038 <> xmdl022
   
   #170213-00036#1--mod--str--
   #xmdl0271,xmdl0281,xmdl0291 計算金額後按照本幣取位
   #抓取本幣對應的小數位數
   LET l_ooaj004=0
   CALL s_curr_sel_ooaj004(g_glaa.glaa026,g_glaa.glaa001) RETURNING l_ooaj004
   
#   UPDATE axrq130_tmp01 SET l_xmdl0271 = xmdl027 * xmdk017,          #160727-00019#6   2016/07/28 By 08734   axrq130_print_tmp ——> axrq130_tmp01
#                                l_xmdl0281 = xmdl028 * xmdk017,
#                                l_xmdl0291 = xmdl029 * xmdk017
   UPDATE axrq130_tmp01 SET l_xmdl0271 = ROUND(xmdl027 * xmdk017,l_ooaj004), 
                            l_xmdl0281 = ROUND(xmdl028 * xmdk017,l_ooaj004),
                            l_xmdl0291 = ROUND(xmdl029 * xmdk017,l_ooaj004)
   WHERE xmdl025 IS NOT NULL
   #170213-00036#1--mod--end
   
   #差異金額 出貨金额－未立账金额－正常立账金额－暂估立账金额
   UPDATE axrq130_tmp01 SET l_xrcb103diff = l_xmdl0272 - xmdl027 - xrcb103 - xrcf103,             #160727-00019#6   2016/07/28 By 08734   axrq130_print_tmp ——> axrq130_tmp01
                                l_xrcb104diff = l_xmdl0292 - xmdl029 - xrcb104 - xrcf104,
                                l_xrcb105diff = l_xmdl0282 - xmdl028 - xrcb105 - xrcf105

   UPDATE axrq130_tmp01                        #160727-00019#6   2016/07/28 By 08734   axrq130_print_tmp ——> axrq130_tmp01
   SET l_xmdl022diff = l_xmdl022diff * -1,
       xmdl022 = xmdl022 * -1,
       xmdl038 = xmdl038 * -1,
       l_xmdl0381= l_xmdl0381* -1,
       xmdl053 = xmdl053 * -1,
       xmdl047 = xmdl047 * -1,
       xmdl027 = xmdl027 * -1,
       xmdl029 = xmdl029 * -1,
       xmdl028 = xmdl028 * -1,
       l_xmdl0271= l_xmdl0271* -1,
       l_xmdl0291= l_xmdl0291* -1,
       l_xmdl0281= l_xmdl0281* -1,
       l_xmdl0272= l_xmdl0272* -1,
       l_xmdl0292= l_xmdl0292* -1,
       l_xmdl0282= l_xmdl0282* -1,
       xrcb103 = xrcb103 * -1,
       xrcb104 = xrcb104 * -1,
       xrcb105 = xrcb105 * -1,
       xrcf103 = xrcf103 * -1,
       xrcf104 = xrcf104 * -1,
       xrcf105 = xrcf105 * -1,
       xrcb113 = xrcb113 * -1,
       xrcb114 = xrcb114 * -1,
       xrcb115 = xrcb115 * -1,
       l_xrcb103diff = l_xrcb103diff * -1,
       l_xrcb104diff = l_xrcb104diff * -1,
       l_xrcb105diff = l_xrcb105diff * -1
   WHERE xmdk000 = '6' 
   #160505-00007#21--add--end

  FREE axrq130_pre01
  FREE axrq130_pre02
  FREE axrq130_pre04
  FREE axrq130_pre05
  FREE axrq130_pre06
 #FREE axrq130_pre07   #160909-00015#2 Mark


END FUNCTION
#+ 單身陣列填充
PRIVATE FUNCTION axrq130_b_fill3()
   DEFINE li_ac           LIKE type_t.num5
   DEFINE l_sql           STRING
   DEFINE l_wc            STRING
   DEFINE l_xmdl038       STRING
   DEFINE l_xmdl053       STRING
   DEFINE l_s             LIKE type_t.chr1
   DEFINE l_success       LIKE type_t.chr1
   DEFINE l_xrcd103       LIKE xrcd_t.xrcd103
   DEFINE l_xrcd104       LIKE xrcd_t.xrcd104
   DEFINE l_xrcd105       LIKE xrcd_t.xrcd105
   DEFINE l_xmdldocno     LIKE xmdl_t.xmdldocno
   DEFINE l_xmdk_d        type_g_xmdk_d
   DEFINE l_xrcasite_desc LIKE type_t.chr500
   DEFINE l_xrcald_desc   LIKE type_t.chr500
   DEFINE l_xmdk000       LIKE type_t.chr80
   DEFINE l_xmdk007_desc  LIKE type_t.chr80
   DEFINE l_glaa004       LIKE glaa_t.glaa004   #160418-00003#1 Add
   DEFINE l_glcc003_desc  STRING
   DEFINE l_gzzd005       LIKE gzzd_t.gzzd005   #160505-00007#21
   DEFINE l_ooef004       LIKE ooef_t.ooef004  #160518-00075#4
   DEFINE l_n1            LIKE type_t.num5     #160518-00075#4
   DEFINE l_n2            LIKE type_t.num5     #160518-00075#4
   #161226-00063#1--add--str--lujh
   DEFINE l_sum_xmdl018       LIKE xmdl_t.xmdl018    #161206-00017#1 add lujh
   DEFINE l_sum_xmdl022       LIKE xmdl_t.xmdl022
   DEFINE l_sum_xmdl038       LIKE xmdl_t.xmdl038
   DEFINE l_sum_xmdl0381      LIKE xmdl_t.xmdl038
   DEFINE l_sum_xmdl053       LIKE xmdl_t.xmdl053
   DEFINE l_sum_xmdl0272      LIKE xmdl_t.xmdl027
   DEFINE l_sum_xmdl0292      LIKE xmdl_t.xmdl029
   DEFINE l_sum_xmdl0282      LIKE xmdl_t.xmdl028
   DEFINE l_sum_xmdl027       LIKE xmdl_t.xmdl027
   DEFINE l_sum_xmdl029       LIKE xmdl_t.xmdl029
   DEFINE l_sum_xmdl028       LIKE xmdl_t.xmdl028
   DEFINE l_sum_xrcb103       LIKE xrcb_t.xrcb103
   DEFINE l_sum_xrcb104       LIKE xrcb_t.xrcb104
   DEFINE l_sum_xrcb105       LIKE xrcb_t.xrcb105
   DEFINE l_sum_xrcf103       LIKE xrcf_t.xrcf103
   DEFINE l_sum_xrcf105       LIKE xrcf_t.xrcf105
   DEFINE l_sum_xrcb103diff   LIKE xrcb_t.xrcb103
   DEFINE l_sum_xrcb104diff   LIKE xrcb_t.xrcb104
   DEFINE l_sum_xrcb105diff   LIKE xrcb_t.xrcb105
   DEFINE l_sum_xmdl0271      LIKE xmdl_t.xmdl027
   DEFINE l_sum_xmdl0291      LIKE xmdl_t.xmdl029
   DEFINE l_sum_xmdl0281      LIKE xmdl_t.xmdl028
   DEFINE l_sum_xrcb113       LIKE xrcb_t.xrcb113
   DEFINE l_sum_xrcb114       LIKE xrcb_t.xrcb114
   DEFINE l_sum_xrcb115       LIKE xrcb_t.xrcb115
   #161226-00063#1--add--end--lujh
   
   CALL s_fin_account_center_with_ld_chk(g_xrca_m.xrcasite,g_xrca_m.xrcald,g_user,'3','N','',g_today) RETURNING l_success,g_errno
   IF NOT cl_null(g_errno) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = g_errno
      LET g_errparam.extend = g_xrca_m.xrcasite
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET g_xrca_m.xrcasite = ''
      LET g_xrca_m.xrcasite_desc = ''
      DISPLAY BY NAME g_xrca_m.xrcasite,g_xrca_m.xrcasite_desc
      RETURN
   END IF

#   CALL axrq130_create_tmp() #160505-00007#21 mark
   DELETE FROM axrq130_tmp01                  #160727-00019#6   2016/07/28 By 08734   axrq130_print_tmp ——> axrq130_tmp01
   LET l_xrcasite_desc = g_xrca_m.xrcasite,"     ",g_xrca_m.xrcasite_desc
   LET l_xrcald_desc = g_xrca_m.xrcald,"    ",g_xrca_m.xrcald_desc,"   ",g_xrca_m.xrcacomp

   LET li_ac = l_ac

   CALL axrq130_get_wc()
   CALL g_xmdk_d.clear()

   CALL s_axrt300_sel_ld(g_xrca_m.xrcald) RETURNING l_success,l_s
   CASE
      WHEN l_s = '1'
         LET l_xmdl038 = 'xmdl038'   LET l_xmdl053 = 'xmdl053'
      WHEN l_s = '2'
         LET l_xmdl038 = 'xmdl039'   LET l_xmdl053 = 'xmdl054'
      WHEN l_s = '3'
         LET l_xmdl038 = 'xmdl040'   LET l_xmdl053 = 'xmdl055'
   END CASE
   
   LET l_xmdl038="(CASE WHEN RTRIM(",l_xmdl038,") IS NULL THEN 0 ELSE ",l_xmdl038," END)" #160505-00007#21 add
   #
   CALL axrq130_b_ins_tmp(l_xrcasite_desc,l_xrcald_desc,l_xmdl038,l_xmdl053)
   IF g_success='N' THEN
     RETURN
   END IF

  #發票號碼
   CALL s_ld_sel_glaa(g_xrca_m.xrcald,'glaa004') RETURNING g_success,l_glaa004
   LET l_glcc003_desc = "(SELECT glacl004 FROM glacl_t WHERE glaclent = '",g_enterprise,"' AND glacl001 = '",l_glaa004,"' AND glacl002 = glcc003 AND glacl003 = '",g_lang,"')"
   
   #160518-00075#4 add s---
   SELECT ooef004 INTO l_ooef004 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_xrca_m.xrcasite
 
   LET g_sql = " SELECT COUNT(1) FROM oobc_t,ooba_t WHERE oobcent = oobaent AND oobc001 = ooba001 AND oobc002 = ooba002 ",#170213-00036#1 mod *-->1
               "    AND oobc001 = ? AND oobc002 = substr(?,?,?) "
   PREPARE axrq130_oobc_pre1 FROM g_sql 

   LET g_sql = " SELECT COUNT(1) FROM oobc_t,ooba_t WHERE oobcent = oobaent AND oobc001 = ooba001 AND oobc002 = ooba002 ",#170213-00036#1 mod *-->1
               "            AND oobc001 = ? ",
               "            AND oobc002 = substr(?,?,?) ",
               "            AND (oobc003 IN (SELECT ooha001 FROM ooha_t,oohc_t WHERE oohaent = oohcent AND ooha001 = oohc001 ",
               "                                AND oohc002 = '",g_user,"' ",
               "                                AND oohastus = 'Y'",  
               "                                AND oohc003 <= '",g_today,"' AND (oohc004 IS NULL OR oohc004 > '",g_today,"') ",
               "                              UNION ",
               "                             SELECT ooha001 FROM ooha_t,oohb_t WHERE oohaent = oohbent AND ooha001 = oohb001 ",
               "                                AND oohb002 = '",g_dept,"' ",
               "                                AND oohastus = 'Y'",  
               "                                AND oohb003 <= '",g_today,"' AND (oohb004 IS NULL OR oohb004 > '",g_today,"')) ",
               "             OR ((oobc003 = '",g_user,"' AND oobc004 = '8') ",
               "             OR (oobc003 = '",g_dept,"' AND oobc004 = '7')))"
   PREPARE axrq130_oobc_pre2 FROM g_sql 
   #160518-00075#4 add e---   
   
   #161206-00017#1 add xmdl018,xrca101 lujh
   LET l_sql = " SELECT 'N',xmdksite,xmdk007,xrcasite_desc,xmdk000,xmdkdocdt,xmdk001,
                        xmdldocno,xmdlseq,xmdk003, xmdk003_desc,xmdk004,xmdk004_desc,xmdl014,
                        xmdl014_desc, xmdl008,imaal003,imaal004,l_xmdl007_desc,imag011,imag011_desc,
                        pmaa091,pmaa091_desc,glcc003,",l_glcc003_desc,",xmdl018,xmdl022,xmdl038,l_xmdl0381,  
                        xmdl053,xmdl047,l_xmdl022diff,xmdk016,xmdl003,xmdl004,xmdl049,
                        xmdk017,xmdl025,xmdl026,xmdl024,l_xmdl0272,l_xmdl0292,l_xmdl0282,",
#                        xmdl027,xmdl024,l_xmdl0272,l_xmdl0292,l_xmdl0282, #160505-00007#21 mark
                        "xmdl027,",                                        #160505-00007#21 add
                        "xmdl029,xmdl028,xrcb103,xrcb104,xrcb105,xrcf103,
                        xrcf104,xrcf105,l_xrcb103diff,l_xrcb104diff, ",
                        "l_xrcb105diff,l_xmdl0271,l_xmdl0291,",            #160505-00007#21 add
                        "l_xmdl0281,xrca101,xrcb113, 
                        xrcb114,xrcb115,xrcadocno,xrcad2
                   FROM axrq130_tmp01 "               #160727-00019#6   2016/07/28 By 08734   axrq130_print_tmp ——> axrq130_tmp01
                 , " WHERE ", g_wc_filter   #161111-00049#1 Add
   PREPARE axrq130_sel_prep FROM l_sql
   DECLARE axrq130_sel_curs CURSOR FOR axrq130_sel_prep

   #160505-00007#21--add--str--
   #小计
   IF g_xrca_m.b_check = 'Y' THEN
      #小计
      SELECT gzzd005 INTO l_gzzd005 FROM gzzd_t WHERE gzzd001 = 'axrq130'
            AND gzzd003 = 'lbl_total' AND gzzd002 = g_lang
      LET l_sql="SELECT SUM(xmdl018),SUM(xmdl022),SUM(xmdl038),SUM(l_xmdl0381),SUM(xmdl053),SUM(xmdl047),SUM(l_xmdl022diff),",   #161206-00017#1 add xmdl018 lujh
                "       SUM(l_xmdl0272),SUM(l_xmdl0292),SUM(l_xmdl0282),SUM(xmdl027),SUM(xmdl029),SUM(xmdl028),",
                "       SUM(xrcb103),SUM(xrcb104),SUM(xrcb105),SUM(xrcf103),SUM(xrcf104),SUM(xrcf105),",
                "       SUM(l_xrcb103diff),SUM(l_xrcb104diff),SUM(l_xrcb105diff),SUM(l_xmdl0271),",
                "       SUM(l_xmdl0291),SUM(l_xmdl0281),SUM(xrcb113),SUM(xrcb114),SUM(xrcb115)",
                "  FROM axrq130_tmp01 ",                     #160727-00019#6   2016/07/28 By 08734   axrq130_print_tmp ——> axrq130_tmp01
                " WHERE xmdldocno=? "
                 #, " WHERE ", g_wc_filter   #161111-00049#1 Add   #161226-00063#1 mark lujh
                , " AND ", g_wc_filter   #161226-00063#1 mark lujh
      PREPARE axrq130_sum_pr FROM l_sql
   END IF
   #160505-00007#21--add--end

   LET li_ac = 1
   LET l_xmdldocno = NULL
   INITIALIZE l_xmdk_d.* TO NULL
   INITIALIZE g_xmdk_d_t.* TO NULL
#160505-00007#21--mark--str--
#   LET l_xmdk_d.xmdl022    = 0
#   LET l_xmdk_d.xmdl038    = 0
#   LET l_xmdk_d.l_xmdl0381   = 0
#   LET l_xmdk_d.xmdl053    = 0
#   LET l_xmdk_d.xmdl047    = 0
#   LET l_xmdk_d.l_xmdl022diff= 0
#   LET l_xmdk_d.l_xmdl0272   = 0
#   LET l_xmdk_d.l_xmdl0292   = 0
#   LET l_xmdk_d.l_xmdl0282   = 0
#   LET l_xmdk_d.xmdl027    = 0
#   LET l_xmdk_d.xmdl029    = 0
#   LET l_xmdk_d.xmdl028    = 0
#   LET l_xmdk_d.xrcb103    = 0
#   LET l_xmdk_d.xrcb104    = 0
#   LET l_xmdk_d.xrcb105    = 0
#   LET l_xmdk_d.xrcf103    = 0
#   LET l_xmdk_d.xrcf104    = 0
#   LET l_xmdk_d.xrcf105    = 0
#   LET l_xmdk_d.l_xrcb103diff= 0
#   LET l_xmdk_d.l_xrcb104diff= 0
#   LET l_xmdk_d.l_xrcb105diff= 0
#   LET l_xmdk_d.l_xmdl0271   = 0
#   LET l_xmdk_d.l_xmdl0291   = 0
#   LET l_xmdk_d.l_xmdl0281   = 0
#   LET l_xmdk_d.xrcb113    = 0
#   LET l_xmdk_d.xrcb114    = 0
#   LET l_xmdk_d.xrcb115    = 0
#160505-00007#21--mark--end
   FOREACH axrq130_sel_curs INTO g_xmdk_d[li_ac].*
      #160505-00007#21--mod--str--
#      IF NOT cl_null(l_xmdldocno) AND l_xmdldocno <> g_xmdk_d[li_ac].xmdldocno AND g_xrca_m.b_check = 'Y' THEN
      IF g_xrca_m.b_check = 'Y' AND li_ac > 1  THEN
         IF g_xmdk_d[li_ac - 1].xmdldocno <> g_xmdk_d[li_ac].xmdldocno  THEN
      #160505-00007#21--mod--end
         #出現新的單據編號,則將當前資料下移一行
         LET g_xmdk_d[li_ac + 1].* = g_xmdk_d[li_ac].*
         #當前行清空後,做小計
         LET g_xmdk_d[li_ac].* = g_xmdk_d_t.*
         #160505-00007#21--add--str--
         LET g_xmdk_d[li_ac].xmdldocno = l_gzzd005
         EXECUTE axrq130_sum_pr USING g_xmdk_d[li_ac - 1].xmdldocno
            INTO g_xmdk_d[li_ac].xmdl018,g_xmdk_d[li_ac].xmdl022,g_xmdk_d[li_ac].xmdl038,g_xmdk_d[li_ac].l_xmdl0381,g_xmdk_d[li_ac].xmdl053,   #161206-00017#1 add g_xmdk_d[li_ac].xmdl018
                 g_xmdk_d[li_ac].xmdl047,g_xmdk_d[li_ac].l_xmdl022diff,g_xmdk_d[li_ac].l_xmdl0272,g_xmdk_d[li_ac].l_xmdl0292,
                 g_xmdk_d[li_ac].l_xmdl0282,g_xmdk_d[li_ac].xmdl027,g_xmdk_d[li_ac].xmdl029,g_xmdk_d[li_ac].xmdl028,
                 g_xmdk_d[li_ac].xrcb103,g_xmdk_d[li_ac].xrcb104,g_xmdk_d[li_ac].xrcb105,g_xmdk_d[li_ac].xrcf103,
                 g_xmdk_d[li_ac].xrcf104,g_xmdk_d[li_ac].xrcf105,g_xmdk_d[li_ac].l_xrcb103diff,g_xmdk_d[li_ac].l_xrcb104diff,
                 g_xmdk_d[li_ac].l_xrcb105diff,g_xmdk_d[li_ac].l_xmdl0271,g_xmdk_d[li_ac].l_xmdl0291,
                 g_xmdk_d[li_ac].l_xmdl0281,g_xmdk_d[li_ac].xrcb113,g_xmdk_d[li_ac].xrcb114,g_xmdk_d[li_ac].xrcb115
         #160505-00007#21--add--end
         
#160505-00007#21--mark--str--         
#         SELECT gzzd005 INTO g_xmdk_d[li_ac].xmdldocno FROM gzzd_t WHERE gzzd001 = 'axrq130'
#            AND gzzd003 = 'lbl_total' AND gzzd002 = g_lang
#         LET g_xmdk_d[li_ac].xmdl022    = l_xmdk_d.xmdl022
#         LET g_xmdk_d[li_ac].xmdl038    = l_xmdk_d.xmdl038
#         LET g_xmdk_d[li_ac].l_xmdl0381   = l_xmdk_d.l_xmdl0381
#         LET g_xmdk_d[li_ac].xmdl053    = l_xmdk_d.xmdl053
#         LET g_xmdk_d[li_ac].xmdl047    = l_xmdk_d.xmdl047
#         LET g_xmdk_d[li_ac].l_xmdl022diff= l_xmdk_d.l_xmdl022diff
#         LET g_xmdk_d[li_ac].l_xmdl0272   = l_xmdk_d.l_xmdl0272
#         LET g_xmdk_d[li_ac].l_xmdl0292   = l_xmdk_d.l_xmdl0292
#         LET g_xmdk_d[li_ac].l_xmdl0282   = l_xmdk_d.l_xmdl0282
#         LET g_xmdk_d[li_ac].xmdl027    = l_xmdk_d.xmdl027
#         LET g_xmdk_d[li_ac].xmdl029    = l_xmdk_d.xmdl029
#         LET g_xmdk_d[li_ac].xmdl028    = l_xmdk_d.xmdl028
#         LET g_xmdk_d[li_ac].xrcb103    = l_xmdk_d.xrcb103
#         LET g_xmdk_d[li_ac].xrcb104    = l_xmdk_d.xrcb104
#         LET g_xmdk_d[li_ac].xrcb105    = l_xmdk_d.xrcb105
#         LET g_xmdk_d[li_ac].xrcf103    = l_xmdk_d.xrcf103
#         LET g_xmdk_d[li_ac].xrcf104    = l_xmdk_d.xrcf104
#         LET g_xmdk_d[li_ac].xrcf105    = l_xmdk_d.xrcf105
#         LET g_xmdk_d[li_ac].l_xrcb103diff= l_xmdk_d.l_xrcb103diff
#         LET g_xmdk_d[li_ac].l_xrcb104diff= l_xmdk_d.l_xrcb104diff
#         LET g_xmdk_d[li_ac].l_xrcb105diff= l_xmdk_d.l_xrcb105diff
#         LET g_xmdk_d[li_ac].l_xmdl0271   = l_xmdk_d.l_xmdl0271
#         LET g_xmdk_d[li_ac].l_xmdl0291   = l_xmdk_d.l_xmdl0291
#         LET g_xmdk_d[li_ac].l_xmdl0281   = l_xmdk_d.l_xmdl0281
#         LET g_xmdk_d[li_ac].xrcb113    = l_xmdk_d.xrcb113
#         LET g_xmdk_d[li_ac].xrcb114    = l_xmdk_d.xrcb114
#         LET g_xmdk_d[li_ac].xrcb115    = l_xmdk_d.xrcb115

#         LET l_xmdk_d.xmdl022    = 0
#         LET l_xmdk_d.xmdl038    = 0
#         LET l_xmdk_d.l_xmdl0381   = 0
#         LET l_xmdk_d.xmdl053    = 0
#         LET l_xmdk_d.xmdl047    = 0
#         LET l_xmdk_d.l_xmdl022diff= 0
#         LET l_xmdk_d.l_xmdl0272   = 0
#         LET l_xmdk_d.l_xmdl0292   = 0
#         LET l_xmdk_d.l_xmdl0282   = 0
#         LET l_xmdk_d.xmdl027    = 0
#         LET l_xmdk_d.xmdl029    = 0
#         LET l_xmdk_d.xmdl028    = 0
#         LET l_xmdk_d.xrcb103    = 0
#         LET l_xmdk_d.xrcb104    = 0
#         LET l_xmdk_d.xrcb105    = 0
#         LET l_xmdk_d.xrcf103    = 0
#         LET l_xmdk_d.xrcf104    = 0
#         LET l_xmdk_d.xrcf105    = 0
#         LET l_xmdk_d.l_xrcb103diff= 0
#         LET l_xmdk_d.l_xrcb104diff= 0
#         LET l_xmdk_d.l_xrcb105diff= 0
#         LET l_xmdk_d.l_xmdl0271   = 0
#         LET l_xmdk_d.l_xmdl0291   = 0
#         LET l_xmdk_d.l_xmdl0281   = 0
#         LET l_xmdk_d.xrcb113    = 0
#         LET l_xmdk_d.xrcb114    = 0
#         LET l_xmdk_d.xrcb115    = 0
#160505-00007#21--mark--end
         LET li_ac = li_ac + 1
      END IF
      END IF #160505-00007#21 add
#160505-00007#21--mark--str--
#      #未匹配數量
#      IF cl_null(g_xmdk_d[li_ac].xmdl038) THEN LET g_xmdk_d[li_ac].xmdl038 = 0 END IF
#      IF cl_null(g_xmdk_d[li_ac].xmdl047) THEN LET g_xmdk_d[li_ac].xmdl047 = 0 END IF
#      CASE
#         WHEN g_argv[1] = '1'   #axrq130
#            LET g_xmdk_d[li_ac].xmdl038 = g_xmdk_d[li_ac].xmdl022 - g_xmdk_d[li_ac].xmdl038
#         WHEN g_argv[1] = '2'   #axrq140
#            LET g_xmdk_d[li_ac].xmdl038 = g_xmdk_d[li_ac].xmdl022 - g_xmdk_d[li_ac].xmdl047
#      END CASE
#
#      #差異數量 = 計價數量 - 立帳數量 - 已開發票數量 - 立暫估數量
#      CASE
#         WHEN g_argv[1] = '1'   #axrq130
#      LET g_xmdk_d[li_ac].l_xmdl022diff = g_xmdk_d[li_ac].xmdl022 - g_xmdk_d[li_ac].l_xmdl0381 - g_xmdk_d[li_ac].xmdl053
#         WHEN g_argv[1] = '2'   #axrq140
#      LET g_xmdk_d[li_ac].l_xmdl022diff = g_xmdk_d[li_ac].xmdl022 - g_xmdk_d[li_ac].xmdl047
#      END CASE
#
#      #未匹配金額
#      IF NOT cl_null(g_xmdk_d[li_ac].xmdl025) THEN
#         IF g_xmdk_d[li_ac].xmdl038 <> g_xmdk_d[li_ac].xmdl022 THEN
#            LET g_xmdk_d[li_ac].xmdl027 = g_xmdk_d[li_ac].xmdl027 * (g_xmdk_d[li_ac].xmdl038 /  g_xmdk_d[li_ac].xmdl022)
#            LET g_xmdk_d[li_ac].xmdl028 = g_xmdk_d[li_ac].xmdl028 * (g_xmdk_d[li_ac].xmdl038 /  g_xmdk_d[li_ac].xmdl022)
#            LET g_xmdk_d[li_ac].xmdl029 = g_xmdk_d[li_ac].xmdl029 * (g_xmdk_d[li_ac].xmdl038 /  g_xmdk_d[li_ac].xmdl022)
#         END IF
#         LET g_xmdk_d[li_ac].l_xmdl0271 = g_xmdk_d[li_ac].xmdl027 * g_xmdk_d[li_ac].xmdk017
#         LET g_xmdk_d[li_ac].l_xmdl0281 = g_xmdk_d[li_ac].xmdl028 * g_xmdk_d[li_ac].xmdk017
#         LET g_xmdk_d[li_ac].l_xmdl0291 = g_xmdk_d[li_ac].xmdl029 * g_xmdk_d[li_ac].xmdk017
#      END IF
#
#      #差異金額 出貨金额－未立账金额－正常立账金额－暂估立账金额
#      LET g_xmdk_d[li_ac].l_xrcb103diff = g_xmdk_d[li_ac].l_xmdl0272 - g_xmdk_d[li_ac].xmdl027 - g_xmdk_d[li_ac].xrcb103 - g_xmdk_d[li_ac].xrcf103
#      LET g_xmdk_d[li_ac].l_xrcb104diff = g_xmdk_d[li_ac].l_xmdl0292 - g_xmdk_d[li_ac].xmdl029 - g_xmdk_d[li_ac].xrcb104 - g_xmdk_d[li_ac].xrcf104
#      LET g_xmdk_d[li_ac].l_xrcb105diff = g_xmdk_d[li_ac].l_xmdl0282 - g_xmdk_d[li_ac].xmdl028 - g_xmdk_d[li_ac].xrcb105 - g_xmdk_d[li_ac].xrcf105
#
#      IF g_xmdk_d[li_ac].xmdk000 = '6' THEN
#         LET g_xmdk_d[li_ac].l_xmdl022diff = g_xmdk_d[li_ac].l_xmdl022diff * -1
#         LET g_xmdk_d[li_ac].xmdl022 = g_xmdk_d[li_ac].xmdl022 * -1
#         LET g_xmdk_d[li_ac].xmdl038 = g_xmdk_d[li_ac].xmdl038 * -1
#         LET g_xmdk_d[li_ac].l_xmdl0381= g_xmdk_d[li_ac].l_xmdl0381* -1
#         LET g_xmdk_d[li_ac].xmdl053 = g_xmdk_d[li_ac].xmdl053 * -1
#         LET g_xmdk_d[li_ac].xmdl047 = g_xmdk_d[li_ac].xmdl047 * -1
#         LET g_xmdk_d[li_ac].xmdl027 = g_xmdk_d[li_ac].xmdl027 * -1
#         LET g_xmdk_d[li_ac].xmdl029 = g_xmdk_d[li_ac].xmdl029 * -1
#         LET g_xmdk_d[li_ac].xmdl028 = g_xmdk_d[li_ac].xmdl028 * -1
#         LET g_xmdk_d[li_ac].l_xmdl0271= g_xmdk_d[li_ac].l_xmdl0271* -1
#         LET g_xmdk_d[li_ac].l_xmdl0291= g_xmdk_d[li_ac].l_xmdl0291* -1
#         LET g_xmdk_d[li_ac].l_xmdl0281= g_xmdk_d[li_ac].l_xmdl0281* -1
#         LET g_xmdk_d[li_ac].l_xmdl0272= g_xmdk_d[li_ac].l_xmdl0272* -1
#         LET g_xmdk_d[li_ac].l_xmdl0292= g_xmdk_d[li_ac].l_xmdl0292* -1
#         LET g_xmdk_d[li_ac].l_xmdl0282= g_xmdk_d[li_ac].l_xmdl0282* -1
#         LET g_xmdk_d[li_ac].xrcb103 = g_xmdk_d[li_ac].xrcb103 * -1
#         LET g_xmdk_d[li_ac].xrcb104 = g_xmdk_d[li_ac].xrcb104 * -1
#         LET g_xmdk_d[li_ac].xrcb105 = g_xmdk_d[li_ac].xrcb105 * -1
#         LET g_xmdk_d[li_ac].xrcf103 = g_xmdk_d[li_ac].xrcf103 * -1
#         LET g_xmdk_d[li_ac].xrcf104 = g_xmdk_d[li_ac].xrcf104 * -1
#         LET g_xmdk_d[li_ac].xrcf105 = g_xmdk_d[li_ac].xrcf105 * -1
#         LET g_xmdk_d[li_ac].xrcb113 = g_xmdk_d[li_ac].xrcb113 * -1
#         LET g_xmdk_d[li_ac].xrcb114 = g_xmdk_d[li_ac].xrcb114 * -1
#         LET g_xmdk_d[li_ac].xrcb115 = g_xmdk_d[li_ac].xrcb115 * -1
#         LET g_xmdk_d[li_ac].l_xrcb103diff = g_xmdk_d[li_ac].l_xrcb103diff * -1
#         LET g_xmdk_d[li_ac].l_xrcb104diff = g_xmdk_d[li_ac].l_xrcb104diff * -1
#         LET g_xmdk_d[li_ac].l_xrcb105diff = g_xmdk_d[li_ac].l_xrcb105diff * -1
#      END IF

#      LET l_xmdldocno = g_xmdk_d[li_ac].xmdldocno
#      IF g_xrca_m.b_check = 'Y' THEN
#         LET l_xmdk_d.xmdl022      = g_xmdk_d[li_ac].xmdl022       + l_xmdk_d.xmdl022
#         LET l_xmdk_d.xmdl038      = g_xmdk_d[li_ac].xmdl038       + l_xmdk_d.xmdl038
#         LET l_xmdk_d.l_xmdl0381   = g_xmdk_d[li_ac].l_xmdl0381    + l_xmdk_d.l_xmdl0381
#         LET l_xmdk_d.xmdl053      = g_xmdk_d[li_ac].xmdl053       + l_xmdk_d.xmdl053
#         LET l_xmdk_d.xmdl047      = g_xmdk_d[li_ac].xmdl047       + l_xmdk_d.xmdl047
#         LET l_xmdk_d.l_xmdl022diff= g_xmdk_d[li_ac].l_xmdl022diff + l_xmdk_d.l_xmdl022diff
#         LET l_xmdk_d.l_xmdl0272   = g_xmdk_d[li_ac].l_xmdl0272    + l_xmdk_d.l_xmdl0272
#         LET l_xmdk_d.l_xmdl0292   = g_xmdk_d[li_ac].l_xmdl0292    + l_xmdk_d.l_xmdl0292
#         LET l_xmdk_d.l_xmdl0282   = g_xmdk_d[li_ac].l_xmdl0282    + l_xmdk_d.l_xmdl0282
#         LET l_xmdk_d.xmdl027      = g_xmdk_d[li_ac].xmdl027       + l_xmdk_d.xmdl027
#         LET l_xmdk_d.xmdl029      = g_xmdk_d[li_ac].xmdl029       + l_xmdk_d.xmdl029
#         LET l_xmdk_d.xmdl028      = g_xmdk_d[li_ac].xmdl028       + l_xmdk_d.xmdl028
#         LET l_xmdk_d.xrcb103      = g_xmdk_d[li_ac].xrcb103       + l_xmdk_d.xrcb103
#         LET l_xmdk_d.xrcb104      = g_xmdk_d[li_ac].xrcb104       + l_xmdk_d.xrcb104
#         LET l_xmdk_d.xrcb105      = g_xmdk_d[li_ac].xrcb105       + l_xmdk_d.xrcb105
#         LET l_xmdk_d.xrcf103      = g_xmdk_d[li_ac].xrcf103       + l_xmdk_d.xrcf103
#         LET l_xmdk_d.xrcf104      = g_xmdk_d[li_ac].xrcf104       + l_xmdk_d.xrcf104
#         LET l_xmdk_d.xrcf105      = g_xmdk_d[li_ac].xrcf105       + l_xmdk_d.xrcf105
#         LET l_xmdk_d.l_xrcb103diff= g_xmdk_d[li_ac].l_xrcb103diff + l_xmdk_d.l_xrcb103diff
#         LET l_xmdk_d.l_xrcb104diff= g_xmdk_d[li_ac].l_xrcb104diff + l_xmdk_d.l_xrcb104diff
#         LET l_xmdk_d.l_xrcb105diff= g_xmdk_d[li_ac].l_xrcb105diff + l_xmdk_d.l_xrcb105diff
#         LET l_xmdk_d.l_xmdl0271   = g_xmdk_d[li_ac].l_xmdl0271    + l_xmdk_d.l_xmdl0271
#         LET l_xmdk_d.l_xmdl0291   = g_xmdk_d[li_ac].l_xmdl0291    + l_xmdk_d.l_xmdl0291
#         LET l_xmdk_d.l_xmdl0281   = g_xmdk_d[li_ac].l_xmdl0281    + l_xmdk_d.l_xmdl0281
#         LET l_xmdk_d.xrcb113      = g_xmdk_d[li_ac].xrcb113       + l_xmdk_d.xrcb113
#         LET l_xmdk_d.xrcb114      = g_xmdk_d[li_ac].xrcb114       + l_xmdk_d.xrcb114
#         LET l_xmdk_d.xrcb115      = g_xmdk_d[li_ac].xrcb115       + l_xmdk_d.xrcb115
#      END IF
#160505-00007#21--mark--end
      LET li_ac = li_ac + 1
   END FOREACH
   
   #160505-00007#21--add--str--
   IF li_ac > 1 AND g_xrca_m.b_check = 'Y' THEN
      #當前行清空後,做小計
      LET g_xmdk_d[li_ac].* = g_xmdk_d_t.*
      LET g_xmdk_d[li_ac].xmdldocno = l_gzzd005
      EXECUTE axrq130_sum_pr USING g_xmdk_d[li_ac-1].xmdldocno
         INTO g_xmdk_d[li_ac].xmdl022,g_xmdk_d[li_ac].xmdl038,g_xmdk_d[li_ac].l_xmdl0381,g_xmdk_d[li_ac].xmdl053,
              g_xmdk_d[li_ac].xmdl047,g_xmdk_d[li_ac].l_xmdl022diff,g_xmdk_d[li_ac].l_xmdl0272,g_xmdk_d[li_ac].l_xmdl0292,
              g_xmdk_d[li_ac].l_xmdl0282,g_xmdk_d[li_ac].xmdl027,g_xmdk_d[li_ac].xmdl029,g_xmdk_d[li_ac].xmdl028,
              g_xmdk_d[li_ac].xrcb103,g_xmdk_d[li_ac].xrcb104,g_xmdk_d[li_ac].xrcb105,g_xmdk_d[li_ac].xrcf103,
              g_xmdk_d[li_ac].xrcf104,g_xmdk_d[li_ac].xrcf105,g_xmdk_d[li_ac].l_xrcb103diff,g_xmdk_d[li_ac].l_xrcb104diff,
              g_xmdk_d[li_ac].l_xrcb105diff,g_xmdk_d[li_ac].l_xmdl0271,g_xmdk_d[li_ac].l_xmdl0291,
              g_xmdk_d[li_ac].l_xmdl0281,g_xmdk_d[li_ac].xrcb113,g_xmdk_d[li_ac].xrcb114,g_xmdk_d[li_ac].xrcb115
   ELSE
      CALL g_xmdk_d.deleteElement(g_xmdk_d.getLength())
   END IF
   #160505-00007#21--add--end
   
#160505-00007#21--mark--str--  
#      IF g_xrca_m.b_check = 'Y' THEN
#         #當前行清空後,做小計
#         LET g_xmdk_d[li_ac].* = g_xmdk_d_t.*
#         SELECT gzzd005 INTO g_xmdk_d[li_ac].xmdldocno FROM gzzd_t WHERE gzzd001 = 'axrq130'
#            AND gzzd003 = 'lbl_total' AND gzzd002 = g_lang
#         LET g_xmdk_d[li_ac].xmdl022    = l_xmdk_d.xmdl022
#         LET g_xmdk_d[li_ac].xmdl038    = l_xmdk_d.xmdl038
#         LET g_xmdk_d[li_ac].l_xmdl0381   = l_xmdk_d.l_xmdl0381
#         LET g_xmdk_d[li_ac].xmdl053    = l_xmdk_d.xmdl053
#         LET g_xmdk_d[li_ac].xmdl047    = l_xmdk_d.xmdl047
#         LET g_xmdk_d[li_ac].l_xmdl022diff= l_xmdk_d.l_xmdl022diff
#         LET g_xmdk_d[li_ac].l_xmdl0272   = l_xmdk_d.l_xmdl0272
#         LET g_xmdk_d[li_ac].l_xmdl0292   = l_xmdk_d.l_xmdl0292
#         LET g_xmdk_d[li_ac].l_xmdl0282   = l_xmdk_d.l_xmdl0282
#         LET g_xmdk_d[li_ac].xmdl027    = l_xmdk_d.xmdl027
#         LET g_xmdk_d[li_ac].xmdl029    = l_xmdk_d.xmdl029
#         LET g_xmdk_d[li_ac].xmdl028    = l_xmdk_d.xmdl028
#         LET g_xmdk_d[li_ac].xrcb103    = l_xmdk_d.xrcb103
#         LET g_xmdk_d[li_ac].xrcb104    = l_xmdk_d.xrcb104
#         LET g_xmdk_d[li_ac].xrcb105    = l_xmdk_d.xrcb105
#         LET g_xmdk_d[li_ac].xrcf103    = l_xmdk_d.xrcf103
#         LET g_xmdk_d[li_ac].xrcf104    = l_xmdk_d.xrcf104
#         LET g_xmdk_d[li_ac].xrcf105    = l_xmdk_d.xrcf105
#         LET g_xmdk_d[li_ac].l_xrcb103diff= l_xmdk_d.l_xrcb103diff
#         LET g_xmdk_d[li_ac].l_xrcb104diff= l_xmdk_d.l_xrcb104diff
#         LET g_xmdk_d[li_ac].l_xrcb105diff= l_xmdk_d.l_xrcb105diff
#         LET g_xmdk_d[li_ac].l_xmdl0271   = l_xmdk_d.l_xmdl0271
#         LET g_xmdk_d[li_ac].l_xmdl0291   = l_xmdk_d.l_xmdl0291
#         LET g_xmdk_d[li_ac].l_xmdl0281   = l_xmdk_d.l_xmdl0281
#         LET g_xmdk_d[li_ac].xrcb113    = l_xmdk_d.xrcb113
#         LET g_xmdk_d[li_ac].xrcb114    = l_xmdk_d.xrcb114
#         LET g_xmdk_d[li_ac].xrcb115    = l_xmdk_d.xrcb115
#         LET li_ac = li_ac + 1
#      ELSE
#         CALL g_xmdk_d.deleteElement(g_xmdk_d.getLength())
#      END IF
#160505-00007#21--mark--end

   LET g_error_show = 0

   UPDATE axrq130_tmp01 SET xmdk007 = xmdk007||'('||xrcasite_desc||')',            #160727-00019#6   2016/07/28 By 08734   axrq130_print_tmp ——> axrq130_tmp01
                                xmdk000 = xmdk000||':'||xrcald_desc


   UPDATE axrq130_tmp01 SET xrcasite_desc = l_xrcasite_desc,            #160727-00019#6   2016/07/28 By 08734   axrq130_print_tmp ——> axrq130_tmp01
                                xrcald_desc   = l_xrcald_desc

   #161226-00063#1--add--str--lujh
   #总计
   LET l_sql="SELECT SUM(xmdl018),SUM(xmdl022),SUM(xmdl038),SUM(l_xmdl0381),SUM(xmdl053),",   #161206-00017#1 add xmdl018 lujh
             "       SUM(l_xmdl0272),SUM(l_xmdl0292),SUM(l_xmdl0282),SUM(xmdl027),SUM(xmdl029),SUM(xmdl028),",
             "       SUM(xrcb103),SUM(xrcb104),SUM(xrcb105),SUM(xrcf103),SUM(xrcf104),SUM(xrcf105),",
             "       SUM(l_xrcb103diff),SUM(l_xrcb104diff),SUM(l_xrcb105diff),SUM(l_xmdl0271),",
             "       SUM(l_xmdl0291),SUM(l_xmdl0281),SUM(xrcb113),SUM(xrcb114),SUM(xrcb115)",
             "  FROM axrq130_tmp01 ",                     
             " WHERE xmdldocno IS NOT NULL ",
             "   AND xmdlseq IS NOT NULL ",                
             "   AND ",g_wc_filter
   PREPARE axrq130_tot_sum_pr FROM l_sql
   EXECUTE axrq130_tot_sum_pr INTO l_sum_xmdl018,l_sum_xmdl022,l_sum_xmdl038,l_sum_xmdl0381,l_sum_xmdl053,   #161206-00017#1 add l_sum_xmdl018 lujh
                                   l_sum_xmdl0272,l_sum_xmdl0292,l_sum_xmdl0282,l_sum_xmdl027,
                                   l_sum_xmdl029,l_sum_xmdl028,l_sum_xrcb103,l_sum_xrcb104,
                                   l_sum_xrcb105,l_sum_xrcf103,l_sum_xrcf105,l_sum_xrcb103diff,
                                   l_sum_xrcb104diff,l_sum_xrcb105diff,l_sum_xmdl0271,l_sum_xmdl0291,
                                   l_sum_xmdl0281,l_sum_xrcb113,l_sum_xrcb114,l_sum_xrcb115
                                   
   DISPLAY l_sum_xmdl018,l_sum_xmdl022,l_sum_xmdl038,l_sum_xmdl0381,l_sum_xmdl053,   #161206-00017#1 l_sum_xmdl018 lujh
           l_sum_xmdl0272,l_sum_xmdl0292,l_sum_xmdl0282,l_sum_xmdl027,
           l_sum_xmdl029,l_sum_xmdl028,l_sum_xrcb103,l_sum_xrcb104,
           l_sum_xrcb105,l_sum_xrcf103,l_sum_xrcf105,l_sum_xrcb103diff,
           l_sum_xrcb104diff,l_sum_xrcb105diff,l_sum_xmdl0271,l_sum_xmdl0291,
           l_sum_xmdl0281,l_sum_xrcb113,l_sum_xrcb114,l_sum_xrcb115      
        TO sum_xmdl018,sum_xmdl022,sum_xmdl038,sum_xmdl0381,sum_xmdl053,  #161206-00017#1 add sum_xmdl018 lujh
           sum_xmdl0272,sum_xmdl0292,sum_xmdl0282,sum_xmdl027,
           sum_xmdl029,sum_xmdl028,sum_xrcb103,sum_xrcb104,
           sum_xrcb105,sum_xrcf103,sum_xrcf105,sum_xrcb103diff,
           sum_xrcb104diff,sum_xrcb105diff,sum_xmdl0271,sum_xmdl0291,
           sum_xmdl0281,sum_xrcb113,sum_xrcb114,sum_xrcb115             
   #161226-00063#1--add--end--lujh


   LET g_detail_cnt = g_xmdk_d.getLength()
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET g_detail_idx = 1
   DISPLAY g_detail_idx TO FORMONLY.h_index
   LET l_ac = g_cnt
   LET g_cnt = 0

   CALL axrq130_filter_show('xmdk007','b_xmdk007')
   CALL axrq130_filter_show('xmdk000','b_xmdk000')
   CALL axrq130_filter_show('xmdkdocdt','b_xmdkdocdt')
   CALL axrq130_filter_show('xmdk001','b_xmdk001')
   CALL axrq130_filter_show('xmdldocno','b_xmdldocno')
   CALL axrq130_filter_show('xmdlseq','b_xmdlseq')
   CALL axrq130_filter_show('xmdl008','b_xmdl008')
   CALL axrq130_filter_show('imaal003','b_imaal003')
   CALL axrq130_filter_show('imaal004','b_imaal004')
   CALL axrq130_filter_show('xmdl007','b_xmdl007')
   CALL axrq130_filter_show('pmaa091','b_pmaa091')  
   CALL axrq130_filter_show('xmdl018','b_xmdl018')   #161206-00017#1 add lujh
   CALL axrq130_filter_show('xmdl022','b_xmdl022') 
   CALL axrq130_filter_show('xmdl038','b_xmdl038')
   CALL axrq130_filter_show('xmdl0381','b_xmdl0381')
   CALL axrq130_filter_show('xmdl053','b_xmdl053')
   CALL axrq130_filter_show('xmdl047','b_xmdl047')
   CALL axrq130_filter_show('xmdl022diff','b_xmdl022diff')
   CALL axrq130_filter_show('xmdk016','b_xmdk016')
   CALL axrq130_filter_show('xmdl003','b_xmdl003')
   CALL axrq130_filter_show('xmdl004','b_xmdl004')
   CALL axrq130_filter_show('xmdl049','b_xmdl049')
   CALL axrq130_filter_show('xmdk017','b_xmdk017')
   CALL axrq130_filter_show('xmdl025','b_xmdl025')
   CALL axrq130_filter_show('xmdl026','b_xmdl026')
   CALL axrq130_filter_show('xmdl024','b_xmdl024')
   CALL axrq130_filter_show('xmdl0272','b_xmdl0272')
   CALL axrq130_filter_show('xmdl0292','b_xmdl0292')
   CALL axrq130_filter_show('xmdl0282','b_xmdl0282')
   CALL axrq130_filter_show('xmdl027','b_xmdl027')
   CALL axrq130_filter_show('xmdl029','b_xmdl029')
   CALL axrq130_filter_show('xmdl028','b_xmdl028')
   CALL axrq130_filter_show('xrcb103','b_xrcb103')
   CALL axrq130_filter_show('xrcb104','b_xrcb104')
   CALL axrq130_filter_show('xrcb105','b_xrcb105')
   CALL axrq130_filter_show('xrcf103','b_xrcf103')
   CALL axrq130_filter_show('xrcf104','b_xrcf104')
   CALL axrq130_filter_show('xrcf105','b_xrcf105')
   CALL axrq130_filter_show('xrcb103diff','b_xrcb103diff')
   CALL axrq130_filter_show('xrcb104diff','b_xrcb104diff')
   CALL axrq130_filter_show('xrcb105diff','b_xrcb105diff')
   CALL axrq130_filter_show('xmdl0271','b_xmdl0271')
   CALL axrq130_filter_show('xmdl0291','b_xmdl0291')
   CALL axrq130_filter_show('xmdl0281','b_xmdl0281')
   CALL axrq130_filter_show('xrca101','b_xrca101')   #161206-00017#1 add lujh
   CALL axrq130_filter_show('xrcb113','b_xrcb113')
   CALL axrq130_filter_show('xrcb114','b_xrcb114')
   CALL axrq130_filter_show('xrcb115','b_xrcb115')
   CALL axrq130_filter_show('xrcadocno','b_xrcadocno')
   CALL axrq130_filter_show('xrcad2','b_xrcad2')

   IF cl_null(g_xmdk_d[1].xmdldocno) THEN
      #無符合條件資料
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'aap-00313'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF

END FUNCTION

################################################################################
# Descriptions...: 描述说明
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
PRIVATE FUNCTION axrq130_b_fill3_bak()
{   DEFINE li_ac           LIKE type_t.num5
   DEFINE l_sql           STRING
   DEFINE l_xmdl038       STRING
   DEFINE l_xmdl053       STRING
   DEFINE l_s             LIKE type_t.chr1 
   DEFINE l_success       LIKE type_t.chr1 
   DEFINE l_xrcd103       LIKE xrcd_t.xrcd103
   DEFINE l_xrcd104       LIKE xrcd_t.xrcd104
   DEFINE l_xrcd105       LIKE xrcd_t.xrcd105
   DEFINE l_xmdldocno     LIKE xmdl_t.xmdldocno
   DEFINE l_xmdk_d        type_g_xmdk_d
   DEFINE l_xrcasite_desc LIKE type_t.chr500
   DEFINE l_xrcald_desc   LIKE type_t.chr500
   DEFINE l_xmdk000       LIKE type_t.chr80
   DEFINE l_xmdk007_desc  LIKE type_t.chr80 #151203-00013#5
 
   CALL s_fin_account_center_with_ld_chk(g_xrca_m.xrcasite,g_xrca_m.xrcald,g_user,'3','N','',g_today) RETURNING l_success,g_errno
   IF NOT cl_null(g_errno) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = g_errno
      LET g_errparam.extend = g_xrca_m.xrcasite
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET g_xrca_m.xrcasite = ''
      LET g_xrca_m.xrcasite_desc = ''
      DISPLAY BY NAME g_xrca_m.xrcasite,g_xrca_m.xrcasite_desc
      RETURN
   END IF
 
   #yangtt-2015/05/25---XG
   CALL axrq130_create_tmp()
   DELETE FROM axrq130_tmp01             #160727-00019#6   2016/07/28 By 08734   axrq130_print_tmp ——> axrq130_tmp01
   LET l_xrcasite_desc = g_xrca_m.xrcasite,"     ",g_xrca_m.xrcasite_desc
   LET l_xrcald_desc = g_xrca_m.xrcald,"    ",g_xrca_m.xrcald_desc,"   ",g_xrca_m.xrcacomp
   #yangtt-2015/05/25---XG
 
   LET li_ac = l_ac

   CALL axrq130_get_wc()
   CALL g_xmdk_d.clear()
   
   
   CALL s_axrt300_sel_ld(g_xrca_m.xrcald) RETURNING l_success,l_s
   CASE
      WHEN l_s = '1'
         LET l_xmdl038 = 'xmdl038'   LET l_xmdl053 = 'xmdl053'
      WHEN l_s = '2'
         LET l_xmdl038 = 'xmdl039'   LET l_xmdl053 = 'xmdl054'
      WHEN l_s = '3'
         LET l_xmdl038 = 'xmdl040'   LET l_xmdl053 = 'xmdl055'
   END CASE
   
  #IF g_argv[1] = '2' THEN  
  #   LET l_xmdl038 = 'xmdl047'
  #   LET l_xmdl053 = '0'
  #END IF

   #LET l_sql = "SELECT 'N',xmdksite,xmdk007,xmdk000,xmdkdocdt,xmdk001,xmdkdocno,xmdlseq,xmdk003,'',xmdk004,'',xmdl014,'',xmdl008,'','',xmdl007,'','','','',xmdl022,", #151102-00008#2 add xmdl007 #151203-00013#1 mark
   LET l_sql = "SELECT 'N',xmdksite,xmdk007,'',xmdk000,xmdkdocdt,xmdk001,xmdkdocno,xmdlseq,xmdk003,'',xmdk004,'',xmdl014,'',xmdl008,'','',xmdl007,'','','','','','',xmdl022,", #151203-00013#1 add pmaa091,pmaa091_desc
                       l_xmdl038,",",l_xmdl038,",",l_xmdl053,",xmdl047,0,xmdk016,",
               "       xmdl003,xmdl004,CASE WHEN (xmdk000 IN ('1', '2', '3')) THEN xmdk037 ",   #150902-00001#2
               "                            WHEN (xmdk000 ='6') THEN xmdl049 END,",             #150902-00001#2
               "       xmdk017,xmdl025,xmdl026,xmdl024,xmdl027,xmdl029,xmdl028,xmdl027,xmdl029,xmdl028,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'','' ",  #150924-00012#2 add xrcadocno #151019-00009#2 add xrcad2
               "  FROM xmdk_t,xmdl_t",
               " WHERE xmdkent = xmdlent",
               "   AND xmdldocno = xmdkdocno",
              #151123-00013#6 Mark ---(S)---
              # "   AND xmdk000 IN ('1','2','3','6') ",
              ##"   AND ((xmdk000 <> 6 AND xmdk002 = '1') OR xmdk000 = '6')",   #150309-00036#1 Mark
              # "   AND ((xmdk000 <> '6' AND xmdk002 = '1') OR (xmdk000 = '6' AND xmdk082 <> '5'))",   #150309-00036#1 Add
              # "   AND xmdkstus = 'S' ",
              #151123-00013#6 Mark ---(S)---
              #151123-00013#6 Add  ---(S)---
               " AND ((xmdk000 IN ('1', '2', '3') AND xmdkstus = 'S' AND xmdk002 = '1') OR (xmdk000 IN ('4', '5') AND xmdkstus = 'Y' AND xmdk002 = '3') OR (xmdk000 = '6' AND xmdk082 <> '5'))",
              #151123-00013#6 Add  ---(S)---
               "   AND xmdkent = '",g_enterprise,"' AND ",g_wc1,
               " ORDER BY xmdk007,xmdk000,xmdkdocdt,xmdk001,xmdldocno"
   PREPARE axrq130_sel_prep FROM l_sql
   DECLARE axrq130_sel_curs CURSOR FOR axrq130_sel_prep

   LET li_ac = 1
   LET l_xmdldocno = NULL
   INITIALIZE l_xmdk_d.* TO NULL
   INITIALIZE g_xmdk_d_t.* TO NULL
   #20150525 Add ---(S)---
   LET l_xmdk_d.xmdl022    = 0
   LET l_xmdk_d.xmdl038    = 0
   LET l_xmdk_d.l_xmdl0381   = 0
   LET l_xmdk_d.xmdl053    = 0
   LET l_xmdk_d.xmdl047    = 0
   LET l_xmdk_d.l_xmdl022diff= 0
   LET l_xmdk_d.l_xmdl0272   = 0
   LET l_xmdk_d.l_xmdl0292   = 0
   LET l_xmdk_d.l_xmdl0282   = 0
   LET l_xmdk_d.xmdl027    = 0
   LET l_xmdk_d.xmdl029    = 0
   LET l_xmdk_d.xmdl028    = 0
   LET l_xmdk_d.xrcb103    = 0
   LET l_xmdk_d.xrcb104    = 0
   LET l_xmdk_d.xrcb105    = 0
   LET l_xmdk_d.xrcf103    = 0
   LET l_xmdk_d.xrcf104    = 0
   LET l_xmdk_d.xrcf105    = 0
   LET l_xmdk_d.l_xrcb103diff= 0
   LET l_xmdk_d.l_xrcb104diff= 0
   LET l_xmdk_d.l_xrcb105diff= 0
   LET l_xmdk_d.l_xmdl0271   = 0
   LET l_xmdk_d.l_xmdl0291   = 0
   LET l_xmdk_d.l_xmdl0281   = 0
   LET l_xmdk_d.xrcb113    = 0
   LET l_xmdk_d.xrcb114    = 0
   LET l_xmdk_d.xrcb115    = 0
   #20150525 Add ---(E)---
   FOREACH axrq130_sel_curs INTO g_xmdk_d[li_ac].*
      IF NOT cl_null(l_xmdldocno) AND l_xmdldocno <> g_xmdk_d[li_ac].xmdldocno AND g_xrca_m.b_check = 'Y' THEN
         #出現新的單據編號,則將當前資料下移一行
         LET g_xmdk_d[li_ac + 1].* = g_xmdk_d[li_ac].*
         #當前行清空後,做小計
         LET g_xmdk_d[li_ac].* = g_xmdk_d_t.*
         SELECT gzzd005 INTO g_xmdk_d[li_ac].xmdldocno FROM gzzd_t WHERE gzzd001 = 'axrq130'
            AND gzzd003 = 'lbl_total' AND gzzd002 = g_lang
         LET g_xmdk_d[li_ac].xmdl022    = l_xmdk_d.xmdl022
         LET g_xmdk_d[li_ac].xmdl038    = l_xmdk_d.xmdl038
         LET g_xmdk_d[li_ac].l_xmdl0381   = l_xmdk_d.l_xmdl0381
         LET g_xmdk_d[li_ac].xmdl053    = l_xmdk_d.xmdl053
         LET g_xmdk_d[li_ac].xmdl047    = l_xmdk_d.xmdl047
         LET g_xmdk_d[li_ac].l_xmdl022diff= l_xmdk_d.l_xmdl022diff
         LET g_xmdk_d[li_ac].l_xmdl0272   = l_xmdk_d.l_xmdl0272
         LET g_xmdk_d[li_ac].l_xmdl0292   = l_xmdk_d.l_xmdl0292
         LET g_xmdk_d[li_ac].l_xmdl0282   = l_xmdk_d.l_xmdl0282
         LET g_xmdk_d[li_ac].xmdl027    = l_xmdk_d.xmdl027
         LET g_xmdk_d[li_ac].xmdl029    = l_xmdk_d.xmdl029
         LET g_xmdk_d[li_ac].xmdl028    = l_xmdk_d.xmdl028
         LET g_xmdk_d[li_ac].xrcb103    = l_xmdk_d.xrcb103
         LET g_xmdk_d[li_ac].xrcb104    = l_xmdk_d.xrcb104
         LET g_xmdk_d[li_ac].xrcb105    = l_xmdk_d.xrcb105
         LET g_xmdk_d[li_ac].xrcf103    = l_xmdk_d.xrcf103
         LET g_xmdk_d[li_ac].xrcf104    = l_xmdk_d.xrcf104
         LET g_xmdk_d[li_ac].xrcf105    = l_xmdk_d.xrcf105
         LET g_xmdk_d[li_ac].l_xrcb103diff= l_xmdk_d.l_xrcb103diff
         LET g_xmdk_d[li_ac].l_xrcb104diff= l_xmdk_d.l_xrcb104diff
         LET g_xmdk_d[li_ac].l_xrcb105diff= l_xmdk_d.l_xrcb105diff
         LET g_xmdk_d[li_ac].l_xmdl0271   = l_xmdk_d.l_xmdl0271
         LET g_xmdk_d[li_ac].l_xmdl0291   = l_xmdk_d.l_xmdl0291
         LET g_xmdk_d[li_ac].l_xmdl0281   = l_xmdk_d.l_xmdl0281
         LET g_xmdk_d[li_ac].xrcb113    = l_xmdk_d.xrcb113
         LET g_xmdk_d[li_ac].xrcb114    = l_xmdk_d.xrcb114
         LET g_xmdk_d[li_ac].xrcb115    = l_xmdk_d.xrcb115
         
         #yangtt-2015/05/25---XG
         INSERT INTO axrq130_tmp01 VALUES(l_xrcasite_desc,l_xrcald_desc,                #160727-00019#6   2016/07/28 By 08734   axrq130_print_tmp ——> axrq130_tmp01
      g_xmdk_d[li_ac].xmdksite,g_xmdk_d[li_ac].xmdk007,g_xmdk_d[li_ac].xmdk000,g_xmdk_d[li_ac].xmdkdocdt, 
      g_xmdk_d[li_ac].xmdk001,g_xmdk_d[li_ac].xmdldocno,g_xmdk_d[li_ac].xmdlseq,g_xmdk_d[li_ac].xmdk003, 
      g_xmdk_d[li_ac].xmdk003_desc,g_xmdk_d[li_ac].xmdk004,g_xmdk_d[li_ac].xmdk004_desc,g_xmdk_d[li_ac].xmdl014, 
      g_xmdk_d[li_ac].xmdl014_desc,g_xmdk_d[li_ac].xmdl008,g_xmdk_d[li_ac].imaal003,g_xmdk_d[li_ac].imaal004,g_xmdk_d[li_ac].xmdl007, #151102-00008#2 add xmdl007
      g_xmdk_d[li_ac].imag011,g_xmdk_d[li_ac].imag011_desc,g_xmdk_d[li_ac].pmaa091,g_xmdk_d[li_ac].pmaa091_desc,g_xmdk_d[li_ac].glcc003,g_xmdk_d[li_ac].glcc003_desc, #151203-00013#1 add pmaa091
      g_xmdk_d[li_ac].xmdl022,g_xmdk_d[li_ac].xmdl038,g_xmdk_d[li_ac].l_xmdl0381,g_xmdk_d[li_ac].xmdl053, 
     #g_xmdk_d[li_ac].xmdl047,g_xmdk_d[li_ac].l_xmdl022diff,g_xmdk_d[li_ac].xmdk016,g_xmdk_d[li_ac].xmdk017,  #150902-00001#2 mark
      g_xmdk_d[li_ac].xmdl047,g_xmdk_d[li_ac].l_xmdl022diff,g_xmdk_d[li_ac].xmdk016,g_xmdk_d[li_ac].xmdl003,  #150902-00001#2
      g_xmdk_d[li_ac].xmdl004,g_xmdk_d[li_ac].xmdl049,g_xmdk_d[li_ac].xmdk017,                                #150902-00001#2
      g_xmdk_d[li_ac].xmdl025,g_xmdk_d[li_ac].xmdl026/100,g_xmdk_d[li_ac].xmdl024,g_xmdk_d[li_ac].l_xmdl0272, 
      g_xmdk_d[li_ac].l_xmdl0292,g_xmdk_d[li_ac].l_xmdl0282,g_xmdk_d[li_ac].xmdl027,g_xmdk_d[li_ac].xmdl029, 
      g_xmdk_d[li_ac].xmdl028,g_xmdk_d[li_ac].xrcb103,g_xmdk_d[li_ac].xrcb104,g_xmdk_d[li_ac].xrcb105, 
      g_xmdk_d[li_ac].xrcf103,g_xmdk_d[li_ac].xrcf104,g_xmdk_d[li_ac].xrcf105,g_xmdk_d[li_ac].l_xrcb103diff, 
      g_xmdk_d[li_ac].l_xrcb104diff,g_xmdk_d[li_ac].l_xrcb105diff,g_xmdk_d[li_ac].l_xmdl0271,g_xmdk_d[li_ac].l_xmdl0291, 
      g_xmdk_d[li_ac].l_xmdl0281,g_xmdk_d[li_ac].xrcb113,g_xmdk_d[li_ac].xrcb114,g_xmdk_d[li_ac].xrcb115,g_xmdk_d[li_ac].xrcadocno,g_xmdk_d[li_ac].xrcad2,'1')  #150924-00012#2 add xrcadocno #151019-00009#2 add xrcad2
         #yangtt-2015/05/25---XG

         LET l_xmdk_d.xmdl022    = 0
         LET l_xmdk_d.xmdl038    = 0
         LET l_xmdk_d.l_xmdl0381   = 0
         LET l_xmdk_d.xmdl053    = 0
         LET l_xmdk_d.xmdl047    = 0
         LET l_xmdk_d.l_xmdl022diff= 0
         LET l_xmdk_d.l_xmdl0272   = 0
         LET l_xmdk_d.l_xmdl0292   = 0
         LET l_xmdk_d.l_xmdl0282   = 0
         LET l_xmdk_d.xmdl027    = 0
         LET l_xmdk_d.xmdl029    = 0
         LET l_xmdk_d.xmdl028    = 0
         LET l_xmdk_d.xrcb103    = 0
         LET l_xmdk_d.xrcb104    = 0
         LET l_xmdk_d.xrcb105    = 0
         LET l_xmdk_d.xrcf103    = 0
         LET l_xmdk_d.xrcf104    = 0
         LET l_xmdk_d.xrcf105    = 0
         LET l_xmdk_d.l_xrcb103diff= 0
         LET l_xmdk_d.l_xrcb104diff= 0
         LET l_xmdk_d.l_xrcb105diff= 0
         LET l_xmdk_d.l_xmdl0271   = 0
         LET l_xmdk_d.l_xmdl0291   = 0
         LET l_xmdk_d.l_xmdl0281   = 0
         LET l_xmdk_d.xrcb113    = 0
         LET l_xmdk_d.xrcb114    = 0
         LET l_xmdk_d.xrcb115    = 0
         LET li_ac = li_ac + 1
      END IF

      #150924-00012#2-----s
      #應付單號
      LET g_xmdk_d[li_ac].xrcadocno = ''
      SELECT xrcadocno INTO g_xmdk_d[li_ac].xrcadocno
        FROM xrca_t,xrcb_t 
       WHERE xrcaent = g_enterprise AND xrcbent = xrcaent 
         AND xrcbld = xrcald AND xrcbdocno = xrcadocno
         AND xrcald = g_xrca_m.xrcald AND xrca001 NOT IN ('01','02','03','04')
         AND xrcb002 = g_xmdk_d[li_ac].xmdldocno AND xrcb003 = g_xmdk_d[li_ac].xmdlseq AND rownum = 1
         AND xrcastus <> 'X'   #albireo 151019 add
      #150924-00012#2-----e

      #151019-00009#2-----s
      #暫估單號
      LET g_xmdk_d[li_ac].xrcad2 = ''
      SELECT xrcadocno INTO g_xmdk_d[li_ac].xrcad2
        FROM xrca_t,xrcb_t 
       WHERE xrcaent = g_enterprise AND xrcbent = xrcaent 
         AND xrcbld = xrcald AND xrcbdocno = xrcadocno
         AND xrcald = g_xrca_m.xrcald AND xrca001 IN ('01','02','03','04')
         AND xrcb002 = g_xmdk_d[li_ac].xmdldocno AND xrcb003 = g_xmdk_d[li_ac].xmdlseq AND rownum = 1
         AND xrcastus <> 'X'
      #151019-00009#2-----e

      SELECT imag011 INTO g_xmdk_d[li_ac].imag011 FROM imag_t WHERE imagent = g_enterprise
         AND imagsite = g_glaa.glaacomp
         AND imag001 = g_xmdk_d[li_ac].xmdl008

      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_xmdk_d[li_ac].imag011
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='206' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_xmdk_d[li_ac].imag011_desc = '', g_rtn_fields[1] , ''

      CALL s_desc_get_person_desc(g_xmdk_d[li_ac].xmdk003) RETURNING g_xmdk_d[li_ac].xmdk003_desc
      CALL s_desc_get_department_desc(g_xmdk_d[li_ac].xmdk004) RETURNING g_xmdk_d[li_ac].xmdk004_desc
      CALL s_desc_get_stock_desc(g_xmdk_d[li_ac].xmdksite,g_xmdk_d[li_ac].xmdl014) RETURNING g_xmdk_d[li_ac].xmdl014_desc
      #CALL s_get_item_acc(g_xrca_m.xrcald,'4',g_xmdk_d[li_ac].xmdl008,'','','','') RETURNING l_success,g_xmdk_d[li_ac].glcc003   #151102-00008#2 mark
      #151102-00008#2---s
      LET g_xmdk_d[li_ac].glcc003 = ''
      LET g_xmdk_d[li_ac].glcc003_desc = ''
      SELECT xrcb021 INTO g_xmdk_d[li_ac].glcc003 FROM xrca_t 
        LEFT OUTER JOIN xrcb_t ON xrcbent = xrcaent AND xrcbld = xrcald AND xrcbdocno = xrcadocno AND xrcb023 <> 'Y'
       WHERE xrcaent = g_enterprise AND xrcald = g_xrca_m.xrcald AND xrcastus <> 'X'  AND xrcb002 = g_xmdk_d[li_ac].xmdldocno  AND xrcb003 = g_xmdk_d[li_ac].xmdlseq AND rownum = 1
      LET g_xmdk_d[li_ac].glcc003_desc = s_desc_get_account_desc(g_xrca_m.xrcald,g_xmdk_d[li_ac].glcc003)
      #151102-00008#2---e
      #CALL s_axrt300_xrca_ref('xrca035',g_xmdk_d[li_ac].glcc003,g_glaa.glaa004,'') RETURNING l_success,g_xmdk_d[li_ac].glcc003_desc     #151102-00008#2 mark
      SELECT imaal003,imaal004 INTO g_xmdk_d[li_ac].imaal003,g_xmdk_d[li_ac].imaal004 FROM imaal_t
       WHERE imaalent = g_enterprise
         AND imaal001 = g_xmdk_d[li_ac].xmdl008
         AND imaal002 = g_lang

      IF cl_null(g_xmdk_d[li_ac].xmdl025) THEN
         SELECT xmdk012 INTO g_xmdk_d[li_ac].xmdl025 FROM xmdk_t
          WHERE xmdkent = g_enterprise
            AND xmdkdocno = g_xmdk_d[li_ac].xmdldocno
      END IF

      #151203-00013#1 --s
      #價格群組
      SELECT DISTINCT pmaa091 INTO g_xmdk_d[li_ac].pmaa091 
        FROM pmaa_t 
       WHERE pmaaent = g_enterprise AND pmaa001 = g_xmdk_d[li_ac].xmdk007
      
      CALL s_desc_get_acc_desc('283',g_xmdk_d[li_ac].pmaa091) RETURNING g_xmdk_d[li_ac].pmaa091_desc
      #151203-00013#1 --e

      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_xmdk_d[li_ac].xmdksite
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_xmdk_d[li_ac].xmdksite = g_xmdk_d[li_ac].xmdksite,'(', g_rtn_fields[1] , ')'

      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_xmdk_d[li_ac].xmdk007
      CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      #LET g_xmdk_d[li_ac].xmdk007 = g_xmdk_d[li_ac].xmdk007,'(', g_rtn_fields[1] , ')'    #151203-00013#5 mark
      LET g_xmdk_d[li_ac].xmdk007_desc = g_rtn_fields[1]                                   #151203-00013#5 
      LET l_xmdk007_desc = g_xmdk_d[li_ac].xmdk007,'(',g_xmdk_d[li_ac].xmdk007_desc,')'    #151203-00013#5 
      

      #未匹配數量
      IF cl_null(g_xmdk_d[li_ac].xmdl038) THEN LET g_xmdk_d[li_ac].xmdl038 = 0 END IF
      IF cl_null(g_xmdk_d[li_ac].xmdl047) THEN LET g_xmdk_d[li_ac].xmdl047 = 0 END IF
      CASE
         WHEN g_argv[1] = '1'   #axrq130
            LET g_xmdk_d[li_ac].xmdl038 = g_xmdk_d[li_ac].xmdl022 - g_xmdk_d[li_ac].xmdl038
         WHEN g_argv[1] = '2'   #axrq140
            LET g_xmdk_d[li_ac].xmdl038 = g_xmdk_d[li_ac].xmdl022 - g_xmdk_d[li_ac].xmdl047
      END CASE

      #立暫估數量
      IF cl_null(g_xmdk_d[li_ac].xmdl053) THEN LET g_xmdk_d[li_ac].xmdl053 = 0 END IF
      IF g_xmdk_d[li_ac].xmdl053 > 0 THEN  #出貨/銷退單有立暫估數才做暫估數量的計算
         #立暂估数 - 已沖暫估數量(已確認)
         SELECT g_xmdk_d[li_ac].xmdl053 - CASE WHEN SUM (xrcf007) IS NULL THEN 0 ELSE SUM(xrcf007) END,
                SUM(xrcf103),SUM(xrcf104),SUM(xrcf105)
           INTO g_xmdk_d[li_ac].xmdl053,g_xmdk_d[li_ac].xrcf103,g_xmdk_d[li_ac].xrcf104,g_xmdk_d[li_ac].xrcf105
           FROM xrcf_t,xrca_t,
                (SELECT xrcbdocno docno, xrcbseq seq
                   FROM xrca_t, xrcb_t
                  WHERE     xrcaent = xrcbent
                        AND xrcald = xrcbld
                        AND xrcadocno = xrcbdocno
                        AND xrca001 IN ('01', '02', '03', '04')
                        AND xrcb002 = g_xmdk_d[li_ac].xmdldocno
                        AND xrcb003 = g_xmdk_d[li_ac].xmdlseq
                        AND xrcald = g_xrca_m.xrcald
                        AND xrcaent = g_enterprise)
          WHERE     xrcfent = xrcaent
                AND xrcfdocno = xrcadocno
                AND xrcfld = xrcald
                AND xrcald = g_xrca_m.xrcald
                AND xrcaent = g_enterprise
                AND xrcf008 = docno
                AND xrcf009 = seq
                AND xrcastus = 'Y';
      END IF
      IF cl_null(g_xmdk_d[li_ac].xrcf103) THEN LET g_xmdk_d[li_ac].xrcf103 = 0 END IF
      IF cl_null(g_xmdk_d[li_ac].xrcf104) THEN LET g_xmdk_d[li_ac].xrcf104 = 0 END IF
      IF cl_null(g_xmdk_d[li_ac].xrcf105) THEN LET g_xmdk_d[li_ac].xrcf105 = 0 END IF

      #差異數量 = 計價數量 - 立帳數量 - 已開發票數量 - 立暫估數量
      CASE
         WHEN g_argv[1] = '1'   #axrq130
      LET g_xmdk_d[li_ac].l_xmdl022diff = g_xmdk_d[li_ac].xmdl022 - g_xmdk_d[li_ac].l_xmdl0381 - g_xmdk_d[li_ac].xmdl053
         WHEN g_argv[1] = '2'   #axrq140
      LET g_xmdk_d[li_ac].l_xmdl022diff = g_xmdk_d[li_ac].xmdl022 - g_xmdk_d[li_ac].xmdl047
      END CASE

      #未匹配金額
      IF NOT cl_null(g_xmdk_d[li_ac].xmdl025) THEN
         IF g_xmdk_d[li_ac].xmdl038 = g_xmdk_d[li_ac].xmdl022 THEN
            CALL s_tax_count(g_xrca_m.xrcasite,g_xmdk_d[li_ac].xmdl025,g_xmdk_d[li_ac].xmdl038 * g_xmdk_d[li_ac].xmdl024,g_xmdk_d[li_ac].xmdl038,g_xmdk_d[li_ac].xmdk016,g_xmdk_d[li_ac].xmdk017)
                      RETURNING l_xrcd103,l_xrcd104,l_xrcd105,
                                g_xmdk_d[li_ac].l_xmdl0271,g_xmdk_d[li_ac].l_xmdl0291,g_xmdk_d[li_ac].l_xmdl0281
         ELSE
            CALL s_tax_count(g_xrca_m.xrcasite,g_xmdk_d[li_ac].xmdl025,g_xmdk_d[li_ac].xmdl038 * g_xmdk_d[li_ac].xmdl024,g_xmdk_d[li_ac].xmdl038,g_xmdk_d[li_ac].xmdk016,g_xmdk_d[li_ac].xmdk017)
                      RETURNING g_xmdk_d[li_ac].xmdl027,g_xmdk_d[li_ac].xmdl029,g_xmdk_d[li_ac].xmdl028,
                                g_xmdk_d[li_ac].l_xmdl0271,g_xmdk_d[li_ac].l_xmdl0291,g_xmdk_d[li_ac].l_xmdl0281
         END IF
      END IF

      #已立帳金額
      IF g_argv[1] = '1' THEN
         SELECT SUM(xrcb103),SUM(xrcb104),SUM(xrcb105),SUM(xrcb113),SUM(xrcb114),SUM(xrcb115)
           INTO g_xmdk_d[li_ac].xrcb103,g_xmdk_d[li_ac].xrcb104,g_xmdk_d[li_ac].xrcb105,
                g_xmdk_d[li_ac].xrcb113,g_xmdk_d[li_ac].xrcb114,g_xmdk_d[li_ac].xrcb115
           FROM xrcb_t,xrca_t
          WHERE xrcaent = xrcbent AND xrcaent = g_enterprise
            AND xrcald  = xrcbld  AND xrcald  = g_xrca_m.xrcald
            AND xrcadocno = xrcbdocno
            AND xrca001 NOT IN ('01','02','03','04')
            AND xrcb002 = g_xmdk_d[li_ac].xmdldocno
            AND xrcb003 = g_xmdk_d[li_ac].xmdlseq
            AND xrcastus <> 'X'
      ELSE
         SELECT SUM(isag103),SUM(isag104),SUM(isag105)
           INTO g_xmdk_d[li_ac].xrcb103,g_xmdk_d[li_ac].xrcb104,g_xmdk_d[li_ac].xrcb105
           FROM isag_t
          WHERE isag002 =g_xmdk_d[li_ac].xmdldocno
            AND isag003 = g_xmdk_d[li_ac].xmdlseq
            AND isagent = g_enterprise
      END IF
      IF cl_null(g_xmdk_d[li_ac].xrcb103) THEN LET g_xmdk_d[li_ac].xrcb103 = 0 END IF
      IF cl_null(g_xmdk_d[li_ac].xrcb104) THEN LET g_xmdk_d[li_ac].xrcb104 = 0 END IF
      IF cl_null(g_xmdk_d[li_ac].xrcb105) THEN LET g_xmdk_d[li_ac].xrcb105 = 0 END IF
      IF cl_null(g_xmdk_d[li_ac].xrcb113) THEN LET g_xmdk_d[li_ac].xrcb113 = 0 END IF
      IF cl_null(g_xmdk_d[li_ac].xrcb114) THEN LET g_xmdk_d[li_ac].xrcb114 = 0 END IF
      IF cl_null(g_xmdk_d[li_ac].xrcb115) THEN LET g_xmdk_d[li_ac].xrcb115 = 0 END IF

      #暂估金额
      SELECT SUM(xrcb103) - g_xmdk_d[li_ac].xrcf103,SUM(xrcb104) - g_xmdk_d[li_ac].xrcf104,SUM(xrcb105) - g_xmdk_d[li_ac].xrcf105
        INTO g_xmdk_d[li_ac].xrcf103,g_xmdk_d[li_ac].xrcf104,g_xmdk_d[li_ac].xrcf105
       FROM xrcb_t,xrca_t
        WHERE xrcaent = xrcbent AND xrcaent = g_enterprise
          AND xrcald  = xrcbld  AND xrcald  = g_xrca_m.xrcald
          AND xrcadocno = xrcbdocno
          AND xrca001 IN ('01','02','03','04')
          AND xrcb002 = g_xmdk_d[li_ac].xmdldocno
          AND xrcb003 = g_xmdk_d[li_ac].xmdlseq
      IF cl_null(g_xmdk_d[li_ac].xrcf103) THEN LET g_xmdk_d[li_ac].xrcf103 = 0 END IF
      IF cl_null(g_xmdk_d[li_ac].xrcf104) THEN LET g_xmdk_d[li_ac].xrcf104 = 0 END IF
      IF cl_null(g_xmdk_d[li_ac].xrcf105) THEN LET g_xmdk_d[li_ac].xrcf105 = 0 END IF

      #差異金額 出貨金额－未立账金额－正常立账金额－暂估立账金额
      LET g_xmdk_d[li_ac].l_xrcb103diff = g_xmdk_d[li_ac].l_xmdl0272 - g_xmdk_d[li_ac].xmdl027 - g_xmdk_d[li_ac].xrcb103 - g_xmdk_d[li_ac].xrcf103
      LET g_xmdk_d[li_ac].l_xrcb104diff = g_xmdk_d[li_ac].l_xmdl0292 - g_xmdk_d[li_ac].xmdl029 - g_xmdk_d[li_ac].xrcb104 - g_xmdk_d[li_ac].xrcf104
      LET g_xmdk_d[li_ac].l_xrcb105diff = g_xmdk_d[li_ac].l_xmdl0282 - g_xmdk_d[li_ac].xmdl028 - g_xmdk_d[li_ac].xrcb105 - g_xmdk_d[li_ac].xrcf105

      IF g_xmdk_d[li_ac].xmdk000 = '6' THEN
         LET g_xmdk_d[li_ac].l_xmdl022diff = g_xmdk_d[li_ac].l_xmdl022diff * -1
         LET g_xmdk_d[li_ac].xmdl022 = g_xmdk_d[li_ac].xmdl022 * -1
         LET g_xmdk_d[li_ac].xmdl038 = g_xmdk_d[li_ac].xmdl038 * -1
         LET g_xmdk_d[li_ac].l_xmdl0381= g_xmdk_d[li_ac].l_xmdl0381* -1
         LET g_xmdk_d[li_ac].xmdl053 = g_xmdk_d[li_ac].xmdl053 * -1
         LET g_xmdk_d[li_ac].xmdl047 = g_xmdk_d[li_ac].xmdl047 * -1
         LET g_xmdk_d[li_ac].xmdl027 = g_xmdk_d[li_ac].xmdl027 * -1
         LET g_xmdk_d[li_ac].xmdl029 = g_xmdk_d[li_ac].xmdl029 * -1
         LET g_xmdk_d[li_ac].xmdl028 = g_xmdk_d[li_ac].xmdl028 * -1
         LET g_xmdk_d[li_ac].l_xmdl0271= g_xmdk_d[li_ac].l_xmdl0271* -1
         LET g_xmdk_d[li_ac].l_xmdl0291= g_xmdk_d[li_ac].l_xmdl0291* -1
         LET g_xmdk_d[li_ac].l_xmdl0281= g_xmdk_d[li_ac].l_xmdl0281* -1
         LET g_xmdk_d[li_ac].l_xmdl0272= g_xmdk_d[li_ac].l_xmdl0272* -1
         LET g_xmdk_d[li_ac].l_xmdl0292= g_xmdk_d[li_ac].l_xmdl0292* -1
         LET g_xmdk_d[li_ac].l_xmdl0282= g_xmdk_d[li_ac].l_xmdl0282* -1
         LET g_xmdk_d[li_ac].xrcb103 = g_xmdk_d[li_ac].xrcb103 * -1
         LET g_xmdk_d[li_ac].xrcb104 = g_xmdk_d[li_ac].xrcb104 * -1
         LET g_xmdk_d[li_ac].xrcb105 = g_xmdk_d[li_ac].xrcb105 * -1
         LET g_xmdk_d[li_ac].xrcf103 = g_xmdk_d[li_ac].xrcf103 * -1
         LET g_xmdk_d[li_ac].xrcf104 = g_xmdk_d[li_ac].xrcf104 * -1
         LET g_xmdk_d[li_ac].xrcf105 = g_xmdk_d[li_ac].xrcf105 * -1
         LET g_xmdk_d[li_ac].xrcb113 = g_xmdk_d[li_ac].xrcb113 * -1
         LET g_xmdk_d[li_ac].xrcb114 = g_xmdk_d[li_ac].xrcb114 * -1
         LET g_xmdk_d[li_ac].xrcb115 = g_xmdk_d[li_ac].xrcb115 * -1
         LET g_xmdk_d[li_ac].l_xrcb103diff = g_xmdk_d[li_ac].l_xrcb103diff * -1
         LET g_xmdk_d[li_ac].l_xrcb104diff = g_xmdk_d[li_ac].l_xrcb104diff * -1
         LET g_xmdk_d[li_ac].l_xrcb105diff = g_xmdk_d[li_ac].l_xrcb105diff * -1
      END IF

      LET l_xmdldocno = g_xmdk_d[li_ac].xmdldocno
      IF g_xrca_m.b_check = 'Y' THEN
         #20150525 Mod 01727 ---(S)---
         LET l_xmdk_d.xmdl022      = g_xmdk_d[li_ac].xmdl022       + l_xmdk_d.xmdl022
         LET l_xmdk_d.xmdl038      = g_xmdk_d[li_ac].xmdl038       + l_xmdk_d.xmdl038
         LET l_xmdk_d.l_xmdl0381   = g_xmdk_d[li_ac].l_xmdl0381    + l_xmdk_d.l_xmdl0381
         LET l_xmdk_d.xmdl053      = g_xmdk_d[li_ac].xmdl053       + l_xmdk_d.xmdl053
         LET l_xmdk_d.xmdl047      = g_xmdk_d[li_ac].xmdl047       + l_xmdk_d.xmdl047
         LET l_xmdk_d.l_xmdl022diff= g_xmdk_d[li_ac].l_xmdl022diff + l_xmdk_d.l_xmdl022diff
         LET l_xmdk_d.l_xmdl0272   = g_xmdk_d[li_ac].l_xmdl0272    + l_xmdk_d.l_xmdl0272
         LET l_xmdk_d.l_xmdl0292   = g_xmdk_d[li_ac].l_xmdl0292    + l_xmdk_d.l_xmdl0292
         LET l_xmdk_d.l_xmdl0282   = g_xmdk_d[li_ac].l_xmdl0282    + l_xmdk_d.l_xmdl0282
         LET l_xmdk_d.xmdl027      = g_xmdk_d[li_ac].xmdl027       + l_xmdk_d.xmdl027
         LET l_xmdk_d.xmdl029      = g_xmdk_d[li_ac].xmdl029       + l_xmdk_d.xmdl029
         LET l_xmdk_d.xmdl028      = g_xmdk_d[li_ac].xmdl028       + l_xmdk_d.xmdl028
         LET l_xmdk_d.xrcb103      = g_xmdk_d[li_ac].xrcb103       + l_xmdk_d.xrcb103
         LET l_xmdk_d.xrcb104      = g_xmdk_d[li_ac].xrcb104       + l_xmdk_d.xrcb104
         LET l_xmdk_d.xrcb105      = g_xmdk_d[li_ac].xrcb105       + l_xmdk_d.xrcb105
         LET l_xmdk_d.xrcf103      = g_xmdk_d[li_ac].xrcf103       + l_xmdk_d.xrcf103
         LET l_xmdk_d.xrcf104      = g_xmdk_d[li_ac].xrcf104       + l_xmdk_d.xrcf104
         LET l_xmdk_d.xrcf105      = g_xmdk_d[li_ac].xrcf105       + l_xmdk_d.xrcf105
         LET l_xmdk_d.l_xrcb103diff= g_xmdk_d[li_ac].l_xrcb103diff + l_xmdk_d.l_xrcb103diff
         LET l_xmdk_d.l_xrcb104diff= g_xmdk_d[li_ac].l_xrcb104diff + l_xmdk_d.l_xrcb104diff
         LET l_xmdk_d.l_xrcb105diff= g_xmdk_d[li_ac].l_xrcb105diff + l_xmdk_d.l_xrcb105diff
         LET l_xmdk_d.l_xmdl0271   = g_xmdk_d[li_ac].l_xmdl0271    + l_xmdk_d.l_xmdl0271
         LET l_xmdk_d.l_xmdl0291   = g_xmdk_d[li_ac].l_xmdl0291    + l_xmdk_d.l_xmdl0291
         LET l_xmdk_d.l_xmdl0281   = g_xmdk_d[li_ac].l_xmdl0281    + l_xmdk_d.l_xmdl0281
         LET l_xmdk_d.xrcb113      = g_xmdk_d[li_ac].xrcb113       + l_xmdk_d.xrcb113
         LET l_xmdk_d.xrcb114      = g_xmdk_d[li_ac].xrcb114       + l_xmdk_d.xrcb114
         LET l_xmdk_d.xrcb115      = g_xmdk_d[li_ac].xrcb115       + l_xmdk_d.xrcb115
         #20150525 Mod 01727 ---(E)---
      END IF
      #yangtt-2015/05/25---XG
      LET l_xmdk000 = g_xmdk_d[li_ac].xmdk000,":",s_desc_gzcbl004_desc('2077',g_xmdk_d[li_ac].xmdk000)
      INSERT INTO axrq130_tmp01 VALUES(l_xrcasite_desc,l_xrcald_desc,                        #160727-00019#6   2016/07/28 By 08734   axrq130_print_tmp ——> axrq130_tmp01
      #g_xmdk_d[li_ac].xmdksite,g_xmdk_d[li_ac].xmdk007,l_xmdk000,g_xmdk_d[li_ac].xmdkdocdt,  #151203-00013#5 mark
      g_xmdk_d[li_ac].xmdksite,l_xmdk007_desc,l_xmdk000,g_xmdk_d[li_ac].xmdkdocdt,            #151203-00013#5
      g_xmdk_d[li_ac].xmdk001,g_xmdk_d[li_ac].xmdldocno,g_xmdk_d[li_ac].xmdlseq,g_xmdk_d[li_ac].xmdk003, 
      g_xmdk_d[li_ac].xmdk003_desc,g_xmdk_d[li_ac].xmdk004,g_xmdk_d[li_ac].xmdk004_desc,g_xmdk_d[li_ac].xmdl014, 
      g_xmdk_d[li_ac].xmdl014_desc,g_xmdk_d[li_ac].xmdl008,g_xmdk_d[li_ac].imaal003,g_xmdk_d[li_ac].imaal004,g_xmdk_d[li_ac].xmdl007,  #151102-00008#2 add xmdl007
      g_xmdk_d[li_ac].imag011,g_xmdk_d[li_ac].imag011_desc,g_xmdk_d[li_ac].pmaa091,g_xmdk_d[li_ac].pmaa091_desc,g_xmdk_d[li_ac].glcc003,g_xmdk_d[li_ac].glcc003_desc,  #151203-00013#1 add pmaa091 
      g_xmdk_d[li_ac].xmdl022,g_xmdk_d[li_ac].xmdl038,g_xmdk_d[li_ac].l_xmdl0381,g_xmdk_d[li_ac].xmdl053, 
     #g_xmdk_d[li_ac].xmdl047,g_xmdk_d[li_ac].l_xmdl022diff,g_xmdk_d[li_ac].xmdk016,g_xmdk_d[li_ac].xmdk017,  #150902-00001#2 mark
      g_xmdk_d[li_ac].xmdl047,g_xmdk_d[li_ac].l_xmdl022diff,g_xmdk_d[li_ac].xmdk016,g_xmdk_d[li_ac].xmdl003,  #150902-00001#2
      g_xmdk_d[li_ac].xmdl004,g_xmdk_d[li_ac].xmdl049,g_xmdk_d[li_ac].xmdk017,                                #150902-00001#2      
      g_xmdk_d[li_ac].xmdl025,g_xmdk_d[li_ac].xmdl026/100,g_xmdk_d[li_ac].xmdl024,g_xmdk_d[li_ac].l_xmdl0272, 
      g_xmdk_d[li_ac].l_xmdl0292,g_xmdk_d[li_ac].l_xmdl0282,g_xmdk_d[li_ac].xmdl027,g_xmdk_d[li_ac].xmdl029, 
      g_xmdk_d[li_ac].xmdl028,g_xmdk_d[li_ac].xrcb103,g_xmdk_d[li_ac].xrcb104,g_xmdk_d[li_ac].xrcb105, 
      g_xmdk_d[li_ac].xrcf103,g_xmdk_d[li_ac].xrcf104,g_xmdk_d[li_ac].xrcf105,g_xmdk_d[li_ac].l_xrcb103diff, 
      g_xmdk_d[li_ac].l_xrcb104diff,g_xmdk_d[li_ac].l_xrcb105diff,g_xmdk_d[li_ac].l_xmdl0271,g_xmdk_d[li_ac].l_xmdl0291, 
      g_xmdk_d[li_ac].l_xmdl0281,g_xmdk_d[li_ac].xrcb113,g_xmdk_d[li_ac].xrcb114,g_xmdk_d[li_ac].xrcb115,g_xmdk_d[li_ac].xrcadocno,g_xmdk_d[li_ac].xrcad2,'1') #150924-00012#2 add xrcadocno   #151019-00009#2 add xrcad2
      #yangtt-2015/05/25---XG
      LET li_ac = li_ac + 1
   END FOREACH

   #20150525 Mod 01727 ---(S)---
      IF g_xrca_m.b_check = 'Y' THEN
         #當前行清空後,做小計
         LET g_xmdk_d[li_ac].* = g_xmdk_d_t.*
         SELECT gzzd005 INTO g_xmdk_d[li_ac].xmdldocno FROM gzzd_t WHERE gzzd001 = 'axrq130'
            AND gzzd003 = 'lbl_total' AND gzzd002 = g_lang
         LET g_xmdk_d[li_ac].xmdl022    = l_xmdk_d.xmdl022
         LET g_xmdk_d[li_ac].xmdl038    = l_xmdk_d.xmdl038
         LET g_xmdk_d[li_ac].l_xmdl0381   = l_xmdk_d.l_xmdl0381
         LET g_xmdk_d[li_ac].xmdl053    = l_xmdk_d.xmdl053
         LET g_xmdk_d[li_ac].xmdl047    = l_xmdk_d.xmdl047
         LET g_xmdk_d[li_ac].l_xmdl022diff= l_xmdk_d.l_xmdl022diff
         LET g_xmdk_d[li_ac].l_xmdl0272   = l_xmdk_d.l_xmdl0272
         LET g_xmdk_d[li_ac].l_xmdl0292   = l_xmdk_d.l_xmdl0292
         LET g_xmdk_d[li_ac].l_xmdl0282   = l_xmdk_d.l_xmdl0282
         LET g_xmdk_d[li_ac].xmdl027    = l_xmdk_d.xmdl027
         LET g_xmdk_d[li_ac].xmdl029    = l_xmdk_d.xmdl029
         LET g_xmdk_d[li_ac].xmdl028    = l_xmdk_d.xmdl028
         LET g_xmdk_d[li_ac].xrcb103    = l_xmdk_d.xrcb103
         LET g_xmdk_d[li_ac].xrcb104    = l_xmdk_d.xrcb104
         LET g_xmdk_d[li_ac].xrcb105    = l_xmdk_d.xrcb105
         LET g_xmdk_d[li_ac].xrcf103    = l_xmdk_d.xrcf103
         LET g_xmdk_d[li_ac].xrcf104    = l_xmdk_d.xrcf104
         LET g_xmdk_d[li_ac].xrcf105    = l_xmdk_d.xrcf105
         LET g_xmdk_d[li_ac].l_xrcb103diff= l_xmdk_d.l_xrcb103diff
         LET g_xmdk_d[li_ac].l_xrcb104diff= l_xmdk_d.l_xrcb104diff
         LET g_xmdk_d[li_ac].l_xrcb105diff= l_xmdk_d.l_xrcb105diff
         LET g_xmdk_d[li_ac].l_xmdl0271   = l_xmdk_d.l_xmdl0271
         LET g_xmdk_d[li_ac].l_xmdl0291   = l_xmdk_d.l_xmdl0291
         LET g_xmdk_d[li_ac].l_xmdl0281   = l_xmdk_d.l_xmdl0281
         LET g_xmdk_d[li_ac].xrcb113    = l_xmdk_d.xrcb113
         LET g_xmdk_d[li_ac].xrcb114    = l_xmdk_d.xrcb114
         LET g_xmdk_d[li_ac].xrcb115    = l_xmdk_d.xrcb115
         #yangtt-2015/05/25---XG
         INSERT INTO axrq130_tmp01 VALUES(l_xrcasite_desc,l_xrcald_desc,                 #160727-00019#6   2016/07/28 By 08734   axrq130_print_tmp ——> axrq130_tmp01
      #g_xmdk_d[li_ac].xmdksite,g_xmdk_d[li_ac].xmdk007,g_xmdk_d[li_ac].xmdk000,g_xmdk_d[li_ac].xmdkdocdt,  #151203-00013#5 mark
      g_xmdk_d[li_ac].xmdksite,l_xmdk007_desc,g_xmdk_d[li_ac].xmdk000,g_xmdk_d[li_ac].xmdkdocdt,            #151203-00013#5
      g_xmdk_d[li_ac].xmdk001,g_xmdk_d[li_ac].xmdldocno,g_xmdk_d[li_ac].xmdlseq,g_xmdk_d[li_ac].xmdk003, 
      g_xmdk_d[li_ac].xmdk003_desc,g_xmdk_d[li_ac].xmdk004,g_xmdk_d[li_ac].xmdk004_desc,g_xmdk_d[li_ac].xmdl014, 
      g_xmdk_d[li_ac].xmdl014_desc,g_xmdk_d[li_ac].xmdl008,g_xmdk_d[li_ac].imaal003,g_xmdk_d[li_ac].imaal004,g_xmdk_d[li_ac].xmdl007,  #151102-00008#2 add xmdl007 
      g_xmdk_d[li_ac].imag011,g_xmdk_d[li_ac].mag_desc,g_xmdk_d[li_ac].pmaa091,g_xmdk_d[li_ac].pmaa091_desc,g_xmdk_d[li_ac].glcc003,g_xmdk_d[li_ac].glcc003_desc,  #151203-00013#1 add pmaa091 
      g_xmdk_d[li_ac].xmdl022,g_xmdk_d[li_ac].xmdl038,g_xmdk_d[li_ac].l_xmdl0381,g_xmdk_d[li_ac].xmdl053, 
     #g_xmdk_d[li_ac].xmdl047,g_xmdk_d[li_ac].l_xmdl022diff,g_xmdk_d[li_ac].xmdk016,g_xmdk_d[li_ac].xmdk017,  #150902-00001#2 mark
      g_xmdk_d[li_ac].xmdl047,g_xmdk_d[li_ac].l_xmdl022diff,g_xmdk_d[li_ac].xmdk016,g_xmdk_d[li_ac].xmdl003,  #150902-00001#2
      g_xmdk_d[li_ac].xmdl004,g_xmdk_d[li_ac].xmdl049,g_xmdk_d[li_ac].xmdk017,                                #150902-00001#2      
      g_xmdk_d[li_ac].xmdl025,g_xmdk_d[li_ac].xmdl026/100,g_xmdk_d[li_ac].xmdl024,g_xmdk_d[li_ac].l_xmdl0272, 
      g_xmdk_d[li_ac].l_xmdl0292,g_xmdk_d[li_ac].l_xmdl0282,g_xmdk_d[li_ac].xmdl027,g_xmdk_d[li_ac].xmdl029, 
      g_xmdk_d[li_ac].xmdl028,g_xmdk_d[li_ac].xrcb103,g_xmdk_d[li_ac].xrcb104,g_xmdk_d[li_ac].xrcb105, 
      g_xmdk_d[li_ac].xrcf103,g_xmdk_d[li_ac].xrcf104,g_xmdk_d[li_ac].xrcf105,g_xmdk_d[li_ac].l_xrcb103diff, 
      g_xmdk_d[li_ac].l_xrcb104diff,g_xmdk_d[li_ac].l_xrcb105diff,g_xmdk_d[li_ac].l_xmdl0271,g_xmdk_d[li_ac].l_xmdl0291, 
      g_xmdk_d[li_ac].l_xmdl0281,g_xmdk_d[li_ac].xrcb113,g_xmdk_d[li_ac].xrcb114,g_xmdk_d[li_ac].xrcb115,g_xmdk_d[li_ac].xrcadocno,g_xmdk_d[li_ac].xrcad2,'1') #150924-00012#2 add xrcadocno  #151019-00009#2 add xrcad2
         #yangtt-2015/05/25---XG

         LET li_ac = li_ac + 1
      ELSE
         CALL g_xmdk_d.deleteElement(g_xmdk_d.getLength())
      END IF
   #20150525 Mod 01727 ---(E)---

  #CALL g_xmdk_d.deleteElement(g_xmdk_d.getLength())

   LET g_error_show = 0
 
   LET g_detail_cnt = g_xmdk_d.getLength()
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET g_detail_idx = 1
   DISPLAY g_detail_idx TO FORMONLY.h_index
   LET l_ac = g_cnt
   LET g_cnt = 0
 
   CALL axrq130_filter_show('xmdk007','b_xmdk007')
   CALL axrq130_filter_show('xmdk000','b_xmdk000')
   CALL axrq130_filter_show('xmdkdocdt','b_xmdkdocdt')
   CALL axrq130_filter_show('xmdk001','b_xmdk001')
   CALL axrq130_filter_show('xmdldocno','b_xmdldocno')
   CALL axrq130_filter_show('xmdlseq','b_xmdlseq')
   CALL axrq130_filter_show('xmdl008','b_xmdl008')
   CALL axrq130_filter_show('imaal003','b_imaal003')
   CALL axrq130_filter_show('imaal004','b_imaal004')
   CALL axrq130_filter_show('xmdl007','b_xmdl007')    #151102-00008#2 add
   CALL axrq130_filter_show('pmaa091','b_pmaa091')    #151203-00013#1 add
   CALL axrq130_filter_show('xmdl022','b_xmdl022')
   CALL axrq130_filter_show('xmdl038','b_xmdl038')
   CALL axrq130_filter_show('xmdl0381','b_xmdl0381')
   CALL axrq130_filter_show('xmdl053','b_xmdl053')
   CALL axrq130_filter_show('xmdl047','b_xmdl047')
   CALL axrq130_filter_show('xmdl022diff','b_xmdl022diff')
   CALL axrq130_filter_show('xmdk016','b_xmdk016')
   CALL axrq130_filter_show('xmdl003','b_xmdl003')   #150902-00001#2
   CALL axrq130_filter_show('xmdl004','b_xmdl004')   #150902-00001#2
   CALL axrq130_filter_show('xmdl049','b_xmdl049')   #150902-00001#2
   CALL axrq130_filter_show('xmdk017','b_xmdk017')
   CALL axrq130_filter_show('xmdl025','b_xmdl025')
   CALL axrq130_filter_show('xmdl026','b_xmdl026')
   CALL axrq130_filter_show('xmdl024','b_xmdl024')
   CALL axrq130_filter_show('xmdl0272','b_xmdl0272')
   CALL axrq130_filter_show('xmdl0292','b_xmdl0292')
   CALL axrq130_filter_show('xmdl0282','b_xmdl0282')
   CALL axrq130_filter_show('xmdl027','b_xmdl027')
   CALL axrq130_filter_show('xmdl029','b_xmdl029')
   CALL axrq130_filter_show('xmdl028','b_xmdl028')
   CALL axrq130_filter_show('xrcb103','b_xrcb103')
   CALL axrq130_filter_show('xrcb104','b_xrcb104')
   CALL axrq130_filter_show('xrcb105','b_xrcb105')
   CALL axrq130_filter_show('xrcf103','b_xrcf103')
   CALL axrq130_filter_show('xrcf104','b_xrcf104')
   CALL axrq130_filter_show('xrcf105','b_xrcf105')
   CALL axrq130_filter_show('xrcb103diff','b_xrcb103diff')
   CALL axrq130_filter_show('xrcb104diff','b_xrcb104diff')
   CALL axrq130_filter_show('xrcb105diff','b_xrcb105diff')
   CALL axrq130_filter_show('xmdl0271','b_xmdl0271')
   CALL axrq130_filter_show('xmdl0291','b_xmdl0291')
   CALL axrq130_filter_show('xmdl0281','b_xmdl0281')
   CALL axrq130_filter_show('xrcb113','b_xrcb113')
   CALL axrq130_filter_show('xrcb114','b_xrcb114')
   CALL axrq130_filter_show('xrcb115','b_xrcb115')
   CALL axrq130_filter_show('xrcadocno','b_xrcadocno') #150924-00012#2
   CALL axrq130_filter_show('xrcad2','b_xrcad2')       #151019-00009#2

   IF cl_null(g_xmdk_d[1].xmdldocno) THEN
      #無符合條件資料
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'aap-00313'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF
}
END FUNCTION

 
{</section>}
 
