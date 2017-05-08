#該程式未解開Section, 採用最新樣板產出!
{<section id="axrt930.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0016(2014-11-20 15:11:28), PR版次:0016(2017-01-13 14:50:21)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000190
#+ Filename...: axrt930
#+ Description: 應收暫估沖回作業
#+ Creator....: 01531(2014-11-04 10:49:14)
#+ Modifier...: 01531 -SD/PR- 02599
 
{</section>}
 
{<section id="axrt930.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#151125-00001#4    2015/11/26   By 06948   增加作廢時詢問「是否作廢」
#150916-00015#1    2015/11/30   By taozf   当有账套时，科目检查改为检查是否存在于glad_t中
#160321-00016#53   2016/04/01   By Hans    將重複內容的錯誤訊息置換為公用錯誤訊息
#160125-00005#9    2016/08/02   By 01727   查詢時加上帳套人員權限條件過濾
#160727-00019#36   16/08/12     By 08734   临时表长度超过15码的减少到15码以下 s_voucher_ar_tmp ——> s_vr_tmp04
#160727-00019#36   16/08/15     By 08734   临时表长度超过15码的减少到15码以下 s_voucher_ar_group ——> s_vr_tmp05
#160811-00009#3    2016/08/15   By 01531   账务中心/法人/账套权限控管
#160811-00009#3    2016/08/23   By 01531   账务中心/法人/账套权限控管
#160920-00010#1    2016/09/29   By 01727   axrt931产生分录失败
#161026-00013#2    2016/10/27   By 06821   組織類型與職能開窗調整
#161006-00005#40   2016/10/28   By 08171   账务中心开窗需调整为q_ooef001_46;来源组织开窗增加where條件 ooef201 = 'Y';
#                                          责任中心开窗改为q_ooeg001_4 并限定where条件ooeg003 IN ('1','2','3')
#161111-00049#10   2016/11/30   By 07900   控制组权限修改
#161128-00061#5    2016/12/05   by 02481   标准程式定义采用宣告模式,弃用.*写法
#161104-00046#10   170103       By albireo   增加單別控制組
#170103-00019#10   2017/01/06   By 02599   1.凭证还原时，同步更新细项立冲账资料；2.当'S-COM-0002'=Y限定单据连号时, 采用凭证作废处理
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
PRIVATE type type_g_xrem_m        RECORD
       xremsite LIKE xrem_t.xremsite, 
   xremsite_desc LIKE type_t.chr80, 
   xremld LIKE xrem_t.xremld, 
   xremld_desc LIKE type_t.chr80, 
   xrem004 LIKE xrem_t.xrem004, 
   xrem004_desc LIKE type_t.chr80, 
   xremcomp LIKE xrem_t.xremcomp, 
   xrem006 LIKE xrem_t.xrem006, 
   xremdocno LIKE xrem_t.xremdocno, 
   xremdocdt LIKE xrem_t.xremdocdt, 
   xrem001 LIKE xrem_t.xrem001, 
   xrem002 LIKE xrem_t.xrem002, 
   xrem005 LIKE xrem_t.xrem005, 
   xremstus LIKE xrem_t.xremstus, 
   xremownid LIKE xrem_t.xremownid, 
   xremownid_desc LIKE type_t.chr80, 
   xremowndp LIKE xrem_t.xremowndp, 
   xremowndp_desc LIKE type_t.chr80, 
   xremcrtid LIKE xrem_t.xremcrtid, 
   xremcrtid_desc LIKE type_t.chr80, 
   xremcrtdp LIKE xrem_t.xremcrtdp, 
   xremcrtdp_desc LIKE type_t.chr80, 
   xremcrtdt LIKE xrem_t.xremcrtdt, 
   xremmodid LIKE xrem_t.xremmodid, 
   xremmodid_desc LIKE type_t.chr80, 
   xremmoddt LIKE xrem_t.xremmoddt, 
   xremcnfid LIKE xrem_t.xremcnfid, 
   xremcnfid_desc LIKE type_t.chr80, 
   xremcnfdt LIKE xrem_t.xremcnfdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_xren_d        RECORD
       xrenseq LIKE xren_t.xrenseq, 
   xrenorga LIKE xren_t.xrenorga, 
   xren004 LIKE xren_t.xren004, 
   xren005 LIKE xren_t.xren005, 
   xren006 LIKE xren_t.xren006, 
   xren007 LIKE xren_t.xren007, 
   xren008 LIKE xren_t.xren008, 
   xren100 LIKE xren_t.xren100, 
   xren040 LIKE xren_t.xren040, 
   xren041 LIKE xren_t.xren041, 
   xren103 LIKE xren_t.xren103, 
   xren104 LIKE xren_t.xren104, 
   xren105 LIKE xren_t.xren105, 
   xren113 LIKE xren_t.xren113, 
   xren114 LIKE xren_t.xren114, 
   xren115 LIKE xren_t.xren115
       END RECORD
PRIVATE TYPE type_g_xren2_d RECORD
       xrenseq LIKE xren_t.xrenseq, 
   xren0052 LIKE type_t.chr500, 
   xren0062 LIKE type_t.chr500, 
   xren0072 LIKE type_t.chr500, 
   xren033 LIKE xren_t.xren033, 
   xren043 LIKE xren_t.xren043, 
   xren043_desc LIKE type_t.chr500, 
   xren019 LIKE xren_t.xren019, 
   xren019_desc LIKE type_t.chr500, 
   xren042 LIKE xren_t.xren042, 
   xren042_desc LIKE type_t.chr500, 
   xren016 LIKE xren_t.xren016, 
   xren016_desc LIKE type_t.chr500, 
   xren011 LIKE xren_t.xren011, 
   xren011_desc LIKE type_t.chr500, 
   xren012 LIKE xren_t.xren012, 
   xren012_desc LIKE type_t.chr500, 
   xren013 LIKE xren_t.xren013, 
   xren013_desc LIKE type_t.chr500, 
   xren014 LIKE xren_t.xren014, 
   xren014_desc LIKE type_t.chr500, 
   xren015 LIKE xren_t.xren015, 
   xren015_desc LIKE type_t.chr500, 
   xren017 LIKE xren_t.xren017, 
   xren017_desc LIKE type_t.chr500, 
   xren018 LIKE xren_t.xren018, 
   xren018_desc LIKE type_t.chr500, 
   xren020 LIKE xren_t.xren020, 
   xren021 LIKE xren_t.xren021, 
   xren021_desc LIKE type_t.chr500, 
   xren022 LIKE xren_t.xren022, 
   xren022_desc LIKE type_t.chr500, 
   xren023 LIKE xren_t.xren023, 
   xren023_desc LIKE type_t.chr500, 
   xren024 LIKE xren_t.xren024, 
   xren024_desc LIKE type_t.chr500, 
   xren025 LIKE xren_t.xren025, 
   xren025_desc LIKE type_t.chr500, 
   xren026 LIKE xren_t.xren026, 
   xren026_desc LIKE type_t.chr500, 
   xren027 LIKE xren_t.xren027, 
   xren027_desc LIKE type_t.chr500, 
   xren028 LIKE xren_t.xren028, 
   xren028_desc LIKE type_t.chr500, 
   xren029 LIKE xren_t.xren029, 
   xren029_desc LIKE type_t.chr500, 
   xren030 LIKE xren_t.xren030, 
   xren030_desc LIKE type_t.chr500, 
   xren031 LIKE xren_t.xren031, 
   xren031_desc LIKE type_t.chr500, 
   xren032 LIKE xren_t.xren032, 
   xren032_desc LIKE type_t.chr500
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_xremdocno LIKE xrem_t.xremdocno,
      b_xrem001 LIKE xrem_t.xrem001,
      b_xrem002 LIKE xrem_t.xrem002,
      b_xrem004 LIKE xrem_t.xrem004
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_glaa102     LIKE glaa_t.glaa102     #借貸不平衡處理方式
DEFINE g_para_data   LIKE type_t.chr80       #S-FIN-2011-法人參數 :暫估帳款期初回轉否
#161128-00061#5---modify----begin------------- 
#DEFINE g_glad        RECORD LIKE glad_t.*
#DEFINE g_glaa_t      RECORD LIKE glaa_t.*         #資料所屬帳套訊息
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
       glad032 LIKE glad_t.glad032, #啟用通路管理
       glad033 LIKE glad_t.glad033, #啟用品牌管理
       glad034 LIKE glad_t.glad034, #科目做多幣別管理
       glad035 LIKE glad_t.glad035, #是否是子系統科目
       glad036 LIKE glad_t.glad036  #貸方現金變動碼
       END RECORD

DEFINE g_glaa_t  RECORD  #帳套資料檔
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
       
#161128-00061#5---modify----begin------------- 
DEFINE g_site_str            STRING                 #160125-00005#9 Add
DEFINE g_user_dept_wc        STRING      #161104-00046#10
DEFINE g_user_dept_wc_q      STRING      #161104-00046#10
#end add-point
       
#模組變數(Module Variables)
DEFINE g_xrem_m          type_g_xrem_m
DEFINE g_xrem_m_t        type_g_xrem_m
DEFINE g_xrem_m_o        type_g_xrem_m
DEFINE g_xrem_m_mask_o   type_g_xrem_m #轉換遮罩前資料
DEFINE g_xrem_m_mask_n   type_g_xrem_m #轉換遮罩後資料
 
   DEFINE g_xremdocno_t LIKE xrem_t.xremdocno
 
 
DEFINE g_xren_d          DYNAMIC ARRAY OF type_g_xren_d
DEFINE g_xren_d_t        type_g_xren_d
DEFINE g_xren_d_o        type_g_xren_d
DEFINE g_xren_d_mask_o   DYNAMIC ARRAY OF type_g_xren_d #轉換遮罩前資料
DEFINE g_xren_d_mask_n   DYNAMIC ARRAY OF type_g_xren_d #轉換遮罩後資料
DEFINE g_xren2_d          DYNAMIC ARRAY OF type_g_xren2_d
DEFINE g_xren2_d_t        type_g_xren2_d
DEFINE g_xren2_d_o        type_g_xren2_d
DEFINE g_xren2_d_mask_o   DYNAMIC ARRAY OF type_g_xren2_d #轉換遮罩前資料
DEFINE g_xren2_d_mask_n   DYNAMIC ARRAY OF type_g_xren2_d #轉換遮罩後資料
 
 
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
 
{<section id="axrt930.main" >}
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
   #161104-00046#10-----s
   #單別控制組
   LET g_user_dept_wc = ''
   CALL s_fin_get_user_dept_control('','xremld','xrement','xremdocno') RETURNING g_user_dept_wc
   #開窗使用
   LET g_user_dept_wc_q = g_user_dept_wc
   #161104-00046#10-----e
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT xremsite,'',xremld,'',xrem004,'',xremcomp,xrem006,xremdocno,xremdocdt, 
       xrem001,xrem002,xrem005,xremstus,xremownid,'',xremowndp,'',xremcrtid,'',xremcrtdp,'',xremcrtdt, 
       xremmodid,'',xremmoddt,xremcnfid,'',xremcnfdt", 
                      " FROM xrem_t",
                      " WHERE xrement= ? AND xremdocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axrt930_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.xremsite,t0.xremld,t0.xrem004,t0.xremcomp,t0.xrem006,t0.xremdocno, 
       t0.xremdocdt,t0.xrem001,t0.xrem002,t0.xrem005,t0.xremstus,t0.xremownid,t0.xremowndp,t0.xremcrtid, 
       t0.xremcrtdp,t0.xremcrtdt,t0.xremmodid,t0.xremmoddt,t0.xremcnfid,t0.xremcnfdt,t1.ooag011 ,t2.ooefl003 , 
       t3.ooag011 ,t4.ooefl003 ,t5.ooag011 ,t6.ooag011",
               " FROM xrem_t t0",
                              " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.xremownid  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.xremowndp AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.xremcrtid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.xremcrtdp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.xremmodid  ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.xremcnfid  ",
 
               " WHERE t0.xrement = " ||g_enterprise|| " AND t0.xremdocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE axrt930_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axrt930 WITH FORM cl_ap_formpath("axr",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axrt930_init()   
 
      #進入選單 Menu (="N")
      CALL axrt930_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axrt930
      
   END IF 
   
   CLOSE axrt930_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   DROP TABLE s_vr_tmp04;  #160727-00019#36   16/08/12 By 08734      临时表长度超过15码的减少到15码以下 s_voucher_ar_tmp ——> s_vr_tmp04
   DROP TABLE s_vr_tmp05;  #160727-00019#36   16/08/15 By 08734      临时表长度超过15码的减少到15码以下 s_voucher_ar_group ——> s_vr_tmp05
   DROP TABLE s_voucher_glbc;
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="axrt930.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION axrt930_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point    
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE r_success           LIKE type_t.num5
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
      CALL cl_set_combo_scc_part('xremstus','13','N,Y,A,D,R,W,X')
 
   
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1','2',","1")
   CALL g_idx_group.addAttribute("","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL axrt930_set_desc()
   CALL s_fin_create_account_center_tmp()
   CALL cl_set_combo_scc('xren020','6013')
   CALL s_fin_set_comp_scc('xrem001','43')
   CALL s_fin_set_comp_scc('xrem002','111')
   CALL cl_set_combo_scc('xrem006','8345')
   CALL cl_set_combo_scc('xren004','8302')
   
   CALL cl_set_act_visible('modify',FALSE)
   CALL cl_set_act_visible('modify_detail',TRUE)
   CALL cl_set_act_visible('insert',FALSE)
   CALL cl_set_comp_visible('xrem006',FALSE)
#   LET g_aw = g_curr_diag.getCurrentItem()
#   CASE g_aw
#   WHEN "s_detail1"
#      CALL cl_set_act_visible('modify_detail',FALSE)
#   WHEN "s_detail2"
#      CALL cl_set_act_visible('modify_detail',TRUE)
#   END CASE   
   CALL s_voucher_cre_ar_tmp_table() RETURNING r_success
   CALL s_pre_voucher_cre_tmp_table() RETURNING r_success 
   #end add-point
   
   #初始化搜尋條件
   CALL axrt930_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="axrt930.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION axrt930_ui_dialog()
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
   DEFINE l_slip     LIKE glap_t.glapdocno 
   DEFINE l_date     LIKE glap_t.glapdocdt
   DEFINE l_count    LIKE type_t.num5
   DEFINE l_docno    LIKE xrem_t.xremdocno
   DEFINE l_start_no LIKE glap_t.glapdocno
   DEFINE l_stus     LIKE glap_t.glapstus
   DEFINE l_para_data LIKE type_t.chr80 #法人關帳日期
   DEFINE l_success  LIKE type_t.num5
   DEFINE l_xremdocno LIKE xrem_t.xremdocno  #20150528 add lujh
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
   
   
   LET lb_first = TRUE
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   
   #end add-point
   
   WHILE TRUE 
   
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_xrem_m.* TO NULL
         CALL g_xren_d.clear()
         CALL g_xren2_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL axrt930_init()
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
               
               CALL axrt930_fetch('') # reload data
               LET l_ac = 1
               CALL axrt930_ui_detailshow() #Setting the current row 
         
               CALL axrt930_idx_chk()
               #NEXT FIELD xrenseq
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_xren_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL axrt930_idx_chk()
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
               CALL axrt930_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               CALL cl_set_act_visible('modify_detail',FALSE)
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
         #第一階單身段落
         DISPLAY ARRAY g_xren2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL axrt930_idx_chk()
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
               CALL axrt930_idx_chk()
               #add-point:page2自定義行為 name="ui_dialog.body2.before_display"
               IF g_xrem_m.xremstus <>'N' THEN
                  CALL cl_set_act_visible('modify_detail',FALSE)
               ELSE
                  CALL cl_set_act_visible('modify_detail',TRUE)
               END IF
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
            CALL axrt930_browser_fill("")
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
               CALL axrt930_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL axrt930_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL axrt930_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL axrt930_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL axrt930_set_act_visible()   
            CALL axrt930_set_act_no_visible()
            IF NOT (g_xrem_m.xremdocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " xrement = " ||g_enterprise|| " AND",
                                  " xremdocno = '", g_xrem_m.xremdocno, "' "
 
               #填到對應位置
               CALL axrt930_browser_fill("")
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
                     WHEN la_wc[li_idx].tableid = "xrem_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "xren_t" 
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
               CALL axrt930_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                     WHEN la_wc[li_idx].tableid = "xrem_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "xren_t" 
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
                  CALL axrt930_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL axrt930_fetch("F")
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
               CALL axrt930_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL axrt930_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axrt930_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL axrt930_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axrt930_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL axrt930_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axrt930_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL axrt930_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axrt930_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL axrt930_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axrt930_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_xren_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_xren2_d)
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
               NEXT FIELD xrenseq
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
               CALL axrt930_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL axrt930_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_pre
            LET g_action_choice="open_pre"
            IF cl_auth_chk_act("open_pre") THEN
               
               #add-point:ON ACTION open_pre name="menu.open_pre"
               IF g_xrem_m.xremstus <> 'N' THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'axr-00270'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                     
                  EXIT DIALOG
               END IF
               
               CALL s_transaction_begin()
               CALL cl_err_collect_init()
               
               IF NOT cl_null(g_xrem_m.xremdocno) THEN 
                  IF g_argv[1] = '1' THEN 
                     CALL s_pre_voucher_ins('AR','R50',g_xrem_m.xremld,g_xrem_m.xremdocno,g_xrem_m.xremdocdt,'5') RETURNING l_success
                  ELSE
                     CALL s_pre_voucher_ins('AR','R51',g_xrem_m.xremld,g_xrem_m.xremdocno,g_xrem_m.xremdocdt,'5') RETURNING l_success   #160920-00010#1 Mod '6' --> '5'
                  END IF
                  
                  IF l_success THEN
                     CALL s_transaction_end('Y','1')
                  ELSE
                     CALL s_transaction_end('N','1')     
                  END IF
               END IF
               CALL cl_err_collect_show() 
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_axrt940_02
            LET g_action_choice="open_axrt940_02"
            IF cl_auth_chk_act("open_axrt940_02") THEN
               
               #add-point:ON ACTION open_axrt940_02 name="menu.open_axrt940_02"
               CALL axrt930_voucher()
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL axrt930_delete()
               #add-point:ON ACTION delete name="menu.delete"
            
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_axrt930_01
            LET g_action_choice="open_axrt930_01"
            IF cl_auth_chk_act("open_axrt930_01") THEN
               
               #add-point:ON ACTION open_axrt930_01 name="menu.open_axrt930_01"
               #整批產生
               CALL s_transaction_begin()
               CALL axrt930_01(g_argv[01])RETURNING g_sub_success,l_xremdocno   #20150528 change g_xrem_m.xremdocno to l_xremdocno lujh
               
               #20150528--add--str--lujh
               IF NOT cl_null(l_xremdocno) THEN 
                  LET g_xrem_m.xremdocno = l_xremdocno  
               END IF
               #20150528--add--end--lujh

               IF g_sub_success THEN
                  CALL s_transaction_end('Y','0')              
               ELSE
                  CALL s_transaction_end('N','0')
               END IF 
               
               IF g_sub_success AND NOT cl_null(g_xrem_m.xremdocno) THEN

                  EXECUTE axrt930_master_referesh USING g_xrem_m.xremdocno INTO g_xrem_m.xremsite,g_xrem_m.xremld,g_xrem_m.xrem004, 
                          g_xrem_m.xremcomp,g_xrem_m.xrem006,g_xrem_m.xremdocno,g_xrem_m.xremdocdt,g_xrem_m.xrem001,g_xrem_m.xrem002, 
                          g_xrem_m.xrem005,g_xrem_m.xremstus,g_xrem_m.xremownid,g_xrem_m.xremowndp,g_xrem_m.xremcrtid,g_xrem_m.xremcrtdp, 
                          g_xrem_m.xremcrtdt,g_xrem_m.xremmodid,g_xrem_m.xremmoddt,g_xrem_m.xremcnfid,g_xrem_m.xremcnfdt, 
                          g_xrem_m.xremownid_desc,g_xrem_m.xremowndp_desc,g_xrem_m.xremcrtid_desc,g_xrem_m.xremcrtdp_desc, 
                          g_xrem_m.xremmodid_desc,g_xrem_m.xremcnfid_desc          
                  CALL axrt930_show()
                  CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/axr/axrt930_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               &include "erp/axr/axrt930_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL axrt930_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION un_voucher
            LET g_action_choice="un_voucher"
            IF cl_auth_chk_act("un_voucher") THEN
               
               #add-point:ON ACTION un_voucher name="menu.un_voucher"
               CALL axrt930_un_voucher()
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_axrt300_13
            LET g_action_choice="open_axrt300_13"
            IF cl_auth_chk_act("open_axrt300_13") THEN
               
               #add-point:ON ACTION open_axrt300_13 name="menu.open_axrt300_13"
               #IF NOT cl_null(g_xrem_m.xrem005) THEN
               #   INITIALIZE g_errparam TO NULL 
               #   LET g_errparam.extend = g_xrem_m.xremdocno 
               #   LET g_errparam.code   = "aap-00052" 
               #   LET g_errparam.popup  = FALSE 
               #   CALL cl_err()
               #ELSE
               #   CALL axrt300_13('AR',g_xrem_m.xremld,g_xrem_m.xremdocno,'5')
               #END IF
               
               IF NOT cl_null(g_xrem_m.xremdocno) THEN
                  IF g_glaa_t.glaa121 = 'Y' THEN 
                     IF g_argv[1] = '1' THEN 
                        CALL s_pre_voucher('AR','R50',g_xrem_m.xremld,g_xrem_m.xremdocno,g_xrem_m.xremdocdt)
                     ELSE
                        CALL s_pre_voucher('AR','R51',g_xrem_m.xremld,g_xrem_m.xremdocno,g_xrem_m.xremdocdt)
                     END IF
                  ELSE               
                     CALL axrt300_13('AR',g_xrem_m.xremld,g_xrem_m.xremdocno,'5')
                  END IF                     
               END IF
               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL axrt930_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL axrt930_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL axrt930_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_xrem_m.xremdocdt)
 
 
 
         
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
 
{<section id="axrt930.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION axrt930_browser_fill(ps_page_action)
   #add-point:browser_fill段define(客製用) name="browser_fill.define_customerization"
   
   #end add-point  
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   DEFINE l_ld_str          STRING    #160125-00005#9 Add
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
   LET l_wc=l_wc," AND xrem003 ='AR' "
  #160125-00005#9 Add  ---(S)---
   #CALL s_axrt300_get_site(g_user,g_site_str,'2') RETURNING l_ld_str  #160811-00009#3 mark
   CALL s_axrt300_get_site(g_user,'','2') RETURNING l_ld_str           #160811-00009#3 add
   LET l_ld_str = cl_replace_str(l_ld_str,"glaald","xremld")        
   LET l_wc = l_wc," AND ",l_ld_str
  #160125-00005#9 Add  ---(E)---
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT xremdocno ",
                      " FROM xrem_t ",
                      " ",
                      " LEFT JOIN xren_t ON xrenent = xrement AND xremdocno = xrendocno ", "  ",
                      #add-point:browser_fill段sql(xren_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
 
                      " ", 
                      " ", 
 
 
                      " WHERE xrement = " ||g_enterprise|| " AND xrenent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("xrem_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT xremdocno ",
                      " FROM xrem_t ", 
                      "  ",
                      "  ",
                      " WHERE xrement = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("xrem_t")
   END IF
   
   #add-point:browser_fill,cnt wc name="browser_fill.cnt_sqlwc"
   
   #end add-point
   
   LET g_sql = " SELECT COUNT(1) FROM (",l_sub_sql,")"
   
   #add-point:browser_fill,count前 name="browser_fill.before_count"
   IF g_argv[1] = '1' THEN
      LET g_sql = " SELECT COUNT(*) FROM (",l_sub_sql," AND xrem006 = '1' )"
   END IF
   IF g_argv[1] = '2' THEN
      LET g_sql = " SELECT COUNT(*) FROM (",l_sub_sql," AND xrem006 = '2' )"
   END IF
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
      INITIALIZE g_xrem_m.* TO NULL
      CALL g_xren_d.clear()        
      CALL g_xren2_d.clear() 
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.xremdocno,t0.xrem001,t0.xrem002,t0.xrem004 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.xremstus,t0.xremdocno,t0.xrem001,t0.xrem002,t0.xrem004 ",
                  " FROM xrem_t t0",
                  "  ",
                  "  LEFT JOIN xren_t ON xrenent = xrement AND xremdocno = xrendocno ", "  ", 
                  #add-point:browser_fill段sql(xren_t1) name="browser_fill.join.xren_t1"
                  
                  #end add-point
 
 
                  " ", 
 
 
                  
                  " WHERE t0.xrement = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("xrem_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.xremstus,t0.xremdocno,t0.xrem001,t0.xrem002,t0.xrem004 ",
                  " FROM xrem_t t0",
                  "  ",
                  
                  " WHERE t0.xrement = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("xrem_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY xremdocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"xrem_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_xremdocno,g_browser[g_cnt].b_xrem001, 
          g_browser[g_cnt].b_xrem002,g_browser[g_cnt].b_xrem004
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
         CALL axrt930_browser_mask()
      
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
   
   IF cl_null(g_browser[g_cnt].b_xremdocno) THEN
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
 
{<section id="axrt930.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION axrt930_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_xrem_m.xremdocno = g_browser[g_current_idx].b_xremdocno   
 
   EXECUTE axrt930_master_referesh USING g_xrem_m.xremdocno INTO g_xrem_m.xremsite,g_xrem_m.xremld,g_xrem_m.xrem004, 
       g_xrem_m.xremcomp,g_xrem_m.xrem006,g_xrem_m.xremdocno,g_xrem_m.xremdocdt,g_xrem_m.xrem001,g_xrem_m.xrem002, 
       g_xrem_m.xrem005,g_xrem_m.xremstus,g_xrem_m.xremownid,g_xrem_m.xremowndp,g_xrem_m.xremcrtid,g_xrem_m.xremcrtdp, 
       g_xrem_m.xremcrtdt,g_xrem_m.xremmodid,g_xrem_m.xremmoddt,g_xrem_m.xremcnfid,g_xrem_m.xremcnfdt, 
       g_xrem_m.xremownid_desc,g_xrem_m.xremowndp_desc,g_xrem_m.xremcrtid_desc,g_xrem_m.xremcrtdp_desc, 
       g_xrem_m.xremmodid_desc,g_xrem_m.xremcnfid_desc
   
   CALL axrt930_xrem_t_mask()
   CALL axrt930_show()
      
END FUNCTION
 
{</section>}
 
{<section id="axrt930.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION axrt930_ui_detailshow()
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
 
{<section id="axrt930.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION axrt930_ui_browser_refresh()
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
      IF g_browser[l_i].b_xremdocno = g_xrem_m.xremdocno 
 
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
 
{<section id="axrt930.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION axrt930_construct()
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
   DEFINE l_ld_str      STRING                #160125-00005#9 Add
   DEFINE l_ooef017   LIKE ooef_t.ooef017
   DEFINE l_glaa004   LIKE glaa_t.glaa004
   #end add-point    
   
   #add-point:Function前置處理  name="cs.pre_function"
   #161111-00049#10 Add  ---(S)---
   SELECT ooef017 INTO l_ooef017 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
   #161111-00049#10 Add  ---(E)---
   #end add-point
    
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_xrem_m.* TO NULL
   CALL g_xren_d.clear()        
   CALL g_xren2_d.clear() 
 
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前 name="cs.before_construct"
   LET g_site_str = NULL   #160125-00005#9 Add
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON xremsite,xremsite_desc,xremld,xremld_desc,xrem004,xrem004_desc,xremcomp, 
          xrem006,xremdocno,xremdocdt,xrem001,xrem002,xrem005,xremstus,xremownid,xremowndp,xremcrtid, 
          xremcrtdp,xremcrtdt,xremmodid,xremmoddt,xremcnfid,xremcnfdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<xremcrtdt>>----
         AFTER FIELD xremcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<xremmoddt>>----
         AFTER FIELD xremmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<xremcnfdt>>----
         AFTER FIELD xremcnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<xrempstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xremsite
            #add-point:BEFORE FIELD xremsite name="construct.b.xremsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xremsite
            
            #add-point:AFTER FIELD xremsite name="construct.a.xremsite"
            CALL FGL_DIALOG_GETBUFFER() RETURNING g_site_str   #160125-00005#9 Add
            #END add-point
            
 
 
         #Ctrlp:construct.c.xremsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xremsite
            #add-point:ON ACTION controlp INFIELD xremsite name="construct.c.xremsite"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #CALL q_ooef001()     #161006-00005#40 mark
            CALL q_ooef001_46()   #161006-00005#40 add
            DISPLAY g_qryparam.return1 TO xremsite
            NEXT FIELD xremsite
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xremsite_desc
            #add-point:BEFORE FIELD xremsite_desc name="construct.b.xremsite_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xremsite_desc
            
            #add-point:AFTER FIELD xremsite_desc name="construct.a.xremsite_desc"
 
            #END add-point
            
 
 
         #Ctrlp:construct.c.xremsite_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xremsite_desc
            #add-point:ON ACTION controlp INFIELD xremsite_desc name="construct.c.xremsite_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xremld
            #add-point:BEFORE FIELD xremld name="construct.b.xremld"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xremld
            
            #add-point:AFTER FIELD xremld name="construct.a.xremld"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xremld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xremld
            #add-point:ON ACTION controlp INFIELD xremld name="construct.c.xremld"
            CALL s_axrt300_get_site(g_user,g_site_str,'2') RETURNING l_ld_str   #160125-00005#9 Add
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept              #160125-00005#9 Mod g_grup --> g_dept
			   #LET g_qryparam.where = l_ld_str CLIPPED   #160125-00005#9 Add                   #160811-00009#3 mark
			   LET g_qryparam.where = l_ld_str CLIPPED," AND (glaa008 = 'Y' OR glaa014 = 'Y')"  #160811-00009#3 add
            CALL q_authorised_ld()
            DISPLAY g_qryparam.return1 TO xremld
            NEXT FIELD xremld
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xremld_desc
            #add-point:BEFORE FIELD xremld_desc name="construct.b.xremld_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xremld_desc
            
            #add-point:AFTER FIELD xremld_desc name="construct.a.xremld_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xremld_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xremld_desc
            #add-point:ON ACTION controlp INFIELD xremld_desc name="construct.c.xremld_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrem004
            #add-point:BEFORE FIELD xrem004 name="construct.b.xrem004"
        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrem004
            
            #add-point:AFTER FIELD xrem004 name="construct.a.xrem004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrem004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrem004
            #add-point:ON ACTION controlp INFIELD xrem004 name="construct.c.xrem004"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()
            DISPLAY g_qryparam.return1 TO xrem004      #顯示到畫面上
            NEXT FIELD xrem004
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrem004_desc
            #add-point:BEFORE FIELD xrem004_desc name="construct.b.xrem004_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrem004_desc
            
            #add-point:AFTER FIELD xrem004_desc name="construct.a.xrem004_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrem004_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrem004_desc
            #add-point:ON ACTION controlp INFIELD xrem004_desc name="construct.c.xrem004_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xremcomp
            #add-point:BEFORE FIELD xremcomp name="construct.b.xremcomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xremcomp
            
            #add-point:AFTER FIELD xremcomp name="construct.a.xremcomp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xremcomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xremcomp
            #add-point:ON ACTION controlp INFIELD xremcomp name="construct.c.xremcomp"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrem006
            #add-point:BEFORE FIELD xrem006 name="construct.b.xrem006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrem006
            
            #add-point:AFTER FIELD xrem006 name="construct.a.xrem006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrem006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrem006
            #add-point:ON ACTION controlp INFIELD xrem006 name="construct.c.xrem006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xremdocno
            #add-point:BEFORE FIELD xremdocno name="construct.b.xremdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xremdocno
            
            #add-point:AFTER FIELD xremdocno name="construct.a.xremdocno"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xremdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xremdocno
            #add-point:ON ACTION controlp INFIELD xremdocno name="construct.c.xremdocno"
            INITIALIZE g_qryparam.* TO NULL
            CALL s_axrt300_get_site(g_user,'','2') RETURNING l_ld_str                    #161111-00049#10 Add
            CALL cl_replace_str(l_ld_str,'glaald','xremld') RETURNING l_ld_str           #161111-00049#10 Add
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = l_ld_str    #161111-00049#10 Add
            #161104-00046#10-----s
            #單別權限控管
            IF NOT cl_null(g_user_dept_wc_q) AND NOT g_user_dept_wc_q = ' 1=1'  THEN
               LET g_qryparam.where = g_qryparam.where," AND ",g_user_dept_wc_q CLIPPED
            END IF
            #161104-00046#10-----e
            CALL q_xremdocno()
            DISPLAY g_qryparam.return1 TO xremdocno      #顯示到畫面上
            NEXT FIELD xremdocno
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xremdocdt
            #add-point:BEFORE FIELD xremdocdt name="construct.b.xremdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xremdocdt
            
            #add-point:AFTER FIELD xremdocdt name="construct.a.xremdocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xremdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xremdocdt
            #add-point:ON ACTION controlp INFIELD xremdocdt name="construct.c.xremdocdt"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrem001
            #add-point:BEFORE FIELD xrem001 name="construct.b.xrem001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrem001
            
            #add-point:AFTER FIELD xrem001 name="construct.a.xrem001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrem001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrem001
            #add-point:ON ACTION controlp INFIELD xrem001 name="construct.c.xrem001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrem002
            #add-point:BEFORE FIELD xrem002 name="construct.b.xrem002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrem002
            
            #add-point:AFTER FIELD xrem002 name="construct.a.xrem002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrem002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrem002
            #add-point:ON ACTION controlp INFIELD xrem002 name="construct.c.xrem002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrem005
            #add-point:BEFORE FIELD xrem005 name="construct.b.xrem005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrem005
            
            #add-point:AFTER FIELD xrem005 name="construct.a.xrem005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrem005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrem005
            #add-point:ON ACTION controlp INFIELD xrem005 name="construct.c.xrem005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xremstus
            #add-point:BEFORE FIELD xremstus name="construct.b.xremstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xremstus
            
            #add-point:AFTER FIELD xremstus name="construct.a.xremstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xremstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xremstus
            #add-point:ON ACTION controlp INFIELD xremstus name="construct.c.xremstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xremownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xremownid
            #add-point:ON ACTION controlp INFIELD xremownid name="construct.c.xremownid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xremownid  #顯示到畫面上
            NEXT FIELD xremownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xremownid
            #add-point:BEFORE FIELD xremownid name="construct.b.xremownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xremownid
            
            #add-point:AFTER FIELD xremownid name="construct.a.xremownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xremowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xremowndp
            #add-point:ON ACTION controlp INFIELD xremowndp name="construct.c.xremowndp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xremowndp  #顯示到畫面上
            NEXT FIELD xremowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xremowndp
            #add-point:BEFORE FIELD xremowndp name="construct.b.xremowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xremowndp
            
            #add-point:AFTER FIELD xremowndp name="construct.a.xremowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xremcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xremcrtid
            #add-point:ON ACTION controlp INFIELD xremcrtid name="construct.c.xremcrtid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xremcrtid  #顯示到畫面上
            NEXT FIELD xremcrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xremcrtid
            #add-point:BEFORE FIELD xremcrtid name="construct.b.xremcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xremcrtid
            
            #add-point:AFTER FIELD xremcrtid name="construct.a.xremcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xremcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xremcrtdp
            #add-point:ON ACTION controlp INFIELD xremcrtdp name="construct.c.xremcrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xremcrtdp  #顯示到畫面上
            NEXT FIELD xremcrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xremcrtdp
            #add-point:BEFORE FIELD xremcrtdp name="construct.b.xremcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xremcrtdp
            
            #add-point:AFTER FIELD xremcrtdp name="construct.a.xremcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xremcrtdt
            #add-point:BEFORE FIELD xremcrtdt name="construct.b.xremcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xremmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xremmodid
            #add-point:ON ACTION controlp INFIELD xremmodid name="construct.c.xremmodid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xremmodid  #顯示到畫面上
            NEXT FIELD xremmodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xremmodid
            #add-point:BEFORE FIELD xremmodid name="construct.b.xremmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xremmodid
            
            #add-point:AFTER FIELD xremmodid name="construct.a.xremmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xremmoddt
            #add-point:BEFORE FIELD xremmoddt name="construct.b.xremmoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xremcnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xremcnfid
            #add-point:ON ACTION controlp INFIELD xremcnfid name="construct.c.xremcnfid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xremcnfid  #顯示到畫面上
            NEXT FIELD xremcnfid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xremcnfid
            #add-point:BEFORE FIELD xremcnfid name="construct.b.xremcnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xremcnfid
            
            #add-point:AFTER FIELD xremcnfid name="construct.a.xremcnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xremcnfdt
            #add-point:BEFORE FIELD xremcnfdt name="construct.b.xremcnfdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON xrenseq,xrenorga,xren004,xren005,xren006,xren007,xren008,xren100,xren040, 
          xren041,xren103,xren104,xren105,xren113,xren114,xren115,xren0052,xren0062,xren0072,xren033, 
          xren043,xren043_desc,xren019,xren019_desc,xren042,xren042_desc,xren016,xren016_desc,xren011, 
          xren011_desc,xren012,xren012_desc,xren013,xren013_desc,xren014,xren014_desc,xren015,xren015_desc, 
          xren017,xren017_desc,xren018,xren018_desc,xren020,xren021,xren021_desc,xren022,xren022_desc, 
          xren023,xren023_desc,xren024,xren024_desc,xren025,xren025_desc,xren026,xren026_desc,xren027, 
          xren027_desc,xren028,xren028_desc,xren029,xren029_desc,xren030,xren030_desc,xren031,xren031_desc, 
          xren032,xren032_desc
           FROM s_detail1[1].xrenseq,s_detail1[1].xrenorga,s_detail1[1].xren004,s_detail1[1].xren005, 
               s_detail1[1].xren006,s_detail1[1].xren007,s_detail1[1].xren008,s_detail1[1].xren100,s_detail1[1].xren040, 
               s_detail1[1].xren041,s_detail1[1].xren103,s_detail1[1].xren104,s_detail1[1].xren105,s_detail1[1].xren113, 
               s_detail1[1].xren114,s_detail1[1].xren115,s_detail2[1].xren0052,s_detail2[1].xren0062, 
               s_detail2[1].xren0072,s_detail2[1].xren033,s_detail2[1].xren043,s_detail2[1].xren043_desc, 
               s_detail2[1].xren019,s_detail2[1].xren019_desc,s_detail2[1].xren042,s_detail2[1].xren042_desc, 
               s_detail2[1].xren016,s_detail2[1].xren016_desc,s_detail2[1].xren011,s_detail2[1].xren011_desc, 
               s_detail2[1].xren012,s_detail2[1].xren012_desc,s_detail2[1].xren013,s_detail2[1].xren013_desc, 
               s_detail2[1].xren014,s_detail2[1].xren014_desc,s_detail2[1].xren015,s_detail2[1].xren015_desc, 
               s_detail2[1].xren017,s_detail2[1].xren017_desc,s_detail2[1].xren018,s_detail2[1].xren018_desc, 
               s_detail2[1].xren020,s_detail2[1].xren021,s_detail2[1].xren021_desc,s_detail2[1].xren022, 
               s_detail2[1].xren022_desc,s_detail2[1].xren023,s_detail2[1].xren023_desc,s_detail2[1].xren024, 
               s_detail2[1].xren024_desc,s_detail2[1].xren025,s_detail2[1].xren025_desc,s_detail2[1].xren026, 
               s_detail2[1].xren026_desc,s_detail2[1].xren027,s_detail2[1].xren027_desc,s_detail2[1].xren028, 
               s_detail2[1].xren028_desc,s_detail2[1].xren029,s_detail2[1].xren029_desc,s_detail2[1].xren030, 
               s_detail2[1].xren030_desc,s_detail2[1].xren031,s_detail2[1].xren031_desc,s_detail2[1].xren032, 
               s_detail2[1].xren032_desc
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrenseq
            #add-point:BEFORE FIELD xrenseq name="construct.b.page1.xrenseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrenseq
            
            #add-point:AFTER FIELD xrenseq name="construct.a.page1.xrenseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xrenseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrenseq
            #add-point:ON ACTION controlp INFIELD xrenseq name="construct.c.page1.xrenseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrenorga
            #add-point:BEFORE FIELD xrenorga name="construct.b.page1.xrenorga"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrenorga
            
            #add-point:AFTER FIELD xrenorga name="construct.a.page1.xrenorga"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xrenorga
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrenorga
            #add-point:ON ACTION controlp INFIELD xrenorga name="construct.c.page1.xrenorga"
            #160125-00005#9 Add  ---(S)---
            CALL s_axrt300_get_site(g_user,'','1') RETURNING l_ld_str
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
			   LET g_qryparam.where = l_ld_str CLIPPED
			   LET g_qryparam.where = g_qryparam.where," AND ooef201 = 'Y' " CLIPPED #161006-00005#40 add 
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrenorga  #顯示到畫面上
            NEXT FIELD xrenorga                     #返回原欄位
            #160125-00005#9 Add  ---(E)---
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren004
            #add-point:BEFORE FIELD xren004 name="construct.b.page1.xren004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren004
            
            #add-point:AFTER FIELD xren004 name="construct.a.page1.xren004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xren004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren004
            #add-point:ON ACTION controlp INFIELD xren004 name="construct.c.page1.xren004"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.xren005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren005
            #add-point:ON ACTION controlp INFIELD xren005 name="construct.c.page1.xren005"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            CALL s_axrt300_get_site(g_user,'','2') RETURNING l_ld_str                    #161111-00049#10 Add
            CALL cl_replace_str(l_ld_str,'glaald','xrcald') RETURNING l_ld_str           #161111-00049#10 Add
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = l_ld_str CLIPPED      #161111-00049#10 Add
            CALL q_xrcadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xren005  #顯示到畫面上
            NEXT FIELD xren005                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren005
            #add-point:BEFORE FIELD xren005 name="construct.b.page1.xren005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren005
            
            #add-point:AFTER FIELD xren005 name="construct.a.page1.xren005"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren006
            #add-point:BEFORE FIELD xren006 name="construct.b.page1.xren006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren006
            
            #add-point:AFTER FIELD xren006 name="construct.a.page1.xren006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xren006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren006
            #add-point:ON ACTION controlp INFIELD xren006 name="construct.c.page1.xren006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren007
            #add-point:BEFORE FIELD xren007 name="construct.b.page1.xren007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren007
            
            #add-point:AFTER FIELD xren007 name="construct.a.page1.xren007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xren007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren007
            #add-point:ON ACTION controlp INFIELD xren007 name="construct.c.page1.xren007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren008
            #add-point:BEFORE FIELD xren008 name="construct.b.page1.xren008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren008
            
            #add-point:AFTER FIELD xren008 name="construct.a.page1.xren008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xren008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren008
            #add-point:ON ACTION controlp INFIELD xren008 name="construct.c.page1.xren008"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.xren100
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren100
            #add-point:ON ACTION controlp INFIELD xren100 name="construct.c.page1.xren100"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xren100  #顯示到畫面上
            NEXT FIELD xren100                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren100
            #add-point:BEFORE FIELD xren100 name="construct.b.page1.xren100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren100
            
            #add-point:AFTER FIELD xren100 name="construct.a.page1.xren100"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren040
            #add-point:BEFORE FIELD xren040 name="construct.b.page1.xren040"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren040
            
            #add-point:AFTER FIELD xren040 name="construct.a.page1.xren040"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xren040
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren040
            #add-point:ON ACTION controlp INFIELD xren040 name="construct.c.page1.xren040"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren041
            #add-point:BEFORE FIELD xren041 name="construct.b.page1.xren041"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren041
            
            #add-point:AFTER FIELD xren041 name="construct.a.page1.xren041"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xren041
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren041
            #add-point:ON ACTION controlp INFIELD xren041 name="construct.c.page1.xren041"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren103
            #add-point:BEFORE FIELD xren103 name="construct.b.page1.xren103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren103
            
            #add-point:AFTER FIELD xren103 name="construct.a.page1.xren103"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xren103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren103
            #add-point:ON ACTION controlp INFIELD xren103 name="construct.c.page1.xren103"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren104
            #add-point:BEFORE FIELD xren104 name="construct.b.page1.xren104"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren104
            
            #add-point:AFTER FIELD xren104 name="construct.a.page1.xren104"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xren104
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren104
            #add-point:ON ACTION controlp INFIELD xren104 name="construct.c.page1.xren104"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren105
            #add-point:BEFORE FIELD xren105 name="construct.b.page1.xren105"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren105
            
            #add-point:AFTER FIELD xren105 name="construct.a.page1.xren105"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xren105
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren105
            #add-point:ON ACTION controlp INFIELD xren105 name="construct.c.page1.xren105"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren113
            #add-point:BEFORE FIELD xren113 name="construct.b.page1.xren113"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren113
            
            #add-point:AFTER FIELD xren113 name="construct.a.page1.xren113"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xren113
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren113
            #add-point:ON ACTION controlp INFIELD xren113 name="construct.c.page1.xren113"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren114
            #add-point:BEFORE FIELD xren114 name="construct.b.page1.xren114"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren114
            
            #add-point:AFTER FIELD xren114 name="construct.a.page1.xren114"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xren114
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren114
            #add-point:ON ACTION controlp INFIELD xren114 name="construct.c.page1.xren114"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren115
            #add-point:BEFORE FIELD xren115 name="construct.b.page1.xren115"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren115
            
            #add-point:AFTER FIELD xren115 name="construct.a.page1.xren115"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xren115
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren115
            #add-point:ON ACTION controlp INFIELD xren115 name="construct.c.page1.xren115"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.xren0052
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren0052
            #add-point:ON ACTION controlp INFIELD xren0052 name="construct.c.page2.xren0052"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            CALL s_axrt300_get_site(g_user,'','2') RETURNING l_ld_str                    #161111-00049#10 Add
            CALL cl_replace_str(l_ld_str,'glaald','xrcald') RETURNING l_ld_str           #161111-00049#10 Add
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = l_ld_str CLIPPED      #161111-00049#10 Add
            CALL q_xrcadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xren0052  #顯示到畫面上
            NEXT FIELD xren0052                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren0052
            #add-point:BEFORE FIELD xren0052 name="construct.b.page2.xren0052"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren0052
            
            #add-point:AFTER FIELD xren0052 name="construct.a.page2.xren0052"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren0062
            #add-point:BEFORE FIELD xren0062 name="construct.b.page2.xren0062"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren0062
            
            #add-point:AFTER FIELD xren0062 name="construct.a.page2.xren0062"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xren0062
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren0062
            #add-point:ON ACTION controlp INFIELD xren0062 name="construct.c.page2.xren0062"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren0072
            #add-point:BEFORE FIELD xren0072 name="construct.b.page2.xren0072"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren0072
            
            #add-point:AFTER FIELD xren0072 name="construct.a.page2.xren0072"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xren0072
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren0072
            #add-point:ON ACTION controlp INFIELD xren0072 name="construct.c.page2.xren0072"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren033
            #add-point:BEFORE FIELD xren033 name="construct.b.page2.xren033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren033
            
            #add-point:AFTER FIELD xren033 name="construct.a.page2.xren033"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xren033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren033
            #add-point:ON ACTION controlp INFIELD xren033 name="construct.c.page2.xren033"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.xren043
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren043
            #add-point:ON ACTION controlp INFIELD xren043 name="construct.c.page2.xren043"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #161111-00049#10 --add--s--
            SELECT glaa004 INTO l_glaa004 FROM glaa_t WHERE glaaent = g_enterprise AND glaacomp = l_ooef017 AND glaa014 = 'Y'
			   LET g_qryparam.where = " glac001 = '",l_glaa004,"'"
			   #161111-00049#10 --add--e--
            CALL aglt310_04()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xren043  #顯示到畫面上
            NEXT FIELD xren043                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren043
            #add-point:BEFORE FIELD xren043 name="construct.b.page2.xren043"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren043
            
            #add-point:AFTER FIELD xren043 name="construct.a.page2.xren043"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xren043_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren043_desc
            #add-point:ON ACTION controlp INFIELD xren043_desc name="construct.c.page2.xren043_desc"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #161111-00049#10 --add--s--
            SELECT glaa004 INTO l_glaa004 FROM glaa_t WHERE glaaent = g_enterprise AND glaacomp = l_ooef017 AND glaa014 = 'Y'
			   LET g_qryparam.where = " glac001 = '",l_glaa004,"'"
			   #161111-00049#10 --add--e--
            CALL aglt310_04()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xren043_desc  #顯示到畫面上
            NEXT FIELD xren043_desc                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren043_desc
            #add-point:BEFORE FIELD xren043_desc name="construct.b.page2.xren043_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren043_desc
            
            #add-point:AFTER FIELD xren043_desc name="construct.a.page2.xren043_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xren019
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren019
            #add-point:ON ACTION controlp INFIELD xren019 name="construct.c.page2.xren019"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #161111-00049#10 --add--s--
            SELECT glaa004 INTO l_glaa004 FROM glaa_t WHERE glaaent = g_enterprise AND glaacomp = l_ooef017 AND glaa014 = 'Y'
			   LET g_qryparam.where = " glac001 = '",l_glaa004,"'"
			   #161111-00049#10 --add--e--
            CALL aglt310_04()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xren019  #顯示到畫面上
            NEXT FIELD xren019                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren019
            #add-point:BEFORE FIELD xren019 name="construct.b.page2.xren019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren019
            
            #add-point:AFTER FIELD xren019 name="construct.a.page2.xren019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xren019_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren019_desc
            #add-point:ON ACTION controlp INFIELD xren019_desc name="construct.c.page2.xren019_desc"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #161111-00049#10 --add--s--
            SELECT glaa004 INTO l_glaa004 FROM glaa_t WHERE glaaent = g_enterprise AND glaacomp = l_ooef017 AND glaa014 = 'Y'
			   LET g_qryparam.where = " glac001 = '",l_glaa004,"'"
			   #161111-00049#10 --add--e--
            CALL aglt310_04()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xren019_desc  #顯示到畫面上
            NEXT FIELD xren019_desc                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren019_desc
            #add-point:BEFORE FIELD xren019_desc name="construct.b.page2.xren019_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren019_desc
            
            #add-point:AFTER FIELD xren019_desc name="construct.a.page2.xren019_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xren042
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren042
            #add-point:ON ACTION controlp INFIELD xren042 name="construct.c.page2.xren042"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #161111-00049#10 --add--s--
            SELECT glaa004 INTO l_glaa004 FROM glaa_t WHERE glaaent = g_enterprise AND glaacomp = l_ooef017 AND glaa014 = 'Y'
			   LET g_qryparam.where = " glac001 = '",l_glaa004,"'"
			   #161111-00049#10 --add--e--
            CALL aglt310_04()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xren042  #顯示到畫面上
            NEXT FIELD xren042                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren042
            #add-point:BEFORE FIELD xren042 name="construct.b.page2.xren042"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren042
            
            #add-point:AFTER FIELD xren042 name="construct.a.page2.xren042"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xren042_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren042_desc
            #add-point:ON ACTION controlp INFIELD xren042_desc name="construct.c.page2.xren042_desc"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #161111-00049#10 --add--s--
            SELECT glaa004 INTO l_glaa004 FROM glaa_t WHERE glaaent = g_enterprise AND glaacomp = l_ooef017 AND glaa014 = 'Y'
			   LET g_qryparam.where = " glac001 = '",l_glaa004,"'"
			   #161111-00049#10 --add--e--
            CALL aglt310_04()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xren042_desc  #顯示到畫面上
            NEXT FIELD xren042_desc                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren042_desc
            #add-point:BEFORE FIELD xren042_desc name="construct.b.page2.xren042_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren042_desc
            
            #add-point:AFTER FIELD xren042_desc name="construct.a.page2.xren042_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xren016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren016
            #add-point:ON ACTION controlp INFIELD xren016 name="construct.c.page2.xren016"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xren016  #顯示到畫面上
            NEXT FIELD xren016                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren016
            #add-point:BEFORE FIELD xren016 name="construct.b.page2.xren016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren016
            
            #add-point:AFTER FIELD xren016 name="construct.a.page2.xren016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xren016_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren016_desc
            #add-point:ON ACTION controlp INFIELD xren016_desc name="construct.c.page2.xren016_desc"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xren016_desc  #顯示到畫面上
            NEXT FIELD xren016_desc                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren016_desc
            #add-point:BEFORE FIELD xren016_desc name="construct.b.page2.xren016_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren016_desc
            
            #add-point:AFTER FIELD xren016_desc name="construct.a.page2.xren016_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xren011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren011
            #add-point:ON ACTION controlp INFIELD xren011 name="construct.c.page2.xren011"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #CALL q_ooef001_13()                           #呼叫開窗 #161026-00013#2 mark
            CALL q_ooeg001_4()                                      #161026-00013#2 add
            DISPLAY g_qryparam.return1 TO xren011  #顯示到畫面上
            NEXT FIELD xren011                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren011
            #add-point:BEFORE FIELD xren011 name="construct.b.page2.xren011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren011
            
            #add-point:AFTER FIELD xren011 name="construct.a.page2.xren011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xren011_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren011_desc
            #add-point:ON ACTION controlp INFIELD xren011_desc name="construct.c.page2.xren011_desc"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #CALL q_ooef001_13()                           #呼叫開窗 #161026-00013#2 mark
            CALL q_ooeg001_4()                                      #161026-00013#2 add
            DISPLAY g_qryparam.return1 TO xren011_desc  #顯示到畫面上
            NEXT FIELD xren011_desc                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren011_desc
            #add-point:BEFORE FIELD xren011_desc name="construct.b.page2.xren011_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren011_desc
            
            #add-point:AFTER FIELD xren011_desc name="construct.a.page2.xren011_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xren012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren012
            #add-point:ON ACTION controlp INFIELD xren012 name="construct.c.page2.xren012"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooeg003 IN ('1','2','3') "     #161006-00005#40 add
            #CALL q_ooeg001_2()                           #呼叫開窗  #161006-00005#40 mark
            CALL q_ooeg001_4()                                      #161006-00005#40 add
            DISPLAY g_qryparam.return1 TO xren012  #顯示到畫面上
            NEXT FIELD xren012                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren012
            #add-point:BEFORE FIELD xren012 name="construct.b.page2.xren012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren012
            
            #add-point:AFTER FIELD xren012 name="construct.a.page2.xren012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xren012_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren012_desc
            #add-point:ON ACTION controlp INFIELD xren012_desc name="construct.c.page2.xren012_desc"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xren012_desc  #顯示到畫面上
            NEXT FIELD xren012_desc                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren012_desc
            #add-point:BEFORE FIELD xren012_desc name="construct.b.page2.xren012_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren012_desc
            
            #add-point:AFTER FIELD xren012_desc name="construct.a.page2.xren012_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xren013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren013
            #add-point:ON ACTION controlp INFIELD xren013 name="construct.c.page2.xren013"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "287" 
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xren013  #顯示到畫面上
            NEXT FIELD xren013                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren013
            #add-point:BEFORE FIELD xren013 name="construct.b.page2.xren013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren013
            
            #add-point:AFTER FIELD xren013 name="construct.a.page2.xren013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xren013_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren013_desc
            #add-point:ON ACTION controlp INFIELD xren013_desc name="construct.c.page2.xren013_desc"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "287" 
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xren013_desc  #顯示到畫面上
            NEXT FIELD xren013_desc                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren013_desc
            #add-point:BEFORE FIELD xren013_desc name="construct.b.page2.xren013_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren013_desc
            
            #add-point:AFTER FIELD xren013_desc name="construct.a.page2.xren013_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xren014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren014
            #add-point:ON ACTION controlp INFIELD xren014 name="construct.c.page2.xren014"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "281" 
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xren014  #顯示到畫面上
            NEXT FIELD xren014                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren014
            #add-point:BEFORE FIELD xren014 name="construct.b.page2.xren014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren014
            
            #add-point:AFTER FIELD xren014 name="construct.a.page2.xren014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xren014_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren014_desc
            #add-point:ON ACTION controlp INFIELD xren014_desc name="construct.c.page2.xren014_desc"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "281" 
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xren014_desc  #顯示到畫面上
            NEXT FIELD xren014_desc                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren014_desc
            #add-point:BEFORE FIELD xren014_desc name="construct.b.page2.xren014_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren014_desc
            
            #add-point:AFTER FIELD xren014_desc name="construct.a.page2.xren014_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xren015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren015
            #add-point:ON ACTION controlp INFIELD xren015 name="construct.c.page2.xren015"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xren015  #顯示到畫面上
            NEXT FIELD xren015                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren015
            #add-point:BEFORE FIELD xren015 name="construct.b.page2.xren015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren015
            
            #add-point:AFTER FIELD xren015 name="construct.a.page2.xren015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xren015_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren015_desc
            #add-point:ON ACTION controlp INFIELD xren015_desc name="construct.c.page2.xren015_desc"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xren015_desc  #顯示到畫面上
            NEXT FIELD xren015_desc                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren015_desc
            #add-point:BEFORE FIELD xren015_desc name="construct.b.page2.xren015_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren015_desc
            
            #add-point:AFTER FIELD xren015_desc name="construct.a.page2.xren015_desc"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren017
            #add-point:BEFORE FIELD xren017 name="construct.b.page2.xren017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren017
            
            #add-point:AFTER FIELD xren017 name="construct.a.page2.xren017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xren017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren017
            #add-point:ON ACTION controlp INFIELD xren017 name="construct.c.page2.xren017"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren017_desc
            #add-point:BEFORE FIELD xren017_desc name="construct.b.page2.xren017_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren017_desc
            
            #add-point:AFTER FIELD xren017_desc name="construct.a.page2.xren017_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xren017_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren017_desc
            #add-point:ON ACTION controlp INFIELD xren017_desc name="construct.c.page2.xren017_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren018
            #add-point:BEFORE FIELD xren018 name="construct.b.page2.xren018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren018
            
            #add-point:AFTER FIELD xren018 name="construct.a.page2.xren018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xren018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren018
            #add-point:ON ACTION controlp INFIELD xren018 name="construct.c.page2.xren018"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren018_desc
            #add-point:BEFORE FIELD xren018_desc name="construct.b.page2.xren018_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren018_desc
            
            #add-point:AFTER FIELD xren018_desc name="construct.a.page2.xren018_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xren018_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren018_desc
            #add-point:ON ACTION controlp INFIELD xren018_desc name="construct.c.page2.xren018_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren020
            #add-point:BEFORE FIELD xren020 name="construct.b.page2.xren020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren020
            
            #add-point:AFTER FIELD xren020 name="construct.a.page2.xren020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xren020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren020
            #add-point:ON ACTION controlp INFIELD xren020 name="construct.c.page2.xren020"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.xren021
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren021
            #add-point:ON ACTION controlp INFIELD xren021 name="construct.c.page2.xren021"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oojd001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xren021  #顯示到畫面上
            NEXT FIELD xren021                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren021
            #add-point:BEFORE FIELD xren021 name="construct.b.page2.xren021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren021
            
            #add-point:AFTER FIELD xren021 name="construct.a.page2.xren021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xren021_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren021_desc
            #add-point:ON ACTION controlp INFIELD xren021_desc name="construct.c.page2.xren021_desc"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oojd001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xren021_desc  #顯示到畫面上
            NEXT FIELD xren021_desc                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren021_desc
            #add-point:BEFORE FIELD xren021_desc name="construct.b.page2.xren021_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren021_desc
            
            #add-point:AFTER FIELD xren021_desc name="construct.a.page2.xren021_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xren022
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren022
            #add-point:ON ACTION controlp INFIELD xren022 name="construct.c.page2.xren022"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "2002" 
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xren022  #顯示到畫面上
            NEXT FIELD xren022                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren022
            #add-point:BEFORE FIELD xren022 name="construct.b.page2.xren022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren022
            
            #add-point:AFTER FIELD xren022 name="construct.a.page2.xren022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xren022_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren022_desc
            #add-point:ON ACTION controlp INFIELD xren022_desc name="construct.c.page2.xren022_desc"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "2002"
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xren022_desc  #顯示到畫面上
            NEXT FIELD xren022_desc                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren022_desc
            #add-point:BEFORE FIELD xren022_desc name="construct.b.page2.xren022_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren022_desc
            
            #add-point:AFTER FIELD xren022_desc name="construct.a.page2.xren022_desc"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren023
            #add-point:BEFORE FIELD xren023 name="construct.b.page2.xren023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren023
            
            #add-point:AFTER FIELD xren023 name="construct.a.page2.xren023"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xren023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren023
            #add-point:ON ACTION controlp INFIELD xren023 name="construct.c.page2.xren023"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren023_desc
            #add-point:BEFORE FIELD xren023_desc name="construct.b.page2.xren023_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren023_desc
            
            #add-point:AFTER FIELD xren023_desc name="construct.a.page2.xren023_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xren023_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren023_desc
            #add-point:ON ACTION controlp INFIELD xren023_desc name="construct.c.page2.xren023_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren024
            #add-point:BEFORE FIELD xren024 name="construct.b.page2.xren024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren024
            
            #add-point:AFTER FIELD xren024 name="construct.a.page2.xren024"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xren024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren024
            #add-point:ON ACTION controlp INFIELD xren024 name="construct.c.page2.xren024"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren024_desc
            #add-point:BEFORE FIELD xren024_desc name="construct.b.page2.xren024_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren024_desc
            
            #add-point:AFTER FIELD xren024_desc name="construct.a.page2.xren024_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xren024_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren024_desc
            #add-point:ON ACTION controlp INFIELD xren024_desc name="construct.c.page2.xren024_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren025
            #add-point:BEFORE FIELD xren025 name="construct.b.page2.xren025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren025
            
            #add-point:AFTER FIELD xren025 name="construct.a.page2.xren025"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xren025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren025
            #add-point:ON ACTION controlp INFIELD xren025 name="construct.c.page2.xren025"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren025_desc
            #add-point:BEFORE FIELD xren025_desc name="construct.b.page2.xren025_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren025_desc
            
            #add-point:AFTER FIELD xren025_desc name="construct.a.page2.xren025_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xren025_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren025_desc
            #add-point:ON ACTION controlp INFIELD xren025_desc name="construct.c.page2.xren025_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren026
            #add-point:BEFORE FIELD xren026 name="construct.b.page2.xren026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren026
            
            #add-point:AFTER FIELD xren026 name="construct.a.page2.xren026"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xren026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren026
            #add-point:ON ACTION controlp INFIELD xren026 name="construct.c.page2.xren026"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren026_desc
            #add-point:BEFORE FIELD xren026_desc name="construct.b.page2.xren026_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren026_desc
            
            #add-point:AFTER FIELD xren026_desc name="construct.a.page2.xren026_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xren026_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren026_desc
            #add-point:ON ACTION controlp INFIELD xren026_desc name="construct.c.page2.xren026_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren027
            #add-point:BEFORE FIELD xren027 name="construct.b.page2.xren027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren027
            
            #add-point:AFTER FIELD xren027 name="construct.a.page2.xren027"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xren027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren027
            #add-point:ON ACTION controlp INFIELD xren027 name="construct.c.page2.xren027"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren027_desc
            #add-point:BEFORE FIELD xren027_desc name="construct.b.page2.xren027_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren027_desc
            
            #add-point:AFTER FIELD xren027_desc name="construct.a.page2.xren027_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xren027_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren027_desc
            #add-point:ON ACTION controlp INFIELD xren027_desc name="construct.c.page2.xren027_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren028
            #add-point:BEFORE FIELD xren028 name="construct.b.page2.xren028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren028
            
            #add-point:AFTER FIELD xren028 name="construct.a.page2.xren028"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xren028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren028
            #add-point:ON ACTION controlp INFIELD xren028 name="construct.c.page2.xren028"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren028_desc
            #add-point:BEFORE FIELD xren028_desc name="construct.b.page2.xren028_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren028_desc
            
            #add-point:AFTER FIELD xren028_desc name="construct.a.page2.xren028_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xren028_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren028_desc
            #add-point:ON ACTION controlp INFIELD xren028_desc name="construct.c.page2.xren028_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren029
            #add-point:BEFORE FIELD xren029 name="construct.b.page2.xren029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren029
            
            #add-point:AFTER FIELD xren029 name="construct.a.page2.xren029"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xren029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren029
            #add-point:ON ACTION controlp INFIELD xren029 name="construct.c.page2.xren029"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren029_desc
            #add-point:BEFORE FIELD xren029_desc name="construct.b.page2.xren029_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren029_desc
            
            #add-point:AFTER FIELD xren029_desc name="construct.a.page2.xren029_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xren029_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren029_desc
            #add-point:ON ACTION controlp INFIELD xren029_desc name="construct.c.page2.xren029_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren030
            #add-point:BEFORE FIELD xren030 name="construct.b.page2.xren030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren030
            
            #add-point:AFTER FIELD xren030 name="construct.a.page2.xren030"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xren030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren030
            #add-point:ON ACTION controlp INFIELD xren030 name="construct.c.page2.xren030"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren030_desc
            #add-point:BEFORE FIELD xren030_desc name="construct.b.page2.xren030_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren030_desc
            
            #add-point:AFTER FIELD xren030_desc name="construct.a.page2.xren030_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xren030_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren030_desc
            #add-point:ON ACTION controlp INFIELD xren030_desc name="construct.c.page2.xren030_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren031
            #add-point:BEFORE FIELD xren031 name="construct.b.page2.xren031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren031
            
            #add-point:AFTER FIELD xren031 name="construct.a.page2.xren031"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xren031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren031
            #add-point:ON ACTION controlp INFIELD xren031 name="construct.c.page2.xren031"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren031_desc
            #add-point:BEFORE FIELD xren031_desc name="construct.b.page2.xren031_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren031_desc
            
            #add-point:AFTER FIELD xren031_desc name="construct.a.page2.xren031_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xren031_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren031_desc
            #add-point:ON ACTION controlp INFIELD xren031_desc name="construct.c.page2.xren031_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren032
            #add-point:BEFORE FIELD xren032 name="construct.b.page2.xren032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren032
            
            #add-point:AFTER FIELD xren032 name="construct.a.page2.xren032"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xren032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren032
            #add-point:ON ACTION controlp INFIELD xren032 name="construct.c.page2.xren032"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren032_desc
            #add-point:BEFORE FIELD xren032_desc name="construct.b.page2.xren032_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren032_desc
            
            #add-point:AFTER FIELD xren032_desc name="construct.a.page2.xren032_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xren032_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren032_desc
            #add-point:ON ACTION controlp INFIELD xren032_desc name="construct.c.page2.xren032_desc"
            
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
                  WHEN la_wc[li_idx].tableid = "xrem_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "xren_t" 
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
   CASE 
      WHEN g_argv[01] = 1  
         LET g_wc = g_wc CLIPPED ," AND xrem006 = '1'"
      WHEN g_argv[01] = 2  
         LET g_wc = g_wc CLIPPED ," AND xrem006 = '2'"      
   END CASE 

   IF NOT cl_null(g_wc2) AND g_wc2 <>" 1=1" THEN
      LET g_wc2 = cl_replace_str(g_wc2,"xren019_desc","xren019")
      LET g_wc2 = cl_replace_str(g_wc2,"xren042_desc","xren042")
      LET g_wc2 = cl_replace_str(g_wc2,"xren043_desc","xren043")      
      LET g_wc2 = cl_replace_str(g_wc2,"xren016_desc","xren016")
      LET g_wc2 = cl_replace_str(g_wc2,"xren011_desc","xren011")
      LET g_wc2 = cl_replace_str(g_wc2,"xren012_desc","xren012")
      LET g_wc2 = cl_replace_str(g_wc2,"xren013_desc","xren013")
      LET g_wc2 = cl_replace_str(g_wc2,"xren014_desc","xren014")
      LET g_wc2 = cl_replace_str(g_wc2,"xren015_desc","xren015")
      LET g_wc2 = cl_replace_str(g_wc2,"xren021_desc","xren021")
      LET g_wc2 = cl_replace_str(g_wc2,"xren022_desc","xren022")
      LET g_wc2 = cl_replace_str(g_wc2,"xren017_desc","xren017")
      LET g_wc2 = cl_replace_str(g_wc2,"xren018_desc","xren018")
      LET g_wc2 = cl_replace_str(g_wc2,"xren023_desc","xren023")
      LET g_wc2 = cl_replace_str(g_wc2,"xren024_desc","xren024")
      LET g_wc2 = cl_replace_str(g_wc2,"xren025_desc","xren025")
      LET g_wc2 = cl_replace_str(g_wc2,"xren026_desc","xren026")
      LET g_wc2 = cl_replace_str(g_wc2,"xren027_desc","xren027")
      LET g_wc2 = cl_replace_str(g_wc2,"xren028_desc","xren028")
      LET g_wc2 = cl_replace_str(g_wc2,"xren029_desc","xren029")
      LET g_wc2 = cl_replace_str(g_wc2,"xren030_desc","xren030")
      LET g_wc2 = cl_replace_str(g_wc2,"xren031_desc","xren031")
      LET g_wc2 = cl_replace_str(g_wc2,"xren032_desc","xren032")
      LET g_wc2_table1 = g_wc2
   END IF 
   
   #161104-00046#10-----s
   IF cl_null(g_user_dept_wc)THEN
      LET g_user_dept_wc = ' 1=1'
   END IF
   IF g_user_dept_wc <>  " 1=1" THEN
      LET g_wc = g_wc ," AND ", g_user_dept_wc CLIPPED
   END IF
   #161104-00046#10-----e
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="axrt930.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION axrt930_filter()
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
      CONSTRUCT g_wc_filter ON xremdocno,xrem001,xrem002,xrem004
                          FROM s_browse[1].b_xremdocno,s_browse[1].b_xrem001,s_browse[1].b_xrem002,s_browse[1].b_xrem004 
 
 
         BEFORE CONSTRUCT
               DISPLAY axrt930_filter_parser('xremdocno') TO s_browse[1].b_xremdocno
            DISPLAY axrt930_filter_parser('xrem001') TO s_browse[1].b_xrem001
            DISPLAY axrt930_filter_parser('xrem002') TO s_browse[1].b_xrem002
            DISPLAY axrt930_filter_parser('xrem004') TO s_browse[1].b_xrem004
      
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
 
      CALL axrt930_filter_show('xremdocno')
   CALL axrt930_filter_show('xrem001')
   CALL axrt930_filter_show('xrem002')
   CALL axrt930_filter_show('xrem004')
 
END FUNCTION
 
{</section>}
 
{<section id="axrt930.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION axrt930_filter_parser(ps_field)
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
 
{<section id="axrt930.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION axrt930_filter_show(ps_field)
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
   LET ls_condition = axrt930_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="axrt930.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION axrt930_query()
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
   CALL g_xren_d.clear()
   CALL g_xren2_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL axrt930_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL axrt930_browser_fill("")
      CALL axrt930_fetch("")
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
      CALL axrt930_filter_show('xremdocno')
   CALL axrt930_filter_show('xrem001')
   CALL axrt930_filter_show('xrem002')
   CALL axrt930_filter_show('xrem004')
   CALL axrt930_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL axrt930_fetch("F") 
      #顯示單身筆數
      CALL axrt930_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="axrt930.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION axrt930_fetch(p_flag)
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
   
   LET g_xrem_m.xremdocno = g_browser[g_current_idx].b_xremdocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE axrt930_master_referesh USING g_xrem_m.xremdocno INTO g_xrem_m.xremsite,g_xrem_m.xremld,g_xrem_m.xrem004, 
       g_xrem_m.xremcomp,g_xrem_m.xrem006,g_xrem_m.xremdocno,g_xrem_m.xremdocdt,g_xrem_m.xrem001,g_xrem_m.xrem002, 
       g_xrem_m.xrem005,g_xrem_m.xremstus,g_xrem_m.xremownid,g_xrem_m.xremowndp,g_xrem_m.xremcrtid,g_xrem_m.xremcrtdp, 
       g_xrem_m.xremcrtdt,g_xrem_m.xremmodid,g_xrem_m.xremmoddt,g_xrem_m.xremcnfid,g_xrem_m.xremcnfdt, 
       g_xrem_m.xremownid_desc,g_xrem_m.xremowndp_desc,g_xrem_m.xremcrtid_desc,g_xrem_m.xremcrtdp_desc, 
       g_xrem_m.xremmodid_desc,g_xrem_m.xremcnfid_desc
   
   #遮罩相關處理
   LET g_xrem_m_mask_o.* =  g_xrem_m.*
   CALL axrt930_xrem_t_mask()
   LET g_xrem_m_mask_n.* =  g_xrem_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL axrt930_set_act_visible()   
   CALL axrt930_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   # s-fin-2011 法人參數 :暫估帳款期初回轉否 if  Y then 可預覽傳票,可轉傳票
#   CALL cl_get_para(g_enterprise,g_xrem_m.xremsite,'S-FIN-2011') RETURNING g_para_data
#   CALL cl_set_act_visible("open_aapt300_14,open_axrp330_01,glap_del",TRUE)
#   IF g_para_data = 'N' THEN
#       CALL cl_set_act_visible("open_aapt300_14,open_axrp330_01,glap_del",FALSE)
#   END IF
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
 
   #end add-point
   
   #保存單頭舊值
   LET g_xrem_m_t.* = g_xrem_m.*
   LET g_xrem_m_o.* = g_xrem_m.*
   
   LET g_data_owner = g_xrem_m.xremownid      
   LET g_data_dept  = g_xrem_m.xremowndp
   
   #重新顯示   
   CALL axrt930_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="axrt930.insert" >}
#+ 資料新增
PRIVATE FUNCTION axrt930_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_xren_d.clear()   
   CALL g_xren2_d.clear()  
 
 
   INITIALIZE g_xrem_m.* TO NULL             #DEFAULT 設定
   
   LET g_xremdocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_xrem_m.xremownid = g_user
      LET g_xrem_m.xremowndp = g_dept
      LET g_xrem_m.xremcrtid = g_user
      LET g_xrem_m.xremcrtdp = g_dept 
      LET g_xrem_m.xremcrtdt = cl_get_current()
      LET g_xrem_m.xremmodid = g_user
      LET g_xrem_m.xremmoddt = cl_get_current()
      LET g_xrem_m.xremstus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
      
  
      #add-point:單頭預設值 name="insert.default"
      
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_xrem_m_t.* = g_xrem_m.*
      LET g_xrem_m_o.* = g_xrem_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_xrem_m.xremstus 
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
 
 
 
    
      CALL axrt930_input("a")
      
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
         INITIALIZE g_xrem_m.* TO NULL
         INITIALIZE g_xren_d TO NULL
         INITIALIZE g_xren2_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL axrt930_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_xren_d.clear()
      #CALL g_xren2_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL axrt930_set_act_visible()   
   CALL axrt930_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_xremdocno_t = g_xrem_m.xremdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " xrement = " ||g_enterprise|| " AND",
                      " xremdocno = '", g_xrem_m.xremdocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL axrt930_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE axrt930_cl
   
   CALL axrt930_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE axrt930_master_referesh USING g_xrem_m.xremdocno INTO g_xrem_m.xremsite,g_xrem_m.xremld,g_xrem_m.xrem004, 
       g_xrem_m.xremcomp,g_xrem_m.xrem006,g_xrem_m.xremdocno,g_xrem_m.xremdocdt,g_xrem_m.xrem001,g_xrem_m.xrem002, 
       g_xrem_m.xrem005,g_xrem_m.xremstus,g_xrem_m.xremownid,g_xrem_m.xremowndp,g_xrem_m.xremcrtid,g_xrem_m.xremcrtdp, 
       g_xrem_m.xremcrtdt,g_xrem_m.xremmodid,g_xrem_m.xremmoddt,g_xrem_m.xremcnfid,g_xrem_m.xremcnfdt, 
       g_xrem_m.xremownid_desc,g_xrem_m.xremowndp_desc,g_xrem_m.xremcrtid_desc,g_xrem_m.xremcrtdp_desc, 
       g_xrem_m.xremmodid_desc,g_xrem_m.xremcnfid_desc
   
   
   #遮罩相關處理
   LET g_xrem_m_mask_o.* =  g_xrem_m.*
   CALL axrt930_xrem_t_mask()
   LET g_xrem_m_mask_n.* =  g_xrem_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_xrem_m.xremsite,g_xrem_m.xremsite_desc,g_xrem_m.xremld,g_xrem_m.xremld_desc,g_xrem_m.xrem004, 
       g_xrem_m.xrem004_desc,g_xrem_m.xremcomp,g_xrem_m.xrem006,g_xrem_m.xremdocno,g_xrem_m.xremdocdt, 
       g_xrem_m.xrem001,g_xrem_m.xrem002,g_xrem_m.xrem005,g_xrem_m.xremstus,g_xrem_m.xremownid,g_xrem_m.xremownid_desc, 
       g_xrem_m.xremowndp,g_xrem_m.xremowndp_desc,g_xrem_m.xremcrtid,g_xrem_m.xremcrtid_desc,g_xrem_m.xremcrtdp, 
       g_xrem_m.xremcrtdp_desc,g_xrem_m.xremcrtdt,g_xrem_m.xremmodid,g_xrem_m.xremmodid_desc,g_xrem_m.xremmoddt, 
       g_xrem_m.xremcnfid,g_xrem_m.xremcnfid_desc,g_xrem_m.xremcnfdt
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_xrem_m.xremownid      
   LET g_data_dept  = g_xrem_m.xremowndp
   
   #功能已完成,通報訊息中心
   CALL axrt930_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="axrt930.modify" >}
#+ 資料修改
PRIVATE FUNCTION axrt930_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point    
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   DEFINE l_wc2_table1          STRING
 
 
   #add-point:modify段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   DEFINE l_success    LIKE type_t.num5
   #end add-point    
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   #保存單頭舊值
   LET g_xrem_m_t.* = g_xrem_m.*
   LET g_xrem_m_o.* = g_xrem_m.*
   
   IF g_xrem_m.xremdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_xremdocno_t = g_xrem_m.xremdocno
 
   CALL s_transaction_begin()
   
   OPEN axrt930_cl USING g_enterprise,g_xrem_m.xremdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axrt930_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE axrt930_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE axrt930_master_referesh USING g_xrem_m.xremdocno INTO g_xrem_m.xremsite,g_xrem_m.xremld,g_xrem_m.xrem004, 
       g_xrem_m.xremcomp,g_xrem_m.xrem006,g_xrem_m.xremdocno,g_xrem_m.xremdocdt,g_xrem_m.xrem001,g_xrem_m.xrem002, 
       g_xrem_m.xrem005,g_xrem_m.xremstus,g_xrem_m.xremownid,g_xrem_m.xremowndp,g_xrem_m.xremcrtid,g_xrem_m.xremcrtdp, 
       g_xrem_m.xremcrtdt,g_xrem_m.xremmodid,g_xrem_m.xremmoddt,g_xrem_m.xremcnfid,g_xrem_m.xremcnfdt, 
       g_xrem_m.xremownid_desc,g_xrem_m.xremowndp_desc,g_xrem_m.xremcrtid_desc,g_xrem_m.xremcrtdp_desc, 
       g_xrem_m.xremmodid_desc,g_xrem_m.xremcnfid_desc
   
   #檢查是否允許此動作
   IF NOT axrt930_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_xrem_m_mask_o.* =  g_xrem_m.*
   CALL axrt930_xrem_t_mask()
   LET g_xrem_m_mask_n.* =  g_xrem_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
 
   
   CALL axrt930_show()
   #add-point:modify段show之後 name="modify.after_show"
   CALL s_axrt300_date_chk(g_xrem_m.xremsite,g_xrem_m.xremdocdt) RETURNING l_success
   IF NOT l_success THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "axr-00300"
      LET g_errparam.popup  = TRUE 
      CALL cl_err() 
      RETURN
   END IF
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
 
    
   WHILE TRUE
      LET g_xremdocno_t = g_xrem_m.xremdocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_xrem_m.xremmodid = g_user 
LET g_xrem_m.xremmoddt = cl_get_current()
LET g_xrem_m.xremmodid_desc = cl_get_username(g_xrem_m.xremmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL axrt930_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE xrem_t SET (xremmodid,xremmoddt) = (g_xrem_m.xremmodid,g_xrem_m.xremmoddt)
          WHERE xrement = g_enterprise AND xremdocno = g_xremdocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_xrem_m.* = g_xrem_m_t.*
            CALL axrt930_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_xrem_m.xremdocno != g_xrem_m_t.xremdocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE xren_t SET xrendocno = g_xrem_m.xremdocno
 
          WHERE xrenent = g_enterprise AND xrendocno = g_xrem_m_t.xremdocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "xren_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xren_t:",SQLERRMESSAGE 
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
   CALL axrt930_set_act_visible()   
   CALL axrt930_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " xrement = " ||g_enterprise|| " AND",
                      " xremdocno = '", g_xrem_m.xremdocno, "' "
 
   #填到對應位置
   CALL axrt930_browser_fill("")
 
   CLOSE axrt930_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL axrt930_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="axrt930.input" >}
#+ 資料輸入
PRIVATE FUNCTION axrt930_input(p_cmd)
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
   DEFINE  l_glaa004             LIKE glaa_t.glaa004
   DEFINE  l_glae009             LIKE glae_t.glae009    #自由核算項使用
   DEFINE  l_slip                LIKE xrda_t.xrdadocno  #20150528 add lujh
   DEFINE  l_ooac004             LIKE ooac_t.ooac004    #20150528 add lujh   
   DEFINE  l_success             LIKE type_t.num5       #20150528 add lujh  
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
   DISPLAY BY NAME g_xrem_m.xremsite,g_xrem_m.xremsite_desc,g_xrem_m.xremld,g_xrem_m.xremld_desc,g_xrem_m.xrem004, 
       g_xrem_m.xrem004_desc,g_xrem_m.xremcomp,g_xrem_m.xrem006,g_xrem_m.xremdocno,g_xrem_m.xremdocdt, 
       g_xrem_m.xrem001,g_xrem_m.xrem002,g_xrem_m.xrem005,g_xrem_m.xremstus,g_xrem_m.xremownid,g_xrem_m.xremownid_desc, 
       g_xrem_m.xremowndp,g_xrem_m.xremowndp_desc,g_xrem_m.xremcrtid,g_xrem_m.xremcrtid_desc,g_xrem_m.xremcrtdp, 
       g_xrem_m.xremcrtdp_desc,g_xrem_m.xremcrtdt,g_xrem_m.xremmodid,g_xrem_m.xremmodid_desc,g_xrem_m.xremmoddt, 
       g_xrem_m.xremcnfid,g_xrem_m.xremcnfid_desc,g_xrem_m.xremcnfdt
   
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
   LET g_forupd_sql = "SELECT xrenseq,xrenorga,xren004,xren005,xren006,xren007,xren008,xren100,xren040, 
       xren041,xren103,xren104,xren105,xren113,xren114,xren115,xrenseq,xren033,xren043,xren019,xren042, 
       xren016,xren011,xren012,xren013,xren014,xren015,xren017,xren018,xren020,xren021,xren022,xren023, 
       xren024,xren025,xren026,xren027,xren028,xren029,xren030,xren031,xren032 FROM xren_t WHERE xrenent=?  
       AND xrendocno=? AND xrenseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axrt930_bcl CURSOR FROM g_forupd_sql
   
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL axrt930_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL axrt930_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_xrem_m.xremsite,g_xrem_m.xremld,g_xrem_m.xrem004,g_xrem_m.xremcomp,g_xrem_m.xrem006, 
       g_xrem_m.xremdocno,g_xrem_m.xremdocdt,g_xrem_m.xrem001,g_xrem_m.xrem002,g_xrem_m.xrem005,g_xrem_m.xremstus 
 
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="axrt930.input.head" >}
      #單頭段
      INPUT BY NAME g_xrem_m.xremsite,g_xrem_m.xremld,g_xrem_m.xrem004,g_xrem_m.xremcomp,g_xrem_m.xrem006, 
          g_xrem_m.xremdocno,g_xrem_m.xremdocdt,g_xrem_m.xrem001,g_xrem_m.xrem002,g_xrem_m.xrem005,g_xrem_m.xremstus  
 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN axrt930_cl USING g_enterprise,g_xrem_m.xremdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN axrt930_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE axrt930_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL axrt930_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            NEXT FIELD xren033
            
            #end add-point
            CALL axrt930_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xremsite
            
            #add-point:AFTER FIELD xremsite name="input.a.xremsite"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xremsite
            #add-point:BEFORE FIELD xremsite name="input.b.xremsite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xremsite
            #add-point:ON CHANGE xremsite name="input.g.xremsite"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xremld
            
            #add-point:AFTER FIELD xremld name="input.a.xremld"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xremld
            #add-point:BEFORE FIELD xremld name="input.b.xremld"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xremld
            #add-point:ON CHANGE xremld name="input.g.xremld"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrem004
            
            #add-point:AFTER FIELD xrem004 name="input.a.xrem004"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrem004
            #add-point:BEFORE FIELD xrem004 name="input.b.xrem004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrem004
            #add-point:ON CHANGE xrem004 name="input.g.xrem004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xremcomp
            #add-point:BEFORE FIELD xremcomp name="input.b.xremcomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xremcomp
            
            #add-point:AFTER FIELD xremcomp name="input.a.xremcomp"


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xremcomp
            #add-point:ON CHANGE xremcomp name="input.g.xremcomp"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrem006
            #add-point:BEFORE FIELD xrem006 name="input.b.xrem006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrem006
            
            #add-point:AFTER FIELD xrem006 name="input.a.xrem006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrem006
            #add-point:ON CHANGE xrem006 name="input.g.xrem006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xremdocno
            #add-point:BEFORE FIELD xremdocno name="input.b.xremdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xremdocno
            
            #add-point:AFTER FIELD xremdocno name="input.a.xremdocno"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_xrem_m.xremdocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xrem_m.xremdocno != g_xremdocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xrem_t WHERE "||"xrement = '" ||g_enterprise|| "' AND "||"xremdocno = '"||g_xrem_m.xremdocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xremdocno
            #add-point:ON CHANGE xremdocno name="input.g.xremdocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xremdocdt
            #add-point:BEFORE FIELD xremdocdt name="input.b.xremdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xremdocdt
            
            #add-point:AFTER FIELD xremdocdt name="input.a.xremdocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xremdocdt
            #add-point:ON CHANGE xremdocdt name="input.g.xremdocdt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrem001
            #add-point:BEFORE FIELD xrem001 name="input.b.xrem001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrem001
            
            #add-point:AFTER FIELD xrem001 name="input.a.xrem001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrem001
            #add-point:ON CHANGE xrem001 name="input.g.xrem001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrem002
            #add-point:BEFORE FIELD xrem002 name="input.b.xrem002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrem002
            
            #add-point:AFTER FIELD xrem002 name="input.a.xrem002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrem002
            #add-point:ON CHANGE xrem002 name="input.g.xrem002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrem005
            #add-point:BEFORE FIELD xrem005 name="input.b.xrem005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrem005
            
            #add-point:AFTER FIELD xrem005 name="input.a.xrem005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrem005
            #add-point:ON CHANGE xrem005 name="input.g.xrem005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xremstus
            #add-point:BEFORE FIELD xremstus name="input.b.xremstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xremstus
            
            #add-point:AFTER FIELD xremstus name="input.a.xremstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xremstus
            #add-point:ON CHANGE xremstus name="input.g.xremstus"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.xremsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xremsite
            #add-point:ON ACTION controlp INFIELD xremsite name="input.c.xremsite"
            
            #END add-point
 
 
         #Ctrlp:input.c.xremld
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xremld
            #add-point:ON ACTION controlp INFIELD xremld name="input.c.xremld"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrem004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrem004
            #add-point:ON ACTION controlp INFIELD xrem004 name="input.c.xrem004"
            
            #END add-point
 
 
         #Ctrlp:input.c.xremcomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xremcomp
            #add-point:ON ACTION controlp INFIELD xremcomp name="input.c.xremcomp"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrem006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrem006
            #add-point:ON ACTION controlp INFIELD xrem006 name="input.c.xrem006"
            
            #END add-point
 
 
         #Ctrlp:input.c.xremdocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xremdocno
            #add-point:ON ACTION controlp INFIELD xremdocno name="input.c.xremdocno"
            
            #END add-point
 
 
         #Ctrlp:input.c.xremdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xremdocdt
            #add-point:ON ACTION controlp INFIELD xremdocdt name="input.c.xremdocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrem001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrem001
            #add-point:ON ACTION controlp INFIELD xrem001 name="input.c.xrem001"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrem002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrem002
            #add-point:ON ACTION controlp INFIELD xrem002 name="input.c.xrem002"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrem005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrem005
            #add-point:ON ACTION controlp INFIELD xrem005 name="input.c.xrem005"
            
            #END add-point
 
 
         #Ctrlp:input.c.xremstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xremstus
            #add-point:ON ACTION controlp INFIELD xremstus name="input.c.xremstus"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_xrem_m.xremdocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               
               #end add-point
               
               INSERT INTO xrem_t (xrement,xremsite,xremld,xrem004,xremcomp,xrem006,xremdocno,xremdocdt, 
                   xrem001,xrem002,xrem005,xremstus,xremownid,xremowndp,xremcrtid,xremcrtdp,xremcrtdt, 
                   xremmodid,xremmoddt,xremcnfid,xremcnfdt)
               VALUES (g_enterprise,g_xrem_m.xremsite,g_xrem_m.xremld,g_xrem_m.xrem004,g_xrem_m.xremcomp, 
                   g_xrem_m.xrem006,g_xrem_m.xremdocno,g_xrem_m.xremdocdt,g_xrem_m.xrem001,g_xrem_m.xrem002, 
                   g_xrem_m.xrem005,g_xrem_m.xremstus,g_xrem_m.xremownid,g_xrem_m.xremowndp,g_xrem_m.xremcrtid, 
                   g_xrem_m.xremcrtdp,g_xrem_m.xremcrtdt,g_xrem_m.xremmodid,g_xrem_m.xremmoddt,g_xrem_m.xremcnfid, 
                   g_xrem_m.xremcnfdt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_xrem_m:",SQLERRMESSAGE 
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
                  CALL axrt930_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL axrt930_b_fill()
                  CALL axrt930_b_fill2('0')
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
               CALL axrt930_xrem_t_mask_restore('restore_mask_o')
               
               UPDATE xrem_t SET (xremsite,xremld,xrem004,xremcomp,xrem006,xremdocno,xremdocdt,xrem001, 
                   xrem002,xrem005,xremstus,xremownid,xremowndp,xremcrtid,xremcrtdp,xremcrtdt,xremmodid, 
                   xremmoddt,xremcnfid,xremcnfdt) = (g_xrem_m.xremsite,g_xrem_m.xremld,g_xrem_m.xrem004, 
                   g_xrem_m.xremcomp,g_xrem_m.xrem006,g_xrem_m.xremdocno,g_xrem_m.xremdocdt,g_xrem_m.xrem001, 
                   g_xrem_m.xrem002,g_xrem_m.xrem005,g_xrem_m.xremstus,g_xrem_m.xremownid,g_xrem_m.xremowndp, 
                   g_xrem_m.xremcrtid,g_xrem_m.xremcrtdp,g_xrem_m.xremcrtdt,g_xrem_m.xremmodid,g_xrem_m.xremmoddt, 
                   g_xrem_m.xremcnfid,g_xrem_m.xremcnfdt)
                WHERE xrement = g_enterprise AND xremdocno = g_xremdocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "xrem_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL axrt930_xrem_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_xrem_m_t)
               LET g_log2 = util.JSON.stringify(g_xrem_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_xremdocno_t = g_xrem_m.xremdocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="axrt930.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_xren_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = FALSE, 
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            NEXT FIELD xren033
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_xren_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL axrt930_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1','2',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_xren_d.getLength()
            #add-point:資料輸入前 name="input.d.before_input"
            
            #end add-point
         
         BEFORE ROW
            #add-point:modify段before row2 name="input.body.before_row2"
            #取得自由核算項資訊
           
            
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
            OPEN axrt930_cl USING g_enterprise,g_xrem_m.xremdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN axrt930_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE axrt930_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_xren_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_xren_d[l_ac].xrenseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_xren_d_t.* = g_xren_d[l_ac].*  #BACKUP
               LET g_xren_d_o.* = g_xren_d[l_ac].*  #BACKUP
               CALL axrt930_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL axrt930_set_no_entry_b(l_cmd)
               IF NOT axrt930_lock_b("xren_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH axrt930_bcl INTO g_xren_d[l_ac].xrenseq,g_xren_d[l_ac].xrenorga,g_xren_d[l_ac].xren004, 
                      g_xren_d[l_ac].xren005,g_xren_d[l_ac].xren006,g_xren_d[l_ac].xren007,g_xren_d[l_ac].xren008, 
                      g_xren_d[l_ac].xren100,g_xren_d[l_ac].xren040,g_xren_d[l_ac].xren041,g_xren_d[l_ac].xren103, 
                      g_xren_d[l_ac].xren104,g_xren_d[l_ac].xren105,g_xren_d[l_ac].xren113,g_xren_d[l_ac].xren114, 
                      g_xren_d[l_ac].xren115,g_xren2_d[l_ac].xrenseq,g_xren2_d[l_ac].xren033,g_xren2_d[l_ac].xren043, 
                      g_xren2_d[l_ac].xren019,g_xren2_d[l_ac].xren042,g_xren2_d[l_ac].xren016,g_xren2_d[l_ac].xren011, 
                      g_xren2_d[l_ac].xren012,g_xren2_d[l_ac].xren013,g_xren2_d[l_ac].xren014,g_xren2_d[l_ac].xren015, 
                      g_xren2_d[l_ac].xren017,g_xren2_d[l_ac].xren018,g_xren2_d[l_ac].xren020,g_xren2_d[l_ac].xren021, 
                      g_xren2_d[l_ac].xren022,g_xren2_d[l_ac].xren023,g_xren2_d[l_ac].xren024,g_xren2_d[l_ac].xren025, 
                      g_xren2_d[l_ac].xren026,g_xren2_d[l_ac].xren027,g_xren2_d[l_ac].xren028,g_xren2_d[l_ac].xren029, 
                      g_xren2_d[l_ac].xren030,g_xren2_d[l_ac].xren031,g_xren2_d[l_ac].xren032
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_xren_d_t.xrenseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_xren_d_mask_o[l_ac].* =  g_xren_d[l_ac].*
                  CALL axrt930_xren_t_mask()
                  LET g_xren_d_mask_n[l_ac].* =  g_xren_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL axrt930_show()
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
            INITIALIZE g_xren_d[l_ac].* TO NULL 
            INITIALIZE g_xren_d_t.* TO NULL 
            INITIALIZE g_xren_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_xren_d[l_ac].xren103 = "0"
      LET g_xren_d[l_ac].xren104 = "0"
      LET g_xren_d[l_ac].xren105 = "0"
      LET g_xren_d[l_ac].xren113 = "0"
      LET g_xren_d[l_ac].xren114 = "0"
      LET g_xren_d[l_ac].xren115 = "0"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            
            #end add-point
            LET g_xren_d_t.* = g_xren_d[l_ac].*     #新輸入資料
            LET g_xren_d_o.* = g_xren_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL axrt930_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL axrt930_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xren_d[li_reproduce_target].* = g_xren_d[li_reproduce].*
               LET g_xren2_d[li_reproduce_target].* = g_xren2_d[li_reproduce].*
 
               LET g_xren_d[li_reproduce_target].xrenseq = NULL
 
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
            SELECT COUNT(1) INTO l_count FROM xren_t 
             WHERE xrenent = g_enterprise AND xrendocno = g_xrem_m.xremdocno
 
               AND xrenseq = g_xren_d[l_ac].xrenseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xrem_m.xremdocno
               LET gs_keys[2] = g_xren_d[g_detail_idx].xrenseq
               CALL axrt930_insert_b('xren_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_xren_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xren_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL axrt930_b_fill()
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
               LET gs_keys[01] = g_xrem_m.xremdocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_xren_d_t.xrenseq
 
            
               #刪除同層單身
               IF NOT axrt930_delete_b('xren_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE axrt930_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT axrt930_key_delete_b(gs_keys,'xren_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE axrt930_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE axrt930_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_xren_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_xren_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrenseq
            #add-point:BEFORE FIELD xrenseq name="input.b.page1.xrenseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrenseq
            
            #add-point:AFTER FIELD xrenseq name="input.a.page1.xrenseq"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_xrem_m.xremdocno IS NOT NULL AND g_xren_d[g_detail_idx].xrenseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xrem_m.xremdocno != g_xremdocno_t OR g_xren_d[g_detail_idx].xrenseq != g_xren_d_t.xrenseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xren_t WHERE "||"xrenent = '" ||g_enterprise|| "' AND "||"xrendocno = '"||g_xrem_m.xremdocno ||"' AND "|| "xrenseq = '"||g_xren_d[g_detail_idx].xrenseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrenseq
            #add-point:ON CHANGE xrenseq name="input.g.page1.xrenseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrenorga
            #add-point:BEFORE FIELD xrenorga name="input.b.page1.xrenorga"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrenorga
            
            #add-point:AFTER FIELD xrenorga name="input.a.page1.xrenorga"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrenorga
            #add-point:ON CHANGE xrenorga name="input.g.page1.xrenorga"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren004
            #add-point:BEFORE FIELD xren004 name="input.b.page1.xren004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren004
            
            #add-point:AFTER FIELD xren004 name="input.a.page1.xren004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xren004
            #add-point:ON CHANGE xren004 name="input.g.page1.xren004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren005
            #add-point:BEFORE FIELD xren005 name="input.b.page1.xren005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren005
            
            #add-point:AFTER FIELD xren005 name="input.a.page1.xren005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xren005
            #add-point:ON CHANGE xren005 name="input.g.page1.xren005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren006
            #add-point:BEFORE FIELD xren006 name="input.b.page1.xren006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren006
            
            #add-point:AFTER FIELD xren006 name="input.a.page1.xren006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xren006
            #add-point:ON CHANGE xren006 name="input.g.page1.xren006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren007
            #add-point:BEFORE FIELD xren007 name="input.b.page1.xren007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren007
            
            #add-point:AFTER FIELD xren007 name="input.a.page1.xren007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xren007
            #add-point:ON CHANGE xren007 name="input.g.page1.xren007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren008
            #add-point:BEFORE FIELD xren008 name="input.b.page1.xren008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren008
            
            #add-point:AFTER FIELD xren008 name="input.a.page1.xren008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xren008
            #add-point:ON CHANGE xren008 name="input.g.page1.xren008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren100
            #add-point:BEFORE FIELD xren100 name="input.b.page1.xren100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren100
            
            #add-point:AFTER FIELD xren100 name="input.a.page1.xren100"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xren100
            #add-point:ON CHANGE xren100 name="input.g.page1.xren100"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren040
            #add-point:BEFORE FIELD xren040 name="input.b.page1.xren040"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren040
            
            #add-point:AFTER FIELD xren040 name="input.a.page1.xren040"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xren040
            #add-point:ON CHANGE xren040 name="input.g.page1.xren040"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren041
            #add-point:BEFORE FIELD xren041 name="input.b.page1.xren041"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren041
            
            #add-point:AFTER FIELD xren041 name="input.a.page1.xren041"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xren041
            #add-point:ON CHANGE xren041 name="input.g.page1.xren041"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren103
            #add-point:BEFORE FIELD xren103 name="input.b.page1.xren103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren103
            
            #add-point:AFTER FIELD xren103 name="input.a.page1.xren103"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xren103
            #add-point:ON CHANGE xren103 name="input.g.page1.xren103"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren104
            #add-point:BEFORE FIELD xren104 name="input.b.page1.xren104"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren104
            
            #add-point:AFTER FIELD xren104 name="input.a.page1.xren104"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xren104
            #add-point:ON CHANGE xren104 name="input.g.page1.xren104"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren105
            #add-point:BEFORE FIELD xren105 name="input.b.page1.xren105"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren105
            
            #add-point:AFTER FIELD xren105 name="input.a.page1.xren105"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xren105
            #add-point:ON CHANGE xren105 name="input.g.page1.xren105"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren113
            #add-point:BEFORE FIELD xren113 name="input.b.page1.xren113"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren113
            
            #add-point:AFTER FIELD xren113 name="input.a.page1.xren113"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xren113
            #add-point:ON CHANGE xren113 name="input.g.page1.xren113"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren114
            #add-point:BEFORE FIELD xren114 name="input.b.page1.xren114"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren114
            
            #add-point:AFTER FIELD xren114 name="input.a.page1.xren114"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xren114
            #add-point:ON CHANGE xren114 name="input.g.page1.xren114"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren115
            #add-point:BEFORE FIELD xren115 name="input.b.page1.xren115"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren115
            
            #add-point:AFTER FIELD xren115 name="input.a.page1.xren115"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xren115
            #add-point:ON CHANGE xren115 name="input.g.page1.xren115"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.xrenseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrenseq
            #add-point:ON ACTION controlp INFIELD xrenseq name="input.c.page1.xrenseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xrenorga
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrenorga
            #add-point:ON ACTION controlp INFIELD xrenorga name="input.c.page1.xrenorga"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xren004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren004
            #add-point:ON ACTION controlp INFIELD xren004 name="input.c.page1.xren004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xren005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren005
            #add-point:ON ACTION controlp INFIELD xren005 name="input.c.page1.xren005"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xren_d[l_ac].xren005             #給予default值
            LET g_qryparam.default2 = "" #g_xren_d[l_ac].xrca001 #账款单性质
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_xrcadocno()                                #呼叫開窗

            LET g_xren_d[l_ac].xren005 = g_qryparam.return1              
            #LET g_xren_d[l_ac].xrca001 = g_qryparam.return2 
            DISPLAY g_xren_d[l_ac].xren005 TO xren005              #
            #DISPLAY g_xren_d[l_ac].xrca001 TO xrca001 #账款单性质
            NEXT FIELD xren005                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.xren006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren006
            #add-point:ON ACTION controlp INFIELD xren006 name="input.c.page1.xren006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xren007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren007
            #add-point:ON ACTION controlp INFIELD xren007 name="input.c.page1.xren007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xren008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren008
            #add-point:ON ACTION controlp INFIELD xren008 name="input.c.page1.xren008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xren100
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren100
            #add-point:ON ACTION controlp INFIELD xren100 name="input.c.page1.xren100"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xren_d[l_ac].xren100             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooai001()                                #呼叫開窗

            LET g_xren_d[l_ac].xren100 = g_qryparam.return1              

            DISPLAY g_xren_d[l_ac].xren100 TO xren100              #

            NEXT FIELD xren100                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.xren040
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren040
            #add-point:ON ACTION controlp INFIELD xren040 name="input.c.page1.xren040"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xren041
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren041
            #add-point:ON ACTION controlp INFIELD xren041 name="input.c.page1.xren041"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xren103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren103
            #add-point:ON ACTION controlp INFIELD xren103 name="input.c.page1.xren103"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xren104
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren104
            #add-point:ON ACTION controlp INFIELD xren104 name="input.c.page1.xren104"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xren105
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren105
            #add-point:ON ACTION controlp INFIELD xren105 name="input.c.page1.xren105"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xren113
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren113
            #add-point:ON ACTION controlp INFIELD xren113 name="input.c.page1.xren113"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xren114
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren114
            #add-point:ON ACTION controlp INFIELD xren114 name="input.c.page1.xren114"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xren115
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren115
            #add-point:ON ACTION controlp INFIELD xren115 name="input.c.page1.xren115"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_xren_d[l_ac].* = g_xren_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE axrt930_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_xren_d[l_ac].xrenseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_xren_d[l_ac].* = g_xren_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL axrt930_xren_t_mask_restore('restore_mask_o')
      
               UPDATE xren_t SET (xrendocno,xrenseq,xrenorga,xren004,xren005,xren006,xren007,xren008, 
                   xren100,xren040,xren041,xren103,xren104,xren105,xren113,xren114,xren115,xren033,xren043, 
                   xren019,xren042,xren016,xren011,xren012,xren013,xren014,xren015,xren017,xren018,xren020, 
                   xren021,xren022,xren023,xren024,xren025,xren026,xren027,xren028,xren029,xren030,xren031, 
                   xren032) = (g_xrem_m.xremdocno,g_xren_d[l_ac].xrenseq,g_xren_d[l_ac].xrenorga,g_xren_d[l_ac].xren004, 
                   g_xren_d[l_ac].xren005,g_xren_d[l_ac].xren006,g_xren_d[l_ac].xren007,g_xren_d[l_ac].xren008, 
                   g_xren_d[l_ac].xren100,g_xren_d[l_ac].xren040,g_xren_d[l_ac].xren041,g_xren_d[l_ac].xren103, 
                   g_xren_d[l_ac].xren104,g_xren_d[l_ac].xren105,g_xren_d[l_ac].xren113,g_xren_d[l_ac].xren114, 
                   g_xren_d[l_ac].xren115,g_xren2_d[l_ac].xren033,g_xren2_d[l_ac].xren043,g_xren2_d[l_ac].xren019, 
                   g_xren2_d[l_ac].xren042,g_xren2_d[l_ac].xren016,g_xren2_d[l_ac].xren011,g_xren2_d[l_ac].xren012, 
                   g_xren2_d[l_ac].xren013,g_xren2_d[l_ac].xren014,g_xren2_d[l_ac].xren015,g_xren2_d[l_ac].xren017, 
                   g_xren2_d[l_ac].xren018,g_xren2_d[l_ac].xren020,g_xren2_d[l_ac].xren021,g_xren2_d[l_ac].xren022, 
                   g_xren2_d[l_ac].xren023,g_xren2_d[l_ac].xren024,g_xren2_d[l_ac].xren025,g_xren2_d[l_ac].xren026, 
                   g_xren2_d[l_ac].xren027,g_xren2_d[l_ac].xren028,g_xren2_d[l_ac].xren029,g_xren2_d[l_ac].xren030, 
                   g_xren2_d[l_ac].xren031,g_xren2_d[l_ac].xren032)
                WHERE xrenent = g_enterprise AND xrendocno = g_xrem_m.xremdocno 
 
                  AND xrenseq = g_xren_d_t.xrenseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_xren_d[l_ac].* = g_xren_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xren_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_xren_d[l_ac].* = g_xren_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xren_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xrem_m.xremdocno
               LET gs_keys_bak[1] = g_xremdocno_t
               LET gs_keys[2] = g_xren_d[g_detail_idx].xrenseq
               LET gs_keys_bak[2] = g_xren_d_t.xrenseq
               CALL axrt930_update_b('xren_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL axrt930_xren_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_xren_d[g_detail_idx].xrenseq = g_xren_d_t.xrenseq 
 
                  ) THEN
                  LET gs_keys[01] = g_xrem_m.xremdocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_xren_d_t.xrenseq
 
                  CALL axrt930_key_update_b(gs_keys,'xren_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_xrem_m),util.JSON.stringify(g_xren_d_t)
               LET g_log2 = util.JSON.stringify(g_xrem_m),util.JSON.stringify(g_xren_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL axrt930_unlock_b("xren_t","'1'")
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
               LET g_xren_d[li_reproduce_target].* = g_xren_d[li_reproduce].*
               LET g_xren2_d[li_reproduce_target].* = g_xren2_d[li_reproduce].*
 
               LET g_xren_d[li_reproduce_target].xrenseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_xren_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_xren_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
      INPUT ARRAY g_xren2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = FALSE, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = FALSE,
                 APPEND ROW = FALSE)
                 
         #自訂ACTION(detail_input,page_2)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body2.before_input2"
            
            #end add-point
            
            CALL axrt930_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue(""))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_xren2_d.getLength()
            #add-point:資料輸入前 name="input.body2.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_xren2_d[l_ac].* TO NULL 
            INITIALIZE g_xren2_d_t.* TO NULL 
            INITIALIZE g_xren2_d_o.* TO NULL 
            #公用欄位給值(單身2)
            
            #自定義預設值(單身2)
            
            #add-point:modify段before備份 name="input.body2.insert.before_bak"
            
            #end add-point
            LET g_xren2_d_t.* = g_xren2_d[l_ac].*     #新輸入資料
            LET g_xren2_d_o.* = g_xren2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL axrt930_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body2.insert.after_set_entry_b"
            
            #end add-point
            CALL axrt930_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xren_d[li_reproduce_target].* = g_xren_d[li_reproduce].*
               LET g_xren2_d[li_reproduce_target].* = g_xren2_d[li_reproduce].*
 
               LET g_xren2_d[li_reproduce_target].xrenseq = NULL
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
            OPEN axrt930_cl USING g_enterprise,g_xrem_m.xremdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN axrt930_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE axrt930_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_xren2_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_xren2_d[l_ac].xrenseq IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_xren2_d_t.* = g_xren2_d[l_ac].*  #BACKUP
               LET g_xren2_d_o.* = g_xren2_d[l_ac].*  #BACKUP
               CALL axrt930_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body2.after_set_entry_b"
               
               #end add-point  
               CALL axrt930_set_no_entry_b(l_cmd)
               IF NOT axrt930_lock_b("xren_t","'2'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH axrt930_bcl INTO g_xren_d[l_ac].xrenseq,g_xren_d[l_ac].xrenorga,g_xren_d[l_ac].xren004, 
                      g_xren_d[l_ac].xren005,g_xren_d[l_ac].xren006,g_xren_d[l_ac].xren007,g_xren_d[l_ac].xren008, 
                      g_xren_d[l_ac].xren100,g_xren_d[l_ac].xren040,g_xren_d[l_ac].xren041,g_xren_d[l_ac].xren103, 
                      g_xren_d[l_ac].xren104,g_xren_d[l_ac].xren105,g_xren_d[l_ac].xren113,g_xren_d[l_ac].xren114, 
                      g_xren_d[l_ac].xren115,g_xren2_d[l_ac].xrenseq,g_xren2_d[l_ac].xren033,g_xren2_d[l_ac].xren043, 
                      g_xren2_d[l_ac].xren019,g_xren2_d[l_ac].xren042,g_xren2_d[l_ac].xren016,g_xren2_d[l_ac].xren011, 
                      g_xren2_d[l_ac].xren012,g_xren2_d[l_ac].xren013,g_xren2_d[l_ac].xren014,g_xren2_d[l_ac].xren015, 
                      g_xren2_d[l_ac].xren017,g_xren2_d[l_ac].xren018,g_xren2_d[l_ac].xren020,g_xren2_d[l_ac].xren021, 
                      g_xren2_d[l_ac].xren022,g_xren2_d[l_ac].xren023,g_xren2_d[l_ac].xren024,g_xren2_d[l_ac].xren025, 
                      g_xren2_d[l_ac].xren026,g_xren2_d[l_ac].xren027,g_xren2_d[l_ac].xren028,g_xren2_d[l_ac].xren029, 
                      g_xren2_d[l_ac].xren030,g_xren2_d[l_ac].xren031,g_xren2_d[l_ac].xren032
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_xren2_d_mask_o[l_ac].* =  g_xren2_d[l_ac].*
                  CALL axrt930_xren_t_mask()
                  LET g_xren2_d_mask_n[l_ac].* =  g_xren2_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL axrt930_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body2.before_row"
            INITIALIZE g_glad.* TO NULL
            LET g_glad.glad017 = 'N' #自由核算項一控制方式
            LET g_glad.glad018 = 'N'
            LET g_glad.glad019 = 'N'
            LET g_glad.glad020 = 'N'
            LET g_glad.glad021 = 'N'
            LET g_glad.glad022 = 'N'
            LET g_glad.glad023 = 'N'
            LET g_glad.glad024 = 'N'
            LET g_glad.glad025 = 'N'
            LET g_glad.glad026 = 'N' #自由核算項十控制方式
            IF NOT cl_null(g_xren2_d[l_ac].xren019) THEN
                CALL axrt930_glad_chk(g_xren2_d[l_ac].xren019) RETURNING g_glad.*
            END IF  
            
            IF NOT cl_null(g_xren2_d[l_ac].xren042) THEN
                CALL axrt930_glad_chk(g_xren2_d[l_ac].xren042) RETURNING g_glad.*
            END IF
            
            IF NOT cl_null(g_xren2_d[l_ac].xren043) THEN
                CALL axrt930_glad_chk(g_xren2_d[l_ac].xren043) RETURNING g_glad.*   
            END IF 
            #CALL s_fin_sel_glad(g_xrem_m.xremld,g_xren2_d[l_ac].xren019,'ALL') RETURNING g_glad.*
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
               LET gs_keys[01] = g_xrem_m.xremdocno
               LET gs_keys[gs_keys.getLength()+1] = g_xren2_d_t.xrenseq
            
               #刪除同層單身
               IF NOT axrt930_delete_b('xren_t',gs_keys,"'2'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE axrt930_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT axrt930_key_delete_b(gs_keys,'xren_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE axrt930_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
 
               
               #add-point:單身2刪除中 name="input.body2.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE axrt930_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身2刪除後 name="input.body2.a_delete"
               
               #end add-point
               LET l_count = g_xren_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body2.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_xren2_d.getLength() + 1) THEN
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
            SELECT COUNT(1) INTO l_count FROM xren_t 
             WHERE xrenent = g_enterprise AND xrendocno = g_xrem_m.xremdocno
               AND xrenseq = g_xren2_d[l_ac].xrenseq
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前 name="input.body2.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xrem_m.xremdocno
               LET gs_keys[2] = g_xren2_d[g_detail_idx].xrenseq
               CALL axrt930_insert_b('xren_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2 name="input.body2.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_xren_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "xren_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL axrt930_b_fill()
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
               LET g_xren2_d[l_ac].* = g_xren2_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE axrt930_bcl
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
               LET g_xren2_d[l_ac].* = g_xren2_d_t.*
            ELSE
               #add-point:單身page2修改前 name="input.body2.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身2)
               
               
               #將遮罩欄位還原
               CALL axrt930_xren_t_mask_restore('restore_mask_o')
                              
               UPDATE xren_t SET (xrendocno,xrenseq,xrenorga,xren004,xren005,xren006,xren007,xren008, 
                   xren100,xren040,xren041,xren103,xren104,xren105,xren113,xren114,xren115,xren033,xren043, 
                   xren019,xren042,xren016,xren011,xren012,xren013,xren014,xren015,xren017,xren018,xren020, 
                   xren021,xren022,xren023,xren024,xren025,xren026,xren027,xren028,xren029,xren030,xren031, 
                   xren032) = (g_xrem_m.xremdocno,g_xren_d[l_ac].xrenseq,g_xren_d[l_ac].xrenorga,g_xren_d[l_ac].xren004, 
                   g_xren_d[l_ac].xren005,g_xren_d[l_ac].xren006,g_xren_d[l_ac].xren007,g_xren_d[l_ac].xren008, 
                   g_xren_d[l_ac].xren100,g_xren_d[l_ac].xren040,g_xren_d[l_ac].xren041,g_xren_d[l_ac].xren103, 
                   g_xren_d[l_ac].xren104,g_xren_d[l_ac].xren105,g_xren_d[l_ac].xren113,g_xren_d[l_ac].xren114, 
                   g_xren_d[l_ac].xren115,g_xren2_d[l_ac].xren033,g_xren2_d[l_ac].xren043,g_xren2_d[l_ac].xren019, 
                   g_xren2_d[l_ac].xren042,g_xren2_d[l_ac].xren016,g_xren2_d[l_ac].xren011,g_xren2_d[l_ac].xren012, 
                   g_xren2_d[l_ac].xren013,g_xren2_d[l_ac].xren014,g_xren2_d[l_ac].xren015,g_xren2_d[l_ac].xren017, 
                   g_xren2_d[l_ac].xren018,g_xren2_d[l_ac].xren020,g_xren2_d[l_ac].xren021,g_xren2_d[l_ac].xren022, 
                   g_xren2_d[l_ac].xren023,g_xren2_d[l_ac].xren024,g_xren2_d[l_ac].xren025,g_xren2_d[l_ac].xren026, 
                   g_xren2_d[l_ac].xren027,g_xren2_d[l_ac].xren028,g_xren2_d[l_ac].xren029,g_xren2_d[l_ac].xren030, 
                   g_xren2_d[l_ac].xren031,g_xren2_d[l_ac].xren032) #自訂欄位頁簽
                WHERE xrenent = g_enterprise AND xrendocno = g_xrem_m.xremdocno
                  AND xrenseq = g_xren2_d_t.xrenseq #項次 
                  
               #add-point:單身page2修改中 name="input.body2.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_xren2_d[l_ac].* = g_xren2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xren_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_xren2_d[l_ac].* = g_xren2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xren_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xrem_m.xremdocno
               LET gs_keys_bak[1] = g_xremdocno_t
               LET gs_keys[2] = g_xren2_d[g_detail_idx].xrenseq
               LET gs_keys_bak[2] = g_xren2_d_t.xrenseq
               CALL axrt930_update_b('xren_t',gs_keys,gs_keys_bak,"'2'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL axrt930_xren_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_xren2_d[g_detail_idx].xrenseq = g_xren2_d_t.xrenseq 
                  ) THEN
                  LET gs_keys[01] = g_xrem_m.xremdocno
                  LET gs_keys[gs_keys.getLength()+1] = g_xren2_d_t.xrenseq
                  CALL axrt930_key_update_b(gs_keys,'xren_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_xrem_m),util.JSON.stringify(g_xren2_d_t)
               LET g_log2 = util.JSON.stringify(g_xrem_m),util.JSON.stringify(g_xren2_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page2修改後 name="input.body2.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren0052
            #add-point:BEFORE FIELD xren0052 name="input.b.page2.xren0052"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren0052
            
            #add-point:AFTER FIELD xren0052 name="input.a.page2.xren0052"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xren0052
            #add-point:ON CHANGE xren0052 name="input.g.page2.xren0052"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren0062
            #add-point:BEFORE FIELD xren0062 name="input.b.page2.xren0062"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren0062
            
            #add-point:AFTER FIELD xren0062 name="input.a.page2.xren0062"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xren0062
            #add-point:ON CHANGE xren0062 name="input.g.page2.xren0062"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren0072
            #add-point:BEFORE FIELD xren0072 name="input.b.page2.xren0072"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren0072
            
            #add-point:AFTER FIELD xren0072 name="input.a.page2.xren0072"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xren0072
            #add-point:ON CHANGE xren0072 name="input.g.page2.xren0072"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren033
            #add-point:BEFORE FIELD xren033 name="input.b.page2.xren033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren033
            
            #add-point:AFTER FIELD xren033 name="input.a.page2.xren033"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xren033
            #add-point:ON CHANGE xren033 name="input.g.page2.xren033"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren043
            #add-point:BEFORE FIELD xren043 name="input.b.page2.xren043"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren043
            
            #add-point:AFTER FIELD xren043 name="input.a.page2.xren043"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xren043
            #add-point:ON CHANGE xren043 name="input.g.page2.xren043"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren043_desc
            #add-point:BEFORE FIELD xren043_desc name="input.b.page2.xren043_desc"
            LET g_xren2_d[l_ac].xren043_desc = g_xren2_d[l_ac].xren043   #20150528 add lujh
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren043_desc
            
            #add-point:AFTER FIELD xren043_desc name="input.a.page2.xren043_desc"
            LET g_xren2_d[l_ac].xren043 = g_xren2_d[l_ac].xren043_desc   #20150528 add lujh 
            #IF NOT cl_null(g_xren2_d[l_ac].xren043_desc) THEN           #20150528 mark lujh
            IF NOT cl_null(g_xren2_d[l_ac].xren043) THEN                 #20150528 add lujh
               # 开窗模糊查询 150916-00015#1 --add                      
               IF s_aglt310_getlike_lc_subject(g_xrem_m.xremld,g_xren2_d[l_ac].xren043,"")  THEN            
                  
                  SELECT glaa004 INTO l_glaa004
                    FROM glaa_t
                   WHERE glaaent = g_enterprise
                     AND glaald  = g_xrem_m.xremld
                  
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
                  LET g_qryparam.reqry = 'FALSE'
                  LET g_qryparam.default1 = g_xren2_d[l_ac].xren043
                                
                  LET g_qryparam.arg1 = l_glaa004
                  LET g_qryparam.arg2 = g_xren2_d[l_ac].xren043
                  LET g_qryparam.arg3 = g_xrem_m.xremld
                  LET g_qryparam.arg4 = " 1"
                  CALL q_glac002_6()
                  LET g_xren2_d[l_ac].xren043      = g_qryparam.return1
                  LET g_xren2_d[l_ac].xren043_desc = g_xren2_d[l_ac].xren043
                  DISPLAY BY NAME g_xren2_d[l_ac].xren043,g_xren2_d[l_ac].xren043_desc                 
               END IF
               #科目存在性，有效性，非统治科目，非子系统科目，账户科目属性检查
               IF NOT  s_aglt310_lc_subject(g_xrem_m.xremld,g_xren2_d[l_ac].xren043,'N') THEN
                     LET g_xren2_d[l_ac].xren043      = g_xren2_d_t.xren043
                     LET g_xren2_d[l_ac].xren043_desc = g_xren2_d_t.xren043_desc
                     NEXT FIELD CURRENT
               END IF
               # 150916-00015#1 --end

               #20150528--mark--str--lujh
               #IF g_xren2_d[l_ac].xren043_desc != g_xren2_d_t.xren043_desc OR g_xren2_d_t.xren043_desc IS NULL THEN
               #   LET g_xren2_d[l_ac].xren043 = g_xren2_d[l_ac].xren043_desc
               #20150528--mark--end--lujh
#                  CALL s_aap_glac002_chk(g_xren2_d[l_ac].xren043,g_xrem_m.xremld) RETURNING g_sub_success,g_errno
#                  IF NOT g_sub_success THEN
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code = g_errno
#                     LET g_errparam.extend = ''
#                     LET g_errparam.popup = TRUE
#                     CALL cl_err()
#                     LET g_xren2_d[l_ac].xren043      = g_xren2_d_t.xren043
#                     LET g_xren2_d[l_ac].xren043_desc = g_xren2_d_t.xren043_desc
#                     DISPLAY BY NAME g_xren2_d[l_ac].xren043,g_xren2_d[l_ac].xren043_desc
#                     NEXT FIELD CURRENT
#                  END IF
               #END IF  #20150528 mark lujh
            END IF        
            LET g_xren2_d[l_ac].xren043_desc = s_desc_show1(g_xren2_d[l_ac].xren043,s_desc_get_account_desc(g_xrem_m.xremld,g_xren2_d[l_ac].xren043))
            LET g_xren2_d_t.xren043_desc = g_xren2_d[l_ac].xren043_desc
            DISPLAY BY NAME g_xren2_d[l_ac].xren043 ,g_xren2_d[l_ac].xren043_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xren043_desc
            #add-point:ON CHANGE xren043_desc name="input.g.page2.xren043_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren019
            #add-point:BEFORE FIELD xren019 name="input.b.page2.xren019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren019
            
            #add-point:AFTER FIELD xren019 name="input.a.page2.xren019"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xren019
            #add-point:ON CHANGE xren019 name="input.g.page2.xren019"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren019_desc
            #add-point:BEFORE FIELD xren019_desc name="input.b.page2.xren019_desc"
            LET g_xren2_d[l_ac].xren019_desc = g_xren2_d[l_ac].xren019   #20150528 add lujh
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren019_desc
            
            #add-point:AFTER FIELD xren019_desc name="input.a.page2.xren019_desc"
            LET g_xren2_d[l_ac].xren019 = g_xren2_d[l_ac].xren019_desc   #20150528 add lujh  
            #IF NOT cl_null(g_xren2_d[l_ac].xren019_desc) THEN           #20150528 mark lujh
            IF NOT cl_null(g_xren2_d[l_ac].xren019) THEN                 #20150528 add lujh
               # 开窗模糊查询 150916-00015#1 --add                      
               IF s_aglt310_getlike_lc_subject(g_xrem_m.xremld,g_xren2_d[l_ac].xren019,"")  THEN            
                  
                  SELECT glaa004 INTO l_glaa004
                    FROM glaa_t
                   WHERE glaaent = g_enterprise
                     AND glaald  = g_xrem_m.xremld
                  
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
                  LET g_qryparam.reqry = 'FALSE'
                  LET g_qryparam.default1 = g_xren2_d[l_ac].xren019
                                
                  LET g_qryparam.arg1 = l_glaa004
                  LET g_qryparam.arg2 = g_xren2_d[l_ac].xren019
                  LET g_qryparam.arg3 = g_xrem_m.xremld
                  LET g_qryparam.arg4 = " 1"
                  CALL q_glac002_6()
                  LET g_xren2_d[l_ac].xren019      = g_qryparam.return1
                  LET g_xren2_d[l_ac].xren019_desc = g_xren2_d[l_ac].xren019
                  DISPLAY BY NAME g_xren2_d[l_ac].xren019,g_xren2_d[l_ac].xren019_desc                
               END IF
               #科目存在性，有效性，非统治科目，非子系统科目，账户科目属性检查
               IF NOT  s_aglt310_lc_subject(g_xrem_m.xremld,g_xren2_d[l_ac].xren019,'N') THEN
                     LET g_xren2_d[l_ac].xren019      = g_xren2_d_t.xren019
                     LET g_xren2_d[l_ac].xren019_desc = g_xren2_d_t.xren019_desc
                     DISPLAY BY NAME g_xren2_d[l_ac].xren043,g_xren2_d[l_ac].xren043_desc
                     NEXT FIELD CURRENT
               END IF
               # 150916-00015#1 --end
               #20150528--mark--str--lujh
               #IF g_xren2_d[l_ac].xren019_desc != g_xren2_d_t.xren019_desc OR g_xren2_d_t.xren019_desc IS NULL THEN
               #   LET g_xren2_d[l_ac].xren019 = g_xren2_d[l_ac].xren019_desc
               #20150528--mark--end--lujh
#                  CALL s_aap_glac002_chk(g_xren2_d[l_ac].xren019,g_xrem_m.xremld) RETURNING g_sub_success,g_errno
#                  IF NOT g_sub_success THEN
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code = g_errno
#                     LET g_errparam.extend = ''
#                     LET g_errparam.popup = TRUE
#                     CALL cl_err()
#                     LET g_xren2_d[l_ac].xren019      = g_xren2_d_t.xren019
#                     LET g_xren2_d[l_ac].xren019_desc = g_xren2_d_t.xren019_desc
#                     DISPLAY BY NAME g_xren2_d[l_ac].xren043,g_xren2_d[l_ac].xren043_desc
#                     NEXT FIELD CURRENT
#                  END IF
               #END IF   #20150528 mark lujh
            END IF
            LET g_xren2_d[l_ac].xren019_desc = s_desc_show1(g_xren2_d[l_ac].xren019,s_desc_get_account_desc(g_xrem_m.xremld,g_xren2_d[l_ac].xren019))
            LET g_xren2_d_t.xren019_desc = g_xren2_d[l_ac].xren019_desc
            DISPLAY BY NAME g_xren2_d[l_ac].xren019 ,g_xren2_d[l_ac].xren019_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xren019_desc
            #add-point:ON CHANGE xren019_desc name="input.g.page2.xren019_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren042
            #add-point:BEFORE FIELD xren042 name="input.b.page2.xren042"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren042
            
            #add-point:AFTER FIELD xren042 name="input.a.page2.xren042"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xren042
            #add-point:ON CHANGE xren042 name="input.g.page2.xren042"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren042_desc
            #add-point:BEFORE FIELD xren042_desc name="input.b.page2.xren042_desc"
            LET g_xren2_d[l_ac].xren042_desc = g_xren2_d[l_ac].xren042   #20150528 add lujh
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren042_desc
            
            #add-point:AFTER FIELD xren042_desc name="input.a.page2.xren042_desc"
            LET g_xren2_d[l_ac].xren042 = g_xren2_d[l_ac].xren042_desc   #20150528 add lujh
            #IF NOT cl_null(g_xren2_d[l_ac].xren042_desc) THEN           #20150528 mark lujh
            IF NOT cl_null(g_xren2_d[l_ac].xren042) THEN                 #20150528 add lujh
               # 开窗模糊查询 150916-00015#1 --add                      
               IF s_aglt310_getlike_lc_subject(g_xrem_m.xremld,g_xren2_d[l_ac].xren042,"")  THEN            
                  
                  SELECT glaa004 INTO l_glaa004
                    FROM glaa_t
                   WHERE glaaent = g_enterprise
                     AND glaald  = g_xrem_m.xremld
                  
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
                  LET g_qryparam.reqry = 'FALSE'
                  LET g_qryparam.default1 = g_xren2_d[l_ac].xren042
                                
                  LET g_qryparam.arg1 = l_glaa004
                  LET g_qryparam.arg2 = g_xren2_d[l_ac].xren042
                  LET g_qryparam.arg3 = g_xrem_m.xremld
                  LET g_qryparam.arg4 = " 1"
                  CALL q_glac002_6()
                  LET g_xren2_d[l_ac].xren042      = g_qryparam.return1
                  LET g_xren2_d[l_ac].xren042_desc = g_xren2_d[l_ac].xren042
                  DISPLAY BY NAME g_xren2_d[l_ac].xren042,g_xren2_d[l_ac].xren042_desc                 
               END IF
               #科目存在性，有效性，非统治科目，非子系统科目，账户科目属性检查
               IF NOT  s_aglt310_lc_subject(g_xrem_m.xremld,g_xren2_d[l_ac].xren042,'N') THEN
                     LET g_xren2_d[l_ac].xren042      = g_xren2_d_t.xren042
                     LET g_xren2_d[l_ac].xren042_desc = g_xren2_d_t.xren042_desc
                     DISPLAY BY NAME g_xren2_d[l_ac].xren043,g_xren2_d[l_ac].xren043_desc
                     NEXT FIELD CURRENT
               END IF
               # 150916-00015#1 --end
               #20150528--mark--str--lujh
               #IF g_xren2_d[l_ac].xren042_desc != g_xren2_d_t.xren042_desc OR g_xren2_d_t.xren042_desc IS NULL THEN
               #   LET g_xren2_d[l_ac].xren042 = g_xren2_d[l_ac].xren042_desc
               #20150528--mark--end--lujh
#                  CALL s_aap_glac002_chk(g_xren2_d[l_ac].xren042,g_xrem_m.xremld) RETURNING g_sub_success,g_errno
#                  IF NOT g_sub_success THEN
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code = g_errno
#                     LET g_errparam.extend = ''
#                     LET g_errparam.popup = TRUE
#                     CALL cl_err()
#                     LET g_xren2_d[l_ac].xren042      = g_xren2_d_t.xren042
#                     LET g_xren2_d[l_ac].xren042_desc = g_xren2_d_t.xren042_desc
#                     DISPLAY BY NAME g_xren2_d[l_ac].xren043,g_xren2_d[l_ac].xren043_desc
#                     NEXT FIELD CURRENT
#                  END IF
               #END IF   #20150528 mark lujh
            END IF        
            LET g_xren2_d[l_ac].xren042_desc = s_desc_show1(g_xren2_d[l_ac].xren042,s_desc_get_account_desc(g_xrem_m.xremld,g_xren2_d[l_ac].xren042))
            LET g_xren2_d_t.xren042_desc = g_xren2_d[l_ac].xren042_desc
            DISPLAY BY NAME g_xren2_d[l_ac].xren042,g_xren2_d[l_ac].xren042_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xren042_desc
            #add-point:ON CHANGE xren042_desc name="input.g.page2.xren042_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren016
            #add-point:BEFORE FIELD xren016 name="input.b.page2.xren016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren016
            
            #add-point:AFTER FIELD xren016 name="input.a.page2.xren016"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xren016
            #add-point:ON CHANGE xren016 name="input.g.page2.xren016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren016_desc
            #add-point:BEFORE FIELD xren016_desc name="input.b.page2.xren016_desc"
            LET g_xren2_d[l_ac].xren016_desc = g_xren2_d[l_ac].xren016   #20150528 add lujh
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren016_desc
            
            #add-point:AFTER FIELD xren016_desc name="input.a.page2.xren016_desc"
            #業務人員
            LET g_xren2_d[l_ac].xren016 = g_xren2_d[l_ac].xren016_desc   #20150528 add lujh
            #IF NOT cl_null(g_xren2_d[l_ac].xren016_desc) THEN           #20150528 mark lujh
            IF NOT cl_null(g_xren2_d[l_ac].xren016) THEN                 #20150528 add lujh
               #20150528--mark--str--lujh
               #IF ( g_xren2_d[l_ac].xren016_desc != g_xren2_d_t.xren016_desc OR g_xren2_d_t.xren016_desc IS NULL ) THEN
               #   LET g_xren2_d[l_ac].xren016 = g_xren2_d[l_ac].xren016_desc
               #20150528--mark--end--lujh
                  CALL s_employee_chk(g_xren2_d[l_ac].xren016_desc) RETURNING g_sub_success
                  IF NOT g_sub_success THEN
                     LET g_xren2_d[l_ac].xren016      = g_xren2_d_t.xren016
                     LET g_xren2_d[l_ac].xren016_desc = g_xren2_d_t.xren016_desc
                     DISPLAY BY NAME g_xren2_d[l_ac].xren016 ,g_xren2_d[l_ac].xren016_desc
                     NEXT FIELD CURRENT
                  END IF

               #END IF   #20150528 mark lujh
            END IF
            LET g_xren2_d[l_ac].xren016_desc = s_desc_show1(g_xren2_d[l_ac].xren016,s_desc_get_person_desc(g_xren2_d[l_ac].xren016))
            LET g_xren2_d_t.xren016_desc = g_xren2_d[l_ac].xren016_desc
            DISPLAY BY NAME g_xren2_d[l_ac].xren016 ,g_xren2_d[l_ac].xren016_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xren016_desc
            #add-point:ON CHANGE xren016_desc name="input.g.page2.xren016_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren011
            #add-point:BEFORE FIELD xren011 name="input.b.page2.xren011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren011
            
            #add-point:AFTER FIELD xren011 name="input.a.page2.xren011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xren011
            #add-point:ON CHANGE xren011 name="input.g.page2.xren011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren011_desc
            #add-point:BEFORE FIELD xren011_desc name="input.b.page2.xren011_desc"
            LET g_xren2_d[l_ac].xren011_desc = g_xren2_d[l_ac].xren011   #20150528 add lujh
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren011_desc
            
            #add-point:AFTER FIELD xren011_desc name="input.a.page2.xren011_desc"
            #業務部門
            LET g_xren2_d[l_ac].xren011 = g_xren2_d[l_ac].xren011_desc   #20150528 add lujh
            #IF NOT cl_null(g_xren2_d[l_ac].xren011_desc) THEN           #20150528 mark lujh
            IF NOT cl_null(g_xren2_d[l_ac].xren011) THEN                 #20150528 add lujh
               #20150528--mark--str--lujh
               #IF ( g_xren2_d[l_ac].xren011_desc != g_xren2_d_t.xren011_desc OR g_xren2_d_t.xren011_desc IS NULL ) THEN
               #   LET g_xren2_d[l_ac].xren011 = g_xren2_d[l_ac].xren011_desc
               #20150528--mark--end--lujh
                  CALL s_department_chk(g_xren2_d[l_ac].xren011,g_xrem_m.xremdocdt) RETURNING g_sub_success
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_xren2_d[l_ac].xren011      = g_xren2_d_t.xren011
                     LET g_xren2_d[l_ac].xren011_desc = g_xren2_d_t.xren011_desc
                     DISPLAY BY NAME g_xren2_d[l_ac].xren011,g_xren2_d[l_ac].xren011_desc
                     NEXT FIELD CURRENT
                  END IF
               #END IF   #20150528 mark lujh
            END IF
            LET g_xren2_d[l_ac].xren011_desc = s_desc_show1(g_xren2_d[l_ac].xren011,s_desc_get_department_desc(g_xren2_d[l_ac].xren011))
            LET g_xren2_d_t.xren011_desc = g_xren2_d[l_ac].xren011_desc
            DISPLAY BY NAME g_xren2_d[l_ac].xren011,g_xren2_d[l_ac].xren011_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xren011_desc
            #add-point:ON CHANGE xren011_desc name="input.g.page2.xren011_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren012
            #add-point:BEFORE FIELD xren012 name="input.b.page2.xren012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren012
            
            #add-point:AFTER FIELD xren012 name="input.a.page2.xren012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xren012
            #add-point:ON CHANGE xren012 name="input.g.page2.xren012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren012_desc
            #add-point:BEFORE FIELD xren012_desc name="input.b.page2.xren012_desc"
            LET g_xren2_d[l_ac].xren012_desc = g_xren2_d[l_ac].xren012   #20150528 add lujh
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren012_desc
            
            #add-point:AFTER FIELD xren012_desc name="input.a.page2.xren012_desc"
            #責任中心
            LET g_xren2_d[l_ac].xren012 = g_xren2_d[l_ac].xren012_desc   #20150528 add lujh
            #IF NOT cl_null(g_xren2_d[l_ac].xren012_desc) THEN           #20150528 mark lujh
            IF NOT cl_null(g_xren2_d[l_ac].xren012) THEN                 #20150528 add lujh
               #20150528--mark--str--lujh
               #IF ( g_xren2_d[l_ac].xren012_desc != g_xren2_d_t.xren012_desc OR g_xren2_d_t.xren012_desc IS NULL ) THEN
               #   LET g_xren2_d[l_ac].xren012 = g_xren2_d[l_ac].xren012_desc
               #20150528--mark--end--lujh
                  CALL s_department_chk(g_xren2_d[l_ac].xren012,g_xrem_m.xremdocdt) RETURNING g_sub_success
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()                    
                     LET g_xren2_d[l_ac].xren012      = g_xren2_d_t.xren012
                     LET g_xren2_d[l_ac].xren012_desc = g_xren2_d_t.xren012_desc
                     DISPLAY BY NAME g_xren2_d[l_ac].xren012 ,g_xren2_d[l_ac].xren012_desc
                     NEXT FIELD CURRENT
                  END IF
               #END IF   #20150528 mark lujh
            END IF
            LET g_xren2_d[l_ac].xren012_desc = s_desc_show1(g_xren2_d[l_ac].xren012,s_desc_get_department_desc(g_xren2_d[l_ac].xren012))
            LET g_xren2_d_t.xren012_desc = g_xren2_d[l_ac].xren012_desc
            DISPLAY BY NAME g_xren2_d[l_ac].xren012,g_xren2_d[l_ac].xren012_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xren012_desc
            #add-point:ON CHANGE xren012_desc name="input.g.page2.xren012_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren013
            #add-point:BEFORE FIELD xren013 name="input.b.page2.xren013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren013
            
            #add-point:AFTER FIELD xren013 name="input.a.page2.xren013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xren013
            #add-point:ON CHANGE xren013 name="input.g.page2.xren013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren013_desc
            #add-point:BEFORE FIELD xren013_desc name="input.b.page2.xren013_desc"
            LET g_xren2_d[l_ac].xren013_desc = g_xren2_d[l_ac].xren013   #20150528 add lujh
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren013_desc
            
            #add-point:AFTER FIELD xren013_desc name="input.a.page2.xren013_desc"
            #區域
            LET g_xren2_d[l_ac].xren013 = g_xren2_d[l_ac].xren013_desc   #20150528 add lujh
            #IF NOT cl_null(g_xren2_d[l_ac].xren013_desc) THEN           #20150528 mark lujh 
            IF NOT cl_null(g_xren2_d[l_ac].xren013) THEN                 #20150528 add lujh
               #20150528--mark--str--lujh
               #IF ( g_xren2_d[l_ac].xren013_desc != g_xren2_d_t.xren013_desc OR g_xren2_d_t.xren013_desc IS NULL ) THEN
               #   LET g_xren2_d[l_ac].xren013 = g_xren2_d[l_ac].xren013_desc
               #20150528--mark--end--lujh
                  IF NOT s_azzi650_chk_exist('287',g_xren2_d[l_ac].xren013) THEN
                     LET g_xren2_d[l_ac].xren013      = g_xren2_d_t.xren013
                     LET g_xren2_d[l_ac].xren013_desc = g_xren2_d_t.xren013_desc
                     DISPLAY BY NAME g_xren2_d[l_ac].xren013 ,g_xren2_d[l_ac].xren013_desc
                     NEXT FIELD CURRENT
                  END IF
               #END IF  #20150528 mark lujh
            END IF
            LET g_xren2_d[l_ac].xren013_desc = s_desc_show1(g_xren2_d[l_ac].xren013,s_desc_get_acc_desc('287',g_xren2_d[l_ac].xren013))
            LET g_xren2_d_t.xren013_desc = g_xren2_d[l_ac].xren013_desc
            DISPLAY BY NAME g_xren2_d[l_ac].xren013 ,g_xren2_d[l_ac].xren013_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xren013_desc
            #add-point:ON CHANGE xren013_desc name="input.g.page2.xren013_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren014
            #add-point:BEFORE FIELD xren014 name="input.b.page2.xren014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren014
            
            #add-point:AFTER FIELD xren014 name="input.a.page2.xren014"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xren014
            #add-point:ON CHANGE xren014 name="input.g.page2.xren014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren014_desc
            #add-point:BEFORE FIELD xren014_desc name="input.b.page2.xren014_desc"
            LET g_xren2_d[l_ac].xren014_desc = g_xren2_d[l_ac].xren014   #20150528 add lujh
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren014_desc
            
            #add-point:AFTER FIELD xren014_desc name="input.a.page2.xren014_desc"
            #客群
            LET g_xren2_d[l_ac].xren014 = g_xren2_d[l_ac].xren014_desc   #20150528 add lujh
            #IF NOT cl_null(g_xren2_d[l_ac].xren014_desc) THEN           #20150528 mark lujh 
            IF NOT cl_null(g_xren2_d[l_ac].xren014) THEN                 #20150528 add lujh
               #20150528--mark--str--lujh
               #IF ( g_xren2_d[l_ac].xren014_desc != g_xren2_d_t.xren014_desc OR g_xren2_d_t.xren014_desc IS NULL ) THEN
               #   LET g_xren2_d[l_ac].xren014 = g_xren2_d[l_ac].xren014_desc
               #20150528--mark--end--lujh
                  IF NOT s_azzi650_chk_exist('281',g_xren2_d[l_ac].xren014) THEN           
                     LET g_xren2_d[l_ac].xren014      = g_xren2_d_t.xren014
                     LET g_xren2_d[l_ac].xren014_desc = g_xren2_d_t.xren014_desc
                     DISPLAY BY NAME g_xren2_d[l_ac].xren014_desc ,g_xren2_d[l_ac].xren014_desc
                     NEXT FIELD CURRENT
                  END IF
               #END IF   #20150528 mark lujh 
            END IF
            LET g_xren2_d[l_ac].xren014_desc = s_desc_show1(g_xren2_d[l_ac].xren014,s_desc_get_acc_desc('281',g_xren2_d[l_ac].xren014))
            DISPLAY BY NAME g_xren2_d[l_ac].xren014 ,g_xren2_d[l_ac].xren014_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xren014_desc
            #add-point:ON CHANGE xren014_desc name="input.g.page2.xren014_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren015
            #add-point:BEFORE FIELD xren015 name="input.b.page2.xren015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren015
            
            #add-point:AFTER FIELD xren015 name="input.a.page2.xren015"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xren015
            #add-point:ON CHANGE xren015 name="input.g.page2.xren015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren015_desc
            #add-point:BEFORE FIELD xren015_desc name="input.b.page2.xren015_desc"
            LET g_xren2_d[l_ac].xren015_desc = g_xren2_d[l_ac].xren015   #20150528 add lujh
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren015_desc
            
            #add-point:AFTER FIELD xren015_desc name="input.a.page2.xren015_desc"
            #產品類別
            LET g_xren2_d[l_ac].xren015 = g_xren2_d[l_ac].xren015_desc   #20150528 add lujh
            #IF NOT cl_null(g_xren2_d[l_ac].xren015_desc) THEN           #20150528 mark lujh 
            IF NOT cl_null(g_xren2_d[l_ac].xren015) THEN                 #20150528 add lujh
               #20150528--mark--str--lujh
               #IF ( g_xren2_d[l_ac].xren015_desc != g_xren2_d_t.xren015_desc OR g_xren2_d_t.xren015_desc IS NULL ) THEN
               #   LET g_xren2_d[l_ac].xren015 = g_xren2_d[l_ac].xren015_desc
               #20150528--mark--end--lujh
                  CALL s_aap_rtax001_chk(g_xren2_d[l_ac].xren015) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ""
                     LET g_errparam.code   = g_errno
                     LET g_errparam.popup  = TRUE
                     #160321-00016#53 --s add
                     LET g_errparam.replace[1] = 'arti202'
                     LET g_errparam.replace[2] = cl_get_progname('arti202',g_lang,"2")
                     LET g_errparam.exeprog = 'arti202'
                     #160321-00016#53 --e add  
                     CALL cl_err()
                     LET g_xren2_d[l_ac].xren015      = g_xren2_d_t.xren015
                     LET g_xren2_d[l_ac].xren015_desc = g_xren2_d_t.xren015_desc
                     DISPLAY BY NAME g_xren2_d[l_ac].xren015 ,g_xren2_d[l_ac].xren015_desc
                     NEXT FIELD CURRENT
                  END IF
               #END IF   #20150528 mark lujh 
            END IF
            LET g_xren2_d[l_ac].xren015_desc = s_desc_show1(g_xren2_d[l_ac].xren015,s_desc_get_rtaxl003_desc(g_xren2_d[l_ac].xren015))
            LET g_xren2_d_t.xren015_desc = g_xren2_d[l_ac].xren015_desc
            DISPLAY BY NAME g_xren2_d[l_ac].xren015 ,g_xren2_d[l_ac].xren015_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xren015_desc
            #add-point:ON CHANGE xren015_desc name="input.g.page2.xren015_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren017
            #add-point:BEFORE FIELD xren017 name="input.b.page2.xren017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren017
            
            #add-point:AFTER FIELD xren017 name="input.a.page2.xren017"
             
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xren017
            #add-point:ON CHANGE xren017 name="input.g.page2.xren017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren017_desc
            #add-point:BEFORE FIELD xren017_desc name="input.b.page2.xren017_desc"
            LET g_xren2_d[l_ac].xren017_desc = g_xren2_d[l_ac].xren017   #20150528 add lujh
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren017_desc
            
            #add-point:AFTER FIELD xren017_desc name="input.a.page2.xren017_desc"
            #專案代號
            LET g_xren2_d[l_ac].xren017 = g_xren2_d[l_ac].xren017_desc   #20150528 add lujh
            #IF NOT cl_null(g_xren2_d[l_ac].xren017_desc) THEN           #20150528 mark lujh
            IF NOT cl_null(g_xren2_d[l_ac].xren017) THEN                 #20150528 add lujh
               #20150528--mark--str--lujh
               #IF ( g_xren2_d[l_ac].xren017_desc != g_xren2_d_t.xren017_desc OR g_xren2_d_t.xren017_desc IS NULL ) THEN
               #   LET g_xren2_d[l_ac].xren017 = g_xren2_d[l_ac].xren017_desc
               #30150528--mark--end--lujh
                  CALL s_aap_project_chk( g_xren2_d[l_ac].xren017) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                      INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     #160321-00016#53 --s add
                     LET g_errparam.replace[1] = 'apjm200'
                     LET g_errparam.replace[2] = cl_get_progname('apjm200',g_lang,"2")
                     LET g_errparam.exeprog = 'apjm200'
                     #160321-00016#53 --e add
                     CALL cl_err()
                     LET g_xren2_d[l_ac].xren017      = g_xren2_d_t.xren017
                     LET g_xren2_d[l_ac].xren017_desc = g_xren2_d_t.xren017_desc
                     DISPLAY BY NAME g_xren2_d[l_ac].xren017,g_xren2_d[l_ac].xren017_desc
                     NEXT FIELD CURRENT
                  END IF
               #END IF   #20150528 mark lujh
            END IF
            LET g_xren2_d[l_ac].xren017_desc = s_desc_show1(g_xren2_d[l_ac].xren017,s_desc_get_project_desc(g_xren2_d[l_ac].xren017))
            DISPLAY BY NAME g_xren2_d[l_ac].xren017,g_xren2_d[l_ac].xren017_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xren017_desc
            #add-point:ON CHANGE xren017_desc name="input.g.page2.xren017_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren018
            #add-point:BEFORE FIELD xren018 name="input.b.page2.xren018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren018
            
            #add-point:AFTER FIELD xren018 name="input.a.page2.xren018"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xren018
            #add-point:ON CHANGE xren018 name="input.g.page2.xren018"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren018_desc
            #add-point:BEFORE FIELD xren018_desc name="input.b.page2.xren018_desc"
            LET g_xren2_d[l_ac].xren018_desc = g_xren2_d[l_ac].xren018   #20150528 add lujh
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren018_desc
            
            #add-point:AFTER FIELD xren018_desc name="input.a.page2.xren018_desc"
            #20150528--add--str--lujh
            LET g_xren2_d[l_ac].xren018 = g_xren2_d[l_ac].xren018_desc
            CALL axrt930_xren018_desc(g_xren2_d[l_ac].xren017,g_xren2_d[l_ac].xren018) RETURNING g_xren2_d[l_ac].xren018_desc
            LET g_xren2_d[l_ac].xren018_desc = g_xren2_d[l_ac].xren018 CLIPPED,g_xren2_d[l_ac].xren018_desc
            IF NOT cl_null(g_xren2_d[l_ac].xren018) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL    
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xren2_d[l_ac].xren017
               LET g_chkparam.arg2 = g_xren2_d[l_ac].xren018
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_pjbb002") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_xren2_d[l_ac].xren018 = g_xren2_d_t.xren018
                  LET g_xren2_d[l_ac].xren018_desc = g_xren2_d_t.xren018_desc
                  NEXT FIELD CURRENT
               END IF
            END IF 
            #20150528--add--end--lujh
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xren018_desc
            #add-point:ON CHANGE xren018_desc name="input.g.page2.xren018_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren020
            #add-point:BEFORE FIELD xren020 name="input.b.page2.xren020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren020
            
            #add-point:AFTER FIELD xren020 name="input.a.page2.xren020"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xren020
            #add-point:ON CHANGE xren020 name="input.g.page2.xren020"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren021
            #add-point:BEFORE FIELD xren021 name="input.b.page2.xren021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren021
            
            #add-point:AFTER FIELD xren021 name="input.a.page2.xren021"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xren021
            #add-point:ON CHANGE xren021 name="input.g.page2.xren021"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren021_desc
            #add-point:BEFORE FIELD xren021_desc name="input.b.page2.xren021_desc"
            LET g_xren2_d[l_ac].xren021_desc = g_xren2_d[l_ac].xren021   #20150528 add lujh
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren021_desc
            
            #add-point:AFTER FIELD xren021_desc name="input.a.page2.xren021_desc"
            #銷售渠道
            LET g_xren2_d[l_ac].xren021 = g_xren2_d[l_ac].xren021_desc   #20150528 add lujh
            #IF NOT cl_null(g_xren2_d[l_ac].xren021_desc) THEN           #20150528 mark lujh
            IF NOT cl_null(g_xren2_d[l_ac].xren021) THEN                 #20150528 add lujh
               #20150528--mark--str--lujh
               #IF ( g_xren2_d[l_ac].xren021_desc != g_xren2_d_t.xren021_desc OR g_xren2_d_t.xren021_desc IS NULL ) THEN
               #   LET g_xren2_d[l_ac].xren021 = g_xren2_d[l_ac].xren021_desc
               #20150528--mark--end--lujh
                  CALL axrt930_xren021_chk(g_xren2_d[l_ac].xren021)RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_xren2_d[l_ac].xren021      = g_xren2_d_t.xren021
                     LET g_xren2_d[l_ac].xren021_desc = g_xren2_d_t.xren021_desc
                     DISPLAY BY NAME g_xren2_d[l_ac].xren021,g_xren2_d[l_ac].xren021_desc
                     NEXT FIELD CURRENT
                  END IF
               #END IF   #20150528 mark lujh
            END IF
            LET g_xren2_d[l_ac].xren021_desc = s_desc_show1(g_xren2_d[l_ac].xren021,s_desc_get_oojdl003_desc(g_xren2_d[l_ac].xren021))
            DISPLAY BY NAME g_xren2_d[l_ac].xren021,g_xren2_d[l_ac].xren021_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xren021_desc
            #add-point:ON CHANGE xren021_desc name="input.g.page2.xren021_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren022
            #add-point:BEFORE FIELD xren022 name="input.b.page2.xren022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren022
            
            #add-point:AFTER FIELD xren022 name="input.a.page2.xren022"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xren022
            #add-point:ON CHANGE xren022 name="input.g.page2.xren022"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren022_desc
            #add-point:BEFORE FIELD xren022_desc name="input.b.page2.xren022_desc"
            LET g_xren2_d[l_ac].xren022_desc = g_xren2_d[l_ac].xren022   #20150528 add lujh
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren022_desc
            
            #add-point:AFTER FIELD xren022_desc name="input.a.page2.xren022_desc"
            #品牌
            LET g_xren2_d[l_ac].xren022 = g_xren2_d[l_ac].xren022_desc   #20150528 add lujh
            #IF NOT cl_null(g_xren2_d[l_ac].xren022_desc) THEN           #20150528 mark lujh
            IF NOT cl_null(g_xren2_d[l_ac].xren022) THEN                 #20150528 add lujh
               #20150528--mark--str--lujh
               #IF ( g_xren2_d[l_ac].xren022_desc != g_xren2_d_t.xren022_desc OR g_xren2_d_t.xren022_desc IS NULL ) THEN
               #   LET g_xren2_d[l_ac].xren022 = g_xren2_d[l_ac].xren022_desc
               #20150528--mark--end--lujh
                  IF NOT s_azzi650_chk_exist('2002',g_xren2_d[l_ac].xren022) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_xren2_d[l_ac].xren022      = g_xren2_d_t.xren022
                     LET g_xren2_d[l_ac].xren022_desc = g_xren2_d_t.xren022_desc
                     DISPLAY BY NAME g_xren2_d[l_ac].xren022,g_xren2_d[l_ac].xren022_desc
                     NEXT FIELD CURRENT
                  END IF
               #END IF   #20150528 mark lujh
            END IF
            LET g_xren2_d[l_ac].xren022_desc = s_desc_show1(g_xren2_d[l_ac].xren022,s_desc_get_acc_desc(2002,g_xren2_d[l_ac].xren022))
            DISPLAY BY NAME  g_xren2_d[l_ac].xren022, g_xren2_d[l_ac].xren022_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xren022_desc
            #add-point:ON CHANGE xren022_desc name="input.g.page2.xren022_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren023
            #add-point:BEFORE FIELD xren023 name="input.b.page2.xren023"
              
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren023
            
            #add-point:AFTER FIELD xren023 name="input.a.page2.xren023"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xren023
            #add-point:ON CHANGE xren023 name="input.g.page2.xren023"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren023_desc
            #add-point:BEFORE FIELD xren023_desc name="input.b.page2.xren023_desc"
            #自由核算項一
            LET g_xren2_d[l_ac].xren023_desc = g_xren2_d[l_ac].xren023   #20150528 add lujh
            CALL s_fin_get_glae009(g_glad.glad0171) RETURNING l_glae009
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren023_desc
            
            #add-point:AFTER FIELD xren023_desc name="input.a.page2.xren023_desc"
            #自由核算項一
            LET g_xren2_d[l_ac].xren023 = g_xren2_d[l_ac].xren023_desc   #20150528 add lujh
            #IF NOT cl_null(g_xren2_d[l_ac].xren023_desc) THEN           #20150528 mark lujh
            IF NOT cl_null(g_xren2_d[l_ac].xren023) THEN                 #20150528 add lujh
               #20150528--mark--str--lujh
               #IF (g_xren2_d[l_ac].xren023_desc != g_xren2_d_t.xren023_desc OR g_xren2_d_t.xren023_desc IS NULL) THEN
               #   LET g_xren2_d[l_ac].xren023 = g_xren2_d[l_ac].xren023_desc
               #20150528--mark--end--lujh
                  IF (g_xren2_d[l_ac].xren023 != g_xren2_d_t.xren023 OR g_xren2_d_t.xren023 IS NULL) THEN
                     CALL s_voucher_free_account_chk(g_glad.glad0171,g_xren2_d[l_ac].xren023,g_glad.glad0172) RETURNING g_errno
                     IF NOT g_sub_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = ""
                        LET g_errparam.code   = g_errno
                        LET g_errparam.popup  = TRUE
                        #160321-00016#53 --s add
                        LET g_errparam.replace[1] = 'agli041'
                        LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                        LET g_errparam.exeprog = 'agli041'
                        #160321-00016#53 --e add 
                        CALL cl_err()
                        LET g_xren2_d[l_ac].xren023 = g_xren2_d_t.xren023
                        LET g_xren2_d[l_ac].xren023_desc = s_desc_show1(g_xren2_d[l_ac].xren023,s_fin_get_accting_desc(g_glad.glad0171,g_xren2_d[l_ac].xren023))
                        DISPLAY BY NAME g_xren2_d[l_ac].xren023_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  LET g_xren2_d[l_ac].xren023_desc = s_desc_show1(g_xren2_d[l_ac].xren023,s_fin_get_accting_desc(g_glad.glad0171,g_xren2_d[l_ac].xren023))
                  DISPLAY BY NAME g_xren2_d[l_ac].xren023_desc
               #END IF   #20150528 mark lujh
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xren023_desc
            #add-point:ON CHANGE xren023_desc name="input.g.page2.xren023_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren024
            #add-point:BEFORE FIELD xren024 name="input.b.page2.xren024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren024
            
            #add-point:AFTER FIELD xren024 name="input.a.page2.xren024"
          
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xren024
            #add-point:ON CHANGE xren024 name="input.g.page2.xren024"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren024_desc
            #add-point:BEFORE FIELD xren024_desc name="input.b.page2.xren024_desc"
            LET g_xren2_d[l_ac].xren024_desc = g_xren2_d[l_ac].xren024   #20150528 add lujh
            CALL s_fin_get_glae009(g_glad.glad0181) RETURNING l_glae009
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren024_desc
            
            #add-point:AFTER FIELD xren024_desc name="input.a.page2.xren024_desc"
            #自由核算項二
            LET g_xren2_d[l_ac].xren024 = g_xren2_d[l_ac].xren024_desc   #20150528 add lujh
            #IF NOT cl_null(g_xren2_d[l_ac].xren024_desc) THEN           #20150528 mark lujh
            IF NOT cl_null(g_xren2_d[l_ac].xren024) THEN                 #20150528 add lujh
               #20150528--mark--str--lujh
               #IF (g_xren2_d[l_ac].xren024_desc != g_xren2_d_t.xren024_desc OR g_xren2_d_t.xren024_desc IS NULL) THEN
               #   LET g_xren2_d[l_ac].xren024 = g_xren2_d[l_ac].xren024_desc
               #20150528--mark--end--lujh
                  IF (g_xren2_d[l_ac].xren024 != g_xren2_d_t.xren024 OR g_xren2_d_t.xren024 IS NULL) THEN
                     CALL s_voucher_free_account_chk(g_glad.glad0181,g_xren2_d[l_ac].xren024,g_glad.glad0182) RETURNING g_errno
                     IF NOT g_sub_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = ""
                        LET g_errparam.code   = g_errno
                        LET g_errparam.popup  = TRUE
                        #160321-00016#53 --s add
                        LET g_errparam.replace[1] = 'agli041'
                        LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                        LET g_errparam.exeprog = 'agli041'
                        #160321-00016#53 --e add 
                        CALL cl_err()
                        LET g_xren2_d[l_ac].xren024 = g_xren2_d_t.xren024
                        LET g_xren2_d[l_ac].xren024_desc = s_desc_show1(g_xren2_d[l_ac].xren024,s_fin_get_accting_desc(g_glad.glad0181,g_xren2_d[l_ac].xren024))
                        DISPLAY BY NAME g_xren2_d[l_ac].xren024_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  LET g_xren2_d[l_ac].xren024_desc = s_desc_show1(g_xren2_d[l_ac].xren024,s_fin_get_accting_desc(g_glad.glad0181,g_xren2_d[l_ac].xren024))
                  DISPLAY BY NAME g_xren2_d[l_ac].xren024_desc
               #END IF   #20150528 mark lujh
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xren024_desc
            #add-point:ON CHANGE xren024_desc name="input.g.page2.xren024_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren025
            #add-point:BEFORE FIELD xren025 name="input.b.page2.xren025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren025
            
            #add-point:AFTER FIELD xren025 name="input.a.page2.xren025"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xren025
            #add-point:ON CHANGE xren025 name="input.g.page2.xren025"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren025_desc
            #add-point:BEFORE FIELD xren025_desc name="input.b.page2.xren025_desc"
            LET g_xren2_d[l_ac].xren025_desc = g_xren2_d[l_ac].xren025   #20150528 add lujh
            CALL s_fin_get_glae009(g_glad.glad0191) RETURNING l_glae009
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren025_desc
            
            #add-point:AFTER FIELD xren025_desc name="input.a.page2.xren025_desc"
            #自由核算項三
            LET g_xren2_d[l_ac].xren025 = g_xren2_d[l_ac].xren025_desc   #20150528 add lujh
            #IF NOT cl_null(g_xren2_d[l_ac].xren025_desc) THEN           #20150528 mark lujh
            IF NOT cl_null(g_xren2_d[l_ac].xren025) THEN                 #20150528 add lujh
               #20150528--mark--str--lujh
               #IF (g_xren2_d[l_ac].xren025_desc != g_xren2_d_t.xren025_desc OR g_xren2_d_t.xren025_desc IS NULL) THEN
               #   LET g_xren2_d[l_ac].xren025 = g_xren2_d[l_ac].xren025_desc
               #20150528--mark--end--lujh
                  IF (g_xren2_d[l_ac].xren025 != g_xren2_d_t.xren025 OR g_xren2_d_t.xren025 IS NULL) THEN
                     CALL s_voucher_free_account_chk(g_glad.glad0191,g_xren2_d[l_ac].xren025,g_glad.glad0192) RETURNING g_errno
                     IF NOT g_sub_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = ""
                        LET g_errparam.code   = g_errno
                        LET g_errparam.popup  = TRUE
                        #160321-00016#53 --s add
                        LET g_errparam.replace[1] = 'agli041'
                        LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                        LET g_errparam.exeprog = 'agli041'
                        #160321-00016#53 --e add 
                        CALL cl_err()
                        LET g_xren2_d[l_ac].xren025 = g_xren2_d_t.xren025
                        LET g_xren2_d[l_ac].xren025_desc = s_desc_show1(g_xren2_d[l_ac].xren025,s_fin_get_accting_desc(g_glad.glad0191,g_xren2_d[l_ac].xren025))
                        DISPLAY BY NAME g_xren2_d[l_ac].xren025_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  LET g_xren2_d[l_ac].xren025_desc = s_desc_show1(g_xren2_d[l_ac].xren025,s_fin_get_accting_desc(g_glad.glad0191,g_xren2_d[l_ac].xren025))
                  DISPLAY BY NAME g_xren2_d[l_ac].xren025_desc
               #END IF   #20150528 mark lujh
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xren025_desc
            #add-point:ON CHANGE xren025_desc name="input.g.page2.xren025_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren026
            #add-point:BEFORE FIELD xren026 name="input.b.page2.xren026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren026
            
            #add-point:AFTER FIELD xren026 name="input.a.page2.xren026"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xren026
            #add-point:ON CHANGE xren026 name="input.g.page2.xren026"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren026_desc
            #add-point:BEFORE FIELD xren026_desc name="input.b.page2.xren026_desc"
            LET g_xren2_d[l_ac].xren026_desc = g_xren2_d[l_ac].xren026   #20150528 add lujh
            CALL s_fin_get_glae009(g_glad.glad0201) RETURNING l_glae009
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren026_desc
            
            #add-point:AFTER FIELD xren026_desc name="input.a.page2.xren026_desc"
            #自由核算項四
            LET g_xren2_d[l_ac].xren026 = g_xren2_d[l_ac].xren026_desc   #20150528 add lujh
            #IF NOT cl_null(g_xren2_d[l_ac].xren026_desc) THEN           #20150528 mark lujh
            IF NOT cl_null(g_xren2_d[l_ac].xren026) THEN                 #20150528 add lujh
               #20150528--mark--str--lujh
               #IF (g_xren2_d[l_ac].xren026_desc != g_xren2_d_t.xren026_desc OR g_xren2_d_t.xren026_desc IS NULL) THEN
               #   LET g_xren2_d[l_ac].xren026 = g_xren2_d[l_ac].xren026_desc
               #20150528--mark--end--lujh
                  IF (g_xren2_d[l_ac].xren026 != g_xren2_d_t.xren026 OR g_xren2_d_t.xren026 IS NULL) THEN
                     CALL s_voucher_free_account_chk(g_glad.glad0201,g_xren2_d[l_ac].xren026,g_glad.glad0202) RETURNING g_errno
                     IF NOT g_sub_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = ""
                        LET g_errparam.code   = g_errno
                        LET g_errparam.popup  = TRUE
                        #160321-00016#53 --s add
                        LET g_errparam.replace[1] = 'agli041'
                        LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                        LET g_errparam.exeprog = 'agli041'
                        #160321-00016#53 --e add 
                        CALL cl_err()
                        LET g_xren2_d[l_ac].xren026 = g_xren2_d_t.xren026
                        LET g_xren2_d[l_ac].xren026_desc = s_desc_show1(g_xren2_d[l_ac].xren026,s_fin_get_accting_desc(g_glad.glad0201,g_xren2_d[l_ac].xren026))
                        DISPLAY BY NAME g_xren2_d[l_ac].xren026_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  LET g_xren2_d[l_ac].xren026_desc = s_desc_show1(g_xren2_d[l_ac].xren026,s_fin_get_accting_desc(g_glad.glad0201,g_xren2_d[l_ac].xren026))
                  DISPLAY BY NAME g_xren2_d[l_ac].xren026_desc
               #END IF   #20150528 mark lujh
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xren026_desc
            #add-point:ON CHANGE xren026_desc name="input.g.page2.xren026_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren027
            #add-point:BEFORE FIELD xren027 name="input.b.page2.xren027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren027
            
            #add-point:AFTER FIELD xren027 name="input.a.page2.xren027"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xren027
            #add-point:ON CHANGE xren027 name="input.g.page2.xren027"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren027_desc
            #add-point:BEFORE FIELD xren027_desc name="input.b.page2.xren027_desc"
            LET g_xren2_d[l_ac].xren027_desc = g_xren2_d[l_ac].xren027   #20150528 add lujh
            CALL s_fin_get_glae009(g_glad.glad0211) RETURNING l_glae009
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren027_desc
            
            #add-point:AFTER FIELD xren027_desc name="input.a.page2.xren027_desc"
            #自由核算項五
            LET g_xren2_d[l_ac].xren027 = g_xren2_d[l_ac].xren027_desc   #20150528 add lujh
            #IF NOT cl_null(g_xren2_d[l_ac].xren027_desc) THEN           #20150528 mark lujh
            IF NOT cl_null(g_xren2_d[l_ac].xren027) THEN                 #20150528 add lujh
               #20150528--mark--str--lujh
               #IF (g_xren2_d[l_ac].xren027_desc != g_xren2_d_t.xren027_desc OR g_xren2_d_t.xren027_desc IS NULL) THEN
               #   LET g_xren2_d[l_ac].xren027 = g_xren2_d[l_ac].xren027_desc
               #20150528--mark--end--lujh
                  IF (g_xren2_d[l_ac].xren027 != g_xren2_d_t.xren027 OR g_xren2_d_t.xren027 IS NULL) THEN
                     CALL s_voucher_free_account_chk(g_glad.glad0211,g_xren2_d[l_ac].xren027,g_glad.glad0212) RETURNING g_errno
                     IF NOT g_sub_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = ""
                        LET g_errparam.code   = g_errno
                        LET g_errparam.popup  = TRUE
                        #160321-00016#53 --s add
                        LET g_errparam.replace[1] = 'agli041'
                        LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                        LET g_errparam.exeprog = 'agli041'
                        #160321-00016#53 --e add 
                        CALL cl_err()
                        LET g_xren2_d[l_ac].xren027 = g_xren2_d_t.xren027
                        LET g_xren2_d[l_ac].xren027_desc = s_desc_show1(g_xren2_d[l_ac].xren027,s_fin_get_accting_desc(g_glad.glad0211,g_xren2_d[l_ac].xren027))
                        DISPLAY BY NAME g_xren2_d[l_ac].xren027_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  LET g_xren2_d[l_ac].xren027_desc = s_desc_show1(g_xren2_d[l_ac].xren027,s_fin_get_accting_desc(g_glad.glad0211,g_xren2_d[l_ac].xren027))
                  DISPLAY BY NAME g_xren2_d[l_ac].xren027_desc
               #END IF   #20150528 mark lujh
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xren027_desc
            #add-point:ON CHANGE xren027_desc name="input.g.page2.xren027_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren028
            #add-point:BEFORE FIELD xren028 name="input.b.page2.xren028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren028
            
            #add-point:AFTER FIELD xren028 name="input.a.page2.xren028"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xren028
            #add-point:ON CHANGE xren028 name="input.g.page2.xren028"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren028_desc
            #add-point:BEFORE FIELD xren028_desc name="input.b.page2.xren028_desc"
            LET g_xren2_d[l_ac].xren028_desc = g_xren2_d[l_ac].xren028   #20150528 add lujh
            CALL s_fin_get_glae009(g_glad.glad0221) RETURNING l_glae009
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren028_desc
            
            #add-point:AFTER FIELD xren028_desc name="input.a.page2.xren028_desc"
            #自由核算項六
            LET g_xren2_d[l_ac].xren028 = g_xren2_d[l_ac].xren028_desc   #20150528 add lujh
            #IF NOT cl_null(g_xren2_d[l_ac].xren028_desc) THEN           #20150528 mark lujh
            IF NOT cl_null(g_xren2_d[l_ac].xren028) THEN                 #20150528 add lujh
               #20150528--mark--str--lujh
               #IF (g_xren2_d[l_ac].xren028_desc != g_xren2_d_t.xren028_desc OR g_xren2_d_t.xren028_desc IS NULL) THEN
               #   LET g_xren2_d[l_ac].xren028 = g_xren2_d[l_ac].xren028_desc
               #20150528--mark--end--lujh
                  IF (g_xren2_d[l_ac].xren028 != g_xren2_d_t.xren028 OR g_xren2_d_t.xren028 IS NULL) THEN
                     CALL s_voucher_free_account_chk(g_glad.glad0221,g_xren2_d[l_ac].xren028,g_glad.glad0222) RETURNING g_errno
                     IF NOT g_sub_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = ""
                        LET g_errparam.code   = g_errno
                        LET g_errparam.popup  = TRUE
                        #160321-00016#53 --s add
                        LET g_errparam.replace[1] = 'agli041'
                        LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                        LET g_errparam.exeprog = 'agli041'
                        #160321-00016#53 --e add 
                        CALL cl_err()
                        LET g_xren2_d[l_ac].xren028 = g_xren2_d_t.xren028
                        LET g_xren2_d[l_ac].xren028_desc = s_desc_show1(g_xren2_d[l_ac].xren028,s_fin_get_accting_desc(g_glad.glad0221,g_xren2_d[l_ac].xren028))
                        DISPLAY BY NAME g_xren2_d[l_ac].xren028_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  LET g_xren2_d[l_ac].xren028_desc = s_desc_show1(g_xren2_d[l_ac].xren028,s_fin_get_accting_desc(g_glad.glad0221,g_xren2_d[l_ac].xren028))
                  DISPLAY BY NAME g_xren2_d[l_ac].xren028_desc
               #END IF   #20150528 mark lujh
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xren028_desc
            #add-point:ON CHANGE xren028_desc name="input.g.page2.xren028_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren029
            #add-point:BEFORE FIELD xren029 name="input.b.page2.xren029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren029
            
            #add-point:AFTER FIELD xren029 name="input.a.page2.xren029"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xren029
            #add-point:ON CHANGE xren029 name="input.g.page2.xren029"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren029_desc
            #add-point:BEFORE FIELD xren029_desc name="input.b.page2.xren029_desc"
            LET g_xren2_d[l_ac].xren029_desc = g_xren2_d[l_ac].xren029   #20150528 add lujh
            CALL s_fin_get_glae009(g_glad.glad0231) RETURNING l_glae009
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren029_desc
            
            #add-point:AFTER FIELD xren029_desc name="input.a.page2.xren029_desc"
            #自由核算項七
            LET g_xren2_d[l_ac].xren029 = g_xren2_d[l_ac].xren029_desc   #20150528 add lujh
            #IF NOT cl_null(g_xren2_d[l_ac].xren029_desc) THEN           #20150528 mark lujh
            IF NOT cl_null(g_xren2_d[l_ac].xren029) THEN                 #20150528 add lujh
               #20150528--mark--str--lujh
               #IF (g_xren2_d[l_ac].xren029_desc != g_xren2_d_t.xren029_desc OR g_xren2_d_t.xren029_desc IS NULL) THEN
               #   LET g_xren2_d[l_ac].xren029 = g_xren2_d[l_ac].xren029_desc
               #20150528--mark--end--lujh
                  IF (g_xren2_d[l_ac].xren029 != g_xren2_d_t.xren029 OR g_xren2_d_t.xren029 IS NULL) THEN
                     CALL s_voucher_free_account_chk(g_glad.glad0231,g_xren2_d[l_ac].xren029,g_glad.glad0232) RETURNING g_errno
                     IF NOT g_sub_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = ""
                        LET g_errparam.code   = g_errno
                        LET g_errparam.popup  = TRUE
                        #160321-00016#53 --s add
                        LET g_errparam.replace[1] = 'agli041'
                        LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                        LET g_errparam.exeprog = 'agli041'
                        #160321-00016#53 --e add 
                        CALL cl_err()
                        LET g_xren2_d[l_ac].xren029 = g_xren2_d_t.xren029
                        LET g_xren2_d[l_ac].xren029_desc = s_desc_show1(g_xren2_d[l_ac].xren029,s_fin_get_accting_desc(g_glad.glad0231,g_xren2_d[l_ac].xren029))
                        DISPLAY BY NAME g_xren2_d[l_ac].xren029_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  LET g_xren2_d[l_ac].xren029_desc = s_desc_show1(g_xren2_d[l_ac].xren029,s_fin_get_accting_desc(g_glad.glad0231,g_xren2_d[l_ac].xren029))
                  DISPLAY BY NAME g_xren2_d[l_ac].xren029_desc
               #END IF   #20150528 mark lujh
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xren029_desc
            #add-point:ON CHANGE xren029_desc name="input.g.page2.xren029_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren030
            #add-point:BEFORE FIELD xren030 name="input.b.page2.xren030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren030
            
            #add-point:AFTER FIELD xren030 name="input.a.page2.xren030"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xren030
            #add-point:ON CHANGE xren030 name="input.g.page2.xren030"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren030_desc
            #add-point:BEFORE FIELD xren030_desc name="input.b.page2.xren030_desc"
            LET g_xren2_d[l_ac].xren030_desc = g_xren2_d[l_ac].xren030   #20150528 add lujh
            CALL s_fin_get_glae009(g_glad.glad0241) RETURNING l_glae009
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren030_desc
            
            #add-point:AFTER FIELD xren030_desc name="input.a.page2.xren030_desc"
            #自由核算項八
            LET g_xren2_d[l_ac].xren030 = g_xren2_d[l_ac].xren030_desc   #20150528 add lujh
            #IF NOT cl_null(g_xren2_d[l_ac].xren030_desc) THEN           #20150528 mark lujh
            IF NOT cl_null(g_xren2_d[l_ac].xren030) THEN                 #20150528 add lujh
               #20150528--mark--str--lujh
               #IF (g_xren2_d[l_ac].xren030_desc != g_xren2_d_t.xren030_desc OR g_xren2_d_t.xren030_desc IS NULL) THEN
               #   LET g_xren2_d[l_ac].xren030 = g_xren2_d[l_ac].xren030_desc
               #20150528--mark--end--lujh
                  IF (g_xren2_d[l_ac].xren030 != g_xren2_d_t.xren030 OR g_xren2_d_t.xren030 IS NULL) THEN
                     CALL s_voucher_free_account_chk(g_glad.glad0241,g_xren2_d[l_ac].xren030,g_glad.glad0242) RETURNING g_errno
                     IF NOT g_sub_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = ""
                        LET g_errparam.code   = g_errno
                        LET g_errparam.popup  = TRUE
                        #160321-00016#53 --s add
                        LET g_errparam.replace[1] = 'agli041'
                        LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                        LET g_errparam.exeprog = 'agli041'
                        #160321-00016#53 --e add 
                        CALL cl_err()
                        LET g_xren2_d[l_ac].xren030 = g_xren2_d_t.xren030
                        LET g_xren2_d[l_ac].xren030_desc = s_desc_show1(g_xren2_d[l_ac].xren030,s_fin_get_accting_desc(g_glad.glad0241,g_xren2_d[l_ac].xren030))
                        DISPLAY BY NAME g_xren2_d[l_ac].xren030_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  LET g_xren2_d[l_ac].xren030_desc = s_desc_show1(g_xren2_d[l_ac].xren030,s_fin_get_accting_desc(g_glad.glad0241,g_xren2_d[l_ac].xren030))
                  DISPLAY BY NAME g_xren2_d[l_ac].xren030_desc
               #END IF   #20150528 mark lujh
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xren030_desc
            #add-point:ON CHANGE xren030_desc name="input.g.page2.xren030_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren031
            #add-point:BEFORE FIELD xren031 name="input.b.page2.xren031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren031
            
            #add-point:AFTER FIELD xren031 name="input.a.page2.xren031"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xren031
            #add-point:ON CHANGE xren031 name="input.g.page2.xren031"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren031_desc
            #add-point:BEFORE FIELD xren031_desc name="input.b.page2.xren031_desc"
            LET g_xren2_d[l_ac].xren031_desc = g_xren2_d[l_ac].xren031   #20150528 add lujh
            CALL s_fin_get_glae009(g_glad.glad0251) RETURNING l_glae009
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren031_desc
            
            #add-point:AFTER FIELD xren031_desc name="input.a.page2.xren031_desc"
            #自由核算項九
            LET g_xren2_d[l_ac].xren031 = g_xren2_d[l_ac].xren031_desc   #20150528 add lujh
            #IF NOT cl_null(g_xren2_d[l_ac].xren031_desc) THEN           #20150528 mark lujh
            IF NOT cl_null(g_xren2_d[l_ac].xren031) THEN                 #20150528 add lujh
               #2150528--mark--str--lujh
               #IF (g_xren2_d[l_ac].xren031_desc != g_xren2_d_t.xren031_desc OR g_xren2_d_t.xren031_desc IS NULL) THEN
               #   LET g_xren2_d[l_ac].xren031 = g_xren2_d[l_ac].xren031_desc
               #2150528--mark--end--lujh
                  IF (g_xren2_d[l_ac].xren031 != g_xren2_d_t.xren031 OR g_xren2_d_t.xren031 IS NULL) THEN
                     CALL s_voucher_free_account_chk(g_glad.glad0251,g_xren2_d[l_ac].xren031,g_glad.glad0252) RETURNING g_errno
                     IF NOT g_sub_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = ""
                        LET g_errparam.code   = g_errno
                        LET g_errparam.popup  = TRUE
                        #160321-00016#53 --s add
                        LET g_errparam.replace[1] = 'agli041'
                        LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                        LET g_errparam.exeprog = 'agli041'
                        #160321-00016#53 --e add 
                        CALL cl_err()
                        LET g_xren2_d[l_ac].xren031 = g_xren2_d_t.xren031
                        LET g_xren2_d[l_ac].xren031_desc = s_desc_show1(g_xren2_d[l_ac].xren031,s_fin_get_accting_desc(g_glad.glad0251,g_xren2_d[l_ac].xren031))
                        DISPLAY BY NAME g_xren2_d[l_ac].xren031_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  LET g_xren2_d[l_ac].xren031_desc = s_desc_show1(g_xren2_d[l_ac].xren031,s_fin_get_accting_desc(g_glad.glad0251,g_xren2_d[l_ac].xren031))
                  DISPLAY BY NAME g_xren2_d[l_ac].xren031_desc
               #END IF   #20150528 mark lujh
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xren031_desc
            #add-point:ON CHANGE xren031_desc name="input.g.page2.xren031_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren032
            #add-point:BEFORE FIELD xren032 name="input.b.page2.xren032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren032
            
            #add-point:AFTER FIELD xren032 name="input.a.page2.xren032"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xren032
            #add-point:ON CHANGE xren032 name="input.g.page2.xren032"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xren032_desc
            #add-point:BEFORE FIELD xren032_desc name="input.b.page2.xren032_desc"
            LET g_xren2_d[l_ac].xren032_desc = g_xren2_d[l_ac].xren032   #20150528 add lujh
            CALL s_fin_get_glae009(g_glad.glad0261) RETURNING l_glae009
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xren032_desc
            
            #add-point:AFTER FIELD xren032_desc name="input.a.page2.xren032_desc"
            #自由核算項十
            LET g_xren2_d[l_ac].xren032 = g_xren2_d[l_ac].xren032_desc   #20150528 add lujh
            #IF NOT cl_null(g_xren2_d[l_ac].xren032_desc) THEN           #20150528 mark lujh
            IF NOT cl_null(g_xren2_d[l_ac].xren032) THEN                 #20150528 add lujh
               #20150528--mark--str--lujh
               #IF (g_xren2_d[l_ac].xren032_desc != g_xren2_d_t.xren032_desc OR g_xren2_d_t.xren032_desc IS NULL) THEN
               #   LET g_xren2_d[l_ac].xren032 = g_xren2_d[l_ac].xren032_desc
               #20150528--mark--end--lujh
                  IF (g_xren2_d[l_ac].xren032 != g_xren2_d_t.xren032 OR g_xren2_d_t.xren032 IS NULL) THEN
                     CALL s_voucher_free_account_chk(g_glad.glad0261,g_xren2_d[l_ac].xren032,g_glad.glad0262) RETURNING g_errno
                     IF NOT g_sub_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = ""
                        LET g_errparam.code   = g_errno
                        LET g_errparam.popup  = TRUE
                        #160321-00016#53 --s add
                        LET g_errparam.replace[1] = 'agli041'
                        LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                        LET g_errparam.exeprog = 'agli041'
                        #160321-00016#53 --e add 
                        CALL cl_err()
                        LET g_xren2_d[l_ac].xren032 = g_xren2_d_t.xren032
                        LET g_xren2_d[l_ac].xren032_desc = s_desc_show1(g_xren2_d[l_ac].xren032,s_fin_get_accting_desc(g_glad.glad0261,g_xren2_d[l_ac].xren032))
                        DISPLAY BY NAME g_xren2_d[l_ac].xren032_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  LET g_xren2_d[l_ac].xren032_desc = s_desc_show1(g_xren2_d[l_ac].xren032,s_fin_get_accting_desc(g_glad.glad0261,g_xren2_d[l_ac].xren032))
                  DISPLAY BY NAME g_xren2_d[l_ac].xren032_desc
               #END IF   #20150528 mark lujh
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xren032_desc
            #add-point:ON CHANGE xren032_desc name="input.g.page2.xren032_desc"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page2.xren0052
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren0052
            #add-point:ON ACTION controlp INFIELD xren0052 name="input.c.page2.xren0052"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xren2_d[l_ac].xren0052             #給予default值
            LET g_qryparam.default2 = "" #g_xren2_d[l_ac].xrca001 #账款单性质
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_xrcadocno()                                #呼叫開窗

            LET g_xren2_d[l_ac].xren0052 = g_qryparam.return1              
            #LET g_xren2_d[l_ac].xrca001 = g_qryparam.return2 
            DISPLAY g_xren2_d[l_ac].xren0052 TO xren0052              #
            #DISPLAY g_xren2_d[l_ac].xrca001 TO xrca001 #账款单性质
            NEXT FIELD xren0052                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.xren0062
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren0062
            #add-point:ON ACTION controlp INFIELD xren0062 name="input.c.page2.xren0062"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xren0072
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren0072
            #add-point:ON ACTION controlp INFIELD xren0072 name="input.c.page2.xren0072"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xren033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren033
            #add-point:ON ACTION controlp INFIELD xren033 name="input.c.page2.xren033"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xren043
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren043
            #add-point:ON ACTION controlp INFIELD xren043 name="input.c.page2.xren043"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xren043_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren043_desc
            #add-point:ON ACTION controlp INFIELD xren043_desc name="input.c.page2.xren043_desc"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xren2_d[l_ac].xren043
            LET g_qryparam.where = " glac003 <>'1' AND glac006 = '1' ",
                                   " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 AND gladld='",g_xrem_m.xremld,"' AND gladent=",g_enterprise,
                                   " AND gladstus = 'Y' )" #150916-00015#1 add  #glac001(會計科目參照表)/glac003(科目類型)
            IF NOT cl_null(g_glaa_t.glaa004) THEN
               LET g_qryparam.where = g_qryparam.where," AND glac001 = '",g_glaa_t.glaa004,"' ",
                                   " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 AND gladld='",g_xrem_m.xremld,"' AND gladent=",g_enterprise,
                                   " AND gladstus = 'Y' )" #150916-00015#1 add
            END IF            
            CALL aglt310_04()
            LET g_xren2_d[l_ac].xren043      = g_qryparam.return1
            LET g_xren2_d[l_ac].xren043_desc = g_xren2_d[l_ac].xren043
            DISPLAY BY NAME g_xren2_d[l_ac].xren043,g_xren2_d[l_ac].xren043_desc
            NEXT FIELD xren043_desc
            #END add-point
 
 
         #Ctrlp:input.c.page2.xren019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren019
            #add-point:ON ACTION controlp INFIELD xren019 name="input.c.page2.xren019"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xren019_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren019_desc
            #add-point:ON ACTION controlp INFIELD xren019_desc name="input.c.page2.xren019_desc"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xren2_d[l_ac].xren019
            LET g_qryparam.where = " glac003 <>'1' AND glac006 = '1' ",
                                   " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 AND gladld='",g_xrem_m.xremld,"' AND gladent=",g_enterprise,
                                   " AND gladstus = 'Y' )" #150916-00015#1 add  #glac001(會計科目參照表)/glac003(科目類型)
            IF NOT cl_null(g_glaa_t.glaa004) THEN
               LET g_qryparam.where = g_qryparam.where," AND glac001 = '",g_glaa_t.glaa004,"' ",
                                   " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 AND gladld='",g_xrem_m.xremld,"' AND gladent=",g_enterprise,
                                   " AND gladstus = 'Y' )" #150916-00015#1 add
            END IF   
            CALL aglt310_04()
            LET g_xren2_d[l_ac].xren019      = g_qryparam.return1
            LET g_xren2_d[l_ac].xren019_desc = g_xren2_d[l_ac].xren019
            DISPLAY BY NAME g_xren2_d[l_ac].xren019,g_xren2_d[l_ac].xren019_desc
            NEXT FIELD xren019_desc
            #END add-point
 
 
         #Ctrlp:input.c.page2.xren042
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren042
            #add-point:ON ACTION controlp INFIELD xren042 name="input.c.page2.xren042"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xren042_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren042_desc
            #add-point:ON ACTION controlp INFIELD xren042_desc name="input.c.page2.xren042_desc"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xren2_d[l_ac].xren042
            LET g_qryparam.where = " glac003 <>'1' AND glac006 = '1' ",
                                   " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 AND gladld='",g_xrem_m.xremld,"' AND gladent=",g_enterprise,
                                   " AND gladstus = 'Y' )" #150916-00015#1 add  #glac001(會計科目參照表)/glac003(科目類型)
            IF NOT cl_null(g_glaa_t.glaa004) THEN
               LET g_qryparam.where = g_qryparam.where," AND glac001 = '",g_glaa_t.glaa004,"' ",
                                   " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 AND gladld='",g_xrem_m.xremld,"' AND gladent=",g_enterprise,
                                   " AND gladstus = 'Y' )" #150916-00015#1 add
            END IF   
            CALL aglt310_04()
            LET g_xren2_d[l_ac].xren042      = g_qryparam.return1
            LET g_xren2_d[l_ac].xren042_desc = g_xren2_d[l_ac].xren042
            DISPLAY BY NAME g_xren2_d[l_ac].xren042,g_xren2_d[l_ac].xren042_desc
            NEXT FIELD xren042_desc
            #END add-point
 
 
         #Ctrlp:input.c.page2.xren016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren016
            #add-point:ON ACTION controlp INFIELD xren016 name="input.c.page2.xren016"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xren016_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren016_desc
            #add-point:ON ACTION controlp INFIELD xren016_desc name="input.c.page2.xren016_desc"
            #業務人員
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xren2_d[l_ac].xren016
            CALL q_ooag001()
            LET g_xren2_d[l_ac].xren016 = g_qryparam.return1
            LET g_xren2_d[l_ac].xren016_desc = g_qryparam.return1
            DISPLAY BY NAME  g_xren2_d[l_ac].xren016,g_xren2_d[l_ac].xren016_desc
            NEXT FIELD xren016_desc
            #END add-point
 
 
         #Ctrlp:input.c.page2.xren011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren011
            #add-point:ON ACTION controlp INFIELD xren011 name="input.c.page2.xren011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xren011_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren011_desc
            #add-point:ON ACTION controlp INFIELD xren011_desc name="input.c.page2.xren011_desc"
            #業務部門
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xren2_d[l_ac].xren011
            LET g_qryparam.arg1 = g_xrem_m.xremdocdt
            CALL q_ooeg001_4()
            LET g_xren2_d[l_ac].xren011      = g_qryparam.return1
            LET g_xren2_d[l_ac].xren011_desc = g_xren2_d[l_ac].xren011
            DISPLAY BY NAME g_xren2_d[l_ac].xren011,g_xren2_d[l_ac].xren011_desc
            NEXT FIELD xren011_desc
            #END add-point
 
 
         #Ctrlp:input.c.page2.xren012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren012
            #add-point:ON ACTION controlp INFIELD xren012 name="input.c.page2.xren012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xren012_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren012_desc
            #add-point:ON ACTION controlp INFIELD xren012_desc name="input.c.page2.xren012_desc"
            #責任中心
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xren2_d[l_ac].xren012
            CALL q_ooeg001_2()
            LET g_xren2_d[l_ac].xren012      = g_qryparam.return1
            LET g_xren2_d[l_ac].xren012_desc = g_xren2_d[l_ac].xren012 
            DISPLAY BY NAME g_xren2_d[l_ac].xren012,g_xren2_d[l_ac].xren012_desc
            NEXT FIELD xren012_desc
            #END add-point
 
 
         #Ctrlp:input.c.page2.xren013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren013
            #add-point:ON ACTION controlp INFIELD xren013 name="input.c.page2.xren013"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xren013_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren013_desc
            #add-point:ON ACTION controlp INFIELD xren013_desc name="input.c.page2.xren013_desc"
            #區域
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xren2_d[l_ac].xren013
            LET g_qryparam.arg1 = '287'
            CALL q_oocq002()
            LET g_xren2_d[l_ac].xren013      = g_qryparam.return1
            LET g_xren2_d[l_ac].xren013_desc = g_qryparam.return1
            DISPLAY BY NAME  g_xren2_d[l_ac].xren013,g_xren2_d[l_ac].xren013_desc
            NEXT FIELD xren013_desc
            #END add-point
 
 
         #Ctrlp:input.c.page2.xren014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren014
            #add-point:ON ACTION controlp INFIELD xren014 name="input.c.page2.xren014"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xren014_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren014_desc
            #add-point:ON ACTION controlp INFIELD xren014_desc name="input.c.page2.xren014_desc"
            #客群
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xren2_d[l_ac].xren014
            LET g_qryparam.arg1 = '281'
            CALL q_oocq002()
            LET g_xren2_d[l_ac].xren014      = g_qryparam.return1
            LET g_xren2_d[l_ac].xren014_desc = g_qryparam.return1
            DISPLAY BY NAME  g_xren2_d[l_ac].xren014,g_xren2_d[l_ac].xren014_desc
            NEXT FIELD xren014_desc
            #END add-point
 
 
         #Ctrlp:input.c.page2.xren015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren015
            #add-point:ON ACTION controlp INFIELD xren015 name="input.c.page2.xren015"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xren015_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren015_desc
            #add-point:ON ACTION controlp INFIELD xren015_desc name="input.c.page2.xren015_desc"
            #產品類別
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xren2_d[l_ac].xren015
            CALL q_rtax001_1()
            LET g_xren2_d[l_ac].xren015 = g_qryparam.return1
            LET g_xren2_d[l_ac].xren015_desc = g_qryparam.return1
            DISPLAY BY NAME  g_xren2_d[l_ac].xren015,g_xren2_d[l_ac].xren015_desc
            NEXT FIELD xren015_desc
            #END add-point
 
 
         #Ctrlp:input.c.page2.xren017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren017
            #add-point:ON ACTION controlp INFIELD xren017 name="input.c.page2.xren017"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xren017_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren017_desc
            #add-point:ON ACTION controlp INFIELD xren017_desc name="input.c.page2.xren017_desc"
             #專案代號
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xren2_d[l_ac].xren017
            CALL q_pjba001()
            LET g_xren2_d[l_ac].xren017      = g_qryparam.return1
            LET g_xren2_d[l_ac].xren017_desc = g_xren2_d[l_ac].xren017
            DISPLAY BY NAME g_xren2_d[l_ac].xren017,g_xren2_d[l_ac].xren017_desc
            NEXT FIELD xren017_desc
            #END add-point
 
 
         #Ctrlp:input.c.page2.xren018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren018
            #add-point:ON ACTION controlp INFIELD xren018 name="input.c.page2.xren018"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xren018_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren018_desc
            #add-point:ON ACTION controlp INFIELD xren018_desc name="input.c.page2.xren018_desc"
            #此段落由子樣板a07產生            
            #開窗i段
            #20150528--add--str--lujh
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xren2_d[l_ac].xren018             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_xren2_d[l_ac].xren017

            
            CALL q_pjbb002_2()                                #呼叫開窗

            LET g_xren2_d[l_ac].xren018 = g_qryparam.return1              
            CALL axrt930_xren018_desc(g_xren2_d[l_ac].xren017,g_xren2_d[l_ac].xren018) RETURNING g_xren2_d[l_ac].xren018_desc
            LET g_xren2_d[l_ac].xren018_desc = g_xren2_d[l_ac].xren018 CLIPPED,g_xren2_d[l_ac].xren018_desc
            DISPLAY g_xren2_d[l_ac].xren018_desc TO xren018_desc              #

            NEXT FIELD xren018_desc                          #返回原欄位
            #20150528--add--end--lujh
            #END add-point
 
 
         #Ctrlp:input.c.page2.xren020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren020
            #add-point:ON ACTION controlp INFIELD xren020 name="input.c.page2.xren020"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xren021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren021
            #add-point:ON ACTION controlp INFIELD xren021 name="input.c.page2.xren021"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xren021_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren021_desc
            #add-point:ON ACTION controlp INFIELD xren021_desc name="input.c.page2.xren021_desc"
            #渠道
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xren2_d[l_ac].xren021
            LET g_qryparam.arg1 = 1
            CALL q_oojd001_1()
            LET g_xren2_d[l_ac].xren021      = g_qryparam.return1
            LET g_xren2_d[l_ac].xren021_desc = g_xren2_d[l_ac].xren021
            DISPLAY BY NAME g_xren2_d[l_ac].xren021,g_xren2_d[l_ac].xren021_desc
            NEXT FIELD xren021_desc
            #END add-point
 
 
         #Ctrlp:input.c.page2.xren022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren022
            #add-point:ON ACTION controlp INFIELD xren022 name="input.c.page2.xren022"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xren022_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren022_desc
            #add-point:ON ACTION controlp INFIELD xren022_desc name="input.c.page2.xren022_desc"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xren2_d[l_ac].xren022
            LET g_qryparam.arg1 = 2002
            CALL q_oocq002()
            LET g_xren2_d[l_ac].xren022        = g_qryparam.return1
            LET g_xren2_d[l_ac].xren022_desc   = g_xren2_d[l_ac].xren022
            DISPLAY BY NAME g_xren2_d[l_ac].xren022,g_xren2_d[l_ac].xren022_desc
            NEXT FIELD xren022_desc
            #END add-point
 
 
         #Ctrlp:input.c.page2.xren023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren023
            #add-point:ON ACTION controlp INFIELD xren023 name="input.c.page2.xren023"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xren023_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren023_desc
            #add-point:ON ACTION controlp INFIELD xren023_desc name="input.c.page2.xren023_desc"
           #自由核算項一
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_xren2_d[l_ac].xren023

               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0171,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_xren2_d[l_ac].xren023      = g_qryparam.return1
               LET g_xren2_d[l_ac].xren023_desc = g_qryparam.return1
               DISPLAY BY NAME g_xren2_d[l_ac].xren023,g_xren2_d[l_ac].xren023_desc
               NEXT FIELD xren023_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page2.xren024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren024
            #add-point:ON ACTION controlp INFIELD xren024 name="input.c.page2.xren024"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xren024_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren024_desc
            #add-point:ON ACTION controlp INFIELD xren024_desc name="input.c.page2.xren024_desc"
            #自由核算項二
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_xren2_d[l_ac].xren024 

               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0181,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_xren2_d[l_ac].xren024       = g_qryparam.return1
               LET g_xren2_d[l_ac].xren024_desc  = g_qryparam.return1
               DISPLAY BY NAME g_xren2_d[l_ac].xren024,g_xren2_d[l_ac].xren024_desc
               NEXT FIELD xren024_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page2.xren025
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren025
            #add-point:ON ACTION controlp INFIELD xren025 name="input.c.page2.xren025"
            #自由核算項四
     
            #END add-point
 
 
         #Ctrlp:input.c.page2.xren025_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren025_desc
            #add-point:ON ACTION controlp INFIELD xren025_desc name="input.c.page2.xren025_desc"
            #自由核算項三
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_xren2_d[l_ac].xren025

               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0191,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_xren2_d[l_ac].xren025      = g_qryparam.return1
               LET g_xren2_d[l_ac].xren025_desc = g_qryparam.return1
               DISPLAY BY NAME g_xren2_d[l_ac].xren025,g_xren2_d[l_ac].xren025_desc
               NEXT FIELD xren025_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page2.xren026
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren026
            #add-point:ON ACTION controlp INFIELD xren026 name="input.c.page2.xren026"
            
        
            #END add-point
 
 
         #Ctrlp:input.c.page2.xren026_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren026_desc
            #add-point:ON ACTION controlp INFIELD xren026_desc name="input.c.page2.xren026_desc"
            #自由核算項四
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 =  g_xren2_d[l_ac].xren026  

               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0201,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_xren2_d[l_ac].xren026      = g_qryparam.return1
               LET g_xren2_d[l_ac].xren026_desc = g_qryparam.return1
               DISPLAY BY NAME g_xren2_d[l_ac].xren026,g_xren2_d[l_ac].xren026_desc
               NEXT FIELD xren026_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page2.xren027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren027
            #add-point:ON ACTION controlp INFIELD xren027 name="input.c.page2.xren027"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xren027_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren027_desc
            #add-point:ON ACTION controlp INFIELD xren027_desc name="input.c.page2.xren027_desc"
            #自由核算項五
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_xren2_d[l_ac].xren027 

               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0211,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_xren2_d[l_ac].xren027      = g_qryparam.return1
               LET g_xren2_d[l_ac].xren027_desc = g_qryparam.return1
               DISPLAY BY NAME g_xren2_d[l_ac].xren027,g_xren2_d[l_ac].xren027_desc
               NEXT FIELD xren027_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page2.xren028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren028
            #add-point:ON ACTION controlp INFIELD xren028 name="input.c.page2.xren028"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xren028_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren028_desc
            #add-point:ON ACTION controlp INFIELD xren028_desc name="input.c.page2.xren028_desc"
            #自由核算項六
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_xren2_d[l_ac].xren028

               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0221,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_xren2_d[l_ac].xren028      = g_qryparam.return1
               LET g_xren2_d[l_ac].xren028_desc = g_qryparam.return1
               DISPLAY BY NAME g_xren2_d[l_ac].xren028,g_xren2_d[l_ac].xren028_desc
               NEXT FIELD xren028_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page2.xren029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren029
            #add-point:ON ACTION controlp INFIELD xren029 name="input.c.page2.xren029"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xren029_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren029_desc
            #add-point:ON ACTION controlp INFIELD xren029_desc name="input.c.page2.xren029_desc"
            #自由核算項七
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_xren2_d[l_ac].xren029

               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0231,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_xren2_d[l_ac].xren029      = g_qryparam.return1
               LET g_xren2_d[l_ac].xren029_desc = g_qryparam.return1
               DISPLAY BY NAME g_xren2_d[l_ac].xren029,g_xren2_d[l_ac].xren029_desc
               NEXT FIELD xren029_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page2.xren030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren030
            #add-point:ON ACTION controlp INFIELD xren030 name="input.c.page2.xren030"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xren030_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren030_desc
            #add-point:ON ACTION controlp INFIELD xren030_desc name="input.c.page2.xren030_desc"
            #自由核算項八
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_xren2_d[l_ac].xren030

               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0241,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_xren2_d[l_ac].xren030      = g_qryparam.return1
               LET g_xren2_d[l_ac].xren030_desc = g_qryparam.return1
               DISPLAY BY NAME g_xren2_d[l_ac].xren030,g_xren2_d[l_ac].xren030_desc
               NEXT FIELD xren030_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page2.xren031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren031
            #add-point:ON ACTION controlp INFIELD xren031 name="input.c.page2.xren031"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xren031_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren031_desc
            #add-point:ON ACTION controlp INFIELD xren031_desc name="input.c.page2.xren031_desc"
            #自由核算項九
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_xren2_d[l_ac].xren031

               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0251,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_xren2_d[l_ac].xren031      = g_qryparam.return1
               LET g_xren2_d[l_ac].xren031_desc = g_qryparam.return1
               DISPLAY BY NAME g_xren2_d[l_ac].xren031,g_xren2_d[l_ac].xren031_desc
               NEXT FIELD xren031_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page2.xren032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren032
            #add-point:ON ACTION controlp INFIELD xren032 name="input.c.page2.xren032"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xren032_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xren032_desc
            #add-point:ON ACTION controlp INFIELD xren032_desc name="input.c.page2.xren032_desc"
            #自由核算項十
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_xren2_d[l_ac].xren032

               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0261,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_xren2_d[l_ac].xren032     = g_qryparam.return1
               LET g_xren2_d[l_ac].xren032_desc = g_qryparam.return1
               DISPLAY BY NAME g_xren2_d[l_ac].xren032,g_xren2_d[l_ac].xren032_desc
               NEXT FIELD xren032_desc
            END IF
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page2 after_row name="input.body2.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_xren2_d[l_ac].* = g_xren2_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE axrt930_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL axrt930_unlock_b("xren_t","'2'")
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
               LET g_xren_d[li_reproduce_target].* = g_xren_d[li_reproduce].*
               LET g_xren2_d[li_reproduce_target].* = g_xren2_d[li_reproduce].*
 
               LET g_xren2_d[li_reproduce_target].xrenseq = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_xren2_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_xren2_d.getLength()+1
            END IF
            
      END INPUT
 
      
 
 
 
 
{</section>}
 
{<section id="axrt930.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
       
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1','2',"))      
         CALL DIALOG.setCurrentRow("s_detail2",g_idx_group.getValue(""))
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            
            #end add-point  
            NEXT FIELD xremdocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD xrenseq
               WHEN "s_detail2"
                  NEXT FIELD xrenseq_2
 
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
   #20150528--add--str--lujh
   CALL s_aooi200_fin_get_slip(g_xrem_m.xremdocno )
   RETURNING l_success,l_slip            
      
   #是否抛傳票    
   SELECT ooac004 INTO l_ooac004
     FROM ooac_t
    WHERE ooacent = g_enterprise
      AND ooac001 = g_glaa_t.glaa024
      AND ooac002 = l_slip
      AND ooac003 = 'D-FIN-0030'  
   
   IF g_glaa_t.glaa121 = 'Y' AND l_ooac004 = 'Y' THEN 
      CALL s_transaction_begin()
      CALL cl_err_collect_init()
      
      IF g_argv[1] = '1' THEN 
         CALL s_pre_voucher_ins('AR','R50',g_xrem_m.xremld,g_xrem_m.xremdocno,g_xrem_m.xremdocdt,'5') RETURNING l_success
      ELSE
         CALL s_pre_voucher_ins('AR','R51',g_xrem_m.xremld,g_xrem_m.xremdocno,g_xrem_m.xremdocdt,'5') RETURNING l_success   #160920-00010#1 Mod '6' --> '5'
      END IF
      
      IF l_success THEN
         CALL s_transaction_end('Y','0')
      ELSE
         CALL s_transaction_end('N','0') 
         CALL cl_err_collect_show()      
      END IF
   END IF
   #20150528--add--end--lujh
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="axrt930.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION axrt930_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   #161128-00061#4-----modify--begin----------
   #SELECT * INTO g_glaa_t.* 
    SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,
           glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,glaa011,
           glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,glaa023,
           glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,glaa113,glaa120,glaa121,
           glaa122,glaa027,glaa130,glaa131,glaa132,glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,
           glaa140,glaa123,glaa124,glaa028 INTO g_glaa_t.* 
   #161128-00061#4----modify--end----------
   FROM glaa_t 
    WHERE glaaent = g_enterprise AND glaald = g_xrem_m.xremld
   
   LET g_aw = g_curr_diag.getCurrentItem()
   IF g_aw = "s_detail2" AND g_xrem_m.xremstus ='N' THEN
      CALL cl_set_act_visible('modify_detail',TRUE)
   ELSE
      CALL cl_set_act_visible('modify_detail',FALSE)
   END IF
   IF g_xrem_m.xremstus <>'N' THEN
      CALL cl_set_act_visible('modify,delete',FALSE)
   ELSE
      CALL cl_set_act_visible('modify,delete',TRUE)
   END IF
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL axrt930_b_fill() #單身填充
      CALL axrt930_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL axrt930_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
 
   #end add-point
   
   #遮罩相關處理
   LET g_xrem_m_mask_o.* =  g_xrem_m.*
   CALL axrt930_xrem_t_mask()
   LET g_xrem_m_mask_n.* =  g_xrem_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_xrem_m.xremsite,g_xrem_m.xremsite_desc,g_xrem_m.xremld,g_xrem_m.xremld_desc,g_xrem_m.xrem004, 
       g_xrem_m.xrem004_desc,g_xrem_m.xremcomp,g_xrem_m.xrem006,g_xrem_m.xremdocno,g_xrem_m.xremdocdt, 
       g_xrem_m.xrem001,g_xrem_m.xrem002,g_xrem_m.xrem005,g_xrem_m.xremstus,g_xrem_m.xremownid,g_xrem_m.xremownid_desc, 
       g_xrem_m.xremowndp,g_xrem_m.xremowndp_desc,g_xrem_m.xremcrtid,g_xrem_m.xremcrtid_desc,g_xrem_m.xremcrtdp, 
       g_xrem_m.xremcrtdp_desc,g_xrem_m.xremcrtdt,g_xrem_m.xremmodid,g_xrem_m.xremmodid_desc,g_xrem_m.xremmoddt, 
       g_xrem_m.xremcnfid,g_xrem_m.xremcnfid_desc,g_xrem_m.xremcnfdt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_xrem_m.xremstus 
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
   FOR l_ac = 1 TO g_xren_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_xren2_d.getLength()
      #add-point:show段單身reference name="show.body2.reference"
      
      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL axrt930_detail_show()
 
   #add-point:show段之後 name="show.after"
   IF g_glaa_t.glaa121 = 'Y' THEN
      CALL cl_set_toolbaritem_visible('open_pre',TRUE)
   ELSE
      CALL cl_set_toolbaritem_visible('open_pre',FALSE)
   END IF
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="axrt930.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION axrt930_detail_show()
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
 
{<section id="axrt930.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION axrt930_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE xrem_t.xremdocno 
   DEFINE l_oldno     LIKE xrem_t.xremdocno 
 
   DEFINE l_master    RECORD LIKE xrem_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE xren_t.* #此變數樣板目前無使用
 
 
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
   
   IF g_xrem_m.xremdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_xremdocno_t = g_xrem_m.xremdocno
 
    
   LET g_xrem_m.xremdocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_xrem_m.xremownid = g_user
      LET g_xrem_m.xremowndp = g_dept
      LET g_xrem_m.xremcrtid = g_user
      LET g_xrem_m.xremcrtdp = g_dept 
      LET g_xrem_m.xremcrtdt = cl_get_current()
      LET g_xrem_m.xremmodid = g_user
      LET g_xrem_m.xremmoddt = cl_get_current()
      LET g_xrem_m.xremstus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
 
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_xrem_m.xremstus 
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
   
   
   CALL axrt930_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_xrem_m.* TO NULL
      INITIALIZE g_xren_d TO NULL
      INITIALIZE g_xren2_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL axrt930_show()
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
   CALL axrt930_set_act_visible()   
   CALL axrt930_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_xremdocno_t = g_xrem_m.xremdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " xrement = " ||g_enterprise|| " AND",
                      " xremdocno = '", g_xrem_m.xremdocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL axrt930_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL axrt930_idx_chk()
   
   LET g_data_owner = g_xrem_m.xremownid      
   LET g_data_dept  = g_xrem_m.xremowndp
   
   #功能已完成,通報訊息中心
   CALL axrt930_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="axrt930.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION axrt930_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE xren_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE axrt930_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM xren_t
    WHERE xrenent = g_enterprise AND xrendocno = g_xremdocno_t
 
    INTO TEMP axrt930_detail
 
   #將key修正為調整後   
   UPDATE axrt930_detail 
      #更新key欄位
      SET xrendocno = g_xrem_m.xremdocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO xren_t SELECT * FROM axrt930_detail
   
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
   DROP TABLE axrt930_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_xremdocno_t = g_xrem_m.xremdocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="axrt930.delete" >}
#+ 資料刪除
PRIVATE FUNCTION axrt930_delete()
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
   
   IF g_xrem_m.xremdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN axrt930_cl USING g_enterprise,g_xrem_m.xremdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axrt930_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE axrt930_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE axrt930_master_referesh USING g_xrem_m.xremdocno INTO g_xrem_m.xremsite,g_xrem_m.xremld,g_xrem_m.xrem004, 
       g_xrem_m.xremcomp,g_xrem_m.xrem006,g_xrem_m.xremdocno,g_xrem_m.xremdocdt,g_xrem_m.xrem001,g_xrem_m.xrem002, 
       g_xrem_m.xrem005,g_xrem_m.xremstus,g_xrem_m.xremownid,g_xrem_m.xremowndp,g_xrem_m.xremcrtid,g_xrem_m.xremcrtdp, 
       g_xrem_m.xremcrtdt,g_xrem_m.xremmodid,g_xrem_m.xremmoddt,g_xrem_m.xremcnfid,g_xrem_m.xremcnfdt, 
       g_xrem_m.xremownid_desc,g_xrem_m.xremowndp_desc,g_xrem_m.xremcrtid_desc,g_xrem_m.xremcrtdp_desc, 
       g_xrem_m.xremmodid_desc,g_xrem_m.xremcnfid_desc
   
   
   #檢查是否允許此動作
   IF NOT axrt930_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_xrem_m_mask_o.* =  g_xrem_m.*
   CALL axrt930_xrem_t_mask()
   LET g_xrem_m_mask_n.* =  g_xrem_m.*
   
   CALL axrt930_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   CALL s_axrt300_date_chk(g_xrem_m.xremsite,g_xrem_m.xremdocdt) RETURNING l_success
   IF NOT l_success THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "axr-00300"
      LET g_errparam.popup  = TRUE 
      CALL cl_err() 
      RETURN
   END IF
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL axrt930_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_xremdocno_t = g_xrem_m.xremdocno
 
 
      DELETE FROM xrem_t
       WHERE xrement = g_enterprise AND xremdocno = g_xrem_m.xremdocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_xrem_m.xremdocno,":",SQLERRMESSAGE  
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
      
      DELETE FROM xren_t
       WHERE xrenent = g_enterprise AND xrendocno = g_xrem_m.xremdocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xren_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      IF g_glaa_t.glaa121 = 'Y' THEN
         IF g_argv[1] = '1' THEN 
            CALL s_pre_voucher_del('AR','R50',g_xrem_m.xremld,g_xrem_m.xremdocno) RETURNING l_success
         ELSE
            CALL s_pre_voucher_del('AR','R51',g_xrem_m.xremld,g_xrem_m.xremdocno) RETURNING l_success
         END IF
         
         IF l_success = FALSE THEN 
            CALL s_transaction_end('N','0')
            RETURN
         END IF
      END IF
      #刪除單號
      IF NOT s_aooi200_fin_del_docno(g_xrem_m.xremld,g_xrem_m.xremdocno,g_xrem_m.xremdocdt) THEN
         CALL s_transaction_end('N','0')
         CALL cl_err_collect_show()
         RETURN
      END IF
      #end add-point
      
            
                                                               
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_xrem_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE axrt930_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_xren_d.clear() 
      CALL g_xren2_d.clear()       
 
     
      CALL axrt930_ui_browser_refresh()  
      #CALL axrt930_ui_headershow()  
      #CALL axrt930_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL axrt930_browser_fill("")
         CALL axrt930_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE axrt930_cl
 
   #功能已完成,通報訊息中心
   CALL axrt930_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="axrt930.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axrt930_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_xren_d.clear()
   CALL g_xren2_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF axrt930_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT xrenseq,xrenorga,xren004,xren005,xren006,xren007,xren008,xren100, 
             xren040,xren041,xren103,xren104,xren105,xren113,xren114,xren115,xrenseq,xren033,xren043, 
             xren019,xren042,xren016,xren011,xren012,xren013,xren014,xren015,xren017,xren018,xren020, 
             xren021,xren022,xren023,xren024,xren025,xren026,xren027,xren028,xren029,xren030,xren031, 
             xren032  FROM xren_t",   
                     " INNER JOIN xrem_t ON xrement = " ||g_enterprise|| " AND xremdocno = xrendocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                     
                     " WHERE xrenent=? AND xrendocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY xren_t.xrenseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
      
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE axrt930_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR axrt930_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_xrem_m.xremdocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_xrem_m.xremdocno INTO g_xren_d[l_ac].xrenseq,g_xren_d[l_ac].xrenorga, 
          g_xren_d[l_ac].xren004,g_xren_d[l_ac].xren005,g_xren_d[l_ac].xren006,g_xren_d[l_ac].xren007, 
          g_xren_d[l_ac].xren008,g_xren_d[l_ac].xren100,g_xren_d[l_ac].xren040,g_xren_d[l_ac].xren041, 
          g_xren_d[l_ac].xren103,g_xren_d[l_ac].xren104,g_xren_d[l_ac].xren105,g_xren_d[l_ac].xren113, 
          g_xren_d[l_ac].xren114,g_xren_d[l_ac].xren115,g_xren2_d[l_ac].xrenseq,g_xren2_d[l_ac].xren033, 
          g_xren2_d[l_ac].xren043,g_xren2_d[l_ac].xren019,g_xren2_d[l_ac].xren042,g_xren2_d[l_ac].xren016, 
          g_xren2_d[l_ac].xren011,g_xren2_d[l_ac].xren012,g_xren2_d[l_ac].xren013,g_xren2_d[l_ac].xren014, 
          g_xren2_d[l_ac].xren015,g_xren2_d[l_ac].xren017,g_xren2_d[l_ac].xren018,g_xren2_d[l_ac].xren020, 
          g_xren2_d[l_ac].xren021,g_xren2_d[l_ac].xren022,g_xren2_d[l_ac].xren023,g_xren2_d[l_ac].xren024, 
          g_xren2_d[l_ac].xren025,g_xren2_d[l_ac].xren026,g_xren2_d[l_ac].xren027,g_xren2_d[l_ac].xren028, 
          g_xren2_d[l_ac].xren029,g_xren2_d[l_ac].xren030,g_xren2_d[l_ac].xren031,g_xren2_d[l_ac].xren032  
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
         CALL s_desc_get_department_desc(g_xrem_m.xremsite)RETURNING g_xrem_m.xremsite_desc
         CALL s_desc_get_ld_desc(g_xrem_m.xremld) RETURNING g_xrem_m.xremld_desc
         CALL s_desc_get_person_desc(g_xrem_m.xrem004) RETURNING g_xrem_m.xrem004_desc
         LET g_xren2_d[l_ac].xren0052 = g_xren_d[l_ac].xren005
         LET g_xren2_d[l_ac].xren0062 = g_xren_d[l_ac].xren006
         LET g_xren2_d[l_ac].xren0072 = g_xren_d[l_ac].xren007    #20150529 change xren002 to xren007 lujh
         #固定核算項
         LET g_xren2_d[l_ac].xren042_desc = s_desc_show1(g_xren2_d[l_ac].xren042,s_desc_get_account_desc(g_xrem_m.xremld,g_xren2_d[l_ac].xren042))
         LET g_xren2_d[l_ac].xren043_desc = s_desc_show1(g_xren2_d[l_ac].xren043,s_desc_get_account_desc(g_xrem_m.xremld,g_xren2_d[l_ac].xren043))
         LET g_xren2_d[l_ac].xren019_desc = s_desc_show1(g_xren2_d[l_ac].xren019,s_desc_get_account_desc(g_xrem_m.xremld,g_xren2_d[l_ac].xren019))
         LET g_xren2_d[l_ac].xren011_desc = s_desc_show1(g_xren2_d[l_ac].xren011,s_desc_get_department_desc(g_xren2_d[l_ac].xren011))
         LET g_xren2_d[l_ac].xren012_desc = s_desc_show1(g_xren2_d[l_ac].xren012,s_desc_get_department_desc(g_xren2_d[l_ac].xren012))
         LET g_xren2_d[l_ac].xren013_desc = s_desc_show1(g_xren2_d[l_ac].xren013,s_desc_get_acc_desc('287',g_xren2_d[l_ac].xren013))
         LET g_xren2_d[l_ac].xren014_desc = s_desc_show1(g_xren2_d[l_ac].xren014,s_desc_get_acc_desc('281',g_xren2_d[l_ac].xren014))
         LET g_xren2_d[l_ac].xren015_desc = s_desc_show1(g_xren2_d[l_ac].xren015,s_desc_get_rtaxl003_desc(g_xren2_d[l_ac].xren015))
         LET g_xren2_d[l_ac].xren016_desc = s_desc_show1(g_xren2_d[l_ac].xren016,s_desc_get_person_desc(g_xren2_d[l_ac].xren016))
         LET g_xren2_d[l_ac].xren017_desc = s_desc_show1(g_xren2_d[l_ac].xren017,s_desc_get_project_desc(g_xren2_d[l_ac].xren017))
         LET g_xren2_d[l_ac].xren021_desc = s_desc_show1(g_xren2_d[l_ac].xren021,s_desc_get_oojdl003_desc(g_xren2_d[l_ac].xren021))
         LET g_xren2_d[l_ac].xren022_desc = s_desc_show1(g_xren2_d[l_ac].xren022,s_desc_get_acc_desc(2002,g_xren2_d[l_ac].xren022))
         
         
         #取得自由核算項類型
         # CALL s_fin_sel_glad(g_xrem_m.xremld,g_xren2_d[l_ac].xren019,'ALL') RETURNING g_glad.*
         LET g_glad.glad017 = 'N' #自由核算項一控制方式
         LET g_glad.glad018 = 'N'
         LET g_glad.glad019 = 'N'
         LET g_glad.glad020 = 'N'
         LET g_glad.glad021 = 'N'
         LET g_glad.glad022 = 'N'
         LET g_glad.glad023 = 'N'
         LET g_glad.glad024 = 'N'
         LET g_glad.glad025 = 'N'
         LET g_glad.glad026 = 'N' #自由核算項十控制方式
         IF NOT cl_null(g_xren2_d[l_ac].xren019) THEN
             CALL axrt930_glad_chk(g_xren2_d[l_ac].xren019) RETURNING g_glad.*
         END IF  
         
         IF NOT cl_null(g_xren2_d[l_ac].xren042) THEN
             CALL axrt930_glad_chk(g_xren2_d[l_ac].xren042) RETURNING g_glad.*
         END IF
         
         IF NOT cl_null(g_xren2_d[l_ac].xren043) THEN 
             CALL axrt930_glad_chk(g_xren2_d[l_ac].xren043) RETURNING g_glad.*   
         END IF 
                               
         LET g_xren2_d[l_ac].xren023_desc = s_desc_show1(g_xren2_d[l_ac].xren023,s_fin_get_accting_desc(g_glad.glad0171,g_xren2_d[l_ac].xren023))
         LET g_xren2_d[l_ac].xren024_desc = s_desc_show1(g_xren2_d[l_ac].xren024,s_fin_get_accting_desc(g_glad.glad0181,g_xren2_d[l_ac].xren024))
         LET g_xren2_d[l_ac].xren025_desc = s_desc_show1(g_xren2_d[l_ac].xren025,s_fin_get_accting_desc(g_glad.glad0191,g_xren2_d[l_ac].xren025))
         LET g_xren2_d[l_ac].xren026_desc = s_desc_show1(g_xren2_d[l_ac].xren026,s_fin_get_accting_desc(g_glad.glad0201,g_xren2_d[l_ac].xren026))
         LET g_xren2_d[l_ac].xren027_desc = s_desc_show1(g_xren2_d[l_ac].xren027,s_fin_get_accting_desc(g_glad.glad0211,g_xren2_d[l_ac].xren027))
         LET g_xren2_d[l_ac].xren028_desc = s_desc_show1(g_xren2_d[l_ac].xren028,s_fin_get_accting_desc(g_glad.glad0221,g_xren2_d[l_ac].xren028))
         LET g_xren2_d[l_ac].xren029_desc = s_desc_show1(g_xren2_d[l_ac].xren029,s_fin_get_accting_desc(g_glad.glad0231,g_xren2_d[l_ac].xren029))
         LET g_xren2_d[l_ac].xren030_desc = s_desc_show1(g_xren2_d[l_ac].xren030,s_fin_get_accting_desc(g_glad.glad0241,g_xren2_d[l_ac].xren030))
         LET g_xren2_d[l_ac].xren031_desc = s_desc_show1(g_xren2_d[l_ac].xren031,s_fin_get_accting_desc(g_glad.glad0251,g_xren2_d[l_ac].xren031))
         LET g_xren2_d[l_ac].xren032_desc = s_desc_show1(g_xren2_d[l_ac].xren032,s_fin_get_accting_desc(g_glad.glad0261,g_xren2_d[l_ac].xren032))
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
   
   CALL g_xren_d.deleteElement(g_xren_d.getLength())
   CALL g_xren2_d.deleteElement(g_xren2_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE axrt930_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_xren_d.getLength()
      LET g_xren_d_mask_o[l_ac].* =  g_xren_d[l_ac].*
      CALL axrt930_xren_t_mask()
      LET g_xren_d_mask_n[l_ac].* =  g_xren_d[l_ac].*
   END FOR
   
   LET g_xren2_d_mask_o.* =  g_xren2_d.*
   FOR l_ac = 1 TO g_xren2_d.getLength()
      LET g_xren2_d_mask_o[l_ac].* =  g_xren2_d[l_ac].*
      CALL axrt930_xren_t_mask()
      LET g_xren2_d_mask_n[l_ac].* =  g_xren2_d[l_ac].*
   END FOR
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="axrt930.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION axrt930_delete_b(ps_table,ps_keys_bak,ps_page)
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
   LET ls_group = "'1','2',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete"
      
      #end add-point    
      DELETE FROM xren_t
       WHERE xrenent = g_enterprise AND
         xrendocno = ps_keys_bak[1] AND xrenseq = ps_keys_bak[2]
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
         CALL g_xren_d.deleteElement(li_idx) 
      END IF 
      IF ps_page <> "'2'" THEN 
         CALL g_xren2_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="axrt930.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION axrt930_insert_b(ps_table,ps_keys,ps_page)
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
      
      #end add-point 
      INSERT INTO xren_t
                  (xrenent,
                   xrendocno,
                   xrenseq
                   ,xrenorga,xren004,xren005,xren006,xren007,xren008,xren100,xren040,xren041,xren103,xren104,xren105,xren113,xren114,xren115,xren033,xren043,xren019,xren042,xren016,xren011,xren012,xren013,xren014,xren015,xren017,xren018,xren020,xren021,xren022,xren023,xren024,xren025,xren026,xren027,xren028,xren029,xren030,xren031,xren032) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_xren_d[g_detail_idx].xrenorga,g_xren_d[g_detail_idx].xren004,g_xren_d[g_detail_idx].xren005, 
                       g_xren_d[g_detail_idx].xren006,g_xren_d[g_detail_idx].xren007,g_xren_d[g_detail_idx].xren008, 
                       g_xren_d[g_detail_idx].xren100,g_xren_d[g_detail_idx].xren040,g_xren_d[g_detail_idx].xren041, 
                       g_xren_d[g_detail_idx].xren103,g_xren_d[g_detail_idx].xren104,g_xren_d[g_detail_idx].xren105, 
                       g_xren_d[g_detail_idx].xren113,g_xren_d[g_detail_idx].xren114,g_xren_d[g_detail_idx].xren115, 
                       g_xren2_d[g_detail_idx].xren033,g_xren2_d[g_detail_idx].xren043,g_xren2_d[g_detail_idx].xren019, 
                       g_xren2_d[g_detail_idx].xren042,g_xren2_d[g_detail_idx].xren016,g_xren2_d[g_detail_idx].xren011, 
                       g_xren2_d[g_detail_idx].xren012,g_xren2_d[g_detail_idx].xren013,g_xren2_d[g_detail_idx].xren014, 
                       g_xren2_d[g_detail_idx].xren015,g_xren2_d[g_detail_idx].xren017,g_xren2_d[g_detail_idx].xren018, 
                       g_xren2_d[g_detail_idx].xren020,g_xren2_d[g_detail_idx].xren021,g_xren2_d[g_detail_idx].xren022, 
                       g_xren2_d[g_detail_idx].xren023,g_xren2_d[g_detail_idx].xren024,g_xren2_d[g_detail_idx].xren025, 
                       g_xren2_d[g_detail_idx].xren026,g_xren2_d[g_detail_idx].xren027,g_xren2_d[g_detail_idx].xren028, 
                       g_xren2_d[g_detail_idx].xren029,g_xren2_d[g_detail_idx].xren030,g_xren2_d[g_detail_idx].xren031, 
                       g_xren2_d[g_detail_idx].xren032)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xren_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_xren_d.insertElement(li_idx) 
      END IF 
      IF ps_page <> "'2'" THEN 
         CALL g_xren2_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="axrt930.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION axrt930_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "xren_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL axrt930_xren_t_mask_restore('restore_mask_o')
               
      UPDATE xren_t 
         SET (xrendocno,
              xrenseq
              ,xrenorga,xren004,xren005,xren006,xren007,xren008,xren100,xren040,xren041,xren103,xren104,xren105,xren113,xren114,xren115,xren033,xren043,xren019,xren042,xren016,xren011,xren012,xren013,xren014,xren015,xren017,xren018,xren020,xren021,xren022,xren023,xren024,xren025,xren026,xren027,xren028,xren029,xren030,xren031,xren032) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_xren_d[g_detail_idx].xrenorga,g_xren_d[g_detail_idx].xren004,g_xren_d[g_detail_idx].xren005, 
                  g_xren_d[g_detail_idx].xren006,g_xren_d[g_detail_idx].xren007,g_xren_d[g_detail_idx].xren008, 
                  g_xren_d[g_detail_idx].xren100,g_xren_d[g_detail_idx].xren040,g_xren_d[g_detail_idx].xren041, 
                  g_xren_d[g_detail_idx].xren103,g_xren_d[g_detail_idx].xren104,g_xren_d[g_detail_idx].xren105, 
                  g_xren_d[g_detail_idx].xren113,g_xren_d[g_detail_idx].xren114,g_xren_d[g_detail_idx].xren115, 
                  g_xren2_d[g_detail_idx].xren033,g_xren2_d[g_detail_idx].xren043,g_xren2_d[g_detail_idx].xren019, 
                  g_xren2_d[g_detail_idx].xren042,g_xren2_d[g_detail_idx].xren016,g_xren2_d[g_detail_idx].xren011, 
                  g_xren2_d[g_detail_idx].xren012,g_xren2_d[g_detail_idx].xren013,g_xren2_d[g_detail_idx].xren014, 
                  g_xren2_d[g_detail_idx].xren015,g_xren2_d[g_detail_idx].xren017,g_xren2_d[g_detail_idx].xren018, 
                  g_xren2_d[g_detail_idx].xren020,g_xren2_d[g_detail_idx].xren021,g_xren2_d[g_detail_idx].xren022, 
                  g_xren2_d[g_detail_idx].xren023,g_xren2_d[g_detail_idx].xren024,g_xren2_d[g_detail_idx].xren025, 
                  g_xren2_d[g_detail_idx].xren026,g_xren2_d[g_detail_idx].xren027,g_xren2_d[g_detail_idx].xren028, 
                  g_xren2_d[g_detail_idx].xren029,g_xren2_d[g_detail_idx].xren030,g_xren2_d[g_detail_idx].xren031, 
                  g_xren2_d[g_detail_idx].xren032) 
         WHERE xrenent = g_enterprise AND xrendocno = ps_keys_bak[1] AND xrenseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xren_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xren_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL axrt930_xren_t_mask_restore('restore_mask_n')
               
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
 
{<section id="axrt930.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION axrt930_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="axrt930.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION axrt930_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="axrt930.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION axrt930_lock_b(ps_table,ps_page)
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
   #CALL axrt930_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1','2',"
   #僅鎖定自身table
   LET ls_group = "xren_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN axrt930_bcl USING g_enterprise,
                                       g_xrem_m.xremdocno,g_xren_d[g_detail_idx].xrenseq     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "axrt930_bcl:",SQLERRMESSAGE 
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
 
{<section id="axrt930.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION axrt930_unlock_b(ps_table,ps_page)
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
      CLOSE axrt930_bcl
   END IF
   
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="axrt930.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION axrt930_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("xremdocno,xremld",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("xremdocno",TRUE)
      CALL cl_set_comp_entry("xremdocdt",TRUE)
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
 
{<section id="axrt930.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION axrt930_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("xremdocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("xremdocno,xremld",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("xremdocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="axrt930.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION axrt930_set_entry_b(p_cmd)
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
 
{<section id="axrt930.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION axrt930_set_no_entry_b(p_cmd)
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
 
{<section id="axrt930.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION axrt930_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="axrt930.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION axrt930_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:1)
   IF g_xrem_m.xremstus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF


   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="axrt930.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION axrt930_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   LET g_aw = g_curr_diag.getCurrentItem()
   IF g_aw = "s_detail2" AND g_xrem_m.xremstus ='N' THEN
      CALL cl_set_act_visible('modify_detail',TRUE)
   ELSE
      CALL cl_set_act_visible('modify_detail',FALSE)
   END IF
   IF g_xrem_m.xremstus <>'N' THEN
      CALL cl_set_act_visible('modify,delete',FALSE)
   END IF
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="axrt930.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION axrt930_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="axrt930.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION axrt930_default_search()
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
      LET ls_wc = ls_wc, " xremdocno = '", g_argv[01], "' AND "
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
               WHEN la_wc[li_idx].tableid = "xrem_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "xren_t" 
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
   CASE
      WHEN g_argv[01] = 1  
         LET ls_wc = " xrem006 = '1'"
      WHEN g_argv[01] = 2  
         LET ls_wc = " xrem006 = '2'"
   END CASE   
   #end add-point  
 
   IF g_wc.getIndexOf(" 1=2", 1) THEN
      LET g_default = TRUE
   END IF
 
 
END FUNCTION
 
{</section>}
 
{<section id="axrt930.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION axrt930_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_success      LIKE type_t.num5
   DEFINE l_wc           STRING
   DEFINE l_efin5001     LIKE type_t.chr1
   DEFINE l_ooba002      LIKE ooba_t.ooba002
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   CALL s_axrt300_date_chk(g_xrem_m.xremsite,g_xrem_m.xremdocdt) RETURNING l_success
   IF NOT l_success THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "axr-00300"
      LET g_errparam.popup  = TRUE 
      CALL cl_err() 
      RETURN
   END IF
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_xrem_m.xremdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN axrt930_cl USING g_enterprise,g_xrem_m.xremdocno
   IF STATUS THEN
      CLOSE axrt930_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axrt930_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE axrt930_master_referesh USING g_xrem_m.xremdocno INTO g_xrem_m.xremsite,g_xrem_m.xremld,g_xrem_m.xrem004, 
       g_xrem_m.xremcomp,g_xrem_m.xrem006,g_xrem_m.xremdocno,g_xrem_m.xremdocdt,g_xrem_m.xrem001,g_xrem_m.xrem002, 
       g_xrem_m.xrem005,g_xrem_m.xremstus,g_xrem_m.xremownid,g_xrem_m.xremowndp,g_xrem_m.xremcrtid,g_xrem_m.xremcrtdp, 
       g_xrem_m.xremcrtdt,g_xrem_m.xremmodid,g_xrem_m.xremmoddt,g_xrem_m.xremcnfid,g_xrem_m.xremcnfdt, 
       g_xrem_m.xremownid_desc,g_xrem_m.xremowndp_desc,g_xrem_m.xremcrtid_desc,g_xrem_m.xremcrtdp_desc, 
       g_xrem_m.xremmodid_desc,g_xrem_m.xremcnfid_desc
   
 
   #檢查是否允許此動作
   IF NOT axrt930_action_chk() THEN
      CLOSE axrt930_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_xrem_m.xremsite,g_xrem_m.xremsite_desc,g_xrem_m.xremld,g_xrem_m.xremld_desc,g_xrem_m.xrem004, 
       g_xrem_m.xrem004_desc,g_xrem_m.xremcomp,g_xrem_m.xrem006,g_xrem_m.xremdocno,g_xrem_m.xremdocdt, 
       g_xrem_m.xrem001,g_xrem_m.xrem002,g_xrem_m.xrem005,g_xrem_m.xremstus,g_xrem_m.xremownid,g_xrem_m.xremownid_desc, 
       g_xrem_m.xremowndp,g_xrem_m.xremowndp_desc,g_xrem_m.xremcrtid,g_xrem_m.xremcrtid_desc,g_xrem_m.xremcrtdp, 
       g_xrem_m.xremcrtdp_desc,g_xrem_m.xremcrtdt,g_xrem_m.xremmodid,g_xrem_m.xremmodid_desc,g_xrem_m.xremmoddt, 
       g_xrem_m.xremcnfid,g_xrem_m.xremcnfid_desc,g_xrem_m.xremcnfdt
 
   CASE g_xrem_m.xremstus
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
         CASE g_xrem_m.xremstus
            
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
            
      HIDE OPTION "approved"
      
      HIDE OPTION "withdraw"
      
      HIDE OPTION "rejection"
      
      HIDE OPTION "signing"    

      CALL s_transaction_begin()
      CALL cl_err_collect_init()
      LET l_success=TRUE 

      #end add-point
      
      #應用 a36 樣板自動產生(Version:5)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT axrt930_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE axrt930_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT axrt930_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE axrt930_cl
            RETURN
         END IF
 
 
 
	  
      ON ACTION unconfirmed
         IF cl_auth_chk_act("unconfirmed") THEN
            LET lc_state = "N"
            #add-point:action控制 name="statechange.unconfirmed"
            CALL s_axrt940_unconf_chk_em(g_xrem_m.xremdocno) RETURNING l_success
            IF l_success = TRUE THEN
               CALL s_axrt940_unconf_upd_em(g_xrem_m.xremdocno) RETURNING l_success
            END IF 
            #end add-point
         END IF
         EXIT MENU
      ON ACTION confirmed
         IF cl_auth_chk_act("confirmed") THEN
            LET lc_state = "Y"
            #add-point:action控制 name="statechange.confirmed"
            #150602-00057#2 by 02291 add
            CALL s_aooi200_fin_get_slip(g_xrem_m.xremdocno) RETURNING l_success,l_ooba002
            CALL s_fin_chk_E5001(g_xrem_m.xremld,g_xrem_m.xremcomp,l_ooba002) RETURNING l_efin5001
            IF l_efin5001 = 'N' THEN
               IF g_xrem_m.xremcrtid = g_user THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'axr-00346'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CALL cl_err_collect_show()
                  CALL s_transaction_end('N','0')
                  CLOSE axrt930_cl
                  RETURN
               END IF
            END IF 
            #150602-00057#2 by 02291 add
            CALL s_axrt940_conf_chk_em(g_xrem_m.xremdocno) RETURNING l_success 
            IF l_success = TRUE THEN
               CALL s_axrt940_conf_upd_em(g_xrem_m.xremdocno) RETURNING l_success
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
      ON ACTION invalid
         IF cl_auth_chk_act("invalid") THEN
            LET lc_state = "X"
            #add-point:action控制 name="statechange.invalid"
            CALL s_axrt940_void_chk_em(g_xrem_m.xremdocno) RETURNING l_success
            IF l_success = TRUE THEN
               CALL s_axrt940_void_upd_em(g_xrem_m.xremdocno) RETURNING l_success
            END IF 
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
      g_xrem_m.xremstus = lc_state OR cl_null(lc_state) THEN
      CLOSE axrt930_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   #151125-00001#4 --- add start ---
   IF lc_state = 'X' THEN
      IF NOT cl_ask_confirm('aim-00109') THEN
         CALL s_transaction_end('N','0') 
         RETURN
      END IF
   END IF
   #151125-00001#4 --- add end   ---   
   IF g_glaa_t.glaa121 = 'Y' AND l_success = TRUE THEN 
      LET l_wc = "glgadocno = '",g_xrem_m.xremdocno,"'"
      
      IF g_argv[1] = '1' THEN 
         CALL s_pre_voucher_upd('AR','R50',g_xrem_m.xremld,lc_state,'','',l_wc) RETURNING l_success
      ELSE
         CALL s_pre_voucher_upd('AR','R51',g_xrem_m.xremld,lc_state,'','',l_wc) RETURNING l_success
      END IF
   END IF
   
   CALL cl_err_collect_show()
   IF l_success = FALSE THEN
      CALL s_transaction_end('N','0')
      RETURN
   ELSE
      CALL s_transaction_end('Y','0')
   END IF

   #end add-point
   
   LET g_xrem_m.xremmodid = g_user
   LET g_xrem_m.xremmoddt = cl_get_current()
   LET g_xrem_m.xremstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE xrem_t 
      SET (xremstus,xremmodid,xremmoddt) 
        = (g_xrem_m.xremstus,g_xrem_m.xremmodid,g_xrem_m.xremmoddt)     
    WHERE xrement = g_enterprise AND xremdocno = g_xrem_m.xremdocno
 
    
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
      EXECUTE axrt930_master_referesh USING g_xrem_m.xremdocno INTO g_xrem_m.xremsite,g_xrem_m.xremld, 
          g_xrem_m.xrem004,g_xrem_m.xremcomp,g_xrem_m.xrem006,g_xrem_m.xremdocno,g_xrem_m.xremdocdt, 
          g_xrem_m.xrem001,g_xrem_m.xrem002,g_xrem_m.xrem005,g_xrem_m.xremstus,g_xrem_m.xremownid,g_xrem_m.xremowndp, 
          g_xrem_m.xremcrtid,g_xrem_m.xremcrtdp,g_xrem_m.xremcrtdt,g_xrem_m.xremmodid,g_xrem_m.xremmoddt, 
          g_xrem_m.xremcnfid,g_xrem_m.xremcnfdt,g_xrem_m.xremownid_desc,g_xrem_m.xremowndp_desc,g_xrem_m.xremcrtid_desc, 
          g_xrem_m.xremcrtdp_desc,g_xrem_m.xremmodid_desc,g_xrem_m.xremcnfid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_xrem_m.xremsite,g_xrem_m.xremsite_desc,g_xrem_m.xremld,g_xrem_m.xremld_desc, 
          g_xrem_m.xrem004,g_xrem_m.xrem004_desc,g_xrem_m.xremcomp,g_xrem_m.xrem006,g_xrem_m.xremdocno, 
          g_xrem_m.xremdocdt,g_xrem_m.xrem001,g_xrem_m.xrem002,g_xrem_m.xrem005,g_xrem_m.xremstus,g_xrem_m.xremownid, 
          g_xrem_m.xremownid_desc,g_xrem_m.xremowndp,g_xrem_m.xremowndp_desc,g_xrem_m.xremcrtid,g_xrem_m.xremcrtid_desc, 
          g_xrem_m.xremcrtdp,g_xrem_m.xremcrtdp_desc,g_xrem_m.xremcrtdt,g_xrem_m.xremmodid,g_xrem_m.xremmodid_desc, 
          g_xrem_m.xremmoddt,g_xrem_m.xremcnfid,g_xrem_m.xremcnfid_desc,g_xrem_m.xremcnfdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE axrt930_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL axrt930_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axrt930.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION axrt930_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_xren_d.getLength() THEN
         LET g_detail_idx = g_xren_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_xren_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_xren_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_xren2_d.getLength() THEN
         LET g_detail_idx = g_xren2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_xren2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_xren2_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axrt930.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axrt930_b_fill2(pi_idx)
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
   
   CALL axrt930_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="axrt930.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION axrt930_fill_chk(ps_idx)
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
 
{<section id="axrt930.status_show" >}
PRIVATE FUNCTION axrt930_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axrt930.mask_functions" >}
&include "erp/axr/axrt930_mask.4gl"
 
{</section>}
 
{<section id="axrt930.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION axrt930_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
 
 
   CALL axrt930_show()
   CALL axrt930_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_xrem_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_xren_d))
   CALL cl_bpm_set_detail_data("s_detail2", util.JSONArray.fromFGL(g_xren2_d))
 
 
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
   #CALL axrt930_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL axrt930_ui_headershow()
   CALL axrt930_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION axrt930_draw_out()
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
   CALL axrt930_ui_headershow()  
   CALL axrt930_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="axrt930.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION axrt930_set_pk_array()
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
   LET g_pk_array[1].values = g_xrem_m.xremdocno
   LET g_pk_array[1].column = 'xremdocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axrt930.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="axrt930.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION axrt930_msgcentre_notify(lc_state)
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
   CALL axrt930_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_xrem_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axrt930.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION axrt930_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="axrt930.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 銷售渠道檢查
# Memo...........:
# Usage..........: CALL axrt930_xren021_chk()
# Date & Author..: 
# Modify.........:
################################################################################
PUBLIC FUNCTION axrt930_xren021_chk(p_oojd001)
DEFINE p_oojd001    LIKE oojd_t.oojd001
DEFINE l_count      LIKE type_t.num5
DEFINE r_success    LIKE type_t.num5
DEFINE r_errno      LIKE gzze_t.gzze001

   LET r_success = TRUE
   LET r_errno = ''
   LET l_count = ''
   SELECT COUNT (*) INTO l_count
     FROM oojd_t
    WHERE oojdent = g_enterprise
      AND oojd001 = p_oojd001

   IF cl_null(l_count) THEN LET l_count = 0 END IF
   IF l_count = 0 THEN
      LET r_success = FALSE
      LET r_errno = 'abg-00043'
   END IF

   RETURN r_success,r_errno
END FUNCTION

################################################################################
# Descriptions...:  
# Memo...........:
# Usage..........: CALL axrt930_glad_chk(p_glad001)
# Input parameter:  
# Modify.........:
################################################################################
PUBLIC FUNCTION axrt930_glad_chk(p_glad001)
#161128-00061#5---modify----begin------------- 
#DEFINE l_glad  RECORD LIKE glad_t.*
DEFINE l_glad RECORD  #帳套科目管理設定檔
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
       glad032 LIKE glad_t.glad032, #啟用通路管理
       glad033 LIKE glad_t.glad033, #啟用品牌管理
       glad034 LIKE glad_t.glad034, #科目做多幣別管理
       glad035 LIKE glad_t.glad035, #是否是子系統科目
       glad036 LIKE glad_t.glad036  #貸方現金變動碼
       END RECORD

DEFINE p_glad001    LIKE glad_t.glad001
    
   #161128-00061#5---modify----begin-------------  
   #SELECT * INTO l_glad.* 
   SELECT gladent,gladownid,gladowndp,gladcrtid,gladcrtdp,gladcrtdt,gladmodid,gladmoddt,gladstus,gladld,
          glad001,glad002,glad003,glad004,glad005,glad006,glad007,glad008,glad009,glad010,glad011,glad012,
          glad013,glad014,glad015,glad016,glad017,glad0171,glad0172,glad018,glad0181,glad0182,glad019,glad0191,
          glad0192,glad020,glad0201,glad0202,glad021,glad0211,glad0212,glad022,glad0221,glad0222,glad023,glad0231,
          glad0232,glad024,glad0241,glad0242,glad025,glad0251,glad0252,glad026,glad0261,glad0262,glad027,glad030,
          glad031,glad032,glad033,glad034,glad035,glad036 INTO l_glad.* 
   #161128-00061#5---modify----end------------- 
     FROM glad_t
    WHERE gladent = g_enterprise
      AND gladld  = g_xrem_m.xremld
      AND glad001 = p_glad001

   IF l_glad.glad017 = 'Y' THEN LET g_glad.glad017 = 'Y' END IF
   IF l_glad.glad018 = 'Y' THEN LET g_glad.glad018 = 'Y' END IF
   IF l_glad.glad019 = 'Y' THEN LET g_glad.glad019 = 'Y' END IF
   IF l_glad.glad020 = 'Y' THEN LET g_glad.glad020 = 'Y' END IF 
   IF l_glad.glad021 = 'Y' THEN LET g_glad.glad021 = 'Y' END IF 
   IF l_glad.glad022 = 'Y' THEN LET g_glad.glad022 = 'Y' END IF 
   IF l_glad.glad023 = 'Y' THEN LET g_glad.glad023 = 'Y' END IF 
   IF l_glad.glad024 = 'Y' THEN LET g_glad.glad024 = 'Y' END IF 
   IF l_glad.glad025 = 'Y' THEN LET g_glad.glad025 = 'Y' END IF 
   IF l_glad.glad026 = 'Y' THEN LET g_glad.glad026 = 'Y' END IF 
   LET g_glad.glad0171 = l_glad.glad0171
   LET g_glad.glad0172 = l_glad.glad0172
   LET g_glad.glad0181 = l_glad.glad0181
   LET g_glad.glad0182 = l_glad.glad0182
   LET g_glad.glad0191 = l_glad.glad0191
   LET g_glad.glad0192 = l_glad.glad0192
   LET g_glad.glad0201 = l_glad.glad0201
   LET g_glad.glad0202 = l_glad.glad0202
   LET g_glad.glad0211 = l_glad.glad0211
   LET g_glad.glad0221 = l_glad.glad0221
   LET g_glad.glad0222 = l_glad.glad0222
   LET g_glad.glad0232 = l_glad.glad0231
   LET g_glad.glad0232 = l_glad.glad0232
   LET g_glad.glad0241 = l_glad.glad0241
   LET g_glad.glad0242 = l_glad.glad0242
   LET g_glad.glad0251 = l_glad.glad0251
   LET g_glad.glad0252 = l_glad.glad0252
   LET g_glad.glad0261 = l_glad.glad0261
   LET g_glad.glad0262 = l_glad.glad0262


   RETURN l_glad.*
END FUNCTION

################################################################################
# Descriptions...: 
# Memo...........:
# Usage..........: CALL axrt930_set_desc()
# Input parameter:  
# Date & Author..: 
# Modify.........:
################################################################################
PRIVATE FUNCTION axrt930_set_desc()
DEFINE l_gzze003       LIKE gzze_t.gzze003   
   CASE g_argv[1] 
      WHEN '1' 
      LET l_gzze003 = cl_getmsg('axr-00236',g_dlang)
      CALL cl_set_comp_att_text('xrem001',l_gzze003)
      LET l_gzze003 = cl_getmsg('axr-00237',g_dlang)
      CALL cl_set_comp_att_text('xrem002',l_gzze003)
      WHEN '2' 
      LET l_gzze003 = cl_getmsg('axr-00238',g_dlang)
      CALL cl_set_comp_att_text('xrem001',l_gzze003)
      LET l_gzze003 = cl_getmsg('axr-00239',g_dlang)
      CALL cl_set_comp_att_text('xrem002',l_gzze003)      
   END CASE
END FUNCTION

################################################################################
# Descriptions...: 傳票拋轉
# Memo...........:
# Usage..........: CALL axrt930_voucher()
# Date & Author..: 2014/11/05 By wangrr
# Modify.........:
################################################################################
PRIVATE FUNCTION axrt930_voucher()
   IF g_xrem_m.xremdocno IS NULL THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   IF g_xrem_m.xremstus <> 'Y' THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = g_xrem_m.xremdocno
      LET g_errparam.code   = "anm-00185" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   IF NOT cl_null(g_xrem_m.xrem005) THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = g_xrem_m.xremdocno 
      LET g_errparam.code   = "anm-00198" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   #拋轉傳票
   CALL axrt940_02(g_xrem_m.xremld,g_xrem_m.xremcomp,g_xrem_m.xremdocno,'2') RETURNING g_xrem_m.xrem005
   IF NOT cl_null(g_xrem_m.xrem005) THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = g_xrem_m.xremdocno
      LET g_errparam.code   = "axr-00119"
      LET g_errparam.popup  = FALSE      
      CALL cl_err()    
      DISPLAY BY NAME g_xrem_m.xrem005
   ELSE 
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = g_xrem_m.xremdocno
      LET g_errparam.code   = "axr-00120"
      LET g_errparam.popup  = FALSE      
      CALL cl_err()    
      LET g_xrem_m.xrem005=''
      DISPLAY BY NAME g_xrem_m.xrem005
   END IF
END FUNCTION

################################################################################
# Descriptions...: 傳票還原
# Memo...........:
# Usage..........: CALL axrt930_un_voucher()
# Date & Author..: 2014/11/05 By wangrr
# Modify.........:
################################################################################
PRIVATE FUNCTION axrt930_un_voucher()
   DEFINE l_cnt         LIKE type_t.num5
   DEFINE l_scom0002    LIKE type_t.chr10     #170103-00019#10 add
   DEFINE l_success     LIKE type_t.num5      #170103-00019#10 add
   DEFINE l_glapdocdt   LIKE glap_t.glapdocdt #170103-00019#10 add
   
   IF g_xrem_m.xremdocno IS NULL THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   IF cl_null(g_xrem_m.xrem005) THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = g_xrem_m.xremdocno
      LET g_errparam.code   = "anm-00186" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   SELECT COUNT(*) INTO l_cnt FROM glap_t
   WHERE glapent=g_enterprise AND glapld=g_xrem_m.xremld 
   AND glapdocno=g_xrem_m.xrem005 AND glapstus <>'N'
   IF l_cnt >0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = g_xrem_m.xrem005 
      LET g_errparam.code   = "axr-00076" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   #刪除傳票
   CALL s_transaction_begin()
   
   #170103-00019#10--add--str--
   CALL cl_get_para(g_enterprise,g_xrem_m.xremcomp,'S-COM-0002') RETURNING l_scom0002 
   #更新相关的细项立冲账资料
   LET l_success = TRUE
   CALL s_pre_voucher_delete_glax(g_xrem_m.xremld,g_xrem_m.xrem005,'',l_scom0002) RETURNING l_success
   IF l_success = FALSE THEN
      CALL s_transaction_end('N','0') 
      RETURN
   END IF
   
   IF l_scom0002 = 'Y' THEN
   #凭证作废处理
      UPDATE glap_t SET glapstus = 'X'
       WHERE glapent = g_enterprise
         AND glapld = g_xrem_m.xremld
         AND glapdocno = g_xrem_m.xrem005
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.extend = 'UPDATE glap_t'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         CALL s_transaction_end('N','0') 
         RETURN
      END IF
   ELSE
      #删除凭证
   #170103-00019#10--add--end
      DELETE FROM glap_t 
      WHERE glapent=g_enterprise AND glapld=g_xrem_m.xremld AND glapdocno=g_xrem_m.xrem005 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "delete glap_t"
         LET g_errparam.code   = SQLCA.SQLCODE
         LET g_errparam.popup  = TRUE      
         CALL cl_err()
         CALL s_transaction_end('N','0') 
         RETURN
      END IF
      DELETE FROM glaq_t 
      WHERE glaqent=g_enterprise AND glaqld=g_xrem_m.xremld AND glaqdocno=g_xrem_m.xrem005
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "delete glaq_t"
         LET g_errparam.code   = SQLCA.SQLCODE
         LET g_errparam.popup  = TRUE      
         CALL cl_err()
         CALL s_transaction_end('N','0') 
         RETURN
      END IF 
   #170103-00019#10--add--str--
      LET l_glapdocdt = ''
      SELECT glapdocdt INTO l_glapdocdt FROM glap_t
       WHERE glapent=g_enterprise AND glapld=g_xrem_m.xremld AND glapdocno=g_xrem_m.xrem005 
      LET g_prog = 'aglt310'
      IF NOT s_aooi200_fin_del_docno(g_xrem_m.xremld,g_xrem_m.xrem005,l_glapdocdt) THEN
         LET g_prog = 'axrt930'
         CALL s_transaction_end('N','0') 
         RETURN
      END IF
      LET g_prog = 'axrt930'
   END IF
   #170103-00019#10--add--end
   
   UPDATE xrem_t SET xrem005='' 
   WHERE xrement=g_enterprise AND xremdocno=g_xrem_m.xremdocno
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "update glap_t"
      LET g_errparam.code   = SQLCA.SQLCODE
      LET g_errparam.popup  = TRUE      
      CALL cl_err()
      CALL s_transaction_end('N','0') 
      RETURN
   END IF 
   CALL s_transaction_end('Y','0') 
   INITIALIZE g_errparam TO NULL 
   LET g_errparam.extend = g_xrem_m.xremdocno
   LET g_errparam.code   = "adz-00217"
   LET g_errparam.popup  = FALSE      
   CALL cl_err()    
   LET g_xrem_m.xrem005=''
   DISPLAY BY NAME g_xrem_m.xrem005
END FUNCTION
# WBS名稱
# 20150528 add lujh
PRIVATE FUNCTION axrt930_xren018_desc(p_xren017,p_xren018)
   DEFINE p_xren017          LIKE xren_t.xren017
   DEFINE p_xren018          LIKE xren_t.xren018
   DEFINE r_xren018_desc     LIKE type_t.chr80
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_xren017
   LET g_ref_fields[2] = p_xren018
   CALL ap_ref_array2(g_ref_fields,"SELECT pjbbl004 FROM pjbbl_t WHERE pjbblent='"||g_enterprise||"' AND pjbbl001=? AND pjbbl002=? AND pjbbl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_xren018_desc = '', g_rtn_fields[1] , ''
   
   RETURN r_xren018_desc
END FUNCTION

 
{</section>}
 
