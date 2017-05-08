#該程式未解開Section, 採用最新樣板產出!
{<section id="astt840.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0013(2016-11-09 15:40:17), PR版次:0013(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000041
#+ Filename...: astt840
#+ Description: 租賃結算單維護作業
#+ Creator....: 02749(2016-04-24 15:06:14)
#+ Modifier...: 07142 -SD/PR- 00000
 
{</section>}
 
{<section id="astt840.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#160509-00004#30 by liyan 2016/5/26 整單操作增加發票補登功能
#add by geza 20160802 #160728-00006#15 增加楼栋楼层区域
#160816-00068#15 2016/08/18 By earl     調整transaction
#160818-00017#41 2016-08-23 By 08734 删除修改未重新判断状态码
#161024-00025#4   2016/10/24 by 08172   组织调整
#161024-00025#2  2016/10/25 By dongsz   stbf015开窗改为q_ooef001_24，where条件:ooef203='Y',栏位检查相应修改;stbe036开窗改为q_ooef001_24
#160824-00007#210  2016/11/18   By 06137    修正舊值備份寫法
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
PRIVATE type type_g_stbd_m        RECORD
       stbdsite LIKE stbd_t.stbdsite, 
   stbdsite_desc LIKE type_t.chr80, 
   stbddocdt LIKE stbd_t.stbddocdt, 
   stbddocno LIKE stbd_t.stbddocno, 
   stbd037 LIKE stbd_t.stbd037, 
   stbd037_desc LIKE type_t.chr80, 
   stbd002 LIKE stbd_t.stbd002, 
   stbd002_desc LIKE type_t.chr80, 
   stbd046 LIKE stbd_t.stbd046, 
   stbd046_desc LIKE type_t.chr80, 
   stbd000 LIKE stbd_t.stbd000, 
   stbd001 LIKE stbd_t.stbd001, 
   stbd041 LIKE stbd_t.stbd041, 
   stbdunit LIKE stbd_t.stbdunit, 
   stbdunit_desc LIKE type_t.chr80, 
   stbd048 LIKE stbd_t.stbd048, 
   stbd048_desc LIKE type_t.chr80, 
   stbd049 LIKE stbd_t.stbd049, 
   stbd049_desc LIKE type_t.chr80, 
   stbd050 LIKE stbd_t.stbd050, 
   stbd050_desc LIKE type_t.chr80, 
   stbd003 LIKE stbd_t.stbd003, 
   stbd043 LIKE stbd_t.stbd043, 
   stbd044 LIKE stbd_t.stbd044, 
   stbd004 LIKE stbd_t.stbd004, 
   l_stjo002 LIKE type_t.dat, 
   stbd005 LIKE stbd_t.stbd005, 
   stbd006 LIKE stbd_t.stbd006, 
   stbd038 LIKE stbd_t.stbd038, 
   stbd060 LIKE stbd_t.stbd060, 
   stbd033 LIKE stbd_t.stbd033, 
   stbdstus LIKE stbd_t.stbdstus, 
   stbdownid LIKE stbd_t.stbdownid, 
   stbdownid_desc LIKE type_t.chr80, 
   stbdowndp LIKE stbd_t.stbdowndp, 
   stbdowndp_desc LIKE type_t.chr80, 
   stbdcrtid LIKE stbd_t.stbdcrtid, 
   stbdcrtid_desc LIKE type_t.chr80, 
   stbdcrtdp LIKE stbd_t.stbdcrtdp, 
   stbdcrtdp_desc LIKE type_t.chr80, 
   stbdcrtdt LIKE stbd_t.stbdcrtdt, 
   stbdmodid LIKE stbd_t.stbdmodid, 
   stbdmodid_desc LIKE type_t.chr80, 
   stbdmoddt LIKE stbd_t.stbdmoddt, 
   stbdcnfid LIKE stbd_t.stbdcnfid, 
   stbdcnfid_desc LIKE type_t.chr80, 
   stbdcnfdt LIKE stbd_t.stbdcnfdt, 
   stbd007 LIKE stbd_t.stbd007, 
   stbd052 LIKE stbd_t.stbd052, 
   stbd051 LIKE stbd_t.stbd051, 
   stbd053 LIKE stbd_t.stbd053, 
   stbd008 LIKE stbd_t.stbd008, 
   stbd054 LIKE stbd_t.stbd054, 
   stbd009 LIKE stbd_t.stbd009, 
   stbd055 LIKE stbd_t.stbd055, 
   stbd010 LIKE stbd_t.stbd010, 
   stbd056 LIKE stbd_t.stbd056, 
   stbd011 LIKE stbd_t.stbd011, 
   stbd057 LIKE stbd_t.stbd057, 
   stbd012 LIKE stbd_t.stbd012, 
   stbd058 LIKE stbd_t.stbd058, 
   stbd013 LIKE stbd_t.stbd013, 
   stbd059 LIKE stbd_t.stbd059, 
   stbd014 LIKE stbd_t.stbd014, 
   stbd017 LIKE stbd_t.stbd017, 
   stbd018 LIKE stbd_t.stbd018, 
   stbd016 LIKE stbd_t.stbd016, 
   stbd019 LIKE stbd_t.stbd019, 
   stbd045 LIKE stbd_t.stbd045, 
   stbd015 LIKE stbd_t.stbd015, 
   stbd040 LIKE stbd_t.stbd040, 
   stbd039 LIKE stbd_t.stbd039, 
   stbd020 LIKE stbd_t.stbd020, 
   stbd042 LIKE stbd_t.stbd042, 
   stbd021 LIKE stbd_t.stbd021, 
   stbd021_desc LIKE type_t.chr80, 
   stbd022 LIKE stbd_t.stbd022, 
   stbd022_desc LIKE type_t.chr80, 
   stje019 LIKE stje_t.stje019, 
   stje019_desc LIKE type_t.chr80, 
   stje020 LIKE stje_t.stje020, 
   stje020_desc LIKE type_t.chr80, 
   stje021 LIKE stje_t.stje021, 
   stje021_desc LIKE type_t.chr80, 
   stbd023 LIKE stbd_t.stbd023, 
   stbd023_desc LIKE type_t.chr80, 
   stbd024 LIKE stbd_t.stbd024, 
   stbd025 LIKE stbd_t.stbd025, 
   stbd025_desc LIKE type_t.chr80, 
   stbd026 LIKE stbd_t.stbd026, 
   stbd027 LIKE stbd_t.stbd027, 
   stbd028 LIKE stbd_t.stbd028, 
   stbd029 LIKE stbd_t.stbd029, 
   stbd030 LIKE stbd_t.stbd030, 
   stbd030_desc LIKE type_t.chr80, 
   stbd031 LIKE stbd_t.stbd031, 
   stbd032 LIKE stbd_t.stbd032, 
   stbd034 LIKE stbd_t.stbd034, 
   stbd035 LIKE stbd_t.stbd035, 
   stbd036 LIKE stbd_t.stbd036, 
   stbd047 LIKE stbd_t.stbd047
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_stbe_d        RECORD
       stbeseq LIKE stbe_t.stbeseq, 
   stbe001 LIKE stbe_t.stbe001, 
   stbe002 LIKE stbe_t.stbe002, 
   stbe003 LIKE stbe_t.stbe003, 
   stbe004 LIKE stbe_t.stbe004, 
   stbe028 LIKE stbe_t.stbe028, 
   stbe028_desc LIKE type_t.chr500, 
   stbe005 LIKE stbe_t.stbe005, 
   stbe005_desc LIKE type_t.chr500, 
   stbe035 LIKE stbe_t.stbe035, 
   stbe036 LIKE stbe_t.stbe036, 
   stbe036_desc LIKE type_t.chr500, 
   stbe024 LIKE stbe_t.stbe024, 
   stbe025 LIKE stbe_t.stbe025, 
   l_stae003 LIKE type_t.chr10, 
   l_stae003_desc LIKE type_t.chr500, 
   stbe006 LIKE stbe_t.stbe006, 
   stbe007 LIKE stbe_t.stbe007, 
   stbe008 LIKE stbe_t.stbe008, 
   stbe008_desc LIKE type_t.chr500, 
   stbe009 LIKE stbe_t.stbe009, 
   stbe009_desc LIKE type_t.chr500, 
   stbe010 LIKE stbe_t.stbe010, 
   stbe011 LIKE stbe_t.stbe011, 
   stbe012 LIKE stbe_t.stbe012, 
   stbe013 LIKE stbe_t.stbe013, 
   stbe014 LIKE stbe_t.stbe014, 
   stbe015 LIKE stbe_t.stbe015, 
   stbe016 LIKE stbe_t.stbe016, 
   stbe026 LIKE stbe_t.stbe026, 
   stbe027 LIKE stbe_t.stbe027, 
   stbe017 LIKE stbe_t.stbe017, 
   stbe017_desc LIKE type_t.chr500, 
   stbe018 LIKE stbe_t.stbe018, 
   stbe033 LIKE stbe_t.stbe033, 
   stbe031 LIKE stbe_t.stbe031, 
   stbe034 LIKE stbe_t.stbe034, 
   stbesite LIKE stbe_t.stbesite, 
   stbesite_desc LIKE type_t.chr500, 
   stbe020 LIKE stbe_t.stbe020, 
   stbe020_desc LIKE type_t.chr500, 
   stbe019 LIKE stbe_t.stbe019, 
   stbe019_desc LIKE type_t.chr500, 
   stbe032 LIKE stbe_t.stbe032, 
   stbecomp LIKE stbe_t.stbecomp, 
   stbe021 LIKE stbe_t.stbe021, 
   stbe022 LIKE stbe_t.stbe022, 
   stbe023 LIKE stbe_t.stbe023
       END RECORD
PRIVATE TYPE type_g_stbe2_d RECORD
       stbfseq LIKE stbf_t.stbfseq, 
   stbf001 LIKE stbf_t.stbf001, 
   stbf002 LIKE stbf_t.stbf002, 
   stbf003 LIKE stbf_t.stbf003, 
   stbf004 LIKE stbf_t.stbf004, 
   stbf004_desc LIKE type_t.chr500, 
   stbf005 LIKE stbf_t.stbf005, 
   stbf009 LIKE stbf_t.stbf009, 
   stbf010 LIKE stbf_t.stbf010, 
   stbf006 LIKE stbf_t.stbf006, 
   stbf007 LIKE stbf_t.stbf007, 
   stbf008 LIKE stbf_t.stbf008, 
   stbf011 LIKE stbf_t.stbf011, 
   stbf012 LIKE stbf_t.stbf012, 
   stbfcomp LIKE stbf_t.stbfcomp, 
   stbfsite LIKE stbf_t.stbfsite, 
   stbf013 LIKE stbf_t.stbf013, 
   stbf014 LIKE stbf_t.stbf014, 
   stbf015 LIKE stbf_t.stbf015, 
   stbf015_desc LIKE type_t.chr500, 
   stbf016 LIKE stbf_t.stbf016
       END RECORD
PRIVATE TYPE type_g_stbe4_d RECORD
       stbeseq LIKE stbe_t.stbeseq, 
   stbe001 LIKE stbe_t.stbe001, 
   stbe002 LIKE stbe_t.stbe002, 
   stbe003 LIKE stbe_t.stbe003, 
   stbe004 LIKE stbe_t.stbe004, 
   stbe028 LIKE stbe_t.stbe028, 
   stbe028_1_desc LIKE type_t.chr500, 
   stbe005 LIKE stbe_t.stbe005, 
   stbe005_1_desc LIKE type_t.chr500, 
   stbe035 LIKE stbe_t.stbe035, 
   stbe036 LIKE stbe_t.stbe036, 
   stbe036_1_desc LIKE type_t.chr500, 
   stbe024 LIKE stbe_t.stbe024, 
   stbe025 LIKE stbe_t.stbe025, 
   l_stae003_1 LIKE type_t.chr10, 
   l_stae003_1_desc LIKE type_t.chr500, 
   stbe006 LIKE stbe_t.stbe006, 
   stbe007 LIKE stbe_t.stbe007, 
   stbe008 LIKE stbe_t.stbe008, 
   stbe008_1_desc LIKE type_t.chr500, 
   stbe009 LIKE stbe_t.stbe009, 
   stbe009_1_desc LIKE type_t.chr500, 
   stbe010 LIKE stbe_t.stbe010, 
   stbe011 LIKE stbe_t.stbe011, 
   stbe012 LIKE stbe_t.stbe012, 
   stbe013 LIKE stbe_t.stbe013, 
   stbe014 LIKE stbe_t.stbe014, 
   stbe015 LIKE stbe_t.stbe015, 
   stbe016 LIKE stbe_t.stbe016, 
   stbe026 LIKE stbe_t.stbe026, 
   stbe027 LIKE stbe_t.stbe027, 
   stbe017 LIKE stbe_t.stbe017, 
   stbe017_1_desc LIKE type_t.chr500, 
   stbe018 LIKE stbe_t.stbe018, 
   stbe033 LIKE stbe_t.stbe033, 
   stbe031 LIKE stbe_t.stbe031, 
   stbe034 LIKE stbe_t.stbe034, 
   stbesite LIKE stbe_t.stbesite, 
   stbesite_1_desc LIKE type_t.chr500, 
   stbe020 LIKE stbe_t.stbe020, 
   stbe020_1_desc LIKE type_t.chr500, 
   stbe019 LIKE stbe_t.stbe019, 
   stbe019_1_desc LIKE type_t.chr500, 
   stbe032 LIKE stbe_t.stbe032, 
   stbecomp LIKE stbe_t.stbecomp, 
   stbe021 LIKE stbe_t.stbe021, 
   stbe022 LIKE stbe_t.stbe022, 
   stbe023 LIKE stbe_t.stbe023
       END RECORD
PRIVATE TYPE type_g_stbe5_d RECORD
       stbeseq LIKE stbe_t.stbeseq, 
   stbe001 LIKE stbe_t.stbe001, 
   stbe002 LIKE stbe_t.stbe002, 
   stbe003 LIKE stbe_t.stbe003, 
   stbe004 LIKE stbe_t.stbe004, 
   stbe028 LIKE stbe_t.stbe028, 
   stbe028_2_desc LIKE type_t.chr500, 
   stbe005 LIKE stbe_t.stbe005, 
   stbe005_2_desc LIKE type_t.chr500, 
   stbe035 LIKE stbe_t.stbe035, 
   stbe036 LIKE stbe_t.stbe036, 
   stbe036_2_desc LIKE type_t.chr500, 
   stbe024 LIKE stbe_t.stbe024, 
   stbe025 LIKE stbe_t.stbe025, 
   l_stae003_2 LIKE type_t.chr10, 
   l_stae003_2_desc LIKE type_t.chr500, 
   stbe006 LIKE stbe_t.stbe006, 
   stbe007 LIKE stbe_t.stbe007, 
   stbe008 LIKE stbe_t.stbe008, 
   stbe008_2_desc LIKE type_t.chr500, 
   stbe009 LIKE stbe_t.stbe009, 
   stbe009_2_desc LIKE type_t.chr500, 
   stbe010 LIKE stbe_t.stbe010, 
   stbe011 LIKE stbe_t.stbe011, 
   stbe012 LIKE stbe_t.stbe012, 
   stbe013 LIKE stbe_t.stbe013, 
   stbe014 LIKE stbe_t.stbe014, 
   stbe015 LIKE stbe_t.stbe015, 
   stbe016 LIKE stbe_t.stbe016, 
   stbe026 LIKE stbe_t.stbe026, 
   stbe027 LIKE stbe_t.stbe027, 
   stbe017 LIKE stbe_t.stbe017, 
   stbe017_2_desc LIKE type_t.chr500, 
   stbe018 LIKE stbe_t.stbe018, 
   stbe033 LIKE stbe_t.stbe033, 
   stbe031 LIKE stbe_t.stbe031, 
   stbe034 LIKE stbe_t.stbe034, 
   stbesite LIKE stbe_t.stbesite, 
   stbesite_2_desc LIKE type_t.chr500, 
   stbe020 LIKE stbe_t.stbe020, 
   stbe020_2_desc LIKE type_t.chr500, 
   stbe019 LIKE stbe_t.stbe019, 
   stbe019_2_desc LIKE type_t.chr500, 
   stbe032 LIKE stbe_t.stbe032, 
   stbecomp LIKE stbe_t.stbecomp, 
   stbe021 LIKE stbe_t.stbe021, 
   stbe022 LIKE stbe_t.stbe022, 
   stbe023 LIKE stbe_t.stbe023
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_stbdsite LIKE stbd_t.stbdsite,
   b_stbdsite_desc LIKE type_t.chr80,
      b_stbddocdt LIKE stbd_t.stbddocdt,
      b_stbddocno LIKE stbd_t.stbddocno,
      b_stbd001 LIKE stbd_t.stbd001,
      b_stbd037 LIKE stbd_t.stbd037,
   b_stbd037_desc LIKE type_t.chr80,
      b_stbd002 LIKE stbd_t.stbd002,
   b_stbd002_desc LIKE type_t.chr80,
      b_stbd004 LIKE stbd_t.stbd004,
      b_stbd005 LIKE stbd_t.stbd005,
      b_stbd006 LIKE stbd_t.stbd006
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
 TYPE type_g_stbe3_d RECORD
        l_stbe001      LIKE stbe_t.stbe001, 
        l_stbe002      LIKE stbe_t.stbe002, 
        l_stbe004      LIKE stbe_t.stbe004,
        l_stbe035      LIKE stbe_t.stbe035,     #160510-00010#8 160514 by lori add 
        l_stbe036      LIKE stbe_t.stbe036,     #160510-00010#8 160514 by lori add 
        l_stbe036_desc LIKE ooefl_t.ooefl003,   #160510-00010#8 160514 by lori add             
        l_stbe012      LIKE stbe_t.stbe012, 
        l_stbe013      LIKE stbe_t.stbe013, 
        l_stbe014      LIKE stbe_t.stbe014, 
        l_stbe015      LIKE stbe_t.stbe015, 
        l_stbe016      LIKE stbe_t.stbe016,
        l_stbe034      LIKE stbe_t.stbe034   
       END RECORD

TYPE g_type_stbc         RECORD   
             stbcent        LIKE stbc_t.stbcent, #企業編號
             stbcsite       LIKE stbc_t.stbcsite,#營運據點
             stbc001        LIKE stbc_t.stbc001, #結算中心
             stbc002        LIKE stbc_t.stbc002, #單據日期
             stbc003        LIKE stbc_t.stbc003, #單據類別
             stbc004        LIKE stbc_t.stbc004, #單據編號
             stbc005        LIKE stbc_t.stbc005, #項次
             stbc006        LIKE stbc_t.stbc006, #業務結算期
             stbc007        LIKE stbc_t.stbc007, #財務會計年度
             stbc008        LIKE stbc_t.stbc008, #對象編號
             stbc009        LIKE stbc_t.stbc009, #經營方式
             stbc010        LIKE stbc_t.stbc010, #結算方式
             stbc011        LIKE stbc_t.stbc011, #結算類型
             stbc012        LIKE stbc_t.stbc012, #費用編號
             stbc013        LIKE stbc_t.stbc013, #幣別
             stbc014        LIKE stbc_t.stbc014, #稅別
             stbc015        LIKE stbc_t.stbc015, #價款類別
             stbc016        LIKE stbc_t.stbc016, #方向
             stbc017        LIKE stbc_t.stbc017, #價外金額
             stbc018        LIKE stbc_t.stbc018, #價內金額
             stbc019        LIKE stbc_t.stbc019, #未結算金額
             stbc020        LIKE stbc_t.stbc020, #已結算金額
             stbc021        LIKE stbc_t.stbc021, #未校驗金額
             stbc022        LIKE stbc_t.stbc022, #已校驗金額
             stbc023        LIKE stbc_t.stbc023, #未立帳金額
             stbc024        LIKE stbc_t.stbc024, #已立帳金額
             stbc025        LIKE stbc_t.stbc025, #所屬品類
             stbc026        LIKE stbc_t.stbc026, #所屬部門
             stbc027        LIKE stbc_t.stbc027, #對象類別
             stbc028        LIKE stbc_t.stbc028, #財務會計期別
             stbc029        LIKE stbc_t.stbc029, #網點編號
             stbc030        LIKE stbc_t.stbc030, #結算合同編號
             stbc031        LIKE stbc_t.stbc031, #承擔對象
             stbc032        LIKE stbc_t.stbc032, #結算對象
             stbcstus       LIKE stbc_t.stbcstus,#狀態碼
             stbc033        LIKE stbc_t.stbc033, #專櫃編號
             stbc034        LIKE stbc_t.stbc034, #數量
             stbc035        LIKE stbc_t.stbc035, #已立帳數量
             stbc036        LIKE stbc_t.stbc036, #單價
             stbc037        LIKE stbc_t.stbc037, #納入結算單否
             stbc038        LIKE stbc_t.stbc038, #票扣否
             stbc039        LIKE stbc_t.stbc039, #結算扣率
             stbc040        LIKE stbc_t.stbc040, #結算日期
             stbc041        LIKE stbc_t.stbc041, #日結成本類型
             stbc042        LIKE stbc_t.stbc042, #銷售金額
             stbc043        LIKE stbc_t.stbc043, #商品編號
             stbc044        LIKE stbc_t.stbc044, #商品品類
             stbc045        LIKE stbc_t.stbc045, #開始日期
             stbc046        LIKE stbc_t.stbc046, #結束日期
             stbc047        LIKE stbc_t.stbc047, #已立帳金額帳套二
             stbc048        LIKE stbc_t.stbc048, #已立帳金額帳套三
             stbc049        LIKE stbc_t.stbc049, #主帳套暫估金額
             stbc050        LIKE stbc_t.stbc050, #帳套二暫估金額
             stbc051        LIKE stbc_t.stbc051, #帳套三暫估金額
             stbc052        LIKE stbc_t.stbc052, #已立帳數量帳套二
             stbc053        LIKE stbc_t.stbc053, #已立帳數量帳套三
             stbc054        LIKE stbc_t.stbc054, #主帳套暫估數量
             stbc055        LIKE stbc_t.stbc055, #帳套二暫估數量
             stbc056        LIKE stbc_t.stbc056, #帳套三暫估數量
             stbc057        LIKE stbc_t.stbc057, #已結算數量
             stbc058        LIKE stbc_t.stbc058, #含發票否
             stbc059        LIKE stbc_t.stbc059, #費用歸屬類型   #160510-00010#8 160514 by lori add
             stbc060        LIKE stbc_t.stbc060  #費用歸屬組織   #160510-00010#8 160514 by lori add
                         END RECORD
DEFINE g_stbe3_d             DYNAMIC ARRAY OF type_g_stbe3_d
DEFINE g_ins_site_flag       LIKE type_t.chr1       #紀錄新增單據stbdsite是否已輸入
DEFINE g_rtax_para           LIKE rtax_t.rtax004    #記錄管理品類層級參數值
DEFINE g_ooef004             LIKE ooef_t.ooef004    #單據別參照表號
DEFINE g_ooef006             LIKE ooef_t.ooef006    #所屬國家地區
#end add-point
       
#模組變數(Module Variables)
DEFINE g_stbd_m          type_g_stbd_m
DEFINE g_stbd_m_t        type_g_stbd_m
DEFINE g_stbd_m_o        type_g_stbd_m
DEFINE g_stbd_m_mask_o   type_g_stbd_m #轉換遮罩前資料
DEFINE g_stbd_m_mask_n   type_g_stbd_m #轉換遮罩後資料
 
   DEFINE g_stbddocno_t LIKE stbd_t.stbddocno
 
 
DEFINE g_stbe_d          DYNAMIC ARRAY OF type_g_stbe_d
DEFINE g_stbe_d_t        type_g_stbe_d
DEFINE g_stbe_d_o        type_g_stbe_d
DEFINE g_stbe_d_mask_o   DYNAMIC ARRAY OF type_g_stbe_d #轉換遮罩前資料
DEFINE g_stbe_d_mask_n   DYNAMIC ARRAY OF type_g_stbe_d #轉換遮罩後資料
DEFINE g_stbe2_d          DYNAMIC ARRAY OF type_g_stbe2_d
DEFINE g_stbe2_d_t        type_g_stbe2_d
DEFINE g_stbe2_d_o        type_g_stbe2_d
DEFINE g_stbe2_d_mask_o   DYNAMIC ARRAY OF type_g_stbe2_d #轉換遮罩前資料
DEFINE g_stbe2_d_mask_n   DYNAMIC ARRAY OF type_g_stbe2_d #轉換遮罩後資料
DEFINE g_stbe4_d          DYNAMIC ARRAY OF type_g_stbe4_d
DEFINE g_stbe4_d_t        type_g_stbe4_d
DEFINE g_stbe4_d_o        type_g_stbe4_d
DEFINE g_stbe4_d_mask_o   DYNAMIC ARRAY OF type_g_stbe4_d #轉換遮罩前資料
DEFINE g_stbe4_d_mask_n   DYNAMIC ARRAY OF type_g_stbe4_d #轉換遮罩後資料
DEFINE g_stbe5_d          DYNAMIC ARRAY OF type_g_stbe5_d
DEFINE g_stbe5_d_t        type_g_stbe5_d
DEFINE g_stbe5_d_o        type_g_stbe5_d
DEFINE g_stbe5_d_mask_o   DYNAMIC ARRAY OF type_g_stbe5_d #轉換遮罩前資料
DEFINE g_stbe5_d_mask_n   DYNAMIC ARRAY OF type_g_stbe5_d #轉換遮罩後資料
 
 
DEFINE g_browser         DYNAMIC ARRAY OF type_browser
DEFINE g_browser_f       DYNAMIC ARRAY OF type_browser
 
 
DEFINE g_wc                  STRING
DEFINE g_wc_t                STRING
DEFINE g_wc2                 STRING                          #單身CONSTRUCT結果
DEFINE g_wc2_table1          STRING
DEFINE g_wc2_table2   STRING
 
DEFINE g_wc2_table3   STRING
 
DEFINE g_wc2_table4   STRING
 
 
 
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
DEFINE g_wcc     STRING 
#end add-point
 
{</section>}
 
{<section id="astt840.main" >}
#應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success LIKE type_t.num5 
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("ast","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT stbdsite,'',stbddocdt,stbddocno,stbd037,'',stbd002,'',stbd046,'',stbd000, 
       stbd001,stbd041,stbdunit,'',stbd048,'',stbd049,'',stbd050,'',stbd003,stbd043,stbd044,stbd004, 
       '',stbd005,stbd006,stbd038,stbd060,stbd033,stbdstus,stbdownid,'',stbdowndp,'',stbdcrtid,'',stbdcrtdp, 
       '',stbdcrtdt,stbdmodid,'',stbdmoddt,stbdcnfid,'',stbdcnfdt,stbd007,stbd052,stbd051,stbd053,stbd008, 
       stbd054,stbd009,stbd055,stbd010,stbd056,stbd011,stbd057,stbd012,stbd058,stbd013,stbd059,stbd014, 
       stbd017,stbd018,stbd016,stbd019,stbd045,stbd015,stbd040,stbd039,stbd020,stbd042,stbd021,'',stbd022, 
       '','','','','','','',stbd023,'',stbd024,stbd025,'',stbd026,stbd027,stbd028,stbd029,stbd030,'', 
       stbd031,stbd032,stbd034,stbd035,stbd036,stbd047", 
                      " FROM stbd_t",
                      " WHERE stbdent= ? AND stbddocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE astt840_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.stbdsite,t0.stbddocdt,t0.stbddocno,t0.stbd037,t0.stbd002,t0.stbd046, 
       t0.stbd000,t0.stbd001,t0.stbd041,t0.stbdunit,t0.stbd048,t0.stbd049,t0.stbd050,t0.stbd003,t0.stbd043, 
       t0.stbd044,t0.stbd004,t0.stbd005,t0.stbd006,t0.stbd038,t0.stbd060,t0.stbd033,t0.stbdstus,t0.stbdownid, 
       t0.stbdowndp,t0.stbdcrtid,t0.stbdcrtdp,t0.stbdcrtdt,t0.stbdmodid,t0.stbdmoddt,t0.stbdcnfid,t0.stbdcnfdt, 
       t0.stbd007,t0.stbd052,t0.stbd051,t0.stbd053,t0.stbd008,t0.stbd054,t0.stbd009,t0.stbd055,t0.stbd010, 
       t0.stbd056,t0.stbd011,t0.stbd057,t0.stbd012,t0.stbd058,t0.stbd013,t0.stbd059,t0.stbd014,t0.stbd017, 
       t0.stbd018,t0.stbd016,t0.stbd019,t0.stbd045,t0.stbd015,t0.stbd040,t0.stbd039,t0.stbd020,t0.stbd042, 
       t0.stbd021,t0.stbd022,t0.stbd023,t0.stbd024,t0.stbd025,t0.stbd026,t0.stbd027,t0.stbd028,t0.stbd029, 
       t0.stbd030,t0.stbd031,t0.stbd032,t0.stbd034,t0.stbd035,t0.stbd036,t0.stbd047,t1.ooefl003 ,t2.mhbel003 , 
       t3.pmaal004 ,t4.pmaal004 ,t5.ooefl003 ,t6.rtaxl003 ,t7.oocql004 ,t8.ooag011 ,t9.ooefl003 ,t10.ooag011 , 
       t11.ooefl003 ,t12.ooag011 ,t13.ooag011 ,t14.ooag011 ,t15.ooefl003 ,t19.ooefl003 ,t20.nmabl003 , 
       t21.ooag011",
               " FROM stbd_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.stbdsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN mhbel_t t2 ON t2.mhbelent="||g_enterprise||" AND t2.mhbel001=t0.stbd037 AND t2.mhbel002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t3 ON t3.pmaalent="||g_enterprise||" AND t3.pmaal001=t0.stbd002 AND t3.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t4 ON t4.pmaalent="||g_enterprise||" AND t4.pmaal001=t0.stbd046 AND t4.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.stbdunit AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN rtaxl_t t6 ON t6.rtaxlent="||g_enterprise||" AND t6.rtaxl001=t0.stbd049 AND t6.rtaxl002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t7 ON t7.oocqlent="||g_enterprise||" AND t7.oocql001='2002' AND t7.oocql002=t0.stbd050 AND t7.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=t0.stbdownid  ",
               " LEFT JOIN ooefl_t t9 ON t9.ooeflent="||g_enterprise||" AND t9.ooefl001=t0.stbdowndp AND t9.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t10 ON t10.ooagent="||g_enterprise||" AND t10.ooag001=t0.stbdcrtid  ",
               " LEFT JOIN ooefl_t t11 ON t11.ooeflent="||g_enterprise||" AND t11.ooefl001=t0.stbdcrtdp AND t11.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t12 ON t12.ooagent="||g_enterprise||" AND t12.ooag001=t0.stbdmodid  ",
               " LEFT JOIN ooag_t t13 ON t13.ooagent="||g_enterprise||" AND t13.ooag001=t0.stbdcnfid  ",
               " LEFT JOIN ooag_t t14 ON t14.ooagent="||g_enterprise||" AND t14.ooag001=t0.stbd021  ",
               " LEFT JOIN ooefl_t t15 ON t15.ooeflent="||g_enterprise||" AND t15.ooefl001=t0.stbd022 AND t15.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t19 ON t19.ooeflent="||g_enterprise||" AND t19.ooefl001=t0.stbd023 AND t19.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN nmabl_t t20 ON t20.nmablent="||g_enterprise||" AND t20.nmabl001=t0.stbd025 AND t20.nmabl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t21 ON t21.ooagent="||g_enterprise||" AND t21.ooag001=t0.stbd030  ",
 
               " WHERE t0.stbdent = " ||g_enterprise|| " AND t0.stbddocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
         
   #end add-point
   PREPARE astt840_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_astt840 WITH FORM cl_ap_formpath("ast",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL astt840_init()   
 
      #進入選單 Menu (="N")
      CALL astt840_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_astt840
      
   END IF 
   
   CLOSE astt840_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   LET l_success = ''
   CALL s_aooi500_drop_temp() RETURNING l_success
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="astt840.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION astt840_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point    
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success LIKE type_t.num5
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   LET g_bfill       = "Y"
   LET g_detail_idx  = 1 #第一層單身指標
   LET g_detail_idx2 = 1 #第二層單身指標
   
   #各個page指標
   LET g_detail_idx_list[1] = 1 
   LET g_detail_idx_list[2] = 1
   LET g_detail_idx_list[3] = 1
   LET g_detail_idx_list[4] = 1
 
   LET g_error_show  = 1
   LET l_ac = 1 #單身指標
      CALL cl_set_combo_scc_part('stbdstus','13','N,Y,A,D,R,W,J,X')
 
      CALL cl_set_combo_scc('stbd041','6785') 
   CALL cl_set_combo_scc('stbd003','6013') 
   CALL cl_set_combo_scc('stbd020','6705') 
   CALL cl_set_combo_scc('stbe001','6703') 
   CALL cl_set_combo_scc('stbe035','6932') 
   CALL cl_set_combo_scc('stbe010','6006') 
   CALL cl_set_combo_scc('stbe033','6800') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
   CALL g_idx_group.addAttribute("'2',","1")
   CALL g_idx_group.addAttribute("'3',","1")
   CALL g_idx_group.addAttribute("'4',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   LET g_errshow = 1   #讓校驗訊息彈窗顯示  
   LET g_wcc = '1=1'
   LET l_success = ''
   CALL s_aooi500_create_temp() RETURNING l_success
   
   CALL cl_set_combo_scc_part('stbd003','6013','5') 
   
   #160310-00019#11 160425 by lori add---(S)
   CALL cl_set_combo_scc_part('stbe001','6703',"4,5")       
   CALL cl_set_combo_scc_part('l_stbe001','6703',"4,5")  
   CALL cl_set_combo_scc_part('stbe001_1','6703',"3")
   CALL cl_set_combo_scc_part('stbe001_2','6703',"3")   
   #160310-00019#11 160425 by lori add---(E)
   
   #160510-00010#8 160514 by lori add---(S)
   CALL cl_set_combo_scc('l_stbe035','6932')    
   CALL cl_set_combo_scc('stbe035_1','6932')  
   CALL cl_set_combo_scc('stbe035_2','6932')
   #160510-00010#8 160514 by lori add---(E)
   CALL cl_set_combo_scc('stbd039','6939')   #160604-00009#15 20160607 add by beckxie
   #end add-point
   
   #初始化搜尋條件
   CALL astt840_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="astt840.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION astt840_ui_dialog()
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
   #160310-00019#10 160427 by lori add---(S)
   DEFINE l_success      LIKE type_t.num5
   DEFINE l_para         LIKE type_t.chr30
   DEFINE l_stbc         g_type_stbc
   #160310-00019#10 160427 by lori add---(E)
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
            CALL astt840_insert()
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
         INITIALIZE g_stbd_m.* TO NULL
         CALL g_stbe_d.clear()
         CALL g_stbe2_d.clear()
         CALL g_stbe4_d.clear()
         CALL g_stbe5_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL astt840_init()
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
               
               CALL astt840_fetch('') # reload data
               LET l_ac = 1
               CALL astt840_ui_detailshow() #Setting the current row 
         
               CALL astt840_idx_chk()
               #NEXT FIELD stbeseq
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_stbe_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL astt840_idx_chk()
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
               CALL astt840_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
         #第一階單身段落
         DISPLAY ARRAY g_stbe2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL astt840_idx_chk()
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
               CALL astt840_idx_chk()
               #add-point:page2自定義行為 name="ui_dialog.body2.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
         
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_stbe4_d TO s_detail4.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL astt840_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail4")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[3] = l_ac
               CALL g_idx_group.addAttribute("'3',",l_ac)
               
               #add-point:page3, before row動作 name="ui_dialog.body4.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'3',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail4")
               LET g_current_page = 3
               #顯示單身筆數
               CALL astt840_idx_chk()
               #add-point:page3自定義行為 name="ui_dialog.body4.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_3)
            
         
            #add-point:page3自定義行為 name="ui_dialog.body4.action"
            
            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_stbe5_d TO s_detail5.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL astt840_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail5")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[4] = l_ac
               CALL g_idx_group.addAttribute("'4',",l_ac)
               
               #add-point:page4, before row動作 name="ui_dialog.body5.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'4',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail5")
               LET g_current_page = 4
               #顯示單身筆數
               CALL astt840_idx_chk()
               #add-point:page4自定義行為 name="ui_dialog.body5.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_4)
            
         
            #add-point:page4自定義行為 name="ui_dialog.body5.action"
            
            #end add-point
         
         END DISPLAY
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_stbe3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b) 
    
            BEFORE ROW
               #顯示單身筆數
               CALL astt840_idx_chk()
               #確定當下選擇的筆數
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[5] = l_ac
               CALL g_idx_group.addAttribute("",l_ac)
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue(""))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_current_page = 5
               #顯示單身筆數
               CALL astt840_idx_chk()
         END DISPLAY
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
      
         BEFORE DIALOG
            #先填充browser資料
            CALL astt840_browser_fill("")
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
               CALL astt840_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL astt840_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL astt840_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL astt840_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL astt840_set_act_visible()   
            CALL astt840_set_act_no_visible()
            IF NOT (g_stbd_m.stbddocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " stbdent = " ||g_enterprise|| " AND",
                                  " stbddocno = '", g_stbd_m.stbddocno, "' "
 
               #填到對應位置
               CALL astt840_browser_fill("")
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
 
               INITIALIZE g_wc2_table3 TO NULL
 
               INITIALIZE g_wc2_table4 TO NULL
 
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "stbd_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "stbe_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "stbf_t" 
                        LET g_wc2_table2 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "stbe_t" 
                        LET g_wc2_table3 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "stbe_t" 
                        LET g_wc2_table4 = la_wc[li_idx].wc
 
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
                  OR NOT cl_null(g_wc2_table2)
 
                  OR NOT cl_null(g_wc2_table3)
 
                  OR NOT cl_null(g_wc2_table4)
 
 
                  OR NOT cl_null(g_wc2_extend)
                  THEN
                  #組合g_wc2
                  IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
                     LET g_wc2 = g_wc2_table1
                  END IF
                  IF g_wc2_table2 <> " 1=1" AND NOT cl_null(g_wc2_table2) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
                  END IF
 
                  IF g_wc2_table3 <> " 1=1" AND NOT cl_null(g_wc2_table3) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table3
                  END IF
 
                  IF g_wc2_table4 <> " 1=1" AND NOT cl_null(g_wc2_table4) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table4
                  END IF
 
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
 
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
               END IF
               CALL astt840_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         #查詢方案選擇
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
               INITIALIZE g_wc2_table2 TO NULL
 
               INITIALIZE g_wc2_table3 TO NULL
 
               INITIALIZE g_wc2_table4 TO NULL
 
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "stbd_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "stbe_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "stbf_t" 
                        LET g_wc2_table2 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "stbe_t" 
                        LET g_wc2_table3 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "stbe_t" 
                        LET g_wc2_table4 = la_wc[li_idx].wc
 
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1)
                  OR NOT cl_null(g_wc2_table2)
 
                  OR NOT cl_null(g_wc2_table3)
 
                  OR NOT cl_null(g_wc2_table4)
 
 
                  OR NOT cl_null(g_wc2_extend)
                  THEN
                  IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
                     LET g_wc2 = g_wc2_table1
                  END IF
                  IF g_wc2_table2 <> " 1=1" AND NOT cl_null(g_wc2_table2) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
                  END IF
 
                  IF g_wc2_table3 <> " 1=1" AND NOT cl_null(g_wc2_table3) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table3
                  END IF
 
                  IF g_wc2_table4 <> " 1=1" AND NOT cl_null(g_wc2_table4) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table4
                  END IF
 
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL astt840_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL astt840_fetch("F")
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
               CALL astt840_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL astt840_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL astt840_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL astt840_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL astt840_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL astt840_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL astt840_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL astt840_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL astt840_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL astt840_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL astt840_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_stbe_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_stbe2_d)
                  LET g_export_id[2]   = "s_detail2"
                  LET g_export_node[3] = base.typeInfo.create(g_stbe4_d)
                  LET g_export_id[3]   = "s_detail4"
                  LET g_export_node[4] = base.typeInfo.create(g_stbe5_d)
                  LET g_export_id[4]   = "s_detail5"
 
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
               NEXT FIELD stbeseq
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
               CALL astt840_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL astt840_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION gen_detail
            LET g_action_choice="gen_detail"
            IF cl_auth_chk_act("gen_detail") THEN
               
               #add-point:ON ACTION gen_detail name="menu.gen_detail"
               #160310-00019#10 160427 by lori add---(S)
               IF cl_null(g_stbd_m.stbddocno) THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "-400" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()               

               ELSE
                  #160513-00037#27 20160602 add by beckxie---S
                  CALL astt840_01(g_stbd_m.stbddocno)
                  LET INT_FLAG = FALSE
                  IF g_current_idx > 0 THEN
                     CALL astt840_ui_headershow()
                  END IF
                  #160604-00009#15 20160607 add by beckxie---E
                  CALL astt840_b_fill()
                  #160513-00037#27 20160602 add by beckxie---E
                  #160513-00037#27 20160602 mark by beckxie---S
                  #INITIALIZE l_stbc.* TO NULL
                  #LET l_success = ''
                  #LET l_para = cl_get_para(g_enterprise,g_site,"S-CIR-2012")   
                  #
                  #CALL s_transaction_begin()
                  #CALL cl_err_collect_init()
                  #
                  ##160513-00037#12 160521 by lori mark and add---(S)
                  ##CALL s_astp840_stbc(1,                 l_para,             g_stbd_m.stbdsite,    #處理類型,是否啟用交款匯總,結算組織
                  ##                    g_stbd_m.stbdunit, '',                 '',                   #結算中心,來源單據編號,來源單據項次
                  ##                    g_stbd_m.stbd003,  g_stbd_m.stbd001,   g_stbd_m.stbd037,     #經營方式,合約編號,鋪位編號     
                  ##                    '',                g_stbd_m.l_stjo002, g_stbd_m.stbddocno,   #納入結算單否,結算日期,結算單號/匯總單號
                  ##                    '')                                                          #批次處理條件
                  ##   RETURNING l_success,l_stbc.*
                  #
                  #CALL s_astp840_ins_detail('N',               1,                 l_para,               #是否為批次作業,處理類型,是否啟用交款匯總        #160513-00037#12 160524 by lori 加傳第一個參數
                  #                          g_stbd_m.stbdsite, g_stbd_m.stbdunit, '',                   #結算組織,結算中心,來源單據編號
                  #                          '',                g_stbd_m.stbd003,  g_stbd_m.stbd001,     #來源單據項次,經營方式,合約編號
                  #                          g_stbd_m.stbd037,  '',                g_stbd_m.l_stjo002,   #鋪位編號,納入結算單否,結算日期     
                  #                          g_stbd_m.stbddocno,'')                                      #結算單號/匯總單號,批次處理條件
                  #   RETURNING l_success
                  ##160513-00037#12 160521 by lori mark and add---(E)
                  #
                  #CALL cl_err_collect_show()               
                  #IF NOT l_success THEN
                  #   CALL s_transaction_end('N',1)
                  #ELSE
                  #   CALL s_transaction_end('Y',1)
                  #   CALL astt840_b_fill()
                  #END IF                
                  #160513-00037#27 20160602 mark by beckxie---E
               END IF        
               #160310-00019#10 160427 by lori add---(E)
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION print_choice
            LET g_action_choice="print_choice"
            IF cl_auth_chk_act("print_choice") THEN
               
               #add-point:ON ACTION print_choice name="menu.print_choice"
               IF NOT cl_null(g_stbd_m.stbddocno) AND g_stbd_m.stbdstus = 'Y' THEN 
                  CALL astt840_02(g_stbd_m.stbddocno) RETURNING g_wcc
               END IF 
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL astt840_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL astt840_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               LET g_rep_wc = "stbdent = "|| g_enterprise ||" AND stbddocno = '"||g_stbd_m.stbddocno||"' , '",g_wcc,"' "   #160516-00014#12 20160613 add by Naysa
               #END add-point
               &include "erp/ast/astt840_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               LET g_wcc = '1=1'
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               LET g_rep_wc = "stbdent = "|| g_enterprise ||" AND stbddocno = '"||g_stbd_m.stbddocno||"' , '",g_wcc,"' "   #160516-00014#12 20160613 add by Naysa
               #END add-point
               &include "erp/ast/astt840_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION invoice_mod
            LET g_action_choice="invoice_mod"
            IF cl_auth_chk_act("invoice_mod") THEN
               
               #add-point:ON ACTION invoice_mod name="menu.invoice_mod"
               #160509-00004#30  add by liyan --str--
               INITIALIZE l_stbc.* TO NULL
               LET l_success = ''
               CALL s_transaction_begin()
               #CALL cl_err_collect_init()
               LET g_forupd_sql = "SELECT stbfseq,stbf001,stbf002,stbf003,stbf004,stbf005,stbf006,stbf007,stbf008,stbf009,stbf010, 
                                          stbf011,stbf012,stbfcomp,stbfsite,stbf013,stbf014,stbf015,stbf016 FROM stbf_t  
                                   WHERE stbfent=? AND stbfdocno=? AND stbfseq=? FOR UPDATE"
               LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
               LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
               DECLARE astt840_bcl9 CURSOR FROM g_forupd_sql
               CALL astt840_invoice_mod()  #RETURNING l_success                                           
               IF INT_FLAG THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = '' 
                  LET g_errparam.code   = 9001 
                  LET g_errparam.popup  = FALSE 
                  CALL cl_err()
                  CALL s_transaction_end('N','0')
                  LET INT_FLAG = 0
               ELSE 
                  #CALL cl_err_collect_show() 
                  CALL s_transaction_end('Y','0')
                  CALL astt840_b_fill()
               END IF               
               #160509-00004#30 add by liyan --end--               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL astt840_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
               CALL g_curr_diag.setCurrentRow("s_detail4",1)
               CALL g_curr_diag.setCurrentRow("s_detail5",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_astm801
            LET g_action_choice="prog_astm801"
            IF cl_auth_chk_act("prog_astm801") THEN
               
               #add-point:ON ACTION prog_astm801 name="menu.prog_astm801"
               #應用 a41 樣板自動產生(Version:3)
               #使用JSON格式組合參數與作業編號(串查)
               INITIALIZE la_param.* TO NULL
               LET la_param.prog     = 'astm801'
               LET la_param.param[1] = g_stbd_m.stbd001

               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun_wait(ls_js)
 



               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_stbd021
            LET g_action_choice="prog_stbd021"
            IF cl_auth_chk_act("prog_stbd021") THEN
               
               #add-point:ON ACTION prog_stbd021 name="menu.prog_stbd021"
               #應用 a45 樣板自動產生(Version:3)
               CALL cl_user_contact("aooi130","ooag_t","ooag002","ooag001",g_stbd_m.stbd021)
 



               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL astt840_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL astt840_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL astt840_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_stbd_m.stbddocdt)
 
 
 
         
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
 
{<section id="astt840.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION astt840_browser_fill(ps_page_action)
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
   LET l_where = ''
   CALL s_aooi500_sql_where(g_prog,'stbdsite') RETURNING l_where
   LET l_wc = l_wc," AND ",l_where
   
   #LET l_wc = l_wc," AND stbd000 = '3' "
   LET l_wc = l_wc," AND stbd003 = '5' "
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT stbddocno ",
                      " FROM stbd_t ",
                      " ",
                      " LEFT JOIN stbe_t ON stbeent = stbdent AND stbddocno = stbedocno ", "  ",
                      #add-point:browser_fill段sql(stbe_t1) name="browser_fill.cnt.join.}"
 
                      #end add-point
                      " LEFT JOIN stbf_t ON stbfent = stbdent AND stbddocno = stbfdocno", "  ",
                      #add-point:browser_fill段sql(stbf_t1) name="browser_fill.cnt.join.stbf_t1"
                      
                      #end add-point
 
                      "", "  ",
                      #add-point:browser_fill段sql(stbe_t2) name="browser_fill.cnt.join.stbe_t2"
                      
                      #end add-point
 
                      "", "  ",
                      #add-point:browser_fill段sql(stbe_t3) name="browser_fill.cnt.join.stbe_t3"
                      
                      #end add-point
 
 
 
                      " ", 
                      " ", 
                      " ",                      
 
                      " ",                      
 
                      " ",                      
 
 
 
                      " WHERE stbdent = " ||g_enterprise|| " AND stbeent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("stbd_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT stbddocno ",
                      " FROM stbd_t ", 
                      "  ",
                      "  ",
                      " WHERE stbdent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("stbd_t")
   END IF
   
   #add-point:browser_fill,cnt wc name="browser_fill.cnt_sqlwc"
   #add by geza 20160802 #160728-00006#15(S)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT stbddocno ",
                      " FROM stbd_t ",
                      " LEFT JOIN stbe_t ON stbeent = stbdent AND stbddocno = stbedocno ", "  ",
                      " LEFT JOIN stje_t ON stjeent = stbdent AND stje001 = stbd001 ", 
                      " LEFT JOIN stbf_t ON stbfent = stbdent AND stbddocno = stbfdocno", "  ",
                      " WHERE stbdent = '" ||g_enterprise|| "' AND stbeent = '" ||g_enterprise|| "' AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("stbd_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT stbddocno ",
                      " FROM stbd_t ", 
                      " LEFT JOIN stje_t ON stjeent = stbdent AND stje001 = stbd001 ",
                      " WHERE stbdent = '" ||g_enterprise|| "' AND ",l_wc CLIPPED, cl_sql_add_filter("stbd_t")
   END IF
   #add by geza 20160802 #160728-00006#15(E)
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
      INITIALIZE g_stbd_m.* TO NULL
      CALL g_stbe_d.clear()        
      CALL g_stbe2_d.clear() 
      CALL g_stbe4_d.clear() 
      CALL g_stbe5_d.clear() 
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.stbdsite,t0.stbddocdt,t0.stbddocno,t0.stbd001,t0.stbd037,t0.stbd002,t0.stbd004,t0.stbd005,t0.stbd006 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.stbdstus,t0.stbdsite,t0.stbddocdt,t0.stbddocno,t0.stbd001,t0.stbd037, 
          t0.stbd002,t0.stbd004,t0.stbd005,t0.stbd006,t1.ooefl003 ,t2.mhbel003 ,t3.pmaal004 ",
                  " FROM stbd_t t0",
                  "  ",
                  "  LEFT JOIN stbe_t ON stbeent = stbdent AND stbddocno = stbedocno ", "  ", 
                  #add-point:browser_fill段sql(stbe_t1) name="browser_fill.join.stbe_t1"
                  
                  #end add-point
                  "  LEFT JOIN stbf_t ON stbfent = stbdent AND stbddocno = stbfdocno", "  ", 
                  #add-point:browser_fill段sql(stbf_t1) name="browser_fill.join.stbf_t1"
                  
                  #end add-point
 
                  " ", "  ", 
                  #add-point:browser_fill段sql(stbe_t2) name="browser_fill.join.stbe_t2"
                  
                  #end add-point
 
                  " ", "  ", 
                  #add-point:browser_fill段sql(stbe_t3) name="browser_fill.join.stbe_t3"
                  
                  #end add-point
 
 
 
                  " ", 
                  " ",                      
 
                  " ",                      
 
                  " ",                      
 
 
 
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.stbdsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN mhbel_t t2 ON t2.mhbelent="||g_enterprise||" AND t2.mhbel001=t0.stbd037 AND t2.mhbel002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t3 ON t3.pmaalent="||g_enterprise||" AND t3.pmaal001=t0.stbd002 AND t3.pmaal002='"||g_dlang||"' ",
 
                  " WHERE t0.stbdent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("stbd_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.stbdstus,t0.stbdsite,t0.stbddocdt,t0.stbddocno,t0.stbd001,t0.stbd037, 
          t0.stbd002,t0.stbd004,t0.stbd005,t0.stbd006,t1.ooefl003 ,t2.mhbel003 ,t3.pmaal004 ",
                  " FROM stbd_t t0",
                  "  ",
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.stbdsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN mhbel_t t2 ON t2.mhbelent="||g_enterprise||" AND t2.mhbel001=t0.stbd037 AND t2.mhbel002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t3 ON t3.pmaalent="||g_enterprise||" AND t3.pmaal001=t0.stbd002 AND t3.pmaal002='"||g_dlang||"' ",
 
                  " WHERE t0.stbdent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("stbd_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   #add by geza 20160802 #160728-00006#15(S)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.stbdstus,t0.stbdsite,t0.stbddocdt,t0.stbddocno,t0.stbd001,t0.stbd037, 
          t0.stbd002,t0.stbd004,t0.stbd005,t0.stbd006,t1.ooefl003 ,t2.mhbel003 ,t3.pmaal004 ",
                  " FROM stbd_t t0",
                  "  LEFT JOIN stbe_t ON stbeent = stbdent AND stbddocno = stbedocno ", "  ", 
                  "  LEFT JOIN stbf_t ON stbfent = stbdent AND stbddocno = stbfdocno", "  ", 
                  "  LEFT JOIN stje_t ON stjeent = stbdent AND stje001 = stbd001 ", 
                  "  LEFT JOIN ooefl_t t1 ON t1.ooeflent='"||g_enterprise||"' AND t1.ooefl001=t0.stbdsite AND t1.ooefl002='"||g_dlang||"' ",
                  "  LEFT JOIN mhbel_t t2 ON t2.mhbelent='"||g_enterprise||"' AND t2.mhbel001=t0.stbd037 AND t2.mhbel002='"||g_dlang||"' ",
                  "  LEFT JOIN pmaal_t t3 ON t3.pmaalent='"||g_enterprise||"' AND t3.pmaal001=t0.stbd002 AND t3.pmaal002='"||g_dlang||"' ",
 
                  " WHERE t0.stbdent = '" ||g_enterprise|| "' AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("stbd_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.stbdstus,t0.stbdsite,t0.stbddocdt,t0.stbddocno,t0.stbd001,t0.stbd037, 
          t0.stbd002,t0.stbd004,t0.stbd005,t0.stbd006,t1.ooefl003 ,t2.mhbel003 ,t3.pmaal004 ",
                  " FROM stbd_t t0",
               " LEFT JOIN stje_t ON stjeent = stbdent AND stje001 = stbd001 ",
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent='"||g_enterprise||"' AND t1.ooefl001=t0.stbdsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN mhbel_t t2 ON t2.mhbelent='"||g_enterprise||"' AND t2.mhbel001=t0.stbd037 AND t2.mhbel002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t3 ON t3.pmaalent='"||g_enterprise||"' AND t3.pmaal001=t0.stbd002 AND t3.pmaal002='"||g_dlang||"' ",
 
                  " WHERE t0.stbdent = '" ||g_enterprise|| "' AND ",l_wc, cl_sql_add_filter("stbd_t")
   END IF               
   #add by geza 20160802 #160728-00006#15(E)
   #end add-point
   LET g_sql = g_sql, " ORDER BY stbddocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"stbd_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_stbdsite,g_browser[g_cnt].b_stbddocdt, 
          g_browser[g_cnt].b_stbddocno,g_browser[g_cnt].b_stbd001,g_browser[g_cnt].b_stbd037,g_browser[g_cnt].b_stbd002, 
          g_browser[g_cnt].b_stbd004,g_browser[g_cnt].b_stbd005,g_browser[g_cnt].b_stbd006,g_browser[g_cnt].b_stbdsite_desc, 
          g_browser[g_cnt].b_stbd037_desc,g_browser[g_cnt].b_stbd002_desc
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
         CALL astt840_browser_mask()
      
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
         WHEN "J"
            LET g_browser[g_cnt].b_statepic = "stus/16/reconciliate.png"
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
   
   IF cl_null(g_browser[g_cnt].b_stbddocno) THEN
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
 
{<section id="astt840.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION astt840_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_stbd_m.stbddocno = g_browser[g_current_idx].b_stbddocno   
 
   EXECUTE astt840_master_referesh USING g_stbd_m.stbddocno INTO g_stbd_m.stbdsite,g_stbd_m.stbddocdt, 
       g_stbd_m.stbddocno,g_stbd_m.stbd037,g_stbd_m.stbd002,g_stbd_m.stbd046,g_stbd_m.stbd000,g_stbd_m.stbd001, 
       g_stbd_m.stbd041,g_stbd_m.stbdunit,g_stbd_m.stbd048,g_stbd_m.stbd049,g_stbd_m.stbd050,g_stbd_m.stbd003, 
       g_stbd_m.stbd043,g_stbd_m.stbd044,g_stbd_m.stbd004,g_stbd_m.stbd005,g_stbd_m.stbd006,g_stbd_m.stbd038, 
       g_stbd_m.stbd060,g_stbd_m.stbd033,g_stbd_m.stbdstus,g_stbd_m.stbdownid,g_stbd_m.stbdowndp,g_stbd_m.stbdcrtid, 
       g_stbd_m.stbdcrtdp,g_stbd_m.stbdcrtdt,g_stbd_m.stbdmodid,g_stbd_m.stbdmoddt,g_stbd_m.stbdcnfid, 
       g_stbd_m.stbdcnfdt,g_stbd_m.stbd007,g_stbd_m.stbd052,g_stbd_m.stbd051,g_stbd_m.stbd053,g_stbd_m.stbd008, 
       g_stbd_m.stbd054,g_stbd_m.stbd009,g_stbd_m.stbd055,g_stbd_m.stbd010,g_stbd_m.stbd056,g_stbd_m.stbd011, 
       g_stbd_m.stbd057,g_stbd_m.stbd012,g_stbd_m.stbd058,g_stbd_m.stbd013,g_stbd_m.stbd059,g_stbd_m.stbd014, 
       g_stbd_m.stbd017,g_stbd_m.stbd018,g_stbd_m.stbd016,g_stbd_m.stbd019,g_stbd_m.stbd045,g_stbd_m.stbd015, 
       g_stbd_m.stbd040,g_stbd_m.stbd039,g_stbd_m.stbd020,g_stbd_m.stbd042,g_stbd_m.stbd021,g_stbd_m.stbd022, 
       g_stbd_m.stbd023,g_stbd_m.stbd024,g_stbd_m.stbd025,g_stbd_m.stbd026,g_stbd_m.stbd027,g_stbd_m.stbd028, 
       g_stbd_m.stbd029,g_stbd_m.stbd030,g_stbd_m.stbd031,g_stbd_m.stbd032,g_stbd_m.stbd034,g_stbd_m.stbd035, 
       g_stbd_m.stbd036,g_stbd_m.stbd047,g_stbd_m.stbdsite_desc,g_stbd_m.stbd037_desc,g_stbd_m.stbd002_desc, 
       g_stbd_m.stbd046_desc,g_stbd_m.stbdunit_desc,g_stbd_m.stbd049_desc,g_stbd_m.stbd050_desc,g_stbd_m.stbdownid_desc, 
       g_stbd_m.stbdowndp_desc,g_stbd_m.stbdcrtid_desc,g_stbd_m.stbdcrtdp_desc,g_stbd_m.stbdmodid_desc, 
       g_stbd_m.stbdcnfid_desc,g_stbd_m.stbd021_desc,g_stbd_m.stbd022_desc,g_stbd_m.stbd023_desc,g_stbd_m.stbd025_desc, 
       g_stbd_m.stbd030_desc
   
   CALL astt840_stbd_t_mask()
   CALL astt840_show()
      
END FUNCTION
 
{</section>}
 
{<section id="astt840.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION astt840_ui_detailshow()
   #add-point:ui_detailshow段define(客製用) name="ui_detailshow.define_customerization"
   
   #end add-point    
   #add-point:ui_detailshow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_detailshow.define"
   
   #end add-point    
 
   #add-point:Function前置處理 name="ui_detailshow.before"
   
   #end add-point    
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
      CALL g_curr_diag.setCurrentRow("s_detail4",g_detail_idx)
      CALL g_curr_diag.setCurrentRow("s_detail5",g_detail_idx)
 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="astt840.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION astt840_ui_browser_refresh()
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
      IF g_browser[l_i].b_stbddocno = g_stbd_m.stbddocno 
 
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
 
{<section id="astt840.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION astt840_construct()
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
   INITIALIZE g_stbd_m.* TO NULL
   CALL g_stbe_d.clear()        
   CALL g_stbe2_d.clear() 
   CALL g_stbe4_d.clear() 
   CALL g_stbe5_d.clear() 
 
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
   INITIALIZE g_wc2_table2 TO NULL
 
   INITIALIZE g_wc2_table3 TO NULL
 
   INITIALIZE g_wc2_table4 TO NULL
 
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前 name="cs.before_construct"
   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON stbdsite,stbddocdt,stbddocno,stbd037,stbd002,stbd046,stbd000,stbd001, 
          stbd041,stbdunit,stbd048,stbd049,stbd050,stbd003,stbd043,stbd044,stbd004,l_stjo002,stbd005, 
          stbd006,stbd038,stbd060,stbd033,stbdstus,stbdownid,stbdowndp,stbdcrtid,stbdcrtdp,stbdcrtdt, 
          stbdmodid,stbdmoddt,stbdcnfid,stbdcnfdt,stbd007,stbd052,stbd051,stbd053,stbd008,stbd054,stbd009, 
          stbd055,stbd010,stbd056,stbd011,stbd057,stbd012,stbd058,stbd013,stbd059,stbd014,stbd017,stbd018, 
          stbd016,stbd019,stbd045,stbd015,stbd040,stbd039,stbd020,stbd042,stbd021,stbd022,stje019,stje020, 
          stje021,stbd023,stbd024,stbd025,stbd026,stbd027,stbd028,stbd029,stbd030,stbd031,stbd032,stbd034, 
          stbd035,stbd036,stbd047
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<stbdcrtdt>>----
         AFTER FIELD stbdcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<stbdmoddt>>----
         AFTER FIELD stbdmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<stbdcnfdt>>----
         AFTER FIELD stbdcnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<stbdpstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.stbdsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbdsite
            #add-point:ON ACTION controlp INFIELD stbdsite name="construct.c.stbdsite"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'stbdsite',g_site,'c')
            
            CALL q_ooef001_24()                  
            
            DISPLAY g_qryparam.return1 TO stbdsite 
            NEXT FIELD stbdsite 
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbdsite
            #add-point:BEFORE FIELD stbdsite name="construct.b.stbdsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbdsite
            
            #add-point:AFTER FIELD stbdsite name="construct.a.stbdsite"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbddocdt
            #add-point:BEFORE FIELD stbddocdt name="construct.b.stbddocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbddocdt
            
            #add-point:AFTER FIELD stbddocdt name="construct.a.stbddocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stbddocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbddocdt
            #add-point:ON ACTION controlp INFIELD stbddocdt name="construct.c.stbddocdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.stbddocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbddocno
            #add-point:ON ACTION controlp INFIELD stbddocno name="construct.c.stbddocno"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #LET g_qryparam.where = " AND stbd000 = '3' "   #160604-00009#15 20160607 mark by beckxie
            LET g_qryparam.where = " stbd000 = '3' "   #160604-00009#15 20160607 add by beckxie
            
            CALL q_stbddocno()            
            
            DISPLAY g_qryparam.return1 TO stbddocno  
            NEXT FIELD stbddocno                      
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbddocno
            #add-point:BEFORE FIELD stbddocno name="construct.b.stbddocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbddocno
            
            #add-point:AFTER FIELD stbddocno name="construct.a.stbddocno"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stbd037
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd037
            #add-point:ON ACTION controlp INFIELD stbd037 name="construct.c.stbd037"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            
            CALL q_mhbe001() 
            
            DISPLAY g_qryparam.return1 TO stbd037 
            NEXT FIELD stbd037  
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd037
            #add-point:BEFORE FIELD stbd037 name="construct.b.stbd037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd037
            
            #add-point:AFTER FIELD stbd037 name="construct.a.stbd037"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stbd002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd002
            #add-point:ON ACTION controlp INFIELD stbd002 name="construct.c.stbd002"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #160513-00037#27 20160603 add by beckxie---S
            LET g_qryparam.arg1 = "('1','3')"
            CALL q_pmaa001_1()
            #160513-00037#27 20160603 add by beckxie---E
            #CALL q_pmaa001_10()   #160513-00037#27 20160603 mark by beckxie
            
            DISPLAY g_qryparam.return1 TO stbd002 
            NEXT FIELD stbd002      
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd002
            #add-point:BEFORE FIELD stbd002 name="construct.b.stbd002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd002
            
            #add-point:AFTER FIELD stbd002 name="construct.a.stbd002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stbd046
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd046
            #add-point:ON ACTION controlp INFIELD stbd046 name="construct.c.stbd046"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '1'
            
            CALL q_pmac002_10()           
          
            DISPLAY g_qryparam.return1 TO stbd046 
            NEXT FIELD stbd046 
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd046
            #add-point:BEFORE FIELD stbd046 name="construct.b.stbd046"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd046
            
            #add-point:AFTER FIELD stbd046 name="construct.a.stbd046"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd000
            #add-point:BEFORE FIELD stbd000 name="construct.b.stbd000"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd000
            
            #add-point:AFTER FIELD stbd000 name="construct.a.stbd000"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stbd000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd000
            #add-point:ON ACTION controlp INFIELD stbd000 name="construct.c.stbd000"
            
            #END add-point
 
 
         #Ctrlp:construct.c.stbd001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd001
            #add-point:ON ACTION controlp INFIELD stbd001 name="construct.c.stbd001"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            
            CALL q_stje001()                  
            
            DISPLAY g_qryparam.return1 TO stbd001
            NEXT FIELD stbd001        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd001
            #add-point:BEFORE FIELD stbd001 name="construct.b.stbd001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd001
            
            #add-point:AFTER FIELD stbd001 name="construct.a.stbd001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd041
            #add-point:BEFORE FIELD stbd041 name="construct.b.stbd041"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd041
            
            #add-point:AFTER FIELD stbd041 name="construct.a.stbd041"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stbd041
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd041
            #add-point:ON ACTION controlp INFIELD stbd041 name="construct.c.stbd041"
            
            #END add-point
 
 
         #Ctrlp:construct.c.stbdunit
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbdunit
            #add-point:ON ACTION controlp INFIELD stbdunit name="construct.c.stbdunit"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'dbeaunit',g_site,'c')
            
            CALL q_ooef001_24()         
            
            DISPLAY g_qryparam.return1 TO stbdunit 
            NEXT FIELD stbdunit 
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbdunit
            #add-point:BEFORE FIELD stbdunit name="construct.b.stbdunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbdunit
            
            #add-point:AFTER FIELD stbdunit name="construct.a.stbdunit"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd048
            #add-point:BEFORE FIELD stbd048 name="construct.b.stbd048"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd048
            
            #add-point:AFTER FIELD stbd048 name="construct.a.stbd048"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stbd048
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd048
            #add-point:ON ACTION controlp INFIELD stbd048 name="construct.c.stbd048"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #161024-00025#4 -s by 08172
            LET g_qryparam.where = " ooef003='Y'"
            CALL q_ooef001_24()
#            CALL q_ooef001_2()   
            #161024-00025#4 -s by 08172
            DISPLAY g_qryparam.return1 TO stbd048
            NEXT FIELD stbd048  
            #END add-point
 
 
         #Ctrlp:construct.c.stbd049
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd049
            #add-point:ON ACTION controlp INFIELD stbd049 name="construct.c.stbd049"
            LET g_rtax_para = cl_get_para(g_enterprise,'',"E-CIR-0001")
            
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_rtax_para
            
            CALL q_rtax001_3()    
            
            DISPLAY g_qryparam.return1 TO stbd049  
            NEXT FIELD stbd049 
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd049
            #add-point:BEFORE FIELD stbd049 name="construct.b.stbd049"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd049
            
            #add-point:AFTER FIELD stbd049 name="construct.a.stbd049"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stbd050
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd050
            #add-point:ON ACTION controlp INFIELD stbd050 name="construct.c.stbd050"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            
            CALL q_oocq002_2002()            
            
            DISPLAY g_qryparam.return1 TO stbd050  
            NEXT FIELD stbd050        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd050
            #add-point:BEFORE FIELD stbd050 name="construct.b.stbd050"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd050
            
            #add-point:AFTER FIELD stbd050 name="construct.a.stbd050"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd003
            #add-point:BEFORE FIELD stbd003 name="construct.b.stbd003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd003
            
            #add-point:AFTER FIELD stbd003 name="construct.a.stbd003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stbd003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd003
            #add-point:ON ACTION controlp INFIELD stbd003 name="construct.c.stbd003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd043
            #add-point:BEFORE FIELD stbd043 name="construct.b.stbd043"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd043
            
            #add-point:AFTER FIELD stbd043 name="construct.a.stbd043"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stbd043
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd043
            #add-point:ON ACTION controlp INFIELD stbd043 name="construct.c.stbd043"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd044
            #add-point:BEFORE FIELD stbd044 name="construct.b.stbd044"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd044
            
            #add-point:AFTER FIELD stbd044 name="construct.a.stbd044"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stbd044
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd044
            #add-point:ON ACTION controlp INFIELD stbd044 name="construct.c.stbd044"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd004
            #add-point:BEFORE FIELD stbd004 name="construct.b.stbd004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd004
            
            #add-point:AFTER FIELD stbd004 name="construct.a.stbd004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stbd004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd004
            #add-point:ON ACTION controlp INFIELD stbd004 name="construct.c.stbd004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_stjo002
            #add-point:BEFORE FIELD l_stjo002 name="construct.b.l_stjo002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_stjo002
            
            #add-point:AFTER FIELD l_stjo002 name="construct.a.l_stjo002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.l_stjo002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_stjo002
            #add-point:ON ACTION controlp INFIELD l_stjo002 name="construct.c.l_stjo002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd005
            #add-point:BEFORE FIELD stbd005 name="construct.b.stbd005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd005
            
            #add-point:AFTER FIELD stbd005 name="construct.a.stbd005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stbd005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd005
            #add-point:ON ACTION controlp INFIELD stbd005 name="construct.c.stbd005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd006
            #add-point:BEFORE FIELD stbd006 name="construct.b.stbd006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd006
            
            #add-point:AFTER FIELD stbd006 name="construct.a.stbd006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stbd006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd006
            #add-point:ON ACTION controlp INFIELD stbd006 name="construct.c.stbd006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd038
            #add-point:BEFORE FIELD stbd038 name="construct.b.stbd038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd038
            
            #add-point:AFTER FIELD stbd038 name="construct.a.stbd038"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stbd038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd038
            #add-point:ON ACTION controlp INFIELD stbd038 name="construct.c.stbd038"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd060
            #add-point:BEFORE FIELD stbd060 name="construct.b.stbd060"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd060
            
            #add-point:AFTER FIELD stbd060 name="construct.a.stbd060"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stbd060
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd060
            #add-point:ON ACTION controlp INFIELD stbd060 name="construct.c.stbd060"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd033
            #add-point:BEFORE FIELD stbd033 name="construct.b.stbd033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd033
            
            #add-point:AFTER FIELD stbd033 name="construct.a.stbd033"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stbd033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd033
            #add-point:ON ACTION controlp INFIELD stbd033 name="construct.c.stbd033"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbdstus
            #add-point:BEFORE FIELD stbdstus name="construct.b.stbdstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbdstus
            
            #add-point:AFTER FIELD stbdstus name="construct.a.stbdstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stbdstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbdstus
            #add-point:ON ACTION controlp INFIELD stbdstus name="construct.c.stbdstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.stbdownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbdownid
            #add-point:ON ACTION controlp INFIELD stbdownid name="construct.c.stbdownid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stbdownid  #顯示到畫面上
            NEXT FIELD stbdownid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbdownid
            #add-point:BEFORE FIELD stbdownid name="construct.b.stbdownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbdownid
            
            #add-point:AFTER FIELD stbdownid name="construct.a.stbdownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stbdowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbdowndp
            #add-point:ON ACTION controlp INFIELD stbdowndp name="construct.c.stbdowndp"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stbdowndp  #顯示到畫面上
            NEXT FIELD stbdowndp                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbdowndp
            #add-point:BEFORE FIELD stbdowndp name="construct.b.stbdowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbdowndp
            
            #add-point:AFTER FIELD stbdowndp name="construct.a.stbdowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stbdcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbdcrtid
            #add-point:ON ACTION controlp INFIELD stbdcrtid name="construct.c.stbdcrtid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stbdcrtid  #顯示到畫面上
            NEXT FIELD stbdcrtid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbdcrtid
            #add-point:BEFORE FIELD stbdcrtid name="construct.b.stbdcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbdcrtid
            
            #add-point:AFTER FIELD stbdcrtid name="construct.a.stbdcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stbdcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbdcrtdp
            #add-point:ON ACTION controlp INFIELD stbdcrtdp name="construct.c.stbdcrtdp"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stbdcrtdp  #顯示到畫面上
            NEXT FIELD stbdcrtdp                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbdcrtdp
            #add-point:BEFORE FIELD stbdcrtdp name="construct.b.stbdcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbdcrtdp
            
            #add-point:AFTER FIELD stbdcrtdp name="construct.a.stbdcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbdcrtdt
            #add-point:BEFORE FIELD stbdcrtdt name="construct.b.stbdcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.stbdmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbdmodid
            #add-point:ON ACTION controlp INFIELD stbdmodid name="construct.c.stbdmodid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stbdmodid  #顯示到畫面上
            NEXT FIELD stbdmodid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbdmodid
            #add-point:BEFORE FIELD stbdmodid name="construct.b.stbdmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbdmodid
            
            #add-point:AFTER FIELD stbdmodid name="construct.a.stbdmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbdmoddt
            #add-point:BEFORE FIELD stbdmoddt name="construct.b.stbdmoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.stbdcnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbdcnfid
            #add-point:ON ACTION controlp INFIELD stbdcnfid name="construct.c.stbdcnfid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stbdcnfid  #顯示到畫面上
            NEXT FIELD stbdcnfid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbdcnfid
            #add-point:BEFORE FIELD stbdcnfid name="construct.b.stbdcnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbdcnfid
            
            #add-point:AFTER FIELD stbdcnfid name="construct.a.stbdcnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbdcnfdt
            #add-point:BEFORE FIELD stbdcnfdt name="construct.b.stbdcnfdt"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd007
            #add-point:BEFORE FIELD stbd007 name="construct.b.stbd007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd007
            
            #add-point:AFTER FIELD stbd007 name="construct.a.stbd007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stbd007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd007
            #add-point:ON ACTION controlp INFIELD stbd007 name="construct.c.stbd007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd052
            #add-point:BEFORE FIELD stbd052 name="construct.b.stbd052"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd052
            
            #add-point:AFTER FIELD stbd052 name="construct.a.stbd052"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stbd052
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd052
            #add-point:ON ACTION controlp INFIELD stbd052 name="construct.c.stbd052"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd051
            #add-point:BEFORE FIELD stbd051 name="construct.b.stbd051"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd051
            
            #add-point:AFTER FIELD stbd051 name="construct.a.stbd051"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stbd051
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd051
            #add-point:ON ACTION controlp INFIELD stbd051 name="construct.c.stbd051"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd053
            #add-point:BEFORE FIELD stbd053 name="construct.b.stbd053"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd053
            
            #add-point:AFTER FIELD stbd053 name="construct.a.stbd053"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stbd053
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd053
            #add-point:ON ACTION controlp INFIELD stbd053 name="construct.c.stbd053"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd008
            #add-point:BEFORE FIELD stbd008 name="construct.b.stbd008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd008
            
            #add-point:AFTER FIELD stbd008 name="construct.a.stbd008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stbd008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd008
            #add-point:ON ACTION controlp INFIELD stbd008 name="construct.c.stbd008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd054
            #add-point:BEFORE FIELD stbd054 name="construct.b.stbd054"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd054
            
            #add-point:AFTER FIELD stbd054 name="construct.a.stbd054"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stbd054
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd054
            #add-point:ON ACTION controlp INFIELD stbd054 name="construct.c.stbd054"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd009
            #add-point:BEFORE FIELD stbd009 name="construct.b.stbd009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd009
            
            #add-point:AFTER FIELD stbd009 name="construct.a.stbd009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stbd009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd009
            #add-point:ON ACTION controlp INFIELD stbd009 name="construct.c.stbd009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd055
            #add-point:BEFORE FIELD stbd055 name="construct.b.stbd055"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd055
            
            #add-point:AFTER FIELD stbd055 name="construct.a.stbd055"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stbd055
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd055
            #add-point:ON ACTION controlp INFIELD stbd055 name="construct.c.stbd055"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd010
            #add-point:BEFORE FIELD stbd010 name="construct.b.stbd010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd010
            
            #add-point:AFTER FIELD stbd010 name="construct.a.stbd010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stbd010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd010
            #add-point:ON ACTION controlp INFIELD stbd010 name="construct.c.stbd010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd056
            #add-point:BEFORE FIELD stbd056 name="construct.b.stbd056"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd056
            
            #add-point:AFTER FIELD stbd056 name="construct.a.stbd056"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stbd056
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd056
            #add-point:ON ACTION controlp INFIELD stbd056 name="construct.c.stbd056"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd011
            #add-point:BEFORE FIELD stbd011 name="construct.b.stbd011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd011
            
            #add-point:AFTER FIELD stbd011 name="construct.a.stbd011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stbd011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd011
            #add-point:ON ACTION controlp INFIELD stbd011 name="construct.c.stbd011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd057
            #add-point:BEFORE FIELD stbd057 name="construct.b.stbd057"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd057
            
            #add-point:AFTER FIELD stbd057 name="construct.a.stbd057"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stbd057
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd057
            #add-point:ON ACTION controlp INFIELD stbd057 name="construct.c.stbd057"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd012
            #add-point:BEFORE FIELD stbd012 name="construct.b.stbd012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd012
            
            #add-point:AFTER FIELD stbd012 name="construct.a.stbd012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stbd012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd012
            #add-point:ON ACTION controlp INFIELD stbd012 name="construct.c.stbd012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd058
            #add-point:BEFORE FIELD stbd058 name="construct.b.stbd058"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd058
            
            #add-point:AFTER FIELD stbd058 name="construct.a.stbd058"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stbd058
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd058
            #add-point:ON ACTION controlp INFIELD stbd058 name="construct.c.stbd058"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd013
            #add-point:BEFORE FIELD stbd013 name="construct.b.stbd013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd013
            
            #add-point:AFTER FIELD stbd013 name="construct.a.stbd013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stbd013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd013
            #add-point:ON ACTION controlp INFIELD stbd013 name="construct.c.stbd013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd059
            #add-point:BEFORE FIELD stbd059 name="construct.b.stbd059"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd059
            
            #add-point:AFTER FIELD stbd059 name="construct.a.stbd059"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stbd059
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd059
            #add-point:ON ACTION controlp INFIELD stbd059 name="construct.c.stbd059"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd014
            #add-point:BEFORE FIELD stbd014 name="construct.b.stbd014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd014
            
            #add-point:AFTER FIELD stbd014 name="construct.a.stbd014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stbd014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd014
            #add-point:ON ACTION controlp INFIELD stbd014 name="construct.c.stbd014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd017
            #add-point:BEFORE FIELD stbd017 name="construct.b.stbd017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd017
            
            #add-point:AFTER FIELD stbd017 name="construct.a.stbd017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stbd017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd017
            #add-point:ON ACTION controlp INFIELD stbd017 name="construct.c.stbd017"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd018
            #add-point:BEFORE FIELD stbd018 name="construct.b.stbd018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd018
            
            #add-point:AFTER FIELD stbd018 name="construct.a.stbd018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stbd018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd018
            #add-point:ON ACTION controlp INFIELD stbd018 name="construct.c.stbd018"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd016
            #add-point:BEFORE FIELD stbd016 name="construct.b.stbd016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd016
            
            #add-point:AFTER FIELD stbd016 name="construct.a.stbd016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stbd016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd016
            #add-point:ON ACTION controlp INFIELD stbd016 name="construct.c.stbd016"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd019
            #add-point:BEFORE FIELD stbd019 name="construct.b.stbd019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd019
            
            #add-point:AFTER FIELD stbd019 name="construct.a.stbd019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stbd019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd019
            #add-point:ON ACTION controlp INFIELD stbd019 name="construct.c.stbd019"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd045
            #add-point:BEFORE FIELD stbd045 name="construct.b.stbd045"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd045
            
            #add-point:AFTER FIELD stbd045 name="construct.a.stbd045"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stbd045
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd045
            #add-point:ON ACTION controlp INFIELD stbd045 name="construct.c.stbd045"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd015
            #add-point:BEFORE FIELD stbd015 name="construct.b.stbd015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd015
            
            #add-point:AFTER FIELD stbd015 name="construct.a.stbd015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stbd015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd015
            #add-point:ON ACTION controlp INFIELD stbd015 name="construct.c.stbd015"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd040
            #add-point:BEFORE FIELD stbd040 name="construct.b.stbd040"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd040
            
            #add-point:AFTER FIELD stbd040 name="construct.a.stbd040"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stbd040
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd040
            #add-point:ON ACTION controlp INFIELD stbd040 name="construct.c.stbd040"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd039
            #add-point:BEFORE FIELD stbd039 name="construct.b.stbd039"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd039
            
            #add-point:AFTER FIELD stbd039 name="construct.a.stbd039"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stbd039
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd039
            #add-point:ON ACTION controlp INFIELD stbd039 name="construct.c.stbd039"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd020
            #add-point:BEFORE FIELD stbd020 name="construct.b.stbd020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd020
            
            #add-point:AFTER FIELD stbd020 name="construct.a.stbd020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stbd020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd020
            #add-point:ON ACTION controlp INFIELD stbd020 name="construct.c.stbd020"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd042
            #add-point:BEFORE FIELD stbd042 name="construct.b.stbd042"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd042
            
            #add-point:AFTER FIELD stbd042 name="construct.a.stbd042"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stbd042
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd042
            #add-point:ON ACTION controlp INFIELD stbd042 name="construct.c.stbd042"
            
            #END add-point
 
 
         #Ctrlp:construct.c.stbd021
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd021
            #add-point:ON ACTION controlp INFIELD stbd021 name="construct.c.stbd021"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            
            CALL q_ooag001()                      
            DISPLAY g_qryparam.return1 TO stbd021 
            
            NEXT FIELD stbd021  
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd021
            #add-point:BEFORE FIELD stbd021 name="construct.b.stbd021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd021
            
            #add-point:AFTER FIELD stbd021 name="construct.a.stbd021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stbd022
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd022
            #add-point:ON ACTION controlp INFIELD stbd022 name="construct.c.stbd022"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            
            CALL q_ooeg001()    
            
            DISPLAY g_qryparam.return1 TO stbd022  
            NEXT FIELD stbd022  
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd022
            #add-point:BEFORE FIELD stbd022 name="construct.b.stbd022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd022
            
            #add-point:AFTER FIELD stbd022 name="construct.a.stbd022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stje019
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stje019
            #add-point:ON ACTION controlp INFIELD stje019 name="construct.c.stje019"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mhaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stje019  #顯示到畫面上
            NEXT FIELD stje019                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stje019
            #add-point:BEFORE FIELD stje019 name="construct.b.stje019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stje019
            
            #add-point:AFTER FIELD stje019 name="construct.a.stje019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stje020
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stje020
            #add-point:ON ACTION controlp INFIELD stje020 name="construct.c.stje020"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mhab002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stje020  #顯示到畫面上
            NEXT FIELD stje020                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stje020
            #add-point:BEFORE FIELD stje020 name="construct.b.stje020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stje020
            
            #add-point:AFTER FIELD stje020 name="construct.a.stje020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stje021
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stje021
            #add-point:ON ACTION controlp INFIELD stje021 name="construct.c.stje021"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mhac003()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stje021  #顯示到畫面上
            NEXT FIELD stje021                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stje021
            #add-point:BEFORE FIELD stje021 name="construct.b.stje021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stje021
            
            #add-point:AFTER FIELD stje021 name="construct.a.stje021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stbd023
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd023
            #add-point:ON ACTION controlp INFIELD stbd023 name="construct.c.stbd023"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            
            IF s_aooi500_setpoint(g_prog,'stbd023') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'stbd023',g_site,'c')
               CALL q_ooef001_24()   
            ELSE
               CALL q_ooef001_23() 
            END IF
            
            DISPLAY g_qryparam.return1 TO stbd023 
            NEXT FIELD stbd023  
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd023
            #add-point:BEFORE FIELD stbd023 name="construct.b.stbd023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd023
            
            #add-point:AFTER FIELD stbd023 name="construct.a.stbd023"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd024
            #add-point:BEFORE FIELD stbd024 name="construct.b.stbd024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd024
            
            #add-point:AFTER FIELD stbd024 name="construct.a.stbd024"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stbd024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd024
            #add-point:ON ACTION controlp INFIELD stbd024 name="construct.c.stbd024"
            
            #END add-point
 
 
         #Ctrlp:construct.c.stbd025
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd025
            #add-point:ON ACTION controlp INFIELD stbd025 name="construct.c.stbd025"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_nmab001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stbd025  #顯示到畫面上
            NEXT FIELD stbd025                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd025
            #add-point:BEFORE FIELD stbd025 name="construct.b.stbd025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd025
            
            #add-point:AFTER FIELD stbd025 name="construct.a.stbd025"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd026
            #add-point:BEFORE FIELD stbd026 name="construct.b.stbd026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd026
            
            #add-point:AFTER FIELD stbd026 name="construct.a.stbd026"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stbd026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd026
            #add-point:ON ACTION controlp INFIELD stbd026 name="construct.c.stbd026"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd027
            #add-point:BEFORE FIELD stbd027 name="construct.b.stbd027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd027
            
            #add-point:AFTER FIELD stbd027 name="construct.a.stbd027"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stbd027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd027
            #add-point:ON ACTION controlp INFIELD stbd027 name="construct.c.stbd027"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd028
            #add-point:BEFORE FIELD stbd028 name="construct.b.stbd028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd028
            
            #add-point:AFTER FIELD stbd028 name="construct.a.stbd028"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stbd028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd028
            #add-point:ON ACTION controlp INFIELD stbd028 name="construct.c.stbd028"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd029
            #add-point:BEFORE FIELD stbd029 name="construct.b.stbd029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd029
            
            #add-point:AFTER FIELD stbd029 name="construct.a.stbd029"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stbd029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd029
            #add-point:ON ACTION controlp INFIELD stbd029 name="construct.c.stbd029"
            
            #END add-point
 
 
         #Ctrlp:construct.c.stbd030
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd030
            #add-point:ON ACTION controlp INFIELD stbd030 name="construct.c.stbd030"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stbd030  #顯示到畫面上
            NEXT FIELD stbd030                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd030
            #add-point:BEFORE FIELD stbd030 name="construct.b.stbd030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd030
            
            #add-point:AFTER FIELD stbd030 name="construct.a.stbd030"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd031
            #add-point:BEFORE FIELD stbd031 name="construct.b.stbd031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd031
            
            #add-point:AFTER FIELD stbd031 name="construct.a.stbd031"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stbd031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd031
            #add-point:ON ACTION controlp INFIELD stbd031 name="construct.c.stbd031"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd032
            #add-point:BEFORE FIELD stbd032 name="construct.b.stbd032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd032
            
            #add-point:AFTER FIELD stbd032 name="construct.a.stbd032"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stbd032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd032
            #add-point:ON ACTION controlp INFIELD stbd032 name="construct.c.stbd032"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd034
            #add-point:BEFORE FIELD stbd034 name="construct.b.stbd034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd034
            
            #add-point:AFTER FIELD stbd034 name="construct.a.stbd034"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stbd034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd034
            #add-point:ON ACTION controlp INFIELD stbd034 name="construct.c.stbd034"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd035
            #add-point:BEFORE FIELD stbd035 name="construct.b.stbd035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd035
            
            #add-point:AFTER FIELD stbd035 name="construct.a.stbd035"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stbd035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd035
            #add-point:ON ACTION controlp INFIELD stbd035 name="construct.c.stbd035"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd036
            #add-point:BEFORE FIELD stbd036 name="construct.b.stbd036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd036
            
            #add-point:AFTER FIELD stbd036 name="construct.a.stbd036"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stbd036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd036
            #add-point:ON ACTION controlp INFIELD stbd036 name="construct.c.stbd036"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd047
            #add-point:BEFORE FIELD stbd047 name="construct.b.stbd047"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd047
            
            #add-point:AFTER FIELD stbd047 name="construct.a.stbd047"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stbd047
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd047
            #add-point:ON ACTION controlp INFIELD stbd047 name="construct.c.stbd047"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON stbeseq,stbe001,stbe002,stbe003,stbe004,stbe028,stbe005,stbe035,stbe036, 
          stbe024,stbe025,l_stae003,stbe006,stbe007,stbe008,stbe009,stbe009_desc,stbe010,stbe011,stbe012, 
          stbe013,stbe014,stbe015,stbe016,stbe026,stbe027,stbe017,stbe018,stbe033,stbe031,stbe034,stbesite, 
          stbe020,stbe019,stbe032,stbecomp,stbe021,stbe022,stbe023
           FROM s_detail1[1].stbeseq,s_detail1[1].stbe001,s_detail1[1].stbe002,s_detail1[1].stbe003, 
               s_detail1[1].stbe004,s_detail1[1].stbe028,s_detail1[1].stbe005,s_detail1[1].stbe035,s_detail1[1].stbe036, 
               s_detail1[1].stbe024,s_detail1[1].stbe025,s_detail1[1].l_stae003,s_detail1[1].stbe006, 
               s_detail1[1].stbe007,s_detail1[1].stbe008,s_detail1[1].stbe009,s_detail1[1].stbe009_desc, 
               s_detail1[1].stbe010,s_detail1[1].stbe011,s_detail1[1].stbe012,s_detail1[1].stbe013,s_detail1[1].stbe014, 
               s_detail1[1].stbe015,s_detail1[1].stbe016,s_detail1[1].stbe026,s_detail1[1].stbe027,s_detail1[1].stbe017, 
               s_detail1[1].stbe018,s_detail1[1].stbe033,s_detail1[1].stbe031,s_detail1[1].stbe034,s_detail1[1].stbesite, 
               s_detail1[1].stbe020,s_detail1[1].stbe019,s_detail1[1].stbe032,s_detail1[1].stbecomp, 
               s_detail1[1].stbe021,s_detail1[1].stbe022,s_detail1[1].stbe023
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbeseq
            #add-point:BEFORE FIELD stbeseq name="construct.b.page1.stbeseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbeseq
            
            #add-point:AFTER FIELD stbeseq name="construct.a.page1.stbeseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.stbeseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbeseq
            #add-point:ON ACTION controlp INFIELD stbeseq name="construct.c.page1.stbeseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe001
            #add-point:BEFORE FIELD stbe001 name="construct.b.page1.stbe001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe001
            
            #add-point:AFTER FIELD stbe001 name="construct.a.page1.stbe001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.stbe001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe001
            #add-point:ON ACTION controlp INFIELD stbe001 name="construct.c.page1.stbe001"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.stbe002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe002
            #add-point:ON ACTION controlp INFIELD stbe002 name="construct.c.page1.stbe002"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            
            CALL q_stbc004_3()        
            
            DISPLAY g_qryparam.return1 TO stbe002 
            NEXT FIELD stbe002   
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe002
            #add-point:BEFORE FIELD stbe002 name="construct.b.page1.stbe002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe002
            
            #add-point:AFTER FIELD stbe002 name="construct.a.page1.stbe002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe003
            #add-point:BEFORE FIELD stbe003 name="construct.b.page1.stbe003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe003
            
            #add-point:AFTER FIELD stbe003 name="construct.a.page1.stbe003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.stbe003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe003
            #add-point:ON ACTION controlp INFIELD stbe003 name="construct.c.page1.stbe003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe004
            #add-point:BEFORE FIELD stbe004 name="construct.b.page1.stbe004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe004
            
            #add-point:AFTER FIELD stbe004 name="construct.a.page1.stbe004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.stbe004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe004
            #add-point:ON ACTION controlp INFIELD stbe004 name="construct.c.page1.stbe004"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.stbe028
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe028
            #add-point:ON ACTION controlp INFIELD stbe028 name="construct.c.page1.stbe028"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mhbe001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stbe028  #顯示到畫面上
            NEXT FIELD stbe028                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe028
            #add-point:BEFORE FIELD stbe028 name="construct.b.page1.stbe028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe028
            
            #add-point:AFTER FIELD stbe028 name="construct.a.page1.stbe028"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.stbe005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe005
            #add-point:ON ACTION controlp INFIELD stbe005 name="construct.c.page1.stbe005"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_stae001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stbe005  #顯示到畫面上
            NEXT FIELD stbe005                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe005
            #add-point:BEFORE FIELD stbe005 name="construct.b.page1.stbe005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe005
            
            #add-point:AFTER FIELD stbe005 name="construct.a.page1.stbe005"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe035
            #add-point:BEFORE FIELD stbe035 name="construct.b.page1.stbe035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe035
            
            #add-point:AFTER FIELD stbe035 name="construct.a.page1.stbe035"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.stbe035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe035
            #add-point:ON ACTION controlp INFIELD stbe035 name="construct.c.page1.stbe035"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.stbe036
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe036
            #add-point:ON ACTION controlp INFIELD stbe036 name="construct.c.page1.stbe036"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            #160510-00010#8 160514 by lori add---(S)
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            
            IF s_aooi500_setpoint(g_prog,'stbe036') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'stbe036',g_site,'c')
               CALL q_ooef001_24()                   
            ELSE
               #CALL q_ooef001_1()       #161024-00025#2 mark
               CALL q_ooef001_24()       #161024-00025#2 add
            END IF             
            
            DISPLAY g_qryparam.return1 TO stbe036  
            NEXT FIELD stbe036 
            #160510-00010#8 160514 by lori add---(E)
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe036
            #add-point:BEFORE FIELD stbe036 name="construct.b.page1.stbe036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe036
            
            #add-point:AFTER FIELD stbe036 name="construct.a.page1.stbe036"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe024
            #add-point:BEFORE FIELD stbe024 name="construct.b.page1.stbe024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe024
            
            #add-point:AFTER FIELD stbe024 name="construct.a.page1.stbe024"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.stbe024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe024
            #add-point:ON ACTION controlp INFIELD stbe024 name="construct.c.page1.stbe024"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe025
            #add-point:BEFORE FIELD stbe025 name="construct.b.page1.stbe025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe025
            
            #add-point:AFTER FIELD stbe025 name="construct.a.page1.stbe025"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.stbe025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe025
            #add-point:ON ACTION controlp INFIELD stbe025 name="construct.c.page1.stbe025"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.l_stae003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_stae003
            #add-point:ON ACTION controlp INFIELD l_stae003 name="construct.c.page1.l_stae003"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2058'   #160604-00009#15 20160608 add by beckxie
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO l_stae003  #顯示到畫面上
            NEXT FIELD l_stae003                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_stae003
            #add-point:BEFORE FIELD l_stae003 name="construct.b.page1.l_stae003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_stae003
            
            #add-point:AFTER FIELD l_stae003 name="construct.a.page1.l_stae003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe006
            #add-point:BEFORE FIELD stbe006 name="construct.b.page1.stbe006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe006
            
            #add-point:AFTER FIELD stbe006 name="construct.a.page1.stbe006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.stbe006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe006
            #add-point:ON ACTION controlp INFIELD stbe006 name="construct.c.page1.stbe006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe007
            #add-point:BEFORE FIELD stbe007 name="construct.b.page1.stbe007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe007
            
            #add-point:AFTER FIELD stbe007 name="construct.a.page1.stbe007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.stbe007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe007
            #add-point:ON ACTION controlp INFIELD stbe007 name="construct.c.page1.stbe007"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.stbe008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe008
            #add-point:ON ACTION controlp INFIELD stbe008 name="construct.c.page1.stbe008"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stbe008  #顯示到畫面上
            NEXT FIELD stbe008                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe008
            #add-point:BEFORE FIELD stbe008 name="construct.b.page1.stbe008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe008
            
            #add-point:AFTER FIELD stbe008 name="construct.a.page1.stbe008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.stbe009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe009
            #add-point:ON ACTION controlp INFIELD stbe009 name="construct.c.page1.stbe009"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oodb002()                      
            DISPLAY g_qryparam.return1 TO stbe009 
            NEXT FIELD stbe009 
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe009
            #add-point:BEFORE FIELD stbe009 name="construct.b.page1.stbe009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe009
            
            #add-point:AFTER FIELD stbe009 name="construct.a.page1.stbe009"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe009_desc
            #add-point:BEFORE FIELD stbe009_desc name="construct.b.page1.stbe009_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe009_desc
            
            #add-point:AFTER FIELD stbe009_desc name="construct.a.page1.stbe009_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.stbe009_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe009_desc
            #add-point:ON ACTION controlp INFIELD stbe009_desc name="construct.c.page1.stbe009_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe010
            #add-point:BEFORE FIELD stbe010 name="construct.b.page1.stbe010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe010
            
            #add-point:AFTER FIELD stbe010 name="construct.a.page1.stbe010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.stbe010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe010
            #add-point:ON ACTION controlp INFIELD stbe010 name="construct.c.page1.stbe010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe011
            #add-point:BEFORE FIELD stbe011 name="construct.b.page1.stbe011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe011
            
            #add-point:AFTER FIELD stbe011 name="construct.a.page1.stbe011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.stbe011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe011
            #add-point:ON ACTION controlp INFIELD stbe011 name="construct.c.page1.stbe011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe012
            #add-point:BEFORE FIELD stbe012 name="construct.b.page1.stbe012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe012
            
            #add-point:AFTER FIELD stbe012 name="construct.a.page1.stbe012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.stbe012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe012
            #add-point:ON ACTION controlp INFIELD stbe012 name="construct.c.page1.stbe012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe013
            #add-point:BEFORE FIELD stbe013 name="construct.b.page1.stbe013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe013
            
            #add-point:AFTER FIELD stbe013 name="construct.a.page1.stbe013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.stbe013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe013
            #add-point:ON ACTION controlp INFIELD stbe013 name="construct.c.page1.stbe013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe014
            #add-point:BEFORE FIELD stbe014 name="construct.b.page1.stbe014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe014
            
            #add-point:AFTER FIELD stbe014 name="construct.a.page1.stbe014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.stbe014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe014
            #add-point:ON ACTION controlp INFIELD stbe014 name="construct.c.page1.stbe014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe015
            #add-point:BEFORE FIELD stbe015 name="construct.b.page1.stbe015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe015
            
            #add-point:AFTER FIELD stbe015 name="construct.a.page1.stbe015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.stbe015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe015
            #add-point:ON ACTION controlp INFIELD stbe015 name="construct.c.page1.stbe015"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe016
            #add-point:BEFORE FIELD stbe016 name="construct.b.page1.stbe016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe016
            
            #add-point:AFTER FIELD stbe016 name="construct.a.page1.stbe016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.stbe016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe016
            #add-point:ON ACTION controlp INFIELD stbe016 name="construct.c.page1.stbe016"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe026
            #add-point:BEFORE FIELD stbe026 name="construct.b.page1.stbe026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe026
            
            #add-point:AFTER FIELD stbe026 name="construct.a.page1.stbe026"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.stbe026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe026
            #add-point:ON ACTION controlp INFIELD stbe026 name="construct.c.page1.stbe026"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe027
            #add-point:BEFORE FIELD stbe027 name="construct.b.page1.stbe027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe027
            
            #add-point:AFTER FIELD stbe027 name="construct.a.page1.stbe027"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.stbe027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe027
            #add-point:ON ACTION controlp INFIELD stbe027 name="construct.c.page1.stbe027"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.stbe017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe017
            #add-point:ON ACTION controlp INFIELD stbe017 name="construct.c.page1.stbe017"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_staa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stbe017  #顯示到畫面上
            NEXT FIELD stbe017                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe017
            #add-point:BEFORE FIELD stbe017 name="construct.b.page1.stbe017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe017
            
            #add-point:AFTER FIELD stbe017 name="construct.a.page1.stbe017"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe018
            #add-point:BEFORE FIELD stbe018 name="construct.b.page1.stbe018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe018
            
            #add-point:AFTER FIELD stbe018 name="construct.a.page1.stbe018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.stbe018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe018
            #add-point:ON ACTION controlp INFIELD stbe018 name="construct.c.page1.stbe018"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe033
            #add-point:BEFORE FIELD stbe033 name="construct.b.page1.stbe033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe033
            
            #add-point:AFTER FIELD stbe033 name="construct.a.page1.stbe033"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.stbe033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe033
            #add-point:ON ACTION controlp INFIELD stbe033 name="construct.c.page1.stbe033"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe031
            #add-point:BEFORE FIELD stbe031 name="construct.b.page1.stbe031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe031
            
            #add-point:AFTER FIELD stbe031 name="construct.a.page1.stbe031"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.stbe031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe031
            #add-point:ON ACTION controlp INFIELD stbe031 name="construct.c.page1.stbe031"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe034
            #add-point:BEFORE FIELD stbe034 name="construct.b.page1.stbe034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe034
            
            #add-point:AFTER FIELD stbe034 name="construct.a.page1.stbe034"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.stbe034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe034
            #add-point:ON ACTION controlp INFIELD stbe034 name="construct.c.page1.stbe034"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.stbesite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbesite
            #add-point:ON ACTION controlp INFIELD stbesite name="construct.c.page1.stbesite"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001_24()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stbesite  #顯示到畫面上
            NEXT FIELD stbesite                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbesite
            #add-point:BEFORE FIELD stbesite name="construct.b.page1.stbesite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbesite
            
            #add-point:AFTER FIELD stbesite name="construct.a.page1.stbesite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.stbe020
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe020
            #add-point:ON ACTION controlp INFIELD stbe020 name="construct.c.page1.stbe020"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stbe020  #顯示到畫面上
            NEXT FIELD stbe020                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe020
            #add-point:BEFORE FIELD stbe020 name="construct.b.page1.stbe020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe020
            
            #add-point:AFTER FIELD stbe020 name="construct.a.page1.stbe020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.stbe019
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe019
            #add-point:ON ACTION controlp INFIELD stbe019 name="construct.c.page1.stbe019"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stbe019  #顯示到畫面上
            NEXT FIELD stbe019                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe019
            #add-point:BEFORE FIELD stbe019 name="construct.b.page1.stbe019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe019
            
            #add-point:AFTER FIELD stbe019 name="construct.a.page1.stbe019"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe032
            #add-point:BEFORE FIELD stbe032 name="construct.b.page1.stbe032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe032
            
            #add-point:AFTER FIELD stbe032 name="construct.a.page1.stbe032"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.stbe032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe032
            #add-point:ON ACTION controlp INFIELD stbe032 name="construct.c.page1.stbe032"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbecomp
            #add-point:BEFORE FIELD stbecomp name="construct.b.page1.stbecomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbecomp
            
            #add-point:AFTER FIELD stbecomp name="construct.a.page1.stbecomp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.stbecomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbecomp
            #add-point:ON ACTION controlp INFIELD stbecomp name="construct.c.page1.stbecomp"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe021
            #add-point:BEFORE FIELD stbe021 name="construct.b.page1.stbe021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe021
            
            #add-point:AFTER FIELD stbe021 name="construct.a.page1.stbe021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.stbe021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe021
            #add-point:ON ACTION controlp INFIELD stbe021 name="construct.c.page1.stbe021"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe022
            #add-point:BEFORE FIELD stbe022 name="construct.b.page1.stbe022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe022
            
            #add-point:AFTER FIELD stbe022 name="construct.a.page1.stbe022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.stbe022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe022
            #add-point:ON ACTION controlp INFIELD stbe022 name="construct.c.page1.stbe022"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe023
            #add-point:BEFORE FIELD stbe023 name="construct.b.page1.stbe023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe023
            
            #add-point:AFTER FIELD stbe023 name="construct.a.page1.stbe023"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.stbe023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe023
            #add-point:ON ACTION controlp INFIELD stbe023 name="construct.c.page1.stbe023"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
      CONSTRUCT g_wc2_table2 ON stbfseq,stbf001,stbf002,stbf003,stbf004,stbf004_desc,stbf005,stbf009, 
          stbf010,stbf006,stbf007,stbf008,stbf011,stbf012,stbfcomp,stbfsite,stbf013,stbf014,stbf015, 
          stbf016
           FROM s_detail2[1].stbfseq,s_detail2[1].stbf001,s_detail2[1].stbf002,s_detail2[1].stbf003, 
               s_detail2[1].stbf004,s_detail2[1].stbf004_desc,s_detail2[1].stbf005,s_detail2[1].stbf009, 
               s_detail2[1].stbf010,s_detail2[1].stbf006,s_detail2[1].stbf007,s_detail2[1].stbf008,s_detail2[1].stbf011, 
               s_detail2[1].stbf012,s_detail2[1].stbfcomp,s_detail2[1].stbfsite,s_detail2[1].stbf013, 
               s_detail2[1].stbf014,s_detail2[1].stbf015,s_detail2[1].stbf016
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body2.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbfseq
            #add-point:BEFORE FIELD stbfseq name="construct.b.page2.stbfseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbfseq
            
            #add-point:AFTER FIELD stbfseq name="construct.a.page2.stbfseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.stbfseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbfseq
            #add-point:ON ACTION controlp INFIELD stbfseq name="construct.c.page2.stbfseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbf001
            #add-point:BEFORE FIELD stbf001 name="construct.b.page2.stbf001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbf001
            
            #add-point:AFTER FIELD stbf001 name="construct.a.page2.stbf001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.stbf001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbf001
            #add-point:ON ACTION controlp INFIELD stbf001 name="construct.c.page2.stbf001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbf002
            #add-point:BEFORE FIELD stbf002 name="construct.b.page2.stbf002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbf002
            
            #add-point:AFTER FIELD stbf002 name="construct.a.page2.stbf002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.stbf002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbf002
            #add-point:ON ACTION controlp INFIELD stbf002 name="construct.c.page2.stbf002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbf003
            #add-point:BEFORE FIELD stbf003 name="construct.b.page2.stbf003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbf003
            
            #add-point:AFTER FIELD stbf003 name="construct.a.page2.stbf003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.stbf003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbf003
            #add-point:ON ACTION controlp INFIELD stbf003 name="construct.c.page2.stbf003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbf004
            #add-point:BEFORE FIELD stbf004 name="construct.b.page2.stbf004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbf004
            
            #add-point:AFTER FIELD stbf004 name="construct.a.page2.stbf004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.stbf004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbf004
            #add-point:ON ACTION controlp INFIELD stbf004 name="construct.c.page2.stbf004"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oodb002()
            DISPLAY g_qryparam.return1 TO stbf004
            NEXT FIELD stbf004
           
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbf004_desc
            #add-point:BEFORE FIELD stbf004_desc name="construct.b.page2.stbf004_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbf004_desc
            
            #add-point:AFTER FIELD stbf004_desc name="construct.a.page2.stbf004_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.stbf004_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbf004_desc
            #add-point:ON ACTION controlp INFIELD stbf004_desc name="construct.c.page2.stbf004_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbf005
            #add-point:BEFORE FIELD stbf005 name="construct.b.page2.stbf005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbf005
            
            #add-point:AFTER FIELD stbf005 name="construct.a.page2.stbf005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.stbf005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbf005
            #add-point:ON ACTION controlp INFIELD stbf005 name="construct.c.page2.stbf005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbf009
            #add-point:BEFORE FIELD stbf009 name="construct.b.page2.stbf009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbf009
            
            #add-point:AFTER FIELD stbf009 name="construct.a.page2.stbf009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.stbf009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbf009
            #add-point:ON ACTION controlp INFIELD stbf009 name="construct.c.page2.stbf009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbf010
            #add-point:BEFORE FIELD stbf010 name="construct.b.page2.stbf010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbf010
            
            #add-point:AFTER FIELD stbf010 name="construct.a.page2.stbf010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.stbf010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbf010
            #add-point:ON ACTION controlp INFIELD stbf010 name="construct.c.page2.stbf010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbf006
            #add-point:BEFORE FIELD stbf006 name="construct.b.page2.stbf006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbf006
            
            #add-point:AFTER FIELD stbf006 name="construct.a.page2.stbf006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.stbf006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbf006
            #add-point:ON ACTION controlp INFIELD stbf006 name="construct.c.page2.stbf006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbf007
            #add-point:BEFORE FIELD stbf007 name="construct.b.page2.stbf007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbf007
            
            #add-point:AFTER FIELD stbf007 name="construct.a.page2.stbf007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.stbf007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbf007
            #add-point:ON ACTION controlp INFIELD stbf007 name="construct.c.page2.stbf007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbf008
            #add-point:BEFORE FIELD stbf008 name="construct.b.page2.stbf008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbf008
            
            #add-point:AFTER FIELD stbf008 name="construct.a.page2.stbf008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.stbf008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbf008
            #add-point:ON ACTION controlp INFIELD stbf008 name="construct.c.page2.stbf008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbf011
            #add-point:BEFORE FIELD stbf011 name="construct.b.page2.stbf011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbf011
            
            #add-point:AFTER FIELD stbf011 name="construct.a.page2.stbf011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.stbf011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbf011
            #add-point:ON ACTION controlp INFIELD stbf011 name="construct.c.page2.stbf011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbf012
            #add-point:BEFORE FIELD stbf012 name="construct.b.page2.stbf012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbf012
            
            #add-point:AFTER FIELD stbf012 name="construct.a.page2.stbf012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.stbf012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbf012
            #add-point:ON ACTION controlp INFIELD stbf012 name="construct.c.page2.stbf012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbfcomp
            #add-point:BEFORE FIELD stbfcomp name="construct.b.page2.stbfcomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbfcomp
            
            #add-point:AFTER FIELD stbfcomp name="construct.a.page2.stbfcomp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.stbfcomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbfcomp
            #add-point:ON ACTION controlp INFIELD stbfcomp name="construct.c.page2.stbfcomp"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbfsite
            #add-point:BEFORE FIELD stbfsite name="construct.b.page2.stbfsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbfsite
            
            #add-point:AFTER FIELD stbfsite name="construct.a.page2.stbfsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.stbfsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbfsite
            #add-point:ON ACTION controlp INFIELD stbfsite name="construct.c.page2.stbfsite"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbf013
            #add-point:BEFORE FIELD stbf013 name="construct.b.page2.stbf013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbf013
            
            #add-point:AFTER FIELD stbf013 name="construct.a.page2.stbf013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.stbf013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbf013
            #add-point:ON ACTION controlp INFIELD stbf013 name="construct.c.page2.stbf013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbf014
            #add-point:BEFORE FIELD stbf014 name="construct.b.page2.stbf014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbf014
            
            #add-point:AFTER FIELD stbf014 name="construct.a.page2.stbf014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.stbf014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbf014
            #add-point:ON ACTION controlp INFIELD stbf014 name="construct.c.page2.stbf014"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.stbf015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbf015
            #add-point:ON ACTION controlp INFIELD stbf015 name="construct.c.page2.stbf015"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #CALL q_ooef001_01()                           #呼叫開窗   #161024-00025#2 mark
            #161024-00025#2--add--s
            IF s_aooi500_setpoint(g_prog,'stbf015') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'stbf015',g_site,'c') 
               CALL q_ooef001_24()
            ELSE
               LET g_qryparam.where = " ooef203 = 'Y' " 
               CALL q_ooef001_24()
            END IF
            #161024-00025#2--add--e
            DISPLAY g_qryparam.return1 TO stbf015  #顯示到畫面上
            NEXT FIELD stbf015                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbf015
            #add-point:BEFORE FIELD stbf015 name="construct.b.page2.stbf015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbf015
            
            #add-point:AFTER FIELD stbf015 name="construct.a.page2.stbf015"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbf016
            #add-point:BEFORE FIELD stbf016 name="construct.b.page2.stbf016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbf016
            
            #add-point:AFTER FIELD stbf016 name="construct.a.page2.stbf016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.stbf016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbf016
            #add-point:ON ACTION controlp INFIELD stbf016 name="construct.c.page2.stbf016"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table3 ON stbeseq_1,stbe001_1,stbe002_1,stbe003_1,stbe004_1,stbe028_1,stbe005_1, 
          stbe035_1,stbe036_1,stbe024_1,stbe025_1,l_stae003_1,stbe006_1,stbe007_1,stbe008_1,stbe009_1, 
          stbe009_1_desc,stbe010_1,stbe011_1,stbe012_1,stbe013_1,stbe014_1,stbe015_1,stbe016_1,stbe026_1, 
          stbe027_1,stbe017_1,stbe018_1,stbe033_1,stbe031_1,stbe034_1,stbesite_1,stbe020_1,stbe019_1, 
          stbe032_1,stbecomp_1,stbe021_1,stbe022_1,stbe023_1
           FROM s_detail4[1].stbeseq_1,s_detail4[1].stbe001_1,s_detail4[1].stbe002_1,s_detail4[1].stbe003_1, 
               s_detail4[1].stbe004_1,s_detail4[1].stbe028_1,s_detail4[1].stbe005_1,s_detail4[1].stbe035_1, 
               s_detail4[1].stbe036_1,s_detail4[1].stbe024_1,s_detail4[1].stbe025_1,s_detail4[1].l_stae003_1, 
               s_detail4[1].stbe006_1,s_detail4[1].stbe007_1,s_detail4[1].stbe008_1,s_detail4[1].stbe009_1, 
               s_detail4[1].stbe009_1_desc,s_detail4[1].stbe010_1,s_detail4[1].stbe011_1,s_detail4[1].stbe012_1, 
               s_detail4[1].stbe013_1,s_detail4[1].stbe014_1,s_detail4[1].stbe015_1,s_detail4[1].stbe016_1, 
               s_detail4[1].stbe026_1,s_detail4[1].stbe027_1,s_detail4[1].stbe017_1,s_detail4[1].stbe018_1, 
               s_detail4[1].stbe033_1,s_detail4[1].stbe031_1,s_detail4[1].stbe034_1,s_detail4[1].stbesite_1, 
               s_detail4[1].stbe020_1,s_detail4[1].stbe019_1,s_detail4[1].stbe032_1,s_detail4[1].stbecomp_1, 
               s_detail4[1].stbe021_1,s_detail4[1].stbe022_1,s_detail4[1].stbe023_1
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body3.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 3)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbeseq_1
            #add-point:BEFORE FIELD stbeseq_1 name="construct.b.page4.stbeseq_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbeseq_1
            
            #add-point:AFTER FIELD stbeseq_1 name="construct.a.page4.stbeseq_1"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.stbeseq_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbeseq_1
            #add-point:ON ACTION controlp INFIELD stbeseq_1 name="construct.c.page4.stbeseq_1"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe001_1
            #add-point:BEFORE FIELD stbe001_1 name="construct.b.page4.stbe001_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe001_1
            
            #add-point:AFTER FIELD stbe001_1 name="construct.a.page4.stbe001_1"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.stbe001_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe001_1
            #add-point:ON ACTION controlp INFIELD stbe001_1 name="construct.c.page4.stbe001_1"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page4.stbe002_1
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe002_1
            #add-point:ON ACTION controlp INFIELD stbe002_1 name="construct.c.page4.stbe002_1"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            
            CALL q_stbc004_3()        
            
            DISPLAY g_qryparam.return1 TO stbe002_1 
            NEXT FIELD stbe002_1
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe002_1
            #add-point:BEFORE FIELD stbe002_1 name="construct.b.page4.stbe002_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe002_1
            
            #add-point:AFTER FIELD stbe002_1 name="construct.a.page4.stbe002_1"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe003_1
            #add-point:BEFORE FIELD stbe003_1 name="construct.b.page4.stbe003_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe003_1
            
            #add-point:AFTER FIELD stbe003_1 name="construct.a.page4.stbe003_1"
 
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.stbe003_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe003_1
            #add-point:ON ACTION controlp INFIELD stbe003_1 name="construct.c.page4.stbe003_1"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe004_1
            #add-point:BEFORE FIELD stbe004_1 name="construct.b.page4.stbe004_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe004_1
            
            #add-point:AFTER FIELD stbe004_1 name="construct.a.page4.stbe004_1"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.stbe004_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe004_1
            #add-point:ON ACTION controlp INFIELD stbe004_1 name="construct.c.page4.stbe004_1"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page4.stbe028_1
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe028_1
            #add-point:ON ACTION controlp INFIELD stbe028_1 name="construct.c.page4.stbe028_1"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mhbe001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stbe028_1  #顯示到畫面上
            NEXT FIELD stbe028_1                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe028_1
            #add-point:BEFORE FIELD stbe028_1 name="construct.b.page4.stbe028_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe028_1
            
            #add-point:AFTER FIELD stbe028_1 name="construct.a.page4.stbe028_1"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.stbe005_1
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe005_1
            #add-point:ON ACTION controlp INFIELD stbe005_1 name="construct.c.page4.stbe005_1"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_stae001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stbe005_1  #顯示到畫面上
            NEXT FIELD stbe005_1                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe005_1
            #add-point:BEFORE FIELD stbe005_1 name="construct.b.page4.stbe005_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe005_1
            
            #add-point:AFTER FIELD stbe005_1 name="construct.a.page4.stbe005_1"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe035_1
            #add-point:BEFORE FIELD stbe035_1 name="construct.b.page4.stbe035_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe035_1
            
            #add-point:AFTER FIELD stbe035_1 name="construct.a.page4.stbe035_1"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.stbe035_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe035_1
            #add-point:ON ACTION controlp INFIELD stbe035_1 name="construct.c.page4.stbe035_1"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page4.stbe036_1
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe036_1
            #add-point:ON ACTION controlp INFIELD stbe036_1 name="construct.c.page4.stbe036_1"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            #160510-00010#8 160514 by lori add---(S)
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE

            IF s_aooi500_setpoint(g_prog,'stbe036') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'stbe036',g_site,'c')
               CALL q_ooef001_24()                   
            ELSE
               #CALL q_ooef001_1()        #161024-00025#2 mark
               CALL q_ooef001_24()        #161024-00025#2 add
            END IF

            DISPLAY g_qryparam.return1 TO stbe036_1 
            NEXT FIELD stbe036_1                    
            #160510-00010#8 160514 by lori add---(E)            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe036_1
            #add-point:BEFORE FIELD stbe036_1 name="construct.b.page4.stbe036_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe036_1
            
            #add-point:AFTER FIELD stbe036_1 name="construct.a.page4.stbe036_1"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe024_1
            #add-point:BEFORE FIELD stbe024_1 name="construct.b.page4.stbe024_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe024_1
            
            #add-point:AFTER FIELD stbe024_1 name="construct.a.page4.stbe024_1"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.stbe024_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe024_1
            #add-point:ON ACTION controlp INFIELD stbe024_1 name="construct.c.page4.stbe024_1"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe025_1
            #add-point:BEFORE FIELD stbe025_1 name="construct.b.page4.stbe025_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe025_1
            
            #add-point:AFTER FIELD stbe025_1 name="construct.a.page4.stbe025_1"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.stbe025_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe025_1
            #add-point:ON ACTION controlp INFIELD stbe025_1 name="construct.c.page4.stbe025_1"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page4.l_stae003_1
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_stae003_1
            #add-point:ON ACTION controlp INFIELD l_stae003_1 name="construct.c.page4.l_stae003_1"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2058'   #160604-00009#15 20160608 add by beckxie
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO l_stae003_1  #顯示到畫面上
            NEXT FIELD l_stae003_1                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_stae003_1
            #add-point:BEFORE FIELD l_stae003_1 name="construct.b.page4.l_stae003_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_stae003_1
            
            #add-point:AFTER FIELD l_stae003_1 name="construct.a.page4.l_stae003_1"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe006_1
            #add-point:BEFORE FIELD stbe006_1 name="construct.b.page4.stbe006_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe006_1
            
            #add-point:AFTER FIELD stbe006_1 name="construct.a.page4.stbe006_1"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.stbe006_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe006_1
            #add-point:ON ACTION controlp INFIELD stbe006_1 name="construct.c.page4.stbe006_1"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe007_1
            #add-point:BEFORE FIELD stbe007_1 name="construct.b.page4.stbe007_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe007_1
            
            #add-point:AFTER FIELD stbe007_1 name="construct.a.page4.stbe007_1"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.stbe007_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe007_1
            #add-point:ON ACTION controlp INFIELD stbe007_1 name="construct.c.page4.stbe007_1"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page4.stbe008_1
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe008_1
            #add-point:ON ACTION controlp INFIELD stbe008_1 name="construct.c.page4.stbe008_1"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stbe008_1  #顯示到畫面上
            NEXT FIELD stbe008_1                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe008_1
            #add-point:BEFORE FIELD stbe008_1 name="construct.b.page4.stbe008_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe008_1
            
            #add-point:AFTER FIELD stbe008_1 name="construct.a.page4.stbe008_1"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.stbe009_1
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe009_1
            #add-point:ON ACTION controlp INFIELD stbe009_1 name="construct.c.page4.stbe009_1"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oodb002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stbe009_1  #顯示到畫面上
            NEXT FIELD stbe009_1                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe009_1
            #add-point:BEFORE FIELD stbe009_1 name="construct.b.page4.stbe009_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe009_1
            
            #add-point:AFTER FIELD stbe009_1 name="construct.a.page4.stbe009_1"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe009_1_desc
            #add-point:BEFORE FIELD stbe009_1_desc name="construct.b.page4.stbe009_1_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe009_1_desc
            
            #add-point:AFTER FIELD stbe009_1_desc name="construct.a.page4.stbe009_1_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.stbe009_1_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe009_1_desc
            #add-point:ON ACTION controlp INFIELD stbe009_1_desc name="construct.c.page4.stbe009_1_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe010_1
            #add-point:BEFORE FIELD stbe010_1 name="construct.b.page4.stbe010_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe010_1
            
            #add-point:AFTER FIELD stbe010_1 name="construct.a.page4.stbe010_1"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.stbe010_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe010_1
            #add-point:ON ACTION controlp INFIELD stbe010_1 name="construct.c.page4.stbe010_1"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe011_1
            #add-point:BEFORE FIELD stbe011_1 name="construct.b.page4.stbe011_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe011_1
            
            #add-point:AFTER FIELD stbe011_1 name="construct.a.page4.stbe011_1"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.stbe011_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe011_1
            #add-point:ON ACTION controlp INFIELD stbe011_1 name="construct.c.page4.stbe011_1"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe012_1
            #add-point:BEFORE FIELD stbe012_1 name="construct.b.page4.stbe012_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe012_1
            
            #add-point:AFTER FIELD stbe012_1 name="construct.a.page4.stbe012_1"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.stbe012_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe012_1
            #add-point:ON ACTION controlp INFIELD stbe012_1 name="construct.c.page4.stbe012_1"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe013_1
            #add-point:BEFORE FIELD stbe013_1 name="construct.b.page4.stbe013_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe013_1
            
            #add-point:AFTER FIELD stbe013_1 name="construct.a.page4.stbe013_1"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.stbe013_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe013_1
            #add-point:ON ACTION controlp INFIELD stbe013_1 name="construct.c.page4.stbe013_1"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe014_1
            #add-point:BEFORE FIELD stbe014_1 name="construct.b.page4.stbe014_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe014_1
            
            #add-point:AFTER FIELD stbe014_1 name="construct.a.page4.stbe014_1"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.stbe014_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe014_1
            #add-point:ON ACTION controlp INFIELD stbe014_1 name="construct.c.page4.stbe014_1"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe015_1
            #add-point:BEFORE FIELD stbe015_1 name="construct.b.page4.stbe015_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe015_1
            
            #add-point:AFTER FIELD stbe015_1 name="construct.a.page4.stbe015_1"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.stbe015_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe015_1
            #add-point:ON ACTION controlp INFIELD stbe015_1 name="construct.c.page4.stbe015_1"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe016_1
            #add-point:BEFORE FIELD stbe016_1 name="construct.b.page4.stbe016_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe016_1
            
            #add-point:AFTER FIELD stbe016_1 name="construct.a.page4.stbe016_1"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.stbe016_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe016_1
            #add-point:ON ACTION controlp INFIELD stbe016_1 name="construct.c.page4.stbe016_1"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe026_1
            #add-point:BEFORE FIELD stbe026_1 name="construct.b.page4.stbe026_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe026_1
            
            #add-point:AFTER FIELD stbe026_1 name="construct.a.page4.stbe026_1"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.stbe026_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe026_1
            #add-point:ON ACTION controlp INFIELD stbe026_1 name="construct.c.page4.stbe026_1"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe027_1
            #add-point:BEFORE FIELD stbe027_1 name="construct.b.page4.stbe027_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe027_1
            
            #add-point:AFTER FIELD stbe027_1 name="construct.a.page4.stbe027_1"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.stbe027_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe027_1
            #add-point:ON ACTION controlp INFIELD stbe027_1 name="construct.c.page4.stbe027_1"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page4.stbe017_1
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe017_1
            #add-point:ON ACTION controlp INFIELD stbe017_1 name="construct.c.page4.stbe017_1"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_staa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stbe017_1  #顯示到畫面上
            NEXT FIELD stbe017_1                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe017_1
            #add-point:BEFORE FIELD stbe017_1 name="construct.b.page4.stbe017_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe017_1
            
            #add-point:AFTER FIELD stbe017_1 name="construct.a.page4.stbe017_1"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe018_1
            #add-point:BEFORE FIELD stbe018_1 name="construct.b.page4.stbe018_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe018_1
            
            #add-point:AFTER FIELD stbe018_1 name="construct.a.page4.stbe018_1"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.stbe018_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe018_1
            #add-point:ON ACTION controlp INFIELD stbe018_1 name="construct.c.page4.stbe018_1"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe033_1
            #add-point:BEFORE FIELD stbe033_1 name="construct.b.page4.stbe033_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe033_1
            
            #add-point:AFTER FIELD stbe033_1 name="construct.a.page4.stbe033_1"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.stbe033_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe033_1
            #add-point:ON ACTION controlp INFIELD stbe033_1 name="construct.c.page4.stbe033_1"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe031_1
            #add-point:BEFORE FIELD stbe031_1 name="construct.b.page4.stbe031_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe031_1
            
            #add-point:AFTER FIELD stbe031_1 name="construct.a.page4.stbe031_1"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.stbe031_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe031_1
            #add-point:ON ACTION controlp INFIELD stbe031_1 name="construct.c.page4.stbe031_1"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe034_1
            #add-point:BEFORE FIELD stbe034_1 name="construct.b.page4.stbe034_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe034_1
            
            #add-point:AFTER FIELD stbe034_1 name="construct.a.page4.stbe034_1"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.stbe034_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe034_1
            #add-point:ON ACTION controlp INFIELD stbe034_1 name="construct.c.page4.stbe034_1"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page4.stbesite_1
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbesite_1
            #add-point:ON ACTION controlp INFIELD stbesite_1 name="construct.c.page4.stbesite_1"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001_24()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stbesite_1  #顯示到畫面上
            NEXT FIELD stbesite_1                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbesite_1
            #add-point:BEFORE FIELD stbesite_1 name="construct.b.page4.stbesite_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbesite_1
            
            #add-point:AFTER FIELD stbesite_1 name="construct.a.page4.stbesite_1"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe020_1
            #add-point:BEFORE FIELD stbe020_1 name="construct.b.page4.stbe020_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe020_1
            
            #add-point:AFTER FIELD stbe020_1 name="construct.a.page4.stbe020_1"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.stbe020_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe020_1
            #add-point:ON ACTION controlp INFIELD stbe020_1 name="construct.c.page4.stbe020_1"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe019_1
            #add-point:BEFORE FIELD stbe019_1 name="construct.b.page4.stbe019_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe019_1
            
            #add-point:AFTER FIELD stbe019_1 name="construct.a.page4.stbe019_1"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.stbe019_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe019_1
            #add-point:ON ACTION controlp INFIELD stbe019_1 name="construct.c.page4.stbe019_1"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe032_1
            #add-point:BEFORE FIELD stbe032_1 name="construct.b.page4.stbe032_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe032_1
            
            #add-point:AFTER FIELD stbe032_1 name="construct.a.page4.stbe032_1"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.stbe032_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe032_1
            #add-point:ON ACTION controlp INFIELD stbe032_1 name="construct.c.page4.stbe032_1"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbecomp_1
            #add-point:BEFORE FIELD stbecomp_1 name="construct.b.page4.stbecomp_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbecomp_1
            
            #add-point:AFTER FIELD stbecomp_1 name="construct.a.page4.stbecomp_1"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.stbecomp_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbecomp_1
            #add-point:ON ACTION controlp INFIELD stbecomp_1 name="construct.c.page4.stbecomp_1"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe021_1
            #add-point:BEFORE FIELD stbe021_1 name="construct.b.page4.stbe021_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe021_1
            
            #add-point:AFTER FIELD stbe021_1 name="construct.a.page4.stbe021_1"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.stbe021_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe021_1
            #add-point:ON ACTION controlp INFIELD stbe021_1 name="construct.c.page4.stbe021_1"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe022_1
            #add-point:BEFORE FIELD stbe022_1 name="construct.b.page4.stbe022_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe022_1
            
            #add-point:AFTER FIELD stbe022_1 name="construct.a.page4.stbe022_1"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.stbe022_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe022_1
            #add-point:ON ACTION controlp INFIELD stbe022_1 name="construct.c.page4.stbe022_1"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe023_1
            #add-point:BEFORE FIELD stbe023_1 name="construct.b.page4.stbe023_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe023_1
            
            #add-point:AFTER FIELD stbe023_1 name="construct.a.page4.stbe023_1"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.stbe023_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe023_1
            #add-point:ON ACTION controlp INFIELD stbe023_1 name="construct.c.page4.stbe023_1"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table4 ON stbeseq_2,stbe001_2,stbe002_2,stbe003_2,stbe004_2,stbe028_2,stbe005_2, 
          stbe035_2,stbe036_2,stbe024_2,stbe025_2,l_stae003_2,stbe006_2,stbe007_2,stbe008_2,stbe009_2, 
          stbe009_2_desc,stbe010_2,stbe011_2,stbe012_2,stbe013_2,stbe014_2,stbe015_2,stbe016_2,stbe026_2, 
          stbe027_2,stbe017_2,stbe018_2,stbe033_2,stbe031_2,stbe034_2,stbesite_2,stbe020_2,stbe019_2, 
          stbe032_2,stbecomp_2,stbe021_2,stbe022_2,stbe023_2
           FROM s_detail5[1].stbeseq_2,s_detail5[1].stbe001_2,s_detail5[1].stbe002_2,s_detail5[1].stbe003_2, 
               s_detail5[1].stbe004_2,s_detail5[1].stbe028_2,s_detail5[1].stbe005_2,s_detail5[1].stbe035_2, 
               s_detail5[1].stbe036_2,s_detail5[1].stbe024_2,s_detail5[1].stbe025_2,s_detail5[1].l_stae003_2, 
               s_detail5[1].stbe006_2,s_detail5[1].stbe007_2,s_detail5[1].stbe008_2,s_detail5[1].stbe009_2, 
               s_detail5[1].stbe009_2_desc,s_detail5[1].stbe010_2,s_detail5[1].stbe011_2,s_detail5[1].stbe012_2, 
               s_detail5[1].stbe013_2,s_detail5[1].stbe014_2,s_detail5[1].stbe015_2,s_detail5[1].stbe016_2, 
               s_detail5[1].stbe026_2,s_detail5[1].stbe027_2,s_detail5[1].stbe017_2,s_detail5[1].stbe018_2, 
               s_detail5[1].stbe033_2,s_detail5[1].stbe031_2,s_detail5[1].stbe034_2,s_detail5[1].stbesite_2, 
               s_detail5[1].stbe020_2,s_detail5[1].stbe019_2,s_detail5[1].stbe032_2,s_detail5[1].stbecomp_2, 
               s_detail5[1].stbe021_2,s_detail5[1].stbe022_2,s_detail5[1].stbe023_2
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body4.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 4)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbeseq_2
            #add-point:BEFORE FIELD stbeseq_2 name="construct.b.page5.stbeseq_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbeseq_2
            
            #add-point:AFTER FIELD stbeseq_2 name="construct.a.page5.stbeseq_2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.stbeseq_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbeseq_2
            #add-point:ON ACTION controlp INFIELD stbeseq_2 name="construct.c.page5.stbeseq_2"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe001_2
            #add-point:BEFORE FIELD stbe001_2 name="construct.b.page5.stbe001_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe001_2
            
            #add-point:AFTER FIELD stbe001_2 name="construct.a.page5.stbe001_2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.stbe001_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe001_2
            #add-point:ON ACTION controlp INFIELD stbe001_2 name="construct.c.page5.stbe001_2"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page5.stbe002_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe002_2
            #add-point:ON ACTION controlp INFIELD stbe002_2 name="construct.c.page5.stbe002_2"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            
            CALL q_stbc004_3()        
            
            DISPLAY g_qryparam.return1 TO stbe002_2 
            NEXT FIELD stbe002_2
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe002_2
            #add-point:BEFORE FIELD stbe002_2 name="construct.b.page5.stbe002_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe002_2
            
            #add-point:AFTER FIELD stbe002_2 name="construct.a.page5.stbe002_2"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe003_2
            #add-point:BEFORE FIELD stbe003_2 name="construct.b.page5.stbe003_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe003_2
            
            #add-point:AFTER FIELD stbe003_2 name="construct.a.page5.stbe003_2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.stbe003_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe003_2
            #add-point:ON ACTION controlp INFIELD stbe003_2 name="construct.c.page5.stbe003_2"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe004_2
            #add-point:BEFORE FIELD stbe004_2 name="construct.b.page5.stbe004_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe004_2
            
            #add-point:AFTER FIELD stbe004_2 name="construct.a.page5.stbe004_2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.stbe004_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe004_2
            #add-point:ON ACTION controlp INFIELD stbe004_2 name="construct.c.page5.stbe004_2"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page5.stbe028_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe028_2
            #add-point:ON ACTION controlp INFIELD stbe028_2 name="construct.c.page5.stbe028_2"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mhbe001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stbe028_2  #顯示到畫面上
            NEXT FIELD stbe028_2                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe028_2
            #add-point:BEFORE FIELD stbe028_2 name="construct.b.page5.stbe028_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe028_2
            
            #add-point:AFTER FIELD stbe028_2 name="construct.a.page5.stbe028_2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.stbe005_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe005_2
            #add-point:ON ACTION controlp INFIELD stbe005_2 name="construct.c.page5.stbe005_2"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_stae001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stbe005_2  #顯示到畫面上
            NEXT FIELD stbe005_2                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe005_2
            #add-point:BEFORE FIELD stbe005_2 name="construct.b.page5.stbe005_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe005_2
            
            #add-point:AFTER FIELD stbe005_2 name="construct.a.page5.stbe005_2"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe035_2
            #add-point:BEFORE FIELD stbe035_2 name="construct.b.page5.stbe035_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe035_2
            
            #add-point:AFTER FIELD stbe035_2 name="construct.a.page5.stbe035_2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.stbe035_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe035_2
            #add-point:ON ACTION controlp INFIELD stbe035_2 name="construct.c.page5.stbe035_2"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page5.stbe036_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe036_2
            #add-point:ON ACTION controlp INFIELD stbe036_2 name="construct.c.page5.stbe036_2"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            #160510-00010#8 160514 by lori add---(S)
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE

            IF s_aooi500_setpoint(g_prog,'stbe036') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'stbe036',g_site,'c')
               CALL q_ooef001_24()                   
            ELSE
               #CALL q_ooef001_1()          #161024-00025#2 mark
               CALL q_ooef001_24()          #161024-00025#2 add
            END IF

            DISPLAY g_qryparam.return1 TO stbe036_2 
            NEXT FIELD stbe036_2                    
            #160510-00010#8 160514 by lori add---(E)  
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe036_2
            #add-point:BEFORE FIELD stbe036_2 name="construct.b.page5.stbe036_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe036_2
            
            #add-point:AFTER FIELD stbe036_2 name="construct.a.page5.stbe036_2"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe024_2
            #add-point:BEFORE FIELD stbe024_2 name="construct.b.page5.stbe024_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe024_2
            
            #add-point:AFTER FIELD stbe024_2 name="construct.a.page5.stbe024_2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.stbe024_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe024_2
            #add-point:ON ACTION controlp INFIELD stbe024_2 name="construct.c.page5.stbe024_2"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe025_2
            #add-point:BEFORE FIELD stbe025_2 name="construct.b.page5.stbe025_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe025_2
            
            #add-point:AFTER FIELD stbe025_2 name="construct.a.page5.stbe025_2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.stbe025_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe025_2
            #add-point:ON ACTION controlp INFIELD stbe025_2 name="construct.c.page5.stbe025_2"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page5.l_stae003_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_stae003_2
            #add-point:ON ACTION controlp INFIELD l_stae003_2 name="construct.c.page5.l_stae003_2"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2058'   #160604-00009#15 20160608 add by beckxie
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO l_stae003_2  #顯示到畫面上
            NEXT FIELD l_stae003_2                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_stae003_2
            #add-point:BEFORE FIELD l_stae003_2 name="construct.b.page5.l_stae003_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_stae003_2
            
            #add-point:AFTER FIELD l_stae003_2 name="construct.a.page5.l_stae003_2"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe006_2
            #add-point:BEFORE FIELD stbe006_2 name="construct.b.page5.stbe006_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe006_2
            
            #add-point:AFTER FIELD stbe006_2 name="construct.a.page5.stbe006_2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.stbe006_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe006_2
            #add-point:ON ACTION controlp INFIELD stbe006_2 name="construct.c.page5.stbe006_2"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe007_2
            #add-point:BEFORE FIELD stbe007_2 name="construct.b.page5.stbe007_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe007_2
            
            #add-point:AFTER FIELD stbe007_2 name="construct.a.page5.stbe007_2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.stbe007_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe007_2
            #add-point:ON ACTION controlp INFIELD stbe007_2 name="construct.c.page5.stbe007_2"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page5.stbe008_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe008_2
            #add-point:ON ACTION controlp INFIELD stbe008_2 name="construct.c.page5.stbe008_2"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stbe008_2  #顯示到畫面上
            NEXT FIELD stbe008_2                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe008_2
            #add-point:BEFORE FIELD stbe008_2 name="construct.b.page5.stbe008_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe008_2
            
            #add-point:AFTER FIELD stbe008_2 name="construct.a.page5.stbe008_2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.stbe009_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe009_2
            #add-point:ON ACTION controlp INFIELD stbe009_2 name="construct.c.page5.stbe009_2"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oodb002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stbe009_2  #顯示到畫面上
            NEXT FIELD stbe009_2                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe009_2
            #add-point:BEFORE FIELD stbe009_2 name="construct.b.page5.stbe009_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe009_2
            
            #add-point:AFTER FIELD stbe009_2 name="construct.a.page5.stbe009_2"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe009_2_desc
            #add-point:BEFORE FIELD stbe009_2_desc name="construct.b.page5.stbe009_2_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe009_2_desc
            
            #add-point:AFTER FIELD stbe009_2_desc name="construct.a.page5.stbe009_2_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.stbe009_2_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe009_2_desc
            #add-point:ON ACTION controlp INFIELD stbe009_2_desc name="construct.c.page5.stbe009_2_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe010_2
            #add-point:BEFORE FIELD stbe010_2 name="construct.b.page5.stbe010_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe010_2
            
            #add-point:AFTER FIELD stbe010_2 name="construct.a.page5.stbe010_2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.stbe010_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe010_2
            #add-point:ON ACTION controlp INFIELD stbe010_2 name="construct.c.page5.stbe010_2"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe011_2
            #add-point:BEFORE FIELD stbe011_2 name="construct.b.page5.stbe011_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe011_2
            
            #add-point:AFTER FIELD stbe011_2 name="construct.a.page5.stbe011_2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.stbe011_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe011_2
            #add-point:ON ACTION controlp INFIELD stbe011_2 name="construct.c.page5.stbe011_2"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe012_2
            #add-point:BEFORE FIELD stbe012_2 name="construct.b.page5.stbe012_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe012_2
            
            #add-point:AFTER FIELD stbe012_2 name="construct.a.page5.stbe012_2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.stbe012_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe012_2
            #add-point:ON ACTION controlp INFIELD stbe012_2 name="construct.c.page5.stbe012_2"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe013_2
            #add-point:BEFORE FIELD stbe013_2 name="construct.b.page5.stbe013_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe013_2
            
            #add-point:AFTER FIELD stbe013_2 name="construct.a.page5.stbe013_2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.stbe013_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe013_2
            #add-point:ON ACTION controlp INFIELD stbe013_2 name="construct.c.page5.stbe013_2"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe014_2
            #add-point:BEFORE FIELD stbe014_2 name="construct.b.page5.stbe014_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe014_2
            
            #add-point:AFTER FIELD stbe014_2 name="construct.a.page5.stbe014_2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.stbe014_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe014_2
            #add-point:ON ACTION controlp INFIELD stbe014_2 name="construct.c.page5.stbe014_2"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe015_2
            #add-point:BEFORE FIELD stbe015_2 name="construct.b.page5.stbe015_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe015_2
            
            #add-point:AFTER FIELD stbe015_2 name="construct.a.page5.stbe015_2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.stbe015_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe015_2
            #add-point:ON ACTION controlp INFIELD stbe015_2 name="construct.c.page5.stbe015_2"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe016_2
            #add-point:BEFORE FIELD stbe016_2 name="construct.b.page5.stbe016_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe016_2
            
            #add-point:AFTER FIELD stbe016_2 name="construct.a.page5.stbe016_2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.stbe016_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe016_2
            #add-point:ON ACTION controlp INFIELD stbe016_2 name="construct.c.page5.stbe016_2"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe026_2
            #add-point:BEFORE FIELD stbe026_2 name="construct.b.page5.stbe026_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe026_2
            
            #add-point:AFTER FIELD stbe026_2 name="construct.a.page5.stbe026_2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.stbe026_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe026_2
            #add-point:ON ACTION controlp INFIELD stbe026_2 name="construct.c.page5.stbe026_2"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe027_2
            #add-point:BEFORE FIELD stbe027_2 name="construct.b.page5.stbe027_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe027_2
            
            #add-point:AFTER FIELD stbe027_2 name="construct.a.page5.stbe027_2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.stbe027_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe027_2
            #add-point:ON ACTION controlp INFIELD stbe027_2 name="construct.c.page5.stbe027_2"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page5.stbe017_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe017_2
            #add-point:ON ACTION controlp INFIELD stbe017_2 name="construct.c.page5.stbe017_2"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_staa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stbe017_2  #顯示到畫面上
            NEXT FIELD stbe017_2                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe017_2
            #add-point:BEFORE FIELD stbe017_2 name="construct.b.page5.stbe017_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe017_2
            
            #add-point:AFTER FIELD stbe017_2 name="construct.a.page5.stbe017_2"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe018_2
            #add-point:BEFORE FIELD stbe018_2 name="construct.b.page5.stbe018_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe018_2
            
            #add-point:AFTER FIELD stbe018_2 name="construct.a.page5.stbe018_2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.stbe018_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe018_2
            #add-point:ON ACTION controlp INFIELD stbe018_2 name="construct.c.page5.stbe018_2"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe033_2
            #add-point:BEFORE FIELD stbe033_2 name="construct.b.page5.stbe033_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe033_2
            
            #add-point:AFTER FIELD stbe033_2 name="construct.a.page5.stbe033_2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.stbe033_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe033_2
            #add-point:ON ACTION controlp INFIELD stbe033_2 name="construct.c.page5.stbe033_2"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe031_2
            #add-point:BEFORE FIELD stbe031_2 name="construct.b.page5.stbe031_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe031_2
            
            #add-point:AFTER FIELD stbe031_2 name="construct.a.page5.stbe031_2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.stbe031_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe031_2
            #add-point:ON ACTION controlp INFIELD stbe031_2 name="construct.c.page5.stbe031_2"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe034_2
            #add-point:BEFORE FIELD stbe034_2 name="construct.b.page5.stbe034_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe034_2
            
            #add-point:AFTER FIELD stbe034_2 name="construct.a.page5.stbe034_2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.stbe034_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe034_2
            #add-point:ON ACTION controlp INFIELD stbe034_2 name="construct.c.page5.stbe034_2"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page5.stbesite_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbesite_2
            #add-point:ON ACTION controlp INFIELD stbesite_2 name="construct.c.page5.stbesite_2"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001_24()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stbesite_2  #顯示到畫面上
            NEXT FIELD stbesite_2                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbesite_2
            #add-point:BEFORE FIELD stbesite_2 name="construct.b.page5.stbesite_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbesite_2
            
            #add-point:AFTER FIELD stbesite_2 name="construct.a.page5.stbesite_2"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe020_2
            #add-point:BEFORE FIELD stbe020_2 name="construct.b.page5.stbe020_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe020_2
            
            #add-point:AFTER FIELD stbe020_2 name="construct.a.page5.stbe020_2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.stbe020_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe020_2
            #add-point:ON ACTION controlp INFIELD stbe020_2 name="construct.c.page5.stbe020_2"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe019_2
            #add-point:BEFORE FIELD stbe019_2 name="construct.b.page5.stbe019_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe019_2
            
            #add-point:AFTER FIELD stbe019_2 name="construct.a.page5.stbe019_2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.stbe019_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe019_2
            #add-point:ON ACTION controlp INFIELD stbe019_2 name="construct.c.page5.stbe019_2"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe032_2
            #add-point:BEFORE FIELD stbe032_2 name="construct.b.page5.stbe032_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe032_2
            
            #add-point:AFTER FIELD stbe032_2 name="construct.a.page5.stbe032_2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.stbe032_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe032_2
            #add-point:ON ACTION controlp INFIELD stbe032_2 name="construct.c.page5.stbe032_2"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbecomp_2
            #add-point:BEFORE FIELD stbecomp_2 name="construct.b.page5.stbecomp_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbecomp_2
            
            #add-point:AFTER FIELD stbecomp_2 name="construct.a.page5.stbecomp_2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.stbecomp_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbecomp_2
            #add-point:ON ACTION controlp INFIELD stbecomp_2 name="construct.c.page5.stbecomp_2"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe021_2
            #add-point:BEFORE FIELD stbe021_2 name="construct.b.page5.stbe021_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe021_2
            
            #add-point:AFTER FIELD stbe021_2 name="construct.a.page5.stbe021_2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.stbe021_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe021_2
            #add-point:ON ACTION controlp INFIELD stbe021_2 name="construct.c.page5.stbe021_2"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe022_2
            #add-point:BEFORE FIELD stbe022_2 name="construct.b.page5.stbe022_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe022_2
            
            #add-point:AFTER FIELD stbe022_2 name="construct.a.page5.stbe022_2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.stbe022_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe022_2
            #add-point:ON ACTION controlp INFIELD stbe022_2 name="construct.c.page5.stbe022_2"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe023_2
            #add-point:BEFORE FIELD stbe023_2 name="construct.b.page5.stbe023_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe023_2
            
            #add-point:AFTER FIELD stbe023_2 name="construct.a.page5.stbe023_2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.stbe023_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe023_2
            #add-point:ON ACTION controlp INFIELD stbe023_2 name="construct.c.page5.stbe023_2"
            
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
 
            INITIALIZE g_wc2_table3 TO NULL
 
            INITIALIZE g_wc2_table4 TO NULL
 
 
            FOR li_idx = 1 TO la_wc.getLength()
               CASE
                  WHEN la_wc[li_idx].tableid = "stbd_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "stbe_t" 
                     LET g_wc2_table1 = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "stbf_t" 
                     LET g_wc2_table2 = la_wc[li_idx].wc
 
                  WHEN la_wc[li_idx].tableid = "stbe_t" 
                     LET g_wc2_table3 = la_wc[li_idx].wc
 
                  WHEN la_wc[li_idx].tableid = "stbe_t" 
                     LET g_wc2_table4 = la_wc[li_idx].wc
 
 
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
 
   IF g_wc2_table3 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table3
   END IF
 
   IF g_wc2_table4 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table4
   END IF
 
 
 
 
   
   #add-point:cs段結束前 name="cs.after_construct"
   
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="astt840.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION astt840_filter()
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
      CONSTRUCT g_wc_filter ON stbdsite,stbddocdt,stbddocno,stbd001,stbd037,stbd002,stbd004,stbd005, 
          stbd006
                          FROM s_browse[1].b_stbdsite,s_browse[1].b_stbddocdt,s_browse[1].b_stbddocno, 
                              s_browse[1].b_stbd001,s_browse[1].b_stbd037,s_browse[1].b_stbd002,s_browse[1].b_stbd004, 
                              s_browse[1].b_stbd005,s_browse[1].b_stbd006
 
         BEFORE CONSTRUCT
               DISPLAY astt840_filter_parser('stbdsite') TO s_browse[1].b_stbdsite
            DISPLAY astt840_filter_parser('stbddocdt') TO s_browse[1].b_stbddocdt
            DISPLAY astt840_filter_parser('stbddocno') TO s_browse[1].b_stbddocno
            DISPLAY astt840_filter_parser('stbd001') TO s_browse[1].b_stbd001
            DISPLAY astt840_filter_parser('stbd037') TO s_browse[1].b_stbd037
            DISPLAY astt840_filter_parser('stbd002') TO s_browse[1].b_stbd002
            DISPLAY astt840_filter_parser('stbd004') TO s_browse[1].b_stbd004
            DISPLAY astt840_filter_parser('stbd005') TO s_browse[1].b_stbd005
            DISPLAY astt840_filter_parser('stbd006') TO s_browse[1].b_stbd006
      
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
 
      CALL astt840_filter_show('stbdsite')
   CALL astt840_filter_show('stbddocdt')
   CALL astt840_filter_show('stbddocno')
   CALL astt840_filter_show('stbd001')
   CALL astt840_filter_show('stbd037')
   CALL astt840_filter_show('stbd002')
   CALL astt840_filter_show('stbd004')
   CALL astt840_filter_show('stbd005')
   CALL astt840_filter_show('stbd006')
 
END FUNCTION
 
{</section>}
 
{<section id="astt840.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION astt840_filter_parser(ps_field)
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
 
{<section id="astt840.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION astt840_filter_show(ps_field)
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
   LET ls_condition = astt840_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="astt840.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION astt840_query()
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
   CALL g_stbe_d.clear()
   CALL g_stbe2_d.clear()
   CALL g_stbe4_d.clear()
   CALL g_stbe5_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL astt840_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL astt840_browser_fill("")
      CALL astt840_fetch("")
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
   LET g_detail_idx_list[3] = 1
   LET g_detail_idx_list[4] = 1
 
   LET g_error_show  = 1
   LET g_wc_filter   = ""
   LET l_ac = 1
   CALL FGL_SET_ARR_CURR(1)
      CALL astt840_filter_show('stbdsite')
   CALL astt840_filter_show('stbddocdt')
   CALL astt840_filter_show('stbddocno')
   CALL astt840_filter_show('stbd001')
   CALL astt840_filter_show('stbd037')
   CALL astt840_filter_show('stbd002')
   CALL astt840_filter_show('stbd004')
   CALL astt840_filter_show('stbd005')
   CALL astt840_filter_show('stbd006')
   CALL astt840_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL astt840_fetch("F") 
      #顯示單身筆數
      CALL astt840_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="astt840.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION astt840_fetch(p_flag)
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
   
   LET g_stbd_m.stbddocno = g_browser[g_current_idx].b_stbddocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE astt840_master_referesh USING g_stbd_m.stbddocno INTO g_stbd_m.stbdsite,g_stbd_m.stbddocdt, 
       g_stbd_m.stbddocno,g_stbd_m.stbd037,g_stbd_m.stbd002,g_stbd_m.stbd046,g_stbd_m.stbd000,g_stbd_m.stbd001, 
       g_stbd_m.stbd041,g_stbd_m.stbdunit,g_stbd_m.stbd048,g_stbd_m.stbd049,g_stbd_m.stbd050,g_stbd_m.stbd003, 
       g_stbd_m.stbd043,g_stbd_m.stbd044,g_stbd_m.stbd004,g_stbd_m.stbd005,g_stbd_m.stbd006,g_stbd_m.stbd038, 
       g_stbd_m.stbd060,g_stbd_m.stbd033,g_stbd_m.stbdstus,g_stbd_m.stbdownid,g_stbd_m.stbdowndp,g_stbd_m.stbdcrtid, 
       g_stbd_m.stbdcrtdp,g_stbd_m.stbdcrtdt,g_stbd_m.stbdmodid,g_stbd_m.stbdmoddt,g_stbd_m.stbdcnfid, 
       g_stbd_m.stbdcnfdt,g_stbd_m.stbd007,g_stbd_m.stbd052,g_stbd_m.stbd051,g_stbd_m.stbd053,g_stbd_m.stbd008, 
       g_stbd_m.stbd054,g_stbd_m.stbd009,g_stbd_m.stbd055,g_stbd_m.stbd010,g_stbd_m.stbd056,g_stbd_m.stbd011, 
       g_stbd_m.stbd057,g_stbd_m.stbd012,g_stbd_m.stbd058,g_stbd_m.stbd013,g_stbd_m.stbd059,g_stbd_m.stbd014, 
       g_stbd_m.stbd017,g_stbd_m.stbd018,g_stbd_m.stbd016,g_stbd_m.stbd019,g_stbd_m.stbd045,g_stbd_m.stbd015, 
       g_stbd_m.stbd040,g_stbd_m.stbd039,g_stbd_m.stbd020,g_stbd_m.stbd042,g_stbd_m.stbd021,g_stbd_m.stbd022, 
       g_stbd_m.stbd023,g_stbd_m.stbd024,g_stbd_m.stbd025,g_stbd_m.stbd026,g_stbd_m.stbd027,g_stbd_m.stbd028, 
       g_stbd_m.stbd029,g_stbd_m.stbd030,g_stbd_m.stbd031,g_stbd_m.stbd032,g_stbd_m.stbd034,g_stbd_m.stbd035, 
       g_stbd_m.stbd036,g_stbd_m.stbd047,g_stbd_m.stbdsite_desc,g_stbd_m.stbd037_desc,g_stbd_m.stbd002_desc, 
       g_stbd_m.stbd046_desc,g_stbd_m.stbdunit_desc,g_stbd_m.stbd049_desc,g_stbd_m.stbd050_desc,g_stbd_m.stbdownid_desc, 
       g_stbd_m.stbdowndp_desc,g_stbd_m.stbdcrtid_desc,g_stbd_m.stbdcrtdp_desc,g_stbd_m.stbdmodid_desc, 
       g_stbd_m.stbdcnfid_desc,g_stbd_m.stbd021_desc,g_stbd_m.stbd022_desc,g_stbd_m.stbd023_desc,g_stbd_m.stbd025_desc, 
       g_stbd_m.stbd030_desc
   
   #遮罩相關處理
   LET g_stbd_m_mask_o.* =  g_stbd_m.*
   CALL astt840_stbd_t_mask()
   LET g_stbd_m_mask_n.* =  g_stbd_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL astt840_set_act_visible()   
   CALL astt840_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_stbd_m_t.* = g_stbd_m.*
   LET g_stbd_m_o.* = g_stbd_m.*
   
   LET g_data_owner = g_stbd_m.stbdownid      
   LET g_data_dept  = g_stbd_m.stbdowndp
   
   #重新顯示   
   CALL astt840_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="astt840.insert" >}
#+ 資料新增
PRIVATE FUNCTION astt840_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   DEFINE l_insert        LIKE type_t.num5
   DEFINE l_success       LIKE type_t.num5
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_stbe_d.clear()   
   CALL g_stbe2_d.clear()  
   CALL g_stbe4_d.clear()  
   CALL g_stbe5_d.clear()  
 
 
   INITIALIZE g_stbd_m.* TO NULL             #DEFAULT 設定
   
   LET g_stbddocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_stbd_m.stbdownid = g_user
      LET g_stbd_m.stbdowndp = g_dept
      LET g_stbd_m.stbdcrtid = g_user
      LET g_stbd_m.stbdcrtdp = g_dept 
      LET g_stbd_m.stbdcrtdt = cl_get_current()
      LET g_stbd_m.stbdmodid = g_user
      LET g_stbd_m.stbdmoddt = cl_get_current()
      LET g_stbd_m.stbdstus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_stbd_m.stbd000 = "3"
      LET g_stbd_m.stbd003 = "5"
      LET g_stbd_m.stbd060 = "0"
      LET g_stbd_m.stbd007 = "0"
      LET g_stbd_m.stbd052 = "0"
      LET g_stbd_m.stbd051 = "0"
      LET g_stbd_m.stbd053 = "0"
      LET g_stbd_m.stbd008 = "0"
      LET g_stbd_m.stbd054 = "0"
      LET g_stbd_m.stbd009 = "0"
      LET g_stbd_m.stbd055 = "0"
      LET g_stbd_m.stbd010 = "0"
      LET g_stbd_m.stbd056 = "0"
      LET g_stbd_m.stbd011 = "0"
      LET g_stbd_m.stbd057 = "0"
      LET g_stbd_m.stbd012 = "0"
      LET g_stbd_m.stbd058 = "0"
      LET g_stbd_m.stbd013 = "0"
      LET g_stbd_m.stbd059 = "0"
      LET g_stbd_m.stbd014 = "0"
      LET g_stbd_m.stbd017 = "0"
      LET g_stbd_m.stbd018 = "0"
      LET g_stbd_m.stbd019 = "0"
      LET g_stbd_m.stbd045 = "0"
      LET g_stbd_m.stbd015 = "0"
      LET g_stbd_m.stbd040 = "0"
      LET g_stbd_m.stbd039 = "1"
      LET g_stbd_m.stbd020 = "0"
      LET g_stbd_m.stbd034 = "0"
      LET g_stbd_m.stbd035 = "0"
      LET g_stbd_m.stbd036 = "0"
 
  
      #add-point:單頭預設值 name="insert.default"
      #營運組織
      LET g_ins_site_flag = ''   
      CALL s_aooi500_default(g_prog,'stbdsite',g_stbd_m.stbdsite)
         RETURNING l_insert,g_stbd_m.stbdsite
      IF l_insert = FALSE THEN
         RETURN
      ELSE
         LET g_stbd_m.stbdsite_desc = s_desc_get_department_desc(g_stbd_m.stbdsite)
      END IF      
      
      #單據日期
      LET g_stbd_m.stbddocdt = g_today   
      
      #預設單別
      LET l_success = ''
      CALL s_arti200_get_def_doc_type(g_stbd_m.stbdsite,g_prog,'1')
         RETURNING l_success,g_stbd_m.stbddocno
         
      #業務人員
      LET g_stbd_m.stbd021 = g_user     
      LET g_stbd_m.stbd021_desc = s_desc_get_person_desc(g_stbd_m.stbd021)

      #業務部門
      LET g_stbd_m.stbd022 = g_dept     
      LET g_stbd_m.stbd022_desc = s_desc_get_department_desc(g_stbd_m.stbd022)
      
      #結算地點
      LET g_stbd_m.stbd023 = g_site   
      LET g_stbd_m.stbd023_desc = s_desc_get_department_desc(g_stbd_m.stbd023)
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_stbd_m_t.* = g_stbd_m.*
      LET g_stbd_m_o.* = g_stbd_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_stbd_m.stbdstus 
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
         WHEN "J"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/reconciliate.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
    
      CALL astt840_input("a")
      
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
         INITIALIZE g_stbd_m.* TO NULL
         INITIALIZE g_stbe_d TO NULL
         INITIALIZE g_stbe2_d TO NULL
         INITIALIZE g_stbe4_d TO NULL
         INITIALIZE g_stbe5_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL astt840_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_stbe_d.clear()
      #CALL g_stbe2_d.clear()
      #CALL g_stbe4_d.clear()
      #CALL g_stbe5_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL astt840_set_act_visible()   
   CALL astt840_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_stbddocno_t = g_stbd_m.stbddocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " stbdent = " ||g_enterprise|| " AND",
                      " stbddocno = '", g_stbd_m.stbddocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL astt840_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE astt840_cl
   
   CALL astt840_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE astt840_master_referesh USING g_stbd_m.stbddocno INTO g_stbd_m.stbdsite,g_stbd_m.stbddocdt, 
       g_stbd_m.stbddocno,g_stbd_m.stbd037,g_stbd_m.stbd002,g_stbd_m.stbd046,g_stbd_m.stbd000,g_stbd_m.stbd001, 
       g_stbd_m.stbd041,g_stbd_m.stbdunit,g_stbd_m.stbd048,g_stbd_m.stbd049,g_stbd_m.stbd050,g_stbd_m.stbd003, 
       g_stbd_m.stbd043,g_stbd_m.stbd044,g_stbd_m.stbd004,g_stbd_m.stbd005,g_stbd_m.stbd006,g_stbd_m.stbd038, 
       g_stbd_m.stbd060,g_stbd_m.stbd033,g_stbd_m.stbdstus,g_stbd_m.stbdownid,g_stbd_m.stbdowndp,g_stbd_m.stbdcrtid, 
       g_stbd_m.stbdcrtdp,g_stbd_m.stbdcrtdt,g_stbd_m.stbdmodid,g_stbd_m.stbdmoddt,g_stbd_m.stbdcnfid, 
       g_stbd_m.stbdcnfdt,g_stbd_m.stbd007,g_stbd_m.stbd052,g_stbd_m.stbd051,g_stbd_m.stbd053,g_stbd_m.stbd008, 
       g_stbd_m.stbd054,g_stbd_m.stbd009,g_stbd_m.stbd055,g_stbd_m.stbd010,g_stbd_m.stbd056,g_stbd_m.stbd011, 
       g_stbd_m.stbd057,g_stbd_m.stbd012,g_stbd_m.stbd058,g_stbd_m.stbd013,g_stbd_m.stbd059,g_stbd_m.stbd014, 
       g_stbd_m.stbd017,g_stbd_m.stbd018,g_stbd_m.stbd016,g_stbd_m.stbd019,g_stbd_m.stbd045,g_stbd_m.stbd015, 
       g_stbd_m.stbd040,g_stbd_m.stbd039,g_stbd_m.stbd020,g_stbd_m.stbd042,g_stbd_m.stbd021,g_stbd_m.stbd022, 
       g_stbd_m.stbd023,g_stbd_m.stbd024,g_stbd_m.stbd025,g_stbd_m.stbd026,g_stbd_m.stbd027,g_stbd_m.stbd028, 
       g_stbd_m.stbd029,g_stbd_m.stbd030,g_stbd_m.stbd031,g_stbd_m.stbd032,g_stbd_m.stbd034,g_stbd_m.stbd035, 
       g_stbd_m.stbd036,g_stbd_m.stbd047,g_stbd_m.stbdsite_desc,g_stbd_m.stbd037_desc,g_stbd_m.stbd002_desc, 
       g_stbd_m.stbd046_desc,g_stbd_m.stbdunit_desc,g_stbd_m.stbd049_desc,g_stbd_m.stbd050_desc,g_stbd_m.stbdownid_desc, 
       g_stbd_m.stbdowndp_desc,g_stbd_m.stbdcrtid_desc,g_stbd_m.stbdcrtdp_desc,g_stbd_m.stbdmodid_desc, 
       g_stbd_m.stbdcnfid_desc,g_stbd_m.stbd021_desc,g_stbd_m.stbd022_desc,g_stbd_m.stbd023_desc,g_stbd_m.stbd025_desc, 
       g_stbd_m.stbd030_desc
   
   
   #遮罩相關處理
   LET g_stbd_m_mask_o.* =  g_stbd_m.*
   CALL astt840_stbd_t_mask()
   LET g_stbd_m_mask_n.* =  g_stbd_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_stbd_m.stbdsite,g_stbd_m.stbdsite_desc,g_stbd_m.stbddocdt,g_stbd_m.stbddocno,g_stbd_m.stbd037, 
       g_stbd_m.stbd037_desc,g_stbd_m.stbd002,g_stbd_m.stbd002_desc,g_stbd_m.stbd046,g_stbd_m.stbd046_desc, 
       g_stbd_m.stbd000,g_stbd_m.stbd001,g_stbd_m.stbd041,g_stbd_m.stbdunit,g_stbd_m.stbdunit_desc,g_stbd_m.stbd048, 
       g_stbd_m.stbd048_desc,g_stbd_m.stbd049,g_stbd_m.stbd049_desc,g_stbd_m.stbd050,g_stbd_m.stbd050_desc, 
       g_stbd_m.stbd003,g_stbd_m.stbd043,g_stbd_m.stbd044,g_stbd_m.stbd004,g_stbd_m.l_stjo002,g_stbd_m.stbd005, 
       g_stbd_m.stbd006,g_stbd_m.stbd038,g_stbd_m.stbd060,g_stbd_m.stbd033,g_stbd_m.stbdstus,g_stbd_m.stbdownid, 
       g_stbd_m.stbdownid_desc,g_stbd_m.stbdowndp,g_stbd_m.stbdowndp_desc,g_stbd_m.stbdcrtid,g_stbd_m.stbdcrtid_desc, 
       g_stbd_m.stbdcrtdp,g_stbd_m.stbdcrtdp_desc,g_stbd_m.stbdcrtdt,g_stbd_m.stbdmodid,g_stbd_m.stbdmodid_desc, 
       g_stbd_m.stbdmoddt,g_stbd_m.stbdcnfid,g_stbd_m.stbdcnfid_desc,g_stbd_m.stbdcnfdt,g_stbd_m.stbd007, 
       g_stbd_m.stbd052,g_stbd_m.stbd051,g_stbd_m.stbd053,g_stbd_m.stbd008,g_stbd_m.stbd054,g_stbd_m.stbd009, 
       g_stbd_m.stbd055,g_stbd_m.stbd010,g_stbd_m.stbd056,g_stbd_m.stbd011,g_stbd_m.stbd057,g_stbd_m.stbd012, 
       g_stbd_m.stbd058,g_stbd_m.stbd013,g_stbd_m.stbd059,g_stbd_m.stbd014,g_stbd_m.stbd017,g_stbd_m.stbd018, 
       g_stbd_m.stbd016,g_stbd_m.stbd019,g_stbd_m.stbd045,g_stbd_m.stbd015,g_stbd_m.stbd040,g_stbd_m.stbd039, 
       g_stbd_m.stbd020,g_stbd_m.stbd042,g_stbd_m.stbd021,g_stbd_m.stbd021_desc,g_stbd_m.stbd022,g_stbd_m.stbd022_desc, 
       g_stbd_m.stje019,g_stbd_m.stje019_desc,g_stbd_m.stje020,g_stbd_m.stje020_desc,g_stbd_m.stje021, 
       g_stbd_m.stje021_desc,g_stbd_m.stbd023,g_stbd_m.stbd023_desc,g_stbd_m.stbd024,g_stbd_m.stbd025, 
       g_stbd_m.stbd025_desc,g_stbd_m.stbd026,g_stbd_m.stbd027,g_stbd_m.stbd028,g_stbd_m.stbd029,g_stbd_m.stbd030, 
       g_stbd_m.stbd030_desc,g_stbd_m.stbd031,g_stbd_m.stbd032,g_stbd_m.stbd034,g_stbd_m.stbd035,g_stbd_m.stbd036, 
       g_stbd_m.stbd047
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_stbd_m.stbdownid      
   LET g_data_dept  = g_stbd_m.stbdowndp
   
   #功能已完成,通報訊息中心
   CALL astt840_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="astt840.modify" >}
#+ 資料修改
PRIVATE FUNCTION astt840_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point    
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   DEFINE l_wc2_table1          STRING
   DEFINE l_wc2_table2   STRING
 
   DEFINE l_wc2_table3   STRING
 
   DEFINE l_wc2_table4   STRING
 
 
 
   #add-point:modify段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   #保存單頭舊值
   LET g_stbd_m_t.* = g_stbd_m.*
   LET g_stbd_m_o.* = g_stbd_m.*
   
   IF g_stbd_m.stbddocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_stbddocno_t = g_stbd_m.stbddocno
 
   CALL s_transaction_begin()
   
   OPEN astt840_cl USING g_enterprise,g_stbd_m.stbddocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN astt840_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE astt840_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE astt840_master_referesh USING g_stbd_m.stbddocno INTO g_stbd_m.stbdsite,g_stbd_m.stbddocdt, 
       g_stbd_m.stbddocno,g_stbd_m.stbd037,g_stbd_m.stbd002,g_stbd_m.stbd046,g_stbd_m.stbd000,g_stbd_m.stbd001, 
       g_stbd_m.stbd041,g_stbd_m.stbdunit,g_stbd_m.stbd048,g_stbd_m.stbd049,g_stbd_m.stbd050,g_stbd_m.stbd003, 
       g_stbd_m.stbd043,g_stbd_m.stbd044,g_stbd_m.stbd004,g_stbd_m.stbd005,g_stbd_m.stbd006,g_stbd_m.stbd038, 
       g_stbd_m.stbd060,g_stbd_m.stbd033,g_stbd_m.stbdstus,g_stbd_m.stbdownid,g_stbd_m.stbdowndp,g_stbd_m.stbdcrtid, 
       g_stbd_m.stbdcrtdp,g_stbd_m.stbdcrtdt,g_stbd_m.stbdmodid,g_stbd_m.stbdmoddt,g_stbd_m.stbdcnfid, 
       g_stbd_m.stbdcnfdt,g_stbd_m.stbd007,g_stbd_m.stbd052,g_stbd_m.stbd051,g_stbd_m.stbd053,g_stbd_m.stbd008, 
       g_stbd_m.stbd054,g_stbd_m.stbd009,g_stbd_m.stbd055,g_stbd_m.stbd010,g_stbd_m.stbd056,g_stbd_m.stbd011, 
       g_stbd_m.stbd057,g_stbd_m.stbd012,g_stbd_m.stbd058,g_stbd_m.stbd013,g_stbd_m.stbd059,g_stbd_m.stbd014, 
       g_stbd_m.stbd017,g_stbd_m.stbd018,g_stbd_m.stbd016,g_stbd_m.stbd019,g_stbd_m.stbd045,g_stbd_m.stbd015, 
       g_stbd_m.stbd040,g_stbd_m.stbd039,g_stbd_m.stbd020,g_stbd_m.stbd042,g_stbd_m.stbd021,g_stbd_m.stbd022, 
       g_stbd_m.stbd023,g_stbd_m.stbd024,g_stbd_m.stbd025,g_stbd_m.stbd026,g_stbd_m.stbd027,g_stbd_m.stbd028, 
       g_stbd_m.stbd029,g_stbd_m.stbd030,g_stbd_m.stbd031,g_stbd_m.stbd032,g_stbd_m.stbd034,g_stbd_m.stbd035, 
       g_stbd_m.stbd036,g_stbd_m.stbd047,g_stbd_m.stbdsite_desc,g_stbd_m.stbd037_desc,g_stbd_m.stbd002_desc, 
       g_stbd_m.stbd046_desc,g_stbd_m.stbdunit_desc,g_stbd_m.stbd049_desc,g_stbd_m.stbd050_desc,g_stbd_m.stbdownid_desc, 
       g_stbd_m.stbdowndp_desc,g_stbd_m.stbdcrtid_desc,g_stbd_m.stbdcrtdp_desc,g_stbd_m.stbdmodid_desc, 
       g_stbd_m.stbdcnfid_desc,g_stbd_m.stbd021_desc,g_stbd_m.stbd022_desc,g_stbd_m.stbd023_desc,g_stbd_m.stbd025_desc, 
       g_stbd_m.stbd030_desc
   
   #檢查是否允許此動作
   IF NOT astt840_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_stbd_m_mask_o.* =  g_stbd_m.*
   CALL astt840_stbd_t_mask()
   LET g_stbd_m_mask_n.* =  g_stbd_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
   #LET l_wc2_table2 = g_wc2_table2
   #LET l_wc2_table2 = " 1=1"
 
   #LET l_wc2_table3 = g_wc2_table3
   #LET l_wc2_table3 = " 1=1"
 
   #LET l_wc2_table4 = g_wc2_table4
   #LET l_wc2_table4 = " 1=1"
 
 
 
   
   CALL astt840_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
   #LET  g_wc2_table2 = l_wc2_table2 
 
   #LET  g_wc2_table3 = l_wc2_table3 
 
   #LET  g_wc2_table4 = l_wc2_table4 
 
 
 
    
   WHILE TRUE
      LET g_stbddocno_t = g_stbd_m.stbddocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_stbd_m.stbdmodid = g_user 
LET g_stbd_m.stbdmoddt = cl_get_current()
LET g_stbd_m.stbdmodid_desc = cl_get_username(g_stbd_m.stbdmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL astt840_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE stbd_t SET (stbdmodid,stbdmoddt) = (g_stbd_m.stbdmodid,g_stbd_m.stbdmoddt)
          WHERE stbdent = g_enterprise AND stbddocno = g_stbddocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_stbd_m.* = g_stbd_m_t.*
            CALL astt840_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_stbd_m.stbddocno != g_stbd_m_t.stbddocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE stbe_t SET stbedocno = g_stbd_m.stbddocno
 
          WHERE stbeent = g_enterprise AND stbedocno = g_stbd_m_t.stbddocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "stbe_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "stbe_t:",SQLERRMESSAGE 
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
         
         UPDATE stbf_t
            SET stbfdocno = g_stbd_m.stbddocno
 
          WHERE stbfent = g_enterprise AND
                stbfdocno = g_stbddocno_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update2"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "stbf_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "stbf_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後 name="modify.body.a_fk_update2"
         
         #end add-point
 
         #更新單身key值
         #add-point:單身fk修改前 name="modify.body.b_fk_update3"
         
         #end add-point
         
         UPDATE stbe_t
            SET stbedocno = g_stbd_m.stbddocno
 
          WHERE stbeent = g_enterprise AND
                stbedocno = g_stbddocno_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update3"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "stbe_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "stbe_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後 name="modify.body.a_fk_update3"
         
         #end add-point
 
         #更新單身key值
         #add-point:單身fk修改前 name="modify.body.b_fk_update4"
         
         #end add-point
         
         UPDATE stbe_t
            SET stbedocno = g_stbd_m.stbddocno
 
          WHERE stbeent = g_enterprise AND
                stbedocno = g_stbddocno_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update4"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "stbe_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "stbe_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後 name="modify.body.a_fk_update4"
         
         #end add-point
 
 
         
 
         
         #UPDATE 多語言table key值
         
         
         
         
 
         CALL s_transaction_end('Y','0')
      END IF
    
      EXIT WHILE
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL astt840_set_act_visible()   
   CALL astt840_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " stbdent = " ||g_enterprise|| " AND",
                      " stbddocno = '", g_stbd_m.stbddocno, "' "
 
   #填到對應位置
   CALL astt840_browser_fill("")
 
   CLOSE astt840_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL astt840_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="astt840.input" >}
#+ 資料輸入
PRIVATE FUNCTION astt840_input(p_cmd)
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
   DEFINE  l_success             LIKE type_t.num5
   DEFINE  l_errno               STRING
   DEFINE  l_seq                 LIKE type_t.num5
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
   DISPLAY BY NAME g_stbd_m.stbdsite,g_stbd_m.stbdsite_desc,g_stbd_m.stbddocdt,g_stbd_m.stbddocno,g_stbd_m.stbd037, 
       g_stbd_m.stbd037_desc,g_stbd_m.stbd002,g_stbd_m.stbd002_desc,g_stbd_m.stbd046,g_stbd_m.stbd046_desc, 
       g_stbd_m.stbd000,g_stbd_m.stbd001,g_stbd_m.stbd041,g_stbd_m.stbdunit,g_stbd_m.stbdunit_desc,g_stbd_m.stbd048, 
       g_stbd_m.stbd048_desc,g_stbd_m.stbd049,g_stbd_m.stbd049_desc,g_stbd_m.stbd050,g_stbd_m.stbd050_desc, 
       g_stbd_m.stbd003,g_stbd_m.stbd043,g_stbd_m.stbd044,g_stbd_m.stbd004,g_stbd_m.l_stjo002,g_stbd_m.stbd005, 
       g_stbd_m.stbd006,g_stbd_m.stbd038,g_stbd_m.stbd060,g_stbd_m.stbd033,g_stbd_m.stbdstus,g_stbd_m.stbdownid, 
       g_stbd_m.stbdownid_desc,g_stbd_m.stbdowndp,g_stbd_m.stbdowndp_desc,g_stbd_m.stbdcrtid,g_stbd_m.stbdcrtid_desc, 
       g_stbd_m.stbdcrtdp,g_stbd_m.stbdcrtdp_desc,g_stbd_m.stbdcrtdt,g_stbd_m.stbdmodid,g_stbd_m.stbdmodid_desc, 
       g_stbd_m.stbdmoddt,g_stbd_m.stbdcnfid,g_stbd_m.stbdcnfid_desc,g_stbd_m.stbdcnfdt,g_stbd_m.stbd007, 
       g_stbd_m.stbd052,g_stbd_m.stbd051,g_stbd_m.stbd053,g_stbd_m.stbd008,g_stbd_m.stbd054,g_stbd_m.stbd009, 
       g_stbd_m.stbd055,g_stbd_m.stbd010,g_stbd_m.stbd056,g_stbd_m.stbd011,g_stbd_m.stbd057,g_stbd_m.stbd012, 
       g_stbd_m.stbd058,g_stbd_m.stbd013,g_stbd_m.stbd059,g_stbd_m.stbd014,g_stbd_m.stbd017,g_stbd_m.stbd018, 
       g_stbd_m.stbd016,g_stbd_m.stbd019,g_stbd_m.stbd045,g_stbd_m.stbd015,g_stbd_m.stbd040,g_stbd_m.stbd039, 
       g_stbd_m.stbd020,g_stbd_m.stbd042,g_stbd_m.stbd021,g_stbd_m.stbd021_desc,g_stbd_m.stbd022,g_stbd_m.stbd022_desc, 
       g_stbd_m.stje019,g_stbd_m.stje019_desc,g_stbd_m.stje020,g_stbd_m.stje020_desc,g_stbd_m.stje021, 
       g_stbd_m.stje021_desc,g_stbd_m.stbd023,g_stbd_m.stbd023_desc,g_stbd_m.stbd024,g_stbd_m.stbd025, 
       g_stbd_m.stbd025_desc,g_stbd_m.stbd026,g_stbd_m.stbd027,g_stbd_m.stbd028,g_stbd_m.stbd029,g_stbd_m.stbd030, 
       g_stbd_m.stbd030_desc,g_stbd_m.stbd031,g_stbd_m.stbd032,g_stbd_m.stbd034,g_stbd_m.stbd035,g_stbd_m.stbd036, 
       g_stbd_m.stbd047
   
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
   LET g_forupd_sql = "SELECT stbeseq,stbe001,stbe002,stbe003,stbe004,stbe028,stbe005,stbe035,stbe036, 
       stbe024,stbe025,stbe006,stbe007,stbe008,stbe009,stbe010,stbe011,stbe012,stbe013,stbe014,stbe015, 
       stbe016,stbe026,stbe027,stbe017,stbe018,stbe033,stbe031,stbe034,stbesite,stbe020,stbe019,stbe032, 
       stbecomp,stbe021,stbe022,stbe023 FROM stbe_t WHERE stbeent=? AND stbedocno=? AND stbeseq=? FOR  
       UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE astt840_bcl CURSOR FROM g_forupd_sql
   
   #add-point:input段define_sql name="input.define_sql2"
   
   #end add-point    
   LET g_forupd_sql = "SELECT stbfseq,stbf001,stbf002,stbf003,stbf004,stbf005,stbf009,stbf010,stbf006, 
       stbf007,stbf008,stbf011,stbf012,stbfcomp,stbfsite,stbf013,stbf014,stbf015,stbf016 FROM stbf_t  
       WHERE stbfent=? AND stbfdocno=? AND stbfseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql2"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE astt840_bcl2 CURSOR FROM g_forupd_sql
 
   #add-point:input段define_sql name="input.define_sql3"
   
   #end add-point    
   LET g_forupd_sql = "SELECT stbeseq,stbe001,stbe002,stbe003,stbe004,stbe028,stbe005,stbe035,stbe036, 
       stbe024,stbe025,stbe006,stbe007,stbe008,stbe009,stbe010,stbe011,stbe012,stbe013,stbe014,stbe015, 
       stbe016,stbe026,stbe027,stbe017,stbe018,stbe033,stbe031,stbe034,stbesite,stbe020,stbe019,stbe032, 
       stbecomp,stbe021,stbe022,stbe023 FROM stbe_t WHERE stbeent=? AND stbedocno=? AND stbeseq=? FOR  
       UPDATE"
   #add-point:input段define_sql name="input.after_define_sql3"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE astt840_bcl3 CURSOR FROM g_forupd_sql
 
   #add-point:input段define_sql name="input.define_sql4"
   
   #end add-point    
   LET g_forupd_sql = "SELECT stbeseq,stbe001,stbe002,stbe003,stbe004,stbe028,stbe005,stbe035,stbe036, 
       stbe024,stbe025,stbe006,stbe007,stbe008,stbe009,stbe010,stbe011,stbe012,stbe013,stbe014,stbe015, 
       stbe016,stbe026,stbe027,stbe017,stbe018,stbe033,stbe031,stbe034,stbesite,stbe020,stbe019,stbe032, 
       stbecomp,stbe021,stbe022,stbe023 FROM stbe_t WHERE stbeent=? AND stbedocno=? AND stbeseq=? FOR  
       UPDATE"
   #add-point:input段define_sql name="input.after_define_sql4"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE astt840_bcl4 CURSOR FROM g_forupd_sql
 
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL astt840_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL astt840_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_stbd_m.stbdsite,g_stbd_m.stbddocdt,g_stbd_m.stbddocno,g_stbd_m.stbd037,g_stbd_m.stbd002, 
       g_stbd_m.stbd046,g_stbd_m.stbd000,g_stbd_m.stbd001,g_stbd_m.stbd041,g_stbd_m.stbdunit,g_stbd_m.stbd048, 
       g_stbd_m.stbd049,g_stbd_m.stbd050,g_stbd_m.stbd003,g_stbd_m.stbd043,g_stbd_m.stbd044,g_stbd_m.stbd004, 
       g_stbd_m.l_stjo002,g_stbd_m.stbd005,g_stbd_m.stbd006,g_stbd_m.stbd038,g_stbd_m.stbd060,g_stbd_m.stbd033, 
       g_stbd_m.stbdstus,g_stbd_m.stbd007,g_stbd_m.stbd052,g_stbd_m.stbd051,g_stbd_m.stbd053,g_stbd_m.stbd008, 
       g_stbd_m.stbd054,g_stbd_m.stbd009,g_stbd_m.stbd055,g_stbd_m.stbd010,g_stbd_m.stbd056,g_stbd_m.stbd011, 
       g_stbd_m.stbd057,g_stbd_m.stbd012,g_stbd_m.stbd058,g_stbd_m.stbd013,g_stbd_m.stbd059,g_stbd_m.stbd014, 
       g_stbd_m.stbd017,g_stbd_m.stbd018,g_stbd_m.stbd016,g_stbd_m.stbd019,g_stbd_m.stbd045,g_stbd_m.stbd015, 
       g_stbd_m.stbd040,g_stbd_m.stbd039,g_stbd_m.stbd020,g_stbd_m.stbd042,g_stbd_m.stbd021,g_stbd_m.stbd022, 
       g_stbd_m.stbd023,g_stbd_m.stbd024,g_stbd_m.stbd025,g_stbd_m.stbd026,g_stbd_m.stbd027,g_stbd_m.stbd028, 
       g_stbd_m.stbd029,g_stbd_m.stbd030,g_stbd_m.stbd031,g_stbd_m.stbd032,g_stbd_m.stbd034,g_stbd_m.stbd035, 
       g_stbd_m.stbd036,g_stbd_m.stbd047
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="astt840.input.head" >}
      #單頭段
      INPUT BY NAME g_stbd_m.stbdsite,g_stbd_m.stbddocdt,g_stbd_m.stbddocno,g_stbd_m.stbd037,g_stbd_m.stbd002, 
          g_stbd_m.stbd046,g_stbd_m.stbd000,g_stbd_m.stbd001,g_stbd_m.stbd041,g_stbd_m.stbdunit,g_stbd_m.stbd048, 
          g_stbd_m.stbd049,g_stbd_m.stbd050,g_stbd_m.stbd003,g_stbd_m.stbd043,g_stbd_m.stbd044,g_stbd_m.stbd004, 
          g_stbd_m.l_stjo002,g_stbd_m.stbd005,g_stbd_m.stbd006,g_stbd_m.stbd038,g_stbd_m.stbd060,g_stbd_m.stbd033, 
          g_stbd_m.stbdstus,g_stbd_m.stbd007,g_stbd_m.stbd052,g_stbd_m.stbd051,g_stbd_m.stbd053,g_stbd_m.stbd008, 
          g_stbd_m.stbd054,g_stbd_m.stbd009,g_stbd_m.stbd055,g_stbd_m.stbd010,g_stbd_m.stbd056,g_stbd_m.stbd011, 
          g_stbd_m.stbd057,g_stbd_m.stbd012,g_stbd_m.stbd058,g_stbd_m.stbd013,g_stbd_m.stbd059,g_stbd_m.stbd014, 
          g_stbd_m.stbd017,g_stbd_m.stbd018,g_stbd_m.stbd016,g_stbd_m.stbd019,g_stbd_m.stbd045,g_stbd_m.stbd015, 
          g_stbd_m.stbd040,g_stbd_m.stbd039,g_stbd_m.stbd020,g_stbd_m.stbd042,g_stbd_m.stbd021,g_stbd_m.stbd022, 
          g_stbd_m.stbd023,g_stbd_m.stbd024,g_stbd_m.stbd025,g_stbd_m.stbd026,g_stbd_m.stbd027,g_stbd_m.stbd028, 
          g_stbd_m.stbd029,g_stbd_m.stbd030,g_stbd_m.stbd031,g_stbd_m.stbd032,g_stbd_m.stbd034,g_stbd_m.stbd035, 
          g_stbd_m.stbd036,g_stbd_m.stbd047 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN astt840_cl USING g_enterprise,g_stbd_m.stbddocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN astt840_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE astt840_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL astt840_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            
            #end add-point
            CALL astt840_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbdsite
            
            #add-point:AFTER FIELD stbdsite name="input.a.stbdsite"
            LET g_stbd_m.stbdsite_desc = ' '
            DISPLAY BY NAME g_stbd_m.stbdsite_desc
            IF NOT cl_null(g_stbd_m.stbdsite) THEN
               IF g_stbd_m.stbdsite != g_stbd_m_o.stbdsite OR cl_null(g_stbd_m_o.stbdsite) THEN
                  LET l_success = NULL
                  LET l_errno = NULL
                  
                  CALL s_aooi500_chk(g_prog,'stbdsite',g_stbd_m.stbdsite,g_stbd_m.stbdsite)
                     RETURNING l_success,l_errno
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ""
                     LET g_errparam.code   = l_errno
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                  
                     LET g_stbd_m.stbdsite = g_stbd_m_o.stbdsite
                     LET g_stbd_m.stbdsite_desc = s_desc_get_department_desc(g_stbd_m.stbdsite)                      
                     DISPLAY BY NAME g_stbd_m.stbdsite,g_stbd_m.stbdsite_desc
                     
                     NEXT FIELD CURRENT
                  ELSE
#                     LET g_ins_site_flag = 'Y'    #161024-00025#4 by 08172
                     CALL astt840_get_ooef_info()   #組織資訊
                  END IF
               END IF
            END IF
            LET g_stbd_m.stbdsite_desc = s_desc_get_department_desc(g_stbd_m.stbdsite) 
            DISPLAY BY NAME g_stbd_m.stbdsite_desc
            
            LET g_stbd_m_o.stbdsite = g_stbd_m.stbdsite
            LET g_stbd_m_o.stbd048 = g_stbd_m.stbd048
            LET g_ins_site_flag = 'Y'    #161024-00025#4 by 08172
            CALL astt840_set_entry(p_cmd)
            CALL astt840_set_no_entry(p_cmd)
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbdsite
            #add-point:BEFORE FIELD stbdsite name="input.b.stbdsite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbdsite
            #add-point:ON CHANGE stbdsite name="input.g.stbdsite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbddocdt
            #add-point:BEFORE FIELD stbddocdt name="input.b.stbddocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbddocdt
            
            #add-point:AFTER FIELD stbddocdt name="input.a.stbddocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbddocdt
            #add-point:ON CHANGE stbddocdt name="input.g.stbddocdt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbddocno
            #add-point:BEFORE FIELD stbddocno name="input.b.stbddocno"
            IF cl_null(g_ooef006) THEN
               CALL astt840_get_ooef_info()
            END IF   
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbddocno
            
            #add-point:AFTER FIELD stbddocno name="input.a.stbddocno"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  NOT cl_null(g_stbd_m.stbddocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_stbd_m.stbddocno != g_stbddocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(1) FROM stbd_t WHERE "||"stbdent = '" ||g_enterprise|| "' AND "||"stbddocno = '"||g_stbd_m.stbddocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
                  
                  IF NOT s_aooi200_chk_slip(g_stbd_m.stbdsite,'',g_stbd_m.stbddocno,g_prog) THEN
                     LET g_stbd_m.stbddocno = g_stbddocno_t
                     DISPLAY BY NAME g_stbd_m.stbddocno
                     NEXT FIELD CURRENT
                  END IF                  
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbddocno
            #add-point:ON CHANGE stbddocno name="input.g.stbddocno"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd037
            
            #add-point:AFTER FIELD stbd037 name="input.a.stbd037"
            LET g_stbd_m.stbd037_desc = ' '
            DISPLAY BY NAME g_stbd_m.stbd037_desc
            IF NOT cl_null(g_stbd_m.stbd037) THEN
               IF g_stbd_m.stbd037 != g_stbd_m_o.stbd037 OR cl_null(g_stbd_m_o.stbd037) THEN
                  IF NOT astt840_stbd037_chk() THEN
                     LET g_stbd_m.stbd037 = g_stbd_m_o.stbd037
                     LET g_stbd_m.stbd037_desc = astt840_mhbe001_ref(g_stbd_m.stbd037)
                     DISPLAY BY NAME g_stbd_m.stbd037,g_stbd_m.stbd037_desc
                     
                     NEXT FIELD CURRENT
                  ELSE
                     #add by geza 20160815 #160815-00006#1S)
                     #判断铺位是否属于单头结算组织
                     IF g_stbd_m.stbdsite IS NOT NULL THEN
                        LET l_cnt = 0 
                        SELECT COUNT(1) INTO l_cnt
                          FROM stje_t
                         WHERE stjeent = g_enterprise 
                           AND stjesite = g_stbd_m.stbdsite
                           AND stje008 = g_stbd_m.stbd037
                           AND stjestus = 'Y'
                        IF l_cnt = 0 THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = 'ast-00837'
                           LET g_errparam.extend = ''
                           LET g_errparam.popup = TRUE
                           LET g_errparam.replace[1] = g_stbd_m.stbd037
                           CALL cl_err()      
                           LET g_stbd_m.stbd037 = g_stbd_m_o.stbd037                     
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                     #add by geza 20160815 #160815-00006#1(E) 
                     
                     #add by geza 20160624 #160604-00009#69(S)
                     #合同不为空，判断合同和铺位是否存在合同
                     IF g_stbd_m.stbd001 IS NOT NULL THEN
                        LET l_cnt = 0 
                        SELECT COUNT(1) INTO l_cnt
                          FROM stje_t
                         WHERE stjeent = g_enterprise 
                           AND stje001 = g_stbd_m.stbd001
                           AND stje008 = g_stbd_m.stbd037
                           AND stjestus = 'Y'
                        IF l_cnt = 0 THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = 'ast-00650'
                           LET g_errparam.extend = ''
                           LET g_errparam.popup = TRUE
                           LET g_errparam.replace[1] = g_stbd_m.stbd037
                           CALL cl_err()      
                           LET g_stbd_m.stbd037 = g_stbd_m_o.stbd037                     
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                     CALL astt840_get_stje008()
                     #add by geza 20160624 #160604-00009#69(E)                  
                  END IF
                  
                  #CALL astt840_get_stje_info(2) #mark by geza 20160624 #160604-00009#69
               END IF
            END IF
            LET g_stbd_m.stbd037_desc = astt840_mhbe001_ref(g_stbd_m.stbd037)
            DISPLAY BY NAME g_stbd_m.stbd037_desc
            
            LET g_stbd_m_o.stbd037 = g_stbd_m.stbd037
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd037
            #add-point:BEFORE FIELD stbd037 name="input.b.stbd037"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbd037
            #add-point:ON CHANGE stbd037 name="input.g.stbd037"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd002
            
            #add-point:AFTER FIELD stbd002 name="input.a.stbd002"
            #160513-00037#27 20160603 add by beckxie---S
            IF NOT cl_null(g_stbd_m.stbd002) THEN
#應用 a17 樣板自動產生(Version:3)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數              
               LET g_chkparam.arg1 = g_stbd_m.stbd002

               #呼叫檢查存在並帶值的library
               IF astt840_stbd002_chk() THEN
                  #add by geza 20160624 #160604-00009#69(S)
                  #合同不为空，判断合同和供应商是否存在合同
                  IF g_stbd_m.stbd001 IS NOT NULL THEN
                     LET l_cnt = 0 
                     SELECT COUNT(1) INTO l_cnt
                       FROM stje_t
                      WHERE stjeent = g_enterprise 
                        AND stje001 = g_stbd_m.stbd001
                        AND stje007 = g_stbd_m.stbd002
                        AND stjestus = 'Y'
                     IF l_cnt = 0 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'ast-00316'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()      
                        LET g_stbd_m.stbd002 = g_stbd_m_o.stbd002                     
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  #add by geza 20160815 #160815-00006#1S)
                  #铺位不为空，判断铺位和供应商是否存在合同
                  IF g_stbd_m.stbd037 IS NOT NULL THEN
                     LET l_cnt = 0 
                     SELECT COUNT(1) INTO l_cnt
                       FROM stje_t
                      WHERE stjeent = g_enterprise 
                        AND stje007 = g_stbd_m.stbd002
                        AND stje008 = g_stbd_m.stbd037
                        AND stjestus = 'Y'
                     IF l_cnt = 0 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'ast-00839'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        LET g_errparam.replace[1] = g_stbd_m.stbd037
                        CALL cl_err()      
                        LET g_stbd_m.stbd002 = g_stbd_m_o.stbd002                     
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  #add by geza 20160815 #160815-00006#1(E) 
                  CALL astt840_get_stje007()
                  #add by geza 20160624 #160604-00009#69(E)
               ELSE
                  #檢查失敗時後續處理
                  LET g_stbd_m.stbd002 = g_stbd_m_o.stbd002
                  LET g_stbd_m.stbd002_desc = s_desc_get_trading_partner_abbr_desc(g_stbd_m.stbd002)   
                  DISPLAY BY NAME g_stbd_m.stbd002_desc
                  NEXT FIELD CURRENT
               END IF
            END IF
            LET g_stbd_m_o.stbd002 = g_stbd_m.stbd002
            LET g_stbd_m.stbd002_desc = s_desc_get_trading_partner_abbr_desc(g_stbd_m.stbd002)   
            DISPLAY BY NAME g_stbd_m.stbd002_desc
            #160513-00037#27 20160603 add by beckxie---E
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd002
            #add-point:BEFORE FIELD stbd002 name="input.b.stbd002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbd002
            #add-point:ON CHANGE stbd002 name="input.g.stbd002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd046
            
            #add-point:AFTER FIELD stbd046 name="input.a.stbd046"
            LET g_stbd_m.stbd046_desc = ' '
            DISPLAY BY NAME g_stbd_m.stbd046_desc
            IF NOT cl_null(g_stbd_m.stbd046) THEN
               IF g_stbd_m.stbd046 != g_stbd_m_o.stbd046 OR cl_null(g_stbd_m_o.stbd046) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_stbd_m.stbd002
                  LET g_chkparam.arg2 = g_stbd_m.stbd046
                  LET g_chkparam.arg3 = g_stbd_m.stbd046
                  IF NOT cl_chk_exist("v_pmac002") THEN
                     LET g_stbd_m.stbd046 = g_stbd_m_o.stbd046
                     LET g_stbd_m.stbd046_desc = s_desc_get_trading_partner_abbr_desc(g_stbd_m.stbd046)
                     DISPLAY BY NAME g_stbd_m.stbd046,g_stbd_m.stbd046_desc
                     
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_stbd_m.stbd046_desc = s_desc_get_trading_partner_abbr_desc(g_stbd_m.stbd046)
            DISPLAY BY NAME g_stbd_m.stbd046_desc
            
            LET g_stbd_m_o.stbd046 = g_stbd_m.stbd046
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd046
            #add-point:BEFORE FIELD stbd046 name="input.b.stbd046"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbd046
            #add-point:ON CHANGE stbd046 name="input.g.stbd046"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd000
            #add-point:BEFORE FIELD stbd000 name="input.b.stbd000"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd000
            
            #add-point:AFTER FIELD stbd000 name="input.a.stbd000"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbd000
            #add-point:ON CHANGE stbd000 name="input.g.stbd000"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd001
            
            #add-point:AFTER FIELD stbd001 name="input.a.stbd001"
            IF NOT cl_null(g_stbd_m.stbd001) THEN
               IF g_stbd_m.stbd001 != g_stbd_m_o.stbd001 OR cl_null(g_stbd_m_o.stbd001) THEN
                  #160604-00009#69 #mark by geza 20160624(S)
#                  INITIALIZE g_chkparam.* TO NULL
#                  LET g_chkparam.arg1 = g_stbd_m.stbd001
#                  LET g_chkparam.arg2 = g_stbd_m.stbdsite #160604-00009#69 #add by geza 20160624
#                  IF NOT cl_chk_exist("v_stje001") THEN
#                     LET g_stbd_m.stbd001 = g_stbd_m_o.stbd001                     
#                     NEXT FIELD CURRENT
#                  END IF
                  #160604-00009#69 #mark by geza 20160624(E)
                  #160604-00009#69 #add by geza 20160624(S)
                  LET l_cnt = 0 
                  SELECT COUNT(1) INTO l_cnt
                    FROM stje_t
                   WHERE stjeent = g_enterprise 
                     AND stje001 = g_stbd_m.stbd001
                  IF l_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'ast-00651'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()      
                     LET g_stbd_m.stbd001 = g_stbd_m_o.stbd001                     
                     NEXT FIELD CURRENT
                  END IF
                  LET l_cnt = 0 
                  SELECT COUNT(1) INTO l_cnt
                    FROM stje_t
                   WHERE stjeent = g_enterprise 
                     AND stje001 = g_stbd_m.stbd001
                     AND stjestus = 'Y'
                  IF l_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'ast-00652'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()      
                     LET g_stbd_m.stbd001 = g_stbd_m_o.stbd001                     
                     NEXT FIELD CURRENT
                  END IF 
                  #add by geza 20160815 #160815-00006#1(S)
                  #判断合同是否属于单头结算组织
                  LET l_cnt = 0 
                  SELECT COUNT(1) INTO l_cnt
                    FROM stje_t
                   WHERE stjeent = g_enterprise 
                     AND stjesite = g_stbd_m.stbdsite
                     AND stje001 = g_stbd_m.stbd001
                     AND stjestus = 'Y'
                  IF l_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'ast-00838'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     LET g_errparam.replace[1] = g_stbd_m.stbd001
                     CALL cl_err()      
                     LET g_stbd_m.stbd001 = g_stbd_m_o.stbd001                     
                     NEXT FIELD CURRENT
                  END IF
                  #add by geza 20160815 #160815-00006#1(E)
                  
                  #160604-00009#69 #add by geza 20160624(E)
                  CALL astt840_get_stje001() #160604-00009#69 #add by geza 20160624
                  #CALL astt840_get_stje_info(1) #160604-00009#69 #mark by geza 20160624
               END IF
            END IF
            #add by geza 20160802 #160728-00006#15(S)
            SELECT stje019,stje020,stje021 INTO g_stbd_m.stje019,g_stbd_m.stje020,g_stbd_m.stje021
              FROM stje_t
             WHERE stjeent = g_enterprise
               AND stje001 = g_stbd_m.stbd001
            DISPLAY BY NAME g_stbd_m.stje019,g_stbd_m.stje020,g_stbd_m.stje021   
            CALL astt840_stje019_ref()
            CALL astt840_stje020_ref()
            CALL astt840_stje021_ref()
            #add by geza 20160802 #160728-00006#15(E)
            LET  g_stbd_m_o.stbd001 = g_stbd_m.stbd001       
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd001
            #add-point:BEFORE FIELD stbd001 name="input.b.stbd001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbd001
            #add-point:ON CHANGE stbd001 name="input.g.stbd001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd041
            #add-point:BEFORE FIELD stbd041 name="input.b.stbd041"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd041
            
            #add-point:AFTER FIELD stbd041 name="input.a.stbd041"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbd041
            #add-point:ON CHANGE stbd041 name="input.g.stbd041"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbdunit
            
            #add-point:AFTER FIELD stbdunit name="input.a.stbdunit"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbdunit
            #add-point:BEFORE FIELD stbdunit name="input.b.stbdunit"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbdunit
            #add-point:ON CHANGE stbdunit name="input.g.stbdunit"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd048
            
            #add-point:AFTER FIELD stbd048 name="input.a.stbd048"
            LET g_stbd_m.stbd048_desc = ' '
            DISPLAY BY NAME g_stbd_m.stbd048_desc
            IF NOT cl_null(g_stbd_m.stbd048) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_stbd_m.stbd048 != g_stbd_m_t.stbd048 OR cl_null(g_stbd_m_t.stbd048) )) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_stbd_m.stbd048
                  IF NOT cl_chk_exist("v_ooef001_1") THEN
                     LET g_stbd_m.stbd048 = g_stbd_m_t.stbd048
                     LET g_stbd_m.stbd048_desc = s_desc_get_department_desc(g_stbd_m.stbd048)
                     DISPLAY BY NAME g_stbd_m.stbd048_desc
                     
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_stbd_m.stbd048_desc = s_desc_get_department_desc(g_stbd_m.stbd048)
            DISPLAY BY NAME g_stbd_m.stbd048_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd048
            #add-point:BEFORE FIELD stbd048 name="input.b.stbd048"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbd048
            #add-point:ON CHANGE stbd048 name="input.g.stbd048"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd049
            
            #add-point:AFTER FIELD stbd049 name="input.a.stbd049"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd049
            #add-point:BEFORE FIELD stbd049 name="input.b.stbd049"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbd049
            #add-point:ON CHANGE stbd049 name="input.g.stbd049"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd050
            
            #add-point:AFTER FIELD stbd050 name="input.a.stbd050"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd050
            #add-point:BEFORE FIELD stbd050 name="input.b.stbd050"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbd050
            #add-point:ON CHANGE stbd050 name="input.g.stbd050"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd003
            #add-point:BEFORE FIELD stbd003 name="input.b.stbd003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd003
            
            #add-point:AFTER FIELD stbd003 name="input.a.stbd003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbd003
            #add-point:ON CHANGE stbd003 name="input.g.stbd003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd043
            #add-point:BEFORE FIELD stbd043 name="input.b.stbd043"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd043
            
            #add-point:AFTER FIELD stbd043 name="input.a.stbd043"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbd043
            #add-point:ON CHANGE stbd043 name="input.g.stbd043"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd044
            #add-point:BEFORE FIELD stbd044 name="input.b.stbd044"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd044
            
            #add-point:AFTER FIELD stbd044 name="input.a.stbd044"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbd044
            #add-point:ON CHANGE stbd044 name="input.g.stbd044"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd004
            #add-point:BEFORE FIELD stbd004 name="input.b.stbd004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd004
            
            #add-point:AFTER FIELD stbd004 name="input.a.stbd004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbd004
            #add-point:ON CHANGE stbd004 name="input.g.stbd004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_stjo002
            #add-point:BEFORE FIELD l_stjo002 name="input.b.l_stjo002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_stjo002
            
            #add-point:AFTER FIELD l_stjo002 name="input.a.l_stjo002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_stjo002
            #add-point:ON CHANGE l_stjo002 name="input.g.l_stjo002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd005
            #add-point:BEFORE FIELD stbd005 name="input.b.stbd005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd005
            
            #add-point:AFTER FIELD stbd005 name="input.a.stbd005"
            IF NOT cl_null(g_stbd_m.stbd005) THEN
               IF g_stbd_m.stbd005 != g_stbd_m_o.stbd005 OR cl_null(g_stbd_m_o.stbd005) THEN
                  IF NOT cl_null(g_stbd_m.stbd006) THEN   
                     IF g_stbd_m.stbd006 < g_stbd_m.stbd005 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = "ast-00041"
                        LET g_errparam.extend = g_stbd_m.stbd005
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                     
                        LET g_stbd_m.stbd005 =  g_stbd_m_o.stbd005
                        DISPLAY BY NAME g_stbd_m.stbd005
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF
            
            LET g_stbd_m_o.stbd005 = g_stbd_m.stbd005
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbd005
            #add-point:ON CHANGE stbd005 name="input.g.stbd005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd006
            #add-point:BEFORE FIELD stbd006 name="input.b.stbd006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd006
            
            #add-point:AFTER FIELD stbd006 name="input.a.stbd006"
            IF NOT cl_null(g_stbd_m.stbd006) THEN
               IF g_stbd_m.stbd006 != g_stbd_m_o.stbd006 OR cl_null(g_stbd_m_o.stbd006) THEN
                  IF NOT cl_null(g_stbd_m.stbd006) THEN   
                     IF g_stbd_m.stbd006 < g_stbd_m.stbd005 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = "ast-00041"
                        LET g_errparam.extend = g_stbd_m.stbd006
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                     
                        LET g_stbd_m.stbd006 =  g_stbd_m_o.stbd006
                        DISPLAY BY NAME g_stbd_m.stbd006
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF
            
            LET g_stbd_m_o.stbd006 = g_stbd_m.stbd006
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbd006
            #add-point:ON CHANGE stbd006 name="input.g.stbd006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd038
            #add-point:BEFORE FIELD stbd038 name="input.b.stbd038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd038
            
            #add-point:AFTER FIELD stbd038 name="input.a.stbd038"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbd038
            #add-point:ON CHANGE stbd038 name="input.g.stbd038"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd060
            #add-point:BEFORE FIELD stbd060 name="input.b.stbd060"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd060
            
            #add-point:AFTER FIELD stbd060 name="input.a.stbd060"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbd060
            #add-point:ON CHANGE stbd060 name="input.g.stbd060"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd033
            #add-point:BEFORE FIELD stbd033 name="input.b.stbd033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd033
            
            #add-point:AFTER FIELD stbd033 name="input.a.stbd033"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbd033
            #add-point:ON CHANGE stbd033 name="input.g.stbd033"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbdstus
            #add-point:BEFORE FIELD stbdstus name="input.b.stbdstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbdstus
            
            #add-point:AFTER FIELD stbdstus name="input.a.stbdstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbdstus
            #add-point:ON CHANGE stbdstus name="input.g.stbdstus"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd007
            #add-point:BEFORE FIELD stbd007 name="input.b.stbd007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd007
            
            #add-point:AFTER FIELD stbd007 name="input.a.stbd007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbd007
            #add-point:ON CHANGE stbd007 name="input.g.stbd007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd052
            #add-point:BEFORE FIELD stbd052 name="input.b.stbd052"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd052
            
            #add-point:AFTER FIELD stbd052 name="input.a.stbd052"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbd052
            #add-point:ON CHANGE stbd052 name="input.g.stbd052"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd051
            #add-point:BEFORE FIELD stbd051 name="input.b.stbd051"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd051
            
            #add-point:AFTER FIELD stbd051 name="input.a.stbd051"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbd051
            #add-point:ON CHANGE stbd051 name="input.g.stbd051"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd053
            #add-point:BEFORE FIELD stbd053 name="input.b.stbd053"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd053
            
            #add-point:AFTER FIELD stbd053 name="input.a.stbd053"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbd053
            #add-point:ON CHANGE stbd053 name="input.g.stbd053"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd008
            #add-point:BEFORE FIELD stbd008 name="input.b.stbd008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd008
            
            #add-point:AFTER FIELD stbd008 name="input.a.stbd008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbd008
            #add-point:ON CHANGE stbd008 name="input.g.stbd008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd054
            #add-point:BEFORE FIELD stbd054 name="input.b.stbd054"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd054
            
            #add-point:AFTER FIELD stbd054 name="input.a.stbd054"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbd054
            #add-point:ON CHANGE stbd054 name="input.g.stbd054"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd009
            #add-point:BEFORE FIELD stbd009 name="input.b.stbd009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd009
            
            #add-point:AFTER FIELD stbd009 name="input.a.stbd009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbd009
            #add-point:ON CHANGE stbd009 name="input.g.stbd009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd055
            #add-point:BEFORE FIELD stbd055 name="input.b.stbd055"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd055
            
            #add-point:AFTER FIELD stbd055 name="input.a.stbd055"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbd055
            #add-point:ON CHANGE stbd055 name="input.g.stbd055"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd010
            #add-point:BEFORE FIELD stbd010 name="input.b.stbd010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd010
            
            #add-point:AFTER FIELD stbd010 name="input.a.stbd010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbd010
            #add-point:ON CHANGE stbd010 name="input.g.stbd010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd056
            #add-point:BEFORE FIELD stbd056 name="input.b.stbd056"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd056
            
            #add-point:AFTER FIELD stbd056 name="input.a.stbd056"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbd056
            #add-point:ON CHANGE stbd056 name="input.g.stbd056"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd011
            #add-point:BEFORE FIELD stbd011 name="input.b.stbd011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd011
            
            #add-point:AFTER FIELD stbd011 name="input.a.stbd011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbd011
            #add-point:ON CHANGE stbd011 name="input.g.stbd011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd057
            #add-point:BEFORE FIELD stbd057 name="input.b.stbd057"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd057
            
            #add-point:AFTER FIELD stbd057 name="input.a.stbd057"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbd057
            #add-point:ON CHANGE stbd057 name="input.g.stbd057"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd012
            #add-point:BEFORE FIELD stbd012 name="input.b.stbd012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd012
            
            #add-point:AFTER FIELD stbd012 name="input.a.stbd012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbd012
            #add-point:ON CHANGE stbd012 name="input.g.stbd012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd058
            #add-point:BEFORE FIELD stbd058 name="input.b.stbd058"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd058
            
            #add-point:AFTER FIELD stbd058 name="input.a.stbd058"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbd058
            #add-point:ON CHANGE stbd058 name="input.g.stbd058"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd013
            #add-point:BEFORE FIELD stbd013 name="input.b.stbd013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd013
            
            #add-point:AFTER FIELD stbd013 name="input.a.stbd013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbd013
            #add-point:ON CHANGE stbd013 name="input.g.stbd013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd059
            #add-point:BEFORE FIELD stbd059 name="input.b.stbd059"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd059
            
            #add-point:AFTER FIELD stbd059 name="input.a.stbd059"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbd059
            #add-point:ON CHANGE stbd059 name="input.g.stbd059"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd014
            #add-point:BEFORE FIELD stbd014 name="input.b.stbd014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd014
            
            #add-point:AFTER FIELD stbd014 name="input.a.stbd014"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbd014
            #add-point:ON CHANGE stbd014 name="input.g.stbd014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd017
            #add-point:BEFORE FIELD stbd017 name="input.b.stbd017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd017
            
            #add-point:AFTER FIELD stbd017 name="input.a.stbd017"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbd017
            #add-point:ON CHANGE stbd017 name="input.g.stbd017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd018
            #add-point:BEFORE FIELD stbd018 name="input.b.stbd018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd018
            
            #add-point:AFTER FIELD stbd018 name="input.a.stbd018"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbd018
            #add-point:ON CHANGE stbd018 name="input.g.stbd018"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd016
            #add-point:BEFORE FIELD stbd016 name="input.b.stbd016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd016
            
            #add-point:AFTER FIELD stbd016 name="input.a.stbd016"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbd016
            #add-point:ON CHANGE stbd016 name="input.g.stbd016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd019
            #add-point:BEFORE FIELD stbd019 name="input.b.stbd019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd019
            
            #add-point:AFTER FIELD stbd019 name="input.a.stbd019"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbd019
            #add-point:ON CHANGE stbd019 name="input.g.stbd019"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd045
            #add-point:BEFORE FIELD stbd045 name="input.b.stbd045"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd045
            
            #add-point:AFTER FIELD stbd045 name="input.a.stbd045"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbd045
            #add-point:ON CHANGE stbd045 name="input.g.stbd045"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd015
            #add-point:BEFORE FIELD stbd015 name="input.b.stbd015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd015
            
            #add-point:AFTER FIELD stbd015 name="input.a.stbd015"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbd015
            #add-point:ON CHANGE stbd015 name="input.g.stbd015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd040
            #add-point:BEFORE FIELD stbd040 name="input.b.stbd040"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd040
            
            #add-point:AFTER FIELD stbd040 name="input.a.stbd040"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbd040
            #add-point:ON CHANGE stbd040 name="input.g.stbd040"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd039
            #add-point:BEFORE FIELD stbd039 name="input.b.stbd039"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd039
            
            #add-point:AFTER FIELD stbd039 name="input.a.stbd039"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbd039
            #add-point:ON CHANGE stbd039 name="input.g.stbd039"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd020
            #add-point:BEFORE FIELD stbd020 name="input.b.stbd020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd020
            
            #add-point:AFTER FIELD stbd020 name="input.a.stbd020"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbd020
            #add-point:ON CHANGE stbd020 name="input.g.stbd020"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd042
            #add-point:BEFORE FIELD stbd042 name="input.b.stbd042"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd042
            
            #add-point:AFTER FIELD stbd042 name="input.a.stbd042"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbd042
            #add-point:ON CHANGE stbd042 name="input.g.stbd042"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd021
            
            #add-point:AFTER FIELD stbd021 name="input.a.stbd021"
            LET g_stbd_m.stbd022_desc = ' '
            DISPLAY BY NAME g_stbd_m.stbd021_desc            
            IF NOT cl_null(g_stbd_m.stbd021) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_stbd_m.stbd021 != g_stbd_m_t.stbd021 OR g_stbd_m_t.stbd021 IS NULL)) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_stbd_m.stbd021
                  LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
                  IF NOT cl_chk_exist("v_ooag001") THEN
                     LET g_stbd_m.stbd021 =  g_stbd_m_t.stbd021
                     LET g_stbd_m.stbd021_desc = s_desc_get_person_desc(g_stbd_m.stbd021)
                     DISPLAY BY NAME g_stbd_m.stbd021,g_stbd_m.stbd021_desc
                     
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF            
            LET g_stbd_m.stbd021_desc = s_desc_get_person_desc(g_stbd_m.stbd021)
            DISPLAY BY NAME g_stbd_m.stbd021_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd021
            #add-point:BEFORE FIELD stbd021 name="input.b.stbd021"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbd021
            #add-point:ON CHANGE stbd021 name="input.g.stbd021"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd022
            
            #add-point:AFTER FIELD stbd022 name="input.a.stbd022"
            LET g_stbd_m.stbd022_desc = ' '
            DISPLAY BY NAME g_stbd_m.stbd022_desc
            IF NOT cl_null(g_stbd_m.stbd022) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_stbd_m.stbd022 != g_stbd_m_t.stbd022 OR g_stbd_m_t.stbd022 IS NULL)) THEN
                 INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_stbd_m.stbd022
                  LET g_chkparam.arg2 = g_today
                  LET g_chkparam.err_str[1] = "aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
                  IF NOT cl_chk_exist("v_ooeg001") THEN
                     LET g_stbd_m.stbd022 = g_stbd_m_t.stbd022
                     LET g_stbd_m.stbd022_desc = s_desc_get_department_desc(g_stbd_m.stbd022)
                     DISPLAY BY NAME g_stbd_m.stbd022,g_stbd_m.stbd022_desc
                     
                     NEXT FIELD CURRENT
                  END IF

               END IF
            END IF
            LET g_stbd_m.stbd022_desc = s_desc_get_department_desc(g_stbd_m.stbd022)
            DISPLAY BY NAME g_stbd_m.stbd022_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd022
            #add-point:BEFORE FIELD stbd022 name="input.b.stbd022"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbd022
            #add-point:ON CHANGE stbd022 name="input.g.stbd022"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd023
            
            #add-point:AFTER FIELD stbd023 name="input.a.stbd023"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd023
            #add-point:BEFORE FIELD stbd023 name="input.b.stbd023"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbd023
            #add-point:ON CHANGE stbd023 name="input.g.stbd023"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd024
            #add-point:BEFORE FIELD stbd024 name="input.b.stbd024"
            IF cl_null(g_ooef006) THEN
               CALL astt840_get_ooef_info()
            END IF   
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd024
            
            #add-point:AFTER FIELD stbd024 name="input.a.stbd024"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbd024
            #add-point:ON CHANGE stbd024 name="input.g.stbd024"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd025
            
            #add-point:AFTER FIELD stbd025 name="input.a.stbd025"
            LET g_stbd_m.stbd025_desc = ' '
            DISPLAY BY NAME g_stbd_m.stbd025_desc
            IF NOT cl_null(g_stbd_m.stbd025) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_stbd_m.stbd025 != g_stbd_m_t.stbd025 OR g_stbd_m_t.stbd025 IS NULL )) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_stbd_m_t.stbd025
                  IF NOT cl_chk_exist("v_nmab001") THEN
                     LET g_stbd_m.stbd025 = g_stbd_m_t.stbd025
                     LET g_stbd_m.stbd025_desc = s_desc_get_nmabl003(g_stbd_m.stbd025)
                     DISPLAY BY NAME g_stbd_m.stbd025_desc
                     
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_stbd_m.stbd025_desc = s_desc_get_nmabl003(g_stbd_m.stbd025)
            DISPLAY BY NAME g_stbd_m.stbd025_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd025
            #add-point:BEFORE FIELD stbd025 name="input.b.stbd025"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbd025
            #add-point:ON CHANGE stbd025 name="input.g.stbd025"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd026
            #add-point:BEFORE FIELD stbd026 name="input.b.stbd026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd026
            
            #add-point:AFTER FIELD stbd026 name="input.a.stbd026"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbd026
            #add-point:ON CHANGE stbd026 name="input.g.stbd026"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd027
            #add-point:BEFORE FIELD stbd027 name="input.b.stbd027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd027
            
            #add-point:AFTER FIELD stbd027 name="input.a.stbd027"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbd027
            #add-point:ON CHANGE stbd027 name="input.g.stbd027"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd028
            #add-point:BEFORE FIELD stbd028 name="input.b.stbd028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd028
            
            #add-point:AFTER FIELD stbd028 name="input.a.stbd028"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbd028
            #add-point:ON CHANGE stbd028 name="input.g.stbd028"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd029
            #add-point:BEFORE FIELD stbd029 name="input.b.stbd029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd029
            
            #add-point:AFTER FIELD stbd029 name="input.a.stbd029"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbd029
            #add-point:ON CHANGE stbd029 name="input.g.stbd029"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd030
            
            #add-point:AFTER FIELD stbd030 name="input.a.stbd030"
            IF NOT cl_null(g_stbd_m.stbd030) THEN 
#應用 a17 樣板自動產生(Version:3)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
 
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_stbd_m.stbd030

                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooag001") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
 


            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stbd_m.stbd030
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_stbd_m.stbd030_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stbd_m.stbd030_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd030
            #add-point:BEFORE FIELD stbd030 name="input.b.stbd030"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbd030
            #add-point:ON CHANGE stbd030 name="input.g.stbd030"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd031
            #add-point:BEFORE FIELD stbd031 name="input.b.stbd031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd031
            
            #add-point:AFTER FIELD stbd031 name="input.a.stbd031"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbd031
            #add-point:ON CHANGE stbd031 name="input.g.stbd031"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd032
            #add-point:BEFORE FIELD stbd032 name="input.b.stbd032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd032
            
            #add-point:AFTER FIELD stbd032 name="input.a.stbd032"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbd032
            #add-point:ON CHANGE stbd032 name="input.g.stbd032"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd034
            #add-point:BEFORE FIELD stbd034 name="input.b.stbd034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd034
            
            #add-point:AFTER FIELD stbd034 name="input.a.stbd034"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbd034
            #add-point:ON CHANGE stbd034 name="input.g.stbd034"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd035
            #add-point:BEFORE FIELD stbd035 name="input.b.stbd035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd035
            
            #add-point:AFTER FIELD stbd035 name="input.a.stbd035"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbd035
            #add-point:ON CHANGE stbd035 name="input.g.stbd035"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd036
            #add-point:BEFORE FIELD stbd036 name="input.b.stbd036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd036
            
            #add-point:AFTER FIELD stbd036 name="input.a.stbd036"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbd036
            #add-point:ON CHANGE stbd036 name="input.g.stbd036"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbd047
            #add-point:BEFORE FIELD stbd047 name="input.b.stbd047"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbd047
            
            #add-point:AFTER FIELD stbd047 name="input.a.stbd047"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbd047
            #add-point:ON CHANGE stbd047 name="input.g.stbd047"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.stbdsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbdsite
            #add-point:ON ACTION controlp INFIELD stbdsite name="input.c.stbdsite"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE 
            LET g_qryparam.default1 = g_stbd_m.stbdsite
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'stbdsite',g_stbd_m.stbdsite,'i')
            
            CALL q_ooef001_24()         
            
            LET g_stbd_m.stbdsite = g_qryparam.return1  
            LET g_stbd_m.stbdsite_desc = s_desc_get_department_desc(g_stbd_m.stbdsite)            
            DISPLAY g_stbd_m.stbdsite TO stbdsite 
            DISPLAY g_stbd_m.stbdsite_desc TO stbdsite_desc 
            
            NEXT FIELD stbdsite                   
            #END add-point
 
 
         #Ctrlp:input.c.stbddocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbddocdt
            #add-point:ON ACTION controlp INFIELD stbddocdt name="input.c.stbddocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.stbddocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbddocno
            #add-point:ON ACTION controlp INFIELD stbddocno name="input.c.stbddocno"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段        
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_stbd_m.stbddocno             #給予default值
            LET g_qryparam.arg1 = g_ooef004
            LET g_qryparam.arg2 = g_prog
 
            CALL q_ooba002_1()          
 
            LET g_stbd_m.stbddocno = g_qryparam.return1  
            DISPLAY g_stbd_m.stbddocno TO stbddocno    
            NEXT FIELD stbddocno      
            #END add-point
 
 
         #Ctrlp:input.c.stbd037
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd037
            #add-point:ON ACTION controlp INFIELD stbd037 name="input.c.stbd037"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_stbd_m.stbd037  
            
            #CALL q_mhbe001()   #160513-00037#27 20160602 mark by beckxie
            #mark by geza 20160624 #160604-00009#69(S)
            #160513-00037#27 20160602 add by beckxie---S
#            IF NOT cl_null(g_stbd_m.stbd002) THEN
#               LET g_qryparam.where = " stje007 = '",g_stbd_m.stbd002,"'"
#            ELSE
#               LET g_qryparam.where = " stjesite = '",g_stbd_m.stbdsite,"'"
#            END IF

            #160513-00037#27 20160602 add by beckxie---E
            #mark by geza 20160624 #160604-00009#69(E)
            #add by geza 20160624 #160604-00009#69(S)
            IF g_stbd_m.stbd002 IS NOT NULL THEN
               LET g_qryparam.where = " stje007 = '",g_stbd_m.stbd002,"'"
            END IF
            IF g_stbd_m.stbd001 IS NOT NULL THEN
               IF g_qryparam.where IS NULL THEN
                  LET g_qryparam.where = " stje001 = '",g_stbd_m.stbd001,"'"
               ELSE    
                  LET g_qryparam.where = g_qryparam.where," AND stje001 = '",g_stbd_m.stbd001,"'"
               END IF                
            END IF
            #add by geza 20160815 #160815-00006#1(S)
            IF g_stbd_m.stbdsite IS NOT NULL THEN
               IF g_qryparam.where IS NULL THEN
                  LET g_qryparam.where = " stjesite = '",g_stbd_m.stbdsite,"'"
               ELSE    
                  LET g_qryparam.where = g_qryparam.where," AND stjesite = '",g_stbd_m.stbdsite,"'"
               END IF                
            END IF
            #add by geza 20160815 #160815-00006#1(E)
            CALL q_stje008_1()   
            #add by geza 20160624 #160604-00009#69(E)
            LET g_stbd_m.stbd037 = g_qryparam.return1              
            LET g_stbd_m.stbd037_desc = astt840_mhbe001_ref(g_stbd_m.stbd037)
            DISPLAY g_stbd_m.stbd037 TO stbd037 
            DISPLAY g_stbd_m.stbd037_desc TO stbd037_desc
            
            NEXT FIELD stbd037  
            #END add-point
 
 
         #Ctrlp:input.c.stbd002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd002
            #add-point:ON ACTION controlp INFIELD stbd002 name="input.c.stbd002"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE 
            LET g_qryparam.default1 = g_stbd_m.stbd002 
            #160513-00037#27 20160603 add by beckxie---S
            LET g_qryparam.arg1 = "('1','3')"
            CALL q_pmaa001_1()
            #160513-00037#27 20160603 add by beckxie---E
            #CALL q_pmaa001_10()   #160513-00037#27 20160603 mark by beckxie
            
            LET g_stbd_m.stbd002 = g_qryparam.return1              
            LET g_stbd_m.stbd002_desc = s_desc_get_trading_partner_abbr_desc(g_stbd_m.stbd002)   
            DISPLAY g_stbd_m.stbd002 TO stbd002             
            DISPLAY g_stbd_m.stbd002_desc TO stbd002_desc
            
            NEXT FIELD stbd002     
            #END add-point
 
 
         #Ctrlp:input.c.stbd046
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd046
            #add-point:ON ACTION controlp INFIELD stbd046 name="input.c.stbd046"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE 
            LET g_qryparam.default1 = g_stbd_m.stbd046        
            LET g_qryparam.arg1 = g_stbd_m.stbd002
            LET g_qryparam.arg2 = '1'
 
            CALL q_pmac002()                              
 
            LET g_stbd_m.stbd046 = g_qryparam.return1              
            LET g_stbd_m.stbd046_desc = s_desc_get_trading_partner_abbr_desc(g_stbd_m.stbd046)
            DISPLAY g_stbd_m.stbd046 TO stbd046             
            DISPLAY g_stbd_m.stbd046_desc TO stbd046_desc
            
            NEXT FIELD stbd046 
            #END add-point
 
 
         #Ctrlp:input.c.stbd000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd000
            #add-point:ON ACTION controlp INFIELD stbd000 name="input.c.stbd000"
            
            #END add-point
 
 
         #Ctrlp:input.c.stbd001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd001
            #add-point:ON ACTION controlp INFIELD stbd001 name="input.c.stbd001"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE 
            LET g_qryparam.default1 = g_stbd_m.stbd001 
            #add by geza 20160624 #160604-00009#69(S)
            IF g_stbd_m.stbd002 IS NOT NULL THEN
               LET g_qryparam.where = " stje007 = '",g_stbd_m.stbd002,"'"
            END IF
            IF g_stbd_m.stbd037 IS NOT NULL THEN
               IF g_qryparam.where IS NULL THEN
                  LET g_qryparam.where = " stje008 = '",g_stbd_m.stbd037,"'"
               ELSE    
                  LET g_qryparam.where = g_qryparam.where," AND stje008 = '",g_stbd_m.stbd037,"'"
               END IF                
            END IF
            #add by geza 20160815 #160815-00006#1(S)
            IF g_stbd_m.stbdsite IS NOT NULL THEN
               IF g_qryparam.where IS NULL THEN
                  LET g_qryparam.where = " stjesite = '",g_stbd_m.stbdsite,"'"
               ELSE    
                  LET g_qryparam.where = g_qryparam.where," AND stjesite = '",g_stbd_m.stbdsite,"'"
               END IF                
            END IF
            #add by geza 20160815 #160815-00006#1(E)
            #add by geza 20160624 #160604-00009#69(E)
            CALL q_stje001()         
            
            LET g_stbd_m.stbd001 = g_qryparam.return1             
            DISPLAY g_stbd_m.stbd001 TO stbd001       
            NEXT FIELD stbd001        
            #END add-point
 
 
         #Ctrlp:input.c.stbd041
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd041
            #add-point:ON ACTION controlp INFIELD stbd041 name="input.c.stbd041"
            
            #END add-point
 
 
         #Ctrlp:input.c.stbdunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbdunit
            #add-point:ON ACTION controlp INFIELD stbdunit name="input.c.stbdunit"
 
            #END add-point
 
 
         #Ctrlp:input.c.stbd048
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd048
            #add-point:ON ACTION controlp INFIELD stbd048 name="input.c.stbd048"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE 
            LET g_qryparam.default1 = g_stbd_m.stbd048   
            #161024-00025#4 -e by 08172
            LET g_qryparam.where = " ooef003='Y'"
            CALL q_ooef001_24()
#            CALL q_ooef001_2()                   
            #161024-00025#4 -e by 08172
            LET g_stbd_m.stbd048 = g_qryparam.return1              
            LET g_stbd_m.stbd048_desc = s_desc_get_department_desc(g_stbd_m.stbd048)
            DISPLAY g_stbd_m.stbd048 TO stbd048
            DISPLAY g_stbd_m.stbd048_desc TO stbd048_desc
            
            NEXT FIELD stbd048           
            #END add-point
 
 
         #Ctrlp:input.c.stbd049
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd049
            #add-point:ON ACTION controlp INFIELD stbd049 name="input.c.stbd049"
 
            #END add-point
 
 
         #Ctrlp:input.c.stbd050
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd050
            #add-point:ON ACTION controlp INFIELD stbd050 name="input.c.stbd050"
 
            #END add-point
 
 
         #Ctrlp:input.c.stbd003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd003
            #add-point:ON ACTION controlp INFIELD stbd003 name="input.c.stbd003"
            
            #END add-point
 
 
         #Ctrlp:input.c.stbd043
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd043
            #add-point:ON ACTION controlp INFIELD stbd043 name="input.c.stbd043"
            
            #END add-point
 
 
         #Ctrlp:input.c.stbd044
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd044
            #add-point:ON ACTION controlp INFIELD stbd044 name="input.c.stbd044"
            
            #END add-point
 
 
         #Ctrlp:input.c.stbd004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd004
            #add-point:ON ACTION controlp INFIELD stbd004 name="input.c.stbd004"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_stjo002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_stjo002
            #add-point:ON ACTION controlp INFIELD l_stjo002 name="input.c.l_stjo002"
            
            #END add-point
 
 
         #Ctrlp:input.c.stbd005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd005
            #add-point:ON ACTION controlp INFIELD stbd005 name="input.c.stbd005"
            
            #END add-point
 
 
         #Ctrlp:input.c.stbd006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd006
            #add-point:ON ACTION controlp INFIELD stbd006 name="input.c.stbd006"
            
            #END add-point
 
 
         #Ctrlp:input.c.stbd038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd038
            #add-point:ON ACTION controlp INFIELD stbd038 name="input.c.stbd038"
            
            #END add-point
 
 
         #Ctrlp:input.c.stbd060
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd060
            #add-point:ON ACTION controlp INFIELD stbd060 name="input.c.stbd060"
            
            #END add-point
 
 
         #Ctrlp:input.c.stbd033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd033
            #add-point:ON ACTION controlp INFIELD stbd033 name="input.c.stbd033"
            
            #END add-point
 
 
         #Ctrlp:input.c.stbdstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbdstus
            #add-point:ON ACTION controlp INFIELD stbdstus name="input.c.stbdstus"
            
            #END add-point
 
 
         #Ctrlp:input.c.stbd007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd007
            #add-point:ON ACTION controlp INFIELD stbd007 name="input.c.stbd007"
            
            #END add-point
 
 
         #Ctrlp:input.c.stbd052
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd052
            #add-point:ON ACTION controlp INFIELD stbd052 name="input.c.stbd052"
            
            #END add-point
 
 
         #Ctrlp:input.c.stbd051
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd051
            #add-point:ON ACTION controlp INFIELD stbd051 name="input.c.stbd051"
            
            #END add-point
 
 
         #Ctrlp:input.c.stbd053
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd053
            #add-point:ON ACTION controlp INFIELD stbd053 name="input.c.stbd053"
            
            #END add-point
 
 
         #Ctrlp:input.c.stbd008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd008
            #add-point:ON ACTION controlp INFIELD stbd008 name="input.c.stbd008"
            
            #END add-point
 
 
         #Ctrlp:input.c.stbd054
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd054
            #add-point:ON ACTION controlp INFIELD stbd054 name="input.c.stbd054"
            
            #END add-point
 
 
         #Ctrlp:input.c.stbd009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd009
            #add-point:ON ACTION controlp INFIELD stbd009 name="input.c.stbd009"
            
            #END add-point
 
 
         #Ctrlp:input.c.stbd055
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd055
            #add-point:ON ACTION controlp INFIELD stbd055 name="input.c.stbd055"
            
            #END add-point
 
 
         #Ctrlp:input.c.stbd010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd010
            #add-point:ON ACTION controlp INFIELD stbd010 name="input.c.stbd010"
            
            #END add-point
 
 
         #Ctrlp:input.c.stbd056
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd056
            #add-point:ON ACTION controlp INFIELD stbd056 name="input.c.stbd056"
            
            #END add-point
 
 
         #Ctrlp:input.c.stbd011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd011
            #add-point:ON ACTION controlp INFIELD stbd011 name="input.c.stbd011"
            
            #END add-point
 
 
         #Ctrlp:input.c.stbd057
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd057
            #add-point:ON ACTION controlp INFIELD stbd057 name="input.c.stbd057"
            
            #END add-point
 
 
         #Ctrlp:input.c.stbd012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd012
            #add-point:ON ACTION controlp INFIELD stbd012 name="input.c.stbd012"
            
            #END add-point
 
 
         #Ctrlp:input.c.stbd058
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd058
            #add-point:ON ACTION controlp INFIELD stbd058 name="input.c.stbd058"
            
            #END add-point
 
 
         #Ctrlp:input.c.stbd013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd013
            #add-point:ON ACTION controlp INFIELD stbd013 name="input.c.stbd013"
            
            #END add-point
 
 
         #Ctrlp:input.c.stbd059
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd059
            #add-point:ON ACTION controlp INFIELD stbd059 name="input.c.stbd059"
            
            #END add-point
 
 
         #Ctrlp:input.c.stbd014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd014
            #add-point:ON ACTION controlp INFIELD stbd014 name="input.c.stbd014"
            
            #END add-point
 
 
         #Ctrlp:input.c.stbd017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd017
            #add-point:ON ACTION controlp INFIELD stbd017 name="input.c.stbd017"
            
            #END add-point
 
 
         #Ctrlp:input.c.stbd018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd018
            #add-point:ON ACTION controlp INFIELD stbd018 name="input.c.stbd018"
            
            #END add-point
 
 
         #Ctrlp:input.c.stbd016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd016
            #add-point:ON ACTION controlp INFIELD stbd016 name="input.c.stbd016"
            
            #END add-point
 
 
         #Ctrlp:input.c.stbd019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd019
            #add-point:ON ACTION controlp INFIELD stbd019 name="input.c.stbd019"
            
            #END add-point
 
 
         #Ctrlp:input.c.stbd045
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd045
            #add-point:ON ACTION controlp INFIELD stbd045 name="input.c.stbd045"
            
            #END add-point
 
 
         #Ctrlp:input.c.stbd015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd015
            #add-point:ON ACTION controlp INFIELD stbd015 name="input.c.stbd015"
            
            #END add-point
 
 
         #Ctrlp:input.c.stbd040
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd040
            #add-point:ON ACTION controlp INFIELD stbd040 name="input.c.stbd040"
            
            #END add-point
 
 
         #Ctrlp:input.c.stbd039
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd039
            #add-point:ON ACTION controlp INFIELD stbd039 name="input.c.stbd039"
            
            #END add-point
 
 
         #Ctrlp:input.c.stbd020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd020
            #add-point:ON ACTION controlp INFIELD stbd020 name="input.c.stbd020"
            
            #END add-point
 
 
         #Ctrlp:input.c.stbd042
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd042
            #add-point:ON ACTION controlp INFIELD stbd042 name="input.c.stbd042"
            
            #END add-point
 
 
         #Ctrlp:input.c.stbd021
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd021
            #add-point:ON ACTION controlp INFIELD stbd021 name="input.c.stbd021"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE 
            LET g_qryparam.default1 = g_stbd_m.stbd021
 
            CALL q_ooag001()                       
            
            LET g_stbd_m.stbd021 = g_qryparam.return1              
            LET g_stbd_m.stbd021_desc = s_desc_get_person_desc(g_stbd_m.stbd021)         
            DISPLAY g_stbd_m.stbd021 TO stbd021           
            DISPLAY g_stbd_m.stbd021_desc TO stbd021_desc
            
            NEXT FIELD stbd021 
            #END add-point
 
 
         #Ctrlp:input.c.stbd022
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd022
            #add-point:ON ACTION controlp INFIELD stbd022 name="input.c.stbd022"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE 
            LET g_qryparam.default1 = g_stbd_m.stbd022             
 
            CALL q_ooeg001()                      
            
            LET g_stbd_m.stbd022 = g_qryparam.return1              
            LET g_stbd_m.stbd022_desc = s_desc_get_department_desc(g_stbd_m.stbd022)   
            DISPLAY g_stbd_m.stbd022 TO stbd022            
            DISPLAY g_stbd_m.stbd022_desc TO stbd022_desc
            
            NEXT FIELD stbd022  
            #END add-point
 
 
         #Ctrlp:input.c.stbd023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd023
            #add-point:ON ACTION controlp INFIELD stbd023 name="input.c.stbd023"
 
            #END add-point
 
 
         #Ctrlp:input.c.stbd024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd024
            #add-point:ON ACTION controlp INFIELD stbd024 name="input.c.stbd024"
            
            #END add-point
 
 
         #Ctrlp:input.c.stbd025
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd025
            #add-point:ON ACTION controlp INFIELD stbd025 name="input.c.stbd025"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE 
            LET g_qryparam.default1 = g_stbd_m.stbd025  
            LET g_qryparam.arg1 = g_ooef006
            
            CALL q_nmab001_1()     
            
            LET g_stbd_m.stbd025 = g_qryparam.return1 
            LET g_stbd_m.stbd025_desc = s_desc_get_nmabl003(g_stbd_m.stbd025)
            DISPLAY g_stbd_m.stbd025 TO stbd025   
            DISPLAY g_stbd_m.stbd025_desc TO stbd025_desc
            
            NEXT FIELD stbd025       
            #END add-point
 
 
         #Ctrlp:input.c.stbd026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd026
            #add-point:ON ACTION controlp INFIELD stbd026 name="input.c.stbd026"
            
            #END add-point
 
 
         #Ctrlp:input.c.stbd027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd027
            #add-point:ON ACTION controlp INFIELD stbd027 name="input.c.stbd027"
            
            #END add-point
 
 
         #Ctrlp:input.c.stbd028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd028
            #add-point:ON ACTION controlp INFIELD stbd028 name="input.c.stbd028"
            
            #END add-point
 
 
         #Ctrlp:input.c.stbd029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd029
            #add-point:ON ACTION controlp INFIELD stbd029 name="input.c.stbd029"
            
            #END add-point
 
 
         #Ctrlp:input.c.stbd030
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd030
            #add-point:ON ACTION controlp INFIELD stbd030 name="input.c.stbd030"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_stbd_m.stbd030             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_ooag001()                                #呼叫開窗
 
            LET g_stbd_m.stbd030 = g_qryparam.return1              

            DISPLAY g_stbd_m.stbd030 TO stbd030              #

            NEXT FIELD stbd030                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.stbd031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd031
            #add-point:ON ACTION controlp INFIELD stbd031 name="input.c.stbd031"
            
            #END add-point
 
 
         #Ctrlp:input.c.stbd032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd032
            #add-point:ON ACTION controlp INFIELD stbd032 name="input.c.stbd032"
            
            #END add-point
 
 
         #Ctrlp:input.c.stbd034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd034
            #add-point:ON ACTION controlp INFIELD stbd034 name="input.c.stbd034"
            
            #END add-point
 
 
         #Ctrlp:input.c.stbd035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd035
            #add-point:ON ACTION controlp INFIELD stbd035 name="input.c.stbd035"
            
            #END add-point
 
 
         #Ctrlp:input.c.stbd036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd036
            #add-point:ON ACTION controlp INFIELD stbd036 name="input.c.stbd036"
            
            #END add-point
 
 
         #Ctrlp:input.c.stbd047
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbd047
            #add-point:ON ACTION controlp INFIELD stbd047 name="input.c.stbd047"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_stbd_m.stbddocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               LET l_success = ''
               CALL s_aooi200_gen_docno(g_stbd_m.stbdsite,g_stbd_m.stbddocno,g_stbd_m.stbddocdt,g_prog) 
                    RETURNING l_success,g_stbd_m.stbddocno
                    
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apm-00003'            ##自動生成單據編號有誤，請重新確認
                  LET g_errparam.extend = g_stbd_m.stbddocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
               
                  CALL s_transaction_end('N',0)
               
                  NEXT FIELD stbddocno
               END IF
               #end add-point
               
               INSERT INTO stbd_t (stbdent,stbdsite,stbddocdt,stbddocno,stbd037,stbd002,stbd046,stbd000, 
                   stbd001,stbd041,stbdunit,stbd048,stbd049,stbd050,stbd003,stbd043,stbd044,stbd004, 
                   stbd005,stbd006,stbd038,stbd060,stbd033,stbdstus,stbdownid,stbdowndp,stbdcrtid,stbdcrtdp, 
                   stbdcrtdt,stbdmodid,stbdmoddt,stbdcnfid,stbdcnfdt,stbd007,stbd052,stbd051,stbd053, 
                   stbd008,stbd054,stbd009,stbd055,stbd010,stbd056,stbd011,stbd057,stbd012,stbd058,stbd013, 
                   stbd059,stbd014,stbd017,stbd018,stbd016,stbd019,stbd045,stbd015,stbd040,stbd039,stbd020, 
                   stbd042,stbd021,stbd022,stbd023,stbd024,stbd025,stbd026,stbd027,stbd028,stbd029,stbd030, 
                   stbd031,stbd032,stbd034,stbd035,stbd036,stbd047)
               VALUES (g_enterprise,g_stbd_m.stbdsite,g_stbd_m.stbddocdt,g_stbd_m.stbddocno,g_stbd_m.stbd037, 
                   g_stbd_m.stbd002,g_stbd_m.stbd046,g_stbd_m.stbd000,g_stbd_m.stbd001,g_stbd_m.stbd041, 
                   g_stbd_m.stbdunit,g_stbd_m.stbd048,g_stbd_m.stbd049,g_stbd_m.stbd050,g_stbd_m.stbd003, 
                   g_stbd_m.stbd043,g_stbd_m.stbd044,g_stbd_m.stbd004,g_stbd_m.stbd005,g_stbd_m.stbd006, 
                   g_stbd_m.stbd038,g_stbd_m.stbd060,g_stbd_m.stbd033,g_stbd_m.stbdstus,g_stbd_m.stbdownid, 
                   g_stbd_m.stbdowndp,g_stbd_m.stbdcrtid,g_stbd_m.stbdcrtdp,g_stbd_m.stbdcrtdt,g_stbd_m.stbdmodid, 
                   g_stbd_m.stbdmoddt,g_stbd_m.stbdcnfid,g_stbd_m.stbdcnfdt,g_stbd_m.stbd007,g_stbd_m.stbd052, 
                   g_stbd_m.stbd051,g_stbd_m.stbd053,g_stbd_m.stbd008,g_stbd_m.stbd054,g_stbd_m.stbd009, 
                   g_stbd_m.stbd055,g_stbd_m.stbd010,g_stbd_m.stbd056,g_stbd_m.stbd011,g_stbd_m.stbd057, 
                   g_stbd_m.stbd012,g_stbd_m.stbd058,g_stbd_m.stbd013,g_stbd_m.stbd059,g_stbd_m.stbd014, 
                   g_stbd_m.stbd017,g_stbd_m.stbd018,g_stbd_m.stbd016,g_stbd_m.stbd019,g_stbd_m.stbd045, 
                   g_stbd_m.stbd015,g_stbd_m.stbd040,g_stbd_m.stbd039,g_stbd_m.stbd020,g_stbd_m.stbd042, 
                   g_stbd_m.stbd021,g_stbd_m.stbd022,g_stbd_m.stbd023,g_stbd_m.stbd024,g_stbd_m.stbd025, 
                   g_stbd_m.stbd026,g_stbd_m.stbd027,g_stbd_m.stbd028,g_stbd_m.stbd029,g_stbd_m.stbd030, 
                   g_stbd_m.stbd031,g_stbd_m.stbd032,g_stbd_m.stbd034,g_stbd_m.stbd035,g_stbd_m.stbd036, 
                   g_stbd_m.stbd047) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_stbd_m:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭新增中 name="input.head.m_insert"
               #160513-00037#27 20160602 add by beckxie---S
               CALL astt840_01(g_stbd_m.stbddocno)
               LET INT_FLAG = FALSE
#               IF g_current_idx > 0 THEN
#                  CALL astt840_ui_headershow()
#               END IF
               CALL astt840_b_fill()
               #160513-00037#27 20160602 add by beckxie---E
               #end add-point
               
               
               
               
               #add-point:單頭新增後 name="input.head.a_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL astt840_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL astt840_b_fill()
                  CALL astt840_b_fill2('0')
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
               CALL astt840_stbd_t_mask_restore('restore_mask_o')
               
               UPDATE stbd_t SET (stbdsite,stbddocdt,stbddocno,stbd037,stbd002,stbd046,stbd000,stbd001, 
                   stbd041,stbdunit,stbd048,stbd049,stbd050,stbd003,stbd043,stbd044,stbd004,stbd005, 
                   stbd006,stbd038,stbd060,stbd033,stbdstus,stbdownid,stbdowndp,stbdcrtid,stbdcrtdp, 
                   stbdcrtdt,stbdmodid,stbdmoddt,stbdcnfid,stbdcnfdt,stbd007,stbd052,stbd051,stbd053, 
                   stbd008,stbd054,stbd009,stbd055,stbd010,stbd056,stbd011,stbd057,stbd012,stbd058,stbd013, 
                   stbd059,stbd014,stbd017,stbd018,stbd016,stbd019,stbd045,stbd015,stbd040,stbd039,stbd020, 
                   stbd042,stbd021,stbd022,stbd023,stbd024,stbd025,stbd026,stbd027,stbd028,stbd029,stbd030, 
                   stbd031,stbd032,stbd034,stbd035,stbd036,stbd047) = (g_stbd_m.stbdsite,g_stbd_m.stbddocdt, 
                   g_stbd_m.stbddocno,g_stbd_m.stbd037,g_stbd_m.stbd002,g_stbd_m.stbd046,g_stbd_m.stbd000, 
                   g_stbd_m.stbd001,g_stbd_m.stbd041,g_stbd_m.stbdunit,g_stbd_m.stbd048,g_stbd_m.stbd049, 
                   g_stbd_m.stbd050,g_stbd_m.stbd003,g_stbd_m.stbd043,g_stbd_m.stbd044,g_stbd_m.stbd004, 
                   g_stbd_m.stbd005,g_stbd_m.stbd006,g_stbd_m.stbd038,g_stbd_m.stbd060,g_stbd_m.stbd033, 
                   g_stbd_m.stbdstus,g_stbd_m.stbdownid,g_stbd_m.stbdowndp,g_stbd_m.stbdcrtid,g_stbd_m.stbdcrtdp, 
                   g_stbd_m.stbdcrtdt,g_stbd_m.stbdmodid,g_stbd_m.stbdmoddt,g_stbd_m.stbdcnfid,g_stbd_m.stbdcnfdt, 
                   g_stbd_m.stbd007,g_stbd_m.stbd052,g_stbd_m.stbd051,g_stbd_m.stbd053,g_stbd_m.stbd008, 
                   g_stbd_m.stbd054,g_stbd_m.stbd009,g_stbd_m.stbd055,g_stbd_m.stbd010,g_stbd_m.stbd056, 
                   g_stbd_m.stbd011,g_stbd_m.stbd057,g_stbd_m.stbd012,g_stbd_m.stbd058,g_stbd_m.stbd013, 
                   g_stbd_m.stbd059,g_stbd_m.stbd014,g_stbd_m.stbd017,g_stbd_m.stbd018,g_stbd_m.stbd016, 
                   g_stbd_m.stbd019,g_stbd_m.stbd045,g_stbd_m.stbd015,g_stbd_m.stbd040,g_stbd_m.stbd039, 
                   g_stbd_m.stbd020,g_stbd_m.stbd042,g_stbd_m.stbd021,g_stbd_m.stbd022,g_stbd_m.stbd023, 
                   g_stbd_m.stbd024,g_stbd_m.stbd025,g_stbd_m.stbd026,g_stbd_m.stbd027,g_stbd_m.stbd028, 
                   g_stbd_m.stbd029,g_stbd_m.stbd030,g_stbd_m.stbd031,g_stbd_m.stbd032,g_stbd_m.stbd034, 
                   g_stbd_m.stbd035,g_stbd_m.stbd036,g_stbd_m.stbd047)
                WHERE stbdent = g_enterprise AND stbddocno = g_stbddocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "stbd_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL astt840_stbd_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_stbd_m_t)
               LET g_log2 = util.JSON.stringify(g_stbd_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               #160513-00037#27 20160602 add by beckxie---S
#               CALL astt840_01(g_stbd_m.stbddocno)
#               LET INT_FLAG = FALSE
#               
#               IF g_current_idx > 0 THEN
#                  CALL astt840_ui_headershow()
#               END IF
#               CALL astt840_b_fill()
               #160513-00037#27 20160602 add by beckxie---E
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_stbddocno_t = g_stbd_m.stbddocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="astt840.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_stbe_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = FALSE, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = FALSE)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            #160513-00037#27 20160603 add by beckxie---S
            ##单身没资料关闭单身
            #IF g_stbe_d.getLength()=0 THEN
            #   EXIT DIALOG
            #END IF 
            #160513-00037#27 20160603 add by beckxie---E
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_stbe_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL astt840_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_stbe_d.getLength()
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
            OPEN astt840_cl USING g_enterprise,g_stbd_m.stbddocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN astt840_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE astt840_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_stbe_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_stbe_d[l_ac].stbeseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_stbe_d_t.* = g_stbe_d[l_ac].*  #BACKUP
               LET g_stbe_d_o.* = g_stbe_d[l_ac].*  #BACKUP
               CALL astt840_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL astt840_set_no_entry_b(l_cmd)
               IF NOT astt840_lock_b("stbe_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH astt840_bcl INTO g_stbe_d[l_ac].stbeseq,g_stbe_d[l_ac].stbe001,g_stbe_d[l_ac].stbe002, 
                      g_stbe_d[l_ac].stbe003,g_stbe_d[l_ac].stbe004,g_stbe_d[l_ac].stbe028,g_stbe_d[l_ac].stbe005, 
                      g_stbe_d[l_ac].stbe035,g_stbe_d[l_ac].stbe036,g_stbe_d[l_ac].stbe024,g_stbe_d[l_ac].stbe025, 
                      g_stbe_d[l_ac].stbe006,g_stbe_d[l_ac].stbe007,g_stbe_d[l_ac].stbe008,g_stbe_d[l_ac].stbe009, 
                      g_stbe_d[l_ac].stbe010,g_stbe_d[l_ac].stbe011,g_stbe_d[l_ac].stbe012,g_stbe_d[l_ac].stbe013, 
                      g_stbe_d[l_ac].stbe014,g_stbe_d[l_ac].stbe015,g_stbe_d[l_ac].stbe016,g_stbe_d[l_ac].stbe026, 
                      g_stbe_d[l_ac].stbe027,g_stbe_d[l_ac].stbe017,g_stbe_d[l_ac].stbe018,g_stbe_d[l_ac].stbe033, 
                      g_stbe_d[l_ac].stbe031,g_stbe_d[l_ac].stbe034,g_stbe_d[l_ac].stbesite,g_stbe_d[l_ac].stbe020, 
                      g_stbe_d[l_ac].stbe019,g_stbe_d[l_ac].stbe032,g_stbe_d[l_ac].stbecomp,g_stbe_d[l_ac].stbe021, 
                      g_stbe_d[l_ac].stbe022,g_stbe_d[l_ac].stbe023
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_stbe_d_t.stbeseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_stbe_d_mask_o[l_ac].* =  g_stbe_d[l_ac].*
                  CALL astt840_stbe_t_mask()
                  LET g_stbe_d_mask_n[l_ac].* =  g_stbe_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL astt840_show()
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
            INITIALIZE g_stbe_d[l_ac].* TO NULL 
            INITIALIZE g_stbe_d_t.* TO NULL 
            INITIALIZE g_stbe_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_stbe_d[l_ac].stbe012 = "0"
      LET g_stbe_d[l_ac].stbe013 = "0"
      LET g_stbe_d[l_ac].stbe014 = "0"
      LET g_stbe_d[l_ac].stbe015 = "0"
      LET g_stbe_d[l_ac].stbe016 = "0"
      LET g_stbe_d[l_ac].stbe026 = "0"
      LET g_stbe_d[l_ac].stbe027 = "0"
      LET g_stbe_d[l_ac].stbe031 = "0"
      LET g_stbe_d[l_ac].stbe034 = "0"
      LET g_stbe_d[l_ac].stbe021 = "0"
      LET g_stbe_d[l_ac].stbe022 = "0"
      LET g_stbe_d[l_ac].stbe023 = "0"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            LET g_stbe_d[l_ac].stbeseq = astt840_stbeseq_def()
            #end add-point
            LET g_stbe_d_t.* = g_stbe_d[l_ac].*     #新輸入資料
            LET g_stbe_d_o.* = g_stbe_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL astt840_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL astt840_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_stbe_d[li_reproduce_target].* = g_stbe_d[li_reproduce].*
 
               LET g_stbe_d[li_reproduce_target].stbeseq = NULL
 
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
            SELECT COUNT(1) INTO l_count FROM stbe_t 
             WHERE stbeent = g_enterprise AND stbedocno = g_stbd_m.stbddocno
 
               AND stbeseq = g_stbe_d[l_ac].stbeseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_stbd_m.stbddocno
               LET gs_keys[2] = g_stbe_d[g_detail_idx].stbeseq
               CALL astt840_insert_b('stbe_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               IF NOT s_astt840_upd_stbc(1,
                                         g_stbd_m.stbddocno,g_stbd_m.stbdunit,
                                         g_stbe_d[l_ac].stbe002,g_stbe_d[l_ac].stbe003) THEN
                  CALL s_transaction_end('N','0')
               END IF
               
               IF NOT s_astp840_stbe_summary(g_stbd_m.stbddocno) THEN
                  CALL s_transaction_end('N',0)
               else
                 SELECT  stbd008,stbd009,stbd010,stbd011,stbd012,stbd013,stbd014,stbd015,stbd016,stbd017,stbd018,stbd019,
                        stbd040,stbd045,stbd051,stbd052,stbd053,stbd054,stbd055,stbd056,stbd057,stbd058,stbd059
                INTO g_stbd_m.stbd008,g_stbd_m.stbd009,g_stbd_m.stbd010,g_stbd_m.stbd011,g_stbd_m.stbd012,g_stbd_m.stbd013,g_stbd_m.stbd014,g_stbd_m.stbd015,g_stbd_m.stbd016,g_stbd_m.stbd017,g_stbd_m.stbd018,g_stbd_m.stbd019,
                     g_stbd_m.stbd040,g_stbd_m.stbd045,g_stbd_m.stbd051,g_stbd_m.stbd052,g_stbd_m.stbd053,g_stbd_m.stbd054,g_stbd_m.stbd055,g_stbd_m.stbd056,g_stbd_m.stbd057,g_stbd_m.stbd058,g_stbd_m.stbd059
                FROM stbd_t 
                WHERE stbdent=g_enterprise   AND  stbddocno=g_stbd_m.stbddocno 
                DISPLAY BY NAME g_stbd_m.stbd008,g_stbd_m.stbd009,g_stbd_m.stbd010,g_stbd_m.stbd011,g_stbd_m.stbd012,
                                g_stbd_m.stbd013,g_stbd_m.stbd014,g_stbd_m.stbd015,g_stbd_m.stbd016,g_stbd_m.stbd017,
                                g_stbd_m.stbd018,g_stbd_m.stbd019,g_stbd_m.stbd040,g_stbd_m.stbd045,g_stbd_m.stbd051,
                                g_stbd_m.stbd052,g_stbd_m.stbd053,g_stbd_m.stbd054,g_stbd_m.stbd055,g_stbd_m.stbd056,
                                g_stbd_m.stbd057,g_stbd_m.stbd058,g_stbd_m.stbd059

               END IF
               IF g_current_idx > 0 THEN
                  CALL astt840_ui_headershow()
               END IF
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_stbe_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "stbe_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL astt840_b_fill()
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
               LET gs_keys[01] = g_stbd_m.stbddocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_stbe_d_t.stbeseq
 
            
               #刪除同層單身
               IF NOT astt840_delete_b('stbe_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE astt840_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT astt840_key_delete_b(gs_keys,'stbe_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE astt840_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               #IF NOT s_astt840_upd_stbc(1,   #160604-00009#15 20160607 mark by beckxie
               IF NOT s_astt840_upd_stbc(2,   #160604-00009#15 20160607 add by beckxie
                                         g_stbd_m.stbddocno,g_stbd_m.stbdunit,
                                         g_stbe_d[l_ac].stbe002,g_stbe_d[l_ac].stbe003) THEN
                  CALL s_transaction_end('N','0')
               END IF
               IF NOT s_astp840_stbe_summary(g_stbd_m.stbddocno) THEN
                  CALL s_transaction_end('N',0)
               else
                  SELECT  stbd008,stbd009,stbd010,stbd011,stbd012,stbd013,stbd014,stbd015,stbd016,stbd017,stbd018,stbd019,
                        stbd040,stbd045,stbd051,stbd052,stbd053,stbd054,stbd055,stbd056,stbd057,stbd058,stbd059
                INTO g_stbd_m.stbd008,g_stbd_m.stbd009,g_stbd_m.stbd010,g_stbd_m.stbd011,g_stbd_m.stbd012,g_stbd_m.stbd013,g_stbd_m.stbd014,g_stbd_m.stbd015,g_stbd_m.stbd016,g_stbd_m.stbd017,g_stbd_m.stbd018,g_stbd_m.stbd019,
                     g_stbd_m.stbd040,g_stbd_m.stbd045,g_stbd_m.stbd051,g_stbd_m.stbd052,g_stbd_m.stbd053,g_stbd_m.stbd054,g_stbd_m.stbd055,g_stbd_m.stbd056,g_stbd_m.stbd057,g_stbd_m.stbd058,g_stbd_m.stbd059
                FROM stbd_t 
                WHERE stbdent=g_enterprise   AND  stbddocno=g_stbd_m.stbddocno 
                DISPLAY BY NAME g_stbd_m.stbd008,g_stbd_m.stbd009,g_stbd_m.stbd010,g_stbd_m.stbd011,g_stbd_m.stbd012,
                                g_stbd_m.stbd013,g_stbd_m.stbd014,g_stbd_m.stbd015,g_stbd_m.stbd016,g_stbd_m.stbd017,
                                g_stbd_m.stbd018,g_stbd_m.stbd019,g_stbd_m.stbd040,g_stbd_m.stbd045,g_stbd_m.stbd051,
                                g_stbd_m.stbd052,g_stbd_m.stbd053,g_stbd_m.stbd054,g_stbd_m.stbd055,g_stbd_m.stbd056,
                                g_stbd_m.stbd057,g_stbd_m.stbd058,g_stbd_m.stbd059
               END IF
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE astt840_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_stbe_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_stbe_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbeseq
            #add-point:BEFORE FIELD stbeseq name="input.b.page1.stbeseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbeseq
            
            #add-point:AFTER FIELD stbeseq name="input.a.page1.stbeseq"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  g_stbd_m.stbddocno IS NOT NULL AND g_stbe_d[g_detail_idx].stbeseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_stbd_m.stbddocno != g_stbddocno_t OR g_stbe_d[g_detail_idx].stbeseq != g_stbe_d_t.stbeseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(1) FROM stbe_t WHERE "||"stbeent = '" ||g_enterprise|| "' AND "||"stbedocno = '"||g_stbd_m.stbddocno ||"' AND "|| "stbeseq = '"||g_stbe_d[g_detail_idx].stbeseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbeseq
            #add-point:ON CHANGE stbeseq name="input.g.page1.stbeseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe001
            #add-point:BEFORE FIELD stbe001 name="input.b.page1.stbe001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe001
            
            #add-point:AFTER FIELD stbe001 name="input.a.page1.stbe001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbe001
            #add-point:ON CHANGE stbe001 name="input.g.page1.stbe001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe002
            
            #add-point:AFTER FIELD stbe002 name="input.a.page1.stbe002"
            IF NOT cl_null(g_stbe_d[l_ac].stbe002) THEN
               IF g_stbe_d[l_ac].stbe002 != g_stbe_d_o.stbe002 OR cl_null(g_stbe_d_o.stbe002) THEN
                   IF NOT astt840_stbe002_chk(1,g_stbe_d[l_ac].stbe001,g_stbe_d[l_ac].stbe002) THEN
                      LET g_stbe_d[l_ac].stbe002 = g_stbe_d_o.stbe002
                      NEXT FIELD CURRENT    
                   END IF
                   
                   IF NOT astt840_stbe_def(1)  THEN
                      LET g_stbe_d[l_ac].stbe002 = g_stbe_d_o.stbe002
                   END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe002
            #add-point:BEFORE FIELD stbe002 name="input.b.page1.stbe002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbe002
            #add-point:ON CHANGE stbe002 name="input.g.page1.stbe002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe003
            #add-point:BEFORE FIELD stbe003 name="input.b.page1.stbe003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe003
            
            #add-point:AFTER FIELD stbe003 name="input.a.page1.stbe003"
            IF NOT cl_null(g_stbe_d[l_ac].stbe003) THEN
               IF g_stbe_d[l_ac].stbe003 != g_stbe_d_o.stbe003 OR cl_null(g_stbe_d_o.stbe003) THEN                   
                   IF NOT astt840_stbe_def(1)  THEN
                      LET g_stbe_d[l_ac].stbe003 = g_stbe_d_o.stbe003
                   END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbe003
            #add-point:ON CHANGE stbe003 name="input.g.page1.stbe003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe004
            #add-point:BEFORE FIELD stbe004 name="input.b.page1.stbe004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe004
            
            #add-point:AFTER FIELD stbe004 name="input.a.page1.stbe004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbe004
            #add-point:ON CHANGE stbe004 name="input.g.page1.stbe004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe028
            
            #add-point:AFTER FIELD stbe028 name="input.a.page1.stbe028"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stbe_d[l_ac].stbe028
            CALL ap_ref_array2(g_ref_fields,"SELECT mhbel003 FROM mhbel_t WHERE mhbelent='"||g_enterprise||"' AND mhbel001=? AND mhbel002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_stbe_d[l_ac].stbe028_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stbe_d[l_ac].stbe028_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe028
            #add-point:BEFORE FIELD stbe028 name="input.b.page1.stbe028"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbe028
            #add-point:ON CHANGE stbe028 name="input.g.page1.stbe028"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe005
            
            #add-point:AFTER FIELD stbe005 name="input.a.page1.stbe005"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe005
            #add-point:BEFORE FIELD stbe005 name="input.b.page1.stbe005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbe005
            #add-point:ON CHANGE stbe005 name="input.g.page1.stbe005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe024
            #add-point:BEFORE FIELD stbe024 name="input.b.page1.stbe024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe024
            
            #add-point:AFTER FIELD stbe024 name="input.a.page1.stbe024"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbe024
            #add-point:ON CHANGE stbe024 name="input.g.page1.stbe024"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe025
            #add-point:BEFORE FIELD stbe025 name="input.b.page1.stbe025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe025
            
            #add-point:AFTER FIELD stbe025 name="input.a.page1.stbe025"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbe025
            #add-point:ON CHANGE stbe025 name="input.g.page1.stbe025"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_stae003
            
            #add-point:AFTER FIELD l_stae003 name="input.a.page1.l_stae003"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_stae003
            #add-point:BEFORE FIELD l_stae003 name="input.b.page1.l_stae003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_stae003
            #add-point:ON CHANGE l_stae003 name="input.g.page1.l_stae003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe006
            #add-point:BEFORE FIELD stbe006 name="input.b.page1.stbe006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe006
            
            #add-point:AFTER FIELD stbe006 name="input.a.page1.stbe006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbe006
            #add-point:ON CHANGE stbe006 name="input.g.page1.stbe006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe007
            #add-point:BEFORE FIELD stbe007 name="input.b.page1.stbe007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe007
            
            #add-point:AFTER FIELD stbe007 name="input.a.page1.stbe007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbe007
            #add-point:ON CHANGE stbe007 name="input.g.page1.stbe007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe008
            
            #add-point:AFTER FIELD stbe008 name="input.a.page1.stbe008"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stbe_d[l_ac].stbe008
            CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_stbe_d[l_ac].stbe008_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stbe_d[l_ac].stbe008_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe008
            #add-point:BEFORE FIELD stbe008 name="input.b.page1.stbe008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbe008
            #add-point:ON CHANGE stbe008 name="input.g.page1.stbe008"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe009
            
            #add-point:AFTER FIELD stbe009 name="input.a.page1.stbe009"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe009
            #add-point:BEFORE FIELD stbe009 name="input.b.page1.stbe009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbe009
            #add-point:ON CHANGE stbe009 name="input.g.page1.stbe009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe010
            #add-point:BEFORE FIELD stbe010 name="input.b.page1.stbe010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe010
            
            #add-point:AFTER FIELD stbe010 name="input.a.page1.stbe010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbe010
            #add-point:ON CHANGE stbe010 name="input.g.page1.stbe010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe011
            #add-point:BEFORE FIELD stbe011 name="input.b.page1.stbe011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe011
            
            #add-point:AFTER FIELD stbe011 name="input.a.page1.stbe011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbe011
            #add-point:ON CHANGE stbe011 name="input.g.page1.stbe011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe012
            #add-point:BEFORE FIELD stbe012 name="input.b.page1.stbe012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe012
            
            #add-point:AFTER FIELD stbe012 name="input.a.page1.stbe012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbe012
            #add-point:ON CHANGE stbe012 name="input.g.page1.stbe012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe013
            #add-point:BEFORE FIELD stbe013 name="input.b.page1.stbe013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe013
            
            #add-point:AFTER FIELD stbe013 name="input.a.page1.stbe013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbe013
            #add-point:ON CHANGE stbe013 name="input.g.page1.stbe013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe014
            #add-point:BEFORE FIELD stbe014 name="input.b.page1.stbe014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe014
            
            #add-point:AFTER FIELD stbe014 name="input.a.page1.stbe014"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbe014
            #add-point:ON CHANGE stbe014 name="input.g.page1.stbe014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe015
            #add-point:BEFORE FIELD stbe015 name="input.b.page1.stbe015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe015
            
            #add-point:AFTER FIELD stbe015 name="input.a.page1.stbe015"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbe015
            #add-point:ON CHANGE stbe015 name="input.g.page1.stbe015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe016
            #add-point:BEFORE FIELD stbe016 name="input.b.page1.stbe016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe016
            
            #add-point:AFTER FIELD stbe016 name="input.a.page1.stbe016"
            ##add by zhangnan  --str  #160906-00032#1
            IF NOT cl_null(g_stbe_d[l_ac].stbe016) THEN
               IF g_stbe_d[l_ac].stbe014 < 0 THEN 
                  IF g_stbe_d[l_ac].stbe016 > 0 OR g_stbe_d[l_ac].stbe016 < g_stbe_d[l_ac].stbe014 THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'ast-00856'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     NEXT FIELD stbe016
                  END IF 
               ELSE
                  IF g_stbe_d[l_ac].stbe016 < 0 OR g_stbe_d[l_ac].stbe016 > g_stbe_d[l_ac].stbe014 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'ast-00857'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     NEXT FIELD stbe016
                  END IF
               END IF 
            END IF
            ##add by zhangnan   --end   #160906-00032#1           
##mark by zhangnan    --str            
#               if g_stbe_d[l_ac].stbe016>g_stbe_d[l_ac].stbe014 then
#                   INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code = 'ast-00292'
#                     LET g_errparam.extend = ''
#                     LET g_errparam.popup = TRUE
#                     CALL cl_err()
#                     NEXT FIELD stbe016
#                end if                      
##mark by zhangnan    --end 

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbe016
            #add-point:ON CHANGE stbe016 name="input.g.page1.stbe016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe026
            #add-point:BEFORE FIELD stbe026 name="input.b.page1.stbe026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe026
            
            #add-point:AFTER FIELD stbe026 name="input.a.page1.stbe026"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbe026
            #add-point:ON CHANGE stbe026 name="input.g.page1.stbe026"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe027
            #add-point:BEFORE FIELD stbe027 name="input.b.page1.stbe027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe027
            
            #add-point:AFTER FIELD stbe027 name="input.a.page1.stbe027"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbe027
            #add-point:ON CHANGE stbe027 name="input.g.page1.stbe027"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe017
            
            #add-point:AFTER FIELD stbe017 name="input.a.page1.stbe017"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe017
            #add-point:BEFORE FIELD stbe017 name="input.b.page1.stbe017"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbe017
            #add-point:ON CHANGE stbe017 name="input.g.page1.stbe017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe018
            #add-point:BEFORE FIELD stbe018 name="input.b.page1.stbe018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe018
            
            #add-point:AFTER FIELD stbe018 name="input.a.page1.stbe018"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbe018
            #add-point:ON CHANGE stbe018 name="input.g.page1.stbe018"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe033
            #add-point:BEFORE FIELD stbe033 name="input.b.page1.stbe033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe033
            
            #add-point:AFTER FIELD stbe033 name="input.a.page1.stbe033"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbe033
            #add-point:ON CHANGE stbe033 name="input.g.page1.stbe033"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe031
            #add-point:BEFORE FIELD stbe031 name="input.b.page1.stbe031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe031
            
            #add-point:AFTER FIELD stbe031 name="input.a.page1.stbe031"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbe031
            #add-point:ON CHANGE stbe031 name="input.g.page1.stbe031"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe034
            #add-point:BEFORE FIELD stbe034 name="input.b.page1.stbe034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe034
            
            #add-point:AFTER FIELD stbe034 name="input.a.page1.stbe034"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbe034
            #add-point:ON CHANGE stbe034 name="input.g.page1.stbe034"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbesite
            
            #add-point:AFTER FIELD stbesite name="input.a.page1.stbesite"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stbe_d[l_ac].stbesite
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND oefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_stbe_d[l_ac].stbesite_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stbe_d[l_ac].stbesite_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbesite
            #add-point:BEFORE FIELD stbesite name="input.b.page1.stbesite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbesite
            #add-point:ON CHANGE stbesite name="input.g.page1.stbesite"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe020
            
            #add-point:AFTER FIELD stbe020 name="input.a.page1.stbe020"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stbe_d[l_ac].stbe020
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_stbe_d[l_ac].stbe020_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stbe_d[l_ac].stbe020_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe020
            #add-point:BEFORE FIELD stbe020 name="input.b.page1.stbe020"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbe020
            #add-point:ON CHANGE stbe020 name="input.g.page1.stbe020"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe019
            
            #add-point:AFTER FIELD stbe019 name="input.a.page1.stbe019"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stbe_d[l_ac].stbe019
            CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_stbe_d[l_ac].stbe019_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stbe_d[l_ac].stbe019_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe019
            #add-point:BEFORE FIELD stbe019 name="input.b.page1.stbe019"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbe019
            #add-point:ON CHANGE stbe019 name="input.g.page1.stbe019"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe032
            #add-point:BEFORE FIELD stbe032 name="input.b.page1.stbe032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe032
            
            #add-point:AFTER FIELD stbe032 name="input.a.page1.stbe032"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbe032
            #add-point:ON CHANGE stbe032 name="input.g.page1.stbe032"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbecomp
            #add-point:BEFORE FIELD stbecomp name="input.b.page1.stbecomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbecomp
            
            #add-point:AFTER FIELD stbecomp name="input.a.page1.stbecomp"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbecomp
            #add-point:ON CHANGE stbecomp name="input.g.page1.stbecomp"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe021
            #add-point:BEFORE FIELD stbe021 name="input.b.page1.stbe021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe021
            
            #add-point:AFTER FIELD stbe021 name="input.a.page1.stbe021"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbe021
            #add-point:ON CHANGE stbe021 name="input.g.page1.stbe021"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe022
            #add-point:BEFORE FIELD stbe022 name="input.b.page1.stbe022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe022
            
            #add-point:AFTER FIELD stbe022 name="input.a.page1.stbe022"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbe022
            #add-point:ON CHANGE stbe022 name="input.g.page1.stbe022"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe023
            #add-point:BEFORE FIELD stbe023 name="input.b.page1.stbe023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe023
            
            #add-point:AFTER FIELD stbe023 name="input.a.page1.stbe023"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbe023
            #add-point:ON CHANGE stbe023 name="input.g.page1.stbe023"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.stbeseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbeseq
            #add-point:ON ACTION controlp INFIELD stbeseq name="input.c.page1.stbeseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stbe001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe001
            #add-point:ON ACTION controlp INFIELD stbe001 name="input.c.page1.stbe001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stbe002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe002
            #add-point:ON ACTION controlp INFIELD stbe002 name="input.c.page1.stbe002"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_stbe_d[l_ac].stbe002   
            LET g_qryparam.arg1 = g_stbd_m.stbd037
 
            IF cl_null(g_stbe_d[l_ac].stbe001) THEN
               LET g_qryparam.where = " stbc003 IN ('4','5') "
            ELSE
               LET g_qryparam.where = " stbc003 = '",g_stbe_d[l_ac].stbe001,"' "
            END IF
            
            CALL q_stbc004_3()     
            
            LET g_stbe_d[l_ac].stbe002 = g_qryparam.return1  
            DISPLAY g_stbe_d[l_ac].stbe002 TO stbe002  
            
            NEXT FIELD stbe002  
            #END add-point
 
 
         #Ctrlp:input.c.page1.stbe003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe003
            #add-point:ON ACTION controlp INFIELD stbe003 name="input.c.page1.stbe003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stbe004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe004
            #add-point:ON ACTION controlp INFIELD stbe004 name="input.c.page1.stbe004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stbe028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe028
            #add-point:ON ACTION controlp INFIELD stbe028 name="input.c.page1.stbe028"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stbe005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe005
            #add-point:ON ACTION controlp INFIELD stbe005 name="input.c.page1.stbe005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stbe024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe024
            #add-point:ON ACTION controlp INFIELD stbe024 name="input.c.page1.stbe024"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stbe025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe025
            #add-point:ON ACTION controlp INFIELD stbe025 name="input.c.page1.stbe025"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_stae003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_stae003
            #add-point:ON ACTION controlp INFIELD l_stae003 name="input.c.page1.l_stae003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stbe006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe006
            #add-point:ON ACTION controlp INFIELD stbe006 name="input.c.page1.stbe006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stbe007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe007
            #add-point:ON ACTION controlp INFIELD stbe007 name="input.c.page1.stbe007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stbe008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe008
            #add-point:ON ACTION controlp INFIELD stbe008 name="input.c.page1.stbe008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stbe009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe009
            #add-point:ON ACTION controlp INFIELD stbe009 name="input.c.page1.stbe009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stbe010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe010
            #add-point:ON ACTION controlp INFIELD stbe010 name="input.c.page1.stbe010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stbe011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe011
            #add-point:ON ACTION controlp INFIELD stbe011 name="input.c.page1.stbe011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stbe012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe012
            #add-point:ON ACTION controlp INFIELD stbe012 name="input.c.page1.stbe012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stbe013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe013
            #add-point:ON ACTION controlp INFIELD stbe013 name="input.c.page1.stbe013"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stbe014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe014
            #add-point:ON ACTION controlp INFIELD stbe014 name="input.c.page1.stbe014"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stbe015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe015
            #add-point:ON ACTION controlp INFIELD stbe015 name="input.c.page1.stbe015"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stbe016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe016
            #add-point:ON ACTION controlp INFIELD stbe016 name="input.c.page1.stbe016"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stbe026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe026
            #add-point:ON ACTION controlp INFIELD stbe026 name="input.c.page1.stbe026"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stbe027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe027
            #add-point:ON ACTION controlp INFIELD stbe027 name="input.c.page1.stbe027"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stbe017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe017
            #add-point:ON ACTION controlp INFIELD stbe017 name="input.c.page1.stbe017"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stbe018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe018
            #add-point:ON ACTION controlp INFIELD stbe018 name="input.c.page1.stbe018"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stbe033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe033
            #add-point:ON ACTION controlp INFIELD stbe033 name="input.c.page1.stbe033"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stbe031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe031
            #add-point:ON ACTION controlp INFIELD stbe031 name="input.c.page1.stbe031"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stbe034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe034
            #add-point:ON ACTION controlp INFIELD stbe034 name="input.c.page1.stbe034"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stbesite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbesite
            #add-point:ON ACTION controlp INFIELD stbesite name="input.c.page1.stbesite"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stbe020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe020
            #add-point:ON ACTION controlp INFIELD stbe020 name="input.c.page1.stbe020"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stbe019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe019
            #add-point:ON ACTION controlp INFIELD stbe019 name="input.c.page1.stbe019"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stbe032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe032
            #add-point:ON ACTION controlp INFIELD stbe032 name="input.c.page1.stbe032"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stbecomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbecomp
            #add-point:ON ACTION controlp INFIELD stbecomp name="input.c.page1.stbecomp"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stbe021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe021
            #add-point:ON ACTION controlp INFIELD stbe021 name="input.c.page1.stbe021"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stbe022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe022
            #add-point:ON ACTION controlp INFIELD stbe022 name="input.c.page1.stbe022"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stbe023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe023
            #add-point:ON ACTION controlp INFIELD stbe023 name="input.c.page1.stbe023"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_stbe_d[l_ac].* = g_stbe_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE astt840_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_stbe_d[l_ac].stbeseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_stbe_d[l_ac].* = g_stbe_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL astt840_stbe_t_mask_restore('restore_mask_o')
      
               UPDATE stbe_t SET (stbedocno,stbeseq,stbe001,stbe002,stbe003,stbe004,stbe028,stbe005, 
                   stbe035,stbe036,stbe024,stbe025,stbe006,stbe007,stbe008,stbe009,stbe010,stbe011,stbe012, 
                   stbe013,stbe014,stbe015,stbe016,stbe026,stbe027,stbe017,stbe018,stbe033,stbe031,stbe034, 
                   stbesite,stbe020,stbe019,stbe032,stbecomp,stbe021,stbe022,stbe023) = (g_stbd_m.stbddocno, 
                   g_stbe_d[l_ac].stbeseq,g_stbe_d[l_ac].stbe001,g_stbe_d[l_ac].stbe002,g_stbe_d[l_ac].stbe003, 
                   g_stbe_d[l_ac].stbe004,g_stbe_d[l_ac].stbe028,g_stbe_d[l_ac].stbe005,g_stbe_d[l_ac].stbe035, 
                   g_stbe_d[l_ac].stbe036,g_stbe_d[l_ac].stbe024,g_stbe_d[l_ac].stbe025,g_stbe_d[l_ac].stbe006, 
                   g_stbe_d[l_ac].stbe007,g_stbe_d[l_ac].stbe008,g_stbe_d[l_ac].stbe009,g_stbe_d[l_ac].stbe010, 
                   g_stbe_d[l_ac].stbe011,g_stbe_d[l_ac].stbe012,g_stbe_d[l_ac].stbe013,g_stbe_d[l_ac].stbe014, 
                   g_stbe_d[l_ac].stbe015,g_stbe_d[l_ac].stbe016,g_stbe_d[l_ac].stbe026,g_stbe_d[l_ac].stbe027, 
                   g_stbe_d[l_ac].stbe017,g_stbe_d[l_ac].stbe018,g_stbe_d[l_ac].stbe033,g_stbe_d[l_ac].stbe031, 
                   g_stbe_d[l_ac].stbe034,g_stbe_d[l_ac].stbesite,g_stbe_d[l_ac].stbe020,g_stbe_d[l_ac].stbe019, 
                   g_stbe_d[l_ac].stbe032,g_stbe_d[l_ac].stbecomp,g_stbe_d[l_ac].stbe021,g_stbe_d[l_ac].stbe022, 
                   g_stbe_d[l_ac].stbe023)
                WHERE stbeent = g_enterprise AND stbedocno = g_stbd_m.stbddocno 
 
                  AND stbeseq = g_stbe_d_t.stbeseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_stbe_d[l_ac].* = g_stbe_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "stbe_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_stbe_d[l_ac].* = g_stbe_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "stbe_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_stbd_m.stbddocno
               LET gs_keys_bak[1] = g_stbddocno_t
               LET gs_keys[2] = g_stbe_d[g_detail_idx].stbeseq
               LET gs_keys_bak[2] = g_stbe_d_t.stbeseq
               CALL astt840_update_b('stbe_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL astt840_stbe_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_stbe_d[g_detail_idx].stbeseq = g_stbe_d_t.stbeseq 
 
                  ) THEN
                  LET gs_keys[01] = g_stbd_m.stbddocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_stbe_d_t.stbeseq
 
                  CALL astt840_key_update_b(gs_keys,'stbe_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_stbd_m),util.JSON.stringify(g_stbe_d_t)
               LET g_log2 = util.JSON.stringify(g_stbd_m),util.JSON.stringify(g_stbe_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL astt840_unlock_b("stbe_t","'1'")
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            #add-point:單身after_row2 name="input.body.after_row2"
            CALL astt840_detail3_fill()
            #end add-point
              
         AFTER INPUT
            #add-point:input段after input  name="input.body.after_input"
            CALL s_transaction_begin()
            IF s_astp840_stbe_summary(g_stbd_m.stbddocno) THEN
               CALL s_transaction_end('Y',0)
               SELECT  stbd008,stbd009,stbd010,stbd011,stbd012,stbd013,stbd014,stbd015,stbd016,stbd017,stbd018,stbd019,
                        stbd040,stbd045,stbd051,stbd052,stbd053,stbd054,stbd055,stbd056,stbd057,stbd058,stbd059
                INTO g_stbd_m.stbd008,g_stbd_m.stbd009,g_stbd_m.stbd010,g_stbd_m.stbd011,g_stbd_m.stbd012,g_stbd_m.stbd013,g_stbd_m.stbd014,g_stbd_m.stbd015,g_stbd_m.stbd016,g_stbd_m.stbd017,g_stbd_m.stbd018,g_stbd_m.stbd019,
                     g_stbd_m.stbd040,g_stbd_m.stbd045,g_stbd_m.stbd051,g_stbd_m.stbd052,g_stbd_m.stbd053,g_stbd_m.stbd054,g_stbd_m.stbd055,g_stbd_m.stbd056,g_stbd_m.stbd057,g_stbd_m.stbd058,g_stbd_m.stbd059
                FROM stbd_t 
                WHERE stbdent=g_enterprise   AND  stbddocno=g_stbd_m.stbddocno 
                DISPLAY BY NAME g_stbd_m.stbd008,g_stbd_m.stbd009,g_stbd_m.stbd010,g_stbd_m.stbd011,g_stbd_m.stbd012,
                                g_stbd_m.stbd013,g_stbd_m.stbd014,g_stbd_m.stbd015,g_stbd_m.stbd016,g_stbd_m.stbd017,
                                g_stbd_m.stbd018,g_stbd_m.stbd019,g_stbd_m.stbd040,g_stbd_m.stbd045,g_stbd_m.stbd051,
                                g_stbd_m.stbd052,g_stbd_m.stbd053,g_stbd_m.stbd054,g_stbd_m.stbd055,g_stbd_m.stbd056,
                                g_stbd_m.stbd057,g_stbd_m.stbd058,g_stbd_m.stbd059
            ELSE   
               CALL s_transaction_end('N',0)
            END IF
#            IF g_current_idx > 0 THEN
#               CALL astt840_ui_headershow()
#            END IF
            CALL astt840_detail3_fill()
            #end add-point 
    
         ON ACTION controlo    
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_stbe_d[li_reproduce_target].* = g_stbe_d[li_reproduce].*
 
               LET g_stbe_d[li_reproduce_target].stbeseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_stbe_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_stbe_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
      INPUT ARRAY g_stbe2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_2)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body2.before_input2"
            ##单身没资料关闭单身
            #IF g_stbe2_d.getLength()=0 THEN
            #   EXIT DIALOG
            #END IF 
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_stbe2_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL astt840_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_stbe2_d.getLength()
            #add-point:資料輸入前 name="input.body2.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_stbe2_d[l_ac].* TO NULL 
            INITIALIZE g_stbe2_d_t.* TO NULL 
            INITIALIZE g_stbe2_d_o.* TO NULL 
            #公用欄位給值(單身2)
            
            #自定義預設值(單身2)
                  LET g_stbe2_d[l_ac].stbf006 = "0"
      LET g_stbe2_d[l_ac].stbf007 = "0"
      LET g_stbe2_d[l_ac].stbf008 = "0"
 
            #add-point:modify段before備份 name="input.body2.insert.before_bak"
            #項次
            SELECT MAX(stbfseq) INTO l_seq
              FROM stbf_t
             WHERE stbfent = g_enterprise
               AND stbfdocno = g_stbd_m.stbddocno
           
            IF cl_null(l_seq) THEN
               LET l_seq = 1
            ELSE
               LET l_seq = l_seq + 1
            END IF              
            
            LET g_stbe2_d[l_ac].stbfseq = l_seq
            #end add-point
            LET g_stbe2_d_t.* = g_stbe2_d[l_ac].*     #新輸入資料
            LET g_stbe2_d_o.* = g_stbe2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL astt840_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body2.insert.after_set_entry_b"
            
            #end add-point
            CALL astt840_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_stbe2_d[li_reproduce_target].* = g_stbe2_d[li_reproduce].*
 
               LET g_stbe2_d[li_reproduce_target].stbfseq = NULL
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
            OPEN astt840_cl USING g_enterprise,g_stbd_m.stbddocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN astt840_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE astt840_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_stbe2_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_stbe2_d[l_ac].stbfseq IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_stbe2_d_t.* = g_stbe2_d[l_ac].*  #BACKUP
               LET g_stbe2_d_o.* = g_stbe2_d[l_ac].*  #BACKUP
               CALL astt840_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body2.after_set_entry_b"
               
               #end add-point  
               CALL astt840_set_no_entry_b(l_cmd)
               IF NOT astt840_lock_b("stbf_t","'2'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH astt840_bcl2 INTO g_stbe2_d[l_ac].stbfseq,g_stbe2_d[l_ac].stbf001,g_stbe2_d[l_ac].stbf002, 
                      g_stbe2_d[l_ac].stbf003,g_stbe2_d[l_ac].stbf004,g_stbe2_d[l_ac].stbf005,g_stbe2_d[l_ac].stbf009, 
                      g_stbe2_d[l_ac].stbf010,g_stbe2_d[l_ac].stbf006,g_stbe2_d[l_ac].stbf007,g_stbe2_d[l_ac].stbf008, 
                      g_stbe2_d[l_ac].stbf011,g_stbe2_d[l_ac].stbf012,g_stbe2_d[l_ac].stbfcomp,g_stbe2_d[l_ac].stbfsite, 
                      g_stbe2_d[l_ac].stbf013,g_stbe2_d[l_ac].stbf014,g_stbe2_d[l_ac].stbf015,g_stbe2_d[l_ac].stbf016 
 
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_stbe2_d_mask_o[l_ac].* =  g_stbe2_d[l_ac].*
                  CALL astt840_stbf_t_mask()
                  LET g_stbe2_d_mask_n[l_ac].* =  g_stbe2_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL astt840_show()
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
               LET gs_keys[01] = g_stbd_m.stbddocno
               LET gs_keys[gs_keys.getLength()+1] = g_stbe2_d_t.stbfseq
            
               #刪除同層單身
               IF NOT astt840_delete_b('stbf_t',gs_keys,"'2'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE astt840_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT astt840_key_delete_b(gs_keys,'stbf_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE astt840_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身2刪除中 name="input.body2.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE astt840_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身2刪除後 name="input.body2.a_delete"
               
               #end add-point
               LET l_count = g_stbe_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body2.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_stbe2_d.getLength() + 1) THEN
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
            SELECT COUNT(1) INTO l_count FROM stbf_t 
             WHERE stbfent = g_enterprise AND stbfdocno = g_stbd_m.stbddocno
               AND stbfseq = g_stbe2_d[l_ac].stbfseq
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前 name="input.body2.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_stbd_m.stbddocno
               LET gs_keys[2] = g_stbe2_d[g_detail_idx].stbfseq
               CALL astt840_insert_b('stbf_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2 name="input.body2.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_stbe_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "stbf_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL astt840_b_fill()
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
               LET g_stbe2_d[l_ac].* = g_stbe2_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE astt840_bcl2
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
               LET g_stbe2_d[l_ac].* = g_stbe2_d_t.*
            ELSE
               #add-point:單身page2修改前 name="input.body2.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身2)
               
               
               #將遮罩欄位還原
               CALL astt840_stbf_t_mask_restore('restore_mask_o')
                              
               UPDATE stbf_t SET (stbfdocno,stbfseq,stbf001,stbf002,stbf003,stbf004,stbf005,stbf009, 
                   stbf010,stbf006,stbf007,stbf008,stbf011,stbf012,stbfcomp,stbfsite,stbf013,stbf014, 
                   stbf015,stbf016) = (g_stbd_m.stbddocno,g_stbe2_d[l_ac].stbfseq,g_stbe2_d[l_ac].stbf001, 
                   g_stbe2_d[l_ac].stbf002,g_stbe2_d[l_ac].stbf003,g_stbe2_d[l_ac].stbf004,g_stbe2_d[l_ac].stbf005, 
                   g_stbe2_d[l_ac].stbf009,g_stbe2_d[l_ac].stbf010,g_stbe2_d[l_ac].stbf006,g_stbe2_d[l_ac].stbf007, 
                   g_stbe2_d[l_ac].stbf008,g_stbe2_d[l_ac].stbf011,g_stbe2_d[l_ac].stbf012,g_stbe2_d[l_ac].stbfcomp, 
                   g_stbe2_d[l_ac].stbfsite,g_stbe2_d[l_ac].stbf013,g_stbe2_d[l_ac].stbf014,g_stbe2_d[l_ac].stbf015, 
                   g_stbe2_d[l_ac].stbf016) #自訂欄位頁簽
                WHERE stbfent = g_enterprise AND stbfdocno = g_stbd_m.stbddocno
                  AND stbfseq = g_stbe2_d_t.stbfseq #項次 
                  
               #add-point:單身page2修改中 name="input.body2.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_stbe2_d[l_ac].* = g_stbe2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "stbf_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_stbe2_d[l_ac].* = g_stbe2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "stbf_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_stbd_m.stbddocno
               LET gs_keys_bak[1] = g_stbddocno_t
               LET gs_keys[2] = g_stbe2_d[g_detail_idx].stbfseq
               LET gs_keys_bak[2] = g_stbe2_d_t.stbfseq
               CALL astt840_update_b('stbf_t',gs_keys,gs_keys_bak,"'2'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL astt840_stbf_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_stbe2_d[g_detail_idx].stbfseq = g_stbe2_d_t.stbfseq 
                  ) THEN
                  LET gs_keys[01] = g_stbd_m.stbddocno
                  LET gs_keys[gs_keys.getLength()+1] = g_stbe2_d_t.stbfseq
                  CALL astt840_key_update_b(gs_keys,'stbf_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_stbd_m),util.JSON.stringify(g_stbe2_d_t)
               LET g_log2 = util.JSON.stringify(g_stbd_m),util.JSON.stringify(g_stbe2_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page2修改後 name="input.body2.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbfseq
            #add-point:BEFORE FIELD stbfseq name="input.b.page2.stbfseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbfseq
            
            #add-point:AFTER FIELD stbfseq name="input.a.page2.stbfseq"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  g_stbd_m.stbddocno IS NOT NULL AND g_stbe2_d[g_detail_idx].stbfseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_stbd_m.stbddocno != g_stbddocno_t OR g_stbe2_d[g_detail_idx].stbfseq != g_stbe2_d_t.stbfseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(1) FROM stbf_t WHERE "||"stbfent = '" ||g_enterprise|| "' AND "||"stbfdocno = '"||g_stbd_m.stbddocno ||"' AND "|| "stbfseq = '"||g_stbe2_d[g_detail_idx].stbfseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbfseq
            #add-point:ON CHANGE stbfseq name="input.g.page2.stbfseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbf001
            #add-point:BEFORE FIELD stbf001 name="input.b.page2.stbf001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbf001
            
            #add-point:AFTER FIELD stbf001 name="input.a.page2.stbf001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbf001
            #add-point:ON CHANGE stbf001 name="input.g.page2.stbf001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbf002
            #add-point:BEFORE FIELD stbf002 name="input.b.page2.stbf002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbf002
            
            #add-point:AFTER FIELD stbf002 name="input.a.page2.stbf002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbf002
            #add-point:ON CHANGE stbf002 name="input.g.page2.stbf002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbf003
            #add-point:BEFORE FIELD stbf003 name="input.b.page2.stbf003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbf003
            
            #add-point:AFTER FIELD stbf003 name="input.a.page2.stbf003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbf003
            #add-point:ON CHANGE stbf003 name="input.g.page2.stbf003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbf004
            
            #add-point:AFTER FIELD stbf004 name="input.a.page2.stbf004"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbf004
            #add-point:BEFORE FIELD stbf004 name="input.b.page2.stbf004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbf004
            #add-point:ON CHANGE stbf004 name="input.g.page2.stbf004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbf005
            #add-point:BEFORE FIELD stbf005 name="input.b.page2.stbf005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbf005
            
            #add-point:AFTER FIELD stbf005 name="input.a.page2.stbf005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbf005
            #add-point:ON CHANGE stbf005 name="input.g.page2.stbf005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbf009
            #add-point:BEFORE FIELD stbf009 name="input.b.page2.stbf009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbf009
            
            #add-point:AFTER FIELD stbf009 name="input.a.page2.stbf009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbf009
            #add-point:ON CHANGE stbf009 name="input.g.page2.stbf009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbf010
            #add-point:BEFORE FIELD stbf010 name="input.b.page2.stbf010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbf010
            
            #add-point:AFTER FIELD stbf010 name="input.a.page2.stbf010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbf010
            #add-point:ON CHANGE stbf010 name="input.g.page2.stbf010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbf006
            #add-point:BEFORE FIELD stbf006 name="input.b.page2.stbf006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbf006
            
            #add-point:AFTER FIELD stbf006 name="input.a.page2.stbf006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbf006
            #add-point:ON CHANGE stbf006 name="input.g.page2.stbf006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbf007
            #add-point:BEFORE FIELD stbf007 name="input.b.page2.stbf007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbf007
            
            #add-point:AFTER FIELD stbf007 name="input.a.page2.stbf007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbf007
            #add-point:ON CHANGE stbf007 name="input.g.page2.stbf007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbf008
            #add-point:BEFORE FIELD stbf008 name="input.b.page2.stbf008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbf008
            
            #add-point:AFTER FIELD stbf008 name="input.a.page2.stbf008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbf008
            #add-point:ON CHANGE stbf008 name="input.g.page2.stbf008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbf011
            #add-point:BEFORE FIELD stbf011 name="input.b.page2.stbf011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbf011
            
            #add-point:AFTER FIELD stbf011 name="input.a.page2.stbf011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbf011
            #add-point:ON CHANGE stbf011 name="input.g.page2.stbf011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbf012
            #add-point:BEFORE FIELD stbf012 name="input.b.page2.stbf012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbf012
            
            #add-point:AFTER FIELD stbf012 name="input.a.page2.stbf012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbf012
            #add-point:ON CHANGE stbf012 name="input.g.page2.stbf012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbfcomp
            #add-point:BEFORE FIELD stbfcomp name="input.b.page2.stbfcomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbfcomp
            
            #add-point:AFTER FIELD stbfcomp name="input.a.page2.stbfcomp"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbfcomp
            #add-point:ON CHANGE stbfcomp name="input.g.page2.stbfcomp"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbfsite
            #add-point:BEFORE FIELD stbfsite name="input.b.page2.stbfsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbfsite
            
            #add-point:AFTER FIELD stbfsite name="input.a.page2.stbfsite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbfsite
            #add-point:ON CHANGE stbfsite name="input.g.page2.stbfsite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbf013
            #add-point:BEFORE FIELD stbf013 name="input.b.page2.stbf013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbf013
            
            #add-point:AFTER FIELD stbf013 name="input.a.page2.stbf013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbf013
            #add-point:ON CHANGE stbf013 name="input.g.page2.stbf013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbf014
            #add-point:BEFORE FIELD stbf014 name="input.b.page2.stbf014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbf014
            
            #add-point:AFTER FIELD stbf014 name="input.a.page2.stbf014"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbf014
            #add-point:ON CHANGE stbf014 name="input.g.page2.stbf014"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbf015
            
            #add-point:AFTER FIELD stbf015 name="input.a.page2.stbf015"
            #161024-00025#2--add--s
            IF NOT cl_null(g_stbe2_d[l_ac].stbf015) THEN 
                IF s_aooi500_setpoint(g_prog,'stbf015') THEN
                   CALL s_aooi500_chk(g_prog,'stbf015',g_stbe2_d[l_ac].stbf015,g_stbd_m.stbdsite) RETURNING l_success,l_errno
                   IF NOT l_success THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.extend = g_stbe2_d[l_ac].stbf015
                      LET g_errparam.code   = l_errno
                      LET g_errparam.popup  = TRUE
                      CALL cl_err()
                   
                      LET g_stbe2_d[l_ac].stbf015 = g_stbe2_d_t.stbf015
                      CALL s_desc_get_department_desc(g_stbe2_d[l_ac].stbf015) RETURNING g_stbe2_d[l_ac].stbf015_desc
                      DISPLAY BY NAME g_stbe2_d[l_ac].stbf015,g_stbe2_d[l_ac].stbf015_desc
                      NEXT FIELD CURRENT
                   END IF
                ELSE
                   SELECT DISTINCT count(*) INTO l_n FROM OOEF_T
                     LEFT OUTER JOIN OOEFL_T ON OOEF001 = OOEFL001
                                            AND OOEFL002 = g_lang
                                            AND OOEFENT = OOEFLENT
                     LEFT OUTER JOIN XRAH_T ON XRAH004 = OOEF001
                                           AND XRAH001 = '3'
                                           AND XRAH007 = 'Y'
                    WHERE OOEFENT = 99
                      AND ooef001 = g_stbe2_d[l_ac].stbf015
                      AND ooef203 = 'Y'
                      AND OOEFSTUS = 'Y'
                    ORDER BY OOEF001
                   IF l_n=0 THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = 'aoo-00092'
                      LET g_errparam.extend = ''
                      LET g_errparam.popup = TRUE
                      CALL cl_err()
                      LET g_stbe2_d[l_ac].stbf015 = g_stbe2_d_t.stbf015
                      CALL s_desc_get_department_desc(g_stbe2_d[l_ac].stbf015) RETURNING g_stbe2_d[l_ac].stbf015_desc
                      DISPLAY BY NAME g_stbe2_d[l_ac].stbf015,g_stbe2_d[l_ac].stbf015_desc
                      NEXT FIELD CURRENT
                   END IF
                END IF
            END IF 
            #161024-00025#2--add--e
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stbe2_d[l_ac].stbf015
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_stbe2_d[l_ac].stbf015_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stbe2_d[l_ac].stbf015_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbf015
            #add-point:BEFORE FIELD stbf015 name="input.b.page2.stbf015"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbf015
            #add-point:ON CHANGE stbf015 name="input.g.page2.stbf015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbf016
            #add-point:BEFORE FIELD stbf016 name="input.b.page2.stbf016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbf016
            
            #add-point:AFTER FIELD stbf016 name="input.a.page2.stbf016"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbf016
            #add-point:ON CHANGE stbf016 name="input.g.page2.stbf016"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page2.stbfseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbfseq
            #add-point:ON ACTION controlp INFIELD stbfseq name="input.c.page2.stbfseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.stbf001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbf001
            #add-point:ON ACTION controlp INFIELD stbf001 name="input.c.page2.stbf001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.stbf002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbf002
            #add-point:ON ACTION controlp INFIELD stbf002 name="input.c.page2.stbf002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.stbf003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbf003
            #add-point:ON ACTION controlp INFIELD stbf003 name="input.c.page2.stbf003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.stbf004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbf004
            #add-point:ON ACTION controlp INFIELD stbf004 name="input.c.page2.stbf004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.stbf005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbf005
            #add-point:ON ACTION controlp INFIELD stbf005 name="input.c.page2.stbf005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.stbf009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbf009
            #add-point:ON ACTION controlp INFIELD stbf009 name="input.c.page2.stbf009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.stbf010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbf010
            #add-point:ON ACTION controlp INFIELD stbf010 name="input.c.page2.stbf010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.stbf006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbf006
            #add-point:ON ACTION controlp INFIELD stbf006 name="input.c.page2.stbf006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.stbf007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbf007
            #add-point:ON ACTION controlp INFIELD stbf007 name="input.c.page2.stbf007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.stbf008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbf008
            #add-point:ON ACTION controlp INFIELD stbf008 name="input.c.page2.stbf008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.stbf011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbf011
            #add-point:ON ACTION controlp INFIELD stbf011 name="input.c.page2.stbf011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.stbf012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbf012
            #add-point:ON ACTION controlp INFIELD stbf012 name="input.c.page2.stbf012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.stbfcomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbfcomp
            #add-point:ON ACTION controlp INFIELD stbfcomp name="input.c.page2.stbfcomp"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.stbfsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbfsite
            #add-point:ON ACTION controlp INFIELD stbfsite name="input.c.page2.stbfsite"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.stbf013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbf013
            #add-point:ON ACTION controlp INFIELD stbf013 name="input.c.page2.stbf013"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.stbf014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbf014
            #add-point:ON ACTION controlp INFIELD stbf014 name="input.c.page2.stbf014"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.stbf015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbf015
            #add-point:ON ACTION controlp INFIELD stbf015 name="input.c.page2.stbf015"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_stbe2_d[l_ac].stbf015             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

            #161024-00025#2--add--s
            IF s_aooi500_setpoint(g_prog,'stbf015') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'stbf015',g_stbd_m.stbdsite,'i')
               CALL q_ooef001_24()
            ELSE
               LET g_qryparam.where = " ooef203 = 'Y' " 
               CALL q_ooef001_24()
            END IF
            #161024-00025#2--add--e
            #CALL q_ooef001_01()                                #呼叫開窗  #161024-00025#2 mark
 
            LET g_stbe2_d[l_ac].stbf015 = g_qryparam.return1              

            DISPLAY g_stbe2_d[l_ac].stbf015 TO stbf015              #

            NEXT FIELD stbf015                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page2.stbf016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbf016
            #add-point:ON ACTION controlp INFIELD stbf016 name="input.c.page2.stbf016"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page2 after_row name="input.body2.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_stbe2_d[l_ac].* = g_stbe2_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE astt840_bcl2
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL astt840_unlock_b("stbf_t","'2'")
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
               LET g_stbe2_d[li_reproduce_target].* = g_stbe2_d[li_reproduce].*
 
               LET g_stbe2_d[li_reproduce_target].stbfseq = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_stbe2_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_stbe2_d.getLength()+1
            END IF
            
      END INPUT
      INPUT ARRAY g_stbe4_d FROM s_detail4.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = FALSE, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = FALSE)
                 
         #自訂ACTION(detail_input,page_3)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body4.before_input2"
            #160513-00037#27 20160603 add by beckxie---S
            ##单身没资料关闭单身
            #IF g_stbe4_d.getLength()=0 THEN
            #   EXIT DIALOG
            #END IF 
            #160513-00037#27 20160603 add by beckxie---E
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_stbe4_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL astt840_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'3',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_stbe4_d.getLength()
            #add-point:資料輸入前 name="input.body4.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_stbe4_d[l_ac].* TO NULL 
            INITIALIZE g_stbe4_d_t.* TO NULL 
            INITIALIZE g_stbe4_d_o.* TO NULL 
            #公用欄位給值(單身3)
            
            #自定義預設值(單身3)
            
            #add-point:modify段before備份 name="input.body4.insert.before_bak"
            LET g_stbe4_d[l_ac].stbeseq = astt840_stbeseq_def()   DISPLAY g_stbe4_d[l_ac].stbeseq TO stbcseq_1
            LET g_stbe4_d[l_ac].stbe001 = '3'                     DISPLAY g_stbe4_d[l_ac].stbe001 TO stbe001_1
            LET g_stbe4_d[l_ac].stbe012 = "0"                     DISPLAY g_stbe4_d[l_ac].stbe012 TO stbe012_1
            LET g_stbe4_d[l_ac].stbe013 = "0"                     DISPLAY g_stbe4_d[l_ac].stbe013 TO stbe013_1
            LET g_stbe4_d[l_ac].stbe014 = "0"                     DISPLAY g_stbe4_d[l_ac].stbe014 TO stbe014_1
            LET g_stbe4_d[l_ac].stbe015 = "0"                     DISPLAY g_stbe4_d[l_ac].stbe015 TO stbe015_1
            LET g_stbe4_d[l_ac].stbe016 = "0"                     DISPLAY g_stbe4_d[l_ac].stbe016 TO stbe016_1
            LET g_stbe4_d[l_ac].stbe026 = "0"                     DISPLAY g_stbe4_d[l_ac].stbe026 TO stbe026_1
            LET g_stbe4_d[l_ac].stbe027 = "0"                     DISPLAY g_stbe4_d[l_ac].stbe027 TO stbe027_1
            LET g_stbe4_d[l_ac].stbe031 = "0"                     DISPLAY g_stbe4_d[l_ac].stbe031 TO stbe031_1
            LET g_stbe4_d[l_ac].stbe034 = "0"                     DISPLAY g_stbe4_d[l_ac].stbe034 TO stbe034_1
            LET g_stbe4_d[l_ac].stbe021 = "0"                     DISPLAY g_stbe4_d[l_ac].stbe021 TO stbe021_1
            LET g_stbe4_d[l_ac].stbe022 = "0"                     DISPLAY g_stbe4_d[l_ac].stbe022 TO stbe022_1
            LET g_stbe4_d[l_ac].stbe023 = "0"                     DISPLAY g_stbe4_d[l_ac].stbe023 TO stbe023_1
            #end add-point
            LET g_stbe4_d_t.* = g_stbe4_d[l_ac].*     #新輸入資料
            LET g_stbe4_d_o.* = g_stbe4_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL astt840_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body4.insert.after_set_entry_b"
            
            #end add-point
            CALL astt840_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_stbe4_d[li_reproduce_target].* = g_stbe4_d[li_reproduce].*
 
               LET g_stbe4_d[li_reproduce_target].stbeseq = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body4.before_insert"
            
            #end add-point  
 
         BEFORE ROW     
            #add-point:modify段before row2 name="input.body4.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET g_detail_idx_list[3] = l_ac
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_current_page = 3
              
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN astt840_cl USING g_enterprise,g_stbd_m.stbddocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN astt840_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE astt840_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_stbe4_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_stbe4_d[l_ac].stbeseq IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_stbe4_d_t.* = g_stbe4_d[l_ac].*  #BACKUP
               LET g_stbe4_d_o.* = g_stbe4_d[l_ac].*  #BACKUP
               CALL astt840_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body4.after_set_entry_b"
               
               #end add-point  
               CALL astt840_set_no_entry_b(l_cmd)
               IF NOT astt840_lock_b("stbe_t","'3'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH astt840_bcl3 INTO g_stbe4_d[l_ac].stbeseq,g_stbe4_d[l_ac].stbe001,g_stbe4_d[l_ac].stbe002, 
                      g_stbe4_d[l_ac].stbe003,g_stbe4_d[l_ac].stbe004,g_stbe4_d[l_ac].stbe028,g_stbe4_d[l_ac].stbe005, 
                      g_stbe4_d[l_ac].stbe035,g_stbe4_d[l_ac].stbe036,g_stbe4_d[l_ac].stbe024,g_stbe4_d[l_ac].stbe025, 
                      g_stbe4_d[l_ac].stbe006,g_stbe4_d[l_ac].stbe007,g_stbe4_d[l_ac].stbe008,g_stbe4_d[l_ac].stbe009, 
                      g_stbe4_d[l_ac].stbe010,g_stbe4_d[l_ac].stbe011,g_stbe4_d[l_ac].stbe012,g_stbe4_d[l_ac].stbe013, 
                      g_stbe4_d[l_ac].stbe014,g_stbe4_d[l_ac].stbe015,g_stbe4_d[l_ac].stbe016,g_stbe4_d[l_ac].stbe026, 
                      g_stbe4_d[l_ac].stbe027,g_stbe4_d[l_ac].stbe017,g_stbe4_d[l_ac].stbe018,g_stbe4_d[l_ac].stbe033, 
                      g_stbe4_d[l_ac].stbe031,g_stbe4_d[l_ac].stbe034,g_stbe4_d[l_ac].stbesite,g_stbe4_d[l_ac].stbe020, 
                      g_stbe4_d[l_ac].stbe019,g_stbe4_d[l_ac].stbe032,g_stbe4_d[l_ac].stbecomp,g_stbe4_d[l_ac].stbe021, 
                      g_stbe4_d[l_ac].stbe022,g_stbe4_d[l_ac].stbe023
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_stbe4_d_mask_o[l_ac].* =  g_stbe4_d[l_ac].*
                  CALL astt840_stbe_t_mask()
                  LET g_stbe4_d_mask_n[l_ac].* =  g_stbe4_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL astt840_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body4.before_row"
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
            #其他table進行lock
            
 
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身AFTER DELETE (=d) name="input.body4.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body4.b_delete_ask"
               
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
               
               #add-point:單身3刪除前 name="input.body4.b_delete"
               
               #end add-point    
                  
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_stbd_m.stbddocno
               LET gs_keys[gs_keys.getLength()+1] = g_stbe4_d_t.stbeseq
            
               #刪除同層單身
               IF NOT astt840_delete_b('stbe_t',gs_keys,"'3'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE astt840_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT astt840_key_delete_b(gs_keys,'stbe_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE astt840_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身3刪除中 name="input.body4.m_delete"
               #IF NOT s_astt840_upd_stbc(1,   #160604-00009#15 20160607 mark by beckxie
               IF NOT s_astt840_upd_stbc(2,   #160604-00009#15 20160607 add by beckxie
                                         g_stbd_m.stbddocno,g_stbd_m.stbdunit,
                                         g_stbe4_d[l_ac].stbe002,g_stbe4_d[l_ac].stbe003) THEN
                  CALL s_transaction_end('N','0')
               END IF
               IF NOT s_astp840_stbe_summary(g_stbd_m.stbddocno) THEN
                  CALL s_transaction_end('N',0)
               else
                  SELECT  stbd008,stbd009,stbd010,stbd011,stbd012,stbd013,stbd014,stbd015,stbd016,stbd017,stbd018,stbd019,
                        stbd040,stbd045,stbd051,stbd052,stbd053,stbd054,stbd055,stbd056,stbd057,stbd058,stbd059
                INTO g_stbd_m.stbd008,g_stbd_m.stbd009,g_stbd_m.stbd010,g_stbd_m.stbd011,g_stbd_m.stbd012,g_stbd_m.stbd013,g_stbd_m.stbd014,g_stbd_m.stbd015,g_stbd_m.stbd016,g_stbd_m.stbd017,g_stbd_m.stbd018,g_stbd_m.stbd019,
                     g_stbd_m.stbd040,g_stbd_m.stbd045,g_stbd_m.stbd051,g_stbd_m.stbd052,g_stbd_m.stbd053,g_stbd_m.stbd054,g_stbd_m.stbd055,g_stbd_m.stbd056,g_stbd_m.stbd057,g_stbd_m.stbd058,g_stbd_m.stbd059
                FROM stbd_t 
                WHERE stbdent=g_enterprise   AND  stbddocno=g_stbd_m.stbddocno 
                DISPLAY BY NAME g_stbd_m.stbd008,g_stbd_m.stbd009,g_stbd_m.stbd010,g_stbd_m.stbd011,g_stbd_m.stbd012,
                                g_stbd_m.stbd013,g_stbd_m.stbd014,g_stbd_m.stbd015,g_stbd_m.stbd016,g_stbd_m.stbd017,
                                g_stbd_m.stbd018,g_stbd_m.stbd019,g_stbd_m.stbd040,g_stbd_m.stbd045,g_stbd_m.stbd051,
                                g_stbd_m.stbd052,g_stbd_m.stbd053,g_stbd_m.stbd054,g_stbd_m.stbd055,g_stbd_m.stbd056,
                                g_stbd_m.stbd057,g_stbd_m.stbd058,g_stbd_m.stbd059
               END IF
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE astt840_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身3刪除後 name="input.body4.a_delete"
               
               #end add-point
               LET l_count = g_stbe_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body4.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_stbe4_d.getLength() + 1) THEN
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
               
            #add-point:單身3新增前 name="input.body4.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM stbe_t 
             WHERE stbeent = g_enterprise AND stbedocno = g_stbd_m.stbddocno
               AND stbeseq = g_stbe4_d[l_ac].stbeseq
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身3新增前 name="input.body4.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_stbd_m.stbddocno
               LET gs_keys[2] = g_stbe4_d[g_detail_idx].stbeseq
               CALL astt840_insert_b('stbe_t',gs_keys,"'3'")
                           
               #add-point:單身新增後3 name="input.body4.a_insert"
               IF NOT s_astt840_upd_stbc(1,
                                         g_stbd_m.stbddocno,g_stbd_m.stbdunit,
                                         g_stbe4_d[l_ac].stbe002,g_stbe4_d[l_ac].stbe003) THEN
                  CALL s_transaction_end('N','0')
               END IF
               IF NOT s_astp840_stbe_summary(g_stbd_m.stbddocno) THEN
                  CALL s_transaction_end('N',0)
               else
                  SELECT  stbd008,stbd009,stbd010,stbd011,stbd012,stbd013,stbd014,stbd015,stbd016,stbd017,stbd018,stbd019,
                        stbd040,stbd045,stbd051,stbd052,stbd053,stbd054,stbd055,stbd056,stbd057,stbd058,stbd059
                INTO g_stbd_m.stbd008,g_stbd_m.stbd009,g_stbd_m.stbd010,g_stbd_m.stbd011,g_stbd_m.stbd012,g_stbd_m.stbd013,g_stbd_m.stbd014,g_stbd_m.stbd015,g_stbd_m.stbd016,g_stbd_m.stbd017,g_stbd_m.stbd018,g_stbd_m.stbd019,
                     g_stbd_m.stbd040,g_stbd_m.stbd045,g_stbd_m.stbd051,g_stbd_m.stbd052,g_stbd_m.stbd053,g_stbd_m.stbd054,g_stbd_m.stbd055,g_stbd_m.stbd056,g_stbd_m.stbd057,g_stbd_m.stbd058,g_stbd_m.stbd059
                FROM stbd_t 
                WHERE stbdent=g_enterprise   AND  stbddocno=g_stbd_m.stbddocno 
                DISPLAY BY NAME g_stbd_m.stbd008,g_stbd_m.stbd009,g_stbd_m.stbd010,g_stbd_m.stbd011,g_stbd_m.stbd012,
                                g_stbd_m.stbd013,g_stbd_m.stbd014,g_stbd_m.stbd015,g_stbd_m.stbd016,g_stbd_m.stbd017,
                                g_stbd_m.stbd018,g_stbd_m.stbd019,g_stbd_m.stbd040,g_stbd_m.stbd045,g_stbd_m.stbd051,
                                g_stbd_m.stbd052,g_stbd_m.stbd053,g_stbd_m.stbd054,g_stbd_m.stbd055,g_stbd_m.stbd056,
                                g_stbd_m.stbd057,g_stbd_m.stbd058,g_stbd_m.stbd059
               END IF
               IF g_current_idx > 0 THEN
                  CALL astt840_ui_headershow()
               END IF
               #end add-point
            ELSE    
               INITIALIZE g_stbe_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "stbe_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL astt840_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body4.after_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_stbe4_d[l_ac].* = g_stbe4_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE astt840_bcl3
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
               LET g_stbe4_d[l_ac].* = g_stbe4_d_t.*
            ELSE
               #add-point:單身page3修改前 name="input.body4.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身3)
               
               
               #將遮罩欄位還原
               CALL astt840_stbe_t_mask_restore('restore_mask_o')
                              
               UPDATE stbe_t SET (stbedocno,stbeseq,stbe001,stbe002,stbe003,stbe004,stbe028,stbe005, 
                   stbe035,stbe036,stbe024,stbe025,stbe006,stbe007,stbe008,stbe009,stbe010,stbe011,stbe012, 
                   stbe013,stbe014,stbe015,stbe016,stbe026,stbe027,stbe017,stbe018,stbe033,stbe031,stbe034, 
                   stbesite,stbe020,stbe019,stbe032,stbecomp,stbe021,stbe022,stbe023) = (g_stbd_m.stbddocno, 
                   g_stbe4_d[l_ac].stbeseq,g_stbe4_d[l_ac].stbe001,g_stbe4_d[l_ac].stbe002,g_stbe4_d[l_ac].stbe003, 
                   g_stbe4_d[l_ac].stbe004,g_stbe4_d[l_ac].stbe028,g_stbe4_d[l_ac].stbe005,g_stbe4_d[l_ac].stbe035, 
                   g_stbe4_d[l_ac].stbe036,g_stbe4_d[l_ac].stbe024,g_stbe4_d[l_ac].stbe025,g_stbe4_d[l_ac].stbe006, 
                   g_stbe4_d[l_ac].stbe007,g_stbe4_d[l_ac].stbe008,g_stbe4_d[l_ac].stbe009,g_stbe4_d[l_ac].stbe010, 
                   g_stbe4_d[l_ac].stbe011,g_stbe4_d[l_ac].stbe012,g_stbe4_d[l_ac].stbe013,g_stbe4_d[l_ac].stbe014, 
                   g_stbe4_d[l_ac].stbe015,g_stbe4_d[l_ac].stbe016,g_stbe4_d[l_ac].stbe026,g_stbe4_d[l_ac].stbe027, 
                   g_stbe4_d[l_ac].stbe017,g_stbe4_d[l_ac].stbe018,g_stbe4_d[l_ac].stbe033,g_stbe4_d[l_ac].stbe031, 
                   g_stbe4_d[l_ac].stbe034,g_stbe4_d[l_ac].stbesite,g_stbe4_d[l_ac].stbe020,g_stbe4_d[l_ac].stbe019, 
                   g_stbe4_d[l_ac].stbe032,g_stbe4_d[l_ac].stbecomp,g_stbe4_d[l_ac].stbe021,g_stbe4_d[l_ac].stbe022, 
                   g_stbe4_d[l_ac].stbe023) #自訂欄位頁簽
                WHERE stbeent = g_enterprise AND stbedocno = g_stbd_m.stbddocno
                  AND stbeseq = g_stbe4_d_t.stbeseq #項次 
                  
               #add-point:單身page3修改中 name="input.body4.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_stbe4_d[l_ac].* = g_stbe4_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "stbe_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_stbe4_d[l_ac].* = g_stbe4_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "stbe_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_stbd_m.stbddocno
               LET gs_keys_bak[1] = g_stbddocno_t
               LET gs_keys[2] = g_stbe4_d[g_detail_idx].stbeseq
               LET gs_keys_bak[2] = g_stbe4_d_t.stbeseq
               CALL astt840_update_b('stbe_t',gs_keys,gs_keys_bak,"'3'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL astt840_stbe_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_stbe4_d[g_detail_idx].stbeseq = g_stbe4_d_t.stbeseq 
                  ) THEN
                  LET gs_keys[01] = g_stbd_m.stbddocno
                  LET gs_keys[gs_keys.getLength()+1] = g_stbe4_d_t.stbeseq
                  CALL astt840_key_update_b(gs_keys,'stbe_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_stbd_m),util.JSON.stringify(g_stbe4_d_t)
               LET g_log2 = util.JSON.stringify(g_stbd_m),util.JSON.stringify(g_stbe4_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page3修改後 name="input.body4.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbeseq_1
            #add-point:BEFORE FIELD stbeseq_1 name="input.b.page4.stbeseq_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbeseq_1
            
            #add-point:AFTER FIELD stbeseq_1 name="input.a.page4.stbeseq_1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbeseq_1
            #add-point:ON CHANGE stbeseq_1 name="input.g.page4.stbeseq_1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe001_1
            #add-point:BEFORE FIELD stbe001_1 name="input.b.page4.stbe001_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe001_1
            
            #add-point:AFTER FIELD stbe001_1 name="input.a.page4.stbe001_1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbe001_1
            #add-point:ON CHANGE stbe001_1 name="input.g.page4.stbe001_1"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe002_1
            
            #add-point:AFTER FIELD stbe002_1 name="input.a.page4.stbe002_1"
            IF NOT cl_null(g_stbe4_d[l_ac].stbe002) THEN
               IF g_stbe4_d[l_ac].stbe002 != g_stbe4_d_o.stbe002 OR cl_null(g_stbe4_d_o.stbe002) THEN
                   IF NOT astt840_stbe002_chk(2,g_stbe4_d[l_ac].stbe001,g_stbe4_d[l_ac].stbe002) THEN
                      LET g_stbe4_d[l_ac].stbe002 = g_stbe4_d_o.stbe002
                      NEXT FIELD CURRENT    
                   END IF

                   IF NOT astt840_stbe_def(2)  THEN
                      LET g_stbe4_d[l_ac].stbe002 = g_stbe4_d_o.stbe002
                   END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe002_1
            #add-point:BEFORE FIELD stbe002_1 name="input.b.page4.stbe002_1"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbe002_1
            #add-point:ON CHANGE stbe002_1 name="input.g.page4.stbe002_1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe003_1
            #add-point:BEFORE FIELD stbe003_1 name="input.b.page4.stbe003_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe003_1
            
            #add-point:AFTER FIELD stbe003_1 name="input.a.page4.stbe003_1"
            IF NOT cl_null(g_stbe4_d[l_ac].stbe003) THEN
               IF g_stbe4_d[l_ac].stbe003 != g_stbe4_d_o.stbe003 OR cl_null(g_stbe4_d_o.stbe003) THEN                   
                   IF NOT astt840_stbe_def(2)  THEN
                      LET g_stbe4_d[l_ac].stbe003 = g_stbe4_d_o.stbe003
                   END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbe003_1
            #add-point:ON CHANGE stbe003_1 name="input.g.page4.stbe003_1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe004_1
            #add-point:BEFORE FIELD stbe004_1 name="input.b.page4.stbe004_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe004_1
            
            #add-point:AFTER FIELD stbe004_1 name="input.a.page4.stbe004_1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbe004_1
            #add-point:ON CHANGE stbe004_1 name="input.g.page4.stbe004_1"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe028_1
            
            #add-point:AFTER FIELD stbe028_1 name="input.a.page4.stbe028_1"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe028_1
            #add-point:BEFORE FIELD stbe028_1 name="input.b.page4.stbe028_1"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbe028_1
            #add-point:ON CHANGE stbe028_1 name="input.g.page4.stbe028_1"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe005_1
            
            #add-point:AFTER FIELD stbe005_1 name="input.a.page4.stbe005_1"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe005_1
            #add-point:BEFORE FIELD stbe005_1 name="input.b.page4.stbe005_1"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbe005_1
            #add-point:ON CHANGE stbe005_1 name="input.g.page4.stbe005_1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe024_1
            #add-point:BEFORE FIELD stbe024_1 name="input.b.page4.stbe024_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe024_1
            
            #add-point:AFTER FIELD stbe024_1 name="input.a.page4.stbe024_1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbe024_1
            #add-point:ON CHANGE stbe024_1 name="input.g.page4.stbe024_1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe025_1
            #add-point:BEFORE FIELD stbe025_1 name="input.b.page4.stbe025_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe025_1
            
            #add-point:AFTER FIELD stbe025_1 name="input.a.page4.stbe025_1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbe025_1
            #add-point:ON CHANGE stbe025_1 name="input.g.page4.stbe025_1"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_stae003_1
            
            #add-point:AFTER FIELD l_stae003_1 name="input.a.page4.l_stae003_1"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_stae003_1
            #add-point:BEFORE FIELD l_stae003_1 name="input.b.page4.l_stae003_1"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_stae003_1
            #add-point:ON CHANGE l_stae003_1 name="input.g.page4.l_stae003_1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe006_1
            #add-point:BEFORE FIELD stbe006_1 name="input.b.page4.stbe006_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe006_1
            
            #add-point:AFTER FIELD stbe006_1 name="input.a.page4.stbe006_1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbe006_1
            #add-point:ON CHANGE stbe006_1 name="input.g.page4.stbe006_1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe007_1
            #add-point:BEFORE FIELD stbe007_1 name="input.b.page4.stbe007_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe007_1
            
            #add-point:AFTER FIELD stbe007_1 name="input.a.page4.stbe007_1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbe007_1
            #add-point:ON CHANGE stbe007_1 name="input.g.page4.stbe007_1"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe008_1
            
            #add-point:AFTER FIELD stbe008_1 name="input.a.page4.stbe008_1"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe008_1
            #add-point:BEFORE FIELD stbe008_1 name="input.b.page4.stbe008_1"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbe008_1
            #add-point:ON CHANGE stbe008_1 name="input.g.page4.stbe008_1"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe009_1
            
            #add-point:AFTER FIELD stbe009_1 name="input.a.page4.stbe009_1"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe009_1
            #add-point:BEFORE FIELD stbe009_1 name="input.b.page4.stbe009_1"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbe009_1
            #add-point:ON CHANGE stbe009_1 name="input.g.page4.stbe009_1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe010_1
            #add-point:BEFORE FIELD stbe010_1 name="input.b.page4.stbe010_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe010_1
            
            #add-point:AFTER FIELD stbe010_1 name="input.a.page4.stbe010_1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbe010_1
            #add-point:ON CHANGE stbe010_1 name="input.g.page4.stbe010_1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe011_1
            #add-point:BEFORE FIELD stbe011_1 name="input.b.page4.stbe011_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe011_1
            
            #add-point:AFTER FIELD stbe011_1 name="input.a.page4.stbe011_1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbe011_1
            #add-point:ON CHANGE stbe011_1 name="input.g.page4.stbe011_1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe012_1
            #add-point:BEFORE FIELD stbe012_1 name="input.b.page4.stbe012_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe012_1
            
            #add-point:AFTER FIELD stbe012_1 name="input.a.page4.stbe012_1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbe012_1
            #add-point:ON CHANGE stbe012_1 name="input.g.page4.stbe012_1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe013_1
            #add-point:BEFORE FIELD stbe013_1 name="input.b.page4.stbe013_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe013_1
            
            #add-point:AFTER FIELD stbe013_1 name="input.a.page4.stbe013_1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbe013_1
            #add-point:ON CHANGE stbe013_1 name="input.g.page4.stbe013_1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe014_1
            #add-point:BEFORE FIELD stbe014_1 name="input.b.page4.stbe014_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe014_1
            
            #add-point:AFTER FIELD stbe014_1 name="input.a.page4.stbe014_1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbe014_1
            #add-point:ON CHANGE stbe014_1 name="input.g.page4.stbe014_1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe015_1
            #add-point:BEFORE FIELD stbe015_1 name="input.b.page4.stbe015_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe015_1
            
            #add-point:AFTER FIELD stbe015_1 name="input.a.page4.stbe015_1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbe015_1
            #add-point:ON CHANGE stbe015_1 name="input.g.page4.stbe015_1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe016_1
            #add-point:BEFORE FIELD stbe016_1 name="input.b.page4.stbe016_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe016_1
            
            #add-point:AFTER FIELD stbe016_1 name="input.a.page4.stbe016_1"
            IF NOT cl_null(g_stbe4_d[l_ac].stbe016) THEN
               IF g_stbe4_d[l_ac].stbe014 < 0 THEN 
                  IF g_stbe4_d[l_ac].stbe016 > 0 OR g_stbe4_d[l_ac].stbe016 < g_stbe4_d[l_ac].stbe014 THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'ast-00856'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     NEXT FIELD stbe016_1
                  END IF 
               ELSE
                  IF g_stbe4_d[l_ac].stbe016 < 0 OR g_stbe4_d[l_ac].stbe016 > g_stbe4_d[l_ac].stbe014 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'ast-00857'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     NEXT FIELD stbe016_1
                  END IF
               END IF 
            END IF
            ##add by zhangnan   --end
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbe016_1
            #add-point:ON CHANGE stbe016_1 name="input.g.page4.stbe016_1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe026_1
            #add-point:BEFORE FIELD stbe026_1 name="input.b.page4.stbe026_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe026_1
            
            #add-point:AFTER FIELD stbe026_1 name="input.a.page4.stbe026_1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbe026_1
            #add-point:ON CHANGE stbe026_1 name="input.g.page4.stbe026_1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe027_1
            #add-point:BEFORE FIELD stbe027_1 name="input.b.page4.stbe027_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe027_1
            
            #add-point:AFTER FIELD stbe027_1 name="input.a.page4.stbe027_1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbe027_1
            #add-point:ON CHANGE stbe027_1 name="input.g.page4.stbe027_1"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe017_1
            
            #add-point:AFTER FIELD stbe017_1 name="input.a.page4.stbe017_1"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe017_1
            #add-point:BEFORE FIELD stbe017_1 name="input.b.page4.stbe017_1"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbe017_1
            #add-point:ON CHANGE stbe017_1 name="input.g.page4.stbe017_1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe018_1
            #add-point:BEFORE FIELD stbe018_1 name="input.b.page4.stbe018_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe018_1
            
            #add-point:AFTER FIELD stbe018_1 name="input.a.page4.stbe018_1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbe018_1
            #add-point:ON CHANGE stbe018_1 name="input.g.page4.stbe018_1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe033_1
            #add-point:BEFORE FIELD stbe033_1 name="input.b.page4.stbe033_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe033_1
            
            #add-point:AFTER FIELD stbe033_1 name="input.a.page4.stbe033_1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbe033_1
            #add-point:ON CHANGE stbe033_1 name="input.g.page4.stbe033_1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe031_1
            #add-point:BEFORE FIELD stbe031_1 name="input.b.page4.stbe031_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe031_1
            
            #add-point:AFTER FIELD stbe031_1 name="input.a.page4.stbe031_1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbe031_1
            #add-point:ON CHANGE stbe031_1 name="input.g.page4.stbe031_1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe034_1
            #add-point:BEFORE FIELD stbe034_1 name="input.b.page4.stbe034_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe034_1
            
            #add-point:AFTER FIELD stbe034_1 name="input.a.page4.stbe034_1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbe034_1
            #add-point:ON CHANGE stbe034_1 name="input.g.page4.stbe034_1"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbesite_1
            
            #add-point:AFTER FIELD stbesite_1 name="input.a.page4.stbesite_1"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbesite_1
            #add-point:BEFORE FIELD stbesite_1 name="input.b.page4.stbesite_1"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbesite_1
            #add-point:ON CHANGE stbesite_1 name="input.g.page4.stbesite_1"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe020_1
            
            #add-point:AFTER FIELD stbe020_1 name="input.a.page4.stbe020_1"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe020_1
            #add-point:BEFORE FIELD stbe020_1 name="input.b.page4.stbe020_1"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbe020_1
            #add-point:ON CHANGE stbe020_1 name="input.g.page4.stbe020_1"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe019_1
            
            #add-point:AFTER FIELD stbe019_1 name="input.a.page4.stbe019_1"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe019_1
            #add-point:BEFORE FIELD stbe019_1 name="input.b.page4.stbe019_1"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbe019_1
            #add-point:ON CHANGE stbe019_1 name="input.g.page4.stbe019_1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe032_1
            #add-point:BEFORE FIELD stbe032_1 name="input.b.page4.stbe032_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe032_1
            
            #add-point:AFTER FIELD stbe032_1 name="input.a.page4.stbe032_1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbe032_1
            #add-point:ON CHANGE stbe032_1 name="input.g.page4.stbe032_1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbecomp_1
            #add-point:BEFORE FIELD stbecomp_1 name="input.b.page4.stbecomp_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbecomp_1
            
            #add-point:AFTER FIELD stbecomp_1 name="input.a.page4.stbecomp_1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbecomp_1
            #add-point:ON CHANGE stbecomp_1 name="input.g.page4.stbecomp_1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe021_1
            #add-point:BEFORE FIELD stbe021_1 name="input.b.page4.stbe021_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe021_1
            
            #add-point:AFTER FIELD stbe021_1 name="input.a.page4.stbe021_1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbe021_1
            #add-point:ON CHANGE stbe021_1 name="input.g.page4.stbe021_1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe022_1
            #add-point:BEFORE FIELD stbe022_1 name="input.b.page4.stbe022_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe022_1
            
            #add-point:AFTER FIELD stbe022_1 name="input.a.page4.stbe022_1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbe022_1
            #add-point:ON CHANGE stbe022_1 name="input.g.page4.stbe022_1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe023_1
            #add-point:BEFORE FIELD stbe023_1 name="input.b.page4.stbe023_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe023_1
            
            #add-point:AFTER FIELD stbe023_1 name="input.a.page4.stbe023_1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbe023_1
            #add-point:ON CHANGE stbe023_1 name="input.g.page4.stbe023_1"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page4.stbeseq_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbeseq_1
            #add-point:ON ACTION controlp INFIELD stbeseq_1 name="input.c.page4.stbeseq_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.stbe001_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe001_1
            #add-point:ON ACTION controlp INFIELD stbe001_1 name="input.c.page4.stbe001_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.stbe002_1
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe002_1
            #add-point:ON ACTION controlp INFIELD stbe002_1 name="input.c.page4.stbe002_1"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_stbe4_d[l_ac].stbe002   
            LET g_qryparam.arg1 = g_stbd_m.stbd037
            LET g_qryparam.where = " stbc003 = '3' AND stbc037 = 'Y' "
            
            CALL q_stbc004_3()     
            
            LET g_stbe4_d[l_ac].stbe002 = g_qryparam.return1  
            DISPLAY g_stbe4_d[l_ac].stbe002 TO stbe002_1  
            
            NEXT FIELD stbe002_1  
            #END add-point
 
 
         #Ctrlp:input.c.page4.stbe003_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe003_1
            #add-point:ON ACTION controlp INFIELD stbe003_1 name="input.c.page4.stbe003_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.stbe004_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe004_1
            #add-point:ON ACTION controlp INFIELD stbe004_1 name="input.c.page4.stbe004_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.stbe028_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe028_1
            #add-point:ON ACTION controlp INFIELD stbe028_1 name="input.c.page4.stbe028_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.stbe005_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe005_1
            #add-point:ON ACTION controlp INFIELD stbe005_1 name="input.c.page4.stbe005_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.stbe024_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe024_1
            #add-point:ON ACTION controlp INFIELD stbe024_1 name="input.c.page4.stbe024_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.stbe025_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe025_1
            #add-point:ON ACTION controlp INFIELD stbe025_1 name="input.c.page4.stbe025_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.l_stae003_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_stae003_1
            #add-point:ON ACTION controlp INFIELD l_stae003_1 name="input.c.page4.l_stae003_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.stbe006_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe006_1
            #add-point:ON ACTION controlp INFIELD stbe006_1 name="input.c.page4.stbe006_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.stbe007_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe007_1
            #add-point:ON ACTION controlp INFIELD stbe007_1 name="input.c.page4.stbe007_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.stbe008_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe008_1
            #add-point:ON ACTION controlp INFIELD stbe008_1 name="input.c.page4.stbe008_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.stbe009_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe009_1
            #add-point:ON ACTION controlp INFIELD stbe009_1 name="input.c.page4.stbe009_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.stbe010_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe010_1
            #add-point:ON ACTION controlp INFIELD stbe010_1 name="input.c.page4.stbe010_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.stbe011_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe011_1
            #add-point:ON ACTION controlp INFIELD stbe011_1 name="input.c.page4.stbe011_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.stbe012_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe012_1
            #add-point:ON ACTION controlp INFIELD stbe012_1 name="input.c.page4.stbe012_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.stbe013_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe013_1
            #add-point:ON ACTION controlp INFIELD stbe013_1 name="input.c.page4.stbe013_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.stbe014_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe014_1
            #add-point:ON ACTION controlp INFIELD stbe014_1 name="input.c.page4.stbe014_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.stbe015_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe015_1
            #add-point:ON ACTION controlp INFIELD stbe015_1 name="input.c.page4.stbe015_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.stbe016_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe016_1
            #add-point:ON ACTION controlp INFIELD stbe016_1 name="input.c.page4.stbe016_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.stbe026_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe026_1
            #add-point:ON ACTION controlp INFIELD stbe026_1 name="input.c.page4.stbe026_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.stbe027_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe027_1
            #add-point:ON ACTION controlp INFIELD stbe027_1 name="input.c.page4.stbe027_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.stbe017_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe017_1
            #add-point:ON ACTION controlp INFIELD stbe017_1 name="input.c.page4.stbe017_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.stbe018_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe018_1
            #add-point:ON ACTION controlp INFIELD stbe018_1 name="input.c.page4.stbe018_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.stbe033_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe033_1
            #add-point:ON ACTION controlp INFIELD stbe033_1 name="input.c.page4.stbe033_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.stbe031_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe031_1
            #add-point:ON ACTION controlp INFIELD stbe031_1 name="input.c.page4.stbe031_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.stbe034_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe034_1
            #add-point:ON ACTION controlp INFIELD stbe034_1 name="input.c.page4.stbe034_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.stbesite_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbesite_1
            #add-point:ON ACTION controlp INFIELD stbesite_1 name="input.c.page4.stbesite_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.stbe020_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe020_1
            #add-point:ON ACTION controlp INFIELD stbe020_1 name="input.c.page4.stbe020_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.stbe019_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe019_1
            #add-point:ON ACTION controlp INFIELD stbe019_1 name="input.c.page4.stbe019_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.stbe032_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe032_1
            #add-point:ON ACTION controlp INFIELD stbe032_1 name="input.c.page4.stbe032_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.stbecomp_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbecomp_1
            #add-point:ON ACTION controlp INFIELD stbecomp_1 name="input.c.page4.stbecomp_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.stbe021_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe021_1
            #add-point:ON ACTION controlp INFIELD stbe021_1 name="input.c.page4.stbe021_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.stbe022_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe022_1
            #add-point:ON ACTION controlp INFIELD stbe022_1 name="input.c.page4.stbe022_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.stbe023_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe023_1
            #add-point:ON ACTION controlp INFIELD stbe023_1 name="input.c.page4.stbe023_1"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page3 after_row name="input.body4.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_stbe4_d[l_ac].* = g_stbe4_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE astt840_bcl3
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL astt840_unlock_b("stbe_t","'3'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page3 after_row2 name="input.body4.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body4.after_input"
            CALL s_transaction_begin()
            IF s_astp840_stbe_summary(g_stbd_m.stbddocno) THEN
               CALL s_transaction_end('Y',0)
               SELECT  stbd008,stbd009,stbd010,stbd011,stbd012,stbd013,stbd014,stbd015,stbd016,stbd017,stbd018,stbd019,
                        stbd040,stbd045,stbd051,stbd052,stbd053,stbd054,stbd055,stbd056,stbd057,stbd058,stbd059
                INTO g_stbd_m.stbd008,g_stbd_m.stbd009,g_stbd_m.stbd010,g_stbd_m.stbd011,g_stbd_m.stbd012,g_stbd_m.stbd013,g_stbd_m.stbd014,g_stbd_m.stbd015,g_stbd_m.stbd016,g_stbd_m.stbd017,g_stbd_m.stbd018,g_stbd_m.stbd019,
                     g_stbd_m.stbd040,g_stbd_m.stbd045,g_stbd_m.stbd051,g_stbd_m.stbd052,g_stbd_m.stbd053,g_stbd_m.stbd054,g_stbd_m.stbd055,g_stbd_m.stbd056,g_stbd_m.stbd057,g_stbd_m.stbd058,g_stbd_m.stbd059
                FROM stbd_t 
                WHERE stbdent=g_enterprise   AND  stbddocno=g_stbd_m.stbddocno 
                DISPLAY BY NAME g_stbd_m.stbd008,g_stbd_m.stbd009,g_stbd_m.stbd010,g_stbd_m.stbd011,g_stbd_m.stbd012,
                                g_stbd_m.stbd013,g_stbd_m.stbd014,g_stbd_m.stbd015,g_stbd_m.stbd016,g_stbd_m.stbd017,
                                g_stbd_m.stbd018,g_stbd_m.stbd019,g_stbd_m.stbd040,g_stbd_m.stbd045,g_stbd_m.stbd051,
                                g_stbd_m.stbd052,g_stbd_m.stbd053,g_stbd_m.stbd054,g_stbd_m.stbd055,g_stbd_m.stbd056,
                                g_stbd_m.stbd057,g_stbd_m.stbd058,g_stbd_m.stbd059
            ELSE   
               CALL s_transaction_end('N',0)
            END IF
#            IF g_current_idx > 0 THEN
#               CALL astt840_ui_headershow()
#            END IF
            #end add-point   
    
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_stbe4_d[li_reproduce_target].* = g_stbe4_d[li_reproduce].*
 
               LET g_stbe4_d[li_reproduce_target].stbeseq = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_stbe4_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_stbe4_d.getLength()+1
            END IF
            
      END INPUT
      INPUT ARRAY g_stbe5_d FROM s_detail5.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = FALSE, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = FALSE)
                 
         #自訂ACTION(detail_input,page_4)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body5.before_input2"
            #160513-00037#27 20160603 add by beckxie---S
            ##单身没资料关闭单身
            #IF g_stbe5_d.getLength()=0 THEN
            #   EXIT DIALOG
            #END IF 
            #160513-00037#27 20160603 add by beckxie---E
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_stbe5_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL astt840_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'4',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_stbe5_d.getLength()
            #add-point:資料輸入前 name="input.body5.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_stbe5_d[l_ac].* TO NULL 
            INITIALIZE g_stbe5_d_t.* TO NULL 
            INITIALIZE g_stbe5_d_o.* TO NULL 
            #公用欄位給值(單身4)
            
            #自定義預設值(單身4)
            
            #add-point:modify段before備份 name="input.body5.insert.before_bak"
            LET g_stbe5_d[l_ac].stbeseq = astt840_stbeseq_def()
            LET g_stbe5_d[l_ac].stbe012 = "0"
            LET g_stbe5_d[l_ac].stbe013 = "0"
            LET g_stbe5_d[l_ac].stbe014 = "0"
            LET g_stbe5_d[l_ac].stbe015 = "0"
            LET g_stbe5_d[l_ac].stbe016 = "0"
            LET g_stbe5_d[l_ac].stbe026 = "0"
            LET g_stbe5_d[l_ac].stbe027 = "0"
            LET g_stbe5_d[l_ac].stbe031 = "0"
            LET g_stbe5_d[l_ac].stbe034 = "0"
            LET g_stbe5_d[l_ac].stbe021 = "0"
            LET g_stbe5_d[l_ac].stbe022 = "0"
            LET g_stbe5_d[l_ac].stbe023 = "0"            
            #end add-point
            LET g_stbe5_d_t.* = g_stbe5_d[l_ac].*     #新輸入資料
            LET g_stbe5_d_o.* = g_stbe5_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL astt840_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body5.insert.after_set_entry_b"
            
            #end add-point
            CALL astt840_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_stbe5_d[li_reproduce_target].* = g_stbe5_d[li_reproduce].*
 
               LET g_stbe5_d[li_reproduce_target].stbeseq = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body5.before_insert"
            
            #end add-point  
 
         BEFORE ROW     
            #add-point:modify段before row2 name="input.body5.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET g_detail_idx_list[4] = l_ac
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_current_page = 4
              
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN astt840_cl USING g_enterprise,g_stbd_m.stbddocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN astt840_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE astt840_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_stbe5_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_stbe5_d[l_ac].stbeseq IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_stbe5_d_t.* = g_stbe5_d[l_ac].*  #BACKUP
               LET g_stbe5_d_o.* = g_stbe5_d[l_ac].*  #BACKUP
               CALL astt840_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body5.after_set_entry_b"
               
               #end add-point  
               CALL astt840_set_no_entry_b(l_cmd)
               IF NOT astt840_lock_b("stbe_t","'4'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH astt840_bcl4 INTO g_stbe5_d[l_ac].stbeseq,g_stbe5_d[l_ac].stbe001,g_stbe5_d[l_ac].stbe002, 
                      g_stbe5_d[l_ac].stbe003,g_stbe5_d[l_ac].stbe004,g_stbe5_d[l_ac].stbe028,g_stbe5_d[l_ac].stbe005, 
                      g_stbe5_d[l_ac].stbe035,g_stbe5_d[l_ac].stbe036,g_stbe5_d[l_ac].stbe024,g_stbe5_d[l_ac].stbe025, 
                      g_stbe5_d[l_ac].stbe006,g_stbe5_d[l_ac].stbe007,g_stbe5_d[l_ac].stbe008,g_stbe5_d[l_ac].stbe009, 
                      g_stbe5_d[l_ac].stbe010,g_stbe5_d[l_ac].stbe011,g_stbe5_d[l_ac].stbe012,g_stbe5_d[l_ac].stbe013, 
                      g_stbe5_d[l_ac].stbe014,g_stbe5_d[l_ac].stbe015,g_stbe5_d[l_ac].stbe016,g_stbe5_d[l_ac].stbe026, 
                      g_stbe5_d[l_ac].stbe027,g_stbe5_d[l_ac].stbe017,g_stbe5_d[l_ac].stbe018,g_stbe5_d[l_ac].stbe033, 
                      g_stbe5_d[l_ac].stbe031,g_stbe5_d[l_ac].stbe034,g_stbe5_d[l_ac].stbesite,g_stbe5_d[l_ac].stbe020, 
                      g_stbe5_d[l_ac].stbe019,g_stbe5_d[l_ac].stbe032,g_stbe5_d[l_ac].stbecomp,g_stbe5_d[l_ac].stbe021, 
                      g_stbe5_d[l_ac].stbe022,g_stbe5_d[l_ac].stbe023
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_stbe5_d_mask_o[l_ac].* =  g_stbe5_d[l_ac].*
                  CALL astt840_stbe_t_mask()
                  LET g_stbe5_d_mask_n[l_ac].* =  g_stbe5_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL astt840_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body5.before_row"
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
            #其他table進行lock
            
 
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身AFTER DELETE (=d) name="input.body5.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body5.b_delete_ask"
               
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
               
               #add-point:單身4刪除前 name="input.body5.b_delete"
               
               #end add-point    
                  
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_stbd_m.stbddocno
               LET gs_keys[gs_keys.getLength()+1] = g_stbe5_d_t.stbeseq
            
               #刪除同層單身
               IF NOT astt840_delete_b('stbe_t',gs_keys,"'4'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE astt840_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT astt840_key_delete_b(gs_keys,'stbe_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE astt840_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身4刪除中 name="input.body5.m_delete"
               #IF NOT s_astt840_upd_stbc(1,   #160604-00009#15 20160607 mark by beckxie
               IF NOT s_astt840_upd_stbc(2,   #160604-00009#15 20160607 add by beckxie
                                         g_stbd_m.stbddocno,g_stbd_m.stbdunit,
                                         g_stbe5_d[l_ac].stbe002,g_stbe5_d[l_ac].stbe003) THEN
                  CALL s_transaction_end('N','0')
               END IF
               IF NOT s_astp840_stbe_summary(g_stbd_m.stbddocno) THEN
                  CALL s_transaction_end('N',0)
               else 
                  SELECT  stbd008,stbd009,stbd010,stbd011,stbd012,stbd013,stbd014,stbd015,stbd016,stbd017,stbd018,stbd019,
                        stbd040,stbd045,stbd051,stbd052,stbd053,stbd054,stbd055,stbd056,stbd057,stbd058,stbd059
                INTO g_stbd_m.stbd008,g_stbd_m.stbd009,g_stbd_m.stbd010,g_stbd_m.stbd011,g_stbd_m.stbd012,g_stbd_m.stbd013,g_stbd_m.stbd014,g_stbd_m.stbd015,g_stbd_m.stbd016,g_stbd_m.stbd017,g_stbd_m.stbd018,g_stbd_m.stbd019,
                     g_stbd_m.stbd040,g_stbd_m.stbd045,g_stbd_m.stbd051,g_stbd_m.stbd052,g_stbd_m.stbd053,g_stbd_m.stbd054,g_stbd_m.stbd055,g_stbd_m.stbd056,g_stbd_m.stbd057,g_stbd_m.stbd058,g_stbd_m.stbd059
                FROM stbd_t 
                WHERE stbdent=g_enterprise   AND  stbddocno=g_stbd_m.stbddocno 
                DISPLAY BY NAME g_stbd_m.stbd008,g_stbd_m.stbd009,g_stbd_m.stbd010,g_stbd_m.stbd011,g_stbd_m.stbd012,
                                g_stbd_m.stbd013,g_stbd_m.stbd014,g_stbd_m.stbd015,g_stbd_m.stbd016,g_stbd_m.stbd017,
                                g_stbd_m.stbd018,g_stbd_m.stbd019,g_stbd_m.stbd040,g_stbd_m.stbd045,g_stbd_m.stbd051,
                                g_stbd_m.stbd052,g_stbd_m.stbd053,g_stbd_m.stbd054,g_stbd_m.stbd055,g_stbd_m.stbd056,
                                g_stbd_m.stbd057,g_stbd_m.stbd058,g_stbd_m.stbd059
               END IF
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE astt840_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身4刪除後 name="input.body5.a_delete"
               
               #end add-point
               LET l_count = g_stbe_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body5.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_stbe5_d.getLength() + 1) THEN
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
               
            #add-point:單身4新增前 name="input.body5.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM stbe_t 
             WHERE stbeent = g_enterprise AND stbedocno = g_stbd_m.stbddocno
               AND stbeseq = g_stbe5_d[l_ac].stbeseq
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身4新增前 name="input.body5.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_stbd_m.stbddocno
               LET gs_keys[2] = g_stbe5_d[g_detail_idx].stbeseq
               CALL astt840_insert_b('stbe_t',gs_keys,"'4'")
                           
               #add-point:單身新增後4 name="input.body5.a_insert"
               IF NOT s_astt840_upd_stbc(1,
                                         g_stbd_m.stbddocno,g_stbd_m.stbdunit,
                                         g_stbe5_d[l_ac].stbe002,g_stbe5_d[l_ac].stbe003) THEN
                  CALL s_transaction_end('N','0')
               END IF
               IF NOT s_astp840_stbe_summary(g_stbd_m.stbddocno) THEN
                  CALL s_transaction_end('N',0)
               else
                  SELECT  stbd008,stbd009,stbd010,stbd011,stbd012,stbd013,stbd014,stbd015,stbd016,stbd017,stbd018,stbd019,
                        stbd040,stbd045,stbd051,stbd052,stbd053,stbd054,stbd055,stbd056,stbd057,stbd058,stbd059
                INTO g_stbd_m.stbd008,g_stbd_m.stbd009,g_stbd_m.stbd010,g_stbd_m.stbd011,g_stbd_m.stbd012,g_stbd_m.stbd013,g_stbd_m.stbd014,g_stbd_m.stbd015,g_stbd_m.stbd016,g_stbd_m.stbd017,g_stbd_m.stbd018,g_stbd_m.stbd019,
                     g_stbd_m.stbd040,g_stbd_m.stbd045,g_stbd_m.stbd051,g_stbd_m.stbd052,g_stbd_m.stbd053,g_stbd_m.stbd054,g_stbd_m.stbd055,g_stbd_m.stbd056,g_stbd_m.stbd057,g_stbd_m.stbd058,g_stbd_m.stbd059
                FROM stbd_t 
                WHERE stbdent=g_enterprise   AND  stbddocno=g_stbd_m.stbddocno 
                DISPLAY BY NAME g_stbd_m.stbd008,g_stbd_m.stbd009,g_stbd_m.stbd010,g_stbd_m.stbd011,g_stbd_m.stbd012,
                                g_stbd_m.stbd013,g_stbd_m.stbd014,g_stbd_m.stbd015,g_stbd_m.stbd016,g_stbd_m.stbd017,
                                g_stbd_m.stbd018,g_stbd_m.stbd019,g_stbd_m.stbd040,g_stbd_m.stbd045,g_stbd_m.stbd051,
                                g_stbd_m.stbd052,g_stbd_m.stbd053,g_stbd_m.stbd054,g_stbd_m.stbd055,g_stbd_m.stbd056,
                                g_stbd_m.stbd057,g_stbd_m.stbd058,g_stbd_m.stbd059
               END IF
               IF g_current_idx > 0 THEN
                  CALL astt840_ui_headershow()
               END IF
               #end add-point
            ELSE    
               INITIALIZE g_stbe_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "stbe_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL astt840_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body5.after_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_stbe5_d[l_ac].* = g_stbe5_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE astt840_bcl4
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
               LET g_stbe5_d[l_ac].* = g_stbe5_d_t.*
            ELSE
               #add-point:單身page4修改前 name="input.body5.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身4)
               
               
               #將遮罩欄位還原
               CALL astt840_stbe_t_mask_restore('restore_mask_o')
                              
               UPDATE stbe_t SET (stbedocno,stbeseq,stbe001,stbe002,stbe003,stbe004,stbe028,stbe005, 
                   stbe035,stbe036,stbe024,stbe025,stbe006,stbe007,stbe008,stbe009,stbe010,stbe011,stbe012, 
                   stbe013,stbe014,stbe015,stbe016,stbe026,stbe027,stbe017,stbe018,stbe033,stbe031,stbe034, 
                   stbesite,stbe020,stbe019,stbe032,stbecomp,stbe021,stbe022,stbe023) = (g_stbd_m.stbddocno, 
                   g_stbe5_d[l_ac].stbeseq,g_stbe5_d[l_ac].stbe001,g_stbe5_d[l_ac].stbe002,g_stbe5_d[l_ac].stbe003, 
                   g_stbe5_d[l_ac].stbe004,g_stbe5_d[l_ac].stbe028,g_stbe5_d[l_ac].stbe005,g_stbe5_d[l_ac].stbe035, 
                   g_stbe5_d[l_ac].stbe036,g_stbe5_d[l_ac].stbe024,g_stbe5_d[l_ac].stbe025,g_stbe5_d[l_ac].stbe006, 
                   g_stbe5_d[l_ac].stbe007,g_stbe5_d[l_ac].stbe008,g_stbe5_d[l_ac].stbe009,g_stbe5_d[l_ac].stbe010, 
                   g_stbe5_d[l_ac].stbe011,g_stbe5_d[l_ac].stbe012,g_stbe5_d[l_ac].stbe013,g_stbe5_d[l_ac].stbe014, 
                   g_stbe5_d[l_ac].stbe015,g_stbe5_d[l_ac].stbe016,g_stbe5_d[l_ac].stbe026,g_stbe5_d[l_ac].stbe027, 
                   g_stbe5_d[l_ac].stbe017,g_stbe5_d[l_ac].stbe018,g_stbe5_d[l_ac].stbe033,g_stbe5_d[l_ac].stbe031, 
                   g_stbe5_d[l_ac].stbe034,g_stbe5_d[l_ac].stbesite,g_stbe5_d[l_ac].stbe020,g_stbe5_d[l_ac].stbe019, 
                   g_stbe5_d[l_ac].stbe032,g_stbe5_d[l_ac].stbecomp,g_stbe5_d[l_ac].stbe021,g_stbe5_d[l_ac].stbe022, 
                   g_stbe5_d[l_ac].stbe023) #自訂欄位頁簽
                WHERE stbeent = g_enterprise AND stbedocno = g_stbd_m.stbddocno
                  AND stbeseq = g_stbe5_d_t.stbeseq #項次 
                  
               #add-point:單身page4修改中 name="input.body5.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_stbe5_d[l_ac].* = g_stbe5_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "stbe_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_stbe5_d[l_ac].* = g_stbe5_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "stbe_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_stbd_m.stbddocno
               LET gs_keys_bak[1] = g_stbddocno_t
               LET gs_keys[2] = g_stbe5_d[g_detail_idx].stbeseq
               LET gs_keys_bak[2] = g_stbe5_d_t.stbeseq
               CALL astt840_update_b('stbe_t',gs_keys,gs_keys_bak,"'4'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL astt840_stbe_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_stbe5_d[g_detail_idx].stbeseq = g_stbe5_d_t.stbeseq 
                  ) THEN
                  LET gs_keys[01] = g_stbd_m.stbddocno
                  LET gs_keys[gs_keys.getLength()+1] = g_stbe5_d_t.stbeseq
                  CALL astt840_key_update_b(gs_keys,'stbe_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_stbd_m),util.JSON.stringify(g_stbe5_d_t)
               LET g_log2 = util.JSON.stringify(g_stbd_m),util.JSON.stringify(g_stbe5_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page4修改後 name="input.body5.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbe016_2
            #add-point:BEFORE FIELD stbe016_2 name="input.b.page5.stbe016_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbe016_2
            
            #add-point:AFTER FIELD stbe016_2 name="input.a.page5.stbe016_2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbe016_2
            #add-point:ON CHANGE stbe016_2 name="input.g.page5.stbe016_2"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page5.stbe016_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbe016_2
            #add-point:ON ACTION controlp INFIELD stbe016_2 name="input.c.page5.stbe016_2"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page4 after_row name="input.body5.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_stbe5_d[l_ac].* = g_stbe5_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE astt840_bcl4
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL astt840_unlock_b("stbe_t","'4'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page4 after_row2 name="input.body5.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body5.after_input"
            CALL s_transaction_begin()
            IF s_astp840_stbe_summary(g_stbd_m.stbddocno) THEN
               CALL s_transaction_end('Y',0)
               SELECT  stbd008,stbd009,stbd010,stbd011,stbd012,stbd013,stbd014,stbd015,stbd016,stbd017,stbd018,stbd019,
                        stbd040,stbd045,stbd051,stbd052,stbd053,stbd054,stbd055,stbd056,stbd057,stbd058,stbd059
                INTO g_stbd_m.stbd008,g_stbd_m.stbd009,g_stbd_m.stbd010,g_stbd_m.stbd011,g_stbd_m.stbd012,g_stbd_m.stbd013,g_stbd_m.stbd014,g_stbd_m.stbd015,g_stbd_m.stbd016,g_stbd_m.stbd017,g_stbd_m.stbd018,g_stbd_m.stbd019,
                     g_stbd_m.stbd040,g_stbd_m.stbd045,g_stbd_m.stbd051,g_stbd_m.stbd052,g_stbd_m.stbd053,g_stbd_m.stbd054,g_stbd_m.stbd055,g_stbd_m.stbd056,g_stbd_m.stbd057,g_stbd_m.stbd058,g_stbd_m.stbd059
                FROM stbd_t 
                WHERE stbdent=g_enterprise   AND  stbddocno=g_stbd_m.stbddocno 
                DISPLAY BY NAME g_stbd_m.stbd008,g_stbd_m.stbd009,g_stbd_m.stbd010,g_stbd_m.stbd011,g_stbd_m.stbd012,
                                g_stbd_m.stbd013,g_stbd_m.stbd014,g_stbd_m.stbd015,g_stbd_m.stbd016,g_stbd_m.stbd017,
                                g_stbd_m.stbd018,g_stbd_m.stbd019,g_stbd_m.stbd040,g_stbd_m.stbd045,g_stbd_m.stbd051,
                                g_stbd_m.stbd052,g_stbd_m.stbd053,g_stbd_m.stbd054,g_stbd_m.stbd055,g_stbd_m.stbd056,
                                g_stbd_m.stbd057,g_stbd_m.stbd058,g_stbd_m.stbd059
                                
                 
            ELSE   
               CALL s_transaction_end('N',0)
            END IF
#            IF g_current_idx > 0 THEN
#               CALL astt840_ui_headershow()
#            END IF
            #end add-point   
    
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_stbe5_d[li_reproduce_target].* = g_stbe5_d[li_reproduce].*
 
               LET g_stbe5_d[li_reproduce_target].stbeseq = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_stbe5_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_stbe5_d.getLength()+1
            END IF
            
      END INPUT
 
      
 
 
 
 
{</section>}
 
{<section id="astt840.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
         
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1',"))      
         CALL DIALOG.setCurrentRow("s_detail2",g_idx_group.getValue("'2',"))
         CALL DIALOG.setCurrentRow("s_detail4",g_idx_group.getValue("'3',"))
         CALL DIALOG.setCurrentRow("s_detail5",g_idx_group.getValue("'4',"))
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            
            #end add-point  
            NEXT FIELD stbddocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD stbeseq
               WHEN "s_detail2"
                  NEXT FIELD stbfseq
               WHEN "s_detail4"
                  NEXT FIELD stbeseq
               WHEN "s_detail5"
                  NEXT FIELD stbeseq
 
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
         LET g_detail_idx_list[3] = 1
         LET g_detail_idx_list[4] = 1
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
         CALL g_curr_diag.setCurrentRow("s_detail4",1)
         CALL g_curr_diag.setCurrentRow("s_detail5",1)
 
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
         LET g_detail_idx_list[3] = 1
         LET g_detail_idx_list[4] = 1
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
         CALL g_curr_diag.setCurrentRow("s_detail4",1)
         CALL g_curr_diag.setCurrentRow("s_detail5",1)
 
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
    
   #add-point:input段after input  name="input.after_input"
   
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="astt840.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION astt840_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL astt840_b_fill() #單身填充
      CALL astt840_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL astt840_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
#   CALL astt840_get_period()
   #add by geza 20160802 #160728-00006#15(S)
   SELECT stje019,stje020,stje021 INTO g_stbd_m.stje019,g_stbd_m.stje020,g_stbd_m.stje021
     FROM stje_t
    WHERE stjeent = g_enterprise
      AND stje001 = g_stbd_m.stbd001
   CALL astt840_stje019_ref()
   CALL astt840_stje020_ref()
   CALL astt840_stje021_ref()
   #add by geza 20160802 #160728-00006#15(E)
   #end add-point
   
   #遮罩相關處理
   LET g_stbd_m_mask_o.* =  g_stbd_m.*
   CALL astt840_stbd_t_mask()
   LET g_stbd_m_mask_n.* =  g_stbd_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_stbd_m.stbdsite,g_stbd_m.stbdsite_desc,g_stbd_m.stbddocdt,g_stbd_m.stbddocno,g_stbd_m.stbd037, 
       g_stbd_m.stbd037_desc,g_stbd_m.stbd002,g_stbd_m.stbd002_desc,g_stbd_m.stbd046,g_stbd_m.stbd046_desc, 
       g_stbd_m.stbd000,g_stbd_m.stbd001,g_stbd_m.stbd041,g_stbd_m.stbdunit,g_stbd_m.stbdunit_desc,g_stbd_m.stbd048, 
       g_stbd_m.stbd048_desc,g_stbd_m.stbd049,g_stbd_m.stbd049_desc,g_stbd_m.stbd050,g_stbd_m.stbd050_desc, 
       g_stbd_m.stbd003,g_stbd_m.stbd043,g_stbd_m.stbd044,g_stbd_m.stbd004,g_stbd_m.l_stjo002,g_stbd_m.stbd005, 
       g_stbd_m.stbd006,g_stbd_m.stbd038,g_stbd_m.stbd060,g_stbd_m.stbd033,g_stbd_m.stbdstus,g_stbd_m.stbdownid, 
       g_stbd_m.stbdownid_desc,g_stbd_m.stbdowndp,g_stbd_m.stbdowndp_desc,g_stbd_m.stbdcrtid,g_stbd_m.stbdcrtid_desc, 
       g_stbd_m.stbdcrtdp,g_stbd_m.stbdcrtdp_desc,g_stbd_m.stbdcrtdt,g_stbd_m.stbdmodid,g_stbd_m.stbdmodid_desc, 
       g_stbd_m.stbdmoddt,g_stbd_m.stbdcnfid,g_stbd_m.stbdcnfid_desc,g_stbd_m.stbdcnfdt,g_stbd_m.stbd007, 
       g_stbd_m.stbd052,g_stbd_m.stbd051,g_stbd_m.stbd053,g_stbd_m.stbd008,g_stbd_m.stbd054,g_stbd_m.stbd009, 
       g_stbd_m.stbd055,g_stbd_m.stbd010,g_stbd_m.stbd056,g_stbd_m.stbd011,g_stbd_m.stbd057,g_stbd_m.stbd012, 
       g_stbd_m.stbd058,g_stbd_m.stbd013,g_stbd_m.stbd059,g_stbd_m.stbd014,g_stbd_m.stbd017,g_stbd_m.stbd018, 
       g_stbd_m.stbd016,g_stbd_m.stbd019,g_stbd_m.stbd045,g_stbd_m.stbd015,g_stbd_m.stbd040,g_stbd_m.stbd039, 
       g_stbd_m.stbd020,g_stbd_m.stbd042,g_stbd_m.stbd021,g_stbd_m.stbd021_desc,g_stbd_m.stbd022,g_stbd_m.stbd022_desc, 
       g_stbd_m.stje019,g_stbd_m.stje019_desc,g_stbd_m.stje020,g_stbd_m.stje020_desc,g_stbd_m.stje021, 
       g_stbd_m.stje021_desc,g_stbd_m.stbd023,g_stbd_m.stbd023_desc,g_stbd_m.stbd024,g_stbd_m.stbd025, 
       g_stbd_m.stbd025_desc,g_stbd_m.stbd026,g_stbd_m.stbd027,g_stbd_m.stbd028,g_stbd_m.stbd029,g_stbd_m.stbd030, 
       g_stbd_m.stbd030_desc,g_stbd_m.stbd031,g_stbd_m.stbd032,g_stbd_m.stbd034,g_stbd_m.stbd035,g_stbd_m.stbd036, 
       g_stbd_m.stbd047
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_stbd_m.stbdstus 
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
         WHEN "J"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/reconciliate.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_stbe_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_stbe2_d.getLength()
      #add-point:show段單身reference name="show.body2.reference"
      
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_stbe4_d.getLength()
      #add-point:show段單身reference name="show.body4.reference"
      
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_stbe5_d.getLength()
      #add-point:show段單身reference name="show.body5.reference"
      
      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL astt840_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="astt840.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION astt840_detail_show()
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
 
{<section id="astt840.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION astt840_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE stbd_t.stbddocno 
   DEFINE l_oldno     LIKE stbd_t.stbddocno 
 
   DEFINE l_master    RECORD LIKE stbd_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE stbe_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE stbf_t.* #此變數樣板目前無使用
 
   DEFINE l_detail3    RECORD LIKE stbe_t.* #此變數樣板目前無使用
 
   DEFINE l_detail4    RECORD LIKE stbe_t.* #此變數樣板目前無使用
 
 
 
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
   
   IF g_stbd_m.stbddocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_stbddocno_t = g_stbd_m.stbddocno
 
    
   LET g_stbd_m.stbddocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_stbd_m.stbdownid = g_user
      LET g_stbd_m.stbdowndp = g_dept
      LET g_stbd_m.stbdcrtid = g_user
      LET g_stbd_m.stbdcrtdp = g_dept 
      LET g_stbd_m.stbdcrtdt = cl_get_current()
      LET g_stbd_m.stbdmodid = g_user
      LET g_stbd_m.stbdmoddt = cl_get_current()
      LET g_stbd_m.stbdstus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_stbd_m.stbdstus 
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
         WHEN "J"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/reconciliate.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
   
   
   CALL astt840_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_stbd_m.* TO NULL
      INITIALIZE g_stbe_d TO NULL
      INITIALIZE g_stbe2_d TO NULL
      INITIALIZE g_stbe4_d TO NULL
      INITIALIZE g_stbe5_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL astt840_show()
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
   CALL astt840_set_act_visible()   
   CALL astt840_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_stbddocno_t = g_stbd_m.stbddocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " stbdent = " ||g_enterprise|| " AND",
                      " stbddocno = '", g_stbd_m.stbddocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL astt840_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL astt840_idx_chk()
   
   LET g_data_owner = g_stbd_m.stbdownid      
   LET g_data_dept  = g_stbd_m.stbdowndp
   
   #功能已完成,通報訊息中心
   CALL astt840_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="astt840.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION astt840_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE stbe_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE stbf_t.* #此變數樣板目前無使用
 
   DEFINE l_detail3    RECORD LIKE stbe_t.* #此變數樣板目前無使用
 
   DEFINE l_detail4    RECORD LIKE stbe_t.* #此變數樣板目前無使用
 
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE astt840_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM stbe_t
    WHERE stbeent = g_enterprise AND stbedocno = g_stbddocno_t
 
    INTO TEMP astt840_detail
 
   #將key修正為調整後   
   UPDATE astt840_detail 
      #更新key欄位
      SET stbedocno = g_stbd_m.stbddocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO stbe_t SELECT * FROM astt840_detail
   
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
   DROP TABLE astt840_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table2.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM stbf_t 
    WHERE stbfent = g_enterprise AND stbfdocno = g_stbddocno_t
 
    INTO TEMP astt840_detail
 
   #將key修正為調整後   
   UPDATE astt840_detail SET stbfdocno = g_stbd_m.stbddocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table2.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO stbf_t SELECT * FROM astt840_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table2.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE astt840_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table2.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table3.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   #SELECT * FROM stbe_t 
   # WHERE stbeent = g_enterprise AND stbedocno = g_stbddocno_t
 
   # INTO TEMP astt840_detail
 
   #將key修正為調整後   
   #UPDATE astt840_detail SET stbedocno = g_stbd_m.stbddocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table3.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   #INSERT INTO stbe_t SELECT * FROM astt840_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table3.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   #DROP TABLE astt840_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table3.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table4.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   #SELECT * FROM stbe_t 
   # WHERE stbeent = g_enterprise AND stbedocno = g_stbddocno_t
 
   # INTO TEMP astt840_detail
 
   #將key修正為調整後   
   #UPDATE astt840_detail SET stbedocno = g_stbd_m.stbddocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table4.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   #INSERT INTO stbe_t SELECT * FROM astt840_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table4.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   #DROP TABLE astt840_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table4.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_stbddocno_t = g_stbd_m.stbddocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="astt840.delete" >}
#+ 資料刪除
PRIVATE FUNCTION astt840_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point     
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   DEFINE  l_success      LIKE type_t.num5  #add by geza 20160610
   #end add-point     
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   IF g_stbd_m.stbddocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN astt840_cl USING g_enterprise,g_stbd_m.stbddocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN astt840_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE astt840_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE astt840_master_referesh USING g_stbd_m.stbddocno INTO g_stbd_m.stbdsite,g_stbd_m.stbddocdt, 
       g_stbd_m.stbddocno,g_stbd_m.stbd037,g_stbd_m.stbd002,g_stbd_m.stbd046,g_stbd_m.stbd000,g_stbd_m.stbd001, 
       g_stbd_m.stbd041,g_stbd_m.stbdunit,g_stbd_m.stbd048,g_stbd_m.stbd049,g_stbd_m.stbd050,g_stbd_m.stbd003, 
       g_stbd_m.stbd043,g_stbd_m.stbd044,g_stbd_m.stbd004,g_stbd_m.stbd005,g_stbd_m.stbd006,g_stbd_m.stbd038, 
       g_stbd_m.stbd060,g_stbd_m.stbd033,g_stbd_m.stbdstus,g_stbd_m.stbdownid,g_stbd_m.stbdowndp,g_stbd_m.stbdcrtid, 
       g_stbd_m.stbdcrtdp,g_stbd_m.stbdcrtdt,g_stbd_m.stbdmodid,g_stbd_m.stbdmoddt,g_stbd_m.stbdcnfid, 
       g_stbd_m.stbdcnfdt,g_stbd_m.stbd007,g_stbd_m.stbd052,g_stbd_m.stbd051,g_stbd_m.stbd053,g_stbd_m.stbd008, 
       g_stbd_m.stbd054,g_stbd_m.stbd009,g_stbd_m.stbd055,g_stbd_m.stbd010,g_stbd_m.stbd056,g_stbd_m.stbd011, 
       g_stbd_m.stbd057,g_stbd_m.stbd012,g_stbd_m.stbd058,g_stbd_m.stbd013,g_stbd_m.stbd059,g_stbd_m.stbd014, 
       g_stbd_m.stbd017,g_stbd_m.stbd018,g_stbd_m.stbd016,g_stbd_m.stbd019,g_stbd_m.stbd045,g_stbd_m.stbd015, 
       g_stbd_m.stbd040,g_stbd_m.stbd039,g_stbd_m.stbd020,g_stbd_m.stbd042,g_stbd_m.stbd021,g_stbd_m.stbd022, 
       g_stbd_m.stbd023,g_stbd_m.stbd024,g_stbd_m.stbd025,g_stbd_m.stbd026,g_stbd_m.stbd027,g_stbd_m.stbd028, 
       g_stbd_m.stbd029,g_stbd_m.stbd030,g_stbd_m.stbd031,g_stbd_m.stbd032,g_stbd_m.stbd034,g_stbd_m.stbd035, 
       g_stbd_m.stbd036,g_stbd_m.stbd047,g_stbd_m.stbdsite_desc,g_stbd_m.stbd037_desc,g_stbd_m.stbd002_desc, 
       g_stbd_m.stbd046_desc,g_stbd_m.stbdunit_desc,g_stbd_m.stbd049_desc,g_stbd_m.stbd050_desc,g_stbd_m.stbdownid_desc, 
       g_stbd_m.stbdowndp_desc,g_stbd_m.stbdcrtid_desc,g_stbd_m.stbdcrtdp_desc,g_stbd_m.stbdmodid_desc, 
       g_stbd_m.stbdcnfid_desc,g_stbd_m.stbd021_desc,g_stbd_m.stbd022_desc,g_stbd_m.stbd023_desc,g_stbd_m.stbd025_desc, 
       g_stbd_m.stbd030_desc
   
   
   #檢查是否允許此動作
   IF NOT astt840_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_stbd_m_mask_o.* =  g_stbd_m.*
   CALL astt840_stbd_t_mask()
   LET g_stbd_m_mask_n.* =  g_stbd_m.*
   
   CALL astt840_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      #add by geza 20160610(S)
      CALL astt840_delete_updstbc() RETURNING l_success
      IF NOT l_success THEN
         CALL s_transaction_end('N','0')
         RETURN      
      END IF   
      #回写供应商合同结算账期单身
      IF g_stbd_m.stbd039 = '2' THEN   #如果stbd039=1，不更新合同帐期
         
         UPDATE stjo_t SET stjo005 = 'N',
                           stjo006 = ''
          WHERE stjoent = g_enterprise AND stjo006 = g_stbd_m.stbddocno
           
         IF SQLCA.SQLcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "stjo_t" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = FALSE 
            CALL cl_err()
            CALL s_transaction_end('N','0')
            RETURN
         END IF
             
      END IF    
      #add by geza 20160610(E)
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL astt840_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_stbddocno_t = g_stbd_m.stbddocno
 
 
      DELETE FROM stbd_t
       WHERE stbdent = g_enterprise AND stbddocno = g_stbd_m.stbddocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_stbd_m.stbddocno,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      IF NOT s_aooi200_del_docno(g_stbd_m.stbddocno,g_stbd_m.stbddocdt) THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF
            
      IF g_current_idx > 0 THEN
         CALL astt840_ui_headershow()
      END IF
      #160604-00009#15 20160607 add by beckxie---E      
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
 
      #end add-point
      
      DELETE FROM stbe_t
       WHERE stbeent = g_enterprise AND stbedocno = g_stbd_m.stbddocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "stbe_t:",SQLERRMESSAGE 
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
      DELETE FROM stbf_t
       WHERE stbfent = g_enterprise AND
             stbfdocno = g_stbd_m.stbddocno
      #add-point:單身刪除中 name="delete.body.m_delete2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "stbf_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete2"
      
      #end add-point
 
      #add-point:單身刪除前 name="delete.body.b_delete3"
      
      #end add-point
      DELETE FROM stbe_t
       WHERE stbeent = g_enterprise AND
             stbedocno = g_stbd_m.stbddocno
      #add-point:單身刪除中 name="delete.body.m_delete3"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "stbe_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete3"
      
      #end add-point
 
      #add-point:單身刪除前 name="delete.body.b_delete4"
      
      #end add-point
      DELETE FROM stbe_t
       WHERE stbeent = g_enterprise AND
             stbedocno = g_stbd_m.stbddocno
      #add-point:單身刪除中 name="delete.body.m_delete4"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "stbe_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete4"
      
      #end add-point
 
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_stbd_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE astt840_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_stbe_d.clear() 
      CALL g_stbe2_d.clear()       
      CALL g_stbe4_d.clear()       
      CALL g_stbe5_d.clear()       
 
     
      CALL astt840_ui_browser_refresh()  
      #CALL astt840_ui_headershow()  
      #CALL astt840_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
      
      
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL astt840_browser_fill("")
         CALL astt840_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE astt840_cl
 
   #功能已完成,通報訊息中心
   CALL astt840_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="astt840.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION astt840_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_ooef019  LIKE ooef_t.ooef019
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_stbe_d.clear()
   CALL g_stbe2_d.clear()
   CALL g_stbe4_d.clear()
   CALL g_stbe5_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF astt840_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT stbeseq,stbe001,stbe002,stbe003,stbe004,stbe028,stbe005,stbe035, 
             stbe036,stbe024,stbe025,stbe006,stbe007,stbe008,stbe009,stbe010,stbe011,stbe012,stbe013, 
             stbe014,stbe015,stbe016,stbe026,stbe027,stbe017,stbe018,stbe033,stbe031,stbe034,stbesite, 
             stbe020,stbe019,stbe032,stbecomp,stbe021,stbe022,stbe023 ,t1.mhbel003 ,t2.stael003 ,t3.ooefl003 , 
             t4.ooail003 ,t5.staal003 ,t6.ooefl003 ,t7.ooefl003 ,t8.rtaxl003 FROM stbe_t",   
                     " INNER JOIN stbd_t ON stbdent = " ||g_enterprise|| " AND stbddocno = stbedocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN mhbel_t t1 ON t1.mhbelent="||g_enterprise||" AND t1.mhbel001=stbe028 AND t1.mhbel002='"||g_dlang||"' ",
               " LEFT JOIN stael_t t2 ON t2.staelent="||g_enterprise||" AND t2.stael001=stbe005 AND t2.stael002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=stbe036 AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooail_t t4 ON t4.ooailent="||g_enterprise||" AND t4.ooail001=stbe008 AND t4.ooail002='"||g_dlang||"' ",
               " LEFT JOIN staal_t t5 ON t5.staalent="||g_enterprise||" AND t5.staal001=stbe017 AND t5.staal002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent="||g_enterprise||" AND t6.ooefl001=stbesite AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t7 ON t7.ooeflent="||g_enterprise||" AND t7.ooefl001=stbe020 AND t7.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN rtaxl_t t8 ON t8.rtaxlent="||g_enterprise||" AND t8.rtaxl001=stbe019 AND t8.rtaxl002='"||g_dlang||"' ",
 
                     " WHERE stbeent=? AND stbedocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         LET g_sql = g_sql, " AND stbe001 IN ('4','5') "
         LET g_sql = cl_sql_add_mask(g_sql)
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY stbe_t.stbeseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE astt840_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR astt840_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_stbd_m.stbddocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_stbd_m.stbddocno INTO g_stbe_d[l_ac].stbeseq,g_stbe_d[l_ac].stbe001, 
          g_stbe_d[l_ac].stbe002,g_stbe_d[l_ac].stbe003,g_stbe_d[l_ac].stbe004,g_stbe_d[l_ac].stbe028, 
          g_stbe_d[l_ac].stbe005,g_stbe_d[l_ac].stbe035,g_stbe_d[l_ac].stbe036,g_stbe_d[l_ac].stbe024, 
          g_stbe_d[l_ac].stbe025,g_stbe_d[l_ac].stbe006,g_stbe_d[l_ac].stbe007,g_stbe_d[l_ac].stbe008, 
          g_stbe_d[l_ac].stbe009,g_stbe_d[l_ac].stbe010,g_stbe_d[l_ac].stbe011,g_stbe_d[l_ac].stbe012, 
          g_stbe_d[l_ac].stbe013,g_stbe_d[l_ac].stbe014,g_stbe_d[l_ac].stbe015,g_stbe_d[l_ac].stbe016, 
          g_stbe_d[l_ac].stbe026,g_stbe_d[l_ac].stbe027,g_stbe_d[l_ac].stbe017,g_stbe_d[l_ac].stbe018, 
          g_stbe_d[l_ac].stbe033,g_stbe_d[l_ac].stbe031,g_stbe_d[l_ac].stbe034,g_stbe_d[l_ac].stbesite, 
          g_stbe_d[l_ac].stbe020,g_stbe_d[l_ac].stbe019,g_stbe_d[l_ac].stbe032,g_stbe_d[l_ac].stbecomp, 
          g_stbe_d[l_ac].stbe021,g_stbe_d[l_ac].stbe022,g_stbe_d[l_ac].stbe023,g_stbe_d[l_ac].stbe028_desc, 
          g_stbe_d[l_ac].stbe005_desc,g_stbe_d[l_ac].stbe036_desc,g_stbe_d[l_ac].stbe008_desc,g_stbe_d[l_ac].stbe017_desc, 
          g_stbe_d[l_ac].stbesite_desc,g_stbe_d[l_ac].stbe020_desc,g_stbe_d[l_ac].stbe019_desc   #(ver:78) 
 
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill.fill"
         LET l_ooef019 = ''
         LET l_ooef019 = astt840_get_ooef019(g_stbe_d[l_ac].stbesite) 
         LET g_stbe_d[l_ac].stbe009_desc  = s_desc_get_tax_desc(l_ooef019,g_stbe_d[l_ac].stbe009)   #稅別
         #160604-00009#15 20160608 add by beckxie---S
         #160609-00001#1 160609 by lori mod l_stbe003_desc->l_stae003_desc
         #費用種類
         CALL astt840_get_stae003(g_stbe_d[l_ac].stbe005) RETURNING g_stbe_d[l_ac].l_stae003,g_stbe_d[l_ac].l_stae003_desc
         #160604-00009#15 20160608 add by beckxie---E
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
   IF astt840_fill_chk(2) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body2.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT stbfseq,stbf001,stbf002,stbf003,stbf004,stbf005,stbf009,stbf010, 
             stbf006,stbf007,stbf008,stbf011,stbf012,stbfcomp,stbfsite,stbf013,stbf014,stbf015,stbf016 , 
             t9.ooefl003 FROM stbf_t",   
                     " INNER JOIN  stbd_t ON stbdent = " ||g_enterprise|| " AND stbddocno = stbfdocno ",
 
                     "",
                     
                                    " LEFT JOIN ooefl_t t9 ON t9.ooeflent="||g_enterprise||" AND t9.ooefl001=stbf015 AND t9.ooefl002='"||g_dlang||"' ",
 
                     " WHERE stbfent=? AND stbfdocno=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body2.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table2) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY stbf_t.stbfseq"
         
         #add-point:單身填充控制 name="b_fill.sql2"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE astt840_pb2 FROM g_sql
         DECLARE b_fill_cs2 CURSOR FOR astt840_pb2
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs2 USING g_enterprise,g_stbd_m.stbddocno   #(ver:78)
                                               
      FOREACH b_fill_cs2 USING g_enterprise,g_stbd_m.stbddocno INTO g_stbe2_d[l_ac].stbfseq,g_stbe2_d[l_ac].stbf001, 
          g_stbe2_d[l_ac].stbf002,g_stbe2_d[l_ac].stbf003,g_stbe2_d[l_ac].stbf004,g_stbe2_d[l_ac].stbf005, 
          g_stbe2_d[l_ac].stbf009,g_stbe2_d[l_ac].stbf010,g_stbe2_d[l_ac].stbf006,g_stbe2_d[l_ac].stbf007, 
          g_stbe2_d[l_ac].stbf008,g_stbe2_d[l_ac].stbf011,g_stbe2_d[l_ac].stbf012,g_stbe2_d[l_ac].stbfcomp, 
          g_stbe2_d[l_ac].stbfsite,g_stbe2_d[l_ac].stbf013,g_stbe2_d[l_ac].stbf014,g_stbe2_d[l_ac].stbf015, 
          g_stbe2_d[l_ac].stbf016,g_stbe2_d[l_ac].stbf015_desc   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill2.fill"
         #160509-00004#30 --str--
         SELECT oodbl004 INTO g_stbe2_d[l_ac].stbf004_desc
            FROM oodb_t
            LEFT OUTER JOIN oodbl_t ON oodbent = oodblent
                                   AND oodb001 = oodbl001
                                   AND oodb002 = oodbl002
                                   AND oodbl003 = g_lang
           WHERE oodbent = g_enterprise 
             AND oodbl002 = g_stbe2_d[l_ac].stbf004
             AND oodb008 IN ('1', '2', '3')
             AND ((oodb004 = '1' AND oodb003 = 'T01') OR (oodb004 <> '1'))
             AND oodbstus = 'Y'
         #160509-00004#30 --end--
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
 
   #判斷是否填充
   IF astt840_fill_chk(3) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body3.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT stbeseq,stbe001,stbe002,stbe003,stbe004,stbe028,stbe005,stbe035, 
             stbe036,stbe024,stbe025,stbe006,stbe007,stbe008,stbe009,stbe010,stbe011,stbe012,stbe013, 
             stbe014,stbe015,stbe016,stbe026,stbe027,stbe017,stbe018,stbe033,stbe031,stbe034,stbesite, 
             stbe020,stbe019,stbe032,stbecomp,stbe021,stbe022,stbe023 ,t10.mhbel003 ,t11.stael003 ,t12.ooefl003 , 
             t13.ooail003 ,t14.staal003 ,t15.ooefl003 ,t16.ooefl003 ,t17.rtaxl003 FROM stbe_t",   
                     " INNER JOIN  stbd_t ON stbdent = " ||g_enterprise|| " AND stbddocno = stbedocno ",
 
                     "",
                     
                                    " LEFT JOIN mhbel_t t10 ON t10.mhbelent="||g_enterprise||" AND t10.mhbel001=stbe028 AND t10.mhbel002='"||g_dlang||"' ",
               " LEFT JOIN stael_t t11 ON t11.staelent="||g_enterprise||" AND t11.stael001=stbe005 AND t11.stael002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t12 ON t12.ooeflent="||g_enterprise||" AND t12.ooefl001=stbe036 AND t12.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooail_t t13 ON t13.ooailent="||g_enterprise||" AND t13.ooail001=stbe008 AND t13.ooail002='"||g_dlang||"' ",
               " LEFT JOIN staal_t t14 ON t14.staalent="||g_enterprise||" AND t14.staal001=stbe017 AND t14.staal002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t15 ON t15.ooeflent="||g_enterprise||" AND t15.ooefl001=stbesite AND t15.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t16 ON t16.ooeflent="||g_enterprise||" AND t16.ooefl001=stbe020 AND t16.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN rtaxl_t t17 ON t17.rtaxlent="||g_enterprise||" AND t17.rtaxl001=stbe019 AND t17.rtaxl002='"||g_dlang||"' ",
 
                     " WHERE stbeent=? AND stbedocno=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body3.fill_sql"
         LET g_sql = g_sql, " AND stbe001 = '3' AND stbe024 = 'Y' "
         #end add-point
         IF NOT cl_null(g_wc2_table3) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table3 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY stbe_t.stbeseq"
         
         #add-point:單身填充控制 name="b_fill.sql3"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE astt840_pb3 FROM g_sql
         DECLARE b_fill_cs3 CURSOR FOR astt840_pb3
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs3 USING g_enterprise,g_stbd_m.stbddocno   #(ver:78)
                                               
      FOREACH b_fill_cs3 USING g_enterprise,g_stbd_m.stbddocno INTO g_stbe4_d[l_ac].stbeseq,g_stbe4_d[l_ac].stbe001, 
          g_stbe4_d[l_ac].stbe002,g_stbe4_d[l_ac].stbe003,g_stbe4_d[l_ac].stbe004,g_stbe4_d[l_ac].stbe028, 
          g_stbe4_d[l_ac].stbe005,g_stbe4_d[l_ac].stbe035,g_stbe4_d[l_ac].stbe036,g_stbe4_d[l_ac].stbe024, 
          g_stbe4_d[l_ac].stbe025,g_stbe4_d[l_ac].stbe006,g_stbe4_d[l_ac].stbe007,g_stbe4_d[l_ac].stbe008, 
          g_stbe4_d[l_ac].stbe009,g_stbe4_d[l_ac].stbe010,g_stbe4_d[l_ac].stbe011,g_stbe4_d[l_ac].stbe012, 
          g_stbe4_d[l_ac].stbe013,g_stbe4_d[l_ac].stbe014,g_stbe4_d[l_ac].stbe015,g_stbe4_d[l_ac].stbe016, 
          g_stbe4_d[l_ac].stbe026,g_stbe4_d[l_ac].stbe027,g_stbe4_d[l_ac].stbe017,g_stbe4_d[l_ac].stbe018, 
          g_stbe4_d[l_ac].stbe033,g_stbe4_d[l_ac].stbe031,g_stbe4_d[l_ac].stbe034,g_stbe4_d[l_ac].stbesite, 
          g_stbe4_d[l_ac].stbe020,g_stbe4_d[l_ac].stbe019,g_stbe4_d[l_ac].stbe032,g_stbe4_d[l_ac].stbecomp, 
          g_stbe4_d[l_ac].stbe021,g_stbe4_d[l_ac].stbe022,g_stbe4_d[l_ac].stbe023,g_stbe4_d[l_ac].stbe028_1_desc, 
          g_stbe4_d[l_ac].stbe005_1_desc,g_stbe4_d[l_ac].stbe036_1_desc,g_stbe4_d[l_ac].stbe008_1_desc, 
          g_stbe4_d[l_ac].stbe017_1_desc,g_stbe4_d[l_ac].stbesite_1_desc,g_stbe4_d[l_ac].stbe020_1_desc, 
          g_stbe4_d[l_ac].stbe019_1_desc   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill3.fill"
         LET l_ooef019 = ''
         LET l_ooef019 = astt840_get_ooef019(g_stbe4_d[l_ac].stbesite) 
         LET g_stbe4_d[l_ac].stbe009_1_desc  = s_desc_get_tax_desc(l_ooef019,g_stbe4_d[l_ac].stbe009)   #稅別
         #160604-00009#15 20160608 add by beckxie---S
         #160609-00001#1 160609 by lori mod l_stbe003_1_desc->l_stae003_1_desc
         #費用種類
         CALL astt840_get_stae003(g_stbe4_d[l_ac].stbe005) RETURNING g_stbe4_d[l_ac].l_stae003_1,g_stbe4_d[l_ac].l_stae003_1_desc
         #160604-00009#15 20160608 add by beckxie---E         
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
 
   #判斷是否填充
   IF astt840_fill_chk(4) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body4.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT stbeseq,stbe001,stbe002,stbe003,stbe004,stbe028,stbe005,stbe035, 
             stbe036,stbe024,stbe025,stbe006,stbe007,stbe008,stbe009,stbe010,stbe011,stbe012,stbe013, 
             stbe014,stbe015,stbe016,stbe026,stbe027,stbe017,stbe018,stbe033,stbe031,stbe034,stbesite, 
             stbe020,stbe019,stbe032,stbecomp,stbe021,stbe022,stbe023 ,t18.mhbel003 ,t19.stael003 ,t20.ooefl003 , 
             t21.ooail003 ,t22.staal003 ,t23.ooefl003 ,t24.ooefl003 ,t25.rtaxl003 FROM stbe_t",   
                     " INNER JOIN  stbd_t ON stbdent = " ||g_enterprise|| " AND stbddocno = stbedocno ",
 
                     "",
                     
                                    " LEFT JOIN mhbel_t t18 ON t18.mhbelent="||g_enterprise||" AND t18.mhbel001=stbe028 AND t18.mhbel002='"||g_dlang||"' ",
               " LEFT JOIN stael_t t19 ON t19.staelent="||g_enterprise||" AND t19.stael001=stbe005 AND t19.stael002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t20 ON t20.ooeflent="||g_enterprise||" AND t20.ooefl001=stbe036 AND t20.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooail_t t21 ON t21.ooailent="||g_enterprise||" AND t21.ooail001=stbe008 AND t21.ooail002='"||g_dlang||"' ",
               " LEFT JOIN staal_t t22 ON t22.staalent="||g_enterprise||" AND t22.staal001=stbe017 AND t22.staal002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t23 ON t23.ooeflent="||g_enterprise||" AND t23.ooefl001=stbesite AND t23.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t24 ON t24.ooeflent="||g_enterprise||" AND t24.ooefl001=stbe020 AND t24.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN rtaxl_t t25 ON t25.rtaxlent="||g_enterprise||" AND t25.rtaxl001=stbe019 AND t25.rtaxl002='"||g_dlang||"' ",
 
                     " WHERE stbeent=? AND stbedocno=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body4.fill_sql"
         LET g_sql = g_sql, " AND stbe001 = '3' AND stbe024 = 'N' "
         #end add-point
         IF NOT cl_null(g_wc2_table4) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table4 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY stbe_t.stbeseq"
         
         #add-point:單身填充控制 name="b_fill.sql4"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE astt840_pb4 FROM g_sql
         DECLARE b_fill_cs4 CURSOR FOR astt840_pb4
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs4 USING g_enterprise,g_stbd_m.stbddocno   #(ver:78)
                                               
      FOREACH b_fill_cs4 USING g_enterprise,g_stbd_m.stbddocno INTO g_stbe5_d[l_ac].stbeseq,g_stbe5_d[l_ac].stbe001, 
          g_stbe5_d[l_ac].stbe002,g_stbe5_d[l_ac].stbe003,g_stbe5_d[l_ac].stbe004,g_stbe5_d[l_ac].stbe028, 
          g_stbe5_d[l_ac].stbe005,g_stbe5_d[l_ac].stbe035,g_stbe5_d[l_ac].stbe036,g_stbe5_d[l_ac].stbe024, 
          g_stbe5_d[l_ac].stbe025,g_stbe5_d[l_ac].stbe006,g_stbe5_d[l_ac].stbe007,g_stbe5_d[l_ac].stbe008, 
          g_stbe5_d[l_ac].stbe009,g_stbe5_d[l_ac].stbe010,g_stbe5_d[l_ac].stbe011,g_stbe5_d[l_ac].stbe012, 
          g_stbe5_d[l_ac].stbe013,g_stbe5_d[l_ac].stbe014,g_stbe5_d[l_ac].stbe015,g_stbe5_d[l_ac].stbe016, 
          g_stbe5_d[l_ac].stbe026,g_stbe5_d[l_ac].stbe027,g_stbe5_d[l_ac].stbe017,g_stbe5_d[l_ac].stbe018, 
          g_stbe5_d[l_ac].stbe033,g_stbe5_d[l_ac].stbe031,g_stbe5_d[l_ac].stbe034,g_stbe5_d[l_ac].stbesite, 
          g_stbe5_d[l_ac].stbe020,g_stbe5_d[l_ac].stbe019,g_stbe5_d[l_ac].stbe032,g_stbe5_d[l_ac].stbecomp, 
          g_stbe5_d[l_ac].stbe021,g_stbe5_d[l_ac].stbe022,g_stbe5_d[l_ac].stbe023,g_stbe5_d[l_ac].stbe028_2_desc, 
          g_stbe5_d[l_ac].stbe005_2_desc,g_stbe5_d[l_ac].stbe036_2_desc,g_stbe5_d[l_ac].stbe008_2_desc, 
          g_stbe5_d[l_ac].stbe017_2_desc,g_stbe5_d[l_ac].stbesite_2_desc,g_stbe5_d[l_ac].stbe020_2_desc, 
          g_stbe5_d[l_ac].stbe019_2_desc   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill4.fill"
         LET l_ooef019 = ''
         LET l_ooef019 = astt840_get_ooef019(g_stbe5_d[l_ac].stbesite) 
         LET g_stbe5_d[l_ac].stbe009_2_desc  = s_desc_get_tax_desc(l_ooef019,g_stbe5_d[l_ac].stbe009)   #稅別         
         #160604-00009#15 20160608 add by beckxie---S
         #160609-00001#1 160609 by lori mod l_stbe003_2_desc->l_stae003_2_desc
         #費用種類
         CALL astt840_get_stae003(g_stbe5_d[l_ac].stbe005) RETURNING g_stbe5_d[l_ac].l_stae003_2,g_stbe5_d[l_ac].l_stae003_2_desc
         #160604-00009#15 20160608 add by beckxie---E  
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
   CALL astt840_detail3_fill()
   #end add-point
   
   CALL g_stbe_d.deleteElement(g_stbe_d.getLength())
   CALL g_stbe2_d.deleteElement(g_stbe2_d.getLength())
   CALL g_stbe4_d.deleteElement(g_stbe4_d.getLength())
   CALL g_stbe5_d.deleteElement(g_stbe5_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE astt840_pb
   FREE astt840_pb2
 
   FREE astt840_pb3
 
   FREE astt840_pb4
 
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_stbe_d.getLength()
      LET g_stbe_d_mask_o[l_ac].* =  g_stbe_d[l_ac].*
      CALL astt840_stbe_t_mask()
      LET g_stbe_d_mask_n[l_ac].* =  g_stbe_d[l_ac].*
   END FOR
   
   LET g_stbe2_d_mask_o.* =  g_stbe2_d.*
   FOR l_ac = 1 TO g_stbe2_d.getLength()
      LET g_stbe2_d_mask_o[l_ac].* =  g_stbe2_d[l_ac].*
      CALL astt840_stbf_t_mask()
      LET g_stbe2_d_mask_n[l_ac].* =  g_stbe2_d[l_ac].*
   END FOR
   LET g_stbe4_d_mask_o.* =  g_stbe4_d.*
   FOR l_ac = 1 TO g_stbe4_d.getLength()
      LET g_stbe4_d_mask_o[l_ac].* =  g_stbe4_d[l_ac].*
      CALL astt840_stbe_t_mask()
      LET g_stbe4_d_mask_n[l_ac].* =  g_stbe4_d[l_ac].*
   END FOR
   LET g_stbe5_d_mask_o.* =  g_stbe5_d.*
   FOR l_ac = 1 TO g_stbe5_d.getLength()
      LET g_stbe5_d_mask_o[l_ac].* =  g_stbe5_d[l_ac].*
      CALL astt840_stbe_t_mask()
      LET g_stbe5_d_mask_n[l_ac].* =  g_stbe5_d[l_ac].*
   END FOR
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="astt840.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION astt840_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM stbe_t
       WHERE stbeent = g_enterprise AND
         stbedocno = ps_keys_bak[1] AND stbeseq = ps_keys_bak[2]
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
         CALL g_stbe_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete2"
      
      #end add-point    
      DELETE FROM stbf_t
       WHERE stbfent = g_enterprise AND
             stbfdocno = ps_keys_bak[1] AND stbfseq = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete2"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "stbf_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_stbe2_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete2"
      
      #end add-point    
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete3"
      
      #end add-point    
      DELETE FROM stbe_t
       WHERE stbeent = g_enterprise AND
             stbedocno = ps_keys_bak[1] AND stbeseq = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete3"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "stbe_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'3'" THEN 
         CALL g_stbe4_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete3"
      
      #end add-point    
   END IF
 
   LET ls_group = "'4',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete4"
      
      #end add-point    
      DELETE FROM stbe_t
       WHERE stbeent = g_enterprise AND
             stbedocno = ps_keys_bak[1] AND stbeseq = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete4"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "stbe_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'4'" THEN 
         CALL g_stbe5_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete4"
      
      #end add-point    
   END IF
 
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="astt840.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION astt840_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO stbe_t
                  (stbeent,
                   stbedocno,
                   stbeseq
                   ,stbe001,stbe002,stbe003,stbe004,stbe028,stbe005,stbe035,stbe036,stbe024,stbe025,stbe006,stbe007,stbe008,stbe009,stbe010,stbe011,stbe012,stbe013,stbe014,stbe015,stbe016,stbe026,stbe027,stbe017,stbe018,stbe033,stbe031,stbe034,stbesite,stbe020,stbe019,stbe032,stbecomp,stbe021,stbe022,stbe023) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_stbe_d[g_detail_idx].stbe001,g_stbe_d[g_detail_idx].stbe002,g_stbe_d[g_detail_idx].stbe003, 
                       g_stbe_d[g_detail_idx].stbe004,g_stbe_d[g_detail_idx].stbe028,g_stbe_d[g_detail_idx].stbe005, 
                       g_stbe_d[g_detail_idx].stbe035,g_stbe_d[g_detail_idx].stbe036,g_stbe_d[g_detail_idx].stbe024, 
                       g_stbe_d[g_detail_idx].stbe025,g_stbe_d[g_detail_idx].stbe006,g_stbe_d[g_detail_idx].stbe007, 
                       g_stbe_d[g_detail_idx].stbe008,g_stbe_d[g_detail_idx].stbe009,g_stbe_d[g_detail_idx].stbe010, 
                       g_stbe_d[g_detail_idx].stbe011,g_stbe_d[g_detail_idx].stbe012,g_stbe_d[g_detail_idx].stbe013, 
                       g_stbe_d[g_detail_idx].stbe014,g_stbe_d[g_detail_idx].stbe015,g_stbe_d[g_detail_idx].stbe016, 
                       g_stbe_d[g_detail_idx].stbe026,g_stbe_d[g_detail_idx].stbe027,g_stbe_d[g_detail_idx].stbe017, 
                       g_stbe_d[g_detail_idx].stbe018,g_stbe_d[g_detail_idx].stbe033,g_stbe_d[g_detail_idx].stbe031, 
                       g_stbe_d[g_detail_idx].stbe034,g_stbe_d[g_detail_idx].stbesite,g_stbe_d[g_detail_idx].stbe020, 
                       g_stbe_d[g_detail_idx].stbe019,g_stbe_d[g_detail_idx].stbe032,g_stbe_d[g_detail_idx].stbecomp, 
                       g_stbe_d[g_detail_idx].stbe021,g_stbe_d[g_detail_idx].stbe022,g_stbe_d[g_detail_idx].stbe023) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "stbe_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_stbe_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert2"
      
      #end add-point 
      INSERT INTO stbf_t
                  (stbfent,
                   stbfdocno,
                   stbfseq
                   ,stbf001,stbf002,stbf003,stbf004,stbf005,stbf009,stbf010,stbf006,stbf007,stbf008,stbf011,stbf012,stbfcomp,stbfsite,stbf013,stbf014,stbf015,stbf016) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_stbe2_d[g_detail_idx].stbf001,g_stbe2_d[g_detail_idx].stbf002,g_stbe2_d[g_detail_idx].stbf003, 
                       g_stbe2_d[g_detail_idx].stbf004,g_stbe2_d[g_detail_idx].stbf005,g_stbe2_d[g_detail_idx].stbf009, 
                       g_stbe2_d[g_detail_idx].stbf010,g_stbe2_d[g_detail_idx].stbf006,g_stbe2_d[g_detail_idx].stbf007, 
                       g_stbe2_d[g_detail_idx].stbf008,g_stbe2_d[g_detail_idx].stbf011,g_stbe2_d[g_detail_idx].stbf012, 
                       g_stbe2_d[g_detail_idx].stbfcomp,g_stbe2_d[g_detail_idx].stbfsite,g_stbe2_d[g_detail_idx].stbf013, 
                       g_stbe2_d[g_detail_idx].stbf014,g_stbe2_d[g_detail_idx].stbf015,g_stbe2_d[g_detail_idx].stbf016) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "stbf_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_stbe2_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert2"
      
      #end add-point
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert3"
      
      #end add-point 
      INSERT INTO stbe_t
                  (stbeent,
                   stbedocno,
                   stbeseq
                   ,stbe001,stbe002,stbe003,stbe004,stbe028,stbe005,stbe035,stbe036,stbe024,stbe025,stbe006,stbe007,stbe008,stbe009,stbe010,stbe011,stbe012,stbe013,stbe014,stbe015,stbe016,stbe026,stbe027,stbe017,stbe018,stbe033,stbe031,stbe034,stbesite,stbe020,stbe019,stbe032,stbecomp,stbe021,stbe022,stbe023) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_stbe4_d[g_detail_idx].stbe001,g_stbe4_d[g_detail_idx].stbe002,g_stbe4_d[g_detail_idx].stbe003, 
                       g_stbe4_d[g_detail_idx].stbe004,g_stbe4_d[g_detail_idx].stbe028,g_stbe4_d[g_detail_idx].stbe005, 
                       g_stbe4_d[g_detail_idx].stbe035,g_stbe4_d[g_detail_idx].stbe036,g_stbe4_d[g_detail_idx].stbe024, 
                       g_stbe4_d[g_detail_idx].stbe025,g_stbe4_d[g_detail_idx].stbe006,g_stbe4_d[g_detail_idx].stbe007, 
                       g_stbe4_d[g_detail_idx].stbe008,g_stbe4_d[g_detail_idx].stbe009,g_stbe4_d[g_detail_idx].stbe010, 
                       g_stbe4_d[g_detail_idx].stbe011,g_stbe4_d[g_detail_idx].stbe012,g_stbe4_d[g_detail_idx].stbe013, 
                       g_stbe4_d[g_detail_idx].stbe014,g_stbe4_d[g_detail_idx].stbe015,g_stbe4_d[g_detail_idx].stbe016, 
                       g_stbe4_d[g_detail_idx].stbe026,g_stbe4_d[g_detail_idx].stbe027,g_stbe4_d[g_detail_idx].stbe017, 
                       g_stbe4_d[g_detail_idx].stbe018,g_stbe4_d[g_detail_idx].stbe033,g_stbe4_d[g_detail_idx].stbe031, 
                       g_stbe4_d[g_detail_idx].stbe034,g_stbe4_d[g_detail_idx].stbesite,g_stbe4_d[g_detail_idx].stbe020, 
                       g_stbe4_d[g_detail_idx].stbe019,g_stbe4_d[g_detail_idx].stbe032,g_stbe4_d[g_detail_idx].stbecomp, 
                       g_stbe4_d[g_detail_idx].stbe021,g_stbe4_d[g_detail_idx].stbe022,g_stbe4_d[g_detail_idx].stbe023) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert3"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "stbe_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'3'" THEN 
         CALL g_stbe4_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert3"
      
      #end add-point
   END IF
 
   LET ls_group = "'4',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert4"
      
      #end add-point 
      INSERT INTO stbe_t
                  (stbeent,
                   stbedocno,
                   stbeseq
                   ,stbe001,stbe002,stbe003,stbe004,stbe028,stbe005,stbe035,stbe036,stbe024,stbe025,stbe006,stbe007,stbe008,stbe009,stbe010,stbe011,stbe012,stbe013,stbe014,stbe015,stbe016,stbe026,stbe027,stbe017,stbe018,stbe033,stbe031,stbe034,stbesite,stbe020,stbe019,stbe032,stbecomp,stbe021,stbe022,stbe023) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_stbe5_d[g_detail_idx].stbe001,g_stbe5_d[g_detail_idx].stbe002,g_stbe5_d[g_detail_idx].stbe003, 
                       g_stbe5_d[g_detail_idx].stbe004,g_stbe5_d[g_detail_idx].stbe028,g_stbe5_d[g_detail_idx].stbe005, 
                       g_stbe5_d[g_detail_idx].stbe035,g_stbe5_d[g_detail_idx].stbe036,g_stbe5_d[g_detail_idx].stbe024, 
                       g_stbe5_d[g_detail_idx].stbe025,g_stbe5_d[g_detail_idx].stbe006,g_stbe5_d[g_detail_idx].stbe007, 
                       g_stbe5_d[g_detail_idx].stbe008,g_stbe5_d[g_detail_idx].stbe009,g_stbe5_d[g_detail_idx].stbe010, 
                       g_stbe5_d[g_detail_idx].stbe011,g_stbe5_d[g_detail_idx].stbe012,g_stbe5_d[g_detail_idx].stbe013, 
                       g_stbe5_d[g_detail_idx].stbe014,g_stbe5_d[g_detail_idx].stbe015,g_stbe5_d[g_detail_idx].stbe016, 
                       g_stbe5_d[g_detail_idx].stbe026,g_stbe5_d[g_detail_idx].stbe027,g_stbe5_d[g_detail_idx].stbe017, 
                       g_stbe5_d[g_detail_idx].stbe018,g_stbe5_d[g_detail_idx].stbe033,g_stbe5_d[g_detail_idx].stbe031, 
                       g_stbe5_d[g_detail_idx].stbe034,g_stbe5_d[g_detail_idx].stbesite,g_stbe5_d[g_detail_idx].stbe020, 
                       g_stbe5_d[g_detail_idx].stbe019,g_stbe5_d[g_detail_idx].stbe032,g_stbe5_d[g_detail_idx].stbecomp, 
                       g_stbe5_d[g_detail_idx].stbe021,g_stbe5_d[g_detail_idx].stbe022,g_stbe5_d[g_detail_idx].stbe023) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert4"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "stbe_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'4'" THEN 
         CALL g_stbe5_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert4"
      
      #end add-point
   END IF
 
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="astt840.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION astt840_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "stbe_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL astt840_stbe_t_mask_restore('restore_mask_o')
               
      UPDATE stbe_t 
         SET (stbedocno,
              stbeseq
              ,stbe001,stbe002,stbe003,stbe004,stbe028,stbe005,stbe035,stbe036,stbe024,stbe025,stbe006,stbe007,stbe008,stbe009,stbe010,stbe011,stbe012,stbe013,stbe014,stbe015,stbe016,stbe026,stbe027,stbe017,stbe018,stbe033,stbe031,stbe034,stbesite,stbe020,stbe019,stbe032,stbecomp,stbe021,stbe022,stbe023) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_stbe_d[g_detail_idx].stbe001,g_stbe_d[g_detail_idx].stbe002,g_stbe_d[g_detail_idx].stbe003, 
                  g_stbe_d[g_detail_idx].stbe004,g_stbe_d[g_detail_idx].stbe028,g_stbe_d[g_detail_idx].stbe005, 
                  g_stbe_d[g_detail_idx].stbe035,g_stbe_d[g_detail_idx].stbe036,g_stbe_d[g_detail_idx].stbe024, 
                  g_stbe_d[g_detail_idx].stbe025,g_stbe_d[g_detail_idx].stbe006,g_stbe_d[g_detail_idx].stbe007, 
                  g_stbe_d[g_detail_idx].stbe008,g_stbe_d[g_detail_idx].stbe009,g_stbe_d[g_detail_idx].stbe010, 
                  g_stbe_d[g_detail_idx].stbe011,g_stbe_d[g_detail_idx].stbe012,g_stbe_d[g_detail_idx].stbe013, 
                  g_stbe_d[g_detail_idx].stbe014,g_stbe_d[g_detail_idx].stbe015,g_stbe_d[g_detail_idx].stbe016, 
                  g_stbe_d[g_detail_idx].stbe026,g_stbe_d[g_detail_idx].stbe027,g_stbe_d[g_detail_idx].stbe017, 
                  g_stbe_d[g_detail_idx].stbe018,g_stbe_d[g_detail_idx].stbe033,g_stbe_d[g_detail_idx].stbe031, 
                  g_stbe_d[g_detail_idx].stbe034,g_stbe_d[g_detail_idx].stbesite,g_stbe_d[g_detail_idx].stbe020, 
                  g_stbe_d[g_detail_idx].stbe019,g_stbe_d[g_detail_idx].stbe032,g_stbe_d[g_detail_idx].stbecomp, 
                  g_stbe_d[g_detail_idx].stbe021,g_stbe_d[g_detail_idx].stbe022,g_stbe_d[g_detail_idx].stbe023)  
 
         WHERE stbeent = g_enterprise AND stbedocno = ps_keys_bak[1] AND stbeseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "stbe_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "stbe_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL astt840_stbe_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
      
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
   
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "stbf_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update2"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL astt840_stbf_t_mask_restore('restore_mask_o')
               
      UPDATE stbf_t 
         SET (stbfdocno,
              stbfseq
              ,stbf001,stbf002,stbf003,stbf004,stbf005,stbf009,stbf010,stbf006,stbf007,stbf008,stbf011,stbf012,stbfcomp,stbfsite,stbf013,stbf014,stbf015,stbf016) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_stbe2_d[g_detail_idx].stbf001,g_stbe2_d[g_detail_idx].stbf002,g_stbe2_d[g_detail_idx].stbf003, 
                  g_stbe2_d[g_detail_idx].stbf004,g_stbe2_d[g_detail_idx].stbf005,g_stbe2_d[g_detail_idx].stbf009, 
                  g_stbe2_d[g_detail_idx].stbf010,g_stbe2_d[g_detail_idx].stbf006,g_stbe2_d[g_detail_idx].stbf007, 
                  g_stbe2_d[g_detail_idx].stbf008,g_stbe2_d[g_detail_idx].stbf011,g_stbe2_d[g_detail_idx].stbf012, 
                  g_stbe2_d[g_detail_idx].stbfcomp,g_stbe2_d[g_detail_idx].stbfsite,g_stbe2_d[g_detail_idx].stbf013, 
                  g_stbe2_d[g_detail_idx].stbf014,g_stbe2_d[g_detail_idx].stbf015,g_stbe2_d[g_detail_idx].stbf016)  
 
         WHERE stbfent = g_enterprise AND stbfdocno = ps_keys_bak[1] AND stbfseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update2"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "stbf_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "stbf_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL astt840_stbf_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update2"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "stbe_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update3"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL astt840_stbe_t_mask_restore('restore_mask_o')
               
      UPDATE stbe_t 
         SET (stbedocno,
              stbeseq
              ,stbe001,stbe002,stbe003,stbe004,stbe028,stbe005,stbe035,stbe036,stbe024,stbe025,stbe006,stbe007,stbe008,stbe009,stbe010,stbe011,stbe012,stbe013,stbe014,stbe015,stbe016,stbe026,stbe027,stbe017,stbe018,stbe033,stbe031,stbe034,stbesite,stbe020,stbe019,stbe032,stbecomp,stbe021,stbe022,stbe023) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_stbe4_d[g_detail_idx].stbe001,g_stbe4_d[g_detail_idx].stbe002,g_stbe4_d[g_detail_idx].stbe003, 
                  g_stbe4_d[g_detail_idx].stbe004,g_stbe4_d[g_detail_idx].stbe028,g_stbe4_d[g_detail_idx].stbe005, 
                  g_stbe4_d[g_detail_idx].stbe035,g_stbe4_d[g_detail_idx].stbe036,g_stbe4_d[g_detail_idx].stbe024, 
                  g_stbe4_d[g_detail_idx].stbe025,g_stbe4_d[g_detail_idx].stbe006,g_stbe4_d[g_detail_idx].stbe007, 
                  g_stbe4_d[g_detail_idx].stbe008,g_stbe4_d[g_detail_idx].stbe009,g_stbe4_d[g_detail_idx].stbe010, 
                  g_stbe4_d[g_detail_idx].stbe011,g_stbe4_d[g_detail_idx].stbe012,g_stbe4_d[g_detail_idx].stbe013, 
                  g_stbe4_d[g_detail_idx].stbe014,g_stbe4_d[g_detail_idx].stbe015,g_stbe4_d[g_detail_idx].stbe016, 
                  g_stbe4_d[g_detail_idx].stbe026,g_stbe4_d[g_detail_idx].stbe027,g_stbe4_d[g_detail_idx].stbe017, 
                  g_stbe4_d[g_detail_idx].stbe018,g_stbe4_d[g_detail_idx].stbe033,g_stbe4_d[g_detail_idx].stbe031, 
                  g_stbe4_d[g_detail_idx].stbe034,g_stbe4_d[g_detail_idx].stbesite,g_stbe4_d[g_detail_idx].stbe020, 
                  g_stbe4_d[g_detail_idx].stbe019,g_stbe4_d[g_detail_idx].stbe032,g_stbe4_d[g_detail_idx].stbecomp, 
                  g_stbe4_d[g_detail_idx].stbe021,g_stbe4_d[g_detail_idx].stbe022,g_stbe4_d[g_detail_idx].stbe023)  
 
         WHERE stbeent = g_enterprise AND stbedocno = ps_keys_bak[1] AND stbeseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update3"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "stbe_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "stbe_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL astt840_stbe_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update3"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
   LET ls_group = "'4',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "stbe_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update4"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL astt840_stbe_t_mask_restore('restore_mask_o')
               
      UPDATE stbe_t 
         SET (stbedocno,
              stbeseq
              ,stbe001,stbe002,stbe003,stbe004,stbe028,stbe005,stbe035,stbe036,stbe024,stbe025,stbe006,stbe007,stbe008,stbe009,stbe010,stbe011,stbe012,stbe013,stbe014,stbe015,stbe016,stbe026,stbe027,stbe017,stbe018,stbe033,stbe031,stbe034,stbesite,stbe020,stbe019,stbe032,stbecomp,stbe021,stbe022,stbe023) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_stbe5_d[g_detail_idx].stbe001,g_stbe5_d[g_detail_idx].stbe002,g_stbe5_d[g_detail_idx].stbe003, 
                  g_stbe5_d[g_detail_idx].stbe004,g_stbe5_d[g_detail_idx].stbe028,g_stbe5_d[g_detail_idx].stbe005, 
                  g_stbe5_d[g_detail_idx].stbe035,g_stbe5_d[g_detail_idx].stbe036,g_stbe5_d[g_detail_idx].stbe024, 
                  g_stbe5_d[g_detail_idx].stbe025,g_stbe5_d[g_detail_idx].stbe006,g_stbe5_d[g_detail_idx].stbe007, 
                  g_stbe5_d[g_detail_idx].stbe008,g_stbe5_d[g_detail_idx].stbe009,g_stbe5_d[g_detail_idx].stbe010, 
                  g_stbe5_d[g_detail_idx].stbe011,g_stbe5_d[g_detail_idx].stbe012,g_stbe5_d[g_detail_idx].stbe013, 
                  g_stbe5_d[g_detail_idx].stbe014,g_stbe5_d[g_detail_idx].stbe015,g_stbe5_d[g_detail_idx].stbe016, 
                  g_stbe5_d[g_detail_idx].stbe026,g_stbe5_d[g_detail_idx].stbe027,g_stbe5_d[g_detail_idx].stbe017, 
                  g_stbe5_d[g_detail_idx].stbe018,g_stbe5_d[g_detail_idx].stbe033,g_stbe5_d[g_detail_idx].stbe031, 
                  g_stbe5_d[g_detail_idx].stbe034,g_stbe5_d[g_detail_idx].stbesite,g_stbe5_d[g_detail_idx].stbe020, 
                  g_stbe5_d[g_detail_idx].stbe019,g_stbe5_d[g_detail_idx].stbe032,g_stbe5_d[g_detail_idx].stbecomp, 
                  g_stbe5_d[g_detail_idx].stbe021,g_stbe5_d[g_detail_idx].stbe022,g_stbe5_d[g_detail_idx].stbe023)  
 
         WHERE stbeent = g_enterprise AND stbedocno = ps_keys_bak[1] AND stbeseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update4"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "stbe_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "stbe_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL astt840_stbe_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update4"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
 
   
 
   
   #add-point:update_b段other name="update_b.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="astt840.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION astt840_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="astt840.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION astt840_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="astt840.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION astt840_lock_b(ps_table,ps_page)
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
   #CALL astt840_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "stbe_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN astt840_bcl USING g_enterprise,
                                       g_stbd_m.stbddocno,g_stbe_d[g_detail_idx].stbeseq     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "astt840_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
                                    
   #鎖定整組table
   #LET ls_group = "'2',"
   #僅鎖定自身table
   LET ls_group = "stbf_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN astt840_bcl2 USING g_enterprise,
                                             g_stbd_m.stbddocno,g_stbe2_d[g_detail_idx].stbfseq
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "astt840_bcl2:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
   #鎖定整組table
   #LET ls_group = "'3',"
   #僅鎖定自身table
   LET ls_group = "stbe_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN astt840_bcl3 USING g_enterprise,
                                             g_stbd_m.stbddocno,g_stbe4_d[g_detail_idx].stbeseq
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "astt840_bcl3:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
   #鎖定整組table
   #LET ls_group = "'4',"
   #僅鎖定自身table
   LET ls_group = "stbe_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN astt840_bcl4 USING g_enterprise,
                                             g_stbd_m.stbddocno,g_stbe5_d[g_detail_idx].stbeseq
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "astt840_bcl4:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
 
   
 
   
   #add-point:lock_b段other name="lock_b.other"
   #160509-00004#30  add by liyan --str--
   LET ls_group = "stbf_1_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN astt840_bcl9 USING g_enterprise,
                                             g_stbd_m.stbddocno,g_stbe2_d[g_detail_idx].stbfseq
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "astt840_bcl2:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
   #160509-00004#30 add by liyan --end--
   #end add-point  
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="astt840.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION astt840_unlock_b(ps_table,ps_page)
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
      CLOSE astt840_bcl
   END IF
   
   LET ls_group = "'2',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE astt840_bcl2
   END IF
 
   LET ls_group = "'3',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE astt840_bcl3
   END IF
 
   LET ls_group = "'4',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE astt840_bcl4
   END IF
 
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   #160509-00004#30 add by liyan --str--
   LET ls_group = "'5',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE astt840_bcl9
   END IF
   #160509-00004#30 add by liyan --end--
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="astt840.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION astt840_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("stbddocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("stbddocno",TRUE)
      CALL cl_set_comp_entry("stbddocdt",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   CALL cl_set_comp_entry("stbdsite,stbdunit",TRUE)
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="astt840.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION astt840_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("stbddocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("stbddocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("stbddocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   IF (NOT s_aooi500_comp_entry(g_prog,'stbdsite') OR g_ins_site_flag = 'Y') THEN
      CALL cl_set_comp_entry("stbdsite",FALSE)
   END IF
   
   IF NOT s_aooi500_comp_entry(g_prog,'stbdunit') THEN
      CALL cl_set_comp_entry("stbdunit",FALSE)
   END IF
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="astt840.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION astt840_set_entry_b(p_cmd)
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
 
{<section id="astt840.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION astt840_set_no_entry_b(p_cmd)
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
 
{<section id="astt840.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION astt840_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="astt840.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION astt840_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:2)
   IF g_stbd_m.stbdstus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF



   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="astt840.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION astt840_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="astt840.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION astt840_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="astt840.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION astt840_default_search()
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
      LET ls_wc = ls_wc, " stbddocno = '", g_argv[01], "' AND "
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
 
         INITIALIZE g_wc2_table3 TO NULL
 
         INITIALIZE g_wc2_table4 TO NULL
 
 
         FOR li_idx = 1 TO la_wc.getLength()
            CASE
               WHEN la_wc[li_idx].tableid = "stbd_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "stbe_t" 
                  LET g_wc2_table1 = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "stbf_t" 
                  LET g_wc2_table2 = la_wc[li_idx].wc
 
               WHEN la_wc[li_idx].tableid = "stbe_t" 
                  LET g_wc2_table3 = la_wc[li_idx].wc
 
               WHEN la_wc[li_idx].tableid = "stbe_t" 
                  LET g_wc2_table4 = la_wc[li_idx].wc
 
 
               WHEN la_wc[li_idx].tableid = "EXTENDWC"
                  LET g_wc2_extend = la_wc[li_idx].wc
            END CASE
         END FOR
         IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
            OR NOT cl_null(g_wc2_table2)
 
            OR NOT cl_null(g_wc2_table3)
 
            OR NOT cl_null(g_wc2_table4)
 
 
            OR NOT cl_null(g_wc2_extend)
            THEN
            #組合g_wc2
            IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
               LET g_wc2 = g_wc2_table1
            END IF
            IF g_wc2_table2 <> " 1=1" AND NOT cl_null(g_wc2_table2) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
            END IF
 
            IF g_wc2_table3 <> " 1=1" AND NOT cl_null(g_wc2_table3) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_table3
            END IF
 
            IF g_wc2_table4 <> " 1=1" AND NOT cl_null(g_wc2_table4) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_table4
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
 
{<section id="astt840.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION astt840_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_success      LIKE type_t.num5   #add by geza 20160610
   DEFINE l_errno        LIKE type_t.chr100 #add by geza 20160610
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_stbd_m.stbddocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN astt840_cl USING g_enterprise,g_stbd_m.stbddocno
   IF STATUS THEN
      CLOSE astt840_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN astt840_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE astt840_master_referesh USING g_stbd_m.stbddocno INTO g_stbd_m.stbdsite,g_stbd_m.stbddocdt, 
       g_stbd_m.stbddocno,g_stbd_m.stbd037,g_stbd_m.stbd002,g_stbd_m.stbd046,g_stbd_m.stbd000,g_stbd_m.stbd001, 
       g_stbd_m.stbd041,g_stbd_m.stbdunit,g_stbd_m.stbd048,g_stbd_m.stbd049,g_stbd_m.stbd050,g_stbd_m.stbd003, 
       g_stbd_m.stbd043,g_stbd_m.stbd044,g_stbd_m.stbd004,g_stbd_m.stbd005,g_stbd_m.stbd006,g_stbd_m.stbd038, 
       g_stbd_m.stbd060,g_stbd_m.stbd033,g_stbd_m.stbdstus,g_stbd_m.stbdownid,g_stbd_m.stbdowndp,g_stbd_m.stbdcrtid, 
       g_stbd_m.stbdcrtdp,g_stbd_m.stbdcrtdt,g_stbd_m.stbdmodid,g_stbd_m.stbdmoddt,g_stbd_m.stbdcnfid, 
       g_stbd_m.stbdcnfdt,g_stbd_m.stbd007,g_stbd_m.stbd052,g_stbd_m.stbd051,g_stbd_m.stbd053,g_stbd_m.stbd008, 
       g_stbd_m.stbd054,g_stbd_m.stbd009,g_stbd_m.stbd055,g_stbd_m.stbd010,g_stbd_m.stbd056,g_stbd_m.stbd011, 
       g_stbd_m.stbd057,g_stbd_m.stbd012,g_stbd_m.stbd058,g_stbd_m.stbd013,g_stbd_m.stbd059,g_stbd_m.stbd014, 
       g_stbd_m.stbd017,g_stbd_m.stbd018,g_stbd_m.stbd016,g_stbd_m.stbd019,g_stbd_m.stbd045,g_stbd_m.stbd015, 
       g_stbd_m.stbd040,g_stbd_m.stbd039,g_stbd_m.stbd020,g_stbd_m.stbd042,g_stbd_m.stbd021,g_stbd_m.stbd022, 
       g_stbd_m.stbd023,g_stbd_m.stbd024,g_stbd_m.stbd025,g_stbd_m.stbd026,g_stbd_m.stbd027,g_stbd_m.stbd028, 
       g_stbd_m.stbd029,g_stbd_m.stbd030,g_stbd_m.stbd031,g_stbd_m.stbd032,g_stbd_m.stbd034,g_stbd_m.stbd035, 
       g_stbd_m.stbd036,g_stbd_m.stbd047,g_stbd_m.stbdsite_desc,g_stbd_m.stbd037_desc,g_stbd_m.stbd002_desc, 
       g_stbd_m.stbd046_desc,g_stbd_m.stbdunit_desc,g_stbd_m.stbd049_desc,g_stbd_m.stbd050_desc,g_stbd_m.stbdownid_desc, 
       g_stbd_m.stbdowndp_desc,g_stbd_m.stbdcrtid_desc,g_stbd_m.stbdcrtdp_desc,g_stbd_m.stbdmodid_desc, 
       g_stbd_m.stbdcnfid_desc,g_stbd_m.stbd021_desc,g_stbd_m.stbd022_desc,g_stbd_m.stbd023_desc,g_stbd_m.stbd025_desc, 
       g_stbd_m.stbd030_desc
   
 
   #檢查是否允許此動作
   IF NOT astt840_action_chk() THEN
      CLOSE astt840_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_stbd_m.stbdsite,g_stbd_m.stbdsite_desc,g_stbd_m.stbddocdt,g_stbd_m.stbddocno,g_stbd_m.stbd037, 
       g_stbd_m.stbd037_desc,g_stbd_m.stbd002,g_stbd_m.stbd002_desc,g_stbd_m.stbd046,g_stbd_m.stbd046_desc, 
       g_stbd_m.stbd000,g_stbd_m.stbd001,g_stbd_m.stbd041,g_stbd_m.stbdunit,g_stbd_m.stbdunit_desc,g_stbd_m.stbd048, 
       g_stbd_m.stbd048_desc,g_stbd_m.stbd049,g_stbd_m.stbd049_desc,g_stbd_m.stbd050,g_stbd_m.stbd050_desc, 
       g_stbd_m.stbd003,g_stbd_m.stbd043,g_stbd_m.stbd044,g_stbd_m.stbd004,g_stbd_m.l_stjo002,g_stbd_m.stbd005, 
       g_stbd_m.stbd006,g_stbd_m.stbd038,g_stbd_m.stbd060,g_stbd_m.stbd033,g_stbd_m.stbdstus,g_stbd_m.stbdownid, 
       g_stbd_m.stbdownid_desc,g_stbd_m.stbdowndp,g_stbd_m.stbdowndp_desc,g_stbd_m.stbdcrtid,g_stbd_m.stbdcrtid_desc, 
       g_stbd_m.stbdcrtdp,g_stbd_m.stbdcrtdp_desc,g_stbd_m.stbdcrtdt,g_stbd_m.stbdmodid,g_stbd_m.stbdmodid_desc, 
       g_stbd_m.stbdmoddt,g_stbd_m.stbdcnfid,g_stbd_m.stbdcnfid_desc,g_stbd_m.stbdcnfdt,g_stbd_m.stbd007, 
       g_stbd_m.stbd052,g_stbd_m.stbd051,g_stbd_m.stbd053,g_stbd_m.stbd008,g_stbd_m.stbd054,g_stbd_m.stbd009, 
       g_stbd_m.stbd055,g_stbd_m.stbd010,g_stbd_m.stbd056,g_stbd_m.stbd011,g_stbd_m.stbd057,g_stbd_m.stbd012, 
       g_stbd_m.stbd058,g_stbd_m.stbd013,g_stbd_m.stbd059,g_stbd_m.stbd014,g_stbd_m.stbd017,g_stbd_m.stbd018, 
       g_stbd_m.stbd016,g_stbd_m.stbd019,g_stbd_m.stbd045,g_stbd_m.stbd015,g_stbd_m.stbd040,g_stbd_m.stbd039, 
       g_stbd_m.stbd020,g_stbd_m.stbd042,g_stbd_m.stbd021,g_stbd_m.stbd021_desc,g_stbd_m.stbd022,g_stbd_m.stbd022_desc, 
       g_stbd_m.stje019,g_stbd_m.stje019_desc,g_stbd_m.stje020,g_stbd_m.stje020_desc,g_stbd_m.stje021, 
       g_stbd_m.stje021_desc,g_stbd_m.stbd023,g_stbd_m.stbd023_desc,g_stbd_m.stbd024,g_stbd_m.stbd025, 
       g_stbd_m.stbd025_desc,g_stbd_m.stbd026,g_stbd_m.stbd027,g_stbd_m.stbd028,g_stbd_m.stbd029,g_stbd_m.stbd030, 
       g_stbd_m.stbd030_desc,g_stbd_m.stbd031,g_stbd_m.stbd032,g_stbd_m.stbd034,g_stbd_m.stbd035,g_stbd_m.stbd036, 
       g_stbd_m.stbd047
 
   CASE g_stbd_m.stbdstus
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
      WHEN "J"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/reconciliate.png")
      WHEN "X"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
      
   END CASE
 
   #add-point:資料刷新後 name="statechange.after_refresh"
   
   #end add-point
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_stbd_m.stbdstus
            
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
            WHEN "J"
               HIDE OPTION "reconciliate"
            WHEN "X"
               HIDE OPTION "invalid"
         END CASE
     
      #add-point:menu前 name="statechange.before_menu"
      #add by geza 20160610(S)
      CALL cl_set_act_visible("invalid,reconciliate,confirmed,unconfirmed",TRUE)    
      CALL cl_set_act_visible("signing,withdraw",FALSE)
      CASE g_stbd_m.stbdstus
         WHEN "N"
            CALL cl_set_act_visible("confirmed,unconfirmed",FALSE)    
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            IF cl_bpm_chk() THEN
               CALL cl_set_act_visible("signing",TRUE)
               CALL cl_set_act_visible("confirmed",FALSE)
            END IF
            
         WHEN "R"    #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed,hold,reconciliate",FALSE) 
         WHEN "D"    #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed,hold,reconciliate",FALSE) 
         WHEN "X"
            CALL cl_set_act_visible("invalid,reconciliate,confirmed,unconfirmed",FALSE) 
         WHEN "Y"
            CALL cl_set_act_visible("invalid,confirmed,unconfirmed",FALSE) 
         WHEN "W"    #只能顯示抽單;其餘應用功能皆隱藏
            CALL cl_set_act_visible("withdraw",TRUE)
            CALL cl_set_act_visible("unconfirmed,invalid,confirmed,hold,reconciliate",FALSE) 
         WHEN "A"    #只能顯示確認; 其餘應用功能皆隱藏
            CALL cl_set_act_visible("confirmed",TRUE)
            CALL cl_set_act_visible("unconfirmed,invalid,hold,reconciliate",FALSE)  
         WHEN "J"    #只能顯示確認和取消对账; 其餘應用功能皆隱藏
            CALL cl_set_act_visible("confirmed,unconfirmed",TRUE)
            CALL cl_set_act_visible("reconciliate,invalid,hold",FALSE)                           
      END CASE
      #add by geza 20160610(E)
      LET l_success = TRUE
      LET g_stbd_m.stbdcnfdt=cl_get_current()
      LET g_stbd_m.stbdmoddt=cl_get_current()
      #end add-point
      
      #應用 a36 樣板自動產生(Version:5)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT astt840_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE astt840_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT astt840_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE astt840_cl
            RETURN
         END IF
 
 
 
	  
      ON ACTION unconfirmed
         IF cl_auth_chk_act("unconfirmed") THEN
            LET lc_state = "N"
            #add-point:action控制 name="statechange.unconfirmed"
            #add by geza 20160610(S)
            CALL s_transaction_begin()
            CALL s_astt840_uncash_chk(g_stbd_m.stbddocno) RETURNING l_success #,l_errno #mark by geza 20160630 #160604-00009#121
            IF NOT l_success THEN
#               INITIALIZE g_errparam TO NULL              #mark by geza 20160630 #160604-00009#121
#               LET g_errparam.code = l_errno              #mark by geza 20160630 #160604-00009#121
#               LET g_errparam.extend = g_stbd_m.stbddocno #mark by geza 20160630 #160604-00009#121 
#               LET g_errparam.popup = TRUE                #mark by geza 20160630 #160604-00009#121      
#               CALL cl_err()                              #mark by geza 20160630 #160604-00009#121
               CALL s_transaction_end('N','0')
               RETURN
            ELSE
               IF NOT cl_ask_confirm('ast-00753') THEN    
                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  CALL s_astt840_uncash_upd(g_stbd_m.stbddocno) RETURNING l_success,l_errno
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = l_errno
                     LET g_errparam.extend = g_stbd_m.stbddocno
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     RETURN
                  END IF
               END IF
            END IF
            #add by geza 20160610(E)
            #end add-point
         END IF
         EXIT MENU
      ON ACTION confirmed
         IF cl_auth_chk_act("confirmed") THEN
            LET lc_state = "Y"
            #add-point:action控制 name="statechange.confirmed"
            #add by geza 20160610(S)
            CALL s_astt840_conf_chk(g_stbd_m.stbddocno,lc_state) RETURNING l_success,l_errno         
            IF l_success THEN
               IF cl_ask_confirm('ast-00755') THEN    
                  CALL s_transaction_begin()
                  CALL s_astt840_conf_upd(g_stbd_m.stbddocno,lc_state) RETURNING l_success 
                  UPDATE stbd_t SET stbdcnfid =g_user,stbdcnfdt=g_stbd_m.stbdcnfdt,stbdstus = lc_state
                       WHERE stbdent = g_enterprise AND stbddocno = g_stbd_m.stbddocno                 
                  IF NOT l_success THEN
           
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
               LET g_errparam.code = l_errno
               LET g_errparam.extend = g_stbd_m.stbddocno
               LET g_errparam.popup = TRUE
               CALL cl_err()            
               CALL s_transaction_end('N','0')   #160816-00068#15
               RETURN            
            END IF 
            #add by geza 20160610(E)
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
      ON ACTION reconciliate
         IF cl_auth_chk_act("reconciliate") THEN
            LET lc_state = "J"
            #add-point:action控制 name="statechange.reconciliate"
            
            #end add-point
         END IF
         EXIT MENU
      ON ACTION invalid
         IF cl_auth_chk_act("invalid") THEN
            LET lc_state = "X"
            #add-point:action控制 name="statechange.invalid"
            CALL s_astt840_void_chk(g_stbd_m.stbddocno) RETURNING l_success,l_errno
            IF l_success THEN
               IF cl_ask_confirm('lib-016') THEN
                  CALL s_transaction_begin()
#                  CALL s_astt840_void_upd(g_stbd_m.stbddocno) RETURNING l_success 
#                  UPDATE stbd_t SET stbdmodid =g_user,stbdmoddt=g_stbd_m.stbdmoddt
#                       WHERE stbdent = g_enterprise AND stbddocno = g_stbd_m.stbddocno                 
#                  IF NOT l_success THEN            
#                     CALL s_transaction_end('N','0')                 
#                     RETURN
#                  ELSE
#                     #更新astq330中的状态
#                     CALL astt840_delete_updstbc() RETURNING l_success
#                     IF NOT l_success THEN
#                        CALL s_transaction_end('N','0')
#                        RETURN      
#                     END IF                     
#                     CALL s_transaction_end('Y','1')
#                  END IF
#               ELSE
#                  RETURN            
#               END IF
                 #CALL s_astt840_void_upd(g_stbd_m.stbddocno) RETURNING l_success 
                  #UPDATE stbd_t SET stbdmodid =g_user,stbdmoddt=g_stbd_m.stbdmoddt
                  #     WHERE stbdent = g_enterprise AND stbddocno = g_stbd_m.stbddocno                 
                  #IF NOT l_success THEN            
                  #   CALL s_transaction_end('N','0')                 
                  #   RETURN
                  #ELSE
                   #  IF NOT s_astt840_upd_stbc(2,
                   #                      g_stbd_m.stbddocno,g_stbd_m.stbdunit,
                   #                      g_stbe4_d[l_ac].stbe002,g_stbe4_d[l_ac].stbe003) THEN
                   #     CALL s_transaction_end('N','0')
                   #     RETURN
                   #   END IF
                    CALL astt840_delete_updstbc() RETURNING l_success
                    IF NOT l_success THEN
                       CALL s_transaction_end('N','0')
                       RETURN      
                     END IF   
                     #回写供应商合同结算账期单身
                    IF g_stbd_m.stbd039 = '2' THEN   #如果stbd039=1，不更新合同帐期
         
                        UPDATE stjo_t SET stjo005 = 'N',
                                           stjo006 = ''
                        WHERE stjoent = g_enterprise AND stjo006 = g_stbd_m.stbddocno
           
                        IF SQLCA.SQLcode THEN
                           INITIALIZE g_errparam TO NULL 
                           LET g_errparam.extend = "stjo_t" 
                           LET g_errparam.code   = SQLCA.sqlcode 
                           LET g_errparam.popup  = FALSE 
                           CALL cl_err()
                           CALL s_transaction_end('N','0')
                           RETURN
                        END IF
             
                     END If
                      IF NOT s_astp840_stbe_summary(g_stbd_m.stbddocno) THEN
                         CALL s_transaction_end('N',0)
                         RETURN
                       END IF                
                     CALL s_transaction_end('Y','1')                     
               ELSE
                  CALL s_transaction_end('N','0')   #160816-00068#15
                  RETURN            
               END IF
              
                      
           ELSE
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = l_errno
               LET g_errparam.extend = g_stbd_m.stbddocno
               LET g_errparam.popup = TRUE
               CALL cl_err()
               CALL s_transaction_end('N','0')   #160816-00068#15
               RETURN  
            end if                
            #add by geza 20160610(E)
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
      AND lc_state <> "J"
      AND lc_state <> "X"
      ) OR 
      g_stbd_m.stbdstus = lc_state OR cl_null(lc_state) THEN
      CLOSE astt840_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   #add by geza 20160610(S)
   IF lc_state = 'J' AND g_stbd_m.stbdstus = 'N' THEN
      CALL s_transaction_begin()
      CALL s_astt840_cash_chk(g_stbd_m.stbddocno) RETURNING l_success,l_errno
      IF NOT l_success THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = l_errno
         LET g_errparam.extend = g_stbd_m.stbddocno
         LET g_errparam.popup = TRUE
         CALL cl_err()
         CALL s_transaction_end('N','0')
         RETURN
      ELSE
         IF NOT cl_ask_confirm('ast-00510') THEN 
            CALL s_transaction_end('N','0')
            RETURN
         ELSE
            CALL s_astt840_cash_upd(g_stbd_m.stbddocno) RETURNING l_success,l_errno 
            IF NOT l_success THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = l_errno
               LET g_errparam.extend = g_stbd_m.stbddocno
               LET g_errparam.popup = TRUE
               CALL cl_err()
               CALL s_transaction_end('N','0')
               RETURN
            END IF
         END IF
      END IF
   END IF
   IF lc_state = 'J' AND g_stbd_m.stbdstus = 'Y' THEN
         CALL cl_err_collect_init() 
         CALL s_astt840_unconf_chk(g_stbd_m.stbddocno) RETURNING l_success      
         IF l_success THEN
            IF cl_ask_confirm('ast-00752') THEN   
               CALL s_transaction_begin()
               CALL s_astt840_unconf_upd(g_stbd_m.stbddocno) RETURNING l_success
               CALL cl_err_collect_show()           
               UPDATE stbd_t SET stbdcnfid ='',stbdcnfdt=''
                    WHERE stbdent = g_enterprise AND stbddocno = g_stbd_m.stbddocno                 
               IF NOT l_success THEN
                  CALL s_transaction_end('N','0')                 
                  RETURN
               END IF
            ELSE
               CALL s_transaction_end('N','0')   #160816-00068#15
               RETURN            
            END IF
         ELSE
            CALL cl_err_collect_show()  
            CALL s_transaction_end('N','0')   #160816-00068#15
            RETURN            
         END IF
   END IF
   #add by geza 20160610(E)
   #end add-point
   
   LET g_stbd_m.stbdmodid = g_user
   LET g_stbd_m.stbdmoddt = cl_get_current()
   LET g_stbd_m.stbdstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE stbd_t 
      SET (stbdstus,stbdmodid,stbdmoddt) 
        = (g_stbd_m.stbdstus,g_stbd_m.stbdmodid,g_stbd_m.stbdmoddt)     
    WHERE stbdent = g_enterprise AND stbddocno = g_stbd_m.stbddocno
 
    
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
         WHEN "J"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/reconciliate.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
    
      #撈取異動後的資料
      EXECUTE astt840_master_referesh USING g_stbd_m.stbddocno INTO g_stbd_m.stbdsite,g_stbd_m.stbddocdt, 
          g_stbd_m.stbddocno,g_stbd_m.stbd037,g_stbd_m.stbd002,g_stbd_m.stbd046,g_stbd_m.stbd000,g_stbd_m.stbd001, 
          g_stbd_m.stbd041,g_stbd_m.stbdunit,g_stbd_m.stbd048,g_stbd_m.stbd049,g_stbd_m.stbd050,g_stbd_m.stbd003, 
          g_stbd_m.stbd043,g_stbd_m.stbd044,g_stbd_m.stbd004,g_stbd_m.stbd005,g_stbd_m.stbd006,g_stbd_m.stbd038, 
          g_stbd_m.stbd060,g_stbd_m.stbd033,g_stbd_m.stbdstus,g_stbd_m.stbdownid,g_stbd_m.stbdowndp, 
          g_stbd_m.stbdcrtid,g_stbd_m.stbdcrtdp,g_stbd_m.stbdcrtdt,g_stbd_m.stbdmodid,g_stbd_m.stbdmoddt, 
          g_stbd_m.stbdcnfid,g_stbd_m.stbdcnfdt,g_stbd_m.stbd007,g_stbd_m.stbd052,g_stbd_m.stbd051,g_stbd_m.stbd053, 
          g_stbd_m.stbd008,g_stbd_m.stbd054,g_stbd_m.stbd009,g_stbd_m.stbd055,g_stbd_m.stbd010,g_stbd_m.stbd056, 
          g_stbd_m.stbd011,g_stbd_m.stbd057,g_stbd_m.stbd012,g_stbd_m.stbd058,g_stbd_m.stbd013,g_stbd_m.stbd059, 
          g_stbd_m.stbd014,g_stbd_m.stbd017,g_stbd_m.stbd018,g_stbd_m.stbd016,g_stbd_m.stbd019,g_stbd_m.stbd045, 
          g_stbd_m.stbd015,g_stbd_m.stbd040,g_stbd_m.stbd039,g_stbd_m.stbd020,g_stbd_m.stbd042,g_stbd_m.stbd021, 
          g_stbd_m.stbd022,g_stbd_m.stbd023,g_stbd_m.stbd024,g_stbd_m.stbd025,g_stbd_m.stbd026,g_stbd_m.stbd027, 
          g_stbd_m.stbd028,g_stbd_m.stbd029,g_stbd_m.stbd030,g_stbd_m.stbd031,g_stbd_m.stbd032,g_stbd_m.stbd034, 
          g_stbd_m.stbd035,g_stbd_m.stbd036,g_stbd_m.stbd047,g_stbd_m.stbdsite_desc,g_stbd_m.stbd037_desc, 
          g_stbd_m.stbd002_desc,g_stbd_m.stbd046_desc,g_stbd_m.stbdunit_desc,g_stbd_m.stbd049_desc,g_stbd_m.stbd050_desc, 
          g_stbd_m.stbdownid_desc,g_stbd_m.stbdowndp_desc,g_stbd_m.stbdcrtid_desc,g_stbd_m.stbdcrtdp_desc, 
          g_stbd_m.stbdmodid_desc,g_stbd_m.stbdcnfid_desc,g_stbd_m.stbd021_desc,g_stbd_m.stbd022_desc, 
          g_stbd_m.stbd023_desc,g_stbd_m.stbd025_desc,g_stbd_m.stbd030_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_stbd_m.stbdsite,g_stbd_m.stbdsite_desc,g_stbd_m.stbddocdt,g_stbd_m.stbddocno, 
          g_stbd_m.stbd037,g_stbd_m.stbd037_desc,g_stbd_m.stbd002,g_stbd_m.stbd002_desc,g_stbd_m.stbd046, 
          g_stbd_m.stbd046_desc,g_stbd_m.stbd000,g_stbd_m.stbd001,g_stbd_m.stbd041,g_stbd_m.stbdunit, 
          g_stbd_m.stbdunit_desc,g_stbd_m.stbd048,g_stbd_m.stbd048_desc,g_stbd_m.stbd049,g_stbd_m.stbd049_desc, 
          g_stbd_m.stbd050,g_stbd_m.stbd050_desc,g_stbd_m.stbd003,g_stbd_m.stbd043,g_stbd_m.stbd044, 
          g_stbd_m.stbd004,g_stbd_m.l_stjo002,g_stbd_m.stbd005,g_stbd_m.stbd006,g_stbd_m.stbd038,g_stbd_m.stbd060, 
          g_stbd_m.stbd033,g_stbd_m.stbdstus,g_stbd_m.stbdownid,g_stbd_m.stbdownid_desc,g_stbd_m.stbdowndp, 
          g_stbd_m.stbdowndp_desc,g_stbd_m.stbdcrtid,g_stbd_m.stbdcrtid_desc,g_stbd_m.stbdcrtdp,g_stbd_m.stbdcrtdp_desc, 
          g_stbd_m.stbdcrtdt,g_stbd_m.stbdmodid,g_stbd_m.stbdmodid_desc,g_stbd_m.stbdmoddt,g_stbd_m.stbdcnfid, 
          g_stbd_m.stbdcnfid_desc,g_stbd_m.stbdcnfdt,g_stbd_m.stbd007,g_stbd_m.stbd052,g_stbd_m.stbd051, 
          g_stbd_m.stbd053,g_stbd_m.stbd008,g_stbd_m.stbd054,g_stbd_m.stbd009,g_stbd_m.stbd055,g_stbd_m.stbd010, 
          g_stbd_m.stbd056,g_stbd_m.stbd011,g_stbd_m.stbd057,g_stbd_m.stbd012,g_stbd_m.stbd058,g_stbd_m.stbd013, 
          g_stbd_m.stbd059,g_stbd_m.stbd014,g_stbd_m.stbd017,g_stbd_m.stbd018,g_stbd_m.stbd016,g_stbd_m.stbd019, 
          g_stbd_m.stbd045,g_stbd_m.stbd015,g_stbd_m.stbd040,g_stbd_m.stbd039,g_stbd_m.stbd020,g_stbd_m.stbd042, 
          g_stbd_m.stbd021,g_stbd_m.stbd021_desc,g_stbd_m.stbd022,g_stbd_m.stbd022_desc,g_stbd_m.stje019, 
          g_stbd_m.stje019_desc,g_stbd_m.stje020,g_stbd_m.stje020_desc,g_stbd_m.stje021,g_stbd_m.stje021_desc, 
          g_stbd_m.stbd023,g_stbd_m.stbd023_desc,g_stbd_m.stbd024,g_stbd_m.stbd025,g_stbd_m.stbd025_desc, 
          g_stbd_m.stbd026,g_stbd_m.stbd027,g_stbd_m.stbd028,g_stbd_m.stbd029,g_stbd_m.stbd030,g_stbd_m.stbd030_desc, 
          g_stbd_m.stbd031,g_stbd_m.stbd032,g_stbd_m.stbd034,g_stbd_m.stbd035,g_stbd_m.stbd036,g_stbd_m.stbd047 
 
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE astt840_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL astt840_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="astt840.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION astt840_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_stbe_d.getLength() THEN
         LET g_detail_idx = g_stbe_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_stbe_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_stbe_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_stbe2_d.getLength() THEN
         LET g_detail_idx = g_stbe2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_stbe2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_stbe2_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 3 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail4")
      IF g_detail_idx > g_stbe4_d.getLength() THEN
         LET g_detail_idx = g_stbe4_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_stbe4_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_stbe4_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 4 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail5")
      IF g_detail_idx > g_stbe5_d.getLength() THEN
         LET g_detail_idx = g_stbe5_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_stbe5_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_stbe5_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   IF g_current_page = 5 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx > g_stbe3_d.getLength() THEN
         LET g_detail_idx = g_stbe3_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_stbe3_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_stbe3_d.getLength() TO FORMONLY.cnt
   END IF
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="astt840.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION astt840_b_fill2(pi_idx)
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
   
   CALL astt840_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="astt840.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION astt840_fill_chk(ps_idx)
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
      (cl_null(g_wc2_table2) OR g_wc2_table2.trim() = '1=1')  AND 
      (cl_null(g_wc2_table3) OR g_wc2_table3.trim() = '1=1')  AND 
      (cl_null(g_wc2_table4) OR g_wc2_table4.trim() = '1=1') THEN
      #add-point:fill_chk段other_chk name="fill_chk.other_chk"
      
      #end add-point
      RETURN TRUE
   END IF
   
   #add-point:fill_chk段after_chk name="fill_chk.after_chk"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="astt840.status_show" >}
PRIVATE FUNCTION astt840_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="astt840.mask_functions" >}
&include "erp/ast/astt840_mask.4gl"
 
{</section>}
 
{<section id="astt840.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION astt840_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
   LET g_wc2_table2 = " 1=1"
   LET g_wc2_table3 = " 1=1"
   LET g_wc2_table4 = " 1=1"
 
 
   CALL astt840_show()
   CALL astt840_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_stbd_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_stbe_d))
   CALL cl_bpm_set_detail_data("s_detail2", util.JSONArray.fromFGL(g_stbe2_d))
   CALL cl_bpm_set_detail_data("s_detail4", util.JSONArray.fromFGL(g_stbe4_d))
   CALL cl_bpm_set_detail_data("s_detail5", util.JSONArray.fromFGL(g_stbe5_d))
 
 
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
   #CALL astt840_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL astt840_ui_headershow()
   CALL astt840_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION astt840_draw_out()
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
   CALL astt840_ui_headershow()  
   CALL astt840_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="astt840.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION astt840_set_pk_array()
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
   LET g_pk_array[1].values = g_stbd_m.stbddocno
   LET g_pk_array[1].column = 'stbddocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="astt840.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="astt840.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION astt840_msgcentre_notify(lc_state)
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
   CALL astt840_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_stbd_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="astt840.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION astt840_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#41 add-S
   SELECT stbdstus  INTO g_stbd_m.stbdstus
     FROM stbd_t
    WHERE stbdent = g_enterprise
      AND stbddocno = g_stbd_m.stbddocno

   IF (g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail")  THEN
     LET g_errno = NULL
     CASE g_stbd_m.stbdstus
        WHEN 'J'
           LET g_errno = 'sub-01355'
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
        LET g_errparam.extend = g_stbd_m.stbddocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL astt840_set_act_visible()
        CALL astt840_set_act_no_visible()
        CALL astt840_show()
        RETURN FALSE
     END IF
   END IF
   #160818-00017#41 add-E
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="astt840.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 貨款匯總顯示
# Memo...........:
# Usage..........: CALL astt840_detail3_fill()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2016/4/24 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION astt840_detail3_fill()
   CALL g_stbe3_d.clear()
   
   IF g_action_choice <> 'fetch' OR cl_null(g_action_choice) THEN
      LET g_sql = "SELECT stbe001,stbe002,stbe004,stbe035,stbe036, ",   #160510-00010#8 160514 by lori add stbe035,stbe036
                  "       (SELECT ooefl003 FROM ooefl_t ",              #160510-00010#8 160514 by lori add
                  "         WHERE ooeflent = stbeent ",                 #160510-00010#8 160514 by lori add
                  "           AND ooefl001 = stbe036 ",                 #160510-00010#8 160514 by lori add
                  "           AND ooefl002 = '",g_dlang,"'), ",         #160510-00010#8 160514 by lori add
                  "       SUM(COALESCE(stbe012,0)), ",
                  "       SUM(COALESCE(stbe013,0)), ",
                  "       SUM(COALESCE(stbe014,0)), ",
                  "       SUM(COALESCE(stbe015,0)), ",
                  "       SUM(COALESCE(stbe016,0)), ",
                  "       SUM(COALESCE(stbe034,0)) ",
                  "  FROM stbe_t ",   
                  " INNER JOIN stbd_t ON stbddocno = stbedocno ",                     
                  " WHERE stbeent = ? AND stbedocno = ? ",
                  "   AND stbe001 IN ('4','5') "                        #顯示來源為:4.銷售,5.銷退                   
                  
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
    
      IF NOT cl_null(g_wc2_table1) THEN
         LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
      END IF
      
      LET g_sql = g_sql," GROUP BY stbeent,stbe001,stbe002,stbe004,stbe035,stbe036",  #160510-00010#8 160514 by lori add stbe035,stbe036                 
                        " ORDER BY stbe001 "
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
      PREPARE astt840_fill_pre3 FROM g_sql
      DECLARE astt840_fill_cur3 CURSOR FOR astt840_fill_pre3
   END IF
   
   LET l_ac = 1
   
   OPEN astt840_fill_cur3 USING g_enterprise,g_stbd_m.stbddocno
                                            
   FOREACH astt840_fill_cur3 INTO g_stbe3_d[l_ac].l_stbe001,g_stbe3_d[l_ac].l_stbe002,g_stbe3_d[l_ac].l_stbe004, 
                                  g_stbe3_d[l_ac].l_stbe035,g_stbe3_d[l_ac].l_stbe036,g_stbe3_d[l_ac].l_stbe036_desc,   #160510-00010#8 160514 by lori add
                                  g_stbe3_d[l_ac].l_stbe012,g_stbe3_d[l_ac].l_stbe013,g_stbe3_d[l_ac].l_stbe014,
                                  g_stbe3_d[l_ac].l_stbe015,g_stbe3_d[l_ac].l_stbe016,g_stbe3_d[l_ac].l_stbe034
    
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
   
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
   CALL g_stbe3_d.deleteElement(g_stbe3_d.getLength())
   FREE astt840_fill_pre3
END FUNCTION

################################################################################
# Descriptions...: 取得稅區
# Memo...........:
# Usage..........: CALL astt840_get_ooef019(p_ooef001)
#                  RETURNING r_ooef019
# Input parameter: p_ooef001      組織編號
# Return code....: r_ooef019      稅區編號
# Date & Author..: 2016/04/24 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION astt840_get_ooef019(p_ooef001)
   DEFINE p_ooef001   LIKE ooef_t.ooef001
   DEFINE r_ooef019   LIKE ooef_t.ooef019
   
   LET r_ooef019 = ''
   
   SELECT ooef019 INTO r_ooef019
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = p_ooef001

   RETURN r_ooef019
END FUNCTION

################################################################################
# Descriptions...: 取得鋪位說明
# Memo...........:
# Usage..........: CALL astt840_mhbe001_ref(p_mhbe001)
#                  RETURNING r_mhbel003
# Input parameter: p_mhbe001      鋪位編號
# Return code....: r_mhbel003     鋪位說明
# Date & Author..: 2016/04/24 By Lori 
# Modify.........:
################################################################################
PRIVATE FUNCTION astt840_mhbe001_ref(p_mhbe001)
   DEFINE p_mhbe001      LIKE mhbe_t.mhbe001
   DEFINE r_mhbel003     LIKE mhbel_t.mhbel003
   
   LET r_mhbel003 = ''
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_mhbe001
   CALL ap_ref_array2(g_ref_fields,"SELECT mhbel003 FROM mhbel_t WHERE mhbelent="||g_enterprise||" AND mhbel001=? AND mhbel002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_mhbel003 = '', g_rtn_fields[1] , ''
   
   RETURN r_mhbel003
END FUNCTION

################################################################################
# Descriptions...: 帳款供應商校驗
# Memo...........:
# Usage..........: CALL astt840_stbd002_chk()
#                  RETURNING r_success
# Input parameter: 無
# Return code....: r_success      校驗結果 TRUE/FALSE
# Date & Author..: 2016/04/24 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION astt840_stbd002_chk()
   DEFINE r_success       LIKE type_t.num5
   
   LET r_success = TRUE

   INITIALIZE g_chkparam.* TO NULL
   LET g_chkparam.arg1 = g_stbd_m.stbd002
   IF NOT cl_chk_exist("v_pmaa001_1") THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #供應商生命週期
   IF NOT s_life_cycle_chk(g_prog,g_stbd_m.stbdsite,'2',g_stbd_m.stbd002,'','') THEN
      LET r_success = FALSE
      RETURN r_success
   END IF   
   #mark by geza 20160624 #160604-00009#69(S)
#   #租賃合約檢查
#   IF NOT astt840_stje_chk() THEN
#      LET r_success = FALSE
#      RETURN r_success
#   END IF
   #mark by geza 20160624 #160604-00009#69(E)

   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 鋪位編號校驗
# Memo...........:
# Usage..........: CALL astt840_stbd037_chk()
#                  RETURNING r_success
# Input parameter: 無
# Return code....: r_success    
# Date & Author..: 2016/04/24 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION astt840_stbd037_chk()
   DEFINE r_success   LIKE type_t.num5
   DEFINE l_cnt       LIKE type_t.num5
   
   LET r_success = TRUE
   
   INITIALIZE g_chkparam.* TO NULL
   LET g_chkparam.arg1 = g_stbd_m.stbd037
   LET g_chkparam.err_str[1] = "amh-00630|",g_stbd_m.stbd037   #160513-00037#27 20160603 add by beckxie
   IF NOT cl_chk_exist("v_mhbe001") THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   LET l_cnt = 0
   SELECT COUNT(stbddocno) INTO l_cnt
     FROM stbd_t
    WHERE stbdent = g_enterprise
      AND stbddocno <> g_stbd_m.stbddocno
      AND stbdstus = 'N'   
      AND stbd037 = g_stbd_m.stbd037      
 
   IF NOT cl_null(l_cnt) AND l_cnt > 0 THEN
      #此鋪位存在未確認的結算單，不可結算！
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "ast-00670"
      LET g_errparam.extend = g_stbd_m.stbd037
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   #mark by geza 20160624 #160604-00009#69(S)
#   #租賃合約檢查
#   IF NOT astt840_stje_chk() THEN
#      LET r_success = FALSE
#      RETURN r_success   
#   END IF
   #mark by geza 20160624 #160604-00009#69(E)
   RETURN r_success 
END FUNCTION

################################################################################
# Descriptions...: 結算單項次預設值
# Memo...........:
# Usage..........: CALL astt840_stbeseq_def()
#                  RETURNING r_stbeseq
# Input parameter: 無
# Return code....: r_stbeseq 
# Date & Author..: 2016/04/24 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION astt840_stbeseq_def()
   DEFINE r_stbeseq   LIKE stbe_t.stbeseq
   
   LET r_stbeseq = NULL
   
   SELECT MAX(stbeseq) INTO r_stbeseq
     FROM stbe_t
    WHERE stbeent = g_enterprise
      AND stbedocno = g_stbd_m.stbddocno

   IF cl_null(r_stbeseq) THEN
      LET r_stbeseq = 1
   ELSE
      LET r_stbeseq = r_stbeseq + 1
   END IF  

   RETURN r_stbeseq
END FUNCTION

################################################################################
# Descriptions...: 來源單號檢查
# Memo...........:
# Usage..........: CALL astt840_stbe002_chk(p_type,p_stbe001,p_stbe002)
#                  RETURNING r_success
# Input parameter: 1. p_type      明細類型：1.貨款 2.費用 3.交款
#                  2. p_stbe001   來源類別
#                  3. p_stbe002   來源單號
# Return code....: 1. r_success   檢查結果
# Date & Author..: 2016/04/24 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION astt840_stbe002_chk(p_type,p_stbe001,p_stbe002)
   DEFINE p_type      LIKE type_t.num5
   DEFINE p_stbe001   LIKE stbe_t.stbe001
   DEFINE p_stbe002   LIKE stbe_t.stbe002
   DEFINE r_success   LIKE type_t.num5
   DEFINE l_cnt       LIKE type_t.num5
   DEFINE l_sql       STRING
   DEFINE l_errno     STRING
   
   LET r_success = TRUE
   LET l_cnt = 0
   
   INITIALIZE g_chkparam.* TO NULL
   LET g_chkparam.arg1 = g_stbd_m.stbdunit
   LET g_chkparam.arg2 = p_stbe002
   IF NOT cl_chk_exist("v_stbc004") THEN
      LET r_success = FALSE
      RETURN r_success
   END IF   
            
   LET l_sql = "SELECT COUNT(1) ",
               "  FROM stbc_t ",
               " WHERE stbcent = ",g_enterprise,
               "   AND stbc001 = '",g_stbd_m.stbd048,"' ",
               "   AND stbc003 = '",p_stbe001,"' ",
               "   AND stbc004 = '",p_stbe002,"' ",  
               "   AND stbcstus IN ('1','3') "
               
   CASE p_type    
      WHEN 1   #1.貨款 
         RETURN r_success
      WHEN 2   #2.費用
         LET l_sql = l_sql," AND stbc037 = 'Y' "
         LET l_errno = "ast-00732"    #在結算底稿中沒有符合條件的納入結算單否為Y，來源類別為費用單的資料！     
      WHEN 3   #3.交款
         LET l_sql = l_sql," AND stbc037 = 'N' "    
         LET l_errno = "ast-00404"    #在結算底稿中沒有符合條件的納入結算單否為N，來源類別為費用單的資料！     
   END CASE
   
   PREPARE astt840_cnt_stbc FROM l_sql
   EXECUTE astt840_cnt_stbc INTO l_cnt
   IF l_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = l_errno
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()   
   
      LET r_success = FALSE
      RETURN r_success   
   END IF   
      
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 取費用說明
# Memo...........:
# Usage..........: CALL astt840_stbe005_ref(p_stbe005)
#                  RETURNING r_stbe005_desc
# Input parameter: p_stbe005        費用編號
# Return code....: r_stbe005_desc   費用說明
# Date & Author..: 2016/04/24 By Lori 
# Modify.........:
################################################################################
PRIVATE FUNCTION astt840_stbe005_ref(p_stbe005)
   DEFINE p_stbe005        LIKE stbe_t.stbe005
   DEFINE r_stbe005_desc   LIKE stael_t.stael003

   LET r_stbe005_desc  = ''
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_stbe005
   CALL ap_ref_array2(g_ref_fields,"SELECT stael003 FROM stael_t WHERE staelent= "||g_enterprise||" AND stael001=? AND stael002='"||g_dlang||"'","") 
      RETURNING g_rtn_fields
   LET r_stbe005_desc = '', g_rtn_fields[1] , ''
   
   RETURN r_stbe005_desc
END FUNCTION

################################################################################
# Descriptions...: 取結算方式說明
# Memo...........:
# Usage..........: CALL astt840_stbe017_ref(p_stbe017)
#                  RETURNING r_stbe017_ref
# Input parameter: p_stbe017      結算方式
# Return code....: r_stbe017_ref  結算方式說明
# Date & Author..: 2016/04/24 By Lori 
# Modify.........:
################################################################################
PRIVATE FUNCTION astt840_stbe017_ref(p_stbe017)
    DEFINE p_stbe017       LIKE stbe_t.stbe017
    DEFINE r_stbe017_ref   LIKE staal_t.staal003
    
    LET r_stbe017_ref = ''
    
    INITIALIZE g_ref_fields TO NULL
    LET g_ref_fields[1] = p_stbe017
    CALL ap_ref_array2(g_ref_fields,"SELECT staal003 FROM staal_t WHERE staalent='"||g_enterprise||"' AND staal001=? AND staal002='"||g_dlang||"'","") RETURNING g_rtn_fields
    LET r_stbe017_ref = '', g_rtn_fields[1] , ''
    
    RETURN r_stbe017_ref
END FUNCTION

################################################################################
# Descriptions...: 租賃合約校驗
# Memo...........:
# Usage..........: CALL astt840_stje_chk()
#                  RETURNING r_success
# Input parameter: 無
# Return code....: r_success      校驗結果 TRUE/FALSE
# Date & Author..: 2016/04/24 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION astt840_stje_chk()
   DEFINE r_success    LIKE type_t.num5
   DEFINE l_cnt        LIKE type_t.num5
   DEFINE l_stje007    LIKE stje_t.stje007,
          l_stje008    LIKE stje_t.stje008 
   DEFINE l_sql        STRING
   
   LET r_success = TRUE
   LET l_sql = "SELECT COUNT(stje001) ",
               "  FROM stje_t ",
               " WHERE stjeent = ",g_enterprise,
               "   AND stjestus = 'Y'                  ",
               "   AND EXISTS(SELECT 1 FROM stjo_t     ",
               "               WHERE stjoent = stjeent ",
               "                 AND stjo001 = stje001 ",
               "                 AND stjo005 = 'N' )   "
               
   IF NOT cl_null(g_stbd_m.stbd037) THEN
      LET l_sql = l_sql, "   AND stje008 = '",g_stbd_m.stbd037,"' "   #鋪位編號 
   END IF
   #160513-00037#27 20160603 add by beckxie---S
   IF NOT cl_null(g_stbd_m.stbd002) THEN
      LET l_sql = l_sql, "   AND stje007 = '",g_stbd_m.stbd002,"' "   #商戶編號 
   END IF
   #160513-00037#27 20160603 add by beckxie---E
   IF NOT cl_null(g_stbd_m.stbd001) THEN
      LET l_sql = l_sql, "   AND stje001 = '",g_stbd_m.stbd001,"' "   #合約編號 
   END IF
   
   LET l_sql = cl_sql_add_mask(l_sql)
   PREPARE astt840_cnt_stje FROM l_sql   
   
   IF NOT cl_null(g_stbd_m.stbd037) THEN
      LET l_cnt = 0
      EXECUTE astt840_cnt_stje INTO l_cnt
      #IF NOT cl_null(l_cnt) AND l_cnt > 0 THEN   #160513-00037#27 20160603 mark by beckxie
      IF NOT cl_null(l_cnt) AND l_cnt = 0 THEN   #160513-00037#27 20160603 add by beckxie
         #鋪位未存在有效合約或該合約已結算完！
         INITIALIZE g_errparam.* TO NULL
         LET g_errparam.code = "ast-00671"
         LET g_errparam.extend = g_stbd_m.stbd037
         LET g_errparam.popup = TRUE
         CALL cl_err()
      
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF
   
   IF NOT cl_null(g_stbd_m.stbd001) THEN
      LET l_stje007 = ''
      LET l_stje008 = ''
      
      SELECT stje007,stje008 
        INTO l_stje007,l_stje008
        FROM stje_t
       WHERE stjeent = g_enterprise
         AND stje001 = g_stbd_m.stbd001

      IF NOT cl_null(g_stbd_m.stbd002) AND g_stbd_m.stbd002 <> l_stje007 THEN
         #供應商與合約內容不符！
         INITIALIZE g_errparam.* TO NULL
         LET g_errparam.code = "ast-00316"
         LET g_errparam.extend = ''
         LET g_errparam.replace[1] = g_stbd_m.stbd037
         LET g_errparam.popup = TRUE
         CALL cl_err()
         
         LET r_success = FALSE
         RETURN r_success         
      END IF
      
      IF NOT cl_null(g_stbd_m.stbd037) AND g_stbd_m.stbd037 <> l_stje008 THEN
         #鋪位編號%1與合約內容不符！
         INITIALIZE g_errparam.* TO NULL
         LET g_errparam.code = "ast-00650"
         LET g_errparam.extend = ''
         LET g_errparam.replace[1] = g_stbd_m.stbd037
         LET g_errparam.popup = TRUE
         CALL cl_err()
         
         LET r_success = FALSE
         RETURN r_success         
      END IF
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 取得結算門店(stbdsite)的相關資訊
# Memo...........:
# Usage..........: CALL astt840_get_ooef_info()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2016/04/24 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION astt840_get_ooef_info()
   LET g_ooef004 = NULL
   LET g_ooef006 = NULL
   LET g_stbd_m.stbd048 = NULL
   LET g_stbd_m.stbd048_desc = NULL
   
   SELECT ooef004,ooef006,ooef017
     INTO g_ooef004,g_ooef006,g_stbd_m.stbd048 
     FROM ooef_t
    WHERE ooefent = g_enterprise 
      AND ooef001 = g_stbd_m.stbdsite 
      AND ooefstus = 'Y'   

   LET g_stbd_m.stbd048_desc = s_desc_get_department_desc(g_stbd_m.stbd048) 
   DISPLAY BY NAME g_stbd_m.stbd048,g_stbd_m.stbd048_desc
END FUNCTION

################################################################################
# Descriptions...: 取得結算日期,會計年度,會計期別
# Memo...........:
# Usage..........: CALL astt840_get_period()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2016/04/24 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION astt840_get_period()
   DEFINE l_success      LIKE type_t.num5
   DEFINE l_stau004      LIKE stau_t.stau004
      
   LET g_stbd_m.l_stjo002 = NULL
   LET g_stbd_m.stbd043 = NULL
   LET g_stbd_m.stbd044 = NULL
   
   LET l_success = NULL
   LET l_stau004 = NULL  
   
   CALL s_astt840_get_period(g_stbd_m.stbd001,g_stbd_m.stbd004,g_stbd_m.stbdunit)
      #RETURNING g_stbd_m.l_stjo002,g_stbd_m.stbd044,g_stbd_m.l_stjo002   #160604-00009#15 20160607 mark by beckxie
      RETURNING g_stbd_m.l_stjo002,g_stbd_m.stbd043,g_stbd_m.stbd044   #160604-00009#15 20160607 add by beckxie
   
   DISPLAY BY NAME g_stbd_m.stbd043,g_stbd_m.stbd044,g_stbd_m.l_stjo002 
END FUNCTION

################################################################################
# Descriptions...: 取得租賃合約資訊
# Memo...........:
# Usage..........: CALL astt840_get_stje_info(p_type)
# Input parameter: p_type    單頭條件變更：1.合約編號 2.鋪位編號
# Return code....: 無
# Date & Author..: 2016/04/24 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION astt840_get_stje_info(p_type)
   DEFINE p_type          LIKE type_t.num5   #單頭條件變更：1.合約編號 2.鋪位編號
   DEFINE l_sel_sql       STRING
   DEFINE l_cnt_sql       STRING
   DEFINE l_cnt           LIKE type_t.num5   
   
   CASE p_type    #單頭條件變更
      WHEN 1      #1.合約編號
         LET g_stbd_m.stbd037 = NULL
      WHEN 2      #2.鋪位編號
         LET g_stbd_m.stbd001 = NULL
   END CASE
   
   LET g_stbd_m.stbd002 = NULL
   LET g_stbd_m.stbd004 = NULL
   LET g_stbd_m.stbd005 = NULL
   LET g_stbd_m.stbd006 = NULL 
   LET g_stbd_m.stbd038 = NULL 
   LET g_stbd_m.stbd041 = NULL
   LET g_stbd_m.stbd042 = NULL
   LET g_stbd_m.stbd046 = NULL
   LET g_stbd_m.stbd049 = NULL
   LET g_stbd_m.stbd050 = NULL
   LET g_stbd_m.stbdunit = NULL

   LET l_sel_sql = "SELECT stje001,stje005,stje007,stje008,  ",           #合約編號,合約狀態,供應商編號,鋪位編號
                   "       stje027,stje029,stje040,stje030,  ",           #管理品類,主品牌,含發票否,結算組織
                   "       stjoseq,stjo003,stjo004 ",                     #結算帳期,起始日期,結束日期
                   "  FROM stje_t ",
                   "       LEFT JOIN stjo_t t1  ON t1.stjoent = stjeent ",
                   "                           AND t1.stjo001 = stje001 ",           
                   "                           AND t1.stjoseq = (SELECT MIN(stjoseq)            ", 
                   "                                               FROM stjo_t t2               ",
                   "                                              WHERE t2.stjoent = t1.stjoent ",
                   "                                                AND t2.stjo001 = t1.stjo001 ",
                   "                                                AND t2.stjo005 = 'N')       ",
                   "                           AND t1.stjo007 = (SELECT MAX(stjo007)            ",
                   "                                               FROM stjo_t t3               ",
                   "                                              WHERE t3.stjoent = t1.stjoent ",
                   "                                                AND t3.stjo001 = t1.stjo001 ",
                   "                                                AND t3.stjo005 = 'N')       ",
                   " WHERE stjeent = ",g_enterprise,
                   "   AND stje004 = '",g_stbd_m.stbd003,"' ",   #經營方式
                   "   AND stjo005 = 'N'",
                   "   AND stjestus = 'Y' "

   IF NOT cl_null(g_stbd_m.stbd001) THEN
      LET l_sel_sql = l_sel_sql, " AND stje001 = '",g_stbd_m.stbd001,"' "   #合約編號 
   END IF

   IF NOT cl_null(g_stbd_m.stbd002) THEN
      LET l_sel_sql = l_sel_sql, " AND stje007 = '",g_stbd_m.stbd002,"' "   #商戶編號 
   END IF
   
   IF NOT cl_null(g_stbd_m.stbd037) THEN
      LET l_sel_sql = l_sel_sql, " AND stje008 = '",g_stbd_m.stbd037,"' "   #鋪位編號
   END IF

   LET l_sel_sql = cl_sql_add_mask(l_sel_sql)
   PREPARE astt840_sel_stje FROM l_sel_sql  
  #DISPLAY "[astt840_sel_stje]SQL: ",l_sel_sql
  
   LET l_cnt_sql =  " SELECt COUNT(1) FROM ( ",l_sel_sql," )"   
   PREPARE astt840_cnt_stje_2 FROM l_cnt_sql 
   
   LET l_cnt = 0
   EXECUTE astt840_cnt_stje_2 INTO l_cnt
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam.* TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
         
      RETURN
   END IF

   IF l_cnt = 1 THEN
      EXECUTE astt840_sel_stje INTO g_stbd_m.stbd001, g_stbd_m.stbd041, g_stbd_m.stbd002, g_stbd_m.stbd037,   #合約編號,合約狀態,帳款供應商編號,鋪位編號
                                    g_stbd_m.stbd049, g_stbd_m.stbd050, g_stbd_m.stbd042, g_stbd_m.stbdunit,  #管理品類,品牌,含發票否,結算中心
                                    g_stbd_m.stbd004, g_stbd_m.stbd005, g_stbd_m.stbd006                      #結算帳期,起始日期,結束日期
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam.* TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
            
         RETURN
      END IF
      
      IF NOT cl_null(g_stbd_m.stbd002) THEN
         SELECT pmac002 INTO g_stbd_m.stbd046
           FROM pmac_t
          WHERE pmacent = g_enterprise
            AND pmac001 = g_stbd_m.stbd002
            AND pmac003 = '1'
            AND pmac004 = 'Y'      
            AND pmacstus = 'Y'            
      END IF

      #預估應付日
      LET g_stbd_m.stbd038 = s_astt840_get_stbd038(g_stbd_m.stbd001,g_stbd_m.stbd006)
      
      #取得結算日期, 會計年度, 會計期別
      CALL astt840_get_period()

      DISPLAY BY NAME g_stbd_m.stbd001,g_stbd_m.stbd041,g_stbd_m.stbd002, g_stbd_m.stbd037,                               
                      g_stbd_m.stbd049,g_stbd_m.stbd050,g_stbd_m.stbd042,g_stbd_m.stbdunit,                                 
                      g_stbd_m.stbd004,g_stbd_m.stbd005,g_stbd_m.stbd006 , g_stbd_m.stbd038
                      
      LET g_stbd_m.stbd002_desc  = s_desc_get_trading_partner_abbr_desc(g_stbd_m.stbd002)
      LET g_stbd_m.stbd037_desc  = astt840_mhbe001_ref(g_stbd_m.stbd037) 
      LET g_stbd_m.stbd046_desc  = s_desc_get_trading_partner_abbr_desc(g_stbd_m.stbd046)
      LET g_stbd_m.stbd049_desc  = s_desc_get_rtaxl003_desc(g_stbd_m.stbd049) 
      LET g_stbd_m.stbd050_desc  = s_desc_get_acc_desc('2002',g_stbd_m.stbd050) 
      LET g_stbd_m.stbdunit_desc = s_desc_get_department_desc(g_stbd_m.stbdunit)      

      DISPLAY BY NAME g_stbd_m.stbd002_desc,g_stbd_m.stbd037_desc,g_stbd_m.stbd049_desc,
                      g_stbd_m.stbd046_desc,g_stbd_m.stbd050_desc
      
      LET g_stbd_m_o.stbd001  = g_stbd_m.stbd001
      LET g_stbd_m_o.stbd002  = g_stbd_m.stbd002
      LET g_stbd_m_o.stbd004  = g_stbd_m.stbd004
      LET g_stbd_m_o.stbd005  = g_stbd_m.stbd005
      LET g_stbd_m_o.stbd006  = g_stbd_m.stbd006
      LET g_stbd_m_o.stbd037  = g_stbd_m.stbd037 
      LET g_stbd_m_o.stbd038  = g_stbd_m.stbd038 
      LET g_stbd_m_o.stbd041  = g_stbd_m.stbd041
      LET g_stbd_m_o.stbd042  = g_stbd_m.stbd042
      LET g_stbd_m_o.stbd043  = g_stbd_m.stbd043
      LET g_stbd_m_o.stbd044  = g_stbd_m.stbd044
      LET g_stbd_m_o.stbd046  = g_stbd_m.stbd046
      LET g_stbd_m_o.stbd049  = g_stbd_m.stbd049
      LET g_stbd_m_o.stbd050  = g_stbd_m.stbd050
      LET g_stbd_m_o.stbdunit = g_stbd_m.stbdunit
      
      IF cl_null(g_stbd_m.stbd048) THEN
         CALL astt840_get_ooef_info()
      END IF      
   END IF
                                   
END FUNCTION

################################################################################
# Descriptions...: 取得結算底稿相關資料
# Memo...........:
# Usage..........: CALL astt840_stbe_def(p_page)
#                     RETURNING r_success
# Input parameter: p_age     頁簽:1.貨款明細 2.費用明細 3.交款明細
# Return code....: 無
# Date & Author..: 2016/04/17 By Lori
# Modify.........: 2016/05/14 By Lori      #結算底稿增加欄位:費用歸屬類,費用歸屬組織
################################################################################
PRIVATE FUNCTION astt840_stbe_def(p_page)
   DEFINE p_page         LIKE type_t.num5
   DEFINE r_success      LIKE type_t.num5
   DEFINE l_success      LIKE type_t.num5
   DEFINE l_para         LIKE type_t.chr30
   DEFINE l_ooef017      LIKE ooef_t.ooef017,
          l_ooef019      LIKE ooef_t.ooef019
   DEFINE l_stbe002      LIKE stbe_t.stbe002,
          l_stbe003      LIKE stbe_t.stbe003         
   DEFINE l_stbc         g_type_stbc
                         
   LET r_success = TRUE
   LET l_success = ''
   LET l_para = ''   
   LET l_ooef017 = ''
   LET l_ooef019 = ''
   LET l_stbe002 = ''
   LET l_stbe003 = ''
   
   CASE p_page
      WHEN 1   #貨款
         LET l_stbe002 = g_stbe_d[l_ac].stbe002
         LET l_stbe003 = g_stbe_d[l_ac].stbe003                 
      WHEN 2   #費用
         LET l_stbe002 = g_stbe4_d[l_ac].stbe002
         LET l_stbe003 = g_stbe4_d[l_ac].stbe003 
      WHEN 3   #交款
         LET l_stbe002 = g_stbe5_d[l_ac].stbe002
         LET l_stbe003 = g_stbe5_d[l_ac].stbe003 
   END CASE
   
   INITIALIZE l_stbc.* TO NULL
   
   LET l_para = cl_get_para(g_enterprise,g_site,"S-CIR-2012")   
   CALL s_astp840_stbc('N',               3,                 l_para,               #是否為批次作業,處理類型,是否啟用交款匯總        #160513-00037#12 160524 by lori 加傳第一個參數
                       g_stbd_m.stbdsite, g_stbd_m.stbdunit, l_stbe002,            #結算組織,結算中心,來源單據編號
                       l_stbe003,         g_stbd_m.stbd003,  g_stbd_m.stbd001,     #來源單據項次,經營方式,合約編號
                       g_stbd_m.stbd037,  '',                g_stbd_m.l_stjo002,   #鋪位編號,納入結算單否,結算日期     
                       '',                '')                                      #結算單號/匯總單號,批次處理條件
      RETURNING l_success,l_stbc.*
      
   IF NOT l_success THEN
      LET r_success = FALSE
      RETURN r_success
   ELSE
      IF cl_null(l_stbc.stbc005) THEN 
         RETURN r_success
      END IF   
   END IF   
   
   IF NOT cl_null(l_stbc.stbcsite) THEN
      SELECT ooef017 ,ooef019
        INTO l_ooef017 , l_ooef019
        FROM ooef_t
       WHERE ooefent = g_enterprise
         AND ooef001 = l_stbc.stbcsite       
   END IF
   
   CASE p_page
     WHEN 1   #貨款明細
        LET g_stbe_d[l_ac].stbesite =  l_stbc.stbcsite   #營運據點
        LET g_stbe_d[l_ac].stbecomp =  l_ooef017         #所屬法人
        
        IF cl_null(g_stbe_d[l_ac].stbe001) THEN
           LET g_stbe_d[l_ac].stbe003  =  l_stbc.stbc003 #來源類別
        END IF
        
        LET g_stbe_d[l_ac].stbe003  =  l_stbc.stbc005    #來源項次
        LET g_stbe_d[l_ac].stbe004  =  l_stbc.stbc002    #來源日期
        LET g_stbe_d[l_ac].stbe005  =  l_stbc.stbc012    #費用編號
        LET g_stbe_d[l_ac].stbe006  =  l_stbc.stbc045    #起始日期
        LET g_stbe_d[l_ac].stbe007  =  l_stbc.stbc046    #截止日期
        LET g_stbe_d[l_ac].stbe008  =  l_stbc.stbc013    #幣別
        LET g_stbe_d[l_ac].stbe009  =  l_stbc.stbc014    #稅別
        LET g_stbe_d[l_ac].stbe010  =  l_stbc.stbc015    #價款類別
        LET g_stbe_d[l_ac].stbe011  =  l_stbc.stbc016    #方向
        LET g_stbe_d[l_ac].stbe012  =  l_stbc.stbc017    #價外金額
        LET g_stbe_d[l_ac].stbe013  =  l_stbc.stbc018    #價內金額
        LET g_stbe_d[l_ac].stbe014  =  l_stbc.stbc019    #未結算金額
        LET g_stbe_d[l_ac].stbe015  =  l_stbc.stbc020    #已結算金額
        LET g_stbe_d[l_ac].stbe016  =  l_stbc.stbc019    #本次結算金額
        LET g_stbe_d[l_ac].stbe017  =  l_stbc.stbc010    #結算方式
        LET g_stbe_d[l_ac].stbe018  =  l_stbc.stbc011    #結算類型
        LET g_stbe_d[l_ac].stbe019  =  l_stbc.stbc025    #所屬品類
        LET g_stbe_d[l_ac].stbe020  =  l_stbc.stbc026    #所屬部門
        LET g_stbe_d[l_ac].stbe021  =  l_stbc.stbc049    #主帳套帳款金額
        LET g_stbe_d[l_ac].stbe022  =  l_stbc.stbc050    #次帳套一帳款金額
        LET g_stbe_d[l_ac].stbe023  =  l_stbc.stbc051    #次帳套二帳款金額
        LET g_stbe_d[l_ac].stbe024  =  l_stbc.stbc037    #納入結算單否
        LET g_stbe_d[l_ac].stbe025  =  l_stbc.stbc038    #票扣否
        LET g_stbe_d[l_ac].stbe026  =  l_stbc.stbc034    #數量
        LET g_stbe_d[l_ac].stbe027  =  l_stbc.stbc036    #單價
        LET g_stbe_d[l_ac].stbe028  =  l_stbc.stbc033    #鋪位編號
        LET g_stbe_d[l_ac].stbe031  =  l_stbc.stbc039    #結算扣率
        LET g_stbe_d[l_ac].stbe033  =  l_stbc.stbc041    #日結成本類型
        LET g_stbe_d[l_ac].stbe034  =  l_stbc.stbc042    #銷售金額
        
        #160510-00010#8 160514 by lori add---(E)  
        LET g_stbe_d[l_ac].stbe035  =  l_stbc.stbc059    #費用歸屬類型   
        LET g_stbe_d[l_ac].stbe036  =  l_stbc.stbc060    #費用歸屬組織 
        
        IF l_stbc.stbc059 = '1' AND cl_null(l_stbc.stbc060) THEN
           LET g_stbe_d[l_ac].stbe036 = g_site
        END IF        
        #160510-00010#8 160514 by lori add---(E)  

        LET g_stbe_d[l_ac].stbesite_desc = s_desc_get_department_desc(g_stbe_d[l_ac].stbesite)   
        LET g_stbe_d[l_ac].stbe005_desc  = astt840_stbe005_ref(g_stbe_d[l_ac].stbe005)             #費用編號
        LET g_stbe_d[l_ac].stbe008_desc  = s_desc_get_currency_desc(g_stbe_d[l_ac].stbe008)        #幣別
        LET g_stbe_d[l_ac].stbe009_desc  = s_desc_get_tax_desc(l_ooef019,g_stbe_d[l_ac].stbe009)   #稅別
        LET g_stbe_d[l_ac].stbe019_desc  = s_desc_get_rtaxl003_desc(g_stbe_d[l_ac].stbe019)        #所屬品類
        LET g_stbe_d[l_ac].stbe020_desc = s_desc_get_department_desc(g_stbe_d[l_ac].stbe020)       #所屬部門 
        LET g_stbe_d[l_ac].stbe017_desc  = astt840_stbe017_ref(g_stbe_d[l_ac].stbe017)             #結算方式
        LET g_stbe_d[l_ac].stbe028_desc  = astt840_mhbe001_ref(g_stbe_d[l_ac].stbe028)             #鋪位編號
        LET g_stbe_d[l_ac].stbe036_desc  = s_desc_get_department_desc(g_stbe_d[l_ac].stbe036)      #費用歸屬組織  #160510-00010#8 160514 by lori add 
       #LET g_stbe_d[l_ac].l_stae003     = #費用總類
   
        LET g_stbe_d_o.* = g_stbe_d[l_ac].*
        
     WHEN 2   #費用明細
        LET g_stbe4_d[l_ac].stbesite =  l_stbc.stbcsite   #營運據點
        LET g_stbe4_d[l_ac].stbecomp =  l_ooef017         #所屬法人
        
        IF cl_null(g_stbe4_d[l_ac].stbe001) THEN
           LET g_stbe4_d[l_ac].stbe003  =  l_stbc.stbc003 #來源類別
        END IF
        
        LET g_stbe4_d[l_ac].stbe003  =  l_stbc.stbc005    #來源項次
        LET g_stbe4_d[l_ac].stbe004  =  l_stbc.stbc002    #來源日期
        LET g_stbe4_d[l_ac].stbe005  =  l_stbc.stbc012    #費用編號
        LET g_stbe4_d[l_ac].stbe006  =  l_stbc.stbc045    #起始日期
        LET g_stbe4_d[l_ac].stbe007  =  l_stbc.stbc046    #截止日期
        LET g_stbe4_d[l_ac].stbe008  =  l_stbc.stbc013    #幣別
        LET g_stbe4_d[l_ac].stbe009  =  l_stbc.stbc014    #稅別
        LET g_stbe4_d[l_ac].stbe010  =  l_stbc.stbc015    #價款類別
        LET g_stbe4_d[l_ac].stbe011  =  l_stbc.stbc016    #方向
        LET g_stbe4_d[l_ac].stbe012  =  l_stbc.stbc017    #價外金額
        LET g_stbe4_d[l_ac].stbe013  =  l_stbc.stbc018    #價內金額
        LET g_stbe4_d[l_ac].stbe014  =  l_stbc.stbc019    #未結算金額
        LET g_stbe4_d[l_ac].stbe015  =  l_stbc.stbc020    #已結算金額
        LET g_stbe4_d[l_ac].stbe016  =  l_stbc.stbc019    #本次結算金額
        LET g_stbe4_d[l_ac].stbe017  =  l_stbc.stbc010    #結算方式
        LET g_stbe4_d[l_ac].stbe018  =  l_stbc.stbc011    #結算類型
        LET g_stbe4_d[l_ac].stbe019  =  l_stbc.stbc025    #所屬品類
        LET g_stbe4_d[l_ac].stbe020  =  l_stbc.stbc026    #所屬部門
        LET g_stbe4_d[l_ac].stbe021  =  l_stbc.stbc049    #主帳套帳款金額
        LET g_stbe4_d[l_ac].stbe022  =  l_stbc.stbc050    #次帳套一帳款金額
        LET g_stbe4_d[l_ac].stbe023  =  l_stbc.stbc051    #次帳套二帳款金額
        LET g_stbe4_d[l_ac].stbe024  =  l_stbc.stbc037    #納入結算單否
        LET g_stbe4_d[l_ac].stbe025  =  l_stbc.stbc038    #票扣否
        LET g_stbe4_d[l_ac].stbe026  =  l_stbc.stbc034    #數量
        LET g_stbe4_d[l_ac].stbe027  =  l_stbc.stbc036    #單價
        LET g_stbe4_d[l_ac].stbe028  =  l_stbc.stbc033    #鋪位編號
        LET g_stbe4_d[l_ac].stbe031  =  l_stbc.stbc039    #結算扣率
        LET g_stbe4_d[l_ac].stbe033  =  l_stbc.stbc041    #日結成本類型
        LET g_stbe4_d[l_ac].stbe034  =  l_stbc.stbc042    #銷售金額
        #160510-00010#8 160514 by lori add---(S)
        LET g_stbe4_d[l_ac].stbe035  =  l_stbc.stbc059    #費用歸屬類型   
        LET g_stbe4_d[l_ac].stbe036  =  l_stbc.stbc060    #費用歸屬組織     
        
        IF l_stbc.stbc059 = '1' AND cl_null(l_stbc.stbc060) THEN
           LET g_stbe_d[l_ac].stbe036 = g_site
        END IF
        #160510-00010#8 160514 by lori add---(E)
        
        LET g_stbe4_d[l_ac].stbesite_1_desc  = s_desc_get_department_desc(g_stbe4_d[l_ac].stbesite)   
        LET g_stbe4_d[l_ac].stbe005_1_desc   = astt840_stbe005_ref(g_stbe4_d[l_ac].stbe005)             #費用編號
        LET g_stbe4_d[l_ac].stbe008_1_desc   = s_desc_get_currency_desc(g_stbe4_d[l_ac].stbe008)        #幣別
        LET g_stbe4_d[l_ac].stbe009_1_desc   = s_desc_get_tax_desc(l_ooef019,g_stbe4_d[l_ac].stbe009)   #稅別
        LET g_stbe4_d[l_ac].stbe017_1_desc   = astt840_stbe017_ref(g_stbe4_d[l_ac].stbe017)             #結算方式
        LET g_stbe4_d[l_ac].stbe019_1_desc   = s_desc_get_rtaxl003_desc(g_stbe4_d[l_ac].stbe019)        #所屬品類
        LET g_stbe4_d[l_ac].stbe020_1_desc  = s_desc_get_department_desc(g_stbe4_d[l_ac].stbe020)       #所屬部門   
        LET g_stbe4_d[l_ac].stbe028_1_desc   = astt840_mhbe001_ref(g_stbe4_d[l_ac].stbe028)             #鋪位編號
        LET g_stbe4_d[l_ac].stbe036_1_desc   = s_desc_get_department_desc(g_stbe4_d[l_ac].stbe036)      #費用歸屬組織   #160510-00010#8 160514 by lori add
       #LET g_stbe4_d[l_ac].l_stae003_1      = #費用總類
                 
        LET g_stbe4_d_o.* = g_stbe4_d[l_ac].*
        
     WHEN 3   #交款明細 
        LET g_stbe5_d[l_ac].stbesite =  l_stbc.stbcsite   #營運據點
        LET g_stbe5_d[l_ac].stbecomp =  l_ooef017         #所屬法人
        
        IF cl_null(g_stbe5_d[l_ac].stbe001) THEN
           LET g_stbe5_d[l_ac].stbe003  =  l_stbc.stbc003 #來源類別
        END IF
        
        LET g_stbe5_d[l_ac].stbe003  =  l_stbc.stbc005    #來源項次
        LET g_stbe5_d[l_ac].stbe004  =  l_stbc.stbc002    #來源日期
        LET g_stbe5_d[l_ac].stbe005  =  l_stbc.stbc012    #費用編號
        LET g_stbe5_d[l_ac].stbe006  =  l_stbc.stbc045    #起始日期
        LET g_stbe5_d[l_ac].stbe007  =  l_stbc.stbc046    #截止日期
        LET g_stbe5_d[l_ac].stbe008  =  l_stbc.stbc013    #幣別
        LET g_stbe5_d[l_ac].stbe009  =  l_stbc.stbc014    #稅別
        LET g_stbe5_d[l_ac].stbe010  =  l_stbc.stbc015    #價款類別
        LET g_stbe5_d[l_ac].stbe011  =  l_stbc.stbc016    #方向
        LET g_stbe5_d[l_ac].stbe012  =  l_stbc.stbc017    #價外金額
        LET g_stbe5_d[l_ac].stbe013  =  l_stbc.stbc018    #價內金額
        LET g_stbe5_d[l_ac].stbe014  =  l_stbc.stbc019    #未結算金額
        LET g_stbe5_d[l_ac].stbe015  =  l_stbc.stbc020    #已結算金額
        LET g_stbe5_d[l_ac].stbe016  =  l_stbc.stbc019    #本次結算金額
        LET g_stbe5_d[l_ac].stbe017  =  l_stbc.stbc010    #結算方式
        LET g_stbe5_d[l_ac].stbe018  =  l_stbc.stbc011    #結算類型
        LET g_stbe5_d[l_ac].stbe019  =  l_stbc.stbc025    #所屬品類
        LET g_stbe5_d[l_ac].stbe020  =  l_stbc.stbc026    #所屬部門
        LET g_stbe5_d[l_ac].stbe021  =  l_stbc.stbc049    #主帳套帳款金額
        LET g_stbe5_d[l_ac].stbe022  =  l_stbc.stbc050    #次帳套一帳款金額
        LET g_stbe5_d[l_ac].stbe023  =  l_stbc.stbc051    #次帳套二帳款金額
        LET g_stbe5_d[l_ac].stbe024  =  l_stbc.stbc037    #納入結算單否
        LET g_stbe5_d[l_ac].stbe025  =  l_stbc.stbc038    #票扣否
        LET g_stbe5_d[l_ac].stbe026  =  l_stbc.stbc034    #數量
        LET g_stbe5_d[l_ac].stbe027  =  l_stbc.stbc036    #單價
        LET g_stbe5_d[l_ac].stbe028  =  l_stbc.stbc033    #鋪位編號
        LET g_stbe5_d[l_ac].stbe031  =  l_stbc.stbc039    #結算扣率
        LET g_stbe5_d[l_ac].stbe033  =  l_stbc.stbc041    #日結成本類型
        LET g_stbe5_d[l_ac].stbe034  =  l_stbc.stbc042    #銷售金額
        LET g_stbe5_d[l_ac].stbe035  =  l_stbc.stbc059    #費用歸屬類型   #160510-00010#8 160514 by lori add
        LET g_stbe5_d[l_ac].stbe036  =  l_stbc.stbc060    #費用歸屬組織   #160510-00010#8 160514 by lori add  
                 
        LET g_stbe5_d[l_ac].stbesite_2_desc = s_desc_get_department_desc(g_stbe5_d[l_ac].stbesite)   
        LET g_stbe5_d[l_ac].stbe005_2_desc  = astt840_stbe005_ref(g_stbe5_d[l_ac].stbe005)             #費用編號
        LET g_stbe5_d[l_ac].stbe008_2_desc  = s_desc_get_currency_desc(g_stbe5_d[l_ac].stbe008)        #幣別
        LET g_stbe5_d[l_ac].stbe009_2_desc  = s_desc_get_tax_desc(l_ooef019,g_stbe5_d[l_ac].stbe009)   #稅別
        LET g_stbe5_d[l_ac].stbe017_2_desc  = astt840_stbe017_ref(g_stbe5_d[l_ac].stbe017)             #結算方式
        LET g_stbe5_d[l_ac].stbe019_2_desc   = s_desc_get_rtaxl003_desc(g_stbe5_d[l_ac].stbe019)       #所屬品類
        LET g_stbe5_d[l_ac].stbe020_2_desc = s_desc_get_department_desc(g_stbe5_d[l_ac].stbe020)       #所屬部門
        LET g_stbe5_d[l_ac].stbe028_2_desc  = astt840_mhbe001_ref(g_stbe5_d[l_ac].stbe028)             #鋪位編號
        LET g_stbe5_d[l_ac].stbe036_2_desc  = s_desc_get_department_desc(g_stbe5_d[l_ac].stbe036)      #費用歸屬組織
       #LET g_stbe5_d[l_ac].l_stae003_2     = #費用總類
                 
        LET g_stbe5_d_o.* = g_stbe5_d[l_ac].*     
   END CASE
   
   RETURN r_success
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
PRIVATE FUNCTION astt840_invoice_mod()
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
   DEFINE  l_success            LIKE type_t.num5
   DEFINE  l_errno               STRING
   DEFINE  l_seq                 LIKE type_t.num5
   define  l_ooef019             like ooef_t.ooef019
   DEFINE  l_desc                LIKE type_t.chr80
   define  l_glaacomp            like glaa_t.glaacomp,
           l_glaald              like glaa_t.glaald,
           l_glaa001             like glaa_t.glaa001,
           l_glaa025             like glaa_t.glaa025,
           l_oodb005             like oodb_t.oodb005,
           l_oodb006             like oodb_t.oodb006,
           l_oodb011             like oodb_t.oodb011,
           l_ooef017             like ooef_t.ooef017,
           l_sum1,l_sum2,l_sum3  like type_t.num5
   #end add-point  
   
   #add-point:Function前置處理  name="input.pre_function"
#   #抓取稅區
#   SELECT ooef019 INTO l_ooef019
#     FROM ooef_t
#    WHERE ooefent = g_enterprise
#      AND ooef001 = g_stbd_m.stbdcomp
#   #end add-point
   
   IF g_stbd_m.stbddocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   #先做狀態判定
   IF p_cmd = 'r' THEN
      LET l_cmd_t = 'r'
      LET p_cmd   = 'a'
   ELSE
      LET l_cmd_t = p_cmd
   END IF   
      #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF
 
   CALL cl_set_head_visible("","YES")  
 
   LET l_insert = FALSE
   LET g_action_choice = ""
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i' 

   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   LET g_errshow = 1
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         INPUT ARRAY g_stbe2_d FROM s_detail2.*
             ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                     INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
        
                     DELETE ROW = l_allow_delete,
                     APPEND ROW = l_allow_insert)
                     
             #自訂ACTION(detail_input,page_2)
             
             
             BEFORE INPUT
                #add-point:資料輸入前 name="input.body2.before_input2"
        
                #end add-point
                IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
                  CALL FGL_SET_ARR_CURR(g_stbe2_d.getLength()+1) 
                  LET g_insert = 'N' 
               END IF 
        
                CALL astt840_b_fill()
                #如果一直都在單身1則控制筆數位置
                IF g_loc = 'd' AND g_rec_b != 0 THEN
                   CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2',"))
                END IF
                LET g_loc = 'd'
                LET g_rec_b = g_stbe2_d.getLength()
                #add-point:資料輸入前 name="input.body2.before_input"
        
                #end add-point
                
             BEFORE INSERT
                IF s_transaction_chk("N",0) THEN
                   CALL s_transaction_begin()
                END IF
                LET l_insert = TRUE
                LET l_n = ARR_COUNT()
                LET l_cmd = 'a'
                INITIALIZE g_stbe2_d[l_ac].* TO NULL 
                INITIALIZE g_stbe2_d_t.* TO NULL 
                INITIALIZE g_stbe2_d_o.* TO NULL 
                #公用欄位給值(單身2)
                
                #自定義預設值(單身2)
                LET g_stbe2_d[l_ac].stbf006 = "0"
                LET g_stbe2_d[l_ac].stbf007 = "0"
                LET g_stbe2_d[l_ac].stbf008 = "0"
                
                SELECT glaald,glaa001,glaa025,glaacomp INTO l_glaald,g_stbe2_d[l_ac].stbf009,l_glaa025,l_glaacomp
                  FROM glaa_t 
                 WHERE glaaent=g_enterprise 
                   AND glaacomp=l_ooef017
                   AND glaa014='Y'
                CALL s_aooi160_get_exrate('2',l_glaald,g_stbe2_d[l_ac].stbf003,g_stbe2_d[l_ac].stbf009,g_stbe2_d[l_ac].stbf009,0,l_glaa025)
                     RETURNING g_stbe2_d[l_ac].stbf010
                DISPLAY BY NAME g_stbe2_d[l_ac].stbf010,g_stbe2_d[l_ac].stbf009
        
                #add-point:modify段before備份 name="input.body2.insert.before_bak"
                #項次
                SELECT MAX(stbfseq) INTO l_seq
                  FROM stbf_t
                 WHERE stbfent = g_enterprise
                   AND stbfdocno = g_stbd_m.stbddocno
               
                IF cl_null(l_seq) THEN
                   LET l_seq = 1
                ELSE
                   LET l_seq = l_seq + 1
                END IF              
                
                LET g_stbe2_d[l_ac].stbfseq = l_seq
                #end add-point
                LET g_stbe2_d_t.* = g_stbe2_d[l_ac].*     #新輸入資料
                LET g_stbe2_d_o.* = g_stbe2_d[l_ac].*     #新輸入資料
                CALL cl_show_fld_cont()
                CALL astt840_set_entry_b(l_cmd)
                #add-point:modify段after_set_entry_b name="input.body2.insert.after_set_entry_b"
        
                #end add-point
                CALL astt840_set_no_entry_b(l_cmd)
                IF lb_reproduce THEN
                   LET lb_reproduce = FALSE
                   LET g_stbe2_d[li_reproduce_target].* = g_stbe2_d[li_reproduce].*
        
                   LET g_stbe2_d[li_reproduce_target].stbfseq = NULL
                END IF
                
                #add-point:modify段before insert name="input.body2.before_insert"
        
                #end add-point  
        
             BEFORE ROW     
               #add-point:modify段before row2 name="input.body2.before_row2"                
               # CALL s_tax_chk(l_glaacomp,g_stbe2_d[l_ac].stbf004) RETURNING g_sub_success,l_desc,l_oodb005,l_oodb006,l_oodb011
                LET l_insert = FALSE
                LET l_cmd = ''
                LET l_ac_t = l_ac 
                LET g_detail_idx_list[2] = l_ac
                LET l_ac = ARR_CURR()
                LET g_detail_idx = l_ac
                LET g_current_page = 2
                
                SELECT ooef017,ooef019 INTO l_ooef017,l_ooef019
                  FROM ooef_t 
                 WHERE ooefent=g_enterprise 
                   AND ooef001=g_stbd_m.stbdsite
                SELECT glaald,glaa001,glaa025,glaacomp INTO l_glaald,g_stbe2_d[l_ac].stbf009,l_glaa025,l_glaacomp
                  FROM glaa_t 
                 WHERE glaaent=g_enterprise 
                   AND glaacomp=l_ooef017
                   AND glaa014='Y'
                CALL s_aooi160_get_exrate('2',l_glaald,g_stbe2_d[l_ac].stbf003,g_stbe2_d[l_ac].stbf009,g_stbe2_d[l_ac].stbf009,0,l_glaa025)
                     RETURNING g_stbe2_d[l_ac].stbf010
                DISPLAY BY NAME g_stbe2_d[l_ac].stbf010,g_stbe2_d[l_ac].stbf009
                
                LET l_lock_sw = 'N'            #DEFAULT
                LET l_n = ARR_COUNT()
                DISPLAY l_ac TO FORMONLY.idx
             
                CALL s_transaction_begin()
                OPEN astt840_cl USING g_enterprise,g_stbd_m.stbddocno
                IF STATUS THEN
                   INITIALIZE g_errparam TO NULL 
                   LET g_errparam.extend = "OPEN astt840_cl:" 
                   LET g_errparam.code   = STATUS 
                   LET g_errparam.popup  = TRUE 
                   CALL cl_err()
                   CLOSE astt840_cl
                   CALL s_transaction_end('N','0')
                   RETURN
                END IF
                
                LET g_rec_b = g_stbe2_d.getLength()
                
                IF g_rec_b >= l_ac 
                   AND g_stbe2_d[l_ac].stbfseq IS NOT NULL
                THEN 
                   LET l_cmd='u'
                   LET g_stbe2_d_t.* = g_stbe2_d[l_ac].*  #BACKUP
                   LET g_stbe2_d_o.* = g_stbe2_d[l_ac].*  #BACKUP
                   CALL astt840_set_entry_b(l_cmd)
                   #add-point:modify段after_set_entry_b name="input.body2.after_set_entry_b"
        
                   #end add-point  
                   CALL astt840_set_no_entry_b(l_cmd)
                   IF NOT astt840_lock_b("stbf_1_t","'2'") THEN
                      LET l_lock_sw='Y'
                   ELSE
                      FETCH astt840_bcl9 INTO g_stbe2_d[l_ac].stbfseq,g_stbe2_d[l_ac].stbf001,g_stbe2_d[l_ac].stbf002, 
                          g_stbe2_d[l_ac].stbf003,g_stbe2_d[l_ac].stbf004,g_stbe2_d[l_ac].stbf005,g_stbe2_d[l_ac].stbf006, 
                          g_stbe2_d[l_ac].stbf007,g_stbe2_d[l_ac].stbf008,g_stbe2_d[l_ac].stbf009,g_stbe2_d[l_ac].stbf010, 
                          g_stbe2_d[l_ac].stbf011,g_stbe2_d[l_ac].stbf012,g_stbe2_d[l_ac].stbfcomp,g_stbe2_d[l_ac].stbfsite, 
                          g_stbe2_d[l_ac].stbf013,g_stbe2_d[l_ac].stbf014,g_stbe2_d[l_ac].stbf015,g_stbe2_d[l_ac].stbf016 
        
                      IF SQLCA.sqlcode THEN
                         INITIALIZE g_errparam TO NULL 
                         LET g_errparam.extend = SQLERRMESSAGE  
                         LET g_errparam.code   = SQLCA.sqlcode 
                         LET g_errparam.popup  = TRUE 
                         CALL cl_err()
                         LET l_lock_sw = "Y"
                      END IF
                      
                      #遮罩相關處理
                      LET g_stbe2_d_mask_o[l_ac].* =  g_stbe2_d[l_ac].*
                      CALL astt840_stbf_t_mask()
                      LET g_stbe2_d_mask_n[l_ac].* =  g_stbe2_d[l_ac].*
                      
                  LET g_bfill = "N"
                  CALL astt840_show()
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
                  LET g_errparam.code   = -263 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CANCEL DELETE
               END IF
               
               #add-point:單身2刪除前 name="input.body2.b_delete"

               #end add-point    
                  
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_stbd_m.stbddocno
               LET gs_keys[gs_keys.getLength()+1] = g_stbe2_d_t.stbfseq
            
               #刪除同層單身
               IF NOT astt840_delete_b('stbf_t',gs_keys,"'2'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE astt840_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT astt840_key_delete_b(gs_keys,'stbf_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE astt840_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
               
               #add-point:單身2刪除中 name="input.body2.m_delete"

               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE astt840_bcl
 
               LET g_rec_b = g_rec_b-1
               
               #add-point:單身2刪除後 name="input.body2.a_delete"

               #end add-point
               LET l_count = g_stbe_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body2.after_delete"

               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_stbe2_d.getLength() + 1) THEN
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
               
            #add-point:單身2新增前 name="input.body2.b_a_insert"

            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM stbf_t 
             WHERE stbfent = g_enterprise AND stbfdocno = g_stbd_m.stbddocno
               AND stbfseq = g_stbe2_d[l_ac].stbfseq
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前 name="input.body2.b_insert"

               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_stbd_m.stbddocno
               LET gs_keys[2] = g_stbe2_d[g_detail_idx].stbfseq
               CALL astt840_insert_b('stbf_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2 name="input.body2.a_insert"

               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               INITIALIZE g_stbe_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "stbf_t:",SQLERRMESSAGE 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL astt840_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body2.after_insert"

               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               LET g_stbe2_d[l_ac].* = g_stbe2_d_t.*
               CLOSE astt840_bcl2
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_stbe2_d[l_ac].* = g_stbe2_d_t.*
            ELSE
               #add-point:單身page2修改前 name="input.body2.b_update"

               #end add-point
               
               #寫入修改者/修改日期資訊(單身2)
               
               
               #將遮罩欄位還原
               CALL astt840_stbf_t_mask_restore('restore_mask_o')
                              
               UPDATE stbf_t SET (stbfdocno,stbfseq,stbf001,stbf002,stbf003,stbf004,stbf005,stbf006, 
                   stbf007,stbf008,stbf009,stbf010,stbf011,stbf012,stbfcomp,stbfsite,stbf013,stbf014, 
                   stbf015,stbf016) = (g_stbd_m.stbddocno,g_stbe2_d[l_ac].stbfseq,g_stbe2_d[l_ac].stbf001, 
                   g_stbe2_d[l_ac].stbf002,g_stbe2_d[l_ac].stbf003,g_stbe2_d[l_ac].stbf004,g_stbe2_d[l_ac].stbf005, 
                   g_stbe2_d[l_ac].stbf006,g_stbe2_d[l_ac].stbf007,g_stbe2_d[l_ac].stbf008,g_stbe2_d[l_ac].stbf009, 
                   g_stbe2_d[l_ac].stbf010,g_stbe2_d[l_ac].stbf011,g_stbe2_d[l_ac].stbf012,g_stbe2_d[l_ac].stbfcomp, 
                   g_stbe2_d[l_ac].stbfsite,g_stbe2_d[l_ac].stbf013,g_stbe2_d[l_ac].stbf014,g_stbe2_d[l_ac].stbf015, 
                   g_stbe2_d[l_ac].stbf016) #自訂欄位頁簽
                WHERE stbfent = g_enterprise AND stbfdocno = g_stbd_m.stbddocno
                  AND stbfseq = g_stbe2_d_t.stbfseq #項次 
                  
               #add-point:單身page2修改中 name="input.body2.m_update"

               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "stbf_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     LET g_stbe2_d[l_ac].* = g_stbe2_d_t.*
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "stbf_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     LET g_stbe2_d[l_ac].* = g_stbe2_d_t.*
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_stbd_m.stbddocno
               LET gs_keys_bak[1] = g_stbddocno_t
               LET gs_keys[2] = g_stbe2_d[g_detail_idx].stbfseq
               LET gs_keys_bak[2] = g_stbe2_d_t.stbfseq
               CALL astt840_update_b('stbf_t',gs_keys,gs_keys_bak,"'2'")
                     #資料多語言用-增/改
                     
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL astt840_stbf_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_stbe2_d[g_detail_idx].stbfseq = g_stbe2_d_t.stbfseq 
                  ) THEN
                  LET gs_keys[01] = g_stbd_m.stbddocno
                  LET gs_keys[gs_keys.getLength()+1] = g_stbe2_d_t.stbfseq
                  CALL astt840_key_update_b(gs_keys,'stbf_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_stbd_m),util.JSON.stringify(g_stbe2_d_t)
               LET g_log2 = util.JSON.stringify(g_stbd_m),util.JSON.stringify(g_stbe2_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page2修改後 name="input.body2.a_update"

               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbfseq
            #add-point:BEFORE FIELD stbfseq name="input.b.page2.stbfseq"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbfseq
            
            #add-point:AFTER FIELD stbfseq name="input.a.page2.stbfseq"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  g_stbd_m.stbddocno IS NOT NULL AND g_stbe2_d[g_detail_idx].stbfseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_stbd_m.stbddocno != g_stbddocno_t OR g_stbe2_d[g_detail_idx].stbfseq != g_stbe2_d_t.stbfseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(1) FROM stbf_t WHERE "||"stbfent = '" ||g_enterprise|| "' AND "||"stbfdocno = '"||g_stbd_m.stbddocno ||"' AND "|| "stbfseq = '"||g_stbe2_d[g_detail_idx].stbfseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbfseq
            #add-point:ON CHANGE stbfseq name="input.g.page2.stbfseq"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbf001
            #add-point:BEFORE FIELD stbf001 name="input.b.page2.stbf001"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbf001
            
            #add-point:AFTER FIELD stbf001 name="input.a.page2.stbf001"

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbf001
            #add-point:ON CHANGE stbf001 name="input.g.page2.stbf001"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbf002
            #add-point:BEFORE FIELD stbf002 name="input.b.page2.stbf002"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbf002
            
            #add-point:AFTER FIELD stbf002 name="input.a.page2.stbf002"

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbf002
            #add-point:ON CHANGE stbf002 name="input.g.page2.stbf002"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbf003
            #add-point:BEFORE FIELD stbf003 name="input.b.page2.stbf003"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbf003
            
            #add-point:AFTER FIELD stbf003 name="input.a.page2.stbf003"

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbf003
            #add-point:ON CHANGE stbf003 name="input.g.page2.stbf003"

            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbf004
            
            #add-point:AFTER FIELD stbf004 name="input.a.page2.stbf004"
            IF NOT cl_null(g_stbe2_d[l_ac].stbf004) THEN
               #IF l_cmd = 'a' OR ( l_cmd = 'u' AND ((cl_null(g_stbe2_d[l_ac].stbf004) OR g_stbe2_d[l_ac].stbf004 != g_stbe2_d_t.stbf004) OR cl_null(g_stbe2_d_t.stbf004))) THEN   #160824-00007#210 Mark By Ken 161118
               IF ((cl_null(g_stbe2_d[l_ac].stbf004) OR g_stbe2_d[l_ac].stbf004 != g_stbe2_d_o.stbf004) OR cl_null(g_stbe2_d_o.stbf004)) THEN   #160824-00007#210 Add By Ken 161118
                  #抓取含稅否&稅率
                  CALL s_tax_chk(l_glaacomp,g_stbe2_d[l_ac].stbf004) RETURNING l_success,g_stbe2_d[l_ac].stbf004_desc,l_oodb005,g_stbe2_d[l_ac].stbf005,l_oodb011
                  #LET g_stbe2_d[l_ac].stbf004=l_oodb005
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aim-00164'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #LET g_stbe2_d[l_ac].stbf004 = g_stbe2_d_t.stbf004  #160824-00007#210 Mark By Ken 161118
                     LET g_stbe2_d[l_ac].stbf004 = g_stbe2_d_o.stbf004   #160824-00007#210 Add By Ken 161118
                     NEXT FIELD CURRENT
                  END IF
                  #CALL aapt810_set_entry_money(g_apbb_m.apbb0121)
               END IF
            END IF
            #CALL s_desc_get_tax_desc(l_ooef019,g_stbe2_d[l_ac].stbf004) RETURNING g_stbe2_d[l_ac].stbf004_desc
            DISPLAY BY NAME g_stbe2_d[l_ac].stbf004,g_stbe2_d[l_ac].stbf004_desc,g_stbe2_d[l_ac].stbf005
            #20151103--add--str--lujh
            IF cl_null(g_stbe2_d[l_ac].stbf004) THEN 
               LET g_stbe2_d[l_ac].stbf005 = 'N'
            END IF
            LET g_stbe2_d_o.* = g_stbe2_d[l_ac].*   #160824-00007#210 Add By Ken 161118
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbf004
            #add-point:BEFORE FIELD stbf004 name="input.b.page2.stbf004"

            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbf004
            #add-point:ON CHANGE stbf004 name="input.g.page2.stbf004"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbf005
            #add-point:BEFORE FIELD stbf005 name="input.b.page2.stbf005"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbf005
            
            #add-point:AFTER FIELD stbf005 name="input.a.page2.stbf005"

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbf005
            #add-point:ON CHANGE stbf005 name="input.g.page2.stbf005"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbf006
            #add-point:BEFORE FIELD stbf006 name="input.b.page2.stbf006"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbf006
            
            #add-point:AFTER FIELD stbf006 name="input.a.page2.stbf006"
            #原幣未稅金額
            IF NOT cl_null(g_stbe2_d[l_ac].stbf006) THEN
               #IF l_cmd = 'a' OR ( l_cmd = 'u' AND ((cl_null(g_stbe2_d[l_ac].stbf006) OR g_stbe2_d[l_ac].stbf006 != g_stbe2_d_t.stbf006) OR cl_null(g_stbe2_d_t.stbf006))) THEN   #160824-00007#210 Mark By Ken 161118
               IF ((cl_null(g_stbe2_d[l_ac].stbf006) OR g_stbe2_d[l_ac].stbf006 != g_stbe2_d_o.stbf006) OR cl_null(g_stbe2_d_o.stbf006)) THEN   #160824-00007#210 Add By Ken 161118
               
                  IF cl_null(g_stbe2_d[l_ac].stbf008) or g_stbe2_d[l_ac].stbf008<=0 THEN
                     CALL s_tax_count(l_glaacomp,g_stbe2_d[l_ac].stbf004,g_stbe2_d[l_ac].stbf006,1,g_stbe2_d[l_ac].stbf009,g_stbe2_d[l_ac].stbf010)     #20151104 change g_apbb_m.apbb012 to g_apba2_d[l_ac].isam012 lujh                      
                          RETURNING g_stbe2_d[l_ac].stbf006,g_stbe2_d[l_ac].stbf007,g_stbe2_d[l_ac].stbf008
                                   ,l_sum1,l_sum2,l_sum3
                  ELSE
                     LET g_stbe2_d[l_ac].stbf007 = g_stbe2_d[l_ac].stbf008 - g_stbe2_d[l_ac].stbf006
                     
#                     IF g_stbe2_d[l_ac].stbf007 = 1 THEN
#                        LET g_apba2_d[l_ac].isam026 = g_apba2_d[l_ac].isam023
#                        LET g_apba2_d[l_ac].isam027 = g_apba2_d[l_ac].isam024
#                     ELSE
#                        LET g_apba2_d[l_ac].isam026 = g_apba2_d[l_ac].isam023 * g_apba2_d[l_ac].isam015
#                        CALL s_curr_round_ld('1',g_ld,g_glaa001,g_apba2_d[l_ac].isam026,2) RETURNING g_sub_success,g_errno,g_apba2_d[l_ac].isam026
#                        LET g_apba2_d[l_ac].isam027 = g_apba2_d[l_ac].isam028 - g_apba2_d[l_ac].isam026
#                     END IF
                  END IF                 
               END IF
            END IF
            DISPLAY BY NAME g_stbe2_d[l_ac].stbf006,g_stbe2_d[l_ac].stbf007,g_stbe2_d[l_ac].stbf008
            LET g_stbe2_d_o.* = g_stbe2_d[l_ac].*     #160824-00007#210 Add By Ken 161118
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbf006
            #add-point:ON CHANGE stbf006 name="input.g.page2.stbf006"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbf007
            #add-point:BEFORE FIELD stbf007 name="input.b.page2.stbf007"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbf007
            
            #add-point:AFTER FIELD stbf007 name="input.a.page2.stbf007"
            IF NOT cl_null(g_stbe2_d[l_ac].stbf007) THEN
               #IF l_cmd = 'a' OR ( l_cmd = 'u' AND ((cl_null(g_stbe2_d[l_ac].stbf007) OR g_stbe2_d[l_ac].stbf007 != g_stbe2_d_t.stbf007) OR cl_null(g_stbe2_d_t.stbf007))) THEN   #160824-00007#210 Mark By Ken 161118
               IF ((cl_null(g_stbe2_d[l_ac].stbf007) OR g_stbe2_d[l_ac].stbf007 != g_stbe2_d_o.stbf007) OR cl_null(g_stbe2_d_o.stbf007)) THEN   #160824-00007#210 Add By Ken 161118
                  #容差率OK更新本幣金額
                  IF l_oodb005 = "Y" THEN              #20151104 add lujh 
                     LET g_stbe2_d[l_ac].stbf007 = g_stbe2_d[l_ac].stbf007 * g_stbe2_d[l_ac].stbf010
                     CALL s_curr_round_ld('1',l_glaald,g_stbe2_d[l_ac].stbf009,g_stbe2_d[l_ac].stbf007,2) RETURNING l_success,l_errno,g_stbe2_d[l_ac].stbf007
                     LET g_stbe2_d[l_ac].stbf006 = g_stbe2_d[l_ac].stbf007 - g_stbe2_d[l_ac].stbf006
                  ELSE
                     LET g_stbe2_d[l_ac].stbf007 = g_stbe2_d[l_ac].stbf007 * g_stbe2_d[l_ac].stbf010
                     CALL s_curr_round_ld('1',l_glaald,g_stbe2_d[l_ac].stbf009,g_stbe2_d[l_ac].stbf007,2) RETURNING l_success,l_errno,g_stbe2_d[l_ac].stbf007
                     LET g_stbe2_d[l_ac].stbf008 = g_stbe2_d[l_ac].stbf006 + g_stbe2_d[l_ac].stbf007
                  END IF
               END IF
            END IF
            DISPLAY BY NAME g_stbe2_d[l_ac].stbf006,g_stbe2_d[l_ac].stbf007,g_stbe2_d[l_ac].stbf008
            LET g_stbe2_d_o.* = g_stbe2_d[l_ac].*    #160824-00007#210 Add By Ken 161118
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbf007
            #add-point:ON CHANGE stbf007 name="input.g.page2.stbf007"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbf008
            #add-point:BEFORE FIELD stbf008 name="input.b.page2.stbf008"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbf008
            
            #add-point:AFTER FIELD stbf008 name="input.a.page2.stbf008"
            #原幣含稅金額
         IF NOT cl_null(g_stbe2_d[l_ac].stbf008) THEN
            #IF l_cmd = 'a' OR ( l_cmd = 'u' AND ((cl_null(g_stbe2_d[l_ac].stbf008) OR g_stbe2_d[l_ac].stbf008 != g_stbe2_d_t.stbf008) OR cl_null(g_stbe2_d_t.stbf008))) THEN    #160824-00007#210 Mark By Ken 161118
            IF ((cl_null(g_stbe2_d[l_ac].stbf008) OR g_stbe2_d[l_ac].stbf008 != g_stbe2_d_o.stbf008) OR cl_null(g_stbe2_d_o.stbf008)) THEN    #160824-00007#210 Add By Ken 161118
               IF cl_null(g_stbe2_d[l_ac].stbf006) or g_stbe2_d[l_ac].stbf006<=0 THEN
                     CALL s_tax_count(l_glaacomp,g_stbe2_d[l_ac].stbf004,g_stbe2_d[l_ac].stbf008,1,g_stbe2_d[l_ac].stbf009,g_stbe2_d[l_ac].stbf010)
                       RETURNING g_stbe2_d[l_ac].stbf006,g_stbe2_d[l_ac].stbf007,g_stbe2_d[l_ac].stbf008
                                ,l_sum1,l_sum2,l_sum3
                  ELSE
                     LET g_stbe2_d[l_ac].stbf007 = g_stbe2_d[l_ac].stbf008 - g_stbe2_d[l_ac].stbf006
#                     IF g_apba2_d[l_ac].isam015 = 1 THEN
#                        LET g_apba2_d[l_ac].isam028 = g_apba2_d[l_ac].isam025
#                        LET g_apba2_d[l_ac].isam027 = g_apba2_d[l_ac].isam024
#                     ELSE
#                        LET g_apba2_d[l_ac].isam028 = g_apba2_d[l_ac].isam025 * g_apba2_d[l_ac].isam015
#                        CALL s_curr_round_ld('1',g_ld,g_glaa001,g_apba2_d[l_ac].isam028,2) RETURNING g_sub_success,g_errno,g_apba2_d[l_ac].isam028
#                        LET g_apba2_d[l_ac].isam027 = g_apba2_d[l_ac].isam028 - g_apba2_d[l_ac].isam026
#                     END IF
                  END IF             
            END IF
         END IF
         DISPLAY BY NAME g_stbe2_d[l_ac].stbf006,g_stbe2_d[l_ac].stbf007,g_stbe2_d[l_ac].stbf008
         LET g_stbe2_d_o.* = g_stbe2_d[l_ac].*     #160824-00007#210 Add By Ken 161118
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbf008
            #add-point:ON CHANGE stbf008 name="input.g.page2.stbf008"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbf009
            #add-point:BEFORE FIELD stbf009 name="input.b.page2.stbf009"
#            SELECT glaald,glaa001,glaa025,glaacomp INTO l_glaald,g_stbe2_d[l_ac].stbf009,l_glaa025,l_glaacomp
#                  FROM glaa_t 
#                 WHERE glaaent=g_enterprise 
#                   AND glaacomp=l_ooef017
#                   AND glaa014='Y'
#                CALL s_aooi160_get_exrate('2',l_glaald,g_stbe2_d[l_ac].stbf003,g_stbe2_d[l_ac].stbf009,g_stbe2_d[l_ac].stbf009,0,l_glaa025)
#                     RETURNING g_stbe2_d[l_ac].stbf010
#                DISPLAY BY NAME g_stbe2_d[l_ac].stbf010,g_stbe2_d[l_ac].stbf009
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbf009
            
            #add-point:AFTER FIELD stbf009 name="input.a.page2.stbf009"

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbf009
            #add-point:ON CHANGE stbf009 name="input.g.page2.stbf009"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbf010
            #add-point:BEFORE FIELD stbf010 name="input.b.page2.stbf010"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbf010
            
            #add-point:AFTER FIELD stbf010 name="input.a.page2.stbf010"

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbf010
            #add-point:ON CHANGE stbf010 name="input.g.page2.stbf010"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbf011
            #add-point:BEFORE FIELD stbf011 name="input.b.page2.stbf011"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbf011
            
            #add-point:AFTER FIELD stbf011 name="input.a.page2.stbf011"

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbf011
            #add-point:ON CHANGE stbf011 name="input.g.page2.stbf011"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbf012
            #add-point:BEFORE FIELD stbf012 name="input.b.page2.stbf012"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbf012
            
            #add-point:AFTER FIELD stbf012 name="input.a.page2.stbf012"

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbf012
            #add-point:ON CHANGE stbf012 name="input.g.page2.stbf012"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbfcomp
            #add-point:BEFORE FIELD stbfcomp name="input.b.page2.stbfcomp"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbfcomp
            
            #add-point:AFTER FIELD stbfcomp name="input.a.page2.stbfcomp"

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbfcomp
            #add-point:ON CHANGE stbfcomp name="input.g.page2.stbfcomp"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbfsite
            #add-point:BEFORE FIELD stbfsite name="input.b.page2.stbfsite"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbfsite
            
            #add-point:AFTER FIELD stbfsite name="input.a.page2.stbfsite"

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbfsite
            #add-point:ON CHANGE stbfsite name="input.g.page2.stbfsite"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbf013
            #add-point:BEFORE FIELD stbf013 name="input.b.page2.stbf013"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbf013
            
            #add-point:AFTER FIELD stbf013 name="input.a.page2.stbf013"

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbf013
            #add-point:ON CHANGE stbf013 name="input.g.page2.stbf013"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbf014
            #add-point:BEFORE FIELD stbf014 name="input.b.page2.stbf014"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbf014
            
            #add-point:AFTER FIELD stbf014 name="input.a.page2.stbf014"

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbf014
            #add-point:ON CHANGE stbf014 name="input.g.page2.stbf014"

            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbf015
            
            #add-point:AFTER FIELD stbf015 name="input.a.page2.stbf015"
            #161024-00025#2--add--s
            IF NOT cl_null(g_stbe2_d[l_ac].stbf015) THEN 
                IF s_aooi500_setpoint(g_prog,'stbf015') THEN
                   CALL s_aooi500_chk(g_prog,'stbf015',g_stbe2_d[l_ac].stbf015,g_stbd_m.stbdsite) RETURNING l_success,l_errno
                   IF NOT l_success THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.extend = g_stbe2_d[l_ac].stbf015
                      LET g_errparam.code   = l_errno
                      LET g_errparam.popup  = TRUE
                      CALL cl_err()
                   
                      LET g_stbe2_d[l_ac].stbf015 = g_stbe2_d_t.stbf015
                      CALL s_desc_get_department_desc(g_stbe2_d[l_ac].stbf015) RETURNING g_stbe2_d[l_ac].stbf015_desc
                      DISPLAY BY NAME g_stbe2_d[l_ac].stbf015,g_stbe2_d[l_ac].stbf015_desc
                      NEXT FIELD CURRENT
                   END IF
                ELSE
                   SELECT DISTINCT count(*) INTO l_n FROM OOEF_T
                     LEFT OUTER JOIN OOEFL_T ON OOEF001 = OOEFL001
                                            AND OOEFL002 = g_lang
                                            AND OOEFENT = OOEFLENT
                     LEFT OUTER JOIN XRAH_T ON XRAH004 = OOEF001
                                           AND XRAH001 = '3'
                                           AND XRAH007 = 'Y'
                    WHERE OOEFENT = 99
                      AND ooef001 = g_stbe2_d[l_ac].stbf015
                      AND ooef203 = 'Y'
                      AND OOEFSTUS = 'Y'
                    ORDER BY OOEF001
                   IF l_n=0 THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = 'aoo-00092'
                      LET g_errparam.extend = ''
                      LET g_errparam.popup = TRUE
                      CALL cl_err()
                      LET g_stbe2_d[l_ac].stbf015 = g_stbe2_d_t.stbf015
                      CALL s_desc_get_department_desc(g_stbe2_d[l_ac].stbf015) RETURNING g_stbe2_d[l_ac].stbf015_desc
                      DISPLAY BY NAME g_stbe2_d[l_ac].stbf015,g_stbe2_d[l_ac].stbf015_desc
                      NEXT FIELD CURRENT
                   END IF
                END IF
            END IF 
            #161024-00025#2--add--e
            INITIALIZE g_ref_fields TO NULL
            #161024-00025#2--mark--s
#            SELECT DISTINCT count(*) INTO l_n FROM OOEF_T
#              LEFT OUTER JOIN OOEFL_T ON OOEF001 = OOEFL001
#                                     AND OOEFL002 = g_lang
#                                     AND OOEFENT = OOEFLENT
#              LEFT OUTER JOIN XRAH_T ON XRAH004 = OOEF001
#                                    AND XRAH001 = '3'
#                                    AND XRAH007 = 'Y'
#             WHERE OOEFENT = 99
#               AND ooef001 = g_stbe2_d[l_ac].stbf015
#               AND OOEFSTUS = 'Y'
#             ORDER BY OOEF001
#            IF l_n=0 THEN
#               INITIALIZE g_errparam TO NULL
#               LET g_errparam.code = 'abm-00006'
#               LET g_errparam.extend = ''
#               LET g_errparam.popup = TRUE
#               CALL cl_err()
#               LET g_stbe2_d[l_ac].stbf015 = g_stbe2_d_t.stbf015
#               NEXT FIELD CURRENT
#            END IF
            #161024-00025#2--mark--e
            LET g_ref_fields[1] = g_stbe2_d[l_ac].stbf015
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_stbe2_d[l_ac].stbf015_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stbe2_d[l_ac].stbf015_desc
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbf015
            #add-point:BEFORE FIELD stbf015 name="input.b.page2.stbf015"

            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbf015
            #add-point:ON CHANGE stbf015 name="input.g.page2.stbf015"

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbf016
            #add-point:BEFORE FIELD stbf016 name="input.b.page2.stbf016"

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbf016
            
            #add-point:AFTER FIELD stbf016 name="input.a.page2.stbf016"

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbf016
            #add-point:ON CHANGE stbf016 name="input.g.page2.stbf016"

            #END add-point 
 
 
 
                  #Ctrlp:input.c.page2.stbfseq
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbfseq
            #add-point:ON ACTION controlp INFIELD stbfseq name="input.c.page2.stbfseq"

            #END add-point
 
 
         #Ctrlp:input.c.page2.stbf001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbf001
            #add-point:ON ACTION controlp INFIELD stbf001 name="input.c.page2.stbf001"

            #END add-point
 
 
         #Ctrlp:input.c.page2.stbf002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbf002
            #add-point:ON ACTION controlp INFIELD stbf002 name="input.c.page2.stbf002"

            #END add-point
 
 
         #Ctrlp:input.c.page2.stbf003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbf003
            #add-point:ON ACTION controlp INFIELD stbf003 name="input.c.page2.stbf003"

            #END add-point
 
 
         #Ctrlp:input.c.page2.stbf004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbf004          
            #add-point:ON ACTION controlp INFIELD stbf004 name="input.c.page2.stbf004"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_stbe2_d[l_ac].stbf004
            LET g_qryparam.default2 = g_stbe2_d[l_ac].stbf004_desc
            LET g_qryparam.default3 = '' #含稅否
            LET g_qryparam.default4 = g_stbe2_d[l_ac].stbf005  #稅率
            LET g_qryparam.arg1 = l_ooef019
            CALL q_oodb002_5()
            LET g_stbe2_d[l_ac].stbf004 = g_qryparam.return1
            LET g_stbe2_d[l_ac].stbf004_desc = g_qryparam.return2
            LET g_stbe2_d[l_ac].stbf005 = g_qryparam.return4
            NEXT FIELD stbf004
            #END add-point
 
 
         #Ctrlp:input.c.page2.stbf005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbf005
            #add-point:ON ACTION controlp INFIELD stbf005 name="input.c.page2.stbf005"

            #END add-point
 
 
         #Ctrlp:input.c.page2.stbf006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbf006
            #add-point:ON ACTION controlp INFIELD stbf006 name="input.c.page2.stbf006"

            #END add-point
 
 
         #Ctrlp:input.c.page2.stbf007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbf007
            #add-point:ON ACTION controlp INFIELD stbf007 name="input.c.page2.stbf007"

            #END add-point
 
 
         #Ctrlp:input.c.page2.stbf008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbf008
            #add-point:ON ACTION controlp INFIELD stbf008 name="input.c.page2.stbf008"

            #END add-point
 
 
         #Ctrlp:input.c.page2.stbf009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbf009
            #add-point:ON ACTION controlp INFIELD stbf009 name="input.c.page2.stbf009"

            #END add-point
 
 
         #Ctrlp:input.c.page2.stbf010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbf010
            #add-point:ON ACTION controlp INFIELD stbf010 name="input.c.page2.stbf010"

            #END add-point
 
 
         #Ctrlp:input.c.page2.stbf011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbf011
            #add-point:ON ACTION controlp INFIELD stbf011 name="input.c.page2.stbf011"

            #END add-point
 
 
         #Ctrlp:input.c.page2.stbf012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbf012
            #add-point:ON ACTION controlp INFIELD stbf012 name="input.c.page2.stbf012"

            #END add-point
 
 
         #Ctrlp:input.c.page2.stbfcomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbfcomp
            #add-point:ON ACTION controlp INFIELD stbfcomp name="input.c.page2.stbfcomp"

            #END add-point
 
 
         #Ctrlp:input.c.page2.stbfsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbfsite
            #add-point:ON ACTION controlp INFIELD stbfsite name="input.c.page2.stbfsite"

            #END add-point
 
 
         #Ctrlp:input.c.page2.stbf013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbf013
            #add-point:ON ACTION controlp INFIELD stbf013 name="input.c.page2.stbf013"

            #END add-point
 
 
         #Ctrlp:input.c.page2.stbf014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbf014
            #add-point:ON ACTION controlp INFIELD stbf014 name="input.c.page2.stbf014"

            #END add-point
 
 
         #Ctrlp:input.c.page2.stbf015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbf015
            #add-point:ON ACTION controlp INFIELD stbf015 name="input.c.page2.stbf015"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_stbe2_d[l_ac].stbf015             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

            #161024-00025#2--add--s
            IF s_aooi500_setpoint(g_prog,'stbf015') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'stbf015',g_stbd_m.stbdsite,'i')
               CALL q_ooef001_24()
            ELSE
               LET g_qryparam.where = " ooef203 = 'Y' " 
               CALL q_ooef001_24()
            END IF
            #161024-00025#2--add--e
            #CALL q_ooef001_01()                                #呼叫開窗  #161024-00025#2 mark
 
            LET g_stbe2_d[l_ac].stbf015 = g_qryparam.return1              

            DISPLAY g_stbe2_d[l_ac].stbf015 TO stbf015              #

            NEXT FIELD stbf015                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page2.stbf016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbf016
            #add-point:ON ACTION controlp INFIELD stbf016 name="input.c.page2.stbf016"

            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page2 after_row name="input.body2.after_row"

            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_stbe2_d[l_ac].* = g_stbe2_d_t.*
               END IF
               CLOSE astt840_bcl2
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL astt840_unlock_b("stbf_t","'5'")
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
               LET g_stbe2_d[li_reproduce_target].* = g_stbe2_d[li_reproduce].*
 
               LET g_stbe2_d[li_reproduce_target].stbfseq = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_stbe2_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_stbe2_d.getLength()+1
            END IF
            
      END INPUT
      
         BEFORE DIALOG 
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail2",g_idx_group.getValue("'2',"))
 
         
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
         LET g_detail_idx_list[3] = 1
         LET g_detail_idx_list[4] = 1
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
         CALL g_curr_diag.setCurrentRow("s_detail4",1)
         CALL g_curr_diag.setCurrentRow("s_detail5",1)
 
         EXIT DIALOG
 
      ON ACTION close       #在dialog 右上角 (X)
         #add-point:input段close name="input.close"

         #end add-point  
         LET INT_FLAG = TRUE 
         EXIT DIALOG
      
     ON ACTION delete
        LET g_action_choice="delete"
        IF cl_auth_chk_act("delete") THEN
           CALL astt840_delete()
           #add-point:ON ACTION delete name="menu.delete"
        
           #END add-point
           
        END IF
 
         #應用 a43 樣板自動產生(Version:4)
     ON ACTION insert
        LET g_action_choice="insert"
        IF cl_auth_chk_act("insert") THEN
           CALL astt840_insert()
           #add-point:ON ACTION insert name="menu.insert"
     
           #END add-point
           
        END IF

      ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL astt840_query()
               #add-point:ON ACTION query name="menu.query"

               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
 
 
 
            END IF

      ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL astt840_modify()
               #add-point:ON ACTION modify name="menu.modify"

               #END add-point
               
            END IF
 
      ON ACTION exit        #toolbar 離開
         #add-point:input段exit name="input.exit"

         #end add-point
         LET INT_FLAG = TRUE 
         LET g_detail_idx  = 1
         LET g_detail_idx2 = 1
         #各個page指標
         LET g_detail_idx_list[1] = 1 
         LET g_detail_idx_list[2] = 1
         LET g_detail_idx_list[3] = 1
         LET g_detail_idx_list[4] = 1
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
         CALL g_curr_diag.setCurrentRow("s_detail4",1)
         CALL g_curr_diag.setCurrentRow("s_detail5",1)
 
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
      
      
END FUNCTION

################################################################################
# Descriptions...: 取得費用總類
# Memo...........:
# Usage..........: CALL astt840_get_stae003(p_stae001)
#                  RETURNING r_stae003
# Input parameter: p_stae001     費用編號
# Return code....: r_stae003     費用總額
# Date & Author..: 2016/06/07 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION astt840_get_stae003(p_stae001)
   DEFINE p_stae001      LIKE stae_t.stae001
   DEFINE r_stae003      LIKE stae_t.stae003
   DEFINE r_oocql004     LIKE oocql_t.oocql004
   
   LET r_stae003 = ''
   
   SELECT stae003,oocql004 INTO r_stae003,r_oocql004
     FROM stae_t 
          LEFT JOIN oocql_t ON oocqlent = staeent AND oocql001 = '2058' 
                           AND oocql002 = stae003 AND oocql003 = g_dlang
    WHERE staeent = g_enterprise
      AND stae001 = p_stae001
    
   RETURN r_stae003,r_oocql004
END FUNCTION

################################################################################
# Descriptions...: 刪除更新結算底稿
# Memo...........:
# Usage..........: CALL astt840_delete_updstbc()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success    TRUE/FALSE
# Date & Author..: 20160610 By geza
# Modify.........:
################################################################################
PRIVATE FUNCTION astt840_delete_updstbc()
DEFINE r_success     LIKE type_t.num5
DEFINE l_stbe002     LIKE stbe_t.stbe002
DEFINE l_stbe003     LIKE stbe_t.stbe003
DEFINE l_stbc018     LIKE stbc_t.stbc018
DEFINE l_stbc019     LIKE stbc_t.stbc019
DEFINE l_stbcstus    LIKE stbc_t.stbcstus


   LET r_success=TRUE
  

   LET g_sql = "SELECT stbe_t.stbe002,stbe_t.stbe003 FROM stbd_t,stbe_t",
               " WHERE stbdent=stbeent",
               "   AND stbddocno=stbedocno",
               "   AND stbdent='",g_enterprise,"'",
               "   AND stbddocno='",g_stbd_m.stbddocno,"'"
      
   PREPARE astt840_update_stbc_pb FROM g_sql
   DECLARE astt840_update_stbe_cur CURSOR FOR astt840_update_stbc_pb
       

   LET l_stbe002=''
   LET l_stbe003=''
   
   FOREACH astt840_update_stbe_cur INTO l_stbe002,l_stbe003

      LET l_stbc018=''
      LET l_stbc019=''
      LET l_stbcstus=''
      SELECT stbc018,stbc019,l_stbcstus INTO l_stbc018,l_stbc019,l_stbcstus
        FROM stbc_t
       WHERE stbcent=g_enterprise
         AND stbc004=l_stbe002
         AND stbc005=l_stbe003
       
       IF cl_null(l_stbc018) THEN
          LET l_stbc018=0
       END IF          

       IF cl_null(l_stbc019) THEN
          LET l_stbc019=0
       END IF  
       
       IF l_stbc018=l_stbc019 THEN
          LET l_stbcstus='1'
       ELSE
          LET l_stbcstus='3'
       END IF
       
      #IF 0<l_stbc019 AND l_stbc019<l_stbc018 THEN
      #   LET l_stbcstus='3'
      #END IF
       
       UPDATE stbc_t SET stbcstus=l_stbcstus
        WHERE stbcent=g_enterprise
          AND stbc004=l_stbe002
          AND stbc005=l_stbe003  
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = "update stbc_t"
          LET g_errparam.popup = TRUE
          CALL cl_err()

          LET r_success=FALSE
          RETURN r_success    
       END IF       
       


   END FOREACH
   
   FREE astt840_update_stbc_pb
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 取得租賃合約資訊
# Memo...........:
# Usage..........: CALL astt840_get_stje001()
# Return code....: 無
# Date & Author..: 2016/06/24 By geza
# Modify.........:
################################################################################
PRIVATE FUNCTION astt840_get_stje001()
   DEFINE l_sel_sql       STRING
   DEFINE l_cnt_sql       STRING
   DEFINE l_cnt           LIKE type_t.num5   
   
   LET l_sel_sql = "SELECT stje001,stje005,stje007,stje008,  ",           #合約編號,合約狀態,供應商編號,鋪位編號
                   "       stje027,stje029,stje040,stje030,  ",           #管理品類,主品牌,含發票否,結算組織
                   "       stjoseq,stjo003,stjo004 ",                     #結算帳期,起始日期,結束日期
                   "  FROM stje_t ",
                   "       LEFT JOIN stjo_t t1  ON t1.stjoent = stjeent ",
                   "                           AND t1.stjo001 = stje001 ",           
                   "                           AND t1.stjoseq = (SELECT MIN(stjoseq)            ", 
                   "                                               FROM stjo_t t2               ",
                   "                                              WHERE t2.stjoent = t1.stjoent ",
                   "                                                AND t2.stjo001 = t1.stjo001 ",
                   "                                                AND t2.stjo005 = 'N')       ",
                   #mark by geza 20160815 #160815-00006#1(S)  
#                   "                           AND t1.stjo007 = (SELECT MAX(stjo007)            ",
#                   "                                               FROM stjo_t t3               ",
#                   "                                              WHERE t3.stjoent = t1.stjoent ",
#                   "                                                AND t3.stjo001 = t1.stjo001 ",
#                   "                                                AND t3.stjo005 = 'N')       ",
                   #mark by geza 20160815 #160815-00006#1(E)  
                   " WHERE stjeent = ",g_enterprise,
                   "   AND stje004 = '",g_stbd_m.stbd003,"' ",   #經營方式
                   "   AND stjo005 = 'N'",
                   "   AND stjestus = 'Y' ",
                   "   AND stjesite = '",g_stbd_m.stbdsite,"' ",   #结算组织 #add by geza 20160815 #160815-00006#1                     
                   "   AND stje001 = '",g_stbd_m.stbd001,"' "   #合約編號   

   LET l_sel_sql = cl_sql_add_mask(l_sel_sql)
   PREPARE astt840_sel_stje1 FROM l_sel_sql  
 
   EXECUTE astt840_sel_stje1 INTO g_stbd_m.stbd001, g_stbd_m.stbd041, g_stbd_m.stbd002, g_stbd_m.stbd037,   #合約編號,合約狀態,帳款供應商編號,鋪位編號
                                 g_stbd_m.stbd049, g_stbd_m.stbd050, g_stbd_m.stbd042, g_stbd_m.stbdunit,  #管理品類,品牌,含發票否,結算中心
                                 g_stbd_m.stbd004, g_stbd_m.stbd005, g_stbd_m.stbd006                      #結算帳期,起始日期,結束日期
#   IF SQLCA.sqlcode THEN
#      INITIALIZE g_errparam.* TO NULL
#      LET g_errparam.code = SQLCA.sqlcode
#      LET g_errparam.extend = ''
#      LET g_errparam.popup = TRUE
#      CALL cl_err()
#         
#      RETURN
#   END IF
      
   IF NOT cl_null(g_stbd_m.stbd002) THEN
      SELECT pmac002 INTO g_stbd_m.stbd046
        FROM pmac_t
       WHERE pmacent = g_enterprise
         AND pmac001 = g_stbd_m.stbd002
         AND pmac003 = '1'
         AND pmac004 = 'Y'      
         AND pmacstus = 'Y'            
   END IF

   #預估應付日
   LET g_stbd_m.stbd038 = s_astt840_get_stbd038(g_stbd_m.stbd001,g_stbd_m.stbd006)
   
   #取得結算日期, 會計年度, 會計期別
   CALL astt840_get_period()
    
   DISPLAY BY NAME g_stbd_m.stbd001,g_stbd_m.stbd041,g_stbd_m.stbd002, g_stbd_m.stbd037,                               
                   g_stbd_m.stbd049,g_stbd_m.stbd050,g_stbd_m.stbd042,g_stbd_m.stbdunit,                                 
                   g_stbd_m.stbd004,g_stbd_m.stbd005,g_stbd_m.stbd006 , g_stbd_m.stbd038
                   
   LET g_stbd_m.stbd002_desc  = s_desc_get_trading_partner_abbr_desc(g_stbd_m.stbd002)
   LET g_stbd_m.stbd037_desc  = astt840_mhbe001_ref(g_stbd_m.stbd037) 
   LET g_stbd_m.stbd046_desc  = s_desc_get_trading_partner_abbr_desc(g_stbd_m.stbd046)
   LET g_stbd_m.stbd049_desc  = s_desc_get_rtaxl003_desc(g_stbd_m.stbd049) 
   LET g_stbd_m.stbd050_desc  = s_desc_get_acc_desc('2002',g_stbd_m.stbd050) 
   LET g_stbd_m.stbdunit_desc = s_desc_get_department_desc(g_stbd_m.stbdunit)      
    
   DISPLAY BY NAME g_stbd_m.stbd002_desc,g_stbd_m.stbd037_desc,g_stbd_m.stbd049_desc,
                   g_stbd_m.stbd046_desc,g_stbd_m.stbd050_desc
   #add by geza 20160802 #160728-00006#15(S)
   SELECT stje019,stje020,stje021 INTO g_stbd_m.stje019,g_stbd_m.stje020,g_stbd_m.stje021
     FROM stje_t
    WHERE stjeent = g_enterprise
      AND stje001 = g_stbd_m.stbd001
   DISPLAY BY NAME g_stbd_m.stje019,g_stbd_m.stje020,g_stbd_m.stje021      
   CALL astt840_stje019_ref()
   CALL astt840_stje020_ref()
   CALL astt840_stje021_ref()
   #add by geza 20160802 #160728-00006#15(E)
   LET g_stbd_m_o.stbd001  = g_stbd_m.stbd001
   LET g_stbd_m_o.stbd002  = g_stbd_m.stbd002
   LET g_stbd_m_o.stbd004  = g_stbd_m.stbd004
   LET g_stbd_m_o.stbd005  = g_stbd_m.stbd005
   LET g_stbd_m_o.stbd006  = g_stbd_m.stbd006
   LET g_stbd_m_o.stbd037  = g_stbd_m.stbd037 
   LET g_stbd_m_o.stbd038  = g_stbd_m.stbd038 
   LET g_stbd_m_o.stbd041  = g_stbd_m.stbd041
   LET g_stbd_m_o.stbd042  = g_stbd_m.stbd042
   LET g_stbd_m_o.stbd043  = g_stbd_m.stbd043
   LET g_stbd_m_o.stbd044  = g_stbd_m.stbd044
   LET g_stbd_m_o.stbd046  = g_stbd_m.stbd046
   LET g_stbd_m_o.stbd049  = g_stbd_m.stbd049
   LET g_stbd_m_o.stbd050  = g_stbd_m.stbd050
   LET g_stbd_m_o.stbdunit = g_stbd_m.stbdunit
   
   IF cl_null(g_stbd_m.stbd048) THEN
      CALL astt840_get_ooef_info()
   END IF      

END FUNCTION

################################################################################
# Descriptions...: 根据供应商取得租賃合約資訊
# Memo...........:
# Usage..........: CALL astt840_get_stje007()
# Return code....: 無
# Date & Author..: 2016/06/24 By geza
# Modify.........:
################################################################################
PRIVATE FUNCTION astt840_get_stje007()
   DEFINE l_sel_sql       STRING
   DEFINE l_cnt_sql       STRING
   DEFINE l_cnt           LIKE type_t.num5   
   
   LET l_sel_sql = "SELECT stje001,stje005,stje007,stje008,  ",           #合約編號,合約狀態,供應商編號,鋪位編號
                   "       stje027,stje029,stje040,stje030,  ",           #管理品類,主品牌,含發票否,結算組織
                   "       stjoseq,stjo003,stjo004 ",                     #結算帳期,起始日期,結束日期
                   "  FROM stje_t ",
                   "       LEFT JOIN stjo_t t1  ON t1.stjoent = stjeent ",
                   "                           AND t1.stjo001 = stje001 ",           
                   "                           AND t1.stjoseq = (SELECT MIN(stjoseq)            ", 
                   "                                               FROM stjo_t t2               ",
                   "                                              WHERE t2.stjoent = t1.stjoent ",
                   "                                                AND t2.stjo001 = t1.stjo001 ",
                   "                                                AND t2.stjo005 = 'N')       ",
                   #mark by geza 20160815 #160815-00006#1(S)  
#                   "                           AND t1.stjo007 = (SELECT MAX(stjo007)            ",
#                   "                                               FROM stjo_t t3               ",
#                   "                                              WHERE t3.stjoent = t1.stjoent ",
#                   "                                                AND t3.stjo001 = t1.stjo001 ",
#                   "                                                AND t3.stjo005 = 'N')       ",
                   #mark by geza 20160815 #160815-00006#1(E)  
                   " WHERE stjeent = ",g_enterprise,
                   "   AND stje004 = '",g_stbd_m.stbd003,"' ",   #經營方式
                   "   AND stjo005 = 'N'",
                   "   AND stjestus = 'Y' ",
                   "   AND stjesite = '",g_stbd_m.stbdsite,"' ",   #结算组织 #add by geza 20160815 #160815-00006#1                     
                   "   AND stje007 = '",g_stbd_m.stbd002,"' "   #商戶編號 

   LET l_sel_sql = cl_sql_add_mask(l_sel_sql)
   PREPARE astt840_sel_stje3 FROM l_sel_sql  
  #DISPLAY "[astt840_sel_stje]SQL: ",l_sel_sql
  
   LET l_cnt_sql =  " SELECT COUNT(1) FROM ( ",l_sel_sql," )"   
   PREPARE astt840_cnt_stje_4 FROM l_cnt_sql 
   
   LET l_cnt = 0
   EXECUTE astt840_cnt_stje_4 INTO l_cnt
#   IF SQLCA.sqlcode THEN
#      INITIALIZE g_errparam.* TO NULL
#      LET g_errparam.code = SQLCA.sqlcode
#      LET g_errparam.extend = ''
#      LET g_errparam.popup = TRUE
#      CALL cl_err()
#         
#      RETURN
#   END IF

   IF l_cnt = 1 THEN
      EXECUTE astt840_sel_stje3 INTO g_stbd_m.stbd001, g_stbd_m.stbd041, g_stbd_m.stbd002, g_stbd_m.stbd037,   #合約編號,合約狀態,帳款供應商編號,鋪位編號
                                    g_stbd_m.stbd049, g_stbd_m.stbd050, g_stbd_m.stbd042, g_stbd_m.stbdunit,  #管理品類,品牌,含發票否,結算中心
                                    g_stbd_m.stbd004, g_stbd_m.stbd005, g_stbd_m.stbd006                      #結算帳期,起始日期,結束日期
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam.* TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
            
         RETURN
      END IF
      
      IF NOT cl_null(g_stbd_m.stbd002) THEN
         SELECT pmac002 INTO g_stbd_m.stbd046
           FROM pmac_t
          WHERE pmacent = g_enterprise
            AND pmac001 = g_stbd_m.stbd002
            AND pmac003 = '1'
            AND pmac004 = 'Y'      
            AND pmacstus = 'Y'            
      END IF

      #預估應付日
      LET g_stbd_m.stbd038 = s_astt840_get_stbd038(g_stbd_m.stbd001,g_stbd_m.stbd006)
      
      #取得結算日期, 會計年度, 會計期別
      CALL astt840_get_period()

      DISPLAY BY NAME g_stbd_m.stbd001,g_stbd_m.stbd041,g_stbd_m.stbd002, g_stbd_m.stbd037,                               
                      g_stbd_m.stbd049,g_stbd_m.stbd050,g_stbd_m.stbd042,g_stbd_m.stbdunit,                                 
                      g_stbd_m.stbd004,g_stbd_m.stbd005,g_stbd_m.stbd006 , g_stbd_m.stbd038
                      
      LET g_stbd_m.stbd002_desc  = s_desc_get_trading_partner_abbr_desc(g_stbd_m.stbd002)
      LET g_stbd_m.stbd037_desc  = astt840_mhbe001_ref(g_stbd_m.stbd037) 
      LET g_stbd_m.stbd046_desc  = s_desc_get_trading_partner_abbr_desc(g_stbd_m.stbd046)
      LET g_stbd_m.stbd049_desc  = s_desc_get_rtaxl003_desc(g_stbd_m.stbd049) 
      LET g_stbd_m.stbd050_desc  = s_desc_get_acc_desc('2002',g_stbd_m.stbd050) 
      LET g_stbd_m.stbdunit_desc = s_desc_get_department_desc(g_stbd_m.stbdunit)      

      DISPLAY BY NAME g_stbd_m.stbd002_desc,g_stbd_m.stbd037_desc,g_stbd_m.stbd049_desc,
                      g_stbd_m.stbd046_desc,g_stbd_m.stbd050_desc
      #add by geza 20160802 #160728-00006#15(S)
      SELECT stje019,stje020,stje021 INTO g_stbd_m.stje019,g_stbd_m.stje020,g_stbd_m.stje021
        FROM stje_t
       WHERE stjeent = g_enterprise
         AND stje001 = g_stbd_m.stbd001
      DISPLAY BY NAME g_stbd_m.stje019,g_stbd_m.stje020,g_stbd_m.stje021      
      CALL astt840_stje019_ref()
      CALL astt840_stje020_ref()
      CALL astt840_stje021_ref()
      #add by geza 20160802 #160728-00006#15(E)
      LET g_stbd_m_o.stbd001  = g_stbd_m.stbd001
      LET g_stbd_m_o.stbd002  = g_stbd_m.stbd002
      LET g_stbd_m_o.stbd004  = g_stbd_m.stbd004
      LET g_stbd_m_o.stbd005  = g_stbd_m.stbd005
      LET g_stbd_m_o.stbd006  = g_stbd_m.stbd006
      LET g_stbd_m_o.stbd037  = g_stbd_m.stbd037 
      LET g_stbd_m_o.stbd038  = g_stbd_m.stbd038 
      LET g_stbd_m_o.stbd041  = g_stbd_m.stbd041
      LET g_stbd_m_o.stbd042  = g_stbd_m.stbd042
      LET g_stbd_m_o.stbd043  = g_stbd_m.stbd043
      LET g_stbd_m_o.stbd044  = g_stbd_m.stbd044
      LET g_stbd_m_o.stbd046  = g_stbd_m.stbd046
      LET g_stbd_m_o.stbd049  = g_stbd_m.stbd049
      LET g_stbd_m_o.stbd050  = g_stbd_m.stbd050
      LET g_stbd_m_o.stbdunit = g_stbd_m.stbdunit
      
      IF cl_null(g_stbd_m.stbd048) THEN
         CALL astt840_get_ooef_info()
      END IF      
   END IF
END FUNCTION

################################################################################
# Descriptions...: 根据铺位取得租賃合約資訊
# Memo...........:
# Usage..........: CALL astt840_get_stje008()
# Return code....: 無
# Date & Author..: 2016/06/24 By geza
# Modify.........:
################################################################################
PRIVATE FUNCTION astt840_get_stje008()
   DEFINE l_sel_sql       STRING
   DEFINE l_cnt_sql       STRING
   DEFINE l_cnt           LIKE type_t.num5   
   
   LET l_sel_sql = "SELECT stje001,stje005,stje007,stje008,  ",           #合約編號,合約狀態,供應商編號,鋪位編號
                   "       stje027,stje029,stje040,stje030,  ",           #管理品類,主品牌,含發票否,結算組織
                   "       stjoseq,stjo003,stjo004 ",                     #結算帳期,起始日期,結束日期
                   "  FROM stje_t ",
                   "       LEFT JOIN stjo_t t1  ON t1.stjoent = stjeent ",
                   "                           AND t1.stjo001 = stje001 ",           
                   "                           AND t1.stjoseq = (SELECT MIN(stjoseq)            ", 
                   "                                               FROM stjo_t t2               ",
                   "                                              WHERE t2.stjoent = t1.stjoent ",
                   "                                                AND t2.stjo001 = t1.stjo001 ",
                   "                                                AND t2.stjo005 = 'N')       ",
                   #mark by geza 20160815 #160815-00006#1(S)  
#                   "                           AND t1.stjo007 = (SELECT MAX(stjo007)            ",
#                   "                                               FROM stjo_t t3               ",
#                   "                                              WHERE t3.stjoent = t1.stjoent ",
#                   "                                                AND t3.stjo001 = t1.stjo001 ",
#                   "                                                AND t3.stjo005 = 'N')       ",
                   #mark by geza 20160815 #160815-00006#1(E)  
                   " WHERE stjeent = ",g_enterprise,
                   "   AND stje004 = '",g_stbd_m.stbd003,"' ",   #經營方式
                   "   AND stjo005 = 'N'",
                   "   AND stjestus = 'Y' ",
                   "   AND stjesite = '",g_stbd_m.stbdsite,"' ",   #结算组织 #add by geza 20160815 #160815-00006#1                     
                   "   AND stje008 = '",g_stbd_m.stbd037,"' "   #商戶編號 

   LET l_sel_sql = cl_sql_add_mask(l_sel_sql)
   PREPARE astt840_sel_stje5 FROM l_sel_sql  
  #DISPLAY "[astt840_sel_stje]SQL: ",l_sel_sql
  
   LET l_cnt_sql =  " SELECT COUNT(1) FROM ( ",l_sel_sql," )"   
   PREPARE astt840_cnt_stje_6 FROM l_cnt_sql 
   
   LET l_cnt = 0
   EXECUTE astt840_cnt_stje_6 INTO l_cnt
#   IF SQLCA.sqlcode THEN
#      INITIALIZE g_errparam.* TO NULL
#      LET g_errparam.code = SQLCA.sqlcode
#      LET g_errparam.extend = ''
#      LET g_errparam.popup = TRUE
#      CALL cl_err()
#         
#      RETURN
#   END IF

   IF l_cnt = 1 THEN
      EXECUTE astt840_sel_stje5 INTO g_stbd_m.stbd001, g_stbd_m.stbd041, g_stbd_m.stbd002, g_stbd_m.stbd037,   #合約編號,合約狀態,帳款供應商編號,鋪位編號
                                    g_stbd_m.stbd049, g_stbd_m.stbd050, g_stbd_m.stbd042, g_stbd_m.stbdunit,  #管理品類,品牌,含發票否,結算中心
                                    g_stbd_m.stbd004, g_stbd_m.stbd005, g_stbd_m.stbd006                      #結算帳期,起始日期,結束日期
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam.* TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
            
         RETURN
      END IF
      
      IF NOT cl_null(g_stbd_m.stbd002) THEN
         SELECT pmac002 INTO g_stbd_m.stbd046
           FROM pmac_t
          WHERE pmacent = g_enterprise
            AND pmac001 = g_stbd_m.stbd002
            AND pmac003 = '1'
            AND pmac004 = 'Y'      
            AND pmacstus = 'Y'            
      END IF

      #預估應付日
      LET g_stbd_m.stbd038 = s_astt840_get_stbd038(g_stbd_m.stbd001,g_stbd_m.stbd006)
      
      #取得結算日期, 會計年度, 會計期別
      CALL astt840_get_period()

      DISPLAY BY NAME g_stbd_m.stbd001,g_stbd_m.stbd041,g_stbd_m.stbd002, g_stbd_m.stbd037,                               
                      g_stbd_m.stbd049,g_stbd_m.stbd050,g_stbd_m.stbd042,g_stbd_m.stbdunit,                                 
                      g_stbd_m.stbd004,g_stbd_m.stbd005,g_stbd_m.stbd006 , g_stbd_m.stbd038
                      
      LET g_stbd_m.stbd002_desc  = s_desc_get_trading_partner_abbr_desc(g_stbd_m.stbd002)
      LET g_stbd_m.stbd037_desc  = astt840_mhbe001_ref(g_stbd_m.stbd037) 
      LET g_stbd_m.stbd046_desc  = s_desc_get_trading_partner_abbr_desc(g_stbd_m.stbd046)
      LET g_stbd_m.stbd049_desc  = s_desc_get_rtaxl003_desc(g_stbd_m.stbd049) 
      LET g_stbd_m.stbd050_desc  = s_desc_get_acc_desc('2002',g_stbd_m.stbd050) 
      LET g_stbd_m.stbdunit_desc = s_desc_get_department_desc(g_stbd_m.stbdunit)      

      DISPLAY BY NAME g_stbd_m.stbd002_desc,g_stbd_m.stbd037_desc,g_stbd_m.stbd049_desc,
                      g_stbd_m.stbd046_desc,g_stbd_m.stbd050_desc
      #add by geza 20160802 #160728-00006#15(S)
      SELECT stje019,stje020,stje021 INTO g_stbd_m.stje019,g_stbd_m.stje020,g_stbd_m.stje021
        FROM stje_t
       WHERE stjeent = g_enterprise
         AND stje001 = g_stbd_m.stbd001
      DISPLAY BY NAME g_stbd_m.stje019,g_stbd_m.stje020,g_stbd_m.stje021      
      CALL astt840_stje019_ref()
      CALL astt840_stje020_ref()
      CALL astt840_stje021_ref()
      #add by geza 20160802 #160728-00006#15(E)
      LET g_stbd_m_o.stbd001  = g_stbd_m.stbd001
      LET g_stbd_m_o.stbd002  = g_stbd_m.stbd002
      LET g_stbd_m_o.stbd004  = g_stbd_m.stbd004
      LET g_stbd_m_o.stbd005  = g_stbd_m.stbd005
      LET g_stbd_m_o.stbd006  = g_stbd_m.stbd006
      LET g_stbd_m_o.stbd037  = g_stbd_m.stbd037 
      LET g_stbd_m_o.stbd038  = g_stbd_m.stbd038 
      LET g_stbd_m_o.stbd041  = g_stbd_m.stbd041
      LET g_stbd_m_o.stbd042  = g_stbd_m.stbd042
      LET g_stbd_m_o.stbd043  = g_stbd_m.stbd043
      LET g_stbd_m_o.stbd044  = g_stbd_m.stbd044
      LET g_stbd_m_o.stbd046  = g_stbd_m.stbd046
      LET g_stbd_m_o.stbd049  = g_stbd_m.stbd049
      LET g_stbd_m_o.stbd050  = g_stbd_m.stbd050
      LET g_stbd_m_o.stbdunit = g_stbd_m.stbdunit
      
      IF cl_null(g_stbd_m.stbd048) THEN
         CALL astt840_get_ooef_info()
      END IF      
   END IF
END FUNCTION

################################################################################

################################################################################
PRIVATE FUNCTION astt840_stje019_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_stbd_m.stje019
   CALL ap_ref_array2(g_ref_fields,"SELECT mhaal003 FROM mhaal_t WHERE mhaalent='"||g_enterprise||"' AND mhaal001=? AND mhaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_stbd_m.stje019_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_stbd_m.stje019_desc
END FUNCTION

################################################################################

################################################################################
PRIVATE FUNCTION astt840_stje020_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_stbd_m.stje019
   LET g_ref_fields[2] = g_stbd_m.stje020
   CALL ap_ref_array2(g_ref_fields,"SELECT mhabl004 FROM mhabl_t WHERE mhablent='"||g_enterprise||"' AND mhabl001=?  AND mhabl002=? AND mhabl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_stbd_m.stje020_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_stbd_m.stje020_desc
END FUNCTION

################################################################################

################################################################################
PRIVATE FUNCTION astt840_stje021_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_stbd_m.stje019
   LET g_ref_fields[2] = g_stbd_m.stje020
   LET g_ref_fields[3] = g_stbd_m.stje021
   CALL ap_ref_array2(g_ref_fields,"SELECT mhacl005 FROM mhacl_t WHERE mhaclent='"||g_enterprise||"' AND mhacl001=? AND mhacl002=? AND mhacl003=? AND mhacl004='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_stbd_m.stje021_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_stbd_m.stje021_desc
END FUNCTION

 
{</section>}
 
