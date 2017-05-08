#該程式未解開Section, 採用最新樣板產出!
{<section id="axrt300_06.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0008(2016-08-23 10:48:56), PR版次:0008(2016-12-13 09:50:14)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000265
#+ Filename...: axrt300_06
#+ Description: 沖暫估訊息
#+ Creator....: 01727(2014-06-16 14:24:25)
#+ Modifier...: 01727 -SD/PR- 01727
 
{</section>}
 
{<section id="axrt300_06.global" >}
#應用 i02 樣板自動產生(Version:38)
#add-point:填寫註解說明 name="global.memo"
#150821-00002#1   2015/08/21  By 01727    1.s_curr_round、s_num_round改為s_curr_round_ld
#                                         2.檢查原幣的取位,幣別應傳入原幣;本幣的取位,幣別應傳入本幣

#150916-00015#1   2015/11/30  By taozf    当有账套时，科目检查改为检查是否存在于glad_t中
#160318-00005#53  2016/04/01  By pengxin  修正azzi920重复定义之错误讯息
#150203-00010#4   2016/04/11  By 01727    沖暫估:
#                                         1.要能自行維護新增,刪除內容
#                                         2.沖暫估子作業離開時,參數=未稅立暫估, 則"本幣"總額比較,計算價差,產生一筆DIFF 
#                                           單身有勾暫估的總額- 沖暫估明細的總額
#                                         3. 沖暫估單開窗,可挑選 暫估單號 xrcc_t (不要顯示單身明細)
#                                         4. 開啟子作業時, 若無xrcf_t的資料, 則CALL批次產生, 先產生數據
#                                         5.子作業加menu功能:  整批刪除, 自動產生
#                                         6.自動產生時,依原處理原則不變, 一旦進入沖暫估子作業修改時,則xrcfseq不再與單身項次作關連,純為序號處理。
#160318-00025#13  2016/04/15  By 07673    將重複內容的錯誤訊息置換為公用錯誤訊息
#160816-00014#1   2016/08/22  By 01727    含稅立沖暫估規格優化
#160816-00014#3   2016/09/02  By 01727    含稅立沖暫估規格優化
#161128-00061#4   2016/12/02  by 02481    标准程式定义采用宣告模式,弃用.*写法
#161212-00024#1   2016/12/12  By 01727    产生分录底稿段需要开启事物;差异为0时不产生差异资料

#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
GLOBALS   #(ver:36) add
   DEFINE mc_data_owner_check LIKE type_t.num5   #(ver:36) add
END GLOBALS   #(ver:36) add
 
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
#單身 type 宣告
PRIVATE TYPE type_g_xrcf_d RECORD
       xrcfdocno LIKE xrcf_t.xrcfdocno, 
   xrcfld LIKE xrcf_t.xrcfld, 
   xrcfseq2 LIKE xrcf_t.xrcfseq2, 
   xrcfseq LIKE xrcf_t.xrcfseq, 
   xrca001_desc LIKE type_t.chr500, 
   xrcf008 LIKE xrcf_t.xrcf008, 
   xrcf009 LIKE xrcf_t.xrcf009, 
   xrcf021 LIKE xrcf_t.xrcf021, 
   xrcf021_1_desc LIKE type_t.chr500, 
   xrcf007 LIKE xrcf_t.xrcf007, 
   xrcf101 LIKE xrcf_t.xrcf101, 
   xrcf103 LIKE xrcf_t.xrcf103, 
   xrcf104 LIKE xrcf_t.xrcf104, 
   xrcf105 LIKE xrcf_t.xrcf105, 
   xrcf106 LIKE xrcf_t.xrcf106, 
   xrcf102 LIKE xrcf_t.xrcf102, 
   xrcf111 LIKE xrcf_t.xrcf111, 
   xrcf113 LIKE xrcf_t.xrcf113, 
   xrcf114 LIKE xrcf_t.xrcf114, 
   xrcf115 LIKE xrcf_t.xrcf115, 
   xrcf116 LIKE xrcf_t.xrcf116, 
   xrcf117 LIKE xrcf_t.xrcf117
       END RECORD
PRIVATE TYPE type_g_xrcf2_d RECORD
       xrcfdocno LIKE xrcf_t.xrcfdocno, 
   xrcfld LIKE xrcf_t.xrcfld, 
   xrcfseq LIKE xrcf_t.xrcfseq, 
   xrcfseq2 LIKE xrcf_t.xrcfseq2, 
   xrcf022 LIKE xrcf_t.xrcf022, 
   xrcf022_desc LIKE type_t.chr500, 
   xrcf024 LIKE xrcf_t.xrcf024, 
   xrcf024_desc LIKE type_t.chr500, 
   xrcf025 LIKE xrcf_t.xrcf025, 
   xrcf025_desc LIKE type_t.chr500
       END RECORD
PRIVATE TYPE type_g_xrcf3_d RECORD
       xrcfdocno LIKE xrcf_t.xrcfdocno, 
   xrcfld LIKE xrcf_t.xrcfld, 
   xrcfseq LIKE xrcf_t.xrcfseq, 
   xrcfseq2 LIKE xrcf_t.xrcfseq2, 
   xrcf105 LIKE xrcf_t.xrcf105, 
   xrcf102 LIKE xrcf_t.xrcf102, 
   xrcf115 LIKE xrcf_t.xrcf115, 
   xrcf122 LIKE xrcf_t.xrcf122, 
   xrcf122_desc LIKE type_t.chr500, 
   xrcf123 LIKE xrcf_t.xrcf123, 
   xrcf124 LIKE xrcf_t.xrcf124, 
   xrcf125 LIKE xrcf_t.xrcf125, 
   xrcf126 LIKE xrcf_t.xrcf126, 
   xrcf127 LIKE xrcf_t.xrcf127, 
   xrcf132 LIKE xrcf_t.xrcf132, 
   xrcf132_desc LIKE type_t.chr500, 
   xrcf133 LIKE xrcf_t.xrcf133, 
   xrcf134 LIKE xrcf_t.xrcf134, 
   xrcf135 LIKE xrcf_t.xrcf135, 
   xrcf136 LIKE xrcf_t.xrcf136, 
   xrcf137 LIKE xrcf_t.xrcf137
       END RECORD
PRIVATE TYPE type_g_xrcf4_d RECORD
       xrcfdocno LIKE xrcf_t.xrcfdocno, 
   xrcfld LIKE xrcf_t.xrcfld, 
   xrcfseq LIKE xrcf_t.xrcfseq, 
   xrcfseq2 LIKE xrcf_t.xrcfseq2, 
   xrcf049 LIKE xrcf_t.xrcf049, 
   xrcf021 LIKE xrcf_t.xrcf021, 
   xrcf021_desc LIKE type_t.chr500, 
   xrcf023 LIKE xrcf_t.xrcf023, 
   xrcf023_desc LIKE type_t.chr500, 
   xrcf033 LIKE xrcf_t.xrcf033, 
   xrcf033_desc LIKE type_t.chr500, 
   xrcf026 LIKE xrcf_t.xrcf026, 
   xrcf026_desc LIKE type_t.chr500, 
   xrcf027 LIKE xrcf_t.xrcf027, 
   xrcf027_desc LIKE type_t.chr500, 
   xrcf028 LIKE xrcf_t.xrcf028, 
   xrcf028_desc LIKE type_t.chr500, 
   xrcf031 LIKE xrcf_t.xrcf031, 
   xrcf031_desc LIKE type_t.chr500, 
   xrcf032 LIKE xrcf_t.xrcf032, 
   xrcf032_desc LIKE type_t.chr500, 
   xrcf034 LIKE xrcf_t.xrcf034, 
   xrcf034_desc LIKE type_t.chr500, 
   xrcf035 LIKE xrcf_t.xrcf035, 
   xrcf035_desc LIKE type_t.chr500, 
   xrcf036 LIKE xrcf_t.xrcf036, 
   xrcf037 LIKE xrcf_t.xrcf037, 
   xrcf037_desc LIKE type_t.chr500, 
   xrcf038 LIKE xrcf_t.xrcf038, 
   xrcf038_desc LIKE type_t.chr500, 
   xrcf039 LIKE xrcf_t.xrcf039, 
   xrcf039_desc LIKE type_t.chr500, 
   xrcf040 LIKE xrcf_t.xrcf040, 
   xrcf040_desc LIKE type_t.chr500, 
   xrcf041 LIKE xrcf_t.xrcf041, 
   xrcf041_desc LIKE type_t.chr500, 
   xrcf042 LIKE xrcf_t.xrcf042, 
   xrcf042_desc LIKE type_t.chr500, 
   xrcf043 LIKE xrcf_t.xrcf043, 
   xrcf043_desc LIKE type_t.chr500, 
   xrcf044 LIKE xrcf_t.xrcf044, 
   xrcf044_desc LIKE type_t.chr500, 
   xrcf045 LIKE xrcf_t.xrcf045, 
   xrcf045_desc LIKE type_t.chr500, 
   xrcf046 LIKE xrcf_t.xrcf046, 
   xrcf046_desc LIKE type_t.chr500, 
   xrcf047 LIKE xrcf_t.xrcf047, 
   xrcf047_desc LIKE type_t.chr500, 
   xrcf048 LIKE xrcf_t.xrcf048, 
   xrcf048_desc LIKE type_t.chr500
       END RECORD
PRIVATE TYPE type_g_xrcf5_d RECORD
       xrcfdocno LIKE xrcf_t.xrcfdocno, 
   xrcfld LIKE xrcf_t.xrcfld, 
   xrcfseq LIKE xrcf_t.xrcfseq, 
   xrcfseq2 LIKE xrcf_t.xrcfseq2, 
   xrcf001 LIKE xrcf_t.xrcf001, 
   xrcf002 LIKE xrcf_t.xrcf002, 
   xrcf010 LIKE xrcf_t.xrcf010, 
   xrcf020 LIKE xrcf_t.xrcf020, 
   xrcf029 LIKE xrcf_t.xrcf029, 
   xrcf030 LIKE xrcf_t.xrcf030, 
   xrcforga LIKE xrcf_t.xrcforga
       END RECORD
 
 
 
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_xrcadocno          LIKE xrca_t.xrcadocno
DEFINE g_xrcald             LIKE xrca_t.xrcald
DEFINE g_xrcadocdt          LIKE xrca_t.xrcadocdt
#161128-00061#4---mdofiy--begin---------
#DEFINE g_glaa               RECORD LIKE glaa_t.*
#DEFINE g_glad               RECORD LIKE glad_t.*
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

#161128-00061#4---mdofiy--begin---------
DEFINE g_xrcf007            LIKE xrcf_t.xrcf007
DEFINE g_xrcf103            LIKE xrcf_t.xrcf103
DEFINE g_xrcf104            LIKE xrcf_t.xrcf104
DEFINE g_xrcf105            LIKE xrcf_t.xrcf105
DEFINE g_xrcf113            LIKE xrcf_t.xrcf113
DEFINE g_xrcf114            LIKE xrcf_t.xrcf114
DEFINE g_xrcf115            LIKE xrcf_t.xrcf115
DEFINE g_xrcf123            LIKE xrcf_t.xrcf123
DEFINE g_xrcf124            LIKE xrcf_t.xrcf124
DEFINE g_xrcf125            LIKE xrcf_t.xrcf125
DEFINE g_xrcf133            LIKE xrcf_t.xrcf133
DEFINE g_xrcf134            LIKE xrcf_t.xrcf134
DEFINE g_xrcf135            LIKE xrcf_t.xrcf135
DEFINE g_glae009            LIKE glae_t.glae009
DEFINE g_glae002            LIKE glae_t.glae002
#150203-00010#4 Add ---(S)---
 TYPE type_diff RECORD
       xrcf103      LIKE xrcf_t.xrcf103,
       xrcf104      LIKE xrcf_t.xrcf104,
       xrcf105      LIKE xrcf_t.xrcf105,
       xrcf113      LIKE xrcf_t.xrcf113,
       xrcf114      LIKE xrcf_t.xrcf114,
       xrcf115      LIKE xrcf_t.xrcf115,
       xrcf123      LIKE xrcf_t.xrcf123,
       xrcf124      LIKE xrcf_t.xrcf124,
       xrcf125      LIKE xrcf_t.xrcf125,
       xrcf133      LIKE xrcf_t.xrcf133,
       xrcf134      LIKE xrcf_t.xrcf134,
       xrcf135      LIKE xrcf_t.xrcf135
       END RECORD
PRIVATE TYPE type_xrcf RECORD
       xrcfent        LIKE xrcf_t.xrcfent,
       xrcfld         LIKE xrcf_t.xrcfld,
       xrcfdocno      LIKE xrcf_t.xrcfdocno,
       xrcfseq        LIKE xrcf_t.xrcfseq,
       xrcfseq2       LIKE xrcf_t.xrcfseq2,
       xrcf001        LIKE xrcf_t.xrcf001,
       xrcf002        LIKE xrcf_t.xrcf002,
       xrcf007        LIKE xrcf_t.xrcf007,
       xrcf008        LIKE xrcf_t.xrcf008,
       xrcf009        LIKE xrcf_t.xrcf009,
       xrcf010        LIKE xrcf_t.xrcf010,
       xrcf020        LIKE xrcf_t.xrcf020,
       xrcf021        LIKE xrcf_t.xrcf021,
       xrcf022        LIKE xrcf_t.xrcf022,
       xrcf023        LIKE xrcf_t.xrcf023,
       xrcf024        LIKE xrcf_t.xrcf024,
       xrcf025        LIKE xrcf_t.xrcf025,
       xrcforga       LIKE xrcf_t.xrcforga,
       xrcf026        LIKE xrcf_t.xrcf026,
       xrcf027        LIKE xrcf_t.xrcf027,
       xrcf028        LIKE xrcf_t.xrcf028,
       xrcf029        LIKE xrcf_t.xrcf029,
       xrcf030        LIKE xrcf_t.xrcf030,
       xrcf031        LIKE xrcf_t.xrcf031,
       xrcf032        LIKE xrcf_t.xrcf032,
       xrcf033        LIKE xrcf_t.xrcf033,
       xrcf034        LIKE xrcf_t.xrcf034,
       xrcf035        LIKE xrcf_t.xrcf035,
       xrcf036        LIKE xrcf_t.xrcf036,
       xrcf037        LIKE xrcf_t.xrcf037,
       xrcf038        LIKE xrcf_t.xrcf038,
       xrcf039        LIKE xrcf_t.xrcf039,
       xrcf040        LIKE xrcf_t.xrcf040,
       xrcf041        LIKE xrcf_t.xrcf041,
       xrcf042        LIKE xrcf_t.xrcf042,
       xrcf043        LIKE xrcf_t.xrcf043,
       xrcf044        LIKE xrcf_t.xrcf044,
       xrcf045        LIKE xrcf_t.xrcf045,
       xrcf046        LIKE xrcf_t.xrcf046,
       xrcf047        LIKE xrcf_t.xrcf047,
       xrcf048        LIKE xrcf_t.xrcf048,
       xrcf049        LIKE xrcf_t.xrcf049,
       xrcf101        LIKE xrcf_t.xrcf101,
       xrcf102        LIKE xrcf_t.xrcf102,
       xrcf103        LIKE xrcf_t.xrcf103,
       xrcf104        LIKE xrcf_t.xrcf104,
       xrcf105        LIKE xrcf_t.xrcf105,
       xrcf106        LIKE xrcf_t.xrcf106,
       xrcf111        LIKE xrcf_t.xrcf111,
       xrcf113        LIKE xrcf_t.xrcf113,
       xrcf114        LIKE xrcf_t.xrcf114,
       xrcf115        LIKE xrcf_t.xrcf115,
       xrcf116        LIKE xrcf_t.xrcf116,
       xrcf117        LIKE xrcf_t.xrcf117,
       xrcf122        LIKE xrcf_t.xrcf122,
       xrcf123        LIKE xrcf_t.xrcf123,
       xrcf124        LIKE xrcf_t.xrcf124,
       xrcf125        LIKE xrcf_t.xrcf125,
       xrcf126        LIKE xrcf_t.xrcf126,
       xrcf127        LIKE xrcf_t.xrcf127,
       xrcf132        LIKE xrcf_t.xrcf132,
       xrcf133        LIKE xrcf_t.xrcf133,
       xrcf134        LIKE xrcf_t.xrcf134,
       xrcf135        LIKE xrcf_t.xrcf135,
       xrcf136        LIKE xrcf_t.xrcf136,
       xrcf137        LIKE xrcf_t.xrcf137
       END RECORD
#150203-00010#4 Add ---(E)---
#end add-point
 
#模組變數(Module Variables)
DEFINE g_xrcf_d          DYNAMIC ARRAY OF type_g_xrcf_d #單身變數
DEFINE g_xrcf_d_t        type_g_xrcf_d                  #單身備份
DEFINE g_xrcf_d_o        type_g_xrcf_d                  #單身備份
DEFINE g_xrcf_d_mask_o   DYNAMIC ARRAY OF type_g_xrcf_d #單身變數
DEFINE g_xrcf_d_mask_n   DYNAMIC ARRAY OF type_g_xrcf_d #單身變數
DEFINE g_xrcf2_d   DYNAMIC ARRAY OF type_g_xrcf2_d
DEFINE g_xrcf2_d_t type_g_xrcf2_d
DEFINE g_xrcf2_d_o type_g_xrcf2_d
DEFINE g_xrcf2_d_mask_o DYNAMIC ARRAY OF type_g_xrcf2_d
DEFINE g_xrcf2_d_mask_n DYNAMIC ARRAY OF type_g_xrcf2_d
DEFINE g_xrcf3_d   DYNAMIC ARRAY OF type_g_xrcf3_d
DEFINE g_xrcf3_d_t type_g_xrcf3_d
DEFINE g_xrcf3_d_o type_g_xrcf3_d
DEFINE g_xrcf3_d_mask_o DYNAMIC ARRAY OF type_g_xrcf3_d
DEFINE g_xrcf3_d_mask_n DYNAMIC ARRAY OF type_g_xrcf3_d
DEFINE g_xrcf4_d   DYNAMIC ARRAY OF type_g_xrcf4_d
DEFINE g_xrcf4_d_t type_g_xrcf4_d
DEFINE g_xrcf4_d_o type_g_xrcf4_d
DEFINE g_xrcf4_d_mask_o DYNAMIC ARRAY OF type_g_xrcf4_d
DEFINE g_xrcf4_d_mask_n DYNAMIC ARRAY OF type_g_xrcf4_d
DEFINE g_xrcf5_d   DYNAMIC ARRAY OF type_g_xrcf5_d
DEFINE g_xrcf5_d_t type_g_xrcf5_d
DEFINE g_xrcf5_d_o type_g_xrcf5_d
DEFINE g_xrcf5_d_mask_o DYNAMIC ARRAY OF type_g_xrcf5_d
DEFINE g_xrcf5_d_mask_n DYNAMIC ARRAY OF type_g_xrcf5_d
 
      
DEFINE g_wc2                STRING
DEFINE g_sql                STRING
DEFINE g_forupd_sql         STRING                        #SELECT ... FOR UPDATE SQL
DEFINE g_before_input_done  LIKE type_t.num5
DEFINE g_cnt                LIKE type_t.num10    
DEFINE l_ac                 LIKE type_t.num10             #目前處理的ARRAY CNT 
DEFINE g_curr_diag          ui.Dialog                     #Current Dialog
DEFINE gwin_curr            ui.Window                     #Current Window
DEFINE gfrm_curr            ui.Form                       #Current Form
DEFINE g_temp_idx           LIKE type_t.num10             #單身 所在筆數(暫存用)
DEFINE g_detail_idx         LIKE type_t.num10             #單身 所在筆數(所有資料)
DEFINE g_detail_cnt         LIKE type_t.num10             #單身 總筆數(所有資料)
DEFINE g_ref_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars           DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys              DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak          DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_insert             LIKE type_t.chr5              #是否導到其他page
DEFINE g_error_show         LIKE type_t.num5
DEFINE g_chk                BOOLEAN
DEFINE g_aw                 STRING                        #確定當下點擊的單身
DEFINE g_log1               STRING                        #log用
DEFINE g_log2               STRING                        #log用
 
#多table用wc
DEFINE g_wc_table           STRING
 
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="axrt300_06.main" >}
#應用 a27 樣板自動產生(Version:6)
#+ 作業開始(子程式類型)
PUBLIC FUNCTION axrt300_06(--)
   #add-point:main段變數傳入 name="main.get_var"
   p_xrcadocno,p_ld
   #end add-point
   )
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE p_xrcadocno         LIKE xrca_t.xrcadocno
   DEFINE p_ld                LIKE xrca_t.xrcald
   #end add-point   
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:作業初始化 name="main.init"
   LET g_xrcadocno = p_xrcadocno
   LET g_xrcald    = p_ld
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
 
   
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT xrcfdocno,xrcfld,xrcfseq2,xrcfseq,xrcf008,xrcf009,xrcf021,xrcf007,xrcf101, 
       xrcf103,xrcf104,xrcf105,xrcf106,xrcf102,xrcf111,xrcf113,xrcf114,xrcf115,xrcf116,xrcf117,xrcfdocno, 
       xrcfld,xrcfseq,xrcfseq2,xrcf022,xrcf024,xrcf025,xrcfdocno,xrcfld,xrcfseq,xrcfseq2,xrcf105,xrcf102, 
       xrcf115,xrcf122,xrcf123,xrcf124,xrcf125,xrcf126,xrcf127,xrcf132,xrcf133,xrcf134,xrcf135,xrcf136, 
       xrcf137,xrcfdocno,xrcfld,xrcfseq,xrcfseq2,xrcf049,xrcf021,xrcf023,xrcf033,xrcf026,xrcf027,xrcf028, 
       xrcf031,xrcf032,xrcf034,xrcf035,xrcf036,xrcf037,xrcf038,xrcf039,xrcf040,xrcf041,xrcf042,xrcf043, 
       xrcf044,xrcf045,xrcf046,xrcf047,xrcf048,xrcfdocno,xrcfld,xrcfseq,xrcfseq2,xrcf001,xrcf002,xrcf010, 
       xrcf020,xrcf029,xrcf030,xrcforga FROM xrcf_t WHERE xrcfent=? AND xrcfld=? AND xrcfdocno=? AND  
       xrcfseq=? AND xrcfseq2=? FOR UPDATE"
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axrt300_06_bcl CURSOR FROM g_forupd_sql
 
 
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_axrt300_06 WITH FORM cl_ap_formpath("axr","axrt300_06")
   
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   #程式初始化
   CALL axrt300_06_init()   
 
   #進入選單 Menu (="N")
   CALL axrt300_06_ui_dialog() 
 
   #畫面關閉
   CLOSE WINDOW w_axrt300_06
 
   
   
 
   #add-point:離開前 name="main.exit"
   
   #end add-point
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axrt300_06.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION axrt300_06_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_xrcastus      LIKE xrca_t.xrcastus
   DEFINE l_count         LIKE type_t.num5    #150203-00010#4 Add
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   
   
   LET g_error_show = 1
   
   #add-point:畫面資料初始化 name="init.init"
   #161128-00061#4-----modify--begin----------
   #SELECT * INTO g_glaa.* 
    SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,
           glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,glaa011,
           glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,glaa023,
           glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,glaa113,glaa120,glaa121,
           glaa122,glaa027,glaa130,glaa131,glaa132,glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,
           glaa140,glaa123,glaa124,glaa028 INTO g_glaa.* 
   #161128-00061#4----modify--end----------
   FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_xrcald
   SELECT xrcadocdt INTO g_xrcadocdt FROM xrca_t WHERE xrcaent = g_enterprise
      AND xrcadocno = g_xrcadocno AND xrcald = g_xrcald
   IF g_glaa.glaa015 = 'N' AND g_glaa.glaa019 = 'N' THEN
      CALL cl_set_comp_visible('bpage_3_06',FALSE)
   END IF
   CALL cl_set_combo_scc('xrca001_desc','8302')
   CALL cl_set_combo_scc('xrcf036','6013')
   SELECT xrcastus INTO l_xrcastus FROM xrca_t WHERE xrcaent = g_enterprise
      AND xrcadocno = g_xrcadocno AND xrcald = g_xrcald
   IF l_xrcastus <> 'N' THEN
      CALL cl_set_toolbaritem_visible("execute_add",FALSE)
      CALL cl_set_toolbaritem_visible("execute_del",FALSE)
   END IF
   #150203-00010#4 Add  ---(S)---
   LET l_count = 0
   SELECT COUNT(1) INTO l_count FROM xrcf_t WHERE xrcfent = g_enterprise
      AND xrcfdocno = g_xrcadocno
      AND xrcfld    = g_xrcald
   IF cl_null(l_count) THEN LET l_count = 0 END IF
   IF l_count = 0 THEN
      CALL axrt300_06_execuet('1')
   END IF
   #150203-00010#4 Add  ---(E)---
   #end add-point
   
   CALL axrt300_06_default_search()
   
END FUNCTION
 
{</section>}
 
{<section id="axrt300_06.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION axrt300_06_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_idx   LIKE type_t.num10
   DEFINE la_param  RECORD #串查用
             prog   STRING,
             param  DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE ls_js     STRING
   DEFINE l_cmd_token           base.StringTokenizer   #報表作業cmdrun使用 
   DEFINE l_cmd_next            STRING                 #報表作業cmdrun使用
   DEFINE l_cmd_cnt             LIKE type_t.num5       #報表作業cmdrun使用
   DEFINE l_cmd_prog_arg        STRING                 #報表作業cmdrun使用
   DEFINE l_cmd_arg             STRING                 #報表作業cmdrun使用
   #add-point:ui_dialog段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_dialog.define"
   DEFINE l_stus   LIKE xrca_t.xrcastus
   #end add-point 
   
   #add-point:Function前置處理  name="ui_dialog.pre_function"
   
   #end add-point
   
   LET g_action_choice = " "  
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()      
 
   CALL cl_set_act_visible("accept,cancel", FALSE)
   
   LET g_detail_idx = 1
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   SELECT xrcastus INTO l_stus FROM xrca_t WHERE xrcaent = g_enterprise
      AND xrcadocno = g_xrcadocno
      AND xrcald    = g_xrcald
   #end add-point
   
   WHILE TRUE
   
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_xrcf_d.clear()
         CALL g_xrcf2_d.clear()
         CALL g_xrcf3_d.clear()
         CALL g_xrcf4_d.clear()
         CALL g_xrcf5_d.clear()
 
         LET g_wc2 = ' 1=2'
         LET g_action_choice = ""
         CALL axrt300_06_init()
      END IF
   
      CALL axrt300_06_b_fill(g_wc2)
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_xrcf_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               #add-point:ui_dialog段before display  name="ui_dialog.body.before_display"
               
               #end add-point
               #讓各頁籤能夠同步指到特定資料
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               #add-point:ui_dialog段before display2 name="ui_dialog.body.before_display2"
               
               #end add-point
               
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               LET g_temp_idx = l_ac
               DISPLAY g_detail_idx TO FORMONLY.idx
               CALL cl_show_fld_cont() 
               #顯示followup圖示
               #應用 a48 樣板自動產生(Version:3)
   CALL axrt300_06_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
               #add-point:display array-before row name="ui_dialog.before_row"
               
               #end add-point
         
            #自訂ACTION(detail_show,page_1)
            
               
         END DISPLAY
      
         DISPLAY ARRAY g_xrcf2_d TO s_detail2.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               #add-point:ui_dialog段before display  name="ui_dialog.body2.before_display"
               
               #end add-point
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               #add-point:ui_dialog段before display2 name="ui_dialog.body2.before_display2"
               
               #end add-point
         
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx
               LET g_temp_idx = l_ac
               DISPLAY g_detail_idx TO FORMONLY.idx
               CALL cl_show_fld_cont() 
               #顯示followup圖示
               #應用 a48 樣板自動產生(Version:3)
   CALL axrt300_06_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
               #add-point:display array-before row name="ui_dialog.before_row2"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_2)
            
               
         END DISPLAY
         DISPLAY ARRAY g_xrcf3_d TO s_detail3.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               #add-point:ui_dialog段before display  name="ui_dialog.body3.before_display"
               
               #end add-point
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               #add-point:ui_dialog段before display2 name="ui_dialog.body3.before_display2"
               
               #end add-point
         
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail3")
               LET l_ac = g_detail_idx
               LET g_temp_idx = l_ac
               DISPLAY g_detail_idx TO FORMONLY.idx
               CALL cl_show_fld_cont() 
               #顯示followup圖示
               #應用 a48 樣板自動產生(Version:3)
   CALL axrt300_06_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
               #add-point:display array-before row name="ui_dialog.before_row3"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_3)
            
               
         END DISPLAY
         DISPLAY ARRAY g_xrcf4_d TO s_detail4.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               #add-point:ui_dialog段before display  name="ui_dialog.body4.before_display"
               
               #end add-point
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               #add-point:ui_dialog段before display2 name="ui_dialog.body4.before_display2"
               
               #end add-point
         
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail4")
               LET l_ac = g_detail_idx
               LET g_temp_idx = l_ac
               DISPLAY g_detail_idx TO FORMONLY.idx
               CALL cl_show_fld_cont() 
               #顯示followup圖示
               #應用 a48 樣板自動產生(Version:3)
   CALL axrt300_06_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
               #add-point:display array-before row name="ui_dialog.before_row4"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_4)
            
               
         END DISPLAY
         DISPLAY ARRAY g_xrcf5_d TO s_detail5.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               #add-point:ui_dialog段before display  name="ui_dialog.body5.before_display"
               
               #end add-point
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               #add-point:ui_dialog段before display2 name="ui_dialog.body5.before_display2"
               
               #end add-point
         
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail5")
               LET l_ac = g_detail_idx
               LET g_temp_idx = l_ac
               DISPLAY g_detail_idx TO FORMONLY.idx
               CALL cl_show_fld_cont() 
               #顯示followup圖示
               #應用 a48 樣板自動產生(Version:3)
   CALL axrt300_06_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
               #add-point:display array-before row name="ui_dialog.before_row5"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_5)
            
               
         END DISPLAY
 
      
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
    
         BEFORE DIALOG
            IF g_temp_idx > 0 THEN
               LET l_ac = g_temp_idx
               CALL DIALOG.setCurrentRow("s_detail1",l_ac)
               LET g_temp_idx = 1
            END IF
            LET g_curr_diag = ui.DIALOG.getCurrent()         
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            CALL DIALOG.setSelectionMode("s_detail2", 1)
            CALL DIALOG.setSelectionMode("s_detail3", 1)
            CALL DIALOG.setSelectionMode("s_detail4", 1)
            CALL DIALOG.setSelectionMode("s_detail5", 1)
 
            #add-point:ui_dialog段before name="ui_dialog.b_dialog"
            IF l_stus <> 'N' THEN
               CALL cl_set_act_visible("insert,modify,delete,modify_detail", FALSE)
            ELSE
               CALL cl_set_act_visible("insert,modify,delete,modify_detail", TRUE)
            END IF
            #end add-point
            NEXT FIELD CURRENT
      
         
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify
            LET g_action_choice="modify"
            LET g_aw = ''
            CALL axrt300_06_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL axrt300_06_modify()
            #add-point:ON ACTION modify name="menu.modify"
            
            #END add-point
            
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            LET g_aw = g_curr_diag.getCurrentItem()
            CALL axrt300_06_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL axrt300_06_modify()
            #add-point:ON ACTION modify_detail name="menu.modify_detail"
            
            #END add-point
            
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION execute_del
            LET g_action_choice="execute_del"
            IF cl_auth_chk_act("execute_del") THEN
               
               #add-point:ON ACTION execute_del name="menu.execute_del"
               #整批刪除
               CALL axrt300_06_execuet('2')
               CALL axrt300_06_b_fill('')  
               #END add-point
               
            END IF
 
 
 
 
         #應用 a67 樣板自動產生(Version:1)
         ON ACTION delete
            LET g_action_choice="delete"
            CALL axrt300_06_show_ownid_msg()
            #因為不呼叫cl_auth_chk_act()，所以需另外紀錄log，
            #但紀錄log時需紀錄status，與鴻傑討論後，決議先一律紀錄成功
            CALL cl_log_act(g_action_choice,TRUE)
            CALL axrt300_06_delete()
            #add-point:ON ACTION delete name="menu.delete"
            
            #END add-point
            
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL axrt300_06_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL axrt300_06_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
               CALL g_curr_diag.setCurrentRow("s_detail3",1)
               CALL g_curr_diag.setCurrentRow("s_detail4",1)
               CALL g_curr_diag.setCurrentRow("s_detail5",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION execute_add
            LET g_action_choice="execute_add"
            IF cl_auth_chk_act("execute_add") THEN
               
               #add-point:ON ACTION execute_add name="menu.execute_add"
               #整批刪除
               CALL axrt300_06_execuet('1')
               CALL axrt300_06_b_fill('')  
               #END add-point
               
            END IF
 
 
 
 
      
         ON ACTION exporttoexcel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_xrcf_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_xrcf2_d)
               LET g_export_id[2]   = "s_detail2"
               LET g_export_node[3] = base.typeInfo.create(g_xrcf3_d)
               LET g_export_id[3]   = "s_detail3"
               LET g_export_node[4] = base.typeInfo.create(g_xrcf4_d)
               LET g_export_id[4]   = "s_detail4"
               LET g_export_node[5] = base.typeInfo.create(g_xrcf5_d)
               LET g_export_id[5]   = "s_detail5"
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
            
         ON ACTION close
            LET INT_FLAG=FALSE         
            LET g_action_choice="exit"
            CANCEL DIALOG
      
         ON ACTION exit
            LET g_action_choice="exit"
            CANCEL DIALOG
            
         
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL axrt300_06_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL axrt300_06_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL axrt300_06_set_pk_array()
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
      
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         #add-point:ui_dialog段離開dialog前 name="ui_dialog.b_exit"
         
         #end add-point
         EXIT WHILE
      END IF
      
   END WHILE
 
   CALL cl_set_act_visible("accept,cancel", TRUE)
 
END FUNCTION
 
{</section>}
 
{<section id="axrt300_06.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION axrt300_06_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="query.pre_function"
   
   #end add-point
   
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_xrcf_d.clear()
   
   LET g_qryparam.state = "c"
   
   #wc備份
   LET ls_wc = g_wc2
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      CONSTRUCT g_wc2 ON xrcfdocno,xrcfld,xrcfseq2,xrcfseq,xrca001_desc,xrcf008,xrcf009,xrcf021_1_desc, 
          xrcf007,xrcf101,xrcf103,xrcf104,xrcf105,xrcf106,xrcf102,xrcf111,xrcf113,xrcf114,xrcf115,xrcf116, 
          xrcf117,xrcf022,xrcf022_desc,xrcf024,xrcf024_desc,xrcf025,xrcf025_desc,xrcf105_1,xrcf102_1, 
          xrcf115_1,xrcf122,xrcf122_desc,xrcf123,xrcf124,xrcf125,xrcf126,xrcf127,xrcf132,xrcf132_desc, 
          xrcf133,xrcf134,xrcf135,xrcf136,xrcf137,xrcf049,xrcf021,xrcf021_desc,xrcf023,xrcf023_desc, 
          xrcf033,xrcf033_desc,xrcf026,xrcf026_desc,xrcf027,xrcf027_desc,xrcf028,xrcf028_desc,xrcf031, 
          xrcf031_desc,xrcf032,xrcf032_desc,xrcf034,xrcf034_desc,xrcf035,xrcf035_desc,xrcf036,xrcf037, 
          xrcf037_desc,xrcf038,xrcf038_desc,xrcf039,xrcf039_desc,xrcf040,xrcf040_desc,xrcf041,xrcf041_desc, 
          xrcf042,xrcf042_desc,xrcf043,xrcf043_desc,xrcf044,xrcf044_desc,xrcf045,xrcf045_desc,xrcf046, 
          xrcf046_desc,xrcf047,xrcf047_desc,xrcf048,xrcf048_desc,xrcf001,xrcf002,xrcf010,xrcf020,xrcf029, 
          xrcf030,xrcforga 
 
         FROM s_detail1[1].xrcfdocno,s_detail1[1].xrcfld,s_detail1[1].xrcfseq2,s_detail1[1].xrcfseq, 
             s_detail1[1].xrca001_desc,s_detail1[1].xrcf008,s_detail1[1].xrcf009,s_detail1[1].xrcf021_1_desc, 
             s_detail1[1].xrcf007,s_detail1[1].xrcf101,s_detail1[1].xrcf103,s_detail1[1].xrcf104,s_detail1[1].xrcf105, 
             s_detail1[1].xrcf106,s_detail1[1].xrcf102,s_detail1[1].xrcf111,s_detail1[1].xrcf113,s_detail1[1].xrcf114, 
             s_detail1[1].xrcf115,s_detail1[1].xrcf116,s_detail1[1].xrcf117,s_detail2[1].xrcf022,s_detail2[1].xrcf022_desc, 
             s_detail2[1].xrcf024,s_detail2[1].xrcf024_desc,s_detail2[1].xrcf025,s_detail2[1].xrcf025_desc, 
             s_detail3[1].xrcf105_1,s_detail3[1].xrcf102_1,s_detail3[1].xrcf115_1,s_detail3[1].xrcf122, 
             s_detail3[1].xrcf122_desc,s_detail3[1].xrcf123,s_detail3[1].xrcf124,s_detail3[1].xrcf125, 
             s_detail3[1].xrcf126,s_detail3[1].xrcf127,s_detail3[1].xrcf132,s_detail3[1].xrcf132_desc, 
             s_detail3[1].xrcf133,s_detail3[1].xrcf134,s_detail3[1].xrcf135,s_detail3[1].xrcf136,s_detail3[1].xrcf137, 
             s_detail4[1].xrcf049,s_detail4[1].xrcf021,s_detail4[1].xrcf021_desc,s_detail4[1].xrcf023, 
             s_detail4[1].xrcf023_desc,s_detail4[1].xrcf033,s_detail4[1].xrcf033_desc,s_detail4[1].xrcf026, 
             s_detail4[1].xrcf026_desc,s_detail4[1].xrcf027,s_detail4[1].xrcf027_desc,s_detail4[1].xrcf028, 
             s_detail4[1].xrcf028_desc,s_detail4[1].xrcf031,s_detail4[1].xrcf031_desc,s_detail4[1].xrcf032, 
             s_detail4[1].xrcf032_desc,s_detail4[1].xrcf034,s_detail4[1].xrcf034_desc,s_detail4[1].xrcf035, 
             s_detail4[1].xrcf035_desc,s_detail4[1].xrcf036,s_detail4[1].xrcf037,s_detail4[1].xrcf037_desc, 
             s_detail4[1].xrcf038,s_detail4[1].xrcf038_desc,s_detail4[1].xrcf039,s_detail4[1].xrcf039_desc, 
             s_detail4[1].xrcf040,s_detail4[1].xrcf040_desc,s_detail4[1].xrcf041,s_detail4[1].xrcf041_desc, 
             s_detail4[1].xrcf042,s_detail4[1].xrcf042_desc,s_detail4[1].xrcf043,s_detail4[1].xrcf043_desc, 
             s_detail4[1].xrcf044,s_detail4[1].xrcf044_desc,s_detail4[1].xrcf045,s_detail4[1].xrcf045_desc, 
             s_detail4[1].xrcf046,s_detail4[1].xrcf046_desc,s_detail4[1].xrcf047,s_detail4[1].xrcf047_desc, 
             s_detail4[1].xrcf048,s_detail4[1].xrcf048_desc,s_detail5[1].xrcf001,s_detail5[1].xrcf002, 
             s_detail5[1].xrcf010,s_detail5[1].xrcf020,s_detail5[1].xrcf029,s_detail5[1].xrcf030,s_detail5[1].xrcforga  
 
      
         
      
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcfdocno
            #add-point:BEFORE FIELD xrcfdocno name="query.b.page1.xrcfdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcfdocno
            
            #add-point:AFTER FIELD xrcfdocno name="query.a.page1.xrcfdocno"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.xrcfdocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcfdocno
            #add-point:ON ACTION controlp INFIELD xrcfdocno name="query.c.page1.xrcfdocno"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcfld
            #add-point:BEFORE FIELD xrcfld name="query.b.page1.xrcfld"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcfld
            
            #add-point:AFTER FIELD xrcfld name="query.a.page1.xrcfld"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.xrcfld
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcfld
            #add-point:ON ACTION controlp INFIELD xrcfld name="query.c.page1.xrcfld"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcfseq2
            #add-point:BEFORE FIELD xrcfseq2 name="query.b.page1.xrcfseq2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcfseq2
            
            #add-point:AFTER FIELD xrcfseq2 name="query.a.page1.xrcfseq2"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.xrcfseq2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcfseq2
            #add-point:ON ACTION controlp INFIELD xrcfseq2 name="query.c.page1.xrcfseq2"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcfseq
            #add-point:BEFORE FIELD xrcfseq name="query.b.page1.xrcfseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcfseq
            
            #add-point:AFTER FIELD xrcfseq name="query.a.page1.xrcfseq"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.xrcfseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcfseq
            #add-point:ON ACTION controlp INFIELD xrcfseq name="query.c.page1.xrcfseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca001_desc
            #add-point:BEFORE FIELD xrca001_desc name="query.b.page1.xrca001_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca001_desc
            
            #add-point:AFTER FIELD xrca001_desc name="query.a.page1.xrca001_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.xrca001_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca001_desc
            #add-point:ON ACTION controlp INFIELD xrca001_desc name="query.c.page1.xrca001_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf008
            #add-point:BEFORE FIELD xrcf008 name="query.b.page1.xrcf008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf008
            
            #add-point:AFTER FIELD xrcf008 name="query.a.page1.xrcf008"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.xrcf008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf008
            #add-point:ON ACTION controlp INFIELD xrcf008 name="query.c.page1.xrcf008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf009
            #add-point:BEFORE FIELD xrcf009 name="query.b.page1.xrcf009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf009
            
            #add-point:AFTER FIELD xrcf009 name="query.a.page1.xrcf009"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.xrcf009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf009
            #add-point:ON ACTION controlp INFIELD xrcf009 name="query.c.page1.xrcf009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf021_1_desc
            #add-point:BEFORE FIELD xrcf021_1_desc name="query.b.page1.xrcf021_1_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf021_1_desc
            
            #add-point:AFTER FIELD xrcf021_1_desc name="query.a.page1.xrcf021_1_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.xrcf021_1_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf021_1_desc
            #add-point:ON ACTION controlp INFIELD xrcf021_1_desc name="query.c.page1.xrcf021_1_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf007
            #add-point:BEFORE FIELD xrcf007 name="query.b.page1.xrcf007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf007
            
            #add-point:AFTER FIELD xrcf007 name="query.a.page1.xrcf007"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.xrcf007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf007
            #add-point:ON ACTION controlp INFIELD xrcf007 name="query.c.page1.xrcf007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf101
            #add-point:BEFORE FIELD xrcf101 name="query.b.page1.xrcf101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf101
            
            #add-point:AFTER FIELD xrcf101 name="query.a.page1.xrcf101"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.xrcf101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf101
            #add-point:ON ACTION controlp INFIELD xrcf101 name="query.c.page1.xrcf101"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf103
            #add-point:BEFORE FIELD xrcf103 name="query.b.page1.xrcf103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf103
            
            #add-point:AFTER FIELD xrcf103 name="query.a.page1.xrcf103"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.xrcf103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf103
            #add-point:ON ACTION controlp INFIELD xrcf103 name="query.c.page1.xrcf103"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf104
            #add-point:BEFORE FIELD xrcf104 name="query.b.page1.xrcf104"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf104
            
            #add-point:AFTER FIELD xrcf104 name="query.a.page1.xrcf104"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.xrcf104
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf104
            #add-point:ON ACTION controlp INFIELD xrcf104 name="query.c.page1.xrcf104"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf105
            #add-point:BEFORE FIELD xrcf105 name="query.b.page1.xrcf105"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf105
            
            #add-point:AFTER FIELD xrcf105 name="query.a.page1.xrcf105"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.xrcf105
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf105
            #add-point:ON ACTION controlp INFIELD xrcf105 name="query.c.page1.xrcf105"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf106
            #add-point:BEFORE FIELD xrcf106 name="query.b.page1.xrcf106"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf106
            
            #add-point:AFTER FIELD xrcf106 name="query.a.page1.xrcf106"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.xrcf106
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf106
            #add-point:ON ACTION controlp INFIELD xrcf106 name="query.c.page1.xrcf106"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf102
            #add-point:BEFORE FIELD xrcf102 name="query.b.page1.xrcf102"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf102
            
            #add-point:AFTER FIELD xrcf102 name="query.a.page1.xrcf102"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.xrcf102
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf102
            #add-point:ON ACTION controlp INFIELD xrcf102 name="query.c.page1.xrcf102"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf111
            #add-point:BEFORE FIELD xrcf111 name="query.b.page1.xrcf111"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf111
            
            #add-point:AFTER FIELD xrcf111 name="query.a.page1.xrcf111"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.xrcf111
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf111
            #add-point:ON ACTION controlp INFIELD xrcf111 name="query.c.page1.xrcf111"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf113
            #add-point:BEFORE FIELD xrcf113 name="query.b.page1.xrcf113"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf113
            
            #add-point:AFTER FIELD xrcf113 name="query.a.page1.xrcf113"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.xrcf113
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf113
            #add-point:ON ACTION controlp INFIELD xrcf113 name="query.c.page1.xrcf113"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf114
            #add-point:BEFORE FIELD xrcf114 name="query.b.page1.xrcf114"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf114
            
            #add-point:AFTER FIELD xrcf114 name="query.a.page1.xrcf114"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.xrcf114
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf114
            #add-point:ON ACTION controlp INFIELD xrcf114 name="query.c.page1.xrcf114"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf115
            #add-point:BEFORE FIELD xrcf115 name="query.b.page1.xrcf115"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf115
            
            #add-point:AFTER FIELD xrcf115 name="query.a.page1.xrcf115"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.xrcf115
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf115
            #add-point:ON ACTION controlp INFIELD xrcf115 name="query.c.page1.xrcf115"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf116
            #add-point:BEFORE FIELD xrcf116 name="query.b.page1.xrcf116"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf116
            
            #add-point:AFTER FIELD xrcf116 name="query.a.page1.xrcf116"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.xrcf116
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf116
            #add-point:ON ACTION controlp INFIELD xrcf116 name="query.c.page1.xrcf116"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf117
            #add-point:BEFORE FIELD xrcf117 name="query.b.page1.xrcf117"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf117
            
            #add-point:AFTER FIELD xrcf117 name="query.a.page1.xrcf117"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page1.xrcf117
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf117
            #add-point:ON ACTION controlp INFIELD xrcf117 name="query.c.page1.xrcf117"
            
            #END add-point
 
 
  
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf022
            #add-point:BEFORE FIELD xrcf022 name="query.b.page2.xrcf022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf022
            
            #add-point:AFTER FIELD xrcf022 name="query.a.page2.xrcf022"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.xrcf022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf022
            #add-point:ON ACTION controlp INFIELD xrcf022 name="query.c.page2.xrcf022"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf022_desc
            #add-point:BEFORE FIELD xrcf022_desc name="query.b.page2.xrcf022_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf022_desc
            
            #add-point:AFTER FIELD xrcf022_desc name="query.a.page2.xrcf022_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.xrcf022_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf022_desc
            #add-point:ON ACTION controlp INFIELD xrcf022_desc name="query.c.page2.xrcf022_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf024
            #add-point:BEFORE FIELD xrcf024 name="query.b.page2.xrcf024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf024
            
            #add-point:AFTER FIELD xrcf024 name="query.a.page2.xrcf024"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.xrcf024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf024
            #add-point:ON ACTION controlp INFIELD xrcf024 name="query.c.page2.xrcf024"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf024_desc
            #add-point:BEFORE FIELD xrcf024_desc name="query.b.page2.xrcf024_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf024_desc
            
            #add-point:AFTER FIELD xrcf024_desc name="query.a.page2.xrcf024_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.xrcf024_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf024_desc
            #add-point:ON ACTION controlp INFIELD xrcf024_desc name="query.c.page2.xrcf024_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf025
            #add-point:BEFORE FIELD xrcf025 name="query.b.page2.xrcf025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf025
            
            #add-point:AFTER FIELD xrcf025 name="query.a.page2.xrcf025"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.xrcf025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf025
            #add-point:ON ACTION controlp INFIELD xrcf025 name="query.c.page2.xrcf025"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf025_desc
            #add-point:BEFORE FIELD xrcf025_desc name="query.b.page2.xrcf025_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf025_desc
            
            #add-point:AFTER FIELD xrcf025_desc name="query.a.page2.xrcf025_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page2.xrcf025_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf025_desc
            #add-point:ON ACTION controlp INFIELD xrcf025_desc name="query.c.page2.xrcf025_desc"
            
            #END add-point
 
 
  
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf105_1
            #add-point:BEFORE FIELD xrcf105_1 name="query.b.page3.xrcf105_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf105_1
            
            #add-point:AFTER FIELD xrcf105_1 name="query.a.page3.xrcf105_1"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page3.xrcf105_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf105_1
            #add-point:ON ACTION controlp INFIELD xrcf105_1 name="query.c.page3.xrcf105_1"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf102_1
            #add-point:BEFORE FIELD xrcf102_1 name="query.b.page3.xrcf102_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf102_1
            
            #add-point:AFTER FIELD xrcf102_1 name="query.a.page3.xrcf102_1"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page3.xrcf102_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf102_1
            #add-point:ON ACTION controlp INFIELD xrcf102_1 name="query.c.page3.xrcf102_1"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf115_1
            #add-point:BEFORE FIELD xrcf115_1 name="query.b.page3.xrcf115_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf115_1
            
            #add-point:AFTER FIELD xrcf115_1 name="query.a.page3.xrcf115_1"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page3.xrcf115_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf115_1
            #add-point:ON ACTION controlp INFIELD xrcf115_1 name="query.c.page3.xrcf115_1"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf122
            #add-point:BEFORE FIELD xrcf122 name="query.b.page3.xrcf122"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf122
            
            #add-point:AFTER FIELD xrcf122 name="query.a.page3.xrcf122"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page3.xrcf122
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf122
            #add-point:ON ACTION controlp INFIELD xrcf122 name="query.c.page3.xrcf122"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf122_desc
            #add-point:BEFORE FIELD xrcf122_desc name="query.b.page3.xrcf122_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf122_desc
            
            #add-point:AFTER FIELD xrcf122_desc name="query.a.page3.xrcf122_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page3.xrcf122_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf122_desc
            #add-point:ON ACTION controlp INFIELD xrcf122_desc name="query.c.page3.xrcf122_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf123
            #add-point:BEFORE FIELD xrcf123 name="query.b.page3.xrcf123"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf123
            
            #add-point:AFTER FIELD xrcf123 name="query.a.page3.xrcf123"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page3.xrcf123
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf123
            #add-point:ON ACTION controlp INFIELD xrcf123 name="query.c.page3.xrcf123"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf124
            #add-point:BEFORE FIELD xrcf124 name="query.b.page3.xrcf124"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf124
            
            #add-point:AFTER FIELD xrcf124 name="query.a.page3.xrcf124"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page3.xrcf124
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf124
            #add-point:ON ACTION controlp INFIELD xrcf124 name="query.c.page3.xrcf124"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf125
            #add-point:BEFORE FIELD xrcf125 name="query.b.page3.xrcf125"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf125
            
            #add-point:AFTER FIELD xrcf125 name="query.a.page3.xrcf125"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page3.xrcf125
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf125
            #add-point:ON ACTION controlp INFIELD xrcf125 name="query.c.page3.xrcf125"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf126
            #add-point:BEFORE FIELD xrcf126 name="query.b.page3.xrcf126"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf126
            
            #add-point:AFTER FIELD xrcf126 name="query.a.page3.xrcf126"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page3.xrcf126
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf126
            #add-point:ON ACTION controlp INFIELD xrcf126 name="query.c.page3.xrcf126"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf127
            #add-point:BEFORE FIELD xrcf127 name="query.b.page3.xrcf127"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf127
            
            #add-point:AFTER FIELD xrcf127 name="query.a.page3.xrcf127"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page3.xrcf127
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf127
            #add-point:ON ACTION controlp INFIELD xrcf127 name="query.c.page3.xrcf127"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf132
            #add-point:BEFORE FIELD xrcf132 name="query.b.page3.xrcf132"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf132
            
            #add-point:AFTER FIELD xrcf132 name="query.a.page3.xrcf132"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page3.xrcf132
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf132
            #add-point:ON ACTION controlp INFIELD xrcf132 name="query.c.page3.xrcf132"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf132_desc
            #add-point:BEFORE FIELD xrcf132_desc name="query.b.page3.xrcf132_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf132_desc
            
            #add-point:AFTER FIELD xrcf132_desc name="query.a.page3.xrcf132_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page3.xrcf132_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf132_desc
            #add-point:ON ACTION controlp INFIELD xrcf132_desc name="query.c.page3.xrcf132_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf133
            #add-point:BEFORE FIELD xrcf133 name="query.b.page3.xrcf133"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf133
            
            #add-point:AFTER FIELD xrcf133 name="query.a.page3.xrcf133"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page3.xrcf133
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf133
            #add-point:ON ACTION controlp INFIELD xrcf133 name="query.c.page3.xrcf133"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf134
            #add-point:BEFORE FIELD xrcf134 name="query.b.page3.xrcf134"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf134
            
            #add-point:AFTER FIELD xrcf134 name="query.a.page3.xrcf134"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page3.xrcf134
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf134
            #add-point:ON ACTION controlp INFIELD xrcf134 name="query.c.page3.xrcf134"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf135
            #add-point:BEFORE FIELD xrcf135 name="query.b.page3.xrcf135"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf135
            
            #add-point:AFTER FIELD xrcf135 name="query.a.page3.xrcf135"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page3.xrcf135
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf135
            #add-point:ON ACTION controlp INFIELD xrcf135 name="query.c.page3.xrcf135"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf136
            #add-point:BEFORE FIELD xrcf136 name="query.b.page3.xrcf136"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf136
            
            #add-point:AFTER FIELD xrcf136 name="query.a.page3.xrcf136"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page3.xrcf136
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf136
            #add-point:ON ACTION controlp INFIELD xrcf136 name="query.c.page3.xrcf136"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf137
            #add-point:BEFORE FIELD xrcf137 name="query.b.page3.xrcf137"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf137
            
            #add-point:AFTER FIELD xrcf137 name="query.a.page3.xrcf137"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page3.xrcf137
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf137
            #add-point:ON ACTION controlp INFIELD xrcf137 name="query.c.page3.xrcf137"
            
            #END add-point
 
 
  
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf049
            #add-point:BEFORE FIELD xrcf049 name="query.b.page4.xrcf049"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf049
            
            #add-point:AFTER FIELD xrcf049 name="query.a.page4.xrcf049"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page4.xrcf049
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf049
            #add-point:ON ACTION controlp INFIELD xrcf049 name="query.c.page4.xrcf049"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf021
            #add-point:BEFORE FIELD xrcf021 name="query.b.page4.xrcf021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf021
            
            #add-point:AFTER FIELD xrcf021 name="query.a.page4.xrcf021"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page4.xrcf021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf021
            #add-point:ON ACTION controlp INFIELD xrcf021 name="query.c.page4.xrcf021"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf021_desc
            #add-point:BEFORE FIELD xrcf021_desc name="query.b.page4.xrcf021_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf021_desc
            
            #add-point:AFTER FIELD xrcf021_desc name="query.a.page4.xrcf021_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page4.xrcf021_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf021_desc
            #add-point:ON ACTION controlp INFIELD xrcf021_desc name="query.c.page4.xrcf021_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf023
            #add-point:BEFORE FIELD xrcf023 name="query.b.page4.xrcf023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf023
            
            #add-point:AFTER FIELD xrcf023 name="query.a.page4.xrcf023"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page4.xrcf023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf023
            #add-point:ON ACTION controlp INFIELD xrcf023 name="query.c.page4.xrcf023"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf023_desc
            #add-point:BEFORE FIELD xrcf023_desc name="query.b.page4.xrcf023_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf023_desc
            
            #add-point:AFTER FIELD xrcf023_desc name="query.a.page4.xrcf023_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page4.xrcf023_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf023_desc
            #add-point:ON ACTION controlp INFIELD xrcf023_desc name="query.c.page4.xrcf023_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf033
            #add-point:BEFORE FIELD xrcf033 name="query.b.page4.xrcf033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf033
            
            #add-point:AFTER FIELD xrcf033 name="query.a.page4.xrcf033"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page4.xrcf033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf033
            #add-point:ON ACTION controlp INFIELD xrcf033 name="query.c.page4.xrcf033"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf033_desc
            #add-point:BEFORE FIELD xrcf033_desc name="query.b.page4.xrcf033_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf033_desc
            
            #add-point:AFTER FIELD xrcf033_desc name="query.a.page4.xrcf033_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page4.xrcf033_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf033_desc
            #add-point:ON ACTION controlp INFIELD xrcf033_desc name="query.c.page4.xrcf033_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf026
            #add-point:BEFORE FIELD xrcf026 name="query.b.page4.xrcf026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf026
            
            #add-point:AFTER FIELD xrcf026 name="query.a.page4.xrcf026"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page4.xrcf026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf026
            #add-point:ON ACTION controlp INFIELD xrcf026 name="query.c.page4.xrcf026"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf026_desc
            #add-point:BEFORE FIELD xrcf026_desc name="query.b.page4.xrcf026_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf026_desc
            
            #add-point:AFTER FIELD xrcf026_desc name="query.a.page4.xrcf026_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page4.xrcf026_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf026_desc
            #add-point:ON ACTION controlp INFIELD xrcf026_desc name="query.c.page4.xrcf026_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf027
            #add-point:BEFORE FIELD xrcf027 name="query.b.page4.xrcf027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf027
            
            #add-point:AFTER FIELD xrcf027 name="query.a.page4.xrcf027"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page4.xrcf027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf027
            #add-point:ON ACTION controlp INFIELD xrcf027 name="query.c.page4.xrcf027"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf027_desc
            #add-point:BEFORE FIELD xrcf027_desc name="query.b.page4.xrcf027_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf027_desc
            
            #add-point:AFTER FIELD xrcf027_desc name="query.a.page4.xrcf027_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page4.xrcf027_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf027_desc
            #add-point:ON ACTION controlp INFIELD xrcf027_desc name="query.c.page4.xrcf027_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf028
            #add-point:BEFORE FIELD xrcf028 name="query.b.page4.xrcf028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf028
            
            #add-point:AFTER FIELD xrcf028 name="query.a.page4.xrcf028"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page4.xrcf028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf028
            #add-point:ON ACTION controlp INFIELD xrcf028 name="query.c.page4.xrcf028"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf028_desc
            #add-point:BEFORE FIELD xrcf028_desc name="query.b.page4.xrcf028_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf028_desc
            
            #add-point:AFTER FIELD xrcf028_desc name="query.a.page4.xrcf028_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page4.xrcf028_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf028_desc
            #add-point:ON ACTION controlp INFIELD xrcf028_desc name="query.c.page4.xrcf028_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf031
            #add-point:BEFORE FIELD xrcf031 name="query.b.page4.xrcf031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf031
            
            #add-point:AFTER FIELD xrcf031 name="query.a.page4.xrcf031"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page4.xrcf031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf031
            #add-point:ON ACTION controlp INFIELD xrcf031 name="query.c.page4.xrcf031"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf031_desc
            #add-point:BEFORE FIELD xrcf031_desc name="query.b.page4.xrcf031_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf031_desc
            
            #add-point:AFTER FIELD xrcf031_desc name="query.a.page4.xrcf031_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page4.xrcf031_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf031_desc
            #add-point:ON ACTION controlp INFIELD xrcf031_desc name="query.c.page4.xrcf031_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf032
            #add-point:BEFORE FIELD xrcf032 name="query.b.page4.xrcf032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf032
            
            #add-point:AFTER FIELD xrcf032 name="query.a.page4.xrcf032"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page4.xrcf032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf032
            #add-point:ON ACTION controlp INFIELD xrcf032 name="query.c.page4.xrcf032"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf032_desc
            #add-point:BEFORE FIELD xrcf032_desc name="query.b.page4.xrcf032_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf032_desc
            
            #add-point:AFTER FIELD xrcf032_desc name="query.a.page4.xrcf032_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page4.xrcf032_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf032_desc
            #add-point:ON ACTION controlp INFIELD xrcf032_desc name="query.c.page4.xrcf032_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf034
            #add-point:BEFORE FIELD xrcf034 name="query.b.page4.xrcf034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf034
            
            #add-point:AFTER FIELD xrcf034 name="query.a.page4.xrcf034"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page4.xrcf034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf034
            #add-point:ON ACTION controlp INFIELD xrcf034 name="query.c.page4.xrcf034"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf034_desc
            #add-point:BEFORE FIELD xrcf034_desc name="query.b.page4.xrcf034_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf034_desc
            
            #add-point:AFTER FIELD xrcf034_desc name="query.a.page4.xrcf034_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page4.xrcf034_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf034_desc
            #add-point:ON ACTION controlp INFIELD xrcf034_desc name="query.c.page4.xrcf034_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf035
            #add-point:BEFORE FIELD xrcf035 name="query.b.page4.xrcf035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf035
            
            #add-point:AFTER FIELD xrcf035 name="query.a.page4.xrcf035"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page4.xrcf035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf035
            #add-point:ON ACTION controlp INFIELD xrcf035 name="query.c.page4.xrcf035"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf035_desc
            #add-point:BEFORE FIELD xrcf035_desc name="query.b.page4.xrcf035_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf035_desc
            
            #add-point:AFTER FIELD xrcf035_desc name="query.a.page4.xrcf035_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page4.xrcf035_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf035_desc
            #add-point:ON ACTION controlp INFIELD xrcf035_desc name="query.c.page4.xrcf035_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf036
            #add-point:BEFORE FIELD xrcf036 name="query.b.page4.xrcf036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf036
            
            #add-point:AFTER FIELD xrcf036 name="query.a.page4.xrcf036"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page4.xrcf036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf036
            #add-point:ON ACTION controlp INFIELD xrcf036 name="query.c.page4.xrcf036"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf037
            #add-point:BEFORE FIELD xrcf037 name="query.b.page4.xrcf037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf037
            
            #add-point:AFTER FIELD xrcf037 name="query.a.page4.xrcf037"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page4.xrcf037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf037
            #add-point:ON ACTION controlp INFIELD xrcf037 name="query.c.page4.xrcf037"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf037_desc
            #add-point:BEFORE FIELD xrcf037_desc name="query.b.page4.xrcf037_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf037_desc
            
            #add-point:AFTER FIELD xrcf037_desc name="query.a.page4.xrcf037_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page4.xrcf037_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf037_desc
            #add-point:ON ACTION controlp INFIELD xrcf037_desc name="query.c.page4.xrcf037_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf038
            #add-point:BEFORE FIELD xrcf038 name="query.b.page4.xrcf038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf038
            
            #add-point:AFTER FIELD xrcf038 name="query.a.page4.xrcf038"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page4.xrcf038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf038
            #add-point:ON ACTION controlp INFIELD xrcf038 name="query.c.page4.xrcf038"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf038_desc
            #add-point:BEFORE FIELD xrcf038_desc name="query.b.page4.xrcf038_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf038_desc
            
            #add-point:AFTER FIELD xrcf038_desc name="query.a.page4.xrcf038_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page4.xrcf038_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf038_desc
            #add-point:ON ACTION controlp INFIELD xrcf038_desc name="query.c.page4.xrcf038_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf039
            #add-point:BEFORE FIELD xrcf039 name="query.b.page4.xrcf039"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf039
            
            #add-point:AFTER FIELD xrcf039 name="query.a.page4.xrcf039"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page4.xrcf039
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf039
            #add-point:ON ACTION controlp INFIELD xrcf039 name="query.c.page4.xrcf039"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf039_desc
            #add-point:BEFORE FIELD xrcf039_desc name="query.b.page4.xrcf039_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf039_desc
            
            #add-point:AFTER FIELD xrcf039_desc name="query.a.page4.xrcf039_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page4.xrcf039_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf039_desc
            #add-point:ON ACTION controlp INFIELD xrcf039_desc name="query.c.page4.xrcf039_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf040
            #add-point:BEFORE FIELD xrcf040 name="query.b.page4.xrcf040"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf040
            
            #add-point:AFTER FIELD xrcf040 name="query.a.page4.xrcf040"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page4.xrcf040
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf040
            #add-point:ON ACTION controlp INFIELD xrcf040 name="query.c.page4.xrcf040"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf040_desc
            #add-point:BEFORE FIELD xrcf040_desc name="query.b.page4.xrcf040_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf040_desc
            
            #add-point:AFTER FIELD xrcf040_desc name="query.a.page4.xrcf040_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page4.xrcf040_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf040_desc
            #add-point:ON ACTION controlp INFIELD xrcf040_desc name="query.c.page4.xrcf040_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf041
            #add-point:BEFORE FIELD xrcf041 name="query.b.page4.xrcf041"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf041
            
            #add-point:AFTER FIELD xrcf041 name="query.a.page4.xrcf041"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page4.xrcf041
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf041
            #add-point:ON ACTION controlp INFIELD xrcf041 name="query.c.page4.xrcf041"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf041_desc
            #add-point:BEFORE FIELD xrcf041_desc name="query.b.page4.xrcf041_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf041_desc
            
            #add-point:AFTER FIELD xrcf041_desc name="query.a.page4.xrcf041_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page4.xrcf041_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf041_desc
            #add-point:ON ACTION controlp INFIELD xrcf041_desc name="query.c.page4.xrcf041_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf042
            #add-point:BEFORE FIELD xrcf042 name="query.b.page4.xrcf042"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf042
            
            #add-point:AFTER FIELD xrcf042 name="query.a.page4.xrcf042"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page4.xrcf042
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf042
            #add-point:ON ACTION controlp INFIELD xrcf042 name="query.c.page4.xrcf042"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf042_desc
            #add-point:BEFORE FIELD xrcf042_desc name="query.b.page4.xrcf042_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf042_desc
            
            #add-point:AFTER FIELD xrcf042_desc name="query.a.page4.xrcf042_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page4.xrcf042_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf042_desc
            #add-point:ON ACTION controlp INFIELD xrcf042_desc name="query.c.page4.xrcf042_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf043
            #add-point:BEFORE FIELD xrcf043 name="query.b.page4.xrcf043"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf043
            
            #add-point:AFTER FIELD xrcf043 name="query.a.page4.xrcf043"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page4.xrcf043
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf043
            #add-point:ON ACTION controlp INFIELD xrcf043 name="query.c.page4.xrcf043"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf043_desc
            #add-point:BEFORE FIELD xrcf043_desc name="query.b.page4.xrcf043_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf043_desc
            
            #add-point:AFTER FIELD xrcf043_desc name="query.a.page4.xrcf043_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page4.xrcf043_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf043_desc
            #add-point:ON ACTION controlp INFIELD xrcf043_desc name="query.c.page4.xrcf043_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf044
            #add-point:BEFORE FIELD xrcf044 name="query.b.page4.xrcf044"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf044
            
            #add-point:AFTER FIELD xrcf044 name="query.a.page4.xrcf044"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page4.xrcf044
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf044
            #add-point:ON ACTION controlp INFIELD xrcf044 name="query.c.page4.xrcf044"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf044_desc
            #add-point:BEFORE FIELD xrcf044_desc name="query.b.page4.xrcf044_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf044_desc
            
            #add-point:AFTER FIELD xrcf044_desc name="query.a.page4.xrcf044_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page4.xrcf044_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf044_desc
            #add-point:ON ACTION controlp INFIELD xrcf044_desc name="query.c.page4.xrcf044_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf045
            #add-point:BEFORE FIELD xrcf045 name="query.b.page4.xrcf045"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf045
            
            #add-point:AFTER FIELD xrcf045 name="query.a.page4.xrcf045"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page4.xrcf045
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf045
            #add-point:ON ACTION controlp INFIELD xrcf045 name="query.c.page4.xrcf045"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf045_desc
            #add-point:BEFORE FIELD xrcf045_desc name="query.b.page4.xrcf045_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf045_desc
            
            #add-point:AFTER FIELD xrcf045_desc name="query.a.page4.xrcf045_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page4.xrcf045_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf045_desc
            #add-point:ON ACTION controlp INFIELD xrcf045_desc name="query.c.page4.xrcf045_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf046
            #add-point:BEFORE FIELD xrcf046 name="query.b.page4.xrcf046"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf046
            
            #add-point:AFTER FIELD xrcf046 name="query.a.page4.xrcf046"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page4.xrcf046
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf046
            #add-point:ON ACTION controlp INFIELD xrcf046 name="query.c.page4.xrcf046"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf046_desc
            #add-point:BEFORE FIELD xrcf046_desc name="query.b.page4.xrcf046_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf046_desc
            
            #add-point:AFTER FIELD xrcf046_desc name="query.a.page4.xrcf046_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page4.xrcf046_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf046_desc
            #add-point:ON ACTION controlp INFIELD xrcf046_desc name="query.c.page4.xrcf046_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf047
            #add-point:BEFORE FIELD xrcf047 name="query.b.page4.xrcf047"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf047
            
            #add-point:AFTER FIELD xrcf047 name="query.a.page4.xrcf047"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page4.xrcf047
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf047
            #add-point:ON ACTION controlp INFIELD xrcf047 name="query.c.page4.xrcf047"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf047_desc
            #add-point:BEFORE FIELD xrcf047_desc name="query.b.page4.xrcf047_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf047_desc
            
            #add-point:AFTER FIELD xrcf047_desc name="query.a.page4.xrcf047_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page4.xrcf047_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf047_desc
            #add-point:ON ACTION controlp INFIELD xrcf047_desc name="query.c.page4.xrcf047_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf048
            #add-point:BEFORE FIELD xrcf048 name="query.b.page4.xrcf048"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf048
            
            #add-point:AFTER FIELD xrcf048 name="query.a.page4.xrcf048"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page4.xrcf048
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf048
            #add-point:ON ACTION controlp INFIELD xrcf048 name="query.c.page4.xrcf048"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf048_desc
            #add-point:BEFORE FIELD xrcf048_desc name="query.b.page4.xrcf048_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf048_desc
            
            #add-point:AFTER FIELD xrcf048_desc name="query.a.page4.xrcf048_desc"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page4.xrcf048_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf048_desc
            #add-point:ON ACTION controlp INFIELD xrcf048_desc name="query.c.page4.xrcf048_desc"
            
            #END add-point
 
 
  
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf001
            #add-point:BEFORE FIELD xrcf001 name="query.b.page5.xrcf001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf001
            
            #add-point:AFTER FIELD xrcf001 name="query.a.page5.xrcf001"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page5.xrcf001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf001
            #add-point:ON ACTION controlp INFIELD xrcf001 name="query.c.page5.xrcf001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf002
            #add-point:BEFORE FIELD xrcf002 name="query.b.page5.xrcf002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf002
            
            #add-point:AFTER FIELD xrcf002 name="query.a.page5.xrcf002"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page5.xrcf002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf002
            #add-point:ON ACTION controlp INFIELD xrcf002 name="query.c.page5.xrcf002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf010
            #add-point:BEFORE FIELD xrcf010 name="query.b.page5.xrcf010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf010
            
            #add-point:AFTER FIELD xrcf010 name="query.a.page5.xrcf010"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page5.xrcf010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf010
            #add-point:ON ACTION controlp INFIELD xrcf010 name="query.c.page5.xrcf010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf020
            #add-point:BEFORE FIELD xrcf020 name="query.b.page5.xrcf020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf020
            
            #add-point:AFTER FIELD xrcf020 name="query.a.page5.xrcf020"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page5.xrcf020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf020
            #add-point:ON ACTION controlp INFIELD xrcf020 name="query.c.page5.xrcf020"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf029
            #add-point:BEFORE FIELD xrcf029 name="query.b.page5.xrcf029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf029
            
            #add-point:AFTER FIELD xrcf029 name="query.a.page5.xrcf029"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page5.xrcf029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf029
            #add-point:ON ACTION controlp INFIELD xrcf029 name="query.c.page5.xrcf029"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf030
            #add-point:BEFORE FIELD xrcf030 name="query.b.page5.xrcf030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf030
            
            #add-point:AFTER FIELD xrcf030 name="query.a.page5.xrcf030"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page5.xrcf030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf030
            #add-point:ON ACTION controlp INFIELD xrcf030 name="query.c.page5.xrcf030"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcforga
            #add-point:BEFORE FIELD xrcforga name="query.b.page5.xrcforga"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcforga
            
            #add-point:AFTER FIELD xrcforga name="query.a.page5.xrcforga"
            
            #END add-point
            
 
 
         #Ctrlp:query.c.page5.xrcforga
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcforga
            #add-point:ON ACTION controlp INFIELD xrcforga name="query.c.page5.xrcforga"
            
            #END add-point
 
 
  
 
      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.before_construct"
            
            #end add-point 
      
      END CONSTRUCT
  
      #add-point:query段more_construct name="query.more_construct"
      
      #end add-point 
  
      BEFORE DIALOG 
         CALL cl_qbe_init()
         #add-point:query段before_dialog name="query.before_dialog"
         
         #end add-point 
      
      ON ACTION qbe_select
         LET ls_wc = ""
         CALL cl_qbe_list("c") RETURNING ls_wc
      
      ON ACTION qbe_save
         CALL cl_qbe_save()
      
      ON ACTION accept
         ACCEPT DIALOG
         
      ON ACTION cancel
         LET INT_FLAG = 1
         CANCEL DIALOG
      
      #交談指令共用ACTION
      &include "common_action.4gl"
      CONTINUE DIALOG 
   END DIALOG
 
   #add-point:query段after_construct name="query.after_construct"
   
   #end add-point
 
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      #還原
      #LET g_wc2 = ls_wc
      LET g_wc2 = " 1=2"
      RETURN
   ELSE
      LET g_error_show = 1
      LET g_detail_idx = 1
   END IF
    
   CALL axrt300_06_b_fill(g_wc2)
 
   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = -100 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
   END IF
   
   LET INT_FLAG = FALSE
   
END FUNCTION
 
{</section>}
 
{<section id="axrt300_06.insert" >}
#+ 資料新增
PRIVATE FUNCTION axrt300_06_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point                
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #add-point:單身新增前 name="insert.b_insert"
   
   #end add-point
   
   LET g_insert = 'Y'
   CALL axrt300_06_modify()
            
   #add-point:單身新增後 name="insert.a_insert"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axrt300_06.modify" >}
#+ 資料修改
PRIVATE FUNCTION axrt300_06_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point
   DEFINE  l_cmd                  LIKE type_t.chr1
   DEFINE  l_ac_t                 LIKE type_t.num10               #未取消的ARRAY CNT 
   DEFINE  l_n                    LIKE type_t.num10               #檢查重複用  
   DEFINE  l_cnt                  LIKE type_t.num10               #檢查重複用  
   DEFINE  l_lock_sw              LIKE type_t.chr1                #單身鎖住否  
   DEFINE  l_allow_insert         LIKE type_t.num5                #可新增否 
   DEFINE  l_allow_delete         LIKE type_t.num5                #可刪除否  
   DEFINE  l_count                LIKE type_t.num10
   DEFINE  l_i                    LIKE type_t.num10
   DEFINE  ls_return              STRING
   DEFINE  l_var_keys             DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys           DYNAMIC ARRAY OF STRING
   DEFINE  l_vars                 DYNAMIC ARRAY OF STRING
   DEFINE  l_fields               DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak         DYNAMIC ARRAY OF STRING
   DEFINE  li_reproduce           LIKE type_t.num10
   DEFINE  li_reproduce_target    LIKE type_t.num10
   DEFINE  lb_reproduce           BOOLEAN
   DEFINE  l_insert               BOOLEAN
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   DEFINE l_success              LIKE type_t.chr1
   DEFINE l_xrca057              LIKE xrca_t.xrca057
   DEFINE l_errno                LIKE type_t.num5
   DEFINE l_xrcastus             LIKE xrca_t.xrcastus
   DEFINE l_glaa004              LIKE glaa_t.glaa004  #150916-00015#1 -add   
   #150203-00010#4 Add  ---(S)---
   DEFINE l_xrcadocdt            LIKE xrca_t.xrcadocdt
   DEFINE l_xrcacomp             LIKE xrca_t.xrcacomp
   DEFINE l_slip                 LIKE xrca_t.xrcadocno
   DEFINE l_dfin0030             LIKE type_t.chr1
   DEFINE l_glaa121              LIKE glaa_t.glaa121
   #150203-00010#4 Add  ---(E)---
   #end add-point 
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
#  LET g_action_choice = ""   #(ver:35) mark
   
   LET g_qryparam.state = "i"
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   
   #add-point:modify開始前 name="modify.define_sql"
   SELECT xrcastus INTO l_xrcastus FROM xrca_t WHERE xrcaent = g_enterprise
      AND xrcadocno = g_xrcadocno AND xrcald = g_xrcald
   IF l_xrcastus <> 'N' THEN RETURN END IF
   #end add-point
   
   LET INT_FLAG = FALSE
   LET lb_reproduce = FALSE
   LET l_insert = FALSE
 
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
 
   #add-point:modify段修改前 name="modify.before_input"
   
   #end add-point
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #Page1 預設值產生於此處
      INPUT ARRAY g_xrcf_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_detail_cnt,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_xrcf_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL axrt300_06_b_fill(g_wc2)
            LET g_detail_cnt = g_xrcf_d.getLength()
         
         BEFORE ROW
            #add-point:modify段before row name="input.body.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET l_ac = g_detail_idx
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
            DISPLAY g_xrcf_d.getLength() TO FORMONLY.cnt
         
            CALL s_transaction_begin()
            LET g_detail_cnt = g_xrcf_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_xrcf_d[l_ac].xrcfld IS NOT NULL
               AND g_xrcf_d[l_ac].xrcfdocno IS NOT NULL
               AND g_xrcf_d[l_ac].xrcfseq IS NOT NULL
               AND g_xrcf_d[l_ac].xrcfseq2 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_xrcf_d_t.* = g_xrcf_d[l_ac].*  #BACKUP
               LET g_xrcf_d_o.* = g_xrcf_d[l_ac].*  #BACKUP
               IF NOT axrt300_06_lock_b("xrcf_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH axrt300_06_bcl INTO g_xrcf_d[l_ac].xrcfdocno,g_xrcf_d[l_ac].xrcfld,g_xrcf_d[l_ac].xrcfseq2, 
                      g_xrcf_d[l_ac].xrcfseq,g_xrcf_d[l_ac].xrcf008,g_xrcf_d[l_ac].xrcf009,g_xrcf_d[l_ac].xrcf021, 
                      g_xrcf_d[l_ac].xrcf007,g_xrcf_d[l_ac].xrcf101,g_xrcf_d[l_ac].xrcf103,g_xrcf_d[l_ac].xrcf104, 
                      g_xrcf_d[l_ac].xrcf105,g_xrcf_d[l_ac].xrcf106,g_xrcf_d[l_ac].xrcf102,g_xrcf_d[l_ac].xrcf111, 
                      g_xrcf_d[l_ac].xrcf113,g_xrcf_d[l_ac].xrcf114,g_xrcf_d[l_ac].xrcf115,g_xrcf_d[l_ac].xrcf116, 
                      g_xrcf_d[l_ac].xrcf117,g_xrcf2_d[l_ac].xrcfdocno,g_xrcf2_d[l_ac].xrcfld,g_xrcf2_d[l_ac].xrcfseq, 
                      g_xrcf2_d[l_ac].xrcfseq2,g_xrcf2_d[l_ac].xrcf022,g_xrcf2_d[l_ac].xrcf024,g_xrcf2_d[l_ac].xrcf025, 
                      g_xrcf3_d[l_ac].xrcfdocno,g_xrcf3_d[l_ac].xrcfld,g_xrcf3_d[l_ac].xrcfseq,g_xrcf3_d[l_ac].xrcfseq2, 
                      g_xrcf3_d[l_ac].xrcf105,g_xrcf3_d[l_ac].xrcf102,g_xrcf3_d[l_ac].xrcf115,g_xrcf3_d[l_ac].xrcf122, 
                      g_xrcf3_d[l_ac].xrcf123,g_xrcf3_d[l_ac].xrcf124,g_xrcf3_d[l_ac].xrcf125,g_xrcf3_d[l_ac].xrcf126, 
                      g_xrcf3_d[l_ac].xrcf127,g_xrcf3_d[l_ac].xrcf132,g_xrcf3_d[l_ac].xrcf133,g_xrcf3_d[l_ac].xrcf134, 
                      g_xrcf3_d[l_ac].xrcf135,g_xrcf3_d[l_ac].xrcf136,g_xrcf3_d[l_ac].xrcf137,g_xrcf4_d[l_ac].xrcfdocno, 
                      g_xrcf4_d[l_ac].xrcfld,g_xrcf4_d[l_ac].xrcfseq,g_xrcf4_d[l_ac].xrcfseq2,g_xrcf4_d[l_ac].xrcf049, 
                      g_xrcf4_d[l_ac].xrcf021,g_xrcf4_d[l_ac].xrcf023,g_xrcf4_d[l_ac].xrcf033,g_xrcf4_d[l_ac].xrcf026, 
                      g_xrcf4_d[l_ac].xrcf027,g_xrcf4_d[l_ac].xrcf028,g_xrcf4_d[l_ac].xrcf031,g_xrcf4_d[l_ac].xrcf032, 
                      g_xrcf4_d[l_ac].xrcf034,g_xrcf4_d[l_ac].xrcf035,g_xrcf4_d[l_ac].xrcf036,g_xrcf4_d[l_ac].xrcf037, 
                      g_xrcf4_d[l_ac].xrcf038,g_xrcf4_d[l_ac].xrcf039,g_xrcf4_d[l_ac].xrcf040,g_xrcf4_d[l_ac].xrcf041, 
                      g_xrcf4_d[l_ac].xrcf042,g_xrcf4_d[l_ac].xrcf043,g_xrcf4_d[l_ac].xrcf044,g_xrcf4_d[l_ac].xrcf045, 
                      g_xrcf4_d[l_ac].xrcf046,g_xrcf4_d[l_ac].xrcf047,g_xrcf4_d[l_ac].xrcf048,g_xrcf5_d[l_ac].xrcfdocno, 
                      g_xrcf5_d[l_ac].xrcfld,g_xrcf5_d[l_ac].xrcfseq,g_xrcf5_d[l_ac].xrcfseq2,g_xrcf5_d[l_ac].xrcf001, 
                      g_xrcf5_d[l_ac].xrcf002,g_xrcf5_d[l_ac].xrcf010,g_xrcf5_d[l_ac].xrcf020,g_xrcf5_d[l_ac].xrcf029, 
                      g_xrcf5_d[l_ac].xrcf030,g_xrcf5_d[l_ac].xrcforga
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_xrcf_d_t.xrcfld,":",SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_xrcf_d_mask_o[l_ac].* =  g_xrcf_d[l_ac].*
                  CALL axrt300_06_xrcf_t_mask()
                  LET g_xrcf_d_mask_n[l_ac].* =  g_xrcf_d[l_ac].*
                  
                  CALL axrt300_06_detail_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL axrt300_06_set_entry_b(l_cmd)
            CALL axrt300_06_set_no_entry_b(l_cmd)
            #add-point:modify段before row name="input.body.before_row"
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
 
 
 
 
            #其他table進行lock
            
 
 
 
 
 
        
         BEFORE INSERT
            
            LET l_insert = TRUE
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_xrcf_d_t.* TO NULL
            INITIALIZE g_xrcf_d_o.* TO NULL
            INITIALIZE g_xrcf_d[l_ac].* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值(單身5)
                  LET g_xrcf_d[l_ac].xrcf007 = "0"
      LET g_xrcf_d[l_ac].xrcf101 = "0"
      LET g_xrcf_d[l_ac].xrcf103 = "0"
      LET g_xrcf_d[l_ac].xrcf104 = "0"
      LET g_xrcf_d[l_ac].xrcf105 = "0"
      LET g_xrcf_d[l_ac].xrcf106 = "0"
      LET g_xrcf_d[l_ac].xrcf111 = "0"
      LET g_xrcf_d[l_ac].xrcf113 = "0"
      LET g_xrcf_d[l_ac].xrcf114 = "0"
      LET g_xrcf_d[l_ac].xrcf115 = "0"
      LET g_xrcf_d[l_ac].xrcf116 = "0"
      LET g_xrcf_d[l_ac].xrcf117 = "0"
 
            #add-point:modify段before備份 name="input.body.before_bak"
            
            #end add-point
            LET g_xrcf_d_t.* = g_xrcf_d[l_ac].*     #新輸入資料
            LET g_xrcf_d_o.* = g_xrcf_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xrcf_d[li_reproduce_target].* = g_xrcf_d[li_reproduce].*
               LET g_xrcf2_d[li_reproduce_target].* = g_xrcf2_d[li_reproduce].*
               LET g_xrcf3_d[li_reproduce_target].* = g_xrcf3_d[li_reproduce].*
               LET g_xrcf4_d[li_reproduce_target].* = g_xrcf4_d[li_reproduce].*
               LET g_xrcf5_d[li_reproduce_target].* = g_xrcf5_d[li_reproduce].*
 
               LET g_xrcf_d[g_xrcf_d.getLength()].xrcfld = NULL
               LET g_xrcf_d[g_xrcf_d.getLength()].xrcfdocno = NULL
               LET g_xrcf_d[g_xrcf_d.getLength()].xrcfseq = NULL
               LET g_xrcf_d[g_xrcf_d.getLength()].xrcfseq2 = NULL
 
            END IF
            
 
 
 
 
 
            CALL axrt300_06_set_entry_b(l_cmd)
            CALL axrt300_06_set_no_entry_b(l_cmd)
            #add-point:modify段before insert name="input.body.before_insert"
            SELECT MAX(xrcfseq) + 1 INTO g_xrcf_d[l_ac].xrcfseq FROM xrcf_t
             WHERE xrcfent = g_enterprise
               AND xrcfdocno = g_xrcadocno
               AND xrcfld    = g_xrcald
            IF cl_null(g_xrcf_d[l_ac].xrcfseq) THEN LET g_xrcf_d[l_ac].xrcfseq = 1 END IF
            LET g_xrcf_d[l_ac].xrcfdocno = g_xrcadocno
            LET g_xrcf_d[l_ac].xrcfld    = g_xrcald
            #end add-point  
  
         AFTER INSERT
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM xrcf_t 
             WHERE xrcfent = g_enterprise AND xrcfld = g_xrcf_d[l_ac].xrcfld
                                       AND xrcfdocno = g_xrcf_d[l_ac].xrcfdocno
                                       AND xrcfseq = g_xrcf_d[l_ac].xrcfseq
                                       AND xrcfseq2 = g_xrcf_d[l_ac].xrcfseq2
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xrcf_d[g_detail_idx].xrcfld
               LET gs_keys[2] = g_xrcf_d[g_detail_idx].xrcfdocno
               LET gs_keys[3] = g_xrcf_d[g_detail_idx].xrcfseq
               LET gs_keys[4] = g_xrcf_d[g_detail_idx].xrcfseq2
               CALL axrt300_06_insert_b('xrcf_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
              #CALL axrt300_06_diff()   #150401-00010#2 Mark
               #end add-point
            ELSE    
               INITIALIZE g_xrcf_d[l_ac].* TO NULL
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xrcf_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL axrt300_06_b_fill(g_wc2)
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               
               #end add-point
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               
               LET g_wc2 = g_wc2, " OR (xrcfld = '", g_xrcf_d[l_ac].xrcfld, "' "
                                  ," AND xrcfdocno = '", g_xrcf_d[l_ac].xrcfdocno, "' "
                                  ," AND xrcfseq = '", g_xrcf_d[l_ac].xrcfseq, "' "
                                  ," AND xrcfseq2 = '", g_xrcf_d[l_ac].xrcfseq2, "' "
 
                                  ,")"
            END IF                
              
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
            ELSE
               #add-point:單身刪除ask前 name="input.body.b_delete_ask"
               
               #end add-point   
               
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
               
               #add-point:單身刪除前 name="input.body.b_delete"
               
               #end add-point   
               
               DELETE FROM xrcf_t
                WHERE xrcfent = g_enterprise AND 
                      xrcfld = g_xrcf_d_t.xrcfld
                      AND xrcfdocno = g_xrcf_d_t.xrcfdocno
                      AND xrcfseq = g_xrcf_d_t.xrcfseq
                      AND xrcfseq2 = g_xrcf_d_t.xrcfseq2
 
                      
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point  
                      
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "xrcf_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
 
 
 
 
 
                  #add-point:單身刪除後 name="input.body.a_delete"
                  
                  #end add-point
                  #修改歷程記錄(刪除)
                  CALL axrt300_06_set_pk_array()
                  LET g_log1 = util.JSON.stringify(g_xrcf_d[l_ac])   #(ver:38)
                  IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:38)
                  ELSE
                  END IF
               END IF 
               CLOSE axrt300_06_bcl
               #add-point:單身關閉bcl name="input.body.close"
               
               #end add-point
               LET l_count = g_xrcf_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xrcf_d_t.xrcfld
               LET gs_keys[2] = g_xrcf_d_t.xrcfdocno
               LET gs_keys[3] = g_xrcf_d_t.xrcfseq
               LET gs_keys[4] = g_xrcf_d_t.xrcfseq2
 
               #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL axrt300_06_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
            END IF 
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2 name="input.body.after_delete"
               
               #end add-point
                              CALL axrt300_06_delete_b('xrcf_t',gs_keys,"'1'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_xrcf_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            #add-point:單身刪除後3 name="input.body.after_delete3"
            
            #end add-point
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcfdocno
            #add-point:BEFORE FIELD xrcfdocno name="input.b.page1.xrcfdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcfdocno
            
            #add-point:AFTER FIELD xrcfdocno name="input.a.page1.xrcfdocno"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcfdocno
            #add-point:ON CHANGE xrcfdocno name="input.g.page1.xrcfdocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcfld
            #add-point:BEFORE FIELD xrcfld name="input.b.page1.xrcfld"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcfld
            
            #add-point:AFTER FIELD xrcfld name="input.a.page1.xrcfld"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcfld
            #add-point:ON CHANGE xrcfld name="input.g.page1.xrcfld"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcfseq2
            #add-point:BEFORE FIELD xrcfseq2 name="input.b.page1.xrcfseq2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcfseq2
            
            #add-point:AFTER FIELD xrcfseq2 name="input.a.page1.xrcfseq2"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcfseq2
            #add-point:ON CHANGE xrcfseq2 name="input.g.page1.xrcfseq2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcfseq
            #add-point:BEFORE FIELD xrcfseq name="input.b.page1.xrcfseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcfseq
            
            #add-point:AFTER FIELD xrcfseq name="input.a.page1.xrcfseq"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_xrcf_d[g_detail_idx].xrcfld IS NOT NULL AND g_xrcf_d[g_detail_idx].xrcfdocno IS NOT NULL AND g_xrcf_d[g_detail_idx].xrcfseq IS NOT NULL AND g_xrcf_d[g_detail_idx].xrcfseq2 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xrcf_d[g_detail_idx].xrcfld != g_xrcf_d_t.xrcfld OR g_xrcf_d[g_detail_idx].xrcfdocno != g_xrcf_d_t.xrcfdocno OR g_xrcf_d[g_detail_idx].xrcfseq != g_xrcf_d_t.xrcfseq OR g_xrcf_d[g_detail_idx].xrcfseq2 != g_xrcf_d_t.xrcfseq2)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xrcf_t WHERE "||"xrcfent = '" ||g_enterprise|| "' AND "||"xrcfld = '"||g_xrcf_d[g_detail_idx].xrcfld ||"' AND "|| "xrcfdocno = '"||g_xrcf_d[g_detail_idx].xrcfdocno ||"' AND "|| "xrcfseq = '"||g_xrcf_d[g_detail_idx].xrcfseq ||"' AND "|| "xrcfseq2 = '"||g_xrcf_d[g_detail_idx].xrcfseq2 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcfseq
            #add-point:ON CHANGE xrcfseq name="input.g.page1.xrcfseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrca001_desc
            #add-point:BEFORE FIELD xrca001_desc name="input.b.page1.xrca001_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrca001_desc
            
            #add-point:AFTER FIELD xrca001_desc name="input.a.page1.xrca001_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrca001_desc
            #add-point:ON CHANGE xrca001_desc name="input.g.page1.xrca001_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf008
            #add-point:BEFORE FIELD xrcf008 name="input.b.page1.xrcf008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf008
            
            #add-point:AFTER FIELD xrcf008 name="input.a.page1.xrcf008"
            #150401-00010#2 Mark ---(S)---
           #IF NOT cl_null(g_xrcf_d[l_ac].xrcf008) THEN
           #   IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_xrcf_d[l_ac].xrcf008 != g_xrcf_d_t.xrcf008 OR g_xrcf_d_t.xrcf008 IS NULL )) THEN
           #      LET l_count = 0
           #      IF g_xrcf_d[l_ac].xrcf009 IS NOT NULL THEN
           #         LET g_errno = ' '
           #         SELECT COUNT(*) INTO l_count FROM xrcb_t
           #          WHERE xrcbent = g_enterprise AND xrcbdocno = g_xrcf_d[l_ac].xrcf008 AND xrcbseq = g_xrcf_d[l_ac].xrcf009 AND xrcbld = g_xrcald
           #         IF l_count < 1 THEN LET g_errno = 'axr-00149' END IF
           #      ELSE
           #         LET g_errno = ' '
           #         SELECT COUNT(*) INTO l_count FROM xrcb_t
           #          WHERE xrcbent = g_enterprise AND xrcbdocno = g_xrcf_d[l_ac].xrcf008 AND xrcbld = g_xrcald
           #         IF l_count < 1 THEN LET g_errno = 'axr-00150' END IF
           #      END IF
           #      IF NOT cl_null(g_errno) THEN
           #        INITIALIZE g_errparam TO NULL
           #        LET g_errparam.code = g_errno
           #        LET g_errparam.extend = g_xrcf_d[l_ac].xrcf008
           #        LET g_errparam.popup = TRUE
           #        CALL cl_err()
           #
           #        LET g_xrcf_d[l_ac].xrcf008 = g_xrcf_d_t.xrcf008
           #        NEXT FIELD CURRENT
           #      END IF
           #      CALL axrt300_06_xrcf('new')
           #   END IF
           #END IF
            #150401-00010#2 Mark ---(E)---
            #150401-00010#2 Add  ---(S)---
            IF NOT cl_null(g_xrcf_d[l_ac].xrcf008) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_xrcf_d[l_ac].xrcf008 != g_xrcf_d_t.xrcf008 OR g_xrcf_d_t.xrcf008 IS NULL )) THEN
                  LET l_count = 0
                  SELECT COUNT(*) INTO l_count FROM xrcb_t
                   WHERE xrcbent = g_enterprise AND xrcbdocno = g_xrcf_d[l_ac].xrcf008 AND xrcbld = g_xrcald
                  IF l_count < 1 THEN
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.code = 'axr-00150'
                    LET g_errparam.extend = g_xrcf_d[l_ac].xrcf008
                    LET g_errparam.popup = TRUE
                    CALL cl_err()

                    LET g_xrcf_d[l_ac].xrcf008 = g_xrcf_d_t.xrcf008
                    NEXT FIELD CURRENT
                  END IF
                  CALL axrt300_06_xrcf('new')
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf008
            #add-point:ON CHANGE xrcf008 name="input.g.page1.xrcf008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf009
            #add-point:BEFORE FIELD xrcf009 name="input.b.page1.xrcf009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf009
            
            #add-point:AFTER FIELD xrcf009 name="input.a.page1.xrcf009"
            #150401-00010#2 Mark ---(S)---
           #IF NOT cl_null(g_xrcf_d[l_ac].xrcf009) THEN
           #   IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_xrcf_d[l_ac].xrcf009 != g_xrcf_d_t.xrcf009 OR g_xrcf_d_t.xrcf009 IS NULL )) THEN
           #      LET l_count = 0
           #      IF g_xrcf_d[l_ac].xrcf008 IS NOT NULL THEN
           #         LET g_errno = ' '
           #         SELECT COUNT(*) INTO l_count FROM xrcb_t
           #          WHERE xrcbent = g_enterprise AND xrcbdocno = g_xrcf_d[l_ac].xrcf008 AND xrcbseq = g_xrcf_d[l_ac].xrcf009 AND xrcbld = g_xrcald
           #         IF l_count < 1 THEN LET g_errno = 'axr-00149' END IF
           #      END IF
           #      IF NOT cl_null(g_errno) THEN
           #        INITIALIZE g_errparam TO NULL
           #        LET g_errparam.code = g_errno
           #        LET g_errparam.extend = g_xrcf_d[l_ac].xrcf008
           #        LET g_errparam.popup = TRUE
           #        CALL cl_err()
           #
           #        LET g_xrcf_d[l_ac].xrcf008 = g_xrcf_d_t.xrcf008
           #        NEXT FIELD CURRENT
           #      END IF
           #      CALL axrt300_06_xrcf('new')
           #   END IF
           #END IF
            #150401-00010#2 Mark ---(E)---
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf009
            #add-point:ON CHANGE xrcf009 name="input.g.page1.xrcf009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf021_1_desc
            #add-point:BEFORE FIELD xrcf021_1_desc name="input.b.page1.xrcf021_1_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf021_1_desc
            
            #add-point:AFTER FIELD xrcf021_1_desc name="input.a.page1.xrcf021_1_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf021_1_desc
            #add-point:ON CHANGE xrcf021_1_desc name="input.g.page1.xrcf021_1_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf007
            #add-point:BEFORE FIELD xrcf007 name="input.b.page1.xrcf007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf007
            
            #add-point:AFTER FIELD xrcf007 name="input.a.page1.xrcf007"
            #150401-00010#2 Mark ---(S)---
           #IF NOT cl_null(g_xrcf_d[l_ac].xrcf007) THEN
           #   IF g_xrcf_d[l_ac].xrcf007 != g_xrcf_d_t.xrcf007 OR g_xrcf_d_t.xrcf007 IS NULL THEN
           #      IF NOT cl_null(g_xrcf_d[l_ac].xrcf008) AND NOT cl_null(g_xrcf_d[l_ac].xrcf009) THEN
           #         CALL axrt300_06_xrcf('amt')
           #         IF NOT cl_null(g_errno) THEN
           #            INITIALIZE g_errparam TO NULL
           #            LET g_errparam.code = g_errno
           #            LET g_errparam.extend = g_xrcf_d[l_ac].xrcf007
           #            LET g_errparam.popup = TRUE
           #            CALL cl_err()
           #
           #            LET g_xrcf_d[l_ac].xrcf007 = g_xrcf_d_t.xrcf007
           #            NEXT FIELD CURRENT
           #         END IF
           #         CALL axrt300_06_refresh('all')
           #      END IF
           #   END IF
           #END IF
            #150401-00010#2 Mark ---(E)---
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf007
            #add-point:ON CHANGE xrcf007 name="input.g.page1.xrcf007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf101
            #add-point:BEFORE FIELD xrcf101 name="input.b.page1.xrcf101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf101
            
            #add-point:AFTER FIELD xrcf101 name="input.a.page1.xrcf101"
            #150401-00010#2 Mark ---(S)---
           #IF NOT cl_null(g_xrcf_d[l_ac].xrcf101) THEN
           #   IF g_xrcf_d[l_ac].xrcf101 != g_xrcf_d_t.xrcf101 OR g_xrcf_d_t.xrcf101 IS NULL THEN
           #      IF NOT cl_null(g_xrcf_d[l_ac].xrcf008) AND NOT cl_null(g_xrcf_d[l_ac].xrcf009) THEN
           #         CALL axrt300_06_xrcf('amt')
           #         IF NOT cl_null(g_errno) THEN
           #            INITIALIZE g_errparam TO NULL
           #            LET g_errparam.code = g_errno
           #            LET g_errparam.extend = g_xrcf_d[l_ac].xrcf101
           #            LET g_errparam.popup = TRUE
           #            CALL cl_err()
           #
           #            LET g_xrcf_d[l_ac].xrcf007 = g_xrcf_d_t.xrcf101
           #            NEXT FIELD CURRENT
           #         END IF
           #         CALL axrt300_06_refresh('all')
           #      END IF
           #   END IF
           #END IF
            #150401-00010#2 Mark ---(E)---
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf101
            #add-point:ON CHANGE xrcf101 name="input.g.page1.xrcf101"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf103
            #add-point:BEFORE FIELD xrcf103 name="input.b.page1.xrcf103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf103
            
            #add-point:AFTER FIELD xrcf103 name="input.a.page1.xrcf103"
            IF NOT cl_null(g_xrcf_d[l_ac].xrcf103) THEN
               IF g_xrcf_d[l_ac].xrcf103 != g_xrcf_d_t.xrcf103 OR g_xrcf_d_t.xrcf103 IS NULL THEN
                 #IF NOT cl_null(g_xrcf_d[l_ac].xrcf008) AND NOT cl_null(g_xrcf_d[l_ac].xrcf009) THEN   #150401-00010#2 Mark
                  IF NOT cl_null(g_xrcf_d[l_ac].xrcf008) THEN   #150401-00010#2 Add
                     CALL axrt300_06_xrcf('amt')
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = g_xrcf_d[l_ac].xrcf103
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        LET g_xrcf_d[l_ac].xrcf103 = g_xrcf_d_t.xrcf103
                        NEXT FIELD CURRENT
                     END IF
                     CALL axrt300_06_refresh('mid')
                  END IF
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf103
            #add-point:ON CHANGE xrcf103 name="input.g.page1.xrcf103"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf104
            #add-point:BEFORE FIELD xrcf104 name="input.b.page1.xrcf104"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf104
            
            #add-point:AFTER FIELD xrcf104 name="input.a.page1.xrcf104"
            IF NOT cl_null(g_xrcf_d[l_ac].xrcf104) THEN
               IF g_xrcf_d[l_ac].xrcf104 != g_xrcf_d_t.xrcf104 OR g_xrcf_d_t.xrcf104 IS NULL THEN
                 #IF NOT cl_null(g_xrcf_d[l_ac].xrcf008) AND NOT cl_null(g_xrcf_d[l_ac].xrcf009) THEN   #150401-00010#2 Mark
                  IF NOT cl_null(g_xrcf_d[l_ac].xrcf008) THEN   #150401-00010#2 Add
                     CALL axrt300_06_xrcf('amt')
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = g_xrcf_d[l_ac].xrcf104
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        LET g_xrcf_d[l_ac].xrcf104 = g_xrcf_d_t.xrcf104
                        NEXT FIELD CURRENT
                     END IF
                     CALL axrt300_06_refresh('mid')
                  END IF
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf104
            #add-point:ON CHANGE xrcf104 name="input.g.page1.xrcf104"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf105
            #add-point:BEFORE FIELD xrcf105 name="input.b.page1.xrcf105"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf105
            
            #add-point:AFTER FIELD xrcf105 name="input.a.page1.xrcf105"
            IF NOT cl_null(g_xrcf_d[l_ac].xrcf105) THEN
               IF g_xrcf_d[l_ac].xrcf105 != g_xrcf_d_t.xrcf105 OR g_xrcf_d_t.xrcf105 IS NULL THEN
                 #IF NOT cl_null(g_xrcf_d[l_ac].xrcf008) AND NOT cl_null(g_xrcf_d[l_ac].xrcf009) THEN   #150401-00010#2 Mark
                  IF NOT cl_null(g_xrcf_d[l_ac].xrcf008) THEN   #150401-00010#2 Add
                     CALL axrt300_06_xrcf('amt')
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = g_xrcf_d[l_ac].xrcf105
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        LET g_xrcf_d[l_ac].xrcf105 = g_xrcf_d_t.xrcf105
                        NEXT FIELD CURRENT
                     END IF
                     CALL axrt300_06_refresh('mid')
                  END IF
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf105
            #add-point:ON CHANGE xrcf105 name="input.g.page1.xrcf105"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf106
            #add-point:BEFORE FIELD xrcf106 name="input.b.page1.xrcf106"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf106
            
            #add-point:AFTER FIELD xrcf106 name="input.a.page1.xrcf106"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf106
            #add-point:ON CHANGE xrcf106 name="input.g.page1.xrcf106"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf102
            #add-point:BEFORE FIELD xrcf102 name="input.b.page1.xrcf102"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf102
            
            #add-point:AFTER FIELD xrcf102 name="input.a.page1.xrcf102"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf102
            #add-point:ON CHANGE xrcf102 name="input.g.page1.xrcf102"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf111
            #add-point:BEFORE FIELD xrcf111 name="input.b.page1.xrcf111"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf111
            
            #add-point:AFTER FIELD xrcf111 name="input.a.page1.xrcf111"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf111
            #add-point:ON CHANGE xrcf111 name="input.g.page1.xrcf111"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf113
            #add-point:BEFORE FIELD xrcf113 name="input.b.page1.xrcf113"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf113
            
            #add-point:AFTER FIELD xrcf113 name="input.a.page1.xrcf113"
           #IF NOT cl_null(g_xrcf_d[l_ac].xrcf113) THEN
           #   IF g_xrcf_d[l_ac].xrcf113 != g_xrcf_d_t.xrcf113 OR g_xrcf_d_t.xrcf113 IS NULL THEN
           #      IF NOT cl_null(g_xrcf_d[l_ac].xrcf008) AND NOT cl_null(g_xrcf_d[l_ac].xrcf009) THEN
           #         CALL axrt300_06_xrcf('amt')
           #         IF NOT cl_null(g_errno) THEN
           #            INITIALIZE g_errparam TO NULL
           #            LET g_errparam.code = g_errno
           #            LET g_errparam.extend = g_xrcf_d[l_ac].xrcf113
           #            LET g_errparam.popup = TRUE
           #            CALL cl_err()
           #
           #            LET g_xrcf_d[l_ac].xrcf113 = g_xrcf_d_t.xrcf113
           #            NEXT FIELD CURRENT
           #         END IF
           #         CALL axrt300_06_refresh('lit1')
           #      END IF
           #   END IF
           #END IF

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf113
            #add-point:ON CHANGE xrcf113 name="input.g.page1.xrcf113"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf114
            #add-point:BEFORE FIELD xrcf114 name="input.b.page1.xrcf114"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf114
            
            #add-point:AFTER FIELD xrcf114 name="input.a.page1.xrcf114"
           #IF NOT cl_null(g_xrcf_d[l_ac].xrcf114) THEN
           #   IF g_xrcf_d[l_ac].xrcf114 != g_xrcf_d_t.xrcf114 OR g_xrcf_d_t.xrcf114 IS NULL THEN
           #      IF NOT cl_null(g_xrcf_d[l_ac].xrcf008) AND NOT cl_null(g_xrcf_d[l_ac].xrcf009) THEN
           #         CALL axrt300_06_xrcf('amt')
           #         IF NOT cl_null(g_errno) THEN
           #            INITIALIZE g_errparam TO NULL
           #            LET g_errparam.code = g_errno
           #            LET g_errparam.extend = g_xrcf_d[l_ac].xrcf114
           #            LET g_errparam.popup = TRUE
           #            CALL cl_err()
           #
           #            LET g_xrcf_d[l_ac].xrcf114 = g_xrcf_d_t.xrcf114
           #            NEXT FIELD CURRENT
           #         END IF
           #         CALL axrt300_06_refresh('lit1')
           #      END IF
           #   END IF
           #END IF

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf114
            #add-point:ON CHANGE xrcf114 name="input.g.page1.xrcf114"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf115
            #add-point:BEFORE FIELD xrcf115 name="input.b.page1.xrcf115"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf115
            
            #add-point:AFTER FIELD xrcf115 name="input.a.page1.xrcf115"
           #IF NOT cl_null(g_xrcf_d[l_ac].xrcf115) THEN
           #   IF g_xrcf_d[l_ac].xrcf115 != g_xrcf_d_t.xrcf115 OR g_xrcf_d_t.xrcf115 IS NULL THEN
           #      IF NOT cl_null(g_xrcf_d[l_ac].xrcf008) AND NOT cl_null(g_xrcf_d[l_ac].xrcf009) THEN
           #         CALL axrt300_06_xrcf('amt')
           #         IF NOT cl_null(g_errno) THEN
           #            INITIALIZE g_errparam TO NULL
           #            LET g_errparam.code = g_errno
           #            LET g_errparam.extend = g_xrcf_d[l_ac].xrcf115
           #            LET g_errparam.popup = TRUE
           #            CALL cl_err()
           #
           #            LET g_xrcf_d[l_ac].xrcf115 = g_xrcf_d_t.xrcf115
           #            NEXT FIELD CURRENT
           #         END IF
           #         CALL axrt300_06_refresh('lit1')
           #      END IF
           #   END IF
           #END IF

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf115
            #add-point:ON CHANGE xrcf115 name="input.g.page1.xrcf115"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf116
            #add-point:BEFORE FIELD xrcf116 name="input.b.page1.xrcf116"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf116
            
            #add-point:AFTER FIELD xrcf116 name="input.a.page1.xrcf116"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf116
            #add-point:ON CHANGE xrcf116 name="input.g.page1.xrcf116"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf117
            #add-point:BEFORE FIELD xrcf117 name="input.b.page1.xrcf117"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf117
            
            #add-point:AFTER FIELD xrcf117 name="input.a.page1.xrcf117"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf117
            #add-point:ON CHANGE xrcf117 name="input.g.page1.xrcf117"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.xrcfdocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcfdocno
            #add-point:ON ACTION controlp INFIELD xrcfdocno name="input.c.page1.xrcfdocno"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xrcfld
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcfld
            #add-point:ON ACTION controlp INFIELD xrcfld name="input.c.page1.xrcfld"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xrcfseq2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcfseq2
            #add-point:ON ACTION controlp INFIELD xrcfseq2 name="input.c.page1.xrcfseq2"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xrcfseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcfseq
            #add-point:ON ACTION controlp INFIELD xrcfseq name="input.c.page1.xrcfseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xrca001_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrca001_desc
            #add-point:ON ACTION controlp INFIELD xrca001_desc name="input.c.page1.xrca001_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xrcf008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf008
            #add-point:ON ACTION controlp INFIELD xrcf008 name="input.c.page1.xrcf008"
            #開窗i段   #20150419 flag
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		   	LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xrcf_d[l_ac].xrcf008            #給予default值

            #给与arg
            SELECT xrca057 INTO l_xrca057 FROM xrca_t
             WHERE xrcaent = g_enterprise AND xrcadocno = g_xrcadocno
               AND xrcald = g_xrcald
           #LET g_qryparam.arg1 = g_xrcb_d[l_ac_d].xrcb002
           #LET g_qryparam.arg2 = g_xrcb_d[l_ac_d].xrcb003
            LET g_qryparam.arg3 = g_xrcald
            LET g_qryparam.arg4 = l_xrca057
            CALL q_xrcadocno_6()                                        #呼叫開窗
            LET g_xrcf_d[l_ac].xrcf008 = g_qryparam.return1             #將開窗取得的值回傳到變數
           #LET g_xrcf_d[l_ac].xrcf009 = g_qryparam.return2             #將開窗取得的值回傳到變數   #150401-00010#2 Mark

            DISPLAY g_xrcf_d[l_ac].xrcf008 TO s_detail1[l_ac].xrcb002   #顯示到畫面上
           #DISPLAY g_xrcf_d[l_ac].xrcf009 TO s_detail1[l_ac].xrcb003   #顯示到畫面上   #150401-00010#2 Mark

            NEXT FIELD xrcf008                                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.xrcf009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf009
            #add-point:ON ACTION controlp INFIELD xrcf009 name="input.c.page1.xrcf009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xrcf021_1_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf021_1_desc
            #add-point:ON ACTION controlp INFIELD xrcf021_1_desc name="input.c.page1.xrcf021_1_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xrcf007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf007
            #add-point:ON ACTION controlp INFIELD xrcf007 name="input.c.page1.xrcf007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xrcf101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf101
            #add-point:ON ACTION controlp INFIELD xrcf101 name="input.c.page1.xrcf101"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xrcf103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf103
            #add-point:ON ACTION controlp INFIELD xrcf103 name="input.c.page1.xrcf103"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xrcf104
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf104
            #add-point:ON ACTION controlp INFIELD xrcf104 name="input.c.page1.xrcf104"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xrcf105
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf105
            #add-point:ON ACTION controlp INFIELD xrcf105 name="input.c.page1.xrcf105"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xrcf106
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf106
            #add-point:ON ACTION controlp INFIELD xrcf106 name="input.c.page1.xrcf106"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xrcf102
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf102
            #add-point:ON ACTION controlp INFIELD xrcf102 name="input.c.page1.xrcf102"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xrcf111
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf111
            #add-point:ON ACTION controlp INFIELD xrcf111 name="input.c.page1.xrcf111"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xrcf113
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf113
            #add-point:ON ACTION controlp INFIELD xrcf113 name="input.c.page1.xrcf113"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xrcf114
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf114
            #add-point:ON ACTION controlp INFIELD xrcf114 name="input.c.page1.xrcf114"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xrcf115
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf115
            #add-point:ON ACTION controlp INFIELD xrcf115 name="input.c.page1.xrcf115"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xrcf116
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf116
            #add-point:ON ACTION controlp INFIELD xrcf116 name="input.c.page1.xrcf116"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xrcf117
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf117
            #add-point:ON ACTION controlp INFIELD xrcf117 name="input.c.page1.xrcf117"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               CLOSE axrt300_06_bcl
               LET INT_FLAG = 0
               LET g_xrcf_d[l_ac].* = g_xrcf_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               #add-point:單身取消時 name="input.body.cancel"
               
               #end add-point
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_xrcf_d[l_ac].xrcfld 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_xrcf_d[l_ac].* = g_xrcf_d_t.*
            ELSE
               #寫入修改者/修改日期資訊(單身)
               
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL axrt300_06_xrcf_t_mask_restore('restore_mask_o')
 
               UPDATE xrcf_t SET (xrcfdocno,xrcfld,xrcfseq2,xrcfseq,xrcf008,xrcf009,xrcf021,xrcf007, 
                   xrcf101,xrcf103,xrcf104,xrcf105,xrcf106,xrcf102,xrcf111,xrcf113,xrcf114,xrcf115,xrcf116, 
                   xrcf117,xrcf022,xrcf024,xrcf025,xrcf122,xrcf123,xrcf124,xrcf125,xrcf126,xrcf127,xrcf132, 
                   xrcf133,xrcf134,xrcf135,xrcf136,xrcf137,xrcf049,xrcf023,xrcf033,xrcf026,xrcf027,xrcf028, 
                   xrcf031,xrcf032,xrcf034,xrcf035,xrcf036,xrcf037,xrcf038,xrcf039,xrcf040,xrcf041,xrcf042, 
                   xrcf043,xrcf044,xrcf045,xrcf046,xrcf047,xrcf048,xrcf001,xrcf002,xrcf010,xrcf020,xrcf029, 
                   xrcf030,xrcforga) = (g_xrcf_d[l_ac].xrcfdocno,g_xrcf_d[l_ac].xrcfld,g_xrcf_d[l_ac].xrcfseq2, 
                   g_xrcf_d[l_ac].xrcfseq,g_xrcf_d[l_ac].xrcf008,g_xrcf_d[l_ac].xrcf009,g_xrcf_d[l_ac].xrcf021, 
                   g_xrcf_d[l_ac].xrcf007,g_xrcf_d[l_ac].xrcf101,g_xrcf_d[l_ac].xrcf103,g_xrcf_d[l_ac].xrcf104, 
                   g_xrcf_d[l_ac].xrcf105,g_xrcf_d[l_ac].xrcf106,g_xrcf_d[l_ac].xrcf102,g_xrcf_d[l_ac].xrcf111, 
                   g_xrcf_d[l_ac].xrcf113,g_xrcf_d[l_ac].xrcf114,g_xrcf_d[l_ac].xrcf115,g_xrcf_d[l_ac].xrcf116, 
                   g_xrcf_d[l_ac].xrcf117,g_xrcf2_d[l_ac].xrcf022,g_xrcf2_d[l_ac].xrcf024,g_xrcf2_d[l_ac].xrcf025, 
                   g_xrcf3_d[l_ac].xrcf122,g_xrcf3_d[l_ac].xrcf123,g_xrcf3_d[l_ac].xrcf124,g_xrcf3_d[l_ac].xrcf125, 
                   g_xrcf3_d[l_ac].xrcf126,g_xrcf3_d[l_ac].xrcf127,g_xrcf3_d[l_ac].xrcf132,g_xrcf3_d[l_ac].xrcf133, 
                   g_xrcf3_d[l_ac].xrcf134,g_xrcf3_d[l_ac].xrcf135,g_xrcf3_d[l_ac].xrcf136,g_xrcf3_d[l_ac].xrcf137, 
                   g_xrcf4_d[l_ac].xrcf049,g_xrcf4_d[l_ac].xrcf023,g_xrcf4_d[l_ac].xrcf033,g_xrcf4_d[l_ac].xrcf026, 
                   g_xrcf4_d[l_ac].xrcf027,g_xrcf4_d[l_ac].xrcf028,g_xrcf4_d[l_ac].xrcf031,g_xrcf4_d[l_ac].xrcf032, 
                   g_xrcf4_d[l_ac].xrcf034,g_xrcf4_d[l_ac].xrcf035,g_xrcf4_d[l_ac].xrcf036,g_xrcf4_d[l_ac].xrcf037, 
                   g_xrcf4_d[l_ac].xrcf038,g_xrcf4_d[l_ac].xrcf039,g_xrcf4_d[l_ac].xrcf040,g_xrcf4_d[l_ac].xrcf041, 
                   g_xrcf4_d[l_ac].xrcf042,g_xrcf4_d[l_ac].xrcf043,g_xrcf4_d[l_ac].xrcf044,g_xrcf4_d[l_ac].xrcf045, 
                   g_xrcf4_d[l_ac].xrcf046,g_xrcf4_d[l_ac].xrcf047,g_xrcf4_d[l_ac].xrcf048,g_xrcf5_d[l_ac].xrcf001, 
                   g_xrcf5_d[l_ac].xrcf002,g_xrcf5_d[l_ac].xrcf010,g_xrcf5_d[l_ac].xrcf020,g_xrcf5_d[l_ac].xrcf029, 
                   g_xrcf5_d[l_ac].xrcf030,g_xrcf5_d[l_ac].xrcforga)
                WHERE xrcfent = g_enterprise AND
                  xrcfld = g_xrcf_d_t.xrcfld #項次   
                  AND xrcfdocno = g_xrcf_d_t.xrcfdocno  
                  AND xrcfseq = g_xrcf_d_t.xrcfseq  
                  AND xrcfseq2 = g_xrcf_d_t.xrcfseq2  
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xrcf_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xrcf_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xrcf_d[g_detail_idx].xrcfld
               LET gs_keys_bak[1] = g_xrcf_d_t.xrcfld
               LET gs_keys[2] = g_xrcf_d[g_detail_idx].xrcfdocno
               LET gs_keys_bak[2] = g_xrcf_d_t.xrcfdocno
               LET gs_keys[3] = g_xrcf_d[g_detail_idx].xrcfseq
               LET gs_keys_bak[3] = g_xrcf_d_t.xrcfseq
               LET gs_keys[4] = g_xrcf_d[g_detail_idx].xrcfseq2
               LET gs_keys_bak[4] = g_xrcf_d_t.xrcfseq2
               CALL axrt300_06_update_b('xrcf_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(修改)
                     LET g_log1 = util.JSON.stringify(g_xrcf_d_t)
                     LET g_log2 = util.JSON.stringify(g_xrcf_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL axrt300_06_xrcf_t_mask_restore('restore_mask_n')
               
               #add-point:單身修改後 name="input.body.a_update"
              #CALL axrt300_06_diff()   #150401-00010#2 Mark
               #end add-point
 
            END IF
            
         AFTER ROW
            CALL axrt300_06_unlock_b("xrcf_t")
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_xrcf_d[l_ac].* = g_xrcf_d_t.*
               END IF
               #add-point:單身after row name="input.body.a_close"
               
               #end add-point
            ELSE
            END IF
            #其他table進行unlock
            
             #add-point:單身after row name="input.body.a_row"
            
            #end add-point
            
         AFTER INPUT
            #add-point:單身input後 name="input.body.a_input"
            #150203-00010#4  Add  ---(S)---
            IF NOT INT_FLAG THEN
               CALL axrt300_06_diff()

               SELECT xrcadocdt,xrcacomp INTO l_xrcadocdt,l_xrcacomp FROM xrca_t WHERE xrcaent = g_enterprise
                  AND xrcadocno = g_xrcadocno
                  AND xrcald    = g_xrcald

               #获取单别
               CALL s_aooi200_fin_get_slip(g_xrcadocno) RETURNING l_success,l_slip
               #是否抛傳票
               CALL s_fin_get_doc_para(g_xrcald,l_xrcacomp,l_slip,'D-FIN-0030') RETURNING l_dfin0030

               SELECT glaa121 INTO l_glaa121 FROM glaa_t WHERE glaaent = g_enterprise
                  AND glaald = g_xrcald

               IF l_glaa121 = 'Y' AND l_dfin0030 = 'Y'THEN
                  CALL s_transaction_begin()   #161212-00024#1 Add
                  CALL s_pre_voucher_ins('AR','R10',g_xrcald,g_xrcadocno,l_xrcadocdt,'1')
                     RETURNING g_sub_success
                  #161212-00024#1 Add  ---(S)---
                  IF l_success THEN
                     CALL s_transaction_end('Y','1')
                  ELSE
                     CALL s_transaction_end('N','1')
                  END IF
                  #161212-00024#1 Add  ---(E)---
               END IF
               CALL axrt300_06_b_fill('')
               CONTINUE DIALOG
            END IF
            #150203-00010#4  Add  ---(E)---
            #end add-point
            #錯誤訊息統整顯示
            #CALL cl_err_collect_show()
            #CALL cl_showmsg()
            
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_xrcf_d[li_reproduce_target].* = g_xrcf_d[li_reproduce].*
               LET g_xrcf2_d[li_reproduce_target].* = g_xrcf2_d[li_reproduce].*
               LET g_xrcf3_d[li_reproduce_target].* = g_xrcf3_d[li_reproduce].*
               LET g_xrcf4_d[li_reproduce_target].* = g_xrcf4_d[li_reproduce].*
               LET g_xrcf5_d[li_reproduce_target].* = g_xrcf5_d[li_reproduce].*
 
               LET g_xrcf_d[li_reproduce_target].xrcfld = NULL
               LET g_xrcf_d[li_reproduce_target].xrcfdocno = NULL
               LET g_xrcf_d[li_reproduce_target].xrcfseq = NULL
               LET g_xrcf_d[li_reproduce_target].xrcfseq2 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_xrcf_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_xrcf_d.getLength()+1
            END IF
            
      END INPUT
      
      INPUT ARRAY g_xrcf2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_detail_cnt,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = FALSE, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_2)
         
         
         BEFORE INPUT
          CALL FGL_SET_ARR_CURR(g_detail_idx)
            
            CALL axrt300_06_b_fill(g_wc2)
            LET g_detail_cnt = g_xrcf2_d.getLength()
    
         BEFORE INSERT
            LET g_insert = 'Y' 
            NEXT FIELD xrcfld
 
            LET l_insert = TRUE
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_xrcf2_d[l_ac].* TO NULL 
            INITIALIZE g_xrcf2_d_t.* TO NULL
            INITIALIZE g_xrcf2_d_o.* TO NULL
            #公用欄位給值(單身2)
            
            #自定義預設值(單身2)
            
            #add-point:modify段before備份 name="input.body2.before_bak"
            
            #end add-point
            LET g_xrcf2_d_t.* = g_xrcf2_d[l_ac].*     #新輸入資料
            LET g_xrcf2_d_o.* = g_xrcf2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xrcf_d[li_reproduce_target].* = g_xrcf_d[li_reproduce].*
               LET g_xrcf2_d[li_reproduce_target].* = g_xrcf2_d[li_reproduce].*
               LET g_xrcf3_d[li_reproduce_target].* = g_xrcf3_d[li_reproduce].*
               LET g_xrcf4_d[li_reproduce_target].* = g_xrcf4_d[li_reproduce].*
               LET g_xrcf5_d[li_reproduce_target].* = g_xrcf5_d[li_reproduce].*
 
               LET g_xrcf2_d[li_reproduce_target].xrcfld = NULL
               LET g_xrcf2_d[li_reproduce_target].xrcfdocno = NULL
               LET g_xrcf2_d[li_reproduce_target].xrcfseq = NULL
               LET g_xrcf2_d[li_reproduce_target].xrcfseq2 = NULL
            END IF
            
 
 
 
 
 
            CALL axrt300_06_set_entry_b(l_cmd)
            CALL axrt300_06_set_no_entry_b(l_cmd)
            #add-point:modify段before insert name="input.body2.before_insert"
            
            #end add-point  
            
         BEFORE ROW 
            #add-point:modify段before row name="input.body2.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET l_ac = g_detail_idx
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
            DISPLAY g_xrcf2_d.getLength() TO FORMONLY.cnt
         
            CALL s_transaction_begin()
            
            LET g_detail_cnt = g_xrcf2_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_xrcf2_d[l_ac].xrcfld IS NOT NULL
               AND g_xrcf2_d[l_ac].xrcfdocno IS NOT NULL
               AND g_xrcf2_d[l_ac].xrcfseq IS NOT NULL
               AND g_xrcf2_d[l_ac].xrcfseq2 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_xrcf2_d_t.* = g_xrcf2_d[l_ac].*  #BACKUP
               LET g_xrcf2_d_o.* = g_xrcf2_d[l_ac].*  #BACKUP
               IF NOT axrt300_06_lock_b("xrcf_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH axrt300_06_bcl INTO g_xrcf_d[l_ac].xrcfdocno,g_xrcf_d[l_ac].xrcfld,g_xrcf_d[l_ac].xrcfseq2, 
                      g_xrcf_d[l_ac].xrcfseq,g_xrcf_d[l_ac].xrcf008,g_xrcf_d[l_ac].xrcf009,g_xrcf_d[l_ac].xrcf021, 
                      g_xrcf_d[l_ac].xrcf007,g_xrcf_d[l_ac].xrcf101,g_xrcf_d[l_ac].xrcf103,g_xrcf_d[l_ac].xrcf104, 
                      g_xrcf_d[l_ac].xrcf105,g_xrcf_d[l_ac].xrcf106,g_xrcf_d[l_ac].xrcf102,g_xrcf_d[l_ac].xrcf111, 
                      g_xrcf_d[l_ac].xrcf113,g_xrcf_d[l_ac].xrcf114,g_xrcf_d[l_ac].xrcf115,g_xrcf_d[l_ac].xrcf116, 
                      g_xrcf_d[l_ac].xrcf117,g_xrcf2_d[l_ac].xrcfdocno,g_xrcf2_d[l_ac].xrcfld,g_xrcf2_d[l_ac].xrcfseq, 
                      g_xrcf2_d[l_ac].xrcfseq2,g_xrcf2_d[l_ac].xrcf022,g_xrcf2_d[l_ac].xrcf024,g_xrcf2_d[l_ac].xrcf025, 
                      g_xrcf3_d[l_ac].xrcfdocno,g_xrcf3_d[l_ac].xrcfld,g_xrcf3_d[l_ac].xrcfseq,g_xrcf3_d[l_ac].xrcfseq2, 
                      g_xrcf3_d[l_ac].xrcf105,g_xrcf3_d[l_ac].xrcf102,g_xrcf3_d[l_ac].xrcf115,g_xrcf3_d[l_ac].xrcf122, 
                      g_xrcf3_d[l_ac].xrcf123,g_xrcf3_d[l_ac].xrcf124,g_xrcf3_d[l_ac].xrcf125,g_xrcf3_d[l_ac].xrcf126, 
                      g_xrcf3_d[l_ac].xrcf127,g_xrcf3_d[l_ac].xrcf132,g_xrcf3_d[l_ac].xrcf133,g_xrcf3_d[l_ac].xrcf134, 
                      g_xrcf3_d[l_ac].xrcf135,g_xrcf3_d[l_ac].xrcf136,g_xrcf3_d[l_ac].xrcf137,g_xrcf4_d[l_ac].xrcfdocno, 
                      g_xrcf4_d[l_ac].xrcfld,g_xrcf4_d[l_ac].xrcfseq,g_xrcf4_d[l_ac].xrcfseq2,g_xrcf4_d[l_ac].xrcf049, 
                      g_xrcf4_d[l_ac].xrcf021,g_xrcf4_d[l_ac].xrcf023,g_xrcf4_d[l_ac].xrcf033,g_xrcf4_d[l_ac].xrcf026, 
                      g_xrcf4_d[l_ac].xrcf027,g_xrcf4_d[l_ac].xrcf028,g_xrcf4_d[l_ac].xrcf031,g_xrcf4_d[l_ac].xrcf032, 
                      g_xrcf4_d[l_ac].xrcf034,g_xrcf4_d[l_ac].xrcf035,g_xrcf4_d[l_ac].xrcf036,g_xrcf4_d[l_ac].xrcf037, 
                      g_xrcf4_d[l_ac].xrcf038,g_xrcf4_d[l_ac].xrcf039,g_xrcf4_d[l_ac].xrcf040,g_xrcf4_d[l_ac].xrcf041, 
                      g_xrcf4_d[l_ac].xrcf042,g_xrcf4_d[l_ac].xrcf043,g_xrcf4_d[l_ac].xrcf044,g_xrcf4_d[l_ac].xrcf045, 
                      g_xrcf4_d[l_ac].xrcf046,g_xrcf4_d[l_ac].xrcf047,g_xrcf4_d[l_ac].xrcf048,g_xrcf5_d[l_ac].xrcfdocno, 
                      g_xrcf5_d[l_ac].xrcfld,g_xrcf5_d[l_ac].xrcfseq,g_xrcf5_d[l_ac].xrcfseq2,g_xrcf5_d[l_ac].xrcf001, 
                      g_xrcf5_d[l_ac].xrcf002,g_xrcf5_d[l_ac].xrcf010,g_xrcf5_d[l_ac].xrcf020,g_xrcf5_d[l_ac].xrcf029, 
                      g_xrcf5_d[l_ac].xrcf030,g_xrcf5_d[l_ac].xrcforga
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "FETCH axrt300_06_bcl:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_xrcf2_d_mask_o[l_ac].* =  g_xrcf2_d[l_ac].*
                  CALL axrt300_06_xrcf_t_mask()
                  LET g_xrcf2_d_mask_n[l_ac].* =  g_xrcf2_d[l_ac].*
                  
                  CALL cl_show_fld_cont()
                  CALL axrt300_06_detail_show()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL axrt300_06_set_entry_b(l_cmd)
            CALL axrt300_06_set_no_entry_b(l_cmd)
            #add-point:modify段before row name="input.body2.before_row"
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
 
 
 
 
            #其他table進行lock
            
 
 
 
 
 
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
            ELSE
               #add-point:單身2ask刪除前 name="input.body2.b_delete_ask"
               
               #end add-point 
            
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
               
               #add-point:單身2刪除前 name="input.body2.b_delete"
               
               #end add-point 
               
               DELETE FROM xrcf_t
                WHERE xrcfent = g_enterprise AND
                  xrcfld = g_xrcf2_d_t.xrcfld
                  AND xrcfdocno = g_xrcf2_d_t.xrcfdocno
                  AND xrcfseq = g_xrcf2_d_t.xrcfseq
                  AND xrcfseq2 = g_xrcf2_d_t.xrcfseq2
                  
               #add-point:單身2刪除中 name="input.body2.m_delete"
               
               #end add-point 
                  
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "xrcf_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
 
 
 
 
 
                  #add-point:單身2刪除後 name="input.body2.a_delete"
                  
                  #end add-point
                  #修改歷程記錄(刪除)
                  CALL axrt300_06_set_pk_array()
                  LET g_log1 = util.JSON.stringify(g_xrcf2_d[l_ac])   #(ver:38)
                  IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:38)
                  ELSE
                  END IF
               END IF 
               CLOSE axrt300_06_bcl
               #add-point:單身2刪除關閉bcl name="input.body2.close"
               
               #end add-point
               LET l_count = g_xrcf_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xrcf2_d_t.xrcfld
               LET gs_keys[2] = g_xrcf2_d_t.xrcfdocno
               LET gs_keys[3] = g_xrcf2_d_t.xrcfseq
               LET gs_keys[4] = g_xrcf2_d_t.xrcfseq2
 
               #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL axrt300_06_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
            END IF 
            
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2 name="input.body2.after_delete"
               
               #end add-point
                              CALL axrt300_06_delete_b('xrcf_t',gs_keys,"'2'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_xrcf2_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            #add-point:單身刪除後3 name="input.body2.after_delete3"
            
            #end add-point
 
         AFTER INSERT    
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM xrcf_t 
             WHERE xrcfent = g_enterprise AND
                   xrcfld = g_xrcf2_d[l_ac].xrcfld
                   AND xrcfdocno = g_xrcf2_d[l_ac].xrcfdocno
                   AND xrcfseq = g_xrcf2_d[l_ac].xrcfseq
                   AND xrcfseq2 = g_xrcf2_d[l_ac].xrcfseq2
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前 name="input.body2.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xrcf2_d[g_detail_idx].xrcfld
               LET gs_keys[2] = g_xrcf2_d[g_detail_idx].xrcfdocno
               LET gs_keys[3] = g_xrcf2_d[g_detail_idx].xrcfseq
               LET gs_keys[4] = g_xrcf2_d[g_detail_idx].xrcfseq2
               CALL axrt300_06_insert_b('xrcf_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2 name="input.body2.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_xrcf_d[l_ac].* TO NULL
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xrcf_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL axrt300_06_b_fill(g_wc2)
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body2.after_insert"
               
               #end add-point
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               LET g_wc2 = g_wc2, " OR (xrcfld = '", g_xrcf2_d[l_ac].xrcfld, "' "
                                  ," AND xrcfdocno = '", g_xrcf2_d[l_ac].xrcfdocno, "' "
                                  ," AND xrcfseq = '", g_xrcf2_d[l_ac].xrcfseq, "' "
                                  ," AND xrcfseq2 = '", g_xrcf2_d[l_ac].xrcfseq2, "' "
                                  ,")"
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               LET g_xrcf2_d[l_ac].* = g_xrcf2_d_t.*
               CLOSE axrt300_06_bcl
               #add-point:單身page2取消後 name="input.body2.cancel"
               
               #end add-point
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_xrcf2_d[l_ac].* = g_xrcf2_d_t.*
            ELSE
               
               #寫入修改者/修改日期資訊(單身2)
               
               
               #add-point:單身page2修改前 name="input.body2.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL axrt300_06_xrcf_t_mask_restore('restore_mask_o')
               
               UPDATE xrcf_t SET (xrcfdocno,xrcfld,xrcfseq2,xrcfseq,xrcf008,xrcf009,xrcf021,xrcf007, 
                   xrcf101,xrcf103,xrcf104,xrcf105,xrcf106,xrcf102,xrcf111,xrcf113,xrcf114,xrcf115,xrcf116, 
                   xrcf117,xrcf022,xrcf024,xrcf025,xrcf122,xrcf123,xrcf124,xrcf125,xrcf126,xrcf127,xrcf132, 
                   xrcf133,xrcf134,xrcf135,xrcf136,xrcf137,xrcf049,xrcf023,xrcf033,xrcf026,xrcf027,xrcf028, 
                   xrcf031,xrcf032,xrcf034,xrcf035,xrcf036,xrcf037,xrcf038,xrcf039,xrcf040,xrcf041,xrcf042, 
                   xrcf043,xrcf044,xrcf045,xrcf046,xrcf047,xrcf048,xrcf001,xrcf002,xrcf010,xrcf020,xrcf029, 
                   xrcf030,xrcforga) = (g_xrcf_d[l_ac].xrcfdocno,g_xrcf_d[l_ac].xrcfld,g_xrcf_d[l_ac].xrcfseq2, 
                   g_xrcf_d[l_ac].xrcfseq,g_xrcf_d[l_ac].xrcf008,g_xrcf_d[l_ac].xrcf009,g_xrcf_d[l_ac].xrcf021, 
                   g_xrcf_d[l_ac].xrcf007,g_xrcf_d[l_ac].xrcf101,g_xrcf_d[l_ac].xrcf103,g_xrcf_d[l_ac].xrcf104, 
                   g_xrcf_d[l_ac].xrcf105,g_xrcf_d[l_ac].xrcf106,g_xrcf_d[l_ac].xrcf102,g_xrcf_d[l_ac].xrcf111, 
                   g_xrcf_d[l_ac].xrcf113,g_xrcf_d[l_ac].xrcf114,g_xrcf_d[l_ac].xrcf115,g_xrcf_d[l_ac].xrcf116, 
                   g_xrcf_d[l_ac].xrcf117,g_xrcf2_d[l_ac].xrcf022,g_xrcf2_d[l_ac].xrcf024,g_xrcf2_d[l_ac].xrcf025, 
                   g_xrcf3_d[l_ac].xrcf122,g_xrcf3_d[l_ac].xrcf123,g_xrcf3_d[l_ac].xrcf124,g_xrcf3_d[l_ac].xrcf125, 
                   g_xrcf3_d[l_ac].xrcf126,g_xrcf3_d[l_ac].xrcf127,g_xrcf3_d[l_ac].xrcf132,g_xrcf3_d[l_ac].xrcf133, 
                   g_xrcf3_d[l_ac].xrcf134,g_xrcf3_d[l_ac].xrcf135,g_xrcf3_d[l_ac].xrcf136,g_xrcf3_d[l_ac].xrcf137, 
                   g_xrcf4_d[l_ac].xrcf049,g_xrcf4_d[l_ac].xrcf023,g_xrcf4_d[l_ac].xrcf033,g_xrcf4_d[l_ac].xrcf026, 
                   g_xrcf4_d[l_ac].xrcf027,g_xrcf4_d[l_ac].xrcf028,g_xrcf4_d[l_ac].xrcf031,g_xrcf4_d[l_ac].xrcf032, 
                   g_xrcf4_d[l_ac].xrcf034,g_xrcf4_d[l_ac].xrcf035,g_xrcf4_d[l_ac].xrcf036,g_xrcf4_d[l_ac].xrcf037, 
                   g_xrcf4_d[l_ac].xrcf038,g_xrcf4_d[l_ac].xrcf039,g_xrcf4_d[l_ac].xrcf040,g_xrcf4_d[l_ac].xrcf041, 
                   g_xrcf4_d[l_ac].xrcf042,g_xrcf4_d[l_ac].xrcf043,g_xrcf4_d[l_ac].xrcf044,g_xrcf4_d[l_ac].xrcf045, 
                   g_xrcf4_d[l_ac].xrcf046,g_xrcf4_d[l_ac].xrcf047,g_xrcf4_d[l_ac].xrcf048,g_xrcf5_d[l_ac].xrcf001, 
                   g_xrcf5_d[l_ac].xrcf002,g_xrcf5_d[l_ac].xrcf010,g_xrcf5_d[l_ac].xrcf020,g_xrcf5_d[l_ac].xrcf029, 
                   g_xrcf5_d[l_ac].xrcf030,g_xrcf5_d[l_ac].xrcforga) #自訂欄位頁簽
                WHERE xrcfent = g_enterprise AND
                  xrcfld = g_xrcf2_d_t.xrcfld #項次 
                  AND xrcfdocno = g_xrcf2_d_t.xrcfdocno
                  AND xrcfseq = g_xrcf2_d_t.xrcfseq
                  AND xrcfseq2 = g_xrcf2_d_t.xrcfseq2
                  
               #add-point:單身page2修改中 name="input.body2.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xrcf_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xrcf_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xrcf2_d[g_detail_idx].xrcfld
               LET gs_keys_bak[1] = g_xrcf2_d_t.xrcfld
               LET gs_keys[2] = g_xrcf2_d[g_detail_idx].xrcfdocno
               LET gs_keys_bak[2] = g_xrcf2_d_t.xrcfdocno
               LET gs_keys[3] = g_xrcf2_d[g_detail_idx].xrcfseq
               LET gs_keys_bak[3] = g_xrcf2_d_t.xrcfseq
               LET gs_keys[4] = g_xrcf2_d[g_detail_idx].xrcfseq2
               LET gs_keys_bak[4] = g_xrcf2_d_t.xrcfseq2
               CALL axrt300_06_update_b('xrcf_t',gs_keys,gs_keys_bak,"'2'")
                     #資料多語言用-增/改
                     
                     
                     #修改歷程記錄(修改)
                     LET g_log1 = util.JSON.stringify(g_xrcf2_d_t)
                     LET g_log2 = util.JSON.stringify(g_xrcf2_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL axrt300_06_xrcf_t_mask_restore('restore_mask_n')
               
               #add-point:單身page2修改後 name="input.body2.a_update"
               
               #end add-point
            END IF
         
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf022
            
            #add-point:AFTER FIELD xrcf022 name="input.a.page2.xrcf022"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf022
            #add-point:BEFORE FIELD xrcf022 name="input.b.page2.xrcf022"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf022
            #add-point:ON CHANGE xrcf022 name="input.g.page2.xrcf022"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf022_desc
            #add-point:BEFORE FIELD xrcf022_desc name="input.b.page2.xrcf022_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf022_desc
            
            #add-point:AFTER FIELD xrcf022_desc name="input.a.page2.xrcf022_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf022_desc
            #add-point:ON CHANGE xrcf022_desc name="input.g.page2.xrcf022_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf024
            
            #add-point:AFTER FIELD xrcf024 name="input.a.page2.xrcf024"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf024
            #add-point:BEFORE FIELD xrcf024 name="input.b.page2.xrcf024"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf024
            #add-point:ON CHANGE xrcf024 name="input.g.page2.xrcf024"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf024_desc
            #add-point:BEFORE FIELD xrcf024_desc name="input.b.page2.xrcf024_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf024_desc
            
            #add-point:AFTER FIELD xrcf024_desc name="input.a.page2.xrcf024_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf024_desc
            #add-point:ON CHANGE xrcf024_desc name="input.g.page2.xrcf024_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf025
            
            #add-point:AFTER FIELD xrcf025 name="input.a.page2.xrcf025"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf025
            #add-point:BEFORE FIELD xrcf025 name="input.b.page2.xrcf025"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf025
            #add-point:ON CHANGE xrcf025 name="input.g.page2.xrcf025"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf025_desc
            #add-point:BEFORE FIELD xrcf025_desc name="input.b.page2.xrcf025_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf025_desc
            
            #add-point:AFTER FIELD xrcf025_desc name="input.a.page2.xrcf025_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf025_desc
            #add-point:ON CHANGE xrcf025_desc name="input.g.page2.xrcf025_desc"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page2.xrcf022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf022
            #add-point:ON ACTION controlp INFIELD xrcf022 name="input.c.page2.xrcf022"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xrcf022_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf022_desc
            #add-point:ON ACTION controlp INFIELD xrcf022_desc name="input.c.page2.xrcf022_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xrcf024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf024
            #add-point:ON ACTION controlp INFIELD xrcf024 name="input.c.page2.xrcf024"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xrcf024_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf024_desc
            #add-point:ON ACTION controlp INFIELD xrcf024_desc name="input.c.page2.xrcf024_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xrcf025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf025
            #add-point:ON ACTION controlp INFIELD xrcf025 name="input.c.page2.xrcf025"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xrcf025_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf025_desc
            #add-point:ON ACTION controlp INFIELD xrcf025_desc name="input.c.page2.xrcf025_desc"
            
            #END add-point
 
 
 
 
         AFTER ROW
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_xrcf2_d[l_ac].* = g_xrcf2_d_t.*
               END IF
               CLOSE axrt300_06_bcl
               #add-point:單身after row name="input.body2.a_close"
               
               #end add-point
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
 
            CALL axrt300_06_unlock_b("xrcf_t")
            #add-point:單身after row name="input.body2.a_row"
            
            #end add-point
            
         AFTER INPUT
            #add-point:單身2input後 name="input.body2.a_input"
            
            #end add-point
         
         #複製上一次指定的單身資料至最下方
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_xrcf_d[li_reproduce_target].* = g_xrcf_d[li_reproduce].*
               LET g_xrcf2_d[li_reproduce_target].* = g_xrcf2_d[li_reproduce].*
               LET g_xrcf3_d[li_reproduce_target].* = g_xrcf3_d[li_reproduce].*
               LET g_xrcf4_d[li_reproduce_target].* = g_xrcf4_d[li_reproduce].*
               LET g_xrcf5_d[li_reproduce_target].* = g_xrcf5_d[li_reproduce].*
 
               LET g_xrcf2_d[li_reproduce_target].xrcfld = NULL
               LET g_xrcf2_d[li_reproduce_target].xrcfdocno = NULL
               LET g_xrcf2_d[li_reproduce_target].xrcfseq = NULL
               LET g_xrcf2_d[li_reproduce_target].xrcfseq2 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_xrcf2_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_xrcf2_d.getLength()+1
            END IF
      END INPUT
      INPUT ARRAY g_xrcf3_d FROM s_detail3.*
         ATTRIBUTE(COUNT = g_detail_cnt,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = FALSE, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_3)
         
         
         BEFORE INPUT
          CALL FGL_SET_ARR_CURR(g_detail_idx)
            
            CALL axrt300_06_b_fill(g_wc2)
            LET g_detail_cnt = g_xrcf3_d.getLength()
    
         BEFORE INSERT
            LET g_insert = 'Y' 
            NEXT FIELD xrcfld
 
            LET l_insert = TRUE
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_xrcf3_d[l_ac].* TO NULL 
            INITIALIZE g_xrcf3_d_t.* TO NULL
            INITIALIZE g_xrcf3_d_o.* TO NULL
            #公用欄位給值(單身3)
            
            #自定義預設值(單身3)
                  LET g_xrcf3_d[l_ac].xrcf124 = "0"
      LET g_xrcf3_d[l_ac].xrcf125 = "0"
      LET g_xrcf3_d[l_ac].xrcf126 = "0"
      LET g_xrcf3_d[l_ac].xrcf127 = "0"
      LET g_xrcf3_d[l_ac].xrcf133 = "0"
      LET g_xrcf3_d[l_ac].xrcf134 = "0"
      LET g_xrcf3_d[l_ac].xrcf135 = "0"
      LET g_xrcf3_d[l_ac].xrcf136 = "0"
      LET g_xrcf3_d[l_ac].xrcf137 = "0"
 
            #add-point:modify段before備份 name="input.body3.before_bak"
            
            #end add-point
            LET g_xrcf3_d_t.* = g_xrcf3_d[l_ac].*     #新輸入資料
            LET g_xrcf3_d_o.* = g_xrcf3_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xrcf_d[li_reproduce_target].* = g_xrcf_d[li_reproduce].*
               LET g_xrcf2_d[li_reproduce_target].* = g_xrcf2_d[li_reproduce].*
               LET g_xrcf3_d[li_reproduce_target].* = g_xrcf3_d[li_reproduce].*
               LET g_xrcf4_d[li_reproduce_target].* = g_xrcf4_d[li_reproduce].*
               LET g_xrcf5_d[li_reproduce_target].* = g_xrcf5_d[li_reproduce].*
 
               LET g_xrcf3_d[li_reproduce_target].xrcfld = NULL
               LET g_xrcf3_d[li_reproduce_target].xrcfdocno = NULL
               LET g_xrcf3_d[li_reproduce_target].xrcfseq = NULL
               LET g_xrcf3_d[li_reproduce_target].xrcfseq2 = NULL
            END IF
            
 
 
 
 
 
            CALL axrt300_06_set_entry_b(l_cmd)
            CALL axrt300_06_set_no_entry_b(l_cmd)
            #add-point:modify段before insert name="input.body3.before_insert"
            
            #end add-point  
            
         BEFORE ROW 
            #add-point:modify段before row name="input.body3.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail3")
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET l_ac = g_detail_idx
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
            DISPLAY g_xrcf3_d.getLength() TO FORMONLY.cnt
         
            CALL s_transaction_begin()
            
            LET g_detail_cnt = g_xrcf3_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_xrcf3_d[l_ac].xrcfld IS NOT NULL
               AND g_xrcf3_d[l_ac].xrcfdocno IS NOT NULL
               AND g_xrcf3_d[l_ac].xrcfseq IS NOT NULL
               AND g_xrcf3_d[l_ac].xrcfseq2 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_xrcf3_d_t.* = g_xrcf3_d[l_ac].*  #BACKUP
               LET g_xrcf3_d_o.* = g_xrcf3_d[l_ac].*  #BACKUP
               IF NOT axrt300_06_lock_b("xrcf_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH axrt300_06_bcl INTO g_xrcf_d[l_ac].xrcfdocno,g_xrcf_d[l_ac].xrcfld,g_xrcf_d[l_ac].xrcfseq2, 
                      g_xrcf_d[l_ac].xrcfseq,g_xrcf_d[l_ac].xrcf008,g_xrcf_d[l_ac].xrcf009,g_xrcf_d[l_ac].xrcf021, 
                      g_xrcf_d[l_ac].xrcf007,g_xrcf_d[l_ac].xrcf101,g_xrcf_d[l_ac].xrcf103,g_xrcf_d[l_ac].xrcf104, 
                      g_xrcf_d[l_ac].xrcf105,g_xrcf_d[l_ac].xrcf106,g_xrcf_d[l_ac].xrcf102,g_xrcf_d[l_ac].xrcf111, 
                      g_xrcf_d[l_ac].xrcf113,g_xrcf_d[l_ac].xrcf114,g_xrcf_d[l_ac].xrcf115,g_xrcf_d[l_ac].xrcf116, 
                      g_xrcf_d[l_ac].xrcf117,g_xrcf2_d[l_ac].xrcfdocno,g_xrcf2_d[l_ac].xrcfld,g_xrcf2_d[l_ac].xrcfseq, 
                      g_xrcf2_d[l_ac].xrcfseq2,g_xrcf2_d[l_ac].xrcf022,g_xrcf2_d[l_ac].xrcf024,g_xrcf2_d[l_ac].xrcf025, 
                      g_xrcf3_d[l_ac].xrcfdocno,g_xrcf3_d[l_ac].xrcfld,g_xrcf3_d[l_ac].xrcfseq,g_xrcf3_d[l_ac].xrcfseq2, 
                      g_xrcf3_d[l_ac].xrcf105,g_xrcf3_d[l_ac].xrcf102,g_xrcf3_d[l_ac].xrcf115,g_xrcf3_d[l_ac].xrcf122, 
                      g_xrcf3_d[l_ac].xrcf123,g_xrcf3_d[l_ac].xrcf124,g_xrcf3_d[l_ac].xrcf125,g_xrcf3_d[l_ac].xrcf126, 
                      g_xrcf3_d[l_ac].xrcf127,g_xrcf3_d[l_ac].xrcf132,g_xrcf3_d[l_ac].xrcf133,g_xrcf3_d[l_ac].xrcf134, 
                      g_xrcf3_d[l_ac].xrcf135,g_xrcf3_d[l_ac].xrcf136,g_xrcf3_d[l_ac].xrcf137,g_xrcf4_d[l_ac].xrcfdocno, 
                      g_xrcf4_d[l_ac].xrcfld,g_xrcf4_d[l_ac].xrcfseq,g_xrcf4_d[l_ac].xrcfseq2,g_xrcf4_d[l_ac].xrcf049, 
                      g_xrcf4_d[l_ac].xrcf021,g_xrcf4_d[l_ac].xrcf023,g_xrcf4_d[l_ac].xrcf033,g_xrcf4_d[l_ac].xrcf026, 
                      g_xrcf4_d[l_ac].xrcf027,g_xrcf4_d[l_ac].xrcf028,g_xrcf4_d[l_ac].xrcf031,g_xrcf4_d[l_ac].xrcf032, 
                      g_xrcf4_d[l_ac].xrcf034,g_xrcf4_d[l_ac].xrcf035,g_xrcf4_d[l_ac].xrcf036,g_xrcf4_d[l_ac].xrcf037, 
                      g_xrcf4_d[l_ac].xrcf038,g_xrcf4_d[l_ac].xrcf039,g_xrcf4_d[l_ac].xrcf040,g_xrcf4_d[l_ac].xrcf041, 
                      g_xrcf4_d[l_ac].xrcf042,g_xrcf4_d[l_ac].xrcf043,g_xrcf4_d[l_ac].xrcf044,g_xrcf4_d[l_ac].xrcf045, 
                      g_xrcf4_d[l_ac].xrcf046,g_xrcf4_d[l_ac].xrcf047,g_xrcf4_d[l_ac].xrcf048,g_xrcf5_d[l_ac].xrcfdocno, 
                      g_xrcf5_d[l_ac].xrcfld,g_xrcf5_d[l_ac].xrcfseq,g_xrcf5_d[l_ac].xrcfseq2,g_xrcf5_d[l_ac].xrcf001, 
                      g_xrcf5_d[l_ac].xrcf002,g_xrcf5_d[l_ac].xrcf010,g_xrcf5_d[l_ac].xrcf020,g_xrcf5_d[l_ac].xrcf029, 
                      g_xrcf5_d[l_ac].xrcf030,g_xrcf5_d[l_ac].xrcforga
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "FETCH axrt300_06_bcl:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_xrcf3_d_mask_o[l_ac].* =  g_xrcf3_d[l_ac].*
                  CALL axrt300_06_xrcf_t_mask()
                  LET g_xrcf3_d_mask_n[l_ac].* =  g_xrcf3_d[l_ac].*
                  
                  CALL cl_show_fld_cont()
                  CALL axrt300_06_detail_show()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL axrt300_06_set_entry_b(l_cmd)
            CALL axrt300_06_set_no_entry_b(l_cmd)
            #add-point:modify段before row name="input.body3.before_row"
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
 
 
 
 
            #其他table進行lock
            
 
 
 
 
 
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
            ELSE
               #add-point:單身3ask刪除前 name="input.body3.b_delete_ask"
               
               #end add-point 
            
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
               
               #add-point:單身3刪除前 name="input.body3.b_delete"
               
               #end add-point 
               
               DELETE FROM xrcf_t
                WHERE xrcfent = g_enterprise AND
                  xrcfld = g_xrcf3_d_t.xrcfld
                  AND xrcfdocno = g_xrcf3_d_t.xrcfdocno
                  AND xrcfseq = g_xrcf3_d_t.xrcfseq
                  AND xrcfseq2 = g_xrcf3_d_t.xrcfseq2
                  
               #add-point:單身3刪除中 name="input.body3.m_delete"
               
               #end add-point 
                  
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "xrcf_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
 
 
 
 
 
                  #add-point:單身3刪除後 name="input.body3.a_delete"
                  
                  #end add-point
                  #修改歷程記錄(刪除)
                  CALL axrt300_06_set_pk_array()
                  LET g_log1 = util.JSON.stringify(g_xrcf3_d[l_ac])   #(ver:38)
                  IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:38)
                  ELSE
                  END IF
               END IF 
               CLOSE axrt300_06_bcl
               #add-point:單身3刪除關閉bcl name="input.body3.close"
               
               #end add-point
               LET l_count = g_xrcf_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xrcf3_d_t.xrcfld
               LET gs_keys[2] = g_xrcf3_d_t.xrcfdocno
               LET gs_keys[3] = g_xrcf3_d_t.xrcfseq
               LET gs_keys[4] = g_xrcf3_d_t.xrcfseq2
 
               #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL axrt300_06_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
            END IF 
            
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2 name="input.body3.after_delete"
               
               #end add-point
                              CALL axrt300_06_delete_b('xrcf_t',gs_keys,"'3'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_xrcf3_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            #add-point:單身刪除後3 name="input.body3.after_delete3"
            
            #end add-point
 
         AFTER INSERT    
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM xrcf_t 
             WHERE xrcfent = g_enterprise AND
                   xrcfld = g_xrcf3_d[l_ac].xrcfld
                   AND xrcfdocno = g_xrcf3_d[l_ac].xrcfdocno
                   AND xrcfseq = g_xrcf3_d[l_ac].xrcfseq
                   AND xrcfseq2 = g_xrcf3_d[l_ac].xrcfseq2
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身3新增前 name="input.body3.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xrcf3_d[g_detail_idx].xrcfld
               LET gs_keys[2] = g_xrcf3_d[g_detail_idx].xrcfdocno
               LET gs_keys[3] = g_xrcf3_d[g_detail_idx].xrcfseq
               LET gs_keys[4] = g_xrcf3_d[g_detail_idx].xrcfseq2
               CALL axrt300_06_insert_b('xrcf_t',gs_keys,"'3'")
                           
               #add-point:單身新增後3 name="input.body3.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_xrcf_d[l_ac].* TO NULL
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xrcf_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL axrt300_06_b_fill(g_wc2)
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body3.after_insert"
               
               #end add-point
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               LET g_wc2 = g_wc2, " OR (xrcfld = '", g_xrcf3_d[l_ac].xrcfld, "' "
                                  ," AND xrcfdocno = '", g_xrcf3_d[l_ac].xrcfdocno, "' "
                                  ," AND xrcfseq = '", g_xrcf3_d[l_ac].xrcfseq, "' "
                                  ," AND xrcfseq2 = '", g_xrcf3_d[l_ac].xrcfseq2, "' "
                                  ,")"
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               LET g_xrcf3_d[l_ac].* = g_xrcf3_d_t.*
               CLOSE axrt300_06_bcl
               #add-point:單身page3取消後 name="input.body3.cancel"
               
               #end add-point
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_xrcf3_d[l_ac].* = g_xrcf3_d_t.*
            ELSE
               
               #寫入修改者/修改日期資訊(單身3)
               
               
               #add-point:單身page3修改前 name="input.body3.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL axrt300_06_xrcf_t_mask_restore('restore_mask_o')
               
               UPDATE xrcf_t SET (xrcfdocno,xrcfld,xrcfseq2,xrcfseq,xrcf008,xrcf009,xrcf021,xrcf007, 
                   xrcf101,xrcf103,xrcf104,xrcf105,xrcf106,xrcf102,xrcf111,xrcf113,xrcf114,xrcf115,xrcf116, 
                   xrcf117,xrcf022,xrcf024,xrcf025,xrcf122,xrcf123,xrcf124,xrcf125,xrcf126,xrcf127,xrcf132, 
                   xrcf133,xrcf134,xrcf135,xrcf136,xrcf137,xrcf049,xrcf023,xrcf033,xrcf026,xrcf027,xrcf028, 
                   xrcf031,xrcf032,xrcf034,xrcf035,xrcf036,xrcf037,xrcf038,xrcf039,xrcf040,xrcf041,xrcf042, 
                   xrcf043,xrcf044,xrcf045,xrcf046,xrcf047,xrcf048,xrcf001,xrcf002,xrcf010,xrcf020,xrcf029, 
                   xrcf030,xrcforga) = (g_xrcf_d[l_ac].xrcfdocno,g_xrcf_d[l_ac].xrcfld,g_xrcf_d[l_ac].xrcfseq2, 
                   g_xrcf_d[l_ac].xrcfseq,g_xrcf_d[l_ac].xrcf008,g_xrcf_d[l_ac].xrcf009,g_xrcf_d[l_ac].xrcf021, 
                   g_xrcf_d[l_ac].xrcf007,g_xrcf_d[l_ac].xrcf101,g_xrcf_d[l_ac].xrcf103,g_xrcf_d[l_ac].xrcf104, 
                   g_xrcf_d[l_ac].xrcf105,g_xrcf_d[l_ac].xrcf106,g_xrcf_d[l_ac].xrcf102,g_xrcf_d[l_ac].xrcf111, 
                   g_xrcf_d[l_ac].xrcf113,g_xrcf_d[l_ac].xrcf114,g_xrcf_d[l_ac].xrcf115,g_xrcf_d[l_ac].xrcf116, 
                   g_xrcf_d[l_ac].xrcf117,g_xrcf2_d[l_ac].xrcf022,g_xrcf2_d[l_ac].xrcf024,g_xrcf2_d[l_ac].xrcf025, 
                   g_xrcf3_d[l_ac].xrcf122,g_xrcf3_d[l_ac].xrcf123,g_xrcf3_d[l_ac].xrcf124,g_xrcf3_d[l_ac].xrcf125, 
                   g_xrcf3_d[l_ac].xrcf126,g_xrcf3_d[l_ac].xrcf127,g_xrcf3_d[l_ac].xrcf132,g_xrcf3_d[l_ac].xrcf133, 
                   g_xrcf3_d[l_ac].xrcf134,g_xrcf3_d[l_ac].xrcf135,g_xrcf3_d[l_ac].xrcf136,g_xrcf3_d[l_ac].xrcf137, 
                   g_xrcf4_d[l_ac].xrcf049,g_xrcf4_d[l_ac].xrcf023,g_xrcf4_d[l_ac].xrcf033,g_xrcf4_d[l_ac].xrcf026, 
                   g_xrcf4_d[l_ac].xrcf027,g_xrcf4_d[l_ac].xrcf028,g_xrcf4_d[l_ac].xrcf031,g_xrcf4_d[l_ac].xrcf032, 
                   g_xrcf4_d[l_ac].xrcf034,g_xrcf4_d[l_ac].xrcf035,g_xrcf4_d[l_ac].xrcf036,g_xrcf4_d[l_ac].xrcf037, 
                   g_xrcf4_d[l_ac].xrcf038,g_xrcf4_d[l_ac].xrcf039,g_xrcf4_d[l_ac].xrcf040,g_xrcf4_d[l_ac].xrcf041, 
                   g_xrcf4_d[l_ac].xrcf042,g_xrcf4_d[l_ac].xrcf043,g_xrcf4_d[l_ac].xrcf044,g_xrcf4_d[l_ac].xrcf045, 
                   g_xrcf4_d[l_ac].xrcf046,g_xrcf4_d[l_ac].xrcf047,g_xrcf4_d[l_ac].xrcf048,g_xrcf5_d[l_ac].xrcf001, 
                   g_xrcf5_d[l_ac].xrcf002,g_xrcf5_d[l_ac].xrcf010,g_xrcf5_d[l_ac].xrcf020,g_xrcf5_d[l_ac].xrcf029, 
                   g_xrcf5_d[l_ac].xrcf030,g_xrcf5_d[l_ac].xrcforga) #自訂欄位頁簽
                WHERE xrcfent = g_enterprise AND
                  xrcfld = g_xrcf3_d_t.xrcfld #項次 
                  AND xrcfdocno = g_xrcf3_d_t.xrcfdocno
                  AND xrcfseq = g_xrcf3_d_t.xrcfseq
                  AND xrcfseq2 = g_xrcf3_d_t.xrcfseq2
                  
               #add-point:單身page3修改中 name="input.body3.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xrcf_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xrcf_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xrcf3_d[g_detail_idx].xrcfld
               LET gs_keys_bak[1] = g_xrcf3_d_t.xrcfld
               LET gs_keys[2] = g_xrcf3_d[g_detail_idx].xrcfdocno
               LET gs_keys_bak[2] = g_xrcf3_d_t.xrcfdocno
               LET gs_keys[3] = g_xrcf3_d[g_detail_idx].xrcfseq
               LET gs_keys_bak[3] = g_xrcf3_d_t.xrcfseq
               LET gs_keys[4] = g_xrcf3_d[g_detail_idx].xrcfseq2
               LET gs_keys_bak[4] = g_xrcf3_d_t.xrcfseq2
               CALL axrt300_06_update_b('xrcf_t',gs_keys,gs_keys_bak,"'3'")
                     #資料多語言用-增/改
                     
                     
                     #修改歷程記錄(修改)
                     LET g_log1 = util.JSON.stringify(g_xrcf3_d_t)
                     LET g_log2 = util.JSON.stringify(g_xrcf3_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL axrt300_06_xrcf_t_mask_restore('restore_mask_n')
               
               #add-point:單身page3修改後 name="input.body3.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf105_1
            #add-point:BEFORE FIELD xrcf105_1 name="input.b.page3.xrcf105_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf105_1
            
            #add-point:AFTER FIELD xrcf105_1 name="input.a.page3.xrcf105_1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf105_1
            #add-point:ON CHANGE xrcf105_1 name="input.g.page3.xrcf105_1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf102_1
            #add-point:BEFORE FIELD xrcf102_1 name="input.b.page3.xrcf102_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf102_1
            
            #add-point:AFTER FIELD xrcf102_1 name="input.a.page3.xrcf102_1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf102_1
            #add-point:ON CHANGE xrcf102_1 name="input.g.page3.xrcf102_1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf115_1
            #add-point:BEFORE FIELD xrcf115_1 name="input.b.page3.xrcf115_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf115_1
            
            #add-point:AFTER FIELD xrcf115_1 name="input.a.page3.xrcf115_1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf115_1
            #add-point:ON CHANGE xrcf115_1 name="input.g.page3.xrcf115_1"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf122
            
            #add-point:AFTER FIELD xrcf122 name="input.a.page3.xrcf122"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf122
            #add-point:BEFORE FIELD xrcf122 name="input.b.page3.xrcf122"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf122
            #add-point:ON CHANGE xrcf122 name="input.g.page3.xrcf122"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf122_desc
            #add-point:BEFORE FIELD xrcf122_desc name="input.b.page3.xrcf122_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf122_desc
            
            #add-point:AFTER FIELD xrcf122_desc name="input.a.page3.xrcf122_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf122_desc
            #add-point:ON CHANGE xrcf122_desc name="input.g.page3.xrcf122_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf123
            #add-point:BEFORE FIELD xrcf123 name="input.b.page3.xrcf123"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf123
            
            #add-point:AFTER FIELD xrcf123 name="input.a.page3.xrcf123"
            IF NOT cl_null(g_xrcf3_d[l_ac].xrcf123) THEN   #20150419 flag
               IF g_xrcf3_d[l_ac].xrcf123 != g_xrcf3_d_t.xrcf123 OR g_xrcf3_d_t.xrcf123 IS NULL THEN
                 #IF NOT cl_null(g_xrcf_d[l_ac].xrcf008) AND NOT cl_null(g_xrcf_d[l_ac].xrcf009) THEN   #150401-00010#2 Mark
                  IF NOT cl_null(g_xrcf_d[l_ac].xrcf008) THEN   #150401-00010#2 Add
                     CALL axrt300_06_xrcf('amt')
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = g_xrcf_d[l_ac].xrcf115
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        LET g_xrcf_d[l_ac].xrcf115 = g_xrcf_d_t.xrcf115
                        NEXT FIELD CURRENT
                     END IF
                     CALL axrt300_06_refresh('lit2')
                  END IF
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf123
            #add-point:ON CHANGE xrcf123 name="input.g.page3.xrcf123"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf124
            #add-point:BEFORE FIELD xrcf124 name="input.b.page3.xrcf124"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf124
            
            #add-point:AFTER FIELD xrcf124 name="input.a.page3.xrcf124"
            IF NOT cl_null(g_xrcf3_d[l_ac].xrcf124) THEN   #20150419 flag
               IF g_xrcf3_d[l_ac].xrcf124 != g_xrcf3_d_t.xrcf124 OR g_xrcf3_d_t.xrcf124 IS NULL THEN
                 #IF NOT cl_null(g_xrcf_d[l_ac].xrcf008) AND NOT cl_null(g_xrcf_d[l_ac].xrcf009) THEN   #150401-00010#2 Mark
                  IF NOT cl_null(g_xrcf_d[l_ac].xrcf008) THEN   #150401-00010#2 Add
                     CALL axrt300_06_xrcf('amt')
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = g_xrcf3_d[l_ac].xrcf124
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        LET g_xrcf3_d[l_ac].xrcf124 = g_xrcf3_d_t.xrcf124
                        NEXT FIELD CURRENT
                     END IF
                     CALL axrt300_06_refresh('lit2')
                  END IF
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf124
            #add-point:ON CHANGE xrcf124 name="input.g.page3.xrcf124"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf125
            #add-point:BEFORE FIELD xrcf125 name="input.b.page3.xrcf125"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf125
            
            #add-point:AFTER FIELD xrcf125 name="input.a.page3.xrcf125"
            IF NOT cl_null(g_xrcf3_d[l_ac].xrcf125) THEN   #20150419 flag
               IF g_xrcf3_d[l_ac].xrcf125 != g_xrcf3_d_t.xrcf125 OR g_xrcf3_d_t.xrcf125 IS NULL THEN
                 #IF NOT cl_null(g_xrcf_d[l_ac].xrcf008) AND NOT cl_null(g_xrcf_d[l_ac].xrcf009) THEN   #150401-00010#2 Mark
                  IF NOT cl_null(g_xrcf_d[l_ac].xrcf008) THEN   #150401-00010#2 Add
                     CALL axrt300_06_xrcf('amt')
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = g_xrcf3_d[l_ac].xrcf125
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        LET g_xrcf3_d[l_ac].xrcf125 = g_xrcf3_d_t.xrcf125
                        NEXT FIELD CURRENT
                     END IF
                     CALL axrt300_06_refresh('lit2')
                  END IF
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf125
            #add-point:ON CHANGE xrcf125 name="input.g.page3.xrcf125"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf126
            #add-point:BEFORE FIELD xrcf126 name="input.b.page3.xrcf126"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf126
            
            #add-point:AFTER FIELD xrcf126 name="input.a.page3.xrcf126"
            IF NOT cl_null(g_xrcf3_d[l_ac].xrcf126) THEN   #20150419 flag
               IF g_xrcf3_d[l_ac].xrcf126 != g_xrcf3_d_t.xrcf126 OR g_xrcf3_d_t.xrcf126 IS NULL THEN
                 #IF NOT cl_null(g_xrcf_d[l_ac].xrcf008) AND NOT cl_null(g_xrcf_d[l_ac].xrcf009) THEN   #150401-00010#2 Mark
                  IF NOT cl_null(g_xrcf_d[l_ac].xrcf008) THEN   #150401-00010#2 Add
                     CALL axrt300_06_xrcf('amt')
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = g_xrcf3_d[l_ac].xrcf126
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        LET g_xrcf3_d[l_ac].xrcf126 = g_xrcf3_d_t.xrcf126
                        NEXT FIELD CURRENT
                     END IF
                     CALL axrt300_06_refresh('lit2')
                  END IF
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf126
            #add-point:ON CHANGE xrcf126 name="input.g.page3.xrcf126"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf127
            #add-point:BEFORE FIELD xrcf127 name="input.b.page3.xrcf127"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf127
            
            #add-point:AFTER FIELD xrcf127 name="input.a.page3.xrcf127"
            IF NOT cl_null(g_xrcf3_d[l_ac].xrcf127) THEN   #20150419 flag
               IF g_xrcf3_d[l_ac].xrcf127 != g_xrcf3_d_t.xrcf127 OR g_xrcf3_d_t.xrcf127 IS NULL THEN
                 #IF NOT cl_null(g_xrcf_d[l_ac].xrcf008) AND NOT cl_null(g_xrcf_d[l_ac].xrcf009) THEN   #150401-00010#2 Mark
                  IF NOT cl_null(g_xrcf_d[l_ac].xrcf008) THEN   #150401-00010#2 Add
                     CALL axrt300_06_xrcf('amt')
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = g_xrcf3_d[l_ac].xrcf127
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        LET g_xrcf3_d[l_ac].xrcf127 = g_xrcf3_d_t.xrcf127
                        NEXT FIELD CURRENT
                     END IF
                     CALL axrt300_06_refresh('lit2')
                  END IF
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf127
            #add-point:ON CHANGE xrcf127 name="input.g.page3.xrcf127"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf132
            
            #add-point:AFTER FIELD xrcf132 name="input.a.page3.xrcf132"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf132
            #add-point:BEFORE FIELD xrcf132 name="input.b.page3.xrcf132"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf132
            #add-point:ON CHANGE xrcf132 name="input.g.page3.xrcf132"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf132_desc
            #add-point:BEFORE FIELD xrcf132_desc name="input.b.page3.xrcf132_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf132_desc
            
            #add-point:AFTER FIELD xrcf132_desc name="input.a.page3.xrcf132_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf132_desc
            #add-point:ON CHANGE xrcf132_desc name="input.g.page3.xrcf132_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf133
            #add-point:BEFORE FIELD xrcf133 name="input.b.page3.xrcf133"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf133
            
            #add-point:AFTER FIELD xrcf133 name="input.a.page3.xrcf133"
            IF NOT cl_null(g_xrcf3_d[l_ac].xrcf133) THEN   #20150419 flag
               IF g_xrcf3_d[l_ac].xrcf133 != g_xrcf3_d_t.xrcf133 OR g_xrcf3_d_t.xrcf133 IS NULL THEN
                 #IF NOT cl_null(g_xrcf_d[l_ac].xrcf008) AND NOT cl_null(g_xrcf_d[l_ac].xrcf009) THEN   #150401-00010#2 Mark
                  IF NOT cl_null(g_xrcf_d[l_ac].xrcf008) THEN   #150401-00010#2 Add
                     CALL axrt300_06_xrcf('amt')
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = g_xrcf3_d[l_ac].xrcf133
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        LET g_xrcf3_d[l_ac].xrcf133 = g_xrcf3_d_t.xrcf133
                        NEXT FIELD CURRENT
                     END IF
                     CALL axrt300_06_refresh('lit3')
                  END IF
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf133
            #add-point:ON CHANGE xrcf133 name="input.g.page3.xrcf133"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf134
            #add-point:BEFORE FIELD xrcf134 name="input.b.page3.xrcf134"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf134
            
            #add-point:AFTER FIELD xrcf134 name="input.a.page3.xrcf134"
            IF NOT cl_null(g_xrcf3_d[l_ac].xrcf134) THEN   #20150419 flag
               IF g_xrcf3_d[l_ac].xrcf134 != g_xrcf3_d_t.xrcf134 OR g_xrcf3_d_t.xrcf134 IS NULL THEN
                 #IF NOT cl_null(g_xrcf_d[l_ac].xrcf008) AND NOT cl_null(g_xrcf_d[l_ac].xrcf009) THEN   #150401-00010#2 Mark
                  IF NOT cl_null(g_xrcf_d[l_ac].xrcf008) THEN   #150401-00010#2 Add
                     CALL axrt300_06_xrcf('amt')
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = g_xrcf3_d[l_ac].xrcf134
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        LET g_xrcf3_d[l_ac].xrcf134 = g_xrcf3_d_t.xrcf134
                        NEXT FIELD CURRENT
                     END IF
                     CALL axrt300_06_refresh('lit3')
                  END IF
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf134
            #add-point:ON CHANGE xrcf134 name="input.g.page3.xrcf134"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf135
            #add-point:BEFORE FIELD xrcf135 name="input.b.page3.xrcf135"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf135
            
            #add-point:AFTER FIELD xrcf135 name="input.a.page3.xrcf135"
            IF NOT cl_null(g_xrcf3_d[l_ac].xrcf135) THEN   #20150419 flag
               IF g_xrcf3_d[l_ac].xrcf135 != g_xrcf3_d_t.xrcf135 OR g_xrcf3_d_t.xrcf135 IS NULL THEN
                 #IF NOT cl_null(g_xrcf_d[l_ac].xrcf008) AND NOT cl_null(g_xrcf_d[l_ac].xrcf009) THEN   #150401-00010#2 Mark
                  IF NOT cl_null(g_xrcf_d[l_ac].xrcf008) THEN   #150401-00010#2 Add
                     CALL axrt300_06_xrcf('amt')
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = g_xrcf3_d[l_ac].xrcf135
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        LET g_xrcf3_d[l_ac].xrcf135 = g_xrcf3_d_t.xrcf135
                        NEXT FIELD CURRENT
                     END IF
                     CALL axrt300_06_refresh('lit3')
                  END IF
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf135
            #add-point:ON CHANGE xrcf135 name="input.g.page3.xrcf135"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf136
            #add-point:BEFORE FIELD xrcf136 name="input.b.page3.xrcf136"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf136
            
            #add-point:AFTER FIELD xrcf136 name="input.a.page3.xrcf136"
            IF NOT cl_null(g_xrcf3_d[l_ac].xrcf136) THEN   #20150419 flag
               IF g_xrcf3_d[l_ac].xrcf136 != g_xrcf3_d_t.xrcf136 OR g_xrcf3_d_t.xrcf136 IS NULL THEN
                 #IF NOT cl_null(g_xrcf_d[l_ac].xrcf008) AND NOT cl_null(g_xrcf_d[l_ac].xrcf009) THEN   #150401-00010#2 Mark
                  IF NOT cl_null(g_xrcf_d[l_ac].xrcf008) THEN   #150401-00010#2 Add
                     CALL axrt300_06_xrcf('amt')
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = g_xrcf3_d[l_ac].xrcf136
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        LET g_xrcf3_d[l_ac].xrcf136 = g_xrcf3_d_t.xrcf136
                        NEXT FIELD CURRENT
                     END IF
                     CALL axrt300_06_refresh('lit3')
                  END IF
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf136
            #add-point:ON CHANGE xrcf136 name="input.g.page3.xrcf136"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf137
            #add-point:BEFORE FIELD xrcf137 name="input.b.page3.xrcf137"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf137
            
            #add-point:AFTER FIELD xrcf137 name="input.a.page3.xrcf137"
            IF NOT cl_null(g_xrcf3_d[l_ac].xrcf137) THEN   #20150419 flag
               IF g_xrcf3_d[l_ac].xrcf137 != g_xrcf3_d_t.xrcf137 OR g_xrcf3_d_t.xrcf137 IS NULL THEN
                 #IF NOT cl_null(g_xrcf_d[l_ac].xrcf008) AND NOT cl_null(g_xrcf_d[l_ac].xrcf009) THEN   #150401-00010#2 Mark
                  IF NOT cl_null(g_xrcf_d[l_ac].xrcf008) THEN   #150401-00010#2 Add
                     CALL axrt300_06_xrcf('amt')
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = g_xrcf3_d[l_ac].xrcf137
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        LET g_xrcf3_d[l_ac].xrcf137 = g_xrcf3_d_t.xrcf137
                        NEXT FIELD CURRENT
                     END IF
                     CALL axrt300_06_refresh('lit3')
                  END IF
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf137
            #add-point:ON CHANGE xrcf137 name="input.g.page3.xrcf137"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page3.xrcf105_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf105_1
            #add-point:ON ACTION controlp INFIELD xrcf105_1 name="input.c.page3.xrcf105_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.xrcf102_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf102_1
            #add-point:ON ACTION controlp INFIELD xrcf102_1 name="input.c.page3.xrcf102_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.xrcf115_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf115_1
            #add-point:ON ACTION controlp INFIELD xrcf115_1 name="input.c.page3.xrcf115_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.xrcf122
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf122
            #add-point:ON ACTION controlp INFIELD xrcf122 name="input.c.page3.xrcf122"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.xrcf122_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf122_desc
            #add-point:ON ACTION controlp INFIELD xrcf122_desc name="input.c.page3.xrcf122_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.xrcf123
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf123
            #add-point:ON ACTION controlp INFIELD xrcf123 name="input.c.page3.xrcf123"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.xrcf124
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf124
            #add-point:ON ACTION controlp INFIELD xrcf124 name="input.c.page3.xrcf124"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.xrcf125
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf125
            #add-point:ON ACTION controlp INFIELD xrcf125 name="input.c.page3.xrcf125"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.xrcf126
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf126
            #add-point:ON ACTION controlp INFIELD xrcf126 name="input.c.page3.xrcf126"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.xrcf127
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf127
            #add-point:ON ACTION controlp INFIELD xrcf127 name="input.c.page3.xrcf127"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.xrcf132
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf132
            #add-point:ON ACTION controlp INFIELD xrcf132 name="input.c.page3.xrcf132"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.xrcf132_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf132_desc
            #add-point:ON ACTION controlp INFIELD xrcf132_desc name="input.c.page3.xrcf132_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.xrcf133
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf133
            #add-point:ON ACTION controlp INFIELD xrcf133 name="input.c.page3.xrcf133"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.xrcf134
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf134
            #add-point:ON ACTION controlp INFIELD xrcf134 name="input.c.page3.xrcf134"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.xrcf135
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf135
            #add-point:ON ACTION controlp INFIELD xrcf135 name="input.c.page3.xrcf135"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.xrcf136
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf136
            #add-point:ON ACTION controlp INFIELD xrcf136 name="input.c.page3.xrcf136"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.xrcf137
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf137
            #add-point:ON ACTION controlp INFIELD xrcf137 name="input.c.page3.xrcf137"
            
            #END add-point
 
 
 
 
         AFTER ROW
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_xrcf3_d[l_ac].* = g_xrcf3_d_t.*
               END IF
               CLOSE axrt300_06_bcl
               #add-point:單身after row name="input.body3.a_close"
               
               #end add-point
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
 
            CALL axrt300_06_unlock_b("xrcf_t")
            #add-point:單身after row name="input.body3.a_row"
            
            #end add-point
            
         AFTER INPUT
            #add-point:單身3input後 name="input.body3.a_input"
            
            #end add-point
         
         #複製上一次指定的單身資料至最下方
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_xrcf_d[li_reproduce_target].* = g_xrcf_d[li_reproduce].*
               LET g_xrcf2_d[li_reproduce_target].* = g_xrcf2_d[li_reproduce].*
               LET g_xrcf3_d[li_reproduce_target].* = g_xrcf3_d[li_reproduce].*
               LET g_xrcf4_d[li_reproduce_target].* = g_xrcf4_d[li_reproduce].*
               LET g_xrcf5_d[li_reproduce_target].* = g_xrcf5_d[li_reproduce].*
 
               LET g_xrcf3_d[li_reproduce_target].xrcfld = NULL
               LET g_xrcf3_d[li_reproduce_target].xrcfdocno = NULL
               LET g_xrcf3_d[li_reproduce_target].xrcfseq = NULL
               LET g_xrcf3_d[li_reproduce_target].xrcfseq2 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_xrcf3_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_xrcf3_d.getLength()+1
            END IF
      END INPUT
      INPUT ARRAY g_xrcf4_d FROM s_detail4.*
         ATTRIBUTE(COUNT = g_detail_cnt,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = FALSE, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_4)
         
         
         BEFORE INPUT
          CALL FGL_SET_ARR_CURR(g_detail_idx)
            
            CALL axrt300_06_b_fill(g_wc2)
            LET g_detail_cnt = g_xrcf4_d.getLength()
    
         BEFORE INSERT
            LET g_insert = 'Y' 
            NEXT FIELD xrcfld
 
            LET l_insert = TRUE
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_xrcf4_d[l_ac].* TO NULL 
            INITIALIZE g_xrcf4_d_t.* TO NULL
            INITIALIZE g_xrcf4_d_o.* TO NULL
            #公用欄位給值(單身4)
            
            #自定義預設值(單身4)
            
            #add-point:modify段before備份 name="input.body4.before_bak"
            
            #end add-point
            LET g_xrcf4_d_t.* = g_xrcf4_d[l_ac].*     #新輸入資料
            LET g_xrcf4_d_o.* = g_xrcf4_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xrcf_d[li_reproduce_target].* = g_xrcf_d[li_reproduce].*
               LET g_xrcf2_d[li_reproduce_target].* = g_xrcf2_d[li_reproduce].*
               LET g_xrcf3_d[li_reproduce_target].* = g_xrcf3_d[li_reproduce].*
               LET g_xrcf4_d[li_reproduce_target].* = g_xrcf4_d[li_reproduce].*
               LET g_xrcf5_d[li_reproduce_target].* = g_xrcf5_d[li_reproduce].*
 
               LET g_xrcf4_d[li_reproduce_target].xrcfld = NULL
               LET g_xrcf4_d[li_reproduce_target].xrcfdocno = NULL
               LET g_xrcf4_d[li_reproduce_target].xrcfseq = NULL
               LET g_xrcf4_d[li_reproduce_target].xrcfseq2 = NULL
            END IF
            
 
 
 
 
 
            CALL axrt300_06_set_entry_b(l_cmd)
            CALL axrt300_06_set_no_entry_b(l_cmd)
            #add-point:modify段before insert name="input.body4.before_insert"
            
            #end add-point  
            
         BEFORE ROW 
            #add-point:modify段before row name="input.body4.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail4")
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET l_ac = g_detail_idx
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
            DISPLAY g_xrcf4_d.getLength() TO FORMONLY.cnt
         
            CALL s_transaction_begin()
            
            LET g_detail_cnt = g_xrcf4_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_xrcf4_d[l_ac].xrcfld IS NOT NULL
               AND g_xrcf4_d[l_ac].xrcfdocno IS NOT NULL
               AND g_xrcf4_d[l_ac].xrcfseq IS NOT NULL
               AND g_xrcf4_d[l_ac].xrcfseq2 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_xrcf4_d_t.* = g_xrcf4_d[l_ac].*  #BACKUP
               LET g_xrcf4_d_o.* = g_xrcf4_d[l_ac].*  #BACKUP
               IF NOT axrt300_06_lock_b("xrcf_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH axrt300_06_bcl INTO g_xrcf_d[l_ac].xrcfdocno,g_xrcf_d[l_ac].xrcfld,g_xrcf_d[l_ac].xrcfseq2, 
                      g_xrcf_d[l_ac].xrcfseq,g_xrcf_d[l_ac].xrcf008,g_xrcf_d[l_ac].xrcf009,g_xrcf_d[l_ac].xrcf021, 
                      g_xrcf_d[l_ac].xrcf007,g_xrcf_d[l_ac].xrcf101,g_xrcf_d[l_ac].xrcf103,g_xrcf_d[l_ac].xrcf104, 
                      g_xrcf_d[l_ac].xrcf105,g_xrcf_d[l_ac].xrcf106,g_xrcf_d[l_ac].xrcf102,g_xrcf_d[l_ac].xrcf111, 
                      g_xrcf_d[l_ac].xrcf113,g_xrcf_d[l_ac].xrcf114,g_xrcf_d[l_ac].xrcf115,g_xrcf_d[l_ac].xrcf116, 
                      g_xrcf_d[l_ac].xrcf117,g_xrcf2_d[l_ac].xrcfdocno,g_xrcf2_d[l_ac].xrcfld,g_xrcf2_d[l_ac].xrcfseq, 
                      g_xrcf2_d[l_ac].xrcfseq2,g_xrcf2_d[l_ac].xrcf022,g_xrcf2_d[l_ac].xrcf024,g_xrcf2_d[l_ac].xrcf025, 
                      g_xrcf3_d[l_ac].xrcfdocno,g_xrcf3_d[l_ac].xrcfld,g_xrcf3_d[l_ac].xrcfseq,g_xrcf3_d[l_ac].xrcfseq2, 
                      g_xrcf3_d[l_ac].xrcf105,g_xrcf3_d[l_ac].xrcf102,g_xrcf3_d[l_ac].xrcf115,g_xrcf3_d[l_ac].xrcf122, 
                      g_xrcf3_d[l_ac].xrcf123,g_xrcf3_d[l_ac].xrcf124,g_xrcf3_d[l_ac].xrcf125,g_xrcf3_d[l_ac].xrcf126, 
                      g_xrcf3_d[l_ac].xrcf127,g_xrcf3_d[l_ac].xrcf132,g_xrcf3_d[l_ac].xrcf133,g_xrcf3_d[l_ac].xrcf134, 
                      g_xrcf3_d[l_ac].xrcf135,g_xrcf3_d[l_ac].xrcf136,g_xrcf3_d[l_ac].xrcf137,g_xrcf4_d[l_ac].xrcfdocno, 
                      g_xrcf4_d[l_ac].xrcfld,g_xrcf4_d[l_ac].xrcfseq,g_xrcf4_d[l_ac].xrcfseq2,g_xrcf4_d[l_ac].xrcf049, 
                      g_xrcf4_d[l_ac].xrcf021,g_xrcf4_d[l_ac].xrcf023,g_xrcf4_d[l_ac].xrcf033,g_xrcf4_d[l_ac].xrcf026, 
                      g_xrcf4_d[l_ac].xrcf027,g_xrcf4_d[l_ac].xrcf028,g_xrcf4_d[l_ac].xrcf031,g_xrcf4_d[l_ac].xrcf032, 
                      g_xrcf4_d[l_ac].xrcf034,g_xrcf4_d[l_ac].xrcf035,g_xrcf4_d[l_ac].xrcf036,g_xrcf4_d[l_ac].xrcf037, 
                      g_xrcf4_d[l_ac].xrcf038,g_xrcf4_d[l_ac].xrcf039,g_xrcf4_d[l_ac].xrcf040,g_xrcf4_d[l_ac].xrcf041, 
                      g_xrcf4_d[l_ac].xrcf042,g_xrcf4_d[l_ac].xrcf043,g_xrcf4_d[l_ac].xrcf044,g_xrcf4_d[l_ac].xrcf045, 
                      g_xrcf4_d[l_ac].xrcf046,g_xrcf4_d[l_ac].xrcf047,g_xrcf4_d[l_ac].xrcf048,g_xrcf5_d[l_ac].xrcfdocno, 
                      g_xrcf5_d[l_ac].xrcfld,g_xrcf5_d[l_ac].xrcfseq,g_xrcf5_d[l_ac].xrcfseq2,g_xrcf5_d[l_ac].xrcf001, 
                      g_xrcf5_d[l_ac].xrcf002,g_xrcf5_d[l_ac].xrcf010,g_xrcf5_d[l_ac].xrcf020,g_xrcf5_d[l_ac].xrcf029, 
                      g_xrcf5_d[l_ac].xrcf030,g_xrcf5_d[l_ac].xrcforga
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "FETCH axrt300_06_bcl:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_xrcf4_d_mask_o[l_ac].* =  g_xrcf4_d[l_ac].*
                  CALL axrt300_06_xrcf_t_mask()
                  LET g_xrcf4_d_mask_n[l_ac].* =  g_xrcf4_d[l_ac].*
                  
                  CALL cl_show_fld_cont()
                  CALL axrt300_06_detail_show()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL axrt300_06_set_entry_b(l_cmd)
            CALL axrt300_06_set_no_entry_b(l_cmd)
            #add-point:modify段before row name="input.body4.before_row"
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
 
 
 
 
            #其他table進行lock
            
 
 
 
 
 
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
            ELSE
               #add-point:單身4ask刪除前 name="input.body4.b_delete_ask"
               
               #end add-point 
            
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
               
               #add-point:單身4刪除前 name="input.body4.b_delete"
               
               #end add-point 
               
               DELETE FROM xrcf_t
                WHERE xrcfent = g_enterprise AND
                  xrcfld = g_xrcf4_d_t.xrcfld
                  AND xrcfdocno = g_xrcf4_d_t.xrcfdocno
                  AND xrcfseq = g_xrcf4_d_t.xrcfseq
                  AND xrcfseq2 = g_xrcf4_d_t.xrcfseq2
                  
               #add-point:單身4刪除中 name="input.body4.m_delete"
               
               #end add-point 
                  
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "xrcf_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
 
 
 
 
 
                  #add-point:單身4刪除後 name="input.body4.a_delete"
                  
                  #end add-point
                  #修改歷程記錄(刪除)
                  CALL axrt300_06_set_pk_array()
                  LET g_log1 = util.JSON.stringify(g_xrcf4_d[l_ac])   #(ver:38)
                  IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:38)
                  ELSE
                  END IF
               END IF 
               CLOSE axrt300_06_bcl
               #add-point:單身4刪除關閉bcl name="input.body4.close"
               
               #end add-point
               LET l_count = g_xrcf_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xrcf4_d_t.xrcfld
               LET gs_keys[2] = g_xrcf4_d_t.xrcfdocno
               LET gs_keys[3] = g_xrcf4_d_t.xrcfseq
               LET gs_keys[4] = g_xrcf4_d_t.xrcfseq2
 
               #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL axrt300_06_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
            END IF 
            
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2 name="input.body4.after_delete"
               
               #end add-point
                              CALL axrt300_06_delete_b('xrcf_t',gs_keys,"'4'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_xrcf4_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            #add-point:單身刪除後3 name="input.body4.after_delete3"
            
            #end add-point
 
         AFTER INSERT    
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM xrcf_t 
             WHERE xrcfent = g_enterprise AND
                   xrcfld = g_xrcf4_d[l_ac].xrcfld
                   AND xrcfdocno = g_xrcf4_d[l_ac].xrcfdocno
                   AND xrcfseq = g_xrcf4_d[l_ac].xrcfseq
                   AND xrcfseq2 = g_xrcf4_d[l_ac].xrcfseq2
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身4新增前 name="input.body4.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xrcf4_d[g_detail_idx].xrcfld
               LET gs_keys[2] = g_xrcf4_d[g_detail_idx].xrcfdocno
               LET gs_keys[3] = g_xrcf4_d[g_detail_idx].xrcfseq
               LET gs_keys[4] = g_xrcf4_d[g_detail_idx].xrcfseq2
               CALL axrt300_06_insert_b('xrcf_t',gs_keys,"'4'")
                           
               #add-point:單身新增後4 name="input.body4.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_xrcf_d[l_ac].* TO NULL
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xrcf_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL axrt300_06_b_fill(g_wc2)
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body4.after_insert"
               
               #end add-point
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               LET g_wc2 = g_wc2, " OR (xrcfld = '", g_xrcf4_d[l_ac].xrcfld, "' "
                                  ," AND xrcfdocno = '", g_xrcf4_d[l_ac].xrcfdocno, "' "
                                  ," AND xrcfseq = '", g_xrcf4_d[l_ac].xrcfseq, "' "
                                  ," AND xrcfseq2 = '", g_xrcf4_d[l_ac].xrcfseq2, "' "
                                  ,")"
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               LET g_xrcf4_d[l_ac].* = g_xrcf4_d_t.*
               CLOSE axrt300_06_bcl
               #add-point:單身page4取消後 name="input.body4.cancel"
               
               #end add-point
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_xrcf4_d[l_ac].* = g_xrcf4_d_t.*
            ELSE
               
               #寫入修改者/修改日期資訊(單身4)
               
               
               #add-point:單身page4修改前 name="input.body4.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL axrt300_06_xrcf_t_mask_restore('restore_mask_o')
               
               UPDATE xrcf_t SET (xrcfdocno,xrcfld,xrcfseq2,xrcfseq,xrcf008,xrcf009,xrcf021,xrcf007, 
                   xrcf101,xrcf103,xrcf104,xrcf105,xrcf106,xrcf102,xrcf111,xrcf113,xrcf114,xrcf115,xrcf116, 
                   xrcf117,xrcf022,xrcf024,xrcf025,xrcf122,xrcf123,xrcf124,xrcf125,xrcf126,xrcf127,xrcf132, 
                   xrcf133,xrcf134,xrcf135,xrcf136,xrcf137,xrcf049,xrcf023,xrcf033,xrcf026,xrcf027,xrcf028, 
                   xrcf031,xrcf032,xrcf034,xrcf035,xrcf036,xrcf037,xrcf038,xrcf039,xrcf040,xrcf041,xrcf042, 
                   xrcf043,xrcf044,xrcf045,xrcf046,xrcf047,xrcf048,xrcf001,xrcf002,xrcf010,xrcf020,xrcf029, 
                   xrcf030,xrcforga) = (g_xrcf_d[l_ac].xrcfdocno,g_xrcf_d[l_ac].xrcfld,g_xrcf_d[l_ac].xrcfseq2, 
                   g_xrcf_d[l_ac].xrcfseq,g_xrcf_d[l_ac].xrcf008,g_xrcf_d[l_ac].xrcf009,g_xrcf_d[l_ac].xrcf021, 
                   g_xrcf_d[l_ac].xrcf007,g_xrcf_d[l_ac].xrcf101,g_xrcf_d[l_ac].xrcf103,g_xrcf_d[l_ac].xrcf104, 
                   g_xrcf_d[l_ac].xrcf105,g_xrcf_d[l_ac].xrcf106,g_xrcf_d[l_ac].xrcf102,g_xrcf_d[l_ac].xrcf111, 
                   g_xrcf_d[l_ac].xrcf113,g_xrcf_d[l_ac].xrcf114,g_xrcf_d[l_ac].xrcf115,g_xrcf_d[l_ac].xrcf116, 
                   g_xrcf_d[l_ac].xrcf117,g_xrcf2_d[l_ac].xrcf022,g_xrcf2_d[l_ac].xrcf024,g_xrcf2_d[l_ac].xrcf025, 
                   g_xrcf3_d[l_ac].xrcf122,g_xrcf3_d[l_ac].xrcf123,g_xrcf3_d[l_ac].xrcf124,g_xrcf3_d[l_ac].xrcf125, 
                   g_xrcf3_d[l_ac].xrcf126,g_xrcf3_d[l_ac].xrcf127,g_xrcf3_d[l_ac].xrcf132,g_xrcf3_d[l_ac].xrcf133, 
                   g_xrcf3_d[l_ac].xrcf134,g_xrcf3_d[l_ac].xrcf135,g_xrcf3_d[l_ac].xrcf136,g_xrcf3_d[l_ac].xrcf137, 
                   g_xrcf4_d[l_ac].xrcf049,g_xrcf4_d[l_ac].xrcf023,g_xrcf4_d[l_ac].xrcf033,g_xrcf4_d[l_ac].xrcf026, 
                   g_xrcf4_d[l_ac].xrcf027,g_xrcf4_d[l_ac].xrcf028,g_xrcf4_d[l_ac].xrcf031,g_xrcf4_d[l_ac].xrcf032, 
                   g_xrcf4_d[l_ac].xrcf034,g_xrcf4_d[l_ac].xrcf035,g_xrcf4_d[l_ac].xrcf036,g_xrcf4_d[l_ac].xrcf037, 
                   g_xrcf4_d[l_ac].xrcf038,g_xrcf4_d[l_ac].xrcf039,g_xrcf4_d[l_ac].xrcf040,g_xrcf4_d[l_ac].xrcf041, 
                   g_xrcf4_d[l_ac].xrcf042,g_xrcf4_d[l_ac].xrcf043,g_xrcf4_d[l_ac].xrcf044,g_xrcf4_d[l_ac].xrcf045, 
                   g_xrcf4_d[l_ac].xrcf046,g_xrcf4_d[l_ac].xrcf047,g_xrcf4_d[l_ac].xrcf048,g_xrcf5_d[l_ac].xrcf001, 
                   g_xrcf5_d[l_ac].xrcf002,g_xrcf5_d[l_ac].xrcf010,g_xrcf5_d[l_ac].xrcf020,g_xrcf5_d[l_ac].xrcf029, 
                   g_xrcf5_d[l_ac].xrcf030,g_xrcf5_d[l_ac].xrcforga) #自訂欄位頁簽
                WHERE xrcfent = g_enterprise AND
                  xrcfld = g_xrcf4_d_t.xrcfld #項次 
                  AND xrcfdocno = g_xrcf4_d_t.xrcfdocno
                  AND xrcfseq = g_xrcf4_d_t.xrcfseq
                  AND xrcfseq2 = g_xrcf4_d_t.xrcfseq2
                  
               #add-point:單身page4修改中 name="input.body4.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xrcf_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xrcf_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xrcf4_d[g_detail_idx].xrcfld
               LET gs_keys_bak[1] = g_xrcf4_d_t.xrcfld
               LET gs_keys[2] = g_xrcf4_d[g_detail_idx].xrcfdocno
               LET gs_keys_bak[2] = g_xrcf4_d_t.xrcfdocno
               LET gs_keys[3] = g_xrcf4_d[g_detail_idx].xrcfseq
               LET gs_keys_bak[3] = g_xrcf4_d_t.xrcfseq
               LET gs_keys[4] = g_xrcf4_d[g_detail_idx].xrcfseq2
               LET gs_keys_bak[4] = g_xrcf4_d_t.xrcfseq2
               CALL axrt300_06_update_b('xrcf_t',gs_keys,gs_keys_bak,"'4'")
                     #資料多語言用-增/改
                     
                     
                     #修改歷程記錄(修改)
                     LET g_log1 = util.JSON.stringify(g_xrcf4_d_t)
                     LET g_log2 = util.JSON.stringify(g_xrcf4_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL axrt300_06_xrcf_t_mask_restore('restore_mask_n')
               
               #add-point:單身page4修改後 name="input.body4.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf049
            #add-point:BEFORE FIELD xrcf049 name="input.b.page4.xrcf049"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf049
            
            #add-point:AFTER FIELD xrcf049 name="input.a.page4.xrcf049"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf049
            #add-point:ON CHANGE xrcf049 name="input.g.page4.xrcf049"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf021
            #add-point:BEFORE FIELD xrcf021 name="input.b.page4.xrcf021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf021
            
            #add-point:AFTER FIELD xrcf021 name="input.a.page4.xrcf021"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf021
            #add-point:ON CHANGE xrcf021 name="input.g.page4.xrcf021"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf021_desc
            #add-point:BEFORE FIELD xrcf021_desc name="input.b.page4.xrcf021_desc"
            LET g_xrcf4_d[l_ac].xrcf021_desc = g_xrcf4_d[l_ac].xrcf021
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf021_desc
            
            #add-point:AFTER FIELD xrcf021_desc name="input.a.page4.xrcf021_desc"
            LET g_xrcf4_d[l_ac].xrcf021 = g_xrcf4_d[l_ac].xrcf021_desc
            IF NOT cl_null(g_xrcf4_d[l_ac].xrcf021) THEN
               # 开窗模糊查询 150916-00015#1 --add                      
               IF s_aglt310_getlike_lc_subject(g_xrcf4_d[l_ac].xrcfld,g_xrcf4_d[l_ac].xrcf021,"")  THEN            
                  
                  SELECT glaa004 INTO l_glaa004
                    FROM glaa_t
                   WHERE glaaent = g_enterprise
                     AND glaald  = g_xrcf4_d[l_ac].xrcfld
                  
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
                  LET g_qryparam.reqry = 'FALSE'
                  LET g_qryparam.default1 = g_xrcf4_d[l_ac].xrcf021
                                
                  LET g_qryparam.arg1 = l_glaa004
                  LET g_qryparam.arg2 = g_xrcf4_d[l_ac].xrcf021
                  LET g_qryparam.arg3 = g_xrcf4_d[l_ac].xrcfld
                  LET g_qryparam.arg4 = " 1"
                  CALL q_glac002_6()
                  LET g_xrcf4_d[l_ac].xrcf021_desc = g_qryparam.return1    #將開窗取得的值回傳到變數
                  LET g_xrcf4_d[l_ac].xrcf021 = g_xrcf4_d[l_ac].xrcf021_desc
                  DISPLAY g_xrcf4_d[l_ac].xrcf021_desc TO s_detail4[l_ac].xrcf021_desc                   
               END IF
               #科目存在性，有效性，非统治科目，非子系统科目，账户科目属性检查
               IF NOT  s_aglt310_lc_subject(g_xrcf4_d[l_ac].xrcfld,g_xrcf4_d[l_ac].xrcf021,'N') THEN
                  LET g_xrcf4_d[l_ac].xrcf021 = g_xrcf4_d_t.xrcf021
                  LET g_xrcf_d[l_ac].xrcf021 = g_xrcf4_d[l_ac].xrcf021
                  CALL s_axrt300_account_desc('xrcb029',g_xrcf4_d[l_ac].xrcf021," AND glacl001= '"||g_glaa.glaa004||"'")
                     RETURNING l_success,g_xrcf4_d[l_ac].xrcf021_desc
                  LET g_xrcf_d[l_ac].xrcf021_1_desc = g_xrcf4_d[l_ac].xrcf021_desc
                  NEXT FIELD  CURRENT
               END IF
               # 150916-00015#1 --end
#
#               INITIALIZE g_chkparam.* TO NULL
#               LET g_chkparam.arg1 = g_glaa.glaa004
#               LET g_chkparam.arg2 = g_xrcf4_d[l_ac].xrcf021
#               IF NOT cl_chk_exist("v_glac002_4") THEN
#                  LET g_xrcf4_d[l_ac].xrcf021 = g_xrcf4_d_t.xrcf021
#                  LET g_xrcf_d[l_ac].xrcf021 = g_xrcf4_d[l_ac].xrcf021
#                  CALL s_axrt300_account_desc('xrcb029',g_xrcf4_d[l_ac].xrcf021," AND glacl001= '"||g_glaa.glaa004||"'")
#                     RETURNING l_success,g_xrcf4_d[l_ac].xrcf021_desc
#                  LET g_xrcf_d[l_ac].xrcf021_1_desc = g_xrcf4_d[l_ac].xrcf021_desc
#                  NEXT FIELD CURRENT
#               END IF
            END IF
            CALL s_axrt300_account_desc('xrcb029',g_xrcf4_d[l_ac].xrcf021," AND glacl001= '"||g_glaa.glaa004||"'")
               RETURNING l_success,g_xrcf4_d[l_ac].xrcf021_desc
            DISPLAY g_xrcf4_d[l_ac].xrcf021_desc TO s_detail4[l_ac].xrcf021_desc
            LET g_xrcf_d[l_ac].xrcf021 = g_xrcf4_d[l_ac].xrcf021
            LET g_xrcf_d[l_ac].xrcf021_1_desc = g_xrcf4_d[l_ac].xrcf021_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf021_desc
            #add-point:ON CHANGE xrcf021_desc name="input.g.page4.xrcf021_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf023
            #add-point:BEFORE FIELD xrcf023 name="input.b.page4.xrcf023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf023
            
            #add-point:AFTER FIELD xrcf023 name="input.a.page4.xrcf023"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf023
            #add-point:ON CHANGE xrcf023 name="input.g.page4.xrcf023"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf023_desc
            #add-point:BEFORE FIELD xrcf023_desc name="input.b.page4.xrcf023_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf023_desc
            
            #add-point:AFTER FIELD xrcf023_desc name="input.a.page4.xrcf023_desc"
            LET g_xrcf4_d[l_ac].xrcf023 = g_xrcf4_d[l_ac].xrcf023_desc
            IF NOT cl_null(g_xrcf4_d[l_ac].xrcf023) THEN
               # 开窗模糊查询                     
               IF s_aglt310_getlike_lc_subject(g_xrcf4_d[l_ac].xrcfld,g_xrcf4_d[l_ac].xrcf023,"")  THEN            
                  
                  SELECT glaa004 INTO l_glaa004
                    FROM glaa_t
                   WHERE glaaent = g_enterprise
                     AND glaald  = g_xrcf4_d[l_ac].xrcfld
                  
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
                  LET g_qryparam.reqry = 'FALSE'
                  LET g_qryparam.default1 = g_xrcf4_d[l_ac].xrcf023
                                
                  LET g_qryparam.arg1 = l_glaa004
                  LET g_qryparam.arg2 = g_xrcf4_d[l_ac].xrcf023
                  LET g_qryparam.arg3 = g_xrcf4_d[l_ac].xrcfld
                  LET g_qryparam.arg4 = " 1"
                  CALL q_glac002_6()
                  LET g_xrcf4_d[l_ac].xrcf023_desc = g_qryparam.return1    #將開窗取得的值回傳到變數
                  LET g_xrcf4_d[l_ac].xrcf023 = g_xrcf4_d[l_ac].xrcf023_desc
                  DISPLAY g_xrcf4_d[l_ac].xrcf023_desc TO s_detail4[l_ac].xrcf023_desc                   
               END IF
               #科目存在性，有效性，非统治科目，非子系统科目，账户科目属性检查
               IF NOT  s_aglt310_lc_subject(g_xrcf4_d[l_ac].xrcfld,g_xrcf4_d[l_ac].xrcf023,'N') THEN
                  LET g_xrcf4_d[l_ac].xrcf023 = g_xrcf4_d_t.xrcf023
                  CALL s_axrt300_account_desc('xrcb029',g_xrcf4_d[l_ac].xrcf023," AND glacl001= '"||g_glaa.glaa004||"'")
                     RETURNING l_success,g_xrcf4_d[l_ac].xrcf023_desc
                  NEXT FIELD  CURRENT
               END IF
            END IF
            CALL s_axrt300_account_desc('xrcb029',g_xrcf4_d[l_ac].xrcf023," AND glacl001= '"||g_glaa.glaa004||"'")
               RETURNING l_success,g_xrcf4_d[l_ac].xrcf023_desc
            DISPLAY g_xrcf4_d[l_ac].xrcf023_desc TO s_detail4[l_ac].xrcf023_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf023_desc
            #add-point:ON CHANGE xrcf023_desc name="input.g.page4.xrcf023_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf033
            #add-point:BEFORE FIELD xrcf033 name="input.b.page4.xrcf033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf033
            
            #add-point:AFTER FIELD xrcf033 name="input.a.page4.xrcf033"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf033
            #add-point:ON CHANGE xrcf033 name="input.g.page4.xrcf033"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf033_desc
            #add-point:BEFORE FIELD xrcf033_desc name="input.b.page4.xrcf033_desc"
            LET g_xrcf4_d[l_ac].xrcf033_desc = g_xrcf4_d[l_ac].xrcf033
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf033_desc
            
            #add-point:AFTER FIELD xrcf033_desc name="input.a.page4.xrcf033_desc"
            LET g_xrcf4_d[l_ac].xrcf033 = g_xrcf4_d[l_ac].xrcf033_desc
            IF NOT cl_null(g_xrcf4_d[l_ac].xrcf033) THEN
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_xrcf4_d[l_ac].xrcf033
               LET g_errshow = TRUE   #160318-00025#13
               LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"    #160318-00025#13   
               IF NOT cl_chk_exist("v_ooag001") THEN
                  LET g_xrcf4_d[l_ac].xrcf033 = g_xrcf4_d_t.xrcf033
                  CALL s_axrt300_account_desc('xrcb051',g_xrcf4_d[l_ac].xrcf033,'') RETURNING l_success,g_xrcf4_d[l_ac].xrcf033_desc
                  NEXT FIELD CURRENT
               END IF
            END IF
            CALL s_axrt300_account_desc('xrcb051',g_xrcf4_d[l_ac].xrcf033,'') RETURNING l_success,g_xrcf4_d[l_ac].xrcf033_desc
            DISPLAY g_xrcf4_d[l_ac].xrcf033_desc TO s_detail4[l_ac].xrcf033_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf033_desc
            #add-point:ON CHANGE xrcf033_desc name="input.g.page4.xrcf033_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf026
            #add-point:BEFORE FIELD xrcf026 name="input.b.page4.xrcf026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf026
            
            #add-point:AFTER FIELD xrcf026 name="input.a.page4.xrcf026"
           #INITIALIZE g_ref_fields TO NULL
           #LET g_ref_fields[1] = g_xrcf4_d[l_ac].xrcf026
           #CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
           #LET g_xrcf4_d[l_ac].xrcf026_desc = '', g_rtn_fields[1] , ''
           #DISPLAY BY NAME g_xrcf4_d[l_ac].xrcf026_desc

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf026
            #add-point:ON CHANGE xrcf026 name="input.g.page4.xrcf026"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf026_desc
            #add-point:BEFORE FIELD xrcf026_desc name="input.b.page4.xrcf026_desc"
            LET g_xrcf4_d[l_ac].xrcf026_desc = g_xrcf4_d[l_ac].xrcf026
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf026_desc
            
            #add-point:AFTER FIELD xrcf026_desc name="input.a.page4.xrcf026_desc"
            LET g_xrcf4_d[l_ac].xrcf026 = g_xrcf4_d[l_ac].xrcf026_desc            
            IF NOT cl_null(g_xrcf4_d[l_ac].xrcf026) THEN
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_xrcf4_d[l_ac].xrcf026
               LET g_chkparam.arg2 = ' '
               LET g_errshow = TRUE   #160318-00025#13
               LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"    #160318-00025#13
               IF NOT cl_chk_exist("v_ooef001_14") THEN
                  LET g_xrcf4_d[l_ac].xrcf026 = g_xrcf4_d_t.xrcf026
                  CALL s_axrt300_account_desc('xrcb010',g_xrcf4_d[l_ac].xrcf026,'') RETURNING l_success,g_xrcf4_d[l_ac].xrcf026_desc
                  NEXT FIELD CURRENT
               END IF
            END IF
            CALL s_axrt300_account_desc('xrcb010',g_xrcf4_d[l_ac].xrcf026,'') RETURNING l_success,g_xrcf4_d[l_ac].xrcf026_desc
            DISPLAY g_xrcf4_d[l_ac].xrcf026_desc TO s_detail4[l_ac].xrcf026_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf026_desc
            #add-point:ON CHANGE xrcf026_desc name="input.g.page4.xrcf026_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf027
            #add-point:BEFORE FIELD xrcf027 name="input.b.page4.xrcf027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf027
            
            #add-point:AFTER FIELD xrcf027 name="input.a.page4.xrcf027"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf027
            #add-point:ON CHANGE xrcf027 name="input.g.page4.xrcf027"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf027_desc
            #add-point:BEFORE FIELD xrcf027_desc name="input.b.page4.xrcf027_desc"
            LET g_xrcf4_d[l_ac].xrcf027_desc = g_xrcf4_d[l_ac].xrcf027
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf027_desc
            
            #add-point:AFTER FIELD xrcf027_desc name="input.a.page4.xrcf027_desc"
            LET g_xrcf4_d[l_ac].xrcf027 = g_xrcf4_d[l_ac].xrcf027_desc
            IF NOT cl_null(g_xrcf4_d[l_ac].xrcf027_desc) THEN
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_xrcf4_d[l_ac].xrcf027
               LET g_chkparam.arg2 = g_xrcadocdt
               LET g_errshow = TRUE   #160318-00025#13
                  LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"    #160318-00025#13 
                  LET g_chkparam.err_str[2] = "aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"    #160318-00025#13              
               IF NOT cl_chk_exist("v_ooeg001") THEN
                  LET g_xrcf4_d[l_ac].xrcf027 = g_xrcf4_d_t.xrcf027
                  CALL s_axrt300_account_desc('xrcb011',g_xrcf4_d[l_ac].xrcf027,'') RETURNING l_success,g_xrcf4_d[l_ac].xrcf027_desc
                  NEXT FIELD CURRENT
               END IF
            END IF
            CALL s_axrt300_account_desc('xrcb011',g_xrcf4_d[l_ac].xrcf027,'') RETURNING l_success,g_xrcf4_d[l_ac].xrcf027_desc
            DISPLAY BY NAME g_xrcf4_d[l_ac].xrcf027_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf027_desc
            #add-point:ON CHANGE xrcf027_desc name="input.g.page4.xrcf027_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf028
            #add-point:BEFORE FIELD xrcf028 name="input.b.page4.xrcf028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf028
            
            #add-point:AFTER FIELD xrcf028 name="input.a.page4.xrcf028"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf028
            #add-point:ON CHANGE xrcf028 name="input.g.page4.xrcf028"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf028_desc
            #add-point:BEFORE FIELD xrcf028_desc name="input.b.page4.xrcf028_desc"
            LET g_xrcf4_d[l_ac].xrcf028_desc = g_xrcf4_d[l_ac].xrcf028
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf028_desc
            
            #add-point:AFTER FIELD xrcf028_desc name="input.a.page4.xrcf028_desc"
            LET g_xrcf4_d[l_ac].xrcf028 = g_xrcf4_d[l_ac].xrcf028_desc
            IF NOT cl_null(g_xrcf4_d[l_ac].xrcf028) THEN
               CALL axrt300_06_xrcf028_chk('287',g_xrcf4_d[l_ac].xrcf028) 
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_xrcf4_d[l_ac].xrcf028
                  #160318-00005#53 --s add
                  CASE g_errno
                     WHEN 'sub-01302'
                        LET g_errparam.replace[1] = 'axmi021'
                        LET g_errparam.replace[2] = cl_get_progname('axmi021',g_lang,"2")
                        LET g_errparam.exeprog = 'axmi021'
                     WHEN 'sub-01303'
                        LET g_errparam.replace[1] = 'axmi021'
                        LET g_errparam.replace[2] = cl_get_progname('axmi021',g_lang,"2")
                        LET g_errparam.exeprog = 'axmi021'
                  END CASE
                  #160318-00005#53 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_xrcf4_d[l_ac].xrcf028 = g_xrcf4_d_t.xrcf028
                  LET g_xrcf4_d[l_ac].xrcf028_desc = g_xrcf4_d_t.xrcf028_desc
                  CALL s_axrt300_account_desc('xrcb024',g_xrcf4_d[l_ac].xrcf028,'') RETURNING l_success,g_xrcf4_d[l_ac].xrcf028_desc
                  DISPLAY BY NAME g_xrcf4_d[l_ac].xrcf028_desc
                  NEXT FIELD xrcb024_desc
               END IF 
            END IF 
            CALL s_axrt300_account_desc('xrcb024',g_xrcf4_d[l_ac].xrcf028,'') RETURNING l_success,g_xrcf4_d[l_ac].xrcf028_desc
            DISPLAY BY NAME g_xrcf4_d[l_ac].xrcf028_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf028_desc
            #add-point:ON CHANGE xrcf028_desc name="input.g.page4.xrcf028_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf031
            #add-point:BEFORE FIELD xrcf031 name="input.b.page4.xrcf031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf031
            
            #add-point:AFTER FIELD xrcf031 name="input.a.page4.xrcf031"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf031
            #add-point:ON CHANGE xrcf031 name="input.g.page4.xrcf031"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf031_desc
            #add-point:BEFORE FIELD xrcf031_desc name="input.b.page4.xrcf031_desc"
          LET g_xrcf4_d[l_ac].xrcf031_desc = g_xrcf4_d[l_ac].xrcf031
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf031_desc
            
            #add-point:AFTER FIELD xrcf031_desc name="input.a.page4.xrcf031_desc"
            LET g_xrcf4_d[l_ac].xrcf031 = g_xrcf4_d[l_ac].xrcf031_desc
            IF NOT cl_null(g_xrcf4_d[l_ac].xrcf031) THEN
                CALL axrt300_06_xrcf028_chk('281',g_xrcf4_d[l_ac].xrcf031) 
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_xrcf4_d[l_ac].xrcf031
                  #160318-00005#53 --s add
                  CASE g_errno
                     WHEN 'sub-01302'
                        LET g_errparam.replace[1] = 'axmi021'
                        LET g_errparam.replace[2] = cl_get_progname('axmi021',g_lang,"2")
                        LET g_errparam.exeprog = 'axmi021'
                     WHEN 'sub-01303'
                        LET g_errparam.replace[1] = 'axmi021'
                        LET g_errparam.replace[2] = cl_get_progname('axmi021',g_lang,"2")
                        LET g_errparam.exeprog = 'axmi021'
                  END CASE
                  #160318-00005#53 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_xrcf4_d[l_ac].xrcf031 = g_xrcf4_d_t.xrcf031
                  LET g_xrcf4_d[l_ac].xrcf031_desc = g_xrcf4_d_t.xrcf031_desc
                  CALL s_axrt300_account_desc('xrcb036',g_xrcf4_d[l_ac].xrcf031,'') RETURNING l_success,g_xrcf4_d[l_ac].xrcf031_desc
                  DISPLAY BY NAME g_xrcf4_d[l_ac].xrcf031_desc
                  NEXT FIELD xrcb036_desc
               END IF 
            END IF 
            CALL s_axrt300_account_desc('xrcb036',g_xrcf4_d[l_ac].xrcf031,'') RETURNING l_success,g_xrcf4_d[l_ac].xrcf031_desc
            DISPLAY BY NAME g_xrcf4_d[l_ac].xrcf031_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf031_desc
            #add-point:ON CHANGE xrcf031_desc name="input.g.page4.xrcf031_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf032
            #add-point:BEFORE FIELD xrcf032 name="input.b.page4.xrcf032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf032
            
            #add-point:AFTER FIELD xrcf032 name="input.a.page4.xrcf032"
           #INITIALIZE g_ref_fields TO NULL
           #LET g_ref_fields[1] = g_xrcf4_d[l_ac].xrcf032
           #CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
           #LET g_xrcf4_d[l_ac].xrcf032_desc = '', g_rtn_fields[1] , ''
           #DISPLAY BY NAME g_xrcf4_d[l_ac].xrcf032_desc

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf032
            #add-point:ON CHANGE xrcf032 name="input.g.page4.xrcf032"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf032_desc
            #add-point:BEFORE FIELD xrcf032_desc name="input.b.page4.xrcf032_desc"
            LET g_xrcf4_d[l_ac].xrcf032_desc = g_xrcf4_d[l_ac].xrcf032
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf032_desc
            
            #add-point:AFTER FIELD xrcf032_desc name="input.a.page4.xrcf032_desc"
            LET g_xrcf4_d[l_ac].xrcf032 = g_xrcf4_d[l_ac].xrcf032_desc
            IF NOT cl_null(g_xrcf4_d[l_ac].xrcf032) THEN
               CALL axrt300_06_xrcb012_chk(g_xrcf4_d[l_ac].xrcf032) 
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_xrcf4_d[l_ac].xrcf032
                  #160318-00005#53 --s add
                  CASE g_errno
                     WHEN 'sub-01302'
                        LET g_errparam.replace[1] = 'arti202'
                        LET g_errparam.replace[2] = cl_get_progname('arti202',g_lang,"2")
                        LET g_errparam.exeprog = 'arti202'
                  END CASE
                  #160318-00005#53 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_xrcf4_d[l_ac].xrcf032 = g_xrcf4_d_t.xrcf032
                  LET g_xrcf4_d[l_ac].xrcf032_desc = g_xrcf4_d_t.xrcf032_desc
                  CALL s_axrt300_account_desc('xrcb012',g_xrcf4_d[l_ac].xrcf032,'') RETURNING l_success,g_xrcf4_d[l_ac].xrcf032_desc
                  DISPLAY BY NAME g_xrcf4_d[l_ac].xrcf032_desc
                  NEXT FIELD xrcb012_desc
               END IF 
            END IF 
            CALL s_axrt300_account_desc('xrcb012',g_xrcf4_d[l_ac].xrcf032,'') RETURNING l_success,g_xrcf4_d[l_ac].xrcf032_desc
            DISPLAY BY NAME g_xrcf4_d[l_ac].xrcf032_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf032_desc
            #add-point:ON CHANGE xrcf032_desc name="input.g.page4.xrcf032_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf034
            #add-point:BEFORE FIELD xrcf034 name="input.b.page4.xrcf034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf034
            
            #add-point:AFTER FIELD xrcf034 name="input.a.page4.xrcf034"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf034
            #add-point:ON CHANGE xrcf034 name="input.g.page4.xrcf034"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf034_desc
            #add-point:BEFORE FIELD xrcf034_desc name="input.b.page4.xrcf034_desc"
            LET g_xrcf4_d[l_ac].xrcf034_desc = g_xrcf4_d[l_ac].xrcf034
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf034_desc
            
            #add-point:AFTER FIELD xrcf034_desc name="input.a.page4.xrcf034_desc"
            LET g_xrcf4_d[l_ac].xrcf034 = g_xrcf4_d[l_ac].xrcf034_desc
            CALL s_desc_get_project_desc(g_xrcf4_d[l_ac].xrcf034) RETURNING g_xrcf4_d[l_ac].xrcf034_desc  
            LET g_xrcf4_d[l_ac].xrcf034_desc = g_xrcf4_d[l_ac].xrcf034,' ',g_xrcf4_d[l_ac].xrcf034_desc
            DISPLAY BY NAME g_xrcf4_d[l_ac].xrcf034_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf034_desc
            #add-point:ON CHANGE xrcf034_desc name="input.g.page4.xrcf034_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf035
            #add-point:BEFORE FIELD xrcf035 name="input.b.page4.xrcf035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf035
            
            #add-point:AFTER FIELD xrcf035 name="input.a.page4.xrcf035"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf035
            #add-point:ON CHANGE xrcf035 name="input.g.page4.xrcf035"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf035_desc
            #add-point:BEFORE FIELD xrcf035_desc name="input.b.page4.xrcf035_desc"
            LET g_xrcf4_d[l_ac].xrcf035_desc = g_xrcf4_d[l_ac].xrcf035
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf035_desc
            
            #add-point:AFTER FIELD xrcf035_desc name="input.a.page4.xrcf035_desc"
            LET g_xrcf4_d[l_ac].xrcf035 = g_xrcf4_d[l_ac].xrcf035_desc
            CALL s_desc_get_wbs_desc(g_xrcf4_d[l_ac].xrcf035,g_xrcf4_d[l_ac].xrcf035) RETURNING g_xrcf4_d[l_ac].xrcf035_desc
            LET g_xrcf4_d[l_ac].xrcf035_desc = g_xrcf4_d[l_ac].xrcf035,' ',g_xrcf4_d[l_ac].xrcf035_desc
            DISPLAY BY NAME g_xrcf4_d[l_ac].xrcf035_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf035_desc
            #add-point:ON CHANGE xrcf035_desc name="input.g.page4.xrcf035_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf036
            #add-point:BEFORE FIELD xrcf036 name="input.b.page4.xrcf036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf036
            
            #add-point:AFTER FIELD xrcf036 name="input.a.page4.xrcf036"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf036
            #add-point:ON CHANGE xrcf036 name="input.g.page4.xrcf036"
            IF NOT cl_null(g_xrcf4_d[l_ac].xrcf036) THEN
               CALL s_voucher_glaq051_chk(g_xrcf4_d[l_ac].xrcf036) 
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_xrcf4_d[l_ac].xrcf036
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_xrcf4_d[l_ac].xrcf036 = g_xrcf4_d_t.xrcf036
               END IF
            END IF
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf037
            #add-point:BEFORE FIELD xrcf037 name="input.b.page4.xrcf037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf037
            
            #add-point:AFTER FIELD xrcf037 name="input.a.page4.xrcf037"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf037
            #add-point:ON CHANGE xrcf037 name="input.g.page4.xrcf037"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf037_desc
            #add-point:BEFORE FIELD xrcf037_desc name="input.b.page4.xrcf037_desc"
            LET g_xrcf4_d[l_ac].xrcf037_desc = g_xrcf4_d[l_ac].xrcf037
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf037_desc
            
            #add-point:AFTER FIELD xrcf037_desc name="input.a.page4.xrcf037_desc"
            LET g_xrcf4_d[l_ac].xrcf037 = g_xrcf4_d[l_ac].xrcf037_desc
            IF NOT cl_null(g_xrcf4_d[l_ac].xrcf037) THEN
               CALL s_voucher_glaq052_chk(g_xrcf4_d[l_ac].xrcf037) 
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_xrcf4_d[l_ac].xrcf037
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_xrcf4_d[l_ac].xrcf037 = g_xrcf4_d_t.xrcf037
                  LET g_xrcf4_d[l_ac].xrcf037_desc = g_xrcf4_d_t.xrcf037_desc
                  CALL s_axrt300_account_desc('xrcb034',g_xrcf4_d[l_ac].xrcf037,'') RETURNING l_success,g_xrcf4_d[l_ac].xrcf037_desc
                  DISPLAY BY NAME g_xrcf4_d[l_ac].xrcf037_desc
                  NEXT FIELD xrcb034_desc
               END IF 
            END IF 
            CALL s_axrt300_account_desc('xrcb034',g_xrcf4_d[l_ac].xrcf037,'') RETURNING l_success,g_xrcf4_d[l_ac].xrcf037_desc
            DISPLAY BY NAME g_xrcf4_d[l_ac].xrcf037_desc   
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf037_desc
            #add-point:ON CHANGE xrcf037_desc name="input.g.page4.xrcf037_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf038
            #add-point:BEFORE FIELD xrcf038 name="input.b.page4.xrcf038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf038
            
            #add-point:AFTER FIELD xrcf038 name="input.a.page4.xrcf038"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf038
            #add-point:ON CHANGE xrcf038 name="input.g.page4.xrcf038"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf038_desc
            #add-point:BEFORE FIELD xrcf038_desc name="input.b.page4.xrcf038_desc"
            LET g_xrcf4_d[l_ac].xrcf038_desc = g_xrcf4_d[l_ac].xrcf038
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf038_desc
            
            #add-point:AFTER FIELD xrcf038_desc name="input.a.page4.xrcf038_desc"
            LET g_xrcf4_d[l_ac].xrcf038 = g_xrcf4_d[l_ac].xrcf038_desc
            IF NOT cl_null(g_xrcf4_d[l_ac].xrcf038) THEN
               CALL s_voucher_glaq020_chk('2002',g_xrcf4_d[l_ac].xrcf038) 
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_xrcf4_d[l_ac].xrcf038
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_xrcf4_d[l_ac].xrcf038 = g_xrcf4_d_t.xrcf038
                  LET g_xrcf4_d[l_ac].xrcf038_desc = g_xrcf4_d_t.xrcf038_desc
                  CALL s_axrt300_account_desc('xrcb035',g_xrcf4_d[l_ac].xrcf038,'') RETURNING l_success,g_xrcf4_d[l_ac].xrcf038_desc
                  DISPLAY BY NAME g_xrcf4_d[l_ac].xrcf038_desc
                  NEXT FIELD xrcb035_desc
               END IF 
            END IF 
            CALL s_axrt300_account_desc('xrcb035',g_xrcf4_d[l_ac].xrcf038,'') RETURNING l_success,g_xrcf4_d[l_ac].xrcf038_desc
            DISPLAY BY NAME g_xrcf4_d[l_ac].xrcf038_desc 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf038_desc
            #add-point:ON CHANGE xrcf038_desc name="input.g.page4.xrcf038_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf039
            #add-point:BEFORE FIELD xrcf039 name="input.b.page4.xrcf039"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf039
            
            #add-point:AFTER FIELD xrcf039 name="input.a.page4.xrcf039"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf039
            #add-point:ON CHANGE xrcf039 name="input.g.page4.xrcf039"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf039_desc
            #add-point:BEFORE FIELD xrcf039_desc name="input.b.page4.xrcf039_desc"
             #当来源类型为1时，开窗为agli041的开窗查询代码值，为2时，开q_glaf002,为3时不给开窗
            LET g_glae002 = ''
            LET g_glae009 = ''
            SELECT glae002 INTO g_glae002 FROM glae_t
             WHERE glaeent = g_enterprise
               AND glae001 = g_glad.glad0171
             IF g_glae002 = '1' THEN
                SELECT glae009 INTO g_glae009 FROM glae_t
                 WHERE glaeent = g_enterprise
                   AND glae001 = g_glad.glad0171
             END IF
             IF g_glae002 = '2' THEN
                LET g_glae009 = 'q_glaf002'
             END IF

             IF g_glae002 = '3' THEN
                LET g_glae009 = ''
             END IF
             LET g_xrcf4_d[l_ac].xrcf039_desc = g_xrcf4_d[l_ac].xrcf039
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf039_desc
            
            #add-point:AFTER FIELD xrcf039_desc name="input.a.page4.xrcf039_desc"
            LET g_xrcf4_d[l_ac].xrcf039 = g_xrcf4_d[l_ac].xrcf039_desc
            IF NOT cl_null(g_xrcf4_d[l_ac].xrcf039_desc) THEN
               CALL axrt300_06_free_account_chk(g_glad.glad0171,g_xrcf4_d[l_ac].xrcf039_desc,g_glad.glad0172) RETURNING l_errno
               IF NOT cl_null(l_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_xrcf4_d[l_ac].xrcf039
                  #160318-00005#53 --s add
                  CASE l_errno
                     WHEN 'sub-01302'
                           LET g_errparam.replace[1] = 'agli041'
                           LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                           LET g_errparam.exeprog = 'agli041'
                  END CASE
                  #160318-00005#53 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_xrcf4_d[l_ac].xrcf039 = g_xrcf4_d_t.xrcf039
                  CALL axrt300_06_free_account_desc()
                  NEXT FIELD xrcf039
               END IF
            END IF
            CALL axrt300_06_free_account_desc()
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf039_desc
            #add-point:ON CHANGE xrcf039_desc name="input.g.page4.xrcf039_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf040
            #add-point:BEFORE FIELD xrcf040 name="input.b.page4.xrcf040"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf040
            
            #add-point:AFTER FIELD xrcf040 name="input.a.page4.xrcf040"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf040
            #add-point:ON CHANGE xrcf040 name="input.g.page4.xrcf040"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf040_desc
            #add-point:BEFORE FIELD xrcf040_desc name="input.b.page4.xrcf040_desc"
            #当来源类型为1时，开窗为agli041的开窗查询代码值，为2时，开q_glaf002,为3时不给开窗
            LET g_glae002 = ''
            LET g_glae009 = ''
            SELECT glae002 INTO g_glae002 FROM glae_t
             WHERE glaeent = g_enterprise
               AND glae001 = g_glad.glad0181
             IF g_glae002 = '1' THEN
                SELECT glae009 INTO g_glae009 FROM glae_t
                 WHERE glaeent = g_enterprise
                   AND glae001 = g_glad.glad0181
             END IF
             IF g_glae002 = '2' THEN
                LET g_glae009 = 'q_glaf002'
             END IF

             IF g_glae002 = '3' THEN
                LET g_glae009 = ''
             END IF
             LET g_xrcf4_d[l_ac].xrcf040_desc = g_xrcf4_d[l_ac].xrcf040
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf040_desc
            
            #add-point:AFTER FIELD xrcf040_desc name="input.a.page4.xrcf040_desc"
            LET g_xrcf4_d[l_ac].xrcf040 = g_xrcf4_d[l_ac].xrcf040_desc
            IF NOT cl_null(g_xrcf4_d[l_ac].xrcf040_desc) THEN
               CALL axrt300_06_free_account_chk(g_glad.glad0181,g_xrcf4_d[l_ac].xrcf040_desc,g_glad.glad0182) RETURNING l_errno
               IF NOT cl_null(l_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_xrcf4_d[l_ac].xrcf040
                  #160318-00005#53 --s add
                  CASE l_errno
                     WHEN 'sub-01302'
                           LET g_errparam.replace[1] = 'agli041'
                           LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                           LET g_errparam.exeprog = 'agli041'
                  END CASE
                  #160318-00005#53 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_xrcf4_d[l_ac].xrcf040 = g_xrcf4_d_t.xrcf040
                  CALL axrt300_06_free_account_desc()
                  NEXT FIELD xrcf040
               END IF
            END IF
            CALL axrt300_06_free_account_desc()
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf040_desc
            #add-point:ON CHANGE xrcf040_desc name="input.g.page4.xrcf040_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf041
            #add-point:BEFORE FIELD xrcf041 name="input.b.page4.xrcf041"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf041
            
            #add-point:AFTER FIELD xrcf041 name="input.a.page4.xrcf041"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf041
            #add-point:ON CHANGE xrcf041 name="input.g.page4.xrcf041"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf041_desc
            #add-point:BEFORE FIELD xrcf041_desc name="input.b.page4.xrcf041_desc"
            #当来源类型为1时，开窗为agli041的开窗查询代码值，为2时，开q_glaf002,为3时不给开窗
            LET g_glae002 = ''
            LET g_glae009 = ''
            SELECT glae002 INTO g_glae002 FROM glae_t
             WHERE glaeent = g_enterprise
               AND glae001 = g_glad.glad0191
             IF g_glae002 = '1' THEN
                SELECT glae009 INTO g_glae009 FROM glae_t
                 WHERE glaeent = g_enterprise
                   AND glae001 = g_glad.glad0191
             END IF
             IF g_glae002 = '2' THEN
                LET g_glae009 = 'q_glaf002'
             END IF

             IF g_glae002 = '3' THEN
                LET g_glae009 = ''
             END IF
             LET g_xrcf4_d[l_ac].xrcf041_desc = g_xrcf4_d[l_ac].xrcf041
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf041_desc
            
            #add-point:AFTER FIELD xrcf041_desc name="input.a.page4.xrcf041_desc"
            LET g_xrcf4_d[l_ac].xrcf041 = g_xrcf4_d[l_ac].xrcf041_desc
            IF NOT cl_null(g_xrcf4_d[l_ac].xrcf041_desc) THEN
               CALL axrt300_06_free_account_chk(g_glad.glad0191,g_xrcf4_d[l_ac].xrcf041_desc,g_glad.glad0192) RETURNING l_errno
               IF NOT cl_null(l_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_xrcf4_d[l_ac].xrcf041
                  #160318-00005#53 --s add
                  CASE l_errno
                     WHEN 'sub-01302'
                           LET g_errparam.replace[1] = 'agli041'
                           LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                           LET g_errparam.exeprog = 'agli041'
                  END CASE
                  #160318-00005#53 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_xrcf4_d[l_ac].xrcf041= g_xrcf4_d_t.xrcf041
                  CALL axrt300_06_free_account_desc()
                  NEXT FIELD xrcf041
               END IF
            END IF
            CALL axrt300_06_free_account_desc()
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf041_desc
            #add-point:ON CHANGE xrcf041_desc name="input.g.page4.xrcf041_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf042
            #add-point:BEFORE FIELD xrcf042 name="input.b.page4.xrcf042"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf042
            
            #add-point:AFTER FIELD xrcf042 name="input.a.page4.xrcf042"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf042
            #add-point:ON CHANGE xrcf042 name="input.g.page4.xrcf042"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf042_desc
            #add-point:BEFORE FIELD xrcf042_desc name="input.b.page4.xrcf042_desc"
            #当来源类型为1时，开窗为agli041的开窗查询代码值，为2时，开q_glaf002,为3时不给开窗
            LET g_glae002 = ''
            LET g_glae009 = ''
            SELECT glae002 INTO g_glae002 FROM glae_t
             WHERE glaeent = g_enterprise
               AND glae001 = g_glad.glad0201
             IF g_glae002 = '1' THEN
                SELECT glae009 INTO g_glae009 FROM glae_t
                 WHERE glaeent = g_enterprise
                   AND glae001 = g_glad.glad0201
             END IF
             IF g_glae002 = '2' THEN
                LET g_glae009 = 'q_glaf002'
             END IF

             IF g_glae002 = '3' THEN
                LET g_glae009 = ''
             END IF
             LET g_xrcf4_d[l_ac].xrcf042_desc = g_xrcf4_d[l_ac].xrcf042
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf042_desc
            
            #add-point:AFTER FIELD xrcf042_desc name="input.a.page4.xrcf042_desc"
            LET g_xrcf4_d[l_ac].xrcf042 = g_xrcf4_d[l_ac].xrcf042_desc
            IF NOT cl_null(g_xrcf4_d[l_ac].xrcf042_desc) THEN
               CALL axrt300_06_free_account_chk(g_glad.glad0201,g_xrcf4_d[l_ac].xrcf042_desc,g_glad.glad0202) RETURNING l_errno
               IF NOT cl_null(l_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_xrcf4_d[l_ac].xrcf042
                  #160318-00005#53 --s add
                  CASE l_errno
                     WHEN 'sub-01302'
                           LET g_errparam.replace[1] = 'agli041'
                           LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                           LET g_errparam.exeprog = 'agli041'
                  END CASE
                  #160318-00005#53 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_xrcf4_d[l_ac].xrcf042= g_xrcf4_d_t.xrcf042
                  CALL axrt300_06_free_account_desc()
                  NEXT FIELD xrcf042
               END IF
            END IF
            CALL axrt300_06_free_account_desc()
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf042_desc
            #add-point:ON CHANGE xrcf042_desc name="input.g.page4.xrcf042_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf043
            #add-point:BEFORE FIELD xrcf043 name="input.b.page4.xrcf043"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf043
            
            #add-point:AFTER FIELD xrcf043 name="input.a.page4.xrcf043"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf043
            #add-point:ON CHANGE xrcf043 name="input.g.page4.xrcf043"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf043_desc
            #add-point:BEFORE FIELD xrcf043_desc name="input.b.page4.xrcf043_desc"
            #当来源类型为1时，开窗为agli041的开窗查询代码值，为2时，开q_glaf002,为3时不给开窗
            LET g_glae002 = ''
            LET g_glae009 = ''
            SELECT glae002 INTO g_glae002 FROM glae_t
             WHERE glaeent = g_enterprise
               AND glae001 = g_glad.glad0211
             IF g_glae002 = '1' THEN
                SELECT glae009 INTO g_glae009 FROM glae_t
                 WHERE glaeent = g_enterprise
                   AND glae001 = g_glad.glad0211
             END IF
             IF g_glae002 = '2' THEN
                LET g_glae009 = 'q_glaf002'
             END IF

             IF g_glae002 = '3' THEN
                LET g_glae009 = ''
             END IF
             LET g_xrcf4_d[l_ac].xrcf043_desc = g_xrcf4_d[l_ac].xrcf043
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf043_desc
            
            #add-point:AFTER FIELD xrcf043_desc name="input.a.page4.xrcf043_desc"
            LET g_xrcf4_d[l_ac].xrcf043 = g_xrcf4_d[l_ac].xrcf043_desc
            IF NOT cl_null(g_xrcf4_d[l_ac].xrcf043_desc) THEN
               CALL axrt300_06_free_account_chk(g_glad.glad0211,g_xrcf4_d[l_ac].xrcf043_desc,g_glad.glad0212) RETURNING l_errno
               IF NOT cl_null(l_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_xrcf4_d[l_ac].xrcf043
                  #160318-00005#53 --s add
                  CASE l_errno
                     WHEN 'sub-01302'
                           LET g_errparam.replace[1] = 'agli041'
                           LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                           LET g_errparam.exeprog = 'agli041'
                  END CASE
                  #160318-00005#53 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_xrcf4_d[l_ac].xrcf043= g_xrcf4_d_t.xrcf043
                  CALL axrt300_06_free_account_desc()
                  NEXT FIELD xrcf043
               END IF
            END IF
            CALL axrt300_06_free_account_desc()
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf043_desc
            #add-point:ON CHANGE xrcf043_desc name="input.g.page4.xrcf043_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf044
            #add-point:BEFORE FIELD xrcf044 name="input.b.page4.xrcf044"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf044
            
            #add-point:AFTER FIELD xrcf044 name="input.a.page4.xrcf044"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf044
            #add-point:ON CHANGE xrcf044 name="input.g.page4.xrcf044"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf044_desc
            #add-point:BEFORE FIELD xrcf044_desc name="input.b.page4.xrcf044_desc"
            #当来源类型为1时，开窗为agli041的开窗查询代码值，为2时，开q_glaf002,为3时不给开窗
            LET g_glae002 = ''
            LET g_glae009 = ''
            SELECT glae002 INTO g_glae002 FROM glae_t
             WHERE glaeent = g_enterprise
               AND glae001 = g_glad.glad0221
             IF g_glae002 = '1' THEN
                SELECT glae009 INTO g_glae009 FROM glae_t
                 WHERE glaeent = g_enterprise
                   AND glae001 = g_glad.glad0221
             END IF
             IF g_glae002 = '2' THEN
                LET g_glae009 = 'q_glaf002'
             END IF

             IF g_glae002 = '3' THEN
                LET g_glae009 = ''
             END IF
             LET g_xrcf4_d[l_ac].xrcf044_desc = g_xrcf4_d[l_ac].xrcf044
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf044_desc
            
            #add-point:AFTER FIELD xrcf044_desc name="input.a.page4.xrcf044_desc"
            LET g_xrcf4_d[l_ac].xrcf044 = g_xrcf4_d[l_ac].xrcf044_desc
            IF NOT cl_null(g_xrcf4_d[l_ac].xrcf044_desc) THEN
               CALL axrt300_06_free_account_chk(g_glad.glad0221,g_xrcf4_d[l_ac].xrcf044_desc,g_glad.glad0222) RETURNING l_errno
               IF NOT cl_null(l_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_xrcf4_d[l_ac].xrcf044
                  #160318-00005#53 --s add
                  CASE l_errno
                     WHEN 'sub-01302'
                           LET g_errparam.replace[1] = 'agli041'
                           LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                           LET g_errparam.exeprog = 'agli041'
                  END CASE
                  #160318-00005#53 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_xrcf4_d[l_ac].xrcf044= g_xrcf4_d_t.xrcf044
                  CALL axrt300_06_free_account_desc()
                  NEXT FIELD xrcf044
               END IF
            END IF
            CALL axrt300_06_free_account_desc()
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf044_desc
            #add-point:ON CHANGE xrcf044_desc name="input.g.page4.xrcf044_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf045
            #add-point:BEFORE FIELD xrcf045 name="input.b.page4.xrcf045"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf045
            
            #add-point:AFTER FIELD xrcf045 name="input.a.page4.xrcf045"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf045
            #add-point:ON CHANGE xrcf045 name="input.g.page4.xrcf045"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf045_desc
            #add-point:BEFORE FIELD xrcf045_desc name="input.b.page4.xrcf045_desc"
            #当来源类型为1时，开窗为agli041的开窗查询代码值，为2时，开q_glaf002,为3时不给开窗
            LET g_glae002 = ''
            LET g_glae009 = ''
            SELECT glae002 INTO g_glae002 FROM glae_t
             WHERE glaeent = g_enterprise
               AND glae001 = g_glad.glad0231
             IF g_glae002 = '1' THEN
                SELECT glae009 INTO g_glae009 FROM glae_t
                 WHERE glaeent = g_enterprise
                   AND glae001 = g_glad.glad0231
             END IF
             IF g_glae002 = '2' THEN
                LET g_glae009 = 'q_glaf002'
             END IF

             IF g_glae002 = '3' THEN
                LET g_glae009 = ''
             END IF
             LET g_xrcf4_d[l_ac].xrcf045_desc = g_xrcf4_d[l_ac].xrcf045
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf045_desc
            
            #add-point:AFTER FIELD xrcf045_desc name="input.a.page4.xrcf045_desc"
            LET g_xrcf4_d[l_ac].xrcf045 = g_xrcf4_d[l_ac].xrcf045_desc
            IF NOT cl_null(g_xrcf4_d[l_ac].xrcf045_desc) THEN
               CALL axrt300_06_free_account_chk(g_glad.glad0231,g_xrcf4_d[l_ac].xrcf045_desc,g_glad.glad0232) RETURNING l_errno
               IF NOT cl_null(l_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_xrcf4_d[l_ac].xrcf045
                  #160318-00005#53 --s add
                  CASE l_errno
                     WHEN 'sub-01302'
                           LET g_errparam.replace[1] = 'agli041'
                           LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                           LET g_errparam.exeprog = 'agli041'
                  END CASE
                  #160318-00005#53 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_xrcf4_d[l_ac].xrcf045= g_xrcf4_d_t.xrcf045
                  CALL axrt300_06_free_account_desc()
                  NEXT FIELD xrcf045
               END IF
            END IF
            CALL axrt300_06_free_account_desc()
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf045_desc
            #add-point:ON CHANGE xrcf045_desc name="input.g.page4.xrcf045_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf046
            #add-point:BEFORE FIELD xrcf046 name="input.b.page4.xrcf046"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf046
            
            #add-point:AFTER FIELD xrcf046 name="input.a.page4.xrcf046"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf046
            #add-point:ON CHANGE xrcf046 name="input.g.page4.xrcf046"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf046_desc
            #add-point:BEFORE FIELD xrcf046_desc name="input.b.page4.xrcf046_desc"
            #当来源类型为1时，开窗为agli041的开窗查询代码值，为2时，开q_glaf002,为3时不给开窗
            LET g_glae002 = ''
            LET g_glae009 = ''
            SELECT glae002 INTO g_glae002 FROM glae_t
             WHERE glaeent = g_enterprise
               AND glae001 = g_glad.glad0241
             IF g_glae002 = '1' THEN
                SELECT glae009 INTO g_glae009 FROM glae_t
                 WHERE glaeent = g_enterprise
                   AND glae001 = g_glad.glad0241
             END IF
             IF g_glae002 = '2' THEN
                LET g_glae009 = 'q_glaf002'
             END IF

             IF g_glae002 = '3' THEN
                LET g_glae009 = ''
             END IF
             LET g_xrcf4_d[l_ac].xrcf046_desc = g_xrcf4_d[l_ac].xrcf046
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf046_desc
            
            #add-point:AFTER FIELD xrcf046_desc name="input.a.page4.xrcf046_desc"
            LET g_xrcf4_d[l_ac].xrcf046 = g_xrcf4_d[l_ac].xrcf046_desc
            IF NOT cl_null(g_xrcf4_d[l_ac].xrcf046_desc) THEN
               CALL axrt300_06_free_account_chk(g_glad.glad0241,g_xrcf4_d[l_ac].xrcf046_desc,g_glad.glad0242) RETURNING l_errno
               IF NOT cl_null(l_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_xrcf4_d[l_ac].xrcf046_desc
                  #160318-00005#53 --s add
                  CASE l_errno
                     WHEN 'sub-01302'
                           LET g_errparam.replace[1] = 'agli041'
                           LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                           LET g_errparam.exeprog = 'agli041'
                  END CASE
                  #160318-00005#53 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_xrcf4_d[l_ac].xrcf046= g_xrcf4_d_t.xrcf046
                  CALL axrt300_06_free_account_desc()
                  NEXT FIELD xrcf046
               END IF
            END IF
            CALL axrt300_06_free_account_desc()
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf046_desc
            #add-point:ON CHANGE xrcf046_desc name="input.g.page4.xrcf046_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf047
            #add-point:BEFORE FIELD xrcf047 name="input.b.page4.xrcf047"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf047
            
            #add-point:AFTER FIELD xrcf047 name="input.a.page4.xrcf047"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf047
            #add-point:ON CHANGE xrcf047 name="input.g.page4.xrcf047"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf047_desc
            #add-point:BEFORE FIELD xrcf047_desc name="input.b.page4.xrcf047_desc"
            #当来源类型为1时，开窗为agli041的开窗查询代码值，为2时，开q_glaf002,为3时不给开窗
            LET g_glae002 = ''
            LET g_glae009 = ''
            SELECT glae002 INTO g_glae002 FROM glae_t
             WHERE glaeent = g_enterprise
               AND glae001 = g_glad.glad0251
            IF g_glae002 = '1' THEN
               SELECT glae009 INTO g_glae009 FROM glae_t
                WHERE glaeent = g_enterprise
                  AND glae001 = g_glad.glad0251
            END IF
            IF g_glae002 = '2' THEN
               LET g_glae009 = 'q_glaf002'
            END IF

            IF g_glae002 = '3' THEN
               LET g_glae009 = ''
            END IF
            LET g_xrcf4_d[l_ac].xrcf047_desc = g_xrcf4_d[l_ac].xrcf047
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf047_desc
            
            #add-point:AFTER FIELD xrcf047_desc name="input.a.page4.xrcf047_desc"
            LET g_xrcf4_d[l_ac].xrcf047 = g_xrcf4_d[l_ac].xrcf047_desc
            IF NOT cl_null(g_xrcf4_d[l_ac].xrcf047_desc) THEN
               CALL axrt300_06_free_account_chk(g_glad.glad0251,g_xrcf4_d[l_ac].xrcf047_desc,g_glad.glad0252) RETURNING l_errno
               IF NOT cl_null(l_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_xrcf4_d[l_ac].xrcf047_desc
                  #160318-00005#53 --s add
                  CASE l_errno
                     WHEN 'sub-01302'
                           LET g_errparam.replace[1] = 'agli041'
                           LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                           LET g_errparam.exeprog = 'agli041'
                  END CASE
                  #160318-00005#53 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_xrcf4_d[l_ac].xrcf047= g_xrcf4_d_t.xrcf047
                  CALL axrt300_06_free_account_desc()
                  NEXT FIELD xrcf047
               END IF
            END IF
            CALL axrt300_06_free_account_desc()
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf047_desc
            #add-point:ON CHANGE xrcf047_desc name="input.g.page4.xrcf047_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf048
            #add-point:BEFORE FIELD xrcf048 name="input.b.page4.xrcf048"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf048
            
            #add-point:AFTER FIELD xrcf048 name="input.a.page4.xrcf048"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf048
            #add-point:ON CHANGE xrcf048 name="input.g.page4.xrcf048"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf048_desc
            #add-point:BEFORE FIELD xrcf048_desc name="input.b.page4.xrcf048_desc"
            #当来源类型为1时，开窗为agli041的开窗查询代码值，为2时，开q_glaf002,为3时不给开窗
            LET g_glae002 = ''
            LET g_glae009 = ''
            SELECT glae002 INTO g_glae002 FROM glae_t
             WHERE glaeent = g_enterprise
               AND glae001 = g_glad.glad0261
            IF g_glae002 = '1' THEN
               SELECT glae009 INTO g_glae009 FROM glae_t
                WHERE glaeent = g_enterprise
                  AND glae001 = g_glad.glad0261
            END IF
            IF g_glae002 = '2' THEN
               LET g_glae009 = 'q_glaf002'
            END IF

            IF g_glae002 = '3' THEN
               LET g_glae009 = ''
            END IF
            LET g_xrcf4_d[l_ac].xrcf048_desc = g_xrcf4_d[l_ac].xrcf048
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf048_desc
            
            #add-point:AFTER FIELD xrcf048_desc name="input.a.page4.xrcf048_desc"
            LET g_xrcf4_d[l_ac].xrcf048 = g_xrcf4_d[l_ac].xrcf048_desc
            IF NOT cl_null(g_xrcf4_d[l_ac].xrcf048_desc) THEN
               CALL axrt300_06_free_account_chk(g_glad.glad0261,g_xrcf4_d[l_ac].xrcf048_desc,g_glad.glad0262) RETURNING l_errno
               IF NOT cl_null(l_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_xrcf4_d[l_ac].xrcf048_desc
                  #160318-00005#53 --s add
                  CASE l_errno
                     WHEN 'sub-01302'
                           LET g_errparam.replace[1] = 'agli041'
                           LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                           LET g_errparam.exeprog = 'agli041'
                  END CASE
                  #160318-00005#53 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_xrcf4_d[l_ac].xrcf048= g_xrcf4_d_t.xrcf048
                  CALL axrt300_06_free_account_desc()
                  NEXT FIELD xrcf048_desc
               END IF
            END IF
            CALL axrt300_06_free_account_desc()
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf048_desc
            #add-point:ON CHANGE xrcf048_desc name="input.g.page4.xrcf048_desc"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page4.xrcf049
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf049
            #add-point:ON ACTION controlp INFIELD xrcf049 name="input.c.page4.xrcf049"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.xrcf021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf021
            #add-point:ON ACTION controlp INFIELD xrcf021 name="input.c.page4.xrcf021"
 
            #END add-point
 
 
         #Ctrlp:input.c.page4.xrcf021_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf021_desc
            #add-point:ON ACTION controlp INFIELD xrcf021_desc name="input.c.page4.xrcf021_desc"
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xrcf4_d[l_ac].xrcf021_desc   #給予default值
            LET g_qryparam.where = " glac001 = '",g_glaa.glaa004,"' AND glac006 = '1'",
                                   " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 AND gladld='",g_xrcf4_d[l_ac].xrcfld,"' AND gladent=",g_enterprise,
                                   " AND gladstus = 'Y' )" #150916-00015#1 add

            #給予arg

            CALL aglt310_04()                                   #呼叫開窗

            LET g_xrcf4_d[l_ac].xrcf021_desc = g_qryparam.return1    #將開窗取得的值回傳到變數
            LET g_xrcf4_d[l_ac].xrcf021 = g_xrcf4_d[l_ac].xrcf021_desc

            DISPLAY g_xrcf4_d[l_ac].xrcf021_desc TO s_detail4[l_ac].xrcf021_desc          #顯示到畫面上

            NEXT FIELD xrcf021_desc                                  #返回原欄位

            #END add-point
 
 
         #Ctrlp:input.c.page4.xrcf023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf023
            #add-point:ON ACTION controlp INFIELD xrcf023 name="input.c.page4.xrcf023"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.xrcf023_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf023_desc
            #add-point:ON ACTION controlp INFIELD xrcf023_desc name="input.c.page4.xrcf023_desc"
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xrcf4_d[l_ac].xrcf023_desc   #給予default值
            LET g_qryparam.where = " glac001 = '",g_glaa.glaa004,"' AND glac006 = '1'",
                                   " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 AND gladld='",g_xrcf4_d[l_ac].xrcfld,"' AND gladent=",g_enterprise,
                                   " AND gladstus = 'Y' )" #150916-00015#1 add

            #給予arg

            CALL aglt310_04()                                   #呼叫開窗

            LET g_xrcf4_d[l_ac].xrcf023_desc = g_qryparam.return1    #將開窗取得的值回傳到變數
            LET g_xrcf4_d[l_ac].xrcf023 = g_xrcf4_d[l_ac].xrcf023_desc

            DISPLAY g_xrcf4_d[l_ac].xrcf023_desc TO s_detail4[l_ac].xrcf023_desc          #顯示到畫面上

            NEXT FIELD xrcf023_desc                                  #返回原欄位

            #END add-point
 
 
         #Ctrlp:input.c.page4.xrcf033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf033
            #add-point:ON ACTION controlp INFIELD xrcf033 name="input.c.page4.xrcf033"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.xrcf033_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf033_desc
            #add-point:ON ACTION controlp INFIELD xrcf033_desc name="input.c.page4.xrcf033_desc"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xrcf4_d[l_ac].xrcf033_desc

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooag001()                                #呼叫開窗

            LET g_xrcf4_d[l_ac].xrcf033_desc = g_qryparam.return1  #1020 mod    
            LET g_xrcf4_d[l_ac].xrcf033 = g_xrcf4_d[l_ac].xrcf033_desc
            DISPLAY g_xrcf4_d[l_ac].xrcf033_desc TO s_detail4[l_ac].xrcf033_desc              #

            NEXT FIELD xrcf033_desc                          #返回原欄位

            #END add-point
 
 
         #Ctrlp:input.c.page4.xrcf026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf026
            #add-point:ON ACTION controlp INFIELD xrcf026 name="input.c.page4.xrcf026"
 
            #END add-point
 
 
         #Ctrlp:input.c.page4.xrcf026_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf026_desc
            #add-point:ON ACTION controlp INFIELD xrcf026_desc name="input.c.page4.xrcf026_desc"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xrcf4_d[l_ac].xrcf026_desc           #給予default值
            #給予arg
            LET g_qryparam.arg1 = g_today
            CALL q_ooeg001_4()                                #呼叫開窗
            LET g_xrcf4_d[l_ac].xrcf026_desc = g_qryparam.return1
            LET g_xrcf4_d[l_ac].xrcf026 = g_xrcf4_d[l_ac].xrcf026_desc
            DISPLAY g_xrcf4_d[l_ac].xrcf026_desc TO s_detail4[l_ac].xrcf026_desc
            NEXT FIELD xrcf026_desc                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page4.xrcf027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf027
            #add-point:ON ACTION controlp INFIELD xrcf027 name="input.c.page4.xrcf027"
 
            #END add-point
 
 
         #Ctrlp:input.c.page4.xrcf027_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf027_desc
            #add-point:ON ACTION controlp INFIELD xrcf027_desc name="input.c.page4.xrcf027_desc"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xrcf4_d[l_ac].xrcf027_desc             #給予default值
            LET g_qryparam.where = " (ooeg003 = '2' OR ooeg003 = '3')"
            #給予arg
            LET g_qryparam.arg1 = g_today
            CALL q_ooeg001_4()                                #呼叫開窗
            LET g_xrcf4_d[l_ac].xrcf027_desc = g_qryparam.return1
            LET g_xrcf4_d[l_ac].xrcf027 = g_xrcf4_d[l_ac].xrcf027_desc
            DISPLAY g_xrcf4_d[l_ac].xrcf027_desc TO s_detail4[l_ac].xrcf027_desc
            NEXT FIELD xrcf027_desc

            #END add-point
 
 
         #Ctrlp:input.c.page4.xrcf028
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf028
            #add-point:ON ACTION controlp INFIELD xrcf028 name="input.c.page4.xrcf028"
            #此段落由子樣板a07產生            

            #END add-point
 
 
         #Ctrlp:input.c.page4.xrcf028_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf028_desc
            #add-point:ON ACTION controlp INFIELD xrcf028_desc name="input.c.page4.xrcf028_desc"
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xrcf4_d[l_ac].xrcf028_desc             #給予default值
            LET g_qryparam.default2 = "" #g_xrcf4_d[l_ac].oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = '287'

            
            CALL q_oocq002()                                #呼叫開窗

            LET g_xrcf4_d[l_ac].xrcf028_desc = g_qryparam.return1   
            LET g_xrcf4_d[l_ac].xrcf028 = g_xrcf4_d[l_ac].xrcf028_desc           
            DISPLAY g_xrcf4_d[l_ac].xrcf028_desc TO s_detail4[l_ac].xrcf028_desc          
            NEXT FIELD xrcf028_desc
            #END add-point
 
 
         #Ctrlp:input.c.page4.xrcf031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf031
            #add-point:ON ACTION controlp INFIELD xrcf031 name="input.c.page4.xrcf031"
 
            #END add-point
 
 
         #Ctrlp:input.c.page4.xrcf031_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf031_desc
            #add-point:ON ACTION controlp INFIELD xrcf031_desc name="input.c.page4.xrcf031_desc"
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xrcf4_d[l_ac].xrcf031_desc             #給予default值
            #給予arg
            LET g_qryparam.arg1 = '281'
            CALL q_oocq002()                                #呼叫開窗
            LET g_xrcf4_d[l_ac].xrcf031_desc = g_qryparam.return1
            LET g_xrcf4_d[l_ac].xrcf031 = g_xrcf4_d[l_ac].xrcf031_desc
            DISPLAY g_xrcf4_d[l_ac].xrcf031_desc TO s_detail4[l_ac].xrcf031_desc

            NEXT FIELD xrcf031_desc                  #返回原欄位

            #END add-point
 
 
         #Ctrlp:input.c.page4.xrcf032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf032
            #add-point:ON ACTION controlp INFIELD xrcf032 name="input.c.page4.xrcf032"
 
            #END add-point
 
 
         #Ctrlp:input.c.page4.xrcf032_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf032_desc
            #add-point:ON ACTION controlp INFIELD xrcf032_desc name="input.c.page4.xrcf032_desc"
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xrcf4_d[l_ac].xrcf032_desc             #給予default值
            #給予arg
            LET g_qryparam.arg1 = "" #
            CALL q_rtax001_1()                                #呼叫開窗
            LET g_xrcf4_d[l_ac].xrcf032_desc = g_qryparam.return1
            LET g_xrcf4_d[l_ac].xrcf032 = g_xrcf4_d[l_ac].xrcf032_desc
            DISPLAY g_xrcf4_d[l_ac].xrcf032_desc TO s_detail4[l_ac].xrcf032_desc
            NEXT FIELD xrcf032_desc                         #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page4.xrcf034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf034
            #add-point:ON ACTION controlp INFIELD xrcf034 name="input.c.page4.xrcf034"
 
            #END add-point
 
 
         #Ctrlp:input.c.page4.xrcf034_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf034_desc
            #add-point:ON ACTION controlp INFIELD xrcf034_desc name="input.c.page4.xrcf034_desc"
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xrcf4_d[l_ac].xrcf034_desc             #給予default值
            #給予arg
            LET g_qryparam.arg1 = "" #
            CALL q_pjba001()                                #呼叫開窗
            LET g_xrcf4_d[l_ac].xrcf034_desc = g_qryparam.return1
            LET g_xrcf4_d[l_ac].xrcf034 = g_xrcf4_d[l_ac].xrcf034_desc
            DISPLAY g_xrcf4_d[l_ac].xrcf034_desc TO s_detail4[l_ac].xrcf034_desc
            NEXT FIELD xrcf034_desc                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page4.xrcf035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf035
            #add-point:ON ACTION controlp INFIELD xrcf035 name="input.c.page4.xrcf035"
 
            #END add-point
 
 
         #Ctrlp:input.c.page4.xrcf035_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf035_desc
            #add-point:ON ACTION controlp INFIELD xrcf035_desc name="input.c.page4.xrcf035_desc"
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xrcf4_d[l_ac].xrcf035_desc             #給予default值
            #給予arg
            LET g_qryparam.arg1 = g_xrcf4_d[l_ac].xrcf035_desc
            CALL q_pjbb002_1()                                #呼叫開窗
            LET g_xrcf4_d[l_ac].xrcf035_desc = g_qryparam.return1
            LET g_xrcf4_d[l_ac].xrcf035 = g_xrcf4_d[l_ac].xrcf035_desc
            DISPLAY g_xrcf4_d[l_ac].xrcf035_desc TO s_detail4[l_ac].xrcf035_desc
            NEXT FIELD xrcf035_desc
            #END add-point
 
 
         #Ctrlp:input.c.page4.xrcf036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf036
            #add-point:ON ACTION controlp INFIELD xrcf036 name="input.c.page4.xrcf036"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.xrcf037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf037
            #add-point:ON ACTION controlp INFIELD xrcf037 name="input.c.page4.xrcf037"
 
            #END add-point
 
 
         #Ctrlp:input.c.page4.xrcf037_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf037_desc
            #add-point:ON ACTION controlp INFIELD xrcf037_desc name="input.c.page4.xrcf037_desc"
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xrcf4_d[l_ac].xrcf037_desc             #給予default值
            #給予arg
            LET g_qryparam.arg1 = "1" #
            CALL q_oojd001()                                #呼叫開窗
            LET g_xrcf4_d[l_ac].xrcf037_desc = g_qryparam.return1    
            LET g_xrcf4_d[l_ac].xrcf037 = g_xrcf4_d[l_ac].xrcf037_desc          
            DISPLAY g_xrcf4_d[l_ac].xrcf037_desc TO s_detail4[l_ac].xrcf037_desc             
            NEXT FIELD xrcf037_desc                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page4.xrcf038
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf038
            #add-point:ON ACTION controlp INFIELD xrcf038 name="input.c.page4.xrcf038"
                         #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page4.xrcf038_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf038_desc
            #add-point:ON ACTION controlp INFIELD xrcf038_desc name="input.c.page4.xrcf038_desc"
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xrcf4_d[l_ac].xrcf038_desc             #給予default值
            LET g_qryparam.default2 = "" #g_xrcf4_d[l_ac].oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "2002" #
            CALL q_oocq002()                                #呼叫開窗
            LET g_xrcf4_d[l_ac].xrcf038_desc = g_qryparam.return1
            LET g_xrcf4_d[l_ac].xrcf038 = g_xrcf4_d[l_ac].xrcf038_desc
            DISPLAY g_xrcf4_d[l_ac].xrcf038_desc TO s_detail4[l_ac].xrcf038_desc
            NEXT FIELD xrcf038_desc
            #END add-point
 
 
         #Ctrlp:input.c.page4.xrcf039
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf039
            #add-point:ON ACTION controlp INFIELD xrcf039 name="input.c.page4.xrcf039"
 
            #END add-point
 
 
         #Ctrlp:input.c.page4.xrcf039_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf039_desc
            #add-point:ON ACTION controlp INFIELD xrcf039_desc name="input.c.page4.xrcf039_desc"
           IF NOT CL_NULL(g_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_xrcf4_d[l_ac].xrcf039_desc
               LET g_qryparam.default2 = "" #g_glaq_m.glafl004 #說明
               #給予arg
               IF g_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0171,"'" #自由核算項類型
               END IF
               CALL q_agli041(g_glae009)                                #呼叫開窗
               LET g_xrcf4_d[l_ac].xrcf039 = g_qryparam.return1              #將開窗取得的值回傳到變數
               LET g_xrcf4_d[l_ac].xrcf039_desc = g_qryparam.return1              #將開窗取得的值回傳到變數
               DISPLAY g_xrcf4_d[l_ac].xrcf039_desc TO xrcf039              #顯示到畫面上
               LET g_qryparam.where = ''
               NEXT FIELD xrcf039_desc                          #返回原欄位
            END IF

            #END add-point
 
 
         #Ctrlp:input.c.page4.xrcf040
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf040
            #add-point:ON ACTION controlp INFIELD xrcf040 name="input.c.page4.xrcf040"
 
            #END add-point
 
 
         #Ctrlp:input.c.page4.xrcf040_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf040_desc
            #add-point:ON ACTION controlp INFIELD xrcf040_desc name="input.c.page4.xrcf040_desc"
            IF NOT CL_NULL(g_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_xrcf4_d[l_ac].xrcf040_desc
               LET g_qryparam.default2 = "" #g_glaq_m.glafl004 #說明
               #給予arg
              IF g_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where ="glaf001 = '",g_glad.glad0181,"'" #自由核算項類型
               END IF
               CALL q_agli041(g_glae009)                              #呼叫開窗
               LET g_xrcf4_d[l_ac].xrcf040 = g_qryparam.return1              #將開窗取得的值回傳到變數
               LET g_xrcf4_d[l_ac].xrcf040_desc = g_qryparam.return1              #將開窗取得的值回傳到變數
               DISPLAY g_xrcf4_d[l_ac].xrcf040_desc TO xrcf040_desc             #顯示到畫面上
               LET g_qryparam.where = ''
               NEXT FIELD xrcf040_desc                          #返回原欄位
            END IF

            #END add-point
 
 
         #Ctrlp:input.c.page4.xrcf041
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf041
            #add-point:ON ACTION controlp INFIELD xrcf041 name="input.c.page4.xrcf041"
 
            #END add-point
 
 
         #Ctrlp:input.c.page4.xrcf041_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf041_desc
            #add-point:ON ACTION controlp INFIELD xrcf041_desc name="input.c.page4.xrcf041_desc"
            IF NOT CL_NULL(g_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_xrcf4_d[l_ac].xrcf041_desc
               LET g_qryparam.default2 = "" #g_glaq_m.glafl004 #說明
               #給予arg
              IF g_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where  = "glaf001 = '",g_glad.glad0191,"'" #自由核算項類型
               END IF
               CALL q_agli041(g_glae009)                              #呼叫開窗
               LET g_xrcf4_d[l_ac].xrcf041 = g_qryparam.return1              #將開窗取得的值回傳到變數
               LET g_xrcf4_d[l_ac].xrcf041_desc = g_qryparam.return1              #將開窗取得的值回傳到變數
               DISPLAY g_xrcf4_d[l_ac].xrcf041_desc TO xrcf041_desc             #顯示到畫面上
               LET g_qryparam.where = ''
               NEXT FIELD xrcf041_desc                          #返回原欄位
            END IF

            #END add-point
 
 
         #Ctrlp:input.c.page4.xrcf042
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf042
            #add-point:ON ACTION controlp INFIELD xrcf042 name="input.c.page4.xrcf042"
 
            #END add-point
 
 
         #Ctrlp:input.c.page4.xrcf042_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf042_desc
            #add-point:ON ACTION controlp INFIELD xrcf042_desc name="input.c.page4.xrcf042_desc"
             IF NOT CL_NULL(g_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_xrcf4_d[l_ac].xrcf042_desc
               LET g_qryparam.default2 = "" #g_glaq_m.glafl004 #說明
               #給予arg
              IF g_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where  = "glaf001 = '",g_glad.glad0201,"'" #自由核算項類型
               END IF
               CALL q_agli041(g_glae009)                              #呼叫開窗
               LET g_xrcf4_d[l_ac].xrcf042 = g_qryparam.return1              #將開窗取得的值回傳到變數
               LET g_xrcf4_d[l_ac].xrcf042_desc = g_qryparam.return1              #將開窗取得的值回傳到變數
               DISPLAY g_xrcf4_d[l_ac].xrcf042_desc TO xrcf042_desc             #顯示到畫面上
               LET g_qryparam.where = ''
               NEXT FIELD xrcf042_desc                         #返回原欄位
            END IF

            #END add-point
 
 
         #Ctrlp:input.c.page4.xrcf043
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf043
            #add-point:ON ACTION controlp INFIELD xrcf043 name="input.c.page4.xrcf043"
 
            #END add-point
 
 
         #Ctrlp:input.c.page4.xrcf043_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf043_desc
            #add-point:ON ACTION controlp INFIELD xrcf043_desc name="input.c.page4.xrcf043_desc"
            IF NOT CL_NULL(g_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_xrcf4_d[l_ac].xrcf043_desc
               LET g_qryparam.default2 = "" #g_glaq_m.glafl004 #說明
               #給予arg
              IF g_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where  = "glaf001 = '",g_glad.glad0211,"'" #自由核算項類型
               END IF
               CALL q_agli041(g_glae009)                              #呼叫開窗
               LET g_xrcf4_d[l_ac].xrcf043 = g_qryparam.return1              #將開窗取得的值回傳到變數
               LET g_xrcf4_d[l_ac].xrcf043_desc = g_qryparam.return1              #將開窗取得的值回傳到變數
               DISPLAY g_xrcf4_d[l_ac].xrcf043_desc TO xrcf043_desc           #顯示到畫面上
               LET g_qryparam.where = ''
               NEXT FIELD xrcf043_desc                        #返回原欄位
            END IF

            #END add-point
 
 
         #Ctrlp:input.c.page4.xrcf044
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf044
            #add-point:ON ACTION controlp INFIELD xrcf044 name="input.c.page4.xrcf044"
 
            #END add-point
 
 
         #Ctrlp:input.c.page4.xrcf044_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf044_desc
            #add-point:ON ACTION controlp INFIELD xrcf044_desc name="input.c.page4.xrcf044_desc"
            IF NOT CL_NULL(g_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_xrcf4_d[l_ac].xrcf044_desc
               LET g_qryparam.default2 = "" #g_glaq_m.glafl004 #說明
               #給予arg
              IF g_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where  = "glaf001 = '",g_glad.glad0221,"'" #自由核算項類型
               END IF
               CALL q_agli041(g_glae009)                              #呼叫開窗
               LET g_xrcf4_d[l_ac].xrcf044 = g_qryparam.return1              #將開窗取得的值回傳到變數
               LET g_xrcf4_d[l_ac].xrcf044_desc = g_qryparam.return1              #將開窗取得的值回傳到變數
               DISPLAY g_xrcf4_d[l_ac].xrcf044_desc TO xrcf044_desc           #顯示到畫面上
               LET g_qryparam.where = ''
               NEXT FIELD xrcf044_desc                        #返回原欄位
            END IF

            #END add-point
 
 
         #Ctrlp:input.c.page4.xrcf045
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf045
            #add-point:ON ACTION controlp INFIELD xrcf045 name="input.c.page4.xrcf045"
 
            #END add-point
 
 
         #Ctrlp:input.c.page4.xrcf045_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf045_desc
            #add-point:ON ACTION controlp INFIELD xrcf045_desc name="input.c.page4.xrcf045_desc"
           IF NOT CL_NULL(g_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_xrcf4_d[l_ac].xrcf045_desc
               LET g_qryparam.default2 = "" #g_glaq_m.glafl004 #說明
               #給予arg
              IF g_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where  = "glaf001 = '",g_glad.glad0231,"'" #自由核算項類型
               END IF
               CALL q_agli041(g_glae009)                              #呼叫開窗
               LET g_xrcf4_d[l_ac].xrcf045 = g_qryparam.return1              #將開窗取得的值回傳到變數
               LET g_xrcf4_d[l_ac].xrcf045_desc = g_qryparam.return1              #將開窗取得的值回傳到變數
               DISPLAY g_xrcf4_d[l_ac].xrcf045_desc TO xrcf045_desc           #顯示到畫面上
               LET g_qryparam.where = ''
               NEXT FIELD xrcf045_desc                        #返回原欄位
            END IF

            #END add-point
 
 
         #Ctrlp:input.c.page4.xrcf046
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf046
            #add-point:ON ACTION controlp INFIELD xrcf046 name="input.c.page4.xrcf046"
 
            #END add-point
 
 
         #Ctrlp:input.c.page4.xrcf046_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf046_desc
            #add-point:ON ACTION controlp INFIELD xrcf046_desc name="input.c.page4.xrcf046_desc"
             IF NOT CL_NULL(g_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_xrcf4_d[l_ac].xrcf046_desc
               LET g_qryparam.default2 = "" #g_glaq_m.glafl004 #說明
               #給予arg
              IF g_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where  = "glaf001 = '",g_glad.glad0241,"'" #自由核算項類型
               END IF
               CALL q_agli041(g_glae009)                              #呼叫開窗
               LET g_xrcf4_d[l_ac].xrcf046 = g_qryparam.return1              #將開窗取得的值回傳到變數
               LET g_xrcf4_d[l_ac].xrcf046_desc = g_qryparam.return1              #將開窗取得的值回傳到變數
               DISPLAY g_xrcf4_d[l_ac].xrcf046_desc TO xrcf046_desc           #顯示到畫面上
               LET g_qryparam.where = ''
               NEXT FIELD xrcf046_desc                      #返回原欄位
            END IF

            #END add-point
 
 
         #Ctrlp:input.c.page4.xrcf047
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf047
            #add-point:ON ACTION controlp INFIELD xrcf047 name="input.c.page4.xrcf047"
 
            #END add-point
 
 
         #Ctrlp:input.c.page4.xrcf047_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf047_desc
            #add-point:ON ACTION controlp INFIELD xrcf047_desc name="input.c.page4.xrcf047_desc"
            IF NOT CL_NULL(g_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_xrcf4_d[l_ac].xrcf047_desc
               LET g_qryparam.default2 = "" #g_glaq_m.glafl004 #說明
               #給予arg
               IF g_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where  = "glaf001 = '",g_glad.glad0251,"'" #自由核算項類型
               END IF
               CALL q_agli041(g_glae009)                              #呼叫開窗
               LET g_xrcf4_d[l_ac].xrcf047 = g_qryparam.return1              #將開窗取得的值回傳到變數
               LET g_xrcf4_d[l_ac].xrcf047_desc = g_qryparam.return1              #將開窗取得的值回傳到變數
               DISPLAY g_xrcf4_d[l_ac].xrcf047_desc TO xrcf047_desc           #顯示到畫面上
               LET g_qryparam.where = ''
               NEXT FIELD xrcf047_desc                     #返回原欄位
            END IF

            #END add-point
 
 
         #Ctrlp:input.c.page4.xrcf048
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf048
            #add-point:ON ACTION controlp INFIELD xrcf048 name="input.c.page4.xrcf048"
 
            #END add-point
 
 
         #Ctrlp:input.c.page4.xrcf048_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf048_desc
            #add-point:ON ACTION controlp INFIELD xrcf048_desc name="input.c.page4.xrcf048_desc"
            IF NOT CL_NULL(g_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_xrcf4_d[l_ac].xrcf048_desc
               LET g_qryparam.default2 = "" #g_glaq_m.glafl004 #說明
               #給予arg
               IF g_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where  = "glaf001 = '",g_glad.glad0261,"'" #自由核算項類型
               END IF
               CALL q_agli041(g_glae009)                              #呼叫開窗
               LET g_xrcf4_d[l_ac].xrcf048 = g_qryparam.return1              #將開窗取得的值回傳到變數
               LET g_xrcf4_d[l_ac].xrcf048_desc = g_qryparam.return1              #將開窗取得的值回傳到變數
               DISPLAY g_xrcf4_d[l_ac].xrcf048_desc TO xrcf048_desc           #顯示到畫面上
               LET g_qryparam.where = ''
               NEXT FIELD xrcf048_desc                     #返回原欄位
            END IF

            #END add-point
 
 
 
 
         AFTER ROW
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_xrcf4_d[l_ac].* = g_xrcf4_d_t.*
               END IF
               CLOSE axrt300_06_bcl
               #add-point:單身after row name="input.body4.a_close"
               
               #end add-point
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
 
            CALL axrt300_06_unlock_b("xrcf_t")
            #add-point:單身after row name="input.body4.a_row"
            
            #end add-point
            
         AFTER INPUT
            #add-point:單身4input後 name="input.body4.a_input"
            
            #end add-point
         
         #複製上一次指定的單身資料至最下方
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_xrcf_d[li_reproduce_target].* = g_xrcf_d[li_reproduce].*
               LET g_xrcf2_d[li_reproduce_target].* = g_xrcf2_d[li_reproduce].*
               LET g_xrcf3_d[li_reproduce_target].* = g_xrcf3_d[li_reproduce].*
               LET g_xrcf4_d[li_reproduce_target].* = g_xrcf4_d[li_reproduce].*
               LET g_xrcf5_d[li_reproduce_target].* = g_xrcf5_d[li_reproduce].*
 
               LET g_xrcf4_d[li_reproduce_target].xrcfld = NULL
               LET g_xrcf4_d[li_reproduce_target].xrcfdocno = NULL
               LET g_xrcf4_d[li_reproduce_target].xrcfseq = NULL
               LET g_xrcf4_d[li_reproduce_target].xrcfseq2 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_xrcf4_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_xrcf4_d.getLength()+1
            END IF
      END INPUT
      INPUT ARRAY g_xrcf5_d FROM s_detail5.*
         ATTRIBUTE(COUNT = g_detail_cnt,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = FALSE, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_5)
         
         
         BEFORE INPUT
          CALL FGL_SET_ARR_CURR(g_detail_idx)
            
            CALL axrt300_06_b_fill(g_wc2)
            LET g_detail_cnt = g_xrcf5_d.getLength()
    
         BEFORE INSERT
            LET g_insert = 'Y' 
            NEXT FIELD xrcfld
 
            LET l_insert = TRUE
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_xrcf5_d[l_ac].* TO NULL 
            INITIALIZE g_xrcf5_d_t.* TO NULL
            INITIALIZE g_xrcf5_d_o.* TO NULL
            #公用欄位給值(單身5)
            
            #自定義預設值(單身5)
            
            #add-point:modify段before備份 name="input.body5.before_bak"
            
            #end add-point
            LET g_xrcf5_d_t.* = g_xrcf5_d[l_ac].*     #新輸入資料
            LET g_xrcf5_d_o.* = g_xrcf5_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xrcf_d[li_reproduce_target].* = g_xrcf_d[li_reproduce].*
               LET g_xrcf2_d[li_reproduce_target].* = g_xrcf2_d[li_reproduce].*
               LET g_xrcf3_d[li_reproduce_target].* = g_xrcf3_d[li_reproduce].*
               LET g_xrcf4_d[li_reproduce_target].* = g_xrcf4_d[li_reproduce].*
               LET g_xrcf5_d[li_reproduce_target].* = g_xrcf5_d[li_reproduce].*
 
               LET g_xrcf5_d[li_reproduce_target].xrcfld = NULL
               LET g_xrcf5_d[li_reproduce_target].xrcfdocno = NULL
               LET g_xrcf5_d[li_reproduce_target].xrcfseq = NULL
               LET g_xrcf5_d[li_reproduce_target].xrcfseq2 = NULL
            END IF
            
 
 
 
 
 
            CALL axrt300_06_set_entry_b(l_cmd)
            CALL axrt300_06_set_no_entry_b(l_cmd)
            #add-point:modify段before insert name="input.body5.before_insert"
            
            #end add-point  
            
         BEFORE ROW 
            #add-point:modify段before row name="input.body5.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail5")
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET l_ac = g_detail_idx
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
            DISPLAY g_xrcf5_d.getLength() TO FORMONLY.cnt
         
            CALL s_transaction_begin()
            
            LET g_detail_cnt = g_xrcf5_d.getLength()
            
            IF g_detail_cnt >= l_ac 
               AND g_xrcf5_d[l_ac].xrcfld IS NOT NULL
               AND g_xrcf5_d[l_ac].xrcfdocno IS NOT NULL
               AND g_xrcf5_d[l_ac].xrcfseq IS NOT NULL
               AND g_xrcf5_d[l_ac].xrcfseq2 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_xrcf5_d_t.* = g_xrcf5_d[l_ac].*  #BACKUP
               LET g_xrcf5_d_o.* = g_xrcf5_d[l_ac].*  #BACKUP
               IF NOT axrt300_06_lock_b("xrcf_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH axrt300_06_bcl INTO g_xrcf_d[l_ac].xrcfdocno,g_xrcf_d[l_ac].xrcfld,g_xrcf_d[l_ac].xrcfseq2, 
                      g_xrcf_d[l_ac].xrcfseq,g_xrcf_d[l_ac].xrcf008,g_xrcf_d[l_ac].xrcf009,g_xrcf_d[l_ac].xrcf021, 
                      g_xrcf_d[l_ac].xrcf007,g_xrcf_d[l_ac].xrcf101,g_xrcf_d[l_ac].xrcf103,g_xrcf_d[l_ac].xrcf104, 
                      g_xrcf_d[l_ac].xrcf105,g_xrcf_d[l_ac].xrcf106,g_xrcf_d[l_ac].xrcf102,g_xrcf_d[l_ac].xrcf111, 
                      g_xrcf_d[l_ac].xrcf113,g_xrcf_d[l_ac].xrcf114,g_xrcf_d[l_ac].xrcf115,g_xrcf_d[l_ac].xrcf116, 
                      g_xrcf_d[l_ac].xrcf117,g_xrcf2_d[l_ac].xrcfdocno,g_xrcf2_d[l_ac].xrcfld,g_xrcf2_d[l_ac].xrcfseq, 
                      g_xrcf2_d[l_ac].xrcfseq2,g_xrcf2_d[l_ac].xrcf022,g_xrcf2_d[l_ac].xrcf024,g_xrcf2_d[l_ac].xrcf025, 
                      g_xrcf3_d[l_ac].xrcfdocno,g_xrcf3_d[l_ac].xrcfld,g_xrcf3_d[l_ac].xrcfseq,g_xrcf3_d[l_ac].xrcfseq2, 
                      g_xrcf3_d[l_ac].xrcf105,g_xrcf3_d[l_ac].xrcf102,g_xrcf3_d[l_ac].xrcf115,g_xrcf3_d[l_ac].xrcf122, 
                      g_xrcf3_d[l_ac].xrcf123,g_xrcf3_d[l_ac].xrcf124,g_xrcf3_d[l_ac].xrcf125,g_xrcf3_d[l_ac].xrcf126, 
                      g_xrcf3_d[l_ac].xrcf127,g_xrcf3_d[l_ac].xrcf132,g_xrcf3_d[l_ac].xrcf133,g_xrcf3_d[l_ac].xrcf134, 
                      g_xrcf3_d[l_ac].xrcf135,g_xrcf3_d[l_ac].xrcf136,g_xrcf3_d[l_ac].xrcf137,g_xrcf4_d[l_ac].xrcfdocno, 
                      g_xrcf4_d[l_ac].xrcfld,g_xrcf4_d[l_ac].xrcfseq,g_xrcf4_d[l_ac].xrcfseq2,g_xrcf4_d[l_ac].xrcf049, 
                      g_xrcf4_d[l_ac].xrcf021,g_xrcf4_d[l_ac].xrcf023,g_xrcf4_d[l_ac].xrcf033,g_xrcf4_d[l_ac].xrcf026, 
                      g_xrcf4_d[l_ac].xrcf027,g_xrcf4_d[l_ac].xrcf028,g_xrcf4_d[l_ac].xrcf031,g_xrcf4_d[l_ac].xrcf032, 
                      g_xrcf4_d[l_ac].xrcf034,g_xrcf4_d[l_ac].xrcf035,g_xrcf4_d[l_ac].xrcf036,g_xrcf4_d[l_ac].xrcf037, 
                      g_xrcf4_d[l_ac].xrcf038,g_xrcf4_d[l_ac].xrcf039,g_xrcf4_d[l_ac].xrcf040,g_xrcf4_d[l_ac].xrcf041, 
                      g_xrcf4_d[l_ac].xrcf042,g_xrcf4_d[l_ac].xrcf043,g_xrcf4_d[l_ac].xrcf044,g_xrcf4_d[l_ac].xrcf045, 
                      g_xrcf4_d[l_ac].xrcf046,g_xrcf4_d[l_ac].xrcf047,g_xrcf4_d[l_ac].xrcf048,g_xrcf5_d[l_ac].xrcfdocno, 
                      g_xrcf5_d[l_ac].xrcfld,g_xrcf5_d[l_ac].xrcfseq,g_xrcf5_d[l_ac].xrcfseq2,g_xrcf5_d[l_ac].xrcf001, 
                      g_xrcf5_d[l_ac].xrcf002,g_xrcf5_d[l_ac].xrcf010,g_xrcf5_d[l_ac].xrcf020,g_xrcf5_d[l_ac].xrcf029, 
                      g_xrcf5_d[l_ac].xrcf030,g_xrcf5_d[l_ac].xrcforga
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "FETCH axrt300_06_bcl:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_xrcf5_d_mask_o[l_ac].* =  g_xrcf5_d[l_ac].*
                  CALL axrt300_06_xrcf_t_mask()
                  LET g_xrcf5_d_mask_n[l_ac].* =  g_xrcf5_d[l_ac].*
                  
                  CALL cl_show_fld_cont()
                  CALL axrt300_06_detail_show()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL axrt300_06_set_entry_b(l_cmd)
            CALL axrt300_06_set_no_entry_b(l_cmd)
            #add-point:modify段before row name="input.body5.before_row"
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
 
 
 
 
            #其他table進行lock
            
 
 
 
 
 
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
            ELSE
               #add-point:單身5ask刪除前 name="input.body5.b_delete_ask"
               
               #end add-point 
            
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
               
               #add-point:單身5刪除前 name="input.body5.b_delete"
               
               #end add-point 
               
               DELETE FROM xrcf_t
                WHERE xrcfent = g_enterprise AND
                  xrcfld = g_xrcf5_d_t.xrcfld
                  AND xrcfdocno = g_xrcf5_d_t.xrcfdocno
                  AND xrcfseq = g_xrcf5_d_t.xrcfseq
                  AND xrcfseq2 = g_xrcf5_d_t.xrcfseq2
                  
               #add-point:單身5刪除中 name="input.body5.m_delete"
               
               #end add-point 
                  
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "xrcf_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  
 
 
 
 
 
                  #add-point:單身5刪除後 name="input.body5.a_delete"
                  
                  #end add-point
                  #修改歷程記錄(刪除)
                  CALL axrt300_06_set_pk_array()
                  LET g_log1 = util.JSON.stringify(g_xrcf5_d[l_ac])   #(ver:38)
                  IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:38)
                  ELSE
                  END IF
               END IF 
               CLOSE axrt300_06_bcl
               #add-point:單身5刪除關閉bcl name="input.body5.close"
               
               #end add-point
               LET l_count = g_xrcf_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xrcf5_d_t.xrcfld
               LET gs_keys[2] = g_xrcf5_d_t.xrcfdocno
               LET gs_keys[3] = g_xrcf5_d_t.xrcfseq
               LET gs_keys[4] = g_xrcf5_d_t.xrcfseq2
 
               #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL axrt300_06_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
            END IF 
            
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2 name="input.body5.after_delete"
               
               #end add-point
                              CALL axrt300_06_delete_b('xrcf_t',gs_keys,"'5'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_xrcf5_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            #add-point:單身刪除後3 name="input.body5.after_delete3"
            
            #end add-point
 
         AFTER INSERT    
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM xrcf_t 
             WHERE xrcfent = g_enterprise AND
                   xrcfld = g_xrcf5_d[l_ac].xrcfld
                   AND xrcfdocno = g_xrcf5_d[l_ac].xrcfdocno
                   AND xrcfseq = g_xrcf5_d[l_ac].xrcfseq
                   AND xrcfseq2 = g_xrcf5_d[l_ac].xrcfseq2
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身5新增前 name="input.body5.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xrcf5_d[g_detail_idx].xrcfld
               LET gs_keys[2] = g_xrcf5_d[g_detail_idx].xrcfdocno
               LET gs_keys[3] = g_xrcf5_d[g_detail_idx].xrcfseq
               LET gs_keys[4] = g_xrcf5_d[g_detail_idx].xrcfseq2
               CALL axrt300_06_insert_b('xrcf_t',gs_keys,"'5'")
                           
               #add-point:單身新增後5 name="input.body5.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_xrcf_d[l_ac].* TO NULL
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xrcf_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL axrt300_06_b_fill(g_wc2)
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body5.after_insert"
               
               #end add-point
               ##ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
               LET g_wc2 = g_wc2, " OR (xrcfld = '", g_xrcf5_d[l_ac].xrcfld, "' "
                                  ," AND xrcfdocno = '", g_xrcf5_d[l_ac].xrcfdocno, "' "
                                  ," AND xrcfseq = '", g_xrcf5_d[l_ac].xrcfseq, "' "
                                  ," AND xrcfseq2 = '", g_xrcf5_d[l_ac].xrcfseq2, "' "
                                  ,")"
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               LET g_xrcf5_d[l_ac].* = g_xrcf5_d_t.*
               CLOSE axrt300_06_bcl
               #add-point:單身page5取消後 name="input.body5.cancel"
               
               #end add-point
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_xrcf5_d[l_ac].* = g_xrcf5_d_t.*
            ELSE
               
               #寫入修改者/修改日期資訊(單身5)
               
               
               #add-point:單身page5修改前 name="input.body5.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL axrt300_06_xrcf_t_mask_restore('restore_mask_o')
               
               UPDATE xrcf_t SET (xrcfdocno,xrcfld,xrcfseq2,xrcfseq,xrcf008,xrcf009,xrcf021,xrcf007, 
                   xrcf101,xrcf103,xrcf104,xrcf105,xrcf106,xrcf102,xrcf111,xrcf113,xrcf114,xrcf115,xrcf116, 
                   xrcf117,xrcf022,xrcf024,xrcf025,xrcf122,xrcf123,xrcf124,xrcf125,xrcf126,xrcf127,xrcf132, 
                   xrcf133,xrcf134,xrcf135,xrcf136,xrcf137,xrcf049,xrcf023,xrcf033,xrcf026,xrcf027,xrcf028, 
                   xrcf031,xrcf032,xrcf034,xrcf035,xrcf036,xrcf037,xrcf038,xrcf039,xrcf040,xrcf041,xrcf042, 
                   xrcf043,xrcf044,xrcf045,xrcf046,xrcf047,xrcf048,xrcf001,xrcf002,xrcf010,xrcf020,xrcf029, 
                   xrcf030,xrcforga) = (g_xrcf_d[l_ac].xrcfdocno,g_xrcf_d[l_ac].xrcfld,g_xrcf_d[l_ac].xrcfseq2, 
                   g_xrcf_d[l_ac].xrcfseq,g_xrcf_d[l_ac].xrcf008,g_xrcf_d[l_ac].xrcf009,g_xrcf_d[l_ac].xrcf021, 
                   g_xrcf_d[l_ac].xrcf007,g_xrcf_d[l_ac].xrcf101,g_xrcf_d[l_ac].xrcf103,g_xrcf_d[l_ac].xrcf104, 
                   g_xrcf_d[l_ac].xrcf105,g_xrcf_d[l_ac].xrcf106,g_xrcf_d[l_ac].xrcf102,g_xrcf_d[l_ac].xrcf111, 
                   g_xrcf_d[l_ac].xrcf113,g_xrcf_d[l_ac].xrcf114,g_xrcf_d[l_ac].xrcf115,g_xrcf_d[l_ac].xrcf116, 
                   g_xrcf_d[l_ac].xrcf117,g_xrcf2_d[l_ac].xrcf022,g_xrcf2_d[l_ac].xrcf024,g_xrcf2_d[l_ac].xrcf025, 
                   g_xrcf3_d[l_ac].xrcf122,g_xrcf3_d[l_ac].xrcf123,g_xrcf3_d[l_ac].xrcf124,g_xrcf3_d[l_ac].xrcf125, 
                   g_xrcf3_d[l_ac].xrcf126,g_xrcf3_d[l_ac].xrcf127,g_xrcf3_d[l_ac].xrcf132,g_xrcf3_d[l_ac].xrcf133, 
                   g_xrcf3_d[l_ac].xrcf134,g_xrcf3_d[l_ac].xrcf135,g_xrcf3_d[l_ac].xrcf136,g_xrcf3_d[l_ac].xrcf137, 
                   g_xrcf4_d[l_ac].xrcf049,g_xrcf4_d[l_ac].xrcf023,g_xrcf4_d[l_ac].xrcf033,g_xrcf4_d[l_ac].xrcf026, 
                   g_xrcf4_d[l_ac].xrcf027,g_xrcf4_d[l_ac].xrcf028,g_xrcf4_d[l_ac].xrcf031,g_xrcf4_d[l_ac].xrcf032, 
                   g_xrcf4_d[l_ac].xrcf034,g_xrcf4_d[l_ac].xrcf035,g_xrcf4_d[l_ac].xrcf036,g_xrcf4_d[l_ac].xrcf037, 
                   g_xrcf4_d[l_ac].xrcf038,g_xrcf4_d[l_ac].xrcf039,g_xrcf4_d[l_ac].xrcf040,g_xrcf4_d[l_ac].xrcf041, 
                   g_xrcf4_d[l_ac].xrcf042,g_xrcf4_d[l_ac].xrcf043,g_xrcf4_d[l_ac].xrcf044,g_xrcf4_d[l_ac].xrcf045, 
                   g_xrcf4_d[l_ac].xrcf046,g_xrcf4_d[l_ac].xrcf047,g_xrcf4_d[l_ac].xrcf048,g_xrcf5_d[l_ac].xrcf001, 
                   g_xrcf5_d[l_ac].xrcf002,g_xrcf5_d[l_ac].xrcf010,g_xrcf5_d[l_ac].xrcf020,g_xrcf5_d[l_ac].xrcf029, 
                   g_xrcf5_d[l_ac].xrcf030,g_xrcf5_d[l_ac].xrcforga) #自訂欄位頁簽
                WHERE xrcfent = g_enterprise AND
                  xrcfld = g_xrcf5_d_t.xrcfld #項次 
                  AND xrcfdocno = g_xrcf5_d_t.xrcfdocno
                  AND xrcfseq = g_xrcf5_d_t.xrcfseq
                  AND xrcfseq2 = g_xrcf5_d_t.xrcfseq2
                  
               #add-point:單身page5修改中 name="input.body5.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xrcf_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  WHEN SQLCA.SQLCODE #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xrcf_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xrcf5_d[g_detail_idx].xrcfld
               LET gs_keys_bak[1] = g_xrcf5_d_t.xrcfld
               LET gs_keys[2] = g_xrcf5_d[g_detail_idx].xrcfdocno
               LET gs_keys_bak[2] = g_xrcf5_d_t.xrcfdocno
               LET gs_keys[3] = g_xrcf5_d[g_detail_idx].xrcfseq
               LET gs_keys_bak[3] = g_xrcf5_d_t.xrcfseq
               LET gs_keys[4] = g_xrcf5_d[g_detail_idx].xrcfseq2
               LET gs_keys_bak[4] = g_xrcf5_d_t.xrcfseq2
               CALL axrt300_06_update_b('xrcf_t',gs_keys,gs_keys_bak,"'5'")
                     #資料多語言用-增/改
                     
                     
                     #修改歷程記錄(修改)
                     LET g_log1 = util.JSON.stringify(g_xrcf5_d_t)
                     LET g_log2 = util.JSON.stringify(g_xrcf5_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL axrt300_06_xrcf_t_mask_restore('restore_mask_n')
               
               #add-point:單身page5修改後 name="input.body5.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf001
            #add-point:BEFORE FIELD xrcf001 name="input.b.page5.xrcf001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf001
            
            #add-point:AFTER FIELD xrcf001 name="input.a.page5.xrcf001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf001
            #add-point:ON CHANGE xrcf001 name="input.g.page5.xrcf001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf002
            #add-point:BEFORE FIELD xrcf002 name="input.b.page5.xrcf002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf002
            
            #add-point:AFTER FIELD xrcf002 name="input.a.page5.xrcf002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf002
            #add-point:ON CHANGE xrcf002 name="input.g.page5.xrcf002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf010
            #add-point:BEFORE FIELD xrcf010 name="input.b.page5.xrcf010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf010
            
            #add-point:AFTER FIELD xrcf010 name="input.a.page5.xrcf010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf010
            #add-point:ON CHANGE xrcf010 name="input.g.page5.xrcf010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf020
            #add-point:BEFORE FIELD xrcf020 name="input.b.page5.xrcf020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf020
            
            #add-point:AFTER FIELD xrcf020 name="input.a.page5.xrcf020"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf020
            #add-point:ON CHANGE xrcf020 name="input.g.page5.xrcf020"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf029
            #add-point:BEFORE FIELD xrcf029 name="input.b.page5.xrcf029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf029
            
            #add-point:AFTER FIELD xrcf029 name="input.a.page5.xrcf029"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf029
            #add-point:ON CHANGE xrcf029 name="input.g.page5.xrcf029"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcf030
            #add-point:BEFORE FIELD xrcf030 name="input.b.page5.xrcf030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcf030
            
            #add-point:AFTER FIELD xrcf030 name="input.a.page5.xrcf030"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcf030
            #add-point:ON CHANGE xrcf030 name="input.g.page5.xrcf030"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcforga
            #add-point:BEFORE FIELD xrcforga name="input.b.page5.xrcforga"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcforga
            
            #add-point:AFTER FIELD xrcforga name="input.a.page5.xrcforga"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcforga
            #add-point:ON CHANGE xrcforga name="input.g.page5.xrcforga"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page5.xrcf001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf001
            #add-point:ON ACTION controlp INFIELD xrcf001 name="input.c.page5.xrcf001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page5.xrcf002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf002
            #add-point:ON ACTION controlp INFIELD xrcf002 name="input.c.page5.xrcf002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page5.xrcf010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf010
            #add-point:ON ACTION controlp INFIELD xrcf010 name="input.c.page5.xrcf010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page5.xrcf020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf020
            #add-point:ON ACTION controlp INFIELD xrcf020 name="input.c.page5.xrcf020"
            
            #END add-point
 
 
         #Ctrlp:input.c.page5.xrcf029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf029
            #add-point:ON ACTION controlp INFIELD xrcf029 name="input.c.page5.xrcf029"
            
            #END add-point
 
 
         #Ctrlp:input.c.page5.xrcf030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcf030
            #add-point:ON ACTION controlp INFIELD xrcf030 name="input.c.page5.xrcf030"
            
            #END add-point
 
 
         #Ctrlp:input.c.page5.xrcforga
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcforga
            #add-point:ON ACTION controlp INFIELD xrcforga name="input.c.page5.xrcforga"
            
            #END add-point
 
 
 
 
         AFTER ROW
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_xrcf5_d[l_ac].* = g_xrcf5_d_t.*
               END IF
               CLOSE axrt300_06_bcl
               #add-point:單身after row name="input.body5.a_close"
               
               #end add-point
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
 
            CALL axrt300_06_unlock_b("xrcf_t")
            #add-point:單身after row name="input.body5.a_row"
            
            #end add-point
            
         AFTER INPUT
            #add-point:單身5input後 name="input.body5.a_input"
            
            #end add-point
         
         #複製上一次指定的單身資料至最下方
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_xrcf_d[li_reproduce_target].* = g_xrcf_d[li_reproduce].*
               LET g_xrcf2_d[li_reproduce_target].* = g_xrcf2_d[li_reproduce].*
               LET g_xrcf3_d[li_reproduce_target].* = g_xrcf3_d[li_reproduce].*
               LET g_xrcf4_d[li_reproduce_target].* = g_xrcf4_d[li_reproduce].*
               LET g_xrcf5_d[li_reproduce_target].* = g_xrcf5_d[li_reproduce].*
 
               LET g_xrcf5_d[li_reproduce_target].xrcfld = NULL
               LET g_xrcf5_d[li_reproduce_target].xrcfdocno = NULL
               LET g_xrcf5_d[li_reproduce_target].xrcfseq = NULL
               LET g_xrcf5_d[li_reproduce_target].xrcfseq2 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_xrcf5_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_xrcf5_d.getLength()+1
            END IF
      END INPUT
 
      
 
      
      #add-point:before_more_input name="input.more_input"
      
      #end add-point
      
      BEFORE DIALOG
         #CALL cl_err_collect_init()      
         IF g_temp_idx > 0 THEN
            LET l_ac = g_temp_idx
            CALL DIALOG.setCurrentRow("s_detail1",l_ac)
            LET g_temp_idx = 1
         END IF
         #LET g_curr_diag = ui.DIALOG.getCurrent()
         #add-point:before_dialog name="input.before_dialog"
         
         #end add-point
         CASE g_aw
            WHEN "s_detail1"
               NEXT FIELD xrcfdocno
            WHEN "s_detail2"
               NEXT FIELD xrcfdocno_2
            WHEN "s_detail3"
               NEXT FIELD xrcfdocno_3
            WHEN "s_detail4"
               NEXT FIELD xrcfdocno_4
            WHEN "s_detail5"
               NEXT FIELD xrcfdocno_5
 
         END CASE
   
      ON ACTION accept
         ACCEPT DIALOG
      
      ON ACTION cancel
         LET INT_FLAG = TRUE 
         CANCEL DIALOG
 
      ON ACTION controlr
         CALL cl_show_req_fields()
 
      ON ACTION controlf
         CALL cl_set_focus_form(ui.Interface.getRootNode()) 
              RETURNING g_fld_name,g_frm_name 
         CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang) 
           
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG
   
   END DIALOG 
    
   #新增後取消
   IF l_cmd = 'a' THEN
      #當取消或無輸入資料按確定時刪除對應資料
      IF INT_FLAG OR cl_null(g_xrcf_d[g_detail_idx].xrcfld) THEN
         CALL g_xrcf_d.deleteElement(g_detail_idx)
         CALL g_xrcf2_d.deleteElement(g_detail_idx)
         CALL g_xrcf3_d.deleteElement(g_detail_idx)
         CALL g_xrcf4_d.deleteElement(g_detail_idx)
         CALL g_xrcf5_d.deleteElement(g_detail_idx)
 
      END IF
   END IF
   
   #修改後取消
   IF l_cmd = 'u' AND INT_FLAG THEN
      LET g_xrcf_d[g_detail_idx].* = g_xrcf_d_t.*
   END IF
   
   #add-point:modify段修改後 name="modify.after_input"
   
   CALL axrt300_06_chk()
   #end add-point
 
   CLOSE axrt300_06_bcl
   
END FUNCTION
 
{</section>}
 
{<section id="axrt300_06.delete" >}
#+ 資料刪除
PRIVATE FUNCTION axrt300_06_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point
   DEFINE li_idx          LIKE type_t.num10
   DEFINE li_ac_t         LIKE type_t.num10
   DEFINE li_detail_tmp   LIKE type_t.num10
   DEFINE l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE l_var_keys_bak  DYNAMIC ARRAY OF STRING
   DEFINE l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE l_vars          DYNAMIC ARRAY OF STRING
   DEFINE l_fields        DYNAMIC ARRAY OF STRING
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="delete.body.before_delete"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET li_ac_t = l_ac
   
   LET li_detail_tmp = g_detail_idx
    
   #lock所有所選資料
   FOR li_idx = 1 TO g_xrcf_d.getLength()
      LET g_detail_idx = li_idx
      #已選擇的資料
      IF g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         #確定是否有被鎖定
         IF NOT axrt300_06_lock_b("xrcf_t") THEN
            #已被他人鎖定
            RETURN
         END IF
 
         #(ver:35) ---add start---
         #確定是否有刪除的權限
         #先確定該table有ownid
         IF cl_getField("xrcf_t","") THEN
            IF NOT cl_auth_chk_act_permission("delete") THEN
               #有目前權限無法刪除的資料
               RETURN
            END IF
         END IF
         #(ver:35) --- add end ---
      END IF
   END FOR
   
   #add-point:單身刪除詢問前 name="delete.body.b_delete_ask"
   
   #end add-point  
   
   #詢問是否確定刪除所選資料
   IF NOT cl_ask_del_detail() THEN
      RETURN
   END IF
   
   FOR li_idx = 1 TO g_xrcf_d.getLength()
      IF g_xrcf_d[li_idx].xrcfld IS NOT NULL
         AND g_xrcf_d[li_idx].xrcfdocno IS NOT NULL
         AND g_xrcf_d[li_idx].xrcfseq IS NOT NULL
         AND g_xrcf_d[li_idx].xrcfseq2 IS NOT NULL
 
         AND g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN 
         
         #add-point:單身刪除前 name="delete.body.b_delete"
         
         #end add-point   
         
         DELETE FROM xrcf_t
          WHERE xrcfent = g_enterprise AND 
                xrcfld = g_xrcf_d[li_idx].xrcfld
                AND xrcfdocno = g_xrcf_d[li_idx].xrcfdocno
                AND xrcfseq = g_xrcf_d[li_idx].xrcfseq
                AND xrcfseq2 = g_xrcf_d[li_idx].xrcfseq2
 
         #add-point:單身刪除中 name="delete.body.m_delete"
         
         #end add-point  
                
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xrcf_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            RETURN
         ELSE
            LET g_detail_cnt = g_detail_cnt-1
            LET l_ac = li_idx
            
 
 
 
 
 
            
 
 
 
 
 
            
 
 
 
 
 
            
 
 
 
 
 
            
 
 
 
 
 
 
            
 
 
 
 
 
            
 
 
 
 
 
            
 
 
 
 
 
            
 
 
 
 
 
            
 
 
 
 
 
 
            #add-point:單身同步刪除前(同層table) name="delete.body.a_delete"
            
            #end add-point
            LET g_detail_idx = li_idx
                           INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xrcf_d_t.xrcfld
               LET gs_keys[2] = g_xrcf_d_t.xrcfdocno
               LET gs_keys[3] = g_xrcf_d_t.xrcfseq
               LET gs_keys[4] = g_xrcf_d_t.xrcfseq2
 
            #add-point:單身同步刪除中(同層table) name="delete.body.a_delete2"
            
            #end add-point
                           CALL axrt300_06_delete_b('xrcf_t',gs_keys,"'1'")
            #add-point:單身同步刪除後(同層table) name="delete.body.a_delete3"
            
            #end add-point
            #刪除相關文件
            #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL axrt300_06_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove.func"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
            
         END IF 
      END IF 
    
   END FOR
   
   LET g_detail_idx = li_detail_tmp
            
   #add-point:單身刪除後 name="delete.after"
   
   #end add-point  
   
   LET l_ac = li_ac_t
   
   #刷新資料
   CALL axrt300_06_b_fill(g_wc2)
            
END FUNCTION
 
{</section>}
 
{<section id="axrt300_06.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axrt300_06_b_fill(p_wc2)              #BODY FILL UP
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2            STRING
   DEFINE ls_owndept_list  STRING  #(ver:35) add
   DEFINE ls_ownuser_list  STRING  #(ver:35) add
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_success      LIKE type_t.chr1
   #end add-point
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   IF cl_null(p_wc2) THEN
      LET p_wc2 = " 1=1"
   END IF
   
   #add-point:b_fill段sql之前 name="b_fill.sql_before"
   LET p_wc2 = p_wc2," AND xrcfdocno = '",g_xrcadocno,"' AND xrcfld = '",g_xrcald,"'"
   #end add-point
 
   LET g_sql = "SELECT  DISTINCT t0.xrcfdocno,t0.xrcfld,t0.xrcfseq2,t0.xrcfseq,t0.xrcf008,t0.xrcf009, 
       t0.xrcf021,t0.xrcf007,t0.xrcf101,t0.xrcf103,t0.xrcf104,t0.xrcf105,t0.xrcf106,t0.xrcf102,t0.xrcf111, 
       t0.xrcf113,t0.xrcf114,t0.xrcf115,t0.xrcf116,t0.xrcf117,t0.xrcfdocno,t0.xrcfld,t0.xrcfseq,t0.xrcfseq2, 
       t0.xrcf022,t0.xrcf024,t0.xrcf025,t0.xrcfdocno,t0.xrcfld,t0.xrcfseq,t0.xrcfseq2,t0.xrcf105,t0.xrcf102, 
       t0.xrcf115,t0.xrcf122,t0.xrcf123,t0.xrcf124,t0.xrcf125,t0.xrcf126,t0.xrcf127,t0.xrcf132,t0.xrcf133, 
       t0.xrcf134,t0.xrcf135,t0.xrcf136,t0.xrcf137,t0.xrcfdocno,t0.xrcfld,t0.xrcfseq,t0.xrcfseq2,t0.xrcf049, 
       t0.xrcf021,t0.xrcf023,t0.xrcf033,t0.xrcf026,t0.xrcf027,t0.xrcf028,t0.xrcf031,t0.xrcf032,t0.xrcf034, 
       t0.xrcf035,t0.xrcf036,t0.xrcf037,t0.xrcf038,t0.xrcf039,t0.xrcf040,t0.xrcf041,t0.xrcf042,t0.xrcf043, 
       t0.xrcf044,t0.xrcf045,t0.xrcf046,t0.xrcf047,t0.xrcf048,t0.xrcfdocno,t0.xrcfld,t0.xrcfseq,t0.xrcfseq2, 
       t0.xrcf001,t0.xrcf002,t0.xrcf010,t0.xrcf020,t0.xrcf029,t0.xrcf030,t0.xrcforga  FROM xrcf_t t0", 
 
               "",
               
               " WHERE t0.xrcfent= ?  AND  1=1 AND (", p_wc2, ") "
 
   #(ver:35) ---add start---
   
   #(ver:35) --- add end ---
 
   #add-point:b_fill段sql wc name="b_fill.sql_wc"
    IF 1 = 0 THEN
   #end add-point
   LET g_sql = g_sql, cl_sql_add_filter("xrcf_t"),
                      " ORDER BY t0.xrcfld,t0.xrcfdocno,t0.xrcfseq,t0.xrcfseq2"
   
   #add-point:b_fill段sql之後 name="b_fill.sql_after"
   ELSE
      LET g_sql = g_sql, cl_sql_add_filter("xrcf_t"),
                      " ORDER BY t0.xrcfld,t0.xrcfdocno,CASE WHEN t0.xrcfseq = 0 THEN 1 ELSE 0 END ASC,t0.xrcfseq,t0.xrcfseq2"
   END IF
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"xrcf_t")            #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE axrt300_06_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR axrt300_06_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_xrcf_d.clear()
   CALL g_xrcf2_d.clear()   
   CALL g_xrcf3_d.clear()   
   CALL g_xrcf4_d.clear()   
   CALL g_xrcf5_d.clear()   
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_xrcf_d[l_ac].xrcfdocno,g_xrcf_d[l_ac].xrcfld,g_xrcf_d[l_ac].xrcfseq2,g_xrcf_d[l_ac].xrcfseq, 
       g_xrcf_d[l_ac].xrcf008,g_xrcf_d[l_ac].xrcf009,g_xrcf_d[l_ac].xrcf021,g_xrcf_d[l_ac].xrcf007,g_xrcf_d[l_ac].xrcf101, 
       g_xrcf_d[l_ac].xrcf103,g_xrcf_d[l_ac].xrcf104,g_xrcf_d[l_ac].xrcf105,g_xrcf_d[l_ac].xrcf106,g_xrcf_d[l_ac].xrcf102, 
       g_xrcf_d[l_ac].xrcf111,g_xrcf_d[l_ac].xrcf113,g_xrcf_d[l_ac].xrcf114,g_xrcf_d[l_ac].xrcf115,g_xrcf_d[l_ac].xrcf116, 
       g_xrcf_d[l_ac].xrcf117,g_xrcf2_d[l_ac].xrcfdocno,g_xrcf2_d[l_ac].xrcfld,g_xrcf2_d[l_ac].xrcfseq, 
       g_xrcf2_d[l_ac].xrcfseq2,g_xrcf2_d[l_ac].xrcf022,g_xrcf2_d[l_ac].xrcf024,g_xrcf2_d[l_ac].xrcf025, 
       g_xrcf3_d[l_ac].xrcfdocno,g_xrcf3_d[l_ac].xrcfld,g_xrcf3_d[l_ac].xrcfseq,g_xrcf3_d[l_ac].xrcfseq2, 
       g_xrcf3_d[l_ac].xrcf105,g_xrcf3_d[l_ac].xrcf102,g_xrcf3_d[l_ac].xrcf115,g_xrcf3_d[l_ac].xrcf122, 
       g_xrcf3_d[l_ac].xrcf123,g_xrcf3_d[l_ac].xrcf124,g_xrcf3_d[l_ac].xrcf125,g_xrcf3_d[l_ac].xrcf126, 
       g_xrcf3_d[l_ac].xrcf127,g_xrcf3_d[l_ac].xrcf132,g_xrcf3_d[l_ac].xrcf133,g_xrcf3_d[l_ac].xrcf134, 
       g_xrcf3_d[l_ac].xrcf135,g_xrcf3_d[l_ac].xrcf136,g_xrcf3_d[l_ac].xrcf137,g_xrcf4_d[l_ac].xrcfdocno, 
       g_xrcf4_d[l_ac].xrcfld,g_xrcf4_d[l_ac].xrcfseq,g_xrcf4_d[l_ac].xrcfseq2,g_xrcf4_d[l_ac].xrcf049, 
       g_xrcf4_d[l_ac].xrcf021,g_xrcf4_d[l_ac].xrcf023,g_xrcf4_d[l_ac].xrcf033,g_xrcf4_d[l_ac].xrcf026, 
       g_xrcf4_d[l_ac].xrcf027,g_xrcf4_d[l_ac].xrcf028,g_xrcf4_d[l_ac].xrcf031,g_xrcf4_d[l_ac].xrcf032, 
       g_xrcf4_d[l_ac].xrcf034,g_xrcf4_d[l_ac].xrcf035,g_xrcf4_d[l_ac].xrcf036,g_xrcf4_d[l_ac].xrcf037, 
       g_xrcf4_d[l_ac].xrcf038,g_xrcf4_d[l_ac].xrcf039,g_xrcf4_d[l_ac].xrcf040,g_xrcf4_d[l_ac].xrcf041, 
       g_xrcf4_d[l_ac].xrcf042,g_xrcf4_d[l_ac].xrcf043,g_xrcf4_d[l_ac].xrcf044,g_xrcf4_d[l_ac].xrcf045, 
       g_xrcf4_d[l_ac].xrcf046,g_xrcf4_d[l_ac].xrcf047,g_xrcf4_d[l_ac].xrcf048,g_xrcf5_d[l_ac].xrcfdocno, 
       g_xrcf5_d[l_ac].xrcfld,g_xrcf5_d[l_ac].xrcfseq,g_xrcf5_d[l_ac].xrcfseq2,g_xrcf5_d[l_ac].xrcf001, 
       g_xrcf5_d[l_ac].xrcf002,g_xrcf5_d[l_ac].xrcf010,g_xrcf5_d[l_ac].xrcf020,g_xrcf5_d[l_ac].xrcf029, 
       g_xrcf5_d[l_ac].xrcf030,g_xrcf5_d[l_ac].xrcforga
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH b_fill_curs:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
  
      #add-point:b_fill段資料填充 name="b_fill.fill"
      LET g_xrcf3_d[l_ac].xrcf122_desc = g_glaa.glaa016,'/',g_xrcf3_d[l_ac].xrcf122
      LET g_xrcf3_d[l_ac].xrcf132_desc = g_glaa.glaa020,'/',g_xrcf3_d[l_ac].xrcf132
      SELECT xrca001 INTO g_xrcf_d[l_ac].xrca001_desc FROM xrca_t WHERE xrcaent = g_enterprise
         AND xrcadocno = g_xrcf_d[l_ac].xrcf008 AND xrcald = g_xrcf_d[l_ac].xrcfld

      CALL s_axrt300_xrca_ref('xrca035',g_xrcf_d[l_ac].xrcf021,g_glaa.glaa004,'') RETURNING l_success,g_xrcf_d[l_ac].xrcf021_1_desc
      LET g_xrcf4_d[l_ac].xrcf021_desc = g_xrcf_d[l_ac].xrcf021_1_desc
      #科目編號
      LET g_xrcf4_d[l_ac].xrcf021_desc = g_xrcf4_d[l_ac].xrcf021,' ',g_xrcf4_d[l_ac].xrcf021_desc
      #160816-00014#1 Add  ---(S)---
      CALL s_axrt300_xrca_ref('xrca035',g_xrcf4_d[l_ac].xrcf023,g_glaa.glaa004,'') RETURNING l_success,g_xrcf4_d[l_ac].xrcf023_desc
      LET g_xrcf4_d[l_ac].xrcf023_desc = g_xrcf4_d[l_ac].xrcf023,' ',g_xrcf4_d[l_ac].xrcf023_desc
      #160816-00014#1 Add  ---(E)---
      #業務人員
      CALL s_axrt300_xrca_ref('xrca014',g_xrcf4_d[l_ac].xrcf033,'','') RETURNING l_success,g_xrcf4_d[l_ac].xrcf033_desc
      LET g_xrcf4_d[l_ac].xrcf033_desc = g_xrcf4_d[l_ac].xrcf033,' ',g_xrcf4_d[l_ac].xrcf033_desc
      #業務部門
      CALL s_axrt300_account_desc('xrcb010',g_xrcf4_d[l_ac].xrcf026,'') RETURNING l_success,g_xrcf4_d[l_ac].xrcf026_desc
      #責任中心
      CALL s_axrt300_account_desc('xrcb011',g_xrcf4_d[l_ac].xrcf027,'') RETURNING l_success,g_xrcf4_d[l_ac].xrcf027_desc
      #區域
      CALL s_axrt300_account_desc('xrcb024',g_xrcf4_d[l_ac].xrcf028,'') RETURNING l_success,g_xrcf4_d[l_ac].xrcf028_desc
      #客群
      CALL s_axrt300_account_desc('xrcb036',g_xrcf4_d[l_ac].xrcf031,'') RETURNING l_success,g_xrcf4_d[l_ac].xrcf031_desc
      #產品類別
      CALL s_axrt300_account_desc('xrcb012',g_xrcf4_d[l_ac].xrcf032,'') RETURNING l_success,g_xrcf4_d[l_ac].xrcf032_desc
      #專案編號
      CALL s_desc_get_project_desc(g_xrcf4_d[l_ac].xrcf034) RETURNING g_xrcf4_d[l_ac].xrcf034_desc
      #WBS編號
      CALL s_desc_get_wbs_desc(g_xrcf4_d[l_ac].xrcf034,g_xrcf4_d[l_ac].xrcf035) RETURNING g_xrcf4_d[l_ac].xrcf035_desc
      #經營方式
      #渠道
      CALL s_axrt300_account_desc('xrcb034',g_xrcf4_d[l_ac].xrcf037,'') RETURNING l_success,g_xrcf4_d[l_ac].xrcf037_desc
      #品牌
      CALL s_axrt300_account_desc('xrcb035',g_xrcf4_d[l_ac].xrcf038,'') RETURNING l_success,g_xrcf4_d[l_ac].xrcf038_desc

      #end add-point
      
      CALL axrt300_06_detail_show()      
 
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = l_ac
            LET g_errparam.code   = 9035 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
         END IF
         EXIT FOREACH
      END IF
 
      LET l_ac = l_ac + 1
      
   END FOREACH
 
   LET g_error_show = 0
   
 
   
   CALL g_xrcf_d.deleteElement(g_xrcf_d.getLength())   
   CALL g_xrcf2_d.deleteElement(g_xrcf2_d.getLength())
   CALL g_xrcf3_d.deleteElement(g_xrcf3_d.getLength())
   CALL g_xrcf4_d.deleteElement(g_xrcf4_d.getLength())
   CALL g_xrcf5_d.deleteElement(g_xrcf5_d.getLength())
 
   
   #將key欄位填到每個page
   FOR l_ac = 1 TO g_xrcf_d.getLength()
      LET g_xrcf2_d[l_ac].xrcfld = g_xrcf_d[l_ac].xrcfld 
      LET g_xrcf2_d[l_ac].xrcfdocno = g_xrcf_d[l_ac].xrcfdocno 
      LET g_xrcf2_d[l_ac].xrcfseq = g_xrcf_d[l_ac].xrcfseq 
      LET g_xrcf2_d[l_ac].xrcfseq2 = g_xrcf_d[l_ac].xrcfseq2 
      LET g_xrcf3_d[l_ac].xrcfld = g_xrcf_d[l_ac].xrcfld 
      LET g_xrcf3_d[l_ac].xrcfdocno = g_xrcf_d[l_ac].xrcfdocno 
      LET g_xrcf3_d[l_ac].xrcfseq = g_xrcf_d[l_ac].xrcfseq 
      LET g_xrcf3_d[l_ac].xrcfseq2 = g_xrcf_d[l_ac].xrcfseq2 
      LET g_xrcf4_d[l_ac].xrcfld = g_xrcf_d[l_ac].xrcfld 
      LET g_xrcf4_d[l_ac].xrcfdocno = g_xrcf_d[l_ac].xrcfdocno 
      LET g_xrcf4_d[l_ac].xrcfseq = g_xrcf_d[l_ac].xrcfseq 
      LET g_xrcf4_d[l_ac].xrcfseq2 = g_xrcf_d[l_ac].xrcfseq2 
      LET g_xrcf5_d[l_ac].xrcfld = g_xrcf_d[l_ac].xrcfld 
      LET g_xrcf5_d[l_ac].xrcfdocno = g_xrcf_d[l_ac].xrcfdocno 
      LET g_xrcf5_d[l_ac].xrcfseq = g_xrcf_d[l_ac].xrcfseq 
      LET g_xrcf5_d[l_ac].xrcfseq2 = g_xrcf_d[l_ac].xrcfseq2 
 
      #add-point:b_fill段key值相關欄位 name="b_fill.keys.fill"
      
      #end add-point
   END FOR
   
   IF g_cnt > g_xrcf_d.getLength() THEN
      LET l_ac = g_xrcf_d.getLength()
   ELSE
      LET l_ac = g_cnt
   END IF
   LET g_cnt = l_ac
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_xrcf_d.getLength()
      LET g_xrcf_d_mask_o[l_ac].* =  g_xrcf_d[l_ac].*
      CALL axrt300_06_xrcf_t_mask()
      LET g_xrcf_d_mask_n[l_ac].* =  g_xrcf_d[l_ac].*
   END FOR
   
   LET g_xrcf2_d_mask_o.* =  g_xrcf2_d.*
   FOR l_ac = 1 TO g_xrcf2_d.getLength()
      LET g_xrcf2_d_mask_o[l_ac].* =  g_xrcf2_d[l_ac].*
      CALL axrt300_06_xrcf_t_mask()
      LET g_xrcf2_d_mask_n[l_ac].* =  g_xrcf2_d[l_ac].*
   END FOR
   LET g_xrcf3_d_mask_o.* =  g_xrcf3_d.*
   FOR l_ac = 1 TO g_xrcf3_d.getLength()
      LET g_xrcf3_d_mask_o[l_ac].* =  g_xrcf3_d[l_ac].*
      CALL axrt300_06_xrcf_t_mask()
      LET g_xrcf3_d_mask_n[l_ac].* =  g_xrcf3_d[l_ac].*
   END FOR
   LET g_xrcf4_d_mask_o.* =  g_xrcf4_d.*
   FOR l_ac = 1 TO g_xrcf4_d.getLength()
      LET g_xrcf4_d_mask_o[l_ac].* =  g_xrcf4_d[l_ac].*
      CALL axrt300_06_xrcf_t_mask()
      LET g_xrcf4_d_mask_n[l_ac].* =  g_xrcf4_d[l_ac].*
   END FOR
   LET g_xrcf5_d_mask_o.* =  g_xrcf5_d.*
   FOR l_ac = 1 TO g_xrcf5_d.getLength()
      LET g_xrcf5_d_mask_o[l_ac].* =  g_xrcf5_d[l_ac].*
      CALL axrt300_06_xrcf_t_mask()
      LET g_xrcf5_d_mask_n[l_ac].* =  g_xrcf5_d[l_ac].*
   END FOR
 
   
   LET l_ac = g_cnt
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
   
   ERROR "" 
 
   LET g_detail_cnt = g_xrcf_d.getLength()
   DISPLAY g_detail_idx TO FORMONLY.idx
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   
   CLOSE b_fill_curs
   FREE axrt300_06_pb
   
END FUNCTION
 
{</section>}
 
{<section id="axrt300_06.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION axrt300_06_detail_show()
   #add-point:detail_show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_show.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="detail_show.before"
   #161128-00061#4---mdofiy--begin---------
   #SELECT * INTO g_glad.* 
    SELECT gladent,gladownid,gladowndp,gladcrtid,gladcrtdp,gladcrtdt,gladmodid,gladmoddt,
           gladstus,gladld,glad001,glad002,glad003,glad004,glad005,glad006,glad007,glad008,
           glad009,glad010,glad011,glad012,glad013,glad014,glad015,glad016,glad017,glad0171,
           glad0172,glad018,glad0181,glad0182,glad019,glad0191,glad0192,glad020,glad0201,
           glad0202,glad021,glad0211,glad0212,glad022,glad0221,glad0222,glad023,glad0231,
           glad0232,glad024,glad0241,glad0242,glad025,glad0251,glad0252,glad026,glad0261,
           glad0262,glad027,glad030,glad031,glad032,glad033,glad034,glad035,glad036 INTO g_glad.* 
   #161128-00061#4---mdofiy--end---------
   FROM glad_t WHERE gladent = g_enterprise
      AND gladld = g_xrcald AND glad001 = g_xrcf4_d[l_ac].xrcf021
   #end add-point
   
   
   
   #帶出公用欄位reference值page1
   
    
   #帶出公用欄位reference值page2
   
   #帶出公用欄位reference值page3
   
   #帶出公用欄位reference值page4
   
   #帶出公用欄位reference值page5
   
 
   
   #讀入ref值
   #add-point:show段單身reference name="detail_show.reference"
   
   #end add-point
   
   #add-point:show段單身reference name="detail_show.body2.reference"
   
   #end add-point
   #add-point:show段單身reference name="detail_show.body3.reference"
   
   #end add-point
   #add-point:show段單身reference name="detail_show.body4.reference"
   
   #end add-point
   #add-point:show段單身reference name="detail_show.body5.reference"
   
   #end add-point
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axrt300_06.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION axrt300_06_set_entry_b(p_cmd)                                                  
   #add-point:set_entry_b段define(客製用) name="set_entry_b.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1         
   #add-point:set_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   
   #end add-point
 
   IF p_cmd = "a" THEN
      CALL cl_set_comp_entry("",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry_b段欄位控制 name="set_entry_b.field_control"
      
      #end add-point 
   END IF
   
   #add-point:set_entry_b段control name="set_entry_b.set_entry_b"
   CALL cl_set_comp_entry('xrcf103,xrcf105,xrcf113,xrcf115,xrcf123,xrcf125,xrcf133,xrcf135',TRUE)
   #end add-point                                                                   
                                                                                
END FUNCTION                                                                 
 
{</section>}
 
{<section id="axrt300_06.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION axrt300_06_set_no_entry_b(p_cmd)                                               
   #add-point:set_no_entry_b段define(客製用) name="set_no_entry_b.define_customerization"
   
   #end add-point   
   DEFINE p_cmd   LIKE type_t.chr1           
   #add-point:set_no_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   DEFINE l_xrcb020         LIKE xrcb_t.xrcb020
   DEFINE l_xrcbsite        LIKE xrcb_t.xrcbsite
   DEFINE l_success         LIKE type_t.num5
   DEFINE l_oodbl004        LIKE oodbL_t.oodbl004
   DEFINE l_oodb005         LIKE oodb_t.oodb005
   DEFINE l_oodb006         LIKE oodb_t.oodb006
   DEFINE l_oodb011         LIKE oodb_t.oodb011

   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry_b段欄位控制 name="set_no_entry_b.field_control"
      
      #end add-point 
   END IF
   
   #add-point:set_no_entry_b段control name="set_no_entry_b.set_no_entry_b"
  #SELECT xrcasite INTO l_xrcbsite FROM xrca_t WHERE xrcaent = g_enterprise
  #   AND xrcadocno = g_xrcb_d[l_ac_d].xrcbdocno AND xrcald = g_xrcald
  #SELECT xrcb020 INTO l_xrcb020 FROM xrcb_t WHERE xrcbent = g_enterprise
  #   AND xrcbdocno = g_xrcb_d[l_ac_d].xrcbdocno AND xrcbseq = g_xrcb_d[l_ac_d].xrcbseq AND xrcbld = g_xrcald
  #CALL s_tax_chk(l_xrcbsite,l_xrcb020) RETURNING l_success,l_oodbl004,l_oodb005,l_oodb006,l_oodb011
   IF l_oodb005 = 'Y' THEN
      CALL cl_set_comp_entry('xrcf103,xrcf113,xrcf123,xrcf133',FALSE)
   ELSE
      CALL cl_set_comp_entry('xrcf105,xrcf115,xrcf125,xrcf135',FALSE)
   END IF

   #end add-point       
                                                                                
END FUNCTION
 
{</section>}
 
{<section id="axrt300_06.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION axrt300_06_default_search()
   #add-point:default_search段define(客製用) name="default_search.define_customerization"
   
   #end add-point
   DEFINE li_idx  LIKE type_t.num10
   DEFINE li_cnt  LIKE type_t.num10
   DEFINE ls_wc   STRING
   #add-point:default_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
 
   #end add-point  
   
   #add-point:Function前置處理  name="default_search.before"
 
   #end add-point  
   
   IF NOT cl_null(g_argv[01]) THEN
      LET ls_wc = ls_wc, " xrcfld = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " xrcfdocno = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " xrcfseq = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET ls_wc = ls_wc, " xrcfseq2 = '", g_argv[04], "' AND "
   END IF
 
   
   #add-point:default_search段after sql name="default_search.after_sql"
   
   #end add-point  
   
   IF NOT cl_null(ls_wc) THEN
      LET ls_wc = ls_wc.subString(1,ls_wc.getLength()-5)
      LET g_wc2 = ls_wc
   ELSE
      LET g_wc2 = " 1=1"
      #預設查詢條件
      LET g_wc2 = cl_qbe_get_default_qryplan()
      IF cl_null(g_wc2) THEN
         LET g_wc2 = " 1=1"
      END IF
   END IF
 
   #add-point:default_search段結束前 name="default_search.after"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="axrt300_06.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION axrt300_06_delete_b(ps_table,ps_keys_bak,ps_page)
   #add-point:delete_b段define(客製用) name="delete_b.define_customerization"
   
   #end add-point
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE li_idx      LIKE type_t.num10
   #add-point:delete_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete_b.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="delete_b.pre_function"
   
   #end add-point
   
   #判斷是否是同一群組的table
   LET ls_group = "xrcf_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      IF ps_table <> 'xrcf_t' THEN
         #add-point:delete_b段刪除前 name="delete_b.b_delete"
         
         #end add-point     
         
         DELETE FROM xrcf_t
          WHERE xrcfent = g_enterprise AND
            xrcfld = ps_keys_bak[1] AND xrcfdocno = ps_keys_bak[2] AND xrcfseq = ps_keys_bak[3] AND xrcfseq2 = ps_keys_bak[4]
         
         #add-point:delete_b段刪除中 name="delete_b.m_delete"
         
         #end add-point  
            
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = ":",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.popup = FALSE 
            CALL cl_err()
         END IF
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_xrcf_d.deleteElement(li_idx) 
      END IF 
      IF ps_page <> "'2'" THEN 
         CALL g_xrcf2_d.deleteElement(li_idx) 
      END IF 
      IF ps_page <> "'3'" THEN 
         CALL g_xrcf3_d.deleteElement(li_idx) 
      END IF 
      IF ps_page <> "'4'" THEN 
         CALL g_xrcf4_d.deleteElement(li_idx) 
      END IF 
      IF ps_page <> "'5'" THEN 
         CALL g_xrcf5_d.deleteElement(li_idx) 
      END IF 
 
      
      #add-point:delete_b段刪除後 name="delete_b.a_delete"
      
      #end add-point
      
      RETURN
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="axrt300_06.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION axrt300_06_insert_b(ps_table,ps_keys,ps_page)
   #add-point:insert_b段define(客製用) name="insert_b.define_customerization"
   
   #end add-point
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   #add-point:insert_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert_b.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="insert_b.pre_function"
   
   #end add-point
   
   #判斷是否是同一群組的table
   LET ls_group = "xrcf_t,"
   #IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      
      #add-point:insert_b段新增前 name="insert_b.b_insert"
      
      #end add-point    
      INSERT INTO xrcf_t
                  (xrcfent,
                   xrcfld,xrcfdocno,xrcfseq,xrcfseq2
                   ,xrcf008,xrcf009,xrcf021,xrcf007,xrcf101,xrcf103,xrcf104,xrcf105,xrcf106,xrcf102,xrcf111,xrcf113,xrcf114,xrcf115,xrcf116,xrcf117,xrcf022,xrcf024,xrcf025,xrcf105,xrcf102,xrcf115,xrcf122,xrcf123,xrcf124,xrcf125,xrcf126,xrcf127,xrcf132,xrcf133,xrcf134,xrcf135,xrcf136,xrcf137,xrcf049,xrcf021,xrcf023,xrcf033,xrcf026,xrcf027,xrcf028,xrcf031,xrcf032,xrcf034,xrcf035,xrcf036,xrcf037,xrcf038,xrcf039,xrcf040,xrcf041,xrcf042,xrcf043,xrcf044,xrcf045,xrcf046,xrcf047,xrcf048,xrcf001,xrcf002,xrcf010,xrcf020,xrcf029,xrcf030,xrcforga) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
                   ,g_xrcf_d[l_ac].xrcf008,g_xrcf_d[l_ac].xrcf009,g_xrcf_d[l_ac].xrcf021,g_xrcf_d[l_ac].xrcf007, 
                       g_xrcf_d[l_ac].xrcf101,g_xrcf_d[l_ac].xrcf103,g_xrcf_d[l_ac].xrcf104,g_xrcf_d[l_ac].xrcf105, 
                       g_xrcf_d[l_ac].xrcf106,g_xrcf_d[l_ac].xrcf102,g_xrcf_d[l_ac].xrcf111,g_xrcf_d[l_ac].xrcf113, 
                       g_xrcf_d[l_ac].xrcf114,g_xrcf_d[l_ac].xrcf115,g_xrcf_d[l_ac].xrcf116,g_xrcf_d[l_ac].xrcf117, 
                       g_xrcf2_d[l_ac].xrcf022,g_xrcf2_d[l_ac].xrcf024,g_xrcf2_d[l_ac].xrcf025,g_xrcf_d[l_ac].xrcf105, 
                       g_xrcf_d[l_ac].xrcf102,g_xrcf_d[l_ac].xrcf115,g_xrcf3_d[l_ac].xrcf122,g_xrcf3_d[l_ac].xrcf123, 
                       g_xrcf3_d[l_ac].xrcf124,g_xrcf3_d[l_ac].xrcf125,g_xrcf3_d[l_ac].xrcf126,g_xrcf3_d[l_ac].xrcf127, 
                       g_xrcf3_d[l_ac].xrcf132,g_xrcf3_d[l_ac].xrcf133,g_xrcf3_d[l_ac].xrcf134,g_xrcf3_d[l_ac].xrcf135, 
                       g_xrcf3_d[l_ac].xrcf136,g_xrcf3_d[l_ac].xrcf137,g_xrcf4_d[l_ac].xrcf049,g_xrcf_d[l_ac].xrcf021, 
                       g_xrcf4_d[l_ac].xrcf023,g_xrcf4_d[l_ac].xrcf033,g_xrcf4_d[l_ac].xrcf026,g_xrcf4_d[l_ac].xrcf027, 
                       g_xrcf4_d[l_ac].xrcf028,g_xrcf4_d[l_ac].xrcf031,g_xrcf4_d[l_ac].xrcf032,g_xrcf4_d[l_ac].xrcf034, 
                       g_xrcf4_d[l_ac].xrcf035,g_xrcf4_d[l_ac].xrcf036,g_xrcf4_d[l_ac].xrcf037,g_xrcf4_d[l_ac].xrcf038, 
                       g_xrcf4_d[l_ac].xrcf039,g_xrcf4_d[l_ac].xrcf040,g_xrcf4_d[l_ac].xrcf041,g_xrcf4_d[l_ac].xrcf042, 
                       g_xrcf4_d[l_ac].xrcf043,g_xrcf4_d[l_ac].xrcf044,g_xrcf4_d[l_ac].xrcf045,g_xrcf4_d[l_ac].xrcf046, 
                       g_xrcf4_d[l_ac].xrcf047,g_xrcf4_d[l_ac].xrcf048,g_xrcf5_d[l_ac].xrcf001,g_xrcf5_d[l_ac].xrcf002, 
                       g_xrcf5_d[l_ac].xrcf010,g_xrcf5_d[l_ac].xrcf020,g_xrcf5_d[l_ac].xrcf029,g_xrcf5_d[l_ac].xrcf030, 
                       g_xrcf5_d[l_ac].xrcforga)
      #add-point:insert_b段新增中 name="insert_b.m_insert"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xrcf_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      #add-point:insert_b段新增後 name="insert_b.a_insert"
      
      #end add-point    
   #END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="axrt300_06.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION axrt300_06_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
   #add-point:update_b段define(客製用) name="update_b.define_customerization"
   
   #end add-point
   DEFINE ps_page          STRING
   DEFINE ps_table         STRING
   DEFINE ps_keys          DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_keys_bak      DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group         STRING
   DEFINE li_idx           LIKE type_t.num10
   DEFINE lb_chk           BOOLEAN
   DEFINE l_new_key        DYNAMIC ARRAY OF STRING
   DEFINE l_old_key        DYNAMIC ARRAY OF STRING
   DEFINE l_field_key      DYNAMIC ARRAY OF STRING
   #add-point:update_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="update_b.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="update_b.pre_function"
   
   #end add-point
   
   #比對新舊值, 判斷key是否有改變
   LET lb_chk = TRUE
   FOR li_idx = 1 TO ps_keys.getLength()
      IF ps_keys[li_idx] <> ps_keys_bak[li_idx] THEN
         LET lb_chk = FALSE
         EXIT FOR
      END IF
   END FOR
   
   #若key無變動, 不需要做處理
   IF lb_chk THEN
      RETURN
   END IF
    
   #若key有變動, 則連動其他table的資料   
   #判斷是否是同一群組的table
   LET ls_group = "xrcf_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "xrcf_t" THEN
      #add-point:update_b段修改前 name="update_b.b_update"
      
      #end add-point     
      UPDATE xrcf_t 
         SET (xrcfld,xrcfdocno,xrcfseq,xrcfseq2
              ,xrcf008,xrcf009,xrcf021,xrcf007,xrcf101,xrcf103,xrcf104,xrcf105,xrcf106,xrcf102,xrcf111,xrcf113,xrcf114,xrcf115,xrcf116,xrcf117,xrcf022,xrcf024,xrcf025,xrcf105,xrcf102,xrcf115,xrcf122,xrcf123,xrcf124,xrcf125,xrcf126,xrcf127,xrcf132,xrcf133,xrcf134,xrcf135,xrcf136,xrcf137,xrcf049,xrcf021,xrcf023,xrcf033,xrcf026,xrcf027,xrcf028,xrcf031,xrcf032,xrcf034,xrcf035,xrcf036,xrcf037,xrcf038,xrcf039,xrcf040,xrcf041,xrcf042,xrcf043,xrcf044,xrcf045,xrcf046,xrcf047,xrcf048,xrcf001,xrcf002,xrcf010,xrcf020,xrcf029,xrcf030,xrcforga) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
              ,g_xrcf_d[l_ac].xrcf008,g_xrcf_d[l_ac].xrcf009,g_xrcf_d[l_ac].xrcf021,g_xrcf_d[l_ac].xrcf007, 
                  g_xrcf_d[l_ac].xrcf101,g_xrcf_d[l_ac].xrcf103,g_xrcf_d[l_ac].xrcf104,g_xrcf_d[l_ac].xrcf105, 
                  g_xrcf_d[l_ac].xrcf106,g_xrcf_d[l_ac].xrcf102,g_xrcf_d[l_ac].xrcf111,g_xrcf_d[l_ac].xrcf113, 
                  g_xrcf_d[l_ac].xrcf114,g_xrcf_d[l_ac].xrcf115,g_xrcf_d[l_ac].xrcf116,g_xrcf_d[l_ac].xrcf117, 
                  g_xrcf2_d[l_ac].xrcf022,g_xrcf2_d[l_ac].xrcf024,g_xrcf2_d[l_ac].xrcf025,g_xrcf_d[l_ac].xrcf105, 
                  g_xrcf_d[l_ac].xrcf102,g_xrcf_d[l_ac].xrcf115,g_xrcf3_d[l_ac].xrcf122,g_xrcf3_d[l_ac].xrcf123, 
                  g_xrcf3_d[l_ac].xrcf124,g_xrcf3_d[l_ac].xrcf125,g_xrcf3_d[l_ac].xrcf126,g_xrcf3_d[l_ac].xrcf127, 
                  g_xrcf3_d[l_ac].xrcf132,g_xrcf3_d[l_ac].xrcf133,g_xrcf3_d[l_ac].xrcf134,g_xrcf3_d[l_ac].xrcf135, 
                  g_xrcf3_d[l_ac].xrcf136,g_xrcf3_d[l_ac].xrcf137,g_xrcf4_d[l_ac].xrcf049,g_xrcf_d[l_ac].xrcf021, 
                  g_xrcf4_d[l_ac].xrcf023,g_xrcf4_d[l_ac].xrcf033,g_xrcf4_d[l_ac].xrcf026,g_xrcf4_d[l_ac].xrcf027, 
                  g_xrcf4_d[l_ac].xrcf028,g_xrcf4_d[l_ac].xrcf031,g_xrcf4_d[l_ac].xrcf032,g_xrcf4_d[l_ac].xrcf034, 
                  g_xrcf4_d[l_ac].xrcf035,g_xrcf4_d[l_ac].xrcf036,g_xrcf4_d[l_ac].xrcf037,g_xrcf4_d[l_ac].xrcf038, 
                  g_xrcf4_d[l_ac].xrcf039,g_xrcf4_d[l_ac].xrcf040,g_xrcf4_d[l_ac].xrcf041,g_xrcf4_d[l_ac].xrcf042, 
                  g_xrcf4_d[l_ac].xrcf043,g_xrcf4_d[l_ac].xrcf044,g_xrcf4_d[l_ac].xrcf045,g_xrcf4_d[l_ac].xrcf046, 
                  g_xrcf4_d[l_ac].xrcf047,g_xrcf4_d[l_ac].xrcf048,g_xrcf5_d[l_ac].xrcf001,g_xrcf5_d[l_ac].xrcf002, 
                  g_xrcf5_d[l_ac].xrcf010,g_xrcf5_d[l_ac].xrcf020,g_xrcf5_d[l_ac].xrcf029,g_xrcf5_d[l_ac].xrcf030, 
                  g_xrcf5_d[l_ac].xrcforga) 
         WHERE xrcfent = g_enterprise AND xrcfld = ps_keys_bak[1] AND xrcfdocno = ps_keys_bak[2] AND xrcfseq = ps_keys_bak[3] AND xrcfseq2 = ps_keys_bak[4]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point 
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xrcf_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xrcf_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.popup = TRUE 
            CALL cl_err()
         OTHERWISE
            
      END CASE
      #add-point:update_b段修改後 name="update_b.a_update"
      
      #end add-point 
      RETURN
   END IF
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="axrt300_06.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION axrt300_06_lock_b(ps_table)
   #add-point:lock_b段define(客製用) name="lock_b.define_customerization"
   
   #end add-point
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
   
   #先刷新資料
   #CALL axrt300_06_b_fill(g_wc2)
   
   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "xrcf_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN axrt300_06_bcl USING g_enterprise,
                                       g_xrcf_d[g_detail_idx].xrcfld,g_xrcf_d[g_detail_idx].xrcfdocno, 
                                           g_xrcf_d[g_detail_idx].xrcfseq,g_xrcf_d[g_detail_idx].xrcfseq2 
 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "axrt300_06_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   
   END IF
                                    
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="axrt300_06.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION axrt300_06_unlock_b(ps_table)
   #add-point:unlock_b段define(客製用) name="unlock_b.define_customerization"
   
   #end add-point
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:unlock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="unlock_b.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="unlock_b.pre_function"
   
   #end add-point
   
   LET ls_group = ""
   
   #IF ls_group.getIndexOf(ps_table,1) THEN
      CLOSE axrt300_06_bcl
   #END IF
   
 
   
   #add-point:unlock_b段結束前 name="unlock_b.after"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="axrt300_06.modify_detail_chk" >}
#+ 單身輸入判定(因應modify_detail)
PRIVATE FUNCTION axrt300_06_modify_detail_chk(ps_record)
   #add-point:modify_detail_chk段define(客製用) name="modify_detail_chk.define_customerization"
   
   #end add-point
   DEFINE ps_record STRING
   DEFINE ls_return STRING
   #add-point:modify_detail_chk段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify_detail_chk.define"
   
   #end add-point
   
   #add-point:modify_detail_chk段開始前 name="modify_detail_chk.before"
   
   #end add-point
   
   #根據sr名稱確定該page第一個欄位的名稱
   CASE ps_record
      WHEN "s_detail1" 
         LET ls_return = "xrcfdocno"
      WHEN "s_detail2"
         LET ls_return = "xrcfdocno_2"
      WHEN "s_detail3"
         LET ls_return = "xrcfdocno_3"
      WHEN "s_detail4"
         LET ls_return = "xrcfdocno_4"
      WHEN "s_detail5"
         LET ls_return = "xrcfdocno_5"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="axrt300_06.show_ownid_msg" >}
#+ 判斷是否顯示只能修改自己權限資料的訊息
#(ver:35) ---add start---
PRIVATE FUNCTION axrt300_06_show_ownid_msg()
   #add-point:show_ownid_msg段define(客製用) name="show_ownid_msg.define_customerization"
   
   #end add-point
   #add-point:show_ownid_msg段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show_ownid_msg.define"
   
   #end add-point
  
 
   
 
END FUNCTION
#(ver:35) --- add end ---
 
{</section>}
 
{<section id="axrt300_06.mask_functions" >}
&include "erp/axr/axrt300_06_mask.4gl"
 
{</section>}
 
{<section id="axrt300_06.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION axrt300_06_set_pk_array()
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
   LET g_pk_array[1].values = g_xrcf_d[l_ac].xrcfld
   LET g_pk_array[1].column = 'xrcfld'
   LET g_pk_array[2].values = g_xrcf_d[l_ac].xrcfdocno
   LET g_pk_array[2].column = 'xrcfdocno'
   LET g_pk_array[3].values = g_xrcf_d[l_ac].xrcfseq
   LET g_pk_array[3].column = 'xrcfseq'
   LET g_pk_array[4].values = g_xrcf_d[l_ac].xrcfseq2
   LET g_pk_array[4].column = 'xrcfseq2'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axrt300_06.state_change" >}
   
 
{</section>}
 
{<section id="axrt300_06.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="axrt300_06.other_function" readonly="Y" >}

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
PRIVATE FUNCTION axrt300_06_xrcf(p_type)
   DEFINE p_type         LIKE type_t.chr10    #new 單據新增OR修改暫估單號、old 進入單身數據前,獲取可用金額、amt 修改金額
   DEFINE l_flag         LIKE type_t.chr1
   DEFINE l_ooaj004      LIKE ooaj_t.ooaj004
   DEFINE l_ooef014      LIKE ooef_t.ooef014
   #161128-00061#4---mdofiy--begin---------
   #DEFINE l_xrcb         RECORD LIKE xrcb_t.*
   #DEFINE l_xrca         RECORD LIKE xrca_t.*
   #DEFINE l_xrcf         RECORD LIKE xrcf_t.*
   DEFINE l_xrcb RECORD  #應收憑單單身
       xrcbent LIKE xrcb_t.xrcbent, #企業編號
       xrcbld LIKE xrcb_t.xrcbld, #帳套
       xrcbdocno LIKE xrcb_t.xrcbdocno, #單號
       xrcbseq LIKE xrcb_t.xrcbseq, #項次
       xrcbsite LIKE xrcb_t.xrcbsite, #營運據點
       xrcborga LIKE xrcb_t.xrcborga, #帳務來源SITE
       xrcb001 LIKE xrcb_t.xrcb001, #來源類型
       xrcb002 LIKE xrcb_t.xrcb002, #來源業務單據號碼
       xrcb003 LIKE xrcb_t.xrcb003, #來源業務單據項次
       xrcb004 LIKE xrcb_t.xrcb004, #產品編號
       xrcb005 LIKE xrcb_t.xrcb005, #品名規格
       xrcb006 LIKE xrcb_t.xrcb006, #單位
       xrcb007 LIKE xrcb_t.xrcb007, #計價數量
       xrcb008 LIKE xrcb_t.xrcb008, #參考單據號碼
       xrcb009 LIKE xrcb_t.xrcb009, #參考單號項次
       xrcblegl LIKE xrcb_t.xrcblegl, #核算組織
       xrcb010 LIKE xrcb_t.xrcb010, #業務部門
       xrcb011 LIKE xrcb_t.xrcb011, #責任中心
       xrcb012 LIKE xrcb_t.xrcb012, #產品類別
       xrcb013 LIKE xrcb_t.xrcb013, #發票帳否(搭贈/備品/樣品)
       xrcb014 LIKE xrcb_t.xrcb014, #理由碼
       xrcb015 LIKE xrcb_t.xrcb015, #專案編號
       xrcb016 LIKE xrcb_t.xrcb016, #WBS編號
       xrcb017 LIKE xrcb_t.xrcb017, #預算細項
       xrcb018 LIKE xrcb_t.xrcb018, #商戶編號
       xrcb019 LIKE xrcb_t.xrcb019, #開票性質
       xrcb020 LIKE xrcb_t.xrcb020, #稅別
       xrcb021 LIKE xrcb_t.xrcb021, #收入會計科目
       xrcb022 LIKE xrcb_t.xrcb022, #正負值
       xrcb023 LIKE xrcb_t.xrcb023, #沖暫估單否
       xrcb024 LIKE xrcb_t.xrcb024, #區域
       xrcb025 LIKE xrcb_t.xrcb025, #傳票號碼
       xrcb026 LIKE xrcb_t.xrcb026, #傳票項次
       xrcb027 LIKE xrcb_t.xrcb027, #發票編號
       xrcb028 LIKE xrcb_t.xrcb028, #發票號碼
       xrcb029 LIKE xrcb_t.xrcb029, #應收帳款科目
       xrcb030 LIKE xrcb_t.xrcb030, #已開發票數量
       xrcb031 LIKE xrcb_t.xrcb031, #收款條件編號
       xrcb032 LIKE xrcb_t.xrcb032, #訂金序次
       xrcb033 LIKE xrcb_t.xrcb033, #經營方式
       xrcb034 LIKE xrcb_t.xrcb034, #通路
       xrcb035 LIKE xrcb_t.xrcb035, #品牌
       xrcb036 LIKE xrcb_t.xrcb036, #客群
       xrcb037 LIKE xrcb_t.xrcb037, #自由核算項一
       xrcb038 LIKE xrcb_t.xrcb038, #自由核算項二
       xrcb039 LIKE xrcb_t.xrcb039, #自由核算項三
       xrcb040 LIKE xrcb_t.xrcb040, #自由核算項四
       xrcb041 LIKE xrcb_t.xrcb041, #自由核算項五
       xrcb042 LIKE xrcb_t.xrcb042, #自由核算項六
       xrcb043 LIKE xrcb_t.xrcb043, #自由核算項七
       xrcb044 LIKE xrcb_t.xrcb044, #自由核算項八
       xrcb045 LIKE xrcb_t.xrcb045, #自由核算項九
       xrcb046 LIKE xrcb_t.xrcb046, #自由核算項十
       xrcb047 LIKE xrcb_t.xrcb047, #摘要
       xrcb048 LIKE xrcb_t.xrcb048, #客戶訂購單號
       xrcb049 LIKE xrcb_t.xrcb049, #開票單號
       xrcb050 LIKE xrcb_t.xrcb050, #開票項次
       xrcb051 LIKE xrcb_t.xrcb051, #業務人員
       xrcb100 LIKE xrcb_t.xrcb100, #交易原幣
       xrcb101 LIKE xrcb_t.xrcb101, #交易原幣單價
       xrcb102 LIKE xrcb_t.xrcb102, #交易匯率
       xrcb103 LIKE xrcb_t.xrcb103, #交易原幣未稅金額
       xrcb104 LIKE xrcb_t.xrcb104, #交易原幣稅額
       xrcb105 LIKE xrcb_t.xrcb105, #交易原幣含稅金額
       xrcb106 LIKE xrcb_t.xrcb106, #交易原幣調整差異金額
       xrcb111 LIKE xrcb_t.xrcb111, #本幣單價
       xrcb113 LIKE xrcb_t.xrcb113, #本幣未稅金額
       xrcb114 LIKE xrcb_t.xrcb114, #本幣稅額
       xrcb115 LIKE xrcb_t.xrcb115, #本幣含稅金額
       xrcb116 LIKE xrcb_t.xrcb116, #本幣調整差異金額
       xrcb117 LIKE xrcb_t.xrcb117, #已開發票金額(未稅)
       xrcb118 LIKE xrcb_t.xrcb118, #應開發票未稅金額
       xrcb119 LIKE xrcb_t.xrcb119, #應開發票含稅金額
       xrcb121 LIKE xrcb_t.xrcb121, #本位幣二匯率
       xrcb123 LIKE xrcb_t.xrcb123, #本位幣二未稅金額
       xrcb124 LIKE xrcb_t.xrcb124, #本位幣二稅額
       xrcb125 LIKE xrcb_t.xrcb125, #本位幣二含稅金額
       xrcb126 LIKE xrcb_t.xrcb126, #本位幣二調整差異金額
       xrcb131 LIKE xrcb_t.xrcb131, #本位幣三匯率
       xrcb133 LIKE xrcb_t.xrcb133, #本位幣三未稅金額
       xrcb134 LIKE xrcb_t.xrcb134, #本位幣三稅額
       xrcb135 LIKE xrcb_t.xrcb135, #本位幣三含稅金額
       xrcb136 LIKE xrcb_t.xrcb136, #本位幣三調整差異金額
       xrcb052 LIKE xrcb_t.xrcb052, #款別編號
       xrcb053 LIKE xrcb_t.xrcb053, #帳款對象
       xrcb054 LIKE xrcb_t.xrcb054, #收款對象
       xrcb055 LIKE xrcb_t.xrcb055, #收現金額(流通)
       xrcb056 LIKE xrcb_t.xrcb056, #應收金額(流通)
       xrcb057 LIKE xrcb_t.xrcb057, #扣款金額(流通)
       xrcb058 LIKE xrcb_t.xrcb058, #預收科目
       xrcb059 LIKE xrcb_t.xrcb059, #代收銀科目
       xrcb060 LIKE xrcb_t.xrcb060, #月份類型
       xrcb107 LIKE xrcb_t.xrcb107  #出貨單單價
       END RECORD
   DEFINE l_xrca RECORD  #應收憑單單頭
       xrcaent LIKE xrca_t.xrcaent, #企業編號
       xrcaownid LIKE xrca_t.xrcaownid, #資料所有者
       xrcaowndp LIKE xrca_t.xrcaowndp, #資料所屬部門
       xrcacrtid LIKE xrca_t.xrcacrtid, #資料建立者
       xrcacrtdp LIKE xrca_t.xrcacrtdp, #資料建立部門
       xrcacrtdt LIKE xrca_t.xrcacrtdt, #資料創建日
       xrcamodid LIKE xrca_t.xrcamodid, #資料修改者
       xrcamoddt LIKE xrca_t.xrcamoddt, #最近修改日
       xrcacnfid LIKE xrca_t.xrcacnfid, #資料確認者
       xrcacnfdt LIKE xrca_t.xrcacnfdt, #資料確認日
       xrcapstid LIKE xrca_t.xrcapstid, #資料過帳者
       xrcapstdt LIKE xrca_t.xrcapstdt, #資料過帳日
       xrcastus LIKE xrca_t.xrcastus, #狀態碼
       xrcacomp LIKE xrca_t.xrcacomp, #法人
       xrcald LIKE xrca_t.xrcald, #帳套
       xrcadocno LIKE xrca_t.xrcadocno, #應收帳款單號碼
       xrcadocdt LIKE xrca_t.xrcadocdt, #帳款日期
       xrca001 LIKE xrca_t.xrca001, #帳款單性質
       xrcasite LIKE xrca_t.xrcasite, #帳務中心
       xrca003 LIKE xrca_t.xrca003, #帳務人員
       xrca004 LIKE xrca_t.xrca004, #帳款客戶編號
       xrca005 LIKE xrca_t.xrca005, #收款客戶
       xrca006 LIKE xrca_t.xrca006, #客戶分類
       xrca007 LIKE xrca_t.xrca007, #帳款類別
       xrca008 LIKE xrca_t.xrca008, #收款條件編號
       xrca009 LIKE xrca_t.xrca009, #應收款日/應扣抵日
       xrca010 LIKE xrca_t.xrca010, #容許票據到期日
       xrca011 LIKE xrca_t.xrca011, #稅別
       xrca012 LIKE xrca_t.xrca012, #稅率
       xrca013 LIKE xrca_t.xrca013, #含稅否
       xrca014 LIKE xrca_t.xrca014, #人員編號
       xrca015 LIKE xrca_t.xrca015, #部門編號
       xrca016 LIKE xrca_t.xrca016, #來源作業類型
       xrca017 LIKE xrca_t.xrca017, #產生方式
       xrca018 LIKE xrca_t.xrca018, #來源參考單號
       xrca019 LIKE xrca_t.xrca019, #系統產生對應單號(待抵帳款-預收)
       xrca020 LIKE xrca_t.xrca020, #信用狀申請流程否
       xrca021 LIKE xrca_t.xrca021, #商業發票號碼(IV no.)
       xrca022 LIKE xrca_t.xrca022, #出口報單號碼
       xrca023 LIKE xrca_t.xrca023, #發票客戶編號
       xrca024 LIKE xrca_t.xrca024, #發票客戶統一編號
       xrca025 LIKE xrca_t.xrca025, #發票客戶全名
       xrca026 LIKE xrca_t.xrca026, #發票客戶地址
       xrca028 LIKE xrca_t.xrca028, #發票類型
       xrca029 LIKE xrca_t.xrca029, #發票匯率
       xrca030 LIKE xrca_t.xrca030, #發票應開未稅金額
       xrca031 LIKE xrca_t.xrca031, #發票應開稅額
       xrca032 LIKE xrca_t.xrca032, #發票應開含稅金額
       xrca033 LIKE xrca_t.xrca033, #專案編號
       xrca034 LIKE xrca_t.xrca034, #責任中心
       xrca035 LIKE xrca_t.xrca035, #應收(借方)科目編號
       xrca036 LIKE xrca_t.xrca036, #收入(貸方)科目編號
       xrca037 LIKE xrca_t.xrca037, #分錄傳票產生否
       xrca038 LIKE xrca_t.xrca038, #拋轉傳票號碼
       xrca039 LIKE xrca_t.xrca039, #會計檢核附件份數
       xrca040 LIKE xrca_t.xrca040, #留置否
       xrca041 LIKE xrca_t.xrca041, #留置理由碼
       xrca042 LIKE xrca_t.xrca042, #留置設定日期
       xrca043 LIKE xrca_t.xrca043, #留置解除日期
       xrca044 LIKE xrca_t.xrca044, #留置原幣金額
       xrca045 LIKE xrca_t.xrca045, #留置說明
       xrca046 LIKE xrca_t.xrca046, #關係人否
       xrca047 LIKE xrca_t.xrca047, #多角序號
       xrca048 LIKE xrca_t.xrca048, #集團代收/代付單號
       xrca049 LIKE xrca_t.xrca049, #來源營運中心編號
       xrca050 LIKE xrca_t.xrca050, #交易原始單據份數
       xrca051 LIKE xrca_t.xrca051, #作廢理由碼
       xrca052 LIKE xrca_t.xrca052, #列印次數
       xrca053 LIKE xrca_t.xrca053, #備註
       xrca054 LIKE xrca_t.xrca054, #多帳期設定
       xrca055 LIKE xrca_t.xrca055, #繳款優惠條件
       xrca056 LIKE xrca_t.xrca056, #會計檢核附件狀態
       xrca057 LIKE xrca_t.xrca057, #交易對象識別碼
       xrca058 LIKE xrca_t.xrca058, #銷售分類
       xrca059 LIKE xrca_t.xrca059, #預算編號
       xrca060 LIKE xrca_t.xrca060, #發票開立原則
       xrca061 LIKE xrca_t.xrca061, #預計開立發票日期
       xrca062 LIKE xrca_t.xrca062, #多角性質
       xrca063 LIKE xrca_t.xrca063, #整帳批序號
       xrca064 LIKE xrca_t.xrca064, #訂金序次
       xrca065 LIKE xrca_t.xrca065, #發票編號
       xrca066 LIKE xrca_t.xrca066, #發票號碼
       xrca100 LIKE xrca_t.xrca100, #交易原幣別
       xrca101 LIKE xrca_t.xrca101, #原幣匯率
       xrca103 LIKE xrca_t.xrca103, #原幣未稅金額
       xrca104 LIKE xrca_t.xrca104, #原幣稅額
       xrca106 LIKE xrca_t.xrca106, #原幣直接折抵合計金額
       xrca107 LIKE xrca_t.xrca107, #原幣直接沖帳(調整)合計金額
       xrca108 LIKE xrca_t.xrca108, #原幣應收金額
       xrca113 LIKE xrca_t.xrca113, #本幣未稅金額
       xrca114 LIKE xrca_t.xrca114, #本幣稅額
       xrca116 LIKE xrca_t.xrca116, #本幣直接沖帳(調整)合計金額
       xrca117 LIKE xrca_t.xrca117, #本幣直接沖帳(調整)合計金額
       xrca118 LIKE xrca_t.xrca118, #本幣應收金額
       xrca120 LIKE xrca_t.xrca120, #本位幣二幣別
       xrca121 LIKE xrca_t.xrca121, #本位幣二匯率
       xrca123 LIKE xrca_t.xrca123, #本位幣二未稅金額
       xrca124 LIKE xrca_t.xrca124, #本位幣二稅額
       xrca126 LIKE xrca_t.xrca126, #本位幣二直接折抵合計金額
       xrca127 LIKE xrca_t.xrca127, #本位幣二直接沖帳(調整)合計金額
       xrca128 LIKE xrca_t.xrca128, #本位幣二應收金額
       xrca130 LIKE xrca_t.xrca130, #本位幣三幣別
       xrca131 LIKE xrca_t.xrca131, #本位幣三匯率
       xrca133 LIKE xrca_t.xrca133, #本位幣三未稅金額
       xrca134 LIKE xrca_t.xrca134, #本位幣三稅額
       xrca136 LIKE xrca_t.xrca136, #本位幣三直接折抵合計金額
       xrca137 LIKE xrca_t.xrca137, #本位幣三直接沖帳(調整)合計金額
       xrca138 LIKE xrca_t.xrca138  #本位幣三應收金額
       END RECORD

   #161128-00061#4---mdofiy--end---------

   IF cl_null(g_xrcf_d[l_ac].xrcf008) THEN RETURN END IF
  #IF cl_null(g_xrcf_d[l_ac].xrcf009) THEN RETURN END IF   #150401-00010#2 Mark

   #兩種情況:
   #CASE1:新增時取得可充暫估資料
   #CASE2:修改時比較資料可行性(需注意尾差)

   IF p_type <> 'amt' THEN   #非修改金額狀態下,都需要重新獲取可沖金額
      LET g_xrcf007 = 0
      LET g_xrcf103 = 0   LET g_xrcf104 = 0   LET g_xrcf105 = 0
      LET g_xrcf113 = 0   LET g_xrcf114 = 0   LET g_xrcf115 = 0
      LET g_xrcf123 = 0   LET g_xrcf124 = 0   LET g_xrcf125 = 0
      LET g_xrcf133 = 0   LET g_xrcf134 = 0   LET g_xrcf135 = 0
      #161128-00061#4---mdofiy--begin---------
     #SELECT * INTO l_xrcb.*
      SELECT xrcbent,xrcbld,xrcbdocno,xrcbseq,xrcbsite,xrcborga,xrcb001,xrcb002,xrcb003,xrcb004,
             xrcb005,xrcb006,xrcb007,xrcb008,xrcb009,xrcblegl,xrcb010,xrcb011,xrcb012,xrcb013,
             xrcb014,xrcb015,xrcb016,xrcb017,xrcb018,xrcb019,xrcb020,xrcb021,xrcb022,xrcb023,
             xrcb024,xrcb025,xrcb026,xrcb027,xrcb028,xrcb029,xrcb030,xrcb031,xrcb032,xrcb033,
             xrcb034,xrcb035,xrcb036,xrcb037,xrcb038,xrcb039,xrcb040,xrcb041,xrcb042,xrcb043,
             xrcb044,xrcb045,xrcb046,xrcb047,xrcb048,xrcb049,xrcb050,xrcb051,xrcb100,xrcb101,
             xrcb102,xrcb103,xrcb104,xrcb105,xrcb106,xrcb111,xrcb113,xrcb114,xrcb115,xrcb116,
             xrcb117,xrcb118,xrcb119,xrcb121,xrcb123,xrcb124,xrcb125,xrcb126,xrcb131,xrcb133,
             xrcb134,xrcb135,xrcb136,xrcb052,xrcb053,xrcb054,xrcb055,xrcb056,xrcb057,xrcb058,
             xrcb059,xrcb060,xrcb107 INTO l_xrcb.*
     #161128-00061#4---mdofiy--end---------
      FROM xrcb_t WHERE xrcbent = g_enterprise
         AND xrcbdocno = g_xrcf_d[l_ac].xrcf008
        #AND xrcbseq   = g_xrcf_d[l_ac].xrcf009   #150401-00010#2 Mark
         AND xrcbld    = g_xrcald

      #161128-00061#4---mdofiy--begin---------
      #SELECT * INTO l_xrca.* 
      SELECT xrcaent,xrcaownid,xrcaowndp,xrcacrtid,xrcacrtdp,xrcacrtdt,xrcamodid,xrcamoddt,xrcacnfid,
             xrcacnfdt,xrcapstid,xrcapstdt,xrcastus,xrcacomp,xrcald,xrcadocno,xrcadocdt,xrca001,
             xrcasite,xrca003,xrca004,xrca005,xrca006,xrca007,xrca008,xrca009,xrca010,xrca011,
             xrca012,xrca013,xrca014,xrca015,xrca016,xrca017,xrca018,xrca019,xrca020,xrca021,
             xrca022,xrca023,xrca024,xrca025,xrca026,xrca028,xrca029,xrca030,xrca031,xrca032,
             xrca033,xrca034,xrca035,xrca036,xrca037,xrca038,xrca039,xrca040,xrca041,xrca042,
             xrca043,xrca044,xrca045,xrca046,xrca047,xrca048,xrca049,xrca050,xrca051,xrca052,
             xrca053,xrca054,xrca055,xrca056,xrca057,xrca058,xrca059,xrca060,xrca061,xrca062,
             xrca063,xrca064,xrca065,xrca066,xrca100,xrca101,xrca103,xrca104,xrca106,xrca107,
             xrca108,xrca113,xrca114,xrca116,xrca117,xrca118,xrca120,xrca121,xrca123,xrca124,
             xrca126,xrca127,xrca128,xrca130,xrca131,xrca133,xrca134,xrca136,xrca137,xrca138 INTO l_xrca.* 
      #161128-00061#4---mdofiy--end--------- 
      FROM xrca_t WHERE xrcaent = g_enterprise
         AND xrcadocno = g_xrcf_d[l_ac].xrcf008
         AND xrcald    = g_xrcald

      SELECT ooef014 INTO l_ooef014 FROM ooef_t
       WHERE ooefent = g_enterprise AND ooef001 = g_glaa.glaacomp
      
      #1.取基础币种的金额精度--若有传入p_amount时,返回的是金额,非汇率
      CALL s_curr_sel_ooaj004(l_ooef014,g_glaa.glaa001)
         RETURNING l_ooaj004

      SELECT SUM(xrcf007),SUM(xrcf103),SUM(xrcf104),SUM(xrcf105),SUM(xrcf113),SUM(xrcf114),SUM(xrcf115),
                          SUM(xrcf123),SUM(xrcf124),SUM(xrcf125),SUM(xrcf133),SUM(xrcf134),SUM(xrcf135)
        INTO g_xrcf007,   g_xrcf103,   g_xrcf104,   g_xrcf105,   g_xrcf113,   g_xrcf114,   g_xrcf115,
                          g_xrcf123,   g_xrcf124,   g_xrcf125,   g_xrcf133,   g_xrcf134,   g_xrcf135
        FROM xrcf_t a
       WHERE xrcfent = g_enterprise
         AND xrcf008 = g_xrcf_d[l_ac].xrcf008
        #AND xrcf009 = g_xrcf_d[l_ac].xrcf009   #150401-00010#2 Mark

      IF cl_null(g_xrcf007) THEN LET g_xrcf007 = 0 END IF
      IF cl_null(g_xrcf103) THEN LET g_xrcf103 = 0 END IF   IF cl_null(g_xrcf113) THEN LET g_xrcf113 = 0 END IF
      IF cl_null(g_xrcf104) THEN LET g_xrcf104 = 0 END IF   IF cl_null(g_xrcf114) THEN LET g_xrcf114 = 0 END IF
      IF cl_null(g_xrcf105) THEN LET g_xrcf105 = 0 END IF   IF cl_null(g_xrcf115) THEN LET g_xrcf115 = 0 END IF
      IF cl_null(g_xrcf123) THEN LET g_xrcf123 = 0 END IF   IF cl_null(g_xrcf133) THEN LET g_xrcf133 = 0 END IF
      IF cl_null(g_xrcf124) THEN LET g_xrcf124 = 0 END IF   IF cl_null(g_xrcf134) THEN LET g_xrcf134 = 0 END IF
      IF cl_null(g_xrcf125) THEN LET g_xrcf125 = 0 END IF   IF cl_null(g_xrcf135) THEN LET g_xrcf135 = 0 END IF

      LET g_xrcf007 = l_xrcb.xrcb007 - g_xrcf007
      LET g_xrcf103 = l_xrcb.xrcb103 - g_xrcf103        LET g_xrcf113 = l_xrcb.xrcb113 - g_xrcf113
      LET g_xrcf104 = l_xrcb.xrcb104 - g_xrcf104        LET g_xrcf114 = l_xrcb.xrcb114 - g_xrcf114
      LET g_xrcf105 = l_xrcb.xrcb105 - g_xrcf105        LET g_xrcf115 = l_xrcb.xrcb115 - g_xrcf115
      LET g_xrcf123 = l_xrcb.xrcb123 - g_xrcf123        LET g_xrcf133 = l_xrcb.xrcb133 - g_xrcf133
      LET g_xrcf124 = l_xrcb.xrcb124 - g_xrcf124        LET g_xrcf134 = l_xrcb.xrcb134 - g_xrcf134
      LET g_xrcf125 = l_xrcb.xrcb125 - g_xrcf125        LET g_xrcf135 = l_xrcb.xrcb135 - g_xrcf135

   END IF

   IF p_type = 'old' THEN   #修改狀態下(非修改暫估單號)時,獲取的可沖金額需要減去當前資料的數據
      LET g_xrcf007 = g_xrcf007 + g_xrcf_d[l_ac].xrcf007
      LET g_xrcf103 = g_xrcf103 + g_xrcf_d[l_ac].xrcf103   LET g_xrcf113 = g_xrcf113 + g_xrcf_d[l_ac].xrcf113
      LET g_xrcf104 = g_xrcf104 + g_xrcf_d[l_ac].xrcf104   LET g_xrcf114 = g_xrcf114 + g_xrcf_d[l_ac].xrcf114
      LET g_xrcf105 = g_xrcf105 + g_xrcf_d[l_ac].xrcf105   LET g_xrcf115 = g_xrcf115 + g_xrcf_d[l_ac].xrcf115
      LET g_xrcf123 = g_xrcf123 + g_xrcf3_d[l_ac].xrcf123  LET g_xrcf133 = g_xrcf133 + g_xrcf3_d[l_ac].xrcf133
      LET g_xrcf124 = g_xrcf124 + g_xrcf3_d[l_ac].xrcf124  LET g_xrcf134 = g_xrcf134 + g_xrcf3_d[l_ac].xrcf134
      LET g_xrcf125 = g_xrcf125 + g_xrcf3_d[l_ac].xrcf125  LET g_xrcf135 = g_xrcf135 + g_xrcf3_d[l_ac].xrcf135
   END IF

   IF p_type = 'new' THEN
      LET g_xrcf_d[l_ac].xrcf101 = l_xrcb.xrcb101
      LET g_xrcf_d[l_ac].xrcf102 = l_xrca.xrca101
      LET g_xrcf_d[l_ac].xrcf007 = g_xrcf007 
      LET g_xrcf_d[l_ac].xrcf103 = g_xrcf103    LET g_xrcf_d[l_ac].xrcf113 = g_xrcf113
      LET g_xrcf_d[l_ac].xrcf104 = g_xrcf104    LET g_xrcf_d[l_ac].xrcf114 = g_xrcf114
      LET g_xrcf_d[l_ac].xrcf105 = g_xrcf105    LET g_xrcf_d[l_ac].xrcf115 = g_xrcf115
      LET g_xrcf3_d[l_ac].xrcf123 = g_xrcf123   LET g_xrcf3_d[l_ac].xrcf133 = g_xrcf133
      LET g_xrcf3_d[l_ac].xrcf124 = g_xrcf124   LET g_xrcf3_d[l_ac].xrcf134 = g_xrcf134
      LET g_xrcf3_d[l_ac].xrcf125 = g_xrcf125   LET g_xrcf3_d[l_ac].xrcf135 = g_xrcf135
      LET g_xrcf_d[l_ac].xrcf111 = l_xrcb.xrcb111
      IF g_glaa.glaa015 = 'Y' THEN
         #計算本位幣二金額
         LET g_xrcf3_d[l_ac].xrcf122 = l_xrca.xrca121
      END IF
      IF g_glaa.glaa019 = 'Y' THEN
         #計算本位幣三金額
         LET g_xrcf3_d[l_ac].xrcf132 = l_xrca.xrca131
      END IF
      
      DISPLAY g_xrcf_d[l_ac].xrcf007, g_xrcf_d[l_ac].xrcf101, g_xrcf_d[l_ac].xrcf103, g_xrcf_d[l_ac].xrcf104, g_xrcf_d[l_ac].xrcf105,
              g_xrcf_d[l_ac].xrcf111, g_xrcf_d[l_ac].xrcf113, g_xrcf_d[l_ac].xrcf114, g_xrcf_d[l_ac].xrcf115
           TO s_detail2[l_ac].xrcf007,s_detail2[l_ac].xrcf101,s_detail2[l_ac].xrcf103,s_detail2[l_ac].xrcf104,s_detail2[l_ac].xrcf105,
              s_detail2[l_ac].xrcf111,s_detail2[l_ac].xrcf113,s_detail2[l_ac].xrcf114,s_detail2[l_ac].xrcf115
      
      LET g_xrcf3_d[l_ac].xrcf105 = g_xrcf_d[l_ac].xrcf105
      
      DISPLAY g_xrcf3_d[l_ac].xrcf105,g_xrcf3_d[l_ac].xrcf122,
              g_xrcf3_d[l_ac].xrcf123,g_xrcf3_d[l_ac].xrcf124,g_xrcf3_d[l_ac].xrcf125,
              g_xrcf3_d[l_ac].xrcf132,g_xrcf3_d[l_ac].xrcf133,g_xrcf3_d[l_ac].xrcf134,
              g_xrcf3_d[l_ac].xrcf135
           TO s_detail4[l_ac].xrcf105,s_detail4[l_ac].xrcf122,
              s_detail4[l_ac].xrcf123,s_detail4[l_ac].xrcf124,s_detail4[l_ac].xrcf125,
              s_detail4[l_ac].xrcf132,s_detail4[l_ac].xrcf133,s_detail4[l_ac].xrcf134,
              s_detail4[l_ac].xrcf135
      
      RETURN

   END IF

   IF p_type = 'amt' THEN   #修改金額之後,需要判斷是否大於可沖金額、是否存在尾差
      LET g_errno = ' '
      #允許的可沖金額範圍檢查的優先級大於尾差檢查的優先級,所以先檢查尾差再檢查可沖金額
      #STEP1
      IF g_xrcf_d[l_ac].xrcf007 = g_xrcf007 THEN
         IF g_xrcf_d[l_ac].xrcf103 <> g_xrcf103 THEN LET g_errno = 'axr-00148' END IF
         IF g_xrcf_d[l_ac].xrcf104 <> g_xrcf104 THEN LET g_errno = 'axr-00148' END IF
         IF g_xrcf_d[l_ac].xrcf105 <> g_xrcf105 THEN LET g_errno = 'axr-00148' END IF
         IF g_xrcf_d[l_ac].xrcf113 <> g_xrcf113 THEN LET g_errno = 'axr-00148' END IF
         IF g_xrcf_d[l_ac].xrcf114 <> g_xrcf114 THEN LET g_errno = 'axr-00148' END IF
         IF g_xrcf_d[l_ac].xrcf115 <> g_xrcf115 THEN LET g_errno = 'axr-00148' END IF
         IF g_xrcf3_d[l_ac].xrcf123 <> g_xrcf123 THEN LET g_errno = 'axr-00148' END IF
         IF g_xrcf3_d[l_ac].xrcf124 <> g_xrcf124 THEN LET g_errno = 'axr-00148' END IF
         IF g_xrcf3_d[l_ac].xrcf125 <> g_xrcf125 THEN LET g_errno = 'axr-00148' END IF
         IF g_xrcf3_d[l_ac].xrcf133 <> g_xrcf133 THEN LET g_errno = 'axr-00148' END IF
         IF g_xrcf3_d[l_ac].xrcf134 <> g_xrcf134 THEN LET g_errno = 'axr-00148' END IF
         IF g_xrcf3_d[l_ac].xrcf135 <> g_xrcf135 THEN LET g_errno = 'axr-00148' END IF
      END IF
      #STEP2
      IF g_xrcf_d[l_ac].xrcf007 > g_xrcf007 THEN LET g_errno = 'axr-00146' END IF
      IF g_xrcf_d[l_ac].xrcf103 > g_xrcf103 THEN LET g_errno = 'axr-00147' END IF
      IF g_xrcf_d[l_ac].xrcf104 > g_xrcf104 THEN LET g_errno = 'axr-00147' END IF
      IF g_xrcf_d[l_ac].xrcf105 > g_xrcf105 THEN LET g_errno = 'axr-00147' END IF
      IF g_xrcf_d[l_ac].xrcf113 > g_xrcf113 THEN LET g_errno = 'axr-00147' END IF
      IF g_xrcf_d[l_ac].xrcf114 > g_xrcf114 THEN LET g_errno = 'axr-00147' END IF
      IF g_xrcf_d[l_ac].xrcf115 > g_xrcf115 THEN LET g_errno = 'axr-00147' END IF
      IF g_xrcf3_d[l_ac].xrcf123 > g_xrcf123 THEN LET g_errno = 'axr-00147' END IF
      IF g_xrcf3_d[l_ac].xrcf124 > g_xrcf124 THEN LET g_errno = 'axr-00147' END IF
      IF g_xrcf3_d[l_ac].xrcf125 > g_xrcf125 THEN LET g_errno = 'axr-00147' END IF
      IF g_xrcf3_d[l_ac].xrcf133 > g_xrcf133 THEN LET g_errno = 'axr-00147' END IF
      IF g_xrcf3_d[l_ac].xrcf134 > g_xrcf134 THEN LET g_errno = 'axr-00147' END IF
      IF g_xrcf3_d[l_ac].xrcf135 > g_xrcf135 THEN LET g_errno = 'axr-00147' END IF

      IF g_errno IS NULL THEN
         IF g_glaa.glaa015 = 'Y' THEN
            #計算本位幣二金額
            LET g_xrcf3_d[l_ac].xrcf122 = l_xrca.xrca121
         END IF
         IF g_glaa.glaa019 = 'Y' THEN
            #計算本位幣三金額
            LET g_xrcf3_d[l_ac].xrcf132 = l_xrca.xrca131
         END IF
         
         DISPLAY g_xrcf_d[l_ac].xrcf007, g_xrcf_d[l_ac].xrcf101, g_xrcf_d[l_ac].xrcf103, g_xrcf_d[l_ac].xrcf104, g_xrcf_d[l_ac].xrcf105,
                 g_xrcf_d[l_ac].xrcf111, g_xrcf_d[l_ac].xrcf113, g_xrcf_d[l_ac].xrcf114, g_xrcf_d[l_ac].xrcf115
              TO s_detail2[l_ac].xrcf007,s_detail2[l_ac].xrcf101,s_detail2[l_ac].xrcf103,s_detail2[l_ac].xrcf104,s_detail2[l_ac].xrcf105,
                 s_detail2[l_ac].xrcf111,s_detail2[l_ac].xrcf113,s_detail2[l_ac].xrcf114,s_detail2[l_ac].xrcf115
         
         LET g_xrcf3_d[l_ac].xrcf105 = g_xrcf_d[l_ac].xrcf105
         
         DISPLAY g_xrcf3_d[l_ac].xrcf105,g_xrcf3_d[l_ac].xrcf122,
                 g_xrcf3_d[l_ac].xrcf123,g_xrcf3_d[l_ac].xrcf124,g_xrcf3_d[l_ac].xrcf125,
                 g_xrcf3_d[l_ac].xrcf132,g_xrcf3_d[l_ac].xrcf133,g_xrcf3_d[l_ac].xrcf134,
                 g_xrcf3_d[l_ac].xrcf135
              TO s_detail4[l_ac].xrcf105,s_detail4[l_ac].xrcf122,
                 s_detail4[l_ac].xrcf123,s_detail4[l_ac].xrcf124,s_detail4[l_ac].xrcf125,
                 s_detail4[l_ac].xrcf132,s_detail4[l_ac].xrcf133,s_detail4[l_ac].xrcf134,
                 s_detail4[l_ac].xrcf135

      END IF

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
PRIVATE FUNCTION axrt300_06_refresh(p_type)
   DEFINE p_type         LIKE type_t.chr10      # all 修改單號 mid 原幣金額重新計算 lit1 修改本幣金額 lit2 修改本幣金額 lit3 修改本幣金額
   DEFINE l_success      LIKE type_t.num5
   DEFINE l_oodbl004     LIKE oodbL_t.oodbl004
   DEFINE l_oodb005      LIKE oodb_t.oodb005
   DEFINE l_oodb006      LIKE oodb_t.oodb006
   DEFINE l_oodb011      LIKE oodb_t.oodb011
   DEFINE l_ooaj004      LIKE ooaj_t.ooaj004
   DEFINE l_ooef014      LIKE ooef_t.ooef014
   DEFINE l_amt1         LIKE type_t.num20
   DEFINE l_amt2         LIKE type_t.num20
   DEFINE l_amt3         LIKE type_t.num20
   #161128-00061#4---mdofiy--begin---------
   #DEFINE l_xrcb         RECORD LIKE xrcb_t.*
   #DEFINE l_xrca         RECORD LIKE xrca_t.*
   DEFINE l_xrcb RECORD  #應收憑單單身
       xrcbent LIKE xrcb_t.xrcbent, #企業編號
       xrcbld LIKE xrcb_t.xrcbld, #帳套
       xrcbdocno LIKE xrcb_t.xrcbdocno, #單號
       xrcbseq LIKE xrcb_t.xrcbseq, #項次
       xrcbsite LIKE xrcb_t.xrcbsite, #營運據點
       xrcborga LIKE xrcb_t.xrcborga, #帳務來源SITE
       xrcb001 LIKE xrcb_t.xrcb001, #來源類型
       xrcb002 LIKE xrcb_t.xrcb002, #來源業務單據號碼
       xrcb003 LIKE xrcb_t.xrcb003, #來源業務單據項次
       xrcb004 LIKE xrcb_t.xrcb004, #產品編號
       xrcb005 LIKE xrcb_t.xrcb005, #品名規格
       xrcb006 LIKE xrcb_t.xrcb006, #單位
       xrcb007 LIKE xrcb_t.xrcb007, #計價數量
       xrcb008 LIKE xrcb_t.xrcb008, #參考單據號碼
       xrcb009 LIKE xrcb_t.xrcb009, #參考單號項次
       xrcblegl LIKE xrcb_t.xrcblegl, #核算組織
       xrcb010 LIKE xrcb_t.xrcb010, #業務部門
       xrcb011 LIKE xrcb_t.xrcb011, #責任中心
       xrcb012 LIKE xrcb_t.xrcb012, #產品類別
       xrcb013 LIKE xrcb_t.xrcb013, #發票帳否(搭贈/備品/樣品)
       xrcb014 LIKE xrcb_t.xrcb014, #理由碼
       xrcb015 LIKE xrcb_t.xrcb015, #專案編號
       xrcb016 LIKE xrcb_t.xrcb016, #WBS編號
       xrcb017 LIKE xrcb_t.xrcb017, #預算細項
       xrcb018 LIKE xrcb_t.xrcb018, #商戶編號
       xrcb019 LIKE xrcb_t.xrcb019, #開票性質
       xrcb020 LIKE xrcb_t.xrcb020, #稅別
       xrcb021 LIKE xrcb_t.xrcb021, #收入會計科目
       xrcb022 LIKE xrcb_t.xrcb022, #正負值
       xrcb023 LIKE xrcb_t.xrcb023, #沖暫估單否
       xrcb024 LIKE xrcb_t.xrcb024, #區域
       xrcb025 LIKE xrcb_t.xrcb025, #傳票號碼
       xrcb026 LIKE xrcb_t.xrcb026, #傳票項次
       xrcb027 LIKE xrcb_t.xrcb027, #發票編號
       xrcb028 LIKE xrcb_t.xrcb028, #發票號碼
       xrcb029 LIKE xrcb_t.xrcb029, #應收帳款科目
       xrcb030 LIKE xrcb_t.xrcb030, #已開發票數量
       xrcb031 LIKE xrcb_t.xrcb031, #收款條件編號
       xrcb032 LIKE xrcb_t.xrcb032, #訂金序次
       xrcb033 LIKE xrcb_t.xrcb033, #經營方式
       xrcb034 LIKE xrcb_t.xrcb034, #通路
       xrcb035 LIKE xrcb_t.xrcb035, #品牌
       xrcb036 LIKE xrcb_t.xrcb036, #客群
       xrcb037 LIKE xrcb_t.xrcb037, #自由核算項一
       xrcb038 LIKE xrcb_t.xrcb038, #自由核算項二
       xrcb039 LIKE xrcb_t.xrcb039, #自由核算項三
       xrcb040 LIKE xrcb_t.xrcb040, #自由核算項四
       xrcb041 LIKE xrcb_t.xrcb041, #自由核算項五
       xrcb042 LIKE xrcb_t.xrcb042, #自由核算項六
       xrcb043 LIKE xrcb_t.xrcb043, #自由核算項七
       xrcb044 LIKE xrcb_t.xrcb044, #自由核算項八
       xrcb045 LIKE xrcb_t.xrcb045, #自由核算項九
       xrcb046 LIKE xrcb_t.xrcb046, #自由核算項十
       xrcb047 LIKE xrcb_t.xrcb047, #摘要
       xrcb048 LIKE xrcb_t.xrcb048, #客戶訂購單號
       xrcb049 LIKE xrcb_t.xrcb049, #開票單號
       xrcb050 LIKE xrcb_t.xrcb050, #開票項次
       xrcb051 LIKE xrcb_t.xrcb051, #業務人員
       xrcb100 LIKE xrcb_t.xrcb100, #交易原幣
       xrcb101 LIKE xrcb_t.xrcb101, #交易原幣單價
       xrcb102 LIKE xrcb_t.xrcb102, #交易匯率
       xrcb103 LIKE xrcb_t.xrcb103, #交易原幣未稅金額
       xrcb104 LIKE xrcb_t.xrcb104, #交易原幣稅額
       xrcb105 LIKE xrcb_t.xrcb105, #交易原幣含稅金額
       xrcb106 LIKE xrcb_t.xrcb106, #交易原幣調整差異金額
       xrcb111 LIKE xrcb_t.xrcb111, #本幣單價
       xrcb113 LIKE xrcb_t.xrcb113, #本幣未稅金額
       xrcb114 LIKE xrcb_t.xrcb114, #本幣稅額
       xrcb115 LIKE xrcb_t.xrcb115, #本幣含稅金額
       xrcb116 LIKE xrcb_t.xrcb116, #本幣調整差異金額
       xrcb117 LIKE xrcb_t.xrcb117, #已開發票金額(未稅)
       xrcb118 LIKE xrcb_t.xrcb118, #應開發票未稅金額
       xrcb119 LIKE xrcb_t.xrcb119, #應開發票含稅金額
       xrcb121 LIKE xrcb_t.xrcb121, #本位幣二匯率
       xrcb123 LIKE xrcb_t.xrcb123, #本位幣二未稅金額
       xrcb124 LIKE xrcb_t.xrcb124, #本位幣二稅額
       xrcb125 LIKE xrcb_t.xrcb125, #本位幣二含稅金額
       xrcb126 LIKE xrcb_t.xrcb126, #本位幣二調整差異金額
       xrcb131 LIKE xrcb_t.xrcb131, #本位幣三匯率
       xrcb133 LIKE xrcb_t.xrcb133, #本位幣三未稅金額
       xrcb134 LIKE xrcb_t.xrcb134, #本位幣三稅額
       xrcb135 LIKE xrcb_t.xrcb135, #本位幣三含稅金額
       xrcb136 LIKE xrcb_t.xrcb136, #本位幣三調整差異金額
       xrcb052 LIKE xrcb_t.xrcb052, #款別編號
       xrcb053 LIKE xrcb_t.xrcb053, #帳款對象
       xrcb054 LIKE xrcb_t.xrcb054, #收款對象
       xrcb055 LIKE xrcb_t.xrcb055, #收現金額(流通)
       xrcb056 LIKE xrcb_t.xrcb056, #應收金額(流通)
       xrcb057 LIKE xrcb_t.xrcb057, #扣款金額(流通)
       xrcb058 LIKE xrcb_t.xrcb058, #預收科目
       xrcb059 LIKE xrcb_t.xrcb059, #代收銀科目
       xrcb060 LIKE xrcb_t.xrcb060, #月份類型
       xrcb107 LIKE xrcb_t.xrcb107  #出貨單單價
       END RECORD
   DEFINE l_xrca RECORD  #應收憑單單頭
       xrcaent LIKE xrca_t.xrcaent, #企業編號
       xrcaownid LIKE xrca_t.xrcaownid, #資料所有者
       xrcaowndp LIKE xrca_t.xrcaowndp, #資料所屬部門
       xrcacrtid LIKE xrca_t.xrcacrtid, #資料建立者
       xrcacrtdp LIKE xrca_t.xrcacrtdp, #資料建立部門
       xrcacrtdt LIKE xrca_t.xrcacrtdt, #資料創建日
       xrcamodid LIKE xrca_t.xrcamodid, #資料修改者
       xrcamoddt LIKE xrca_t.xrcamoddt, #最近修改日
       xrcacnfid LIKE xrca_t.xrcacnfid, #資料確認者
       xrcacnfdt LIKE xrca_t.xrcacnfdt, #資料確認日
       xrcapstid LIKE xrca_t.xrcapstid, #資料過帳者
       xrcapstdt LIKE xrca_t.xrcapstdt, #資料過帳日
       xrcastus LIKE xrca_t.xrcastus, #狀態碼
       xrcacomp LIKE xrca_t.xrcacomp, #法人
       xrcald LIKE xrca_t.xrcald, #帳套
       xrcadocno LIKE xrca_t.xrcadocno, #應收帳款單號碼
       xrcadocdt LIKE xrca_t.xrcadocdt, #帳款日期
       xrca001 LIKE xrca_t.xrca001, #帳款單性質
       xrcasite LIKE xrca_t.xrcasite, #帳務中心
       xrca003 LIKE xrca_t.xrca003, #帳務人員
       xrca004 LIKE xrca_t.xrca004, #帳款客戶編號
       xrca005 LIKE xrca_t.xrca005, #收款客戶
       xrca006 LIKE xrca_t.xrca006, #客戶分類
       xrca007 LIKE xrca_t.xrca007, #帳款類別
       xrca008 LIKE xrca_t.xrca008, #收款條件編號
       xrca009 LIKE xrca_t.xrca009, #應收款日/應扣抵日
       xrca010 LIKE xrca_t.xrca010, #容許票據到期日
       xrca011 LIKE xrca_t.xrca011, #稅別
       xrca012 LIKE xrca_t.xrca012, #稅率
       xrca013 LIKE xrca_t.xrca013, #含稅否
       xrca014 LIKE xrca_t.xrca014, #人員編號
       xrca015 LIKE xrca_t.xrca015, #部門編號
       xrca016 LIKE xrca_t.xrca016, #來源作業類型
       xrca017 LIKE xrca_t.xrca017, #產生方式
       xrca018 LIKE xrca_t.xrca018, #來源參考單號
       xrca019 LIKE xrca_t.xrca019, #系統產生對應單號(待抵帳款-預收)
       xrca020 LIKE xrca_t.xrca020, #信用狀申請流程否
       xrca021 LIKE xrca_t.xrca021, #商業發票號碼(IV no.)
       xrca022 LIKE xrca_t.xrca022, #出口報單號碼
       xrca023 LIKE xrca_t.xrca023, #發票客戶編號
       xrca024 LIKE xrca_t.xrca024, #發票客戶統一編號
       xrca025 LIKE xrca_t.xrca025, #發票客戶全名
       xrca026 LIKE xrca_t.xrca026, #發票客戶地址
       xrca028 LIKE xrca_t.xrca028, #發票類型
       xrca029 LIKE xrca_t.xrca029, #發票匯率
       xrca030 LIKE xrca_t.xrca030, #發票應開未稅金額
       xrca031 LIKE xrca_t.xrca031, #發票應開稅額
       xrca032 LIKE xrca_t.xrca032, #發票應開含稅金額
       xrca033 LIKE xrca_t.xrca033, #專案編號
       xrca034 LIKE xrca_t.xrca034, #責任中心
       xrca035 LIKE xrca_t.xrca035, #應收(借方)科目編號
       xrca036 LIKE xrca_t.xrca036, #收入(貸方)科目編號
       xrca037 LIKE xrca_t.xrca037, #分錄傳票產生否
       xrca038 LIKE xrca_t.xrca038, #拋轉傳票號碼
       xrca039 LIKE xrca_t.xrca039, #會計檢核附件份數
       xrca040 LIKE xrca_t.xrca040, #留置否
       xrca041 LIKE xrca_t.xrca041, #留置理由碼
       xrca042 LIKE xrca_t.xrca042, #留置設定日期
       xrca043 LIKE xrca_t.xrca043, #留置解除日期
       xrca044 LIKE xrca_t.xrca044, #留置原幣金額
       xrca045 LIKE xrca_t.xrca045, #留置說明
       xrca046 LIKE xrca_t.xrca046, #關係人否
       xrca047 LIKE xrca_t.xrca047, #多角序號
       xrca048 LIKE xrca_t.xrca048, #集團代收/代付單號
       xrca049 LIKE xrca_t.xrca049, #來源營運中心編號
       xrca050 LIKE xrca_t.xrca050, #交易原始單據份數
       xrca051 LIKE xrca_t.xrca051, #作廢理由碼
       xrca052 LIKE xrca_t.xrca052, #列印次數
       xrca053 LIKE xrca_t.xrca053, #備註
       xrca054 LIKE xrca_t.xrca054, #多帳期設定
       xrca055 LIKE xrca_t.xrca055, #繳款優惠條件
       xrca056 LIKE xrca_t.xrca056, #會計檢核附件狀態
       xrca057 LIKE xrca_t.xrca057, #交易對象識別碼
       xrca058 LIKE xrca_t.xrca058, #銷售分類
       xrca059 LIKE xrca_t.xrca059, #預算編號
       xrca060 LIKE xrca_t.xrca060, #發票開立原則
       xrca061 LIKE xrca_t.xrca061, #預計開立發票日期
       xrca062 LIKE xrca_t.xrca062, #多角性質
       xrca063 LIKE xrca_t.xrca063, #整帳批序號
       xrca064 LIKE xrca_t.xrca064, #訂金序次
       xrca065 LIKE xrca_t.xrca065, #發票編號
       xrca066 LIKE xrca_t.xrca066, #發票號碼
       xrca100 LIKE xrca_t.xrca100, #交易原幣別
       xrca101 LIKE xrca_t.xrca101, #原幣匯率
       xrca103 LIKE xrca_t.xrca103, #原幣未稅金額
       xrca104 LIKE xrca_t.xrca104, #原幣稅額
       xrca106 LIKE xrca_t.xrca106, #原幣直接折抵合計金額
       xrca107 LIKE xrca_t.xrca107, #原幣直接沖帳(調整)合計金額
       xrca108 LIKE xrca_t.xrca108, #原幣應收金額
       xrca113 LIKE xrca_t.xrca113, #本幣未稅金額
       xrca114 LIKE xrca_t.xrca114, #本幣稅額
       xrca116 LIKE xrca_t.xrca116, #本幣直接沖帳(調整)合計金額
       xrca117 LIKE xrca_t.xrca117, #本幣直接沖帳(調整)合計金額
       xrca118 LIKE xrca_t.xrca118, #本幣應收金額
       xrca120 LIKE xrca_t.xrca120, #本位幣二幣別
       xrca121 LIKE xrca_t.xrca121, #本位幣二匯率
       xrca123 LIKE xrca_t.xrca123, #本位幣二未稅金額
       xrca124 LIKE xrca_t.xrca124, #本位幣二稅額
       xrca126 LIKE xrca_t.xrca126, #本位幣二直接折抵合計金額
       xrca127 LIKE xrca_t.xrca127, #本位幣二直接沖帳(調整)合計金額
       xrca128 LIKE xrca_t.xrca128, #本位幣二應收金額
       xrca130 LIKE xrca_t.xrca130, #本位幣三幣別
       xrca131 LIKE xrca_t.xrca131, #本位幣三匯率
       xrca133 LIKE xrca_t.xrca133, #本位幣三未稅金額
       xrca134 LIKE xrca_t.xrca134, #本位幣三稅額
       xrca136 LIKE xrca_t.xrca136, #本位幣三直接折抵合計金額
       xrca137 LIKE xrca_t.xrca137, #本位幣三直接沖帳(調整)合計金額
       xrca138 LIKE xrca_t.xrca138  #本位幣三應收金額
       END RECORD
   #161128-00061#4---mdofiy--end---------     


   #161128-00061#4---mdofiy--begin---------
   #SELECT * INTO l_xrcb.*
    SELECT xrcbent,xrcbld,xrcbdocno,xrcbseq,xrcbsite,xrcborga,xrcb001,xrcb002,xrcb003,xrcb004,
           xrcb005,xrcb006,xrcb007,xrcb008,xrcb009,xrcblegl,xrcb010,xrcb011,xrcb012,xrcb013,
           xrcb014,xrcb015,xrcb016,xrcb017,xrcb018,xrcb019,xrcb020,xrcb021,xrcb022,xrcb023,
           xrcb024,xrcb025,xrcb026,xrcb027,xrcb028,xrcb029,xrcb030,xrcb031,xrcb032,xrcb033,
           xrcb034,xrcb035,xrcb036,xrcb037,xrcb038,xrcb039,xrcb040,xrcb041,xrcb042,xrcb043,
           xrcb044,xrcb045,xrcb046,xrcb047,xrcb048,xrcb049,xrcb050,xrcb051,xrcb100,xrcb101,
           xrcb102,xrcb103,xrcb104,xrcb105,xrcb106,xrcb111,xrcb113,xrcb114,xrcb115,xrcb116,
           xrcb117,xrcb118,xrcb119,xrcb121,xrcb123,xrcb124,xrcb125,xrcb126,xrcb131,xrcb133,
           xrcb134,xrcb135,xrcb136,xrcb052,xrcb053,xrcb054,xrcb055,xrcb056,xrcb057,xrcb058,
           xrcb059,xrcb060,xrcb107 INTO l_xrcb.*
   #161128-00061#4---mdofiy--end--------- 
   FROM xrcb_t
    WHERE xrcbent = g_enterprise AND xrcbdocno = g_xrcf_d[l_ac].xrcf008#AND xrcbseq = g_xrcf_d[l_ac].xrcf009   #150401-00010#2 Mark
      AND xrcbld = g_xrcald
      
   #161128-00061#4---mdofiy--begin---------
   #SELECT * INTO l_xrca.* 
   SELECT xrcaent,xrcaownid,xrcaowndp,xrcacrtid,xrcacrtdp,xrcacrtdt,xrcamodid,xrcamoddt,xrcacnfid,
          xrcacnfdt,xrcapstid,xrcapstdt,xrcastus,xrcacomp,xrcald,xrcadocno,xrcadocdt,xrca001,
          xrcasite,xrca003,xrca004,xrca005,xrca006,xrca007,xrca008,xrca009,xrca010,xrca011,
          xrca012,xrca013,xrca014,xrca015,xrca016,xrca017,xrca018,xrca019,xrca020,xrca021,
          xrca022,xrca023,xrca024,xrca025,xrca026,xrca028,xrca029,xrca030,xrca031,xrca032,
          xrca033,xrca034,xrca035,xrca036,xrca037,xrca038,xrca039,xrca040,xrca041,xrca042,
          xrca043,xrca044,xrca045,xrca046,xrca047,xrca048,xrca049,xrca050,xrca051,xrca052,
          xrca053,xrca054,xrca055,xrca056,xrca057,xrca058,xrca059,xrca060,xrca061,xrca062,
          xrca063,xrca064,xrca065,xrca066,xrca100,xrca101,xrca103,xrca104,xrca106,xrca107,
          xrca108,xrca113,xrca114,xrca116,xrca117,xrca118,xrca120,xrca121,xrca123,xrca124,
          xrca126,xrca127,xrca128,xrca130,xrca131,xrca133,xrca134,xrca136,xrca137,xrca138 INTO l_xrca.* 
   #161128-00061#4---mdofiy--end--------- 
   FROM xrca_t
    WHERE xrcaent = g_enterprise AND xrcadocno = g_xrcf_d[l_ac].xrcf008
      AND xrcald = g_xrcald

   SELECT ooef014 INTO l_ooef014 FROM ooef_t
    WHERE ooefent = g_enterprise AND ooef001 = g_glaa.glaacomp

   #取基础币种的金额精度--若有传入p_amount时,返回的是金额,非汇率
   CALL s_curr_sel_ooaj004(l_ooef014,g_glaa.glaa001)
      RETURNING l_ooaj004

   CALL s_tax_chk(l_xrca.xrcasite,l_xrcb.xrcb020) RETURNING l_success,l_oodbl004,l_oodb005,l_oodb006,l_oodb011

   IF p_type = 'all' THEN
      CALL s_tax_count(l_xrca.xrcasite,l_xrcb.xrcb020,g_xrcf_d[l_ac].xrcf007 * g_xrcf_d[l_ac].xrcf101,g_xrcf_d[l_ac].xrcf007,l_xrca.xrca100,l_xrca.xrca101)
         RETURNING g_xrcf_d[l_ac].xrcf103,g_xrcf_d[l_ac].xrcf104,g_xrcf_d[l_ac].xrcf105,
                   g_xrcf_d[l_ac].xrcf113,g_xrcf_d[l_ac].xrcf114,g_xrcf_d[l_ac].xrcf115
   END IF

   IF p_type = 'mid' THEN
      IF l_oodb005 = 'Y' THEN
         CALL s_tax_count(l_xrca.xrcasite,l_xrcb.xrcb020,g_xrcf_d[l_ac].xrcf105,g_xrcf_d[l_ac].xrcf007,l_xrca.xrca100,l_xrca.xrca101)
            RETURNING g_xrcf_d[l_ac].xrcf103,g_xrcf_d[l_ac].xrcf104,g_xrcf_d[l_ac].xrcf105,
                      g_xrcf_d[l_ac].xrcf113,g_xrcf_d[l_ac].xrcf114,g_xrcf_d[l_ac].xrcf115
      ELSE
         CALL s_tax_count(l_xrca.xrcasite,l_xrcb.xrcb020,g_xrcf_d[l_ac].xrcf103,g_xrcf_d[l_ac].xrcf007,l_xrca.xrca100,l_xrca.xrca101)
            RETURNING g_xrcf_d[l_ac].xrcf103,g_xrcf_d[l_ac].xrcf104,g_xrcf_d[l_ac].xrcf105,
                      g_xrcf_d[l_ac].xrcf113,g_xrcf_d[l_ac].xrcf114,g_xrcf_d[l_ac].xrcf115
      END IF
   END IF

   IF p_type = 'lit1' THEN
      IF l_oodb005 = 'Y' THEN
         CALL s_tax_count(l_xrca.xrcasite,l_xrcb.xrcb020,g_xrcf_d[l_ac].xrcf115,g_xrcf_d[l_ac].xrcf007,l_xrca.xrca100,l_xrca.xrca101)
            RETURNING g_xrcf_d[l_ac].xrcf113,g_xrcf_d[l_ac].xrcf114,g_xrcf_d[l_ac].xrcf115,l_amt1,l_amt2,l_amt3
      ELSE
         CALL s_tax_count(l_xrca.xrcasite,l_xrcb.xrcb020,g_xrcf_d[l_ac].xrcf113,g_xrcf_d[l_ac].xrcf007,l_xrca.xrca100,l_xrca.xrca101)
            RETURNING g_xrcf_d[l_ac].xrcf113,g_xrcf_d[l_ac].xrcf114,g_xrcf_d[l_ac].xrcf115,l_amt1,l_amt2,l_amt3
      END IF
   END IF

   IF p_type = 'lit2' THEN
      IF l_oodb005 = 'Y' THEN
         CALL s_tax_count(l_xrca.xrcasite,l_xrcb.xrcb020,g_xrcf3_d[l_ac].xrcf125,g_xrcf_d[l_ac].xrcf007,l_xrca.xrca100,l_xrca.xrca101)
            RETURNING g_xrcf3_d[l_ac].xrcf123,g_xrcf3_d[l_ac].xrcf124,g_xrcf3_d[l_ac].xrcf125,l_amt1,l_amt2,l_amt3
      ELSE
         CALL s_tax_count(l_xrca.xrcasite,l_xrcb.xrcb020,g_xrcf3_d[l_ac].xrcf123,g_xrcf_d[l_ac].xrcf007,l_xrca.xrca100,l_xrca.xrca101)
            RETURNING g_xrcf3_d[l_ac].xrcf123,g_xrcf3_d[l_ac].xrcf124,g_xrcf3_d[l_ac].xrcf125,l_amt1,l_amt2,l_amt3
      END IF
   END IF

   IF p_type = 'lit3' THEN
      IF l_oodb005 = 'Y' THEN
         CALL s_tax_count(l_xrca.xrcasite,l_xrcb.xrcb020,g_xrcf3_d[l_ac].xrcf135,g_xrcf_d[l_ac].xrcf007,l_xrca.xrca100,l_xrca.xrca101)
            RETURNING g_xrcf3_d[l_ac].xrcf133,g_xrcf3_d[l_ac].xrcf134,g_xrcf3_d[l_ac].xrcf135,l_amt1,l_amt2,l_amt3
      ELSE
         CALL s_tax_count(l_xrca.xrcasite,l_xrcb.xrcb020,g_xrcf3_d[l_ac].xrcf133,g_xrcf_d[l_ac].xrcf007,l_xrca.xrca100,l_xrca.xrca101)
            RETURNING g_xrcf3_d[l_ac].xrcf133,g_xrcf3_d[l_ac].xrcf134,g_xrcf3_d[l_ac].xrcf135,l_amt1,l_amt2,l_amt3
      END IF
   END IF

   IF p_type <> 'lit2' AND p_type <> 'lit3' THEN
      IF g_glaa.glaa015 = 'Y' THEN
         #計算本位幣二金額
         IF g_glaa.glaa017 = '1' THEN
            #换算基准:交易原幣
            CALL s_axrt300_exrate(g_glaa.glaa002,l_xrca.xrcadocdt,l_xrca.xrca100,g_glaa.glaa016,g_xrcf_d[l_ac].xrcf103,l_xrca.xrca121,g_glaa.glaacomp)
               RETURNING l_success,g_xrcf3_d[l_ac].xrcf123
            CALL s_axrt300_exrate(g_glaa.glaa002,l_xrca.xrcadocdt,l_xrca.xrca100,g_glaa.glaa016,g_xrcf_d[l_ac].xrcf104,l_xrca.xrca121,g_glaa.glaacomp)
               RETURNING l_success,g_xrcf3_d[l_ac].xrcf124
            CALL s_axrt300_exrate(g_glaa.glaa002,l_xrca.xrcadocdt,l_xrca.xrca100,g_glaa.glaa016,g_xrcf_d[l_ac].xrcf105,l_xrca.xrca121,g_glaa.glaacomp)
               RETURNING l_success,g_xrcf3_d[l_ac].xrcf125
         ELSE
            #换算基准:帳簿幣別
            CALL s_axrt300_exrate(g_glaa.glaa002,l_xrca.xrcadocdt,g_glaa.glaa001,g_glaa.glaa016,g_xrcf_d[l_ac].xrcf103,l_xrca.xrca121,g_glaa.glaacomp)
               RETURNING l_success,g_xrcf3_d[l_ac].xrcf123
            CALL s_axrt300_exrate(g_glaa.glaa002,l_xrca.xrcadocdt,g_glaa.glaa001,g_glaa.glaa016,g_xrcf_d[l_ac].xrcf104,l_xrca.xrca121,g_glaa.glaacomp)
               RETURNING l_success,g_xrcf3_d[l_ac].xrcf124
            CALL s_axrt300_exrate(g_glaa.glaa002,l_xrca.xrcadocdt,g_glaa.glaa001,g_glaa.glaa016,g_xrcf_d[l_ac].xrcf105,l_xrca.xrca121,g_glaa.glaacomp)
               RETURNING l_success,g_xrcf3_d[l_ac].xrcf125
         END IF
      ELSE
         LET g_xrcf3_d[l_ac].xrcf123 = 0
         LET g_xrcf3_d[l_ac].xrcf124 = 0
         LET g_xrcf3_d[l_ac].xrcf125 = 0
      END IF

      IF g_glaa.glaa019 = 'Y' THEN
         #計算本位幣三金額
         IF g_glaa.glaa021 = '1' THEN
            #换算基准:交易原幣
            CALL s_axrt300_exrate(g_glaa.glaa002,l_xrca.xrcadocdt,l_xrca.xrca100,g_glaa.glaa016,g_xrcf_d[l_ac].xrcf103,l_xrca.xrca131,g_glaa.glaacomp)
               RETURNING l_success,g_xrcf3_d[l_ac].xrcf133
            CALL s_axrt300_exrate(g_glaa.glaa002,l_xrca.xrcadocdt,l_xrca.xrca100,g_glaa.glaa016,g_xrcf_d[l_ac].xrcf104,l_xrca.xrca131,g_glaa.glaacomp)
               RETURNING l_success,g_xrcf3_d[l_ac].xrcf134
            CALL s_axrt300_exrate(g_glaa.glaa002,l_xrca.xrcadocdt,l_xrca.xrca100,g_glaa.glaa016,g_xrcf_d[l_ac].xrcf105,l_xrca.xrca131,g_glaa.glaacomp)
               RETURNING l_success,g_xrcf3_d[l_ac].xrcf135
         ELSE
            #换算基准:帳簿幣別
            CALL s_axrt300_exrate(g_glaa.glaa002,l_xrca.xrcadocdt,g_glaa.glaa001,g_glaa.glaa016,g_xrcf_d[l_ac].xrcf103,l_xrca.xrca131,g_glaa.glaacomp)
               RETURNING l_success,g_xrcf3_d[l_ac].xrcf133
            CALL s_axrt300_exrate(g_glaa.glaa002,l_xrca.xrcadocdt,g_glaa.glaa001,g_glaa.glaa016,g_xrcf_d[l_ac].xrcf104,l_xrca.xrca131,g_glaa.glaacomp)
               RETURNING l_success,g_xrcf3_d[l_ac].xrcf134
            CALL s_axrt300_exrate(g_glaa.glaa002,l_xrca.xrcadocdt,g_glaa.glaa001,g_glaa.glaa016,g_xrcf_d[l_ac].xrcf105,l_xrca.xrca131,g_glaa.glaacomp)
               RETURNING l_success,g_xrcf3_d[l_ac].xrcf135
         END IF
      ELSE
         LET g_xrcf3_d[l_ac].xrcf133 = 0
         LET g_xrcf3_d[l_ac].xrcf134 = 0
         LET g_xrcf3_d[l_ac].xrcf135 = 0
      END IF
   END IF

   IF g_glaa.glaa015 = 'Y' THEN
      #計算本位幣二金額
      LET g_xrcf3_d[l_ac].xrcf122 = l_xrca.xrca121
   END IF
   IF g_glaa.glaa019 = 'Y' THEN
      #計算本位幣三金額
      LET g_xrcf3_d[l_ac].xrcf132 = l_xrca.xrca131
   END IF

   DISPLAY g_xrcf_d[l_ac].xrcf007, g_xrcf_d[l_ac].xrcf101, g_xrcf_d[l_ac].xrcf103, g_xrcf_d[l_ac].xrcf104, g_xrcf_d[l_ac].xrcf105,
           g_xrcf_d[l_ac].xrcf111, g_xrcf_d[l_ac].xrcf113, g_xrcf_d[l_ac].xrcf114, g_xrcf_d[l_ac].xrcf115
        TO s_detail2[l_ac].xrcf007,s_detail2[l_ac].xrcf101,s_detail2[l_ac].xrcf103,s_detail2[l_ac].xrcf104,s_detail2[l_ac].xrcf105,
           s_detail2[l_ac].xrcf111,s_detail2[l_ac].xrcf113,s_detail2[l_ac].xrcf114,s_detail2[l_ac].xrcf115

   LET g_xrcf3_d[l_ac].xrcf105 = g_xrcf_d[l_ac].xrcf105
   
   DISPLAY g_xrcf3_d[l_ac].xrcf105,g_xrcf3_d[l_ac].xrcf122,
           g_xrcf3_d[l_ac].xrcf123,g_xrcf3_d[l_ac].xrcf124,g_xrcf3_d[l_ac].xrcf125,
           g_xrcf3_d[l_ac].xrcf132,g_xrcf3_d[l_ac].xrcf133,g_xrcf3_d[l_ac].xrcf134,
           g_xrcf3_d[l_ac].xrcf135
        TO s_detail4[l_ac].xrcf105,s_detail4[l_ac].xrcf122,
           s_detail4[l_ac].xrcf123,s_detail4[l_ac].xrcf124,s_detail4[l_ac].xrcf125,
           s_detail4[l_ac].xrcf132,s_detail4[l_ac].xrcf133,s_detail4[l_ac].xrcf134,
           s_detail4[l_ac].xrcf135


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
PRIVATE FUNCTION axrt300_06_diff()
   DEFINE l_diff      type_diff   #暫估金額合計(沖暫估金額)
   DEFINE d_diff      type_diff   #暫估金額合計(差異金額)
   DEFINE t_diff      type_diff   #立帳金額合計(沖暫估為'Y')
   DEFINE l_xrcf      type_xrcf
   DEFINE l_sql       STRING
   DEFINE l_xrca007   LIKE xrca_t.xrca007
   DEFINE l_glaa015   LIKE glaa_t.glaa015
   DEFINE l_glaa019   LIKE glaa_t.glaa019
   DEFINE l_glaacomp  LIKE glaa_t.glaacomp
   DEFINE l_sfin2011  LIKE type_t.chr1        #迴轉否
   DEFINE l_sfin2012  LIKE type_t.chr1
   DEFINE l_flag      LIKE type_t.chr1


   WHENEVER ERROR CONTINUE

   CALL cl_get_para(g_enterprise,g_glaa.glaacomp,'S-FIN-2011') RETURNING l_sfin2011
   CALL cl_get_para(g_enterprise,g_glaa.glaacomp,'S-FIN-2012') RETURNING l_sfin2012
   IF l_sfin2011 = 'N' THEN LET l_sfin2012 = '1' END IF

   SELECT xrca007 INTO l_xrca007 FROM xrca_t WHERE xrcaent = g_enterprise
      AND xrcadocno = g_xrcadocno
      AND xrcald    = g_xrcald

   CALL s_ld_sel_glaa(g_xrcald,'glaacomp|glaa015|glaa019')
        RETURNING  g_sub_success,l_glaacomp,l_glaa015,l_glaa019

   #此時可能修改過沖暫估資料,所以只能以整體的角度去看暫估差異

   INITIALIZE l_diff TO NULL
   INITIALIZE t_diff TO NULL

   LET l_sql =" SELECT ABS(SUM(xrcf103 * xrcb022)),ABS(SUM(xrcf104 * xrcb022)),ABS(SUM(xrcf105 * xrcb022)),        " CLIPPED,
              "        ABS(SUM(xrcf113 * xrcb022)),ABS(SUM(xrcf114 * xrcb022)),ABS(SUM(xrcf115 * xrcb022)),        " CLIPPED,
              "        ABS(SUM(xrcf123 * xrcb022)),ABS(SUM(xrcf124 * xrcb022)),ABS(SUM(xrcf125 * xrcb022)),        " CLIPPED,
              "        ABS(SUM(xrcf133 * xrcb022)),ABS(SUM(xrcf134 * xrcb022)),ABS(SUM(xrcf135 * xrcb022))         " CLIPPED,
              "   FROM xrcf_t,xrcb_t                                                                               " CLIPPED,
              "  WHERE xrcfent = xrcbent        AND xrcf008 = xrcbdocno            AND xrcf009 = xrcbseq           " CLIPPED,
              "    AND xrcfld  = '",g_xrcald,"' AND xrcfdocno = '",g_xrcadocno,"'  AND xrcfent = '",g_enterprise,"'" CLIPPED,
              "    AND xrcf008 <> 'DIFF'                                                                           "
   PREPARE axrt300_06_diff1 FROM l_sql
   EXECUTE axrt300_06_diff1 INTO l_diff.xrcf103,l_diff.xrcf104,l_diff.xrcf105,l_diff.xrcf113,l_diff.xrcf114,l_diff.xrcf115,
                                 l_diff.xrcf123,l_diff.xrcf124,l_diff.xrcf125,l_diff.xrcf133,l_diff.xrcf134,l_diff.xrcf135

   IF cl_null(l_diff.xrcf103) THEN LET l_diff.xrcf103 = 0 END IF   IF cl_null(l_diff.xrcf123) THEN LET l_diff.xrcf123 = 0 END IF
   IF cl_null(l_diff.xrcf104) THEN LET l_diff.xrcf104 = 0 END IF   IF cl_null(l_diff.xrcf124) THEN LET l_diff.xrcf124 = 0 END IF
   IF cl_null(l_diff.xrcf105) THEN LET l_diff.xrcf105 = 0 END IF   IF cl_null(l_diff.xrcf125) THEN LET l_diff.xrcf125 = 0 END IF
   IF cl_null(l_diff.xrcf113) THEN LET l_diff.xrcf113 = 0 END IF   IF cl_null(l_diff.xrcf133) THEN LET l_diff.xrcf133 = 0 END IF
   IF cl_null(l_diff.xrcf114) THEN LET l_diff.xrcf114 = 0 END IF   IF cl_null(l_diff.xrcf134) THEN LET l_diff.xrcf134 = 0 END IF
   IF cl_null(l_diff.xrcf115) THEN LET l_diff.xrcf115 = 0 END IF   IF cl_null(l_diff.xrcf135) THEN LET l_diff.xrcf135 = 0 END IF

   LET l_sql =" SELECT ABS(SUM(xrcb103 * xrcb022)),ABS(SUM(xrcb104 * xrcb022)),ABS(SUM(xrcb105 * xrcb022)),        " CLIPPED,
              "        ABS(SUM(xrcb113 * xrcb022)),ABS(SUM(xrcb114 * xrcb022)),ABS(SUM(xrcb115 * xrcb022)),        " CLIPPED,
              "        ABS(SUM(xrcb123 * xrcb022)),ABS(SUM(xrcb124 * xrcb022)),ABS(SUM(xrcb125 * xrcb022)),        " CLIPPED,
              "        ABS(SUM(xrcb133 * xrcb022)),ABS(SUM(xrcb134 * xrcb022)),ABS(SUM(xrcb135 * xrcb022))         " CLIPPED,
              "   FROM xrcb_t                                                                                      " CLIPPED,
              "  WHERE xrcbld  = '",g_xrcald,"' AND xrcbdocno = '",g_xrcadocno,"'  AND xrcbent = '",g_enterprise,"'" CLIPPED,
			  "    AND xrcb023 = 'Y'                                                                               " CLIPPED
   PREPARE axrt300_06_diff2 FROM l_sql
   EXECUTE axrt300_06_diff2 INTO t_diff.xrcf103,t_diff.xrcf104,t_diff.xrcf105,t_diff.xrcf113,t_diff.xrcf114,t_diff.xrcf115,
                                 t_diff.xrcf123,t_diff.xrcf124,t_diff.xrcf125,t_diff.xrcf133,t_diff.xrcf134,t_diff.xrcf135

   IF cl_null(t_diff.xrcf103) THEN LET t_diff.xrcf103 = 0 END IF   IF cl_null(t_diff.xrcf123) THEN LET t_diff.xrcf123 = 0 END IF
   IF cl_null(t_diff.xrcf104) THEN LET t_diff.xrcf104 = 0 END IF   IF cl_null(t_diff.xrcf124) THEN LET t_diff.xrcf124 = 0 END IF
   IF cl_null(t_diff.xrcf105) THEN LET t_diff.xrcf105 = 0 END IF   IF cl_null(t_diff.xrcf125) THEN LET t_diff.xrcf125 = 0 END IF
   IF cl_null(t_diff.xrcf113) THEN LET t_diff.xrcf113 = 0 END IF   IF cl_null(t_diff.xrcf133) THEN LET t_diff.xrcf133 = 0 END IF
   IF cl_null(t_diff.xrcf114) THEN LET t_diff.xrcf114 = 0 END IF   IF cl_null(t_diff.xrcf134) THEN LET t_diff.xrcf134 = 0 END IF
   IF cl_null(t_diff.xrcf115) THEN LET t_diff.xrcf115 = 0 END IF   IF cl_null(t_diff.xrcf135) THEN LET t_diff.xrcf135 = 0 END IF

   LET l_sql =" SELECT SUM(xrcf103),SUM(xrcf104),SUM(xrcf105),                         " CLIPPED,
              "        SUM(xrcf113),SUM(xrcf114),SUM(xrcf115),                         " CLIPPED,
              "        SUM(xrcf123),SUM(xrcf124),SUM(xrcf125),                         " CLIPPED,
              "        SUM(xrcf133),SUM(xrcf134),SUM(xrcf135)                          " CLIPPED,
              "   FROM xrcf_t                                                          " CLIPPED,
              "  WHERE xrcfld  = '",g_xrcald,"'       AND xrcfdocno = '",g_xrcadocno,"'" CLIPPED,
			     "    AND xrcfent = '",g_enterprise,"'   AND xrcf008 = 'DIFF'             " CLIPPED
   PREPARE axrt300_06_diff3 FROM l_sql
   EXECUTE axrt300_06_diff3 INTO d_diff.xrcf103,d_diff.xrcf104,d_diff.xrcf105,d_diff.xrcf113,d_diff.xrcf114,d_diff.xrcf115,
                                 d_diff.xrcf123,d_diff.xrcf124,d_diff.xrcf125,d_diff.xrcf133,d_diff.xrcf134,d_diff.xrcf135

   IF cl_null(d_diff.xrcf103) THEN LET d_diff.xrcf103 = 0 END IF   IF cl_null(d_diff.xrcf123) THEN LET d_diff.xrcf123 = 0 END IF
   IF cl_null(d_diff.xrcf104) THEN LET d_diff.xrcf104 = 0 END IF   IF cl_null(d_diff.xrcf124) THEN LET d_diff.xrcf124 = 0 END IF
   IF cl_null(d_diff.xrcf105) THEN LET d_diff.xrcf105 = 0 END IF   IF cl_null(d_diff.xrcf125) THEN LET d_diff.xrcf125 = 0 END IF
   IF cl_null(d_diff.xrcf113) THEN LET d_diff.xrcf113 = 0 END IF   IF cl_null(d_diff.xrcf133) THEN LET d_diff.xrcf133 = 0 END IF
   IF cl_null(d_diff.xrcf114) THEN LET d_diff.xrcf114 = 0 END IF   IF cl_null(d_diff.xrcf134) THEN LET d_diff.xrcf134 = 0 END IF
   IF cl_null(d_diff.xrcf115) THEN LET d_diff.xrcf115 = 0 END IF   IF cl_null(d_diff.xrcf135) THEN LET d_diff.xrcf135 = 0 END IF

   LET l_flag = 'N'

   IF l_sfin2012 = '1' THEN
      LET l_diff.xrcf113 = l_diff.xrcf113 + d_diff.xrcf113 - t_diff.xrcf113
      LET l_diff.xrcf123 = l_diff.xrcf123 + d_diff.xrcf123 - t_diff.xrcf123
      LET l_diff.xrcf133 = l_diff.xrcf133 + d_diff.xrcf133 - t_diff.xrcf133
      IF l_diff.xrcf113 > 0                     THEN LET l_flag = 'Y' END IF
      IF l_diff.xrcf123 > 0 AND l_glaa015 = 'Y' THEN LET l_flag = 'Y' END IF
      IF l_diff.xrcf133 > 0 AND l_glaa019 = 'Y' THEN LET l_flag = 'Y' END IF
   ELSE
      LET l_diff.xrcf113 = l_diff.xrcf115 + d_diff.xrcf115 - t_diff.xrcf115
      LET l_diff.xrcf123 = l_diff.xrcf125 + d_diff.xrcf125 - t_diff.xrcf125
      LET l_diff.xrcf133 = l_diff.xrcf135 + d_diff.xrcf135 - t_diff.xrcf135
      IF l_diff.xrcf113 > 0                     THEN LET l_flag = 'Y' END IF
      IF l_diff.xrcf123 > 0 AND l_glaa015 = 'Y' THEN LET l_flag = 'Y' END IF
      IF l_diff.xrcf133 > 0 AND l_glaa019 = 'Y' THEN LET l_flag = 'Y' END IF
   END IF

   IF l_flag = 'Y' THEN
      IF NOT cl_ask_confirm('aap-00211') THEN
         CALL axrt300_06_b_fill(' 1=1')
         RETURN
      END IF
   #161212-00024#1 Add  ---(S)---
   ELSE
      CALL axrt300_06_b_fill(' 1=1')
      RETURN
   #161212-00024#1 Add  ---(E)---
   END IF

   CALL s_transaction_begin()

   INITIALIZE l_xrcf.* TO NULL

   SELECT MAX(xrcfseq) + 1 INTO l_xrcf.xrcfseq
     FROM xrcf_t
    WHERE xrcfent  = g_enterprise AND xrcfld = g_xrcald
     AND xrcfdocno = g_xrcadocno
   IF cl_null(l_xrcf.xrcfseq) THEN LET l_xrcf.xrcfseq = 1 END IF
   LET l_xrcf.xrcfent   = g_enterprise
   LET l_xrcf.xrcfld    = g_xrcald
   LET l_xrcf.xrcforga  = l_glaacomp
   LET l_xrcf.xrcfdocno = g_xrcadocno
   LET l_xrcf.xrcfseq2  = 0
   LET l_xrcf.xrcf001 = 'axrt300'
   LET l_xrcf.xrcf002 = '01'              #固定值
   LET l_xrcf.xrcf007 = 1
   LET l_xrcf.xrcf008 = 'DIFF'
   LET l_xrcf.xrcf009 = 0
   LET l_xrcf.xrcf010 = 0
   LET l_xrcf.xrcf020 = ''
   LET l_xrcf.xrcf022 = ''
   LET l_xrcf.xrcf023 = ''
   LET l_xrcf.xrcf024 = ''
   LET l_xrcf.xrcf025 = ''
   LET l_xrcf.xrcf022 = ''
   LET l_xrcf.xrcf101 = 0
   LET l_xrcf.xrcf104 = 0
   LET l_xrcf.xrcf106 = 0
   LET l_xrcf.xrcf111 = 0
   LET l_xrcf.xrcf114 = 0
   LET l_xrcf.xrcf116 = 0
   LET l_xrcf.xrcf117 = 0
   LET l_xrcf.xrcf113 = l_diff.xrcf113
   LET l_xrcf.xrcf114 = 0
   LET l_xrcf.xrcf115 = l_xrcf.xrcf113          #含稅未稅相同
   LET l_xrcf.xrcf123 = l_diff.xrcf123
   LET l_xrcf.xrcf124 = 0
   LET l_xrcf.xrcf125 = l_xrcf.xrcf113
   LET l_xrcf.xrcf133 = l_diff.xrcf133
   LET l_xrcf.xrcf134 = 0
   LET l_xrcf.xrcf135 = l_xrcf.xrcf133
   LET l_xrcf.xrcf103 = l_xrcf.xrcf113
   LET l_xrcf.xrcf104 = 0
   LET l_xrcf.xrcf105 = l_xrcf.xrcf115
   CALL s_fin_get_account(g_xrcald,'13',l_xrca007,'8304_11') RETURNING g_sub_success,l_xrcf.xrcf021,g_errno

   INSERT INTO xrcf_t (xrcfent,xrcfld,xrcfdocno,xrcfseq,xrcfseq2,xrcforga,
                       xrcf001,xrcf002,xrcf007,xrcf008,xrcf009,xrcf010,xrcf020,xrcf021,
                       xrcf022,xrcf023,xrcf024,xrcf025,xrcf026,xrcf027,xrcf028,xrcf029,
                       xrcf030,xrcf031,xrcf032,xrcf033,xrcf034,xrcf035,xrcf036,xrcf037,
                       xrcf038,xrcf039,xrcf040,xrcf041,xrcf042,xrcf043,xrcf044,xrcf045,
                       xrcf046,xrcf047,xrcf048,xrcf049,xrcf101,xrcf102,xrcf103,xrcf104,
                       xrcf105,xrcf106,xrcf111,xrcf113,xrcf114,xrcf115,xrcf116,xrcf117,
                       xrcf122,xrcf123,xrcf124,xrcf125,xrcf126,xrcf127,xrcf132,xrcf133,
                       xrcf134,xrcf135,xrcf136,xrcf137
                      )
                VALUES(l_xrcf.xrcfent,l_xrcf.xrcfld,l_xrcf.xrcfdocno,l_xrcf.xrcfseq,l_xrcf.xrcfseq2,l_xrcf.xrcforga,
                       l_xrcf.xrcf001,l_xrcf.xrcf002,l_xrcf.xrcf007,l_xrcf.xrcf008,l_xrcf.xrcf009,l_xrcf.xrcf010,l_xrcf.xrcf020,l_xrcf.xrcf021,
                       l_xrcf.xrcf022,l_xrcf.xrcf023,l_xrcf.xrcf024,l_xrcf.xrcf025,l_xrcf.xrcf026,l_xrcf.xrcf027,l_xrcf.xrcf028,l_xrcf.xrcf029,
                       l_xrcf.xrcf030,l_xrcf.xrcf031,l_xrcf.xrcf032,l_xrcf.xrcf033,l_xrcf.xrcf034,l_xrcf.xrcf035,l_xrcf.xrcf036,l_xrcf.xrcf037,
                       l_xrcf.xrcf038,l_xrcf.xrcf039,l_xrcf.xrcf040,l_xrcf.xrcf041,l_xrcf.xrcf042,l_xrcf.xrcf043,l_xrcf.xrcf044,l_xrcf.xrcf045,
                       l_xrcf.xrcf046,l_xrcf.xrcf047,l_xrcf.xrcf048,l_xrcf.xrcf049,l_xrcf.xrcf101,l_xrcf.xrcf102,l_xrcf.xrcf103,l_xrcf.xrcf104,
                       l_xrcf.xrcf105,l_xrcf.xrcf106,l_xrcf.xrcf111,l_xrcf.xrcf113,l_xrcf.xrcf114,l_xrcf.xrcf115,l_xrcf.xrcf116,l_xrcf.xrcf117,
                       l_xrcf.xrcf122,l_xrcf.xrcf123,l_xrcf.xrcf124,l_xrcf.xrcf125,l_xrcf.xrcf126,l_xrcf.xrcf127,l_xrcf.xrcf132,l_xrcf.xrcf133,
                       l_xrcf.xrcf134,l_xrcf.xrcf135,l_xrcf.xrcf136,l_xrcf.xrcf137)
   IF SQLCA.SQLERRD[3] <> '1' THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = l_xrcf.xrcfdocno,":",SQLERRMESSAGE  
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      CALL s_transaction_end('N','0')
   ELSE
      CALL s_transaction_end('Y','0')
   END IF

   CALL axrt300_06_b_fill(' 1=1')

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
PRIVATE FUNCTION axrt300_06_get_glab(p_glabld,p_glab001,p_glab002,p_glab003)
   DEFINE p_glabld         LIKE glab_t.glabld
   DEFINE p_glab001        LIKE glab_t.glab001
   DEFINE p_glab002        LIKE glab_t.glab002
   DEFINE p_glab003        LIKE glab_t.glab003
   
   DEFINE r_glab005        LIKE glab_t.glab005

   SELECT glab005 INTO r_glab005 FROM glab_t
    WHERE glabent = g_enterprise AND glabld = p_glabld AND glab001 = p_glab001 AND glab002 = p_glab002 AND glab003 = p_glab003

   RETURN r_glab005

END FUNCTION

################################################################################
# Descriptions...: 自由核算項檢查
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
PRIVATE FUNCTION axrt300_06_free_account_chk(p_glaf001,p_glaf002,p_ctrl)
   DEFINE p_glaf001      LIKE glaf_t.glaf001
   DEFINE p_glaf002      LIKE glaf_t.glaf002
   DEFINE p_ctrl         LIKE type_t.chr5       #控制方式1.1.允许空白，2：必输不需检查或，3：必输需要检查
   DEFINE r_errno        LIKE type_t.chr10      #错误编号
   DEFINE l_glafstus     LIKE glaf_t.glafstus
   DEFINE l_glae002      LIKE glae_t.glae002
   DEFINE l_glae003      LIKE glae_t.glae003
   DEFINE l_glae004      LIKE glae_t.glae004
   DEFINE l_cnt          LIKE type_t.num5
   DEFINE l_sql          STRING
   
      LET r_errno = ''
      LET l_glae002 = ''
      LET l_glae003 = ''
      LET l_glae004 = ''
      #.抓出該类型对应的资料来源，来源档案，来源编号栏位
      SELECT glae002,glae003,glae004 INTO l_glae002,l_glae003,l_glae004 FROM glae_t
       WHERE glaeent = g_enterprise
         AND glae001 = p_glaf001
      #来源类型为1.‘基本资料’，則檢核來源編號欄位是否存在,並依核算项类型对应的控制方式，檢核核算项值的合理性
      IF l_glae002 = '1' THEN
         SELECT count(*) INTO l_cnt FROM dzeb_t
          WHERE dzeb001 = l_glae003
            AND dzeb002 = l_glae004
         IF l_cnt = 0  THEN
            LET r_errno = 'agl-00073'
            RETURN r_errno
         END IF
         #控制方式3：必输必检查
         IF p_ctrl = '3'  THEN
            #1.检查资料的有效存在
             LET l_cnt = 0
             CALL axrt300_06_make_sql(l_glae003,l_glae004,p_glaf002) RETURNING l_sql
             PREPARE anmt530_03_chk  FROM l_sql
             EXECUTE anmt530_03_chk INTO l_cnt             
             IF  l_cnt = 0  THEN
                 LET r_errno = 'agl-00099'
                 RETURN r_errno
             END IF
             #IF  l_glafstus = 'N'  THEN
             #    LET g_errno = 'agl-00063'
             #    RETURN r_errno
             #END IF
         END IF
      END IF
      #来源类型为2.预设值，則輸入值應檢核是否存在自由核算項資料檔,並依核算项类型对应的控制方式，檢核核算项值的合理性
      IF l_glae002 = '2' THEN
         SELECT glafstus INTO l_glafstus FROM glaf_t
             WHERE glafent = g_enterprise
               AND glaf001 = p_glaf001
               AND glaf002 = p_glaf002
         IF SQLCA.SQLCODE = 100  THEN
            LET r_errno = 'agl-00062'
            RETURN r_errno
          END IF
          IF p_ctrl = '3'  THEN
             IF l_glafstus = 'N'  THEN
#                LET g_errno = 'agl-00063'   #160318-00005#53  mark
                LET r_errno = 'sub-01302'    #160318-00005#53  add
                RETURN r_errno
             END IF
          END IF
      END IF
      #若来源类型为3.'自行輸入'則user可任意輸入且不需檢核
      RETURN r_errno
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
PRIVATE FUNCTION axrt300_06_make_sql(p_glae003,p_glae004,p_glaf002)
   DEFINE p_glae003 LIKE glae_t.glae003    #来源档案
   DEFINE p_glae004 LIKE glae_t.glae004    #来源编号栏位
   DEFINE p_glaf002 LIKE glaf_t.glaf002    #核算项值
   DEFINE l_dzeb002 LIKE dzeb_t.dzeb002
   DEFINE l_dzeb006 LIKE dzeb_t.dzeb006
   DEFINE l_sql     STRING
   DEFINE r_sql     STRING

   LET r_sql = " SELECT count(*) FROM ",p_glae003 ,
               "  WHERE ", p_glae004," = '",p_glaf002,"'"
               
   LET l_sql = "SELECT dzeb002,dzeb006 FROM dzeb_t ",
               " WHERE dzeb001 = '", p_glae003,"'"
   PREPARE anmt311_make_sql_pre FROM l_sql
   DECLARE anmt311_make_sql_cs CURSOR FOR anmt311_make_sql_pre
   FOREACH anmt311_make_sql_cs INTO l_dzeb002,l_dzeb006
      #判断是否有ent栏位
      IF l_dzeb006 = 'N802' THEN
         LET r_sql = r_sql CLIPPED," AND ",l_dzeb002 ," ='",g_enterprise,"' "
      END IF
      #判断是否有stus栏位
      IF l_dzeb002 LIKE '%stus'  THEN
         LET r_sql = r_sql CLIPPED," AND ",l_dzeb002 ," ='Y'"
      END IF
   END FOREACH
   RETURN r_sql
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
PRIVATE FUNCTION axrt300_06_xrcf028_chk(p_oocq001,p_oocq002)
   DEFINE p_oocq001     LIKE oocq_t.oocq001
   DEFINE p_oocq002     LIKE oocq_t.oocq002
   DEFINE l_oocqstus     LIKE oocq_t.oocqstus
   
   LET g_errno = ''
   SELECT oocqstus INTO l_oocqstus FROM oocq_t
    WHERE oocqent = g_enterprise
      AND oocq001 = p_oocq001
      AND oocq002 = p_oocq002
   CASE
     WHEN SQLCA.SQLCODE = 100 
        IF p_oocq001 = '287' THEN      
#           LET g_errno = 'apm-00092'   #160318-00005#53  mark
           LET g_errno = 'sub-01303'    #160318-00005#53  add
        ELSE
           LET g_errno = 'axm-00003'  
        END IF 
     
     WHEN l_oocqstus = 'N'
        IF p_oocq001 = '287' THEN    
#           LET g_errno = 'apm-00093'  #160318-00005#53  mark
           LET g_errno = 'sub-01302'   #160318-00005#53  add
        ELSE
#           LET g_errno = 'axm-00004'   #160318-00005#53  mark
           LET g_errno = 'sub-01302'    #160318-00005#53  add
        END IF       
   END CASE
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
PRIVATE FUNCTION axrt300_06_xrcb012_chk(p_xrcb012)
  DEFINE p_xrcb012   LIKE xrcb_t.xrcb012
  DEFINE l_rtaxstus  LIKE rtax_t.rtaxstus

  LET g_errno = ''
  SELECT rtaxstus INTO l_rtaxstus FROM rtax_t
   WHERE rtaxent = g_enterprise
     AND rtax001 = p_xrcb012

  CASE
     WHEN SQLCA.SQLCODE = 100   LET g_errno = 'aoo-00137'
#     WHEN l_rtaxstus = 'N'      LET g_errno = 'aoo-00138'  #160318-00005#53  mark
     WHEN l_rtaxstus = 'N'      LET g_errno = 'sub-01302'   #160318-00005#53  add
  END CASE
END FUNCTION
#核算项说明
#如果栏位对应的核算项类型对应的资料来源为‘1’，则自组sql来抓取说明
PRIVATE FUNCTION axrt300_06_free_account_desc()
    DEFINE l_glae002     LIKE glae_t.glae002     #资料来源
    DEFINE l_sql         STRING                  #组的抓取资料的sql
   
   #核算项一
   LET l_glae002 = ''
   LET l_sql = ''
   SELECT glae002 INTO l_glae002 FROM glae_t
    WHERE glaeent = g_enterprise
      AND glae001 = g_glad.glad0171
   IF l_glae002 = '2' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] =g_glad.glad0171
      LET g_ref_fields[2] =g_xrcf4_d[l_ac].xrcf039
      CALL ap_ref_array2(g_ref_fields,"SELECT glafl004 FROM glafl_t WHERE glaflent='"||g_enterprise||"' AND glafl001=? AND glafl002=? AND glafl003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_xrcf4_d[l_ac].xrcf039_desc= g_rtn_fields[1]
      LET g_xrcf4_d[l_ac].xrcf039_desc = g_xrcf4_d[l_ac].xrcf039,' ',g_xrcf4_d[l_ac].xrcf039_desc 
   ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_xrcf4_d[l_ac].xrcf039
      CALL axrt300_06_make_sql_desc(g_glad.glad0171) RETURNING l_sql
      CALL ap_ref_array2(g_ref_fields,l_sql,"") RETURNING g_rtn_fields
      LET g_xrcf4_d[l_ac].xrcf039_desc= g_rtn_fields[1]
      LET g_xrcf4_d[l_ac].xrcf039_desc = g_xrcf4_d[l_ac].xrcf039,' ',g_xrcf4_d[l_ac].xrcf039_desc 
   END IF 
 
   #核算项二
   LET l_glae002 = ''
   LET l_sql = ''
   SELECT glae002 INTO l_glae002 FROM glae_t
    WHERE glaeent = g_enterprise
      AND glae001 = g_glad.glad0181
   IF l_glae002 = '2' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] =g_glad.glad0181
      LET g_ref_fields[2] =g_xrcf4_d[l_ac].xrcf040  
      CALL ap_ref_array2(g_ref_fields,"SELECT glafl004 FROM glafl_t WHERE glaflent='"||g_enterprise||"' AND glafl001=? AND glafl002=? AND glafl003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_xrcf4_d[l_ac].xrcf040_desc= g_rtn_fields[1]
      LET g_xrcf4_d[l_ac].xrcf040_desc = g_xrcf4_d[l_ac].xrcf040,' ',g_xrcf4_d[l_ac].xrcf040_desc 
   ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_xrcf4_d[l_ac].xrcf040
      CALL axrt300_06_make_sql_desc(g_glad.glad0181) RETURNING l_sql
      CALL ap_ref_array2(g_ref_fields,l_sql,"") RETURNING g_rtn_fields
      LET g_xrcf4_d[l_ac].xrcf040_desc= g_rtn_fields[1]
      LET g_xrcf4_d[l_ac].xrcf040_desc = g_xrcf4_d[l_ac].xrcf040,' ',g_xrcf4_d[l_ac].xrcf040_desc 
   END IF   
 
   #核算项三
   LET l_glae002 = ''
   LET l_sql = ''
   SELECT glae002 INTO l_glae002 FROM glae_t
    WHERE glaeent = g_enterprise
      AND glae001 = g_glad.glad0191
   IF l_glae002 = '2' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] =g_glad.glad0191
      LET g_ref_fields[2] =g_xrcf4_d[l_ac].xrcf041
      CALL ap_ref_array2(g_ref_fields,"SELECT glafl004 FROM glafl_t WHERE glaflent='"||g_enterprise||"' AND glafl001=? AND glafl002=? AND glafl003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_xrcf4_d[l_ac].xrcf041_desc= g_rtn_fields[1]
      LET g_xrcf4_d[l_ac].xrcf041_desc = g_xrcf4_d[l_ac].xrcf041,' ',g_xrcf4_d[l_ac].xrcf041_desc 
   ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_xrcf4_d[l_ac].xrcf041
      CALL axrt300_06_make_sql_desc(g_glad.glad0191) RETURNING l_sql
      CALL ap_ref_array2(g_ref_fields,l_sql,"") RETURNING g_rtn_fields
      LET g_xrcf4_d[l_ac].xrcf041_desc= g_rtn_fields[1]   
      LET g_xrcf4_d[l_ac].xrcf041_desc = g_xrcf4_d[l_ac].xrcf041,' ',g_xrcf4_d[l_ac].xrcf041_desc 
   END IF     
  
   #核算项四
   LET l_glae002 = ''
   LET l_sql = ''
   SELECT glae002 INTO l_glae002 FROM glae_t
    WHERE glaeent = g_enterprise
      AND glae001 = g_glad.glad0201
   IF l_glae002 = '2' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] =g_glad.glad0201
      LET g_ref_fields[2] =g_xrcf4_d[l_ac].xrcf042
      CALL ap_ref_array2(g_ref_fields,"SELECT glafl004 FROM glafl_t WHERE glaflent='"||g_enterprise||"' AND glafl001=? AND glafl002=? AND glafl003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_xrcf4_d[l_ac].xrcf042_desc= g_rtn_fields[1]
      LET g_xrcf4_d[l_ac].xrcf042_desc = g_xrcf4_d[l_ac].xrcf042,' ',g_xrcf4_d[l_ac].xrcf042_desc 
    ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_xrcf4_d[l_ac].xrcf042
      CALL axrt300_06_make_sql_desc(g_glad.glad0201) RETURNING l_sql
      CALL ap_ref_array2(g_ref_fields,l_sql,"") RETURNING g_rtn_fields
      LET g_xrcf4_d[l_ac].xrcf042_desc= g_rtn_fields[1]   
      LET g_xrcf4_d[l_ac].xrcf042_desc = g_xrcf4_d[l_ac].xrcf042,' ',g_xrcf4_d[l_ac].xrcf042_desc 
   END IF   
   
   #核算项五
   LET l_glae002 = ''
   LET l_sql = ''
   SELECT glae002 INTO l_glae002 FROM glae_t
    WHERE glaeent = g_enterprise
      AND glae001 = g_glad.glad0211
   IF l_glae002 = '2' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] =g_glad.glad0211
      LET g_ref_fields[2] =g_xrcf4_d[l_ac].xrcf043
      CALL ap_ref_array2(g_ref_fields,"SELECT glafl004 FROM glafl_t WHERE glaflent='"||g_enterprise||"' AND glafl001=? AND glafl002=? AND glafl003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_xrcf4_d[l_ac].xrcf043_desc= g_rtn_fields[1]  
      LET g_xrcf4_d[l_ac].xrcf043_desc = g_xrcf4_d[l_ac].xrcf043,' ',g_xrcf4_d[l_ac].xrcf043_desc 
   ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_xrcf4_d[l_ac].xrcf043
      CALL axrt300_06_make_sql_desc(g_glad.glad0211) RETURNING l_sql
      CALL ap_ref_array2(g_ref_fields,l_sql,"") RETURNING g_rtn_fields
      LET g_xrcf4_d[l_ac].xrcf043_desc= g_rtn_fields[1]   
      LET g_xrcf4_d[l_ac].xrcf043_desc = g_xrcf4_d[l_ac].xrcf043,' ',g_xrcf4_d[l_ac].xrcf043_desc 
   END IF    
 
   #核算项六
   LET l_glae002 = ''
   LET l_sql = ''
   SELECT glae002 INTO l_glae002 FROM glae_t
    WHERE glaeent = g_enterprise
      AND glae001 = g_glad.glad0221
   IF l_glae002 = '2' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] =g_glad.glad0221
      LET g_ref_fields[2] =g_xrcf4_d[l_ac].xrcf044
      CALL ap_ref_array2(g_ref_fields,"SELECT glafl004 FROM glafl_t WHERE glaflent='"||g_enterprise||"' AND glafl001=? AND glafl002=? AND glafl003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_xrcf4_d[l_ac].xrcf044_desc= g_rtn_fields[1]
      LET g_xrcf4_d[l_ac].xrcf044_desc = g_xrcf4_d[l_ac].xrcf044,' ',g_xrcf4_d[l_ac].xrcf044_desc 
   ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_xrcf4_d[l_ac].xrcf044
      CALL axrt300_06_make_sql_desc(g_glad.glad0221) RETURNING l_sql
      CALL ap_ref_array2(g_ref_fields,l_sql,"") RETURNING g_rtn_fields
      LET g_xrcf4_d[l_ac].xrcf044_desc= g_rtn_fields[1]  
      LET g_xrcf4_d[l_ac].xrcf044_desc = g_xrcf4_d[l_ac].xrcf044,' ',g_xrcf4_d[l_ac].xrcf044_desc 
   END IF    
   
   #核算项七
   LET l_glae002 = ''
   LET l_sql = ''
   SELECT glae002 INTO l_glae002 FROM glae_t
    WHERE glaeent = g_enterprise
      AND glae001 = g_glad.glad0231
   IF l_glae002 = '2' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] =g_glad.glad0231
      LET g_ref_fields[2] =g_xrcf4_d[l_ac].xrcf045
      CALL ap_ref_array2(g_ref_fields,"SELECT glafl004 FROM glafl_t WHERE glaflent='"||g_enterprise||"' AND glafl001=? AND glafl002=? AND glafl003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_xrcf4_d[l_ac].xrcf045_desc= g_rtn_fields[1]
      LET g_xrcf4_d[l_ac].xrcf045_desc = g_xrcf4_d[l_ac].xrcf045,' ',g_xrcf4_d[l_ac].xrcf045_desc
   ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_xrcf4_d[l_ac].xrcf045
      CALL axrt300_06_make_sql_desc(g_glad.glad0241) RETURNING l_sql
      CALL ap_ref_array2(g_ref_fields,l_sql,"") RETURNING g_rtn_fields
      LET g_xrcf4_d[l_ac].xrcf045_desc= g_rtn_fields[1]  
      LET g_xrcf4_d[l_ac].xrcf045_desc = g_xrcf4_d[l_ac].xrcf045,' ',g_xrcf4_d[l_ac].xrcf045_desc 
   END IF     
  
   #核算项八
   LET l_glae002 = ''
   LET l_sql = ''
   SELECT glae002 INTO l_glae002 FROM glae_t
    WHERE glaeent = g_enterprise
      AND glae001 = g_glad.glad0241
   IF l_glae002 = '2' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] =g_glad.glad0241
      LET g_ref_fields[2] =g_xrcf4_d[l_ac].xrcf046
      CALL ap_ref_array2(g_ref_fields,"SELECT glafl004 FROM glafl_t WHERE glaflent='"||g_enterprise||"' AND glafl001=? AND glafl002=? AND glafl003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_xrcf4_d[l_ac].xrcf046_desc= g_rtn_fields[1]
      LET g_xrcf4_d[l_ac].xrcf046_desc = g_xrcf4_d[l_ac].xrcf046,' ',g_xrcf4_d[l_ac].xrcf046_desc
   ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_xrcf4_d[l_ac].xrcf046
      CALL axrt300_06_make_sql_desc(g_glad.glad0241) RETURNING l_sql
      CALL ap_ref_array2(g_ref_fields,l_sql,"") RETURNING g_rtn_fields
      LET g_xrcf4_d[l_ac].xrcf046_desc= g_rtn_fields[1]   
      LET g_xrcf4_d[l_ac].xrcf046_desc = g_xrcf4_d[l_ac].xrcf046,' ',g_xrcf4_d[l_ac].xrcf046_desc
   END IF     
  
   #核算项九
   LET l_glae002 = ''
   LET l_sql = ''
   SELECT glae002 INTO l_glae002 FROM glae_t
    WHERE glaeent = g_enterprise
      AND glae001 = g_glad.glad0251
   IF l_glae002 = '2' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] =g_glad.glad0251
      LET g_ref_fields[2] =g_xrcf4_d[l_ac].xrcf047
      CALL ap_ref_array2(g_ref_fields,"SELECT glafl004 FROM glafl_t WHERE glaflent='"||g_enterprise||"' AND glafl001=? AND glafl002=? AND glafl003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_xrcf4_d[l_ac].xrcf047_desc= g_rtn_fields[1]
      LET g_xrcf4_d[l_ac].xrcf047_desc = g_xrcf4_d[l_ac].xrcf047,' ',g_xrcf4_d[l_ac].xrcf047_desc
   ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_xrcf4_d[l_ac].xrcf047
      CALL axrt300_06_make_sql_desc(g_glad.glad0251) RETURNING l_sql
      CALL ap_ref_array2(g_ref_fields,l_sql,"") RETURNING g_rtn_fields
      LET g_xrcf4_d[l_ac].xrcf047_desc= g_rtn_fields[1]   
      LET g_xrcf4_d[l_ac].xrcf047_desc = g_xrcf4_d[l_ac].xrcf047,' ',g_xrcf4_d[l_ac].xrcf047_desc
   END IF  
  
   #核算项十
   LET l_glae002 = ''
   LET l_sql = ''
   SELECT glae002 INTO l_glae002 FROM glae_t
    WHERE glaeent = g_enterprise
      AND glae001 = g_glad.glad0261
   IF l_glae002 = '2' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] =g_glad.glad0261
      LET g_ref_fields[2] =g_xrcf4_d[l_ac].xrcf048
      CALL ap_ref_array2(g_ref_fields,"SELECT glafl004 FROM glafl_t WHERE glaflent='"||g_enterprise||"' AND glafl001=? AND glafl002=? AND glafl003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_xrcf4_d[l_ac].xrcf048_desc= g_rtn_fields[1]
      LET g_xrcf4_d[l_ac].xrcf048_desc = g_xrcf4_d[l_ac].xrcf048,' ',g_xrcf4_d[l_ac].xrcf048_desc
   ELSE
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_xrcf4_d[l_ac].xrcf048
      CALL axrt300_06_make_sql_desc(g_glad.glad0261) RETURNING l_sql
      CALL ap_ref_array2(g_ref_fields,l_sql,"") RETURNING g_rtn_fields
      LET g_xrcf4_d[l_ac].xrcf048_desc= g_rtn_fields[1]   
      LET g_xrcf4_d[l_ac].xrcf048_desc = g_xrcf4_d[l_ac].xrcf048,' ',g_xrcf4_d[l_ac].xrcf048_desc
   END IF
END FUNCTION
# 核算项说明
PRIVATE FUNCTION axrt300_06_make_sql_desc(p_glae001)
   DEFINE p_glae001   LIKE glae_t.glae001   #核算项类型
   #DEFINE p_field_value   LIKE glaf_t.glaf002   #核算项值
   DEFINE r_sql       STRING
   DEFINE l_glae003   LIKE glae_t.glae003   #来源档案
   DEFINE l_glae004   LIKE glae_t.glae004   #来源编号栏位
   DEFINE l_glae005   LIKE glae_t.glae005   #来源说明档案
   DEFINE l_glae006   LIKE glae_t.glae006   #来源说明栏位
   DEFINE l_dzeb002   LIKE dzeb_t.dzeb002   #栏位代号
   DEFINE l_dzeb006   LIKE dzeb_t.dzeb002   #栏位属性
   DEFINE l_sql     STRING
   DEFINE li_sql1   STRING    #抓主档表的key
   DEFINE li_sql2   STRING    #抓对应多语言表的key
   #抓取主表的key放入数组
   DEFINE li_main    DYNAMIC ARRAY OF RECORD
          dzeb002    LIKE dzeb_t.dzeb002
   END RECORD
   #抓取多语言表的key放入数组
   DEFINE li_dlang    DYNAMIC ARRAY OF RECORD
          dzeb002    LIKE dzeb_t.dzeb002
   END RECORD
   DEFINE l_where   STRING    #组出的对应的抓取说明的where条件
   DEFINE l_i,l_i2,l_i3       LIKE type_t.num5

    #初始化
    CALL li_main.clear()
    CALL li_dlang.clear()

   #抓取来源档案，来源说明档案，来源说明栏位
   SELECT glae003,glae004,glae005,glae006 INTO l_glae003,l_glae004,l_glae005,l_glae006 FROM glae_t
    WHERE glaeent = g_enterprise
      AND glae001 = p_glae001

   #抓取主档key
   LET l_i = 1
   LET li_sql1 = " SELECT dzeb002 FROM dzeb_t ",
                 "  WHERE dzeb001 = '",l_glae003,"'",
                 "    AND dzeb004 = 'Y'",
                 "  ORDER BY dzeb021 "
   PREPARE anmt470_pr FROM li_sql1
   DECLARE anmt470_cs1 CURSOR FOR anmt470_pr
   FOREACH anmt470_cs1 INTO li_main[l_i].dzeb002
       LET l_i = l_i +1
   END FOREACH
   #真实数组长度
   LET l_i = l_i -1

   #抓取多语言档key
   LET l_i2 = 1
   LET li_sql2 = " SELECT dzeb002 FROM dzeb_t ",
                 " WHERE dzeb001 = '",l_glae005,"'" ,
                  "  AND dzeb004 = 'Y'",
                 " ORDER BY dzeb021 "
   PREPARE anmt470_pr2 FROM li_sql2
   DECLARE anmt470_cs2 CURSOR FOR anmt470_pr2
   FOREACH anmt470_cs2 INTO li_dlang[l_i2].dzeb002
       LET l_i2 = l_i2 +1
   END FOREACH
   #真实数组长度
   LET l_i2 = l_i2 -1


   #组合where条件
   LET l_where = '1=1'
   FOR  l_i3 = 1 TO  l_i
       LET l_where = l_where," AND ", li_main[l_i3].dzeb002, " = " ,li_dlang[l_i3].dzeb002
   END FOR

   #组出的基础sql
   LET r_sql = " SELECT ", l_glae006 ," FROM ",l_glae005 ,',',l_glae003,
               " WHERE " , l_glae004," = ?",
               "   AND " ,l_where
   #组sql
   LET l_sql = "SELECT dzeb002,dzeb006 FROM dzeb_t ",
               " WHERE dzeb001 = '",l_glae005,"'",
               "   AND dzeb004 = 'Y'"
   PREPARE anmt470_make_sql_pre1 FROM l_sql
   DECLARE anmt470_make_sql_cs1 CURSOR FOR anmt470_make_sql_pre1
   FOREACH anmt470_make_sql_cs1 INTO l_dzeb002,l_dzeb006
      #判断是否有ent栏位
      IF l_dzeb006 = 'N802' THEN
         LET r_sql = r_sql CLIPPED," AND ",l_dzeb002 ," ='",g_enterprise,"' "
      END IF

      IF l_dzeb006 = 'C800' THEN
         LET r_sql = r_sql CLIPPED," AND ",l_dzeb002 ," ='",g_dlang,"' "
      END IF

   END FOREACH
   RETURN r_sql

END FUNCTION

################################################################################
# Descriptions...: 檢查立帳單單身選擇的沖暫估金額和暫估金額是否相等
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2015、05、19 By 01727
# Modify.........:
################################################################################
PRIVATE FUNCTION axrt300_06_chk()
   DEFINE l_xrcf103      LIKE xrcf_t.xrcf103
   DEFINE l_xrcf104      LIKE xrcf_t.xrcf104
   DEFINE l_xrcf105      LIKE xrcf_t.xrcf105
   DEFINE l_xrcf113      LIKE xrcf_t.xrcf113
   DEFINE l_xrcf114      LIKE xrcf_t.xrcf114
   DEFINE l_xrcf115      LIKE xrcf_t.xrcf115
   DEFINE l_xrcf123      LIKE xrcf_t.xrcf123
   DEFINE l_xrcf124      LIKE xrcf_t.xrcf124
   DEFINE l_xrcf125      LIKE xrcf_t.xrcf125
   DEFINE l_xrcf133      LIKE xrcf_t.xrcf133
   DEFINE l_xrcf134      LIKE xrcf_t.xrcf134
   DEFINE l_xrcf135      LIKE xrcf_t.xrcf135
   DEFINE l_xrcb103      LIKE xrcb_t.xrcb103
   DEFINE l_xrcb104      LIKE xrcb_t.xrcb104
   DEFINE l_xrcb105      LIKE xrcb_t.xrcb105
   DEFINE l_xrcb113      LIKE xrcb_t.xrcb113
   DEFINE l_xrcb114      LIKE xrcb_t.xrcb114
   DEFINE l_xrcb115      LIKE xrcb_t.xrcb115
   DEFINE l_xrcb123      LIKE xrcb_t.xrcb123
   DEFINE l_xrcb124      LIKE xrcb_t.xrcb124
   DEFINE l_xrcb125      LIKE xrcb_t.xrcb125
   DEFINE l_xrcb133      LIKE xrcb_t.xrcb133
   DEFINE l_xrcb134      LIKE xrcb_t.xrcb134
   DEFINE l_xrcb135      LIKE xrcb_t.xrcb135
   DEFINE l_flag         LIKE type_t.chr1
   DEFINE l_glaa015      LIKE glaa_t.glaa015   #161212-00024#1 Add
   DEFINE l_glaa019      LIKE glaa_t.glaa019   #161212-00024#1 Add
   DEFINE l_sfin2011     LIKE type_t.chr1      #161212-00024#1 Add
   DEFINE l_sfin2012     LIKE type_t.chr1      #161212-00024#1 Add

   LET l_xrcf103 = 0   LET l_xrcf104 = 0   LET l_xrcf105 = 0
   LET l_xrcf113 = 0   LET l_xrcf114 = 0   LET l_xrcf115 = 0
   LET l_xrcf123 = 0   LET l_xrcf124 = 0   LET l_xrcf125 = 0
   LET l_xrcf133 = 0   LET l_xrcf134 = 0   LET l_xrcf135 = 0

   LET l_xrcb103 = 0   LET l_xrcb104 = 0   LET l_xrcb105 = 0
   LET l_xrcb113 = 0   LET l_xrcb114 = 0   LET l_xrcb115 = 0
   LET l_xrcb123 = 0   LET l_xrcb124 = 0   LET l_xrcb125 = 0
   LET l_xrcb133 = 0   LET l_xrcb134 = 0   LET l_xrcb135 = 0

   SELECT SUM(xrcf103),SUM(xrcf104),SUM(xrcf105),SUM(xrcf113),SUM(xrcf114),SUM(xrcf115),
          SUM(xrcf123),SUM(xrcf124),SUM(xrcf125),SUM(xrcf133),SUM(xrcf134),SUM(xrcf135)
     INTO l_xrcf103,   l_xrcf104,   l_xrcf105,   l_xrcf113,   l_xrcf114,   l_xrcf115,
          l_xrcf123,   l_xrcf124,   l_xrcf125,   l_xrcf133,   l_xrcf134,   l_xrcf135
     FROM xrcf_t a
    WHERE xrcfent   = g_enterprise AND xrcfld = g_xrcald
      AND xrcfdocno = g_xrcadocno

   IF cl_null(l_xrcf103) THEN LET l_xrcf103 = 0 END IF   IF cl_null(l_xrcf113) THEN LET l_xrcf113 = 0 END IF
   IF cl_null(l_xrcf104) THEN LET l_xrcf104 = 0 END IF   IF cl_null(l_xrcf114) THEN LET l_xrcf114 = 0 END IF
   IF cl_null(l_xrcf105) THEN LET l_xrcf105 = 0 END IF   IF cl_null(l_xrcf115) THEN LET l_xrcf115 = 0 END IF
   IF cl_null(l_xrcf123) THEN LET l_xrcf123 = 0 END IF   IF cl_null(l_xrcf133) THEN LET l_xrcf133 = 0 END IF
   IF cl_null(l_xrcf124) THEN LET l_xrcf124 = 0 END IF   IF cl_null(l_xrcf134) THEN LET l_xrcf134 = 0 END IF
   IF cl_null(l_xrcf125) THEN LET l_xrcf125 = 0 END IF   IF cl_null(l_xrcf135) THEN LET l_xrcf135 = 0 END IF

   SELECT SUM(xrcb103),SUM(xrcb104),SUM(xrcb105),SUM(xrcb113),SUM(xrcb114),SUM(xrcb115),
          SUM(xrcb123),SUM(xrcb124),SUM(xrcb125),SUM(xrcb133),SUM(xrcb134),SUM(xrcb135)
     INTO l_xrcb103,   l_xrcb104,   l_xrcb105,   l_xrcb113,   l_xrcb114,   l_xrcb115,
          l_xrcb123,   l_xrcb124,   l_xrcb125,   l_xrcb133,   l_xrcb134,   l_xrcb135
     FROM xrcb_t a
    WHERE xrcbent   = g_enterprise AND xrcbld = g_xrcald
      AND xrcbdocno = g_xrcadocno

   IF cl_null(l_xrcb103) THEN LET l_xrcb103 = 0 END IF   IF cl_null(l_xrcb113) THEN LET l_xrcb113 = 0 END IF
   IF cl_null(l_xrcb104) THEN LET l_xrcb104 = 0 END IF   IF cl_null(l_xrcb114) THEN LET l_xrcb114 = 0 END IF
   IF cl_null(l_xrcb105) THEN LET l_xrcb105 = 0 END IF   IF cl_null(l_xrcb115) THEN LET l_xrcb115 = 0 END IF
   IF cl_null(l_xrcb123) THEN LET l_xrcb123 = 0 END IF   IF cl_null(l_xrcb133) THEN LET l_xrcb133 = 0 END IF
   IF cl_null(l_xrcb124) THEN LET l_xrcb124 = 0 END IF   IF cl_null(l_xrcb134) THEN LET l_xrcb134 = 0 END IF
   IF cl_null(l_xrcb125) THEN LET l_xrcb125 = 0 END IF   IF cl_null(l_xrcb135) THEN LET l_xrcb135 = 0 END IF

   #161212-00024#1 Add  ---(S)---
   SELECT glaa015,glaa019 INTO l_glaa015,l_glaa019 FROM glaa_t WHERE glaaent = g_enterprise
      AND glaald = g_xrcald

   CALL cl_get_para(g_enterprise,g_glaa.glaacomp,'S-FIN-2011') RETURNING l_sfin2011
   CALL cl_get_para(g_enterprise,g_glaa.glaacomp,'S-FIN-2012') RETURNING l_sfin2012
   IF l_sfin2011 = 'N' THEN LET l_sfin2012 = '1' END IF
   #161212-00024#1 Add  ---(E)---

   LET l_flag = 'Y'
   #161212-00024#1 Mark ---(S)---
  #IF l_xrcf103 <> l_xrcb103 THEN LET l_flag = 'N' END IF
  #IF l_xrcf104 <> l_xrcb104 THEN LET l_flag = 'N' END IF
  #IF l_xrcf105 <> l_xrcb105 THEN LET l_flag = 'N' END IF
  #IF l_xrcf113 <> l_xrcb113 THEN LET l_flag = 'N' END IF
  #IF l_xrcf114 <> l_xrcb114 THEN LET l_flag = 'N' END IF
  #IF l_xrcf115 <> l_xrcb115 THEN LET l_flag = 'N' END IF
  #IF l_xrcf123 <> l_xrcb123 THEN LET l_flag = 'N' END IF
  #IF l_xrcf124 <> l_xrcb124 THEN LET l_flag = 'N' END IF
  #IF l_xrcf125 <> l_xrcb125 THEN LET l_flag = 'N' END IF
  #IF l_xrcf133 <> l_xrcb133 THEN LET l_flag = 'N' END IF
  #IF l_xrcf134 <> l_xrcb134 THEN LET l_flag = 'N' END IF
  #IF l_xrcf135 <> l_xrcb135 THEN LET l_flag = 'N' END IF
   #161212-00024#1 Mark ---(E)---
   #161212-00024#1 Add  ---(S)---
   IF l_sfin2012 = '1' THEN
      IF l_xrcf103 <> l_xrcb103 THEN LET l_flag = 'N' END IF
      IF l_xrcf113 <> l_xrcb113 THEN LET l_flag = 'N' END IF
      IF l_glaa015 = 'Y' THEN
         IF l_xrcf123 <> l_xrcb123 THEN LET l_flag = 'N' END IF
      END IF
      IF l_glaa019 = 'Y' THEN
         IF l_xrcf133 <> l_xrcb133 THEN LET l_flag = 'N' END IF
      END IF
   ELSE
      IF l_xrcf105 <> l_xrcb105 THEN LET l_flag = 'N' END IF
      IF l_xrcf115 <> l_xrcb115 THEN LET l_flag = 'N' END IF
      IF l_glaa015 = 'Y' THEN
         IF l_xrcf125 <> l_xrcb125 THEN LET l_flag = 'N' END IF
      END IF
      IF l_glaa019 = 'Y' THEN
         IF l_xrcf135 <> l_xrcb135 THEN LET l_flag = 'N' END IF
      END IF
   END IF
   #161212-00024#1 Add  ---(E)---

   IF l_flag = 'N' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'axr-00322'
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
PRIVATE FUNCTION axrt300_06_execuet(p_chr)
   DEFINE p_chr         LIKE type_t.chr1
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_xrcbld      LIKE xrcb_t.xrcbld
   DEFINE l_xrcbdocno   LIKE xrcb_t.xrcbdocno
   DEFINE l_xrcbseq     LIKE xrcb_t.xrcbseq
   DEFINE l_xrcb023     LIKE xrcb_t.xrcb023
   DEFINE l_sql         STRING

   IF cl_null(p_chr) THEN RETURN END IF
 
   #160816-00014#3 del xrcbseq
   LET l_sql = "SELECT DISTINCT xrcbld,xrcbdocno FROM xrcb_t WHERE xrcbent = '",g_enterprise,"'",
               "   AND xrcbdocno = '",g_xrcadocno,"'",
               "   AND xrcbld = '",g_xrcald,"'",
               "   AND xrcb023 = 'Y'"
   PREPARE axrt300_06_xrcb_prep FROM l_sql
   DECLARE axrt300_06_xrcb_curs CURSOR FOR axrt300_06_xrcb_prep

   LET l_success = TRUE
   CALL s_transaction_begin()
   DELETE FROM xrcf_t WHERE xrcfent = g_enterprise AND xrcfdocno = g_xrcadocno AND xrcfld = g_xrcald

   IF p_chr = '1' THEN   #整批新增
      FOREACH axrt300_06_xrcb_curs INTO l_xrcbld,l_xrcbdocno,l_xrcbseq
         CALL s_axrp130_ins_xrcf(l_xrcbld,l_xrcbdocno,l_xrcbseq,0) RETURNING l_xrcb023 #150203-00010#4 Mod
      END FOREACH
   END IF

   CALL s_transaction_end('Y','0')

END FUNCTION

 
{</section>}
 
