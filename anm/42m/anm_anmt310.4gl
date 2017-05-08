#該程式未解開Section, 採用最新樣板產出!
{<section id="anmt310.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0024(2016-09-29 16:03:31), PR版次:0024(2017-01-17 14:49:05)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000753
#+ Filename...: anmt310
#+ Description: 銀存收支維護作業
#+ Creator....: 02114(2013-11-08 10:31:45)
#+ Modifier...: 01531 -SD/PR- 08729
 
{</section>}
 
{<section id="anmt310.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#150603-00041#1   2015/06/04 By apo      單身繳款人員,取說明時沒有取到值
#150417-00007#51  2015/06/04 By 01727    加一个来源为adet402收银员短款单，不可新增这个来源，只显示
#150616-00026#12  2015/06/22 By apo      1.單別加入是否產生分錄底稿之參數,且將畫面上暫收的欄位隱藏,值則參考參數值給予(150622 By Thomas)
#                                        2.不從anmt310串action至anmt311;只從anmt311回抓
#150707-00001#2   2015/07/09 By apo      各本位幣金額/匯率欄位應根據各本位幣別各自取位
#150714-00024#1   2015/07/15 By Reanna   bug修正
#150401-00001#13  2015/07/21 By RayHuang statechange段問題修正
#150807-00007#1   2015/08/13 By Reanna   變動時需重產現金變動碼
#150818-00032#3   2015/08/23 By RayHuang nmbc_t新增兩個欄位
#150831-00004#1   2015/08/31 By yangtt   刪除資料時，判斷資料來源(nmba003='adet402'),則需更新adet402單頭deag006為空
#150930-00010#4   2015/10/02 By 03538    異動類型屬於支出時,匯率來源參數參照S-FIN-4012,且日平均匯率以新元件計算;透過匯率元件回傳的匯率不用再取一次位;匯率取位依原幣
#151016-00018#1   2015/10/19 By Jessy    1.anmt310增加複製功能 2.anmt310增加針對本位幣一增加合計顯示(類似aapt420的合計畫面):增加 借方/存入及 貸方/提出合計 3.anmt310報表增加存入/提出/借方/貸方合計
#151016-00018#2   2015/10/20 By Jessy    複製後 1.不開放帳務中心與法人修改 2.帳務單號/傳票號碼/修改者資訊清空 3.單身匯率依當日匯率重新預設,並依新匯率推算本幣金額
#150401-00001#31  2015/10/22 By Hans     修改狀況下把日期鎖掉，但新增時卻未開啟
#151012-00014#6   2015/10/26 By RayHuang nmbc_t新增三個欄位(nmbc014~nmbc016)
#151013-00016#6   2015/10/28 By RayHuang glbc_t新增狀態碼
#151125-00006#3   2015/12/03 By 07166    新增[編輯完單據後立即審核]功能
#151130-00015#2   2015/12/18 BY XIAOZG   根据是否可以更改單據日期 設定開放單據日期修改
#151222-00010#1   2015/12/24 By yangtt   AFTER ROW 检查，若异动别 in(1:存入,2:提出),则，存提码nmbb002不为空，glbc档有相应的资料不为空（glbcld+glbcdocno+glbcseq)
#150813-00015#3   2016/01/19 By 02599    增加日期控管，日期不可小于等于关账日期
#160122-00001#26  2016/02/17 By 07673    添加交易账户编号用户权限控管
#160322-00025#1   2016/03/22 By 02114    nmbc_t增加nmbcorga记示画面上的来源组织栏位，原nmbcsite依旧记录资金中心
#160318-00005#27  2016/03/24 By 07900    重复错误信息修改
#160120-00029#1   2016/03/28 By 01531    录入或修改，异动别=1存入或2提出时，币别字段应由交易账户nmbb003带出，且不能修改。   
#160321-00016#39  2016/03/30 By Jessy    將重複內容的錯誤訊息置換為公用錯誤訊息
#160428-00019#1   2016/04/28 By Dido     取消確認時需排除 anmt311 已作廢的資料
#160509-00004#20  2016/05/17 By liyan    增加往来据点
#160326-00001#26  2016/08/05 By 01531    来源作业类型使用scc-8741
#160326-00001#36  2016/08/10 By 01531    来源作业类型scc-8741改为程式代号
#160816-00012#3   2016/09/01 By 01727    ANM增加资金中心，帐套，法人三个栏位权限
#160912-00024#1   2016/09/20 By 01531    来源组织权限控管
#160913-00017#6   2016/09/23 By 07900    ANM模组调整交易客商开窗
#160518-00024#14  2016/09/29 By 01531    1.單身加欄位增加來源單號,項次
#                                        2.單頭增加來源作業:aapt352 零用金撥補申請單
#                                        3.topmenu 增加零用金撥補申請單處理 :取aapt352 申請單轉入anmt310
#161021-00050#8   2016/10/26 By Reanna   资金中心开窗需调整为q_ooef001_33新增时where条件限定ooefstus= 'Y'查询时不限定此条件；
#                                        法人开窗调整为q_ooef001_2,要注意原本where条件中的权限设置要保留;
#                                        来源组织/nmbb070见excel"资金单身来源组织"
#161026-00004#1   2016/11/02 By 01531    单身【银行存提码】可以任意输入，无检核
#161104-00030#1   2016/11/04 By 01531    还原原本的借貸及收支平衡檢核，單身有二筆以上者, 則作借貸的平衡.
#160822-00012#5   2016/11/10 By 08732    新舊值調整
#161110-00001#1   2016/11/28 By 07900    ANM模組使用ooea_t/ooeaf_t的需替換ooef_t/ooefl_t
#161130-00055#1   2016/12/01 By Jessica  BPM整合功能修正:
#                                        1.抽單/已拒絕狀態下，不能按修改及刪除功能鈕
#                                        2.借貸項合計欄位amt1_d, amt2_d, amt3_c, amt4_4，提交未拋值BPM
#161219-00014#2   2016/12/27 By 07900    标准程式定义采用宣告模式,弃用.*写法
#170112-00020#1   2017/01/13 By 01531    anmt310录完单据后修改日期到跨月后，审核报错提示现金变动码不存在，此时，整单操作维护现金变动码后，后台glbc_t一共产生2比数据， 其中有一笔是错误的，会导致后面作业的金额翻倍;
#                                        并且删除anmt310的时候，异常的数据也删除不掉，一直留在那里，请修改！
#161104-00046#12  2017/01/17 By 08729    單別預設值;資料依照單別user dept權限過濾單號
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
   nmba002 LIKE nmba_t.nmba002, 
   nmba002_desc LIKE type_t.chr80, 
   nmbacomp LIKE nmba_t.nmbacomp, 
   nmbacomp_desc LIKE type_t.chr80, 
   nmbadocno LIKE nmba_t.nmbadocno, 
   nmbadocdt LIKE nmba_t.nmbadocdt, 
   nmba003 LIKE nmba_t.nmba003, 
   nmba003_desc LIKE type_t.chr200, 
   nmba015 LIKE nmba_t.nmba015, 
   nmba004 LIKE nmba_t.nmba004, 
   nmba004_desc LIKE type_t.chr80, 
   nmba005 LIKE nmba_t.nmba005, 
   nmba006 LIKE nmba_t.nmba006, 
   nmba007 LIKE nmba_t.nmba007, 
   l_nmbs003 LIKE type_t.chr500, 
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
   nmbb071 LIKE nmbb_t.nmbb071, 
   nmbb072 LIKE nmbb_t.nmbb072, 
   nmbb053 LIKE nmbb_t.nmbb053, 
   nmbb053_desc LIKE type_t.chr100, 
   nmbb054 LIKE nmbb_t.nmbb054, 
   nmbb054_desc LIKE type_t.chr100, 
   nmbb070 LIKE nmbb_t.nmbb070, 
   nmbb070_desc LIKE type_t.chr500, 
   nmbblegl LIKE type_t.chr10, 
   nmbb001 LIKE nmbb_t.nmbb001, 
   nmbb002 LIKE nmbb_t.nmbb002, 
   nmbb002_desc LIKE type_t.chr500, 
   nmbb003 LIKE nmbb_t.nmbb003, 
   nmbb003_desc LIKE type_t.chr500, 
   nmbb029 LIKE nmbb_t.nmbb029, 
   nmbb004 LIKE nmbb_t.nmbb004, 
   nmbb005 LIKE nmbb_t.nmbb005, 
   nmbb006 LIKE nmbb_t.nmbb006, 
   nmbb007 LIKE nmbb_t.nmbb007, 
   nmbb010 LIKE nmbb_t.nmbb010, 
   nmbb010_desc LIKE type_t.chr500, 
   nmbb025 LIKE nmbb_t.nmbb025, 
   nmbb011 LIKE nmbb_t.nmbb011, 
   nmbb012 LIKE nmbb_t.nmbb012, 
   nmbb013 LIKE nmbb_t.nmbb013, 
   nmbb014 LIKE nmbb_t.nmbb014, 
   nmbb015 LIKE nmbb_t.nmbb015, 
   nmbb016 LIKE nmbb_t.nmbb016, 
   nmbb017 LIKE nmbb_t.nmbb017, 
   nmbb018 LIKE nmbb_t.nmbb018, 
   nmbb008 LIKE nmbb_t.nmbb008, 
   nmbb009 LIKE nmbb_t.nmbb009, 
   nmbb019 LIKE nmbb_t.nmbb019, 
   nmbb020 LIKE nmbb_t.nmbb020, 
   nmbb021 LIKE nmbb_t.nmbb021, 
   nmbb022 LIKE nmbb_t.nmbb022, 
   nmbb023 LIKE nmbb_t.nmbb023, 
   nmbb024 LIKE nmbb_t.nmbb024, 
   nmbb026 LIKE nmbb_t.nmbb026, 
   nmbb027 LIKE nmbb_t.nmbb027, 
   nmbb056 LIKE nmbb_t.nmbb056, 
   nmbb057 LIKE nmbb_t.nmbb057, 
   nmbb058 LIKE nmbb_t.nmbb058, 
   nmbb059 LIKE nmbb_t.nmbb059, 
   nmbb060 LIKE nmbb_t.nmbb060, 
   nmbb061 LIKE nmbb_t.nmbb061, 
   nmbb062 LIKE nmbb_t.nmbb062, 
   nmbb066 LIKE nmbb_t.nmbb066, 
   nmbb067 LIKE nmbb_t.nmbb067, 
   nmbb068 LIKE nmbb_t.nmbb068
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_nmbacomp LIKE nmba_t.nmbacomp,
      b_nmbadocno LIKE nmba_t.nmbadocno
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_ooag004             LIKE ooag_t.ooag004
DEFINE g_nmbacomp            LIKE nmba_t.nmbacomp
DEFINE g_ooef001             LIKE ooef_t.ooef001
DEFINE g_ooef014             LIKE ooef_t.ooef014
DEFINE g_ooef016             LIKE ooef_t.ooef016
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
DEFINE g_glaa003             LIKE glaa_t.glaa003
DEFINE g_glaa024             LIKE glaa_t.glaa024
#2015/02/02 add by qiull(S)
DEFINE g_glaa026             LIKE glaa_t.glaa026
DEFINE g_ooaj0042            LIKE ooaj_t.ooaj004
DEFINE g_ooaj0043            LIKE ooaj_t.ooaj004
DEFINE g_ooaj0052            LIKE ooaj_t.ooaj005
DEFINE g_ooaj0053            LIKE ooaj_t.ooaj005
#2015/02/02 add by qiull(E)
#DEFINE g_glaald_1            LIKE glaa_t.glaald       #次帳套一
#DEFINE g_glaald_2            LIKE glaa_t.glaald       #次帳套二
#DEFINE g_glaa001_1           LIKE glaa_t.glaa001      #次帳套一使用幣別
#DEFINE g_glaa001_2           LIKE glaa_t.glaa001      #次帳套二使用幣別
DEFINE g_flag                LIKE type_t.chr1

TYPE type_g_nmbb2_d          RECORD
                                nmbb011_1 LIKE nmbb_t.nmbb011,
                                nmbb012_1 LIKE nmbb_t.nmbb012,
                                nmbb013_1 LIKE nmbb_t.nmbb013,
                                nmbb014_1 LIKE nmbb_t.nmbb014,
                                nmbb015_1 LIKE nmbb_t.nmbb015,
                                nmbb016_1 LIKE nmbb_t.nmbb016,
                                nmbb017_1 LIKE nmbb_t.nmbb017,
                                nmbb018_1 LIKE nmbb_t.nmbb018
                             END RECORD
      
TYPE type_g_nmbb3_d          RECORD
                                nmbbseq_1 LIKE nmbb_t.nmbbseq,
                                nmbb008_1 LIKE nmbb_t.nmbb008,
                                nmbb009_1 LIKE nmbb_t.nmbb009,
                                nmbb019_1 LIKE nmbb_t.nmbb019,
                                nmbb020_1 LIKE nmbb_t.nmbb020,
                                nmbb021_1 LIKE nmbb_t.nmbb021,
                                nmbb022_1 LIKE nmbb_t.nmbb022,
                                nmbb023_1 LIKE nmbb_t.nmbb023,
                                nmbb024_1 LIKE nmbb_t.nmbb024
                             END RECORD
       
DEFINE g_nmbb2_d             DYNAMIC ARRAY OF type_g_nmbb2_d
DEFINE g_nmbb3_d             DYNAMIC ARRAY OF type_g_nmbb3_d
DEFINE g_ooef017             LIKE ooef_t.ooef017
DEFINE g_para_data           LIKE type_t.chr80         #資金模組匯率來源
DEFINE g_site_wc             STRING                    #150714-00024#1
DEFINE g_comp_wc             STRING                    #150714-00024#1

#151016-00018#1-----s
#借貸項合計
DEFINE g_amt1_d         LIKE nmbb_t.nmbb006
DEFINE g_amt2_d         LIKE nmbb_t.nmbb006
DEFINE g_amt3_c         LIKE nmbb_t.nmbb006
DEFINE g_amt4_c         LIKE nmbb_t.nmbb006
#151016-00018#1-----e
DEFINE g_sql_bank       STRING #160122-00001#26 add
#161130-00055#1-S
DEFINE g_other          RECORD               #例外欄位資料
         amt1_d         LIKE nmbb_t.nmbb006,
         amt2_d         LIKE nmbb_t.nmbb006,
         amt3_c         LIKE nmbb_t.nmbb006,
         amt4_c         LIKE nmbb_t.nmbb006
                        END RECORD
#161130-00055#1-E
DEFINE g_user_dept_wc       STRING      #161104-00046#12
DEFINE g_user_dept_wc_q     STRING      #161104-00046#12
DEFINE g_user_slip_wc       STRING      #161104-00046#12
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
 
{<section id="anmt310.main" >}
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
   #161104-00046#12-----s
   #建立與單頭array相同的temptable
   CALL s_aooi200def_create('','g_nmba_m','','','','','','')RETURNING g_sub_success
   
   #單別控制組
   LET g_user_dept_wc = ''
   CALL s_fin_get_user_dept_control('nmbacomp','','nmbaent','nmbadocno') RETURNING g_user_dept_wc
   #開窗使用
   LET g_user_dept_wc_q = g_user_dept_wc
   
   CALL s_control_get_docno_sql(g_user,g_dept) RETURNING g_sub_success,g_user_slip_wc  
   #161104-00046#12-----e
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT nmbasite,'',nmba002,'',nmbacomp,'',nmbadocno,nmbadocdt,nmba003,'',nmba015, 
       nmba004,'',nmba005,nmba006,nmba007,'',nmbastus,nmbaownid,'',nmbaowndp,'',nmbacrtid,'',nmbacrtdp, 
       '',nmbacrtdt,nmbamodid,'',nmbamoddt,nmbacnfid,'',nmbacnfdt", 
                      " FROM nmba_t",
                      " WHERE nmbaent= ? AND nmbacomp=? AND nmbadocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE anmt310_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.nmbasite,t0.nmba002,t0.nmbacomp,t0.nmbadocno,t0.nmbadocdt,t0.nmba003, 
       t0.nmba015,t0.nmba004,t0.nmba005,t0.nmba006,t0.nmba007,t0.nmbastus,t0.nmbaownid,t0.nmbaowndp, 
       t0.nmbacrtid,t0.nmbacrtdp,t0.nmbacrtdt,t0.nmbamodid,t0.nmbamoddt,t0.nmbacnfid,t0.nmbacnfdt,t1.ooefl003 , 
       t2.ooefl003 ,t3.pmaal004 ,t4.ooag011 ,t5.ooefl003 ,t6.ooag011 ,t7.ooefl003 ,t8.ooag011 ,t9.ooag011", 
 
               " FROM nmba_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.nmbasite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.nmbacomp AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t3 ON t3.pmaalent="||g_enterprise||" AND t3.pmaal001=t0.nmba004 AND t3.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=t0.nmbaownid  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.nmbaowndp AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.nmbacrtid  ",
               " LEFT JOIN ooefl_t t7 ON t7.ooeflent="||g_enterprise||" AND t7.ooefl001=t0.nmbacrtdp AND t7.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=t0.nmbamodid  ",
               " LEFT JOIN ooag_t t9 ON t9.ooagent="||g_enterprise||" AND t9.ooag001=t0.nmbacnfid  ",
 
               " WHERE t0.nmbaent = " ||g_enterprise|| " AND t0.nmbacomp = ? AND t0.nmbadocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE anmt310_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_anmt310 WITH FORM cl_ap_formpath("anm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL anmt310_init()   
 
      #進入選單 Menu (="N")
      CALL anmt310_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_anmt310
      
   END IF 
   
   CLOSE anmt310_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="anmt310.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION anmt310_init()
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
      CALL cl_set_combo_scc_part('nmbastus','13','N,Y,V,A,D,R,W,X')
 
      CALL cl_set_combo_scc('nmbb001','8701') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   #CALL cl_set_combo_scc('nmba003','8707') 
   CALL cl_set_combo_scc('nmbb001','8701')
   CALL s_fin_create_account_center_tmp()
   CALL cl_set_toolbaritem_visible("open_anmt311", FALSE)   #150616-00026#12
   #160122-00001#26--add--str--
   LET g_sql_bank=NULL
   CALL s_anmi120_get_bank_account_sql(g_user,g_dept) RETURNING g_sub_success,g_sql_bank
   #160122-00001#26--add--end
   CALL cl_set_combo_scc('nmba003','8741') #160326-00001#26 add
   #end add-point
   
   #初始化搜尋條件
   CALL anmt310_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="anmt310.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION anmt310_ui_dialog()
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
   DEFINE l_cnt     LIKE type_t.num5
   DEFINE l_glaald  LIKE glaa_t.glaald
   DEFINE l_oobn003 LIKE oobn_t.oobn003
   DEFINE l_lisp    LIKE ooba_t.ooba002
   DEFINE l_success LIKE type_t.num5 
   DEFINE l_glaa008 LIKE glaa_t.glaa008
   DEFINE  l_n      LIKE type_t.num10          #151125-00006#3
   DEFINE l_docno   LIKE nmba_t.nmbadocno      #160518-00024#14 
   DEFINE l_year_o  LIKE type_t.num5 #170112-00020#1 add
   DEFINE l_month_o LIKE type_t.num5 #170112-00020#1 add   
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
            CALL anmt310_insert()
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
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL anmt310_init()
      END IF
   
            
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
    
         DISPLAY ARRAY g_nmbb_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL anmt310_idx_chk()
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
               CALL anmt310_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_nmbb2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)

            BEFORE ROW
               CALL anmt310_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac

            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               CALL anmt310_idx_chk()
               LET g_current_page = 2

         END DISPLAY
         
         DISPLAY ARRAY g_nmbb3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)

            BEFORE ROW
               CALL anmt310_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_detail_idx = l_ac

            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               CALL anmt310_idx_chk()
               LET g_current_page = 3

         END DISPLAY
         #end add-point
         
      
         BEFORE DIALOG
            #先填充browser資料
            CALL anmt310_browser_fill("")
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
               CALL anmt310_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL anmt310_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL anmt310_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL anmt310_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL anmt310_set_act_visible()   
            CALL anmt310_set_act_no_visible()
            IF NOT (g_nmba_m.nmbacomp IS NULL
              OR g_nmba_m.nmbadocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " nmbaent = " ||g_enterprise|| " AND",
                                  " nmbacomp = '", g_nmba_m.nmbacomp, "' "
                                  ," AND nmbadocno = '", g_nmba_m.nmbadocno, "' "
 
               #填到對應位置
               CALL anmt310_browser_fill("")
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
                     WHEN la_wc[li_idx].tableid = "nmba_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "nmbb_t" 
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
               CALL anmt310_browser_fill("F")   #browser_fill()會將notice區塊清空
            END IF
         
         #查詢方案選擇
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "nmba_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "nmbb_t" 
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
                  CALL anmt310_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL anmt310_fetch("F")
                  END IF
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
          
         
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL anmt310_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL anmt310_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL anmt310_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL anmt310_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL anmt310_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL anmt310_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL anmt310_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL anmt310_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL anmt310_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL anmt310_idx_chk()
          
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
 
                  #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
                  LET g_export_node[2] = base.typeInfo.create(g_nmbb2_d)
                  LET g_export_id[2]   = "s_detail2"
                  LET g_export_node[3] = base.typeInfo.create(g_nmbb3_d)
                  LET g_export_id[3]   = "s_detail3"
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
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL anmt310_modify()
               #add-point:ON ACTION modify name="menu.modify"
               #151125-00006#3--s           
               CALL anmt310_immediately_conf()
               SELECT COUNT(*) INTO l_n FROM nmba_t
                WHERE nmbaent = g_enterprise AND nmbacomp = g_nmba_m.nmbacomp AND nmbadocno = g_nmba_m.nmbadocno
                IF l_n > 0 THEN CALL anmt310_ui_headershow() END IF
               #151125-00006#3--e
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL anmt310_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               #151125-00006#3--s           
               CALL anmt310_immediately_conf()
               SELECT COUNT(*) INTO l_n FROM nmba_t
                WHERE nmbaent = g_enterprise AND nmbacomp = g_nmba_m.nmbacomp AND nmbadocno = g_nmba_m.nmbadocno
                IF l_n > 0 THEN CALL anmt310_ui_headershow() END IF
               #151125-00006#3--e
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION anmt310_02
            LET g_action_choice="anmt310_02"
            IF cl_auth_chk_act("anmt310_02") THEN
               
               #add-point:ON ACTION anmt310_02 name="menu.anmt310_02"
               #160518-00024#14 add s---
               CALL anmt310_02() RETURNING l_docno
               IF NOT cl_null(l_docno) THEN
                  LET g_nmba_m.nmbadocno = l_docno
                  #把產生的那張顯示出來
                  LET g_wc = " nmbaent = ",g_enterprise," AND nmbadocno = '",g_nmba_m.nmbadocno,"' "
                  CALL anmt310_browser_fill('')
                  LET g_no_ask = TRUE
                  LET g_jump = 1
                  CALL anmt310_fetch('/')
                  CALL anmt310_idx_chk()
               END IF
               #160518-00024#14 add e---
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL anmt310_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL anmt310_insert()
               #add-point:ON ACTION insert name="menu.insert"
               #151125-00006#3--s           
               CALL anmt310_immediately_conf()
               SELECT COUNT(*) INTO l_n FROM nmba_t
                WHERE nmbaent = g_enterprise AND nmbacomp = g_nmba_m.nmbacomp AND nmbadocno = g_nmba_m.nmbadocno
                IF l_n > 0 THEN CALL anmt310_ui_headershow() END IF
               #151125-00006#3--e
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               LET g_rep_wc = " nmbaent = '",g_enterprise,"' AND nmbadocno = '",g_nmba_m.nmbadocno,"' "
               #END add-point
               &include "erp/anm/anmt310_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               LET g_rep_wc = " nmbaent = '",g_enterprise,"' AND nmbadocno = '",g_nmba_m.nmbadocno,"' "
               #END add-point
               &include "erp/anm/anmt310_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL anmt310_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_anmt311
            LET g_action_choice="open_anmt311"
            IF cl_auth_chk_act("open_anmt311") THEN
               
               #add-point:ON ACTION open_anmt311 name="menu.open_anmt311"
#-150616-00026#12-mark--(s)               
#               IF g_nmba_m.nmbastus <> 'Y' AND g_nmba_m.nmbastus <> 'V' THEN 
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = 'anm-00196'
#                  LET g_errparam.extend = ''
#                  LET g_errparam.popup = TRUE
#                  CALL cl_err()
#                  EXIT DIALOG
#               END IF
#               
#               IF NOT cl_null(g_nmba_m.nmba007) THEN 
#                  LET la_param.prog = "anmt311"
#                  LET la_param.param[1] = g_glaald
#                  LET la_param.param[2] = g_nmba_m.nmba007
#                  LET ls_js = util.JSON.stringify(la_param)
#                  CALL cl_cmdrun(ls_js)
#               ELSE
#                  LET l_cnt = 1
#                  SELECT COUNT(*) INTO l_cnt FROM glaa_t 
#                   WHERE glaaent = g_enterprise  #2015/03/31 add by 02599
#                     AND glaacomp = g_nmba_m.nmbacomp 
#                     AND glaa008 = 'Y'  #平行帳套
#                     
#                  IF  l_cnt > 1 THEN 
#                      LET  l_glaald = ''
#                      LET l_glaa008='Y'
#                  ELSE 
#                      LET l_glaald = g_glaald     #帳套=主帳套代碼,不可異動
#                      LET l_glaa008='N'
#                  END IF 
#                  
#                  #CALL s_aooi200_get_slip(g_nmba_m.nmbadocno) RETURNING l_success,l_lisp       #2014/12/26 liuym mark
#                  CALL s_aooi200_fin_get_slip(g_nmba_m.nmbadocno) RETURNING l_success,l_lisp    #2014/12/26 liuym add
#                  SELECT oobn003 INTO l_oobn003
#                    FROM oobn_t
#                   WHERE oobnent = g_enterprise
#                     AND oobn001 = 'anmt311'
#                     AND oobn002 = l_lisp
#                  
#                  #產生帳務資料
#                                    #法人                    #平行記帳否 #帳別     #單別    #單號
#                  CALL anmt311_01(g_nmba_m.nmbacomp,'N','Y', l_glaa008, l_glaald,l_oobn003,g_nmba_m.nmbadocno)
#               END IF 
#-150616-00026#12-mark--(e)               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL anmt310_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION unverify
            LET g_action_choice="unverify"
            IF cl_auth_chk_act("unverify") THEN
               
               #add-point:ON ACTION unverify name="menu.unverify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION s_cashflow
            LET g_action_choice="s_cashflow"
            IF cl_auth_chk_act("s_cashflow") THEN
               
               #add-point:ON ACTION s_cashflow name="menu.s_cashflow"
               LET l_year = YEAR(g_nmba_m.nmbadocdt)
               LET l_month = MONTH(g_nmba_m.nmbadocdt) 
               LET l_year_o = YEAR(g_nmba_m_t.nmbadocdt)   #170112-00020#1 add 
               LET l_month_o = MONTH(g_nmba_m_t.nmbadocdt) #170112-00020#1 add               
               IF g_detail_idx > 0 THEN 
                  IF g_nmbb_d[g_detail_idx].nmbb001 = '3' OR g_nmbb_d[g_detail_idx].nmbb001 = '4' THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'anm-00334'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     EXIT DIALOG
                  ELSE
                     #170112-00020#1 add s---
                     #单据日期变更，且跨年或跨月时，glbc不重新新增，在原glbc上UPDATE年度期别
                     IF g_nmba_m.nmbadocdt != g_nmba_m_t.nmbadocdt AND (l_year <> l_year_o OR l_month <> l_month_o) THEN   
                        CALL s_cashflow_nm_1(g_glaald,g_nmba_m.nmbadocno,l_year,l_month,l_year_o,l_month_o,g_nmbb_d[g_detail_idx].nmbb001,g_prog,g_nmbb_d[g_detail_idx].nmbbseq)
                     ELSE
                     #170112-00020#1 add e---                     
                                            #帳別      #匯款編號         #年度   #期別  #借貸別                        #作業編號  #單身項次
                        CALL s_cashflow_nm(g_glaald,g_nmba_m.nmbadocno,l_year,l_month,g_nmbb_d[g_detail_idx].nmbb001,g_prog,g_nmbb_d[g_detail_idx].nmbbseq)
                     END IF #170112-00020#1 add
                  END IF 
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_nmba002
            LET g_action_choice="prog_nmba002"
            IF cl_auth_chk_act("prog_nmba002") THEN
               
               #add-point:ON ACTION prog_nmba002 name="menu.prog_nmba002"
               CALL cl_user_contact("aooi130", "ooag_t", "ooag002", "ooag001",g_nmba_m.nmba002)
               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL anmt310_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL anmt310_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL anmt310_set_pk_array()
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
 
{<section id="anmt310.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION anmt310_browser_fill(ps_page_action)
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
   #160816-00012#3 add s---
   CALL s_axrt300_get_site(g_user,'','3') RETURNING l_comp_str
   LET l_comp_str = cl_replace_str(l_comp_str,"ooef017","nmbacomp")
   LET g_wc = g_wc," AND ",l_comp_str  
   #160816-00012#3 add e---
   IF cl_null(g_wc) THEN 
      LET g_wc = " nmba003 IN('anmt310','anmt440','adet402','anmp802','aapt352') "  #160326-00001#26 mark #160326-00001#36 remark  #160518-00024#14 add aapt352 
      #LET g_wc = " nmba003 IN('1','4','2','3') "   #160326-00001#26 add #160326-00001#36 mark
   ELSE
      LET g_wc = g_wc," AND nmba003 IN('anmt310','anmt440','adet402','anmp802','aapt352') "  #160326-00001#26 mark #160326-00001#36 remark  #160518-00024#14 add aapt352  
      #LET g_wc = g_wc," AND nmba003 IN('1','4','2','3') "  #160326-00001#26 add #160326-00001#36 mark
   END IF 
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
      LET l_sub_sql = " SELECT DISTINCT nmbacomp,nmbadocno ",
                      " FROM nmba_t ",
                      " ",
                      " LEFT JOIN nmbb_t ON nmbbent = nmbaent AND nmbacomp = nmbbcomp AND nmbadocno = nmbbdocno ", "  ",
                      #add-point:browser_fill段sql(nmbb_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
 
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
   #160122-00001#26 - add -str
     IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT UNIQUE nmbacomp,nmbadocno ",
                      " FROM nmba_t ",
                      " LEFT JOIN nmbb_t ON nmbbent = nmbaent AND nmbacomp = nmbbcomp AND nmbadocno = nmbbdocno ", "  ",
                      " WHERE nmbaent = '" ||g_enterprise|| "' AND TRIM(nmbb003) IS NULL  ",
                      " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("nmba_t"),
                      " UNION ",
                      " SELECT UNIQUE nmbacomp,nmbadocno ",
                      " FROM nmba_t,nmbb_t ", 
                      " WHERE nmbaent = '" ||g_enterprise|| "' AND nmbbent = nmbaent AND nmbbdocno = mabadocno AND nmbacomp = nmbbcomp",
#                      " AND nmbb003 IN (SELECT UNIQUE nmll001 FROM nmll_t WHERE nmllent = ",g_enterprise," AND nmll002 = '",g_user,"')",
                      " AND nmbb003 IN (",g_sql_bank,")",
                      " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("nmba_t")
   ELSE
      #單身未輸入搜尋條件
      
      LET l_sub_sql = " SELECT UNIQUE nmbacomp,nmbadocno ",
                      " FROM nmba_t ",
                      " LEFT JOIN nmbb_t ON nmbbent = nmbaent AND nmbacomp = nmbbcomp AND nmbadocno = nmbbdocno ", "  ",
                      " WHERE nmbaent = '" ||g_enterprise|| "' AND TRIM(nmbb003) IS NULL  ",
                      " AND ",l_wc CLIPPED, cl_sql_add_filter("nmba_t"),
                      " UNION ",
                      " SELECT UNIQUE nmbacomp,nmbadocno ",
                      " FROM nmba_t ,nmbb_t", 
                      " WHERE nmbaent = '" ||g_enterprise|| "'  AND nmbbent = nmbaent AND nmbacomp = nmbbcomp AND nmbadocno = nmbbdocno",
#                      " AND nmbb003 IN (SELECT UNIQUE nmll001 FROM nmll_t WHERE nmllent = ",g_enterprise," AND nmll002 = '",g_user,"')",
                      " AND nmbb003 IN (",g_sql_bank,")",
                      " AND ",l_wc CLIPPED, cl_sql_add_filter("nmba_t")
   END IF
   #160122-00001#26 -add -end
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
   #160122-00001#26 - add -str
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.nmbastus,t0.nmbacomp,t0.nmbadocno ",
                  " FROM nmba_t t0",
                  "  LEFT JOIN nmbb_t ON nmbbent = nmbaent AND nmbacomp = nmbbcomp AND nmbadocno = nmbbdocno ", "  ",                   
                  " WHERE t0.nmbaent = '" ||g_enterprise|| "' AND TRIM(nmbb003) IS NULL AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("nmba_t"),
                  " UNION ",
                  " SELECT DISTINCT t0.nmbastus,t0.nmbacomp,t0.nmbadocno ",
                  " FROM nmba_t t0 ,nmbb_t", 
                  " WHERE t0.nmbaent = '" ||g_enterprise|| "' AND nmbbent = '" ||g_enterprise|| "'  AND nmbbent = nmbaent AND nmbacomp = nmbbcomp AND nmbadocno = nmbbdocno",
#                  " AND nmbb003 IN (SELECT UNIQUE nmll001 FROM nmll_t WHERE nmllent = ",g_enterprise," AND nmll002 = '",g_user,"')",
                  " AND nmbb003 IN (",g_sql_bank,")",
                  " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("nmba_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.nmbastus,t0.nmbacomp,t0.nmbadocno ",
                  " FROM nmba_t t0",
                  "  LEFT JOIN nmbb_t ON nmbbent = nmbaent AND nmbacomp = nmbbcomp AND nmbadocno = nmbbdocno ", "  ",                  
                  " WHERE t0.nmbaent = '" ||g_enterprise|| "' AND TRIM(nmbb003) IS NULL AND ",l_wc, cl_sql_add_filter("nmba_t"),
                  " UNION ",
                  " SELECT DISTINCT t0.nmbastus,t0.nmbacomp,t0.nmbadocno ",
                  " FROM nmba_t t0 ,nmbb_t",     
                  " WHERE t0.nmbaent = '" ||g_enterprise|| "' AND nmbbent = '" ||g_enterprise|| "' AND nmbbent = nmbaent AND nmbacomp = nmbbcomp AND nmbadocno = nmbbdocno",
#                  " AND nmbb003 IN (SELECT UNIQUE nmll001 FROM nmll_t WHERE nmllent = ",g_enterprise," AND nmll002 = '",g_user,"')",
                  " AND nmbb003 IN (",g_sql_bank,")",
                  " AND ",l_wc, cl_sql_add_filter("nmba_t")
   END IF
   #160122-00001#26 -add -end
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
 
{<section id="anmt310.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION anmt310_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_nmba_m.nmbacomp = g_browser[g_current_idx].b_nmbacomp   
   LET g_nmba_m.nmbadocno = g_browser[g_current_idx].b_nmbadocno   
 
   EXECUTE anmt310_master_referesh USING g_nmba_m.nmbacomp,g_nmba_m.nmbadocno INTO g_nmba_m.nmbasite, 
       g_nmba_m.nmba002,g_nmba_m.nmbacomp,g_nmba_m.nmbadocno,g_nmba_m.nmbadocdt,g_nmba_m.nmba003,g_nmba_m.nmba015, 
       g_nmba_m.nmba004,g_nmba_m.nmba005,g_nmba_m.nmba006,g_nmba_m.nmba007,g_nmba_m.nmbastus,g_nmba_m.nmbaownid, 
       g_nmba_m.nmbaowndp,g_nmba_m.nmbacrtid,g_nmba_m.nmbacrtdp,g_nmba_m.nmbacrtdt,g_nmba_m.nmbamodid, 
       g_nmba_m.nmbamoddt,g_nmba_m.nmbacnfid,g_nmba_m.nmbacnfdt,g_nmba_m.nmbasite_desc,g_nmba_m.nmbacomp_desc, 
       g_nmba_m.nmba004_desc,g_nmba_m.nmbaownid_desc,g_nmba_m.nmbaowndp_desc,g_nmba_m.nmbacrtid_desc, 
       g_nmba_m.nmbacrtdp_desc,g_nmba_m.nmbamodid_desc,g_nmba_m.nmbacnfid_desc
   
   CALL anmt310_nmba_t_mask()
   CALL anmt310_show()
      
END FUNCTION
 
{</section>}
 
{<section id="anmt310.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION anmt310_ui_detailshow()
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
 
{<section id="anmt310.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION anmt310_ui_browser_refresh()
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
 
{<section id="anmt310.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION anmt310_construct()
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
    DEFINE l_wc       STRING   #160816-00012#3 Add
   #end add-point    
   
   #add-point:Function前置處理  name="cs.pre_function"
   
   #end add-point
    
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_nmba_m.* TO NULL
   CALL g_nmbb_d.clear()        
 
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前 name="cs.before_construct"
   CALL cl_set_comp_visible('nmbb071,nmbb072',TRUE) #160518-00024#14 add
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON nmbasite,nmba002,nmba002_desc,nmbacomp,nmbadocno,nmbadocdt,nmba003,nmba003_desc, 
          nmba015,nmba004,nmba005,nmba006,nmba007,nmbastus,nmbaownid,nmbaowndp,nmbacrtid,nmbacrtdp,nmbacrtdt, 
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
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.where = " ooef206 = 'Y'"
            #CALL q_ooef001()    #161021-00050#8 mark
            CALL q_ooef001_33()  #161021-00050#8
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
            
 
 
         #Ctrlp:construct.c.nmba002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmba002
            #add-point:ON ACTION controlp INFIELD nmba002 name="construct.c.nmba002"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_ooag001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmba002  #顯示到畫面上
               #DISPLAY g_qryparam.return2 TO oofa011 #全名 

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
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmba002_desc
            #add-point:BEFORE FIELD nmba002_desc name="construct.b.nmba002_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmba002_desc
            
            #add-point:AFTER FIELD nmba002_desc name="construct.a.nmba002_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmba002_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmba002_desc
            #add-point:ON ACTION controlp INFIELD nmba002_desc name="construct.c.nmba002_desc"
            
            #END add-point
 
 
         #Ctrlp:construct.c.nmbacomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbacomp
            #add-point:ON ACTION controlp INFIELD nmbacomp name="construct.c.nmbacomp"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooef003 = 'Y'"
            #160816-00012#3 Add  ---(S)---
            CALL s_axrt300_get_site(g_user,'','3') RETURNING l_wc
            LET g_qryparam.where = g_qryparam.where," AND ",l_wc CLIPPED
            #160816-00012#3 Add  ---(E)---
            #CALL q_ooef001()  #161021-00050#8 mark
            CALL q_ooef001_2() #161021-00050#8
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
            
 
 
         #Ctrlp:construct.c.nmbadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbadocno
            #add-point:ON ACTION controlp INFIELD nmbadocno name="construct.c.nmbadocno"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			#抓取單據別參照表號
            LET g_qryparam.where = " nmba003 IN('anmt310','anmt440','adet402','anmp802','aapt352') "  #160326-00001#26 mark #160326-00001#36 remark #160518-00024#14 add aapt352
            #LET g_qryparam.where = " nmba003 IN('1','4','2','3') "  #160326-00001#26 add #160326-00001#36 mark
            #161104-00046#12-----s
            #單別權限控管
            IF NOT cl_null(g_user_dept_wc_q) AND NOT g_user_dept_wc_q = ' 1=1'  THEN
               LET g_qryparam.where = g_qryparam.where," AND ",g_user_dept_wc_q CLIPPED
            END IF
            #161104-00046#12-----e
            CALL q_nmbadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbadocno  #顯示到畫面上
            LET g_qryparam.where = ''
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
         BEFORE FIELD nmba003_desc
            #add-point:BEFORE FIELD nmba003_desc name="construct.b.nmba003_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmba003_desc
            
            #add-point:AFTER FIELD nmba003_desc name="construct.a.nmba003_desc"
 
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmba003_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmba003_desc
            #add-point:ON ACTION controlp INFIELD nmba003_desc name="construct.c.nmba003_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmba015
            #add-point:BEFORE FIELD nmba015 name="construct.b.nmba015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmba015
            
            #add-point:AFTER FIELD nmba015 name="construct.a.nmba015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmba015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmba015
            #add-point:ON ACTION controlp INFIELD nmba015 name="construct.c.nmba015"
            
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
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmba004
            #add-point:ON ACTION controlp INFIELD nmba004 name="construct.c.nmba004"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            # CALL q_pmaa001()       #160913-00017#6  mark                  #呼叫開窗
            CALL q_pmaa001_25()     #160913-00017#6  add      
            DISPLAY g_qryparam.return1 TO nmba004  #顯示到畫面上

            NEXT FIELD nmba004                     #返回原欄位


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
         BEFORE FIELD nmba007
            #add-point:BEFORE FIELD nmba007 name="construct.b.nmba007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmba007
            
            #add-point:AFTER FIELD nmba007 name="construct.a.nmba007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmba007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmba007
            #add-point:ON ACTION controlp INFIELD nmba007 name="construct.c.nmba007"
            
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
      CONSTRUCT g_wc2_table1 ON nmbbseq,nmbborga,nmbb071,nmbb072,nmbb053,nmbb053_desc,nmbb054,nmbb054_desc, 
          nmbb070,nmbb001,nmbb002,nmbb003,nmbb004,nmbb005,nmbb006,nmbb007,nmbb010,nmbb010_desc,nmbb025, 
          nmbb011,nmbb013,nmbb014,nmbb017,nmbb018,nmbb008,nmbb009,nmbb020,nmbb021,nmbb022,nmbb023,nmbb024, 
          nmbb026,nmbb027,nmbb057,nmbb058,nmbb059,nmbb060,nmbb062,nmbb066,nmbb067,nmbb068
           FROM s_detail1[1].nmbbseq,s_detail1[1].nmbborga,s_detail1[1].nmbb071,s_detail1[1].nmbb072, 
               s_detail1[1].nmbb053,s_detail1[1].nmbb053_desc,s_detail1[1].nmbb054,s_detail1[1].nmbb054_desc, 
               s_detail1[1].nmbb070,s_detail1[1].nmbb001,s_detail1[1].nmbb002,s_detail1[1].nmbb003,s_detail1[1].nmbb004, 
               s_detail1[1].nmbb005,s_detail1[1].nmbb006,s_detail1[1].nmbb007,s_detail1[1].nmbb010,s_detail1[1].nmbb010_desc, 
               s_detail1[1].nmbb025,s_detail1[1].nmbb011,s_detail1[1].nmbb013,s_detail1[1].nmbb014,s_detail1[1].nmbb017, 
               s_detail1[1].nmbb018,s_detail1[1].nmbb008,s_detail1[1].nmbb009,s_detail1[1].nmbb020,s_detail1[1].nmbb021, 
               s_detail1[1].nmbb022,s_detail1[1].nmbb023,s_detail1[1].nmbb024,s_detail1[1].nmbb026,s_detail1[1].nmbb027, 
               s_detail1[1].nmbb057,s_detail1[1].nmbb058,s_detail1[1].nmbb059,s_detail1[1].nmbb060,s_detail1[1].nmbb062, 
               s_detail1[1].nmbb066,s_detail1[1].nmbb067,s_detail1[1].nmbb068
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            #160509-0004  --str--
            CALL cl_set_comp_visible("nmbb070,nmbb070_desc", true)
            #160509-0004  --end--
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
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   #LET g_qryparam.where = " ooef206 = 'Y'" #150714-00024#1 #161021-00050#8 mark
			   LET g_qryparam.where = " ooef201 = 'Y'"  #161021-00050#8
            #160816-00012#3 Add  ---(S)---
            CALL s_axrt300_get_site(g_user,'','1') RETURNING l_wc
            LET g_qryparam.where = g_qryparam.where," AND ",l_wc CLIPPED
            #160816-00012#3 Add  ---(E)---
            CALL q_ooef001()
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
            
 
 
         #Ctrlp:construct.c.page1.nmbb071
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb071
            #add-point:ON ACTION controlp INFIELD nmbb071 name="construct.c.page1.nmbb071"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            #160518-00024#14 add s---
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_apagdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbb071  #顯示到畫面上
            NEXT FIELD nmbb071                     #返回原欄位
           #160518-00024#14 add e---



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb071
            #add-point:BEFORE FIELD nmbb071 name="construct.b.page1.nmbb071"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb071
            
            #add-point:AFTER FIELD nmbb071 name="construct.a.page1.nmbb071"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb072
            #add-point:BEFORE FIELD nmbb072 name="construct.b.page1.nmbb072"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb072
            
            #add-point:AFTER FIELD nmbb072 name="construct.a.page1.nmbb072"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmbb072
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb072
            #add-point:ON ACTION controlp INFIELD nmbb072 name="construct.c.page1.nmbb072"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.nmbb053
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb053
            #add-point:ON ACTION controlp INFIELD nmbb053 name="construct.c.page1.nmbb053"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbb053  #顯示到畫面上
               #DISPLAY g_qryparam.return2 TO oofa011 #全名 

            NEXT FIELD nmbb053                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb053
            #add-point:BEFORE FIELD nmbb053 name="construct.b.page1.nmbb053"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb053
            
            #add-point:AFTER FIELD nmbb053 name="construct.a.page1.nmbb053"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmbb053_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb053_desc
            #add-point:ON ACTION controlp INFIELD nmbb053_desc name="construct.c.page1.nmbb053_desc"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbb053_desc  #顯示到畫面上
               #DISPLAY g_qryparam.return2 TO oofa011 #全名 

            NEXT FIELD nmbb053_desc                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb053_desc
            #add-point:BEFORE FIELD nmbb053_desc name="construct.b.page1.nmbb053_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb053_desc
            
            #add-point:AFTER FIELD nmbb053_desc name="construct.a.page1.nmbb053_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmbb054
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb054
            #add-point:ON ACTION controlp INFIELD nmbb054 name="construct.c.page1.nmbb054"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #CALL q_ooef001()                     #150714-00024#1 mark
            LET g_qryparam.arg1 = g_today         #150714-00024#1
		      CALL q_ooeg001_4()                    #150714-00024#1
            DISPLAY g_qryparam.return1 TO nmbb054
            NEXT FIELD nmbb054
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb054
            #add-point:BEFORE FIELD nmbb054 name="construct.b.page1.nmbb054"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb054
            
            #add-point:AFTER FIELD nmbb054 name="construct.a.page1.nmbb054"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmbb054_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb054_desc
            #add-point:ON ACTION controlp INFIELD nmbb054_desc name="construct.c.page1.nmbb054_desc"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #CALL q_ooef001()                     #150714-00024#1 mark
            LET g_qryparam.arg1 = g_today         #150714-00024#1
		      CALL q_ooeg001_4()                    #150714-00024#1
            DISPLAY g_qryparam.return1 TO nmbb054_desc
            NEXT FIELD nmbb054_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb054_desc
            #add-point:BEFORE FIELD nmbb054_desc name="construct.b.page1.nmbb054_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb054_desc
            
            #add-point:AFTER FIELD nmbb054_desc name="construct.a.page1.nmbb054_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmbb070
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb070
            #add-point:ON ACTION controlp INFIELD nmbb070 name="construct.c.page1.nmbb070"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooef201 = 'Y'"  #161021-00050#8
            CALL q_ooef001_1()     #160509-0004
            DISPLAY g_qryparam.return1 TO nmbb070
            NEXT FIELD nmbb070
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb070
            #add-point:BEFORE FIELD nmbb070 name="construct.b.page1.nmbb070"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb070
            
            #add-point:AFTER FIELD nmbb070 name="construct.a.page1.nmbb070"
            
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
            
 
 
         #Ctrlp:construct.c.page1.nmbb003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb003
            #add-point:ON ACTION controlp INFIELD nmbb003 name="construct.c.page1.nmbb003"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			   #160122-00001#26 - add -str
			   LET g_qryparam.where = " nmas002 IN (",g_sql_bank,")"   
            #160122-00001#26 -add -end
            CALL q_nmas_01()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbb003  #顯示到畫面上
               #DISPLAY g_qryparam.return2 TO nmas003 #交易幣別 
            LET g_qryparam.where = " "  #160122-00001#26 - add
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
 
 
         #Ctrlp:construct.c.page1.nmbb010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb010
            #add-point:ON ACTION controlp INFIELD nmbb010 name="construct.c.page1.nmbb010"
            #此段落由子樣板a08產生
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
         BEFORE FIELD nmbb010_desc
            #add-point:BEFORE FIELD nmbb010_desc name="construct.b.page1.nmbb010_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb010_desc
            
            #add-point:AFTER FIELD nmbb010_desc name="construct.a.page1.nmbb010_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmbb010_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb010_desc
            #add-point:ON ACTION controlp INFIELD nmbb010_desc name="construct.c.page1.nmbb010_desc"
            
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
         BEFORE FIELD nmbb008
            #add-point:BEFORE FIELD nmbb008 name="construct.b.page1.nmbb008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb008
            
            #add-point:AFTER FIELD nmbb008 name="construct.a.page1.nmbb008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmbb008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb008
            #add-point:ON ACTION controlp INFIELD nmbb008 name="construct.c.page1.nmbb008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb009
            #add-point:BEFORE FIELD nmbb009 name="construct.b.page1.nmbb009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb009
            
            #add-point:AFTER FIELD nmbb009 name="construct.a.page1.nmbb009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmbb009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb009
            #add-point:ON ACTION controlp INFIELD nmbb009 name="construct.c.page1.nmbb009"
            
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
         BEFORE FIELD nmbb026
            #add-point:BEFORE FIELD nmbb026 name="construct.b.page1.nmbb026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb026
            
            #add-point:AFTER FIELD nmbb026 name="construct.a.page1.nmbb026"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmbb026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb026
            #add-point:ON ACTION controlp INFIELD nmbb026 name="construct.c.page1.nmbb026"
            
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
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb027
            #add-point:ON ACTION controlp INFIELD nmbb027 name="construct.c.page1.nmbb027"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb057
            #add-point:BEFORE FIELD nmbb057 name="construct.b.page1.nmbb057"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb057
            
            #add-point:AFTER FIELD nmbb057 name="construct.a.page1.nmbb057"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmbb057
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb057
            #add-point:ON ACTION controlp INFIELD nmbb057 name="construct.c.page1.nmbb057"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb058
            #add-point:BEFORE FIELD nmbb058 name="construct.b.page1.nmbb058"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb058
            
            #add-point:AFTER FIELD nmbb058 name="construct.a.page1.nmbb058"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmbb058
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb058
            #add-point:ON ACTION controlp INFIELD nmbb058 name="construct.c.page1.nmbb058"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb059
            #add-point:BEFORE FIELD nmbb059 name="construct.b.page1.nmbb059"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb059
            
            #add-point:AFTER FIELD nmbb059 name="construct.a.page1.nmbb059"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmbb059
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb059
            #add-point:ON ACTION controlp INFIELD nmbb059 name="construct.c.page1.nmbb059"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb060
            #add-point:BEFORE FIELD nmbb060 name="construct.b.page1.nmbb060"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb060
            
            #add-point:AFTER FIELD nmbb060 name="construct.a.page1.nmbb060"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmbb060
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb060
            #add-point:ON ACTION controlp INFIELD nmbb060 name="construct.c.page1.nmbb060"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb062
            #add-point:BEFORE FIELD nmbb062 name="construct.b.page1.nmbb062"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb062
            
            #add-point:AFTER FIELD nmbb062 name="construct.a.page1.nmbb062"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmbb062
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb062
            #add-point:ON ACTION controlp INFIELD nmbb062 name="construct.c.page1.nmbb062"
            
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
                  WHEN la_wc[li_idx].tableid = "nmba_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "nmbb_t" 
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
   #161104-00046#12-----s
   IF cl_null(g_user_dept_wc)THEN
      LET g_user_dept_wc = ' 1=1'
   END IF
   IF g_user_dept_wc <>  " 1=1" THEN
      LET g_wc = g_wc ," AND ", g_user_dept_wc CLIPPED
   END IF   
   #161104-00046#12-----e
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="anmt310.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION anmt310_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point   
   DEFINE ls_wc STRING
   #add-point:query段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   CALL cl_set_comp_visible('page2',TRUE)   #150714-00024#1
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
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL anmt310_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL anmt310_browser_fill("")
      CALL anmt310_fetch("")
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
   CALL anmt310_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL anmt310_fetch("F") 
      #顯示單身筆數
      CALL anmt310_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="anmt310.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION anmt310_fetch(p_flag)
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
   EXECUTE anmt310_master_referesh USING g_nmba_m.nmbacomp,g_nmba_m.nmbadocno INTO g_nmba_m.nmbasite, 
       g_nmba_m.nmba002,g_nmba_m.nmbacomp,g_nmba_m.nmbadocno,g_nmba_m.nmbadocdt,g_nmba_m.nmba003,g_nmba_m.nmba015, 
       g_nmba_m.nmba004,g_nmba_m.nmba005,g_nmba_m.nmba006,g_nmba_m.nmba007,g_nmba_m.nmbastus,g_nmba_m.nmbaownid, 
       g_nmba_m.nmbaowndp,g_nmba_m.nmbacrtid,g_nmba_m.nmbacrtdp,g_nmba_m.nmbacrtdt,g_nmba_m.nmbamodid, 
       g_nmba_m.nmbamoddt,g_nmba_m.nmbacnfid,g_nmba_m.nmbacnfdt,g_nmba_m.nmbasite_desc,g_nmba_m.nmbacomp_desc, 
       g_nmba_m.nmba004_desc,g_nmba_m.nmbaownid_desc,g_nmba_m.nmbaowndp_desc,g_nmba_m.nmbacrtid_desc, 
       g_nmba_m.nmbacrtdp_desc,g_nmba_m.nmbamodid_desc,g_nmba_m.nmbacnfid_desc
   
   #遮罩相關處理
   LET g_nmba_m_mask_o.* =  g_nmba_m.*
   CALL anmt310_nmba_t_mask()
   LET g_nmba_m_mask_n.* =  g_nmba_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL anmt310_set_act_visible()   
   CALL anmt310_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   #160509-0004--STR--
   IF g_nmba_m.nmba015='Y' THEN 
      CALL cl_set_comp_visible("nmbb070,nmbb070_desc",TRUE)
   ELSE
      CALL cl_set_comp_visible("nmbb070,nmbb070_desc",FALSE)
   END IF
   #160509-0004--END--
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_nmba_m_t.* = g_nmba_m.*
   LET g_nmba_m_o.* = g_nmba_m.*
   
   LET g_data_owner = g_nmba_m.nmbaownid      
   LET g_data_dept  = g_nmba_m.nmbaowndp
   
   #重新顯示   
   CALL anmt310_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="anmt310.insert" >}
#+ 資料新增
PRIVATE FUNCTION anmt310_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   DEFINE l_msg         LIKE type_t.chr200
   DEFINE l_wc          STRING             #160816-00012#3 Add
   DEFINE l_count       LIKE type_t.num5   #160816-00012#3 Add
   DEFINE l_sql         STRING             #160816-00012#3 Add
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_nmbb_d.clear()   
 
 
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
            LET g_nmba_m.nmba015 = "N"
      LET g_nmba_m.nmba004 = "MISC"
      LET g_nmba_m.nmba005 = "MISC"
      LET g_nmba_m.nmba006 = "N"
      LET g_nmba_m.nmbastus = "N"
 
  
      #add-point:單頭預設值 name="insert.default"
      LET g_nmba_m_t.* = g_nmba_m.*
      #取得預設的資金中心,因新增階段的時候,並不會知道site,所以以登入人員做為依據
      CALL s_fin_get_account_center('',g_user,'6',g_today) RETURNING g_sub_success,g_nmba_m.nmbasite,g_errno
      CALL s_anm_get_comp_wc('6',g_nmba_m.nmbasite,g_nmba_m.nmbadocdt) RETURNING g_comp_wc   #150714-00024#1
      
      #160509-0004--str--
      CALL cl_set_comp_visible("nmbb070,nmbb070_desc", FALSE)
      #160509-0004--end--
      
      LET g_nmba_m.nmba002 = g_user
      SELECT ooag004 INTO g_ooag004 FROM ooag_t
       WHERE ooagent = g_enterprise  #2015/03/31 add by 02599
         AND ooag001 = g_user

      SELECT ooef017 INTO g_nmba_m.nmbacomp
        FROM ooef_t
       WHERE ooefent = g_enterprise
         AND ooef001 = g_nmba_m.nmbasite
      #CALL s_anm_get_site_wc('6',g_nmba_m.nmbacomp,g_nmba_m.nmbadocdt) RETURNING g_site_wc   #150714-00024#1 #160912-00024#1 mark
      CALL s_anm_get_site_wc('6',g_nmba_m.nmbasite,g_nmba_m.nmbadocdt) RETURNING g_site_wc    #160912-00024#1 add
      #160816-00012#3 Add  ---(S)---
      #检查用户是否有资金中心对应法人的权限
      CALL s_axrt300_get_site(g_user,'','3') RETURNING l_wc
      LET l_count = 0
      LET l_sql = "SELECT COUNT(*) FROM ooef_t WHERE ooefent = '",g_enterprise,"' ",
                  "   AND ooef001 = '",g_nmba_m.nmbacomp,"'",
                  "   AND ooef003 = 'Y'",
                  "   AND ",l_wc CLIPPED
      PREPARE anmt310_count1_prep FROM l_sql
      EXECUTE anmt310_count1_prep INTO l_count
      IF cl_null(l_count) THEN LET l_count = 0 END IF
      IF l_count = 0 THEN
         LET g_nmba_m.nmbacomp = ''
         LET g_nmba_m.nmbacomp_desc = ''
         DISPLAY BY NAME g_nmba_m.nmbacomp,g_nmba_m.nmbacomp_desc
      END IF
      #160816-00012#3 Add  ---(E)---
      
      SELECT ooef001,ooef016 INTO g_ooef001,g_ooef016
        FROM ooef_t
       WHERE ooefent = g_enterprise
         AND ooef001 = g_ooag004
      
      SELECT glaald,glaa002 INTO g_glaald,g_glaa002
        FROM glaa_t
       WHERE glaaent = g_enterprise  #2015/03/31 add by 02599
         AND glaacomp = g_nmba_m.nmbacomp
         AND glaa014 = 'Y'
      
      LET g_nmba_m.nmbadocdt = g_today
#160326-00001#26 add s---      
#      CALL cl_getmsg('anm-00038',g_lang) RETURNING l_msg
#      LET g_nmba_m.nmba003 = 'anmt310'
#      LET g_nmba_m.nmba003_desc = l_msg
      CALL cl_set_combo_scc('nmba003','8741')      
      #LET g_nmba_m.nmba003 = '1' #anmt310 #160326-00001#36 mark
      LET g_nmba_m.nmba003 = 'anmt310'     #160326-00001#36 add 
      #LET g_nmba_m.nmba003_desc = '1'  
#160326-00001#26 add e---      
      #LET g_sql = " SELECT xrah002 FROM xrah_t ",
      #            "  WHERE xrah001 = '3' ", 
      #            "    AND xrah007 = 'Y' ",
      #            "    AND xrah004 = '",g_ooag004,"'"
      #PREPARE xrah002_pre FROM g_sql
      #DECLARE xrah002_cur CURSOR FOR xrah002_pre
      #OPEN xrah002_cur
      #FETCH xrah002_cur INTO g_nmba_m.nmbasite
      CALL anmt310_show()
      CALL anmt310_nmbasite_desc()
      CALL anmt310_nmbacomp_desc()
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
 
 
 
    
      CALL anmt310_input("a")
      
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
         INITIALIZE g_nmba_m.* TO NULL
         INITIALIZE g_nmbb_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL anmt310_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_nmbb_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL anmt310_set_act_visible()   
   CALL anmt310_set_act_no_visible()
   
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
   CALL anmt310_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE anmt310_cl
   
   CALL anmt310_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE anmt310_master_referesh USING g_nmba_m.nmbacomp,g_nmba_m.nmbadocno INTO g_nmba_m.nmbasite, 
       g_nmba_m.nmba002,g_nmba_m.nmbacomp,g_nmba_m.nmbadocno,g_nmba_m.nmbadocdt,g_nmba_m.nmba003,g_nmba_m.nmba015, 
       g_nmba_m.nmba004,g_nmba_m.nmba005,g_nmba_m.nmba006,g_nmba_m.nmba007,g_nmba_m.nmbastus,g_nmba_m.nmbaownid, 
       g_nmba_m.nmbaowndp,g_nmba_m.nmbacrtid,g_nmba_m.nmbacrtdp,g_nmba_m.nmbacrtdt,g_nmba_m.nmbamodid, 
       g_nmba_m.nmbamoddt,g_nmba_m.nmbacnfid,g_nmba_m.nmbacnfdt,g_nmba_m.nmbasite_desc,g_nmba_m.nmbacomp_desc, 
       g_nmba_m.nmba004_desc,g_nmba_m.nmbaownid_desc,g_nmba_m.nmbaowndp_desc,g_nmba_m.nmbacrtid_desc, 
       g_nmba_m.nmbacrtdp_desc,g_nmba_m.nmbamodid_desc,g_nmba_m.nmbacnfid_desc
   
   
   #遮罩相關處理
   LET g_nmba_m_mask_o.* =  g_nmba_m.*
   CALL anmt310_nmba_t_mask()
   LET g_nmba_m_mask_n.* =  g_nmba_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_nmba_m.nmbasite,g_nmba_m.nmbasite_desc,g_nmba_m.nmba002,g_nmba_m.nmba002_desc,g_nmba_m.nmbacomp, 
       g_nmba_m.nmbacomp_desc,g_nmba_m.nmbadocno,g_nmba_m.nmbadocdt,g_nmba_m.nmba003,g_nmba_m.nmba003_desc, 
       g_nmba_m.nmba015,g_nmba_m.nmba004,g_nmba_m.nmba004_desc,g_nmba_m.nmba005,g_nmba_m.nmba006,g_nmba_m.nmba007, 
       g_nmba_m.l_nmbs003,g_nmba_m.nmbastus,g_nmba_m.nmbaownid,g_nmba_m.nmbaownid_desc,g_nmba_m.nmbaowndp, 
       g_nmba_m.nmbaowndp_desc,g_nmba_m.nmbacrtid,g_nmba_m.nmbacrtid_desc,g_nmba_m.nmbacrtdp,g_nmba_m.nmbacrtdp_desc, 
       g_nmba_m.nmbacrtdt,g_nmba_m.nmbamodid,g_nmba_m.nmbamodid_desc,g_nmba_m.nmbamoddt,g_nmba_m.nmbacnfid, 
       g_nmba_m.nmbacnfid_desc,g_nmba_m.nmbacnfdt
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_nmba_m.nmbaownid      
   LET g_data_dept  = g_nmba_m.nmbaowndp
   
   #功能已完成,通報訊息中心
   CALL anmt310_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="anmt310.modify" >}
#+ 資料修改
PRIVATE FUNCTION anmt310_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point    
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   DEFINE l_wc2_table1          STRING
 
 
   #add-point:modify段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   #150813-00015#3--add--str--
   DEFINE l_success   LIKE type_t.num5  
   DEFINE l_slip      LIKE type_t.chr10
   DEFINE l_dfin0033  LIKE type_t.chr80
   DEFINE l_para_date LIKE type_t.dat
   #150813-00015#3--add--end  
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
   
   OPEN anmt310_cl USING g_enterprise,g_nmba_m.nmbacomp,g_nmba_m.nmbadocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN anmt310_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE anmt310_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE anmt310_master_referesh USING g_nmba_m.nmbacomp,g_nmba_m.nmbadocno INTO g_nmba_m.nmbasite, 
       g_nmba_m.nmba002,g_nmba_m.nmbacomp,g_nmba_m.nmbadocno,g_nmba_m.nmbadocdt,g_nmba_m.nmba003,g_nmba_m.nmba015, 
       g_nmba_m.nmba004,g_nmba_m.nmba005,g_nmba_m.nmba006,g_nmba_m.nmba007,g_nmba_m.nmbastus,g_nmba_m.nmbaownid, 
       g_nmba_m.nmbaowndp,g_nmba_m.nmbacrtid,g_nmba_m.nmbacrtdp,g_nmba_m.nmbacrtdt,g_nmba_m.nmbamodid, 
       g_nmba_m.nmbamoddt,g_nmba_m.nmbacnfid,g_nmba_m.nmbacnfdt,g_nmba_m.nmbasite_desc,g_nmba_m.nmbacomp_desc, 
       g_nmba_m.nmba004_desc,g_nmba_m.nmbaownid_desc,g_nmba_m.nmbaowndp_desc,g_nmba_m.nmbacrtid_desc, 
       g_nmba_m.nmbacrtdp_desc,g_nmba_m.nmbamodid_desc,g_nmba_m.nmbacnfid_desc
   
   #檢查是否允許此動作
   IF NOT anmt310_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_nmba_m_mask_o.* =  g_nmba_m.*
   CALL anmt310_nmba_t_mask()
   LET g_nmba_m_mask_n.* =  g_nmba_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
 
   
   CALL anmt310_show()
   #add-point:modify段show之後 name="modify.after_show"
   #150813-00015#3--add--str--
   #161130-00055#1-S
   #IF g_nmba_m.nmbastus <> 'N' THEN
   #   INITIALIZE g_errparam TO NULL
   #   LET g_errparam.code = 'agl-00313'
   #   LET g_errparam.extend = 'modify'
   #   LET g_errparam.popup = TRUE
   #   CALL cl_err()
   #   CLOSE anmt310_cl
   #   CALL s_transaction_end('N','0')
   #   RETURN
   #END IF 
   #161130-00055#1-E
   #获取单别
   CALL s_aooi200_fin_get_slip(g_nmba_m.nmbadocno) RETURNING l_success,l_slip
   #是否可改日期
   CALL s_fin_get_doc_para(g_glaald,g_nmba_m.nmbacomp,l_slip,'D-FIN-0033') RETURNING l_dfin0033
   IF l_dfin0033 = 'N' THEN
      #檢查當單據日期小於等於關帳日期時，不可異動單據
      CALL s_fin_date_close_chk('',g_nmba_m.nmbacomp,'ANM',g_nmba_m.nmbadocdt) RETURNING l_success
      IF l_success = FALSE THEN
         CLOSE anmt310_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
   END IF
   #150813-00015#3--add--end
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
 
    
   WHILE TRUE
      LET g_nmbacomp_t = g_nmba_m.nmbacomp
      LET g_nmbadocno_t = g_nmba_m.nmbadocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_nmba_m.nmbamodid = g_user 
LET g_nmba_m.nmbamoddt = cl_get_current()
LET g_nmba_m.nmbamodid_desc = cl_get_username(g_nmba_m.nmbamodid)
      
      #add-point:modify段修改前 name="modify.before_input"
#150813-00015#3--mark--str--
#      IF g_nmba_m.nmbastus <> 'N' THEN
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.code = 'agl-00052'
#         LET g_errparam.extend = 'modify'
#         LET g_errparam.popup = TRUE
#         CALL cl_err()
#
#         RETURN
#      END IF 
#150813-00015#3--mark--end
      #161130-00055#1-S
      IF g_nmba_m.nmbastus MATCHES '[DR]' THEN 
         LET g_nmba_m.nmbastus = "N"
      END IF
      #161130-00055#1-E
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL anmt310_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
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
            CALL anmt310_show()
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
         
 
         
 
         
         #UPDATE 多語言table key值
         
 
         CALL s_transaction_end('Y','0')
      END IF
    
      EXIT WHILE
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL anmt310_set_act_visible()   
   CALL anmt310_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " nmbaent = " ||g_enterprise|| " AND",
                      " nmbacomp = '", g_nmba_m.nmbacomp, "' "
                      ," AND nmbadocno = '", g_nmba_m.nmbadocno, "' "
 
   #填到對應位置
   CALL anmt310_browser_fill("")
 
   CLOSE anmt310_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL anmt310_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="anmt310.input" >}
#+ 資料輸入
PRIVATE FUNCTION anmt310_input(p_cmd)
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
   DEFINE l_pmaa004        LIKE pmaa_t.pmaa004
   DEFINE l_success        LIKE type_t.num5
   DEFINE l_glaa005        LIKE glaa_t.glaa005
   DEFINE l_ooab002        LIKE ooab_t.ooab002
   DEFINE l_ooam003        LIKE ooam_t.ooam003
   DEFINE l_year           LIKE type_t.num5
   DEFINE l_month          LIKE type_t.num5
   DEFINE l_origin_str     STRING   #組織範圍
   DEFINE l_ooaj004        LIKE ooaj_t.ooaj004    #2015/02/02 add by qiull
   DEFINE l_ooaj005        LIKE ooaj_t.ooaj005    #2015/02/02 add by qiull
   DEFINE l_sql            STRING   #160816-00012#3 Add
   DEFINE l_wc             STRING   #160816-00012#3 Add
   DEFINE l_year_o           LIKE type_t.num5  #170112-00020#1 add
   DEFINE l_month_o          LIKE type_t.num5  #170112-00020#1 add 
   DEFINE l_flag           LIKE type_t.num5    #161104-00046#12
   DEFINE l_slip           LIKE ooba_t.ooba002 #161104-00046#12
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
   DISPLAY BY NAME g_nmba_m.nmbasite,g_nmba_m.nmbasite_desc,g_nmba_m.nmba002,g_nmba_m.nmba002_desc,g_nmba_m.nmbacomp, 
       g_nmba_m.nmbacomp_desc,g_nmba_m.nmbadocno,g_nmba_m.nmbadocdt,g_nmba_m.nmba003,g_nmba_m.nmba003_desc, 
       g_nmba_m.nmba015,g_nmba_m.nmba004,g_nmba_m.nmba004_desc,g_nmba_m.nmba005,g_nmba_m.nmba006,g_nmba_m.nmba007, 
       g_nmba_m.l_nmbs003,g_nmba_m.nmbastus,g_nmba_m.nmbaownid,g_nmba_m.nmbaownid_desc,g_nmba_m.nmbaowndp, 
       g_nmba_m.nmbaowndp_desc,g_nmba_m.nmbacrtid,g_nmba_m.nmbacrtid_desc,g_nmba_m.nmbacrtdp,g_nmba_m.nmbacrtdp_desc, 
       g_nmba_m.nmbacrtdt,g_nmba_m.nmbamodid,g_nmba_m.nmbamodid_desc,g_nmba_m.nmbamoddt,g_nmba_m.nmbacnfid, 
       g_nmba_m.nmbacnfid_desc,g_nmba_m.nmbacnfdt
   
   #切換畫面
 
   CALL cl_set_head_visible("","YES")  
 
   LET l_insert = FALSE
   LET g_action_choice = ""
 
   #add-point:input段define_sql name="input.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT nmbbseq,nmbborga,nmbb071,nmbb072,nmbb053,nmbb054,nmbb070,nmbblegl,nmbb001, 
       nmbb002,nmbb003,nmbb029,nmbb004,nmbb005,nmbb006,nmbb007,nmbb010,nmbb025,nmbb011,nmbb012,nmbb013, 
       nmbb014,nmbb015,nmbb016,nmbb017,nmbb018,nmbb008,nmbb009,nmbb019,nmbb020,nmbb021,nmbb022,nmbb023, 
       nmbb024,nmbb026,nmbb027,nmbb056,nmbb057,nmbb058,nmbb059,nmbb060,nmbb061,nmbb062,nmbb066,nmbb067, 
       nmbb068 FROM nmbb_t WHERE nmbbent=? AND nmbbcomp=? AND nmbbdocno=? AND nmbbseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE anmt310_bcl CURSOR FROM g_forupd_sql
   
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL anmt310_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   #160326-00001#26 add s---
   #IF g_nmba_m.nmba003 = '3' THEN #160326-00001#36 mark
   IF g_nmba_m.nmba003 = 'anmp802' THEN  #160326-00001#36 add 
      LET l_allow_insert = FALSE
   END IF
   #160326-00001#26 add e---   
   

 
   #end add-point
   CALL anmt310_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_nmba_m.nmbasite,g_nmba_m.nmba002,g_nmba_m.nmbacomp,g_nmba_m.nmbadocno,g_nmba_m.nmbadocdt, 
       g_nmba_m.nmba003,g_nmba_m.nmba003_desc,g_nmba_m.nmba015,g_nmba_m.nmba004,g_nmba_m.nmba005,g_nmba_m.nmba006, 
       g_nmba_m.nmba007,g_nmba_m.nmbastus
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   #151016-00018#1-----s
   IF cl_null(g_nmba_m.nmbacomp) THEN
      SELECT ooef017 INTO g_nmba_m.nmbacomp FROM ooef_t
       WHERE ooefent = g_enterprise AND ooef001 = g_nmba_m.nmbasite
      #CALL s_anm_get_site_wc('6',g_nmba_m.nmbacomp,g_nmba_m.nmbadocdt) RETURNING g_site_wc #160912-00024#1 mod
      CALL anmt310_nmbacomp_desc()
   END IF
   #151016-00018#1-----e

   CALL s_anm_get_site_wc('6',g_nmba_m.nmbasite,g_nmba_m.nmbadocdt) RETURNING g_site_wc   #160912-00024#1 add 
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="anmt310.input.head" >}
      #單頭段
      INPUT BY NAME g_nmba_m.nmbasite,g_nmba_m.nmba002,g_nmba_m.nmbacomp,g_nmba_m.nmbadocno,g_nmba_m.nmbadocdt, 
          g_nmba_m.nmba003,g_nmba_m.nmba003_desc,g_nmba_m.nmba015,g_nmba_m.nmba004,g_nmba_m.nmba005, 
          g_nmba_m.nmba006,g_nmba_m.nmba007,g_nmba_m.nmbastus 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN anmt310_cl USING g_enterprise,g_nmba_m.nmbacomp,g_nmba_m.nmbadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN anmt310_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE anmt310_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL anmt310_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            #CALL cl_showmsg_init()
            #151016-00018#2-----s
            IF l_cmd_t = 'r' AND p_cmd   = 'a' THEN
               CALL cl_set_comp_entry("nmbasite,nmbacomp",FALSE)
            END IF
            #151016-00018#2-----e
            #end add-point
            CALL anmt310_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbasite
            
            #add-point:AFTER FIELD nmbasite name="input.a.nmbasite"
            IF NOT cl_null(g_nmba_m.nmbasite) THEN 
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_nmba_m.nmbasite != g_nmba_m_t.nmbasite OR g_nmba_m_t.nmbasite IS NULL )) THEN   #160822-00012#5   mark
               IF g_nmba_m.nmbasite != g_nmba_m_o.nmbasite OR cl_null(g_nmba_m_o.nmbasite) THEN                                       #160822-00012#5   add
