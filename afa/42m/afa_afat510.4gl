#該程式未解開Section, 採用最新樣板產出!
{<section id="afat510.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0003(2016-11-16 11:19:57), PR版次:0003(2017-01-04 10:23:16)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000000
#+ Filename...: afat510
#+ Description: 資產撥入帳務維護作業
#+ Creator....: 02114(2016-11-02 10:26:31)
#+ Modifier...: 02114 -SD/PR- 06821
 
{</section>}
 
{<section id="afat510.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#161215-00044#2     2016/12/16 by 02481    标准程式定义采用宣告模式,弃用.*写
#161104-00046#16    2017/01/04 By 06821    單別預設值;資料依照單別user dept權限過濾單號
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
PRIVATE type type_g_fabg_m        RECORD
       fabgsite LIKE fabg_t.fabgsite, 
   fabgsite_desc LIKE type_t.chr80, 
   fabg001 LIKE fabg_t.fabg001, 
   fabg001_desc LIKE type_t.chr80, 
   fabgld LIKE fabg_t.fabgld, 
   fabgld_desc LIKE type_t.chr80, 
   fabgcomp LIKE fabg_t.fabgcomp, 
   fabg005 LIKE fabg_t.fabg005, 
   fabgdocno LIKE fabg_t.fabgdocno, 
   fabgdocdt LIKE fabg_t.fabgdocdt, 
   fabg010 LIKE fabg_t.fabg010, 
   fabg010_desc LIKE type_t.chr80, 
   fabg018 LIKE fabg_t.fabg018, 
   fabg018_desc LIKE type_t.chr80, 
   fabg017 LIKE fabg_t.fabg017, 
   fabg006 LIKE fabg_t.fabg006, 
   fabg006_desc LIKE type_t.chr80, 
   fabg007 LIKE fabg_t.fabg007, 
   fabg007_desc LIKE type_t.chr80, 
   fabg013 LIKE fabg_t.fabg013, 
   fabg014 LIKE fabg_t.fabg014, 
   fabg015 LIKE fabg_t.fabg015, 
   fabg016 LIKE fabg_t.fabg016, 
   fabg012 LIKE fabg_t.fabg012, 
   fabg008 LIKE fabg_t.fabg008, 
   fabgstus LIKE fabg_t.fabgstus, 
   fabgownid LIKE fabg_t.fabgownid, 
   fabgownid_desc LIKE type_t.chr80, 
   fabgowndp LIKE fabg_t.fabgowndp, 
   fabgowndp_desc LIKE type_t.chr80, 
   fabgcrtid LIKE fabg_t.fabgcrtid, 
   fabgcrtid_desc LIKE type_t.chr80, 
   fabgcrtdp LIKE fabg_t.fabgcrtdp, 
   fabgcrtdp_desc LIKE type_t.chr80, 
   fabgcrtdt LIKE fabg_t.fabgcrtdt, 
   fabgmodid LIKE fabg_t.fabgmodid, 
   fabgmodid_desc LIKE type_t.chr80, 
   fabgmoddt LIKE fabg_t.fabgmoddt, 
   fabgcnfid LIKE fabg_t.fabgcnfid, 
   fabgcnfid_desc LIKE type_t.chr80, 
   fabgcnfdt LIKE fabg_t.fabgcnfdt, 
   fabgpstid LIKE fabg_t.fabgpstid, 
   fabgpstid_desc LIKE type_t.chr80, 
   fabgpstdt LIKE fabg_t.fabgpstdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_faca_d        RECORD
       facaseq LIKE faca_t.facaseq, 
   faca001 LIKE faca_t.faca001, 
   faca002 LIKE faca_t.faca002, 
   faca003 LIKE faca_t.faca003, 
   faca004 LIKE faca_t.faca004, 
   faca005 LIKE faca_t.faca005, 
   faca008 LIKE faca_t.faca008, 
   faca009 LIKE faca_t.faca009, 
   faca010 LIKE faca_t.faca010, 
   faca017 LIKE faca_t.faca017, 
   faca007 LIKE faca_t.faca007, 
   faca011 LIKE faca_t.faca011, 
   faca012 LIKE faca_t.faca012, 
   faca013 LIKE faca_t.faca013, 
   faca014 LIKE faca_t.faca014, 
   faca015 LIKE faca_t.faca015, 
   faca016 LIKE faca_t.faca016, 
   faca018 LIKE faca_t.faca018, 
   faca024 LIKE faca_t.faca024
       END RECORD
PRIVATE TYPE type_g_faca2_d RECORD
       facaseq LIKE faca_t.facaseq, 
   faca019 LIKE faca_t.faca019, 
   faca019_desc LIKE type_t.chr500, 
   faca036 LIKE faca_t.faca036, 
   faca025 LIKE faca_t.faca025, 
   faca025_desc LIKE type_t.chr500, 
   faca026 LIKE faca_t.faca026, 
   faca026_desc LIKE type_t.chr500, 
   faca027 LIKE faca_t.faca027, 
   faca027_desc LIKE type_t.chr500, 
   faca028 LIKE faca_t.faca028, 
   faca028_desc LIKE type_t.chr500, 
   faca029 LIKE faca_t.faca029, 
   faca029_desc LIKE type_t.chr500, 
   faca030 LIKE faca_t.faca030, 
   faca030_desc LIKE type_t.chr500, 
   faca031 LIKE faca_t.faca031, 
   faca031_desc LIKE type_t.chr500, 
   faca032 LIKE faca_t.faca032, 
   faca032_desc LIKE type_t.chr500, 
   faca033 LIKE faca_t.faca033, 
   faca033_desc LIKE type_t.chr500, 
   faca034 LIKE faca_t.faca034, 
   faca034_desc LIKE type_t.chr500, 
   faca052 LIKE faca_t.faca052, 
   faca053 LIKE faca_t.faca053, 
   faca053_desc LIKE type_t.chr500, 
   faca054 LIKE faca_t.faca054, 
   faca054_desc LIKE type_t.chr500, 
   faca065 LIKE faca_t.faca065, 
   faca065_desc LIKE type_t.chr500, 
   faca055 LIKE faca_t.faca055, 
   faca055_desc LIKE type_t.chr500, 
   faca056 LIKE faca_t.faca056, 
   faca056_desc LIKE type_t.chr500, 
   faca057 LIKE faca_t.faca057, 
   faca057_desc LIKE type_t.chr500, 
   faca058 LIKE faca_t.faca058, 
   faca058_desc LIKE type_t.chr500, 
   faca059 LIKE faca_t.faca059, 
   faca059_desc LIKE type_t.chr500, 
   faca060 LIKE faca_t.faca060, 
   faca060_desc LIKE type_t.chr500, 
   faca061 LIKE faca_t.faca061, 
   faca061_desc LIKE type_t.chr500, 
   faca062 LIKE faca_t.faca062, 
   faca062_desc LIKE type_t.chr500, 
   faca063 LIKE faca_t.faca063, 
   faca063_desc LIKE type_t.chr500, 
   faca064 LIKE faca_t.faca064, 
   faca064_desc LIKE type_t.chr500
       END RECORD
PRIVATE TYPE type_g_faca3_d RECORD
       xrcdseq LIKE xrcd_t.xrcdseq, 
   xrcdseq_desc LIKE type_t.chr500, 
   faca003 LIKE type_t.chr20, 
   xrcdseq2 LIKE xrcd_t.xrcdseq2, 
   xrcd007 LIKE xrcd_t.xrcd007, 
   xrcd002 LIKE xrcd_t.xrcd002, 
   xrcd002_desc LIKE type_t.chr500, 
   xrcd003 LIKE xrcd_t.xrcd003, 
   xrcd006 LIKE xrcd_t.xrcd006, 
   xrcd103 LIKE xrcd_t.xrcd103, 
   xrcd104 LIKE xrcd_t.xrcd104, 
   xrcd105 LIKE xrcd_t.xrcd105, 
   xrcd113 LIKE xrcd_t.xrcd113, 
   xrcd114 LIKE xrcd_t.xrcd114, 
   xrcd115 LIKE xrcd_t.xrcd115, 
   xrcd009 LIKE xrcd_t.xrcd009, 
   xrcd009_desc LIKE type_t.chr500
       END RECORD
PRIVATE TYPE type_g_faca5_d RECORD
       facaseq LIKE faca_t.facaseq, 
   faca043 LIKE faca_t.faca043, 
   faca038 LIKE faca_t.faca038, 
   faca039 LIKE faca_t.faca039, 
   faca040 LIKE faca_t.faca040, 
   faca041 LIKE faca_t.faca041, 
   faca042 LIKE faca_t.faca042, 
   faca044 LIKE faca_t.faca044, 
   faca050 LIKE faca_t.faca050, 
   faca045 LIKE faca_t.faca045, 
   faca046 LIKE faca_t.faca046, 
   faca047 LIKE faca_t.faca047, 
   faca048 LIKE faca_t.faca048, 
   faca049 LIKE faca_t.faca049, 
   faca051 LIKE faca_t.faca051
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_fabgld LIKE fabg_t.fabgld,
      b_fabgdocno LIKE fabg_t.fabgdocno
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
#161215-00044#1---modify----begin-----------------
#DEFINE g_glaa      RECORD LIKE glaa_t.* 
DEFINE g_glaa RECORD  #帳套資料檔
        glaaent LIKE glaa_t.glaaent, #企业编号
        glaaownid LIKE glaa_t.glaaownid, #资料所有者
        glaaowndp LIKE glaa_t.glaaowndp, #资料所有部门
        glaacrtid LIKE glaa_t.glaacrtid, #资料录入者
        glaacrtdp LIKE glaa_t.glaacrtdp, #资料录入部门
        glaacrtdt LIKE glaa_t.glaacrtdt, #资料创建日
        glaamodid LIKE glaa_t.glaamodid, #资料更改者
        glaamoddt LIKE glaa_t.glaamoddt, #最近更改日
        glaastus LIKE glaa_t.glaastus, #状态码
        glaald LIKE glaa_t.glaald, #账套编号
        glaacomp LIKE glaa_t.glaacomp, #归属法人
        glaa001 LIKE glaa_t.glaa001, #使用币种
        glaa002 LIKE glaa_t.glaa002, #汇率参照表号
        glaa003 LIKE glaa_t.glaa003, #会计周期参照表号
        glaa004 LIKE glaa_t.glaa004, #会计科目参照表号
        glaa005 LIKE glaa_t.glaa005, #现金变动参照表号
        glaa006 LIKE glaa_t.glaa006, #月结方式
        glaa007 LIKE glaa_t.glaa007, #年结方式
        glaa008 LIKE glaa_t.glaa008, #平行记账否
        glaa009 LIKE glaa_t.glaa009, #凭证登录方式
        glaa010 LIKE glaa_t.glaa010, #现行年度
        glaa011 LIKE glaa_t.glaa011, #现行期别
        glaa012 LIKE glaa_t.glaa012, #最后过账日期
        glaa013 LIKE glaa_t.glaa013, #关账日期
        glaa014 LIKE glaa_t.glaa014, #主账套
        glaa015 LIKE glaa_t.glaa015, #启用本位币二
        glaa016 LIKE glaa_t.glaa016, #本位币二
        glaa017 LIKE glaa_t.glaa017, #本位币二换算基准
        glaa018 LIKE glaa_t.glaa018, #本位币二汇率采用
        glaa019 LIKE glaa_t.glaa019, #启用本位币三
        glaa020 LIKE glaa_t.glaa020, #本位币三
        glaa021 LIKE glaa_t.glaa021, #本位币三换算基准
        glaa022 LIKE glaa_t.glaa022, #本位币三汇率采用
        glaa023 LIKE glaa_t.glaa023, #次账套账务生成时机
        glaa024 LIKE glaa_t.glaa024, #单据别参照表号
        glaa025 LIKE glaa_t.glaa025, #本位币一汇率采用
        glaa026 LIKE glaa_t.glaa026, #币种参照表号
        glaa100 LIKE glaa_t.glaa100, #凭证录入时自动按缺号生成
        glaa101 LIKE glaa_t.glaa101, #凭证总号录入时机
        glaa102 LIKE glaa_t.glaa102, #凭证成立时,借贷不平衡的处理方式
        glaa103 LIKE glaa_t.glaa103, #未打印的凭证可否进行过账
        glaa111 LIKE glaa_t.glaa111, #应计调整单别
        glaa112 LIKE glaa_t.glaa112, #期末结转单别
        glaa113 LIKE glaa_t.glaa113, #年底结转单别
        glaa120 LIKE glaa_t.glaa120, #成本计算类型
        glaa121 LIKE glaa_t.glaa121, #子模块启用分录底稿
        glaa122 LIKE glaa_t.glaa122, #总账可维护资金异动明细
        glaa027 LIKE glaa_t.glaa027, #单据据点编号
        glaa130 LIKE glaa_t.glaa130, #合并账套否
        glaa131 LIKE glaa_t.glaa131, #分层合并
        glaa132 LIKE glaa_t.glaa132, #平均汇率计算方式
        glaa133 LIKE glaa_t.glaa133, #非T100公司导入余额类型
        glaa134 LIKE glaa_t.glaa134, #合并科目转换依据异动码设置值
        glaa135 LIKE glaa_t.glaa135, #现流表间接法群组参照表号
        glaa136 LIKE glaa_t.glaa136, #应收账款核销限定己立账凭证
        glaa137 LIKE glaa_t.glaa137, #应付账款核销限定已立账凭证
        glaa138 LIKE glaa_t.glaa138, #合并报表编制期别
        glaa139 LIKE glaa_t.glaa139, #递延收入(负债)管理生成否
        glaa140 LIKE glaa_t.glaa140, #无原出货单的递延负债减项者,是否仍立递延收入管理?
        glaa123 LIKE glaa_t.glaa123, #应收帐款核销可维护资金异动明细
        glaa124 LIKE glaa_t.glaa124, #应付帐款核销可维护资金异动明细
        glaa028 LIKE glaa_t.glaa028  #汇率来源
        END RECORD
 #161215-00044#1---modify----end-----------------
DEFINE g_wc_cs_ld         STRING               
DEFINE g_site_str         STRING         
DEFINE g_sql_ctrl         STRING
DEFINE g_ooef019          LIKE ooef_t.ooef019
DEFINE g_ooaa002          LIKE ooaa_t.ooaa002

#是否做自由科目核算项管理
DEFINE g_glad017          LIKE glad_t.glad017
DEFINE g_glad0171         LIKE glad_t.glad0171 
DEFINE g_glad0172         LIKE glad_t.glad0172 
DEFINE g_glad018          LIKE glad_t.glad018
DEFINE g_glad0181         LIKE glad_t.glad0181
DEFINE g_glad0182         LIKE glad_t.glad0182
DEFINE g_glad019          LIKE glad_t.glad019
DEFINE g_glad0191         LIKE glad_t.glad0191
DEFINE g_glad0192         LIKE glad_t.glad0192
DEFINE g_glad020          LIKE glad_t.glad020
DEFINE g_glad0201         LIKE glad_t.glad0201
DEFINE g_glad0202         LIKE glad_t.glad0202
DEFINE g_glad021          LIKE glad_t.glad021
DEFINE g_glad0211         LIKE glad_t.glad0211
DEFINE g_glad0212         LIKE glad_t.glad0212
DEFINE g_glad022          LIKE glad_t.glad022
DEFINE g_glad0221         LIKE glad_t.glad0221
DEFINE g_glad0222         LIKE glad_t.glad0222
DEFINE g_glad023          LIKE glad_t.glad023
DEFINE g_glad0231         LIKE glad_t.glad0231
DEFINE g_glad0232         LIKE glad_t.glad0232
DEFINE g_glad024          LIKE glad_t.glad024
DEFINE g_glad0241         LIKE glad_t.glad0241
DEFINE g_glad0242         LIKE glad_t.glad0242
DEFINE g_glad025          LIKE glad_t.glad025
DEFINE g_glad0251         LIKE glad_t.glad0251
DEFINE g_glad0252         LIKE glad_t.glad0252
DEFINE g_glad026          LIKE glad_t.glad026
DEFINE g_glad0261         LIKE glad_t.glad0261
DEFINE g_glad0262         LIKE glad_t.glad0262
DEFINE g_glae009          LIKE glae_t.glae009
DEFINE g_glae002          LIKE glae_t.glae002
#161104-00046#16 --s add
DEFINE g_user_dept_wc     STRING     
DEFINE g_user_dept_wc_q   STRING     
DEFINE g_user_slip_wc     STRING  
DEFINE g_ap_slip          LIKE ooba_t.ooba002
#161104-00046#16 --e add
#end add-point
       
#模組變數(Module Variables)
DEFINE g_fabg_m          type_g_fabg_m
DEFINE g_fabg_m_t        type_g_fabg_m
DEFINE g_fabg_m_o        type_g_fabg_m
DEFINE g_fabg_m_mask_o   type_g_fabg_m #轉換遮罩前資料
DEFINE g_fabg_m_mask_n   type_g_fabg_m #轉換遮罩後資料
 
   DEFINE g_fabgld_t LIKE fabg_t.fabgld
DEFINE g_fabgdocno_t LIKE fabg_t.fabgdocno
 
 
DEFINE g_faca_d          DYNAMIC ARRAY OF type_g_faca_d
DEFINE g_faca_d_t        type_g_faca_d
DEFINE g_faca_d_o        type_g_faca_d
DEFINE g_faca_d_mask_o   DYNAMIC ARRAY OF type_g_faca_d #轉換遮罩前資料
DEFINE g_faca_d_mask_n   DYNAMIC ARRAY OF type_g_faca_d #轉換遮罩後資料
DEFINE g_faca2_d          DYNAMIC ARRAY OF type_g_faca2_d
DEFINE g_faca2_d_t        type_g_faca2_d
DEFINE g_faca2_d_o        type_g_faca2_d
DEFINE g_faca2_d_mask_o   DYNAMIC ARRAY OF type_g_faca2_d #轉換遮罩前資料
DEFINE g_faca2_d_mask_n   DYNAMIC ARRAY OF type_g_faca2_d #轉換遮罩後資料
DEFINE g_faca3_d          DYNAMIC ARRAY OF type_g_faca3_d
DEFINE g_faca3_d_t        type_g_faca3_d
DEFINE g_faca3_d_o        type_g_faca3_d
DEFINE g_faca3_d_mask_o   DYNAMIC ARRAY OF type_g_faca3_d #轉換遮罩前資料
DEFINE g_faca3_d_mask_n   DYNAMIC ARRAY OF type_g_faca3_d #轉換遮罩後資料
DEFINE g_faca5_d          DYNAMIC ARRAY OF type_g_faca5_d
DEFINE g_faca5_d_t        type_g_faca5_d
DEFINE g_faca5_d_o        type_g_faca5_d
DEFINE g_faca5_d_mask_o   DYNAMIC ARRAY OF type_g_faca5_d #轉換遮罩前資料
DEFINE g_faca5_d_mask_n   DYNAMIC ARRAY OF type_g_faca5_d #轉換遮罩後資料
 
 
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
 
{<section id="afat510.main" >}
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
   CALL cl_ap_init("afa","")
 
   #add-point:作業初始化 name="main.init"
   LET g_sql_ctrl = NULL
   CALL s_control_get_customer_sql('2',g_site,g_user,g_dept,'') RETURNING g_sub_success,g_sql_ctrl
   #161104-00046#16 --s add
   #建立與單頭array相同的temptable
   CALL s_aooi200def_create('','g_fabg_m','','','','','','')RETURNING g_sub_success
   #單別控制組
   LET g_user_dept_wc = ''
   CALL s_fin_get_user_dept_control('','fabgld','fabgent','fabgdocno') RETURNING g_user_dept_wc
   #開窗使用
   LET g_user_dept_wc_q = g_user_dept_wc
   CALL s_control_get_docno_sql(g_user,g_dept) RETURNING g_sub_success,g_user_slip_wc  
   #161104-00046#16 --e add   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT fabgsite,'',fabg001,'',fabgld,'',fabgcomp,fabg005,fabgdocno,fabgdocdt, 
       fabg010,'',fabg018,'',fabg017,fabg006,'',fabg007,'',fabg013,fabg014,fabg015,fabg016,fabg012,fabg008, 
       fabgstus,fabgownid,'',fabgowndp,'',fabgcrtid,'',fabgcrtdp,'',fabgcrtdt,fabgmodid,'',fabgmoddt, 
       fabgcnfid,'',fabgcnfdt,fabgpstid,'',fabgpstdt", 
                      " FROM fabg_t",
                      " WHERE fabgent= ? AND fabgld=? AND fabgdocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE afat510_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.fabgsite,t0.fabg001,t0.fabgld,t0.fabgcomp,t0.fabg005,t0.fabgdocno, 
       t0.fabgdocdt,t0.fabg010,t0.fabg018,t0.fabg017,t0.fabg006,t0.fabg007,t0.fabg013,t0.fabg014,t0.fabg015, 
       t0.fabg016,t0.fabg012,t0.fabg008,t0.fabgstus,t0.fabgownid,t0.fabgowndp,t0.fabgcrtid,t0.fabgcrtdp, 
       t0.fabgcrtdt,t0.fabgmodid,t0.fabgmoddt,t0.fabgcnfid,t0.fabgcnfdt,t0.fabgpstid,t0.fabgpstdt,t1.ooefl003 , 
       t2.ooag011 ,t3.glaal002 ,t4.ooefl003 ,t5.ooefl003 ,t6.pmaal004 ,t7.pmaal004 ,t8.ooag011 ,t9.ooefl003 , 
       t10.ooag011 ,t11.ooefl003 ,t12.ooag011 ,t13.ooag011 ,t14.ooag011",
               " FROM fabg_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.fabgsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.fabg001  ",
               " LEFT JOIN glaal_t t3 ON t3.glaalent="||g_enterprise||" AND t3.glaalld=t0.fabgld AND t3.glaal001='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.fabg010 AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.fabg018 AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t6 ON t6.pmaalent="||g_enterprise||" AND t6.pmaal001=t0.fabg006 AND t6.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t7 ON t7.pmaalent="||g_enterprise||" AND t7.pmaal001=t0.fabg007 AND t7.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=t0.fabgownid  ",
               " LEFT JOIN ooefl_t t9 ON t9.ooeflent="||g_enterprise||" AND t9.ooefl001=t0.fabgowndp AND t9.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t10 ON t10.ooagent="||g_enterprise||" AND t10.ooag001=t0.fabgcrtid  ",
               " LEFT JOIN ooefl_t t11 ON t11.ooeflent="||g_enterprise||" AND t11.ooefl001=t0.fabgcrtdp AND t11.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t12 ON t12.ooagent="||g_enterprise||" AND t12.ooag001=t0.fabgmodid  ",
               " LEFT JOIN ooag_t t13 ON t13.ooagent="||g_enterprise||" AND t13.ooag001=t0.fabgcnfid  ",
               " LEFT JOIN ooag_t t14 ON t14.ooagent="||g_enterprise||" AND t14.ooag001=t0.fabgpstid  ",
 
               " WHERE t0.fabgent = " ||g_enterprise|| " AND t0.fabgld = ? AND t0.fabgdocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE afat510_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_afat510 WITH FORM cl_ap_formpath("afa",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL afat510_init()   
 
      #進入選單 Menu (="N")
      CALL afat510_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_afat510
      
   END IF 
   
   CLOSE afat510_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   DROP TABLE afap280_tmp01
   DROP TABLE afap280_tmp02
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="afat510.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION afat510_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point    
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success     LIKE type_t.num5
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
      CALL cl_set_combo_scc_part('fabgstus','13','A,D,N,R,W,Y,Z,S,X')
 
      CALL cl_set_combo_scc('fabg005','9910') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1','2','4',","1")
   CALL g_idx_group.addAttribute("'3',","1")
   CALL g_idx_group.addAttribute("","1")
   CALL g_idx_group.addAttribute("","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc_part('fabg005','9910','44')
   CALL cl_set_combo_scc('faca052','6013')
   #品类管理层级aoos010
   CALL cl_get_para(g_enterprise,'','E-CIR-0001') RETURNING g_ooaa002
   CALL s_fin_create_account_center_tmp()
   CALL afap280_01_cre_fa_tmp_table() RETURNING l_success
   CALL s_pre_voucher_cre_tmp_table() RETURNING l_success
   #end add-point
   
   #初始化搜尋條件
   CALL afat510_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="afat510.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION afat510_ui_dialog()
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
   DEFINE  l_slip                LIKE type_t.chr80
   DEFINE  l_ooac004             LIKE ooac_t.ooac004
   DEFINE  l_success             LIKE type_t.num5
   DEFINE  l_wc                  STRING
   #end add-point
   
   #add-point:Function前置處理  name="ui_dialog.pre_function"
   IF NOT cl_null(g_argv[02]) AND g_argv[01] = 'N' THEN 
      LET g_actdefault = 'insert'
   END IF
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
            CALL afat510_insert()
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
         INITIALIZE g_fabg_m.* TO NULL
         CALL g_faca_d.clear()
         CALL g_faca2_d.clear()
         CALL g_faca3_d.clear()
         CALL g_faca5_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL afat510_init()
      END IF
   
            
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
    
         DISPLAY ARRAY g_faca_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL afat510_idx_chk()
               #確定當下選擇的筆數
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[1] = l_ac
               CALL g_idx_group.addAttribute("'1','2','4',",l_ac)
               
               #add-point:page1, before row動作 name="ui_dialog.page1.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1','2','4',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_current_page = 1
               #顯示單身筆數
               CALL afat510_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
         #第一階單身段落
         DISPLAY ARRAY g_faca2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL afat510_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[2] = l_ac
               CALL g_idx_group.addAttribute("'3',",l_ac)
               
               #add-point:page2, before row動作 name="ui_dialog.body2.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'3',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_current_page = 2
               #顯示單身筆數
               CALL afat510_idx_chk()
               #add-point:page2自定義行為 name="ui_dialog.body2.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
         
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_faca3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL afat510_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[3] = l_ac
               CALL g_idx_group.addAttribute("",l_ac)
               
               #add-point:page3, before row動作 name="ui_dialog.body3.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue(""))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_current_page = 3
               #顯示單身筆數
               CALL afat510_idx_chk()
               #add-point:page3自定義行為 name="ui_dialog.body3.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_3)
            
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION detail_qrystr
               MENU "" ATTRIBUTE(STYLE="popup")
                  #add-point:ON ACTION detail_qrystr相關動作 name="menu.detail_show.page3_sub.detail_qrystr"
                  
                  #END add-point
                                 #應用 a43 樣板自動產生(Version:4)
               ON ACTION prog_aooi610
                  LET g_action_choice="prog_aooi610"
                  IF cl_auth_chk_act("prog_aooi610") THEN
                     
                     #add-point:ON ACTION prog_aooi610 name="menu.detail_show.page3_sub.prog_aooi610"
               #應用 a41 樣板自動產生(Version:3)
               #使用JSON格式組合參數與作業編號(串查)
               INITIALIZE la_param.* TO NULL
               LET la_param.prog     = 'aooi610'
               LET la_param.param[1] = g_faca3_d[l_ac].xrcd002

               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun_wait(ls_js)
 



                     #END add-point
                     
                  END IF
 
 
 
 
               END MENU
 
 
 
               #add-point:ON ACTION detail_qrystr name="menu.detail_show.page3.detail_qrystr"
               
               #END add-point
 
 
 
 
         
            #add-point:page3自定義行為 name="ui_dialog.body3.action"
            
            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_faca5_d TO s_detail5.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL afat510_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail5")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[4] = l_ac
               CALL g_idx_group.addAttribute("",l_ac)
               
               #add-point:page4, before row動作 name="ui_dialog.body5.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue(""))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail5")
               LET g_current_page = 4
               #顯示單身筆數
               CALL afat510_idx_chk()
               #add-point:page4自定義行為 name="ui_dialog.body5.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_4)
            
         
            #add-point:page4自定義行為 name="ui_dialog.body5.action"
            
            #end add-point
         
         END DISPLAY
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
      
         BEFORE DIALOG
            #先填充browser資料
            CALL afat510_browser_fill("")
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
               CALL afat510_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL afat510_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL afat510_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL afat510_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL afat510_set_act_visible()   
            CALL afat510_set_act_no_visible()
            IF NOT (g_fabg_m.fabgld IS NULL
              OR g_fabg_m.fabgdocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " fabgent = " ||g_enterprise|| " AND",
                                  " fabgld = '", g_fabg_m.fabgld, "' "
                                  ," AND fabgdocno = '", g_fabg_m.fabgdocno, "' "
 
               #填到對應位置
               CALL afat510_browser_fill("")
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
                     WHEN la_wc[li_idx].tableid = "fabg_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "faca_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "xrcd_t" 
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
               CALL afat510_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                     WHEN la_wc[li_idx].tableid = "fabg_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "faca_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "xrcd_t" 
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
                  CALL afat510_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL afat510_fetch("F")
                  END IF
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
          
         
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL afat510_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL afat510_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL afat510_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL afat510_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL afat510_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL afat510_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL afat510_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL afat510_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL afat510_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL afat510_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_faca_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_faca2_d)
                  LET g_export_id[2]   = "s_detail2"
                  LET g_export_node[3] = base.typeInfo.create(g_faca3_d)
                  LET g_export_id[3]   = "s_detail3"
                  LET g_export_node[4] = base.typeInfo.create(g_faca5_d)
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
               CALL afat510_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL afat510_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_pre
            LET g_action_choice="open_pre"
            IF cl_auth_chk_act("open_pre") THEN
               
               #add-point:ON ACTION open_pre name="menu.open_pre"
               IF NOT cl_null(g_fabg_m.fabgdocno) THEN 
                  CALL afat510_ui_headershow()
                  IF g_fabg_m.fabgstus <> 'N' THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'axr-00270'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                        
                     EXIT DIALOG
                  END IF
                  
                  #获取单别
                  CALL s_aooi200_get_slip(g_fabg_m.fabgdocno) RETURNING l_success,l_slip
                   
                  #是否抛傳票
                  CALL s_fin_get_doc_para(g_fabg_m.fabgld,g_fabg_m.fabgcomp,l_slip,'D-FIN-0030') RETURNING l_ooac004
                   
                  IF l_ooac004 = 'N' OR cl_null(l_ooac004) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = l_slip
                     LET g_errparam.code   = 'axr-00225'
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                   
                     EXIT DIALOG
                  END IF
                  
                  CALL s_transaction_begin()
                  CALL cl_err_collect_init()
                  IF NOT cl_null(g_fabg_m.fabgdocno) THEN 
                     CALL s_pre_voucher_ins('FA','F50',g_fabg_m.fabgld,g_fabg_m.fabgdocno,g_fabg_m.fabgdocdt,'44') RETURNING l_success
                     
                     IF l_success THEN
                        CALL s_transaction_end('Y','1')
                     ELSE
                        CALL s_transaction_end('N','1')     
                     END IF
                     CALL cl_err_collect_show() 
                  END IF
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION set_back
            LET g_action_choice="set_back"
            IF cl_auth_chk_act("set_back") THEN
               
               #add-point:ON ACTION set_back name="menu.set_back"
               IF NOT cl_null(g_fabg_m.fabgld) AND NOT cl_null(g_fabg_m.fabgdocno) THEN
                  #存在应付账款资料
                  IF NOT cl_null(g_fabg_m.fabg012) THEN
                     #单据日期大于关账日期
                     IF s_afa_date_chk(g_fabg_m.fabgld,'',g_fabg_m.fabgdocdt) THEN                     
                        IF cl_ask_confirm('afa-00243') THEN
                           CALL s_transaction_begin()
                           CALL cl_err_collect_init()  
                           LET l_success = TRUE    
                 
                           CALL afat510_set_back() RETURNING l_success  
                           IF l_success = TRUE THEN              
                              CALL cl_err_collect_init() 
                              CALL cl_err_collect_show()
                              CALL s_transaction_end('Y','0') 
                           ELSE
                              CALL cl_err_collect_show()
                              CALL s_transaction_end('N','0')
                           END IF                  
                        END IF
                     END IF 
                  END IF 
               END IF
               CALL afat510_ui_headershow()
               CALL afat510_show()              
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL afat510_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL afat510_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/afa/afat510_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               &include "erp/afa/afat510_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL afat510_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_afap280
            LET g_action_choice="open_afap280"
            IF cl_auth_chk_act("open_afap280") THEN
               
               #add-point:ON ACTION open_afap280 name="menu.open_afap280"
               IF NOT cl_null(g_fabg_m.fabgdocno) AND g_fabg_m.fabgstus = 'S' AND cl_null(g_fabg_m.fabg008) THEN 
                  LET la_param.prog = 'afap280'
                  LET la_param.param[1] = g_fabg_m.fabgld
                  LET la_param.param[2] = g_fabg_m.fabgdocno
                  LET la_param.param[3] = g_fabg_m.fabg005
                  LET ls_js = util.JSON.stringify(la_param)
                  CALL cl_cmdrun_wait(ls_js)
                  CALL afat510_ui_headershow()
                  CALL afat510_show()
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_afap290
            LET g_action_choice="open_afap290"
            IF cl_auth_chk_act("open_afap290") THEN
               
               #add-point:ON ACTION open_afap290 name="menu.open_afap290"
               IF NOT cl_null(g_fabg_m.fabgdocno) AND g_fabg_m.fabgstus = 'S' AND NOT cl_null(g_fabg_m.fabg008) THEN 
                  LET la_param.prog = 'afap290'
                  LET la_param.param[1] = g_fabg_m.fabgld
                  LET la_param.param[2] = g_fabg_m.fabgdocno
                  LET la_param.param[3] = g_fabg_m.fabg005
                  LET ls_js = util.JSON.stringify(la_param)
                  CALL cl_cmdrun_wait(ls_js)
                  CALL afat510_ui_headershow()
                  CALL afat510_show()
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL afat510_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
               CALL g_curr_diag.setCurrentRow("s_detail3",1)
               CALL g_curr_diag.setCurrentRow("s_detail5",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_afap270
            LET g_action_choice="open_afap270"
            IF cl_auth_chk_act("open_afap270") THEN
               
               #add-point:ON ACTION open_afap270 name="menu.open_afap270"
               IF NOT cl_null(g_fabg_m.fabgdocno) AND (g_fabg_m.fabgstus = 'Y' OR g_fabg_m.fabgstus = 'S') AND
                      cl_null(g_fabg_m.fabg012) THEN
                   LET la_param.prog = 'afap270'
                   LET la_param.param[1] = g_fabg_m.fabgld
                   LET la_param.param[2] = g_fabg_m.fabgdocno
                   LET la_param.param[3] = g_fabg_m.fabg005
                   LET ls_js = util.JSON.stringify(la_param)
                   CALL cl_cmdrun_wait(ls_js)
                   CALL afat510_ui_headershow()
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_axrt300_13
            LET g_action_choice="open_axrt300_13"
            IF cl_auth_chk_act("open_axrt300_13") THEN
               
               #add-point:ON ACTION open_axrt300_13 name="menu.open_axrt300_13"
               IF NOT cl_null(g_fabg_m.fabgdocno) THEN 
                  #获取单别
                  CALL s_aooi200_get_slip(g_fabg_m.fabgdocno) RETURNING l_success,l_slip
                   
                  #是否抛傳票
                  CALL s_fin_get_doc_para(g_fabg_m.fabgld,g_fabg_m.fabgcomp,l_slip,'D-FIN-0030') RETURNING l_ooac004
                   
                  IF l_ooac004 = 'N' OR cl_null(l_ooac004) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = l_slip
                     LET g_errparam.code   = 'axr-00225'
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                   
                     EXIT DIALOG
                  END IF
               
                  IF g_glaa.glaa121 = 'Y' THEN 
                     CALL s_pre_voucher('FA','F50',g_fabg_m.fabgld,g_fabg_m.fabgdocno,g_fabg_m.fabgdocdt)
                  ELSE
                     CALL s_transaction_begin()
                     LET l_wc = "fabgdocno = '",g_fabg_m.fabgdocno,"'"
                     CALL afap280_01_gen_ar('44',g_fabg_m.fabgld,'','','1',l_wc,'Y','afat510') RETURNING l_success
                     IF l_success THEN
                        CALL s_transaction_end('Y','0')
                     ELSE
                        CALL s_transaction_end('N','0')
                     END IF
                     CALL axrt300_13('FA',g_fabg_m.fabgld,g_fabg_m.fabgdocno,'')
                  END IF
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_fabg012
            LET g_action_choice="prog_fabg012"
            IF cl_auth_chk_act("prog_fabg012") THEN
               
               #add-point:ON ACTION prog_fabg012 name="menu.prog_fabg012"
               #應用 a41 樣板自動產生(Version:3)
               #使用JSON格式組合參數與作業編號(串查)
               IF NOT cl_null(g_fabg_m.fabg012) THEN 
                  INITIALIZE la_param.* TO NULL
                  LET la_param.prog     = 'aapt301'
                  LET la_param.param[1] = g_fabg_m.fabgld
                  LET la_param.param[2] = g_fabg_m.fabg012
                  
                  LET ls_js = util.JSON.stringify(la_param)
                  CALL cl_cmdrun_wait(ls_js)
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_fabg008
            LET g_action_choice="prog_fabg008"
            IF cl_auth_chk_act("prog_fabg008") THEN
               
               #add-point:ON ACTION prog_fabg008 name="menu.prog_fabg008"
               #應用 a41 樣板自動產生(Version:3)
               #使用JSON格式組合參數與作業編號(串查)
               IF NOT cl_null(g_fabg_m.fabg008) THEN 
                  INITIALIZE la_param.* TO NULL
                  LET la_param.prog     = 'aglt310'
                  LET la_param.param[1] = g_fabg_m.fabgld
                  LET la_param.param[2] = g_fabg_m.fabg008
                  
                  LET ls_js = util.JSON.stringify(la_param)
                  CALL cl_cmdrun_wait(ls_js)
               END IF
               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL afat510_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL afat510_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL afat510_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_fabg_m.fabgdocdt)
 
 
 
         
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
 
{<section id="afat510.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION afat510_browser_fill(ps_page_action)
   #add-point:browser_fill段define(客製用) name="browser_fill.define_customerization"
   
   #end add-point  
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   DEFINE l_ld_str          STRING
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
   LET l_wc = l_wc," AND fabg005='44' "

   #账套范围
   CALL s_axrt300_get_site(g_user,'','2')  RETURNING g_wc_cs_ld 
   IF NOT cl_null(g_wc_cs_ld) THEN   
      LET l_ld_str = cl_replace_str(g_wc_cs_ld,"glaald","fabgld")
      LET l_wc = l_wc , " AND ",l_ld_str
   END IF

   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT fabgld,fabgdocno ",
                      " FROM fabg_t ",
                      " ",
                      " LEFT JOIN faca_t ON facaent = fabgent AND fabgld = facald AND fabgdocno = facadocno ", "  ",
                      #add-point:browser_fill段sql(faca_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
                      " LEFT JOIN xrcd_t ON xrcdent = fabgent AND fabgld = xrcdld AND fabgdocno = xrcddocno", "  ",
                      #add-point:browser_fill段sql(xrcd_t1) name="browser_fill.cnt.join.xrcd_t1"
                      
                      #end add-point
 
 
 
                      " ", 
                      " ", 
                      " ",                      
 
 
 
                      " WHERE fabgent = " ||g_enterprise|| " AND facaent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("fabg_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT fabgld,fabgdocno ",
                      " FROM fabg_t ", 
                      "  ",
                      "  ",
                      " WHERE fabgent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("fabg_t")
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
      INITIALIZE g_fabg_m.* TO NULL
      CALL g_faca_d.clear()        
      CALL g_faca2_d.clear() 
      CALL g_faca3_d.clear() 
      CALL g_faca5_d.clear() 
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.fabgld,t0.fabgdocno Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.fabgstus,t0.fabgld,t0.fabgdocno ",
                  " FROM fabg_t t0",
                  "  ",
                  "  LEFT JOIN faca_t ON facaent = fabgent AND fabgld = facald AND fabgdocno = facadocno ", "  ", 
                  #add-point:browser_fill段sql(faca_t1) name="browser_fill.join.faca_t1"
                  
                  #end add-point
                  "  LEFT JOIN xrcd_t ON xrcdent = fabgent AND fabgld = xrcdld AND fabgdocno = xrcddocno", "  ", 
                  #add-point:browser_fill段sql(xrcd_t1) name="browser_fill.join.xrcd_t1"
                  
                  #end add-point
 
 
 
                  " ", 
                  " ",                      
 
 
 
                  
                  " WHERE t0.fabgent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("fabg_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.fabgstus,t0.fabgld,t0.fabgdocno ",
                  " FROM fabg_t t0",
                  "  ",
                  
                  " WHERE t0.fabgent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("fabg_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
      LET g_sql = g_sql," AND EXISTS (SELECT 1 FROM pmaa_t ",
                        "              WHERE pmaaent = ",g_enterprise,
                        "                AND ",g_sql_ctrl,
                        "                AND pmaaent = fabgent ",
                        "                AND pmaa001 = fabg006 )"
   END IF
   #end add-point
   LET g_sql = g_sql, " ORDER BY fabgld,fabgdocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"fabg_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_fabgld,g_browser[g_cnt].b_fabgdocno 
 
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
         WHEN "A"
            LET g_browser[g_cnt].b_statepic = "stus/16/approved.png"
         WHEN "D"
            LET g_browser[g_cnt].b_statepic = "stus/16/withdraw.png"
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/unconfirmed.png"
         WHEN "R"
            LET g_browser[g_cnt].b_statepic = "stus/16/rejection.png"
         WHEN "W"
            LET g_browser[g_cnt].b_statepic = "stus/16/signing.png"
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/confirmed.png"
         WHEN "Z"
            LET g_browser[g_cnt].b_statepic = "stus/16/unposted.png"
         WHEN "S"
            LET g_browser[g_cnt].b_statepic = "stus/16/posted.png"
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
   
   IF cl_null(g_browser[g_cnt].b_fabgld) THEN
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
 
{<section id="afat510.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION afat510_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_fabg_m.fabgld = g_browser[g_current_idx].b_fabgld   
   LET g_fabg_m.fabgdocno = g_browser[g_current_idx].b_fabgdocno   
 
   EXECUTE afat510_master_referesh USING g_fabg_m.fabgld,g_fabg_m.fabgdocno INTO g_fabg_m.fabgsite,g_fabg_m.fabg001, 
       g_fabg_m.fabgld,g_fabg_m.fabgcomp,g_fabg_m.fabg005,g_fabg_m.fabgdocno,g_fabg_m.fabgdocdt,g_fabg_m.fabg010, 
       g_fabg_m.fabg018,g_fabg_m.fabg017,g_fabg_m.fabg006,g_fabg_m.fabg007,g_fabg_m.fabg013,g_fabg_m.fabg014, 
       g_fabg_m.fabg015,g_fabg_m.fabg016,g_fabg_m.fabg012,g_fabg_m.fabg008,g_fabg_m.fabgstus,g_fabg_m.fabgownid, 
       g_fabg_m.fabgowndp,g_fabg_m.fabgcrtid,g_fabg_m.fabgcrtdp,g_fabg_m.fabgcrtdt,g_fabg_m.fabgmodid, 
       g_fabg_m.fabgmoddt,g_fabg_m.fabgcnfid,g_fabg_m.fabgcnfdt,g_fabg_m.fabgpstid,g_fabg_m.fabgpstdt, 
       g_fabg_m.fabgsite_desc,g_fabg_m.fabg001_desc,g_fabg_m.fabgld_desc,g_fabg_m.fabg010_desc,g_fabg_m.fabg018_desc, 
       g_fabg_m.fabg006_desc,g_fabg_m.fabg007_desc,g_fabg_m.fabgownid_desc,g_fabg_m.fabgowndp_desc,g_fabg_m.fabgcrtid_desc, 
       g_fabg_m.fabgcrtdp_desc,g_fabg_m.fabgmodid_desc,g_fabg_m.fabgcnfid_desc,g_fabg_m.fabgpstid_desc 
 
   
   CALL afat510_fabg_t_mask()
   CALL afat510_show()
      
END FUNCTION
 
{</section>}
 
{<section id="afat510.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION afat510_ui_detailshow()
   #add-point:ui_detailshow段define(客製用) name="ui_detailshow.define_customerization"
   
   #end add-point    
   #add-point:ui_detailshow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_detailshow.define"
   
   #end add-point    
 
   #add-point:Function前置處理 name="ui_detailshow.before"
   
   #end add-point    
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
      CALL g_curr_diag.setCurrentRow("s_detail3",g_detail_idx)
      CALL g_curr_diag.setCurrentRow("s_detail5",g_detail_idx)
 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="afat510.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION afat510_ui_browser_refresh()
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
      IF g_browser[l_i].b_fabgld = g_fabg_m.fabgld 
         AND g_browser[l_i].b_fabgdocno = g_fabg_m.fabgdocno 
 
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
 
{<section id="afat510.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION afat510_construct()
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
   DEFINE l_comp_str  STRING
   #end add-point    
   
   #add-point:Function前置處理  name="cs.pre_function"
   
   #end add-point
    
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_fabg_m.* TO NULL
   CALL g_faca_d.clear()        
   CALL g_faca2_d.clear() 
   CALL g_faca3_d.clear() 
   CALL g_faca5_d.clear() 
 
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
   INITIALIZE g_wc2_table2 TO NULL
 
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前 name="cs.before_construct"
   LET g_site_str = NULL
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON fabgsite,fabg001,fabgld,fabgcomp,fabg005,fabgdocno,fabgdocdt,fabg010, 
          fabg018,fabg017,fabg006,fabg007,fabg013,fabg014,fabg015,fabg016,fabg012,fabg008,fabgstus,fabgownid, 
          fabgowndp,fabgcrtid,fabgcrtdp,fabgcrtdt,fabgmodid,fabgmoddt,fabgcnfid,fabgcnfdt,fabgpstid, 
          fabgpstdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<fabgcrtdt>>----
         AFTER FIELD fabgcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<fabgmoddt>>----
         AFTER FIELD fabgmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<fabgcnfdt>>----
         AFTER FIELD fabgcnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<fabgpstdt>>----
         AFTER FIELD fabgpstdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.fabgsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabgsite
            #add-point:ON ACTION controlp INFIELD fabgsite name="construct.c.fabgsite"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001_47()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabgsite  #顯示到畫面上
            NEXT FIELD fabgsite                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabgsite
            #add-point:BEFORE FIELD fabgsite name="construct.b.fabgsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabgsite
            
            #add-point:AFTER FIELD fabgsite name="construct.a.fabgsite"
            CALL FGL_DIALOG_GETBUFFER() RETURNING g_site_str
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabg001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabg001
            #add-point:ON ACTION controlp INFIELD fabg001 name="construct.c.fabg001"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabg001  #顯示到畫面上
            NEXT FIELD fabg001                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabg001
            #add-point:BEFORE FIELD fabg001 name="construct.b.fabg001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabg001
            
            #add-point:AFTER FIELD fabg001 name="construct.a.fabg001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabgld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabgld
            #add-point:ON ACTION controlp INFIELD fabgld name="construct.c.fabgld"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            CALL s_axrt300_get_site(g_user,g_site_str,'2')  RETURNING g_wc_cs_ld 
            IF NOT cl_null(g_wc_cs_ld) THEN   
               LET g_qryparam.where = g_wc_cs_ld
            END IF
            CALL q_authorised_ld()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabgld  #顯示到畫面上
            NEXT FIELD fabgld                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabgld
            #add-point:BEFORE FIELD fabgld name="construct.b.fabgld"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabgld
            
            #add-point:AFTER FIELD fabgld name="construct.a.fabgld"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabgcomp
            #add-point:BEFORE FIELD fabgcomp name="construct.b.fabgcomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabgcomp
            
            #add-point:AFTER FIELD fabgcomp name="construct.a.fabgcomp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabgcomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabgcomp
            #add-point:ON ACTION controlp INFIELD fabgcomp name="construct.c.fabgcomp"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabg005
            #add-point:BEFORE FIELD fabg005 name="construct.b.fabg005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabg005
            
            #add-point:AFTER FIELD fabg005 name="construct.a.fabg005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabg005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabg005
            #add-point:ON ACTION controlp INFIELD fabg005 name="construct.c.fabg005"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fabgdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabgdocno
            #add-point:ON ACTION controlp INFIELD fabgdocno name="construct.c.fabgdocno"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " fabg005='44' "
            #161104-00046#16 --s add
            #單別權限控管
            IF NOT cl_null(g_user_dept_wc_q) AND NOT g_user_dept_wc_q = ' 1=1'  THEN
               LET g_qryparam.where = g_qryparam.where," AND ",g_user_dept_wc_q CLIPPED
            END IF
            #161104-00046#16 --e add	            
            CALL q_fabgdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabgdocno  #顯示到畫面上
            NEXT FIELD fabgdocno                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabgdocno
            #add-point:BEFORE FIELD fabgdocno name="construct.b.fabgdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabgdocno
            
            #add-point:AFTER FIELD fabgdocno name="construct.a.fabgdocno"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabgdocdt
            #add-point:BEFORE FIELD fabgdocdt name="construct.b.fabgdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabgdocdt
            
            #add-point:AFTER FIELD fabgdocdt name="construct.a.fabgdocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabgdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabgdocdt
            #add-point:ON ACTION controlp INFIELD fabgdocdt name="construct.c.fabgdocdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fabg010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabg010
            #add-point:ON ACTION controlp INFIELD fabg010 name="construct.c.fabg010"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            CALL s_axrt300_get_site(g_user,g_site_str,'1') RETURNING l_comp_str
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabg010  #顯示到畫面上
            NEXT FIELD fabg010                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabg010
            #add-point:BEFORE FIELD fabg010 name="construct.b.fabg010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabg010
            
            #add-point:AFTER FIELD fabg010 name="construct.a.fabg010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabg018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabg018
            #add-point:ON ACTION controlp INFIELD fabg018 name="construct.c.fabg018"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            CALL s_axrt300_get_site(g_user,g_site_str,'1') RETURNING l_comp_str
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooef204 = 'Y' AND ",l_comp_str CLIPPED
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabg018  #顯示到畫面上
            NEXT FIELD fabg018                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabg018
            #add-point:BEFORE FIELD fabg018 name="construct.b.fabg018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabg018
            
            #add-point:AFTER FIELD fabg018 name="construct.a.fabg018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabg017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabg017
            #add-point:ON ACTION controlp INFIELD fabg017 name="construct.c.fabg017"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_fabx010()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabg017  #顯示到畫面上
            NEXT FIELD fabg017                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabg017
            #add-point:BEFORE FIELD fabg017 name="construct.b.fabg017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabg017
            
            #add-point:AFTER FIELD fabg017 name="construct.a.fabg017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabg006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabg006
            #add-point:ON ACTION controlp INFIELD fabg006 name="construct.c.fabg006"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_qryparam.where," AND ",g_sql_ctrl
            END IF
            LET g_qryparam.arg1="('1','3')"
            CALL q_pmaa001_1()
            DISPLAY g_qryparam.return1 TO fabg006  #顯示到畫面上
            NEXT FIELD fabg006                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabg006
            #add-point:BEFORE FIELD fabg006 name="construct.b.fabg006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabg006
            
            #add-point:AFTER FIELD fabg006 name="construct.a.fabg006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabg007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabg007
            #add-point:ON ACTION controlp INFIELD fabg007 name="construct.c.fabg007"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = " EXISTS (SELECT 1 FROM pmaa_t ",
                                      "          WHERE pmaaent = ",g_enterprise,
                                      "            AND ",g_sql_ctrl,
                                      "            AND pmaaent = pmacent ",
                                      "            AND pmaa001 = pmac002 )"
            END IF
            CALL q_pmac002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabg007  #顯示到畫面上
            NEXT FIELD fabg007                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabg007
            #add-point:BEFORE FIELD fabg007 name="construct.b.fabg007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabg007
            
            #add-point:AFTER FIELD fabg007 name="construct.a.fabg007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabg013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabg013
            #add-point:ON ACTION controlp INFIELD fabg013 name="construct.c.fabg013"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oodb002_5()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabg013  #顯示到畫面上
            NEXT FIELD fabg013                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabg013
            #add-point:BEFORE FIELD fabg013 name="construct.b.fabg013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabg013
            
            #add-point:AFTER FIELD fabg013 name="construct.a.fabg013"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabg014
            #add-point:BEFORE FIELD fabg014 name="construct.b.fabg014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabg014
            
            #add-point:AFTER FIELD fabg014 name="construct.a.fabg014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabg014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabg014
            #add-point:ON ACTION controlp INFIELD fabg014 name="construct.c.fabg014"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fabg015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabg015
            #add-point:ON ACTION controlp INFIELD fabg015 name="construct.c.fabg015"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabg015  #顯示到畫面上
            NEXT FIELD fabg015                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabg015
            #add-point:BEFORE FIELD fabg015 name="construct.b.fabg015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabg015
            
            #add-point:AFTER FIELD fabg015 name="construct.a.fabg015"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabg016
            #add-point:BEFORE FIELD fabg016 name="construct.b.fabg016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabg016
            
            #add-point:AFTER FIELD fabg016 name="construct.a.fabg016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabg016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabg016
            #add-point:ON ACTION controlp INFIELD fabg016 name="construct.c.fabg016"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabg012
            #add-point:BEFORE FIELD fabg012 name="construct.b.fabg012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabg012
            
            #add-point:AFTER FIELD fabg012 name="construct.a.fabg012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabg012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabg012
            #add-point:ON ACTION controlp INFIELD fabg012 name="construct.c.fabg012"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fabg008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabg008
            #add-point:ON ACTION controlp INFIELD fabg008 name="construct.c.fabg008"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_fabg008()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabg008  #顯示到畫面上
            NEXT FIELD fabg008                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabg008
            #add-point:BEFORE FIELD fabg008 name="construct.b.fabg008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabg008
            
            #add-point:AFTER FIELD fabg008 name="construct.a.fabg008"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabgstus
            #add-point:BEFORE FIELD fabgstus name="construct.b.fabgstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabgstus
            
            #add-point:AFTER FIELD fabgstus name="construct.a.fabgstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabgstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabgstus
            #add-point:ON ACTION controlp INFIELD fabgstus name="construct.c.fabgstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fabgownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabgownid
            #add-point:ON ACTION controlp INFIELD fabgownid name="construct.c.fabgownid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabgownid  #顯示到畫面上
            NEXT FIELD fabgownid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabgownid
            #add-point:BEFORE FIELD fabgownid name="construct.b.fabgownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabgownid
            
            #add-point:AFTER FIELD fabgownid name="construct.a.fabgownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabgowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabgowndp
            #add-point:ON ACTION controlp INFIELD fabgowndp name="construct.c.fabgowndp"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabgowndp  #顯示到畫面上
            NEXT FIELD fabgowndp                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabgowndp
            #add-point:BEFORE FIELD fabgowndp name="construct.b.fabgowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabgowndp
            
            #add-point:AFTER FIELD fabgowndp name="construct.a.fabgowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabgcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabgcrtid
            #add-point:ON ACTION controlp INFIELD fabgcrtid name="construct.c.fabgcrtid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabgcrtid  #顯示到畫面上
            NEXT FIELD fabgcrtid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabgcrtid
            #add-point:BEFORE FIELD fabgcrtid name="construct.b.fabgcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabgcrtid
            
            #add-point:AFTER FIELD fabgcrtid name="construct.a.fabgcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabgcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabgcrtdp
            #add-point:ON ACTION controlp INFIELD fabgcrtdp name="construct.c.fabgcrtdp"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabgcrtdp  #顯示到畫面上
            NEXT FIELD fabgcrtdp                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabgcrtdp
            #add-point:BEFORE FIELD fabgcrtdp name="construct.b.fabgcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabgcrtdp
            
            #add-point:AFTER FIELD fabgcrtdp name="construct.a.fabgcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabgcrtdt
            #add-point:BEFORE FIELD fabgcrtdt name="construct.b.fabgcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fabgmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabgmodid
            #add-point:ON ACTION controlp INFIELD fabgmodid name="construct.c.fabgmodid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabgmodid  #顯示到畫面上
            NEXT FIELD fabgmodid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabgmodid
            #add-point:BEFORE FIELD fabgmodid name="construct.b.fabgmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabgmodid
            
            #add-point:AFTER FIELD fabgmodid name="construct.a.fabgmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabgmoddt
            #add-point:BEFORE FIELD fabgmoddt name="construct.b.fabgmoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fabgcnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabgcnfid
            #add-point:ON ACTION controlp INFIELD fabgcnfid name="construct.c.fabgcnfid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabgcnfid  #顯示到畫面上
            NEXT FIELD fabgcnfid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabgcnfid
            #add-point:BEFORE FIELD fabgcnfid name="construct.b.fabgcnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabgcnfid
            
            #add-point:AFTER FIELD fabgcnfid name="construct.a.fabgcnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabgcnfdt
            #add-point:BEFORE FIELD fabgcnfdt name="construct.b.fabgcnfdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fabgpstid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabgpstid
            #add-point:ON ACTION controlp INFIELD fabgpstid name="construct.c.fabgpstid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabgpstid  #顯示到畫面上
            NEXT FIELD fabgpstid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabgpstid
            #add-point:BEFORE FIELD fabgpstid name="construct.b.fabgpstid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabgpstid
            
            #add-point:AFTER FIELD fabgpstid name="construct.a.fabgpstid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabgpstdt
            #add-point:BEFORE FIELD fabgpstdt name="construct.b.fabgpstdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON facaseq,faca001,faca002,faca003,faca004,faca005,faca008,faca009,faca010, 
          faca017,faca007,faca011,faca012,faca013,faca014,faca015,faca016,faca018,faca024,faca019,faca019_desc, 
          faca036,faca025,faca025_desc,faca026,faca026_desc,faca027,faca027_desc,faca028,faca028_desc, 
          faca029,faca029_desc,faca030,faca030_desc,faca031,faca031_desc,faca032,faca032_desc,faca033, 
          faca033_desc,faca034,faca034_desc,faca052,faca053,faca053_desc,faca054,faca054_desc,faca065, 
          faca065_desc,faca055,faca055_desc,faca056,faca056_desc,faca057,faca057_desc,faca058,faca058_desc, 
          faca059,faca059_desc,faca060,faca060_desc,faca061,faca061_desc,faca062,faca062_desc,faca063, 
          faca063_desc,faca064,faca064_desc,faca043,faca038,faca039,faca040,faca041,faca042,faca044, 
          faca050,faca045,faca046,faca047,faca048,faca049,faca051
           FROM s_detail1[1].facaseq,s_detail1[1].faca001,s_detail1[1].faca002,s_detail1[1].faca003, 
               s_detail1[1].faca004,s_detail1[1].faca005,s_detail1[1].faca008,s_detail1[1].faca009,s_detail1[1].faca010, 
               s_detail1[1].faca017,s_detail1[1].faca007,s_detail1[1].faca011,s_detail1[1].faca012,s_detail1[1].faca013, 
               s_detail1[1].faca014,s_detail1[1].faca015,s_detail1[1].faca016,s_detail1[1].faca018,s_detail1[1].faca024, 
               s_detail2[1].faca019,s_detail2[1].faca019_desc,s_detail2[1].faca036,s_detail2[1].faca025, 
               s_detail2[1].faca025_desc,s_detail2[1].faca026,s_detail2[1].faca026_desc,s_detail2[1].faca027, 
               s_detail2[1].faca027_desc,s_detail2[1].faca028,s_detail2[1].faca028_desc,s_detail2[1].faca029, 
               s_detail2[1].faca029_desc,s_detail2[1].faca030,s_detail2[1].faca030_desc,s_detail2[1].faca031, 
               s_detail2[1].faca031_desc,s_detail2[1].faca032,s_detail2[1].faca032_desc,s_detail2[1].faca033, 
               s_detail2[1].faca033_desc,s_detail2[1].faca034,s_detail2[1].faca034_desc,s_detail2[1].faca052, 
               s_detail2[1].faca053,s_detail2[1].faca053_desc,s_detail2[1].faca054,s_detail2[1].faca054_desc, 
               s_detail2[1].faca065,s_detail2[1].faca065_desc,s_detail2[1].faca055,s_detail2[1].faca055_desc, 
               s_detail2[1].faca056,s_detail2[1].faca056_desc,s_detail2[1].faca057,s_detail2[1].faca057_desc, 
               s_detail2[1].faca058,s_detail2[1].faca058_desc,s_detail2[1].faca059,s_detail2[1].faca059_desc, 
               s_detail2[1].faca060,s_detail2[1].faca060_desc,s_detail2[1].faca061,s_detail2[1].faca061_desc, 
               s_detail2[1].faca062,s_detail2[1].faca062_desc,s_detail2[1].faca063,s_detail2[1].faca063_desc, 
               s_detail2[1].faca064,s_detail2[1].faca064_desc,s_detail5[1].faca043,s_detail5[1].faca038, 
               s_detail5[1].faca039,s_detail5[1].faca040,s_detail5[1].faca041,s_detail5[1].faca042,s_detail5[1].faca044, 
               s_detail5[1].faca050,s_detail5[1].faca045,s_detail5[1].faca046,s_detail5[1].faca047,s_detail5[1].faca048, 
               s_detail5[1].faca049,s_detail5[1].faca051
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD facaseq
            #add-point:BEFORE FIELD facaseq name="construct.b.page1.facaseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD facaseq
            
            #add-point:AFTER FIELD facaseq name="construct.a.page1.facaseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.facaseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD facaseq
            #add-point:ON ACTION controlp INFIELD facaseq name="construct.c.page1.facaseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca001
            #add-point:BEFORE FIELD faca001 name="construct.b.page1.faca001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca001
            
            #add-point:AFTER FIELD faca001 name="construct.a.page1.faca001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.faca001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca001
            #add-point:ON ACTION controlp INFIELD faca001 name="construct.c.page1.faca001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca002
            #add-point:BEFORE FIELD faca002 name="construct.b.page1.faca002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca002
            
            #add-point:AFTER FIELD faca002 name="construct.a.page1.faca002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.faca002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca002
            #add-point:ON ACTION controlp INFIELD faca002 name="construct.c.page1.faca002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca003
            #add-point:BEFORE FIELD faca003 name="construct.b.page1.faca003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca003
            
            #add-point:AFTER FIELD faca003 name="construct.a.page1.faca003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.faca003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca003
            #add-point:ON ACTION controlp INFIELD faca003 name="construct.c.page1.faca003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca004
            #add-point:BEFORE FIELD faca004 name="construct.b.page1.faca004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca004
            
            #add-point:AFTER FIELD faca004 name="construct.a.page1.faca004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.faca004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca004
            #add-point:ON ACTION controlp INFIELD faca004 name="construct.c.page1.faca004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca005
            #add-point:BEFORE FIELD faca005 name="construct.b.page1.faca005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca005
            
            #add-point:AFTER FIELD faca005 name="construct.a.page1.faca005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.faca005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca005
            #add-point:ON ACTION controlp INFIELD faca005 name="construct.c.page1.faca005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca008
            #add-point:BEFORE FIELD faca008 name="construct.b.page1.faca008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca008
            
            #add-point:AFTER FIELD faca008 name="construct.a.page1.faca008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.faca008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca008
            #add-point:ON ACTION controlp INFIELD faca008 name="construct.c.page1.faca008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca009
            #add-point:BEFORE FIELD faca009 name="construct.b.page1.faca009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca009
            
            #add-point:AFTER FIELD faca009 name="construct.a.page1.faca009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.faca009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca009
            #add-point:ON ACTION controlp INFIELD faca009 name="construct.c.page1.faca009"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.faca010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca010
            #add-point:ON ACTION controlp INFIELD faca010 name="construct.c.page1.faca010"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oodb002_5()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faca010  #顯示到畫面上
            NEXT FIELD faca010                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca010
            #add-point:BEFORE FIELD faca010 name="construct.b.page1.faca010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca010
            
            #add-point:AFTER FIELD faca010 name="construct.a.page1.faca010"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca017
            #add-point:BEFORE FIELD faca017 name="construct.b.page1.faca017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca017
            
            #add-point:AFTER FIELD faca017 name="construct.a.page1.faca017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.faca017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca017
            #add-point:ON ACTION controlp INFIELD faca017 name="construct.c.page1.faca017"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca007
            #add-point:BEFORE FIELD faca007 name="construct.b.page1.faca007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca007
            
            #add-point:AFTER FIELD faca007 name="construct.a.page1.faca007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.faca007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca007
            #add-point:ON ACTION controlp INFIELD faca007 name="construct.c.page1.faca007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca011
            #add-point:BEFORE FIELD faca011 name="construct.b.page1.faca011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca011
            
            #add-point:AFTER FIELD faca011 name="construct.a.page1.faca011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.faca011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca011
            #add-point:ON ACTION controlp INFIELD faca011 name="construct.c.page1.faca011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca012
            #add-point:BEFORE FIELD faca012 name="construct.b.page1.faca012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca012
            
            #add-point:AFTER FIELD faca012 name="construct.a.page1.faca012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.faca012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca012
            #add-point:ON ACTION controlp INFIELD faca012 name="construct.c.page1.faca012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca013
            #add-point:BEFORE FIELD faca013 name="construct.b.page1.faca013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca013
            
            #add-point:AFTER FIELD faca013 name="construct.a.page1.faca013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.faca013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca013
            #add-point:ON ACTION controlp INFIELD faca013 name="construct.c.page1.faca013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca014
            #add-point:BEFORE FIELD faca014 name="construct.b.page1.faca014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca014
            
            #add-point:AFTER FIELD faca014 name="construct.a.page1.faca014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.faca014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca014
            #add-point:ON ACTION controlp INFIELD faca014 name="construct.c.page1.faca014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca015
            #add-point:BEFORE FIELD faca015 name="construct.b.page1.faca015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca015
            
            #add-point:AFTER FIELD faca015 name="construct.a.page1.faca015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.faca015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca015
            #add-point:ON ACTION controlp INFIELD faca015 name="construct.c.page1.faca015"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca016
            #add-point:BEFORE FIELD faca016 name="construct.b.page1.faca016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca016
            
            #add-point:AFTER FIELD faca016 name="construct.a.page1.faca016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.faca016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca016
            #add-point:ON ACTION controlp INFIELD faca016 name="construct.c.page1.faca016"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca018
            #add-point:BEFORE FIELD faca018 name="construct.b.page1.faca018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca018
            
            #add-point:AFTER FIELD faca018 name="construct.a.page1.faca018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.faca018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca018
            #add-point:ON ACTION controlp INFIELD faca018 name="construct.c.page1.faca018"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca024
            #add-point:BEFORE FIELD faca024 name="construct.b.page1.faca024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca024
            
            #add-point:AFTER FIELD faca024 name="construct.a.page1.faca024"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.faca024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca024
            #add-point:ON ACTION controlp INFIELD faca024 name="construct.c.page1.faca024"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.faca019
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca019
            #add-point:ON ACTION controlp INFIELD faca019 name="construct.c.page2.faca019"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL aglt310_04()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faca019  #顯示到畫面上
            NEXT FIELD faca019                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca019
            #add-point:BEFORE FIELD faca019 name="construct.b.page2.faca019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca019
            
            #add-point:AFTER FIELD faca019 name="construct.a.page2.faca019"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca019_desc
            #add-point:BEFORE FIELD faca019_desc name="construct.b.page2.faca019_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca019_desc
            
            #add-point:AFTER FIELD faca019_desc name="construct.a.page2.faca019_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.faca019_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca019_desc
            #add-point:ON ACTION controlp INFIELD faca019_desc name="construct.c.page2.faca019_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca036
            #add-point:BEFORE FIELD faca036 name="construct.b.page2.faca036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca036
            
            #add-point:AFTER FIELD faca036 name="construct.a.page2.faca036"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.faca036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca036
            #add-point:ON ACTION controlp INFIELD faca036 name="construct.c.page2.faca036"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca025
            #add-point:BEFORE FIELD faca025 name="construct.b.page2.faca025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca025
            
            #add-point:AFTER FIELD faca025 name="construct.a.page2.faca025"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.faca025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca025
            #add-point:ON ACTION controlp INFIELD faca025 name="construct.c.page2.faca025"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.faca025_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca025_desc
            #add-point:ON ACTION controlp INFIELD faca025_desc name="construct.c.page2.faca025_desc"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faca025_desc  #顯示到畫面上
            NEXT FIELD faca025_desc                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca025_desc
            #add-point:BEFORE FIELD faca025_desc name="construct.b.page2.faca025_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca025_desc
            
            #add-point:AFTER FIELD faca025_desc name="construct.a.page2.faca025_desc"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca026
            #add-point:BEFORE FIELD faca026 name="construct.b.page2.faca026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca026
            
            #add-point:AFTER FIELD faca026 name="construct.a.page2.faca026"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.faca026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca026
            #add-point:ON ACTION controlp INFIELD faca026 name="construct.c.page2.faca026"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.faca026_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca026_desc
            #add-point:ON ACTION controlp INFIELD faca026_desc name="construct.c.page2.faca026_desc"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_today
            CALL q_ooeg001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faca026_desc  #顯示到畫面上
            NEXT FIELD faca026_desc                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca026_desc
            #add-point:BEFORE FIELD faca026_desc name="construct.b.page2.faca026_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca026_desc
            
            #add-point:AFTER FIELD faca026_desc name="construct.a.page2.faca026_desc"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca027
            #add-point:BEFORE FIELD faca027 name="construct.b.page2.faca027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca027
            
            #add-point:AFTER FIELD faca027 name="construct.a.page2.faca027"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.faca027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca027
            #add-point:ON ACTION controlp INFIELD faca027 name="construct.c.page2.faca027"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.faca027_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca027_desc
            #add-point:ON ACTION controlp INFIELD faca027_desc name="construct.c.page2.faca027_desc"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_today
            LET g_qryparam.where = " ooeg003 IN ('2','3')"
            CALL q_ooeg001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faca027_desc  #顯示到畫面上
            NEXT FIELD faca027_desc                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca027_desc
            #add-point:BEFORE FIELD faca027_desc name="construct.b.page2.faca027_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca027_desc
            
            #add-point:AFTER FIELD faca027_desc name="construct.a.page2.faca027_desc"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca028
            #add-point:BEFORE FIELD faca028 name="construct.b.page2.faca028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca028
            
            #add-point:AFTER FIELD faca028 name="construct.a.page2.faca028"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.faca028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca028
            #add-point:ON ACTION controlp INFIELD faca028 name="construct.c.page2.faca028"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.faca028_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca028_desc
            #add-point:ON ACTION controlp INFIELD faca028_desc name="construct.c.page2.faca028_desc"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_287()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faca028_desc  #顯示到畫面上
            NEXT FIELD faca028_desc                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca028_desc
            #add-point:BEFORE FIELD faca028_desc name="construct.b.page2.faca028_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca028_desc
            
            #add-point:AFTER FIELD faca028_desc name="construct.a.page2.faca028_desc"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca029
            #add-point:BEFORE FIELD faca029 name="construct.b.page2.faca029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca029
            
            #add-point:AFTER FIELD faca029 name="construct.a.page2.faca029"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.faca029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca029
            #add-point:ON ACTION controlp INFIELD faca029 name="construct.c.page2.faca029"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.faca029_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca029_desc
            #add-point:ON ACTION controlp INFIELD faca029_desc name="construct.c.page2.faca029_desc"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_25()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faca029_desc  #顯示到畫面上
            NEXT FIELD faca029_desc                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca029_desc
            #add-point:BEFORE FIELD faca029_desc name="construct.b.page2.faca029_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca029_desc
            
            #add-point:AFTER FIELD faca029_desc name="construct.a.page2.faca029_desc"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca030
            #add-point:BEFORE FIELD faca030 name="construct.b.page2.faca030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca030
            
            #add-point:AFTER FIELD faca030 name="construct.a.page2.faca030"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.faca030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca030
            #add-point:ON ACTION controlp INFIELD faca030 name="construct.c.page2.faca030"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.faca030_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca030_desc
            #add-point:ON ACTION controlp INFIELD faca030_desc name="construct.c.page2.faca030_desc"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_25()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faca030_desc  #顯示到畫面上
            NEXT FIELD faca030_desc                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca030_desc
            #add-point:BEFORE FIELD faca030_desc name="construct.b.page2.faca030_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca030_desc
            
            #add-point:AFTER FIELD faca030_desc name="construct.a.page2.faca030_desc"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca031
            #add-point:BEFORE FIELD faca031 name="construct.b.page2.faca031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca031
            
            #add-point:AFTER FIELD faca031 name="construct.a.page2.faca031"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.faca031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca031
            #add-point:ON ACTION controlp INFIELD faca031 name="construct.c.page2.faca031"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.faca031_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca031_desc
            #add-point:ON ACTION controlp INFIELD faca031_desc name="construct.c.page2.faca031_desc"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_281()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faca031_desc  #顯示到畫面上
            NEXT FIELD faca031_desc                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca031_desc
            #add-point:BEFORE FIELD faca031_desc name="construct.b.page2.faca031_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca031_desc
            
            #add-point:AFTER FIELD faca031_desc name="construct.a.page2.faca031_desc"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca032
            #add-point:BEFORE FIELD faca032 name="construct.b.page2.faca032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca032
            
            #add-point:AFTER FIELD faca032 name="construct.a.page2.faca032"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.faca032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca032
            #add-point:ON ACTION controlp INFIELD faca032 name="construct.c.page2.faca032"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.faca032_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca032_desc
            #add-point:ON ACTION controlp INFIELD faca032_desc name="construct.c.page2.faca032_desc"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001_8()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faca032_desc  #顯示到畫面上
            NEXT FIELD faca032_desc                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca032_desc
            #add-point:BEFORE FIELD faca032_desc name="construct.b.page2.faca032_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca032_desc
            
            #add-point:AFTER FIELD faca032_desc name="construct.a.page2.faca032_desc"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca033
            #add-point:BEFORE FIELD faca033 name="construct.b.page2.faca033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca033
            
            #add-point:AFTER FIELD faca033 name="construct.a.page2.faca033"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.faca033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca033
            #add-point:ON ACTION controlp INFIELD faca033 name="construct.c.page2.faca033"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.faca033_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca033_desc
            #add-point:ON ACTION controlp INFIELD faca033_desc name="construct.c.page2.faca033_desc"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pjba001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faca033_desc  #顯示到畫面上
            NEXT FIELD faca033_desc                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca033_desc
            #add-point:BEFORE FIELD faca033_desc name="construct.b.page2.faca033_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca033_desc
            
            #add-point:AFTER FIELD faca033_desc name="construct.a.page2.faca033_desc"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca034
            #add-point:BEFORE FIELD faca034 name="construct.b.page2.faca034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca034
            
            #add-point:AFTER FIELD faca034 name="construct.a.page2.faca034"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.faca034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca034
            #add-point:ON ACTION controlp INFIELD faca034 name="construct.c.page2.faca034"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.faca034_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca034_desc
            #add-point:ON ACTION controlp INFIELD faca034_desc name="construct.c.page2.faca034_desc"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pjbb002_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faca034_desc  #顯示到畫面上
            NEXT FIELD faca034_desc                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca034_desc
            #add-point:BEFORE FIELD faca034_desc name="construct.b.page2.faca034_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca034_desc
            
            #add-point:AFTER FIELD faca034_desc name="construct.a.page2.faca034_desc"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca052
            #add-point:BEFORE FIELD faca052 name="construct.b.page2.faca052"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca052
            
            #add-point:AFTER FIELD faca052 name="construct.a.page2.faca052"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.faca052
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca052
            #add-point:ON ACTION controlp INFIELD faca052 name="construct.c.page2.faca052"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca053
            #add-point:BEFORE FIELD faca053 name="construct.b.page2.faca053"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca053
            
            #add-point:AFTER FIELD faca053 name="construct.a.page2.faca053"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.faca053
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca053
            #add-point:ON ACTION controlp INFIELD faca053 name="construct.c.page2.faca053"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca053_desc
            #add-point:BEFORE FIELD faca053_desc name="construct.b.page2.faca053_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca053_desc
            
            #add-point:AFTER FIELD faca053_desc name="construct.a.page2.faca053_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.faca053_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca053_desc
            #add-point:ON ACTION controlp INFIELD faca053_desc name="construct.c.page2.faca053_desc"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            CALL q_oojd001_2()
            DISPLAY g_qryparam.return1 TO faca053_desc
            NEXT FIELD faca053_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca054
            #add-point:BEFORE FIELD faca054 name="construct.b.page2.faca054"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca054
            
            #add-point:AFTER FIELD faca054 name="construct.a.page2.faca054"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.faca054
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca054
            #add-point:ON ACTION controlp INFIELD faca054 name="construct.c.page2.faca054"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca054_desc
            #add-point:BEFORE FIELD faca054_desc name="construct.b.page2.faca054_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca054_desc
            
            #add-point:AFTER FIELD faca054_desc name="construct.a.page2.faca054_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.faca054_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca054_desc
            #add-point:ON ACTION controlp INFIELD faca054_desc name="construct.c.page2.faca054_desc"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_2002()
            DISPLAY g_qryparam.return1 TO faca054_desc
            NEXT FIELD faca054_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca065
            #add-point:BEFORE FIELD faca065 name="construct.b.page2.faca065"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca065
            
            #add-point:AFTER FIELD faca065 name="construct.a.page2.faca065"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.faca065
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca065
            #add-point:ON ACTION controlp INFIELD faca065 name="construct.c.page2.faca065"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca065_desc
            #add-point:BEFORE FIELD faca065_desc name="construct.b.page2.faca065_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca065_desc
            
            #add-point:AFTER FIELD faca065_desc name="construct.a.page2.faca065_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.faca065_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca065_desc
            #add-point:ON ACTION controlp INFIELD faca065_desc name="construct.c.page2.faca065_desc"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " rtax004 = '",g_ooaa002,"'"
            CALL q_rtax001_1()
            DISPLAY g_qryparam.return1 TO faca065_desc
            NEXT FIELD faca065_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca055
            #add-point:BEFORE FIELD faca055 name="construct.b.page2.faca055"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca055
            
            #add-point:AFTER FIELD faca055 name="construct.a.page2.faca055"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.faca055
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca055
            #add-point:ON ACTION controlp INFIELD faca055 name="construct.c.page2.faca055"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca055_desc
            #add-point:BEFORE FIELD faca055_desc name="construct.b.page2.faca055_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca055_desc
            
            #add-point:AFTER FIELD faca055_desc name="construct.a.page2.faca055_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.faca055_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca055_desc
            #add-point:ON ACTION controlp INFIELD faca055_desc name="construct.c.page2.faca055_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca056
            #add-point:BEFORE FIELD faca056 name="construct.b.page2.faca056"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca056
            
            #add-point:AFTER FIELD faca056 name="construct.a.page2.faca056"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.faca056
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca056
            #add-point:ON ACTION controlp INFIELD faca056 name="construct.c.page2.faca056"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca056_desc
            #add-point:BEFORE FIELD faca056_desc name="construct.b.page2.faca056_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca056_desc
            
            #add-point:AFTER FIELD faca056_desc name="construct.a.page2.faca056_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.faca056_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca056_desc
            #add-point:ON ACTION controlp INFIELD faca056_desc name="construct.c.page2.faca056_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca057
            #add-point:BEFORE FIELD faca057 name="construct.b.page2.faca057"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca057
            
            #add-point:AFTER FIELD faca057 name="construct.a.page2.faca057"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.faca057
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca057
            #add-point:ON ACTION controlp INFIELD faca057 name="construct.c.page2.faca057"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca057_desc
            #add-point:BEFORE FIELD faca057_desc name="construct.b.page2.faca057_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca057_desc
            
            #add-point:AFTER FIELD faca057_desc name="construct.a.page2.faca057_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.faca057_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca057_desc
            #add-point:ON ACTION controlp INFIELD faca057_desc name="construct.c.page2.faca057_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca058
            #add-point:BEFORE FIELD faca058 name="construct.b.page2.faca058"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca058
            
            #add-point:AFTER FIELD faca058 name="construct.a.page2.faca058"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.faca058
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca058
            #add-point:ON ACTION controlp INFIELD faca058 name="construct.c.page2.faca058"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca058_desc
            #add-point:BEFORE FIELD faca058_desc name="construct.b.page2.faca058_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca058_desc
            
            #add-point:AFTER FIELD faca058_desc name="construct.a.page2.faca058_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.faca058_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca058_desc
            #add-point:ON ACTION controlp INFIELD faca058_desc name="construct.c.page2.faca058_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca059
            #add-point:BEFORE FIELD faca059 name="construct.b.page2.faca059"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca059
            
            #add-point:AFTER FIELD faca059 name="construct.a.page2.faca059"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.faca059
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca059
            #add-point:ON ACTION controlp INFIELD faca059 name="construct.c.page2.faca059"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca059_desc
            #add-point:BEFORE FIELD faca059_desc name="construct.b.page2.faca059_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca059_desc
            
            #add-point:AFTER FIELD faca059_desc name="construct.a.page2.faca059_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.faca059_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca059_desc
            #add-point:ON ACTION controlp INFIELD faca059_desc name="construct.c.page2.faca059_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca060
            #add-point:BEFORE FIELD faca060 name="construct.b.page2.faca060"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca060
            
            #add-point:AFTER FIELD faca060 name="construct.a.page2.faca060"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.faca060
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca060
            #add-point:ON ACTION controlp INFIELD faca060 name="construct.c.page2.faca060"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca060_desc
            #add-point:BEFORE FIELD faca060_desc name="construct.b.page2.faca060_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca060_desc
            
            #add-point:AFTER FIELD faca060_desc name="construct.a.page2.faca060_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.faca060_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca060_desc
            #add-point:ON ACTION controlp INFIELD faca060_desc name="construct.c.page2.faca060_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca061
            #add-point:BEFORE FIELD faca061 name="construct.b.page2.faca061"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca061
            
            #add-point:AFTER FIELD faca061 name="construct.a.page2.faca061"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.faca061
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca061
            #add-point:ON ACTION controlp INFIELD faca061 name="construct.c.page2.faca061"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca061_desc
            #add-point:BEFORE FIELD faca061_desc name="construct.b.page2.faca061_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca061_desc
            
            #add-point:AFTER FIELD faca061_desc name="construct.a.page2.faca061_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.faca061_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca061_desc
            #add-point:ON ACTION controlp INFIELD faca061_desc name="construct.c.page2.faca061_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca062
            #add-point:BEFORE FIELD faca062 name="construct.b.page2.faca062"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca062
            
            #add-point:AFTER FIELD faca062 name="construct.a.page2.faca062"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.faca062
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca062
            #add-point:ON ACTION controlp INFIELD faca062 name="construct.c.page2.faca062"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca062_desc
            #add-point:BEFORE FIELD faca062_desc name="construct.b.page2.faca062_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca062_desc
            
            #add-point:AFTER FIELD faca062_desc name="construct.a.page2.faca062_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.faca062_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca062_desc
            #add-point:ON ACTION controlp INFIELD faca062_desc name="construct.c.page2.faca062_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca063
            #add-point:BEFORE FIELD faca063 name="construct.b.page2.faca063"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca063
            
            #add-point:AFTER FIELD faca063 name="construct.a.page2.faca063"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.faca063
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca063
            #add-point:ON ACTION controlp INFIELD faca063 name="construct.c.page2.faca063"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca063_desc
            #add-point:BEFORE FIELD faca063_desc name="construct.b.page2.faca063_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca063_desc
            
            #add-point:AFTER FIELD faca063_desc name="construct.a.page2.faca063_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.faca063_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca063_desc
            #add-point:ON ACTION controlp INFIELD faca063_desc name="construct.c.page2.faca063_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca064
            #add-point:BEFORE FIELD faca064 name="construct.b.page2.faca064"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca064
            
            #add-point:AFTER FIELD faca064 name="construct.a.page2.faca064"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.faca064
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca064
            #add-point:ON ACTION controlp INFIELD faca064 name="construct.c.page2.faca064"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca064_desc
            #add-point:BEFORE FIELD faca064_desc name="construct.b.page2.faca064_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca064_desc
            
            #add-point:AFTER FIELD faca064_desc name="construct.a.page2.faca064_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.faca064_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca064_desc
            #add-point:ON ACTION controlp INFIELD faca064_desc name="construct.c.page2.faca064_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca043
            #add-point:BEFORE FIELD faca043 name="construct.b.page5.faca043"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca043
            
            #add-point:AFTER FIELD faca043 name="construct.a.page5.faca043"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.faca043
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca043
            #add-point:ON ACTION controlp INFIELD faca043 name="construct.c.page5.faca043"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca038
            #add-point:BEFORE FIELD faca038 name="construct.b.page5.faca038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca038
            
            #add-point:AFTER FIELD faca038 name="construct.a.page5.faca038"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.faca038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca038
            #add-point:ON ACTION controlp INFIELD faca038 name="construct.c.page5.faca038"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca039
            #add-point:BEFORE FIELD faca039 name="construct.b.page5.faca039"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca039
            
            #add-point:AFTER FIELD faca039 name="construct.a.page5.faca039"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.faca039
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca039
            #add-point:ON ACTION controlp INFIELD faca039 name="construct.c.page5.faca039"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca040
            #add-point:BEFORE FIELD faca040 name="construct.b.page5.faca040"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca040
            
            #add-point:AFTER FIELD faca040 name="construct.a.page5.faca040"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.faca040
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca040
            #add-point:ON ACTION controlp INFIELD faca040 name="construct.c.page5.faca040"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca041
            #add-point:BEFORE FIELD faca041 name="construct.b.page5.faca041"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca041
            
            #add-point:AFTER FIELD faca041 name="construct.a.page5.faca041"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.faca041
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca041
            #add-point:ON ACTION controlp INFIELD faca041 name="construct.c.page5.faca041"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca042
            #add-point:BEFORE FIELD faca042 name="construct.b.page5.faca042"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca042
            
            #add-point:AFTER FIELD faca042 name="construct.a.page5.faca042"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.faca042
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca042
            #add-point:ON ACTION controlp INFIELD faca042 name="construct.c.page5.faca042"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca044
            #add-point:BEFORE FIELD faca044 name="construct.b.page5.faca044"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca044
            
            #add-point:AFTER FIELD faca044 name="construct.a.page5.faca044"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.faca044
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca044
            #add-point:ON ACTION controlp INFIELD faca044 name="construct.c.page5.faca044"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca050
            #add-point:BEFORE FIELD faca050 name="construct.b.page5.faca050"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca050
            
            #add-point:AFTER FIELD faca050 name="construct.a.page5.faca050"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.faca050
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca050
            #add-point:ON ACTION controlp INFIELD faca050 name="construct.c.page5.faca050"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca045
            #add-point:BEFORE FIELD faca045 name="construct.b.page5.faca045"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca045
            
            #add-point:AFTER FIELD faca045 name="construct.a.page5.faca045"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.faca045
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca045
            #add-point:ON ACTION controlp INFIELD faca045 name="construct.c.page5.faca045"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca046
            #add-point:BEFORE FIELD faca046 name="construct.b.page5.faca046"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca046
            
            #add-point:AFTER FIELD faca046 name="construct.a.page5.faca046"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.faca046
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca046
            #add-point:ON ACTION controlp INFIELD faca046 name="construct.c.page5.faca046"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca047
            #add-point:BEFORE FIELD faca047 name="construct.b.page5.faca047"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca047
            
            #add-point:AFTER FIELD faca047 name="construct.a.page5.faca047"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.faca047
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca047
            #add-point:ON ACTION controlp INFIELD faca047 name="construct.c.page5.faca047"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca048
            #add-point:BEFORE FIELD faca048 name="construct.b.page5.faca048"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca048
            
            #add-point:AFTER FIELD faca048 name="construct.a.page5.faca048"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.faca048
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca048
            #add-point:ON ACTION controlp INFIELD faca048 name="construct.c.page5.faca048"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca049
            #add-point:BEFORE FIELD faca049 name="construct.b.page5.faca049"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca049
            
            #add-point:AFTER FIELD faca049 name="construct.a.page5.faca049"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.faca049
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca049
            #add-point:ON ACTION controlp INFIELD faca049 name="construct.c.page5.faca049"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca051
            #add-point:BEFORE FIELD faca051 name="construct.b.page5.faca051"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca051
            
            #add-point:AFTER FIELD faca051 name="construct.a.page5.faca051"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.faca051
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca051
            #add-point:ON ACTION controlp INFIELD faca051 name="construct.c.page5.faca051"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
      CONSTRUCT g_wc2_table2 ON xrcdseq,faca003,xrcdseq2,xrcd007,xrcd002,xrcd003,xrcd006,xrcd103,xrcd104, 
          xrcd105,xrcd113,xrcd114,xrcd115,xrcd009
           FROM s_detail3[1].xrcdseq,s_detail3[1].faca003,s_detail3[1].xrcdseq2,s_detail3[1].xrcd007, 
               s_detail3[1].xrcd002,s_detail3[1].xrcd003,s_detail3[1].xrcd006,s_detail3[1].xrcd103,s_detail3[1].xrcd104, 
               s_detail3[1].xrcd105,s_detail3[1].xrcd113,s_detail3[1].xrcd114,s_detail3[1].xrcd115,s_detail3[1].xrcd009 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body2.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcdseq
            #add-point:BEFORE FIELD xrcdseq name="construct.b.page3.xrcdseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcdseq
            
            #add-point:AFTER FIELD xrcdseq name="construct.a.page3.xrcdseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.xrcdseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcdseq
            #add-point:ON ACTION controlp INFIELD xrcdseq name="construct.c.page3.xrcdseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca003
            #add-point:BEFORE FIELD faca003 name="construct.b.page3.faca003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca003
            
            #add-point:AFTER FIELD faca003 name="construct.a.page3.faca003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.faca003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca003
            #add-point:ON ACTION controlp INFIELD faca003 name="construct.c.page3.faca003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcdseq2
            #add-point:BEFORE FIELD xrcdseq2 name="construct.b.page3.xrcdseq2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcdseq2
            
            #add-point:AFTER FIELD xrcdseq2 name="construct.a.page3.xrcdseq2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.xrcdseq2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcdseq2
            #add-point:ON ACTION controlp INFIELD xrcdseq2 name="construct.c.page3.xrcdseq2"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd007
            #add-point:BEFORE FIELD xrcd007 name="construct.b.page3.xrcd007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd007
            
            #add-point:AFTER FIELD xrcd007 name="construct.a.page3.xrcd007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.xrcd007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd007
            #add-point:ON ACTION controlp INFIELD xrcd007 name="construct.c.page3.xrcd007"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page3.xrcd002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd002
            #add-point:ON ACTION controlp INFIELD xrcd002 name="construct.c.page3.xrcd002"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_xrcd002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrcd002  #顯示到畫面上
            NEXT FIELD xrcd002                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd002
            #add-point:BEFORE FIELD xrcd002 name="construct.b.page3.xrcd002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd002
            
            #add-point:AFTER FIELD xrcd002 name="construct.a.page3.xrcd002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd003
            #add-point:BEFORE FIELD xrcd003 name="construct.b.page3.xrcd003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd003
            
            #add-point:AFTER FIELD xrcd003 name="construct.a.page3.xrcd003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.xrcd003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd003
            #add-point:ON ACTION controlp INFIELD xrcd003 name="construct.c.page3.xrcd003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd006
            #add-point:BEFORE FIELD xrcd006 name="construct.b.page3.xrcd006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd006
            
            #add-point:AFTER FIELD xrcd006 name="construct.a.page3.xrcd006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.xrcd006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd006
            #add-point:ON ACTION controlp INFIELD xrcd006 name="construct.c.page3.xrcd006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd103
            #add-point:BEFORE FIELD xrcd103 name="construct.b.page3.xrcd103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd103
            
            #add-point:AFTER FIELD xrcd103 name="construct.a.page3.xrcd103"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.xrcd103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd103
            #add-point:ON ACTION controlp INFIELD xrcd103 name="construct.c.page3.xrcd103"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd104
            #add-point:BEFORE FIELD xrcd104 name="construct.b.page3.xrcd104"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd104
            
            #add-point:AFTER FIELD xrcd104 name="construct.a.page3.xrcd104"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.xrcd104
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd104
            #add-point:ON ACTION controlp INFIELD xrcd104 name="construct.c.page3.xrcd104"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd105
            #add-point:BEFORE FIELD xrcd105 name="construct.b.page3.xrcd105"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd105
            
            #add-point:AFTER FIELD xrcd105 name="construct.a.page3.xrcd105"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.xrcd105
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd105
            #add-point:ON ACTION controlp INFIELD xrcd105 name="construct.c.page3.xrcd105"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd113
            #add-point:BEFORE FIELD xrcd113 name="construct.b.page3.xrcd113"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd113
            
            #add-point:AFTER FIELD xrcd113 name="construct.a.page3.xrcd113"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.xrcd113
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd113
            #add-point:ON ACTION controlp INFIELD xrcd113 name="construct.c.page3.xrcd113"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd114
            #add-point:BEFORE FIELD xrcd114 name="construct.b.page3.xrcd114"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd114
            
            #add-point:AFTER FIELD xrcd114 name="construct.a.page3.xrcd114"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.xrcd114
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd114
            #add-point:ON ACTION controlp INFIELD xrcd114 name="construct.c.page3.xrcd114"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd115
            #add-point:BEFORE FIELD xrcd115 name="construct.b.page3.xrcd115"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd115
            
            #add-point:AFTER FIELD xrcd115 name="construct.a.page3.xrcd115"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.xrcd115
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd115
            #add-point:ON ACTION controlp INFIELD xrcd115 name="construct.c.page3.xrcd115"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page3.xrcd009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd009
            #add-point:ON ACTION controlp INFIELD xrcd009 name="construct.c.page3.xrcd009"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL aglt310_04()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrcd009  #顯示到畫面上
            NEXT FIELD xrcd009                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd009
            #add-point:BEFORE FIELD xrcd009 name="construct.b.page3.xrcd009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd009
            
            #add-point:AFTER FIELD xrcd009 name="construct.a.page3.xrcd009"
            
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
 
 
            FOR li_idx = 1 TO la_wc.getLength()
               CASE
                  WHEN la_wc[li_idx].tableid = "fabg_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "faca_t" 
                     LET g_wc2_table1 = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "xrcd_t" 
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
   #161104-00046#16 --s add
   IF cl_null(g_user_dept_wc)THEN
      LET g_user_dept_wc = ' 1=1'
   END IF
   IF g_user_dept_wc <>  " 1=1" THEN
      LET g_wc = g_wc ," AND ", g_user_dept_wc CLIPPED
   END IF   
   #161104-00046#16 --e add   
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="afat510.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION afat510_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point   
   DEFINE ls_wc STRING
   #add-point:query段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   
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
   CALL g_faca_d.clear()
   CALL g_faca2_d.clear()
   CALL g_faca3_d.clear()
   CALL g_faca5_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL afat510_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL afat510_browser_fill("")
      CALL afat510_fetch("")
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
   CALL afat510_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL afat510_fetch("F") 
      #顯示單身筆數
      CALL afat510_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="afat510.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION afat510_fetch(p_flag)
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
   
   LET g_fabg_m.fabgld = g_browser[g_current_idx].b_fabgld
   LET g_fabg_m.fabgdocno = g_browser[g_current_idx].b_fabgdocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE afat510_master_referesh USING g_fabg_m.fabgld,g_fabg_m.fabgdocno INTO g_fabg_m.fabgsite,g_fabg_m.fabg001, 
       g_fabg_m.fabgld,g_fabg_m.fabgcomp,g_fabg_m.fabg005,g_fabg_m.fabgdocno,g_fabg_m.fabgdocdt,g_fabg_m.fabg010, 
       g_fabg_m.fabg018,g_fabg_m.fabg017,g_fabg_m.fabg006,g_fabg_m.fabg007,g_fabg_m.fabg013,g_fabg_m.fabg014, 
       g_fabg_m.fabg015,g_fabg_m.fabg016,g_fabg_m.fabg012,g_fabg_m.fabg008,g_fabg_m.fabgstus,g_fabg_m.fabgownid, 
       g_fabg_m.fabgowndp,g_fabg_m.fabgcrtid,g_fabg_m.fabgcrtdp,g_fabg_m.fabgcrtdt,g_fabg_m.fabgmodid, 
       g_fabg_m.fabgmoddt,g_fabg_m.fabgcnfid,g_fabg_m.fabgcnfdt,g_fabg_m.fabgpstid,g_fabg_m.fabgpstdt, 
       g_fabg_m.fabgsite_desc,g_fabg_m.fabg001_desc,g_fabg_m.fabgld_desc,g_fabg_m.fabg010_desc,g_fabg_m.fabg018_desc, 
       g_fabg_m.fabg006_desc,g_fabg_m.fabg007_desc,g_fabg_m.fabgownid_desc,g_fabg_m.fabgowndp_desc,g_fabg_m.fabgcrtid_desc, 
       g_fabg_m.fabgcrtdp_desc,g_fabg_m.fabgmodid_desc,g_fabg_m.fabgcnfid_desc,g_fabg_m.fabgpstid_desc 
 
   
   #遮罩相關處理
   LET g_fabg_m_mask_o.* =  g_fabg_m.*
   CALL afat510_fabg_t_mask()
   LET g_fabg_m_mask_n.* =  g_fabg_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL afat510_set_act_visible()   
   CALL afat510_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_fabg_m_t.* = g_fabg_m.*
   LET g_fabg_m_o.* = g_fabg_m.*
   
   LET g_data_owner = g_fabg_m.fabgownid      
   LET g_data_dept  = g_fabg_m.fabgowndp
   
   #重新顯示   
   CALL afat510_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="afat510.insert" >}
#+ 資料新增
PRIVATE FUNCTION afat510_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_faca_d.clear()   
   CALL g_faca2_d.clear()  
   CALL g_faca3_d.clear()  
   CALL g_faca5_d.clear()  
 
 
   INITIALIZE g_fabg_m.* TO NULL             #DEFAULT 設定
   
   LET g_fabgld_t = NULL
   LET g_fabgdocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_fabg_m.fabgownid = g_user
      LET g_fabg_m.fabgowndp = g_dept
      LET g_fabg_m.fabgcrtid = g_user
      LET g_fabg_m.fabgcrtdp = g_dept 
      LET g_fabg_m.fabgcrtdt = cl_get_current()
      LET g_fabg_m.fabgmodid = g_user
      LET g_fabg_m.fabgmoddt = cl_get_current()
      LET g_fabg_m.fabgstus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_fabg_m.fabg005 = "44"
      LET g_fabg_m.fabgstus = "N"
 
  
      #add-point:單頭預設值 name="insert.default"
      CALL afat510_defalut()
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_fabg_m_t.* = g_fabg_m.*
      LET g_fabg_m_o.* = g_fabg_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_fabg_m.fabgstus 
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "Z"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unposted.png")
         WHEN "S"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/posted.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
    
      CALL afat510_input("a")
      
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
         INITIALIZE g_fabg_m.* TO NULL
         INITIALIZE g_faca_d TO NULL
         INITIALIZE g_faca2_d TO NULL
         INITIALIZE g_faca3_d TO NULL
         INITIALIZE g_faca5_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL afat510_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_faca_d.clear()
      #CALL g_faca2_d.clear()
      #CALL g_faca3_d.clear()
      #CALL g_faca5_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL afat510_set_act_visible()   
   CALL afat510_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_fabgld_t = g_fabg_m.fabgld
   LET g_fabgdocno_t = g_fabg_m.fabgdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " fabgent = " ||g_enterprise|| " AND",
                      " fabgld = '", g_fabg_m.fabgld, "' "
                      ," AND fabgdocno = '", g_fabg_m.fabgdocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL afat510_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE afat510_cl
   
   CALL afat510_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE afat510_master_referesh USING g_fabg_m.fabgld,g_fabg_m.fabgdocno INTO g_fabg_m.fabgsite,g_fabg_m.fabg001, 
       g_fabg_m.fabgld,g_fabg_m.fabgcomp,g_fabg_m.fabg005,g_fabg_m.fabgdocno,g_fabg_m.fabgdocdt,g_fabg_m.fabg010, 
       g_fabg_m.fabg018,g_fabg_m.fabg017,g_fabg_m.fabg006,g_fabg_m.fabg007,g_fabg_m.fabg013,g_fabg_m.fabg014, 
       g_fabg_m.fabg015,g_fabg_m.fabg016,g_fabg_m.fabg012,g_fabg_m.fabg008,g_fabg_m.fabgstus,g_fabg_m.fabgownid, 
       g_fabg_m.fabgowndp,g_fabg_m.fabgcrtid,g_fabg_m.fabgcrtdp,g_fabg_m.fabgcrtdt,g_fabg_m.fabgmodid, 
       g_fabg_m.fabgmoddt,g_fabg_m.fabgcnfid,g_fabg_m.fabgcnfdt,g_fabg_m.fabgpstid,g_fabg_m.fabgpstdt, 
       g_fabg_m.fabgsite_desc,g_fabg_m.fabg001_desc,g_fabg_m.fabgld_desc,g_fabg_m.fabg010_desc,g_fabg_m.fabg018_desc, 
       g_fabg_m.fabg006_desc,g_fabg_m.fabg007_desc,g_fabg_m.fabgownid_desc,g_fabg_m.fabgowndp_desc,g_fabg_m.fabgcrtid_desc, 
       g_fabg_m.fabgcrtdp_desc,g_fabg_m.fabgmodid_desc,g_fabg_m.fabgcnfid_desc,g_fabg_m.fabgpstid_desc 
 
   
   
   #遮罩相關處理
   LET g_fabg_m_mask_o.* =  g_fabg_m.*
   CALL afat510_fabg_t_mask()
   LET g_fabg_m_mask_n.* =  g_fabg_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_fabg_m.fabgsite,g_fabg_m.fabgsite_desc,g_fabg_m.fabg001,g_fabg_m.fabg001_desc,g_fabg_m.fabgld, 
       g_fabg_m.fabgld_desc,g_fabg_m.fabgcomp,g_fabg_m.fabg005,g_fabg_m.fabgdocno,g_fabg_m.fabgdocdt, 
       g_fabg_m.fabg010,g_fabg_m.fabg010_desc,g_fabg_m.fabg018,g_fabg_m.fabg018_desc,g_fabg_m.fabg017, 
       g_fabg_m.fabg006,g_fabg_m.fabg006_desc,g_fabg_m.fabg007,g_fabg_m.fabg007_desc,g_fabg_m.fabg013, 
       g_fabg_m.fabg014,g_fabg_m.fabg015,g_fabg_m.fabg016,g_fabg_m.fabg012,g_fabg_m.fabg008,g_fabg_m.fabgstus, 
       g_fabg_m.fabgownid,g_fabg_m.fabgownid_desc,g_fabg_m.fabgowndp,g_fabg_m.fabgowndp_desc,g_fabg_m.fabgcrtid, 
       g_fabg_m.fabgcrtid_desc,g_fabg_m.fabgcrtdp,g_fabg_m.fabgcrtdp_desc,g_fabg_m.fabgcrtdt,g_fabg_m.fabgmodid, 
       g_fabg_m.fabgmodid_desc,g_fabg_m.fabgmoddt,g_fabg_m.fabgcnfid,g_fabg_m.fabgcnfid_desc,g_fabg_m.fabgcnfdt, 
       g_fabg_m.fabgpstid,g_fabg_m.fabgpstid_desc,g_fabg_m.fabgpstdt
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_fabg_m.fabgownid      
   LET g_data_dept  = g_fabg_m.fabgowndp
   
   #功能已完成,通報訊息中心
   CALL afat510_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="afat510.modify" >}
#+ 資料修改
PRIVATE FUNCTION afat510_modify()
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
   LET g_fabg_m_t.* = g_fabg_m.*
   LET g_fabg_m_o.* = g_fabg_m.*
   
   IF g_fabg_m.fabgld IS NULL
   OR g_fabg_m.fabgdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_fabgld_t = g_fabg_m.fabgld
   LET g_fabgdocno_t = g_fabg_m.fabgdocno
 
   CALL s_transaction_begin()
   
   OPEN afat510_cl USING g_enterprise,g_fabg_m.fabgld,g_fabg_m.fabgdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN afat510_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE afat510_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE afat510_master_referesh USING g_fabg_m.fabgld,g_fabg_m.fabgdocno INTO g_fabg_m.fabgsite,g_fabg_m.fabg001, 
       g_fabg_m.fabgld,g_fabg_m.fabgcomp,g_fabg_m.fabg005,g_fabg_m.fabgdocno,g_fabg_m.fabgdocdt,g_fabg_m.fabg010, 
       g_fabg_m.fabg018,g_fabg_m.fabg017,g_fabg_m.fabg006,g_fabg_m.fabg007,g_fabg_m.fabg013,g_fabg_m.fabg014, 
       g_fabg_m.fabg015,g_fabg_m.fabg016,g_fabg_m.fabg012,g_fabg_m.fabg008,g_fabg_m.fabgstus,g_fabg_m.fabgownid, 
       g_fabg_m.fabgowndp,g_fabg_m.fabgcrtid,g_fabg_m.fabgcrtdp,g_fabg_m.fabgcrtdt,g_fabg_m.fabgmodid, 
       g_fabg_m.fabgmoddt,g_fabg_m.fabgcnfid,g_fabg_m.fabgcnfdt,g_fabg_m.fabgpstid,g_fabg_m.fabgpstdt, 
       g_fabg_m.fabgsite_desc,g_fabg_m.fabg001_desc,g_fabg_m.fabgld_desc,g_fabg_m.fabg010_desc,g_fabg_m.fabg018_desc, 
       g_fabg_m.fabg006_desc,g_fabg_m.fabg007_desc,g_fabg_m.fabgownid_desc,g_fabg_m.fabgowndp_desc,g_fabg_m.fabgcrtid_desc, 
       g_fabg_m.fabgcrtdp_desc,g_fabg_m.fabgmodid_desc,g_fabg_m.fabgcnfid_desc,g_fabg_m.fabgpstid_desc 
 
   
   #檢查是否允許此動作
   IF NOT afat510_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_fabg_m_mask_o.* =  g_fabg_m.*
   CALL afat510_fabg_t_mask()
   LET g_fabg_m_mask_n.* =  g_fabg_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   IF NOT cl_null(g_fabg_m.fabgdocdt) THEN 
      IF NOT s_afa_date_chk('',g_fabg_m.fabgcomp,g_fabg_m.fabgdocdt) THEN 
         CLOSE afat510_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF 
   END IF 
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
   #LET l_wc2_table2 = g_wc2_table2
   #LET l_wc2_table2 = " 1=1"
 
 
 
   
   CALL afat510_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
   #LET  g_wc2_table2 = l_wc2_table2 
 
 
 
    
   WHILE TRUE
      LET g_fabgld_t = g_fabg_m.fabgld
      LET g_fabgdocno_t = g_fabg_m.fabgdocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_fabg_m.fabgmodid = g_user 
LET g_fabg_m.fabgmoddt = cl_get_current()
LET g_fabg_m.fabgmodid_desc = cl_get_username(g_fabg_m.fabgmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL afat510_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE fabg_t SET (fabgmodid,fabgmoddt) = (g_fabg_m.fabgmodid,g_fabg_m.fabgmoddt)
          WHERE fabgent = g_enterprise AND fabgld = g_fabgld_t
            AND fabgdocno = g_fabgdocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_fabg_m.* = g_fabg_m_t.*
            CALL afat510_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_fabg_m.fabgld != g_fabg_m_t.fabgld
      OR g_fabg_m.fabgdocno != g_fabg_m_t.fabgdocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE faca_t SET facald = g_fabg_m.fabgld
                                       ,facadocno = g_fabg_m.fabgdocno
 
          WHERE facaent = g_enterprise AND facald = g_fabg_m_t.fabgld
            AND facadocno = g_fabg_m_t.fabgdocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "faca_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "faca_t:",SQLERRMESSAGE 
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
         
         UPDATE xrcd_t
            SET xrcdld = g_fabg_m.fabgld
               ,xrcddocno = g_fabg_m.fabgdocno
 
          WHERE xrcdent = g_enterprise AND
                xrcdld = g_fabgld_t
            AND xrcddocno = g_fabgdocno_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update2"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "xrcd_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xrcd_t:",SQLERRMESSAGE 
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
   CALL afat510_set_act_visible()   
   CALL afat510_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " fabgent = " ||g_enterprise|| " AND",
                      " fabgld = '", g_fabg_m.fabgld, "' "
                      ," AND fabgdocno = '", g_fabg_m.fabgdocno, "' "
 
   #填到對應位置
   CALL afat510_browser_fill("")
 
   CLOSE afat510_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL afat510_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="afat510.input" >}
#+ 資料輸入
PRIVATE FUNCTION afat510_input(p_cmd)
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
   DEFINE  l_origin_str          STRING
   DEFINE  l_ooab002             LIKE ooab_t.ooab002
   DEFINE  l_oodb005             LIKE oodb_t.oodb005   
   DEFINE  l_ooef017             LIKE ooef_t.ooef017
   DEFINE  l_ooef024             LIKE ooef_t.ooef024
   DEFINE  l_ooef204             LIKE ooef_t.ooef204
   DEFINE  r_xrcd123             LIKE xrcd_t.xrcd113
   DEFINE  r_xrcd124             LIKE xrcd_t.xrcd114
   DEFINE  r_xrcd125             LIKE xrcd_t.xrcd115
   DEFINE  r_xrcd133             LIKE xrcd_t.xrcd113
   DEFINE  r_xrcd134             LIKE xrcd_t.xrcd114
   DEFINE  r_xrcd135             LIKE xrcd_t.xrcd115
   DEFINE  l_slip                LIKE type_t.chr80
   DEFINE  l_ooac004             LIKE ooac_t.ooac004
   DEFINE  l_sql                 STRING
   DEFINE  l_fabxstus            LIKE fabx_t.fabxstus
   DEFINE  l_flag                LIKE type_t.num5       #161104-00046#16 add
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
   DISPLAY BY NAME g_fabg_m.fabgsite,g_fabg_m.fabgsite_desc,g_fabg_m.fabg001,g_fabg_m.fabg001_desc,g_fabg_m.fabgld, 
       g_fabg_m.fabgld_desc,g_fabg_m.fabgcomp,g_fabg_m.fabg005,g_fabg_m.fabgdocno,g_fabg_m.fabgdocdt, 
       g_fabg_m.fabg010,g_fabg_m.fabg010_desc,g_fabg_m.fabg018,g_fabg_m.fabg018_desc,g_fabg_m.fabg017, 
       g_fabg_m.fabg006,g_fabg_m.fabg006_desc,g_fabg_m.fabg007,g_fabg_m.fabg007_desc,g_fabg_m.fabg013, 
       g_fabg_m.fabg014,g_fabg_m.fabg015,g_fabg_m.fabg016,g_fabg_m.fabg012,g_fabg_m.fabg008,g_fabg_m.fabgstus, 
       g_fabg_m.fabgownid,g_fabg_m.fabgownid_desc,g_fabg_m.fabgowndp,g_fabg_m.fabgowndp_desc,g_fabg_m.fabgcrtid, 
       g_fabg_m.fabgcrtid_desc,g_fabg_m.fabgcrtdp,g_fabg_m.fabgcrtdp_desc,g_fabg_m.fabgcrtdt,g_fabg_m.fabgmodid, 
       g_fabg_m.fabgmodid_desc,g_fabg_m.fabgmoddt,g_fabg_m.fabgcnfid,g_fabg_m.fabgcnfid_desc,g_fabg_m.fabgcnfdt, 
       g_fabg_m.fabgpstid,g_fabg_m.fabgpstid_desc,g_fabg_m.fabgpstdt
   
   #切換畫面
 
   CALL cl_set_head_visible("","YES")  
 
   LET l_insert = FALSE
   LET g_action_choice = ""
 
   #add-point:input段define_sql name="input.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT facaseq,faca001,faca002,faca003,faca004,faca005,faca008,faca009,faca010, 
       faca017,faca007,faca011,faca012,faca013,faca014,faca015,faca016,faca018,faca024,facaseq,faca019, 
       faca036,faca025,faca026,faca027,faca028,faca029,faca030,faca031,faca032,faca033,faca034,faca052, 
       faca053,faca054,faca065,faca055,faca056,faca057,faca058,faca059,faca060,faca061,faca062,faca063, 
       faca064,facaseq,faca043,faca038,faca039,faca040,faca041,faca042,faca044,faca050,faca045,faca046, 
       faca047,faca048,faca049,faca051 FROM faca_t WHERE facaent=? AND facald=? AND facadocno=? AND  
       facaseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE afat510_bcl CURSOR FROM g_forupd_sql
   
   #add-point:input段define_sql name="input.define_sql2"
   
   #end add-point    
   LET g_forupd_sql = "SELECT xrcdseq,xrcdseq2,xrcd007,xrcd002,xrcd003,xrcd006,xrcd103,xrcd104,xrcd105, 
       xrcd113,xrcd114,xrcd115,xrcd009 FROM xrcd_t WHERE xrcdent=? AND xrcdld=? AND xrcddocno=? AND  
       xrcdseq=? AND xrcdseq2=? AND xrcd007=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql2"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE afat510_bcl2 CURSOR FROM g_forupd_sql
 
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL afat510_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL afat510_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_fabg_m.fabgsite,g_fabg_m.fabg001,g_fabg_m.fabgld,g_fabg_m.fabgcomp,g_fabg_m.fabg005, 
       g_fabg_m.fabgdocno,g_fabg_m.fabgdocdt,g_fabg_m.fabg010,g_fabg_m.fabg018,g_fabg_m.fabg017,g_fabg_m.fabg006, 
       g_fabg_m.fabg007,g_fabg_m.fabg013,g_fabg_m.fabg014,g_fabg_m.fabg015,g_fabg_m.fabg016,g_fabg_m.fabg012, 
       g_fabg_m.fabg008,g_fabg_m.fabgstus
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   LET g_errshow = 1
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="afat510.input.head" >}
      #單頭段
      INPUT BY NAME g_fabg_m.fabgsite,g_fabg_m.fabg001,g_fabg_m.fabgld,g_fabg_m.fabgcomp,g_fabg_m.fabg005, 
          g_fabg_m.fabgdocno,g_fabg_m.fabgdocdt,g_fabg_m.fabg010,g_fabg_m.fabg018,g_fabg_m.fabg017,g_fabg_m.fabg006, 
          g_fabg_m.fabg007,g_fabg_m.fabg013,g_fabg_m.fabg014,g_fabg_m.fabg015,g_fabg_m.fabg016,g_fabg_m.fabg012, 
          g_fabg_m.fabg008,g_fabg_m.fabgstus 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN afat510_cl USING g_enterprise,g_fabg_m.fabgld,g_fabg_m.fabgdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN afat510_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE afat510_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL afat510_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            
            #end add-point
            CALL afat510_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabgsite
            
            #add-point:AFTER FIELD fabgsite name="input.a.fabgsite"
            IF NOT cl_null(g_fabg_m.fabgsite) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_fabg_m.fabgsite != g_fabg_m_t.fabgsite OR g_fabg_m_t.fabgsite IS NULL )) THEN

                  CALL s_afa_site_chk(g_fabg_m.fabgsite,g_fabg_m_t.fabgsite,'',g_fabg_m.fabgld,g_fabg_m.fabgdocdt)
                  RETURNING l_success,g_glaa.glaacomp,g_fabg_m.fabgld
                  
                  IF l_success = FALSE THEN 
                     LET g_fabg_m.fabgsite = g_fabg_m_t.fabgsite
                     LET g_fabg_m.fabgld = g_fabg_m_t.fabgld
                     CALL s_desc_get_department_desc(g_fabg_m.fabgsite) RETURNING g_fabg_m.fabgsite_desc
                     DISPLAY BY NAME g_fabg_m.fabgsite_desc
                     NEXT FIELD CURRENT
                  END IF
                  
                  #人员不为空
                  IF NOT cl_null(g_fabg_m.fabg001) THEN
                     CALL s_afa_person_chk(g_fabg_m.fabgsite,g_fabg_m.fabg001)
                     RETURNING l_success
                     IF l_success = FALSE THEN
                        LET g_fabg_m.fabgsite = g_fabg_m_t.fabgsite
                        CALL s_desc_get_department_desc(g_fabg_m.fabgsite) RETURNING g_fabg_m.fabgsite_desc
                        DISPLAY BY NAME g_fabg_m.fabgsite_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  CALL afat510_get_glaa()
                  LET g_fabg_m.fabg015 = g_glaa.glaa001
                  LET g_fabg_m.fabg016 = 1
               END IF
            END IF
            CALL s_fin_account_center_sons_query('5',g_fabg_m.fabgsite,g_today,'1')
            LET g_fabg_m_t.fabgsite = g_fabg_m.fabgsite
            LET g_fabg_m_t.fabgld = g_fabg_m.fabgld
            CALL s_desc_get_department_desc(g_fabg_m.fabgsite) RETURNING g_fabg_m.fabgsite_desc
            CALL s_desc_get_ld_desc(g_fabg_m.fabgld) RETURNING g_fabg_m.fabgld_desc
            DISPLAY BY NAME g_fabg_m.fabgsite_desc,g_fabg_m.fabgld_desc
            CALL afat510_get_glaa()
            CALL afat510_visible()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabgsite
            #add-point:BEFORE FIELD fabgsite name="input.b.fabgsite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabgsite
            #add-point:ON CHANGE fabgsite name="input.g.fabgsite"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabg001
            
            #add-point:AFTER FIELD fabg001 name="input.a.fabg001"
            IF NOT cl_null(g_fabg_m.fabg001) THEN 
#應用 a19 樣板自動產生(Version:2)
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fabg_m.fabg001
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooag001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                  IF NOT cl_null(g_fabg_m.fabgsite) THEN 
                     CALL s_afa_person_chk(g_fabg_m.fabgsite,g_fabg_m.fabg001) RETURNING l_success
                     
                     IF l_success = FALSE THEN
                        LET g_fabg_m.fabg001 = g_fabg_m_t.fabg001
                        CALL s_desc_get_person_desc(g_fabg_m.fabg001) RETURNING g_fabg_m.fabg001_desc
                        DISPLAY BY NAME g_fabg_m.fabg001_desc  
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               ELSE
                  #檢查失敗時後續處理
                  LET g_fabg_m.fabg001 = g_fabg_m_t.fabg001
                  CALL s_desc_get_person_desc(g_fabg_m.fabg001) RETURNING g_fabg_m.fabg001_desc
                  DISPLAY BY NAME g_fabg_m.fabg001_desc  
                  NEXT FIELD CURRENT
               END IF
            END IF 
            CALL s_desc_get_person_desc(g_fabg_m.fabg001) RETURNING g_fabg_m.fabg001_desc
            DISPLAY BY NAME g_fabg_m.fabg001_desc  
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabg001
            #add-point:BEFORE FIELD fabg001 name="input.b.fabg001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabg001
            #add-point:ON CHANGE fabg001 name="input.g.fabg001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabgld
            
            #add-point:AFTER FIELD fabgld name="input.a.fabgld"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  NOT cl_null(g_fabg_m.fabgld) AND NOT cl_null(g_fabg_m.fabgdocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_fabg_m.fabgld != g_fabgld_t  OR g_fabg_m.fabgdocno != g_fabgdocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM fabg_t WHERE "||"fabgent = " ||g_enterprise|| " AND "||"fabgld = '"||g_fabg_m.fabgld ||"' AND "|| "fabgdocno = '"||g_fabg_m.fabgdocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            
            IF NOT cl_null(g_fabg_m.fabgld) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_fabg_m.fabgld != g_fabg_m_t.fabgld OR g_fabg_m_t.fabgld IS NULL )) THEN
                  CALL s_afa_ld_chk(g_fabg_m.fabgsite,g_fabg_m.fabgld)
                  RETURNING l_success,g_glaa.glaacomp
                  
                  IF l_success = FALSE THEN 
                     LET g_fabg_m.fabgld = g_fabg_m_t.fabgld
                     CALL s_desc_get_ld_desc(g_fabg_m.fabgld) RETURNING g_fabg_m.fabgld_desc
                     DISPLAY BY NAME g_fabg_m.fabgld_desc
                     NEXT FIELD CURRENT
                  END IF  
                  CALL afat510_get_glaa()
                  LET g_fabg_m.fabg015 = g_glaa.glaa001
                  LET g_fabg_m.fabg016 = 1
               END IF
            END IF
            LET g_fabg_m_t.fabgld = g_fabg_m.fabgld
            CALL s_desc_get_ld_desc(g_fabg_m.fabgld) RETURNING g_fabg_m.fabgld_desc
            DISPLAY BY NAME g_fabg_m.fabgld_desc
            
            CALL afat510_get_glaa()
            CALL afat510_visible()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabgld
            #add-point:BEFORE FIELD fabgld name="input.b.fabgld"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabgld
            #add-point:ON CHANGE fabgld name="input.g.fabgld"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabgcomp
            #add-point:BEFORE FIELD fabgcomp name="input.b.fabgcomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabgcomp
            
            #add-point:AFTER FIELD fabgcomp name="input.a.fabgcomp"


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabgcomp
            #add-point:ON CHANGE fabgcomp name="input.g.fabgcomp"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabg005
            #add-point:BEFORE FIELD fabg005 name="input.b.fabg005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabg005
            
            #add-point:AFTER FIELD fabg005 name="input.a.fabg005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabg005
            #add-point:ON CHANGE fabg005 name="input.g.fabg005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabgdocno
            #add-point:BEFORE FIELD fabgdocno name="input.b.fabgdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabgdocno
            
            #add-point:AFTER FIELD fabgdocno name="input.a.fabgdocno"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  NOT cl_null(g_fabg_m.fabgld) AND NOT cl_null(g_fabg_m.fabgdocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_fabg_m.fabgld != g_fabgld_t  OR g_fabg_m.fabgdocno != g_fabgdocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM fabg_t WHERE "||"fabgent = " ||g_enterprise|| " AND "||"fabgld = '"||g_fabg_m.fabgld ||"' AND "|| "fabgdocno = '"||g_fabg_m.fabgdocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            IF NOT cl_null(g_fabg_m.fabgdocno) THEN
               IF NOT s_aooi200_fin_chk_slip(g_fabg_m.fabgld,g_glaa.glaa024,g_fabg_m.fabgdocno,g_prog) THEN
                  LET g_fabg_m.fabgdocno = g_fabg_m_t.fabgdocno
                  NEXT FIELD CURRENT
               END IF
               #161104-00046#16 --s add
               CALL s_control_chk_doc('1',g_fabg_m.fabgdocno,'4',g_user,g_dept,'','') RETURNING g_sub_success,l_flag
               IF g_sub_success AND l_flag THEN             
               ELSE
                  LET g_fabg_m.fabgdocno = g_fabg_m_t.fabgdocno
                  NEXT FIELD CURRENT        
               END IF
               CALL s_aooi200_fin_get_slip(g_fabg_m.fabgdocno) RETURNING g_sub_success,g_ap_slip
               #刪除單別預設temptable
               DELETE FROM s_aooi200def1
               #以目前畫面資訊新增temp資料   #請勿調整.*
               INSERT INTO s_aooi200def1 VALUES(g_fabg_m.*)
               #依單別預設取用資訊
               CALL s_aooi200def_get('','',g_fabg_m.fabgsite,'2',g_ap_slip,'','',g_fabg_m.fabgld)
               #依單別預設值TEMP內容 給予到畫面上   #請勿調整.*
               SELECT * INTO g_fabg_m.* FROM s_aooi200def1               
               #161104-00046#16 --e add               
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabgdocno
            #add-point:ON CHANGE fabgdocno name="input.g.fabgdocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabgdocdt
            #add-point:BEFORE FIELD fabgdocdt name="input.b.fabgdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabgdocdt
            
            #add-point:AFTER FIELD fabgdocdt name="input.a.fabgdocdt"
            IF NOT cl_null(g_fabg_m.fabgdocdt) THEN 
               #單據日期不能小於關賬日期
               #S-FIN-9003
               CALL cl_get_para(g_enterprise,g_fabg_m.fabgcomp,'S-FIN-9003') RETURNING l_ooab002   
               IF g_fabg_m.fabgdocdt <= l_ooab002 THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'afa-00060'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
               
                  LET g_fabg_m.fabgdocdt = g_fabg_m_t.fabgdocdt
                  NEXT FIELD fabgdocdt
               END IF
               IF NOT cl_null(g_fabg_m.fabgcomp) THEN
                  IF NOT s_afat503_sys_chk('',g_fabg_m.fabgcomp,g_fabg_m.fabgdocdt) THEN
                     LET g_fabg_m.fabgdocdt = g_fabg_m_t.fabgdocdt
                     NEXT FIELD fabgdocdt
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabgdocdt
            #add-point:ON CHANGE fabgdocdt name="input.g.fabgdocdt"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabg010
            
            #add-point:AFTER FIELD fabg010 name="input.a.fabg010"
            IF NOT cl_null(g_fabg_m.fabg010) THEN 
#應用 a17 樣板自動產生(Version:3)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
 
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fabg_m.fabg010

                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooef001") THEN
                  #檢查成功時後續處理
                  CALL s_fin_account_center_sons_str()RETURNING l_origin_str
                  IF cl_null(l_origin_str) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'axr-00378'
                     LET g_errparam.extend = g_fabg_m.fabg010
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_fabg_m.fabg010 = g_fabg_m_t.fabg010
                     CALL s_desc_get_department_desc(g_fabg_m.fabg010) RETURNING g_fabg_m.fabg010_desc
                     DISPLAY BY NAME g_fabg_m.fabg010_desc
                     NEXT FIELD CURRENT
                  END IF
                  
                  #檢查輸入組織代碼是否存在帳務中心下法人範圍內
                  IF s_chr_get_index_of(l_origin_str,g_fabg_m.fabg010,1) = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'afa-01098'
                     LET g_errparam.extend = g_fabg_m.fabg010
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_fabg_m.fabg010 = g_fabg_m_t.fabg010
                     CALL s_desc_get_department_desc(g_fabg_m.fabg010) RETURNING g_fabg_m.fabg010_desc
                     DISPLAY BY NAME g_fabg_m.fabg010_desc
                     NEXT FIELD CURRENT
                  END IF
                  
                  LET l_ooef017 = ''
                  SELECT ooef017,ooef204 INTO l_ooef017,l_ooef204
                    FROM ooef_t
                   WHERE ooefent = g_enterprise
                     AND ooef001 = g_fabg_m.fabg010
                     
                  IF l_ooef017 <> g_fabg_m.fabgcomp THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_fabg_m.fabg010
                     LET g_errparam.code   = "afa-01107" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET g_fabg_m.fabg010 = g_fabg_m_t.fabg010
                     CALL s_desc_get_department_desc(g_fabg_m.fabg010) RETURNING g_fabg_m.fabg010_desc
                     DISPLAY BY NAME g_fabg_m.fabg010_desc
                     NEXT FIELD CURRENT
                  END IF
                  
                  IF l_ooef204 = 'Y' THEN 
                     LET g_fabg_m.fabg018 = g_fabg_m.fabg010
                     CALL s_desc_get_department_desc(g_fabg_m.fabg018) RETURNING g_fabg_m.fabg018_desc
                     DISPLAY BY NAME g_fabg_m.fabg018_desc
                  END IF
               ELSE
                  #檢查失敗時後續處理
                  LET g_fabg_m.fabg010 = g_fabg_m_t.fabg010
                  CALL s_desc_get_department_desc(g_fabg_m.fabg010) RETURNING g_fabg_m.fabg010_desc
                  DISPLAY BY NAME g_fabg_m.fabg010_desc
                  NEXT FIELD CURRENT
               END IF
            END IF 
            CALL s_desc_get_department_desc(g_fabg_m.fabg010) RETURNING g_fabg_m.fabg010_desc
            DISPLAY BY NAME g_fabg_m.fabg010_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabg010
            #add-point:BEFORE FIELD fabg010 name="input.b.fabg010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabg010
            #add-point:ON CHANGE fabg010 name="input.g.fabg010"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabg018
            
            #add-point:AFTER FIELD fabg018 name="input.a.fabg018"
            IF NOT cl_null(g_fabg_m.fabg018) THEN 
#應用 a17 樣板自動產生(Version:3)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
 
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fabg_m.fabg018

                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooef001") THEN
                  #檢查成功時後續處理
                  CALL s_fin_account_center_sons_str()RETURNING l_origin_str
                  IF cl_null(l_origin_str) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'axr-00378'
                     LET g_errparam.extend = g_fabg_m.fabg018
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_fabg_m.fabg018 = g_fabg_m_t.fabg018
                     CALL s_desc_get_department_desc(g_fabg_m.fabg018) RETURNING g_fabg_m.fabg018_desc
                     DISPLAY BY NAME g_fabg_m.fabg018_desc
                     NEXT FIELD CURRENT
                  END IF
                  
                  #檢查輸入組織代碼是否存在帳務中心下法人範圍內
                  IF s_chr_get_index_of(l_origin_str,g_fabg_m.fabg018,1) = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'afa-01098'
                     LET g_errparam.extend = g_fabg_m.fabg018
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_fabg_m.fabg018 = g_fabg_m_t.fabg018
                     CALL s_desc_get_department_desc(g_fabg_m.fabg018) RETURNING g_fabg_m.fabg018_desc
                     DISPLAY BY NAME g_fabg_m.fabg018_desc
                     NEXT FIELD CURRENT
                  END IF
                  
                  LET l_ooef204 = ''
                  LET l_ooef024 = ''
                  SELECT ooef204,ooef024 INTO l_ooef204,l_ooef024
                    FROM ooef_t
                   WHERE ooefent = g_enterprise
                     AND ooef001 = g_fabg_m.fabg018
                     
                  IF l_ooef204 <> 'Y' THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_fabg_m.fabg018
                     LET g_errparam.code   = "afa-00120" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET g_fabg_m.fabg018 = g_fabg_m_t.fabg018
                     CALL s_desc_get_department_desc(g_fabg_m.fabg018) RETURNING g_fabg_m.fabg018_desc
                     DISPLAY BY NAME g_fabg_m.fabg018_desc
                     NEXT FIELD CURRENT
                  END IF
                  
                  LET g_fabg_m.fabg006 = l_ooef024
                  LET g_fabg_m.fabg007 = g_fabg_m.fabg006
                  CALL afat510_fabg007_chk()
                  IF NOT cl_null(g_errno) THEN 
                     LET g_fabg_m.fabg007 = g_fabg_m_t.fabg007
                     LET g_fabg_m.fabg007_desc = g_fabg_m_t.fabg007_desc
                  END IF
                  CALL s_desc_get_trading_partner_abbr_desc(g_fabg_m.fabg006) RETURNING g_fabg_m.fabg006_desc
                  CALL s_desc_get_trading_partner_abbr_desc(g_fabg_m.fabg007) RETURNING g_fabg_m.fabg007_desc 
                  DISPLAY g_fabg_m.fabg006_desc,g_fabg_m.fabg007_desc TO fabg006_desc,fabg007_desc                  
               ELSE
                  #檢查失敗時後續處理
                  LET g_fabg_m.fabg018 = g_fabg_m_t.fabg018
                  CALL s_desc_get_department_desc(g_fabg_m.fabg018) RETURNING g_fabg_m.fabg018_desc
                  DISPLAY BY NAME g_fabg_m.fabg018_desc
                  NEXT FIELD CURRENT
               END IF
            END IF 
            CALL s_desc_get_department_desc(g_fabg_m.fabg018) RETURNING g_fabg_m.fabg018_desc
            DISPLAY BY NAME g_fabg_m.fabg018_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabg018
            #add-point:BEFORE FIELD fabg018 name="input.b.fabg018"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabg018
            #add-point:ON CHANGE fabg018 name="input.g.fabg018"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabg017
            #add-point:BEFORE FIELD fabg017 name="input.b.fabg017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabg017
            
            #add-point:AFTER FIELD fabg017 name="input.a.fabg017"
            IF NOT cl_null(g_fabg_m.fabg017) THEN 
               IF p_cmd = 'a' OR (p_cmd = 'u' AND g_fabg_m.fabg017 <> g_fabg_m_t.fabg017) THEN
                  LET l_n = 0
                  SELECT COUNT(1) INTO l_n 
                    FROM fabx_t
                   WHERE fabxent = g_enterprise
                     AND fabx001 = '32'
                     AND fabx010 = g_fabg_m.fabg017
                     
                  IF l_n = 0  THEN 
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_fabg_m.fabg017
                     LET g_errparam.code   = 'afa-01099' 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET g_fabg_m.fabg017 = g_fabg_m_t.fabg017
                     NEXT FIELD fabg017
                  END IF
                  
                  LET l_n = 0
                  LET l_sql = "SELECT COUNT(1) FROM fabg_t,fabx_t ",
                              " WHERE fabgent = ",g_enterprise,
                              "   AND fabgent = fabxent ",
                              "   AND fabgcomp = fabxcomp ",
                              "   AND fabx001 = '32' ",
                              "   AND fabgcomp = '",g_fabg_m.fabgcomp,"'",
                              "   AND fabx010 = '",g_fabg_m.fabg017,"'"
                  IF NOT cl_null(g_fabg_m.fabg010) THEN 
                     LET l_sql = l_sql," AND fabx006 = '",g_fabg_m.fabg010,"'"
                  END IF
                  
                  IF NOT cl_null(g_fabg_m.fabg018) THEN 
                     LET l_sql = l_sql," AND fabx007 = '",g_fabg_m.fabg018,"'"
                  END IF
                  
                  PREPARE afat510_fabg017_pre FROM l_sql
                  EXECUTE afat510_fabg017_pre INTO l_n
                  
                  IF l_n = 0 THEN 
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_fabg_m.fabg017
                     LET g_errparam.code   = 'afa-01100' 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET g_fabg_m.fabg017 = g_fabg_m_t.fabg017
                     NEXT FIELD fabg017
                  END IF
                  
                  LET l_n = 0
                  SELECT COUNT(1) INTO l_n
                    FROM fabg_t
                   WHERE fabgent = g_enterprise
                     AND fabg005 = '44'
                     AND fabg017 = g_fabg_m.fabg017
                     AND fabgstus <> 'X'
                     
                  IF l_n > 0 THEN 
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_fabg_m.fabg017
                     LET g_errparam.code   = 'afa-01115' 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET g_fabg_m.fabg017 = g_fabg_m_t.fabg017
                     NEXT FIELD fabg017
                  END IF
                  
                  SELECT fabxstus INTO l_fabxstus
                    FROM fabx_t
                   WHERE fabxent = g_enterprise
                     AND fabx001 = '32'
                     AND fabx010 = g_fabg_m.fabg017
                  
                  IF l_fabxstus <> 'S' THEN 
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_fabg_m.fabg017
                     LET g_errparam.code   = 'afa-01112' 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET g_fabg_m.fabg017 = g_fabg_m_t.fabg017
                     NEXT FIELD fabg017
                  END IF
                     
               END IF
               CALL afat510_fabg017_get()
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabg017
            #add-point:ON CHANGE fabg017 name="input.g.fabg017"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabg006
            
            #add-point:AFTER FIELD fabg006 name="input.a.fabg006"
            IF NOT cl_null(g_fabg_m.fabg006) THEN
               IF p_cmd = 'a'  OR (g_fabg_m.fabg006 <> g_fabg_m_t.fabg006 OR cl_null(g_fabg_m_t.fabg006)) THEN            
#此段落由子樣板a19產生
                  #校驗代值
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_fabg_m.fabg006
                  LET g_errshow = TRUE 
                  LET g_chkparam.err_str[1] = "apm-00201:sub-01302|axmm200|",cl_get_progname("axmm200",g_lang,"2"),"|:EXEPROGaxmm200"
                     
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_pmaa001_27") THEN   
                     #檢查成功時後續處理
                     #LET  = g_chkparam.return1
                     #DISPLAY BY NAME 
                     
                     IF NOT s_control_check_customer(g_fabg_m.fabg006,'2',g_site,g_user,g_dept,'') THEN
                        LET g_fabg_m.fabg006 = g_fabg_m_t.fabg006
                        CALL s_desc_get_trading_partner_abbr_desc(g_fabg_m.fabg006) RETURNING g_fabg_m.fabg006_desc
                        DISPLAY BY NAME g_fabg_m.fabg006_desc
                        NEXT FIELD CURRENT
		    	         END IF
		    	         
		    	         SELECT pmac002 INTO g_fabg_m.fabg007
                       FROM pmac_t 
                      WHERE pmacent = g_enterprise
                        AND pmac001 = g_fabg_m.fabg006
                        AND pmac003 = '1'
                        AND pmac004 = 'Y'
                     CALL s_desc_get_trading_partner_abbr_desc(g_fabg_m.fabg007) RETURNING g_fabg_m.fabg007_desc
                     DISPLAY BY NAME g_fabg_m.fabg007_desc
                  ELSE
                     #檢查失敗時後續處理
                     LET g_fabg_m.fabg006 = g_fabg_m_t.fabg006
                     NEXT FIELD CURRENT
                  END IF
               END IF
               
            END IF
            CALL s_desc_get_trading_partner_abbr_desc(g_fabg_m.fabg006) RETURNING g_fabg_m.fabg006_desc           
            DISPLAY BY NAME g_fabg_m.fabg006_desc
            IF cl_null(g_fabg_m.fabg007) THEN
               LET g_fabg_m.fabg007=g_fabg_m.fabg006
               LET g_fabg_m.fabg007_desc=g_fabg_m.fabg006_desc
               DISPLAY BY NAME g_fabg_m.fabg007,g_fabg_m.fabg007_desc
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabg006
            #add-point:BEFORE FIELD fabg006 name="input.b.fabg006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabg006
            #add-point:ON CHANGE fabg006 name="input.g.fabg006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabg007
            
            #add-point:AFTER FIELD fabg007 name="input.a.fabg007"
            IF NOT cl_null(g_fabg_m.fabg007) THEN
               IF p_cmd = 'a'  OR (g_fabg_m.fabg007 <> g_fabg_m_t.fabg007 OR cl_null(g_fabg_m_t.fabg007)) THEN
                  CALL afat510_fabg007_chk()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_fabg_m.fabg007
                     LET g_errparam.replace[1] ='apmm100'
                     LET g_errparam.replace[2] = cl_get_progname('apmm100',g_lang,"2")
                     LET g_errparam.exeprog    ='apmm100'
                     LET g_errparam.popup = FALSE
                     CALL cl_err()
                     
                     LET g_fabg_m.fabg007 = g_fabg_m_t.fabg007
                     NEXT FIELD fabg007
                  END IF
               END IF
            END IF
            CALL s_desc_get_trading_partner_abbr_desc(g_fabg_m.fabg007) RETURNING g_fabg_m.fabg007_desc    
            DISPLAY BY NAME g_fabg_m.fabg007_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabg007
            #add-point:BEFORE FIELD fabg007 name="input.b.fabg007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabg007
            #add-point:ON CHANGE fabg007 name="input.g.fabg007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabg013
            
            #add-point:AFTER FIELD fabg013 name="input.a.fabg013"
            IF NOT cl_null(g_fabg_m.fabg013) THEN 
#應用 a17 樣板自動產生(Version:3)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
 
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_ooef019
               LET g_chkparam.arg2 = g_fabg_m.fabg013
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_oodb002_2") THEN
                  #檢查成功時後續處理
                  SELECT oodb006 INTO g_fabg_m.fabg014
                    FROM oodb_t
                   WHERE oodbent = g_enterprise
                     AND oodb001 = g_ooef019
                     AND oodb002 = g_fabg_m.fabg013
                     
                  DISPLAY g_fabg_m.fabg014 TO fabg014
                  
                  IF p_cmd = 'u' AND (g_fabg_m.fabg013 <> g_fabg_m_t.fabg013 OR cl_null(g_fabg_m_t.fabg013)) THEN
                     CALL afat510_update_fabg013()
                     LET g_fabg_m_t.fabg013 = g_fabg_m.fabg013
                  END IF
               ELSE
                  #檢查失敗時後續處理
                  LET g_fabg_m.fabg013 = g_fabg_m_t.fabg013
                  LET g_fabg_m.fabg014 = g_fabg_m_t.fabg014
                  NEXT FIELD CURRENT
               END IF
            END IF 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabg013
            #add-point:BEFORE FIELD fabg013 name="input.b.fabg013"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabg013
            #add-point:ON CHANGE fabg013 name="input.g.fabg013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabg014
            #add-point:BEFORE FIELD fabg014 name="input.b.fabg014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabg014
            
            #add-point:AFTER FIELD fabg014 name="input.a.fabg014"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabg014
            #add-point:ON CHANGE fabg014 name="input.g.fabg014"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabg015
            
            #add-point:AFTER FIELD fabg015 name="input.a.fabg015"
            IF NOT cl_null(g_fabg_m.fabg015) THEN 
#應用 a17 樣板自動產生(Version:3)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
 
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fabg_m.fabg015

                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooai001") THEN
                  #檢查成功時後續處理
                                                    #匯率參照表;帳套;    日期;      來源幣別
                  CALL s_aooi160_get_exrate('2',g_fabg_m.fabgld,g_fabg_m.fabgdocdt,g_fabg_m.fabg015,
                                            #目的幣別;          交易金額; 匯類類型
                                            g_glaa.glaa001 ,0,g_glaa.glaa025)
                  RETURNING g_fabg_m.fabg016
               ELSE
                  #檢查失敗時後續處理
                  LET g_fabg_m.fabg015 = g_fabg_m_t.fabg015
                  NEXT FIELD CURRENT
               END IF
            END IF 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabg015
            #add-point:BEFORE FIELD fabg015 name="input.b.fabg015"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabg015
            #add-point:ON CHANGE fabg015 name="input.g.fabg015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabg016
            #add-point:BEFORE FIELD fabg016 name="input.b.fabg016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabg016
            
            #add-point:AFTER FIELD fabg016 name="input.a.fabg016"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabg016
            #add-point:ON CHANGE fabg016 name="input.g.fabg016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabg012
            #add-point:BEFORE FIELD fabg012 name="input.b.fabg012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabg012
            
            #add-point:AFTER FIELD fabg012 name="input.a.fabg012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabg012
            #add-point:ON CHANGE fabg012 name="input.g.fabg012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabg008
            #add-point:BEFORE FIELD fabg008 name="input.b.fabg008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabg008
            
            #add-point:AFTER FIELD fabg008 name="input.a.fabg008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabg008
            #add-point:ON CHANGE fabg008 name="input.g.fabg008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabgstus
            #add-point:BEFORE FIELD fabgstus name="input.b.fabgstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabgstus
            
            #add-point:AFTER FIELD fabgstus name="input.a.fabgstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabgstus
            #add-point:ON CHANGE fabgstus name="input.g.fabgstus"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.fabgsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabgsite
            #add-point:ON ACTION controlp INFIELD fabgsite name="input.c.fabgsite"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabg_m.fabgsite             #給予default值
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooef001_47()                                #呼叫開窗

            LET g_fabg_m.fabgsite = g_qryparam.return1              

            DISPLAY g_fabg_m.fabgsite TO fabgsite              #
            CALL s_desc_get_department_desc(g_fabg_m.fabgsite) RETURNING g_fabg_m.fabgsite_desc
            DISPLAY BY NAME g_fabg_m.fabgsite_desc
            NEXT FIELD fabgsite                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.fabg001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabg001
            #add-point:ON ACTION controlp INFIELD fabg001 name="input.c.fabg001"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_fabg_m.fabg001             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

 
            CALL q_ooag001()                                #呼叫開窗
 
            LET g_fabg_m.fabg001 = g_qryparam.return1              
            CALL s_desc_get_person_desc(g_fabg_m.fabg001) RETURNING g_fabg_m.fabg001_desc
            DISPLAY g_fabg_m.fabg001_desc TO fabg001_desc
            DISPLAY g_fabg_m.fabg001 TO fabg001              #
           
            NEXT FIELD fabg001                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.fabgld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabgld
            #add-point:ON ACTION controlp INFIELD fabgld name="input.c.fabgld"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabg_m.fabgld             #給予default值

            #取得资产組織下所屬成員
            CALL s_fin_account_center_sons_query('5',g_fabg_m.fabgsite,g_fabg_m.fabgdocdt,'1')
            #取得资产中心下所屬成員之帳別   
            CALL s_fin_account_center_comp_str() RETURNING l_origin_str
            #將取回的字串轉換為SQL條件
            CALL s_fin_get_wc_str(l_origin_str) RETURNING l_origin_str  
            
            LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') AND glaacomp IN ",l_origin_str

            #給予arg
            LET g_qryparam.arg1 = g_user 
            LET g_qryparam.arg2 = g_dept 
            
            CALL q_authorised_ld()                                #呼叫開窗

            LET g_fabg_m.fabgld = g_qryparam.return1              

            DISPLAY g_fabg_m.fabgld TO fabgld              #
            CALL s_desc_get_ld_desc(g_fabg_m.fabgld) RETURNING g_fabg_m.fabgld_desc
            DISPLAY BY NAME g_fabg_m.fabgld_desc
            NEXT FIELD fabgld                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.fabgcomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabgcomp
            #add-point:ON ACTION controlp INFIELD fabgcomp name="input.c.fabgcomp"
            
            #END add-point
 
 
         #Ctrlp:input.c.fabg005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabg005
            #add-point:ON ACTION controlp INFIELD fabg005 name="input.c.fabg005"
            
            #END add-point
 
 
         #Ctrlp:input.c.fabgdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabgdocno
            #add-point:ON ACTION controlp INFIELD fabgdocno name="input.c.fabgdocno"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_fabg_m.fabgdocno             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_glaa.glaa024
            LET g_qryparam.arg2 = g_prog
             #161104-00046#16 --s add
            IF NOT cl_null(g_user_slip_wc)THEN
               LET g_qryparam.where = g_user_slip_wc
            END IF
            #161104-00046#16 --e add   
            CALL q_ooba002_1()                                #呼叫開窗
 
            LET g_fabg_m.fabgdocno = g_qryparam.return1              

            DISPLAY g_fabg_m.fabgdocno TO fabgdocno              #

            NEXT FIELD fabgdocno                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.fabgdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabgdocdt
            #add-point:ON ACTION controlp INFIELD fabgdocdt name="input.c.fabgdocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.fabg010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabg010
            #add-point:ON ACTION controlp INFIELD fabg010 name="input.c.fabg010"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_fabg_m.fabg010             #給予default值

            CALL s_fin_account_center_sons_str()RETURNING l_origin_str
            CALL s_fin_get_wc_str(l_origin_str)RETURNING l_origin_str
            LET g_qryparam.where = " ooef017 = '",g_fabg_m.fabgcomp,"' AND ooef001 IN ",l_origin_str CLIPPED 
            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_ooef001()                                #呼叫開窗
 
            LET g_fabg_m.fabg010 = g_qryparam.return1 
            CALL s_desc_get_department_desc(g_fabg_m.fabg010) RETURNING g_fabg_m.fabg010_desc
            DISPLAY BY NAME g_fabg_m.fabg010_desc                  
            DISPLAY g_fabg_m.fabg010 TO fabg010              #
            NEXT FIELD fabg010                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.fabg018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabg018
            #add-point:ON ACTION controlp INFIELD fabg018 name="input.c.fabg018"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_fabg_m.fabg018             #給予default值
            CALL s_fin_account_center_sons_str()RETURNING l_origin_str
            CALL s_fin_get_wc_str(l_origin_str)RETURNING l_origin_str
            LET g_qryparam.where = " ooef204 = 'Y' AND ooef001 IN ",l_origin_str CLIPPED 
            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_ooef001()                                #呼叫開窗
 
            LET g_fabg_m.fabg018 = g_qryparam.return1              
            CALL s_desc_get_department_desc(g_fabg_m.fabg018) RETURNING g_fabg_m.fabg018_desc
            DISPLAY BY NAME g_fabg_m.fabg018_desc    
            DISPLAY g_fabg_m.fabg018 TO fabg018              #

            NEXT FIELD fabg018                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.fabg017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabg017
            #add-point:ON ACTION controlp INFIELD fabg017 name="input.c.fabg017"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_fabg_m.fabg017             #給予default值
            
            LET g_qryparam.where = "     ooef017 = '",g_fabg_m.fabgcomp,"'",
                                   " AND fabxstus = 'S' ",
                                   " AND fabx010 NOT IN (SELECT fabg017 FROM fabg_t ",
                                   "                      WHERE fabgent = ",g_enterprise,
                                   "                        AND fabgld = '",g_fabg_m.fabgld,"'",
                                   "                        AND fabg005 = '44' ",
                                   "                        AND fabgstus <> 'X' ",
                                   "                           )"
                                   
            IF NOT cl_null(g_fabg_m.fabg010) THEN 
               LET g_qryparam.where = g_qryparam.where," AND fabx006 = '",g_fabg_m.fabg010,"'"
            END IF
            
            IF NOT cl_null(g_fabg_m.fabg018) THEN 
               LET g_qryparam.where = g_qryparam.where," AND fabx007 = '",g_fabg_m.fabg018,"'"
            END IF

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_fabx010_2()                                #呼叫開窗
 
            LET g_fabg_m.fabg017 = g_qryparam.return1              
            CALL afat510_fabg017_get()
            DISPLAY g_fabg_m.fabg017 TO fabg017              #

            NEXT FIELD fabg017                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.fabg006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabg006
            #add-point:ON ACTION controlp INFIELD fabg006 name="input.c.fabg006"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabg_m.fabg006             #給予default值
            
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_qryparam.where CLIPPED," AND ",g_sql_ctrl
            END IF

            LET g_qryparam.arg1="('1','3')"
            CALL q_pmaa001_1()

            LET g_fabg_m.fabg006 = g_qryparam.return1              

            DISPLAY g_fabg_m.fabg006 TO fabg006              #
            CALL s_desc_get_trading_partner_abbr_desc(g_fabg_m.fabg006) RETURNING g_fabg_m.fabg006_desc
            DISPLAY BY NAME g_fabg_m.fabg006_desc
            NEXT FIELD fabg006                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.fabg007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabg007
            #add-point:ON ACTION controlp INFIELD fabg007 name="input.c.fabg007"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabg_m.fabg007             #給予default值

            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = " EXISTS (SELECT 1 FROM pmaa_t ",
                                      "          WHERE pmaaent = ",g_enterprise,
                                      "            AND ",g_sql_ctrl,
                                      "            AND pmaaent = pmacent ",                                   
                                      "            AND pmaa001 = pmac002 )"
            END IF
            #給予arg
            LET g_qryparam.arg1 = g_fabg_m.fabg006
            LET g_qryparam.arg2 = "1"  
            
            CALL q_pmac002_1()                                #呼叫開窗

            LET g_fabg_m.fabg007 = g_qryparam.return1              

            DISPLAY g_fabg_m.fabg007 TO fabg007              #

            CALL s_desc_get_trading_partner_abbr_desc(g_fabg_m.fabg007) RETURNING g_fabg_m.fabg007_desc
            DISPLAY BY NAME g_fabg_m.fabg007_desc
            NEXT FIELD fabg007                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.fabg013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabg013
            #add-point:ON ACTION controlp INFIELD fabg013 name="input.c.fabg013"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_fabg_m.fabg013             #給予default值
            LET g_qryparam.default4 = g_fabg_m.fabg014

            #給予arg
            LET g_qryparam.arg1 = g_ooef019

 
            CALL q_oodb002_5()                                #呼叫開窗
 
            LET g_fabg_m.fabg013 = g_qryparam.return1 
            LET g_fabg_m.fabg014 = g_qryparam.return4            

            DISPLAY g_fabg_m.fabg013 TO fabg013              #
            DISPLAY g_fabg_m.fabg014 TO fabg014

            NEXT FIELD fabg013                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.fabg014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabg014
            #add-point:ON ACTION controlp INFIELD fabg014 name="input.c.fabg014"
            
            #END add-point
 
 
         #Ctrlp:input.c.fabg015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabg015
            #add-point:ON ACTION controlp INFIELD fabg015 name="input.c.fabg015"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_fabg_m.fabg015             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_ooai001()                                #呼叫開窗
 
            LET g_fabg_m.fabg015 = g_qryparam.return1              

            DISPLAY g_fabg_m.fabg015 TO fabg015              #

            NEXT FIELD fabg015                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.fabg016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabg016
            #add-point:ON ACTION controlp INFIELD fabg016 name="input.c.fabg016"
            
            #END add-point
 
 
         #Ctrlp:input.c.fabg012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabg012
            #add-point:ON ACTION controlp INFIELD fabg012 name="input.c.fabg012"
            
            #END add-point
 
 
         #Ctrlp:input.c.fabg008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabg008
            #add-point:ON ACTION controlp INFIELD fabg008 name="input.c.fabg008"
            
            #END add-point
 
 
         #Ctrlp:input.c.fabgstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabgstus
            #add-point:ON ACTION controlp INFIELD fabgstus name="input.c.fabgstus"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_fabg_m.fabgld,g_fabg_m.fabgdocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            IF NOT cl_null(g_fabg_m.fabgdocdt) THEN 
               #單據日期不能小於關賬日期
               #S-FIN-9003
               CALL cl_get_para(g_enterprise,g_fabg_m.fabgcomp,'S-FIN-9003') RETURNING l_ooab002  
               IF g_fabg_m.fabgdocdt <= l_ooab002 THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'afa-00060'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_fabg_m.fabgdocdt = g_fabg_m_t.fabgdocdt
                  NEXT FIELD fabgdocdt
               END IF
               IF NOT cl_null(g_fabg_m.fabgcomp) THEN
                  IF NOT s_afat503_sys_chk('',g_fabg_m.fabgcomp,g_fabg_m.fabgdocdt) THEN
                     LET g_fabg_m.fabgdocdt = g_fabg_m_t.fabgdocdt
                     NEXT FIELD fabgdocdt
                  END IF
               END IF         
            END IF 
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               CALL s_aooi200_fin_gen_docno(g_glaa.glaald,g_glaa.glaa024,g_glaa.glaa003,g_fabg_m.fabgdocno,g_fabg_m.fabgdocdt,g_prog)
               RETURNING l_success,g_fabg_m.fabgdocno
               IF l_success  = 0  THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apm-00003'
                  LET g_errparam.extend = g_fabg_m.fabgdocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                
                  NEXT FIELD fabgdocno
               END IF
               DISPLAY BY NAME g_fabg_m.fabgdocno
               #end add-point
               
               INSERT INTO fabg_t (fabgent,fabgsite,fabg001,fabgld,fabgcomp,fabg005,fabgdocno,fabgdocdt, 
                   fabg010,fabg018,fabg017,fabg006,fabg007,fabg013,fabg014,fabg015,fabg016,fabg012,fabg008, 
                   fabgstus,fabgownid,fabgowndp,fabgcrtid,fabgcrtdp,fabgcrtdt,fabgmodid,fabgmoddt,fabgcnfid, 
                   fabgcnfdt,fabgpstid,fabgpstdt)
               VALUES (g_enterprise,g_fabg_m.fabgsite,g_fabg_m.fabg001,g_fabg_m.fabgld,g_fabg_m.fabgcomp, 
                   g_fabg_m.fabg005,g_fabg_m.fabgdocno,g_fabg_m.fabgdocdt,g_fabg_m.fabg010,g_fabg_m.fabg018, 
                   g_fabg_m.fabg017,g_fabg_m.fabg006,g_fabg_m.fabg007,g_fabg_m.fabg013,g_fabg_m.fabg014, 
                   g_fabg_m.fabg015,g_fabg_m.fabg016,g_fabg_m.fabg012,g_fabg_m.fabg008,g_fabg_m.fabgstus, 
                   g_fabg_m.fabgownid,g_fabg_m.fabgowndp,g_fabg_m.fabgcrtid,g_fabg_m.fabgcrtdp,g_fabg_m.fabgcrtdt, 
                   g_fabg_m.fabgmodid,g_fabg_m.fabgmoddt,g_fabg_m.fabgcnfid,g_fabg_m.fabgcnfdt,g_fabg_m.fabgpstid, 
                   g_fabg_m.fabgpstdt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_fabg_m:",SQLERRMESSAGE 
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
                  CALL afat510_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL afat510_b_fill()
                  CALL afat510_b_fill2('0')
               END IF
               
               #add-point:單頭新增後 name="input.head.a_insert2"
               CALL afat510_ins_faca()
               #end add-point
               
               LET g_master_insert = TRUE
               
               LET p_cmd = 'u'
            ELSE
               CALL s_transaction_begin()
            
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL afat510_fabg_t_mask_restore('restore_mask_o')
               
               UPDATE fabg_t SET (fabgsite,fabg001,fabgld,fabgcomp,fabg005,fabgdocno,fabgdocdt,fabg010, 
                   fabg018,fabg017,fabg006,fabg007,fabg013,fabg014,fabg015,fabg016,fabg012,fabg008,fabgstus, 
                   fabgownid,fabgowndp,fabgcrtid,fabgcrtdp,fabgcrtdt,fabgmodid,fabgmoddt,fabgcnfid,fabgcnfdt, 
                   fabgpstid,fabgpstdt) = (g_fabg_m.fabgsite,g_fabg_m.fabg001,g_fabg_m.fabgld,g_fabg_m.fabgcomp, 
                   g_fabg_m.fabg005,g_fabg_m.fabgdocno,g_fabg_m.fabgdocdt,g_fabg_m.fabg010,g_fabg_m.fabg018, 
                   g_fabg_m.fabg017,g_fabg_m.fabg006,g_fabg_m.fabg007,g_fabg_m.fabg013,g_fabg_m.fabg014, 
                   g_fabg_m.fabg015,g_fabg_m.fabg016,g_fabg_m.fabg012,g_fabg_m.fabg008,g_fabg_m.fabgstus, 
                   g_fabg_m.fabgownid,g_fabg_m.fabgowndp,g_fabg_m.fabgcrtid,g_fabg_m.fabgcrtdp,g_fabg_m.fabgcrtdt, 
                   g_fabg_m.fabgmodid,g_fabg_m.fabgmoddt,g_fabg_m.fabgcnfid,g_fabg_m.fabgcnfdt,g_fabg_m.fabgpstid, 
                   g_fabg_m.fabgpstdt)
                WHERE fabgent = g_enterprise AND fabgld = g_fabgld_t
                  AND fabgdocno = g_fabgdocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "fabg_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL afat510_fabg_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_fabg_m_t)
               LET g_log2 = util.JSON.stringify(g_fabg_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_fabgld_t = g_fabg_m.fabgld
            LET g_fabgdocno_t = g_fabg_m.fabgdocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="afat510.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_faca_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = FALSE, 
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_faca_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL afat510_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1','2','4',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_faca_d.getLength()
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
            OPEN afat510_cl USING g_enterprise,g_fabg_m.fabgld,g_fabg_m.fabgdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN afat510_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE afat510_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_faca_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_faca_d[l_ac].facaseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_faca_d_t.* = g_faca_d[l_ac].*  #BACKUP
               LET g_faca_d_o.* = g_faca_d[l_ac].*  #BACKUP
               CALL afat510_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL afat510_set_no_entry_b(l_cmd)
               IF NOT afat510_lock_b("faca_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH afat510_bcl INTO g_faca_d[l_ac].facaseq,g_faca_d[l_ac].faca001,g_faca_d[l_ac].faca002, 
                      g_faca_d[l_ac].faca003,g_faca_d[l_ac].faca004,g_faca_d[l_ac].faca005,g_faca_d[l_ac].faca008, 
                      g_faca_d[l_ac].faca009,g_faca_d[l_ac].faca010,g_faca_d[l_ac].faca017,g_faca_d[l_ac].faca007, 
                      g_faca_d[l_ac].faca011,g_faca_d[l_ac].faca012,g_faca_d[l_ac].faca013,g_faca_d[l_ac].faca014, 
                      g_faca_d[l_ac].faca015,g_faca_d[l_ac].faca016,g_faca_d[l_ac].faca018,g_faca_d[l_ac].faca024, 
                      g_faca2_d[l_ac].facaseq,g_faca2_d[l_ac].faca019,g_faca2_d[l_ac].faca036,g_faca2_d[l_ac].faca025, 
                      g_faca2_d[l_ac].faca026,g_faca2_d[l_ac].faca027,g_faca2_d[l_ac].faca028,g_faca2_d[l_ac].faca029, 
                      g_faca2_d[l_ac].faca030,g_faca2_d[l_ac].faca031,g_faca2_d[l_ac].faca032,g_faca2_d[l_ac].faca033, 
                      g_faca2_d[l_ac].faca034,g_faca2_d[l_ac].faca052,g_faca2_d[l_ac].faca053,g_faca2_d[l_ac].faca054, 
                      g_faca2_d[l_ac].faca065,g_faca2_d[l_ac].faca055,g_faca2_d[l_ac].faca056,g_faca2_d[l_ac].faca057, 
                      g_faca2_d[l_ac].faca058,g_faca2_d[l_ac].faca059,g_faca2_d[l_ac].faca060,g_faca2_d[l_ac].faca061, 
                      g_faca2_d[l_ac].faca062,g_faca2_d[l_ac].faca063,g_faca2_d[l_ac].faca064,g_faca5_d[l_ac].facaseq, 
                      g_faca5_d[l_ac].faca043,g_faca5_d[l_ac].faca038,g_faca5_d[l_ac].faca039,g_faca5_d[l_ac].faca040, 
                      g_faca5_d[l_ac].faca041,g_faca5_d[l_ac].faca042,g_faca5_d[l_ac].faca044,g_faca5_d[l_ac].faca050, 
                      g_faca5_d[l_ac].faca045,g_faca5_d[l_ac].faca046,g_faca5_d[l_ac].faca047,g_faca5_d[l_ac].faca048, 
                      g_faca5_d[l_ac].faca049,g_faca5_d[l_ac].faca051
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_faca_d_t.facaseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_faca_d_mask_o[l_ac].* =  g_faca_d[l_ac].*
                  CALL afat510_faca_t_mask()
                  LET g_faca_d_mask_n[l_ac].* =  g_faca_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL afat510_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            IF NOT cl_null(g_faca_d[l_ac].faca010) THEN 
               SELECT oodb005 INTO l_oodb005
                 FROM oodb_t
                WHERE oodbent = g_enterprise
                  AND oodb001 = g_ooef019
                  AND oodb002 = g_faca_d[l_ac].faca010

               IF l_oodb005 = 'N' THEN 
                  CALL cl_set_comp_entry("faca011",TRUE)
                  CALL cl_set_comp_entry("faca013",FALSE)
               ELSE
                  CALL cl_set_comp_entry("faca011",FALSE)
                  CALL cl_set_comp_entry("faca013",TRUE)
               END IF
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
            INITIALIZE g_faca_d[l_ac].* TO NULL 
            INITIALIZE g_faca_d_t.* TO NULL 
            INITIALIZE g_faca_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_faca_d[l_ac].facaseq = "0"
      LET g_faca_d[l_ac].faca002 = "0"
      LET g_faca_d[l_ac].faca008 = "0"
      LET g_faca_d[l_ac].faca009 = "0"
      LET g_faca_d[l_ac].faca017 = "0"
      LET g_faca_d[l_ac].faca007 = "0"
      LET g_faca_d[l_ac].faca011 = "0"
      LET g_faca_d[l_ac].faca012 = "0"
      LET g_faca_d[l_ac].faca013 = "0"
      LET g_faca_d[l_ac].faca014 = "0"
      LET g_faca_d[l_ac].faca015 = "0"
      LET g_faca_d[l_ac].faca016 = "0"
      LET g_faca_d[l_ac].faca018 = "0"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            
            #end add-point
            LET g_faca_d_t.* = g_faca_d[l_ac].*     #新輸入資料
            LET g_faca_d_o.* = g_faca_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL afat510_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL afat510_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_faca_d[li_reproduce_target].* = g_faca_d[li_reproduce].*
               LET g_faca2_d[li_reproduce_target].* = g_faca2_d[li_reproduce].*
               LET g_faca5_d[li_reproduce_target].* = g_faca5_d[li_reproduce].*
 
               LET g_faca_d[li_reproduce_target].facaseq = NULL
 
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
            SELECT COUNT(1) INTO l_count FROM faca_t 
             WHERE facaent = g_enterprise AND facald = g_fabg_m.fabgld
               AND facadocno = g_fabg_m.fabgdocno
 
               AND facaseq = g_faca_d[l_ac].facaseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fabg_m.fabgld
               LET gs_keys[2] = g_fabg_m.fabgdocno
               LET gs_keys[3] = g_faca_d[g_detail_idx].facaseq
               CALL afat510_insert_b('faca_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_faca_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "faca_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL afat510_b_fill()
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
               LET gs_keys[01] = g_fabg_m.fabgld
               LET gs_keys[gs_keys.getLength()+1] = g_fabg_m.fabgdocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_faca_d_t.facaseq
 
            
               #刪除同層單身
               IF NOT afat510_delete_b('faca_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE afat510_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT afat510_key_delete_b(gs_keys,'faca_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE afat510_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
 
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE afat510_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_faca_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_faca_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD facaseq
            #add-point:BEFORE FIELD facaseq name="input.b.page1.facaseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD facaseq
            
            #add-point:AFTER FIELD facaseq name="input.a.page1.facaseq"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  g_fabg_m.fabgld IS NOT NULL AND g_fabg_m.fabgdocno IS NOT NULL AND g_faca_d[g_detail_idx].facaseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_fabg_m.fabgld != g_fabgld_t OR g_fabg_m.fabgdocno != g_fabgdocno_t OR g_faca_d[g_detail_idx].facaseq != g_faca_d_t.facaseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM faca_t WHERE "||"facaent = " ||g_enterprise|| " AND "||"facald = '"||g_fabg_m.fabgld ||"' AND "|| "facadocno = '"||g_fabg_m.fabgdocno ||"' AND "|| "facaseq = '"||g_faca_d[g_detail_idx].facaseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE facaseq
            #add-point:ON CHANGE facaseq name="input.g.page1.facaseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca001
            #add-point:BEFORE FIELD faca001 name="input.b.page1.faca001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca001
            
            #add-point:AFTER FIELD faca001 name="input.a.page1.faca001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faca001
            #add-point:ON CHANGE faca001 name="input.g.page1.faca001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca002
            #add-point:BEFORE FIELD faca002 name="input.b.page1.faca002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca002
            
            #add-point:AFTER FIELD faca002 name="input.a.page1.faca002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faca002
            #add-point:ON CHANGE faca002 name="input.g.page1.faca002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca003
            #add-point:BEFORE FIELD faca003 name="input.b.page1.faca003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca003
            
            #add-point:AFTER FIELD faca003 name="input.a.page1.faca003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faca003
            #add-point:ON CHANGE faca003 name="input.g.page1.faca003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca004
            #add-point:BEFORE FIELD faca004 name="input.b.page1.faca004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca004
            
            #add-point:AFTER FIELD faca004 name="input.a.page1.faca004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faca004
            #add-point:ON CHANGE faca004 name="input.g.page1.faca004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca005
            #add-point:BEFORE FIELD faca005 name="input.b.page1.faca005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca005
            
            #add-point:AFTER FIELD faca005 name="input.a.page1.faca005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faca005
            #add-point:ON CHANGE faca005 name="input.g.page1.faca005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca008
            #add-point:BEFORE FIELD faca008 name="input.b.page1.faca008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca008
            
            #add-point:AFTER FIELD faca008 name="input.a.page1.faca008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faca008
            #add-point:ON CHANGE faca008 name="input.g.page1.faca008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca009
            #add-point:BEFORE FIELD faca009 name="input.b.page1.faca009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca009
            
            #add-point:AFTER FIELD faca009 name="input.a.page1.faca009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faca009
            #add-point:ON CHANGE faca009 name="input.g.page1.faca009"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca010
            
            #add-point:AFTER FIELD faca010 name="input.a.page1.faca010"
            IF NOT cl_null(g_faca_d[l_ac].faca010) THEN 
#應用 a17 樣板自動產生(Version:3)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
 
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_ooef019
               LET g_chkparam.arg2 = g_faca_d[l_ac].faca010
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_oodb002_2") THEN
                  #檢查成功時後續處理
                  SELECT oodb005,oodb006 INTO l_oodb005,g_faca_d[l_ac].faca017
                    FROM oodb_t
                   WHERE oodbent = g_enterprise
                     AND oodb001 = g_ooef019
                     AND oodb002 = g_faca_d[l_ac].faca010
                     
                  DISPLAY g_faca_d[l_ac].faca017 TO faca017
                  
                  IF l_oodb005 = 'N' THEN 
                     CALL cl_set_comp_entry("faca011",TRUE)
                     CALL cl_set_comp_entry("faca013",FALSE)
                  ELSE
                     CALL cl_set_comp_entry("faca011",FALSE)
                     CALL cl_set_comp_entry("faca013",TRUE)
                  END IF
                  
                  IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_faca_d[l_ac].faca010 <> g_faca_d_t.faca010 OR cl_null(g_faca_d_t.faca010))) THEN 
                     CALL s_tax_ins(g_fabg_m.fabgdocno,g_faca_d[l_ac].facaseq,0,g_fabg_m.fabgcomp,
                                    g_faca_d[l_ac].faca009,g_faca_d[l_ac].faca010,
                                    g_faca_d[l_ac].faca008,g_fabg_m.fabg015,g_fabg_m.fabg016,g_fabg_m.fabgld,
                                    g_faca5_d[l_ac].faca039,g_faca5_d[l_ac].faca046)
                          RETURNING g_faca_d[l_ac].faca011,g_faca_d[l_ac].faca012,g_faca_d[l_ac].faca013,
                                    g_faca_d[l_ac].faca014,g_faca_d[l_ac].faca015,g_faca_d[l_ac].faca016,
                                    r_xrcd123,r_xrcd124,r_xrcd125,r_xrcd133,r_xrcd134,r_xrcd135
                     
                     CALL afat510_faca018_get(g_faca_d[l_ac].faca001,g_faca_d[l_ac].faca002,g_faca_d[l_ac].faca014) 
                     RETURNING g_faca_d[l_ac].faca018
                     
                     CALL s_curr_round_ld('1',g_fabg_m.fabgld,g_fabg_m.fabg015,g_faca_d[l_ac].faca011,2) RETURNING g_sub_success,g_errno,g_faca_d[l_ac].faca011
                     CALL s_curr_round_ld('1',g_fabg_m.fabgld,g_fabg_m.fabg015,g_faca_d[l_ac].faca012,2) RETURNING g_sub_success,g_errno,g_faca_d[l_ac].faca012
                     CALL s_curr_round_ld('1',g_fabg_m.fabgld,g_fabg_m.fabg015,g_faca_d[l_ac].faca013,2) RETURNING g_sub_success,g_errno,g_faca_d[l_ac].faca013
                     CALL s_curr_round_ld('1',g_fabg_m.fabgld,g_fabg_m.fabg015,g_faca_d[l_ac].faca014,2) RETURNING g_sub_success,g_errno,g_faca_d[l_ac].faca014
                     CALL s_curr_round_ld('1',g_fabg_m.fabgld,g_fabg_m.fabg015,g_faca_d[l_ac].faca015,2) RETURNING g_sub_success,g_errno,g_faca_d[l_ac].faca015
                     CALL s_curr_round_ld('1',g_fabg_m.fabgld,g_fabg_m.fabg015,g_faca_d[l_ac].faca016,2) RETURNING g_sub_success,g_errno,g_faca_d[l_ac].faca016
                     CALL s_curr_round_ld('1',g_fabg_m.fabgld,g_fabg_m.fabg015,g_faca_d[l_ac].faca018,2) RETURNING g_sub_success,g_errno,g_faca_d[l_ac].faca018
                     
                     #本位币二
                     IF g_glaa.glaa015 = 'Y' THEN 
                        LET g_faca5_d[l_ac].faca040 = g_faca_d[l_ac].faca014 * g_faca5_d[l_ac].faca039
                        LET g_faca5_d[l_ac].faca041 = g_faca_d[l_ac].faca015 * g_faca5_d[l_ac].faca039
                        LET g_faca5_d[l_ac].faca042 = g_faca_d[l_ac].faca016 * g_faca5_d[l_ac].faca039
                        LET g_faca5_d[l_ac].faca043 = g_faca_d[l_ac].faca009 * g_faca5_d[l_ac].faca039
                        LET g_faca5_d[l_ac].faca044 = g_faca_d[l_ac].faca018 * g_faca5_d[l_ac].faca039
                        
                        CALL s_curr_round_ld('1',g_fabg_m.fabgld,g_faca5_d[l_ac].faca038,g_faca5_d[l_ac].faca040,2) RETURNING g_sub_success,g_errno,g_faca5_d[l_ac].faca040
                        CALL s_curr_round_ld('1',g_fabg_m.fabgld,g_faca5_d[l_ac].faca038,g_faca5_d[l_ac].faca041,2) RETURNING g_sub_success,g_errno,g_faca5_d[l_ac].faca041
                        CALL s_curr_round_ld('1',g_fabg_m.fabgld,g_faca5_d[l_ac].faca038,g_faca5_d[l_ac].faca042,2) RETURNING g_sub_success,g_errno,g_faca5_d[l_ac].faca042
                        CALL s_curr_round_ld('1',g_fabg_m.fabgld,g_faca5_d[l_ac].faca038,g_faca5_d[l_ac].faca043,2) RETURNING g_sub_success,g_errno,g_faca5_d[l_ac].faca043
                        CALL s_curr_round_ld('1',g_fabg_m.fabgld,g_faca5_d[l_ac].faca038,g_faca5_d[l_ac].faca044,2) RETURNING g_sub_success,g_errno,g_faca5_d[l_ac].faca044
                     END IF
                     
                     #本位币三
                     IF g_glaa.glaa019 = 'Y' THEN 
                        LET g_faca5_d[l_ac].faca047 = g_faca_d[l_ac].faca014 * g_faca5_d[l_ac].faca046
                        LET g_faca5_d[l_ac].faca048 = g_faca_d[l_ac].faca015 * g_faca5_d[l_ac].faca046
                        LET g_faca5_d[l_ac].faca049 = g_faca_d[l_ac].faca016 * g_faca5_d[l_ac].faca046
                        LET g_faca5_d[l_ac].faca050 = g_faca_d[l_ac].faca009 * g_faca5_d[l_ac].faca046
                        LET g_faca5_d[l_ac].faca051 = g_faca_d[l_ac].faca018 * g_faca5_d[l_ac].faca046
                        
                        CALL s_curr_round_ld('1',g_fabg_m.fabgld,g_faca5_d[l_ac].faca045,g_faca5_d[l_ac].faca047,2) RETURNING g_sub_success,g_errno,g_faca5_d[l_ac].faca047
                        CALL s_curr_round_ld('1',g_fabg_m.fabgld,g_faca5_d[l_ac].faca045,g_faca5_d[l_ac].faca048,2) RETURNING g_sub_success,g_errno,g_faca5_d[l_ac].faca048
                        CALL s_curr_round_ld('1',g_fabg_m.fabgld,g_faca5_d[l_ac].faca045,g_faca5_d[l_ac].faca049,2) RETURNING g_sub_success,g_errno,g_faca5_d[l_ac].faca049
                        CALL s_curr_round_ld('1',g_fabg_m.fabgld,g_faca5_d[l_ac].faca045,g_faca5_d[l_ac].faca050,2) RETURNING g_sub_success,g_errno,g_faca5_d[l_ac].faca050
                        CALL s_curr_round_ld('1',g_fabg_m.fabgld,g_faca5_d[l_ac].faca045,g_faca5_d[l_ac].faca051,2) RETURNING g_sub_success,g_errno,g_faca5_d[l_ac].faca051
                     END IF 
                    
                     SELECT glab005 INTO g_faca_d[l_ac].faca024
                       FROM glab_t
                      WHERE glabent = g_enterprise
                        AND glabld  = g_fabg_m.fabgld
                        AND glab001 = '14'
                        AND glab002 = '2'  
                        AND glab003 = g_faca_d[l_ac].faca010
                     UPDATE xrcd_t SET xrcd009 = g_faca_d[l_ac].faca024
                      WHERE xrcd009 IS NULL
                        AND xrcdent = g_enterprise
                        AND xrcddocno = g_fabg_m.fabgdocno
                        AND xrcdld = g_fabg_m.fabgld
                        
                     LET g_faca_d_t.faca010 = g_faca_d[l_ac].faca010   
                  END IF
               ELSE
                  #檢查失敗時後續處理
                  LET g_faca_d[l_ac].faca010 = g_faca_d_t.faca010
                  LET g_faca_d[l_ac].faca017 = g_faca_d_t.faca017
                  NEXT FIELD CURRENT
               END IF
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca010
            #add-point:BEFORE FIELD faca010 name="input.b.page1.faca010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faca010
            #add-point:ON CHANGE faca010 name="input.g.page1.faca010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca017
            #add-point:BEFORE FIELD faca017 name="input.b.page1.faca017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca017
            
            #add-point:AFTER FIELD faca017 name="input.a.page1.faca017"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faca017
            #add-point:ON CHANGE faca017 name="input.g.page1.faca017"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca007
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_faca_d[l_ac].faca007,"0","1","","","azz-00079",1) THEN
               NEXT FIELD faca007
            END IF 
 
 
 
            #add-point:AFTER FIELD faca007 name="input.a.page1.faca007"
            IF NOT cl_null(g_faca_d[l_ac].faca007) THEN 
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_faca_d[l_ac].faca007 <> g_faca_d_t.faca007 OR cl_null(g_faca_d_t.faca007))) THEN            
                  CALL s_tax_ins(g_fabg_m.fabgdocno,g_faca_d[l_ac].facaseq,0,g_fabg_m.fabgcomp,
                                 g_faca_d[l_ac].faca007*g_faca_d[l_ac].faca008,g_faca_d[l_ac].faca010,
                                 g_faca_d[l_ac].faca008,g_fabg_m.fabg015,g_fabg_m.fabg016,g_fabg_m.fabgld,
                                 g_faca5_d[l_ac].faca039,g_faca5_d[l_ac].faca046)
                       RETURNING g_faca_d[l_ac].faca011,g_faca_d[l_ac].faca012,g_faca_d[l_ac].faca013,
                                 g_faca_d[l_ac].faca014,g_faca_d[l_ac].faca015,g_faca_d[l_ac].faca016,
                                 r_xrcd123,r_xrcd124,r_xrcd125,r_xrcd133,r_xrcd134,r_xrcd135
                  
                  CALL afat510_faca018_get(g_faca_d[l_ac].faca001,g_faca_d[l_ac].faca002,g_faca_d[l_ac].faca014) 
                  RETURNING g_faca_d[l_ac].faca018
                  
                  CALL s_curr_round_ld('1',g_fabg_m.fabgld,g_fabg_m.fabg015,g_faca_d[l_ac].faca011,2) RETURNING g_sub_success,g_errno,g_faca_d[l_ac].faca011
                  CALL s_curr_round_ld('1',g_fabg_m.fabgld,g_fabg_m.fabg015,g_faca_d[l_ac].faca012,2) RETURNING g_sub_success,g_errno,g_faca_d[l_ac].faca012
                  CALL s_curr_round_ld('1',g_fabg_m.fabgld,g_fabg_m.fabg015,g_faca_d[l_ac].faca013,2) RETURNING g_sub_success,g_errno,g_faca_d[l_ac].faca013
                  CALL s_curr_round_ld('1',g_fabg_m.fabgld,g_fabg_m.fabg015,g_faca_d[l_ac].faca014,2) RETURNING g_sub_success,g_errno,g_faca_d[l_ac].faca014
                  CALL s_curr_round_ld('1',g_fabg_m.fabgld,g_fabg_m.fabg015,g_faca_d[l_ac].faca015,2) RETURNING g_sub_success,g_errno,g_faca_d[l_ac].faca015
                  CALL s_curr_round_ld('1',g_fabg_m.fabgld,g_fabg_m.fabg015,g_faca_d[l_ac].faca016,2) RETURNING g_sub_success,g_errno,g_faca_d[l_ac].faca016
                  CALL s_curr_round_ld('1',g_fabg_m.fabgld,g_fabg_m.fabg015,g_faca_d[l_ac].faca018,2) RETURNING g_sub_success,g_errno,g_faca_d[l_ac].faca018
                  
                  #本位币二
                  IF g_glaa.glaa015 = 'Y' THEN 
                     LET g_faca5_d[l_ac].faca040 = g_faca_d[l_ac].faca014 * g_faca5_d[l_ac].faca039
                     LET g_faca5_d[l_ac].faca041 = g_faca_d[l_ac].faca015 * g_faca5_d[l_ac].faca039
                     LET g_faca5_d[l_ac].faca042 = g_faca_d[l_ac].faca016 * g_faca5_d[l_ac].faca039
                     LET g_faca5_d[l_ac].faca043 = g_faca_d[l_ac].faca009 * g_faca5_d[l_ac].faca039
                     LET g_faca5_d[l_ac].faca044 = g_faca_d[l_ac].faca018 * g_faca5_d[l_ac].faca039
                     
                     CALL s_curr_round_ld('1',g_fabg_m.fabgld,g_faca5_d[l_ac].faca038,g_faca5_d[l_ac].faca040,2) RETURNING g_sub_success,g_errno,g_faca5_d[l_ac].faca040
                     CALL s_curr_round_ld('1',g_fabg_m.fabgld,g_faca5_d[l_ac].faca038,g_faca5_d[l_ac].faca041,2) RETURNING g_sub_success,g_errno,g_faca5_d[l_ac].faca041
                     CALL s_curr_round_ld('1',g_fabg_m.fabgld,g_faca5_d[l_ac].faca038,g_faca5_d[l_ac].faca042,2) RETURNING g_sub_success,g_errno,g_faca5_d[l_ac].faca042
                     CALL s_curr_round_ld('1',g_fabg_m.fabgld,g_faca5_d[l_ac].faca038,g_faca5_d[l_ac].faca043,2) RETURNING g_sub_success,g_errno,g_faca5_d[l_ac].faca043
                     CALL s_curr_round_ld('1',g_fabg_m.fabgld,g_faca5_d[l_ac].faca038,g_faca5_d[l_ac].faca044,2) RETURNING g_sub_success,g_errno,g_faca5_d[l_ac].faca044
                  END IF
                  
                  #本位币三
                  IF g_glaa.glaa019 = 'Y' THEN 
                     LET g_faca5_d[l_ac].faca047 = g_faca_d[l_ac].faca014 * g_faca5_d[l_ac].faca046
                     LET g_faca5_d[l_ac].faca048 = g_faca_d[l_ac].faca015 * g_faca5_d[l_ac].faca046
                     LET g_faca5_d[l_ac].faca049 = g_faca_d[l_ac].faca016 * g_faca5_d[l_ac].faca046
                     LET g_faca5_d[l_ac].faca050 = g_faca_d[l_ac].faca009 * g_faca5_d[l_ac].faca046
                     LET g_faca5_d[l_ac].faca051 = g_faca_d[l_ac].faca018 * g_faca5_d[l_ac].faca046
                     
                     CALL s_curr_round_ld('1',g_fabg_m.fabgld,g_faca5_d[l_ac].faca045,g_faca5_d[l_ac].faca047,2) RETURNING g_sub_success,g_errno,g_faca5_d[l_ac].faca047
                     CALL s_curr_round_ld('1',g_fabg_m.fabgld,g_faca5_d[l_ac].faca045,g_faca5_d[l_ac].faca048,2) RETURNING g_sub_success,g_errno,g_faca5_d[l_ac].faca048
                     CALL s_curr_round_ld('1',g_fabg_m.fabgld,g_faca5_d[l_ac].faca045,g_faca5_d[l_ac].faca049,2) RETURNING g_sub_success,g_errno,g_faca5_d[l_ac].faca049
                     CALL s_curr_round_ld('1',g_fabg_m.fabgld,g_faca5_d[l_ac].faca045,g_faca5_d[l_ac].faca050,2) RETURNING g_sub_success,g_errno,g_faca5_d[l_ac].faca050
                     CALL s_curr_round_ld('1',g_fabg_m.fabgld,g_faca5_d[l_ac].faca045,g_faca5_d[l_ac].faca051,2) RETURNING g_sub_success,g_errno,g_faca5_d[l_ac].faca051
                  END IF
                     
                  LET g_faca_d_t.faca007 = g_faca_d[l_ac].faca007
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca007
            #add-point:BEFORE FIELD faca007 name="input.b.page1.faca007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faca007
            #add-point:ON CHANGE faca007 name="input.g.page1.faca007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca011
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_faca_d[l_ac].faca011,"0","1","","","azz-00079",1) THEN
               NEXT FIELD faca011
            END IF 
 
 
 
            #add-point:AFTER FIELD faca011 name="input.a.page1.faca011"
            IF NOT cl_null(g_faca_d[l_ac].faca011) THEN 
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_faca_d[l_ac].faca011 <> g_faca_d_t.faca011 OR cl_null(g_faca_d_t.faca011))) THEN             
                  CALL s_tax_ins(g_fabg_m.fabgdocno,g_faca_d[l_ac].facaseq,0,g_fabg_m.fabgcomp,
                                 g_faca_d[l_ac].faca011,g_faca_d[l_ac].faca010,
                                 g_faca_d[l_ac].faca008,g_fabg_m.fabg015,g_fabg_m.fabg016,g_fabg_m.fabgld,
                                 g_faca5_d[l_ac].faca039,g_faca5_d[l_ac].faca046)
                       RETURNING g_faca_d[l_ac].faca011,g_faca_d[l_ac].faca012,g_faca_d[l_ac].faca013,
                                 g_faca_d[l_ac].faca014,g_faca_d[l_ac].faca015,g_faca_d[l_ac].faca016,
                                 r_xrcd123,r_xrcd124,r_xrcd125,r_xrcd133,r_xrcd134,r_xrcd135
                  
                  CALL afat510_faca018_get(g_faca_d[l_ac].faca001,g_faca_d[l_ac].faca002,g_faca_d[l_ac].faca014) 
                  RETURNING g_faca_d[l_ac].faca018
                  
                  CALL s_curr_round_ld('1',g_fabg_m.fabgld,g_fabg_m.fabg015,g_faca_d[l_ac].faca011,2) RETURNING g_sub_success,g_errno,g_faca_d[l_ac].faca011
                  CALL s_curr_round_ld('1',g_fabg_m.fabgld,g_fabg_m.fabg015,g_faca_d[l_ac].faca012,2) RETURNING g_sub_success,g_errno,g_faca_d[l_ac].faca012
                  CALL s_curr_round_ld('1',g_fabg_m.fabgld,g_fabg_m.fabg015,g_faca_d[l_ac].faca013,2) RETURNING g_sub_success,g_errno,g_faca_d[l_ac].faca013
                  CALL s_curr_round_ld('1',g_fabg_m.fabgld,g_fabg_m.fabg015,g_faca_d[l_ac].faca014,2) RETURNING g_sub_success,g_errno,g_faca_d[l_ac].faca014
                  CALL s_curr_round_ld('1',g_fabg_m.fabgld,g_fabg_m.fabg015,g_faca_d[l_ac].faca015,2) RETURNING g_sub_success,g_errno,g_faca_d[l_ac].faca015
                  CALL s_curr_round_ld('1',g_fabg_m.fabgld,g_fabg_m.fabg015,g_faca_d[l_ac].faca016,2) RETURNING g_sub_success,g_errno,g_faca_d[l_ac].faca016
                  CALL s_curr_round_ld('1',g_fabg_m.fabgld,g_fabg_m.fabg015,g_faca_d[l_ac].faca018,2) RETURNING g_sub_success,g_errno,g_faca_d[l_ac].faca018
                  
                  #本位币二
                  IF g_glaa.glaa015 = 'Y' THEN 
                     LET g_faca5_d[l_ac].faca040 = g_faca_d[l_ac].faca014 * g_faca5_d[l_ac].faca039
                     LET g_faca5_d[l_ac].faca041 = g_faca_d[l_ac].faca015 * g_faca5_d[l_ac].faca039
                     LET g_faca5_d[l_ac].faca042 = g_faca_d[l_ac].faca016 * g_faca5_d[l_ac].faca039
                     LET g_faca5_d[l_ac].faca043 = g_faca_d[l_ac].faca009 * g_faca5_d[l_ac].faca039
                     LET g_faca5_d[l_ac].faca044 = g_faca_d[l_ac].faca018 * g_faca5_d[l_ac].faca039
                     
                     CALL s_curr_round_ld('1',g_fabg_m.fabgld,g_faca5_d[l_ac].faca038,g_faca5_d[l_ac].faca040,2) RETURNING g_sub_success,g_errno,g_faca5_d[l_ac].faca040
                     CALL s_curr_round_ld('1',g_fabg_m.fabgld,g_faca5_d[l_ac].faca038,g_faca5_d[l_ac].faca041,2) RETURNING g_sub_success,g_errno,g_faca5_d[l_ac].faca041
                     CALL s_curr_round_ld('1',g_fabg_m.fabgld,g_faca5_d[l_ac].faca038,g_faca5_d[l_ac].faca042,2) RETURNING g_sub_success,g_errno,g_faca5_d[l_ac].faca042
                     CALL s_curr_round_ld('1',g_fabg_m.fabgld,g_faca5_d[l_ac].faca038,g_faca5_d[l_ac].faca043,2) RETURNING g_sub_success,g_errno,g_faca5_d[l_ac].faca043
                     CALL s_curr_round_ld('1',g_fabg_m.fabgld,g_faca5_d[l_ac].faca038,g_faca5_d[l_ac].faca044,2) RETURNING g_sub_success,g_errno,g_faca5_d[l_ac].faca044
                  END IF
                  
                  #本位币三
                  IF g_glaa.glaa019 = 'Y' THEN 
                     LET g_faca5_d[l_ac].faca047 = g_faca_d[l_ac].faca014 * g_faca5_d[l_ac].faca046
                     LET g_faca5_d[l_ac].faca048 = g_faca_d[l_ac].faca015 * g_faca5_d[l_ac].faca046
                     LET g_faca5_d[l_ac].faca049 = g_faca_d[l_ac].faca016 * g_faca5_d[l_ac].faca046
                     LET g_faca5_d[l_ac].faca050 = g_faca_d[l_ac].faca009 * g_faca5_d[l_ac].faca046
                     LET g_faca5_d[l_ac].faca051 = g_faca_d[l_ac].faca018 * g_faca5_d[l_ac].faca046
                     
                     CALL s_curr_round_ld('1',g_fabg_m.fabgld,g_faca5_d[l_ac].faca045,g_faca5_d[l_ac].faca047,2) RETURNING g_sub_success,g_errno,g_faca5_d[l_ac].faca047
                     CALL s_curr_round_ld('1',g_fabg_m.fabgld,g_faca5_d[l_ac].faca045,g_faca5_d[l_ac].faca048,2) RETURNING g_sub_success,g_errno,g_faca5_d[l_ac].faca048
                     CALL s_curr_round_ld('1',g_fabg_m.fabgld,g_faca5_d[l_ac].faca045,g_faca5_d[l_ac].faca049,2) RETURNING g_sub_success,g_errno,g_faca5_d[l_ac].faca049
                     CALL s_curr_round_ld('1',g_fabg_m.fabgld,g_faca5_d[l_ac].faca045,g_faca5_d[l_ac].faca050,2) RETURNING g_sub_success,g_errno,g_faca5_d[l_ac].faca050
                     CALL s_curr_round_ld('1',g_fabg_m.fabgld,g_faca5_d[l_ac].faca045,g_faca5_d[l_ac].faca051,2) RETURNING g_sub_success,g_errno,g_faca5_d[l_ac].faca051
                  END IF    
                  LET g_faca_d_t.faca011 = g_faca_d[l_ac].faca011
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca011
            #add-point:BEFORE FIELD faca011 name="input.b.page1.faca011"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faca011
            #add-point:ON CHANGE faca011 name="input.g.page1.faca011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca012
            #add-point:BEFORE FIELD faca012 name="input.b.page1.faca012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca012
            
            #add-point:AFTER FIELD faca012 name="input.a.page1.faca012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faca012
            #add-point:ON CHANGE faca012 name="input.g.page1.faca012"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca013
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_faca_d[l_ac].faca013,"0","1","","","azz-00079",1) THEN
               NEXT FIELD faca013
            END IF 
 
 
 
            #add-point:AFTER FIELD faca013 name="input.a.page1.faca013"
            IF NOT cl_null(g_faca_d[l_ac].faca013) THEN 
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_faca_d[l_ac].faca013 <> g_faca_d_t.faca013 OR cl_null(g_faca_d_t.faca013))) THEN             
                  CALL s_tax_ins(g_fabg_m.fabgdocno,g_faca_d[l_ac].facaseq,0,g_fabg_m.fabgcomp,
                                 g_faca_d[l_ac].faca013,g_faca_d[l_ac].faca010,
                                 g_faca_d[l_ac].faca008,g_fabg_m.fabg015,g_fabg_m.fabg016,g_fabg_m.fabgld,
                                 g_faca5_d[l_ac].faca039,g_faca5_d[l_ac].faca046)
                       RETURNING g_faca_d[l_ac].faca011,g_faca_d[l_ac].faca012,g_faca_d[l_ac].faca013,
                                 g_faca_d[l_ac].faca014,g_faca_d[l_ac].faca015,g_faca_d[l_ac].faca016,
                                 r_xrcd123,r_xrcd124,r_xrcd125,r_xrcd133,r_xrcd134,r_xrcd135
                  
                  CALL afat510_faca018_get(g_faca_d[l_ac].faca001,g_faca_d[l_ac].faca002,g_faca_d[l_ac].faca014) 
                  RETURNING g_faca_d[l_ac].faca018
                  
                  CALL s_curr_round_ld('1',g_fabg_m.fabgld,g_fabg_m.fabg015,g_faca_d[l_ac].faca011,2) RETURNING g_sub_success,g_errno,g_faca_d[l_ac].faca011
                  CALL s_curr_round_ld('1',g_fabg_m.fabgld,g_fabg_m.fabg015,g_faca_d[l_ac].faca012,2) RETURNING g_sub_success,g_errno,g_faca_d[l_ac].faca012
                  CALL s_curr_round_ld('1',g_fabg_m.fabgld,g_fabg_m.fabg015,g_faca_d[l_ac].faca013,2) RETURNING g_sub_success,g_errno,g_faca_d[l_ac].faca013
                  CALL s_curr_round_ld('1',g_fabg_m.fabgld,g_fabg_m.fabg015,g_faca_d[l_ac].faca014,2) RETURNING g_sub_success,g_errno,g_faca_d[l_ac].faca014
                  CALL s_curr_round_ld('1',g_fabg_m.fabgld,g_fabg_m.fabg015,g_faca_d[l_ac].faca015,2) RETURNING g_sub_success,g_errno,g_faca_d[l_ac].faca015
                  CALL s_curr_round_ld('1',g_fabg_m.fabgld,g_fabg_m.fabg015,g_faca_d[l_ac].faca016,2) RETURNING g_sub_success,g_errno,g_faca_d[l_ac].faca016
                  CALL s_curr_round_ld('1',g_fabg_m.fabgld,g_fabg_m.fabg015,g_faca_d[l_ac].faca018,2) RETURNING g_sub_success,g_errno,g_faca_d[l_ac].faca018
                  
                  #本位币二
                  IF g_glaa.glaa015 = 'Y' THEN 
                     LET g_faca5_d[l_ac].faca040 = g_faca_d[l_ac].faca014 * g_faca5_d[l_ac].faca039
                     LET g_faca5_d[l_ac].faca041 = g_faca_d[l_ac].faca015 * g_faca5_d[l_ac].faca039
                     LET g_faca5_d[l_ac].faca042 = g_faca_d[l_ac].faca016 * g_faca5_d[l_ac].faca039
                     LET g_faca5_d[l_ac].faca043 = g_faca_d[l_ac].faca009 * g_faca5_d[l_ac].faca039
                     LET g_faca5_d[l_ac].faca044 = g_faca_d[l_ac].faca018 * g_faca5_d[l_ac].faca039
                     
                     CALL s_curr_round_ld('1',g_fabg_m.fabgld,g_faca5_d[l_ac].faca038,g_faca5_d[l_ac].faca040,2) RETURNING g_sub_success,g_errno,g_faca5_d[l_ac].faca040
                     CALL s_curr_round_ld('1',g_fabg_m.fabgld,g_faca5_d[l_ac].faca038,g_faca5_d[l_ac].faca041,2) RETURNING g_sub_success,g_errno,g_faca5_d[l_ac].faca041
                     CALL s_curr_round_ld('1',g_fabg_m.fabgld,g_faca5_d[l_ac].faca038,g_faca5_d[l_ac].faca042,2) RETURNING g_sub_success,g_errno,g_faca5_d[l_ac].faca042
                     CALL s_curr_round_ld('1',g_fabg_m.fabgld,g_faca5_d[l_ac].faca038,g_faca5_d[l_ac].faca043,2) RETURNING g_sub_success,g_errno,g_faca5_d[l_ac].faca043
                     CALL s_curr_round_ld('1',g_fabg_m.fabgld,g_faca5_d[l_ac].faca038,g_faca5_d[l_ac].faca044,2) RETURNING g_sub_success,g_errno,g_faca5_d[l_ac].faca044
                  END IF
                  
                  #本位币三
                  IF g_glaa.glaa019 = 'Y' THEN 
                     LET g_faca5_d[l_ac].faca047 = g_faca_d[l_ac].faca014 * g_faca5_d[l_ac].faca046
                     LET g_faca5_d[l_ac].faca048 = g_faca_d[l_ac].faca015 * g_faca5_d[l_ac].faca046
                     LET g_faca5_d[l_ac].faca049 = g_faca_d[l_ac].faca016 * g_faca5_d[l_ac].faca046
                     LET g_faca5_d[l_ac].faca050 = g_faca_d[l_ac].faca009 * g_faca5_d[l_ac].faca046
                     LET g_faca5_d[l_ac].faca051 = g_faca_d[l_ac].faca018 * g_faca5_d[l_ac].faca046
                     
                     CALL s_curr_round_ld('1',g_fabg_m.fabgld,g_faca5_d[l_ac].faca045,g_faca5_d[l_ac].faca047,2) RETURNING g_sub_success,g_errno,g_faca5_d[l_ac].faca047
                     CALL s_curr_round_ld('1',g_fabg_m.fabgld,g_faca5_d[l_ac].faca045,g_faca5_d[l_ac].faca048,2) RETURNING g_sub_success,g_errno,g_faca5_d[l_ac].faca048
                     CALL s_curr_round_ld('1',g_fabg_m.fabgld,g_faca5_d[l_ac].faca045,g_faca5_d[l_ac].faca049,2) RETURNING g_sub_success,g_errno,g_faca5_d[l_ac].faca049
                     CALL s_curr_round_ld('1',g_fabg_m.fabgld,g_faca5_d[l_ac].faca045,g_faca5_d[l_ac].faca050,2) RETURNING g_sub_success,g_errno,g_faca5_d[l_ac].faca050
                     CALL s_curr_round_ld('1',g_fabg_m.fabgld,g_faca5_d[l_ac].faca045,g_faca5_d[l_ac].faca051,2) RETURNING g_sub_success,g_errno,g_faca5_d[l_ac].faca051
                  END IF    
                  LET g_faca_d_t.faca013 = g_faca_d[l_ac].faca013
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca013
            #add-point:BEFORE FIELD faca013 name="input.b.page1.faca013"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faca013
            #add-point:ON CHANGE faca013 name="input.g.page1.faca013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca014
            #add-point:BEFORE FIELD faca014 name="input.b.page1.faca014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca014
            
            #add-point:AFTER FIELD faca014 name="input.a.page1.faca014"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faca014
            #add-point:ON CHANGE faca014 name="input.g.page1.faca014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca015
            #add-point:BEFORE FIELD faca015 name="input.b.page1.faca015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca015
            
            #add-point:AFTER FIELD faca015 name="input.a.page1.faca015"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faca015
            #add-point:ON CHANGE faca015 name="input.g.page1.faca015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca016
            #add-point:BEFORE FIELD faca016 name="input.b.page1.faca016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca016
            
            #add-point:AFTER FIELD faca016 name="input.a.page1.faca016"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faca016
            #add-point:ON CHANGE faca016 name="input.g.page1.faca016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca018
            #add-point:BEFORE FIELD faca018 name="input.b.page1.faca018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca018
            
            #add-point:AFTER FIELD faca018 name="input.a.page1.faca018"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faca018
            #add-point:ON CHANGE faca018 name="input.g.page1.faca018"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca024
            #add-point:BEFORE FIELD faca024 name="input.b.page1.faca024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca024
            
            #add-point:AFTER FIELD faca024 name="input.a.page1.faca024"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faca024
            #add-point:ON CHANGE faca024 name="input.g.page1.faca024"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.facaseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD facaseq
            #add-point:ON ACTION controlp INFIELD facaseq name="input.c.page1.facaseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.faca001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca001
            #add-point:ON ACTION controlp INFIELD faca001 name="input.c.page1.faca001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.faca002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca002
            #add-point:ON ACTION controlp INFIELD faca002 name="input.c.page1.faca002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.faca003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca003
            #add-point:ON ACTION controlp INFIELD faca003 name="input.c.page1.faca003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.faca004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca004
            #add-point:ON ACTION controlp INFIELD faca004 name="input.c.page1.faca004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.faca005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca005
            #add-point:ON ACTION controlp INFIELD faca005 name="input.c.page1.faca005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.faca008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca008
            #add-point:ON ACTION controlp INFIELD faca008 name="input.c.page1.faca008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.faca009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca009
            #add-point:ON ACTION controlp INFIELD faca009 name="input.c.page1.faca009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.faca010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca010
            #add-point:ON ACTION controlp INFIELD faca010 name="input.c.page1.faca010"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_faca_d[l_ac].faca010             #給予default值
            LET g_qryparam.default4 = g_faca_d[l_ac].faca017
            #給予arg
            LET g_qryparam.arg1 = g_ooef019

 
            CALL q_oodb002_5()                                #呼叫開窗
 
            LET g_faca_d[l_ac].faca010 = g_qryparam.return1
            LET g_faca_d[l_ac].faca017 = g_qryparam.return4            

            DISPLAY g_faca_d[l_ac].faca010 TO faca010              #
            DISPLAY g_faca_d[l_ac].faca017 TO faca017

            NEXT FIELD faca010                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page1.faca017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca017
            #add-point:ON ACTION controlp INFIELD faca017 name="input.c.page1.faca017"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.faca007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca007
            #add-point:ON ACTION controlp INFIELD faca007 name="input.c.page1.faca007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.faca011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca011
            #add-point:ON ACTION controlp INFIELD faca011 name="input.c.page1.faca011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.faca012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca012
            #add-point:ON ACTION controlp INFIELD faca012 name="input.c.page1.faca012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.faca013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca013
            #add-point:ON ACTION controlp INFIELD faca013 name="input.c.page1.faca013"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.faca014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca014
            #add-point:ON ACTION controlp INFIELD faca014 name="input.c.page1.faca014"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.faca015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca015
            #add-point:ON ACTION controlp INFIELD faca015 name="input.c.page1.faca015"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.faca016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca016
            #add-point:ON ACTION controlp INFIELD faca016 name="input.c.page1.faca016"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.faca018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca018
            #add-point:ON ACTION controlp INFIELD faca018 name="input.c.page1.faca018"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.faca024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca024
            #add-point:ON ACTION controlp INFIELD faca024 name="input.c.page1.faca024"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_faca_d[l_ac].* = g_faca_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE afat510_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_faca_d[l_ac].facaseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_faca_d[l_ac].* = g_faca_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL afat510_faca_t_mask_restore('restore_mask_o')
      
               UPDATE faca_t SET (facald,facadocno,facaseq,faca001,faca002,faca003,faca004,faca005,faca008, 
                   faca009,faca010,faca017,faca007,faca011,faca012,faca013,faca014,faca015,faca016,faca018, 
                   faca024,faca019,faca036,faca025,faca026,faca027,faca028,faca029,faca030,faca031,faca032, 
                   faca033,faca034,faca052,faca053,faca054,faca065,faca055,faca056,faca057,faca058,faca059, 
                   faca060,faca061,faca062,faca063,faca064,faca043,faca038,faca039,faca040,faca041,faca042, 
                   faca044,faca050,faca045,faca046,faca047,faca048,faca049,faca051) = (g_fabg_m.fabgld, 
                   g_fabg_m.fabgdocno,g_faca_d[l_ac].facaseq,g_faca_d[l_ac].faca001,g_faca_d[l_ac].faca002, 
                   g_faca_d[l_ac].faca003,g_faca_d[l_ac].faca004,g_faca_d[l_ac].faca005,g_faca_d[l_ac].faca008, 
                   g_faca_d[l_ac].faca009,g_faca_d[l_ac].faca010,g_faca_d[l_ac].faca017,g_faca_d[l_ac].faca007, 
                   g_faca_d[l_ac].faca011,g_faca_d[l_ac].faca012,g_faca_d[l_ac].faca013,g_faca_d[l_ac].faca014, 
                   g_faca_d[l_ac].faca015,g_faca_d[l_ac].faca016,g_faca_d[l_ac].faca018,g_faca_d[l_ac].faca024, 
                   g_faca2_d[l_ac].faca019,g_faca2_d[l_ac].faca036,g_faca2_d[l_ac].faca025,g_faca2_d[l_ac].faca026, 
                   g_faca2_d[l_ac].faca027,g_faca2_d[l_ac].faca028,g_faca2_d[l_ac].faca029,g_faca2_d[l_ac].faca030, 
                   g_faca2_d[l_ac].faca031,g_faca2_d[l_ac].faca032,g_faca2_d[l_ac].faca033,g_faca2_d[l_ac].faca034, 
                   g_faca2_d[l_ac].faca052,g_faca2_d[l_ac].faca053,g_faca2_d[l_ac].faca054,g_faca2_d[l_ac].faca065, 
                   g_faca2_d[l_ac].faca055,g_faca2_d[l_ac].faca056,g_faca2_d[l_ac].faca057,g_faca2_d[l_ac].faca058, 
                   g_faca2_d[l_ac].faca059,g_faca2_d[l_ac].faca060,g_faca2_d[l_ac].faca061,g_faca2_d[l_ac].faca062, 
                   g_faca2_d[l_ac].faca063,g_faca2_d[l_ac].faca064,g_faca5_d[l_ac].faca043,g_faca5_d[l_ac].faca038, 
                   g_faca5_d[l_ac].faca039,g_faca5_d[l_ac].faca040,g_faca5_d[l_ac].faca041,g_faca5_d[l_ac].faca042, 
                   g_faca5_d[l_ac].faca044,g_faca5_d[l_ac].faca050,g_faca5_d[l_ac].faca045,g_faca5_d[l_ac].faca046, 
                   g_faca5_d[l_ac].faca047,g_faca5_d[l_ac].faca048,g_faca5_d[l_ac].faca049,g_faca5_d[l_ac].faca051) 
 
                WHERE facaent = g_enterprise AND facald = g_fabg_m.fabgld 
                  AND facadocno = g_fabg_m.fabgdocno 
 
                  AND facaseq = g_faca_d_t.facaseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_faca_d[l_ac].* = g_faca_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "faca_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_faca_d[l_ac].* = g_faca_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "faca_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fabg_m.fabgld
               LET gs_keys_bak[1] = g_fabgld_t
               LET gs_keys[2] = g_fabg_m.fabgdocno
               LET gs_keys_bak[2] = g_fabgdocno_t
               LET gs_keys[3] = g_faca_d[g_detail_idx].facaseq
               LET gs_keys_bak[3] = g_faca_d_t.facaseq
               CALL afat510_update_b('faca_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL afat510_faca_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_faca_d[g_detail_idx].facaseq = g_faca_d_t.facaseq 
 
                  ) THEN
                  LET gs_keys[01] = g_fabg_m.fabgld
                  LET gs_keys[gs_keys.getLength()+1] = g_fabg_m.fabgdocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_faca_d_t.facaseq
 
                  CALL afat510_key_update_b(gs_keys,'faca_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_fabg_m),util.JSON.stringify(g_faca_d_t)
               LET g_log2 = util.JSON.stringify(g_fabg_m),util.JSON.stringify(g_faca_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL afat510_unlock_b("faca_t","'1'")
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
               LET g_faca_d[li_reproduce_target].* = g_faca_d[li_reproduce].*
               LET g_faca2_d[li_reproduce_target].* = g_faca2_d[li_reproduce].*
               LET g_faca5_d[li_reproduce_target].* = g_faca5_d[li_reproduce].*
 
               LET g_faca_d[li_reproduce_target].facaseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_faca_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_faca_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
      INPUT ARRAY g_faca2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = FALSE, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = FALSE,
                 APPEND ROW = FALSE)
                 
         #自訂ACTION(detail_input,page_2)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body2.before_input2"
            
            #end add-point
            
            CALL afat510_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'3',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_faca2_d.getLength()
            #add-point:資料輸入前 name="input.body2.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_faca2_d[l_ac].* TO NULL 
            INITIALIZE g_faca2_d_t.* TO NULL 
            INITIALIZE g_faca2_d_o.* TO NULL 
            #公用欄位給值(單身2)
            
            #自定義預設值(單身2)
            
            #add-point:modify段before備份 name="input.body2.insert.before_bak"
            
            #end add-point
            LET g_faca2_d_t.* = g_faca2_d[l_ac].*     #新輸入資料
            LET g_faca2_d_o.* = g_faca2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL afat510_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body2.insert.after_set_entry_b"
            
            #end add-point
            CALL afat510_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_faca_d[li_reproduce_target].* = g_faca_d[li_reproduce].*
               LET g_faca2_d[li_reproduce_target].* = g_faca2_d[li_reproduce].*
               LET g_faca5_d[li_reproduce_target].* = g_faca5_d[li_reproduce].*
 
               LET g_faca2_d[li_reproduce_target].facaseq = NULL
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
            OPEN afat510_cl USING g_enterprise,g_fabg_m.fabgld,g_fabg_m.fabgdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN afat510_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE afat510_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_faca2_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_faca2_d[l_ac].facaseq IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_faca2_d_t.* = g_faca2_d[l_ac].*  #BACKUP
               LET g_faca2_d_o.* = g_faca2_d[l_ac].*  #BACKUP
               CALL afat510_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body2.after_set_entry_b"
               
               #end add-point  
               CALL afat510_set_no_entry_b(l_cmd)
               IF NOT afat510_lock_b("faca_t","'2'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH afat510_bcl INTO g_faca_d[l_ac].facaseq,g_faca_d[l_ac].faca001,g_faca_d[l_ac].faca002, 
                      g_faca_d[l_ac].faca003,g_faca_d[l_ac].faca004,g_faca_d[l_ac].faca005,g_faca_d[l_ac].faca008, 
                      g_faca_d[l_ac].faca009,g_faca_d[l_ac].faca010,g_faca_d[l_ac].faca017,g_faca_d[l_ac].faca007, 
                      g_faca_d[l_ac].faca011,g_faca_d[l_ac].faca012,g_faca_d[l_ac].faca013,g_faca_d[l_ac].faca014, 
                      g_faca_d[l_ac].faca015,g_faca_d[l_ac].faca016,g_faca_d[l_ac].faca018,g_faca_d[l_ac].faca024, 
                      g_faca2_d[l_ac].facaseq,g_faca2_d[l_ac].faca019,g_faca2_d[l_ac].faca036,g_faca2_d[l_ac].faca025, 
                      g_faca2_d[l_ac].faca026,g_faca2_d[l_ac].faca027,g_faca2_d[l_ac].faca028,g_faca2_d[l_ac].faca029, 
                      g_faca2_d[l_ac].faca030,g_faca2_d[l_ac].faca031,g_faca2_d[l_ac].faca032,g_faca2_d[l_ac].faca033, 
                      g_faca2_d[l_ac].faca034,g_faca2_d[l_ac].faca052,g_faca2_d[l_ac].faca053,g_faca2_d[l_ac].faca054, 
                      g_faca2_d[l_ac].faca065,g_faca2_d[l_ac].faca055,g_faca2_d[l_ac].faca056,g_faca2_d[l_ac].faca057, 
                      g_faca2_d[l_ac].faca058,g_faca2_d[l_ac].faca059,g_faca2_d[l_ac].faca060,g_faca2_d[l_ac].faca061, 
                      g_faca2_d[l_ac].faca062,g_faca2_d[l_ac].faca063,g_faca2_d[l_ac].faca064,g_faca5_d[l_ac].facaseq, 
                      g_faca5_d[l_ac].faca043,g_faca5_d[l_ac].faca038,g_faca5_d[l_ac].faca039,g_faca5_d[l_ac].faca040, 
                      g_faca5_d[l_ac].faca041,g_faca5_d[l_ac].faca042,g_faca5_d[l_ac].faca044,g_faca5_d[l_ac].faca050, 
                      g_faca5_d[l_ac].faca045,g_faca5_d[l_ac].faca046,g_faca5_d[l_ac].faca047,g_faca5_d[l_ac].faca048, 
                      g_faca5_d[l_ac].faca049,g_faca5_d[l_ac].faca051
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_faca2_d_mask_o[l_ac].* =  g_faca2_d[l_ac].*
                  CALL afat510_faca_t_mask()
                  LET g_faca2_d_mask_n[l_ac].* =  g_faca2_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL afat510_show()
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
               LET gs_keys[01] = g_fabg_m.fabgld
               LET gs_keys[gs_keys.getLength()+1] = g_fabg_m.fabgdocno
               LET gs_keys[gs_keys.getLength()+1] = g_faca2_d_t.facaseq
            
               #刪除同層單身
               IF NOT afat510_delete_b('faca_t',gs_keys,"'2'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE afat510_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT afat510_key_delete_b(gs_keys,'faca_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE afat510_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
 
 
               
               #add-point:單身2刪除中 name="input.body2.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE afat510_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身2刪除後 name="input.body2.a_delete"
               
               #end add-point
               LET l_count = g_faca_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body2.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_faca2_d.getLength() + 1) THEN
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
            SELECT COUNT(1) INTO l_count FROM faca_t 
             WHERE facaent = g_enterprise AND facald = g_fabg_m.fabgld
               AND facadocno = g_fabg_m.fabgdocno
               AND facaseq = g_faca2_d[l_ac].facaseq
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前 name="input.body2.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fabg_m.fabgld
               LET gs_keys[2] = g_fabg_m.fabgdocno
               LET gs_keys[3] = g_faca2_d[g_detail_idx].facaseq
               CALL afat510_insert_b('faca_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2 name="input.body2.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_faca_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "faca_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL afat510_b_fill()
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
               LET g_faca2_d[l_ac].* = g_faca2_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE afat510_bcl
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
               LET g_faca2_d[l_ac].* = g_faca2_d_t.*
            ELSE
               #add-point:單身page2修改前 name="input.body2.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身2)
               
               
               #將遮罩欄位還原
               CALL afat510_faca_t_mask_restore('restore_mask_o')
                              
               UPDATE faca_t SET (facald,facadocno,facaseq,faca001,faca002,faca003,faca004,faca005,faca008, 
                   faca009,faca010,faca017,faca007,faca011,faca012,faca013,faca014,faca015,faca016,faca018, 
                   faca024,faca019,faca036,faca025,faca026,faca027,faca028,faca029,faca030,faca031,faca032, 
                   faca033,faca034,faca052,faca053,faca054,faca065,faca055,faca056,faca057,faca058,faca059, 
                   faca060,faca061,faca062,faca063,faca064,faca043,faca038,faca039,faca040,faca041,faca042, 
                   faca044,faca050,faca045,faca046,faca047,faca048,faca049,faca051) = (g_fabg_m.fabgld, 
                   g_fabg_m.fabgdocno,g_faca_d[l_ac].facaseq,g_faca_d[l_ac].faca001,g_faca_d[l_ac].faca002, 
                   g_faca_d[l_ac].faca003,g_faca_d[l_ac].faca004,g_faca_d[l_ac].faca005,g_faca_d[l_ac].faca008, 
                   g_faca_d[l_ac].faca009,g_faca_d[l_ac].faca010,g_faca_d[l_ac].faca017,g_faca_d[l_ac].faca007, 
                   g_faca_d[l_ac].faca011,g_faca_d[l_ac].faca012,g_faca_d[l_ac].faca013,g_faca_d[l_ac].faca014, 
                   g_faca_d[l_ac].faca015,g_faca_d[l_ac].faca016,g_faca_d[l_ac].faca018,g_faca_d[l_ac].faca024, 
                   g_faca2_d[l_ac].faca019,g_faca2_d[l_ac].faca036,g_faca2_d[l_ac].faca025,g_faca2_d[l_ac].faca026, 
                   g_faca2_d[l_ac].faca027,g_faca2_d[l_ac].faca028,g_faca2_d[l_ac].faca029,g_faca2_d[l_ac].faca030, 
                   g_faca2_d[l_ac].faca031,g_faca2_d[l_ac].faca032,g_faca2_d[l_ac].faca033,g_faca2_d[l_ac].faca034, 
                   g_faca2_d[l_ac].faca052,g_faca2_d[l_ac].faca053,g_faca2_d[l_ac].faca054,g_faca2_d[l_ac].faca065, 
                   g_faca2_d[l_ac].faca055,g_faca2_d[l_ac].faca056,g_faca2_d[l_ac].faca057,g_faca2_d[l_ac].faca058, 
                   g_faca2_d[l_ac].faca059,g_faca2_d[l_ac].faca060,g_faca2_d[l_ac].faca061,g_faca2_d[l_ac].faca062, 
                   g_faca2_d[l_ac].faca063,g_faca2_d[l_ac].faca064,g_faca5_d[l_ac].faca043,g_faca5_d[l_ac].faca038, 
                   g_faca5_d[l_ac].faca039,g_faca5_d[l_ac].faca040,g_faca5_d[l_ac].faca041,g_faca5_d[l_ac].faca042, 
                   g_faca5_d[l_ac].faca044,g_faca5_d[l_ac].faca050,g_faca5_d[l_ac].faca045,g_faca5_d[l_ac].faca046, 
                   g_faca5_d[l_ac].faca047,g_faca5_d[l_ac].faca048,g_faca5_d[l_ac].faca049,g_faca5_d[l_ac].faca051)  
                   #自訂欄位頁簽
                WHERE facaent = g_enterprise AND facald = g_fabg_m.fabgld
                  AND facadocno = g_fabg_m.fabgdocno
                  AND facaseq = g_faca2_d_t.facaseq #項次 
                  
               #add-point:單身page2修改中 name="input.body2.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_faca2_d[l_ac].* = g_faca2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "faca_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_faca2_d[l_ac].* = g_faca2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "faca_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fabg_m.fabgld
               LET gs_keys_bak[1] = g_fabgld_t
               LET gs_keys[2] = g_fabg_m.fabgdocno
               LET gs_keys_bak[2] = g_fabgdocno_t
               LET gs_keys[3] = g_faca2_d[g_detail_idx].facaseq
               LET gs_keys_bak[3] = g_faca2_d_t.facaseq
               CALL afat510_update_b('faca_t',gs_keys,gs_keys_bak,"'2'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL afat510_faca_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_faca2_d[g_detail_idx].facaseq = g_faca2_d_t.facaseq 
                  ) THEN
                  LET gs_keys[01] = g_fabg_m.fabgld
                  LET gs_keys[gs_keys.getLength()+1] = g_fabg_m.fabgdocno
                  LET gs_keys[gs_keys.getLength()+1] = g_faca2_d_t.facaseq
                  CALL afat510_key_update_b(gs_keys,'faca_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_fabg_m),util.JSON.stringify(g_faca2_d_t)
               LET g_log2 = util.JSON.stringify(g_fabg_m),util.JSON.stringify(g_faca2_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page2修改後 name="input.body2.a_update"
               
               #end add-point
            END IF
         
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca019
            
            #add-point:AFTER FIELD faca019 name="input.a.page2.faca019"
            IF NOT cl_null(g_faca2_d[l_ac].faca019) THEN 
               # 开窗模糊查询                 
               IF s_aglt310_getlike_lc_subject(g_fabg_m.fabgld,g_faca2_d[l_ac].faca019,"")  THEN            
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
                  LET g_qryparam.reqry = 'FALSE'
                  LET g_qryparam.default1 = g_faca2_d[l_ac].faca019
                                
                  LET g_qryparam.arg1 = g_glaa.glaa004
                  LET g_qryparam.arg2 = g_faca2_d[l_ac].faca019
                  LET g_qryparam.arg3 = g_fabg_m.fabgld
                  LET g_qryparam.arg4 = " 1"
                  CALL q_glac002_6()
                  LET g_faca2_d[l_ac].faca019 = g_qryparam.return1              
                  CALL afat510_faca019_desc(g_faca2_d[l_ac].faca019) RETURNING g_faca2_d[l_ac].faca019_desc
                  DISPLAY g_faca2_d[l_ac].faca019_desc TO faca019_desc                
               END IF
               #科目存在性，有效性，非统治科目，非子系统科目，账户科目属性检查
               IF NOT  s_aglt310_lc_subject(g_fabg_m.fabgld,g_faca2_d[l_ac].faca019,'N') THEN
                  LET g_faca2_d[l_ac].faca019 = g_faca2_d_t.faca019
                  LET g_faca2_d[l_ac].faca019_desc = g_faca2_d_t.faca019_desc
                  NEXT FIELD CURRENT
               ELSE
                  SELECT glad017,glad0171,glad0172,glad018,glad0181,glad0182,
                         glad019,glad0191,glad0192,glad020,glad0201,glad0202,
                         glad021,glad0211,glad0212,glad022,glad0221,glad0222,
                         glad023,glad0231,glad0232,glad024,glad0221,glad0242,
                         glad025,glad0251,glad0252,glad026,glad0261,glad0262
                   INTO  g_glad017,g_glad0171,g_glad0172,g_glad018,g_glad0181,g_glad0182,
                         g_glad019,g_glad0191,g_glad0192,g_glad020,g_glad0201,g_glad0202,
                         g_glad021,g_glad0211,g_glad0212,g_glad022,g_glad0221,g_glad0222,
                         g_glad023,g_glad0231,g_glad0232,g_glad024,g_glad0241,g_glad0242,
                         g_glad025,g_glad0251,g_glad0252,g_glad026,g_glad0261,g_glad0262
                   FROM  glad_t
                   WHERE gladent = g_enterprise
                     AND gladld = g_fabg_m.fabgld
                     AND glad001 = g_faca2_d[l_ac].faca019
               END IF
            END IF    
            CALL afat510_faca019_desc(g_faca2_d[l_ac].faca019) RETURNING g_faca2_d[l_ac].faca019_desc
            DISPLAY g_faca2_d[l_ac].faca019_desc TO faca019_desc   
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca019
            #add-point:BEFORE FIELD faca019 name="input.b.page2.faca019"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faca019
            #add-point:ON CHANGE faca019 name="input.g.page2.faca019"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca036
            #add-point:BEFORE FIELD faca036 name="input.b.page2.faca036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca036
            
            #add-point:AFTER FIELD faca036 name="input.a.page2.faca036"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faca036
            #add-point:ON CHANGE faca036 name="input.g.page2.faca036"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca025
            #add-point:BEFORE FIELD faca025 name="input.b.page2.faca025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca025
            
            #add-point:AFTER FIELD faca025 name="input.a.page2.faca025"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faca025
            #add-point:ON CHANGE faca025 name="input.g.page2.faca025"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca025_desc
            #add-point:BEFORE FIELD faca025_desc name="input.b.page2.faca025_desc"
            LET g_faca2_d[l_ac].faca025_desc = g_faca2_d[l_ac].faca025
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca025_desc
            
            #add-point:AFTER FIELD faca025_desc name="input.a.page2.faca025_desc"
            LET g_faca2_d[l_ac].faca025 = g_faca2_d[l_ac].faca025_desc
            CALL s_desc_get_department_desc(g_faca2_d[l_ac].faca025) RETURNING g_faca2_d[l_ac].faca025_desc
            LET g_faca2_d[l_ac].faca025_desc = g_faca2_d[l_ac].faca025 CLIPPED,g_faca2_d[l_ac].faca025_desc
            IF NOT cl_null(g_faca2_d[l_ac].faca025) THEN 
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_faca2_d[l_ac].faca025
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi100|",cl_get_progname("aooi100",g_lang,"2"),"|:EXEPROGaooi100"
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooef001_13") THEN           #161024-00008#1           
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               
               ELSE
                  #檢查失敗時後續處理
                  LET g_faca2_d[l_ac].faca025 = g_faca2_d_t.faca025
                  LET g_faca2_d[l_ac].faca025_desc = g_faca2_d_t.faca025_desc
                  NEXT FIELD CURRENT
               END IF
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faca025_desc
            #add-point:ON CHANGE faca025_desc name="input.g.page2.faca025_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca026
            #add-point:BEFORE FIELD faca026 name="input.b.page2.faca026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca026
            
            #add-point:AFTER FIELD faca026 name="input.a.page2.faca026"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faca026
            #add-point:ON CHANGE faca026 name="input.g.page2.faca026"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca026_desc
            #add-point:BEFORE FIELD faca026_desc name="input.b.page2.faca026_desc"
            LET g_faca2_d[l_ac].faca026_desc = g_faca2_d[l_ac].faca026
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca026_desc
            
            #add-point:AFTER FIELD faca026_desc name="input.a.page2.faca026_desc"
            LET g_faca2_d[l_ac].faca026 = g_faca2_d[l_ac].faca026_desc
            CALL s_desc_get_department_desc(g_faca2_d[l_ac].faca026) RETURNING g_faca2_d[l_ac].faca026_desc
            LET g_faca2_d[l_ac].faca026_desc = g_faca2_d[l_ac].faca026 CLIPPED,g_faca2_d[l_ac].faca026_desc
            IF NOT cl_null(g_faca2_d[l_ac].faca026) THEN 
               CALL s_department_chk(g_faca2_d[l_ac].faca026,g_fabg_m.fabgdocdt) RETURNING l_success
               
               IF l_success = FALSE THEN 
                  LET g_faca2_d[l_ac].faca026 = g_faca2_d_t.faca026
                  LET g_faca2_d[l_ac].faca026_desc = g_faca2_d_t.faca026_desc
                  NEXT FIELD CURRENT
               END IF
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faca026_desc
            #add-point:ON CHANGE faca026_desc name="input.g.page2.faca026_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca027
            #add-point:BEFORE FIELD faca027 name="input.b.page2.faca027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca027
            
            #add-point:AFTER FIELD faca027 name="input.a.page2.faca027"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faca027
            #add-point:ON CHANGE faca027 name="input.g.page2.faca027"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca027_desc
            #add-point:BEFORE FIELD faca027_desc name="input.b.page2.faca027_desc"
            LET g_faca2_d[l_ac].faca027_desc = g_faca2_d[l_ac].faca027
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca027_desc
            
            #add-point:AFTER FIELD faca027_desc name="input.a.page2.faca027_desc"
            LET g_faca2_d[l_ac].faca027 = g_faca2_d[l_ac].faca027_desc
            CALL s_desc_get_department_desc(g_faca2_d[l_ac].faca027) RETURNING g_faca2_d[l_ac].faca027_desc
            LET g_faca2_d[l_ac].faca027_desc = g_faca2_d[l_ac].faca027 CLIPPED,g_faca2_d[l_ac].faca027_desc
            IF NOT cl_null(g_faca2_d[l_ac].faca027) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL    
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faca2_d[l_ac].faca027
               LET g_chkparam.arg2 = g_fabg_m.fabgdocdt 
               LET g_errshow = TRUE   
               LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"    
               LET g_chkparam.err_str[2] = "aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"               
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooeg001_6") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_faca2_d[l_ac].faca027 = g_faca2_d_t.faca027
                  LET g_faca2_d[l_ac].faca027_desc = g_faca2_d_t.faca027_desc
                  NEXT FIELD CURRENT
               END IF
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faca027_desc
            #add-point:ON CHANGE faca027_desc name="input.g.page2.faca027_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca028
            #add-point:BEFORE FIELD faca028 name="input.b.page2.faca028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca028
            
            #add-point:AFTER FIELD faca028 name="input.a.page2.faca028"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faca028
            #add-point:ON CHANGE faca028 name="input.g.page2.faca028"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca028_desc
            #add-point:BEFORE FIELD faca028_desc name="input.b.page2.faca028_desc"
            LET g_faca2_d[l_ac].faca028_desc = g_faca2_d[l_ac].faca028
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca028_desc
            
            #add-point:AFTER FIELD faca028_desc name="input.a.page2.faca028_desc"
            LET g_faca2_d[l_ac].faca028 = g_faca2_d[l_ac].faca028_desc
            CALL s_desc_get_acc_desc('287',g_faca2_d[l_ac].faca028) RETURNING g_faca2_d[l_ac].faca028_desc
            LET g_faca2_d[l_ac].faca028_desc = g_faca2_d[l_ac].faca028 CLIPPED,g_faca2_d[l_ac].faca028_desc
            IF NOT cl_null(g_faca2_d[l_ac].faca028) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL    
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faca2_d[l_ac].faca028
               LET g_errshow = TRUE  
               LET g_chkparam.err_str[1] = "axm-00004:sub-01302|axmi027|",cl_get_progname("axmi027",g_lang,"2"),"|:EXEPROGaxmi027"    
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_oocq002_287") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_faca2_d[l_ac].faca028 = g_faca2_d_t.faca028
                  LET g_faca2_d[l_ac].faca028_desc = g_faca2_d_t.faca028_desc
                  NEXT FIELD CURRENT
               END IF
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faca028_desc
            #add-point:ON CHANGE faca028_desc name="input.g.page2.faca028_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca029
            #add-point:BEFORE FIELD faca029 name="input.b.page2.faca029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca029
            
            #add-point:AFTER FIELD faca029 name="input.a.page2.faca029"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faca029
            #add-point:ON CHANGE faca029 name="input.g.page2.faca029"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca029_desc
            #add-point:BEFORE FIELD faca029_desc name="input.b.page2.faca029_desc"
            LET g_faca2_d[l_ac].faca029_desc = g_faca2_d[l_ac].faca029
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca029_desc
            
            #add-point:AFTER FIELD faca029_desc name="input.a.page2.faca029_desc"
            LET g_faca2_d[l_ac].faca029 = g_faca2_d[l_ac].faca029_desc
            CALL s_desc_get_trading_partner_abbr_desc(g_faca2_d[l_ac].faca029) RETURNING g_faca2_d[l_ac].faca029_desc
            LET g_faca2_d[l_ac].faca029_desc = g_faca2_d[l_ac].faca029 CLIPPED,g_faca2_d[l_ac].faca029_desc
            IF NOT cl_null(g_faca2_d[l_ac].faca029) THEN
               CALL s_voucher_glaq021_chk(g_faca2_d[l_ac].faca029)
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = g_errno
                  LET g_errparam.replace[1] = 'apmm100'
                  LET g_errparam.replace[2] = cl_get_progname('apmm100',g_lang,"2")
                  LET g_errparam.exeprog = 'apmm100'
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  
                  LET g_faca2_d[l_ac].faca029 = g_faca2_d_t.faca029
                  LET g_faca2_d[l_ac].faca029_desc = g_faca2_d_t.faca029_desc
                  NEXT FIELD CURRENT
               END IF            
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faca029_desc
            #add-point:ON CHANGE faca029_desc name="input.g.page2.faca029_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca030
            #add-point:BEFORE FIELD faca030 name="input.b.page2.faca030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca030
            
            #add-point:AFTER FIELD faca030 name="input.a.page2.faca030"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faca030
            #add-point:ON CHANGE faca030 name="input.g.page2.faca030"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca030_desc
            #add-point:BEFORE FIELD faca030_desc name="input.b.page2.faca030_desc"
            LET g_faca2_d[l_ac].faca030_desc = g_faca2_d[l_ac].faca030
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca030_desc
            
            #add-point:AFTER FIELD faca030_desc name="input.a.page2.faca030_desc"
            LET g_faca2_d[l_ac].faca030 = g_faca2_d[l_ac].faca030_desc
            CALL s_desc_get_trading_partner_abbr_desc(g_faca2_d[l_ac].faca030) RETURNING g_faca2_d[l_ac].faca030_desc
            LET g_faca2_d[l_ac].faca030_desc = g_faca2_d[l_ac].faca030 CLIPPED,g_faca2_d[l_ac].faca030_desc
            IF NOT cl_null(g_faca2_d[l_ac].faca030) THEN
               CALL s_voucher_glaq021_chk(g_faca2_d[l_ac].faca030)
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = g_errno
                  LET g_errparam.replace[1] = 'apmm100'
                  LET g_errparam.replace[2] = cl_get_progname('apmm100',g_lang,"2")
                  LET g_errparam.exeprog = 'apmm100'
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  
                  LET g_faca2_d[l_ac].faca030 = g_faca2_d_t.faca030
                  LET g_faca2_d[l_ac].faca030_desc = g_faca2_d_t.faca030_desc
                  NEXT FIELD CURRENT
               END IF            
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faca030_desc
            #add-point:ON CHANGE faca030_desc name="input.g.page2.faca030_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca031
            #add-point:BEFORE FIELD faca031 name="input.b.page2.faca031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca031
            
            #add-point:AFTER FIELD faca031 name="input.a.page2.faca031"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faca031
            #add-point:ON CHANGE faca031 name="input.g.page2.faca031"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca031_desc
            #add-point:BEFORE FIELD faca031_desc name="input.b.page2.faca031_desc"
            LET g_faca2_d[l_ac].faca031_desc = g_faca2_d[l_ac].faca031
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca031_desc
            
            #add-point:AFTER FIELD faca031_desc name="input.a.page2.faca031_desc"
            LET g_faca2_d[l_ac].faca031 = g_faca2_d[l_ac].faca031_desc
            CALL s_desc_get_acc_desc('281',g_faca2_d[l_ac].faca031) RETURNING g_faca2_d[l_ac].faca031_desc
            LET g_faca2_d[l_ac].faca031_desc = g_faca2_d[l_ac].faca031 CLIPPED,g_faca2_d[l_ac].faca031_desc
            IF NOT cl_null(g_faca2_d[l_ac].faca031) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL    
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faca2_d[l_ac].faca031
               LET g_errshow = TRUE  
               LET g_chkparam.err_str[1] = "axm-00004:sub-01302|axmi027|",cl_get_progname("axmi027",g_lang,"2"),"|:EXEPROGaxmi027"    
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_oocq002_281") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_faca2_d[l_ac].faca031 = g_faca2_d_t.faca031
                  LET g_faca2_d[l_ac].faca031_desc = g_faca2_d_t.faca031_desc
                  NEXT FIELD CURRENT
               END IF
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faca031_desc
            #add-point:ON CHANGE faca031_desc name="input.g.page2.faca031_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca032
            #add-point:BEFORE FIELD faca032 name="input.b.page2.faca032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca032
            
            #add-point:AFTER FIELD faca032 name="input.a.page2.faca032"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faca032
            #add-point:ON CHANGE faca032 name="input.g.page2.faca032"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca032_desc
            #add-point:BEFORE FIELD faca032_desc name="input.b.page2.faca032_desc"
            LET g_faca2_d[l_ac].faca032_desc = g_faca2_d[l_ac].faca032
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca032_desc
            
            #add-point:AFTER FIELD faca032_desc name="input.a.page2.faca032_desc"
            LET g_faca2_d[l_ac].faca032 = g_faca2_d[l_ac].faca032_desc
            CALL s_desc_get_person_desc(g_faca2_d[l_ac].faca032) RETURNING g_faca2_d[l_ac].faca032_desc
            LET g_faca2_d[l_ac].faca032_desc = g_faca2_d[l_ac].faca032 CLIPPED,g_faca2_d[l_ac].faca032_desc
            IF NOT cl_null(g_faca2_d[l_ac].faca032) THEN 
               CALL s_employee_chk(g_faca2_d[l_ac].faca032) RETURNING l_success
               
               IF l_success = FALSE THEN 
                  LET g_faca2_d[l_ac].faca032 = g_faca2_d_t.faca032
                  LET g_faca2_d[l_ac].faca032_desc = g_faca2_d_t.faca032_desc
                  NEXT FIELD CURRENT
               END IF
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faca032_desc
            #add-point:ON CHANGE faca032_desc name="input.g.page2.faca032_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca033
            #add-point:BEFORE FIELD faca033 name="input.b.page2.faca033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca033
            
            #add-point:AFTER FIELD faca033 name="input.a.page2.faca033"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faca033
            #add-point:ON CHANGE faca033 name="input.g.page2.faca033"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca033_desc
            #add-point:BEFORE FIELD faca033_desc name="input.b.page2.faca033_desc"
            LET g_faca2_d[l_ac].faca033_desc = g_faca2_d[l_ac].faca033
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca033_desc
            
            #add-point:AFTER FIELD faca033_desc name="input.a.page2.faca033_desc"
            LET g_faca2_d[l_ac].faca033 = g_faca2_d[l_ac].faca033_desc
            CALL s_desc_get_project_desc(g_faca2_d[l_ac].faca033) RETURNING g_faca2_d[l_ac].faca033_desc
            LET g_faca2_d[l_ac].faca033_desc = g_faca2_d[l_ac].faca033 CLIPPED,g_faca2_d[l_ac].faca033_desc
            IF NOT cl_null(g_faca2_d[l_ac].faca033) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL    
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faca2_d[l_ac].faca033
               LET g_errshow = TRUE   
               LET g_chkparam.err_str[1] = "apj-00012:sub-01302|apjm200|",cl_get_progname("apjm200",g_lang,"2"),"|:EXEPROGapjm200"     
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_pjba001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_faca2_d[l_ac].faca033 = g_faca2_d_t.faca033
                  LET g_faca2_d[l_ac].faca033_desc = g_faca2_d_t.faca033_desc
                  NEXT FIELD CURRENT
               END IF
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faca033_desc
            #add-point:ON CHANGE faca033_desc name="input.g.page2.faca033_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca034
            #add-point:BEFORE FIELD faca034 name="input.b.page2.faca034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca034
            
            #add-point:AFTER FIELD faca034 name="input.a.page2.faca034"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faca034
            #add-point:ON CHANGE faca034 name="input.g.page2.faca034"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca034_desc
            #add-point:BEFORE FIELD faca034_desc name="input.b.page2.faca034_desc"
            LET g_faca2_d[l_ac].faca034_desc = g_faca2_d[l_ac].faca034
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca034_desc
            
            #add-point:AFTER FIELD faca034_desc name="input.a.page2.faca034_desc"
            LET g_faca2_d[l_ac].faca034 = g_faca2_d[l_ac].faca034_desc
            CALL s_desc_get_pjbbl004_desc(g_faca2_d[l_ac].faca033,g_faca2_d[l_ac].faca034) RETURNING g_faca2_d[l_ac].faca034_desc
            LET g_faca2_d[l_ac].faca034_desc = g_faca2_d[l_ac].faca034 CLIPPED,g_faca2_d[l_ac].faca034_desc 
            IF NOT cl_null(g_faca2_d[l_ac].faca034) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL    
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faca2_d[l_ac].faca033
               LET g_chkparam.arg2 = g_faca2_d[l_ac].faca034
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_pjbb002") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_faca2_d[l_ac].faca034 = g_faca2_d_t.faca034
                  LET g_faca2_d[l_ac].faca034_desc = g_faca2_d_t.faca034_desc
                  NEXT FIELD CURRENT
               END IF
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faca034_desc
            #add-point:ON CHANGE faca034_desc name="input.g.page2.faca034_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca052
            #add-point:BEFORE FIELD faca052 name="input.b.page2.faca052"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca052
            
            #add-point:AFTER FIELD faca052 name="input.a.page2.faca052"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faca052
            #add-point:ON CHANGE faca052 name="input.g.page2.faca052"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca053
            #add-point:BEFORE FIELD faca053 name="input.b.page2.faca053"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca053
            
            #add-point:AFTER FIELD faca053 name="input.a.page2.faca053"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faca053
            #add-point:ON CHANGE faca053 name="input.g.page2.faca053"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca053_desc
            #add-point:BEFORE FIELD faca053_desc name="input.b.page2.faca053_desc"
            LET g_faca2_d[l_ac].faca053_desc = g_faca2_d[l_ac].faca053
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca053_desc
            
            #add-point:AFTER FIELD faca053_desc name="input.a.page2.faca053_desc"
            LET g_faca2_d[l_ac].faca053 = g_faca2_d[l_ac].faca053_desc
            CALL s_desc_get_oojdl003_desc(g_faca2_d[l_ac].faca053) RETURNING g_faca2_d[l_ac].faca053_desc
            LET g_faca2_d[l_ac].faca053_desc = g_faca2_d[l_ac].faca053 CLIPPED,g_faca2_d[l_ac].faca053_desc 
            IF NOT cl_null(g_faca2_d[l_ac].faca053) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL    
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faca2_d[l_ac].faca053
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_oojd001_1") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_faca2_d[l_ac].faca053 = g_faca2_d_t.faca053
                  LET g_faca2_d[l_ac].faca053_desc = g_faca2_d_t.faca053_desc
                  NEXT FIELD CURRENT
               END IF
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faca053_desc
            #add-point:ON CHANGE faca053_desc name="input.g.page2.faca053_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca054
            #add-point:BEFORE FIELD faca054 name="input.b.page2.faca054"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca054
            
            #add-point:AFTER FIELD faca054 name="input.a.page2.faca054"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faca054
            #add-point:ON CHANGE faca054 name="input.g.page2.faca054"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca054_desc
            #add-point:BEFORE FIELD faca054_desc name="input.b.page2.faca054_desc"
            LET g_faca2_d[l_ac].faca054_desc = g_faca2_d[l_ac].faca054
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca054_desc
            
            #add-point:AFTER FIELD faca054_desc name="input.a.page2.faca054_desc"
            LET g_faca2_d[l_ac].faca054 = g_faca2_d[l_ac].faca054_desc
            CALL s_desc_get_acc_desc('2002',g_faca2_d[l_ac].faca054) RETURNING g_faca2_d[l_ac].faca054_desc
            LET g_faca2_d[l_ac].faca054_desc = g_faca2_d[l_ac].faca054 CLIPPED,g_faca2_d[l_ac].faca054_desc
            IF NOT cl_null(g_faca2_d[l_ac].faca054) THEN 
               IF NOT s_azzi650_chk_exist('2002',g_faca2_d[l_ac].faca054) THEN
                  LET g_faca2_d[l_ac].faca054 = g_faca2_d_t.faca054
                  LET g_faca2_d[l_ac].faca054_desc = g_faca2_d_t.faca054_desc
                  NEXT FIELD CURRENT
               END IF
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faca054_desc
            #add-point:ON CHANGE faca054_desc name="input.g.page2.faca054_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca065
            #add-point:BEFORE FIELD faca065 name="input.b.page2.faca065"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca065
            
            #add-point:AFTER FIELD faca065 name="input.a.page2.faca065"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faca065
            #add-point:ON CHANGE faca065 name="input.g.page2.faca065"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca065_desc
            #add-point:BEFORE FIELD faca065_desc name="input.b.page2.faca065_desc"
            LET g_faca2_d[l_ac].faca065_desc = g_faca2_d[l_ac].faca065
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca065_desc
            
            #add-point:AFTER FIELD faca065_desc name="input.a.page2.faca065_desc"
            LET g_faca2_d[l_ac].faca065 = g_faca2_d[l_ac].faca065_desc
            CALL s_desc_get_rtaxl003_desc(g_faca2_d[l_ac].faca065) RETURNING g_faca2_d[l_ac].faca065_desc
            LET g_faca2_d[l_ac].faca065_desc = g_faca2_d[l_ac].faca065 CLIPPED,g_faca2_d[l_ac].faca065_desc 
            IF NOT cl_null(g_faca2_d[l_ac].faca065) THEN 
               CALL s_voucher_glaq024_chk(g_faca2_d[l_ac].faca065) 
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_faca2_d[l_ac].faca065
                  LET g_errparam.replace[1] = 'arti202'
                  LET g_errparam.replace[2] = cl_get_progname('arti202',g_lang,"2")
                  LET g_errparam.exeprog = 'arti202'
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_faca2_d[l_ac].faca065 = g_faca2_d_t.faca065
                  LET g_faca2_d[l_ac].faca065_desc = g_faca2_d_t.faca065_desc
                  NEXT FIELD CURRENT
               END IF 
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faca065_desc
            #add-point:ON CHANGE faca065_desc name="input.g.page2.faca065_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca055
            #add-point:BEFORE FIELD faca055 name="input.b.page2.faca055"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca055
            
            #add-point:AFTER FIELD faca055 name="input.a.page2.faca055"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faca055
            #add-point:ON CHANGE faca055 name="input.g.page2.faca055"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca055_desc
            #add-point:BEFORE FIELD faca055_desc name="input.b.page2.faca055_desc"
            CALL s_fin_get_glae009(g_glad0171) RETURNING g_glae009
            LET g_faca2_d[l_ac].faca055_desc = g_faca2_d[l_ac].faca055
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca055_desc
            
            #add-point:AFTER FIELD faca055_desc name="input.a.page2.faca055_desc"
            LET g_faca2_d[l_ac].faca055 = g_faca2_d[l_ac].faca055_desc
            CALL s_fin_get_accting_desc(g_glad0171,g_faca2_d[l_ac].faca055) RETURNING g_faca2_d[l_ac].faca055_desc
            LET g_faca2_d[l_ac].faca055_desc = g_faca2_d[l_ac].faca055 CLIPPED,g_faca2_d[l_ac].faca055_desc 
            IF NOT cl_null(g_faca2_d[l_ac].faca055) THEN 
               CALL s_voucher_free_account_chk(g_glad0171,g_faca2_d[l_ac].faca055,g_glad0172) RETURNING g_errno
               IF NOT cl_null(g_errno) THEN
                  LET g_faca2_d[l_ac].faca055 = g_faca2_d_t.faca055
                  LET g_faca2_d[l_ac].faca055_desc = g_faca2_d_t.faca055_desc
                  NEXT FIELD CURRENT
               END IF
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faca055_desc
            #add-point:ON CHANGE faca055_desc name="input.g.page2.faca055_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca056
            #add-point:BEFORE FIELD faca056 name="input.b.page2.faca056"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca056
            
            #add-point:AFTER FIELD faca056 name="input.a.page2.faca056"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faca056
            #add-point:ON CHANGE faca056 name="input.g.page2.faca056"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca056_desc
            #add-point:BEFORE FIELD faca056_desc name="input.b.page2.faca056_desc"
            CALL s_fin_get_glae009(g_glad0181) RETURNING g_glae009
            LET g_faca2_d[l_ac].faca056_desc = g_faca2_d[l_ac].faca056
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca056_desc
            
            #add-point:AFTER FIELD faca056_desc name="input.a.page2.faca056_desc"
            LET g_faca2_d[l_ac].faca056 = g_faca2_d[l_ac].faca056_desc
            CALL s_fin_get_accting_desc(g_glad0181,g_faca2_d[l_ac].faca056) RETURNING g_faca2_d[l_ac].faca056_desc
            LET g_faca2_d[l_ac].faca056_desc = g_faca2_d[l_ac].faca056 CLIPPED,g_faca2_d[l_ac].faca056_desc 
            IF NOT cl_null(g_faca2_d[l_ac].faca056) THEN 
               CALL s_voucher_free_account_chk(g_glad0181,g_faca2_d[l_ac].faca056,g_glad0182) RETURNING g_errno
               IF NOT cl_null(g_errno) THEN
                  LET g_faca2_d[l_ac].faca056 = g_faca2_d_t.faca056
                  LET g_faca2_d[l_ac].faca056_desc = g_faca2_d_t.faca056_desc
                  NEXT FIELD CURRENT
               END IF
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faca056_desc
            #add-point:ON CHANGE faca056_desc name="input.g.page2.faca056_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca057
            #add-point:BEFORE FIELD faca057 name="input.b.page2.faca057"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca057
            
            #add-point:AFTER FIELD faca057 name="input.a.page2.faca057"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faca057
            #add-point:ON CHANGE faca057 name="input.g.page2.faca057"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca057_desc
            #add-point:BEFORE FIELD faca057_desc name="input.b.page2.faca057_desc"
            CALL s_fin_get_glae009(g_glad0191) RETURNING g_glae009
            LET g_faca2_d[l_ac].faca057_desc = g_faca2_d[l_ac].faca057
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca057_desc
            
            #add-point:AFTER FIELD faca057_desc name="input.a.page2.faca057_desc"
            LET g_faca2_d[l_ac].faca057 = g_faca2_d[l_ac].faca057_desc
            CALL s_fin_get_accting_desc(g_glad0191,g_faca2_d[l_ac].faca057) RETURNING g_faca2_d[l_ac].faca057_desc
            LET g_faca2_d[l_ac].faca057_desc = g_faca2_d[l_ac].faca057 CLIPPED,g_faca2_d[l_ac].faca057_desc 
            IF NOT cl_null(g_faca2_d[l_ac].faca057) THEN 
               CALL s_voucher_free_account_chk(g_glad0191,g_faca2_d[l_ac].faca057,g_glad0192) RETURNING g_errno
               IF NOT cl_null(g_errno) THEN
                  LET g_faca2_d[l_ac].faca057 = g_faca2_d_t.faca057
                  LET g_faca2_d[l_ac].faca057_desc = g_faca2_d_t.faca057_desc
                  NEXT FIELD CURRENT
               END IF
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faca057_desc
            #add-point:ON CHANGE faca057_desc name="input.g.page2.faca057_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca058
            #add-point:BEFORE FIELD faca058 name="input.b.page2.faca058"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca058
            
            #add-point:AFTER FIELD faca058 name="input.a.page2.faca058"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faca058
            #add-point:ON CHANGE faca058 name="input.g.page2.faca058"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca058_desc
            #add-point:BEFORE FIELD faca058_desc name="input.b.page2.faca058_desc"
            CALL s_fin_get_glae009(g_glad0201) RETURNING g_glae009
            LET g_faca2_d[l_ac].faca058_desc = g_faca2_d[l_ac].faca058
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca058_desc
            
            #add-point:AFTER FIELD faca058_desc name="input.a.page2.faca058_desc"
            LET g_faca2_d[l_ac].faca058 = g_faca2_d[l_ac].faca058_desc
            CALL s_fin_get_accting_desc(g_glad0201,g_faca2_d[l_ac].faca058) RETURNING g_faca2_d[l_ac].faca058_desc
            LET g_faca2_d[l_ac].faca058_desc = g_faca2_d[l_ac].faca058 CLIPPED,g_faca2_d[l_ac].faca058_desc 
            IF NOT cl_null(g_faca2_d[l_ac].faca058) THEN 
               CALL s_voucher_free_account_chk(g_glad0201,g_faca2_d[l_ac].faca058,g_glad0202) RETURNING g_errno
               IF NOT cl_null(g_errno) THEN
                  LET g_faca2_d[l_ac].faca058 = g_faca2_d_t.faca058
                  LET g_faca2_d[l_ac].faca058_desc = g_faca2_d_t.faca058_desc
                  NEXT FIELD CURRENT
               END IF
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faca058_desc
            #add-point:ON CHANGE faca058_desc name="input.g.page2.faca058_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca059
            #add-point:BEFORE FIELD faca059 name="input.b.page2.faca059"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca059
            
            #add-point:AFTER FIELD faca059 name="input.a.page2.faca059"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faca059
            #add-point:ON CHANGE faca059 name="input.g.page2.faca059"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca059_desc
            #add-point:BEFORE FIELD faca059_desc name="input.b.page2.faca059_desc"
            CALL s_fin_get_glae009(g_glad0211) RETURNING g_glae009
            LET g_faca2_d[l_ac].faca059_desc = g_faca2_d[l_ac].faca059
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca059_desc
            
            #add-point:AFTER FIELD faca059_desc name="input.a.page2.faca059_desc"
            LET g_faca2_d[l_ac].faca059 = g_faca2_d[l_ac].faca059_desc
            CALL s_fin_get_accting_desc(g_glad0211,g_faca2_d[l_ac].faca059) RETURNING g_faca2_d[l_ac].faca059_desc
            LET g_faca2_d[l_ac].faca059_desc = g_faca2_d[l_ac].faca059 CLIPPED,g_faca2_d[l_ac].faca059_desc 
            IF NOT cl_null(g_faca2_d[l_ac].faca059) THEN 
               CALL s_voucher_free_account_chk(g_glad0211,g_faca2_d[l_ac].faca059,g_glad0212) RETURNING g_errno
               IF NOT cl_null(g_errno) THEN
                  LET g_faca2_d[l_ac].faca059 = g_faca2_d_t.faca059
                  LET g_faca2_d[l_ac].faca059_desc = g_faca2_d_t.faca059_desc
                  NEXT FIELD CURRENT
               END IF
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faca059_desc
            #add-point:ON CHANGE faca059_desc name="input.g.page2.faca059_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca060
            #add-point:BEFORE FIELD faca060 name="input.b.page2.faca060"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca060
            
            #add-point:AFTER FIELD faca060 name="input.a.page2.faca060"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faca060
            #add-point:ON CHANGE faca060 name="input.g.page2.faca060"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca060_desc
            #add-point:BEFORE FIELD faca060_desc name="input.b.page2.faca060_desc"
            CALL s_fin_get_glae009(g_glad0221) RETURNING g_glae009
            LET g_faca2_d[l_ac].faca060_desc = g_faca2_d[l_ac].faca060
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca060_desc
            
            #add-point:AFTER FIELD faca060_desc name="input.a.page2.faca060_desc"
            LET g_faca2_d[l_ac].faca060 = g_faca2_d[l_ac].faca060_desc
            CALL s_fin_get_accting_desc(g_glad0221,g_faca2_d[l_ac].faca060) RETURNING g_faca2_d[l_ac].faca060_desc
            LET g_faca2_d[l_ac].faca060_desc = g_faca2_d[l_ac].faca060 CLIPPED,g_faca2_d[l_ac].faca060_desc 
            IF NOT cl_null(g_faca2_d[l_ac].faca060) THEN 
               CALL s_voucher_free_account_chk(g_glad0221,g_faca2_d[l_ac].faca060,g_glad0222) RETURNING g_errno
               IF NOT cl_null(g_errno) THEN
                  LET g_faca2_d[l_ac].faca060 = g_faca2_d_t.faca060
                  LET g_faca2_d[l_ac].faca060_desc = g_faca2_d_t.faca060_desc
                  NEXT FIELD CURRENT
               END IF
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faca060_desc
            #add-point:ON CHANGE faca060_desc name="input.g.page2.faca060_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca061
            #add-point:BEFORE FIELD faca061 name="input.b.page2.faca061"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca061
            
            #add-point:AFTER FIELD faca061 name="input.a.page2.faca061"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faca061
            #add-point:ON CHANGE faca061 name="input.g.page2.faca061"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca061_desc
            #add-point:BEFORE FIELD faca061_desc name="input.b.page2.faca061_desc"
            CALL s_fin_get_glae009(g_glad0231) RETURNING g_glae009
            LET g_faca2_d[l_ac].faca061_desc = g_faca2_d[l_ac].faca061
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca061_desc
            
            #add-point:AFTER FIELD faca061_desc name="input.a.page2.faca061_desc"
            LET g_faca2_d[l_ac].faca061 = g_faca2_d[l_ac].faca061_desc
            CALL s_fin_get_accting_desc(g_glad0231,g_faca2_d[l_ac].faca061) RETURNING g_faca2_d[l_ac].faca061_desc
            LET g_faca2_d[l_ac].faca061_desc = g_faca2_d[l_ac].faca061 CLIPPED,g_faca2_d[l_ac].faca061_desc 
            IF NOT cl_null(g_faca2_d[l_ac].faca061) THEN 
               CALL s_voucher_free_account_chk(g_glad0231,g_faca2_d[l_ac].faca061,g_glad0232) RETURNING g_errno
               IF NOT cl_null(g_errno) THEN
                  LET g_faca2_d[l_ac].faca061 = g_faca2_d_t.faca061
                  LET g_faca2_d[l_ac].faca061_desc = g_faca2_d_t.faca061_desc
                  NEXT FIELD CURRENT
               END IF
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faca061_desc
            #add-point:ON CHANGE faca061_desc name="input.g.page2.faca061_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca062
            #add-point:BEFORE FIELD faca062 name="input.b.page2.faca062"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca062
            
            #add-point:AFTER FIELD faca062 name="input.a.page2.faca062"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faca062
            #add-point:ON CHANGE faca062 name="input.g.page2.faca062"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca062_desc
            #add-point:BEFORE FIELD faca062_desc name="input.b.page2.faca062_desc"
            CALL s_fin_get_glae009(g_glad0241) RETURNING g_glae009
            LET g_faca2_d[l_ac].faca062_desc = g_faca2_d[l_ac].faca062
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca062_desc
            
            #add-point:AFTER FIELD faca062_desc name="input.a.page2.faca062_desc"
            LET g_faca2_d[l_ac].faca062 = g_faca2_d[l_ac].faca062_desc
            CALL s_fin_get_accting_desc(g_glad0241,g_faca2_d[l_ac].faca062) RETURNING g_faca2_d[l_ac].faca062_desc
            LET g_faca2_d[l_ac].faca062_desc = g_faca2_d[l_ac].faca062 CLIPPED,g_faca2_d[l_ac].faca062_desc 
            IF NOT cl_null(g_faca2_d[l_ac].faca062) THEN 
               CALL s_voucher_free_account_chk(g_glad0241,g_faca2_d[l_ac].faca062,g_glad0242) RETURNING g_errno
               IF NOT cl_null(g_errno) THEN
                  LET g_faca2_d[l_ac].faca062 = g_faca2_d_t.faca062
                  LET g_faca2_d[l_ac].faca062_desc = g_faca2_d_t.faca062_desc
                  NEXT FIELD CURRENT
               END IF
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faca062_desc
            #add-point:ON CHANGE faca062_desc name="input.g.page2.faca062_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca063
            #add-point:BEFORE FIELD faca063 name="input.b.page2.faca063"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca063
            
            #add-point:AFTER FIELD faca063 name="input.a.page2.faca063"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faca063
            #add-point:ON CHANGE faca063 name="input.g.page2.faca063"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca063_desc
            #add-point:BEFORE FIELD faca063_desc name="input.b.page2.faca063_desc"
            CALL s_fin_get_glae009(g_glad0251) RETURNING g_glae009
            LET g_faca2_d[l_ac].faca063_desc = g_faca2_d[l_ac].faca063
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca063_desc
            
            #add-point:AFTER FIELD faca063_desc name="input.a.page2.faca063_desc"
            LET g_faca2_d[l_ac].faca063 = g_faca2_d[l_ac].faca063_desc
            CALL s_fin_get_accting_desc(g_glad0251,g_faca2_d[l_ac].faca063) RETURNING g_faca2_d[l_ac].faca063_desc
            LET g_faca2_d[l_ac].faca063_desc = g_faca2_d[l_ac].faca063 CLIPPED,g_faca2_d[l_ac].faca063_desc 
            IF NOT cl_null(g_faca2_d[l_ac].faca063) THEN 
               CALL s_voucher_free_account_chk(g_glad0251,g_faca2_d[l_ac].faca063,g_glad0252) RETURNING g_errno
               IF NOT cl_null(g_errno) THEN
                  LET g_faca2_d[l_ac].faca063 = g_faca2_d_t.faca063
                  LET g_faca2_d[l_ac].faca063_desc = g_faca2_d_t.faca063_desc
                  NEXT FIELD CURRENT
               END IF
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faca063_desc
            #add-point:ON CHANGE faca063_desc name="input.g.page2.faca063_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca064
            #add-point:BEFORE FIELD faca064 name="input.b.page2.faca064"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca064
            
            #add-point:AFTER FIELD faca064 name="input.a.page2.faca064"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faca064
            #add-point:ON CHANGE faca064 name="input.g.page2.faca064"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca064_desc
            #add-point:BEFORE FIELD faca064_desc name="input.b.page2.faca064_desc"
            CALL s_fin_get_glae009(g_glad0261) RETURNING g_glae009
            LET g_faca2_d[l_ac].faca064_desc = g_faca2_d[l_ac].faca064
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca064_desc
            
            #add-point:AFTER FIELD faca064_desc name="input.a.page2.faca064_desc"
            LET g_faca2_d[l_ac].faca064 = g_faca2_d[l_ac].faca064_desc
            CALL s_fin_get_accting_desc(g_glad0261,g_faca2_d[l_ac].faca064) RETURNING g_faca2_d[l_ac].faca064_desc
            LET g_faca2_d[l_ac].faca064_desc = g_faca2_d[l_ac].faca064 CLIPPED,g_faca2_d[l_ac].faca064_desc 
            IF NOT cl_null(g_faca2_d[l_ac].faca064) THEN 
               CALL s_voucher_free_account_chk(g_glad0261,g_faca2_d[l_ac].faca064,g_glad0262) RETURNING g_errno
               IF NOT cl_null(g_errno) THEN
                  LET g_faca2_d[l_ac].faca064 = g_faca2_d_t.faca064
                  LET g_faca2_d[l_ac].faca064_desc = g_faca2_d_t.faca064_desc
                  NEXT FIELD CURRENT
               END IF
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faca064_desc
            #add-point:ON CHANGE faca064_desc name="input.g.page2.faca064_desc"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page2.faca019
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca019
            #add-point:ON ACTION controlp INFIELD faca019 name="input.c.page2.faca019"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_faca2_d[l_ac].faca019             #給予default值
            LET g_qryparam.where = " glac001 = '",g_glaa.glaa004,"'",
                                   " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 AND gladld='",g_fabg_m.fabgld,"' AND gladent=",g_enterprise,
                                   " AND gladstus = 'Y' )" 
            
            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL aglt310_04()                                #呼叫開窗
 
            LET g_faca2_d[l_ac].faca019 = g_qryparam.return1              
            CALL afat510_faca019_desc(g_faca2_d[l_ac].faca019) RETURNING g_faca2_d[l_ac].faca019_desc
            DISPLAY g_faca2_d[l_ac].faca019_desc TO faca019_desc
            DISPLAY g_faca2_d[l_ac].faca019 TO faca019              #

            NEXT FIELD faca019                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page2.faca036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca036
            #add-point:ON ACTION controlp INFIELD faca036 name="input.c.page2.faca036"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.faca025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca025
            #add-point:ON ACTION controlp INFIELD faca025 name="input.c.page2.faca025"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.faca025_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca025_desc
            #add-point:ON ACTION controlp INFIELD faca025_desc name="input.c.page2.faca025_desc"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_faca2_d[l_ac].faca025             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_ooef001_1()                                #呼叫開窗
 
            LET g_faca2_d[l_ac].faca025 = g_qryparam.return1              
            CALL s_desc_get_department_desc(g_faca2_d[l_ac].faca025) RETURNING g_faca2_d[l_ac].faca025_desc
            LET g_faca2_d[l_ac].faca025_desc = g_faca2_d[l_ac].faca025 CLIPPED,g_faca2_d[l_ac].faca025_desc
            DISPLAY g_faca2_d[l_ac].faca025_desc TO faca025_desc              #

            NEXT FIELD faca025_desc                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page2.faca026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca026
            #add-point:ON ACTION controlp INFIELD faca026 name="input.c.page2.faca026"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.faca026_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca026_desc
            #add-point:ON ACTION controlp INFIELD faca026_desc name="input.c.page2.faca026_desc"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_faca2_d[l_ac].faca026             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_fabg_m.fabgdocdt

 
            CALL q_ooeg001_4()                                #呼叫開窗
 
            LET g_faca2_d[l_ac].faca026 = g_qryparam.return1              
            CALL s_desc_get_department_desc(g_faca2_d[l_ac].faca026) RETURNING g_faca2_d[l_ac].faca026_desc
            LET g_faca2_d[l_ac].faca026_desc = g_faca2_d[l_ac].faca026 CLIPPED,g_faca2_d[l_ac].faca026_desc
            DISPLAY g_faca2_d[l_ac].faca026_desc TO faca026_desc              #

            NEXT FIELD faca026_desc                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page2.faca027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca027
            #add-point:ON ACTION controlp INFIELD faca027 name="input.c.page2.faca027"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.faca027_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca027_desc
            #add-point:ON ACTION controlp INFIELD faca027_desc name="input.c.page2.faca027_desc"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_faca2_d[l_ac].faca027             #給予default值
            LET g_qryparam.where = " ooeg003 IN ('2','3')"
            #給予arg
            LET g_qryparam.arg1 = g_fabg_m.fabgdocdt

            CALL q_ooeg001_4()                                #呼叫開窗
 
            LET g_faca2_d[l_ac].faca027 = g_qryparam.return1              
            CALL s_desc_get_department_desc(g_faca2_d[l_ac].faca027) RETURNING g_faca2_d[l_ac].faca027_desc
            LET g_faca2_d[l_ac].faca027_desc = g_faca2_d[l_ac].faca027 CLIPPED,g_faca2_d[l_ac].faca027_desc
            DISPLAY g_faca2_d[l_ac].faca027_desc TO faca027_desc              #

            NEXT FIELD faca027_desc                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page2.faca028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca028
            #add-point:ON ACTION controlp INFIELD faca028 name="input.c.page2.faca028"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.faca028_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca028_desc
            #add-point:ON ACTION controlp INFIELD faca028_desc name="input.c.page2.faca028_desc"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_faca2_d[l_ac].faca028             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_oocq002_287()                                #呼叫開窗
 
            LET g_faca2_d[l_ac].faca028 = g_qryparam.return1              
            CALL s_desc_get_acc_desc('287',g_faca2_d[l_ac].faca028) RETURNING g_faca2_d[l_ac].faca028_desc
            LET g_faca2_d[l_ac].faca028_desc = g_faca2_d[l_ac].faca028 CLIPPED,g_faca2_d[l_ac].faca028_desc
            DISPLAY g_faca2_d[l_ac].faca028_desc TO faca028_desc              #

            NEXT FIELD faca028_desc                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page2.faca029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca029
            #add-point:ON ACTION controlp INFIELD faca029 name="input.c.page2.faca029"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.faca029_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca029_desc
            #add-point:ON ACTION controlp INFIELD faca029_desc name="input.c.page2.faca029_desc"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_faca2_d[l_ac].faca029             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_pmaa001_25()                                #呼叫開窗
 
            LET g_faca2_d[l_ac].faca029 = g_qryparam.return1              
            CALL s_desc_get_trading_partner_abbr_desc(g_faca2_d[l_ac].faca029) RETURNING g_faca2_d[l_ac].faca029_desc
            LET g_faca2_d[l_ac].faca029_desc = g_faca2_d[l_ac].faca029 CLIPPED,g_faca2_d[l_ac].faca029_desc
            DISPLAY g_faca2_d[l_ac].faca029_desc TO faca029_desc              #

            NEXT FIELD faca029_desc                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page2.faca030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca030
            #add-point:ON ACTION controlp INFIELD faca030 name="input.c.page2.faca030"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.faca030_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca030_desc
            #add-point:ON ACTION controlp INFIELD faca030_desc name="input.c.page2.faca030_desc"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_faca2_d[l_ac].faca030             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_pmaa001_25()                                #呼叫開窗
 
            LET g_faca2_d[l_ac].faca030 = g_qryparam.return1              
            CALL s_desc_get_trading_partner_abbr_desc(g_faca2_d[l_ac].faca030) RETURNING g_faca2_d[l_ac].faca030_desc
            LET g_faca2_d[l_ac].faca030_desc = g_faca2_d[l_ac].faca030 CLIPPED,g_faca2_d[l_ac].faca030_desc
            DISPLAY g_faca2_d[l_ac].faca030_desc TO faca030_desc              #

            NEXT FIELD faca030_desc                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page2.faca031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca031
            #add-point:ON ACTION controlp INFIELD faca031 name="input.c.page2.faca031"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.faca031_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca031_desc
            #add-point:ON ACTION controlp INFIELD faca031_desc name="input.c.page2.faca031_desc"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_faca2_d[l_ac].faca031             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_oocq002_281()                                #呼叫開窗
 
            LET g_faca2_d[l_ac].faca031 = g_qryparam.return1              
            CALL s_desc_get_acc_desc('281',g_faca2_d[l_ac].faca031) RETURNING g_faca2_d[l_ac].faca031_desc
            LET g_faca2_d[l_ac].faca031_desc = g_faca2_d[l_ac].faca031 CLIPPED,g_faca2_d[l_ac].faca031_desc
            DISPLAY g_faca2_d[l_ac].faca031_desc TO faca031_desc              #

            NEXT FIELD faca031_desc                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page2.faca032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca032
            #add-point:ON ACTION controlp INFIELD faca032 name="input.c.page2.faca032"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.faca032_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca032_desc
            #add-point:ON ACTION controlp INFIELD faca032_desc name="input.c.page2.faca032_desc"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_faca2_d[l_ac].faca032             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_ooag001_8()                                #呼叫開窗
 
            LET g_faca2_d[l_ac].faca032 = g_qryparam.return1              
            CALL s_desc_get_person_desc(g_faca2_d[l_ac].faca032) RETURNING g_faca2_d[l_ac].faca032_desc
            LET g_faca2_d[l_ac].faca032_desc = g_faca2_d[l_ac].faca032 CLIPPED,g_faca2_d[l_ac].faca032_desc
            DISPLAY g_faca2_d[l_ac].faca032_desc TO faca032_desc              #

            NEXT FIELD faca032_desc                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page2.faca033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca033
            #add-point:ON ACTION controlp INFIELD faca033 name="input.c.page2.faca033"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.faca033_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca033_desc
            #add-point:ON ACTION controlp INFIELD faca033_desc name="input.c.page2.faca033_desc"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_faca2_d[l_ac].faca033             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_pjba001()                                #呼叫開窗
 
            LET g_faca2_d[l_ac].faca033 = g_qryparam.return1              
            CALL s_desc_get_project_desc(g_faca2_d[l_ac].faca033) RETURNING g_faca2_d[l_ac].faca033_desc
            LET g_faca2_d[l_ac].faca033_desc = g_faca2_d[l_ac].faca033 CLIPPED,g_faca2_d[l_ac].faca033_desc
            DISPLAY g_faca2_d[l_ac].faca033_desc TO faca033_desc              #

            NEXT FIELD faca033_desc                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page2.faca034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca034
            #add-point:ON ACTION controlp INFIELD faca034 name="input.c.page2.faca034"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.faca034_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca034_desc
            #add-point:ON ACTION controlp INFIELD faca034_desc name="input.c.page2.faca034_desc"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_faca2_d[l_ac].faca034             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_faca2_d[l_ac].faca033 

 
            CALL q_pjbb002_2()                                #呼叫開窗
 
            LET g_faca2_d[l_ac].faca034 = g_qryparam.return1              
            CALL s_desc_get_pjbbl004_desc(g_faca2_d[l_ac].faca033,g_faca2_d[l_ac].faca034) RETURNING g_faca2_d[l_ac].faca034_desc
            LET g_faca2_d[l_ac].faca034_desc = g_faca2_d[l_ac].faca034 CLIPPED,g_faca2_d[l_ac].faca034_desc 
            DISPLAY g_faca2_d[l_ac].faca034_desc TO faca034_desc              #

            NEXT FIELD faca034_desc                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page2.faca052
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca052
            #add-point:ON ACTION controlp INFIELD faca052 name="input.c.page2.faca052"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.faca053
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca053
            #add-point:ON ACTION controlp INFIELD faca053 name="input.c.page2.faca053"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.faca053_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca053_desc
            #add-point:ON ACTION controlp INFIELD faca053_desc name="input.c.page2.faca053_desc"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_faca2_d[l_ac].faca053
            CALL q_oojd001_2()
            LET g_faca2_d[l_ac].faca053 = g_qryparam.return1
            CALL s_desc_get_oojdl003_desc(g_faca2_d[l_ac].faca053) RETURNING g_faca2_d[l_ac].faca053_desc
            LET g_faca2_d[l_ac].faca053_desc = g_faca2_d[l_ac].faca053 CLIPPED,g_faca2_d[l_ac].faca053_desc 
            DISPLAY g_faca2_d[l_ac].faca053_desc TO faca053_desc          

            NEXT FIELD faca053_desc 
            #END add-point
 
 
         #Ctrlp:input.c.page2.faca054
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca054
            #add-point:ON ACTION controlp INFIELD faca054 name="input.c.page2.faca054"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.faca054_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca054_desc
            #add-point:ON ACTION controlp INFIELD faca054_desc name="input.c.page2.faca054_desc"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_faca2_d[l_ac].faca054
            CALL q_oocq002_2002()
            LET g_faca2_d[l_ac].faca054 = g_qryparam.return1
            CALL s_desc_get_acc_desc('2002',g_faca2_d[l_ac].faca054) RETURNING g_faca2_d[l_ac].faca054_desc
            LET g_faca2_d[l_ac].faca054_desc = g_faca2_d[l_ac].faca054 CLIPPED,g_faca2_d[l_ac].faca054_desc 
            DISPLAY g_faca2_d[l_ac].faca054_desc TO faca054_desc          

            NEXT FIELD faca054_desc 
            #END add-point
 
 
         #Ctrlp:input.c.page2.faca065
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca065
            #add-point:ON ACTION controlp INFIELD faca065 name="input.c.page2.faca065"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.faca065_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca065_desc
            #add-point:ON ACTION controlp INFIELD faca065_desc name="input.c.page2.faca065_desc"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_faca2_d[l_ac].faca065
            LET g_qryparam.where = " rtax004 = '",g_ooaa002,"'"
            CALL q_rtax001_1()
            LET g_faca2_d[l_ac].faca065 = g_qryparam.return1
            CALL s_desc_get_rtaxl003_desc(g_faca2_d[l_ac].faca065) RETURNING g_faca2_d[l_ac].faca065_desc
            LET g_faca2_d[l_ac].faca065_desc = g_faca2_d[l_ac].faca065 CLIPPED,g_faca2_d[l_ac].faca065_desc 
            DISPLAY g_faca2_d[l_ac].faca065_desc TO faca065_desc          

            NEXT FIELD faca065_desc 
            #END add-point
 
 
         #Ctrlp:input.c.page2.faca055
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca055
            #add-point:ON ACTION controlp INFIELD faca055 name="input.c.page2.faca055"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.faca055_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca055_desc
            #add-point:ON ACTION controlp INFIELD faca055_desc name="input.c.page2.faca055_desc"
            IF NOT cl_null(g_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_faca2_d[l_ac].faca055
               IF g_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",g_glad0171,"'" #自由核算項類型
               END IF 
               CALL q_agli041(g_glae009) 
               LET g_faca2_d[l_ac].faca055 = g_qryparam.return1
               CALL s_fin_get_accting_desc(g_glad0171,g_faca2_d[l_ac].faca055) RETURNING g_faca2_d[l_ac].faca055_desc
               LET g_faca2_d[l_ac].faca055_desc = g_faca2_d[l_ac].faca055 CLIPPED,g_faca2_d[l_ac].faca055_desc 
               NEXT FIELD faca055_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page2.faca056
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca056
            #add-point:ON ACTION controlp INFIELD faca056 name="input.c.page2.faca056"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.faca056_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca056_desc
            #add-point:ON ACTION controlp INFIELD faca056_desc name="input.c.page2.faca056_desc"
            IF NOT cl_null(g_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_faca2_d[l_ac].faca056
               IF g_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",g_glad0181,"'" #自由核算項類型
               END IF 
               CALL q_agli041(g_glae009) 
               LET g_faca2_d[l_ac].faca056 = g_qryparam.return1
               CALL s_fin_get_accting_desc(g_glad0181,g_faca2_d[l_ac].faca056) RETURNING g_faca2_d[l_ac].faca056_desc
               LET g_faca2_d[l_ac].faca056_desc = g_faca2_d[l_ac].faca056 CLIPPED,g_faca2_d[l_ac].faca056_desc 
               NEXT FIELD faca056_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page2.faca057
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca057
            #add-point:ON ACTION controlp INFIELD faca057 name="input.c.page2.faca057"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.faca057_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca057_desc
            #add-point:ON ACTION controlp INFIELD faca057_desc name="input.c.page2.faca057_desc"
            IF NOT cl_null(g_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_faca2_d[l_ac].faca057
               IF g_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",g_glad0191,"'" #自由核算項類型
               END IF 
               CALL q_agli041(g_glae009) 
               LET g_faca2_d[l_ac].faca057 = g_qryparam.return1
               CALL s_fin_get_accting_desc(g_glad0191,g_faca2_d[l_ac].faca057) RETURNING g_faca2_d[l_ac].faca057_desc
               LET g_faca2_d[l_ac].faca057_desc = g_faca2_d[l_ac].faca057 CLIPPED,g_faca2_d[l_ac].faca057_desc 
               NEXT FIELD faca057_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page2.faca058
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca058
            #add-point:ON ACTION controlp INFIELD faca058 name="input.c.page2.faca058"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.faca058_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca058_desc
            #add-point:ON ACTION controlp INFIELD faca058_desc name="input.c.page2.faca058_desc"
            IF NOT cl_null(g_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_faca2_d[l_ac].faca058
               IF g_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",g_glad0201,"'" #自由核算項類型
               END IF 
               CALL q_agli041(g_glae009) 
               LET g_faca2_d[l_ac].faca058 = g_qryparam.return1
               CALL s_fin_get_accting_desc(g_glad0201,g_faca2_d[l_ac].faca058) RETURNING g_faca2_d[l_ac].faca058_desc
               LET g_faca2_d[l_ac].faca058_desc = g_faca2_d[l_ac].faca058 CLIPPED,g_faca2_d[l_ac].faca058_desc 
               NEXT FIELD faca058_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page2.faca059
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca059
            #add-point:ON ACTION controlp INFIELD faca059 name="input.c.page2.faca059"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.faca059_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca059_desc
            #add-point:ON ACTION controlp INFIELD faca059_desc name="input.c.page2.faca059_desc"
            IF NOT cl_null(g_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_faca2_d[l_ac].faca059
               IF g_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",g_glad0211,"'" #自由核算項類型
               END IF 
               CALL q_agli041(g_glae009) 
               LET g_faca2_d[l_ac].faca059 = g_qryparam.return1
               CALL s_fin_get_accting_desc(g_glad0211,g_faca2_d[l_ac].faca059) RETURNING g_faca2_d[l_ac].faca059_desc
               LET g_faca2_d[l_ac].faca059_desc = g_faca2_d[l_ac].faca059 CLIPPED,g_faca2_d[l_ac].faca059_desc 
               NEXT FIELD faca059_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page2.faca060
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca060
            #add-point:ON ACTION controlp INFIELD faca060 name="input.c.page2.faca060"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.faca060_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca060_desc
            #add-point:ON ACTION controlp INFIELD faca060_desc name="input.c.page2.faca060_desc"
            IF NOT cl_null(g_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_faca2_d[l_ac].faca060
               IF g_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",g_glad0221,"'" #自由核算項類型
               END IF 
               CALL q_agli041(g_glae009) 
               LET g_faca2_d[l_ac].faca060 = g_qryparam.return1
               CALL s_fin_get_accting_desc(g_glad0221,g_faca2_d[l_ac].faca060) RETURNING g_faca2_d[l_ac].faca060_desc
               LET g_faca2_d[l_ac].faca060_desc = g_faca2_d[l_ac].faca060 CLIPPED,g_faca2_d[l_ac].faca060_desc 
               NEXT FIELD faca060_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page2.faca061
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca061
            #add-point:ON ACTION controlp INFIELD faca061 name="input.c.page2.faca061"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.faca061_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca061_desc
            #add-point:ON ACTION controlp INFIELD faca061_desc name="input.c.page2.faca061_desc"
            IF NOT cl_null(g_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_faca2_d[l_ac].faca061
               IF g_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",g_glad0231,"'" #自由核算項類型
               END IF 
               CALL q_agli041(g_glae009) 
               LET g_faca2_d[l_ac].faca061 = g_qryparam.return1
               CALL s_fin_get_accting_desc(g_glad0231,g_faca2_d[l_ac].faca061) RETURNING g_faca2_d[l_ac].faca061_desc
               LET g_faca2_d[l_ac].faca061_desc = g_faca2_d[l_ac].faca061 CLIPPED,g_faca2_d[l_ac].faca061_desc 
               NEXT FIELD faca061_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page2.faca062
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca062
            #add-point:ON ACTION controlp INFIELD faca062 name="input.c.page2.faca062"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.faca062_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca062_desc
            #add-point:ON ACTION controlp INFIELD faca062_desc name="input.c.page2.faca062_desc"
            IF NOT cl_null(g_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_faca2_d[l_ac].faca062
               IF g_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",g_glad0241,"'" #自由核算項類型
               END IF 
               CALL q_agli041(g_glae009) 
               LET g_faca2_d[l_ac].faca062 = g_qryparam.return1
               CALL s_fin_get_accting_desc(g_glad0241,g_faca2_d[l_ac].faca062) RETURNING g_faca2_d[l_ac].faca062_desc
               LET g_faca2_d[l_ac].faca062_desc = g_faca2_d[l_ac].faca062 CLIPPED,g_faca2_d[l_ac].faca062_desc 
               NEXT FIELD faca062_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page2.faca063
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca063
            #add-point:ON ACTION controlp INFIELD faca063 name="input.c.page2.faca063"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.faca063_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca063_desc
            #add-point:ON ACTION controlp INFIELD faca063_desc name="input.c.page2.faca063_desc"
            IF NOT cl_null(g_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_faca2_d[l_ac].faca063
               IF g_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",g_glad0251,"'" #自由核算項類型
               END IF 
               CALL q_agli041(g_glae009) 
               LET g_faca2_d[l_ac].faca063 = g_qryparam.return1
               CALL s_fin_get_accting_desc(g_glad0251,g_faca2_d[l_ac].faca063) RETURNING g_faca2_d[l_ac].faca063_desc
               LET g_faca2_d[l_ac].faca063_desc = g_faca2_d[l_ac].faca063 CLIPPED,g_faca2_d[l_ac].faca063_desc 
               NEXT FIELD faca063_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page2.faca064
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca064
            #add-point:ON ACTION controlp INFIELD faca064 name="input.c.page2.faca064"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.faca064_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca064_desc
            #add-point:ON ACTION controlp INFIELD faca064_desc name="input.c.page2.faca064_desc"
            IF NOT cl_null(g_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_faca2_d[l_ac].faca064
               IF g_glae009 = 'q_glaf002' THEN    
                  LET g_qryparam.where = "glaf001 = '",g_glad0261,"'" #自由核算項類型
               END IF 
               CALL q_agli041(g_glae009) 
               LET g_faca2_d[l_ac].faca064 = g_qryparam.return1
               CALL s_fin_get_accting_desc(g_glad0261,g_faca2_d[l_ac].faca064) RETURNING g_faca2_d[l_ac].faca064_desc
               LET g_faca2_d[l_ac].faca064_desc = g_faca2_d[l_ac].faca064 CLIPPED,g_faca2_d[l_ac].faca064_desc 
               NEXT FIELD faca064_desc
            END IF
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page2 after_row name="input.body2.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_faca2_d[l_ac].* = g_faca2_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE afat510_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL afat510_unlock_b("faca_t","'2'")
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
               LET g_faca_d[li_reproduce_target].* = g_faca_d[li_reproduce].*
               LET g_faca2_d[li_reproduce_target].* = g_faca2_d[li_reproduce].*
               LET g_faca5_d[li_reproduce_target].* = g_faca5_d[li_reproduce].*
 
               LET g_faca2_d[li_reproduce_target].facaseq = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_faca2_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_faca2_d.getLength()+1
            END IF
            
      END INPUT
      INPUT ARRAY g_faca3_d FROM s_detail3.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = FALSE, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = FALSE,
                 APPEND ROW = FALSE)
                 
         #自訂ACTION(detail_input,page_3)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body3.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_faca3_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL afat510_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue(""))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_faca3_d.getLength()
            #add-point:資料輸入前 name="input.body3.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_faca3_d[l_ac].* TO NULL 
            INITIALIZE g_faca3_d_t.* TO NULL 
            INITIALIZE g_faca3_d_o.* TO NULL 
            #公用欄位給值(單身3)
            
            #自定義預設值(單身3)
                  LET g_faca3_d[l_ac].xrcd006 = "N"
 
            #add-point:modify段before備份 name="input.body3.insert.before_bak"
            
            #end add-point
            LET g_faca3_d_t.* = g_faca3_d[l_ac].*     #新輸入資料
            LET g_faca3_d_o.* = g_faca3_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL afat510_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body3.insert.after_set_entry_b"
            
            #end add-point
            CALL afat510_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_faca3_d[li_reproduce_target].* = g_faca3_d[li_reproduce].*
 
               LET g_faca3_d[li_reproduce_target].xrcdseq = NULL
               LET g_faca3_d[li_reproduce_target].xrcdseq2 = NULL
               LET g_faca3_d[li_reproduce_target].xrcd007 = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body3.before_insert"
            
            #end add-point  
 
         BEFORE ROW     
            #add-point:modify段before row2 name="input.body3.before_row2"
            
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
            OPEN afat510_cl USING g_enterprise,g_fabg_m.fabgld,g_fabg_m.fabgdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN afat510_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE afat510_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_faca3_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_faca3_d[l_ac].xrcdseq IS NOT NULL
               AND g_faca3_d[l_ac].xrcdseq2 IS NOT NULL
               AND g_faca3_d[l_ac].xrcd007 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_faca3_d_t.* = g_faca3_d[l_ac].*  #BACKUP
               LET g_faca3_d_o.* = g_faca3_d[l_ac].*  #BACKUP
               CALL afat510_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body3.after_set_entry_b"
               
               #end add-point  
               CALL afat510_set_no_entry_b(l_cmd)
               IF NOT afat510_lock_b("xrcd_t","'3'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH afat510_bcl2 INTO g_faca3_d[l_ac].xrcdseq,g_faca3_d[l_ac].xrcdseq2,g_faca3_d[l_ac].xrcd007, 
                      g_faca3_d[l_ac].xrcd002,g_faca3_d[l_ac].xrcd003,g_faca3_d[l_ac].xrcd006,g_faca3_d[l_ac].xrcd103, 
                      g_faca3_d[l_ac].xrcd104,g_faca3_d[l_ac].xrcd105,g_faca3_d[l_ac].xrcd113,g_faca3_d[l_ac].xrcd114, 
                      g_faca3_d[l_ac].xrcd115,g_faca3_d[l_ac].xrcd009
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_faca3_d_mask_o[l_ac].* =  g_faca3_d[l_ac].*
                  CALL afat510_xrcd_t_mask()
                  LET g_faca3_d_mask_n[l_ac].* =  g_faca3_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL afat510_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body3.before_row"
            
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
               
               #add-point:單身3刪除前 name="input.body3.b_delete"
               
               #end add-point    
                  
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_fabg_m.fabgld
               LET gs_keys[gs_keys.getLength()+1] = g_fabg_m.fabgdocno
               LET gs_keys[gs_keys.getLength()+1] = g_faca3_d_t.xrcdseq
               LET gs_keys[gs_keys.getLength()+1] = g_faca3_d_t.xrcdseq2
               LET gs_keys[gs_keys.getLength()+1] = g_faca3_d_t.xrcd007
            
               #刪除同層單身
               IF NOT afat510_delete_b('xrcd_t',gs_keys,"'3'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE afat510_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT afat510_key_delete_b(gs_keys,'xrcd_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE afat510_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身3刪除中 name="input.body3.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE afat510_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身3刪除後 name="input.body3.a_delete"
               
               #end add-point
               LET l_count = g_faca_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body3.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_faca3_d.getLength() + 1) THEN
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
               
            #add-point:單身3新增前 name="input.body3.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM xrcd_t 
             WHERE xrcdent = g_enterprise AND xrcdld = g_fabg_m.fabgld
               AND xrcddocno = g_fabg_m.fabgdocno
               AND xrcdseq = g_faca3_d[l_ac].xrcdseq
               AND xrcdseq2 = g_faca3_d[l_ac].xrcdseq2
               AND xrcd007 = g_faca3_d[l_ac].xrcd007
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身3新增前 name="input.body3.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fabg_m.fabgld
               LET gs_keys[2] = g_fabg_m.fabgdocno
               LET gs_keys[3] = g_faca3_d[g_detail_idx].xrcdseq
               LET gs_keys[4] = g_faca3_d[g_detail_idx].xrcdseq2
               LET gs_keys[5] = g_faca3_d[g_detail_idx].xrcd007
               CALL afat510_insert_b('xrcd_t',gs_keys,"'3'")
                           
               #add-point:單身新增後3 name="input.body3.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_faca_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "xrcd_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL afat510_b_fill()
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
               LET g_faca3_d[l_ac].* = g_faca3_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE afat510_bcl2
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
               LET g_faca3_d[l_ac].* = g_faca3_d_t.*
            ELSE
               #add-point:單身page3修改前 name="input.body3.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身3)
               
               
               #將遮罩欄位還原
               CALL afat510_xrcd_t_mask_restore('restore_mask_o')
                              
               UPDATE xrcd_t SET (xrcdld,xrcddocno,xrcdseq,xrcdseq2,xrcd007,xrcd002,xrcd003,xrcd006, 
                   xrcd103,xrcd104,xrcd105,xrcd113,xrcd114,xrcd115,xrcd009) = (g_fabg_m.fabgld,g_fabg_m.fabgdocno, 
                   g_faca3_d[l_ac].xrcdseq,g_faca3_d[l_ac].xrcdseq2,g_faca3_d[l_ac].xrcd007,g_faca3_d[l_ac].xrcd002, 
                   g_faca3_d[l_ac].xrcd003,g_faca3_d[l_ac].xrcd006,g_faca3_d[l_ac].xrcd103,g_faca3_d[l_ac].xrcd104, 
                   g_faca3_d[l_ac].xrcd105,g_faca3_d[l_ac].xrcd113,g_faca3_d[l_ac].xrcd114,g_faca3_d[l_ac].xrcd115, 
                   g_faca3_d[l_ac].xrcd009) #自訂欄位頁簽
                WHERE xrcdent = g_enterprise AND xrcdld = g_fabg_m.fabgld
                  AND xrcddocno = g_fabg_m.fabgdocno
                  AND xrcdseq = g_faca3_d_t.xrcdseq #項次 
                  AND xrcdseq2 = g_faca3_d_t.xrcdseq2
                  AND xrcd007 = g_faca3_d_t.xrcd007
                  
               #add-point:單身page3修改中 name="input.body3.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_faca3_d[l_ac].* = g_faca3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xrcd_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_faca3_d[l_ac].* = g_faca3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xrcd_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fabg_m.fabgld
               LET gs_keys_bak[1] = g_fabgld_t
               LET gs_keys[2] = g_fabg_m.fabgdocno
               LET gs_keys_bak[2] = g_fabgdocno_t
               LET gs_keys[3] = g_faca3_d[g_detail_idx].xrcdseq
               LET gs_keys_bak[3] = g_faca3_d_t.xrcdseq
               LET gs_keys[4] = g_faca3_d[g_detail_idx].xrcdseq2
               LET gs_keys_bak[4] = g_faca3_d_t.xrcdseq2
               LET gs_keys[5] = g_faca3_d[g_detail_idx].xrcd007
               LET gs_keys_bak[5] = g_faca3_d_t.xrcd007
               CALL afat510_update_b('xrcd_t',gs_keys,gs_keys_bak,"'3'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL afat510_xrcd_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_faca3_d[g_detail_idx].xrcdseq = g_faca3_d_t.xrcdseq 
                  AND g_faca3_d[g_detail_idx].xrcdseq2 = g_faca3_d_t.xrcdseq2 
                  AND g_faca3_d[g_detail_idx].xrcd007 = g_faca3_d_t.xrcd007 
                  ) THEN
                  LET gs_keys[01] = g_fabg_m.fabgld
                  LET gs_keys[gs_keys.getLength()+1] = g_fabg_m.fabgdocno
                  LET gs_keys[gs_keys.getLength()+1] = g_faca3_d_t.xrcdseq
                  LET gs_keys[gs_keys.getLength()+1] = g_faca3_d_t.xrcdseq2
                  LET gs_keys[gs_keys.getLength()+1] = g_faca3_d_t.xrcd007
                  CALL afat510_key_update_b(gs_keys,'xrcd_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_fabg_m),util.JSON.stringify(g_faca3_d_t)
               LET g_log2 = util.JSON.stringify(g_fabg_m),util.JSON.stringify(g_faca3_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page3修改後 name="input.body3.a_update"
               
               #end add-point
            END IF
         
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcdseq
            
            #add-point:AFTER FIELD xrcdseq name="input.a.page3.xrcdseq"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  g_fabg_m.fabgld IS NOT NULL AND g_fabg_m.fabgdocno IS NOT NULL AND g_faca3_d[g_detail_idx].xrcdseq IS NOT NULL AND g_faca3_d[g_detail_idx].xrcdseq2 IS NOT NULL AND g_faca3_d[g_detail_idx].xrcd007 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_fabg_m.fabgld != g_fabgld_t OR g_fabg_m.fabgdocno != g_fabgdocno_t OR g_faca3_d[g_detail_idx].xrcdseq != g_faca3_d_t.xrcdseq OR g_faca3_d[g_detail_idx].xrcdseq2 != g_faca3_d_t.xrcdseq2 OR g_faca3_d[g_detail_idx].xrcd007 != g_faca3_d_t.xrcd007)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xrcd_t WHERE "||"xrcdent = " ||g_enterprise|| " AND "||"xrcdld = '"||g_fabg_m.fabgld ||"' AND "|| "xrcddocno = '"||g_fabg_m.fabgdocno ||"' AND "|| "xrcdseq = '"||g_faca3_d[g_detail_idx].xrcdseq ||"' AND "|| "xrcdseq2 = '"||g_faca3_d[g_detail_idx].xrcdseq2 ||"' AND "|| "xrcd007 = '"||g_faca3_d[g_detail_idx].xrcd007 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_faca3_d[l_ac].xrcdseq
            CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent="||g_enterprise||" AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_faca3_d[l_ac].xrcdseq_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_faca3_d[l_ac].xrcdseq_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcdseq
            #add-point:BEFORE FIELD xrcdseq name="input.b.page3.xrcdseq"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcdseq
            #add-point:ON CHANGE xrcdseq name="input.g.page3.xrcdseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca003
            #add-point:BEFORE FIELD faca003 name="input.b.page3.faca003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca003
            
            #add-point:AFTER FIELD faca003 name="input.a.page3.faca003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faca003
            #add-point:ON CHANGE faca003 name="input.g.page3.faca003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcdseq2
            #add-point:BEFORE FIELD xrcdseq2 name="input.b.page3.xrcdseq2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcdseq2
            
            #add-point:AFTER FIELD xrcdseq2 name="input.a.page3.xrcdseq2"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  g_fabg_m.fabgld IS NOT NULL AND g_fabg_m.fabgdocno IS NOT NULL AND g_faca3_d[g_detail_idx].xrcdseq IS NOT NULL AND g_faca3_d[g_detail_idx].xrcdseq2 IS NOT NULL AND g_faca3_d[g_detail_idx].xrcd007 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_fabg_m.fabgld != g_fabgld_t OR g_fabg_m.fabgdocno != g_fabgdocno_t OR g_faca3_d[g_detail_idx].xrcdseq != g_faca3_d_t.xrcdseq OR g_faca3_d[g_detail_idx].xrcdseq2 != g_faca3_d_t.xrcdseq2 OR g_faca3_d[g_detail_idx].xrcd007 != g_faca3_d_t.xrcd007)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xrcd_t WHERE "||"xrcdent = " ||g_enterprise|| " AND "||"xrcdld = '"||g_fabg_m.fabgld ||"' AND "|| "xrcddocno = '"||g_fabg_m.fabgdocno ||"' AND "|| "xrcdseq = '"||g_faca3_d[g_detail_idx].xrcdseq ||"' AND "|| "xrcdseq2 = '"||g_faca3_d[g_detail_idx].xrcdseq2 ||"' AND "|| "xrcd007 = '"||g_faca3_d[g_detail_idx].xrcd007 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcdseq2
            #add-point:ON CHANGE xrcdseq2 name="input.g.page3.xrcdseq2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd007
            #add-point:BEFORE FIELD xrcd007 name="input.b.page3.xrcd007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd007
            
            #add-point:AFTER FIELD xrcd007 name="input.a.page3.xrcd007"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  g_fabg_m.fabgld IS NOT NULL AND g_fabg_m.fabgdocno IS NOT NULL AND g_faca3_d[g_detail_idx].xrcdseq IS NOT NULL AND g_faca3_d[g_detail_idx].xrcdseq2 IS NOT NULL AND g_faca3_d[g_detail_idx].xrcd007 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_fabg_m.fabgld != g_fabgld_t OR g_fabg_m.fabgdocno != g_fabgdocno_t OR g_faca3_d[g_detail_idx].xrcdseq != g_faca3_d_t.xrcdseq OR g_faca3_d[g_detail_idx].xrcdseq2 != g_faca3_d_t.xrcdseq2 OR g_faca3_d[g_detail_idx].xrcd007 != g_faca3_d_t.xrcd007)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xrcd_t WHERE "||"xrcdent = " ||g_enterprise|| " AND "||"xrcdld = '"||g_fabg_m.fabgld ||"' AND "|| "xrcddocno = '"||g_fabg_m.fabgdocno ||"' AND "|| "xrcdseq = '"||g_faca3_d[g_detail_idx].xrcdseq ||"' AND "|| "xrcdseq2 = '"||g_faca3_d[g_detail_idx].xrcdseq2 ||"' AND "|| "xrcd007 = '"||g_faca3_d[g_detail_idx].xrcd007 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcd007
            #add-point:ON CHANGE xrcd007 name="input.g.page3.xrcd007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd002
            
            #add-point:AFTER FIELD xrcd002 name="input.a.page3.xrcd002"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_faca3_d[l_ac].xrcd002
            CALL ap_ref_array2(g_ref_fields,"SELECT oodbl004 FROM oodbl_t WHERE oodblent="||g_enterprise||" AND oodbl001='2' AND oodbl002=? AND oodbl003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_faca3_d[l_ac].xrcd002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_faca3_d[l_ac].xrcd002_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd002
            #add-point:BEFORE FIELD xrcd002 name="input.b.page3.xrcd002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcd002
            #add-point:ON CHANGE xrcd002 name="input.g.page3.xrcd002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd003
            #add-point:BEFORE FIELD xrcd003 name="input.b.page3.xrcd003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd003
            
            #add-point:AFTER FIELD xrcd003 name="input.a.page3.xrcd003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcd003
            #add-point:ON CHANGE xrcd003 name="input.g.page3.xrcd003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd006
            #add-point:BEFORE FIELD xrcd006 name="input.b.page3.xrcd006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd006
            
            #add-point:AFTER FIELD xrcd006 name="input.a.page3.xrcd006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcd006
            #add-point:ON CHANGE xrcd006 name="input.g.page3.xrcd006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd103
            #add-point:BEFORE FIELD xrcd103 name="input.b.page3.xrcd103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd103
            
            #add-point:AFTER FIELD xrcd103 name="input.a.page3.xrcd103"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcd103
            #add-point:ON CHANGE xrcd103 name="input.g.page3.xrcd103"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd104
            #add-point:BEFORE FIELD xrcd104 name="input.b.page3.xrcd104"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd104
            
            #add-point:AFTER FIELD xrcd104 name="input.a.page3.xrcd104"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcd104
            #add-point:ON CHANGE xrcd104 name="input.g.page3.xrcd104"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd105
            #add-point:BEFORE FIELD xrcd105 name="input.b.page3.xrcd105"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd105
            
            #add-point:AFTER FIELD xrcd105 name="input.a.page3.xrcd105"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcd105
            #add-point:ON CHANGE xrcd105 name="input.g.page3.xrcd105"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd113
            #add-point:BEFORE FIELD xrcd113 name="input.b.page3.xrcd113"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd113
            
            #add-point:AFTER FIELD xrcd113 name="input.a.page3.xrcd113"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcd113
            #add-point:ON CHANGE xrcd113 name="input.g.page3.xrcd113"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd114
            #add-point:BEFORE FIELD xrcd114 name="input.b.page3.xrcd114"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd114
            
            #add-point:AFTER FIELD xrcd114 name="input.a.page3.xrcd114"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcd114
            #add-point:ON CHANGE xrcd114 name="input.g.page3.xrcd114"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd115
            #add-point:BEFORE FIELD xrcd115 name="input.b.page3.xrcd115"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd115
            
            #add-point:AFTER FIELD xrcd115 name="input.a.page3.xrcd115"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcd115
            #add-point:ON CHANGE xrcd115 name="input.g.page3.xrcd115"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd009
            
            #add-point:AFTER FIELD xrcd009 name="input.a.page3.xrcd009"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_faca3_d[l_ac].xrcd009
            CALL ap_ref_array2(g_ref_fields,"SELECT glacl004 FROM glacl_t WHERE glaclent="||g_enterprise||" AND glacl001='' AND glacl002=? AND glacl003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_faca3_d[l_ac].xrcd009_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_faca3_d[l_ac].xrcd009_desc

            IF NOT cl_null(g_faca3_d[l_ac].xrcd009) THEN 
               # 开窗模糊查询                 
               IF s_aglt310_getlike_lc_subject(g_fabg_m.fabgld,g_faca3_d[l_ac].xrcd009,"")  THEN            
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
                  LET g_qryparam.reqry = 'FALSE'
                  LET g_qryparam.default1 = g_faca3_d[l_ac].xrcd009
                                
                  LET g_qryparam.arg1 = g_glaa.glaa004
                  LET g_qryparam.arg2 = g_faca3_d[l_ac].xrcd009
                  LET g_qryparam.arg3 = g_fabg_m.fabgld
                  LET g_qryparam.arg4 = " 1"
                  CALL q_glac002_6()
                  LET g_faca3_d[l_ac].xrcd009 = g_qryparam.return1              
                  CALL afat510_faca019_desc(g_faca3_d[l_ac].xrcd009) RETURNING g_faca3_d[l_ac].xrcd009_desc
                  DISPLAY g_faca3_d[l_ac].xrcd009_desc TO xrcd009_desc                
               END IF
               #科目存在性，有效性，非统治科目，非子系统科目，账户科目属性检查
               IF NOT  s_aglt310_lc_subject(g_fabg_m.fabgld,g_faca3_d[l_ac].xrcd009,'N') THEN
                  LET g_faca3_d[l_ac].xrcd009 = g_faca3_d_t.xrcd009
                  LET g_faca3_d[l_ac].xrcd009_desc = g_faca3_d_t.xrcd009_desc
                  NEXT FIELD CURRENT
               ELSE
                  SELECT glad017,glad0171,glad0172,glad018,glad0181,glad0182,
                         glad019,glad0191,glad0192,glad020,glad0201,glad0202,
                         glad021,glad0211,glad0212,glad022,glad0221,glad0222,
                         glad023,glad0231,glad0232,glad024,glad0221,glad0242,
                         glad025,glad0251,glad0252,glad026,glad0261,glad0262
                   INTO  g_glad017,g_glad0171,g_glad0172,g_glad018,g_glad0181,g_glad0182,
                         g_glad019,g_glad0191,g_glad0192,g_glad020,g_glad0201,g_glad0202,
                         g_glad021,g_glad0211,g_glad0212,g_glad022,g_glad0221,g_glad0222,
                         g_glad023,g_glad0231,g_glad0232,g_glad024,g_glad0241,g_glad0242,
                         g_glad025,g_glad0251,g_glad0252,g_glad026,g_glad0261,g_glad0262
                   FROM  glad_t
                   WHERE gladent = g_enterprise
                     AND gladld = g_fabg_m.fabgld
                     AND glad001 = g_faca3_d[l_ac].xrcd009
               END IF
            END IF    
            CALL afat510_faca019_desc(g_faca3_d[l_ac].xrcd009) RETURNING g_faca3_d[l_ac].xrcd009_desc
            DISPLAY g_faca3_d[l_ac].xrcd009_desc TO xrcd009_desc        
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd009
            #add-point:BEFORE FIELD xrcd009 name="input.b.page3.xrcd009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcd009
            #add-point:ON CHANGE xrcd009 name="input.g.page3.xrcd009"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page3.xrcdseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcdseq
            #add-point:ON ACTION controlp INFIELD xrcdseq name="input.c.page3.xrcdseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.faca003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca003
            #add-point:ON ACTION controlp INFIELD faca003 name="input.c.page3.faca003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.xrcdseq2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcdseq2
            #add-point:ON ACTION controlp INFIELD xrcdseq2 name="input.c.page3.xrcdseq2"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.xrcd007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd007
            #add-point:ON ACTION controlp INFIELD xrcd007 name="input.c.page3.xrcd007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.xrcd002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd002
            #add-point:ON ACTION controlp INFIELD xrcd002 name="input.c.page3.xrcd002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.xrcd003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd003
            #add-point:ON ACTION controlp INFIELD xrcd003 name="input.c.page3.xrcd003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.xrcd006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd006
            #add-point:ON ACTION controlp INFIELD xrcd006 name="input.c.page3.xrcd006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.xrcd103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd103
            #add-point:ON ACTION controlp INFIELD xrcd103 name="input.c.page3.xrcd103"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.xrcd104
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd104
            #add-point:ON ACTION controlp INFIELD xrcd104 name="input.c.page3.xrcd104"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.xrcd105
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd105
            #add-point:ON ACTION controlp INFIELD xrcd105 name="input.c.page3.xrcd105"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.xrcd113
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd113
            #add-point:ON ACTION controlp INFIELD xrcd113 name="input.c.page3.xrcd113"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.xrcd114
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd114
            #add-point:ON ACTION controlp INFIELD xrcd114 name="input.c.page3.xrcd114"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.xrcd115
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd115
            #add-point:ON ACTION controlp INFIELD xrcd115 name="input.c.page3.xrcd115"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.xrcd009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd009
            #add-point:ON ACTION controlp INFIELD xrcd009 name="input.c.page3.xrcd009"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_faca3_d[l_ac].xrcd009             #給予default值
            LET g_qryparam.where = " glac001 = '",g_glaa.glaa004,"'",
                                   " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 AND gladld='",g_fabg_m.fabgld,"' AND gladent=",g_enterprise,
                                   " AND gladstus = 'Y' )" 
  
            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL aglt310_04()                                #呼叫開窗
 
            LET g_faca3_d[l_ac].xrcd009 = g_qryparam.return1              
            CALL afat510_faca019_desc(g_faca3_d[l_ac].xrcd009) RETURNING g_faca3_d[l_ac].xrcd009_desc
            DISPLAY g_faca3_d[l_ac].xrcd009_desc TO xrcd009_desc
            DISPLAY g_faca3_d[l_ac].xrcd009 TO xrcd009              #

            NEXT FIELD xrcd009                          #返回原欄位



            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page3 after_row name="input.body3.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_faca3_d[l_ac].* = g_faca3_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE afat510_bcl2
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL afat510_unlock_b("xrcd_t","'3'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page3 after_row2 name="input.body3.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body3.after_input"
            
            #end add-point   
    
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_faca3_d[li_reproduce_target].* = g_faca3_d[li_reproduce].*
 
               LET g_faca3_d[li_reproduce_target].xrcdseq = NULL
               LET g_faca3_d[li_reproduce_target].xrcdseq2 = NULL
               LET g_faca3_d[li_reproduce_target].xrcd007 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_faca3_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_faca3_d.getLength()+1
            END IF
            
      END INPUT
      INPUT ARRAY g_faca5_d FROM s_detail5.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = FALSE, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = FALSE,
                 APPEND ROW = FALSE)
                 
         #自訂ACTION(detail_input,page_4)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body5.before_input2"
            NEXT FIELD facaseq
            #end add-point
            
            CALL afat510_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue(""))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_faca5_d.getLength()
            #add-point:資料輸入前 name="input.body5.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_faca5_d[l_ac].* TO NULL 
            INITIALIZE g_faca5_d_t.* TO NULL 
            INITIALIZE g_faca5_d_o.* TO NULL 
            #公用欄位給值(單身4)
            
            #自定義預設值(單身4)
                  LET g_faca5_d[l_ac].faca043 = "0"
      LET g_faca5_d[l_ac].faca039 = "0"
      LET g_faca5_d[l_ac].faca040 = "0"
      LET g_faca5_d[l_ac].faca041 = "0"
      LET g_faca5_d[l_ac].faca042 = "0"
      LET g_faca5_d[l_ac].faca044 = "0"
      LET g_faca5_d[l_ac].faca050 = "0"
      LET g_faca5_d[l_ac].faca046 = "0"
      LET g_faca5_d[l_ac].faca047 = "0"
      LET g_faca5_d[l_ac].faca048 = "0"
      LET g_faca5_d[l_ac].faca049 = "0"
      LET g_faca5_d[l_ac].faca051 = "0"
 
            #add-point:modify段before備份 name="input.body5.insert.before_bak"
            
            #end add-point
            LET g_faca5_d_t.* = g_faca5_d[l_ac].*     #新輸入資料
            LET g_faca5_d_o.* = g_faca5_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL afat510_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body5.insert.after_set_entry_b"
            
            #end add-point
            CALL afat510_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_faca_d[li_reproduce_target].* = g_faca_d[li_reproduce].*
               LET g_faca2_d[li_reproduce_target].* = g_faca2_d[li_reproduce].*
               LET g_faca5_d[li_reproduce_target].* = g_faca5_d[li_reproduce].*
 
               LET g_faca5_d[li_reproduce_target].facaseq = NULL
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
            OPEN afat510_cl USING g_enterprise,g_fabg_m.fabgld,g_fabg_m.fabgdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN afat510_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE afat510_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_faca5_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_faca5_d[l_ac].facaseq IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_faca5_d_t.* = g_faca5_d[l_ac].*  #BACKUP
               LET g_faca5_d_o.* = g_faca5_d[l_ac].*  #BACKUP
               CALL afat510_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body5.after_set_entry_b"
               
               #end add-point  
               CALL afat510_set_no_entry_b(l_cmd)
               IF NOT afat510_lock_b("faca_t","'4'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH afat510_bcl INTO g_faca_d[l_ac].facaseq,g_faca_d[l_ac].faca001,g_faca_d[l_ac].faca002, 
                      g_faca_d[l_ac].faca003,g_faca_d[l_ac].faca004,g_faca_d[l_ac].faca005,g_faca_d[l_ac].faca008, 
                      g_faca_d[l_ac].faca009,g_faca_d[l_ac].faca010,g_faca_d[l_ac].faca017,g_faca_d[l_ac].faca007, 
                      g_faca_d[l_ac].faca011,g_faca_d[l_ac].faca012,g_faca_d[l_ac].faca013,g_faca_d[l_ac].faca014, 
                      g_faca_d[l_ac].faca015,g_faca_d[l_ac].faca016,g_faca_d[l_ac].faca018,g_faca_d[l_ac].faca024, 
                      g_faca2_d[l_ac].facaseq,g_faca2_d[l_ac].faca019,g_faca2_d[l_ac].faca036,g_faca2_d[l_ac].faca025, 
                      g_faca2_d[l_ac].faca026,g_faca2_d[l_ac].faca027,g_faca2_d[l_ac].faca028,g_faca2_d[l_ac].faca029, 
                      g_faca2_d[l_ac].faca030,g_faca2_d[l_ac].faca031,g_faca2_d[l_ac].faca032,g_faca2_d[l_ac].faca033, 
                      g_faca2_d[l_ac].faca034,g_faca2_d[l_ac].faca052,g_faca2_d[l_ac].faca053,g_faca2_d[l_ac].faca054, 
                      g_faca2_d[l_ac].faca065,g_faca2_d[l_ac].faca055,g_faca2_d[l_ac].faca056,g_faca2_d[l_ac].faca057, 
                      g_faca2_d[l_ac].faca058,g_faca2_d[l_ac].faca059,g_faca2_d[l_ac].faca060,g_faca2_d[l_ac].faca061, 
                      g_faca2_d[l_ac].faca062,g_faca2_d[l_ac].faca063,g_faca2_d[l_ac].faca064,g_faca5_d[l_ac].facaseq, 
                      g_faca5_d[l_ac].faca043,g_faca5_d[l_ac].faca038,g_faca5_d[l_ac].faca039,g_faca5_d[l_ac].faca040, 
                      g_faca5_d[l_ac].faca041,g_faca5_d[l_ac].faca042,g_faca5_d[l_ac].faca044,g_faca5_d[l_ac].faca050, 
                      g_faca5_d[l_ac].faca045,g_faca5_d[l_ac].faca046,g_faca5_d[l_ac].faca047,g_faca5_d[l_ac].faca048, 
                      g_faca5_d[l_ac].faca049,g_faca5_d[l_ac].faca051
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_faca5_d_mask_o[l_ac].* =  g_faca5_d[l_ac].*
                  CALL afat510_faca_t_mask()
                  LET g_faca5_d_mask_n[l_ac].* =  g_faca5_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL afat510_show()
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
               LET gs_keys[01] = g_fabg_m.fabgld
               LET gs_keys[gs_keys.getLength()+1] = g_fabg_m.fabgdocno
               LET gs_keys[gs_keys.getLength()+1] = g_faca5_d_t.facaseq
            
               #刪除同層單身
               IF NOT afat510_delete_b('faca_t',gs_keys,"'4'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE afat510_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT afat510_key_delete_b(gs_keys,'faca_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE afat510_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
 
 
               
               #add-point:單身4刪除中 name="input.body5.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE afat510_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身4刪除後 name="input.body5.a_delete"
               
               #end add-point
               LET l_count = g_faca_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body5.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_faca5_d.getLength() + 1) THEN
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
            SELECT COUNT(1) INTO l_count FROM faca_t 
             WHERE facaent = g_enterprise AND facald = g_fabg_m.fabgld
               AND facadocno = g_fabg_m.fabgdocno
               AND facaseq = g_faca5_d[l_ac].facaseq
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身4新增前 name="input.body5.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fabg_m.fabgld
               LET gs_keys[2] = g_fabg_m.fabgdocno
               LET gs_keys[3] = g_faca5_d[g_detail_idx].facaseq
               CALL afat510_insert_b('faca_t',gs_keys,"'4'")
                           
               #add-point:單身新增後4 name="input.body5.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_faca_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "faca_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL afat510_b_fill()
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
               LET g_faca5_d[l_ac].* = g_faca5_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE afat510_bcl
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
               LET g_faca5_d[l_ac].* = g_faca5_d_t.*
            ELSE
               #add-point:單身page4修改前 name="input.body5.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身4)
               
               
               #將遮罩欄位還原
               CALL afat510_faca_t_mask_restore('restore_mask_o')
                              
               UPDATE faca_t SET (facald,facadocno,facaseq,faca001,faca002,faca003,faca004,faca005,faca008, 
                   faca009,faca010,faca017,faca007,faca011,faca012,faca013,faca014,faca015,faca016,faca018, 
                   faca024,faca019,faca036,faca025,faca026,faca027,faca028,faca029,faca030,faca031,faca032, 
                   faca033,faca034,faca052,faca053,faca054,faca065,faca055,faca056,faca057,faca058,faca059, 
                   faca060,faca061,faca062,faca063,faca064,faca043,faca038,faca039,faca040,faca041,faca042, 
                   faca044,faca050,faca045,faca046,faca047,faca048,faca049,faca051) = (g_fabg_m.fabgld, 
                   g_fabg_m.fabgdocno,g_faca_d[l_ac].facaseq,g_faca_d[l_ac].faca001,g_faca_d[l_ac].faca002, 
                   g_faca_d[l_ac].faca003,g_faca_d[l_ac].faca004,g_faca_d[l_ac].faca005,g_faca_d[l_ac].faca008, 
                   g_faca_d[l_ac].faca009,g_faca_d[l_ac].faca010,g_faca_d[l_ac].faca017,g_faca_d[l_ac].faca007, 
                   g_faca_d[l_ac].faca011,g_faca_d[l_ac].faca012,g_faca_d[l_ac].faca013,g_faca_d[l_ac].faca014, 
                   g_faca_d[l_ac].faca015,g_faca_d[l_ac].faca016,g_faca_d[l_ac].faca018,g_faca_d[l_ac].faca024, 
                   g_faca2_d[l_ac].faca019,g_faca2_d[l_ac].faca036,g_faca2_d[l_ac].faca025,g_faca2_d[l_ac].faca026, 
                   g_faca2_d[l_ac].faca027,g_faca2_d[l_ac].faca028,g_faca2_d[l_ac].faca029,g_faca2_d[l_ac].faca030, 
                   g_faca2_d[l_ac].faca031,g_faca2_d[l_ac].faca032,g_faca2_d[l_ac].faca033,g_faca2_d[l_ac].faca034, 
                   g_faca2_d[l_ac].faca052,g_faca2_d[l_ac].faca053,g_faca2_d[l_ac].faca054,g_faca2_d[l_ac].faca065, 
                   g_faca2_d[l_ac].faca055,g_faca2_d[l_ac].faca056,g_faca2_d[l_ac].faca057,g_faca2_d[l_ac].faca058, 
                   g_faca2_d[l_ac].faca059,g_faca2_d[l_ac].faca060,g_faca2_d[l_ac].faca061,g_faca2_d[l_ac].faca062, 
                   g_faca2_d[l_ac].faca063,g_faca2_d[l_ac].faca064,g_faca5_d[l_ac].faca043,g_faca5_d[l_ac].faca038, 
                   g_faca5_d[l_ac].faca039,g_faca5_d[l_ac].faca040,g_faca5_d[l_ac].faca041,g_faca5_d[l_ac].faca042, 
                   g_faca5_d[l_ac].faca044,g_faca5_d[l_ac].faca050,g_faca5_d[l_ac].faca045,g_faca5_d[l_ac].faca046, 
                   g_faca5_d[l_ac].faca047,g_faca5_d[l_ac].faca048,g_faca5_d[l_ac].faca049,g_faca5_d[l_ac].faca051)  
                   #自訂欄位頁簽
                WHERE facaent = g_enterprise AND facald = g_fabg_m.fabgld
                  AND facadocno = g_fabg_m.fabgdocno
                  AND facaseq = g_faca5_d_t.facaseq #項次 
                  
               #add-point:單身page4修改中 name="input.body5.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_faca5_d[l_ac].* = g_faca5_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "faca_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_faca5_d[l_ac].* = g_faca5_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "faca_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fabg_m.fabgld
               LET gs_keys_bak[1] = g_fabgld_t
               LET gs_keys[2] = g_fabg_m.fabgdocno
               LET gs_keys_bak[2] = g_fabgdocno_t
               LET gs_keys[3] = g_faca5_d[g_detail_idx].facaseq
               LET gs_keys_bak[3] = g_faca5_d_t.facaseq
               CALL afat510_update_b('faca_t',gs_keys,gs_keys_bak,"'4'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL afat510_faca_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_faca5_d[g_detail_idx].facaseq = g_faca5_d_t.facaseq 
                  ) THEN
                  LET gs_keys[01] = g_fabg_m.fabgld
                  LET gs_keys[gs_keys.getLength()+1] = g_fabg_m.fabgdocno
                  LET gs_keys[gs_keys.getLength()+1] = g_faca5_d_t.facaseq
                  CALL afat510_key_update_b(gs_keys,'faca_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_fabg_m),util.JSON.stringify(g_faca5_d_t)
               LET g_log2 = util.JSON.stringify(g_fabg_m),util.JSON.stringify(g_faca5_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page4修改後 name="input.body5.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca043
            #add-point:BEFORE FIELD faca043 name="input.b.page5.faca043"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca043
            
            #add-point:AFTER FIELD faca043 name="input.a.page5.faca043"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faca043
            #add-point:ON CHANGE faca043 name="input.g.page5.faca043"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca038
            #add-point:BEFORE FIELD faca038 name="input.b.page5.faca038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca038
            
            #add-point:AFTER FIELD faca038 name="input.a.page5.faca038"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faca038
            #add-point:ON CHANGE faca038 name="input.g.page5.faca038"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca039
            #add-point:BEFORE FIELD faca039 name="input.b.page5.faca039"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca039
            
            #add-point:AFTER FIELD faca039 name="input.a.page5.faca039"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faca039
            #add-point:ON CHANGE faca039 name="input.g.page5.faca039"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca040
            #add-point:BEFORE FIELD faca040 name="input.b.page5.faca040"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca040
            
            #add-point:AFTER FIELD faca040 name="input.a.page5.faca040"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faca040
            #add-point:ON CHANGE faca040 name="input.g.page5.faca040"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca041
            #add-point:BEFORE FIELD faca041 name="input.b.page5.faca041"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca041
            
            #add-point:AFTER FIELD faca041 name="input.a.page5.faca041"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faca041
            #add-point:ON CHANGE faca041 name="input.g.page5.faca041"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca042
            #add-point:BEFORE FIELD faca042 name="input.b.page5.faca042"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca042
            
            #add-point:AFTER FIELD faca042 name="input.a.page5.faca042"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faca042
            #add-point:ON CHANGE faca042 name="input.g.page5.faca042"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca044
            #add-point:BEFORE FIELD faca044 name="input.b.page5.faca044"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca044
            
            #add-point:AFTER FIELD faca044 name="input.a.page5.faca044"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faca044
            #add-point:ON CHANGE faca044 name="input.g.page5.faca044"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca050
            #add-point:BEFORE FIELD faca050 name="input.b.page5.faca050"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca050
            
            #add-point:AFTER FIELD faca050 name="input.a.page5.faca050"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faca050
            #add-point:ON CHANGE faca050 name="input.g.page5.faca050"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca045
            #add-point:BEFORE FIELD faca045 name="input.b.page5.faca045"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca045
            
            #add-point:AFTER FIELD faca045 name="input.a.page5.faca045"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faca045
            #add-point:ON CHANGE faca045 name="input.g.page5.faca045"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca046
            #add-point:BEFORE FIELD faca046 name="input.b.page5.faca046"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca046
            
            #add-point:AFTER FIELD faca046 name="input.a.page5.faca046"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faca046
            #add-point:ON CHANGE faca046 name="input.g.page5.faca046"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca047
            #add-point:BEFORE FIELD faca047 name="input.b.page5.faca047"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca047
            
            #add-point:AFTER FIELD faca047 name="input.a.page5.faca047"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faca047
            #add-point:ON CHANGE faca047 name="input.g.page5.faca047"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca048
            #add-point:BEFORE FIELD faca048 name="input.b.page5.faca048"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca048
            
            #add-point:AFTER FIELD faca048 name="input.a.page5.faca048"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faca048
            #add-point:ON CHANGE faca048 name="input.g.page5.faca048"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca049
            #add-point:BEFORE FIELD faca049 name="input.b.page5.faca049"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca049
            
            #add-point:AFTER FIELD faca049 name="input.a.page5.faca049"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faca049
            #add-point:ON CHANGE faca049 name="input.g.page5.faca049"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faca051
            #add-point:BEFORE FIELD faca051 name="input.b.page5.faca051"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faca051
            
            #add-point:AFTER FIELD faca051 name="input.a.page5.faca051"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faca051
            #add-point:ON CHANGE faca051 name="input.g.page5.faca051"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page5.faca043
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca043
            #add-point:ON ACTION controlp INFIELD faca043 name="input.c.page5.faca043"
            
            #END add-point
 
 
         #Ctrlp:input.c.page5.faca038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca038
            #add-point:ON ACTION controlp INFIELD faca038 name="input.c.page5.faca038"
            
            #END add-point
 
 
         #Ctrlp:input.c.page5.faca039
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca039
            #add-point:ON ACTION controlp INFIELD faca039 name="input.c.page5.faca039"
            
            #END add-point
 
 
         #Ctrlp:input.c.page5.faca040
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca040
            #add-point:ON ACTION controlp INFIELD faca040 name="input.c.page5.faca040"
            
            #END add-point
 
 
         #Ctrlp:input.c.page5.faca041
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca041
            #add-point:ON ACTION controlp INFIELD faca041 name="input.c.page5.faca041"
            
            #END add-point
 
 
         #Ctrlp:input.c.page5.faca042
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca042
            #add-point:ON ACTION controlp INFIELD faca042 name="input.c.page5.faca042"
            
            #END add-point
 
 
         #Ctrlp:input.c.page5.faca044
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca044
            #add-point:ON ACTION controlp INFIELD faca044 name="input.c.page5.faca044"
            
            #END add-point
 
 
         #Ctrlp:input.c.page5.faca050
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca050
            #add-point:ON ACTION controlp INFIELD faca050 name="input.c.page5.faca050"
            
            #END add-point
 
 
         #Ctrlp:input.c.page5.faca045
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca045
            #add-point:ON ACTION controlp INFIELD faca045 name="input.c.page5.faca045"
            
            #END add-point
 
 
         #Ctrlp:input.c.page5.faca046
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca046
            #add-point:ON ACTION controlp INFIELD faca046 name="input.c.page5.faca046"
            
            #END add-point
 
 
         #Ctrlp:input.c.page5.faca047
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca047
            #add-point:ON ACTION controlp INFIELD faca047 name="input.c.page5.faca047"
            
            #END add-point
 
 
         #Ctrlp:input.c.page5.faca048
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca048
            #add-point:ON ACTION controlp INFIELD faca048 name="input.c.page5.faca048"
            
            #END add-point
 
 
         #Ctrlp:input.c.page5.faca049
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca049
            #add-point:ON ACTION controlp INFIELD faca049 name="input.c.page5.faca049"
            
            #END add-point
 
 
         #Ctrlp:input.c.page5.faca051
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faca051
            #add-point:ON ACTION controlp INFIELD faca051 name="input.c.page5.faca051"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page4 after_row name="input.body5.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_faca5_d[l_ac].* = g_faca5_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE afat510_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL afat510_unlock_b("faca_t","'4'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page4 after_row2 name="input.body5.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body5.after_input"
            
            #end add-point   
    
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_faca_d[li_reproduce_target].* = g_faca_d[li_reproduce].*
               LET g_faca2_d[li_reproduce_target].* = g_faca2_d[li_reproduce].*
               LET g_faca5_d[li_reproduce_target].* = g_faca5_d[li_reproduce].*
 
               LET g_faca5_d[li_reproduce_target].facaseq = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_faca5_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_faca5_d.getLength()+1
            END IF
            
      END INPUT
 
      
 
 
 
 
{</section>}
 
{<section id="afat510.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
         
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1','2','4',"))      
         CALL DIALOG.setCurrentRow("s_detail2",g_idx_group.getValue("'3',"))
         CALL DIALOG.setCurrentRow("s_detail3",g_idx_group.getValue(""))
         CALL DIALOG.setCurrentRow("s_detail5",g_idx_group.getValue(""))
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            NEXT FIELD fabgsite
            #end add-point  
            NEXT FIELD fabgld
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD facaseq
               WHEN "s_detail2"
                  NEXT FIELD facaseq_2
               WHEN "s_detail3"
                  NEXT FIELD xrcdseq
               WHEN "s_detail5"
                  NEXT FIELD facaseq_4
 
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
         CALL g_curr_diag.setCurrentRow("s_detail3",1)
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
         CALL g_curr_diag.setCurrentRow("s_detail3",1)
         CALL g_curr_diag.setCurrentRow("s_detail5",1)
 
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
    
   #add-point:input段after input  name="input.after_input"
   IF NOT INT_FLAG THEN
      #获取单别
      CALL s_aooi200_get_slip(g_fabg_m.fabgdocno) RETURNING l_success,l_slip
                      
      #是否抛傳票
      CALL s_fin_get_doc_para(g_fabg_m.fabgld,g_fabg_m.fabgcomp,l_slip,'D-FIN-0030') RETURNING l_ooac004
                      
      IF l_ooac004 = 'Y' AND g_glaa.glaa121 = 'Y' THEN 
           CALL s_transaction_begin()
           CALL cl_err_collect_init()
           CALL s_pre_voucher_ins('FA','F50',g_fabg_m.fabgld,g_fabg_m.fabgdocno,g_fabg_m.fabgdocdt,'44') RETURNING l_success
           
           IF l_success THEN
              CALL s_transaction_end('Y','1')
           ELSE
              CALL s_transaction_end('N','1')     
           END IF
           CALL cl_err_collect_show() 
      END IF
   END IF
   CALL afat510_show()
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="afat510.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION afat510_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   CALL afat510_get_glaa()
   CALL afat510_visible()
   IF g_glaa.glaa121 = 'Y' THEN
      CALL cl_set_toolbaritem_visible("open_pre",TRUE)
   ELSE
      CALL cl_set_toolbaritem_visible("open_pre",FALSE)
   END IF
   
   IF g_fabg_m.fabg012 = 'F' THEN
      CALL cl_set_toolbaritem_visible("open_pre,open_axrt300_13,open_afap280,open_afap290",FALSE)
   ELSE
      CALL cl_set_toolbaritem_visible("open_pre,open_axrt300_13,open_afap280,open_afap290",TRUE)
   END IF
   
   IF NOT cl_null(g_fabg_m.fabgdocno) AND g_fabg_m.fabgstus = 'S' AND cl_null(g_fabg_m.fabg008) THEN 
      CALL cl_set_act_visible("open_afap280",TRUE)
   ELSE
      CALL cl_set_act_visible("open_afap280",FALSE)
   END IF
   
   IF NOT cl_null(g_fabg_m.fabg008) THEN 
      CALL cl_set_act_visible("open_afap290",TRUE)
   ELSE
      CALL cl_set_act_visible("open_afap290",FALSE)
   END IF
   
   IF cl_null(g_fabg_m.fabg012) AND NOT cl_null(g_fabg_m.fabgdocno) 
      AND (g_fabg_m.fabgstus = 'Y' OR g_fabg_m.fabgstus = 'S') THEN 
      CALL cl_set_act_visible("open_afap270",TRUE) 
   ELSE
      CALL cl_set_act_visible("open_afap270",FALSE) 
   END IF
   
   IF NOT cl_null(g_fabg_m.fabg012) AND g_fabg_m.fabg012 <> 'F' THEN 
      CALL cl_set_act_visible("set_back",TRUE) 
   ELSE
      CALL cl_set_act_visible("set_back",FALSE) 
   END IF
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL afat510_b_fill() #單身填充
      CALL afat510_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL afat510_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   
   #end add-point
   
   #遮罩相關處理
   LET g_fabg_m_mask_o.* =  g_fabg_m.*
   CALL afat510_fabg_t_mask()
   LET g_fabg_m_mask_n.* =  g_fabg_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_fabg_m.fabgsite,g_fabg_m.fabgsite_desc,g_fabg_m.fabg001,g_fabg_m.fabg001_desc,g_fabg_m.fabgld, 
       g_fabg_m.fabgld_desc,g_fabg_m.fabgcomp,g_fabg_m.fabg005,g_fabg_m.fabgdocno,g_fabg_m.fabgdocdt, 
       g_fabg_m.fabg010,g_fabg_m.fabg010_desc,g_fabg_m.fabg018,g_fabg_m.fabg018_desc,g_fabg_m.fabg017, 
       g_fabg_m.fabg006,g_fabg_m.fabg006_desc,g_fabg_m.fabg007,g_fabg_m.fabg007_desc,g_fabg_m.fabg013, 
       g_fabg_m.fabg014,g_fabg_m.fabg015,g_fabg_m.fabg016,g_fabg_m.fabg012,g_fabg_m.fabg008,g_fabg_m.fabgstus, 
       g_fabg_m.fabgownid,g_fabg_m.fabgownid_desc,g_fabg_m.fabgowndp,g_fabg_m.fabgowndp_desc,g_fabg_m.fabgcrtid, 
       g_fabg_m.fabgcrtid_desc,g_fabg_m.fabgcrtdp,g_fabg_m.fabgcrtdp_desc,g_fabg_m.fabgcrtdt,g_fabg_m.fabgmodid, 
       g_fabg_m.fabgmodid_desc,g_fabg_m.fabgmoddt,g_fabg_m.fabgcnfid,g_fabg_m.fabgcnfid_desc,g_fabg_m.fabgcnfdt, 
       g_fabg_m.fabgpstid,g_fabg_m.fabgpstid_desc,g_fabg_m.fabgpstdt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_fabg_m.fabgstus 
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "Z"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unposted.png")
         WHEN "S"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/posted.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_faca_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_faca2_d.getLength()
      #add-point:show段單身reference name="show.body2.reference"
      
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_faca3_d.getLength()
      #add-point:show段單身reference name="show.body3.reference"
      
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_faca5_d.getLength()
      #add-point:show段單身reference name="show.body5.reference"
      
      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL afat510_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="afat510.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION afat510_detail_show()
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
 
{<section id="afat510.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION afat510_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE fabg_t.fabgld 
   DEFINE l_oldno     LIKE fabg_t.fabgld 
   DEFINE l_newno02     LIKE fabg_t.fabgdocno 
   DEFINE l_oldno02     LIKE fabg_t.fabgdocno 
 
   DEFINE l_master    RECORD LIKE fabg_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE faca_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE xrcd_t.* #此變數樣板目前無使用
 
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="reproduce.pre_function"
   
   #end add-point
   
   #切換畫面
   
   LET g_master_insert = FALSE
   
   IF g_fabg_m.fabgld IS NULL
   OR g_fabg_m.fabgdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_fabgld_t = g_fabg_m.fabgld
   LET g_fabgdocno_t = g_fabg_m.fabgdocno
 
    
   LET g_fabg_m.fabgld = ""
   LET g_fabg_m.fabgdocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_fabg_m.fabgownid = g_user
      LET g_fabg_m.fabgowndp = g_dept
      LET g_fabg_m.fabgcrtid = g_user
      LET g_fabg_m.fabgcrtdp = g_dept 
      LET g_fabg_m.fabgcrtdt = cl_get_current()
      LET g_fabg_m.fabgmodid = g_user
      LET g_fabg_m.fabgmoddt = cl_get_current()
      LET g_fabg_m.fabgstus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_fabg_m.fabgstus 
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "Z"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unposted.png")
         WHEN "S"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/posted.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
      LET g_fabg_m.fabgld_desc = ''
   DISPLAY BY NAME g_fabg_m.fabgld_desc
 
   
   CALL afat510_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_fabg_m.* TO NULL
      INITIALIZE g_faca_d TO NULL
      INITIALIZE g_faca2_d TO NULL
      INITIALIZE g_faca3_d TO NULL
      INITIALIZE g_faca5_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL afat510_show()
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
   CALL afat510_set_act_visible()   
   CALL afat510_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_fabgld_t = g_fabg_m.fabgld
   LET g_fabgdocno_t = g_fabg_m.fabgdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " fabgent = " ||g_enterprise|| " AND",
                      " fabgld = '", g_fabg_m.fabgld, "' "
                      ," AND fabgdocno = '", g_fabg_m.fabgdocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL afat510_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL afat510_idx_chk()
   
   LET g_data_owner = g_fabg_m.fabgownid      
   LET g_data_dept  = g_fabg_m.fabgowndp
   
   #功能已完成,通報訊息中心
   CALL afat510_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="afat510.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION afat510_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE faca_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE xrcd_t.* #此變數樣板目前無使用
 
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE afat510_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM faca_t
    WHERE facaent = g_enterprise AND facald = g_fabgld_t
     AND facadocno = g_fabgdocno_t
 
    INTO TEMP afat510_detail
 
   #將key修正為調整後   
   UPDATE afat510_detail 
      #更新key欄位
      SET facald = g_fabg_m.fabgld
          , facadocno = g_fabg_m.fabgdocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO faca_t SELECT * FROM afat510_detail
   
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
   DROP TABLE afat510_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table2.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM xrcd_t 
    WHERE xrcdent = g_enterprise AND xrcdld = g_fabgld_t
      AND xrcddocno = g_fabgdocno_t   
 
    INTO TEMP afat510_detail
 
   #將key修正為調整後   
   UPDATE afat510_detail SET xrcdld = g_fabg_m.fabgld
                                       , xrcddocno = g_fabg_m.fabgdocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table2.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO xrcd_t SELECT * FROM afat510_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table2.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE afat510_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table2.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_fabgld_t = g_fabg_m.fabgld
   LET g_fabgdocno_t = g_fabg_m.fabgdocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="afat510.delete" >}
#+ 資料刪除
PRIVATE FUNCTION afat510_delete()
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
   
   IF g_fabg_m.fabgld IS NULL
   OR g_fabg_m.fabgdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN afat510_cl USING g_enterprise,g_fabg_m.fabgld,g_fabg_m.fabgdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN afat510_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE afat510_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE afat510_master_referesh USING g_fabg_m.fabgld,g_fabg_m.fabgdocno INTO g_fabg_m.fabgsite,g_fabg_m.fabg001, 
       g_fabg_m.fabgld,g_fabg_m.fabgcomp,g_fabg_m.fabg005,g_fabg_m.fabgdocno,g_fabg_m.fabgdocdt,g_fabg_m.fabg010, 
       g_fabg_m.fabg018,g_fabg_m.fabg017,g_fabg_m.fabg006,g_fabg_m.fabg007,g_fabg_m.fabg013,g_fabg_m.fabg014, 
       g_fabg_m.fabg015,g_fabg_m.fabg016,g_fabg_m.fabg012,g_fabg_m.fabg008,g_fabg_m.fabgstus,g_fabg_m.fabgownid, 
       g_fabg_m.fabgowndp,g_fabg_m.fabgcrtid,g_fabg_m.fabgcrtdp,g_fabg_m.fabgcrtdt,g_fabg_m.fabgmodid, 
       g_fabg_m.fabgmoddt,g_fabg_m.fabgcnfid,g_fabg_m.fabgcnfdt,g_fabg_m.fabgpstid,g_fabg_m.fabgpstdt, 
       g_fabg_m.fabgsite_desc,g_fabg_m.fabg001_desc,g_fabg_m.fabgld_desc,g_fabg_m.fabg010_desc,g_fabg_m.fabg018_desc, 
       g_fabg_m.fabg006_desc,g_fabg_m.fabg007_desc,g_fabg_m.fabgownid_desc,g_fabg_m.fabgowndp_desc,g_fabg_m.fabgcrtid_desc, 
       g_fabg_m.fabgcrtdp_desc,g_fabg_m.fabgmodid_desc,g_fabg_m.fabgcnfid_desc,g_fabg_m.fabgpstid_desc 
 
   
   
   #檢查是否允許此動作
   IF NOT afat510_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_fabg_m_mask_o.* =  g_fabg_m.*
   CALL afat510_fabg_t_mask()
   LET g_fabg_m_mask_n.* =  g_fabg_m.*
   
   CALL afat510_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   IF NOT cl_null(g_fabg_m.fabgdocdt) THEN 
      IF NOT s_afa_date_chk('',g_fabg_m.fabgcomp,g_fabg_m.fabgdocdt) THEN 
         CLOSE afat510_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF 
   END IF 
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL afat510_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_fabgld_t = g_fabg_m.fabgld
      LET g_fabgdocno_t = g_fabg_m.fabgdocno
 
 
      DELETE FROM fabg_t
       WHERE fabgent = g_enterprise AND fabgld = g_fabg_m.fabgld
         AND fabgdocno = g_fabg_m.fabgdocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_fabg_m.fabgld,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      IF g_glaa.glaa121 = 'Y' THEN
         CALL s_pre_voucher_del('FA','F50',g_fabg_m.fabgld,g_fabg_m.fabgdocno) RETURNING l_success
         
         IF l_success = FALSE THEN 
            CALL s_transaction_end('N','0')
            RETURN
         END IF
      END IF
      IF NOT s_aooi200_fin_del_docno(g_fabg_m.fabgld,g_fabg_m.fabgdocno,g_fabg_m.fabgdocdt) THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM faca_t
       WHERE facaent = g_enterprise AND facald = g_fabg_m.fabgld
         AND facadocno = g_fabg_m.fabgdocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "faca_t:",SQLERRMESSAGE 
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
      DELETE FROM xrcd_t
       WHERE xrcdent = g_enterprise AND
             xrcdld = g_fabg_m.fabgld AND xrcddocno = g_fabg_m.fabgdocno
      #add-point:單身刪除中 name="delete.body.m_delete2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "faca_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete2"
      
      #end add-point
 
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_fabg_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE afat510_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_faca_d.clear() 
      CALL g_faca2_d.clear()       
      CALL g_faca3_d.clear()       
      CALL g_faca5_d.clear()       
 
     
      CALL afat510_ui_browser_refresh()  
      #CALL afat510_ui_headershow()  
      #CALL afat510_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
      
      
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL afat510_browser_fill("")
         CALL afat510_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE afat510_cl
 
   #功能已完成,通報訊息中心
   CALL afat510_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="afat510.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION afat510_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_faca_d.clear()
   CALL g_faca2_d.clear()
   CALL g_faca3_d.clear()
   CALL g_faca5_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF afat510_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT facaseq,faca001,faca002,faca003,faca004,faca005,faca008,faca009, 
             faca010,faca017,faca007,faca011,faca012,faca013,faca014,faca015,faca016,faca018,faca024, 
             facaseq,faca019,faca036,faca025,faca026,faca027,faca028,faca029,faca030,faca031,faca032, 
             faca033,faca034,faca052,faca053,faca054,faca065,faca055,faca056,faca057,faca058,faca059, 
             faca060,faca061,faca062,faca063,faca064,facaseq,faca043,faca038,faca039,faca040,faca041, 
             faca042,faca044,faca050,faca045,faca046,faca047,faca048,faca049,faca051  FROM faca_t",  
               
                     " INNER JOIN fabg_t ON fabgent = " ||g_enterprise|| " AND fabgld = facald ",
                     " AND fabgdocno = facadocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                     
                     " WHERE facaent=? AND facald=? AND facadocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY faca_t.facaseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE afat510_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR afat510_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_fabg_m.fabgld,g_fabg_m.fabgdocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_fabg_m.fabgld,g_fabg_m.fabgdocno INTO g_faca_d[l_ac].facaseq, 
          g_faca_d[l_ac].faca001,g_faca_d[l_ac].faca002,g_faca_d[l_ac].faca003,g_faca_d[l_ac].faca004, 
          g_faca_d[l_ac].faca005,g_faca_d[l_ac].faca008,g_faca_d[l_ac].faca009,g_faca_d[l_ac].faca010, 
          g_faca_d[l_ac].faca017,g_faca_d[l_ac].faca007,g_faca_d[l_ac].faca011,g_faca_d[l_ac].faca012, 
          g_faca_d[l_ac].faca013,g_faca_d[l_ac].faca014,g_faca_d[l_ac].faca015,g_faca_d[l_ac].faca016, 
          g_faca_d[l_ac].faca018,g_faca_d[l_ac].faca024,g_faca2_d[l_ac].facaseq,g_faca2_d[l_ac].faca019, 
          g_faca2_d[l_ac].faca036,g_faca2_d[l_ac].faca025,g_faca2_d[l_ac].faca026,g_faca2_d[l_ac].faca027, 
          g_faca2_d[l_ac].faca028,g_faca2_d[l_ac].faca029,g_faca2_d[l_ac].faca030,g_faca2_d[l_ac].faca031, 
          g_faca2_d[l_ac].faca032,g_faca2_d[l_ac].faca033,g_faca2_d[l_ac].faca034,g_faca2_d[l_ac].faca052, 
          g_faca2_d[l_ac].faca053,g_faca2_d[l_ac].faca054,g_faca2_d[l_ac].faca065,g_faca2_d[l_ac].faca055, 
          g_faca2_d[l_ac].faca056,g_faca2_d[l_ac].faca057,g_faca2_d[l_ac].faca058,g_faca2_d[l_ac].faca059, 
          g_faca2_d[l_ac].faca060,g_faca2_d[l_ac].faca061,g_faca2_d[l_ac].faca062,g_faca2_d[l_ac].faca063, 
          g_faca2_d[l_ac].faca064,g_faca5_d[l_ac].facaseq,g_faca5_d[l_ac].faca043,g_faca5_d[l_ac].faca038, 
          g_faca5_d[l_ac].faca039,g_faca5_d[l_ac].faca040,g_faca5_d[l_ac].faca041,g_faca5_d[l_ac].faca042, 
          g_faca5_d[l_ac].faca044,g_faca5_d[l_ac].faca050,g_faca5_d[l_ac].faca045,g_faca5_d[l_ac].faca046, 
          g_faca5_d[l_ac].faca047,g_faca5_d[l_ac].faca048,g_faca5_d[l_ac].faca049,g_faca5_d[l_ac].faca051  
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
         CALL afat510_faca019_desc(g_faca2_d[l_ac].faca019) RETURNING g_faca2_d[l_ac].faca019_desc
         DISPLAY g_faca2_d[l_ac].faca019_desc TO faca019_desc   

         CALL s_desc_get_department_desc(g_faca2_d[l_ac].faca025) RETURNING g_faca2_d[l_ac].faca025_desc
         LET g_faca2_d[l_ac].faca025_desc = g_faca2_d[l_ac].faca025 CLIPPED,g_faca2_d[l_ac].faca025_desc
         CALL s_desc_get_department_desc(g_faca2_d[l_ac].faca026) RETURNING g_faca2_d[l_ac].faca026_desc
         LET g_faca2_d[l_ac].faca026_desc = g_faca2_d[l_ac].faca026 CLIPPED,g_faca2_d[l_ac].faca026_desc
         CALL s_desc_get_department_desc(g_faca2_d[l_ac].faca027) RETURNING g_faca2_d[l_ac].faca027_desc
         LET g_faca2_d[l_ac].faca027_desc = g_faca2_d[l_ac].faca027 CLIPPED,g_faca2_d[l_ac].faca027_desc
         CALL s_desc_get_acc_desc('287',g_faca2_d[l_ac].faca028) RETURNING g_faca2_d[l_ac].faca028_desc
         LET g_faca2_d[l_ac].faca028_desc = g_faca2_d[l_ac].faca028 CLIPPED,g_faca2_d[l_ac].faca028_desc
         CALL s_desc_get_trading_partner_abbr_desc(g_faca2_d[l_ac].faca029) RETURNING g_faca2_d[l_ac].faca029_desc
         LET g_faca2_d[l_ac].faca029_desc = g_faca2_d[l_ac].faca029 CLIPPED,g_faca2_d[l_ac].faca029_desc
         CALL s_desc_get_trading_partner_abbr_desc(g_faca2_d[l_ac].faca030) RETURNING g_faca2_d[l_ac].faca030_desc
         LET g_faca2_d[l_ac].faca030_desc = g_faca2_d[l_ac].faca030 CLIPPED,g_faca2_d[l_ac].faca030_desc
         CALL s_desc_get_acc_desc('281',g_faca2_d[l_ac].faca031) RETURNING g_faca2_d[l_ac].faca031_desc
         LET g_faca2_d[l_ac].faca031_desc = g_faca2_d[l_ac].faca031 CLIPPED,g_faca2_d[l_ac].faca031_desc
         CALL s_desc_get_person_desc(g_faca2_d[l_ac].faca032) RETURNING g_faca2_d[l_ac].faca032_desc
         LET g_faca2_d[l_ac].faca032_desc = g_faca2_d[l_ac].faca032 CLIPPED,g_faca2_d[l_ac].faca032_desc
         CALL s_desc_get_project_desc(g_faca2_d[l_ac].faca033) RETURNING g_faca2_d[l_ac].faca033_desc
         LET g_faca2_d[l_ac].faca033_desc = g_faca2_d[l_ac].faca033 CLIPPED,g_faca2_d[l_ac].faca033_desc
         CALL s_desc_get_pjbbl004_desc(g_faca2_d[l_ac].faca033,g_faca2_d[l_ac].faca034) RETURNING g_faca2_d[l_ac].faca034_desc
         LET g_faca2_d[l_ac].faca034_desc = g_faca2_d[l_ac].faca034 CLIPPED,g_faca2_d[l_ac].faca034_desc 
         CALL s_desc_get_oojdl003_desc(g_faca2_d[l_ac].faca053) RETURNING g_faca2_d[l_ac].faca053_desc
         LET g_faca2_d[l_ac].faca053_desc = g_faca2_d[l_ac].faca053 CLIPPED,g_faca2_d[l_ac].faca053_desc
         CALL s_desc_get_acc_desc('2002',g_faca2_d[l_ac].faca054) RETURNING g_faca2_d[l_ac].faca054_desc
         LET g_faca2_d[l_ac].faca054_desc = g_faca2_d[l_ac].faca054 CLIPPED,g_faca2_d[l_ac].faca054_desc
         CALL s_desc_get_rtaxl003_desc(g_faca2_d[l_ac].faca065) RETURNING g_faca2_d[l_ac].faca065_desc
         LET g_faca2_d[l_ac].faca065_desc = g_faca2_d[l_ac].faca065 CLIPPED,g_faca2_d[l_ac].faca065_desc 
         
         
         CALL s_fin_get_accting_desc(g_glad0171,g_faca2_d[l_ac].faca055) RETURNING g_faca2_d[l_ac].faca055_desc
         LET g_faca2_d[l_ac].faca055_desc = g_faca2_d[l_ac].faca055 CLIPPED,g_faca2_d[l_ac].faca055_desc 
         CALL s_fin_get_accting_desc(g_glad0181,g_faca2_d[l_ac].faca056) RETURNING g_faca2_d[l_ac].faca056_desc
         LET g_faca2_d[l_ac].faca056_desc = g_faca2_d[l_ac].faca056 CLIPPED,g_faca2_d[l_ac].faca056_desc 
         CALL s_fin_get_accting_desc(g_glad0191,g_faca2_d[l_ac].faca057) RETURNING g_faca2_d[l_ac].faca057_desc
         LET g_faca2_d[l_ac].faca057_desc = g_faca2_d[l_ac].faca057 CLIPPED,g_faca2_d[l_ac].faca057_desc 
         CALL s_fin_get_accting_desc(g_glad0201,g_faca2_d[l_ac].faca058) RETURNING g_faca2_d[l_ac].faca058_desc
         LET g_faca2_d[l_ac].faca058_desc = g_faca2_d[l_ac].faca058 CLIPPED,g_faca2_d[l_ac].faca058_desc 
         CALL s_fin_get_accting_desc(g_glad0211,g_faca2_d[l_ac].faca059) RETURNING g_faca2_d[l_ac].faca059_desc
         LET g_faca2_d[l_ac].faca059_desc = g_faca2_d[l_ac].faca059 CLIPPED,g_faca2_d[l_ac].faca059_desc 
         CALL s_fin_get_accting_desc(g_glad0221,g_faca2_d[l_ac].faca060) RETURNING g_faca2_d[l_ac].faca060_desc
         LET g_faca2_d[l_ac].faca060_desc = g_faca2_d[l_ac].faca060 CLIPPED,g_faca2_d[l_ac].faca060_desc 
         CALL s_fin_get_accting_desc(g_glad0231,g_faca2_d[l_ac].faca061) RETURNING g_faca2_d[l_ac].faca061_desc
         LET g_faca2_d[l_ac].faca061_desc = g_faca2_d[l_ac].faca061 CLIPPED,g_faca2_d[l_ac].faca061_desc 
         CALL s_fin_get_accting_desc(g_glad0241,g_faca2_d[l_ac].faca062) RETURNING g_faca2_d[l_ac].faca062_desc
         LET g_faca2_d[l_ac].faca062_desc = g_faca2_d[l_ac].faca062 CLIPPED,g_faca2_d[l_ac].faca062_desc 
         CALL s_fin_get_accting_desc(g_glad0251,g_faca2_d[l_ac].faca063) RETURNING g_faca2_d[l_ac].faca063_desc
         LET g_faca2_d[l_ac].faca063_desc = g_faca2_d[l_ac].faca063 CLIPPED,g_faca2_d[l_ac].faca063_desc 
         CALL s_fin_get_accting_desc(g_glad0261,g_faca2_d[l_ac].faca064) RETURNING g_faca2_d[l_ac].faca064_desc
         LET g_faca2_d[l_ac].faca064_desc = g_faca2_d[l_ac].faca064 CLIPPED,g_faca2_d[l_ac].faca064_desc 
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
   IF afat510_fill_chk(2) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body2.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT xrcdseq,xrcdseq2,xrcd007,xrcd002,xrcd003,xrcd006,xrcd103,xrcd104, 
             xrcd105,xrcd113,xrcd114,xrcd115,xrcd009 ,t2.oodbl004 ,t3.glacl004 FROM xrcd_t",   
                     " INNER JOIN  fabg_t ON fabgent = " ||g_enterprise|| " AND fabgld = xrcdld ",
                     " AND fabgdocno = xrcddocno ",
 
                     "",
                     
                                    " LEFT JOIN oodbl_t t2 ON t2.oodblent="||g_enterprise||" AND t2.oodbl001='2' AND t2.oodbl002=xrcd002 AND t2.oodbl003='"||g_dlang||"' ",
               " LEFT JOIN glacl_t t3 ON t3.glaclent="||g_enterprise||" AND t3.glacl001='' AND t3.glacl002=xrcd009 AND t3.glacl003='"||g_dlang||"' ",
 
                     " WHERE xrcdent=? AND xrcdld=? AND xrcddocno=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body2.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table2) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY xrcd_t.xrcdseq,xrcd_t.xrcdseq2,xrcd_t.xrcd007"
         
         #add-point:單身填充控制 name="b_fill.sql2"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE afat510_pb2 FROM g_sql
         DECLARE b_fill_cs2 CURSOR FOR afat510_pb2
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs2 USING g_enterprise,g_fabg_m.fabgld,g_fabg_m.fabgdocno   #(ver:78)
                                               
      FOREACH b_fill_cs2 USING g_enterprise,g_fabg_m.fabgld,g_fabg_m.fabgdocno INTO g_faca3_d[l_ac].xrcdseq, 
          g_faca3_d[l_ac].xrcdseq2,g_faca3_d[l_ac].xrcd007,g_faca3_d[l_ac].xrcd002,g_faca3_d[l_ac].xrcd003, 
          g_faca3_d[l_ac].xrcd006,g_faca3_d[l_ac].xrcd103,g_faca3_d[l_ac].xrcd104,g_faca3_d[l_ac].xrcd105, 
          g_faca3_d[l_ac].xrcd113,g_faca3_d[l_ac].xrcd114,g_faca3_d[l_ac].xrcd115,g_faca3_d[l_ac].xrcd009, 
          g_faca3_d[l_ac].xrcd002_desc,g_faca3_d[l_ac].xrcd009_desc   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill2.fill"
         SELECT faca003 INTO g_faca3_d[l_ac].faca003
           FROM faca_t
          WHERE facaent = g_enterprise
            AND facald = g_fabg_m.fabgld
            AND facadocno = g_fabg_m.fabgdocno
            AND facaseq = g_faca3_d[l_ac].xrcdseq
            
         CALL afat510_faca019_desc(g_faca3_d[l_ac].xrcd009) RETURNING g_faca3_d[l_ac].xrcd009_desc
         DISPLAY g_faca3_d[l_ac].xrcd009_desc TO xrcd009_desc
         
         SELECT oodbl004 INTO g_faca3_d[l_ac].xrcd002_desc    
           FROM oodbl_t           
          WHERE oodblent = g_enterprise
            AND oodbl001 = g_ooef019
            AND oodbl002 = g_faca3_d[l_ac].xrcd002
            AND oodbl003 = g_dlang
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
   
   CALL g_faca_d.deleteElement(g_faca_d.getLength())
   CALL g_faca2_d.deleteElement(g_faca2_d.getLength())
   CALL g_faca3_d.deleteElement(g_faca3_d.getLength())
   CALL g_faca5_d.deleteElement(g_faca5_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE afat510_pb
   FREE afat510_pb2
 
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_faca_d.getLength()
      LET g_faca_d_mask_o[l_ac].* =  g_faca_d[l_ac].*
      CALL afat510_faca_t_mask()
      LET g_faca_d_mask_n[l_ac].* =  g_faca_d[l_ac].*
   END FOR
   
   LET g_faca2_d_mask_o.* =  g_faca2_d.*
   FOR l_ac = 1 TO g_faca2_d.getLength()
      LET g_faca2_d_mask_o[l_ac].* =  g_faca2_d[l_ac].*
      CALL afat510_faca_t_mask()
      LET g_faca2_d_mask_n[l_ac].* =  g_faca2_d[l_ac].*
   END FOR
   LET g_faca3_d_mask_o.* =  g_faca3_d.*
   FOR l_ac = 1 TO g_faca3_d.getLength()
      LET g_faca3_d_mask_o[l_ac].* =  g_faca3_d[l_ac].*
      CALL afat510_xrcd_t_mask()
      LET g_faca3_d_mask_n[l_ac].* =  g_faca3_d[l_ac].*
   END FOR
   LET g_faca5_d_mask_o.* =  g_faca5_d.*
   FOR l_ac = 1 TO g_faca5_d.getLength()
      LET g_faca5_d_mask_o[l_ac].* =  g_faca5_d[l_ac].*
      CALL afat510_faca_t_mask()
      LET g_faca5_d_mask_n[l_ac].* =  g_faca5_d[l_ac].*
   END FOR
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="afat510.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION afat510_delete_b(ps_table,ps_keys_bak,ps_page)
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
   LET ls_group = "'1','2','4',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete"
      
      #end add-point    
      DELETE FROM faca_t
       WHERE facaent = g_enterprise AND
         facald = ps_keys_bak[1] AND facadocno = ps_keys_bak[2] AND facaseq = ps_keys_bak[3]
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
         CALL g_faca_d.deleteElement(li_idx) 
      END IF 
      IF ps_page <> "'2'" THEN 
         CALL g_faca2_d.deleteElement(li_idx) 
      END IF 
      IF ps_page <> "'4'" THEN 
         CALL g_faca5_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete2"
      
      #end add-point    
      DELETE FROM xrcd_t
       WHERE xrcdent = g_enterprise AND
             xrcdld = ps_keys_bak[1] AND xrcddocno = ps_keys_bak[2] AND xrcdseq = ps_keys_bak[3] AND xrcdseq2 = ps_keys_bak[4] AND xrcd007 = ps_keys_bak[5]
      #add-point:delete_b段刪除中 name="delete_b.m_delete2"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xrcd_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'3'" THEN 
         CALL g_faca3_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete2"
      
      #end add-point    
   END IF
 
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="afat510.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION afat510_insert_b(ps_table,ps_keys,ps_page)
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
   LET ls_group = "'1','2','4',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert"
      
      #end add-point 
      INSERT INTO faca_t
                  (facaent,
                   facald,facadocno,
                   facaseq
                   ,faca001,faca002,faca003,faca004,faca005,faca008,faca009,faca010,faca017,faca007,faca011,faca012,faca013,faca014,faca015,faca016,faca018,faca024,faca019,faca036,faca025,faca026,faca027,faca028,faca029,faca030,faca031,faca032,faca033,faca034,faca052,faca053,faca054,faca065,faca055,faca056,faca057,faca058,faca059,faca060,faca061,faca062,faca063,faca064,faca043,faca038,faca039,faca040,faca041,faca042,faca044,faca050,faca045,faca046,faca047,faca048,faca049,faca051) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_faca_d[g_detail_idx].faca001,g_faca_d[g_detail_idx].faca002,g_faca_d[g_detail_idx].faca003, 
                       g_faca_d[g_detail_idx].faca004,g_faca_d[g_detail_idx].faca005,g_faca_d[g_detail_idx].faca008, 
                       g_faca_d[g_detail_idx].faca009,g_faca_d[g_detail_idx].faca010,g_faca_d[g_detail_idx].faca017, 
                       g_faca_d[g_detail_idx].faca007,g_faca_d[g_detail_idx].faca011,g_faca_d[g_detail_idx].faca012, 
                       g_faca_d[g_detail_idx].faca013,g_faca_d[g_detail_idx].faca014,g_faca_d[g_detail_idx].faca015, 
                       g_faca_d[g_detail_idx].faca016,g_faca_d[g_detail_idx].faca018,g_faca_d[g_detail_idx].faca024, 
                       g_faca2_d[g_detail_idx].faca019,g_faca2_d[g_detail_idx].faca036,g_faca2_d[g_detail_idx].faca025, 
                       g_faca2_d[g_detail_idx].faca026,g_faca2_d[g_detail_idx].faca027,g_faca2_d[g_detail_idx].faca028, 
                       g_faca2_d[g_detail_idx].faca029,g_faca2_d[g_detail_idx].faca030,g_faca2_d[g_detail_idx].faca031, 
                       g_faca2_d[g_detail_idx].faca032,g_faca2_d[g_detail_idx].faca033,g_faca2_d[g_detail_idx].faca034, 
                       g_faca2_d[g_detail_idx].faca052,g_faca2_d[g_detail_idx].faca053,g_faca2_d[g_detail_idx].faca054, 
                       g_faca2_d[g_detail_idx].faca065,g_faca2_d[g_detail_idx].faca055,g_faca2_d[g_detail_idx].faca056, 
                       g_faca2_d[g_detail_idx].faca057,g_faca2_d[g_detail_idx].faca058,g_faca2_d[g_detail_idx].faca059, 
                       g_faca2_d[g_detail_idx].faca060,g_faca2_d[g_detail_idx].faca061,g_faca2_d[g_detail_idx].faca062, 
                       g_faca2_d[g_detail_idx].faca063,g_faca2_d[g_detail_idx].faca064,g_faca5_d[g_detail_idx].faca043, 
                       g_faca5_d[g_detail_idx].faca038,g_faca5_d[g_detail_idx].faca039,g_faca5_d[g_detail_idx].faca040, 
                       g_faca5_d[g_detail_idx].faca041,g_faca5_d[g_detail_idx].faca042,g_faca5_d[g_detail_idx].faca044, 
                       g_faca5_d[g_detail_idx].faca050,g_faca5_d[g_detail_idx].faca045,g_faca5_d[g_detail_idx].faca046, 
                       g_faca5_d[g_detail_idx].faca047,g_faca5_d[g_detail_idx].faca048,g_faca5_d[g_detail_idx].faca049, 
                       g_faca5_d[g_detail_idx].faca051)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "faca_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_faca_d.insertElement(li_idx) 
      END IF 
      IF ps_page <> "'2'" THEN 
         CALL g_faca2_d.insertElement(li_idx) 
      END IF 
      IF ps_page <> "'4'" THEN 
         CALL g_faca5_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert2"
      
      #end add-point 
      INSERT INTO xrcd_t
                  (xrcdent,
                   xrcdld,xrcddocno,
                   xrcdseq,xrcdseq2,xrcd007
                   ,xrcd002,xrcd003,xrcd006,xrcd103,xrcd104,xrcd105,xrcd113,xrcd114,xrcd115,xrcd009) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4],ps_keys[5]
                   ,g_faca3_d[g_detail_idx].xrcd002,g_faca3_d[g_detail_idx].xrcd003,g_faca3_d[g_detail_idx].xrcd006, 
                       g_faca3_d[g_detail_idx].xrcd103,g_faca3_d[g_detail_idx].xrcd104,g_faca3_d[g_detail_idx].xrcd105, 
                       g_faca3_d[g_detail_idx].xrcd113,g_faca3_d[g_detail_idx].xrcd114,g_faca3_d[g_detail_idx].xrcd115, 
                       g_faca3_d[g_detail_idx].xrcd009)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xrcd_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'3'" THEN 
         CALL g_faca3_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert2"
      
      #end add-point
   END IF
 
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="afat510.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION afat510_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   LET ls_group = "'1','2','4',"
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "faca_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL afat510_faca_t_mask_restore('restore_mask_o')
               
      UPDATE faca_t 
         SET (facald,facadocno,
              facaseq
              ,faca001,faca002,faca003,faca004,faca005,faca008,faca009,faca010,faca017,faca007,faca011,faca012,faca013,faca014,faca015,faca016,faca018,faca024,faca019,faca036,faca025,faca026,faca027,faca028,faca029,faca030,faca031,faca032,faca033,faca034,faca052,faca053,faca054,faca065,faca055,faca056,faca057,faca058,faca059,faca060,faca061,faca062,faca063,faca064,faca043,faca038,faca039,faca040,faca041,faca042,faca044,faca050,faca045,faca046,faca047,faca048,faca049,faca051) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_faca_d[g_detail_idx].faca001,g_faca_d[g_detail_idx].faca002,g_faca_d[g_detail_idx].faca003, 
                  g_faca_d[g_detail_idx].faca004,g_faca_d[g_detail_idx].faca005,g_faca_d[g_detail_idx].faca008, 
                  g_faca_d[g_detail_idx].faca009,g_faca_d[g_detail_idx].faca010,g_faca_d[g_detail_idx].faca017, 
                  g_faca_d[g_detail_idx].faca007,g_faca_d[g_detail_idx].faca011,g_faca_d[g_detail_idx].faca012, 
                  g_faca_d[g_detail_idx].faca013,g_faca_d[g_detail_idx].faca014,g_faca_d[g_detail_idx].faca015, 
                  g_faca_d[g_detail_idx].faca016,g_faca_d[g_detail_idx].faca018,g_faca_d[g_detail_idx].faca024, 
                  g_faca2_d[g_detail_idx].faca019,g_faca2_d[g_detail_idx].faca036,g_faca2_d[g_detail_idx].faca025, 
                  g_faca2_d[g_detail_idx].faca026,g_faca2_d[g_detail_idx].faca027,g_faca2_d[g_detail_idx].faca028, 
                  g_faca2_d[g_detail_idx].faca029,g_faca2_d[g_detail_idx].faca030,g_faca2_d[g_detail_idx].faca031, 
                  g_faca2_d[g_detail_idx].faca032,g_faca2_d[g_detail_idx].faca033,g_faca2_d[g_detail_idx].faca034, 
                  g_faca2_d[g_detail_idx].faca052,g_faca2_d[g_detail_idx].faca053,g_faca2_d[g_detail_idx].faca054, 
                  g_faca2_d[g_detail_idx].faca065,g_faca2_d[g_detail_idx].faca055,g_faca2_d[g_detail_idx].faca056, 
                  g_faca2_d[g_detail_idx].faca057,g_faca2_d[g_detail_idx].faca058,g_faca2_d[g_detail_idx].faca059, 
                  g_faca2_d[g_detail_idx].faca060,g_faca2_d[g_detail_idx].faca061,g_faca2_d[g_detail_idx].faca062, 
                  g_faca2_d[g_detail_idx].faca063,g_faca2_d[g_detail_idx].faca064,g_faca5_d[g_detail_idx].faca043, 
                  g_faca5_d[g_detail_idx].faca038,g_faca5_d[g_detail_idx].faca039,g_faca5_d[g_detail_idx].faca040, 
                  g_faca5_d[g_detail_idx].faca041,g_faca5_d[g_detail_idx].faca042,g_faca5_d[g_detail_idx].faca044, 
                  g_faca5_d[g_detail_idx].faca050,g_faca5_d[g_detail_idx].faca045,g_faca5_d[g_detail_idx].faca046, 
                  g_faca5_d[g_detail_idx].faca047,g_faca5_d[g_detail_idx].faca048,g_faca5_d[g_detail_idx].faca049, 
                  g_faca5_d[g_detail_idx].faca051) 
         WHERE facaent = g_enterprise AND facald = ps_keys_bak[1] AND facadocno = ps_keys_bak[2] AND facaseq = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "faca_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "faca_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL afat510_faca_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
      
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
   
   
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "xrcd_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update2"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL afat510_xrcd_t_mask_restore('restore_mask_o')
               
      UPDATE xrcd_t 
         SET (xrcdld,xrcddocno,
              xrcdseq,xrcdseq2,xrcd007
              ,xrcd002,xrcd003,xrcd006,xrcd103,xrcd104,xrcd105,xrcd113,xrcd114,xrcd115,xrcd009) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4],ps_keys[5]
              ,g_faca3_d[g_detail_idx].xrcd002,g_faca3_d[g_detail_idx].xrcd003,g_faca3_d[g_detail_idx].xrcd006, 
                  g_faca3_d[g_detail_idx].xrcd103,g_faca3_d[g_detail_idx].xrcd104,g_faca3_d[g_detail_idx].xrcd105, 
                  g_faca3_d[g_detail_idx].xrcd113,g_faca3_d[g_detail_idx].xrcd114,g_faca3_d[g_detail_idx].xrcd115, 
                  g_faca3_d[g_detail_idx].xrcd009) 
         WHERE xrcdent = g_enterprise AND xrcdld = ps_keys_bak[1] AND xrcddocno = ps_keys_bak[2] AND xrcdseq = ps_keys_bak[3] AND xrcdseq2 = ps_keys_bak[4] AND xrcd007 = ps_keys_bak[5]
      #add-point:update_b段修改中 name="update_b.m_update2"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xrcd_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xrcd_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL afat510_xrcd_t_mask_restore('restore_mask_n')
 
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
 
{<section id="afat510.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION afat510_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="afat510.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION afat510_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="afat510.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION afat510_lock_b(ps_table,ps_page)
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
   #CALL afat510_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1','2','4',"
   #僅鎖定自身table
   LET ls_group = "faca_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN afat510_bcl USING g_enterprise,
                                       g_fabg_m.fabgld,g_fabg_m.fabgdocno,g_faca_d[g_detail_idx].facaseq  
                                               
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "afat510_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
                                    
   #鎖定整組table
   #LET ls_group = "'3',"
   #僅鎖定自身table
   LET ls_group = "xrcd_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN afat510_bcl2 USING g_enterprise,
                                             g_fabg_m.fabgld,g_fabg_m.fabgdocno,g_faca3_d[g_detail_idx].xrcdseq, 
                                                 g_faca3_d[g_detail_idx].xrcdseq2,g_faca3_d[g_detail_idx].xrcd007 
 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "afat510_bcl2:",SQLERRMESSAGE 
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
 
{<section id="afat510.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION afat510_unlock_b(ps_table,ps_page)
   #add-point:unlock_b段define(客製用) name="unlock_b.define_customerization"
   
   #end add-point  
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:unlock_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="unlock_b.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="unlock_b.pre_function"
   
   #end add-point
    
   LET ls_group = "'1','2','4',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE afat510_bcl
   END IF
   
   LET ls_group = "'3',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE afat510_bcl2
   END IF
 
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="afat510.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION afat510_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("fabgdocno,fabgld",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("fabgld,fabgdocno",TRUE)
      CALL cl_set_comp_entry("fabgdocdt",TRUE)
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
 
{<section id="afat510.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION afat510_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   DEFINE l_fabx004    LIKE fabx_t.fabx004
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("fabgld,fabgdocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("fabgdocno,fabgld",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("fabgdocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   SELECT fabx004 INTO l_fabx004
     FROM fabx_t
    WHERE fabxent = g_enterprise
      AND fabx001 = '32'
      AND fabx010 = g_fabg_m.fabg017

   IF g_fabg_m.fabg018 <> l_fabx004 THEN 
      CALL cl_set_comp_entry("fabg013",TRUE)
   ELSE
      CALL cl_set_comp_entry("fabg013",FALSE)
   END IF
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="afat510.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION afat510_set_entry_b(p_cmd)
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
 
{<section id="afat510.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION afat510_set_no_entry_b(p_cmd)
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
 
{<section id="afat510.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION afat510_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="afat510.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION afat510_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:2)
   IF g_fabg_m.fabgstus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF



   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="afat510.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION afat510_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="afat510.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION afat510_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="afat510.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION afat510_default_search()
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
   
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " fabgld = '", g_argv[03], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[04]) THEN
      LET ls_wc = ls_wc, " fabgdocno = '", g_argv[04], "' AND "
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
               WHEN la_wc[li_idx].tableid = "fabg_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "faca_t" 
                  LET g_wc2_table1 = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "xrcd_t" 
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
 
{<section id="afat510.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION afat510_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_success    LIKE type_t.num5
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_fabg_m.fabgld IS NULL
      OR g_fabg_m.fabgdocno IS NULL
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN afat510_cl USING g_enterprise,g_fabg_m.fabgld,g_fabg_m.fabgdocno
   IF STATUS THEN
      CLOSE afat510_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN afat510_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE afat510_master_referesh USING g_fabg_m.fabgld,g_fabg_m.fabgdocno INTO g_fabg_m.fabgsite,g_fabg_m.fabg001, 
       g_fabg_m.fabgld,g_fabg_m.fabgcomp,g_fabg_m.fabg005,g_fabg_m.fabgdocno,g_fabg_m.fabgdocdt,g_fabg_m.fabg010, 
       g_fabg_m.fabg018,g_fabg_m.fabg017,g_fabg_m.fabg006,g_fabg_m.fabg007,g_fabg_m.fabg013,g_fabg_m.fabg014, 
       g_fabg_m.fabg015,g_fabg_m.fabg016,g_fabg_m.fabg012,g_fabg_m.fabg008,g_fabg_m.fabgstus,g_fabg_m.fabgownid, 
       g_fabg_m.fabgowndp,g_fabg_m.fabgcrtid,g_fabg_m.fabgcrtdp,g_fabg_m.fabgcrtdt,g_fabg_m.fabgmodid, 
       g_fabg_m.fabgmoddt,g_fabg_m.fabgcnfid,g_fabg_m.fabgcnfdt,g_fabg_m.fabgpstid,g_fabg_m.fabgpstdt, 
       g_fabg_m.fabgsite_desc,g_fabg_m.fabg001_desc,g_fabg_m.fabgld_desc,g_fabg_m.fabg010_desc,g_fabg_m.fabg018_desc, 
       g_fabg_m.fabg006_desc,g_fabg_m.fabg007_desc,g_fabg_m.fabgownid_desc,g_fabg_m.fabgowndp_desc,g_fabg_m.fabgcrtid_desc, 
       g_fabg_m.fabgcrtdp_desc,g_fabg_m.fabgmodid_desc,g_fabg_m.fabgcnfid_desc,g_fabg_m.fabgpstid_desc 
 
   
 
   #檢查是否允許此動作
   IF NOT afat510_action_chk() THEN
      CLOSE afat510_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_fabg_m.fabgsite,g_fabg_m.fabgsite_desc,g_fabg_m.fabg001,g_fabg_m.fabg001_desc,g_fabg_m.fabgld, 
       g_fabg_m.fabgld_desc,g_fabg_m.fabgcomp,g_fabg_m.fabg005,g_fabg_m.fabgdocno,g_fabg_m.fabgdocdt, 
       g_fabg_m.fabg010,g_fabg_m.fabg010_desc,g_fabg_m.fabg018,g_fabg_m.fabg018_desc,g_fabg_m.fabg017, 
       g_fabg_m.fabg006,g_fabg_m.fabg006_desc,g_fabg_m.fabg007,g_fabg_m.fabg007_desc,g_fabg_m.fabg013, 
       g_fabg_m.fabg014,g_fabg_m.fabg015,g_fabg_m.fabg016,g_fabg_m.fabg012,g_fabg_m.fabg008,g_fabg_m.fabgstus, 
       g_fabg_m.fabgownid,g_fabg_m.fabgownid_desc,g_fabg_m.fabgowndp,g_fabg_m.fabgowndp_desc,g_fabg_m.fabgcrtid, 
       g_fabg_m.fabgcrtid_desc,g_fabg_m.fabgcrtdp,g_fabg_m.fabgcrtdp_desc,g_fabg_m.fabgcrtdt,g_fabg_m.fabgmodid, 
       g_fabg_m.fabgmodid_desc,g_fabg_m.fabgmoddt,g_fabg_m.fabgcnfid,g_fabg_m.fabgcnfid_desc,g_fabg_m.fabgcnfdt, 
       g_fabg_m.fabgpstid,g_fabg_m.fabgpstid_desc,g_fabg_m.fabgpstdt
 
   CASE g_fabg_m.fabgstus
      WHEN "A"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
      WHEN "D"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
      WHEN "R"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
      WHEN "W"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
      WHEN "Z"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/unposted.png")
      WHEN "S"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/posted.png")
      WHEN "X"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
      
   END CASE
 
   #add-point:資料刷新後 name="statechange.after_refresh"
   IF NOT cl_null(g_fabg_m.fabgdocdt) THEN 
      IF NOT s_afa_date_chk('',g_fabg_m.fabgcomp,g_fabg_m.fabgdocdt) THEN 
         CLOSE afat510_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF 
   END IF 
   
   CALL cl_err_collect_init()
   #end add-point
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_fabg_m.fabgstus
            
            WHEN "A"
               HIDE OPTION "approved"
            WHEN "D"
               HIDE OPTION "withdraw"
            WHEN "N"
               HIDE OPTION "unconfirmed"
            WHEN "R"
               HIDE OPTION "rejection"
            WHEN "W"
               HIDE OPTION "signing"
            WHEN "Y"
               HIDE OPTION "confirmed"
            WHEN "Z"
               HIDE OPTION "unposted"
            WHEN "S"
               HIDE OPTION "posted"
            WHEN "X"
               HIDE OPTION "invalid"
         END CASE
     
      #add-point:menu前 name="statechange.before_menu"
      HIDE OPTION "approved"
      HIDE OPTION "withdraw"
      HIDE OPTION "rejection"
      HIDE OPTION "signing"
      CALL cl_set_act_visible("unconfirmed,invalid,confirmed,posted,unposted",TRUE)
      CASE g_fabg_m.fabgstus
         WHEN "X"
            CALL cl_set_act_visible("unconfirmed,confirmed,invalid,posted,unposted",FALSE)
            CLOSE afat510_cl
            CALL s_transaction_end('N','0')
            RETURN
         WHEN "Y"
            CALL cl_set_act_visible("invalid,confirmed,unposted",FALSE)
         WHEN "N"
            CALL cl_set_act_visible("unconfirmed,posted,unposted",FALSE)
         WHEN "S"
            CALL cl_set_act_visible("unconfirmed,invalid,confirmed,posted",FALSE)
      END CASE
      #end add-point
      
      #應用 a36 樣板自動產生(Version:5)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT afat510_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE afat510_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT afat510_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE afat510_cl
            RETURN
         END IF
 
 
 
	  
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
      ON ACTION unconfirmed
         IF cl_auth_chk_act("unconfirmed") THEN
            LET lc_state = "N"
            #add-point:action控制 name="statechange.unconfirmed"
            CALL s_afat510_unconf_chk(g_fabg_m.fabgld,g_fabg_m.fabgdocno) RETURNING l_success
            
            IF l_success = TRUE THEN 
               CALL s_afat510_unconfirm(g_fabg_m.fabgld,g_fabg_m.fabgdocno) RETURNING l_success
            END IF
            
            IF l_success = FALSE THEN 
               CALL cl_err_collect_show()
               CALL s_transaction_end('N','0') 
               RETURN
            ELSE
               CALL cl_err_collect_show()  
               CALL s_transaction_end('Y','0')
            END IF
            #end add-point
         END IF
         EXIT MENU
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
      ON ACTION confirmed
         IF cl_auth_chk_act("confirmed") THEN
            LET lc_state = "Y"
            #add-point:action控制 name="statechange.confirmed"
            CALL s_afat510_conf_chk(g_fabg_m.fabgld,g_fabg_m.fabgdocno) RETURNING l_success
            
            IF l_success = TRUE THEN 
               CALL s_afat510_confirm(g_fabg_m.fabgld,g_fabg_m.fabgdocno) RETURNING l_success
            END IF
            
            IF l_success = FALSE THEN 
               CALL cl_err_collect_show()
               CALL s_transaction_end('N','0') 
               RETURN
            ELSE
               CALL cl_err_collect_show()  
               CALL s_transaction_end('Y','0')
            END IF
            #end add-point
         END IF
         EXIT MENU
      ON ACTION unposted
         IF cl_auth_chk_act("unposted") THEN
            LET lc_state = "Z"
            #add-point:action控制 name="statechange.unposted"
            LET lc_state = "Y"
            
            CALL s_afat510_unpost_chk(g_fabg_m.fabgld,g_fabg_m.fabgdocno) RETURNING l_success
            
            IF l_success = TRUE THEN 
               CALL s_afat510_unpost(g_fabg_m.fabgld,g_fabg_m.fabgdocno) RETURNING l_success
            END IF
            
            IF l_success = FALSE THEN 
               CALL cl_err_collect_show()
               CALL s_transaction_end('N','0') 
               RETURN
            ELSE
               CALL cl_err_collect_show()  
               CALL s_transaction_end('Y','0')
            END IF
            #end add-point
         END IF
         EXIT MENU
      ON ACTION posted
         IF cl_auth_chk_act("posted") THEN
            LET lc_state = "S"
            #add-point:action控制 name="statechange.posted"
            CALL s_afat510_post(g_fabg_m.fabgld,g_fabg_m.fabgdocno) RETURNING l_success 
            
            IF l_success = FALSE THEN 
               CALL cl_err_collect_show()
               CALL s_transaction_end('N','0') 
               RETURN
            ELSE
               CALL cl_err_collect_show()  
               CALL s_transaction_end('Y','0')
            END IF
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
   IF (lc_state <> "A" 
      AND lc_state <> "D"
      AND lc_state <> "N"
      AND lc_state <> "R"
      AND lc_state <> "W"
      AND lc_state <> "Y"
      AND lc_state <> "Z"
      AND lc_state <> "S"
      AND lc_state <> "X"
      ) OR 
      g_fabg_m.fabgstus = lc_state OR cl_null(lc_state) THEN
      CLOSE afat510_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   
   #end add-point
   
   LET g_fabg_m.fabgmodid = g_user
   LET g_fabg_m.fabgmoddt = cl_get_current()
   LET g_fabg_m.fabgstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE fabg_t 
      SET (fabgstus,fabgmodid,fabgmoddt) 
        = (g_fabg_m.fabgstus,g_fabg_m.fabgmodid,g_fabg_m.fabgmoddt)     
    WHERE fabgent = g_enterprise AND fabgld = g_fabg_m.fabgld
      AND fabgdocno = g_fabg_m.fabgdocno
    
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
   ELSE
      CASE lc_state
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "Z"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unposted.png")
         WHEN "S"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/posted.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
    
      #撈取異動後的資料
      EXECUTE afat510_master_referesh USING g_fabg_m.fabgld,g_fabg_m.fabgdocno INTO g_fabg_m.fabgsite, 
          g_fabg_m.fabg001,g_fabg_m.fabgld,g_fabg_m.fabgcomp,g_fabg_m.fabg005,g_fabg_m.fabgdocno,g_fabg_m.fabgdocdt, 
          g_fabg_m.fabg010,g_fabg_m.fabg018,g_fabg_m.fabg017,g_fabg_m.fabg006,g_fabg_m.fabg007,g_fabg_m.fabg013, 
          g_fabg_m.fabg014,g_fabg_m.fabg015,g_fabg_m.fabg016,g_fabg_m.fabg012,g_fabg_m.fabg008,g_fabg_m.fabgstus, 
          g_fabg_m.fabgownid,g_fabg_m.fabgowndp,g_fabg_m.fabgcrtid,g_fabg_m.fabgcrtdp,g_fabg_m.fabgcrtdt, 
          g_fabg_m.fabgmodid,g_fabg_m.fabgmoddt,g_fabg_m.fabgcnfid,g_fabg_m.fabgcnfdt,g_fabg_m.fabgpstid, 
          g_fabg_m.fabgpstdt,g_fabg_m.fabgsite_desc,g_fabg_m.fabg001_desc,g_fabg_m.fabgld_desc,g_fabg_m.fabg010_desc, 
          g_fabg_m.fabg018_desc,g_fabg_m.fabg006_desc,g_fabg_m.fabg007_desc,g_fabg_m.fabgownid_desc, 
          g_fabg_m.fabgowndp_desc,g_fabg_m.fabgcrtid_desc,g_fabg_m.fabgcrtdp_desc,g_fabg_m.fabgmodid_desc, 
          g_fabg_m.fabgcnfid_desc,g_fabg_m.fabgpstid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_fabg_m.fabgsite,g_fabg_m.fabgsite_desc,g_fabg_m.fabg001,g_fabg_m.fabg001_desc, 
          g_fabg_m.fabgld,g_fabg_m.fabgld_desc,g_fabg_m.fabgcomp,g_fabg_m.fabg005,g_fabg_m.fabgdocno, 
          g_fabg_m.fabgdocdt,g_fabg_m.fabg010,g_fabg_m.fabg010_desc,g_fabg_m.fabg018,g_fabg_m.fabg018_desc, 
          g_fabg_m.fabg017,g_fabg_m.fabg006,g_fabg_m.fabg006_desc,g_fabg_m.fabg007,g_fabg_m.fabg007_desc, 
          g_fabg_m.fabg013,g_fabg_m.fabg014,g_fabg_m.fabg015,g_fabg_m.fabg016,g_fabg_m.fabg012,g_fabg_m.fabg008, 
          g_fabg_m.fabgstus,g_fabg_m.fabgownid,g_fabg_m.fabgownid_desc,g_fabg_m.fabgowndp,g_fabg_m.fabgowndp_desc, 
          g_fabg_m.fabgcrtid,g_fabg_m.fabgcrtid_desc,g_fabg_m.fabgcrtdp,g_fabg_m.fabgcrtdp_desc,g_fabg_m.fabgcrtdt, 
          g_fabg_m.fabgmodid,g_fabg_m.fabgmodid_desc,g_fabg_m.fabgmoddt,g_fabg_m.fabgcnfid,g_fabg_m.fabgcnfid_desc, 
          g_fabg_m.fabgcnfdt,g_fabg_m.fabgpstid,g_fabg_m.fabgpstid_desc,g_fabg_m.fabgpstdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   CALL afat510_show()
   #end add-point  
 
   CLOSE afat510_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL afat510_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="afat510.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION afat510_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_faca_d.getLength() THEN
         LET g_detail_idx = g_faca_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_faca_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_faca_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_faca2_d.getLength() THEN
         LET g_detail_idx = g_faca2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_faca2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_faca2_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 3 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx > g_faca3_d.getLength() THEN
         LET g_detail_idx = g_faca3_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_faca3_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_faca3_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 4 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail5")
      IF g_detail_idx > g_faca5_d.getLength() THEN
         LET g_detail_idx = g_faca5_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_faca5_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_faca5_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="afat510.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION afat510_b_fill2(pi_idx)
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
   
   CALL afat510_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="afat510.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION afat510_fill_chk(ps_idx)
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
 
{<section id="afat510.status_show" >}
PRIVATE FUNCTION afat510_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="afat510.mask_functions" >}
&include "erp/afa/afat510_mask.4gl"
 
{</section>}
 
{<section id="afat510.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION afat510_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
   LET g_wc2_table2 = " 1=1"
 
 
   CALL afat510_show()
   CALL afat510_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_fabg_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_faca_d))
   CALL cl_bpm_set_detail_data("s_detail2", util.JSONArray.fromFGL(g_faca2_d))
   CALL cl_bpm_set_detail_data("s_detail3", util.JSONArray.fromFGL(g_faca3_d))
   CALL cl_bpm_set_detail_data("s_detail5", util.JSONArray.fromFGL(g_faca5_d))
 
 
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
   #CALL afat510_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL afat510_ui_headershow()
   CALL afat510_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION afat510_draw_out()
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
   CALL afat510_ui_headershow()  
   CALL afat510_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="afat510.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION afat510_set_pk_array()
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
   LET g_pk_array[1].values = g_fabg_m.fabgld
   LET g_pk_array[1].column = 'fabgld'
   LET g_pk_array[2].values = g_fabg_m.fabgdocno
   LET g_pk_array[2].column = 'fabgdocno'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="afat510.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="afat510.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION afat510_msgcentre_notify(lc_state)
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
   CALL afat510_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_fabg_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="afat510.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION afat510_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="afat510.other_function" readonly="Y" >}
# 抓取账套信息
PRIVATE FUNCTION afat510_get_glaa()
   #161215-00044#1---modify----begin-----------------
   #SELECT * INTO g_glaa.* 
   SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,
          glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,glaa011,
          glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,glaa023,
          glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,glaa113,glaa120,glaa121,
          glaa122,glaa027,glaa130,glaa131,glaa132,glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,
          glaa140,glaa123,glaa124,glaa028 INTO g_glaa.* 
   #161215-00044#1---modify----end-----------------
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald = g_fabg_m.fabgld
      
   LET g_fabg_m.fabgcomp = g_glaa.glaacomp
   
   SELECT ooef019 INTO g_ooef019
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_glaa.glaacomp

END FUNCTION
# 默认值
PRIVATE FUNCTION afat510_defalut()
   DEFINE l_ooef204            LIKE ooef_t.ooef204
   
   LET g_fabg_m.fabg001 = g_user
   CALL s_desc_get_person_desc(g_fabg_m.fabg001) RETURNING g_fabg_m.fabg001_desc
   DISPLAY BY NAME g_fabg_m.fabg001_desc
   
   LET g_fabg_m.fabgdocdt = g_today
    
   #取得預設的資金中心,因新增階段的時候,並不會知道site,所以以登入人員做為依據
   CALL s_fin_get_account_center('',g_user,'5',g_today) RETURNING g_sub_success,g_fabg_m.fabgsite,g_errno
   CALL s_desc_get_department_desc(g_fabg_m.fabgsite) RETURNING g_fabg_m.fabgsite_desc
   DISPLAY BY NAME g_fabg_m.fabgsite_desc
   
   CALL s_ld_bookno() RETURNING g_sub_success,g_fabg_m.fabgld
   CALL s_desc_get_ld_desc(g_fabg_m.fabgld) RETURNING g_fabg_m.fabgld_desc
   DISPLAY BY NAME g_fabg_m.fabgld_desc
   
   #所屬法人
   SELECT ooef017 INTO g_fabg_m.fabgcomp
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_fabg_m.fabgsite
      AND ooefstus = 'Y'  
   
   #所有组织
   LET g_fabg_m.fabg010 = g_site
   CALL s_desc_get_department_desc(g_fabg_m.fabg010) RETURNING g_fabg_m.fabg010_desc
   DISPLAY BY NAME g_fabg_m.fabg010_desc
   
   SELECT ooef204 INTO l_ooef204
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site
   
   #核算组织
   IF l_ooef204 = 'Y' THEN 
      LET g_fabg_m.fabg018 = g_site
      CALL s_desc_get_department_desc(g_fabg_m.fabg018) RETURNING g_fabg_m.fabg018_desc
      DISPLAY BY NAME g_fabg_m.fabg018_desc
   ELSE
      LET g_fabg_m.fabg018 = ''
   END IF

   CALL afat510_get_glaa()
   
   IF cl_null(g_fabg_m.fabg015) THEN    
      LET g_fabg_m.fabg015 = g_glaa.glaa001
      LET g_fabg_m.fabg016 = 1
   END IF
   
   CALL afat510_visible()
   
   IF NOT cl_null(g_argv[02]) AND g_argv[01] = 'N' THEN 
      LET g_fabg_m.fabg017 = g_argv[02]
      LET g_fabg_m.fabgld = g_argv[03]
      CALL afat510_fabg017_get()
   END IF
END FUNCTION
# 其他本位币显示
PRIVATE FUNCTION afat510_visible()
   CALL cl_set_comp_visible('page_6',TRUE) 
   IF g_glaa.glaa015 = 'N' AND g_glaa.glaa019 = 'Y' THEN 
      CALL cl_set_comp_visible('faca038,faca039,faca040,faca041,faca042,faca043,faca044',FALSE)
      CALL cl_set_comp_visible('faca045,faca046,faca047,faca048,faca049,faca050,faca051',TRUE)
   END IF
   
   IF g_glaa.glaa015 = 'Y' AND g_glaa.glaa019 = 'N' THEN 
      CALL cl_set_comp_visible('faca038,faca039,faca040,faca041,faca042,faca043,faca044',TRUE)
      CALL cl_set_comp_visible('faca045,faca046,faca047,faca048,faca049,faca050,faca051',FALSE)
   END IF
   
   IF g_glaa.glaa015 = 'Y' AND g_glaa.glaa019 = 'Y' THEN 
      CALL cl_set_comp_visible('faca038,faca039,faca040,faca041,faca042,faca043,faca044',TRUE)
      CALL cl_set_comp_visible('faca045,faca046,faca047,faca048,faca049,faca050,faca051',TRUE)
   END IF
   
   IF g_glaa.glaa015 = 'N' AND g_glaa.glaa019 = 'N' THEN 
      CALL cl_set_comp_visible('page_6',FALSE) 
   END IF
END FUNCTION
# 调拨流水码带值
PRIVATE FUNCTION afat510_fabg017_get()
   DEFINE l_fabx004          LIKE fabx_t.fabx004
   DEFINE l_ooef024          LIKE ooef_t.ooef024
   
   IF cl_null(g_fabg_m.fabg017) THEN 
      RETURN 
   END IF
   
   SELECT fabx006,fabx007,fabx004
     INTO g_fabg_m.fabg010,g_fabg_m.fabg018,l_fabx004
     FROM fabx_t
    WHERE fabxent = g_enterprise
      AND fabx001 = '32'
      AND fabx010 = g_fabg_m.fabg017

   SELECT ooef024 INTO l_ooef024
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_fabg_m.fabg018

   IF g_fabg_m.fabg018 <> l_fabx004 THEN 
      CALL cl_set_comp_entry("fabg013",TRUE)
      
      SELECT pmab084 INTO g_fabg_m.fabg013
        FROM pmab_t
       WHERE pmabent = g_enterprise
         AND pmabsite = 'ALL'
         AND pmab001 = l_ooef024
         
      SELECT oodb006 INTO g_fabg_m.fabg014
        FROM oodb_t
       WHERE oodbent = g_enterprise
         AND oodb001 = g_ooef019
         AND oodb002 = g_fabg_m.fabg013
   ELSE
      CALL cl_set_comp_entry("fabg013",FALSE)
      LET g_fabg_m.fabg013 = ''
      LET g_fabg_m.fabg014 = ''
      LET g_fabg_m.fabg012 = 'F'
   END IF
   
   LET g_fabg_m.fabg006 = l_ooef024
   LET g_fabg_m.fabg007 = g_fabg_m.fabg006
   CALL afat510_fabg007_chk()
   IF NOT cl_null(g_errno) THEN 
      LET g_fabg_m.fabg007 = ''
   END IF
   
   CALL s_desc_get_trading_partner_abbr_desc(g_fabg_m.fabg006) RETURNING g_fabg_m.fabg006_desc
   CALL s_desc_get_trading_partner_abbr_desc(g_fabg_m.fabg007) RETURNING g_fabg_m.fabg007_desc   
      
   CALL s_desc_get_department_desc(g_fabg_m.fabg010) RETURNING g_fabg_m.fabg010_desc
   CALL s_desc_get_department_desc(g_fabg_m.fabg018) RETURNING g_fabg_m.fabg018_desc
   
   DISPLAY g_fabg_m.fabg010,g_fabg_m.fabg018,g_fabg_m.fabg010_desc,g_fabg_m.fabg018_desc,
           g_fabg_m.fabg013,g_fabg_m.fabg014,g_fabg_m.fabg006,g_fabg_m.fabg006_desc,
           g_fabg_m.fabg007,g_fabg_m.fabg007_desc
        TO fabg010,fabg018,fabg010_desc,fabg018_desc,fabg013,fabg014,
           fabg006,fabg006_desc,fabg007,fabg007_desc
END FUNCTION
# 产生单身资料
PRIVATE FUNCTION afat510_ins_faca()
   DEFINE l_curr              LIKE glaa_t.glaa001
   DEFINE l_docno             LIKE fabx_t.fabxdocno   
   DEFINE l_sql               STRING
   DEFINE l_faah017           LIKE faah_t.faah017
   DEFINE r_xrcd123           LIKE xrcd_t.xrcd113
   DEFINE r_xrcd124           LIKE xrcd_t.xrcd114
   DEFINE r_xrcd125           LIKE xrcd_t.xrcd115
   DEFINE r_xrcd133           LIKE xrcd_t.xrcd113
   DEFINE r_xrcd134           LIKE xrcd_t.xrcd114
   DEFINE r_xrcd135           LIKE xrcd_t.xrcd115
   DEFINE l_sfin9017          LIKE type_t.chr10
   #161215-00044#2---modify----begin-----------------
   #DEFINE l_fabv              RECORD LIKE fabv_t.*
   #DEFINE l_faca              RECORD LIKE faca_t.*
   #DEFINE l_faaj              RECORD LIKE faaj_t.*
   DEFINE l_fabv RECORD  #資產調撥單身檔
       fabvent LIKE fabv_t.fabvent, #企業編碼
       fabvdocno LIKE fabv_t.fabvdocno, #異動單號
       fabvseq LIKE fabv_t.fabvseq, #項次
       fabv001 LIKE fabv_t.fabv001, #來源單號
       fabv002 LIKE fabv_t.fabv002, #來源項次
       fabv003 LIKE fabv_t.fabv003, #財產編號
       fabv004 LIKE fabv_t.fabv004, #附號
       fabv005 LIKE fabv_t.fabv005, #卡片編號
       fabv006 LIKE fabv_t.fabv006, #名稱
       fabv007 LIKE fabv_t.fabv007, #規格
       fabv008 LIKE fabv_t.fabv008, #主要類型
       fabv009 LIKE fabv_t.fabv009, #存放位置
       fabv010 LIKE fabv_t.fabv010, #調撥數量
       fabv011 LIKE fabv_t.fabv011, #調撥成本
       fabv012 LIKE fabv_t.fabv012, #調撥累折
       fabv013 LIKE fabv_t.fabv013, #調撥減值準備
       fabv014 LIKE fabv_t.fabv014, #調撥預留殘值
       fabv015 LIKE fabv_t.fabv015, #調撥價格差異
       fabv016 LIKE fabv_t.fabv016, #幣別
       fabv017 LIKE fabv_t.fabv017, #本位幣二成本
       fabv018 LIKE fabv_t.fabv018, #本位幣二累折
       fabv019 LIKE fabv_t.fabv019, #本位幣二減值準備
       fabv020 LIKE fabv_t.fabv020, #本位幣二預留殘值
       fabv021 LIKE fabv_t.fabv021, #本位幣二價格差異
       fabv022 LIKE fabv_t.fabv022, #本位幣二幣別
       fabv023 LIKE fabv_t.fabv023, #本位幣二匯率
       fabv024 LIKE fabv_t.fabv024, #本位幣三成本
       fabv025 LIKE fabv_t.fabv025, #本位幣三累折
       fabv026 LIKE fabv_t.fabv026, #本位幣三減值準備
       fabv027 LIKE fabv_t.fabv027, #本位幣三預留殘值
       fabv028 LIKE fabv_t.fabv028, #本位幣三價格差異
       fabv029 LIKE fabv_t.fabv029, #本位幣三幣別
       fabv030 LIKE fabv_t.fabv030, #本位幣三匯率
       fabv031 LIKE fabv_t.fabv031, #剩餘淨值
       fabvud001 LIKE fabv_t.fabvud001, #自定義欄位(文字)001
       fabvud002 LIKE fabv_t.fabvud002, #自定義欄位(文字)002
       fabvud003 LIKE fabv_t.fabvud003, #自定義欄位(文字)003
       fabvud004 LIKE fabv_t.fabvud004, #自定義欄位(文字)004
       fabvud005 LIKE fabv_t.fabvud005, #自定義欄位(文字)005
       fabvud006 LIKE fabv_t.fabvud006, #自定義欄位(文字)006
       fabvud007 LIKE fabv_t.fabvud007, #自定義欄位(文字)007
       fabvud008 LIKE fabv_t.fabvud008, #自定義欄位(文字)008
       fabvud009 LIKE fabv_t.fabvud009, #自定義欄位(文字)009
       fabvud010 LIKE fabv_t.fabvud010, #自定義欄位(文字)010
       fabvud011 LIKE fabv_t.fabvud011, #自定義欄位(數字)011
       fabvud012 LIKE fabv_t.fabvud012, #自定義欄位(數字)012
       fabvud013 LIKE fabv_t.fabvud013, #自定義欄位(數字)013
       fabvud014 LIKE fabv_t.fabvud014, #自定義欄位(數字)014
       fabvud015 LIKE fabv_t.fabvud015, #自定義欄位(數字)015
       fabvud016 LIKE fabv_t.fabvud016, #自定義欄位(數字)016
       fabvud017 LIKE fabv_t.fabvud017, #自定義欄位(數字)017
       fabvud018 LIKE fabv_t.fabvud018, #自定義欄位(數字)018
       fabvud019 LIKE fabv_t.fabvud019, #自定義欄位(數字)019
       fabvud020 LIKE fabv_t.fabvud020, #自定義欄位(數字)020
       fabvud021 LIKE fabv_t.fabvud021, #自定義欄位(日期時間)021
       fabvud022 LIKE fabv_t.fabvud022, #自定義欄位(日期時間)022
       fabvud023 LIKE fabv_t.fabvud023, #自定義欄位(日期時間)023
       fabvud024 LIKE fabv_t.fabvud024, #自定義欄位(日期時間)024
       fabvud025 LIKE fabv_t.fabvud025, #自定義欄位(日期時間)025
       fabvud026 LIKE fabv_t.fabvud026, #自定義欄位(日期時間)026
       fabvud027 LIKE fabv_t.fabvud027, #自定義欄位(日期時間)027
       fabvud028 LIKE fabv_t.fabvud028, #自定義欄位(日期時間)028
       fabvud029 LIKE fabv_t.fabvud029, #自定義欄位(日期時間)029
       fabvud030 LIKE fabv_t.fabvud030  #自定義欄位(日期時間)030
       END RECORD

   DEFINE l_faca RECORD  #調撥帳務單身檔
       facaent LIKE faca_t.facaent, #企業代碼
       facald LIKE faca_t.facald, #帳套
       facadocno LIKE faca_t.facadocno, #單號
       facaseq LIKE faca_t.facaseq, #項次
       faca001 LIKE faca_t.faca001, #來源單號
       faca002 LIKE faca_t.faca002, #來源項次
       faca003 LIKE faca_t.faca003, #財產編號
       faca004 LIKE faca_t.faca004, #附號
       faca005 LIKE faca_t.faca005, #卡片編號
       faca006 LIKE faca_t.faca006, #單位
       faca007 LIKE faca_t.faca007, #单价
       faca008 LIKE faca_t.faca008, #調撥數量
       faca009 LIKE faca_t.faca009, #調撥成本
       faca010 LIKE faca_t.faca010, #稅別
       faca011 LIKE faca_t.faca011, #原幣未稅金額
       faca012 LIKE faca_t.faca012, #原幣稅額
       faca013 LIKE faca_t.faca013, #原幣應收金額
       faca014 LIKE faca_t.faca014, #本幣未稅金額
       faca015 LIKE faca_t.faca015, #本幣稅額
       faca016 LIKE faca_t.faca016, #本幣應收金額
       faca017 LIKE faca_t.faca017, #稅率
       faca018 LIKE faca_t.faca018, #處置損益
       faca019 LIKE faca_t.faca019, #異動科目
       faca020 LIKE faca_t.faca020, #累折科目
       faca021 LIKE faca_t.faca021, #減值準備科目
       faca022 LIKE faca_t.faca022, #資產科目
       faca023 LIKE faca_t.faca023, #應收/付帳款科目
       faca024 LIKE faca_t.faca024, #稅額科目
       faca025 LIKE faca_t.faca025, #營運據點
       faca026 LIKE faca_t.faca026, #部門
       faca027 LIKE faca_t.faca027, #利潤/成本中心
       faca028 LIKE faca_t.faca028, #區域
       faca029 LIKE faca_t.faca029, #交易客商
       faca030 LIKE faca_t.faca030, #帳款客商
       faca031 LIKE faca_t.faca031, #客群
       faca032 LIKE faca_t.faca032, #人員
       faca033 LIKE faca_t.faca033, #專案編號
       faca034 LIKE faca_t.faca034, #WBS
       faca035 LIKE faca_t.faca035, #帳款編號
       faca036 LIKE faca_t.faca036, #摘要
       faca037 LIKE faca_t.faca037, #應收/付帳款單號
       faca038 LIKE faca_t.faca038, #本位幣二幣別
       faca039 LIKE faca_t.faca039, #本位幣二匯率
       faca040 LIKE faca_t.faca040, #本位幣二未稅金額
       faca041 LIKE faca_t.faca041, #本位幣二稅額
       faca042 LIKE faca_t.faca042, #本位幣二應收金額
       faca043 LIKE faca_t.faca043, #本位幣二調撥成本
       faca044 LIKE faca_t.faca044, #本位幣二處置損益
       faca045 LIKE faca_t.faca045, #本位幣三幣別
       faca046 LIKE faca_t.faca046, #本位幣三匯率
       faca047 LIKE faca_t.faca047, #本位幣三未稅金額
       faca048 LIKE faca_t.faca048, #本位幣三稅額
       faca049 LIKE faca_t.faca049, #本位幣三應收金額
       faca050 LIKE faca_t.faca050, #本位幣三調撥成本
       faca051 LIKE faca_t.faca051, #本位幣三處置損益
       faca052 LIKE faca_t.faca052, #經營方式
       faca053 LIKE faca_t.faca053, #通路
       faca054 LIKE faca_t.faca054, #品牌
       faca055 LIKE faca_t.faca055, #自由核算項一
       faca056 LIKE faca_t.faca056, #自由核算項二
       faca057 LIKE faca_t.faca057, #自由核算項三
       faca058 LIKE faca_t.faca058, #自由核算項四
       faca059 LIKE faca_t.faca059, #自由核算項五
       faca060 LIKE faca_t.faca060, #自由核算項六
       faca061 LIKE faca_t.faca061, #自由核算項七
       faca062 LIKE faca_t.faca062, #自由核算項八
       faca063 LIKE faca_t.faca063, #自由核算項九
       faca064 LIKE faca_t.faca064, #自由核算項十
       faca065 LIKE faca_t.faca065, #產品類別
       facaud001 LIKE faca_t.facaud001, #自定義欄位(文字)001
       facaud002 LIKE faca_t.facaud002, #自定義欄位(文字)002
       facaud003 LIKE faca_t.facaud003, #自定義欄位(文字)003
       facaud004 LIKE faca_t.facaud004, #自定義欄位(文字)004
       facaud005 LIKE faca_t.facaud005, #自定義欄位(文字)005
       facaud006 LIKE faca_t.facaud006, #自定義欄位(文字)006
       facaud007 LIKE faca_t.facaud007, #自定義欄位(文字)007
       facaud008 LIKE faca_t.facaud008, #自定義欄位(文字)008
       facaud009 LIKE faca_t.facaud009, #自定義欄位(文字)009
       facaud010 LIKE faca_t.facaud010, #自定義欄位(文字)010
       facaud011 LIKE faca_t.facaud011, #自定義欄位(數字)011
       facaud012 LIKE faca_t.facaud012, #自定義欄位(數字)012
       facaud013 LIKE faca_t.facaud013, #自定義欄位(數字)013
       facaud014 LIKE faca_t.facaud014, #自定義欄位(數字)014
       facaud015 LIKE faca_t.facaud015, #自定義欄位(數字)015
       facaud016 LIKE faca_t.facaud016, #自定義欄位(數字)016
       facaud017 LIKE faca_t.facaud017, #自定義欄位(數字)017
       facaud018 LIKE faca_t.facaud018, #自定義欄位(數字)018
       facaud019 LIKE faca_t.facaud019, #自定義欄位(數字)019
       facaud020 LIKE faca_t.facaud020, #自定義欄位(數字)020
       facaud021 LIKE faca_t.facaud021, #自定義欄位(日期時間)021
       facaud022 LIKE faca_t.facaud022, #自定義欄位(日期時間)022
       facaud023 LIKE faca_t.facaud023, #自定義欄位(日期時間)023
       facaud024 LIKE faca_t.facaud024, #自定義欄位(日期時間)024
       facaud025 LIKE faca_t.facaud025, #自定義欄位(日期時間)025
       facaud026 LIKE faca_t.facaud026, #自定義欄位(日期時間)026
       facaud027 LIKE faca_t.facaud027, #自定義欄位(日期時間)027
       facaud028 LIKE faca_t.facaud028, #自定義欄位(日期時間)028
       facaud029 LIKE faca_t.facaud029, #自定義欄位(日期時間)029
       facaud030 LIKE faca_t.facaud030 #自定義欄位(日期時間)030
       END RECORD     

   DEFINE l_faaj RECORD  #固定資產帳套折舊資訊資料檔
       faajent LIKE faaj_t.faajent, #企業編碼
       faajld LIKE faaj_t.faajld, #帳套別編碼
       faajsite LIKE faaj_t.faajsite, #營運據點
       faaj000 LIKE faaj_t.faaj000, #批號
       faaj001 LIKE faaj_t.faaj001, #財產編號
       faaj002 LIKE faaj_t.faaj002, #附號
       faaj003 LIKE faaj_t.faaj003, #折舊方式
       faaj004 LIKE faaj_t.faaj004, #耐用年限(月數)
       faaj005 LIKE faaj_t.faaj005, #未使用年限(月數)
       faaj006 LIKE faaj_t.faaj006, #分攤方式
       faaj007 LIKE faaj_t.faaj007, #分攤類別
       faaj008 LIKE faaj_t.faaj008, #開始折舊年月
       faaj009 LIKE faaj_t.faaj009, #最近折舊年度
       faaj010 LIKE faaj_t.faaj010, #最近折舊期別
       faaj011 LIKE faaj_t.faaj011, #折畢再提
       faaj012 LIKE faaj_t.faaj012, #折畢再提預留殘值
       faaj013 LIKE faaj_t.faaj013, #折畢再提預留年月（數）
       faaj014 LIKE faaj_t.faaj014, #幣別
       faaj015 LIKE faaj_t.faaj015, #匯率
       faaj016 LIKE faaj_t.faaj016, #成本
       faaj017 LIKE faaj_t.faaj017, #累折
       faaj018 LIKE faaj_t.faaj018, #本期累折
       faaj019 LIKE faaj_t.faaj019, #預留殘值
       faaj020 LIKE faaj_t.faaj020, #調整成本
       faaj021 LIKE faaj_t.faaj021, #已提列減值準備
       faaj022 LIKE faaj_t.faaj022, #年折舊額
       faaj023 LIKE faaj_t.faaj023, #資產科目
       faaj024 LIKE faaj_t.faaj024, #累折科目
       faaj025 LIKE faaj_t.faaj025, #折舊科目
       faaj026 LIKE faaj_t.faaj026, #減值準備科目
       faaj027 LIKE faaj_t.faaj027, #銷帳減值準備
       faaj028 LIKE faaj_t.faaj028, #未折減額
       faaj029 LIKE faaj_t.faaj029, #第一個月未折減額
       faaj030 LIKE faaj_t.faaj030, #帳款編號
       faaj031 LIKE faaj_t.faaj031, #帳款編號項次
       faaj032 LIKE faaj_t.faaj032, #本期處置累折
       faaj033 LIKE faaj_t.faaj033, #處置數量
       faaj034 LIKE faaj_t.faaj034, #處置成本
       faaj035 LIKE faaj_t.faaj035, #處置累折
       faaj036 LIKE faaj_t.faaj036, #交易價格差異
       faaj037 LIKE faaj_t.faaj037, #卡片編號
       faaj038 LIKE faaj_t.faaj038, #資產狀態
       faaj039 LIKE faaj_t.faaj039, #部門
       faaj040 LIKE faaj_t.faaj040, #利潤/成本中心
       faaj041 LIKE faaj_t.faaj041, #區域
       faaj042 LIKE faaj_t.faaj042, #交易客商
       faaj043 LIKE faaj_t.faaj043, #帳款客商
       faaj044 LIKE faaj_t.faaj044, #客群
       faaj045 LIKE faaj_t.faaj045, #專案編號
       faaj046 LIKE faaj_t.faaj046, #WBS
       faaj047 LIKE faaj_t.faaj047, #人員
       faaj101 LIKE faaj_t.faaj101, #本位幣二幣別
       faaj102 LIKE faaj_t.faaj102, #本位幣二匯率
       faaj103 LIKE faaj_t.faaj103, #本位幣二成本
       faaj104 LIKE faaj_t.faaj104, #本位幣二累折
       faaj105 LIKE faaj_t.faaj105, #本位幣二預留殘值
       faaj106 LIKE faaj_t.faaj106, #本位幣二折畢再提預留殘值
       faaj107 LIKE faaj_t.faaj107, #本位幣二年折舊額
       faaj108 LIKE faaj_t.faaj108, #本位幣二未折減額
       faaj109 LIKE faaj_t.faaj109, #本位幣二第一月未折減額
       faaj110 LIKE faaj_t.faaj110, #本位幣二處置減值準備
       faaj111 LIKE faaj_t.faaj111, #本位幣二本年累折
       faaj112 LIKE faaj_t.faaj112, #本位幣二已提列減值準備
       faaj113 LIKE faaj_t.faaj113, #本位幣二處置成本
       faaj114 LIKE faaj_t.faaj114, #本位幣二處置累折
       faaj115 LIKE faaj_t.faaj115, #本位幣二本期處置累折
       faaj116 LIKE faaj_t.faaj116, #本位幣二交易價格差異
       faaj117 LIKE faaj_t.faaj117, #本位幣二調整成本
       faaj151 LIKE faaj_t.faaj151, #本位幣三幣別
       faaj152 LIKE faaj_t.faaj152, #本位幣三匯率
       faaj153 LIKE faaj_t.faaj153, #本位幣三成本
       faaj154 LIKE faaj_t.faaj154, #本位幣三累折
       faaj155 LIKE faaj_t.faaj155, #本位幣三預留殘值
       faaj156 LIKE faaj_t.faaj156, #本位幣三折畢再提預留殘值
       faaj157 LIKE faaj_t.faaj157, #本位幣三年折舊額
       faaj158 LIKE faaj_t.faaj158, #本位幣三未折減額
       faaj159 LIKE faaj_t.faaj159, #本位幣三第一月未折減額
       faaj160 LIKE faaj_t.faaj160, #本位幣三處置減值準備
       faaj161 LIKE faaj_t.faaj161, #本位幣三本年累折
       faaj162 LIKE faaj_t.faaj162, #本位幣三已提列減值準備
       faaj163 LIKE faaj_t.faaj163, #本位幣三處置成本
       faaj164 LIKE faaj_t.faaj164, #本位幣三處置累折
       faaj165 LIKE faaj_t.faaj165, #本位幣三本期處置累折
       faaj166 LIKE faaj_t.faaj166, #本位幣三交易價格差異
       faaj167 LIKE faaj_t.faaj167, #本位幣三調整成本
       faajownid LIKE faaj_t.faajownid, #資料所有者
       faajowndp LIKE faaj_t.faajowndp, #資料所屬部門
       faajcrtid LIKE faaj_t.faajcrtid, #資料建立者
       faajcrtdp LIKE faaj_t.faajcrtdp, #資料建立部門
       faajcrtdt LIKE faaj_t.faajcrtdt, #資料創建日
       faajmodid LIKE faaj_t.faajmodid, #資料修改者
       faajmoddt LIKE faaj_t.faajmoddt, #最近修改日
       faajstus LIKE faaj_t.faajstus, #狀態碼
       faaj048 LIKE faaj_t.faaj048  #列帳/列管
       END RECORD

   #161215-00044#2---modify----end-----------------
   DEFINE l_success           LIKE type_t.num5
   
   LET l_success = TRUE
   
   CALL s_transaction_begin()
   CALL cl_err_collect_init()
   
   INITIALIZE l_fabv.* TO NULL
   INITIALIZE l_faca.* TO NULL
   INITIALIZE l_faaj.* TO NULL
   
   CALL cl_get_para(g_enterprise,g_fabg_m.fabgcomp,'S-FIN-9017') RETURNING l_sfin9017 
   
   SELECT fabxdocno INTO l_docno
     FROM fabx_t
    WHERE fabxent = g_enterprise
      AND fabx001 = '32'
      AND fabx010 = g_fabg_m.fabg017
   
   #161215-00044#2---modify----begin-----------------
   #LET l_sql = "SELECT * FROM fabv_t ",
   LET l_sql = "SELECT fabvent,fabvdocno,fabvseq,fabv001,fabv002,fabv003,fabv004,fabv005,fabv006,fabv007,fabv008,",
               "fabv009,fabv010,fabv011,fabv012,fabv013,fabv014,fabv015,fabv016,fabv017,fabv018,fabv019,fabv020,",
               "fabv021,fabv022,fabv023,fabv024,fabv025,fabv026,fabv027,fabv028,fabv029,fabv030,fabv031,fabvud001,",
               "fabvud002,fabvud003,fabvud004,fabvud005,fabvud006,fabvud007,fabvud008,fabvud009,fabvud010,fabvud011,",
               "fabvud012,fabvud013,fabvud014,fabvud015,fabvud016,fabvud017,fabvud018,fabvud019,fabvud020,fabvud021,",
               "fabvud022,fabvud023,fabvud024,fabvud025,fabvud026,fabvud027,fabvud028,fabvud029,fabvud030 FROM fabv_t ",
   #161215-00044#2---modify----end-----------------
               " WHERE fabvent = ",g_enterprise,
               "   AND fabvdocno = '",l_docno,"'"
   PREPARE afat510_ins_faca_pre FROM l_sql
   DECLARE afat510_ins_faca_cs CURSOR FOR afat510_ins_faca_pre

   FOREACH afat510_ins_faca_cs INTO l_fabv.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 's_afat490_ins_afat491_cs'
         LET g_errparam.popup = TRUE
         CALL cl_err()
       
         LET l_success = FALSE
      END IF
      #161215-00044#2---modify----begin-----------------
      #SELECT * INTO l_faaj.*
      SELECT faajent,faajld,faajsite,faaj000,faaj001,faaj002,faaj003,faaj004,faaj005,faaj006,faaj007,faaj008,
             faaj009,faaj010,faaj011,faaj012,faaj013,faaj014,faaj015,faaj016,faaj017,faaj018,faaj019,faaj020,
             faaj021,faaj022,faaj023,faaj024,faaj025,faaj026,faaj027,faaj028,faaj029,faaj030,faaj031,faaj032,
             faaj033,faaj034,faaj035,faaj036,faaj037,faaj038,faaj039,faaj040,faaj041,faaj042,faaj043,faaj044,
             faaj045,faaj046,faaj047,faaj101,faaj102,faaj103,faaj104,faaj105,faaj106,faaj107,faaj108,faaj109,
             faaj110,faaj111,faaj112,faaj113,faaj114,faaj115,faaj116,faaj117,faaj151,faaj152,faaj153,faaj154,
             faaj155,faaj156,faaj157,faaj158,faaj159,faaj160,faaj161,faaj162,faaj163,faaj164,faaj165,faaj166,
             faaj167,faajownid,faajowndp,faajcrtid,faajcrtdp,faajcrtdt,faajmodid,faajmoddt,faajstus,faaj048 INTO l_faaj.*
      #161215-00044#2---modify----end-----------------
        FROM faaj_t
       WHERE faajent = g_enterprise
         AND faajld = g_fabg_m.fabgld
         AND faaj001 = l_fabv.fabv003
         AND faaj002 = l_fabv.fabv004
         AND faaj037 = l_fabv.fabv005
      
      SELECT MAX(facaseq) INTO l_faca.facaseq
        FROM faca_t
       WHERE facaent = g_enterprise
         AND facald = g_fabg_m.fabgld
         AND facadocno = g_fabg_m.fabgdocno
         
      IF cl_null(l_faca.facaseq) THEN 
         LET l_faca.facaseq = 1
      ELSE
         LET l_faca.facaseq = l_faca.facaseq + 1
      END IF
         
      SELECT faah017 INTO l_faah017
        FROM faah_t
       WHERE faahent = g_enterprise
         AND faah001 = l_fabv.fabv005
         AND faah003 = l_fabv.fabv003
         AND faah004 = l_fabv.fabv004
      
      LET l_faca.facaent   = g_enterprise
      LET l_faca.facald    = g_fabg_m.fabgld
      LET l_faca.facadocno = g_fabg_m.fabgdocno
      LET l_faca.faca001   = l_fabv.fabvdocno
      LET l_faca.faca002   = l_fabv.fabvseq
      LET l_faca.faca003   = l_fabv.fabv003
      LET l_faca.faca004   = l_fabv.fabv004
      LET l_faca.faca005   = l_fabv.fabv005
      LET l_faca.faca006   = l_faah017
      LET l_faca.faca007   = l_fabv.fabv011 / l_fabv.fabv010
      LET l_faca.faca008   = l_fabv.fabv010
      LET l_faca.faca009   = l_fabv.fabv011
      LET l_faca.faca010   = g_fabg_m.fabg013
      LET l_faca.faca017   = g_fabg_m.fabg014
      
      #本位币二
      IF g_glaa.glaa015 = 'Y' THEN 
         LET l_faca.faca038 = g_glaa.glaa016
         IF g_glaa.glaa017 = '1' THEN #依交易原幣轉換
            LET l_curr = g_fabg_m.fabg015
         ELSE
            LET l_curr = g_glaa.glaa001
         END IF
         
                                  #匯率參照表;帳套;           日期;      來源幣別
         CALL s_aooi160_get_exrate('2',g_fabg_m.fabgld,g_fabg_m.fabgdocdt,l_curr,
                                   #目的幣別;          交易金額; 匯類類型
                                   g_glaa.glaa016 ,0,g_glaa.glaa018)
         RETURNING l_faca.faca039
      END IF
      
      #本位币三
      IF g_glaa.glaa019 = 'Y' THEN 
         LET l_faca.faca045 = g_glaa.glaa020
         IF g_glaa.glaa021 = '1' THEN #依交易原幣轉換
            LET l_curr = g_fabg_m.fabg015
         ELSE
            LET l_curr = g_glaa.glaa001
         END IF
         
                                  #匯率參照表;帳套;           日期;      來源幣別
         CALL s_aooi160_get_exrate('2',g_fabg_m.fabgld,g_fabg_m.fabgdocdt,l_curr,
                                   #目的幣別;          交易金額; 匯類類型
                                   g_glaa.glaa020 ,0,g_glaa.glaa022)
         RETURNING l_faca.faca046
      END IF
      
      IF NOT cl_null(l_faca.faca010) THEN
         CALL s_tax_ins(l_faca.facadocno,l_faca.facaseq,0,g_fabg_m.fabgcomp,
                        l_fabv.fabv011,l_faca.faca010,
                        l_faca.faca008,g_fabg_m.fabg015,g_fabg_m.fabg016,g_fabg_m.fabgld,l_faca.faca039,l_faca.faca046)
           RETURNING l_faca.faca011,l_faca.faca012,l_faca.faca013,
                     l_faca.faca014,l_faca.faca015,l_faca.faca016,
                     r_xrcd123,r_xrcd124,r_xrcd125,r_xrcd133,r_xrcd134,r_xrcd135
      END IF
                  
      CALL afat510_faca018_get(l_faca.faca001,l_faca.faca002,l_faca.faca014) 
      RETURNING l_faca.faca018
      
      #异动科目
      IF l_sfin9017 = 'Y' THEN        
         SELECT glab005 INTO l_faca.faca019
           FROM glab_t
          WHERE glabent = g_enterprise 
            AND glabld  = g_fabg_m.fabgld
            AND glab002 = '25' 
            AND glab001 = '90' 
            AND glab003 = '9902_12'
      ELSE
         SELECT glab005 INTO l_faca.faca019
           FROM glab_t
          WHERE glabent = g_enterprise 
            AND glabld  = g_fabg_m.fabgld
            AND glab002 = '40' 
            AND glab001 = '90' 
            AND glab003 = '9902_05'       
      END IF 
      
      LET l_faca.faca020 = l_faaj.faaj024                   #累計折舊科目
      LET l_faca.faca021 = l_faaj.faaj026                   #減值準備科目
      LET l_faca.faca022 = l_faaj.faaj023                   #資產科目
      
      #應收帳款科目
      SELECT glab005 INTO l_faca.faca023 
        FROM glab_t
       WHERE glabent = g_enterprise 
         AND glabld  = g_fabg_m.fabgld
         AND glab001 = '90' 
         AND glab002 = '40' 
         AND glab003 = '9902_05'     
      
      #税别科目      
      #應收有帳套時要取帳套慣用稅別設定會科
      SELECT glab005 INTO l_faca.faca024
        FROM glab_t
       WHERE glabent = g_enterprise
         AND glabld  = g_fabg_m.fabgld
         AND glab001 = '14'
         AND glab002 = '2'  # 銷項
         AND glab003 = l_faca.faca010
      #取不到會科時表示以常用會科設定
      IF cl_null(l_faca.faca023) THEN
         SELECT glab005 INTO l_faca.faca023
           FROM glab_t
          WHERE glabent = g_enterprise
            AND glabld  = g_fabg_m.fabgld
            AND glab001 = '12'
            AND glab002 = '9711'
            AND glab003 = '9711_91'
      END IF

      LET l_faca.faca025 = l_faaj.faajsite               #营运据点          
      LET l_faca.faca026 = ''                            #部门
      LET l_faca.faca027 = ''                            #利润/成本中心
      LET l_faca.faca028 = ''                            #区域
      LET l_faca.faca029 = g_fabg_m.fabg007              #交易客商
      LET l_faca.faca030 = g_fabg_m.fabg006              #帳款客商
      LET l_faca.faca031 = ''                            #客群
      LET l_faca.faca032 = ''                            #人员
      LET l_faca.faca033 = l_faaj.faaj045                #专案编号
      LET l_faca.faca034 = l_faaj.faaj046                #WBS

      CALL s_curr_round_ld('1',g_fabg_m.fabgld,g_fabg_m.fabg015,l_faca.faca011,2) RETURNING g_sub_success,g_errno,l_faca.faca011
      CALL s_curr_round_ld('1',g_fabg_m.fabgld,g_fabg_m.fabg015,l_faca.faca012,2) RETURNING g_sub_success,g_errno,l_faca.faca012
      CALL s_curr_round_ld('1',g_fabg_m.fabgld,g_fabg_m.fabg015,l_faca.faca013,2) RETURNING g_sub_success,g_errno,l_faca.faca013
      CALL s_curr_round_ld('1',g_fabg_m.fabgld,g_fabg_m.fabg015,l_faca.faca014,2) RETURNING g_sub_success,g_errno,l_faca.faca014
      CALL s_curr_round_ld('1',g_fabg_m.fabgld,g_fabg_m.fabg015,l_faca.faca015,2) RETURNING g_sub_success,g_errno,l_faca.faca015
      CALL s_curr_round_ld('1',g_fabg_m.fabgld,g_fabg_m.fabg015,l_faca.faca016,2) RETURNING g_sub_success,g_errno,l_faca.faca016
      CALL s_curr_round_ld('1',g_fabg_m.fabgld,g_fabg_m.fabg015,l_faca.faca018,2) RETURNING g_sub_success,g_errno,l_faca.faca018


      #本位币二
      IF g_glaa.glaa015 = 'Y' THEN 
         LET l_faca.faca040 = l_faca.faca014 * l_faca.faca039
         LET l_faca.faca041 = l_faca.faca015 * l_faca.faca039
         LET l_faca.faca042 = l_faca.faca016 * l_faca.faca039
         LET l_faca.faca043 = l_faca.faca009 * l_faca.faca039
         LET l_faca.faca044 = l_faca.faca018 * l_faca.faca039
         
         CALL s_curr_round_ld('1',g_fabg_m.fabgld,l_faca.faca038,l_faca.faca040,2) RETURNING g_sub_success,g_errno,l_faca.faca040
         CALL s_curr_round_ld('1',g_fabg_m.fabgld,l_faca.faca038,l_faca.faca041,2) RETURNING g_sub_success,g_errno,l_faca.faca041
         CALL s_curr_round_ld('1',g_fabg_m.fabgld,l_faca.faca038,l_faca.faca042,2) RETURNING g_sub_success,g_errno,l_faca.faca042
         CALL s_curr_round_ld('1',g_fabg_m.fabgld,l_faca.faca038,l_faca.faca043,2) RETURNING g_sub_success,g_errno,l_faca.faca043
         CALL s_curr_round_ld('1',g_fabg_m.fabgld,l_faca.faca038,l_faca.faca044,2) RETURNING g_sub_success,g_errno,l_faca.faca044
      END IF
      
      #本位币三
      IF g_glaa.glaa019 = 'Y' THEN 
         LET l_faca.faca047 = l_faca.faca014 * l_faca.faca046
         LET l_faca.faca048 = l_faca.faca015 * l_faca.faca046
         LET l_faca.faca049 = l_faca.faca016 * l_faca.faca046
         LET l_faca.faca050 = l_faca.faca009 * l_faca.faca046
         LET l_faca.faca051 = l_faca.faca018 * l_faca.faca046
         
         CALL s_curr_round_ld('1',g_fabg_m.fabgld,l_faca.faca045,l_faca.faca047,2) RETURNING g_sub_success,g_errno,l_faca.faca047
         CALL s_curr_round_ld('1',g_fabg_m.fabgld,l_faca.faca045,l_faca.faca048,2) RETURNING g_sub_success,g_errno,l_faca.faca048
         CALL s_curr_round_ld('1',g_fabg_m.fabgld,l_faca.faca045,l_faca.faca049,2) RETURNING g_sub_success,g_errno,l_faca.faca049
         CALL s_curr_round_ld('1',g_fabg_m.fabgld,l_faca.faca045,l_faca.faca050,2) RETURNING g_sub_success,g_errno,l_faca.faca050
         CALL s_curr_round_ld('1',g_fabg_m.fabgld,l_faca.faca045,l_faca.faca051,2) RETURNING g_sub_success,g_errno,l_faca.faca051
      END IF

      #161215-00044#2---modify----begin-----------------
      #INSERT INTO faca_t VALUES(l_faca.*)
      INSERT INTO faca_t (facaent,facald,facadocno,facaseq,faca001,faca002,faca003,faca004,faca005,faca006,faca007,
                          faca008,faca009,faca010,faca011,faca012,faca013,faca014,faca015,faca016,faca017,faca018,
                          faca019,faca020,faca021,faca022,faca023,faca024,faca025,faca026,faca027,faca028,faca029,
                          faca030,faca031,faca032,faca033,faca034,faca035,faca036,faca037,faca038,faca039,faca040,
                          faca041,faca042,faca043,faca044,faca045,faca046,faca047,faca048,faca049,faca050,faca051,
                          faca052,faca053,faca054,faca055,faca056,faca057,faca058,faca059,faca060,faca061,faca062,
                          faca063,faca064,faca065,facaud001,facaud002,facaud003,facaud004,facaud005,facaud006,
                          facaud007,facaud008,facaud009,facaud010,facaud011,facaud012,facaud013,facaud014,facaud015,
                          facaud016,facaud017,facaud018,facaud019,facaud020,facaud021,facaud022,facaud023,facaud024,
                          facaud025,facaud026,facaud027,facaud028,facaud029,facaud030)
      VALUES(l_faca.facaent,l_faca.facald,l_faca.facadocno,l_faca.facaseq,l_faca.faca001,l_faca.faca002,l_faca.faca003,l_faca.faca004,l_faca.faca005,l_faca.faca006,l_faca.faca007,
             l_faca.faca008,l_faca.faca009,l_faca.faca010,l_faca.faca011,l_faca.faca012,l_faca.faca013,l_faca.faca014,l_faca.faca015,l_faca.faca016,l_faca.faca017,l_faca.faca018,
             l_faca.faca019,l_faca.faca020,l_faca.faca021,l_faca.faca022,l_faca.faca023,l_faca.faca024,l_faca.faca025,l_faca.faca026,l_faca.faca027,l_faca.faca028,l_faca.faca029,
             l_faca.faca030,l_faca.faca031,l_faca.faca032,l_faca.faca033,l_faca.faca034,l_faca.faca035,l_faca.faca036,l_faca.faca037,l_faca.faca038,l_faca.faca039,l_faca.faca040,
             l_faca.faca041,l_faca.faca042,l_faca.faca043,l_faca.faca044,l_faca.faca045,l_faca.faca046,l_faca.faca047,l_faca.faca048,l_faca.faca049,l_faca.faca050,l_faca.faca051,
             l_faca.faca052,l_faca.faca053,l_faca.faca054,l_faca.faca055,l_faca.faca056,l_faca.faca057,l_faca.faca058,l_faca.faca059,l_faca.faca060,l_faca.faca061,l_faca.faca062,
             l_faca.faca063,l_faca.faca064,l_faca.faca065,l_faca.facaud001,l_faca.facaud002,l_faca.facaud003,l_faca.facaud004,l_faca.facaud005,l_faca.facaud006,
             l_faca.facaud007,l_faca.facaud008,l_faca.facaud009,l_faca.facaud010,l_faca.facaud011,l_faca.facaud012,l_faca.facaud013,l_faca.facaud014,l_faca.facaud015,
             l_faca.facaud016,l_faca.facaud017,l_faca.facaud018,l_faca.facaud019,l_faca.facaud020,l_faca.facaud021,l_faca.facaud022,l_faca.facaud023,l_faca.facaud024,
             l_faca.facaud025,l_faca.facaud026,l_faca.facaud027,l_faca.facaud028,l_faca.facaud029,l_faca.facaud030)
      #161215-00044#2---modify----end-----------------
      
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = g_fabg_m.fabgdocno
         LET g_errparam.code   = sqlca.sqlcode
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET l_success = FALSE
      END IF 
   END FOREACH

   IF l_success = TRUE THEN 
      CALL s_transaction_end('Y','0') 
   ELSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "faca_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CALL s_transaction_end('N','0') 
   END IF
   
   CALL cl_err_collect_show()
END FUNCTION
# 计算处置损益
PRIVATE FUNCTION afat510_faca018_get(p_faca001,p_faca002,p_faca014)
   DEFINE p_faca001              LIKE faca_t.faca001
   DEFINE p_faca002              LIKE faca_t.faca002
   DEFINE p_faca014              LIKE faca_t.faca014
   DEFINE l_fabv031              LIKE fabv_t.fabv031
   DEFINE r_faca018              LIKE faca_t.faca018
   
   LET r_faca018 = 0
   
   SELECT fabv031 INTO l_fabv031
     FROM fabv_t
    WHERE fabvent = g_enterprise
      AND fabvdocno = p_faca001
      AND fabvseq = p_faca002
      
   IF cl_null(l_fabv031) THEN 
      LET l_fabv031 = 0
   END IF
   
   LET r_faca018 = p_faca014 -l_fabv031
   
   RETURN r_faca018
END FUNCTION
# 修改单头税别重新计算单身金额
PRIVATE FUNCTION afat510_update_fabg013()
   DEFINE l_sql            STRING
   #161215-00044#2---modify----begin-----------------
   #DEFINE l_faca           RECORD LIKE faca_t.*
   DEFINE l_faca RECORD  #調撥帳務單身檔
       facaent LIKE faca_t.facaent, #企業代碼
       facald LIKE faca_t.facald, #帳套
       facadocno LIKE faca_t.facadocno, #單號
       facaseq LIKE faca_t.facaseq, #項次
       faca001 LIKE faca_t.faca001, #來源單號
       faca002 LIKE faca_t.faca002, #來源項次
       faca003 LIKE faca_t.faca003, #財產編號
       faca004 LIKE faca_t.faca004, #附號
       faca005 LIKE faca_t.faca005, #卡片編號
       faca006 LIKE faca_t.faca006, #單位
       faca007 LIKE faca_t.faca007, #单价
       faca008 LIKE faca_t.faca008, #調撥數量
       faca009 LIKE faca_t.faca009, #調撥成本
       faca010 LIKE faca_t.faca010, #稅別
       faca011 LIKE faca_t.faca011, #原幣未稅金額
       faca012 LIKE faca_t.faca012, #原幣稅額
       faca013 LIKE faca_t.faca013, #原幣應收金額
       faca014 LIKE faca_t.faca014, #本幣未稅金額
       faca015 LIKE faca_t.faca015, #本幣稅額
       faca016 LIKE faca_t.faca016, #本幣應收金額
       faca017 LIKE faca_t.faca017, #稅率
       faca018 LIKE faca_t.faca018, #處置損益
       faca019 LIKE faca_t.faca019, #異動科目
       faca020 LIKE faca_t.faca020, #累折科目
       faca021 LIKE faca_t.faca021, #減值準備科目
       faca022 LIKE faca_t.faca022, #資產科目
       faca023 LIKE faca_t.faca023, #應收/付帳款科目
       faca024 LIKE faca_t.faca024, #稅額科目
       faca025 LIKE faca_t.faca025, #營運據點
       faca026 LIKE faca_t.faca026, #部門
       faca027 LIKE faca_t.faca027, #利潤/成本中心
       faca028 LIKE faca_t.faca028, #區域
       faca029 LIKE faca_t.faca029, #交易客商
       faca030 LIKE faca_t.faca030, #帳款客商
       faca031 LIKE faca_t.faca031, #客群
       faca032 LIKE faca_t.faca032, #人員
       faca033 LIKE faca_t.faca033, #專案編號
       faca034 LIKE faca_t.faca034, #WBS
       faca035 LIKE faca_t.faca035, #帳款編號
       faca036 LIKE faca_t.faca036, #摘要
       faca037 LIKE faca_t.faca037, #應收/付帳款單號
       faca038 LIKE faca_t.faca038, #本位幣二幣別
       faca039 LIKE faca_t.faca039, #本位幣二匯率
       faca040 LIKE faca_t.faca040, #本位幣二未稅金額
       faca041 LIKE faca_t.faca041, #本位幣二稅額
       faca042 LIKE faca_t.faca042, #本位幣二應收金額
       faca043 LIKE faca_t.faca043, #本位幣二調撥成本
       faca044 LIKE faca_t.faca044, #本位幣二處置損益
       faca045 LIKE faca_t.faca045, #本位幣三幣別
       faca046 LIKE faca_t.faca046, #本位幣三匯率
       faca047 LIKE faca_t.faca047, #本位幣三未稅金額
       faca048 LIKE faca_t.faca048, #本位幣三稅額
       faca049 LIKE faca_t.faca049, #本位幣三應收金額
       faca050 LIKE faca_t.faca050, #本位幣三調撥成本
       faca051 LIKE faca_t.faca051, #本位幣三處置損益
       faca052 LIKE faca_t.faca052, #經營方式
       faca053 LIKE faca_t.faca053, #通路
       faca054 LIKE faca_t.faca054, #品牌
       faca055 LIKE faca_t.faca055, #自由核算項一
       faca056 LIKE faca_t.faca056, #自由核算項二
       faca057 LIKE faca_t.faca057, #自由核算項三
       faca058 LIKE faca_t.faca058, #自由核算項四
       faca059 LIKE faca_t.faca059, #自由核算項五
       faca060 LIKE faca_t.faca060, #自由核算項六
       faca061 LIKE faca_t.faca061, #自由核算項七
       faca062 LIKE faca_t.faca062, #自由核算項八
       faca063 LIKE faca_t.faca063, #自由核算項九
       faca064 LIKE faca_t.faca064, #自由核算項十
       faca065 LIKE faca_t.faca065, #產品類別
       facaud001 LIKE faca_t.facaud001, #自定義欄位(文字)001
       facaud002 LIKE faca_t.facaud002, #自定義欄位(文字)002
       facaud003 LIKE faca_t.facaud003, #自定義欄位(文字)003
       facaud004 LIKE faca_t.facaud004, #自定義欄位(文字)004
       facaud005 LIKE faca_t.facaud005, #自定義欄位(文字)005
       facaud006 LIKE faca_t.facaud006, #自定義欄位(文字)006
       facaud007 LIKE faca_t.facaud007, #自定義欄位(文字)007
       facaud008 LIKE faca_t.facaud008, #自定義欄位(文字)008
       facaud009 LIKE faca_t.facaud009, #自定義欄位(文字)009
       facaud010 LIKE faca_t.facaud010, #自定義欄位(文字)010
       facaud011 LIKE faca_t.facaud011, #自定義欄位(數字)011
       facaud012 LIKE faca_t.facaud012, #自定義欄位(數字)012
       facaud013 LIKE faca_t.facaud013, #自定義欄位(數字)013
       facaud014 LIKE faca_t.facaud014, #自定義欄位(數字)014
       facaud015 LIKE faca_t.facaud015, #自定義欄位(數字)015
       facaud016 LIKE faca_t.facaud016, #自定義欄位(數字)016
       facaud017 LIKE faca_t.facaud017, #自定義欄位(數字)017
       facaud018 LIKE faca_t.facaud018, #自定義欄位(數字)018
       facaud019 LIKE faca_t.facaud019, #自定義欄位(數字)019
       facaud020 LIKE faca_t.facaud020, #自定義欄位(數字)020
       facaud021 LIKE faca_t.facaud021, #自定義欄位(日期時間)021
       facaud022 LIKE faca_t.facaud022, #自定義欄位(日期時間)022
       facaud023 LIKE faca_t.facaud023, #自定義欄位(日期時間)023
       facaud024 LIKE faca_t.facaud024, #自定義欄位(日期時間)024
       facaud025 LIKE faca_t.facaud025, #自定義欄位(日期時間)025
       facaud026 LIKE faca_t.facaud026, #自定義欄位(日期時間)026
       facaud027 LIKE faca_t.facaud027, #自定義欄位(日期時間)027
       facaud028 LIKE faca_t.facaud028, #自定義欄位(日期時間)028
       facaud029 LIKE faca_t.facaud029, #自定義欄位(日期時間)029
       facaud030 LIKE faca_t.facaud030  #自定義欄位(日期時間)030
       END RECORD
   #161215-00044#2---modify----end-----------------
   DEFINE r_xrcd123        LIKE xrcd_t.xrcd113
   DEFINE r_xrcd124        LIKE xrcd_t.xrcd114
   DEFINE r_xrcd125        LIKE xrcd_t.xrcd115
   DEFINE r_xrcd133        LIKE xrcd_t.xrcd113
   DEFINE r_xrcd134        LIKE xrcd_t.xrcd114
   DEFINE r_xrcd135        LIKE xrcd_t.xrcd115
   
   #161215-00044#2---modify----begin-----------------
   #LET l_sql = "SELECT * FROM faca_t ",
   LET l_sql = "SELECT facaent,facald,facadocno,facaseq,faca001,faca002,faca003,faca004,faca005,faca006,faca007,",
               "faca008,faca009,faca010,faca011,faca012,faca013,faca014,faca015,faca016,faca017,faca018,faca019,",
               "faca020,faca021,faca022,faca023,faca024,faca025,faca026,faca027,faca028,faca029,faca030,faca031,",
               "faca032,faca033,faca034,faca035,faca036,faca037,faca038,faca039,faca040,faca041,faca042,faca043,",
               "faca044,faca045,faca046,faca047,faca048,faca049,faca050,faca051,faca052,faca053,faca054,faca055,",
               "faca056,faca057,faca058,faca059,faca060,faca061,faca062,faca063,faca064,faca065,facaud001,facaud002,",
               "facaud003,facaud004,facaud005,facaud006,facaud007,facaud008,facaud009,facaud010,facaud011,facaud012,",
               "facaud013,facaud014,facaud015,facaud016,facaud017,facaud018,facaud019,facaud020,facaud021,facaud022,",
               "facaud023,facaud024,facaud025,facaud026,facaud027,facaud028,facaud029,facaud030 FROM faca_t ",
   #161215-00044#2---modify----end-----------------
               " WHERE facaent = ",g_enterprise,
               "   AND facald = '",g_fabg_m.fabgld,"'",
               "   AND facadocno = '",g_fabg_m.fabgdocno,"'"
   PREPARE afat510_update_fabg013_pre FROM l_sql
   DECLARE afat510_update_fabg013_cs CURSOR FOR afat510_update_fabg013_pre
   
   FOREACH afat510_update_fabg013_cs INTO l_faca.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "foreach:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
      LET l_faca.faca010 = g_fabg_m.fabg013
      LET l_faca.faca017 = g_fabg_m.fabg014
      
      CALL s_tax_ins(g_fabg_m.fabgdocno,l_faca.facaseq,0,g_fabg_m.fabgcomp,
                     l_faca.faca009,l_faca.faca010,
                     l_faca.faca008,g_fabg_m.fabg015,g_fabg_m.fabg016,g_fabg_m.fabgld,
                     l_faca.faca039,l_faca.faca046)
           RETURNING l_faca.faca011,l_faca.faca012,l_faca.faca013,
                     l_faca.faca014,l_faca.faca015,l_faca.faca016,
                     r_xrcd123,r_xrcd124,r_xrcd125,r_xrcd133,r_xrcd134,r_xrcd135
      
      CALL afat510_faca018_get(l_faca.faca001,l_faca.faca002,l_faca.faca014) 
      RETURNING l_faca.faca018
      
      CALL s_curr_round_ld('1',g_fabg_m.fabgld,g_fabg_m.fabg015,l_faca.faca011,2) RETURNING g_sub_success,g_errno,l_faca.faca011
      CALL s_curr_round_ld('1',g_fabg_m.fabgld,g_fabg_m.fabg015,l_faca.faca012,2) RETURNING g_sub_success,g_errno,l_faca.faca012
      CALL s_curr_round_ld('1',g_fabg_m.fabgld,g_fabg_m.fabg015,l_faca.faca013,2) RETURNING g_sub_success,g_errno,l_faca.faca013
      CALL s_curr_round_ld('1',g_fabg_m.fabgld,g_fabg_m.fabg015,l_faca.faca014,2) RETURNING g_sub_success,g_errno,l_faca.faca014
      CALL s_curr_round_ld('1',g_fabg_m.fabgld,g_fabg_m.fabg015,l_faca.faca015,2) RETURNING g_sub_success,g_errno,l_faca.faca015
      CALL s_curr_round_ld('1',g_fabg_m.fabgld,g_fabg_m.fabg015,l_faca.faca016,2) RETURNING g_sub_success,g_errno,l_faca.faca016
      CALL s_curr_round_ld('1',g_fabg_m.fabgld,g_fabg_m.fabg015,l_faca.faca018,2) RETURNING g_sub_success,g_errno,l_faca.faca018
      
      #本位币二
      IF g_glaa.glaa015 = 'Y' THEN 
         LET l_faca.faca040 = l_faca.faca014 * l_faca.faca039
         LET l_faca.faca041 = l_faca.faca015 * l_faca.faca039
         LET l_faca.faca042 = l_faca.faca016 * l_faca.faca039
         LET l_faca.faca043 = l_faca.faca009 * l_faca.faca039
         LET l_faca.faca044 = l_faca.faca018 * l_faca.faca039
         
         CALL s_curr_round_ld('1',g_fabg_m.fabgld,l_faca.faca038,l_faca.faca040,2) RETURNING g_sub_success,g_errno,l_faca.faca040
         CALL s_curr_round_ld('1',g_fabg_m.fabgld,l_faca.faca038,l_faca.faca041,2) RETURNING g_sub_success,g_errno,l_faca.faca041
         CALL s_curr_round_ld('1',g_fabg_m.fabgld,l_faca.faca038,l_faca.faca042,2) RETURNING g_sub_success,g_errno,l_faca.faca042
         CALL s_curr_round_ld('1',g_fabg_m.fabgld,l_faca.faca038,l_faca.faca043,2) RETURNING g_sub_success,g_errno,l_faca.faca043
         CALL s_curr_round_ld('1',g_fabg_m.fabgld,l_faca.faca038,l_faca.faca044,2) RETURNING g_sub_success,g_errno,l_faca.faca044
      END IF
      
      #本位币三
      IF g_glaa.glaa019 = 'Y' THEN 
         LET l_faca.faca047 = l_faca.faca014 * l_faca.faca046
         LET l_faca.faca048 = l_faca.faca015 * l_faca.faca046
         LET l_faca.faca049 = l_faca.faca016 * l_faca.faca046
         LET l_faca.faca050 = l_faca.faca009 * l_faca.faca046
         LET l_faca.faca051 = l_faca.faca018 * l_faca.faca046
         
         CALL s_curr_round_ld('1',g_fabg_m.fabgld,l_faca.faca045,l_faca.faca047,2) RETURNING g_sub_success,g_errno,l_faca.faca047
         CALL s_curr_round_ld('1',g_fabg_m.fabgld,l_faca.faca045,l_faca.faca048,2) RETURNING g_sub_success,g_errno,l_faca.faca048
         CALL s_curr_round_ld('1',g_fabg_m.fabgld,l_faca.faca045,l_faca.faca049,2) RETURNING g_sub_success,g_errno,l_faca.faca049
         CALL s_curr_round_ld('1',g_fabg_m.fabgld,l_faca.faca045,l_faca.faca050,2) RETURNING g_sub_success,g_errno,l_faca.faca050
         CALL s_curr_round_ld('1',g_fabg_m.fabgld,l_faca.faca045,l_faca.faca051,2) RETURNING g_sub_success,g_errno,l_faca.faca051
      END IF 
      
      SELECT glab005 INTO l_faca.faca024
        FROM glab_t
       WHERE glabent = g_enterprise
         AND glabld  = g_fabg_m.fabgld
         AND glab001 = '14'
         AND glab002 = '2'  
         AND glab003 = l_faca.faca010
         
      UPDATE faca_t  SET faca010 = l_faca.faca010,
                         faca017 = l_faca.faca017,   
                         faca011 = l_faca.faca011,
                         faca012 = l_faca.faca012,
                         faca013 = l_faca.faca013,
                         faca014 = l_faca.faca014,
                         faca015 = l_faca.faca015,
                         faca016 = l_faca.faca016, 
                         faca018 = l_faca.faca018, 
                         faca040 = l_faca.faca040,
                         faca041 = l_faca.faca041,
                         faca042 = l_faca.faca042,
                         faca043 = l_faca.faca043,
                         faca044 = l_faca.faca044,
                         faca047 = l_faca.faca047,
                         faca048 = l_faca.faca048,
                         faca049 = l_faca.faca049,
                         faca050 = l_faca.faca050,
                         faca051 = l_faca.faca051
       WHERE facaent   = g_enterprise
         AND facald    = g_fabg_m.fabgld
         AND facadocno = g_fabg_m.fabgdocno
         AND facaseq   = l_faca.facaseq         
         
      UPDATE xrcd_t SET xrcd009 = l_faca.faca024
       WHERE xrcd009 IS NULL
         AND xrcdent = g_enterprise
         AND xrcddocno = g_fabg_m.fabgdocno
         AND xrcdld = g_fabg_m.fabgld
   END FOREACH
   
END FUNCTION
# 科目说明
PRIVATE FUNCTION afat510_faca019_desc(p_faca019)
   DEFINE p_faca019       LIKE faca_t.faca019
   DEFINE r_faca019_desc  LIKE type_t.chr80
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_glaa.glaa004
   LET g_ref_fields[2] = p_faca019
   CALL ap_ref_array2(g_ref_fields,"SELECT glacl004 FROM glacl_t WHERE glaclent='"||g_enterprise||"' AND glacl001=? AND glacl002=? AND glacl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_faca019_desc = '', g_rtn_fields[1] , ''
   
   RETURN r_faca019_desc
END FUNCTION
# 收款客户检查
PRIVATE FUNCTION afat510_fabg007_chk()
   DEFINE l_pmacstus   LIKE pmac_t.pmacstus
   DEFINE l_pmac003    LIKE pmac_t.pmac003

   LET g_errno = ''
   SELECT pmacstus,pmac003 INTO l_pmacstus,l_pmac003
     FROM pmac_t 
    WHERE pmacent = g_enterprise
      AND pmac001 = g_fabg_m.fabg006
      AND pmac002 = g_fabg_m.fabg007 
   CASE
      WHEN SQLCA.SQLCODE =100  LET g_errno = 'axr-00048'
      WHEN l_pmacstus = 'N'    LET g_errno = 'sub-01302' 
      WHEN l_pmac003 <> '1'    LET g_errno = 'axr-00050'
   END CASE
END FUNCTION
# 账款还原
PRIVATE FUNCTION afat510_set_back()
   DEFINE l_apcastus    LIKE apca_t.apcastus 
   DEFINE r_success     LIKE type_t.num5   
   DEFINE l_sql         STRING             
   DEFINE l_apcald      LIKE apca_t.apcald  
   DEFINE l_apcadocno   LIKE apca_t.apcadocno  
   DEFINE l_apcadocdt   LIKE apca_t.apcadocdt
   DEFINE l_apca038     LIKE apca_t.apca038
   DEFINE l_apcasite    LIKE apca_t.apcasite
   DEFINE l_clo_date    LIKE type_t.dat
   DEFINE l_success     LIKE type_t.chr1
   DEFINE l_flag        LIKE type_t.num5
   DEFINE l_dfin0030    LIKE type_t.chr1
   DEFINE l_ooba002     LIKE ooba_t.ooba002

   LET r_success = TRUE 
   
   IF NOT cl_null(g_fabg_m.fabg012) AND NOT cl_null(g_fabg_m.fabgdocno) THEN
      SELECT apcastus,apcadocdt,apca038,apcasite
        INTO l_apcastus,l_apcadocdt,l_apca038,l_apcasite
        FROM apca_t 
       WHERE apcaent = g_enterprise 
         AND apcadocno = g_fabg_m.fabg012
         AND apcald = g_fabg_m.fabgld 
      #检查日期是否小于应付关账日期，如果小于不可还原
      CALL cl_get_para(g_enterprise,l_apcasite,'S-FIN-3007') RETURNING l_clo_date 
      IF l_apcadocdt <= l_clo_date THEN 
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = l_apcadocdt||'<='||l_clo_date
         LET g_errparam.code   = "afa-00474" 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET r_success = FALSE 
      END IF 
      #应付账款已抛转凭证，不可还原
      IF NOT cl_null(l_apca038) THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = l_apca038
         LET g_errparam.code   = "afa-00475" 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET r_success = FALSE 
      END IF 
      #当应付账款已审核时，不可还原
      IF l_apcastus='Y' THEN 
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = l_apca038
         LET g_errparam.code   = "afa-01117" 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET r_success = FALSE
      END IF
      IF r_success = TRUE THEN
         UPDATE fabg_t SET fabg012 = '' 
          WHERE fabgent = g_enterprise    
            AND fabg012 = g_fabg_m.fabg012   
            AND fabgld = g_fabg_m.fabgld
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = sqlca.sqlcode
            LET g_errparam.extend = g_fabg_m.fabg012
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success = FALSE  
         END IF
         
         UPDATE faca_t SET faca037 = ''
          WHERE facaent = g_enterprise
            AND facald = g_fabg_m.fabgld
            AND faca037 = g_fabg_m.fabg012
            
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = sqlca.sqlcode
            LET g_errparam.extend = g_fabg_m.fabg012
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success = FALSE  
         END IF

         #生成账款考虑平行帐套，还原时平行帐套也需删除
         LET l_sql = "SELECT glaald FROM glaa_t WHERE glaaent = '",g_enterprise,"' AND (glaald = '",g_fabg_m.fabgld,"'",
                     " OR glaald IN (SELECT glaald FROM glaa_t WHERE glaaent = '",g_enterprise,"' AND glaa008 = 'Y' AND glaacomp = '",g_fabg_m.fabgcomp,"' )) ORDER BY glaa023 "
         PREPARE pre_glaald FROM l_sql
         DECLARE sel_glaald CURSOR FOR pre_glaald
          

         #通过apcb单身资料获取账款单据
         LET l_sql = "SELECT DISTINCT apcadocno FROM apca_t LEFT OUTER JOIN apcb_t ON apcaent = apcbent AND apcald = apcbld AND apcadocno = apcbdocno ",
                     " WHERE apcbent = '",g_enterprise,"' ",
                     "   AND apcbld = ? AND apcb002 = '",g_fabg_m.fabgdocno,"' ",
                     "   AND apcastus = 'N' ",
                     "  ORDER BY apcadocno "
         PREPARE pre_apcadocno FROM l_sql
         DECLARE sel_apcadocno CURSOR FOR pre_apcadocno
         
         LET g_prog = 'aapt301' 
         
         FOREACH sel_glaald INTO l_apcald        
            FOREACH sel_apcadocno USING l_apcald INTO l_apcadocno
               DELETE FROM apca_t 
                WHERE apcaent = g_enterprise 
                  AND apcadocno = l_apcadocno
                  AND apcald = l_apcald   
                  AND apcastus = 'N'
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = sqlca.sqlcode
                  LET g_errparam.extend =l_apcadocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()            
                  LET r_success = FALSE  
               END IF
            
               DELETE FROM apcb_t 
                WHERE apcbent = g_enterprise
                  AND apcbdocno=l_apcadocno
                  AND apcbld = l_apcald   

               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = sqlca.sqlcode
                  LET g_errparam.extend = g_fabg_m.fabg012
                  LET g_errparam.popup = TRUE
                  CALL cl_err()              
                  LET r_success = FALSE  
               END IF
            
               DELETE FROM apcc_t 
                WHERE apccdocno = l_apcadocno
                  AND apccent = g_enterprise
                  AND apccld = l_apcald   
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = sqlca.sqlcode
                  LET g_errparam.extend = g_fabg_m.fabg012
                  LET g_errparam.popup = TRUE
                  CALL cl_err()              
                  LET r_success = FALSE  
               END IF           
            
               DELETE FROM xrcd_t 
                WHERE xrcddocno = l_apcadocno 
                  AND xrcdent = g_enterprise
                  AND xrcdld = l_apcald   
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = sqlca.sqlcode
                  LET g_errparam.extend = g_fabg_m.fabg012
                  LET g_errparam.popup = TRUE
                  CALL cl_err()              
                  LET r_success = FALSE  
               END IF
               
               #删除分录底稿资料
               CALL s_aooi200_fin_get_slip(l_apcadocno) RETURNING l_flag,l_ooba002
               CALL s_fin_get_doc_para(l_apcald,g_fabg_m.fabgcomp,l_ooba002,'D-FIN-0030') RETURNING l_dfin0030
               IF g_glaa.glaa121 = 'Y' AND l_dfin0030 = 'Y' THEN
                  CALL s_pre_voucher_del('AP','P10',l_apcald,l_apcadocno) RETURNING l_flag
                  IF NOT l_flag THEN
                     LET r_success = FALSE
                  END IF
               END IF
               
               #刪除單號
               IF NOT s_aooi200_fin_del_docno(l_apcald,l_apcadocno,l_apcadocdt) THEN
                  LET r_success = FALSE
               END IF
            END FOREACH    
         END FOREACH  

         LET g_prog = 'afat510'  
      END IF
   END IF
   RETURN r_success  
END FUNCTION

 
{</section>}
 
