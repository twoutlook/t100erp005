#該程式未解開Section, 採用最新樣板產出!
{<section id="anmt540.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0036(2017-02-13 14:09:29), PR版次:0036(2017-02-14 15:51:17)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000716
#+ Filename...: anmt540
#+ Description: 收款單維護作業
#+ Creator....: 02114(2013-12-18 17:48:05)
#+ Modifier...: 08172 -SD/PR- 02114
 
{</section>}
 
{<section id="anmt540.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#150616-00026#8   2015/06/23 By apo      增加匯款性質時,給予票況為T:應收票據收款
#150401-00001#13  2015/07/17 By RayHuang statechange段問題修正
#150803-00018#1   2015/08/11 By Reanna   款別性質為10,20需把幣別鎖起來，其他不用鎖
#150807-00007#1   2015/08/14 By Reanna   現金類維持寫入，其他類型取消，topmenu維持有現金變動碼，但只限於10.現金類
#150818-00032#3   2015/08/23 By RayHuang nmbc_t新增兩個欄位
#150826           2015/08/26 By Reanna   匯率改取aooi160的銀行中價匯率
#150904-00006#1   2015/09/07 By Hans     增加nmbb027當執行anmt541時隱藏nmbb026/收款明細/收款來源，nmbb027寫入員工姓名nmbb026寫入EMPL
#150922-00021#4   2015/10/01 By Reanna   修改匯率要重推重評後本幣金額(nmbb066)
#151016-00015#1   2015/10/16 By Jessy    畫面加入本幣合計
#150921-00004#4   2015/10/22 By 03538    過交易對象欄位,雖有帶出開票人全名,但沒有真正寫進db
#151013-00016#3   2015/10/23 By RayHuang anmt540 增加審核取消
#151012-00014#6   2015/10/26 By RayHuang nmbc_t新增三個欄位(nmbc014~nmbc016)
#151013-00016#6   2015/10/28 By RayHuang glbc_t新增狀態碼
#151127-00006#2   2015/12/01 By 02599    当单据别参数'收款審核是否分開審核(D-FIN-4004)'=N时，anmt540直接执行复核，更新单据状态为V.已复核
#151125-00006#3   2015/12/08 By 07166    新增[編輯完單據後立即審核]功能
#151130-00015#2   2015/12/21 BY Xiaozg   根据是否可以更改單據日期 設定開放單據日期修改
#151222-00010#7   2015/12/24 By yangtt   1,当款别刷子028的款别性质ooia002 in(10,20)时,存提码nmbb002,现金码nmbb010   AFTERFIELD 里检查不可为空,
#                                        2,AFTER ROW 检查，当款别刷子028的款别性质ooia002 in(10,20)时，glbc档有相应的资料（glbcld+glbcdocno+glbcseq)
#150813-00015#14  2016/01/19 By 02599    增加日期控管，日期不可小于等于关账日期
#160122-00001#27  2016/02/15 By yangtt   添加交易帳戶編號用戶權限空管  
#160122-00001#27  2016/03/16 By 07673    添加交易帳戶編號用戶權限空管,增加部门权限
#160322-00025#2   2016/03/22 By 02114    nmbc_t增加nmbcorga记示画面上的来源组织栏位，原nmbcsite依旧记录资金中心
#160318-00005#28  2016/03/24 By 07900    重复错误信息修改 
#160321-00016#40  2016/03/30 By Jessy    將重複內容的錯誤訊息置換為公用錯誤訊息
#160318-00025#30  2016/04/08 by 07959    將重複內容的錯誤訊息置換為公用錯誤訊息
#160530-00005#4   2016/06/27 By 02599    当anmt540单别数D-FIN-4004=Y表示走anmt550复核流程，此时anmt540录入时存提码和现金变动码不为必输栏位，反之为必输栏位
#160705-00042#9   2016/07/13 By sakura   程式中寫死g_prog部分改寫MATCHES方式
#160708-00011#1   2016/07/13 By 01531    新增时，nmba002需赋值g_user
#160822-00018#1   2016/08/22 By Reanna   調整匯率取位問題，應用原幣幣別取位
#160816-00012#3   2016/09/12 By 01531    ANM增加资金中心，帐套，法人三个栏位权限
#160912-00024#1   2016/09/20 By 01531    来源组织权限控管
#160913-00017#6   2016/09/23 By 07900    ANM模组调整交易客商开窗
#160912-00026#1   2016/09/28 By 02114    收款单原币金额和本币金额不符合汇率转换也允许录入，审核复核也没有管控
#160919-00008#1   2016/10/10 By 01727    首款来源的营收单据应该限制为已经确认的单据
#161021-00050#10  2016/10/27 By Reanna   资金中心开窗需调整为q_ooef001_33 新增时where条件限定ooefstus= 'Y'查询时不限定此条件；
#                                        法人开窗调整为q_ooef001_2,要注意原本where条件中的权限设置要保留;
#                                        来源组织见excel"资金单身来源组织"
#161028-00051#1   2016/10/31 By 08732    財務權限修改
#161005-00003#4   2016/11/03 By 08171    新舊值調整
#161111-00031#1   2016/11/11 By 08732    161028-00051做的組織範圍重複限制了 需拿掉相同範圍的組織限制
#161104-00013#1   2016/11/15 By 01531    控卡anmt510&anmt540 票据号码若存在,则不可以登打
#161112-00002#1   2016/11/21 By 07900    anmt540新增時會自動帶資金中心預設值，沒有檢核預設值組織職能是否為資金組織，若不是資金組織，預設值應清空。
#161110-00001#2   2016/11/28 By 07900    ANM模組使用ooea_t/ooeaf_t的需替換ooef_t/ooefl_t
#161125-00052#2   2016/12/02 By 01531    畫面增加【開票帳號】字段, 置於開票銀行後方。不檢核,可空白。
#161212-00005#2   2016/12/14  by 02481    标准程式定义采用宣告模式,弃用.*写法
#161222-00013#1   2016/12/22 By 07900    相關錯誤訊息 anm-02954 程式段檢核 axrt400 的 SQL 請排除已作廢(xrdastus = 'X')的資料
#161226-00036#1   2016/12/28 By 01531    單據狀態為未確認時，會隱藏「交易對象變更」ACTION，但若立即切換狀態為已確認，「交易對象變更」ACTION沒有顯示
#161228-00019#1   2016/12/28 By 02114    交易对象改抓pmab表
#161227-00022#1   2016/12/28 By 01531    anmt540取消审核时，需检查是否已产生anmt520异动单。
#170105-00046#1   2017/01/05 By 01531    输入完本幣金額后，不需要反推原币金额
#161104-00046#14  2017/01/13 By 08729    單別預設值;資料依照單別user dept權限過濾單號
#170122-00008#1   2017/01/24 By 02599    增加ENT
#161213-00020#5   2017/02/10 by 08172    开窗检查调整
#170210-00051#1   2017/02/14 By 02114    缴款人员说明带值错误
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
PRIVATE type type_g_nmba_m        RECORD
       nmbasite LIKE nmba_t.nmbasite, 
   nmbasite_desc LIKE type_t.chr80, 
   nmba008 LIKE nmba_t.nmba008, 
   nmba008_desc LIKE type_t.chr80, 
   nmba001 LIKE nmba_t.nmba001, 
   nmba001_desc LIKE type_t.chr80, 
   nmbacomp LIKE nmba_t.nmbacomp, 
   nmbacomp_desc LIKE type_t.chr80, 
   nmba002 LIKE nmba_t.nmba002, 
   nmbadocno LIKE nmba_t.nmbadocno, 
   nmbadocno_desc LIKE type_t.chr80, 
   nmbadocdt LIKE nmba_t.nmbadocdt, 
   nmba003 LIKE nmba_t.nmba003, 
   nmba004 LIKE nmba_t.nmba004, 
   nmba005 LIKE nmba_t.nmba005, 
   nmba006 LIKE nmba_t.nmba006, 
   nmbastus LIKE nmba_t.nmbastus, 
   nmbaownid LIKE nmba_t.nmbaownid, 
   nmbaownid_desc LIKE type_t.chr80, 
   nmbaowndp LIKE nmba_t.nmbaowndp, 
   nmbaowndp_desc LIKE type_t.chr80, 
   nmbacrtid LIKE nmba_t.nmbacrtid, 
   nmbacrtid_desc LIKE type_t.chr80, 
   nmbacrtdp LIKE nmba_t.nmbacrtdp, 
   nmbacrtdp_desc LIKE type_t.chr80, 
   nmbacrtdt LIKE nmba_t.nmbacrtdt, 
   nmbamodid LIKE nmba_t.nmbamodid, 
   nmbamodid_desc LIKE type_t.chr80, 
   nmbamoddt LIKE nmba_t.nmbamoddt, 
   nmbacnfid LIKE nmba_t.nmbacnfid, 
   nmbacnfid_desc LIKE type_t.chr80, 
   nmbacnfdt LIKE nmba_t.nmbacnfdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_nmbb_d        RECORD
       nmbbseq LIKE nmbb_t.nmbbseq, 
   nmbborga LIKE nmbb_t.nmbborga, 
   nmbborga_desc LIKE type_t.chr500, 
   nmbb026 LIKE nmbb_t.nmbb026, 
   nmbb026_desc LIKE type_t.chr500, 
   nmbb027 LIKE nmbb_t.nmbb027, 
   nmbb027_desc LIKE type_t.chr500, 
   nmbb028 LIKE nmbb_t.nmbb028, 
   nmbb028_desc LIKE type_t.chr500, 
   nmbb003 LIKE nmbb_t.nmbb003, 
   nmbb030 LIKE nmbb_t.nmbb030, 
   nmbb043 LIKE nmbb_t.nmbb043, 
   nmbb043_desc LIKE type_t.chr500, 
   nmbb073 LIKE nmbb_t.nmbb073, 
   nmbb031 LIKE nmbb_t.nmbb031, 
   nmbb004 LIKE nmbb_t.nmbb004, 
   nmbb005 LIKE nmbb_t.nmbb005, 
   nmbb006 LIKE nmbb_t.nmbb006, 
   nmbb007 LIKE nmbb_t.nmbb007, 
   nmbb040 LIKE nmbb_t.nmbb040, 
   nmbb041 LIKE nmbb_t.nmbb041, 
   nmbb044 LIKE nmbb_t.nmbb044, 
   nmbb002 LIKE nmbb_t.nmbb002, 
   nmbb002_desc LIKE type_t.chr500, 
   nmbb010 LIKE nmbb_t.nmbb010, 
   nmbb010_desc LIKE type_t.chr500, 
   nmbblegl LIKE nmbb_t.nmbblegl, 
   nmbb045 LIKE nmbb_t.nmbb045, 
   nmbb029 LIKE nmbb_t.nmbb029, 
   nmbb039 LIKE nmbb_t.nmbb039, 
   nmbb001 LIKE nmbb_t.nmbb001, 
   nmbb011 LIKE nmbb_t.nmbb011, 
   nmbb012 LIKE nmbb_t.nmbb012, 
   nmbb013 LIKE nmbb_t.nmbb013, 
   nmbb014 LIKE nmbb_t.nmbb014, 
   nmbb015 LIKE nmbb_t.nmbb015, 
   nmbb016 LIKE nmbb_t.nmbb016, 
   nmbb017 LIKE nmbb_t.nmbb017, 
   nmbb018 LIKE nmbb_t.nmbb018, 
   nmbb019 LIKE nmbb_t.nmbb019, 
   nmbb020 LIKE nmbb_t.nmbb020, 
   nmbb021 LIKE nmbb_t.nmbb021, 
   nmbb022 LIKE nmbb_t.nmbb022, 
   nmbb023 LIKE nmbb_t.nmbb023, 
   nmbb024 LIKE nmbb_t.nmbb024, 
   nmbb053 LIKE nmbb_t.nmbb053, 
   nmbb054 LIKE nmbb_t.nmbb054, 
   nmbb008 LIKE nmbb_t.nmbb008, 
   nmbb009 LIKE nmbb_t.nmbb009, 
   nmbb056 LIKE nmbb_t.nmbb056, 
   nmbb057 LIKE nmbb_t.nmbb057, 
   nmbb058 LIKE nmbb_t.nmbb058, 
   nmbb059 LIKE nmbb_t.nmbb059, 
   nmbb060 LIKE nmbb_t.nmbb060, 
   nmbb061 LIKE nmbb_t.nmbb061, 
   nmbb062 LIKE nmbb_t.nmbb062, 
   nmbb066 LIKE nmbb_t.nmbb066, 
   nmbb067 LIKE nmbb_t.nmbb067, 
   nmbb068 LIKE nmbb_t.nmbb068, 
   nmbb042 LIKE nmbb_t.nmbb042, 
   nmbb069 LIKE nmbb_t.nmbb069, 
   nmbb025 LIKE nmbb_t.nmbb025
       END RECORD
PRIVATE TYPE type_g_nmbb3_d RECORD
       nmbuseq LIKE nmbu_t.nmbuseq, 
   nmbu001 LIKE nmbu_t.nmbu001, 
   nmbu001_desc LIKE type_t.chr500, 
   nmbuorga LIKE nmbu_t.nmbuorga, 
   nmbuorga_desc LIKE type_t.chr500, 
   nmbu003 LIKE nmbu_t.nmbu003, 
   nmbu004 LIKE nmbu_t.nmbu004, 
   nmbu005 LIKE nmbu_t.nmbu005, 
   nmbu006 LIKE nmbu_t.nmbu006, 
   nmbu007 LIKE nmbu_t.nmbu007, 
   nmbu002 LIKE nmbu_t.nmbu002
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_nmbacomp LIKE nmba_t.nmbacomp,
      b_nmbadocno LIKE nmba_t.nmbadocno
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_ooag004             LIKE ooag_t.ooag004
DEFINE g_glaald              LIKE glaa_t.glaald
DEFINE g_glaa001             LIKE glaa_t.glaa001
DEFINE g_glaa002             LIKE glaa_t.glaa002
DEFINE g_glaa015             LIKE glaa_t.glaa015
DEFINE g_glaa016             LIKE glaa_t.glaa016
DEFINE g_glaa017             LIKE glaa_t.glaa017
DEFINE g_glaa018             LIKE glaa_t.glaa018
DEFINE g_glaa019             LIKE glaa_t.glaa019
DEFINE g_glaa020             LIKE glaa_t.glaa020
DEFINE g_glaa021             LIKE glaa_t.glaa021
DEFINE g_glaa022             LIKE glaa_t.glaa022
DEFINE g_glaa003             LIKE glaa_t.glaa003   #2014/12/29 liuym aad
DEFINE g_glaa024             LIKE glaa_t.glaa024   #2014/12/29 liuym aad
#DEFINE g_glaald_1            LIKE glaa_t.glaald       #次帳套一
#DEFINE g_glaald_2            LIKE glaa_t.glaald       #次帳套二
#DEFINE g_glaa001_1           LIKE glaa_t.glaa001      #次帳套一使用幣別
#DEFINE g_glaa001_2           LIKE glaa_t.glaa001      #次帳套二使用幣別
DEFINE g_flag                LIKE type_t.chr1
DEFINE g_nmbb028             LIKE type_t.chr80
DEFINE g_ooia002             LIKE ooia_t.ooia002
DEFINE g_ooef001             LIKE ooef_t.ooef001
DEFINE g_ooef006             LIKE ooef_t.ooef006
DEFINE g_ooef016             LIKE ooef_t.ooef016
DEFINE g_wc2_table3          STRING
DEFINE g_para_data          LIKE type_t.chr80     #資金模組匯率來源
DEFINE g_ooed004_t    LIKE ooed_t.ooed004
DEFINE g_pmaal003     LIKE pmaal_t.pmaal003

 TYPE type_g_nmbb2_d RECORD
   nmbbseq LIKE nmbb_t.nmbbseq, 
   nmbb026_1 LIKE nmbb_t.nmbb026, 
   nmbb026_1_desc LIKE type_t.chr500, 
   nmbb028 LIKE nmbb_t.nmbb028, 
   nmbb028_desc1 LIKE type_t.chr10, 
   nmbb004 LIKE nmbb_t.nmbb004, 
   nmbb006 LIKE nmbb_t.nmbb006, 
   nmbb032 LIKE nmbb_t.nmbb032, 
   nmbb033 LIKE nmbb_t.nmbb033, 
   nmbb034 LIKE nmbb_t.nmbb034, 
   nmbb035 LIKE nmbb_t.nmbb035, 
   nmbb036 LIKE nmbb_t.nmbb036, 
   nmbb036_desc LIKE type_t.chr500, 
   nmbb037 LIKE nmbb_t.nmbb037, 
   nmbb038 LIKE nmbb_t.nmbb038
          END RECORD
DEFINE g_nmbb2_d   DYNAMIC ARRAY OF type_g_nmbb2_d
DEFINE g_nmbb2_d_t type_g_nmbb2_d
DEFINE g_nmbb2_d_o type_g_nmbb2_d
DEFINE g_site_wc             STRING                 #150707-00001#7
DEFINE g_comp_wc             STRING                 #150707-00001#7
DEFINE g_glaa005             LIKE glaa_t.glaa005    #150807-00007#1
DEFINE g_sql_bank            STRING                 #160122-00001#27 by 07673 
DEFINE g_conf                LIKE type_t.chr1   #160530-00005#4 add
#DEFINE g_wc_orga             STRING                 #161028-00051#1   add   161111-00031#1   mark
#DEFINE g_wc_cs_comp          STRING                 #161028-00051#1   add   161111-00031#1   mark
DEFINE g_user_dept_wc        STRING   #161104-00046#14
DEFINE g_user_dept_wc_q      STRING   #161104-00046#14
DEFINE g_user_slip_wc        STRING   #161104-00046#14
#end add-point
       
#模組變數(Module Variables)
DEFINE g_nmba_m          type_g_nmba_m
DEFINE g_nmba_m_t        type_g_nmba_m
DEFINE g_nmba_m_o        type_g_nmba_m
DEFINE g_nmba_m_mask_o   type_g_nmba_m #轉換遮罩前資料
DEFINE g_nmba_m_mask_n   type_g_nmba_m #轉換遮罩後資料
 
   DEFINE g_nmbacomp_t LIKE nmba_t.nmbacomp
DEFINE g_nmbadocno_t LIKE nmba_t.nmbadocno
 
 
DEFINE g_nmbb_d          DYNAMIC ARRAY OF type_g_nmbb_d
DEFINE g_nmbb_d_t        type_g_nmbb_d
DEFINE g_nmbb_d_o        type_g_nmbb_d
DEFINE g_nmbb_d_mask_o   DYNAMIC ARRAY OF type_g_nmbb_d #轉換遮罩前資料
DEFINE g_nmbb_d_mask_n   DYNAMIC ARRAY OF type_g_nmbb_d #轉換遮罩後資料
DEFINE g_nmbb3_d          DYNAMIC ARRAY OF type_g_nmbb3_d
DEFINE g_nmbb3_d_t        type_g_nmbb3_d
DEFINE g_nmbb3_d_o        type_g_nmbb3_d
DEFINE g_nmbb3_d_mask_o   DYNAMIC ARRAY OF type_g_nmbb3_d #轉換遮罩前資料
DEFINE g_nmbb3_d_mask_n   DYNAMIC ARRAY OF type_g_nmbb3_d #轉換遮罩後資料
 
 
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
 
{<section id="anmt540.main" >}
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
   CALL cl_ap_init("anm","")
 
   #add-point:作業初始化 name="main.init"
   #161104-00046#14-----s
   #建立與單頭array相同的temptable
   CALL s_aooi200def_create('','g_nmba_m','','','','','','')RETURNING g_sub_success
   
   #單別控制組
   LET g_user_dept_wc = ''
   CALL s_fin_get_user_dept_control('nmbacomp','','nmbaent','nmbadocno') RETURNING g_user_dept_wc
   #開窗使用
   LET g_user_dept_wc_q = g_user_dept_wc
   
   CALL s_control_get_docno_sql(g_user,g_dept) RETURNING g_sub_success,g_user_slip_wc  
   #161104-00046#14-----e
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT nmbasite,'',nmba008,'',nmba001,'',nmbacomp,'',nmba002,nmbadocno,'',nmbadocdt, 
       nmba003,nmba004,nmba005,nmba006,nmbastus,nmbaownid,'',nmbaowndp,'',nmbacrtid,'',nmbacrtdp,'', 
       nmbacrtdt,nmbamodid,'',nmbamoddt,nmbacnfid,'',nmbacnfdt", 
                      " FROM nmba_t",
                      " WHERE nmbaent= ? AND nmbacomp=? AND nmbadocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE anmt540_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.nmbasite,t0.nmba008,t0.nmba001,t0.nmbacomp,t0.nmba002,t0.nmbadocno, 
       t0.nmbadocdt,t0.nmba003,t0.nmba004,t0.nmba005,t0.nmba006,t0.nmbastus,t0.nmbaownid,t0.nmbaowndp, 
       t0.nmbacrtid,t0.nmbacrtdp,t0.nmbacrtdt,t0.nmbamodid,t0.nmbamoddt,t0.nmbacnfid,t0.nmbacnfdt,t1.ooefl003 , 
       t2.ooag011 ,t3.ooefl003 ,t4.ooefl003 ,t5.ooag011 ,t6.ooefl003 ,t7.ooag011 ,t8.ooefl003 ,t9.ooag011 , 
       t10.ooag011",
               " FROM nmba_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.nmbasite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.nmba008  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.nmba001 AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.nmbacomp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.nmbaownid  ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent="||g_enterprise||" AND t6.ooefl001=t0.nmbaowndp AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=t0.nmbacrtid  ",
               " LEFT JOIN ooefl_t t8 ON t8.ooeflent="||g_enterprise||" AND t8.ooefl001=t0.nmbacrtdp AND t8.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t9 ON t9.ooagent="||g_enterprise||" AND t9.ooag001=t0.nmbamodid  ",
               " LEFT JOIN ooag_t t10 ON t10.ooagent="||g_enterprise||" AND t10.ooag001=t0.nmbacnfid  ",
 
               " WHERE t0.nmbaent = " ||g_enterprise|| " AND t0.nmbacomp = ? AND t0.nmbadocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE anmt540_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_anmt540 WITH FORM cl_ap_formpath("anm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL anmt540_init()   
 
      #進入選單 Menu (="N")
      CALL anmt540_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_anmt540
      
   END IF 
   
   CLOSE anmt540_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="anmt540.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION anmt540_init()
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
      CALL cl_set_combo_scc_part('nmbastus','13','N,Y,V,A,D,R,W,X')
 
      CALL cl_set_combo_scc('nmbb044','8715') 
   CALL cl_set_combo_scc('nmbb001','8701') 
   CALL cl_set_combo_scc('nmbb042','8714') 
   CALL cl_set_combo_scc('nmbu003','8719') 
   CALL cl_set_combo_scc('nmbu004','8720') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
   CALL g_idx_group.addAttribute("'2',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc_part('nmbb001','8701','1,2')    
   CALL s_fin_create_account_center_tmp() 
      #150904-00006#1 ---s---
   #IF g_prog = 'anmt541' THEN        #160705-00042#9 160713 by sakura mark
   IF g_prog MATCHES 'anmt541' THEN   #160705-00042#9 160713 by sakura add
      CALL cl_set_comp_visible('page2,page_3,nmbb026,nmbb026_desc',FALSE)
   ELSE
      CALL cl_set_comp_visible('nmbb027,nmbb027_desc',FALSE)
   END IF
    #150904-00006#1 ---e---
   #160122-00001#27 by 07673--add--str--
   LET g_sql_bank=NULL
   CALL s_anmi120_get_bank_account_sql(g_user,g_dept) RETURNING g_sub_success,g_sql_bank
   #160122-00001#27 by 07673--add--end
   #161111-00031#1   mark---s
   ##161028-00051#1   add---s
   #CALL s_fin_azzi800_sons_query(g_today)
   #CALL s_fin_account_center_sons_str() RETURNING g_wc_orga
   #CALL s_fin_get_wc_str(g_wc_orga) RETURNING g_wc_orga
   #CALL s_fin_account_center_comp_str() RETURNING g_wc_cs_comp
   #CALL s_fin_get_wc_str(g_wc_cs_comp) RETURNING g_wc_cs_comp
   ##161028-00051#1   add---e
   #161111-00031#1   mark---e
   #end add-point
   
   #初始化搜尋條件
   CALL anmt540_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="anmt540.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION anmt540_ui_dialog()
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
   DEFINE l_year    LIKE type_t.num5
   DEFINE l_month   LIKE type_t.num5
   DEFINE l_n       LIKE type_t.num10          #151125-00006#3
   #end add-point
   
   #add-point:Function前置處理  name="ui_dialog.pre_function"
   
   #end add-point
   
   CALL cl_set_act_visible("accept,cancel", FALSE)
 
   
   #action default動作
   #應用 a42 樣板自動產生(Version:3)
   #進入程式時預設執行的動作
   CASE g_actdefault
      WHEN "insert"
         LET g_action_choice="insert"
         LET g_actdefault = ""
         IF cl_auth_chk_act("insert") THEN
            CALL anmt540_insert()
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
         INITIALIZE g_nmba_m.* TO NULL
         CALL g_nmbb_d.clear()
         CALL g_nmbb3_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL anmt540_init()
      END IF
   
            
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
    
         DISPLAY ARRAY g_nmbb_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL anmt540_idx_chk()
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
               CALL anmt540_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
         #第一階單身段落
         DISPLAY ARRAY g_nmbb3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL anmt540_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[2] = l_ac
               CALL g_idx_group.addAttribute("'2',",l_ac)
               
               #add-point:page2, before row動作 name="ui_dialog.body3.before_row"
               
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
               CALL anmt540_idx_chk()
               #add-point:page2自定義行為 name="ui_dialog.body3.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
         
            #add-point:page2自定義行為 name="ui_dialog.body3.action"
            
            #end add-point
         
         END DISPLAY
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_nmbb2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               CALL anmt540_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac

            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               CALL anmt540_idx_chk()
               LET g_current_page = 2
         END DISPLAY
         #end add-point
         
      
         BEFORE DIALOG
            #先填充browser資料
            CALL anmt540_browser_fill("")
            CALL cl_notice()
            CALL cl_navigator_setting(g_current_idx, g_detail_cnt)
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_current_sw = FALSE
            #回歸舊筆數位置 (回到當時異動的筆數)
            
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
               CALL anmt540_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL anmt540_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL anmt540_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL anmt540_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL anmt540_set_act_visible()   
            CALL anmt540_set_act_no_visible()
            IF NOT (g_nmba_m.nmbacomp IS NULL
              OR g_nmba_m.nmbadocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " nmbaent = " ||g_enterprise|| " AND",
                                  " nmbacomp = '", g_nmba_m.nmbacomp, "' "
                                  ," AND nmbadocno = '", g_nmba_m.nmbadocno, "' "
 
               #填到對應位置
               CALL anmt540_browser_fill("")
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
                     WHEN la_wc[li_idx].tableid = "nmba_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "nmbb_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "nmbu_t" 
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
               CALL anmt540_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                     WHEN la_wc[li_idx].tableid = "nmba_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "nmbb_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "nmbu_t" 
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
                  CALL anmt540_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL anmt540_fetch("F")
                  END IF
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
          
         
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL anmt540_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL anmt540_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL anmt540_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL anmt540_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL anmt540_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL anmt540_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL anmt540_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL anmt540_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL anmt540_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL anmt540_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_nmbb_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_nmbb3_d)
                  LET g_export_id[2]   = "s_detail3"
 
                  #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
                  LET g_export_node[3] = base.typeInfo.create(g_nmbb2_d)
                  LET g_export_id[3]   = "s_detail2"
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
         ON ACTION approval
            LET g_action_choice="approval"
            IF cl_auth_chk_act("approval") THEN
               
               #add-point:ON ACTION approval name="menu.approval"
               #直接審核
               CALL anmt540_approval()
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modi_nmbb026
            LET g_action_choice="modi_nmbb026"
            IF cl_auth_chk_act("modi_nmbb026") THEN
               
               #add-point:ON ACTION modi_nmbb026 name="menu.modi_nmbb026"
               #IF g_nmba_m.nmbastus = 'Y' THEN #161226-00036#1 mark
               IF g_nmba_m.nmbastus = 'Y' OR g_nmba_m.nmbastus = 'V' THEN  #161226-00036#1 add 
                  CALL anmt550_01(g_nmba_m.nmbacomp,g_nmba_m.nmbadocno)
                  CALL anmt540_b_fill()
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL anmt540_modify()
               #add-point:ON ACTION modify name="menu.modify"
               #151125-00006#3--s           
               CALL anmt540_immediately_conf()
               SELECT COUNT(*) INTO l_n FROM nmba_t
                WHERE nmbaent = g_enterprise AND nmbacomp = g_nmba_m.nmbacomp AND nmbadocno = g_nmba_m.nmbadocno
                IF l_n > 0 THEN CALL anmt540_ui_headershow() END IF
               #151125-00006#3--e
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL anmt540_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               #151125-00006#3--s           
               CALL anmt540_immediately_conf()
               SELECT COUNT(*) INTO l_n FROM nmba_t
                WHERE nmbaent = g_enterprise AND nmbacomp = g_nmba_m.nmbacomp AND nmbadocno = g_nmba_m.nmbadocno
                IF l_n > 0 THEN CALL anmt540_ui_headershow() END IF
               #151125-00006#3--e
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL anmt540_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL anmt540_insert()
               #add-point:ON ACTION insert name="menu.insert"
               #151125-00006#3--s           
               CALL anmt540_immediately_conf()
               SELECT COUNT(*) INTO l_n FROM nmba_t
                WHERE nmbaent = g_enterprise AND nmbacomp = g_nmba_m.nmbacomp AND nmbadocno = g_nmba_m.nmbadocno
                IF l_n > 0 THEN CALL anmt540_ui_headershow() END IF
               #151125-00006#3--e
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               # CALL anmr540_g01("nmbaent ="|| g_enterprise ||" AND nmbadocno ='"|| g_nmba_m.nmbadocno||"'")
               LET g_rep_wc = "nmbaent ="|| g_enterprise ||" AND nmbadocno ='"|| g_nmba_m.nmbadocno||"'"  
               #END add-point
               &include "erp/anm/anmt540_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               # CALL anmr540_g01("nmbaent ="|| g_enterprise ||" AND nmbadocno ='"|| g_nmba_m.nmbadocno||"'")
               LET g_rep_wc = "nmbaent ="|| g_enterprise ||" AND nmbadocno ='"|| g_nmba_m.nmbadocno||"'"  
               #END add-point
               &include "erp/anm/anmt540_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL anmt540_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail3",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION unverify
            LET g_action_choice="unverify"
            IF cl_auth_chk_act("unverify") THEN
               
               #add-point:ON ACTION unverify name="menu.unverify"
               CALL anmt540_unverify()    #151013-00016#3
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION s_cashflow
            LET g_action_choice="s_cashflow"
            IF cl_auth_chk_act("s_cashflow") THEN
               
               #add-point:ON ACTION s_cashflow name="menu.s_cashflow"
               LET l_year = YEAR(g_nmba_m.nmbadocdt)
               LET l_month = MONTH(g_nmba_m.nmbadocdt)
              #IF g_detail_idx > 0 THEN          #150707-00001#7 mark
               IF g_nmbb_d.getLength() > 0 THEN  #150707-00001#7
                  #150807-00007#1 add ------
                  #款別性質=10&20才寫入一筆現金變動碼
                  SELECT ooia002 INTO g_ooia002
                    FROM ooia_t
                   WHERE ooiaent = g_enterprise
                     AND ooia001 = g_nmbb_d[g_detail_idx].nmbb028
                  IF g_ooia002 = '10' OR g_ooia002 = '20' THEN
                  #150807-00007#1 add end---
                                          #帳別      #匯款編號         #年度   #期別  #借貸別 #作業編號暂时给anmt550  #單身項次
                     CALL s_cashflow_nm(g_glaald,g_nmba_m.nmbadocno,l_year,l_month,'1','anmt550',g_nmbb_d[g_detail_idx].nmbbseq)
                  #150807-00007#1 add ------
                  ELSE
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'anm-02950'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     CONTINUE DIALOG
                  END IF
                  #150807-00007#1 add end---
               END IF
               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL anmt540_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL anmt540_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL anmt540_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_nmba_m.nmbadocdt)
 
 
 
         
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
 
{<section id="anmt540.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION anmt540_browser_fill(ps_page_action)
   #add-point:browser_fill段define(客製用) name="browser_fill.define_customerization"
   
   #end add-point  
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   DEFINE l_comp_str        STRING #160816-00012#3 add 
   
   IF cl_null(g_wc) THEN 
      #LET g_wc = " nmba003 = 'anmt540'  " #150904-00006#1
      LET g_wc = "nmba003 = '",g_prog,"' " #150904-00006#1
   ELSE
      #LET g_wc = g_wc," AND nmba003 = 'anmt540'"      #150904-00006#1
      LET g_wc = g_wc," AND nmba003 =  '",g_prog,"' " #150904-00006#1
   END IF 

   #160816-00012#3 add s---
   CALL s_axrt300_get_site(g_user,'','3') RETURNING l_comp_str
   LET l_comp_str = cl_replace_str(l_comp_str,"ooef017","nmbacomp")
   LET g_wc = g_wc," AND ",l_comp_str  
   #160816-00012#3 add e---
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
  # CALL g_nmbb2_d.clear()
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT nmbacomp,nmbadocno ",
                      " FROM nmba_t ",
                      " ",
                      " LEFT JOIN nmbb_t ON nmbbent = nmbaent AND nmbacomp = nmbbcomp AND nmbadocno = nmbbdocno ", "  ",
                      #add-point:browser_fill段sql(nmbb_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
                      " LEFT JOIN nmbu_t ON nmbuent = nmbaent AND nmbacomp = nmbucomp AND nmbadocno = nmbudocno", "  ",
                      #add-point:browser_fill段sql(nmbu_t1) name="browser_fill.cnt.join.nmbu_t1"
                      
                      #end add-point
 
 
 
                      " ", 
                      " ", 
                      " ",                      
 
 
 
                      " WHERE nmbaent = " ||g_enterprise|| " AND nmbbent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("nmba_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT nmbacomp,nmbadocno ",
                      " FROM nmba_t ", 
                      "  ",
                      "  ",
                      " WHERE nmbaent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("nmba_t")
   END IF
   
   #add-point:browser_fill,cnt wc name="browser_fill.cnt_sqlwc"
   #160122-00001#27--add---str
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT nmbacomp,nmbadocno ",
                      " FROM nmba_t ",
                      " LEFT JOIN nmbu_t ON nmbuent = nmbaent AND nmbacomp = nmbucomp AND nmbadocno = nmbudocno", "  ",
                      ",nmbb_t ",
                      " WHERE nmbbent = nmbaent AND nmbacomp = nmbbcomp AND nmbadocno = nmbbdocno ",
                      "   AND nmbaent = '" ||g_enterprise|| "' AND nmbbent = '" ||g_enterprise|| "' ",
                      "   AND nmbb003 IN (",g_sql_bank,")",
                      "   AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("nmba_t"),
                      " UNION ",
                      " SELECT DISTINCT nmbacomp,nmbadocno ",
                      " FROM nmba_t ",
                      " ",
                      " LEFT JOIN nmbb_t ON nmbbent = nmbaent AND nmbacomp = nmbbcomp AND nmbadocno = nmbbdocno ", "  ",
                      " LEFT JOIN nmbu_t ON nmbuent = nmbaent AND nmbacomp = nmbucomp AND nmbadocno = nmbudocno", "  ",
                      " WHERE nmbaent = '" ||g_enterprise|| "' AND nmbbent = '" ||g_enterprise|| "' ",
                      "   AND TRIM(nmbb003) IS NULL ",
                      "   AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("nmba_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT nmbacomp,nmbadocno ",
                      " FROM nmba_t,nmbb_t ", 
                      " WHERE nmbbent = nmbaent AND nmbacomp = nmbbcomp AND nmbadocno = nmbbdocno ",
                      "   AND nmbaent = '" ||g_enterprise|| "' ",
                      "   AND nmbb003 IN (",g_sql_bank,")",
                      "   AND ",l_wc CLIPPED, cl_sql_add_filter("nmba_t"),
                      "  UNION ",
                      " SELECT DISTINCT nmbacomp,nmbadocno ",
                      " FROM nmba_t ", 
                      " LEFT JOIN nmbb_t ON nmbbent = nmbaent AND nmbacomp = nmbbcomp AND nmbadocno = nmbbdocno ", "  ",
                      " WHERE nmbaent = '" ||g_enterprise|| "' ",
                      "   AND TRIM(nmbb003) IS NULL",
                      "   AND ",l_wc CLIPPED, cl_sql_add_filter("nmba_t")
   END IF
   #160122-00001#27--add---end
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
      INITIALIZE g_nmba_m.* TO NULL
      CALL g_nmbb_d.clear()        
      CALL g_nmbb3_d.clear() 
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.nmbacomp,t0.nmbadocno Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.nmbastus,t0.nmbacomp,t0.nmbadocno ",
                  " FROM nmba_t t0",
                  "  ",
                  "  LEFT JOIN nmbb_t ON nmbbent = nmbaent AND nmbacomp = nmbbcomp AND nmbadocno = nmbbdocno ", "  ", 
                  #add-point:browser_fill段sql(nmbb_t1) name="browser_fill.join.nmbb_t1"
                  
                  #end add-point
                  "  LEFT JOIN nmbu_t ON nmbuent = nmbaent AND nmbacomp = nmbucomp AND nmbadocno = nmbudocno", "  ", 
                  #add-point:browser_fill段sql(nmbu_t1) name="browser_fill.join.nmbu_t1"
                  
                  #end add-point
 
 
 
                  " ", 
                  " ",                      
 
 
 
                  
                  " WHERE t0.nmbaent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("nmba_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.nmbastus,t0.nmbacomp,t0.nmbadocno ",
                  " FROM nmba_t t0",
                  "  ",
                  
                  " WHERE t0.nmbaent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("nmba_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   #160122-00001#27--add---str
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.nmbastus,t0.nmbacomp,t0.nmbadocno ",
                  " FROM nmba_t t0",
                  "  LEFT JOIN nmbu_t ON nmbuent = nmbaent AND nmbacomp = nmbucomp AND nmbadocno = nmbudocno", "  ", 
                  "  ,nmbb_t",
                  " WHERE nmbbent = t0.nmbaent AND t0.nmbacomp = nmbbcomp AND t0.nmbadocno = nmbbdocno",
                  "   AND t0.nmbaent = '" ||g_enterprise|| "' ",
                  "   AND nmbb003 IN (",g_sql_bank,")",
                  "   AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("nmba_t"),
                  "  UNION ",
                  " SELECT DISTINCT t1.nmbastus,t1.nmbacomp,t1.nmbadocno ",
                  " FROM nmba_t t1",
                  "  ",
                  "  LEFT JOIN nmbb_t ON nmbbent = nmbaent AND nmbacomp = nmbbcomp AND nmbadocno = nmbbdocno ", "  ", 
                  "  LEFT JOIN nmbu_t ON nmbuent = nmbaent AND nmbacomp = nmbucomp AND nmbadocno = nmbudocno", "  ", 
                  " WHERE t1.nmbaent = '" ||g_enterprise|| "' ",
                  "   AND TRIM(nmbb003) IS NULL",
                  "   AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("nmba_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.nmbastus,t0.nmbacomp,t0.nmbadocno ",
                  " FROM nmba_t t0,nmbb_t",
                  " WHERE nmbbent = t0.nmbaent AND t0.nmbacomp = nmbbcomp AND t0.nmbadocno = nmbbdocno ",
                  "   AND t0.nmbaent = '" ||g_enterprise|| "' ",
                  "   AND nmbb003 IN (",g_sql_bank,")",
                  "   AND ",l_wc, cl_sql_add_filter("nmba_t"),
                  "  UNION ",
                  " SELECT DISTINCT t1.nmbastus,t1.nmbacomp,t1.nmbadocno ",
                  " FROM nmba_t t1",
                  "  LEFT JOIN nmbb_t ON nmbbent = nmbaent AND nmbacomp = nmbbcomp AND nmbadocno = nmbbdocno ",
                  " WHERE t1.nmbaent = '" ||g_enterprise|| "' ",
                  "   AND TRIM(nmbb003) IS NULL",
                  "   AND ",l_wc, cl_sql_add_filter("nmba_t")
   END IF
   #160122-00001#27--add---end
   #end add-point
   LET g_sql = g_sql, " ORDER BY nmbacomp,nmbadocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"nmba_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_nmbacomp,g_browser[g_cnt].b_nmbadocno 
 
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
      
      
               #應用 a24 樣板自動產生(Version:3)
      #browser顯示圖片
      CASE g_browser[g_cnt].b_statepic
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/unconfirmed.png"
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/confirmed.png"
         WHEN "V"
            LET g_browser[g_cnt].b_statepic = "stus/16/verify.png"
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
   
   IF cl_null(g_browser[g_cnt].b_nmbacomp) THEN
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
 
{<section id="anmt540.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION anmt540_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_nmba_m.nmbacomp = g_browser[g_current_idx].b_nmbacomp   
   LET g_nmba_m.nmbadocno = g_browser[g_current_idx].b_nmbadocno   
 
   EXECUTE anmt540_master_referesh USING g_nmba_m.nmbacomp,g_nmba_m.nmbadocno INTO g_nmba_m.nmbasite, 
       g_nmba_m.nmba008,g_nmba_m.nmba001,g_nmba_m.nmbacomp,g_nmba_m.nmba002,g_nmba_m.nmbadocno,g_nmba_m.nmbadocdt, 
       g_nmba_m.nmba003,g_nmba_m.nmba004,g_nmba_m.nmba005,g_nmba_m.nmba006,g_nmba_m.nmbastus,g_nmba_m.nmbaownid, 
       g_nmba_m.nmbaowndp,g_nmba_m.nmbacrtid,g_nmba_m.nmbacrtdp,g_nmba_m.nmbacrtdt,g_nmba_m.nmbamodid, 
       g_nmba_m.nmbamoddt,g_nmba_m.nmbacnfid,g_nmba_m.nmbacnfdt,g_nmba_m.nmbasite_desc,g_nmba_m.nmba008_desc, 
       g_nmba_m.nmba001_desc,g_nmba_m.nmbacomp_desc,g_nmba_m.nmbaownid_desc,g_nmba_m.nmbaowndp_desc, 
       g_nmba_m.nmbacrtid_desc,g_nmba_m.nmbacrtdp_desc,g_nmba_m.nmbamodid_desc,g_nmba_m.nmbacnfid_desc 
 
   
   CALL anmt540_nmba_t_mask()
   CALL anmt540_show()
      
END FUNCTION
 
{</section>}
 
{<section id="anmt540.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION anmt540_ui_detailshow()
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
 
{<section id="anmt540.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION anmt540_ui_browser_refresh()
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
      IF g_browser[l_i].b_nmbacomp = g_nmba_m.nmbacomp 
         AND g_browser[l_i].b_nmbadocno = g_nmba_m.nmbadocno 
 
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
 
{<section id="anmt540.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION anmt540_construct()
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
   DEFINE l_wc        STRING #160816-00012#3 add 
   #end add-point    
   
   #add-point:Function前置處理  name="cs.pre_function"
   
   #end add-point
    
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_nmba_m.* TO NULL
   CALL g_nmbb_d.clear()        
   CALL g_nmbb3_d.clear() 
 
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
   INITIALIZE g_wc2_table2 TO NULL
 
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前 name="cs.before_construct"
   INITIALIZE g_wc2_table3 TO NULL
   CALL g_nmbb2_d.clear() 
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON nmbasite,nmba008,nmba001,nmbacomp,nmba002,nmbadocno,nmbadocno_desc,nmbadocdt, 
          nmba003,nmba004,nmba005,nmba006,nmbastus,nmbaownid,nmbaowndp,nmbacrtid,nmbacrtdp,nmbacrtdt, 
          nmbamodid,nmbamoddt,nmbacnfid,nmbacnfdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<nmbacrtdt>>----
         AFTER FIELD nmbacrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<nmbamoddt>>----
         AFTER FIELD nmbamoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<nmbacnfdt>>----
         AFTER FIELD nmbacnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<nmbapstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.nmbasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbasite
            #add-point:ON ACTION controlp INFIELD nmbasite name="construct.c.nmbasite"
            #資金中心
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1=g_user
#            LET g_qryparam.where = " ooef206 = 'Y'"  #161213-00020#5 20170210 mark by 08172
            #CALL q_ooef001()    #161021-00050#10 mark
            CALL q_ooef001_33()  #161021-00050#10
            DISPLAY g_qryparam.return1 TO nmbasite
            NEXT FIELD nmbasite
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbasite
            #add-point:BEFORE FIELD nmbasite name="construct.b.nmbasite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbasite
            
            #add-point:AFTER FIELD nmbasite name="construct.a.nmbasite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmba008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmba008
            #add-point:ON ACTION controlp INFIELD nmba008 name="construct.c.nmba008"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmba008  #顯示到畫面上
               #DISPLAY g_qryparam.return2 TO oofa011 #全名 

            NEXT FIELD nmba008                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmba008
            #add-point:BEFORE FIELD nmba008 name="construct.b.nmba008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmba008
            
            #add-point:AFTER FIELD nmba008 name="construct.a.nmba008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmba001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmba001
            #add-point:ON ACTION controlp INFIELD nmba001 name="construct.c.nmba001"
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_today         #150707-00001#7
            CALL q_ooeg001_4()                    #150707-00001#7
           #CALL q_ooef001()                      #150707-00001#7 mark
            DISPLAY g_qryparam.return1 TO nmba001  #顯示到畫面上

            NEXT FIELD nmba001                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmba001
            #add-point:BEFORE FIELD nmba001 name="construct.b.nmba001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmba001
            
            #add-point:AFTER FIELD nmba001 name="construct.a.nmba001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmbacomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbacomp
            #add-point:ON ACTION controlp INFIELD nmbacomp name="construct.c.nmbacomp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
#            LET g_qryparam.where = " ooef003 = 'Y' " #161213-00020#5 20170210 mark by 08172
            #160816-00012#3 Add  ---(S)---
            CALL s_axrt300_get_site(g_user,'','3') RETURNING l_wc
            #LET g_qryparam.where = g_qryparam.where," AND ",l_wc CLIPPED  #161028-00051#1   mark
            #LET g_qryparam.where = g_qryparam.where," AND ",l_wc CLIPPED," AND ooef001 IN ",g_wc_cs_comp   #161028-00051#1   add   #161111-00031#1   mark
#            LET g_qryparam.where = g_qryparam.where," AND ",l_wc CLIPPED   #161111-00031#1   add #161213-00020#5 20170210 mark by 08172
            LET g_qryparam.where = l_wc CLIPPED   #161111-00031#1   add #161213-00020#5 20170210 add by 08172
            #160816-00012#3 Add  ---(E)---
            #CALL q_ooef001()  #161021-00050#10 mark
            CALL q_ooef001_2() #161021-00050#10
            DISPLAY g_qryparam.return1 TO nmbacomp
            NEXT FIELD nmbacomp
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbacomp
            #add-point:BEFORE FIELD nmbacomp name="construct.b.nmbacomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbacomp
            
            #add-point:AFTER FIELD nmbacomp name="construct.a.nmbacomp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmba002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmba002
            #add-point:ON ACTION controlp INFIELD nmba002 name="construct.c.nmba002"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmba002  #顯示到畫面上
            NEXT FIELD nmba002                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmba002
            #add-point:BEFORE FIELD nmba002 name="construct.b.nmba002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmba002
            
            #add-point:AFTER FIELD nmba002 name="construct.a.nmba002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmbadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbadocno
            #add-point:ON ACTION controlp INFIELD nmbadocno name="construct.c.nmbadocno"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			#LET g_qryparam.where = " nmba003 = 'anmt540'"   #150904-00006#1
			 LET g_qryparam.where = "nmba003 = '",g_prog,"' " #150904-00006#1
			   #161104-00046#14-----s
            #單別權限控管
            IF NOT cl_null(g_user_dept_wc_q) AND NOT g_user_dept_wc_q = ' 1=1'  THEN
               LET g_qryparam.where = g_qryparam.where," AND ",g_user_dept_wc_q CLIPPED
            END IF
            #161104-00046#14-----e
            CALL q_nmbadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbadocno  #顯示到畫面上

            NEXT FIELD nmbadocno                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbadocno
            #add-point:BEFORE FIELD nmbadocno name="construct.b.nmbadocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbadocno
            
            #add-point:AFTER FIELD nmbadocno name="construct.a.nmbadocno"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbadocno_desc
            #add-point:BEFORE FIELD nmbadocno_desc name="construct.b.nmbadocno_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbadocno_desc
            
            #add-point:AFTER FIELD nmbadocno_desc name="construct.a.nmbadocno_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmbadocno_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbadocno_desc
            #add-point:ON ACTION controlp INFIELD nmbadocno_desc name="construct.c.nmbadocno_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbadocdt
            #add-point:BEFORE FIELD nmbadocdt name="construct.b.nmbadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbadocdt
            
            #add-point:AFTER FIELD nmbadocdt name="construct.a.nmbadocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmbadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbadocdt
            #add-point:ON ACTION controlp INFIELD nmbadocdt name="construct.c.nmbadocdt"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmba003
            #add-point:BEFORE FIELD nmba003 name="construct.b.nmba003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmba003
            
            #add-point:AFTER FIELD nmba003 name="construct.a.nmba003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmba003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmba003
            #add-point:ON ACTION controlp INFIELD nmba003 name="construct.c.nmba003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmba004
            #add-point:BEFORE FIELD nmba004 name="construct.b.nmba004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmba004
            
            #add-point:AFTER FIELD nmba004 name="construct.a.nmba004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmba004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmba004
            #add-point:ON ACTION controlp INFIELD nmba004 name="construct.c.nmba004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmba005
            #add-point:BEFORE FIELD nmba005 name="construct.b.nmba005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmba005
            
            #add-point:AFTER FIELD nmba005 name="construct.a.nmba005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmba005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmba005
            #add-point:ON ACTION controlp INFIELD nmba005 name="construct.c.nmba005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmba006
            #add-point:BEFORE FIELD nmba006 name="construct.b.nmba006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmba006
            
            #add-point:AFTER FIELD nmba006 name="construct.a.nmba006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmba006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmba006
            #add-point:ON ACTION controlp INFIELD nmba006 name="construct.c.nmba006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbastus
            #add-point:BEFORE FIELD nmbastus name="construct.b.nmbastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbastus
            
            #add-point:AFTER FIELD nmbastus name="construct.a.nmbastus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmbastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbastus
            #add-point:ON ACTION controlp INFIELD nmbastus name="construct.c.nmbastus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.nmbaownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbaownid
            #add-point:ON ACTION controlp INFIELD nmbaownid name="construct.c.nmbaownid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbaownid  #顯示到畫面上

            NEXT FIELD nmbaownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbaownid
            #add-point:BEFORE FIELD nmbaownid name="construct.b.nmbaownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbaownid
            
            #add-point:AFTER FIELD nmbaownid name="construct.a.nmbaownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmbaowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbaowndp
            #add-point:ON ACTION controlp INFIELD nmbaowndp name="construct.c.nmbaowndp"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbaowndp  #顯示到畫面上

            NEXT FIELD nmbaowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbaowndp
            #add-point:BEFORE FIELD nmbaowndp name="construct.b.nmbaowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbaowndp
            
            #add-point:AFTER FIELD nmbaowndp name="construct.a.nmbaowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmbacrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbacrtid
            #add-point:ON ACTION controlp INFIELD nmbacrtid name="construct.c.nmbacrtid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbacrtid  #顯示到畫面上

            NEXT FIELD nmbacrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbacrtid
            #add-point:BEFORE FIELD nmbacrtid name="construct.b.nmbacrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbacrtid
            
            #add-point:AFTER FIELD nmbacrtid name="construct.a.nmbacrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmbacrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbacrtdp
            #add-point:ON ACTION controlp INFIELD nmbacrtdp name="construct.c.nmbacrtdp"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbacrtdp  #顯示到畫面上

            NEXT FIELD nmbacrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbacrtdp
            #add-point:BEFORE FIELD nmbacrtdp name="construct.b.nmbacrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbacrtdp
            
            #add-point:AFTER FIELD nmbacrtdp name="construct.a.nmbacrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbacrtdt
            #add-point:BEFORE FIELD nmbacrtdt name="construct.b.nmbacrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.nmbamodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbamodid
            #add-point:ON ACTION controlp INFIELD nmbamodid name="construct.c.nmbamodid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbamodid  #顯示到畫面上

            NEXT FIELD nmbamodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbamodid
            #add-point:BEFORE FIELD nmbamodid name="construct.b.nmbamodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbamodid
            
            #add-point:AFTER FIELD nmbamodid name="construct.a.nmbamodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbamoddt
            #add-point:BEFORE FIELD nmbamoddt name="construct.b.nmbamoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.nmbacnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbacnfid
            #add-point:ON ACTION controlp INFIELD nmbacnfid name="construct.c.nmbacnfid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbacnfid  #顯示到畫面上

            NEXT FIELD nmbacnfid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbacnfid
            #add-point:BEFORE FIELD nmbacnfid name="construct.b.nmbacnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbacnfid
            
            #add-point:AFTER FIELD nmbacnfid name="construct.a.nmbacnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbacnfdt
            #add-point:BEFORE FIELD nmbacnfdt name="construct.b.nmbacnfdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON nmbbseq,nmbborga,nmbb026,nmbb027,nmbb028,nmbb003,nmbb030,nmbb043,nmbb043_desc, 
          nmbb073,nmbb031,nmbb004,nmbb005,nmbb006,nmbb007,nmbb040,nmbb041,nmbb044,nmbb002,nmbb002_desc, 
          nmbb010,nmbb045,nmbb029,nmbb039,nmbb001,nmbb011,nmbb012,nmbb013,nmbb014,nmbb015,nmbb016,nmbb017, 
          nmbb018,nmbb019,nmbb020,nmbb021,nmbb022,nmbb023,nmbb024,nmbb053,nmbb054,nmbb056,nmbb066,nmbb067, 
          nmbb068,nmbb042,nmbb069,nmbb025
           FROM s_detail1[1].nmbbseq,s_detail1[1].nmbborga,s_detail1[1].nmbb026,s_detail1[1].nmbb027, 
               s_detail1[1].nmbb028,s_detail1[1].nmbb003,s_detail1[1].nmbb030,s_detail1[1].nmbb043,s_detail1[1].nmbb043_desc, 
               s_detail1[1].nmbb073,s_detail1[1].nmbb031,s_detail1[1].nmbb004,s_detail1[1].nmbb005,s_detail1[1].nmbb006, 
               s_detail1[1].nmbb007,s_detail1[1].nmbb040,s_detail1[1].nmbb041,s_detail1[1].nmbb044,s_detail1[1].nmbb002, 
               s_detail1[1].nmbb002_desc,s_detail1[1].nmbb010,s_detail1[1].nmbb045,s_detail1[1].nmbb029, 
               s_detail1[1].nmbb039,s_detail1[1].nmbb001,s_detail1[1].nmbb011,s_detail1[1].nmbb012,s_detail1[1].nmbb013, 
               s_detail1[1].nmbb014,s_detail1[1].nmbb015,s_detail1[1].nmbb016,s_detail1[1].nmbb017,s_detail1[1].nmbb018, 
               s_detail1[1].nmbb019,s_detail1[1].nmbb020,s_detail1[1].nmbb021,s_detail1[1].nmbb022,s_detail1[1].nmbb023, 
               s_detail1[1].nmbb024,s_detail1[1].nmbb053,s_detail1[1].nmbb054,s_detail1[1].nmbb056,s_detail1[1].nmbb066, 
               s_detail1[1].nmbb067,s_detail1[1].nmbb068,s_detail1[1].nmbb042,s_detail1[1].nmbb069,s_detail1[1].nmbb025 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbbseq
            #add-point:BEFORE FIELD nmbbseq name="construct.b.page1.nmbbseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbbseq
            
            #add-point:AFTER FIELD nmbbseq name="construct.a.page1.nmbbseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmbbseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbbseq
            #add-point:ON ACTION controlp INFIELD nmbbseq name="construct.c.page1.nmbbseq"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.nmbborga
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbborga
            #add-point:ON ACTION controlp INFIELD nmbborga name="construct.c.page1.nmbborga"
            #來源組織
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #LET g_qryparam.where = " ooef206 = 'Y' " #150707-00001#7 #161021-00050#10 mark
            LET g_qryparam.where = " ooef201 = 'Y'"  #161021-00050#10
            #160816-00012#3 Add  ---(S)---
            CALL s_axrt300_get_site(g_user,'','1') RETURNING l_wc
            #LET g_qryparam.where = g_qryparam.where," AND ",l_wc CLIPPED                              #161028-00051#1   mark
            #LET g_qryparam.where = g_qryparam.where," AND ",l_wc CLIPPED, "AND ooef001 IN",g_wc_orga   #161028-00051#1   add   #161111-00031#1   mark
            LET g_qryparam.where = g_qryparam.where," AND ",l_wc CLIPPED   #161111-00031#1   add
            #160816-00012#3 Add  ---(E)---
            #CALL q_ooed004_8()      #150707-00001#7 mark
            CALL q_ooef001()         #150707-00001#7
            DISPLAY g_qryparam.return1 TO nmbborga
            NEXT FIELD nmbborga
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbborga
            #add-point:BEFORE FIELD nmbborga name="construct.b.page1.nmbborga"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbborga
            
            #add-point:AFTER FIELD nmbborga name="construct.a.page1.nmbborga"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmbb026
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb026
            #add-point:ON ACTION controlp INFIELD nmbb026 name="construct.c.page1.nmbb026"
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            #CALL q_pmaa001()       #160913-00017#6  mark                  #呼叫開窗
            #CALL q_pmaa001_25()     #160913-00017#6  add    #161228-00019#1 mark lujh  
            CALL q_pmab001()                                 #161228-00019#1 add lujh
            DISPLAY g_qryparam.return1 TO nmbb026  #顯示到畫面上

            NEXT FIELD nmbb026                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb026
            #add-point:BEFORE FIELD nmbb026 name="construct.b.page1.nmbb026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb026
            
            #add-point:AFTER FIELD nmbb026 name="construct.a.page1.nmbb026"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb027
            #add-point:BEFORE FIELD nmbb027 name="construct.b.page1.nmbb027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb027
            
            #add-point:AFTER FIELD nmbb027 name="construct.a.page1.nmbb027"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmbb027
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb027
            #add-point:ON ACTION controlp INFIELD nmbb027 name="construct.c.page1.nmbb027"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()
            DISPLAY g_qryparam.return1 TO INFIELD      #顯示到畫面上
            NEXT FIELD INFIELD
            #END add-point
 
 
         #Ctrlp:construct.c.page1.nmbb028
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb028
            #add-point:ON ACTION controlp INFIELD nmbb028 name="construct.c.page1.nmbb028"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
	      	LET g_qryparam.reqry = FALSE
			   LET g_qryparam.where = " ooia002 IN ('10','20','30','40','50')"
            CALL q_ooia001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbb028  #顯示到畫面上

            NEXT FIELD nmbb028                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb028
            #add-point:BEFORE FIELD nmbb028 name="construct.b.page1.nmbb028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb028
            
            #add-point:AFTER FIELD nmbb028 name="construct.a.page1.nmbb028"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmbb003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb003
            #add-point:ON ACTION controlp INFIELD nmbb003 name="construct.c.page1.nmbb003"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			   #160122-00001#27--add---str
            LET g_qryparam.where = " nmas002 IN (",g_sql_bank,")"
            #160122-00001#27--add---end
            CALL q_nmas_01()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbb003  #顯示到畫面上
             LET g_qryparam.where = " "             #160122-00001#27

            NEXT FIELD nmbb003                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb003
            #add-point:BEFORE FIELD nmbb003 name="construct.b.page1.nmbb003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb003
            
            #add-point:AFTER FIELD nmbb003 name="construct.a.page1.nmbb003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb030
            #add-point:BEFORE FIELD nmbb030 name="construct.b.page1.nmbb030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb030
            
            #add-point:AFTER FIELD nmbb030 name="construct.a.page1.nmbb030"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmbb030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb030
            #add-point:ON ACTION controlp INFIELD nmbb030 name="construct.c.page1.nmbb030"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.nmbb043
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb043
            #add-point:ON ACTION controlp INFIELD nmbb043 name="construct.c.page1.nmbb043"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_nmab001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbb043  #顯示到畫面上

            NEXT FIELD nmbb043                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb043
            #add-point:BEFORE FIELD nmbb043 name="construct.b.page1.nmbb043"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb043
            
            #add-point:AFTER FIELD nmbb043 name="construct.a.page1.nmbb043"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb043_desc
            #add-point:BEFORE FIELD nmbb043_desc name="construct.b.page1.nmbb043_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb043_desc
            
            #add-point:AFTER FIELD nmbb043_desc name="construct.a.page1.nmbb043_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmbb043_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb043_desc
            #add-point:ON ACTION controlp INFIELD nmbb043_desc name="construct.c.page1.nmbb043_desc"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_nmab001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbb043_desc  #顯示到畫面上

            NEXT FIELD nmbb043_desc                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb073
            #add-point:BEFORE FIELD nmbb073 name="construct.b.page1.nmbb073"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb073
            
            #add-point:AFTER FIELD nmbb073 name="construct.a.page1.nmbb073"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmbb073
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb073
            #add-point:ON ACTION controlp INFIELD nmbb073 name="construct.c.page1.nmbb073"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb031
            #add-point:BEFORE FIELD nmbb031 name="construct.b.page1.nmbb031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb031
            
            #add-point:AFTER FIELD nmbb031 name="construct.a.page1.nmbb031"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmbb031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb031
            #add-point:ON ACTION controlp INFIELD nmbb031 name="construct.c.page1.nmbb031"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.nmbb004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb004
            #add-point:ON ACTION controlp INFIELD nmbb004 name="construct.c.page1.nmbb004"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_aooi001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbb004  #顯示到畫面上

            NEXT FIELD nmbb004                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb004
            #add-point:BEFORE FIELD nmbb004 name="construct.b.page1.nmbb004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb004
            
            #add-point:AFTER FIELD nmbb004 name="construct.a.page1.nmbb004"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb005
            #add-point:BEFORE FIELD nmbb005 name="construct.b.page1.nmbb005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb005
            
            #add-point:AFTER FIELD nmbb005 name="construct.a.page1.nmbb005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmbb005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb005
            #add-point:ON ACTION controlp INFIELD nmbb005 name="construct.c.page1.nmbb005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb006
            #add-point:BEFORE FIELD nmbb006 name="construct.b.page1.nmbb006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb006
            
            #add-point:AFTER FIELD nmbb006 name="construct.a.page1.nmbb006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmbb006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb006
            #add-point:ON ACTION controlp INFIELD nmbb006 name="construct.c.page1.nmbb006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb007
            #add-point:BEFORE FIELD nmbb007 name="construct.b.page1.nmbb007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb007
            
            #add-point:AFTER FIELD nmbb007 name="construct.a.page1.nmbb007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmbb007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb007
            #add-point:ON ACTION controlp INFIELD nmbb007 name="construct.c.page1.nmbb007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb040
            #add-point:BEFORE FIELD nmbb040 name="construct.b.page1.nmbb040"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb040
            
            #add-point:AFTER FIELD nmbb040 name="construct.a.page1.nmbb040"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmbb040
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb040
            #add-point:ON ACTION controlp INFIELD nmbb040 name="construct.c.page1.nmbb040"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb041
            #add-point:BEFORE FIELD nmbb041 name="construct.b.page1.nmbb041"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb041
            
            #add-point:AFTER FIELD nmbb041 name="construct.a.page1.nmbb041"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmbb041
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb041
            #add-point:ON ACTION controlp INFIELD nmbb041 name="construct.c.page1.nmbb041"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb044
            #add-point:BEFORE FIELD nmbb044 name="construct.b.page1.nmbb044"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb044
            
            #add-point:AFTER FIELD nmbb044 name="construct.a.page1.nmbb044"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmbb044
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb044
            #add-point:ON ACTION controlp INFIELD nmbb044 name="construct.c.page1.nmbb044"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.nmbb002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb002
            #add-point:ON ACTION controlp INFIELD nmbb002 name="construct.c.page1.nmbb002"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_nmaj001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbb002  #顯示到畫面上
            NEXT FIELD nmbb002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb002
            #add-point:BEFORE FIELD nmbb002 name="construct.b.page1.nmbb002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb002
            
            #add-point:AFTER FIELD nmbb002 name="construct.a.page1.nmbb002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb002_desc
            #add-point:BEFORE FIELD nmbb002_desc name="construct.b.page1.nmbb002_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb002_desc
            
            #add-point:AFTER FIELD nmbb002_desc name="construct.a.page1.nmbb002_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmbb002_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb002_desc
            #add-point:ON ACTION controlp INFIELD nmbb002_desc name="construct.c.page1.nmbb002_desc"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.nmbb010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb010
            #add-point:ON ACTION controlp INFIELD nmbb010 name="construct.c.page1.nmbb010"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_nmai002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbb010  #顯示到畫面上
            NEXT FIELD nmbb010                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb010
            #add-point:BEFORE FIELD nmbb010 name="construct.b.page1.nmbb010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb010
            
            #add-point:AFTER FIELD nmbb010 name="construct.a.page1.nmbb010"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb045
            #add-point:BEFORE FIELD nmbb045 name="construct.b.page1.nmbb045"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb045
            
            #add-point:AFTER FIELD nmbb045 name="construct.a.page1.nmbb045"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmbb045
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb045
            #add-point:ON ACTION controlp INFIELD nmbb045 name="construct.c.page1.nmbb045"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb029
            #add-point:BEFORE FIELD nmbb029 name="construct.b.page1.nmbb029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb029
            
            #add-point:AFTER FIELD nmbb029 name="construct.a.page1.nmbb029"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmbb029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb029
            #add-point:ON ACTION controlp INFIELD nmbb029 name="construct.c.page1.nmbb029"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb039
            #add-point:BEFORE FIELD nmbb039 name="construct.b.page1.nmbb039"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb039
            
            #add-point:AFTER FIELD nmbb039 name="construct.a.page1.nmbb039"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmbb039
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb039
            #add-point:ON ACTION controlp INFIELD nmbb039 name="construct.c.page1.nmbb039"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb001
            #add-point:BEFORE FIELD nmbb001 name="construct.b.page1.nmbb001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb001
            
            #add-point:AFTER FIELD nmbb001 name="construct.a.page1.nmbb001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmbb001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb001
            #add-point:ON ACTION controlp INFIELD nmbb001 name="construct.c.page1.nmbb001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb011
            #add-point:BEFORE FIELD nmbb011 name="construct.b.page1.nmbb011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb011
            
            #add-point:AFTER FIELD nmbb011 name="construct.a.page1.nmbb011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmbb011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb011
            #add-point:ON ACTION controlp INFIELD nmbb011 name="construct.c.page1.nmbb011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb012
            #add-point:BEFORE FIELD nmbb012 name="construct.b.page1.nmbb012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb012
            
            #add-point:AFTER FIELD nmbb012 name="construct.a.page1.nmbb012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmbb012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb012
            #add-point:ON ACTION controlp INFIELD nmbb012 name="construct.c.page1.nmbb012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb013
            #add-point:BEFORE FIELD nmbb013 name="construct.b.page1.nmbb013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb013
            
            #add-point:AFTER FIELD nmbb013 name="construct.a.page1.nmbb013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmbb013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb013
            #add-point:ON ACTION controlp INFIELD nmbb013 name="construct.c.page1.nmbb013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb014
            #add-point:BEFORE FIELD nmbb014 name="construct.b.page1.nmbb014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb014
            
            #add-point:AFTER FIELD nmbb014 name="construct.a.page1.nmbb014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmbb014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb014
            #add-point:ON ACTION controlp INFIELD nmbb014 name="construct.c.page1.nmbb014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb015
            #add-point:BEFORE FIELD nmbb015 name="construct.b.page1.nmbb015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb015
            
            #add-point:AFTER FIELD nmbb015 name="construct.a.page1.nmbb015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmbb015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb015
            #add-point:ON ACTION controlp INFIELD nmbb015 name="construct.c.page1.nmbb015"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb016
            #add-point:BEFORE FIELD nmbb016 name="construct.b.page1.nmbb016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb016
            
            #add-point:AFTER FIELD nmbb016 name="construct.a.page1.nmbb016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmbb016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb016
            #add-point:ON ACTION controlp INFIELD nmbb016 name="construct.c.page1.nmbb016"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb017
            #add-point:BEFORE FIELD nmbb017 name="construct.b.page1.nmbb017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb017
            
            #add-point:AFTER FIELD nmbb017 name="construct.a.page1.nmbb017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmbb017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb017
            #add-point:ON ACTION controlp INFIELD nmbb017 name="construct.c.page1.nmbb017"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb018
            #add-point:BEFORE FIELD nmbb018 name="construct.b.page1.nmbb018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb018
            
            #add-point:AFTER FIELD nmbb018 name="construct.a.page1.nmbb018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmbb018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb018
            #add-point:ON ACTION controlp INFIELD nmbb018 name="construct.c.page1.nmbb018"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb019
            #add-point:BEFORE FIELD nmbb019 name="construct.b.page1.nmbb019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb019
            
            #add-point:AFTER FIELD nmbb019 name="construct.a.page1.nmbb019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmbb019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb019
            #add-point:ON ACTION controlp INFIELD nmbb019 name="construct.c.page1.nmbb019"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb020
            #add-point:BEFORE FIELD nmbb020 name="construct.b.page1.nmbb020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb020
            
            #add-point:AFTER FIELD nmbb020 name="construct.a.page1.nmbb020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmbb020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb020
            #add-point:ON ACTION controlp INFIELD nmbb020 name="construct.c.page1.nmbb020"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb021
            #add-point:BEFORE FIELD nmbb021 name="construct.b.page1.nmbb021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb021
            
            #add-point:AFTER FIELD nmbb021 name="construct.a.page1.nmbb021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmbb021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb021
            #add-point:ON ACTION controlp INFIELD nmbb021 name="construct.c.page1.nmbb021"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb022
            #add-point:BEFORE FIELD nmbb022 name="construct.b.page1.nmbb022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb022
            
            #add-point:AFTER FIELD nmbb022 name="construct.a.page1.nmbb022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmbb022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb022
            #add-point:ON ACTION controlp INFIELD nmbb022 name="construct.c.page1.nmbb022"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb023
            #add-point:BEFORE FIELD nmbb023 name="construct.b.page1.nmbb023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb023
            
            #add-point:AFTER FIELD nmbb023 name="construct.a.page1.nmbb023"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmbb023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb023
            #add-point:ON ACTION controlp INFIELD nmbb023 name="construct.c.page1.nmbb023"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb024
            #add-point:BEFORE FIELD nmbb024 name="construct.b.page1.nmbb024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb024
            
            #add-point:AFTER FIELD nmbb024 name="construct.a.page1.nmbb024"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmbb024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb024
            #add-point:ON ACTION controlp INFIELD nmbb024 name="construct.c.page1.nmbb024"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb053
            #add-point:BEFORE FIELD nmbb053 name="construct.b.page1.nmbb053"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb053
            
            #add-point:AFTER FIELD nmbb053 name="construct.a.page1.nmbb053"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmbb053
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb053
            #add-point:ON ACTION controlp INFIELD nmbb053 name="construct.c.page1.nmbb053"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb054
            #add-point:BEFORE FIELD nmbb054 name="construct.b.page1.nmbb054"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb054
            
            #add-point:AFTER FIELD nmbb054 name="construct.a.page1.nmbb054"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmbb054
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb054
            #add-point:ON ACTION controlp INFIELD nmbb054 name="construct.c.page1.nmbb054"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb056
            #add-point:BEFORE FIELD nmbb056 name="construct.b.page1.nmbb056"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb056
            
            #add-point:AFTER FIELD nmbb056 name="construct.a.page1.nmbb056"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmbb056
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb056
            #add-point:ON ACTION controlp INFIELD nmbb056 name="construct.c.page1.nmbb056"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb066
            #add-point:BEFORE FIELD nmbb066 name="construct.b.page1.nmbb066"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb066
            
            #add-point:AFTER FIELD nmbb066 name="construct.a.page1.nmbb066"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmbb066
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb066
            #add-point:ON ACTION controlp INFIELD nmbb066 name="construct.c.page1.nmbb066"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb067
            #add-point:BEFORE FIELD nmbb067 name="construct.b.page1.nmbb067"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb067
            
            #add-point:AFTER FIELD nmbb067 name="construct.a.page1.nmbb067"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmbb067
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb067
            #add-point:ON ACTION controlp INFIELD nmbb067 name="construct.c.page1.nmbb067"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb068
            #add-point:BEFORE FIELD nmbb068 name="construct.b.page1.nmbb068"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb068
            
            #add-point:AFTER FIELD nmbb068 name="construct.a.page1.nmbb068"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmbb068
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb068
            #add-point:ON ACTION controlp INFIELD nmbb068 name="construct.c.page1.nmbb068"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb042
            #add-point:BEFORE FIELD nmbb042 name="construct.b.page1.nmbb042"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb042
            
            #add-point:AFTER FIELD nmbb042 name="construct.a.page1.nmbb042"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmbb042
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb042
            #add-point:ON ACTION controlp INFIELD nmbb042 name="construct.c.page1.nmbb042"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb069
            #add-point:BEFORE FIELD nmbb069 name="construct.b.page1.nmbb069"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb069
            
            #add-point:AFTER FIELD nmbb069 name="construct.a.page1.nmbb069"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmbb069
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb069
            #add-point:ON ACTION controlp INFIELD nmbb069 name="construct.c.page1.nmbb069"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb025
            #add-point:BEFORE FIELD nmbb025 name="construct.b.page1.nmbb025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb025
            
            #add-point:AFTER FIELD nmbb025 name="construct.a.page1.nmbb025"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmbb025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb025
            #add-point:ON ACTION controlp INFIELD nmbb025 name="construct.c.page1.nmbb025"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
      CONSTRUCT g_wc2_table2 ON nmbuseq,nmbu001,nmbuorga,nmbu003,nmbu004,nmbu005,nmbu006,nmbu007,nmbu002 
 
           FROM s_detail3[1].nmbuseq,s_detail3[1].nmbu001,s_detail3[1].nmbuorga,s_detail3[1].nmbu003, 
               s_detail3[1].nmbu004,s_detail3[1].nmbu005,s_detail3[1].nmbu006,s_detail3[1].nmbu007,s_detail3[1].nmbu002 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body2.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbuseq
            #add-point:BEFORE FIELD nmbuseq name="construct.b.page3.nmbuseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbuseq
            
            #add-point:AFTER FIELD nmbuseq name="construct.a.page3.nmbuseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.nmbuseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbuseq
            #add-point:ON ACTION controlp INFIELD nmbuseq name="construct.c.page3.nmbuseq"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page3.nmbu001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbu001
            #add-point:ON ACTION controlp INFIELD nmbu001 name="construct.c.page3.nmbu001"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
#			LET g_qryparam.arg1 = g_nmba_m.nmbadocno  #161213-00020#5 20170210 mark by 08172
#            CALL q_nmbb026()      #161213-00020#5 20170210 mark by 08172
            CALL q_pmaa001_25()    #161213-00020#5 20170210 add by 08172
            #CALL q_pmaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbu001  #顯示到畫面上

            NEXT FIELD nmbu001                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbu001
            #add-point:BEFORE FIELD nmbu001 name="construct.b.page3.nmbu001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbu001
            
            #add-point:AFTER FIELD nmbu001 name="construct.a.page3.nmbu001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.nmbuorga
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbuorga
            #add-point:ON ACTION controlp INFIELD nmbuorga name="construct.c.page3.nmbuorga"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_nmbborga()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbuorga  #顯示到畫面上

            NEXT FIELD nmbuorga                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbuorga
            #add-point:BEFORE FIELD nmbuorga name="construct.b.page3.nmbuorga"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbuorga
            
            #add-point:AFTER FIELD nmbuorga name="construct.a.page3.nmbuorga"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbu003
            #add-point:BEFORE FIELD nmbu003 name="construct.b.page3.nmbu003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbu003
            
            #add-point:AFTER FIELD nmbu003 name="construct.a.page3.nmbu003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.nmbu003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbu003
            #add-point:ON ACTION controlp INFIELD nmbu003 name="construct.c.page3.nmbu003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbu004
            #add-point:BEFORE FIELD nmbu004 name="construct.b.page3.nmbu004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbu004
            
            #add-point:AFTER FIELD nmbu004 name="construct.a.page3.nmbu004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.nmbu004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbu004
            #add-point:ON ACTION controlp INFIELD nmbu004 name="construct.c.page3.nmbu004"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page3.nmbu005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbu005
            #add-point:ON ACTION controlp INFIELD nmbu005 name="construct.c.page3.nmbu005"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_xrcadocno_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbu005  #顯示到畫面上

            NEXT FIELD nmbu005                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbu005
            #add-point:BEFORE FIELD nmbu005 name="construct.b.page3.nmbu005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbu005
            
            #add-point:AFTER FIELD nmbu005 name="construct.a.page3.nmbu005"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbu006
            #add-point:BEFORE FIELD nmbu006 name="construct.b.page3.nmbu006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbu006
            
            #add-point:AFTER FIELD nmbu006 name="construct.a.page3.nmbu006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.nmbu006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbu006
            #add-point:ON ACTION controlp INFIELD nmbu006 name="construct.c.page3.nmbu006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbu007
            #add-point:BEFORE FIELD nmbu007 name="construct.b.page3.nmbu007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbu007
            
            #add-point:AFTER FIELD nmbu007 name="construct.a.page3.nmbu007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.nmbu007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbu007
            #add-point:ON ACTION controlp INFIELD nmbu007 name="construct.c.page3.nmbu007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbu002
            #add-point:BEFORE FIELD nmbu002 name="construct.b.page3.nmbu002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbu002
            
            #add-point:AFTER FIELD nmbu002 name="construct.a.page3.nmbu002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.nmbu002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbu002
            #add-point:ON ACTION controlp INFIELD nmbu002 name="construct.c.page3.nmbu002"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
 
      
 
      
      #add-point:cs段add_cs(本段內只能出現新的CONSTRUCT指令) name="cs.add_cs"
      
      #end add-point
 
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:cs段b_dialog name="cs.b_dialog"
         #151105--s
         #加上合計功能後無法查詢，需重新DISPLAY所有頁籤
         LET g_nmbb_d[1].nmbbseq = ""
         DISPLAY ARRAY g_nmbb_d TO s_detail1.*
            BEFORE DISPLAY
               EXIT DISPLAY
         END DISPLAY
         #151105--e
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
                  WHEN la_wc[li_idx].tableid = "nmba_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "nmbb_t" 
                     LET g_wc2_table1 = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "nmbu_t" 
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
   #161104-00046#14-----s
   IF cl_null(g_user_dept_wc)THEN
      LET g_user_dept_wc = ' 1=1'
   END IF
   IF g_user_dept_wc <>  " 1=1" THEN
      LET g_wc = g_wc ," AND ", g_user_dept_wc CLIPPED
   END IF   
   #161104-00046#14-----e
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="anmt540.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION anmt540_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point   
   DEFINE ls_wc STRING
   #add-point:query段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   CALL g_nmbb2_d.clear()
   #end add-point   
   
   #add-point:Function前置處理  name="query.pre_function"
   
   #end add-point
   
   #切換畫面
   
   LET ls_wc = g_wc
   
   LET INT_FLAG = 0
   CALL cl_navigator_setting( g_current_idx, g_detail_cnt )
   ERROR ""
   
   #清除畫面及相關資料
   CLEAR FORM
   CALL g_browser.clear()       
   CALL g_nmbb_d.clear()
   CALL g_nmbb3_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL anmt540_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL anmt540_browser_fill("")
      CALL anmt540_fetch("")
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
   CALL anmt540_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL anmt540_fetch("F") 
      #顯示單身筆數
      CALL anmt540_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="anmt540.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION anmt540_fetch(p_flag)
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point    
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   DEFINE l_conf     LIKE type_t.chr1
   DEFINE l_slip     LIKE type_t.chr20
   DEFINE l_success  LIKE type_t.num5
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
   LET g_pagestart = g_current_idx
   DISPLAY g_pagestart TO FORMONLY.b_index   #當下筆數
   DISPLAY g_pagestart TO FORMONLY.h_index   #當下筆數
   
   CALL cl_navigator_setting( g_pagestart, g_browser_cnt )
 
   #代表沒有資料
   IF g_current_idx = 0 OR g_browser.getLength() = 0 THEN
      RETURN
   END IF
   
   #避免超出browser資料筆數上限
   IF g_current_idx > g_browser.getLength() THEN
      LET g_browser_idx = g_browser.getLength()
      LET g_current_idx = g_browser.getLength()
   END IF
   
   LET g_nmba_m.nmbacomp = g_browser[g_current_idx].b_nmbacomp
   LET g_nmba_m.nmbadocno = g_browser[g_current_idx].b_nmbadocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE anmt540_master_referesh USING g_nmba_m.nmbacomp,g_nmba_m.nmbadocno INTO g_nmba_m.nmbasite, 
       g_nmba_m.nmba008,g_nmba_m.nmba001,g_nmba_m.nmbacomp,g_nmba_m.nmba002,g_nmba_m.nmbadocno,g_nmba_m.nmbadocdt, 
       g_nmba_m.nmba003,g_nmba_m.nmba004,g_nmba_m.nmba005,g_nmba_m.nmba006,g_nmba_m.nmbastus,g_nmba_m.nmbaownid, 
       g_nmba_m.nmbaowndp,g_nmba_m.nmbacrtid,g_nmba_m.nmbacrtdp,g_nmba_m.nmbacrtdt,g_nmba_m.nmbamodid, 
       g_nmba_m.nmbamoddt,g_nmba_m.nmbacnfid,g_nmba_m.nmbacnfdt,g_nmba_m.nmbasite_desc,g_nmba_m.nmba008_desc, 
       g_nmba_m.nmba001_desc,g_nmba_m.nmbacomp_desc,g_nmba_m.nmbaownid_desc,g_nmba_m.nmbaowndp_desc, 
       g_nmba_m.nmbacrtid_desc,g_nmba_m.nmbacrtdp_desc,g_nmba_m.nmbamodid_desc,g_nmba_m.nmbacnfid_desc 
 
   
   #遮罩相關處理
   LET g_nmba_m_mask_o.* =  g_nmba_m.*
   CALL anmt540_nmba_t_mask()
   LET g_nmba_m_mask_n.* =  g_nmba_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL anmt540_set_act_visible()   
   CALL anmt540_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   CALL cl_set_toolbaritem_visible("modi_nmbb026", FALSE)
   #IF g_nmba_m.nmbastus = 'Y' THEN    #161226-00036#1 mark
   IF g_nmba_m.nmbastus = 'Y' OR g_nmba_m.nmbastus = 'V' THEN    #161226-00036#1 add
      CALL cl_set_toolbaritem_visible("modi_nmbb026", TRUE)
   END IF
   #151127-00006#2--mod--str--
   LET l_conf = 'Y'
   CALL s_aooi200_fin_get_slip(g_nmba_m.nmbadocno) RETURNING l_success,l_slip
   IF l_success = TRUE THEN
      SELECT glaald INTO g_glaald  FROM glaa_t
       WHERE glaaent = g_enterprise 
         AND glaacomp = g_nmba_m.nmbacomp
         AND glaa014 = 'Y'
      #獲取單據別對應參數：收款審核是否分開審核
      CALL s_fin_get_doc_para(g_glaald,g_nmba_m.nmbacomp,l_slip,'D-FIN-4004') RETURNING l_conf  
   END IF 
   IF l_conf = 'N' THEN #不分开审核，即在anmt540直接复核，状态码=V
      CALL cl_set_toolbaritem_visible("approval,unverify", FALSE)
   ELSE                 #分开审核，即在anmt540审核，状态码=Y，在anmt550中复核，状态码=V
      CALL cl_set_toolbaritem_visible("approval,unverify", TRUE)
   END IF
   #151127-00006#2--mod--end
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_nmba_m_t.* = g_nmba_m.*
   LET g_nmba_m_o.* = g_nmba_m.*
   
   LET g_data_owner = g_nmba_m.nmbaownid      
   LET g_data_dept  = g_nmba_m.nmbaowndp
   
   #重新顯示   
   CALL anmt540_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="anmt540.insert" >}
#+ 資料新增
PRIVATE FUNCTION anmt540_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   DEFINE l_ooef206  LIKE ooef_t.ooef206
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_nmbb_d.clear()   
   CALL g_nmbb3_d.clear()  
 
 
   INITIALIZE g_nmba_m.* TO NULL             #DEFAULT 設定
   
   LET g_nmbacomp_t = NULL
   LET g_nmbadocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_nmba_m.nmbaownid = g_user
      LET g_nmba_m.nmbaowndp = g_dept
      LET g_nmba_m.nmbacrtid = g_user
      LET g_nmba_m.nmbacrtdp = g_dept 
      LET g_nmba_m.nmbacrtdt = cl_get_current()
      LET g_nmba_m.nmbamodid = g_user
      LET g_nmba_m.nmbamoddt = cl_get_current()
      LET g_nmba_m.nmbastus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_nmba_m.nmba004 = "MISC"
      LET g_nmba_m.nmba005 = "MISC"
      LET g_nmba_m.nmba006 = "N"
      LET g_nmba_m.nmbastus = "N"
 
  
      #add-point:單頭預設值 name="insert.default"
      CALL g_nmbb2_d.clear()    
      #150707-00001#7--(s)
      #取得預設的資金中心,因新增階段的時候,並不會知道site,所以以登入人員做為依據
      CALL s_fin_get_account_center('',g_user,'6',g_today) RETURNING g_sub_success,g_nmba_m.nmbasite,g_errno
      #161112-00002#1--add--s--xul
      #是否为资金组织
      SELECT ooef206 INTO l_ooef206
        FROM ooef_t
       WHERE ooefent = g_enterprise 
         AND ooef001 = g_nmba_m.nmbasite
       IF l_ooef206 != 'Y' THEN   
         LET g_nmba_m.nmbasite = ''
       END IF
      #161112-00002#1--add--e--xul
      LET g_nmba_m.nmbasite_desc = s_desc_get_department_desc(g_nmba_m.nmbasite)
      CALL s_anm_get_comp_wc('6',g_nmba_m.nmbasite,g_nmba_m.nmbadocdt) RETURNING g_comp_wc   
      SELECT ooef017 INTO g_nmba_m.nmbacomp
        FROM ooef_t
       WHERE ooefent = g_enterprise
         AND ooef001 = g_nmba_m.nmbasite
      #CALL s_anm_get_site_wc('6',g_nmba_m.nmbacomp,g_nmba_m.nmbadocdt) RETURNING g_site_wc    #160912-00024#1    
      CALL s_anm_get_site_wc('6',g_nmba_m.nmbasite,g_nmba_m.nmbadocdt) RETURNING g_site_wc     #160912-00024#1   
      #150707-00001#7--(e)
      LET g_nmba_m.nmba008 = g_user
      SELECT ooag004 INTO g_ooag004 FROM ooag_t
       WHERE ooag001 = g_user
         AND ooagent = g_enterprise #2015/04/02 by 02599 add
      LET g_nmba_m.nmba001 = g_ooag004
      #150707-00001#7-mark-(s)
      #SELECT ooef017 INTO g_nmba_m.nmbacomp
      #  FROM ooef_t
      # WHERE ooefent = g_enterprise
      #   AND ooef001 = g_ooag004
      #150707-00001#7-mark-(e)
       
       
      LET g_nmba_m.nmbadocdt = g_today
      #LET g_nmba_m.nmba003 = 'anmt540' #150904-00006#1
      LET g_nmba_m.nmba003 = g_prog     #150904-00006#1
      LET g_nmba_m.nmba005 = "MISC"
      LET g_nmba_m.nmba002 = g_user     #160708-00011#1
      CALL anmt540_glaa_get()
      CALL anmt540_ref_show()
      LET g_flag = 'N'
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_nmba_m_t.* = g_nmba_m.*
      LET g_nmba_m_o.* = g_nmba_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_nmba_m.nmbastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "V"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/verify.png")
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
 
 
 
    
      CALL anmt540_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      CALL g_nmbb2_d.clear()
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
         INITIALIZE g_nmba_m.* TO NULL
         INITIALIZE g_nmbb_d TO NULL
         INITIALIZE g_nmbb3_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL anmt540_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_nmbb_d.clear()
      #CALL g_nmbb3_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL anmt540_set_act_visible()   
   CALL anmt540_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_nmbacomp_t = g_nmba_m.nmbacomp
   LET g_nmbadocno_t = g_nmba_m.nmbadocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " nmbaent = " ||g_enterprise|| " AND",
                      " nmbacomp = '", g_nmba_m.nmbacomp, "' "
                      ," AND nmbadocno = '", g_nmba_m.nmbadocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL anmt540_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE anmt540_cl
   
   CALL anmt540_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE anmt540_master_referesh USING g_nmba_m.nmbacomp,g_nmba_m.nmbadocno INTO g_nmba_m.nmbasite, 
       g_nmba_m.nmba008,g_nmba_m.nmba001,g_nmba_m.nmbacomp,g_nmba_m.nmba002,g_nmba_m.nmbadocno,g_nmba_m.nmbadocdt, 
       g_nmba_m.nmba003,g_nmba_m.nmba004,g_nmba_m.nmba005,g_nmba_m.nmba006,g_nmba_m.nmbastus,g_nmba_m.nmbaownid, 
       g_nmba_m.nmbaowndp,g_nmba_m.nmbacrtid,g_nmba_m.nmbacrtdp,g_nmba_m.nmbacrtdt,g_nmba_m.nmbamodid, 
       g_nmba_m.nmbamoddt,g_nmba_m.nmbacnfid,g_nmba_m.nmbacnfdt,g_nmba_m.nmbasite_desc,g_nmba_m.nmba008_desc, 
       g_nmba_m.nmba001_desc,g_nmba_m.nmbacomp_desc,g_nmba_m.nmbaownid_desc,g_nmba_m.nmbaowndp_desc, 
       g_nmba_m.nmbacrtid_desc,g_nmba_m.nmbacrtdp_desc,g_nmba_m.nmbamodid_desc,g_nmba_m.nmbacnfid_desc 
 
   
   
   #遮罩相關處理
   LET g_nmba_m_mask_o.* =  g_nmba_m.*
   CALL anmt540_nmba_t_mask()
   LET g_nmba_m_mask_n.* =  g_nmba_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_nmba_m.nmbasite,g_nmba_m.nmbasite_desc,g_nmba_m.nmba008,g_nmba_m.nmba008_desc,g_nmba_m.nmba001, 
       g_nmba_m.nmba001_desc,g_nmba_m.nmbacomp,g_nmba_m.nmbacomp_desc,g_nmba_m.nmba002,g_nmba_m.nmbadocno, 
       g_nmba_m.nmbadocno_desc,g_nmba_m.nmbadocdt,g_nmba_m.nmba003,g_nmba_m.nmba004,g_nmba_m.nmba005, 
       g_nmba_m.nmba006,g_nmba_m.nmbastus,g_nmba_m.nmbaownid,g_nmba_m.nmbaownid_desc,g_nmba_m.nmbaowndp, 
       g_nmba_m.nmbaowndp_desc,g_nmba_m.nmbacrtid,g_nmba_m.nmbacrtid_desc,g_nmba_m.nmbacrtdp,g_nmba_m.nmbacrtdp_desc, 
       g_nmba_m.nmbacrtdt,g_nmba_m.nmbamodid,g_nmba_m.nmbamodid_desc,g_nmba_m.nmbamoddt,g_nmba_m.nmbacnfid, 
       g_nmba_m.nmbacnfid_desc,g_nmba_m.nmbacnfdt
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_nmba_m.nmbaownid      
   LET g_data_dept  = g_nmba_m.nmbaowndp
   
   #功能已完成,通報訊息中心
   CALL anmt540_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="anmt540.modify" >}
#+ 資料修改
PRIVATE FUNCTION anmt540_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point    
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   DEFINE l_wc2_table1          STRING
   DEFINE l_wc2_table2   STRING
 
 
 
   #add-point:modify段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   #150813-00015#14--add--str--
   DEFINE l_success   LIKE type_t.num5  
   DEFINE l_slip      LIKE type_t.chr10
   DEFINE l_dfin0033  LIKE type_t.chr80
   DEFINE l_para_date LIKE type_t.dat
   #150813-00015#14--add--end  
   #end add-point    
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   #保存單頭舊值
   LET g_nmba_m_t.* = g_nmba_m.*
   LET g_nmba_m_o.* = g_nmba_m.*
   
   IF g_nmba_m.nmbacomp IS NULL
   OR g_nmba_m.nmbadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_nmbacomp_t = g_nmba_m.nmbacomp
   LET g_nmbadocno_t = g_nmba_m.nmbadocno
 
   CALL s_transaction_begin()
   
   OPEN anmt540_cl USING g_enterprise,g_nmba_m.nmbacomp,g_nmba_m.nmbadocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN anmt540_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE anmt540_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE anmt540_master_referesh USING g_nmba_m.nmbacomp,g_nmba_m.nmbadocno INTO g_nmba_m.nmbasite, 
       g_nmba_m.nmba008,g_nmba_m.nmba001,g_nmba_m.nmbacomp,g_nmba_m.nmba002,g_nmba_m.nmbadocno,g_nmba_m.nmbadocdt, 
       g_nmba_m.nmba003,g_nmba_m.nmba004,g_nmba_m.nmba005,g_nmba_m.nmba006,g_nmba_m.nmbastus,g_nmba_m.nmbaownid, 
       g_nmba_m.nmbaowndp,g_nmba_m.nmbacrtid,g_nmba_m.nmbacrtdp,g_nmba_m.nmbacrtdt,g_nmba_m.nmbamodid, 
       g_nmba_m.nmbamoddt,g_nmba_m.nmbacnfid,g_nmba_m.nmbacnfdt,g_nmba_m.nmbasite_desc,g_nmba_m.nmba008_desc, 
       g_nmba_m.nmba001_desc,g_nmba_m.nmbacomp_desc,g_nmba_m.nmbaownid_desc,g_nmba_m.nmbaowndp_desc, 
       g_nmba_m.nmbacrtid_desc,g_nmba_m.nmbacrtdp_desc,g_nmba_m.nmbamodid_desc,g_nmba_m.nmbacnfid_desc 
 
   
   #檢查是否允許此動作
   IF NOT anmt540_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_nmba_m_mask_o.* =  g_nmba_m.*
   CALL anmt540_nmba_t_mask()
   LET g_nmba_m_mask_n.* =  g_nmba_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
   #LET l_wc2_table2 = g_wc2_table2
   #LET l_wc2_table2 = " 1=1"
 
 
 
   
   CALL anmt540_show()
   #add-point:modify段show之後 name="modify.after_show"
   #150813-00015#14--add--str--
   IF g_nmba_m.nmbastus <> 'N' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'agl-00313'
      LET g_errparam.extend = 'modify'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CLOSE anmt540_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF 
   #获取单别
   CALL s_aooi200_fin_get_slip(g_nmba_m.nmbadocno) RETURNING l_success,l_slip
   #是否可改日期
   CALL s_fin_get_doc_para(g_glaald,g_nmba_m.nmbacomp,l_slip,'D-FIN-0033') RETURNING l_dfin0033
   IF l_dfin0033 = 'N' THEN
      #檢查當單據日期小於等於關帳日期時，不可異動單據
      CALL s_fin_date_close_chk('',g_nmba_m.nmbacomp,'ANM',g_nmba_m.nmbadocdt) RETURNING l_success
      IF l_success = FALSE THEN
         CLOSE anmt540_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
   END IF
   #150813-00015#14--add--end
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
   #LET  g_wc2_table2 = l_wc2_table2 
 
 
 
    
   WHILE TRUE
      LET g_nmbacomp_t = g_nmba_m.nmbacomp
      LET g_nmbadocno_t = g_nmba_m.nmbadocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_nmba_m.nmbamodid = g_user 
LET g_nmba_m.nmbamoddt = cl_get_current()
LET g_nmba_m.nmbamodid_desc = cl_get_username(g_nmba_m.nmbamodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL anmt540_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      #150707-00001#7--(s)
      #「D抽單 / R已拒絕」狀況碼更改資料後，需還原為「N未確認」
      IF g_nmba_m.nmbastus MATCHES "[DR]" THEN 
         LET g_nmba_m.nmbastus = "N"
      END IF
      #150707-00001#7--(e)
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE nmba_t SET (nmbamodid,nmbamoddt) = (g_nmba_m.nmbamodid,g_nmba_m.nmbamoddt)
          WHERE nmbaent = g_enterprise AND nmbacomp = g_nmbacomp_t
            AND nmbadocno = g_nmbadocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_nmba_m.* = g_nmba_m_t.*
            CALL anmt540_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_nmba_m.nmbacomp != g_nmba_m_t.nmbacomp
      OR g_nmba_m.nmbadocno != g_nmba_m_t.nmbadocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE nmbb_t SET nmbbcomp = g_nmba_m.nmbacomp
                                       ,nmbbdocno = g_nmba_m.nmbadocno
 
          WHERE nmbbent = g_enterprise AND nmbbcomp = g_nmba_m_t.nmbacomp
            AND nmbbdocno = g_nmba_m_t.nmbadocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "nmbb_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "nmbb_t:",SQLERRMESSAGE 
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
         
         UPDATE nmbu_t
            SET nmbucomp = g_nmba_m.nmbacomp
               ,nmbudocno = g_nmba_m.nmbadocno
 
          WHERE nmbuent = g_enterprise AND
                nmbucomp = g_nmbacomp_t
            AND nmbudocno = g_nmbadocno_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update2"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "nmbu_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "nmbu_t:",SQLERRMESSAGE 
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
   CALL anmt540_set_act_visible()   
   CALL anmt540_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " nmbaent = " ||g_enterprise|| " AND",
                      " nmbacomp = '", g_nmba_m.nmbacomp, "' "
                      ," AND nmbadocno = '", g_nmba_m.nmbadocno, "' "
 
   #填到對應位置
   CALL anmt540_browser_fill("")
 
   CLOSE anmt540_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL anmt540_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="anmt540.input" >}
#+ 資料輸入
PRIVATE FUNCTION anmt540_input(p_cmd)
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
   DEFINE l_ooag004        LIKE ooag_t.ooag004
   DEFINE l_success        LIKE type_t.num5   
   DEFINE l_ooab002        LIKE ooab_t.ooab002
   DEFINE l_nmbb029        LIKE nmbb_t.nmbb029
   DEFINE l_nmbb034        STRING
   DEFINE l_nmbb035        STRING 
   DEFINE l_nmbasite       LIKE nmba_t.nmbasite
   DEFINE  l_count1        LIKE type_t.num5
   DEFINE l_str            STRING 
   DEFINE l_origin_str     STRING   #組織範圍
   DEFINE l_slip              LIKE type_t.chr20  #160530-00005#4 add  
   DEFINE l_wc             STRING  #160816-00012#3 add
   DEFINE l_sql            STRING  #160816-00012#3 add 
   DEFINE l_flag           LIKE type_t.num5     #161104-00046#14
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
   DISPLAY BY NAME g_nmba_m.nmbasite,g_nmba_m.nmbasite_desc,g_nmba_m.nmba008,g_nmba_m.nmba008_desc,g_nmba_m.nmba001, 
       g_nmba_m.nmba001_desc,g_nmba_m.nmbacomp,g_nmba_m.nmbacomp_desc,g_nmba_m.nmba002,g_nmba_m.nmbadocno, 
       g_nmba_m.nmbadocno_desc,g_nmba_m.nmbadocdt,g_nmba_m.nmba003,g_nmba_m.nmba004,g_nmba_m.nmba005, 
       g_nmba_m.nmba006,g_nmba_m.nmbastus,g_nmba_m.nmbaownid,g_nmba_m.nmbaownid_desc,g_nmba_m.nmbaowndp, 
       g_nmba_m.nmbaowndp_desc,g_nmba_m.nmbacrtid,g_nmba_m.nmbacrtid_desc,g_nmba_m.nmbacrtdp,g_nmba_m.nmbacrtdp_desc, 
       g_nmba_m.nmbacrtdt,g_nmba_m.nmbamodid,g_nmba_m.nmbamodid_desc,g_nmba_m.nmbamoddt,g_nmba_m.nmbacnfid, 
       g_nmba_m.nmbacnfid_desc,g_nmba_m.nmbacnfdt
   
   #切換畫面
 
   CALL cl_set_head_visible("","YES")  
 
   LET l_insert = FALSE
   LET g_action_choice = ""
 
   #add-point:input段define_sql name="input.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT nmbbseq,nmbborga,nmbb026,nmbb027,nmbb028,nmbb003,nmbb030,nmbb043,nmbb073, 
       nmbb031,nmbb004,nmbb005,nmbb006,nmbb007,nmbb040,nmbb041,nmbb044,nmbb002,nmbb010,nmbblegl,nmbb045, 
       nmbb029,nmbb039,nmbb001,nmbb011,nmbb012,nmbb013,nmbb014,nmbb015,nmbb016,nmbb017,nmbb018,nmbb019, 
       nmbb020,nmbb021,nmbb022,nmbb023,nmbb024,nmbb053,nmbb054,nmbb008,nmbb009,nmbb056,nmbb057,nmbb058, 
       nmbb059,nmbb060,nmbb061,nmbb062,nmbb066,nmbb067,nmbb068,nmbb042,nmbb069,nmbb025 FROM nmbb_t WHERE  
       nmbbent=? AND nmbbcomp=? AND nmbbdocno=? AND nmbbseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE anmt540_bcl CURSOR FROM g_forupd_sql
   
   #add-point:input段define_sql name="input.define_sql2"
   LET g_forupd_sql = "SELECT nmbbseq,nmbb026,'',nmbb028,'',nmbb004,nmbb006,nmbb032,nmbb033,nmbb034,nmbb035,nmbb036,'',nmbb037,nmbb038 FROM nmbb_t WHERE nmbbent=? AND nmbbcomp=? AND nmbbdocno=? AND nmbbseq=? FOR UPDATE"
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE anmt540_bcl3 CURSOR FROM g_forupd_sql
   #end add-point    
   LET g_forupd_sql = "SELECT nmbuseq,nmbu001,nmbuorga,nmbu003,nmbu004,nmbu005,nmbu006,nmbu007,nmbu002  
       FROM nmbu_t WHERE nmbuent=? AND nmbucomp=? AND nmbudocno=? AND nmbuseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql2"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE anmt540_bcl2 CURSOR FROM g_forupd_sql
 
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL anmt540_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL anmt540_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_nmba_m.nmbasite,g_nmba_m.nmba008,g_nmba_m.nmba001,g_nmba_m.nmbacomp,g_nmba_m.nmba002, 
       g_nmba_m.nmbadocno,g_nmba_m.nmbadocdt,g_nmba_m.nmba003,g_nmba_m.nmba004,g_nmba_m.nmba005,g_nmba_m.nmba006, 
       g_nmba_m.nmbastus
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="anmt540.input.head" >}
      #單頭段
      INPUT BY NAME g_nmba_m.nmbasite,g_nmba_m.nmba008,g_nmba_m.nmba001,g_nmba_m.nmbacomp,g_nmba_m.nmba002, 
          g_nmba_m.nmbadocno,g_nmba_m.nmbadocdt,g_nmba_m.nmba003,g_nmba_m.nmba004,g_nmba_m.nmba005,g_nmba_m.nmba006, 
          g_nmba_m.nmbastus 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN anmt540_cl USING g_enterprise,g_nmba_m.nmbacomp,g_nmba_m.nmbadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN anmt540_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE anmt540_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL anmt540_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            #CALL cl_showmsg_init()
            CALL anmt540_set_no_entry(p_cmd)   #150707-00001#7            
            NEXT FIELD nmbasite
            #end add-point
            CALL anmt540_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbasite
            
            #add-point:AFTER FIELD nmbasite name="input.a.nmbasite"
#2015/04/02--by--02599--mark--str--
#            LET l_count1=0
#            SELECT COUNT (*) INTO l_count1 FROM ooef_t WHERE ooefent =g_enterprise AND ooefstus = 'Y' AND ooef206 = 'Y' 
#            AND ooef001 IN (SELECT gzxc004 FROM gzxc_t WHERE gzxc001=g_user AND gzxcent=g_enterprise AND gzxcstus='Y' AND gzxc004=g_nmba_m.nmbasite)
#            ORDER BY ooef001
#            IF l_count1 > 0 THEN 
#               INITIALIZE g_ref_fields TO NULL
#               LET g_ref_fields[1] = g_nmba_m.nmbasite
#               CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#               LET g_nmba_m.nmbasite_desc = '', g_rtn_fields[1] , ''
#               DISPLAY BY NAME g_nmba_m.nmbasite_desc
#            ELSE 
#               INITIALIZE g_errparam TO NULL 
#               LET g_errparam.extend = "" 
#               LET g_errparam.code   = "-100" 
#               LET g_errparam.popup  = TRUE 
#               CALL cl_err()
#               NEXT FIELD CURRENT
#            END IF
#2015/04/02--by--02599--mark--end
#2015/04/02--by--02599--add--str--
            IF NOT cl_null(g_nmba_m.nmbasite) THEN 
              #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_nmba_m.nmbasite != g_nmba_m_t.nmbasite OR g_nmba_m_t.nmbasite IS NULL )) THEN #161005-00003#4 mark
               IF g_nmba_m.nmbasite != g_nmba_m_o.nmbasite OR cl_null(g_nmba_m_o.nmbasite) THEN #161005-00003#4 add
                 #CALL s_fin_account_center_sons_query('6',g_nmba_m.nmbasite,g_nmba_m.nmbadocdt,'')                         #150707-00001#7 mark
                 #CALL s_fin_account_center_with_ld_chk(g_nmba_m.nmbasite,g_glaald,g_user,'6','N','',g_nmba_m.nmbadocdt)    #150707-00001#7 mark
                  #160816-00012#3 add s---
                  CALL anmt540_nmbasite_chk()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_nmba_m.nmbasite
                     LET g_errparam.replace[1] = 'aooi125'
                     LET g_errparam.replace[2] = cl_get_progname("aooi125",g_lang,"2")
                     LET g_errparam.exeprog ='aooi125'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                    #LET g_nmba_m.nmbasite = g_nmba_m_t.nmbasite #161005-00003#4 mark
                     LET g_nmba_m.nmbasite = g_nmba_m_o.nmbasite #161005-00003#4 add
                     LET g_nmba_m.nmbasite_desc = s_desc_get_department_desc(g_nmba_m.nmbasite)
                     NEXT FIELD CURRENT
                  END IF
                  #160816-00012#3 add e--- 
                  CALL s_fin_account_center_with_ld_chk(g_nmba_m.nmbasite,'',g_user,'6','N','',g_nmba_m.nmbadocdt)    #150707-00001#7
                  RETURNING l_success,g_errno
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_nmba_m.nmbasite
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                  
                    #LET g_nmba_m.nmbasite = g_nmba_m_t.nmbasite #161005-00003#4 mark
                     LET g_nmba_m.nmbasite = g_nmba_m_o.nmbasite #161005-00003#4 add
                     LET g_nmba_m.nmbasite_desc = s_desc_get_department_desc(g_nmba_m.nmbasite)
                     DISPLAY BY NAME g_nmba_m.nmbasite_desc
                     NEXT FIELD CURRENT
                  END IF  
                  #150707-00001#7--(s)
                  CALL s_anm_get_comp_wc('6',g_nmba_m.nmbasite,g_nmba_m.nmbadocdt) RETURNING g_comp_wc
                  #IF NOT cl_null(g_nmba_m.nmbacomp) AND s_chr_get_index_of(g_comp_wc,g_nmba_m.nmbacomp,1) = 0 THEN #160816-00012#3 mark
                  IF NOT cl_null(g_nmba_m.nmbacomp) THEN                            #160816-00012#3 add
                     IF s_chr_get_index_of(g_comp_wc,g_nmba_m.nmbacomp,1) = 0 THEN  #160816-00012#3 add
                        SELECT ooef017 INTO g_nmba_m.nmbacomp
                          FROM ooef_t
                         WHERE ooefent = g_enterprise
                           AND ooef001 = g_nmba_m.nmbasite
                        LET g_nmba_m.nmbacomp_desc = s_desc_get_department_desc(g_nmba_m.nmbacomp)                          
                        DISPLAY BY NAME g_nmba_m.nmbacomp,g_nmba_m.nmbacomp_desc 
                        #CALL s_anm_get_site_wc('6',g_nmba_m.nmbacomp,g_nmba_m.nmbadocdt) RETURNING g_site_wc #160912-00024#1
                        CALL anmt540_glaa_get()
                     END IF #160816-00012#3 add    
                  END IF
                  CALL s_anm_get_site_wc('6',g_nmba_m.nmbasite,g_nmba_m.nmbadocdt) RETURNING g_site_wc     #160912-00024#1
                  #150707-00001#7--(e)                  
               END IF
            END IF
            LET g_nmba_m.nmbasite_desc = s_desc_get_department_desc(g_nmba_m.nmbasite)
            DISPLAY BY NAME g_nmba_m.nmbasite_desc
#2015/04/02--by--02599--add--end
            LET g_nmba_m_o.* = g_nmba_m.*  #161005-00003#4 add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbasite
            #add-point:BEFORE FIELD nmbasite name="input.b.nmbasite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbasite
            #add-point:ON CHANGE nmbasite name="input.g.nmbasite"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmba008
            
            #add-point:AFTER FIELD nmba008 name="input.a.nmba008"
            IF NOT cl_null(g_nmba_m.nmba008) THEN 
               CALL anmt540_nmba008_chk()
               IF NOT cl_null(g_errno) THEN 
                  IF p_cmd = 'a' THEN 
                     DISPLAY '' TO nmba008
                     DISPLAY '' TO nmba008_desc
                     DISPLAY '' TO nmba001
                     DISPLAY '' TO nmba001_desc
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_nmba_m.nmba008
                     #160318-00005#28 by 07900 --add--str
                     LET g_errparam.replace[1] = 'aooi130'
                     LET g_errparam.replace[2] = cl_get_progname("aooi130",g_lang,"2")
                     LET g_errparam.exeprog ='aooi130'
                     #160318-00005#28 by 07900 --add--end
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_nmba_m.nmba008 = ''
                     LET g_nmba_m.nmba008_desc = ''
                     LET g_nmba_m.nmba001 = ''
                     LET g_nmba_m.nmba001_desc = ''
                  ELSE
                     DISPLAY '' TO nmba008
                     DISPLAY '' TO nmba008_desc
                     DISPLAY '' TO nmba001
                     DISPLAY '' TO nmba001_desc
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_nmba_m.nmba008
                     #160318-00005#28 by 07900 --add--str
                     LET g_errparam.replace[1] = 'aooi130'
                     LET g_errparam.replace[2] = cl_get_progname("aooi130",g_lang,"2")
                     LET g_errparam.exeprog ='aooi130'
                     #160318-00005#28 by 07900 --add--end
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_nmba_m.nmba008 = g_nmba_m_t.nmba008
                     LET g_nmba_m.nmba008_desc = g_nmba_m_t.nmba008_desc
                     CALL anmt540_ref_show()
                  END IF 
                  NEXT FIELD nmba008
               END IF
            END IF
            CALL anmt540_ref_show()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmba008
            #add-point:BEFORE FIELD nmba008 name="input.b.nmba008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmba008
            #add-point:ON CHANGE nmba008 name="input.g.nmba008"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmba001
            
            #add-point:AFTER FIELD nmba001 name="input.a.nmba001"
            #150707-00001#1--(s)
            IF NOT cl_null(g_nmba_m.nmba001) THEN 
               CALL s_department_chk(g_nmba_m.nmba001,g_nmba_m.nmbadocdt) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  LET g_nmba_m.nmba001 = g_nmba_m_t.nmba001
                  LET g_nmba_m.nmba001_desc = g_nmba_m_t.nmba001_desc
                  DISPLAY BY NAME g_nmba_m.nmba001,g_nmba_m.nmba001_desc
                  NEXT FIELD CURRENT
               END IF
            END IF
            CALL anmt540_ref_show()
            #150707-00001#1--(e)
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmba001
            #add-point:BEFORE FIELD nmba001 name="input.b.nmba001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmba001
            #add-point:ON CHANGE nmba001 name="input.g.nmba001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbacomp
            
            #add-point:AFTER FIELD nmbacomp name="input.a.nmbacomp"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_nmba_m.nmbacomp) AND NOT cl_null(g_nmba_m.nmbadocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_nmba_m.nmbacomp != g_nmbacomp_t  OR g_nmba_m.nmbadocno != g_nmbadocno_t )) THEN 
                  IF NOT ap_chk_notDup(g_nmba_m.nmbacomp,"SELECT COUNT(*) FROM nmba_t WHERE "||"nmbaent = '" ||g_enterprise|| "' AND "||"nmbacomp = '"||g_nmba_m.nmbacomp ||"' AND "|| "nmbadocno = '"||g_nmba_m.nmbadocno ||"'",'std-00004',0) THEN 
                     LET g_nmba_m.nmbacomp = ''
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            IF NOT cl_null(g_nmba_m.nmbacomp) THEN 
#2015/04/02--by--02599--mark--str--
#               CALL anmt540_nmbacomp_chk()
#               IF NOT cl_null(g_errno) THEN 
#                  IF p_cmd = 'a' THEN 
#                     DISPLAY '' TO nmbacomp
#                     DISPLAY '' TO nmbacomp_desc
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code = g_errno
#                     LET g_errparam.extend = g_nmba_m.nmbacomp
#                     LET g_errparam.popup = TRUE
#                     CALL cl_err()
#
#                     LET g_nmba_m.nmbacomp = ''
#                     LET g_nmba_m.nmbacomp_desc = ''
#                  ELSE
#                     DISPLAY '' TO nmbacomp
#                     DISPLAY '' TO nmbacomp_desc
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code = g_errno
#                     LET g_errparam.extend = g_nmba_m.nmbacomp
#                     LET g_errparam.popup = TRUE
#                     CALL cl_err()
#
#                     LET g_nmba_m.nmbacomp = g_nmba_m_t.nmbacomp
#                     CALL anmt540_ref_show()
#                  END IF 
#                  NEXT FIELD nmbacomp
#               END IF
#2015/04/02--by--02599--mark--end
#2015/04/02--by--02599--add--str--
              #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_nmba_m.nmbacomp != g_nmba_m_t.nmbacomp OR g_nmba_m_t.nmbacomp IS NULL )) THEN #161005-00003#4 mark
               IF g_nmba_m.nmbacomp != g_nmba_m_o.nmbacomp OR cl_null(g_nmba_m_o.nmbacomp) THEN #161005-00003#4 add
                  CALL s_fin_comp_chk(g_nmba_m.nmbacomp) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     #160321-00016#40 --s add
                     LET g_errparam.replace[1] = 'aooi100'
                     LET g_errparam.replace[2] = cl_get_progname('aooi100',g_lang,"2")
                     LET g_errparam.exeprog = 'aooi100'
                     #160321-00016#40 --e add
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                    #LET g_nmba_m.nmbacomp = g_nmba_m_t.nmbacomp #161005-00003#4 mark
                     LET g_nmba_m.nmbacomp = g_nmba_m_o.nmbacomp #161005-00003#4 add
                     CALL anmt540_ref_show()
                     NEXT FIELD CURRENT
                  END IF
                  #150707-00001#7--mark--(s)
                  #CALL s_fin_account_center_sons_query('6',g_nmba_m.nmbasite,g_nmba_m.nmbadocdt,'')
                  #CALL s_fin_account_center_with_ld_chk(g_nmba_m.nmbasite,g_glaald,g_user,'6','Y','',g_nmba_m.nmbadocdt) 
                  #   RETURNING g_sub_success,g_errno
                  #IF NOT g_sub_success THEN
                  #   INITIALIZE g_errparam TO NULL
                  #   LET g_errparam.code = g_errno
                  #   LET g_errparam.extend = ''
                  #   LET g_errparam.popup = TRUE
                  #   CALL cl_err()
                  #   LET g_nmba_m.nmbacomp = g_nmba_m_t.nmbacomp
                  #   CALL anmt540_ref_show()
                  #   NEXT FIELD CURRENT
                  #END IF  
                  #150707-00001#7--mark--(e)
                  #--150707-00001#7--(s)
                  IF NOT cl_null(g_nmba_m.nmbasite) THEN #160816-00012#3 add
                     IF s_chr_get_index_of(g_comp_wc,g_nmba_m.nmbacomp,1) = 0 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'anm-02928'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                       #LET g_nmba_m.nmbacomp = g_nmba_m_t.nmbacomp #161005-00003#4 mark
                        LET g_nmba_m.nmbacomp = g_nmba_m_o.nmbacomp #161005-00003#4 add
                        CALL anmt540_ref_show()
                        NEXT FIELD CURRENT
                     END IF
                  END IF  #160816-00012#3 add
                  #160816-00012#3 Add  ---(S)---
                  #检查用户是否有资金中心对应法人的权限
                  CALL s_axrt300_get_site(g_user,'','3') RETURNING l_wc
                  LET l_count = 0
                  LET l_sql = "SELECT COUNT(*) FROM ooef_t WHERE ooefent = '",g_enterprise,"' ",
                              "   AND ooef001 = '",g_nmba_m.nmbacomp,"'",
                              "   AND ooef003 = 'Y'",
                              "   AND ",l_wc CLIPPED
                  PREPARE anmp410_count_prep1 FROM l_sql
                  EXECUTE anmp410_count_prep1 INTO l_count
                  IF cl_null(l_count) THEN LET l_count = 0 END IF
                  IF l_count = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "ais-00228"
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                    #LET g_nmba_m.nmbacomp = g_nmba_m_t.nmbacomp #161005-00003#4 mark
                     LET g_nmba_m.nmbacomp = g_nmba_m_o.nmbacomp #161005-00003#4 add
                     LET g_nmba_m.nmbasite_desc = s_desc_get_department_desc(g_nmba_m.nmbasite)                    
                     NEXT FIELD CURRENT
                  END IF
                  #160816-00012#3 Add  ---(E)---                  
                  #CALL s_anm_get_site_wc('6',g_nmba_m.nmbacomp,g_nmba_m.nmbadocdt) RETURNING g_site_wc #160912-00024#1
                  CALL anmt540_glaa_get()
                  #--150707-00001#7--(e)                  
               END IF
#2015/04/02--by--02599--add--end
            END IF 
           #CALL anmt540_glaa_get()   #150707-00001#7 mark
            CALL anmt540_ref_show()
            LET g_nmba_m_o.* = g_nmba_m.* #161005-00003#4 add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbacomp
            #add-point:BEFORE FIELD nmbacomp name="input.b.nmbacomp"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbacomp
            #add-point:ON CHANGE nmbacomp name="input.g.nmbacomp"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmba002
            #add-point:BEFORE FIELD nmba002 name="input.b.nmba002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmba002
            
            #add-point:AFTER FIELD nmba002 name="input.a.nmba002"


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmba002
            #add-point:ON CHANGE nmba002 name="input.g.nmba002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbadocno
            
            #add-point:AFTER FIELD nmbadocno name="input.a.nmbadocno"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_nmba_m.nmbacomp) AND NOT cl_null(g_nmba_m.nmbadocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_nmba_m.nmbacomp != g_nmbacomp_t  OR g_nmba_m.nmbadocno != g_nmbadocno_t )) THEN 
                  IF NOT ap_chk_notDup(g_nmba_m.nmbadocno,"SELECT COUNT(*) FROM nmba_t WHERE "||"nmbaent = '" ||g_enterprise|| "' AND "||"nmbacomp = '"||g_nmba_m.nmbacomp ||"' AND "|| "nmbadocno = '"||g_nmba_m.nmbadocno ||"'",'std-00004',0) THEN 
                     LET g_nmba_m.nmbadocno = ''
                     NEXT FIELD nmbadocno
                  END IF
               END IF
            END IF

            IF NOT cl_null(g_nmba_m.nmbadocno) THEN 
               IF NOT anmt540_nmbadocno_chk() THEN 
                  LET g_nmba_m.nmbadocno = ''
                  LET g_nmba_m.nmbadocno_desc = ''
                  NEXT FIELD nmbadocno
               END IF
               #161104-00046#14-----s
               CALL s_control_chk_doc('1',g_nmba_m.nmbadocno,'4',g_user,g_dept,'','') RETURNING g_sub_success,l_flag
               IF g_sub_success AND l_flag THEN             
               ELSE
                  LET g_nmba_m.nmbadocno = g_nmba_m_o.nmbadocno 
                  NEXT FIELD CURRENT                  
               END IF
               CALL s_aooi200_fin_get_slip(g_nmba_m.nmbadocno) RETURNING g_sub_success,l_slip
               #刪除單別預設temptable
               DELETE FROM s_aooi200def1
               #以目前畫面資訊新增temp資料   #請勿調整.*
               INSERT INTO s_aooi200def1 VALUES(g_nmba_m.*)
               #依單別預設取用資訊
               CALL s_aooi200def_get('','',g_nmba_m.nmbacomp,'2',l_slip,'','',g_glaald)
               #依單別預設值TEMP內容 給予到畫面上   #請勿調整.*
               SELECT * INTO g_nmba_m.* FROM s_aooi200def1
               #161104-00046#14-----e  
               CALL anmt540_nmba006_chk()
               #IF NOT cl_null(g_nmba_m.nmbadocdt) THEN 
               #   #单据编号
               #   CALL s_aooi200_gen_docno(g_nmba_m.nmbacomp,g_nmba_m.nmbadocno,g_nmba_m.nmbadocdt,g_prog)
               #   RETURNING l_success,g_nmba_m.nmbadocno
               #   IF l_success  = 0  THEN
               #      CALL cl_err(g_nmba_m.nmbadocno,'apm-00003',1)
               #      NEXT FIELD nmbadocno
               #   END IF 
               #   DISPLAY BY NAME g_nmba_m.nmbadocno
               #   LET g_flag = 'Y'
               #END IF 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbadocno
            #add-point:BEFORE FIELD nmbadocno name="input.b.nmbadocno"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbadocno
            #add-point:ON CHANGE nmbadocno name="input.g.nmbadocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbadocdt
            #add-point:BEFORE FIELD nmbadocdt name="input.b.nmbadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbadocdt
            
            #add-point:AFTER FIELD nmbadocdt name="input.a.nmbadocdt"
            IF NOT cl_null(g_nmba_m.nmbadocdt) THEN 
               #150813-00015#14--mod--str--
              #IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_nmba_m.nmbadocdt != g_nmba_m_t.nmbadocdt OR cl_null(g_nmba_m_t.nmbadocdt))) THEN  #161005-00003#4 mark
               IF g_nmba_m.nmbadocdt != g_nmba_m_o.nmbadocdt OR cl_null(g_nmba_m_o.nmbadocdt) THEN #161005-00003#4 add
                  #檢查當單據日期小於等於關帳日期時，不可異動單據
                  CALL s_fin_date_close_chk('',g_nmba_m.nmbacomp,'ANM',g_nmba_m.nmbadocdt) RETURNING l_success
                  IF l_success=FALSE THEN
                    #LET g_nmba_m.nmbadocdt = g_nmba_m_t.nmbadocdt #161005-00003#4 mark
                     LET g_nmba_m.nmbadocdt = g_nmba_m_o.nmbadocdt #161005-00003#4 add
                     NEXT FIELD CURRENT
                  END IF
               END IF
#               LET l_ooab002 = ''
#               SELECT ooab002 INTO l_ooab002
#                 FROM ooab_t
#                WHERE ooabent = g_enterprise
#                  AND ooab001 = 'S-FIN-4002'
#                  AND ooabsite = g_nmba_m.nmbacomp
#               IF g_nmba_m.nmbadocdt < l_ooab002 THEN 
#                  IF p_cmd = 'a' THEN 
#                     DISPLAY '' TO nmbadocdt
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code = 'anm-00036'
#                     LET g_errparam.extend = g_nmba_m.nmbadocdt
#                     LET g_errparam.popup = TRUE
#                     CALL cl_err()
#
#                     LET g_nmba_m.nmbadocdt = ''
#                  ELSE
#                     DISPLAY '' TO nmbadocdt
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code = 'anm-00036'
#                     LET g_errparam.extend = g_nmba_m.nmbadocdt
#                     LET g_errparam.popup = TRUE
#                     CALL cl_err()
#
#                     LET g_nmba_m.nmbadocdt = g_nmba_m_t.nmbadocdt
#                  END IF
#                  NEXT FIELD nmbadocdt
#               END IF
            #150813-00015#14--mod--end
            END IF 
            #IF NOT cl_null(g_nmba_m.nmbadocdt) AND not cl_null(g_nmba_m.nmbadocno) AND p_cmd = 'a' THEN 
            #   IF g_flag = 'N' THEN
            #      #单据编号
            #      CALL s_aooi200_gen_docno(g_nmba_m.nmbacomp,g_nmba_m.nmbadocno,g_nmba_m.nmbadocdt,g_prog)
            #      RETURNING l_success,g_nmba_m.nmbadocno
            #      IF l_success  = 0  THEN
            #         CALL cl_err(g_nmba_m.nmbadocno,'apm-00003',1)
            #         NEXT FIELD nmbadocno
            #      END IF 
            #      DISPLAY BY NAME g_nmba_m.nmbadocno
            #   END IF
            #END IF 
            LET g_nmba_m_o.* = g_nmba_m.* #161005-00003#4 add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbadocdt
            #add-point:ON CHANGE nmbadocdt name="input.g.nmbadocdt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmba003
            #add-point:BEFORE FIELD nmba003 name="input.b.nmba003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmba003
            
            #add-point:AFTER FIELD nmba003 name="input.a.nmba003"


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmba003
            #add-point:ON CHANGE nmba003 name="input.g.nmba003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmba004
            #add-point:BEFORE FIELD nmba004 name="input.b.nmba004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmba004
            
            #add-point:AFTER FIELD nmba004 name="input.a.nmba004"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmba004
            #add-point:ON CHANGE nmba004 name="input.g.nmba004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmba005
            #add-point:BEFORE FIELD nmba005 name="input.b.nmba005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmba005
            
            #add-point:AFTER FIELD nmba005 name="input.a.nmba005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmba005
            #add-point:ON CHANGE nmba005 name="input.g.nmba005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmba006
            #add-point:BEFORE FIELD nmba006 name="input.b.nmba006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmba006
            
            #add-point:AFTER FIELD nmba006 name="input.a.nmba006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmba006
            #add-point:ON CHANGE nmba006 name="input.g.nmba006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbastus
            #add-point:BEFORE FIELD nmbastus name="input.b.nmbastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbastus
            
            #add-point:AFTER FIELD nmbastus name="input.a.nmbastus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbastus
            #add-point:ON CHANGE nmbastus name="input.g.nmbastus"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.nmbasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbasite
            #add-point:ON ACTION controlp INFIELD nmbasite name="input.c.nmbasite"
            #資金中心
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL  #161213-00020#5 20170213 add by 08172
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_nmba_m.nmbasite
#            LET g_qryparam.where = " ooef206 = 'Y'"  #161213-00020#5 20170210 mark by 08172
            LET g_qryparam.arg1=g_user
#            LET g_qryparam.where = g_qryparam.where," AND ooefstus= 'Y'" #161021-00050#10  #161213-00020#5 20170210 mark by 08172
            #CALL q_ooef001()    #161021-00050#10 mark
            CALL q_ooef001_33()  #161021-00050#10
            LET g_nmba_m.nmbasite = g_qryparam.return1
            DISPLAY g_nmba_m.nmbasite TO nmbasite
            NEXT FIELD nmbasite
            #END add-point
 
 
         #Ctrlp:input.c.nmba008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmba008
            #add-point:ON ACTION controlp INFIELD nmba008 name="input.c.nmba008"
            #繳款人員
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_nmba_m.nmba008
            CALL q_ooag001_8()
            LET g_nmba_m.nmba008 = g_qryparam.return1
            DISPLAY g_nmba_m.nmba008 TO nmba008
            SELECT ooag004 INTO g_nmba_m.nmba001 FROM ooag_t
             WHERE ooag001 = g_nmba_m.nmba008
               AND ooagent = g_enterprise #2015/04/02 by 02599 add
            DISPLAY g_nmba_m.nmba001 TO nmba001
            CALL anmt540_ref_show()
            NEXT FIELD nmba008
            #END add-point
 
 
         #Ctrlp:input.c.nmba001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmba001
            #add-point:ON ACTION controlp INFIELD nmba001 name="input.c.nmba001"
            #此段落由子樣板a07產生            
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_nmba_m.nmba001             #給予default值
            #給予arg
            LET g_qryparam.arg1 = g_nmba_m.nmbadocdt               #150707-00001#7
            CALL q_ooeg001_4()                                     #150707-00001#7
           #CALL q_ooef001()                                       #150707-00001#7 mark
            LET g_nmba_m.nmba001 = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_nmba_m.nmba001 TO nmba001                    #顯示到畫面上
            CALL anmt540_ref_show()                                #150707-00001#7
            NEXT FIELD nmba001                                     #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.nmbacomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbacomp
            #add-point:ON ACTION controlp INFIELD nmbacomp name="input.c.nmbacomp"
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_nmba_m.nmbacomp
            #LET g_qryparam.where = " ooef003 = 'Y' "
            #2015/04/02--by--02599--add--str--
            #CALL s_fin_create_account_center_tmp()       #Belle Mark要一開始就給不然手動輸入沒有tmp
            #--150707-00001#7--mark--(s)
            #CALL s_fin_account_center_sons_query('6',g_nmba_m.nmbasite,g_today,'')
            #CALL s_fin_account_center_comp_str()RETURNING l_origin_str
            #CALL s_fin_get_wc_str(l_origin_str)RETURNING l_origin_str
            #LET g_qryparam.where = " ooef003 = 'Y' AND ooef001 IN ",l_origin_str CLIPPED
            ##2015/04/02--by--02599--add--end
            #--150707-00001#7--mark--(e)
            CALL s_anm_get_comp_wc('6',g_nmba_m.nmbasite,g_nmba_m.nmbadocdt) RETURNING g_comp_wc  #160816-00012#3 add           
            LET g_qryparam.where = " ooef001 IN ",g_comp_wc   #150707-00001#7
            #160816-00012#3 Add  ---(S)---
            CALL s_axrt300_get_site(g_user,'','3') RETURNING l_wc
            #LET g_qryparam.where = g_qryparam.where," AND ",l_wc CLIPPED," AND ooef003 = 'Y'"   #161028-00051#1   mark
            #160816-00012#3 Add  ---(E)---
            #LET g_qryparam.where = g_qryparam.where," AND ",l_wc CLIPPED," AND ooef003 = 'Y' AND ooef001 IN ",g_wc_cs_comp   #161028-00051#1   add   #161111-00031#1   mark
#            LET g_qryparam.where = g_qryparam.where," AND ",l_wc CLIPPED," AND ooef003 = 'Y'"   #161111-00031#1   add #161213-00020#5 20170210 mark by 08172
            LET g_qryparam.where = g_qryparam.where," AND ",l_wc CLIPPED #161213-00020#5 20170210 add by 08172
            #CALL q_ooef001()  #161021-00050#10 mark
            CALL q_ooef001_2() #161021-00050#10
            LET g_nmba_m.nmbacomp = g_qryparam.return1
            DISPLAY g_nmba_m.nmbacomp TO nmbacomp
            CALL anmt540_ref_show()
            NEXT FIELD nmbacomp 
            #END add-point
 
 
         #Ctrlp:input.c.nmba002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmba002
            #add-point:ON ACTION controlp INFIELD nmba002 name="input.c.nmba002"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_nmba_m.nmba002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

 
            CALL q_ooag001_2()                                #呼叫開窗
 
            LET g_nmba_m.nmba002 = g_qryparam.return1              

            DISPLAY g_nmba_m.nmba002 TO nmba002              #

            NEXT FIELD nmba002                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.nmbadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbadocno
            #add-point:ON ACTION controlp INFIELD nmbadocno name="input.c.nmbadocno"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_nmba_m.nmbadocno             #給予default值 
               
            #LET g_qryparam.where = "ooba001 = '",g_glaa024,"' AND oobx004 = 'anmt540'"    #150904-00006#1 
#            LET g_qryparam.where = "ooba001 = '",g_glaa024,"' AND oobx004 = '",g_prog,"' " #150904-00006#1 #161213-00020#5 20170210 mark by 08172
            LET g_qryparam.where = "ooba001 = '",g_glaa024,"' AND EXISTS (SELECT 1 FROM oobl_t WHERE ooblent=oobaent  AND oobl001=ooba002 AND oobl002='",g_prog,"' )" #161213-00020#5 20170210 add by 08172
            #給予arg
            #161104-00046#14-----s
            IF NOT cl_null(g_user_slip_wc)THEN
               LET g_qryparam.where = g_qryparam.where," AND ",g_user_slip_wc CLIPPED
            END IF
            #161104-00046#14-----e
            CALL q_ooba002_4()                                #呼叫開窗

            LET g_nmba_m.nmbadocno = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_nmba_m.nmbadocno TO nmbadocno              #顯示到畫面上
            #CALL s_aooi200_get_slip_desc(g_nmba_m.nmbadocno)        #2014/12/29 liuym mark
            CALL s_aooi200_fin_get_slip_desc(g_nmba_m.nmbadocno)     #2014/12/29 liuym add
            RETURNING g_nmba_m.nmbadocno_desc
            DISPLAY g_nmba_m.nmbadocno_desc TO nmbadocno_desc
            NEXT FIELD nmbadocno                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.nmbadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbadocdt
            #add-point:ON ACTION controlp INFIELD nmbadocdt name="input.c.nmbadocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmba003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmba003
            #add-point:ON ACTION controlp INFIELD nmba003 name="input.c.nmba003"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmba004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmba004
            #add-point:ON ACTION controlp INFIELD nmba004 name="input.c.nmba004"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmba005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmba005
            #add-point:ON ACTION controlp INFIELD nmba005 name="input.c.nmba005"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmba006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmba006
            #add-point:ON ACTION controlp INFIELD nmba006 name="input.c.nmba006"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmbastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbastus
            #add-point:ON ACTION controlp INFIELD nmbastus name="input.c.nmbastus"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_nmba_m.nmbacomp,g_nmba_m.nmbadocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               #单据编号
               #CALL s_aooi200_gen_docno(g_nmba_m.nmbacomp,g_nmba_m.nmbadocno,g_nmba_m.nmbadocdt,g_prog)                #2014/12/29 liuym mark
               CALL s_aooi200_fin_gen_docno(g_glaald,g_glaa024,g_glaa003,g_nmba_m.nmbadocno,g_nmba_m.nmbadocdt,g_prog)  #2014/12/29 liuym add
               RETURNING l_success,g_nmba_m.nmbadocno
               IF l_success  = 0  THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apm-00003'
                  LET g_errparam.extend = g_nmba_m.nmbadocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  #RETURN  #2015/05/08 by 02599 mark
                  NEXT FIELD nmbadocno #2015/05/08 by 02599 add
               END IF 
               DISPLAY BY NAME g_nmba_m.nmbadocno
               #end add-point
               
               INSERT INTO nmba_t (nmbaent,nmbasite,nmba008,nmba001,nmbacomp,nmba002,nmbadocno,nmbadocdt, 
                   nmba003,nmba004,nmba005,nmba006,nmbastus,nmbaownid,nmbaowndp,nmbacrtid,nmbacrtdp, 
                   nmbacrtdt,nmbamodid,nmbamoddt,nmbacnfid,nmbacnfdt)
               VALUES (g_enterprise,g_nmba_m.nmbasite,g_nmba_m.nmba008,g_nmba_m.nmba001,g_nmba_m.nmbacomp, 
                   g_nmba_m.nmba002,g_nmba_m.nmbadocno,g_nmba_m.nmbadocdt,g_nmba_m.nmba003,g_nmba_m.nmba004, 
                   g_nmba_m.nmba005,g_nmba_m.nmba006,g_nmba_m.nmbastus,g_nmba_m.nmbaownid,g_nmba_m.nmbaowndp, 
                   g_nmba_m.nmbacrtid,g_nmba_m.nmbacrtdp,g_nmba_m.nmbacrtdt,g_nmba_m.nmbamodid,g_nmba_m.nmbamoddt, 
                   g_nmba_m.nmbacnfid,g_nmba_m.nmbacnfdt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_nmba_m:",SQLERRMESSAGE 
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
                  CALL anmt540_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL anmt540_b_fill()
                  CALL anmt540_b_fill2('0')
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
               CALL anmt540_nmba_t_mask_restore('restore_mask_o')
               
               UPDATE nmba_t SET (nmbasite,nmba008,nmba001,nmbacomp,nmba002,nmbadocno,nmbadocdt,nmba003, 
                   nmba004,nmba005,nmba006,nmbastus,nmbaownid,nmbaowndp,nmbacrtid,nmbacrtdp,nmbacrtdt, 
                   nmbamodid,nmbamoddt,nmbacnfid,nmbacnfdt) = (g_nmba_m.nmbasite,g_nmba_m.nmba008,g_nmba_m.nmba001, 
                   g_nmba_m.nmbacomp,g_nmba_m.nmba002,g_nmba_m.nmbadocno,g_nmba_m.nmbadocdt,g_nmba_m.nmba003, 
                   g_nmba_m.nmba004,g_nmba_m.nmba005,g_nmba_m.nmba006,g_nmba_m.nmbastus,g_nmba_m.nmbaownid, 
                   g_nmba_m.nmbaowndp,g_nmba_m.nmbacrtid,g_nmba_m.nmbacrtdp,g_nmba_m.nmbacrtdt,g_nmba_m.nmbamodid, 
                   g_nmba_m.nmbamoddt,g_nmba_m.nmbacnfid,g_nmba_m.nmbacnfdt)
                WHERE nmbaent = g_enterprise AND nmbacomp = g_nmbacomp_t
                  AND nmbadocno = g_nmbadocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "nmba_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL anmt540_nmba_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_nmba_m_t)
               LET g_log2 = util.JSON.stringify(g_nmba_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_nmbacomp_t = g_nmba_m.nmbacomp
            LET g_nmbadocno_t = g_nmba_m.nmbadocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="anmt540.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_nmbb_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_nmbb_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL anmt540_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_nmbb_d.getLength()
            #add-point:資料輸入前 name="input.d.before_input"
            CALL anmt540_glaa_get()
            #160530-00005#4--add--str--
            #当anmt540单别参数D-FIN-4004=Y表示走anmt550复核流程，此时存提码和现金变动码不为必输栏位，反之，为必输栏位
            LET g_conf = 'N'
            CALL s_aooi200_fin_get_slip(g_nmba_m.nmbadocno) RETURNING l_success,l_slip
            #獲取單據別對應參數：收款審核是否分開審核
            CALL s_fin_get_doc_para(g_glaald,g_nmba_m.nmbacomp,l_slip,'D-FIN-4004') RETURNING g_conf 
            #160530-00005#4--add--end
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
            OPEN anmt540_cl USING g_enterprise,g_nmba_m.nmbacomp,g_nmba_m.nmbadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN anmt540_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE anmt540_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_nmbb_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_nmbb_d[l_ac].nmbbseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_nmbb_d_t.* = g_nmbb_d[l_ac].*  #BACKUP
               LET g_nmbb_d_o.* = g_nmbb_d[l_ac].*  #BACKUP
               CALL anmt540_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL anmt540_set_no_entry_b(l_cmd)
               IF NOT anmt540_lock_b("nmbb_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH anmt540_bcl INTO g_nmbb_d[l_ac].nmbbseq,g_nmbb_d[l_ac].nmbborga,g_nmbb_d[l_ac].nmbb026, 
                      g_nmbb_d[l_ac].nmbb027,g_nmbb_d[l_ac].nmbb028,g_nmbb_d[l_ac].nmbb003,g_nmbb_d[l_ac].nmbb030, 
                      g_nmbb_d[l_ac].nmbb043,g_nmbb_d[l_ac].nmbb073,g_nmbb_d[l_ac].nmbb031,g_nmbb_d[l_ac].nmbb004, 
                      g_nmbb_d[l_ac].nmbb005,g_nmbb_d[l_ac].nmbb006,g_nmbb_d[l_ac].nmbb007,g_nmbb_d[l_ac].nmbb040, 
                      g_nmbb_d[l_ac].nmbb041,g_nmbb_d[l_ac].nmbb044,g_nmbb_d[l_ac].nmbb002,g_nmbb_d[l_ac].nmbb010, 
                      g_nmbb_d[l_ac].nmbblegl,g_nmbb_d[l_ac].nmbb045,g_nmbb_d[l_ac].nmbb029,g_nmbb_d[l_ac].nmbb039, 
                      g_nmbb_d[l_ac].nmbb001,g_nmbb_d[l_ac].nmbb011,g_nmbb_d[l_ac].nmbb012,g_nmbb_d[l_ac].nmbb013, 
                      g_nmbb_d[l_ac].nmbb014,g_nmbb_d[l_ac].nmbb015,g_nmbb_d[l_ac].nmbb016,g_nmbb_d[l_ac].nmbb017, 
                      g_nmbb_d[l_ac].nmbb018,g_nmbb_d[l_ac].nmbb019,g_nmbb_d[l_ac].nmbb020,g_nmbb_d[l_ac].nmbb021, 
                      g_nmbb_d[l_ac].nmbb022,g_nmbb_d[l_ac].nmbb023,g_nmbb_d[l_ac].nmbb024,g_nmbb_d[l_ac].nmbb053, 
                      g_nmbb_d[l_ac].nmbb054,g_nmbb_d[l_ac].nmbb008,g_nmbb_d[l_ac].nmbb009,g_nmbb_d[l_ac].nmbb056, 
                      g_nmbb_d[l_ac].nmbb057,g_nmbb_d[l_ac].nmbb058,g_nmbb_d[l_ac].nmbb059,g_nmbb_d[l_ac].nmbb060, 
                      g_nmbb_d[l_ac].nmbb061,g_nmbb_d[l_ac].nmbb062,g_nmbb_d[l_ac].nmbb066,g_nmbb_d[l_ac].nmbb067, 
                      g_nmbb_d[l_ac].nmbb068,g_nmbb_d[l_ac].nmbb042,g_nmbb_d[l_ac].nmbb069,g_nmbb_d[l_ac].nmbb025 
 
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_nmbb_d_t.nmbbseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_nmbb_d_mask_o[l_ac].* =  g_nmbb_d[l_ac].*
                  CALL anmt540_nmbb_t_mask()
                  LET g_nmbb_d_mask_n[l_ac].* =  g_nmbb_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL anmt540_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            CALL anmt540_ref_b()
            CALL anmt540_nmbborga_desc()
     
            IF g_nmbb_d[l_ac].nmbb029 = '20'  OR g_nmbb_d[l_ac].nmbb029 = '10' THEN 
               CALL cl_set_comp_entry('nmbb003',TRUE)
               CALL cl_set_comp_entry('nmbb044,nmbb045',FALSE)
               LET g_nmbb_d[l_ac].nmbb044 = ''
               LET g_nmbb_d[l_ac].nmbb045 = ''
               IF g_conf = 'N' THEN   #160530-00005#4 不走anmt550复核流程时，存提码和现金变动码必须录入
               CALL cl_set_comp_required('nmbb002,nmbb010',TRUE) #151127-00006#2 add
               END IF
            ELSE
               CALL cl_set_comp_entry('nmbb003',FALSE)
               CALL cl_set_comp_entry('nmbb044,nmbb045',TRUE)
               LET g_nmbb_d[l_ac].nmbb003 = ' '
               CALL cl_set_comp_required('nmbb002,nmbb010',FALSE) #151127-00006#2 add
            END IF 
            
            IF g_nmbb_d[l_ac].nmbb029 = '30' THEN 
               CALL anmt540_set_comp_entry('nmbb030,nmbb043_desc,nmbb031,nmbb040,nmbb041,nmbb073',TRUE) #161125-00052#2 add nmbb073
            ELSE
               CALL anmt540_set_comp_entry('nmbb030,nmbb043_desc,nmbb031,nmbb040,nmbb041,nmbb073',FALSE) #161125-00052#2 add nmbb073
               LET g_nmbb_d[l_ac].nmbb030 = ''
               LET g_nmbb_d[l_ac].nmbb043 = ''
               LET g_nmbb_d[l_ac].nmbb043_desc = ''
               LET g_nmbb_d[l_ac].nmbb073 = '' #161125-00052#2 add 
               IF g_nmbb_d[l_ac].nmbb029 = '10' THEN 
                  LET g_nmbb_d[l_ac].nmbb031 = g_nmba_m.nmbadocdt
               ELSE
                  LET g_nmbb_d[l_ac].nmbb031 = ''
               END IF
               LET g_nmbb_d[l_ac].nmbb041 = ''
               LET g_nmbb_d[l_ac].nmbb040 = 'N'
            END IF
            CALL anmt540_nmbb001_entry()   #151222-00010#7
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
            INITIALIZE g_nmbb_d[l_ac].* TO NULL 
            INITIALIZE g_nmbb_d_t.* TO NULL 
            INITIALIZE g_nmbb_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_nmbb_d[l_ac].nmbb006 = "0"
      LET g_nmbb_d[l_ac].nmbb007 = "0"
      LET g_nmbb_d[l_ac].nmbb040 = "N"
      LET g_nmbb_d[l_ac].nmbb013 = "0"
      LET g_nmbb_d[l_ac].nmbb014 = "0"
      LET g_nmbb_d[l_ac].nmbb017 = "0"
      LET g_nmbb_d[l_ac].nmbb018 = "0"
      LET g_nmbb_d[l_ac].nmbb020 = "0"
      LET g_nmbb_d[l_ac].nmbb021 = "0"
      LET g_nmbb_d[l_ac].nmbb023 = "0"
      LET g_nmbb_d[l_ac].nmbb024 = "0"
      LET g_nmbb_d[l_ac].nmbb008 = "0"
      LET g_nmbb_d[l_ac].nmbb009 = "0"
      LET g_nmbb_d[l_ac].nmbb057 = "0"
      LET g_nmbb_d[l_ac].nmbb058 = "0"
      LET g_nmbb_d[l_ac].nmbb059 = "0"
      LET g_nmbb_d[l_ac].nmbb060 = "0"
      LET g_nmbb_d[l_ac].nmbb062 = "0"
      LET g_nmbb_d[l_ac].nmbb066 = "0"
      LET g_nmbb_d[l_ac].nmbb067 = "0"
      LET g_nmbb_d[l_ac].nmbb068 = "0"
      LET g_nmbb_d[l_ac].nmbb042 = "1"
      LET g_nmbb_d[l_ac].nmbb069 = "N"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            #LET g_nmbb_d[l_ac].nmbborga = g_nmba_m.nmbacomp #160912-00024#1
            LET g_nmbb_d[l_ac].nmbborga = g_nmba_m.nmbasite  #160912-00024#1 add
            CALL s_anm_orga_chk(g_nmbb_d[l_ac].nmbborga,g_nmba_m.nmbacomp) RETURNING g_nmbb_d[l_ac].nmbborga  #160912-00024#1 add            
            LET g_nmbb_d[l_ac].nmbborga_desc = s_desc_get_department_desc(g_nmbb_d[l_ac].nmbborga)   #150707-00001#7
            ##150904-00006#1 ---s---
            #IF g_prog = 'anmt541' THEN        #160705-00042#9 160713 by sakura mark
            IF g_prog MATCHES 'anmt541' THEN   #160705-00042#9 160713 by sakura add
               LET g_nmbb_d[l_ac].nmbb026 = 'EMPL'
            END IF
            LET g_nmbb_d[l_ac].nmbb027 = g_nmba_m.nmba008            
            CALL s_desc_get_person_desc(g_nmbb_d[l_ac].nmbb027 ) RETURNING g_nmbb_d[l_ac].nmbb027_desc
            DISPLAY BY NAME g_nmbb_d[l_ac].nmbb027_desc
            #150904-00006#1 ---e---
            CALL anmt540_nmbb001_entry()   #151222-00010#7
            #end add-point
            LET g_nmbb_d_t.* = g_nmbb_d[l_ac].*     #新輸入資料
            LET g_nmbb_d_o.* = g_nmbb_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL anmt540_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL anmt540_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_nmbb_d[li_reproduce_target].* = g_nmbb_d[li_reproduce].*
 
               LET g_nmbb_d[li_reproduce_target].nmbbseq = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
            IF l_cmd = 'a' THEN 
               IF cl_null(g_nmbb_d[g_detail_idx].nmbbseq) THEN 
                  SELECT MAX(nmbbseq) INTO g_nmbb_d[g_detail_idx].nmbbseq
                    FROM nmbb_t
                   WHERE nmbbent = g_enterprise
                     AND nmbbcomp = g_nmba_m.nmbacomp
                     AND nmbbdocno = g_nmba_m.nmbadocno
                     
                  IF cl_null(g_nmbb_d[g_detail_idx].nmbbseq) THEN 
                     LET g_nmbb_d[g_detail_idx].nmbbseq = 1
                  ELSE
                     LET g_nmbb_d[g_detail_idx].nmbbseq = g_nmbb_d[g_detail_idx].nmbbseq + 1
                  END IF
               END IF
            END IF
            LET g_nmbb_d[l_ac].nmbb004 = g_ooef016
            IF l_ac > 1 THEN 
               LET g_nmbb_d[l_ac].nmbb026 = g_nmbb_d[l_ac-1].nmbb026
               CALL anmt540_ref_b()
            END IF
            LET g_nmbb_d[l_ac].nmbb005 = 1  #給匯率賦初始值
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
            CALL anmt540_ref_amt()
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM nmbb_t 
             WHERE nmbbent = g_enterprise AND nmbbcomp = g_nmba_m.nmbacomp
               AND nmbbdocno = g_nmba_m.nmbadocno
 
               AND nmbbseq = g_nmbb_d[l_ac].nmbbseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_nmba_m.nmbacomp
               LET gs_keys[2] = g_nmba_m.nmbadocno
               LET gs_keys[3] = g_nmbb_d[g_detail_idx].nmbbseq
               CALL anmt540_insert_b('nmbb_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_nmbb_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "nmbb_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL anmt540_b_fill()
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               CALL anmt540_ins_glbc() RETURNING l_success
               IF l_success = FALSE THEN
                  CALL s_transaction_end('N','0')
                  CANCEL INSERT
               END IF
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
               LET gs_keys[01] = g_nmba_m.nmbacomp
               LET gs_keys[gs_keys.getLength()+1] = g_nmba_m.nmbadocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_nmbb_d_t.nmbbseq
 
            
               #刪除同層單身
               IF NOT anmt540_delete_b('nmbb_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE anmt540_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT anmt540_key_delete_b(gs_keys,'nmbb_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE anmt540_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE anmt540_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_nmbb_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_nmbb_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbbseq
            #add-point:BEFORE FIELD nmbbseq name="input.b.page1.nmbbseq"
            IF cl_null(g_nmbb_d[g_detail_idx].nmbbseq) THEN 
               SELECT MAX(nmbbseq) INTO g_nmbb_d[g_detail_idx].nmbbseq
                 FROM nmbb_t
                WHERE nmbbent = g_enterprise
                  AND nmbbcomp = g_nmba_m.nmbacomp
                  AND nmbbdocno = g_nmba_m.nmbadocno
                  
               IF cl_null(g_nmbb_d[g_detail_idx].nmbbseq) THEN 
                  LET g_nmbb_d[g_detail_idx].nmbbseq = 1
               ELSE
                  LET g_nmbb_d[g_detail_idx].nmbbseq = g_nmbb_d[g_detail_idx].nmbbseq + 1
               END IF
            END IF
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbbseq
            
            #add-point:AFTER FIELD nmbbseq name="input.a.page1.nmbbseq"
            #此段落由子樣板a05產生
            IF  g_nmba_m.nmbacomp IS NOT NULL AND g_nmba_m.nmbadocno IS NOT NULL AND g_nmbb_d[g_detail_idx].nmbbseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_nmba_m.nmbacomp != g_nmbacomp_t OR g_nmba_m.nmbadocno != g_nmbadocno_t OR g_nmbb_d[g_detail_idx].nmbbseq != g_nmbb_d_t.nmbbseq)) THEN 
                  IF NOT ap_chk_notDup(g_nmbb_d[g_detail_idx].nmbbseq,"SELECT COUNT(*) FROM nmbb_t WHERE "||"nmbbent = '" ||g_enterprise|| "' AND "||"nmbbcomp = '"||g_nmba_m.nmbacomp ||"' AND "|| "nmbbdocno = '"||g_nmba_m.nmbadocno ||"' AND "|| "nmbbseq = '"||g_nmbb_d[g_detail_idx].nmbbseq ||"'",'std-00004',0) THEN 
                     LET g_nmbb_d[g_detail_idx].nmbbseq = ''
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbbseq
            #add-point:ON CHANGE nmbbseq name="input.g.page1.nmbbseq"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbborga
            
            #add-point:AFTER FIELD nmbborga name="input.a.page1.nmbborga"
            IF NOT cl_null(g_nmbb_d[l_ac].nmbborga) THEN  
               IF NOT anmt540_nmbborga_chk() THEN 
                  IF l_cmd = 'a' THEN 
                     DISPLAY '' TO s_detail1[l_ac].nmbborga
                     DISPLAY '' TO s_detail1[l_ac].nmbborga_desc
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_nmbb_d[l_ac].nmbborga
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_nmbb_d[l_ac].nmbborga = ''
                     LET g_nmbb_d[l_ac].nmbborga_desc = ''
                  ELSE
                     DISPLAY '' TO s_detail1[l_ac].nmbborga
                     DISPLAY '' TO s_detail1[l_ac].nmbborga_desc
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_nmbb_d[l_ac].nmbborga
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_nmbb_d[l_ac].nmbborga = g_nmbb_d_t.nmbborga
                     LET g_nmbb_d[l_ac].nmbborga_desc = g_nmbb_d_t.nmbborga_desc   
                  END IF 
                  DISPLAY g_nmbb_d[l_ac].nmbborga TO s_detail1[l_ac].nmbborga
                  DISPLAY g_nmbb_d[l_ac].nmbborga_desc TO s_detail1[l_ac].nmbborga_desc
                  NEXT FIELD nmbborga
               END IF
               IF NOT cl_null(g_errno) THEN 
                  DISPLAY '' TO s_detail1[l_ac].nmbborga
                  DISPLAY '' TO s_detail1[l_ac].nmbborga_desc
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_nmbb_d[l_ac].nmbborga
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_nmbb_d[l_ac].nmbborga = g_nmbb_d_t.nmbborga
                  LET g_nmbb_d[l_ac].nmbborga_desc = g_nmbb_d_t.nmbborga_desc
               #160912-00024#1 add s---   
               ELSE                  
                  IF NOT ap_chk_isExist(g_nmbb_d[l_ac].nmbborga,"SELECT COUNT(*) FROM ooef_t WHERE "||"ooefent = '" ||g_enterprise|| "' AND "||"ooef001 = ?  AND ooefstus ='Y' AND ooef017 = '"||g_nmba_m.nmbacomp||"'",'anm-03022',1) THEN 
                     LET g_nmbb_d[l_ac].nmbborga = g_nmbb_d_t.nmbborga
                     NEXT FIELD CURRENT
                  END IF  
               #160912-00024#1 add e---                  
               END IF 
            END IF 
            CALL anmt540_nmbborga_desc()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbborga
            #add-point:BEFORE FIELD nmbborga name="input.b.page1.nmbborga"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbborga
            #add-point:ON CHANGE nmbborga name="input.g.page1.nmbborga"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb026
            
            #add-point:AFTER FIELD nmbb026 name="input.a.page1.nmbb026"
            CALL anmt540_ref_b()
            IF NOT cl_null(g_nmbb_d[l_ac].nmbb026) THEN 
               CALL anmt540_nmbb026_chk()
               IF NOT cl_null(g_errno) THEN 
                  IF p_cmd = 'a' THEN 
                     DISPLAY '' TO nmbb026
                     DISPLAY '' TO nmbb026_desc
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_nmbb_d[l_ac].nmbb026
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_nmbb_d[l_ac].nmbb026 = ''
                     LET g_nmbb_d[l_ac].nmbb026_desc = ''
                  ELSE
                     DISPLAY '' TO nmbb026
                     DISPLAY '' TO nmbb026_desc
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_nmbb_d[l_ac].nmbb026
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_nmbb_d[l_ac].nmbb026 = g_nmbb_d_t.nmbb026
                     LET g_nmbb_d[l_ac].nmbb026_desc = g_nmbb_d_t.nmbb026_desc
                  END IF 
                  NEXT FIELD nmbb026
               END IF 
            END IF 
            CALL anmt540_ref_b()

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb026
            #add-point:BEFORE FIELD nmbb026 name="input.b.page1.nmbb026"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbb026
            #add-point:ON CHANGE nmbb026 name="input.g.page1.nmbb026"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb027
            
            #add-point:AFTER FIELD nmbb027 name="input.a.page1.nmbb027"
            LET g_nmbb_d[l_ac].nmbb027_desc = ''
            IF NOT cl_null(g_nmbb_d[l_ac].nmbb027) THEN             
                CALL s_employee_chk(g_nmbb_d[l_ac].nmbb027) RETURNING g_sub_success
                  IF NOT g_sub_success THEN
                     LET g_nmbb_d[l_ac].nmbb027 = g_nmbb_d_t.nmbb027
                     CALL s_desc_get_person_desc(g_nmbb_d[l_ac].nmbb027 ) RETURNING g_nmbb_d[l_ac].nmbb027_desc
                     DISPLAY BY NAME g_nmbb_d[l_ac].nmbb027_desc
                     NEXT FIELD CURRENT
                  END IF
            END IF
            CALL s_desc_get_person_desc(g_nmbb_d[l_ac].nmbb027 ) RETURNING g_nmbb_d[l_ac].nmbb027_desc
            DISPLAY BY NAME g_nmbb_d[l_ac].nmbb027_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb027
            #add-point:BEFORE FIELD nmbb027 name="input.b.page1.nmbb027"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbb027
            #add-point:ON CHANGE nmbb027 name="input.g.page1.nmbb027"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb028
            
            #add-point:AFTER FIELD nmbb028 name="input.a.page1.nmbb028"
            IF NOT cl_null(g_nmbb_d[l_ac].nmbb028) THEN 
               CALL anmt540_nmbb028_chk()
               IF NOT cl_null(g_errno) THEN 
                  IF p_cmd = 'a' THEN 
                     DISPLAY '' TO nmbb028
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_nmbb_d[l_ac].nmbb028
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_nmbb_d[l_ac].nmbb028 = ''
                  ELSE
                     DISPLAY '' TO nmbb028
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_nmbb_d[l_ac].nmbb028
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_nmbb_d[l_ac].nmbb028= g_nmbb_d_t.nmbb028 
                  END IF
                  DISPLAY g_nmbb_d[l_ac].nmbb028 TO nmbb028
                  NEXT FIELD nmbb028
               END IF
               #150803-00018#1 add ------
               #如果款別性質為10,20那就要把幣別鎖起來不可輸入(由帳戶帶出幣別)
               SELECT COUNT(*) INTO l_n
                 FROM ooia_t
                WHERE ooiaent = g_enterprise
                  AND ooia002 IN ('10','20')
                  AND ooia001 = g_nmbb_d[l_ac].nmbb028
               IF cl_null(l_n) THEN LET l_n = 0 END IF
               IF l_n > 0 THEN
                  CALL cl_set_comp_entry("nmbb004",FALSE)
               ELSE
                  CALL cl_set_comp_entry("nmbb004",TRUE)
               END IF
               #150803-00018#1 add end---
            END IF 
            CALL anmt540_ref_b()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb028
            #add-point:BEFORE FIELD nmbb028 name="input.b.page1.nmbb028"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbb028
            #add-point:ON CHANGE nmbb028 name="input.g.page1.nmbb028"
            CALL anmt540_nmbb001_entry()   #151222-00010#7
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb003
            #add-point:BEFORE FIELD nmbb003 name="input.b.page1.nmbb003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb003
            
            #add-point:AFTER FIELD nmbb003 name="input.a.page1.nmbb003"
            IF NOT cl_null(g_nmbb_d[l_ac].nmbb003) THEN 
               CALL anmt540_nmbb003_chk()
               IF NOT cl_null(g_errno) THEN 
                  IF l_cmd = 'a' THEN 
                     DISPLAY '' TO s_detail1[l_ac].nmbb003
                     DISPLAY '' TO s_detail1[l_ac].nmbb004
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_nmbb_d[l_ac].nmbb003
                     #160318-00005#28 by 07900 --add--str
                     LET g_errparam.replace[1] = 'anmi120'
                     LET g_errparam.replace[2] = cl_get_progname("anmi120",g_lang,"2")
                     LET g_errparam.exeprog ='anmi120'
                     #160318-00005#28 by 07900 --add--end
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_nmbb_d[l_ac].nmbb003 = ''
                     LET g_nmbb_d[l_ac].nmbb004 = ''
                  ELSE
                     DISPLAY '' TO s_detail1[l_ac].nmbb003
                     DISPLAY '' TO s_detail1[l_ac].nmbb004
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_nmbb_d[l_ac].nmbb003
                     #160318-00005#28 by 07900 --add--str
                     LET g_errparam.replace[1] = 'aooi100'
                     LET g_errparam.replace[2] = cl_get_progname("aooi100",g_lang,"2")
                     LET g_errparam.exeprog ='aooi100'
                     #160318-00005#28 by 07900 --add--end      
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_nmbb_d[l_ac].nmbb003 = g_nmbb_d_t.nmbb003
                     LET g_nmbb_d[l_ac].nmbb004 = g_nmbb_d_t.nmbb004
                  END IF 
                  DISPLAY g_nmbb_d[l_ac].nmbb003 TO s_detail1[l_ac].nmbb003
                  DISPLAY g_nmbb_d[l_ac].nmbb004 TO s_detail1[l_ac].nmbb004
                  NEXT FIELD nmbb003
               END IF 
               #150826 mark ------
               #SELECT ooab002 INTO l_ooab002 FROM ooab_t
               # WHERE ooabent = g_enterprise
               #   AND ooabsite= g_ooef001
               #   AND ooab001 = 'S-BAS-0010'
               #150826 mark end---
               CALL cl_get_para(g_enterprise,g_nmba_m.nmbacomp,'S-FIN-4004') RETURNING l_ooab002  #資金模組匯率來源 #150826
                                         #匯率參照表;帳套;           日期;               來源幣別
               CALL s_aooi160_get_exrate('2',g_glaald,g_nmba_m.nmbadocdt,g_nmbb_d[l_ac].nmbb004,
                                         #目的幣別;  交易金額;              匯類類型
                                         g_ooef016,0,l_ooab002)
                    RETURNING g_nmbb_d[l_ac].nmbb005
              IF cl_null(g_nmbb_d[l_ac].nmbb005) OR g_nmbb_d[l_ac].nmbb005 = 0 THEN
                 LET g_nmbb_d[l_ac].nmbb005 = 1   #抓取不到值給1
              END IF
             #CALL s_curr_round_ld('1',g_glaald,g_glaa001,g_nmbb_d[l_ac].nmbb005,3)      #150707-00001#7 #160822-00018#1 mark
              CALL s_curr_round_ld('1',g_glaald,g_nmbb_d[l_ac].nmbb004,g_nmbb_d[l_ac].nmbb005,3)         #160822-00018#1
                   RETURNING g_sub_success,g_errno,g_nmbb_d[l_ac].nmbb005                #150707-00001#7
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbb003
            #add-point:ON CHANGE nmbb003 name="input.g.page1.nmbb003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb030
            #add-point:BEFORE FIELD nmbb030 name="input.b.page1.nmbb030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb030
            
            #add-point:AFTER FIELD nmbb030 name="input.a.page1.nmbb030"
            #150610-00023#2--(s)
            IF NOT cl_null(g_nmbb_d[l_ac].nmbb030) THEN
              #IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_nmbb_d[l_ac].nmbb030 != g_nmbb_d_t.nmbb030 OR g_nmbb_d_t.nmbb030 IS NULL )) THEN  #161005-00003#4 mark
               IF g_nmbb_d[l_ac].nmbb030 != g_nmbb_d_o.nmbb030 OR cl_null(g_nmbb_d_o.nmbb030) THEN #161005-00003#4 add
                  LET l_cnt = 0
                  SELECT COUNT(nmbbseq) INTO l_cnt
                    FROM nmba_t,nmbb_t
                   WHERE nmbaent = nmbbent
                     AND nmbacomp = nmbbcomp
                     AND nmbadocno = nmbbdocno
                     AND nmbaent = g_enterprise
                     #AND nmba003 = 'anmt540' #150904-00006#1 
                     AND nmba003 = g_prog     #150904-00006#1 
                     AND nmbastus <> 'X'
                     AND nmbb030 = g_nmbb_d[l_ac].nmbb030           
                     
                  IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
                  IF l_cnt > 0 THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'anm-02916'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                    #LET g_nmbb_d[l_ac].nmbb030 = g_nmbb_d_t.nmbb030 #161005-00003#4 mark
                     LET g_nmbb_d[l_ac].nmbb030 = g_nmbb_d_o.nmbb030 #161005-00003#4 add
                     DISPLAY BY NAME g_nmbb_d[l_ac].nmbb030
                     NEXT FIELD CURRENT             
                  END IF  
                  #161104-00013#1 add s---
                  #检查anmt510票据资料是否存在
                  LET l_n = 0
                  SELECT count(*) INTO l_n
                    FROM nmbb_t,nmba_t
                   WHERE nmbaent = nmbbent AND nmbadocno = nmbbdocno
                     AND nmbacomp = nmbbcomp
                     AND nmbbent = g_enterprise
                     AND nmbb030 = g_nmbb_d[l_ac].nmbb030
                     AND nmbastus <> 'X'
                     AND nmba003 ='anmt510' 
                  IF l_n > 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'anm-03037'
                     LET g_errparam.extend = g_nmbb_d[l_ac].nmbb030
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_nmbb_d[l_ac].nmbb030 = g_nmbb_d_o.nmbb030
                     DISPLAY BY NAME g_nmbb_d[l_ac].nmbb030
                     NEXT FIELD nmbb030
                  END IF                     
                  #161104-00013#1 add e---                  
               END IF
            END IF
            #150610-00023#2--(e)
            LET g_nmbb_d_o.* = g_nmbb_d[l_ac].* #161005-00003#4 add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbb030
            #add-point:ON CHANGE nmbb030 name="input.g.page1.nmbb030"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb043
            #add-point:BEFORE FIELD nmbb043 name="input.b.page1.nmbb043"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb043
            
            #add-point:AFTER FIELD nmbb043 name="input.a.page1.nmbb043"
            IF NOT cl_null(g_nmbb_d[l_ac].nmbb043) THEN 
               CALL anmt540_nmbb043_chk(g_nmbb_d[l_ac].nmbb043)
               IF NOT cl_null(g_errno) THEN 
                  IF p_cmd = 'a' THEN 
                     DISPLAY '' TO nmbb043
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_nmbb_d[l_ac].nmbb043
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_nmbb_d[l_ac].nmbb043 = ''
                  ELSE
                     DISPLAY '' TO nmbb043
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_nmbb_d[l_ac].nmbb043
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_nmbb_d[l_ac].nmbb043 = g_nmbb_d_t.nmbb043
                  END IF 
                  DISPLAY g_nmbb_d[l_ac].nmbb043 TO nmbb043
                  NEXT FIELD nmbb043
               END IF 
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbb043
            #add-point:ON CHANGE nmbb043 name="input.g.page1.nmbb043"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb043_desc
            #add-point:BEFORE FIELD nmbb043_desc name="input.b.page1.nmbb043_desc"
            LET g_nmbb_d[l_ac].nmbb043_desc = g_nmbb_d[l_ac].nmbb043
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb043_desc
            
            #add-point:AFTER FIELD nmbb043_desc name="input.a.page1.nmbb043_desc"
            LET g_nmbb_d[l_ac].nmbb043 = g_nmbb_d[l_ac].nmbb043_desc
            IF NOT cl_null(g_nmbb_d[l_ac].nmbb043_desc) THEN 
               CALL anmt540_nmbb043_chk(g_nmbb_d[l_ac].nmbb043_desc)
               IF NOT cl_null(g_errno) THEN 
                  IF p_cmd = 'a' THEN 
                     DISPLAY '' TO s_detail1[l_ac].nmbb043_desc
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_nmbb_d[l_ac].nmbb043_desc
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_nmbb_d[l_ac].nmbb043 = ''
                     LET g_nmbb_d[l_ac].nmbb043_desc = ''
                  ELSE
                     DISPLAY '' TO s_detail1[l_ac].nmbb043_desc
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_nmbb_d[l_ac].nmbb043_desc
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_nmbb_d[l_ac].nmbb043= g_nmbb_d_t.nmbb043
                     LET g_nmbb_d[l_ac].nmbb043_desc = g_nmbb_d_t.nmbb043_desc
                  END IF 
                  DISPLAY g_nmbb_d[l_ac].nmbb043_desc TO nmbb043_desc
                  NEXT FIELD nmbb043_desc
               END IF 
            END IF
            CALL anmt540_ref_b()
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbb043_desc
            #add-point:ON CHANGE nmbb043_desc name="input.g.page1.nmbb043_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb073
            #add-point:BEFORE FIELD nmbb073 name="input.b.page1.nmbb073"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb073
            
            #add-point:AFTER FIELD nmbb073 name="input.a.page1.nmbb073"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbb073
            #add-point:ON CHANGE nmbb073 name="input.g.page1.nmbb073"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb031
            #add-point:BEFORE FIELD nmbb031 name="input.b.page1.nmbb031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb031
            
            #add-point:AFTER FIELD nmbb031 name="input.a.page1.nmbb031"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbb031
            #add-point:ON CHANGE nmbb031 name="input.g.page1.nmbb031"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb004
            #add-point:BEFORE FIELD nmbb004 name="input.b.page1.nmbb004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb004
            
            #add-point:AFTER FIELD nmbb004 name="input.a.page1.nmbb004"
            IF NOT cl_null(g_nmbb_d[l_ac].nmbb004) THEN 
               CALL anmt540_nmbb004_chk()
               IF NOT cl_null(g_errno) THEN 
                  IF p_cmd = 'a' THEN 
                     DISPLAY '' TO nmbb004
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_nmbb_d[l_ac].nmbb004
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_nmbb_d[l_ac].nmbb004 = ''
                  ELSE
                     DISPLAY '' TO nmbb004
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_nmbb_d[l_ac].nmbb004
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_nmbb_d[l_ac].nmbb004 = g_nmbb_d_t.nmbb004
                  END IF 
                  DISPLAY g_nmbb_d[l_ac].nmbb004 TO nmbb004
                  NEXT FIELD nmbb004
               END IF 
               #150826 mark ------
               #SELECT ooab002 INTO l_ooab002 FROM ooab_t
               # WHERE ooabent = g_enterprise
               #   AND ooabsite= g_ooef001
               #   AND ooab001 = 'S-BAS-0010'
               #150826 mark end---
               CALL cl_get_para(g_enterprise,g_nmba_m.nmbacomp,'S-FIN-4004') RETURNING l_ooab002  #資金模組匯率來源 #150826
                                         #匯率參照表;帳套;           日期;               來源幣別
               CALL s_aooi160_get_exrate('2',g_glaald,g_nmba_m.nmbadocdt,g_nmbb_d[l_ac].nmbb004,
                                         #目的幣別;  交易金額;              匯類類型
                                         g_ooef016,0,l_ooab002)
                    RETURNING g_nmbb_d[l_ac].nmbb005
              #CALL s_curr_round_ld('1',g_glaald,g_glaa001,g_nmbb_d[l_ac].nmbb005,3)    #150707-00001#7 #160822-00018#1 mark
               CALL s_curr_round_ld('1',g_glaald,g_nmbb_d[l_ac].nmbb004,g_nmbb_d[l_ac].nmbb005,3)       #160822-00018#1
                    RETURNING g_sub_success,g_errno,g_nmbb_d[l_ac].nmbb005              #150707-00001#7
               DISPLAY g_nmbb_d[l_ac].nmbb005 TO s_detail1[l_ac].nmbb005
                  
               IF NOT cl_null(g_nmbb_d[l_ac].nmbb006) THEN
                  LET g_nmbb_d[l_ac].nmbb007 = g_nmbb_d[l_ac].nmbb006 * g_nmbb_d[l_ac].nmbb005
                  CALL s_curr_round_ld('1',g_glaald,g_glaa001,g_nmbb_d[l_ac].nmbb007,2)          #150707-00001#7
                       RETURNING g_sub_success,g_errno,g_nmbb_d[l_ac].nmbb007                    #150707-00001#7
                  DISPLAY g_nmbb_d[l_ac].nmbb007 TO s_detail1[l_ac].nmbb007
                  #150922-00021#4 add ------
                  #修改幣別要重推重評後本幣金額(nmbb066)
                  LET g_nmbb_d[l_ac].nmbb066 = g_nmbb_d[l_ac].nmbb007
                  DISPLAY BY NAME g_nmbb_d[l_ac].nmbb066
                  #150922-00021#4 add end---
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbb004
            #add-point:ON CHANGE nmbb004 name="input.g.page1.nmbb004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb005
            #add-point:BEFORE FIELD nmbb005 name="input.b.page1.nmbb005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb005
            
            #add-point:AFTER FIELD nmbb005 name="input.a.page1.nmbb005"
            IF NOT cl_null(g_nmbb_d[l_ac].nmbb005) THEN                                        #150707-00001#7
              #CALL s_curr_round_ld('1',g_glaald,g_glaa001,g_nmbb_d[l_ac].nmbb005,3)           #150707-00001#7 #160822-00018#1 mark
               CALL s_curr_round_ld('1',g_glaald,g_nmbb_d[l_ac].nmbb004,g_nmbb_d[l_ac].nmbb005,3)              #160822-00018#1
                    RETURNING g_sub_success,g_errno,g_nmbb_d[l_ac].nmbb005                     #150707-00001#7
               IF NOT cl_null(g_nmbb_d[l_ac].nmbb006) THEN 
                  LET g_nmbb_d[l_ac].nmbb007 = g_nmbb_d[l_ac].nmbb006 * g_nmbb_d[l_ac].nmbb005
                  CALL s_curr_round_ld('1',g_glaald,g_glaa001,g_nmbb_d[l_ac].nmbb007,2)        #150707-00001#7
                       RETURNING g_sub_success,g_errno,g_nmbb_d[l_ac].nmbb007                  #150707-00001#7
                  DISPLAY g_nmbb_d[l_ac].nmbb007 TO s_detail1[l_ac].nmbb007
                  #150922-00021#4 add ------
                  #修改匯率要重推重評後本幣金額(nmbb066)
                  LET g_nmbb_d[l_ac].nmbb066 = g_nmbb_d[l_ac].nmbb007
                  DISPLAY BY NAME g_nmbb_d[l_ac].nmbb066
                  #150922-00021#4 add end---
               END IF
            END IF    #150707-00001#7
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbb005
            #add-point:ON CHANGE nmbb005 name="input.g.page1.nmbb005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb006
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_nmbb_d[l_ac].nmbb006,"0","0","","","azz-00079",1) THEN
               NEXT FIELD nmbb006
            END IF 
 
 
 
            #add-point:AFTER FIELD nmbb006 name="input.a.page1.nmbb006"
            IF NOT cl_null(g_nmbb_d[l_ac].nmbb006) THEN 
               CALL s_curr_round_ld('1',g_glaald,g_nmbb_d[l_ac].nmbb004,g_nmbb_d[l_ac].nmbb006,2) #150707-00001#7
                    RETURNING g_sub_success,g_errno,g_nmbb_d[l_ac].nmbb006                        #150707-00001#7
               LET g_nmbb_d[l_ac].nmbb007 = g_nmbb_d[l_ac].nmbb006 * g_nmbb_d[l_ac].nmbb005
               CALL s_curr_round_ld('1',g_glaald,g_glaa001,g_nmbb_d[l_ac].nmbb007,2)              #150707-00001#7
                    RETURNING g_sub_success,g_errno,g_nmbb_d[l_ac].nmbb007                        #150707-00001#7
               DISPLAY g_nmbb_d[l_ac].nmbb007 TO s_detail1[l_ac].nmbb007
               #150922-00021#4 add ------
               #修改原幣要重推重評後本幣金額(nmbb066)
               LET g_nmbb_d[l_ac].nmbb066 = g_nmbb_d[l_ac].nmbb007
               DISPLAY BY NAME g_nmbb_d[l_ac].nmbb066
               #150922-00021#4 add end---
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb006
            #add-point:BEFORE FIELD nmbb006 name="input.b.page1.nmbb006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbb006
            #add-point:ON CHANGE nmbb006 name="input.g.page1.nmbb006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb007
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_nmbb_d[l_ac].nmbb007,"0","0","","","azz-00079",1) THEN
               NEXT FIELD nmbb007
            END IF 
 
 
 
            #add-point:AFTER FIELD nmbb007 name="input.a.page1.nmbb007"
            #160912-00026#1--add--str--lujh
            IF NOT cl_null(g_nmbb_d[l_ac].nmbb007) THEN 
               CALL s_curr_round_ld('1',g_glaald,g_nmbb_d[l_ac].nmbb004,g_nmbb_d[l_ac].nmbb007,2) 
                    RETURNING g_sub_success,g_errno,g_nmbb_d[l_ac].nmbb007  
               IF g_nmbb_d[l_ac].nmbb006 = 0 THEN  #170105-00046#1 add 
                  LET g_nmbb_d[l_ac].nmbb006 = g_nmbb_d[l_ac].nmbb007 / g_nmbb_d[l_ac].nmbb005
                  CALL s_curr_round_ld('1',g_glaald,g_glaa001,g_nmbb_d[l_ac].nmbb006,2)              
                       RETURNING g_sub_success,g_errno,g_nmbb_d[l_ac].nmbb006                       
                  DISPLAY g_nmbb_d[l_ac].nmbb006 TO s_detail1[l_ac].nmbb006
               END IF  #170105-00046#1 add  

               LET g_nmbb_d[l_ac].nmbb066 = g_nmbb_d[l_ac].nmbb007
               DISPLAY BY NAME g_nmbb_d[l_ac].nmbb066
            END IF
            #160912-00026#1--add--end--lujh
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb007
            #add-point:BEFORE FIELD nmbb007 name="input.b.page1.nmbb007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbb007
            #add-point:ON CHANGE nmbb007 name="input.g.page1.nmbb007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb040
            #add-point:BEFORE FIELD nmbb040 name="input.b.page1.nmbb040"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb040
            
            #add-point:AFTER FIELD nmbb040 name="input.a.page1.nmbb040"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbb040
            #add-point:ON CHANGE nmbb040 name="input.g.page1.nmbb040"
            IF g_nmbb_d[l_ac].nmbb040 = 'Y' THEN 
               LET g_nmbb_d[l_ac].nmbb041 = ''
               CALL cl_set_comp_required('nmbb041',TRUE)
            ELSE
               LET g_nmbb_d[l_ac].nmbb041 = g_pmaal003
            END IF
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb041
            #add-point:BEFORE FIELD nmbb041 name="input.b.page1.nmbb041"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb041
            
            #add-point:AFTER FIELD nmbb041 name="input.a.page1.nmbb041"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbb041
            #add-point:ON CHANGE nmbb041 name="input.g.page1.nmbb041"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb044
            #add-point:BEFORE FIELD nmbb044 name="input.b.page1.nmbb044"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb044
            
            #add-point:AFTER FIELD nmbb044 name="input.a.page1.nmbb044"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbb044
            #add-point:ON CHANGE nmbb044 name="input.g.page1.nmbb044"
            IF NOT cl_null(g_nmbb_d[l_ac].nmbb044) THEN 
               CALL cl_set_comp_required('nmbb045',TRUE)
               CALL cl_set_comp_entry("nmbb045",TRUE)
            END IF
            IF cl_null(g_nmbb_d[l_ac].nmbb044) THEN 
               LET g_nmbb_d[l_ac].nmbb045 = ''
               CALL cl_set_comp_entry("nmbb045",FALSE)
            END IF 
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb002
            
            #add-point:AFTER FIELD nmbb002 name="input.a.page1.nmbb002"
             IF NOT cl_null(g_nmbb_d[l_ac].nmbb002) THEN 
               CALL anmt540_nmbb002_chk()
               IF NOT cl_null(g_errno) THEN
                  DISPLAY '' TO nmbb004
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_nmbb_d[l_ac].nmbb002
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_nmbb_d[l_ac].nmbb002 = g_nmbb_d_t.nmbb002
                  #150807-00007#1 add ------
                  LET g_nmbb_d[l_ac].nmbb010 = ''
                  DISPLAY g_nmbb_d[l_ac].nmbb010 TO s_detail1[l_ac].nmbb010
                  #150807-00007#1 add end---
                  CALL anmt540_nmbb002_desc()
                  NEXT FIELD CURRENT
#               ELSE   #160530-00005#4 mark
#                  CALL anmt540_nmbb002_desc()   #160530-00005#4 mark            
               END IF 
            END IF
            CALL anmt540_nmbb002_desc()   #160530-00005#4 add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb002
            #add-point:BEFORE FIELD nmbb002 name="input.b.page1.nmbb002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbb002
            #add-point:ON CHANGE nmbb002 name="input.g.page1.nmbb002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb002_desc
            #add-point:BEFORE FIELD nmbb002_desc name="input.b.page1.nmbb002_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb002_desc
            
            #add-point:AFTER FIELD nmbb002_desc name="input.a.page1.nmbb002_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbb002_desc
            #add-point:ON CHANGE nmbb002_desc name="input.g.page1.nmbb002_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb010
            
            #add-point:AFTER FIELD nmbb010 name="input.a.page1.nmbb010"
            #150807-00007#1 add ------
            IF NOT cl_null(g_nmbb_d[l_ac].nmbb010) THEN
               CALL anmt540_nmbb010_chk()
               IF NOT cl_null(g_errno) THEN
                  IF l_cmd = 'a' THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_nmbb_d[l_ac].nmbb010
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_nmbb_d[l_ac].nmbb010 = ''
                     LET g_nmbb_d[l_ac].nmbb010_desc = ''
                  ELSE
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_nmbb_d[l_ac].nmbb010
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_nmbb_d[l_ac].nmbb010 = g_nmbb_d_t.nmbb010
                     LET g_nmbb_d[l_ac].nmbb010_desc = g_nmbb_d_t.nmbb010_desc
                  END IF 
                  DISPLAY BY NAME g_nmbb_d[l_ac].nmbb010,g_nmbb_d[l_ac].nmbb010_desc
                  NEXT FIELD nmbb010
               END IF
            END IF
            LET g_nmbb_d[l_ac].nmbb010_desc = s_desc_get_nmail004_desc(g_glaa005,g_nmbb_d[l_ac].nmbb010)
            DISPLAY BY NAME g_nmbb_d[l_ac].nmbb010_desc
            #150807-00007#1 add end---
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb010
            #add-point:BEFORE FIELD nmbb010 name="input.b.page1.nmbb010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbb010
            #add-point:ON CHANGE nmbb010 name="input.g.page1.nmbb010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb045
            #add-point:BEFORE FIELD nmbb045 name="input.b.page1.nmbb045"
            IF NOT cl_null(g_nmbb_d[l_ac].nmbb044) THEN 
               CALL cl_set_comp_required('nmbb045',TRUE)
               CALL cl_set_comp_entry("nmbb045",TRUE)
            END IF
            IF cl_null(g_nmbb_d[l_ac].nmbb044) THEN 
               LET g_nmbb_d[l_ac].nmbb045 = ''
               CALL cl_set_comp_entry("nmbb045",FALSE)
            END IF 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb045
            
            #add-point:AFTER FIELD nmbb045 name="input.a.page1.nmbb045"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbb045
            #add-point:ON CHANGE nmbb045 name="input.g.page1.nmbb045"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb029
            #add-point:BEFORE FIELD nmbb029 name="input.b.page1.nmbb029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb029
            
            #add-point:AFTER FIELD nmbb029 name="input.a.page1.nmbb029"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbb029
            #add-point:ON CHANGE nmbb029 name="input.g.page1.nmbb029"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb039
            #add-point:BEFORE FIELD nmbb039 name="input.b.page1.nmbb039"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb039
            
            #add-point:AFTER FIELD nmbb039 name="input.a.page1.nmbb039"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbb039
            #add-point:ON CHANGE nmbb039 name="input.g.page1.nmbb039"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb001
            #add-point:BEFORE FIELD nmbb001 name="input.b.page1.nmbb001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb001
            
            #add-point:AFTER FIELD nmbb001 name="input.a.page1.nmbb001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbb001
            #add-point:ON CHANGE nmbb001 name="input.g.page1.nmbb001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb011
            #add-point:BEFORE FIELD nmbb011 name="input.b.page1.nmbb011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb011
            
            #add-point:AFTER FIELD nmbb011 name="input.a.page1.nmbb011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbb011
            #add-point:ON CHANGE nmbb011 name="input.g.page1.nmbb011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb012
            #add-point:BEFORE FIELD nmbb012 name="input.b.page1.nmbb012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb012
            
            #add-point:AFTER FIELD nmbb012 name="input.a.page1.nmbb012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbb012
            #add-point:ON CHANGE nmbb012 name="input.g.page1.nmbb012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb013
            #add-point:BEFORE FIELD nmbb013 name="input.b.page1.nmbb013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb013
            
            #add-point:AFTER FIELD nmbb013 name="input.a.page1.nmbb013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbb013
            #add-point:ON CHANGE nmbb013 name="input.g.page1.nmbb013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb014
            #add-point:BEFORE FIELD nmbb014 name="input.b.page1.nmbb014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb014
            
            #add-point:AFTER FIELD nmbb014 name="input.a.page1.nmbb014"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbb014
            #add-point:ON CHANGE nmbb014 name="input.g.page1.nmbb014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb015
            #add-point:BEFORE FIELD nmbb015 name="input.b.page1.nmbb015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb015
            
            #add-point:AFTER FIELD nmbb015 name="input.a.page1.nmbb015"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbb015
            #add-point:ON CHANGE nmbb015 name="input.g.page1.nmbb015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb016
            #add-point:BEFORE FIELD nmbb016 name="input.b.page1.nmbb016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb016
            
            #add-point:AFTER FIELD nmbb016 name="input.a.page1.nmbb016"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbb016
            #add-point:ON CHANGE nmbb016 name="input.g.page1.nmbb016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb017
            #add-point:BEFORE FIELD nmbb017 name="input.b.page1.nmbb017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb017
            
            #add-point:AFTER FIELD nmbb017 name="input.a.page1.nmbb017"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbb017
            #add-point:ON CHANGE nmbb017 name="input.g.page1.nmbb017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb018
            #add-point:BEFORE FIELD nmbb018 name="input.b.page1.nmbb018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb018
            
            #add-point:AFTER FIELD nmbb018 name="input.a.page1.nmbb018"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbb018
            #add-point:ON CHANGE nmbb018 name="input.g.page1.nmbb018"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb019
            #add-point:BEFORE FIELD nmbb019 name="input.b.page1.nmbb019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb019
            
            #add-point:AFTER FIELD nmbb019 name="input.a.page1.nmbb019"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbb019
            #add-point:ON CHANGE nmbb019 name="input.g.page1.nmbb019"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb020
            #add-point:BEFORE FIELD nmbb020 name="input.b.page1.nmbb020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb020
            
            #add-point:AFTER FIELD nmbb020 name="input.a.page1.nmbb020"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbb020
            #add-point:ON CHANGE nmbb020 name="input.g.page1.nmbb020"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb021
            #add-point:BEFORE FIELD nmbb021 name="input.b.page1.nmbb021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb021
            
            #add-point:AFTER FIELD nmbb021 name="input.a.page1.nmbb021"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbb021
            #add-point:ON CHANGE nmbb021 name="input.g.page1.nmbb021"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb022
            #add-point:BEFORE FIELD nmbb022 name="input.b.page1.nmbb022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb022
            
            #add-point:AFTER FIELD nmbb022 name="input.a.page1.nmbb022"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbb022
            #add-point:ON CHANGE nmbb022 name="input.g.page1.nmbb022"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb023
            #add-point:BEFORE FIELD nmbb023 name="input.b.page1.nmbb023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb023
            
            #add-point:AFTER FIELD nmbb023 name="input.a.page1.nmbb023"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbb023
            #add-point:ON CHANGE nmbb023 name="input.g.page1.nmbb023"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb024
            #add-point:BEFORE FIELD nmbb024 name="input.b.page1.nmbb024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb024
            
            #add-point:AFTER FIELD nmbb024 name="input.a.page1.nmbb024"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbb024
            #add-point:ON CHANGE nmbb024 name="input.g.page1.nmbb024"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb053
            #add-point:BEFORE FIELD nmbb053 name="input.b.page1.nmbb053"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb053
            
            #add-point:AFTER FIELD nmbb053 name="input.a.page1.nmbb053"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbb053
            #add-point:ON CHANGE nmbb053 name="input.g.page1.nmbb053"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb054
            #add-point:BEFORE FIELD nmbb054 name="input.b.page1.nmbb054"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb054
            
            #add-point:AFTER FIELD nmbb054 name="input.a.page1.nmbb054"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbb054
            #add-point:ON CHANGE nmbb054 name="input.g.page1.nmbb054"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb056
            #add-point:BEFORE FIELD nmbb056 name="input.b.page1.nmbb056"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb056
            
            #add-point:AFTER FIELD nmbb056 name="input.a.page1.nmbb056"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbb056
            #add-point:ON CHANGE nmbb056 name="input.g.page1.nmbb056"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb066
            #add-point:BEFORE FIELD nmbb066 name="input.b.page1.nmbb066"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb066
            
            #add-point:AFTER FIELD nmbb066 name="input.a.page1.nmbb066"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbb066
            #add-point:ON CHANGE nmbb066 name="input.g.page1.nmbb066"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb067
            #add-point:BEFORE FIELD nmbb067 name="input.b.page1.nmbb067"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb067
            
            #add-point:AFTER FIELD nmbb067 name="input.a.page1.nmbb067"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbb067
            #add-point:ON CHANGE nmbb067 name="input.g.page1.nmbb067"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb068
            #add-point:BEFORE FIELD nmbb068 name="input.b.page1.nmbb068"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb068
            
            #add-point:AFTER FIELD nmbb068 name="input.a.page1.nmbb068"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbb068
            #add-point:ON CHANGE nmbb068 name="input.g.page1.nmbb068"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb042
            #add-point:BEFORE FIELD nmbb042 name="input.b.page1.nmbb042"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb042
            
            #add-point:AFTER FIELD nmbb042 name="input.a.page1.nmbb042"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbb042
            #add-point:ON CHANGE nmbb042 name="input.g.page1.nmbb042"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb069
            #add-point:BEFORE FIELD nmbb069 name="input.b.page1.nmbb069"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb069
            
            #add-point:AFTER FIELD nmbb069 name="input.a.page1.nmbb069"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbb069
            #add-point:ON CHANGE nmbb069 name="input.g.page1.nmbb069"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb025
            #add-point:BEFORE FIELD nmbb025 name="input.b.page1.nmbb025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb025
            
            #add-point:AFTER FIELD nmbb025 name="input.a.page1.nmbb025"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbb025
            #add-point:ON CHANGE nmbb025 name="input.g.page1.nmbb025"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.nmbbseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbbseq
            #add-point:ON ACTION controlp INFIELD nmbbseq name="input.c.page1.nmbbseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbborga
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbborga
            #add-point:ON ACTION controlp INFIELD nmbborga name="input.c.page1.nmbborga"
            #來源組織
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_nmbb_d[l_ac].nmbborga
            CALL s_fin_get_wc_str(g_site_wc) RETURNING l_origin_str  #160912-00024#1
            LET g_qryparam.where = " ooef001 IN ",l_origin_str," AND  ooef017 ='",g_nmba_m.nmbacomp,"'" #160912-00024#1 add
            #LET g_qryparam.where = " ooef001 IN ",g_site_wc #150707-00001#7 #160912-00024#1 mark
            LET g_qryparam.where = g_qryparam.where," AND ooef201 = 'Y'"  #161021-00050#10
            #CALL q_ooed004_8()                              #150707-00001#7 mark
            CALL q_ooef001()                                 #150707-00001#7
            LET g_nmbb_d[l_ac].nmbborga = g_qryparam.return1
            DISPLAY g_nmbb_d[l_ac].nmbborga TO nmbborga
            CALL anmt540_nmbborga_desc()
            NEXT FIELD nmbborga
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbb026
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb026
            #add-point:ON ACTION controlp INFIELD nmbb026 name="input.c.page1.nmbb026"
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_nmbb_d[l_ac].nmbb026
            #CALL q_pmaa001()       #160913-00017#6  mark
            #CALL q_pmaa001_25()     #160913-00017#6  add    #161228-00019#1 mark lujh
            #161228-00019#1--add--str--lujh
            LET g_qryparam.arg1 = g_nmba_m.nmbacomp
            CALL q_pmab001()    
            #161228-00019#1--add--end--lujh
            LET g_nmbb_d[l_ac].nmbb026 = g_qryparam.return1
            DISPLAY g_nmbb_d[l_ac].nmbb026 TO nmbb026
            CALL anmt540_ref_b()
            NEXT FIELD nmbb026
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbb027
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb027
            #add-point:ON ACTION controlp INFIELD nmbb027 name="input.c.page1.nmbb027"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_nmbb_d[l_ac].nmbb027
            CALL q_ooag001()
            LET g_nmbb_d[l_ac].nmbb027 = g_qryparam.return1
            CALL s_desc_get_person_desc(g_nmbb_d[l_ac].nmbb027) RETURNING g_nmbb_d[l_ac].nmbb027_desc
            DISPLAY BY NAME g_nmbb_d[l_ac].nmbb027,g_nmbb_d[l_ac].nmbb027_desc
            NEXT FIELD nmbb027
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbb028
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb028
            #add-point:ON ACTION controlp INFIELD nmbb028 name="input.c.page1.nmbb028"
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_nmbb_d[l_ac].nmbb028
            #LET g_qryparam.where = " ooia002 IN ('10','20','30','40','50')"
            CALL s_money_where(g_nmbb_d[l_ac].nmbborga) RETURNING l_str
            LET g_qryparam.where = l_str," AND ooia002 IN ('10','20','30','40','50')"
            CALL q_ooia001()
            LET g_nmbb_d[l_ac].nmbb028 = g_qryparam.return1
            LET g_nmbb028 = g_nmbb_d[l_ac].nmbb028
            CALL anmt540_ref_b()
            NEXT FIELD nmbb028
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbb003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb003
            #add-point:ON ACTION controlp INFIELD nmbb003 name="input.c.page1.nmbb003"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_nmbb_d[l_ac].nmbb003             #給予default值
            LET g_qryparam.where = " nmaa002 IN (select ooef001 FROM ooef_t WHERE ooefent = '",g_enterprise,"'",
                                   "              AND ooef017 = '",g_nmba_m.nmbacomp,"')"
            #給予arg
            #160122-00001#27--add---str
            LET g_qryparam.where = g_qryparam.where CLIPPED," AND nmas002 IN (",g_sql_bank,")"
            #160122-00001#27--add---end

            CALL q_nmas_01()                                #呼叫開窗

            LET g_nmbb_d[l_ac].nmbb003 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_nmbb_d[l_ac].nmbb003 TO nmbb003              #顯示到畫面上
            LET g_qryparam.where = " "             #160122-00001#27

            NEXT FIELD nmbb003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbb030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb030
            #add-point:ON ACTION controlp INFIELD nmbb030 name="input.c.page1.nmbb030"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbb043
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb043
            #add-point:ON ACTION controlp INFIELD nmbb043 name="input.c.page1.nmbb043"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_nmbb_d[l_ac].nmbb043             #給予default值
            LET g_qryparam.where = " nmab008 = '",g_ooef006,"'"
            #給予arg

            CALL q_nmab001()                                #呼叫開窗

            LET g_nmbb_d[l_ac].nmbb043 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_nmbb_d[l_ac].nmbb043 TO nmbb043              #顯示到畫面上

            NEXT FIELD nmbb043                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbb043_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb043_desc
            #add-point:ON ACTION controlp INFIELD nmbb043_desc name="input.c.page1.nmbb043_desc"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_nmbb_d[l_ac].nmbb043_desc             #給予default值
            LET g_qryparam.where = " nmab008 = '",g_ooef006,"'"
            #給予arg

            CALL q_nmab001()                                #呼叫開窗

            LET g_nmbb_d[l_ac].nmbb043 = g_qryparam.return1              #將開窗取得的值回傳到變數
            CALL anmt540_ref_b()
            DISPLAY g_nmbb_d[l_ac].nmbb043_desc TO nmbb043_desc              #顯示到畫面上

            NEXT FIELD nmbb043_desc                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbb073
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb073
            #add-point:ON ACTION controlp INFIELD nmbb073 name="input.c.page1.nmbb073"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbb031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb031
            #add-point:ON ACTION controlp INFIELD nmbb031 name="input.c.page1.nmbb031"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbb004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb004
            #add-point:ON ACTION controlp INFIELD nmbb004 name="input.c.page1.nmbb004"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_nmbb_d[l_ac].nmbb004             #給予default值

            #給予arg

            CALL q_aooi001_1()                                #呼叫開窗

            LET g_nmbb_d[l_ac].nmbb004 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_nmbb_d[l_ac].nmbb004 TO nmbb004              #顯示到畫面上

            NEXT FIELD nmbb004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbb005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb005
            #add-point:ON ACTION controlp INFIELD nmbb005 name="input.c.page1.nmbb005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbb006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb006
            #add-point:ON ACTION controlp INFIELD nmbb006 name="input.c.page1.nmbb006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbb007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb007
            #add-point:ON ACTION controlp INFIELD nmbb007 name="input.c.page1.nmbb007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbb040
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb040
            #add-point:ON ACTION controlp INFIELD nmbb040 name="input.c.page1.nmbb040"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbb041
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb041
            #add-point:ON ACTION controlp INFIELD nmbb041 name="input.c.page1.nmbb041"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbb044
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb044
            #add-point:ON ACTION controlp INFIELD nmbb044 name="input.c.page1.nmbb044"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbb002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb002
            #add-point:ON ACTION controlp INFIELD nmbb002 name="input.c.page1.nmbb002"
            #此段落由子樣板a07產生
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_nmbb_d[l_ac].nmbb002
            LET g_qryparam.where = " nmaj002 = '1'"
            CALL q_nmaj001()
            LET g_nmbb_d[l_ac].nmbb002 = g_qryparam.return1
            CALL anmt540_nmbb002_desc()
            DISPLAY g_nmbb_d[l_ac].nmbb002 TO nmbb002
            #抓取現金變動碼
            CALL anmt540_nmbb002_chk()  #150807-00007#1
            LET g_nmbb_d[l_ac].nmbb010_desc = s_desc_get_nmail004_desc(g_glaa005,g_nmbb_d[l_ac].nmbb010)
            DISPLAY BY NAME g_nmbb_d[l_ac].nmbb010_desc
            NEXT FIELD nmbb002
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbb002_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb002_desc
            #add-point:ON ACTION controlp INFIELD nmbb002_desc name="input.c.page1.nmbb002_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbb010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb010
            #add-point:ON ACTION controlp INFIELD nmbb010 name="input.c.page1.nmbb010"
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_nmbb_d[l_ac].nmbb010
            LET g_qryparam.where = " nmai001 = '",g_glaa005,"'"
            CALL q_nmai002()
            LET g_nmbb_d[l_ac].nmbb010 = g_qryparam.return1
            LET g_nmbb_d[l_ac].nmbb010_desc = s_desc_get_nmail004_desc(g_glaa005,g_nmbb_d[l_ac].nmbb010)
            DISPLAY BY NAME g_nmbb_d[l_ac].nmbb010,g_nmbb_d[l_ac].nmbb010_desc
            NEXT FIELD nmbb010
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbb045
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb045
            #add-point:ON ACTION controlp INFIELD nmbb045 name="input.c.page1.nmbb045"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbb029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb029
            #add-point:ON ACTION controlp INFIELD nmbb029 name="input.c.page1.nmbb029"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbb039
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb039
            #add-point:ON ACTION controlp INFIELD nmbb039 name="input.c.page1.nmbb039"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbb001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb001
            #add-point:ON ACTION controlp INFIELD nmbb001 name="input.c.page1.nmbb001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbb011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb011
            #add-point:ON ACTION controlp INFIELD nmbb011 name="input.c.page1.nmbb011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbb012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb012
            #add-point:ON ACTION controlp INFIELD nmbb012 name="input.c.page1.nmbb012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbb013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb013
            #add-point:ON ACTION controlp INFIELD nmbb013 name="input.c.page1.nmbb013"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbb014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb014
            #add-point:ON ACTION controlp INFIELD nmbb014 name="input.c.page1.nmbb014"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbb015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb015
            #add-point:ON ACTION controlp INFIELD nmbb015 name="input.c.page1.nmbb015"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbb016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb016
            #add-point:ON ACTION controlp INFIELD nmbb016 name="input.c.page1.nmbb016"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbb017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb017
            #add-point:ON ACTION controlp INFIELD nmbb017 name="input.c.page1.nmbb017"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbb018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb018
            #add-point:ON ACTION controlp INFIELD nmbb018 name="input.c.page1.nmbb018"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbb019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb019
            #add-point:ON ACTION controlp INFIELD nmbb019 name="input.c.page1.nmbb019"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbb020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb020
            #add-point:ON ACTION controlp INFIELD nmbb020 name="input.c.page1.nmbb020"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbb021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb021
            #add-point:ON ACTION controlp INFIELD nmbb021 name="input.c.page1.nmbb021"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbb022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb022
            #add-point:ON ACTION controlp INFIELD nmbb022 name="input.c.page1.nmbb022"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbb023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb023
            #add-point:ON ACTION controlp INFIELD nmbb023 name="input.c.page1.nmbb023"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbb024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb024
            #add-point:ON ACTION controlp INFIELD nmbb024 name="input.c.page1.nmbb024"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbb053
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb053
            #add-point:ON ACTION controlp INFIELD nmbb053 name="input.c.page1.nmbb053"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbb054
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb054
            #add-point:ON ACTION controlp INFIELD nmbb054 name="input.c.page1.nmbb054"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbb056
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb056
            #add-point:ON ACTION controlp INFIELD nmbb056 name="input.c.page1.nmbb056"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbb066
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb066
            #add-point:ON ACTION controlp INFIELD nmbb066 name="input.c.page1.nmbb066"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbb067
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb067
            #add-point:ON ACTION controlp INFIELD nmbb067 name="input.c.page1.nmbb067"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbb068
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb068
            #add-point:ON ACTION controlp INFIELD nmbb068 name="input.c.page1.nmbb068"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbb042
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb042
            #add-point:ON ACTION controlp INFIELD nmbb042 name="input.c.page1.nmbb042"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbb069
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb069
            #add-point:ON ACTION controlp INFIELD nmbb069 name="input.c.page1.nmbb069"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbb025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb025
            #add-point:ON ACTION controlp INFIELD nmbb025 name="input.c.page1.nmbb025"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_nmbb_d[l_ac].* = g_nmbb_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE anmt540_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_nmbb_d[l_ac].nmbbseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_nmbb_d[l_ac].* = g_nmbb_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               CALL anmt540_ref_amt()
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL anmt540_nmbb_t_mask_restore('restore_mask_o')
      
               UPDATE nmbb_t SET (nmbbcomp,nmbbdocno,nmbbseq,nmbborga,nmbb026,nmbb027,nmbb028,nmbb003, 
                   nmbb030,nmbb043,nmbb073,nmbb031,nmbb004,nmbb005,nmbb006,nmbb007,nmbb040,nmbb041,nmbb044, 
                   nmbb002,nmbb010,nmbblegl,nmbb045,nmbb029,nmbb039,nmbb001,nmbb011,nmbb012,nmbb013, 
                   nmbb014,nmbb015,nmbb016,nmbb017,nmbb018,nmbb019,nmbb020,nmbb021,nmbb022,nmbb023,nmbb024, 
                   nmbb053,nmbb054,nmbb008,nmbb009,nmbb056,nmbb057,nmbb058,nmbb059,nmbb060,nmbb061,nmbb062, 
                   nmbb066,nmbb067,nmbb068,nmbb042,nmbb069,nmbb025) = (g_nmba_m.nmbacomp,g_nmba_m.nmbadocno, 
                   g_nmbb_d[l_ac].nmbbseq,g_nmbb_d[l_ac].nmbborga,g_nmbb_d[l_ac].nmbb026,g_nmbb_d[l_ac].nmbb027, 
                   g_nmbb_d[l_ac].nmbb028,g_nmbb_d[l_ac].nmbb003,g_nmbb_d[l_ac].nmbb030,g_nmbb_d[l_ac].nmbb043, 
                   g_nmbb_d[l_ac].nmbb073,g_nmbb_d[l_ac].nmbb031,g_nmbb_d[l_ac].nmbb004,g_nmbb_d[l_ac].nmbb005, 
                   g_nmbb_d[l_ac].nmbb006,g_nmbb_d[l_ac].nmbb007,g_nmbb_d[l_ac].nmbb040,g_nmbb_d[l_ac].nmbb041, 
                   g_nmbb_d[l_ac].nmbb044,g_nmbb_d[l_ac].nmbb002,g_nmbb_d[l_ac].nmbb010,g_nmbb_d[l_ac].nmbblegl, 
                   g_nmbb_d[l_ac].nmbb045,g_nmbb_d[l_ac].nmbb029,g_nmbb_d[l_ac].nmbb039,g_nmbb_d[l_ac].nmbb001, 
                   g_nmbb_d[l_ac].nmbb011,g_nmbb_d[l_ac].nmbb012,g_nmbb_d[l_ac].nmbb013,g_nmbb_d[l_ac].nmbb014, 
                   g_nmbb_d[l_ac].nmbb015,g_nmbb_d[l_ac].nmbb016,g_nmbb_d[l_ac].nmbb017,g_nmbb_d[l_ac].nmbb018, 
                   g_nmbb_d[l_ac].nmbb019,g_nmbb_d[l_ac].nmbb020,g_nmbb_d[l_ac].nmbb021,g_nmbb_d[l_ac].nmbb022, 
                   g_nmbb_d[l_ac].nmbb023,g_nmbb_d[l_ac].nmbb024,g_nmbb_d[l_ac].nmbb053,g_nmbb_d[l_ac].nmbb054, 
                   g_nmbb_d[l_ac].nmbb008,g_nmbb_d[l_ac].nmbb009,g_nmbb_d[l_ac].nmbb056,g_nmbb_d[l_ac].nmbb057, 
                   g_nmbb_d[l_ac].nmbb058,g_nmbb_d[l_ac].nmbb059,g_nmbb_d[l_ac].nmbb060,g_nmbb_d[l_ac].nmbb061, 
                   g_nmbb_d[l_ac].nmbb062,g_nmbb_d[l_ac].nmbb066,g_nmbb_d[l_ac].nmbb067,g_nmbb_d[l_ac].nmbb068, 
                   g_nmbb_d[l_ac].nmbb042,g_nmbb_d[l_ac].nmbb069,g_nmbb_d[l_ac].nmbb025)
                WHERE nmbbent = g_enterprise AND nmbbcomp = g_nmba_m.nmbacomp 
                  AND nmbbdocno = g_nmba_m.nmbadocno 
 
                  AND nmbbseq = g_nmbb_d_t.nmbbseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_nmbb_d[l_ac].* = g_nmbb_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "nmbb_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_nmbb_d[l_ac].* = g_nmbb_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "nmbb_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_nmba_m.nmbacomp
               LET gs_keys_bak[1] = g_nmbacomp_t
               LET gs_keys[2] = g_nmba_m.nmbadocno
               LET gs_keys_bak[2] = g_nmbadocno_t
               LET gs_keys[3] = g_nmbb_d[g_detail_idx].nmbbseq
               LET gs_keys_bak[3] = g_nmbb_d_t.nmbbseq
               CALL anmt540_update_b('nmbb_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL anmt540_nmbb_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_nmbb_d[g_detail_idx].nmbbseq = g_nmbb_d_t.nmbbseq 
 
                  ) THEN
                  LET gs_keys[01] = g_nmba_m.nmbacomp
                  LET gs_keys[gs_keys.getLength()+1] = g_nmba_m.nmbadocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_nmbb_d_t.nmbbseq
 
                  CALL anmt540_key_update_b(gs_keys,'nmbb_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_nmba_m),util.JSON.stringify(g_nmbb_d_t)
               LET g_log2 = util.JSON.stringify(g_nmba_m),util.JSON.stringify(g_nmbb_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               CALL anmt540_ins_glbc() RETURNING l_success
               IF l_success = FALSE THEN
                  CALL s_transaction_end('N','0')                    
               END IF
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            #151222-00010#7---add---str
            IF g_nmbb_d[l_ac].nmbb029 = '10' OR g_nmbb_d[l_ac].nmbb029 = '20' THEN
               LET l_n = 0
               SELECT COUNT(*) INTO l_n FROM glbc_t 
                WHERE glbcent = g_enterprise AND glbcdocno = g_nmba_m.nmbadocno
                  AND glbcseq = g_nmbb_d[l_ac].nmbbseq
               IF l_n = 0 THEN
                  CALL anmt540_ins_glbc() RETURNING l_success
               END IF
            END IF
            #151222-00010#7---add---end
            #end add-point
            CALL anmt540_unlock_b("nmbb_t","'1'")
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
               LET g_nmbb_d[li_reproduce_target].* = g_nmbb_d[li_reproduce].*
 
               LET g_nmbb_d[li_reproduce_target].nmbbseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_nmbb_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_nmbb_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
      INPUT ARRAY g_nmbb3_d FROM s_detail3.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_2)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body3.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_nmbb3_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL anmt540_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_nmbb3_d.getLength()
            #add-point:資料輸入前 name="input.body3.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_nmbb3_d[l_ac].* TO NULL 
            INITIALIZE g_nmbb3_d_t.* TO NULL 
            INITIALIZE g_nmbb3_d_o.* TO NULL 
            #公用欄位給值(單身2)
            
            #自定義預設值(單身2)
                  LET g_nmbb3_d[l_ac].nmbu003 = "3"
      LET g_nmbb3_d[l_ac].nmbu004 = "2"
 
            #add-point:modify段before備份 name="input.body3.insert.before_bak"
            
            #end add-point
            LET g_nmbb3_d_t.* = g_nmbb3_d[l_ac].*     #新輸入資料
            LET g_nmbb3_d_o.* = g_nmbb3_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL anmt540_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body3.insert.after_set_entry_b"
            
            #end add-point
            CALL anmt540_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_nmbb3_d[li_reproduce_target].* = g_nmbb3_d[li_reproduce].*
 
               LET g_nmbb3_d[li_reproduce_target].nmbuseq = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body3.before_insert"
            IF l_cmd = 'a' THEN 
               IF cl_null(g_nmbb3_d[g_detail_idx].nmbuseq) THEN 
                  SELECT MAX(nmbuseq) INTO g_nmbb3_d[g_detail_idx].nmbuseq
                    FROM nmbu_t
                   WHERE nmbuent = g_enterprise
                     AND nmbucomp = g_nmba_m.nmbacomp
                     AND nmbudocno = g_nmba_m.nmbadocno
                     
                  IF cl_null(g_nmbb3_d[g_detail_idx].nmbuseq) THEN 
                     LET g_nmbb3_d[g_detail_idx].nmbuseq = 1
                  ELSE
                     LET g_nmbb3_d[g_detail_idx].nmbuseq = g_nmbb3_d[g_detail_idx].nmbuseq + 1
                  END IF
               END IF
            END IF
            #end add-point  
 
         BEFORE ROW     
            #add-point:modify段before row2 name="input.body3.before_row2"
            
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
            OPEN anmt540_cl USING g_enterprise,g_nmba_m.nmbacomp,g_nmba_m.nmbadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN anmt540_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE anmt540_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_nmbb3_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_nmbb3_d[l_ac].nmbuseq IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_nmbb3_d_t.* = g_nmbb3_d[l_ac].*  #BACKUP
               LET g_nmbb3_d_o.* = g_nmbb3_d[l_ac].*  #BACKUP
               CALL anmt540_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body3.after_set_entry_b"
               
               #end add-point  
               CALL anmt540_set_no_entry_b(l_cmd)
               IF NOT anmt540_lock_b("nmbu_t","'2'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH anmt540_bcl2 INTO g_nmbb3_d[l_ac].nmbuseq,g_nmbb3_d[l_ac].nmbu001,g_nmbb3_d[l_ac].nmbuorga, 
                      g_nmbb3_d[l_ac].nmbu003,g_nmbb3_d[l_ac].nmbu004,g_nmbb3_d[l_ac].nmbu005,g_nmbb3_d[l_ac].nmbu006, 
                      g_nmbb3_d[l_ac].nmbu007,g_nmbb3_d[l_ac].nmbu002
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_nmbb3_d_mask_o[l_ac].* =  g_nmbb3_d[l_ac].*
                  CALL anmt540_nmbu_t_mask()
                  LET g_nmbb3_d_mask_n[l_ac].* =  g_nmbb3_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL anmt540_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body3.before_row"
            CALL anmt540_ref_b_3()
            CALL anmt540_nmbuorga_desc()
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
            #其他table進行lock
            
 
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身AFTER DELETE (=d) name="input.body3.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body3.b_delete_ask"
               
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
               
               #add-point:單身2刪除前 name="input.body3.b_delete"
               
               #end add-point    
                  
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_nmba_m.nmbacomp
               LET gs_keys[gs_keys.getLength()+1] = g_nmba_m.nmbadocno
               LET gs_keys[gs_keys.getLength()+1] = g_nmbb3_d_t.nmbuseq
            
               #刪除同層單身
               IF NOT anmt540_delete_b('nmbu_t',gs_keys,"'2'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE anmt540_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT anmt540_key_delete_b(gs_keys,'nmbu_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE anmt540_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身2刪除中 name="input.body3.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE anmt540_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身2刪除後 name="input.body3.a_delete"
               
               #end add-point
               LET l_count = g_nmbb_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body3.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_nmbb3_d.getLength() + 1) THEN
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
               
            #add-point:單身2新增前 name="input.body3.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM nmbu_t 
             WHERE nmbuent = g_enterprise AND nmbucomp = g_nmba_m.nmbacomp
               AND nmbudocno = g_nmba_m.nmbadocno
               AND nmbuseq = g_nmbb3_d[l_ac].nmbuseq
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前 name="input.body3.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_nmba_m.nmbacomp
               LET gs_keys[2] = g_nmba_m.nmbadocno
               LET gs_keys[3] = g_nmbb3_d[g_detail_idx].nmbuseq
               CALL anmt540_insert_b('nmbu_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2 name="input.body3.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_nmbb_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "nmbu_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL anmt540_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body3.after_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_nmbb3_d[l_ac].* = g_nmbb3_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE anmt540_bcl2
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
               LET g_nmbb3_d[l_ac].* = g_nmbb3_d_t.*
            ELSE
               #add-point:單身page2修改前 name="input.body3.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身2)
               
               
               #將遮罩欄位還原
               CALL anmt540_nmbu_t_mask_restore('restore_mask_o')
                              
               UPDATE nmbu_t SET (nmbucomp,nmbudocno,nmbuseq,nmbu001,nmbuorga,nmbu003,nmbu004,nmbu005, 
                   nmbu006,nmbu007,nmbu002) = (g_nmba_m.nmbacomp,g_nmba_m.nmbadocno,g_nmbb3_d[l_ac].nmbuseq, 
                   g_nmbb3_d[l_ac].nmbu001,g_nmbb3_d[l_ac].nmbuorga,g_nmbb3_d[l_ac].nmbu003,g_nmbb3_d[l_ac].nmbu004, 
                   g_nmbb3_d[l_ac].nmbu005,g_nmbb3_d[l_ac].nmbu006,g_nmbb3_d[l_ac].nmbu007,g_nmbb3_d[l_ac].nmbu002)  
                   #自訂欄位頁簽
                WHERE nmbuent = g_enterprise AND nmbucomp = g_nmba_m.nmbacomp
                  AND nmbudocno = g_nmba_m.nmbadocno
                  AND nmbuseq = g_nmbb3_d_t.nmbuseq #項次 
                  
               #add-point:單身page2修改中 name="input.body3.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_nmbb3_d[l_ac].* = g_nmbb3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "nmbu_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_nmbb3_d[l_ac].* = g_nmbb3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "nmbu_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_nmba_m.nmbacomp
               LET gs_keys_bak[1] = g_nmbacomp_t
               LET gs_keys[2] = g_nmba_m.nmbadocno
               LET gs_keys_bak[2] = g_nmbadocno_t
               LET gs_keys[3] = g_nmbb3_d[g_detail_idx].nmbuseq
               LET gs_keys_bak[3] = g_nmbb3_d_t.nmbuseq
               CALL anmt540_update_b('nmbu_t',gs_keys,gs_keys_bak,"'2'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL anmt540_nmbu_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_nmbb3_d[g_detail_idx].nmbuseq = g_nmbb3_d_t.nmbuseq 
                  ) THEN
                  LET gs_keys[01] = g_nmba_m.nmbacomp
                  LET gs_keys[gs_keys.getLength()+1] = g_nmba_m.nmbadocno
                  LET gs_keys[gs_keys.getLength()+1] = g_nmbb3_d_t.nmbuseq
                  CALL anmt540_key_update_b(gs_keys,'nmbu_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_nmba_m),util.JSON.stringify(g_nmbb3_d_t)
               LET g_log2 = util.JSON.stringify(g_nmba_m),util.JSON.stringify(g_nmbb3_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page2修改後 name="input.body3.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbuseq
            #add-point:BEFORE FIELD nmbuseq name="input.b.page3.nmbuseq"
            IF cl_null(g_nmbb3_d[g_detail_idx].nmbuseq) THEN 
               SELECT MAX(nmbuseq) INTO g_nmbb3_d[g_detail_idx].nmbuseq
                 FROM nmbu_t
                WHERE nmbuent = g_enterprise
                  AND nmbucomp = g_nmba_m.nmbacomp
                  AND nmbudocno = g_nmba_m.nmbadocno
                  
               IF cl_null(g_nmbb3_d[g_detail_idx].nmbuseq) THEN 
                  LET g_nmbb3_d[g_detail_idx].nmbuseq = 1
               ELSE
                  LET g_nmbb3_d[g_detail_idx].nmbuseq = g_nmbb3_d[g_detail_idx].nmbuseq + 1
               END IF
            END IF
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbuseq
            
            #add-point:AFTER FIELD nmbuseq name="input.a.page3.nmbuseq"
            #此段落由子樣板a05產生
            IF  g_nmba_m.nmbacomp IS NOT NULL AND g_nmba_m.nmbadocno IS NOT NULL AND g_nmbb3_d[g_detail_idx].nmbuseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_nmba_m.nmbacomp != g_nmbacomp_t OR g_nmba_m.nmbadocno != g_nmbadocno_t OR g_nmbb3_d[g_detail_idx].nmbuseq != g_nmbb3_d_t.nmbuseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM nmbu_t WHERE "||"nmbuent = '" ||g_enterprise|| "' AND "||"nmbucomp = '"||g_nmba_m.nmbacomp ||"' AND "|| "nmbudocno = '"||g_nmba_m.nmbadocno ||"' AND "|| "nmbuseq = '"||g_nmbb3_d[g_detail_idx].nmbuseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbuseq
            #add-point:ON CHANGE nmbuseq name="input.g.page3.nmbuseq"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbu001
            
            #add-point:AFTER FIELD nmbu001 name="input.a.page3.nmbu001"
         
            IF NOT cl_null(g_nmbb3_d[l_ac].nmbu001) THEN 
               CALL anmt540_nmbu001_chk()
               IF NOT cl_null(g_errno) THEN 
                  IF p_cmd = 'a' THEN 
                     DISPLAY '' TO nmbu001
                     DISPLAY '' TO nmbu001_desc
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_nmbb3_d[l_ac].nmbu001
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_nmbb3_d[l_ac].nmbu001 = ''
                     LET g_nmbb3_d[l_ac].nmbu001_desc = ''
                  ELSE
                     DISPLAY '' TO nmbu001
                     DISPLAY '' TO nmbu001_desc
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_nmbb3_d[l_ac].nmbu001
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_nmbb3_d[l_ac].nmbu001 = g_nmbb3_d_t.nmbu001
                     LET g_nmbb3_d[l_ac].nmbu001_desc = g_nmbb3_d_t.nmbu001_desc
                  END IF 
                  NEXT FIELD nmbu001
               END IF 
            END IF 
            CALL anmt540_ref_b_3()
            CALL anmt540_nmbuorga_desc()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbu001
            #add-point:BEFORE FIELD nmbu001 name="input.b.page3.nmbu001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbu001
            #add-point:ON CHANGE nmbu001 name="input.g.page3.nmbu001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbuorga
            
            #add-point:AFTER FIELD nmbuorga name="input.a.page3.nmbuorga"
            IF NOT cl_null(g_nmbb3_d[l_ac].nmbuorga) THEN 
               CALL anmt540_nmbuorga_chk()
               IF NOT cl_null(g_errno) THEN 
                  IF l_cmd = 'a' THEN 
                     DISPLAY '' TO s_detail3[l_ac].nmbuorga
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_nmbb3_d[l_ac].nmbuorga
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_nmbb3_d[l_ac].nmbuorga = ''
                  ELSE
                     DISPLAY '' TO s_detail3[l_ac].nmbuorga
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_nmbb3_d[l_ac].nmbuorga
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_nmbb3_d[l_ac].nmbuorga = g_nmbb3_d_t.nmbuorga
                  END IF 
                  DISPLAY g_nmbb3_d[l_ac].nmbuorga TO s_detail3[l_ac].nmbuorga
                  NEXT FIELD nmbuorga
               END IF
            END IF 
            CALL anmt540_nmbuorga_desc()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbuorga
            #add-point:BEFORE FIELD nmbuorga name="input.b.page3.nmbuorga"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbuorga
            #add-point:ON CHANGE nmbuorga name="input.g.page3.nmbuorga"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbu003
            #add-point:BEFORE FIELD nmbu003 name="input.b.page3.nmbu003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbu003
            
            #add-point:AFTER FIELD nmbu003 name="input.a.page3.nmbu003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbu003
            #add-point:ON CHANGE nmbu003 name="input.g.page3.nmbu003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbu004
            #add-point:BEFORE FIELD nmbu004 name="input.b.page3.nmbu004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbu004
            
            #add-point:AFTER FIELD nmbu004 name="input.a.page3.nmbu004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbu004
            #add-point:ON CHANGE nmbu004 name="input.g.page3.nmbu004"
            LET g_nmbb3_d[l_ac].nmbu005 = ''
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbu005
            #add-point:BEFORE FIELD nmbu005 name="input.b.page3.nmbu005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbu005
            
            #add-point:AFTER FIELD nmbu005 name="input.a.page3.nmbu005"
            IF NOT cl_null(g_nmbb3_d[l_ac].nmbu005) THEN 
               CALL anmt540_nmbu005_chk()
               IF NOT cl_null(g_errno) THEN 
                  IF l_cmd = 'a' THEN 
                     DISPLAY '' TO s_detail3[l_ac].nmbu005
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_nmbb3_d[l_ac].nmbu005
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_nmbb3_d[l_ac].nmbu005 = ''
                  ELSE
                     DISPLAY '' TO s_detail3[l_ac].nmbu005
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_nmbb3_d[l_ac].nmbu005
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_nmbb3_d[l_ac].nmbu005 = g_nmbb3_d_t.nmbu005
                  END IF 
                  DISPLAY g_nmbb3_d[l_ac].nmbu005 TO s_detail3[l_ac].nmbu005
                  NEXT FIELD nmbu005
               END IF
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbu005
            #add-point:ON CHANGE nmbu005 name="input.g.page3.nmbu005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbu006
            #add-point:BEFORE FIELD nmbu006 name="input.b.page3.nmbu006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbu006
            
            #add-point:AFTER FIELD nmbu006 name="input.a.page3.nmbu006"
            IF g_nmbb3_d[l_ac].nmbu004 = '1' THEN 
               IF NOT cl_null(g_nmbb3_d[l_ac].nmbu005) AND NOT cl_null(g_nmbb3_d[l_ac].nmbu006) THEN 
                  LET l_n = 0
                  SELECT COUNT(*) INTO l_n
                    FROM xmdb_t 
                   WHERE xmdbent = g_enterprise
                     AND xmdbdocno = g_nmbb3_d[l_ac].nmbu005
                     AND xmdb001 = g_nmbb3_d[l_ac].nmbu006
                  
                  IF l_n = 0 THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'anm-00212'
                     LET g_errparam.extend = g_nmbb3_d[l_ac].nmbu006
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     
                     LET g_nmbb3_d[l_ac].nmbu006 = ''
                     NEXT FIELD nmbu006
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbu006
            #add-point:ON CHANGE nmbu006 name="input.g.page3.nmbu006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbu007
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_nmbb3_d[l_ac].nmbu007,"0","0","","","azz-00079",1) THEN
               NEXT FIELD nmbu007
            END IF 
 
 
 
            #add-point:AFTER FIELD nmbu007 name="input.a.page3.nmbu007"
            IF NOT cl_null(g_nmbb3_d[l_ac].nmbu007) THEN 
               CALL s_curr_round_ld('1',g_glaald,g_nmbb_d[l_ac].nmbb004,g_nmbb3_d[l_ac].nmbu007,2) #150707-00001#7
                    RETURNING g_sub_success,g_errno,g_nmbb3_d[l_ac].nmbu007                        #150707-00001#7             
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbu007
            #add-point:BEFORE FIELD nmbu007 name="input.b.page3.nmbu007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbu007
            #add-point:ON CHANGE nmbu007 name="input.g.page3.nmbu007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbu002
            #add-point:BEFORE FIELD nmbu002 name="input.b.page3.nmbu002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbu002
            
            #add-point:AFTER FIELD nmbu002 name="input.a.page3.nmbu002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbu002
            #add-point:ON CHANGE nmbu002 name="input.g.page3.nmbu002"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page3.nmbuseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbuseq
            #add-point:ON ACTION controlp INFIELD nmbuseq name="input.c.page3.nmbuseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.nmbu001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbu001
            #add-point:ON ACTION controlp INFIELD nmbu001 name="input.c.page3.nmbu001"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_nmbb3_d[l_ac].nmbu001             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_nmba_m.nmbadocno
            CALL q_nmbb026()                                #呼叫開窗

            LET g_nmbb3_d[l_ac].nmbu001 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_nmbb3_d[l_ac].nmbu001 TO nmbu001              #顯示到畫面上
            CALL anmt540_ref_b_3()
            NEXT FIELD nmbu001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page3.nmbuorga
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbuorga
            #add-point:ON ACTION controlp INFIELD nmbuorga name="input.c.page3.nmbuorga"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_nmbb3_d[l_ac].nmbuorga             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_nmba_m.nmbadocno
            LET g_qryparam.arg2 = g_nmbb3_d[l_ac].nmbu001

            CALL q_nmbborga()                                #呼叫開窗

            LET g_nmbb3_d[l_ac].nmbuorga = g_qryparam.return1              #將開窗取得的值回傳到變數
            CALL anmt540_nmbuorga_desc()
            DISPLAY g_nmbb3_d[l_ac].nmbuorga TO nmbuorga              #顯示到畫面上
            
            NEXT FIELD nmbuorga                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page3.nmbu003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbu003
            #add-point:ON ACTION controlp INFIELD nmbu003 name="input.c.page3.nmbu003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.nmbu004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbu004
            #add-point:ON ACTION controlp INFIELD nmbu004 name="input.c.page3.nmbu004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.nmbu005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbu005
            #add-point:ON ACTION controlp INFIELD nmbu005 name="input.c.page3.nmbu005"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_nmbb3_d[l_ac].nmbu005             #給予default值
            
            #給予arg
            IF g_nmbb3_d[l_ac].nmbu004 = '1' THEN 
               LET  g_qryparam.where = " xmda004 = '",g_nmbb3_d[l_ac].nmbu001,"'",
                                       #150707-00001#7--(s)
                                       " AND EXISTS( SELECT 1 FROM ooef_t ",
                                       "              WHERE ooefent = xmdaent ",
                                       "                AND ooef001 = xmdasite ",
                                       "                AND ooef017 = '",g_nmba_m.nmbacomp,"') "
                                       #150707-00001#7--(e)
                                       
               SELECT ooag004 INTO l_ooag004 FROM ooag_t
                WHERE ooagent = g_enterprise #2015/04/02 by 02599 add
                  AND ooag001 = g_user 
                
              # LET g_sql = " SELECT xrah002 FROM xrah_t ",
              #             "  WHERE xrah001 = '3' ", 
              #             "    AND xrah007 = 'Y' ",
              #             "    AND xrah004 = '",l_ooag004,"'"
              # PREPARE xrah002_pre FROM g_sql
              # DECLARE xrah002_cur CURSOR FOR xrah002_pre
              # OPEN xrah002_cur
              # FETCH xrah002_cur INTO l_nmbasite 
               
               LET g_qryparam.arg1 = g_nmbb_d[l_ac].nmbborga   #來源組織
               LET g_qryparam.arg2 = '1'
               LET g_qryparam.arg3 = g_nmba_m.nmbadocdt
               LET g_qryparam.arg4 = g_nmbb3_d[l_ac].nmbu001

               CALL q_xmdb_11()                                #呼叫開窗
            END IF 
            IF g_nmbb3_d[l_ac].nmbu004 = '2' THEN
               LET  g_qryparam.where = " xrca004 = '",g_nmbb3_d[l_ac].nmbu001,"'",
                                       "   AND xrcald = '",g_glaald,"'",
                                       "   AND xrcastus = 'Y' ",   #160919-00008#1 Add
                                       "   AND xrca108 > 0"                                       
               CALL q_xrcadocno()                                #呼叫開窗
            END IF
            
            IF g_nmbb3_d[l_ac].nmbu004 = '3' THEN
               LET  g_qryparam.where = " isaf002 = '",g_nmbb3_d[l_ac].nmbu001,"'",
                                       "  AND isafcomp = '",g_nmba_m.nmbacomp,"'", 
                                       "  AND isaf035 IS NULL"                                       
               CALL q_isafdocno_2()                                #呼叫開窗
            END IF

            LET g_nmbb3_d[l_ac].nmbu005 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_nmbb3_d[l_ac].nmbu005 TO nmbu005              #顯示到畫面上

            NEXT FIELD nmbu005                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page3.nmbu006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbu006
            #add-point:ON ACTION controlp INFIELD nmbu006 name="input.c.page3.nmbu006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.nmbu007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbu007
            #add-point:ON ACTION controlp INFIELD nmbu007 name="input.c.page3.nmbu007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.nmbu002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbu002
            #add-point:ON ACTION controlp INFIELD nmbu002 name="input.c.page3.nmbu002"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page2 after_row name="input.body3.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_nmbb3_d[l_ac].* = g_nmbb3_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE anmt540_bcl2
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL anmt540_unlock_b("nmbu_t","'2'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page2 after_row2 name="input.body3.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body3.after_input"
            
            #end add-point   
    
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_nmbb3_d[li_reproduce_target].* = g_nmbb3_d[li_reproduce].*
 
               LET g_nmbb3_d[li_reproduce_target].nmbuseq = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_nmbb3_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_nmbb3_d.getLength()+1
            END IF
            
      END INPUT
 
      
 
 
 
 
{</section>}
 
{<section id="anmt540.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      INPUT ARRAY g_nmbb2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                 INSERT ROW = TRUE, #此頁面insert功能由產生器控制, 手動之設定無效!
                 DELETE ROW = TRUE,
                 APPEND ROW = TRUE)
                 
         BEFORE INPUT
            
            CALL anmt540_b_fill2('0')
            LET g_rec_b = g_nmbb2_d.getLength()
            
            
         BEFORE INSERT
            LET g_insert = 'Y' 
            NEXT FIELD xrceseq_t
 
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_nmbb2_d[l_ac].* TO NULL 
            
            LET g_nmbb2_d_t.* = g_nmbb2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL anmt540_set_entry_b2()
            CALL anmt540_set_no_entry_b2()
            #公用欄位給值(單身2)
            
         BEFORE ROW     
            LET l_insert = FALSE
            LET p_cmd = ''
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
              
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN anmt540_cl USING g_enterprise,g_nmba_m.nmbacomp,g_nmba_m.nmbadocno
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  STATUS
               LET g_errparam.extend = "OPEN anmt540_cl:"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               CLOSE anmt540_cl
               CALL s_transaction_end('N','0')
               RETURN
            END IF
            
            LET g_rec_b = g_nmbb2_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND NOT cl_null(g_nmbb2_d[l_ac].nmbbseq) 
            THEN 
               LET l_cmd='u'
               LET g_nmbb2_d_t.* = g_nmbb2_d[l_ac].*  #BACKUP
               CALL anmt540_set_entry_b2()
               CALL anmt540_set_no_entry_b2()
               IF NOT anmt540_lock_b2("nmbb_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH anmt540_bcl3 INTO g_nmbb2_d[l_ac].nmbbseq,g_nmbb2_d[l_ac].nmbb026_1,
                                          g_nmbb2_d[l_ac].nmbb026_1_desc,g_nmbb2_d[l_ac].nmbb028,
                                          g_nmbb2_d[l_ac].nmbb028_desc1,g_nmbb2_d[l_ac].nmbb004,
                                          g_nmbb2_d[l_ac].nmbb006,g_nmbb2_d[l_ac].nmbb032,
                                          g_nmbb2_d[l_ac].nmbb033,g_nmbb2_d[l_ac].nmbb034,
                                          g_nmbb2_d[l_ac].nmbb035,g_nmbb2_d[l_ac].nmbb036,
                                          g_nmbb2_d[l_ac].nmbb036_desc,
                                          g_nmbb2_d[l_ac].nmbb037,g_nmbb2_d[l_ac].nmbb038
                   IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET l_lock_sw = "Y"
                  END IF
                  
                  LET g_bfill = "N"
                  CALL anmt540_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
#                  SELECT ooia002
#                    INTO l_nmbb029
#                    FROM ooie_t,ooia_t
#                   WHERE ooieent = g_enterprise
#                     AND ooiesite = g_nmbb_d[l_ac].nmbborga
#                     AND ooie001 = g_nmbb_d[l_ac].nmbb028
#                     AND ooiaent = ooieent
#                     AND ooia001 = ooie001
                  SELECT ooia002 INTO l_nmbb029
                    FROM ooia_t
                   WHERE ooiaent = g_enterprise
                     AND ooia001 = g_nmbb_d[l_ac].nmbb028
                  IF l_nmbb029 <> '40' AND l_nmbb029 <> '50' THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'anm-00066'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = FALSE
                     CALL cl_err()
                     EXIT DIALOG
                  END IF 
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL anmt540_ref_b_2()
            
         BEFORE DELETE                            #是否取消單身
         
         AFTER DELETE
            
         AFTER INSERT    
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               CANCEL INSERT
            END IF

         ON ROW CHANGE 
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               LET g_nmbb2_d[l_ac].* = g_nmbb2_d_t.*
               CLOSE anmt540_bcl3
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_nmbb2_d[l_ac].* = g_nmbb2_d_t.*
            ELSE
               
               #寫入修改者/修改日期資訊(單身2)
               
               UPDATE nmbb_t SET (nmbb032,nmbb033,nmbb034,nmbb035,nmbb036,nmbb037,nmbb038) = (g_nmbb2_d[l_ac].nmbb032,g_nmbb2_d[l_ac].nmbb033,g_nmbb2_d[l_ac].nmbb034,g_nmbb2_d[l_ac].nmbb035,g_nmbb2_d[l_ac].nmbb036,g_nmbb2_d[l_ac].nmbb037,g_nmbb2_d[l_ac].nmbb038) 
                WHERE nmbbent = g_enterprise AND nmbbcomp = g_nmba_m.nmbacomp 
                  AND nmbbdocno = g_nmba_m.nmbadocno 
                  AND nmbbseq = g_nmbb2_d_t.nmbbseq #項次 

               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
   
                  LET g_nmbb2_d[l_ac].* = g_nmbb2_d_t.*
               ELSE
               INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_nmba_m.nmbacomp
               LET gs_keys_bak[1] = g_nmbacomp_t
               LET gs_keys[2] = g_nmba_m.nmbadocno
               LET gs_keys_bak[2] = g_nmbadocno_t
               LET gs_keys[3] = g_nmbb2_d[g_detail_idx].nmbbseq
               LET gs_keys_bak[3] = g_nmbb2_d_t.nmbbseq
                  #資料多語言用-增/改
                  
               END IF
            END IF
         
         #---------------------<  Detail: page2  >---------------------
         #----<<nmbb034>>----
         AFTER FIELD nmbb034
            LET l_nmbb034 = g_nmbb2_d[l_ac].nmbb034
            LET l_nmbb035 = g_nmbb2_d[l_ac].nmbb035
            IF NOT cl_null(g_nmbb2_d[l_ac].nmbb034) AND NOT cl_null(g_nmbb2_d[l_ac].nmbb035) THEN 
               IF l_nmbb034.getLength() <> l_nmbb035.getLength() THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'anm-00085'
                  LET g_errparam.extend = g_nmbb2_d[l_ac].nmbb034
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_nmbb2_d[l_ac].nmbb034 = g_nmbb2_d_t.nmbb034
                  NEXT FIELD nmbb034
               END IF 
            END IF 
            
         AFTER FIELD nmbb035
            LET l_nmbb034 = g_nmbb2_d[l_ac].nmbb034
            LET l_nmbb035 = g_nmbb2_d[l_ac].nmbb035
            IF NOT cl_null(g_nmbb2_d[l_ac].nmbb034) AND NOT cl_null(g_nmbb2_d[l_ac].nmbb035) THEN 
               IF l_nmbb034.getLength() <> l_nmbb035.getLength() THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'anm-00085'
                  LET g_errparam.extend = g_nmbb2_d[l_ac].nmbb035
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_nmbb2_d[l_ac].nmbb035 = g_nmbb2_d_t.nmbb035
                  NEXT FIELD nmbb035
               END IF 
            END IF
        #150707-00001#7--(s)
        AFTER FIELD nmbb033
           IF NOT cl_null(g_nmbb2_d[l_ac].nmbb033) THEN
               CALL s_curr_round_ld('1',g_glaald,g_nmbb_d[l_ac].nmbb004,g_nmbb2_d[l_ac].nmbb033,2)  
                RETURNING g_sub_success,g_errno,g_nmbb2_d[l_ac].nmbb033                             
           END IF
           
        AFTER FIELD nmbb038
           IF NOT cl_null(g_nmbb2_d[l_ac].nmbb038) THEN
               CALL s_curr_round_ld('1',g_glaald,g_nmbb_d[l_ac].nmbb004,g_nmbb2_d[l_ac].nmbb038,2)  
                RETURNING g_sub_success,g_errno,g_nmbb2_d[l_ac].nmbb038                             
           END IF           
        #150707-00001#7--(e)
         #----<<nmbb036_desc>>----
       #  BEFORE FIELD nmbb036_desc
       #     LET g_nmbb2_d[l_ac].nmbb036_desc = g_nmbb2_d[l_ac].nmbb036

         AFTER FIELD nmbb036
          # LET g_nmbb2_d[l_ac].nmbb036 = g_nmbb2_d[l_ac].nmbb036_desc
            IF NOT cl_null(g_nmbb2_d[l_ac].nmbb036) THEN 
               CALL anmt540_nmbb043_chk(g_nmbb2_d[l_ac].nmbb036)
               IF NOT cl_null(g_errno) THEN 
                  IF p_cmd = 'a' THEN 
                     DISPLAY '' TO s_detail2[l_ac].nmbb036
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_nmbb2_d[l_ac].nmbb036
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_nmbb2_d[l_ac].nmbb036 = ''
                     LET g_nmbb2_d[l_ac].nmbb036_desc = ''
                  ELSE
                     DISPLAY '' TO s_detail2[l_ac].nmbb036
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_nmbb2_d[l_ac].nmbb036
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_nmbb2_d[l_ac].nmbb036 = g_nmbb2_d_t.nmbb036
                     LET g_nmbb2_d[l_ac].nmbb036_desc = g_nmbb2_d_t.nmbb036_desc
                  END IF 
                  DISPLAY g_nmbb2_d[l_ac].nmbb036_desc TO nmbb036_desc
                  NEXT FIELD nmbb036
               END IF 
            END IF
            CALL anmt540_ref_b_2()
         
         ON CHANGE nmbb036_desc
 

         
         ON ACTION controlp INFIELD nmbb036
            #add-point:ON ACTION controlp INFIELD nmbb036_desc
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_nmbb2_d[l_ac].nmbb036             #給予default值
            LET g_qryparam.where = " nmab008 = '",g_ooef006,"'"
            #給予arg

            CALL q_nmab001()                                #呼叫開窗

            LET g_nmbb2_d[l_ac].nmbb036 = g_qryparam.return1              #將開窗取得的值回傳到變數
            CALL anmt540_ref_b_2() 
            DISPLAY g_nmbb2_d[l_ac].nmbb036_desc TO nmbb036_desc              #顯示到畫面上

            NEXT FIELD nmbb036


         #---------------------<  Detail: page2  >---------------------

         AFTER ROW
            LET l_ac = ARR_CURR()
            #LET l_ac_t = l_ac
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_nmbb2_d[l_ac].* = g_nmbb2_d_t.*
               END IF
               CLOSE anmt540_bcl3
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL anmt540_unlock_b("nmbb_t","'3'")
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
 
      END INPUT
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
         IF p_cmd = 'a' THEN
            NEXT FIELD nmba008
         END IF
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1',"))      
         CALL DIALOG.setCurrentRow("s_detail3",g_idx_group.getValue("'2',"))
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            
            #end add-point  
            NEXT FIELD nmbacomp
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD nmbbseq
               WHEN "s_detail3"
                  NEXT FIELD nmbuseq
 
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
 
{<section id="anmt540.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION anmt540_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   DEFINE l_ooba002        LIKE ooba_t.ooba002
   DEFINE l_success        LIKE type_t.num5
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   CALL anmt540_glaa_get()
   IF g_nmba_m.nmbastus = 'N' THEN
      CALL cl_set_act_visible("modify,delete,modify_detail", TRUE)   
   ELSE
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF

   #161226-00036#1 add s---
   IF g_nmba_m.nmbastus = 'Y' OR g_nmba_m.nmbastus = 'V' THEN
      CALL cl_set_toolbaritem_visible("modi_nmbb026", TRUE)
   ELSE
      CALL cl_set_toolbaritem_visible("modi_nmbb026", FALSE)
   END IF
   #161226-00036#1 add e---

   #CALL s_aooi200_get_slip_desc(g_nmba_m.nmbadocno)        #2014/12/29 liuym mark
   CALL s_aooi200_fin_get_slip_desc(g_nmba_m.nmbadocno)     #2014/12/29 liuym add
   RETURNING g_nmba_m.nmbadocno_desc
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL anmt540_b_fill() #單身填充
      CALL anmt540_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL anmt540_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
 
   #end add-point
   
   #遮罩相關處理
   LET g_nmba_m_mask_o.* =  g_nmba_m.*
   CALL anmt540_nmba_t_mask()
   LET g_nmba_m_mask_n.* =  g_nmba_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_nmba_m.nmbasite,g_nmba_m.nmbasite_desc,g_nmba_m.nmba008,g_nmba_m.nmba008_desc,g_nmba_m.nmba001, 
       g_nmba_m.nmba001_desc,g_nmba_m.nmbacomp,g_nmba_m.nmbacomp_desc,g_nmba_m.nmba002,g_nmba_m.nmbadocno, 
       g_nmba_m.nmbadocno_desc,g_nmba_m.nmbadocdt,g_nmba_m.nmba003,g_nmba_m.nmba004,g_nmba_m.nmba005, 
       g_nmba_m.nmba006,g_nmba_m.nmbastus,g_nmba_m.nmbaownid,g_nmba_m.nmbaownid_desc,g_nmba_m.nmbaowndp, 
       g_nmba_m.nmbaowndp_desc,g_nmba_m.nmbacrtid,g_nmba_m.nmbacrtid_desc,g_nmba_m.nmbacrtdp,g_nmba_m.nmbacrtdp_desc, 
       g_nmba_m.nmbacrtdt,g_nmba_m.nmbamodid,g_nmba_m.nmbamodid_desc,g_nmba_m.nmbamoddt,g_nmba_m.nmbacnfid, 
       g_nmba_m.nmbacnfid_desc,g_nmba_m.nmbacnfdt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_nmba_m.nmbastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "V"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/verify.png")
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
   FOR l_ac = 1 TO g_nmbb_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
 
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_nmbb3_d.getLength()
      #add-point:show段單身reference name="show.body3.reference"
            #INITIALIZE g_ref_fields TO NULL
            #LET g_ref_fields[1] = g_nmbb3_d[l_ac].nmbu001
            #CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            #LET g_nmbb3_d[l_ac].nmbu001_desc = '', g_rtn_fields[1] , ''
            #DISPLAY BY NAME g_nmbb3_d[l_ac].nmbu001_desc

      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL anmt540_detail_show()
 
   #add-point:show段之後 name="show.after"
   CALL s_anm_get_comp_wc('6',g_nmba_m.nmbasite,g_nmba_m.nmbadocdt) RETURNING g_comp_wc   #150707-00001#7
   #CALL s_anm_get_site_wc('6',g_nmba_m.nmbacomp,g_nmba_m.nmbadocdt) RETURNING g_site_wc   #150707-00001#7 #160912-00024#1
   CALL s_anm_get_site_wc('6',g_nmba_m.nmbasite,g_nmba_m.nmbadocdt) RETURNING g_site_wc    #160912-00024#1
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="anmt540.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION anmt540_detail_show()
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
 
{<section id="anmt540.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION anmt540_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE nmba_t.nmbacomp 
   DEFINE l_oldno     LIKE nmba_t.nmbacomp 
   DEFINE l_newno02     LIKE nmba_t.nmbadocno 
   DEFINE l_oldno02     LIKE nmba_t.nmbadocno 
 
   DEFINE l_master    RECORD LIKE nmba_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE nmbb_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE nmbu_t.* #此變數樣板目前無使用
 
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="reproduce.pre_function"
   
   #end add-point
   
   #切換畫面
   
   LET g_master_insert = FALSE
   
   IF g_nmba_m.nmbacomp IS NULL
   OR g_nmba_m.nmbadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_nmbacomp_t = g_nmba_m.nmbacomp
   LET g_nmbadocno_t = g_nmba_m.nmbadocno
 
    
   LET g_nmba_m.nmbacomp = ""
   LET g_nmba_m.nmbadocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_nmba_m.nmbaownid = g_user
      LET g_nmba_m.nmbaowndp = g_dept
      LET g_nmba_m.nmbacrtid = g_user
      LET g_nmba_m.nmbacrtdp = g_dept 
      LET g_nmba_m.nmbacrtdt = cl_get_current()
      LET g_nmba_m.nmbamodid = g_user
      LET g_nmba_m.nmbamoddt = cl_get_current()
      LET g_nmba_m.nmbastus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_nmba_m.nmbastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "V"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/verify.png")
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
      LET g_nmba_m.nmbacomp_desc = ''
   DISPLAY BY NAME g_nmba_m.nmbacomp_desc
   LET g_nmba_m.nmbadocno_desc = ''
   DISPLAY BY NAME g_nmba_m.nmbadocno_desc
 
   
   CALL anmt540_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_nmba_m.* TO NULL
      INITIALIZE g_nmbb_d TO NULL
      INITIALIZE g_nmbb3_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL anmt540_show()
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
   CALL anmt540_set_act_visible()   
   CALL anmt540_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_nmbacomp_t = g_nmba_m.nmbacomp
   LET g_nmbadocno_t = g_nmba_m.nmbadocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " nmbaent = " ||g_enterprise|| " AND",
                      " nmbacomp = '", g_nmba_m.nmbacomp, "' "
                      ," AND nmbadocno = '", g_nmba_m.nmbadocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL anmt540_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL anmt540_idx_chk()
   
   LET g_data_owner = g_nmba_m.nmbaownid      
   LET g_data_dept  = g_nmba_m.nmbaowndp
   
   #功能已完成,通報訊息中心
   CALL anmt540_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="anmt540.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION anmt540_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE nmbb_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE nmbu_t.* #此變數樣板目前無使用
 
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE anmt540_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM nmbb_t
    WHERE nmbbent = g_enterprise AND nmbbcomp = g_nmbacomp_t
     AND nmbbdocno = g_nmbadocno_t
 
    INTO TEMP anmt540_detail
 
   #將key修正為調整後   
   UPDATE anmt540_detail 
      #更新key欄位
      SET nmbbcomp = g_nmba_m.nmbacomp
          , nmbbdocno = g_nmba_m.nmbadocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO nmbb_t SELECT * FROM anmt540_detail
   
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
   DROP TABLE anmt540_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table2.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM nmbu_t 
    WHERE nmbuent = g_enterprise AND nmbucomp = g_nmbacomp_t
      AND nmbudocno = g_nmbadocno_t   
 
    INTO TEMP anmt540_detail
 
   #將key修正為調整後   
   UPDATE anmt540_detail SET nmbucomp = g_nmba_m.nmbacomp
                                       , nmbudocno = g_nmba_m.nmbadocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table2.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO nmbu_t SELECT * FROM anmt540_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table2.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE anmt540_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table2.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_nmbacomp_t = g_nmba_m.nmbacomp
   LET g_nmbadocno_t = g_nmba_m.nmbadocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="anmt540.delete" >}
#+ 資料刪除
PRIVATE FUNCTION anmt540_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point     
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   DEFINE l_success        LIKE type_t.num5  #150813-00015#14 add
   DEFINE l_n              LIKE type_t.num5  #160122-00001#27
   #end add-point     
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   IF g_nmba_m.nmbacomp IS NULL
   OR g_nmba_m.nmbadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN anmt540_cl USING g_enterprise,g_nmba_m.nmbacomp,g_nmba_m.nmbadocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN anmt540_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE anmt540_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE anmt540_master_referesh USING g_nmba_m.nmbacomp,g_nmba_m.nmbadocno INTO g_nmba_m.nmbasite, 
       g_nmba_m.nmba008,g_nmba_m.nmba001,g_nmba_m.nmbacomp,g_nmba_m.nmba002,g_nmba_m.nmbadocno,g_nmba_m.nmbadocdt, 
       g_nmba_m.nmba003,g_nmba_m.nmba004,g_nmba_m.nmba005,g_nmba_m.nmba006,g_nmba_m.nmbastus,g_nmba_m.nmbaownid, 
       g_nmba_m.nmbaowndp,g_nmba_m.nmbacrtid,g_nmba_m.nmbacrtdp,g_nmba_m.nmbacrtdt,g_nmba_m.nmbamodid, 
       g_nmba_m.nmbamoddt,g_nmba_m.nmbacnfid,g_nmba_m.nmbacnfdt,g_nmba_m.nmbasite_desc,g_nmba_m.nmba008_desc, 
       g_nmba_m.nmba001_desc,g_nmba_m.nmbacomp_desc,g_nmba_m.nmbaownid_desc,g_nmba_m.nmbaowndp_desc, 
       g_nmba_m.nmbacrtid_desc,g_nmba_m.nmbacrtdp_desc,g_nmba_m.nmbamodid_desc,g_nmba_m.nmbacnfid_desc 
 
   
   
   #檢查是否允許此動作
   IF NOT anmt540_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_nmba_m_mask_o.* =  g_nmba_m.*
   CALL anmt540_nmba_t_mask()
   LET g_nmba_m_mask_n.* =  g_nmba_m.*
   
   CALL anmt540_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   #150813-00015#14--add--str--
   IF g_nmba_m.nmbastus <> 'N' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'agl-00313'
      LET g_errparam.extend = 'modify'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CLOSE anmt540_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF 
   
   #檢查當單據日期小於等於關帳日期時，不可異動單據
   CALL s_fin_date_close_chk('',g_nmba_m.nmbacomp,'ANM',g_nmba_m.nmbadocdt) RETURNING l_success
   IF l_success = FALSE THEN
      CLOSE anmt540_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   #150813-00015#14--add--end
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL anmt540_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      #160122-00001#27 by 07673 ---modify---str
      LET l_n = 0 
      #單身存在當前用戶沒有權限的交易帳戶編碼
      SELECT COUNT(*) INTO l_n FROM nmbb_t
       WHERE nmbbent = g_enterprise AND nmbbdocno = g_nmba_m.nmbadocno
         AND nmbb003 NOT IN( SELECT UNIQUE nmll001 FROM nmll_t WHERE nmllent = g_enterprise AND nmll002 = g_user)
         AND nmbb003 NOT IN( SELECT UNIQUE nmlm001 FROM nmlm_t WHERE nmlment = g_enterprise AND nmlm002 = g_dept)    
         AND TRIM(nmbb003) IS NOT NULL 
      IF l_n > 0 THEN
         IF NOT cl_ask_confirm('anm-00395') THEN
            CLOSE anmt540_cl
            CALL s_transaction_end('N','0')
            RETURN
         END IF
      END IF
      #160122-00001#27 by 07673 ---modify---end
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_nmbacomp_t = g_nmba_m.nmbacomp
      LET g_nmbadocno_t = g_nmba_m.nmbadocno
 
 
      DELETE FROM nmba_t
       WHERE nmbaent = g_enterprise AND nmbacomp = g_nmba_m.nmbacomp
         AND nmbadocno = g_nmba_m.nmbadocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      IF NOT s_aooi200_fin_del_docno(g_glaald,g_nmba_m.nmbadocno,g_nmba_m.nmbadocdt) THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_nmba_m.nmbacomp,":",SQLERRMESSAGE  
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
      
      DELETE FROM nmbb_t
       WHERE nmbbent = g_enterprise AND nmbbcomp = g_nmba_m.nmbacomp
         AND nmbbdocno = g_nmba_m.nmbadocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      #160126-00010#27 by 07673---mrak---str
#      #160126-00010#27---add---str
#         AND (nmbb003 IN( SELECT UNIQUE nmll001 FROM nmll_t WHERE nmllent = g_enterprise AND nmll002 = g_user)
#          OR nmbb003 IS NULL)
#      #160126-00010#27---add---end
      #160126-00010#27 by 07673---mrak---end
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "nmbb_t:",SQLERRMESSAGE 
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
      DELETE FROM nmbu_t
       WHERE nmbuent = g_enterprise AND
             nmbucomp = g_nmba_m.nmbacomp AND nmbudocno = g_nmba_m.nmbadocno
      #add-point:單身刪除中 name="delete.body.m_delete2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "nmbu_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete2"
      #150707-00001#7--(s)
      CALL s_cashflow_nm_del_glbc(g_nmba_m.nmbadocdt,g_glaald,g_nmba_m.nmbadocno,'')
           RETURNING g_sub_success,g_errno
      IF NOT g_sub_success THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "glbc_t"
         LET g_errparam.code   = g_errno
         LET g_errparam.popup  = FALSE
         CALL cl_err()
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      #150707-00001#7--(e)
      #end add-point
 
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_nmba_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE anmt540_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_nmbb_d.clear() 
      CALL g_nmbb3_d.clear()       
 
     
      CALL anmt540_ui_browser_refresh()  
      #CALL anmt540_ui_headershow()  
      #CALL anmt540_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL anmt540_browser_fill("")
         CALL anmt540_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE anmt540_cl
 
   #功能已完成,通報訊息中心
   CALL anmt540_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="anmt540.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION anmt540_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_nmbb_d.clear()
   CALL g_nmbb3_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF anmt540_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT nmbbseq,nmbborga,nmbb026,nmbb027,nmbb028,nmbb003,nmbb030,nmbb043, 
             nmbb073,nmbb031,nmbb004,nmbb005,nmbb006,nmbb007,nmbb040,nmbb041,nmbb044,nmbb002,nmbb010, 
             nmbblegl,nmbb045,nmbb029,nmbb039,nmbb001,nmbb011,nmbb012,nmbb013,nmbb014,nmbb015,nmbb016, 
             nmbb017,nmbb018,nmbb019,nmbb020,nmbb021,nmbb022,nmbb023,nmbb024,nmbb053,nmbb054,nmbb008, 
             nmbb009,nmbb056,nmbb057,nmbb058,nmbb059,nmbb060,nmbb061,nmbb062,nmbb066,nmbb067,nmbb068, 
             nmbb042,nmbb069,nmbb025 ,t1.ooefl003 ,t2.pmaal004 ,t3.ooial003 FROM nmbb_t",   
                     " INNER JOIN nmba_t ON nmbaent = " ||g_enterprise|| " AND nmbacomp = nmbbcomp ",
                     " AND nmbadocno = nmbbdocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=nmbborga AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t2 ON t2.pmaalent="||g_enterprise||" AND t2.pmaal001=nmbb026 AND t2.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN ooial_t t3 ON t3.ooialent="||g_enterprise||" AND t3.ooial001=nmbb028 AND t3.ooial002='"||g_dlang||"' ",
 
                     " WHERE nmbbent=? AND nmbbcomp=? AND nmbbdocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         LET g_sql = g_sql CLIPPED," AND (nmbb003 IN(",g_sql_bank,")  OR TRIM(nmbb003) IS NULL)"  #160122-00001#27
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料  #160122-00001#27
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY nmbb_t.nmbbseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
      
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE anmt540_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR anmt540_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_nmba_m.nmbacomp,g_nmba_m.nmbadocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_nmba_m.nmbacomp,g_nmba_m.nmbadocno INTO g_nmbb_d[l_ac].nmbbseq, 
          g_nmbb_d[l_ac].nmbborga,g_nmbb_d[l_ac].nmbb026,g_nmbb_d[l_ac].nmbb027,g_nmbb_d[l_ac].nmbb028, 
          g_nmbb_d[l_ac].nmbb003,g_nmbb_d[l_ac].nmbb030,g_nmbb_d[l_ac].nmbb043,g_nmbb_d[l_ac].nmbb073, 
          g_nmbb_d[l_ac].nmbb031,g_nmbb_d[l_ac].nmbb004,g_nmbb_d[l_ac].nmbb005,g_nmbb_d[l_ac].nmbb006, 
          g_nmbb_d[l_ac].nmbb007,g_nmbb_d[l_ac].nmbb040,g_nmbb_d[l_ac].nmbb041,g_nmbb_d[l_ac].nmbb044, 
          g_nmbb_d[l_ac].nmbb002,g_nmbb_d[l_ac].nmbb010,g_nmbb_d[l_ac].nmbblegl,g_nmbb_d[l_ac].nmbb045, 
          g_nmbb_d[l_ac].nmbb029,g_nmbb_d[l_ac].nmbb039,g_nmbb_d[l_ac].nmbb001,g_nmbb_d[l_ac].nmbb011, 
          g_nmbb_d[l_ac].nmbb012,g_nmbb_d[l_ac].nmbb013,g_nmbb_d[l_ac].nmbb014,g_nmbb_d[l_ac].nmbb015, 
          g_nmbb_d[l_ac].nmbb016,g_nmbb_d[l_ac].nmbb017,g_nmbb_d[l_ac].nmbb018,g_nmbb_d[l_ac].nmbb019, 
          g_nmbb_d[l_ac].nmbb020,g_nmbb_d[l_ac].nmbb021,g_nmbb_d[l_ac].nmbb022,g_nmbb_d[l_ac].nmbb023, 
          g_nmbb_d[l_ac].nmbb024,g_nmbb_d[l_ac].nmbb053,g_nmbb_d[l_ac].nmbb054,g_nmbb_d[l_ac].nmbb008, 
          g_nmbb_d[l_ac].nmbb009,g_nmbb_d[l_ac].nmbb056,g_nmbb_d[l_ac].nmbb057,g_nmbb_d[l_ac].nmbb058, 
          g_nmbb_d[l_ac].nmbb059,g_nmbb_d[l_ac].nmbb060,g_nmbb_d[l_ac].nmbb061,g_nmbb_d[l_ac].nmbb062, 
          g_nmbb_d[l_ac].nmbb066,g_nmbb_d[l_ac].nmbb067,g_nmbb_d[l_ac].nmbb068,g_nmbb_d[l_ac].nmbb042, 
          g_nmbb_d[l_ac].nmbb069,g_nmbb_d[l_ac].nmbb025,g_nmbb_d[l_ac].nmbborga_desc,g_nmbb_d[l_ac].nmbb026_desc, 
          g_nmbb_d[l_ac].nmbb028_desc   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill.fill"
         CALL anmt540_ref_b()
         CALL anmt540_nmbb002_desc()  
         CALL s_desc_get_person_desc(g_nmbb_d[l_ac].nmbb027) RETURNING g_nmbb_d[l_ac].nmbb027_desc
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
   IF anmt540_fill_chk(2) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body2.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT nmbuseq,nmbu001,nmbuorga,nmbu003,nmbu004,nmbu005,nmbu006,nmbu007, 
             nmbu002 ,t5.ooefl003 FROM nmbu_t",   
                     " INNER JOIN  nmba_t ON nmbaent = " ||g_enterprise|| " AND nmbacomp = nmbucomp ",
                     " AND nmbadocno = nmbudocno ",
 
                     "",
                     
                                    " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=nmbuorga AND t5.ooefl002='"||g_dlang||"' ",
 
                     " WHERE nmbuent=? AND nmbucomp=? AND nmbudocno=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body2.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table2) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY nmbu_t.nmbuseq"
         
         #add-point:單身填充控制 name="b_fill.sql2"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE anmt540_pb2 FROM g_sql
         DECLARE b_fill_cs2 CURSOR FOR anmt540_pb2
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs2 USING g_enterprise,g_nmba_m.nmbacomp,g_nmba_m.nmbadocno   #(ver:78)
                                               
      FOREACH b_fill_cs2 USING g_enterprise,g_nmba_m.nmbacomp,g_nmba_m.nmbadocno INTO g_nmbb3_d[l_ac].nmbuseq, 
          g_nmbb3_d[l_ac].nmbu001,g_nmbb3_d[l_ac].nmbuorga,g_nmbb3_d[l_ac].nmbu003,g_nmbb3_d[l_ac].nmbu004, 
          g_nmbb3_d[l_ac].nmbu005,g_nmbb3_d[l_ac].nmbu006,g_nmbb3_d[l_ac].nmbu007,g_nmbb3_d[l_ac].nmbu002, 
          g_nmbb3_d[l_ac].nmbuorga_desc   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill2.fill"
         CALL anmt540_ref_b_3()
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
   
   CALL g_nmbb_d.deleteElement(g_nmbb_d.getLength())
   CALL g_nmbb3_d.deleteElement(g_nmbb3_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE anmt540_pb
   FREE anmt540_pb2
 
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_nmbb_d.getLength()
      LET g_nmbb_d_mask_o[l_ac].* =  g_nmbb_d[l_ac].*
      CALL anmt540_nmbb_t_mask()
      LET g_nmbb_d_mask_n[l_ac].* =  g_nmbb_d[l_ac].*
   END FOR
   
   LET g_nmbb3_d_mask_o.* =  g_nmbb3_d.*
   FOR l_ac = 1 TO g_nmbb3_d.getLength()
      LET g_nmbb3_d_mask_o[l_ac].* =  g_nmbb3_d[l_ac].*
      CALL anmt540_nmbu_t_mask()
      LET g_nmbb3_d_mask_n[l_ac].* =  g_nmbb3_d[l_ac].*
   END FOR
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="anmt540.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION anmt540_delete_b(ps_table,ps_keys_bak,ps_page)
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
      #150707-00001#7--(s)
      CALL s_cashflow_nm_del_glbc(g_nmba_m.nmbadocdt,g_glaald,g_nmba_m.nmbadocno,ps_keys_bak[3])
           RETURNING g_sub_success,g_errno
      IF NOT g_sub_success THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "delete glbc_t"
         LET g_errparam.code   = g_errno
         LET g_errparam.popup  = FALSE
         CALL cl_err()
         RETURN FALSE
      END IF
      #150707-00001#7--(e)
      #end add-point    
      DELETE FROM nmbb_t
       WHERE nmbbent = g_enterprise AND
         nmbbcomp = ps_keys_bak[1] AND nmbbdocno = ps_keys_bak[2] AND nmbbseq = ps_keys_bak[3]
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
         CALL g_nmbb_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete2"
      
      #end add-point    
      DELETE FROM nmbu_t
       WHERE nmbuent = g_enterprise AND
             nmbucomp = ps_keys_bak[1] AND nmbudocno = ps_keys_bak[2] AND nmbuseq = ps_keys_bak[3]
      #add-point:delete_b段刪除中 name="delete_b.m_delete2"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "nmbu_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_nmbb3_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete2"
      
      #end add-point    
   END IF
 
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="anmt540.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION anmt540_insert_b(ps_table,ps_keys,ps_page)
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
      LET g_nmbb_d[g_detail_idx].nmbb066 = g_nmbb_d[g_detail_idx].nmbb007
      LET g_nmbb_d[g_detail_idx].nmbb067 = g_nmbb_d[g_detail_idx].nmbb013
      LET g_nmbb_d[g_detail_idx].nmbb068 = g_nmbb_d[g_detail_idx].nmbb017
      #end add-point 
      INSERT INTO nmbb_t
                  (nmbbent,
                   nmbbcomp,nmbbdocno,
                   nmbbseq
                   ,nmbborga,nmbb026,nmbb027,nmbb028,nmbb003,nmbb030,nmbb043,nmbb073,nmbb031,nmbb004,nmbb005,nmbb006,nmbb007,nmbb040,nmbb041,nmbb044,nmbb002,nmbb010,nmbblegl,nmbb045,nmbb029,nmbb039,nmbb001,nmbb011,nmbb012,nmbb013,nmbb014,nmbb015,nmbb016,nmbb017,nmbb018,nmbb019,nmbb020,nmbb021,nmbb022,nmbb023,nmbb024,nmbb053,nmbb054,nmbb008,nmbb009,nmbb056,nmbb057,nmbb058,nmbb059,nmbb060,nmbb061,nmbb062,nmbb066,nmbb067,nmbb068,nmbb042,nmbb069,nmbb025) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_nmbb_d[g_detail_idx].nmbborga,g_nmbb_d[g_detail_idx].nmbb026,g_nmbb_d[g_detail_idx].nmbb027, 
                       g_nmbb_d[g_detail_idx].nmbb028,g_nmbb_d[g_detail_idx].nmbb003,g_nmbb_d[g_detail_idx].nmbb030, 
                       g_nmbb_d[g_detail_idx].nmbb043,g_nmbb_d[g_detail_idx].nmbb073,g_nmbb_d[g_detail_idx].nmbb031, 
                       g_nmbb_d[g_detail_idx].nmbb004,g_nmbb_d[g_detail_idx].nmbb005,g_nmbb_d[g_detail_idx].nmbb006, 
                       g_nmbb_d[g_detail_idx].nmbb007,g_nmbb_d[g_detail_idx].nmbb040,g_nmbb_d[g_detail_idx].nmbb041, 
                       g_nmbb_d[g_detail_idx].nmbb044,g_nmbb_d[g_detail_idx].nmbb002,g_nmbb_d[g_detail_idx].nmbb010, 
                       g_nmbb_d[g_detail_idx].nmbblegl,g_nmbb_d[g_detail_idx].nmbb045,g_nmbb_d[g_detail_idx].nmbb029, 
                       g_nmbb_d[g_detail_idx].nmbb039,g_nmbb_d[g_detail_idx].nmbb001,g_nmbb_d[g_detail_idx].nmbb011, 
                       g_nmbb_d[g_detail_idx].nmbb012,g_nmbb_d[g_detail_idx].nmbb013,g_nmbb_d[g_detail_idx].nmbb014, 
                       g_nmbb_d[g_detail_idx].nmbb015,g_nmbb_d[g_detail_idx].nmbb016,g_nmbb_d[g_detail_idx].nmbb017, 
                       g_nmbb_d[g_detail_idx].nmbb018,g_nmbb_d[g_detail_idx].nmbb019,g_nmbb_d[g_detail_idx].nmbb020, 
                       g_nmbb_d[g_detail_idx].nmbb021,g_nmbb_d[g_detail_idx].nmbb022,g_nmbb_d[g_detail_idx].nmbb023, 
                       g_nmbb_d[g_detail_idx].nmbb024,g_nmbb_d[g_detail_idx].nmbb053,g_nmbb_d[g_detail_idx].nmbb054, 
                       g_nmbb_d[g_detail_idx].nmbb008,g_nmbb_d[g_detail_idx].nmbb009,g_nmbb_d[g_detail_idx].nmbb056, 
                       g_nmbb_d[g_detail_idx].nmbb057,g_nmbb_d[g_detail_idx].nmbb058,g_nmbb_d[g_detail_idx].nmbb059, 
                       g_nmbb_d[g_detail_idx].nmbb060,g_nmbb_d[g_detail_idx].nmbb061,g_nmbb_d[g_detail_idx].nmbb062, 
                       g_nmbb_d[g_detail_idx].nmbb066,g_nmbb_d[g_detail_idx].nmbb067,g_nmbb_d[g_detail_idx].nmbb068, 
                       g_nmbb_d[g_detail_idx].nmbb042,g_nmbb_d[g_detail_idx].nmbb069,g_nmbb_d[g_detail_idx].nmbb025) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "nmbb_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_nmbb_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert2"
      
      #end add-point 
      INSERT INTO nmbu_t
                  (nmbuent,
                   nmbucomp,nmbudocno,
                   nmbuseq
                   ,nmbu001,nmbuorga,nmbu003,nmbu004,nmbu005,nmbu006,nmbu007,nmbu002) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_nmbb3_d[g_detail_idx].nmbu001,g_nmbb3_d[g_detail_idx].nmbuorga,g_nmbb3_d[g_detail_idx].nmbu003, 
                       g_nmbb3_d[g_detail_idx].nmbu004,g_nmbb3_d[g_detail_idx].nmbu005,g_nmbb3_d[g_detail_idx].nmbu006, 
                       g_nmbb3_d[g_detail_idx].nmbu007,g_nmbb3_d[g_detail_idx].nmbu002)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "nmbu_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_nmbb3_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert2"
      
      #end add-point
   END IF
 
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="anmt540.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION anmt540_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "nmbb_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL anmt540_nmbb_t_mask_restore('restore_mask_o')
               
      UPDATE nmbb_t 
         SET (nmbbcomp,nmbbdocno,
              nmbbseq
              ,nmbborga,nmbb026,nmbb027,nmbb028,nmbb003,nmbb030,nmbb043,nmbb073,nmbb031,nmbb004,nmbb005,nmbb006,nmbb007,nmbb040,nmbb041,nmbb044,nmbb002,nmbb010,nmbblegl,nmbb045,nmbb029,nmbb039,nmbb001,nmbb011,nmbb012,nmbb013,nmbb014,nmbb015,nmbb016,nmbb017,nmbb018,nmbb019,nmbb020,nmbb021,nmbb022,nmbb023,nmbb024,nmbb053,nmbb054,nmbb008,nmbb009,nmbb056,nmbb057,nmbb058,nmbb059,nmbb060,nmbb061,nmbb062,nmbb066,nmbb067,nmbb068,nmbb042,nmbb069,nmbb025) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_nmbb_d[g_detail_idx].nmbborga,g_nmbb_d[g_detail_idx].nmbb026,g_nmbb_d[g_detail_idx].nmbb027, 
                  g_nmbb_d[g_detail_idx].nmbb028,g_nmbb_d[g_detail_idx].nmbb003,g_nmbb_d[g_detail_idx].nmbb030, 
                  g_nmbb_d[g_detail_idx].nmbb043,g_nmbb_d[g_detail_idx].nmbb073,g_nmbb_d[g_detail_idx].nmbb031, 
                  g_nmbb_d[g_detail_idx].nmbb004,g_nmbb_d[g_detail_idx].nmbb005,g_nmbb_d[g_detail_idx].nmbb006, 
                  g_nmbb_d[g_detail_idx].nmbb007,g_nmbb_d[g_detail_idx].nmbb040,g_nmbb_d[g_detail_idx].nmbb041, 
                  g_nmbb_d[g_detail_idx].nmbb044,g_nmbb_d[g_detail_idx].nmbb002,g_nmbb_d[g_detail_idx].nmbb010, 
                  g_nmbb_d[g_detail_idx].nmbblegl,g_nmbb_d[g_detail_idx].nmbb045,g_nmbb_d[g_detail_idx].nmbb029, 
                  g_nmbb_d[g_detail_idx].nmbb039,g_nmbb_d[g_detail_idx].nmbb001,g_nmbb_d[g_detail_idx].nmbb011, 
                  g_nmbb_d[g_detail_idx].nmbb012,g_nmbb_d[g_detail_idx].nmbb013,g_nmbb_d[g_detail_idx].nmbb014, 
                  g_nmbb_d[g_detail_idx].nmbb015,g_nmbb_d[g_detail_idx].nmbb016,g_nmbb_d[g_detail_idx].nmbb017, 
                  g_nmbb_d[g_detail_idx].nmbb018,g_nmbb_d[g_detail_idx].nmbb019,g_nmbb_d[g_detail_idx].nmbb020, 
                  g_nmbb_d[g_detail_idx].nmbb021,g_nmbb_d[g_detail_idx].nmbb022,g_nmbb_d[g_detail_idx].nmbb023, 
                  g_nmbb_d[g_detail_idx].nmbb024,g_nmbb_d[g_detail_idx].nmbb053,g_nmbb_d[g_detail_idx].nmbb054, 
                  g_nmbb_d[g_detail_idx].nmbb008,g_nmbb_d[g_detail_idx].nmbb009,g_nmbb_d[g_detail_idx].nmbb056, 
                  g_nmbb_d[g_detail_idx].nmbb057,g_nmbb_d[g_detail_idx].nmbb058,g_nmbb_d[g_detail_idx].nmbb059, 
                  g_nmbb_d[g_detail_idx].nmbb060,g_nmbb_d[g_detail_idx].nmbb061,g_nmbb_d[g_detail_idx].nmbb062, 
                  g_nmbb_d[g_detail_idx].nmbb066,g_nmbb_d[g_detail_idx].nmbb067,g_nmbb_d[g_detail_idx].nmbb068, 
                  g_nmbb_d[g_detail_idx].nmbb042,g_nmbb_d[g_detail_idx].nmbb069,g_nmbb_d[g_detail_idx].nmbb025)  
 
         WHERE nmbbent = g_enterprise AND nmbbcomp = ps_keys_bak[1] AND nmbbdocno = ps_keys_bak[2] AND nmbbseq = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "nmbb_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "nmbb_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL anmt540_nmbb_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
      
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
   
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "nmbu_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update2"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL anmt540_nmbu_t_mask_restore('restore_mask_o')
               
      UPDATE nmbu_t 
         SET (nmbucomp,nmbudocno,
              nmbuseq
              ,nmbu001,nmbuorga,nmbu003,nmbu004,nmbu005,nmbu006,nmbu007,nmbu002) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_nmbb3_d[g_detail_idx].nmbu001,g_nmbb3_d[g_detail_idx].nmbuorga,g_nmbb3_d[g_detail_idx].nmbu003, 
                  g_nmbb3_d[g_detail_idx].nmbu004,g_nmbb3_d[g_detail_idx].nmbu005,g_nmbb3_d[g_detail_idx].nmbu006, 
                  g_nmbb3_d[g_detail_idx].nmbu007,g_nmbb3_d[g_detail_idx].nmbu002) 
         WHERE nmbuent = g_enterprise AND nmbucomp = ps_keys_bak[1] AND nmbudocno = ps_keys_bak[2] AND nmbuseq = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update2"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "nmbu_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "nmbu_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL anmt540_nmbu_t_mask_restore('restore_mask_n')
 
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
 
{<section id="anmt540.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION anmt540_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="anmt540.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION anmt540_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="anmt540.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION anmt540_lock_b(ps_table,ps_page)
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
   #CALL anmt540_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "nmbb_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN anmt540_bcl USING g_enterprise,
                                       g_nmba_m.nmbacomp,g_nmba_m.nmbadocno,g_nmbb_d[g_detail_idx].nmbbseq  
                                               
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "anmt540_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
                                    
   #鎖定整組table
   #LET ls_group = "'2',"
   #僅鎖定自身table
   LET ls_group = "nmbu_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN anmt540_bcl2 USING g_enterprise,
                                             g_nmba_m.nmbacomp,g_nmba_m.nmbadocno,g_nmbb3_d[g_detail_idx].nmbuseq 
 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "anmt540_bcl2:",SQLERRMESSAGE 
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
 
{<section id="anmt540.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION anmt540_unlock_b(ps_table,ps_page)
   #add-point:unlock_b段define(客製用) name="unlock_b.define_customerization"
   
   #end add-point  
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:unlock_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="unlock_b.define"
   LET ls_group = "'3',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE anmt540_bcl3
   END IF
   #end add-point  
   
   #add-point:Function前置處理  name="unlock_b.pre_function"
   
   #end add-point
    
   LET ls_group = "'1',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE anmt540_bcl
   END IF
   
   LET ls_group = "'2',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE anmt540_bcl2
   END IF
 
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="anmt540.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION anmt540_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("nmbadocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("nmbacomp,nmbadocno",TRUE)
      CALL cl_set_comp_entry("nmbadocdt",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      CALL cl_set_comp_entry("nmbasite,nmbacomp,nmbadocdt",TRUE)   #150707-00001#7
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
 
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="anmt540.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION anmt540_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   DEFINE l_success   LIKE type_t.num5   #151130-00015#2 
   DEFINE l_slip      LIKE type_t.chr10  #151130-00015#2
   DEFINE l_dfin0033  LIKE type_t.chr80  #151130-00015#2
   DEFINE l_para_date LIKE type_t.dat    #150813-00015#14 add
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("nmbacomp,nmbadocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
 
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("nmbadocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("nmbadocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   #150707-00001#7--(s)
   IF p_cmd = 'u' THEN
      CALL cl_set_comp_entry("nmbasite,nmbacomp,nmbadocdt",FALSE)   
   END IF
   #150707-00001#7--(e)
   #151130-00015#2 -begin -add by XZG 20151218
#   IF NOT cl_null(g_nmba_m.nmbadocno) THEN  #150813-00015#14 mark
   IF NOT cl_null(g_nmba_m.nmbadocno) AND p_cmd = 'u' THEN    #150813-00015#14 add
      #获取单别
      CALL s_aooi200_fin_get_slip(g_nmba_m.nmbadocno) RETURNING l_success,l_slip
      #是否可改日期
      CALL s_fin_get_doc_para(g_glaald,g_nmba_m.nmbacomp,l_slip,'D-FIN-0033') RETURNING l_dfin0033
      #抓取关帐日期
      CALL cl_get_para(g_enterprise,g_nmba_m.nmbacomp,'S-FIN-4007') RETURNING l_para_date #150813-00015#14 add
#      IF l_dfin0033 = "N"  THEN  #150813-00015#14 mark
      IF l_dfin0033 = "N" AND g_nmba_m.nmbadocdt <= l_para_date THEN  #150813-00015#14 add
         CALL cl_set_comp_entry("nmbadocdt",FALSE)
      ELSE 
         CALL cl_set_comp_entry("nmbadocdt",TRUE)
      END IF          
   END IF 
   #151130-00015#2  -end 
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="anmt540.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION anmt540_set_entry_b(p_cmd)
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
   IF g_nmbb_d[l_ac].nmbb029 = '30' THEN 
      CALL cl_set_comp_entry("nmbb040",TRUE)
   END IF
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="anmt540.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION anmt540_set_no_entry_b(p_cmd)
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
   IF g_nmbb_d[l_ac].nmbb029 <> '30' THEN 
      CALL cl_set_comp_entry("nmbb040",FALSE)
      LET g_nmbb_d[l_ac].nmbb040 = 'N'
   END IF
   
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="anmt540.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION anmt540_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   CALL cl_set_act_visible("modify,delete,modify_detail", TRUE)
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="anmt540.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION anmt540_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   IF g_nmba_m.nmbastus <> 'N' THEN   
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="anmt540.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION anmt540_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="anmt540.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION anmt540_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="anmt540.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION anmt540_default_search()
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
      LET ls_wc = ls_wc, " nmbacomp = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " nmbadocno = '", g_argv[02], "' AND "
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
 
 
         FOR li_idx = 1 TO la_wc.getLength()
            CASE
               WHEN la_wc[li_idx].tableid = "nmba_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "nmbb_t" 
                  LET g_wc2_table1 = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "nmbu_t" 
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
 
{<section id="anmt540.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION anmt540_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_today       DATETIME YEAR TO SECOND
   DEFINE l_n           LIKE type_t.num5
   DEFINE l_sql         STRING
   DEFINE l_efin5001    LIKE type_t.chr1
   DEFINE l_ooba002     LIKE ooba_t.ooba002
   DEFINE l_glaald      LIKE glaa_t.glaald
   DEFINE l_success     LIKE type_t.num5
#R
#   #151013-00016#3---s
#   DEFINE l_nmbb029  LIKE nmbb_t.nmbb029
#   DEFINE l_cnt      LIKE type_t.num10
#   DEFINE ls_js      STRING
#   DEFINE lc_param   RECORD
#            xmab003  LIKE xmab_t.xmab003,          #單據編號
#            xmab006  LIKE xmab_t.xmab006,          #交易客戶
#            xmab007  LIKE xmab_t.xmab007,          #交易幣別
#            proj     LIKE xmaa_t.xmaa002,          #目前計算項目
#            proj_o   LIKE xmaa_t.xmaa002,          #前置計算項目
#            type     LIKE type_t.num5,             #正負向
#            glaald   LIKE glaa_t.glaald,           #帳套
#            glaacomp LIKE glaa_t.glaacomp,         #法人
#            xmab004  LIKE xmab_t.xmab004           #單據項次
#                 END RECORD
#   #151013-00016#3---e

   DEFINE l_conf        LIKE type_t.chr1   #151127-00006#2 add
   DEFINE l_slip        LIKE type_t.chr20  #151127-00006#2 add
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_nmba_m.nmbacomp IS NULL
      OR g_nmba_m.nmbadocno IS NULL
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN anmt540_cl USING g_enterprise,g_nmba_m.nmbacomp,g_nmba_m.nmbadocno
   IF STATUS THEN
      CLOSE anmt540_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN anmt540_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE anmt540_master_referesh USING g_nmba_m.nmbacomp,g_nmba_m.nmbadocno INTO g_nmba_m.nmbasite, 
       g_nmba_m.nmba008,g_nmba_m.nmba001,g_nmba_m.nmbacomp,g_nmba_m.nmba002,g_nmba_m.nmbadocno,g_nmba_m.nmbadocdt, 
       g_nmba_m.nmba003,g_nmba_m.nmba004,g_nmba_m.nmba005,g_nmba_m.nmba006,g_nmba_m.nmbastus,g_nmba_m.nmbaownid, 
       g_nmba_m.nmbaowndp,g_nmba_m.nmbacrtid,g_nmba_m.nmbacrtdp,g_nmba_m.nmbacrtdt,g_nmba_m.nmbamodid, 
       g_nmba_m.nmbamoddt,g_nmba_m.nmbacnfid,g_nmba_m.nmbacnfdt,g_nmba_m.nmbasite_desc,g_nmba_m.nmba008_desc, 
       g_nmba_m.nmba001_desc,g_nmba_m.nmbacomp_desc,g_nmba_m.nmbaownid_desc,g_nmba_m.nmbaowndp_desc, 
       g_nmba_m.nmbacrtid_desc,g_nmba_m.nmbacrtdp_desc,g_nmba_m.nmbamodid_desc,g_nmba_m.nmbacnfid_desc 
 
   
 
   #檢查是否允許此動作
   IF NOT anmt540_action_chk() THEN
      CLOSE anmt540_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_nmba_m.nmbasite,g_nmba_m.nmbasite_desc,g_nmba_m.nmba008,g_nmba_m.nmba008_desc,g_nmba_m.nmba001, 
       g_nmba_m.nmba001_desc,g_nmba_m.nmbacomp,g_nmba_m.nmbacomp_desc,g_nmba_m.nmba002,g_nmba_m.nmbadocno, 
       g_nmba_m.nmbadocno_desc,g_nmba_m.nmbadocdt,g_nmba_m.nmba003,g_nmba_m.nmba004,g_nmba_m.nmba005, 
       g_nmba_m.nmba006,g_nmba_m.nmbastus,g_nmba_m.nmbaownid,g_nmba_m.nmbaownid_desc,g_nmba_m.nmbaowndp, 
       g_nmba_m.nmbaowndp_desc,g_nmba_m.nmbacrtid,g_nmba_m.nmbacrtid_desc,g_nmba_m.nmbacrtdp,g_nmba_m.nmbacrtdp_desc, 
       g_nmba_m.nmbacrtdt,g_nmba_m.nmbamodid,g_nmba_m.nmbamodid_desc,g_nmba_m.nmbamoddt,g_nmba_m.nmbacnfid, 
       g_nmba_m.nmbacnfid_desc,g_nmba_m.nmbacnfdt
 
   CASE g_nmba_m.nmbastus
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
      WHEN "V"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/verify.png")
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
         CASE g_nmba_m.nmbastus
            
            WHEN "N"
               HIDE OPTION "unconfirmed"
            WHEN "Y"
               HIDE OPTION "confirmed"
            WHEN "V"
               HIDE OPTION "verify"
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
      #151127-00006#2--mod--str--
      LET l_conf = 'Y'
      CALL s_aooi200_fin_get_slip(g_nmba_m.nmbadocno) RETURNING l_success,l_slip
      IF l_success = FALSE THEN
         CLOSE anmt540_cl
         CALL s_transaction_end('N','0')
         RETURN
      ELSE
         SELECT glaald INTO g_glaald  FROM glaa_t
          WHERE glaaent = g_enterprise 
            AND glaacomp = g_nmba_m.nmbacomp
            AND glaa014 = 'Y'
         #獲取單據別對應參數：收款審核是否分開審核
         CALL s_fin_get_doc_para(g_glaald,g_nmba_m.nmbacomp,l_slip,'D-FIN-4004') RETURNING l_conf  
      END IF 
      IF l_conf = 'N' THEN #不分开审核，即在anmt540直接复核，状态码=V
         HIDE OPTION "confirmed"
         CALL cl_set_act_visible("unconfirmed,invalid,verify",TRUE)
      ELSE                 #分开审核，即在anmt540审核，状态码=Y，在anmt550中复核，状态码=V
         HIDE OPTION "verify"
         CALL cl_set_act_visible("unconfirmed,invalid,confirmed",TRUE)
      END IF
      #151127-00006#2--mod--end
      #150707-00001#7--(s)
      CALL cl_set_act_visible("signing,withdraw",FALSE)
#      CALL cl_set_act_visible("unconfirmed,invalid,confirmed",TRUE) #151127-00006#2 mark
      CALL cl_set_act_visible("closed",FALSE)
      
      CASE g_nmba_m.nmbastus
         WHEN "N"
            CALL cl_set_act_visible("unconfirmed,hold",FALSE)
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            IF cl_bpm_chk() THEN
                CALL cl_set_act_visible("signing",TRUE)
                CALL cl_set_act_visible("confirmed",FALSE)
            END IF

         WHEN "R"   #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed,verify",FALSE)   #151127-00006#2 add verify
 
         WHEN "D"   #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed,verify",FALSE)   #151127-00006#2 add verify

         WHEN "X"
            CLOSE anmt540_cl  #150813-00015#14 add
            CALL s_transaction_end('N','0')      #150401-00001#13
            RETURN

         WHEN "Y"
            CALL cl_set_act_visible("invalid,confirmed",FALSE)
            
         WHEN "V"
            CALL cl_set_act_visible("invalid,verify",FALSE)

         WHEN "W"    #只能顯示抽單;其餘應用功能皆隱藏
             CALL cl_set_act_visible("withdraw",TRUE)
             CALL cl_set_act_visible("unconfirmed,invalid,confirmed,verify",FALSE) #151127-00006#2 add verify

         WHEN "A"     #只能顯示確認; 其餘應用功能皆隱藏
             #151127-00006#2--mod--str--
             IF l_conf = 'N' THEN
                CALL cl_set_act_visible("verify",TRUE)
             ELSE
                CALL cl_set_act_visible("confirmed",TRUE)
             END IF
             #151127-00006#2--mod--end
             CALL cl_set_act_visible("unconfirmed,invalid",FALSE)
      END CASE      
      #150707-00001#7--(e)
      #end add-point
      
      #應用 a36 樣板自動產生(Version:5)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT anmt540_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE anmt540_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT anmt540_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE anmt540_cl
            RETURN
         END IF
 
 
 
	  
      ON ACTION unconfirmed
         IF cl_auth_chk_act("unconfirmed") THEN
            LET lc_state = "N"
            #add-point:action控制 name="statechange.unconfirmed"
            #151013-00016#7 151104 by sakura mark(S)
            #IF g_nmba_m.nmbastus = 'V' THEN 
            #   INITIALIZE g_errparam TO NULL
            #   LET g_errparam.code = 'anm-00054'
            #   LET g_errparam.extend = g_nmba_m.nmbadocno
            #   LET g_errparam.popup = TRUE
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')      #150401-00001#13
            #   RETURN
            #END IF
            #151013-00016#7 151104 by sakura mark(S)            
            #end add-point
         END IF
         EXIT MENU
      ON ACTION confirmed
         IF cl_auth_chk_act("confirmed") THEN
            LET lc_state = "Y"
            #add-point:action控制 name="statechange.confirmed"
            #151013-00016#7 151104 by sakura mark(S)
            #IF g_nmba_m.nmbastus = 'X' THEN 
            #   INITIALIZE g_errparam TO NULL
            #   LET g_errparam.code = 'anm-00044'
            #   LET g_errparam.extend = g_nmba_m.nmbadocno
            #   LET g_errparam.popup = TRUE
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')      #150401-00001#13
            #   RETURN
            #END IF 
            #IF g_nmba_m.nmbastus = 'V' THEN 
            #   INITIALIZE g_errparam TO NULL
            #   LET g_errparam.code = 'anm-00054'
            #   LET g_errparam.extend = g_nmba_m.nmbadocno
            #   LET g_errparam.popup = TRUE
            #   CALL cl_err() 
            #   CALL s_transaction_end('N','0')      #150401-00001#13
            #   RETURN
            #END IF 
            #
            # #150602-00057#2 by 02291 add
            # SELECT glaald INTO l_glaald FROM glaa_t
            #     WHERE glaaent = g_enterprise AND glaacomp = g_nmba_m.nmbacomp
            #       AND glaa014 = 'Y'
            # CALL s_aooi200_fin_get_slip(g_nmba_m.nmbadocno) RETURNING l_success,l_ooba002
            # CALL s_fin_chk_E5001(l_glaald,g_nmba_m.nmbacomp,l_ooba002) RETURNING l_efin5001
            # IF l_efin5001 = 'N' THEN
            #    IF g_nmba_m.nmbacrtid = g_user THEN
            #       INITIALIZE g_errparam TO NULL
            #       LET g_errparam.code = 'axr-00346'
            #       LET g_errparam.extend = ''
            #       LET g_errparam.popup = TRUE
            #       CALL cl_err()
            #       CALL s_transaction_end('N','0')
            #       CLOSE anmt540_cl
            #       RETURN
            #    END IF
            # END IF 
            # #150602-00057#2 by 02291 add
            #
            #LET l_n = 0
            #SELECT count(*) INTO l_n
            #  FROM nmbb_t
            # WHERE nmbbent = g_enterprise
            #   AND nmbbdocno = g_nmba_m.nmbadocno
            #   AND nmbbcomp = g_nmba_m.nmbacomp
            #IF l_n = 0 THEN 
            #   INITIALIZE g_errparam TO NULL
            #   LET g_errparam.code = 'aec-00020'
            #   LET g_errparam.extend = g_nmba_m.nmbadocno
            #   LET g_errparam.popup = TRUE
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')      #150401-00001#13
            #   RETURN
            #END IF
            #
            #LET l_n = 0
            #SELECT count(*) INTO l_n
            #  FROM nmbu_t
            # WHERE nmbuent = g_enterprise
            #   AND nmbudocno = g_nmba_m.nmbadocno
            #   AND nmbucomp = g_nmba_m.nmbacomp
            ##IF l_n = 0 THEN 
            ##   INITIALIZE g_errparam TO NULL
            ##   LET g_errparam.code = 'anm-00089'
            ##   LET g_errparam.extend = g_nmba_m.nmbadocno
            ##   LET g_errparam.popup = TRUE
            ##   CALL cl_err()
            ##
            ##   RETURN
            ##END IF
            #
            #IF l_n > 0 THEN 
            #   #檢查繳款來源頁籤金額和繳款單金額相同對象的 金額是否相同, 不同則不可確認
            #   LET l_n = 0
            #   LET g_sql = " SELECT count(*) FROM ",
            #               " ( ",
            #               "   SELECT doc,a,SUM(b) a1,SUM(c) a2 ",
            #               "     FROM ( (  SELECT nmbbdocno doc,nmbb026 a, SUM (nmbb006) b,0 c ",
            #               "                 FROM nmbb_t a ",
            #               "                WHERE nmbbent = '",g_enterprise,"'",
            #               "                  AND nmbbdocno = '",g_nmba_m.nmbadocno,"'",
            #               "                  AND nmbbcomp = '",g_nmba_m.nmbacomp,"'",
            #               "             GROUP BY nmbbdocno,nmbb026) ",
            #               "             UNION ",
            #               "             (  SELECT nmbudocno doc,nmbu001 a,0 b,SUM (nmbu007) c ",
            #               "                  FROM nmbu_t b ",
            #               "                 WHERE nmbuent = '",g_enterprise,"'",
            #               "                   AND nmbudocno = '",g_nmba_m.nmbadocno,"'",
            #               "                   AND nmbucomp = '",g_nmba_m.nmbacomp,"'",
            #               "              GROUP BY nmbudocno,nmbu001) ",
            #               "           ) ",
            #               " GROUP BY doc,a ",
            #               " ) ",
            #               " WHERE a1 <> a2 "
            #   PREPARE anmt540_pre FROM g_sql
            #   EXECUTE anmt540_pre INTO l_n
            #   IF l_n > 0 THEN 
            #      INITIALIZE g_errparam TO NULL
            #      LET g_errparam.code = 'anm-00088'
            #      LET g_errparam.extend = g_nmba_m.nmbadocno
            #      LET g_errparam.popup = TRUE
            #      CALL cl_err()
            #      CALL s_transaction_end('N','0')      #150401-00001#13
            #      RETURN
            #   END IF
            #END IF
            #151013-00016#7 151104 by sakura mark(E)
            #end add-point
         END IF
         EXIT MENU
      ON ACTION verify
         IF cl_auth_chk_act("verify") THEN
            LET lc_state = "V"
            #add-point:action控制 name="statechange.verify"
            
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
            #151013-00016#7 151104 by sakura mark(S)
            #IF g_nmba_m.nmbastus = 'Y' THEN 
            #   INITIALIZE g_errparam TO NULL
            #   LET g_errparam.code = 'anm-00045'
            #   LET g_errparam.extend = g_nmba_m.nmbadocno
            #   LET g_errparam.popup = TRUE
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')      #150401-00001#13
            #   RETURN
            #END IF 
            #IF g_nmba_m.nmbastus = 'V' THEN 
            #   INITIALIZE g_errparam TO NULL
            #   LET g_errparam.code = 'anm-00055'
            #   LET g_errparam.extend = g_nmba_m.nmbadocno
            #   LET g_errparam.popup = TRUE
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')      #150401-00001#13
            #   RETURN
            #END IF 
            ##150707-00001#7--(s)
            #IF NOT cl_ask_confirm('aim-00109') THEN
            #   CALL s_transaction_end('N','0')
            #   RETURN
            #END IF
            ##150707-00001#7--(e)
            #151013-00016#7 151104 by sakura mark(E)            
            #end add-point
         END IF
         EXIT MENU
 
      #add-point:stus控制 name="statechange.more_control"
#R
#      #151013-00016#3---s
#      ON ACTION unverify
#         LET lc_state = "Y"         
#         IF g_nmba_m.nmbastus <> 'V' THEN 
#            INITIALIZE g_errparam TO NULL
#            LET g_errparam.code = 'anm-00056'
#            LET g_errparam.extend = g_nmba_m.nmbadocno
#            LET g_errparam.popup = TRUE
#            CALL cl_err()
#            CALL s_transaction_end('N','0')
#            RETURN
#         END IF
#        
#         LET l_cnt = 0 
#         SELECT COUNT(*) INTO l_cnt FROM xrde_t
#          WHERE xrdeent = g_enterprise AND xrde003 = g_nmba_m.nmbadocno
#         IF l_cnt > 0 THEN
#            INITIALIZE g_errparam TO NULL
#            LET g_errparam.code = 'anm-02954'
#            LET g_errparam.extend = g_nmba_m.nmbadocno
#            LET g_errparam.popup = TRUE
#            CALL cl_err()
#            CALL s_transaction_end('N','0')
#            RETURN
#         END IF
#
#         LET l_cnt = 0
#         SELECT COUNT(*) INTO l_cnt FROM nmbt_t WHERE nmbtent = g_enterprise
#                                                  AND nmbt001 = '4'
#                                                  AND nmbt002 = g_nmba_m.nmbadocno
#         IF l_cnt > 0 THEN
#            INITIALIZE g_errparam TO NULL
#            LET g_errparam.code = 'anm-00297'
#            LET g_errparam.extend = g_nmba_m.nmbadocno
#            LET g_errparam.popup = TRUE
#            CALL cl_err()
#            CALL s_transaction_end('N','0')      
#            RETURN         
#         END IF          
#
#         LET lc_param.xmab003  = g_nmba_m.nmbadocno
#         LET lc_param.glaacomp = g_nmba_m.nmbacomp
#         LET lc_param.type   = '2'    #1:正向 2:負向
#         LET l_sql = " SELECT nmbbseq,nmbb026,nmbb004,nmbb029 ",
#                     "   FROM nmbb_t ",
#                     "  WHERE nmbbent = ",g_enterprise,
#                     "    AND nmbbcomp= '",g_nmba_m.nmbacomp,"' AND nmbbdocno = '",g_nmba_m.nmbadocno,"'"
#         PREPARE anmt540_credit_p2 FROM l_sql
#         DECLARE anmt540_credit_c2 CURSOR FOR anmt540_credit_p2
#         FOREACH anmt540_credit_c2 INTO lc_param.xmab004,lc_param.xmab006,lc_param.xmab007,l_nmbb029
#            IF NOT cl_null(lc_param.xmab004) AND NOT cl_null(lc_param.xmab006) THEN
#               IF l_nmbb029 = '30' THEN            
#                  LET lc_param.proj   = 'S9'    
#               ELSE                             
#                  LET lc_param.proj   = 'S8'     
#               END IF                           
#               LET ls_js = util.JSON.stringify(lc_param)
#               CALL s_credit_move(ls_js)  RETURNING g_sub_success
#               IF NOT g_sub_success THEN
#                  CALL s_transaction_end('N','0')
#                  CLOSE anmt540_cl
#                  RETURN
#               END IF
#            END IF
#         END FOREACH
#      #151013-00016#3---e
      #end add-point
      
   END MENU
   
   #確認被選取的狀態碼在清單中
   IF (lc_state <> "N" 
      AND lc_state <> "Y"
      AND lc_state <> "V"
      AND lc_state <> "A"
      AND lc_state <> "D"
      AND lc_state <> "R"
      AND lc_state <> "W"
      AND lc_state <> "X"
      ) OR 
      g_nmba_m.nmbastus = lc_state OR cl_null(lc_state) THEN
      CLOSE anmt540_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   #151013-00016#7 151104 by sakura mark(S)
   #IF lc_state = 'Y' THEN 
   #   LET l_today  = cl_get_current() 
   #   LET g_nmba_m.nmbacnfid = g_user
   #   LET g_nmba_m.nmbacnfdt = l_today
   #   UPDATE nmba_t SET nmbacnfid = g_user,
   #                     nmbacnfdt = l_today
   #    WHERE nmbaent = g_enterprise 
   #      AND nmbacomp = g_nmba_m.nmbacomp
   #      AND nmbadocno = g_nmba_m.nmbadocno
   #      
   #   IF SQLCA.sqlcode THEN
   #      INITIALIZE g_errparam TO NULL
   #      LET g_errparam.code = SQLCA.sqlcode
   #      LET g_errparam.extend = ""
   #      LET g_errparam.popup = FALSE
   #      CALL cl_err()
   #      CALL s_transaction_end('N','1')
   #      RETURN
   #   ELSE
   #      CALL s_transaction_end('Y','1')
   #   END IF
   #END IF
   #IF lc_state = 'N' THEN
   #   LET g_nmba_m.nmbacnfid = ''
   #   LET g_nmba_m.nmbacnfdt = ''
   #   UPDATE nmba_t SET nmbacnfid = '',
   #                     nmbacnfdt = ''
   #    WHERE nmbaent = g_enterprise 
   #      AND nmbacomp = g_nmba_m.nmbacomp
   #      AND nmbadocno = g_nmba_m.nmbadocno
   #
   #   IF SQLCA.sqlcode THEN
   #      INITIALIZE g_errparam TO NULL
   #      LET g_errparam.code = SQLCA.sqlcode
   #      LET g_errparam.extend = ""
   #      LET g_errparam.popup = FALSE
   #      CALL cl_err()
   #      CALL s_transaction_end('N','1')
   #      RETURN
   #   ELSE
   #      CALL s_transaction_end('Y','1')
   #   END IF
   #END IF
   #151013-00016#7 151104 by sakura mark(E)
#R
#   #151013-00016#3---s
#   IF lc_state = 'V' THEN 
#   ELSE                 
#      UPDATE nmba_t SET nmba009 = '',nmba002 = ''    
#       WHERE nmbaent = g_enterprise 
#         AND nmbacomp = g_nmba_m.nmbacomp
#         AND nmbadocno = g_nmba_m.nmbadocno
#
#      CALL anmt540_nmbc_delete()
#      IF g_success = 'Y' THEN
#         CALL s_transaction_end('Y','1')
#      END IF
#      IF g_success = 'N' THEN
#         CALL cl_err_collect_show()
#         CALL s_transaction_end('N','1')
#         RETURN
#      END IF
#   END IF
#   #151013-00016#3---e

   #151013-00016#7 151104 by sakura add(S)
   CALL cl_err_collect_init()
   #確認
   IF lc_state = 'Y' THEN
      IF g_nmba_m.nmbastus = 'N' THEN
         CALL s_anmt540_conf_chk(g_nmba_m.nmbacomp,g_nmba_m.nmbadocno) RETURNING g_sub_success
         IF NOT g_sub_success THEN
            CALL s_transaction_end('N','0')
            CALL cl_err_collect_show()
            RETURN
         ELSE
            IF NOT cl_ask_confirm('aim-00108') THEN   #是否執行確認？
               CALL s_transaction_end('N','0')
               CALL cl_err_collect_show()
               RETURN
            ELSE
               CALL s_transaction_begin()
               CALL s_anmt540_conf_upd(g_nmba_m.nmbacomp,g_nmba_m.nmbadocno) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  CALL s_transaction_end('N','0')
                  CALL cl_err_collect_show()
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','0')
                  CALL cl_err_collect_show()
               END IF
            END IF
         END IF
      END IF 
      #161227-00022#1 add s---      
      IF g_nmba_m.nmbastus = 'V' THEN
         CALL s_anmt540_unverify_chk(g_nmba_m.nmbacomp,g_nmba_m.nmbadocno) RETURNING g_sub_success
         IF NOT g_sub_success THEN
            CALL s_transaction_end('N','0')
            CALL cl_err_collect_show()
            RETURN
         ELSE
            IF NOT cl_ask_confirm('aim-00108') THEN   #是否執行確認？
               CALL s_transaction_end('N','0')
               CALL cl_err_collect_show()
               RETURN
            ELSE
               CALL s_transaction_begin()
               CALL s_anmt540_unverify_upd(g_nmba_m.nmbacomp,g_nmba_m.nmbadocno) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  CALL s_transaction_end('N','0')
                  CALL cl_err_collect_show()
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','0')
                  CALL cl_err_collect_show()
               END IF
            END IF
         END IF
      END IF
      #161227-00022#1 add e---      
   END IF  
   #取消確認
   IF lc_state = 'N' THEN
      #151127-00006#2--mod--str--
      #当收款審核不分開審核时，anmt540直接执行复核，否则在anmt540中审核，在anmt550中复核
      IF l_conf = 'N' THEN 
         CALL s_anmt540_unverify_chk(g_nmba_m.nmbacomp,g_nmba_m.nmbadocno) RETURNING g_sub_success
      ELSE
         CALL s_anmt540_unconf_chk(g_nmba_m.nmbacomp,g_nmba_m.nmbadocno) RETURNING g_sub_success
      END IF
      #151127-00006#2--mod--end
      IF NOT g_sub_success THEN
         CALL s_transaction_end('N','0')
         CALL cl_err_collect_show()
         RETURN
      ELSE
         IF NOT cl_ask_confirm('aim-00110') THEN   #是否執行取消確認？
            CALL s_transaction_end('N','0')
            CALL cl_err_collect_show()
            RETURN
         ELSE
            CALL s_transaction_begin()
            #151127-00006#2--mod--str--
            #当收款審核不分開審核时，anmt540直接执行复核，否则在anmt540中审核，在anmt550中复核
            IF l_conf = 'N' THEN 
               CALL s_anmt540_unverify_upd(g_nmba_m.nmbacomp,g_nmba_m.nmbadocno) RETURNING g_sub_success
            ELSE
               CALL s_anmt540_unconf_upd(g_nmba_m.nmbacomp,g_nmba_m.nmbadocno) RETURNING g_sub_success
            END IF
            #151127-00006#2--mod--end
            IF NOT g_sub_success THEN
               CALL s_transaction_end('N','0')
               CALL cl_err_collect_show()
               RETURN
            ELSE
               CALL s_transaction_end('Y','0')
               CALL cl_err_collect_show()
            END IF
         END IF
      END IF
   END IF
   #作廢
   IF lc_state = 'X' THEN
      CALL s_anmt540_invalid_chk(g_nmba_m.nmbacomp,g_nmba_m.nmbadocno) RETURNING g_sub_success
      IF NOT g_sub_success THEN
         CALL s_transaction_end('N','0')
         CALL cl_err_collect_show()
         RETURN
      ELSE
         IF NOT cl_ask_confirm('aim-00109') THEN   #是否執行作廢？
            CALL s_transaction_end('N','0')
            CALL cl_err_collect_show()
            RETURN
         ELSE
            CALL s_transaction_begin()
            CALL s_anmt540_invalid_upd(g_nmba_m.nmbacomp,g_nmba_m.nmbadocno) RETURNING g_sub_success
            IF NOT g_sub_success THEN
               CALL s_transaction_end('N','0')
               CALL cl_err_collect_show()
               RETURN
            ELSE
               CALL s_transaction_end('Y','0')
               CALL cl_err_collect_show()
            END IF
         END IF
      END IF
   END IF   
   #151013-00016#7 151104 by sakura add(E)
   
   #151127-00006#2--add--str--
   #复核
   IF lc_state = 'V' THEN
      IF g_nmba_m.nmbastus = 'N' THEN
         CALL s_anmt540_verify_chk(g_nmba_m.nmbacomp,g_nmba_m.nmbadocno) RETURNING g_sub_success
         IF NOT g_sub_success THEN
            CALL s_transaction_end('N','0')
            CALL cl_err_collect_show()
            RETURN
         ELSE
            IF NOT cl_ask_confirm('aim-00108') THEN   #是否執行確認？
               CALL s_transaction_end('N','0')
               CALL cl_err_collect_show()
               RETURN
            ELSE
               CALL s_transaction_begin()
               CALL s_anmt540_verify_upd(g_nmba_m.nmbacomp,g_nmba_m.nmbadocno) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  CALL s_transaction_end('N','0')
                  CALL cl_err_collect_show()
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','0')
                  CALL cl_err_collect_show()
               END IF
            END IF
         END IF
      END IF  
   END IF
   #151127-00006#2--add--end
   #end add-point
   
   LET g_nmba_m.nmbamodid = g_user
   LET g_nmba_m.nmbamoddt = cl_get_current()
   LET g_nmba_m.nmbastus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE nmba_t 
      SET (nmbastus,nmbamodid,nmbamoddt) 
        = (g_nmba_m.nmbastus,g_nmba_m.nmbamodid,g_nmba_m.nmbamoddt)     
    WHERE nmbaent = g_enterprise AND nmbacomp = g_nmba_m.nmbacomp
      AND nmbadocno = g_nmba_m.nmbadocno
    
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
         WHEN "V"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/verify.png")
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
      EXECUTE anmt540_master_referesh USING g_nmba_m.nmbacomp,g_nmba_m.nmbadocno INTO g_nmba_m.nmbasite, 
          g_nmba_m.nmba008,g_nmba_m.nmba001,g_nmba_m.nmbacomp,g_nmba_m.nmba002,g_nmba_m.nmbadocno,g_nmba_m.nmbadocdt, 
          g_nmba_m.nmba003,g_nmba_m.nmba004,g_nmba_m.nmba005,g_nmba_m.nmba006,g_nmba_m.nmbastus,g_nmba_m.nmbaownid, 
          g_nmba_m.nmbaowndp,g_nmba_m.nmbacrtid,g_nmba_m.nmbacrtdp,g_nmba_m.nmbacrtdt,g_nmba_m.nmbamodid, 
          g_nmba_m.nmbamoddt,g_nmba_m.nmbacnfid,g_nmba_m.nmbacnfdt,g_nmba_m.nmbasite_desc,g_nmba_m.nmba008_desc, 
          g_nmba_m.nmba001_desc,g_nmba_m.nmbacomp_desc,g_nmba_m.nmbaownid_desc,g_nmba_m.nmbaowndp_desc, 
          g_nmba_m.nmbacrtid_desc,g_nmba_m.nmbacrtdp_desc,g_nmba_m.nmbamodid_desc,g_nmba_m.nmbacnfid_desc 
 
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_nmba_m.nmbasite,g_nmba_m.nmbasite_desc,g_nmba_m.nmba008,g_nmba_m.nmba008_desc, 
          g_nmba_m.nmba001,g_nmba_m.nmba001_desc,g_nmba_m.nmbacomp,g_nmba_m.nmbacomp_desc,g_nmba_m.nmba002, 
          g_nmba_m.nmbadocno,g_nmba_m.nmbadocno_desc,g_nmba_m.nmbadocdt,g_nmba_m.nmba003,g_nmba_m.nmba004, 
          g_nmba_m.nmba005,g_nmba_m.nmba006,g_nmba_m.nmbastus,g_nmba_m.nmbaownid,g_nmba_m.nmbaownid_desc, 
          g_nmba_m.nmbaowndp,g_nmba_m.nmbaowndp_desc,g_nmba_m.nmbacrtid,g_nmba_m.nmbacrtid_desc,g_nmba_m.nmbacrtdp, 
          g_nmba_m.nmbacrtdp_desc,g_nmba_m.nmbacrtdt,g_nmba_m.nmbamodid,g_nmba_m.nmbamodid_desc,g_nmba_m.nmbamoddt, 
          g_nmba_m.nmbacnfid,g_nmba_m.nmbacnfid_desc,g_nmba_m.nmbacnfdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   #151013-00016#7 151104 by sakura mark(S)
   ##151013-00016#6---s
   #CALL s_anm_glbc015_upd(g_glaald,g_nmba_m.nmbadocno,g_nmba_m.nmbadocdt,g_nmba_m.nmbastus) RETURNING l_success
   #IF NOT l_success THEN
   #   CALL s_transaction_end('N','0')
   #   RETURN
   #END IF
   ##151013-00016#6---e
   #151013-00016#7 151104 by sakura mark(E)
   CALL anmt540_show()
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE anmt540_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL anmt540_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="anmt540.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION anmt540_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_nmbb_d.getLength() THEN
         LET g_detail_idx = g_nmbb_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_nmbb_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_nmbb_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx > g_nmbb3_d.getLength() THEN
         LET g_detail_idx = g_nmbb3_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_nmbb3_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_nmbb3_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="anmt540.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION anmt540_b_fill2(pi_idx)
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
   LET g_sql = "SELECT  UNIQUE nmbbseq,nmbb026,'',nmbb028,'',nmbb004,nmbb006,nmbb032,nmbb033,nmbb034,nmbb035,nmbb036,'',nmbb037,nmbb038 FROM nmbb_t",   
                  " INNER JOIN nmba_t ON nmbacomp = nmbbcomp ",
                  " AND nmbadocno = nmbbdocno ",
                  " WHERE nmbbent=? AND nmbbcomp=? AND nmbbdocno=?"
     
   IF NOT cl_null(g_wc2_table3) THEN
      LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table3 CLIPPED
   END IF

   LET g_sql = g_sql, " ORDER BY nmbb_t.nmbbseq"
   
   PREPARE anmt540_pb3 FROM g_sql
   DECLARE b_fill_cs3 CURSOR FOR anmt540_pb3
   
   LET g_cnt = l_ac
   LET l_ac = 1
   
   OPEN b_fill_cs3 USING g_enterprise,g_nmba_m.nmbacomp
                                               ,g_nmba_m.nmbadocno
                                            
   FOREACH b_fill_cs3 INTO g_nmbb2_d[l_ac].nmbbseq,g_nmbb2_d[l_ac].nmbb026_1,
                           g_nmbb2_d[l_ac].nmbb026_1_desc,g_nmbb2_d[l_ac].nmbb028,
                           g_nmbb2_d[l_ac].nmbb028_desc1,g_nmbb2_d[l_ac].nmbb004,
                           g_nmbb2_d[l_ac].nmbb006,g_nmbb2_d[l_ac].nmbb032,
                           g_nmbb2_d[l_ac].nmbb033,g_nmbb2_d[l_ac].nmbb034,
                           g_nmbb2_d[l_ac].nmbb035,g_nmbb2_d[l_ac].nmbb036,
                           g_nmbb2_d[l_ac].nmbb036_desc,
                           g_nmbb2_d[l_ac].nmbb037,g_nmbb2_d[l_ac].nmbb038
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
   
      CALL anmt540_ref_b_2()
   
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec AND g_error_show = 1 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  9035
         LET g_errparam.extend =  ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
   END FOREACH
   LET g_error_show = 0

   CALL g_nmbb2_d.deleteElement(g_nmbb2_d.getLength())

   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE anmt540_pb3
   #end add-point
    
   LET l_ac = li_ac
   
   CALL anmt540_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="anmt540.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION anmt540_fill_chk(ps_idx)
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
 
{<section id="anmt540.status_show" >}
PRIVATE FUNCTION anmt540_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="anmt540.mask_functions" >}
&include "erp/anm/anmt540_mask.4gl"
 
{</section>}
 
{<section id="anmt540.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION anmt540_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
   LET g_wc2_table2 = " 1=1"
 
 
   CALL anmt540_show()
   CALL anmt540_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   #151013-00016#7 151104 by sakura add(S)
   IF NOT s_anmt540_conf_chk(g_nmba_m.nmbacomp,g_nmba_m.nmbadocno) THEN
      CLOSE anmt540_cl
      CALL s_transaction_end('N','0')
      RETURN FALSE
   END IF
   #151013-00016#7 151104 by sakura add(E)
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_nmba_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_nmbb_d))
   CALL cl_bpm_set_detail_data("s_detail3", util.JSONArray.fromFGL(g_nmbb3_d))
 
 
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
   #CALL anmt540_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL anmt540_ui_headershow()
   CALL anmt540_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION anmt540_draw_out()
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
   CALL anmt540_ui_headershow()  
   CALL anmt540_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="anmt540.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION anmt540_set_pk_array()
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
   LET g_pk_array[1].values = g_nmba_m.nmbacomp
   LET g_pk_array[1].column = 'nmbacomp'
   LET g_pk_array[2].values = g_nmba_m.nmbadocno
   LET g_pk_array[2].column = 'nmbadocno'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="anmt540.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="anmt540.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION anmt540_msgcentre_notify(lc_state)
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
   CALL anmt540_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_nmba_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="anmt540.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION anmt540_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="anmt540.other_function" readonly="Y" >}
# nmba008 繳款人員欄位檢查
PRIVATE FUNCTION anmt540_nmba008_chk()
   DEFINE l_ooagstus  LIKE ooag_t.ooagstus

   LET g_errno=''
   SELECT ooagstus INTO l_ooagstus FROM ooag_t
    WHERE ooagent = g_enterprise
      AND ooag001 = g_nmba_m.nmba008

   CASE
      WHEN SQLCA.SQLCODE=100   LET g_errno = 'aoo-00074'
      WHEN l_ooagstus ='N'     LET g_errno = 'sub-01302' #aoo-00071  #160318-00005#28  By 07900 --mod  
   END CASE
   SELECT ooag004 INTO g_nmba_m.nmba001 FROM ooag_t
    WHERE ooagent = g_enterprise #2015/04/02 by 02599 add
      AND ooag001 = g_nmba_m.nmba008
   
   DISPLAY g_nmba_m.nmba001 TO nmba001   
END FUNCTION
# nmbacomp 法人組織欄位檢查
PRIVATE FUNCTION anmt540_nmbacomp_chk()
   DEFINE l_ooefstus         LIKE ooef_t.ooefstus
   DEFINE l_ooef003          LIKE ooef_t.ooef003
   
   LET g_errno = ''
   SELECT ooefstus,ooef003 INTO l_ooefstus,l_ooef003
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_nmba_m.nmbacomp
   
   CASE
      WHEN SQLCA.SQLCODE = 100    LET g_errno = 'aoo-00090'
      WHEN l_ooefstus = 'N'       LET g_errno = 'sub-01302' #aoo-00091 #160318-00005#28  By 07900 --mod
      WHEN l_ooef003 = 'N'        LET g_errno = 'anm-00037'
   END CASE
END FUNCTION
# nmbadocno 繳款單號欄位檢查
PRIVATE FUNCTION anmt540_nmbadocno_chk()
   DEFINE l_n             LIKE type_t.num5 
   
   #判斷資料是否存在   
   LET l_n = 0   
   SELECT count(*) INTO l_n
     FROM ooba_t,oobx_t
    WHERE oobaent = g_enterprise
      AND ooba001 = g_glaa024
      #AND oobx004 = 'anmt540' #150904-00006#1 
      AND oobx004 = g_prog #150904-00006#1 
      AND ooba002 = g_nmba_m.nmbadocno 
      AND oobaent = oobxent
      AND ooba002 = oobx001      
      
   IF l_n = 0 THEN 
      LET g_nmba_m.nmbadocno_desc = ''
      DISPLAY g_nmba_m.nmbadocno_desc TO nmbadocno_desc
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'aim-00056'
      LET g_errparam.extend = g_nmba_m.nmbadocno 
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE
   END IF
   
   #判斷資料是否有效  
   LET l_n = 0   
   SELECT count(*) INTO l_n
     FROM ooba_t,oobx_t
    WHERE oobaent = g_enterprise
      AND ooba001 = g_glaa024
      #AND oobx004 = 'anmt540' 
      AND oobx004 = g_prog #150904-00006#1 
      AND ooba002 = g_nmba_m.nmbadocno  
      AND oobastus = 'Y'
      AND oobaent = oobxent
      AND ooba002 = oobx001  
   
   IF l_n = 0 THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-01302' #aim-00057 #160318-00005#28  By 07900 --mod  
      LET g_errparam.extend = g_nmba_m.nmbadocno
      #160318-00005#28 by 07900 --add--str
      LET g_errparam.replace[1] = 'aooi200'
      LET g_errparam.replace[2] = cl_get_progname("aooi200",g_lang,"2")
      LET g_errparam.exeprog ='aooi200'
      #160318-00005#28 by 07900 --add--end
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE
   END IF
   
   #CALL s_aooi200_get_slip_desc(g_nmba_m.nmbadocno)        #2014/12/29 liuym mark
   CALL s_aooi200_fin_get_slip_desc(g_nmba_m.nmbadocno)     #2014/12/29 liuym add
   RETURNING g_nmba_m.nmbadocno_desc
   DISPLAY g_nmba_m.nmbadocno_desc TO nmbadocno_desc
   
   RETURN TRUE
END FUNCTION
# nmbaorga 來源組織欄位檢查
PRIVATE FUNCTION anmt540_nmbborga_chk()
DEFINE l_ooefstus     LIKE ooef_t.ooefstus
DEFINE r_success      LIKE type_t.num5
DEFINE l_no           LIKE type_t.chr10

   LET g_errno = ''
   LET r_success = TRUE

   #150707-00001#7--(s)
   CALL s_anm_ooef001_chk(g_nmbb_d[l_ac].nmbborga) RETURNING g_sub_success,g_errno         
   IF NOT g_sub_success THEN
      LET r_success = FALSE
      RETURN r_success                 
   END IF  

   #160912-00024#1 add s---
   CALL s_anm_get_site_wc('6',g_nmba_m.nmbasite,g_nmba_m.nmbadocdt) RETURNING g_site_wc
   IF cl_null(g_site_wc) THEN
      LET g_errno = 'anm-03020' #该资金中心下无可用运营据点!
      LET r_success = FALSE
      RETURN r_success
   END IF                  
   #160912-00024#1 add e---
                  
   #檢查輸入組織代碼是否存在法人組織下的組織範圍內(1.與單頭法人組織法人相同2.屬於資金組織3.user具有拜
   IF s_chr_get_index_of(g_site_wc,g_nmbb_d[l_ac].nmbborga,1) = 0 THEN
      LET g_errno   ='axc-00099'
      LET r_success = FALSE
      RETURN r_success
   END IF
     
   #150707-00001#7--(e)
  #150707-00001#7-mark-(s)
  #CALL s_fin_apcborga_chk(g_nmba_m.nmbasite,g_nmba_m.nmbacomp,g_nmbb_d[l_ac].nmbborga,g_nmba_m.nmbadocdt,'6')
  #                 RETURNING g_sub_success,g_errno
  #IF g_errno = 'aap-00120' THEN 
  #  LET g_errno = 'anm-00276'
  #END IF
  #IF g_errno = 'aap-00034' THEN 
  #   LET g_errno = 'anm-00277'
  #END IF
  #150707-00001#7-mark-(e)
#   SELECT ooefstus INTO l_ooefstus
#     FROM ooef_t
#    WHERE ooefent = g_enterprise
#      AND ooef001 = g_nmbb_d[l_ac].nmbborga
#   
#   CASE
#      WHEN SQLCA.SQLCODE = 100    LET g_errno = 'aoo-00090'
#      WHEN l_ooefstus = 'N'       LET g_errno = 'aoo-00091'
#   END CASE
#   

   IF NOT cl_null(g_nmbb_d[l_ac].nmbb028) AND cl_null(g_errno) THEN 
      CALL s_money_chk('2',g_nmbb_d[l_ac].nmbborga,g_nmbb_d[l_ac].nmbb028) RETURNING g_sub_success,g_errno,l_no,g_ooia002
      IF NOT g_sub_success THEN 
         LET r_success = FALSE
         RETURN r_success
      ELSE
         IF  g_ooia002 != '10'
         AND g_ooia002 != '20'      
         AND g_ooia002 != '30'
         AND g_ooia002 != '40'
         AND g_ooia002 != '50' THEN 
            LET g_errno = 'aoo-00399'
            LET r_success = FALSE
            RETURN r_success
         END IF 
      END IF 
   END IF  
   CALL anmt540_nmbblegl_get(g_nmbb_d[l_ac].nmbborga)
   DISPLAY g_nmbb_d[l_ac].nmbblegl TO s_detail1[l_ac].nmbblegl
   RETURN r_success
END FUNCTION
# 單身參考欄位帶值
PRIVATE FUNCTION anmt540_ref_b()
   
   IF cl_null(g_nmbb_d[l_ac].nmbb027) THEN 
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_nmbb_d[l_ac].nmbb026
      CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004,pmaal003 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_nmbb_d[l_ac].nmbb026_desc = '', g_rtn_fields[1] , ''
      LET g_pmaal003 = '', g_rtn_fields[2] , ''
      DISPLAY BY NAME g_nmbb_d[l_ac].nmbb026_desc
   ELSE
   #IF cl_null(g_nmbb_d[l_ac].nmbb026_desc) AND NOT cl_null(g_nmbb_d[l_ac].nmbb027) THEN 
      SELECT pmak003 INTO g_nmbb_d[l_ac].nmbb026_desc
        FROM pmak_t
       WHERE pmakent = g_enterprise
         AND pmak001 = g_nmbb_d[l_ac].nmbb027
      DISPLAY g_nmbb_d[l_ac].nmbb026_desc TO s_detail1[l_ac].nmbb026_desc
   END IF
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_nmbb_d[l_ac].nmbb028
   CALL ap_ref_array2(g_ref_fields,"SELECT ooial003 FROM ooial_t WHERE ooialent='"||g_enterprise||"' AND ooial001=? AND ooial002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_nmbb_d[l_ac].nmbb028_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_nmbb_d[l_ac].nmbb028_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_nmbb_d[l_ac].nmbb043
   CALL ap_ref_array2(g_ref_fields,"SELECT nmabl003 FROM nmabl_t WHERE nmablent='"||g_enterprise||"' AND nmabl001=? AND nmabl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_nmbb_d[l_ac].nmbb043_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_nmbb_d[l_ac].nmbb043_desc
   
   #150807-00007#1 add ------
   #帶值
   SELECT glaa005 INTO g_glaa005
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaacomp = g_nmba_m.nmbacomp
      AND glaa014 = 'Y'
   LET g_nmbb_d[l_ac].nmbb010_desc = s_desc_get_nmail004_desc(g_glaa005,g_nmbb_d[l_ac].nmbb010)
   DISPLAY BY NAME g_nmbb_d[l_ac].nmbb010,g_nmbb_d[l_ac].nmbb010_desc
   #150807-00007#1 add end---
   
END FUNCTION
# 抓取核算組織
PRIVATE FUNCTION anmt540_nmbblegl_get(p_ooed004)
   DEFINE l_ooed005      LIKE ooed_t.ooed005
#  DEFINE l_ooea005      LIKE ooea_t.ooea005  #核算组织否 #161110-00001#2 MARK
   DEFINE l_ooef204      LIKE ooef_t.ooef204             #161110-00001#2 ADD 
   DEFINE p_ooed004      LIKE ooed_t.ooed004
   
   SELECT ooed005 INTO l_ooed005 
     FROM ooed_t
    WHERE ooedent = g_enterprise
      AND ooed001 = '3'
      AND ooed004 = p_ooed004
      AND ooed006 < = g_today 
      AND ooed007 > g_today
   
   IF g_ooed004_t = p_ooed004 THEN 
      LET g_nmbb_d[l_ac].nmbblegl = g_nmbb_d[l_ac].nmbborga
      RETURN 
   END IF
   
   IF cl_null(l_ooed005) THEN 
      LET g_nmbb_d[l_ac].nmbblegl = g_nmbb_d[l_ac].nmbborga
      RETURN 
   END IF 
   #161110-00001#2 MARK--S--
#   SELECT ooea005 INTO l_ooea005
#     FROM ooea_t
#    WHERE ooeaent = g_enterprise
#      AND ooea001 = l_ooed005
   #161110-00001#2 MARK--E--
   #161110-00001#2 ADD--S--
   SELECT ooef204 INTO l_ooef204
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = l_ooed005
   #161110-00001#2 ADD--E--
   IF l_ooef204 = 'Y' THEN   #161110-00001#2 mod l_ooea005 -> l_ooef204
      LET g_nmbb_d[l_ac].nmbblegl = l_ooed005
      RETURN 
   ELSE
      LET g_ooed004_t = l_ooed005
      CALL anmt540_nmbblegl_get(l_ooed005)
   END IF
END FUNCTION
# nmbb026 交易對象欄位檢查
PRIVATE FUNCTION anmt540_nmbb026_chk()
   DEFINE l_pmaastus         LIKE pmaa_t.pmaastus
   DEFINE l_n                LIKE type_t.num5
   DEFINE l_pmaa004          LIKE pmaa_t.pmaa004
   
   LET g_errno = ''
   
   SELECT pmaa004 INTO l_pmaa004
     FROM pmaa_t
    WHERE pmaaent = g_enterprise
      AND pmaa001 = g_nmbb_d[l_ac].nmbb026
   
   LET l_n = 0
   #161228-00019#1--mark--str--lujh
   #SELECT count(*) INTO l_n
   #  FROM pmaa_t
   # WHERE pmaaent = g_enterprise
   #   AND pmaa001 = g_nmbb_d[l_ac].nmbb026
   #161228-00019#1--mark--end--lujh    
   
   #161228-00019#1--add--str--lujh
   SELECT COUNT(pmab001) INTO l_n   
     FROM pmab_t
    WHERE pmabent = g_enterprise
      AND pmabsite = g_nmba_m.nmbacomp
      AND pmab001 = g_nmbb_d[l_ac].nmbb026
   #161228-00019#1--add--end--lujh
      
   IF l_n = 0 THEN 
      #LET g_errno = 'ais-00019'   #161228-00019#1 mark lujh
      LET g_errno = 'anm-03040'    #161228-00019#1 add lujh
      RETURN 
   ELSE
      #161228-00019#1--mark--str--lujh
      #LET l_n = 0 
      #SELECT count(*) INTO l_n 
      #  FROM pmaa_t
      # WHERE pmaaent = g_enterprise
      #   AND pmaa001 = g_nmbb_d[l_ac].nmbb026
      #   AND pmaastus = 'Y'
      #IF l_n = 0 THEN 
      #   LET g_errno = 'ais-00020'   
      #   RETURN 
      #END IF 
      #161228-00019#1--mark--end--lujh
   END IF

   IF l_pmaa004 = '2' THEN 
      INITIALIZE g_qryparam.* TO NULL
      LET g_qryparam.state = 'i'
	  LET g_qryparam.reqry = FALSE

      LET g_qryparam.arg1 = g_nmbb_d[l_ac].nmbb026
      #給予arg

      CALL q_pmak002()                                #呼叫開窗

      LET g_nmbb_d[l_ac].nmbb027 = g_qryparam.return1   
   ELSE
      LET g_nmbb_d[l_ac].nmbb027 = ''
   END IF   
   IF g_nmbb_d[l_ac].nmbb040 = 'N' THEN 
      LET g_pmaal003 = s_desc_get_trading_partner_full_desc(g_nmbb_d[l_ac].nmbb026)  #150921-00004#4
      LET g_nmbb_d[l_ac].nmbb041 = g_pmaal003
      DISPLAY BY NAME g_nmbb_d[l_ac].nmbb041   #150921-00004#4
   END IF 
END FUNCTION
# nmbb028 款別欄位檢查
PRIVATE FUNCTION anmt540_nmbb028_chk()
DEFINE l_ooiestus     LIKE ooie_t.ooiestus
DEFINE l_ooie003      LIKE ooie_t.ooie003
DEFINE l_ooie004      LIKE ooie_t.ooie004
DEFINE l_nmbb003      LIKE nmbb_t.nmbb003
DEFINE l_success      LIKE type_t.num5
DEFINE l_errno        LIKE type_t.chr50
DEFINE l_no           LIKE type_t.chr10
   
   LET g_errno = ''

   LET g_nmbb_d[l_ac].nmbb029 = ''
   LET l_nmbb003 = ''
   LET g_nmbb_d[l_ac].nmbb039 = ''
   LET l_ooie003 = ''
   LET l_ooie004 = ''
#   SELECT ooiestus,ooia002,'',ooie003,ooie004 
#     INTO l_ooiestus,g_nmbb_d[l_ac].nmbb029,l_nmbb003,l_ooie003,l_ooie004
#     FROM ooie_t,ooia_t
#    WHERE ooieent = g_enterprise
#      AND ooiesite = g_nmbb_d[l_ac].nmbborga
#      AND ooie001 = g_nmbb_d[l_ac].nmbb028
#      AND ooiaent = ooieent
#      AND ooia001 = ooie001
#      AND ooia002 IN ('10','20','30','40','50')
#      
#   CASE
#      WHEN SQLCA.SQLCODE = 100    LET g_errno = 'anm-00049'
#      WHEN l_ooiestus = 'N'       LET g_errno = 'anm-00050'
#   END CASE
   CALL s_money_chk('2',g_nmbb_d[l_ac].nmbborga,g_nmbb_d[l_ac].nmbb028) RETURNING l_success,l_errno,l_no,g_ooia002
   IF NOT l_success THEN 
      LET g_errno = l_errno
      RETURN 
   ELSE
      IF  g_ooia002 != '10'
      AND g_ooia002 != '20'      
      AND g_ooia002 != '30'
      AND g_ooia002 != '40'
      AND g_ooia002 != '50' THEN 
         LET g_errno = 'aoo-00399'
         RETURN 
      END IF 
   END IF 
   LET g_nmbb_d[l_ac].nmbb029 = g_ooia002
   CALL s_money_ooie_get(l_no,'ooie003',g_nmbb_d[l_ac].nmbborga,g_nmbb_d[l_ac].nmbb028) RETURNING l_ooie003
   CALL s_money_ooie_get(l_no,'ooie004',g_nmbb_d[l_ac].nmbborga,g_nmbb_d[l_ac].nmbb028) RETURNING l_ooie004
   
   IF cl_null(g_nmbb_d[l_ac].nmbb003) THEN 
      LET g_nmbb_d[l_ac].nmbb003 = l_nmbb003
   END IF 
   
   #依款別給預設值
   IF g_nmbb_d[l_ac].nmbb029 = '10' THEN 
      LET g_nmbb_d[l_ac].nmbb031 = g_nmba_m.nmbadocdt
   END IF
   
   IF g_nmbb_d[l_ac].nmbb029 = '20'  OR g_nmbb_d[l_ac].nmbb029 = '10' THEN 
      CALL cl_set_comp_entry('nmbb003',TRUE)
      CALL cl_set_comp_entry('nmbb044,nmbb045',FALSE)
      LET g_nmbb_d[l_ac].nmbb044 = ''
      LET g_nmbb_d[l_ac].nmbb045 = ''
      IF g_conf = 'N' THEN   #160530-00005#4 不走anmt550复核流程时，存提码和现金变动码必须录入
      CALL cl_set_comp_required('nmbb002,nmbb010',TRUE) #151127-00006#2 add
      END IF #160530-00005#4
   ELSE
      CALL cl_set_comp_entry('nmbb003',FALSE)
      CALL cl_set_comp_entry('nmbb044,nmbb045',TRUE)
      LET g_nmbb_d[l_ac].nmbb003 = ' '
      CALL cl_set_comp_required('nmbb002,nmbb010',FALSE) #151127-00006#2 add
   END IF 
   
   IF g_nmbb_d[l_ac].nmbb029 = '30' THEN 
      CALL anmt540_set_comp_entry('nmbb030,nmbb043_desc,nmbb031,nmbb040,nmbb041,nmbb073',TRUE) #161125-00052#2 add nmbb073
      LET g_nmbb_d[l_ac].nmbb042 = '1'
      LET g_nmbb_d[l_ac].nmbb044 = '1'
      LET g_nmbb_d[l_ac].nmbb045 = 0
   ELSE
      CALL anmt540_set_comp_entry('nmbb030,nmbb043_desc,nmbb031,nmbb040,nmbb041,nmbb073',FALSE) #161125-00052#2 add nmbb073
      LET g_nmbb_d[l_ac].nmbb030 = ''
      LET g_nmbb_d[l_ac].nmbb043 = ''
      LET g_nmbb_d[l_ac].nmbb043_desc = ''
      LET g_nmbb_d[l_ac].nmbb073 = '' #161125-00052#2 add
      IF g_nmbb_d[l_ac].nmbb029 = '10' THEN 
         LET g_nmbb_d[l_ac].nmbb031 = g_nmba_m.nmbadocdt
      ELSE
         LET g_nmbb_d[l_ac].nmbb031 = ''
      END IF
      LET g_nmbb_d[l_ac].nmbb041 = ''
      LET g_nmbb_d[l_ac].nmbb040 = 'N'
      LET g_nmbb_d[l_ac].nmbb042 = 'T'   #150616-00026#8
   END IF
   
   IF l_ooie003 = 'Y' THEN 
      LET g_nmbb_d[l_ac].nmbb039 = l_ooie004
      DISPLAY g_nmbb_d[l_ac].nmbb039 TO s_detail1[l_ac].nmbb039
   END IF
   
   DISPLAY g_nmbb_d[l_ac].nmbb003 TO s_detail1[l_ac].nmbb003
   DISPLAY g_nmbb_d[l_ac].nmbb031 TO s_detail1[l_ac].nmbb031
   
   CALL anmt540_ref_b()
END FUNCTION
# nmbb003 交易帳戶編碼欄位檢查
PRIVATE FUNCTION anmt540_nmbb003_chk()
   DEFINE l_nmaastus            LIKE nmaa_t.nmaastus
   DEFINE l_ooab002             LIKE ooab_t.ooab002
   
   LET g_errno = ''
   
   SELECT nmaastus,nmas003 INTO l_nmaastus,g_nmbb_d[l_ac].nmbb004
     FROM nmaa_t,nmas_t
    WHERE nmaaent = g_enterprise
      AND nmaaent = nmasent
      AND nmaa001 = nmas001
      AND nmas002 = g_nmbb_d[l_ac].nmbb003
      AND nmaa002 IN (select ooef001 FROM ooef_t WHERE ooefent = g_enterprise
                                               AND ooef017 = g_nmba_m.nmbacomp)

   CASE
      WHEN SQLCA.SQLCODE = 100    LET g_errno = 'anm-00026'
      WHEN l_nmaastus = 'N'       LET g_errno = 'sub-01302' #anm-00027 #160318-00005#28  By 07900 --mod  
   END CASE
   
   #160122-00001#27--add---str
   IF NOT s_anmi120_nmll002_chk(g_nmbb_d[l_ac].nmbb003,g_user) THEN
      LET g_errno = 'anm-00574'
   END IF
   #160122-00001#27--add---end
  
END FUNCTION
# nmbb004 繳款幣別欄位檢查
PRIVATE FUNCTION anmt540_nmbb004_chk()
   DEFINE  l_n             LIKE type_t.num5 
   DEFINE  l_ooab002       LIKE ooab_t.ooab002
   
   LET g_errno = ''
   
   #判斷資料是否存在
   SELECT count(*) INTO l_n
     FROM ooai_t
    WHERE ooaient = g_enterprise
      AND ooai001 = g_nmbb_d[l_ac].nmbb004
      
   IF l_n = 0 THEN 
      LET g_errno = 'aoo-00028'
      RETURN 
   END IF
   
END FUNCTION
#
PRIVATE FUNCTION anmt540_lock_b2(ps_table,ps_page)
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING

   
   #先刷新資料
   #CALL anmt540_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "nmbb_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN anmt540_bcl3 USING g_enterprise,
                                       g_nmba_m.nmbacomp,g_nmba_m.nmbadocno,g_nmbb_d[g_detail_idx].nmbbseq
                                       
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "anmt540_bcl3"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF
   
   END IF
 
   RETURN TRUE
END FUNCTION
# 動態設定元件開啟與關閉
PRIVATE FUNCTION anmt540_set_comp_entry(ps_fields,pi_entry)
   DEFINE ps_fields STRING,
          pi_entry  LIKE type_t.num5           
   DEFINE lst_fields base.StringTokenizer,
          ls_field_name STRING
   DEFINE lwin_curr     ui.Window
   DEFINE lnode_win     om.DomNode,
          llst_items    om.NodeList,
          li_i          LIKE type_t.num5,        
          lnode_item    om.DomNode,
          ls_item_name  STRING
 
   IF g_bgjob = 'Y' AND g_gui_type NOT MATCHES "[13]"  THEN  
      RETURN
   END IF
 
   IF (ps_fields IS NULL) THEN
      RETURN
   END IF
 
   LET ps_fields = ps_fields.toLowerCase()
 
   LET lst_fields = base.StringTokenizer.create(ps_fields, ",")
 
   LET lwin_curr = ui.Window.getCurrent()
   LET lnode_win = lwin_curr.getNode()
 
   LET llst_items = lnode_win.selectByPath("//Form//*")
 
   WHILE lst_fields.hasMoreTokens()
     LET ls_field_name = lst_fields.nextToken()
     LET ls_field_name = ls_field_name.trim()
 
     IF (ls_field_name.getLength() > 0) THEN
        FOR li_i = 1 TO llst_items.getLength()
            LET lnode_item = llst_items.item(li_i)
            LET ls_item_name = lnode_item.getAttribute("colName")
 
            IF (ls_item_name IS NULL) THEN
               LET ls_item_name = lnode_item.getAttribute("name")
 
               IF (ls_item_name IS NULL) THEN
                  CONTINUE FOR
               END IF
            END IF
 
            LET ls_item_name = ls_item_name.trim()
 
            IF (ls_item_name.equals(ls_field_name)) THEN
               IF (pi_entry) THEN
                  CALL lnode_item.setAttribute("noEntry", "0")
                  CALL lnode_item.setAttribute("active", "1")
               ELSE
                  CALL lnode_item.setAttribute("noEntry", "1")
                  CALL lnode_item.setAttribute("active", "0")
               END IF
 
               EXIT FOR
            END IF
        END FOR
     END IF
   END WHILE
END FUNCTION
# 單身2欄位開啟設定
PRIVATE FUNCTION anmt540_set_entry_b2()
   
   IF g_nmbb_d[l_ac].nmbb029 = '40' THEN 
      CALL anmt540_set_comp_entry("nmbb032_1,nmbb033_1,nmbb034_1,nmbb035_1",TRUE)
   END IF
   IF g_nmbb_d[l_ac].nmbb029 = '50' THEN 
      CALL anmt540_set_comp_entry("nmbb036_desc,nmbb037_1,nmbb038_1",TRUE)
   END IF
END FUNCTION
# 單身2欄位關閉設定
PRIVATE FUNCTION anmt540_set_no_entry_b2()
   
   IF g_nmbb_d[l_ac].nmbb029 <> '40' THEN 
      CALL anmt540_set_comp_entry("nmbb032_1,nmbb033_1,nmbb034_1,nmbb035_1",FALSE)
   END IF
   IF g_nmbb_d[l_ac].nmbb029 <> '50' THEN 
      CALL anmt540_set_comp_entry("nmbb036_desc,nmbb037_1,nmbb038_1",FALSE)
   END IF
END FUNCTION
# nmbu001交易對象欄位檢查
PRIVATE FUNCTION anmt540_nmbu001_chk()
   DEFINE l_n                LIKE type_t.num5
   DEFINE l_pmaa004          LIKE pmaa_t.pmaa004
   
   LET g_errno = ''
   LET l_n = 0
   SELECT COUNT(*) INTO l_n
     FROM nmbb_t
    where nmbbent = g_enterprise
      and nmbbcomp = g_nmba_m.nmbacomp
      and nmbbdocno = g_nmba_m.nmbadocno
      and nmbb026 = g_nmbb3_d[l_ac].nmbu001
      
   IF l_n = 0 THEN 
      LET g_errno = 'anm-00057'
      RETURN
   END IF 
   
   SELECT pmaa004 INTO l_pmaa004
     FROM pmaa_t
    WHERE pmaaent = g_enterprise
      AND pmaa001 = g_nmbb3_d[l_ac].nmbu001
      
   IF l_pmaa004 = '2' THEN 
      INITIALIZE g_qryparam.* TO NULL
      LET g_qryparam.state = 'i'
	  LET g_qryparam.reqry = FALSE

      LET g_qryparam.arg1 = g_nmbb3_d[l_ac].nmbu001
      #給予arg

      CALL q_pmak002()                                #呼叫開窗

      LET g_nmbb3_d[l_ac].nmbu002 = g_qryparam.return1  
   ELSE
      LET g_nmbb3_d[l_ac].nmbu002 = ''    
   END IF  
   
   #帶來源組織
   LET g_sql = " SELECT nmbborga FROM nmbb_t ",
               "  WHERE nmbbent = '",g_enterprise,"'", 
               "    AND nmbbcomp = '",g_nmba_m.nmbacomp,"'",
               "    AND nmbbdocno = '",g_nmba_m.nmbadocno,"'",
               "    AND nmbb026 = '",g_nmbb3_d[l_ac].nmbu001,"'"
   PREPARE nmbborga_pre FROM g_sql
   DECLARE nmbborga_cur CURSOR FOR nmbborga_pre
   OPEN nmbborga_cur
   FETCH nmbborga_cur INTO g_nmbb3_d[l_ac].nmbuorga
      
END FUNCTION
# 第三單身參考欄位帶值
PRIVATE FUNCTION anmt540_ref_b_3()
   DEFINE l_pmaa004          LIKE pmaa_t.pmaa004
   
   SELECT pmaa004 INTO l_pmaa004
     FROM pmaa_t
    WHERE pmaaent = g_enterprise
      AND pmaa001 = g_nmbb3_d[l_ac].nmbu001
      
   IF l_pmaa004 <> '2' THEN 
      LET g_nmbb3_d[l_ac].nmbu002 = ''
   END IF
   
   IF cl_null(g_nmbb3_d[l_ac].nmbu002) THEN 
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_nmbb3_d[l_ac].nmbu001
      CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_nmbb3_d[l_ac].nmbu001_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_nmbb3_d[l_ac].nmbu001_desc
   ELSE
   #IF cl_null(g_nmbb2_d[l_ac].nmbu001_desc) THEN 
      SELECT pmak003 INTO g_nmbb3_d[l_ac].nmbu001_desc
        FROM pmak_t
       WHERE pmakent = g_enterprise
         AND pmak001 = g_nmbb3_d[l_ac].nmbu002
      DISPLAY BY NAME g_nmbb3_d[l_ac].nmbu001_desc
   END IF
   

END FUNCTION
# nmbuorga 來源組織欄位檢查
PRIVATE FUNCTION anmt540_nmbuorga_chk()
   DEFINE l_n                LIKE type_t.num5 
   
   LET g_errno = ''
   LET l_n = 0
   SELECT COUNT(*) INTO l_n
     FROM nmbb_t
    WHERE nmbbent = g_enterprise
      AND nmbbcomp = g_nmba_m.nmbacomp
      AND nmbbdocno = g_nmba_m.nmbadocno
      AND nmbb026 = g_nmbb3_d[l_ac].nmbu001
      AND nmbborga = g_nmbb3_d[l_ac].nmbuorga
      
   IF l_n = 0 THEN 
      LET g_errno = 'anm-00059'
      RETURN 
   END IF 
END FUNCTION
# 來源單號欄位檢查
PRIVATE FUNCTION anmt540_nmbu005_chk()
   DEFINE l_xmdastus          LIKE xmda_t.xmdastus
   DEFINE l_xrcastus          LIKE xrca_t.xrcastus
   DEFINE l_isafstus          LIKE isaf_t.isafstus
   DEFINE l_isaf035           LIKE isaf_t.isaf035
   DEFINE l_xrca108           LIKE xrca_t.xrca108
   DEFINE l_n                 LIKE type_t.num5
   
   LET g_errno = ''
   
   IF g_nmbb3_d[l_ac].nmbu004 = '1' THEN 
      SELECT xmdastus
        INTO l_xmdastus
        FROM xmda_t,xmdb_t
       WHERE xmdaent = g_enterprise
         AND xmdadocno = g_nmbb3_d[l_ac].nmbu005
         AND xmda004 = g_nmbb3_d[l_ac].nmbu001
         
      CASE
          WHEN SQLCA.SQLCODE = 100    LET g_errno = 'anm-00210'
          WHEN l_xmdastus = 'N'       LET g_errno = 'anm-00211'
       END CASE
       
       IF NOT cl_null(g_nmbb3_d[l_ac].nmbu005) AND NOT cl_null(g_nmbb3_d[l_ac].nmbu006) THEN 
          SELECT COUNT(*) INTO l_n
            FROM xmdb_t 
           WHERE xmdbent = g_enterprise
             AND xmdbdocno = g_nmbb3_d[l_ac].nmbu005
             AND xmdb001 = g_nmbb3_d[l_ac].nmbu006
          
          IF l_n = 0 THEN 
             LET g_errno = 'anm-00212'
          END IF
       END IF
       
   END IF 
   
   IF g_nmbb3_d[l_ac].nmbu004 = '2' THEN 
      SELECT xrcastus,xrca108
        INTO l_xrcastus,l_xrca108
        FROM xrca_t 
       WHERE xrcaent = g_enterprise 
         AND xrcald = g_glaald
         AND xrcadocno = g_nmbb3_d[l_ac].nmbu005
         AND xrca004 = g_nmbb3_d[l_ac].nmbu001
       CASE
          WHEN SQLCA.SQLCODE = 100    LET g_errno = 'anm-00060'
          WHEN l_xrcastus = 'N'       LET g_errno = 'axr-00065'
          WHEN l_xrca108 = 0          LET g_errno = 'anm-00061'
       END CASE
   END IF 
   
   IF g_nmbb3_d[l_ac].nmbu004 = '3' THEN 
      SELECT isafstus,isaf035
        INTO l_isafstus,l_isaf035
        FROM isaf_t,isag_t 
       WHERE isafent = g_enterprise
         AND isafdocno = g_nmbb3_d[l_ac].nmbu005
         AND isafcomp = g_nmba_m.nmbacomp
         AND isaf002 = g_nmbb3_d[l_ac].nmbu001
       CASE
          WHEN SQLCA.SQLCODE = 100    LET g_errno = 'anm-00062'
          WHEN l_isafstus = 'N'       LET g_errno = 'anm-00063'
          WHEN l_isaf035 IS NOT NULL  LET g_errno = 'anm-00064'
       END CASE
   END IF 
END FUNCTION
# nmba043 開票銀行欄位檢查
PRIVATE FUNCTION anmt540_nmbb043_chk(p_nmbb043)
   DEFINE l_n            LIKE type_t.num5
   DEFINE p_nmbb043      LIKE nmbb_t.nmbb043
   
   LET g_errno = ''
   
   LET l_n = 0
   SELECT COUNT(*) INTO l_n 
     FROM nmab_t
    WHERE nmabent = g_enterprise
      AND nmab001 = p_nmbb043
      
   IF l_n = 0 THEN 
      LET g_errno = 'anm-00051'
   ELSE
      LET l_n = 0
      SELECT COUNT(*) INTO l_n 
        FROM nmab_t
       WHERE nmabent = g_enterprise
         AND nmab001 = p_nmbb043
         AND nmab008 = g_ooef006
      IF l_n = 0 THEN 
         LET g_errno = 'anm-00052'
      END IF
   END IF
END FUNCTION
# 單身2參考欄位帶值
PRIVATE FUNCTION anmt540_ref_b_2()
   
   IF cl_null(g_nmbb_d[l_ac].nmbb027) THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_nmbb2_d[l_ac].nmbb026_1
      CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_nmbb2_d[l_ac].nmbb026_1_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_nmbb2_d[l_ac].nmbb026_1_desc
   ELSE
      SELECT pmak003 INTO g_nmbb2_d[l_ac].nmbb026_1_desc
        FROM pmak_t
       WHERE pmakent = g_enterprise
         AND pmak001 = g_nmbb_d[l_ac].nmbb027
      DISPLAY g_nmbb2_d[l_ac].nmbb026_1_desc TO s_detail2[l_ac].nmbb026_1_desc
   END IF
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_nmbb2_d[l_ac].nmbb028
   CALL ap_ref_array2(g_ref_fields,"SELECT ooial003 FROM ooial_t WHERE ooialent='"||g_enterprise||"' AND ooial001=? AND ooial002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_nmbb2_d[l_ac].nmbb028_desc1 = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_nmbb2_d[l_ac].nmbb028_desc1
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_nmbb2_d[l_ac].nmbb036
   CALL ap_ref_array2(g_ref_fields,"SELECT nmabl003 FROM nmabl_t WHERE nmablent='"||g_enterprise||"' AND nmabl001=? AND nmabl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_nmbb2_d[l_ac].nmbb036_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_nmbb2_d[l_ac].nmbb036_desc
END FUNCTION
#
PRIVATE FUNCTION anmt540_ref_amt()
   DEFINE l_ooam003        LIKE ooam_t.ooam003
   
   LET g_nmbb_d[l_ac].nmbb001 = '1'
   #-------------------------------其他本位幣頁簽------------------------------------
            
   IF g_glaa015 = 'Y' THEN
      #帳套本位幣二幣別
      LET g_nmbb_d[l_ac].nmbb011 = g_glaa016
      #來源幣別
      IF g_glaa017 = '1' THEN
         LET l_ooam003 = g_nmbb_d[l_ac].nmbb004
      ELSE   #表示帳簿幣別 
         LET l_ooam003 = g_glaa001            #帳套使用幣別
      END IF
      #主帳套本位幣二匯率
                               #匯率參照表;帳套;           日期;         來源幣別
      CALL s_aooi160_get_exrate('2',g_glaald,g_nmba_m.nmbadocdt,l_ooam003,
                                #目的幣別;          交易金額; 匯類類型
                                g_nmbb_d[l_ac].nmbb011,0,g_glaa018)
           RETURNING g_nmbb_d[l_ac].nmbb012
     #CALL s_curr_round_ld('1',g_glaald,g_glaa016,g_nmbb_d[l_ac].nmbb012,3) #150707-00001#7 #160822-00018#1 mark
      CALL s_curr_round_ld('1',g_glaald,l_ooam003,g_nmbb_d[l_ac].nmbb012,3)                 #160822-00018#1
           RETURNING g_sub_success,g_errno,g_nmbb_d[l_ac].nmbb012           #150707-00001#7
      #主帳套本位幣二金額
      IF g_glaa017 = '1' THEN
         LET g_nmbb_d[l_ac].nmbb013 = g_nmbb_d[l_ac].nmbb006 * g_nmbb_d[l_ac].nmbb012
      ELSE
         LET g_nmbb_d[l_ac].nmbb013 = g_nmbb_d[l_ac].nmbb007 * g_nmbb_d[l_ac].nmbb012
      END IF
      CALL s_curr_round_ld('1',g_glaald,g_glaa016,g_nmbb_d[l_ac].nmbb013,2)    #150707-00001#7
           RETURNING g_sub_success,g_errno,g_nmbb_d[l_ac].nmbb013              #150707-00001#7
   END IF
   #主帳套本位幣二已沖金額
   LET g_nmbb_d[l_ac].nmbb014 = 0
   
   IF g_glaa019 = 'Y' THEN
      #主帳套本位幣三幣別
      LET g_nmbb_d[l_ac].nmbb015 = g_glaa020
      #來源幣別
      IF g_glaa021 = '1' THEN
         LET l_ooam003 = g_nmbb_d[l_ac].nmbb004
      ELSE   #表示帳簿幣別
         LET l_ooam003 = g_glaa001               #帳套使用幣別
      END IF
      #主帳套本位幣三匯率
                               #匯率參照表;帳套;           日期;         來源幣別
      CALL s_aooi160_get_exrate('2',g_glaald,g_nmba_m.nmbadocdt,l_ooam003,
                                #目的幣別;         交易金額; 匯類類型
                                g_nmbb_d[l_ac].nmbb015,0,g_glaa022)
           RETURNING g_nmbb_d[l_ac].nmbb016 
     #CALL s_curr_round_ld('1',g_glaald,g_glaa020,g_nmbb_d[l_ac].nmbb016,3) #150707-00001#7 #160822-00018#1 mark
      CALL s_curr_round_ld('1',g_glaald,l_ooam003,g_nmbb_d[l_ac].nmbb016,3) #160822-00018#1
           RETURNING g_sub_success,g_errno,g_nmbb_d[l_ac].nmbb016           #150707-00001#7
      #主帳套本位幣三金額
     #IF g_glaa017 = '1' THEN #160822-00018#1 mark
      IF g_glaa021 = '1' THEN #160822-00018#1
         LET g_nmbb_d[l_ac].nmbb017 = g_nmbb_d[l_ac].nmbb006 * g_nmbb_d[l_ac].nmbb016
      ELSE
         LET g_nmbb_d[l_ac].nmbb017 = g_nmbb_d[l_ac].nmbb007 * g_nmbb_d[l_ac].nmbb016
      END IF
      CALL s_curr_round_ld('1',g_glaald,g_glaa020,g_nmbb_d[l_ac].nmbb017,2)	  #150707-00001#7
           RETURNING g_sub_success,g_errno,g_nmbb_d[l_ac].nmbb017               #150707-00001#7
   END IF
   #主帳套本位幣三已沖金額
   LET g_nmbb_d[l_ac].nmbb018 = 0
   
   #-------------沖賬記錄查詢-----------------
   CALL cl_get_para(g_enterprise,g_nmba_m.nmbacomp,'S-FIN-4004') RETURNING g_para_data  #資金模組匯率來源

 #  IF NOT cl_null(g_glaald_1) THEN 
 #     SELECT glaa001 INTO g_glaa001_1
 #       FROM glaa_t
 #      WHERE glaaent = g_enterprise
 #        AND glaald = g_glaald_1
 #     
 #                           #匯率參照表;帳套;           日期;         來源幣別
 #     CALL s_aooi160_get_exrate('2',g_glaald_1,g_nmba_m.nmbadocdt,g_nmbb_d[l_ac].nmbb004,
 #                               #目的幣別;  交易金額; 匯類類型
 #                               g_glaa001_1,0,g_para_data)
 #     RETURNING g_nmbb_d[l_ac].nmbb019            #次帳套一匯率
 #  END IF
   LET g_nmbb_d[l_ac].nmbb019 = 0 
   LET g_nmbb_d[l_ac].nmbb020 = 0              #次帳套一原幣已沖
   LET g_nmbb_d[l_ac].nmbb021 = 0              #次帳套一本幣已沖
 
 #  IF NOT cl_null(g_glaald_2) THEN 
 #     SELECT glaa001 INTO g_glaa001_2
 #       FROM glaa_t
 #      WHERE glaaent = g_enterprise
 #        AND glaald = g_glaald_2
 #        
 #                           #匯率參照表;帳套;           日期;         來源幣別
 #     CALL s_aooi160_get_exrate('2',g_glaald_2,g_nmba_m.nmbadocdt,g_nmbb_d[l_ac].nmbb004,
 #                               #目的幣別;  交易金額; 匯類類型
 #                               g_glaa001_2,0,g_para_data)
 #     RETURNING g_nmbb_d[l_ac].nmbb022            #次帳套二匯率
 #
 #  END IF
   LET g_nmbb_d[l_ac].nmbb022 = 0 
   LET g_nmbb_d[l_ac].nmbb023 = 0              #次帳套二原幣已沖
   LET g_nmbb_d[l_ac].nmbb024 = 0              #次帳套二本幣已沖
   
   LET g_nmbb_d[l_ac].nmbb008 = 0              #主帳套已沖原幣
   LET g_nmbb_d[l_ac].nmbb009 = 0              #主帳套已沖本幣
   
   #由本程式寫入的 入帳金額= 繳款金額
   LET g_nmbb_d[l_ac].nmbb056 = g_nmbb_d[l_ac].nmbb005	     #繳款匯率            
   LET g_nmbb_d[l_ac].nmbb057 = g_nmbb_d[l_ac].nmbb006	     #主帳套原幣金額(繳款)
   LET g_nmbb_d[l_ac].nmbb058 = g_nmbb_d[l_ac].nmbb007	     #主帳套本幣金額(繳款)
   LET g_nmbb_d[l_ac].nmbb059 = g_nmbb_d[l_ac].nmbb012	     #主帳套本位幣二匯率(繳款)
   LET g_nmbb_d[l_ac].nmbb060 = g_nmbb_d[l_ac].nmbb013	     #主帳套本位幣二金額(繳款)
   LET g_nmbb_d[l_ac].nmbb061 = g_nmbb_d[l_ac].nmbb016	     #主帳套本位幣三匯率(繳款)
   LET g_nmbb_d[l_ac].nmbb062 = g_nmbb_d[l_ac].nmbb017	     #主帳套本位幣三金額(繳款)
END FUNCTION
# 必要栏位的控制
PRIVATE FUNCTION anmt540_set_comp_required(ps_fields,pi_required)
   DEFINE ps_fields STRING,
          pi_required   LIKE type_t.num5              
   DEFINE lst_fields base.StringTokenizer,
          ls_field_name STRING
   DEFINE lwin_curr     ui.Window,
          lfrm_curr     ui.Form         
   DEFINE lnode_win     om.DomNode,
          llst_items    om.NodeList,
          li_i          LIKE type_t.num5,             
          lnode_item    om.DomNode,
          lnode_child   om.DomNode,     
          ls_item_name  STRING
 
   IF (ps_fields IS NULL) THEN RETURN END IF
 
   IF g_bgjob = 'Y' AND g_gui_type NOT MATCHES "[13]"  THEN
      RETURN
   END IF
 
   LET ps_fields = ps_fields.toLowerCase()
 
   LET lst_fields = base.StringTokenizer.create(ps_fields, ",")
 
   LET lwin_curr = ui.Window.getCurrent()
   LET lfrm_curr = lwin_curr.getForm()       
   LET lnode_win = lwin_curr.getNode()
 
   LET llst_items = lnode_win.selectByPath("//Form//*")
 
   WHILE lst_fields.hasMoreTokens()
     LET ls_field_name = lst_fields.nextToken()
     LET ls_field_name = ls_field_name.trim()
 
     IF (ls_field_name.getLength() > 0) THEN
        FOR li_i = 1 TO llst_items.getLength()
            LET lnode_item = llst_items.item(li_i)
            LET ls_item_name = lnode_item.getAttribute("colName")
 
            IF (ls_item_name IS NULL) THEN
               CONTINUE FOR
            END IF
 
            LET ls_item_name = ls_item_name.trim()
 
            IF (ls_item_name.equals(ls_field_name)) THEN
               IF (pi_required) THEN
                  CALL lfrm_curr.setFieldHidden(ls_field_name,0) 
                  CALL lnode_item.setAttribute("required", "1")
                  CALL lnode_item.setAttribute("notNull", "1")
                  IF lnode_item.getTagName() = "FormField" THEN   
                     LET lnode_child = lnode_item.getFirstChild() 
                     IF lnode_child IS NOT NULL AND
                        lnode_child.getTagName() <> "CheckBox" AND
                        lnode_child.getTagName() <> "RadioGroup" THEN
                        CALL lfrm_curr.setFieldStyle(ls_field_name,"inputbgcolor_white")
                     END IF
                  ELSE
                     CALL lfrm_curr.setFieldStyle(ls_field_name,"inputbgcolor_red")
                  END IF
               ELSE
                  CALL lnode_item.setAttribute("required", "0")
                  CALL lnode_item.setAttribute("notNull", "0")
                  IF lnode_item.getTagName() = "FormField" THEN   
                     LET lnode_child = lnode_item.getFirstChild()
                     IF lnode_child IS NOT NULL AND
                        lnode_child.getTagName() <> "CheckBox"   AND
                        lnode_child.getTagName() <> "RadioGroup" THEN
                        CALL lfrm_curr.setFieldStyle(ls_field_name,"inputbgcolor_white")
                     END IF
                  ELSE
                     CALL lfrm_curr.setFieldStyle(ls_field_name,"inputbgcolor_white")
                  END IF
               END IF
 
               EXIT FOR
            END IF
        END FOR
     END IF
   END WHILE
END FUNCTION
#
PRIVATE FUNCTION anmt540_glaa_get()
   
   LET g_ooef001=''
   LET g_ooef016=''
   LET g_ooef006=''
   LET g_glaald=''
   LET g_glaa001=''
   LET g_glaa002=''
   LET g_glaa015=''
   LET g_glaa016=''
   LET g_glaa017=''
   LET g_glaa018=''
   LET g_glaa019=''
   LET g_glaa020=''
   LET g_glaa021=''
   LET g_glaa022=''
   LET g_glaa003=''
   LET g_glaa024=''
   
   SELECT ooef001,ooef016,ooef006 INTO g_ooef001,g_ooef016,g_ooef006
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_nmba_m.nmbacomp
      
    SELECT glaald,glaa001,glaa002,glaa015,glaa016,glaa017,glaa018,
    glaa019,glaa020,glaa021,glaa022,glaa003,glaa024                        #2014/12/19 liuym add glaa003,glaa024
     INTO g_glaald,g_glaa001,g_glaa002,g_glaa015,g_glaa016,g_glaa017,
     g_glaa018,g_glaa019,g_glaa020,g_glaa021,g_glaa022,g_glaa003,g_glaa024 #2014/12/19 liuym add g_glaa003,g_glaa024
     FROM glaa_t
    WHERE glaaent = g_enterprise #2015/04/02 by 02599 add
      AND glaacomp = g_nmba_m.nmbacomp
      AND glaa014 = 'Y'
   #取得帳套一的帳套代碼
 #  CALL cl_get_para(g_enterprise,g_nmba_m.nmbacomp,'S-FIN-0001') RETURNING g_glaald_1  
      
   #取得帳套二的帳套代碼 
 #  CALL cl_get_para(g_enterprise,g_nmba_m.nmbacomp,'S-FIN-0002') RETURNING g_glaald_2  
END FUNCTION
# 參考欄位帶值
PRIVATE FUNCTION anmt540_ref_show()
   LET g_nmba_m.nmba008_desc = ''
   #170210-00051#1--mark--str--lujh
   #SELECT oofa011 INTO g_nmba_m.nmba008_desc
   #  FROM oofa_t
   # WHERE oofaent = g_enterprise
   #   AND oofa001 IN (SELECT ooag002 FROM ooag_t
   #                     WHERE ooagent = g_enterprise
   #                       AND ooag001 = g_nmba_m.nmba008)
   #170210-00051#1--mark--end--lujh
   CALL s_desc_get_person_desc(g_nmba_m.nmba008) RETURNING g_nmba_m.nmba008_desc  #170210-00051#1 add lujh
   DISPLAY g_nmba_m.nmba008_desc TO nmba008_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_nmba_m.nmba001
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_nmba_m.nmba001_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_nmba_m.nmba001_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_nmba_m.nmbacomp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_nmba_m.nmbacomp_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_nmba_m.nmbacomp_desc
   
END FUNCTION
# nmbborga參考欄位帶值
PRIVATE FUNCTION anmt540_nmbborga_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_nmbb_d[l_ac].nmbborga
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_nmbb_d[l_ac].nmbborga_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_nmbb_d[l_ac].nmbborga_desc
END FUNCTION
# nmbuorga參考欄位帶值
PRIVATE FUNCTION anmt540_nmbuorga_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_nmbb3_d[l_ac].nmbuorga
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_nmbb3_d[l_ac].nmbuorga_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_nmbb3_d[l_ac].nmbuorga_desc 
END FUNCTION

################################################################################
# Descriptions...: 暂收否预设值设置
# Date & Author..: 2014/09/30  BY 05426
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt540_nmba006_chk()
   DEFINE l_ooac004     LIKE ooac_t.ooac004  #参数值
   
   #根据单据别+参照表号+参数编号获取参数值ooac004
   SELECT ooac004 INTO l_ooac004 FROM ooac_t WHERE ooacent=g_enterprise AND ooac001=g_glaa024
      AND ooac002=g_nmba_m.nmbadocno AND ooac003='D-FIN-0030'
      
   IF NOT cl_null(l_ooac004) THEN 
      IF l_ooac004='Y' THEN 
         LET g_nmba_m.nmba006='Y'
      ELSE 
         LET g_nmba_m.nmba006='N'
      END IF      
      CALL cl_set_comp_entry("nmba006",FALSE)
   ELSE 
      CALL cl_set_comp_entry("nmba006",TRUE)
   END IF
END FUNCTION

################################################################################
# Descriptions...: 直接審核功能
# Memo...........:
# Usage..........: CALL anmt540_approval()
#                  RETURNING 回传参数
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt540_approval()
   DEFINE l_flag    LIKE type_t.chr1
   DEFINE l_nmba002 LIKE nmba_t.nmba002  #帳務人員
   DEFINE l_nmba009 LIKE nmba_t.nmba009  #核准日期 
   DEFINE l_success LIKE type_t.chr1     #標記成功否
   DEFINE lc_state  LIKE type_t.chr1     #核准狀態 
   #150518-00040#5
   DEFINE l_nmbb028  LIKE nmbb_t.nmbb028
   DEFINE l_nmbb029  LIKE nmbb_t.nmbb029
   DEFINE l_sql      STRING
   DEFINE ls_js      STRING
   DEFINE lc_param   RECORD
            xmab003  LIKE xmab_t.xmab003,          #單據編號
            xmab006  LIKE xmab_t.xmab006,          #交易客戶
            xmab007  LIKE xmab_t.xmab007,          #交易幣別
            proj     LIKE xmaa_t.xmaa002,          #目前計算項目
            proj_o   LIKE xmaa_t.xmaa002,          #前置計算項目
            type     LIKE type_t.num5,             #正負向
            glaald   LIKE glaa_t.glaald,           #帳套
            glaacomp LIKE glaa_t.glaacomp,         #法人
            xmab004  LIKE xmab_t.xmab004           #單據項次
                 END RECORD
   #150518-00040#5
   LET l_flag = 'Y'
   IF g_nmba_m.nmbacomp IS NULL
      OR g_nmba_m.nmbadocno IS NULL
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err() 
      RETURN
   END IF
   
   IF g_nmba_m.nmbastus <> 'Y' THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "adb-00077" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err() 
      RETURN
   END IF
   
  OPEN WINDOW w_anmt540_s01 WITH FORM cl_ap_formpath("anm",'anmt540_s01')
  
  DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   INPUT l_nmba002,l_nmba009 FROM nmba002,nmba009 ATTRIBUTE(WITHOUT DEFAULTS)
    BEFORE INPUT
      #CALL cl_set_comp_entry("nmba009",FALSE)  #核准日期不開啟錄入
      CALL cl_set_comp_entry("nmba002",TRUE)
      CALL cl_set_comp_required("nmba002",TRUE)
      LET l_nmba002 = g_user   #帳務人員
      LET l_nmba009 = g_today  #核准日期
      CALL anmt540_nmba002_desc(l_nmba002)
      DISPLAY l_nmba002 TO nmba002
      DISPLAY l_nmba009 TO nmba009 
      
   
    AFTER FIELD nmba002
       IF NOT cl_null(l_nmba002) THEN
          INITIALIZE g_chkparam.* TO NULL
          LET g_errshow = TRUE #是否開窗 #160318-00025#30  add
          LET g_chkparam.arg1 = l_nmba002
          LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"#要執行的建議程式待補 #160318-00025#30  add
          IF cl_chk_exist("v_ooag001") THEN
             CALL anmt540_nmba002_desc(l_nmba002) 
          ELSE
             NEXT FIELD nmba002
          END IF
       END IF  
       
    AFTER FIELD nmba009
       IF NOT cl_null(l_nmba009) THEN
          IF l_nmba009 < g_nmba_m.nmbadocdt THEN
             INITIALIZE g_errparam TO NULL 
             LET g_errparam.extend = "" 
             LET g_errparam.code   = "anm-00288" 
             LET g_errparam.popup  = TRUE 
             CALL cl_err()
             NEXT FIELD nmba009
          END IF 
       END IF  
       
    ON ACTION controlp INFIELD nmba002
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'i'
         LET g_qryparam.reqry = FALSE
         CALL q_ooag001()
         LET l_nmba002 = g_qryparam.return1 
         CALL anmt540_nmba002_desc(l_nmba002)
         DISPLAY l_nmba002 TO nmba002
         NEXT FIELD nmba002
         
    
   AFTER INPUT
      #CALL cl_showmsg_init()
      CALL cl_err_collect_init()
      CALL anmt540_approval_chk() RETURNING l_success
      IF l_success = 'N' THEN
         #CALL cl_err_showmsg()
         CALL cl_err_collect_show()
         NEXT FIELD nmba002
      END IF   
          
   END INPUT

     ON ACTION accept
        LET l_flag = 'Y'  #確認動作
        ACCEPT DIALOG
        
     ON ACTION cancel
        LET l_flag = 'N' #取消動作
        EXIT DIALOG

 END DIALOG
 CLOSE WINDOW w_anmt540_s01
 
 IF l_flag = 'Y' THEN
    LET lc_state = 'V'
    CALL s_transaction_begin()
    CALL anmt540_nmbc_insert()
    CALL anmt540_update_amt()
    #150518-00040#5--       
    LET lc_param.xmab003  = g_nmba_m.nmbadocno
    LET lc_param.glaacomp = g_nmba_m.nmbacomp
    LET lc_param.type   = '1'    #1:正向 2:負向
    LET l_sql = " SELECT nmbbseq,nmbb026,nmbb004,nmbb029 ",
                "   FROM nmbb_t ",
                "  WHERE nmbbent = ",g_enterprise,
                "    AND nmbbcomp= '",g_nmba_m.nmbacomp,"' AND nmbbdocno = '",g_nmba_m.nmbadocno,"'"
    PREPARE anmt550_credit_p1 FROM l_sql
    DECLARE anmt550_credit_c1 CURSOR FOR anmt550_credit_p1
    FOREACH anmt550_credit_c1 INTO lc_param.xmab004,lc_param.xmab006,lc_param.xmab007,l_nmbb029
       IF NOT cl_null(lc_param.xmab004) AND NOT cl_null(lc_param.xmab006) THEN
          IF l_nmbb029 = '30' THEN     #20150914
            LET lc_param.proj   = 'S9' #20150914
          ELSE                         #20150914
            LET lc_param.proj   = 'S8'
          END IF                       #20150914
          LET ls_js = util.JSON.stringify(lc_param)
          CALL s_credit_move(ls_js)  RETURNING g_sub_success
          IF NOT g_sub_success THEN
             CALL s_transaction_end('N','0')
             EXIT FOREACH
          END IF
       END IF
    END FOREACH
    #150518-00040#5--   
    UPDATE nmba_t SET nmba009 = l_nmba009,
                      nmba002 = l_nmba002,
                      nmbastus = lc_state
       WHERE nmbaent = g_enterprise
         AND nmbacomp = g_nmba_m.nmbacomp
         AND nmbadocno = g_nmba_m.nmbadocno
    IF SQLCA.sqlcode THEN
      CALL s_transaction_end('N','0')
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
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         WHEN "V"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/verify.png")

       END CASE
       CALL s_transaction_end('Y','0')
       LET g_nmba_m.nmbastus = lc_state
       DISPLAY BY NAME g_nmba_m.nmbastus
    END IF    
 END IF

END FUNCTION

################################################################################
# Descriptions...:帳務人員名稱
# Memo...........:
# Usage..........: CALL  anmt540_nmba002_desc(p_ooag001)
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt540_nmba002_desc(p_ooag001)
 DEFINE p_ooag001 LIKE ooag_t.ooag001
 DEFINE l_ooag011 LIKE ooag_t.ooag011

 SELECT ooag011 INTO l_ooag011 FROM ooag_t WHERE ooagent = g_enterprise AND ooag001 = p_ooag001
 DISPLAY l_ooag011 TO nmba002_desc

END FUNCTION

################################################################################
# Descriptions...: 審核檢查
# Memo...........:
# Usage..........: CALL anmt540_approval_chk()
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt540_approval_chk()
  #161212-00005#2---modify-----begin------------- 
  # DEFINE l_nmbb            RECORD   LIKE nmbb_t.*
  DEFINE l_nmbb RECORD  #銀存收支明細檔
       nmbbent LIKE nmbb_t.nmbbent, #企業編號
       nmbbcomp LIKE nmbb_t.nmbbcomp, #法人
       nmbbdocno LIKE nmbb_t.nmbbdocno, #收支單號
       nmbbseq LIKE nmbb_t.nmbbseq, #項次
       nmbborga LIKE nmbb_t.nmbborga, #來源組織
       nmbblegl LIKE nmbb_t.nmbblegl, #核算組織
       nmbb001 LIKE nmbb_t.nmbb001, #異動別
       nmbb002 LIKE nmbb_t.nmbb002, #存提碼
       nmbb003 LIKE nmbb_t.nmbb003, #交易帳戶編碼
       nmbb004 LIKE nmbb_t.nmbb004, #幣別
       nmbb005 LIKE nmbb_t.nmbb005, #匯率
       nmbb006 LIKE nmbb_t.nmbb006, #主帳套原幣金額
       nmbb007 LIKE nmbb_t.nmbb007, #主帳套本幣金額
       nmbb008 LIKE nmbb_t.nmbb008, #主帳套已沖原幣金額
       nmbb009 LIKE nmbb_t.nmbb009, #主帳套已沖本幣金額
       nmbb010 LIKE nmbb_t.nmbb010, #現金變動碼
       nmbb011 LIKE nmbb_t.nmbb011, #本位幣二幣別
       nmbb012 LIKE nmbb_t.nmbb012, #本位幣二匯率
       nmbb013 LIKE nmbb_t.nmbb013, #本位幣二金額
       nmbb014 LIKE nmbb_t.nmbb014, #本位幣二已沖金額
       nmbb015 LIKE nmbb_t.nmbb015, #本位幣三幣別
       nmbb016 LIKE nmbb_t.nmbb016, #本位幣三匯率
       nmbb017 LIKE nmbb_t.nmbb017, #本位幣三金額
       nmbb018 LIKE nmbb_t.nmbb018, #本位幣三已沖金額
       nmbb019 LIKE nmbb_t.nmbb019, #輔助帳套一匯率
       nmbb020 LIKE nmbb_t.nmbb020, #輔助帳套一原幣已沖
       nmbb021 LIKE nmbb_t.nmbb021, #輔助帳套一本幣已沖
       nmbb022 LIKE nmbb_t.nmbb022, #輔助帳套二匯率
       nmbb023 LIKE nmbb_t.nmbb023, #輔助帳套二原幣已沖
       nmbb024 LIKE nmbb_t.nmbb024, #輔助帳套二本幣已沖
       nmbb025 LIKE nmbb_t.nmbb025, #備註
       nmbb026 LIKE nmbb_t.nmbb026, #交易對象
       nmbb027 LIKE nmbb_t.nmbb027, #一次性交易對象識別碼
       nmbb028 LIKE nmbb_t.nmbb028, #款別編碼
       nmbb029 LIKE nmbb_t.nmbb029, #款別分類
       nmbb030 LIKE nmbb_t.nmbb030, #票據號碼
       nmbb031 LIKE nmbb_t.nmbb031, #到期日
       nmbb032 LIKE nmbb_t.nmbb032, #有價券數量
       nmbb033 LIKE nmbb_t.nmbb033, #有價券面額
       nmbb034 LIKE nmbb_t.nmbb034, #有價券起始編號
       nmbb035 LIKE nmbb_t.nmbb035, #有價券結束編號
       nmbb036 LIKE nmbb_t.nmbb036, #刷卡銀行
       nmbb037 LIKE nmbb_t.nmbb037, #信用卡卡號
       nmbb038 LIKE nmbb_t.nmbb038, #手續費
       nmbb039 LIKE nmbb_t.nmbb039, #第三方代收機構
       nmbb040 LIKE nmbb_t.nmbb040, #背書轉入
       nmbb041 LIKE nmbb_t.nmbb041, #發票人全名
       nmbb042 LIKE nmbb_t.nmbb042, #票況
       nmbb043 LIKE nmbb_t.nmbb043, #票據付款銀行
       nmbb044 LIKE nmbb_t.nmbb044, #票面利率種類
       nmbb045 LIKE nmbb_t.nmbb045, #票面利率百分比
       nmbb046 LIKE nmbb_t.nmbb046, #轉付交易對象
       nmbb047 LIKE nmbb_t.nmbb047, #票據流通期間
       nmbb048 LIKE nmbb_t.nmbb048, #貼現利率種類
       nmbb049 LIKE nmbb_t.nmbb049, #貼現利率
       nmbb050 LIKE nmbb_t.nmbb050, #貼現期間
       nmbb051 LIKE nmbb_t.nmbb051, #貼現撥款原幣金額
       nmbb052 LIKE nmbb_t.nmbb052, #貼現撥款本幣金額
       nmbb053 LIKE nmbb_t.nmbb053, #繳款人員
       nmbb054 LIKE nmbb_t.nmbb054, #繳款部門
       nmbb055 LIKE nmbb_t.nmbb055, #POS繳款單號
       nmbb056 LIKE nmbb_t.nmbb056, #入帳匯率
       nmbb057 LIKE nmbb_t.nmbb057, #入帳原幣金額
       nmbb058 LIKE nmbb_t.nmbb058, #入帳主帳套本幣金額
       nmbb059 LIKE nmbb_t.nmbb059, #入帳主帳套本位幣二匯率
       nmbb060 LIKE nmbb_t.nmbb060, #入帳主帳套本位幣二金額
       nmbb061 LIKE nmbb_t.nmbb061, #入帳主帳套本位幣三匯率
       nmbb062 LIKE nmbb_t.nmbb062, #入帳主帳套本位幣三金額
       nmbb063 LIKE nmbb_t.nmbb063, #對方會科
       nmbb064 LIKE nmbb_t.nmbb064, #差異處理狀態
       nmbb065 LIKE nmbb_t.nmbb065, #開票日期
       nmbb066 LIKE nmbb_t.nmbb066, #重評後本幣金額
       nmbb067 LIKE nmbb_t.nmbb067, #重評後本位幣二金額
       nmbb068 LIKE nmbb_t.nmbb068, #重評後本位幣三金額
       nmbb069 LIKE nmbb_t.nmbb069, #質押否
       nmbbud001 LIKE nmbb_t.nmbbud001, #自定義欄位(文字)001
       nmbbud002 LIKE nmbb_t.nmbbud002, #自定義欄位(文字)002
       nmbbud003 LIKE nmbb_t.nmbbud003, #自定義欄位(文字)003
       nmbbud004 LIKE nmbb_t.nmbbud004, #自定義欄位(文字)004
       nmbbud005 LIKE nmbb_t.nmbbud005, #自定義欄位(文字)005
       nmbbud006 LIKE nmbb_t.nmbbud006, #自定義欄位(文字)006
       nmbbud007 LIKE nmbb_t.nmbbud007, #自定義欄位(文字)007
       nmbbud008 LIKE nmbb_t.nmbbud008, #自定義欄位(文字)008
       nmbbud009 LIKE nmbb_t.nmbbud009, #自定義欄位(文字)009
       nmbbud010 LIKE nmbb_t.nmbbud010, #自定義欄位(文字)010
       nmbbud011 LIKE nmbb_t.nmbbud011, #自定義欄位(數字)011
       nmbbud012 LIKE nmbb_t.nmbbud012, #自定義欄位(數字)012
       nmbbud013 LIKE nmbb_t.nmbbud013, #自定義欄位(數字)013
       nmbbud014 LIKE nmbb_t.nmbbud014, #自定義欄位(數字)014
       nmbbud015 LIKE nmbb_t.nmbbud015, #自定義欄位(數字)015
       nmbbud016 LIKE nmbb_t.nmbbud016, #自定義欄位(數字)016
       nmbbud017 LIKE nmbb_t.nmbbud017, #自定義欄位(數字)017
       nmbbud018 LIKE nmbb_t.nmbbud018, #自定義欄位(數字)018
       nmbbud019 LIKE nmbb_t.nmbbud019, #自定義欄位(數字)019
       nmbbud020 LIKE nmbb_t.nmbbud020, #自定義欄位(數字)020
       nmbbud021 LIKE nmbb_t.nmbbud021, #自定義欄位(日期時間)021
       nmbbud022 LIKE nmbb_t.nmbbud022, #自定義欄位(日期時間)022
       nmbbud023 LIKE nmbb_t.nmbbud023, #自定義欄位(日期時間)023
       nmbbud024 LIKE nmbb_t.nmbbud024, #自定義欄位(日期時間)024
       nmbbud025 LIKE nmbb_t.nmbbud025, #自定義欄位(日期時間)025
       nmbbud026 LIKE nmbb_t.nmbbud026, #自定義欄位(日期時間)026
       nmbbud027 LIKE nmbb_t.nmbbud027, #自定義欄位(日期時間)027
       nmbbud028 LIKE nmbb_t.nmbbud028, #自定義欄位(日期時間)028
       nmbbud029 LIKE nmbb_t.nmbbud029, #自定義欄位(日期時間)029
       nmbbud030 LIKE nmbb_t.nmbbud030, #自定義欄位(日期時間)030
       nmbb070 LIKE nmbb_t.nmbb070, #往來據點
       nmbb071 LIKE nmbb_t.nmbb071, #來源單號
       nmbb072 LIKE nmbb_t.nmbb072, #項次
       nmbb073 LIKE nmbb_t.nmbb073  #開票帳號
       END RECORD

  #161212-00005#2---modify-----end-------------
   DEFINE r_success         LIKE type_t.chr1
   DEFINE l_n               LIKE type_t.num5

   LET r_success = 'Y'
   #單頭檢查
   LET l_n = 0
   SELECT count(*) INTO l_n FROM nmbb_t
          WHERE nmbbent = g_enterprise
            AND nmbbdocno = g_nmba_m.nmbadocno
            AND nmbbcomp = g_nmba_m.nmbacomp
   IF l_n = 0 THEN
      LET r_success = 'N'
      #CALL cl_errmsg(g_nmba_m.nmbadocno,g_nmba_m.nmbacomp,'','anm-00087',1)
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'anm-00087'
      LET g_errparam.extend = g_nmba_m.nmbadocno
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF
   
   LET l_n = 0
   #161212-00005#2---modify-----begin-------------
   #LET g_sql = "SELECT * FROM nmbb_t",
   LET g_sql = "SELECT nmbbent,nmbbcomp,nmbbdocno,nmbbseq,nmbborga,nmbblegl,nmbb001,nmbb002,nmbb003,nmbb004,",
               "nmbb005,nmbb006,nmbb007,nmbb008,nmbb009,nmbb010,nmbb011,nmbb012,nmbb013,nmbb014,nmbb015,nmbb016,",
               "nmbb017,nmbb018,nmbb019,nmbb020,nmbb021,nmbb022,nmbb023,nmbb024,nmbb025,nmbb026,nmbb027,nmbb028,",
               "nmbb029,nmbb030,nmbb031,nmbb032,nmbb033,nmbb034,nmbb035,nmbb036,nmbb037,nmbb038,nmbb039,nmbb040,",
               "nmbb041,nmbb042,nmbb043,nmbb044,nmbb045,nmbb046,nmbb047,nmbb048,nmbb049,nmbb050,nmbb051,nmbb052,",
               "nmbb053,nmbb054,nmbb055,nmbb056,nmbb057,nmbb058,nmbb059,nmbb060,nmbb061,nmbb062,nmbb063,nmbb064,",
               "nmbb065,nmbb066,nmbb067,nmbb068,nmbb069,nmbbud001,nmbbud002,nmbbud003,nmbbud004,nmbbud005,",
               "nmbbud006,nmbbud007,nmbbud008,nmbbud009,nmbbud010,nmbbud011,nmbbud012,nmbbud013,nmbbud014,nmbbud015,",
               "nmbbud016,nmbbud017,nmbbud018,nmbbud019,nmbbud020,nmbbud021,nmbbud022,nmbbud023,nmbbud024,nmbbud025,",
               "nmbbud026,nmbbud027,nmbbud028,nmbbud029,nmbbud030,nmbb070,nmbb071,nmbb072,nmbb073 FROM nmbb_t",
   #161212-00005#2---modify-----end-------------
               " WHERE nmbbent = '",g_enterprise,"'",
               "   AND nmbbcomp = '",g_nmba_m.nmbacomp,"'",
               "   AND nmbbdocno = '",g_nmba_m.nmbadocno,"'"
   PREPARE anmt540_pre4 FROM g_sql
   DECLARE anmt540_cs4 CURSOR FOR anmt540_pre4

   FOREACH anmt540_cs4 INTO l_nmbb.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      IF cl_null(l_nmbb.nmbb002) THEN
         LET r_success = 'N'
         #CALL cl_errmsg(l_nmbb.nmbbseq,l_nmbb.nmbbdocno,'','anm-00090',1)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'anm-00090'
         LET g_errparam.extend = l_nmbb.nmbbseq
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END IF

      #150807-00007#1 add ------
      #款別性質=10&20才要檢查有沒有現金變動碼
      SELECT ooia002 INTO g_ooia002
        FROM ooia_t
       WHERE ooiaent = g_enterprise
         AND ooia001 = l_nmbb.nmbb028
      IF g_ooia002 = '10' OR g_ooia002 = '20' THEN
      #150807-00007#1 add end---
         LET l_n = 0
         SELECT COUNT(*) INTO l_n
           FROM glbc_t
          WHERE glbcent = g_enterprise
            AND glbcld  = g_glaald
            AND glbcdocno = g_nmba_m.nmbadocno
            AND glbcseq = l_nmbb.nmbbseq
            AND glbc004 IS NOT NULL
         IF l_n = 0 THEN
            LET r_success = 'N'
            #CALL cl_errmsg(l_nmbb.nmbbseq,l_nmbb.nmbbdocno,'','anm-00091',1)
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'anm-00091'
            LET g_errparam.extend = l_nmbb.nmbbseq
            LET g_errparam.popup = TRUE
            CALL cl_err()
         END IF
      END IF #150807-00007#1
      
     #IF l_nmbb.nmbb029 = '10' OR l_nmbb.nmbb029 = '20'THEN
      IF l_nmbb.nmbb029 = '20'THEN
         IF cl_null(l_nmbb.nmbb003) THEN
            LET r_success = 'N'
            #CALL cl_errmsg(l_nmbb.nmbbseq,l_nmbb.nmbbdocno,'','anm-00092',1)
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'anm-00092'
            LET g_errparam.extend = l_nmbb.nmbbseq
            LET g_errparam.popup = TRUE
            CALL cl_err()
         END IF
      END IF

      IF l_nmbb.nmbb029 = '30' THEN
         IF cl_null(l_nmbb.nmbb030) OR cl_null(l_nmbb.nmbb043) OR cl_null(l_nmbb.nmbb031) THEN
            LET r_success = 'N'
            #CALL cl_errmsg(l_nmbb.nmbbseq,l_nmbb.nmbbdocno,'','anm-00093',1)
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'anm-00093'
            LET g_errparam.extend = l_nmbb.nmbbseq
            LET g_errparam.popup = TRUE
            CALL cl_err()
         END IF
      END IF
   END FOREACH

   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 款別分類 nmbb029 = 10 或20寫入銀存收支異動檔 nmbc_t
# Memo...........:
# Usage..........: CALL anmt540_nmbc_insert()
#                  RETURNING 回传参数
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt540_nmbc_insert()
   #161212-00005#2---modify-----begin------------- 
  #DEFINE l_nmbb            RECORD   LIKE nmbb_t.*
  #DEFINE l_nmbc   RECORD   LIKE nmbc_t.*
  DEFINE l_nmbb RECORD  #銀存收支明細檔
       nmbbent LIKE nmbb_t.nmbbent, #企業編號
       nmbbcomp LIKE nmbb_t.nmbbcomp, #法人
       nmbbdocno LIKE nmbb_t.nmbbdocno, #收支單號
       nmbbseq LIKE nmbb_t.nmbbseq, #項次
       nmbborga LIKE nmbb_t.nmbborga, #來源組織
       nmbblegl LIKE nmbb_t.nmbblegl, #核算組織
       nmbb001 LIKE nmbb_t.nmbb001, #異動別
       nmbb002 LIKE nmbb_t.nmbb002, #存提碼
       nmbb003 LIKE nmbb_t.nmbb003, #交易帳戶編碼
       nmbb004 LIKE nmbb_t.nmbb004, #幣別
       nmbb005 LIKE nmbb_t.nmbb005, #匯率
       nmbb006 LIKE nmbb_t.nmbb006, #主帳套原幣金額
       nmbb007 LIKE nmbb_t.nmbb007, #主帳套本幣金額
       nmbb008 LIKE nmbb_t.nmbb008, #主帳套已沖原幣金額
       nmbb009 LIKE nmbb_t.nmbb009, #主帳套已沖本幣金額
       nmbb010 LIKE nmbb_t.nmbb010, #現金變動碼
       nmbb011 LIKE nmbb_t.nmbb011, #本位幣二幣別
       nmbb012 LIKE nmbb_t.nmbb012, #本位幣二匯率
       nmbb013 LIKE nmbb_t.nmbb013, #本位幣二金額
       nmbb014 LIKE nmbb_t.nmbb014, #本位幣二已沖金額
       nmbb015 LIKE nmbb_t.nmbb015, #本位幣三幣別
       nmbb016 LIKE nmbb_t.nmbb016, #本位幣三匯率
       nmbb017 LIKE nmbb_t.nmbb017, #本位幣三金額
       nmbb018 LIKE nmbb_t.nmbb018, #本位幣三已沖金額
       nmbb019 LIKE nmbb_t.nmbb019, #輔助帳套一匯率
       nmbb020 LIKE nmbb_t.nmbb020, #輔助帳套一原幣已沖
       nmbb021 LIKE nmbb_t.nmbb021, #輔助帳套一本幣已沖
       nmbb022 LIKE nmbb_t.nmbb022, #輔助帳套二匯率
       nmbb023 LIKE nmbb_t.nmbb023, #輔助帳套二原幣已沖
       nmbb024 LIKE nmbb_t.nmbb024, #輔助帳套二本幣已沖
       nmbb025 LIKE nmbb_t.nmbb025, #備註
       nmbb026 LIKE nmbb_t.nmbb026, #交易對象
       nmbb027 LIKE nmbb_t.nmbb027, #一次性交易對象識別碼
       nmbb028 LIKE nmbb_t.nmbb028, #款別編碼
       nmbb029 LIKE nmbb_t.nmbb029, #款別分類
       nmbb030 LIKE nmbb_t.nmbb030, #票據號碼
       nmbb031 LIKE nmbb_t.nmbb031, #到期日
       nmbb032 LIKE nmbb_t.nmbb032, #有價券數量
       nmbb033 LIKE nmbb_t.nmbb033, #有價券面額
       nmbb034 LIKE nmbb_t.nmbb034, #有價券起始編號
       nmbb035 LIKE nmbb_t.nmbb035, #有價券結束編號
       nmbb036 LIKE nmbb_t.nmbb036, #刷卡銀行
       nmbb037 LIKE nmbb_t.nmbb037, #信用卡卡號
       nmbb038 LIKE nmbb_t.nmbb038, #手續費
       nmbb039 LIKE nmbb_t.nmbb039, #第三方代收機構
       nmbb040 LIKE nmbb_t.nmbb040, #背書轉入
       nmbb041 LIKE nmbb_t.nmbb041, #發票人全名
       nmbb042 LIKE nmbb_t.nmbb042, #票況
       nmbb043 LIKE nmbb_t.nmbb043, #票據付款銀行
       nmbb044 LIKE nmbb_t.nmbb044, #票面利率種類
       nmbb045 LIKE nmbb_t.nmbb045, #票面利率百分比
       nmbb046 LIKE nmbb_t.nmbb046, #轉付交易對象
       nmbb047 LIKE nmbb_t.nmbb047, #票據流通期間
       nmbb048 LIKE nmbb_t.nmbb048, #貼現利率種類
       nmbb049 LIKE nmbb_t.nmbb049, #貼現利率
       nmbb050 LIKE nmbb_t.nmbb050, #貼現期間
       nmbb051 LIKE nmbb_t.nmbb051, #貼現撥款原幣金額
       nmbb052 LIKE nmbb_t.nmbb052, #貼現撥款本幣金額
       nmbb053 LIKE nmbb_t.nmbb053, #繳款人員
       nmbb054 LIKE nmbb_t.nmbb054, #繳款部門
       nmbb055 LIKE nmbb_t.nmbb055, #POS繳款單號
       nmbb056 LIKE nmbb_t.nmbb056, #入帳匯率
       nmbb057 LIKE nmbb_t.nmbb057, #入帳原幣金額
       nmbb058 LIKE nmbb_t.nmbb058, #入帳主帳套本幣金額
       nmbb059 LIKE nmbb_t.nmbb059, #入帳主帳套本位幣二匯率
       nmbb060 LIKE nmbb_t.nmbb060, #入帳主帳套本位幣二金額
       nmbb061 LIKE nmbb_t.nmbb061, #入帳主帳套本位幣三匯率
       nmbb062 LIKE nmbb_t.nmbb062, #入帳主帳套本位幣三金額
       nmbb063 LIKE nmbb_t.nmbb063, #對方會科
       nmbb064 LIKE nmbb_t.nmbb064, #差異處理狀態
       nmbb065 LIKE nmbb_t.nmbb065, #開票日期
       nmbb066 LIKE nmbb_t.nmbb066, #重評後本幣金額
       nmbb067 LIKE nmbb_t.nmbb067, #重評後本位幣二金額
       nmbb068 LIKE nmbb_t.nmbb068, #重評後本位幣三金額
       nmbb069 LIKE nmbb_t.nmbb069, #質押否
       nmbbud001 LIKE nmbb_t.nmbbud001, #自定義欄位(文字)001
       nmbbud002 LIKE nmbb_t.nmbbud002, #自定義欄位(文字)002
       nmbbud003 LIKE nmbb_t.nmbbud003, #自定義欄位(文字)003
       nmbbud004 LIKE nmbb_t.nmbbud004, #自定義欄位(文字)004
       nmbbud005 LIKE nmbb_t.nmbbud005, #自定義欄位(文字)005
       nmbbud006 LIKE nmbb_t.nmbbud006, #自定義欄位(文字)006
       nmbbud007 LIKE nmbb_t.nmbbud007, #自定義欄位(文字)007
       nmbbud008 LIKE nmbb_t.nmbbud008, #自定義欄位(文字)008
       nmbbud009 LIKE nmbb_t.nmbbud009, #自定義欄位(文字)009
       nmbbud010 LIKE nmbb_t.nmbbud010, #自定義欄位(文字)010
       nmbbud011 LIKE nmbb_t.nmbbud011, #自定義欄位(數字)011
       nmbbud012 LIKE nmbb_t.nmbbud012, #自定義欄位(數字)012
       nmbbud013 LIKE nmbb_t.nmbbud013, #自定義欄位(數字)013
       nmbbud014 LIKE nmbb_t.nmbbud014, #自定義欄位(數字)014
       nmbbud015 LIKE nmbb_t.nmbbud015, #自定義欄位(數字)015
       nmbbud016 LIKE nmbb_t.nmbbud016, #自定義欄位(數字)016
       nmbbud017 LIKE nmbb_t.nmbbud017, #自定義欄位(數字)017
       nmbbud018 LIKE nmbb_t.nmbbud018, #自定義欄位(數字)018
       nmbbud019 LIKE nmbb_t.nmbbud019, #自定義欄位(數字)019
       nmbbud020 LIKE nmbb_t.nmbbud020, #自定義欄位(數字)020
       nmbbud021 LIKE nmbb_t.nmbbud021, #自定義欄位(日期時間)021
       nmbbud022 LIKE nmbb_t.nmbbud022, #自定義欄位(日期時間)022
       nmbbud023 LIKE nmbb_t.nmbbud023, #自定義欄位(日期時間)023
       nmbbud024 LIKE nmbb_t.nmbbud024, #自定義欄位(日期時間)024
       nmbbud025 LIKE nmbb_t.nmbbud025, #自定義欄位(日期時間)025
       nmbbud026 LIKE nmbb_t.nmbbud026, #自定義欄位(日期時間)026
       nmbbud027 LIKE nmbb_t.nmbbud027, #自定義欄位(日期時間)027
       nmbbud028 LIKE nmbb_t.nmbbud028, #自定義欄位(日期時間)028
       nmbbud029 LIKE nmbb_t.nmbbud029, #自定義欄位(日期時間)029
       nmbbud030 LIKE nmbb_t.nmbbud030, #自定義欄位(日期時間)030
       nmbb070 LIKE nmbb_t.nmbb070, #往來據點
       nmbb071 LIKE nmbb_t.nmbb071, #來源單號
       nmbb072 LIKE nmbb_t.nmbb072, #項次
       nmbb073 LIKE nmbb_t.nmbb073  #開票帳號
       END RECORD
  DEFINE l_nmbc RECORD  #銀存收支異動檔
       nmbcent LIKE nmbc_t.nmbcent, #企業編號
       nmbcownid LIKE nmbc_t.nmbcownid, #資料所有者
       nmbcowndp LIKE nmbc_t.nmbcowndp, #資料所屬部門
       nmbccrtid LIKE nmbc_t.nmbccrtid, #資料建立者
       nmbccrtdp LIKE nmbc_t.nmbccrtdp, #資料建立部門
       nmbccrtdt LIKE nmbc_t.nmbccrtdt, #資料創建日
       nmbcmodid LIKE nmbc_t.nmbcmodid, #資料修改者
       nmbcmoddt LIKE nmbc_t.nmbcmoddt, #最近修改日
       nmbccnfid LIKE nmbc_t.nmbccnfid, #資料確認者
       nmbccnfdt LIKE nmbc_t.nmbccnfdt, #資料確認日
       nmbcpstid LIKE nmbc_t.nmbcpstid, #資料過帳者
       nmbcpstdt LIKE nmbc_t.nmbcpstdt, #資料過帳日
       nmbcstus LIKE nmbc_t.nmbcstus, #狀態碼
       nmbccomp LIKE nmbc_t.nmbccomp, #法人
       nmbcsite LIKE nmbc_t.nmbcsite, #資金中心
       nmbcdocno LIKE nmbc_t.nmbcdocno, #來源單號
       nmbcseq LIKE nmbc_t.nmbcseq, #項次
       nmbc001 LIKE nmbc_t.nmbc001, #單據來源
       nmbc002 LIKE nmbc_t.nmbc002, #交易帳戶編碼
       nmbc003 LIKE nmbc_t.nmbc003, #交易對象
       nmbc004 LIKE nmbc_t.nmbc004, #交易對象識別碼
       nmbc005 LIKE nmbc_t.nmbc005, #銀行日期
       nmbc006 LIKE nmbc_t.nmbc006, #異動別
       nmbc007 LIKE nmbc_t.nmbc007, #存提碼
       nmbc008 LIKE nmbc_t.nmbc008, #調節碼
       nmbc009 LIKE nmbc_t.nmbc009, #對帳碼
       nmbc010 LIKE nmbc_t.nmbc010, #網銀媒體檔轉出日期
       nmbc011 LIKE nmbc_t.nmbc011, #網銀媒體檔轉出批號
       nmbc100 LIKE nmbc_t.nmbc100, #交易帳戶幣別
       nmbc101 LIKE nmbc_t.nmbc101, #主帳套匯率
       nmbc103 LIKE nmbc_t.nmbc103, #主帳套原幣金額
       nmbc113 LIKE nmbc_t.nmbc113, #主帳套本幣金額
       nmbc121 LIKE nmbc_t.nmbc121, #主帳套本位幣二匯率
       nmbc123 LIKE nmbc_t.nmbc123, #主帳套本位幣二金額
       nmbc131 LIKE nmbc_t.nmbc131, #主帳套本位幣三匯率
       nmbc133 LIKE nmbc_t.nmbc133, #主帳套本位幣三金額
       nmbcud001 LIKE nmbc_t.nmbcud001, #自定義欄位(文字)001
       nmbcud002 LIKE nmbc_t.nmbcud002, #自定義欄位(文字)002
       nmbcud003 LIKE nmbc_t.nmbcud003, #自定義欄位(文字)003
       nmbcud004 LIKE nmbc_t.nmbcud004, #自定義欄位(文字)004
       nmbcud005 LIKE nmbc_t.nmbcud005, #自定義欄位(文字)005
       nmbcud006 LIKE nmbc_t.nmbcud006, #自定義欄位(文字)006
       nmbcud007 LIKE nmbc_t.nmbcud007, #自定義欄位(文字)007
       nmbcud008 LIKE nmbc_t.nmbcud008, #自定義欄位(文字)008
       nmbcud009 LIKE nmbc_t.nmbcud009, #自定義欄位(文字)009
       nmbcud010 LIKE nmbc_t.nmbcud010, #自定義欄位(文字)010
       nmbcud011 LIKE nmbc_t.nmbcud011, #自定義欄位(數字)011
       nmbcud012 LIKE nmbc_t.nmbcud012, #自定義欄位(數字)012
       nmbcud013 LIKE nmbc_t.nmbcud013, #自定義欄位(數字)013
       nmbcud014 LIKE nmbc_t.nmbcud014, #自定義欄位(數字)014
       nmbcud015 LIKE nmbc_t.nmbcud015, #自定義欄位(數字)015
       nmbcud016 LIKE nmbc_t.nmbcud016, #自定義欄位(數字)016
       nmbcud017 LIKE nmbc_t.nmbcud017, #自定義欄位(數字)017
       nmbcud018 LIKE nmbc_t.nmbcud018, #自定義欄位(數字)018
       nmbcud019 LIKE nmbc_t.nmbcud019, #自定義欄位(數字)019
       nmbcud020 LIKE nmbc_t.nmbcud020, #自定義欄位(數字)020
       nmbcud021 LIKE nmbc_t.nmbcud021, #自定義欄位(日期時間)021
       nmbcud022 LIKE nmbc_t.nmbcud022, #自定義欄位(日期時間)022
       nmbcud023 LIKE nmbc_t.nmbcud023, #自定義欄位(日期時間)023
       nmbcud024 LIKE nmbc_t.nmbcud024, #自定義欄位(日期時間)024
       nmbcud025 LIKE nmbc_t.nmbcud025, #自定義欄位(日期時間)025
       nmbcud026 LIKE nmbc_t.nmbcud026, #自定義欄位(日期時間)026
       nmbcud027 LIKE nmbc_t.nmbcud027, #自定義欄位(日期時間)027
       nmbcud028 LIKE nmbc_t.nmbcud028, #自定義欄位(日期時間)028
       nmbcud029 LIKE nmbc_t.nmbcud029, #自定義欄位(日期時間)029
       nmbcud030 LIKE nmbc_t.nmbcud030, #自定義欄位(日期時間)030
       nmbc012 LIKE nmbc_t.nmbc012, #票據號碼
       nmbc013 LIKE nmbc_t.nmbc013, #款別
       nmbc014 LIKE nmbc_t.nmbc014, #到期日
       nmbc015 LIKE nmbc_t.nmbc015, #匯入銀行編號
       nmbc016 LIKE nmbc_t.nmbc016, #匯入帳號
       nmbc017 LIKE nmbc_t.nmbc017, #受款人全名
       nmbcorga LIKE nmbc_t.nmbcorga  #來源組織
       END RECORD
  #161212-00005#2---modify-----end-------------
  

   #161212-00005#2---modify-----begin-------------
   #LET g_sql = "SELECT * FROM nmbb_t",
   LET g_sql = "SELECT nmbbent,nmbbcomp,nmbbdocno,nmbbseq,nmbborga,nmbblegl,nmbb001,nmbb002,nmbb003,nmbb004,",
               "nmbb005,nmbb006,nmbb007,nmbb008,nmbb009,nmbb010,nmbb011,nmbb012,nmbb013,nmbb014,nmbb015,nmbb016,",
               "nmbb017,nmbb018,nmbb019,nmbb020,nmbb021,nmbb022,nmbb023,nmbb024,nmbb025,nmbb026,nmbb027,nmbb028,",
               "nmbb029,nmbb030,nmbb031,nmbb032,nmbb033,nmbb034,nmbb035,nmbb036,nmbb037,nmbb038,nmbb039,nmbb040,",
               "nmbb041,nmbb042,nmbb043,nmbb044,nmbb045,nmbb046,nmbb047,nmbb048,nmbb049,nmbb050,nmbb051,nmbb052,",
               "nmbb053,nmbb054,nmbb055,nmbb056,nmbb057,nmbb058,nmbb059,nmbb060,nmbb061,nmbb062,nmbb063,nmbb064,",
               "nmbb065,nmbb066,nmbb067,nmbb068,nmbb069,nmbbud001,nmbbud002,nmbbud003,nmbbud004,nmbbud005,",
               "nmbbud006,nmbbud007,nmbbud008,nmbbud009,nmbbud010,nmbbud011,nmbbud012,nmbbud013,nmbbud014,nmbbud015,",
               "nmbbud016,nmbbud017,nmbbud018,nmbbud019,nmbbud020,nmbbud021,nmbbud022,nmbbud023,nmbbud024,nmbbud025,",
               "nmbbud026,nmbbud027,nmbbud028,nmbbud029,nmbbud030,nmbb070,nmbb071,nmbb072,nmbb073 FROM nmbb_t",
   #161212-00005#2---modify-----end-------------
               " WHERE nmbbent = '",g_enterprise,"'",
               "   AND nmbbcomp = '",g_nmba_m.nmbacomp,"'",
               "   AND nmbbdocno = '",g_nmba_m.nmbadocno,"'",
               "   AND (nmbb029 = '10' OR nmbb029 = '20')"

   PREPARE anmt540_pre1 FROM g_sql
   DECLARE anmt540_cs1 CURSOR FOR anmt540_pre1

   FOREACH anmt540_cs1 INTO l_nmbb.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      LET l_nmbc.nmbcent = g_enterprise
      LET l_nmbc.nmbccomp = l_nmbb.nmbbcomp
      LET l_nmbc.nmbcsite = g_nmba_m.nmbasite
      LET l_nmbc.nmbcdocno = l_nmbb.nmbbdocno
      LET l_nmbc.nmbcseq = l_nmbb.nmbbseq
      LET l_nmbc.nmbc001 = 'anmt540' #150904-00006#1
      LET l_nmbc.nmbc001 = g_prog #150904-00006#1
      LET l_nmbc.nmbc002 = l_nmbb.nmbb003
      LET l_nmbc.nmbc003 = l_nmbb.nmbb026
      LET l_nmbc.nmbc004 = l_nmbb.nmbb027
      LET l_nmbc.nmbc005 = g_nmba_m.nmbadocdt
      LET l_nmbc.nmbc006 = l_nmbb.nmbb001
      LET l_nmbc.nmbc007 = l_nmbb.nmbb002
      LET l_nmbc.nmbc008 = ''
      LET l_nmbc.nmbc009 = ''
      LET l_nmbc.nmbc010 = ''
      LET l_nmbc.nmbc011 = ''
      LET l_nmbc.nmbc012 = l_nmbb.nmbb030     #150818-00032#3
      LET l_nmbc.nmbc013 = l_nmbb.nmbb028     #150818-00032#3
      LET l_nmbc.nmbc014 = g_nmba_m.nmbadocdt #151012-00014#6
      LET l_nmbc.nmbc015 = ''                 #151012-00014#6
      LET l_nmbc.nmbc016 = ''                 #151012-00014#6
      LET l_nmbc.nmbc100 = l_nmbb.nmbb004
      LET l_nmbc.nmbc101 = l_nmbb.nmbb056
      LET l_nmbc.nmbc103 = l_nmbb.nmbb057
      LET l_nmbc.nmbc113 = l_nmbb.nmbb058
      LET l_nmbc.nmbc121 = l_nmbb.nmbb059
      LET l_nmbc.nmbc123 = l_nmbb.nmbb060
      LET l_nmbc.nmbc131 = l_nmbb.nmbb061
      LET l_nmbc.nmbc133 = l_nmbb.nmbb062
      LET l_nmbc.nmbcownid = g_user
      LET l_nmbc.nmbcowndp = g_dept
      LET l_nmbc.nmbccrtid = g_user
      LET l_nmbc.nmbccrtdp = g_dept
      LET l_nmbc.nmbccrtdt = cl_get_current()
      LET l_nmbc.nmbcorga = l_nmbb.nmbborga             #160322-00025#1 add lujh
      
      #161212-00005#2---modify-----begin-------------
      #INSERT INTO nmbc_t VALUES(l_nmbc.*)
      INSERT INTO nmbc_t (nmbcent,nmbcownid,nmbcowndp,nmbccrtid,nmbccrtdp,nmbccrtdt,nmbcmodid,nmbcmoddt,nmbccnfid,
                          nmbccnfdt,nmbcpstid,nmbcpstdt,nmbcstus,nmbccomp,nmbcsite,nmbcdocno,nmbcseq,nmbc001,nmbc002,
                          nmbc003,nmbc004,nmbc005,nmbc006,nmbc007,nmbc008,nmbc009,nmbc010,nmbc011,nmbc100,nmbc101,
                          nmbc103,nmbc113,nmbc121,nmbc123,nmbc131,nmbc133,nmbcud001,nmbcud002,nmbcud003,nmbcud004,
                          nmbcud005,nmbcud006,nmbcud007,nmbcud008,nmbcud009,nmbcud010,nmbcud011,nmbcud012,nmbcud013,
                          nmbcud014,nmbcud015,nmbcud016,nmbcud017,nmbcud018,nmbcud019,nmbcud020,nmbcud021,nmbcud022,
                          nmbcud023,nmbcud024,nmbcud025,nmbcud026,nmbcud027,nmbcud028,nmbcud029,nmbcud030,nmbc012,
                          nmbc013,nmbc014,nmbc015,nmbc016,nmbc017,nmbcorga)
       VALUES(l_nmbc.nmbcent,l_nmbc.nmbcownid,l_nmbc.nmbcowndp,l_nmbc.nmbccrtid,l_nmbc.nmbccrtdp,l_nmbc.nmbccrtdt,l_nmbc.nmbcmodid,l_nmbc.nmbcmoddt,l_nmbc.nmbccnfid,
              l_nmbc.nmbccnfdt,l_nmbc.nmbcpstid,l_nmbc.nmbcpstdt,l_nmbc.nmbcstus,l_nmbc.nmbccomp,l_nmbc.nmbcsite,l_nmbc.nmbcdocno,l_nmbc.nmbcseq,l_nmbc.nmbc001,l_nmbc.nmbc002,
              l_nmbc.nmbc003,l_nmbc.nmbc004,l_nmbc.nmbc005,l_nmbc.nmbc006,l_nmbc.nmbc007,l_nmbc.nmbc008,l_nmbc.nmbc009,l_nmbc.nmbc010,l_nmbc.nmbc011,l_nmbc.nmbc100,l_nmbc.nmbc101,
              l_nmbc.nmbc103,l_nmbc.nmbc113,l_nmbc.nmbc121,l_nmbc.nmbc123,l_nmbc.nmbc131,l_nmbc.nmbc133,l_nmbc.nmbcud001,l_nmbc.nmbcud002,l_nmbc.nmbcud003,l_nmbc.nmbcud004,
              l_nmbc.nmbcud005,l_nmbc.nmbcud006,l_nmbc.nmbcud007,l_nmbc.nmbcud008,l_nmbc.nmbcud009,l_nmbc.nmbcud010,l_nmbc.nmbcud011,l_nmbc.nmbcud012,l_nmbc.nmbcud013,
              l_nmbc.nmbcud014,l_nmbc.nmbcud015,l_nmbc.nmbcud016,l_nmbc.nmbcud017,l_nmbc.nmbcud018,l_nmbc.nmbcud019,l_nmbc.nmbcud020,l_nmbc.nmbcud021,l_nmbc.nmbcud022,
              l_nmbc.nmbcud023,l_nmbc.nmbcud024,l_nmbc.nmbcud025,l_nmbc.nmbcud026,l_nmbc.nmbcud027,l_nmbc.nmbcud028,l_nmbc.nmbcud029,l_nmbc.nmbcud030,l_nmbc.nmbc012,
              l_nmbc.nmbc013,l_nmbc.nmbc014,l_nmbc.nmbc015,l_nmbc.nmbc016,l_nmbc.nmbc017,l_nmbc.nmbcorga)
      #161212-00005#2---modify-----end-------------
      IF SQLCA.SQLcode  THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins nmbc_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET g_success = 'N'
         EXIT FOREACH
      END IF
   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: anmt540_update_amt()
# Memo...........:
# Usage..........: CALL anmt540_update_amt()
#                  RETURNING 回传参数
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt540_update_amt()
   DEFINE l_ooam003         LIKE ooam_t.ooam003
   DEFINE l_nmbbseq         LIKE nmbb_t.nmbbseq
   DEFINE l_nmbb004         LIKE nmbb_t.nmbb004
   DEFINE l_nmbb011         LIKE nmbb_t.nmbb011
   DEFINE l_nmbb015         LIKE nmbb_t.nmbb015
   DEFINE l_nmbb057         LIKE nmbb_t.nmbb057
   DEFINE l_nmbb058         LIKE nmbb_t.nmbb058
   DEFINE l_nmbb059         LIKE nmbb_t.nmbb059
   DEFINE l_nmbb060         LIKE nmbb_t.nmbb060
   DEFINE l_nmbb061         LIKE nmbb_t.nmbb061
   DEFINE l_nmbb062         LIKE nmbb_t.nmbb062

   LET g_sql = "SELECT nmbbseq,nmbb004,nmbb011,nmbb015,nmbb057,nmbb058 FROM nmbb_t ",
               " WHERE nmbbent = '",g_enterprise,"'",
               "   AND nmbbcomp = '",g_nmba_m.nmbacomp,"'",
               "   AND nmbbdocno = '",g_nmba_m.nmbadocno,"'"
   PREPARE anmt540_pre2 FROM g_sql
   DECLARE anmt540_cs2 CURSOR FOR anmt540_pre2

   FOREACH anmt540_cs2 INTO l_nmbbseq,l_nmbb004,l_nmbb011,l_nmbb015,l_nmbb057,l_nmbb058
      IF g_glaa015 = 'Y' THEN
         #來源幣別
         IF g_glaa017 = '1' THEN
           LET l_ooam003 = l_nmbb004
         ELSE   #表示帳簿幣別
            LET l_ooam003 = g_glaa001            #帳套使用幣別
         END IF

         #主帳套本位幣二匯率
                                  #匯率參照表;帳套;           日期;         來源幣別
         CALL s_aooi160_get_exrate('2',g_glaald,g_today,l_ooam003,
                                   #目的幣別;          交易金額; 匯類類型
                                   l_nmbb011,0,g_glaa018)
         RETURNING l_nmbb059

         #主帳套本位幣二金額
         IF g_glaa017 = '1'  THEN
            LET l_nmbb060 = l_nmbb057 * l_nmbb059
         ELSE
            LET l_nmbb060 = l_nmbb058 * l_nmbb059
         END IF
      END IF
      
       IF g_glaa019 = 'Y' THEN
         #來源幣別
         IF g_glaa021 = '1' THEN
            LET l_ooam003 = l_nmbb004
         ELSE   #表示帳簿幣別
            LET l_ooam003 = g_glaa001               #帳套使用幣別
         END IF


         #主帳套本位幣三匯率
                                  #匯率參照表;帳套;           日期;         來源幣別
         CALL s_aooi160_get_exrate('2',g_glaald,g_today,l_ooam003,
                                   #目的幣別;         交易金額; 匯類類型
                                   l_nmbb015,0,g_glaa022)
         RETURNING l_nmbb061

         #主帳套本位幣三金額
         IF g_glaa017 = '1' THEN
            LET l_nmbb062 = l_nmbb057 * l_nmbb061
         ELSE
            LET l_nmbb062 = l_nmbb058 * l_nmbb061
         END IF
      END IF

      UPDATE nmbb_t set nmbb059 = l_nmbb059,
                        nmbb060 = l_nmbb060,
                        nmbb061 = l_nmbb061,
                        nmbb062 = l_nmbb062
       WHERE nmbbent = g_enterprise
         AND nmbbseq = l_nmbbseq
         AND nmbbcomp = g_nmba_m.nmbacomp
         AND nmbbdocno = g_nmba_m.nmbadocno

      IF SQLCA.SQLcode  THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "upd nmbb_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET g_success = 'N'
         EXIT FOREACH
      END IF
   END FOREACH   

END FUNCTION

################################################################################
# Descriptions...: 檢查銀行存提碼
# Memo...........:
# Usage..........: CALL anmt540_nmbb002_chk()
#                  RETURNING 回传参数
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt540_nmbb002_chk()
DEFINE l_nmajstus               LIKE nmaj_t.nmajstus
DEFINE l_nmaj002                LIKE nmaj_t.nmaj002
   
   LET g_errno = ''
   
   SELECT nmajstus,nmaj002 INTO l_nmajstus,l_nmaj002
     FROM nmaj_t
    WHERE nmajent = g_enterprise
      AND nmaj001 = g_nmbb_d[l_ac].nmbb002

   CASE
      WHEN SQLCA.SQLCODE = 100    LET g_errno = 'anm-00017'
      WHEN l_nmajstus = 'N'       LET g_errno = 'anm-00016'
      WHEN l_nmaj002 <> '1'       LET g_errno = 'anm-00072'
   END CASE
   
   #帶值
   SELECT glaa005 INTO g_glaa005
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaacomp = g_nmba_m.nmbacomp
      AND glaa014 = 'Y'
      
   IF cl_null(g_nmbb_d[l_ac].nmbb010) THEN
      SELECT nmad003 INTO g_nmbb_d[l_ac].nmbb010
        FROM nmad_t
       WHERE nmadent = g_enterprise
         AND nmad001 = g_glaa005
         AND nmad002 = g_nmbb_d[l_ac].nmbb002
      DISPLAY g_nmbb_d[l_ac].nmbb010 TO s_detail1[l_ac].nmbb010
   END IF
   
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL anmt540_nmbb002_desc()
#                  RETURNING 回传参数
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt540_nmbb002_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_nmbb_d[l_ac].nmbb002
   CALL ap_ref_array2(g_ref_fields,"SELECT nmajl003 FROM nmajl_t WHERE nmajlent='"||g_enterprise||"' AND nmajl001=? AND nmajl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_nmbb_d[l_ac].nmbb002_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_nmbb_d[l_ac].nmbb002_desc
END FUNCTION

################################################################################
# Descriptions...: 自动产生现金变动码资料
# Memo...........:
# Usage..........: CALL anmt540_ins_glbc()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success      新增成功否
# Date & Author..: 2014/11/27 By wangrr
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt540_ins_glbc()
#161212-00005#2---modify-----begin-------------
#DEFINE l_glbc           RECORD LIKE glbc_t.*
DEFINE l_glbc RECORD  #現金變動碼明細檔
       glbcent LIKE glbc_t.glbcent, #企業編號
       glbcld LIKE glbc_t.glbcld, #帳套
       glbccomp LIKE glbc_t.glbccomp, #營運據點
       glbcdocno LIKE glbc_t.glbcdocno, #傳票編號
       glbcseq LIKE glbc_t.glbcseq, #項次
       glbcseq1 LIKE glbc_t.glbcseq1, #序號
       glbc001 LIKE glbc_t.glbc001, #年度
       glbc002 LIKE glbc_t.glbc002, #期別
       glbc003 LIKE glbc_t.glbc003, #借貸別
       glbc004 LIKE glbc_t.glbc004, #現金變動碼
       glbc005 LIKE glbc_t.glbc005, #交易客商
       glbc006 LIKE glbc_t.glbc006, #交易幣別
       glbc007 LIKE glbc_t.glbc007, #匯率
       glbc008 LIKE glbc_t.glbc008, #原幣金額
       glbc009 LIKE glbc_t.glbc009, #本幣金額
       glbc010 LIKE glbc_t.glbc010, #資料來源
       glbc011 LIKE glbc_t.glbc011, #匯率(本位幣二)
       glbc012 LIKE glbc_t.glbc012, #金額(本位幣二)
       glbc013 LIKE glbc_t.glbc013, #匯率(本位幣三)
       glbc014 LIKE glbc_t.glbc014, #金額(本位幣三)
       glbcud001 LIKE glbc_t.glbcud001, #自定義欄位(文字)001
       glbcud002 LIKE glbc_t.glbcud002, #自定義欄位(文字)002
       glbcud003 LIKE glbc_t.glbcud003, #自定義欄位(文字)003
       glbcud004 LIKE glbc_t.glbcud004, #自定義欄位(文字)004
       glbcud005 LIKE glbc_t.glbcud005, #自定義欄位(文字)005
       glbcud006 LIKE glbc_t.glbcud006, #自定義欄位(文字)006
       glbcud007 LIKE glbc_t.glbcud007, #自定義欄位(文字)007
       glbcud008 LIKE glbc_t.glbcud008, #自定義欄位(文字)008
       glbcud009 LIKE glbc_t.glbcud009, #自定義欄位(文字)009
       glbcud010 LIKE glbc_t.glbcud010, #自定義欄位(文字)010
       glbcud011 LIKE glbc_t.glbcud011, #自定義欄位(數字)011
       glbcud012 LIKE glbc_t.glbcud012, #自定義欄位(數字)012
       glbcud013 LIKE glbc_t.glbcud013, #自定義欄位(數字)013
       glbcud014 LIKE glbc_t.glbcud014, #自定義欄位(數字)014
       glbcud015 LIKE glbc_t.glbcud015, #自定義欄位(數字)015
       glbcud016 LIKE glbc_t.glbcud016, #自定義欄位(數字)016
       glbcud017 LIKE glbc_t.glbcud017, #自定義欄位(數字)017
       glbcud018 LIKE glbc_t.glbcud018, #自定義欄位(數字)018
       glbcud019 LIKE glbc_t.glbcud019, #自定義欄位(數字)019
       glbcud020 LIKE glbc_t.glbcud020, #自定義欄位(數字)020
       glbcud021 LIKE glbc_t.glbcud021, #自定義欄位(日期時間)021
       glbcud022 LIKE glbc_t.glbcud022, #自定義欄位(日期時間)022
       glbcud023 LIKE glbc_t.glbcud023, #自定義欄位(日期時間)023
       glbcud024 LIKE glbc_t.glbcud024, #自定義欄位(日期時間)024
       glbcud025 LIKE glbc_t.glbcud025, #自定義欄位(日期時間)025
       glbcud026 LIKE glbc_t.glbcud026, #自定義欄位(日期時間)026
       glbcud027 LIKE glbc_t.glbcud027, #自定義欄位(日期時間)027
       glbcud028 LIKE glbc_t.glbcud028, #自定義欄位(日期時間)028
       glbcud029 LIKE glbc_t.glbcud029, #自定義欄位(日期時間)029
       glbcud030 LIKE glbc_t.glbcud030, #自定義欄位(日期時間)030
       glbc015 LIKE glbc_t.glbc015 #狀態碼
       END RECORD

#161212-00005#2---modify-----end-------------
DEFINE r_success        LIKE type_t.num5
DEFINE l_glaa005        LIKE glaa_t.glaa005   
DEFINE l_glaa015        LIKE glaa_t.glaa015
DEFINE l_glaa019        LIKE glaa_t.glaa019
DEFINE l_month          LIKE type_t.num5
   
   
   #刪除原有現金變動碼
   CALL s_cashflow_nm_del_glbc(g_nmba_m.nmbadocdt,g_glaald,g_nmba_m.nmbadocno,g_nmbb_d[g_detail_idx].nmbbseq)
        RETURNING g_sub_success,g_errno
   
   LET r_success=TRUE
   INITIALIZE l_glbc.* TO NULL
   
   #150807-00007#1 add ------
   #款別性質=10&20才寫入一筆現金變動碼
   SELECT ooia002 INTO g_ooia002
     FROM ooia_t
    WHERE ooiaent = g_enterprise
      AND ooia001 = g_nmbb_d[g_detail_idx].nmbb028
   IF g_ooia002 NOT MATCHES '[123]0' THEN     #160105-00011#1 add 3 lujh
      RETURN r_success
   END IF
   #150807-00007#1 add end---
   
   LET l_glbc.glbcent   = g_enterprise
   LET l_glbc.glbcld    = g_glaald      #帳別 
   #法人
   SELECT glaacomp,glaa015,glaa019
   INTO l_glbc.glbccomp,l_glaa015,l_glaa019 
   FROM glaa_t 
   WHERE glaaent=g_enterprise AND glaald=g_glaald
   LET l_glbc.glbcdocno = g_nmba_m.nmbadocno  #匯款編號 
   LET l_glbc.glbcseq   = g_nmbb_d[g_detail_idx].nmbbseq #單身項次
   SELECT MAX(glbcseq1) + 1 INTO l_glbc.glbcseq1
     FROM glbc_t
    WHERE glbcent = g_enterprise
      AND glbcld =  l_glbc.glbcld
      AND glbcdocno = l_glbc.glbcdocno
      AND glbcseq = l_glbc.glbcseq
      AND glbc001 = g_glbc_m.glbc001
      AND glac002 = g_glbc_m.glbc002   
   IF cl_null(l_glbc.glbcseq1) THEN 
      LET l_glbc.glbcseq1 = 1
   END IF

   LET l_glbc.glbc001   = YEAR(g_nmba_m.nmbadocdt)  #年度 
   LET l_glbc.glbc002   = MONTH(g_nmba_m.nmbadocdt) #期別
   LET l_glbc.glbc003   = '1'  #借貸別

   #現金變動碼
   LET l_glbc.glbc004 = g_nmbb_d[g_detail_idx].nmbb010  #150807-00007#1
   
   #150807-00007#1 mark ------
   ##根據agli010 抓取anmi172現金異動碼
   #SELECT glaa005 INTO l_glaa005
   #  FROM glaa_t
   # WHERE glaaent = g_enterprise
   #   AND glaa014 = 'Y' 
   #   AND glaacomp = g_nmba_m.nmbacomp
   #SELECT nmad003 INTO l_glbc.glbc004
   #  FROM nmad_t
   # WHERE nmadent = g_enterprise
   #   AND nmad001 = l_glaa005 
   #   AND nmad002 = g_nmbb_d[g_detail_idx].nmbb002
   #150807-00007#1 mark end---   
   
   LET l_glbc.glbc005 = g_nmbb_d[g_detail_idx].nmbb026
   LET l_glbc.glbc006 = g_nmbb_d[g_detail_idx].nmbb004
   LET l_glbc.glbc007 = g_nmbb_d[g_detail_idx].nmbb005
   LET l_glbc.glbc008 = g_nmbb_d[g_detail_idx].nmbb006
   LET l_glbc.glbc009 = g_nmbb_d[g_detail_idx].nmbb007
   LET l_glbc.glbc010 = '2' 
   #--以下視主帳套有無啟用本位幣
   IF l_glaa015 = 'Y' THEN 
      LET l_glbc.glbc011 = g_nmbb_d[g_detail_idx].nmbb012
      LET l_glbc.glbc012 = g_nmbb_d[g_detail_idx].nmbb013
   END IF
   IF l_glaa019 = 'Y' THEN 
      LET l_glbc.glbc013 = g_nmbb_d[g_detail_idx].nmbb016
      LET l_glbc.glbc014 = g_nmbb_d[g_detail_idx].nmbb017 
   END IF
   
   LET l_glbc.glbc015   = g_nmba_m.nmbastus      #151013-00016#6
   
   #161212-00005#2---modify-----begin-------------
   #INSERT INTO glbc_t VALUES(l_glbc.*)
   INSERT INTO glbc_t (glbcent,glbcld,glbccomp,glbcdocno,glbcseq,glbcseq1,glbc001,glbc002,glbc003,glbc004,glbc005,glbc006,
                       glbc007,glbc008,glbc009,glbc010,glbc011,glbc012,glbc013,glbc014,glbcud001,glbcud002,glbcud003,glbcud004,
                       glbcud005,glbcud006,glbcud007,glbcud008,glbcud009,glbcud010,glbcud011,glbcud012,glbcud013,glbcud014,
                       glbcud015,glbcud016,glbcud017,glbcud018,glbcud019,glbcud020,glbcud021,glbcud022,glbcud023,glbcud024,
                       glbcud025,glbcud026,glbcud027,glbcud028,glbcud029,glbcud030,glbc015)
    VALUES(l_glbc.glbcent,l_glbc.glbcld,l_glbc.glbccomp,l_glbc.glbcdocno,l_glbc.glbcseq,l_glbc.glbcseq1,l_glbc.glbc001,l_glbc.glbc002,l_glbc.glbc003,l_glbc.glbc004,l_glbc.glbc005,l_glbc.glbc006,
           l_glbc.glbc007,l_glbc.glbc008,l_glbc.glbc009,l_glbc.glbc010,l_glbc.glbc011,l_glbc.glbc012,l_glbc.glbc013,l_glbc.glbc014,l_glbc.glbcud001,l_glbc.glbcud002,l_glbc.glbcud003,l_glbc.glbcud004,
           l_glbc.glbcud005,l_glbc.glbcud006,l_glbc.glbcud007,l_glbc.glbcud008,l_glbc.glbcud009,l_glbc.glbcud010,l_glbc.glbcud011,l_glbc.glbcud012,l_glbc.glbcud013,l_glbc.glbcud014,
           l_glbc.glbcud015,l_glbc.glbcud016,l_glbc.glbcud017,l_glbc.glbcud018,l_glbc.glbcud019,l_glbc.glbcud020,l_glbc.glbcud021,l_glbc.glbcud022,l_glbc.glbcud023,l_glbc.glbcud024,
           l_glbc.glbcud025,l_glbc.glbcud026,l_glbc.glbcud027,l_glbc.glbcud028,l_glbc.glbcud029,l_glbc.glbcud030,l_glbc.glbc015)
   #161212-00005#2---modify-----end-------------
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "insert glbc_t"
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET r_success=FALSE
   END IF 
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 現金變動碼檢核
# Memo...........:
# Usage..........: CALL anmt540_nmbb010_chk()
# Date & Author..: 2015/08/14 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt540_nmbb010_chk()
DEFINE l_nmaistus         LIKE nmai_t.nmaistus
   
   LET g_errno = ''
      
   SELECT nmaistus INTO l_nmaistus
     FROM nmai_t
    WHERE nmaient = g_enterprise
      AND nmai001 = g_glaa005
      AND nmai002 = g_nmbb_d[l_ac].nmbb010
   
   CASE
      WHEN SQLCA.SQLCODE = 100    LET g_errno = 'anm-00034'
      WHEN l_nmaistus = 'N'       LET g_errno = 'anm-00035'
   END CASE
END FUNCTION
# 刪除銀存收支異動檔 nmbc_t
PRIVATE FUNCTION anmt540_nmbc_delete()
   DELETE FROM nmbc_t 
    WHERE nmbcent = g_enterprise
      AND nmbcdocno = g_nmba_m.nmbadocno
      AND nmbccomp = g_nmba_m.nmbacomp
      
   IF SQLCA.SQLcode  THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "del nmbc_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
  
      LET g_success = 'N'                        
   END IF
END FUNCTION

################################################################################
# Descriptions...: 取消審核
# Memo...........: #151013-00016#3
# Usage..........: CALL anmt540_unverify()
# Date & Author..: 15/10/26 By RayHuang
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt540_unverify()
DEFINE lc_state LIKE type_t.chr5
DEFINE l_sql    STRING
DEFINE l_nmbb029  LIKE nmbb_t.nmbb029
DEFINE l_cnt      LIKE type_t.num10
DEFINE ls_js      STRING
DEFINE lc_param   RECORD
         xmab003  LIKE xmab_t.xmab003,          #單據編號
         xmab006  LIKE xmab_t.xmab006,          #交易客戶
         xmab007  LIKE xmab_t.xmab007,          #交易幣別
         proj     LIKE xmaa_t.xmaa002,          #目前計算項目
         proj_o   LIKE xmaa_t.xmaa002,          #前置計算項目
         type     LIKE type_t.num5,             #正負向
         glaald   LIKE glaa_t.glaald,           #帳套
         glaacomp LIKE glaa_t.glaacomp,         #法人
         xmab004  LIKE xmab_t.xmab004           #單據項次
              END RECORD
 
   LET lc_state = "Y"         
   IF g_nmba_m.nmbastus <> 'V' THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'anm-00056'
      LET g_errparam.extend = g_nmba_m.nmbadocno
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN
   END IF

   #161227-00022#1 add s---
   #若該收票已在anmt520產生異動單據，則不應該取消確認
   SELECT COUNT(*) INTO l_cnt
     FROM nmcq_t
     LEFT JOIN nmcr_t ON nmcqent = nmcrent AND nmcqcomp = nmcrcomp AND nmcqdocno = nmcrdocno
    WHERE nmcqent = g_enterprise
      AND nmcr003 = g_nmba_m.nmbadocno
      AND nmcqstus <> 'X'
   IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
   IF l_cnt > 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'anm-03041'
      LET g_errparam.extend = g_nmba_m.nmbadocno
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN
   END IF   
   #161227-00022#1 add e---
   
   LET l_cnt = 0 
   SELECT COUNT(*) INTO l_cnt FROM xrde_t
    WHERE xrdeent = g_enterprise AND xrde003 = g_nmba_m.nmbadocno
      AND xrdedocno NOT IN (SELECT xrdadocno FROM xrda_t WHERE xrdadocno = xrdedocno AND xrdastus = 'X' AND xrdaent=g_enterprise)   #161222-00013#1 ADD xul #170122-00008#1 add ENT
   IF l_cnt > 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'anm-02954'
      LET g_errparam.extend = g_nmba_m.nmbadocno
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN
   END IF

   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt FROM nmbt_t WHERE nmbtent = g_enterprise
                                            AND nmbt001 = '4'
                                            AND nmbt002 = g_nmba_m.nmbadocno
   IF l_cnt > 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'anm-00297'
      LET g_errparam.extend = g_nmba_m.nmbadocno
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN         
   END IF          
   CALL s_transaction_begin()
   LET lc_param.xmab003  = g_nmba_m.nmbadocno
   LET lc_param.glaacomp = g_nmba_m.nmbacomp
   LET lc_param.type   = '2'    #1:正向 2:負向
   LET l_sql = " SELECT nmbbseq,nmbb026,nmbb004,nmbb029 ",
               "   FROM nmbb_t ",
               "  WHERE nmbbent = ",g_enterprise,
               "    AND nmbbcomp= '",g_nmba_m.nmbacomp,"' AND nmbbdocno = '",g_nmba_m.nmbadocno,"'"
   PREPARE anmt540_credit_p2 FROM l_sql
   DECLARE anmt540_credit_c2 CURSOR FOR anmt540_credit_p2
   FOREACH anmt540_credit_c2 INTO lc_param.xmab004,lc_param.xmab006,lc_param.xmab007,l_nmbb029
      IF NOT cl_null(lc_param.xmab004) AND NOT cl_null(lc_param.xmab006) THEN
         IF l_nmbb029 = '30' THEN            
            LET lc_param.proj   = 'S9'    
         ELSE                             
            LET lc_param.proj   = 'S8'     
         END IF                           
         LET ls_js = util.JSON.stringify(lc_param)
         CALL s_credit_move(ls_js)  RETURNING g_sub_success
         IF NOT g_sub_success THEN
            CALL s_transaction_end('N','0')
            CLOSE anmt540_cl
            RETURN
         END IF
      END IF
   END FOREACH
   
   UPDATE nmba_t SET nmba009 = '',nmba002 = '',nmbastus = 'Y'   
    WHERE nmbaent = g_enterprise 
      AND nmbacomp = g_nmba_m.nmbacomp
      AND nmbadocno = g_nmba_m.nmbadocno
   IF SQLCA.sqlcode THEN
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   LET g_success = 'Y'   
   CALL anmt540_nmbc_delete()
   IF g_success = 'Y' THEN
      CALL s_transaction_end('Y','1')
      LET g_nmba_m.nmbastus = 'Y'
      CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
      DISPLAY BY NAME g_nmba_m.nmbastus
   ELSE
      CALL s_transaction_end('N','1')
      CALL gfrm_curr.setElementImage("statechange", "stus/32/verify.png")
      RETURN
   END IF
END FUNCTION

################################################################################
# Descriptions...: 编辑后立即审核
# Memo...........:
# Usage..........: CALL anmt540_immediately_conf()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2015/12/08 By 07166
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt540_immediately_conf()
#151125-00006#3--s
   DEFINE l_success         LIKE type_t.num5
   DEFINE l_doc_success     LIKE type_t.num5
   DEFINE l_slip            LIKE ooba_t.ooba002
   DEFINE l_dfin0031        LIKE type_t.chr1
   DEFINE l_count           LIKE type_t.num5
   DEFINE l_conf            LIKE type_t.chr1
   IF cl_null(g_glaald)           THEN RETURN END IF   #無資料直接返回不做處理
   IF cl_null(g_nmba_m.nmbacomp)  THEN RETURN END IF   #無資料直接返回不做處理
   IF cl_null(g_nmba_m.nmbadocno) THEN RETURN END IF   #無資料直接返回不做處理
    
   LET l_count = 0
   SELECT COUNT(*) INTO l_count FROM nmbb_t WHERE nmbbent = g_enterprise
      AND nmbbdocno = g_nmba_m.nmbadocno
      
   IF cl_null(l_count) THEN LET l_count = 0 END IF
   IF l_count = 0 THEN
      RETURN 
   END IF                   #单身無資料直接返回不做處理
   
   LET l_conf = 'Y'
   #取得單別
   CALL s_aooi200_fin_get_slip(g_nmba_m.nmbadocno) RETURNING l_success,l_slip
   #獲取單據別對應參數：收款審核是否分開審核
   CALL s_fin_get_doc_para(g_glaald,g_nmba_m.nmbacomp,l_slip,'D-FIN-4004') RETURNING l_conf   
   
   #取得單別設置的"是否直接審核"參數
   CALL s_fin_get_doc_para(g_glaald,g_nmba_m.nmbacomp,l_slip,'D-FIN-0031') RETURNING l_dfin0031

   IF cl_null(l_dfin0031) OR l_dfin0031 MATCHES '[Nn]' THEN RETURN END IF #參數值為空或為N則不做直接審核邏輯
   IF NOT cl_ask_confirm('aap-00403') THEN RETURN END IF  #询问是否立即审核?
   
   
   CALL s_transaction_begin()
   CALL cl_err_collect_init()
   LET l_doc_success = TRUE
    
 IF l_conf MATCHES '[Nn]' THEN
      IF NOT s_anmt540_verify_chk(g_nmba_m.nmbacomp,g_nmba_m.nmbadocno) THEN
         LET l_doc_success = FALSE
      END IF
      
      IF NOT s_anmt540_verify_upd(g_nmba_m.nmbacomp,g_nmba_m.nmbadocno) THEN
         LET l_doc_success = FALSE
      END IF

       #異動狀態碼欄位/修改人/修改日期
      LET g_nmba_m.nmbamoddt = cl_get_current()
      LET g_nmba_m.nmbacnfdt = cl_get_current()
      UPDATE nmba_t SET nmbastus = 'V',
                        nmbamodid= g_user,
                        nmbamoddt= g_nmba_m.nmbamoddt,
                        nmbacnfid= g_user,
                        nmbacnfdt= g_nmba_m.nmbacnfdt
       WHERE nmbaent = g_enterprise AND nmbacomp = g_nmba_m.nmbacomp
         AND nmbadocno = g_nmba_m.nmbadocno
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         LET l_doc_success = FALSE
      END IF
 ELSE 
      IF NOT s_anmt540_conf_chk(g_nmba_m.nmbacomp,g_nmba_m.nmbadocno) THEN
         LET l_doc_success = FALSE
      END IF
      
      IF NOT s_anmt540_conf_upd(g_nmba_m.nmbacomp,g_nmba_m.nmbadocno) THEN
         LET l_doc_success = FALSE
      END IF 
   
   #異動狀態碼欄位/修改人/修改日期
   LET g_nmba_m.nmbamoddt = cl_get_current()
   LET g_nmba_m.nmbacnfdt = cl_get_current()
   UPDATE nmba_t SET nmbastus = 'Y',
                     nmbamodid= g_user,
                     nmbamoddt= g_nmba_m.nmbamoddt,
                     nmbacnfid= g_user,
                     nmbacnfdt= g_nmba_m.nmbacnfdt
    WHERE nmbaent = g_enterprise AND nmbacomp = g_nmba_m.nmbacomp
      AND nmbadocno = g_nmba_m.nmbadocno
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      LET l_doc_success = FALSE
   END IF
 END IF 
   
   IF l_doc_success = TRUE THEN
      CALL s_transaction_end('Y',1)
   ELSE
      CALL s_transaction_end('N',1)
      CALL cl_err_collect_show()
   END IF
#151125-00006#3--e
END FUNCTION

################################################################################
# Descriptions...: 1,当款别刷子028的款别性质ooia002 in(10,20)时,存提码nmbb002,现金码nmbb010   AFTERFIELD 里检查不可为空
# Memo...........:
# Usage..........: CALL anmt540_nmbb001_entry()
# Date & Author..: 2015/12/24 By yangtt
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt540_nmbb001_entry()
DEFINE l_ooia002           LIKE ooia_t.ooia002

   SELECT ooia002 INTO l_ooia002 FROM ooia_t WHERE ooiaent = g_enterprise AND ooia001 = g_nmbb_d[l_ac].nmbb028
          
   CALL cl_set_comp_required('nmbb002,nmbb010',FALSE)
#   IF l_ooia002 = '10' OR l_ooia002  = '20' THEN #160530-00005#4 mark
   IF g_conf = 'N' AND l_ooia002 = '10' OR l_ooia002  = '20' THEN #160530-00005#4 add
      CALL cl_set_comp_required('nmbb002,nmbb010',TRUE)
   ELSE
      CALL cl_set_comp_required('nmbb002,nmbb010',FALSE)
   END IF
END FUNCTION

################################################################################
# Descriptions...:  
# Memo...........:
# Usage..........: CALL anmt540_nmbasite_chk()
# Date & Author..: 2016/09/12 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt540_nmbasite_chk()
DEFINE l_ooef RECORD
                 ooef206  LIKE ooef_t.ooef206,
                 ooefstus LIKE ooef_t.ooefstus
              END RECORD
   LET g_errno = ''
   SELECT ooef206,ooefstus INTO l_ooef.*
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_nmba_m.nmbasite
   CASE
      WHEN SQLCA.SQLCODE = 100 LET g_errno = 'aoo-00094'
      WHEN l_ooef.ooefstus = 'N' LET g_errno = 'sub-01302' #aoo-00095   #160318-00005#27 by 07900 --mod
      WHEN l_ooef.ooef206 <> 'Y' LET g_errno = 'anm-00272'
   END CASE
END FUNCTION

 
{</section>}
 