#2015/03/31--by 02599--mark--str--
#                  CALL s_fin_account_center_chk(g_nmba_m.nmbasite,'','6',g_nmba_m.nmbadocdt)
#                     RETURNING g_sub_success,g_errno
#                  IF NOT g_sub_success THEN
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code = 'anm-00275'
#                     LET g_errparam.extend = ''
#                     LET g_errparam.popup = TRUE
#                     CALL cl_err()
#                     LET g_nmba_m.nmbasite = g_nmba_m_t.nmbasite
#                     CALL anmt310_nmbasite_desc()
#                     NEXT FIELD CURRENT
#                  END IF
#2015/03/31--by 02599--mark--end
                  CALL anmt310_nmbasite_chk()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_nmba_m.nmbasite
                     #160318-00005#27 by 07900 --add--str
                     LET g_errparam.replace[1] = 'aooi125'
                     LET g_errparam.replace[2] = cl_get_progname("aooi125",g_lang,"2")
                     LET g_errparam.exeprog ='aooi125'
                     #160318-00005#27 by 07900 --add--end
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #LET g_nmba_m.nmbasite = g_nmba_m_t.nmbasite   #160822-00012#5   mark
                     LET g_nmba_m.nmbasite = g_nmba_m_o.nmbasite    #160822-00012#5   add
                     CALL anmt310_nmbasite_desc()
                     NEXT FIELD CURRENT
                  END IF

                 #CALL s_fin_account_center_with_ld_chk(g_nmba_m.nmbasite,g_glaald,g_user,'6','N','',g_nmba_m.nmbadocdt) RETURNING l_success,g_errno #150714-00024#1 mark
                  CALL s_fin_account_center_with_ld_chk(g_nmba_m.nmbasite,'',g_user,'6','N','',g_nmba_m.nmbadocdt) RETURNING l_success,g_errno #150714-00024#1
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
#                    LET g_errparam.code = 'anm-00274'   #2015/03/31 by 02599 mark
                     LET g_errparam.code = g_errno       #2015/03/31 by 02599 add
                     LET g_errparam.extend = g_nmba_m.nmbasite
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #LET g_nmba_m.nmbasite = g_nmba_m_t.nmbasite   #160822-00012#5   mark
                     LET g_nmba_m.nmbasite = g_nmba_m_o.nmbasite    #160822-00012#5   add
                     CALL anmt310_nmbasite_desc()
                     NEXT FIELD CURRENT
                  END IF
                  
                  #150714-00024#1 add ------
                  CALL s_anm_get_comp_wc('6',g_nmba_m.nmbasite,g_nmba_m.nmbadocdt) RETURNING g_comp_wc
                 #IF NOT cl_null(g_nmba_m.nmbacomp) AND s_chr_get_index_of(g_comp_wc,g_nmba_m.nmbacomp,1) = 0 THEN   #160816-00012#3 Mark
                  IF NOT cl_null(g_nmba_m.nmbacomp) THEN   #160816-00012#3 Add
                     IF s_chr_get_index_of(g_comp_wc,g_nmba_m.nmbacomp,1) = 0 THEN   #160816-00012#3 Add
                        LET g_nmba_m.nmbacomp = ''   #160822-00012#5   add
                        SELECT ooef017 INTO g_nmba_m.nmbacomp
                          FROM ooef_t
                         WHERE ooefent = g_enterprise
                           AND ooef001 = g_nmba_m.nmbasite
                        #160816-00012#3 Add  ---(S)---
                        #检查用户是否有资金中心对应法人的权限
                        CALL s_axrt300_get_site(g_user,'','3') RETURNING l_wc
                        LET l_count = 0
                        LET l_sql = "SELECT COUNT(*) FROM ooef_t WHERE ooefent = '",g_enterprise,"' ",
                                    "   AND ooef001 = '",g_nmba_m.nmbacomp,"'",
                                    "   AND ooef003 = 'Y'",
                                    "   AND ",l_wc CLIPPED
                        PREPARE anmp410_count_prep FROM l_sql
                        EXECUTE anmp410_count_prep INTO l_count
                        IF cl_null(l_count) THEN LET l_count = 0 END IF
                        IF l_count = 0 THEN
                           LET g_nmba_m.nmbacomp = ''
                           LET g_nmba_m.nmbacomp_desc = ''
                           DISPLAY BY NAME g_nmba_m.nmbacomp,g_nmba_m.nmbacomp_desc
                        END IF
                        #160816-00012#3 Add  ---(E)---
                        DISPLAY BY NAME g_nmba_m.nmbacomp
                        #CALL s_anm_get_site_wc('6',g_nmba_m.nmbacomp,g_nmba_m.nmbadocdt) RETURNING g_site_wc #160912-00024#1 mark
                        CALL anmt310_glaa_get()
                     END IF
                  END IF   #160816-00012#3 Add
                  CALL s_anm_get_site_wc('6',g_nmba_m.nmbasite,g_nmba_m.nmbadocdt) RETURNING g_site_wc #160912-00024#1 add
                  LET g_nmba_m.nmbacomp_desc = s_desc_get_department_desc(g_nmba_m.nmbacomp)
                  DISPLAY BY NAME g_nmba_m.nmbacomp_desc
                  #150714-00024#1 add end---
               END IF
            END IF
            CALL anmt310_nmbasite_desc()
            LET g_nmba_m_o.* = g_nmba_m.*   #160822-00012#5   add
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
         AFTER FIELD nmba002
            
            #add-point:AFTER FIELD nmba002 name="input.a.nmba002"
            IF NOT cl_null(g_nmba_m.nmba002) THEN 
               CALL anmt310_nmba002_chk(g_nmba_m.nmba002)
               IF NOT cl_null(g_errno) THEN 
                  IF p_cmd = 'a' THEN 
                     DISPLAY '' TO nmba002
                     DISPLAY '' TO nmba002_desc
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_nmba_m.nmba002
                     #160318-00005#27 by 07900 --add--str
                     LET g_errparam.replace[1] = 'aooi130'
                     LET g_errparam.replace[2] = cl_get_progname("aooi130",g_lang,"2")
                     LET g_errparam.exeprog ='aooi130'
                     #160318-00005#27 by 07900 --add--end
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_nmba_m.nmba002 = ''
                     LET g_nmba_m.nmba002_desc = ''
                  ELSE
                     DISPLAY '' TO nmba002
                     DISPLAY '' TO nmba002_desc
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_nmba_m.nmba002
                     #160318-00005#27 by 07900 --add--str
                     LET g_errparam.replace[1] = 'aooi130'
                     LET g_errparam.replace[2] = cl_get_progname("aooi130",g_lang,"2")
                     LET g_errparam.exeprog ='aooi130'
                     #160318-00005#27 by 07900 --add--end
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_nmba_m.nmba002 = g_nmba_m_t.nmba002
                     #151016-00018#1-----s
                     #CALL anmt310_show()
                     SELECT oofa011 INTO g_nmba_m.nmba002_desc
                       FROM oofa_t
                      WHERE oofaent = g_enterprise
                        AND oofa001 IN (SELECT ooag002 FROM ooag_t
                                          WHERE ooagent = g_enterprise
                                            AND ooag001 = g_nmba_m.nmba002)
                     DISPLAY g_nmba_m.nmba002_desc TO nmba002_desc
                     #151016-00018#1-----e
                  END IF 
                  NEXT FIELD nmba002
               END IF 
            END IF 
            #151016-00018#1-----s
            #CALL anmt310_show()
            SELECT oofa011 INTO g_nmba_m.nmba002_desc
              FROM oofa_t
             WHERE oofaent = g_enterprise
               AND oofa001 IN (SELECT ooag002 FROM ooag_t
                                 WHERE ooagent = g_enterprise
                                   AND ooag001 = g_nmba_m.nmba002)
            DISPLAY g_nmba_m.nmba002_desc TO nmba002_desc
            #151016-00018#1-----e
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmba002
            #add-point:BEFORE FIELD nmba002 name="input.b.nmba002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmba002
            #add-point:ON CHANGE nmba002 name="input.g.nmba002"
            
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
            
            #CALL anmt310_glaa_get() #150714-00024#1 mark

            IF NOT cl_null(g_nmba_m.nmbacomp) THEN 
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_nmba_m.nmbacomp != g_nmba_m_t.nmbacomp OR g_nmba_m_t.nmbacomp IS NULL )) THEN   #160822-00012#5   mark
               IF g_nmba_m.nmbacomp != g_nmba_m_o.nmbacomp OR cl_null(g_nmba_m_o.nmbacomp) THEN                                       #160822-00012#5   add
                  CALL s_fin_comp_chk(g_nmba_m.nmbacomp) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     #160321-00016#39 --s add
                     LET g_errparam.replace[1] = 'aooi100'
                     LET g_errparam.replace[2] = cl_get_progname('aooi100',g_lang,"2")
                     LET g_errparam.exeprog = 'aooi100'
                     #160321-00016#39 --e add
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #LET g_nmba_m.nmbacomp = g_nmba_m_t.nmbacomp   #160822-00012#5   mark
                     LET g_nmba_m.nmbacomp = g_nmba_m_o.nmbacomp    #160822-00012#5   add
                     CALL anmt310_nmbacomp_desc()
                     NEXT FIELD CURRENT
                  END IF
                  
                  #150714-00024#1 mark ------
                  #IF NOT cl_null(g_nmba_m.nmbacomp)THEN
                  #   CALL s_fin_account_center_with_ld_chk(g_nmba_m.nmbasite,g_glaald,g_user,'6','Y','',g_nmba_m.nmbadocdt) 
                  #      RETURNING g_sub_success,g_errno
                  #   IF NOT g_sub_success THEN
                  #      INITIALIZE g_errparam TO NULL
