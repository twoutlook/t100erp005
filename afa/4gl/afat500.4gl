#該程式未解開Section, 採用最新樣板產出!
{<section id="afat500.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0018(2016-09-13 11:15:54), PR版次:0018(2017-02-20 10:28:33)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000185
#+ Filename...: afat500
#+ Description: 資本化帳務維護作業
#+ Creator....: 02114(2014-08-01 09:44:12)
#+ Modifier...: 07900 -SD/PR- 07900
 
{</section>}
 
{<section id="afat500.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#151125-00001#1   2015/11/27 BY fionchen 執行[作廢]作業時,增加詢問「是否執行作廢？」
#150916-00015#1   2015/12/7  BY Xiaozg   1.快捷带出类似科目编号 2.当有账套时，科目检查改为检查是否存在于glad_t中
#151125-00006#2   2015/12/11 BY 06421    添加自动审核和自动抛转凭证功能
#151130-00015#2   2015/12/21 BY taozf    判断 是否可以更改單據日期 設定開放單據日期修改
#160321-00016#26  2016/03/24 BY Jessy    修正azzi920重複定義之錯誤訊息
#160405-00007#1   2016/04/05 BY 02599    增加建立临时表
#160318-00025#6   2016/04/19 BY 07675    將重複內容的錯誤訊息置換為公用錯誤訊息(r.v）
#160414-00015#1   2016/04/25 BY 07673    复制时清空特定栏位
#160727-00019#2   2016/08/01 BY 08742    系统中定义的临时表名称超过15码在执行时会出错,所以需要将系统中定义的临时表长度超过15码的全部改掉	 	
#                                        MOD   afap280_01_fa_tmp -->afap280_tmp01
#                                        MOD   afap280_01_group -->afap280_tmp02
#160125-00005#7   2016/08/09 BY 02599    查詢時加上帳套人員權限條件過濾
#160426-00014#33  2016/08/17 BY 02114    修改权限的问题
#160812-00017#7   2016/08/22 By 06137    在satatchange( )的FUNCTION中，有RETURN指令但沒有加上transaction_end( ) 造成transaction沒有結束就直接RETURN
#160818-00017#9   2016/08/25 By 07900    删除修改未重新判断状态码
#160426-00014#23  2016/09/12 By 07900    固定资产的t作业的单身都增加名称与规格二个栏位，取值来源为afai100的faah012,faah013,各单身表栏位直接按现有表依序增加
#160913-00017#1   2016/09/23 By 07900    AFA模组调整交易客商开窗
#161024-00008#4   2016/10/27 By Hans     AFA組織類型與職能開窗清單調整。
#161111-00049#12  2016/11/25 By 01531    二阶段FA问题7~14 调整作业:afat450/afat500/afat501/afat502/afat503/afat504/afat505/afat506 
#161215-00044#1   2016/12/16 by 02481    标准程式定义采用宣告模式,弃用.*写
#161104-00046#22  2017/01/03 By Reanna   單別預設值;資料依照單別user dept權限過濾單號
#161221-00054#4   2017/02/17 By 07900    相關單身(會計科目+部門) 及傳票預覽( 會計科目+部門), 要擋<<科目拒絕部門>> 參照agli060擋拒絕部門設定 
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
   fabg002 LIKE fabg_t.fabg002, 
   fabg002_desc LIKE type_t.chr80, 
   fabg003 LIKE fabg_t.fabg003, 
   fabg003_desc LIKE type_t.chr80, 
   fabg004 LIKE fabg_t.fabg004, 
   fabg005 LIKE fabg_t.fabg005, 
   fabgdocno LIKE fabg_t.fabgdocno, 
   fabgdocdt LIKE fabg_t.fabgdocdt, 
   fabg008 LIKE fabg_t.fabg008, 
   fabg009 LIKE fabg_t.fabg009, 
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
PRIVATE TYPE type_g_fabs_d        RECORD
       fabsseq LIKE fabs_t.fabsseq, 
   fabs002 LIKE fabs_t.fabs002, 
   fabs003 LIKE fabs_t.fabs003, 
   fabs004 LIKE fabs_t.fabs004, 
   fabs005 LIKE fabs_t.fabs005, 
   fabs006 LIKE fabs_t.fabs006, 
   faah012 LIKE type_t.chr500, 
   faah013 LIKE type_t.chr500, 
   fabs009 LIKE fabs_t.fabs009, 
   fabs010 LIKE fabs_t.fabs010, 
   fabs011 LIKE fabs_t.fabs011, 
   fabs012 LIKE fabs_t.fabs012, 
   fabn017 LIKE type_t.chr10, 
   fabn017_desc LIKE type_t.chr500, 
   fabs100 LIKE type_t.chr10, 
   fabs101 LIKE type_t.num26_10, 
   fabs102 LIKE type_t.num20_6, 
   fabs150 LIKE type_t.chr10, 
   fabs151 LIKE type_t.num26_10, 
   fabs152 LIKE type_t.num20_6
       END RECORD
PRIVATE TYPE type_g_fabs2_d RECORD
       fabsseq LIKE fabs_t.fabsseq, 
   fabs007 LIKE type_t.chr500, 
   fabs007_desc LIKE type_t.chr500, 
   fabs008 LIKE fabs_t.fabs008, 
   fabs008_desc LIKE type_t.chr500, 
   fabs014 LIKE type_t.chr10, 
   fabs014_desc LIKE type_t.chr500, 
   fabs015 LIKE type_t.chr10, 
   fabs015_desc LIKE type_t.chr500, 
   fabs016 LIKE type_t.chr10, 
   fabs016_desc LIKE type_t.chr500, 
   fabs017 LIKE type_t.chr10, 
   fabs017_desc LIKE type_t.chr500, 
   fabs018 LIKE type_t.chr10, 
   fabs018_desc LIKE type_t.chr500, 
   fabs019 LIKE type_t.chr10, 
   fabs019_desc LIKE type_t.chr500, 
   fabs020 LIKE type_t.chr10, 
   fabs020_desc LIKE type_t.chr500, 
   fabs022 LIKE type_t.chr20, 
   fabs022_desc LIKE type_t.chr500, 
   fabs024 LIKE type_t.chr20, 
   fabs024_desc LIKE type_t.chr500, 
   fabs025 LIKE type_t.chr30, 
   fabs025_desc LIKE type_t.chr500
       END RECORD
PRIVATE TYPE type_g_fabs3_d RECORD
       fabsseq LIKE fabs_t.fabsseq, 
   fabs100 LIKE fabs_t.fabs100, 
   fabs101 LIKE fabs_t.fabs101, 
   fabs102 LIKE fabs_t.fabs102, 
   fabs150 LIKE fabs_t.fabs150, 
   fabs151 LIKE fabs_t.fabs151, 
   fabs152 LIKE fabs_t.fabs152
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_fabgld LIKE fabg_t.fabgld,
      b_fabgdocno LIKE fabg_t.fabgdocno
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_glaa001             LIKE glaa_t.glaa001
DEFINE g_glaa004             LIKE glaa_t.glaa004
DEFINE g_glaa015             LIKE glaa_t.glaa015
DEFINE g_glaa016             LIKE glaa_t.glaa016
DEFINE g_glaa017             LIKE glaa_t.glaa017
DEFINE g_glaa018             LIKE glaa_t.glaa018
DEFINE g_glaa019             LIKE glaa_t.glaa019
DEFINE g_glaa020             LIKE glaa_t.glaa020
DEFINE g_glaa021             LIKE glaa_t.glaa021
DEFINE g_glaa022             LIKE glaa_t.glaa022
DEFINE g_glaa025             LIKE glaa_t.glaa025
DEFINE g_bookno              LIKE glaa_t.glaald
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
DEFINE g_wc_cs_ld            STRING                #160125-00005#7
DEFINE g_site_str            STRING                #160125-00005#7
#161104-00046#22 add ------
DEFINE g_user_dept_wc        STRING
DEFINE g_user_dept_wc_q      STRING
DEFINE g_user_slip_wc        STRING
DEFINE g_ap_slip             LIKE ooba_t.ooba002
#161104-00046#22 add end---
#end add-point
       
#模組變數(Module Variables)
DEFINE g_fabg_m          type_g_fabg_m
DEFINE g_fabg_m_t        type_g_fabg_m
DEFINE g_fabg_m_o        type_g_fabg_m
DEFINE g_fabg_m_mask_o   type_g_fabg_m #轉換遮罩前資料
DEFINE g_fabg_m_mask_n   type_g_fabg_m #轉換遮罩後資料
 
   DEFINE g_fabgld_t LIKE fabg_t.fabgld
DEFINE g_fabgdocno_t LIKE fabg_t.fabgdocno
 
 
DEFINE g_fabs_d          DYNAMIC ARRAY OF type_g_fabs_d
DEFINE g_fabs_d_t        type_g_fabs_d
DEFINE g_fabs_d_o        type_g_fabs_d
DEFINE g_fabs_d_mask_o   DYNAMIC ARRAY OF type_g_fabs_d #轉換遮罩前資料
DEFINE g_fabs_d_mask_n   DYNAMIC ARRAY OF type_g_fabs_d #轉換遮罩後資料
DEFINE g_fabs2_d          DYNAMIC ARRAY OF type_g_fabs2_d
DEFINE g_fabs2_d_t        type_g_fabs2_d
DEFINE g_fabs2_d_o        type_g_fabs2_d
DEFINE g_fabs2_d_mask_o   DYNAMIC ARRAY OF type_g_fabs2_d #轉換遮罩前資料
DEFINE g_fabs2_d_mask_n   DYNAMIC ARRAY OF type_g_fabs2_d #轉換遮罩後資料
DEFINE g_fabs3_d          DYNAMIC ARRAY OF type_g_fabs3_d
DEFINE g_fabs3_d_t        type_g_fabs3_d
DEFINE g_fabs3_d_o        type_g_fabs3_d
DEFINE g_fabs3_d_mask_o   DYNAMIC ARRAY OF type_g_fabs3_d #轉換遮罩前資料
DEFINE g_fabs3_d_mask_n   DYNAMIC ARRAY OF type_g_fabs3_d #轉換遮罩後資料
 
 
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
 
{<section id="afat500.main" >}
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
   #161104-00046#22 add ------
   #建立與單頭array相同的temptable
   CALL s_aooi200def_create('','g_fabg_m','','','','','','')RETURNING g_sub_success
   #單別控制組
   LET g_user_dept_wc = ''
   CALL s_fin_get_user_dept_control('','fabgld','fabgent','fabgdocno') RETURNING g_user_dept_wc
   #開窗使用
   LET g_user_dept_wc_q = g_user_dept_wc
   CALL s_control_get_docno_sql(g_user,g_dept) RETURNING g_sub_success,g_user_slip_wc
   #161104-00046#22 add end---
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT fabgsite,'',fabg001,'',fabgld,'',fabg002,'',fabg003,'',fabg004,fabg005, 
       fabgdocno,fabgdocdt,fabg008,fabg009,fabgstus,fabgownid,'',fabgowndp,'',fabgcrtid,'',fabgcrtdp, 
       '',fabgcrtdt,fabgmodid,'',fabgmoddt,fabgcnfid,'',fabgcnfdt,fabgpstid,'',fabgpstdt", 
                      " FROM fabg_t",
                      " WHERE fabgent= ? AND fabgld=? AND fabgdocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE afat500_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.fabgsite,t0.fabg001,t0.fabgld,t0.fabg002,t0.fabg003,t0.fabg004,t0.fabg005, 
       t0.fabgdocno,t0.fabgdocdt,t0.fabg008,t0.fabg009,t0.fabgstus,t0.fabgownid,t0.fabgowndp,t0.fabgcrtid, 
       t0.fabgcrtdp,t0.fabgcrtdt,t0.fabgmodid,t0.fabgmoddt,t0.fabgcnfid,t0.fabgcnfdt,t0.fabgpstid,t0.fabgpstdt, 
       t1.ooefl003 ,t2.ooag011 ,t3.glaal002 ,t4.ooag011 ,t5.ooefl003 ,t6.ooag011 ,t7.ooefl003 ,t8.ooag011 , 
       t9.ooefl003 ,t10.ooag011 ,t11.ooag011 ,t12.ooag011",
               " FROM fabg_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.fabgsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.fabg001  ",
               " LEFT JOIN glaal_t t3 ON t3.glaalent="||g_enterprise||" AND t3.glaalld=t0.fabgld AND t3.glaal001='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=t0.fabg002  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.fabg003 AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.fabgownid  ",
               " LEFT JOIN ooefl_t t7 ON t7.ooeflent="||g_enterprise||" AND t7.ooefl001=t0.fabgowndp AND t7.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=t0.fabgcrtid  ",
               " LEFT JOIN ooefl_t t9 ON t9.ooeflent="||g_enterprise||" AND t9.ooefl001=t0.fabgcrtdp AND t9.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t10 ON t10.ooagent="||g_enterprise||" AND t10.ooag001=t0.fabgmodid  ",
               " LEFT JOIN ooag_t t11 ON t11.ooagent="||g_enterprise||" AND t11.ooag001=t0.fabgcnfid  ",
               " LEFT JOIN ooag_t t12 ON t12.ooagent="||g_enterprise||" AND t12.ooag001=t0.fabgpstid  ",
 
               " WHERE t0.fabgent = " ||g_enterprise|| " AND t0.fabgld = ? AND t0.fabgdocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE afat500_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_afat500 WITH FORM cl_ap_formpath("afa",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL afat500_init()   
 
      #進入選單 Menu (="N")
      CALL afat500_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
 
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_afat500
      
   END IF 
   
   CLOSE afat500_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   DROP TABLE afap280_tmp01   #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
   DROP TABLE afap280_tmp02   #160727-00019#2 Mod   afap280_01_group -->afap280_tmp02
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="afat500.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION afat500_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point    
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success     LIKE type_t.num5 #160405-00007#1 add
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
 
   LET g_error_show  = 1
   LET l_ac = 1 #單身指標
      CALL cl_set_combo_scc_part('fabgstus','13','A,D,N,R,W,Y,Z,S,X')
 
      CALL cl_set_combo_scc('fabg005','9910') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1','2','3',","1")
   CALL g_idx_group.addAttribute("","1")
   CALL g_idx_group.addAttribute("","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc_part('fabg005','9910','22,26') 
   CALL afap280_01_cre_fa_tmp_table() RETURNING l_success #160405-00007#1 add
   CALL s_fin_create_account_center_tmp()
   #end add-point
   
   #初始化搜尋條件
   CALL afat500_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="afat500.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION afat500_ui_dialog()
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
   DEFINE l_glaa014  LIKE glaa_t.glaa014   #所用帐套是否是主帐套
   DEFINE l_success  LIKE type_t.num5
   DEFINE l_ooba002  LIKE ooba_t.ooba002
   DEFINE l_str1     LIKE type_t.chr1
   DEFINE l_n        LIKE type_t.num5
   DEFINE l_slip     LIKE type_t.chr20
   DEFINE l_ooac004  LIKE ooac_t.ooac004 
   #151125-00006#2 add ---s 
   DEFINE l_cn              LIKE type_t.num5
   #151125-00006#2 add ---e
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
            CALL afat500_insert()
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
         CALL g_fabs_d.clear()
         CALL g_fabs2_d.clear()
         CALL g_fabs3_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL afat500_init()
      END IF
   
            
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
    
         DISPLAY ARRAY g_fabs_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL afat500_idx_chk()
               #確定當下選擇的筆數
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[1] = l_ac
               CALL g_idx_group.addAttribute("'1','2','3',",l_ac)
               
               #add-point:page1, before row動作 name="ui_dialog.page1.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1','2','3',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_current_page = 1
               #顯示單身筆數
               CALL afat500_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION detail_qrystr
               MENU "" ATTRIBUTE(STYLE="popup")
                  #add-point:ON ACTION detail_qrystr相關動作 name="menu.detail_show.page1_sub.detail_qrystr"
                  BEFORE MENU
                     IF l_ac < 1 OR cl_null(l_ac) THEN
                        EXIT MENU
                     END IF
                     IF g_fabg_m.fabg005 = '22' THEN
                        HIDE OPTION "prog_afat460"
                     END IF
                     IF g_fabg_m.fabg005 = '26' THEN
                        HIDE OPTION "prog_afat400"
                     END IF
                     IF cl_null(g_fabs_d[l_ac].fabs002) THEN
                        EXIT MENU
                     END IF
                  #END add-point
                                 #應用 a43 樣板自動產生(Version:4)
               ON ACTION prog_afat400
                  LET g_action_choice="prog_afat400"
                  IF cl_auth_chk_act("prog_afat400") THEN
                     
                     #add-point:ON ACTION prog_afat400 name="menu.detail_show.page1_sub.prog_afat400"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               INITIALIZE la_param.* TO NULL
               LET la_param.prog     = 'afat400'
               LET la_param.param[1] = g_fabs_d[l_ac].fabs002

               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun_wait(ls_js)
 


                     #END add-point
                     
                  END IF
 
 
 
               #應用 a43 樣板自動產生(Version:4)
               ON ACTION prog_afat460
                  LET g_action_choice="prog_afat460"
                  IF cl_auth_chk_act("prog_afat460") THEN
                     
                     #add-point:ON ACTION prog_afat460 name="menu.detail_show.page1_sub.prog_afat460"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               INITIALIZE la_param.* TO NULL
               LET la_param.prog     = 'afat460'
               LET la_param.param[1] = g_fabs_d[l_ac].fabs002

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
        
         #第一階單身段落
         DISPLAY ARRAY g_fabs2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL afat500_idx_chk()
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
               CALL afat500_idx_chk()
               #add-point:page2自定義行為 name="ui_dialog.body2.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
         
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_fabs3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL afat500_idx_chk()
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
               CALL afat500_idx_chk()
               #add-point:page3自定義行為 name="ui_dialog.body3.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_3)
            
         
            #add-point:page3自定義行為 name="ui_dialog.body3.action"
            
            #end add-point
         
         END DISPLAY
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
      
         BEFORE DIALOG
            #先填充browser資料
            CALL afat500_browser_fill("")
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
               CALL afat500_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL afat500_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL afat500_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL afat500_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL afat500_set_act_visible()   
            CALL afat500_set_act_no_visible()
            IF NOT (g_fabg_m.fabgld IS NULL
              OR g_fabg_m.fabgdocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " fabgent = " ||g_enterprise|| " AND",
                                  " fabgld = '", g_fabg_m.fabgld, "' "
                                  ," AND fabgdocno = '", g_fabg_m.fabgdocno, "' "
 
               #填到對應位置
               CALL afat500_browser_fill("")
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
                     WHEN la_wc[li_idx].tableid = "fabg_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "fabs_t" 
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
               CALL afat500_browser_fill("F")   #browser_fill()會將notice區塊清空
            END IF
         
         #查詢方案選擇
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "fabg_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "fabs_t" 
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
                  CALL afat500_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL afat500_fetch("F")
                  END IF
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
          
         
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL afat500_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL afat500_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL afat500_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL afat500_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL afat500_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL afat500_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL afat500_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL afat500_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL afat500_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL afat500_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_fabs_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_fabs2_d)
                  LET g_export_id[2]   = "s_detail2"
                  LET g_export_node[3] = base.typeInfo.create(g_fabs3_d)
                  LET g_export_id[3]   = "s_detail3"
 
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
               CALL afat500_modify()
               #add-point:ON ACTION modify name="menu.modify"
               #add 151125-00006#2 --s
               LET l_cn = 0 
               SELECT COUNT(*) INTO l_cn FROM fabg_t 
               WHERE fabgld  = g_fabg_m.fabgld  AND fabgdocno = g_fabg_m.fabgdocno AND fabgent = g_enterprise
               IF l_cn > 0 AND NOT cl_null (g_current_idx) THEN
                  CALL afat500_ui_headershow()
               END IF
               #add 151125-00006#2 --e
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL afat500_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               #add 151125-00006#2 --s
               LET l_cn = 0 
               SELECT COUNT(*) INTO l_cn FROM fabg_t 
               WHERE fabgld  = g_fabg_m.fabgld  AND fabgdocno = g_fabg_m.fabgdocno AND fabgent = g_enterprise
               IF l_cn > 0 AND NOT cl_null (g_current_idx) THEN
                  CALL afat500_ui_headershow()
               END IF
               #add 151125-00006#2 --e
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_pre
            LET g_action_choice="open_pre"
            IF cl_auth_chk_act("open_pre") THEN
               
               #add-point:ON ACTION open_pre name="menu.open_pre"
               #20150210 add by chenying
               IF NOT cl_null(g_fabg_m.fabgdocno) AND g_fabg_m.fabgstus = 'N' THEN
                  #获取单别
                  CALL s_aooi200_get_slip(g_fabg_m.fabgdocno) RETURNING l_success,l_slip

                  #是否抛傳票
                #161215-00044#1---modify----begin-----------------         
                #SELECT * INTO g_glaa.* 
                 SELECT glaaent,glaaownid,glaaowndp,glaacrtid,
                        glaacrtdp,glaacrtdt,glaamodid,glaamoddt,
                        glaastus,glaald,glaacomp,
                        glaa001,glaa002,glaa003,glaa004,glaa005,
                        glaa006,glaa007,glaa008,glaa009,glaa010,
                        glaa011,glaa012,glaa013,glaa014,glaa015,
                        glaa016,glaa017,glaa018,glaa019,glaa020,
                        glaa021,glaa022,glaa023,glaa024,glaa025,
                        glaa026,glaa100,glaa101,glaa102,glaa103,
                        glaa111,glaa112,glaa113,glaa120,glaa121,
                        glaa122,glaa027,glaa130,glaa131,glaa132,
                        glaa133,glaa134,glaa135,glaa136,glaa137,
                        glaa138,glaa139,glaa140,glaa123,glaa124,
                        glaa028 
                   INTO g_glaa.glaaent,g_glaa.glaaownid,g_glaa.glaaowndp,g_glaa.glaacrtid,
                        g_glaa.glaacrtdp,g_glaa.glaacrtdt,g_glaa.glaamodid,g_glaa.glaamoddt,
                        g_glaa.glaastus,g_glaa.glaald,g_glaa.glaacomp,
                        g_glaa.glaa001,g_glaa.glaa002,g_glaa.glaa003,g_glaa.glaa004,g_glaa.glaa005,
                        g_glaa.glaa006,g_glaa.glaa007,g_glaa.glaa008,g_glaa.glaa009,g_glaa.glaa010,
                        g_glaa.glaa011,g_glaa.glaa012,g_glaa.glaa013,g_glaa.glaa014,g_glaa.glaa015,
                        g_glaa.glaa016,g_glaa.glaa017,g_glaa.glaa018,g_glaa.glaa019,g_glaa.glaa020,
                        g_glaa.glaa021,g_glaa.glaa022,g_glaa.glaa023,g_glaa.glaa024,g_glaa.glaa025,
                        g_glaa.glaa026,g_glaa.glaa100,g_glaa.glaa101,g_glaa.glaa102,g_glaa.glaa103,
                        g_glaa.glaa111,g_glaa.glaa112,g_glaa.glaa113,g_glaa.glaa120,g_glaa.glaa121,
                        g_glaa.glaa122,g_glaa.glaa027,g_glaa.glaa130,g_glaa.glaa131,g_glaa.glaa132,
                        g_glaa.glaa133,g_glaa.glaa134,g_glaa.glaa135,g_glaa.glaa136,g_glaa.glaa137,
                        g_glaa.glaa138,g_glaa.glaa139,g_glaa.glaa140,g_glaa.glaa123,g_glaa.glaa124,
                        g_glaa.glaa028 
              #161215-00044#1---modify----end-----------------
                  FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_fabg_m.fabgld  
                  CALL s_fin_get_doc_para(g_fabg_m.fabgld,g_glaa.glaacomp,l_slip,'D-FIN-0030') RETURNING l_ooac004

                  IF l_ooac004 = 'N' THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = l_slip
                     LET g_errparam.code   = 'axr-00225'
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()

                     EXIT DIALOG
                  END IF

                  CALL s_transaction_begin()
                  IF g_fabg_m.fabg005 = '22' THEN
                     CALL s_pre_voucher_ins('FA','F10',g_fabg_m.fabgld,g_fabg_m.fabgdocno,g_fabg_m.fabgdocdt,'22')
                        RETURNING l_success
                  ELSE
                     CALL s_pre_voucher_ins('FA','F20',g_fabg_m.fabgld,g_fabg_m.fabgdocno,g_fabg_m.fabgdocdt,'26')
                        RETURNING l_success                  
                  END IF                  
                  IF l_success THEN
                     CALL s_transaction_end('Y','0')
                  ELSE
                     CALL s_transaction_end('N','0')
                  END IF
               END IF               
               #20150210 add by chenying
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL afat500_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL afat500_insert()
               #add-point:ON ACTION insert name="menu.insert"
               #add 151125-00006#2 --s
               LET l_cn = 0 
               SELECT COUNT(*) INTO l_cn FROM fabg_t 
               WHERE fabgld  = g_fabg_m.fabgld  AND fabgdocno = g_fabg_m.fabgdocno AND fabgent = g_enterprise
               IF l_cn > 0 AND NOT cl_null (g_current_idx) THEN
                  CALL afat500_ui_headershow()
               END IF
               #add 151125-00006#2 --e
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/afa/afat500_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               &include "erp/afa/afat500_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL afat500_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               #add 151125-00006#2 --s
               LET l_cn = 0 
               SELECT COUNT(*) INTO l_cn FROM fabg_t 
               WHERE fabgld  = g_fabg_m.fabgld  AND fabgdocno = g_fabg_m.fabgdocno AND fabgent = g_enterprise
               IF l_cn > 0 AND NOT cl_null (g_current_idx) THEN
                  CALL afat500_ui_headershow()
               END IF
               #add 151125-00006#2 --e
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_afap280
            LET g_action_choice="open_afap280"
            IF cl_auth_chk_act("open_afap280") THEN
               
               #add-point:ON ACTION open_afap280 name="menu.open_afap280"
               CALL s_afat503_afap280_chk(g_fabg_m.fabgdocno,g_fabg_m.fabg008,g_fabg_m.fabgstus) RETURNING l_success 
               IF l_success = TRUE THEN 
                  LET la_param.prog = 'afap280'
                  LET la_param.param[1] = g_fabg_m.fabgld
                  LET la_param.param[2] = g_fabg_m.fabgdocno
                  LET la_param.param[3] = g_fabg_m.fabg005
                  LET ls_js = util.JSON.stringify(la_param)
                  CALL cl_cmdrun_wait(ls_js)
                   CURRENT WINDOW IS w_afat500
                     SELECT fabg008,fabg009 INTO g_fabg_m.fabg008,g_fabg_m.fabg009 FROM fabg_t
                      WHERE fabgent = g_enterprise AND fabgld = g_fabg_m.fabgld
                        AND fabgdocno = g_fabg_m.fabgdocno
                     DISPLAY BY NAME g_fabg_m.fabg008,g_fabg_m.fabg009
                     CALL afat500_ui_headershow()  #20141106 add
                END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_afap290
            LET g_action_choice="open_afap290"
            IF cl_auth_chk_act("open_afap290") THEN
               
               #add-point:ON ACTION open_afap290 name="menu.open_afap290"
               LET la_param.prog = 'afap290'
               LET la_param.param[1] = g_fabg_m.fabgld
               LET la_param.param[2] = g_fabg_m.fabgdocno
               LET la_param.param[3] = g_fabg_m.fabg005
               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun(ls_js)

               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL afat500_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
               CALL g_curr_diag.setCurrentRow("s_detail3",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aglt310
            LET g_action_choice="open_aglt310"
            IF cl_auth_chk_act("open_aglt310") THEN
               
               #add-point:ON ACTION open_aglt310 name="menu.open_aglt310"
               IF NOT cl_null(g_fabg_m.fabg008) THEN
                  LET la_param.prog = 'aglt310'
                  LET la_param.param[1] = g_fabg_m.fabgld
                  LET la_param.param[2] = g_fabg_m.fabg008
                  LET ls_js = util.JSON.stringify(la_param)
                  CALL cl_cmdrun(ls_js)
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_afat500_01
            LET g_action_choice="open_afat500_01"
            IF cl_auth_chk_act("open_afat500_01") THEN
               
               #add-point:ON ACTION open_afat500_01 name="menu.open_afat500_01"
                IF NOT cl_null(g_fabg_m.fabgdocno) AND l_ac>0 THEN                       
                   CALL s_aooi200_fin_get_slip(g_fabg_m.fabgdocno) RETURNING l_success,l_ooba002
                   CALL s_fin_get_doc_para(g_fabg_m.fabgld,'',l_ooba002,'D-FIN-0030') RETURNING l_str1 
                   IF cl_null(l_str1) THEN LET l_str1 = 'Y' END IF
                   IF l_str1 = 'Y' THEN
                      #161215-00044#1---modify----begin-----------------         
                      #SELECT * INTO g_glaa.* 
                       SELECT glaaent,glaaownid,glaaowndp,glaacrtid,
                              glaacrtdp,glaacrtdt,glaamodid,glaamoddt,
                              glaastus,glaald,glaacomp,
                              glaa001,glaa002,glaa003,glaa004,glaa005,
                              glaa006,glaa007,glaa008,glaa009,glaa010,
                              glaa011,glaa012,glaa013,glaa014,glaa015,
                              glaa016,glaa017,glaa018,glaa019,glaa020,
                              glaa021,glaa022,glaa023,glaa024,glaa025,
                              glaa026,glaa100,glaa101,glaa102,glaa103,
                              glaa111,glaa112,glaa113,glaa120,glaa121,
                              glaa122,glaa027,glaa130,glaa131,glaa132,
                              glaa133,glaa134,glaa135,glaa136,glaa137,
                              glaa138,glaa139,glaa140,glaa123,glaa124,
                              glaa028 
                         INTO g_glaa.glaaent,g_glaa.glaaownid,g_glaa.glaaowndp,g_glaa.glaacrtid,
                              g_glaa.glaacrtdp,g_glaa.glaacrtdt,g_glaa.glaamodid,g_glaa.glaamoddt,
                              g_glaa.glaastus,g_glaa.glaald,g_glaa.glaacomp,
                              g_glaa.glaa001,g_glaa.glaa002,g_glaa.glaa003,g_glaa.glaa004,g_glaa.glaa005,
                              g_glaa.glaa006,g_glaa.glaa007,g_glaa.glaa008,g_glaa.glaa009,g_glaa.glaa010,
                              g_glaa.glaa011,g_glaa.glaa012,g_glaa.glaa013,g_glaa.glaa014,g_glaa.glaa015,
                              g_glaa.glaa016,g_glaa.glaa017,g_glaa.glaa018,g_glaa.glaa019,g_glaa.glaa020,
                              g_glaa.glaa021,g_glaa.glaa022,g_glaa.glaa023,g_glaa.glaa024,g_glaa.glaa025,
                              g_glaa.glaa026,g_glaa.glaa100,g_glaa.glaa101,g_glaa.glaa102,g_glaa.glaa103,
                              g_glaa.glaa111,g_glaa.glaa112,g_glaa.glaa113,g_glaa.glaa120,g_glaa.glaa121,
                              g_glaa.glaa122,g_glaa.glaa027,g_glaa.glaa130,g_glaa.glaa131,g_glaa.glaa132,
                              g_glaa.glaa133,g_glaa.glaa134,g_glaa.glaa135,g_glaa.glaa136,g_glaa.glaa137,
                              g_glaa.glaa138,g_glaa.glaa139,g_glaa.glaa140,g_glaa.glaa123,g_glaa.glaa124,
                              g_glaa.glaa028 
              #161215-00044#1---modify----end-----------------
                      FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_fabg_m.fabgld 
                     IF g_glaa.glaa121 = 'Y' THEN
                        IF g_fabg_m.fabg005 = '22' THEN
                           CALL s_pre_voucher('FA','F10',g_fabg_m.fabgld,g_fabg_m.fabgdocno,g_fabg_m.fabgdocdt)
                        ELSE
                           CALL s_pre_voucher('FA','F20',g_fabg_m.fabgld,g_fabg_m.fabgdocno,g_fabg_m.fabgdocdt)
                        END IF                        
                     ELSE  
#                        CALL afap280_01_cre_fa_tmp_table() RETURNING l_success #add by 06421 151223 #160405-00007#1 mark
                        CALL s_transaction_begin()           #add by 06421 151223          
                        LET g_wc_t = "fabgdocno = '",g_fabg_m.fabgdocno,"'"                     
                        #移動類型         #帳套        #日期 #單據別  #匯總方式 #查詢條件  #是否先預覽后再拋憑證
                        CALL afap280_01_gen_ar(g_fabg_m.fabg005,g_fabg_m.fabgld,'',' ','1',g_wc_t,'Y','afat500') RETURNING l_success
                        IF l_success THEN
                           CALL s_transaction_end('Y','0')
                        ELSE
                           CALL s_transaction_end('N','0')
                        END IF             
                        CALL axrt300_13('FA',g_fabg_m.fabgld,g_fabg_m.fabgdocno,'')                        
                     END IF 
                 END IF   
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_fabg001
            LET g_action_choice="prog_fabg001"
            IF cl_auth_chk_act("prog_fabg001") THEN
               
               #add-point:ON ACTION prog_fabg001 name="menu.prog_fabg001"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               CALL cl_user_contact("aooi130", "ooag_t", "ooag002", "ooag001",g_fabg_m.fabg001)
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_fabg002
            LET g_action_choice="prog_fabg002"
            IF cl_auth_chk_act("prog_fabg002") THEN
               
               #add-point:ON ACTION prog_fabg002 name="menu.prog_fabg002"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               CALL cl_user_contact("aooi130", "ooag_t", "ooag002", "ooag001",g_fabg_m.fabg002)
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_fabg008
            LET g_action_choice="prog_fabg008"
            IF cl_auth_chk_act("prog_fabg008") THEN
               
               #add-point:ON ACTION prog_fabg008 name="menu.prog_fabg008"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               IF NOT cl_null(g_fabg_m.fabg008) THEN
                  INITIALIZE la_param.* TO NULL
                  LET la_param.prog     = 'aglt310'
                  LET la_param.param[1] = g_fabg_m.fabgld  #150727-00004#1 add
                  LET la_param.param[2] = g_fabg_m.fabg008 #150727-00004#1 mod
                  
                  LET ls_js = util.JSON.stringify(la_param)
                  CALL cl_cmdrun_wait(ls_js)
               END IF


               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL afat500_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL afat500_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL afat500_set_pk_array()
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
 
{<section id="afat500.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION afat500_browser_fill(ps_page_action)
   #add-point:browser_fill段define(客製用) name="browser_fill.define_customerization"
   
   #end add-point  
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   DEFINE l_ld_str          STRING #160125-00005#7
   
   IF cl_null(g_wc) THEN 
      LET g_wc = " fabg005 IN ('22','26') "
   ELSE
      LET g_wc = g_wc," AND fabg005 IN ('22','26')"
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
   #160125-00005#7--add--str--
   #账套范围
   CALL s_axrt300_get_site(g_user,'','2')  RETURNING g_wc_cs_ld 
   IF NOT cl_null(g_wc_cs_ld) THEN   
      LET l_ld_str = cl_replace_str(g_wc_cs_ld,"glaald","fabgld")
      LET l_wc = l_wc , " AND ",l_ld_str
   END IF
   #160125-00005#7--add--end
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT fabgld,fabgdocno ",
                      " FROM fabg_t ",
                      " ",
                      " LEFT JOIN fabs_t ON fabsent = fabgent AND fabgld = fabsld AND fabgdocno = fabsdocno ", "  ",
                      #add-point:browser_fill段sql(fabs_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
 
                      " ", 
                      " ", 
 
 
                      " WHERE fabgent = " ||g_enterprise|| " AND fabsent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("fabg_t")
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
      CALL g_fabs_d.clear()        
      CALL g_fabs2_d.clear() 
      CALL g_fabs3_d.clear() 
 
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
                  "  LEFT JOIN fabs_t ON fabsent = fabgent AND fabgld = fabsld AND fabgdocno = fabsdocno ", "  ", 
                  #add-point:browser_fill段sql(fabs_t1) name="browser_fill.join.fabs_t1"
                  
                  #end add-point
 
 
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
 
{<section id="afat500.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION afat500_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_fabg_m.fabgld = g_browser[g_current_idx].b_fabgld   
   LET g_fabg_m.fabgdocno = g_browser[g_current_idx].b_fabgdocno   
 
   EXECUTE afat500_master_referesh USING g_fabg_m.fabgld,g_fabg_m.fabgdocno INTO g_fabg_m.fabgsite,g_fabg_m.fabg001, 
       g_fabg_m.fabgld,g_fabg_m.fabg002,g_fabg_m.fabg003,g_fabg_m.fabg004,g_fabg_m.fabg005,g_fabg_m.fabgdocno, 
       g_fabg_m.fabgdocdt,g_fabg_m.fabg008,g_fabg_m.fabg009,g_fabg_m.fabgstus,g_fabg_m.fabgownid,g_fabg_m.fabgowndp, 
       g_fabg_m.fabgcrtid,g_fabg_m.fabgcrtdp,g_fabg_m.fabgcrtdt,g_fabg_m.fabgmodid,g_fabg_m.fabgmoddt, 
       g_fabg_m.fabgcnfid,g_fabg_m.fabgcnfdt,g_fabg_m.fabgpstid,g_fabg_m.fabgpstdt,g_fabg_m.fabgsite_desc, 
       g_fabg_m.fabg001_desc,g_fabg_m.fabgld_desc,g_fabg_m.fabg002_desc,g_fabg_m.fabg003_desc,g_fabg_m.fabgownid_desc, 
       g_fabg_m.fabgowndp_desc,g_fabg_m.fabgcrtid_desc,g_fabg_m.fabgcrtdp_desc,g_fabg_m.fabgmodid_desc, 
       g_fabg_m.fabgcnfid_desc,g_fabg_m.fabgpstid_desc
   
   CALL afat500_fabg_t_mask()
   CALL afat500_show()
      
END FUNCTION
 
{</section>}
 
{<section id="afat500.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION afat500_ui_detailshow()
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
 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="afat500.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION afat500_ui_browser_refresh()
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
 
{<section id="afat500.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION afat500_construct()
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
   DEFINE l_ooef017   LIKE ooef_t.ooef017   #161111-00049#12
   DEFINE l_ld_str    STRING                #161111-00049#12
   #end add-point    
   
   #add-point:Function前置處理  name="cs.pre_function"
   
   #end add-point
    
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_fabg_m.* TO NULL
   CALL g_fabs_d.clear()        
   CALL g_fabs2_d.clear() 
   CALL g_fabs3_d.clear() 
 
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前 name="cs.before_construct"
   LET g_site_str = NULL #160125-00005#7
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON fabgsite,fabg001,fabgld,fabg002,fabg003,fabg004,fabg005,fabgdocno,fabgdocdt, 
          fabg008,fabg009,fabgstus,fabgownid,fabgowndp,fabgcrtid,fabgcrtdp,fabgcrtdt,fabgmodid,fabgmoddt, 
          fabgcnfid,fabgcnfdt,fabgpstid,fabgpstdt
 
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
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #160426-00014#33--add--str--lujh
			   LET g_qryparam.where =" ooef207='Y'"    
            #CALL q_ooef001()                        #呼叫開窗          #161024-00008#4 
            CALL q_ooef001_47()                                         #161024-00008#4 
            #160426-00014#33--add--end--lujh
            #CALL q_faab001()                       #呼叫開窗      #160426-00014#33 mark lujh
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
            CALL FGL_DIALOG_GETBUFFER() RETURNING g_site_str #160125-00005#7
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabg001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabg001
            #add-point:ON ACTION controlp INFIELD fabg001 name="construct.c.fabg001"
            #此段落由子樣板a08產生
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
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            #160125-00005#7--add--str--
            #账套范围
            CALL s_axrt300_get_site(g_user,g_site_str,'2')  RETURNING g_wc_cs_ld 
            IF NOT cl_null(g_wc_cs_ld) THEN   
               LET g_qryparam.where = g_wc_cs_ld
            END IF
            #160125-00005#7--add--end
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
            
 
 
         #Ctrlp:construct.c.fabg002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabg002
            #add-point:ON ACTION controlp INFIELD fabg002 name="construct.c.fabg002"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabg002  #顯示到畫面上
            NEXT FIELD fabg002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabg002
            #add-point:BEFORE FIELD fabg002 name="construct.b.fabg002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabg002
            
            #add-point:AFTER FIELD fabg002 name="construct.a.fabg002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabg003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabg003
            #add-point:ON ACTION controlp INFIELD fabg003 name="construct.c.fabg003"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_today
            CALL q_ooeg001_4()                                #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabg003  #顯示到畫面上
            NEXT FIELD fabg003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabg003
            #add-point:BEFORE FIELD fabg003 name="construct.b.fabg003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabg003
            
            #add-point:AFTER FIELD fabg003 name="construct.a.fabg003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabg004
            #add-point:BEFORE FIELD fabg004 name="construct.b.fabg004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabg004
            
            #add-point:AFTER FIELD fabg004 name="construct.a.fabg004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabg004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabg004
            #add-point:ON ACTION controlp INFIELD fabg004 name="construct.c.fabg004"
            
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
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #LET g_qryparam.where = "fabg005 = '1'" #161104-00046#22 mark
            #161104-00046#22 add ------
            LET g_qryparam.where = "fabg005 IN ('22','26')"
            #單別權限控管
            IF NOT cl_null(g_user_dept_wc_q) AND NOT g_user_dept_wc_q = ' 1=1'  THEN
               LET g_qryparam.where = g_qryparam.where," AND ",g_user_dept_wc_q CLIPPED
            END IF
            #161104-00046#22 add end---
            CALL q_fabgdocno()
            DISPLAY g_qryparam.return1 TO fabgdocno
            NEXT FIELD fabgdocno
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
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabg008
            #add-point:BEFORE FIELD fabg008 name="construct.b.fabg008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabg008
            
            #add-point:AFTER FIELD fabg008 name="construct.a.fabg008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabg008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabg008
            #add-point:ON ACTION controlp INFIELD fabg008 name="construct.c.fabg008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabg009
            #add-point:BEFORE FIELD fabg009 name="construct.b.fabg009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabg009
            
            #add-point:AFTER FIELD fabg009 name="construct.a.fabg009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabg009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabg009
            #add-point:ON ACTION controlp INFIELD fabg009 name="construct.c.fabg009"
            
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
            #此段落由子樣板a08產生
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
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooea001_1()                           #呼叫開窗
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
            #此段落由子樣板a08產生
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
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooea001_1()                           #呼叫開窗
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
            #此段落由子樣板a08產生
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
            #此段落由子樣板a08產生
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
            #此段落由子樣板a08產生
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
      CONSTRUCT g_wc2_table1 ON fabsseq,fabs002,fabs003,fabs004,fabs005,fabs006,faah012,faah013,fabs009, 
          fabs010,fabs011,fabs012,fabn017_desc,fabs100,fabs101,fabs102,fabs150,fabs151,fabs152,fabs007, 
          fabs007_desc,fabs008,fabs008_desc,fabs014,fabs014_desc,fabs015,fabs015_desc,fabs016,fabs016_desc, 
          fabs017,fabs017_desc,fabs018,fabs018_desc,fabs019,fabs019_desc,fabs020,fabs020_desc,fabs022, 
          fabs022_desc,fabs024,fabs024_desc,fabs025,fabs025_desc
           FROM s_detail1[1].fabsseq,s_detail1[1].fabs002,s_detail1[1].fabs003,s_detail1[1].fabs004, 
               s_detail1[1].fabs005,s_detail1[1].fabs006,s_detail1[1].faah012,s_detail1[1].faah013,s_detail1[1].fabs009, 
               s_detail1[1].fabs010,s_detail1[1].fabs011,s_detail1[1].fabs012,s_detail1[1].fabn017_desc, 
               s_detail1[1].fabs100,s_detail1[1].fabs101,s_detail1[1].fabs102,s_detail1[1].fabs150,s_detail1[1].fabs151, 
               s_detail1[1].fabs152,s_detail2[1].fabs007,s_detail2[1].fabs007_desc,s_detail2[1].fabs008, 
               s_detail2[1].fabs008_desc,s_detail2[1].fabs014,s_detail2[1].fabs014_desc,s_detail2[1].fabs015, 
               s_detail2[1].fabs015_desc,s_detail2[1].fabs016,s_detail2[1].fabs016_desc,s_detail2[1].fabs017, 
               s_detail2[1].fabs017_desc,s_detail2[1].fabs018,s_detail2[1].fabs018_desc,s_detail2[1].fabs019, 
               s_detail2[1].fabs019_desc,s_detail2[1].fabs020,s_detail2[1].fabs020_desc,s_detail2[1].fabs022, 
               s_detail2[1].fabs022_desc,s_detail2[1].fabs024,s_detail2[1].fabs024_desc,s_detail2[1].fabs025, 
               s_detail2[1].fabs025_desc
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabsseq
            #add-point:BEFORE FIELD fabsseq name="construct.b.page1.fabsseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabsseq
            
            #add-point:AFTER FIELD fabsseq name="construct.a.page1.fabsseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fabsseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabsseq
            #add-point:ON ACTION controlp INFIELD fabsseq name="construct.c.page1.fabsseq"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.fabs002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabs002
            #add-point:ON ACTION controlp INFIELD fabs002 name="construct.c.page1.fabs002"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
           #CALL q_fabndocno()                           #呼叫開窗
            #161111-00049#12 add s---
            CALL s_axrt300_get_site(g_user,g_site,'2') RETURNING l_ld_str            
            SELECT ooef017 INTO l_ooef017 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
            LET g_qryparam.where = " fabgcomp IN (SELECT glaacomp FROM glaa_t WHERE ",l_ld_str,")"
            #161111-00049#12 add e---
            CALL q_fabs002()
            DISPLAY g_qryparam.return1 TO fabs002  #顯示到畫面上
            NEXT FIELD fabs002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabs002
            #add-point:BEFORE FIELD fabs002 name="construct.b.page1.fabs002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabs002
            
            #add-point:AFTER FIELD fabs002 name="construct.a.page1.fabs002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabs003
            #add-point:BEFORE FIELD fabs003 name="construct.b.page1.fabs003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabs003
            
            #add-point:AFTER FIELD fabs003 name="construct.a.page1.fabs003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fabs003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabs003
            #add-point:ON ACTION controlp INFIELD fabs003 name="construct.c.page1.fabs003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabs004
            #add-point:BEFORE FIELD fabs004 name="construct.b.page1.fabs004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabs004
            
            #add-point:AFTER FIELD fabs004 name="construct.a.page1.fabs004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fabs004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabs004
            #add-point:ON ACTION controlp INFIELD fabs004 name="construct.c.page1.fabs004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabs005
            #add-point:BEFORE FIELD fabs005 name="construct.b.page1.fabs005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabs005
            
            #add-point:AFTER FIELD fabs005 name="construct.a.page1.fabs005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fabs005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabs005
            #add-point:ON ACTION controlp INFIELD fabs005 name="construct.c.page1.fabs005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabs006
            #add-point:BEFORE FIELD fabs006 name="construct.b.page1.fabs006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabs006
            
            #add-point:AFTER FIELD fabs006 name="construct.a.page1.fabs006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fabs006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabs006
            #add-point:ON ACTION controlp INFIELD fabs006 name="construct.c.page1.fabs006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah012
            #add-point:BEFORE FIELD faah012 name="construct.b.page1.faah012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah012
            
            #add-point:AFTER FIELD faah012 name="construct.a.page1.faah012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.faah012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah012
            #add-point:ON ACTION controlp INFIELD faah012 name="construct.c.page1.faah012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah013
            #add-point:BEFORE FIELD faah013 name="construct.b.page1.faah013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah013
            
            #add-point:AFTER FIELD faah013 name="construct.a.page1.faah013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.faah013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah013
            #add-point:ON ACTION controlp INFIELD faah013 name="construct.c.page1.faah013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabs009
            #add-point:BEFORE FIELD fabs009 name="construct.b.page1.fabs009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabs009
            
            #add-point:AFTER FIELD fabs009 name="construct.a.page1.fabs009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fabs009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabs009
            #add-point:ON ACTION controlp INFIELD fabs009 name="construct.c.page1.fabs009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabs010
            #add-point:BEFORE FIELD fabs010 name="construct.b.page1.fabs010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabs010
            
            #add-point:AFTER FIELD fabs010 name="construct.a.page1.fabs010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fabs010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabs010
            #add-point:ON ACTION controlp INFIELD fabs010 name="construct.c.page1.fabs010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabs011
            #add-point:BEFORE FIELD fabs011 name="construct.b.page1.fabs011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabs011
            
            #add-point:AFTER FIELD fabs011 name="construct.a.page1.fabs011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fabs011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabs011
            #add-point:ON ACTION controlp INFIELD fabs011 name="construct.c.page1.fabs011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabs012
            #add-point:BEFORE FIELD fabs012 name="construct.b.page1.fabs012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabs012
            
            #add-point:AFTER FIELD fabs012 name="construct.a.page1.fabs012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fabs012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabs012
            #add-point:ON ACTION controlp INFIELD fabs012 name="construct.c.page1.fabs012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabn017
            #add-point:BEFORE FIELD fabn017 name="construct.b.page1.fabn017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabn017
            
            #add-point:AFTER FIELD fabn017 name="construct.a.page1.fabn017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fabn017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabn017
            #add-point:ON ACTION controlp INFIELD fabn017 name="construct.c.page1.fabn017"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabn017_desc
            #add-point:BEFORE FIELD fabn017_desc name="construct.b.page1.fabn017_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabn017_desc
            
            #add-point:AFTER FIELD fabn017_desc name="construct.a.page1.fabn017_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fabn017_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabn017_desc
            #add-point:ON ACTION controlp INFIELD fabn017_desc name="construct.c.page1.fabn017_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabs100
            #add-point:BEFORE FIELD fabs100 name="construct.b.page1.fabs100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabs100
            
            #add-point:AFTER FIELD fabs100 name="construct.a.page1.fabs100"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fabs100
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabs100
            #add-point:ON ACTION controlp INFIELD fabs100 name="construct.c.page1.fabs100"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabs101
            #add-point:BEFORE FIELD fabs101 name="construct.b.page1.fabs101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabs101
            
            #add-point:AFTER FIELD fabs101 name="construct.a.page1.fabs101"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fabs101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabs101
            #add-point:ON ACTION controlp INFIELD fabs101 name="construct.c.page1.fabs101"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabs102
            #add-point:BEFORE FIELD fabs102 name="construct.b.page1.fabs102"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabs102
            
            #add-point:AFTER FIELD fabs102 name="construct.a.page1.fabs102"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fabs102
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabs102
            #add-point:ON ACTION controlp INFIELD fabs102 name="construct.c.page1.fabs102"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabs150
            #add-point:BEFORE FIELD fabs150 name="construct.b.page1.fabs150"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabs150
            
            #add-point:AFTER FIELD fabs150 name="construct.a.page1.fabs150"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fabs150
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabs150
            #add-point:ON ACTION controlp INFIELD fabs150 name="construct.c.page1.fabs150"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabs151
            #add-point:BEFORE FIELD fabs151 name="construct.b.page1.fabs151"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabs151
            
            #add-point:AFTER FIELD fabs151 name="construct.a.page1.fabs151"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fabs151
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabs151
            #add-point:ON ACTION controlp INFIELD fabs151 name="construct.c.page1.fabs151"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabs152
            #add-point:BEFORE FIELD fabs152 name="construct.b.page1.fabs152"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabs152
            
            #add-point:AFTER FIELD fabs152 name="construct.a.page1.fabs152"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fabs152
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabs152
            #add-point:ON ACTION controlp INFIELD fabs152 name="construct.c.page1.fabs152"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.fabs007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabs007
            #add-point:ON ACTION controlp INFIELD fabs007 name="construct.c.page2.fabs007"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL aglt310_04()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabs007  #顯示到畫面上
            NEXT FIELD fabs007                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabs007
            #add-point:BEFORE FIELD fabs007 name="construct.b.page2.fabs007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabs007
            
            #add-point:AFTER FIELD fabs007 name="construct.a.page2.fabs007"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabs007_desc
            #add-point:BEFORE FIELD fabs007_desc name="construct.b.page2.fabs007_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabs007_desc
            
            #add-point:AFTER FIELD fabs007_desc name="construct.a.page2.fabs007_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fabs007_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabs007_desc
            #add-point:ON ACTION controlp INFIELD fabs007_desc name="construct.c.page2.fabs007_desc"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.fabs008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabs008
            #add-point:ON ACTION controlp INFIELD fabs008 name="construct.c.page2.fabs008"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL aglt310_04()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabs008  #顯示到畫面上
            NEXT FIELD fabs008                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabs008
            #add-point:BEFORE FIELD fabs008 name="construct.b.page2.fabs008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabs008
            
            #add-point:AFTER FIELD fabs008 name="construct.a.page2.fabs008"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabs008_desc
            #add-point:BEFORE FIELD fabs008_desc name="construct.b.page2.fabs008_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabs008_desc
            
            #add-point:AFTER FIELD fabs008_desc name="construct.a.page2.fabs008_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fabs008_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabs008_desc
            #add-point:ON ACTION controlp INFIELD fabs008_desc name="construct.c.page2.fabs008_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabs014
            #add-point:BEFORE FIELD fabs014 name="construct.b.page2.fabs014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabs014
            
            #add-point:AFTER FIELD fabs014 name="construct.a.page2.fabs014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fabs014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabs014
            #add-point:ON ACTION controlp INFIELD fabs014 name="construct.c.page2.fabs014"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.fabs014_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabs014_desc
            #add-point:ON ACTION controlp INFIELD fabs014_desc name="construct.c.page2.fabs014_desc"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001_1()                                     #161024-00008#4 
            #CALL q_ooef001()                            #呼叫開窗  #161024-00008#4           
            DISPLAY g_qryparam.return1 TO fabs014_desc  #顯示到畫面上
            NEXT FIELD fabs014_desc                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabs014_desc
            #add-point:BEFORE FIELD fabs014_desc name="construct.b.page2.fabs014_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabs014_desc
            
            #add-point:AFTER FIELD fabs014_desc name="construct.a.page2.fabs014_desc"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabs015
            #add-point:BEFORE FIELD fabs015 name="construct.b.page2.fabs015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabs015
            
            #add-point:AFTER FIELD fabs015 name="construct.a.page2.fabs015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fabs015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabs015
            #add-point:ON ACTION controlp INFIELD fabs015 name="construct.c.page2.fabs015"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.fabs015_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabs015_desc
            #add-point:ON ACTION controlp INFIELD fabs015_desc name="construct.c.page2.fabs015_desc"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_today   #20150113 add by chenying
            CALL q_ooeg001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabs015_desc  #顯示到畫面上
            NEXT FIELD fabs015_desc                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabs015_desc
            #add-point:BEFORE FIELD fabs015_desc name="construct.b.page2.fabs015_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabs015_desc
            
            #add-point:AFTER FIELD fabs015_desc name="construct.a.page2.fabs015_desc"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabs016
            #add-point:BEFORE FIELD fabs016 name="construct.b.page2.fabs016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabs016
            
            #add-point:AFTER FIELD fabs016 name="construct.a.page2.fabs016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fabs016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabs016
            #add-point:ON ACTION controlp INFIELD fabs016 name="construct.c.page2.fabs016"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.fabs016_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabs016_desc
            #add-point:ON ACTION controlp INFIELD fabs016_desc name="construct.c.page2.fabs016_desc"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " (ooeg003 = '2' OR ooeg003 = '3')"
            LET g_qryparam.arg1 = g_today
#           CALL q_ooeg001_4()  #20150113 mark by chenying     #呼叫開窗
           #CALL q_ooeg001_5()  #20150113 add by chenying     #161221-00054#4 MARK xul
            CALL q_ooeg001_15()       #161221-00054#4 add xul      
            DISPLAY g_qryparam.return1 TO fabs016_desc  #顯示到畫面上
            NEXT FIELD fabs016_desc                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabs016_desc
            #add-point:BEFORE FIELD fabs016_desc name="construct.b.page2.fabs016_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabs016_desc
            
            #add-point:AFTER FIELD fabs016_desc name="construct.a.page2.fabs016_desc"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabs017
            #add-point:BEFORE FIELD fabs017 name="construct.b.page2.fabs017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabs017
            
            #add-point:AFTER FIELD fabs017 name="construct.a.page2.fabs017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fabs017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabs017
            #add-point:ON ACTION controlp INFIELD fabs017 name="construct.c.page2.fabs017"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.fabs017_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabs017_desc
            #add-point:ON ACTION controlp INFIELD fabs017_desc name="construct.c.page2.fabs017_desc"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
#            LET g_qryparam.arg1 = '287'   #20150113 mark by chenying
#            CALL q_oocq002()              #20150113 mark by chenying
            CALL q_oocq002_287()           #20150113 add by chenying 
            DISPLAY g_qryparam.return1 TO fabs017_desc  #顯示到畫面上
            NEXT FIELD fabs017_desc                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabs017_desc
            #add-point:BEFORE FIELD fabs017_desc name="construct.b.page2.fabs017_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabs017_desc
            
            #add-point:AFTER FIELD fabs017_desc name="construct.a.page2.fabs017_desc"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabs018
            #add-point:BEFORE FIELD fabs018 name="construct.b.page2.fabs018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabs018
            
            #add-point:AFTER FIELD fabs018 name="construct.a.page2.fabs018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fabs018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabs018
            #add-point:ON ACTION controlp INFIELD fabs018 name="construct.c.page2.fabs018"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.fabs018_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabs018_desc
            #add-point:ON ACTION controlp INFIELD fabs018_desc name="construct.c.page2.fabs018_desc"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #CALL q_pmaa001()    #160913-00017#1  mark               #呼叫開窗
           CALL q_pmaa001_25() #160913-00017#1  add 
            DISPLAY g_qryparam.return1 TO fabs018_desc  #顯示到畫面上
            NEXT FIELD fabs018_desc                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabs018_desc
            #add-point:BEFORE FIELD fabs018_desc name="construct.b.page2.fabs018_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabs018_desc
            
            #add-point:AFTER FIELD fabs018_desc name="construct.a.page2.fabs018_desc"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabs019
            #add-point:BEFORE FIELD fabs019 name="construct.b.page2.fabs019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabs019
            
            #add-point:AFTER FIELD fabs019 name="construct.a.page2.fabs019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fabs019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabs019
            #add-point:ON ACTION controlp INFIELD fabs019 name="construct.c.page2.fabs019"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.fabs019_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabs019_desc
            #add-point:ON ACTION controlp INFIELD fabs019_desc name="construct.c.page2.fabs019_desc"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
             #CALL q_pmaa001()    #160913-00017#1  mark               #呼叫開窗
           CALL q_pmaa001_25() #160913-00017#1  add 
            DISPLAY g_qryparam.return1 TO fabs019_desc  #顯示到畫面上
            NEXT FIELD fabs019_desc                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabs019_desc
            #add-point:BEFORE FIELD fabs019_desc name="construct.b.page2.fabs019_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabs019_desc
            
            #add-point:AFTER FIELD fabs019_desc name="construct.a.page2.fabs019_desc"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabs020
            #add-point:BEFORE FIELD fabs020 name="construct.b.page2.fabs020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabs020
            
            #add-point:AFTER FIELD fabs020 name="construct.a.page2.fabs020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fabs020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabs020
            #add-point:ON ACTION controlp INFIELD fabs020 name="construct.c.page2.fabs020"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.fabs020_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabs020_desc
            #add-point:ON ACTION controlp INFIELD fabs020_desc name="construct.c.page2.fabs020_desc"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
#            LET g_qryparam.arg1 = '281'         #20150113 mark by chenying   
#            CALL q_oocq002()                    #20150113 mark by chenying          
            CALL q_oocq002_281()                 #20150113 add by chenying                        #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabs020_desc  #顯示到畫面上
            NEXT FIELD fabs020_desc                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabs020_desc
            #add-point:BEFORE FIELD fabs020_desc name="construct.b.page2.fabs020_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabs020_desc
            
            #add-point:AFTER FIELD fabs020_desc name="construct.a.page2.fabs020_desc"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabs022
            #add-point:BEFORE FIELD fabs022 name="construct.b.page2.fabs022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabs022
            
            #add-point:AFTER FIELD fabs022 name="construct.a.page2.fabs022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fabs022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabs022
            #add-point:ON ACTION controlp INFIELD fabs022 name="construct.c.page2.fabs022"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.fabs022_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabs022_desc
            #add-point:ON ACTION controlp INFIELD fabs022_desc name="construct.c.page2.fabs022_desc"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
#            CALL q_ooag001_2() #20150113 mark by chenying              
            CALL q_ooag001_8()  #20150113 add by chenying
            DISPLAY g_qryparam.return1 TO fabs022_desc  #顯示到畫面上
            NEXT FIELD fabs022_desc                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabs022_desc
            #add-point:BEFORE FIELD fabs022_desc name="construct.b.page2.fabs022_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabs022_desc
            
            #add-point:AFTER FIELD fabs022_desc name="construct.a.page2.fabs022_desc"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabs024
            #add-point:BEFORE FIELD fabs024 name="construct.b.page2.fabs024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabs024
            
            #add-point:AFTER FIELD fabs024 name="construct.a.page2.fabs024"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fabs024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabs024
            #add-point:ON ACTION controlp INFIELD fabs024 name="construct.c.page2.fabs024"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.fabs024_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabs024_desc
            #add-point:ON ACTION controlp INFIELD fabs024_desc name="construct.c.page2.fabs024_desc"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pjba001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabs024_desc  #顯示到畫面上
            NEXT FIELD fabs024_desc                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabs024_desc
            #add-point:BEFORE FIELD fabs024_desc name="construct.b.page2.fabs024_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabs024_desc
            
            #add-point:AFTER FIELD fabs024_desc name="construct.a.page2.fabs024_desc"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabs025
            #add-point:BEFORE FIELD fabs025 name="construct.b.page2.fabs025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabs025
            
            #add-point:AFTER FIELD fabs025 name="construct.a.page2.fabs025"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fabs025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabs025
            #add-point:ON ACTION controlp INFIELD fabs025 name="construct.c.page2.fabs025"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.fabs025_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabs025_desc
            #add-point:ON ACTION controlp INFIELD fabs025_desc name="construct.c.page2.fabs025_desc"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
#            CALL q_pjbb002_1()  #20150113 mark by chenying                                  
            CALL q_pjbb002_2()   #20150113 add by chenying                          #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabs025_desc  #顯示到畫面上
            NEXT FIELD fabs025_desc                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabs025_desc
            #add-point:BEFORE FIELD fabs025_desc name="construct.b.page2.fabs025_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabs025_desc
            
            #add-point:AFTER FIELD fabs025_desc name="construct.a.page2.fabs025_desc"
            
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
                  WHEN la_wc[li_idx].tableid = "fabg_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "fabs_t" 
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
   #161104-00046#22 add ------
   IF cl_null(g_user_dept_wc)THEN
      LET g_user_dept_wc = ' 1=1'
   END IF
   IF g_user_dept_wc <>  " 1=1" THEN
      LET g_wc = g_wc ," AND ", g_user_dept_wc CLIPPED
   END IF
   #161104-00046#22 add end---
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="afat500.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION afat500_query()
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
   CALL g_fabs_d.clear()
   CALL g_fabs2_d.clear()
   CALL g_fabs3_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL afat500_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL afat500_browser_fill("")
      CALL afat500_fetch("")
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
 
   LET g_error_show  = 1
   LET g_wc_filter   = ""
   LET l_ac = 1
   CALL FGL_SET_ARR_CURR(1)
   CALL afat500_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL afat500_fetch("F") 
      #顯示單身筆數
      CALL afat500_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="afat500.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION afat500_fetch(p_flag)
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
   EXECUTE afat500_master_referesh USING g_fabg_m.fabgld,g_fabg_m.fabgdocno INTO g_fabg_m.fabgsite,g_fabg_m.fabg001, 
       g_fabg_m.fabgld,g_fabg_m.fabg002,g_fabg_m.fabg003,g_fabg_m.fabg004,g_fabg_m.fabg005,g_fabg_m.fabgdocno, 
       g_fabg_m.fabgdocdt,g_fabg_m.fabg008,g_fabg_m.fabg009,g_fabg_m.fabgstus,g_fabg_m.fabgownid,g_fabg_m.fabgowndp, 
       g_fabg_m.fabgcrtid,g_fabg_m.fabgcrtdp,g_fabg_m.fabgcrtdt,g_fabg_m.fabgmodid,g_fabg_m.fabgmoddt, 
       g_fabg_m.fabgcnfid,g_fabg_m.fabgcnfdt,g_fabg_m.fabgpstid,g_fabg_m.fabgpstdt,g_fabg_m.fabgsite_desc, 
       g_fabg_m.fabg001_desc,g_fabg_m.fabgld_desc,g_fabg_m.fabg002_desc,g_fabg_m.fabg003_desc,g_fabg_m.fabgownid_desc, 
       g_fabg_m.fabgowndp_desc,g_fabg_m.fabgcrtid_desc,g_fabg_m.fabgcrtdp_desc,g_fabg_m.fabgmodid_desc, 
       g_fabg_m.fabgcnfid_desc,g_fabg_m.fabgpstid_desc
   
   #遮罩相關處理
   LET g_fabg_m_mask_o.* =  g_fabg_m.*
   CALL afat500_fabg_t_mask()
   LET g_fabg_m_mask_n.* =  g_fabg_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL afat500_set_act_visible()   
   CALL afat500_set_act_no_visible()
   
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
   CALL afat500_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="afat500.insert" >}
#+ 資料新增
PRIVATE FUNCTION afat500_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   DEFINE l_fabgcomp  LIKE fabg_t.fabgcomp
   DEFINE l_success   LIKE type_t.num5
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_fabs_d.clear()   
   CALL g_fabs2_d.clear()  
   CALL g_fabs3_d.clear()  
 
 
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
            LET g_fabg_m.fabg005 = "8"
      LET g_fabg_m.fabgstus = "N"
 
  
      #add-point:單頭預設值 name="insert.default"
      LET g_fabg_m.fabg001 = g_user
      CALL afat500_fabg001_desc() 
      DISPLAY BY NAME g_fabg_m.fabg001_desc  
      LET g_fabg_m.fabg005 = "22"
      LET g_fabg_m.fabg002 = g_user
      CALL afat500_fabg002_desc() 
      DISPLAY BY NAME g_fabg_m.fabg002_desc 
      
      SELECT ooag003 INTO g_fabg_m.fabg003
        FROM ooag_t
       WHERE ooagent = g_enterprise
         AND ooag001 = g_user
         
      CALL afat500_fabg003_desc() 
      DISPLAY BY NAME g_fabg_m.fabg003_desc 
      
      LET g_fabg_m.fabg004   = g_today
      LET g_fabg_m.fabgdocdt = g_today  
     #
     # SELECT faab002 INTO g_fabg_m.fabgsite FROM faab_t,ooag_t
     #  WHERE faab004 = ooag004 AND faabent = ooagent
     #    AND ooag001 = g_user AND ooagent = g_enterprise
     #    AND faab007 = 'Y' AND faab001= '4'
     #
     #SELECT DISTINCT glaald INTO g_fabg_m.fabgld 
     #  FROM glaa_t,ooef_t,ooag_t
     # WHERE ooag004 = ooef001 AND ooagent = ooefent AND glaacomp = ooef017 AND ooefent = glaaent AND glaa014 = 'Y'
     #   AND ooag001 = g_user AND glaaent = g_enterprise
     #DISPLAY BY NAME g_fabg_m.fabgld,g_fabg_m.fabgsite
     
     CALL s_afat503_default(g_bookno) RETURNING l_success,g_fabg_m.fabgsite,g_fabg_m.fabgld,l_fabgcomp #20141106
     IF cl_null(g_fabg_m.fabgsite) THEN
        LET g_fabg_m.fabg001 = NULL
     ELSE
        IF NOT s_afat502_site_user_chk(g_fabg_m.fabgsite,g_fabg_m.fabg001) THEN 
           LET g_fabg_m.fabg001 = NULL
        END IF 
     END IF
     
     CALL afat500_fabgld_desc()
     CALL afat500_fabgsite_desc()   
     LET g_fabg_m_t.* = g_fabg_m.*     
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
 
 
 
    
      CALL afat500_input("a")
      
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
         INITIALIZE g_fabs_d TO NULL
         INITIALIZE g_fabs2_d TO NULL
         INITIALIZE g_fabs3_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL afat500_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_fabs_d.clear()
      #CALL g_fabs2_d.clear()
      #CALL g_fabs3_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL afat500_set_act_visible()   
   CALL afat500_set_act_no_visible()
   
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
   CALL afat500_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE afat500_cl
   
   CALL afat500_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE afat500_master_referesh USING g_fabg_m.fabgld,g_fabg_m.fabgdocno INTO g_fabg_m.fabgsite,g_fabg_m.fabg001, 
       g_fabg_m.fabgld,g_fabg_m.fabg002,g_fabg_m.fabg003,g_fabg_m.fabg004,g_fabg_m.fabg005,g_fabg_m.fabgdocno, 
       g_fabg_m.fabgdocdt,g_fabg_m.fabg008,g_fabg_m.fabg009,g_fabg_m.fabgstus,g_fabg_m.fabgownid,g_fabg_m.fabgowndp, 
       g_fabg_m.fabgcrtid,g_fabg_m.fabgcrtdp,g_fabg_m.fabgcrtdt,g_fabg_m.fabgmodid,g_fabg_m.fabgmoddt, 
       g_fabg_m.fabgcnfid,g_fabg_m.fabgcnfdt,g_fabg_m.fabgpstid,g_fabg_m.fabgpstdt,g_fabg_m.fabgsite_desc, 
       g_fabg_m.fabg001_desc,g_fabg_m.fabgld_desc,g_fabg_m.fabg002_desc,g_fabg_m.fabg003_desc,g_fabg_m.fabgownid_desc, 
       g_fabg_m.fabgowndp_desc,g_fabg_m.fabgcrtid_desc,g_fabg_m.fabgcrtdp_desc,g_fabg_m.fabgmodid_desc, 
       g_fabg_m.fabgcnfid_desc,g_fabg_m.fabgpstid_desc
   
   
   #遮罩相關處理
   LET g_fabg_m_mask_o.* =  g_fabg_m.*
   CALL afat500_fabg_t_mask()
   LET g_fabg_m_mask_n.* =  g_fabg_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_fabg_m.fabgsite,g_fabg_m.fabgsite_desc,g_fabg_m.fabg001,g_fabg_m.fabg001_desc,g_fabg_m.fabgld, 
       g_fabg_m.fabgld_desc,g_fabg_m.fabg002,g_fabg_m.fabg002_desc,g_fabg_m.fabg003,g_fabg_m.fabg003_desc, 
       g_fabg_m.fabg004,g_fabg_m.fabg005,g_fabg_m.fabgdocno,g_fabg_m.fabgdocdt,g_fabg_m.fabg008,g_fabg_m.fabg009, 
       g_fabg_m.fabgstus,g_fabg_m.fabgownid,g_fabg_m.fabgownid_desc,g_fabg_m.fabgowndp,g_fabg_m.fabgowndp_desc, 
       g_fabg_m.fabgcrtid,g_fabg_m.fabgcrtid_desc,g_fabg_m.fabgcrtdp,g_fabg_m.fabgcrtdp_desc,g_fabg_m.fabgcrtdt, 
       g_fabg_m.fabgmodid,g_fabg_m.fabgmodid_desc,g_fabg_m.fabgmoddt,g_fabg_m.fabgcnfid,g_fabg_m.fabgcnfid_desc, 
       g_fabg_m.fabgcnfdt,g_fabg_m.fabgpstid,g_fabg_m.fabgpstid_desc,g_fabg_m.fabgpstdt
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_fabg_m.fabgownid      
   LET g_data_dept  = g_fabg_m.fabgowndp
   
   #功能已完成,通報訊息中心
   CALL afat500_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="afat500.modify" >}
#+ 資料修改
PRIVATE FUNCTION afat500_modify()
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
   
   OPEN afat500_cl USING g_enterprise,g_fabg_m.fabgld,g_fabg_m.fabgdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN afat500_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE afat500_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE afat500_master_referesh USING g_fabg_m.fabgld,g_fabg_m.fabgdocno INTO g_fabg_m.fabgsite,g_fabg_m.fabg001, 
       g_fabg_m.fabgld,g_fabg_m.fabg002,g_fabg_m.fabg003,g_fabg_m.fabg004,g_fabg_m.fabg005,g_fabg_m.fabgdocno, 
       g_fabg_m.fabgdocdt,g_fabg_m.fabg008,g_fabg_m.fabg009,g_fabg_m.fabgstus,g_fabg_m.fabgownid,g_fabg_m.fabgowndp, 
       g_fabg_m.fabgcrtid,g_fabg_m.fabgcrtdp,g_fabg_m.fabgcrtdt,g_fabg_m.fabgmodid,g_fabg_m.fabgmoddt, 
       g_fabg_m.fabgcnfid,g_fabg_m.fabgcnfdt,g_fabg_m.fabgpstid,g_fabg_m.fabgpstdt,g_fabg_m.fabgsite_desc, 
       g_fabg_m.fabg001_desc,g_fabg_m.fabgld_desc,g_fabg_m.fabg002_desc,g_fabg_m.fabg003_desc,g_fabg_m.fabgownid_desc, 
       g_fabg_m.fabgowndp_desc,g_fabg_m.fabgcrtid_desc,g_fabg_m.fabgcrtdp_desc,g_fabg_m.fabgmodid_desc, 
       g_fabg_m.fabgcnfid_desc,g_fabg_m.fabgpstid_desc
   
   #檢查是否允許此動作
   IF NOT afat500_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_fabg_m_mask_o.* =  g_fabg_m.*
   CALL afat500_fabg_t_mask()
   LET g_fabg_m_mask_n.* =  g_fabg_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   #151231-00005#3--add--str--lujh
   IF NOT cl_null(g_fabg_m.fabgdocdt) THEN 
      IF NOT s_afa_date_chk(g_fabg_m.fabgld,'',g_fabg_m.fabgdocdt) THEN 
         CLOSE afat500_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF 
   END IF 
   #151231-00005#3--add--end--lujh
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
 
   
   CALL afat500_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
 
    
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
      CALL afat500_input("u")
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
            CALL afat500_show()
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
         UPDATE fabs_t SET fabsld = g_fabg_m.fabgld
                                       ,fabsdocno = g_fabg_m.fabgdocno
 
          WHERE fabsent = g_enterprise AND fabsld = g_fabg_m_t.fabgld
            AND fabsdocno = g_fabg_m_t.fabgdocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "fabs_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "fabs_t:",SQLERRMESSAGE 
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
   CALL afat500_set_act_visible()   
   CALL afat500_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " fabgent = " ||g_enterprise|| " AND",
                      " fabgld = '", g_fabg_m.fabgld, "' "
                      ," AND fabgdocno = '", g_fabg_m.fabgdocno, "' "
 
   #填到對應位置
   CALL afat500_browser_fill("")
 
   CLOSE afat500_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL afat500_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="afat500.input" >}
#+ 資料輸入
PRIVATE FUNCTION afat500_input(p_cmd)
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
   DEFINE  l_faab004             LIKE faab_t.faab004
   DEFINE  l_ooag004             LIKE ooag_t.ooag004
   DEFINE  l_ooef004             LIKE ooef_t.ooef004
   DEFINE  l_fabn015             LIKE fabn_t.fabn015
   DEFINE  l_success             LIKE type_t.num5
   DEFINE  l_ooab002             LIKE ooab_t.ooab002
   DEFINE  l_origin_str          STRING   #組織範圍
   DEFINE  l_year                LIKE type_t.num5    
   DEFINE  l_month               LIKE type_t.num5  
   DEFINE  l_fabacomp            LIKE faba_t.fabacomp
   DEFINE  l_glaacomp            LIKE glaa_t.glaacomp  
   DEFINE  l_glac003             LIKE glac_t.glac003
   #ADD BY XZG20151203 B
   DEFINE l_sql                  STRING
   DEFINE l_glaa004              LIKE  glaa_t.glaa004 
   #ADD BY XZG20151203 e
   #151125-00006#2-add-s
   DEFINE  l_ooba002             LIKE ooba_t.ooba002
   DEFINE  l_dfin0031            LIKE type_t.chr1
   DEFINE  l_dfin0032            LIKE type_t.chr1
   DEFINE  l_fabgcomp            LIKE fabg_t.fabgcomp
   DEFINE  l_ld                  LIKE fabg_t.fabgld
   DEFINE  l_flag                LIKE type_t.num5      #161104-00046#22
   #151125-00006#2-add-e
   #161221-00054#4--add--s--xul
   DEFINE l_wc                   STRING
   DEFINE l_glak_sql             STRING
   #161221-00054#4--add--e--xul
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
       g_fabg_m.fabgld_desc,g_fabg_m.fabg002,g_fabg_m.fabg002_desc,g_fabg_m.fabg003,g_fabg_m.fabg003_desc, 
       g_fabg_m.fabg004,g_fabg_m.fabg005,g_fabg_m.fabgdocno,g_fabg_m.fabgdocdt,g_fabg_m.fabg008,g_fabg_m.fabg009, 
       g_fabg_m.fabgstus,g_fabg_m.fabgownid,g_fabg_m.fabgownid_desc,g_fabg_m.fabgowndp,g_fabg_m.fabgowndp_desc, 
       g_fabg_m.fabgcrtid,g_fabg_m.fabgcrtid_desc,g_fabg_m.fabgcrtdp,g_fabg_m.fabgcrtdp_desc,g_fabg_m.fabgcrtdt, 
       g_fabg_m.fabgmodid,g_fabg_m.fabgmodid_desc,g_fabg_m.fabgmoddt,g_fabg_m.fabgcnfid,g_fabg_m.fabgcnfid_desc, 
       g_fabg_m.fabgcnfdt,g_fabg_m.fabgpstid,g_fabg_m.fabgpstid_desc,g_fabg_m.fabgpstdt
   
   #切換畫面
 
   CALL cl_set_head_visible("","YES")  
 
   LET l_insert = FALSE
   LET g_action_choice = ""
 
   #add-point:input段define_sql name="input.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT fabsseq,fabs002,fabs003,fabs004,fabs005,fabs006,fabs009,fabs010,fabs011, 
       fabs012,fabs100,fabs101,fabs102,fabs150,fabs151,fabs152,fabsseq,fabs007,fabs008,fabs014,fabs015, 
       fabs016,fabs017,fabs018,fabs019,fabs020,fabs022,fabs024,fabs025,fabsseq,fabs100,fabs101,fabs102, 
       fabs150,fabs151,fabs152 FROM fabs_t WHERE fabsent=? AND fabsld=? AND fabsdocno=? AND fabsseq=?  
       FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE afat500_bcl CURSOR FROM g_forupd_sql
   
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL afat500_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL afat500_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_fabg_m.fabgsite,g_fabg_m.fabg001,g_fabg_m.fabgld,g_fabg_m.fabg002,g_fabg_m.fabg003, 
       g_fabg_m.fabg004,g_fabg_m.fabg005,g_fabg_m.fabgdocno,g_fabg_m.fabgdocdt,g_fabg_m.fabg008,g_fabg_m.fabg009, 
       g_fabg_m.fabgstus
   
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
 
{<section id="afat500.input.head" >}
      #單頭段
      INPUT BY NAME g_fabg_m.fabgsite,g_fabg_m.fabg001,g_fabg_m.fabgld,g_fabg_m.fabg002,g_fabg_m.fabg003, 
          g_fabg_m.fabg004,g_fabg_m.fabg005,g_fabg_m.fabgdocno,g_fabg_m.fabgdocdt,g_fabg_m.fabg008,g_fabg_m.fabg009, 
          g_fabg_m.fabgstus 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN afat500_cl USING g_enterprise,g_fabg_m.fabgld,g_fabg_m.fabgdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN afat500_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE afat500_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL afat500_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            
            #end add-point
            CALL afat500_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabgsite
            
            #add-point:AFTER FIELD fabgsite name="input.a.fabgsite"
#160426-00014#33--mark--str--lujh
#           LET g_fabg_m.fabgsite_desc = ''
#           DISPLAY BY NAME g_fabg_m.fabgsite_desc
#           IF NOT cl_null(g_fabg_m.fabgsite) THEN
#               #检查组织资料的合理性             
#               IF NOT s_afat502_site_chk(g_fabg_m.fabgsite ) THEN
#                  LET g_fabg_m.fabgsite = g_fabg_m_t.fabgsite
#                  CALL afat500_fabgsite_desc()
#                  NEXT FIELD CURRENT
#               END IF 
#               #帳務人員不為空需要檢查和資產中心的權限
#               IF NOT cl_null(g_fabg_m.fabg001) THEN
#                  IF NOT s_afat502_site_user_chk(g_fabg_m.fabgsite,g_fabg_m.fabg001) THEN
#                     LET g_fabg_m.fabgsite = g_fabg_m_t.fabgsite
#                     CALL afat500_fabgsite_desc()
#                     NEXT FIELD CURRENT  
#                  END IF
#               END IF   
#               #帐套不为空检查法人归属是否相同
#               IF NOT cl_null(g_fabg_m.fabgld) THEN
#                  IF NOT s_afat502_site_ld_chk(g_fabg_m.fabgsite,g_fabg_m.fabgld) THEN
#                     LET g_fabg_m.fabgsite = g_fabg_m_t.fabgsite
#                     CALL afat500_fabgsite_desc()
#                     NEXT FIELD CURRENT  
#                  END IF
#               END IF               
#             ################################################################mark by huangtao
#             
#            END IF           
#
#            CALL afat500_fabgsite_desc()
#160426-00014#33--mark--end--lujh

#160426-00014#33--add--str--lujh
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
               END IF
            END IF
            CALL s_fin_account_center_sons_query('5',g_fabg_m.fabgsite,g_today,'1')
            LET g_fabg_m_t.fabgsite = g_fabg_m.fabgsite
            LET g_fabg_m_t.fabgld = g_fabg_m.fabgld
            CALL s_desc_get_department_desc(g_fabg_m.fabgsite) RETURNING g_fabg_m.fabgsite_desc
            CALL s_desc_get_ld_desc(g_fabg_m.fabgld) RETURNING g_fabg_m.fabgld_desc
            DISPLAY BY NAME g_fabg_m.fabgsite_desc,g_fabg_m.fabgld_desc
#160426-00014#33--add--end--lujh
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
#160426-00014#33--mark--str--lujh
#            IF NOT cl_null(g_fabg_m.fabg001) THEN
#               INITIALIZE g_chkparam.* TO NULL
#
#               #設定g_chkparam.*的參數
#               LET g_chkparam.arg1=g_fabg_m.fabg001
#               #160318-00025#6--add--str
#               LET g_errshow = TRUE 
#               LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
#               #160318-00025#6--add--end
#               #檢查是否存在  員工資料檔中
#               IF NOT cl_chk_exist("v_ooag001") THEN 
#                  LET g_fabg_m.fabg001 = g_fabg_m_t.fabg001
#                   CALL afat500_fabg001_desc()
#                  NEXT FIELD CURRENT
#               END IF      
#                #資產中心不為空的情況下
#               IF NOT cl_null(g_fabg_m.fabgsite) THEN   
#                  IF NOT s_afat502_site_user_chk(g_fabg_m.fabgsite,g_fabg_m.fabg001) THEN
#                     LET g_fabg_m.fabg001 = g_fabg_m_t.fabg001
#                     CALL afat500_fabg001_desc()
#                     NEXT FIELD CURRENT
#                  END IF
#                END IF
#               #帳套不為空時
#               IF NOT cl_null(g_fabg_m.fabgld) THEN
#                  IF NOT s_ld_chk_authorization(g_fabg_m.fabg001,g_fabg_m.fabgld) THEN
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code = 'axr-00022'     
#                     LET g_errparam.extend = ''
#                     LET g_errparam.popup = TRUE
#                     CALL cl_err() 
#                     LET g_fabg_m.fabg001 = g_fabg_m_t.fabg001
#                     CALL afat500_fabg001_desc()
#                     NEXT FIELD CURRENT
#                  END IF  
#               END IF
#               #######################################mark by huangtao                  
#                            
#            END IF    
#            CALL afat500_fabg001_desc() 
#160426-00014#33--mark--end--lujh

#160426-00014#33--add--str--lujh
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
                  NEXT FIELD CURRENT
               END IF
            END IF 
            CALL s_desc_get_person_desc(g_fabg_m.fabg001) RETURNING g_fabg_m.fabg001_desc
            DISPLAY BY NAME g_fabg_m.fabg001_desc  
#160426-00014#33--add--end--lujh

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
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_fabg_m.fabgld) AND NOT cl_null(g_fabg_m.fabgdocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_fabg_m.fabgld != g_fabgld_t  OR g_fabg_m.fabgdocno != g_fabgdocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM fabg_t WHERE "||"fabgent = '" ||g_enterprise|| "' AND "||"fabgld = '"||g_fabg_m.fabgld ||"' AND "|| "fabgdocno = '"||g_fabg_m.fabgdocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

#160426-00014#33--mark--str--lujh
#            IF NOT cl_null(g_fabg_m.fabgld) THEN 
##此段落由子樣板a19產生
#               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
#               INITIALIZE g_chkparam.* TO NULL
#               
#               #設定g_chkparam.*的參數
#               LET g_chkparam.arg1 = g_fabg_m.fabgld
#               #160318-00025#6--add--str
#               LET g_errshow = TRUE 
#               LET g_chkparam.err_str[1] = "agl-00051:sub-01302|agli010|",cl_get_progname("agli010",g_lang,"2"),"|:EXEPROGagli010"
#               #160318-00025#6--add--end
#                  
#               #呼叫檢查存在並帶值的library
#               IF cl_chk_exist("v_fabgld") THEN
#                  #檢查成功時後續處理
#                  #LET  = g_chkparam.return1
#                  #DISPLAY BY NAME 
#                  CALL afat500_glaa_visible()
#               ELSE
#                  #檢查失敗時後續處理
#                  LET g_fabg_m.fabgld = g_fabg_m_t.fabgld
#                  CALL afat500_fabgld_desc()
#                  DISPLAY BY NAME g_fabg_m.fabgld,g_fabg_m.fabgld_desc 
#                  NEXT FIELD CURRENT
#               END IF
#               ######################################mark by huangtao
#               #帐套人员不为空时
#               IF NOT cl_null(g_fabg_m.fabg001) THEN
#                  IF NOT s_ld_chk_authorization(g_fabg_m.fabg001,g_fabg_m.fabgld) THEN
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code = 'axr-00022'
#                     LET g_errparam.extend = g_fabg_m.fabgld
#                     LET g_errparam.popup = FALSE
#                     CALL cl_err()
#                 
#                    #LET g_fabg_m.fabgld = ''
#                    #LET g_fabg_m.fabgld_desc = ''
#                    #DISPLAY BY NAME g_fabg_m.fabgld,g_fabg_m.fabgld_desc
#                    LET g_fabg_m.fabgld = g_fabg_m_t.fabgld
#                    CALL afat500_fabgld_desc()
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#               #资产中心不为空时
#               IF NOT cl_null(g_fabg_m.fabgsite) THEN
#                  IF NOT s_afat502_site_ld_chk(g_fabg_m.fabgsite,g_fabg_m.fabgld) THEN
#                     LET g_fabg_m.fabgld = g_fabg_m_t.fabgld
#                     CALL afat500_fabgld_desc()
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#               ##############################################mark by huangtao
#            END IF 
#            
#            CALL afat500_fabgld_desc()
#160426-00014#33--mark--end--lujh

#160426-00014#33--add--str--lujh
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
               END IF
            END IF
            LET g_fabg_m_t.fabgld = g_fabg_m.fabgld
            CALL s_desc_get_ld_desc(g_fabg_m.fabgld) RETURNING g_fabg_m.fabgld_desc
            DISPLAY BY NAME g_fabg_m.fabgld_desc
#160426-00014#33--add--end--lujh            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabgld
            #add-point:BEFORE FIELD fabgld name="input.b.fabgld"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabgld
            #add-point:ON CHANGE fabgld name="input.g.fabgld"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabg002
            
            #add-point:AFTER FIELD fabg002 name="input.a.fabg002"
            IF NOT cl_null(g_fabg_m.fabg002) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fabg_m.fabg002
               #160318-00025#6--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
               #160318-00025#6--add--end  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooag001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_fabg_m.fabg002 = g_fabg_m_t.fabg002
                  CALL afat500_fabg002_desc()
                  NEXT FIELD CURRENT
               END IF
               SELECT ooag003 INTO g_fabg_m.fabg003
                 FROM ooag_t
                WHERE ooagent = g_enterprise
                  AND ooag001 = g_fabg_m.fabg002
                  
               CALL afat500_fabg003_desc() 
               DISPLAY BY NAME g_fabg_m.fabg003_desc 
            END IF 
            CALL afat500_fabg002_desc()

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabg002
            #add-point:BEFORE FIELD fabg002 name="input.b.fabg002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabg002
            #add-point:ON CHANGE fabg002 name="input.g.fabg002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabg003
            
            #add-point:AFTER FIELD fabg003 name="input.a.fabg003"
            IF NOT cl_null(g_fabg_m.fabg003) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fabg_m.fabg003
               LET g_chkparam.arg2 = g_today
               #160318-00025#6--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#6--add--end   
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooeg001_3") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                  IF NOT cl_null(g_fabg_m.fabg002) THEN 
                     INITIALIZE g_chkparam.* TO NULL
               
                     #設定g_chkparam.*的參數
                     LET g_chkparam.arg1 = g_fabg_m.fabg002
                     LET g_chkparam.arg2 = g_fabg_m.fabg003
                        
                     #呼叫檢查存在並帶值的library
                     IF cl_chk_exist("v_ooag003") THEN
                        #檢查成功時後續處理
                        #LET  = g_chkparam.return1
                        #DISPLAY BY NAME 
                     ELSE
                        #檢查失敗時後續處理
                        LET g_fabg_m.fabg003 = g_fabg_m_t.fabg003
                        CALL afat500_fabg003_desc()
                        NEXT FIELD CURRENT
                     END IF
                  END IF 
               ELSE
                  #檢查失敗時後續處理
                  LET g_fabg_m.fabg003 = g_fabg_m_t.fabg003
                  CALL afat500_fabg003_desc()
                  NEXT FIELD CURRENT
               END IF
           
            END IF 
            CALL afat500_fabg003_desc()
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabg003
            #add-point:BEFORE FIELD fabg003 name="input.b.fabg003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabg003
            #add-point:ON CHANGE fabg003 name="input.g.fabg003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabg004
            #add-point:BEFORE FIELD fabg004 name="input.b.fabg004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabg004
            
            #add-point:AFTER FIELD fabg004 name="input.a.fabg004"
#            IF NOT cl_null(g_fabg_m.fabg004) THEN 
#               #單據日期不能小於關賬日期
#               #S-FIN-9003
#               SELECT * INTO g_glaa.* FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_fabg_m.fabgld
#               SELECT ooab002 INTO l_ooab002 FROM ooab_t
#                WHERE ooabent = g_enterprise
#                  AND ooab001 = 'S-FIN-9003'
#                  AND ooabsite = g_glaa.glaacomp 
#              IF g_fabg_m.fabg004 <= l_ooab002 THEN 
#                 INITIALIZE g_errparam TO NULL
#                 LET g_errparam.code = 'afa-00060'
#                 LET g_errparam.extend = ''
#                 LET g_errparam.popup = TRUE
#                 CALL cl_err()
#
#                 LET g_fabg_m.fabg004 = g_fabg_m_t.fabg004
#                 NEXT FIELD fabg004
#              END IF
#            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabg004
            #add-point:ON CHANGE fabg004 name="input.g.fabg004"
            
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
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_fabg_m.fabgld) AND NOT cl_null(g_fabg_m.fabgdocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_fabg_m.fabgld != g_fabgld_t  OR g_fabg_m.fabgdocno != g_fabgdocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM fabg_t WHERE "||"fabgent = '" ||g_enterprise|| "' AND "||"fabgld = '"||g_fabg_m.fabgld ||"' AND "|| "fabgdocno = '"||g_fabg_m.fabgdocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            IF NOT cl_null(g_fabg_m.fabgdocno) THEN
               #161215-00044#1---modify----begin-----------------
               #SELECT * INTO g_glaa.* 
               SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,
                      glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,glaa011,
                      glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,glaa023,
                      glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,glaa113,glaa120,glaa121,
                      glaa122,glaa027,glaa130,glaa131,glaa132,glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,
                      glaa140,glaa123,glaa124,glaa028 INTO g_glaa.* 
               #161215-00044#1---modify----end-----------------
               FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_fabg_m.fabgld 
               IF NOT s_aooi200_fin_chk_slip(g_fabg_m.fabgld,g_glaa.glaa024,g_fabg_m.fabgdocno,'afat500') THEN
                  LET g_fabg_m.fabgdocno = g_fabg_m_t.fabgdocno
                  NEXT FIELD CURRENT
               END IF
               #161104-00046#22 add ------
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
               #161104-00046#22 add end---
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
               #161215-00044#1---modify----begin-----------------
               #SELECT * INTO g_glaa.* 
               SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,
                      glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,glaa011,
                      glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,glaa023,
                      glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,glaa113,glaa120,glaa121,
                      glaa122,glaa027,glaa130,glaa131,glaa132,glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,
                      glaa140,glaa123,glaa124,glaa028 INTO g_glaa.* 
               #161215-00044#1---modify----end----------------- 
               FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_fabg_m.fabgld
               SELECT ooab002 INTO l_ooab002 FROM ooab_t
                WHERE ooabent = g_enterprise
                  AND ooab001 = 'S-FIN-9003'
                  AND ooabsite = g_glaa.glaacomp 
              IF g_fabg_m.fabgdocdt <= l_ooab002 THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = 'afa-00060'
                 LET g_errparam.extend = ''
                 LET g_errparam.popup = TRUE
                 CALL cl_err()

                 LET g_fabg_m.fabgdocdt = g_fabg_m_t.fabgdocdt
                 NEXT FIELD fabgdocdt
              END IF
              #现行年月检查
              CALL cl_get_para(g_enterprise,g_glaa.glaacomp,'S-FIN-9018') RETURNING l_year
              CALL cl_get_para(g_enterprise,g_glaa.glaacomp,'S-FIN-9019') RETURNING l_month
              IF l_year <> YEAR(g_fabg_m.fabgdocdt) OR l_month <> MONTH(g_fabg_m.fabgdocdt) THEN
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = 'afa-00283'
                 LET g_errparam.extend = ''
                 LET g_errparam.popup = TRUE
                 CALL cl_err()
                 LET g_fabg_m.fabgdocdt = g_fabg_m_t.fabgdocdt
                 NEXT FIELD fabgdocdt
              END IF              
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabgdocdt
            #add-point:ON CHANGE fabgdocdt name="input.g.fabgdocdt"
            
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
         BEFORE FIELD fabg009
            #add-point:BEFORE FIELD fabg009 name="input.b.fabg009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabg009
            
            #add-point:AFTER FIELD fabg009 name="input.a.fabg009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabg009
            #add-point:ON CHANGE fabg009 name="input.g.fabg009"
            
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
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabg_m.fabgsite             #給予default值
 
#            IF NOT cl_null(g_fabg_m.fabg001) THEN    
#               LET g_qryparam.where = " faab004 IN (SELECT ooag004 FROM ooag_t WHERE ooagent = '",g_enterprise,"' AND ooag001 ='",g_fabg_m.fabg001,"')"
#            END IF

            #給予arg
            LET g_qryparam.arg1 = "" #

            #160426-00014#33--add--str--lujh
			   LET g_qryparam.where =" ooef207='Y'"    
            #CALL q_ooef001()                        #呼叫開窗
            CALL q_ooef001_47()                                         #161024-00008#4 
            #160426-00014#33--add--end--lujh
            #CALL q_ooef001_6()                     #呼叫開窗   #160426-00014#33 mark lujh

            LET g_fabg_m.fabgsite = g_qryparam.return1              

            DISPLAY g_fabg_m.fabgsite TO fabgsite              #
            CALL afat500_fabgsite_desc()
            NEXT FIELD fabgsite                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.fabg001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabg001
            #add-point:ON ACTION controlp INFIELD fabg001 name="input.c.fabg001"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabg_m.fabg001             #給予default值

            #獲取當前資產中心的組織編號
#            IF NOT cl_null(g_fabg_m.fabgsite) THEN 
#              LET g_qryparam.where = " ooag004 IN (SELECT faab004 FROM faab_t WHERE faabent =  '",g_enterprise,"' AND faab001 = '4' AND faab002 = '",g_fabg_m.fabgsite,"' AND faab007 = 'Y' AND faabstus = 'Y' )" 
#            END IF
#
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooag001()                                #呼叫開窗

            LET g_fabg_m.fabg001 = g_qryparam.return1              

            DISPLAY g_fabg_m.fabg001 TO fabg001              #
            CALL afat500_fabg001_desc()
            NEXT FIELD fabg001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.fabgld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabgld
            #add-point:ON ACTION controlp INFIELD fabgld name="input.c.fabgld"
            #此段落由子樣板a07產生            
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
            CALL afat500_change_to_sql(l_origin_str) RETURNING l_origin_str  
            
            LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') AND glaacomp IN (",l_origin_str," )"
            #給予arg
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            
            CALL q_authorised_ld()                                #呼叫開窗

            LET g_fabg_m.fabgld = g_qryparam.return1              

            DISPLAY g_fabg_m.fabgld TO fabgld              #
            CALL afat500_fabgld_desc()
            NEXT FIELD fabgld                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.fabg002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabg002
            #add-point:ON ACTION controlp INFIELD fabg002 name="input.c.fabg002"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabg_m.fabg002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooag001()                                #呼叫開窗

            LET g_fabg_m.fabg002 = g_qryparam.return1              

            DISPLAY g_fabg_m.fabg002 TO fabg002              #
            CALL afat500_fabg002_desc()
            NEXT FIELD fabg002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.fabg003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabg003
            #add-point:ON ACTION controlp INFIELD fabg003 name="input.c.fabg003"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabg_m.fabg003             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_today

            
            CALL q_ooeg001_4()                                #呼叫開窗

            LET g_fabg_m.fabg003 = g_qryparam.return1              

            DISPLAY g_fabg_m.fabg003 TO fabg003              #
            CALL afat500_fabg003_desc()
            NEXT FIELD fabg003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.fabg004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabg004
            #add-point:ON ACTION controlp INFIELD fabg004 name="input.c.fabg004"
            
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
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_fabg_m.fabgdocno
#            SELECT ooef004 INTO l_ooef004 from ooef_t,ooag_t
#             WHERE ooefent=ooagent AND ooefent = g_enterprise
#               AND ooef001 = ooag004 AND ooag001 = g_user
            #161215-00044#1---modify----begin-----------------
            #SELECT * INTO g_glaa.* 
            SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,
                   glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,glaa011,
                   glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,glaa023,
                   glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,glaa113,glaa120,glaa121,
                   glaa122,glaa027,glaa130,glaa131,glaa132,glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,
                   glaa140,glaa123,glaa124,glaa028 INTO g_glaa.* 
            #161215-00044#1---modify----end-----------------
            FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_fabg_m.fabgld 
            LET g_qryparam.arg1 = g_glaa.glaa024
            #LET g_qryparam.arg2 = "afat500"     #160705-00042#2 160711 by sakura mark
            LET g_qryparam.arg2 = g_prog         #160705-00042#2 160711 by sakura add
            #161104-00046#22 add ------
            IF NOT cl_null(g_user_slip_wc)THEN
               LET g_qryparam.where = g_user_slip_wc
            END IF
            #161104-00046#22 add end---
            CALL q_ooba002_1()
            LET g_fabg_m.fabgdocno = g_qryparam.return1
            DISPLAY g_fabg_m.fabgdocno TO fabgdocno
            NEXT FIELD fabgdocno
            #END add-point
 
 
         #Ctrlp:input.c.fabgdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabgdocdt
            #add-point:ON ACTION controlp INFIELD fabgdocdt name="input.c.fabgdocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.fabg008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabg008
            #add-point:ON ACTION controlp INFIELD fabg008 name="input.c.fabg008"
            
            #END add-point
 
 
         #Ctrlp:input.c.fabg009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabg009
            #add-point:ON ACTION controlp INFIELD fabg009 name="input.c.fabg009"
            
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
            #161215-00044#1---modify----begin-----------------
            #SELECT * INTO g_glaa.* 
            SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,
                   glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,glaa011,
                   glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,glaa023,
                   glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,glaa113,glaa120,glaa121,
                   glaa122,glaa027,glaa130,glaa131,glaa132,glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,
                   glaa140,glaa123,glaa124,glaa028 INTO g_glaa.* 
            #161215-00044#1---modify----end-----------------
            FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_fabg_m.fabgld 
            CALL afat500_glaa_visible()  #add by huangtao
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
              # SELECT ooag004 INTO l_ooag004 FROM ooag_t
              #  WHERE ooagent = g_enterprise AND ooag001 = g_user
               #161215-00044#1---modify----begin-----------------
               #SELECT * INTO g_glaa.* 
               SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,
                      glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,glaa011,
                      glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,glaa023,
                      glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,glaa113,glaa120,glaa121,
                      glaa122,glaa027,glaa130,glaa131,glaa132,glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,
                      glaa140,glaa123,glaa124,glaa028 INTO g_glaa.* 
               #161215-00044#1---modify----end----------------- 
               FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_fabg_m.fabgld
               CALL s_aooi200_fin_gen_docno(g_fabg_m.fabgld,'','',g_fabg_m.fabgdocno,g_fabg_m.fabgdocdt,g_prog)
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
               
               INSERT INTO fabg_t (fabgent,fabgsite,fabg001,fabgld,fabg002,fabg003,fabg004,fabg005,fabgdocno, 
                   fabgdocdt,fabg008,fabg009,fabgstus,fabgownid,fabgowndp,fabgcrtid,fabgcrtdp,fabgcrtdt, 
                   fabgmodid,fabgmoddt,fabgcnfid,fabgcnfdt,fabgpstid,fabgpstdt)
               VALUES (g_enterprise,g_fabg_m.fabgsite,g_fabg_m.fabg001,g_fabg_m.fabgld,g_fabg_m.fabg002, 
                   g_fabg_m.fabg003,g_fabg_m.fabg004,g_fabg_m.fabg005,g_fabg_m.fabgdocno,g_fabg_m.fabgdocdt, 
                   g_fabg_m.fabg008,g_fabg_m.fabg009,g_fabg_m.fabgstus,g_fabg_m.fabgownid,g_fabg_m.fabgowndp, 
                   g_fabg_m.fabgcrtid,g_fabg_m.fabgcrtdp,g_fabg_m.fabgcrtdt,g_fabg_m.fabgmodid,g_fabg_m.fabgmoddt, 
                   g_fabg_m.fabgcnfid,g_fabg_m.fabgcnfdt,g_fabg_m.fabgpstid,g_fabg_m.fabgpstdt) 
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
                  CALL afat500_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL afat500_b_fill()
                  CALL afat500_b_fill2('0')
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
               CALL afat500_fabg_t_mask_restore('restore_mask_o')
               
               UPDATE fabg_t SET (fabgsite,fabg001,fabgld,fabg002,fabg003,fabg004,fabg005,fabgdocno, 
                   fabgdocdt,fabg008,fabg009,fabgstus,fabgownid,fabgowndp,fabgcrtid,fabgcrtdp,fabgcrtdt, 
                   fabgmodid,fabgmoddt,fabgcnfid,fabgcnfdt,fabgpstid,fabgpstdt) = (g_fabg_m.fabgsite, 
                   g_fabg_m.fabg001,g_fabg_m.fabgld,g_fabg_m.fabg002,g_fabg_m.fabg003,g_fabg_m.fabg004, 
                   g_fabg_m.fabg005,g_fabg_m.fabgdocno,g_fabg_m.fabgdocdt,g_fabg_m.fabg008,g_fabg_m.fabg009, 
                   g_fabg_m.fabgstus,g_fabg_m.fabgownid,g_fabg_m.fabgowndp,g_fabg_m.fabgcrtid,g_fabg_m.fabgcrtdp, 
                   g_fabg_m.fabgcrtdt,g_fabg_m.fabgmodid,g_fabg_m.fabgmoddt,g_fabg_m.fabgcnfid,g_fabg_m.fabgcnfdt, 
                   g_fabg_m.fabgpstid,g_fabg_m.fabgpstdt)
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
               CALL afat500_fabg_t_mask_restore('restore_mask_n')
               
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
 
{<section id="afat500.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_fabs_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_fabs_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL afat500_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1','2','3',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_fabs_d.getLength()
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
            OPEN afat500_cl USING g_enterprise,g_fabg_m.fabgld,g_fabg_m.fabgdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN afat500_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE afat500_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_fabs_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_fabs_d[l_ac].fabsseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_fabs_d_t.* = g_fabs_d[l_ac].*  #BACKUP
               LET g_fabs_d_o.* = g_fabs_d[l_ac].*  #BACKUP
               CALL afat500_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL afat500_set_no_entry_b(l_cmd)
               IF NOT afat500_lock_b("fabs_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH afat500_bcl INTO g_fabs_d[l_ac].fabsseq,g_fabs_d[l_ac].fabs002,g_fabs_d[l_ac].fabs003, 
                      g_fabs_d[l_ac].fabs004,g_fabs_d[l_ac].fabs005,g_fabs_d[l_ac].fabs006,g_fabs_d[l_ac].fabs009, 
                      g_fabs_d[l_ac].fabs010,g_fabs_d[l_ac].fabs011,g_fabs_d[l_ac].fabs012,g_fabs_d[l_ac].fabs100, 
                      g_fabs_d[l_ac].fabs101,g_fabs_d[l_ac].fabs102,g_fabs_d[l_ac].fabs150,g_fabs_d[l_ac].fabs151, 
                      g_fabs_d[l_ac].fabs152,g_fabs2_d[l_ac].fabsseq,g_fabs2_d[l_ac].fabs007,g_fabs2_d[l_ac].fabs008, 
                      g_fabs2_d[l_ac].fabs014,g_fabs2_d[l_ac].fabs015,g_fabs2_d[l_ac].fabs016,g_fabs2_d[l_ac].fabs017, 
                      g_fabs2_d[l_ac].fabs018,g_fabs2_d[l_ac].fabs019,g_fabs2_d[l_ac].fabs020,g_fabs2_d[l_ac].fabs022, 
                      g_fabs2_d[l_ac].fabs024,g_fabs2_d[l_ac].fabs025,g_fabs3_d[l_ac].fabsseq,g_fabs3_d[l_ac].fabs100, 
                      g_fabs3_d[l_ac].fabs101,g_fabs3_d[l_ac].fabs102,g_fabs3_d[l_ac].fabs150,g_fabs3_d[l_ac].fabs151, 
                      g_fabs3_d[l_ac].fabs152
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_fabs_d_t.fabsseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_fabs_d_mask_o[l_ac].* =  g_fabs_d[l_ac].*
                  CALL afat500_fabs_t_mask()
                  LET g_fabs_d_mask_n[l_ac].* =  g_fabs_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL afat500_show()
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
            INITIALIZE g_fabs_d[l_ac].* TO NULL 
            INITIALIZE g_fabs_d_t.* TO NULL 
            INITIALIZE g_fabs_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
            
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            
            #end add-point
            LET g_fabs_d_t.* = g_fabs_d[l_ac].*     #新輸入資料
            LET g_fabs_d_o.* = g_fabs_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL afat500_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL afat500_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_fabs_d[li_reproduce_target].* = g_fabs_d[li_reproduce].*
               LET g_fabs2_d[li_reproduce_target].* = g_fabs2_d[li_reproduce].*
               LET g_fabs3_d[li_reproduce_target].* = g_fabs3_d[li_reproduce].*
 
               LET g_fabs_d[li_reproduce_target].fabsseq = NULL
 
            END IF
            
 
 
 
            #add-point:modify段before insert name="input.body.before_insert"
            SELECT MAX(fabsseq)+1 INTO g_fabs_d[l_ac].fabsseq 
              FROM fabs_t 
             WHERE fabsdocno = g_fabg_m.fabgdocno  
               AND fabsld = g_fabg_m.fabgld
               AND fabsent = g_enterprise
            IF cl_null(g_fabs_d[l_ac].fabsseq) THEN 
               LET g_fabs_d[l_ac].fabsseq = 1 
            END IF 
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
            SELECT COUNT(1) INTO l_count FROM fabs_t 
             WHERE fabsent = g_enterprise AND fabsld = g_fabg_m.fabgld
               AND fabsdocno = g_fabg_m.fabgdocno
 
               AND fabsseq = g_fabs_d[l_ac].fabsseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fabg_m.fabgld
               LET gs_keys[2] = g_fabg_m.fabgdocno
               LET gs_keys[3] = g_fabs_d[g_detail_idx].fabsseq
               CALL afat500_insert_b('fabs_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_fabs_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "fabs_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL afat500_b_fill()
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
 
               LET gs_keys[gs_keys.getLength()+1] = g_fabs_d_t.fabsseq
 
            
               #刪除同層單身
               IF NOT afat500_delete_b('fabs_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE afat500_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT afat500_key_delete_b(gs_keys,'fabs_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE afat500_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
 
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE afat500_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_fabs_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_fabs_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabsseq
            #add-point:BEFORE FIELD fabsseq name="input.b.page1.fabsseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabsseq
            
            #add-point:AFTER FIELD fabsseq name="input.a.page1.fabsseq"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_fabg_m.fabgld IS NOT NULL AND g_fabg_m.fabgdocno IS NOT NULL AND g_fabs_d[g_detail_idx].fabsseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_fabg_m.fabgld != g_fabgld_t OR g_fabg_m.fabgdocno != g_fabgdocno_t OR g_fabs_d[g_detail_idx].fabsseq != g_fabs_d_t.fabsseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM fabs_t WHERE "||"fabsent = '" ||g_enterprise|| "' AND "||"fabsld = '"||g_fabg_m.fabgld ||"' AND "|| "fabsdocno = '"||g_fabg_m.fabgdocno ||"' AND "|| "fabsseq = '"||g_fabs_d[g_detail_idx].fabsseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabsseq
            #add-point:ON CHANGE fabsseq name="input.g.page1.fabsseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabs002
            #add-point:BEFORE FIELD fabs002 name="input.b.page1.fabs002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabs002
            
            #add-point:AFTER FIELD fabs002 name="input.a.page1.fabs002"
            IF NOT cl_null(g_fabs_d[l_ac].fabs002) AND NOT cl_null(g_fabs_d[l_ac].fabs003) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fabs_d[l_ac].fabs002
               LET g_chkparam.arg2 = g_fabs_d[l_ac].fabs003
               
               IF g_fabg_m.fabg005 = '22' THEN 
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_fabndocno") THEN
                     #檢查失敗時後續處理
                     LET g_fabs_d[l_ac].fabs002 = g_fabs_d_t.fabs002
                     CALL afat500_fabn017_desc()
                     NEXT FIELD CURRENT
                  END IF
               ELSE
                  IF NOT cl_chk_exist("v_fabjdocno") THEN
                     #檢查失敗時後續處理
                     LET g_fabs_d[l_ac].fabs002 = g_fabs_d_t.fabs002
                     CALL afat500_fabn017_desc()
                     NEXT FIELD CURRENT
                  END IF             
               END IF
               #来源作业单头的法人和afat500单头的帐套是同一法人 2014/12/29 by huangtao
               SELECT fabacomp INTO l_fabacomp FROM faba_t
                WHERE fabaent = g_enterprise AND fabadonco = g_fabs_d[l_ac].fabs002
               SELECT glaacomp INTO l_glaacomp FROM glaa_t 
                WHERE glaaent = g_enterprise AND glaald = g_fabg_m.fabgld
               IF l_fabacomp <>  l_glaacomp THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_fabs_d[l_ac].fabs002||'|'||g_fabs_d[l_ac].fabs003
                  LET g_errparam.code   = "afa-00370" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()                   
                  NEXT FIELD CURRENT
               END IF
            END IF 
            CALL afat500_fabn_get()
            CALL afat500_fabn017_desc()
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabs002
            #add-point:ON CHANGE fabs002 name="input.g.page1.fabs002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabs003
            #add-point:BEFORE FIELD fabs003 name="input.b.page1.fabs003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabs003
            
            #add-point:AFTER FIELD fabs003 name="input.a.page1.fabs003"
            IF NOT cl_null(g_fabs_d[l_ac].fabs002) AND NOT cl_null(g_fabs_d[l_ac].fabs003) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fabs_d[l_ac].fabs002
               LET g_chkparam.arg2 = g_fabs_d[l_ac].fabs003
                  
               IF g_fabg_m.fabg005 = '22' THEN 
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_fabndocno") THEN
                     #檢查失敗時後續處理
                     LET g_fabs_d[l_ac].fabs003 = g_fabs_d_t.fabs003
                     CALL afat500_fabn017_desc()
                     NEXT FIELD CURRENT
                  END IF
               ELSE
                  IF NOT cl_chk_exist("v_fabjdocno") THEN
                     #檢查失敗時後續處理
                     LET g_fabs_d[l_ac].fabs003 = g_fabs_d_t.fabs003
                     CALL afat500_fabn017_desc()
                     NEXT FIELD CURRENT
                  END IF             
               END IF
               #来源作业单头的法人和afat500单头的帐套是同一法人 2014/12/29 by huangtao
               SELECT fabacomp INTO l_fabacomp FROM faba_t
                WHERE fabaent = g_enterprise AND fabadonco = g_fabs_d[l_ac].fabs002
               SELECT glaacomp INTO l_glaacomp FROM glaa_t 
                WHERE glaaent = g_enterprise AND glaald = g_fabg_m.fabgld
               IF l_fabacomp <>  l_glaacomp THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_fabs_d[l_ac].fabs002||'|'||g_fabs_d[l_ac].fabs003
                  LET g_errparam.code   = "afa-00370" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()                   
                  NEXT FIELD CURRENT
               END IF
            END IF 
            CALL afat500_fabn_get()
            CALL afat500_fabn017_desc()
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabs003
            #add-point:ON CHANGE fabs003 name="input.g.page1.fabs003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabs004
            #add-point:BEFORE FIELD fabs004 name="input.b.page1.fabs004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabs004
            
            #add-point:AFTER FIELD fabs004 name="input.a.page1.fabs004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabs004
            #add-point:ON CHANGE fabs004 name="input.g.page1.fabs004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabs005
            #add-point:BEFORE FIELD fabs005 name="input.b.page1.fabs005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabs005
            
            #add-point:AFTER FIELD fabs005 name="input.a.page1.fabs005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabs005
            #add-point:ON CHANGE fabs005 name="input.g.page1.fabs005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabs006
            #add-point:BEFORE FIELD fabs006 name="input.b.page1.fabs006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabs006
            
            #add-point:AFTER FIELD fabs006 name="input.a.page1.fabs006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabs006
            #add-point:ON CHANGE fabs006 name="input.g.page1.fabs006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah012
            #add-point:BEFORE FIELD faah012 name="input.b.page1.faah012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah012
            
            #add-point:AFTER FIELD faah012 name="input.a.page1.faah012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah012
            #add-point:ON CHANGE faah012 name="input.g.page1.faah012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah013
            #add-point:BEFORE FIELD faah013 name="input.b.page1.faah013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah013
            
            #add-point:AFTER FIELD faah013 name="input.a.page1.faah013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah013
            #add-point:ON CHANGE faah013 name="input.g.page1.faah013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabs009
            #add-point:BEFORE FIELD fabs009 name="input.b.page1.fabs009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabs009
            
            #add-point:AFTER FIELD fabs009 name="input.a.page1.fabs009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabs009
            #add-point:ON CHANGE fabs009 name="input.g.page1.fabs009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabs010
            #add-point:BEFORE FIELD fabs010 name="input.b.page1.fabs010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabs010
            
            #add-point:AFTER FIELD fabs010 name="input.a.page1.fabs010"
            IF NOT cl_null(g_fabs_d[l_ac].fabs010) THEN 
               LET g_fabs_d[l_ac].fabs012 = g_fabs_d[l_ac].fabs010 * g_fabs_d[l_ac].fabs011
               
               CALL afat500_get_glaa()
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabs010
            #add-point:ON CHANGE fabs010 name="input.g.page1.fabs010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabs011
            #add-point:BEFORE FIELD fabs011 name="input.b.page1.fabs011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabs011
            
            #add-point:AFTER FIELD fabs011 name="input.a.page1.fabs011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabs011
            #add-point:ON CHANGE fabs011 name="input.g.page1.fabs011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabs012
            #add-point:BEFORE FIELD fabs012 name="input.b.page1.fabs012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabs012
            
            #add-point:AFTER FIELD fabs012 name="input.a.page1.fabs012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabs012
            #add-point:ON CHANGE fabs012 name="input.g.page1.fabs012"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabn017
            
            #add-point:AFTER FIELD fabn017 name="input.a.page1.fabn017"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fabs_d[l_ac].fabn017
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='3904' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_fabs_d[l_ac].fabn017_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fabs_d[l_ac].fabn017_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabn017
            #add-point:BEFORE FIELD fabn017 name="input.b.page1.fabn017"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabn017
            #add-point:ON CHANGE fabn017 name="input.g.page1.fabn017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabn017_desc
            #add-point:BEFORE FIELD fabn017_desc name="input.b.page1.fabn017_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabn017_desc
            
            #add-point:AFTER FIELD fabn017_desc name="input.a.page1.fabn017_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabn017_desc
            #add-point:ON CHANGE fabn017_desc name="input.g.page1.fabn017_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabs100
            #add-point:BEFORE FIELD fabs100 name="input.b.page1.fabs100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabs100
            
            #add-point:AFTER FIELD fabs100 name="input.a.page1.fabs100"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabs100
            #add-point:ON CHANGE fabs100 name="input.g.page1.fabs100"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabs101
            #add-point:BEFORE FIELD fabs101 name="input.b.page1.fabs101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabs101
            
            #add-point:AFTER FIELD fabs101 name="input.a.page1.fabs101"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabs101
            #add-point:ON CHANGE fabs101 name="input.g.page1.fabs101"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabs102
            #add-point:BEFORE FIELD fabs102 name="input.b.page1.fabs102"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabs102
            
            #add-point:AFTER FIELD fabs102 name="input.a.page1.fabs102"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabs102
            #add-point:ON CHANGE fabs102 name="input.g.page1.fabs102"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabs150
            #add-point:BEFORE FIELD fabs150 name="input.b.page1.fabs150"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabs150
            
            #add-point:AFTER FIELD fabs150 name="input.a.page1.fabs150"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabs150
            #add-point:ON CHANGE fabs150 name="input.g.page1.fabs150"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabs151
            #add-point:BEFORE FIELD fabs151 name="input.b.page1.fabs151"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabs151
            
            #add-point:AFTER FIELD fabs151 name="input.a.page1.fabs151"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabs151
            #add-point:ON CHANGE fabs151 name="input.g.page1.fabs151"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabs152
            #add-point:BEFORE FIELD fabs152 name="input.b.page1.fabs152"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabs152
            
            #add-point:AFTER FIELD fabs152 name="input.a.page1.fabs152"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabs152
            #add-point:ON CHANGE fabs152 name="input.g.page1.fabs152"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.fabsseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabsseq
            #add-point:ON ACTION controlp INFIELD fabsseq name="input.c.page1.fabsseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fabs002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabs002
            #add-point:ON ACTION controlp INFIELD fabs002 name="input.c.page1.fabs002"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabs_d[l_ac].fabs002             #給予default值
            LET g_qryparam.default2 = g_fabs_d[l_ac].fabs003
            

            #161215-00044#1---modify----begin-----------------
            #SELECT * INTO g_glaa.* 
            SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,
                   glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,glaa011,
                   glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,glaa023,
                   glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,glaa113,glaa120,glaa121,
                   glaa122,glaa027,glaa130,glaa131,glaa132,glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,
                   glaa140,glaa123,glaa124,glaa028 INTO g_glaa.* 
            #161215-00044#1---modify----end----------------- 
            FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_fabg_m.fabgld
            LET g_qryparam.where = " fabacomp = '",g_glaa.glaacomp,"'"
            
            #給予arg
            LET g_qryparam.arg1 = "" #

            IF g_fabg_m.fabg005 = '22' THEN
               CALL q_fabndocno()                                #呼叫開窗
            ELSE
               CALL q_fabjdocno_1()
            END IF

            LET g_fabs_d[l_ac].fabs002 = g_qryparam.return1 
            LET g_fabs_d[l_ac].fabs003 = g_qryparam.return2            

            DISPLAY g_fabs_d[l_ac].fabs002 TO fabs002              #
            DISPLAY g_fabs_d[l_ac].fabs003 TO fabs003
            CALL afat500_fabn_get()
            CALL afat500_fabn017_desc()
            NEXT FIELD fabs002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.fabs003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabs003
            #add-point:ON ACTION controlp INFIELD fabs003 name="input.c.page1.fabs003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fabs004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabs004
            #add-point:ON ACTION controlp INFIELD fabs004 name="input.c.page1.fabs004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fabs005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabs005
            #add-point:ON ACTION controlp INFIELD fabs005 name="input.c.page1.fabs005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fabs006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabs006
            #add-point:ON ACTION controlp INFIELD fabs006 name="input.c.page1.fabs006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.faah012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah012
            #add-point:ON ACTION controlp INFIELD faah012 name="input.c.page1.faah012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.faah013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah013
            #add-point:ON ACTION controlp INFIELD faah013 name="input.c.page1.faah013"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fabs009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabs009
            #add-point:ON ACTION controlp INFIELD fabs009 name="input.c.page1.fabs009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fabs010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabs010
            #add-point:ON ACTION controlp INFIELD fabs010 name="input.c.page1.fabs010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fabs011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabs011
            #add-point:ON ACTION controlp INFIELD fabs011 name="input.c.page1.fabs011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fabs012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabs012
            #add-point:ON ACTION controlp INFIELD fabs012 name="input.c.page1.fabs012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fabn017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabn017
            #add-point:ON ACTION controlp INFIELD fabn017 name="input.c.page1.fabn017"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fabn017_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabn017_desc
            #add-point:ON ACTION controlp INFIELD fabn017_desc name="input.c.page1.fabn017_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fabs100
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabs100
            #add-point:ON ACTION controlp INFIELD fabs100 name="input.c.page1.fabs100"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fabs101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabs101
            #add-point:ON ACTION controlp INFIELD fabs101 name="input.c.page1.fabs101"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fabs102
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabs102
            #add-point:ON ACTION controlp INFIELD fabs102 name="input.c.page1.fabs102"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fabs150
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabs150
            #add-point:ON ACTION controlp INFIELD fabs150 name="input.c.page1.fabs150"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fabs151
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabs151
            #add-point:ON ACTION controlp INFIELD fabs151 name="input.c.page1.fabs151"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fabs152
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabs152
            #add-point:ON ACTION controlp INFIELD fabs152 name="input.c.page1.fabs152"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_fabs_d[l_ac].* = g_fabs_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE afat500_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_fabs_d[l_ac].fabsseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_fabs_d[l_ac].* = g_fabs_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL afat500_fabs_t_mask_restore('restore_mask_o')
      
               UPDATE fabs_t SET (fabsld,fabsdocno,fabsseq,fabs002,fabs003,fabs004,fabs005,fabs006,fabs009, 
                   fabs010,fabs011,fabs012,fabs100,fabs101,fabs102,fabs150,fabs151,fabs152,fabs007,fabs008, 
                   fabs014,fabs015,fabs016,fabs017,fabs018,fabs019,fabs020,fabs022,fabs024,fabs025) = (g_fabg_m.fabgld, 
                   g_fabg_m.fabgdocno,g_fabs_d[l_ac].fabsseq,g_fabs_d[l_ac].fabs002,g_fabs_d[l_ac].fabs003, 
                   g_fabs_d[l_ac].fabs004,g_fabs_d[l_ac].fabs005,g_fabs_d[l_ac].fabs006,g_fabs_d[l_ac].fabs009, 
                   g_fabs_d[l_ac].fabs010,g_fabs_d[l_ac].fabs011,g_fabs_d[l_ac].fabs012,g_fabs_d[l_ac].fabs100, 
                   g_fabs_d[l_ac].fabs101,g_fabs_d[l_ac].fabs102,g_fabs_d[l_ac].fabs150,g_fabs_d[l_ac].fabs151, 
                   g_fabs_d[l_ac].fabs152,g_fabs2_d[l_ac].fabs007,g_fabs2_d[l_ac].fabs008,g_fabs2_d[l_ac].fabs014, 
                   g_fabs2_d[l_ac].fabs015,g_fabs2_d[l_ac].fabs016,g_fabs2_d[l_ac].fabs017,g_fabs2_d[l_ac].fabs018, 
                   g_fabs2_d[l_ac].fabs019,g_fabs2_d[l_ac].fabs020,g_fabs2_d[l_ac].fabs022,g_fabs2_d[l_ac].fabs024, 
                   g_fabs2_d[l_ac].fabs025)
                WHERE fabsent = g_enterprise AND fabsld = g_fabg_m.fabgld 
                  AND fabsdocno = g_fabg_m.fabgdocno 
 
                  AND fabsseq = g_fabs_d_t.fabsseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_fabs_d[l_ac].* = g_fabs_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fabs_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_fabs_d[l_ac].* = g_fabs_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fabs_t:",SQLERRMESSAGE 
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
               LET gs_keys[3] = g_fabs_d[g_detail_idx].fabsseq
               LET gs_keys_bak[3] = g_fabs_d_t.fabsseq
               CALL afat500_update_b('fabs_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL afat500_fabs_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_fabs_d[g_detail_idx].fabsseq = g_fabs_d_t.fabsseq 
 
                  ) THEN
                  LET gs_keys[01] = g_fabg_m.fabgld
                  LET gs_keys[gs_keys.getLength()+1] = g_fabg_m.fabgdocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_fabs_d_t.fabsseq
 
                  CALL afat500_key_update_b(gs_keys,'fabs_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_fabg_m),util.JSON.stringify(g_fabs_d_t)
               LET g_log2 = util.JSON.stringify(g_fabg_m),util.JSON.stringify(g_fabs_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL afat500_unlock_b("fabs_t","'1'")
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            #add-point:單身after_row2 name="input.body.after_row2"
            
            #end add-point
              
         AFTER INPUT
            #add-point:input段after input  name="input.body.after_input"
            CALL afat500_b_fill()
            #end add-point 
    
         ON ACTION controlo    
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_fabs_d[li_reproduce_target].* = g_fabs_d[li_reproduce].*
               LET g_fabs2_d[li_reproduce_target].* = g_fabs2_d[li_reproduce].*
               LET g_fabs3_d[li_reproduce_target].* = g_fabs3_d[li_reproduce].*
 
               LET g_fabs_d[li_reproduce_target].fabsseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_fabs_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_fabs_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
      INPUT ARRAY g_fabs2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = FALSE, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = FALSE,
                 APPEND ROW = FALSE)
                 
         #自訂ACTION(detail_input,page_2)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body2.before_input2"
            
            #end add-point
            
            CALL afat500_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue(""))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_fabs2_d.getLength()
            #add-point:資料輸入前 name="input.body2.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_fabs2_d[l_ac].* TO NULL 
            INITIALIZE g_fabs2_d_t.* TO NULL 
            INITIALIZE g_fabs2_d_o.* TO NULL 
            #公用欄位給值(單身2)
            
            #自定義預設值(單身2)
            
            #add-point:modify段before備份 name="input.body2.insert.before_bak"
            
            #end add-point
            LET g_fabs2_d_t.* = g_fabs2_d[l_ac].*     #新輸入資料
            LET g_fabs2_d_o.* = g_fabs2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL afat500_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body2.insert.after_set_entry_b"
            
            #end add-point
            CALL afat500_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_fabs_d[li_reproduce_target].* = g_fabs_d[li_reproduce].*
               LET g_fabs2_d[li_reproduce_target].* = g_fabs2_d[li_reproduce].*
               LET g_fabs3_d[li_reproduce_target].* = g_fabs3_d[li_reproduce].*
 
               LET g_fabs2_d[li_reproduce_target].fabsseq = NULL
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
            OPEN afat500_cl USING g_enterprise,g_fabg_m.fabgld,g_fabg_m.fabgdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN afat500_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE afat500_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_fabs2_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_fabs2_d[l_ac].fabsseq IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_fabs2_d_t.* = g_fabs2_d[l_ac].*  #BACKUP
               LET g_fabs2_d_o.* = g_fabs2_d[l_ac].*  #BACKUP
               CALL afat500_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body2.after_set_entry_b"
               
               #end add-point  
               CALL afat500_set_no_entry_b(l_cmd)
               IF NOT afat500_lock_b("fabs_t","'2'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH afat500_bcl INTO g_fabs_d[l_ac].fabsseq,g_fabs_d[l_ac].fabs002,g_fabs_d[l_ac].fabs003, 
                      g_fabs_d[l_ac].fabs004,g_fabs_d[l_ac].fabs005,g_fabs_d[l_ac].fabs006,g_fabs_d[l_ac].fabs009, 
                      g_fabs_d[l_ac].fabs010,g_fabs_d[l_ac].fabs011,g_fabs_d[l_ac].fabs012,g_fabs_d[l_ac].fabs100, 
                      g_fabs_d[l_ac].fabs101,g_fabs_d[l_ac].fabs102,g_fabs_d[l_ac].fabs150,g_fabs_d[l_ac].fabs151, 
                      g_fabs_d[l_ac].fabs152,g_fabs2_d[l_ac].fabsseq,g_fabs2_d[l_ac].fabs007,g_fabs2_d[l_ac].fabs008, 
                      g_fabs2_d[l_ac].fabs014,g_fabs2_d[l_ac].fabs015,g_fabs2_d[l_ac].fabs016,g_fabs2_d[l_ac].fabs017, 
                      g_fabs2_d[l_ac].fabs018,g_fabs2_d[l_ac].fabs019,g_fabs2_d[l_ac].fabs020,g_fabs2_d[l_ac].fabs022, 
                      g_fabs2_d[l_ac].fabs024,g_fabs2_d[l_ac].fabs025,g_fabs3_d[l_ac].fabsseq,g_fabs3_d[l_ac].fabs100, 
                      g_fabs3_d[l_ac].fabs101,g_fabs3_d[l_ac].fabs102,g_fabs3_d[l_ac].fabs150,g_fabs3_d[l_ac].fabs151, 
                      g_fabs3_d[l_ac].fabs152
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_fabs2_d_mask_o[l_ac].* =  g_fabs2_d[l_ac].*
                  CALL afat500_fabs_t_mask()
                  LET g_fabs2_d_mask_n[l_ac].* =  g_fabs2_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL afat500_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body2.before_row"
            #161221-00054#4--add--s--xul
            LET l_wc = g_fabs2_d[l_ac].fabs007,",",g_fabs2_d[l_ac].fabs008
            CALL s_fin_get_wc_str(l_wc) RETURNING l_wc
            #161221-00054#4--add--e--xul
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
               LET gs_keys[gs_keys.getLength()+1] = g_fabs2_d_t.fabsseq
            
               #刪除同層單身
               IF NOT afat500_delete_b('fabs_t',gs_keys,"'2'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE afat500_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT afat500_key_delete_b(gs_keys,'fabs_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE afat500_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
 
 
               
               #add-point:單身2刪除中 name="input.body2.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE afat500_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身2刪除後 name="input.body2.a_delete"
               
               #end add-point
               LET l_count = g_fabs_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body2.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_fabs2_d.getLength() + 1) THEN
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
            SELECT COUNT(1) INTO l_count FROM fabs_t 
             WHERE fabsent = g_enterprise AND fabsld = g_fabg_m.fabgld
               AND fabsdocno = g_fabg_m.fabgdocno
               AND fabsseq = g_fabs2_d[l_ac].fabsseq
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前 name="input.body2.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fabg_m.fabgld
               LET gs_keys[2] = g_fabg_m.fabgdocno
               LET gs_keys[3] = g_fabs2_d[g_detail_idx].fabsseq
               CALL afat500_insert_b('fabs_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2 name="input.body2.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_fabs_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "fabs_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL afat500_b_fill()
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
               LET g_fabs2_d[l_ac].* = g_fabs2_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE afat500_bcl
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
               LET g_fabs2_d[l_ac].* = g_fabs2_d_t.*
            ELSE
               #add-point:單身page2修改前 name="input.body2.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身2)
               
               
               #將遮罩欄位還原
               CALL afat500_fabs_t_mask_restore('restore_mask_o')
                              
               UPDATE fabs_t SET (fabsld,fabsdocno,fabsseq,fabs002,fabs003,fabs004,fabs005,fabs006,fabs009, 
                   fabs010,fabs011,fabs012,fabs100,fabs101,fabs102,fabs150,fabs151,fabs152,fabs007,fabs008, 
                   fabs014,fabs015,fabs016,fabs017,fabs018,fabs019,fabs020,fabs022,fabs024,fabs025) = (g_fabg_m.fabgld, 
                   g_fabg_m.fabgdocno,g_fabs_d[l_ac].fabsseq,g_fabs_d[l_ac].fabs002,g_fabs_d[l_ac].fabs003, 
                   g_fabs_d[l_ac].fabs004,g_fabs_d[l_ac].fabs005,g_fabs_d[l_ac].fabs006,g_fabs_d[l_ac].fabs009, 
                   g_fabs_d[l_ac].fabs010,g_fabs_d[l_ac].fabs011,g_fabs_d[l_ac].fabs012,g_fabs_d[l_ac].fabs100, 
                   g_fabs_d[l_ac].fabs101,g_fabs_d[l_ac].fabs102,g_fabs_d[l_ac].fabs150,g_fabs_d[l_ac].fabs151, 
                   g_fabs_d[l_ac].fabs152,g_fabs2_d[l_ac].fabs007,g_fabs2_d[l_ac].fabs008,g_fabs2_d[l_ac].fabs014, 
                   g_fabs2_d[l_ac].fabs015,g_fabs2_d[l_ac].fabs016,g_fabs2_d[l_ac].fabs017,g_fabs2_d[l_ac].fabs018, 
                   g_fabs2_d[l_ac].fabs019,g_fabs2_d[l_ac].fabs020,g_fabs2_d[l_ac].fabs022,g_fabs2_d[l_ac].fabs024, 
                   g_fabs2_d[l_ac].fabs025) #自訂欄位頁簽
                WHERE fabsent = g_enterprise AND fabsld = g_fabg_m.fabgld
                  AND fabsdocno = g_fabg_m.fabgdocno
                  AND fabsseq = g_fabs2_d_t.fabsseq #項次 
                  
               #add-point:單身page2修改中 name="input.body2.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_fabs2_d[l_ac].* = g_fabs2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fabs_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_fabs2_d[l_ac].* = g_fabs2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fabs_t:",SQLERRMESSAGE 
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
               LET gs_keys[3] = g_fabs2_d[g_detail_idx].fabsseq
               LET gs_keys_bak[3] = g_fabs2_d_t.fabsseq
               CALL afat500_update_b('fabs_t',gs_keys,gs_keys_bak,"'2'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL afat500_fabs_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_fabs2_d[g_detail_idx].fabsseq = g_fabs2_d_t.fabsseq 
                  ) THEN
                  LET gs_keys[01] = g_fabg_m.fabgld
                  LET gs_keys[gs_keys.getLength()+1] = g_fabg_m.fabgdocno
                  LET gs_keys[gs_keys.getLength()+1] = g_fabs2_d_t.fabsseq
                  CALL afat500_key_update_b(gs_keys,'fabs_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_fabg_m),util.JSON.stringify(g_fabs2_d_t)
               LET g_log2 = util.JSON.stringify(g_fabg_m),util.JSON.stringify(g_fabs2_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page2修改後 name="input.body2.a_update"
               
               #end add-point
            END IF
         
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabs007
            
            #add-point:AFTER FIELD fabs007 name="input.a.page2.fabs007"
            IF NOT cl_null(g_fabs2_d[l_ac].fabs007) THEN 
                #  150916-00015#1 BEGIN    快捷带出类似科目编号     ADD BY XZG201511204
              LET l_sql = ""
              IF  s_aglt310_getlike_lc_subject(g_fabg_m.fabgld,g_fabs2_d[l_ac].fabs007,l_sql) THEN
                 INITIALIZE g_qryparam.* TO NULL
                 SELECT glaa004 INTO l_glaa004
                  FROM glaa_t
                 WHERE glaaent = g_enterprise
                   AND glaald = g_fabg_m.fabgld
                LET g_qryparam.state = 'i'
                LET g_qryparam.reqry = 'FALSE'
                LET g_qryparam.default1 = g_fabs2_d[l_ac].fabs007
                
                LET g_qryparam.arg1 = l_glaa004
                LET g_qryparam.arg2 = g_fabs2_d[l_ac].fabs007
                LET g_qryparam.arg3 = g_fabg_m.fabgld
                LET g_qryparam.arg4 = "1 "
                CALL q_glac002_6()
                LET g_fabs2_d[l_ac].fabs007 = g_qryparam.return1              
             
                DISPLAY g_fabs2_d[l_ac].fabs007 TO fabs007              #
                CALL afat500_fabs007_desc()
              END IF
               IF NOT  s_aglt310_lc_subject(g_fabg_m.fabgld,g_fabs2_d[l_ac].fabs007,'N') THEN
                  LET g_fabs2_d[l_ac].fabs007 = g_fabs2_d_t.fabs007
                     CALL afat500_fabs007_desc()
                      NEXT FIELD CURRENT
               END IF
 #  150916-00015#1 END
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_glaa004
               LET g_chkparam.arg2 = g_fabs2_d[l_ac].fabs007
               #160318-00025#6--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "agl-00012:sub-01302|agli020|",cl_get_progname("agli020",g_lang,"2"),"|:EXEPROGagli020"
               #160318-00025#6--add--end  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_glac002_3") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                  SELECT glac003 INTO l_glac003 FROM glac_t WHERE glacent = g_enterprise AND glac001 =  g_glaa004 AND glac002 =g_fabs2_d[l_ac].fabs007
                  IF l_glac003 = '1' THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ''
                     LET g_errparam.code   = 'agl-00013'
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err() 
                     LET g_fabs2_d[l_ac].fabs007 = g_fabs2_d_t.fabs007
                     CALL afat500_fabs007_desc()
                      NEXT FIELD CURRENT
                  END IF                  
               ELSE
                  #檢查失敗時後續處理
                  LET g_fabs2_d[l_ac].fabs007 = g_fabs2_d_t.fabs007
                  CALL afat500_fabs007_desc()
                  NEXT FIELD CURRENT
               END IF
            END IF 
            #161221-00054#4--add--s--xul
            LET l_wc = g_fabs2_d[l_ac].fabs007,",",g_fabs2_d[l_ac].fabs008
            CALL s_fin_get_wc_str(l_wc) RETURNING l_wc
            #161221-00054#4--add--e--xul
            CALL afat500_fabs007_desc()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabs007
            #add-point:BEFORE FIELD fabs007 name="input.b.page2.fabs007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabs007
            #add-point:ON CHANGE fabs007 name="input.g.page2.fabs007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabs007_desc
            #add-point:BEFORE FIELD fabs007_desc name="input.b.page2.fabs007_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabs007_desc
            
            #add-point:AFTER FIELD fabs007_desc name="input.a.page2.fabs007_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabs007_desc
            #add-point:ON CHANGE fabs007_desc name="input.g.page2.fabs007_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabs008
            
            #add-point:AFTER FIELD fabs008 name="input.a.page2.fabs008"
            IF NOT cl_null(g_fabs2_d[l_ac].fabs008) THEN 
               #  150916-00015#1 BEGIN    快捷带出类似科目编号     ADD BY XZG201511204
              LET l_sql = ""
              IF  s_aglt310_getlike_lc_subject(g_fabg_m.fabgld,g_fabs2_d[l_ac].fabs008,l_sql) THEN
                 INITIALIZE g_qryparam.* TO NULL
                 SELECT glaa004 INTO l_glaa004
                  FROM glaa_t
                 WHERE glaaent = g_enterprise
                   AND glaald = g_fabg_m.fabgld
                LET g_qryparam.state = 'i'
                LET g_qryparam.reqry = 'FALSE'
                LET g_qryparam.default1 = g_fabs2_d[l_ac].fabs008
                
                LET g_qryparam.arg1 = l_glaa004
                LET g_qryparam.arg2 = g_fabs2_d[l_ac].fabs008
                LET g_qryparam.arg3 = g_fabg_m.fabgld
                LET g_qryparam.arg4 = "1 "
                CALL q_glac002_6()
                LET g_fabs2_d[l_ac].fabs008 = g_qryparam.return1              
              
                DISPLAY g_fabs2_d[l_ac].fabs008 TO fabs008              #
                CALL afat500_fabs008_desc()  
                    
              END IF
               IF  NOT  s_aglt310_lc_subject(g_fabg_m.fabgld,g_fabs2_d[l_ac].fabs008,'N') THEN
                  LET g_fabs2_d[l_ac].fabs008 = g_fabs2_d_t.fabs008
                     CALL afat500_fabs008_desc()
                     NEXT FIELD CURRENT
               END IF
 #  150916-00015#1 END
#應用 a19 樣板自動產生(Version:2)
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_glaa004
               LET g_chkparam.arg2 = g_fabs2_d[l_ac].fabs008
               #160318-00025#6--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "agl-00012:sub-01302|agli020|",cl_get_progname("agli020",g_lang,"2"),"|:EXEPROGagli020"
               #160318-00025#6--add--end 
               #呼叫檢查存在並帶值的library
                IF cl_chk_exist("v_glac002_3") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                   SELECT glac003 INTO l_glac003 FROM glac_t WHERE glacent = g_enterprise AND glac001 =  g_glaa004 AND glac002 =g_fabs2_d[l_ac].fabs008
                  IF l_glac003 = '1' THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ''
                     LET g_errparam.code   = 'agl-00013'
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err() 
                     LET g_fabs2_d[l_ac].fabs008 = g_fabs2_d_t.fabs008
                     CALL afat500_fabs008_desc()
                     NEXT FIELD CURRENT
                  END IF
               ELSE
                  #檢查失敗時後續處理
                  LET g_fabs2_d[l_ac].fabs008 = g_fabs2_d_t.fabs008
                  CALL afat500_fabs008_desc()
                  NEXT FIELD CURRENT
               END IF
            

            END IF
             #161221-00054#4--add--s--xul
             LET l_wc = g_fabs2_d[l_ac].fabs007,",",g_fabs2_d[l_ac].fabs008
             CALL s_fin_get_wc_str(l_wc) RETURNING l_wc
            #161221-00054#4--add--e--xul            
             CALL afat500_fabs008_desc()

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabs008
            #add-point:BEFORE FIELD fabs008 name="input.b.page2.fabs008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabs008
            #add-point:ON CHANGE fabs008 name="input.g.page2.fabs008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabs008_desc
            #add-point:BEFORE FIELD fabs008_desc name="input.b.page2.fabs008_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabs008_desc
            
            #add-point:AFTER FIELD fabs008_desc name="input.a.page2.fabs008_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabs008_desc
            #add-point:ON CHANGE fabs008_desc name="input.g.page2.fabs008_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabs014
            #add-point:BEFORE FIELD fabs014 name="input.b.page2.fabs014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabs014
            
            #add-point:AFTER FIELD fabs014 name="input.a.page2.fabs014"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabs014
            #add-point:ON CHANGE fabs014 name="input.g.page2.fabs014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabs014_desc
            #add-point:BEFORE FIELD fabs014_desc name="input.b.page2.fabs014_desc"
            LET g_fabs2_d[l_ac].fabs014_desc = g_fabs2_d[l_ac].fabs014
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabs014_desc
            
            #add-point:AFTER FIELD fabs014_desc name="input.a.page2.fabs014_desc"
            LET g_fabs2_d[l_ac].fabs014 = g_fabs2_d[l_ac].fabs014_desc
            CALL afat500_fabs014_desc()
            IF NOT cl_null(g_fabs2_d[l_ac].fabs014) THEN
#20150113 mod by chenying            
#               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
#               INITIALIZE g_chkparam.* TO NULL
#               #設定g_chkparam.*的參數
#               LET g_chkparam.arg1 = g_fabs2_d[l_ac].fabs014   
#               #呼叫檢查存在並帶值的library
#               IF cl_chk_exist("v_ooef001") THEN
#                  #檢查成功時後續處理
#                  #LET  = g_chkparam.return1
#                  #DISPLAY BY NAME 
#
#               ELSE
#                  #檢查失敗時後續處理
#                  LET g_fabs2_d[l_ac].fabs014 = g_fabs2_d_t.fabs014
#                  LET g_fabs2_d[l_ac].fabs014_desc = g_fabs2_d_t.fabs014_desc
#                  CALL afat500_fabs014_desc()
#                  NEXT FIELD CURRENT
#               END IF
               CALL s_voucher_glaq017_chk(g_fabs2_d[l_ac].fabs014)
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = g_errno
                  #160321-00016#26 --s add
                  LET g_errparam.replace[1] = 'aooi100'
                  LET g_errparam.replace[2] = cl_get_progname('aooi100',g_lang,"2")
                  LET g_errparam.exeprog = 'aooi100'
                  #160321-00016#26 --e add
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()     

                  LET g_fabs2_d[l_ac].fabs014 = g_fabs2_d_t.fabs014
                  LET g_fabs2_d[l_ac].fabs014_desc = g_fabs2_d_t.fabs014_desc
                  CALL afat500_fabs014_desc() 
                  NEXT FIELD CURRENT
               END IF
               
               #161024-00008#4---s---
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fabs2_d[l_ac].fabs014   
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooef001_20") THEN
                  #161221-00054#4--add--s--xul
                  #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件
                  CALL s_voucher_hsx_glak_chk(g_fabg_m.fabgld,'01',g_fabs2_d[l_ac].fabs007,g_fabs2_d[l_ac].fabs014) RETURNING g_sub_success
                  IF NOT g_sub_success THEN
                     LET g_fabs2_d[l_ac].fabs014 = g_fabs2_d_t.fabs014
                     LET g_fabs2_d[l_ac].fabs014_desc = g_fabs2_d_t.fabs014_desc
                     CALL afat500_fabs014_desc()
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_voucher_hsx_glak_chk(g_fabg_m.fabgld,'01',g_fabs2_d[l_ac].fabs008,g_fabs2_d[l_ac].fabs014) RETURNING g_sub_success
                  IF NOT g_sub_success THEN
                     LET g_fabs2_d[l_ac].fabs014 = g_fabs2_d_t.fabs014
                     LET g_fabs2_d[l_ac].fabs014_desc = g_fabs2_d_t.fabs014_desc
                     CALL afat500_fabs014_desc()
                     NEXT FIELD CURRENT
                  END IF
                  #161221-00054#4--add--e--xul
               ELSE
                  #檢查失敗時後續處理
                  LET g_fabs2_d[l_ac].fabs014 = g_fabs2_d_t.fabs014
                  LET g_fabs2_d[l_ac].fabs014_desc = g_fabs2_d_t.fabs014_desc
                  CALL afat500_fabs014_desc()
                  NEXT FIELD CURRENT
               END IF
               #161024-00008#4---e---
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabs014_desc
            #add-point:ON CHANGE fabs014_desc name="input.g.page2.fabs014_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabs015
            #add-point:BEFORE FIELD fabs015 name="input.b.page2.fabs015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabs015
            
            #add-point:AFTER FIELD fabs015 name="input.a.page2.fabs015"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabs015
            #add-point:ON CHANGE fabs015 name="input.g.page2.fabs015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabs015_desc
            #add-point:BEFORE FIELD fabs015_desc name="input.b.page2.fabs015_desc"
            LET g_fabs2_d[l_ac].fabs015_desc = g_fabs2_d[l_ac].fabs015
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabs015_desc
            
            #add-point:AFTER FIELD fabs015_desc name="input.a.page2.fabs015_desc"
            LET g_fabs2_d[l_ac].fabs015 = g_fabs2_d[l_ac].fabs015_desc
            CALL afat500_fabs015_desc(g_fabs2_d[l_ac].fabs015) RETURNING g_fabs2_d[l_ac].fabs015_desc
            DISPLAY g_fabs2_d[l_ac].fabs015_desc TO s_detail2[l_ac].fabs015_desc
            IF NOT cl_null(g_fabs2_d[l_ac].fabs015) THEN 
#20150113 mod by chenying             
#               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
#               INITIALIZE g_chkparam.* TO NULL          
#               #設定g_chkparam.*的參數
#               LET g_chkparam.arg1 = g_fabs2_d[l_ac].fabs015
#               LET g_chkparam.arg2 = g_today               
#               #呼叫檢查存在並帶值的library
#               IF cl_chk_exist("v_ooeg001") THEN
#                  #檢查成功時後續處理
#                  #LET  = g_chkparam.return1
#                  #DISPLAY BY NAME 
#               ELSE
#                  #檢查失敗時後續處理
#                  LET g_fabs2_d[l_ac].fabs015 = g_fabs2_d_t.fabs015
#                  LET g_fabs2_d[l_ac].fabs015_desc = g_fabs2_d_t.fabs015_desc
#                  CALL afat500_fabs015_desc(g_fabs2_d[l_ac].fabs015) RETURNING g_fabs2_d[l_ac].fabs015_desc
#                  DISPLAY g_fabs2_d[l_ac].fabs015_desc TO s_detail2[l_ac].fabs015_desc
#                  NEXT FIELD CURRENT
#               END IF
               CALL s_department_chk(g_fabs2_d[l_ac].fabs015,g_fabg_m.fabgdocdt) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  LET g_fabs2_d[l_ac].fabs015 = g_fabs2_d_t.fabs015
                  LET g_fabs2_d[l_ac].fabs015_desc = g_fabs2_d_t.fabs015_desc
                  CALL afat500_fabs015_desc(g_fabs2_d[l_ac].fabs015) RETURNING g_fabs2_d[l_ac].fabs015_desc
                  DISPLAY g_fabs2_d[l_ac].fabs015_desc TO s_detail2[l_ac].fabs015_desc
                  NEXT FIELD CURRENT               
               END IF               
#20150113 mod by chenying
               #161221-00054#4--add--s--xul
               #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件
               CALL s_voucher_hsx_glak_chk(g_fabg_m.fabgld,'02',g_fabs2_d[l_ac].fabs007,g_fabs2_d[l_ac].fabs015) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                   LET g_fabs2_d[l_ac].fabs015 = g_fabs2_d_t.fabs015
                  LET g_fabs2_d[l_ac].fabs015_desc = g_fabs2_d_t.fabs015_desc
                  CALL afat500_fabs015_desc(g_fabs2_d[l_ac].fabs015) RETURNING g_fabs2_d[l_ac].fabs015_desc
                  DISPLAY g_fabs2_d[l_ac].fabs015_desc TO s_detail2[l_ac].fabs015_desc
                  NEXT FIELD CURRENT    
               END IF
               CALL s_voucher_hsx_glak_chk(g_fabg_m.fabgld,'02',g_fabs2_d[l_ac].fabs008,g_fabs2_d[l_ac].fabs015) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                   LET g_fabs2_d[l_ac].fabs015 = g_fabs2_d_t.fabs015
                  LET g_fabs2_d[l_ac].fabs015_desc = g_fabs2_d_t.fabs015_desc
                  CALL afat500_fabs015_desc(g_fabs2_d[l_ac].fabs015) RETURNING g_fabs2_d[l_ac].fabs015_desc
                  DISPLAY g_fabs2_d[l_ac].fabs015_desc TO s_detail2[l_ac].fabs015_desc
                  NEXT FIELD CURRENT    
               END IF
               #161221-00054#4--add--e--xul
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabs015_desc
            #add-point:ON CHANGE fabs015_desc name="input.g.page2.fabs015_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabs016
            #add-point:BEFORE FIELD fabs016 name="input.b.page2.fabs016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabs016
            
            #add-point:AFTER FIELD fabs016 name="input.a.page2.fabs016"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabs016
            #add-point:ON CHANGE fabs016 name="input.g.page2.fabs016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabs016_desc
            #add-point:BEFORE FIELD fabs016_desc name="input.b.page2.fabs016_desc"
            LET g_fabs2_d[l_ac].fabs016_desc = g_fabs2_d[l_ac].fabs016
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabs016_desc
            
            #add-point:AFTER FIELD fabs016_desc name="input.a.page2.fabs016_desc"
            LET g_fabs2_d[l_ac].fabs016 = g_fabs2_d[l_ac].fabs016_desc
             CALL afat500_fabs016_desc(g_fabs2_d[l_ac].fabs016) RETURNING g_fabs2_d[l_ac].fabs016_desc
             DISPLAY g_fabs2_d[l_ac].fabs016_desc TO s_detail2[l_ac].fabs016_desc
             IF NOT cl_null(g_fabs2_d[l_ac].fabs016) THEN 
#20150113 mod by chenying 
#                #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
#                INITIALIZE g_chkparam.* TO NULL              
#                #設定g_chkparam.*的參數
#                LET g_chkparam.arg1 = g_fabs2_d[l_ac].fabs016
#                LET g_chkparam.arg2 = g_today             
#                #呼叫檢查存在並帶值的library
#                IF cl_chk_exist("v_ooeg001") THEN
#                   #檢查成功時後續處理
#                   #LET  = g_chkparam.return1
#                   #DISPLAY BY NAME 
#                ELSE
#                   #檢查失敗時後續處理
#                   LET g_fabs2_d[l_ac].fabs016 = g_fabs2_d_t.fabs016
#                   LET g_fabs2_d[l_ac].fabs016_desc = g_fabs2_d_t.fabs016_desc
#                   CALL afat500_fabs016_desc(g_fabs2_d[l_ac].fabs016) RETURNING g_fabs2_d[l_ac].fabs016_desc
#                   DISPLAY g_fabs2_d[l_ac].fabs016_desc TO s_detail2[l_ac].fabs016_desc
#                   NEXT FIELD CURRENT
#                END IF
               CALL s_voucher_glaq019_chk(g_fabs2_d[l_ac].fabs016,g_fabg_m.fabgdocdt)
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_fabs2_d[l_ac].fabs016
                  #160321-00016#26 --s add
                  LET g_errparam.replace[1] = 'aooi125'
                  LET g_errparam.replace[2] = cl_get_progname('aooi125',g_lang,"2")
                  LET g_errparam.exeprog = 'aooi125'
                  #160321-00016#26 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  
                  LET g_fabs2_d[l_ac].fabs016 = g_fabs2_d_t.fabs016
                  LET g_fabs2_d[l_ac].fabs016_desc = g_fabs2_d_t.fabs016_desc
                  CALL afat500_fabs016_desc(g_fabs2_d[l_ac].fabs016) RETURNING g_fabs2_d[l_ac].fabs016_desc
                  DISPLAY g_fabs2_d[l_ac].fabs016_desc TO s_detail2[l_ac].fabs016_desc
                  NEXT FIELD CURRENT                
                END IF
#20150113 mod by chenying
                #161221-00054#4--add--s--xul
                #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件
                CALL s_voucher_hsx_glak_chk(g_fabg_m.fabgld,'03',g_fabs2_d[l_ac].fabs007,g_fabs2_d[l_ac].fabs016) RETURNING g_sub_success
                IF NOT g_sub_success THEN
                  LET g_fabs2_d[l_ac].fabs016 = g_fabs2_d_t.fabs016
                  LET g_fabs2_d[l_ac].fabs016_desc = g_fabs2_d_t.fabs016_desc
                  CALL afat500_fabs016_desc(g_fabs2_d[l_ac].fabs016) RETURNING g_fabs2_d[l_ac].fabs016_desc
                  DISPLAY g_fabs2_d[l_ac].fabs016_desc TO s_detail2[l_ac].fabs016_desc
                  NEXT FIELD CURRENT  
                END IF
                CALL s_voucher_hsx_glak_chk(g_fabg_m.fabgld,'03',g_fabs2_d[l_ac].fabs008,g_fabs2_d[l_ac].fabs016) RETURNING g_sub_success
                IF NOT g_sub_success THEN
                  LET g_fabs2_d[l_ac].fabs016 = g_fabs2_d_t.fabs016
                  LET g_fabs2_d[l_ac].fabs016_desc = g_fabs2_d_t.fabs016_desc
                  CALL afat500_fabs016_desc(g_fabs2_d[l_ac].fabs016) RETURNING g_fabs2_d[l_ac].fabs016_desc
                  DISPLAY g_fabs2_d[l_ac].fabs016_desc TO s_detail2[l_ac].fabs016_desc
                  NEXT FIELD CURRENT  
                END IF
                #161221-00054#4--add--e--xul
             END IF   
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabs016_desc
            #add-point:ON CHANGE fabs016_desc name="input.g.page2.fabs016_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabs017
            #add-point:BEFORE FIELD fabs017 name="input.b.page2.fabs017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabs017
            
            #add-point:AFTER FIELD fabs017 name="input.a.page2.fabs017"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabs017
            #add-point:ON CHANGE fabs017 name="input.g.page2.fabs017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabs017_desc
            #add-point:BEFORE FIELD fabs017_desc name="input.b.page2.fabs017_desc"
            LET g_fabs2_d[l_ac].fabs017_desc = g_fabs2_d[l_ac].fabs017
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabs017_desc
            
            #add-point:AFTER FIELD fabs017_desc name="input.a.page2.fabs017_desc"
            LET g_fabs2_d[l_ac].fabs017 = g_fabs2_d[l_ac].fabs017_desc
            CALL afat500_fabs017_desc('287',g_fabs2_d[l_ac].fabs017) RETURNING g_fabs2_d[l_ac].fabs017_desc
            DISPLAY g_fabs2_d[l_ac].fabs017_desc TO s_detail2[l_ac].fabs017_desc
            IF NOT cl_null(g_fabs2_d[l_ac].fabs017) THEN 
#20150113 mod by chenying   
#               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
#               INITIALIZE g_chkparam.* TO NULL            
#               #設定g_chkparam.*的參數
#               LET g_chkparam.arg1 = g_fabs2_d[l_ac].fabs017            
#               #呼叫檢查存在並帶值的library
#               IF cl_chk_exist("v_oocq002_287") THEN
#                  #檢查成功時後續處理
#                  #LET  = g_chkparam.return1
#                  #DISPLAY BY NAME 
#               ELSE
#                  #檢查失敗時後續處理
#                  LET g_fabs2_d[l_ac].fabs017 = g_fabs2_d_t.fabs017
#                  LET g_fabs2_d[l_ac].fabs017_desc = g_fabs2_d_t.fabs017_desc
#                  CALL afat500_fabs017_desc('287',g_fabs2_d[l_ac].fabs017) RETURNING g_fabs2_d[l_ac].fabs017_desc
#                  DISPLAY g_fabs2_d[l_ac].fabs017_desc TO s_detail2[l_ac].fabs017_desc
#                  NEXT FIELD CURRENT
#               END IF
            IF NOT s_azzi650_chk_exist('287',g_fabs2_d[l_ac].fabs017) THEN
               LET g_fabs2_d[l_ac].fabs017 = g_fabs2_d_t.fabs017
               LET g_fabs2_d[l_ac].fabs017_desc = g_fabs2_d_t.fabs017_desc
               CALL afat500_fabs017_desc('287',g_fabs2_d[l_ac].fabs017) RETURNING g_fabs2_d[l_ac].fabs017_desc
               DISPLAY g_fabs2_d[l_ac].fabs017_desc TO s_detail2[l_ac].fabs017_desc
               NEXT FIELD CURRENT            
            END IF
#20150113 mod by chenying
             #161221-00054#4--add--s--xul
             #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件
             CALL s_voucher_hsx_glak_chk(g_fabg_m.fabgld,'04',g_fabs2_d[l_ac].fabs007,g_fabs2_d[l_ac].fabs017) RETURNING g_sub_success
             IF NOT g_sub_success THEN
               LET g_fabs2_d[l_ac].fabs017 = g_fabs2_d_t.fabs017
               LET g_fabs2_d[l_ac].fabs017_desc = g_fabs2_d_t.fabs017_desc
               CALL afat500_fabs017_desc('287',g_fabs2_d[l_ac].fabs017) RETURNING g_fabs2_d[l_ac].fabs017_desc
               DISPLAY g_fabs2_d[l_ac].fabs017_desc TO s_detail2[l_ac].fabs017_desc
               NEXT FIELD CURRENT 
             END IF
             CALL s_voucher_hsx_glak_chk(g_fabg_m.fabgld,'04',g_fabs2_d[l_ac].fabs008,g_fabs2_d[l_ac].fabs017) RETURNING g_sub_success
             IF NOT g_sub_success THEN
               LET g_fabs2_d[l_ac].fabs017 = g_fabs2_d_t.fabs017
               LET g_fabs2_d[l_ac].fabs017_desc = g_fabs2_d_t.fabs017_desc
               CALL afat500_fabs017_desc('287',g_fabs2_d[l_ac].fabs017) RETURNING g_fabs2_d[l_ac].fabs017_desc
               DISPLAY g_fabs2_d[l_ac].fabs017_desc TO s_detail2[l_ac].fabs017_desc
               NEXT FIELD CURRENT  
             END IF
             #161221-00054#4--add--e--xul
          END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabs017_desc
            #add-point:ON CHANGE fabs017_desc name="input.g.page2.fabs017_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabs018
            #add-point:BEFORE FIELD fabs018 name="input.b.page2.fabs018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabs018
            
            #add-point:AFTER FIELD fabs018 name="input.a.page2.fabs018"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabs018
            #add-point:ON CHANGE fabs018 name="input.g.page2.fabs018"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabs018_desc
            #add-point:BEFORE FIELD fabs018_desc name="input.b.page2.fabs018_desc"
            LET g_fabs2_d[l_ac].fabs018_desc = g_fabs2_d[l_ac].fabs018
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabs018_desc
            
            #add-point:AFTER FIELD fabs018_desc name="input.a.page2.fabs018_desc"
            LET g_fabs2_d[l_ac].fabs018 = g_fabs2_d[l_ac].fabs018_desc
            CALL afat500_fabs018_desc(g_fabs2_d[l_ac].fabs018) RETURNING g_fabs2_d[l_ac].fabs018_desc
            DISPLAY g_fabs2_d[l_ac].fabs018_desc TO s_detail2[l_ac].fabs018_desc
            IF NOT cl_null(g_fabs2_d[l_ac].fabs018) THEN 
#20150113 mod by chenying            
#               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
#               INITIALIZE g_chkparam.* TO NULL
#               #設定g_chkparam.*的參數
#               LET g_chkparam.arg1 = g_fabs2_d[l_ac].fabs018
#               #呼叫檢查存在並帶值的library
#               IF cl_chk_exist("v_pmaa001_2") THEN
#
#               ELSE
#                  #檢查失敗時後續處理
#                  LET g_fabs2_d[l_ac].fabs018 = g_fabs2_d_t.fabs018
#                  LET g_fabs2_d[l_ac].fabs018_desc = g_fabs2_d_t.fabs018_desc
#                  CALL afat500_fabs018_desc(g_fabs2_d[l_ac].fabs018) RETURNING g_fabs2_d[l_ac].fabs018_desc
#                  DISPLAY g_fabs2_d[l_ac].fabs018_desc TO s_detail2[l_ac].fabs018_desc
#                  NEXT FIELD CURRENT
#               END IF               
               CALL s_voucher_glaq021_chk(g_fabs2_d[l_ac].fabs018)
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = g_errno
                  #160321-00016#26 --s add
                  LET g_errparam.replace[1] = 'apmm100'
                  LET g_errparam.replace[2] = cl_get_progname('apmm100',g_lang,"2")
                  LET g_errparam.exeprog = 'apmm100'
                  #160321-00016#26 --e add
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  
                  LET g_fabs2_d[l_ac].fabs018 = g_fabs2_d_t.fabs018
                  LET g_fabs2_d[l_ac].fabs018_desc = g_fabs2_d_t.fabs018_desc
                  CALL afat500_fabs018_desc(g_fabs2_d[l_ac].fabs018) RETURNING g_fabs2_d[l_ac].fabs018_desc
                  DISPLAY g_fabs2_d[l_ac].fabs018_desc TO s_detail2[l_ac].fabs018_desc
                  NEXT FIELD CURRENT                  
               END IF 
#20150113 mod by chenying
               #161221-00054#4--add--s--xul
               #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件
               CALL s_voucher_hsx_glak_chk(g_fabg_m.fabgld,'05',g_fabs2_d[l_ac].fabs007,g_fabs2_d[l_ac].fabs018) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  LET g_fabs2_d[l_ac].fabs018 = g_fabs2_d_t.fabs018
                  LET g_fabs2_d[l_ac].fabs018_desc = g_fabs2_d_t.fabs018_desc
                  CALL afat500_fabs018_desc(g_fabs2_d[l_ac].fabs018) RETURNING g_fabs2_d[l_ac].fabs018_desc
                  DISPLAY g_fabs2_d[l_ac].fabs018_desc TO s_detail2[l_ac].fabs018_desc
                  NEXT FIELD CURRENT
               END IF
               CALL s_voucher_hsx_glak_chk(g_fabg_m.fabgld,'05',g_fabs2_d[l_ac].fabs008,g_fabs2_d[l_ac].fabs018) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  LET g_fabs2_d[l_ac].fabs018 = g_fabs2_d_t.fabs018
                  LET g_fabs2_d[l_ac].fabs018_desc = g_fabs2_d_t.fabs018_desc
                  CALL afat500_fabs018_desc(g_fabs2_d[l_ac].fabs018) RETURNING g_fabs2_d[l_ac].fabs018_desc
                  DISPLAY g_fabs2_d[l_ac].fabs018_desc TO s_detail2[l_ac].fabs018_desc
                  NEXT FIELD CURRENT 
               END IF
              #161221-00054#4--add--e--xul
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabs018_desc
            #add-point:ON CHANGE fabs018_desc name="input.g.page2.fabs018_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabs019
            #add-point:BEFORE FIELD fabs019 name="input.b.page2.fabs019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabs019
            
            #add-point:AFTER FIELD fabs019 name="input.a.page2.fabs019"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabs019
            #add-point:ON CHANGE fabs019 name="input.g.page2.fabs019"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabs019_desc
            #add-point:BEFORE FIELD fabs019_desc name="input.b.page2.fabs019_desc"
            LET g_fabs2_d[l_ac].fabs019_desc = g_fabs2_d[l_ac].fabs019
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabs019_desc
            
            #add-point:AFTER FIELD fabs019_desc name="input.a.page2.fabs019_desc"
            LET g_fabs2_d[l_ac].fabs019 = g_fabs2_d[l_ac].fabs019_desc
            CALL afat500_fabs019_desc(g_fabs2_d[l_ac].fabs019) RETURNING g_fabs2_d[l_ac].fabs019_desc
            DISPLAY g_fabs2_d[l_ac].fabs019_desc TO s_detail2[l_ac].fabs019_desc
            IF NOT cl_null(g_fabs2_d[l_ac].fabs019) THEN 
#20150113 mod by chenying 
#               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
#               INITIALIZE g_chkparam.* TO NULL          
#               #設定g_chkparam.*的參數
#               LET g_chkparam.arg1 = g_fabs2_d[l_ac].fabs019          
#               #呼叫檢查存在並帶值的library
#               IF cl_chk_exist("v_pmaa001_2") THEN
#                  #檢查成功時後續處理
#                  #LET  = g_chkparam.return1
#                  #DISPLAY BY NAME 
#               ELSE
#                  #檢查失敗時後續處理
#                  LET g_fabs2_d[l_ac].fabs019 = g_fabs2_d_t.fabs019
#                  LET g_fabs2_d[l_ac].fabs019_desc = g_fabs2_d_t.fabs019_desc
#                  CALL afat500_fabs019_desc(g_fabs2_d[l_ac].fabs019) RETURNING g_fabs2_d[l_ac].fabs019_desc
#                  DISPLAY g_fabs2_d[l_ac].fabs019_desc TO s_detail2[l_ac].fabs019_desc
#                  NEXT FIELD CURRENT
#               END IF
               CALL s_voucher_glaq021_chk(g_fabs2_d[l_ac].fabs019)
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = g_errno
                  #160321-00016#26 --s add
                  LET g_errparam.replace[1] = 'apmm100'
                  LET g_errparam.replace[2] = cl_get_progname('apmm100',g_lang,"2")
                  LET g_errparam.exeprog = 'apmm100'
                  #160321-00016#26 --e add
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  
                  LET g_fabs2_d[l_ac].fabs019 = g_fabs2_d_t.fabs019
                  LET g_fabs2_d[l_ac].fabs019_desc = g_fabs2_d_t.fabs019_desc
                  CALL afat500_fabs019_desc(g_fabs2_d[l_ac].fabs019) RETURNING g_fabs2_d[l_ac].fabs019_desc
                  DISPLAY g_fabs2_d[l_ac].fabs019_desc TO s_detail2[l_ac].fabs019_desc
                  NEXT FIELD CURRENT                
               END IF 
#20150113 mod by chenying
               #161221-00054#4--add--s--xul
               #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件
               CALL s_voucher_hsx_glak_chk(g_fabg_m.fabgld,'06',g_fabs2_d[l_ac].fabs007,g_fabs2_d[l_ac].fabs019) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  LET g_fabs2_d[l_ac].fabs019 = g_fabs2_d_t.fabs019
                  LET g_fabs2_d[l_ac].fabs019_desc = g_fabs2_d_t.fabs019_desc
                  CALL afat500_fabs019_desc(g_fabs2_d[l_ac].fabs019) RETURNING g_fabs2_d[l_ac].fabs019_desc
                  DISPLAY g_fabs2_d[l_ac].fabs019_desc TO s_detail2[l_ac].fabs019_desc
                  NEXT FIELD CURRENT       
               END IF
               CALL s_voucher_hsx_glak_chk(g_fabg_m.fabgld,'06',g_fabs2_d[l_ac].fabs008,g_fabs2_d[l_ac].fabs019) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  LET g_fabs2_d[l_ac].fabs019 = g_fabs2_d_t.fabs019
                  LET g_fabs2_d[l_ac].fabs019_desc = g_fabs2_d_t.fabs019_desc
                  CALL afat500_fabs019_desc(g_fabs2_d[l_ac].fabs019) RETURNING g_fabs2_d[l_ac].fabs019_desc
                  DISPLAY g_fabs2_d[l_ac].fabs019_desc TO s_detail2[l_ac].fabs019_desc
                  NEXT FIELD CURRENT       
               END IF
              #161221-00054#4--add--e--xul
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabs019_desc
            #add-point:ON CHANGE fabs019_desc name="input.g.page2.fabs019_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabs020
            #add-point:BEFORE FIELD fabs020 name="input.b.page2.fabs020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabs020
            
            #add-point:AFTER FIELD fabs020 name="input.a.page2.fabs020"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabs020
            #add-point:ON CHANGE fabs020 name="input.g.page2.fabs020"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabs020_desc
            #add-point:BEFORE FIELD fabs020_desc name="input.b.page2.fabs020_desc"
            LET g_fabs2_d[l_ac].fabs020_desc = g_fabs2_d[l_ac].fabs020
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabs020_desc
            
            #add-point:AFTER FIELD fabs020_desc name="input.a.page2.fabs020_desc"
            LET g_fabs2_d[l_ac].fabs020 = g_fabs2_d[l_ac].fabs020_desc
            CALL afat500_fabs017_desc('281',g_fabs2_d[l_ac].fabs020) RETURNING g_fabs2_d[l_ac].fabs020_desc
            DISPLAY g_fabs2_d[l_ac].fabs020_desc TO s_detail2[l_ac].fabs020_desc
            IF NOT cl_null(g_fabs2_d[l_ac].fabs020) THEN 
#20150113 mod by chenying 
#               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
#               INITIALIZE g_chkparam.* TO NULL        
#               #設定g_chkparam.*的參數
#               LET g_chkparam.arg1 = g_fabs2_d[l_ac].fabs020       
#               #呼叫檢查存在並帶值的library
#               IF cl_chk_exist("v_oocq002_281") THEN
#                  #檢查成功時後續處理
#                  #LET  = g_chkparam.return1
#                  #DISPLAY BY NAME 
#               ELSE
#                  #檢查失敗時後續處理
#                  LET g_fabs2_d[l_ac].fabs020 = g_fabs2_d_t.fabs020
#                  LET g_fabs2_d[l_ac].fabs020_desc = g_fabs2_d_t.fabs020_desc
#                  CALL afat500_fabs017_desc('281',g_fabs2_d[l_ac].fabs020) RETURNING g_fabs2_d[l_ac].fabs020_desc
#                  DISPLAY g_fabs2_d[l_ac].fabs020_desc TO s_detail2[l_ac].fabs020_desc
#                  NEXT FIELD CURRENT
#               END IF
               IF NOT s_azzi650_chk_exist('281',g_fabs2_d[l_ac].fabs020) THEN
                  LET g_fabs2_d[l_ac].fabs020 = g_fabs2_d_t.fabs020
                  LET g_fabs2_d[l_ac].fabs020_desc = g_fabs2_d_t.fabs020_desc
                  CALL afat500_fabs017_desc('281',g_fabs2_d[l_ac].fabs020) RETURNING g_fabs2_d[l_ac].fabs020_desc
                  DISPLAY g_fabs2_d[l_ac].fabs020_desc TO s_detail2[l_ac].fabs020_desc
                  NEXT FIELD CURRENT               
               END IF
#20150113 mod by chenying
               #161221-00054#4--add--s--xul
               #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件
               CALL s_voucher_hsx_glak_chk(g_fabg_m.fabgld,'07',g_fabs2_d[l_ac].fabs007,g_fabs2_d[l_ac].fabs020) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                   LET g_fabs2_d[l_ac].fabs020 = g_fabs2_d_t.fabs020
                  LET g_fabs2_d[l_ac].fabs020_desc = g_fabs2_d_t.fabs020_desc
                  CALL afat500_fabs017_desc('281',g_fabs2_d[l_ac].fabs020) RETURNING g_fabs2_d[l_ac].fabs020_desc
                  DISPLAY g_fabs2_d[l_ac].fabs020_desc TO s_detail2[l_ac].fabs020_desc
                  NEXT FIELD CURRENT       
               END IF
               CALL s_voucher_hsx_glak_chk(g_fabg_m.fabgld,'07',g_fabs2_d[l_ac].fabs008,g_fabs2_d[l_ac].fabs020) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                   LET g_fabs2_d[l_ac].fabs020 = g_fabs2_d_t.fabs020
                  LET g_fabs2_d[l_ac].fabs020_desc = g_fabs2_d_t.fabs020_desc
                  CALL afat500_fabs017_desc('281',g_fabs2_d[l_ac].fabs020) RETURNING g_fabs2_d[l_ac].fabs020_desc
                  DISPLAY g_fabs2_d[l_ac].fabs020_desc TO s_detail2[l_ac].fabs020_desc
                  NEXT FIELD CURRENT       
               END IF
              #161221-00054#4--add--e--xul
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabs020_desc
            #add-point:ON CHANGE fabs020_desc name="input.g.page2.fabs020_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabs022
            #add-point:BEFORE FIELD fabs022 name="input.b.page2.fabs022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabs022
            
            #add-point:AFTER FIELD fabs022 name="input.a.page2.fabs022"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabs022
            #add-point:ON CHANGE fabs022 name="input.g.page2.fabs022"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabs022_desc
            #add-point:BEFORE FIELD fabs022_desc name="input.b.page2.fabs022_desc"
            LET g_fabs2_d[l_ac].fabs022_desc = g_fabs2_d[l_ac].fabs022
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabs022_desc
            
            #add-point:AFTER FIELD fabs022_desc name="input.a.page2.fabs022_desc"
            LET g_fabs2_d[l_ac].fabs022 = g_fabs2_d[l_ac].fabs022_desc
            CALL afat500_fabs022_desc()
            IF NOT cl_null(g_fabs2_d[l_ac].fabs022) THEN 
#20150113 mod by chenying 
#               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
#               INITIALIZE g_chkparam.* TO NULL
#               #設定g_chkparam.*的參數
#               LET g_chkparam.arg1 = g_fabs2_d[l_ac].fabs022
#               #呼叫檢查存在並帶值的library
#               IF cl_chk_exist("v_ooag001") THEN
#                  #檢查成功時後續處理
#                  #LET  = g_chkparam.return1
#                  #DISPLAY BY NAME 
#               ELSE
#                  #檢查失敗時後續處理
#                  LET g_fabs2_d[l_ac].fabs022 = g_fabs2_d_t.fabs022
#                  LET g_fabs2_d[l_ac].fabs022_desc = g_fabs2_d_t.fabs022_desc
#                  CALL afat500_fabs022_desc()
#                  NEXT FIELD CURRENT
#               END IF
               CALL s_employee_chk(g_fabs2_d[l_ac].fabs022) RETURNING g_sub_success
               IF NOT g_sub_success THEN 
                  LET g_fabs2_d[l_ac].fabs022 = g_fabs2_d_t.fabs022
                  LET g_fabs2_d[l_ac].fabs022_desc = g_fabs2_d_t.fabs022_desc
                  CALL afat500_fabs022_desc()
                  NEXT FIELD CURRENT               
               END IF
#20150113 mod by chenying 
                #161221-00054#4--add--s--xul
               #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件
               CALL s_voucher_hsx_glak_chk(g_fabg_m.fabgld,'12',g_fabs2_d[l_ac].fabs007,g_fabs2_d[l_ac].fabs022) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  LET g_fabs2_d[l_ac].fabs022 = g_fabs2_d_t.fabs022
                  LET g_fabs2_d[l_ac].fabs022_desc = g_fabs2_d_t.fabs022_desc
                  CALL afat500_fabs022_desc()
                  NEXT FIELD CURRENT       
               END IF
               CALL s_voucher_hsx_glak_chk(g_fabg_m.fabgld,'12',g_fabs2_d[l_ac].fabs008,g_fabs2_d[l_ac].fabs022) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  LET g_fabs2_d[l_ac].fabs022 = g_fabs2_d_t.fabs022
                  LET g_fabs2_d[l_ac].fabs022_desc = g_fabs2_d_t.fabs022_desc
                  CALL afat500_fabs022_desc()
                  NEXT FIELD CURRENT    
               END IF
              #161221-00054#4--add--e--xul
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabs022_desc
            #add-point:ON CHANGE fabs022_desc name="input.g.page2.fabs022_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabs024
            #add-point:BEFORE FIELD fabs024 name="input.b.page2.fabs024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabs024
            
            #add-point:AFTER FIELD fabs024 name="input.a.page2.fabs024"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabs024
            #add-point:ON CHANGE fabs024 name="input.g.page2.fabs024"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabs024_desc
            #add-point:BEFORE FIELD fabs024_desc name="input.b.page2.fabs024_desc"
            LET g_fabs2_d[l_ac].fabs024_desc = g_fabs2_d[l_ac].fabs024
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabs024_desc
            
            #add-point:AFTER FIELD fabs024_desc name="input.a.page2.fabs024_desc"
            LET g_fabs2_d[l_ac].fabs024 = g_fabs2_d[l_ac].fabs024_desc
            CALL afat500_fabs024_desc()
            IF NOT cl_null(g_fabs2_d[l_ac].fabs024) THEN 
#20150113 mod by chenying 
##此段落由子樣板a19產生
#               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
#               INITIALIZE g_chkparam.* TO NULL
#               
#               #設定g_chkparam.*的參數
#               LET g_chkparam.arg1 = g_fabs2_d[l_ac].fabs024 
#            
#                  
#               #呼叫檢查存在並帶值的library
#               IF cl_chk_exist("v_pjba001") THEN
#                  #檢查成功時後續處理
#                  #LET  = g_chkparam.return1
#                  #DISPLAY BY NAME 
#            
#               ELSE
#                  #檢查失敗時後續處理
#                  LET g_fabs2_d[l_ac].fabs024 = g_fabs2_d_t.fabs024
#                  LET g_fabs2_d[l_ac].fabs024_desc = g_fabs2_d_t.fabs024_desc
#                  CALL afat500_fabs024_desc()
#                  NEXT FIELD CURRENT
#               END IF         
               CALL s_aap_project_chk(g_fabs2_d[l_ac].fabs024) RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  #160321-00016#26 --s add
                  LET g_errparam.replace[1] = 'apjm200'
                  LET g_errparam.replace[2] = cl_get_progname('apjm200',g_lang,"2")
                  LET g_errparam.exeprog = 'apjm200'
                  #160321-00016#26 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_fabs2_d[l_ac].fabs024 = g_fabs2_d_t.fabs024
                  LET g_fabs2_d[l_ac].fabs024_desc = g_fabs2_d_t.fabs024_desc
                  CALL afat500_fabs024_desc()
                  NEXT FIELD CURRENT 
               END IF
#20150113 mod by chenying
                #161221-00054#4--add--s--xul
               #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件
               CALL s_voucher_hsx_glak_chk(g_fabg_m.fabgld,'13',g_fabs2_d[l_ac].fabs007,g_fabs2_d[l_ac].fabs024) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  LET g_fabs2_d[l_ac].fabs024 = g_fabs2_d_t.fabs024
                  LET g_fabs2_d[l_ac].fabs024_desc = g_fabs2_d_t.fabs024_desc
                  CALL afat500_fabs024_desc()
                  NEXT FIELD CURRENT        
               END IF
               CALL s_voucher_hsx_glak_chk(g_fabg_m.fabgld,'13',g_fabs2_d[l_ac].fabs008,g_fabs2_d[l_ac].fabs024) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  LET g_fabs2_d[l_ac].fabs024 = g_fabs2_d_t.fabs024
                  LET g_fabs2_d[l_ac].fabs024_desc = g_fabs2_d_t.fabs024_desc
                  CALL afat500_fabs024_desc()
                  NEXT FIELD CURRENT  
               END IF
              #161221-00054#4--add--e--xul
            END IF  
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabs024_desc
            #add-point:ON CHANGE fabs024_desc name="input.g.page2.fabs024_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabs025
            #add-point:BEFORE FIELD fabs025 name="input.b.page2.fabs025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabs025
            
            #add-point:AFTER FIELD fabs025 name="input.a.page2.fabs025"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabs025
            #add-point:ON CHANGE fabs025 name="input.g.page2.fabs025"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabs025_desc
            #add-point:BEFORE FIELD fabs025_desc name="input.b.page2.fabs025_desc"
            LET g_fabs2_d[l_ac].fabs025_desc = g_fabs2_d[l_ac].fabs025
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabs025_desc
            
            #add-point:AFTER FIELD fabs025_desc name="input.a.page2.fabs025_desc"
            LET g_fabs2_d[l_ac].fabs025 = g_fabs2_d[l_ac].fabs025_desc
            CALL afat500_fabs025_desc()
            IF NOT cl_null(g_fabs2_d[l_ac].fabs025) THEN 
#20150113 mod by chenying              
###此段落由子樣板a19產生
#               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
#               INITIALIZE g_chkparam.* TO NULL
#               
#               #設定g_chkparam.*的參數
#               LET g_chkparam.arg1 = g_fabs2_d[l_ac].fabs024
#               LET g_chkparam.arg2 = g_fabs2_d[l_ac].fabs025 
# 
#                  
#               #呼叫檢查存在並帶值的library
#               IF cl_chk_exist("v_pjbb002") THEN
#                  #檢查成功時後續處理
#                  #LET  = g_chkparam.return1
#                  #DISPLAY BY NAME 
#            
#               ELSE
#                  #檢查失敗時後續處理
#                  LET g_fabs2_d[l_ac].fabs025 = g_fabs2_d_t.fabs025
#                  LET g_fabs2_d[l_ac].fabs025_desc = g_fabs2_d_t.fabs025_desc
#                  CALL afat500_fabs025_desc()
#                  NEXT FIELD CURRENT
#               END IF
               CALL s_voucher_glaq028_chk(g_fabs2_d[l_ac].fabs024,g_fabs2_d[l_ac].fabs025)
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_fabs2_d[l_ac].fabs025
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  
                  LET g_fabs2_d[l_ac].fabs025 = g_fabs2_d_t.fabs025
                  LET g_fabs2_d[l_ac].fabs025_desc = g_fabs2_d_t.fabs025_desc 
                  CALL afat500_fabs025_desc() 
                  NEXT FIELD fabs025_desc
               END IF
               #161221-00054#4--add--s--xul
               #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件
               CALL s_voucher_hsx_glak_chk(g_fabg_m.fabgld,'14',g_fabs2_d[l_ac].fabs007,g_fabs2_d[l_ac].fabs025) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  LET g_fabs2_d[l_ac].fabs025 = g_fabs2_d_t.fabs025
                  LET g_fabs2_d[l_ac].fabs025_desc = g_fabs2_d_t.fabs025_desc 
                  CALL afat500_fabs025_desc() 
                  NEXT FIELD fabs025_desc     
               END IF
               CALL s_voucher_hsx_glak_chk(g_fabg_m.fabgld,'14',g_fabs2_d[l_ac].fabs008,g_fabs2_d[l_ac].fabs025) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  LET g_fabs2_d[l_ac].fabs025 = g_fabs2_d_t.fabs025
                  LET g_fabs2_d[l_ac].fabs025_desc = g_fabs2_d_t.fabs025_desc 
                  CALL afat500_fabs025_desc() 
                  NEXT FIELD fabs025_desc
               END IF
              #161221-00054#4--add--e--xul               
            END IF 
#20150113 mod by chenying              
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabs025_desc
            #add-point:ON CHANGE fabs025_desc name="input.g.page2.fabs025_desc"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page2.fabs007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabs007
            #add-point:ON ACTION controlp INFIELD fabs007 name="input.c.page2.fabs007"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabs2_d[l_ac].fabs007             #給予default值
            LET g_qryparam.where = " glac001 = '",g_glaa004,"' AND glac003 <> '1' ",
                                    " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 ",
                                   "AND gladld='",g_fabg_m.fabgld,"' AND gladent='",g_enterprise,"'",
                                   " AND gladstus = 'Y' )"
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL aglt310_04()                                #呼叫開窗

            LET g_fabs2_d[l_ac].fabs007 = g_qryparam.return1              

            DISPLAY g_fabs2_d[l_ac].fabs007 TO fabs007              #
            CALL afat500_fabs007_desc()
            NEXT FIELD fabs007                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.fabs007_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabs007_desc
            #add-point:ON ACTION controlp INFIELD fabs007_desc name="input.c.page2.fabs007_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.fabs008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabs008
            #add-point:ON ACTION controlp INFIELD fabs008 name="input.c.page2.fabs008"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabs2_d[l_ac].fabs008             #給予default值
            LET g_qryparam.where = " glac001 = '",g_glaa004,"' AND glac003 <> '1' ",
                                    " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 ",
                                   "AND gladld='",g_fabg_m.fabgld,"' AND gladent='",g_enterprise,"'",
                                   " AND gladstus = 'Y' )"
            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL aglt310_04()                                #呼叫開窗

            LET g_fabs2_d[l_ac].fabs008 = g_qryparam.return1              

            DISPLAY g_fabs2_d[l_ac].fabs008 TO fabs008              #
            CALL afat500_fabs008_desc()  
            NEXT FIELD fabs008                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.fabs008_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabs008_desc
            #add-point:ON ACTION controlp INFIELD fabs008_desc name="input.c.page2.fabs008_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.fabs014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabs014
            #add-point:ON ACTION controlp INFIELD fabs014 name="input.c.page2.fabs014"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.fabs014_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabs014_desc
            #add-point:ON ACTION controlp INFIELD fabs014_desc name="input.c.page2.fabs014_desc"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabs2_d[l_ac].fabs014             #給予default值
            LET g_qryparam.default2 = "" #g_fabs2_d[l_ac].ooefl003 #說明(簡稱)
            #給予arg
            LET g_qryparam.arg1 = "" #

            LET g_qryparam.where ="ooefstus='Y'"   #20150113 add by chenying
            
            #161221-00054#4--add--s--xul
            #agli060设置的客群限制条件
            CALL s_voucher_get_glak_sql(g_fabg_m.fabgld,'01',l_wc) RETURNING l_glak_sql
            LET g_qryparam.where = g_qryparam.where," AND ",l_glak_sql
            #161221-00054#4--add--e--xul
            
            CALL q_ooef001_1()                                         #161024-00008#4 
            #CALL q_ooef001()                                #呼叫開窗 #161024-00008#4

            LET g_fabs2_d[l_ac].fabs014 = g_qryparam.return1              
            CALL afat500_fabs014_desc()
            DISPLAY g_fabs2_d[l_ac].fabs014_desc TO fabs014_desc              #

            NEXT FIELD fabs014_desc                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.fabs015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabs015
            #add-point:ON ACTION controlp INFIELD fabs015 name="input.c.page2.fabs015"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.fabs015_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabs015_desc
            #add-point:ON ACTION controlp INFIELD fabs015_desc name="input.c.page2.fabs015_desc"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabs2_d[l_ac].fabs015             #給予default值
            #161221-00054#4--add--s--xul
            #agli060设置的客群限制条件
            CALL s_voucher_get_glak_sql(g_fabg_m.fabgld,'02',l_wc) RETURNING l_glak_sql
            LET g_qryparam.where = l_glak_sql
            #161221-00054#4--add--e--xul
            #給予arg
            LET g_qryparam.arg1 = g_fabg_m.fabgdocdt   #20150113 mod by chenying g_today-->单据日（生效日期）

            
            CALL q_ooeg001_4()                                #呼叫開窗

            LET g_fabs2_d[l_ac].fabs015 = g_qryparam.return1              
            CALL afat500_fabs015_desc(g_fabs2_d[l_ac].fabs015) RETURNING g_fabs2_d[l_ac].fabs015_desc
            DISPLAY g_fabs2_d[l_ac].fabs015_desc TO fabs015_desc              #

            NEXT FIELD fabs015_desc                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.fabs016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabs016
            #add-point:ON ACTION controlp INFIELD fabs016 name="input.c.page2.fabs016"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.fabs016_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabs016_desc
            #add-point:ON ACTION controlp INFIELD fabs016_desc name="input.c.page2.fabs016_desc"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabs2_d[l_ac].fabs016             #給予default值
            
            LET g_qryparam.where = " (ooeg003 = '2' OR ooeg003 = '3')"
            #161221-00054#4--add--s--xul
            #agli060设置的客群限制条件
            CALL s_voucher_get_glak_sql(g_fabg_m.fabgld,'03',l_wc) RETURNING l_glak_sql
            LET g_qryparam.where = g_qryparam.where," AND ",l_glak_sql
            #161221-00054#4--add--e--xul
            #給予arg
#           LET g_qryparam.arg1 = g_today            #20150113 mark by chenying
#           CALL q_ooeg001_4()                       #20150113 mark by chenying
            LET g_qryparam.arg1 = g_fabg_m.fabgdocdt #20150113 add by chenying
           #CALL q_ooeg001_5()                       #20150113 add by chenying   #161221-00054#4 MARK xul    
            CALL q_ooeg001_15()                      #161221-00054#4 add xul  
            LET g_fabs2_d[l_ac].fabs016 = g_qryparam.return1              
            CALL afat500_fabs016_desc(g_fabs2_d[l_ac].fabs016) RETURNING g_fabs2_d[l_ac].fabs016_desc
            DISPLAY g_fabs2_d[l_ac].fabs016_desc TO fabs016_desc              #

            NEXT FIELD fabs016_desc                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.fabs017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabs017
            #add-point:ON ACTION controlp INFIELD fabs017 name="input.c.page2.fabs017"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.fabs017_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabs017_desc
            #add-point:ON ACTION controlp INFIELD fabs017_desc name="input.c.page2.fabs017_desc"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabs2_d[l_ac].fabs017             #給予default值
            #161221-00054#4--add--s--xul
            #agli060设置的客群限制条件
            CALL s_voucher_get_glak_sql(g_fabg_m.fabgld,'04',l_wc) RETURNING l_glak_sql
            LET g_qryparam.where = l_glak_sql
            #161221-00054#4--add--e--xul
            #給予arg
#            LET g_qryparam.arg1 = '287'  #20150113 mark by chenying
#            CALL q_oocq002()             #20150113 mark by chenying                    
            CALL q_oocq002_287()          #20150113 add by chenying
            LET g_fabs2_d[l_ac].fabs017 = g_qryparam.return1              
            CALL afat500_fabs017_desc('287',g_fabs2_d[l_ac].fabs017) RETURNING g_fabs2_d[l_ac].fabs017_desc
            DISPLAY g_fabs2_d[l_ac].fabs017_desc TO fabs017_desc              #

            NEXT FIELD fabs017_desc                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.fabs018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabs018
            #add-point:ON ACTION controlp INFIELD fabs018 name="input.c.page2.fabs018"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.fabs018_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabs018_desc
            #add-point:ON ACTION controlp INFIELD fabs018_desc name="input.c.page2.fabs018_desc"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabs2_d[l_ac].fabs018             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #
            
            #161221-00054#4--add--s--xul
            #agli060设置的客群限制条件
            CALL s_voucher_get_glak_sql(g_fabg_m.fabgld,'05',l_wc) RETURNING l_glak_sql
            LET g_qryparam.where = l_glak_sql
            #161221-00054#4--add--e--xul
            
            #CALL q_pmaa001()    #160913-00017#1  mark               #呼叫開窗
           CALL q_pmaa001_25() #160913-00017#1  add 

            LET g_fabs2_d[l_ac].fabs018 = g_qryparam.return1              
            CALL afat500_fabs018_desc(g_fabs2_d[l_ac].fabs018) RETURNING g_fabs2_d[l_ac].fabs018_desc 
            DISPLAY g_fabs2_d[l_ac].fabs018_desc TO fabs018_desc              #

            NEXT FIELD fabs018_desc                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.fabs019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabs019
            #add-point:ON ACTION controlp INFIELD fabs019 name="input.c.page2.fabs019"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.fabs019_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabs019_desc
            #add-point:ON ACTION controlp INFIELD fabs019_desc name="input.c.page2.fabs019_desc"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabs2_d[l_ac].fabs019             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #
            #161221-00054#4--add--s--xul
            #agli060设置的客群限制条件
            CALL s_voucher_get_glak_sql(g_fabg_m.fabgld,'06',l_wc) RETURNING l_glak_sql
            LET g_qryparam.where = l_glak_sql
            #161221-00054#4--add--e--xul
            
             #CALL q_pmaa001()    #160913-00017#1  mark               #呼叫開窗
           CALL q_pmaa001_25() #160913-00017#1  add 

            LET g_fabs2_d[l_ac].fabs019 = g_qryparam.return1              
            CALL afat500_fabs019_desc(g_fabs2_d[l_ac].fabs019) RETURNING g_fabs2_d[l_ac].fabs019_desc
            DISPLAY g_fabs2_d[l_ac].fabs019_desc TO fabs019_desc              #

            NEXT FIELD fabs019_desc                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.fabs020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabs020
            #add-point:ON ACTION controlp INFIELD fabs020 name="input.c.page2.fabs020"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.fabs020_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabs020_desc
            #add-point:ON ACTION controlp INFIELD fabs020_desc name="input.c.page2.fabs020_desc"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabs2_d[l_ac].fabs020            #給予default值
            #161221-00054#4--add--s--xul
            #agli060设置的客群限制条件
            CALL s_voucher_get_glak_sql(g_fabg_m.fabgld,'07',l_wc) RETURNING l_glak_sql
            LET g_qryparam.where = l_glak_sql
            #161221-00054#4--add--e--xul
            #給予arg
#            LET g_qryparam.arg1 = '281'         #20150113 mark by chenying   
#            CALL q_oocq002()                    #20150113 mark by chenying          
            CALL q_oocq002_281()                 #20150113 add by chenying
            
            LET g_fabs2_d[l_ac].fabs020 = g_qryparam.return1              
            CALL afat500_fabs017_desc('281',g_fabs2_d[l_ac].fabs020) RETURNING g_fabs2_d[l_ac].fabs020_desc
            DISPLAY g_fabs2_d[l_ac].fabs020_desc TO fabs020_desc              #

            NEXT FIELD fabs020_desc                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.fabs022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabs022
            #add-point:ON ACTION controlp INFIELD fabs022 name="input.c.page2.fabs022"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.fabs022_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabs022_desc
            #add-point:ON ACTION controlp INFIELD fabs022_desc name="input.c.page2.fabs022_desc"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabs2_d[l_ac].fabs022             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #
            #161221-00054#4--add--s--xul
            #agli060设置的客群限制条件
            CALL s_voucher_get_glak_sql(g_fabg_m.fabgld,'12',l_wc) RETURNING l_glak_sql
            LET g_qryparam.where =  l_glak_sql
            #161221-00054#4--add--e--xul
            
#            CALL q_ooag001_2() #20150113 mark by chenying              
            CALL q_ooag001_8()  #20150113 add by chenying

            LET g_fabs2_d[l_ac].fabs022 = g_qryparam.return1              
            CALL afat500_fabs022_desc()
            DISPLAY g_fabs2_d[l_ac].fabs022_desc TO fabs022_desc              #

            NEXT FIELD fabs022_desc                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.fabs024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabs024
            #add-point:ON ACTION controlp INFIELD fabs024 name="input.c.page2.fabs024"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.fabs024_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabs024_desc
            #add-point:ON ACTION controlp INFIELD fabs024_desc name="input.c.page2.fabs024_desc"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabs2_d[l_ac].fabs024             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #
            #161221-00054#4--add--s--xul
            #agli060设置的客群限制条件
            CALL s_voucher_get_glak_sql(g_fabg_m.fabgld,'13',l_wc) RETURNING l_glak_sql
            LET g_qryparam.where =  l_glak_sql
            #161221-00054#4--add--e--xul
            
            CALL q_pjba001()                                #呼叫開窗

            LET g_fabs2_d[l_ac].fabs024 = g_qryparam.return1              
            CALL afat500_fabs024_desc()
            DISPLAY g_fabs2_d[l_ac].fabs024_desc TO fabs024_desc              #

            NEXT FIELD fabs024_desc                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.fabs025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabs025
            #add-point:ON ACTION controlp INFIELD fabs025 name="input.c.page2.fabs025"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.fabs025_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabs025_desc
            #add-point:ON ACTION controlp INFIELD fabs025_desc name="input.c.page2.fabs025_desc"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabs2_d[l_ac].fabs025             #給予default值

            #給予arg
#            LET g_qryparam.arg1 = g_fabs2_d[l_ac].fabs024 #20150113 mark by chenying 
            
            #20150113 add by chenying
            IF NOT cl_null(g_fabs2_d[l_ac].fabs024) THEN
               LET g_qryparam.where = "pjbb012='1' AND pjbb001='",g_fabs2_d[l_ac].fabs024,"'"
            ELSE
               LET g_qryparam.where = "pjbb012='1'"
            END IF
            #161221-00054#4--add--s--xul
            #agli060设置的客群限制条件
            CALL s_voucher_get_glak_sql(g_fabg_m.fabgld,'14',l_wc) RETURNING l_glak_sql
            LET g_qryparam.where = g_qryparam.where," AND ",l_glak_sql
            #161221-00054#4--add--e--xul
            CALL q_pjbb002()             #呼叫開窗
            #20150113 add by chenying
            
#            CALL q_pjbb002_1()  #20150113 mark by chenying                                  
 

            LET g_fabs2_d[l_ac].fabs025 = g_qryparam.return1              
            CALL afat500_fabs025_desc()
            DISPLAY g_fabs2_d[l_ac].fabs025_desc TO fabs025_desc              #

            NEXT FIELD fabs025_desc                          #返回原欄位


            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page2 after_row name="input.body2.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_fabs2_d[l_ac].* = g_fabs2_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE afat500_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL afat500_unlock_b("fabs_t","'2'")
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
               LET g_fabs_d[li_reproduce_target].* = g_fabs_d[li_reproduce].*
               LET g_fabs2_d[li_reproduce_target].* = g_fabs2_d[li_reproduce].*
               LET g_fabs3_d[li_reproduce_target].* = g_fabs3_d[li_reproduce].*
 
               LET g_fabs2_d[li_reproduce_target].fabsseq = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_fabs2_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_fabs2_d.getLength()+1
            END IF
            
      END INPUT
 
      
 
      DISPLAY ARRAY g_fabs3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
    
         BEFORE ROW
            CALL afat500_idx_chk()
            LET l_ac = DIALOG.getCurrentRow("s_detail3")
            LET g_detail_idx = l_ac
            
            #add-point:page3, before row動作 name="input.body3.before_row"
            
            #end add-point
            
         BEFORE DISPLAY
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue(""))
            END IF
            LET g_loc = 'm'
            LET l_ac = DIALOG.getCurrentRow("s_detail3")
            CALL afat500_idx_chk()
            LET g_current_page = 3
      
         #add-point:page3自定義行為 name="input.body3.action"
         
         #end add-point
      
      END DISPLAY
 
 
 
{</section>}
 
{<section id="afat500.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
         IF p_cmd = 'a' THEN
            NEXT FIELD fabgsite
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD fabsseq
               WHEN "s_detail2"
                  NEXT FIELD fabsseq_2
               WHEN "s_detail3"
                  NEXT FIELD fabsseq_3
 
            END CASE
         END IF
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1','2','3',"))      
         CALL DIALOG.setCurrentRow("s_detail2",g_idx_group.getValue(""))
         CALL DIALOG.setCurrentRow("s_detail3",g_idx_group.getValue(""))
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            
            #end add-point  
            NEXT FIELD fabgld
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD fabsseq
               WHEN "s_detail2"
                  NEXT FIELD fabsseq_2
               WHEN "s_detail3"
                  NEXT FIELD fabsseq_3
 
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
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
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
         LET g_detail_idx_list[3] = 1
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
         CALL g_curr_diag.setCurrentRow("s_detail3",1)
 
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
    
   #add-point:input段after input  name="input.after_input"
   #20150104 add by chenying
   IF g_glaa.glaa121 = 'Y' AND INT_FLAG = 0 THEN 
      CALL s_transaction_begin()
      CALL cl_err_collect_init()
      
      IF g_fabg_m.fabg005 = '22' THEN 
         CALL s_pre_voucher_ins('FA','F10',g_fabg_m.fabgld,g_fabg_m.fabgdocno,g_fabg_m.fabgdocdt,'22') RETURNING l_success
      ELSE
         CALL s_pre_voucher_ins('FA','F20',g_fabg_m.fabgld,g_fabg_m.fabgdocno,g_fabg_m.fabgdocdt,'26') RETURNING l_success
      END IF
      IF l_success THEN
         CALL cl_err_collect_init()
         CALL cl_err_collect_show()
         CALL s_transaction_end('Y','1')
      ELSE
         CALL cl_err_collect_show()
         CALL s_transaction_end('N','1')     
      END IF 
   END IF
   #20150104 add by chenying
   #151125-00006#2--add--s
   IF NOT INT_FLAG THEN
       CALL s_aooi200_fin_get_slip(g_fabg_m.fabgdocno) RETURNING l_success,l_ooba002
       CALL s_fin_orga_get_comp_ld(g_fabg_m.fabgsite) RETURNING g_sub_success,g_errno,l_fabgcomp,l_ld
       CALL s_fin_get_doc_para(g_fabg_m.fabgld,l_fabgcomp,l_ooba002,'D-FIN-0031') RETURNING l_dfin0031
       CALL s_fin_get_doc_para(g_fabg_m.fabgld,l_fabgcomp,l_ooba002,'D-FIN-0032') RETURNING l_dfin0032
       IF NOT cl_null(l_dfin0031) AND l_dfin0031 MATCHES '[Yy]' THEN 
          IF cl_ask_confirm('aap-00403') THEN
             CALL s_transaction_begin()
             CALL s_afat503_immediately_conf_1(g_fabg_m.fabgdocno,l_fabgcomp,g_fabg_m.fabgld,g_fabg_m.fabgdocdt,g_prog) RETURNING l_success
             IF l_success THEN 
                CALL s_transaction_end('Y','0')
             ELSE
                CALL s_transaction_end('N','0')
                CALL cl_err_collect_show()
             END IF 
          END IF 
       END IF
   END IF
   #151125-00006#2--add--e
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="afat500.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION afat500_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   IF g_fabg_m.fabgstus = 'Y' THEN
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   ELSE
      CALL cl_set_act_visible("modify,delete,modify_detail", TRUE)
   END IF     
   CALL afat500_glaa_visible()
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL afat500_b_fill() #單身填充
      CALL afat500_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL afat500_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
 
   #end add-point
   
   #遮罩相關處理
   LET g_fabg_m_mask_o.* =  g_fabg_m.*
   CALL afat500_fabg_t_mask()
   LET g_fabg_m_mask_n.* =  g_fabg_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_fabg_m.fabgsite,g_fabg_m.fabgsite_desc,g_fabg_m.fabg001,g_fabg_m.fabg001_desc,g_fabg_m.fabgld, 
       g_fabg_m.fabgld_desc,g_fabg_m.fabg002,g_fabg_m.fabg002_desc,g_fabg_m.fabg003,g_fabg_m.fabg003_desc, 
       g_fabg_m.fabg004,g_fabg_m.fabg005,g_fabg_m.fabgdocno,g_fabg_m.fabgdocdt,g_fabg_m.fabg008,g_fabg_m.fabg009, 
       g_fabg_m.fabgstus,g_fabg_m.fabgownid,g_fabg_m.fabgownid_desc,g_fabg_m.fabgowndp,g_fabg_m.fabgowndp_desc, 
       g_fabg_m.fabgcrtid,g_fabg_m.fabgcrtid_desc,g_fabg_m.fabgcrtdp,g_fabg_m.fabgcrtdp_desc,g_fabg_m.fabgcrtdt, 
       g_fabg_m.fabgmodid,g_fabg_m.fabgmodid_desc,g_fabg_m.fabgmoddt,g_fabg_m.fabgcnfid,g_fabg_m.fabgcnfid_desc, 
       g_fabg_m.fabgcnfdt,g_fabg_m.fabgpstid,g_fabg_m.fabgpstid_desc,g_fabg_m.fabgpstdt
   
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
   FOR l_ac = 1 TO g_fabs_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_fabs2_d.getLength()
      #add-point:show段單身reference name="show.body2.reference"
      
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_fabs3_d.getLength()
      #add-point:show段單身reference name="show.body3.reference"
      
      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL afat500_detail_show()
 
   #add-point:show段之後 name="show.after"
   #20150210 add by chenying
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
 
   IF g_glaa.glaa121 = 'Y' THEN
      CALL cl_set_toolbaritem_visible('open_pre',TRUE)
   ELSE
      CALL cl_set_toolbaritem_visible('open_pre',FALSE)
   END IF
   #20150210 add by chenying
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="afat500.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION afat500_detail_show()
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
 
{<section id="afat500.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION afat500_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE fabg_t.fabgld 
   DEFINE l_oldno     LIKE fabg_t.fabgld 
   DEFINE l_newno02     LIKE fabg_t.fabgdocno 
   DEFINE l_oldno02     LIKE fabg_t.fabgdocno 
 
   DEFINE l_master    RECORD LIKE fabg_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE fabs_t.* #此變數樣板目前無使用
 
 
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
   #160414-00015#1 add -str
   LET g_fabg_m.fabg008  =  NULL
   LET g_fabg_m.fabg009  =  NULL
   LET g_fabg_m.fabgdocdt = g_today
   LET g_fabg_m.fabgcnfdt = NULL
   LET g_fabg_m.fabgcnfid  = NULL
   LET g_fabg_m.fabgcnfid_desc  = NULL   
   #160414-00015#1 add -end
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
 
   
   CALL afat500_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_fabg_m.* TO NULL
      INITIALIZE g_fabs_d TO NULL
      INITIALIZE g_fabs2_d TO NULL
      INITIALIZE g_fabs3_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL afat500_show()
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
   CALL afat500_set_act_visible()   
   CALL afat500_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_fabgld_t = g_fabg_m.fabgld
   LET g_fabgdocno_t = g_fabg_m.fabgdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " fabgent = " ||g_enterprise|| " AND",
                      " fabgld = '", g_fabg_m.fabgld, "' "
                      ," AND fabgdocno = '", g_fabg_m.fabgdocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL afat500_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL afat500_idx_chk()
   
   LET g_data_owner = g_fabg_m.fabgownid      
   LET g_data_dept  = g_fabg_m.fabgowndp
   
   #功能已完成,通報訊息中心
   CALL afat500_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="afat500.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION afat500_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE fabs_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE afat500_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM fabs_t
    WHERE fabsent = g_enterprise AND fabsld = g_fabgld_t
     AND fabsdocno = g_fabgdocno_t
 
    INTO TEMP afat500_detail
 
   #將key修正為調整後   
   UPDATE afat500_detail 
      #更新key欄位
      SET fabsld = g_fabg_m.fabgld
          , fabsdocno = g_fabg_m.fabgdocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO fabs_t SELECT * FROM afat500_detail
   
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
   DROP TABLE afat500_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_fabgld_t = g_fabg_m.fabgld
   LET g_fabgdocno_t = g_fabg_m.fabgdocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="afat500.delete" >}
#+ 資料刪除
PRIVATE FUNCTION afat500_delete()
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
 
   OPEN afat500_cl USING g_enterprise,g_fabg_m.fabgld,g_fabg_m.fabgdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN afat500_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE afat500_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE afat500_master_referesh USING g_fabg_m.fabgld,g_fabg_m.fabgdocno INTO g_fabg_m.fabgsite,g_fabg_m.fabg001, 
       g_fabg_m.fabgld,g_fabg_m.fabg002,g_fabg_m.fabg003,g_fabg_m.fabg004,g_fabg_m.fabg005,g_fabg_m.fabgdocno, 
       g_fabg_m.fabgdocdt,g_fabg_m.fabg008,g_fabg_m.fabg009,g_fabg_m.fabgstus,g_fabg_m.fabgownid,g_fabg_m.fabgowndp, 
       g_fabg_m.fabgcrtid,g_fabg_m.fabgcrtdp,g_fabg_m.fabgcrtdt,g_fabg_m.fabgmodid,g_fabg_m.fabgmoddt, 
       g_fabg_m.fabgcnfid,g_fabg_m.fabgcnfdt,g_fabg_m.fabgpstid,g_fabg_m.fabgpstdt,g_fabg_m.fabgsite_desc, 
       g_fabg_m.fabg001_desc,g_fabg_m.fabgld_desc,g_fabg_m.fabg002_desc,g_fabg_m.fabg003_desc,g_fabg_m.fabgownid_desc, 
       g_fabg_m.fabgowndp_desc,g_fabg_m.fabgcrtid_desc,g_fabg_m.fabgcrtdp_desc,g_fabg_m.fabgmodid_desc, 
       g_fabg_m.fabgcnfid_desc,g_fabg_m.fabgpstid_desc
   
   
   #檢查是否允許此動作
   IF NOT afat500_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_fabg_m_mask_o.* =  g_fabg_m.*
   CALL afat500_fabg_t_mask()
   LET g_fabg_m_mask_n.* =  g_fabg_m.*
   
   CALL afat500_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   #151231-00005#3--add--str--lujh
   IF NOT cl_null(g_fabg_m.fabgdocdt) THEN 
      IF NOT s_afa_date_chk(g_fabg_m.fabgld,'',g_fabg_m.fabgdocdt) THEN 
         CLOSE afat500_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF 
   END IF 
   #151231-00005#3--add--end--lujh
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL afat500_set_pk_array()
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
      IF NOT s_aooi200_fin_del_docno(g_fabg_m.fabgld,g_fabg_m.fabgdocno,g_fabg_m.fabgdocdt) THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM fabs_t
       WHERE fabsent = g_enterprise AND fabsld = g_fabg_m.fabgld
         AND fabsdocno = g_fabg_m.fabgdocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "fabs_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      #20150210 add by chenying
      IF g_glaa.glaa121 = 'Y' THEN
         IF g_fabg_m.fabg005 = '22' THEN
            CALL s_pre_voucher_del('FA','F10',g_fabg_m.fabgld,g_fabg_m.fabgdocno) RETURNING l_success
         ELSE
            CALL s_pre_voucher_del('FA','F20',g_fabg_m.fabgld,g_fabg_m.fabgdocno) RETURNING l_success
         END IF
         IF l_success = FALSE THEN 
            CALL s_transaction_end('N','0')
            RETURN
         END IF
      END IF
      #20150210 add by chenying
      #end add-point
      
            
                                                               
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_fabg_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE afat500_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_fabs_d.clear() 
      CALL g_fabs2_d.clear()       
      CALL g_fabs3_d.clear()       
 
     
      CALL afat500_ui_browser_refresh()  
      #CALL afat500_ui_headershow()  
      #CALL afat500_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
      
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL afat500_browser_fill("")
         CALL afat500_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE afat500_cl
 
   #功能已完成,通報訊息中心
   CALL afat500_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="afat500.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION afat500_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_fabs_d.clear()
   CALL g_fabs2_d.clear()
   CALL g_fabs3_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF afat500_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT fabsseq,fabs002,fabs003,fabs004,fabs005,fabs006,fabs009,fabs010, 
             fabs011,fabs012,fabs100,fabs101,fabs102,fabs150,fabs151,fabs152,fabsseq,fabs007,fabs008, 
             fabs014,fabs015,fabs016,fabs017,fabs018,fabs019,fabs020,fabs022,fabs024,fabs025,fabsseq, 
             fabs100,fabs101,fabs102,fabs150,fabs151,fabs152  FROM fabs_t",   
                     " INNER JOIN fabg_t ON fabgent = " ||g_enterprise|| " AND fabgld = fabsld ",
                     " AND fabgdocno = fabsdocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                     
                     " WHERE fabsent=? AND fabsld=? AND fabsdocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY fabs_t.fabsseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE afat500_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR afat500_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_fabg_m.fabgld,g_fabg_m.fabgdocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_fabg_m.fabgld,g_fabg_m.fabgdocno INTO g_fabs_d[l_ac].fabsseq, 
          g_fabs_d[l_ac].fabs002,g_fabs_d[l_ac].fabs003,g_fabs_d[l_ac].fabs004,g_fabs_d[l_ac].fabs005, 
          g_fabs_d[l_ac].fabs006,g_fabs_d[l_ac].fabs009,g_fabs_d[l_ac].fabs010,g_fabs_d[l_ac].fabs011, 
          g_fabs_d[l_ac].fabs012,g_fabs_d[l_ac].fabs100,g_fabs_d[l_ac].fabs101,g_fabs_d[l_ac].fabs102, 
          g_fabs_d[l_ac].fabs150,g_fabs_d[l_ac].fabs151,g_fabs_d[l_ac].fabs152,g_fabs2_d[l_ac].fabsseq, 
          g_fabs2_d[l_ac].fabs007,g_fabs2_d[l_ac].fabs008,g_fabs2_d[l_ac].fabs014,g_fabs2_d[l_ac].fabs015, 
          g_fabs2_d[l_ac].fabs016,g_fabs2_d[l_ac].fabs017,g_fabs2_d[l_ac].fabs018,g_fabs2_d[l_ac].fabs019, 
          g_fabs2_d[l_ac].fabs020,g_fabs2_d[l_ac].fabs022,g_fabs2_d[l_ac].fabs024,g_fabs2_d[l_ac].fabs025, 
          g_fabs3_d[l_ac].fabsseq,g_fabs3_d[l_ac].fabs100,g_fabs3_d[l_ac].fabs101,g_fabs3_d[l_ac].fabs102, 
          g_fabs3_d[l_ac].fabs150,g_fabs3_d[l_ac].fabs151,g_fabs3_d[l_ac].fabs152   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill.fill"
         #160426-00014#23--add--s--
         CALL afat500_fabn_get()
         #160426-00014#23--add--e--
         DISPLAY g_fabs3_d[l_ac].fabsseq TO s_detail3[l_ac].fabsseq_3
         DISPLAY g_fabs3_d[l_ac].fabs100 TO s_detail3[l_ac].fabs100_3
         DISPLAY g_fabs3_d[l_ac].fabs101 TO s_detail3[l_ac].fabs101_3
         DISPLAY g_fabs3_d[l_ac].fabs102 TO s_detail3[l_ac].fabs102_3 
         DISPLAY g_fabs3_d[l_ac].fabs150 TO s_detail3[l_ac].fabs150_3
         DISPLAY g_fabs3_d[l_ac].fabs151 TO s_detail3[l_ac].fabs151_3
         DISPLAY g_fabs3_d[l_ac].fabs152 TO s_detail3[l_ac].fabs152_3 
         CALL afat500_fabn017_desc()
         CALL afat500_fabs007_desc()
         CALL afat500_fabs008_desc()
         CALL afat500_fabs014_desc()
         CALL afat500_fabs015_desc(g_fabs2_d[l_ac].fabs015) RETURNING g_fabs2_d[l_ac].fabs015_desc
         CALL afat500_fabs016_desc(g_fabs2_d[l_ac].fabs016) RETURNING g_fabs2_d[l_ac].fabs016_desc
         CALL afat500_fabs017_desc('287',g_fabs2_d[l_ac].fabs017) RETURNING g_fabs2_d[l_ac].fabs017_desc
         CALL afat500_fabs018_desc(g_fabs2_d[l_ac].fabs018) RETURNING g_fabs2_d[l_ac].fabs018_desc 
         CALL afat500_fabs019_desc(g_fabs2_d[l_ac].fabs019) RETURNING g_fabs2_d[l_ac].fabs019_desc
         CALL afat500_fabs017_desc('281',g_fabs2_d[l_ac].fabs020) RETURNING g_fabs2_d[l_ac].fabs020_desc
         CALL afat500_fabs022_desc() 
         CALL afat500_fabs024_desc()
         CALL afat500_fabs025_desc()

        
        
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
   
   CALL g_fabs_d.deleteElement(g_fabs_d.getLength())
   CALL g_fabs2_d.deleteElement(g_fabs2_d.getLength())
   CALL g_fabs3_d.deleteElement(g_fabs3_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE afat500_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_fabs_d.getLength()
      LET g_fabs_d_mask_o[l_ac].* =  g_fabs_d[l_ac].*
      CALL afat500_fabs_t_mask()
      LET g_fabs_d_mask_n[l_ac].* =  g_fabs_d[l_ac].*
   END FOR
   
   LET g_fabs2_d_mask_o.* =  g_fabs2_d.*
   FOR l_ac = 1 TO g_fabs2_d.getLength()
      LET g_fabs2_d_mask_o[l_ac].* =  g_fabs2_d[l_ac].*
      CALL afat500_fabs_t_mask()
      LET g_fabs2_d_mask_n[l_ac].* =  g_fabs2_d[l_ac].*
   END FOR
   LET g_fabs3_d_mask_o.* =  g_fabs3_d.*
   FOR l_ac = 1 TO g_fabs3_d.getLength()
      LET g_fabs3_d_mask_o[l_ac].* =  g_fabs3_d[l_ac].*
      CALL afat500_fabs_t_mask()
      LET g_fabs3_d_mask_n[l_ac].* =  g_fabs3_d[l_ac].*
   END FOR
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="afat500.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION afat500_delete_b(ps_table,ps_keys_bak,ps_page)
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
   LET ls_group = "'1','2','3',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete"
      
      #end add-point    
      DELETE FROM fabs_t
       WHERE fabsent = g_enterprise AND
         fabsld = ps_keys_bak[1] AND fabsdocno = ps_keys_bak[2] AND fabsseq = ps_keys_bak[3]
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
         CALL g_fabs_d.deleteElement(li_idx) 
      END IF 
      IF ps_page <> "'2'" THEN 
         CALL g_fabs2_d.deleteElement(li_idx) 
      END IF 
      IF ps_page <> "'3'" THEN 
         CALL g_fabs3_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="afat500.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION afat500_insert_b(ps_table,ps_keys,ps_page)
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
   LET ls_group = "'1','2','3',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert"
      IF 1 = 0 THEN 
      #end add-point 
      INSERT INTO fabs_t
                  (fabsent,
                   fabsld,fabsdocno,
                   fabsseq
                   ,fabs002,fabs003,fabs004,fabs005,fabs006,fabs009,fabs010,fabs011,fabs012,fabs100,fabs101,fabs102,fabs150,fabs151,fabs152,fabs007,fabs008,fabs014,fabs015,fabs016,fabs017,fabs018,fabs019,fabs020,fabs022,fabs024,fabs025,fabs100,fabs101,fabs102,fabs150,fabs151,fabs152) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_fabs_d[g_detail_idx].fabs002,g_fabs_d[g_detail_idx].fabs003,g_fabs_d[g_detail_idx].fabs004, 
                       g_fabs_d[g_detail_idx].fabs005,g_fabs_d[g_detail_idx].fabs006,g_fabs_d[g_detail_idx].fabs009, 
                       g_fabs_d[g_detail_idx].fabs010,g_fabs_d[g_detail_idx].fabs011,g_fabs_d[g_detail_idx].fabs012, 
                       g_fabs_d[g_detail_idx].fabs100,g_fabs_d[g_detail_idx].fabs101,g_fabs_d[g_detail_idx].fabs102, 
                       g_fabs_d[g_detail_idx].fabs150,g_fabs_d[g_detail_idx].fabs151,g_fabs_d[g_detail_idx].fabs152, 
                       g_fabs2_d[g_detail_idx].fabs007,g_fabs2_d[g_detail_idx].fabs008,g_fabs2_d[g_detail_idx].fabs014, 
                       g_fabs2_d[g_detail_idx].fabs015,g_fabs2_d[g_detail_idx].fabs016,g_fabs2_d[g_detail_idx].fabs017, 
                       g_fabs2_d[g_detail_idx].fabs018,g_fabs2_d[g_detail_idx].fabs019,g_fabs2_d[g_detail_idx].fabs020, 
                       g_fabs2_d[g_detail_idx].fabs022,g_fabs2_d[g_detail_idx].fabs024,g_fabs2_d[g_detail_idx].fabs025, 
                       g_fabs_d[g_detail_idx].fabs100,g_fabs_d[g_detail_idx].fabs101,g_fabs_d[g_detail_idx].fabs102, 
                       g_fabs_d[g_detail_idx].fabs150,g_fabs_d[g_detail_idx].fabs151,g_fabs_d[g_detail_idx].fabs152) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      ELSE
         INSERT INTO fabs_t
                  (fabsent,
                   fabsld,fabsdocno,
                   fabsseq
                   ,fabs002,fabs003,fabs004,fabs005,fabs006,fabs009,fabs010,fabs011,fabs012,fabs100,fabs101,fabs102,fabs150,fabs151,fabs152,
                    fabs007,fabs014,fabs015,fabs016,fabs017,fabs018,fabs019,fabs020,fabs022,fabs024,fabs025) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_fabs_d[g_detail_idx].fabs002,g_fabs_d[g_detail_idx].fabs003,g_fabs_d[g_detail_idx].fabs004, 
                       g_fabs_d[g_detail_idx].fabs005,g_fabs_d[g_detail_idx].fabs006,g_fabs_d[g_detail_idx].fabs009, 
                       g_fabs_d[g_detail_idx].fabs010,g_fabs_d[g_detail_idx].fabs011,g_fabs_d[g_detail_idx].fabs012, 
                       g_fabs_d[g_detail_idx].fabs100,g_fabs_d[g_detail_idx].fabs101,g_fabs_d[g_detail_idx].fabs102, 
                       g_fabs_d[g_detail_idx].fabs150,g_fabs_d[g_detail_idx].fabs151,g_fabs_d[g_detail_idx].fabs152, 
                       g_fabs2_d[g_detail_idx].fabs007,g_fabs2_d[g_detail_idx].fabs014,g_fabs2_d[g_detail_idx].fabs015, 
                       g_fabs2_d[g_detail_idx].fabs016,g_fabs2_d[g_detail_idx].fabs017,g_fabs2_d[g_detail_idx].fabs018, 
                       g_fabs2_d[g_detail_idx].fabs019,g_fabs2_d[g_detail_idx].fabs020,g_fabs2_d[g_detail_idx].fabs022, 
                       g_fabs2_d[g_detail_idx].fabs024,g_fabs2_d[g_detail_idx].fabs025)
      END IF
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "fabs_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_fabs_d.insertElement(li_idx) 
      END IF 
      IF ps_page <> "'2'" THEN 
         CALL g_fabs2_d.insertElement(li_idx) 
      END IF 
      IF ps_page <> "'3'" THEN 
         CALL g_fabs3_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="afat500.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION afat500_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   LET ls_group = "'1','2','3',"
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "fabs_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL afat500_fabs_t_mask_restore('restore_mask_o')
               
      UPDATE fabs_t 
         SET (fabsld,fabsdocno,
              fabsseq
              ,fabs002,fabs003,fabs004,fabs005,fabs006,fabs009,fabs010,fabs011,fabs012,fabs100,fabs101,fabs102,fabs150,fabs151,fabs152,fabs007,fabs008,fabs014,fabs015,fabs016,fabs017,fabs018,fabs019,fabs020,fabs022,fabs024,fabs025,fabs100,fabs101,fabs102,fabs150,fabs151,fabs152) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_fabs_d[g_detail_idx].fabs002,g_fabs_d[g_detail_idx].fabs003,g_fabs_d[g_detail_idx].fabs004, 
                  g_fabs_d[g_detail_idx].fabs005,g_fabs_d[g_detail_idx].fabs006,g_fabs_d[g_detail_idx].fabs009, 
                  g_fabs_d[g_detail_idx].fabs010,g_fabs_d[g_detail_idx].fabs011,g_fabs_d[g_detail_idx].fabs012, 
                  g_fabs_d[g_detail_idx].fabs100,g_fabs_d[g_detail_idx].fabs101,g_fabs_d[g_detail_idx].fabs102, 
                  g_fabs_d[g_detail_idx].fabs150,g_fabs_d[g_detail_idx].fabs151,g_fabs_d[g_detail_idx].fabs152, 
                  g_fabs2_d[g_detail_idx].fabs007,g_fabs2_d[g_detail_idx].fabs008,g_fabs2_d[g_detail_idx].fabs014, 
                  g_fabs2_d[g_detail_idx].fabs015,g_fabs2_d[g_detail_idx].fabs016,g_fabs2_d[g_detail_idx].fabs017, 
                  g_fabs2_d[g_detail_idx].fabs018,g_fabs2_d[g_detail_idx].fabs019,g_fabs2_d[g_detail_idx].fabs020, 
                  g_fabs2_d[g_detail_idx].fabs022,g_fabs2_d[g_detail_idx].fabs024,g_fabs2_d[g_detail_idx].fabs025, 
                  g_fabs_d[g_detail_idx].fabs100,g_fabs_d[g_detail_idx].fabs101,g_fabs_d[g_detail_idx].fabs102, 
                  g_fabs_d[g_detail_idx].fabs150,g_fabs_d[g_detail_idx].fabs151,g_fabs_d[g_detail_idx].fabs152)  
 
         WHERE fabsent = g_enterprise AND fabsld = ps_keys_bak[1] AND fabsdocno = ps_keys_bak[2] AND fabsseq = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "fabs_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "fabs_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL afat500_fabs_t_mask_restore('restore_mask_n')
               
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
 
{<section id="afat500.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION afat500_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="afat500.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION afat500_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="afat500.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION afat500_lock_b(ps_table,ps_page)
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
   #CALL afat500_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1','2','3',"
   #僅鎖定自身table
   LET ls_group = "fabs_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN afat500_bcl USING g_enterprise,
                                       g_fabg_m.fabgld,g_fabg_m.fabgdocno,g_fabs_d[g_detail_idx].fabsseq  
                                               
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "afat500_bcl:",SQLERRMESSAGE 
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
 
{<section id="afat500.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION afat500_unlock_b(ps_table,ps_page)
   #add-point:unlock_b段define(客製用) name="unlock_b.define_customerization"
   
   #end add-point  
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:unlock_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="unlock_b.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="unlock_b.pre_function"
   
   #end add-point
    
   LET ls_group = "'1','2','3',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE afat500_bcl
   END IF
   
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="afat500.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION afat500_set_entry(p_cmd)
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
      CALL cl_set_comp_entry("fabgdocdt",TRUE)  #151130-00015#2 
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="afat500.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION afat500_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   DEFINE l_dfin0033  LIKE type_t.chr1  #151130-00015#2
   DEFINE l_success   LIKE type_t.chr1  #151130-00015#2
   DEFINE l_slip      LIKE type_t.chr80 #151130-00015#2 
   DEFINE l_fabgcomp  LIKE type_t.chr80 #151130-00015#2 
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
   #151130-00015#2  -add -str
   IF NOT cl_null(g_fabg_m.fabgdocno) THEN  
      #获取单别
      CALL s_aooi200_fin_get_slip(g_fabg_m.fabgdocno) RETURNING l_success,l_slip
      #判断是否可以修改单据日期
      SELECT ooef017 INTO l_fabgcomp
        FROM ooef_t
       WHERE ooefent = g_enterprise
         AND ooef001 = g_fabg_m.fabgsite
         AND ooefstus = 'Y'
      CALL s_fin_get_doc_para(g_fabg_m.fabgld,l_fabgcomp,l_slip,'D-FIN-0033') RETURNING l_dfin0033
      IF l_dfin0033 = "Y"  THEN 
         CALL cl_set_comp_entry("fabgdocdt",TRUE)   
      END IF          
   END IF 
   #151130-00015#2  -end -str
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="afat500.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION afat500_set_entry_b(p_cmd)
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
 
{<section id="afat500.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION afat500_set_no_entry_b(p_cmd)
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
 
{<section id="afat500.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION afat500_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   IF g_fabg_m.fabgstus = 'Y' THEN
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   ELSE
      CALL cl_set_act_visible("modify,delete,modify_detail", TRUE)
   END IF    
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="afat500.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION afat500_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:1)
   IF g_fabg_m.fabgstus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF


   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="afat500.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION afat500_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="afat500.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION afat500_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="afat500.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION afat500_default_search()
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
      LET ls_wc = ls_wc, " fabgld = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " fabgdocno = '", g_argv[02], "' AND "
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
               WHEN la_wc[li_idx].tableid = "fabg_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "fabs_t" 
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
 
{<section id="afat500.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION afat500_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_n           LIKE type_t.num5
   DEFINE l_today       DATETIME YEAR TO SECOND
   DEFINE l_wc          STRING   
   #20150608--add--str--lujh
   DEFINE  l_gzzd005    LIKE gzzd_t.gzzd005
   DEFINE  l_colname    STRING
   DEFINE  l_comment    STRING
   #20150608--add--end--lujh
   #151125-00006#2-s
   DEFINE l_dfin0032    LIKE type_t.chr1
   DEFINE l_ooba002     LIKE ooba_t.ooba002
   DEFINE l_fabgcomp    LIKE fabg_t.fabgcomp
   DEFINE l_ld          LIKE fabg_t.fabgld
   #151125-00006#2-e
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
   
   OPEN afat500_cl USING g_enterprise,g_fabg_m.fabgld,g_fabg_m.fabgdocno
   IF STATUS THEN
      CLOSE afat500_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN afat500_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE afat500_master_referesh USING g_fabg_m.fabgld,g_fabg_m.fabgdocno INTO g_fabg_m.fabgsite,g_fabg_m.fabg001, 
       g_fabg_m.fabgld,g_fabg_m.fabg002,g_fabg_m.fabg003,g_fabg_m.fabg004,g_fabg_m.fabg005,g_fabg_m.fabgdocno, 
       g_fabg_m.fabgdocdt,g_fabg_m.fabg008,g_fabg_m.fabg009,g_fabg_m.fabgstus,g_fabg_m.fabgownid,g_fabg_m.fabgowndp, 
       g_fabg_m.fabgcrtid,g_fabg_m.fabgcrtdp,g_fabg_m.fabgcrtdt,g_fabg_m.fabgmodid,g_fabg_m.fabgmoddt, 
       g_fabg_m.fabgcnfid,g_fabg_m.fabgcnfdt,g_fabg_m.fabgpstid,g_fabg_m.fabgpstdt,g_fabg_m.fabgsite_desc, 
       g_fabg_m.fabg001_desc,g_fabg_m.fabgld_desc,g_fabg_m.fabg002_desc,g_fabg_m.fabg003_desc,g_fabg_m.fabgownid_desc, 
       g_fabg_m.fabgowndp_desc,g_fabg_m.fabgcrtid_desc,g_fabg_m.fabgcrtdp_desc,g_fabg_m.fabgmodid_desc, 
       g_fabg_m.fabgcnfid_desc,g_fabg_m.fabgpstid_desc
   
 
   #檢查是否允許此動作
   IF NOT afat500_action_chk() THEN
      CLOSE afat500_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_fabg_m.fabgsite,g_fabg_m.fabgsite_desc,g_fabg_m.fabg001,g_fabg_m.fabg001_desc,g_fabg_m.fabgld, 
       g_fabg_m.fabgld_desc,g_fabg_m.fabg002,g_fabg_m.fabg002_desc,g_fabg_m.fabg003,g_fabg_m.fabg003_desc, 
       g_fabg_m.fabg004,g_fabg_m.fabg005,g_fabg_m.fabgdocno,g_fabg_m.fabgdocdt,g_fabg_m.fabg008,g_fabg_m.fabg009, 
       g_fabg_m.fabgstus,g_fabg_m.fabgownid,g_fabg_m.fabgownid_desc,g_fabg_m.fabgowndp,g_fabg_m.fabgowndp_desc, 
       g_fabg_m.fabgcrtid,g_fabg_m.fabgcrtid_desc,g_fabg_m.fabgcrtdp,g_fabg_m.fabgcrtdp_desc,g_fabg_m.fabgcrtdt, 
       g_fabg_m.fabgmodid,g_fabg_m.fabgmodid_desc,g_fabg_m.fabgmoddt,g_fabg_m.fabgcnfid,g_fabg_m.fabgcnfid_desc, 
       g_fabg_m.fabgcnfdt,g_fabg_m.fabgpstid,g_fabg_m.fabgpstid_desc,g_fabg_m.fabgpstdt
 
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
   #151231-00005#3--add--str--lujh
   IF NOT cl_null(g_fabg_m.fabgdocdt) THEN 
      IF NOT s_afa_date_chk(g_fabg_m.fabgld,'',g_fabg_m.fabgdocdt) THEN 
         CLOSE afat500_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF 
   END IF 
   #151231-00005#3--add--end--lujh
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
      #20141218 add by chenying
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
      CALL cl_set_act_visible("confirmed,unconfirmed,posted,unposted,invalid,unhold,hold",FALSE)

      CASE g_fabg_m.fabgstus
         WHEN "N"   #未確認
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            CALL cl_set_act_visible("invalid,confirmed",TRUE)
            IF cl_bpm_chk() THEN
               CALL cl_set_act_visible("signing",TRUE)
               CALL cl_set_act_visible("confirmed",FALSE)
            END IF

         WHEN "X"   #作廢
            CALL s_transaction_end('N','0')     #160812-00017#7 Add By Ken 160822
            RETURN

         WHEN "Y"   #已確認
            CALL cl_set_act_visible("unconfirmed,posted,hold",TRUE)

         WHEN "S"   #已過帳
            CALL cl_set_act_visible("unposted",TRUE)

         WHEN "A"   #已核准
            CALL cl_set_act_visible("confirmed ",TRUE)

         WHEN "R"   #已拒絕
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            CALL cl_set_act_visible("invalid,confirmed",TRUE)

            IF cl_bpm_chk() THEN
               CALL cl_set_act_visible("signing",TRUE)
               CALL cl_set_act_visible("confirmed",FALSE)
            END IF

         WHEN "D"   #抽單
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            CALL cl_set_act_visible("invalid,confirmed",TRUE)

            IF cl_bpm_chk() THEN
               CALL cl_set_act_visible("signing",TRUE)
               CALL cl_set_act_visible("confirmed",FALSE)
            END IF

         WHEN "W"   #送簽中
            CALL cl_set_act_visible("withdraw",TRUE)

         WHEN "H"  #留置
            CALL cl_set_act_visible("unhold",TRUE)

#         WHEN "UH" #取消留置
#         WHEN "Z"  #扣帳還原
       WHEN "Z"  #扣帳還原
            CALL cl_set_act_visible("posted",TRUE)

      END CASE
#      HIDE OPTION "unposted"  #20141218 add by chenying #mark 151221
#      HIDE OPTION "posted"    #20141218 add by chenying #mark 151221
      #20141218 add by chenying
      
      LET l_success=TRUE
      CALL s_transaction_begin()
      CALL cl_err_collect_init()      
      #end add-point
      
      #應用 a36 樣板自動產生(Version:5)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT afat500_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE afat500_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT afat500_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE afat500_cl
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
            IF NOT cl_null(g_fabg_m.fabg008) THEN 
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'anm-00187'
               LET g_errparam.extend = g_fabg_m.fabgstus
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET l_success = 'N'
            #20141214 add by chenying    
            ELSE
               #20150608--add--str--lujh
               CALL s_azzi902_get_gzzd('afap100',"lbl_faah001") RETURNING l_colname,l_comment  #卡片编号
               LET g_coll_title[1] = l_colname
               CALL s_azzi902_get_gzzd('afap100',"lbl_faah003") RETURNING l_colname,l_comment  #财产编号
               LET g_coll_title[2] = l_colname
               CALL s_azzi902_get_gzzd('afap100',"lbl_faah004") RETURNING l_colname,l_comment  #符号
               LET g_coll_title[3] = l_colname
               
               CALL s_afa_p_faan_chk(g_fabg_m.fabgld,g_fabg_m.fabgdocno,g_fabg_m.fabgdocdt,'fabs_t','fabs006','fabs004','fabs005') RETURNING l_success
               IF l_success = FALSE THEN 
                  CALL cl_err_collect_show()
                  CALL s_transaction_end('N','0')     #160812-00017#7 Add By Ken 160822
                  RETURN 
               END IF
               #20150608--add--end--lujh
            
               CALL s_afat503_unconf_chk_fabg(g_fabg_m.fabgld,g_fabg_m.fabgdocno) RETURNING l_success         
            #20141214 add by chenying 
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
#         IF g_fabg_m.fabgstus = 'X' THEN 
#            INITIALIZE g_errparam TO NULL
#            LET g_errparam.code = 'anm-00133'
#            LET g_errparam.extend = g_fabg_m.fabgstus
#            LET g_errparam.popup = TRUE
#            CALL cl_err()
#
#            RETURN 
#      
#         END IF
         
         #20150608--add--str--lujh
         CALL s_azzi902_get_gzzd('afap100',"lbl_faah001") RETURNING l_colname,l_comment  #卡片编号
         LET g_coll_title[1] = l_colname
         CALL s_azzi902_get_gzzd('afap100',"lbl_faah003") RETURNING l_colname,l_comment  #财产编号
         LET g_coll_title[2] = l_colname
         CALL s_azzi902_get_gzzd('afap100',"lbl_faah004") RETURNING l_colname,l_comment  #符号
         LET g_coll_title[3] = l_colname
         
         CALL s_afa_p_faan_chk(g_fabg_m.fabgld,g_fabg_m.fabgdocno,g_fabg_m.fabgdocdt,'fabs_t','fabs006','fabs004','fabs005') RETURNING l_success
         IF l_success = FALSE THEN 
            CALL cl_err_collect_show()
            CALL s_transaction_end('N','0')     #160812-00017#7 Add By Ken 160822
            RETURN 
         END IF
         #20150608--add--end--lujh
          
         #20141214 add by chenying
         CALL s_afat503_conf_chk_fabs (g_fabg_m.fabgld,g_fabg_m.fabgdocno) RETURNING l_success 
         #20141214 add by chenying   
         
#         SELECT COUNT(*) INTO l_n
#           FROM fabs_t
#          WHERE fabsent = g_enterprise
#            AND fabsld = g_fabg_m.fabgld
#            AND fabsdocno = g_fabg_m.fabgdocno
#            
#         IF l_n = 0 THEN 
#            INITIALIZE g_errparam TO NULL
#            LET g_errparam.code = 'agl-00065'
#            LET g_errparam.extend = ''
#            LET g_errparam.popup = TRUE
#            CALL cl_err()
#
#            RETURN 
#         END IF
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
      ON ACTION posted
         IF cl_auth_chk_act("posted") THEN
            LET lc_state = "S"
            #add-point:action控制 name="statechange.posted"
            
            #end add-point
         END IF
         EXIT MENU
      ON ACTION invalid
         IF cl_auth_chk_act("invalid") THEN
            LET lc_state = "X"
            #add-point:action控制 name="statechange.invalid"
            IF g_fabg_m.fabgstus = 'Y' THEN 
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'anm-00134'
               LET g_errparam.extend = g_fabg_m.fabgstus
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET l_success = FALSE
#               RETURN 
            END IF
            
            #20150608--add--str--lujh
            CALL s_azzi902_get_gzzd('afap100',"lbl_faah001") RETURNING l_colname,l_comment  #卡片编号
            LET g_coll_title[1] = l_colname
            CALL s_azzi902_get_gzzd('afap100',"lbl_faah003") RETURNING l_colname,l_comment  #财产编号
            LET g_coll_title[2] = l_colname
            CALL s_azzi902_get_gzzd('afap100',"lbl_faah004") RETURNING l_colname,l_comment  #符号
            LET g_coll_title[3] = l_colname
            
            CALL s_afa_p_faan_chk(g_fabg_m.fabgld,g_fabg_m.fabgdocno,g_fabg_m.fabgdocdt,'fabs_t','fabs006','fabs004','fabs005') RETURNING l_success
            IF l_success = FALSE THEN 
               CALL cl_err_collect_show()
               CALL s_transaction_end('N','0')     #160812-00017#7 Add By Ken 160822
               RETURN 
            END IF
            #20150608--add--end--lujh
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
      CLOSE afat500_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   #20150210 add by chenying
   IF l_success = TRUE THEN   
      IF g_glaa.glaa121 = 'Y' THEN 
         LET l_wc = "glgadocno = '",g_fabg_m.fabgdocno,"'"
         IF g_fabg_m.fabg005 = '22' THEN
            CALL s_pre_voucher_upd('FA','F10',g_fabg_m.fabgld,lc_state,'','',l_wc) RETURNING l_success
         ELSE
            CALL s_pre_voucher_upd('FA','F20',g_fabg_m.fabgld,lc_state,'','',l_wc) RETURNING l_success
         END IF
      END IF
   END IF   
   #20150210 add by chenying 
   
   IF l_success = FALSE  THEN
      CALL cl_err_collect_show()
      CALL s_transaction_end('N','0') 
      RETURN    
   ELSE
      #151125-00001#1 add start ------------------
      IF lc_state = 'X' THEN
         IF NOT cl_ask_confirm('aim-00109') THEN
            CALL s_transaction_end('N','0')     #160812-00017#7 Add By Ken 160822
            RETURN
         END IF
      END IF
      #151125-00001#1 add end   ------------------
      CALL cl_err_collect_init()
      CALL cl_err_collect_show() 
      CALL s_transaction_end('Y','0')    
   END IF 
   
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
      EXECUTE afat500_master_referesh USING g_fabg_m.fabgld,g_fabg_m.fabgdocno INTO g_fabg_m.fabgsite, 
          g_fabg_m.fabg001,g_fabg_m.fabgld,g_fabg_m.fabg002,g_fabg_m.fabg003,g_fabg_m.fabg004,g_fabg_m.fabg005, 
          g_fabg_m.fabgdocno,g_fabg_m.fabgdocdt,g_fabg_m.fabg008,g_fabg_m.fabg009,g_fabg_m.fabgstus, 
          g_fabg_m.fabgownid,g_fabg_m.fabgowndp,g_fabg_m.fabgcrtid,g_fabg_m.fabgcrtdp,g_fabg_m.fabgcrtdt, 
          g_fabg_m.fabgmodid,g_fabg_m.fabgmoddt,g_fabg_m.fabgcnfid,g_fabg_m.fabgcnfdt,g_fabg_m.fabgpstid, 
          g_fabg_m.fabgpstdt,g_fabg_m.fabgsite_desc,g_fabg_m.fabg001_desc,g_fabg_m.fabgld_desc,g_fabg_m.fabg002_desc, 
          g_fabg_m.fabg003_desc,g_fabg_m.fabgownid_desc,g_fabg_m.fabgowndp_desc,g_fabg_m.fabgcrtid_desc, 
          g_fabg_m.fabgcrtdp_desc,g_fabg_m.fabgmodid_desc,g_fabg_m.fabgcnfid_desc,g_fabg_m.fabgpstid_desc 
 
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_fabg_m.fabgsite,g_fabg_m.fabgsite_desc,g_fabg_m.fabg001,g_fabg_m.fabg001_desc, 
          g_fabg_m.fabgld,g_fabg_m.fabgld_desc,g_fabg_m.fabg002,g_fabg_m.fabg002_desc,g_fabg_m.fabg003, 
          g_fabg_m.fabg003_desc,g_fabg_m.fabg004,g_fabg_m.fabg005,g_fabg_m.fabgdocno,g_fabg_m.fabgdocdt, 
          g_fabg_m.fabg008,g_fabg_m.fabg009,g_fabg_m.fabgstus,g_fabg_m.fabgownid,g_fabg_m.fabgownid_desc, 
          g_fabg_m.fabgowndp,g_fabg_m.fabgowndp_desc,g_fabg_m.fabgcrtid,g_fabg_m.fabgcrtid_desc,g_fabg_m.fabgcrtdp, 
          g_fabg_m.fabgcrtdp_desc,g_fabg_m.fabgcrtdt,g_fabg_m.fabgmodid,g_fabg_m.fabgmodid_desc,g_fabg_m.fabgmoddt, 
          g_fabg_m.fabgcnfid,g_fabg_m.fabgcnfid_desc,g_fabg_m.fabgcnfdt,g_fabg_m.fabgpstid,g_fabg_m.fabgpstid_desc, 
          g_fabg_m.fabgpstdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   LET g_success = 'Y'
   IF lc_state = 'Y' THEN 
      LET l_today  = cl_get_current() 
      UPDATE fabg_t SET fabgcnfid = g_user,
                        fabgcnfdt = l_today
       WHERE fabgent = g_enterprise 
         AND fabgld =  g_fabg_m.fabgld
         AND fabgdocno = g_fabg_m.fabgdocno
         
      IF g_success = 'Y' THEN
         LET g_fabg_m.fabgcnfid=g_user
         LET g_fabg_m.fabgcnfdt=l_today
         CALL s_transaction_end('Y','1')
         
      END IF
      IF g_success = 'N' THEN
         LET g_fabg_m.fabgcnfid=''
         LET g_fabg_m.fabgcnfdt=''
         CALL s_transaction_end('N','1')
      END IF
   ELSE
      UPDATE fabg_t SET fabgcnfid = '',
                        fabgcnfdt = ''
       WHERE fabgent = g_enterprise 
         AND fabgld =  g_fabg_m.fabgld
         AND fabgdocno = g_fabg_m.fabgdocno

      IF g_success = 'Y' THEN
         LET g_fabg_m.fabgcnfid=''
         LET g_fabg_m.fabgcnfdt=''
         CALL s_transaction_end('Y','1')
      END IF
      IF g_success = 'N' THEN
         CALL s_transaction_end('N','1')
      END IF
   END IF
   DISPLAY BY NAME  g_fabg_m.fabgcnfid, g_fabg_m.fabgcnfdt
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   #151125-00006#2-add-s
   IF g_fabg_m.fabgstus = 'S' THEN 
      CALL s_aooi200_fin_get_slip(g_fabg_m.fabgdocno) RETURNING l_success,l_ooba002
      CALL s_fin_orga_get_comp_ld(g_fabg_m.fabgsite) RETURNING g_sub_success,g_errno,l_fabgcomp,l_ld
      CALL s_fin_get_doc_para(g_fabg_m.fabgld,l_fabgcomp,l_ooba002,'D-FIN-0032') RETURNING l_dfin0032
      IF NOT cl_null(l_dfin0032) AND l_dfin0032 MATCHES '[Yy]' THEN 
         IF cl_ask_confirm('axr-00888') THEN              
            CALL s_afat503_fabg_immediately_gen(g_fabg_m.fabgld,g_fabg_m.fabgdocno,g_fabg_m.fabgstus,g_fabg_m.fabg005,g_fabg_m.fabg008)
            CALL afat500_ui_headershow()
         END IF 
      END IF 
   END IF
   #151125-00006#2-add-e
   #end add-point  
 
   CLOSE afat500_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL afat500_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="afat500.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION afat500_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_fabs_d.getLength() THEN
         LET g_detail_idx = g_fabs_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_fabs_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_fabs_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_fabs2_d.getLength() THEN
         LET g_detail_idx = g_fabs2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_fabs2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_fabs2_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 3 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx > g_fabs3_d.getLength() THEN
         LET g_detail_idx = g_fabs3_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_fabs3_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_fabs3_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="afat500.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION afat500_b_fill2(pi_idx)
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
   
   CALL afat500_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="afat500.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION afat500_fill_chk(ps_idx)
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
 
{<section id="afat500.status_show" >}
PRIVATE FUNCTION afat500_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="afat500.mask_functions" >}
&include "erp/afa/afat500_mask.4gl"
 
{</section>}
 
{<section id="afat500.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION afat500_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
 
 
   CALL afat500_show()
   CALL afat500_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_fabg_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_fabs_d))
   CALL cl_bpm_set_detail_data("s_detail2", util.JSONArray.fromFGL(g_fabs2_d))
   CALL cl_bpm_set_detail_data("s_detail3", util.JSONArray.fromFGL(g_fabs3_d))
 
 
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
   #CALL afat500_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL afat500_ui_headershow()
   CALL afat500_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION afat500_draw_out()
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
   CALL afat500_ui_headershow()  
   CALL afat500_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="afat500.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION afat500_set_pk_array()
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
 
{<section id="afat500.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="afat500.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION afat500_msgcentre_notify(lc_state)
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
   CALL afat500_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_fabg_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="afat500.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION afat500_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#9  2016/08/25  By 07900 --add---s--
   SELECT fabgstus  INTO g_fabg_m.fabgstus
     FROM fabg_t
    WHERE fabgent = g_enterprise
      AND fabgdocno = g_fabg_m.fabgdocno
      AND fabgld  = g_fabg_m.fabgld

   IF (g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail")  THEN
      LET g_errno = NULL
      CASE g_fabg_m.fabgstus       
        WHEN 'Z'
           LET g_errno = 'sub-01351'
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
        LET g_errparam.extend = g_fabg_m.fabgdocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL afat500_set_act_visible()
        CALL afat500_set_act_no_visible()
        CALL afat500_show()
        RETURN FALSE
     END IF
   END IF
   #160818-00017#9  2016/08/25  By 07900 --add---e--
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="afat500.other_function" readonly="Y" >}
# 資產中心名稱
PRIVATE FUNCTION afat500_fabgsite_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_fabg_m.fabgsite
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_fabg_m.fabgsite_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_fabg_m.fabgsite_desc
END FUNCTION
# 帳務人員名稱
PRIVATE FUNCTION afat500_fabg001_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_fabg_m.fabg001
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_fabg_m.fabg001_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_fabg_m.fabg001_desc
END FUNCTION
# 帳套名稱
PRIVATE FUNCTION afat500_fabgld_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_fabg_m.fabgld
   CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_fabg_m.fabgld_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_fabg_m.fabgld_desc
END FUNCTION
# 申請人員名稱
PRIVATE FUNCTION afat500_fabg002_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_fabg_m.fabg002
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_fabg_m.fabg002_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_fabg_m.fabg002_desc
END FUNCTION
# 申請部門名稱
PRIVATE FUNCTION afat500_fabg003_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_fabg_m.fabg003
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_fabg_m.fabg003_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_fabg_m.fabg003_desc
END FUNCTION
# 本位幣二三欄位顯示
PRIVATE FUNCTION afat500_glaa_visible()
   SELECT glaa001,glaa004,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,glaa025 
     INTO g_glaa001,g_glaa004,g_glaa015,g_glaa016,g_glaa017,g_glaa018,
          g_glaa019,g_glaa020,g_glaa021,g_glaa022,g_glaa025       
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald = g_fabg_m.fabgld
      
   CALL cl_set_comp_visible("lbl_page3",TRUE)   
   
   IF g_glaa015 = 'N' AND g_glaa019 = 'N' THEN 
      CALL cl_set_comp_visible("lbl_page3",FALSE)   
   END IF
      
   #本位幣二   
   IF g_glaa015 = 'Y' THEN
      CALL cl_set_comp_visible("fabs100_3,fabs101_3,fabs102_3",TRUE)
   ELSE
      CALL cl_set_comp_visible("fabs100_3,fabs101_3,fabs102_3",FALSE)   
   END IF
   #本位幣三
   IF g_glaa019 = 'Y' THEN 
      CALL cl_set_comp_visible("fabs150_3,fabs151_3,fabs152_3",TRUE)
   ELSE
      CALL cl_set_comp_visible("fabs150_3,fabs151_3,fabs152_3",FALSE)   
   END IF
END FUNCTION
# 獲取fabn資料
PRIVATE FUNCTION afat500_fabn_get()
   IF g_fabg_m.fabg005 = '22' THEN 
     SELECT fabn001,fabn002,fabn003,fabn007,fabn009,fabn008,fabn010
       INTO g_fabs_d[l_ac].fabs004,g_fabs_d[l_ac].fabs005,g_fabs_d[l_ac].fabs006,
            g_fabs_d[l_ac].fabs009,g_fabs_d[l_ac].fabs011,g_fabs_d[l_ac].fabs010,g_fabs_d[l_ac].fabs012
       FROM fabn_t
      WHERE fabnent = g_enterprise
        AND fabndocno = g_fabs_d[l_ac].fabs002
        AND fabnseq = g_fabs_d[l_ac].fabs003
     #160426-00014#23--add--s--
     #根据 卡片编号、财产编号、附号 带出 名称、规格型号
     SELECT faah012,faah013  
       INTO g_fabs_d[l_ac].faah012,g_fabs_d[l_ac].faah013
       FROM faah_t
      WHERE faahent = g_enterprise  
        AND faah003 = g_fabs_d[l_ac].fabs004
        AND faah004 = g_fabs_d[l_ac].fabs005
        AND faah001 = g_fabs_d[l_ac].fabs006
     #160426-00014#23--add--e--
   ################################add by huangtao
   ELSE
      SELECT fabj001,fabj002,fabj003,fabj010,fabj012,fabj011,fabj013
        INTO g_fabs_d[l_ac].fabs004,g_fabs_d[l_ac].fabs005,g_fabs_d[l_ac].fabs006,
            g_fabs_d[l_ac].fabs009,g_fabs_d[l_ac].fabs011,g_fabs_d[l_ac].fabs010,g_fabs_d[l_ac].fabs012
        FROM fabj_t
       WHERE fabjent = g_enterprise AND fabjdocno = g_fabs_d[l_ac].fabs002 AND fabjseq = g_fabs_d[l_ac].fabs003
       #160426-00014#23--add--s--
      #根据 卡片编号、底稿编号、附号 带出 名称、规格型号
      SELECT faak012,faak013  
        INTO g_fabs_d[l_ac].faah012,g_fabs_d[l_ac].faah013
        FROM faak_t
       WHERE faakent = g_enterprise  
         AND faak003 = g_fabs_d[l_ac].fabs004
         AND faak004 = g_fabs_d[l_ac].fabs005
         AND faak001 = g_fabs_d[l_ac].fabs006
      #160426-00014#23--add--e--
   END IF
   ################################add by huangtao
   
   ##################################mark by huangtao   
  #IF NOT cl_null(g_glaa001) AND NOT cl_null(g_fabs_d[l_ac].fabs009) AND NOT cl_null(g_glaa025) THEN 
  #                          #匯率參照表;帳套;         日期;             來源幣別
  #   CALL s_aooi160_get_exrate('2',g_fabg_m.fabgld,g_fabg_m.fabgdocdt,g_glaa001,
  #                             #目的幣別;           交易金額; 匯類類型
  #                             g_fabs_d[l_ac].fabs009,0,g_glaa025)
  #   RETURNING g_fabs_d[l_ac].fabs010   
  #END IF   
  #LET g_fabs_d[l_ac].fabs012 = g_fabs_d[l_ac].fabs010 * g_fabs_d[l_ac].fabs011
   ####################################mark by huangtao
   
   CALL afat500_get_glaa()
   IF g_fabg_m.fabg005 = '26' THEN 
      SELECT glab005 INTO g_fabs2_d[l_ac].fabs007 FROM glab_t
                  WHERE glabent=g_enterprise AND glabld=g_fabg_m.fabgld AND glab001='90' AND glab002='20' AND glab003='9902_08'
   ELSE
      SELECT glab005 INTO g_fabs2_d[l_ac].fabs007 FROM glab_t
                  WHERE glabent=g_enterprise AND glabld=g_fabg_m.fabgld AND glab001='90' AND glab002='22' AND glab003='9902_14'
   END IF 
   DISPLAY g_fabs_d[l_ac].fabs004 TO s_detail1[l_ac].fabs004  
   DISPLAY g_fabs_d[l_ac].fabs005 TO s_detail1[l_ac].fabs005
   DISPLAY g_fabs_d[l_ac].fabs006 TO s_detail1[l_ac].fabs006
   DISPLAY g_fabs2_d[l_ac].fabs007 TO s_detail2[l_ac].fabs007
   DISPLAY g_fabs_d[l_ac].fabs009 TO s_detail1[l_ac].fabs009
   DISPLAY g_fabs_d[l_ac].fabs010 TO s_detail1[l_ac].fabs010
   DISPLAY g_fabs_d[l_ac].fabs011 TO s_detail1[l_ac].fabs011
END FUNCTION
# 原因,原因說明帶值
PRIVATE FUNCTION afat500_fabn017_desc()
   SELECT fabn017 INTO g_fabs_d[l_ac].fabn017
     FROM fabn_t
    WHERE fabnent = g_enterprise
      AND fabndocno = g_fabs_d[l_ac].fabs002
      AND fabnseq = g_fabs_d[l_ac].fabs003
      
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_fabs_d[l_ac].fabn017
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='3904' AND oocql002 = ? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_fabs_d[l_ac].fabn017_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_fabs_d[l_ac].fabn017_desc
END FUNCTION
# 計算本位幣二三的匯率金額
PRIVATE FUNCTION afat500_get_glaa()
   DEFINE l_ooam003      LIKE ooam_t.ooam003
   
   IF g_glaa015 = 'Y' THEN 
      LET g_fabs_d[l_ac].fabs100 = g_glaa016
   
      #來源幣別
      IF g_glaa017 = '1' THEN
         LET l_ooam003 = g_fabs_d[l_ac].fabs009    
      ELSE   #表示帳簿幣別 
         LET l_ooam003 = g_glaa001            #帳套使用幣別
      END IF
      
      IF NOT cl_null(l_ooam003) AND NOT cl_null(g_fabs_d[l_ac].fabs100) AND NOT cl_null(g_glaa018) THEN 
         
                                  #匯率參照表;帳套;           日期;         來源幣別
         CALL s_aooi160_get_exrate('2',g_fabg_m.fabgld,g_fabg_m.fabgdocdt,l_ooam003,
                                   #目的幣別;          交易金額; 匯類類型
                                   g_fabs_d[l_ac].fabs100,0,g_glaa018)
         RETURNING g_fabs_d[l_ac].fabs101
      END IF

      LET g_fabs_d[l_ac].fabs102 = g_fabs_d[l_ac].fabs101 * g_fabs_d[l_ac].fabs012
      
      DISPLAY g_fabs_d[l_ac].fabs100 TO s_detail1[l_ac].fabs100
      DISPLAY g_fabs_d[l_ac].fabs101 TO s_detail1[l_ac].fabs101
      DISPLAY g_fabs_d[l_ac].fabs102 TO s_detail1[l_ac].fabs102
   END IF
   
   IF g_glaa019 = 'Y' THEN 
      LET g_fabs_d[l_ac].fabs150 = g_glaa020
   
      #來源幣別
      IF g_glaa021 = '1' THEN
         LET l_ooam003 = g_fabs_d[l_ac].fabs009    
      ELSE   #表示帳簿幣別 
         LET l_ooam003 = g_glaa001            #帳套使用幣別
      END IF
      
      IF NOT cl_null(l_ooam003) AND NOT cl_null(g_fabs_d[l_ac].fabs150) AND NOT cl_null(g_glaa022) THEN 
                                  #匯率參照表;帳套;           日期;         來源幣別
         CALL s_aooi160_get_exrate('2',g_fabg_m.fabgld,g_fabg_m.fabgdocdt,l_ooam003,
                                   #目的幣別;          交易金額; 匯類類型
                                   g_fabs_d[l_ac].fabs150,0,g_glaa022)
         RETURNING g_fabs_d[l_ac].fabs151
      END IF

      LET g_fabs_d[l_ac].fabs152 = g_fabs_d[l_ac].fabs151 * g_fabs_d[l_ac].fabs012
      
      DISPLAY g_fabs_d[l_ac].fabs150 TO s_detail1[l_ac].fabs150
      DISPLAY g_fabs_d[l_ac].fabs151 TO s_detail1[l_ac].fabs151
      DISPLAY g_fabs_d[l_ac].fabs152 TO s_detail1[l_ac].fabs152
   END IF
END FUNCTION
# 科目名稱
PRIVATE FUNCTION afat500_fabs007_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_glaa004
   LET g_ref_fields[2] = g_fabs2_d[l_ac].fabs007
   CALL ap_ref_array2(g_ref_fields,"SELECT glacl004 FROM glacl_t WHERE glaclent='"||g_enterprise||"' AND glacl001=? AND glacl002=? AND glacl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_fabs2_d[l_ac].fabs007_desc = '', g_rtn_fields[1] , ''
   DISPLAY g_fabs2_d[l_ac].fabs007_desc TO fabs007_desc
END FUNCTION
# 營運據點名稱
PRIVATE FUNCTION afat500_fabs014_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_fabs2_d[l_ac].fabs014
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_fabs2_d[l_ac].fabs014_desc = '', g_rtn_fields[1] , ''
   LET g_fabs2_d[l_ac].fabs014_desc = g_fabs2_d[l_ac].fabs014 CLIPPED,g_fabs2_d[l_ac].fabs014_desc
   DISPLAY g_fabs2_d[l_ac].fabs014_desc TO s_detail2[l_ac].fabs014_desc
END FUNCTION
# 部門名稱
PRIVATE FUNCTION afat500_fabs015_desc(p_ooea001)
   DEFINE p_ooea001  LIKE ooea_t.ooea001
   DEFINE r_ooefl003 LIKE ooefl_t.ooefl003
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_ooea001
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_ooefl003 = g_rtn_fields[1] 
   LET r_ooefl003 = g_fabs2_d[l_ac].fabs015 CLIPPED,r_ooefl003
   RETURN r_ooefl003
END FUNCTION
# 利潤/成本中心名稱
PRIVATE FUNCTION afat500_fabs016_desc(p_ooea001)
   DEFINE p_ooea001  LIKE ooea_t.ooea001
   DEFINE r_ooefl003 LIKE ooefl_t.ooefl003
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_ooea001
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_ooefl003 = g_rtn_fields[1] 
   LET r_ooefl003 = g_fabs2_d[l_ac].fabs016 CLIPPED,r_ooefl003
   RETURN r_ooefl003
END FUNCTION
# 區域名稱
PRIVATE FUNCTION afat500_fabs017_desc(p_oocq001,p_oocq002)
   DEFINE p_oocq001  LIKE oocq_t.oocq001
   DEFINE p_oocq002  LIKE oocq_t.oocq002
   DEFINE r_oocql004 LIKE oocql_t.oocql004 
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_oocq001
   LET g_ref_fields[2] = p_oocq002
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=? AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_oocql004 = '', g_rtn_fields[1] , ''
   IF p_oocq001 = '287' THEN 
      LET r_oocql004 = g_fabs2_d[l_ac].fabs017 CLIPPED,r_oocql004
   END IF
   IF p_oocq001 = '281' THEN 
      LET r_oocql004 = g_fabs2_d[l_ac].fabs020 CLIPPED,r_oocql004
   END IF
   RETURN r_oocql004
END FUNCTION
# 交易客商名稱
PRIVATE FUNCTION afat500_fabs018_desc(p_pmaa001)
   DEFINE p_pmaa001  LIKE pmaa_t.pmaa001
   DEFINE r_pmaal004 LIKE pmaal_t.pmaal004    
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_pmaa001
   CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_pmaal004 = '', g_rtn_fields[1] , '' 
   LET r_pmaal004 = g_fabs2_d[l_ac].fabs018 CLIPPED,r_pmaal004
   RETURN r_pmaal004
END FUNCTION
# 帳款客商名稱
PRIVATE FUNCTION afat500_fabs019_desc(p_pmaa001)
   DEFINE p_pmaa001  LIKE pmaa_t.pmaa001
   DEFINE r_pmaal004 LIKE pmaal_t.pmaal004    
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_pmaa001
   CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_pmaal004 = '', g_rtn_fields[1] , '' 
   LET r_pmaal004 = g_fabs2_d[l_ac].fabs019 CLIPPED,r_pmaal004
   RETURN r_pmaal004
END FUNCTION
# 人員名稱
PRIVATE FUNCTION afat500_fabs022_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_fabs2_d[l_ac].fabs022
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_fabs2_d[l_ac].fabs022_desc = '', g_rtn_fields[1] , ''
   LET g_fabs2_d[l_ac].fabs022_desc = g_fabs2_d[l_ac].fabs022 CLIPPED ,g_fabs2_d[l_ac].fabs022_desc
   DISPLAY g_fabs2_d[l_ac].fabs022_desc TO s_detail2[l_ac].fabs022_desc
END FUNCTION
# 專案編號名稱
PRIVATE FUNCTION afat500_fabs024_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_fabs2_d[l_ac].fabs024
   CALL ap_ref_array2(g_ref_fields,"SELECT pjbal003 FROM pjbal_t WHERE pjbalent='"||g_enterprise||"' AND pjbal001=? AND pjbal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_fabs2_d[l_ac].fabs024_desc = '', g_rtn_fields[1] , ''
   LET g_fabs2_d[l_ac].fabs024_desc = g_fabs2_d[l_ac].fabs024 CLIPPED ,g_fabs2_d[l_ac].fabs024_desc
   DISPLAY g_fabs2_d[l_ac].fabs024_desc TO s_detail2[l_ac].fabs024_desc
END FUNCTION
# WBS名稱
PRIVATE FUNCTION afat500_fabs025_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_fabs2_d[l_ac].fabs024
   LET g_ref_fields[2] = g_fabs2_d[l_ac].fabs025
   CALL ap_ref_array2(g_ref_fields,"SELECT pjbbl004 FROM pjbbl_t WHERE pjbblent='"||g_enterprise||"' AND pjbbl001=? AND pjbbl002=? AND pjbbl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_fabs2_d[l_ac].fabs025_desc = '', g_rtn_fields[1] , ''
   LET g_fabs2_d[l_ac].fabs025_desc = g_fabs2_d[l_ac].fabs025 CLIPPED ,g_fabs2_d[l_ac].fabs025_desc
   DISPLAY g_fabs2_d[l_ac].fabs025_desc TO s_detail2[l_ac].fabs025_desc
END FUNCTION

################################################################################

################################################################################
PRIVATE FUNCTION afat500_change_to_sql(p_wc)
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
PUBLIC FUNCTION afat500_fabs008_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_glaa004
   LET g_ref_fields[2] = g_fabs2_d[l_ac].fabs008
   CALL ap_ref_array2(g_ref_fields,"SELECT glacl004 FROM glacl_t WHERE glaclent='"||g_enterprise||"' AND glacl001=? AND glacl002=? AND glacl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_fabs2_d[l_ac].fabs008_desc = '', g_rtn_fields[1] , ''
   DISPLAY g_fabs2_d[l_ac].fabs008_desc TO fabs008_desc
END FUNCTION

 
{</section>}
 
