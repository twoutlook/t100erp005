#該程式未解開Section, 採用最新樣板產出!
{<section id="anmt440.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0036(2017-01-18 17:46:16), PR版次:0036(2017-02-16 10:36:14)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000358
#+ Filename...: anmt440
#+ Description: 應付票據開立作業
#+ Creator....: 02599(2014-06-06 00:00:00)
#+ Modifier...: 06821 -SD/PR- 07900
 
{</section>}
 
{<section id="anmt440.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#150518-00043#13 2015/06/05 By Jessy    新增經辦人工號與姓名欄位(nmck022)
#150616-00026#6  2015/06/17 By apo      作廢狀態時也應回寫apde009為'N';無論來源是否AP,一律開放支票簿號跟票據號碼兩欄位
#150616-00026#10 2015/06/22 By apo      移除整單操作串至anmt470的action,只留相關作業中的
#150626-00011#1  2015/07/07 By Reanna   修改來源組織檢核&開窗
#150714-00024#1  2015/07/15 By Reanna   bug修正
#150518-00043#12 2015/07/21 By Jessy    增加狀態碼更改控卡(寄出/自取日期資料已被回寫時，狀態不可被修改)
#150825-00004#1  2015/08/26 By Reanna   若付款對象是EMPL則把一次性交易欄位顯示出來並放入員工編號，否則就隱藏
#150922-00021#2  2015/09/21 By Reanna   變更匯率，重評後本幣金額也要重推
#150930-00010#4  2015/10/02 By 03538    匯率來源參數參照S-FIN-4012,且日平均匯率以新元件計算;透過匯率元件回傳的匯率不用再取一次位;匯率取位依原幣
#151008-00014#1  2015/10/08 By Reanna   確認時沒有回寫支票簿號下次開立號碼
#151012-00014#6  2015/10/19 By Reanna   修改單頭匯率需重推單身金額
#151013-00019#11 2015/11/19 By Reanna   新增時寄領方式改預帶2自領

#150916-00015#1  2015/11/30 By taozf    当有账套时，科目检查改为检查是否存在于glad_t中
#151125-00006#3  2015/12/03 By 07166    新增[編輯完單據後立即審核]功能
#151029-00001#5  2015/12/16 By 02599    单头来源增加'发票请款单'，此时单身抓取aapt415发票请款单资料
#151130-00015#2  2015/12/21 By 07675    根据是否可以更改單據日期 設定開放單據日期修改
#160119          2016/01/19 By 03538    增加不可輸入作廢之簿號+支票號碼的控卡
#150813-00015#5  2016/01/19 By 02599    增加日期控管，日期不可小于等于关账日期
#160122-00001#27 2016/01/27 By yangtt   添加交易帳戶編號用戶權限空管
#160122-00001#27 2016/03/16 By 07673    添加交易帳戶編號用戶權限空管,增加部门权限
#160318-00005#27 2016/03/24 By 07900    重复错误信息修改
#160321-00016#39 2016/03/30 By Jessy    將重複內容的錯誤訊息置換為公用錯誤訊息
#160318-00025#1  2016/04/06 By 07675    將重複內容的錯誤訊息置換為公用錯誤訊息(r.v）
#160413-00001#1  2016/04/13 By 03297    应付票据展期視同開立,开放修改
#160413-00039#1  2016/04/20 By 07673    查询开窗时把现金变动码表的条件拿掉，新增和修改是,nmck010查询开窗需要把glaa005的条件加上
#160524-00055#1  2016/06/15 By 01531    规格调整
#160616-00026#1  2016/06/17 By 02599    新增、修改時,來源類型:AP 請款單應不可以選
#160621-00015#1  2016/06/27 By 02599    增加票号号码检核
#160621-00016#1  2016/06/27 By 02599    现金变动码nmck049 nmck050开窗增加限制条件：现金变动码参照表号等于账套对应对的现金变动码参照表号
#160617-00017#1  2016/06/28 By 01531    來源為AP單時, 只能修改存提碼及現變碼;另加 topmenu : 可修改到期日, 支票簿號,票據號碼 /付款對象訊息框
#160708-00004#1  2016/07/08 By 01531    交易账户的账户类型码检查
#160729-00011#1  2016/08/08 By 01531    到期日应该不可以小于单据日期 
#160326-00001#37 2016/08/11 By 02599    '设定票据信息'增加字段[nmck027禁止背书转让],主程序重新显示nmck027
#160829-00032#1  2016/08/29 By 01727    【保证金账户】&【保证金来源账户】需要限定法人=单头指定的法人
#160816-00012#3  2016/09/05 By 01531    ANM增加资金中心，帐套，法人三个栏位权限
#160905-00056#1  2016/09/08 By 00768    修改原币金额、本币金额&重评后本币金额的联动
#160830-00039#1  2016/09/13 By 01531    1，anmt440中的支票簿号开窗要过率anmi130里面的套印否=Y的资料，即只能开套印否=N的资料
#                                       2.確認時增加回寫 支票明細檔 nmcd009 = 'Y' --列印否 
#160912-00024#1  2016/09/20 By 01531    来源组织权限控管
#160326-00001#20 2016/09/29 By 02114    整单操作下面增加按钮为票据补登，此按钮是在已审核的单据的情况下开启支票簿号（nmck024)和发票号码（nmck025)，
#                                       且在after filed 保存后增加回写支票簿号下次回写开立号码,update nmaf
#161019-00001#1  2016/10/19 By 01727    离开编辑状态(不论是在单头或单身),会检查单头单身金额是否一致,不一致时提示是否更新单头金额.然后在审核的时候判断单头单身金额是否一致,不一致报错返回.
#161006-00023#1  2016/10/20 By 06948    修正開窗選不到套印支票簿，欄位卻可以輸入套印支票簿的問題，新增控卡 anm-03031
#161021-00050#8  2016/10/26 By Reanna   资金中心开窗需调整为q_ooef001_33新增时where条件限定ooefstus= 'Y'查询时不限定此条件
#                                       法人开窗调整为q_ooef001_2,要注意原本where条件中的权限设置要保留
#                                       来源组织见excel "资金单身来源组织"anmt440/anmt460
#160822-00012#5  2016/11/02 By 08732    新舊值調整
#161102-00048#1  2016/11/10 By 01727    资金中心开窗ooef206 = 'Y'条件重复调用
#161114-00030#1  2016/11/25 By 01531    当单身金额合计与单头金额nmck103不一致，在退出单身维护时，报提示，是否更新单头金额，
#                                       确认后，会更新单头的原币金额和本币金额。
#                                       若此时 "票据保证金百分比nmck028" 不为空，"票据保证金金额nmck029"未做同步的更新
#161128-00061#2  2016/11/29 by 02481    标准程式定义采用宣告模式,弃用.*写法
#161026-00010#1  2016/12/22 By 01531    產生nmba_t的狀態碼應為’V’
#161228-00018#1  2016/12/28 By 02114    付款对象改抓pmab表
#161230-00012#1  2016/01/05 By 07900    票据类别下拉应该取aooi901资料，按据点取款别，其它条件不变
#170118-00018#1  2016/01/18 By 07900    161230-00012修改有误 ，anmt440的款别，应是符合aooi901的款别性质是30的资料，而不是所有的aooi901里的资料
#170118-00039#1  2017/01/18 By 06821    1.整單操作 增加"支票作廢" 2.檢核: 1.付款來源<>'AP' 且 不存在aapt420中 2.不存在異動作業anmt450 3.詢問確定作廢否? 4.回寫支票明細nmcd的作廢狀態  清空開票作業的【票據號碼】
#161104-00046#13 2017/01/23 By 08729    單別預設值;資料依照單別user dept權限過濾單號
#170118-00039#2  2017/02/02 By 06821    支票作廢加開子視窗, 輸入作廢理由碼回寫nmcd004, 同時回寫nmcd005作廢人員
#161213-00020#1  2017/02/09 by 08172    开窗检查调整
#170203-00007#1  2017/02/15 By 07900    5区（当前信用了两本支票簿）CNJ-T44-201702000003 点修改时，支票簿号会自动变化。

#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"
#IMPORT FGL anm_anmt440_01  #匯款來源
#end add-point 
 
SCHEMA ds 
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
#單頭 type 宣告
PRIVATE type type_g_nmck_m        RECORD
       nmcksite LIKE nmck_t.nmcksite, 
   nmcksite_desc LIKE type_t.chr80, 
   nmckcomp LIKE nmck_t.nmckcomp, 
   nmckcomp_desc LIKE type_t.chr80, 
   nmck003 LIKE nmck_t.nmck003, 
   nmck003_desc LIKE type_t.chr80, 
   nmckdocno LIKE nmck_t.nmckdocno, 
   nmck002 LIKE nmck_t.nmck002, 
   nmckdocdt LIKE nmck_t.nmckdocdt, 
   nmck004 LIKE nmck_t.nmck004, 
   nmck004_desc LIKE type_t.chr80, 
   nmas003 LIKE nmas_t.nmas003, 
   nmck019 LIKE nmck_t.nmck019, 
   nmckstus LIKE nmck_t.nmckstus, 
   nmckownid LIKE nmck_t.nmckownid, 
   nmckownid_desc LIKE type_t.chr80, 
   nmckowndp LIKE nmck_t.nmckowndp, 
   nmckowndp_desc LIKE type_t.chr80, 
   nmckcrtid LIKE nmck_t.nmckcrtid, 
   nmckcrtid_desc LIKE type_t.chr80, 
   nmckcrtdp LIKE nmck_t.nmckcrtdp, 
   nmckcrtdp_desc LIKE type_t.chr80, 
   nmckcrtdt LIKE nmck_t.nmckcrtdt, 
   nmckmodid LIKE nmck_t.nmckmodid, 
   nmckmodid_desc LIKE type_t.chr80, 
   nmckmoddt LIKE nmck_t.nmckmoddt, 
   nmckcnfid LIKE nmck_t.nmckcnfid, 
   nmckcnfid_desc LIKE type_t.chr80, 
   nmckcnfdt LIKE nmck_t.nmckcnfdt, 
   nmck001 LIKE nmck_t.nmck001, 
   nmck100 LIKE nmck_t.nmck100, 
   nmck103 LIKE nmck_t.nmck103, 
   nmck101 LIKE nmck_t.nmck101, 
   nmck113 LIKE nmck_t.nmck113, 
   nmck121 LIKE nmck_t.nmck121, 
   nmck123 LIKE nmck_t.nmck123, 
   nmck131 LIKE nmck_t.nmck131, 
   nmck133 LIKE nmck_t.nmck133, 
   nmck034 LIKE nmck_t.nmck034, 
   nmck035 LIKE nmck_t.nmck035, 
   nmck022 LIKE nmck_t.nmck022, 
   nmck022_desc LIKE type_t.chr500, 
   nmck036 LIKE nmck_t.nmck036, 
   nmck023 LIKE nmck_t.nmck023, 
   nmck011 LIKE nmck_t.nmck011, 
   nmck009 LIKE nmck_t.nmck009, 
   nmck009_desc LIKE type_t.chr80, 
   nmck010 LIKE nmck_t.nmck010, 
   nmck010_desc LIKE type_t.chr80, 
   nmck024 LIKE nmck_t.nmck024, 
   nmck027 LIKE nmck_t.nmck027, 
   nmck025 LIKE nmck_t.nmck025, 
   nmck026 LIKE nmck_t.nmck026, 
   nmck114 LIKE nmck_t.nmck114, 
   nmck124 LIKE nmck_t.nmck124, 
   nmck134 LIKE nmck_t.nmck134, 
   nmck005 LIKE nmck_t.nmck005, 
   nmck005_desc LIKE type_t.chr80, 
   nmck006 LIKE nmck_t.nmck006, 
   nmck006_desc LIKE type_t.chr80, 
   nmck015 LIKE nmck_t.nmck015, 
   nmck046 LIKE nmck_t.nmck046, 
   nmck030 LIKE nmck_t.nmck030, 
   nmck031 LIKE nmck_t.nmck031, 
   nmck028 LIKE nmck_t.nmck028, 
   nmck029 LIKE nmck_t.nmck029, 
   nmck032 LIKE nmck_t.nmck032, 
   nmck032_desc LIKE type_t.chr80, 
   nmck044 LIKE nmck_t.nmck044, 
   nmck044_desc LIKE type_t.chr80, 
   nmck045 LIKE nmck_t.nmck045, 
   nmck045_desc LIKE type_t.chr80, 
   nmck047 LIKE nmck_t.nmck047, 
   nmck047_desc LIKE type_t.chr80, 
   nmck048 LIKE nmck_t.nmck048, 
   nmck048_desc LIKE type_t.chr80, 
   nmck049 LIKE nmck_t.nmck049, 
   nmck049_desc LIKE type_t.chr80, 
   nmck050 LIKE nmck_t.nmck050, 
   nmck050_desc LIKE type_t.chr80, 
   nmck051 LIKE nmck_t.nmck051
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_nmcl_d        RECORD
       nmclseq LIKE nmcl_t.nmclseq, 
   nmclorga LIKE nmcl_t.nmclorga, 
   nmclorga_desc LIKE type_t.chr500, 
   nmcl001 LIKE nmcl_t.nmcl001, 
   nmcl002 LIKE nmcl_t.nmcl002, 
   nmcl003 LIKE nmcl_t.nmcl003, 
   nmcl003_desc LIKE type_t.chr500, 
   nmcl103 LIKE nmcl_t.nmcl103, 
   nmcl113 LIKE nmcl_t.nmcl113, 
   nmcl121 LIKE nmcl_t.nmcl121, 
   nmcl123 LIKE nmcl_t.nmcl123, 
   nmcl131 LIKE nmcl_t.nmcl131, 
   nmcl133 LIKE nmcl_t.nmcl133
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_nmckcomp LIKE nmck_t.nmckcomp,
      b_nmckdocno LIKE nmck_t.nmckdocno
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_para_data           LIKE type_t.chr80     #資金系統關帳日
DEFINE g_para_data1          LIKE type_t.chr80     #銀存支出匯率來源
DEFINE g_para_data2          LIKE type_t.chr80     #資金模組匯率來源   #150930-00010#4
DEFINE g_glaa001             LIKE glaa_t.glaa001
DEFINE g_glaald              LIKE glaa_t.glaald
DEFINE g_glaa004             LIKE glaa_t.glaa004
DEFINE g_glaa005             LIKE glaa_t.glaa005 
DEFINE g_ooef006             LIKE ooef_t.ooef006
DEFINE g_glaa015             LIKE glaa_t.glaa015
DEFINE g_glaa016             LIKE glaa_t.glaa016
DEFINE g_glaa017             LIKE glaa_t.glaa017
DEFINE g_glaa018             LIKE glaa_t.glaa018
DEFINE g_glaa019             LIKE glaa_t.glaa019
DEFINE g_glaa020             LIKE glaa_t.glaa020
DEFINE g_glaa021             LIKE glaa_t.glaa021
DEFINE g_glaa022             LIKE glaa_t.glaa022
DEFINE g_glaa003             LIKE glaa_t.glaa003   #会计周期参照表号 2014/123/29 liuym add
DEFINE g_glaa024             LIKE glaa_t.glaa024   #单据别参照表号   2014/123/29 liuym add
DEFINE g_site_wc             STRING                #150714-00024#1
DEFINE g_comp_wc             STRING                #150714-00024#1
#DEFINE g_wc2                 STRING
#GLOBALS
#   DEFINE g_wc_source        STRING
#   DEFINE g_nmckcomp         LIKE nmck_t.nmckcomp
#   DEFINE g_nmckdocno        LIKE nmck_t.nmckdocno
#   DEFINE g_nmckcomp_o       LIKE nmck_t.nmckcomp
#   DEFINE g_nmckdocno_o      LIKE nmck_t.nmckdocno
#   DEFINE g_detail_insert    LIKE type_t.num5   #單身的新增權限
#   DEFINE g_detail_delete    LIKE type_t.num5   #單身的刪除權限
#161019-00001#1 Add  ---(S)---
GLOBALS
    DEFINE g_nmckcomp         LIKE nmck_t.nmckcomp
    DEFINE g_nmckdocno        LIKE nmck_t.nmckdocno
END GLOBALS
#161019-00001#1 Add  ---(E)---
DEFINE g_sql_bank            STRING              #160122-00001#27 by 07673 
DEFINE g_user_dept_wc        STRING              #161104-00046#13
DEFINE g_user_dept_wc_q      STRING              #161104-00046#13
DEFINE g_user_slip_wc        STRING              #161104-00046#13
#END GLOBALS
#end add-point
       
#模組變數(Module Variables)
DEFINE g_nmck_m          type_g_nmck_m
DEFINE g_nmck_m_t        type_g_nmck_m
DEFINE g_nmck_m_o        type_g_nmck_m
DEFINE g_nmck_m_mask_o   type_g_nmck_m #轉換遮罩前資料
DEFINE g_nmck_m_mask_n   type_g_nmck_m #轉換遮罩後資料
 
   DEFINE g_nmckcomp_t LIKE nmck_t.nmckcomp
DEFINE g_nmckdocno_t LIKE nmck_t.nmckdocno
 
 
DEFINE g_nmcl_d          DYNAMIC ARRAY OF type_g_nmcl_d
DEFINE g_nmcl_d_t        type_g_nmcl_d
DEFINE g_nmcl_d_o        type_g_nmcl_d
DEFINE g_nmcl_d_mask_o   DYNAMIC ARRAY OF type_g_nmcl_d #轉換遮罩前資料
DEFINE g_nmcl_d_mask_n   DYNAMIC ARRAY OF type_g_nmcl_d #轉換遮罩後資料
 
 
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
 
{<section id="anmt440.main" >}
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
   #161104-00046#13-----s
   #建立與單頭array相同的temptable
   CALL s_aooi200def_create('','g_nmck_m','','','','','','')RETURNING g_sub_success
   
   #單別控制組
   LET g_user_dept_wc = ''
   CALL s_fin_get_user_dept_control('nmckcomp','','nmckent','nmckdocno') RETURNING g_user_dept_wc
   #開窗使用
   LET g_user_dept_wc_q = g_user_dept_wc
   
   CALL s_control_get_docno_sql(g_user,g_dept) RETURNING g_sub_success,g_user_slip_wc  
   #161104-00046#13-----e
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT nmcksite,'',nmckcomp,'',nmck003,'',nmckdocno,nmck002,nmckdocdt,nmck004, 
       '','',nmck019,nmckstus,nmckownid,'',nmckowndp,'',nmckcrtid,'',nmckcrtdp,'',nmckcrtdt,nmckmodid, 
       '',nmckmoddt,nmckcnfid,'',nmckcnfdt,nmck001,nmck100,nmck103,nmck101,nmck113,nmck121,nmck123,nmck131, 
       nmck133,nmck034,nmck035,nmck022,'',nmck036,nmck023,nmck011,nmck009,'',nmck010,'',nmck024,nmck027, 
       nmck025,nmck026,nmck114,nmck124,nmck134,nmck005,'',nmck006,'',nmck015,nmck046,nmck030,nmck031, 
       nmck028,nmck029,nmck032,'',nmck044,'',nmck045,'',nmck047,'',nmck048,'',nmck049,'',nmck050,'', 
       nmck051", 
                      " FROM nmck_t",
                      " WHERE nmckent= ? AND nmckcomp=? AND nmckdocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE anmt440_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.nmcksite,t0.nmckcomp,t0.nmck003,t0.nmckdocno,t0.nmck002,t0.nmckdocdt, 
       t0.nmck004,t0.nmck019,t0.nmckstus,t0.nmckownid,t0.nmckowndp,t0.nmckcrtid,t0.nmckcrtdp,t0.nmckcrtdt, 
       t0.nmckmodid,t0.nmckmoddt,t0.nmckcnfid,t0.nmckcnfdt,t0.nmck001,t0.nmck100,t0.nmck103,t0.nmck101, 
       t0.nmck113,t0.nmck121,t0.nmck123,t0.nmck131,t0.nmck133,t0.nmck034,t0.nmck035,t0.nmck022,t0.nmck036, 
       t0.nmck023,t0.nmck011,t0.nmck009,t0.nmck010,t0.nmck024,t0.nmck027,t0.nmck025,t0.nmck026,t0.nmck114, 
       t0.nmck124,t0.nmck134,t0.nmck005,t0.nmck006,t0.nmck015,t0.nmck046,t0.nmck030,t0.nmck031,t0.nmck028, 
       t0.nmck029,t0.nmck032,t0.nmck044,t0.nmck045,t0.nmck047,t0.nmck048,t0.nmck049,t0.nmck050,t0.nmck051, 
       t1.ooefl003 ,t2.ooefl003 ,t3.ooag011 ,t4.nmaal003 ,t5.ooag011 ,t6.ooefl003 ,t7.ooag011 ,t8.ooefl003 , 
       t9.ooag011 ,t10.ooag011 ,t11.nmajl003 ,t12.pmaal003 ,t13.nmabl003 ,t14.nmaal003 ,t15.nmaal003 , 
       t16.nmajl003 ,t17.nmajl003 ,t18.nmail004 ,t19.nmail004",
               " FROM nmck_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.nmcksite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.nmckcomp AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.nmck003  ",
               " LEFT JOIN nmaal_t t4 ON t4.nmaalent="||g_enterprise||" AND t4.nmaal001=t0.nmck004 AND t4.nmaal002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.nmckownid  ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent="||g_enterprise||" AND t6.ooefl001=t0.nmckowndp AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=t0.nmckcrtid  ",
               " LEFT JOIN ooefl_t t8 ON t8.ooeflent="||g_enterprise||" AND t8.ooefl001=t0.nmckcrtdp AND t8.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t9 ON t9.ooagent="||g_enterprise||" AND t9.ooag001=t0.nmckmodid  ",
               " LEFT JOIN ooag_t t10 ON t10.ooagent="||g_enterprise||" AND t10.ooag001=t0.nmckcnfid  ",
               " LEFT JOIN nmajl_t t11 ON t11.nmajlent="||g_enterprise||" AND t11.nmajl001=t0.nmck009 AND t11.nmajl002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t12 ON t12.pmaalent="||g_enterprise||" AND t12.pmaal001=t0.nmck005 AND t12.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN nmabl_t t13 ON t13.nmablent="||g_enterprise||" AND t13.nmabl001=t0.nmck032 AND t13.nmabl002='"||g_dlang||"' ",
               " LEFT JOIN nmaal_t t14 ON t14.nmaalent="||g_enterprise||" AND t14.nmaal001=t0.nmck044 AND t14.nmaal002='"||g_dlang||"' ",
               " LEFT JOIN nmaal_t t15 ON t15.nmaalent="||g_enterprise||" AND t15.nmaal001=t0.nmck045 AND t15.nmaal002='"||g_dlang||"' ",
               " LEFT JOIN nmajl_t t16 ON t16.nmajlent="||g_enterprise||" AND t16.nmajl001=t0.nmck047 AND t16.nmajl002='"||g_dlang||"' ",
               " LEFT JOIN nmajl_t t17 ON t17.nmajlent="||g_enterprise||" AND t17.nmajl001=t0.nmck048 AND t17.nmajl002='"||g_dlang||"' ",
               " LEFT JOIN nmail_t t18 ON t18.nmailent="||g_enterprise||" AND t18.nmail001='' AND t18.nmail002=t0.nmck049 AND t18.nmail003='"||g_dlang||"' ",
               " LEFT JOIN nmail_t t19 ON t19.nmailent="||g_enterprise||" AND t19.nmail001='' AND t19.nmail002=t0.nmck050 AND t19.nmail003='"||g_dlang||"' ",
 
               " WHERE t0.nmckent = " ||g_enterprise|| " AND t0.nmckcomp = ? AND t0.nmckdocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE anmt440_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_anmt440 WITH FORM cl_ap_formpath("anm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL anmt440_init()   
 
      #進入選單 Menu (="N")
      CALL anmt440_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_anmt440
      
   END IF 
   
   CLOSE anmt440_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="anmt440.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION anmt440_init()
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
      CALL cl_set_combo_scc_part('nmckstus','13','N,Y,A,D,R,W,X')
 
      CALL cl_set_combo_scc('nmck034','8712') 
   CALL cl_set_combo_scc('nmck026','8711') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL anmt440_set_combo_scc('nmck002','30')
   CALL cl_set_combo_scc('nmck001','8722')
   CALL anmt440_nmck026_scc('2')
   CALL cl_set_combo_scc('nmck034','8712')
   CALL cl_set_combo_scc('nmck030','8715')
#   #子程式畫面取代主程式元件
#   CALL cl_ui_replace_sub_window(cl_ap_formpath("anm", "anmt440_01"), "grid_source", "Table", "s_detail1_anmt440_01")

   CALL s_fin_create_account_center_tmp() #150714-00024#1
   
   #160122-00001#27 by 07673 --add--str--
   LET g_sql_bank=NULL
   CALL s_anmi120_get_bank_account_sql(g_user,g_dept) RETURNING g_sub_success,g_sql_bank
   #160122-00001#27 by 07673 --add--end
   #end add-point
   
   #初始化搜尋條件
   CALL anmt440_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="anmt440.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION anmt440_ui_dialog()
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
   DEFINE  l_n       LIKE type_t.num10          #151125-00006#3
   DEFINE  l_success LIKE type_t.num5           #160617-00017#1
   DEFINE  r_success LIKE type_t.num5           #160617-00017#1
   #end add-point
   
   #add-point:Function前置處理  name="ui_dialog.pre_function"
   LET l_success = TRUE      #160617-00017#1
   LET g_sub_success = TRUE  #160617-00017#1
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
            CALL anmt440_insert()
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
         INITIALIZE g_nmck_m.* TO NULL
         CALL g_nmcl_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL anmt440_init()
      END IF
   
            
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
    
         DISPLAY ARRAY g_nmcl_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL anmt440_idx_chk()
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
               CALL anmt440_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION detail_qrystr
               MENU "" ATTRIBUTE(STYLE="popup")
                  #add-point:ON ACTION detail_qrystr相關動作 name="menu.detail_show.page1_sub.detail_qrystr"
                  
                  #END add-point
                                 #應用 a43 樣板自動產生(Version:4)
               ON ACTION prog_aapt420
                  LET g_action_choice="prog_aapt420"
                  IF cl_auth_chk_act("prog_aapt420") THEN
                     
                     #add-point:ON ACTION prog_aapt420 name="menu.detail_show.page1_sub.prog_aapt420"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               INITIALIZE la_param.* TO NULL
               LET la_param.prog     = 'aapt420'
               LET la_param.param[1] = g_glaald
               LET la_param.param[2] = g_nmcl_d[l_ac].nmcl001

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
#            SUBDIALOG anm_anmt440_01.anmt440_01_display
#            SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         #end add-point
         
      
         BEFORE DIALOG
            #先填充browser資料
            CALL anmt440_browser_fill("")
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
               CALL anmt440_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL anmt440_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL anmt440_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL anmt440_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL anmt440_set_act_visible()   
            CALL anmt440_set_act_no_visible()
            IF NOT (g_nmck_m.nmckcomp IS NULL
              OR g_nmck_m.nmckdocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " nmckent = " ||g_enterprise|| " AND",
                                  " nmckcomp = '", g_nmck_m.nmckcomp, "' "
                                  ," AND nmckdocno = '", g_nmck_m.nmckdocno, "' "
 
               #填到對應位置
               CALL anmt440_browser_fill("")
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
                     WHEN la_wc[li_idx].tableid = "nmck_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "nmcl_t" 
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
               CALL anmt440_browser_fill("F")   #browser_fill()會將notice區塊清空
            END IF
         
         #查詢方案選擇
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "nmck_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "nmcl_t" 
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
                  CALL anmt440_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL anmt440_fetch("F")
                  END IF
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
          
         
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL anmt440_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL anmt440_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL anmt440_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL anmt440_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL anmt440_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL anmt440_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL anmt440_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL anmt440_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL anmt440_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL anmt440_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_nmcl_d)
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
               CALL anmt440_modify()
               #add-point:ON ACTION modify name="menu.modify"
               #151125-00006#3--s
               CALL anmt440_immediately_conf()
               SELECT COUNT(*) INTO l_n FROM nmck_t
                WHERE nmckent = g_enterprise AND nmckcomp = g_nmck_m.nmckcomp AND nmckdocno = g_nmck_m.nmckdocno
                IF l_n > 0 THEN CALL anmt440_ui_headershow() END IF
               #151125-00006#3--e
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL anmt440_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               #151125-00006#3--s
               CALL anmt440_immediately_conf()
               SELECT COUNT(*) INTO l_n FROM nmck_t
                WHERE nmckent = g_enterprise AND nmckcomp = g_nmck_m.nmckcomp AND nmckdocno = g_nmck_m.nmckdocno
                IF l_n > 0 THEN CALL anmt440_ui_headershow() END IF
               #151125-00006#3--e
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION extension
            LET g_action_choice="extension"
            IF cl_auth_chk_act("extension") THEN
               
               #add-point:ON ACTION extension name="menu.extension"
               CALL anmt440_extension()
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION anmt440_02
            LET g_action_choice="anmt440_02"
            IF cl_auth_chk_act("anmt440_02") THEN
               
               #add-point:ON ACTION anmt440_02 name="menu.anmt440_02"
               #160617-00017#1 add s--
               IF g_nmck_m.nmck001='AP' AND g_nmck_m.nmckstus = 'N' THEN
                #檢查當單據日期小於等於關帳日期時，不可異動單據
                CALL s_fin_date_close_chk('',g_nmck_m.nmckcomp,'ANM',g_nmck_m.nmckdocdt) RETURNING r_success
                IF  r_success = TRUE  THEN 
#160729-00011#1 mod s---                
#                   CALL cl_err_collect_init()
#                   CALL s_transaction_begin()
#                   CALL anmt440_02(g_nmck_m.nmckcomp,g_nmck_m.nmckdocno,g_nmck_m.nmck011,g_nmck_m.nmck024,g_nmck_m.nmck025,g_nmck_m.nmck005,g_nmck_m.nmck006,g_nmck_m.nmck015) RETURNING g_sub_success,l_success
#                   IF g_sub_success = FALSE AND l_success = FALSE THEN
#                      CALL cl_err_collect_show()
#                      CALL s_transaction_end('N','0') 
#                      INITIALIZE g_errparam TO NULL
#                      LET g_errparam.extend = ''
#                      LET g_errparam.popup = TRUE
#                      CALL cl_err()                                        
#                   ELSE
#                      CALL cl_err_collect_init() 
#                      CALL cl_err_collect_show()
#                      CALL s_transaction_end('Y','0')
#                      IF g_sub_success = TRUE AND l_success = TRUE THEN  
#                        INITIALIZE g_errparam TO NULL
#                        LET g_errparam.code = 'axm-00084'
#                        LET g_errparam.extend = ''
#                        LET g_errparam.popup = TRUE
#                        CALL cl_err()                       
#                      END IF
                   CALL s_transaction_begin()
                   CALL anmt440_02(g_nmck_m.nmckcomp,g_nmck_m.nmckdocno,g_nmck_m.nmck011,g_nmck_m.nmck024,g_nmck_m.nmck025,g_nmck_m.nmck005,g_nmck_m.nmck006,g_nmck_m.nmck015) RETURNING g_sub_success,l_success
                   IF g_sub_success = FALSE AND l_success = FALSE THEN
                      CALL s_transaction_end('N','0') 
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.extend = ''
                      LET g_errparam.popup = TRUE
                      CALL cl_err()                                        
                   ELSE
                      CALL s_transaction_end('Y','0')
                      IF g_sub_success = TRUE AND l_success = TRUE THEN  
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'axm-00084'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()                       
                      END IF
#160729-00011#1 mod e---
                   END IF
                   SELECT nmck011,nmck024,nmck025,nmck005,nmck006,nmck026,nmck015,nmck027 #160326-00001#37 add nmck027 
                     INTO g_nmck_m.nmck011,g_nmck_m.nmck024,g_nmck_m.nmck025,
                          g_nmck_m.nmck005,g_nmck_m.nmck006,g_nmck_m.nmck026,
                          g_nmck_m.nmck015,g_nmck_m.nmck027  #160326-00001#37 add nmck027
                     FROM nmck_t
                   WHERE nmckent = g_enterprise
                     AND nmckdocno = g_nmck_m.nmckdocno 
                     AND nmckcomp = g_nmck_m.nmckcomp 
                   IF cl_null(g_nmck_m.nmck006) THEN
                      INITIALIZE g_ref_fields TO NULL
                      LET g_ref_fields[1] = g_nmck_m.nmck005
                      CALL ap_ref_array2(g_ref_fields,"SELECT pmaal003 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
                      LET g_nmck_m.nmck005_desc = '', g_rtn_fields[1] , ''
                      DISPLAY BY NAME g_nmck_m.nmck005_desc
                   ELSE  
                      SELECT pmak003 INTO g_nmck_m.nmck005_desc
                        FROM pmak_t
                       WHERE pmakent = g_enterprise
                         AND pmak001 = g_nmck_m.nmck006
                      DISPLAY BY NAME g_nmck_m.nmck005_desc
                   END IF  
                   DISPLAY g_nmck_m.nmck011 TO nmck011     
                   DISPLAY g_nmck_m.nmck024 TO nmck024 
                   DISPLAY g_nmck_m.nmck025 TO nmck025 
                   DISPLAY g_nmck_m.nmck005 TO nmck005 
                   DISPLAY g_nmck_m.nmck005_desc TO nmck005_desc                
                   DISPLAY g_nmck_m.nmck006 TO nmck006  
                   DISPLAY g_nmck_m.nmck026 TO nmck026
                   DISPLAY g_nmck_m.nmck015 TO nmck015   
                   DISPLAY g_nmck_m.nmck027 TO nmck027 #160326-00001#37
                   IF g_nmck_m.nmck005 = 'EMPL' THEN
                      CALL cl_set_comp_visible('nmck006,nmck006_desc',TRUE)
                      LET g_nmck_m.nmck006_desc = s_desc_get_person_desc(g_nmck_m.nmck006)
                      DISPLAY BY NAME g_nmck_m.nmck006_desc
                   ELSE
                      CALL cl_set_comp_visible('nmck006,nmck006_desc',FALSE)
                   END IF                   
                  END IF 
               END IF   
               #160617-00017#1 add s--               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL anmt440_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL anmt440_insert()
               #add-point:ON ACTION insert name="menu.insert"
               #151125-00006#3--s
               CALL anmt440_immediately_conf()
               SELECT COUNT(*) INTO l_n FROM nmck_t
                WHERE nmckent = g_enterprise AND nmckcomp = g_nmck_m.nmckcomp AND nmckdocno = g_nmck_m.nmckdocno
                IF l_n > 0 THEN CALL anmt440_ui_headershow() END IF
               #151125-00006#3--e
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL anmt440_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION inv_invalid
            LET g_action_choice="inv_invalid"
            IF cl_auth_chk_act("inv_invalid") THEN
               
               #add-point:ON ACTION inv_invalid name="menu.inv_invalid"
               #170118-00039#1 --s add
               IF NOT cl_null(g_nmck_m.nmckdocno) AND NOT cl_null(g_nmck_m.nmckcomp) THEN 
                  CALL anmt440_inv_invalid()
                  #重show資訊
                  SELECT nmck025,nmckmodid,nmckmoddt,nmckcnfid,nmckcnfdt 
                    INTO g_nmck_m.nmck025,g_nmck_m.nmckmodid,g_nmck_m.nmckmoddt,g_nmck_m.nmckcnfid,g_nmck_m.nmckcnfdt  
                    FROM nmck_t  
                   WHERE nmckent = g_enterprise AND nmckcomp = g_nmck_m.nmckcomp AND nmckdocno = g_nmck_m.nmckdocno   
                  LET g_nmck_m.nmckmodid_desc = cl_get_username(g_nmck_m.nmckmodid)
                  LET g_nmck_m.nmckcnfid_desc = cl_get_username(g_nmck_m.nmckcnfid)                  
                  DISPLAY BY NAME g_nmck_m.nmck025,g_nmck_m.nmckmodid,g_nmck_m.nmckmoddt,g_nmck_m.nmckcnfid,g_nmck_m.nmckcnfdt,
                                  g_nmck_m.nmckmodid_desc,g_nmck_m.nmckcnfid_desc           
                  CALL anmt440_show()
               END IF
               #170118-00039#1 --e add
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION invoice
            LET g_action_choice="invoice"
            IF cl_auth_chk_act("invoice") THEN
               
               #add-point:ON ACTION invoice name="menu.invoice"
               IF NOT cl_null(g_nmck_m.nmckdocno) AND g_nmck_m.nmckstus = 'Y' THEN 
                  CALL anmt440_invoice()
                  CALL anmt440_show()
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_nmck003
            LET g_action_choice="prog_nmck003"
            IF cl_auth_chk_act("prog_nmck003") THEN
               
               #add-point:ON ACTION prog_nmck003 name="menu.prog_nmck003"
               CALL cl_user_contact("aooi130", "ooag_t", "ooag002", "ooag001",g_nmck_m.nmck003)
               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL anmt440_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL anmt440_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL anmt440_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_nmck_m.nmckdocdt)
 
 
 
         
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
 
{<section id="anmt440.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION anmt440_browser_fill(ps_page_action)
   #add-point:browser_fill段define(客製用) name="browser_fill.define_customerization"
   
   #end add-point  
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   DEFINE l_comp_str        STRING  #160816-00012#3 add 
#   DEFINE l_sub_sql         STRING
#   DEFINE l_wc2             STRING
   
   #2015/04/01 by 02599 add 'ooiaent=g_enterprise'
   IF cl_null(g_wc) THEN 
      LET g_wc = " nmck002 IN (SELECT ooia001 FROM ooia_t WHERE ooia002 = '30' AND ooiaent = ",g_enterprise,") " 
   ELSE
      LET g_wc = g_wc," AND nmck002 IN (SELECT ooia001 FROM ooia_t WHERE ooia002 = '30' AND ooiaent = ",g_enterprise,") "
   END IF
   #160126-00010#27---add---str
#160621-00015#1--mark--str--
#   LET g_wc = g_wc CLIPPED," AND (nmck004 IN(SELECT UNIQUE nmll001 FROM nmll_t WHERE nmllent = ",g_enterprise," AND nmll002='",g_user,"') OR nmck004 IS NULL)",
#              " AND (nmck044 IN(SELECT UNIQUE nmll001 FROM nmll_t WHERE nmllent = ",g_enterprise," AND nmll002='",g_user,"') OR nmck044 IS NULL)",
#              " AND (nmck045 IN(SELECT UNIQUE nmll001 FROM nmll_t WHERE nmllent = ",g_enterprise," AND nmll002='",g_user,"') OR nmck045 IS NULL)"
#160621-00015#1--mark--end
   #160126-00010#27---add---end
   #160621-00015#1--add--str--
   LET g_wc = g_wc CLIPPED," AND (nmck004 IN (",g_sql_bank,") OR nmck004 IS NULL)",
              " AND (nmck044 IN (",g_sql_bank,") OR nmck044 IS NULL)",
              " AND (nmck045 IN (",g_sql_bank,") OR nmck045 IS NULL)"
   #160621-00015#1--add--end
   
   #160816-00012#3 add s---
   CALL s_axrt300_get_site(g_user,'','3') RETURNING l_comp_str
   LET l_comp_str = cl_replace_str(l_comp_str,"ooef017","nmckcomp")
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
 
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT nmckcomp,nmckdocno ",
                      " FROM nmck_t ",
                      " ",
                      " LEFT JOIN nmcl_t ON nmclent = nmckent AND nmckcomp = nmclcomp AND nmckdocno = nmcldocno ", "  ",
                      #add-point:browser_fill段sql(nmcl_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
 
                      " ", 
                      " ", 
 
 
                      " WHERE nmckent = " ||g_enterprise|| " AND nmclent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("nmck_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT nmckcomp,nmckdocno ",
                      " FROM nmck_t ", 
                      "  ",
                      "  ",
                      " WHERE nmckent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("nmck_t")
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
      INITIALIZE g_nmck_m.* TO NULL
      CALL g_nmcl_d.clear()        
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.nmckcomp,t0.nmckdocno Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.nmckstus,t0.nmckcomp,t0.nmckdocno ",
                  " FROM nmck_t t0",
                  "  ",
                  "  LEFT JOIN nmcl_t ON nmclent = nmckent AND nmckcomp = nmclcomp AND nmckdocno = nmcldocno ", "  ", 
                  #add-point:browser_fill段sql(nmcl_t1) name="browser_fill.join.nmcl_t1"
                  
                  #end add-point
 
 
                  " ", 
 
 
                  
                  " WHERE t0.nmckent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("nmck_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.nmckstus,t0.nmckcomp,t0.nmckdocno ",
                  " FROM nmck_t t0",
                  "  ",
                  
                  " WHERE t0.nmckent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("nmck_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY nmckcomp,nmckdocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"nmck_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_nmckcomp,g_browser[g_cnt].b_nmckdocno 
 
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
   
   IF cl_null(g_browser[g_cnt].b_nmckcomp) THEN
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
 
{<section id="anmt440.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION anmt440_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_nmck_m.nmckcomp = g_browser[g_current_idx].b_nmckcomp   
   LET g_nmck_m.nmckdocno = g_browser[g_current_idx].b_nmckdocno   
 
   EXECUTE anmt440_master_referesh USING g_nmck_m.nmckcomp,g_nmck_m.nmckdocno INTO g_nmck_m.nmcksite, 
       g_nmck_m.nmckcomp,g_nmck_m.nmck003,g_nmck_m.nmckdocno,g_nmck_m.nmck002,g_nmck_m.nmckdocdt,g_nmck_m.nmck004, 
       g_nmck_m.nmck019,g_nmck_m.nmckstus,g_nmck_m.nmckownid,g_nmck_m.nmckowndp,g_nmck_m.nmckcrtid,g_nmck_m.nmckcrtdp, 
       g_nmck_m.nmckcrtdt,g_nmck_m.nmckmodid,g_nmck_m.nmckmoddt,g_nmck_m.nmckcnfid,g_nmck_m.nmckcnfdt, 
       g_nmck_m.nmck001,g_nmck_m.nmck100,g_nmck_m.nmck103,g_nmck_m.nmck101,g_nmck_m.nmck113,g_nmck_m.nmck121, 
       g_nmck_m.nmck123,g_nmck_m.nmck131,g_nmck_m.nmck133,g_nmck_m.nmck034,g_nmck_m.nmck035,g_nmck_m.nmck022, 
       g_nmck_m.nmck036,g_nmck_m.nmck023,g_nmck_m.nmck011,g_nmck_m.nmck009,g_nmck_m.nmck010,g_nmck_m.nmck024, 
       g_nmck_m.nmck027,g_nmck_m.nmck025,g_nmck_m.nmck026,g_nmck_m.nmck114,g_nmck_m.nmck124,g_nmck_m.nmck134, 
       g_nmck_m.nmck005,g_nmck_m.nmck006,g_nmck_m.nmck015,g_nmck_m.nmck046,g_nmck_m.nmck030,g_nmck_m.nmck031, 
       g_nmck_m.nmck028,g_nmck_m.nmck029,g_nmck_m.nmck032,g_nmck_m.nmck044,g_nmck_m.nmck045,g_nmck_m.nmck047, 
       g_nmck_m.nmck048,g_nmck_m.nmck049,g_nmck_m.nmck050,g_nmck_m.nmck051,g_nmck_m.nmcksite_desc,g_nmck_m.nmckcomp_desc, 
       g_nmck_m.nmck003_desc,g_nmck_m.nmck004_desc,g_nmck_m.nmckownid_desc,g_nmck_m.nmckowndp_desc,g_nmck_m.nmckcrtid_desc, 
       g_nmck_m.nmckcrtdp_desc,g_nmck_m.nmckmodid_desc,g_nmck_m.nmckcnfid_desc,g_nmck_m.nmck009_desc, 
       g_nmck_m.nmck005_desc,g_nmck_m.nmck032_desc,g_nmck_m.nmck044_desc,g_nmck_m.nmck045_desc,g_nmck_m.nmck047_desc, 
       g_nmck_m.nmck048_desc,g_nmck_m.nmck049_desc,g_nmck_m.nmck050_desc
   
   CALL anmt440_nmck_t_mask()
   CALL anmt440_show()
      
END FUNCTION
 
{</section>}
 
{<section id="anmt440.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION anmt440_ui_detailshow()
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
 
{<section id="anmt440.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION anmt440_ui_browser_refresh()
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
      IF g_browser[l_i].b_nmckcomp = g_nmck_m.nmckcomp 
         AND g_browser[l_i].b_nmckdocno = g_nmck_m.nmckdocno 
 
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
 
{<section id="anmt440.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION anmt440_construct()
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
   DEFINE l_comp_str  STRING #160816-00012#3    
   DEFINE l_orga_str  STRING #160816-00012#3    
   #end add-point    
   
   #add-point:Function前置處理  name="cs.pre_function"
   
   #end add-point
    
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_nmck_m.* TO NULL
   CALL g_nmcl_d.clear()        
 
   
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
      CONSTRUCT BY NAME g_wc ON nmcksite,nmckcomp,nmck003,nmckdocno,nmck002,nmckdocdt,nmck004,nmas003, 
          nmck019,nmckstus,nmckownid,nmckowndp,nmckcrtid,nmckcrtdp,nmckcrtdt,nmckmodid,nmckmoddt,nmckcnfid, 
          nmckcnfdt,nmck001,nmck100,nmck103,nmck101,nmck113,nmck121,nmck123,nmck131,nmck133,nmck034, 
          nmck035,nmck036,nmck011,nmck009,nmck010,nmck010_desc,nmck024,nmck027,nmck025,nmck026,nmck114, 
          nmck124,nmck134,nmck005,nmck006,nmck015,nmck046,nmck030,nmck031,nmck028,nmck029,nmck032,nmck044, 
          nmck045,nmck047,nmck048,nmck049,nmck050,nmck051
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<nmckcrtdt>>----
         AFTER FIELD nmckcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<nmckmoddt>>----
         AFTER FIELD nmckmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<nmckcnfdt>>----
         AFTER FIELD nmckcnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<nmckpstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.nmcksite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmcksite
            #add-point:ON ACTION controlp INFIELD nmcksite name="construct.c.nmcksite"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
           #LET g_qryparam.where = " ooef206 = 'Y'"   #161102-00048#1 Mark
            #CALL q_ooef001()    #161021-00050#8 mark
            CALL q_ooef001_33()  #161021-00050#8
            DISPLAY g_qryparam.return1 TO nmcksite
            NEXT FIELD nmcksite
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmcksite
            #add-point:BEFORE FIELD nmcksite name="construct.b.nmcksite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmcksite
            
            #add-point:AFTER FIELD nmcksite name="construct.a.nmcksite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmckcomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmckcomp
            #add-point:ON ACTION controlp INFIELD nmckcomp name="construct.c.nmckcomp"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #160816-00012#3 Add  ---(S)---
            CALL s_axrt300_get_site(g_user,'','3') RETURNING l_comp_str
            LET g_qryparam.where = l_comp_str CLIPPED
            #160816-00012#3 Add  ---(E)---            
           #CALL q_ooef001()    #150714-00024#1 mark
            CALL q_ooef001_2()  #150714-00024#1
            DISPLAY g_qryparam.return1 TO nmckcomp
            NEXT FIELD nmckcomp
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmckcomp
            #add-point:BEFORE FIELD nmckcomp name="construct.b.nmckcomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmckcomp
            
            #add-point:AFTER FIELD nmckcomp name="construct.a.nmckcomp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmck003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck003
            #add-point:ON ACTION controlp INFIELD nmck003 name="construct.c.nmck003"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmck003  #顯示到畫面上
            NEXT FIELD nmck003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck003
            #add-point:BEFORE FIELD nmck003 name="construct.b.nmck003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck003
            
            #add-point:AFTER FIELD nmck003 name="construct.a.nmck003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmckdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmckdocno
            #add-point:ON ACTION controlp INFIELD nmckdocno name="construct.c.nmckdocno"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " nmck002 IN (SELECT ooia001 FROM ooia_t  WHERE ooia002 = '30' AND ooiaent = ",g_enterprise," )"
            #161104-00046#13-----s
            #單別權限控管
            IF NOT cl_null(g_user_dept_wc_q) AND NOT g_user_dept_wc_q = ' 1=1'  THEN
               LET g_qryparam.where = g_qryparam.where," AND ",g_user_dept_wc_q CLIPPED
            END IF
            #161104-00046#13-----e
            CALL q_nmckdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmckdocno  #顯示到畫面上
            NEXT FIELD nmckdocno                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmckdocno
            #add-point:BEFORE FIELD nmckdocno name="construct.b.nmckdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmckdocno
            
            #add-point:AFTER FIELD nmckdocno name="construct.a.nmckdocno"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck002
            #add-point:BEFORE FIELD nmck002 name="construct.b.nmck002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck002
            
            #add-point:AFTER FIELD nmck002 name="construct.a.nmck002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmck002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck002
            #add-point:ON ACTION controlp INFIELD nmck002 name="construct.c.nmck002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmckdocdt
            #add-point:BEFORE FIELD nmckdocdt name="construct.b.nmckdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmckdocdt
            
            #add-point:AFTER FIELD nmckdocdt name="construct.a.nmckdocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmckdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmckdocdt
            #add-point:ON ACTION controlp INFIELD nmckdocdt name="construct.c.nmckdocdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.nmck004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck004
            #add-point:ON ACTION controlp INFIELD nmck004 name="construct.c.nmck004"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #160122-00001#27 by 07673 mark --str
#            #160122-00001#27--add---str
#            LET g_qryparam.where = " nmas002 IN (SELECT nmll001 FROM nmll_t WHERE nmllent = ",g_enterprise,
#                                   " AND nmll002 = '",g_user,"')"
#            #160122-00001#27--add---end
            #160122-00001#27 by 07673 mark --end 
            #160122-00001#27 by 07673 add -str
            LET g_qryparam.where = " nmas002 IN (",g_sql_bank,")"
            #160122-00001#27 by 07673 add -end
            CALL q_nmas_01()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmck004  #顯示到畫面上
            LET g_qryparam.where = " "             #160122-00001#27
            NEXT FIELD nmck004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck004
            #add-point:BEFORE FIELD nmck004 name="construct.b.nmck004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck004
            
            #add-point:AFTER FIELD nmck004 name="construct.a.nmck004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmas003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmas003
            #add-point:ON ACTION controlp INFIELD nmas003 name="construct.c.nmas003"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooaj002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmas003  #顯示到畫面上
            NEXT FIELD nmas003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmas003
            #add-point:BEFORE FIELD nmas003 name="construct.b.nmas003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmas003
            
            #add-point:AFTER FIELD nmas003 name="construct.a.nmas003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmck019
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck019
            #add-point:ON ACTION controlp INFIELD nmck019 name="construct.c.nmck019"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " nmck002 IN (SELECT ooia001 FROM ooia_t  WHERE ooia002 = '30' AND ooiaent = ",g_enterprise," )"
            CALL q_nmck019()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmck019  #顯示到畫面上
            NEXT FIELD nmck019                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck019
            #add-point:BEFORE FIELD nmck019 name="construct.b.nmck019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck019
            
            #add-point:AFTER FIELD nmck019 name="construct.a.nmck019"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmckstus
            #add-point:BEFORE FIELD nmckstus name="construct.b.nmckstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmckstus
            
            #add-point:AFTER FIELD nmckstus name="construct.a.nmckstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmckstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmckstus
            #add-point:ON ACTION controlp INFIELD nmckstus name="construct.c.nmckstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.nmckownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmckownid
            #add-point:ON ACTION controlp INFIELD nmckownid name="construct.c.nmckownid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmckownid  #顯示到畫面上
            NEXT FIELD nmckownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmckownid
            #add-point:BEFORE FIELD nmckownid name="construct.b.nmckownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmckownid
            
            #add-point:AFTER FIELD nmckownid name="construct.a.nmckownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmckowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmckowndp
            #add-point:ON ACTION controlp INFIELD nmckowndp name="construct.c.nmckowndp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmckowndp  #顯示到畫面上
            NEXT FIELD nmckowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmckowndp
            #add-point:BEFORE FIELD nmckowndp name="construct.b.nmckowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmckowndp
            
            #add-point:AFTER FIELD nmckowndp name="construct.a.nmckowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmckcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmckcrtid
            #add-point:ON ACTION controlp INFIELD nmckcrtid name="construct.c.nmckcrtid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmckcrtid  #顯示到畫面上
            NEXT FIELD nmckcrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmckcrtid
            #add-point:BEFORE FIELD nmckcrtid name="construct.b.nmckcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmckcrtid
            
            #add-point:AFTER FIELD nmckcrtid name="construct.a.nmckcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmckcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmckcrtdp
            #add-point:ON ACTION controlp INFIELD nmckcrtdp name="construct.c.nmckcrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmckcrtdp  #顯示到畫面上
            NEXT FIELD nmckcrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmckcrtdp
            #add-point:BEFORE FIELD nmckcrtdp name="construct.b.nmckcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmckcrtdp
            
            #add-point:AFTER FIELD nmckcrtdp name="construct.a.nmckcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmckcrtdt
            #add-point:BEFORE FIELD nmckcrtdt name="construct.b.nmckcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.nmckmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmckmodid
            #add-point:ON ACTION controlp INFIELD nmckmodid name="construct.c.nmckmodid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmckmodid  #顯示到畫面上
            NEXT FIELD nmckmodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmckmodid
            #add-point:BEFORE FIELD nmckmodid name="construct.b.nmckmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmckmodid
            
            #add-point:AFTER FIELD nmckmodid name="construct.a.nmckmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmckmoddt
            #add-point:BEFORE FIELD nmckmoddt name="construct.b.nmckmoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.nmckcnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmckcnfid
            #add-point:ON ACTION controlp INFIELD nmckcnfid name="construct.c.nmckcnfid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmckcnfid  #顯示到畫面上
            NEXT FIELD nmckcnfid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmckcnfid
            #add-point:BEFORE FIELD nmckcnfid name="construct.b.nmckcnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmckcnfid
            
            #add-point:AFTER FIELD nmckcnfid name="construct.a.nmckcnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmckcnfdt
            #add-point:BEFORE FIELD nmckcnfdt name="construct.b.nmckcnfdt"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck001
            #add-point:BEFORE FIELD nmck001 name="construct.b.nmck001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck001
            
            #add-point:AFTER FIELD nmck001 name="construct.a.nmck001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmck001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck001
            #add-point:ON ACTION controlp INFIELD nmck001 name="construct.c.nmck001"
            
            #END add-point
 
 
         #Ctrlp:construct.c.nmck100
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck100
            #add-point:ON ACTION controlp INFIELD nmck100 name="construct.c.nmck100"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_aooi001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmck100  #顯示到畫面上
            NEXT FIELD nmck100                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck100
            #add-point:BEFORE FIELD nmck100 name="construct.b.nmck100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck100
            
            #add-point:AFTER FIELD nmck100 name="construct.a.nmck100"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck103
            #add-point:BEFORE FIELD nmck103 name="construct.b.nmck103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck103
            
            #add-point:AFTER FIELD nmck103 name="construct.a.nmck103"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmck103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck103
            #add-point:ON ACTION controlp INFIELD nmck103 name="construct.c.nmck103"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck101
            #add-point:BEFORE FIELD nmck101 name="construct.b.nmck101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck101
            
            #add-point:AFTER FIELD nmck101 name="construct.a.nmck101"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmck101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck101
            #add-point:ON ACTION controlp INFIELD nmck101 name="construct.c.nmck101"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck113
            #add-point:BEFORE FIELD nmck113 name="construct.b.nmck113"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck113
            
            #add-point:AFTER FIELD nmck113 name="construct.a.nmck113"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmck113
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck113
            #add-point:ON ACTION controlp INFIELD nmck113 name="construct.c.nmck113"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck121
            #add-point:BEFORE FIELD nmck121 name="construct.b.nmck121"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck121
            
            #add-point:AFTER FIELD nmck121 name="construct.a.nmck121"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmck121
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck121
            #add-point:ON ACTION controlp INFIELD nmck121 name="construct.c.nmck121"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck123
            #add-point:BEFORE FIELD nmck123 name="construct.b.nmck123"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck123
            
            #add-point:AFTER FIELD nmck123 name="construct.a.nmck123"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmck123
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck123
            #add-point:ON ACTION controlp INFIELD nmck123 name="construct.c.nmck123"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck131
            #add-point:BEFORE FIELD nmck131 name="construct.b.nmck131"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck131
            
            #add-point:AFTER FIELD nmck131 name="construct.a.nmck131"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmck131
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck131
            #add-point:ON ACTION controlp INFIELD nmck131 name="construct.c.nmck131"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck133
            #add-point:BEFORE FIELD nmck133 name="construct.b.nmck133"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck133
            
            #add-point:AFTER FIELD nmck133 name="construct.a.nmck133"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmck133
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck133
            #add-point:ON ACTION controlp INFIELD nmck133 name="construct.c.nmck133"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck034
            #add-point:BEFORE FIELD nmck034 name="construct.b.nmck034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck034
            
            #add-point:AFTER FIELD nmck034 name="construct.a.nmck034"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmck034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck034
            #add-point:ON ACTION controlp INFIELD nmck034 name="construct.c.nmck034"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck035
            #add-point:BEFORE FIELD nmck035 name="construct.b.nmck035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck035
            
            #add-point:AFTER FIELD nmck035 name="construct.a.nmck035"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmck035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck035
            #add-point:ON ACTION controlp INFIELD nmck035 name="construct.c.nmck035"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck036
            #add-point:BEFORE FIELD nmck036 name="construct.b.nmck036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck036
            
            #add-point:AFTER FIELD nmck036 name="construct.a.nmck036"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmck036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck036
            #add-point:ON ACTION controlp INFIELD nmck036 name="construct.c.nmck036"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck011
            #add-point:BEFORE FIELD nmck011 name="construct.b.nmck011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck011
            
            #add-point:AFTER FIELD nmck011 name="construct.a.nmck011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmck011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck011
            #add-point:ON ACTION controlp INFIELD nmck011 name="construct.c.nmck011"
            
            #END add-point
 
 
         #Ctrlp:construct.c.nmck009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck009
            #add-point:ON ACTION controlp INFIELD nmck009 name="construct.c.nmck009"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " nmad002 IN (SELECT nmaj001 FROM nmaj_t WHERE nmaj002='2'AND nmajstus='Y' AND nmajent = ",g_enterprise," )"
            CALL q_nmad002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmck009  #顯示到畫面上
            NEXT FIELD nmck009                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck009
            #add-point:BEFORE FIELD nmck009 name="construct.b.nmck009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck009
            
            #add-point:AFTER FIELD nmck009 name="construct.a.nmck009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmck010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck010
            #add-point:ON ACTION controlp INFIELD nmck010 name="construct.c.nmck010"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
#            LET g_qryparam.where = " nmai001='",g_glaa005,"'"  #160413-00039#1 mark
            
            CALL q_nmai002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmck010  #顯示到畫面上
            NEXT FIELD nmck010                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck010
            #add-point:BEFORE FIELD nmck010 name="construct.b.nmck010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck010
            
            #add-point:AFTER FIELD nmck010 name="construct.a.nmck010"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck010_desc
            #add-point:BEFORE FIELD nmck010_desc name="construct.b.nmck010_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck010_desc
            
            #add-point:AFTER FIELD nmck010_desc name="construct.a.nmck010_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmck010_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck010_desc
            #add-point:ON ACTION controlp INFIELD nmck010_desc name="construct.c.nmck010_desc"
            
            #END add-point
 
 
         #Ctrlp:construct.c.nmck024
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck024
            #add-point:ON ACTION controlp INFIELD nmck024 name="construct.c.nmck024"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_nmaf004()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmck024  #顯示到畫面上
            NEXT FIELD nmck024                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck024
            #add-point:BEFORE FIELD nmck024 name="construct.b.nmck024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck024
            
            #add-point:AFTER FIELD nmck024 name="construct.a.nmck024"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck027
            #add-point:BEFORE FIELD nmck027 name="construct.b.nmck027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck027
            
            #add-point:AFTER FIELD nmck027 name="construct.a.nmck027"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmck027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck027
            #add-point:ON ACTION controlp INFIELD nmck027 name="construct.c.nmck027"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck025
            #add-point:BEFORE FIELD nmck025 name="construct.b.nmck025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck025
            
            #add-point:AFTER FIELD nmck025 name="construct.a.nmck025"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmck025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck025
            #add-point:ON ACTION controlp INFIELD nmck025 name="construct.c.nmck025"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck026
            #add-point:BEFORE FIELD nmck026 name="construct.b.nmck026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck026
            
            #add-point:AFTER FIELD nmck026 name="construct.a.nmck026"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmck026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck026
            #add-point:ON ACTION controlp INFIELD nmck026 name="construct.c.nmck026"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck114
            #add-point:BEFORE FIELD nmck114 name="construct.b.nmck114"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck114
            
            #add-point:AFTER FIELD nmck114 name="construct.a.nmck114"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmck114
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck114
            #add-point:ON ACTION controlp INFIELD nmck114 name="construct.c.nmck114"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck124
            #add-point:BEFORE FIELD nmck124 name="construct.b.nmck124"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck124
            
            #add-point:AFTER FIELD nmck124 name="construct.a.nmck124"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmck124
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck124
            #add-point:ON ACTION controlp INFIELD nmck124 name="construct.c.nmck124"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck134
            #add-point:BEFORE FIELD nmck134 name="construct.b.nmck134"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck134
            
            #add-point:AFTER FIELD nmck134 name="construct.a.nmck134"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmck134
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck134
            #add-point:ON ACTION controlp INFIELD nmck134 name="construct.c.nmck134"
            
            #END add-point
 
 
         #Ctrlp:construct.c.nmck005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck005
            #add-point:ON ACTION controlp INFIELD nmck005 name="construct.c.nmck005"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #CALL q_pmaa001_10()                   #呼叫開窗    #161228-00018#1 mark lujh
            CALL q_pmab001_3()                                 #161228-00018#1 add lujh
            DISPLAY g_qryparam.return1 TO nmck005  #顯示到畫面上
            NEXT FIELD nmck005                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck005
            #add-point:BEFORE FIELD nmck005 name="construct.b.nmck005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck005
            
            #add-point:AFTER FIELD nmck005 name="construct.a.nmck005"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck006
            #add-point:BEFORE FIELD nmck006 name="construct.b.nmck006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck006
            
            #add-point:AFTER FIELD nmck006 name="construct.a.nmck006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmck006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck006
            #add-point:ON ACTION controlp INFIELD nmck006 name="construct.c.nmck006"
            #150825-00004#1 add ------
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()
            DISPLAY g_qryparam.return1 TO nmck006
            NEXT FIELD nmck006
            #150825-00004#1 add end---
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck015
            #add-point:BEFORE FIELD nmck015 name="construct.b.nmck015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck015
            
            #add-point:AFTER FIELD nmck015 name="construct.a.nmck015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmck015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck015
            #add-point:ON ACTION controlp INFIELD nmck015 name="construct.c.nmck015"
            
            #END add-point
 
 
         #Ctrlp:construct.c.nmck046
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck046
            #add-point:ON ACTION controlp INFIELD nmck046 name="construct.c.nmck046"
            #應用 a08 樣板自動產生(Version:1)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_nmas003()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmck046  #顯示到畫面上
            NEXT FIELD nmck046                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck046
            #add-point:BEFORE FIELD nmck046 name="construct.b.nmck046"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck046
            
            #add-point:AFTER FIELD nmck046 name="construct.a.nmck046"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck030
            #add-point:BEFORE FIELD nmck030 name="construct.b.nmck030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck030
            
            #add-point:AFTER FIELD nmck030 name="construct.a.nmck030"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmck030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck030
            #add-point:ON ACTION controlp INFIELD nmck030 name="construct.c.nmck030"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck031
            #add-point:BEFORE FIELD nmck031 name="construct.b.nmck031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck031
            
            #add-point:AFTER FIELD nmck031 name="construct.a.nmck031"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmck031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck031
            #add-point:ON ACTION controlp INFIELD nmck031 name="construct.c.nmck031"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck028
            #add-point:BEFORE FIELD nmck028 name="construct.b.nmck028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck028
            
            #add-point:AFTER FIELD nmck028 name="construct.a.nmck028"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmck028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck028
            #add-point:ON ACTION controlp INFIELD nmck028 name="construct.c.nmck028"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck029
            #add-point:BEFORE FIELD nmck029 name="construct.b.nmck029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck029
            
            #add-point:AFTER FIELD nmck029 name="construct.a.nmck029"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmck029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck029
            #add-point:ON ACTION controlp INFIELD nmck029 name="construct.c.nmck029"
            
            #END add-point
 
 
         #Ctrlp:construct.c.nmck032
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck032
            #add-point:ON ACTION controlp INFIELD nmck032 name="construct.c.nmck032"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_nmab001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmck032  #顯示到畫面上
            NEXT FIELD nmck032                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck032
            #add-point:BEFORE FIELD nmck032 name="construct.b.nmck032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck032
            
            #add-point:AFTER FIELD nmck032 name="construct.a.nmck032"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmck044
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck044
            #add-point:ON ACTION controlp INFIELD nmck044 name="construct.c.nmck044"
            #應用 a08 樣板自動產生(Version:1)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #160122-00001#27 by 07673 mark --str
#            #160122-00001#27--add---str
#            LET g_qryparam.where = " nmas002 IN (SELECT nmll001 FROM nmll_t WHERE nmllent = ",g_enterprise,
#                                   " AND nmll002 = '",g_user,"')"
#            #160122-00001#27--add---end
            #160122-00001#27 by 07673 mark --end 
            #160122-00001#27 by 07673 add -str
            LET g_qryparam.where = " nmas002 IN (",g_sql_bank,")"
            #160122-00001#27 by 07673 add -end
            CALL q_nmas002_10()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmck044  #顯示到畫面上
            LET g_qryparam.where = " "             #160122-00001#27
            NEXT FIELD nmck044                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck044
            #add-point:BEFORE FIELD nmck044 name="construct.b.nmck044"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck044
            
            #add-point:AFTER FIELD nmck044 name="construct.a.nmck044"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmck045
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck045
            #add-point:ON ACTION controlp INFIELD nmck045 name="construct.c.nmck045"
            #應用 a08 樣板自動產生(Version:1)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #160122-00001#27 by 07673 mark --str
#            #160122-00001#27--add---str
#            LET g_qryparam.where = " nmas002 IN (SELECT nmll001 FROM nmll_t WHERE nmllent = ",g_enterprise,
#                                   " AND nmll002 = '",g_user,"')"
#            #160122-00001#27--add---end
            #160122-00001#27 by 07673 mark --end 
            #160122-00001#27 by 07673 add -str
            LET g_qryparam.where = " nmas002 IN (",g_sql_bank,")"
            #160122-00001#27 by 07673 add -end
            CALL q_nmas002_10()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmck045  #顯示到畫面上
            LET g_qryparam.where = " "             #160122-00001#27
            NEXT FIELD nmck045                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck045
            #add-point:BEFORE FIELD nmck045 name="construct.b.nmck045"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck045
            
            #add-point:AFTER FIELD nmck045 name="construct.a.nmck045"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmck047
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck047
            #add-point:ON ACTION controlp INFIELD nmck047 name="construct.c.nmck047"
            #應用 a08 樣板自動產生(Version:1)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " nmaj002 = '1'"
            CALL q_nmaj001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmck047  #顯示到畫面上
            NEXT FIELD nmck047                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck047
            #add-point:BEFORE FIELD nmck047 name="construct.b.nmck047"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck047
            
            #add-point:AFTER FIELD nmck047 name="construct.a.nmck047"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmck048
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck048
            #add-point:ON ACTION controlp INFIELD nmck048 name="construct.c.nmck048"
            #應用 a08 樣板自動產生(Version:1)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " nmaj002 = '2'"
            CALL q_nmaj001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmck048  #顯示到畫面上
            NEXT FIELD nmck048                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck048
            #add-point:BEFORE FIELD nmck048 name="construct.b.nmck048"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck048
            
            #add-point:AFTER FIELD nmck048 name="construct.a.nmck048"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmck049
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck049
            #add-point:ON ACTION controlp INFIELD nmck049 name="construct.c.nmck049"
            #應用 a08 樣板自動產生(Version:1)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_nmai002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmck049  #顯示到畫面上
            NEXT FIELD nmck049                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck049
            #add-point:BEFORE FIELD nmck049 name="construct.b.nmck049"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck049
            
            #add-point:AFTER FIELD nmck049 name="construct.a.nmck049"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmck050
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck050
            #add-point:ON ACTION controlp INFIELD nmck050 name="construct.c.nmck050"
            #應用 a08 樣板自動產生(Version:1)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_nmai002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmck050  #顯示到畫面上
            NEXT FIELD nmck050                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck050
            #add-point:BEFORE FIELD nmck050 name="construct.b.nmck050"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck050
            
            #add-point:AFTER FIELD nmck050 name="construct.a.nmck050"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmck051
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck051
            #add-point:ON ACTION controlp INFIELD nmck051 name="construct.c.nmck051"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            #160524-00055#1 add s---
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " nmba003 IN('anmt440')"
            CALL q_nmbadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmck051  #顯示到畫面上
            NEXT FIELD nmck051                     #返回原欄位
            #160524-00055#1 add e---



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck051
            #add-point:BEFORE FIELD nmck051 name="construct.b.nmck051"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck051
            
            #add-point:AFTER FIELD nmck051 name="construct.a.nmck051"
            
            #END add-point
            
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON nmclseq,nmclorga,nmclorga_desc,nmcl001,nmcl002,nmcl003,nmcl003_desc, 
          nmcl103,nmcl113,nmcl121,nmcl123,nmcl131,nmcl133
           FROM s_detail1[1].nmclseq,s_detail1[1].nmclorga,s_detail1[1].nmclorga_desc,s_detail1[1].nmcl001, 
               s_detail1[1].nmcl002,s_detail1[1].nmcl003,s_detail1[1].nmcl003_desc,s_detail1[1].nmcl103, 
               s_detail1[1].nmcl113,s_detail1[1].nmcl121,s_detail1[1].nmcl123,s_detail1[1].nmcl131,s_detail1[1].nmcl133 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmclseq
            #add-point:BEFORE FIELD nmclseq name="construct.b.page1.nmclseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmclseq
            
            #add-point:AFTER FIELD nmclseq name="construct.a.page1.nmclseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmclseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmclseq
            #add-point:ON ACTION controlp INFIELD nmclseq name="construct.c.page1.nmclseq"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.nmclorga
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmclorga
            #add-point:ON ACTION controlp INFIELD nmclorga name="construct.c.page1.nmclorga"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #LET g_qryparam.where = " ooef206 = 'Y'"  #150714-00024#1     #160816-00012#3 mark
            CALL s_axrt300_get_site(g_user,'','1') RETURNING l_orga_str   #160816-00012#3 add
            #LET g_qryparam.where = " ooef206 = 'Y' AND ",l_orga_str      #160816-00012#3 add #161021-00050#8 mark
            LET g_qryparam.where = " ooef201 = 'Y' AND ",l_orga_str       #161021-00050#8
            CALL q_ooef001()
            DISPLAY g_qryparam.return1 TO nmclorga
            NEXT FIELD nmclorga
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmclorga
            #add-point:BEFORE FIELD nmclorga name="construct.b.page1.nmclorga"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmclorga
            
            #add-point:AFTER FIELD nmclorga name="construct.a.page1.nmclorga"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmclorga_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmclorga_desc
            #add-point:ON ACTION controlp INFIELD nmclorga_desc name="construct.c.page1.nmclorga_desc"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL s_axrt300_get_site(g_user,'','1') RETURNING l_orga_str   #160816-00012#3 add
            #LET g_qryparam.where = " ooef206 = 'Y'"  #150714-00024#1     #160816-00012#3 mark
            #LET g_qryparam.where = " ooef206 = 'Y' AND ",l_orga_str      #160816-00012#3 add #161021-00050#8 mark
            LET g_qryparam.where = " ooef201 = 'Y' AND ",l_orga_str       #161021-00050#8
            CALL q_ooef001()
            DISPLAY g_qryparam.return1 TO nmclorga_desc
            NEXT FIELD nmclorga_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmclorga_desc
            #add-point:BEFORE FIELD nmclorga_desc name="construct.b.page1.nmclorga_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmclorga_desc
            
            #add-point:AFTER FIELD nmclorga_desc name="construct.a.page1.nmclorga_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmcl001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmcl001
            #add-point:ON ACTION controlp INFIELD nmcl001 name="construct.c.page1.nmcl001"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_apdadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmcl001  #顯示到畫面上
            NEXT FIELD nmcl001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmcl001
            #add-point:BEFORE FIELD nmcl001 name="construct.b.page1.nmcl001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmcl001
            
            #add-point:AFTER FIELD nmcl001 name="construct.a.page1.nmcl001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmcl002
            #add-point:BEFORE FIELD nmcl002 name="construct.b.page1.nmcl002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmcl002
            
            #add-point:AFTER FIELD nmcl002 name="construct.a.page1.nmcl002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmcl002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmcl002
            #add-point:ON ACTION controlp INFIELD nmcl002 name="construct.c.page1.nmcl002"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_apdeseq()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmcl002  #顯示到畫面上
            NEXT FIELD nmcl002                     #返回原欄位
    


            #END add-point
 
 
         #Ctrlp:construct.c.page1.nmcl003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmcl003
            #add-point:ON ACTION controlp INFIELD nmcl003 name="construct.c.page1.nmcl003"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL aglt310_04()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmcl003  #顯示到畫面上
            NEXT FIELD nmcl003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmcl003
            #add-point:BEFORE FIELD nmcl003 name="construct.b.page1.nmcl003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmcl003
            
            #add-point:AFTER FIELD nmcl003 name="construct.a.page1.nmcl003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmcl003_desc
            #add-point:BEFORE FIELD nmcl003_desc name="construct.b.page1.nmcl003_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmcl003_desc
            
            #add-point:AFTER FIELD nmcl003_desc name="construct.a.page1.nmcl003_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmcl003_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmcl003_desc
            #add-point:ON ACTION controlp INFIELD nmcl003_desc name="construct.c.page1.nmcl003_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmcl103
            #add-point:BEFORE FIELD nmcl103 name="construct.b.page1.nmcl103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmcl103
            
            #add-point:AFTER FIELD nmcl103 name="construct.a.page1.nmcl103"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmcl103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmcl103
            #add-point:ON ACTION controlp INFIELD nmcl103 name="construct.c.page1.nmcl103"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmcl113
            #add-point:BEFORE FIELD nmcl113 name="construct.b.page1.nmcl113"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmcl113
            
            #add-point:AFTER FIELD nmcl113 name="construct.a.page1.nmcl113"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmcl113
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmcl113
            #add-point:ON ACTION controlp INFIELD nmcl113 name="construct.c.page1.nmcl113"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmcl121
            #add-point:BEFORE FIELD nmcl121 name="construct.b.page1.nmcl121"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmcl121
            
            #add-point:AFTER FIELD nmcl121 name="construct.a.page1.nmcl121"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmcl121
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmcl121
            #add-point:ON ACTION controlp INFIELD nmcl121 name="construct.c.page1.nmcl121"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmcl123
            #add-point:BEFORE FIELD nmcl123 name="construct.b.page1.nmcl123"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmcl123
            
            #add-point:AFTER FIELD nmcl123 name="construct.a.page1.nmcl123"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmcl123
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmcl123
            #add-point:ON ACTION controlp INFIELD nmcl123 name="construct.c.page1.nmcl123"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmcl131
            #add-point:BEFORE FIELD nmcl131 name="construct.b.page1.nmcl131"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmcl131
            
            #add-point:AFTER FIELD nmcl131 name="construct.a.page1.nmcl131"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmcl131
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmcl131
            #add-point:ON ACTION controlp INFIELD nmcl131 name="construct.c.page1.nmcl131"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmcl133
            #add-point:BEFORE FIELD nmcl133 name="construct.b.page1.nmcl133"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmcl133
            
            #add-point:AFTER FIELD nmcl133 name="construct.a.page1.nmcl133"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmcl133
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmcl133
            #add-point:ON ACTION controlp INFIELD nmcl133 name="construct.c.page1.nmcl133"
            
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
                  WHEN la_wc[li_idx].tableid = "nmck_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "nmcl_t" 
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
#   LET g_wc2=g_wc_source
   #161104-00046#13-----s
   IF cl_null(g_user_dept_wc)THEN
      LET g_user_dept_wc = ' 1=1'
   END IF
   IF g_user_dept_wc <>  " 1=1" THEN
      LET g_wc = g_wc ," AND ", g_user_dept_wc CLIPPED
   END IF   
   #161104-00046#13-----e
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="anmt440.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION anmt440_query()
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
   CALL g_nmcl_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL anmt440_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL anmt440_browser_fill("")
      CALL anmt440_fetch("")
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
   CALL anmt440_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL anmt440_fetch("F") 
      #顯示單身筆數
      CALL anmt440_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="anmt440.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION anmt440_fetch(p_flag)
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
   
   LET g_nmck_m.nmckcomp = g_browser[g_current_idx].b_nmckcomp
   LET g_nmck_m.nmckdocno = g_browser[g_current_idx].b_nmckdocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE anmt440_master_referesh USING g_nmck_m.nmckcomp,g_nmck_m.nmckdocno INTO g_nmck_m.nmcksite, 
       g_nmck_m.nmckcomp,g_nmck_m.nmck003,g_nmck_m.nmckdocno,g_nmck_m.nmck002,g_nmck_m.nmckdocdt,g_nmck_m.nmck004, 
       g_nmck_m.nmck019,g_nmck_m.nmckstus,g_nmck_m.nmckownid,g_nmck_m.nmckowndp,g_nmck_m.nmckcrtid,g_nmck_m.nmckcrtdp, 
       g_nmck_m.nmckcrtdt,g_nmck_m.nmckmodid,g_nmck_m.nmckmoddt,g_nmck_m.nmckcnfid,g_nmck_m.nmckcnfdt, 
       g_nmck_m.nmck001,g_nmck_m.nmck100,g_nmck_m.nmck103,g_nmck_m.nmck101,g_nmck_m.nmck113,g_nmck_m.nmck121, 
       g_nmck_m.nmck123,g_nmck_m.nmck131,g_nmck_m.nmck133,g_nmck_m.nmck034,g_nmck_m.nmck035,g_nmck_m.nmck022, 
       g_nmck_m.nmck036,g_nmck_m.nmck023,g_nmck_m.nmck011,g_nmck_m.nmck009,g_nmck_m.nmck010,g_nmck_m.nmck024, 
       g_nmck_m.nmck027,g_nmck_m.nmck025,g_nmck_m.nmck026,g_nmck_m.nmck114,g_nmck_m.nmck124,g_nmck_m.nmck134, 
       g_nmck_m.nmck005,g_nmck_m.nmck006,g_nmck_m.nmck015,g_nmck_m.nmck046,g_nmck_m.nmck030,g_nmck_m.nmck031, 
       g_nmck_m.nmck028,g_nmck_m.nmck029,g_nmck_m.nmck032,g_nmck_m.nmck044,g_nmck_m.nmck045,g_nmck_m.nmck047, 
       g_nmck_m.nmck048,g_nmck_m.nmck049,g_nmck_m.nmck050,g_nmck_m.nmck051,g_nmck_m.nmcksite_desc,g_nmck_m.nmckcomp_desc, 
       g_nmck_m.nmck003_desc,g_nmck_m.nmck004_desc,g_nmck_m.nmckownid_desc,g_nmck_m.nmckowndp_desc,g_nmck_m.nmckcrtid_desc, 
       g_nmck_m.nmckcrtdp_desc,g_nmck_m.nmckmodid_desc,g_nmck_m.nmckcnfid_desc,g_nmck_m.nmck009_desc, 
       g_nmck_m.nmck005_desc,g_nmck_m.nmck032_desc,g_nmck_m.nmck044_desc,g_nmck_m.nmck045_desc,g_nmck_m.nmck047_desc, 
       g_nmck_m.nmck048_desc,g_nmck_m.nmck049_desc,g_nmck_m.nmck050_desc
   
   #遮罩相關處理
   LET g_nmck_m_mask_o.* =  g_nmck_m.*
   CALL anmt440_nmck_t_mask()
   LET g_nmck_m_mask_n.* =  g_nmck_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL anmt440_set_act_visible()   
   CALL anmt440_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
#   LET g_nmckcomp=g_nmck_m.nmckcomp
#   LET g_nmckdocno=g_nmck_m.nmckdocno
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_nmck_m_t.* = g_nmck_m.*
   LET g_nmck_m_o.* = g_nmck_m.*
   
   LET g_data_owner = g_nmck_m.nmckownid      
   LET g_data_dept  = g_nmck_m.nmckowndp
   
   #重新顯示   
   CALL anmt440_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="anmt440.insert" >}
#+ 資料新增
PRIVATE FUNCTION anmt440_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   DEFINE l_ooef003      LIKE ooef_t.ooef003
   DEFINE l_ooag004      LIKE ooag_t.ooag004
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_nmcl_d.clear()   
 
 
   INITIALIZE g_nmck_m.* TO NULL             #DEFAULT 設定
   
   LET g_nmckcomp_t = NULL
   LET g_nmckdocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_nmck_m.nmckownid = g_user
      LET g_nmck_m.nmckowndp = g_dept
      LET g_nmck_m.nmckcrtid = g_user
      LET g_nmck_m.nmckcrtdp = g_dept 
      LET g_nmck_m.nmckcrtdt = cl_get_current()
      LET g_nmck_m.nmckmodid = g_user
      LET g_nmck_m.nmckmoddt = cl_get_current()
      LET g_nmck_m.nmckstus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_nmck_m.nmckstus = "N"
      LET g_nmck_m.nmck001 = "AP"
      LET g_nmck_m.nmck034 = "2"
      LET g_nmck_m.nmck027 = "Y"
      LET g_nmck_m.nmck031 = "0"
      LET g_nmck_m.nmck028 = "0"
      LET g_nmck_m.nmck029 = "0"
 
  
      #add-point:單頭預設值 name="insert.default"
      LET g_nmck_m.nmck026 = "1"
      #161019-00001#1 Add  ---(S)---
      LET g_nmck_m.nmck103 = 0
      LET g_nmck_m.nmck113 = 0
      #161019-00001#1 Add  ---(E)---
      LET g_nmck_m_t.* = g_nmck_m.*
      LET g_nmck_m.nmck001 = 'XX'
      
      #150714-00024#1 add ------
      #取得預設的資金中心,因新增階段的時候,並不會知道site,所以以登入人員做為依據
      CALL s_fin_get_account_center('',g_user,'6',g_today) RETURNING g_sub_success,g_nmck_m.nmcksite,g_errno
      CALL s_anm_get_comp_wc('6',g_nmck_m.nmcksite,g_nmck_m.nmckdocdt) RETURNING g_comp_wc
      CALL anmt440_nmcksite_desc()
      SELECT ooef017 INTO g_nmck_m.nmckcomp
        FROM ooef_t
       WHERE ooefent = g_enterprise
         AND ooef001 = g_nmck_m.nmcksite
      #CALL s_anm_get_site_wc('6',g_nmck_m.nmckcomp,g_nmck_m.nmckdocdt) RETURNING g_site_wc #160912-00024#1 mark
      CALL s_anm_get_site_wc('6',g_nmck_m.nmcksite,g_nmck_m.nmckdocdt) RETURNING g_site_wc  #160912-00024#1 add
      #150714-00024#1 add end---
      
      #150714-00024#1 mark ------
      ##判斷g_SITE是否為"法人", 若為法人者可直接作為預設值，非法人者，依g_user判別。
      ##為登入人員g_user之所屬營運據點 歸屬法人
      #SELECT ooef003 INTO l_ooef003
      #  FROM ooef_t
      # WHERE ooefent = g_enterprise
      #   AND ooef001 = g_site
      #IF l_ooef003 = 'Y' THEN 
      #   LET g_nmck_m.nmckcomp = g_site
      #ELSE
      #   SELECT ooag004 INTO l_ooag004
      #     FROM ooag_t
      #    WHERE ooagent = g_enterprise
      #      AND ooag001 = g_user
      #   SELECT ooef017 INTO g_nmck_m.nmckcomp
      #     FROM ooef_t
      #    WHERE ooefent = g_enterprise
      #      AND ooef001 = l_ooag004
      #END IF
      #150714-00024#1 mark end---
      
      LET g_nmck_m.nmck003 = g_user
      LET g_nmck_m.nmckdocdt = g_today
      CALL anmt440_nmck003_desc()
      CALL anmt440_nmckcomp_desc()
      CALL anmt440_nmck026_scc('1')
#      LET g_nmckcomp_o = NULL
#      LET g_nmckdocno_o = NULL
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_nmck_m_t.* = g_nmck_m.*
      LET g_nmck_m_o.* = g_nmck_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_nmck_m.nmckstus 
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
 
 
 
    
      CALL anmt440_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      CALL anmt440_nmck026_scc('2')
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
         INITIALIZE g_nmck_m.* TO NULL
         INITIALIZE g_nmcl_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL anmt440_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_nmcl_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL anmt440_set_act_visible()   
   CALL anmt440_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_nmckcomp_t = g_nmck_m.nmckcomp
   LET g_nmckdocno_t = g_nmck_m.nmckdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " nmckent = " ||g_enterprise|| " AND",
                      " nmckcomp = '", g_nmck_m.nmckcomp, "' "
                      ," AND nmckdocno = '", g_nmck_m.nmckdocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL anmt440_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE anmt440_cl
   
   CALL anmt440_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE anmt440_master_referesh USING g_nmck_m.nmckcomp,g_nmck_m.nmckdocno INTO g_nmck_m.nmcksite, 
       g_nmck_m.nmckcomp,g_nmck_m.nmck003,g_nmck_m.nmckdocno,g_nmck_m.nmck002,g_nmck_m.nmckdocdt,g_nmck_m.nmck004, 
       g_nmck_m.nmck019,g_nmck_m.nmckstus,g_nmck_m.nmckownid,g_nmck_m.nmckowndp,g_nmck_m.nmckcrtid,g_nmck_m.nmckcrtdp, 
       g_nmck_m.nmckcrtdt,g_nmck_m.nmckmodid,g_nmck_m.nmckmoddt,g_nmck_m.nmckcnfid,g_nmck_m.nmckcnfdt, 
       g_nmck_m.nmck001,g_nmck_m.nmck100,g_nmck_m.nmck103,g_nmck_m.nmck101,g_nmck_m.nmck113,g_nmck_m.nmck121, 
       g_nmck_m.nmck123,g_nmck_m.nmck131,g_nmck_m.nmck133,g_nmck_m.nmck034,g_nmck_m.nmck035,g_nmck_m.nmck022, 
       g_nmck_m.nmck036,g_nmck_m.nmck023,g_nmck_m.nmck011,g_nmck_m.nmck009,g_nmck_m.nmck010,g_nmck_m.nmck024, 
       g_nmck_m.nmck027,g_nmck_m.nmck025,g_nmck_m.nmck026,g_nmck_m.nmck114,g_nmck_m.nmck124,g_nmck_m.nmck134, 
       g_nmck_m.nmck005,g_nmck_m.nmck006,g_nmck_m.nmck015,g_nmck_m.nmck046,g_nmck_m.nmck030,g_nmck_m.nmck031, 
       g_nmck_m.nmck028,g_nmck_m.nmck029,g_nmck_m.nmck032,g_nmck_m.nmck044,g_nmck_m.nmck045,g_nmck_m.nmck047, 
       g_nmck_m.nmck048,g_nmck_m.nmck049,g_nmck_m.nmck050,g_nmck_m.nmck051,g_nmck_m.nmcksite_desc,g_nmck_m.nmckcomp_desc, 
       g_nmck_m.nmck003_desc,g_nmck_m.nmck004_desc,g_nmck_m.nmckownid_desc,g_nmck_m.nmckowndp_desc,g_nmck_m.nmckcrtid_desc, 
       g_nmck_m.nmckcrtdp_desc,g_nmck_m.nmckmodid_desc,g_nmck_m.nmckcnfid_desc,g_nmck_m.nmck009_desc, 
       g_nmck_m.nmck005_desc,g_nmck_m.nmck032_desc,g_nmck_m.nmck044_desc,g_nmck_m.nmck045_desc,g_nmck_m.nmck047_desc, 
       g_nmck_m.nmck048_desc,g_nmck_m.nmck049_desc,g_nmck_m.nmck050_desc
   
   
   #遮罩相關處理
   LET g_nmck_m_mask_o.* =  g_nmck_m.*
   CALL anmt440_nmck_t_mask()
   LET g_nmck_m_mask_n.* =  g_nmck_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_nmck_m.nmcksite,g_nmck_m.nmcksite_desc,g_nmck_m.nmckcomp,g_nmck_m.nmckcomp_desc, 
       g_nmck_m.nmck003,g_nmck_m.nmck003_desc,g_nmck_m.nmckdocno,g_nmck_m.nmck002,g_nmck_m.nmckdocdt, 
       g_nmck_m.nmck004,g_nmck_m.nmck004_desc,g_nmck_m.nmas003,g_nmck_m.nmck019,g_nmck_m.nmckstus,g_nmck_m.nmckownid, 
       g_nmck_m.nmckownid_desc,g_nmck_m.nmckowndp,g_nmck_m.nmckowndp_desc,g_nmck_m.nmckcrtid,g_nmck_m.nmckcrtid_desc, 
       g_nmck_m.nmckcrtdp,g_nmck_m.nmckcrtdp_desc,g_nmck_m.nmckcrtdt,g_nmck_m.nmckmodid,g_nmck_m.nmckmodid_desc, 
       g_nmck_m.nmckmoddt,g_nmck_m.nmckcnfid,g_nmck_m.nmckcnfid_desc,g_nmck_m.nmckcnfdt,g_nmck_m.nmck001, 
       g_nmck_m.nmck100,g_nmck_m.nmck103,g_nmck_m.nmck101,g_nmck_m.nmck113,g_nmck_m.nmck121,g_nmck_m.nmck123, 
       g_nmck_m.nmck131,g_nmck_m.nmck133,g_nmck_m.nmck034,g_nmck_m.nmck035,g_nmck_m.nmck022,g_nmck_m.nmck022_desc, 
       g_nmck_m.nmck036,g_nmck_m.nmck023,g_nmck_m.nmck011,g_nmck_m.nmck009,g_nmck_m.nmck009_desc,g_nmck_m.nmck010, 
       g_nmck_m.nmck010_desc,g_nmck_m.nmck024,g_nmck_m.nmck027,g_nmck_m.nmck025,g_nmck_m.nmck026,g_nmck_m.nmck114, 
       g_nmck_m.nmck124,g_nmck_m.nmck134,g_nmck_m.nmck005,g_nmck_m.nmck005_desc,g_nmck_m.nmck006,g_nmck_m.nmck006_desc, 
       g_nmck_m.nmck015,g_nmck_m.nmck046,g_nmck_m.nmck030,g_nmck_m.nmck031,g_nmck_m.nmck028,g_nmck_m.nmck029, 
       g_nmck_m.nmck032,g_nmck_m.nmck032_desc,g_nmck_m.nmck044,g_nmck_m.nmck044_desc,g_nmck_m.nmck045, 
       g_nmck_m.nmck045_desc,g_nmck_m.nmck047,g_nmck_m.nmck047_desc,g_nmck_m.nmck048,g_nmck_m.nmck048_desc, 
       g_nmck_m.nmck049,g_nmck_m.nmck049_desc,g_nmck_m.nmck050,g_nmck_m.nmck050_desc,g_nmck_m.nmck051 
 
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_nmck_m.nmckownid      
   LET g_data_dept  = g_nmck_m.nmckowndp
   
   #功能已完成,通報訊息中心
   CALL anmt440_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="anmt440.modify" >}
#+ 資料修改
PRIVATE FUNCTION anmt440_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point    
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   DEFINE l_wc2_table1          STRING
 
 
   #add-point:modify段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   #150813-00015#5--add--str--
   DEFINE l_success   LIKE type_t.num5  
   DEFINE l_slip      LIKE type_t.chr10
   DEFINE l_dfin0033  LIKE type_t.chr80
   DEFINE l_para_date LIKE type_t.dat
   #150813-00015#5--add--end  
   #end add-point    
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   #保存單頭舊值
   LET g_nmck_m_t.* = g_nmck_m.*
   LET g_nmck_m_o.* = g_nmck_m.*
   
   IF g_nmck_m.nmckcomp IS NULL
   OR g_nmck_m.nmckdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_nmckcomp_t = g_nmck_m.nmckcomp
   LET g_nmckdocno_t = g_nmck_m.nmckdocno
 
   CALL s_transaction_begin()
   
   OPEN anmt440_cl USING g_enterprise,g_nmck_m.nmckcomp,g_nmck_m.nmckdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN anmt440_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE anmt440_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE anmt440_master_referesh USING g_nmck_m.nmckcomp,g_nmck_m.nmckdocno INTO g_nmck_m.nmcksite, 
       g_nmck_m.nmckcomp,g_nmck_m.nmck003,g_nmck_m.nmckdocno,g_nmck_m.nmck002,g_nmck_m.nmckdocdt,g_nmck_m.nmck004, 
       g_nmck_m.nmck019,g_nmck_m.nmckstus,g_nmck_m.nmckownid,g_nmck_m.nmckowndp,g_nmck_m.nmckcrtid,g_nmck_m.nmckcrtdp, 
       g_nmck_m.nmckcrtdt,g_nmck_m.nmckmodid,g_nmck_m.nmckmoddt,g_nmck_m.nmckcnfid,g_nmck_m.nmckcnfdt, 
       g_nmck_m.nmck001,g_nmck_m.nmck100,g_nmck_m.nmck103,g_nmck_m.nmck101,g_nmck_m.nmck113,g_nmck_m.nmck121, 
       g_nmck_m.nmck123,g_nmck_m.nmck131,g_nmck_m.nmck133,g_nmck_m.nmck034,g_nmck_m.nmck035,g_nmck_m.nmck022, 
       g_nmck_m.nmck036,g_nmck_m.nmck023,g_nmck_m.nmck011,g_nmck_m.nmck009,g_nmck_m.nmck010,g_nmck_m.nmck024, 
       g_nmck_m.nmck027,g_nmck_m.nmck025,g_nmck_m.nmck026,g_nmck_m.nmck114,g_nmck_m.nmck124,g_nmck_m.nmck134, 
       g_nmck_m.nmck005,g_nmck_m.nmck006,g_nmck_m.nmck015,g_nmck_m.nmck046,g_nmck_m.nmck030,g_nmck_m.nmck031, 
       g_nmck_m.nmck028,g_nmck_m.nmck029,g_nmck_m.nmck032,g_nmck_m.nmck044,g_nmck_m.nmck045,g_nmck_m.nmck047, 
       g_nmck_m.nmck048,g_nmck_m.nmck049,g_nmck_m.nmck050,g_nmck_m.nmck051,g_nmck_m.nmcksite_desc,g_nmck_m.nmckcomp_desc, 
       g_nmck_m.nmck003_desc,g_nmck_m.nmck004_desc,g_nmck_m.nmckownid_desc,g_nmck_m.nmckowndp_desc,g_nmck_m.nmckcrtid_desc, 
       g_nmck_m.nmckcrtdp_desc,g_nmck_m.nmckmodid_desc,g_nmck_m.nmckcnfid_desc,g_nmck_m.nmck009_desc, 
       g_nmck_m.nmck005_desc,g_nmck_m.nmck032_desc,g_nmck_m.nmck044_desc,g_nmck_m.nmck045_desc,g_nmck_m.nmck047_desc, 
       g_nmck_m.nmck048_desc,g_nmck_m.nmck049_desc,g_nmck_m.nmck050_desc
   
   #檢查是否允許此動作
   IF NOT anmt440_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_nmck_m_mask_o.* =  g_nmck_m.*
   CALL anmt440_nmck_t_mask()
   LET g_nmck_m_mask_n.* =  g_nmck_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
 
   
   CALL anmt440_show()
   #add-point:modify段show之後 name="modify.after_show"
   #150813-00015#5--add--str--
   IF g_nmck_m.nmckstus <> 'N' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'agl-00313'
      LET g_errparam.extend = 'modify'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CLOSE anmt440_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF 
   #获取单别
   CALL s_aooi200_fin_get_slip(g_nmck_m.nmckdocno) RETURNING l_success,l_slip
   #是否可改日期
   CALL s_fin_get_doc_para(g_glaald,g_nmck_m.nmckcomp,l_slip,'D-FIN-0033') RETURNING l_dfin0033
   IF l_dfin0033 = 'N' THEN
      #檢查當單據日期小於等於關帳日期時，不可異動單據
      CALL s_fin_date_close_chk('',g_nmck_m.nmckcomp,'ANM',g_nmck_m.nmckdocdt) RETURNING l_success
      IF l_success = FALSE THEN
         CLOSE anmt440_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
   END IF
   #150813-00015#5--add--end
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
 
    
   WHILE TRUE
      LET g_nmckcomp_t = g_nmck_m.nmckcomp
      LET g_nmckdocno_t = g_nmck_m.nmckdocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_nmck_m.nmckmodid = g_user 
LET g_nmck_m.nmckmoddt = cl_get_current()
LET g_nmck_m.nmckmodid_desc = cl_get_username(g_nmck_m.nmckmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      #當票況=0時才可異動
      IF g_nmck_m.nmck026 <> '0' AND g_nmck_m.nmck026 <> '1' AND g_nmck_m.nmck026 <> '2' THEN  #160413-00001#1 add <>2
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'anm-00162'
         LET g_errparam.extend = ''
         LET g_errparam.popup = FALSE
         CALL cl_err()

         EXIT WHILE
      END IF
#      LET g_nmckcomp_o = g_nmckcomp_t
#      LET g_nmckdocno_o = g_nmckdocno_t
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL anmt440_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      IF NOT INT_FLAG THEN
         #若單頭key欄位有變更
         IF g_nmck_m.nmckcomp != g_nmckcomp_t 
         OR g_nmck_m.nmckdocno != g_nmckdocno_t 
         
         THEN
            CALL s_transaction_begin()
            #更新單身key值
            UPDATE nmcl_t SET nmclcomp = g_nmck_m.nmckcomp,
                              nmcldocno = g_nmck_m.nmckdocno
         
             WHERE nmclent = g_enterprise AND nmclcomp = g_nmckcomp_t
               AND nmcldocno = g_nmckdocno_t
            CASE
               WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "std-00009"
                  LET g_errparam.extend = "nmcl_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL s_transaction_end('N','0')
                  CONTINUE WHILE
               WHEN SQLCA.sqlcode #其他錯誤
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "nmcl_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
  
                  CALL s_transaction_end('N','0')
                  CONTINUE WHILE
            END CASE
         END IF
      END IF
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE nmck_t SET (nmckmodid,nmckmoddt) = (g_nmck_m.nmckmodid,g_nmck_m.nmckmoddt)
          WHERE nmckent = g_enterprise AND nmckcomp = g_nmckcomp_t
            AND nmckdocno = g_nmckdocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_nmck_m.* = g_nmck_m_t.*
            CALL anmt440_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_nmck_m.nmckcomp != g_nmck_m_t.nmckcomp
      OR g_nmck_m.nmckdocno != g_nmck_m_t.nmckdocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE nmcl_t SET nmclcomp = g_nmck_m.nmckcomp
                                       ,nmcldocno = g_nmck_m.nmckdocno
 
          WHERE nmclent = g_enterprise AND nmclcomp = g_nmck_m_t.nmckcomp
            AND nmcldocno = g_nmck_m_t.nmckdocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "nmcl_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "nmcl_t:",SQLERRMESSAGE 
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
   CALL anmt440_set_act_visible()   
   CALL anmt440_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " nmckent = " ||g_enterprise|| " AND",
                      " nmckcomp = '", g_nmck_m.nmckcomp, "' "
                      ," AND nmckdocno = '", g_nmck_m.nmckdocno, "' "
 
   #填到對應位置
   CALL anmt440_browser_fill("")
 
   CLOSE anmt440_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL anmt440_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="anmt440.input" >}
#+ 資料輸入
PRIVATE FUNCTION anmt440_input(p_cmd)
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
   DEFINE l_success              LIKE type_t.num5
   DEFINE l_pmaa027              LIKE pmaa_t.pmaa027
   DEFINE l_pmaa004              LIKE pmaa_t.pmaa004
   DEFINE l_nmcl103              LIKE nmcl_t.nmcl103
   DEFINE l_nmcl113              LIKE nmcl_t.nmcl113 #150714-00024#1
   DEFINE l_nmaf006              LIKE nmaf_t.nmaf006
   DEFINE l_nmaf007              LIKE nmaf_t.nmaf007
   DEFINE l_nmaf010              LIKE nmaf_t.nmaf010
   DEFINE l_nmaf011              LIKE nmaf_t.nmaf011
   DEFINE l_ooag004              LIKE ooag_t.ooag004
   DEFINE l_nmaa003              LIKE nmaa_t.nmaa003
   DEFINE l_nmag002              LIKE nmag_t.nmag002    
   DEFINE l_glaald               LIKE glaa_t.glaald
   DEFINE l_exrate               LIKE ooan_t.ooan005
   DEFINE l_glaa004              LIKE glaa_t.glaa004
   DEFINE l_origin_str           STRING               #2015/01/27---add---by---qiull
   DEFINE l_flag                 LIKE type_t.chr1     #151029-00001#5 add lujh
   DEFINE l_apeb006              LIKE apeb_t.apeb006  #151029-00001#5 add lujh
   #160616-00026#1--add--str--
   DEFINE l_sql      STRING
   DEFINE l_str      STRING
   DEFINE l_gzcb002  LIKE gzcb_t.gzcb002
   DEFINE l_wc       STRING #160816-00012#3
   #160616-00026#1--add--end
   DEFINE l_nmck029  LIKE nmck_t.nmck029 #161114-00030#1 add
   DEFINE l_flag1                LIKE type_t.num5     #161104-00046#13 單別預設值用
   DEFINE l_slip                 LIKE ooba_t.ooba002  #161104-00046#13
   LET l_cmd_t = p_cmd 
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
   DISPLAY BY NAME g_nmck_m.nmcksite,g_nmck_m.nmcksite_desc,g_nmck_m.nmckcomp,g_nmck_m.nmckcomp_desc, 
       g_nmck_m.nmck003,g_nmck_m.nmck003_desc,g_nmck_m.nmckdocno,g_nmck_m.nmck002,g_nmck_m.nmckdocdt, 
       g_nmck_m.nmck004,g_nmck_m.nmck004_desc,g_nmck_m.nmas003,g_nmck_m.nmck019,g_nmck_m.nmckstus,g_nmck_m.nmckownid, 
       g_nmck_m.nmckownid_desc,g_nmck_m.nmckowndp,g_nmck_m.nmckowndp_desc,g_nmck_m.nmckcrtid,g_nmck_m.nmckcrtid_desc, 
       g_nmck_m.nmckcrtdp,g_nmck_m.nmckcrtdp_desc,g_nmck_m.nmckcrtdt,g_nmck_m.nmckmodid,g_nmck_m.nmckmodid_desc, 
       g_nmck_m.nmckmoddt,g_nmck_m.nmckcnfid,g_nmck_m.nmckcnfid_desc,g_nmck_m.nmckcnfdt,g_nmck_m.nmck001, 
       g_nmck_m.nmck100,g_nmck_m.nmck103,g_nmck_m.nmck101,g_nmck_m.nmck113,g_nmck_m.nmck121,g_nmck_m.nmck123, 
       g_nmck_m.nmck131,g_nmck_m.nmck133,g_nmck_m.nmck034,g_nmck_m.nmck035,g_nmck_m.nmck022,g_nmck_m.nmck022_desc, 
       g_nmck_m.nmck036,g_nmck_m.nmck023,g_nmck_m.nmck011,g_nmck_m.nmck009,g_nmck_m.nmck009_desc,g_nmck_m.nmck010, 
       g_nmck_m.nmck010_desc,g_nmck_m.nmck024,g_nmck_m.nmck027,g_nmck_m.nmck025,g_nmck_m.nmck026,g_nmck_m.nmck114, 
       g_nmck_m.nmck124,g_nmck_m.nmck134,g_nmck_m.nmck005,g_nmck_m.nmck005_desc,g_nmck_m.nmck006,g_nmck_m.nmck006_desc, 
       g_nmck_m.nmck015,g_nmck_m.nmck046,g_nmck_m.nmck030,g_nmck_m.nmck031,g_nmck_m.nmck028,g_nmck_m.nmck029, 
       g_nmck_m.nmck032,g_nmck_m.nmck032_desc,g_nmck_m.nmck044,g_nmck_m.nmck044_desc,g_nmck_m.nmck045, 
       g_nmck_m.nmck045_desc,g_nmck_m.nmck047,g_nmck_m.nmck047_desc,g_nmck_m.nmck048,g_nmck_m.nmck048_desc, 
       g_nmck_m.nmck049,g_nmck_m.nmck049_desc,g_nmck_m.nmck050,g_nmck_m.nmck050_desc,g_nmck_m.nmck051 
 
   
   #切換畫面
 
   CALL cl_set_head_visible("","YES")  
 
   LET l_insert = FALSE
   LET g_action_choice = ""
 
   #add-point:input段define_sql name="input.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT nmclseq,nmclorga,nmcl001,nmcl002,nmcl003,nmcl103,nmcl113,nmcl121,nmcl123, 
       nmcl131,nmcl133 FROM nmcl_t WHERE nmclent=? AND nmclcomp=? AND nmcldocno=? AND nmclseq=? FOR  
       UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE anmt440_bcl CURSOR FROM g_forupd_sql
   
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL anmt440_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL anmt440_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_nmck_m.nmcksite,g_nmck_m.nmckcomp,g_nmck_m.nmck003,g_nmck_m.nmckdocno,g_nmck_m.nmck002, 
       g_nmck_m.nmckdocdt,g_nmck_m.nmck004,g_nmck_m.nmas003,g_nmck_m.nmck019,g_nmck_m.nmckstus,g_nmck_m.nmck001, 
       g_nmck_m.nmck103,g_nmck_m.nmck101,g_nmck_m.nmck113,g_nmck_m.nmck121,g_nmck_m.nmck123,g_nmck_m.nmck131, 
       g_nmck_m.nmck133,g_nmck_m.nmck034,g_nmck_m.nmck035,g_nmck_m.nmck036,g_nmck_m.nmck011,g_nmck_m.nmck009, 
       g_nmck_m.nmck010,g_nmck_m.nmck024,g_nmck_m.nmck027,g_nmck_m.nmck025,g_nmck_m.nmck026,g_nmck_m.nmck114, 
       g_nmck_m.nmck124,g_nmck_m.nmck134,g_nmck_m.nmck005,g_nmck_m.nmck006,g_nmck_m.nmck015,g_nmck_m.nmck030, 
       g_nmck_m.nmck031,g_nmck_m.nmck028,g_nmck_m.nmck029,g_nmck_m.nmck032,g_nmck_m.nmck044,g_nmck_m.nmck045, 
       g_nmck_m.nmck047,g_nmck_m.nmck048,g_nmck_m.nmck049,g_nmck_m.nmck050,g_nmck_m.nmck051
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   LET g_errshow = 1
#   LET g_detail_insert = cl_auth_detail_input("insert")
#   LET g_detail_delete = cl_auth_detail_input("delete")
   #抓取帳務資料 
   IF NOT cl_null(g_nmck_m.nmckcomp) THEN     
      CALL anmt440_glaa()
   END IF
   
   IF g_nmck_m.nmck001='AP' THEN 
      LET l_allow_insert = FALSE
      LET l_allow_delete = FALSE
   END IF   
   
   #160616-00026#1--add--str--
   IF cl_null(g_nmck_m.nmck001) OR g_nmck_m.nmck001<>'AP' THEN
      LET l_sql = "SELECT gzcb002 FROM gzcb_t WHERE gzcb001 = '8722' AND gzcb002 <> 'AP'"
      PREPARE anmt460_nmck001_prep FROM l_sql
      DECLARE anmt460_nmck001_curs CURSOR FOR anmt460_nmck001_prep
      LET l_str = NULL
      LET l_gzcb002 = NULL
      FOREACH anmt460_nmck001_curs INTO l_gzcb002
         IF cl_null(l_str) THEN 
            LET l_str = l_gzcb002 
            CONTINUE FOREACH 
         END IF
         LET l_str = l_str,",",l_gzcb002
      END FOREACH
      CALL cl_set_combo_scc_part('nmck001','8722',l_str)
   END IF
   #160616-00026#1--add--end
   
   #151029-00001#5--add--str--lujh
   WHILE TRUE
      LET l_flag = 'N'
   #151029-00001#5--add--end--lujh
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="anmt440.input.head" >}
      #單頭段
      INPUT BY NAME g_nmck_m.nmcksite,g_nmck_m.nmckcomp,g_nmck_m.nmck003,g_nmck_m.nmckdocno,g_nmck_m.nmck002, 
          g_nmck_m.nmckdocdt,g_nmck_m.nmck004,g_nmck_m.nmas003,g_nmck_m.nmck019,g_nmck_m.nmckstus,g_nmck_m.nmck001, 
          g_nmck_m.nmck103,g_nmck_m.nmck101,g_nmck_m.nmck113,g_nmck_m.nmck121,g_nmck_m.nmck123,g_nmck_m.nmck131, 
          g_nmck_m.nmck133,g_nmck_m.nmck034,g_nmck_m.nmck035,g_nmck_m.nmck036,g_nmck_m.nmck011,g_nmck_m.nmck009, 
          g_nmck_m.nmck010,g_nmck_m.nmck024,g_nmck_m.nmck027,g_nmck_m.nmck025,g_nmck_m.nmck026,g_nmck_m.nmck114, 
          g_nmck_m.nmck124,g_nmck_m.nmck134,g_nmck_m.nmck005,g_nmck_m.nmck006,g_nmck_m.nmck015,g_nmck_m.nmck030, 
          g_nmck_m.nmck031,g_nmck_m.nmck028,g_nmck_m.nmck029,g_nmck_m.nmck032,g_nmck_m.nmck044,g_nmck_m.nmck045, 
          g_nmck_m.nmck047,g_nmck_m.nmck048,g_nmck_m.nmck049,g_nmck_m.nmck050,g_nmck_m.nmck051 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN anmt440_cl USING g_enterprise,g_nmck_m.nmckcomp,g_nmck_m.nmckdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN anmt440_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE anmt440_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL anmt440_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            IF (cl_null(g_nmck_m.nmck028) OR g_nmck_m.nmck028=0) AND 
               (cl_null(g_nmck_m.nmck029) OR g_nmck_m.nmck029=0) AND 
               cl_null(g_nmck_m.nmck030) THEN
               CALL cl_set_comp_required("nmck032",FALSE)
            ELSE
               CALL cl_set_comp_required("nmck032",TRUE)
            END IF
            IF NOT cl_null(g_nmck_m.nmck002) AND NOT cl_null(g_nmck_m.nmck004) AND NOT cl_null(g_nmck_m.nmck024) THEN
              #170203-00007#1--mark--s--xul
#              #SELECT nmaf004,nmaf010,nmaf011 INTO g_nmck_m.nmck024,l_nmaf010,l_nmaf011  #151008-00014#1 mark
#               SELECT nmaf004,nmaf011 INTO g_nmck_m.nmck024,l_nmaf011  #151008-00014#1
#               FROM nmaf_t
#               WHERE nmafent=g_enterprise AND nmaf001=g_nmck_m.nmck004
#                 AND nmaf002=g_nmck_m.nmck002 AND nmaf010<nmaf007
#                 AND nmaf012='Y'
#               ORDER BY nmaf004
#              #LET g_nmck_m.nmck025=l_nmaf010 #151008-00014#1 mark
#               DISPLAY BY NAME g_nmck_m.nmck024,g_nmck_m.nmck025
              #170203-00007#1--mark--e--xul
              #170203-00007#1--add--s--xul
              SELECT nmaf011 INTO l_nmaf011  
                FROM nmaf_t
               WHERE nmafent=g_enterprise AND nmaf001=g_nmck_m.nmck004
                 AND nmaf002=g_nmck_m.nmck002 AND nmaf010<nmaf007
                 AND nmaf012='Y'
                 AND nmaf004 = g_nmck_m.nmck024
               ORDER BY nmaf004
              #170203-00007#1--add--e--xul
               IF l_nmaf011='N' THEN #套印否
                  CALL cl_set_comp_required("nmck025",TRUE)
               ELSE
                  CALL cl_set_comp_required("nmck025",FALSE)
               END IF
               IF cl_null(g_nmck_m.nmck026) THEN
                  IF NOT cl_null(g_nmck_m.nmck025) THEN
                     LET g_nmck_m.nmck026='1'
                  ELSE
                     LET g_nmck_m.nmck026='0'
                  END IF
                  DISPLAY BY NAME g_nmck_m.nmck026
               END IF
            END IF
            IF p_cmd='a' THEN
               NEXT FIELD nmcksite
            END IF
            #end add-point
            CALL anmt440_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmcksite
            
            #add-point:AFTER FIELD nmcksite name="input.a.nmcksite"
            IF NOT cl_null(g_nmck_m.nmcksite) THEN 
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_nmck_m.nmcksite != g_nmck_m_t.nmcksite OR g_nmck_m_t.nmcksite IS NULL )) THEN   #160822-00012#5   mark
               IF g_nmck_m.nmcksite != g_nmck_m_o.nmcksite OR cl_null(g_nmck_m_o.nmcksite) THEN                                       #160822-00012#5   add
                  CALL anmt440_nmcksite_chk()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_nmck_m.nmcksite
                     #160318-00005#27 by 07900 --add--str
                     LET g_errparam.replace[1] = 'aooi125'
                     LET g_errparam.replace[2] = cl_get_progname("aooi125",g_lang,"2")
                     LET g_errparam.exeprog ='aooi125'
                     #160318-00005#27 by 07900 --add--end
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #LET g_nmck_m.nmcksite=g_nmck_m_t.nmcksite   #160822-00012#5   mark
                     LET g_nmck_m.nmcksite=g_nmck_m_o.nmcksite    #160822-00012#5   add
                     CALL anmt440_nmcksite_desc()
                     NEXT FIELD CURRENT
                  END IF
                  
                  #2015/03/31--by 02599--add--str--
                 #CALL s_fin_account_center_with_ld_chk(g_nmck_m.nmcksite,g_glaald,g_user,'6','N','',g_nmck_m.nmckdocdt) RETURNING l_success,g_errno #150714-00024#1 mark
                  CALL s_fin_account_center_with_ld_chk(g_nmck_m.nmcksite,'',g_user,'6','N','',g_nmck_m.nmckdocdt) RETURNING l_success,g_errno #150714-00024#1
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno       
                     LET g_errparam.extend = g_nmck_m.nmcksite
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #LET g_nmck_m.nmcksite=g_nmck_m_t.nmcksite   #160822-00012#5   mark
                     LET g_nmck_m.nmcksite=g_nmck_m_o.nmcksite    #160822-00012#5   add
                     CALL anmt440_nmcksite_desc()
                     NEXT FIELD CURRENT
                  END IF
                  #2015/03/31--by 02599--add--end
                  
                  #150714-00024#1 add ------
                  CALL s_anm_get_comp_wc('6',g_nmck_m.nmcksite,g_nmck_m.nmckdocdt) RETURNING g_comp_wc
                  #IF NOT cl_null(g_nmck_m.nmckcomp) AND s_chr_get_index_of(g_comp_wc,g_nmck_m.nmckcomp,1) = 0 THEN #160816-00012#3 mark
                  IF NOT cl_null(g_nmck_m.nmckcomp) THEN                           #160816-00012#3 add 
                     IF s_chr_get_index_of(g_comp_wc,g_nmck_m.nmckcomp,1) = 0 THEN #160816-00012#3 add
                        LET g_nmck_m.nmckcomp = ''   #160822-00012#5   add
                        SELECT ooef017 INTO g_nmck_m.nmckcomp
                          FROM ooef_t
                         WHERE ooefent = g_enterprise
                           AND ooef001 = g_nmck_m.nmcksite
                        DISPLAY BY NAME g_nmck_m.nmckcomp
                        #CALL s_anm_get_site_wc('6',g_nmck_m.nmckcomp,g_nmck_m.nmckdocdt) RETURNING g_site_wc #160912-00024#1 mark
                        CALL anmt440_glaa()
                     END IF #160816-00012#3 add   
                  END IF
                  CALL s_anm_get_site_wc('6',g_nmck_m.nmcksite,g_nmck_m.nmckdocdt) RETURNING g_site_wc #160912-00024#1 
                  LET g_nmck_m.nmckcomp_desc = s_desc_get_department_desc(g_nmck_m.nmckcomp)
                  DISPLAY BY NAME g_nmck_m.nmckcomp_desc
                  #150714-00024#1 add end---
               END IF
            END IF
            CALL anmt440_nmcksite_desc()
            LET g_nmck_m_o.*=g_nmck_m.*    #160822-00012#5   add
            #150714-00024#1 mark ------
            ##預設法人=資金中心對應的法人
            #IF cl_null(g_nmck_m.nmckcomp) THEN
            #   SELECT ooef017 INTO g_nmck_m.nmckcomp
            #     FROM ooef_t
            #    WHERE ooefent=g_enterprise AND ooef001=g_nmck_m.nmcksite
            #   CALL anmt440_nmckcomp_desc()
            #   DISPLAY BY NAME g_nmck_m.nmckcomp
            #END IF
            #150714-00024#1 mark end---
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmcksite
            #add-point:BEFORE FIELD nmcksite name="input.b.nmcksite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmcksite
            #add-point:ON CHANGE nmcksite name="input.g.nmcksite"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmckcomp
            
            #add-point:AFTER FIELD nmckcomp name="input.a.nmckcomp"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_nmck_m.nmckcomp) AND NOT cl_null(g_nmck_m.nmckdocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_nmck_m.nmckcomp != g_nmckcomp_t  OR g_nmck_m.nmckdocno != g_nmckdocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM nmck_t WHERE "||"nmckent = '" ||g_enterprise|| "' AND "||"nmckcomp = '"||g_nmck_m.nmckcomp ||"' AND "|| "nmckdocno = '"||g_nmck_m.nmckdocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            
            IF NOT cl_null(g_nmck_m.nmckcomp) THEN 
               #2015/04/01--by 02599--add--str--
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_nmck_m.nmckcomp != g_nmck_m_t.nmckcomp OR g_nmck_m_t.nmckcomp IS NULL )) THEN   #160822-00012#5   mark
               IF g_nmck_m.nmckcomp != g_nmck_m_o.nmckcomp OR cl_null(g_nmck_m_o.nmckcomp) THEN                                       #160822-00012#5   add
                  CALL s_fin_comp_chk(g_nmck_m.nmckcomp) RETURNING g_sub_success,g_errno
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
                     #LET g_nmck_m.nmckcomp = g_nmck_m_t.nmckcomp   #160822-00012#5   mark
                     LET g_nmck_m.nmckcomp = g_nmck_m_o.nmckcomp    #160822-00012#5   add
                     CALL anmt440_nmckcomp_desc()
                     NEXT FIELD CURRENT
                  END IF
                  #150714-00024#1 mark ------
                  #CALL s_fin_account_center_with_ld_chk(g_nmck_m.nmcksite,g_glaald,g_user,'6','Y','',g_nmck_m.nmckdocdt) 
                  #   RETURNING g_sub_success,g_errno
                  #IF NOT g_sub_success THEN
                  #   INITIALIZE g_errparam TO NULL
                  #   LET g_errparam.code = g_errno
                  #   LET g_errparam.extend = ''
                  #   LET g_errparam.popup = TRUE
                  #   CALL cl_err()
                  #   LET g_nmck_m.nmckcomp = g_nmck_m_t.nmckcomp
                  #   CALL anmt440_nmckcomp_desc()
                  #   NEXT FIELD CURRENT
                  #END IF
                  #150714-00024#1 mark end---
                  #150714-00024#1 add ------
                  IF NOT cl_null(g_nmck_m.nmcksite) THEN #160816-00012#3 add
                     IF s_chr_get_index_of(g_comp_wc,g_nmck_m.nmckcomp,1) = 0 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'anm-02928'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        #LET g_nmck_m.nmckcomp = g_nmck_m_t.nmckcomp   #160822-00012#5   mark
                        LET g_nmck_m.nmckcomp = g_nmck_m_o.nmckcomp    #160822-00012#5   add
                        CALL anmt440_nmckcomp_desc()
                        NEXT FIELD CURRENT
                     END IF
                  END IF  #160816-00012#3 add
                  #160816-00012#3 Add  ---(S)---
                  #检查用户是否有资金中心对应法人的权限
                  CALL s_axrt300_get_site(g_user,'','3') RETURNING l_wc
                  LET l_count = 0
                  LET l_sql = "SELECT COUNT(*) FROM ooef_t WHERE ooefent = '",g_enterprise,"' ",
                              "   AND ooef001 = '",g_nmck_m.nmckcomp,"'",
                              "   AND ooef003 = 'Y'",
                              "   AND ",l_wc CLIPPED
                  PREPARE anmt440_count_prep1 FROM l_sql
                  EXECUTE anmt440_count_prep1 INTO l_count
                  IF cl_null(l_count) THEN LET l_count = 0 END IF
                  IF l_count = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "ais-00228"
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #LET g_nmck_m.nmckcomp = g_nmck_m_t.nmckcomp   #160822-00012#5   mark
                     LET g_nmck_m.nmckcomp = g_nmck_m_o.nmckcomp    #160822-00012#5   add
                     CALL anmt440_nmckcomp_desc()                     
                     NEXT FIELD CURRENT
                  END IF
                  #160816-00012#3 Add  ---(E)---                  
                  #CALL s_anm_get_site_wc('6',g_nmck_m.nmckcomp,g_nmck_m.nmckdocdt) RETURNING g_site_wc #160912-00024#1 mark
                  CALL anmt440_glaa()
                  #150714-00024#1 add end---
               END IF
               #2015/04/01--by 02599--add--end
            END IF 
            #CALL anmt440_glaa()         #150714-00024#1 mark
            CALL anmt440_nmckcomp_desc() #150714-00024#1
            LET g_nmck_m_o.* = g_nmck_m.*    #160822-00012#5   add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmckcomp
            #add-point:BEFORE FIELD nmckcomp name="input.b.nmckcomp"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmckcomp
            #add-point:ON CHANGE nmckcomp name="input.g.nmckcomp"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck003
            
            #add-point:AFTER FIELD nmck003 name="input.a.nmck003"
            CALL anmt440_nmck003_desc()
            IF NOT cl_null(g_nmck_m.nmck003) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_nmck_m.nmck003
               #160318-00025#1--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
               #160318-00025#1--add--end  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooag001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_nmck_m.nmck003 = g_nmck_m_t.nmck003
                  CALL anmt440_nmck003_desc()
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck003
            #add-point:BEFORE FIELD nmck003 name="input.b.nmck003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmck003
            #add-point:ON CHANGE nmck003 name="input.g.nmck003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmckdocno
            #add-point:BEFORE FIELD nmckdocno name="input.b.nmckdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmckdocno
            
            #add-point:AFTER FIELD nmckdocno name="input.a.nmckdocno"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_nmck_m.nmckcomp) AND NOT cl_null(g_nmck_m.nmckdocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_nmck_m.nmckcomp != g_nmckcomp_t  OR g_nmck_m.nmckdocno != g_nmckdocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM nmck_t WHERE "||"nmckent = '" ||g_enterprise|| "' AND "||"nmckcomp = '"||g_nmck_m.nmckcomp ||"' AND "|| "nmckdocno = '"||g_nmck_m.nmckdocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
           
            IF NOT cl_null(g_nmck_m.nmckdocno) THEN 
               #CALL s_aooi200_chk_slip(g_nmck_m.nmckcomp,g_glaa024,g_nmck_m.nmckdocno,'anmt440') RETURNING l_success   2014/12/29 liuym mark
               CALL s_aooi200_fin_chk_slip(g_glaald,g_glaa024,g_nmck_m.nmckdocno,'anmt440') RETURNING l_success
               IF l_success = FALSE THEN 
                  LET g_nmck_m.nmckdocno = g_nmck_m_t.nmckdocno
                  NEXT FIELD nmckdocno
               END IF
               #161104-00046#13-----s
               CALL s_control_chk_doc('1',g_nmck_m.nmckdocno,'4',g_user,g_dept,'','') RETURNING g_sub_success,l_flag1
               IF g_sub_success AND l_flag1 THEN             
               ELSE
                  LET g_nmck_m.nmckdocno = g_nmck_m_o.nmckdocno 
                  NEXT FIELD CURRENT                  
               END IF
               CALL s_aooi200_fin_get_slip(g_nmck_m.nmckdocno) RETURNING g_sub_success,l_slip
               #刪除單別預設temptable
               DELETE FROM s_aooi200def1
               #以目前畫面資訊新增temp資料   #請勿調整.*
               INSERT INTO s_aooi200def1 VALUES(g_nmck_m.*)
               #依單別預設取用資訊
               CALL s_aooi200def_get('','',g_nmck_m.nmckcomp,'2',l_slip,'','',g_glaald)
               #依單別預設值TEMP內容 給予到畫面上   #請勿調整.*
               SELECT * INTO g_nmck_m.* FROM s_aooi200def1
               #161104-00046#13-----e  
            END IF

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmckdocno
            #add-point:ON CHANGE nmckdocno name="input.g.nmckdocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck002
            #add-point:BEFORE FIELD nmck002 name="input.b.nmck002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck002
            
            #add-point:AFTER FIELD nmck002 name="input.a.nmck002"
            #160621-00015#1--add--str--
            #5065行移到此处
            IF NOT cl_null(g_nmck_m.nmck002) THEN
              SELECT ooia002 INTO g_nmck_m.nmck023 
                FROM ooia_t
                WHERE ooiaent = g_enterprise
                  AND ooia001 = g_nmck_m.nmck002
            END IF
            #160621-00015#1--add--end
            IF NOT cl_null(g_nmck_m.nmck002) AND NOT cl_null(g_nmck_m.nmck004) AND NOT cl_null(g_nmck_m.nmck024) THEN
               SELECT nmaf004,nmaf010,nmaf011 INTO g_nmck_m.nmck024,l_nmaf010,l_nmaf011 
               FROM nmaf_t
               WHERE nmafent=g_enterprise AND nmaf001=g_nmck_m.nmck004
                 AND nmaf002=g_nmck_m.nmck002 AND nmaf010<nmaf007
                 AND nmaf012='Y'
               ORDER BY nmaf004
               LET g_nmck_m.nmck025=l_nmaf010
               DISPLAY BY NAME g_nmck_m.nmck024,g_nmck_m.nmck025
               IF l_nmaf011='N' THEN #套印否
                  CALL cl_set_comp_required("nmck025",TRUE)
               ELSE
                  CALL cl_set_comp_required("nmck025",FALSE)
               END IF
               IF cl_null(g_nmck_m.nmck026) THEN
                  IF NOT cl_null(g_nmck_m.nmck025) THEN
                     LET g_nmck_m.nmck026='1'
                  ELSE
                     LET g_nmck_m.nmck026='0'
                  END IF
                  DISPLAY BY NAME g_nmck_m.nmck026
               END IF
               #160621-00015#1--add--str--
               #检核是否存在重复票据号码
               SELECT COUNT(*) INTO l_cnt FROM nmck_t
                WHERE nmckent=g_enterprise AND nmck004=g_nmck_m.nmck004
                  AND nmck002=g_nmck_m.nmck002 AND nmck025=g_nmck_m.nmck025
                  AND nmckdocno <> g_nmck_m.nmckdocno
               IF l_cnt>0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'anm-00157'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
                  NEXT FIELD nmck025
               END IF
               #160621-00015#1--add--end
            END IF
#160621-00015#1--mark--str-- #移至上面5017行           
#            IF NOT cl_null(g_nmck_m.nmck002) THEN
#              SELECT ooia002 INTO g_nmck_m.nmck023 
#                FROM ooia_t
#                WHERE ooiaent = g_enterprise
#                  AND ooia001 = g_nmck_m.nmck002
#            END IF
#160621-00015#1--mark--end
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmck002
            #add-point:ON CHANGE nmck002 name="input.g.nmck002"
            #160621-00015#1--add--str--
            #5129行移到此处
            IF NOT cl_null(g_nmck_m.nmck002) THEN
              SELECT ooia002 INTO g_nmck_m.nmck023 
                FROM ooia_t
                WHERE ooiaent = g_enterprise
                  AND ooia001 = g_nmck_m.nmck002
            END IF
            #160621-00015#1--add--end
            IF NOT cl_null(g_nmck_m.nmck002) AND NOT cl_null(g_nmck_m.nmck004) AND NOT cl_null(g_nmck_m.nmck024) THEN
               SELECT nmaf004,nmaf010,nmaf011 INTO g_nmck_m.nmck024,l_nmaf010,l_nmaf011 
               FROM nmaf_t
               WHERE nmafent=g_enterprise AND nmaf001=g_nmck_m.nmck004
                 AND nmaf002=g_nmck_m.nmck002 AND nmaf010<nmaf007
                 AND nmaf012='Y'
               ORDER BY nmaf004
               LET g_nmck_m.nmck025=l_nmaf010
               DISPLAY BY NAME g_nmck_m.nmck024,g_nmck_m.nmck025
               IF l_nmaf011='N' THEN #套印否
                  CALL cl_set_comp_required("nmck025",TRUE)
               ELSE
                  CALL cl_set_comp_required("nmck025",FALSE)
               END IF
               IF cl_null(g_nmck_m.nmck026) THEN
                  IF NOT cl_null(g_nmck_m.nmck025) THEN
                     LET g_nmck_m.nmck026='1'
                  ELSE
                     LET g_nmck_m.nmck026='0'
                  END IF
                  DISPLAY BY NAME g_nmck_m.nmck026
               END IF
               #160621-00015#1--add--str--
               #检核是否存在重复票据号码
               SELECT COUNT(*) INTO l_cnt FROM nmck_t
                WHERE nmckent=g_enterprise AND nmck004=g_nmck_m.nmck004
                  AND nmck002=g_nmck_m.nmck002 AND nmck025=g_nmck_m.nmck025
                  AND nmckdocno <> g_nmck_m.nmckdocno
               IF l_cnt>0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'anm-00157'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
                  NEXT FIELD nmck025
               END IF
               #160621-00015#1--add--end
            END IF
#160621-00015#1--mark--str-- #移至上面5081行           
#            IF NOT cl_null(g_nmck_m.nmck002) THEN
#              SELECT ooia002 INTO g_nmck_m.nmck023 
#                FROM ooia_t
#                WHERE ooiaent = g_enterprise
#                  AND ooia001 = g_nmck_m.nmck002
#            END IF 
#160621-00015#1--mark--end
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmckdocdt
            #add-point:BEFORE FIELD nmckdocdt name="input.b.nmckdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmckdocdt
            
            #add-point:AFTER FIELD nmckdocdt name="input.a.nmckdocdt"
            IF NOT cl_null(g_nmck_m.nmckdocdt) THEN 
               #150813-00015#5--mod--str--
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_nmck_m.nmckdocdt <>g_nmck_m_t.nmckdocdt OR cl_null(g_nmck_m_t.nmckdocdt))) THEN   #160822-00012#5   mark
               IF g_nmck_m.nmckdocdt != g_nmck_m_o.nmckdocdt OR cl_null(g_nmck_m_o.nmckdocdt) THEN                                       #160822-00012#5   add
                  #檢查當單據日期小於等於關帳日期時，不可異動單據
                  CALL s_fin_date_close_chk('',g_nmck_m.nmckcomp,'ANM',g_nmck_m.nmckdocdt) RETURNING l_success
                  IF l_success=FALSE THEN
                     #LET g_nmck_m.nmckdocdt = g_nmck_m_t.nmckdocdt   #160822-00012#5   mark
                     LET g_nmck_m.nmckdocdt = g_nmck_m_o.nmckdocdt    #160822-00012#5   add
                     NEXT FIELD nmckdocdt
                  END IF
#               IF g_nmck_m.nmckdocdt < g_para_data THEN 
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = 'anm-00124'
#                  LET g_errparam.extend = g_nmck_m.nmckdocdt
#                  LET g_errparam.popup = TRUE
#                  CALL cl_err()
# 
#                  LET g_nmck_m.nmckdocdt = g_nmck_m_t.nmckdocdt
#                  NEXT FIELD nmckdocdt
               END IF
               #150813-00015#5--mod--end
            END IF
            LET g_nmck_m_o.* = g_nmck_m.*    #160822-00012#5   add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmckdocdt
            #add-point:ON CHANGE nmckdocdt name="input.g.nmckdocdt"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck004
            
            #add-point:AFTER FIELD nmck004 name="input.a.nmck004"
            CALL anmt440_nmck004_desc()
            IF NOT cl_null(g_nmck_m.nmck004) THEN 
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_nmck_m.nmck004
               LET g_chkparam.arg2 = g_nmck_m.nmckcomp
               #160318-00025#1--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "ade-00010:sub-01302|anmi120|",cl_get_progname("anmi120",g_lang,"2"),"|:EXEPROGanmi120"
               #160318-00025#1--add--end
               IF cl_chk_exist("v_nmas002_1") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
#                  #賬戶幣別
#                  LET g_nmck_m.nmas003 = ''
#                  SELECT nmas003 INTO g_nmck_m.nmas003 
#                    FROM nmaa_t,nmas_t
#                   WHERE nmaaent = g_enterprise
#                     AND nmaaent = nmasent
#                     AND nmaa001 = nmas001
#                     AND nmas002 = g_nmck_m.nmck004 
#                     AND nmaa002 IN (select ooef001 FROM ooef_t WHERE ooefent = g_enterprise
#                                                              AND ooef017 = g_nmck_m.nmckcomp)
#                  DISPLAY g_nmck_m.nmas003 TO nmas003
 
                  #160122-00001#27--add---str
                  IF NOT s_anmi120_nmll002_chk(g_nmck_m.nmck004,g_user) THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_nmck_m.nmck004
                     LET g_errparam.code   = 'anm-00574' 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET g_nmck_m.nmck004 = g_nmck_m_t.nmck004
                     CALL anmt440_nmck004_desc()
                     NEXT FIELD CURRENT
                  END IF
                  #160122-00001#27--add---end
                  
                  #160708-00004#1 add s---
                  SELECT nmaa003 INTO l_nmaa003
                    FROM nmaa_t,nmas_t
                   WHERE nmaaent = g_enterprise
                     AND nmaaent = nmasent
                     AND nmaa001 = nmas001
                     AND nmas002 = g_nmck_m.nmck004 
                     AND nmaa002 IN (select ooef001 FROM ooef_t WHERE ooefent = g_enterprise
                                                                  AND ooef017 = g_nmck_m.nmckcomp)                  
                  #先检查该银行账户是否存在anmi140资料
                  LET l_n = 0 
                  SELECT COUNT(*) INTO l_n FROM nmag_t WHERE nmagent = g_enterprise AND nmag001 = l_nmaa003                
                  IF l_n = 0 THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'anm-03009'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     
                     LET g_nmck_m.nmck004 = g_nmck_m_t.nmck004
                     CALL anmt440_nmck004_desc()
                     NEXT FIELD CURRENT                      
                  END IF
                  #anmi140资料是否存在符合nmag002 in('1','4')的资料
                  LET l_n = 0 
                  SELECT COUNT(*) INTO l_n FROM nmag_t WHERE nmagent = g_enterprise AND nmag001 = l_nmaa003 
                     AND nmag002 IN('1','4') 
                  IF l_n = 0 THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'anm-00258'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     
                     LET g_nmck_m.nmck004 = g_nmck_m_t.nmck004
                     CALL anmt440_nmck004_desc()
                     NEXT FIELD CURRENT                      
                  END IF     
                  #anmi140中是否符合条件的资料有效
                  LET l_n = 0 
                  SELECT COUNT(*) INTO l_n FROM nmag_t WHERE nmagent = g_enterprise AND nmag001 = l_nmaa003 
                     AND nmag002 IN('1','4') AND nmagstus = 'Y'
                  IF l_n = 0 THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'anm-03010'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     
                     LET g_nmck_m.nmck004 = g_nmck_m_t.nmck004
                     CALL anmt440_nmck004_desc()
                     NEXT FIELD CURRENT                      
                  END IF  
                  #160708-00004#1 add e--- 
#160708-00004#1 mark e---                   
#                   SELECT nmaa003 INTO l_nmaa003
#                     FROM nmaa_t,nmas_t
#                    WHERE nmaaent = g_enterprise
#                      AND nmaaent = nmasent
#                      AND nmaa001 = nmas001
#                      AND nmas002 = g_nmck_m.nmck004 
#                      AND nmaa002 IN (select ooef001 FROM ooef_t WHERE ooefent = g_enterprise
#                                                                   AND ooef017 = g_nmck_m.nmckcomp)
#
#                   SELECT nmag002 INTO l_nmag002
#                     FROM nmag_t
#                    WHERE nmagent = g_enterprise
#                      AND nmag001 = l_nmaa003
#                      
#                   IF l_nmag002 <> '1' AND l_nmag002 <> '4' THEN 
#                      INITIALIZE g_errparam TO NULL
#                      LET g_errparam.code = 'anm-00258'
#                      LET g_errparam.extend = ''
#                      LET g_errparam.popup = TRUE
#                      CALL cl_err()
#                      
#                      LET g_nmck_m.nmck004 = g_nmck_m_t.nmck004
#                      CALL anmt440_nmck004_desc()
#                      NEXT FIELD CURRENT
#                   END IF
#160708-00004#1 mark e--- 
                   #141106-00011#22-(S)
                   IF NOT cl_null(g_nmck_m.nmck100) THEN
                      #150930-00010#4--s
                      IF g_para_data1 = '23' THEN
                         #銀行日平均匯率
                         CALL s_anm_get_exrate(g_glaald,g_nmck_m.nmckcomp,g_nmck_m.nmck004,g_nmck_m.nmck100,g_glaa001,g_nmck_m.nmckdocdt) RETURNING g_nmck_m.nmck101 
                      ELSE
                      #150930-00010#4--e
                         CALL s_aooi160_get_exrate('1',g_nmck_m.nmckcomp,g_nmck_m.nmckdocdt,g_nmck_m.nmck100,
                                                  #目的幣別;  交易金額;              匯類類型
                                                   g_glaa001,0,g_para_data1)
                              RETURNING g_nmck_m.nmck101
                         #150930-00010#4 mark--s
                         #CALL s_curr_round_ld('1',g_glaald,g_glaa001,g_nmck_m.nmck101,3) #150714-00024#1
                         #     RETURNING g_sub_success,g_errno,g_nmck_m.nmck101           #150714-00024#1
                         #150930-00010#4 mark--e
                      END IF   #150930-00010#4
                      DISPLAY g_nmck_m.nmck101 TO nmck101
                      IF NOT cl_null(g_nmck_m.nmck103) THEN
                         CALL s_curr_round_ld('1',g_glaald,g_nmck_m.nmck100,g_nmck_m.nmck103,2)  #150714-00024#1
                              RETURNING g_sub_success,g_errno,g_nmck_m.nmck103                   #150714-00024#1
                         LET g_nmck_m.nmck113 = g_nmck_m.nmck103 * g_nmck_m.nmck101
                         CALL s_curr_round_ld('1',g_glaald,g_glaa001,g_nmck_m.nmck113,2)         #150714-00024#1
                              RETURNING g_sub_success,g_errno,g_nmck_m.nmck113                   #150714-00024#1
                         DISPLAY g_nmck_m.nmck113 TO nmck113
                         CALL anmt440_get_exrate()
                      END IF
                   END IF
                   #141106-00011#22-(E)
               ELSE
                  #檢查失敗時後續處理
                  LET g_nmck_m.nmck004 = g_nmck_m_t.nmck004
                  CALL anmt440_nmck004_desc()
                  NEXT FIELD CURRENT
               END IF
            
               IF NOT cl_null(g_nmck_m.nmck002) AND NOT cl_null(g_nmck_m.nmck024) THEN
                  SELECT nmaf004,nmaf010,nmaf011 INTO g_nmck_m.nmck024,l_nmaf010,l_nmaf011 
                  FROM nmaf_t
                  WHERE nmafent=g_enterprise AND nmaf001=g_nmck_m.nmck004
                    AND nmaf002=g_nmck_m.nmck002 AND nmaf010<nmaf007
                    AND nmaf012='Y'
                  ORDER BY nmaf004
                  LET g_nmck_m.nmck025=l_nmaf010
                  DISPLAY BY NAME g_nmck_m.nmck024,g_nmck_m.nmck025
                  IF l_nmaf011='N' THEN #套印否
                     CALL cl_set_comp_required("nmck025",TRUE)
                  ELSE
                     CALL cl_set_comp_required("nmck025",FALSE)
                  END IF
                  IF cl_null(g_nmck_m.nmck026) THEN
                     IF NOT cl_null(g_nmck_m.nmck025) THEN
                        LET g_nmck_m.nmck026='1'
                     ELSE
                        LET g_nmck_m.nmck026='0'
                     END IF
                     DISPLAY BY NAME g_nmck_m.nmck026
                  END IF
                  #160621-00015#1--add--str--
                  #检核是否存在重复票据号码
                  SELECT COUNT(*) INTO l_cnt FROM nmck_t
                   WHERE nmckent=g_enterprise AND nmck004=g_nmck_m.nmck004
                     AND nmck002=g_nmck_m.nmck002 AND nmck025=g_nmck_m.nmck025
                     AND nmckdocno <> g_nmck_m.nmckdocno
                  IF l_cnt>0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'anm-00157'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = FALSE
                     CALL cl_err()
                     NEXT FIELD nmck025
                  END IF
                  #160621-00015#1--add--end
               END IF
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck004
            #add-point:BEFORE FIELD nmck004 name="input.b.nmck004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmck004
            #add-point:ON CHANGE nmck004 name="input.g.nmck004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmas003
            #add-point:BEFORE FIELD nmas003 name="input.b.nmas003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmas003
            
            #add-point:AFTER FIELD nmas003 name="input.a.nmas003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmas003
            #add-point:ON CHANGE nmas003 name="input.g.nmas003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck019
            #add-point:BEFORE FIELD nmck019 name="input.b.nmck019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck019
            
            #add-point:AFTER FIELD nmck019 name="input.a.nmck019"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmck019
            #add-point:ON CHANGE nmck019 name="input.g.nmck019"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmckstus
            #add-point:BEFORE FIELD nmckstus name="input.b.nmckstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmckstus
            
            #add-point:AFTER FIELD nmckstus name="input.a.nmckstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmckstus
            #add-point:ON CHANGE nmckstus name="input.g.nmckstus"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck001
            #add-point:BEFORE FIELD nmck001 name="input.b.nmck001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck001
            
            #add-point:AFTER FIELD nmck001 name="input.a.nmck001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmck001
            #add-point:ON CHANGE nmck001 name="input.g.nmck001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck103
            #add-point:BEFORE FIELD nmck103 name="input.b.nmck103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck103
            
            #add-point:AFTER FIELD nmck103 name="input.a.nmck103"
            IF NOT cl_null(g_nmck_m.nmck103) THEN 
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND g_nmck_m.nmck103 <> g_nmck_m_t.nmck103) THEN   #160822-00012#5   mark
               IF g_nmck_m.nmck103 != g_nmck_m_o.nmck103 OR cl_null(g_nmck_m_o.nmck103) THEN      #160822-00012#5   add             
                  CALL s_curr_round_ld('1',g_glaald,g_nmck_m.nmck100,g_nmck_m.nmck103,2)  #150714-00024#1
                       RETURNING g_sub_success,g_errno,g_nmck_m.nmck103                   #150714-00024#1
                  LET g_nmck_m.nmck113 = g_nmck_m.nmck103 * g_nmck_m.nmck101
                  CALL s_curr_round_ld('1',g_glaald,g_glaa001,g_nmck_m.nmck113,2)         #150714-00024#1
                       RETURNING g_sub_success,g_errno,g_nmck_m.nmck113                   #150714-00024#1
                  IF cl_null(g_nmck_m.nmck028) THEN LET g_nmck_m.nmck028=0 END IF
                  LET g_nmck_m.nmck029=g_nmck_m.nmck113*g_nmck_m.nmck028/100
                  #CALL s_curr_round_ld('1',g_glaald,g_glaa001,g_nmck_m.nmck029,2)         #150714-00024#1 #160524-00055#1
                   CALL s_curr_round_ld('1',g_glaald,g_nmck_m.nmck100,g_nmck_m.nmck029,2)  #160524-00055#1
                       RETURNING g_sub_success,g_errno,g_nmck_m.nmck029                   #150714-00024#1 
                  DISPLAY BY NAME g_nmck_m.nmck029
                  CALL anmt440_get_exrate()
                  DISPLAY g_nmck_m.nmck113 TO nmck113
                  
                  #160905-00056#1 add--s
                  #重評後本幣金額也要重推
                  LET g_nmck_m.nmck114 = g_nmck_m.nmck113
                  #160905-00056#1 add--e
               END IF
            END IF
            LET g_nmck_m_o.* = g_nmck_m.*   #160822-00012#5   add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmck103
            #add-point:ON CHANGE nmck103 name="input.g.nmck103"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck101
            #add-point:BEFORE FIELD nmck101 name="input.b.nmck101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck101
            
            #add-point:AFTER FIELD nmck101 name="input.a.nmck101"
            IF NOT cl_null(g_nmck_m.nmck101) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND g_nmck_m.nmck101 <> g_nmck_m_t.nmck101) THEN   #160822-00012#5   mark
               IF g_nmck_m.nmck101 != g_nmck_m_o.nmck101 OR cl_null(g_nmck_m_o.nmck101) THEN      #160822-00012#5   add
                  #150714-00024#1 add ------
                 #CALL s_curr_round_ld('1',g_glaald,g_glaa001,g_nmck_m.nmck101,3)          #150930-00010#4 mark
                  CALL s_curr_round_ld('1',g_glaald,g_nmck_m.nmck100,g_nmck_m.nmck101,3)   #150930-00010#4 
                       RETURNING g_sub_success,g_errno,g_nmck_m.nmck101
                  CALL s_curr_round_ld('1',g_glaald,g_nmck_m.nmck100,g_nmck_m.nmck103,2)
                       RETURNING g_sub_success,g_errno,g_nmck_m.nmck103
                  #150714-00024#1 add end---
                  LET g_nmck_m.nmck113 = g_nmck_m.nmck103 * g_nmck_m.nmck101
                  CALL s_curr_round_ld('1',g_glaald,g_glaa001,g_nmck_m.nmck113,2)         #150714-00024#1
                       RETURNING g_sub_success,g_errno,g_nmck_m.nmck113                   #150714-00024#1
                  #重評後本幣金額也要重推
                  LET g_nmck_m.nmck114 = g_nmck_m.nmck113                                 #150922-00021#2
                  IF cl_null(g_nmck_m.nmck028) THEN LET g_nmck_m.nmck028=0 END IF
                  LET g_nmck_m.nmck029=g_nmck_m.nmck113*g_nmck_m.nmck028/100
                  #CALL s_curr_round_ld('1',g_glaald,g_glaa001,g_nmck_m.nmck029,2)         #150714-00024#1 #160524-00055#1
                  CALL s_curr_round_ld('1',g_glaald,g_nmck_m.nmck100,g_nmck_m.nmck029,2)   #150714-00024#1  #160524-00055#1
                       RETURNING g_sub_success,g_errno,g_nmck_m.nmck029                   #150714-00024#1
                  DISPLAY BY NAME g_nmck_m.nmck029
                  CALL anmt440_get_exrate()
                  DISPLAY g_nmck_m.nmck113 TO nmck113
               END IF
            END IF
            LET g_nmck_m_o.* = g_nmck_m.*   #160822-00012#5   add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmck101
            #add-point:ON CHANGE nmck101 name="input.g.nmck101"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck113
            #add-point:BEFORE FIELD nmck113 name="input.b.nmck113"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck113
            
            #add-point:AFTER FIELD nmck113 name="input.a.nmck113"
            IF NOT cl_null(g_nmck_m.nmck113) THEN
               #161019-00001#1 Mark ---(S)---
              ##160905-00056#1 add--s
              #IF NOT cl_ap_chk_range(g_nmck_m.nmck113,"0","0","","","azz-00079",1) THEN
              #   NEXT FIELD nmck103
              #END IF 
              ##160905-00056#1 add--e
               #161019-00001#1 Mark ---(E)---
               
               CALL s_curr_round_ld('1',g_glaald,g_glaa001,g_nmck_m.nmck113,2)         #150714-00024#1
                    RETURNING g_sub_success,g_errno,g_nmck_m.nmck113                   #150714-00024#1
               #CALL anmt440_get_exrate()  #160905-00056#1  mark
               IF cl_null(g_nmck_m.nmck028) THEN LET g_nmck_m.nmck028=0 END IF
               LET g_nmck_m.nmck029=g_nmck_m.nmck113*g_nmck_m.nmck028/100
               #CALL s_curr_round_ld('1',g_glaald,g_glaa001,g_nmck_m.nmck029,2)         #150714-00024#1 #160524-00055#1
               CALL s_curr_round_ld('1',g_glaald,g_nmck_m.nmck100,g_nmck_m.nmck029,2)     #160524-00055#1
                    RETURNING g_sub_success,g_errno,g_nmck_m.nmck029                   #150714-00024#1
               DISPLAY BY NAME g_nmck_m.nmck029
               
               #160905-00056#1 add--s
               IF NOT cl_null(g_nmck_m.nmck101) AND g_nmck_m.nmck101!=0 THEN
                  LET g_nmck_m.nmck103 = g_nmck_m.nmck113 / g_nmck_m.nmck101
                  CALL s_curr_round_ld('1',g_glaald,g_nmck_m.nmck100,g_nmck_m.nmck103,2)
                       RETURNING g_sub_success,g_errno,g_nmck_m.nmck103
                  DISPLAY g_nmck_m.nmck103 TO nmck103
               END IF
               
               DISPLAY g_nmck_m.nmck113 TO nmck113
               #重評後本幣金額也要重推
               LET g_nmck_m.nmck114 = g_nmck_m.nmck113
               
               CALL anmt440_get_exrate()
               #160905-00056#1 add--e
            END IF
            LET g_nmck_m_o.* = g_nmck_m.*   #160822-00012#5   add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmck113
            #add-point:ON CHANGE nmck113 name="input.g.nmck113"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck121
            #add-point:BEFORE FIELD nmck121 name="input.b.nmck121"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck121
            
            #add-point:AFTER FIELD nmck121 name="input.a.nmck121"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmck121
            #add-point:ON CHANGE nmck121 name="input.g.nmck121"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck123
            #add-point:BEFORE FIELD nmck123 name="input.b.nmck123"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck123
            
            #add-point:AFTER FIELD nmck123 name="input.a.nmck123"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmck123
            #add-point:ON CHANGE nmck123 name="input.g.nmck123"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck131
            #add-point:BEFORE FIELD nmck131 name="input.b.nmck131"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck131
            
            #add-point:AFTER FIELD nmck131 name="input.a.nmck131"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmck131
            #add-point:ON CHANGE nmck131 name="input.g.nmck131"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck133
            #add-point:BEFORE FIELD nmck133 name="input.b.nmck133"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck133
            
            #add-point:AFTER FIELD nmck133 name="input.a.nmck133"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmck133
            #add-point:ON CHANGE nmck133 name="input.g.nmck133"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck034
            #add-point:BEFORE FIELD nmck034 name="input.b.nmck034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck034
            
            #add-point:AFTER FIELD nmck034 name="input.a.nmck034"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmck034
            #add-point:ON CHANGE nmck034 name="input.g.nmck034"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck035
            #add-point:BEFORE FIELD nmck035 name="input.b.nmck035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck035
            
            #add-point:AFTER FIELD nmck035 name="input.a.nmck035"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmck035
            #add-point:ON CHANGE nmck035 name="input.g.nmck035"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck036
            #add-point:BEFORE FIELD nmck036 name="input.b.nmck036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck036
            
            #add-point:AFTER FIELD nmck036 name="input.a.nmck036"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmck036
            #add-point:ON CHANGE nmck036 name="input.g.nmck036"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck011
            #add-point:BEFORE FIELD nmck011 name="input.b.nmck011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck011
            
            #add-point:AFTER FIELD nmck011 name="input.a.nmck011"
            #160729-00011#1 add s---
            IF NOT cl_null(g_nmck_m.nmck011) THEN 
               IF g_nmck_m.nmck011 < g_nmck_m.nmckdocdt THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'anm-03017'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_nmck_m.nmck011 = g_nmck_m_t.nmck011
                  NEXT FIELD nmck011                
               END IF
            END IF
            #160729-00011#1 add e---
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmck011
            #add-point:ON CHANGE nmck011 name="input.g.nmck011"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck009
            
            #add-point:AFTER FIELD nmck009 name="input.a.nmck009"
            CALL anmt440_nmck009_desc()
            IF NOT cl_null(g_nmck_m.nmck009) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_glaa005
               LET g_chkparam.arg2 = g_nmck_m.nmck009
               #160318-00025#1--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "agl-00149:sub-01302|anmi172|",cl_get_progname("anmi172",g_lang,"2"),"|:EXEPROGanmi172"
               #160318-00025#1--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_nmad002") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                  IF cl_null(g_nmck_m.nmck010) THEN 
                     SELECT nmad003 INTO g_nmck_m.nmck010
                       FROM nmad_t
                      WHERE nmadent = g_enterprise
                        AND nmad001 = g_glaa005
                        AND nmad002 = g_nmck_m.nmck009    
                     DISPLAY g_nmck_m.nmck010 TO nmck010  
                     CALL anmt440_nmck010_desc()  
                   END IF                     
               ELSE
                  #檢查失敗時後續處理
                  LET g_nmck_m.nmck009 = g_nmck_m_t.nmck009
                  CALL anmt440_nmck009_desc()
                  NEXT FIELD CURRENT
               END IF
            

            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck009
            #add-point:BEFORE FIELD nmck009 name="input.b.nmck009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmck009
            #add-point:ON CHANGE nmck009 name="input.g.nmck009"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck010
            
            #add-point:AFTER FIELD nmck010 name="input.a.nmck010"
            CALL anmt440_nmck010_desc()
            IF NOT cl_null(g_nmck_m.nmck010) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_nmck_m.nmck010
               LET g_chkparam.arg2 = g_glaa005
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_nmai002") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_nmck_m.nmck010 = g_nmck_m_t.nmck010
                  CALL anmt440_nmck010_desc()
                  NEXT FIELD CURRENT
               END IF
            

            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck010
            #add-point:BEFORE FIELD nmck010 name="input.b.nmck010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmck010
            #add-point:ON CHANGE nmck010 name="input.g.nmck010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck024
            #add-point:BEFORE FIELD nmck024 name="input.b.nmck024"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck024
            
            #add-point:AFTER FIELD nmck024 name="input.a.nmck024"
            IF NOT cl_null(g_nmck_m.nmck024) THEN
               CALL anmt440_nmck024_chk(g_nmck_m.nmck024)
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  LET g_nmck_m.nmck024=g_nmck_m_t.nmck024
                  NEXT FIELD nmck024
               END IF
               #160621-00015#1--add--str--
               #检核是否存在重复票据号码
               SELECT COUNT(*) INTO l_cnt FROM nmck_t
                WHERE nmckent=g_enterprise AND nmck004=g_nmck_m.nmck004
                  AND nmck002=g_nmck_m.nmck002 AND nmck025=g_nmck_m.nmck025
                  AND nmckdocno <> g_nmck_m.nmckdocno
               IF l_cnt>0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'anm-00157'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
                  NEXT FIELD nmck025
               END IF
               #160621-00015#1--add--end
            ELSE
               CALL cl_set_comp_required("nmck025",FALSE)
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmck024
            #add-point:ON CHANGE nmck024 name="input.g.nmck024"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck027
            #add-point:BEFORE FIELD nmck027 name="input.b.nmck027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck027
            
            #add-point:AFTER FIELD nmck027 name="input.a.nmck027"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmck027
            #add-point:ON CHANGE nmck027 name="input.g.nmck027"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck025
            #add-point:BEFORE FIELD nmck025 name="input.b.nmck025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck025
            
            #add-point:AFTER FIELD nmck025 name="input.a.nmck025"
            IF NOT cl_null(g_nmck_m.nmck025) THEN
               IF ((g_nmck_m.nmck025 <> g_nmck_m_t.nmck025 OR cl_null(g_nmck_m_t.nmck025)) OR (g_nmck_m.nmck024 <> g_nmck_m_t.nmck024 OR cl_null(g_nmck_m_t.nmck024)) )  THEN  #170203-00007#1 add  OR (g_nmck_m.nmck024 <> g_nmck_m_t.nmck024 OR cl_null(g_nmck_m_t.nmck024))
                  SELECT nmaf006,nmaf007 INTO l_nmaf006,l_nmaf007 FROM nmaf_t
                   WHERE nmafent=g_enterprise AND nmaf001=g_nmck_m.nmck004 
                     AND nmaf002=g_nmck_m.nmck002 AND nmaf004=g_nmck_m.nmck024 
                     AND nmaf010<nmaf007 AND nmaf012='Y'
                  IF SQLCA.sqlcode=0 AND (g_nmck_m.nmck025<l_nmaf006 OR g_nmck_m.nmck025>l_nmaf007) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'anm-00153'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = FALSE
                     CALL cl_err()
                  
                     LET g_nmck_m.nmck025=g_nmck_m_t.nmck025
                     NEXT FIELD nmck025
                  END IF
                  
                  SELECT COUNT(*) INTO l_cnt FROM nmck_t
                   WHERE nmckent=g_enterprise AND nmck004=g_nmck_m.nmck004
                     AND nmck002=g_nmck_m.nmck002 AND nmck025=g_nmck_m.nmck025
                     AND nmckdocno <> g_nmck_m.nmckdocno
                  IF l_cnt>0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'anm-00157'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = FALSE
                     CALL cl_err()
                  
                     LET g_nmck_m.nmck025=g_nmck_m_t.nmck025
                     NEXT FIELD nmck025
                  END IF
                  #160119--s
                  LET l_cnt = 0
                  SELECT COUNT(*) INTO l_cnt FROM nmcd_t
                   WHERE nmcdent = g_enterprise 
                     AND nmcd002 = g_nmck_m.nmck024
                     AND nmcd003 = g_nmck_m.nmck025
                     AND nmcd008 = 'Y' 
                  IF l_cnt > 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'anm-02972'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = FALSE
                     CALL cl_err()                  
                     LET g_nmck_m.nmck025=g_nmck_m_t.nmck025
                     NEXT FIELD nmck025
                  END IF                  
                  #160119--e                  
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmck025
            #add-point:ON CHANGE nmck025 name="input.g.nmck025"
            IF cl_null(g_nmck_m.nmck026) THEN
               IF NOT cl_null(g_nmck_m.nmck025) THEN
                  LET g_nmck_m.nmck026='1'
               ELSE
                  LET g_nmck_m.nmck026='0'
               END IF
               DISPLAY BY NAME g_nmck_m.nmck026
            END IF
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck026
            #add-point:BEFORE FIELD nmck026 name="input.b.nmck026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck026
            
            #add-point:AFTER FIELD nmck026 name="input.a.nmck026"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmck026
            #add-point:ON CHANGE nmck026 name="input.g.nmck026"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck114
            #add-point:BEFORE FIELD nmck114 name="input.b.nmck114"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck114
            
            #add-point:AFTER FIELD nmck114 name="input.a.nmck114"
            LET g_nmck_m_o.* = g_nmck_m.*   #160822-00012#5   add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmck114
            #add-point:ON CHANGE nmck114 name="input.g.nmck114"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck124
            #add-point:BEFORE FIELD nmck124 name="input.b.nmck124"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck124
            
            #add-point:AFTER FIELD nmck124 name="input.a.nmck124"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmck124
            #add-point:ON CHANGE nmck124 name="input.g.nmck124"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck134
            #add-point:BEFORE FIELD nmck134 name="input.b.nmck134"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck134
            
            #add-point:AFTER FIELD nmck134 name="input.a.nmck134"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmck134
            #add-point:ON CHANGE nmck134 name="input.g.nmck134"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck005
            
            #add-point:AFTER FIELD nmck005 name="input.a.nmck005"
            CALL anmt440_nmck005_desc()
            IF NOT cl_null(g_nmck_m.nmck005) THEN 
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_nmck_m.nmck005
               LET g_chkparam.arg2 = g_nmck_m.nmckcomp    #161228-00018#1 add lujh
               #IF cl_chk_exist("v_pmaa001_1") THEN       #161228-00018#1 mark lujh
               IF cl_chk_exist("v_pmab001_5") THEN        #161228-00018#1 add lujh
                  #交易對象之匯款銀行戶號 
                  SELECT pmaal003 INTO g_nmck_m.nmck015
                    FROM pmaal_t
                  WHERE pmaalent=g_enterprise AND pmaal002=g_lang
                    AND pmaal001 = g_nmck_m.nmck005     #付款對象
                  DISPLAY g_nmck_m.nmck015 TO nmck015
                  
                  SELECT pmaa027,pmaa004 INTO l_pmaa027,l_pmaa004
                    FROM pmaa_t
                   WHERE pmaaent = g_enterprise
                     AND pmaa001 = g_nmck_m.nmck005
                  IF l_pmaa004 = '2' THEN 
                     INITIALIZE g_qryparam.* TO NULL
                     LET g_qryparam.state = 'i'
	                  LET g_qryparam.reqry = FALSE
                     LET g_qryparam.arg1 = g_nmck_m.nmck005
                     CALL q_pmak002()
                     LET g_nmck_m.nmck006 = g_qryparam.return1
                     CALL anmt440_nmck005_desc()
                  ELSE
                     LET g_nmck_m.nmck006 = ''
                  END IF
                  #150825-00004#1 add ------
                  #如果付款對象是EMPL就顯示
                  IF g_nmck_m.nmck005 = 'EMPL' THEN
                     CALL cl_set_comp_visible('nmck006,nmck006_desc',TRUE)
                  ELSE
                     CALL cl_set_comp_visible('nmck006,nmck006_desc',FALSE)
                  END IF
                  #150825-00004#1 add ------
               ELSE
                  #檢查失敗時後續處理
                  LET g_nmck_m.nmck005 = g_nmck_m_t.nmck005
                  CALL anmt440_nmck005_desc()
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck005
            #add-point:BEFORE FIELD nmck005 name="input.b.nmck005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmck005
            #add-point:ON CHANGE nmck005 name="input.g.nmck005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck006
            
            #add-point:AFTER FIELD nmck006 name="input.a.nmck006"
            #150825-00004#1 add ------
            IF NOT cl_null(g_nmck_m.nmck006) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_nmck_m.nmck006 != g_nmck_m_t.nmck006 OR g_nmck_m_t.nmck006 IS NULL )) THEN   #160822-00012#5   mark
               IF g_nmck_m.nmck006 != g_nmck_m_o.nmck006 OR cl_null(g_nmck_m_o.nmck006) THEN                                       #160822-00012#5   add
                  CALL s_employee_chk(g_nmck_m.nmck006)RETURNING g_sub_success
                  IF NOT g_sub_success THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = g_errno
                      LET g_errparam.extend = ''
                      LET g_errparam.popup = TRUE
                      CALL cl_err()
                     #LET g_nmck_m.nmck006 = g_nmck_m_t.nmck006   #160822-00012#5   mark
                     LET g_nmck_m.nmck006 = g_nmck_m_o.nmck006    #160822-00012#5   add
                     LET g_nmck_m.nmck006_desc = s_desc_get_person_desc(g_nmck_m.nmck006)
                     DISPLAY BY NAME g_nmck_m.nmck006_desc
                     NEXT FIELD CURRENT
                  END IF
                  #抓該員工的帳戶資料
                  LET g_nmck_m.nmck015 = ''    #160822-00012#5   add
                  SELECT ooag011 INTO g_nmck_m.nmck015
                    FROM ooag_t
                   WHERE ooagent = g_enterprise
                     AND ooag001 = g_nmck_m.nmck006
                  DISPLAY BY NAME g_nmck_m.nmck015
               END IF
            END IF
            LET g_nmck_m.nmck006_desc = s_desc_get_person_desc(g_nmck_m.nmck006)
            DISPLAY BY NAME g_nmck_m.nmck006_desc
            #150825-00004#1 add end---
            LET g_nmck_m_o.* = g_nmck_m.*    #160822-00012#5   add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck006
            #add-point:BEFORE FIELD nmck006 name="input.b.nmck006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmck006
            #add-point:ON CHANGE nmck006 name="input.g.nmck006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck015
            #add-point:BEFORE FIELD nmck015 name="input.b.nmck015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck015
            
            #add-point:AFTER FIELD nmck015 name="input.a.nmck015"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmck015
            #add-point:ON CHANGE nmck015 name="input.g.nmck015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck030
            #add-point:BEFORE FIELD nmck030 name="input.b.nmck030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck030
            
            #add-point:AFTER FIELD nmck030 name="input.a.nmck030"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmck030
            #add-point:ON CHANGE nmck030 name="input.g.nmck030"
            IF NOT cl_null(g_nmck_m.nmck030) THEN
               CALL cl_set_comp_required('nmck031,nmck032',TRUE)
               IF NOT cl_null(g_nmck_m.nmck031) THEN
                  IF g_nmck_m.nmck031<=0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'anm-00149'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = FALSE
                     CALL cl_err()

                     NEXT FIELD nmck031
                  END IF                  
               END IF 
            ELSE
               CALL cl_set_comp_required('nmck031',FALSE)
               LET g_nmck_m.nmck031=0
               DISPLAY BY NAME g_nmck_m.nmck031
            END IF
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck031
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_nmck_m.nmck031,"0","1","","","azz-00079",1) THEN
               NEXT FIELD nmck031
            END IF 
 
 
 
            #add-point:AFTER FIELD nmck031 name="input.a.nmck031"
            IF NOT cl_null(g_nmck_m.nmck031) AND NOT cl_null(g_nmck_m.nmck030) THEN 
               IF g_nmck_m.nmck031=0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'anm-00149'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  LET g_nmck_m.nmck031=g_nmck_m_t.nmck031
                  NEXT FIELD nmck031
               END IF
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck031
            #add-point:BEFORE FIELD nmck031 name="input.b.nmck031"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmck031
            #add-point:ON CHANGE nmck031 name="input.g.nmck031"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck028
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_nmck_m.nmck028,"0","1","","","azz-00079",1) THEN
               NEXT FIELD nmck028
            END IF 
 
 
 
            #add-point:AFTER FIELD nmck028 name="input.a.nmck028"
            IF NOT cl_null(g_nmck_m.nmck028) AND NOT cl_null(g_nmck_m.nmck046) THEN 
               IF cl_null(g_nmck_m.nmck113) THEN LET g_nmck_m.nmck113=0 END IF
               CALL s_aooi160_get_exrate('1',g_nmck_m.nmckcomp,g_nmck_m.nmckdocdt,g_nmck_m.nmck100,  
                                         #目的幣別;  交易金額;              匯類類型
                                         g_nmck_m.nmck046,0,g_para_data2)   #150930-00010#4
                                        #g_nmck_m.nmck046,0,g_para_data1)   #150930-00010#4 mark
               RETURNING l_exrate
               LET g_nmck_m.nmck029=g_nmck_m.nmck103*l_exrate*g_nmck_m.nmck028/100
               CALL s_curr_round_ld('1',g_glaald,g_nmck_m.nmck100,g_nmck_m.nmck029,2)  #160524-00055#1
                   RETURNING g_sub_success,g_errno,g_nmck_m.nmck029                   #150714-00024#1                
               DISPLAY BY NAME g_nmck_m.nmck029
            END IF 

            LET g_nmck_m_o.* = g_nmck_m.*   #160822-00012#5   add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck028
            #add-point:BEFORE FIELD nmck028 name="input.b.nmck028"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmck028
            #add-point:ON CHANGE nmck028 name="input.g.nmck028"
            IF NOT cl_null(g_nmck_m.nmck028) AND g_nmck_m.nmck028<>0 THEN 
               CALL cl_set_comp_required('nmck032',TRUE)
            END IF
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck029
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_nmck_m.nmck029,"0","1","","","azz-00079",1) THEN
               NEXT FIELD nmck029
            END IF 
 
 
 
            #add-point:AFTER FIELD nmck029 name="input.a.nmck029"
            IF NOT cl_null(g_nmck_m.nmck029) THEN 
            END IF 

            LET g_nmck_m_o.* = g_nmck_m.*   #160822-00012#5   add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck029
            #add-point:BEFORE FIELD nmck029 name="input.b.nmck029"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmck029
            #add-point:ON CHANGE nmck029 name="input.g.nmck029"
            IF NOT cl_null(g_nmck_m.nmck029) THEN 
               CALL cl_set_comp_required('nmck032',TRUE)
            END IF
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck032
            
            #add-point:AFTER FIELD nmck032 name="input.a.nmck032"
            IF NOT cl_null(g_nmck_m.nmck032) THEN 
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_nmck_m.nmck032
               #160318-00025#1--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "anm-00012:sub-01302|anmi100|",cl_get_progname("anmi100",g_lang,"2"),"|:EXEPROGanmi100"
               #160318-00025#1--add--end
               IF cl_chk_exist("v_nmab001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                  SELECT COUNT(*) INTO l_n
                    FROM nmab_t
                   WHERE nmabent = g_enterprise
                     AND nmab001 = g_nmck_m.nmck032
                     AND nmab008 = g_ooef006
                  IF l_n = 0 THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'anm-00128'
                     LET g_errparam.extend = g_nmck_m.nmck032
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_nmck_m.nmck032 = g_nmck_m_t.nmck032
                     CALL anmt440_nmck032_desc()
                     NEXT FIELD CURRENT
                  END IF
               ELSE
                  #檢查失敗時後續處理
                  LET g_nmck_m.nmck032 = g_nmck_m_t.nmck032
                  CALL anmt440_nmck032_desc()
                  NEXT FIELD CURRENT
               END IF
            END IF
            CALL anmt440_nmck032_desc()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck032
            #add-point:BEFORE FIELD nmck032 name="input.b.nmck032"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmck032
            #add-point:ON CHANGE nmck032 name="input.g.nmck032"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck044
            
            #add-point:AFTER FIELD nmck044 name="input.a.nmck044"
            IF NOT cl_null(g_nmck_m.nmck044) THEN 
#應用 a19 樣板自動產生(Version:1)
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_nmck_m.nmck044
               LET g_chkparam.arg2 = g_nmck_m.nmck046
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_nmas002_10") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                  #160122-00001#27--add---str
                  IF NOT s_anmi120_nmll002_chk(g_nmck_m.nmck044,g_user) THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_nmck_m.nmck044
                     LET g_errparam.code   = 'anm-00574' 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET g_nmck_m.nmck044 = g_nmck_m_t.nmck044
                     CALL anmt440_nmck044_desc()  #160524-00055#1
                     NEXT FIELD CURRENT
                  END IF
                  #160122-00001#27--add---end
               ELSE
                  #檢查失敗時後續處理
                  LET g_nmck_m.nmck044 = g_nmck_m_t.nmck044 #160524-00055#1
                  CALL anmt440_nmck044_desc()  #160524-00055#1
                  NEXT FIELD CURRENT
               END IF
               #160829-00032#1 Add  ---(S)---
               IF NOT cl_null(g_nmck_m.nmckcomp) THEN
                  LET l_count = 0
                  SELECT COUNT(*) INTO l_count FROM nmas_t WHERE nmasent = g_enterprise
                     AND nmas001 IN (SELECT nmaa001 FROM nmaa_t WHERE nmaaent = g_enterprise AND nmaa002 = g_nmck_m.nmckcomp)
                     AND nmas002 = g_nmck_m.nmck044
                  IF cl_null(l_count) THEN lET l_count = 0 END IF
                  IF l_count = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'anm-00407'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_nmck_m.nmck044 = g_nmck_m_t.nmck044
                     NEXT FIELD CURRENT
                  END IF
               END IF
               #160829-00032#1 Add  ---(E)---
               #160524-00055#1  add s--
               IF NOT cl_null(g_nmck_m.nmck045) THEN 
                  IF g_nmck_m.nmck045 = g_nmck_m.nmck044 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'anm-03005'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()  
                     LET g_nmck_m.nmck044 = g_nmck_m_t.nmck044
                     CALL anmt440_nmck044_desc() 
                     NEXT FIELD CURRENT                     
                  END IF
               END IF
               #160524-00055#1  add e--
               CALL anmt440_nmck044_desc()  #160524-00055#1

            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck044
            #add-point:BEFORE FIELD nmck044 name="input.b.nmck044"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmck044
            #add-point:ON CHANGE nmck044 name="input.g.nmck044"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck045
            
            #add-point:AFTER FIELD nmck045 name="input.a.nmck045"
            IF NOT cl_null(g_nmck_m.nmck045) THEN 
#應用 a19 樣板自動產生(Version:1)
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_nmck_m.nmck045
               LET g_chkparam.arg2 = g_nmck_m.nmck046
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_nmas002_10") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                  #160122-00001#27--add---str
                  IF NOT s_anmi120_nmll002_chk(g_nmck_m.nmck045,g_user) THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_nmck_m.nmck045
                     LET g_errparam.code   = 'anm-00574' 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET g_nmck_m.nmck045 = g_nmck_m_t.nmck045
                     CALL anmt440_nmck045_desc()  #160524-00055#1
                     NEXT FIELD CURRENT
                  END IF
                  #160122-00001#27--add---end
               ELSE
                  #檢查失敗時後續處理
                  LET g_nmck_m.nmck045 = g_nmck_m_t.nmck045 #160524-00055#1
                  CALL anmt440_nmck045_desc()  #160524-00055#1
                  NEXT FIELD CURRENT
               END IF
               #160829-00032#1 Add  ---(S)---
               IF NOT cl_null(g_nmck_m.nmckcomp) THEN
                  LET l_count = 0
                  SELECT COUNT(*) INTO l_count FROM nmas_t WHERE nmasent = g_enterprise
                     AND nmas001 IN (SELECT nmaa001 FROM nmaa_t WHERE nmaaent = g_enterprise AND nmaa002 = g_nmck_m.nmckcomp)
                     AND nmas002 = g_nmck_m.nmck045
                  IF cl_null(l_count) THEN lET l_count = 0 END IF
                  IF l_count = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'anm-00407'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_nmck_m.nmck045 = g_nmck_m_t.nmck045
                     NEXT FIELD CURRENT
                  END IF
               END IF
               #160829-00032#1 Add  ---(E)---
            END IF 
            #160524-00055#1 add s---
            IF NOT cl_null(g_nmck_m.nmck044) THEN 
               IF g_nmck_m.nmck045 = g_nmck_m.nmck044 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'anm-03005'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()  
                  LET g_nmck_m.nmck045 = g_nmck_m_t.nmck045
                  CALL anmt440_nmck045_desc() 
                  NEXT FIELD CURRENT                  
               END IF
            END IF            
            
            IF NOT cl_null(g_nmck_m.nmck045) THEN 
               CALL cl_set_comp_entry("nmck051",TRUE)
            ELSE
               CALL cl_set_comp_entry("nmck051",FALSE)
               LET g_nmck_m.nmck051 = ''   #来源账户为空时，直接清空单别
               CALL anmt440_nmck045_desc() 
               DISPLAY  g_nmck_m.nmck051 TO nmck051
               #NEXT FIELD CURRENT 
            END IF   
            
                

                 
            CALL anmt440_nmck045_desc()  
            #160524-00055#1 add e---

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck045
            #add-point:BEFORE FIELD nmck045 name="input.b.nmck045"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmck045
            #add-point:ON CHANGE nmck045 name="input.g.nmck045"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck047
            
            #add-point:AFTER FIELD nmck047 name="input.a.nmck047"
            IF NOT cl_null(g_nmck_m.nmck047) THEN 
#應用 a19 樣板自動產生(Version:1)
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_nmck_m.nmck047
               #160318-00025#1--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aap-00002:sub-01302|aapi010|",cl_get_progname("aapi010",g_lang,"2"),"|:EXEPROGaapi010"
               #160318-00025#1--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_nmaj001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                  CALL anmt440_nmck047_desc()  #160524-00055#1
               ELSE
                  #檢查失敗時後續處理
                  LET g_nmck_m.nmck047 = g_nmck_m_t.nmck047 #160524-00055#1
                  CALL anmt440_nmck047_desc()  #160524-00055#1
                  NEXT FIELD CURRENT
               END IF
               CALL anmt440_nmck047_desc()  #160524-00055#1

            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck047
            #add-point:BEFORE FIELD nmck047 name="input.b.nmck047"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmck047
            #add-point:ON CHANGE nmck047 name="input.g.nmck047"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck048
            
            #add-point:AFTER FIELD nmck048 name="input.a.nmck048"
            IF NOT cl_null(g_nmck_m.nmck048) THEN 
#應用 a19 樣板自動產生(Version:1)
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_nmck_m.nmck048
               #160318-00025#1--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aap-00002:sub-01302|aapi010|",cl_get_progname("aapi010",g_lang,"2"),"|:EXEPROGaapi010"
               #160318-00025#1--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_nmaj001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                  CALL anmt440_nmck048_desc()  #160524-00055#1
               ELSE
                  #檢查失敗時後續處理
                  LET g_nmck_m.nmck048 = g_nmck_m_t.nmck048 #160524-00055#1
                  CALL anmt440_nmck048_desc()  #160524-00055#1
                  NEXT FIELD CURRENT
               END IF
               CALL anmt440_nmck048_desc()  #160524-00055#1

            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck048
            #add-point:BEFORE FIELD nmck048 name="input.b.nmck048"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmck048
            #add-point:ON CHANGE nmck048 name="input.g.nmck048"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck049
            
            #add-point:AFTER FIELD nmck049 name="input.a.nmck049"
            IF NOT cl_null(g_nmck_m.nmck049) THEN 
#應用 a19 樣板自動產生(Version:1)
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_nmck_m.nmck049
               LET g_chkparam.arg2 = g_glaa005
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_nmai002") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                  CALL anmt440_nmck049_desc()  #160524-00055#1
               ELSE
                  #檢查失敗時後續處理
                  LET g_nmck_m.nmck049 = g_nmck_m_t.nmck049 #160524-00055#1
                  CALL anmt440_nmck049_desc()  #160524-00055#1
                  NEXT FIELD CURRENT
               END IF
               CALL anmt440_nmck049_desc()  #160524-00055#1


            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck049
            #add-point:BEFORE FIELD nmck049 name="input.b.nmck049"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmck049
            #add-point:ON CHANGE nmck049 name="input.g.nmck049"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck050
            
            #add-point:AFTER FIELD nmck050 name="input.a.nmck050"
            IF NOT cl_null(g_nmck_m.nmck050) THEN 
#應用 a19 樣板自動產生(Version:1)
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_nmck_m.nmck050
               LET g_chkparam.arg2 = g_glaa005
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_nmai002") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                  CALL anmt440_nmck050_desc()  #160524-00055#1
               ELSE
                  #檢查失敗時後續處理
                  LET g_nmck_m.nmck050 = g_nmck_m_t.nmck050 #160524-00055#1
                  CALL anmt440_nmck050_desc()  #160524-00055#1
                  NEXT FIELD CURRENT
               END IF
               CALL anmt440_nmck050_desc()  #160524-00055#1

            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck050
            #add-point:BEFORE FIELD nmck050 name="input.b.nmck050"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmck050
            #add-point:ON CHANGE nmck050 name="input.g.nmck050"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmck051
            #add-point:BEFORE FIELD nmck051 name="input.b.nmck051"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmck051
            
            #add-point:AFTER FIELD nmck051 name="input.a.nmck051"
            #160524-00055#1 add s---
            IF NOT cl_null(g_nmck_m.nmck051) THEN    
               #是否可以使用单别
               SELECT COUNT(*) INTO l_cnt FROM oobl_t
                WHERE ooblent = g_enterprise
                  AND oobl001 = g_nmck_m.nmck051
                  AND oobl002 = 'anmt310'
               IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
               IF l_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'sub-00250'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  LET g_errparam.replace[1] = 'anmt310'
                  LET g_errparam.replace[2] = g_nmck_m.nmck051
                  CALL cl_err()
                  LET g_nmck_m.nmck051 = g_nmck_m_t.nmck051
                  NEXT FIELD nmck051                  
               END IF 
            END IF   
            #160524-00055 add e---   
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmck051
            #add-point:ON CHANGE nmck051 name="input.g.nmck051"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.nmcksite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmcksite
            #add-point:ON ACTION controlp INFIELD nmcksite name="input.c.nmcksite"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_nmck_m.nmcksite
           #LET g_qryparam.where = " ooef206 = 'Y'"   #161102-00048#1 Mark
           #LET g_qryparam.where = g_qryparam.where," AND ooefstus= 'Y'" #161021-00050#8 #161102-00048#1 Mark
            LET g_qryparam.where = " ooefstus= 'Y'"   #161102-00048#1 Add
            #CALL q_ooef001()    #161021-00050#8 mark
            CALL q_ooef001_33()  #161021-00050#8
            LET g_nmck_m.nmcksite = g_qryparam.return1
            CALL anmt440_nmcksite_desc()
            DISPLAY g_nmck_m.nmcksite TO nmcksite
            NEXT FIELD nmcksite
            #END add-point
 
 
         #Ctrlp:input.c.nmckcomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmckcomp
            #add-point:ON ACTION controlp INFIELD nmckcomp name="input.c.nmckcomp"
            #開窗i段-法人
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_nmck_m.nmckcomp
            LET g_qryparam.default2 = "" #g_nmck_m.ooefl003 #說明(簡稱)
            #150714-00024#1 mark ------
            ##2015/04/01--by 02599--add--str--
            ##CALL s_fin_create_account_center_tmp()
            #CALL s_fin_account_center_sons_query('6',g_nmck_m.nmcksite,g_today,'')
            #CALL s_fin_account_center_comp_str()RETURNING l_origin_str
            #CALL s_fin_get_wc_str(l_origin_str)RETURNING l_origin_str
            #LET g_qryparam.where = " ooef003 = 'Y' AND ooef001 IN ",l_origin_str CLIPPED
            ##2015/04/01--by 02599--add--end
            #150714-00024#1 mark end---
            CALL s_anm_get_comp_wc('6',g_nmck_m.nmcksite,g_nmck_m.nmckdocdt) RETURNING g_comp_wc #160816-00012#3 add
            LET g_qryparam.where = " ooef001 IN ",g_comp_wc   #150714-00024#1
            #CALL q_ooef001()  #161021-00050#8 mark
            CALL q_ooef001_2() #161021-00050#8
            LET g_nmck_m.nmckcomp = g_qryparam.return1
            #LET g_nmck_m.ooefl003 = g_qryparam.return2
            CALL anmt440_nmckcomp_desc()
            DISPLAY g_nmck_m.nmckcomp TO nmckcomp
            #DISPLAY g_nmck_m.ooefl003 TO ooefl003 #說明(簡稱)
            NEXT FIELD nmckcomp
            #END add-point
 
 
         #Ctrlp:input.c.nmck003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck003
            #add-point:ON ACTION controlp INFIELD nmck003 name="input.c.nmck003"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_nmck_m.nmck003             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooag001_8()                                #呼叫開窗

            LET g_nmck_m.nmck003 = g_qryparam.return1              

            DISPLAY g_nmck_m.nmck003 TO nmck003              #

            NEXT FIELD nmck003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.nmckdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmckdocno
            #add-point:ON ACTION controlp INFIELD nmckdocno name="input.c.nmckdocno"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_nmck_m.nmckdocno             #給予default值
            
#            LET g_qryparam.where = " ooba001 = '",g_glaa024,"' AND oobx003 = 'anmt440'"  #161213-00020#1 20170209 mark by 08172
            LET g_qryparam.where = " ooba001 = '",g_glaa024,"' AND EXISTS (SELECT 1 FROM oobl_t WHERE ooblent=oobaent  AND oobl001=ooba002 AND oobl002='anmt440' )"   #161213-00020#1 add by 08172
            #給予arg
            LET g_qryparam.arg1 = "" #
            #161104-00046#13-----s
            IF NOT cl_null(g_user_slip_wc)THEN
               LET g_qryparam.where = g_qryparam.where," AND ",g_user_slip_wc CLIPPED
            END IF
            #161104-00046#13-----e
            CALL q_ooba002()                                #呼叫開窗

            LET g_nmck_m.nmckdocno = g_qryparam.return1              

            DISPLAY g_nmck_m.nmckdocno TO nmckdocno              #

            NEXT FIELD nmckdocno                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.nmck002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck002
            #add-point:ON ACTION controlp INFIELD nmck002 name="input.c.nmck002"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmckdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmckdocdt
            #add-point:ON ACTION controlp INFIELD nmckdocdt name="input.c.nmckdocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmck004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck004
            #add-point:ON ACTION controlp INFIELD nmck004 name="input.c.nmck004"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_nmck_m.nmck004             #給予default值
            LET g_qryparam.where = " nmaa002 IN (select ooef001 FROM ooef_t WHERE ooefent = '",g_enterprise,"'",
                                   "              AND ooef017 = '",g_nmck_m.nmckcomp,"')",
                                   " AND nmaa003 IN (SELECT nmag001 FROM nmag_t WHERE nmagent = '",g_enterprise,"'",
                                   #"                    AND (nmag002 = '1' OR nmag002 = '4'))"                    #160708-00004#1
                                   "                    AND (nmag002 = '1' OR nmag002 = '4') AND nmagstus = 'Y')"  #160708-00004#1
            #160122-00001#27 by 07673 mark --str
#            #160122-00001#27--add---str
#            LET g_qryparam.where = g_qryparam.where CLIPPED, " AND nmas002 IN (SELECT nmll001 FROM nmll_t WHERE nmllent = ",g_enterprise,
#                                   " AND nmll002 = '",g_user,"')"
#            #160122-00001#27--add---end
            #160122-00001#27 by 07673 mark --end 
            #160122-00001#27 by 07673 add -str
            LET g_qryparam.where =g_qryparam.where CLIPPED, " AND  nmas002 IN (",g_sql_bank,")"
            #160122-00001#27 by 07673 add -end
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_nmas_01()                                #呼叫開窗

            LET g_nmck_m.nmck004 = g_qryparam.return1              
            CALL anmt440_nmck004_desc()
            DISPLAY g_nmck_m.nmck004 TO nmck004              #
            LET g_qryparam.where = " "             #160122-00001#27

            NEXT FIELD nmck004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.nmas003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmas003
            #add-point:ON ACTION controlp INFIELD nmas003 name="input.c.nmas003"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmck019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck019
            #add-point:ON ACTION controlp INFIELD nmck019 name="input.c.nmck019"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmckstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmckstus
            #add-point:ON ACTION controlp INFIELD nmckstus name="input.c.nmckstus"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmck001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck001
            #add-point:ON ACTION controlp INFIELD nmck001 name="input.c.nmck001"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmck103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck103
            #add-point:ON ACTION controlp INFIELD nmck103 name="input.c.nmck103"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmck101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck101
            #add-point:ON ACTION controlp INFIELD nmck101 name="input.c.nmck101"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmck113
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck113
            #add-point:ON ACTION controlp INFIELD nmck113 name="input.c.nmck113"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmck121
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck121
            #add-point:ON ACTION controlp INFIELD nmck121 name="input.c.nmck121"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmck123
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck123
            #add-point:ON ACTION controlp INFIELD nmck123 name="input.c.nmck123"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmck131
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck131
            #add-point:ON ACTION controlp INFIELD nmck131 name="input.c.nmck131"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmck133
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck133
            #add-point:ON ACTION controlp INFIELD nmck133 name="input.c.nmck133"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmck034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck034
            #add-point:ON ACTION controlp INFIELD nmck034 name="input.c.nmck034"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmck035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck035
            #add-point:ON ACTION controlp INFIELD nmck035 name="input.c.nmck035"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmck036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck036
            #add-point:ON ACTION controlp INFIELD nmck036 name="input.c.nmck036"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmck011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck011
            #add-point:ON ACTION controlp INFIELD nmck011 name="input.c.nmck011"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmck009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck009
            #add-point:ON ACTION controlp INFIELD nmck009 name="input.c.nmck009"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_nmck_m.nmck009             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_glaa005
            LET g_qryparam.where = " nmad002 IN (SELECT nmaj001 FROM nmaj_t WHERE nmaj002='2'AND nmajstus='Y' AND nmajent = ",g_enterprise," )"
            
            CALL q_nmad002()                                #呼叫開窗

            LET g_nmck_m.nmck009 = g_qryparam.return1              
            CALL anmt440_nmck009_desc()
            DISPLAY g_nmck_m.nmck009 TO nmck009              #

            NEXT FIELD nmck009                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.nmck010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck010
            #add-point:ON ACTION controlp INFIELD nmck010 name="input.c.nmck010"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_nmck_m.nmck010             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #
            LET g_qryparam.where = " nmai001='",g_glaa005,"' "   #160413-00039#1 add 
            
            CALL q_nmai002()                                #呼叫開窗

            LET g_nmck_m.nmck010 = g_qryparam.return1              
            CALL anmt440_nmck010_desc()
            DISPLAY g_nmck_m.nmck010 TO nmck010              #

            NEXT FIELD nmck010                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.nmck024
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck024
            #add-point:ON ACTION controlp INFIELD nmck024 name="input.c.nmck024"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_nmck_m.nmck024             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_nmck_m.nmck004 #
            LET g_qryparam.arg2 = g_nmck_m.nmck002 #
            LET g_qryparam.where = " nmaf011 = 'N' " #160830-00039#1 add
            CALL q_nmaf004()                                #呼叫開窗

            LET g_nmck_m.nmck024 = g_qryparam.return1              

            DISPLAY g_nmck_m.nmck024 TO nmck024              #

            NEXT FIELD nmck024                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.nmck027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck027
            #add-point:ON ACTION controlp INFIELD nmck027 name="input.c.nmck027"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmck025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck025
            #add-point:ON ACTION controlp INFIELD nmck025 name="input.c.nmck025"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmck026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck026
            #add-point:ON ACTION controlp INFIELD nmck026 name="input.c.nmck026"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmck114
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck114
            #add-point:ON ACTION controlp INFIELD nmck114 name="input.c.nmck114"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmck124
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck124
            #add-point:ON ACTION controlp INFIELD nmck124 name="input.c.nmck124"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmck134
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck134
            #add-point:ON ACTION controlp INFIELD nmck134 name="input.c.nmck134"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmck005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck005
            #add-point:ON ACTION controlp INFIELD nmck005 name="input.c.nmck005"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_nmck_m.nmck005
            #CALL q_pmaa001_10()   #161228-00018#1 mark lujh
            #161228-00018#1--add--str--lujh
            LET g_qryparam.arg1 = g_nmck_m.nmckcomp
            CALL q_pmab001_3()
            #161228-00018#1--add--end--lujh
            LET g_nmck_m.nmck005 = g_qryparam.return1
            CALL anmt440_nmck005_desc()
            DISPLAY g_nmck_m.nmck005 TO nmck005
            NEXT FIELD nmck005
            #END add-point
 
 
         #Ctrlp:input.c.nmck006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck006
            #add-point:ON ACTION controlp INFIELD nmck006 name="input.c.nmck006"
            #150825-00004#1 add ------
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_nmck_m.nmck006
            CALL q_ooag001()
            LET g_nmck_m.nmck006 = g_qryparam.return1
            LET g_nmck_m.nmck006_desc = s_desc_get_person_desc(g_nmck_m.nmck006)
            DISPLAY BY NAME g_nmck_m.nmck006,g_nmck_m.nmck006_desc
            NEXT FIELD nmck006
            #150825-00004#1 add end---
            #END add-point
 
 
         #Ctrlp:input.c.nmck015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck015
            #add-point:ON ACTION controlp INFIELD nmck015 name="input.c.nmck015"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmck030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck030
            #add-point:ON ACTION controlp INFIELD nmck030 name="input.c.nmck030"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmck031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck031
            #add-point:ON ACTION controlp INFIELD nmck031 name="input.c.nmck031"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmck028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck028
            #add-point:ON ACTION controlp INFIELD nmck028 name="input.c.nmck028"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmck029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck029
            #add-point:ON ACTION controlp INFIELD nmck029 name="input.c.nmck029"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmck032
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck032
            #add-point:ON ACTION controlp INFIELD nmck032 name="input.c.nmck032"
            #開窗i段-承兌銀行
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_nmck_m.nmck032
            LET g_qryparam.where = " nmab008 = '",g_ooef006,"'" #150714-00024#1 add
            CALL q_nmab001()
            LET g_nmck_m.nmck032 = g_qryparam.return1
            DISPLAY g_nmck_m.nmck032 TO nmck032
            NEXT FIELD nmck032
            #END add-point
 
 
         #Ctrlp:input.c.nmck044
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck044
            #add-point:ON ACTION controlp INFIELD nmck044 name="input.c.nmck044"
            #應用 a07 樣板自動產生(Version:1)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_nmck_m.nmck044             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_nmck_m.nmck046
            #160122-00001#27 by 07673--modify---str
            LET g_qryparam.where = " nmas002 IN (",g_sql_bank,")"
            #160122-00001#27 by 07673 --modify---end
            LET g_qryparam.where = g_qryparam.where," AND nmas001 IN (SELECT nmaa001 FROM nmaa_t WHERE nmaaent = '",g_enterprise,"' AND nmaa002 = '",g_nmck_m.nmckcomp,"')"#160829-00032#1 Add

            
            CALL q_nmas002_10()                                #呼叫開窗

            LET g_nmck_m.nmck044 = g_qryparam.return1              
            CALL anmt440_nmck044_desc()                    #160524-00055#1 
            DISPLAY g_nmck_m.nmck044 TO nmck044              #
            DISPLAY g_nmck_m.nmck044_desc TO nmck044_desc  #160524-00055#1
            LET g_qryparam.where = " "             #160122-00001#27

            NEXT FIELD nmck044                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.nmck045
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck045
            #add-point:ON ACTION controlp INFIELD nmck045 name="input.c.nmck045"
            #應用 a07 樣板自動產生(Version:1)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_nmck_m.nmck045             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_nmck_m.nmck046
            
            #160122-00001#27 by 07673--modify---str
            LET g_qryparam.where = " nmas002 IN (",g_sql_bank,")"
            #160122-00001#27 by 07673 --modify---end
            LET g_qryparam.where = g_qryparam.where," AND nmas001 IN (SELECT nmaa001 FROM nmaa_t WHERE nmaaent = '",g_enterprise,"' AND nmaa002 = '",g_nmck_m.nmckcomp,"')"#160829-00032#1 Add

            
            CALL q_nmas002_10()                                #呼叫開窗

            LET g_nmck_m.nmck045 = g_qryparam.return1              
            CALL anmt440_nmck045_desc()                    #160524-00055#1 
            DISPLAY g_nmck_m.nmck045 TO nmck045              #
            DISPLAY g_nmck_m.nmck045_desc TO nmck045_desc  #160524-00055#1
            LET g_qryparam.where = " "             #160122-00001#27

            NEXT FIELD nmck045                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.nmck047
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck047
            #add-point:ON ACTION controlp INFIELD nmck047 name="input.c.nmck047"
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_nmck_m.nmck047
            LET g_qryparam.where = " nmaj002 = '1'"
            CALL q_nmaj001()
            LET g_nmck_m.nmck047 = g_qryparam.return1
            CALL anmt440_nmck047_desc()                    #160524-00055#1 
            DISPLAY g_nmck_m.nmck047 TO nmck047
            DISPLAY g_nmck_m.nmck047_desc TO nmck047_desc  #160524-00055#1
            NEXT FIELD nmck047
            #END add-point
 
 
         #Ctrlp:input.c.nmck048
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck048
            #add-point:ON ACTION controlp INFIELD nmck048 name="input.c.nmck048"
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_nmck_m.nmck048
            LET g_qryparam.where = " nmaj002 = '2'"
            CALL q_nmaj001()
            LET g_nmck_m.nmck048 = g_qryparam.return1
            CALL anmt440_nmck048_desc()                    #160524-00055#1 
            DISPLAY g_nmck_m.nmck048 TO nmck048
            DISPLAY g_nmck_m.nmck048_desc TO nmck048_desc  #160524-00055#1
            NEXT FIELD nmck048
            #END add-point
 
 
         #Ctrlp:input.c.nmck049
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck049
            #add-point:ON ACTION controlp INFIELD nmck049 name="input.c.nmck049"
            #應用 a07 樣板自動產生(Version:1)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_nmck_m.nmck049             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

            LET g_qryparam.where = " nmai001 = '",g_glaa005,"'" #160621-00016#1 add
            CALL q_nmai002()                                #呼叫開窗

            LET g_nmck_m.nmck049 = g_qryparam.return1              
            CALL anmt440_nmck049_desc()                    #160524-00055#1 
            DISPLAY g_nmck_m.nmck049 TO nmck049              #
            DISPLAY g_nmck_m.nmck049_desc TO nmck049_desc  #160524-00055#1
            NEXT FIELD nmck049                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.nmck050
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck050
            #add-point:ON ACTION controlp INFIELD nmck050 name="input.c.nmck050"
            #應用 a07 樣板自動產生(Version:1)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_nmck_m.nmck050             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s
            LET g_qryparam.where = " nmai001 = '",g_glaa005,"'" #160621-00016#1 add
            
            CALL q_nmai002()                                #呼叫開窗
 
            LET g_nmck_m.nmck050 = g_qryparam.return1 
            CALL anmt440_nmck050_desc()                    #160524-00055#1             
            DISPLAY g_nmck_m.nmck050_desc TO nmck050_desc  #160524-00055#1
            DISPLAY g_nmck_m.nmck050 TO nmck050              #

            NEXT FIELD nmck050                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.nmck051
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmck051
            #add-point:ON ACTION controlp INFIELD nmck051 name="input.c.nmck051"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            #160524-00055#1 add s---
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_nmck_m.nmck051             #給予default值

            #給予arg
            LET g_qryparam.where = "ooba001 = '",g_glaa024,"' AND oobx003 = 'anmt310'" 

 
            CALL q_ooba002_4()                                #呼叫開窗
 
            LET g_nmck_m.nmck051 = g_qryparam.return1              

            DISPLAY g_nmck_m.nmck051 TO nmck051              #

            NEXT FIELD nmck051                          #返回原欄位
            #160524-00055#1 add e---


            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_nmck_m.nmckcomp,g_nmck_m.nmckdocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            IF (cl_null(g_nmck_m.nmck028) OR g_nmck_m.nmck028=0) AND 
               (cl_null(g_nmck_m.nmck029) OR g_nmck_m.nmck029=0) AND 
               cl_null(g_nmck_m.nmck030) THEN
               CALL cl_set_comp_required("nmck032",FALSE)
            ELSE
               CALL cl_set_comp_required("nmck032",TRUE)
            END IF
            IF NOT cl_null(g_nmck_m.nmck024) THEN 
               CALL anmt440_nmck024_chk(g_nmck_m.nmck024)
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
               
                  NEXT FIELD nmck024
               END IF
            END IF
            SELECT nmaf006,nmaf007 INTO l_nmaf006,l_nmaf007 FROM nmaf_t
             WHERE nmafent=g_enterprise AND nmaf001=g_nmck_m.nmck004 
               AND nmaf002=g_nmck_m.nmck002 AND nmaf004=g_nmck_m.nmck024 
               AND nmaf010<nmaf007 AND nmaf012='Y'
            IF g_nmck_m.nmck025<l_nmaf006 OR g_nmck_m.nmck025>l_nmaf007 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'anm-00153'
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               NEXT FIELD nmck025
            END IF
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
#               IF g_nmck_m.nmck002 = '2' AND cl_null(g_nmck_m.nmck017) AND cl_null(g_nmck_m.nmck018) THEN
#               IF g_nmck_m.nmck002 = '2' AND cl_null(g_nmck_m.nmck017) THEN 
#                  CALL cl_err('','anm-00135',1)
#                  NEXT FIELD nmck017
#               END IF
                  #财务改为使用s_aooi200_fin中的FUNCTION---2014/12/29 liuym mark-----str-----
                  #CALL s_aooi200_gen_docno(g_nmck_m.nmckcomp,g_nmck_m.nmckdocno,g_nmck_m.nmckdocdt,g_prog)
                        #RETURNING l_success,g_nmck_m.nmckdocno
                  #2014/12/29 liuym mark-----end-----
                  #2014/12/29 liuym add-----str-----
                  CALL s_aooi200_fin_gen_docno(g_glaald,g_glaa024,g_glaa003,g_nmck_m.nmckdocno,g_nmck_m.nmckdocdt,g_prog)
                        RETURNING l_success,g_nmck_m.nmckdocno
                  #2014/12/29 liuym add-----end-----                  
                  IF l_success  = 0  THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'apm-00003'
                     LET g_errparam.extend = g_nmck_m.nmckdocno
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     NEXT FIELD nmckdocno
                  END IF 
                  
                  LET g_nmck_m.nmck114 =  g_nmck_m.nmck113
                  LET g_nmck_m.nmck124 =  g_nmck_m.nmck123
                  LET g_nmck_m.nmck134 =  g_nmck_m.nmck133   
               #end add-point
               
               INSERT INTO nmck_t (nmckent,nmcksite,nmckcomp,nmck003,nmckdocno,nmck002,nmckdocdt,nmck004, 
                   nmck019,nmckstus,nmckownid,nmckowndp,nmckcrtid,nmckcrtdp,nmckcrtdt,nmckmodid,nmckmoddt, 
                   nmckcnfid,nmckcnfdt,nmck001,nmck100,nmck103,nmck101,nmck113,nmck121,nmck123,nmck131, 
                   nmck133,nmck034,nmck035,nmck022,nmck036,nmck023,nmck011,nmck009,nmck010,nmck024,nmck027, 
                   nmck025,nmck026,nmck114,nmck124,nmck134,nmck005,nmck006,nmck015,nmck046,nmck030,nmck031, 
                   nmck028,nmck029,nmck032,nmck044,nmck045,nmck047,nmck048,nmck049,nmck050,nmck051)
               VALUES (g_enterprise,g_nmck_m.nmcksite,g_nmck_m.nmckcomp,g_nmck_m.nmck003,g_nmck_m.nmckdocno, 
                   g_nmck_m.nmck002,g_nmck_m.nmckdocdt,g_nmck_m.nmck004,g_nmck_m.nmck019,g_nmck_m.nmckstus, 
                   g_nmck_m.nmckownid,g_nmck_m.nmckowndp,g_nmck_m.nmckcrtid,g_nmck_m.nmckcrtdp,g_nmck_m.nmckcrtdt, 
                   g_nmck_m.nmckmodid,g_nmck_m.nmckmoddt,g_nmck_m.nmckcnfid,g_nmck_m.nmckcnfdt,g_nmck_m.nmck001, 
                   g_nmck_m.nmck100,g_nmck_m.nmck103,g_nmck_m.nmck101,g_nmck_m.nmck113,g_nmck_m.nmck121, 
                   g_nmck_m.nmck123,g_nmck_m.nmck131,g_nmck_m.nmck133,g_nmck_m.nmck034,g_nmck_m.nmck035, 
                   g_nmck_m.nmck022,g_nmck_m.nmck036,g_nmck_m.nmck023,g_nmck_m.nmck011,g_nmck_m.nmck009, 
                   g_nmck_m.nmck010,g_nmck_m.nmck024,g_nmck_m.nmck027,g_nmck_m.nmck025,g_nmck_m.nmck026, 
                   g_nmck_m.nmck114,g_nmck_m.nmck124,g_nmck_m.nmck134,g_nmck_m.nmck005,g_nmck_m.nmck006, 
                   g_nmck_m.nmck015,g_nmck_m.nmck046,g_nmck_m.nmck030,g_nmck_m.nmck031,g_nmck_m.nmck028, 
                   g_nmck_m.nmck029,g_nmck_m.nmck032,g_nmck_m.nmck044,g_nmck_m.nmck045,g_nmck_m.nmck047, 
                   g_nmck_m.nmck048,g_nmck_m.nmck049,g_nmck_m.nmck050,g_nmck_m.nmck051) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_nmck_m:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭新增中 name="input.head.m_insert"
               
               #end add-point
               
               
               
               
               #add-point:單頭新增後 name="input.head.a_insert"
                  CALL s_transaction_end('Y','0')
                  
                  IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                     CALL anmt440_detail_reproduce()
                  END IF
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL anmt440_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL anmt440_b_fill()
                  CALL anmt440_b_fill2('0')
               END IF
               
               #add-point:單頭新增後 name="input.head.a_insert2"
               
               #end add-point
               
               LET g_master_insert = TRUE
               
               LET p_cmd = 'u'
            ELSE
               CALL s_transaction_begin()
            
               #add-point:單頭修改前 name="input.head.b_update"
#               IF g_nmck_m.nmck002 = '2' AND cl_null(g_nmck_m.nmck017) AND cl_null(g_nmck_m.nmck018) THEN
#               IF g_nmck_m.nmck002 = '2' AND cl_null(g_nmck_m.nmck017)  THEN 
#                  CALL cl_err('','anm-00135',1)
#                  NEXT FIELD nmck017
#               END IF
               #151012-00014#6 add ------
               #匯率有變動，需重算單身金額
               IF g_nmck_m.nmck101 != g_nmck_m_t.nmck101 THEN
                  IF cl_ask_confirm('aap-00251') THEN
                     CALL anmt440_upd_nmcl() RETURNING g_sub_success
                     IF NOT g_sub_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = "nmcl_t"
                        LET g_errparam.code   = SQLCA.sqlcode
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()
                        CALL s_transaction_end('N','0')
                        CONTINUE DIALOG
                     END IF
                  END IF
               END IF
               #151012-00014#6 add end---
               #end add-point
               
               #將遮罩欄位還原
               CALL anmt440_nmck_t_mask_restore('restore_mask_o')
               
               UPDATE nmck_t SET (nmcksite,nmckcomp,nmck003,nmckdocno,nmck002,nmckdocdt,nmck004,nmck019, 
                   nmckstus,nmckownid,nmckowndp,nmckcrtid,nmckcrtdp,nmckcrtdt,nmckmodid,nmckmoddt,nmckcnfid, 
                   nmckcnfdt,nmck001,nmck100,nmck103,nmck101,nmck113,nmck121,nmck123,nmck131,nmck133, 
                   nmck034,nmck035,nmck022,nmck036,nmck023,nmck011,nmck009,nmck010,nmck024,nmck027,nmck025, 
                   nmck026,nmck114,nmck124,nmck134,nmck005,nmck006,nmck015,nmck046,nmck030,nmck031,nmck028, 
                   nmck029,nmck032,nmck044,nmck045,nmck047,nmck048,nmck049,nmck050,nmck051) = (g_nmck_m.nmcksite, 
                   g_nmck_m.nmckcomp,g_nmck_m.nmck003,g_nmck_m.nmckdocno,g_nmck_m.nmck002,g_nmck_m.nmckdocdt, 
                   g_nmck_m.nmck004,g_nmck_m.nmck019,g_nmck_m.nmckstus,g_nmck_m.nmckownid,g_nmck_m.nmckowndp, 
                   g_nmck_m.nmckcrtid,g_nmck_m.nmckcrtdp,g_nmck_m.nmckcrtdt,g_nmck_m.nmckmodid,g_nmck_m.nmckmoddt, 
                   g_nmck_m.nmckcnfid,g_nmck_m.nmckcnfdt,g_nmck_m.nmck001,g_nmck_m.nmck100,g_nmck_m.nmck103, 
                   g_nmck_m.nmck101,g_nmck_m.nmck113,g_nmck_m.nmck121,g_nmck_m.nmck123,g_nmck_m.nmck131, 
                   g_nmck_m.nmck133,g_nmck_m.nmck034,g_nmck_m.nmck035,g_nmck_m.nmck022,g_nmck_m.nmck036, 
                   g_nmck_m.nmck023,g_nmck_m.nmck011,g_nmck_m.nmck009,g_nmck_m.nmck010,g_nmck_m.nmck024, 
                   g_nmck_m.nmck027,g_nmck_m.nmck025,g_nmck_m.nmck026,g_nmck_m.nmck114,g_nmck_m.nmck124, 
                   g_nmck_m.nmck134,g_nmck_m.nmck005,g_nmck_m.nmck006,g_nmck_m.nmck015,g_nmck_m.nmck046, 
                   g_nmck_m.nmck030,g_nmck_m.nmck031,g_nmck_m.nmck028,g_nmck_m.nmck029,g_nmck_m.nmck032, 
                   g_nmck_m.nmck044,g_nmck_m.nmck045,g_nmck_m.nmck047,g_nmck_m.nmck048,g_nmck_m.nmck049, 
                   g_nmck_m.nmck050,g_nmck_m.nmck051)
                WHERE nmckent = g_enterprise AND nmckcomp = g_nmckcomp_t
                  AND nmckdocno = g_nmckdocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "nmck_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL anmt440_nmck_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_nmck_m_t)
               LET g_log2 = util.JSON.stringify(g_nmck_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               CALL anmt440_b_fill()  #151012-00014#6
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_nmckcomp_t = g_nmck_m.nmckcomp
            LET g_nmckdocno_t = g_nmck_m.nmckdocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="anmt440.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_nmcl_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            IF g_nmck_m.nmck001 = 'AP' THEN
               EXIT DIALOG 
            END IF 
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_nmcl_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL anmt440_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_nmcl_d.getLength()
            #add-point:資料輸入前 name="input.d.before_input"
            #151029-00001#5--add--str--
            IF g_nmck_m.nmck001 = 'XX' THEN
               CALL cl_set_comp_entry("nmcl001,nmcl002",FALSE)
               CALL cl_set_comp_entry("nmcl003,nmcl103,nmcl113",TRUE)
               CALL cl_set_comp_required("nmcl003,nmcl103,nmcl113",TRUE)
            ELSE
               CALL cl_set_comp_entry("nmcl001,nmcl002",TRUE)
               CALL cl_set_comp_required("nmcl001,nmcl002",TRUE)
               CALL cl_set_comp_entry("nmcl003,nmcl103,nmcl113",FALSE)
            END IF 
            #151029-00001#5--add--end
            #end add-point
         
         BEFORE ROW
            #add-point:modify段before row2 name="input.body.before_row2"
            LET g_aw = 's_detail1'
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
            OPEN anmt440_cl USING g_enterprise,g_nmck_m.nmckcomp,g_nmck_m.nmckdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN anmt440_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE anmt440_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_nmcl_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_nmcl_d[l_ac].nmclseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_nmcl_d_t.* = g_nmcl_d[l_ac].*  #BACKUP
               LET g_nmcl_d_o.* = g_nmcl_d[l_ac].*  #BACKUP
               CALL anmt440_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL anmt440_set_no_entry_b(l_cmd)
               IF NOT anmt440_lock_b("nmcl_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH anmt440_bcl INTO g_nmcl_d[l_ac].nmclseq,g_nmcl_d[l_ac].nmclorga,g_nmcl_d[l_ac].nmcl001, 
                      g_nmcl_d[l_ac].nmcl002,g_nmcl_d[l_ac].nmcl003,g_nmcl_d[l_ac].nmcl103,g_nmcl_d[l_ac].nmcl113, 
                      g_nmcl_d[l_ac].nmcl121,g_nmcl_d[l_ac].nmcl123,g_nmcl_d[l_ac].nmcl131,g_nmcl_d[l_ac].nmcl133 
 
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_nmcl_d_t.nmclseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_nmcl_d_mask_o[l_ac].* =  g_nmcl_d[l_ac].*
                  CALL anmt440_nmcl_t_mask()
                  LET g_nmcl_d_mask_n[l_ac].* =  g_nmcl_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL anmt440_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            CALL anmt440_ref_b()
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
            INITIALIZE g_nmcl_d[l_ac].* TO NULL 
            INITIALIZE g_nmcl_d_t.* TO NULL 
            INITIALIZE g_nmcl_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
            
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            LET g_nmcl_d[l_ac].nmclorga = g_nmck_m.nmcksite                                                   #160912-00024#1 add
            CALL s_anm_orga_chk(g_nmcl_d[l_ac].nmclorga,g_nmck_m.nmckcomp) RETURNING g_nmcl_d[l_ac].nmclorga  #160912-00024#1 add
            #end add-point
            LET g_nmcl_d_t.* = g_nmcl_d[l_ac].*     #新輸入資料
            LET g_nmcl_d_o.* = g_nmcl_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL anmt440_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL anmt440_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_nmcl_d[li_reproduce_target].* = g_nmcl_d[li_reproduce].*
 
               LET g_nmcl_d[li_reproduce_target].nmclseq = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
            IF l_cmd = 'a' THEN 
               IF cl_null(g_nmcl_d[g_detail_idx].nmclseq) THEN 
                  SELECT MAX(nmclseq) INTO g_nmcl_d[g_detail_idx].nmclseq
                    FROM nmcl_t
                   WHERE nmclent = g_enterprise
                     AND nmclcomp = g_nmck_m.nmckcomp
                     AND nmcldocno = g_nmck_m.nmckdocno
                     
                  IF cl_null(g_nmcl_d[g_detail_idx].nmclseq) THEN 
                     LET g_nmcl_d[g_detail_idx].nmclseq = 1
                  ELSE
                     LET g_nmcl_d[g_detail_idx].nmclseq = g_nmcl_d[g_detail_idx].nmclseq + 1
                  END IF
               END IF
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
            SELECT COUNT(1) INTO l_count FROM nmcl_t 
             WHERE nmclent = g_enterprise AND nmclcomp = g_nmck_m.nmckcomp
               AND nmcldocno = g_nmck_m.nmckdocno
 
               AND nmclseq = g_nmcl_d[l_ac].nmclseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_nmck_m.nmckcomp
               LET gs_keys[2] = g_nmck_m.nmckdocno
               LET gs_keys[3] = g_nmcl_d[g_detail_idx].nmclseq
               CALL anmt440_insert_b('nmcl_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_nmcl_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "nmcl_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL anmt440_b_fill()
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
              #161019-00001#1 Mark ---(S)---
              #LET l_nmcl103=0
              ##150714-00024#1 add nmcl113
              #SELECT SUM(nmcl103),SUM(nmcl113) INTO l_nmcl103,l_nmcl113
              #  FROM nmcl_t
              # WHERE nmclent = g_enterprise
              #   AND nmcldocno = g_nmck_m.nmckdocno
              #   AND nmclcomp = g_nmck_m.nmckcomp
              #IF cl_null(l_nmcl103) THEN LET l_nmcl103 = 0 END IF #150714-00024#1
              #IF cl_null(l_nmcl113) THEN LET l_nmcl113 = 0 END IF #150714-00024#1
              #UPDATE nmck_t SET nmck103 = l_nmcl103,
              #                  nmck113 = l_nmcl113
              # WHERE nmckent = g_enterprise
              #   AND nmckdocno = g_nmck_m.nmckdocno
              #   AND nmckcomp = g_nmck_m.nmckcomp
              #LET g_nmck_m.nmck103=l_nmcl103
              #LET g_nmck_m.nmck113=l_nmcl103 * g_nmck_m.nmck101 #150714-00024#1 mark
              #LET g_nmck_m.nmck113=l_nmcl113 #150714-00024#1
              #DISPLAY BY NAME g_nmck_m.nmck103,g_nmck_m.nmck113
              #161019-00001#1 Mark ---(E)---
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
               LET gs_keys[01] = g_nmck_m.nmckcomp
               LET gs_keys[gs_keys.getLength()+1] = g_nmck_m.nmckdocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_nmcl_d_t.nmclseq
 
            
               #刪除同層單身
               IF NOT anmt440_delete_b('nmcl_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE anmt440_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT anmt440_key_delete_b(gs_keys,'nmcl_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE anmt440_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               IF g_nmck_m.nmck001 = 'AP' THEN     
                 UPDATE apde_t SET apde009 = 'N',
                                   apde003 = '',
                                   apde014 = ''
                               WHERE apdeent = g_enterprise 
                                 AND apdedocno = g_nmcl_d[l_ac].nmcl001 
                                 AND apdeseq = g_nmcl_d[l_ac].nmcl002
               END IF 
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE anmt440_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
              #161019-00001#1 Mark ---(S)---
              #LET l_nmcl103=0
              ##150714-00024#1 add nmcl113
              #SELECT SUM(nmcl103),SUM(nmcl113) INTO l_nmcl103,l_nmcl113
              #  FROM nmcl_t
              # WHERE nmclent = g_enterprise
              #   AND nmcldocno = g_nmck_m.nmckdocno
              #   AND nmclcomp = g_nmck_m.nmckcomp
              #IF cl_null(l_nmcl103) THEN LET l_nmcl103 = 0 END IF #150714-00024#1
              #IF cl_null(l_nmcl113) THEN LET l_nmcl113 = 0 END IF #150714-00024#1
              #UPDATE nmck_t SET nmck103 = l_nmcl103,
              #                  nmck113 = l_nmcl113
              # WHERE nmckent = g_enterprise
              #   AND nmckdocno = g_nmck_m.nmckdocno
              #   AND nmckcomp = g_nmck_m.nmckcomp
              #LET g_nmck_m.nmck103=l_nmcl103
              #LET g_nmck_m.nmck113=l_nmcl103 * g_nmck_m.nmck101 #150714-00024#1 mark
              #LET g_nmck_m.nmck113=l_nmcl113 #150714-00024#1
              #DISPLAY BY NAME g_nmck_m.nmck103,g_nmck_m.nmck113
              #161019-00001#1 Mark ---(E)---
               #end add-point
               LET l_count = g_nmcl_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_nmcl_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmclseq
            #add-point:BEFORE FIELD nmclseq name="input.b.page1.nmclseq"
            IF cl_null(g_nmcl_d[g_detail_idx].nmclseq) THEN 
               SELECT MAX(nmclseq) INTO g_nmcl_d[g_detail_idx].nmclseq
                 FROM nmcl_t
                WHERE nmclent = g_enterprise
                  AND nmclcomp = g_nmck_m.nmckcomp
                  AND nmcldocno = g_nmck_m.nmckdocno
                  
               IF cl_null(g_nmcl_d[g_detail_idx].nmclseq) THEN 
                  LET g_nmcl_d[g_detail_idx].nmclseq = 1
               ELSE
                  LET g_nmcl_d[g_detail_idx].nmclseq = g_nmcl_d[g_detail_idx].nmclseq + 1
               END IF
            END IF
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmclseq
            
            #add-point:AFTER FIELD nmclseq name="input.a.page1.nmclseq"
            #此段落由子樣板a05產生
            IF  g_nmck_m.nmckcomp IS NOT NULL AND g_nmck_m.nmckdocno IS NOT NULL AND g_nmcl_d[g_detail_idx].nmclseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_nmck_m.nmckcomp != g_nmckcomp_t OR g_nmck_m.nmckdocno != g_nmckdocno_t OR g_nmcl_d[g_detail_idx].nmclseq != g_nmcl_d_t.nmclseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM nmcl_t WHERE "||"nmclent = '" ||g_enterprise|| "' AND "||"nmclcomp = '"||g_nmck_m.nmckcomp ||"' AND "|| "nmcldocno = '"||g_nmck_m.nmckdocno ||"' AND "|| "nmclseq = '"||g_nmcl_d[g_detail_idx].nmclseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmclseq
            #add-point:ON CHANGE nmclseq name="input.g.page1.nmclseq"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmclorga
            
            #add-point:AFTER FIELD nmclorga name="input.a.page1.nmclorga"
            IF NOT cl_null(g_nmcl_d[l_ac].nmclorga) THEN
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_nmcl_d[l_ac].nmclorga
               #160318-00025#1--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#1--add--end
               IF cl_chk_exist("v_ooef001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME
               ELSE
                  LET g_nmcl_d[l_ac].nmclorga = g_nmcl_d_t.nmclorga
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmclorga
            #add-point:BEFORE FIELD nmclorga name="input.b.page1.nmclorga"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmclorga
            #add-point:ON CHANGE nmclorga name="input.g.page1.nmclorga"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmclorga_desc
            #add-point:BEFORE FIELD nmclorga_desc name="input.b.page1.nmclorga_desc"
            LET g_nmcl_d[l_ac].nmclorga_desc = g_nmcl_d[l_ac].nmclorga
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmclorga_desc
            
            #add-point:AFTER FIELD nmclorga_desc name="input.a.page1.nmclorga_desc"
            #150626-00011#1 mark ------
            #IF NOT cl_null(g_nmcl_d[l_ac].nmclorga_desc) THEN 
            #   INITIALIZE g_chkparam.* TO NULL
            #   LET g_chkparam.arg1 = g_nmcl_d[l_ac].nmclorga_desc
            #   IF cl_chk_exist("v_ooef001") THEN
            #      #檢查成功時後續處理
            #      #LET  = g_chkparam.return1
            #      #DISPLAY BY NAME 
            #      LET g_nmcl_d[l_ac].nmclorga = g_nmcl_d[l_ac].nmclorga_desc
            #      #获取当前组织编号主帐套
            #      SELECT glaald INTO l_glaald 
            #        FROM glaa_t 
            #       WHERE glaaent=g_enterprise AND glaa014='Y'
            #         AND glaacomp IN (SELECT ooef017 FROM ooef_t 
            #                           WHERE ooef001=g_nmcl_d[l_ac].nmclorga AND ooefent=g_enterprise)
            #      LET l_n=0 
            #      SELECT COUNT(*) INTO l_n
            #        FROM ooef_t
            #       WHERE ooefent=g_enterprise
            #         AND ooef001=g_nmcl_d[l_ac].nmclorga_desc
            #         AND ooef017=g_nmck_m.nmckcomp
            #      IF cl_null(l_n) OR l_n=0 THEN
            #         INITIALIZE g_errparam TO NULL
            #         LET g_errparam.code = 'ais-00023'
            #         LET g_errparam.extend = g_nmcl_d[l_ac].nmclorga_desc
            #         LET g_errparam.popup = TRUE
            #         CALL cl_err()
            #         LET g_nmcl_d[l_ac].nmclorga_desc = g_nmcl_d_t.nmclorga_desc
            #         NEXT FIELD CURRENT
            #      END IF
            #   ELSE
            #      #檢查失敗時後續處理
            #      LET g_nmcl_d[l_ac].nmclorga = g_nmcl_d_t.nmclorga
            #      LET g_nmcl_d[l_ac].nmclorga_desc = g_nmcl_d_t.nmclorga_desc
            #      CALL anmt440_ref_b()
            #      NEXT FIELD CURRENT
            #   END IF
            #END IF
            #150626-00011#1 mark end---
            
            #150626-00011#1 add ------
            IF NOT cl_null(g_nmcl_d[l_ac].nmclorga_desc) THEN
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND ((cl_null(g_nmcl_d[l_ac].nmclorga_desc) OR g_nmcl_d[l_ac].nmclorga_desc != g_nmcl_d_t.nmclorga_desc) OR cl_null(g_nmcl_d_t.nmclorga_desc))) THEN   #160822-00012#5  mark
               IF g_nmcl_d[l_ac].nmclorga_desc != g_nmcl_d_o.nmclorga_desc OR cl_null(g_nmcl_d_o.nmclorga_desc) THEN                                                                                   #160822-00012#5  add
                  CALL s_anm_ooef001_chk(g_nmcl_d[l_ac].nmclorga_desc) RETURNING g_sub_success,g_errno     
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
                     #LET g_nmcl_d[l_ac].nmclorga_desc = g_nmcl_d_t.nmclorga   #160822-00012#5  mark
                     LET g_nmcl_d[l_ac].nmclorga_desc = g_nmcl_d_o.nmclorga    #160822-00012#5  add
                     CALL anmt440_ref_b()
                     NEXT FIELD CURRENT
                  END IF
                  
                  #160912-00024#1 add s---
                  CALL s_anm_get_site_wc('6',g_nmck_m.nmcksite,g_nmck_m.nmckdocdt) RETURNING g_site_wc
                  IF cl_null(g_site_wc) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'anm-03020' #该资金中心下无可用运营据点!
                     LET g_errparam.extend = g_nmck_m.nmcksite
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #LET g_nmcl_d[l_ac].nmclorga = g_nmcl_d_t.nmclorga   #160822-00012#5  mark
                     LET g_nmcl_d[l_ac].nmclorga = g_nmcl_d_o.nmclorga    #160822-00012#5  add
                     NEXT FIELD CURRENT
                  END IF                  
                  #160912-00024#1 add e---
                  
                  #檢查輸入組織代碼是否存在法人組織下的組織範圍內(1.與單頭法人組織法人相同2.屬於資金組織3.user具有拜訪權限)
                  IF s_chr_get_index_of(g_site_wc,g_nmcl_d[l_ac].nmclorga_desc,1) = 0 THEN
                     LET g_errno ='axc-00099'
                  #160912-00024#1 add s--- 
                  ELSE                   
                     IF NOT ap_chk_isExist(g_nmcl_d[l_ac].nmclorga_desc,"SELECT COUNT(*) FROM ooef_t WHERE "||"ooefent = '" ||g_enterprise|| "' AND "||"ooef001 = ?  AND ooefstus ='Y' AND ooef017 = '"||g_nmck_m.nmckcomp||"'",'anm-03022',1) THEN 
                        LET g_nmcl_d[l_ac].nmclorga_desc = g_nmcl_d_t.nmclorga_desc
                        NEXT FIELD CURRENT
                     END IF 
                  #160912-00024#1 add e---                       
                  END IF
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ""
                     LET g_errparam.code   = g_errno
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     #LET g_nmcl_d[l_ac].nmclorga_desc = g_nmcl_d_t.nmclorga   #160822-00012#5  mark
                     LET g_nmcl_d[l_ac].nmclorga_desc = g_nmcl_d_o.nmclorga    #160822-00012#5  add
                     CALL anmt440_ref_b()
                     NEXT FIELD CURRENT
                  END IF
                  
                  #150714-00024#1 add ------
                  #同一張開票單號，單身限制只能為同一個來源組織
                  IF l_ac > 1 THEN
                     IF g_nmcl_d[l_ac-1].nmclorga <>  g_nmcl_d[l_ac].nmclorga_desc THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = ""
                        LET g_errparam.code   = 'anm-02940'
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()
                        #LET g_nmcl_d[l_ac].nmclorga_desc = g_nmcl_d_t.nmclorga   #160822-00012#5  mark
                        LET g_nmcl_d[l_ac].nmclorga_desc = g_nmcl_d_o.nmclorga    #160822-00012#5  add
                        CALL anmt440_ref_b()
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  #150714-00024#1 add end---
                  LET g_nmcl_d[l_ac].nmclorga = g_nmcl_d[l_ac].nmclorga_desc
               END IF
            END IF
            #150626-00011#1 add end---
            CALL anmt440_ref_b()
            LET g_nmcl_d_o.* = g_nmcl_d[l_ac].*    #160822-00012#5  add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmclorga_desc
            #add-point:ON CHANGE nmclorga_desc name="input.g.page1.nmclorga_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmcl001
            
            #add-point:AFTER FIELD nmcl001 name="input.a.page1.nmcl001"
            IF g_nmck_m.nmck001 = 'AP' THEN 
                IF NOT cl_null(g_nmcl_d[l_ac].nmcl001) THEN 
#此段落由子樣板a19產生
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_nmcl_d[l_ac].nmcl001
                  LET g_chkparam.arg2 = l_glaald
                  #160318-00025#1--add--str
                  LET g_errshow = TRUE 
                  LET g_chkparam.err_str[1] = "anm-00130:sub-01302|aapt400|",cl_get_progname("aapt400",g_lang,"2"),"|:EXEPROGaapt400"
                  #160318-00025#1--add--end
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_apdadocno") THEN
                     #檢查成功時後續處理
                     #LET  = g_chkparam.return1
                     #DISPLAY BY NAME 
                     #請款單+項次是否已存在請款資料
                     LET l_n = 0
                     SELECT COUNT(*) INTO l_n
                       FROM nmck_t,nmcl_t
                      WHERE nmclent = g_enterprise
                        AND nmckent = nmclent
                        AND nmckcomp = nmclcomp
                        AND nmckdocno = nmcldocno
                        AND nmcl001 = g_nmcl_d[l_ac].nmcl001
                        AND nmcl002 = g_nmcl_d[l_ac].nmcl002
                        AND nmckstus <> 'X'
                        AND nmckdocno <> g_nmck_m.nmckdocno 
                        AND nmck002 IN (SELECT ooia001 FROM ooia_t WHERE ooia002 = '30' AND ooiaent = g_enterprise )
                     IF l_n > 0 THEN 
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'anm-00137'
                        LET g_errparam.extend = g_nmcl_d[l_ac].nmcl001
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        #LET g_nmcl_d[l_ac].nmcl001 = g_nmcl_d_t.nmcl001   #160822-00012#5   mark
                        LET g_nmcl_d[l_ac].nmcl001 = g_nmcl_d_o.nmcl001    #160822-00012#5   add
                        NEXT FIELD CURRENT
                     END IF
                        
                     
                     LET l_n = 0
                     SELECT COUNT(*) INTO l_n
                       FROM apda_t
                       LEFT OUTER JOIN apde_t ON apdaent = apdeent AND apdald = apdeld AND apdadocno = apdedocno
                      WHERE apdaent = g_enterprise
                        AND apdadocno = g_nmcl_d[l_ac].nmcl001
                        AND apda001 = '45' 
                        AND apda005 = g_nmck_m.nmck005
                        AND apde006 = '30' 
                        AND apde100 = g_nmck_m.nmck100
#                        AND apdeorga = g_nmcl_d[l_ac].nmclorga      anmt440来源组织与aapt400的来源组织定义不一样，暂时mark
                        AND apde002 IN (select gzcb002 FROM gzcb_t where gzcb001 = '8506' AND gzcb004 = '2' )
                     
                     IF l_n = 0 THEN 
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'anm-00234'
                        LET g_errparam.extend = g_nmcl_d[l_ac].nmcl001
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        #LET g_nmcl_d[l_ac].nmcl001 = g_nmcl_d_t.nmcl001   #160822-00012#5   mark
                        LET g_nmcl_d[l_ac].nmcl001 = g_nmcl_d_o.nmcl001    #160822-00012#5   add
                        NEXT FIELD CURRENT
                     END IF
                        
                     IF NOT cl_null(g_nmcl_d[l_ac].nmcl001) AND NOT cl_null(g_nmcl_d[l_ac].nmcl002) THEN 
                        LET l_n = 0
                        SELECT COUNT(*) INTO l_n
                          FROM apda_t
                          LEFT OUTER JOIN apde_t ON apdaent = apdeent AND apdald = apdeld AND apdadocno = apdedocno
                         WHERE apdaent = g_enterprise
                           AND apdadocno = g_nmcl_d[l_ac].nmcl001
                           AND apda001 = '45' 
                           AND apda005 = g_nmck_m.nmck005
                           AND apde006 = '30' 
                           AND apde100 = g_nmck_m.nmck100
#                           AND apdeorga = g_nmcl_d[l_ac].nmclorga   anmt440来源组织与aapt400的来源组织定义不一样，暂时mark
                           AND apdeseq = g_nmcl_d[l_ac].nmcl002
                           AND apde002 IN (select gzcb002 FROM gzcb_t where gzcb001 = '8506' AND gzcb004 = '2' )
                        IF l_n = 0 THEN 
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = 'anm-00235'
                           LET g_errparam.extend = g_nmcl_d[l_ac].nmcl001
                           LET g_errparam.popup = TRUE
                           CALL cl_err()

                           #LET g_nmcl_d[l_ac].nmcl001 = g_nmcl_d_t.nmcl001   #160822-00012#5   mark
                           LET g_nmcl_d[l_ac].nmcl001 = g_nmcl_d_o.nmcl001    #160822-00012#5   add
                           #LET g_nmcl_d[l_ac].nmcl002 = g_nmcl_d_t.nmcl002   #160822-00012#5   mark
                           LET g_nmcl_d[l_ac].nmcl002 = g_nmcl_d_o.nmcl002    #160822-00012#5   add
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                     
                     CALL anmt440_amt_get()
                  ELSE
                     #檢查失敗時後續處理
                     #LET g_nmcl_d[l_ac].nmcl001 = g_nmcl_d_t.nmcl001   #160822-00012#5   mark
                     LET g_nmcl_d[l_ac].nmcl001 = g_nmcl_d_o.nmcl001    #160822-00012#5   add
                     NEXT FIELD CURRENT
                  END IF
               
               
               END IF 
            END IF
            
            #151029-00001#5--add--str--lujh
            IF g_nmck_m.nmck001 = 'IV' THEN 
               IF NOT cl_null(g_nmcl_d[l_ac].nmcl001) THEN 
                  #IF l_cmd='a' OR (l_cmd='u' AND (g_nmcl_d[l_ac].nmcl001 <> g_nmcl_d_t.nmcl001 OR cl_null(g_nmcl_d_t.nmcl001))) THEN   #160822-00012#5  mark
                  IF g_nmcl_d[l_ac].nmcl001 != g_nmcl_d_o.nmcl001 OR cl_null(g_nmcl_d_o.nmcl001) THEN                                   #160822-00012#5  add
                     INITIALIZE g_chkparam.* TO NULL
                     LET g_chkparam.arg1 = g_nmcl_d[l_ac].nmcl001
                     #160318-00025#1--add--str
                     LET g_errshow = TRUE 
                     LET g_chkparam.err_str[1] = "anm-00130:sub-01302|aapt400|",cl_get_progname("aapt400",g_lang,"2"),"|:EXEPROGaapt400"
                     #160318-00025#1--add--end
                     IF cl_chk_exist("v_apeadocno") THEN
                        #檢查成功時後續處理
                        #LET  = g_chkparam.return1
                        #DISPLAY BY NAME 
                        LET l_n = 0
                        SELECT COUNT(*) INTO l_n
                          FROM nmck_t,nmcl_t
                         WHERE nmclent = g_enterprise
                           AND nmckent = nmclent
                           AND nmckcomp = nmclcomp
                           AND nmckdocno = nmcldocno
                           AND nmcl001 = g_nmcl_d[l_ac].nmcl001
                           AND nmcl002 = g_nmcl_d[l_ac].nmcl002
                           AND nmckstus <> 'X'
                        IF l_n > 0 THEN 
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = 'anm-00137'
                           LET g_errparam.extend = g_nmcl_d[l_ac].nmcl001,"+",g_nmcl_d[l_ac].nmcl002
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           #LET g_nmcl_d[l_ac].nmcl001 = g_nmcl_d_t.nmcl001   #160822-00012#5  mark
                           LET g_nmcl_d[l_ac].nmcl001 = g_nmcl_d_o.nmcl001    #160822-00012#5  add
                           NEXT FIELD CURRENT
                        END IF
                        
                        LET l_n = 0
                        SELECT COUNT(*) INTO l_n
                          FROM apea_t
                          LEFT OUTER JOIN apeb_t ON apeaent = apebent AND apeadocno = apebdocno
                         WHERE apeaent = g_enterprise
                           AND apeadocno = g_nmcl_d[l_ac].nmcl001
                           AND apea005 = g_nmck_m.nmck005
                           AND apeb100 = g_nmck_m.nmck100
                           AND apeborga = g_nmcl_d[l_ac].nmclorga
                        IF l_n = 0 THEN 
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = 'anm-00131'
                           LET g_errparam.extend = g_nmcl_d[l_ac].nmcl001
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           #LET g_nmcl_d[l_ac].nmcl001 = g_nmcl_d_t.nmcl001   #160822-00012#5  mark
                           LET g_nmcl_d[l_ac].nmcl001 = g_nmcl_d_o.nmcl001    #160822-00012#5  add
                           NEXT FIELD CURRENT
                        END IF
                        
                        IF NOT cl_null(g_nmcl_d[l_ac].nmcl001) AND NOT cl_null(g_nmcl_d[l_ac].nmcl002) THEN 
                           LET l_n = 0
                           SELECT COUNT(*) INTO l_n
                             FROM apea_t
                             LEFT OUTER JOIN apeb_t ON apeaent = apebent AND apeadocno = apebdocno
                            WHERE apeaent = g_enterprise
                              AND apeadocno = g_nmcl_d[l_ac].nmcl001
                              AND apea005 = g_nmck_m.nmck005
                              AND apeb100 = g_nmck_m.nmck100
                              AND apeborga = g_nmcl_d[l_ac].nmclorga
                              AND apebseq = g_nmcl_d[l_ac].nmcl002
                           IF l_n = 0 THEN 
                              INITIALIZE g_errparam TO NULL
                              LET g_errparam.code = 'anm-00132'
                              LET g_errparam.extend = g_nmcl_d[l_ac].nmcl001
                              LET g_errparam.popup = TRUE
                              CALL cl_err()
                              #LET g_nmcl_d[l_ac].nmcl001 = g_nmcl_d_t.nmcl001   #160822-00012#5  mark
                              LET g_nmcl_d[l_ac].nmcl001 = g_nmcl_d_o.nmcl001    #160822-00012#5  add
                              #LET g_nmcl_d[l_ac].nmcl002 = g_nmcl_d_t.nmcl002   #160822-00012#5  mark
                              LET g_nmcl_d[l_ac].nmcl002 = g_nmcl_d_o.nmcl002    #160822-00012#5  add
                              NEXT FIELD CURRENT
                           END IF
                           
                           SELECT apeb006 INTO l_apeb006
                             FROM apeb_t
                            WHERE apebent = g_enterprise
                              AND apebdocno = g_nmcl_d[l_ac].nmcl001
                              AND apebseq = g_nmcl_d[l_ac].nmcl002 
                              
                           IF l_apeb006 <> '30' THEN 
                              INITIALIZE g_errparam TO NULL
                              LET g_errparam.code = 'aap-00419'
                              LET g_errparam.extend = g_nmcl_d[l_ac].nmcl001
                              LET g_errparam.popup = TRUE
                              CALL cl_err()
                              #LET g_nmcl_d[l_ac].nmcl001 = g_nmcl_d_t.nmcl001   #160822-00012#5  mark
                              LET g_nmcl_d[l_ac].nmcl001 = g_nmcl_d_o.nmcl001    #160822-00012#5  add
                              #LET g_nmcl_d[l_ac].nmcl002 = g_nmcl_d_t.nmcl002   #160822-00012#5  mark
                              LET g_nmcl_d[l_ac].nmcl002 = g_nmcl_d_o.nmcl002    #160822-00012#5  add
                              NEXT FIELD CURRENT
                           END IF
                        END IF
                        CALL anmt440_amt_get()
                     ELSE
                        #檢查失敗時後續處理
                        #LET g_nmcl_d[l_ac].nmcl001 = g_nmcl_d_t.nmcl001   #160822-00012#5  mark
                        LET g_nmcl_d[l_ac].nmcl001 = g_nmcl_d_o.nmcl001    #160822-00012#5  add
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF
            #151029-00001#5--add--end--lujh
            LET g_nmcl_d_o.* = g_nmcl_d[l_ac].*    #160822-00012#5  add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmcl001
            #add-point:BEFORE FIELD nmcl001 name="input.b.page1.nmcl001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmcl001
            #add-point:ON CHANGE nmcl001 name="input.g.page1.nmcl001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmcl002
            
            #add-point:AFTER FIELD nmcl002 name="input.a.page1.nmcl002"
            IF g_nmck_m.nmck001 = 'AP' THEN 
                IF NOT cl_null(g_nmcl_d[l_ac].nmcl002) THEN 
#此段落由子樣板a19產生
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_nmcl_d[l_ac].nmcl001
                  LET g_chkparam.arg2 = g_nmcl_d[l_ac].nmcl002
                     
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_apdeseq") THEN
                     #檢查成功時後續處理
                     #LET  = g_chkparam.return1
                     #DISPLAY BY NAME 
                     LET l_n = 0
                     SELECT COUNT(*) INTO l_n
                       FROM nmck_t,nmcl_t
                      WHERE nmclent = g_enterprise
                        AND nmckent = nmclent
                        AND nmckcomp = nmclcomp
                        AND nmckdocno = nmcldocno
                        AND nmcl001 = g_nmcl_d[l_ac].nmcl001
                        AND nmcl002 = g_nmcl_d[l_ac].nmcl002
                        AND nmckstus <> 'X'
                        AND nmckdocno <> g_nmck_m.nmckdocno
                        AND nmck002 IN (SELECT ooia001 FROM ooia_t WHERE ooia002 = '30' AND ooiaent = g_enterprise)
                        
                     IF l_n > 0 THEN 
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'anm-00137'
                        LET g_errparam.extend = g_nmcl_d[l_ac].nmcl001
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        #LET g_nmcl_d[l_ac].nmcl002 = g_nmcl_d_t.nmcl002   #160822-00012#5   mark
                        LET g_nmcl_d[l_ac].nmcl002 = g_nmcl_d_o.nmcl002    #160822-00012#5   add
                        NEXT FIELD CURRENT
                     END IF
                     
                     IF NOT cl_null(g_nmcl_d[l_ac].nmcl001) AND NOT cl_null(g_nmcl_d[l_ac].nmcl002) THEN 
                        LET l_n = 0
                        SELECT COUNT(*) INTO l_n
                          FROM apda_t
                          LEFT OUTER JOIN apde_t ON apdaent = apdeent AND apdald = apdeld AND apdadocno = apdedocno
                         WHERE apdaent = g_enterprise
                           AND apdadocno = g_nmcl_d[l_ac].nmcl001
                           AND apda001 = '45' 
                           AND apda005 = g_nmck_m.nmck005
                           AND apde006 = '30' 
                           AND apde100 = g_nmck_m.nmck100
                           AND apdeorga = g_nmcl_d[l_ac].nmclorga
                           AND apdeseq = g_nmcl_d[l_ac].nmcl002
                        IF l_n = 0 THEN 
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = 'anm-00235'
                           LET g_errparam.extend = g_nmcl_d[l_ac].nmcl001
                           LET g_errparam.popup = TRUE
                           CALL cl_err()

                           #LET g_nmcl_d[l_ac].nmcl002 = g_nmcl_d_t.nmcl002   #160822-00012#5   mark
                           LET g_nmcl_d[l_ac].nmcl002 = g_nmcl_d_o.nmcl002    #160822-00012#5   add
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                     
                     CALL anmt440_amt_get()
                  ELSE
                     #檢查失敗時後續處理
                     #LET g_nmcl_d[l_ac].nmcl002 = g_nmcl_d_t.nmcl002   #160822-00012#5   mark
                     LET g_nmcl_d[l_ac].nmcl002 = g_nmcl_d_o.nmcl002    #160822-00012#5   add
                     NEXT FIELD CURRENT
                  END IF
               
               
               END IF 
            END IF
            
            
            #151029-00001#5--add--str--lujh
            IF g_nmck_m.nmck001 = 'IV' THEN 
               IF NOT cl_null(g_nmcl_d[l_ac].nmcl002) THEN 
                  #IF l_cmd='a' OR (l_cmd='u' AND (g_nmcl_d[l_ac].nmcl002 <> g_nmcl_d_t.nmcl002 OR cl_null(g_nmcl_d_t.nmcl002))) THEN   #160822-00012#5  mark
                  IF g_nmcl_d[l_ac].nmcl002 != g_nmcl_d_o.nmcl002 OR cl_null(g_nmcl_d_o.nmcl002) THEN                                  #160822-00012#5  add
                     INITIALIZE g_chkparam.* TO NULL
                     LET g_chkparam.arg1 = g_nmcl_d[l_ac].nmcl001
                     LET g_chkparam.arg2 = g_nmcl_d[l_ac].nmcl002
                     IF cl_chk_exist("v_apebseq") THEN
                        #檢查成功時後續處理
                        #LET  = g_chkparam.return1
                        #DISPLAY BY NAME 
                        LET l_n = 0
                        SELECT COUNT(*) INTO l_n
                          FROM nmck_t,nmcl_t
                         WHERE nmclent = g_enterprise
                           AND nmckent = nmclent
                           AND nmckcomp = nmclcomp
                           AND nmckdocno = nmcldocno
                           AND nmcl001 = g_nmcl_d[l_ac].nmcl001
                           AND nmcl002 = g_nmcl_d[l_ac].nmcl002
                           AND nmckstus <> 'X'
                        IF cl_null(l_n) THEN LET l_n = 0 END IF
                        IF l_n > 0 THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = 'anm-00137'
                           LET g_errparam.extend = g_nmcl_d[l_ac].nmcl001,"+",g_nmcl_d[l_ac].nmcl002
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           #LET g_nmcl_d[l_ac].nmcl002 = g_nmcl_d_t.nmcl002   #160822-00012#5  mark
                           LET g_nmcl_d[l_ac].nmcl002 = g_nmcl_d_o.nmcl002    #160822-00012#5  add
                           NEXT FIELD CURRENT
                        END IF
                        
                        IF NOT cl_null(g_nmcl_d[l_ac].nmcl001) AND NOT cl_null(g_nmcl_d[l_ac].nmcl002) THEN 
                           LET l_n = 0
                           SELECT COUNT(*) INTO l_n
                             FROM apea_t
                             LEFT OUTER JOIN apeb_t ON apeaent = apebent AND apeadocno = apebdocno
                            WHERE apeaent = g_enterprise
                              AND apeadocno = g_nmcl_d[l_ac].nmcl001
                              AND apea005 = g_nmck_m.nmck005
                              AND apeb100 = g_nmck_m.nmck100
                              AND apeborga = g_nmcl_d[l_ac].nmclorga
                              AND apebseq = g_nmcl_d[l_ac].nmcl002
                           IF l_n = 0 THEN 
                              INITIALIZE g_errparam TO NULL
                              LET g_errparam.code = 'anm-00132'
                              LET g_errparam.extend = g_nmcl_d[l_ac].nmcl001
                              LET g_errparam.popup = TRUE
                              CALL cl_err()
                              #LET g_nmcl_d[l_ac].nmcl002 = g_nmcl_d_t.nmcl002   #160822-00012#5  mark
                              LET g_nmcl_d[l_ac].nmcl002 = g_nmcl_d_o.nmcl002    #160822-00012#5  add
                              NEXT FIELD CURRENT
                           END IF
                        END IF
                        CALL anmt440_amt_get()
                     ELSE
                        #檢查失敗時後續處理
                        #LET g_nmcl_d[l_ac].nmcl002 = g_nmcl_d_t.nmcl002   #160822-00012#5  mark
                        LET g_nmcl_d[l_ac].nmcl002 = g_nmcl_d_o.nmcl002    #160822-00012#5  add
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF
            #151029-00001#5--add--end--lujh
            LET g_nmcl_d_o.* = g_nmcl_d[l_ac].*    #160822-00012#5  add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmcl002
            #add-point:BEFORE FIELD nmcl002 name="input.b.page1.nmcl002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmcl002
            #add-point:ON CHANGE nmcl002 name="input.g.page1.nmcl002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmcl003
            
            #add-point:AFTER FIELD nmcl003 name="input.a.page1.nmcl003"
            IF NOT cl_null(g_nmcl_d[l_ac].nmcl003) THEN    
              
               LET l_glaa004 = ''   #160822-00012#5   add
               LET l_glaald = ''    #160822-00012#5   add
               # 开窗模糊查询 150916-00015#1 --add      
               SELECT glaa004,glaald INTO l_glaa004,l_glaald
                   FROM glaa_t 
                  WHERE glaaent = g_enterprise 
                    AND glaacomp = g_nmck_m.nmckcomp
                    AND glaa014='Y'               
               IF s_aglt310_getlike_lc_subject(l_glaald,g_nmcl_d[l_ac].nmcl003,"")  THEN            
                                                    
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
                  LET g_qryparam.reqry = 'FALSE'
                  LET g_qryparam.default1 = g_nmcl_d[l_ac].nmcl003
                                
                  LET g_qryparam.arg1 = l_glaa004
                  LET g_qryparam.arg2 = g_nmcl_d[l_ac].nmcl003
                  LET g_qryparam.arg3 = l_glaald
                  LET g_qryparam.arg4 = " 1"
                  CALL q_glac002_6()
                  LET  g_nmcl_d[l_ac].nmcl003 = g_qryparam.return1
                  DISPLAY g_nmcl_d[l_ac].nmcl003 TO nmcl003                  
               END IF
               #科目存在性，有效性，非统治科目，非子系统科目，账户科目属性检查
               IF NOT  s_aglt310_lc_subject(l_glaald,g_nmcl_d[l_ac].nmcl003,'N') THEN
                  #LET g_nmcl_d[l_ac].nmcl003 = g_nmcl_d_t.nmcl003   #160822-00012#5   mark
                  LET g_nmcl_d[l_ac].nmcl003 = g_nmcl_d_o.nmcl003    #160822-00012#5   add
                  NEXT FIELD CURRENT
               END IF
               # 150916-00015#1 --end
               
#               SELECT glaa004 INTO l_glaa004 
#                 FROM glaa_t 
#                WHERE glaaent = g_enterprise 
#                  AND glaacomp = g_nmck_m.nmckcomp
#                  AND glaa014='Y'
#               INITIALIZE g_chkparam.* TO NULL
#               LET g_chkparam.arg1 = l_glaa004
#               LET g_chkparam.arg2 = g_nmcl_d[l_ac].nmcl003
#               IF NOT cl_chk_exist("v_glac002_4") THEN
#                  LET g_nmcl_d[l_ac].nmcl003 = g_nmcl_d_t.nmcl003
#                  NEXT FIELD CURRENT
#               END IF
           END IF
           LET l_glaa004 = ''   #160822-00012#5   add
           SELECT glaa004 INTO l_glaa004 
             FROM glaa_t 
            WHERE glaaent = g_enterprise 
              AND glaacomp = g_nmck_m.nmckcomp
              AND glaa014='Y'
           INITIALIZE g_ref_fields TO NULL
           LET g_ref_fields[1] = l_glaa004
           LET g_ref_fields[2] = g_nmcl_d[l_ac].nmcl003
           CALL ap_ref_array2(g_ref_fields,"SELECT glacl004 FROM glacl_t WHERE glaclent='"||g_enterprise||"' AND glacl001=? AND glacl002=? ","")
                         RETURNING g_rtn_fields
           LET g_nmcl_d[l_ac].nmcl003_desc = '', g_rtn_fields[1] , ''
           DISPLAY BY NAME g_nmcl_d[l_ac].nmcl003_desc
           LET g_nmcl_d_o.* = g_nmcl_d[l_ac].*   #160822-00012#5   add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmcl003
            #add-point:BEFORE FIELD nmcl003 name="input.b.page1.nmcl003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmcl003
            #add-point:ON CHANGE nmcl003 name="input.g.page1.nmcl003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmcl003_desc
            #add-point:BEFORE FIELD nmcl003_desc name="input.b.page1.nmcl003_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmcl003_desc
            
            #add-point:AFTER FIELD nmcl003_desc name="input.a.page1.nmcl003_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmcl003_desc
            #add-point:ON CHANGE nmcl003_desc name="input.g.page1.nmcl003_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmcl103
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_nmcl_d[l_ac].nmcl103,"0","0","","","azz-00079",1) THEN
               NEXT FIELD nmcl103
            END IF 
 
 
 
            #add-point:AFTER FIELD nmcl103 name="input.a.page1.nmcl103"
            IF NOT cl_null(g_nmcl_d[l_ac].nmcl103) THEN
               CALL s_curr_round_ld('1',g_glaald,g_nmck_m.nmck100,g_nmcl_d[l_ac].nmcl103,2) #150714-00024#1
                    RETURNING g_sub_success,g_errno,g_nmcl_d[l_ac].nmcl103                  #150714-00024#1
               CALL anmt440_get_default()
            END IF
            LET g_nmcl_d_o.* = g_nmcl_d[l_ac].*   #160822-00012#5   add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmcl103
            #add-point:BEFORE FIELD nmcl103 name="input.b.page1.nmcl103"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmcl103
            #add-point:ON CHANGE nmcl103 name="input.g.page1.nmcl103"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmcl113
            #add-point:BEFORE FIELD nmcl113 name="input.b.page1.nmcl113"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmcl113
            
            #add-point:AFTER FIELD nmcl113 name="input.a.page1.nmcl113"
            #150714-00024#1 add ------
            IF NOT cl_null(g_nmcl_d[l_ac].nmcl113) THEN 
               CALL s_curr_round_ld('1',g_glaald,g_glaa001,g_nmcl_d[l_ac].nmcl113,2)
                    RETURNING g_sub_success,g_errno,g_nmcl_d[l_ac].nmcl113
            END IF
            #150714-00024#1 add end---
            LET g_nmcl_d_o.* = g_nmcl_d[l_ac].*   #160822-00012#5   add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmcl113
            #add-point:ON CHANGE nmcl113 name="input.g.page1.nmcl113"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmcl121
            #add-point:BEFORE FIELD nmcl121 name="input.b.page1.nmcl121"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmcl121
            
            #add-point:AFTER FIELD nmcl121 name="input.a.page1.nmcl121"
            LET g_nmcl_d_o.* = g_nmcl_d[l_ac].*   #160822-00012#5   add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmcl121
            #add-point:ON CHANGE nmcl121 name="input.g.page1.nmcl121"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmcl123
            #add-point:BEFORE FIELD nmcl123 name="input.b.page1.nmcl123"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmcl123
            
            #add-point:AFTER FIELD nmcl123 name="input.a.page1.nmcl123"
            LET g_nmcl_d_o.* = g_nmcl_d[l_ac].*   #160822-00012#5   add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmcl123
            #add-point:ON CHANGE nmcl123 name="input.g.page1.nmcl123"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmcl131
            #add-point:BEFORE FIELD nmcl131 name="input.b.page1.nmcl131"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmcl131
            
            #add-point:AFTER FIELD nmcl131 name="input.a.page1.nmcl131"
            LET g_nmcl_d_o.* = g_nmcl_d[l_ac].*   #160822-00012#5   add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmcl131
            #add-point:ON CHANGE nmcl131 name="input.g.page1.nmcl131"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmcl133
            #add-point:BEFORE FIELD nmcl133 name="input.b.page1.nmcl133"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmcl133
            
            #add-point:AFTER FIELD nmcl133 name="input.a.page1.nmcl133"
            LET g_nmcl_d_o.* = g_nmcl_d[l_ac].*   #160822-00012#5   add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmcl133
            #add-point:ON CHANGE nmcl133 name="input.g.page1.nmcl133"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.nmclseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmclseq
            #add-point:ON ACTION controlp INFIELD nmclseq name="input.c.page1.nmclseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmclorga
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmclorga
            #add-point:ON ACTION controlp INFIELD nmclorga name="input.c.page1.nmclorga"
            #此段落由子樣板a07產生
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_nmcl_d[l_ac].nmclorga
            LET g_qryparam.default2 = "" #g_nmcl_d[l_ac].ooefl003 #說明(簡稱)
            #150714-00024#1 mark ------
            ##2015/01/27---add---by---qiull(S)
            ##CALL s_fin_create_account_center_tmp()
            #CALL s_fin_account_center_sons_query('6',g_nmck_m.nmcksite,g_today,'')
            ##CALL s_fin_account_center_comp_str()RETURNING l_origin_str    #150626-00011#1 mark
            #CALL s_fin_account_center_sons_str()RETURNING l_origin_str     #150626-00011#1
            #CALL anmt440_change_to_sql(l_origin_str)RETURNING l_origin_str
            #LET g_qryparam.where = "ooef001 IN(",l_origin_str CLIPPED,") AND ooef017 = '",g_nmck_m.nmckcomp,"' "
            ##2015/01/27---add---by---qiull(E)
            #150714-00024#1 mark end---
            #160912-00024#1 mod s---
            #LET g_qryparam.where = " ooef001 IN ",g_site_wc   #150714-00024#1
            CALL s_fin_get_wc_str(g_site_wc) RETURNING l_origin_str
            LET g_qryparam.where = " ooef017 ='",g_nmck_m.nmckcomp,"' AND ooef001 IN ",l_origin_str CLIPPED
            #160912-00024#1 mod e---
            LET g_qryparam.where = g_qryparam.where," AND ooef201 = 'Y'" #161021-00050#8
            CALL q_ooef001()
            LET g_nmcl_d[l_ac].nmclorga = g_qryparam.return1
            #LET g_nmcl_d[l_ac].ooefl003 = g_qryparam.return2
            DISPLAY g_nmcl_d[l_ac].nmclorga TO nmclorga
            #DISPLAY g_nmcl_d[l_ac].ooefl003 TO ooefl003 #說明(簡稱)
            NEXT FIELD nmclorga
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmclorga_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmclorga_desc
            #add-point:ON ACTION controlp INFIELD nmclorga_desc name="input.c.page1.nmclorga_desc"
            #此段落由子樣板a07產生
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_nmcl_d[l_ac].nmclorga
            LET g_qryparam.default2 = "" #g_nmcl_d[l_ac].ooefl003 #說明(簡稱)
            #150714-00024#1 mark ------
            ##2015/01/27---add---by---qiull(S)
            #CALL s_fin_create_account_center_tmp()
            #CALL s_fin_account_center_sons_query('6',g_nmck_m.nmcksite,g_today,'')
            ##CALL s_fin_account_center_comp_str()RETURNING l_origin_str    #150626-00011#1 mark
            #CALL s_fin_account_center_sons_str()RETURNING l_origin_str     #150626-00011#1
            #CALL anmt440_change_to_sql(l_origin_str)RETURNING l_origin_str
            #LET g_qryparam.where = "ooef001 IN(",l_origin_str CLIPPED,") AND ooef017 = '",g_nmck_m.nmckcomp,"' "
            #2015/01/27---add---by---qiull(E)
            #150714-00024#1 mark end---
            CALL s_fin_get_wc_str(g_site_wc) RETURNING l_origin_str  #160912-00024#1 add 
            #LET g_qryparam.where = " ooef001 IN ",g_site_wc         #150714-00024#1 #160912-00024#1 mark
            LET g_qryparam.where = " ooef017 ='",g_nmck_m.nmckcomp,"' AND ooef001 IN ",l_origin_str #160912-00024#1 add
            LET g_qryparam.where = g_qryparam.where," AND ooef201 = 'Y'" #161021-00050#8
            CALL q_ooef001()
            LET g_nmcl_d[l_ac].nmclorga = g_qryparam.return1
            #LET g_nmcl_d[l_ac].ooefl003 = g_qryparam.return2
            CALL anmt440_ref_b()
            DISPLAY g_nmcl_d[l_ac].nmclorga_desc TO nmclorga_desc
            #DISPLAY g_nmcl_d[l_ac].ooefl003 TO ooefl003 #說明(簡稱)
            NEXT FIELD nmclorga_desc
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmcl001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmcl001
            #add-point:ON ACTION controlp INFIELD nmcl001 name="input.c.page1.nmcl001"
            #此段落由子樣板a07產生 
            #151029-00001#5--add--str--lujh
            IF g_nmck_m.nmck001 = 'IV' THEN 
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_nmcl_d[l_ac].nmcl001   #給予default值
               LET g_qryparam.default2 = g_nmcl_d[l_ac].nmcl002   #給予default值
            
               LET g_qryparam.where = "      apea005 = '",g_nmck_m.nmck005,"'",
                                      " AND apeborga = '",g_nmcl_d[l_ac].nmclorga,"'",
                                      " AND apebcomp = '",g_nmck_m.nmckcomp,"'",
                                      " AND apeb100 = '",g_nmck_m.nmck100,"'",
                                      " AND apea001 = '40' ",  #151029-00001#5 add by 02599
                                      " AND apeastus = 'Y' ",  #151029-00001#5 add by 02599
                                      " AND apeb006  = '30'",
                                      " AND apebdocno||apebseq NOT IN (",
                                      " SELECT nmcl001||nmcl002 FROM nmck_t,nmcl_t ",
                                      "  WHERE nmclent = '",g_enterprise,"'",
                                      "    AND nmckent = nmclent ",
                                      "    AND nmckcomp = nmclcomp ",
                                      "    AND nmckdocno = nmcldocno ",
                                      "    AND nmckstus <> 'X' ",
                                      "    AND nmcl001 IS NOT NULL )"  
                                      
               CALL q_apeadocno_1()                                #呼叫開窗
               
               IF NOT cl_null(g_qryparam.return1) THEN 
                  CALL anmt440_ins_nmcl()
                  LET l_flag = 'Y'
                  EXIT DIALOG
               ELSE
                  NEXT FIELD nmcl001  #151029-00001#5 add by 02599
               END IF
            ELSE
            #151029-00001#5--add--end--lujh
               #開窗i段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               
               LET g_qryparam.default1 = g_nmcl_d[l_ac].nmcl001 
               LET g_qryparam.default2 = g_nmcl_d[l_ac].nmcl002             #給予default值
               
               IF g_nmck_m.nmck001 = 'AP' THEN 
                 LET g_qryparam.where = "     apda001 = '45' AND apda005 = '",g_nmck_m.nmck005,"'",
                                         " AND apde006 = '30' AND apdeorga = '",g_nmcl_d[l_ac].nmclorga,"'",
                                         " AND apde100 = '",g_nmck_m.nmck100,"'",
                                         " AND apdald = '",g_glaald,"'",
                                         " AND (apdastus = 'Y' OR apdastus = 'V')",
                                         " AND apde002 IN (select gzcb002 FROM gzcb_t where gzcb001 = '8506' AND gzcb004 = '2' )",
                                         " AND apdedocno||apdeseq NOT IN (",
                                         " SELECT nmcl001||nmcl002 FROM nmck_t,nmcl_t ",
                                         "  WHERE nmclent = '",g_enterprise,"'",
                                         "    AND nmckent = nmclent ",
                                         "    AND nmckcomp = nmclcomp ",
                                         "    AND nmckdocno = nmcldocno ",
                                         "    AND nmck002 IN (SELECT ooia001 FROM ooia_t WHERE ooia002 = '30' AND ooiaent = ",g_enterprise," )",
                                         "    AND nmckstus <> 'X' )"
                                         
                  CALL q_apdeseq()                                #呼叫開窗
               END IF
               
               LET g_nmcl_d[l_ac].nmcl001 = g_qryparam.return1              
               LET g_nmcl_d[l_ac].nmcl002 = g_qryparam.return2 
               DISPLAY g_nmcl_d[l_ac].nmcl001 TO nmcl001              #
               DISPLAY g_nmcl_d[l_ac].nmcl002 TO nmcl002 
               
               NEXT FIELD nmcl001                          #返回原欄位
            END IF     #151029-00001#5 add lujh
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmcl002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmcl002
            #add-point:ON ACTION controlp INFIELD nmcl002 name="input.c.page1.nmcl002"
            #此段落由子樣板a07產生            
            #開窗i段
#            INITIALIZE g_qryparam.* TO NULL
#            LET g_qryparam.state = 'i'
#            LET g_qryparam.reqry = FALSE
#
#            LET g_qryparam.default1 = g_nmcl_d[l_ac].nmcl002             #給予default值
#            IF g_nmck_m.nmck001 = 'AP' THEN
#               LET g_qryparam.where = "     apdedocno = '",g_nmcl_d[l_ac].nmcl001,"'",
#                                      " AND apda001 = '45' AND apda005 = '",g_nmck_m.nmck005,"'",
#                                      " AND apde006 = '30' AND apdeorga = '",g_nmcl_d[l_ac].nmclorga,"'",
#                                      " AND apdald = '",g_glaald,"'",
#                                      " AND apdeseq NOT IN (",
#                                      " SELECT nmcl002 FROM nmck_t,nmcl_t ",
#                                      "  WHERE nmclent = '",g_enterprise,"'",
#                                      "    AND nmckent = nmclent ",
#                                      "    AND nmckcomp = nmclcomp ",
#                                      "    AND nmckdocno = nmcldocno ",
#                                      "    AND nmckstus <> 'X' )"
#               
#               CALL q_apdeseq()                                #呼叫開窗
#            END IF
#
#            LET g_nmcl_d[l_ac].nmcl002 = g_qryparam.return1              
#
#            DISPLAY g_nmcl_d[l_ac].nmcl002 TO nmcl002              #
#
#            NEXT FIELD nmcl002                          #返回原欄位
#

            #END add-point
 
 
         #Ctrlp:input.c.page1.nmcl003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmcl003
            #add-point:ON ACTION controlp INFIELD nmcl003 name="input.c.page1.nmcl003"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_nmcl_d[l_ac].nmcl003             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #
            SELECT glaa004 INTO l_glaa004 
              FROM glaa_t 
             WHERE glaaent = g_enterprise 
               AND glaacomp = g_nmck_m.nmckcomp
               AND glaa014='Y'
            
            SELECT glaald INTO l_glaald
              FROM glaa_t 
             WHERE glaaent = g_enterprise 
               AND glaacomp = g_nmck_m.nmckcomp
               AND glaa014='Y'
            LET g_qryparam.where = "glac003<> '1' AND glac001 = '",l_glaa004,"' ",
                                   " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 AND gladld='",l_glaald,"' AND gladent=",g_enterprise,
                                   " AND gladstus = 'Y' )" #150916-00015#1 add

            CALL aglt310_04()                                #呼叫開窗

            LET g_nmcl_d[l_ac].nmcl003 = g_qryparam.return1              

            DISPLAY g_nmcl_d[l_ac].nmcl003 TO nmcl003              #
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = l_glaa004
            LET g_ref_fields[2] = g_nmcl_d[l_ac].nmcl003
            CALL ap_ref_array2(g_ref_fields,"SELECT glacl004 FROM glacl_t WHERE glaclent='"||g_enterprise||"' AND glacl001=? AND glacl002=? ","")
                          RETURNING g_rtn_fields
            LET g_nmcl_d[l_ac].nmcl003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_nmcl_d[l_ac].nmcl003_desc
            NEXT FIELD nmcl003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.nmcl003_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmcl003_desc
            #add-point:ON ACTION controlp INFIELD nmcl003_desc name="input.c.page1.nmcl003_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmcl103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmcl103
            #add-point:ON ACTION controlp INFIELD nmcl103 name="input.c.page1.nmcl103"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmcl113
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmcl113
            #add-point:ON ACTION controlp INFIELD nmcl113 name="input.c.page1.nmcl113"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmcl121
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmcl121
            #add-point:ON ACTION controlp INFIELD nmcl121 name="input.c.page1.nmcl121"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmcl123
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmcl123
            #add-point:ON ACTION controlp INFIELD nmcl123 name="input.c.page1.nmcl123"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmcl131
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmcl131
            #add-point:ON ACTION controlp INFIELD nmcl131 name="input.c.page1.nmcl131"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmcl133
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmcl133
            #add-point:ON ACTION controlp INFIELD nmcl133 name="input.c.page1.nmcl133"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_nmcl_d[l_ac].* = g_nmcl_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE anmt440_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_nmcl_d[l_ac].nmclseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_nmcl_d[l_ac].* = g_nmcl_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL anmt440_nmcl_t_mask_restore('restore_mask_o')
      
               UPDATE nmcl_t SET (nmclcomp,nmcldocno,nmclseq,nmclorga,nmcl001,nmcl002,nmcl003,nmcl103, 
                   nmcl113,nmcl121,nmcl123,nmcl131,nmcl133) = (g_nmck_m.nmckcomp,g_nmck_m.nmckdocno, 
                   g_nmcl_d[l_ac].nmclseq,g_nmcl_d[l_ac].nmclorga,g_nmcl_d[l_ac].nmcl001,g_nmcl_d[l_ac].nmcl002, 
                   g_nmcl_d[l_ac].nmcl003,g_nmcl_d[l_ac].nmcl103,g_nmcl_d[l_ac].nmcl113,g_nmcl_d[l_ac].nmcl121, 
                   g_nmcl_d[l_ac].nmcl123,g_nmcl_d[l_ac].nmcl131,g_nmcl_d[l_ac].nmcl133)
                WHERE nmclent = g_enterprise AND nmclcomp = g_nmck_m.nmckcomp 
                  AND nmcldocno = g_nmck_m.nmckdocno 
 
                  AND nmclseq = g_nmcl_d_t.nmclseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_nmcl_d[l_ac].* = g_nmcl_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "nmcl_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_nmcl_d[l_ac].* = g_nmcl_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "nmcl_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_nmck_m.nmckcomp
               LET gs_keys_bak[1] = g_nmckcomp_t
               LET gs_keys[2] = g_nmck_m.nmckdocno
               LET gs_keys_bak[2] = g_nmckdocno_t
               LET gs_keys[3] = g_nmcl_d[g_detail_idx].nmclseq
               LET gs_keys_bak[3] = g_nmcl_d_t.nmclseq
               CALL anmt440_update_b('nmcl_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL anmt440_nmcl_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_nmcl_d[g_detail_idx].nmclseq = g_nmcl_d_t.nmclseq 
 
                  ) THEN
                  LET gs_keys[01] = g_nmck_m.nmckcomp
                  LET gs_keys[gs_keys.getLength()+1] = g_nmck_m.nmckdocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_nmcl_d_t.nmclseq
 
                  CALL anmt440_key_update_b(gs_keys,'nmcl_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_nmck_m),util.JSON.stringify(g_nmcl_d_t)
               LET g_log2 = util.JSON.stringify(g_nmck_m),util.JSON.stringify(g_nmcl_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
              #161019-00001#1 Mark ---(S)---
              #LET l_nmcl103=0
              ##150714-00024#1 add nmcl113
              #SELECT SUM(nmcl103),SUM(nmcl113) INTO l_nmcl103,l_nmcl113
              #  FROM nmcl_t
              # WHERE nmclent = g_enterprise
              #   AND nmcldocno = g_nmck_m.nmckdocno
              #   AND nmclcomp = g_nmck_m.nmckcomp 
              #IF cl_null(l_nmcl103) THEN LET l_nmcl103 = 0 END IF #150714-00024#1
              #IF cl_null(l_nmcl113) THEN LET l_nmcl113 = 0 END IF #150714-00024#1
              #UPDATE nmck_t SET nmck103 = l_nmcl103,
              #                  nmck113 = l_nmcl113
              # WHERE nmckent = g_enterprise
              #   AND nmckdocno = g_nmck_m.nmckdocno
              #   AND nmckcomp = g_nmck_m.nmckcomp   
              #LET g_nmck_m.nmck103=l_nmcl103
              #LET g_nmck_m.nmck113=l_nmcl103 * g_nmck_m.nmck101 #150714-00024#1 mark
              #LET g_nmck_m.nmck113=l_nmcl113 #150714-00024#1
              #DISPLAY BY NAME g_nmck_m.nmck103,g_nmck_m.nmck113 
              #161019-00001#1 Mark ---(E)---
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL anmt440_unlock_b("nmcl_t","'1'")
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
               LET g_nmcl_d[li_reproduce_target].* = g_nmcl_d[li_reproduce].*
 
               LET g_nmcl_d[li_reproduce_target].nmclseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_nmcl_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_nmcl_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
 
 
 
 
{</section>}
 
{<section id="anmt440.input.other" >}
      
      #add-point:自定義input name="input.more_input"
#      SUBDIALOG anm_anmt440_01.anmt440_01_input
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
            #151029-00001#5--add--str--
            IF l_flag = 'Y' THEN     
               NEXT FIELD nmcl001
            END IF
            #151029-00001#5--add--end
            #end add-point  
            NEXT FIELD nmckcomp
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD nmclseq
 
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
#151029-00001#5--add--str--lujh   
   IF l_flag = 'Y' THEN
      CONTINUE WHILE
   ELSE
      EXIT WHILE
   END IF
   
END WHILE
#151029-00001#5--add--end--lujh
  #161019-00001#1 Mark ---(S)---
  #LET l_n = 0
  #SELECT COUNT(*) INTO l_n 
  #  FROM nmcl_t
  # WHERE nmclent = g_enterprise
  #   AND nmcldocno = g_nmck_m.nmckdocno
  #   AND nmclcomp = g_nmck_m.nmckcomp 
  #IF l_n > 0 THEN    
  #   CALL s_transaction_begin()
  #   #150714-00024#1 add nmcl113
  #   SELECT SUM(nmcl103),SUM(nmcl113) INTO l_nmcl103,l_nmcl113
  #     FROM nmcl_t
  #    WHERE nmclent = g_enterprise
  #      AND nmcldocno = g_nmck_m.nmckdocno
  #      AND nmclcomp = g_nmck_m.nmckcomp
  #   IF cl_null(l_nmcl103) THEN LET l_nmcl103 = 0 END IF #150714-00024#1
  #   IF cl_null(l_nmcl113) THEN LET l_nmcl113 = 0 END IF #150714-00024#1
  #   UPDATE nmck_t SET nmck103 = l_nmcl103,
  #                     nmck113 = l_nmcl113
  #    WHERE nmckent = g_enterprise
  #      AND nmckdocno = g_nmck_m.nmckdocno
  #      AND nmckcomp = g_nmck_m.nmckcomp
  #   IF SQLCA.sqlcode THEN
  #      INITIALIZE g_errparam TO NULL
  #      LET g_errparam.code = SQLCA.sqlcode
  #      LET g_errparam.extend = "nmck_t"
  #      LET g_errparam.popup = TRUE
  #      CALL cl_err()
  #      CALL s_transaction_end('N','0')
  #   ELSE
  #      CALL s_transaction_end('Y','0')
  #      #150714-00024#1 add ------
  #      LET g_nmck_m.nmck103=l_nmcl103
  #      LET g_nmck_m.nmck113=l_nmcl113
  #      DISPLAY BY NAME g_nmck_m.nmck103,g_nmck_m.nmck113
  #      #150714-00024#1 add end---
  #   END IF
  #END IF
  #161019-00001#1 Mark ---(E)---
  #161019-00001#1 Add  ---(S)---
   #檢核金額不一致是否更新至單頭
   LET g_nmckcomp = g_nmck_m.nmckcomp
   LET g_nmckdocno= g_nmck_m.nmckdocno
   CALL anmt440_01_chk_money() RETURNING g_sub_success
   IF NOT g_sub_success THEN
      IF cl_ask_confirm('aap-00210') THEN
         CALL s_transaction_begin()
         SELECT SUM(nmcl103),SUM(nmcl113) INTO l_nmcl103,l_nmcl113
           FROM nmcl_t
          WHERE nmclent = g_enterprise
            AND nmcldocno = g_nmck_m.nmckdocno
            AND nmclcomp = g_nmck_m.nmckcomp
         IF cl_null(l_nmcl103) THEN LET l_nmcl103 = 0 END IF
         IF cl_null(l_nmcl113) THEN LET l_nmcl113 = 0 END IF
         #161114-00030#1 add s---
         IF NOT cl_null(g_nmck_m.nmck028) THEN
            LET l_nmck029=l_nmcl113*g_nmck_m.nmck028/100
            UPDATE nmck_t SET nmck103 = l_nmcl103,
                              nmck113 = l_nmcl113,
                              nmck029 = l_nmck029
             WHERE nmckent = g_enterprise
               AND nmckdocno = g_nmck_m.nmckdocno
               AND nmckcomp = g_nmck_m.nmckcomp            
         ELSE 
         #161114-00030#1 add e---         
            UPDATE nmck_t SET nmck103 = l_nmcl103,
                              nmck113 = l_nmcl113
             WHERE nmckent = g_enterprise
               AND nmckdocno = g_nmck_m.nmckdocno
               AND nmckcomp = g_nmck_m.nmckcomp
         END IF   #161114-00030#1 add    
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "nmck_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            CALL s_transaction_end('N','0')
         ELSE         
            CALL s_transaction_end('Y','0')
            #單頭金額重新顯示
            LET g_nmck_m.nmck103=l_nmcl103
            LET g_nmck_m.nmck113=l_nmcl113
            DISPLAY BY NAME g_nmck_m.nmck103,g_nmck_m.nmck113
            #161114-00030#1 add s---
            IF NOT cl_null(g_nmck_m.nmck028) THEN
               LET g_nmck_m.nmck029=l_nmck029
               DISPLAY BY NAME g_nmck_m.nmck029
            END IF
            #161114-00030#1 add e---
         END IF
      END IF
   END IF
  #161019-00001#1 Add  ---(E)---
   IF g_nmck_m.nmckstus <> 'N' THEN
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)   
   ELSE
      CALL cl_set_act_visible("modify,delete,modify_detail", TRUE)  
   END IF
   
   #160616-00026#1--add--str--
   IF g_nmck_m.nmck001 <> 'AP' THEN
      CALL cl_set_combo_scc('nmck001','8722') 
   END IF
   #160616-00026#1--add--end
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="anmt440.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION anmt440_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   DEFINE l_glaa004 LIKE glaa_t.glaa004
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   IF g_nmck_m.nmckstus <> 'N' THEN
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)   
   ELSE
      CALL cl_set_act_visible("modify,delete", TRUE)  
   END IF
   CALL anmt440_glaa()
   #150825-00004#1 add ------
   #如果付款對象是EMPL就顯示
   IF g_nmck_m.nmck005 = 'EMPL' THEN
      CALL cl_set_comp_visible('nmck006,nmck006_desc',TRUE)
      LET g_nmck_m.nmck006_desc = s_desc_get_person_desc(g_nmck_m.nmck006)
      DISPLAY BY NAME g_nmck_m.nmck006_desc
   ELSE
      CALL cl_set_comp_visible('nmck006,nmck006_desc',FALSE)
   END IF
   #150825-00004#1 add end---
   
   #160617-00017#1 add s---
   IF g_nmck_m.nmck001 = "AP" AND g_nmck_m.nmckstus = 'N' THEN
      CALL cl_set_act_visible("anmt440_02",TRUE) 
   ELSE
      CALL cl_set_act_visible("anmt440_02",FALSE) 
   END IF
   #160617-00017#1 add e---
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL anmt440_b_fill() #單身填充
      CALL anmt440_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL anmt440_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   #現金變動碼說明
   CALL anmt440_nmck010_desc()
   CALL anmt440_nmck004_desc()
   #160524-00055#1 add s---
   CALL anmt440_nmck044_desc() 
   CALL anmt440_nmck045_desc() 
   CALL anmt440_nmck048_desc()  
   CALL anmt440_nmck047_desc()  
   CALL anmt440_nmck049_desc()  
   CALL anmt440_nmck050_desc()     
   #160524-00055#1 add e---
   #150518-00043#13 經辦人姓名
   LET g_nmck_m.nmck022_desc = s_desc_get_person_desc(g_nmck_m.nmck022) 
   #end add-point
   
   #遮罩相關處理
   LET g_nmck_m_mask_o.* =  g_nmck_m.*
   CALL anmt440_nmck_t_mask()
   LET g_nmck_m_mask_n.* =  g_nmck_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_nmck_m.nmcksite,g_nmck_m.nmcksite_desc,g_nmck_m.nmckcomp,g_nmck_m.nmckcomp_desc, 
       g_nmck_m.nmck003,g_nmck_m.nmck003_desc,g_nmck_m.nmckdocno,g_nmck_m.nmck002,g_nmck_m.nmckdocdt, 
       g_nmck_m.nmck004,g_nmck_m.nmck004_desc,g_nmck_m.nmas003,g_nmck_m.nmck019,g_nmck_m.nmckstus,g_nmck_m.nmckownid, 
       g_nmck_m.nmckownid_desc,g_nmck_m.nmckowndp,g_nmck_m.nmckowndp_desc,g_nmck_m.nmckcrtid,g_nmck_m.nmckcrtid_desc, 
       g_nmck_m.nmckcrtdp,g_nmck_m.nmckcrtdp_desc,g_nmck_m.nmckcrtdt,g_nmck_m.nmckmodid,g_nmck_m.nmckmodid_desc, 
       g_nmck_m.nmckmoddt,g_nmck_m.nmckcnfid,g_nmck_m.nmckcnfid_desc,g_nmck_m.nmckcnfdt,g_nmck_m.nmck001, 
       g_nmck_m.nmck100,g_nmck_m.nmck103,g_nmck_m.nmck101,g_nmck_m.nmck113,g_nmck_m.nmck121,g_nmck_m.nmck123, 
       g_nmck_m.nmck131,g_nmck_m.nmck133,g_nmck_m.nmck034,g_nmck_m.nmck035,g_nmck_m.nmck022,g_nmck_m.nmck022_desc, 
       g_nmck_m.nmck036,g_nmck_m.nmck023,g_nmck_m.nmck011,g_nmck_m.nmck009,g_nmck_m.nmck009_desc,g_nmck_m.nmck010, 
       g_nmck_m.nmck010_desc,g_nmck_m.nmck024,g_nmck_m.nmck027,g_nmck_m.nmck025,g_nmck_m.nmck026,g_nmck_m.nmck114, 
       g_nmck_m.nmck124,g_nmck_m.nmck134,g_nmck_m.nmck005,g_nmck_m.nmck005_desc,g_nmck_m.nmck006,g_nmck_m.nmck006_desc, 
       g_nmck_m.nmck015,g_nmck_m.nmck046,g_nmck_m.nmck030,g_nmck_m.nmck031,g_nmck_m.nmck028,g_nmck_m.nmck029, 
       g_nmck_m.nmck032,g_nmck_m.nmck032_desc,g_nmck_m.nmck044,g_nmck_m.nmck044_desc,g_nmck_m.nmck045, 
       g_nmck_m.nmck045_desc,g_nmck_m.nmck047,g_nmck_m.nmck047_desc,g_nmck_m.nmck048,g_nmck_m.nmck048_desc, 
       g_nmck_m.nmck049,g_nmck_m.nmck049_desc,g_nmck_m.nmck050,g_nmck_m.nmck050_desc,g_nmck_m.nmck051 
 
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_nmck_m.nmckstus 
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
   FOR l_ac = 1 TO g_nmcl_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      SELECT glaa004 INTO l_glaa004 
        FROM glaa_t 
       WHERE glaaent = g_enterprise 
         AND glaacomp = g_nmck_m.nmckcomp
         AND glaa014='Y'
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = l_glaa004
      LET g_ref_fields[2] = g_nmcl_d[l_ac].nmcl003
      CALL ap_ref_array2(g_ref_fields,"SELECT glacl004 FROM glacl_t WHERE glaclent='"||g_enterprise||"' AND glacl001=? AND glacl002=? ","")
                    RETURNING g_rtn_fields
      LET g_nmcl_d[l_ac].nmcl003_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_nmcl_d[l_ac].nmcl003_desc
      #end add-point
   END FOR
   
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL anmt440_detail_show()
 
   #add-point:show段之後 name="show.after"
   CALL s_anm_get_comp_wc('6',g_nmck_m.nmcksite,g_nmck_m.nmckdocdt) RETURNING g_comp_wc   #150714-00024#1
   #CALL s_anm_get_site_wc('6',g_nmck_m.nmckcomp,g_nmck_m.nmckdocdt) RETURNING g_site_wc   #150714-00024#1 #160912-00024#1
   CALL s_anm_get_site_wc('6',g_nmck_m.nmcksite,g_nmck_m.nmckdocdt) RETURNING g_site_wc    #160912-00024#1
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="anmt440.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION anmt440_detail_show()
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
 
{<section id="anmt440.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION anmt440_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE nmck_t.nmckcomp 
   DEFINE l_oldno     LIKE nmck_t.nmckcomp 
   DEFINE l_newno02     LIKE nmck_t.nmckdocno 
   DEFINE l_oldno02     LIKE nmck_t.nmckdocno 
 
   DEFINE l_master    RECORD LIKE nmck_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE nmcl_t.* #此變數樣板目前無使用
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="reproduce.pre_function"
   
   #end add-point
   
   #切換畫面
   
   LET g_master_insert = FALSE
   
   IF g_nmck_m.nmckcomp IS NULL
   OR g_nmck_m.nmckdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_nmckcomp_t = g_nmck_m.nmckcomp
   LET g_nmckdocno_t = g_nmck_m.nmckdocno
 
    
   LET g_nmck_m.nmckcomp = ""
   LET g_nmck_m.nmckdocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_nmck_m.nmckownid = g_user
      LET g_nmck_m.nmckowndp = g_dept
      LET g_nmck_m.nmckcrtid = g_user
      LET g_nmck_m.nmckcrtdp = g_dept 
      LET g_nmck_m.nmckcrtdt = cl_get_current()
      LET g_nmck_m.nmckmodid = g_user
      LET g_nmck_m.nmckmoddt = cl_get_current()
      LET g_nmck_m.nmckstus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
#   LET g_nmckcomp_o = g_nmckcomp_t
#   LET g_nmckdocno_o = g_nmckdocno_t
   IF NOT cl_null(g_nmck_m.nmck025) THEN
      LET g_nmck_m.nmck026='1'
   ELSE
      LET g_nmck_m.nmck026='0'
   END IF
   DISPLAY BY NAME g_nmck_m.nmck026
   CALL anmt440_nmck026_scc('1')
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_nmck_m.nmckstus 
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
      LET g_nmck_m.nmckcomp_desc = ''
   DISPLAY BY NAME g_nmck_m.nmckcomp_desc
 
   
   CALL anmt440_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_nmck_m.* TO NULL
      INITIALIZE g_nmcl_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL anmt440_show()
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
   CALL anmt440_set_act_visible()   
   CALL anmt440_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_nmckcomp_t = g_nmck_m.nmckcomp
   LET g_nmckdocno_t = g_nmck_m.nmckdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " nmckent = " ||g_enterprise|| " AND",
                      " nmckcomp = '", g_nmck_m.nmckcomp, "' "
                      ," AND nmckdocno = '", g_nmck_m.nmckdocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL anmt440_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   CALL anmt440_nmck026_scc('2')
   #end add-point
   
   CALL anmt440_idx_chk()
   
   LET g_data_owner = g_nmck_m.nmckownid      
   LET g_data_dept  = g_nmck_m.nmckowndp
   
   #功能已完成,通報訊息中心
   CALL anmt440_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="anmt440.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION anmt440_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE nmcl_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE anmt440_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM nmcl_t
    WHERE nmclent = g_enterprise AND nmclcomp = g_nmckcomp_t
     AND nmcldocno = g_nmckdocno_t
 
    INTO TEMP anmt440_detail
 
   #將key修正為調整後   
   UPDATE anmt440_detail 
      #更新key欄位
      SET nmclcomp = g_nmck_m.nmckcomp
          , nmcldocno = g_nmck_m.nmckdocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO nmcl_t SELECT * FROM anmt440_detail
   
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
   DROP TABLE anmt440_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_nmckcomp_t = g_nmck_m.nmckcomp
   LET g_nmckdocno_t = g_nmck_m.nmckdocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="anmt440.delete" >}
#+ 資料刪除
PRIVATE FUNCTION anmt440_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point     
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   DEFINE l_success        LIKE type_t.num5  #150813-00015#5 add
#150813-00015#5--mark--str--
#   #當票況=0時才可異動
#   IF g_nmck_m.nmck026 <> '0' AND g_nmck_m.nmck026 <> '1' THEN
#      INITIALIZE g_errparam TO NULL
#      LET g_errparam.code = 'anm-00162'
#      LET g_errparam.extend = ''
#      LET g_errparam.popup = FALSE
#      CALL cl_err()
#
#      RETURN
#   END IF
#150813-00015#5--mark--end
   #end add-point     
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   IF g_nmck_m.nmckcomp IS NULL
   OR g_nmck_m.nmckdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN anmt440_cl USING g_enterprise,g_nmck_m.nmckcomp,g_nmck_m.nmckdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN anmt440_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE anmt440_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE anmt440_master_referesh USING g_nmck_m.nmckcomp,g_nmck_m.nmckdocno INTO g_nmck_m.nmcksite, 
       g_nmck_m.nmckcomp,g_nmck_m.nmck003,g_nmck_m.nmckdocno,g_nmck_m.nmck002,g_nmck_m.nmckdocdt,g_nmck_m.nmck004, 
       g_nmck_m.nmck019,g_nmck_m.nmckstus,g_nmck_m.nmckownid,g_nmck_m.nmckowndp,g_nmck_m.nmckcrtid,g_nmck_m.nmckcrtdp, 
       g_nmck_m.nmckcrtdt,g_nmck_m.nmckmodid,g_nmck_m.nmckmoddt,g_nmck_m.nmckcnfid,g_nmck_m.nmckcnfdt, 
       g_nmck_m.nmck001,g_nmck_m.nmck100,g_nmck_m.nmck103,g_nmck_m.nmck101,g_nmck_m.nmck113,g_nmck_m.nmck121, 
       g_nmck_m.nmck123,g_nmck_m.nmck131,g_nmck_m.nmck133,g_nmck_m.nmck034,g_nmck_m.nmck035,g_nmck_m.nmck022, 
       g_nmck_m.nmck036,g_nmck_m.nmck023,g_nmck_m.nmck011,g_nmck_m.nmck009,g_nmck_m.nmck010,g_nmck_m.nmck024, 
       g_nmck_m.nmck027,g_nmck_m.nmck025,g_nmck_m.nmck026,g_nmck_m.nmck114,g_nmck_m.nmck124,g_nmck_m.nmck134, 
       g_nmck_m.nmck005,g_nmck_m.nmck006,g_nmck_m.nmck015,g_nmck_m.nmck046,g_nmck_m.nmck030,g_nmck_m.nmck031, 
       g_nmck_m.nmck028,g_nmck_m.nmck029,g_nmck_m.nmck032,g_nmck_m.nmck044,g_nmck_m.nmck045,g_nmck_m.nmck047, 
       g_nmck_m.nmck048,g_nmck_m.nmck049,g_nmck_m.nmck050,g_nmck_m.nmck051,g_nmck_m.nmcksite_desc,g_nmck_m.nmckcomp_desc, 
       g_nmck_m.nmck003_desc,g_nmck_m.nmck004_desc,g_nmck_m.nmckownid_desc,g_nmck_m.nmckowndp_desc,g_nmck_m.nmckcrtid_desc, 
       g_nmck_m.nmckcrtdp_desc,g_nmck_m.nmckmodid_desc,g_nmck_m.nmckcnfid_desc,g_nmck_m.nmck009_desc, 
       g_nmck_m.nmck005_desc,g_nmck_m.nmck032_desc,g_nmck_m.nmck044_desc,g_nmck_m.nmck045_desc,g_nmck_m.nmck047_desc, 
       g_nmck_m.nmck048_desc,g_nmck_m.nmck049_desc,g_nmck_m.nmck050_desc
   
   
   #檢查是否允許此動作
   IF NOT anmt440_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_nmck_m_mask_o.* =  g_nmck_m.*
   CALL anmt440_nmck_t_mask()
   LET g_nmck_m_mask_n.* =  g_nmck_m.*
   
   CALL anmt440_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   #150813-00015#5--add--str--
   IF g_nmck_m.nmckstus <> 'N' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'agl-00313'
      LET g_errparam.extend = 'modify'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CLOSE anmt440_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF 
   
   #檢查當單據日期小於等於關帳日期時，不可異動單據
   CALL s_fin_date_close_chk('',g_nmck_m.nmckcomp,'ANM',g_nmck_m.nmckdocdt) RETURNING l_success
   IF l_success = FALSE THEN
      CLOSE anmt440_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #當票況=0時才可異動
   IF g_nmck_m.nmck026 <> '0' AND g_nmck_m.nmck026 <> '1' AND g_nmck_m.nmck026 <> '2' THEN #160413-00001#1 add <>2
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'anm-00162'
      LET g_errparam.extend = ''
      LET g_errparam.popup = FALSE
      CALL cl_err()
      CLOSE anmt440_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   #150813-00015#5--add--end
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL anmt440_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_nmckcomp_t = g_nmck_m.nmckcomp
      LET g_nmckdocno_t = g_nmck_m.nmckdocno
 
 
      DELETE FROM nmck_t
       WHERE nmckent = g_enterprise AND nmckcomp = g_nmck_m.nmckcomp
         AND nmckdocno = g_nmck_m.nmckdocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      IF NOT s_aooi200_fin_del_docno(g_glaald,g_nmck_m.nmckdocno,g_nmck_m.nmckdocdt) THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_nmck_m.nmckcomp,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
#      DELETE FROM nmcl_t
#       WHERE nmclent = g_enterprise AND nmclcomp = g_nmck_m.nmckcomp
#         AND nmcldocno = g_nmck_m.nmckdocno
#      IF SQLCA.sqlcode THEN
#         CALL cl_err("nmcl_t",SQLCA.sqlcode,0) 
#         CALL s_transaction_end('N','0')
#         RETURN
#      END IF 
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM nmcl_t
       WHERE nmclent = g_enterprise AND nmclcomp = g_nmck_m.nmckcomp
         AND nmcldocno = g_nmck_m.nmckdocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      IF g_nmck_m.nmck001 = 'AP' THEN
         UPDATE apde_t SET apde009 = 'N',
                           apde003 = '',
                           apde014 = ''
          WHERE apdeent = g_enterprise
            AND apdedocno = g_nmcl_d[l_ac].nmcl001
           #AND apdeseq = g_nmcl_d[l_ac].nmcl002    #150714-00024#1
      END IF
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "nmcl_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      IF g_nmck_m.nmck001 = 'AP' THEN     
         CALL anmt440_upd_apde()  #更新 apde008,apde009
      END IF   
      #end add-point
      
            
                                                               
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_nmck_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE anmt440_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_nmcl_d.clear() 
 
     
      CALL anmt440_ui_browser_refresh()  
      #CALL anmt440_ui_headershow()  
      #CALL anmt440_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL anmt440_browser_fill("")
         CALL anmt440_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE anmt440_cl
 
   #功能已完成,通報訊息中心
   CALL anmt440_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="anmt440.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION anmt440_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_nmcl_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF anmt440_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT nmclseq,nmclorga,nmcl001,nmcl002,nmcl003,nmcl103,nmcl113,nmcl121, 
             nmcl123,nmcl131,nmcl133  FROM nmcl_t",   
                     " INNER JOIN nmck_t ON nmckent = " ||g_enterprise|| " AND nmckcomp = nmclcomp ",
                     " AND nmckdocno = nmcldocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                     
                     " WHERE nmclent=? AND nmclcomp=? AND nmcldocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY nmcl_t.nmclseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE anmt440_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR anmt440_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_nmck_m.nmckcomp,g_nmck_m.nmckdocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_nmck_m.nmckcomp,g_nmck_m.nmckdocno INTO g_nmcl_d[l_ac].nmclseq, 
          g_nmcl_d[l_ac].nmclorga,g_nmcl_d[l_ac].nmcl001,g_nmcl_d[l_ac].nmcl002,g_nmcl_d[l_ac].nmcl003, 
          g_nmcl_d[l_ac].nmcl103,g_nmcl_d[l_ac].nmcl113,g_nmcl_d[l_ac].nmcl121,g_nmcl_d[l_ac].nmcl123, 
          g_nmcl_d[l_ac].nmcl131,g_nmcl_d[l_ac].nmcl133   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill.fill"
         CALL anmt440_ref_b()
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
   
   CALL g_nmcl_d.deleteElement(g_nmcl_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE anmt440_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_nmcl_d.getLength()
      LET g_nmcl_d_mask_o[l_ac].* =  g_nmcl_d[l_ac].*
      CALL anmt440_nmcl_t_mask()
      LET g_nmcl_d_mask_n[l_ac].* =  g_nmcl_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="anmt440.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION anmt440_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM nmcl_t
       WHERE nmclent = g_enterprise AND
         nmclcomp = ps_keys_bak[1] AND nmcldocno = ps_keys_bak[2] AND nmclseq = ps_keys_bak[3]
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
         CALL g_nmcl_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="anmt440.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION anmt440_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO nmcl_t
                  (nmclent,
                   nmclcomp,nmcldocno,
                   nmclseq
                   ,nmclorga,nmcl001,nmcl002,nmcl003,nmcl103,nmcl113,nmcl121,nmcl123,nmcl131,nmcl133) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_nmcl_d[g_detail_idx].nmclorga,g_nmcl_d[g_detail_idx].nmcl001,g_nmcl_d[g_detail_idx].nmcl002, 
                       g_nmcl_d[g_detail_idx].nmcl003,g_nmcl_d[g_detail_idx].nmcl103,g_nmcl_d[g_detail_idx].nmcl113, 
                       g_nmcl_d[g_detail_idx].nmcl121,g_nmcl_d[g_detail_idx].nmcl123,g_nmcl_d[g_detail_idx].nmcl131, 
                       g_nmcl_d[g_detail_idx].nmcl133)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "nmcl_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_nmcl_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="anmt440.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION anmt440_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "nmcl_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL anmt440_nmcl_t_mask_restore('restore_mask_o')
               
      UPDATE nmcl_t 
         SET (nmclcomp,nmcldocno,
              nmclseq
              ,nmclorga,nmcl001,nmcl002,nmcl003,nmcl103,nmcl113,nmcl121,nmcl123,nmcl131,nmcl133) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_nmcl_d[g_detail_idx].nmclorga,g_nmcl_d[g_detail_idx].nmcl001,g_nmcl_d[g_detail_idx].nmcl002, 
                  g_nmcl_d[g_detail_idx].nmcl003,g_nmcl_d[g_detail_idx].nmcl103,g_nmcl_d[g_detail_idx].nmcl113, 
                  g_nmcl_d[g_detail_idx].nmcl121,g_nmcl_d[g_detail_idx].nmcl123,g_nmcl_d[g_detail_idx].nmcl131, 
                  g_nmcl_d[g_detail_idx].nmcl133) 
         WHERE nmclent = g_enterprise AND nmclcomp = ps_keys_bak[1] AND nmcldocno = ps_keys_bak[2] AND nmclseq = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "nmcl_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "nmcl_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL anmt440_nmcl_t_mask_restore('restore_mask_n')
               
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
 
{<section id="anmt440.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION anmt440_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="anmt440.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION anmt440_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="anmt440.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION anmt440_lock_b(ps_table,ps_page)
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
   #CALL anmt440_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "nmcl_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN anmt440_bcl USING g_enterprise,
                                       g_nmck_m.nmckcomp,g_nmck_m.nmckdocno,g_nmcl_d[g_detail_idx].nmclseq  
                                               
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "anmt440_bcl:",SQLERRMESSAGE 
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
 
{<section id="anmt440.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION anmt440_unlock_b(ps_table,ps_page)
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
      CLOSE anmt440_bcl
   END IF
   
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="anmt440.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION anmt440_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("nmckdocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("nmckcomp,nmckdocno",TRUE)
      CALL cl_set_comp_entry("nmckdocdt",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   CALL cl_set_comp_entry("nmcksite,nmck002,nmck003,nmck004,nmckdocdt",TRUE)
   CALL cl_set_comp_entry("nmck103,nmck101,nmck113,nmck024,nmck025,nmck027,nmck034,nmck005,nmck015",TRUE)
   CALL cl_set_comp_entry("nmck028,nmck029,nmck030,nmck031,nmck032",TRUE)
   CALL cl_set_comp_entry("nmck044,nmck045,nmck046,nmck047,nmck048,nmck049,nmck050",TRUE)
   #160524-00055#1 add s---
   IF NOT cl_null(g_nmck_m.nmck045) THEN 
      CALL cl_set_comp_entry("nmck051",TRUE)
   END IF   
   #160524-00055#1 add e---
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="anmt440.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION anmt440_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   DEFINE l_success  LIKE type_t.num5  
   DEFINE l_slip     LIKE type_t.chr10
   DEFINE l_dfin0033  LIKE type_t.chr80
   DEFINE l_para_date LIKE type_t.dat   #150813-00015#5 add
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("nmckcomp,nmckdocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
   
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("nmckdocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("nmckdocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   #CALL cl_set_comp_entry("nmck001",FALSE)      #151029-00001#5 mark lujh  
   #160524-00055#1 add s---
   CALL cl_set_comp_entry("nmck046",FALSE)       
   IF cl_null(g_nmck_m.nmck045) THEN 
      CALL cl_set_comp_entry("nmck051",FALSE)
   END IF
   #160524-00055#1 add e---
   IF g_nmck_m.nmck001='AP' THEN 
      CALL cl_set_comp_entry("nmcksite,nmck002,nmck003,nmck004,nmckdocdt",FALSE)
     #CALL cl_set_comp_entry("nmck103,nmck101,nmck113,nmck024,nmck025,nmck027,nmck034,nmck005,nmck015",FALSE)   #150616-00026#6 mark
     #CALL cl_set_comp_entry("nmck103,nmck101,nmck113,nmck027,nmck034,nmck005,nmck015",FALSE)   #150616-00026#6  #150825 mark
      CALL cl_set_comp_entry("nmck103,nmck101,nmck113,nmck027,nmck005,nmck015",FALSE)   #150825
      CALL cl_set_comp_entry("nmck028,nmck029,nmck030,nmck031,nmck032",FALSE)
      CALL cl_set_comp_entry("nmck044,nmck045,nmck046,nmck047,nmck048,nmck049,nmck050",FALSE)
      CALL cl_set_comp_entry("nmck001,nmck100,nmck103,nmck101,nmck113,nmck034,nmck035",FALSE)         #160617-00017#1
      CALL cl_set_comp_entry("nmck022,nmck022_desc,nmck036,nmck011,nmck024,nmck025,nmck026",FALSE)    #160617-00017#1
      CALL cl_set_comp_entry("nmck005,nmck006,nmck015",FALSE)                                         #160617-00017#1
      #150825 add ------
      IF NOT cl_null(g_nmck_m.nmck035) THEN
         CALL cl_set_comp_entry("nmck034",FALSE)
      END IF
      #150825 add end---
   END IF
   #151130-00015#2 -begin -add by XZG 20151218
#   IF NOT cl_null(g_nmck_m.nmckdocno) THEN #150813-00015#5 mark
   IF NOT cl_null(g_nmck_m.nmckdocno) AND p_cmd = 'u'  THEN  #150813-00015#5 add
      #获取单别
      CALL s_aooi200_fin_get_slip(g_nmck_m.nmckdocno) RETURNING l_success,l_slip
      #是否可改日期
      CALL s_fin_get_doc_para(g_glaald,g_nmck_m.nmckcomp,l_slip,'D-FIN-0033') RETURNING l_dfin0033
      #抓取关帐日期
      CALL cl_get_para(g_enterprise,g_nmck_m.nmckcomp,'S-FIN-4007') RETURNING l_para_date #150813-00015#5 add
#      IF l_dfin0033 = "N"  THEN  #150813-00015#5 mark
      IF l_dfin0033 = "N" AND g_nmck_m.nmckdocdt <= l_para_date THEN  #150813-00015#5 add
         CALL cl_set_comp_entry("nmckdocdt",FALSE)
      ELSE 
         CALL cl_set_comp_entry("nmckdocdt",TRUE)
      END IF          
   END IF 
   #151130-00015#2  -end 
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="anmt440.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION anmt440_set_entry_b(p_cmd)
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
   CALL cl_set_comp_entry("nmcl001,nmcl002",TRUE)
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="anmt440.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION anmt440_set_no_entry_b(p_cmd)
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
   IF g_nmck_m.nmck001='XX' THEN 
     CALL cl_set_comp_entry("nmcl001,nmcl002",FALSE)
   END IF
   
   #151029-00001#5--add--str--lujh
   IF g_nmck_m.nmck001='IV' THEN 
     CALL cl_set_comp_entry("nmcl003,nmcl103,nmcl113",FALSE)
   END IF
   #151029-00001#5--add--end--lujh
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="anmt440.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION anmt440_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce",TRUE)
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="anmt440.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION anmt440_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   #iluym 2014/11/28 add---str
   IF g_nmck_m.nmckstus <> "N" THEN
      CALL cl_set_act_visible("modify,modify_detail,delete", FALSE)
   END IF
   #----add----end 
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   IF g_nmck_m.nmck001='AP' THEN 
      CALL cl_set_act_visible("modify_detail",FALSE)
   END IF   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="anmt440.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION anmt440_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
 
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="anmt440.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION anmt440_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="anmt440.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION anmt440_default_search()
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
      LET ls_wc = ls_wc, " nmckcomp = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " nmckdocno = '", g_argv[02], "' AND "
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
               WHEN la_wc[li_idx].tableid = "nmck_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "nmcl_t" 
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
 
{<section id="anmt440.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION anmt440_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_nmcl113        LIKE nmcl_t.nmcl113
   DEFINE l_nmcl001        LIKE nmcl_t.nmcl001
   DEFINE l_nmcl002        LIKE nmcl_t.nmcl002
   DEFINE l_success        LIKE type_t.num5
   DEFINE l_n              LIKE type_t.num5
   DEFINE l_today          DATETIME YEAR TO SECOND
   #151008-00014#1 mark ------
   #DEFINE l_nmaf007        LIKE nmaf_t.nmaf007
   #DEFINE l_nmaf010        LIKE nmaf_t.nmaf010
   #DEFINE l_nmaf009        LIKE nmaf_t.nmaf009
   #DEFINE l_nmck025        LIKE type_t.chr20
   #151008-00014#1 mark end---
   DEFINE l_str,l_str1     STRING
   DEFINE l_sql            STRING
   #161128-00061#2---modify----begin----------
   #DEFINE l_nmbc           RECORD LIKE nmbc_t.*
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
       nmbc012 LIKE nmbc_t.nmbc012, #票據號碼
       nmbc013 LIKE nmbc_t.nmbc013, #款別
       nmbc014 LIKE nmbc_t.nmbc014, #到期日
       nmbc015 LIKE nmbc_t.nmbc015, #匯入銀行編號
       nmbc016 LIKE nmbc_t.nmbc016, #匯入帳號
       nmbc017 LIKE nmbc_t.nmbc017, #受款人全名
       nmbcorga LIKE nmbc_t.nmbcorga #來源組織
       END RECORD

   #161128-00061#2---modify----end----------
   DEFINE l_nmcl103        LIKE nmcl_t.nmcl103
   #150518-00040#5--
   DEFINE ls_js            STRING
   DEFINE lc_param         RECORD
            xmab003           LIKE xmab_t.xmab003,          #單據編號
            xmab006           LIKE xmab_t.xmab006,          #交易客戶
            xmab007           LIKE xmab_t.xmab007,          #交易幣別
            proj              LIKE xmaa_t.xmaa002,          #目前計算項目
            proj_o            LIKE xmaa_t.xmaa002,          #前置計算項目
            type              LIKE type_t.num5,             #正負向
            glaald            LIKE glaa_t.glaald,           #帳套
            glaacomp          LIKE glaa_t.glaacomp          #法人
                           END RECORD
   #150518-00040#5--
   DEFINE l_cnt            LIKE type_t.num10             #150714-00024#1
   DEFINE l_efin5001       LIKE type_t.chr1
   DEFINE l_ooba002        LIKE ooba_t.ooba002
   DEFINE l_glaald         LIKE glaa_t.glaald
   #151008-00014#1 add ------
   DEFINE l_nmaf007        LIKE nmaf_t.nmaf007
   DEFINE l_nmaf009        LIKE nmaf_t.nmaf009
   DEFINE l_nmaf010        LIKE nmaf_t.nmaf010
   DEFINE l_nmck025        STRING
   DEFINE l_nmaf007_str    STRING
   DEFINE l_nmaf010_str    STRING
   DEFINE l_nmaf007_str2   STRING
   DEFINE l_nmaf010_str2   STRING
   DEFINE l_nmck025_str2   STRING
   DEFINE l_num            LIKE type_t.num5
   DEFINE l_str_new        LIKE nmaf_t.nmaf010
   #151008-00014#1 add end---
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_nmck_m.nmckcomp IS NULL
      OR g_nmck_m.nmckdocno IS NULL
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN anmt440_cl USING g_enterprise,g_nmck_m.nmckcomp,g_nmck_m.nmckdocno
   IF STATUS THEN
      CLOSE anmt440_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN anmt440_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE anmt440_master_referesh USING g_nmck_m.nmckcomp,g_nmck_m.nmckdocno INTO g_nmck_m.nmcksite, 
       g_nmck_m.nmckcomp,g_nmck_m.nmck003,g_nmck_m.nmckdocno,g_nmck_m.nmck002,g_nmck_m.nmckdocdt,g_nmck_m.nmck004, 
       g_nmck_m.nmck019,g_nmck_m.nmckstus,g_nmck_m.nmckownid,g_nmck_m.nmckowndp,g_nmck_m.nmckcrtid,g_nmck_m.nmckcrtdp, 
       g_nmck_m.nmckcrtdt,g_nmck_m.nmckmodid,g_nmck_m.nmckmoddt,g_nmck_m.nmckcnfid,g_nmck_m.nmckcnfdt, 
       g_nmck_m.nmck001,g_nmck_m.nmck100,g_nmck_m.nmck103,g_nmck_m.nmck101,g_nmck_m.nmck113,g_nmck_m.nmck121, 
       g_nmck_m.nmck123,g_nmck_m.nmck131,g_nmck_m.nmck133,g_nmck_m.nmck034,g_nmck_m.nmck035,g_nmck_m.nmck022, 
       g_nmck_m.nmck036,g_nmck_m.nmck023,g_nmck_m.nmck011,g_nmck_m.nmck009,g_nmck_m.nmck010,g_nmck_m.nmck024, 
       g_nmck_m.nmck027,g_nmck_m.nmck025,g_nmck_m.nmck026,g_nmck_m.nmck114,g_nmck_m.nmck124,g_nmck_m.nmck134, 
       g_nmck_m.nmck005,g_nmck_m.nmck006,g_nmck_m.nmck015,g_nmck_m.nmck046,g_nmck_m.nmck030,g_nmck_m.nmck031, 
       g_nmck_m.nmck028,g_nmck_m.nmck029,g_nmck_m.nmck032,g_nmck_m.nmck044,g_nmck_m.nmck045,g_nmck_m.nmck047, 
       g_nmck_m.nmck048,g_nmck_m.nmck049,g_nmck_m.nmck050,g_nmck_m.nmck051,g_nmck_m.nmcksite_desc,g_nmck_m.nmckcomp_desc, 
       g_nmck_m.nmck003_desc,g_nmck_m.nmck004_desc,g_nmck_m.nmckownid_desc,g_nmck_m.nmckowndp_desc,g_nmck_m.nmckcrtid_desc, 
       g_nmck_m.nmckcrtdp_desc,g_nmck_m.nmckmodid_desc,g_nmck_m.nmckcnfid_desc,g_nmck_m.nmck009_desc, 
       g_nmck_m.nmck005_desc,g_nmck_m.nmck032_desc,g_nmck_m.nmck044_desc,g_nmck_m.nmck045_desc,g_nmck_m.nmck047_desc, 
       g_nmck_m.nmck048_desc,g_nmck_m.nmck049_desc,g_nmck_m.nmck050_desc
   
 
   #檢查是否允許此動作
   IF NOT anmt440_action_chk() THEN
      CLOSE anmt440_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_nmck_m.nmcksite,g_nmck_m.nmcksite_desc,g_nmck_m.nmckcomp,g_nmck_m.nmckcomp_desc, 
       g_nmck_m.nmck003,g_nmck_m.nmck003_desc,g_nmck_m.nmckdocno,g_nmck_m.nmck002,g_nmck_m.nmckdocdt, 
       g_nmck_m.nmck004,g_nmck_m.nmck004_desc,g_nmck_m.nmas003,g_nmck_m.nmck019,g_nmck_m.nmckstus,g_nmck_m.nmckownid, 
       g_nmck_m.nmckownid_desc,g_nmck_m.nmckowndp,g_nmck_m.nmckowndp_desc,g_nmck_m.nmckcrtid,g_nmck_m.nmckcrtid_desc, 
       g_nmck_m.nmckcrtdp,g_nmck_m.nmckcrtdp_desc,g_nmck_m.nmckcrtdt,g_nmck_m.nmckmodid,g_nmck_m.nmckmodid_desc, 
       g_nmck_m.nmckmoddt,g_nmck_m.nmckcnfid,g_nmck_m.nmckcnfid_desc,g_nmck_m.nmckcnfdt,g_nmck_m.nmck001, 
       g_nmck_m.nmck100,g_nmck_m.nmck103,g_nmck_m.nmck101,g_nmck_m.nmck113,g_nmck_m.nmck121,g_nmck_m.nmck123, 
       g_nmck_m.nmck131,g_nmck_m.nmck133,g_nmck_m.nmck034,g_nmck_m.nmck035,g_nmck_m.nmck022,g_nmck_m.nmck022_desc, 
       g_nmck_m.nmck036,g_nmck_m.nmck023,g_nmck_m.nmck011,g_nmck_m.nmck009,g_nmck_m.nmck009_desc,g_nmck_m.nmck010, 
       g_nmck_m.nmck010_desc,g_nmck_m.nmck024,g_nmck_m.nmck027,g_nmck_m.nmck025,g_nmck_m.nmck026,g_nmck_m.nmck114, 
       g_nmck_m.nmck124,g_nmck_m.nmck134,g_nmck_m.nmck005,g_nmck_m.nmck005_desc,g_nmck_m.nmck006,g_nmck_m.nmck006_desc, 
       g_nmck_m.nmck015,g_nmck_m.nmck046,g_nmck_m.nmck030,g_nmck_m.nmck031,g_nmck_m.nmck028,g_nmck_m.nmck029, 
       g_nmck_m.nmck032,g_nmck_m.nmck032_desc,g_nmck_m.nmck044,g_nmck_m.nmck044_desc,g_nmck_m.nmck045, 
       g_nmck_m.nmck045_desc,g_nmck_m.nmck047,g_nmck_m.nmck047_desc,g_nmck_m.nmck048,g_nmck_m.nmck048_desc, 
       g_nmck_m.nmck049,g_nmck_m.nmck049_desc,g_nmck_m.nmck050,g_nmck_m.nmck050_desc,g_nmck_m.nmck051 
 
 
   CASE g_nmck_m.nmckstus
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
         CASE g_nmck_m.nmckstus
            
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
      #open改為unconfirmed
      CALL cl_set_act_visible("unconfirmed,invalid,confirmed,hold,unhold",TRUE)
      #無條件關結案
      CALL cl_set_act_visible("closed",FALSE)
      #提交和抽單一開始先無條件關
      CALL cl_set_act_visible("signing,withdraw",FALSE)

      CASE g_nmck_m.nmckstus
         WHEN "N"
            CALL cl_set_act_visible("unconfirmed,hold,unhold",FALSE)
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            IF cl_bpm_chk() THEN
               CALL cl_set_act_visible("signing",TRUE)
               CALL cl_set_act_visible("confirmed",FALSE)
            END IF

         WHEN "X"
            CALL cl_set_act_visible("unconfirmed,invalid,confirmed,hold,unhold",FALSE)
            CLOSE anmt440_cl               #150813-00015#5 add
            CALL s_transaction_end('N','0')#150813-00015#5 add
            RETURN
         WHEN "Y"
            CALL cl_set_act_visible("invalid,confirmed,unhold",FALSE)

         WHEN "H"
            CALL cl_set_act_visible("unconfirmed,invalid,confirmed,hold",FALSE)

          #已核准只能顯示確認;其餘應用功能皆隱藏
         WHEN "A"
            CALL cl_set_act_visible("confirmed ",TRUE)
            CALL cl_set_act_visible("unconfirmed,invalid,hold,unhold",FALSE)

         #保留修改的功能(如作廢)，隱藏其他應用功能
         WHEN "R"
            CALL cl_set_act_visible("confirmed,unconfirmed",FALSE)
         WHEN "D"
            CALL cl_set_act_visible("confirmed,unconfirmed,hold,unhold",FALSE)

         #送簽中只能顯示抽單;其餘應用功能皆隱藏
         WHEN "W"
            CALL cl_set_act_visible("withdraw",TRUE)
            CALL cl_set_act_visible("unconfirmed,invalid,confirmed,hold,unhold",FALSE)
      END CASE
      
      #CALL cl_showmsg_init()
      #end add-point
      
      #應用 a36 樣板自動產生(Version:5)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT anmt440_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE anmt440_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT anmt440_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE anmt440_cl
            RETURN
         END IF
 
 
 
	  
      ON ACTION unconfirmed
         IF cl_auth_chk_act("unconfirmed") THEN
            LET lc_state = "N"
            #add-point:action控制 name="statechange.unconfirmed"
            #151013-00016#7 151027 by sakura mark(S)
            ##150714-00024#1 add ------
            ##若該票據已在anmt450產生異動單據，則不應該取消確認
            #SELECT COUNT(*) INTO l_cnt
            #  FROM nmch_t
            #  LEFT JOIN nmci_t ON nmchent = nmcient AND nmchcomp = nmcicomp AND nmchdocno = nmcidocno
            # WHERE nmchent = g_enterprise
            #   AND nmci003 = g_nmck_m.nmckdocno
            #   AND nmchstus <> 'X'
            #IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
            #IF l_cnt > 0 THEN
            #   INITIALIZE g_errparam TO NULL
            #   LET g_errparam.code = 'anm-02930'
            #   LET g_errparam.extend = g_nmck_m.nmckdocno
            #   LET g_errparam.popup = TRUE
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   RETURN
            #END IF
            ##若該票據已在anmt470產生帳務單據，則不應該取消確認
            #SELECT COUNT(*) INTO l_cnt
            #  FROM nmbs_t
            #  LEFT JOIN nmbt_t ON nmbsent = nmbtent AND nmbsld = nmbtld AND nmbsdocno = nmbtdocno
            # WHERE nmbsent = g_enterprise
            #   AND nmbt002 = g_nmck_m.nmckdocno
            #   AND nmbsstus <> 'X'
            #IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
            #IF l_cnt > 0 THEN
            #   INITIALIZE g_errparam TO NULL
            #   LET g_errparam.code = 'anm-02929'
            #   LET g_errparam.extend = g_nmck_m.nmckdocno
            #   LET g_errparam.popup = TRUE
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   RETURN
            #END IF
            ##150714-00024#1 add end---
            #
            ##150518-00043#12-----s
            ##若該票據已回寫領取資料，則不能被取消確認
            #SELECT COUNT(*) INTO l_cnt
            #  FROM nmck_t
            # WHERE nmckent = g_enterprise
            #   AND nmck035 IS NOT NULL
            #   AND nmckdocno = g_nmck_m.nmckdocno
            #   AND nmckstus ='Y'
            #IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
            #IF l_cnt > 0 THEN
            #   INITIALIZE g_errparam TO NULL
            #   LET g_errparam.code = 'anm-02934'
            #   LET g_errparam.extend = ''
            #   LET g_errparam.popup = TRUE
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   RETURN
            #END IF
            ##150518-00043#12-----e
            #
            ##150518-00040#5--
            #LET lc_param.xmab003  = g_nmck_m.nmckdocno
            #LET lc_param.glaacomp = g_nmck_m.nmckcomp
            #LET lc_param.xmab006  = g_nmck_m.nmck005
            #LET lc_param.xmab007  = g_nmck_m.nmck100
            #LET lc_param.type   = '2'    #1:正向 2:負向
            #LET lc_param.proj   = 'P9'
            #LET ls_js = util.JSON.stringify(lc_param)
            #CALL s_credit_move(ls_js)  RETURNING g_sub_success
            #IF NOT g_sub_success THEN
            #   CALL s_transaction_end('N','0')
            #   CLOSE anmt440_cl
            #   RETURN
            #END IF
            ##150518-00040#5--
            #151013-00016#7 151027 by sakura mark(E)
            #end add-point
         END IF
         EXIT MENU
      ON ACTION confirmed
         IF cl_auth_chk_act("confirmed") THEN
            LET lc_state = "Y"
            #add-point:action控制 name="statechange.confirmed"
             

            #151013-00016#7 151027 by sakura mark(S)
            ##150714-00024#1 add ------
            ##單身有資料才可審核確認
            #SELECT COUNT(*) INTO l_n
            #  FROM nmcl_t
            # WHERE nmclent = g_enterprise
            #   AND nmclcomp = g_nmck_m.nmckcomp
            #   AND nmcldocno = g_nmck_m.nmckdocno
            #IF cl_null(l_n) THEN LET l_n = 0 END IF
            #IF l_n = 0 THEN
            #   INITIALIZE g_errparam TO NULL
            #   LET g_errparam.code = 'agl-00065'
            #   LET g_errparam.extend = ''
            #   LET g_errparam.popup = TRUE
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   RETURN
            #END IF
            ##150714-00024#1 add end---
            #
            ##150602-00057#2 by 02291 add
            #SELECT glaald INTO l_glaald FROM glaa_t
            # WHERE glaaent = g_enterprise
            #   AND glaacomp = g_nmck_m.nmckcomp
            #   AND glaa014 = 'Y'
            #CALL s_aooi200_fin_get_slip(g_nmck_m.nmckdocno) RETURNING l_success,l_ooba002
            #CALL s_fin_chk_E5001(l_glaald,g_nmck_m.nmckcomp,l_ooba002) RETURNING l_efin5001
            #IF l_efin5001 = 'N' THEN
            #   IF g_nmck_m.nmckcrtid = g_user THEN
            #      INITIALIZE g_errparam TO NULL
            #      LET g_errparam.code = 'axr-00346'
            #      LET g_errparam.extend = ''
            #      LET g_errparam.popup = TRUE
            #      CALL cl_err()
            #      CALL s_transaction_end('N','0')
            #      CLOSE anmt440_cl
            #      RETURN
            #   END IF
            #END IF   
            ##150602-00057#2 by 02291 add
            #
            ##150518-00040#5--
            #LET lc_param.xmab003  = g_nmck_m.nmckdocno
            #LET lc_param.glaacomp = g_nmck_m.nmckcomp
            #LET lc_param.xmab006  = g_nmck_m.nmck005
            #LET lc_param.xmab007  = g_nmck_m.nmck100
            #LET lc_param.type   = '1'    #1:正向 2:負向
            #LET lc_param.proj   = 'P9'
            #LET ls_js = util.JSON.stringify(lc_param)
            #CALL s_credit_move(ls_js)  RETURNING g_sub_success
            #IF NOT g_sub_success THEN
            #   CALL s_transaction_end('N','0')
            #   CLOSE anmt440_cl
            #   RETURN
            #END IF
            ##150518-00040#5--
            #
            ##151008-00014#1 add ------
            ##抓取 支票截止號碼/流水號長度/下次列印號碼
            #SELECT nmaf007,nmaf009,nmaf010 INTO l_nmaf007,l_nmaf009,l_nmaf010
            #  FROM nmaf_t
            # WHERE nmafent = g_enterprise
            #   AND nmaf001 = g_nmck_m.nmck004 #交易帳戶編碼
            #   AND nmaf002 = g_nmck_m.nmck002 #票據類型
            #   AND nmaf004 = g_nmck_m.nmck024 #支票簿號
            #
            ##擷取號碼
            #LET l_nmaf007_str = l_nmaf007
            #LET l_nmaf010_str = l_nmaf010
            #LET l_nmck025 = g_nmck_m.nmck025
            #LET l_nmaf007_str2 = l_nmaf007_str.subString(l_nmaf007_str.getLength()-l_nmaf009+1,l_nmaf007_str.getLength())
            #LET l_nmaf010_str2 = l_nmaf010_str.subString(l_nmaf010_str.getLength()-l_nmaf009+1,l_nmaf010_str.getLength())
            #LET l_nmck025_str2 = l_nmck025.subString(l_nmck025.getLength()-l_nmaf009+1,l_nmck025.getLength())
            #
            ##擷取
            #IF l_nmaf010_str2 < (l_nmck025_str2+1) AND (l_nmck025_str2+1) < l_nmaf007_str2 THEN
            #   #擷取票據文字
            #   LET l_str = l_nmaf007_str.subString(1,l_nmaf007_str.getLength()-l_nmaf009)
            #   
            #   #合併新的下次列印號碼
            #   LET l_num = l_nmck025_str2
            #   LET l_num = l_num + 1
            #   LET l_nmck025_str2 = l_num
            #   CASE
            #      WHEN l_nmaf009 = 1
            #         LET l_nmck025_str2 = l_nmck025_str2 USING "&"
            #      WHEN l_nmaf009 = 2
            #         LET l_nmck025_str2 = l_nmck025_str2 USING "&&"
            #      WHEN l_nmaf009 = 3
            #         LET l_nmck025_str2 = l_nmck025_str2 USING "&&&"
            #      WHEN l_nmaf009 = 4
            #         LET l_nmck025_str2 = l_nmck025_str2 USING "&&&&"
            #      WHEN l_nmaf009 = 5
            #         LET l_nmck025_str2 = l_nmck025_str2 USING "&&&&&"
            #      WHEN l_nmaf009 = 6
            #         LET l_nmck025_str2 = l_nmck025_str2 USING "&&&&&&"
            #      WHEN l_nmaf009 = 7
            #         LET l_nmck025_str2 = l_nmck025_str2 USING "&&&&&&&"
            #      WHEN l_nmaf009 = 8
            #         LET l_nmck025_str2 = l_nmck025_str2 USING "&&&&&&&&"
            #      WHEN l_nmaf009 = 9
            #         LET l_nmck025_str2 = l_nmck025_str2 USING "&&&&&&&&&"
            #      WHEN l_nmaf009 = 10
            #         LET l_nmck025_str2 = l_nmck025_str2 USING "&&&&&&&&&&"
            #   END CASE
            #   LET l_str_new = l_str,l_nmck025_str2
            #   
            #   UPDATE nmaf_t SET nmaf010 = l_str_new
            #    WHERE nmafent = g_enterprise
            #      AND nmaf001 = g_nmck_m.nmck004 #交易帳戶編碼
            #      AND nmaf002 = g_nmck_m.nmck002 #票據類型
            #      AND nmaf004 = g_nmck_m.nmck024 #支票簿號
            #END IF
            ##151008-00014#1 add end---
            #151013-00016#7 151027 by sakura mark(E)
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
      g_nmck_m.nmckstus = lc_state OR cl_null(lc_state) THEN
      CLOSE anmt440_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   #151013-00016#7 151027 by sakura add(S)
   CALL cl_err_collect_init()
   #確認
   IF lc_state = 'Y' THEN
      IF g_nmck_m.nmckstus = 'N' THEN
        #161019-00001#1 Add  ---(S)---
         #檢核金額不一致是否更新至單頭
         LET g_nmckcomp = g_nmck_m.nmckcomp
         LET g_nmckdocno= g_nmck_m.nmckdocno
         CALL anmt440_01_chk_money() RETURNING g_sub_success
         IF NOT g_sub_success THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'anm-02924'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()      
            CALL cl_err_collect_show()
            CALL s_transaction_end('N','0')
            RETURN
         END IF
        #161019-00001#1 Add  ---(E)---
         CALL s_anmt440_conf_chk(g_nmck_m.nmckcomp,g_nmck_m.nmckdocno) RETURNING g_sub_success
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
               CALL s_anmt440_conf_upd(g_nmck_m.nmckcomp,g_nmck_m.nmckdocno) RETURNING g_sub_success
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
   #取消確認
   IF lc_state = 'N' THEN
      CALL s_anmt440_unconf_chk(g_nmck_m.nmckcomp,g_nmck_m.nmckdocno) RETURNING g_sub_success
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
            CALL s_anmt440_unconf_upd(g_nmck_m.nmckcomp,g_nmck_m.nmckdocno) RETURNING g_sub_success
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
      CALL s_anmt440_invalid_chk(g_nmck_m.nmckcomp,g_nmck_m.nmckdocno) RETURNING g_sub_success
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
            CALL s_anmt440_invalid_upd(g_nmck_m.nmckcomp,g_nmck_m.nmckdocno) RETURNING g_sub_success
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
   
   LET g_nmck_m.nmckmodid = g_user
   LET g_nmck_m.nmckmoddt = cl_get_current()
   LET g_nmck_m.nmckstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE nmck_t 
      SET (nmckstus,nmckmodid,nmckmoddt) 
        = (g_nmck_m.nmckstus,g_nmck_m.nmckmodid,g_nmck_m.nmckmoddt)     
    WHERE nmckent = g_enterprise AND nmckcomp = g_nmck_m.nmckcomp
      AND nmckdocno = g_nmck_m.nmckdocno
    
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
      EXECUTE anmt440_master_referesh USING g_nmck_m.nmckcomp,g_nmck_m.nmckdocno INTO g_nmck_m.nmcksite, 
          g_nmck_m.nmckcomp,g_nmck_m.nmck003,g_nmck_m.nmckdocno,g_nmck_m.nmck002,g_nmck_m.nmckdocdt, 
          g_nmck_m.nmck004,g_nmck_m.nmck019,g_nmck_m.nmckstus,g_nmck_m.nmckownid,g_nmck_m.nmckowndp, 
          g_nmck_m.nmckcrtid,g_nmck_m.nmckcrtdp,g_nmck_m.nmckcrtdt,g_nmck_m.nmckmodid,g_nmck_m.nmckmoddt, 
          g_nmck_m.nmckcnfid,g_nmck_m.nmckcnfdt,g_nmck_m.nmck001,g_nmck_m.nmck100,g_nmck_m.nmck103,g_nmck_m.nmck101, 
          g_nmck_m.nmck113,g_nmck_m.nmck121,g_nmck_m.nmck123,g_nmck_m.nmck131,g_nmck_m.nmck133,g_nmck_m.nmck034, 
          g_nmck_m.nmck035,g_nmck_m.nmck022,g_nmck_m.nmck036,g_nmck_m.nmck023,g_nmck_m.nmck011,g_nmck_m.nmck009, 
          g_nmck_m.nmck010,g_nmck_m.nmck024,g_nmck_m.nmck027,g_nmck_m.nmck025,g_nmck_m.nmck026,g_nmck_m.nmck114, 
          g_nmck_m.nmck124,g_nmck_m.nmck134,g_nmck_m.nmck005,g_nmck_m.nmck006,g_nmck_m.nmck015,g_nmck_m.nmck046, 
          g_nmck_m.nmck030,g_nmck_m.nmck031,g_nmck_m.nmck028,g_nmck_m.nmck029,g_nmck_m.nmck032,g_nmck_m.nmck044, 
          g_nmck_m.nmck045,g_nmck_m.nmck047,g_nmck_m.nmck048,g_nmck_m.nmck049,g_nmck_m.nmck050,g_nmck_m.nmck051, 
          g_nmck_m.nmcksite_desc,g_nmck_m.nmckcomp_desc,g_nmck_m.nmck003_desc,g_nmck_m.nmck004_desc, 
          g_nmck_m.nmckownid_desc,g_nmck_m.nmckowndp_desc,g_nmck_m.nmckcrtid_desc,g_nmck_m.nmckcrtdp_desc, 
          g_nmck_m.nmckmodid_desc,g_nmck_m.nmckcnfid_desc,g_nmck_m.nmck009_desc,g_nmck_m.nmck005_desc, 
          g_nmck_m.nmck032_desc,g_nmck_m.nmck044_desc,g_nmck_m.nmck045_desc,g_nmck_m.nmck047_desc,g_nmck_m.nmck048_desc, 
          g_nmck_m.nmck049_desc,g_nmck_m.nmck050_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_nmck_m.nmcksite,g_nmck_m.nmcksite_desc,g_nmck_m.nmckcomp,g_nmck_m.nmckcomp_desc, 
          g_nmck_m.nmck003,g_nmck_m.nmck003_desc,g_nmck_m.nmckdocno,g_nmck_m.nmck002,g_nmck_m.nmckdocdt, 
          g_nmck_m.nmck004,g_nmck_m.nmck004_desc,g_nmck_m.nmas003,g_nmck_m.nmck019,g_nmck_m.nmckstus, 
          g_nmck_m.nmckownid,g_nmck_m.nmckownid_desc,g_nmck_m.nmckowndp,g_nmck_m.nmckowndp_desc,g_nmck_m.nmckcrtid, 
          g_nmck_m.nmckcrtid_desc,g_nmck_m.nmckcrtdp,g_nmck_m.nmckcrtdp_desc,g_nmck_m.nmckcrtdt,g_nmck_m.nmckmodid, 
          g_nmck_m.nmckmodid_desc,g_nmck_m.nmckmoddt,g_nmck_m.nmckcnfid,g_nmck_m.nmckcnfid_desc,g_nmck_m.nmckcnfdt, 
          g_nmck_m.nmck001,g_nmck_m.nmck100,g_nmck_m.nmck103,g_nmck_m.nmck101,g_nmck_m.nmck113,g_nmck_m.nmck121, 
          g_nmck_m.nmck123,g_nmck_m.nmck131,g_nmck_m.nmck133,g_nmck_m.nmck034,g_nmck_m.nmck035,g_nmck_m.nmck022, 
          g_nmck_m.nmck022_desc,g_nmck_m.nmck036,g_nmck_m.nmck023,g_nmck_m.nmck011,g_nmck_m.nmck009, 
          g_nmck_m.nmck009_desc,g_nmck_m.nmck010,g_nmck_m.nmck010_desc,g_nmck_m.nmck024,g_nmck_m.nmck027, 
          g_nmck_m.nmck025,g_nmck_m.nmck026,g_nmck_m.nmck114,g_nmck_m.nmck124,g_nmck_m.nmck134,g_nmck_m.nmck005, 
          g_nmck_m.nmck005_desc,g_nmck_m.nmck006,g_nmck_m.nmck006_desc,g_nmck_m.nmck015,g_nmck_m.nmck046, 
          g_nmck_m.nmck030,g_nmck_m.nmck031,g_nmck_m.nmck028,g_nmck_m.nmck029,g_nmck_m.nmck032,g_nmck_m.nmck032_desc, 
          g_nmck_m.nmck044,g_nmck_m.nmck044_desc,g_nmck_m.nmck045,g_nmck_m.nmck045_desc,g_nmck_m.nmck047, 
          g_nmck_m.nmck047_desc,g_nmck_m.nmck048,g_nmck_m.nmck048_desc,g_nmck_m.nmck049,g_nmck_m.nmck049_desc, 
          g_nmck_m.nmck050,g_nmck_m.nmck050_desc,g_nmck_m.nmck051
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   #151013-00016#7 151027 by sakura mark(S)
   #LET g_success = 'Y'
   #IF lc_state = 'Y' THEN 
   #   LET l_today  = cl_get_current() 
   #   UPDATE nmck_t SET nmckcnfid = g_user,
   #                     nmckcnfdt = l_today
   #    WHERE nmckent = g_enterprise 
   #      AND nmckcomp =  g_nmck_m.nmckcomp
   #      AND nmckdocno = g_nmck_m.nmckdocno
   #      
   #   IF g_success = 'Y' THEN
   #      CALL s_transaction_end('Y','1')
   #   END IF
   #   IF g_success = 'N' THEN
   #      CALL s_transaction_end('N','1')
   #   END IF
   #ELSE
   #   UPDATE nmck_t SET nmckcnfid = '',
   #                     nmckcnfdt = ''
   #    WHERE nmckent = g_enterprise 
   #      AND nmckcomp =  g_nmck_m.nmckcomp
   #      AND nmckdocno = g_nmck_m.nmckdocno
   #   #150616-00026#6--(s)
   #   IF lc_state = 'X' THEN 
   #      CALL anmt440_upd_apde()  #更新 apde008,apde009
   #   END IF
   #   #150616-00026#6--(e)   
   #   IF g_success = 'Y' THEN
   #      CALL s_transaction_end('Y','1')
   #   END IF
   #   IF g_success = 'N' THEN
   #      CALL s_transaction_end('N','1')
   #   END IF
   #END IF
   #151013-00016#7 151027 by sakura mark(E)
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE anmt440_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL anmt440_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="anmt440.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION anmt440_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_nmcl_d.getLength() THEN
         LET g_detail_idx = g_nmcl_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_nmcl_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_nmcl_d.getLength() TO FORMONLY.cnt
   END IF
   
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="anmt440.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION anmt440_b_fill2(pi_idx)
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
   
   CALL anmt440_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="anmt440.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION anmt440_fill_chk(ps_idx)
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
 
{<section id="anmt440.status_show" >}
PRIVATE FUNCTION anmt440_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="anmt440.mask_functions" >}
&include "erp/anm/anmt440_mask.4gl"
 
{</section>}
 
{<section id="anmt440.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION anmt440_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
 
 
   CALL anmt440_show()
   CALL anmt440_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   #151013-00016#7 151027 by sakura add(S)
   IF NOT s_anmt440_conf_chk(g_nmck_m.nmckcomp ,g_nmck_m.nmckdocno) THEN
      CLOSE anmt440_cl
      CALL s_transaction_end('N','0')
      RETURN FALSE
   END IF
   #151013-00016#7 151027 by sakura add(E)
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_nmck_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_nmcl_d))
 
 
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
   #CALL anmt440_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL anmt440_ui_headershow()
   CALL anmt440_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION anmt440_draw_out()
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
   CALL anmt440_ui_headershow()  
   CALL anmt440_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="anmt440.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION anmt440_set_pk_array()
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
   LET g_pk_array[1].values = g_nmck_m.nmckcomp
   LET g_pk_array[1].column = 'nmckcomp'
   LET g_pk_array[2].values = g_nmck_m.nmckdocno
   LET g_pk_array[2].column = 'nmckdocno'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="anmt440.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="anmt440.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION anmt440_msgcentre_notify(lc_state)
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
   CALL anmt440_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_nmck_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="anmt440.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION anmt440_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="anmt440.other_function" readonly="Y" >}
# 付款對象
PRIVATE FUNCTION anmt440_nmck005_desc()
   DEFINE l_pmaa004      LIKE pmaa_t.pmaa004
      
   SELECT pmaa004 INTO l_pmaa004
     FROM pmaa_t
    WHERE pmaaent = g_enterprise
      AND pmaa001 = g_nmck_m.nmck005
 
   IF l_pmaa004 <> '2' THEN 
      LET g_nmck_m.nmck006 = ''
   END IF
   #非一次性交易對象
   IF cl_null(g_nmck_m.nmck006) THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_nmck_m.nmck005
      CALL ap_ref_array2(g_ref_fields,"SELECT pmaal003 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_nmck_m.nmck005_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_nmck_m.nmck005_desc
   ELSE  
      SELECT pmak003 INTO g_nmck_m.nmck005_desc
        FROM pmak_t
       WHERE pmakent = g_enterprise
         AND pmak001 = g_nmck_m.nmck006
      DISPLAY BY NAME g_nmck_m.nmck005_desc
   END IF 
END FUNCTION

################################################################################
# Descriptions...: 設置票據類別下拉框內容
# Memo...........:
# Usage..........: CALL anmt440_set_combo_scc(p_field,p_scc)
# Input parameter: p_field        欄位代號
#                : p_scc          scc碼
# Date & Author..: 2014/6/10 By wangrr
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt440_set_combo_scc(p_field,p_scc)
   DEFINE p_field        LIKE type_t.chr80
   DEFINE p_scc          LIKE type_t.chr10
   DEFINE ps_values      STRING
   DEFINE ps_items       STRING
   DEFINE pc_ooia001     LIKE ooia_t.ooia001      
   DEFINE pc_ooial003    LIKE ooial_t.ooial003  
   DEFINE li_cnt         LIKE type_t.num5
   DEFINE ps_field_name  STRING
   DEFINE lcbo_target    ui.ComboBox
   DEFINE ls_temp        STRING
   DEFINE l_sql          STRING
   DEFINE pa_array DYNAMIC ARRAY OF RECORD
             value       STRING,
             label_tag   STRING,
             label       STRING
                   END RECORD
   #161230-00012#1--mark--s---
#   LET l_sql = "SELECT ooia001,ooial003",
#               "  FROM ooia_t LEFT JOIN ooial_t   ON ooial001 = ooia001",
#               "                                 AND ooial002 = '",g_lang,"'",
#               "                                 AND ooiaent = ooialent",
#               "                                 AND ooiaent = ",g_enterprise,
#               " WHERE ooia002 = '",p_scc,"' AND ooiaent=",g_enterprise
   #161230-00012#1--mark--e-- 
   #170118-00018#1--mark--s--   
   #161230-00012#1--add--s--   
#  LET l_sql = " SELECT ooie001, ooial003",
#              "   FROM ooie_t LEFT JOIN ooial_t ON ooialent = ooieent ",
#              "    AND ooial001 = ooie001 AND ooial002 = '",g_lang,"'",
#              "  WHERE ooieent =",g_enterprise," AND ooiesite = '",g_site,"' AND ooiestus = 'Y'",
#              "  ORDER BY ooie001 "               
#
   #161230-00012#1--add--e--
   #170118-00018#1--mark--e--
   #170118-00018#1--add--s--
   LET l_sql = " SELECT ooie001, ooial003",
               "   FROM ooia_t,ooie_t LEFT JOIN ooial_t ON ooialent = ooieent ",
               "    AND ooial001 = ooie001 AND ooial002 = '",g_lang,"'",
               "  WHERE ooiaent = ooieent AND ooia001 = ooie001 AND ooia002 = '",p_scc,"' AND ooieent =",g_enterprise," AND ooiesite = '",g_site,"' AND ooiestus = 'Y'",
               "  ORDER BY ooie001 "               

   #170118-00018#1--add--e--
   
   PREPARE p_scc_itemp_pe FROM l_sql
   DECLARE p_scc_itemp_cs CURSOR FOR p_scc_itemp_pe

   LET ps_values = ''
   LET ps_items = ''

   #將選項填入陣列
   LET li_cnt = 1
   FOREACH p_scc_itemp_cs INTO pc_ooia001, pc_ooial003
      LET pa_array[li_cnt].value = pc_ooia001 CLIPPED
      LET pa_array[li_cnt].label_tag = pc_ooia001 CLIPPED
      LET pa_array[li_cnt].label = pc_ooial003 CLIPPED
      LET li_cnt = li_cnt + 1
   END FOREACH

   LET ps_field_name = p_field

   LET ps_field_name = ps_field_name.trim()

   LET lcbo_target = ui.ComboBox.forName(ps_field_name)
   CALL lcbo_target.clear()  #170118-00018#1  add xul
   #以下是Combobox的處理
   FOR li_cnt = 1 TO pa_array.getLength()
       IF cl_null(pa_array[li_cnt].label_tag) THEN
          LET ls_temp = pa_array[li_cnt].label
       ELSE
          LET ls_temp = pa_array[li_cnt].label_tag,":",pa_array[li_cnt].label
       END IF
      CALL lcbo_target.addItem(pa_array[li_cnt].value,ls_temp)
   END FOR
END FUNCTION

################################################################################
# Descriptions...: 獲取本位幣二三匯率和金額
# Memo...........:
# Usage..........: CALL anmt440_get_exrate()
# Date & Author..: 2014/6/11 By wangrr
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt440_get_exrate()
DEFINE l_ooam003      LIKE ooam_t.ooam003

   #本位幣二
   IF g_glaa015 = 'Y' THEN 
      #來源幣別
      LET l_ooam003 = ''
      IF g_glaa017 = '1' THEN
         LET l_ooam003 = g_nmck_m.nmck100
      ELSE   #表示帳簿幣別 
         LET l_ooam003 = g_glaa001  #帳套使用幣別
      END IF
                               #     帳套;       日期;           來源幣別
      CALL s_aooi160_get_exrate('2',g_glaald,g_nmck_m.nmckdocdt,l_ooam003,
                                #目的幣別; 交易金額; 匯類類型
                                g_glaa016,0,g_glaa018)
           RETURNING g_nmck_m.nmck121
      #150930-00010#4 mark--s           
      #CALL s_curr_round_ld('1',g_glaald,g_glaa016,g_nmck_m.nmck121,3)  #150714-00024#1
      #     RETURNING g_sub_success,g_errno,g_nmck_m.nmck121            #150714-00024#1
      #150930-00010#4 mark--e           
      IF g_glaa017 = '1' THEN #原幣
         LET g_nmck_m.nmck123 = g_nmck_m.nmck103 * g_nmck_m.nmck121
      ELSE #本幣
         LET g_nmck_m.nmck123 = g_nmck_m.nmck113 * g_nmck_m.nmck121
      END IF
      CALL s_curr_round_ld('1',g_glaald,g_glaa016,g_nmck_m.nmck123,2)  #150714-00024#1
           RETURNING g_sub_success,g_errno,g_nmck_m.nmck123            #150714-00024#1
      DISPLAY g_nmck_m.nmck121 TO nmck121
      DISPLAY g_nmck_m.nmck123 TO nmck123
   END IF
   
   
   #本位幣三  
   IF g_glaa019 = 'Y' THEN 
      #來源幣別
      LET l_ooam003 = ''
      IF g_glaa021 = '1' THEN
         LET l_ooam003 = g_nmck_m.nmck100
      ELSE   #表示帳簿幣別 
         LET l_ooam003 = g_glaa001           #帳套使用幣別
      END IF
                               #     帳套;       日期;           來源幣別
      CALL s_aooi160_get_exrate('2',g_glaald,g_nmck_m.nmckdocdt,l_ooam003,
                                #目的幣別; 交易金額; 匯類類型
                                g_glaa020,0,g_glaa022)
           RETURNING g_nmck_m.nmck131
      #150930-00010#4 mark--s
      #CALL s_curr_round_ld('1',g_glaald,g_glaa020,g_nmck_m.nmck131,3)  #150714-00024#1
      #     RETURNING g_sub_success,g_errno,g_nmck_m.nmck131            #150714-00024#1
      #150930-00010#4 mark--e
      IF g_glaa021 = '1' THEN
         LET g_nmck_m.nmck133 = g_nmck_m.nmck103 * g_nmck_m.nmck131
      ELSE
         LET g_nmck_m.nmck133 = g_nmck_m.nmck113 * g_nmck_m.nmck131
      END IF
      CALL s_curr_round_ld('1',g_glaald,g_glaa020,g_nmck_m.nmck133,2)  #150714-00024#1
           RETURNING g_sub_success,g_errno,g_nmck_m.nmck133            #150714-00024#1
      DISPLAY g_nmck_m.nmck131 TO nmck131
      DISPLAY g_nmck_m.nmck133 TO nmck133
   END IF
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL anmt440_nmck024_chk(p_nmck024)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt440_nmck024_chk(p_nmck024)
   DEFINE p_nmck024      LIKE nmck_t.nmck024
   DEFINE l_nmaf007      LIKE nmaf_t.nmaf007
   DEFINE l_nmaf010      LIKE nmaf_t.nmaf010
   DEFINE l_nmaf012      LIKE nmaf_t.nmaf012
   DEFINE l_nmaf011      LIKE nmaf_t.nmaf011
   
   LET g_errno=""
   SELECT nmaf010,nmaf007,nmaf012,nmaf011 INTO l_nmaf010,l_nmaf007,l_nmaf012,l_nmaf011
     FROM nmaf_t    
    WHERE nmafent = g_enterprise 
      AND nmaf001 = g_nmck_m.nmck004 #交易帳戶
      AND nmaf002 = g_nmck_m.nmck002 #票據類型
      AND nmaf004 = g_nmck_m.nmck024 #支票簿 
              
   CASE
      WHEN SQLCA.sqlcode=100     LET g_errno="anm-00150"
      WHEN l_nmaf010>=l_nmaf007  LET g_errno="anm-00151"
      WHEN l_nmaf012<>'Y'        LET g_errno="anm-00152"
      WHEN l_nmaf011='Y'         LET g_errno="anm-03031"     #161006-00023#1 add
   END CASE
   IF cl_null(g_errno) AND cl_null(g_nmck_m.nmck025) THEN
      LET g_nmck_m.nmck025=l_nmaf010
      DISPLAY BY NAME g_nmck_m.nmck025
      IF l_nmaf011='N' THEN #套印否
         CALL cl_set_comp_required("nmck025",TRUE)
      ELSE
         CALL cl_set_comp_required("nmck025",FALSE)
      END IF
      IF cl_null(g_nmck_m.nmck026) THEN
         IF NOT cl_null(g_nmck_m.nmck025) THEN
            LET g_nmck_m.nmck026='1'
         ELSE
            LET g_nmck_m.nmck026='0'
         END IF
         DISPLAY BY NAME g_nmck_m.nmck026
      END IF      
   END IF
      
END FUNCTION

#公司法人說明
PRIVATE FUNCTION anmt440_nmckcomp_desc()
   #公司法人
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_nmck_m.nmckcomp   
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_nmck_m.nmckcomp_desc = '', g_rtn_fields[1] , ''
   DISPLAY g_nmck_m.nmckcomp_desc TO nmckcomp_desc
END FUNCTION

#資金中心說明
PRIVATE FUNCTION anmt440_nmcksite_desc()
   #資金中心
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_nmck_m.nmcksite
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_nmck_m.nmcksite_desc = '', g_rtn_fields[1] , ''
   DISPLAY g_nmck_m.nmcksite_desc TO nmcksite_desc
END FUNCTION

#帳務人員
PRIVATE FUNCTION anmt440_nmck003_desc()
   #帳務人員
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_nmck_m.nmck003 
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_nmck_m.nmck003_desc = '', g_rtn_fields[1] , ''
   DISPLAY g_nmck_m.nmck003_desc TO nmck003_desc
END FUNCTION

#帳戶編碼
PRIVATE FUNCTION anmt440_nmck004_desc()
   DEFINE l_nmas001      LIKE nmas_t.nmas001
   
   #帳戶編碼
   SELECT nmas001 INTO l_nmas001 
     FROM nmas_t
    WHERE nmasent = g_enterprise
      AND nmas002 = g_nmck_m.nmck004
   #交易賬戶名稱 
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = l_nmas001
   CALL ap_ref_array2(g_ref_fields,"SELECT nmaal003 FROM nmaal_t WHERE nmaalent='"||g_enterprise||"' AND nmaal001=? AND nmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_nmck_m.nmck004_desc = '', g_rtn_fields[1] , ''
   DISPLAY g_nmck_m.nmck004_desc TO nmck004_desc
   #交易幣別
   LET g_nmck_m.nmas003 = ''
   SELECT nmas003 INTO g_nmck_m.nmas003 
     FROM nmaa_t,nmas_t
    WHERE nmaaent = g_enterprise
      AND nmaaent = nmasent
      AND nmaa001 = nmas001
      AND nmas002 = g_nmck_m.nmck004 
      AND nmaa002 IN (select ooef001 FROM ooef_t WHERE ooefent = g_enterprise
                                               AND ooef017 = g_nmck_m.nmckcomp)
   LET g_nmck_m.nmck100 = g_nmck_m.nmas003
   LET g_nmck_m.nmck046 = g_nmck_m.nmas003 #160524-00055#1
   DISPLAY g_nmck_m.nmas003 TO nmas003
   DISPLAY g_nmck_m.nmas003 TO nmck046   #160524-00055#1
   DISPLAY BY NAME g_nmck_m.nmck100
END FUNCTION

##存提碼
PRIVATE FUNCTION anmt440_nmck009_desc()
   #存提碼
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_nmck_m.nmck009
   CALL ap_ref_array2(g_ref_fields,"SELECT nmajl003 FROM nmajl_t WHERE nmajlent='"||g_enterprise||"' AND nmajl001=? AND nmajl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_nmck_m.nmck009_desc = '', g_rtn_fields[1] , ''
   DISPLAY g_nmck_m.nmck009_desc TO nmck009_desc  
END FUNCTION

#現金變動碼
PRIVATE FUNCTION anmt440_nmck010_desc()
   #現金變動碼
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_glaa005
   LET g_ref_fields[2] = g_nmck_m.nmck010
   CALL ap_ref_array2(g_ref_fields,"SELECT nmail004 FROM nmail_t WHERE nmailent='"||g_enterprise||"' AND nmail001=? AND nmail002 =? AND nmail003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_nmck_m.nmck010_desc = '', g_rtn_fields[1] , ''
   DISPLAY g_nmck_m.nmck010_desc TO nmck010_desc
END FUNCTION

#承兌銀行
PRIVATE FUNCTION anmt440_nmck032_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_nmck_m.nmck032
   CALL ap_ref_array2(g_ref_fields,"SELECT nmabl003 FROM nmabl_t WHERE nmablent='"||g_enterprise||"' AND nmabl001=? AND nmabl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_nmck_m.nmck032_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_nmck_m.nmck032_desc
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL anmt440_nmck026_scc(p_type)
# Input parameter: p_type         当前操作状态1：新增/修改；2：查询
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt440_nmck026_scc(p_type)
   DEFINE p_type       LIKE type_t.chr1
   DEFINE l_sql        STRING
   DEFINE l_str        STRING
   DEFINE l_gzcb002    LIKE gzcb_t.gzcb002
   
   #1:新增/修改;2:查詢
   IF p_type='1' THEN
      LET l_sql = "SELECT gzcb002 FROM gzcb_t WHERE gzcb001 = '8711' AND gzcb006 = 'anmt440' "
   ELSE
      LET l_sql = "SELECT gzcb002 FROM gzcb_t WHERE gzcb001 = '8711' AND gzcb006 IN ('anmt440','anmt450')"
   END IF
   PREPARE anmt440_nmck026_prep FROM l_sql
   DECLARE anmt440_nmck026_curs CURSOR FOR anmt440_nmck026_prep
   LET l_str = Null
   LET l_gzcb002 = Null
   FOREACH anmt440_nmck026_curs INTO l_gzcb002
      IF cl_null(l_str) THEN 
         LET l_str = l_gzcb002 
         CONTINUE FOREACH 
      END IF
      LET l_str = l_str,",",l_gzcb002
   END FOREACH
   CALL cl_set_combo_scc_part('nmck026','8711',l_str)
END FUNCTION

#+展期
#當票況=1：開立時，可修改‘到期日’，并更新票況=2：展期
PRIVATE FUNCTION anmt440_extension()
   DEFINE l_date    DATETIME YEAR TO SECOND
   
   IF g_nmck_m.nmckcomp IS NULL THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()

      RETURN
   END IF  
   
   IF g_nmck_m.nmck026<>'1' OR cl_null(g_nmck_m.nmck025) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'anm-00163'
      LET g_errparam.extend = ''
      LET g_errparam.popup = FALSE
      CALL cl_err()

      RETURN
   END IF
   LET g_nmck_m.nmck026='2'
   #DISPLAY BY NAME g_nmck_m.nmck026
   LET l_date=cl_get_current()
   INPUT BY NAME g_nmck_m.nmck011
      ATTRIBUTE(WITHOUT DEFAULTS)
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
      AFTER FIELD nmck011
            #160729-00011#1 add s---
            IF NOT cl_null(g_nmck_m.nmck011) THEN 
               IF g_nmck_m.nmck011 < g_nmck_m.nmckdocdt THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'anm-03017'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_nmck_m.nmck011 = g_nmck_m_t.nmck011
                  NEXT FIELD nmck011                
               END IF
            END IF
            #160729-00011#1 add e---            
      AFTER INPUT
         UPDATE nmck_t SET nmck011=g_nmck_m.nmck011,
                           nmck026=g_nmck_m.nmck026,
                           nmckmodid=g_user,
                           nmckmoddt=l_date
         WHERE nmckent=g_enterprise AND nmckcomp=g_nmck_m.nmckcomp 
           AND nmckdocno=g_nmck_m.nmckdocno
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = ''
            LET g_errparam.popup = FALSE
            CALL cl_err()

            CALL s_transaction_end('N','0')
         END IF
         
       ON ACTION accept
         ACCEPT INPUT
        
      ON ACTION cancel      #在dialog button (放棄)
         LET g_action_choice=""
         LET INT_FLAG = TRUE 
         EXIT INPUT
 
      ON ACTION close       #在dialog 右上角 (X)
         LET INT_FLAG = TRUE 
         EXIT INPUT
 
      ON ACTION exit        #toolbar 離開
         LET INT_FLAG = TRUE 
         EXIT INPUT
   END INPUT
   IF INT_FLAG THEN
      LET g_nmck_m.nmck026='1'
      LET INT_FLAG = 0        
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 9001
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()

   END IF
   CALL anmt440_show()
END FUNCTION

#+應付票據帳務資料
#當帳務資料存在時調用anmt470顯示帳務資料，反之，調用anmt470_01產生帳務資料
PRIVATE FUNCTION anmt440_open_anmt470()
   DEFINE l_nmck020     LIKE nmck_t.nmck020
   DEFINE l_nmck021     LIKE nmck_t.nmck021
   DEFINE la_param      RECORD
          prog          STRING,
          param         DYNAMIC ARRAY OF STRING
                        END RECORD
   DEFINE ls_js         STRING
   DEFINE l_cnt         LIKE type_t.num5
   DEFINE l_glaa008     LIKE glaa_t.glaa008
   DEFINE l_glaald      LIKE glaa_t.glaald
   DEFINE l_oobn003     LIKE oobn_t.oobn003
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_slip        LIKE oobn_t.oobn002
   DEFINE l_docno       LIKE nmbs_t.nmbsdocno   #150707-00001#5

   IF g_nmck_m.nmckstus<>'Y' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "anm-00196"
      LET g_errparam.extend = g_nmck_m.nmckdocno
      LET g_errparam.popup = FALSE
      CALL cl_err()

      RETURN
   END IF
   IF g_nmck_m.nmckcomp IS NULL THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()

      RETURN
   END IF
   IF g_nmck_m.nmck026 NOT MATCHES "[012]" THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "anm-00265"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()

      RETURN
   END IF
   SELECT nmck020,nmck021 INTO l_nmck020,l_nmck021 FROM nmck_t
   WHERE nmckent=g_enterprise AND nmckcomp=g_nmck_m.nmckcomp AND nmckdocno=g_nmck_m.nmckdocno
   IF NOT cl_null(g_nmck_m.nmck019) OR NOT cl_null(l_nmck020) OR NOT cl_null(l_nmck021) THEN
      LET la_param.prog = 'anmt470'
      LET la_param.param[1] = g_glaald
      LET la_param.param[2] = g_nmck_m.nmck019
      LET ls_js = util.JSON.stringify(la_param )
      CALL cl_cmdrun(ls_js)
   ELSE
      LET l_cnt = 0
      SELECT count(*) INTO l_cnt FROM glaa_t
       WHERE glaaent = g_enterprise #2015/04/01 by 02599 add
         AND glaacomp = g_nmck_m.nmckcomp
         AND glaa008 = 'Y'  #平行帳套
      IF l_cnt >0 THEN
         LET  l_glaald = ''
         LET l_glaa008='Y'
      ELSE
         LET l_glaald = g_glaald     #帳套=主帳套代碼,不可異動
         LET l_glaa008='N'
      END IF

      #CALL s_aooi200_get_slip(g_nmck_m.nmckdocno) RETURNING l_success,l_slip       #2014/12/29 liuym mark
      CALL s_aooi200_fin_get_slip(g_nmck_m.nmckdocno) RETURNING l_success,l_slip    #2014/12/29 liuym add
      SELECT oobn003 INTO l_oobn003
        FROM oobn_t
       WHERE oobnent = g_enterprise
         AND oobn001 = 'anmt470'
         AND oobn002 = l_slip
      #產生帳務資料
                        #法人                        #平行記帳否 #帳別     #單別    #單號
      CALL anmt470_01(g_nmck_m.nmckcomp,'N','Y','N', l_glaa008, l_glaald,l_oobn003,g_nmck_m.nmckdocno)       
       RETURNING l_docno   #150707-00001#5
   END IF
END FUNCTION

#+抓取帳務資料
PRIVATE FUNCTION anmt440_glaa()
   LET g_glaa001=''
   LET g_glaald=''
   LET g_glaa004=''
   LET g_glaa005=''
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
   
   
   CALL cl_get_para(g_enterprise,g_nmck_m.nmckcomp,'S-FIN-4007') RETURNING g_para_data   #資金系統關帳日
  #CALL cl_get_para(g_enterprise,g_nmck_m.nmckcomp,'S-FIN-4004') RETURNING g_para_data1  #150930-00010#4 mark  #資金模組匯率來源
   CALL cl_get_para(g_enterprise,g_nmck_m.nmckcomp,'S-FIN-4012') RETURNING g_para_data1  #150930-00010#4       #銀存支出匯率來源
   CALL cl_get_para(g_enterprise,g_nmck_m.nmckcomp,'S-FIN-4004') RETURNING g_para_data2  #150930-00010#4       #資金模組匯率來源
   
   SELECT glaa001,glaald,glaa004,glaa005,glaa015,
          glaa016,glaa017,glaa018,glaa019,glaa020,
          glaa021,glaa022,glaa003,glaa024                     #2014/12/29 liuym add glaa003,glaa024
     INTO g_glaa001,g_glaald,g_glaa004,g_glaa005,g_glaa015,
          g_glaa016,g_glaa017,g_glaa018,g_glaa019,g_glaa020,
          g_glaa021,g_glaa022,g_glaa003,g_glaa024             #2014/12/29 liuym add g_glaa003,g_glaa024
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaacomp = g_nmck_m.nmckcomp
      AND glaa014 = 'Y'
   
   #所屬國家地區
   LET g_ooef006 = ''   #160822-00012#5   add   
   SELECT ooef006 INTO g_ooef006 
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_nmck_m.nmckcomp
END FUNCTION

################################################################################
# Descriptions...: 抓取單身說明欄位
# Memo...........:
# Usage..........: CALL anmt440_ref_b()
# Date & Author..: 2014/5/12 By wangrr
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt440_ref_b()
   #組織說明
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_nmcl_d[l_ac].nmclorga 
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_nmcl_d[l_ac].nmclorga_desc = '', g_rtn_fields[1] , ''
   LET g_nmcl_d[l_ac].nmclorga_desc=g_nmcl_d[l_ac].nmclorga,g_nmcl_d[l_ac].nmclorga_desc
   DISPLAY g_nmcl_d[l_ac].nmclorga_desc TO nmclorga_desc
   #科目說明
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_glaa004
   LET g_ref_fields[2] = g_nmcl_d[l_ac].nmcl003
   CALL ap_ref_array2(g_ref_fields,"SELECT glacl004 FROM glacl_t WHERE glaclent='"||g_enterprise||"' AND glacl001=? AND glacl002=? AND glacl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_nmcl_d[l_ac].nmcl003_desc = '', g_rtn_fields[1] , ''
   DISPLAY g_nmcl_d[l_ac].nmcl003_desc TO nmcl003_desc
END FUNCTION

################################################################################
# Descriptions...: 根據來源單號+項次帶出原幣、本幣金額
# Memo...........:
# Usage..........: CALL anmt440_amt_get()
# Date & Author..: 2014/6/12 By wangrr
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt440_amt_get()
   IF g_nmck_m.nmck001 = 'AP' THEN 
      #160822-00012#5   add---s
      LET g_nmcl_d[l_ac].nmcl003 = 0
      LET g_nmcl_d[l_ac].nmcl103 = 0
      LET g_nmcl_d[l_ac].nmcl113 = 0
      LET g_nmcl_d[l_ac].nmcl121 = 0
      LET g_nmcl_d[l_ac].nmcl123 = 0
      LET g_nmcl_d[l_ac].nmcl131 = 0
      LET g_nmcl_d[l_ac].nmcl133 = 0
      #160822-00012#5   add---e
      SELECT apde016,apde109,apde119,apde121,apde129,apde131,apde139
        INTO g_nmcl_d[l_ac].nmcl003,g_nmcl_d[l_ac].nmcl103,g_nmcl_d[l_ac].nmcl113,
             g_nmcl_d[l_ac].nmcl121,g_nmcl_d[l_ac].nmcl123,g_nmcl_d[l_ac].nmcl131,g_nmcl_d[l_ac].nmcl133
        FROM apde_t
       WHERE apdeent = g_enterprise
         AND apdedocno = g_nmcl_d[l_ac].nmcl001
         AND apdeseq = g_nmcl_d[l_ac].nmcl002
         
      DISPLAY BY NAME g_nmcl_d[l_ac].nmcl003,g_nmcl_d[l_ac].nmcl103,g_nmcl_d[l_ac].nmcl113,
             g_nmcl_d[l_ac].nmcl121,g_nmcl_d[l_ac].nmcl123,g_nmcl_d[l_ac].nmcl131,g_nmcl_d[l_ac].nmcl133
   END IF
   
   #151029-00001#5--add--str--lujh
   IF g_nmck_m.nmck001 = 'IV' THEN
      LET g_nmcl_d[l_ac].nmcl103 = 0   #160822-00012#5   add   
      SELECT apeb108 INTO g_nmcl_d[l_ac].nmcl103
        FROM apeb_t
       WHERE apebent = g_enterprise
         AND apebdocno = g_nmcl_d[l_ac].nmcl001
         AND apebseq = g_nmcl_d[l_ac].nmcl002
         
      LET g_nmcl_d[l_ac].nmcl113 = g_nmcl_d[l_ac].nmcl103 * g_nmck_m.nmck101
      
      CALL s_curr_round_ld('1',g_glaald,g_nmck_m.nmck100,g_nmcl_d[l_ac].nmcl103,2) RETURNING g_sub_success,g_errno,g_nmcl_d[l_ac].nmcl103
      CALL s_curr_round_ld('1',g_glaald,g_glaa001,g_nmcl_d[l_ac].nmcl113,2) RETURNING g_sub_success,g_errno,g_nmcl_d[l_ac].nmcl113
      
      DISPLAY BY NAME g_nmcl_d[l_ac].nmcl003,g_nmcl_d[l_ac].nmcl103,g_nmcl_d[l_ac].nmcl113
   END IF
   #151029-00001#5--add--end--lujh
END FUNCTION

################################################################################
# Descriptions...: 资金中心检查
# Memo...........:
# Usage..........: CALL anmt440_nmcksite_chk()
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt440_nmcksite_chk()
   DEFINE l_ooefstus          LIKE ooef_t.ooefstus
   DEFINE l_ooef206           LIKE ooef_t.ooef206
   
   LET g_errno = ''
   
   SELECT ooef206,ooefstus INTO l_ooef206,l_ooefstus
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_nmck_m.nmcksite  
   CASE 
      WHEN SQLCA.SQLCODE = 100 LET g_errno = 'aoo-00094'
      WHEN l_ooefstus = 'N'    LET g_errno = 'sub-01302' #aoo-00095 #160318-00005#27 By 07900 --mod
      WHEN l_ooef206<>'Y'      LET g_errno = 'anm-00272'
   END CASE
   
END FUNCTION
#更新apde008,apde009
PRIVATE FUNCTION anmt440_upd_apde()

  DEFINE l_sql     STRING
  DEFINE l_nmcl001 LIKE nmcl_t.nmcl001
  DEFINE l_nmcl002 LIKE nmcl_t.nmcl002
  
  LET l_sql = " SELECT nmcl001,nmcl002 FROM nmcl_t WHERE nmclent = '",g_enterprise,"'",
              "                                      AND nmcldocno = '",g_nmck_m.nmckdocno,"'", 
              "                                      AND nmclcomp = '",g_nmck_m.nmckcomp,"'"
              
  PREPARE anmt440_nmcl_prep FROM l_sql
  DECLARE anmt440_nmcl_curs CURSOR FOR anmt440_nmcl_prep 
  
  FOREACH anmt440_nmcl_curs INTO l_nmcl001,l_nmcl002
     UPDATE apde_t SET apde009 = 'N',
                       apde003 = '',
                       apde014 = ''
                  WHERE apdeent = g_enterprise 
                    AND apdedocno = l_nmcl001
                    AND apdeseq = l_nmcl002
      
      IF STATUS THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "upd apde_t"
         LET g_errparam.code   = STATUS
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
  END FOREACH
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
PRIVATE FUNCTION anmt440_ins_nmba()
   #161128-00061#2---modify----begin----------
   #DEFINE l_nmba        RECORD LIKE nmba_t.*
   #DEFINE l_nmbb        RECORD LIKE nmbb_t.*
   DEFINE l_nmba RECORD  #銀存收支主檔
       nmbaent LIKE nmba_t.nmbaent, #企業編號
       nmbaownid LIKE nmba_t.nmbaownid, #資料所有者
       nmbaowndp LIKE nmba_t.nmbaowndp, #資料所有部門
       nmbacrtid LIKE nmba_t.nmbacrtid, #資料建立者
       nmbacrtdp LIKE nmba_t.nmbacrtdp, #資料建立部門
       nmbacrtdt LIKE nmba_t.nmbacrtdt, #資料創建日
       nmbamodid LIKE nmba_t.nmbamodid, #資料修改者
       nmbamoddt LIKE nmba_t.nmbamoddt, #最近修改日
       nmbacnfid LIKE nmba_t.nmbacnfid, #資料確認者
       nmbacnfdt LIKE nmba_t.nmbacnfdt, #資料確認日
       nmbastus LIKE nmba_t.nmbastus, #確認碼
       nmbacomp LIKE nmba_t.nmbacomp, #法人
       nmbadocno LIKE nmba_t.nmbadocno, #收支單號
       nmbadocdt LIKE nmba_t.nmbadocdt, #收支日期
       nmbasite LIKE nmba_t.nmbasite, #資金中心
       nmba001 LIKE nmba_t.nmba001, #繳款部門
       nmba002 LIKE nmba_t.nmba002, #帳務人員
       nmba003 LIKE nmba_t.nmba003, #來源作業類型
       nmba004 LIKE nmba_t.nmba004, #交易對象
       nmba005 LIKE nmba_t.nmba005, #一次性交易對象識別碼
       nmba006 LIKE nmba_t.nmba006, #暫收否
       nmba007 LIKE nmba_t.nmba007, #帳務單號
       nmba008 LIKE nmba_t.nmba008, #繳款人員
       nmba009 LIKE nmba_t.nmba009, #核准日期
       nmba010 LIKE nmba_t.nmba010, #帳套二帳務單號
       nmba011 LIKE nmba_t.nmba011, #帳套三帳務單號
       nmba012 LIKE nmba_t.nmba012, #立帳否(for流通)
       nmba013 LIKE nmba_t.nmba013, #起始日期
       nmba014 LIKE nmba_t.nmba014, #截止日期
       nmba015 LIKE nmba_t.nmba015  #往來據點
       END RECORD
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
       nmbb070 LIKE nmbb_t.nmbb070, #往來據點
       nmbb071 LIKE nmbb_t.nmbb071, #來源單號
       nmbb072 LIKE nmbb_t.nmbb072  #項次
       END RECORD

   #161128-00061#2---modify----end----------
   DEFINE l_ooef016     LIKE ooef_t.ooef016
   DEFINE l_ooab002     LIKE ooab_t.ooab002
   DEFINE l_ooam003     LIKE ooam_t.ooam003
   DEFINE r_success     LIKE type_t.num5     #160524-00055#1

   WHENEVER ERROR CONTINUE  #160524-00055#1
   LET r_success = TRUE     #160524-00055#1

   LET l_nmba.nmbaent = g_enterprise
   LET l_nmba.nmbaownid = g_user
   LET l_nmba.nmbaowndp = g_dept
   LET l_nmba.nmbacrtid = g_user
   LET l_nmba.nmbacrtdp = g_dept 
   LET l_nmba.nmbacrtdt = cl_get_current()
   LET l_nmba.nmbamodid = ""
   LET l_nmba.nmbamoddt = ""
   LET l_nmba.nmbacnfid = g_user
   LET l_nmba.nmbacnfdt = cl_get_current()
   #LET l_nmba.nmbastus = 'Y'  #161026-00010#1 mark
   LET l_nmba.nmbastus = 'V'   #161026-00010#1 add
   LET l_nmba.nmbacomp  = g_nmck_m.nmckcomp
   LET l_nmba.nmbadocdt = g_today
   LET l_nmba.nmbasite = g_nmck_m.nmcksite
   LET l_nmba.nmbadocno = g_nmck_m.nmckdocno  
   LET l_nmba.nmba001 = g_nmck_m.nmcksite
   LET l_nmba.nmba002 = g_nmck_m.nmck003
   LET l_nmba.nmba003 = 'anmt440'
   LET l_nmba.nmba004 = g_nmck_m.nmcksite
   
   #161128-00061#2---modify----begin----------   
   #INSERT INTO nmba_t VALUES(l_nmba.*)
   INSERT INTO nmba_t (nmbaent,nmbaownid,nmbaowndp,nmbacrtid,nmbacrtdp,nmbacrtdt,nmbamodid,nmbamoddt,
                       nmbacnfid,nmbacnfdt,nmbastus,nmbacomp,nmbadocno,nmbadocdt,nmbasite,nmba001,nmba002,
                       nmba003,nmba004,nmba005,nmba006,nmba007,nmba008,nmba009,nmba010,nmba011,nmba012,
                       nmba013,nmba014,nmba015)
    VALUES(l_nmba.nmbaent,l_nmba.nmbaownid,l_nmba.nmbaowndp,l_nmba.nmbacrtid,l_nmba.nmbacrtdp,l_nmba.nmbacrtdt,l_nmba.nmbamodid,l_nmba.nmbamoddt,
           l_nmba.nmbacnfid,l_nmba.nmbacnfdt,l_nmba.nmbastus,l_nmba.nmbacomp,l_nmba.nmbadocno,l_nmba.nmbadocdt,l_nmba.nmbasite,l_nmba.nmba001,l_nmba.nmba002,
           l_nmba.nmba003,l_nmba.nmba004,l_nmba.nmba005,l_nmba.nmba006,l_nmba.nmba007,l_nmba.nmba008,l_nmba.nmba009,l_nmba.nmba010,l_nmba.nmba011,l_nmba.nmba012,
           l_nmba.nmba013,l_nmba.nmba014,l_nmba.nmba015)
   #161128-00061#2---modify----end----------
   IF SQLCA.sqlcode THEN 
         LET r_success = FALSE   #160524-00055#1
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = ""
         LET g_errparam.popup = FALSE
         CALL cl_err()
   END IF
   
   CALL anmt440_glaa()
   LET l_nmbb.nmbbent = g_enterprise
   LET l_nmbb.nmbbcomp  = g_nmck_m.nmckcomp
   LET l_nmbb.nmbbdocno = g_nmck_m.nmckdocno
   LET l_nmbb.nmbborga = g_nmck_m.nmcksite
   LET l_nmbb.nmbblegl = g_nmck_m.nmcksite
   LET l_nmbb.nmbb004 = g_nmck_m.nmck046
  
   SELECT ooef016 INTO l_ooef016 FROM ooef_t 
    WHERE ooefent = g_enterprise AND ooef001 = g_nmck_m.nmckcomp
    
   SELECT ooab002 INTO l_ooab002 FROM ooab_t
    WHERE ooabent = g_enterprise AND ooabsite= g_nmck_m.nmckcomp
     #AND ooab001 = 'S-BAS-0010' 
      AND ooab001 = 'S-FIN-4004'     #150820-00017      
    
                             #匯率參照表;帳套; 日期;   來源幣別
   CALL s_aooi160_get_exrate('2',g_glaald,g_today,l_nmbb.nmbb004,
                             #目的幣別;交易金額;匯類類型
                             l_ooef016,0,l_ooab002)
         RETURNING l_nmbb.nmbb005
         
   LET l_nmbb.nmbb006 = g_nmck_m.nmck029
   LET l_nmbb.nmbb007 = l_nmbb.nmbb006*l_nmbb.nmbb005
   LET l_nmbb.nmbb011 = g_glaa016
   
   IF g_glaa015 = 'Y' THEN 
      #來源幣別
      LET l_ooam003 = ''
      IF g_glaa017 = '1' THEN
         LET l_ooam003 = l_nmbb.nmbb004
      ELSE   #表示帳簿幣別 
         LET l_ooam003 = g_glaa001           #帳套使用幣別
      END IF
  
                               #     帳套;       日期;           來源幣別
      CALL s_aooi160_get_exrate('2',g_glaald,g_today,l_ooam003,
                                #目的幣別; 交易金額; 匯類類型
                                g_glaa016,0,g_glaa018)
      RETURNING l_nmbb.nmbb012
      IF g_glaa017 = '1' THEN #原幣
         LET l_nmbb.nmbb013 = l_nmbb.nmbb006 * l_nmbb.nmbb012
      ELSE #本幣
         LET l_nmbb.nmbb013 = l_nmbb.nmbb007 * l_nmbb.nmbb012
      END IF
   END IF
  
   LET l_nmbb.nmbb015 = g_glaa020
   #本位幣三  
   IF g_glaa019 = 'Y' THEN 
      #來源幣別
      LET l_ooam003 = ''
      IF g_glaa021 = '1' THEN
         LET l_ooam003 = l_nmbb.nmbb004
      ELSE   #表示帳簿幣別 
         LET l_ooam003 = g_glaa001           #帳套使用幣別
      END IF
      
                               #     帳套;       日期;           來源幣別
      CALL s_aooi160_get_exrate('2',g_glaald,g_today,l_ooam003,
                                #目的幣別; 交易金額; 匯類類型
                                g_glaa020,0,g_glaa022)
      RETURNING l_nmbb.nmbb016
      IF g_glaa021 = '1' THEN
         LET l_nmbb.nmbb017 = l_nmbb.nmbb006 * l_nmbb.nmbb016
      ELSE
         LET l_nmbb.nmbb017 = l_nmbb.nmbb007 * l_nmbb.nmbb016
      END IF
   END IF
   
   LET l_nmbb.nmbbseq = 1
   LET l_nmbb.nmbb001 = 1
   LET l_nmbb.nmbb002 = g_nmck_m.nmck047
   LET l_nmbb.nmbb003 = g_nmck_m.nmck044
   LET l_nmbb.nmbb010 = g_nmck_m.nmck049
   
   #161128-00061#2---modify----begin----------
   #INSERT INTO nmbb_t VALUES(l_nmbb.*)
   INSERT INTO nmbb_t (nmbbent,nmbbcomp,nmbbdocno,nmbbseq,nmbborga,nmbblegl,nmbb001,nmbb002,nmbb003,nmbb004,
                       nmbb005,nmbb006,nmbb007,nmbb008,nmbb009,nmbb010,nmbb011,nmbb012,nmbb013,nmbb014,nmbb015,
                       nmbb016,nmbb017,nmbb018,nmbb019,nmbb020,nmbb021,nmbb022,nmbb023,nmbb024,nmbb025,nmbb026,
                       nmbb027,nmbb028,nmbb029,nmbb030,nmbb031,nmbb032,nmbb033,nmbb034,nmbb035,nmbb036,nmbb037,
                       nmbb038,nmbb039,nmbb040,nmbb041,nmbb042,nmbb043,nmbb044,nmbb045,nmbb046,nmbb047,nmbb048,
                       nmbb049,nmbb050,nmbb051,nmbb052,nmbb053,nmbb054,nmbb055,nmbb056,nmbb057,nmbb058,nmbb059,
                       nmbb060,nmbb061,nmbb062,nmbb063,nmbb064,nmbb065,nmbb066,nmbb067,nmbb068,nmbb069,nmbb070,
                       nmbb071,nmbb072)
    VALUES(l_nmbb.nmbbent,l_nmbb.nmbbcomp,l_nmbb.nmbbdocno,l_nmbb.nmbbseq,l_nmbb.nmbborga,l_nmbb.nmbblegl,l_nmbb.nmbb001,l_nmbb.nmbb002,l_nmbb.nmbb003,l_nmbb.nmbb004,
           l_nmbb.nmbb005,l_nmbb.nmbb006,l_nmbb.nmbb007,l_nmbb.nmbb008,l_nmbb.nmbb009,l_nmbb.nmbb010,l_nmbb.nmbb011,l_nmbb.nmbb012,l_nmbb.nmbb013,l_nmbb.nmbb014,l_nmbb.nmbb015,
           l_nmbb.nmbb016,l_nmbb.nmbb017,l_nmbb.nmbb018,l_nmbb.nmbb019,l_nmbb.nmbb020,l_nmbb.nmbb021,l_nmbb.nmbb022,l_nmbb.nmbb023,l_nmbb.nmbb024,l_nmbb.nmbb025,l_nmbb.nmbb026,
           l_nmbb.nmbb027,l_nmbb.nmbb028,l_nmbb.nmbb029,l_nmbb.nmbb030,l_nmbb.nmbb031,l_nmbb.nmbb032,l_nmbb.nmbb033,l_nmbb.nmbb034,l_nmbb.nmbb035,l_nmbb.nmbb036,l_nmbb.nmbb037,
           l_nmbb.nmbb038,l_nmbb.nmbb039,l_nmbb.nmbb040,l_nmbb.nmbb041,l_nmbb.nmbb042,l_nmbb.nmbb043,l_nmbb.nmbb044,l_nmbb.nmbb045,l_nmbb.nmbb046,l_nmbb.nmbb047,l_nmbb.nmbb048,
           l_nmbb.nmbb049,l_nmbb.nmbb050,l_nmbb.nmbb051,l_nmbb.nmbb052,l_nmbb.nmbb053,l_nmbb.nmbb054,l_nmbb.nmbb055,l_nmbb.nmbb056,l_nmbb.nmbb057,l_nmbb.nmbb058,l_nmbb.nmbb059,
           l_nmbb.nmbb060,l_nmbb.nmbb061,l_nmbb.nmbb062,l_nmbb.nmbb063,l_nmbb.nmbb064,l_nmbb.nmbb065,l_nmbb.nmbb066,l_nmbb.nmbb067,l_nmbb.nmbb068,l_nmbb.nmbb069,l_nmbb.nmbb070,
           l_nmbb.nmbb071,l_nmbb.nmbb072)
  #161128-00061#2---modify----end----------
   IF SQLCA.sqlcode THEN
      LET r_success = FALSE   #160524-00055#1 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()
   END IF
   
   LET l_nmbb.nmbbseq = 2
   LET l_nmbb.nmbb001 = 2
   LET l_nmbb.nmbb002 = g_nmck_m.nmck048
   LET l_nmbb.nmbb003 = g_nmck_m.nmck045
   LET l_nmbb.nmbb010 = g_nmck_m.nmck050
   
   #161128-00061#2---modify----begin----------
    #INSERT INTO nmbb_t VALUES(l_nmbb.*)
    INSERT INTO nmbb_t (nmbbent,nmbbcomp,nmbbdocno,nmbbseq,nmbborga,nmbblegl,nmbb001,nmbb002,nmbb003,nmbb004,
                        nmbb005,nmbb006,nmbb007,nmbb008,nmbb009,nmbb010,nmbb011,nmbb012,nmbb013,nmbb014,nmbb015,
                        nmbb016,nmbb017,nmbb018,nmbb019,nmbb020,nmbb021,nmbb022,nmbb023,nmbb024,nmbb025,nmbb026,
                        nmbb027,nmbb028,nmbb029,nmbb030,nmbb031,nmbb032,nmbb033,nmbb034,nmbb035,nmbb036,nmbb037,
                        nmbb038,nmbb039,nmbb040,nmbb041,nmbb042,nmbb043,nmbb044,nmbb045,nmbb046,nmbb047,nmbb048,
                        nmbb049,nmbb050,nmbb051,nmbb052,nmbb053,nmbb054,nmbb055,nmbb056,nmbb057,nmbb058,nmbb059,
                        nmbb060,nmbb061,nmbb062,nmbb063,nmbb064,nmbb065,nmbb066,nmbb067,nmbb068,nmbb069,nmbb070,
                        nmbb071,nmbb072)
     VALUES(l_nmbb.nmbbent,l_nmbb.nmbbcomp,l_nmbb.nmbbdocno,l_nmbb.nmbbseq,l_nmbb.nmbborga,l_nmbb.nmbblegl,l_nmbb.nmbb001,l_nmbb.nmbb002,l_nmbb.nmbb003,l_nmbb.nmbb004,
            l_nmbb.nmbb005,l_nmbb.nmbb006,l_nmbb.nmbb007,l_nmbb.nmbb008,l_nmbb.nmbb009,l_nmbb.nmbb010,l_nmbb.nmbb011,l_nmbb.nmbb012,l_nmbb.nmbb013,l_nmbb.nmbb014,l_nmbb.nmbb015,
            l_nmbb.nmbb016,l_nmbb.nmbb017,l_nmbb.nmbb018,l_nmbb.nmbb019,l_nmbb.nmbb020,l_nmbb.nmbb021,l_nmbb.nmbb022,l_nmbb.nmbb023,l_nmbb.nmbb024,l_nmbb.nmbb025,l_nmbb.nmbb026,
            l_nmbb.nmbb027,l_nmbb.nmbb028,l_nmbb.nmbb029,l_nmbb.nmbb030,l_nmbb.nmbb031,l_nmbb.nmbb032,l_nmbb.nmbb033,l_nmbb.nmbb034,l_nmbb.nmbb035,l_nmbb.nmbb036,l_nmbb.nmbb037,
            l_nmbb.nmbb038,l_nmbb.nmbb039,l_nmbb.nmbb040,l_nmbb.nmbb041,l_nmbb.nmbb042,l_nmbb.nmbb043,l_nmbb.nmbb044,l_nmbb.nmbb045,l_nmbb.nmbb046,l_nmbb.nmbb047,l_nmbb.nmbb048,
            l_nmbb.nmbb049,l_nmbb.nmbb050,l_nmbb.nmbb051,l_nmbb.nmbb052,l_nmbb.nmbb053,l_nmbb.nmbb054,l_nmbb.nmbb055,l_nmbb.nmbb056,l_nmbb.nmbb057,l_nmbb.nmbb058,l_nmbb.nmbb059,
            l_nmbb.nmbb060,l_nmbb.nmbb061,l_nmbb.nmbb062,l_nmbb.nmbb063,l_nmbb.nmbb064,l_nmbb.nmbb065,l_nmbb.nmbb066,l_nmbb.nmbb067,l_nmbb.nmbb068,l_nmbb.nmbb069,l_nmbb.nmbb070,
            l_nmbb.nmbb071,l_nmbb.nmbb072)
   #161128-00061#2---modify----end----------
      
   
   IF SQLCA.sqlcode THEN
      LET r_success = FALSE   #160524-00055#1
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()
   END IF

   
   IF r_success = TRUE THEN  #160524-00055#1  
      UPDATE nmck_t SET nmck051 = l_nmba.nmbadocno
       WHERE nmckent = g_enterprise
         AND nmckdocno = g_nmck_m.nmckdocno
         AND nmckcomp = g_nmck_m.nmckcomp  
           
      IF SQLCA.sqlcode THEN
         LET r_success = FALSE   #160524-00055#1
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = ""
         LET g_errparam.popup = FALSE
         CALL cl_err()
      END IF
   END IF #160524-00055#1    
   
    
   RETURN r_success #160524-00055#1
END FUNCTION

################################################################################
# Descriptions...: #根據原幣金額，計算本幣金額、本幣二匯率、本幣二金額、本幣三匯率、本幣三金額
# Memo...........:
# Usage..........: CALL anmt440_get_default()
# Input parameter: 
# Return code....: 
# Date & Author..: 20141209 By huangrh
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt440_get_default()
DEFINE l_nmck101 LIKE nmck_t.nmck101  #匯率
DEFINE l_nmck100 LIKE nmck_t.nmck100  #幣別
DEFINE l_ooam003 LIKE ooam_t.ooam003
DEFINE l_glaa001             LIKE glaa_t.glaa001
DEFINE l_glaald              LIKE glaa_t.glaald
DEFINE l_glaa015             LIKE glaa_t.glaa015
DEFINE l_glaa016             LIKE glaa_t.glaa016
DEFINE l_glaa017             LIKE glaa_t.glaa017
DEFINE l_glaa018             LIKE glaa_t.glaa018
DEFINE l_glaa019             LIKE glaa_t.glaa019
DEFINE l_glaa020             LIKE glaa_t.glaa020
DEFINE l_glaa021             LIKE glaa_t.glaa021
DEFINE l_glaa022             LIKE glaa_t.glaa022


   SELECT nmck100,nmck101 INTO l_nmck100,l_nmck101
    FROM nmck_t 
   WHERE nmckent = g_enterprise
     AND nmckcomp = g_nmck_m.nmckcomp
     AND nmckdocno = g_nmck_m.nmckdocno
   LET g_nmcl_d[l_ac].nmcl113 =  g_nmcl_d[l_ac].nmcl103 * l_nmck101  #本幣金額
   CALL s_curr_round_ld('1',g_glaald,g_glaa001,g_nmcl_d[l_ac].nmcl113,2)  #150714-00024#1
        RETURNING g_sub_success,g_errno,g_nmcl_d[l_ac].nmcl113            #150714-00024#1
   DISPLAY BY NAME g_nmcl_d[l_ac].nmcl113
   
   SELECT glaa001,glaald,glaa015,glaa016,glaa017,
          glaa018,glaa019,glaa020,glaa021,glaa022
     INTO l_glaa001,l_glaald,l_glaa015,l_glaa016,l_glaa017,
          l_glaa018,l_glaa019,l_glaa020,l_glaa021,l_glaa022
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaacomp = g_nmck_m.nmckcomp
      AND glaa014 = 'Y'

   LET l_ooam003 = ''
   IF l_glaa015 = 'Y' THEN
      IF l_glaa017 = '1' THEN
         LET l_ooam003 = l_nmck100
      ELSE   #表示帳簿幣別
         LET l_ooam003 = l_glaa001           #帳套使用幣別
      END IF
      CALL s_aooi160_get_exrate('2',l_glaald,g_today,l_ooam003,
                                     #目的幣別; 交易金額; 匯類類型
                                     l_glaa016,0,l_glaa018)
           RETURNING g_nmcl_d[l_ac].nmcl121  #匯率二
      #150930-00010#4 mark--s
      #CALL s_curr_round_ld('1',g_glaald,g_glaa016,g_nmcl_d[l_ac].nmcl121,3)  #150714-00024#1
      #     RETURNING g_sub_success,g_errno,g_nmcl_d[l_ac].nmcl121            #150714-00024#1
      #150930-00010#4 mark--s
      IF l_glaa017 = '1' THEN
          LET g_nmcl_d[l_ac].nmcl123 =  g_nmcl_d[l_ac].nmcl121 * g_nmcl_d[l_ac].nmcl103
      ELSE
          LET g_nmcl_d[l_ac].nmcl123 =  g_nmcl_d[l_ac].nmcl121 * g_nmcl_d[l_ac].nmcl113
      END IF
      CALL s_curr_round_ld('1',g_glaald,g_glaa016,g_nmcl_d[l_ac].nmcl123,2)  #150714-00024#1
           RETURNING g_sub_success,g_errno,g_nmcl_d[l_ac].nmcl123            #150714-00024#1
   ELSE
      LET g_nmcl_d[l_ac].nmcl121 = 0
      LET g_nmcl_d[l_ac].nmcl123 = 0
   END IF
   
   
   IF l_glaa019 = 'Y' THEN
      IF l_glaa021 = '1' THEN
         LET l_ooam003 = l_nmck100
      ELSE   #表示帳簿幣別
         LET l_ooam003 = l_glaa001           #帳套使用幣別
      END IF
      CALL s_aooi160_get_exrate('2',l_glaald,g_today,l_ooam003,
                                     #目的幣別; 交易金額; 匯類類型
                                     l_glaa020,0,l_glaa022)
           RETURNING g_nmcl_d[l_ac].nmcl131  #匯率二
      #150930-00010#4 mark--s
      #CALL s_curr_round_ld('1',g_glaald,g_glaa020,g_nmcl_d[l_ac].nmcl131,3)  #150714-00024#1
      #     RETURNING g_sub_success,g_errno,g_nmcl_d[l_ac].nmcl131            #150714-00024#1
      #150930-00010#4 mark--s
      IF l_glaa021 = '1' THEN
          LET g_nmcl_d[l_ac].nmcl133 =  g_nmcl_d[l_ac].nmcl131 * g_nmcl_d[l_ac].nmcl103
      ELSE
          LET g_nmcl_d[l_ac].nmcl133 =  g_nmcl_d[l_ac].nmcl131 * g_nmcl_d[l_ac].nmcl113
      END IF
      CALL s_curr_round_ld('1',g_glaald,g_glaa020,g_nmcl_d[l_ac].nmcl133,2)  #150714-00024#1
           RETURNING g_sub_success,g_errno,g_nmcl_d[l_ac].nmcl133            #150714-00024#1
   ELSE
      LET g_nmcl_d[l_ac].nmcl131 = 0
      LET g_nmcl_d[l_ac].nmcl133 = 0
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
PRIVATE FUNCTION anmt440_change_to_sql(p_wc)
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
# Descriptions...: 更新單身匯率
# Memo...........: #151012-00014#6
# Usage..........: CALL anmt440_upd_nmcl()
# Date & Author..: 2015/10/19 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt440_upd_nmcl()
DEFINE l_sql            STRING
DEFINE l_nmclseq        LIKE nmcl_t.nmclseq
DEFINE l_nmcl103        LIKE nmcl_t.nmcl103
DEFINE l_nmcl113        LIKE nmcl_t.nmcl113
DEFINE l_nmcl123        LIKE nmcl_t.nmcl123
DEFINE l_nmcl133        LIKE nmcl_t.nmcl133
DEFINE r_success        LIKE type_t.num5
   
   LET r_success = TRUE
   
   LET l_sql = "SELECT nmclseq,nmcl103",
               "  FROM nmcl_t",
               " WHERE nmclent = ",g_enterprise,
               "   AND nmclcomp = '",g_nmck_m.nmckcomp,"'",
               "   AND nmcldocno = '",g_nmck_m.nmckdocno,"'"
   PREPARE anmt440_nmcl_sel_p FROM l_sql
   DECLARE anmt440_nmcl_sel_c CURSOR FOR anmt440_nmcl_sel_p
   FOREACH anmt440_nmcl_sel_c INTO l_nmclseq,l_nmcl103
      IF SQLCA.sqlcode THEN
         LET r_success = FALSE
         EXIT FOREACH
      END IF
      #本幣
      LET l_nmcl113 = l_nmcl103 * g_nmck_m.nmck101
      IF cl_null(l_nmcl113) THEN LET l_nmcl113 = 0 END IF
      CALL s_curr_round_ld('1',g_glaald,g_glaa001,l_nmcl113,2)
           RETURNING g_sub_success,g_errno,l_nmcl113
      #本幣二
      LET l_nmcl123 = l_nmcl103 * g_nmck_m.nmck121
      IF cl_null(l_nmcl123) THEN LET l_nmcl123 = 0 END IF
      CALL s_curr_round_ld('1',g_glaald,g_glaa016,l_nmcl123,2)
           RETURNING g_sub_success,g_errno,l_nmcl123
      #本幣三
      LET l_nmcl133 = l_nmcl103 * g_nmck_m.nmck131
      IF cl_null(l_nmcl133) THEN LET l_nmcl133 = 0 END IF
      CALL s_curr_round_ld('1',g_glaald,g_glaa020,l_nmcl133,2)
           RETURNING g_sub_success,g_errno,l_nmcl133
      
      UPDATE nmcl_t SET nmcl113 = l_nmcl113,
                        nmcl123 = l_nmcl123,
                        nmcl133 = l_nmcl133
       WHERE nmclent = g_enterprise
         AND nmclcomp = g_nmck_m.nmckcomp
         AND nmcldocno = g_nmck_m.nmckdocno
         AND nmclseq = l_nmclseq
      IF SQLCA.sqlcode THEN
         LET r_success = FALSE
         EXIT FOREACH
      END IF
   END FOREACH
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 编辑后立即审核
# Memo...........:
# Usage..........: CALL anmt440_immediately_conf()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2015/12/03 By 07166
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt440_immediately_conf()
#151125-00006#3--s
   DEFINE l_success         LIKE type_t.num5
   DEFINE l_doc_success     LIKE type_t.num5
   DEFINE l_slip            LIKE ooba_t.ooba002
   DEFINE l_dfin0031        LIKE type_t.chr1
   DEFINE l_count           LIKE type_t.num5
   IF cl_null(g_glaald)           THEN RETURN END IF   #無資料直接返回不做處理
   IF cl_null(g_nmck_m.nmckcomp)  THEN RETURN END IF   #無資料直接返回不做處理
   IF cl_null(g_nmck_m.nmckdocno) THEN RETURN END IF   #無資料直接返回不做處理
    
   LET l_count = 0
   SELECT COUNT(*) INTO l_count FROM nmcl_t WHERE nmclent = g_enterprise
      AND nmcldocno = g_nmck_m.nmckdocno
      
   IF cl_null(l_count) THEN LET l_count = 0 END IF
   IF l_count = 0 THEN
      RETURN 
   END IF                   #单身無資料直接返回不做處理
   
   #取得單別
   CALL s_aooi200_fin_get_slip(g_nmck_m.nmckdocno) RETURNING l_success,l_slip
   #取得單別設置的"是否直接審核"參數
   CALL s_fin_get_doc_para(g_glaald,g_nmck_m.nmckcomp,l_slip,'D-FIN-0031') RETURNING l_dfin0031

   IF cl_null(l_dfin0031) OR l_dfin0031 MATCHES '[Nn]' THEN RETURN END IF #參數值為空或為N則不做直接審核邏輯
   IF NOT cl_ask_confirm('aap-00403') THEN RETURN END IF  #询问是否立即审核?
   
   
   CALL s_transaction_begin()
   CALL cl_err_collect_init()
   LET l_doc_success = TRUE
   #161019-00001#1 Add  ---(S)---
    #檢核金額不一致是否更新至單頭
    LET g_nmckcomp = g_nmck_m.nmckcomp
    LET g_nmckdocno= g_nmck_m.nmckdocno
    CALL anmt440_01_chk_money() RETURNING g_sub_success
    IF NOT g_sub_success THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = 'anm-02924'
       LET g_errparam.extend = ''
       LET g_errparam.popup = TRUE
       CALL cl_err()      
       CALL cl_err_collect_show()
       CALL s_transaction_end('N','0')
       RETURN
    END IF
   #161019-00001#1 Add  ---(E)---
   IF NOT s_anmt440_conf_chk(g_nmck_m.nmckcomp,g_nmck_m.nmckdocno) THEN
      LET l_doc_success = FALSE
   END IF
   
   IF NOT s_anmt440_conf_upd(g_nmck_m.nmckcomp,g_nmck_m.nmckdocno) THEN
      LET l_doc_success = FALSE
   END IF 
   
   #異動狀態碼欄位/修改人/修改日期
   LET g_nmck_m.nmckmoddt = cl_get_current()
   LET g_nmck_m.nmckcnfdt = cl_get_current()
   UPDATE nmck_t SET nmckstus = 'Y',
                     nmckmodid= g_user,
                     nmckmoddt= g_nmck_m.nmckmoddt,
                     nmckcnfid= g_user,
                     nmckcnfdt= g_nmck_m.nmckcnfdt
    WHERE nmckent = g_enterprise AND nmckcomp = g_nmck_m.nmckcomp
      AND nmckdocno = g_nmck_m.nmckdocno
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
# 开窗挑选整批产生单身
#151029-00001#5 add lujh
PRIVATE FUNCTION anmt440_ins_nmcl()
   #161128-00061#2---modify----begin----------
   #DEFINE l_nmcl            RECORD LIKE nmcl_t.*
   DEFINE l_nmcl RECORD  #應付匯款來源明細檔
       nmclent LIKE nmcl_t.nmclent, #企業編號
       nmclcomp LIKE nmcl_t.nmclcomp, #法人
       nmcldocno LIKE nmcl_t.nmcldocno, #單據號碼
       nmclseq LIKE nmcl_t.nmclseq, #序號
       nmclorga LIKE nmcl_t.nmclorga, #來源組織
       nmcl001 LIKE nmcl_t.nmcl001, #請款單號
       nmcl002 LIKE nmcl_t.nmcl002, #項次
       nmcl003 LIKE nmcl_t.nmcl003, #對方會科
       nmcl103 LIKE nmcl_t.nmcl103, #請款原幣金額
       nmcl113 LIKE nmcl_t.nmcl113, #請款本幣金額
       nmcl121 LIKE nmcl_t.nmcl121, #本位幣二匯率
       nmcl123 LIKE nmcl_t.nmcl123, #本位幣二金額
       nmcl131 LIKE nmcl_t.nmcl131, #本位幣三匯率
       nmcl133 LIKE nmcl_t.nmcl133  #本位幣三金額
       END RECORD

   #161128-00061#2---modify----end----------
   DEFINE l_apebdocno       LIKE apeb_t.apebdocno
   DEFINE l_apebseq         LIKE apeb_t.apebseq
   DEFINE l_apeborga        LIKE apeb_t.apeborga
   DEFINE l_apeb108         LIKE apeb_t.apeb108
   DEFINE l_sql             STRING
   DEFINE l_glaald          LIKE glaa_t.glaald
   DEFINE l_glaa001         LIKE glaa_t.glaa001
   DEFINE l_success         LIKE type_t.num5
   
   CALL s_transaction_end('N',0)
   
   CALL s_transaction_begin()
   
   LET l_success = TRUE
   
   DELETE FROM nmcl_t
    WHERE nmclent = g_enterprise
      AND nmcldocno = g_nmck_m.nmckdocno
      AND nmclcomp = g_nmck_m.nmckcomp
      AND nmclseq = g_nmcl_d[l_ac].nmclseq
      
   IF cl_null(g_nmcl_d_t.nmcl001) THEN 
      SELECT MAX(nmclseq) INTO l_nmcl.nmclseq FROM nmcl_t
       WHERE nmclent = g_enterprise
         AND nmcldocno = g_nmck_m.nmckdocno
         AND nmclcomp = g_nmck_m.nmckcomp
      IF cl_null(l_nmcl.nmclseq) THEN
         LET l_nmcl.nmclseq = 1
      ELSE
         LET l_nmcl.nmclseq = l_nmcl.nmclseq + 1
      END IF
   ELSE
      LET l_nmcl.nmclseq = g_nmcl_d_t.nmclseq
   END IF
   
   SELECT glaald,glaa001 INTO l_glaald,l_glaa001
     FROM glaa_t 
    WHERE glaaent = g_enterprise 
      AND glaacomp = g_nmck_m.nmckcomp
      AND glaa014='Y'
   
   LET l_sql = "SELECT apebdocno,apebseq,apeborga,apeb108 ",
               "  FROM apea_t,apeb_t ",
               " WHERE apeaent = ",g_enterprise,
               "   AND apeaent = apebent ",
               "   AND apeadocno = apebdocno ",
               "   AND (",g_qryparam.return1,")"
   PREPARE anmt440_ins_pre FROM l_sql
   DECLARE anmt440_ins_cs CURSOR FOR anmt440_ins_pre   
   
   FOREACH anmt440_ins_cs INTO l_apebdocno,l_apebseq,l_apeborga,l_apeb108    

      LET l_nmcl.nmclent = g_enterprise
      LET l_nmcl.nmclcomp = g_nmck_m.nmckcomp
      LET l_nmcl.nmcldocno = g_nmck_m.nmckdocno
      LET l_nmcl.nmclorga = l_apeborga
      LET l_nmcl.nmcl001 = l_apebdocno
      LET l_nmcl.nmcl002 = l_apebseq
      LET l_nmcl.nmcl103 = l_apeb108
      LET l_nmcl.nmcl113 = l_nmcl.nmcl103 * g_nmck_m.nmck101
      CALL s_curr_round_ld('1',l_glaald,g_nmck_m.nmck100,l_nmcl.nmcl103,2) RETURNING g_sub_success,g_errno,l_nmcl.nmcl103
      CALL s_curr_round_ld('1',l_glaald,l_glaa001,l_nmcl.nmcl113,2) RETURNING g_sub_success,g_errno,l_nmcl.nmcl113
      
      #161128-00061#2---modify----begin----------
      #INSERT INTO nmcl_t VALUES(l_nmcl.*)
      INSERT INTO nmcl_t (nmclent,nmclcomp,nmcldocno,nmclseq,nmclorga,nmcl001,nmcl002,nmcl003,nmcl103,
                          nmcl113,nmcl121,nmcl123,nmcl131,nmcl133)
       VALUES(l_nmcl.nmclent,l_nmcl.nmclcomp,l_nmcl.nmcldocno,l_nmcl.nmclseq,l_nmcl.nmclorga,l_nmcl.nmcl001,l_nmcl.nmcl002,l_nmcl.nmcl003,l_nmcl.nmcl103,l_nmcl.nmcl113,
              l_nmcl.nmcl121,l_nmcl.nmcl123,l_nmcl.nmcl131,l_nmcl.nmcl133)
      #161128-00061#2---modify----end----------
      
      IF SQLCA.sqlcode THEN
         LET l_success = FALSE
      END IF
      
      SELECT MAX(nmclseq) INTO l_nmcl.nmclseq FROM nmcl_t
       WHERE nmclent = g_enterprise
         AND nmcldocno = g_nmck_m.nmckdocno
         AND nmclcomp = g_nmck_m.nmckcomp
      IF cl_null(l_nmcl.nmclseq) THEN
         LET l_nmcl.nmclseq = 1
      ELSE
         LET l_nmcl.nmclseq = l_nmcl.nmclseq + 1
      END IF
   END FOREACH 
   
   IF l_success = TRUE THEN
      CALL s_transaction_end('Y',0)
   ELSE
      CALL s_transaction_end('N',0)
   END IF
END FUNCTION

################################################################################
# Descriptions...: 保证金账户
# Memo...........:
# Usage..........: CALL anmt440_nmck044_desc()
# Date & Author..: 2016/06/19 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt440_nmck044_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_nmck_m.nmck044
   CALL ap_ref_array2(g_ref_fields,"SELECT nmaal003 FROM nmaal_t WHERE nmaalent='"||g_enterprise||"' AND nmaal001=(SELECT nmas001 FROM nmas_t WHERE nmasent ='"||g_enterprise||"' AND nmas002 = ? )  AND nmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_nmck_m.nmck044_desc = '', g_rtn_fields[1] , ''
   DISPLAY g_nmck_m.nmck044_desc TO nmck044_desc
END FUNCTION

################################################################################
# Descriptions...: 保证金来源账户
# Memo...........:
# Usage..........: CALL anmt440_nmck045_desc()
# Date & Author..: 2016/06/16 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt440_nmck045_desc()
   DEFINE l_nmas001      LIKE nmas_t.nmas001
     
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_nmck_m.nmck045
   CALL ap_ref_array2(g_ref_fields,"SELECT nmaal003 FROM nmaal_t WHERE nmaalent='"||g_enterprise||"' AND nmaal001= (SELECT nmas001 FROM nmas_t WHERE nmasent ='"||g_enterprise||"' AND nmas002 = ? ) AND nmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_nmck_m.nmck045_desc = '', g_rtn_fields[1] , ''
   DISPLAY g_nmck_m.nmck045_desc TO nmck045_desc
END FUNCTION

################################################################################
# Descriptions...: 存提码 
# Memo...........:
# Usage..........: CALL anmt440_nmck047_desc()
# Date & Author..: 2016/06/16 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt440_nmck047_desc()
   #存提碼
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_nmck_m.nmck047
   CALL ap_ref_array2(g_ref_fields,"SELECT nmajl003 FROM nmajl_t WHERE nmajlent='"||g_enterprise||"' AND nmajl001=? AND nmajl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_nmck_m.nmck047_desc = '', g_rtn_fields[1] , ''
   DISPLAY g_nmck_m.nmck047_desc TO nmck047_desc  
END FUNCTION

################################################################################
# Descriptions...: 存提码 
# Memo...........:
# Usage..........: CALL anmt440_nmck048_desc()
# Date & Author..: 2016/06/16 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt440_nmck048_desc()
   #存提碼
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_nmck_m.nmck048
   CALL ap_ref_array2(g_ref_fields,"SELECT nmajl003 FROM nmajl_t WHERE nmajlent='"||g_enterprise||"' AND nmajl001=? AND nmajl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_nmck_m.nmck048_desc = '', g_rtn_fields[1] , ''
   DISPLAY g_nmck_m.nmck048_desc TO nmck048_desc  
END FUNCTION

################################################################################
# Descriptions...: 现金变动码
# Memo...........:
# Usage..........: CALL anmt440_nmck049_desc()
# Date & Author..: 2016/06/16 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt440_nmck049_desc()
   #現金變動碼
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_glaa005
   LET g_ref_fields[2] = g_nmck_m.nmck049
   CALL ap_ref_array2(g_ref_fields,"SELECT nmail004 FROM nmail_t WHERE nmailent='"||g_enterprise||"' AND nmail001=? AND nmail002 =? AND nmail003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_nmck_m.nmck049_desc = '', g_rtn_fields[1] , ''
   DISPLAY g_nmck_m.nmck049_desc TO nmck049_desc
END FUNCTION

################################################################################
# Descriptions...: 现金变动码
# Memo...........:
# Usage..........: CALL anmt440_nmck050_desc()
# Date & Author..: 2016/06/16 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt440_nmck050_desc()
   #現金變動碼
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_glaa005
   LET g_ref_fields[2] = g_nmck_m.nmck050
   CALL ap_ref_array2(g_ref_fields,"SELECT nmail004 FROM nmail_t WHERE nmailent='"||g_enterprise||"' AND nmail001=? AND nmail002 =? AND nmail003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_nmck_m.nmck050_desc = '', g_rtn_fields[1] , ''
   DISPLAY g_nmck_m.nmck050_desc TO nmck050_desc
END FUNCTION
# 发票补登
#160326-00001#20 add lujh
PRIVATE FUNCTION anmt440_invoice()
   DEFINE l_cnt                 LIKE type_t.num10
   DEFINE l_nmaf006             LIKE nmaf_t.nmaf006
   DEFINE l_nmaf007             LIKE nmaf_t.nmaf007
   DEFINE l_nmaf009             LIKE nmaf_t.nmaf009
   DEFINE l_nmaf010             LIKE nmaf_t.nmaf010
   DEFINE l_today               DATETIME YEAR TO SECOND
   DEFINE l_nmck025_1           STRING
   DEFINE l_nmaf007_str         STRING
   DEFINE l_nmaf010_str         STRING
   DEFINE l_nmaf007_str2        STRING
   DEFINE l_nmaf010_str2        STRING
   DEFINE l_nmck025_str2        STRING
   DEFINE l_num                 LIKE type_t.num5
   DEFINE l_str                 STRING
   DEFINE l_str_new             LIKE nmaf_t.nmaf010
   
   CALL s_transaction_begin()
   
   LET l_today = cl_get_current() 
   
   INPUT BY NAME g_nmck_m.nmck024,g_nmck_m.nmck025 ATTRIBUTE(WITHOUT DEFAULTS)
      BEFORE INPUT
      
      AFTER FIELD nmck024
         IF NOT cl_null(g_nmck_m.nmck024) THEN
            CALL anmt440_nmck024_chk(g_nmck_m.nmck024)
            IF NOT cl_null(g_errno) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = g_errno
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
    
               LET g_nmck_m.nmck024=g_nmck_m_t.nmck024
               NEXT FIELD nmck024
            END IF
            #检核是否存在重复票据号码
            SELECT COUNT(1) INTO l_cnt FROM nmck_t
             WHERE nmckent=g_enterprise AND nmck004=g_nmck_m.nmck004
               AND nmck002=g_nmck_m.nmck002 AND nmck025=g_nmck_m.nmck025
               AND nmckdocno <> g_nmck_m.nmckdocno
            IF l_cnt>0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'anm-00157'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               NEXT FIELD nmck025
            END IF
         ELSE
            CALL cl_set_comp_required("nmck025",FALSE)
         END IF
         
         
      AFTER FIELD nmck025   
         IF NOT cl_null(g_nmck_m.nmck025) THEN
            IF g_nmck_m.nmck025 <> g_nmck_m_t.nmck025 OR cl_null(g_nmck_m_t.nmck025) THEN
               CALL anmt440_nmck025_chk()
               IF NOT cl_null(g_errno) THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
               
                  LET g_nmck_m.nmck025 = g_nmck_m_t.nmck025
                  NEXT FIELD nmck025
               END IF
               
               SELECT COUNT(*) INTO l_cnt FROM nmck_t
                WHERE nmckent=g_enterprise AND nmck004=g_nmck_m.nmck004
                  AND nmck002=g_nmck_m.nmck002 AND nmck025=g_nmck_m.nmck025
                  AND nmckdocno <> g_nmck_m.nmckdocno
               IF l_cnt>0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'anm-00157'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
               
                  LET g_nmck_m.nmck025=g_nmck_m_t.nmck025
                  NEXT FIELD nmck025
               END IF
               LET l_cnt = 0
               SELECT COUNT(*) INTO l_cnt FROM nmcd_t
                WHERE nmcdent = g_enterprise 
                  AND nmcd002 = g_nmck_m.nmck024
                  AND nmcd003 = g_nmck_m.nmck025
                  AND nmcd008 = 'Y' 
               IF l_cnt > 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'anm-02972'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()                  
                  LET g_nmck_m.nmck025=g_nmck_m_t.nmck025
                  NEXT FIELD nmck025
               END IF                                 
            END IF
         END IF   
         
      ON ACTION controlp INFIELD nmck024
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'i'
         LET g_qryparam.reqry = FALSE
         LET g_qryparam.default1 = g_nmck_m.nmck024             #給予default值
         LET g_qryparam.arg1 = g_nmck_m.nmck004 
         LET g_qryparam.arg2 = g_nmck_m.nmck002 
         LET g_qryparam.where = " nmaf011 = 'N' "
         CALL q_nmaf004()                                #呼叫開窗
    
         LET g_nmck_m.nmck024 = g_qryparam.return1              
    
         DISPLAY g_nmck_m.nmck024 TO nmck024             
    
         NEXT FIELD nmck024     
   
      AFTER INPUT
         UPDATE nmck_t SET nmck024   = g_nmck_m.nmck024,
                           nmck025   = g_nmck_m.nmck025,
                           nmckmodid = g_user,
                           nmckmoddt = l_today
          WHERE nmckent   = g_enterprise 
            AND nmckcomp  = g_nmck_m.nmckcomp 
            AND nmckdocno = g_nmck_m.nmckdocno
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = ''
            LET g_errparam.popup = FALSE
            CALL cl_err()
         
            CALL s_transaction_end('N','0')
         END IF
    
         #抓取 支票截止號碼/流水號長度/下次列印號碼
         SELECT nmaf007,nmaf009,nmaf010 INTO l_nmaf007,l_nmaf009,l_nmaf010
           FROM nmaf_t
          WHERE nmafent = g_enterprise
            AND nmaf001 = g_nmck_m.nmck004 #交易帳戶編碼
            AND nmaf002 = g_nmck_m.nmck002 #票據類型
            AND nmaf004 = g_nmck_m.nmck024 #支票簿號
          
         #擷取號碼
         LET l_nmaf007_str = l_nmaf007
         LET l_nmaf010_str = l_nmaf010
         LET l_nmck025_1 = g_nmck_m.nmck025
         LET l_nmaf007_str2 = l_nmaf007_str.subString(l_nmaf007_str.getLength()-l_nmaf009+1,l_nmaf007_str.getLength())
         LET l_nmaf010_str2 = l_nmaf010_str.subString(l_nmaf010_str.getLength()-l_nmaf009+1,l_nmaf010_str.getLength())
         LET l_nmck025_str2 = l_nmck025_1.subString(l_nmck025_1.getLength()-l_nmaf009+1,l_nmck025_1.getLength())
         
         #擷取
         IF l_nmaf010_str2 < (l_nmck025_str2+1) AND (l_nmck025_str2+1) < l_nmaf007_str2 THEN
            #擷取票據文字
            LET l_str = l_nmaf007_str.subString(1,l_nmaf007_str.getLength()-l_nmaf009)
            
            #合併新的下次列印號碼
            LET l_num = l_nmck025_str2
            LET l_num = l_num + 1
            LET l_nmck025_str2 = l_num
            CASE
               WHEN l_nmaf009 = 1
                  LET l_nmck025_str2 = l_nmck025_str2 USING "&"
               WHEN l_nmaf009 = 2
                  LET l_nmck025_str2 = l_nmck025_str2 USING "&&"
               WHEN l_nmaf009 = 3
                  LET l_nmck025_str2 = l_nmck025_str2 USING "&&&"
               WHEN l_nmaf009 = 4
                  LET l_nmck025_str2 = l_nmck025_str2 USING "&&&&"
               WHEN l_nmaf009 = 5
                  LET l_nmck025_str2 = l_nmck025_str2 USING "&&&&&"
               WHEN l_nmaf009 = 6
                  LET l_nmck025_str2 = l_nmck025_str2 USING "&&&&&&"
               WHEN l_nmaf009 = 7
                  LET l_nmck025_str2 = l_nmck025_str2 USING "&&&&&&&"
               WHEN l_nmaf009 = 8
                  LET l_nmck025_str2 = l_nmck025_str2 USING "&&&&&&&&"
               WHEN l_nmaf009 = 9
                  LET l_nmck025_str2 = l_nmck025_str2 USING "&&&&&&&&&"
               WHEN l_nmaf009 = 10
                  LET l_nmck025_str2 = l_nmck025_str2 USING "&&&&&&&&&&"
            END CASE
            LET l_str_new = l_str,l_nmck025_str2
            
            UPDATE nmaf_t SET nmaf010 = l_str_new
             WHERE nmafent = g_enterprise
               AND nmaf001 = g_nmck_m.nmck004 #交易帳戶編碼
               AND nmaf002 = g_nmck_m.nmck002 #票據類型
               AND nmaf004 = g_nmck_m.nmck024 #支票簿號
               
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()
            
               CALL s_transaction_end('N','0')
            END IF
         END IF
         
         ON ACTION accept
            ACCEPT INPUT
           
         ON ACTION cancel      #在dialog button (放棄)
            LET g_action_choice=""
            LET INT_FLAG = TRUE 
            EXIT INPUT
         
         ON ACTION close       #在dialog 右上角 (X)
            LET INT_FLAG = TRUE 
            EXIT INPUT
         
         ON ACTION exit        #toolbar 離開
            LET INT_FLAG = TRUE 
            EXIT INPUT
     
         
         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE INPUT
   END INPUT
      
      
   
   CALL s_transaction_end('Y','1')
END FUNCTION
# 票据号码检查
PRIVATE FUNCTION anmt440_nmck025_chk()
   DEFINE  l_nmaf006_t           LIKE nmaf_t.nmaf006
   DEFINE  l_nmaf007_t           LIKE nmaf_t.nmaf007
   DEFINE  l_nmaf009_t           LIKE nmaf_t.nmaf009
   DEFINE  l_nmaf006             STRING
   DEFINE  l_nmaf007             STRING
   DEFINE  l_nmaf010             STRING
   DEFINE  l_nmaf006_str         STRING
   DEFINE  l_nmaf007_str         STRING
   DEFINE  l_nmaf010_str         STRING
   DEFINE  l_same_nmaf006        LIKE type_t.chr100 
   DEFINE  l_same_nmaf010        LIKE type_t.chr100 
   
   LET g_errno = ''
   
   SELECT nmaf006,nmaf007,nmaf009 
     INTO l_nmaf006_t,l_nmaf007_t,l_nmaf009_t 
    FROM nmaf_t
    WHERE nmafent = g_enterprise 
      AND nmaf001 = g_nmck_m.nmck004 
      AND nmaf002 = g_nmck_m.nmck002 
      AND nmaf004 = g_nmck_m.nmck024 
   
   LET l_nmaf010 = g_nmck_m.nmck025
   LET l_nmaf006 = l_nmaf006_t
   LET l_nmaf007 = l_nmaf007_t
   
   LET l_nmaf006_str = l_nmaf006.substring(l_nmaf006.getLength()-l_nmaf009_t+1,l_nmaf006.getLength())
   LET l_nmaf007_str = l_nmaf007.substring(l_nmaf007.getLength()-l_nmaf009_t+1,l_nmaf007.getLength())
   LET l_nmaf010_str = l_nmaf010.substring(l_nmaf010.getLength()-l_nmaf009_t+1,l_nmaf010.getLength())
   
   LET l_same_nmaf006 = l_nmaf006.substring(1,l_nmaf006.getLength()-l_nmaf009_t)
   LET l_same_nmaf010 = l_nmaf010.substring(1,l_nmaf010.getLength()-l_nmaf009_t)
   
   IF l_nmaf010.getLength() <> l_nmaf006.getLength() THEN 
      LET g_errno = 'anm-03023'
      RETURN
   END IF 
   
   IF l_same_nmaf006 <> l_same_nmaf010 THEN 
      LET g_errno = 'anm-03024'
      RETURN 
   END IF
   
   IF cl_null(l_nmaf010_str - l_nmaf006_str) THEN 
      LET g_errno = 'anm-00098'
      RETURN 
   END IF
   
   IF l_nmaf010_str > l_nmaf007_str OR l_nmaf010_str < l_nmaf006_str THEN
      LET g_errno = 'anm-00153'
      RETURN         
   END IF
   
END FUNCTION

################################################################################
# Descriptions...: 支票作廢
# Memo...........: #170118-00039#1
# Usage..........: CALL anmt440_inv_invalid()
# Date & Author..: 170118 By 06821
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt440_inv_invalid()
DEFINE l_cnt         LIKE type_t.num10
DEFINE l_date        LIKE nmcd_t.nmcdmoddt
DEFINE l_success     LIKE type_t.num10
#170118-00039#2 --s add
DEFINE l_nmcd004      LIKE nmcd_t.nmcd004    
DEFINE l_nmcd004_ud   LIKE nmcd_t.nmcd004    
DEFINE l_nmcd004_desc LIKE type_t.chr100
#170118-00039#2 --e add

   LET l_success = TRUE
   LET l_date = cl_get_current()
   
   IF NOT cl_ask_confirm("aim-00109") THEN
      RETURN
   END IF    

   #170118-00039#2 --s add
   #作廢理由碼
   OPEN WINDOW w_anmt440_s01 WITH FORM cl_ap_formpath("anm",'anmt440_s01')
    
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      INPUT l_nmcd004,l_nmcd004_desc FROM nmcd004,nmcd004_desc ATTRIBUTE(WITHOUT DEFAULTS)
      
         BEFORE INPUT
            LET l_nmcd004_ud = ''
         
         AFTER FIELD nmcd004
            IF NOT cl_null(l_nmcd004) THEN 
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = l_nmcd004
               IF cl_chk_exist("v_oocq002_3303") THEN
               ELSE
                  #檢查失敗時後續處理
                  LET l_nmcd004 = ''
                  LET l_nmcd004_desc = s_desc_get_acc_desc('3303',l_nmcd004)
                  DISPLAY l_nmcd004 TO nmcd004                           
                  DISPLAY l_nmcd004_desc TO nmcd004_desc                  
                  NEXT FIELD nmcd004
               END IF
            END IF          
            
         ON ACTION controlp INFIELD nmcd004         
            #開窗i段
		   	INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		   	LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '3303'
            CALL q_oocq002()                                           #呼叫開窗
            LET l_nmcd004 = g_qryparam.return1 
            LET l_nmcd004_desc = s_desc_get_acc_desc('3303',l_nmcd004)
            DISPLAY l_nmcd004 TO nmcd004                               #顯示到畫面上
            DISPLAY l_nmcd004_desc TO nmcd004_desc                     #顯示到畫面上
            NEXT FIELD nmcd004                                         #返回原欄位
         
         AFTER INPUT
            LET l_nmcd004_ud = l_nmcd004
            
      END INPUT
   

      ON ACTION accept
         ACCEPT DIALOG
         
      ON ACTION cancel
         LET l_success = FALSE
         EXIT DIALOG

   END DIALOG
   CLOSE WINDOW w_anmt440_s01   
   
   IF NOT l_success THEN RETURN END IF
   IF cl_null(l_nmcd004_ud) THEN RETURN END IF
   #170118-00039#2 --e add

   #  票況狀態不存在4 5 7類
   LET l_cnt = 0
   SELECT COUNT(nmckdocno) INTO l_cnt 
     FROM nmck_t
    WHERE nmckent = g_enterprise AND nmckcomp = g_nmck_m.nmckcomp AND nmckdocno = g_nmck_m.nmckdocno   
      AND nmck026 IN ('4','5','7')
   IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
   IF l_cnt > 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'anm-03048'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET l_success = FALSE
      RETURN      
   END IF

   CALL s_transaction_begin()
   #檢核: 
   #  (1)簿號nmck024是否存在nmcd002支票明細檔簿號,無:直接清空nmck025;有:update nmcd
   LET l_cnt = 0
   SELECT COUNT(nmcd002) INTO l_cnt FROM nmcd_t
    WHERE nmcdent = g_enterprise AND nmcd003 = g_nmck_m.nmck025 
   IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
   IF l_cnt = 0 THEN
   #(直接清空nmck025,不用報錯)-----
      UPDATE nmck_t  
         SET nmck025 = '',nmckmodid = g_user,nmckmoddt = l_date,
             nmckcnfid = g_user,nmckcnfdt = l_date
       WHERE nmckent = g_enterprise AND nmckcomp = g_nmck_m.nmckcomp AND nmckdocno = g_nmck_m.nmckdocno    
   ELSE
   #(檢查符合條件則update nmcd)----
   #  (2)付款來源<>'AP' 且 不存在aapt420中
      LET l_cnt = 0
      SELECT COUNT(nmckdocno) INTO l_cnt 
        FROM nmck_t
       WHERE nmckent = g_enterprise AND nmckcomp = g_nmck_m.nmckcomp AND nmckdocno = g_nmck_m.nmckdocno
         AND (nmck001 <> 'AP' AND EXISTS (SELECT 1 FROM apda_t,apde_t 
                                          WHERE apdaent = g_enterprise AND apdeent = apdaent AND apdeld = apdald 
                                            AND apdedocno = apdadocno  AND apdastus <> 'X' AND apde003 = nmckdocno ))
      IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
      IF l_cnt > 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'anm-03046'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET l_success = FALSE 
      ELSE
   #  (3)不存在異動作業anmt450   
         LET l_cnt = 0
         SELECT COUNT(nmckdocno) INTO l_cnt 
           FROM nmck_t
          WHERE nmckent = g_enterprise AND nmckcomp = g_nmck_m.nmckcomp AND nmckdocno = g_nmck_m.nmckdocno   
            AND EXISTS (SELECT 1 FROM nmch_t,nmci_t 
                         WHERE nmchent = g_enterprise AND nmchent = nmcient AND nmchcomp = nmcicomp
                           AND nmchdocno = nmcidocno  AND nmchstus <> 'X' AND nmci003 = nmckdocno)
         IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
         IF l_cnt > 0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'anm-03047'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET l_success = FALSE 
         END IF  
      END IF  
      
      #更新nmcd_t
      UPDATE nmcd_t SET nmcd008 = 'Y',nmcd005 = g_user,
                        nmcdmodid = g_user,nmcdmoddt = l_date,
                        nmcd004 = l_nmcd004_ud  #170118-00039#2 add
       WHERE nmcdent = g_enterprise AND nmcd002 = g_nmck_m.nmck024
         AND nmcd003 = g_nmck_m.nmck025
         
      #更新nmck_t
      UPDATE nmck_t  
         SET nmck025 = '',nmckmodid = g_user,nmckmoddt = l_date,
             nmckcnfid = g_user,nmckcnfdt = l_date
       WHERE nmckent = g_enterprise AND nmckcomp = g_nmck_m.nmckcomp AND nmckdocno = g_nmck_m.nmckdocno      
       
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err() 
         LET l_success = FALSE          
      END IF       
   END IF


   IF l_success THEN      
      CALL s_transaction_end('Y','0')  #執行成功
   ELSE   
      CALL s_transaction_end('N','0')  #執行失敗
   END IF         
   
END FUNCTION

 
{</section>}
 