#                 #       LET g_errparam.code = 'anm-00274'
                  #      LET g_errparam.code = g_errno
                  #      LET g_errparam.extend = ''
                  #      LET g_errparam.popup = TRUE
                  #      CALL cl_err()
                  #      LET g_nmba_m.nmbacomp = g_nmba_m_t.nmbacomp
                  #      CALL anmt310_nmbacomp_desc()
                  #      NEXT FIELD CURRENT
                  #   END IF   
                  #END IF
                  #150714-00024#1 mark end---
                  #150714-00024#1 add ------
                  IF NOT cl_null(g_nmba_m.nmbasite) THEN #160816-00012#3 add 
                     IF s_chr_get_index_of(g_comp_wc,g_nmba_m.nmbacomp,1) = 0 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'anm-02928'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        #LET g_nmba_m.nmbacomp = g_nmba_m_t.nmbacomp   #160822-00012#5   mark
                        LET g_nmba_m.nmbacomp = g_nmba_m_o.nmbacomp    #160822-00012#5   add
                        CALL anmt310_nmbacomp_desc()
                        NEXT FIELD CURRENT
                     END IF
                  END IF #160816-00012#3   
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
                     #LET g_nmba_m.nmbacomp = g_nmba_m_t.nmbacomp   #160822-00012#5   mark
                     LET g_nmba_m.nmbacomp = g_nmba_m_o.nmbacomp    #160822-00012#5   add
                     CALL anmt310_nmbacomp_desc()                     
                     NEXT FIELD CURRENT
                  END IF
                  #160816-00012#3 Add  ---(E)---
                  #CALL s_anm_get_site_wc('6',g_nmba_m.nmbacomp,g_nmba_m.nmbadocdt) RETURNING g_site_wc  #160912-00024#1 mark
                  CALL anmt310_glaa_get()
                  #150714-00024#1 add end---
               END IF
            END IF 
            #CALL anmt310_glaa_get() #150714-00024#1 mark
            CALL anmt310_nmbacomp_desc()
            LET g_nmba_m_o.* = g_nmba_m.*   #160822-00012#5   add
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
         BEFORE FIELD nmbadocno
            #add-point:BEFORE FIELD nmbadocno name="input.b.nmbadocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbadocno
            
            #add-point:AFTER FIELD nmbadocno name="input.a.nmbadocno"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_nmba_m.nmbacomp) AND NOT cl_null(g_nmba_m.nmbadocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_nmba_m.nmbacomp != g_nmbacomp_t  OR g_nmba_m.nmbadocno != g_nmbadocno_t )) THEN 
                  IF NOT ap_chk_notDup(g_nmba_m.nmbadocno,"SELECT COUNT(*) FROM nmba_t WHERE "||"nmbaent = '" ||g_enterprise|| "' AND "||"nmbacomp = '"||g_nmba_m.nmbacomp ||"' AND "|| "nmbadocno = '"||g_nmba_m.nmbadocno ||"'",'std-00004',0) THEN 
                     LET g_nmba_m.nmbadocno = ''
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            IF NOT cl_null(g_nmba_m.nmbadocno) THEN 
               #财务改为使用s_aooi200_fin中的FUNCTION---2014/12/26 liuym mark-----str-----
               #CALL s_aooi200_chk_slip(g_nmba_m.nmbacomp,g_glaa024,g_nmba_m.nmbadocno,'anmt310') RETURNING l_success
               #2014/12/26 liuym mark-----end-----
                #2014/12/26 liuym add-----str-----
               #财务改为使用s_aooi200_fin中的FUNCTION---
               CALL s_aooi200_fin_chk_slip(g_glaald,g_glaa024,g_nmba_m.nmbadocno,'anmt310') RETURNING l_success
               #2014/12/26 liuym add-----end-----
               IF l_success = FALSE THEN 
                  LET g_nmba_m.nmbadocno = g_nmba_m_t.nmbadocno
                  NEXT FIELD nmbadocno
               END IF
               #161104-00046#12-----s
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
               #161104-00046#12-----e  
               CALL anmt310_nmba006_chk()   #150616-00026#12
            END IF

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
               #150813-00015#3--mod--str--
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_nmba_m.nmbadocdt <>g_nmba_m_t.nmbadocdt OR cl_null(g_nmba_m_t.nmbadocdt))) THEN    #160822-00012#5   mark
               IF g_nmba_m.nmbadocdt != g_nmba_m_o.nmbadocdt OR cl_null(g_nmba_m_o.nmbadocdt) THEN                                        #160822-00012#5   addd
                  #檢查當單據日期小於等於關帳日期時，不可異動單據
                  CALL s_fin_date_close_chk('',g_nmba_m.nmbacomp,'ANM',g_nmba_m.nmbadocdt) RETURNING l_success
                  IF l_success=FALSE THEN
                     #LET g_nmba_m.nmbadocdt = g_nmba_m_t.nmbadocdt   #160822-00012#5   mark
                     LET g_nmba_m.nmbadocdt = g_nmba_m_o.nmbadocdt    #160822-00012#5   add
                     NEXT FIELD nmbadocdt
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
               END IF
               #150813-00015#3--mod--end
            END IF
            LET g_nmba_m_o.* = g_nmba_m.*   #160822-00012#5   add            
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
         BEFORE FIELD nmba003_desc
            #add-point:BEFORE FIELD nmba003_desc name="input.b.nmba003_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmba003_desc
            
            #add-point:AFTER FIELD nmba003_desc name="input.a.nmba003_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmba003_desc
            #add-point:ON CHANGE nmba003_desc name="input.g.nmba003_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmba015
            #add-point:BEFORE FIELD nmba015 name="input.b.nmba015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmba015
            
            #add-point:AFTER FIELD nmba015 name="input.a.nmba015"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmba015
            #add-point:ON CHANGE nmba015 name="input.g.nmba015"
            #160509-0004#20--STR--
            IF g_nmba_m.nmba015='Y' THEN 
               CALL cl_set_comp_visible("nmbb070,nmbb070_desc", TRUE)
               CALL cl_set_comp_required("nmbb070",TRUE)
            ELSE 
               CALL cl_set_comp_visible("nmbb070,nmbb070_desc", FALSE)
            END IF   
            #160509-0004#20--END--
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmba004
            
            #add-point:AFTER FIELD nmba004 name="input.a.nmba004"
            IF NOT cl_null(g_nmba_m.nmba004) THEN 
               CALL anmt310_nmba004_chk(g_nmba_m.nmba004)
               IF NOT cl_null(g_errno) THEN 
                  IF p_cmd = 'a' THEN 
                     DISPLAY '' TO nmba004
                     DISPLAY '' TO nmba004_desc
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_nmba_m.nmba004
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_nmba_m.nmba004 = ''
                     LET g_nmba_m.nmba004_desc = ''
                  ELSE
                     DISPLAY '' TO nmba004
                     DISPLAY '' TO nmba004_desc
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_nmba_m.nmba004
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_nmba_m.nmba004 = g_nmba_m_t.nmba004
                     CALL anmt310_show()
                  END IF 
                  NEXT FIELD nmba004
               END IF 
            END IF 
            CALL anmt310_show()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmba004
            #add-point:BEFORE FIELD nmba004 name="input.b.nmba004"
            
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
         BEFORE FIELD nmba007
            #add-point:BEFORE FIELD nmba007 name="input.b.nmba007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmba007
            
            #add-point:AFTER FIELD nmba007 name="input.a.nmba007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmba007
            #add-point:ON CHANGE nmba007 name="input.g.nmba007"
            
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
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_nmba_m.nmbasite
            LET g_qryparam.where = " ooef206 = 'Y'"
            LET g_qryparam.where = g_qryparam.where," AND ooefstus= 'Y'" #161021-00050#8
            #CALL q_ooef001()    #161021-00050#8 mark
            CALL q_ooef001_33()  #161021-00050#8
            LET g_nmba_m.nmbasite = g_qryparam.return1
            DISPLAY g_nmba_m.nmbasite TO nmbasite
            CALL anmt310_nmbasite_desc()
            NEXT FIELD nmbasite
            #END add-point
 
 
         #Ctrlp:input.c.nmba002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmba002
            #add-point:ON ACTION controlp INFIELD nmba002 name="input.c.nmba002"
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_nmba_m.nmba002
            LET g_qryparam.default2 = "" #g_nmba_m.oofa011 #全名
            CALL q_ooag001_2()
            LET g_nmba_m.nmba002 = g_qryparam.return1
            #LET g_nmba_m.oofa011 = g_qryparam.return2 #全名
            DISPLAY g_nmba_m.nmba002 TO nmba002
            #DISPLAY g_nmba_m.oofa011 TO oofa011 #全名
            CALL anmt310_show()
            NEXT FIELD nmba002
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
            #150714-00024#1 mark ------
            #CALL s_fin_account_center_sons_query('6',g_nmba_m.nmbasite,g_today,'')
            #CALL s_fin_account_center_comp_str()RETURNING l_origin_str
            #CALL anmt310_change_to_sql(l_origin_str)RETURNING l_origin_str
            #LET g_qryparam.where = " ooef003 = 'Y' AND ooef001 IN(",l_origin_str CLIPPED,") "
            #150714-00024#1 mark end---
            CALL s_anm_get_comp_wc('6',g_nmba_m.nmbasite,g_nmba_m.nmbadocdt) RETURNING g_comp_wc  #160816-00012#3 add
            LET g_qryparam.where = " ooef001 IN ",g_comp_wc   #150714-00024#1
            #160816-00012#3 Add  ---(S)---
            CALL s_axrt300_get_site(g_user,'','3') RETURNING l_wc
            LET g_qryparam.where = g_qryparam.where," AND ",l_wc CLIPPED," AND ooef003 = 'Y'"
            #160816-00012#3 Add  ---(E)---
            #CALL q_ooef001()  #161021-00050#8 mark
            CALL q_ooef001_2() #161021-00050#8
            LET g_nmba_m.nmbacomp = g_qryparam.return1
            CALL anmt310_nmbacomp_desc()
            DISPLAY g_nmba_m.nmbacomp TO nmbacomp
            NEXT FIELD nmbacomp
            #END add-point
 
 
         #Ctrlp:input.c.nmbadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbadocno
            #add-point:ON ACTION controlp INFIELD nmbadocno name="input.c.nmbadocno"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_nmba_m.nmbadocno
            LET g_qryparam.where = "ooba001 = '",g_glaa024,"' AND oobx003 = 'anmt310'"
            #161104-00046#12-----s
            IF NOT cl_null(g_user_slip_wc)THEN
               LET g_qryparam.where = g_qryparam.where," AND ",g_user_slip_wc CLIPPED
            END IF
            #161104-00046#12-----e
            CALL q_ooba002_4()
            LET g_nmba_m.nmbadocno = g_qryparam.return1
            DISPLAY g_nmba_m.nmbadocno TO nmbadocno
            NEXT FIELD nmbadocno
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
 
 
         #Ctrlp:input.c.nmba003_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmba003_desc
            #add-point:ON ACTION controlp INFIELD nmba003_desc name="input.c.nmba003_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmba015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmba015
            #add-point:ON ACTION controlp INFIELD nmba015 name="input.c.nmba015"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmba004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmba004
            #add-point:ON ACTION controlp INFIELD nmba004 name="input.c.nmba004"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_nmba_m.nmba004             #給予default值

            #給予arg

           # CALL q_pmaa001()       #160913-00017#6  mark                  #呼叫開窗
            CALL q_pmaa001_25()     #160913-00017#6  add      

            LET g_nmba_m.nmba004 = g_qryparam.return1              #將開窗取得的值回傳到變數
 
            DISPLAY g_nmba_m.nmba004 TO nmba004              #顯示到畫面上
            CALL anmt310_show()
            NEXT FIELD nmba004                          #返回原欄位


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
 
 
         #Ctrlp:input.c.nmba007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmba007
            #add-point:ON ACTION controlp INFIELD nmba007 name="input.c.nmba007"
            
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
                  #财务改为使用s_aooi200_fin中的FUNCTION---2014/12/26 liuym mark-----str-----
                  #CALL s_aooi200_gen_docno(g_nmba_m.nmbacomp,g_nmba_m.nmbadocno,g_nmba_m.nmbadocdt,g_prog)
                  #RETURNING l_success,g_nmba_m.nmbadocno
                  #2014/12/26 liuym add-----str-----
                  #财务改为使用s_aooi200_fin中的FUNCTION---
    
                  CALL s_aooi200_fin_gen_docno(g_glaald,g_glaa024,g_glaa003,g_nmba_m.nmbadocno,g_nmba_m.nmbadocdt,g_prog)
                        RETURNING l_success,g_nmba_m.nmbadocno
                  #2014/12/26 liuym add-----end-----                        
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
               
               INSERT INTO nmba_t (nmbaent,nmbasite,nmba002,nmbacomp,nmbadocno,nmbadocdt,nmba003,nmba015, 
                   nmba004,nmba005,nmba006,nmba007,nmbastus,nmbaownid,nmbaowndp,nmbacrtid,nmbacrtdp, 
                   nmbacrtdt,nmbamodid,nmbamoddt,nmbacnfid,nmbacnfdt)
               VALUES (g_enterprise,g_nmba_m.nmbasite,g_nmba_m.nmba002,g_nmba_m.nmbacomp,g_nmba_m.nmbadocno, 
                   g_nmba_m.nmbadocdt,g_nmba_m.nmba003,g_nmba_m.nmba015,g_nmba_m.nmba004,g_nmba_m.nmba005, 
                   g_nmba_m.nmba006,g_nmba_m.nmba007,g_nmba_m.nmbastus,g_nmba_m.nmbaownid,g_nmba_m.nmbaowndp, 
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
                  CALL anmt310_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL anmt310_b_fill()
                  CALL anmt310_b_fill2('0')
               END IF
               
               #add-point:單頭新增後 name="input.head.a_insert2"
               #151016-00018#2-----s
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL anmt310_b_fill_2()
                  CALL anmt310_b_fill_3() 
               END IF
               #151016-00018#2-----e
               #end add-point
               
               LET g_master_insert = TRUE
               
               LET p_cmd = 'u'
            ELSE
               CALL s_transaction_begin()
            
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL anmt310_nmba_t_mask_restore('restore_mask_o')
               
               UPDATE nmba_t SET (nmbasite,nmba002,nmbacomp,nmbadocno,nmbadocdt,nmba003,nmba015,nmba004, 
                   nmba005,nmba006,nmba007,nmbastus,nmbaownid,nmbaowndp,nmbacrtid,nmbacrtdp,nmbacrtdt, 
                   nmbamodid,nmbamoddt,nmbacnfid,nmbacnfdt) = (g_nmba_m.nmbasite,g_nmba_m.nmba002,g_nmba_m.nmbacomp, 
                   g_nmba_m.nmbadocno,g_nmba_m.nmbadocdt,g_nmba_m.nmba003,g_nmba_m.nmba015,g_nmba_m.nmba004, 
                   g_nmba_m.nmba005,g_nmba_m.nmba006,g_nmba_m.nmba007,g_nmba_m.nmbastus,g_nmba_m.nmbaownid, 
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
               CALL anmt310_nmba_t_mask_restore('restore_mask_n')
               
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
 
{<section id="anmt310.input.body" >}
   
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
 
            CALL anmt310_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_nmbb_d.getLength()
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
            OPEN anmt310_cl USING g_enterprise,g_nmba_m.nmbacomp,g_nmba_m.nmbadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN anmt310_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE anmt310_cl
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
               CALL anmt310_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL anmt310_set_no_entry_b(l_cmd)
               IF NOT anmt310_lock_b("nmbb_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH anmt310_bcl INTO g_nmbb_d[l_ac].nmbbseq,g_nmbb_d[l_ac].nmbborga,g_nmbb_d[l_ac].nmbb071, 
                      g_nmbb_d[l_ac].nmbb072,g_nmbb_d[l_ac].nmbb053,g_nmbb_d[l_ac].nmbb054,g_nmbb_d[l_ac].nmbb070, 
                      g_nmbb_d[l_ac].nmbblegl,g_nmbb_d[l_ac].nmbb001,g_nmbb_d[l_ac].nmbb002,g_nmbb_d[l_ac].nmbb003, 
                      g_nmbb_d[l_ac].nmbb029,g_nmbb_d[l_ac].nmbb004,g_nmbb_d[l_ac].nmbb005,g_nmbb_d[l_ac].nmbb006, 
                      g_nmbb_d[l_ac].nmbb007,g_nmbb_d[l_ac].nmbb010,g_nmbb_d[l_ac].nmbb025,g_nmbb_d[l_ac].nmbb011, 
                      g_nmbb_d[l_ac].nmbb012,g_nmbb_d[l_ac].nmbb013,g_nmbb_d[l_ac].nmbb014,g_nmbb_d[l_ac].nmbb015, 
                      g_nmbb_d[l_ac].nmbb016,g_nmbb_d[l_ac].nmbb017,g_nmbb_d[l_ac].nmbb018,g_nmbb_d[l_ac].nmbb008, 
                      g_nmbb_d[l_ac].nmbb009,g_nmbb_d[l_ac].nmbb019,g_nmbb_d[l_ac].nmbb020,g_nmbb_d[l_ac].nmbb021, 
                      g_nmbb_d[l_ac].nmbb022,g_nmbb_d[l_ac].nmbb023,g_nmbb_d[l_ac].nmbb024,g_nmbb_d[l_ac].nmbb026, 
                      g_nmbb_d[l_ac].nmbb027,g_nmbb_d[l_ac].nmbb056,g_nmbb_d[l_ac].nmbb057,g_nmbb_d[l_ac].nmbb058, 
                      g_nmbb_d[l_ac].nmbb059,g_nmbb_d[l_ac].nmbb060,g_nmbb_d[l_ac].nmbb061,g_nmbb_d[l_ac].nmbb062, 
                      g_nmbb_d[l_ac].nmbb066,g_nmbb_d[l_ac].nmbb067,g_nmbb_d[l_ac].nmbb068
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
                  CALL anmt310_nmbb_t_mask()
                  LET g_nmbb_d_mask_n[l_ac].* =  g_nmbb_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL anmt310_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            CALL anmt310_ref_b()
            IF g_nmbb_d[l_ac].nmbb001 = '3' OR g_nmbb_d[l_ac].nmbb001 = '4' THEN
               CALL cl_set_comp_required('nmbb003',FALSE)
            ELSE
               CALL cl_set_comp_required('nmbb003',TRUE)
            END IF
            CALL anmt310_nmbb001_entry()     #151222-00010#1
            
             
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
                  LET g_nmbb_d[l_ac].nmbb072 = "0"
      LET g_nmbb_d[l_ac].nmbb006 = "0"
      LET g_nmbb_d[l_ac].nmbb007 = "0"
      LET g_nmbb_d[l_ac].nmbb013 = "0"
      LET g_nmbb_d[l_ac].nmbb014 = "0"
      LET g_nmbb_d[l_ac].nmbb017 = "0"
      LET g_nmbb_d[l_ac].nmbb018 = "0"
      LET g_nmbb_d[l_ac].nmbb008 = "0"
      LET g_nmbb_d[l_ac].nmbb009 = "0"
      LET g_nmbb_d[l_ac].nmbb020 = "0"
      LET g_nmbb_d[l_ac].nmbb021 = "0"
      LET g_nmbb_d[l_ac].nmbb023 = "0"
      LET g_nmbb_d[l_ac].nmbb024 = "0"
      LET g_nmbb_d[l_ac].nmbb057 = "0"
      LET g_nmbb_d[l_ac].nmbb058 = "0"
      LET g_nmbb_d[l_ac].nmbb059 = "0"
      LET g_nmbb_d[l_ac].nmbb060 = "0"
      LET g_nmbb_d[l_ac].nmbb062 = "0"
      LET g_nmbb_d[l_ac].nmbb066 = "0"
      LET g_nmbb_d[l_ac].nmbb067 = "0"
      LET g_nmbb_d[l_ac].nmbb068 = "0"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            LET g_nmbb_d[l_ac].nmbborga = g_nmba_m.nmbasite  #160912-00024#1 add
            CALL s_anm_orga_chk(g_nmbb_d[l_ac].nmbborga,g_nmba_m.nmbacomp) RETURNING g_nmbb_d[l_ac].nmbborga  #160912-00024#1 add
            #end add-point
            LET g_nmbb_d_t.* = g_nmbb_d[l_ac].*     #新輸入資料
            LET g_nmbb_d_o.* = g_nmbb_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL anmt310_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
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

            #LET g_nmbb_d[l_ac].nmbborga = g_nmba_m.nmbacomp    # 默认单头的法人组织    #160912-00024#1 mark
            LET g_nmbb_d[l_ac].nmbb053 = g_user
            LET g_nmbb_d[l_ac].nmbb054 = g_ooag004
            LET g_nmbb_d[l_ac].nmbb004 = g_ooef016
            CALL anmt310_ref_b()
            LET l_ooab002 = ''
            #150930-00010#4--s
            LET g_nmbb_d[l_ac].nmbb001 = '1'
            CALL anmt310_nmbb001_entry()     #151222-00010#1
            CALL anmt310_get_exrate()   #取得匯率
            #150930-00010#4--e
            #150930-00010#4 mark--s
            ##銀存收入匯率來源
            #SELECT ooab002 INTO l_ooab002 FROM ooab_t
            # WHERE ooabent = g_enterprise
            #   AND ooabsite= g_ooef001
            #   #AND ooab001 = 'S-BAS-0010'
            #    AND ooab001 = 'S-FIN-4004'   #150820-00017 
            #
            #                            #匯率參照表;帳套;           日期;               來源幣別
            #CALL s_aooi160_get_exrate('2',g_glaald,g_nmba_m.nmbadocdt,g_nmbb_d[l_ac].nmbb004,
            #                         #目的幣別;  交易金額;              匯類類型
            #                          g_ooef016,0,l_ooab002)
            #RETURNING g_nmbb_d[l_ac].nmbb005
            #150930-00010#4 mark--e

            LET g_nmbb_d[l_ac].nmbb026 = g_nmba_m.nmba004 
            LET g_nmbb_d[l_ac].nmbb027 = g_nmba_m.nmba005 
            #end add-point
            CALL anmt310_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_nmbb_d[li_reproduce_target].* = g_nmbb_d[li_reproduce].*
 
               LET g_nmbb_d[li_reproduce_target].nmbbseq = NULL
 
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
            CALL anmt310_ref_amt()
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
               CALL anmt310_insert_b('nmbb_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               IF g_nmbb_d[l_ac].nmbb001 = '1' OR g_nmbb_d[l_ac].nmbb001 = '2' THEN
                  CALL anmt310_glbc_ins()
               END IF 
               CALL anmt310_b_fill_2()
               CALL anmt310_b_fill_3()
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
               #CALL anmt310_b_fill()
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
               LET gs_keys[01] = g_nmba_m.nmbacomp
               LET gs_keys[gs_keys.getLength()+1] = g_nmba_m.nmbadocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_nmbb_d_t.nmbbseq
 
            
               #刪除同層單身
               IF NOT anmt310_delete_b('nmbb_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE anmt310_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT anmt310_key_delete_b(gs_keys,'nmbb_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE anmt310_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               #150807-00007#1 add ------
               CALL s_cashflow_nm_del_glbc(g_nmba_m.nmbadocdt,g_glaald,g_nmba_m.nmbadocno,g_nmbb_d_t.nmbbseq)
                    RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  CALL s_transaction_end('N','0')
                  CLOSE anmt310_bcl
                  CANCEL DELETE
               END IF
               #150807-00007#1 add end---
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE anmt310_bcl
            
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
            IF  NOT cl_null(g_nmba_m.nmbacomp) AND NOT cl_null(g_nmba_m.nmbadocno) AND NOT cl_null(g_nmbb_d[g_detail_idx].nmbbseq) THEN 
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
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_nmbb_d[l_ac].nmbborga != g_nmbb_d_t.nmbborga OR g_nmbb_d_t.nmbborga IS NULL )) THEN   #160822-00012#5   mark
               IF g_nmbb_d[l_ac].nmbborga != g_nmbb_d_o.nmbborga OR cl_null(g_nmbb_d_o.nmbborga) THEN                                       #160822-00012#5   add
                  #150714-00024#1 mark ------
                  #CALL s_fin_apcborga_chk(g_nmba_m.nmbasite,g_nmba_m.nmbacomp,g_nmbb_d[l_ac].nmbborga,g_nmba_m.nmbadocdt,'6')
                  #   RETURNING g_sub_success,g_errno
                  #IF g_errno = 'aap-00120' THEN 
                  #   LET g_errno = 'anm-00276'
                  #END IF
                  #IF g_errno = 'aap-00034' THEN 
                  #   LET g_errno = 'anm-00277'
                  #END IF
                  #IF NOT g_sub_success THEN
                  #150714-00024#1 mark end---
                  #150714-00024#1 add ------
                  CALL s_anm_ooef001_chk(g_nmbb_d[l_ac].nmbborga) RETURNING g_sub_success,g_errno     
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ""
                     LET g_errparam.code   = g_errno
                     #160321-00016#39 --s add
                     LET g_errparam.replace[1] = 'aooi100'
                     LET g_errparam.replace[2] = cl_get_progname('aooi100',g_lang,"2")
                     LET g_errparam.exeprog = 'aooi100'
                     #160321-00016#39 --e add
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     #LET g_nmbb_d[l_ac].nmbborga = g_nmbb_d_t.nmbborga   #160822-00012#5   mark
                     LET g_nmbb_d[l_ac].nmbborga = g_nmbb_d_o.nmbborga    #160822-00012#5   add
                     CALL anmt310_ref_b()
                     NEXT FIELD CURRENT
                  END IF
                  
                  #160912-00024#1 add s---
                  CALL s_anm_get_site_wc('6',g_nmba_m.nmbasite,g_nmba_m.nmbadocdt) RETURNING g_site_wc
                  IF cl_null(g_site_wc) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'anm-03020' #该资金中心下无可用运营据点!
                     LET g_errparam.extend = g_nmba_m.nmbasite
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #LET g_nmbb_d[l_ac].nmbborga = g_nmbb_d_t.nmbborga   #160822-00012#5   mark
                     LET g_nmbb_d[l_ac].nmbborga = g_nmbb_d_o.nmbborga    #160822-00012#5   add
                     NEXT FIELD CURRENT
                  END IF                  
                  #160912-00024#1 add e---
                  
                  #檢查輸入組織代碼是否存在法人組織下的組織範圍內(1.與單頭法人組織法人相同2.屬於資金組織3.user具有拜訪權限)
                  LET g_errno =''   #160822-00012#5   add
                  IF s_chr_get_index_of(g_site_wc,g_nmbb_d[l_ac].nmbborga,1) = 0 THEN
                     LET g_errno ='axc-00099'
                  ELSE
                  #160912-00024#1 add s---   
                     IF NOT ap_chk_isExist(g_nmbb_d[l_ac].nmbborga,"SELECT COUNT(*) FROM ooef_t WHERE "||"ooefent = '" ||g_enterprise|| "' AND "||"ooef001 = ?  AND ooefstus ='Y' AND ooef017 = '"||g_nmba_m.nmbacomp||"'",'anm-03022',1) THEN 
                        #LET g_nmbb_d[l_ac].nmbborga = g_nmbb_d_t.nmbborga   #160822-00012#5   mark
                        LET g_nmbb_d[l_ac].nmbborga = g_nmbb_d_o.nmbborga    #160822-00012#5   add
                        NEXT FIELD CURRENT
                     END IF 
                  #160912-00024#1 add e---                    
                  END IF
                  IF NOT cl_null(g_errno) THEN
                  #150714-00024#1 add end---
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ""
                     LET g_errparam.code   = g_errno
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     #LET g_nmbb_d[l_ac].nmbborga = g_nmbb_d_t.nmbborga   #160822-00012#5   mark
                     LET g_nmbb_d[l_ac].nmbborga = g_nmbb_d_o.nmbborga    #160822-00012#5   add
                     CALL anmt310_ref_b()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL anmt310_ref_b()
            LET g_nmbb_d_o.* = g_nmbb_d[l_ac].*   #160822-00012#   add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbborga
            #add-point:BEFORE FIELD nmbborga name="input.b.page1.nmbborga"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbborga
            #add-point:ON CHANGE nmbborga name="input.g.page1.nmbborga"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb071
            #add-point:BEFORE FIELD nmbb071 name="input.b.page1.nmbb071"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb071
            
            #add-point:AFTER FIELD nmbb071 name="input.a.page1.nmbb071"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbb071
            #add-point:ON CHANGE nmbb071 name="input.g.page1.nmbb071"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb072
            #add-point:BEFORE FIELD nmbb072 name="input.b.page1.nmbb072"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb072
            
            #add-point:AFTER FIELD nmbb072 name="input.a.page1.nmbb072"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbb072
            #add-point:ON CHANGE nmbb072 name="input.g.page1.nmbb072"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb053
            #add-point:BEFORE FIELD nmbb053 name="input.b.page1.nmbb053"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb053
            
            #add-point:AFTER FIELD nmbb053 name="input.a.page1.nmbb053"
            IF not cl_null(g_nmbb_d[l_ac].nmbb053) then 
               CALL anmt310_nmba002_chk(g_nmbb_d[l_ac].nmbb053)
               IF NOT cl_null(g_errno) THEN 
                  IF l_cmd = 'a' THEN 
                     DISPLAY '' TO s_detail1[l_ac].nmbb053
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_nmbb_d[l_ac].nmbb053
                     #160318-00005#27 by 07900 --add--str
                     LET g_errparam.replace[1] = 'aooi130'
                     LET g_errparam.replace[2] = cl_get_progname("aooi130",g_lang,"2")
                     LET g_errparam.exeprog ='aooi130'
                     #160318-00005#27 by 07900 --add--end
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_nmbb_d[l_ac].nmbb053 = ''
                  ELSE
                     DISPLAY '' TO s_detail1[l_ac].nmbb053
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_nmbb_d[l_ac].nmbb053
                     #160318-00005#27 by 07900 --add--str
                     LET g_errparam.replace[1] = 'aooi130'
                     LET g_errparam.replace[2] = cl_get_progname("aooi130",g_lang,"2")
                     LET g_errparam.exeprog ='aooi130'
                     #160318-00005#27 by 07900 --add--end
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_nmbb_d[l_ac].nmbb053 = g_nmbb_d_t.nmbb053
                  END IF 
                  NEXT FIELD nmbb053
               END IF
            end if 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbb053
            #add-point:ON CHANGE nmbb053 name="input.g.page1.nmbb053"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb053_desc
            #add-point:BEFORE FIELD nmbb053_desc name="input.b.page1.nmbb053_desc"
            LET g_nmbb_d[l_ac].nmbb053_desc = g_nmbb_d[l_ac].nmbb053
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb053_desc
            
            #add-point:AFTER FIELD nmbb053_desc name="input.a.page1.nmbb053_desc"
            LET g_nmbb_d[l_ac].nmbb053 = g_nmbb_d[l_ac].nmbb053_desc  
            IF NOT cl_null(g_nmbb_d[l_ac].nmbb053_desc) THEN 
               CALL anmt310_nmba002_chk(g_nmbb_d[l_ac].nmbb053)
               IF NOT cl_null(g_errno) THEN 
                  IF l_cmd = 'a' THEN 
                     DISPLAY '' TO s_detail1[l_ac].nmbb053_desc
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_nmbb_d[l_ac].nmbb053
                     #160318-00005#27 by 07900 --add--str
                     LET g_errparam.replace[1] = 'aooi130'
                     LET g_errparam.replace[2] = cl_get_progname("aooi130",g_lang,"2")
                     LET g_errparam.exeprog ='aooi130'
                     #160318-00005#27 by 07900 --add--end
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_nmbb_d[l_ac].nmbb053 = ''
                     LET g_nmbb_d[l_ac].nmbb053_desc = ''
                  ELSE
                     DISPLAY '' TO s_detail1[l_ac].nmbb053_desc
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_nmbb_d[l_ac].nmbb053
                     #160318-00005#27 by 07900 --add--str
                     LET g_errparam.replace[1] = 'aooi130'
                     LET g_errparam.replace[2] = cl_get_progname("aooi130",g_lang,"2")
                     LET g_errparam.exeprog ='aooi130'
                     #160318-00005#27 by 07900 --add--end
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_nmbb_d[l_ac].nmbb053 = g_nmbb_d_t.nmbb053
                     LET g_nmbb_d[l_ac].nmbb053_desc = g_nmbb_d_t.nmbb053_desc
                  END IF 
                  NEXT FIELD nmbb053_desc
               END IF
            END IF 
            CALL anmt310_ref_b()
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbb053_desc
            #add-point:ON CHANGE nmbb053_desc name="input.g.page1.nmbb053_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb054
            #add-point:BEFORE FIELD nmbb054 name="input.b.page1.nmbb054"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb054
            
            #add-point:AFTER FIELD nmbb054 name="input.a.page1.nmbb054"
            IF NOT cl_null(g_nmbb_d[l_ac].nmbb054) THEN 
               CALL anmt310_nmbb054_chk()
               IF NOT cl_null(g_errno) THEN 
                  IF p_cmd = 'a' THEN  
                     DISPLAY '' TO s_detail1[l_ac].nmbb054
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_nmbb_d[l_ac].nmbb054
                     #160318-00005#27 by 07900 --add--str
                     LET g_errparam.replace[1] = 'aooi100'
                     LET g_errparam.replace[2] = cl_get_progname("aooi100",g_lang,"2")
                     LET g_errparam.exeprog ='aooi100'
                     #160318-00005#27 by 07900 --add--end
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_nmbb_d[l_ac].nmbb054 = ''
                  ELSE
                     DISPLAY '' TO s_detail1[l_ac].nmbb054
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_nmbb_d[l_ac].nmbb054
                     #160318-00005#27 by 07900 --add--str
                     LET g_errparam.replace[1] = 'aooi100'
                     LET g_errparam.replace[2] = cl_get_progname("aooi100",g_lang,"2")
                     LET g_errparam.exeprog ='aooi100'
                     #160318-00005#27 by 07900 --add--end
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_nmbb_d[l_ac].nmbb054 = g_nmbb_d_t.nmbb054
                  END IF 
                  NEXT FIELD nmbb054
               END IF 
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbb054
            #add-point:ON CHANGE nmbb054 name="input.g.page1.nmbb054"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb054_desc
            #add-point:BEFORE FIELD nmbb054_desc name="input.b.page1.nmbb054_desc"
            LET g_nmbb_d[l_ac].nmbb054_desc = g_nmbb_d[l_ac].nmbb054
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb054_desc
            
            #add-point:AFTER FIELD nmbb054_desc name="input.a.page1.nmbb054_desc"
            LET g_nmbb_d[l_ac].nmbb054 = g_nmbb_d[l_ac].nmbb054_desc  
            IF NOT cl_null(g_nmbb_d[l_ac].nmbb054_desc) THEN 
               CALL anmt310_nmbb054_chk()
               IF NOT cl_null(g_errno) THEN 
                  IF p_cmd = 'a' THEN  
                     DISPLAY '' TO s_detail1[l_ac].nmbb054
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_nmbb_d[l_ac].nmbb054
                     #160318-00005#27 by 07900 --add--str
                     LET g_errparam.replace[1] = 'aooi100'
                     LET g_errparam.replace[2] = cl_get_progname("aooi100",g_lang,"2")
                     LET g_errparam.exeprog ='aooi100'
                     #160318-00005#27 by 07900 --add--end
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_nmbb_d[l_ac].nmbb054 = ''
                     LET g_nmbb_d[l_ac].nmbb054_desc = ''
                  ELSE
                     DISPLAY '' TO s_detail1[l_ac].nmbb054
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_nmbb_d[l_ac].nmbb054
                     #160318-00005#27 by 07900 --add--str
                     LET g_errparam.replace[1] = 'aooi100'
                     LET g_errparam.replace[2] = cl_get_progname("aooi100",g_lang,"2")
                     LET g_errparam.exeprog ='aooi100'
                     #160318-00005#27 by 07900 --add--end
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_nmbb_d[l_ac].nmbb054 = g_nmbb_d_t.nmbb054
                     LET g_nmbb_d[l_ac].nmbb054_desc = g_nmbb_d_t.nmbb054_desc
                  END IF 
                  NEXT FIELD nmbb054_desc
               END IF 
            END IF 
            CALL anmt310_ref_b()
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbb054_desc
            #add-point:ON CHANGE nmbb054_desc name="input.g.page1.nmbb054_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb070
            
            #add-point:AFTER FIELD nmbb070 name="input.a.page1.nmbb070"
            #160509-0004--str--           
            IF NOT cl_null(g_nmbb_d[l_ac].nmbb070) THEN 
               CALL anmt310_nmbb070_chk()
               IF NOT cl_null(g_errno) THEN 
                  IF p_cmd = 'a' THEN  
                     DISPLAY '' TO s_detail1[l_ac].nmbb070
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_nmbb_d[l_ac].nmbb070
                     #160318-00005#27 by 07900 --add--str
                     LET g_errparam.replace[1] = 'aooi100'
                     LET g_errparam.replace[2] = cl_get_progname("aooi100",g_lang,"2")
                     LET g_errparam.exeprog ='aooi100'
                     #160318-00005#27 by 07900 --add--end
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_nmbb_d[l_ac].nmbb070 = ''
                  ELSE
                     DISPLAY '' TO s_detail1[l_ac].nmbb070
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_nmbb_d[l_ac].nmbb070
                     #160318-00005#27 by 07900 --add--str
                     LET g_errparam.replace[1] = 'aooi100'
                     LET g_errparam.replace[2] = cl_get_progname("aooi100",g_lang,"2")
                     LET g_errparam.exeprog ='aooi100'
                     #160318-00005#27 by 07900 --add--end
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_nmbb_d[l_ac].nmbb070 = g_nmbb_d_t.nmbb070
                  END IF 
                  NEXT FIELD nmbb070
               END IF
               #161021-00050#8 add ------
               #判斷是否為營運據點
               SELECT COUNT(1) INTO l_cnt
                 FROM ooef_t
                WHERE ooefent = g_enterprise
                  AND ooef001 = g_nmbb_d[l_ac].nmbb070
                  AND ooef201 = 'Y'
               IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
               IF l_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'axc-00115'
                  LET g_errparam.extend = g_nmbb_d[l_ac].nmbb070
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_nmbb_d[l_ac].nmbb070 = ''
               END IF
               #161021-00050#8 add end---
               call anmt310_ref_b()
            END IF 
            #160509-0004--end--
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb070
            #add-point:BEFORE FIELD nmbb070 name="input.b.page1.nmbb070"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbb070
            #add-point:ON CHANGE nmbb070 name="input.g.page1.nmbb070"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb001
            #add-point:BEFORE FIELD nmbb001 name="input.b.page1.nmbb001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb001
            
            #add-point:AFTER FIELD nmbb001 name="input.a.page1.nmbb001"
            IF NOT cl_null(g_nmbb_d[l_ac].nmbb002) THEN 
               CALL anmt310_nmbb002_chk() 
               IF NOT cl_null(g_errno) THEN 
                  IF l_cmd = 'a' THEN 
                     DISPLAY '' TO s_detail1[l_ac].nmbb002
                     DISPLAY '' TO s_detail1[l_ac].nmbb002_desc
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_nmbb_d[l_ac].nmbb002
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_nmbb_d[l_ac].nmbb002 = ''
                     LET g_nmbb_d[l_ac].nmbb002_desc = ''
                  ELSE
                     DISPLAY '' TO s_detail1[l_ac].nmbb002
                     DISPLAY '' TO s_detail1[l_ac].nmbb002_desc
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_nmbb_d[l_ac].nmbb002
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_nmbb_d[l_ac].nmbb002 = g_nmbb_d_t.nmbb002 
                     LET g_nmbb_d[l_ac].nmbb002_desc = g_nmbb_d_t.nmbb002_desc
                  END IF 
                  DISPLAY g_nmbb_d[l_ac].nmbb002 TO s_detail1[l_ac].nmbb002
                  DISPLAY g_nmbb_d[l_ac].nmbb002_desc TO s_detail1[l_ac].nmbb002_desc
                  NEXT FIELD nmbb002
               END IF 
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbb001
            #add-point:ON CHANGE nmbb001 name="input.g.page1.nmbb001"
            IF g_nmbb_d[l_ac].nmbb001 = '3' OR g_nmbb_d[l_ac].nmbb001 = '4' THEN
               CALL cl_set_comp_required('nmbb003',FALSE)
               #150807-00007#1 add ------
               #變更的話要刪除現金變動碼檔
               CALL s_cashflow_nm_del_glbc(g_nmba_m.nmbadocdt,g_glaald,g_nmba_m.nmbadocno,g_nmbb_d[l_ac].nmbbseq)
                    RETURNING g_sub_success,g_errno
               #150807-00007#1 add end---
            ELSE
               CALL cl_set_comp_required('nmbb003',TRUE)
            END IF
            CALL anmt310_nmbb001_entry()     #151222-00010#1
            CALL anmt310_get_exrate()   #取得匯率   #150930-00010#4            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb002
            
            #add-point:AFTER FIELD nmbb002 name="input.a.page1.nmbb002"
            IF NOT cl_null(g_nmbb_d[l_ac].nmbb002) THEN 
               CALL anmt310_nmbb002_chk() 
               IF NOT cl_null(g_errno) THEN 
                  IF l_cmd = 'a' THEN 
                     DISPLAY '' TO s_detail1[l_ac].nmbb002
                     DISPLAY '' TO s_detail1[l_ac].nmbb002_desc
                     DISPLAY '' TO s_detail1[l_ac].nmbb010
                     DISPLAY '' TO s_detail1[l_ac].nmbb010_desc
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_nmbb_d[l_ac].nmbb002
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_nmbb_d[l_ac].nmbb002 = ''
                     LET g_nmbb_d[l_ac].nmbb002_desc = ''
                     LET g_nmbb_d[l_ac].nmbb010 = ''
                     LET g_nmbb_d[l_ac].nmbb010_desc = ''
                  ELSE
                     DISPLAY '' TO s_detail1[l_ac].nmbb002
                     DISPLAY '' TO s_detail1[l_ac].nmbb002_desc
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_nmbb_d[l_ac].nmbb002
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_nmbb_d[l_ac].nmbb002 = g_nmbb_d_t.nmbb002 
                     LET g_nmbb_d[l_ac].nmbb002_desc = g_nmbb_d_t.nmbb002_desc
                  END IF 
                  DISPLAY g_nmbb_d[l_ac].nmbb002 TO s_detail1[l_ac].nmbb002
                  DISPLAY g_nmbb_d[l_ac].nmbb002_desc TO s_detail1[l_ac].nmbb002_desc
                  DISPLAY g_nmbb_d[l_ac].nmbb010 TO s_detail1[l_ac].nmbb010
                  DISPLAY g_nmbb_d[l_ac].nmbb010_desc TO s_detail1[l_ac].nmbb010_desc
                  NEXT FIELD nmbb002
               END IF 
            END IF 
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_nmbb_d[l_ac].nmbb002
            CALL ap_ref_array2(g_ref_fields,"SELECT nmajl003 FROM nmajl_t WHERE nmajlent='"||g_enterprise||"' AND nmajl001=? AND nmajl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_nmbb_d[l_ac].nmbb002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_nmbb_d[l_ac].nmbb002_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb002
            #add-point:BEFORE FIELD nmbb002 name="input.b.page1.nmbb002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbb002
            #add-point:ON CHANGE nmbb002 name="input.g.page1.nmbb002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb003
            
            #add-point:AFTER FIELD nmbb003 name="input.a.page1.nmbb003"
            IF NOT cl_null(g_nmbb_d[l_ac].nmbb003) THEN 
               CALL anmt310_nmbb003_chk()
                  
               IF NOT cl_null(g_errno) THEN 
                  IF l_cmd = 'a' THEN 
                     DISPLAY '' TO s_detail1[l_ac].nmbb003
                     DISPLAY '' TO s_detail1[l_ac].nmbb003_desc
                     DISPLAY '' TO s_detail1[l_ac].nmbb004
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_nmbb_d[l_ac].nmbb003
                     #160318-00005#27 by 07900 --add--str
                     LET g_errparam.replace[1] = 'anmi120'
                     LET g_errparam.replace[2] = cl_get_progname("anmi120",g_lang,"2")
                     LET g_errparam.exeprog ='anmi120'
                     #160318-00005#27 by 07900 --add--end
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_nmbb_d[l_ac].nmbb003 = ''
                     LET g_nmbb_d[l_ac].nmbb003_desc = ''
                     LET g_nmbb_d[l_ac].nmbb004 = ''
                  ELSE
                     DISPLAY '' TO s_detail1[l_ac].nmbb003
                     DISPLAY '' TO s_detail1[l_ac].nmbb003_desc
                     DISPLAY '' TO s_detail1[l_ac].nmbb004
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_nmbb_d[l_ac].nmbb003
                     #160318-00005#27 by 07900 --add--str
                     LET g_errparam.replace[1] = 'anmi120'
                     LET g_errparam.replace[2] = cl_get_progname("anmi120",g_lang,"2")
                     LET g_errparam.exeprog ='anmi120'
                     #160318-00005#27 by 07900 --add--end
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_nmbb_d[l_ac].nmbb003 = g_nmbb_d_t.nmbb003
                     LET g_nmbb_d[l_ac].nmbb003_desc = g_nmbb_d_t.nmbb003_desc
                     LET g_nmbb_d[l_ac].nmbb004 = g_nmbb_d_t.nmbb004
                  END IF 

                  DISPLAY g_nmbb_d[l_ac].nmbb003 TO s_detail1[l_ac].nmbb003
                  DISPLAY g_nmbb_d[l_ac].nmbb003_desc TO s_detail1[l_ac].nmbb003_desc
                  DISPLAY g_nmbb_d[l_ac].nmbb004 TO s_detail1[l_ac].nmbb004
                  NEXT FIELD nmbb003  
               END IF 
               #160122-00001#26 - add -str
               IF NOT s_anmi120_nmll002_chk(g_nmbb_d[l_ac].nmbb003,g_user) THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_nmbb_d[l_ac].nmbb003
                  LET g_errparam.code   = 'anm-00574' 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  
                  LET g_nmbb_d[l_ac].nmbb003 = g_nmbb_d_t.nmbb003
                  LET g_nmbb_d[l_ac].nmbb003_desc = g_nmbb_d_t.nmbb003_desc
                  LET g_nmbb_d[l_ac].nmbb004 = g_nmbb_d_t.nmbb004 
                  NEXT FIELD CURRENT
               END IF
               #160122-00001#26 -add -end
               CALL anmt310_get_exrate()   #取得匯率   #150930-00010#4   
               #160120-00029#1 add--str---
               IF g_nmbb_d[l_ac].nmbb001 = '1' OR g_nmbb_d[l_ac].nmbb001 = '2' THEN 
                  CALL anmt310_get_nmbb004()
               END IF
               #160120-00029#1 add--end---                
               #150930-00010#4 mark--s
               #SELECT ooab002 INTO l_ooab002 FROM ooab_t
               # WHERE ooabent = g_enterprise
               #   AND ooabsite= g_ooef001
               #  #AND ooab001 = 'S-BAS-0010'
               #   AND ooab001 = 'S-FIN-4004'   #150820-00017
               #
               #                         #匯率參照表;帳套;           日期;               來源幣別
               #CALL s_aooi160_get_exrate('2',g_glaald,g_nmba_m.nmbadocdt,g_nmbb_d[l_ac].nmbb004,
               #                         #目的幣別;  交易金額;              匯類類型
               #                          g_ooef016,0,l_ooab002)
               #   RETURNING g_nmbb_d[l_ac].nmbb005           
               #DISPLAY g_nmbb_d[l_ac].nmbb005 TO s_detail1[l_ac].nmbb005
               #150930-00010#4 mark--e
            END IF 
            CALL anmt310_ref_b()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb003
            #add-point:BEFORE FIELD nmbb003 name="input.b.page1.nmbb003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbb003
            #add-point:ON CHANGE nmbb003 name="input.g.page1.nmbb003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb004
            #add-point:BEFORE FIELD nmbb004 name="input.b.page1.nmbb004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb004
            
            #add-point:AFTER FIELD nmbb004 name="input.a.page1.nmbb004"
            IF NOT cl_null(g_nmbb_d[l_ac].nmbb004) THEN 
               CALL anmt310_nmbb004_chk()
               IF NOT cl_null(g_errno) THEN 
                  IF l_cmd = 'a' THEN 
                     DISPLAY '' TO s_detail1[l_ac].nmbb004
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_nmbb_d[l_ac].nmbb004
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_nmbb_d[l_ac].nmbb004 = ''
                  ELSE
                     DISPLAY '' TO s_detail1[l_ac].nmbb004
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_nmbb_d[l_ac].nmbb004
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_nmbb_d[l_ac].nmbb004 = g_nmbb_d_t.nmbb004
                  END IF 
                  DISPLAY g_nmbb_d[l_ac].nmbb004 TO s_detail1[l_ac].nmbb004
                  NEXT FIELD nmbb004
               END IF
               CALL anmt310_get_exrate()   #取得匯率   #150930-00010#4    
               #150930-00010#4 mark--s
               #SELECT ooab002 INTO l_ooab002 FROM ooab_t
               # WHERE ooabent = g_enterprise
               #   AND ooabsite= g_ooef001
               #   #AND ooab001 = 'S-BAS-0010'  
               #   AND ooab001 = 'S-FIN-4004'   #150820-00017
               #
               #
               #   
               #                         #匯率參照表;帳套;           日期;               來源幣別
               #CALL s_aooi160_get_exrate('2',g_glaald,g_nmba_m.nmbadocdt,g_nmbb_d[l_ac].nmbb004,
               #                         #目的幣別;  交易金額;              匯類類型
               #                          g_ooef016,0,l_ooab002)
               #   RETURNING g_nmbb_d[l_ac].nmbb005                    
               ##2015/02/02 add by qiull(S)
               #SELECT ooaj004,ooaj005 INTO l_ooaj004,l_ooaj005 FROM ooaj_t 
               # WHERE ooajent = g_enterprise
               #   AND ooaj001 = g_glaa026 
               #   AND ooaj002 = g_nmbb_d[l_ac].nmbb004
               ##LET g_nmbb_d[l_ac].nmbb005 = s_num_round('1',g_nmbb_d[l_ac].nmbb005,l_ooaj005)          #150707-00001#2 mark
               #CALL s_curr_round_ld('1',g_glaald,g_glaa001,g_nmbb_d[l_ac].nmbb005,3)                   #150707-00001#2
               #     RETURNING g_sub_success,g_errno,g_nmbb_d[l_ac].nmbb005                             #150707-00001#2               
               ##2015/02/02 add by qiull(E)                   
               #DISPLAY g_nmbb_d[l_ac].nmbb005 TO s_detail1[l_ac].nmbb005   
               #   
               #IF NOT cl_null(g_nmbb_d[l_ac].nmbb006) THEN 
               #  #LET g_nmbb_d[l_ac].nmbb006 = s_num_round('1',g_nmbb_d[l_ac].nmbb006,l_ooaj004)       #150707-00001#2 mark   #2015/02/02 add by qiull
               #   CALL s_curr_round_ld('1',g_glaald,g_nmbb_d[l_ac].nmbb004,g_nmbb_d[l_ac].nmbb006,2)   #150707-00001#2
               #        RETURNING g_sub_success,g_errno,g_nmbb_d[l_ac].nmbb006                          #150707-00001#2                  
               #   LET g_nmbb_d[l_ac].nmbb007 = g_nmbb_d[l_ac].nmbb006 * g_nmbb_d[l_ac].nmbb005
               #  #LET g_nmbb_d[l_ac].nmbb007 = s_num_round('1',g_nmbb_d[l_ac].nmbb007,l_ooaj004)       #150707-00001#2 mark   #2015/02/02 add by qiull
               #   CALL s_curr_round_ld('1',g_glaald,g_glaa001,g_nmbb_d[l_ac].nmbb007,2)                #150707-00001#2
               #        RETURNING g_sub_success,g_errno,g_nmbb_d[l_ac].nmbb007                          #150707-00001#2                   
               #   DISPLAY g_nmbb_d[l_ac].nmbb007 TO s_detail1[l_ac].nmbb007
               #END IF               
               #150930-00010#4 mark--e
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
            #2015/02/02 add by qiull(s)
            IF NOT cl_null(g_nmbb_d[l_ac].nmbb004) AND NOT cl_null(g_nmbb_d[l_ac].nmbb005) THEN
               SELECT ooaj004,ooaj005 INTO l_ooaj004,l_ooaj005 FROM ooaj_t 
                WHERE ooajent = g_enterprise
                  AND ooaj001 = g_glaa026 
                  AND ooaj002 = g_nmbb_d[l_ac].nmbb004
              #LET g_nmbb_d[l_ac].nmbb005 = s_num_round('1',g_nmbb_d[l_ac].nmbb005,l_ooaj005)      #150707-00001#2 mark
              #CALL s_curr_round_ld('1',g_glaald,g_glaa001,g_nmbb_d[l_ac].nmbb005,3)               #150930-00010#4 mark  #150707-00001#2
               CALL s_curr_round_ld('1',g_glaald,g_nmbb_d[l_ac].nmbb004,g_nmbb_d[l_ac].nmbb005,3)  #150930-00010#4
                    RETURNING g_sub_success,g_errno,g_nmbb_d[l_ac].nmbb005                         #150707-00001#2               
            END IF                                                                                  
            #2015/02/02 add by qiull(e)                                                             
            IF NOT cl_null(g_nmbb_d[l_ac].nmbb006) THEN                                             
              #LET g_nmbb_d[l_ac].nmbb006 = s_num_round('1',g_nmbb_d[l_ac].nmbb006,l_ooaj004)      #150707-00001#2 mark   #2015/02/02 add by qiull
               CALL s_curr_round_ld('1',g_glaald,g_nmbb_d[l_ac].nmbb004,g_nmbb_d[l_ac].nmbb006,2)  #150707-00001#2
                    RETURNING g_sub_success,g_errno,g_nmbb_d[l_ac].nmbb006                         #150707-00001#2               
               LET g_nmbb_d[l_ac].nmbb007 = g_nmbb_d[l_ac].nmbb006 * g_nmbb_d[l_ac].nmbb005         
              #LET g_nmbb_d[l_ac].nmbb007 = s_num_round('1',g_nmbb_d[l_ac].nmbb007,l_ooaj004)      #150707-00001#2 mark   #2015/02/02 add by qiull
               CALL s_curr_round_ld('1',g_glaald,g_glaa001,g_nmbb_d[l_ac].nmbb007,2)               #150707-00001#2
                    RETURNING g_sub_success,g_errno,g_nmbb_d[l_ac].nmbb007                         #150707-00001#2                
               DISPLAY g_nmbb_d[l_ac].nmbb007 TO s_detail1[l_ac].nmbb007
            END IF 
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
               #2015/02/02 add by qiull(s)
               IF NOT cl_null(g_nmbb_d[l_ac].nmbb004) THEN
                  SELECT ooaj004 INTO l_ooaj004 FROM ooaj_t 
                   WHERE ooajent = g_enterprise
                     AND ooaj001 = g_glaa026 
                     AND ooaj002 = g_nmbb_d[l_ac].nmbb004
                 #LET g_nmbb_d[l_ac].nmbb006 = s_num_round('1',g_nmbb_d[l_ac].nmbb006,l_ooaj004)     #150707-00001#2 mark
                  CALL s_curr_round_ld('1',g_glaald,g_nmbb_d[l_ac].nmbb004,g_nmbb_d[l_ac].nmbb006,2) #150707-00001#2
                       RETURNING g_sub_success,g_errno,g_nmbb_d[l_ac].nmbb006                        #150707-00001#2                  
               END IF 
               #2015/02/02 add by qiull(e)
               LET g_nmbb_d[l_ac].nmbb007 = g_nmbb_d[l_ac].nmbb006 * g_nmbb_d[l_ac].nmbb005
              #LET g_nmbb_d[l_ac].nmbb007 = s_num_round('1',g_nmbb_d[l_ac].nmbb007,l_ooaj004)        #150707-00001#2 mark   #2015/02/02 add by qiull
               CALL s_curr_round_ld('1',g_glaald,g_glaa001,g_nmbb_d[l_ac].nmbb007,2)                 #150707-00001#2
                    RETURNING g_sub_success,g_errno,g_nmbb_d[l_ac].nmbb007                           #150707-00001#2                
               DISPLAY g_nmbb_d[l_ac].nmbb007 TO s_detail1[l_ac].nmbb007
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
            IF NOT cl_null(g_nmbb_d[l_ac].nmbb007) THEN 
               SELECT ooaj004 INTO l_ooaj004 FROM ooaj_t 
                WHERE ooajent = g_enterprise
                  AND ooaj001 = g_glaa026 
                  AND ooaj002 = g_nmbb_d[l_ac].nmbb004
              #LET g_nmbb_d[l_ac].nmbb007 = s_num_round('1',g_nmbb_d[l_ac].nmbb007,l_ooaj004)       #150707-00001#2 mark
               CALL s_curr_round_ld('1',g_glaald,g_glaa001,g_nmbb_d[l_ac].nmbb007,2)                #150707-00001#2
                    RETURNING g_sub_success,g_errno,g_nmbb_d[l_ac].nmbb007                          #150707-00001#2                
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb007
            #add-point:BEFORE FIELD nmbb007 name="input.b.page1.nmbb007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbb007
            #add-point:ON CHANGE nmbb007 name="input.g.page1.nmbb007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb010
            
            #add-point:AFTER FIELD nmbb010 name="input.a.page1.nmbb010"
            IF NOT cl_null(g_nmbb_d[l_ac].nmbb010) THEN 
               CALL anmt310_nmbb010_chk()
               IF NOT cl_null(g_errno) THEN 
                  IF l_cmd = 'a' THEN 
                     DISPLAY '' TO s_detail1[l_ac].nmbb010
                     DISPLAY '' TO s_detail1[l_ac].nmbb010_desc
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_nmbb_d[l_ac].nmbb010
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_nmbb_d[l_ac].nmbb010 = ''
                     LET g_nmbb_d[l_ac].nmbb010_desc = ''
                  ELSE
                     DISPLAY '' TO s_detail1[l_ac].nmbb010
                     DISPLAY '' TO s_detail1[l_ac].nmbb010_desc
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_nmbb_d[l_ac].nmbb010
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_nmbb_d[l_ac].nmbb010 = g_nmbb_d_t.nmbb010
                     LET g_nmbb_d[l_ac].nmbb010_desc = g_nmbb_d_t.nmbb010_desc
                  END IF 
                  DISPLAY g_nmbb_d[l_ac].nmbb010 TO s_detail1[l_ac].nmbb010
                  DISPLAY g_nmbb_d[l_ac].nmbb010_desc TO s_detail1[l_ac].nmbb010_desc
                  NEXT FIELD nmbb010
               END IF 
            END IF 
            
            CALL anmt310_ref_b()
            #INITIALIZE g_ref_fields TO NULL
            #LET g_ref_fields[1] = g_nmbb_d[l_ac].nmbb010
            #LET g_ref_fields[2] = l_glaa005
            #CALL ap_ref_array2(g_ref_fields,"SELECT nmail004 FROM nmail_t WHERE nmailent='"||g_enterprise||"' AND nmail002=? AND nmail001 = ? AND nmail003='"||g_dlang||"'","") RETURNING g_rtn_fields
            #LET g_nmbb_d[l_ac].nmbb010_desc = '', g_rtn_fields[1] , ''
            #DISPLAY BY NAME g_nmbb_d[l_ac].nmbb010_desc

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
         BEFORE FIELD nmbb010_desc
            #add-point:BEFORE FIELD nmbb010_desc name="input.b.page1.nmbb010_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb010_desc
            
            #add-point:AFTER FIELD nmbb010_desc name="input.a.page1.nmbb010_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbb010_desc
            #add-point:ON CHANGE nmbb010_desc name="input.g.page1.nmbb010_desc"
            
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
         BEFORE FIELD nmbb008
            #add-point:BEFORE FIELD nmbb008 name="input.b.page1.nmbb008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb008
            
            #add-point:AFTER FIELD nmbb008 name="input.a.page1.nmbb008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbb008
            #add-point:ON CHANGE nmbb008 name="input.g.page1.nmbb008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb009
            #add-point:BEFORE FIELD nmbb009 name="input.b.page1.nmbb009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb009
            
            #add-point:AFTER FIELD nmbb009 name="input.a.page1.nmbb009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbb009
            #add-point:ON CHANGE nmbb009 name="input.g.page1.nmbb009"
            
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
         BEFORE FIELD nmbb026
            #add-point:BEFORE FIELD nmbb026 name="input.b.page1.nmbb026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb026
            
            #add-point:AFTER FIELD nmbb026 name="input.a.page1.nmbb026"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbb026
            #add-point:ON CHANGE nmbb026 name="input.g.page1.nmbb026"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb027
            #add-point:BEFORE FIELD nmbb027 name="input.b.page1.nmbb027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb027
            
            #add-point:AFTER FIELD nmbb027 name="input.a.page1.nmbb027"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbb027
            #add-point:ON CHANGE nmbb027 name="input.g.page1.nmbb027"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb057
            #add-point:BEFORE FIELD nmbb057 name="input.b.page1.nmbb057"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb057
            
            #add-point:AFTER FIELD nmbb057 name="input.a.page1.nmbb057"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbb057
            #add-point:ON CHANGE nmbb057 name="input.g.page1.nmbb057"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb058
            #add-point:BEFORE FIELD nmbb058 name="input.b.page1.nmbb058"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb058
            
            #add-point:AFTER FIELD nmbb058 name="input.a.page1.nmbb058"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbb058
            #add-point:ON CHANGE nmbb058 name="input.g.page1.nmbb058"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb059
            #add-point:BEFORE FIELD nmbb059 name="input.b.page1.nmbb059"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb059
            
            #add-point:AFTER FIELD nmbb059 name="input.a.page1.nmbb059"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbb059
            #add-point:ON CHANGE nmbb059 name="input.g.page1.nmbb059"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb060
            #add-point:BEFORE FIELD nmbb060 name="input.b.page1.nmbb060"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb060
            
            #add-point:AFTER FIELD nmbb060 name="input.a.page1.nmbb060"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbb060
            #add-point:ON CHANGE nmbb060 name="input.g.page1.nmbb060"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbb062
            #add-point:BEFORE FIELD nmbb062 name="input.b.page1.nmbb062"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbb062
            
            #add-point:AFTER FIELD nmbb062 name="input.a.page1.nmbb062"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbb062
            #add-point:ON CHANGE nmbb062 name="input.g.page1.nmbb062"
            
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
 
 
 
                  #Ctrlp:input.c.page1.nmbbseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbbseq
            #add-point:ON ACTION controlp INFIELD nmbbseq name="input.c.page1.nmbbseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbborga
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbborga
            #add-point:ON ACTION controlp INFIELD nmbborga name="input.c.page1.nmbborga"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_nmbb_d[l_ac].nmbborga
            #150714-00024#1 mark ------
            #CALL s_fin_account_center_sons_query('6',g_nmba_m.nmbasite,g_today,'')
            #CALL s_fin_account_center_sons_str()RETURNING l_origin_str
            #CALL anmt310_change_to_sql(l_origin_str)RETURNING l_origin_str
            #LET g_qryparam.where = " ooef001 IN (",l_origin_str CLIPPED,") AND ooef017 ='",g_nmba_m.nmbacomp,"' "
            #150714-00024#1 mark end---
            #160912-00024#1 mod s---
            #LET g_qryparam.where = " ooef001 IN ",g_site_wc   #150714-00024#1                                   
            CALL s_fin_get_wc_str(g_site_wc) RETURNING l_origin_str
            LET g_qryparam.where = " ooef017 ='",g_nmba_m.nmbacomp,"' AND ooef001 IN ",l_origin_str CLIPPED  
            #160912-00024#1 mod e---
            LET g_qryparam.where = g_qryparam.where," AND ooef201 = 'Y'"  #161021-00050#8
            CALL q_ooef001()
            LET g_nmbb_d[l_ac].nmbborga = g_qryparam.return1
            CALL anmt310_ref_b()
            DISPLAY g_nmbb_d[l_ac].nmbborga TO nmbborga
            LET g_qryparam.where = ''
            NEXT FIELD nmbborga
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbb071
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb071
            #add-point:ON ACTION controlp INFIELD nmbb071 name="input.c.page1.nmbb071"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            #160518-00024#14 add s---
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_nmbb_d[l_ac].nmbb071             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

 
            CALL q_apagdocno()                                #呼叫開窗
 
            LET g_nmbb_d[l_ac].nmbb071 = g_qryparam.return1              

            DISPLAY g_nmbb_d[l_ac].nmbb071 TO nmbb071              #

            NEXT FIELD nmbb071                          #返回原欄位
            #160518-00024#14 add e---


            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbb072
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb072
            #add-point:ON ACTION controlp INFIELD nmbb072 name="input.c.page1.nmbb072"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbb053
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb053
            #add-point:ON ACTION controlp INFIELD nmbb053 name="input.c.page1.nmbb053"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_nmbb_d[l_ac].nmbb053             #給予default值
            LET g_qryparam.default2 = "" #g_nmbb_d[l_ac].oofa011 #全名

            #給予arg

            CALL q_ooag001_6()                                #呼叫開窗

            LET g_nmbb_d[l_ac].nmbb053 = g_qryparam.return1              #將開窗取得的值回傳到變數
            #LET g_nmbb_d[l_ac].oofa011 = g_qryparam.return2 #全名

            DISPLAY g_nmbb_d[l_ac].nmbb053 TO nmbb053              #顯示到畫面上
            #DISPLAY g_nmbb_d[l_ac].oofa011 TO oofa011 #全名

            NEXT FIELD nmbb053                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbb053_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb053_desc
            #add-point:ON ACTION controlp INFIELD nmbb053_desc name="input.c.page1.nmbb053_desc"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_nmbb_d[l_ac].nmbb053_desc             #給予default值
            LET g_qryparam.default2 = "" #g_nmbb_d[l_ac].oofa011 #全名

            #給予arg

            CALL q_ooag001_2()                                #呼叫開窗

            LET g_nmbb_d[l_ac].nmbb053 = g_qryparam.return1              #將開窗取得的值回傳到變數
            #LET g_nmbb_d[l_ac].oofa011 = g_qryparam.return2 #全名
            CALL anmt310_ref_b()
            DISPLAY g_nmbb_d[l_ac].nmbb053_desc TO nmbb053_desc              #顯示到畫面上
            #DISPLAY g_nmbb_d[l_ac].oofa011 TO oofa011 #全名

            NEXT FIELD nmbb053_desc                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbb054
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb054
            #add-point:ON ACTION controlp INFIELD nmbb054 name="input.c.page1.nmbb054"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_nmbb_d[l_ac].nmbb054
            #CALL q_ooef001()                          #150714-00024#1 mark
            LET g_qryparam.arg1 = g_nmba_m.nmbadocdt   #150714-00024#1
		      CALL q_ooeg001_4()                         #150714-00024#1
            LET g_nmbb_d[l_ac].nmbb054 = g_qryparam.return1
            DISPLAY g_nmbb_d[l_ac].nmbb054 TO nmbb054
            NEXT FIELD nmbb054
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbb054_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb054_desc
            #add-point:ON ACTION controlp INFIELD nmbb054_desc name="input.c.page1.nmbb054_desc"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_nmbb_d[l_ac].nmbb054_desc
            #CALL q_ooef001()                          #150714-00024#1 mark
            LET g_qryparam.arg1 = g_nmba_m.nmbadocdt   #150714-00024#1
		      CALL q_ooeg001_4()                         #150714-00024#1
            LET g_nmbb_d[l_ac].nmbb054 = g_qryparam.return1
            CALL anmt310_ref_b()
            DISPLAY g_nmbb_d[l_ac].nmbb054_desc TO nmbb054_desc
            NEXT FIELD nmbb054_desc
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbb070
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb070
            #add-point:ON ACTION controlp INFIELD nmbb070 name="input.c.page1.nmbb070"
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_nmbb_d[l_ac].nmbb070
            LET g_qryparam.where = " ooef201 = 'Y'"  #161021-00050#8
            CALL q_ooef001()
            LET g_nmbb_d[l_ac].nmbb070 = g_qryparam.return1
            DISPLAY g_nmbb_d[l_ac].nmbb070 TO nmbb070
            NEXT FIELD nmbb070
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbb001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb001
            #add-point:ON ACTION controlp INFIELD nmbb001 name="input.c.page1.nmbb001"
            
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

            LET g_qryparam.default1 = g_nmbb_d[l_ac].nmbb002             #給予default值
            IF g_nmbb_d[l_ac].nmbb001 = '1' OR g_nmbb_d[l_ac].nmbb001 = '2' THEN
               LET g_qryparam.where = " nmaj002 = '",g_nmbb_d[l_ac].nmbb001,"'"
            END IF 
            #給予arg

            CALL q_nmaj001()                                #呼叫開窗

            LET g_nmbb_d[l_ac].nmbb002 = g_qryparam.return1              #將開窗取得的值回傳到變數
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_nmbb_d[l_ac].nmbb002
            CALL ap_ref_array2(g_ref_fields,"SELECT nmajl003 FROM nmajl_t WHERE nmajlent='"||g_enterprise||"' AND nmajl001=? AND nmajl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_nmbb_d[l_ac].nmbb002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_nmbb_d[l_ac].nmbb002_desc
            
            SELECT glaa005 INTO l_glaa005
              FROM glaa_t
             WHERE glaaent = g_enterprise
               AND glaacomp = g_nmba_m.nmbacomp
               AND glaa014 = 'Y'
               
            SELECT nmad003 INTO g_nmbb_d[l_ac].nmbb010
              FROM nmad_t
             WHERE nmadent = g_enterprise
               AND nmad001 = l_glaa005
               AND nmad002 = g_nmbb_d[l_ac].nmbb002
            DISPLAY g_nmbb_d[l_ac].nmbb010 TO nmbb010
            
            CALL anmt310_ref_b()
            #INITIALIZE g_ref_fields TO NULL
            #LET g_ref_fields[1] = g_nmbb_d[l_ac].nmbb010
            #LET g_ref_fields[2] = l_glaa005
            #CALL ap_ref_array2(g_ref_fields,"SELECT nmail004 FROM nmail_t WHERE nmailent='"||g_enterprise||"' AND nmail002=? AND nmail001 = ? AND nmail003='"||g_dlang||"'","") RETURNING g_rtn_fields
            #LET g_nmbb_d[l_ac].nmbb010_desc = '', g_rtn_fields[1] , ''
            #DISPLAY BY NAME g_nmbb_d[l_ac].nmbb010_desc
            
            DISPLAY g_nmbb_d[l_ac].nmbb002 TO nmbb002              #顯示到畫面上
            
            LET g_qryparam.where = ''
            NEXT FIELD nmbb002                          #返回原欄位


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
            #LET g_qryparam.default2 = "" #g_nmbb_d[l_ac].nmas003 #交易幣別   #160120-00029#1 mark
            LET g_qryparam.default2 = g_nmbb_d[l_ac].nmbb004                 #160120-00029#1 add
            #160122-00001#26 - add -str 
            #LET g_qryparam.where = " nmaa002 IN (select ooef001 FROM ooef_t WHERE ooefent = '",g_enterprise,"'",
            #                      "              AND ooef017 = '",g_nmba_m.nmbacomp,"')"
            LET g_qryparam.where = " nmas002 IN (",g_sql_bank,")",
                                   " AND  nmaa002 IN (select ooef001 FROM ooef_t WHERE ooefent = '",g_enterprise,"'",
                                   "              AND ooef017 = '",g_nmba_m.nmbacomp,"')"
            #160122-00001#26 -add end
            #給予arg
            #160120-00029#1 add--str--
            IF g_nmbb_d[l_ac].nmbb001 = '1' OR g_nmbb_d[l_ac].nmbb001 = '2' THEN 
               CALL q_nmas001_2()
               
               LET g_nmbb_d[l_ac].nmbb003 = g_qryparam.return1 
               LET g_nmbb_d[l_ac].nmbb004 = g_qryparam.return2 
               CALL anmt310_ref_b()
               DISPLAY g_nmbb_d[l_ac].nmbb003 TO nmbb003
               DISPLAY g_nmbb_d[l_ac].nmbb004 TO nmbb004
            ELSE
            #160120-00029#1 add--end---
               CALL q_nmas_01()                                #呼叫開窗
               
               LET g_nmbb_d[l_ac].nmbb003 = g_qryparam.return1              #將開窗取得的值回傳到變數
               #LET g_nmbb_d[l_ac].nmas003 = g_qryparam.return2 #交易幣別
               CALL anmt310_ref_b()
               DISPLAY g_nmbb_d[l_ac].nmbb003 TO nmbb003              #顯示到畫面上
               #DISPLAY g_nmbb_d[l_ac].nmas003 TO nmas003 #交易幣別
            END IF  #160120-00029#1 add
            LET g_qryparam.where = ' '
            NEXT FIELD nmbb003                          #返回原欄位


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
 
 
         #Ctrlp:input.c.page1.nmbb010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb010
            #add-point:ON ACTION controlp INFIELD nmbb010 name="input.c.page1.nmbb010"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_nmbb_d[l_ac].nmbb010             #給予default值
            #帶值
            SELECT glaa005 INTO l_glaa005
              FROM glaa_t
             WHERE glaaent = g_enterprise
               AND glaacomp = g_nmba_m.nmbacomp
               AND glaa014 = 'Y'
            LET g_qryparam.where = " nmai001 = '",l_glaa005,"'"
            #給予arg

            CALL q_nmai002()                                #呼叫開窗

            LET g_nmbb_d[l_ac].nmbb010 = g_qryparam.return1              #將開窗取得的值回傳到變數

            CALL anmt310_ref_b()
            #INITIALIZE g_ref_fields TO NULL
            #LET g_ref_fields[1] = g_nmbb_d[l_ac].nmbb010
            #LET g_ref_fields[2] = l_glaa005
            #CALL ap_ref_array2(g_ref_fields,"SELECT nmail004 FROM nmail_t WHERE nmailent='"||g_enterprise||"' AND nmail002=? AND nmail001 = ?  AND nmail003='"||g_dlang||"'","") RETURNING g_rtn_fields
            #LET g_nmbb_d[l_ac].nmbb010_desc = '', g_rtn_fields[1] , ''
            #DISPLAY BY NAME g_nmbb_d[l_ac].nmbb010_desc
            
            DISPLAY g_nmbb_d[l_ac].nmbb010 TO nmbb010              #顯示到畫面上
            LET g_qryparam.where = ''
            NEXT FIELD nmbb010                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbb010_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb010_desc
            #add-point:ON ACTION controlp INFIELD nmbb010_desc name="input.c.page1.nmbb010_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbb025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb025
            #add-point:ON ACTION controlp INFIELD nmbb025 name="input.c.page1.nmbb025"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbb011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb011
            #add-point:ON ACTION controlp INFIELD nmbb011 name="input.c.page1.nmbb011"
            
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
 
 
         #Ctrlp:input.c.page1.nmbb008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb008
            #add-point:ON ACTION controlp INFIELD nmbb008 name="input.c.page1.nmbb008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbb009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb009
            #add-point:ON ACTION controlp INFIELD nmbb009 name="input.c.page1.nmbb009"
            
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
 
 
         #Ctrlp:input.c.page1.nmbb026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb026
            #add-point:ON ACTION controlp INFIELD nmbb026 name="input.c.page1.nmbb026"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbb027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb027
            #add-point:ON ACTION controlp INFIELD nmbb027 name="input.c.page1.nmbb027"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbb057
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb057
            #add-point:ON ACTION controlp INFIELD nmbb057 name="input.c.page1.nmbb057"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbb058
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb058
            #add-point:ON ACTION controlp INFIELD nmbb058 name="input.c.page1.nmbb058"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbb059
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb059
            #add-point:ON ACTION controlp INFIELD nmbb059 name="input.c.page1.nmbb059"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbb060
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb060
            #add-point:ON ACTION controlp INFIELD nmbb060 name="input.c.page1.nmbb060"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbb062
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbb062
            #add-point:ON ACTION controlp INFIELD nmbb062 name="input.c.page1.nmbb062"
            
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
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_nmbb_d[l_ac].* = g_nmbb_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE anmt310_bcl
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
               CALL anmt310_ref_amt()
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL anmt310_nmbb_t_mask_restore('restore_mask_o')
      
               UPDATE nmbb_t SET (nmbbcomp,nmbbdocno,nmbbseq,nmbborga,nmbb071,nmbb072,nmbb053,nmbb054, 
                   nmbb070,nmbblegl,nmbb001,nmbb002,nmbb003,nmbb029,nmbb004,nmbb005,nmbb006,nmbb007, 
                   nmbb010,nmbb025,nmbb011,nmbb012,nmbb013,nmbb014,nmbb015,nmbb016,nmbb017,nmbb018,nmbb008, 
                   nmbb009,nmbb019,nmbb020,nmbb021,nmbb022,nmbb023,nmbb024,nmbb026,nmbb027,nmbb056,nmbb057, 
                   nmbb058,nmbb059,nmbb060,nmbb061,nmbb062,nmbb066,nmbb067,nmbb068) = (g_nmba_m.nmbacomp, 
                   g_nmba_m.nmbadocno,g_nmbb_d[l_ac].nmbbseq,g_nmbb_d[l_ac].nmbborga,g_nmbb_d[l_ac].nmbb071, 
                   g_nmbb_d[l_ac].nmbb072,g_nmbb_d[l_ac].nmbb053,g_nmbb_d[l_ac].nmbb054,g_nmbb_d[l_ac].nmbb070, 
                   g_nmbb_d[l_ac].nmbblegl,g_nmbb_d[l_ac].nmbb001,g_nmbb_d[l_ac].nmbb002,g_nmbb_d[l_ac].nmbb003, 
                   g_nmbb_d[l_ac].nmbb029,g_nmbb_d[l_ac].nmbb004,g_nmbb_d[l_ac].nmbb005,g_nmbb_d[l_ac].nmbb006, 
                   g_nmbb_d[l_ac].nmbb007,g_nmbb_d[l_ac].nmbb010,g_nmbb_d[l_ac].nmbb025,g_nmbb_d[l_ac].nmbb011, 
                   g_nmbb_d[l_ac].nmbb012,g_nmbb_d[l_ac].nmbb013,g_nmbb_d[l_ac].nmbb014,g_nmbb_d[l_ac].nmbb015, 
                   g_nmbb_d[l_ac].nmbb016,g_nmbb_d[l_ac].nmbb017,g_nmbb_d[l_ac].nmbb018,g_nmbb_d[l_ac].nmbb008, 
                   g_nmbb_d[l_ac].nmbb009,g_nmbb_d[l_ac].nmbb019,g_nmbb_d[l_ac].nmbb020,g_nmbb_d[l_ac].nmbb021, 
                   g_nmbb_d[l_ac].nmbb022,g_nmbb_d[l_ac].nmbb023,g_nmbb_d[l_ac].nmbb024,g_nmbb_d[l_ac].nmbb026, 
                   g_nmbb_d[l_ac].nmbb027,g_nmbb_d[l_ac].nmbb056,g_nmbb_d[l_ac].nmbb057,g_nmbb_d[l_ac].nmbb058, 
                   g_nmbb_d[l_ac].nmbb059,g_nmbb_d[l_ac].nmbb060,g_nmbb_d[l_ac].nmbb061,g_nmbb_d[l_ac].nmbb062, 
                   g_nmbb_d[l_ac].nmbb066,g_nmbb_d[l_ac].nmbb067,g_nmbb_d[l_ac].nmbb068)
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
               CALL anmt310_update_b('nmbb_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL anmt310_nmbb_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_nmbb_d[g_detail_idx].nmbbseq = g_nmbb_d_t.nmbbseq 
 
                  ) THEN
                  LET gs_keys[01] = g_nmba_m.nmbacomp
                  LET gs_keys[gs_keys.getLength()+1] = g_nmba_m.nmbadocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_nmbb_d_t.nmbbseq
 
                  CALL anmt310_key_update_b(gs_keys,'nmbb_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_nmba_m),util.JSON.stringify(g_nmbb_d_t)
               LET g_log2 = util.JSON.stringify(g_nmba_m),util.JSON.stringify(g_nmbb_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               #150807-00007#1 add ------
               #如果異動別從3&4改成1或2時，要新增一筆
               IF g_nmbb_d[l_ac].nmbb001 = '1' OR g_nmbb_d[l_ac].nmbb001 = '2' THEN
                  LET l_year = YEAR(g_nmba_m.nmbadocdt)
                  LET l_month = MONTH(g_nmba_m.nmbadocdt)
                  #170112-00020#1 add s---
                  LET l_year_o = YEAR(g_nmba_m_t.nmbadocdt)
                  LET l_month_o = MONTH(g_nmba_m_t.nmbadocdt)
                  IF g_nmba_m.nmbadocdt != g_nmba_m_t.nmbadocdt AND (l_year <> l_year_o OR l_month <> l_month_o) THEN 
                     SELECT COUNT(*) INTO l_n
                       FROM glbc_t
                      WHERE glbcent = g_enterprise
                        AND glbcld  = g_glaald
                        AND glbcdocno = g_nmba_m.nmbadocno
                        AND glbcseq = g_nmbb_d[l_ac].nmbbseq
                  ELSE    
                  #170112-00020#1 add e---                  
                     SELECT COUNT(*) INTO l_n
                       FROM glbc_t
                      WHERE glbcent = g_enterprise
                        AND glbcld  = g_glaald
                        AND glbcdocno = g_nmba_m.nmbadocno
                        AND glbcseq = g_nmbb_d[l_ac].nmbbseq
                        AND glbc001 = l_year
                        AND glbc002 = l_month 
                  END IF  #170112-00020#1 add                        
                  IF cl_null(l_n) THEN LET l_n = 0 END IF
                  IF l_n = 0 THEN
                     CALL anmt310_glbc_ins()
                  END IF
                  
                  #150807-00007#1 add ------
                  IF g_nmbb_d[l_ac].nmbb002 <> g_nmbb_d_t.nmbb002 OR g_nmbb_d[l_ac].nmbb006 <> g_nmbb_d_t.nmbb006 THEN
                     #170112-00020#1 add s---
                     IF g_nmba_m.nmbadocdt != g_nmba_m_t.nmbadocdt AND (l_year <> l_year_o OR l_month <> l_month_o) THEN 
                        #修改存提碼及金額時要重產glbc
                        CALL s_cashflow_nm_del_glbc(g_nmba_m_t.nmbadocdt,g_glaald,g_nmba_m.nmbadocno,g_nmbb_d[l_ac].nmbbseq)
                             RETURNING g_sub_success,g_errno
                     ELSE
                     #170112-00020#1 add e---
                        CALL s_cashflow_nm_del_glbc(g_nmba_m.nmbadocdt,g_glaald,g_nmba_m.nmbadocno,g_nmbb_d[l_ac].nmbbseq)
                             RETURNING g_sub_success,g_errno
                     END IF  #170112-00020#1 add                             
                     CALL anmt310_glbc_ins()
                  END IF
               END IF
               #150807-00007#1 add end---
               CALL anmt310_b_fill_2()
               CALL anmt310_b_fill_3()
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            #151222-00010#1---add---str
            IF g_nmbb_d[l_ac].nmbb001 = '1' OR g_nmbb_d[l_ac].nmbb001 = '2' THEN
               LET l_n = 0
               SELECT COUNT(*) INTO l_n FROM glbc_t 
                WHERE glbcent = g_enterprise AND glbcdocno = g_nmba_m.nmbadocno
                  AND glbcseq = g_nmbb_d[l_ac].nmbbseq
               IF l_n = 0 THEN
                  CALL anmt310_glbc_ins()
               END IF
            END IF
            #151222-00010#1---add---end
            #end add-point
            CALL anmt310_unlock_b("nmbb_t","'1'")
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            #add-point:單身after_row2 name="input.body.after_row2"
            
            #end add-point
              
         AFTER INPUT
            #add-point:input段after input  name="input.body.after_input"
            CALL anmt310_sum_page_show()    #151016-00018#1 借貸項合計信息
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
      
 
      
 
 
 
 
{</section>}
 
{<section id="anmt310.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
         IF p_cmd = 'a' THEN
            NEXT FIELD nmbasite
         END IF
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1',"))      
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
 
            #end add-point  
            NEXT FIELD nmbacomp
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD nmbbseq
 
               #add-point:input段modify_detail  name="input.modify_detail.other"
               
               #end add-point  
            END CASE
         END IF
      
      AFTER DIALOG
         #add-point:input段after_dialog name="input.after_dialog"
         CALL anmt310_sum_page_show()    #151016-00018#1 借貸項合計信息
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
 
{<section id="anmt310.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION anmt310_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   DEFINE l_pmaa004          LIKE pmaa_t.pmaa004
   DEFINE l_msg              LIKE type_t.chr200
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   #160518-00024#14 add s---
   IF g_nmba_m.nmba003 = 'aapt352' THEN 
      CALL cl_set_comp_visible('nmbb071,nmbb072',TRUE)
   ELSE
      CALL cl_set_comp_visible('nmbb071,nmbb072',FALSE)
   END IF
   #160518-00024#14 add e---   
   #161130-00055#1-S
   #IF g_nmba_m.nmbastus <> 'N' THEN
   #   CALL cl_set_act_visible("modify,modify_detail,delete", FALSE)   
   #ELSE
   #   CALL cl_set_act_visible("modify,modify_detail,delete", TRUE) 
   #END IF
   #161130-00055#1-E
   
 
   
   LET g_nmba_m.nmba002_desc = ''
   SELECT oofa011 INTO g_nmba_m.nmba002_desc
     FROM oofa_t
    WHERE oofaent = g_enterprise
      AND oofa001 IN (SELECT ooag002 FROM ooag_t
                        WHERE ooagent = g_enterprise
                          AND ooag001 = g_nmba_m.nmba002)
   DISPLAY g_nmba_m.nmba002_desc TO nmba002_desc
   
   SELECT pmaa004 INTO l_pmaa004
     FROM pmaa_t
    WHERE pmaaent = g_enterprise
      AND pmaa001 = g_nmba_m.nmba004
      
   IF l_pmaa004 <> '2' AND l_pmaa004 <> '4' THEN 
      LET g_nmba_m.nmba005 = ''
   END IF
   
   IF cl_null(g_nmba_m.nmba005) THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_nmba_m.nmba004
      CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_nmba_m.nmba004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_nmba_m.nmba004_desc
   ELSE
      SELECT pmak003 INTO g_nmba_m.nmba004_desc
        FROM pmak_t
       WHERE pmakent = g_enterprise
         AND pmak001 = g_nmba_m.nmba005
      DISPLAY BY NAME g_nmba_m.nmba004_desc
   END IF 
#160326-00001#26 mark s---   
#   IF g_nmba_m.nmba003 = 'anmt310' THEN
#      #CALL cl_getmsg('anm-00038',g_lang) RETURNING l_msg  #160326-00001#26 
#      LET g_nmba_m.nmba003_desc = '1'                      #160326-00001#26 
#   END IF 
#   IF g_nmba_m.nmba003 = 'anmt440' THEN
#      #CALL cl_getmsg('anm-00330',g_lang) RETURNING l_msg  #160326-00001#26 
#      LET g_nmba_m.nmba003_desc = '4'                      #160326-00001#26
#   END IF 
#  #150417-00007#51 Add  ---(S)---
#   IF g_nmba_m.nmba003 = 'adet402' THEN
#      #CALL cl_getmsg('anm-00354',g_lang) RETURNING l_msg  #160326-00001#26
#      LET g_nmba_m.nmba003_desc = '2'                      #160326-00001#26  
#   END IF 
#  #150417-00007#51 Add  ---(E)---
#   #160326-00001#26 add s---
#   IF g_nmba_m.nmba003 = 'anmp802' THEN
#      LET g_nmba_m.nmba003_desc = '3'                       
#   END IF 
#   #160326-00001#26 add e---   
#   #LET g_nmba_m.nmba003_desc = l_msg #160326-00001#26
#160326-00001#26 mark e---

   SELECT ooef001,ooef016 INTO g_ooef001,g_ooef016
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_nmba_m.nmbacomp
      
   
   CALL anmt310_glaa_get()
   
   LET g_nmba_m.l_nmbs003 = "" #150803-00018#1
   #150707-00001#2--(s)
   SELECT DISTINCT nmbs003 INTO g_nmba_m.l_nmbs003
     FROM nmbs_t
    WHERE nmbsent  = g_enterprise      
      AND nmbsdocno= g_nmba_m.nmba007
      AND nmbsstus <> 'X'
   DISPLAY BY NAME g_nmba_m.l_nmbs003      
   #150707-00001#2--(e)
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL anmt310_b_fill() #單身填充
      CALL anmt310_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL anmt310_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
 
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   IF g_bfill = 'Y' THEN 
      CALL anmt310_b_fill_2()
      CALL anmt310_b_fill_3()
   END IF 
 

   CALL anmt310_sum_page_show()    #151016-00018#1 借貸項合計信息
   #end add-point
   
   #遮罩相關處理
   LET g_nmba_m_mask_o.* =  g_nmba_m.*
   CALL anmt310_nmba_t_mask()
   LET g_nmba_m_mask_n.* =  g_nmba_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_nmba_m.nmbasite,g_nmba_m.nmbasite_desc,g_nmba_m.nmba002,g_nmba_m.nmba002_desc,g_nmba_m.nmbacomp, 
       g_nmba_m.nmbacomp_desc,g_nmba_m.nmbadocno,g_nmba_m.nmbadocdt,g_nmba_m.nmba003,g_nmba_m.nmba003_desc, 
       g_nmba_m.nmba015,g_nmba_m.nmba004,g_nmba_m.nmba004_desc,g_nmba_m.nmba005,g_nmba_m.nmba006,g_nmba_m.nmba007, 
       g_nmba_m.l_nmbs003,g_nmba_m.nmbastus,g_nmba_m.nmbaownid,g_nmba_m.nmbaownid_desc,g_nmba_m.nmbaowndp, 
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
   
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL anmt310_detail_show()
 
   #add-point:show段之後 name="show.after"
   CALL s_anm_get_comp_wc('6',g_nmba_m.nmbasite,g_nmba_m.nmbadocdt) RETURNING g_comp_wc   #150714-00024#1
   #CALL s_anm_get_site_wc('6',g_nmba_m.nmbacomp,g_nmba_m.nmbadocdt) RETURNING g_site_wc   #150714-00024#1 #160912-00024#1 mod
   CALL s_anm_get_site_wc('6',g_nmba_m.nmbasite,g_nmba_m.nmbadocdt) RETURNING g_site_wc    #160912-00024#1 add
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="anmt310.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION anmt310_detail_show()
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
 
{<section id="anmt310.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION anmt310_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE nmba_t.nmbacomp 
   DEFINE l_oldno     LIKE nmba_t.nmbacomp 
   DEFINE l_newno02     LIKE nmba_t.nmbadocno 
   DEFINE l_oldno02     LIKE nmba_t.nmbadocno 
 
   DEFINE l_master    RECORD LIKE nmba_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE nmbb_t.* #此變數樣板目前無使用
 
 
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
   #151016-00018#2-----s
   LET g_nmba_m.nmba007        = NULL
   LET g_nmba_m.l_nmbs003      = NULL
   LET g_nmba_m.nmbamodid      = NULL
   LET g_nmba_m.nmbamodid_desc = NULL
   LET g_nmba_m.nmbamoddt      = NULL
   LET g_nmba_m.nmbacnfid      = NULL
   LET g_nmba_m.nmbacnfid_desc = NULL
   LET g_nmba_m.nmbacnfdt      = NULL  
   #151016-00018#2-----e
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
 
   
   CALL anmt310_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_nmba_m.* TO NULL
      INITIALIZE g_nmbb_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL anmt310_show()
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
   CALL anmt310_set_act_visible()   
   CALL anmt310_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_nmbacomp_t = g_nmba_m.nmbacomp
   LET g_nmbadocno_t = g_nmba_m.nmbadocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " nmbaent = " ||g_enterprise|| " AND",
                      " nmbacomp = '", g_nmba_m.nmbacomp, "' "
                      ," AND nmbadocno = '", g_nmba_m.nmbadocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL anmt310_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
 
   #end add-point
   
   CALL anmt310_idx_chk()
   
   LET g_data_owner = g_nmba_m.nmbaownid      
   LET g_data_dept  = g_nmba_m.nmbaowndp
   
   #功能已完成,通報訊息中心
   CALL anmt310_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="anmt310.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION anmt310_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE nmbb_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
 
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE anmt310_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
 
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM nmbb_t
    WHERE nmbbent = g_enterprise AND nmbbcomp = g_nmbacomp_t
     AND nmbbdocno = g_nmbadocno_t
 
    INTO TEMP anmt310_detail
 
   #將key修正為調整後   
   UPDATE anmt310_detail 
      #更新key欄位
      SET nmbbcomp = g_nmba_m.nmbacomp
          , nmbbdocno = g_nmba_m.nmbadocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO nmbb_t SELECT * FROM anmt310_detail
   
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
   DROP TABLE anmt310_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   #151016-00018#2-----s
   CALL cl_err_collect_init()
   FOR l_ac = 1 TO g_nmbb_d.getLength()
      CALL anmt310_get_exrate()
      CALL anmt310_ref_amt()
      UPDATE nmbb_t 
         SET (nmbb005,nmbb007,nmbb008,nmbb009,nmbb011,nmbb012,
              nmbb013,nmbb014,nmbb015,nmbb016,nmbb017,nmbb018) 
           = (g_nmbb_d[l_ac].nmbb005,g_nmbb_d[l_ac].nmbb007,0,0,g_nmbb_d[l_ac].nmbb011,g_nmbb_d[l_ac].nmbb012,
              g_nmbb_d[l_ac].nmbb013,0,g_nmbb_d[l_ac].nmbb015,g_nmbb_d[l_ac].nmbb016,g_nmbb_d[l_ac].nmbb017,0)  
       WHERE nmbbent = g_enterprise
         AND nmbbcomp = g_nmba_m.nmbacomp
         AND nmbbdocno = g_nmba_m.nmbadocno
         AND nmbbseq = g_nmbb_d[l_ac].nmbbseq
   END FOR
   CALL cl_err_collect_show()
   LET l_ac = 1
   #151016-00018#2-----e
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_nmbacomp_t = g_nmba_m.nmbacomp
   LET g_nmbadocno_t = g_nmba_m.nmbadocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="anmt310.delete" >}
#+ 資料刪除
PRIVATE FUNCTION anmt310_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point     
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   DEFINE  l_cnt   LIKE type_t.num5
   DEFINE  l_year          LIKE type_t.num5
   DEFINE  l_month         LIKE type_t.num5
   DEFINE  l_result        LIKE type_t.num5
   DEFINE l_success        LIKE type_t.num5  #150813-00015#3 add
   DEFINE l_n              LIKE type_t.num5
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
 
   OPEN anmt310_cl USING g_enterprise,g_nmba_m.nmbacomp,g_nmba_m.nmbadocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN anmt310_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE anmt310_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE anmt310_master_referesh USING g_nmba_m.nmbacomp,g_nmba_m.nmbadocno INTO g_nmba_m.nmbasite, 
       g_nmba_m.nmba002,g_nmba_m.nmbacomp,g_nmba_m.nmbadocno,g_nmba_m.nmbadocdt,g_nmba_m.nmba003,g_nmba_m.nmba015, 
       g_nmba_m.nmba004,g_nmba_m.nmba005,g_nmba_m.nmba006,g_nmba_m.nmba007,g_nmba_m.nmbastus,g_nmba_m.nmbaownid, 
       g_nmba_m.nmbaowndp,g_nmba_m.nmbacrtid,g_nmba_m.nmbacrtdp,g_nmba_m.nmbacrtdt,g_nmba_m.nmbamodid, 
       g_nmba_m.nmbamoddt,g_nmba_m.nmbacnfid,g_nmba_m.nmbacnfdt,g_nmba_m.nmbasite_desc,g_nmba_m.nmbacomp_desc, 
       g_nmba_m.nmba004_desc,g_nmba_m.nmbaownid_desc,g_nmba_m.nmbaowndp_desc,g_nmba_m.nmbacrtid_desc, 
       g_nmba_m.nmbacrtdp_desc,g_nmba_m.nmbamodid_desc,g_nmba_m.nmbacnfid_desc
   
   
   #檢查是否允許此動作
   IF NOT anmt310_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_nmba_m_mask_o.* =  g_nmba_m.*
   CALL anmt310_nmba_t_mask()
   LET g_nmba_m_mask_n.* =  g_nmba_m.*
   
   CALL anmt310_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   #150813-00015#3--add--str--
   #161130-00055#1-S
   #IF g_nmba_m.nmbastus <> 'N' THEN
   #   INITIALIZE g_errparam TO NULL
   #   LET g_errparam.code = 'agl-00313'
   #   LET g_errparam.extend = 'modify'
   #   LET g_errparam.popup = TRUE
   #   CALL cl_err()
   #   CLOSE anmt310_cl
   #   CALL s_transaction_end('N','0')
   #   RETURN
   #END IF 
   #161130-00055#1-E
   
   #檢查當單據日期小於等於關帳日期時，不可異動單據
   CALL s_fin_date_close_chk('',g_nmba_m.nmbacomp,'ANM',g_nmba_m.nmbadocdt) RETURNING l_success
   IF l_success = FALSE THEN
      CLOSE anmt310_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   CALL anmt310_void_chk() RETURNING l_result
   IF l_result>0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'anm-01001'
      LET g_errparam.extend = 'delete'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CLOSE anmt310_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   #150813-00015#3--add--end
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
#150813-00015#3--mark--str--
#      IF g_nmba_m.nmbastus <> 'N' THEN
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.code = 'agl-00052'
#         LET g_errparam.extend = 'delete'
#         LET g_errparam.popup = TRUE
#         CALL cl_err()
#
#         RETURN
#      END IF 
#      CALL anmt310_void_chk() RETURNING l_result
#      IF l_result>0 THEN
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.code = 'anm-01001'
#         LET g_errparam.extend = 'delete'
#         LET g_errparam.popup = TRUE
#         CALL cl_err()
#         RETURN
#      END IF
#150813-00015#3--mark--end
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL anmt310_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      #160122-00001#26 - add -str
      LET l_n = 0 
      #單身存在當前用戶沒有權限的交易帳戶編碼
      SELECT COUNT(*) INTO l_n FROM nmbb_t
       WHERE nmbbent = g_enterprise AND nmbbdocno = g_nmba_m.nmbadocno
         AND nmbb003 NOT IN( SELECT UNIQUE nmll001 FROM nmll_t WHERE nmllent = g_enterprise AND nmll002 = g_user AND nmllstus='Y')
         AND nmbb003 NOT IN( SELECT UNIQUE nmlm001 FROM nmlm_t WHERE nmlment = g_enterprise AND nmlm002 = g_dept AND nmlmstus='Y')
         AND TRIM(nmbb003) IS NOT NULL
      IF l_n > 0 THEN
         IF NOT cl_ask_confirm('anm-00395') THEN
            CLOSE anmt310_cl
            CALL s_transaction_end('N','0')
            RETURN
         END IF
      END IF
      #160122-00001#26 -add -end
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
      
      #150831-00004#1----add---str--
      IF g_nmba_m.nmba003 = 'adet402' THEN   #判斷資料來源為adet402
         UPDATE deag_t SET deag006 = ''
          WHERE deagent = g_enterprise AND deag006 = g_nmba_m.nmbadocno
      END IF
      #150831-00004#1----add---end--
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
       #一次性交易對象
      LET l_cnt = 0
      SELECT COUNT(*) INTO l_cnt
        FROM pmak_t 
       WHERE pmakent = g_enterprise 
         AND pmak001 = g_nmba_m.nmba005
      IF l_cnt > 0 THEN
         DELETE FROM pmak_t WHERE pmakent = g_enterprise AND pmak001 = g_nmba_m.nmba005
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "pmak_t"
            LET g_errparam.popup = FALSE
            CALL cl_err()
 
            CALL s_transaction_end('N','0')
            RETURN
         END IF            
      END IF       
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM nmbb_t
       WHERE nmbbent = g_enterprise AND nmbbcomp = g_nmba_m.nmbacomp
         AND nmbbdocno = g_nmba_m.nmbadocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
     #150807-00007#1 add ------
      CALL s_cashflow_nm_del_glbc(g_nmba_m.nmbadocdt,g_glaald,g_nmba_m.nmbadocno,'')
           RETURNING g_sub_success,g_errno
      #150807-00007#1 add end---
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
      
            
                                                               
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_nmba_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE anmt310_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_nmbb_d.clear() 
 
     
      CALL anmt310_ui_browser_refresh()  
      #CALL anmt310_ui_headershow()  
      #CALL anmt310_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL anmt310_browser_fill("")
         CALL anmt310_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE anmt310_cl
 
   #功能已完成,通報訊息中心
   CALL anmt310_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="anmt310.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION anmt310_b_fill()
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
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF anmt310_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT nmbbseq,nmbborga,nmbb071,nmbb072,nmbb053,nmbb054,nmbb070,nmbblegl, 
             nmbb001,nmbb002,nmbb003,nmbb029,nmbb004,nmbb005,nmbb006,nmbb007,nmbb010,nmbb025,nmbb011, 
             nmbb012,nmbb013,nmbb014,nmbb015,nmbb016,nmbb017,nmbb018,nmbb008,nmbb009,nmbb019,nmbb020, 
             nmbb021,nmbb022,nmbb023,nmbb024,nmbb026,nmbb027,nmbb056,nmbb057,nmbb058,nmbb059,nmbb060, 
             nmbb061,nmbb062,nmbb066,nmbb067,nmbb068 ,t1.ooefl003 ,t2.ooefl003 ,t3.nmajl003 ,t4.nmaal003 FROM nmbb_t", 
                
                     " INNER JOIN nmba_t ON nmbaent = " ||g_enterprise|| " AND nmbacomp = nmbbcomp ",
                     " AND nmbadocno = nmbbdocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=nmbborga AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=nmbb070 AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN nmajl_t t3 ON t3.nmajlent="||g_enterprise||" AND t3.nmajl001=nmbb002 AND t3.nmajl002='"||g_dlang||"' ",
               " LEFT JOIN nmaal_t t4 ON t4.nmaalent="||g_enterprise||" AND t4.nmaal001=nmbb003 AND t4.nmaal002='"||g_dlang||"' ",
 
                     " WHERE nmbbent=? AND nmbbcomp=? AND nmbbdocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         #160122-00001#26 - add -str
#         LET g_sql = g_sql CLIPPED ," AND (nmbb003 IN (SELECT UNIQUE nmll001 FROM nmll_t WHERE nmllent = ",g_enterprise," AND nmll002 = '",g_user,"')",
#                                " OR nmbb003 IS NULL )"
         LET g_sql = g_sql CLIPPED ," AND (nmbb003 IN (",g_sql_bank,") OR TRIM(nmbb003) IS NULL )"
         LET g_sql = cl_sql_add_mask(g_sql)                              
         #160122-00001#26 - add -end
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY nmbb_t.nmbbseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
      
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE anmt310_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR anmt310_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_nmba_m.nmbacomp,g_nmba_m.nmbadocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_nmba_m.nmbacomp,g_nmba_m.nmbadocno INTO g_nmbb_d[l_ac].nmbbseq, 
          g_nmbb_d[l_ac].nmbborga,g_nmbb_d[l_ac].nmbb071,g_nmbb_d[l_ac].nmbb072,g_nmbb_d[l_ac].nmbb053, 
          g_nmbb_d[l_ac].nmbb054,g_nmbb_d[l_ac].nmbb070,g_nmbb_d[l_ac].nmbblegl,g_nmbb_d[l_ac].nmbb001, 
          g_nmbb_d[l_ac].nmbb002,g_nmbb_d[l_ac].nmbb003,g_nmbb_d[l_ac].nmbb029,g_nmbb_d[l_ac].nmbb004, 
          g_nmbb_d[l_ac].nmbb005,g_nmbb_d[l_ac].nmbb006,g_nmbb_d[l_ac].nmbb007,g_nmbb_d[l_ac].nmbb010, 
          g_nmbb_d[l_ac].nmbb025,g_nmbb_d[l_ac].nmbb011,g_nmbb_d[l_ac].nmbb012,g_nmbb_d[l_ac].nmbb013, 
          g_nmbb_d[l_ac].nmbb014,g_nmbb_d[l_ac].nmbb015,g_nmbb_d[l_ac].nmbb016,g_nmbb_d[l_ac].nmbb017, 
          g_nmbb_d[l_ac].nmbb018,g_nmbb_d[l_ac].nmbb008,g_nmbb_d[l_ac].nmbb009,g_nmbb_d[l_ac].nmbb019, 
          g_nmbb_d[l_ac].nmbb020,g_nmbb_d[l_ac].nmbb021,g_nmbb_d[l_ac].nmbb022,g_nmbb_d[l_ac].nmbb023, 
          g_nmbb_d[l_ac].nmbb024,g_nmbb_d[l_ac].nmbb026,g_nmbb_d[l_ac].nmbb027,g_nmbb_d[l_ac].nmbb056, 
          g_nmbb_d[l_ac].nmbb057,g_nmbb_d[l_ac].nmbb058,g_nmbb_d[l_ac].nmbb059,g_nmbb_d[l_ac].nmbb060, 
          g_nmbb_d[l_ac].nmbb061,g_nmbb_d[l_ac].nmbb062,g_nmbb_d[l_ac].nmbb066,g_nmbb_d[l_ac].nmbb067, 
          g_nmbb_d[l_ac].nmbb068,g_nmbb_d[l_ac].nmbborga_desc,g_nmbb_d[l_ac].nmbb070_desc,g_nmbb_d[l_ac].nmbb002_desc, 
          g_nmbb_d[l_ac].nmbb003_desc   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill.fill"
         CALL anmt310_ref_b()
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
   
   CALL g_nmbb_d.deleteElement(g_nmbb_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE anmt310_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_nmbb_d.getLength()
      LET g_nmbb_d_mask_o[l_ac].* =  g_nmbb_d[l_ac].*
      CALL anmt310_nmbb_t_mask()
      LET g_nmbb_d_mask_n[l_ac].* =  g_nmbb_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="anmt310.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION anmt310_delete_b(ps_table,ps_keys_bak,ps_page)
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
   
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="anmt310.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION anmt310_insert_b(ps_table,ps_keys,ps_page)
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
                   ,nmbborga,nmbb071,nmbb072,nmbb053,nmbb054,nmbb070,nmbblegl,nmbb001,nmbb002,nmbb003,nmbb029,nmbb004,nmbb005,nmbb006,nmbb007,nmbb010,nmbb025,nmbb011,nmbb012,nmbb013,nmbb014,nmbb015,nmbb016,nmbb017,nmbb018,nmbb008,nmbb009,nmbb019,nmbb020,nmbb021,nmbb022,nmbb023,nmbb024,nmbb026,nmbb027,nmbb056,nmbb057,nmbb058,nmbb059,nmbb060,nmbb061,nmbb062,nmbb066,nmbb067,nmbb068) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_nmbb_d[g_detail_idx].nmbborga,g_nmbb_d[g_detail_idx].nmbb071,g_nmbb_d[g_detail_idx].nmbb072, 
                       g_nmbb_d[g_detail_idx].nmbb053,g_nmbb_d[g_detail_idx].nmbb054,g_nmbb_d[g_detail_idx].nmbb070, 
                       g_nmbb_d[g_detail_idx].nmbblegl,g_nmbb_d[g_detail_idx].nmbb001,g_nmbb_d[g_detail_idx].nmbb002, 
                       g_nmbb_d[g_detail_idx].nmbb003,g_nmbb_d[g_detail_idx].nmbb029,g_nmbb_d[g_detail_idx].nmbb004, 
                       g_nmbb_d[g_detail_idx].nmbb005,g_nmbb_d[g_detail_idx].nmbb006,g_nmbb_d[g_detail_idx].nmbb007, 
                       g_nmbb_d[g_detail_idx].nmbb010,g_nmbb_d[g_detail_idx].nmbb025,g_nmbb_d[g_detail_idx].nmbb011, 
                       g_nmbb_d[g_detail_idx].nmbb012,g_nmbb_d[g_detail_idx].nmbb013,g_nmbb_d[g_detail_idx].nmbb014, 
                       g_nmbb_d[g_detail_idx].nmbb015,g_nmbb_d[g_detail_idx].nmbb016,g_nmbb_d[g_detail_idx].nmbb017, 
                       g_nmbb_d[g_detail_idx].nmbb018,g_nmbb_d[g_detail_idx].nmbb008,g_nmbb_d[g_detail_idx].nmbb009, 
                       g_nmbb_d[g_detail_idx].nmbb019,g_nmbb_d[g_detail_idx].nmbb020,g_nmbb_d[g_detail_idx].nmbb021, 
                       g_nmbb_d[g_detail_idx].nmbb022,g_nmbb_d[g_detail_idx].nmbb023,g_nmbb_d[g_detail_idx].nmbb024, 
                       g_nmbb_d[g_detail_idx].nmbb026,g_nmbb_d[g_detail_idx].nmbb027,g_nmbb_d[g_detail_idx].nmbb056, 
                       g_nmbb_d[g_detail_idx].nmbb057,g_nmbb_d[g_detail_idx].nmbb058,g_nmbb_d[g_detail_idx].nmbb059, 
                       g_nmbb_d[g_detail_idx].nmbb060,g_nmbb_d[g_detail_idx].nmbb061,g_nmbb_d[g_detail_idx].nmbb062, 
                       g_nmbb_d[g_detail_idx].nmbb066,g_nmbb_d[g_detail_idx].nmbb067,g_nmbb_d[g_detail_idx].nmbb068) 
 
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
   
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="anmt310.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION anmt310_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
      CALL anmt310_nmbb_t_mask_restore('restore_mask_o')
               
      UPDATE nmbb_t 
         SET (nmbbcomp,nmbbdocno,
              nmbbseq
              ,nmbborga,nmbb071,nmbb072,nmbb053,nmbb054,nmbb070,nmbblegl,nmbb001,nmbb002,nmbb003,nmbb029,nmbb004,nmbb005,nmbb006,nmbb007,nmbb010,nmbb025,nmbb011,nmbb012,nmbb013,nmbb014,nmbb015,nmbb016,nmbb017,nmbb018,nmbb008,nmbb009,nmbb019,nmbb020,nmbb021,nmbb022,nmbb023,nmbb024,nmbb026,nmbb027,nmbb056,nmbb057,nmbb058,nmbb059,nmbb060,nmbb061,nmbb062,nmbb066,nmbb067,nmbb068) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_nmbb_d[g_detail_idx].nmbborga,g_nmbb_d[g_detail_idx].nmbb071,g_nmbb_d[g_detail_idx].nmbb072, 
                  g_nmbb_d[g_detail_idx].nmbb053,g_nmbb_d[g_detail_idx].nmbb054,g_nmbb_d[g_detail_idx].nmbb070, 
                  g_nmbb_d[g_detail_idx].nmbblegl,g_nmbb_d[g_detail_idx].nmbb001,g_nmbb_d[g_detail_idx].nmbb002, 
                  g_nmbb_d[g_detail_idx].nmbb003,g_nmbb_d[g_detail_idx].nmbb029,g_nmbb_d[g_detail_idx].nmbb004, 
                  g_nmbb_d[g_detail_idx].nmbb005,g_nmbb_d[g_detail_idx].nmbb006,g_nmbb_d[g_detail_idx].nmbb007, 
                  g_nmbb_d[g_detail_idx].nmbb010,g_nmbb_d[g_detail_idx].nmbb025,g_nmbb_d[g_detail_idx].nmbb011, 
                  g_nmbb_d[g_detail_idx].nmbb012,g_nmbb_d[g_detail_idx].nmbb013,g_nmbb_d[g_detail_idx].nmbb014, 
                  g_nmbb_d[g_detail_idx].nmbb015,g_nmbb_d[g_detail_idx].nmbb016,g_nmbb_d[g_detail_idx].nmbb017, 
                  g_nmbb_d[g_detail_idx].nmbb018,g_nmbb_d[g_detail_idx].nmbb008,g_nmbb_d[g_detail_idx].nmbb009, 
                  g_nmbb_d[g_detail_idx].nmbb019,g_nmbb_d[g_detail_idx].nmbb020,g_nmbb_d[g_detail_idx].nmbb021, 
                  g_nmbb_d[g_detail_idx].nmbb022,g_nmbb_d[g_detail_idx].nmbb023,g_nmbb_d[g_detail_idx].nmbb024, 
                  g_nmbb_d[g_detail_idx].nmbb026,g_nmbb_d[g_detail_idx].nmbb027,g_nmbb_d[g_detail_idx].nmbb056, 
                  g_nmbb_d[g_detail_idx].nmbb057,g_nmbb_d[g_detail_idx].nmbb058,g_nmbb_d[g_detail_idx].nmbb059, 
                  g_nmbb_d[g_detail_idx].nmbb060,g_nmbb_d[g_detail_idx].nmbb061,g_nmbb_d[g_detail_idx].nmbb062, 
                  g_nmbb_d[g_detail_idx].nmbb066,g_nmbb_d[g_detail_idx].nmbb067,g_nmbb_d[g_detail_idx].nmbb068)  
 
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
      CALL anmt310_nmbb_t_mask_restore('restore_mask_n')
               
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
 
{<section id="anmt310.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION anmt310_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="anmt310.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION anmt310_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="anmt310.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION anmt310_lock_b(ps_table,ps_page)
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
   #CALL anmt310_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "nmbb_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN anmt310_bcl USING g_enterprise,
                                       g_nmba_m.nmbacomp,g_nmba_m.nmbadocno,g_nmbb_d[g_detail_idx].nmbbseq  
                                               
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "anmt310_bcl:",SQLERRMESSAGE 
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
 
{<section id="anmt310.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION anmt310_unlock_b(ps_table,ps_page)
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
      CLOSE anmt310_bcl
   END IF
   
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="anmt310.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION anmt310_set_entry(p_cmd)
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
      CALL cl_set_comp_entry("nmbasite,nmba002",TRUE) #150714-00024#1 add
      CALL cl_set_comp_entry("nmbadocdt",TRUE)  #150401-00001#31 
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
  
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="anmt310.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION anmt310_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   DEFINE l_success  LIKE type_t.num5  
   DEFINE l_slip     LIKE type_t.chr10
   DEFINE l_dfin0033  LIKE type_t.chr80
   DEFINE l_para_date LIKE type_t.dat   #150813-00015#3 add
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
      CALL cl_set_comp_entry("nmbasite,nmba002",FALSE) #150714-00024#1 add 

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
   #151130-00015#2 -begin -add by XZG 20151218
#   IF NOT cl_null(g_nmba_m.nmbadocno) THEN #150813-00015#3 mark
   IF NOT cl_null(g_nmba_m.nmbadocno) AND p_cmd = 'u'  THEN  #150813-00015#3 add
      #获取单别
      CALL s_aooi200_fin_get_slip(g_nmba_m.nmbadocno) RETURNING l_success,l_slip
      #是否可改日期
      CALL s_fin_get_doc_para(g_glaald,g_nmba_m.nmbacomp,l_slip,'D-FIN-0033') RETURNING l_dfin0033
      #抓取关帐日期
      CALL cl_get_para(g_enterprise,g_nmba_m.nmbacomp,'S-FIN-4007') RETURNING l_para_date #150813-00015#3 add
#      IF l_dfin0033 = "N"  THEN  #150813-00015#3 mark
      IF l_dfin0033 = "N" AND g_nmba_m.nmbadocdt <= l_para_date THEN  #150813-00015#3 add
         CALL cl_set_comp_entry("nmbadocdt",FALSE)
      ELSE 
         CALL cl_set_comp_entry("nmbadocdt",TRUE)
      END IF          
   END IF 
   #151130-00015#2  -end
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="anmt310.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION anmt310_set_entry_b(p_cmd)
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
 
{<section id="anmt310.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION anmt310_set_no_entry_b(p_cmd)
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
      #160326-00001#26 add s---
      #IF g_nmba_m.nmba003 = '3' THEN #160326-00001#36 mark
      IF g_nmba_m.nmba003 = 'anmp802' THEN #160326-00001#36 add
         CALL cl_set_comp_entry("nmbborga,nmbb001,nmbb003,nmbb004,nmbb005,nmbb006,nmbb007",FALSE) 
      END IF
      #160326-00001#26 add e---
      #end add-point 
   END IF 
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b"
 
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="anmt310.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION anmt310_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   #161130-00055#1-S
   #IF g_nmba_m.nmbastus = 'N' THEN
   IF g_nmba_m.nmbastus MATCHES '[NDR]' THEN 
   #161130-00055#1-E
      CALL cl_set_act_visible("modify,modify_detail,delete", TRUE) 
   END IF
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="anmt310.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION anmt310_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #161130-00055#1-S
   #IF g_nmba_m.nmbastus <> 'N' THEN
   IF g_nmba_m.nmbastus NOT MATCHES '[NDR]' THEN 
   #161130-00055#1-E
      CALL cl_set_act_visible("modify,modify_detail,delete", FALSE)   
   END IF
   CALL cl_set_toolbaritem_visible("open_anmt311", FALSE)   #150616-00026#12
    
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="anmt310.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION anmt310_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="anmt310.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION anmt310_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
 
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="anmt310.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION anmt310_default_search()
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
 
         FOR li_idx = 1 TO la_wc.getLength()
            CASE
               WHEN la_wc[li_idx].tableid = "nmba_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "nmbb_t" 
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
 
{<section id="anmt310.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION anmt310_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_today       DATETIME YEAR TO SECOND
   DEFINE l_year        LIKE type_t.chr500
   DEFINE l_month       LIKE type_t.chr500
   DEFINE l_n           LIKE type_t.num5
   DEFINE l_result      LIKE type_t.num5
   DEFINE l_nmbb007     LIKE nmbb_t.nmbb007
   DEFINE l_nmbb007_1   LIKE nmbb_t.nmbb007
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_efin5001    LIKE type_t.chr1
   DEFINE l_ooba002     LIKE ooba_t.ooba002
   DEFINE l_flag        LIKE type_t.num5  #161104-00030#1 add
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
   
   OPEN anmt310_cl USING g_enterprise,g_nmba_m.nmbacomp,g_nmba_m.nmbadocno
   IF STATUS THEN
      CLOSE anmt310_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN anmt310_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE anmt310_master_referesh USING g_nmba_m.nmbacomp,g_nmba_m.nmbadocno INTO g_nmba_m.nmbasite, 
       g_nmba_m.nmba002,g_nmba_m.nmbacomp,g_nmba_m.nmbadocno,g_nmba_m.nmbadocdt,g_nmba_m.nmba003,g_nmba_m.nmba015, 
       g_nmba_m.nmba004,g_nmba_m.nmba005,g_nmba_m.nmba006,g_nmba_m.nmba007,g_nmba_m.nmbastus,g_nmba_m.nmbaownid, 
       g_nmba_m.nmbaowndp,g_nmba_m.nmbacrtid,g_nmba_m.nmbacrtdp,g_nmba_m.nmbacrtdt,g_nmba_m.nmbamodid, 
       g_nmba_m.nmbamoddt,g_nmba_m.nmbacnfid,g_nmba_m.nmbacnfdt,g_nmba_m.nmbasite_desc,g_nmba_m.nmbacomp_desc, 
       g_nmba_m.nmba004_desc,g_nmba_m.nmbaownid_desc,g_nmba_m.nmbaowndp_desc,g_nmba_m.nmbacrtid_desc, 
       g_nmba_m.nmbacrtdp_desc,g_nmba_m.nmbamodid_desc,g_nmba_m.nmbacnfid_desc
   
 
   #檢查是否允許此動作
   IF NOT anmt310_action_chk() THEN
      CLOSE anmt310_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_nmba_m.nmbasite,g_nmba_m.nmbasite_desc,g_nmba_m.nmba002,g_nmba_m.nmba002_desc,g_nmba_m.nmbacomp, 
       g_nmba_m.nmbacomp_desc,g_nmba_m.nmbadocno,g_nmba_m.nmbadocdt,g_nmba_m.nmba003,g_nmba_m.nmba003_desc, 
       g_nmba_m.nmba015,g_nmba_m.nmba004,g_nmba_m.nmba004_desc,g_nmba_m.nmba005,g_nmba_m.nmba006,g_nmba_m.nmba007, 
       g_nmba_m.l_nmbs003,g_nmba_m.nmbastus,g_nmba_m.nmbaownid,g_nmba_m.nmbaownid_desc,g_nmba_m.nmbaowndp, 
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
      HIDE OPTION "verify"
      HIDE OPTION "unverify"
      #CALL cl_showmsg_init()
      #150714-00024#1 add ------
      CALL cl_set_act_visible("signing,withdraw",FALSE)
      CALL cl_set_act_visible("unconfirmed,invalid,confirmed",TRUE)
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
            CALL cl_set_act_visible("confirmed,unconfirmed",FALSE)

         WHEN "D"   #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed",FALSE) 
          
         WHEN "X"
            CLOSE anmt310_cl #150813-00015#3 add
            CALL s_transaction_end('N','0')        #150401-00001#13
            RETURN

         WHEN "Y"
            CALL cl_set_act_visible("invalid,confirmed",FALSE)
         
         WHEN "W"    #只能顯示抽單;其餘應用功能皆隱藏
             CALL cl_set_act_visible("withdraw",TRUE)  
             CALL cl_set_act_visible("unconfirmed,invalid,confirmed",FALSE)
         
         WHEN "A"     #只能顯示確認; 其餘應用功能皆隱藏
             CALL cl_set_act_visible("confirmed ",TRUE)  
             CALL cl_set_act_visible("unconfirmed,invalid",FALSE)
      END CASE
      #150714-00024#1 add end---
      LET g_success = 'Y'
      #end add-point
      
      #應用 a36 樣板自動產生(Version:5)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT anmt310_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE anmt310_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT anmt310_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE anmt310_cl
            RETURN
         END IF
 
 
 
	  
      ON ACTION unconfirmed
         IF cl_auth_chk_act("unconfirmed") THEN
            LET lc_state = "N"
            #add-point:action控制 name="statechange.unconfirmed"
            #151013-00016#7 151027 by sakura mark(S)
            #IF g_nmba_m.nmba003 = 'anmt440' THEN           
            #   INITIALIZE g_errparam TO NULL
            #   LET g_errparam.code = 'anm-00331'
            #   LET g_errparam.extend = g_nmba_m.nmbadocno
            #   LET g_errparam.popup = TRUE
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0') #150714-00024#1
            #   RETURN
            #END IF
            #151013-00016#7 151027 by sakura mark(E)
#           IF NOT cl_null(g_nmba_m.nmba007) THEN 
#              INITIALIZE g_errparam TO NULL
#              LET g_errparam.code = 'anm-00197'
#              LET g_errparam.extend = g_nmba_m.nmbadocno
#              LET g_errparam.popup = TRUE
#              CALL cl_err()
#              RETURN
#           END IF
            #151013-00016#7 151027 by sakura mark(S)
            #CALL anmt310_void_chk() RETURNING l_result
            #IF l_result>0 THEN
            #   INITIALIZE g_errparam TO NULL
            #   LET g_errparam.code = 'anm-01001'
            #   LET g_errparam.extend = g_nmba_m.nmbadocno
            #   LET g_errparam.popup = TRUE
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0') #150714-00024#1
            #   RETURN
            #END IF
            #151013-00016#7 151027 by sakura mark(E)
            #end add-point
         END IF
         EXIT MENU
      ON ACTION confirmed
         IF cl_auth_chk_act("confirmed") THEN
            LET lc_state = "Y"
            #add-point:action控制 name="statechange.confirmed"
            #151013-00016#7 151027 by sakura mark(S)
            #IF g_nmba_m.nmbastus = 'X' THEN 
            #   INITIALIZE g_errparam TO NULL
            #   LET g_errparam.code = 'anm-00044'
            #   LET g_errparam.extend = g_nmba_m.nmbadocno
            #   LET g_errparam.popup = TRUE
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0') #150714-00024#1
            #   RETURN
            #END IF 
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
            #   CALL s_transaction_end('N','0') #150714-00024#1
            #   RETURN
            #END IF
            #
            ##150602-00057#2 by 02291 add
            #CALL s_aooi200_fin_get_slip(g_nmba_m.nmbadocno) RETURNING l_success,l_ooba002
            #CALL s_fin_chk_E5001(g_glaald,g_nmba_m.nmbacomp,l_ooba002) RETURNING l_efin5001
            #IF l_efin5001 = 'N' THEN
            #   IF g_nmba_m.nmbacrtid = g_user THEN
            #      INITIALIZE g_errparam TO NULL
            #      LET g_errparam.code = 'axr-00346'
            #      LET g_errparam.extend = ''
            #      LET g_errparam.popup = TRUE
            #      CALL cl_err()
            #      CALL s_transaction_end('N','0')
            #      CLOSE anmt310_cl
            #      RETURN
            #   END IF
            #END IF   
            ##150602-00057#2 by 02291 add
            #
            ##檢查存入和提出的本幣金額是否相等
            #SELECT SUM(nmbb007) INTO l_nmbb007
            #  FROM nmbb_t
            # WHERE nmbbent = g_enterprise
            #   AND nmbbdocno = g_nmba_m.nmbadocno
            #   AND nmbbcomp = g_nmba_m.nmbacomp
            #   AND nmbb001 IN('1','3')
            #SELECT SUM(nmbb007) INTO l_nmbb007_1
            #  FROM nmbb_t
            # WHERE nmbbent = g_enterprise
            #   AND nmbbdocno = g_nmba_m.nmbadocno
            #   AND nmbbcomp = g_nmba_m.nmbacomp
            #   AND nmbb001 IN('2','4')
            #IF cl_null(l_nmbb007) THEN LET l_nmbb007 = 0 END IF
            #IF cl_null(l_nmbb007_1) THEN LET l_nmbb007_1 = 0 END IF
            #IF l_nmbb007 <> l_nmbb007_1 THEN
            #   INITIALIZE g_errparam TO NULL
            #   LET g_errparam.code = 'anm-00310'
            #   LET g_errparam.extend = g_nmba_m.nmbadocno
            #   LET g_errparam.popup = TRUE
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0') #150714-00024#1
            #   RETURN
            #END IF
            #CALL cl_err_collect_init()
            #CALL anmt310_conf()
            #151013-00016#7 151027 by sakura mark(E)
            #end add-point
         END IF
         EXIT MENU
      ON ACTION verify
         IF cl_auth_chk_act("verify") THEN
            LET lc_state = "V"
            #add-point:action控制 name="statechange.verify"
            IF g_nmba_m.nmbastus = 'X' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'anm-00044'
               LET g_errparam.extend = g_nmba_m.nmbadocno
               LET g_errparam.popup = TRUE
               CALL cl_err()
               CALL s_transaction_end('N','0') #150714-00024#1
               RETURN
            END IF
            IF g_nmba_m.nmbastus <> 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'anm-00053'
               LET g_errparam.extend = g_nmba_m.nmbadocno
               LET g_errparam.popup = TRUE
               CALL cl_err()
               CALL s_transaction_end('N','0') #150714-00024#1
               RETURN
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
            #151013-00016#7 151027 by sakura mark(S)
            #IF g_nmba_m.nmbastus = 'Y' THEN 
            #   INITIALIZE g_errparam TO NULL
            #   LET g_errparam.code = 'anm-00045'
            #   LET g_errparam.extend = g_nmba_m.nmbadocno
            #   LET g_errparam.popup = TRUE
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0') #150714-00024#1
            #   RETURN
            #END IF 
            #IF g_nmba_m.nmbastus = 'V' THEN 
            #   INITIALIZE g_errparam TO NULL
            #   LET g_errparam.code = 'anm-00055'
            #   LET g_errparam.extend = g_nmba_m.nmbadocno
            #   LET g_errparam.popup = TRUE
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0') #150714-00024#1
            #   RETURN
            #END IF
            #151013-00016#7 151027 by sakura mark(E)
            #end add-point
         END IF
         EXIT MENU
 
      #add-point:stus控制 name="statechange.more_control"
      ON ACTION unverify
         LET lc_state = "Y"
         
         IF g_nmba_m.nmbastus <> 'V' THEN 
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'anm-00056'
            LET g_errparam.extend = g_nmba_m.nmbadocno
            LET g_errparam.popup = TRUE
            CALL cl_err()
            CALL s_transaction_end('N','0') #150714-00024#1
            RETURN
         END IF 
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
      CLOSE anmt310_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   #151013-00016#7 151027 by sakura mark(S)
   #IF g_success = 'N'  THEN
   #   #CALL cl_err_showmsg()
   #   CALL cl_err_collect_show()
   #   CALL s_transaction_end('N','0') 
   #   RETURN        
   #END IF
   #151013-00016#7 151027 by sakura mark(E)
   
   #151013-00016#7 151027 by sakura add(S)
   CALL cl_err_collect_init()
   #確認
   IF lc_state = 'Y' THEN
      IF g_nmba_m.nmbastus = 'N' THEN
         #CALL s_anmt310_conf_chk(g_nmba_m.nmbacomp,g_nmba_m.nmbadocno) RETURNING g_sub_success       #161104-00030#1 mark
         CALL s_anmt310_conf_chk(g_nmba_m.nmbacomp,g_nmba_m.nmbadocno) RETURNING g_sub_success,l_flag #161104-00030#1 add
         IF NOT g_sub_success THEN
            CALL s_transaction_end('N','0')
            CALL cl_err_collect_show()
            RETURN
         ELSE
            IF l_flag = TRUE THEN #161104-00030#1 add
               IF NOT cl_ask_confirm('aim-00108') THEN   #是否執行確認？
                  CALL s_transaction_end('N','0')
                  CALL cl_err_collect_show()
                  RETURN
               ELSE
                  CALL s_transaction_begin()
                  CALL s_anmt310_conf_upd(g_nmba_m.nmbacomp,g_nmba_m.nmbadocno) RETURNING g_sub_success
                  IF NOT g_sub_success THEN
                     CALL s_transaction_end('N','0')
                     CALL cl_err_collect_show()
                     RETURN
                  ELSE
                     CALL s_transaction_end('Y','0')
                     CALL cl_err_collect_show()
                  END IF
               END IF
            #161104-00030#1 add s---   
            ELSE
               CALL s_transaction_begin()
               CALL s_anmt310_conf_upd(g_nmba_m.nmbacomp,g_nmba_m.nmbadocno) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  CALL s_transaction_end('N','0')
                  CALL cl_err_collect_show()
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','0')
                  CALL cl_err_collect_show()
               END IF            
            END IF            
            #161104-00030#1 add e---
         END IF
      END IF  
   END IF  
   #取消確認
   IF lc_state = 'N' THEN
      CALL s_anmt310_unconf_chk(g_nmba_m.nmbacomp,g_nmba_m.nmbadocno) RETURNING g_sub_success
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
            CALL s_anmt310_unconf_upd(g_nmba_m.nmbacomp,g_nmba_m.nmbadocno) RETURNING g_sub_success
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
      CALL s_anmt310_invalid_chk(g_nmba_m.nmbacomp,g_nmba_m.nmbadocno) RETURNING g_sub_success
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
            CALL s_anmt310_invalid_upd(g_nmba_m.nmbacomp,g_nmba_m.nmbadocno) RETURNING g_sub_success
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
   #151013-00016#7 151027 by sakura add(E)   
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
      EXECUTE anmt310_master_referesh USING g_nmba_m.nmbacomp,g_nmba_m.nmbadocno INTO g_nmba_m.nmbasite, 
          g_nmba_m.nmba002,g_nmba_m.nmbacomp,g_nmba_m.nmbadocno,g_nmba_m.nmbadocdt,g_nmba_m.nmba003, 
          g_nmba_m.nmba015,g_nmba_m.nmba004,g_nmba_m.nmba005,g_nmba_m.nmba006,g_nmba_m.nmba007,g_nmba_m.nmbastus, 
          g_nmba_m.nmbaownid,g_nmba_m.nmbaowndp,g_nmba_m.nmbacrtid,g_nmba_m.nmbacrtdp,g_nmba_m.nmbacrtdt, 
          g_nmba_m.nmbamodid,g_nmba_m.nmbamoddt,g_nmba_m.nmbacnfid,g_nmba_m.nmbacnfdt,g_nmba_m.nmbasite_desc, 
          g_nmba_m.nmbacomp_desc,g_nmba_m.nmba004_desc,g_nmba_m.nmbaownid_desc,g_nmba_m.nmbaowndp_desc, 
          g_nmba_m.nmbacrtid_desc,g_nmba_m.nmbacrtdp_desc,g_nmba_m.nmbamodid_desc,g_nmba_m.nmbacnfid_desc 
 
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_nmba_m.nmbasite,g_nmba_m.nmbasite_desc,g_nmba_m.nmba002,g_nmba_m.nmba002_desc, 
          g_nmba_m.nmbacomp,g_nmba_m.nmbacomp_desc,g_nmba_m.nmbadocno,g_nmba_m.nmbadocdt,g_nmba_m.nmba003, 
          g_nmba_m.nmba003_desc,g_nmba_m.nmba015,g_nmba_m.nmba004,g_nmba_m.nmba004_desc,g_nmba_m.nmba005, 
          g_nmba_m.nmba006,g_nmba_m.nmba007,g_nmba_m.l_nmbs003,g_nmba_m.nmbastus,g_nmba_m.nmbaownid, 
          g_nmba_m.nmbaownid_desc,g_nmba_m.nmbaowndp,g_nmba_m.nmbaowndp_desc,g_nmba_m.nmbacrtid,g_nmba_m.nmbacrtid_desc, 
          g_nmba_m.nmbacrtdp,g_nmba_m.nmbacrtdp_desc,g_nmba_m.nmbacrtdt,g_nmba_m.nmbamodid,g_nmba_m.nmbamodid_desc, 
          g_nmba_m.nmbamoddt,g_nmba_m.nmbacnfid,g_nmba_m.nmbacnfid_desc,g_nmba_m.nmbacnfdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   #151013-00016#7 151102 by sakura mark(S)
   ##151013-00016#6---s
   #CALL s_anm_glbc015_upd(g_glaald,g_nmba_m.nmbadocno,g_nmba_m.nmbadocdt,g_nmba_m.nmbastus) RETURNING l_success
   #IF NOT l_success THEN
   #   CALL s_transaction_end('N','0')
   #   RETURN
   #END IF
   ##151013-00016#6---e
   #151013-00016#7 151102 by sakura mark(E)
   
   #151013-00016#7 151027 by sakura mark(S)
   #LET g_success = 'Y'
   #IF lc_state = 'Y' THEN 
   #   LET l_today  = cl_get_current() 
   #   UPDATE nmba_t SET nmbacnfid = g_user,
   #                     nmbacnfdt = l_today
   #    WHERE nmbaent = g_enterprise 
   #      AND nmbacomp = g_nmba_m.nmbacomp
   #      AND nmbadocno = g_nmba_m.nmbadocno
   #   
   #   CALL anmt310_nmbc_insert()
   #   IF g_success = 'Y' THEN
   #      CALL s_transaction_end('Y','1')
   #   END IF
   #   IF g_success = 'N' THEN
   #      CALL s_transaction_end('N','1')
   #      RETURN
   #   END IF
   #ELSE
   #   UPDATE nmba_t SET nmbacnfid = '',
   #                     nmbacnfdt = ''
   #    WHERE nmbaent = g_enterprise 
   #      AND nmbacomp = g_nmba_m.nmbacomp
   #      AND nmbadocno = g_nmba_m.nmbadocno
   #   CALL anmt310_nmbc_delete()
   #   IF g_success = 'Y' THEN
   #      CALL s_transaction_end('Y','1')
   #   END IF
   #   IF g_success = 'N' THEN
   #      CALL s_transaction_end('N','1')
   #      RETURN
   #   END IF
   #END IF
   #151013-00016#7 151027 by sakura mark(E)
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE anmt310_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL anmt310_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="anmt310.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION anmt310_idx_chk()
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
   
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="anmt310.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION anmt310_b_fill2(pi_idx)
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
   
   CALL anmt310_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="anmt310.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION anmt310_fill_chk(ps_idx)
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
 
{<section id="anmt310.status_show" >}
PRIVATE FUNCTION anmt310_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="anmt310.mask_functions" >}
&include "erp/anm/anmt310_mask.4gl"
 
{</section>}
 
{<section id="anmt310.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION anmt310_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   DEFINE l_flag        LIKE type_t.num5  #161104-00030#1 add
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
 
 
   CALL anmt310_show()
   CALL anmt310_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   #151013-00016#7 151027 by sakura add(S)
   #IF NOT s_anmt310_conf_chk(g_nmba_m.nmbacomp ,g_nmba_m.nmbadocno) THEN                        #161104-00030#1 mark
   CALL s_anmt310_conf_chk(g_nmba_m.nmbacomp ,g_nmba_m.nmbadocno) RETURNING g_sub_success,l_flag #161104-00030#1 add
   IF NOT g_sub_success THEN                                                                     #161104-00030#1 add
      CLOSE anmt310_cl
      CALL s_transaction_end('N','0')
      RETURN FALSE
   END IF
   #151013-00016#7 151027 by sakura add(E)
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_nmba_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_nmbb_d))
 
 
   # cl_bpm_cli() 裡有包含以前的aws_condition()=>送簽資料檢核和更新單據狀況碼為'W'
   # cl_bpm_cli() 傳入參數:無  ;  回傳值: 0 開單失敗; 1 開單成功
 
   #add-point: 提交前的ADP name="send.before_cli"
   #161130-00055#1.2-S
   LET g_other.amt3_c         = g_amt3_c
   LET g_other.amt4_c         = g_amt4_c
   LET g_other.amt1_d         = g_amt1_d
   LET g_other.amt2_d         = g_amt2_d
   #例外欄位資料
   CALL cl_bpm_set_other_data(util.JSONObject.fromFGL(g_other))
   #161130-00055#1.2-E
   #end add-point
 
   #開單失敗
   IF NOT cl_bpm_cli() THEN 
      RETURN FALSE
   END IF
 
   #add-point: 提交後的ADP name="send.after_send"
   
   #end add-point
 
   #此段落不需要刪除資料,但是否需要refresh圖片樣式???
   #CALL anmt310_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL anmt310_ui_headershow()
   CALL anmt310_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION anmt310_draw_out()
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
   CALL anmt310_ui_headershow()  
   CALL anmt310_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="anmt310.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION anmt310_set_pk_array()
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
 
{<section id="anmt310.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="anmt310.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION anmt310_msgcentre_notify(lc_state)
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
   CALL anmt310_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_nmba_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="anmt310.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION anmt310_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="anmt310.other_function" readonly="Y" >}
# nmbb002存提碼欄位檢查
PRIVATE FUNCTION anmt310_nmbb002_chk()
   DEFINE l_nmajstus               LIKE nmaj_t.nmajstus
   DEFINE l_glaa005                LIKE glaa_t.glaa005
   
   LET g_errno = ''
   CALL cl_set_comp_entry('nmbb004',TRUE)  #币别   #160120-00029#1 add
   IF g_nmbb_d[l_ac].nmbb001 <> '1' AND g_nmbb_d[l_ac].nmbb001 <> '2' THEN
      SELECT nmajstus INTO l_nmajstus
        FROM nmaj_t
       WHERE nmajent = g_enterprise
         AND nmaj001 = g_nmbb_d[l_ac].nmbb002
         
      #CALL cl_set_comp_entry('nmbb004',TRUE)  #币别   #160120-00029#1 add    #161026-00004#1 mark
   ELSE
      SELECT nmajstus INTO l_nmajstus
        FROM nmaj_t
       WHERE nmajent = g_enterprise
         AND nmaj001 = g_nmbb_d[l_ac].nmbb002
         AND nmaj002 = g_nmbb_d[l_ac].nmbb001
         
      #CALL cl_set_comp_entry('nmbb004',FALSE)  #币别  #160120-00029#1 add   #161026-00004#1 mark
   END IF 
   
   CASE
      WHEN SQLCA.SQLCODE = 100    LET g_errno = 'anm-00017'
      WHEN l_nmajstus = 'N'       LET g_errno = 'anm-00016'
   END CASE
   #161026-00004#1 add s---
   IF g_nmbb_d[l_ac].nmbb001 <> '1' AND g_nmbb_d[l_ac].nmbb001 <> '2' THEN
      CALL cl_set_comp_entry('nmbb004',TRUE)
   ELSE
      CALL cl_set_comp_entry('nmbb004',FALSE)
   END IF   
   #161026-00004#1 add e---
   
   #帶值
   SELECT glaa005 INTO l_glaa005
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaacomp = g_nmba_m.nmbacomp
      AND glaa014 = 'Y'
      
   IF cl_null(g_nmbb_d[l_ac].nmbb010) THEN    
      SELECT nmad003 INTO g_nmbb_d[l_ac].nmbb010
        FROM nmad_t
       WHERE nmadent = g_enterprise
         AND nmad001 = l_glaa005
         AND nmad002 = g_nmbb_d[l_ac].nmbb002
      DISPLAY g_nmbb_d[l_ac].nmbb010 TO s_detail1[l_ac].nmbb010
   END IF 
   
   CALL anmt310_ref_b()
   
END FUNCTION
# nmbasite 資金中心欄位檢查
PRIVATE FUNCTION anmt310_nmbasite_chk()
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
# nmba002帳務人員欄位檢查
PRIVATE FUNCTION anmt310_nmba002_chk(p_nmba002)
   DEFINE l_ooagstus  LIKE ooag_t.ooagstus
   DEFINE p_nmba002   LIKE nmba_t.nmba002

   LET g_errno=''
   SELECT ooagstus INTO l_ooagstus FROM ooag_t
    WHERE ooagent = g_enterprise
      AND ooag001 = p_nmba002

   CASE
      WHEN SQLCA.SQLCODE=100   LET g_errno = 'aoo-00074'
      WHEN l_ooagstus ='N'     LET g_errno = 'sub-01302' #aoo-00071   #160318-00005#27 by 07900 --mod 
   END CASE
END FUNCTION
# nmba004交易對象欄位檢查
PRIVATE FUNCTION anmt310_nmba004_chk(l_nmba004)
   DEFINE l_pmaastus         LIKE pmaa_t.pmaastus
   DEFINE l_n                LIKE type_t.num5
   DEFINE l_pmaa004          LIKE pmaa_t.pmaa004
   DEFINE l_nmba004          LIKE nmba_t.nmba004
   
   LET g_errno = ''
   
   SELECT pmaa004 INTO l_pmaa004
     FROM pmaa_t
    WHERE pmaaent = g_enterprise
      AND pmaa001 = l_nmba004
   
   LET l_n = 0
   SELECT count(*) INTO l_n
     FROM pmaa_t
    WHERE pmaaent = g_enterprise
      AND pmaa001 = l_nmba004
   IF l_n = 0 THEN 
      LET g_errno = 'ais-00019'
      RETURN 
   ELSE
      LET l_n = 0 
      SELECT count(*) INTO l_n 
        FROM pmaa_t
       WHERE pmaaent = g_enterprise
         AND pmaa001 = l_nmba004
         AND pmaastus = 'Y'
         
      IF l_n = 0 THEN 
         LET g_errno = 'ais-00020'
         RETURN 
      END IF 
   END IF

   IF l_pmaa004 = '2' OR l_pmaa004 = '4' THEN 
      INITIALIZE g_qryparam.* TO NULL
      LET g_qryparam.state = 'i'
	   LET g_qryparam.reqry = FALSE
      LET g_qryparam.arg1 = l_nmba004
      #給予arg
   
      CALL q_pmak002()                                #呼叫開窗
   
      LET g_nmba_m.nmba005 = g_qryparam.return1   
   ELSE
      LET g_nmba_m.nmba005 = ''
   END IF    
   
   IF cl_null(g_nmba_m.nmba005) THEN 
      IF l_pmaa004 = '2' THEN   #一次性交易對象
         CALL apmi004_01('1','',g_nmba_m.nmba004,g_nmba_m.nmbadocno) RETURNING g_nmba_m.nmba005
      END IF
      IF l_pmaa004 = '4' THEN   #內部員工
         CALL apmi004_01('2','',g_nmba_m.nmba004,g_nmba_m.nmbadocno) RETURNING g_nmba_m.nmba005
      END IF
   END IF      
END FUNCTION
# nmbadocno收支單別欄位檢查
PRIVATE FUNCTION anmt310_nmbadocno_chk()
  DEFINE l_n             LIKE type_t.num5   
      
   #判斷資料是否存在   
   LET l_n = 0   
   SELECT count(*) INTO l_n
     FROM ooba_t
    WHERE oobaent = g_enterprise
      AND ooba001 = g_glaa024
      AND ooba004 = 'anmt310' 
      AND ooba002 = g_nmba_m.nmbadocno  
      
   IF l_n = 0 THEN 
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
     FROM ooba_t
    WHERE oobaent = g_enterprise
      AND ooba001 = g_glaa024
      AND ooba004 = 'anmt310' 
      AND ooba002 = g_nmba_m.nmbadocno  
      AND oobastus = 'Y'
   
   IF l_n = 0 THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-01302' #aim-00057  #160318-00005#27 by 07900 --mod
      LET g_errparam.extend = g_nmba_m.nmbadocno
      #160318-00005#27 by 07900 --add--str
      LET g_errparam.replace[1] = 'aooi200'
      LET g_errparam.replace[2] = cl_get_progname("aooi200",g_lang,"2")
      LET g_errparam.exeprog ='aooi200'
      #160318-00005#27 by 07900 --add--end
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE
   END IF
   
   RETURN TRUE
END FUNCTION
# nmbb003交易帳戶編碼欄位檢查
PRIVATE FUNCTION anmt310_nmbb003_chk()
   DEFINE l_nmaastus            LIKE nmaa_t.nmaastus
   DEFINE l_nmaa003             LIKE nmaa_t.nmaa003
   DEFINE l_nmag002             LIKE nmag_t.nmag002
   DEFINE l_ooab002             LIKE ooab_t.ooab002

   LET g_errno = ''
   
   SELECT nmaastus,nmaa003,nmas003 INTO l_nmaastus,l_nmaa003,g_nmbb_d[l_ac].nmbb004
     FROM nmaa_t,nmas_t
    WHERE nmaaent = g_enterprise
      AND nmaaent = nmasent
      AND nmaa001 = nmas001
      AND nmas002 = g_nmbb_d[l_ac].nmbb003
      AND nmaa002 IN (select ooef001 FROM ooef_t WHERE ooefent = g_enterprise
                                               AND ooef017 = g_nmba_m.nmbacomp)
      
   CASE
      WHEN SQLCA.SQLCODE = 100    LET g_errno = 'anm-00026'
      WHEN l_nmaastus = 'N'       LET g_errno = 'sub-01302' #anm-00027  #160318-00005#27  By 07900 --mod
   END CASE

   SELECT nmag002 INTO l_nmag002
     FROM nmag_t 
    WHERE nmagent = g_enterprise  #2015/03/31 add by 02599
      AND nmag001 = l_nmaa003 
      AND nmagstus = 'Y'
    
   IF l_nmag002 = '5' THEN
      LET g_nmbb_d[l_ac].nmbb029 = '10'  #現金
   ELSE
      LET g_nmbb_d[l_ac].nmbb029 = '20'  #電匯
   END IF 
 
END FUNCTION
# nmbb幣別欄位檢查
PRIVATE FUNCTION anmt310_nmbb004_chk()
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
# nmbb010現金變動碼欄位檢查
PRIVATE FUNCTION anmt310_nmbb010_chk()
   DEFINE l_nmaistus         LIKE nmai_t.nmaistus
   DEFINE l_glaa005          LIKE glaa_t.glaa005
   
   LET g_errno = ''
    #帶值
   SELECT glaa005 INTO l_glaa005
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaacomp = g_nmba_m.nmbacomp
      AND glaa014 = 'Y'
      
   SELECT nmaistus INTO l_nmaistus
     FROM nmai_t
    WHERE nmaient = g_enterprise
      AND nmai001 = l_glaa005
      AND nmai002 = g_nmbb_d[l_ac].nmbb010
      
   CASE
      WHEN SQLCA.SQLCODE = 100    LET g_errno = 'anm-00034'
      WHEN l_nmaistus = 'N'       LET g_errno = 'anm-00035'
   END CASE
END FUNCTION
# nmbb054繳款部門欄位檢查
PRIVATE FUNCTION anmt310_nmbb054_chk()
   DEFINE l_ooefstus     LIKE ooef_t.ooefstus
   
   LET g_errno = ''
   
   SELECT ooefstus INTO l_ooefstus FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_nmbb_d[l_ac].nmbb054
      
   CASE
      WHEN SQLCA.SQLCODE = 100    LET g_errno = 'aoo-00090'
      WHEN l_ooefstus = 'N'       LET g_errno = 'sub-01302' #aoo-00091  #160318-00005#27 by 07900 --mod
   END CASE
END FUNCTION
# 單身參考欄位帶值
PRIVATE FUNCTION anmt310_ref_b()
   DEFINE l_glaa005                LIKE glaa_t.glaa005
   DEFINE l_nmas001                LIKE nmas_t.nmas001
   DEFINE l_nmas002                LIKE nmas_t.nmas002
   
   LET l_glaa005 = ''   #160822-00012#5   add
   SELECT glaa005 INTO l_glaa005
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaacomp = g_nmba_m.nmbacomp
      AND glaa014 = 'Y'
      
   LET g_nmbb_d[l_ac].nmbb053_desc = ''
   LET g_nmbb_d[l_ac].nmbb003_desc = ''   #160822-00012#5   add
  #--150603-00041#1--mark--(s)
  #SELECT oofa011 INTO g_nmbb_d[l_ac].nmbb053_desc
  #  FROM oofa_t
  # WHERE oofaent = g_enterprise
  #   AND oofa001 IN (SELECT ooag002 FROM ooag_t
  #                     WHERE ooagent = g_enterprise
  #                       AND ooag001 = g_nmbb_d[l_ac].nmbb053)
  #--150603-00041#1--mark--(e)                          
   LET g_nmbb_d[l_ac].nmbb053_desc = s_desc_get_person_desc(g_nmbb_d[l_ac].nmbb053)  #150603-00041#1
   DISPLAY g_nmbb_d[l_ac].nmbb053_desc TO nmbb053_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_nmbb_d[l_ac].nmbb054
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_nmbb_d[l_ac].nmbb054_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_nmbb_d[l_ac].nmbb054_desc
   
   #160509-0004--str--
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_nmbb_d[l_ac].nmbb070
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_nmbb_d[l_ac].nmbb070_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_nmbb_d[l_ac].nmbb070_desc
   #160509-0004--end--
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_nmbb_d[l_ac].nmbborga
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_nmbb_d[l_ac].nmbborga_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_nmbb_d[l_ac].nmbborga_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_nmbb_d[l_ac].nmbb002
   CALL ap_ref_array2(g_ref_fields,"SELECT nmajl003 FROM nmajl_t WHERE nmajlent='"||g_enterprise||"' AND nmajl001=? AND nmajl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_nmbb_d[l_ac].nmbb002_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_nmbb_d[l_ac].nmbb002_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_nmbb_d[l_ac].nmbb010
   LET g_ref_fields[2] = l_glaa005
   CALL ap_ref_array2(g_ref_fields,"SELECT nmail004 FROM nmail_t WHERE nmailent='"||g_enterprise||"' AND nmail002=? AND nmail001 = ? AND nmail003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_nmbb_d[l_ac].nmbb010_desc = '', g_rtn_fields[1] , ''
   DISPLAY g_nmbb_d[l_ac].nmbb010_desc TO s_detail1[l_ac].nmbb010_desc
   
   #150714-00024#1 mark ------
   #SELECT nmas001 INTO l_nmas001 
   #  FROM nmas_t
   # WHERE nmasent = g_enterprise
   #   AND nmas002 = g_nmbb_d[l_ac].nmbb003
   #INITIALIZE g_ref_fields TO NULL
   #LET g_ref_fields[1] = l_nmas001
   #CALL ap_ref_array2(g_ref_fields,"SELECT nmaal003 FROM nmaal_t WHERE nmaalent='"||g_enterprise||"' AND nmaal001=? AND nmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   #LET g_nmbb_d[l_ac].nmbb003_desc = '', g_rtn_fields[1] , ''
   #DISPLAY BY NAME g_nmbb_d[l_ac].nmbb003_desc
   #150714-00024#1 mark end---
   LET g_nmbb_d[l_ac].nmbb003_desc = s_desc_get_nmas002_desc(g_nmbb_d[l_ac].nmbb003)   #150714-00024#1
END FUNCTION
# nmbacomp 法人組織檢查
PRIVATE FUNCTION anmt310_nmbacomp_chk()
   DEFINE l_ooefstus         LIKE ooef_t.ooefstus
   DEFINE l_ooef003          LIKE ooef_t.ooef003
   
   LET g_errno = ''
   SELECT ooefstus,ooef003 INTO l_ooefstus,l_ooef003
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_nmba_m.nmbacomp
   
   CASE
      WHEN SQLCA.SQLCODE = 100    LET g_errno = 'aoo-00090'
      WHEN l_ooefstus = 'N'       LET g_errno = 'sub-01302' #aoo-00091  #160318-00005#27 by 07900 --mod
      WHEN l_ooef003 = 'N'        LET g_errno = 'anm-00037'
   END CASE
END FUNCTION
# 第二個單身
PRIVATE FUNCTION anmt310_b_fill_2()
   
   CALL g_nmbb2_d.clear()    #g_nmbb_d 單頭及單身 
   
   LET g_sql = "SELECT nmbb011,nmbb012,nmbb013,nmbb014,nmbb015,nmbb016,nmbb017,nmbb018 FROM nmbb_t",   
               " INNER JOIN nmba_t ON nmbacomp = nmbbcomp ",
               " AND nmbadocno = nmbbdocno ",
               " WHERE nmbbent=? AND nmbbcomp=? AND nmbbdocno=?"
      
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
   END IF 
   
   LET g_sql = g_sql, " ORDER BY nmbb_t.nmbbseq"
   
   PREPARE anmt310_pb1 FROM g_sql
   DECLARE b_fill_cs1 CURSOR FOR anmt310_pb1
   
   LET g_cnt = l_ac
   LET l_ac = 1
   
   OPEN b_fill_cs1 USING g_enterprise,g_nmba_m.nmbacomp
                                            ,g_nmba_m.nmbadocno
   
   FOREACH b_fill_cs1 INTO g_nmbb2_d[l_ac].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
     
   
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
   
   FREE anmt310_pb1
END FUNCTION
# 第三單身填充
PRIVATE FUNCTION anmt310_b_fill_3()
   CALL g_nmbb3_d.clear()    #g_nmbb_d 單頭及單身 
   
   LET g_sql = "SELECT UNIQUE nmbbseq,nmbb008,nmbb009,nmbb019,nmbb020,nmbb021,nmbb022,nmbb023,nmbb024 FROM nmbb_t",   
               " INNER JOIN nmba_t ON nmbacomp = nmbbcomp ",
               " AND nmbadocno = nmbbdocno ",
               " WHERE nmbbent=? AND nmbbcomp=? AND nmbbdocno=?"
      
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
   END IF 
   
   LET g_sql = g_sql, " ORDER BY nmbb_t.nmbbseq"
   
   PREPARE anmt310_pb2 FROM g_sql
   DECLARE b_fill_cs2 CURSOR FOR anmt310_pb2
   
   LET g_cnt = l_ac
   LET l_ac = 1
   
   OPEN b_fill_cs2 USING g_enterprise,g_nmba_m.nmbacomp
                                            ,g_nmba_m.nmbadocno
   
   FOREACH b_fill_cs2 INTO g_nmbb3_d[l_ac].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
     
   
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
   
   CALL g_nmbb3_d.deleteElement(g_nmbb3_d.getLength())

   

   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE anmt310_pb2
END FUNCTION
# 審核
PRIVATE FUNCTION anmt310_conf()
DEFINE l_ooab002          LIKE ooab_t.ooab002
DEFINE l_nmbbseq          LIKE nmbb_t.nmbbseq
DEFINE l_nmbb001          LIKE nmbb_t.nmbb001
DEFINE l_nmbb002          LIKE nmbb_t.nmbb002
DEFINE l_nmbb003          LIKE nmbb_t.nmbb003
DEFINE l_nmbb004          LIKE nmbb_t.nmbb004
DEFINE l_nmbb005          LIKE nmbb_t.nmbb005
DEFINE l_nmbb007          LIKE nmbb_t.nmbb007
DEFINE l_nmbb013          LIKE nmbb_t.nmbb013
DEFINE l_nmbb017          LIKE nmbb_t.nmbb017
DEFINE l_glbc009          LIKE glbc_t.glbc009
DEFINE l_glbc012          LIKE glbc_t.glbc012
DEFINE l_glbc014          LIKE glbc_t.glbc014
DEFINE l_year             LIKE type_t.num5
DEFINE l_month            LIKE type_t.num5
   
   LET l_year = YEAR(g_nmba_m.nmbadocdt)
   LET l_month = MONTH(g_nmba_m.nmbadocdt)
   
   LET g_sql = "SELECT nmbbseq,nmbb001,nmbb002,nmbb003,nmbb004,",
               "       nmbb005,nmbb007,nmbb013,nmbb017 ",
               "  FROM nmbb_t ",
               " WHERE nmbbent = ",g_enterprise,
               "   AND nmbbcomp = '",g_nmba_m.nmbacomp,"'",
               "   AND nmbbdocno = '",g_nmba_m.nmbadocno,"'"
   PREPARE anmt310_pre FROM g_sql
   DECLARE anmt310_cs CURSOR FOR anmt310_pre
   FOREACH anmt310_cs INTO l_nmbbseq,l_nmbb001,l_nmbb002,l_nmbb003,l_nmbb004,
                           l_nmbb005,l_nmbb007,l_nmbb013,l_nmbb017
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
   
      #異動別.存提碼.交易帳戶編碼.幣別.匯率.不可空白
      #150803-00018#1 add ------
      IF NOT cl_null(l_nmbb001) THEN
         CASE
            WHEN l_nmbb001 = '3' OR l_nmbb001 = '4'
               IF cl_null(l_nmbb001) OR cl_null(l_nmbb002) OR
                  cl_null(l_nmbb004) OR cl_null(l_nmbb005) THEN
                  LET g_success = 'N'
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'anm-02948'
                  LET g_errparam.extend = l_nmbbseq
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
               END IF
            OTHERWISE
               IF cl_null(l_nmbb001) OR cl_null(l_nmbb002) OR
                  cl_null(l_nmbb003) OR cl_null(l_nmbb004) OR
                  cl_null(l_nmbb005) THEN
                  LET g_success = 'N'
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'anm-00041'
                  LET g_errparam.extend = l_nmbbseq
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
               END IF
         END CASE
      ELSE
      #150803-00018#1 add end---
         IF cl_null(l_nmbb001) OR cl_null(l_nmbb002)
            OR cl_null(l_nmbb003) OR cl_null(l_nmbb004)
            OR cl_null(l_nmbb005) THEN
            LET g_success = 'N'
            #CALL cl_errmsg(l_nmbbseq,g_nmba_m.nmbadocno,'','anm-00041',1)
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'anm-02947'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] = l_nmbbseq
            CALL cl_err()
         END IF
      END IF #150803-00018#1
      
      #本幣金額不可為
      IF l_nmbb007 <= 0 THEN 
         LET g_success = 'N'
         #CALL cl_errmsg(l_nmbbseq,g_nmba_m.nmbadocno,'','anm-00042',1)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'anm-00042'
         LET g_errparam.extend = l_nmbbseq
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END IF 
      
      IF l_nmbb001 = '1' OR l_nmbb001 = '2' THEN
         SELECT SUM(glbc009),SUM(glbc012),SUM(glbc014)
           INTO l_glbc009,l_glbc012,l_glbc014
           FROM glbc_t
          WHERE glbcent=g_enterprise AND glbcld=g_glaald
            AND glbcdocno=g_nmba_m.nmbadocno AND glbc001=l_year
            AND glbc002=l_month
            AND glbcseq = l_nmbbseq
            
         IF l_glbc009<>l_nmbb007 THEN
            LET g_success = 'N'
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'anm-00146'
            LET g_errparam.extend = l_nmbbseq
            LET g_errparam.popup = TRUE
            CALL cl_err()
         END IF
         IF g_glaa015='Y' AND l_glbc012<>l_nmbb013 THEN
            LET g_success = 'N'
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'anm-00147'
            LET g_errparam.extend = l_nmbbseq
            LET g_errparam.popup = TRUE
            CALL cl_err()
         END IF
         IF g_glaa019='Y' AND l_glbc014<>l_nmbb017 THEN
            LET g_success = 'N'
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'anm-00148'
            LET g_errparam.extend = l_nmbbseq
            LET g_errparam.popup = TRUE
            CALL cl_err()
         END IF
      END IF 
   END FOREACH 

   #收支日期是否小於資金模塊關帳日期
   LET l_ooab002 = ''
   SELECT ooab002 INTO l_ooab002
     FROM ooab_t
    WHERE ooabent = g_enterprise
      AND ooab001 = 'S-FIN-4002'
      AND ooabsite = g_nmba_m.nmbacomp
   IF g_nmba_m.nmbadocdt < l_ooab002 THEN
      LET g_success = 'N'
      #CALL cl_errmsg('',g_nmba_m.nmbadocno,'','anm-00036',1)
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'anm-00036'
      LET g_errparam.extend = g_nmba_m.nmbadocno
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF 
END FUNCTION
# 寫入銀存收支異動檔 nmbc_t
PRIVATE FUNCTION anmt310_nmbc_insert()
  #DEFINE l_nmbc   RECORD   LIKE nmbc_t.*  #161219-00014#2--mark--
   #161219-00014#2--add--s--
   DEFINE l_nmbc RECORD  #銀存收支異動檔
       nmbcent LIKE nmbc_t.nmbcent, #企业编号
       nmbcownid LIKE nmbc_t.nmbcownid, #资料所有者
       nmbcowndp LIKE nmbc_t.nmbcowndp, #资料所有部门
       nmbccrtid LIKE nmbc_t.nmbccrtid, #资料录入者
       nmbccrtdp LIKE nmbc_t.nmbccrtdp, #资料录入部门
       nmbccrtdt LIKE nmbc_t.nmbccrtdt, #资料创建日
       nmbcmodid LIKE nmbc_t.nmbcmodid, #资料更改者
       nmbcmoddt LIKE nmbc_t.nmbcmoddt, #最近更改日
       nmbccnfid LIKE nmbc_t.nmbccnfid, #资料审核者
       nmbccnfdt LIKE nmbc_t.nmbccnfdt, #数据审核日
       nmbcpstid LIKE nmbc_t.nmbcpstid, #资料过账者
       nmbcpstdt LIKE nmbc_t.nmbcpstdt, #资料过账日
       nmbcstus LIKE nmbc_t.nmbcstus, #状态码
       nmbccomp LIKE nmbc_t.nmbccomp, #法人
       nmbcsite LIKE nmbc_t.nmbcsite, #资金中心
       nmbcdocno LIKE nmbc_t.nmbcdocno, #来源单号
       nmbcseq LIKE nmbc_t.nmbcseq, #项次
       nmbc001 LIKE nmbc_t.nmbc001, #单据来源
       nmbc002 LIKE nmbc_t.nmbc002, #交易账户编码
       nmbc003 LIKE nmbc_t.nmbc003, #交易对象
       nmbc004 LIKE nmbc_t.nmbc004, #交易对象识别码
       nmbc005 LIKE nmbc_t.nmbc005, #银行日期
       nmbc006 LIKE nmbc_t.nmbc006, #异动别
       nmbc007 LIKE nmbc_t.nmbc007, #存提码
       nmbc008 LIKE nmbc_t.nmbc008, #调节码
       nmbc009 LIKE nmbc_t.nmbc009, #对账码
       nmbc010 LIKE nmbc_t.nmbc010, #网银媒体档转出日期
       nmbc011 LIKE nmbc_t.nmbc011, #网银媒体档转出批号
       nmbc100 LIKE nmbc_t.nmbc100, #交易帐户币种
       nmbc101 LIKE nmbc_t.nmbc101, #主账套汇率
       nmbc103 LIKE nmbc_t.nmbc103, #主账套原币金额
       nmbc113 LIKE nmbc_t.nmbc113, #主账套本币金额
       nmbc121 LIKE nmbc_t.nmbc121, #主账套本位币二汇率
       nmbc123 LIKE nmbc_t.nmbc123, #主账套本位币二金额
       nmbc131 LIKE nmbc_t.nmbc131, #主账套本位币三汇率
       nmbc133 LIKE nmbc_t.nmbc133, #主账套本位币三金额
       nmbcud001 LIKE nmbc_t.nmbcud001, #自定义字段(文本)001
       nmbcud002 LIKE nmbc_t.nmbcud002, #自定义字段(文本)002
       nmbcud003 LIKE nmbc_t.nmbcud003, #自定义字段(文本)003
       nmbcud004 LIKE nmbc_t.nmbcud004, #自定义字段(文本)004
       nmbcud005 LIKE nmbc_t.nmbcud005, #自定义字段(文本)005
       nmbcud006 LIKE nmbc_t.nmbcud006, #自定义字段(文本)006
       nmbcud007 LIKE nmbc_t.nmbcud007, #自定义字段(文本)007
       nmbcud008 LIKE nmbc_t.nmbcud008, #自定义字段(文本)008
       nmbcud009 LIKE nmbc_t.nmbcud009, #自定义字段(文本)009
       nmbcud010 LIKE nmbc_t.nmbcud010, #自定义字段(文本)010
       nmbcud011 LIKE nmbc_t.nmbcud011, #自定义字段(数字)011
       nmbcud012 LIKE nmbc_t.nmbcud012, #自定义字段(数字)012
       nmbcud013 LIKE nmbc_t.nmbcud013, #自定义字段(数字)013
       nmbcud014 LIKE nmbc_t.nmbcud014, #自定义字段(数字)014
       nmbcud015 LIKE nmbc_t.nmbcud015, #自定义字段(数字)015
       nmbcud016 LIKE nmbc_t.nmbcud016, #自定义字段(数字)016
       nmbcud017 LIKE nmbc_t.nmbcud017, #自定义字段(数字)017
       nmbcud018 LIKE nmbc_t.nmbcud018, #自定义字段(数字)018
       nmbcud019 LIKE nmbc_t.nmbcud019, #自定义字段(数字)019
       nmbcud020 LIKE nmbc_t.nmbcud020, #自定义字段(数字)020
       nmbcud021 LIKE nmbc_t.nmbcud021, #自定义字段(日期时间)021
       nmbcud022 LIKE nmbc_t.nmbcud022, #自定义字段(日期时间)022
       nmbcud023 LIKE nmbc_t.nmbcud023, #自定义字段(日期时间)023
       nmbcud024 LIKE nmbc_t.nmbcud024, #自定义字段(日期时间)024
       nmbcud025 LIKE nmbc_t.nmbcud025, #自定义字段(日期时间)025
       nmbcud026 LIKE nmbc_t.nmbcud026, #自定义字段(日期时间)026
       nmbcud027 LIKE nmbc_t.nmbcud027, #自定义字段(日期时间)027
       nmbcud028 LIKE nmbc_t.nmbcud028, #自定义字段(日期时间)028
       nmbcud029 LIKE nmbc_t.nmbcud029, #自定义字段(日期时间)029
       nmbcud030 LIKE nmbc_t.nmbcud030, #自定义字段(日期时间)030
       nmbc012 LIKE nmbc_t.nmbc012, #票据号码
       nmbc013 LIKE nmbc_t.nmbc013, #款别
       nmbc014 LIKE nmbc_t.nmbc014, #到期日
       nmbc015 LIKE nmbc_t.nmbc015, #导入银行编号
       nmbc016 LIKE nmbc_t.nmbc016, #导入帐号
       nmbc017 LIKE nmbc_t.nmbc017, #受款人全名
       nmbcorga LIKE nmbc_t.nmbcorga #来源组织
       END RECORD
   #161219-00014#2--add--e--
  #DEFINE l_nmbb   RECORD   LIKE nmbb_t.*  #161219-00014#2--mark--
   #161219-00014#2--add--s--
   DEFINE l_nmbb RECORD  #銀存收支明細檔
       nmbbent LIKE nmbb_t.nmbbent, #企业编号
       nmbbcomp LIKE nmbb_t.nmbbcomp, #法人
       nmbbdocno LIKE nmbb_t.nmbbdocno, #收支单号
       nmbbseq LIKE nmbb_t.nmbbseq, #项次
       nmbborga LIKE nmbb_t.nmbborga, #来源组织
       nmbblegl LIKE nmbb_t.nmbblegl, #核算组织
       nmbb001 LIKE nmbb_t.nmbb001, #异动别
       nmbb002 LIKE nmbb_t.nmbb002, #存提码
       nmbb003 LIKE nmbb_t.nmbb003, #交易账户编码
       nmbb004 LIKE nmbb_t.nmbb004, #币种
       nmbb005 LIKE nmbb_t.nmbb005, #汇率
       nmbb006 LIKE nmbb_t.nmbb006, #主账套原币金额
       nmbb007 LIKE nmbb_t.nmbb007, #主账套本币金额
       nmbb008 LIKE nmbb_t.nmbb008, #主账套已冲原币金额
       nmbb009 LIKE nmbb_t.nmbb009, #主账套已冲本币金额
       nmbb010 LIKE nmbb_t.nmbb010, #现金变动码
       nmbb011 LIKE nmbb_t.nmbb011, #本位币二币种
       nmbb012 LIKE nmbb_t.nmbb012, #本位币二汇率
       nmbb013 LIKE nmbb_t.nmbb013, #本位币二金额
       nmbb014 LIKE nmbb_t.nmbb014, #本位币二已冲金额
       nmbb015 LIKE nmbb_t.nmbb015, #本位币三币种
       nmbb016 LIKE nmbb_t.nmbb016, #本位币三汇率
       nmbb017 LIKE nmbb_t.nmbb017, #本位币三金额
       nmbb018 LIKE nmbb_t.nmbb018, #本位币三已冲金额
       nmbb019 LIKE nmbb_t.nmbb019, #辅助账套一汇率
       nmbb020 LIKE nmbb_t.nmbb020, #辅助账套一原币已冲
       nmbb021 LIKE nmbb_t.nmbb021, #辅助账套一本币已冲
       nmbb022 LIKE nmbb_t.nmbb022, #辅助账套二汇率
       nmbb023 LIKE nmbb_t.nmbb023, #辅助账套二原币已冲
       nmbb024 LIKE nmbb_t.nmbb024, #辅助账套二本币已冲
       nmbb025 LIKE nmbb_t.nmbb025, #备注
       nmbb026 LIKE nmbb_t.nmbb026, #交易对象
       nmbb027 LIKE nmbb_t.nmbb027, #一次性交易对象识别码
       nmbb028 LIKE nmbb_t.nmbb028, #款别编码
       nmbb029 LIKE nmbb_t.nmbb029, #款别分类
       nmbb030 LIKE nmbb_t.nmbb030, #票据号码
       nmbb031 LIKE nmbb_t.nmbb031, #到期日
       nmbb032 LIKE nmbb_t.nmbb032, #有价券数量
       nmbb033 LIKE nmbb_t.nmbb033, #有价券面额
       nmbb034 LIKE nmbb_t.nmbb034, #有价券起始编号
       nmbb035 LIKE nmbb_t.nmbb035, #有价券结束编号
       nmbb036 LIKE nmbb_t.nmbb036, #刷卡银行
       nmbb037 LIKE nmbb_t.nmbb037, #信用卡卡号
       nmbb038 LIKE nmbb_t.nmbb038, #手续费
       nmbb039 LIKE nmbb_t.nmbb039, #第三方代收机构
       nmbb040 LIKE nmbb_t.nmbb040, #背书转入
       nmbb041 LIKE nmbb_t.nmbb041, #发票人全名
       nmbb042 LIKE nmbb_t.nmbb042, #票况
       nmbb043 LIKE nmbb_t.nmbb043, #票据付款银行
       nmbb044 LIKE nmbb_t.nmbb044, #票面利率种类
       nmbb045 LIKE nmbb_t.nmbb045, #票面利率百分比
       nmbb046 LIKE nmbb_t.nmbb046, #转付交易对象
       nmbb047 LIKE nmbb_t.nmbb047, #票据流通期间
       nmbb048 LIKE nmbb_t.nmbb048, #贴现利率种类
       nmbb049 LIKE nmbb_t.nmbb049, #贴现利率
       nmbb050 LIKE nmbb_t.nmbb050, #贴现期间
       nmbb051 LIKE nmbb_t.nmbb051, #贴现拨款原币金额
       nmbb052 LIKE nmbb_t.nmbb052, #贴现拨款本币金额
       nmbb053 LIKE nmbb_t.nmbb053, #缴款人员
       nmbb054 LIKE nmbb_t.nmbb054, #缴款部门
       nmbb055 LIKE nmbb_t.nmbb055, #POS缴款单号
       nmbb056 LIKE nmbb_t.nmbb056, #入账汇率
       nmbb057 LIKE nmbb_t.nmbb057, #入账原币金额
       nmbb058 LIKE nmbb_t.nmbb058, #入账主账套本币金额
       nmbb059 LIKE nmbb_t.nmbb059, #入账主账套本位币二汇率
       nmbb060 LIKE nmbb_t.nmbb060, #入账主账套本位币二金额
       nmbb061 LIKE nmbb_t.nmbb061, #入账主账套本位币三汇率
       nmbb062 LIKE nmbb_t.nmbb062, #入账主账套本位币三金额
       nmbb063 LIKE nmbb_t.nmbb063, #对方会科
       nmbb064 LIKE nmbb_t.nmbb064, #差异处理状态
       nmbb065 LIKE nmbb_t.nmbb065, #开票日期
       nmbb066 LIKE nmbb_t.nmbb066, #重评后本币金额
       nmbb067 LIKE nmbb_t.nmbb067, #重评后本位币二金额
       nmbb068 LIKE nmbb_t.nmbb068, #重评后本位币三金额
       nmbb069 LIKE nmbb_t.nmbb069, #质押否
       nmbbud001 LIKE nmbb_t.nmbbud001, #自定义字段(文本)001
       nmbbud002 LIKE nmbb_t.nmbbud002, #自定义字段(文本)002
       nmbbud003 LIKE nmbb_t.nmbbud003, #自定义字段(文本)003
       nmbbud004 LIKE nmbb_t.nmbbud004, #自定义字段(文本)004
       nmbbud005 LIKE nmbb_t.nmbbud005, #自定义字段(文本)005
       nmbbud006 LIKE nmbb_t.nmbbud006, #自定义字段(文本)006
       nmbbud007 LIKE nmbb_t.nmbbud007, #自定义字段(文本)007
       nmbbud008 LIKE nmbb_t.nmbbud008, #自定义字段(文本)008
       nmbbud009 LIKE nmbb_t.nmbbud009, #自定义字段(文本)009
       nmbbud010 LIKE nmbb_t.nmbbud010, #自定义字段(文本)010
       nmbbud011 LIKE nmbb_t.nmbbud011, #自定义字段(数字)011
       nmbbud012 LIKE nmbb_t.nmbbud012, #自定义字段(数字)012
       nmbbud013 LIKE nmbb_t.nmbbud013, #自定义字段(数字)013
       nmbbud014 LIKE nmbb_t.nmbbud014, #自定义字段(数字)014
       nmbbud015 LIKE nmbb_t.nmbbud015, #自定义字段(数字)015
       nmbbud016 LIKE nmbb_t.nmbbud016, #自定义字段(数字)016
       nmbbud017 LIKE nmbb_t.nmbbud017, #自定义字段(数字)017
       nmbbud018 LIKE nmbb_t.nmbbud018, #自定义字段(数字)018
       nmbbud019 LIKE nmbb_t.nmbbud019, #自定义字段(数字)019
       nmbbud020 LIKE nmbb_t.nmbbud020, #自定义字段(数字)020
       nmbbud021 LIKE nmbb_t.nmbbud021, #自定义字段(日期时间)021
       nmbbud022 LIKE nmbb_t.nmbbud022, #自定义字段(日期时间)022
       nmbbud023 LIKE nmbb_t.nmbbud023, #自定义字段(日期时间)023
       nmbbud024 LIKE nmbb_t.nmbbud024, #自定义字段(日期时间)024
       nmbbud025 LIKE nmbb_t.nmbbud025, #自定义字段(日期时间)025
       nmbbud026 LIKE nmbb_t.nmbbud026, #自定义字段(日期时间)026
       nmbbud027 LIKE nmbb_t.nmbbud027, #自定义字段(日期时间)027
       nmbbud028 LIKE nmbb_t.nmbbud028, #自定义字段(日期时间)028
       nmbbud029 LIKE nmbb_t.nmbbud029, #自定义字段(日期时间)029
       nmbbud030 LIKE nmbb_t.nmbbud030, #自定义字段(日期时间)030
       nmbb070 LIKE nmbb_t.nmbb070, #往来据点
       nmbb071 LIKE nmbb_t.nmbb071, #来源单号
       nmbb072 LIKE nmbb_t.nmbb072, #项次
       nmbb073 LIKE nmbb_t.nmbb073 #开票帐号
       END RECORD
   #161219-00014#2--add--e--
   #161219-00014#2--mark--s--
#   LET g_sql = "SELECT * FROM nmbb_t",
#               " WHERE nmbbent = '",g_enterprise,"'",
#               "   AND nmbbcomp = '",g_nmba_m.nmbacomp,"'",
#               "   AND nmbbdocno = '",g_nmba_m.nmbadocno,"'"
   #161219-00014#2--mark--e--
   #161219-00014#2--add--s--
   LET g_sql = "SELECT nmbbent,nmbbcomp,nmbbdocno,nmbbseq,nmbborga,nmbblegl,nmbb001,nmbb002,nmbb003,nmbb004,nmbb005,",
               " nmbb006,nmbb007,nmbb008,nmbb009,nmbb010,nmbb011,nmbb012,nmbb013,nmbb014,nmbb015,nmbb016,nmbb017,nmbb018,",
               " nmbb019,nmbb020,nmbb021,nmbb022,nmbb023,nmbb024,nmbb025,nmbb026,nmbb027,nmbb028,nmbb029,nmbb030,nmbb031,",
               " nmbb032,nmbb033,nmbb034,nmbb035,nmbb036,nmbb037,nmbb038,nmbb039,nmbb040,nmbb041,nmbb042,nmbb043,nmbb044,",
               " nmbb045,nmbb046,nmbb047,nmbb048,nmbb049,nmbb050,nmbb051,nmbb052,nmbb053,nmbb054,nmbb055,nmbb056,nmbb057,",
               " nmbb058,nmbb059,nmbb060,nmbb061,nmbb062,nmbb063,nmbb064,nmbb065,nmbb066,nmbb067,nmbb068,nmbb069,nmbbud001,",
               " nmbbud002,nmbbud003,nmbbud004,nmbbud005,nmbbud006,nmbbud007,nmbbud008,nmbbud009,nmbbud010,nmbbud011,nmbbud012,",
               " nmbbud013,nmbbud014,nmbbud015,nmbbud016,nmbbud017,nmbbud018,nmbbud019,nmbbud020,nmbbud021,nmbbud022,nmbbud023,",
               " nmbbud024,nmbbud025,nmbbud026,nmbbud027,nmbbud028,nmbbud029,nmbbud030,nmbb070,nmbb071,nmbb072,nmbb073 ",
               "   FROM nmbb_t",
               " WHERE nmbbent = '",g_enterprise,"'",
               "   AND nmbbcomp = '",g_nmba_m.nmbacomp,"'",
               "   AND nmbbdocno = '",g_nmba_m.nmbadocno,"'"
   #161219-00014#2--add--e--
   PREPARE anmt310_pre1 FROM g_sql
   DECLARE anmt310_cs1 CURSOR FOR anmt310_pre1
   
   FOREACH anmt310_cs1 INTO l_nmbb.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         
         EXIT FOREACH
      END IF
      
      IF l_nmbb.nmbb001 <> '1' AND l_nmbb.nmbb001 <> '2' THEN
         CONTINUE FOREACH 
      END IF 
      
      LET l_nmbc.nmbcent = g_enterprise
      LET l_nmbc.nmbccomp = l_nmbb.nmbbcomp
      LET l_nmbc.nmbcsite = g_nmba_m.nmbasite
      LET l_nmbc.nmbcdocno = l_nmbb.nmbbdocno
      LET l_nmbc.nmbcseq = l_nmbb.nmbbseq
      LET l_nmbc.nmbc001 = 'anmt310'
      LET l_nmbc.nmbc002 = l_nmbb.nmbb003
      LET l_nmbc.nmbc003 = g_nmba_m.nmba004
      LET l_nmbc.nmbc004 = g_nmba_m.nmba005
      LET l_nmbc.nmbc005 = g_nmba_m.nmbadocdt
      LET l_nmbc.nmbc006 = l_nmbb.nmbb001
      LET l_nmbc.nmbc007 = l_nmbb.nmbb002
      LET l_nmbc.nmbc008 = ''
      LET l_nmbc.nmbc009 = ''
      LET l_nmbc.nmbc010 = ''
      LET l_nmbc.nmbc011 = ''
      LET l_nmbc.nmbc012 = ''              #150818-00032#3 
      LET l_nmbc.nmbc013 = l_nmbb.nmbb028  #150818-00032#3 
      LET l_nmbc.nmbc014 = ''              #151012-00014#6
      LET l_nmbc.nmbc015 = ''              #151012-00014#6
      LET l_nmbc.nmbc016 = ''              #151012-00014#6
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
      
     #INSERT INTO nmbc_t VALUES(l_nmbc.*)   #161219-00014#2  mark
      #161219-00014#2--add--s--
      INSERT INTO nmbc_t(nmbcent,nmbcownid,nmbcowndp,nmbccrtid,nmbccrtdp,nmbccrtdt,nmbcmodid,nmbcmoddt,nmbccnfid,nmbccnfdt,nmbcpstid,
      nmbcpstdt,nmbcstus,nmbccomp,nmbcsite,nmbcdocno,nmbcseq,nmbc001,nmbc002,nmbc003,nmbc004,nmbc005,nmbc006,nmbc007,nmbc008,nmbc009,
      nmbc010,nmbc011,nmbc100,nmbc101,nmbc103,nmbc113,nmbc121,nmbc123,nmbc131,nmbc133,nmbcud001,nmbcud002,nmbcud003,nmbcud004,nmbcud005,
      nmbcud006,nmbcud007,nmbcud008,nmbcud009,nmbcud010,nmbcud011,nmbcud012,nmbcud013,nmbcud014,nmbcud015,nmbcud016,nmbcud017,nmbcud018,
      nmbcud019,nmbcud020,nmbcud021,nmbcud022,nmbcud023,nmbcud024,nmbcud025,nmbcud026,nmbcud027,nmbcud028,nmbcud029,nmbcud030,nmbc012,
      nmbc013,nmbc014,nmbc015,nmbc016,nmbc017,nmbcorga) VALUES(l_nmbc.nmbcent,l_nmbc.nmbcownid,l_nmbc.nmbcowndp,l_nmbc.nmbccrtid,l_nmbc.nmbccrtdp,
      l_nmbc.nmbccrtdt,l_nmbc.nmbcmodid,l_nmbc.nmbcmoddt,l_nmbc.nmbccnfid,l_nmbc.nmbccnfdt,l_nmbc.nmbcpstid,l_nmbc.nmbcpstdt,l_nmbc.nmbcstus,
      l_nmbc.nmbccomp,l_nmbc.nmbcsite,l_nmbc.nmbcdocno,l_nmbc.nmbcseq,l_nmbc.nmbc001,l_nmbc.nmbc002,l_nmbc.nmbc003,l_nmbc.nmbc004,l_nmbc.nmbc005,
      l_nmbc.nmbc006,l_nmbc.nmbc007,l_nmbc.nmbc008,l_nmbc.nmbc009,l_nmbc.nmbc010,l_nmbc.nmbc011,l_nmbc.nmbc100,l_nmbc.nmbc101,l_nmbc.nmbc103,
      l_nmbc.nmbc113,l_nmbc.nmbc121,l_nmbc.nmbc123,l_nmbc.nmbc131,l_nmbc.nmbc133,l_nmbc.nmbcud001,l_nmbc.nmbcud002,l_nmbc.nmbcud003,l_nmbc.nmbcud004,
      l_nmbc.nmbcud005,l_nmbc.nmbcud006,l_nmbc.nmbcud007,l_nmbc.nmbcud008,l_nmbc.nmbcud009,l_nmbc.nmbcud010,l_nmbc.nmbcud011,l_nmbc.nmbcud012,l_nmbc.nmbcud013,
      l_nmbc.nmbcud014,l_nmbc.nmbcud015,l_nmbc.nmbcud016,l_nmbc.nmbcud017,l_nmbc.nmbcud018,l_nmbc.nmbcud019,l_nmbc.nmbcud020,l_nmbc.nmbcud021,l_nmbc.nmbcud022,
      l_nmbc.nmbcud023,l_nmbc.nmbcud024,l_nmbc.nmbcud025,l_nmbc.nmbcud026,l_nmbc.nmbcud027,l_nmbc.nmbcud028,l_nmbc.nmbcud029,l_nmbc.nmbcud030,l_nmbc.nmbc012,
      l_nmbc.nmbc013,l_nmbc.nmbc014,l_nmbc.nmbc015,l_nmbc.nmbc016,l_nmbc.nmbc017,l_nmbc.nmbcorga) 
      #161219-00014#2--add--e--
      IF SQLCA.SQLcode  THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins nmbc_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()         
         LET g_success = 'N'                        
      END IF
      IF g_success = 'N' THEN 
         EXIT FOREACH
      END IF 
   END FOREACH 
END FUNCTION
# 刪除銀存收支異動檔 nmbc_t
PRIVATE FUNCTION anmt310_nmbc_delete()
   
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
# 抓取核算組織
PRIVATE FUNCTION anmt310_nmbblegl_get(p_ooed004)
   DEFINE l_ooed005      LIKE ooed_t.ooed005
#  DEFINE l_ooea005      LIKE ooea_t.ooea005     #161110-00001#1 MARK 
   DEFINE p_ooed004      LIKE ooed_t.ooed004
   
   SELECT ooed005 INTO l_ooed005 
     FROM ooed_t
    WHERE ooedent = g_enterprise
      AND ooed001 = '3'
      AND ooed004 = p_ooed004
      AND ooed006 < = g_today 
      AND ooed007 > g_today
   
   IF cl_null(l_ooed005) THEN 
      LET g_nmbb_d[l_ac].nmbblegl = g_nmbb_d[l_ac].nmbborga
      RETURN 
   END IF 
   #161110-00001#1 MARK--S--
#   SELECT ooea005 INTO l_ooea005
#     FROM ooea_t
#    WHERE ooeaent = g_enterprise
#      AND ooea001 = l_ooed005  
#   IF l_ooea005 = 'Y' THEN 
#      LET g_nmbb_d[l_ac].nmbblegl = l_ooed005
#      RETURN 
#   ELSE
#      CALL anmt310_nmbblegl_get(l_ooed005)
#   END IF
   #161110-00001#1 MARK--E--
END FUNCTION
# 修改單身時，刷新第二和第三頁簽的值
PRIVATE FUNCTION anmt310_ref_amt()
   DEFINE l_ooam003        LIKE ooam_t.ooam003
   
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
     #LET g_nmbb_d[l_ac].nmbb012 = s_num_round('1',g_nmbb_d[l_ac].nmbb012,g_ooaj0052)   #150707-00001#2 mark   #2015/02/02 add by qiull    
      #150930-00010#4 mark--s
      #CALL s_curr_round_ld('1',g_glaald,g_glaa016,g_nmbb_d[l_ac].nmbb012,3)             #150707-00001#2
      #     RETURNING g_sub_success,g_errno,g_nmbb_d[l_ac].nmbb012                       #150707-00001#2      
      #150930-00010#4 mark--e
      
      #主帳套本位幣二金額
      IF g_glaa017 = '1'  THEN 
         LET g_nmbb_d[l_ac].nmbb013 = g_nmbb_d[l_ac].nmbb006 * g_nmbb_d[l_ac].nmbb012
      ELSE 
         LET g_nmbb_d[l_ac].nmbb013 = g_nmbb_d[l_ac].nmbb007 * g_nmbb_d[l_ac].nmbb012
      END IF    
     #LET g_nmbb_d[l_ac].nmbb013 = s_num_round('1',g_nmbb_d[l_ac].nmbb013,g_ooaj0042)   #150707-00001#2 mark   #2015/02/02 add by qiull  
      CALL s_curr_round_ld('1',g_glaald,g_glaa016,g_nmbb_d[l_ac].nmbb013,2)             #150707-00001#2
           RETURNING g_sub_success,g_errno,g_nmbb_d[l_ac].nmbb013                       #150707-00001#2        
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
     #LET g_nmbb_d[l_ac].nmbb016 = s_num_round('1',g_nmbb_d[l_ac].nmbb016,g_ooaj0053)   #150707-00001#2 mark #2015/02/02 add by qiull 
      #150930-00010#4 mark--s
      #CALL s_curr_round_ld('1',g_glaald,g_glaa020,g_nmbb_d[l_ac].nmbb016,3)             #150707-00001#2
      #     RETURNING g_sub_success,g_errno,g_nmbb_d[l_ac].nmbb016                       #150707-00001#2       
      #150930-00010#4 mark--e
      
      #主帳套本位幣三金額
      IF g_glaa017 = '1' THEN
         LET g_nmbb_d[l_ac].nmbb017 = g_nmbb_d[l_ac].nmbb006 * g_nmbb_d[l_ac].nmbb016
      ELSE
         LET g_nmbb_d[l_ac].nmbb017 = g_nmbb_d[l_ac].nmbb007 * g_nmbb_d[l_ac].nmbb016
      END IF
     #LET g_nmbb_d[l_ac].nmbb017 = s_num_round('1',g_nmbb_d[l_ac].nmbb017,g_ooaj0043)   #150707-00001#2 mark   #2015/02/02 add by qiull   
      CALL s_curr_round_ld('1',g_glaald,g_glaa020,g_nmbb_d[l_ac].nmbb017,2)             #150707-00001#2
           RETURNING g_sub_success,g_errno,g_nmbb_d[l_ac].nmbb017                       #150707-00001#2        
   END IF
   #主帳套本位幣三已沖金額
   LET g_nmbb_d[l_ac].nmbb018 = 0
   
   #-------------沖賬記錄查詢-----------------
   #150930-00010#4--s
   IF g_nmbb_d[l_ac].nmbb001 = '2' THEN
      #銀存支出匯率來源
      CALL cl_get_para(g_enterprise,g_nmba_m.nmbacomp,'S-FIN-4012') RETURNING g_para_data  #銀存支出匯率來源        
   ELSE
   #150930-00010#4--e   
      CALL cl_get_para(g_enterprise,g_nmba_m.nmbacomp,'S-FIN-4004') RETURNING g_para_data  #銀存收入匯率來源
   END IF   #150930-00010#4  
   
#   SELECT glaa001 INTO g_glaa001_1
#     FROM glaa_t
#    WHERE glaaent = g_enterprise
#      AND glaald = g_glaald_1
#      
#   IF NOT cl_null(g_glaa001_1) THEN
#         
#                            #匯率參照表;帳套;           日期;         來源幣別
#      CALL s_aooi160_get_exrate('2',g_glaald_1,g_nmba_m.nmbadocdt,g_nmbb_d[l_ac].nmbb004,
#                                #目的幣別;  交易金額; 匯類類型
#                                g_glaa001_1,0,g_para_data)
#      RETURNING g_nmbb_d[l_ac].nmbb019            #次帳套一匯率
#   END IF
   #LET g_nmbb_d[l_ac].nmbb019 = g_glaa001_1   #次帳套一幣別
   LET g_nmbb_d[l_ac].nmbb019 = 0
   LET g_nmbb_d[l_ac].nmbb020 = 0              #次帳套一原幣已沖
   LET g_nmbb_d[l_ac].nmbb021 = 0              #次帳套一本幣已沖
 
#   SELECT glaa001 INTO g_glaa001_2
#     FROM glaa_t
#    WHERE glaaent = g_enterprise
#      AND glaald = g_glaald_2
#      
#   IF NOT cl_null(g_glaa001_2) THEN
#         
#                            #匯率參照表;帳套;           日期;         來源幣別
#      CALL s_aooi160_get_exrate('2',g_glaald_2,g_nmba_m.nmbadocdt,g_nmbb_d[l_ac].nmbb004,
#                                #目的幣別;  交易金額; 匯類類型
#                                g_glaa001_2,0,g_para_data)
#      RETURNING g_nmbb_d[l_ac].nmbb022            #次帳套二匯率
#   END IF 
   #LET g_nmbb_d[l_ac].nmbb022 = g_glaa001_2   #次帳套二幣別
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
# 開啟交易對象修改
PRIVATE FUNCTION anmt310_open_nmba004()
   DEFINE l_nmba004              LIKE nmba_t.nmba004
   DEFINE l_pmaastus             LIKE pmaa_t.pmaastus
   DEFINE l_n                    LIKE type_t.num5
   DEFINE l_pmaa004              LIKE pmaa_t.pmaa004
   
   LET g_nmba_m_t.nmba004 = g_nmba_m.nmba004
   LET g_nmba_m_t.nmba004_desc = g_nmba_m.nmba004_desc
   LET g_flag = 'N'
   INPUT l_nmba004  FROM nmba004 
      
      
      AFTER FIELD nmba004 
      
         IF NOT cl_null(l_nmba004) THEN 
            #-------------------------------
            LET g_errno = ''
   
            SELECT pmaa004 INTO l_pmaa004
              FROM pmaa_t
             WHERE pmaaent = g_enterprise
               AND pmaa001 = l_nmba004
            
            LET l_n = 0
            SELECT count(*) INTO l_n
              FROM pmaa_t
             WHERE pmaaent = g_enterprise
               AND pmaa001 = l_nmba004
            IF l_n = 0 THEN 
               DISPLAY '' TO nmba004
               DISPLAY '' TO nmba004_desc
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'ais-00019'
               LET g_errparam.extend = l_nmba004
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET l_nmba004 = g_nmba_m_t.nmba004
               LET g_nmba_m.nmba004 = g_nmba_m_t.nmba004
               LET g_nmba_m.nmba004_desc = g_nmba_m_t.nmba004_desc
               DISPLAY g_nmba_m.nmba004 TO nmba004
               DISPLAY g_nmba_m.nmba004_desc TO nmba004_desc
               
               NEXT FIELD nmba004 
            ELSE
               LET l_n = 0 
               SELECT count(*) INTO l_n 
                 FROM pmaa_t
                WHERE pmaaent = g_enterprise
                  AND pmaa001 = l_nmba004
                  AND pmaastus = 'Y'
                  
               IF l_n = 0 THEN 
                  DISPLAY '' TO nmba004
                  DISPLAY '' TO nmba004_desc
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'ais-00020'
                  LET g_errparam.extend = l_nmba004
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET l_nmba004 = g_nmba_m_t.nmba004
                  LET g_nmba_m.nmba004 = g_nmba_m_t.nmba004
                  LET g_nmba_m.nmba004_desc = g_nmba_m_t.nmba004_desc
                  DISPLAY g_nmba_m.nmba004 TO nmba004
                  DISPLAY g_nmba_m.nmba004_desc TO nmba004_desc
                  NEXT FIELD nmba004 
               END IF 
            END IF
         
            IF l_pmaa004 = '2' OR l_pmaa004 = '4'  THEN 
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
	           LET g_qryparam.reqry = FALSE
         
               #LET g_qryparam.default1 = g_nmba_m.nmba004             #給予default值
               LET g_qryparam.arg1 = l_nmba004
               #給予arg
         
               CALL q_pmak002()                                #呼叫開窗
         
               LET g_nmba_m.nmba005 = g_qryparam.return1 
               CALL anmt310_show()               
               NEXT FIELD nmba004
            ELSE
               LET g_nmba_m.nmba005 = ''
            END IF   

            IF cl_null(g_nmba_m.nmba005) THEN 
               IF l_pmaa004 = '2' THEN   #一次性交易對象
                  CALL apmi004_01('1','',g_nmba_m.nmba004,g_nmba_m.nmbadocno) RETURNING g_nmba_m.nmba005
               END IF
               IF l_pmaa004 = '4' THEN   #內部員工
                  CALL apmi004_01('2','',g_nmba_m.nmba004,g_nmba_m.nmbadocno) RETURNING g_nmba_m.nmba005
               END IF
            END IF 
            
            
            
            #-------------------------------
            #CALL anmt310_nmba004_chk(l_nmba004)
            #IF NOT cl_null(g_errno) THEN 
            #   DISPLAY '' TO nmba004
            #   DISPLAY '' TO nmba004_desc
            #   CALL cl_err(l_nmba004,g_errno,1)
            #   LET g_nmba_m.nmba004 = g_nmba_m_t.nmba004
            #   LET g_nmba_m.nmba004_desc = g_nmba_m_t.nmba004_desc
            #   NEXT FIELD nmba004
            #END IF   
         END IF 
         LET g_nmba_m.nmba004 = l_nmba004
         CALL anmt310_show()      
         
      ON ACTION controlp INFIELD nmba004
            #add-point:ON ACTION controlp INFIELD nmba004
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = l_nmba004             #給予default值

            #給予arg

            # CALL q_pmaa001()       #160913-00017#6  mark                  #呼叫開窗
            CALL q_pmaa001_25()     #160913-00017#6  add      

            LET l_nmba004 = g_qryparam.return1              #將開窗取得的值回傳到變數
            LET g_nmba_m.nmba004 = l_nmba004
            DISPLAY g_nmba_m.nmba004 TO nmba004              #顯示到畫面上
            CALL anmt310_show()
            NEXT FIELD nmba004                          #返回原欄位
   
         
      BEFORE INPUT
         #LET g_nmba_m.nmba004 = ''
         #LET g_nmba_m.nmba004_desc = ''
         #DISPLAY g_nmba_m.nmba004_desc TO nmba004_desc
         LET l_nmba004 = g_nmba_m.nmba004
         
         
      AFTER INPUT
         #若取消則直接結束
         IF INT_FLAG = 1 THEN
            LET INT_FLAG = 0
            RETURN
         END IF
 
      ON ACTION accept
         CALL s_transaction_begin()
   
         UPDATE nmba_t set nmba004 = g_nmba_m.nmba004,
                           nmba005 = g_nmba_m.nmba005
          WHERE nmbaent = g_enterprise 
            AND nmbacomp = g_nmba_m.nmbacomp
            AND nmbadocno = g_nmba_m.nmbadocno
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'UPDATE error!'
            LET g_errparam.popup = TRUE
            CALL cl_err()

            CALL s_transaction_end('N','0')
         ELSE
            CALL s_transaction_end('Y','0')
         END IF
         LET g_flag = 'Y'
         RETURN
 
      ON ACTION cancel
         LET INT_FLAG = 1
         RETURN 
 
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE INPUT

      
   END INPUT
   
   IF g_flag = 'N' THEN
      CALL s_transaction_begin()
   
      UPDATE nmba_t set nmba004 = g_nmba_m.nmba004,
                        nmba005 = g_nmba_m.nmba005
       WHERE nmbaent = g_enterprise 
         AND nmbacomp = g_nmba_m.nmbacomp
         AND nmbadocno = g_nmba_m.nmbadocno
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'UPDATE error!'
            LET g_errparam.popup = TRUE
            CALL cl_err()

         CALL s_transaction_end('N','0')
      ELSE
         CALL s_transaction_end('Y','0')
      END IF
   END IF
END FUNCTION
#
PRIVATE FUNCTION anmt310_glaa_get()
   LET g_glaald  = ''
   LET g_glaa001 = ''
   LET g_glaa002 = ''
   LET g_glaa015 = ''
   LET g_glaa016 = ''
   LET g_glaa017 = ''
   LET g_glaa018 = ''
   LET g_glaa019 = ''
   LET g_glaa020 = ''
   LET g_glaa021 = ''
   LET g_glaa022 = ''
   LET g_glaa003 = ''
   LET g_glaa024 = ''
   #2015/02/02 add by qiull(s)
   LET g_glaa026 = '' 
   LET g_ooaj0042 = ''
   LET g_ooaj0052 = ''   
   LET g_ooaj0043 = ''
   LET g_ooaj0053 = ''
   #2015/02/02 add by qiull(e)
   SELECT glaald,glaa001,glaa002,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,glaa003,glaa024                           #2014/12/26 liuym add glaa003,glaa024
          ,glaa026       #2015/02/02 add by qiull
     INTO g_glaald,g_glaa001,g_glaa002,g_glaa015,g_glaa016,g_glaa017,g_glaa018,g_glaa019,g_glaa020,g_glaa021,g_glaa022,g_glaa003,g_glaa024 #2014/12/26 liuym add g_glaa003,g_glaa024
          ,g_glaa026     #2015/02/02 add by qiull
     FROM glaa_t
    WHERE glaaent = g_enterprise  #2015/03/31 add by 02599
      AND glaacomp = g_nmba_m.nmbacomp
      AND glaa014 = 'Y'
   
   #取得帳套一的帳套代碼
#   CALL cl_get_para(g_enterprise,g_nmba_m.nmbacomp,'S-FIN-0001') RETURNING g_glaald_1  
      
   #取得帳套二的帳套代碼 
#   CALL cl_get_para(g_enterprise,g_nmba_m.nmbacomp,'S-FIN-0002') RETURNING g_glaald_2
      
   CALL cl_set_comp_visible('page2',TRUE)   
   CALL cl_set_comp_visible('nmbb011_1,nmbb012_1,nmbb013_1,nmbb014_1',TRUE)
   CALL cl_set_comp_visible('nmbb015_1,nmbb016_1,nmbb017_1,nmbb018_1',TRUE)
      
   IF g_glaa015 = 'N' AND g_glaa019 = 'N' THEN
      CALL cl_set_comp_visible('page2',FALSE)
   END IF 
   IF g_glaa015 = 'N' AND g_glaa019 = 'Y' THEN 
      CALL cl_set_comp_visible('nmbb011_1,nmbb012_1,nmbb013_1,nmbb014_1',FALSE)
      CALL cl_set_comp_visible('nmbb015_1,nmbb016_1,nmbb017_1,nmbb018_1',TRUE)
      #2015/02/02 add by qiull(s)
      SELECT ooaj004,ooaj005 INTO g_ooaj0043,g_ooaj0053 FROM ooaj_t 
       WHERE ooajent = g_enterprise
         AND ooaj001 = g_glaa026 
         AND ooaj002 = g_glaa020
      #2015/02/02 add by qiull(e)
   END IF 
   IF g_glaa015 = 'Y' AND g_glaa019 = 'N' THEN 
      CALL cl_set_comp_visible('nmbb011_1,nmbb012_1,nmbb013_1,nmbb014_1',TRUE)
      CALL cl_set_comp_visible('nmbb015_1,nmbb016_1,nmbb017_1,nmbb018_1',FALSE)
      #2015/02/02 add by qiull(s)
      SELECT ooaj004,ooaj005 INTO g_ooaj0043,g_ooaj0053 FROM ooaj_t 
       WHERE ooajent = g_enterprise
         AND ooaj001 = g_glaa026 
         AND ooaj002 = g_glaa016
      #2015/02/02 add by qiull(e)
   END IF 
   
   CALL cl_set_comp_visible('nmbb019_1,nmbb020_1,nmbb021_1',TRUE)
   CALL cl_set_comp_visible('nmbb022_1,nmbb023_1,nmbb024_1',TRUE)    
#   IF cl_null(g_glaald_1) THEN 
      CALL cl_set_comp_visible('nmbb019_1,nmbb020_1,nmbb021_1',FALSE) 
#   END IF 
#   IF cl_null(g_glaald_2) THEN 
      CALL cl_set_comp_visible('nmbb022_1,nmbb023_1,nmbb024_1',FALSE) 
#   END IF 
END FUNCTION
# 資金中心名稱
PRIVATE FUNCTION anmt310_nmbasite_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_nmba_m.nmbasite
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_nmba_m.nmbasite_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_nmba_m.nmbasite_desc
END FUNCTION
# 法人組織名稱
PRIVATE FUNCTION anmt310_nmbacomp_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_nmba_m.nmbacomp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_nmba_m.nmbacomp_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_nmba_m.nmbacomp_desc
END FUNCTION
# 插入現金變動碼
PRIVATE FUNCTION anmt310_glbc_ins()
  #DEFINE l_glbc         RECORD LIKE glbc_t.*  #161219-00014#2--mark--
   #161219-00014#2--add--s--
   DEFINE l_glbc RECORD  #現金變動碼明細檔
       glbcent LIKE glbc_t.glbcent, #企业编号
       glbcld LIKE glbc_t.glbcld, #账套
       glbccomp LIKE glbc_t.glbccomp, #营运据点
       glbcdocno LIKE glbc_t.glbcdocno, #凭证编号
       glbcseq LIKE glbc_t.glbcseq, #项次
       glbcseq1 LIKE glbc_t.glbcseq1, #序号
       glbc001 LIKE glbc_t.glbc001, #年度
       glbc002 LIKE glbc_t.glbc002, #期别
       glbc003 LIKE glbc_t.glbc003, #借贷别
       glbc004 LIKE glbc_t.glbc004, #现金变动码
       glbc005 LIKE glbc_t.glbc005, #交易客商
       glbc006 LIKE glbc_t.glbc006, #交易币种
       glbc007 LIKE glbc_t.glbc007, #汇率
       glbc008 LIKE glbc_t.glbc008, #原币金额
       glbc009 LIKE glbc_t.glbc009, #本币金额
       glbc010 LIKE glbc_t.glbc010, #数据源
       glbc011 LIKE glbc_t.glbc011, #汇率(本位币二)
       glbc012 LIKE glbc_t.glbc012, #金额(本位币二)
       glbc013 LIKE glbc_t.glbc013, #汇率(本位币三)
       glbc014 LIKE glbc_t.glbc014, #金额(本位币三)
       glbcud001 LIKE glbc_t.glbcud001, #自定义字段(文本)001
       glbcud002 LIKE glbc_t.glbcud002, #自定义字段(文本)002
       glbcud003 LIKE glbc_t.glbcud003, #自定义字段(文本)003
       glbcud004 LIKE glbc_t.glbcud004, #自定义字段(文本)004
       glbcud005 LIKE glbc_t.glbcud005, #自定义字段(文本)005
       glbcud006 LIKE glbc_t.glbcud006, #自定义字段(文本)006
       glbcud007 LIKE glbc_t.glbcud007, #自定义字段(文本)007
       glbcud008 LIKE glbc_t.glbcud008, #自定义字段(文本)008
       glbcud009 LIKE glbc_t.glbcud009, #自定义字段(文本)009
       glbcud010 LIKE glbc_t.glbcud010, #自定义字段(文本)010
       glbcud011 LIKE glbc_t.glbcud011, #自定义字段(数字)011
       glbcud012 LIKE glbc_t.glbcud012, #自定义字段(数字)012
       glbcud013 LIKE glbc_t.glbcud013, #自定义字段(数字)013
       glbcud014 LIKE glbc_t.glbcud014, #自定义字段(数字)014
       glbcud015 LIKE glbc_t.glbcud015, #自定义字段(数字)015
       glbcud016 LIKE glbc_t.glbcud016, #自定义字段(数字)016
       glbcud017 LIKE glbc_t.glbcud017, #自定义字段(数字)017
       glbcud018 LIKE glbc_t.glbcud018, #自定义字段(数字)018
       glbcud019 LIKE glbc_t.glbcud019, #自定义字段(数字)019
       glbcud020 LIKE glbc_t.glbcud020, #自定义字段(数字)020
       glbcud021 LIKE glbc_t.glbcud021, #自定义字段(日期时间)021
       glbcud022 LIKE glbc_t.glbcud022, #自定义字段(日期时间)022
       glbcud023 LIKE glbc_t.glbcud023, #自定义字段(日期时间)023
       glbcud024 LIKE glbc_t.glbcud024, #自定义字段(日期时间)024
       glbcud025 LIKE glbc_t.glbcud025, #自定义字段(日期时间)025
       glbcud026 LIKE glbc_t.glbcud026, #自定义字段(日期时间)026
       glbcud027 LIKE glbc_t.glbcud027, #自定义字段(日期时间)027
       glbcud028 LIKE glbc_t.glbcud028, #自定义字段(日期时间)028
       glbcud029 LIKE glbc_t.glbcud029, #自定义字段(日期时间)029
       glbcud030 LIKE glbc_t.glbcud030, #自定义字段(日期时间)030
       glbc015 LIKE glbc_t.glbc015  #状态码
       END RECORD
   #161219-00014#2--add--e--
   DEFINE l_year         LIKE type_t.num5
   DEFINE l_month        LIKE type_t.num5
   
   LET l_year = YEAR(g_nmba_m.nmbadocdt)
   LET l_month = MONTH(g_nmba_m.nmbadocdt)
   
   LET l_glbc.glbcent   = g_enterprise
   LET l_glbc.glbcld    = g_glaald
   LET l_glbc.glbccomp  = g_nmba_m.nmbacomp
   LET l_glbc.glbcdocno = g_nmba_m.nmbadocno
   LET l_glbc.glbcseq   = g_nmbb_d[l_ac].nmbbseq
   LET l_glbc.glbc001   = l_year
   LET l_glbc.glbc002   = l_month
   
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
   
   LET l_glbc.glbc003   = g_nmbb_d[l_ac].nmbb001
   LET l_glbc.glbc004   = g_nmbb_d[l_ac].nmbb010 
   LET l_glbc.glbc005   = g_nmbb_d[l_ac].nmbb026
   LET l_glbc.glbc006   = g_nmbb_d[l_ac].nmbb004
   LET l_glbc.glbc007   = g_nmbb_d[l_ac].nmbb005
   LET l_glbc.glbc008   = g_nmbb_d[l_ac].nmbb006
   LET l_glbc.glbc009   = g_nmbb_d[l_ac].nmbb007
   LET l_glbc.glbc010   ='2' 
   #--以下視主帳套有無啟用本位幣
   IF g_glaa015 = 'Y' THEN 
      LET l_glbc.glbc011 = g_nmbb_d[l_ac].nmbb012
      LET l_glbc.glbc012 = g_nmbb_d[l_ac].nmbb013
   END IF
   IF g_glaa019 = 'Y' THEN 
      LET l_glbc.glbc013 = g_nmbb_d[l_ac].nmbb016
      LET l_glbc.glbc014 = g_nmbb_d[l_ac].nmbb017
   END IF
   
   LET l_glbc.glbc015   = g_nmba_m.nmbastus      #151013-00016#6
   
  #INSERT INTO glbc_t VALUES (l_glbc.*)  #161219-00014#2--mark--
   #161219-00014#2--add--s--
   INSERT INTO glbc_t(glbcent,glbcld,glbccomp,glbcdocno,glbcseq,glbcseq1,glbc001,glbc002,glbc003,glbc004,glbc005,glbc006,glbc007,
   glbc008,glbc009,glbc010,glbc011,glbc012,glbc013,glbc014,glbcud001,glbcud002,glbcud003,glbcud004,glbcud005,glbcud006,glbcud007,
   glbcud008,glbcud009,glbcud010,glbcud011,glbcud012,glbcud013,glbcud014,glbcud015,glbcud016,glbcud017,glbcud018,glbcud019,glbcud020,
   glbcud021,glbcud022,glbcud023,glbcud024,glbcud025,glbcud026,glbcud027,glbcud028,glbcud029,glbcud030,glbc015) VALUES (l_glbc.glbcent,
   l_glbc.glbcld,l_glbc.glbccomp,l_glbc.glbcdocno,l_glbc.glbcseq,l_glbc.glbcseq1,l_glbc.glbc001,l_glbc.glbc002,l_glbc.glbc003,l_glbc.glbc004,
   l_glbc.glbc005,l_glbc.glbc006,l_glbc.glbc007,l_glbc.glbc008,l_glbc.glbc009,l_glbc.glbc010,l_glbc.glbc011,l_glbc.glbc012,l_glbc.glbc013,
   l_glbc.glbc014,l_glbc.glbcud001,l_glbc.glbcud002,l_glbc.glbcud003,l_glbc.glbcud004,l_glbc.glbcud005,l_glbc.glbcud006,l_glbc.glbcud007,
   l_glbc.glbcud008,l_glbc.glbcud009,l_glbc.glbcud010,l_glbc.glbcud011,l_glbc.glbcud012,l_glbc.glbcud013,l_glbc.glbcud014,l_glbc.glbcud015,
   l_glbc.glbcud016,l_glbc.glbcud017,l_glbc.glbcud018,l_glbc.glbcud019,l_glbc.glbcud020,l_glbc.glbcud021,l_glbc.glbcud022,l_glbc.glbcud023,
   l_glbc.glbcud024,l_glbc.glbcud025,l_glbc.glbcud026,l_glbc.glbcud027,l_glbc.glbcud028,l_glbc.glbcud029,l_glbc.glbcud030,l_glbc.glbc015)
   #161219-00014#2--add--e--
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'ins glbc_t'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      CALL s_transaction_end('N','0')
   END IF
END FUNCTION
#
PRIVATE FUNCTION anmt310_change_to_sql(p_wc)
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
   LET r_wc = "'",l_str,"'"

   RETURN r_wc
END FUNCTION

################################################################################
# Descriptions...: 判断单据是否已存在于银存收支账务处理作业中
# Memo...........:
# Usage..........: CALL anmt310_void_chk()
#                  RETURNING g_success
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2014/09/30 By 05426
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt310_void_chk()
   DEFINE l_success     LIKE type_t.num5
   LET l_success=0
   IF NOT cl_null(g_nmba_m.nmbadocno) THEN
      SELECT COUNT(*) INTO l_success 
        FROM nmbt_t,nmbs_t
       WHERE nmbsent = nmbtent
         AND nmbsld = nmbtld
         AND nmbsdocno = nmbtdocno
         AND nmbsent = g_enterprise
         AND nmbscomp = g_nmba_m.nmbacomp
         AND nmbt002=g_nmba_m.nmbadocno
         AND nmbsstus <> 'X'                      #160428-00019
   END IF
   RETURN l_success

END FUNCTION
################################################################################
# Descriptions...: 暂收否预设值设置
# Date & Author..: 2015/06/22  BY apo
# Modify.........: #150616-00026#12
################################################################################
PRIVATE FUNCTION anmt310_nmba006_chk()
DEFINE l_dfin0030             LIKE ooac_t.ooac004  
DEFINE l_ooba002              LIKE ooba_t.ooba002  
DEFINE l_glaa121              LIKE glaa_t.glaa121  

  CALL s_aooi200_fin_get_slip(g_nmba_m.nmbadocno) RETURNING g_sub_success,l_ooba002
  CALL s_fin_get_doc_para(g_glaald,g_nmba_m.nmbacomp,l_ooba002,'D-FIN-0030') RETURNING l_dfin0030
  SELECT glaa121 INTO l_glaa121
    FROM glaa_t
   WHERE glaaent = g_enterprise
     AND glaald = g_glaald
            
   IF NOT cl_null(l_dfin0030) THEN
      IF l_dfin0030='Y' THEN
         LET g_nmba_m.nmba006='Y'
      ELSE
         LET g_nmba_m.nmba006='N'
      END IF
   END IF
END FUNCTION

################################################################################
# Descriptions...: 根據畫面資訊取得匯率
# Memo...........:
# Usage..........: CALL anmt310_get_exrate()
# Date & Author..: 15/10/02 By apo(#150930-00010#4)
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt310_get_exrate()
DEFINE l_ooab002        LIKE ooab_t.ooab002
   IF g_nmbb_d[l_ac].nmbb001 = '2' THEN
      #銀存支出匯率來源
      CALL cl_get_para(g_enterprise,g_ooef001,'S-FIN-4012') RETURNING l_ooab002             
   ELSE
      SELECT ooab002 INTO l_ooab002 FROM ooab_t
       WHERE ooabent = g_enterprise
         AND ooabsite= g_ooef001
         AND ooab001 = 'S-FIN-4004'
   END IF    
    
   IF l_ooab002 = '23' THEN
      #銀行日平均匯率
      CALL s_anm_get_exrate(g_glaald,g_nmba_m.nmbacomp,g_nmbb_d[l_ac].nmbb003,g_nmbb_d[l_ac].nmbb004,g_glaa001,g_nmba_m.nmbadocdt) RETURNING g_nmbb_d[l_ac].nmbb005
   ELSE         
                               #匯率參照表;帳套;           日期;               來源幣別
      CALL s_aooi160_get_exrate('2',g_glaald,g_nmba_m.nmbadocdt,g_nmbb_d[l_ac].nmbb004,
                               #目的幣別;  交易金額;              匯類類型
                                g_glaa001,0,l_ooab002)
         RETURNING g_nmbb_d[l_ac].nmbb005                    
   END IF                     
   DISPLAY BY NAME g_nmbb_d[l_ac].nmbb005
      
   IF NOT cl_null(g_nmbb_d[l_ac].nmbb006) AND g_nmbb_d[l_ac].nmbb006 <> 0 THEN 
      LET g_nmbb_d[l_ac].nmbb007 = g_nmbb_d[l_ac].nmbb006 * g_nmbb_d[l_ac].nmbb005
      CALL s_curr_round_ld('1',g_glaald,g_glaa001,g_nmbb_d[l_ac].nmbb007,2) RETURNING g_sub_success,g_errno,g_nmbb_d[l_ac].nmbb007                                            
      DISPLAY BY NAME g_nmbb_d[l_ac].nmbb007
   END IF                  
END FUNCTION

################################################################################
# Descriptions...: 借貸項合計信息頁籤
# Memo...........: #151016-00018#1
# Usage..........: CALL anmt310_sum_page_show()
# Date & Author..: 151019 By Jessy
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt310_sum_page_show()
DEFINE l_nmbb006_d LIKE nmbb_t.nmbb006  #借方
DEFINE l_nmbb007_d LIKE nmbb_t.nmbb006  #借方
DEFINE l_nmbb006_c LIKE nmbb_t.nmbb006  #貸方
DEFINE l_nmbb007_c LIKE nmbb_t.nmbb006  #貸方
  
   #借方合計
   SELECT SUM(nmbb006),SUM(nmbb007) INTO l_nmbb006_d,l_nmbb007_d  
     FROM nmbb_t
    WHERE nmbbent = g_enterprise
      AND nmbbdocno = g_nmba_m.nmbadocno
      AND nmbbcomp = g_nmba_m.nmbacomp
      AND nmbb001 IN ('1','3') 

   IF cl_null(l_nmbb006_d)THEN LET l_nmbb006_d = 0 END IF
   IF cl_null(l_nmbb007_d)THEN LET l_nmbb007_d = 0 END IF
 
   #貸方合計
   SELECT SUM(nmbb006),SUM(nmbb007) INTO l_nmbb006_c,l_nmbb007_c  
     FROM nmbb_t
    WHERE nmbbent = g_enterprise
      AND nmbbdocno = g_nmba_m.nmbadocno
      AND nmbbcomp = g_nmba_m.nmbacomp
      AND nmbb001 IN ('2','4') 

   IF cl_null(l_nmbb006_c)THEN LET l_nmbb006_c = 0 END IF
   IF cl_null(l_nmbb007_c)THEN LET l_nmbb007_c = 0 END IF
   
   #借方合計   
   LET g_amt1_d = l_nmbb006_d       #原幣
   LET g_amt2_d = l_nmbb007_d       #本幣

   #貸方合計                                     
   LET g_amt3_c = l_nmbb006_c       #原幣
   LET g_amt4_c = l_nmbb007_c       #本幣
     
#   DISPLAY BY NAME g_amt1_d,g_amt2_d,g_amt3_c,g_amt4_c

   DISPLAY g_amt1_d,g_amt3_c  TO amt1_d,amt3_c
   DISPLAY g_amt2_d,g_amt4_c  TO amt2_d,amt4_c
END FUNCTION

################################################################################
# Descriptions...: 新增后立即审核
# Memo...........:
# Usage..........: CALL anmt310_immediately_conf()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 15/12/03 By 07166
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt310_immediately_conf()
#151125-00006#3--s
   DEFINE l_success         LIKE type_t.num5
   DEFINE l_doc_success     LIKE type_t.num5
   DEFINE l_slip            LIKE ooba_t.ooba002
   DEFINE l_dfin0031        LIKE type_t.chr1
   DEFINE l_count           LIKE type_t.num5
   DEFINE l_flag            LIKE type_t.num5  #161104-00030#1 add
   IF cl_null(g_glaald)    THEN RETURN END IF   #無資料直接返回不做處理
   IF cl_null(g_nmba_m.nmbacomp)  THEN RETURN END IF   #無資料直接返回不做處理
   IF cl_null(g_nmba_m.nmbadocno) THEN RETURN END IF   #無資料直接返回不做處理
    
   LET l_count = 0
   SELECT COUNT(*) INTO l_count FROM nmbb_t WHERE nmbbent = g_enterprise
      AND nmbbdocno = g_nmba_m.nmbadocno
      
   IF cl_null(l_count) THEN LET l_count = 0 END IF
   IF l_count = 0 THEN
      RETURN 
   END IF                   #单身無資料直接返回不做處理
   
   #取得單別
   CALL s_aooi200_fin_get_slip(g_nmba_m.nmbadocno) RETURNING l_success,l_slip
   #取得單別設置的"是否直接審核"參數
   CALL s_fin_get_doc_para(g_glaald,g_nmba_m.nmbacomp,l_slip,'D-FIN-0031') RETURNING l_dfin0031

   IF cl_null(l_dfin0031) OR l_dfin0031 MATCHES '[Nn]' THEN RETURN END IF #參數值為空或為N則不做直接審核邏輯
   IF NOT cl_ask_confirm('aap-00403') THEN RETURN END IF  #询问是否立即审核?
   
   
   CALL s_transaction_begin()
   CALL cl_err_collect_init()
   LET l_doc_success = TRUE
#161104-00030#1 mod s---        
#   IF NOT s_anmt310_conf_chk(g_nmba_m.nmbacomp,g_nmba_m.nmbadocno) THEN
#      LET l_doc_success = FALSE
#   END IF
   CALL s_anmt310_conf_chk(g_nmba_m.nmbacomp,g_nmba_m.nmbadocno) RETURNING g_sub_success,l_flag
   IF NOT g_sub_success THEN 
      LET l_doc_success = FALSE
   END IF
#161104-00030#1 mod e---   
   
   IF NOT s_anmt310_conf_upd(g_nmba_m.nmbacomp,g_nmba_m.nmbadocno) THEN
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
   IF l_doc_success = TRUE THEN
      CALL s_transaction_end('Y',1)
   ELSE
      CALL s_transaction_end('N',1)
      CALL cl_err_collect_show()
   END IF
#151125-00006#3--e
END FUNCTION

################################################################################
# Descriptions...: 若异动别 in(1:存入,2:提出),则，存提码nmbb002不为空,币别不可录
# Memo...........:
# Usage..........: CALL anmt310_nmbb001_entry()
# Date & Author..: 2015/12/24 By yangtt
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt310_nmbb001_entry()
   CALL cl_set_comp_required('nmbb002',FALSE)
   CALL cl_set_comp_entry('nmbb004',FALSE)       #币别  #160120-00029#1 add 
   IF g_nmbb_d[l_ac].nmbb001 = '1' OR g_nmbb_d[l_ac].nmbb001 = '2' THEN
      CALL cl_set_comp_required('nmbb002',TRUE)
      CALL cl_set_comp_entry('nmbb004',FALSE)    #币别  #160120-00029#1 add 
   ELSE
      CALL cl_set_comp_required('nmbb002',FALSE)
      CALL cl_set_comp_entry('nmbb004',TRUE)     #币别  #160120-00029#1 add 
   END IF
END FUNCTION

################################################################################
# Descriptions...: 若异动别 in(1:存入,2:提出),则，币别nmbb004由交易账户自动带出
# Memo...........:
# Usage..........: CALL anmt310_get_nmbb004()
# Date & Author..: 2016/03/29 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt310_get_nmbb004()

   SELECT nmas003 INTO g_nmbb_d[l_ac].nmbb004
     FROM nmaa_t,nmas_t
    WHERE nmaaent = g_enterprise
      AND nmaaent = nmasent
      AND nmaa001 = nmas001
      AND nmas002 = g_nmbb_d[l_ac].nmbb003
   DISPLAY BY NAME g_nmbb_d[l_ac].nmbb004
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
PRIVATE FUNCTION anmt310_nmbb070_chk()
   DEFINE l_ooefstus     LIKE ooef_t.ooefstus
   
   LET g_errno = ''
   
   SELECT ooefstus INTO l_ooefstus FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_nmbb_d[l_ac].nmbb070
      
   CASE
      WHEN SQLCA.SQLCODE = 100    LET g_errno = 'aoo-00090'
      WHEN l_ooefstus = 'N'       LET g_errno = 'sub-01302' #aoo-00091  #160318-00005#27 by 07900 --mod
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
PRIVATE FUNCTION anmt310_set_comp_required(ps_fields,pi_required)
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

 
{</section>}
 
