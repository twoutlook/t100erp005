#該程式未解開Section, 採用最新樣板產出!
{<section id="afat507.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0028(2016-11-18 16:46:25), PR版次:0028(2017-01-04 10:00:23)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000380
#+ Filename...: afat507
#+ Description: 資產報廢維護作業
#+ Creator....: ()
#+ Modifier...: 07900 -SD/PR- 06821
 
{</section>}
 
{<section id="afat507.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#151022-00001#1     2015/10/22 BY yangtt      新增列印功能
#151125-00001#1     2015/11/27 BY fionchen    執行[作廢]作業時,增加詢問「是否執行作廢？」
#150916-00015#1     2015/12/7  BY Xiaozg      1.快捷带出类似科目编号 2.当有账套时，科目检查改为检查是否存在于glad_t中
#151210-00006#1     2015/12/10 BY yangtt      单据作业动态设定打印报表元件
#151125-00006#3     2015/12/16 BY 07166       添加自动审核和自动抛转凭证功能
#151130-00015#2     2015/12/21 BY taozf       判断 是否可以更改單據日期 設定開放單據日期修改
#160304-00002#1     2016/03/04 BY lujh        处置数量栏位带的成本累折未折减额的计算错了,成本=（成本-处置成本）*（单身处置数量/l_c）  检核不可<0
#160318-00005#11    2016/03/25 BY 07675       將重複內容的錯誤訊息置換為公用錯誤訊息
#160405-00007#1     2016/04/05 BY 02599       增加建立临时表
#160331-00003#2     2016/04/11 BY 07673       作业的过帐还原未更新afai100处置本年累折栏位
#160318-00025#5     2016/04/14 BY 07675       將重複內容的錯誤訊息置換為公用錯誤訊息(r.v）
#160414-00015#1     2016/04/25 BY 07673       复制时清空特定栏位
#160108-00008#1     2016/05/03 BY 01531       新增時，單據日期未正確卡控(若未點擊日期欄位)。未在當前期別也可新建成功。
#141208-00022#1     2016/05/11 BY 01531       BMP簽核流程调整
#160616-00005#3     2016/06/21 BY 01531       #141208-00022#1BUG修复
#160727-00019#2     2016/08/01 BY 08742       系统中定义的临时表名称超过15码在执行时会出错,所以需要将系统中定义的临时表长度超过15码的全部改掉	 	
#                                             MOD   afap280_01_fa_tmp -->afap280_tmp01
#                                             MOD   afap280_01_group -->afap280_tmp02
#160125-00005#7     2016/08/09 BY 02599       查詢時加上帳套人員權限條件過濾
#160426-00014#33    2016/08/17 BY 02114       修改权限的问题
#160812-00017#6     2016/08/22 By 06814       在satatchange( )的FUNCTION中，有RETURN指令但沒有加上transaction_end( ) 
#                                             造成transaction沒有結束就直接RETURN
#160818-00017#10    2016/08/25 By 07900       删除修改未重新判断状态码
#160426-00014#23    2016/09/12 By 07900       固定资产的t作业的单身都增加名称与规格二个栏位，取值来源为afai100的faah012,faah013,各单身表栏位直接按现有表依序增加
#160905-00037#1     2016/09/19 By 01531       fabh015没有给值（为0），请按照规格的写法正确赋值。
#161024-00008#4     2016/10/27 By Hans        AFA組織類型與職能開窗清單調整。
#161115-00003#1     2016/11/18 By 07900       增加显示保管人员，保管部门
#161111-00049#13    2016/11/23 By 07900      【卡片編號、財產編號、附號：基礎資料類查詢，增加USER據點權限與資產設備的【歸屬法人】，作交互限定可視範圍。
#160824-00007#248   2016/12/08 by lori        修正舊值備份寫法
#161215-00044#1     2016/12/16 by 02481       标准程式定义采用宣告模式,弃用.*写
#161104-00046#16    2017/01/04 By 06821       單別預設值;資料依照單別user dept權限過濾單號
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"
IMPORT FGL afa_afat503_01  #科目與核算項
#end add-point 
 
SCHEMA ds 
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
#單頭 type 宣告
PRIVATE type type_g_fabg_m        RECORD
       fabgsite LIKE fabg_t.fabgsite, 
   fabgsite_desc LIKE type_t.chr80, 
   fabg002 LIKE fabg_t.fabg002, 
   fabg002_desc LIKE type_t.chr80, 
   fabg001 LIKE fabg_t.fabg001, 
   fabg001_desc LIKE type_t.chr80, 
   fabg003 LIKE fabg_t.fabg003, 
   fabg003_desc LIKE type_t.chr80, 
   fabgld LIKE fabg_t.fabgld, 
   fabgld_desc LIKE type_t.chr80, 
   fabg004 LIKE fabg_t.fabg004, 
   fabg005 LIKE fabg_t.fabg005, 
   fabg008 LIKE fabg_t.fabg008, 
   fabgdocno LIKE fabg_t.fabgdocno, 
   fabg009 LIKE fabg_t.fabg009, 
   fabgdocdt LIKE fabg_t.fabgdocdt, 
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
   fabgcnfdt LIKE fabg_t.fabgcnfdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_fabh_d        RECORD
       fabhseq LIKE fabh_t.fabhseq, 
   fabh001 LIKE fabh_t.fabh001, 
   fabh002 LIKE fabh_t.fabh002, 
   fabh000 LIKE fabh_t.fabh000, 
   faah012 LIKE type_t.chr500, 
   faah013 LIKE type_t.chr500, 
   fabh005 LIKE fabh_t.fabh005, 
   fabh006 LIKE fabh_t.fabh006, 
   faah025 LIKE type_t.chr500, 
   faah026 LIKE type_t.chr500, 
   fabh007 LIKE fabh_t.fabh007, 
   fabh015 LIKE fabh_t.fabh015, 
   fabh008 LIKE fabh_t.fabh008, 
   fabh011 LIKE fabh_t.fabh011, 
   fabh004 LIKE fabh_t.fabh004, 
   fabh017 LIKE fabh_t.fabh017, 
   fabh073 LIKE fabh_t.fabh073, 
   fabh020 LIKE fabh_t.fabh020, 
   fabh020_desc LIKE type_t.chr500, 
   fabh003 LIKE fabh_t.fabh003, 
   fabh023 LIKE fabh_t.fabh023, 
   fabh024 LIKE fabh_t.fabh024, 
   fabh025 LIKE fabh_t.fabh025
       END RECORD
PRIVATE TYPE type_g_fabh3_d RECORD
       fabhseq LIKE fabh_t.fabhseq, 
   fabh100 LIKE fabh_t.fabh100, 
   fabh101 LIKE fabh_t.fabh101, 
   fabh102 LIKE fabh_t.fabh102, 
   fabh104 LIKE fabh_t.fabh104, 
   fabh108 LIKE fabh_t.fabh108, 
   fabh109 LIKE fabh_t.fabh109, 
   fabh111 LIKE fabh_t.fabh111, 
   fabh150 LIKE fabh_t.fabh150, 
   fabh151 LIKE fabh_t.fabh151, 
   fabh152 LIKE fabh_t.fabh152, 
   fabh154 LIKE fabh_t.fabh154, 
   fabh158 LIKE fabh_t.fabh158, 
   fabh159 LIKE fabh_t.fabh159, 
   fabh161 LIKE fabh_t.fabh161
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_fabgld LIKE fabg_t.fabgld,
      b_fabgdocno LIKE fabg_t.fabgdocno
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
GLOBALS
   DEFINE p_prog             LIKE type_t.chr20
   DEFINE g_wc_subject       STRING
   DEFINE g_wc_d             STRING
   DEFINE g_fabgld           LIKE fabg_t.fabgld
   DEFINE g_fabgdocno        LIKE fabg_t.fabgdocno
   DEFINE g_fabhseq          LIKE fabh_t.fabhseq
   DEFINE g_fabgld_o         LIKE fabg_t.fabgld
   DEFINE g_fabgdocno_o      LIKE fabg_t.fabgdocno
   DEFINE g_fabhseq_o        LIKE fabh_t.fabhseq
   DEFINE g_detail_insert    LIKE type_t.num5   #單身的新增權限
   DEFINE g_detail_delete    LIKE type_t.num5   #單身的刪除權限
   TYPE type_g_fabh_d3        RECORD
   fabhseq LIKE fabh_t.fabhseq, 
   fabh021 LIKE fabh_t.fabh021, 
   fabh021_desc LIKE type_t.chr500, 
   fabh022 LIKE fabh_t.fabh022, 
   fabh022_desc LIKE type_t.chr500, 
   fabh036 LIKE fabh_t.fabh036, 
   fabh026 LIKE fabh_t.fabh026, 
   fabh026_desc LIKE type_t.chr500, 
   fabh027 LIKE fabh_t.fabh027, 
   fabh027_desc LIKE type_t.chr500, 
   fabh028 LIKE fabh_t.fabh028, 
   fabh028_desc LIKE type_t.chr500, 
   fabh029 LIKE fabh_t.fabh029, 
   fabh029_desc LIKE type_t.chr500, 
   fabh030 LIKE fabh_t.fabh030, 
   fabh030_desc LIKE type_t.chr500, 
   fabh031 LIKE fabh_t.fabh031, 
   fabh031_desc LIKE type_t.chr500, 
   fabh032 LIKE fabh_t.fabh032, 
   fabh032_desc LIKE type_t.chr500, 
   fabh033 LIKE fabh_t.fabh033, 
   fabh033_desc LIKE type_t.chr500, 
   fabh034 LIKE fabh_t.fabh034, 
   fabh034_desc LIKE type_t.chr500, 
   fabh035 LIKE fabh_t.fabh035, 
   fabh035_desc LIKE type_t.chr500, 
   fabh041 LIKE fabh_t.fabh041, 
   fabh042 LIKE fabh_t.fabh042, 
   fabh042_desc LIKE type_t.chr500, 
   fabh043 LIKE fabh_t.fabh043, 
   fabh043_desc LIKE type_t.chr500, 
   fabh060 LIKE fabh_t.fabh060, 
   fabh060_desc LIKE type_t.chr500, 
   fabh061 LIKE fabh_t.fabh061, 
   fabh061_desc LIKE type_t.chr500, 
   fabh062 LIKE fabh_t.fabh062, 
   fabh062_desc LIKE type_t.chr500, 
   fabh063 LIKE fabh_t.fabh063, 
   fabh063_desc LIKE type_t.chr500, 
   fabh064 LIKE fabh_t.fabh064, 
   fabh064_desc LIKE type_t.chr500, 
   fabh065 LIKE fabh_t.fabh065, 
   fabh065_desc LIKE type_t.chr500, 
   fabh066 LIKE fabh_t.fabh066, 
   fabh066_desc LIKE type_t.chr500, 
   fabh067 LIKE fabh_t.fabh067, 
   fabh067_desc LIKE type_t.chr500, 
   fabh068 LIKE fabh_t.fabh068, 
   fabh068_desc LIKE type_t.chr500, 
   fabh069 LIKE fabh_t.fabh069, 
   fabh069_desc LIKE type_t.chr500
   END RECORD
   DEFINE g_fabh_d2          DYNAMIC ARRAY OF type_g_fabh_d3      
END GLOBALS
DEFINE g_detail_id           STRING             #紀錄當前提留在那個單身Page上
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
DEFINE g_bookno              LIKE glaa_t.glaald
DEFINE g_wc_cs_ld            STRING                #160125-00005#7
DEFINE g_site_str            STRING                #160125-00005#7
#161104-00046#16 --s add
DEFINE g_user_dept_wc        STRING     
DEFINE g_user_dept_wc_q      STRING     
DEFINE g_user_slip_wc        STRING  
DEFINE g_ap_slip             LIKE ooba_t.ooba002
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
 
 
DEFINE g_fabh_d          DYNAMIC ARRAY OF type_g_fabh_d
DEFINE g_fabh_d_t        type_g_fabh_d
DEFINE g_fabh_d_o        type_g_fabh_d
DEFINE g_fabh_d_mask_o   DYNAMIC ARRAY OF type_g_fabh_d #轉換遮罩前資料
DEFINE g_fabh_d_mask_n   DYNAMIC ARRAY OF type_g_fabh_d #轉換遮罩後資料
DEFINE g_fabh3_d          DYNAMIC ARRAY OF type_g_fabh3_d
DEFINE g_fabh3_d_t        type_g_fabh3_d
DEFINE g_fabh3_d_o        type_g_fabh3_d
DEFINE g_fabh3_d_mask_o   DYNAMIC ARRAY OF type_g_fabh3_d #轉換遮罩前資料
DEFINE g_fabh3_d_mask_n   DYNAMIC ARRAY OF type_g_fabh3_d #轉換遮罩後資料
 
 
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
 
{<section id="afat507.main" >}
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
   LET g_forupd_sql = " SELECT fabgsite,'',fabg002,'',fabg001,'',fabg003,'',fabgld,'',fabg004,fabg005, 
       fabg008,fabgdocno,fabg009,fabgdocdt,fabgstus,fabgownid,'',fabgowndp,'',fabgcrtid,'',fabgcrtdp, 
       '',fabgcrtdt,fabgmodid,'',fabgmoddt,fabgcnfid,'',fabgcnfdt", 
                      " FROM fabg_t",
                      " WHERE fabgent= ? AND fabgld=? AND fabgdocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE afat507_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.fabgsite,t0.fabg002,t0.fabg001,t0.fabg003,t0.fabgld,t0.fabg004,t0.fabg005, 
       t0.fabg008,t0.fabgdocno,t0.fabg009,t0.fabgdocdt,t0.fabgstus,t0.fabgownid,t0.fabgowndp,t0.fabgcrtid, 
       t0.fabgcrtdp,t0.fabgcrtdt,t0.fabgmodid,t0.fabgmoddt,t0.fabgcnfid,t0.fabgcnfdt,t1.ooefl003 ,t2.ooag011 , 
       t3.ooag011 ,t4.ooefl003 ,t5.glaal002 ,t6.ooag011 ,t7.ooefl003 ,t8.ooag011 ,t9.ooefl003 ,t10.ooag011 , 
       t11.ooag011",
               " FROM fabg_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.fabgsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.fabg002  ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.fabg001  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.fabg003 AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN glaal_t t5 ON t5.glaalent="||g_enterprise||" AND t5.glaalld=t0.fabgld AND t5.glaal001='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.fabgownid  ",
               " LEFT JOIN ooefl_t t7 ON t7.ooeflent="||g_enterprise||" AND t7.ooefl001=t0.fabgowndp AND t7.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=t0.fabgcrtid  ",
               " LEFT JOIN ooefl_t t9 ON t9.ooeflent="||g_enterprise||" AND t9.ooefl001=t0.fabgcrtdp AND t9.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t10 ON t10.ooagent="||g_enterprise||" AND t10.ooag001=t0.fabgmodid  ",
               " LEFT JOIN ooag_t t11 ON t11.ooagent="||g_enterprise||" AND t11.ooag001=t0.fabgcnfid  ",
 
               " WHERE t0.fabgent = " ||g_enterprise|| " AND t0.fabgld = ? AND t0.fabgdocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE afat507_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_afat507 WITH FORM cl_ap_formpath("afa",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL afat507_init()   
 
      #進入選單 Menu (="N")
      CALL afat507_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_afat507
      
   END IF 
   
   CLOSE afat507_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   #DROP TABLE afap280_01_fa_tmp #160405-00007#1 add #160727-00019#2 mark
   #DROP TABLE afap280_01_group  #160405-00007#1 add #160727-00019#2 mark
   DROP TABLE afap280_tmp01  #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01
   DROP TABLE afap280_tmp02  #160727-00019#2 Mod   afap280_01_group -->afap280_tmp02
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="afat507.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION afat507_init()
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
 
   LET g_error_show  = 1
   LET l_ac = 1 #單身指標
      CALL cl_set_combo_scc_part('fabgstus','13','A,D,N,R,W,Y,Z,S,X')
 
      CALL cl_set_combo_scc('fabg005','9910') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1','2',","1")
   CALL g_idx_group.addAttribute("","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc_part('fabg005','9910','21')
   #子程式畫面取代主程式元件
   CALL cl_ui_replace_sub_window(cl_ap_formpath("afa", "afat503_01"), "grid_subject", "Table", "s_detail1_afat503_01")
   LET p_prog=g_prog
   
   #CALL cl_set_combo_scc('fabg005','9910')   #20150525 mark lujh
   CALL cl_set_comp_entry("fabg005",FALSE)
   LET g_fabg_m.fabg005 = '21'
   
   CALL cl_set_comp_entry("fabg008,fabg009",FALSE)
   
   #單身單位、數量
   CALL cl_set_comp_entry("fabh005,fabh006",FALSE)
   #單身成本、累折、未折減額、已提列減值準備
   CALL cl_set_comp_entry("fabh008,fabh011,fabh004,fabh017",FALSE)
    
    
   CALL afat507_default()
   CALL afap280_01_cre_fa_tmp_table() RETURNING l_success #160405-00007#1 add
   CALL s_fin_create_account_center_tmp()
   #end add-point
   
   #初始化搜尋條件
   CALL afat507_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="afat507.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION afat507_ui_dialog()
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
   DEFINE l_success  LIKE type_t.num5
   DEFINE l_ooba002  LIKE ooba_t.ooba002
   DEFINE l_str1     LIKE type_t.chr1
   DEFINE l_slip     LIKE type_t.chr20
   DEFINE l_ooac004  LIKE ooac_t.ooac004   
   DEFINE l_wc       STRING    #151022-00001#1
   DEFINE l_cn       LIKE type_t.num5   #151125-00006#3   
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
            CALL afat507_insert()
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
         CALL g_fabh_d.clear()
         CALL g_fabh3_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL afat507_init()
      END IF
   
            
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
    
         DISPLAY ARRAY g_fabh_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL afat507_idx_chk()
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
               CALL afat507_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_fabi
            LET g_action_choice="open_fabi"
            IF cl_auth_chk_act("open_fabi") THEN
               
               #add-point:ON ACTION open_fabi name="menu.detail_show.page1.open_fabi"
               CALL afat440_01('',g_fabh_d[l_ac].fabhseq,g_fabh_d[l_ac].fabh001,g_fabh_d[l_ac].fabh002,g_fabh_d[l_ac].fabh000,g_fabg_m.fabg005,g_fabg_m.fabgdocno,'')
               #END add-point
               
            END IF
 
 
 
 
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
         #第一階單身段落
         DISPLAY ARRAY g_fabh3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL afat507_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[2] = l_ac
               CALL g_idx_group.addAttribute("",l_ac)
               
               #add-point:page2, before row動作 name="ui_dialog.body3.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue(""))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_current_page = 2
               #顯示單身筆數
               CALL afat507_idx_chk()
               #add-point:page2自定義行為 name="ui_dialog.body3.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
         
            #add-point:page2自定義行為 name="ui_dialog.body3.action"
 
            #end add-point
         
         END DISPLAY
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         SUBDIALOG afa_afat503_01.afat503_01_display
         #end add-point
         
      
         BEFORE DIALOG
            #先填充browser資料
            CALL afat507_browser_fill("")
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
               CALL afat507_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL afat507_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL afat507_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            IF g_current_page = 1 THEN
               NEXT FIELD fabhseq
            END IF
            
            ON ACTION detail_page
               LET g_detail_id = "detail_page"
               NEXT FIELD fabhseq
            ON ACTION subject_page
               LET g_detail_id = "subject_page"
               LET g_fabgld=g_fabg_m.fabgld
               LET g_fabgdocno=g_fabg_m.fabgdocno
               CALL afat503_01_b_fill()
               NEXT FIELD fabh021
            ON ACTION curr_page
               LET g_detail_id = "curr_page"
               NEXT FIELD fabh100   #161115-00003#1 mod fabh103 -> fabh100
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL afat507_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL afat507_set_act_visible()   
            CALL afat507_set_act_no_visible()
            IF NOT (g_fabg_m.fabgld IS NULL
              OR g_fabg_m.fabgdocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " fabgent = " ||g_enterprise|| " AND",
                                  " fabgld = '", g_fabg_m.fabgld, "' "
                                  ," AND fabgdocno = '", g_fabg_m.fabgdocno, "' "
 
               #填到對應位置
               CALL afat507_browser_fill("")
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
                     WHEN la_wc[li_idx].tableid = "fabh_t" 
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
               CALL afat507_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                     WHEN la_wc[li_idx].tableid = "fabh_t" 
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
                  CALL afat507_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL afat507_fetch("F")
                  END IF
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
          
         
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL afat507_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL afat507_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL afat507_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL afat507_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL afat507_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL afat507_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL afat507_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL afat507_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL afat507_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL afat507_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_fabh_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_fabh3_d)
                  LET g_export_id[2]   = "s_detail3"
 
                  #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
                  LET g_export_node[1] = base.typeInfo.create(g_fabh_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_fabh_d2)
                  LET g_export_id[2]   = "s_detail1_afat503_01"                     
                  LET g_export_node[3] = base.typeInfo.create(g_fabh3_d)
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
               CALL afat507_modify()
               #add-point:ON ACTION modify name="menu.modify"
               #add 151125-00006#3 --s
               LET l_cn = 0 
               SELECT COUNT(*) INTO l_cn FROM fabg_t 
               WHERE fabgld  = g_fabg_m.fabgld  AND fabgdocno = g_fabg_m.fabgdocno AND fabgent = g_enterprise
               IF l_cn > 0 AND NOT cl_null (g_current_idx) THEN
                  CALL afat507_ui_headershow()
               END IF
               #add 151125-00006#3 --e
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL afat507_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               #add 151125-00006#3 --s
               LET l_cn = 0 
               SELECT COUNT(*) INTO l_cn FROM fabg_t 
               WHERE fabgld  = g_fabg_m.fabgld  AND fabgdocno = g_fabg_m.fabgdocno AND fabgent = g_enterprise
               IF l_cn > 0 AND NOT cl_null (g_current_idx) THEN
                  CALL afat507_ui_headershow()
               END IF
               #add 151125-00006#3 --e
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_afat507_02
            LET g_action_choice="open_afat507_02"
            IF cl_auth_chk_act("open_afat507_02") THEN
               
               #add-point:ON ACTION open_afat507_02 name="menu.open_afat507_02"
               #150916--s
               CALL s_aooi200_fin_get_slip(g_fabg_m.fabgdocno) RETURNING l_success,l_ooba002
               CALL s_fin_get_doc_para(g_fabg_m.fabgld,'',l_ooba002,'D-FIN-0030') RETURNING l_str1  
               IF cl_null(l_str1) THEN LET l_str1 = 'Y' END IF    
               IF l_str1 = 'Y' THEN               
               #150916--e
                  #20141106 add--str--
                  CALL s_afat503_afap280_chk(g_fabg_m.fabgdocno,g_fabg_m.fabg008,g_fabg_m.fabgstus) RETURNING l_success 
                  IF l_success = TRUE THEN 
                  #20141106 add--end--               
                     LET la_param.prog = 'afap280'
                     LET la_param.param[1] = g_fabg_m.fabgld
                     LET la_param.param[2] = g_fabg_m.fabgdocno
                     LET la_param.param[3] = g_fabg_m.fabg005
                     LET ls_js = util.JSON.stringify(la_param)
                     CALL cl_cmdrun_wait(ls_js)
                  #20141106 add--str--
                     CURRENT WINDOW IS w_afat507
                     CALL afat507_ui_headershow()
                     SELECT fabg008,fabg009 INTO g_fabg_m.fabg008,g_fabg_m.fabg009 FROM fabg_t
                      WHERE fabgent = g_enterprise AND fabgld = g_fabg_m.fabgld
                        AND fabgdocno = g_fabg_m.fabgdocno
                     DISPLAY BY NAME g_fabg_m.fabg008,g_fabg_m.fabg009    
              
                  END IF    
                
                  #20141106 add--end---   
               #150916--s
               ELSE
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = l_slip
                  LET g_errparam.code   = 'axr-00225'
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()          
               END IF  
               #150916--e                     
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_pre
            LET g_action_choice="open_pre"
            IF cl_auth_chk_act("open_pre") THEN
               
               #add-point:ON ACTION open_pre name="menu.open_pre"
               #20150104 add by chenying
               IF NOT cl_null(g_fabg_m.fabgdocno) AND g_fabg_m.fabgstus = 'N' THEN
                  #获取单别
                  CALL s_aooi200_get_slip(g_fabg_m.fabgdocno) RETURNING l_success,l_slip

                  #是否抛傳票
                  #161215-00044#1---modify----begin-----------------
                  #SELECT * INTO g_glaa.* 
                  SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,
                         glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,glaa011,
                         glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,glaa023,
                         glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,glaa113,glaa120,glaa121,
                         glaa122,glaa027,glaa130,glaa131,glaa132,glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,
                         glaa140,glaa123,glaa124,glaa028 INTO g_glaa.* 
                  #161215-00044#1---modify----end---------------
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
                  CALL s_pre_voucher_ins('FA','F50',g_fabg_m.fabgld,g_fabg_m.fabgdocno,g_fabg_m.fabgdocdt,'21')
                     RETURNING l_success
                  IF l_success THEN
                     CALL s_transaction_end('Y','0')
                  ELSE
                     CALL s_transaction_end('N','0')
                  END IF
               END IF               
               #20150104 add by chenying
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL afat507_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL afat507_insert()
               #add-point:ON ACTION insert name="menu.insert"
               #add 151125-00006#3 --s
               LET l_cn = 0 
               SELECT COUNT(*) INTO l_cn FROM fabg_t 
               WHERE fabgld  = g_fabg_m.fabgld  AND fabgdocno = g_fabg_m.fabgdocno AND fabgent = g_enterprise
               IF l_cn > 0 AND NOT cl_null (g_current_idx) THEN
                  CALL afat507_ui_headershow()
               END IF
               #add 151125-00006#3 --e
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               #151210-00006#1---add----str--
               LET g_rep_wc = " fabgsite ='"||g_fabg_m.fabgsite||"' AND fabg005 = '"||
                              g_fabg_m.fabg005||"' AND fabgstus = '"||g_fabg_m.fabgstus||"' AND fabgld = '"||g_fabg_m.fabgld||
                              "' AND fabgdocno = '"||g_fabg_m.fabgdocno||"'"
               #151210-00006#1---add----end--
               #END add-point
               &include "erp/afa/afat507_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
#151210-00006#1---mark----str--
#               #151022-00001#1---add---str
#               LET l_wc = " fabgdocno = '",g_fabg_m.fabgdocno,"'"
#               CALL afar500_g01(l_wc,g_fabg_m.fabgsite,g_fabg_m.fabg005,g_fabg_m.fabgstus,g_fabg_m.fabgld)
#               #151022-00001#1---add---end
#151210-00006#1---mark----end--
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               #151210-00006#1---add----str--
               LET g_rep_wc = " fabgsite ='"||g_fabg_m.fabgsite||"' AND fabg005 = '"||
                              g_fabg_m.fabg005||"' AND fabgstus = '"||g_fabg_m.fabgstus||"' AND fabgld = '"||g_fabg_m.fabgld||
                              "' AND fabgdocno = '"||g_fabg_m.fabgdocno||"'"
               #151210-00006#1---add----end--
               #END add-point
               &include "erp/afa/afat507_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL afat507_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               #add 151125-00006#3 --s
               LET l_cn = 0 
               SELECT COUNT(*) INTO l_cn FROM fabg_t 
               WHERE fabgld  = g_fabg_m.fabgld  AND fabgdocno = g_fabg_m.fabgdocno AND fabgent = g_enterprise
               IF l_cn > 0 AND NOT cl_null (g_current_idx) THEN
                  CALL afat507_ui_headershow()
               END IF
               #add 151125-00006#3 --e
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_afat507_01
            LET g_action_choice="open_afat507_01"
            IF cl_auth_chk_act("open_afat507_01") THEN
               
               #add-point:ON ACTION open_afat507_01 name="menu.open_afat507_01"
              #CALL afat506_01(g_fabg_m.fabgdocno,g_fabg_m.fabgld,g_fabg_m.fabg005)
               CALL s_aooi200_fin_get_slip(g_fabg_m.fabgdocno) RETURNING l_success,l_ooba002
#               CALL cl_get_doc_para(g_enterprise,g_fabg_m.fabgdocno,l_ooba002,'D-FIN-0030') RETURNING l_str1
               CALL s_fin_get_doc_para(g_fabg_m.fabgld,'',l_ooba002,'D-FIN-0030') RETURNING l_str1  #20141224 add by chenying
               IF cl_null(l_str1) THEN LET l_str1 = 'Y' END IF
               IF l_str1 = 'Y' THEN
                  #20150104 add by chenying
                  IF g_glaa.glaa121 = 'Y' THEN
                     CALL s_pre_voucher('FA','F50',g_fabg_m.fabgld,g_fabg_m.fabgdocno,g_fabg_m.fabgdocdt)
                  ELSE
                  #20150104 add by chenying
#                     CALL afap280_01_cre_fa_tmp_table() RETURNING l_success  #160405-00007#1 mark
                     CALL s_transaction_begin()                  
                     CALL afap280_01_gen_ar('21',g_fabg_m.fabgld,'',' ','1','','Y','afat507') RETURNING l_success
                     IF l_success THEN
                        CALL s_transaction_end('Y','0')
                     ELSE
                        CALL s_transaction_end('N','0')
                     END IF
                     CALL axrt300_13('FA',g_fabg_m.fabgld,g_fabg_m.fabgdocno,'')
                  END IF  #20150104 add by chenying    
               END IF
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL afat507_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail3",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_afat507_03
            LET g_action_choice="open_afat507_03"
            IF cl_auth_chk_act("open_afat507_03") THEN
               
               #add-point:ON ACTION open_afat507_03 name="menu.open_afat507_03"
                #20141106 --add--str--
               CALL s_afat503_afap290_chk(g_fabg_m.fabgdocno,g_fabg_m.fabgld,g_fabg_m.fabg008) RETURNING l_success
               IF l_success = TRUE THEN 
               #20141106 --add--end--                
                  LET la_param.prog = 'afap290'
                  LET la_param.param[1] = g_fabg_m.fabgld
                  LET la_param.param[2] = g_fabg_m.fabgdocno
                  LET la_param.param[3] = g_fabg_m.fabg005
                  LET ls_js = util.JSON.stringify(la_param)
                  CALL cl_cmdrun_wait(ls_js)
               #20141106 add--str--
                  CURRENT WINDOW IS w_afat507
                  SELECT fabg008,fabg009 INTO g_fabg_m.fabg008,g_fabg_m.fabg009 FROM fabg_t
                   WHERE fabgent = g_enterprise AND fabgld = g_fabg_m.fabgld
                     AND fabgdocno = g_fabg_m.fabgdocno
                  DISPLAY BY NAME g_fabg_m.fabg008,g_fabg_m.fabg009  
                  CALL afat507_ui_headershow()                                  
               END IF    
               #20141106 add--end---                     
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_afat502_03
            LET g_action_choice="open_afat502_03"
            IF cl_auth_chk_act("open_afat502_03") THEN
               
               #add-point:ON ACTION open_afat502_03 name="menu.open_afat502_03"
               CALL afat502_03(g_fabg_m.fabgdocno,g_fabg_m.fabgld,g_fabg_m.fabg005)
               CALL afat507_b_fill()
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
            CALL afat507_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL afat507_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL afat507_set_pk_array()
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
 
{<section id="afat507.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION afat507_browser_fill(ps_page_action)
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
   LET l_wc=l_wc," AND fabg005='21' "
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
                      " LEFT JOIN fabh_t ON fabhent = fabgent AND fabgld = fabhld AND fabgdocno = fabhdocno ", "  ",
                      #add-point:browser_fill段sql(fabh_t1) name="browser_fill.cnt.join.}"
                      " LEFT JOIN faah_t ON fabhent = faahent AND fabh000 =faah001 AND fabh001 = faah003 AND fabh002 = faah004 ", #161115-00003#1   2016/11/18 By 07900  add 
                      #end add-point
 
 
                      " ", 
                      " ", 
 
 
                      " WHERE fabgent = " ||g_enterprise|| " AND fabhent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("fabg_t")
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
      CALL g_fabh_d.clear()        
      CALL g_fabh3_d.clear() 
 
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
                  "  LEFT JOIN fabh_t ON fabhent = fabgent AND fabgld = fabhld AND fabgdocno = fabhdocno ", "  ", 
                  #add-point:browser_fill段sql(fabh_t1) name="browser_fill.join.fabh_t1"
                  "  LEFT JOIN faah_t ON fabhent = faahent AND fabh000 =faah001 AND fabh001 = faah003 AND fabh002 = faah004 ", #161115-00003#1   2016/11/18 By 07900  add 
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
 
{<section id="afat507.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION afat507_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_fabg_m.fabgld = g_browser[g_current_idx].b_fabgld   
   LET g_fabg_m.fabgdocno = g_browser[g_current_idx].b_fabgdocno   
 
   EXECUTE afat507_master_referesh USING g_fabg_m.fabgld,g_fabg_m.fabgdocno INTO g_fabg_m.fabgsite,g_fabg_m.fabg002, 
       g_fabg_m.fabg001,g_fabg_m.fabg003,g_fabg_m.fabgld,g_fabg_m.fabg004,g_fabg_m.fabg005,g_fabg_m.fabg008, 
       g_fabg_m.fabgdocno,g_fabg_m.fabg009,g_fabg_m.fabgdocdt,g_fabg_m.fabgstus,g_fabg_m.fabgownid,g_fabg_m.fabgowndp, 
       g_fabg_m.fabgcrtid,g_fabg_m.fabgcrtdp,g_fabg_m.fabgcrtdt,g_fabg_m.fabgmodid,g_fabg_m.fabgmoddt, 
       g_fabg_m.fabgcnfid,g_fabg_m.fabgcnfdt,g_fabg_m.fabgsite_desc,g_fabg_m.fabg002_desc,g_fabg_m.fabg001_desc, 
       g_fabg_m.fabg003_desc,g_fabg_m.fabgld_desc,g_fabg_m.fabgownid_desc,g_fabg_m.fabgowndp_desc,g_fabg_m.fabgcrtid_desc, 
       g_fabg_m.fabgcrtdp_desc,g_fabg_m.fabgmodid_desc,g_fabg_m.fabgcnfid_desc
   
   CALL afat507_fabg_t_mask()
   CALL afat507_show()
      
END FUNCTION
 
{</section>}
 
{<section id="afat507.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION afat507_ui_detailshow()
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
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
      CALL g_curr_diag.setCurrentRow("s_detail1_afat503_01",g_detail_idx)        
      CALL g_curr_diag.setCurrentRow("s_detail3",g_detail_idx)
   END IF
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="afat507.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION afat507_ui_browser_refresh()
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
 
{<section id="afat507.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION afat507_construct()
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
   DEFINE l_ooab002   LIKE ooab_t.ooab002
   DEFINE l_origin_str           STRING   #組織範圍
   DEFINE l_comp_str             STRING   #法人范围
   #end add-point    
   
   #add-point:Function前置處理  name="cs.pre_function"
   
   #end add-point
    
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_fabg_m.* TO NULL
   CALL g_fabh_d.clear()        
   CALL g_fabh3_d.clear() 
 
   
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
      CONSTRUCT BY NAME g_wc ON fabgsite,fabg002,fabg001,fabg003,fabgld,fabg004,fabg005,fabg008,fabgdocno, 
          fabg009,fabgdocdt,fabgstus,fabgownid,fabgowndp,fabgcrtid,fabgcrtdp,fabgcrtdt,fabgmodid,fabgmoddt, 
          fabgcnfid,fabgcnfdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            #CALL cl_set_combo_scc('fabg005','9910')   #20150525 mark lujh
            CALL cl_set_comp_entry("fabg005",FALSE)
            LET g_fabg_m.fabg005 = '21'
            
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
			   LET g_qryparam.where = " ooef207 = 'Y' "
            #CALL q_ooef001()                           #呼叫開窗        #161024-00008#4 
            CALL q_ooef001_47()                                         #161024-00008#4 
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
            
 
 
         #Ctrlp:construct.c.fabg003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabg003
            #add-point:ON ACTION controlp INFIELD fabg003 name="construct.c.fabg003"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            #CALL q_ooef001_9()                           #呼叫開窗      #161024-00008#4 
            CALL q_ooeg001_4()                                          #161024-00008#4 
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
            
 
 
         #Ctrlp:construct.c.fabgld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabgld
            #add-point:ON ACTION controlp INFIELD fabgld name="construct.c.fabgld"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
#160125-00005#7--mark--str--
#         CALL s_fin_create_account_center_tmp()   
#         #取得资产組織下所屬成員
#         CALL s_fin_account_center_sons_query('5',g_fabg_m.fabgsite,g_fabg_m.fabgdocdt,'1')
#         #取得资产中心下所屬成員之帳別   
#         CALL s_fin_account_center_comp_str() RETURNING l_origin_str
#         #將取回的字串轉換為SQL條件
#         CALL afat507_change_to_sql(l_origin_str) RETURNING l_origin_str  
#            
#         LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') AND glaacomp IN (",l_origin_str," )"
#160125-00005#7--mark--end			
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
         BEFORE FIELD fabgdocno
            #add-point:BEFORE FIELD fabgdocno name="construct.b.fabgdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabgdocno
            
            #add-point:AFTER FIELD fabgdocno name="construct.a.fabgdocno"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabgdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabgdocno
            #add-point:ON ACTION controlp INFIELD fabgdocno name="construct.c.fabgdocno"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " fabg005='21' "
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
         BEFORE FIELD fabgdocdt
            #add-point:BEFORE FIELD fabgdocdt name="construct.b.fabgdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabgdocdt
            
            #add-point:AFTER FIELD fabgdocdt name="construct.a.fabgdocdt"
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
               #161215-00044#1---modify----end--------------- 
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
            END IF   
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabgdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabgdocdt
            #add-point:ON ACTION controlp INFIELD fabgdocdt name="construct.c.fabgdocdt"
            
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
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON fabhseq,fabh001,fabh002,fabh000,faah012,faah013,fabh005,fabh006,faah025, 
          faah026,fabh007,fabh015,fabh008,fabh011,fabh004,fabh017,fabh073,fabh020,fabh003,fabh023,fabh024, 
          fabh025,fabh100,fabh101,fabh102,fabh104,fabh108,fabh109,fabh111,fabh150,fabh151,fabh152,fabh154, 
          fabh158,fabh159,fabh161
           FROM s_detail1[1].fabhseq,s_detail1[1].fabh001,s_detail1[1].fabh002,s_detail1[1].fabh000, 
               s_detail1[1].faah012,s_detail1[1].faah013,s_detail1[1].fabh005,s_detail1[1].fabh006,s_detail1[1].faah025, 
               s_detail1[1].faah026,s_detail1[1].fabh007,s_detail1[1].fabh015,s_detail1[1].fabh008,s_detail1[1].fabh011, 
               s_detail1[1].fabh004,s_detail1[1].fabh017,s_detail1[1].fabh073,s_detail1[1].fabh020,s_detail1[1].fabh003, 
               s_detail1[1].fabh023,s_detail1[1].fabh024,s_detail1[1].fabh025,s_detail3[1].fabh100,s_detail3[1].fabh101, 
               s_detail3[1].fabh102,s_detail3[1].fabh104,s_detail3[1].fabh108,s_detail3[1].fabh109,s_detail3[1].fabh111, 
               s_detail3[1].fabh150,s_detail3[1].fabh151,s_detail3[1].fabh152,s_detail3[1].fabh154,s_detail3[1].fabh158, 
               s_detail3[1].fabh159,s_detail3[1].fabh161
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabhseq
            #add-point:BEFORE FIELD fabhseq name="construct.b.page1.fabhseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabhseq
            
            #add-point:AFTER FIELD fabhseq name="construct.a.page1.fabhseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fabhseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabhseq
            #add-point:ON ACTION controlp INFIELD fabhseq name="construct.c.page1.fabhseq"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.fabh001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh001
            #add-point:ON ACTION controlp INFIELD fabh001 name="construct.c.page1.fabh001"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			  #161111-00049#13--ADD--S--
			  CALL s_axrt300_get_site(g_user,'','3') RETURNING l_comp_str 
			  LET l_comp_str = cl_replace_str(l_comp_str ,"ooef017","faah032")
		     LET g_qryparam.where = " faah032 IN (SELECT ooef017 FROM ooef_t WHERE ooefent = ",g_enterprise," AND ooef001 = '",g_site,"') AND ",l_comp_str 			  
			  #161111-00049#13--ADD--E--
            CALL q_faah003_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabh001  #顯示到畫面上
               #DISPLAY g_qryparam.return2 TO faah003 #财产编号 
               #DISPLAY g_qryparam.return3 TO faah004 #附号 

            NEXT FIELD fabh001                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh001
            #add-point:BEFORE FIELD fabh001 name="construct.b.page1.fabh001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh001
            
            #add-point:AFTER FIELD fabh001 name="construct.a.page1.fabh001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fabh002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh002
            #add-point:ON ACTION controlp INFIELD fabh002 name="construct.c.page1.fabh002"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			  #161111-00049#13--ADD--S--
			  CALL s_axrt300_get_site(g_user,'','3') RETURNING l_comp_str 
			  LET l_comp_str = cl_replace_str(l_comp_str ,"ooef017","faah032")
		     LET g_qryparam.where = " faah032 IN (SELECT ooef017 FROM ooef_t WHERE ooefent = ",g_enterprise," AND ooef001 = '",g_site,"') AND ",l_comp_str 			  
			  #161111-00049#13--ADD--E--
            CALL q_faah003_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabh002  #顯示到畫面上
               #DISPLAY g_qryparam.return2 TO faah003 #财产编号 
               #DISPLAY g_qryparam.return3 TO faah004 #附号 

            NEXT FIELD fabh002                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh002
            #add-point:BEFORE FIELD fabh002 name="construct.b.page1.fabh002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh002
            
            #add-point:AFTER FIELD fabh002 name="construct.a.page1.fabh002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fabh000
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh000
            #add-point:ON ACTION controlp INFIELD fabh000 name="construct.c.page1.fabh000"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
		   	LET g_qryparam.reqry = FALSE
			   #161111-00049#13--ADD--S--
			   CALL s_axrt300_get_site(g_user,'','3') RETURNING l_comp_str 
			   LET l_comp_str = cl_replace_str(l_comp_str ,"ooef017","faah032")
		      LET g_qryparam.where = " faah032 IN (SELECT ooef017 FROM ooef_t WHERE ooefent = ",g_enterprise," AND ooef001 = '",g_site,"') AND ",l_comp_str 			  
			   #161111-00049#13--ADD--E--
            CALL q_faah003_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabh000  #顯示到畫面上
               #DISPLAY g_qryparam.return2 TO faah003 #财产编号 
               #DISPLAY g_qryparam.return3 TO faah004 #附号 

            NEXT FIELD fabh000                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh000
            #add-point:BEFORE FIELD fabh000 name="construct.b.page1.fabh000"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh000
            
            #add-point:AFTER FIELD fabh000 name="construct.a.page1.fabh000"
            
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
         BEFORE FIELD fabh005
            #add-point:BEFORE FIELD fabh005 name="construct.b.page1.fabh005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh005
            
            #add-point:AFTER FIELD fabh005 name="construct.a.page1.fabh005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fabh005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh005
            #add-point:ON ACTION controlp INFIELD fabh005 name="construct.c.page1.fabh005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh006
            #add-point:BEFORE FIELD fabh006 name="construct.b.page1.fabh006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh006
            
            #add-point:AFTER FIELD fabh006 name="construct.a.page1.fabh006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fabh006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh006
            #add-point:ON ACTION controlp INFIELD fabh006 name="construct.c.page1.fabh006"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.faah025
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah025
            #add-point:ON ACTION controlp INFIELD faah025 name="construct.c.page1.faah025"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faah025  #顯示到畫面上
            NEXT FIELD faah025                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah025
            #add-point:BEFORE FIELD faah025 name="construct.b.page1.faah025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah025
            
            #add-point:AFTER FIELD faah025 name="construct.a.page1.faah025"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.faah026
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah026
            #add-point:ON ACTION controlp INFIELD faah026 name="construct.c.page1.faah026"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faah026  #顯示到畫面上
            NEXT FIELD faah026                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah026
            #add-point:BEFORE FIELD faah026 name="construct.b.page1.faah026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah026
            
            #add-point:AFTER FIELD faah026 name="construct.a.page1.faah026"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh007
            #add-point:BEFORE FIELD fabh007 name="construct.b.page1.fabh007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh007
            
            #add-point:AFTER FIELD fabh007 name="construct.a.page1.fabh007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fabh007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh007
            #add-point:ON ACTION controlp INFIELD fabh007 name="construct.c.page1.fabh007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh015
            #add-point:BEFORE FIELD fabh015 name="construct.b.page1.fabh015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh015
            
            #add-point:AFTER FIELD fabh015 name="construct.a.page1.fabh015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fabh015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh015
            #add-point:ON ACTION controlp INFIELD fabh015 name="construct.c.page1.fabh015"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh008
            #add-point:BEFORE FIELD fabh008 name="construct.b.page1.fabh008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh008
            
            #add-point:AFTER FIELD fabh008 name="construct.a.page1.fabh008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fabh008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh008
            #add-point:ON ACTION controlp INFIELD fabh008 name="construct.c.page1.fabh008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh011
            #add-point:BEFORE FIELD fabh011 name="construct.b.page1.fabh011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh011
            
            #add-point:AFTER FIELD fabh011 name="construct.a.page1.fabh011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fabh011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh011
            #add-point:ON ACTION controlp INFIELD fabh011 name="construct.c.page1.fabh011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh004
            #add-point:BEFORE FIELD fabh004 name="construct.b.page1.fabh004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh004
            
            #add-point:AFTER FIELD fabh004 name="construct.a.page1.fabh004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fabh004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh004
            #add-point:ON ACTION controlp INFIELD fabh004 name="construct.c.page1.fabh004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh017
            #add-point:BEFORE FIELD fabh017 name="construct.b.page1.fabh017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh017
            
            #add-point:AFTER FIELD fabh017 name="construct.a.page1.fabh017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fabh017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh017
            #add-point:ON ACTION controlp INFIELD fabh017 name="construct.c.page1.fabh017"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh073
            #add-point:BEFORE FIELD fabh073 name="construct.b.page1.fabh073"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh073
            
            #add-point:AFTER FIELD fabh073 name="construct.a.page1.fabh073"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fabh073
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh073
            #add-point:ON ACTION controlp INFIELD fabh073 name="construct.c.page1.fabh073"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.fabh020
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh020
            #add-point:ON ACTION controlp INFIELD fabh020 name="construct.c.page1.fabh020"
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_oocq002_18()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabh020  #顯示到畫面上

            NEXT FIELD fabh020                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh020
            #add-point:BEFORE FIELD fabh020 name="construct.b.page1.fabh020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh020
            
            #add-point:AFTER FIELD fabh020 name="construct.a.page1.fabh020"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh003
            #add-point:BEFORE FIELD fabh003 name="construct.b.page1.fabh003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh003
            
            #add-point:AFTER FIELD fabh003 name="construct.a.page1.fabh003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fabh003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh003
            #add-point:ON ACTION controlp INFIELD fabh003 name="construct.c.page1.fabh003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh023
            #add-point:BEFORE FIELD fabh023 name="construct.b.page1.fabh023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh023
            
            #add-point:AFTER FIELD fabh023 name="construct.a.page1.fabh023"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fabh023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh023
            #add-point:ON ACTION controlp INFIELD fabh023 name="construct.c.page1.fabh023"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh024
            #add-point:BEFORE FIELD fabh024 name="construct.b.page1.fabh024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh024
            
            #add-point:AFTER FIELD fabh024 name="construct.a.page1.fabh024"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fabh024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh024
            #add-point:ON ACTION controlp INFIELD fabh024 name="construct.c.page1.fabh024"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.fabh025
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh025
            #add-point:ON ACTION controlp INFIELD fabh025 name="construct.c.page1.fabh025"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL aglt310_04()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabh025  #顯示到畫面上
            NEXT FIELD fabh025                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh025
            #add-point:BEFORE FIELD fabh025 name="construct.b.page1.fabh025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh025
            
            #add-point:AFTER FIELD fabh025 name="construct.a.page1.fabh025"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh100
            #add-point:BEFORE FIELD fabh100 name="construct.b.page3.fabh100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh100
            
            #add-point:AFTER FIELD fabh100 name="construct.a.page3.fabh100"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.fabh100
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh100
            #add-point:ON ACTION controlp INFIELD fabh100 name="construct.c.page3.fabh100"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh101
            #add-point:BEFORE FIELD fabh101 name="construct.b.page3.fabh101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh101
            
            #add-point:AFTER FIELD fabh101 name="construct.a.page3.fabh101"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.fabh101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh101
            #add-point:ON ACTION controlp INFIELD fabh101 name="construct.c.page3.fabh101"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh102
            #add-point:BEFORE FIELD fabh102 name="construct.b.page3.fabh102"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh102
            
            #add-point:AFTER FIELD fabh102 name="construct.a.page3.fabh102"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.fabh102
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh102
            #add-point:ON ACTION controlp INFIELD fabh102 name="construct.c.page3.fabh102"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh104
            #add-point:BEFORE FIELD fabh104 name="construct.b.page3.fabh104"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh104
            
            #add-point:AFTER FIELD fabh104 name="construct.a.page3.fabh104"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.fabh104
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh104
            #add-point:ON ACTION controlp INFIELD fabh104 name="construct.c.page3.fabh104"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh108
            #add-point:BEFORE FIELD fabh108 name="construct.b.page3.fabh108"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh108
            
            #add-point:AFTER FIELD fabh108 name="construct.a.page3.fabh108"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.fabh108
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh108
            #add-point:ON ACTION controlp INFIELD fabh108 name="construct.c.page3.fabh108"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh109
            #add-point:BEFORE FIELD fabh109 name="construct.b.page3.fabh109"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh109
            
            #add-point:AFTER FIELD fabh109 name="construct.a.page3.fabh109"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.fabh109
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh109
            #add-point:ON ACTION controlp INFIELD fabh109 name="construct.c.page3.fabh109"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh111
            #add-point:BEFORE FIELD fabh111 name="construct.b.page3.fabh111"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh111
            
            #add-point:AFTER FIELD fabh111 name="construct.a.page3.fabh111"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.fabh111
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh111
            #add-point:ON ACTION controlp INFIELD fabh111 name="construct.c.page3.fabh111"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh150
            #add-point:BEFORE FIELD fabh150 name="construct.b.page3.fabh150"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh150
            
            #add-point:AFTER FIELD fabh150 name="construct.a.page3.fabh150"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.fabh150
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh150
            #add-point:ON ACTION controlp INFIELD fabh150 name="construct.c.page3.fabh150"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh151
            #add-point:BEFORE FIELD fabh151 name="construct.b.page3.fabh151"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh151
            
            #add-point:AFTER FIELD fabh151 name="construct.a.page3.fabh151"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.fabh151
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh151
            #add-point:ON ACTION controlp INFIELD fabh151 name="construct.c.page3.fabh151"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh152
            #add-point:BEFORE FIELD fabh152 name="construct.b.page3.fabh152"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh152
            
            #add-point:AFTER FIELD fabh152 name="construct.a.page3.fabh152"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.fabh152
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh152
            #add-point:ON ACTION controlp INFIELD fabh152 name="construct.c.page3.fabh152"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh154
            #add-point:BEFORE FIELD fabh154 name="construct.b.page3.fabh154"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh154
            
            #add-point:AFTER FIELD fabh154 name="construct.a.page3.fabh154"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.fabh154
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh154
            #add-point:ON ACTION controlp INFIELD fabh154 name="construct.c.page3.fabh154"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh158
            #add-point:BEFORE FIELD fabh158 name="construct.b.page3.fabh158"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh158
            
            #add-point:AFTER FIELD fabh158 name="construct.a.page3.fabh158"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.fabh158
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh158
            #add-point:ON ACTION controlp INFIELD fabh158 name="construct.c.page3.fabh158"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh159
            #add-point:BEFORE FIELD fabh159 name="construct.b.page3.fabh159"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh159
            
            #add-point:AFTER FIELD fabh159 name="construct.a.page3.fabh159"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.fabh159
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh159
            #add-point:ON ACTION controlp INFIELD fabh159 name="construct.c.page3.fabh159"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh161
            #add-point:BEFORE FIELD fabh161 name="construct.b.page3.fabh161"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh161
            
            #add-point:AFTER FIELD fabh161 name="construct.a.page3.fabh161"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.fabh161
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh161
            #add-point:ON ACTION controlp INFIELD fabh161 name="construct.c.page3.fabh161"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
 
      
 
      
      #add-point:cs段add_cs(本段內只能出現新的CONSTRUCT指令) name="cs.add_cs"
      SUBDIALOG afa_afat503_01.afat503_01_construct
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
                  WHEN la_wc[li_idx].tableid = "fabh_t" 
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
   
   IF g_wc_subject <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc_subject
   END IF
   LET g_wc_d=g_wc2
   
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
 
{<section id="afat507.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION afat507_query()
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
   CALL g_fabh_d.clear()
   CALL g_fabh3_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL afat507_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL afat507_browser_fill("")
      CALL afat507_fetch("")
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
   CALL afat507_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL afat507_fetch("F") 
      #顯示單身筆數
      CALL afat507_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="afat507.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION afat507_fetch(p_flag)
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
   EXECUTE afat507_master_referesh USING g_fabg_m.fabgld,g_fabg_m.fabgdocno INTO g_fabg_m.fabgsite,g_fabg_m.fabg002, 
       g_fabg_m.fabg001,g_fabg_m.fabg003,g_fabg_m.fabgld,g_fabg_m.fabg004,g_fabg_m.fabg005,g_fabg_m.fabg008, 
       g_fabg_m.fabgdocno,g_fabg_m.fabg009,g_fabg_m.fabgdocdt,g_fabg_m.fabgstus,g_fabg_m.fabgownid,g_fabg_m.fabgowndp, 
       g_fabg_m.fabgcrtid,g_fabg_m.fabgcrtdp,g_fabg_m.fabgcrtdt,g_fabg_m.fabgmodid,g_fabg_m.fabgmoddt, 
       g_fabg_m.fabgcnfid,g_fabg_m.fabgcnfdt,g_fabg_m.fabgsite_desc,g_fabg_m.fabg002_desc,g_fabg_m.fabg001_desc, 
       g_fabg_m.fabg003_desc,g_fabg_m.fabgld_desc,g_fabg_m.fabgownid_desc,g_fabg_m.fabgowndp_desc,g_fabg_m.fabgcrtid_desc, 
       g_fabg_m.fabgcrtdp_desc,g_fabg_m.fabgmodid_desc,g_fabg_m.fabgcnfid_desc
   
   #遮罩相關處理
   LET g_fabg_m_mask_o.* =  g_fabg_m.*
   CALL afat507_fabg_t_mask()
   LET g_fabg_m_mask_n.* =  g_fabg_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL afat507_set_act_visible()   
   CALL afat507_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   CALL cl_set_act_visible("modify,delete,insert,modify_detail", TRUE)
   IF g_fabg_m.fabgstus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   LET g_fabgld=g_fabg_m.fabgld
   LET g_fabgdocno=g_fabg_m.fabgdocno
   #end add-point
   
   #保存單頭舊值
   LET g_fabg_m_t.* = g_fabg_m.*
   LET g_fabg_m_o.* = g_fabg_m.*
   
   LET g_data_owner = g_fabg_m.fabgownid      
   LET g_data_dept  = g_fabg_m.fabgowndp
   
   #重新顯示   
   CALL afat507_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="afat507.insert" >}
#+ 資料新增
PRIVATE FUNCTION afat507_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   DEFINE l_ooef207   LIKE ooef_t.ooef207
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_fabh_d.clear()   
   CALL g_fabh3_d.clear()  
 
 
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
     
     CALL afat507_default()
     CALL afat507_visible()
     LET g_fabg_m.fabg005 = "21"
     SELECT ooef207 INTO l_ooef207
       FROM ooef_t
      WHERE ooefent = g_enterprise
        AND ooef001 = g_site
     IF l_ooef207 = 'Y' THEN      
        LET g_fabg_m.fabgsite = g_site
        CALL afat507_get_fabgsite_desc()
     END IF 
     LET g_fabg_m_t.* = g_fabg_m.* #20141213 add by chenying
     CALL afat503_01_b_fill()

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
 
 
 
    
      CALL afat507_input("a")
      
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
         INITIALIZE g_fabh_d TO NULL
         INITIALIZE g_fabh3_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL afat507_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_fabh_d.clear()
      #CALL g_fabh3_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL afat507_set_act_visible()   
   CALL afat507_set_act_no_visible()
   
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
   CALL afat507_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE afat507_cl
   
   CALL afat507_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE afat507_master_referesh USING g_fabg_m.fabgld,g_fabg_m.fabgdocno INTO g_fabg_m.fabgsite,g_fabg_m.fabg002, 
       g_fabg_m.fabg001,g_fabg_m.fabg003,g_fabg_m.fabgld,g_fabg_m.fabg004,g_fabg_m.fabg005,g_fabg_m.fabg008, 
       g_fabg_m.fabgdocno,g_fabg_m.fabg009,g_fabg_m.fabgdocdt,g_fabg_m.fabgstus,g_fabg_m.fabgownid,g_fabg_m.fabgowndp, 
       g_fabg_m.fabgcrtid,g_fabg_m.fabgcrtdp,g_fabg_m.fabgcrtdt,g_fabg_m.fabgmodid,g_fabg_m.fabgmoddt, 
       g_fabg_m.fabgcnfid,g_fabg_m.fabgcnfdt,g_fabg_m.fabgsite_desc,g_fabg_m.fabg002_desc,g_fabg_m.fabg001_desc, 
       g_fabg_m.fabg003_desc,g_fabg_m.fabgld_desc,g_fabg_m.fabgownid_desc,g_fabg_m.fabgowndp_desc,g_fabg_m.fabgcrtid_desc, 
       g_fabg_m.fabgcrtdp_desc,g_fabg_m.fabgmodid_desc,g_fabg_m.fabgcnfid_desc
   
   
   #遮罩相關處理
   LET g_fabg_m_mask_o.* =  g_fabg_m.*
   CALL afat507_fabg_t_mask()
   LET g_fabg_m_mask_n.* =  g_fabg_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_fabg_m.fabgsite,g_fabg_m.fabgsite_desc,g_fabg_m.fabg002,g_fabg_m.fabg002_desc,g_fabg_m.fabg001, 
       g_fabg_m.fabg001_desc,g_fabg_m.fabg003,g_fabg_m.fabg003_desc,g_fabg_m.fabgld,g_fabg_m.fabgld_desc, 
       g_fabg_m.fabg004,g_fabg_m.fabg005,g_fabg_m.fabg008,g_fabg_m.fabgdocno,g_fabg_m.fabg009,g_fabg_m.fabgdocdt, 
       g_fabg_m.fabgstus,g_fabg_m.fabgownid,g_fabg_m.fabgownid_desc,g_fabg_m.fabgowndp,g_fabg_m.fabgowndp_desc, 
       g_fabg_m.fabgcrtid,g_fabg_m.fabgcrtid_desc,g_fabg_m.fabgcrtdp,g_fabg_m.fabgcrtdp_desc,g_fabg_m.fabgcrtdt, 
       g_fabg_m.fabgmodid,g_fabg_m.fabgmodid_desc,g_fabg_m.fabgmoddt,g_fabg_m.fabgcnfid,g_fabg_m.fabgcnfid_desc, 
       g_fabg_m.fabgcnfdt
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_fabg_m.fabgownid      
   LET g_data_dept  = g_fabg_m.fabgowndp
   
   #功能已完成,通報訊息中心
   CALL afat507_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="afat507.modify" >}
#+ 資料修改
PRIVATE FUNCTION afat507_modify()
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
   
   OPEN afat507_cl USING g_enterprise,g_fabg_m.fabgld,g_fabg_m.fabgdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN afat507_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE afat507_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE afat507_master_referesh USING g_fabg_m.fabgld,g_fabg_m.fabgdocno INTO g_fabg_m.fabgsite,g_fabg_m.fabg002, 
       g_fabg_m.fabg001,g_fabg_m.fabg003,g_fabg_m.fabgld,g_fabg_m.fabg004,g_fabg_m.fabg005,g_fabg_m.fabg008, 
       g_fabg_m.fabgdocno,g_fabg_m.fabg009,g_fabg_m.fabgdocdt,g_fabg_m.fabgstus,g_fabg_m.fabgownid,g_fabg_m.fabgowndp, 
       g_fabg_m.fabgcrtid,g_fabg_m.fabgcrtdp,g_fabg_m.fabgcrtdt,g_fabg_m.fabgmodid,g_fabg_m.fabgmoddt, 
       g_fabg_m.fabgcnfid,g_fabg_m.fabgcnfdt,g_fabg_m.fabgsite_desc,g_fabg_m.fabg002_desc,g_fabg_m.fabg001_desc, 
       g_fabg_m.fabg003_desc,g_fabg_m.fabgld_desc,g_fabg_m.fabgownid_desc,g_fabg_m.fabgowndp_desc,g_fabg_m.fabgcrtid_desc, 
       g_fabg_m.fabgcrtdp_desc,g_fabg_m.fabgmodid_desc,g_fabg_m.fabgcnfid_desc
   
   #檢查是否允許此動作
   IF NOT afat507_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_fabg_m_mask_o.* =  g_fabg_m.*
   CALL afat507_fabg_t_mask()
   LET g_fabg_m_mask_n.* =  g_fabg_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   IF g_fabg_m.fabgstus<>'N' THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = '' 
      LET g_errparam.code   = 'aim-00090'
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   #151231-00005#4--add--str--lujh
   IF NOT cl_null(g_fabg_m.fabgdocdt) THEN 
      IF NOT s_afa_date_chk(g_fabg_m.fabgld,'',g_fabg_m.fabgdocdt) THEN 
         CLOSE afat507_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF 
   END IF 
   #151231-00005#4--add--end--lujh
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
 
   
   CALL afat507_show()
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
      #「D抽單 / R已拒絕」狀況碼更改資料後，需還原為「N未確認」
      IF g_fabg_m.fabgstus MATCHES "[DR]" THEN
         LET g_fabg_m.fabgstus = "N"
      END IF      
      IF g_fabg_m.fabgstus<>'N' THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 'aim-00090'
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN
      END IF
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL afat507_input("u")
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
            CALL afat507_show()
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
         UPDATE fabh_t SET fabhld = g_fabg_m.fabgld
                                       ,fabhdocno = g_fabg_m.fabgdocno
 
          WHERE fabhent = g_enterprise AND fabhld = g_fabg_m_t.fabgld
            AND fabhdocno = g_fabg_m_t.fabgdocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "fabh_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "fabh_t:",SQLERRMESSAGE 
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
   CALL afat507_set_act_visible()   
   CALL afat507_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " fabgent = " ||g_enterprise|| " AND",
                      " fabgld = '", g_fabg_m.fabgld, "' "
                      ," AND fabgdocno = '", g_fabg_m.fabgdocno, "' "
 
   #填到對應位置
   CALL afat507_browser_fill("")
 
   CLOSE afat507_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL afat507_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="afat507.input" >}
#+ 資料輸入
PRIVATE FUNCTION afat507_input(p_cmd)
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
   DEFINE  l_ooab002             LIKE ooab_t.ooab002
   DEFINE  l_ooag004             LIKE ooag_t.ooag004 
   DEFINE  l_faab004             LIKE faab_t.faab004 
   DEFINE  l_success             LIKE type_t.num5
   DEFINE  l_ooef004             LIKE ooef_t.ooef004
   DEFINE  l_n1                  LIKE type_t.num5
   DEFINE  l_n2                  LIKE type_t.num5
   DEFINE  l_n3                  LIKE type_t.num5
   DEFINE  l_n4                  LIKE type_t.num5
   DEFINE  l_n7                  LIKE type_t.num5
   DEFINE  l_fabh007             LIKE fabh_t.fabh007
   DEFINE  l_faaj033             LIKE faaj_t.faaj033
   DEFINE  l_glaa004             LIKE glaa_t.glaa004
   DEFINE  l_oocq019             LIKE oocq_t.oocq019
   DEFINE  l_glaa001             LIKE glaa_t.glaa001
   DEFINE  l_glaacomp            LIKE glaa_t.glaacomp
   DEFINE l_origin_str           STRING   #組織範圍
   DEFINE  l_n5                  LIKE type_t.num5
   DEFINE  l_n6                  LIKE type_t.num5
   DEFINE  l_sql                 STRING
   DEFINE  l_fabh001             LIKE fabh_t.fabh001
   DEFINE  l_fabh002             LIKE fabh_t.fabh002
   DEFINE  l_fabh000             LIKE fabh_t.fabh000
   DEFINE  l_fabgcomp            LIKE fabg_t.fabgcomp
   DEFINE  l_ooef207             LIKE ooef_t.ooef207  
   DEFINE  l_year                LIKE type_t.num5   #20141213 add by chenying
   DEFINE  l_month               LIKE type_t.num5   #20141213 add by chenying 
   DEFINE  l_para_data           LIKE fabg_t.fabg004 #20141213 add by chenying 
   DEFINE  l_oocq009             LIKE oocq_t.oocq009 #20141219 add by chenying 
   DEFINE  r_success             LIKE type_t.num5   #20141224 add by chenying 
   DEFINE  l_ooba002             LIKE ooba_t.ooba002   #150916
   DEFINE  l_str1                LIKE type_t.chr1      #150916
   #151125-00006#3-s
   DEFINE  l_dfin0031            LIKE type_t.chr1
   DEFINE  l_dfin0032            LIKE type_t.chr1
   DEFINE  l_ld                  LIKE fabg_t.fabgld
   #151125-00006#3-e
   DEFINE  l_ld_str              STRING
   DEFINE l_flag                 LIKE type_t.num5       #161104-00046#16 add
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
   DISPLAY BY NAME g_fabg_m.fabgsite,g_fabg_m.fabgsite_desc,g_fabg_m.fabg002,g_fabg_m.fabg002_desc,g_fabg_m.fabg001, 
       g_fabg_m.fabg001_desc,g_fabg_m.fabg003,g_fabg_m.fabg003_desc,g_fabg_m.fabgld,g_fabg_m.fabgld_desc, 
       g_fabg_m.fabg004,g_fabg_m.fabg005,g_fabg_m.fabg008,g_fabg_m.fabgdocno,g_fabg_m.fabg009,g_fabg_m.fabgdocdt, 
       g_fabg_m.fabgstus,g_fabg_m.fabgownid,g_fabg_m.fabgownid_desc,g_fabg_m.fabgowndp,g_fabg_m.fabgowndp_desc, 
       g_fabg_m.fabgcrtid,g_fabg_m.fabgcrtid_desc,g_fabg_m.fabgcrtdp,g_fabg_m.fabgcrtdp_desc,g_fabg_m.fabgcrtdt, 
       g_fabg_m.fabgmodid,g_fabg_m.fabgmodid_desc,g_fabg_m.fabgmoddt,g_fabg_m.fabgcnfid,g_fabg_m.fabgcnfid_desc, 
       g_fabg_m.fabgcnfdt
   
   #切換畫面
 
   CALL cl_set_head_visible("","YES")  
 
   LET l_insert = FALSE
   LET g_action_choice = ""
 
   #add-point:input段define_sql name="input.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT fabhseq,fabh001,fabh002,fabh000,fabh005,fabh006,fabh007,fabh015,fabh008, 
       fabh011,fabh004,fabh017,fabh073,fabh020,fabh003,fabh023,fabh024,fabh025,fabhseq,fabh100,fabh101, 
       fabh102,fabh104,fabh108,fabh109,fabh111,fabh150,fabh151,fabh152,fabh154,fabh158,fabh159,fabh161  
       FROM fabh_t WHERE fabhent=? AND fabhld=? AND fabhdocno=? AND fabhseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE afat507_bcl CURSOR FROM g_forupd_sql
   
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL afat507_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL afat507_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_fabg_m.fabgsite,g_fabg_m.fabg002,g_fabg_m.fabg001,g_fabg_m.fabg003,g_fabg_m.fabgld, 
       g_fabg_m.fabg004,g_fabg_m.fabg005,g_fabg_m.fabg008,g_fabg_m.fabgdocno,g_fabg_m.fabg009,g_fabg_m.fabgdocdt, 
       g_fabg_m.fabgstus
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   LET g_errshow = 1
   LET g_detail_insert = cl_auth_detail_input("insert")
   LET g_detail_delete = cl_auth_detail_input("delete")
   #161215-00044#1---modify----begin-----------------
   #SELECT * INTO g_glaa.* 
   SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,
          glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,glaa011,
          glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,glaa023,
          glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,glaa113,glaa120,glaa121,
          glaa122,glaa027,glaa130,glaa131,glaa132,glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,
          glaa140,glaa123,glaa124,glaa028 INTO g_glaa.* 
   #161215-00044#1---modify----end---------------
   FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_fabg_m.fabgld #20141213 add by chenying
   CALL cl_get_para(g_enterprise,g_glaa.glaacomp,'S-FIN-9003') RETURNING l_para_data
   LET r_success = TRUE #20141224 add by chenying
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="afat507.input.head" >}
      #單頭段
      INPUT BY NAME g_fabg_m.fabgsite,g_fabg_m.fabg002,g_fabg_m.fabg001,g_fabg_m.fabg003,g_fabg_m.fabgld, 
          g_fabg_m.fabg004,g_fabg_m.fabg005,g_fabg_m.fabg008,g_fabg_m.fabgdocno,g_fabg_m.fabg009,g_fabg_m.fabgdocdt, 
          g_fabg_m.fabgstus 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN afat507_cl USING g_enterprise,g_fabg_m.fabgld,g_fabg_m.fabgdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN afat507_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE afat507_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL afat507_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            
            #end add-point
            CALL afat507_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabgsite
            
            #add-point:AFTER FIELD fabgsite name="input.a.fabgsite"
#160426-00014#33--mark--str--lujh
#            IF NOT cl_null(g_fabg_m.fabgsite) THEN
#               IF p_cmd = 'a'  OR (g_fabg_m.fabgsite <> g_fabg_m_t.fabgsite OR cl_null(g_fabg_m_t.fabgsite)) THEN
#                  #检查组织资料的合理性             
#                  IF NOT s_afat502_site_chk(g_fabg_m.fabgsite) THEN
#                     LET g_fabg_m.fabgsite = g_fabg_m_t.fabgsite
#                     CALL afat507_get_fabgsite_desc()
#                     NEXT FIELD CURRENT
#                  END IF 
#                  #帳務人員不為空需要檢查和資產中心的權限
#                  IF NOT cl_null(g_fabg_m.fabg001) THEN
#                     IF NOT s_afat502_site_user_chk(g_fabg_m.fabgsite,g_fabg_m.fabg001) THEN
#                        INITIALIZE g_errparam TO NULL
#                        LET g_errparam.code = g_errno
#                        LET g_errparam.extend = ''
#                        LET g_errparam.popup = TRUE
#                        CALL cl_err()
#                        LET g_fabg_m.fabgsite = g_fabg_m_t.fabgsite
#                        CALL afat507_get_fabgsite_desc()
#                        NEXT FIELD CURRENT  
#                     END IF
#                  END IF   
#                  #帐套不为空检查法人归属是否相同
#                  IF NOT cl_null(g_fabg_m.fabgld) THEN
#                     IF NOT s_afat502_site_ld_chk(g_fabg_m.fabgsite,g_fabg_m.fabgld) THEN
#                        LET g_fabg_m.fabgsite = g_fabg_m_t.fabgsite
#                        CALL afat507_get_fabgsite_desc()
#                        NEXT FIELD CURRENT  
#                     END IF
#                  END IF  
#                  # ####################################mark by huangtao
#               END IF
#              
#            END IF    
#            CALL afat507_get_fabgsite_desc()
#160426-00014#33--mark--end--lujh

#160426-00014#33--add--str--lujh
            IF NOT cl_null(g_fabg_m.fabgsite) THEN
              #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_fabg_m.fabgsite != g_fabg_m_t.fabgsite OR g_fabg_m_t.fabgsite IS NULL )) THEN   #160824-00007#248 161208 by lori mark
               IF g_fabg_m.fabgsite != g_fabg_m_o.fabgsite OR cl_null(g_fabg_m_o.fabgsite) THEN                      #160824-00007#248 161208 by lori add
                 #160824-00007#248 161208 by lori mod---(S)
                 #CALL s_afa_site_chk(g_fabg_m.fabgsite,g_fabg_m_t.fabgsite,'',g_fabg_m.fabgld,g_fabg_m.fabgdocdt)   
                  CALL s_afa_site_chk(g_fabg_m.fabgsite,g_fabg_m_o.fabgsite,'',g_fabg_m.fabgld,g_fabg_m.fabgdocdt)   
                  RETURNING l_success,g_glaa.glaacomp,g_fabg_m.fabgld
                 #160824-00007#248 161208 by lori mod---(E)
                  IF l_success = FALSE THEN 
                    #160824-00007#248 161208 by lori mod---(S)
                    #LET g_fabg_m.fabgsite = g_fabg_m_t.fabgsite  
                    #LET g_fabg_m.fabgld = g_fabg_m_t.fabgld      
                     LET g_fabg_m.fabgsite = g_fabg_m_o.fabgsite  
                     LET g_fabg_m.fabgld = g_fabg_m_o.fabgld      
                    #160824-00007#248 161208 by lori mod---(E)
                     CALL s_desc_get_department_desc(g_fabg_m.fabgsite) RETURNING g_fabg_m.fabgsite_desc
                     DISPLAY BY NAME g_fabg_m.fabgsite_desc
                     NEXT FIELD CURRENT
                  END IF
                  
                  #人员不为空
                  IF NOT cl_null(g_fabg_m.fabg001) THEN
                     CALL s_afa_person_chk(g_fabg_m.fabgsite,g_fabg_m.fabg001)
                     RETURNING l_success
                     IF l_success = FALSE THEN
                       #160824-00007#248 161208 by lori mod---(S)
                       #LET g_fabg_m.fabgsite = g_fabg_m_t.fabgsite                          
                        LET g_fabg_m.fabgsite = g_fabg_m_o.fabgsite  
                       #160824-00007#248 161208 by lori mod---(E)                        
                        CALL s_desc_get_department_desc(g_fabg_m.fabgsite) RETURNING g_fabg_m.fabgsite_desc
                        DISPLAY BY NAME g_fabg_m.fabgsite_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF
            CALL s_fin_account_center_sons_query('5',g_fabg_m.fabgsite,g_today,'1')
           #160824-00007#248 161208 by lori mod---(S)
           #LET g_fabg_m_t.fabgsite = g_fabg_m.fabgsite   
           #LET g_fabg_m_t.fabgld = g_fabg_m.fabgld       
            LET g_fabg_m_o.fabgsite = g_fabg_m.fabgsite   
            LET g_fabg_m_o.fabgld = g_fabg_m.fabgld       
           #160824-00007#248 161208 by lori mod---(E)
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
         AFTER FIELD fabg002
            
            #add-point:AFTER FIELD fabg002 name="input.a.fabg002"
            IF NOT cl_null(g_fabg_m.fabg002) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fabg_m.fabg002
               #160318-00025#5--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
               #160318-00025#5--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooag001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  #檢查失敗時後續處理
                  LET g_fabg_m.fabg002 = g_fabg_m_t.fabg002
                  CALL afat507_get_fabg002_desc()
                  DISPLAY BY NAME g_fabg_m.fabg002,g_fabg_m.fabg002_desc 
                  NEXT FIELD CURRENT
               END IF
               #add by yangxf ----
               SELECT ooag003 INTO g_fabg_m.fabg003
                 FROM ooag_t
                WHERE ooagent = g_enterprise
                  AND ooag001 = g_fabg_m.fabg002
               CALL afat507_get_fabg003_desc()
               #add by yangxf ---
            END IF 
            
            CALL afat507_get_fabg002_desc()
            
            

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
         AFTER FIELD fabg001
            
            #add-point:AFTER FIELD fabg001 name="input.a.fabg001"
#160426-00014#33--mark--str--lujh
#            IF NOT cl_null(g_fabg_m.fabg001) THEN
#               #檢查是否存在  員工資料檔中
#               IF NOT ap_chk_isExist(g_fabg_m.fabg001,"SELECT COUNT(*) FROM ooag_t WHERE "||"ooagent = '" ||g_enterprise|| "' AND "||"ooag001 = ? ",'aim-00069',1) THEN
#                  LET g_fabg_m.fabg001 = g_fabg_m_t.fabg001
#                   CALL afat507_get_fabg001_desc()                   
#                  NEXT FIELD CURRENT
#               END IF   
#               #檢查是否有效               
##               IF NOT ap_chk_isExist(g_fabg_m.fabg001,"SELECT COUNT(*) FROM ooag_t WHERE "||"ooagent = '" ||g_enterprise|| "' AND "||"ooag001 = ? AND ooagstus = 'Y'",'aim-00070',1) THEN
#                IF NOT ap_chk_isExist(g_fabg_m.fabg001,"SELECT COUNT(*) FROM ooag_t WHERE "||"ooagent = '" ||g_enterprise|| "' AND "||"ooag001 = ? AND ooagstus = 'Y'",'sub-01302','aooi130') THEN#160318-00005#11 mod 
#                  LET g_fabg_m.fabg001 = g_fabg_m_t.fabg001
#                   CALL afat507_get_fabg001_desc()
#                  NEXT FIELD CURRENT
#               END IF        
#                ################################add by huangtao
#                #資產中心不為空的情況下
#                IF NOT cl_null(g_fabg_m.fabgsite) THEN 
#                  IF NOT s_afat502_site_user_chk(g_fabg_m.fabgsite,g_fabg_m.fabg001) THEN
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code = g_errno
#                     LET g_errparam.extend = ''
#                     LET g_errparam.popup = TRUE
#                     CALL cl_err()
#                     LET g_fabg_m.fabg001 = g_fabg_m_t.fabg001
#                     CALL afat507_get_fabg001_desc() 
#                     NEXT FIELD CURRENT
#                  END IF
#                END IF
#                #帳套不為空時
#                IF NOT cl_null(g_fabg_m.fabgld) THEN
#                   IF NOT s_ld_chk_authorization(g_fabg_m.fabg001,g_fabg_m.fabgld) THEN
#                      INITIALIZE g_errparam TO NULL
#                      LET g_errparam.code = 'axr-00022'     
#                      LET g_errparam.extend = ''
#                      LET g_errparam.popup = TRUE
#                      CALL cl_err() 
#                      LET g_fabg_m.fabg001 = g_fabg_m_t.fabg001
#                      CALL afat507_get_fabg001_desc() 
#                      NEXT FIELD CURRENT
#                   END IF  
#                END IF
#                ################################add by huangtao
#            END IF    
#            CALL afat507_get_fabg001_desc() 
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
         AFTER FIELD fabg003
            
            #add-point:AFTER FIELD fabg003 name="input.a.fabg003"
            IF NOT cl_null(g_fabg_m.fabg003) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fabg_m.fabg003
               #160318-00025#5--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#5--add--end 
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooef001_14") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                  #add by yangxf ---
                  IF NOT cl_null(g_fabg_m.fabg002) THEN 
                     INITIALIZE g_chkparam.* TO NULL
                     #設定g_chkparam.*的參數
                     #161024-00008#4---s---
                     #LET g_chkparam.arg1 = g_fabg_m.fabg002
                     #LET g_chkparam.arg2 = g_fabg_m.fabg003
                        
                     #呼叫檢查存在並帶值的library
                      #IF cl_chk_exist("v_ooag003") THEN
                     LET g_chkparam.arg1 = g_fabg_m.fabg003
                     LET g_chkparam.arg2 = g_fabg_m.fabg004
                     IF cl_chk_exist("v_ooeg001_8") THEN
                     #161024-00008#4---e---
                     ELSE
                        #檢查失敗時後續處理
                        LET g_fabg_m.fabg003 = g_fabg_m_t.fabg003
                        CALL afat507_get_fabg003_desc()
                        NEXT FIELD CURRENT
                     END IF
                  END IF 
                  #add by yangxf ---
               ELSE
                  #檢查失敗時後續處理
                  LET g_fabg_m.fabg003 = g_fabg_m_t.fabg003
                  CALL afat507_get_fabg003_desc()
                  DISPLAY BY NAME g_fabg_m.fabg003,g_fabg_m.fabg003_desc 
                  NEXT FIELD CURRENT
               END IF

            END IF 
            
            CALL afat507_get_fabg003_desc()
            
            

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabg003
            #add-point:BEFORE FIELD fabg003 name="input.b.fabg003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabg003
            #add-point:ON CHANGE fabg003 name="input.g.fabg003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabgld
            
            #add-point:AFTER FIELD fabgld name="input.a.fabgld"
            #此段落由子樣板a05產生
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
#               #160318-00025#5--add--str
#               LET g_errshow = TRUE 
#               LET g_chkparam.err_str[1] = "agl-00051:sub-01302|agli010|",cl_get_progname("agli010",g_lang,"2"),"|:EXEPROGagli010"
#               #160318-00025#5--add--end
#                  
#               #呼叫檢查存在並帶值的library
#               IF cl_chk_exist("v_fabgld") THEN
#                  #檢查成功時後續處理
#                  #LET  = g_chkparam.return1
#                  #DISPLAY BY NAME 
#
#               ELSE
#                  #檢查失敗時後續處理
#                  LET g_fabg_m.fabgld = g_fabg_m_t.fabgld
#                  CALL afat507_get_fabgld_desc()
#                  DISPLAY BY NAME g_fabg_m.fabgld,g_fabg_m.fabgld_desc 
#                  NEXT FIELD CURRENT
#               END IF
#
#               #帐套人员不为空时
#               IF NOT cl_null(g_fabg_m.fabg001) THEN
#                  IF NOT s_ld_chk_authorization(g_fabg_m.fabg001,g_fabg_m.fabgld) THEN
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code = 'axr-00022'
#                     LET g_errparam.extend = g_fabg_m.fabgld
#                     LET g_errparam.popup = FALSE
#                     CALL cl_err()
#                     LET g_fabg_m.fabgld = g_fabg_m_t.fabgld
#                     CALL afat507_get_fabgld_desc()
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#               #资产中心不为空时
#               IF NOT cl_null(g_fabg_m.fabgsite) THEN
#                  IF NOT s_afat502_site_ld_chk(g_fabg_m.fabgsite,g_fabg_m.fabgld) THEN
#                     LET g_fabg_m.fabgld = g_fabg_m_t.fabgld
#                     CALL afat507_get_fabgld_desc()
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#               ##########################################mark by huangtao
#            END IF 
#            
#            CALL afat507_get_fabgld_desc()
#160426-00014#33--mark--end--lujh

#160426-00014#33--add--str--lujh
            IF NOT cl_null(g_fabg_m.fabgld) THEN
              #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_fabg_m.fabgld != g_fabg_m_t.fabgld OR g_fabg_m_t.fabgld IS NULL )) THEN   #160824-00007#248 161208 by lori mark
               IF g_fabg_m.fabgld != g_fabg_m_o.fabgld OR cl_null(g_fabg_m_o.fabgld) THEN   #160824-00007#248 161208 by lori add
                  CALL s_afa_ld_chk(g_fabg_m.fabgsite,g_fabg_m.fabgld)
                  RETURNING l_success,g_glaa.glaacomp
                  
                  IF l_success = FALSE THEN 
                    #160824-00007#248 161208 by lori mod---(S)
                    #LET g_fabg_m.fabgld = g_fabg_m_t.fabgld   
                     LET g_fabg_m.fabgld = g_fabg_m_o.fabgld   
                    #160824-00007#248 161208 by lori mod---(S)
                     CALL s_desc_get_ld_desc(g_fabg_m.fabgld) RETURNING g_fabg_m.fabgld_desc
                     DISPLAY BY NAME g_fabg_m.fabgld_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
           #160824-00007#248 161208 by lori mod---(S)
            LET g_fabg_m_t.fabgld = g_fabg_m.fabgld  
            LET g_fabg_m_o.fabgld = g_fabg_m.fabgld  
           #160824-00007#248 161208 by lori mod---(E)            
            CALL s_desc_get_ld_desc(g_fabg_m.fabgld) RETURNING g_fabg_m.fabgld_desc
            DISPLAY BY NAME g_fabg_m.fabgld_desc
#160426-00014#33--add--end--lujh 

            #161215-00044#1---modify----begin-----------------
            #SELECT * INTO g_glaa.* 
            SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,
                   glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,glaa011,
                   glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,glaa023,
                   glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,glaa113,glaa120,glaa121,
                   glaa122,glaa027,glaa130,glaa131,glaa132,glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,
                   glaa140,glaa123,glaa124,glaa028 INTO g_glaa.* 
            #161215-00044#1---modify----end---------------
            FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_fabg_m.fabgld
            CALL afat507_visible()
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
         BEFORE FIELD fabg004
            #add-point:BEFORE FIELD fabg004 name="input.b.fabg004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabg004
            
            #add-point:AFTER FIELD fabg004 name="input.a.fabg004"
            
#            IF NOT cl_null(g_fabg_m.fabg004) THEN 
#               #單據日期不能小於關賬日期
#               #S-FIN-9003
#               SELECT ooab002 INTO l_ooab002 FROM ooab_t
#                WHERE ooabent = g_enterprise
#                  AND ooab001 = 'S-FIN-9003'
#                  AND ooabsite = g_site 
#              IF g_fabg_m.fabg004 < l_ooab002 THEN 
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
         BEFORE FIELD fabgdocno
            #add-point:BEFORE FIELD fabgdocno name="input.b.fabgdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabgdocno
            
            #add-point:AFTER FIELD fabgdocno name="input.a.fabgdocno"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_fabg_m.fabgld) AND NOT cl_null(g_fabg_m.fabgdocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_fabg_m.fabgld != g_fabgld_t  OR g_fabg_m.fabgdocno != g_fabgdocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM fabg_t WHERE "||"fabgent = '" ||g_enterprise|| "' AND "||"fabgld = '"||g_fabg_m.fabgld ||"' AND "|| "fabgdocno = '"||g_fabg_m.fabgdocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            
            IF NOT cl_null(g_fabg_m.fabgdocno) THEN
#               SELECT ooef004 INTO l_ooef004 from ooef_t,ooag_t
#                WHERE ooefent=ooagent AND ooefent = g_enterprise
#                  AND ooef001 = ooag004 AND ooag001 = g_user             
                #161215-00044#1---modify----begin-----------------
                  #SELECT * INTO g_glaa.* 
                  SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,
                         glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,glaa011,
                         glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,glaa023,
                         glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,glaa113,glaa120,glaa121,
                         glaa122,glaa027,glaa130,glaa131,glaa132,glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,
                         glaa140,glaa123,glaa124,glaa028 INTO g_glaa.* 
                  #161215-00044#1---modify----end---------------
               FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_fabg_m.fabgld
  
               IF NOT s_aooi200_fin_chk_slip(g_fabg_m.fabgld,g_glaa.glaa024,g_fabg_m.fabgdocno,'afat507') THEN
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
         BEFORE FIELD fabgdocdt
            #add-point:BEFORE FIELD fabgdocdt name="input.b.fabgdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabgdocdt
            
            #add-point:AFTER FIELD fabgdocdt name="input.a.fabgdocdt"
            IF NOT cl_null(g_fabg_m.fabgdocdt) THEN
              #IF p_cmd = 'a'  OR (g_fabg_m.fabgdocdt <> g_fabg_m_t.fabgdocdt OR cl_null(g_fabg_m_t.fabgdocdt)) THEN   #160824-00007#248 161208 by lori mark
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_fabg_m.fabgdocdt <> g_fabg_m_t.fabgdocdt) OR cl_null(g_fabg_m_t.fabgdocdt)) THEN   #160824-00007#248 161208 by lori add
                  IF NOT cl_null(l_para_data) AND g_fabg_m.fabgdocdt<=l_para_data THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "afa-00060"
                     LET g_errparam.extend = g_fabg_m.fabgdocdt
                     LET g_errparam.popup = FALSE
                     CALL cl_err()
                     
                     LET g_fabg_m.fabgdocdt = g_fabg_m_t.fabgdocdt
                     NEXT FIELD fabgdocdt
                  END IF
                  #20141213 add by chenying
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
                  #20141213 add by chenying
               END IF
  
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabgdocdt
            #add-point:ON CHANGE fabgdocdt name="input.g.fabgdocdt"
            
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
            LET g_qryparam.where = " ooef207 = 'Y' "  
 
           # CALL q_ooef001()                       #呼叫開窗            #161024-00008#4 
            CALL q_ooef001_47()                                         #161024-00008#4 

            LET g_fabg_m.fabgsite = g_qryparam.return1              #將開窗取得的值回傳到變數

            CALL afat507_get_fabgsite_desc()            
            
            DISPLAY g_fabg_m.fabgsite TO fabgsite              #顯示到畫面上
            DISPLAY g_fabg_m.fabgsite_desc TO fabgsite_desc
        

            LET g_qryparam.where = ""
             
            NEXT FIELD fabgsite                          #返回原欄位


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

            CALL q_ooag001()                                #呼叫開窗

            LET g_fabg_m.fabg002 = g_qryparam.return1              #將開窗取得的值回傳到變數

            CALL afat507_get_fabg002_desc()

            DISPLAY g_fabg_m.fabg002 TO fabg002              #顯示到畫面上
            DISPLAY g_fabg_m.fabg002_desc TO fabg002_desc
 

            NEXT FIELD fabg002                          #返回原欄位


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

#            IF NOT cl_null(g_fabg_m.fabgsite) THEN 
#               LET g_qryparam.where = " ooag004 IN (SELECT faab004 FROM faab_t WHERE faabent =  '",g_enterprise,"' AND faab001 = '4' AND faab002 = '",g_fabg_m.fabgsite,"' AND faab007 = 'Y' AND faabstus = 'Y' )"
#            END IF

            #給予arg

            CALL q_ooag001()                                #呼叫開窗

            LET g_fabg_m.fabg001 = g_qryparam.return1              #將開窗取得的值回傳到變數

            CALL afat507_get_fabg001_desc()

            DISPLAY g_fabg_m.fabg001 TO fabg001              #顯示到畫面上
            DISPLAY g_fabg_m.fabg001_desc TO fabg001_desc
         
            LET g_qryparam.where = ""

            NEXT FIELD fabg001                          #返回原欄位


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

                    #CALL q_ooef001_9()                                #呼叫開窗 #161024-00008#4
            LET g_qryparam.arg1 = g_fabg_m.fabg004                      #161024-00008#4
            CALL q_ooeg001_4()                                          #161024-00008#4 

            LET g_fabg_m.fabg003 = g_qryparam.return1              #將開窗取得的值回傳到變數

            CALL afat507_get_fabg003_desc()

            DISPLAY g_fabg_m.fabg003 TO fabg003             #顯示到畫面上
            DISPLAY g_fabg_m.fabg003_desc TO fabg003_desc
           

            NEXT FIELD fabg003                          #返回原欄位


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
            CALL afat507_change_to_sql(l_origin_str) RETURNING l_origin_str  
            
            LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') AND glaacomp IN (",l_origin_str," )"
            #給予arg
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept

            CALL q_authorised_ld()                                #呼叫開窗

            LET g_fabg_m.fabgld = g_qryparam.return1              #將開窗取得的值回傳到變數
            
            CALL afat507_get_fabgld_desc()

            DISPLAY g_fabg_m.fabgld TO fabgld              #顯示到畫面上
            DISPLAY g_fabg_m.fabgld_desc TO fabgld_desc

            NEXT FIELD fabgld                          #返回原欄位


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
 
 
         #Ctrlp:input.c.fabg008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabg008
            #add-point:ON ACTION controlp INFIELD fabg008 name="input.c.fabg008"
            
            #END add-point
 
 
         #Ctrlp:input.c.fabgdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabgdocno
            #add-point:ON ACTION controlp INFIELD fabgdocno name="input.c.fabgdocno"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabg_m.fabgdocno             #給予default值

            #給予arg
#            SELECT ooef004 INTO l_ooef004 from ooef_t,ooag_t
#             WHERE ooefent=ooagent AND ooefent = g_enterprise
#               AND ooef001 = ooag004 AND ooag001 = g_user
#
#            LET g_qryparam.arg1 = l_ooef004
             #161215-00044#1---modify----begin-----------------
             #SELECT * INTO g_glaa.* 
             SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,
                    glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,glaa011,
                    glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,glaa023,
                    glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,glaa113,glaa120,glaa121,
                    glaa122,glaa027,glaa130,glaa131,glaa132,glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,
                    glaa140,glaa123,glaa124,glaa028 INTO g_glaa.* 
             #161215-00044#1---modify----end--------------- 
            FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_fabg_m.fabgld
            LET g_qryparam.arg1 = g_glaa.glaa024            
            #LET g_qryparam.arg2 = "afat507"     #160705-00042#1 160711 by sakura mark
            LET g_qryparam.arg2 = g_prog         #160705-00042#1 160711 by sakura add
            #161104-00046#16 --s add
            IF NOT cl_null(g_user_slip_wc)THEN
               LET g_qryparam.where = g_user_slip_wc
            END IF
            #161104-00046#16 --e add
            CALL q_ooba002_1()                                #呼叫開窗

            LET g_fabg_m.fabgdocno = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_fabg_m.fabgdocno TO fabgdocno              #顯示到畫面上

            NEXT FIELD fabgdocno                          #返回原欄位 
            #END add-point
 
 
         #Ctrlp:input.c.fabg009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabg009
            #add-point:ON ACTION controlp INFIELD fabg009 name="input.c.fabg009"
            
            #END add-point
 
 
         #Ctrlp:input.c.fabgdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabgdocdt
            #add-point:ON ACTION controlp INFIELD fabgdocdt name="input.c.fabgdocdt"
            
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
#            #單據日期不能小於關賬日期
#            #S-FIN-9003
#            SELECT * INTO g_glaa.* FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_fabg_m.fabgld
#            SELECT ooab002 INTO l_ooab002 FROM ooab_t
#             WHERE ooabent = g_enterprise
#               AND ooab001 = 'S-FIN-9003'
#               AND ooabsite = g_glaa.glaacomp 
#            IF g_fabg_m.fabgdocdt <= l_ooab002 THEN 
#               INITIALIZE g_errparam TO NULL
#               LET g_errparam.code = 'afa-00060'
#               LET g_errparam.extend = ''
#               LET g_errparam.popup = TRUE
#               CALL cl_err()
#
#               NEXT FIELD fabgdocdt
#            END IF
#            
#            #现行年月检查
#            CALL cl_get_para(g_enterprise,g_glaa.glaacomp,'S-FIN-9018') RETURNING l_year
#            CALL cl_get_para(g_enterprise,g_glaa.glaacomp,'S-FIN-9019') RETURNING l_month
#            IF l_year <> YEAR(g_fabg_m.fabgdocdt) OR l_month <> MONTH(g_fabg_m.fabgdocdt) THEN
#               INITIALIZE g_errparam TO NULL
#               LET g_errparam.code = 'afa-00283'
#               LET g_errparam.extend = ''
#               LET g_errparam.popup = TRUE
#               CALL cl_err()
#               
#               NEXT FIELD fabgdocdt
#            END IF      

            #160108-00008#1 add--str--
            IF NOT cl_null(g_fabg_m.fabgdocdt) THEN
                #161215-00044#1---modify----begin-----------------
                #SELECT * INTO g_glaa.* 
                SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,
                       glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,glaa011,
                       glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,glaa023,
                       glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,glaa113,glaa120,glaa121,
                       glaa122,glaa027,glaa130,glaa131,glaa132,glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,
                       glaa140,glaa123,glaa124,glaa028 INTO g_glaa.* 
                #161215-00044#1---modify----end--------------- 
               FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_fabg_m.fabgld 
               CALL cl_get_para(g_enterprise,g_glaa.glaacomp,'S-FIN-9003') RETURNING l_para_data             
               IF NOT cl_null(l_para_data) AND g_fabg_m.fabgdocdt<=l_para_data THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "afa-00060"
                  LET g_errparam.extend = g_fabg_m.fabgdocdt
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
                  
                  LET g_fabg_m.fabgdocdt = ''
                  NEXT FIELD fabgdocdt
               END IF
             
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
            #160108-00008#1 add--end--
            
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
                #161215-00044#1---modify----end---------------
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
               
               INSERT INTO fabg_t (fabgent,fabgsite,fabg002,fabg001,fabg003,fabgld,fabg004,fabg005,fabg008, 
                   fabgdocno,fabg009,fabgdocdt,fabgstus,fabgownid,fabgowndp,fabgcrtid,fabgcrtdp,fabgcrtdt, 
                   fabgmodid,fabgmoddt,fabgcnfid,fabgcnfdt)
               VALUES (g_enterprise,g_fabg_m.fabgsite,g_fabg_m.fabg002,g_fabg_m.fabg001,g_fabg_m.fabg003, 
                   g_fabg_m.fabgld,g_fabg_m.fabg004,g_fabg_m.fabg005,g_fabg_m.fabg008,g_fabg_m.fabgdocno, 
                   g_fabg_m.fabg009,g_fabg_m.fabgdocdt,g_fabg_m.fabgstus,g_fabg_m.fabgownid,g_fabg_m.fabgowndp, 
                   g_fabg_m.fabgcrtid,g_fabg_m.fabgcrtdp,g_fabg_m.fabgcrtdt,g_fabg_m.fabgmodid,g_fabg_m.fabgmoddt, 
                   g_fabg_m.fabgcnfid,g_fabg_m.fabgcnfdt) 
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
               SELECT glaa001,glaacomp INTO l_glaa001,l_glaacomp FROM glaa_t
                WHERE glaaent = g_enterprise AND glaald = g_fabg_m.fabgld
                
               UPDATE fabg_t SET fabg015 = l_glaa001,
                                 fabg016 = 1,
                                 fabgcomp = l_glaacomp
                           WHERE fabgent = g_enterprise
                             AND fabgld = g_fabg_m.fabgld
                             AND fabgdocno = g_fabg_m.fabgdocno
               #end add-point
               
               
               
               
               #add-point:單頭新增後 name="input.head.a_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL afat507_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL afat507_b_fill()
                  CALL afat507_b_fill2('0')
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
               CALL afat507_fabg_t_mask_restore('restore_mask_o')
               
               UPDATE fabg_t SET (fabgsite,fabg002,fabg001,fabg003,fabgld,fabg004,fabg005,fabg008,fabgdocno, 
                   fabg009,fabgdocdt,fabgstus,fabgownid,fabgowndp,fabgcrtid,fabgcrtdp,fabgcrtdt,fabgmodid, 
                   fabgmoddt,fabgcnfid,fabgcnfdt) = (g_fabg_m.fabgsite,g_fabg_m.fabg002,g_fabg_m.fabg001, 
                   g_fabg_m.fabg003,g_fabg_m.fabgld,g_fabg_m.fabg004,g_fabg_m.fabg005,g_fabg_m.fabg008, 
                   g_fabg_m.fabgdocno,g_fabg_m.fabg009,g_fabg_m.fabgdocdt,g_fabg_m.fabgstus,g_fabg_m.fabgownid, 
                   g_fabg_m.fabgowndp,g_fabg_m.fabgcrtid,g_fabg_m.fabgcrtdp,g_fabg_m.fabgcrtdt,g_fabg_m.fabgmodid, 
                   g_fabg_m.fabgmoddt,g_fabg_m.fabgcnfid,g_fabg_m.fabgcnfdt)
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
               CALL afat507_fabg_t_mask_restore('restore_mask_n')
               
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
 
{<section id="afat507.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_fabh_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_fabi
            LET g_action_choice="open_fabi"
            IF cl_auth_chk_act("open_fabi") THEN
               
               #add-point:ON ACTION open_fabi name="input.detail_input.page1.open_fabi"
               #20141118 add--str--
               LET l_n = 0
               SELECT COUNT(*) INTO l_n FROM faai_t 
                WHERE faaient = g_enterprise AND faai001 = g_fabh_d[l_ac].fabh000
                  AND faai002 = g_fabh_d[l_ac].fabh001 AND faai003 = g_fabh_d[l_ac].fabh002
               IF l_n > 0 THEN                  
               #20141118 add--end--                
                  CALL afat440_01(l_cmd,g_fabh_d[l_ac].fabhseq,g_fabh_d[l_ac].fabh001,g_fabh_d[l_ac].fabh002,g_fabh_d[l_ac].fabh000,g_fabg_m.fabg005,g_fabg_m.fabgdocno,'')
               END IF #20141118   
               #END add-point
            END IF
 
 
 
 
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
              LET l_n = 0
            SELECT COUNT(*) INTO l_n FROM fabh_t
             WHERE fabhent = g_enterprise AND fabhdocno = g_fabg_m.fabgdocno AND fabhld = g_fabg_m.fabgld
            IF l_n = 0 THEN
               IF cl_ask_confirm('afa-00249') THEN
                  CALL afat502_03(g_fabg_m.fabgdocno,g_fabg_m.fabgld,g_fabg_m.fabg005)
               END IF
            END IF  
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_fabh_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL afat507_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1','2',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_fabh_d.getLength()
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
            OPEN afat507_cl USING g_enterprise,g_fabg_m.fabgld,g_fabg_m.fabgdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN afat507_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE afat507_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_fabh_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_fabh_d[l_ac].fabhseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_fabh_d_t.* = g_fabh_d[l_ac].*  #BACKUP
               LET g_fabh_d_o.* = g_fabh_d[l_ac].*  #BACKUP
               CALL afat507_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL afat507_set_no_entry_b(l_cmd)
               IF NOT afat507_lock_b("fabh_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH afat507_bcl INTO g_fabh_d[l_ac].fabhseq,g_fabh_d[l_ac].fabh001,g_fabh_d[l_ac].fabh002, 
                      g_fabh_d[l_ac].fabh000,g_fabh_d[l_ac].fabh005,g_fabh_d[l_ac].fabh006,g_fabh_d[l_ac].fabh007, 
                      g_fabh_d[l_ac].fabh015,g_fabh_d[l_ac].fabh008,g_fabh_d[l_ac].fabh011,g_fabh_d[l_ac].fabh004, 
                      g_fabh_d[l_ac].fabh017,g_fabh_d[l_ac].fabh073,g_fabh_d[l_ac].fabh020,g_fabh_d[l_ac].fabh003, 
                      g_fabh_d[l_ac].fabh023,g_fabh_d[l_ac].fabh024,g_fabh_d[l_ac].fabh025,g_fabh3_d[l_ac].fabhseq, 
                      g_fabh3_d[l_ac].fabh100,g_fabh3_d[l_ac].fabh101,g_fabh3_d[l_ac].fabh102,g_fabh3_d[l_ac].fabh104, 
                      g_fabh3_d[l_ac].fabh108,g_fabh3_d[l_ac].fabh109,g_fabh3_d[l_ac].fabh111,g_fabh3_d[l_ac].fabh150, 
                      g_fabh3_d[l_ac].fabh151,g_fabh3_d[l_ac].fabh152,g_fabh3_d[l_ac].fabh154,g_fabh3_d[l_ac].fabh158, 
                      g_fabh3_d[l_ac].fabh159,g_fabh3_d[l_ac].fabh161
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_fabh_d_t.fabhseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_fabh_d_mask_o[l_ac].* =  g_fabh_d[l_ac].*
                  CALL afat507_fabh_t_mask()
                  LET g_fabh_d_mask_n[l_ac].* =  g_fabh_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL afat507_show()
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
            INITIALIZE g_fabh_d[l_ac].* TO NULL 
            INITIALIZE g_fabh_d_t.* TO NULL 
            INITIALIZE g_fabh_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_fabh_d[l_ac].fabh015 = "0"
      LET g_fabh_d[l_ac].fabh073 = "0"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            
            #end add-point
            LET g_fabh_d_t.* = g_fabh_d[l_ac].*     #新輸入資料
            LET g_fabh_d_o.* = g_fabh_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL afat507_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL afat507_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_fabh_d[li_reproduce_target].* = g_fabh_d[li_reproduce].*
               LET g_fabh3_d[li_reproduce_target].* = g_fabh3_d[li_reproduce].*
 
               LET g_fabh_d[li_reproduce_target].fabhseq = NULL
 
            END IF
            
 
 
            #add-point:modify段before insert name="input.body.before_insert"
            SELECT MAX(fabhseq)+1 INTO g_fabh_d[l_ac].fabhseq 
              FROM fabh_t 
             WHERE fabhdocno = g_fabg_m.fabgdocno  
               AND fabhld = g_fabg_m.fabgld
               AND fabhent = g_enterprise
            IF cl_null(g_fabh_d[l_ac].fabhseq) THEN 
               LET g_fabh_d[l_ac].fabhseq = 1 
            END IF 
            
            CALL afat507_visible()
 
            #20150608--add--str--lujh
            IF  cl_null(g_fabh_d[l_ac].fabh002) THEN 
               LET g_fabh_d[l_ac].fabh002=' ' 
            END IF
            #20150608--add--end--lujh
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
            SELECT COUNT(1) INTO l_count FROM fabh_t 
             WHERE fabhent = g_enterprise AND fabhld = g_fabg_m.fabgld
               AND fabhdocno = g_fabg_m.fabgdocno
 
               AND fabhseq = g_fabh_d[l_ac].fabhseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fabg_m.fabgld
               LET gs_keys[2] = g_fabg_m.fabgdocno
               LET gs_keys[3] = g_fabh_d[g_detail_idx].fabhseq
               CALL afat507_insert_b('fabh_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_fabh_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "fabh_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL afat507_b_fill()
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               #20141118 add--str--
               LET l_n = 0
               SELECT COUNT(*) INTO l_n FROM faai_t 
                WHERE faaient = g_enterprise AND faai001 = g_fabh_d[l_ac].fabh000
                  AND faai002 = g_fabh_d[l_ac].fabh001 AND faai003 = g_fabh_d[l_ac].fabh002
               IF l_n > 0 THEN                  
               #20141118 add--end--                
                  IF l_cmd = 'a' AND NOT cl_null(g_fabh_d[l_ac].fabh001) AND NOT cl_null(g_fabh_d[l_ac].fabh002) AND NOT cl_null(g_fabh_d[l_ac].fabh000) THEN
                     CALL afat440_01(l_cmd,g_fabh_d[l_ac].fabhseq,g_fabh_d[l_ac].fabh001,g_fabh_d[l_ac].fabh002,g_fabh_d[l_ac].fabh000,g_fabg_m.fabg005,g_fabg_m.fabgdocno,'')
                  END IF
               END IF #20141118 

               #20141219 add by chenying
               #预设afai090摘要
               IF NOT cl_null(g_fabh_d[l_ac].fabh020) THEN
                  #150916--s
                  #有維護摘要就不取設定的摘要
                  LET l_oocq009 = ''
                  SELECT fabh036 INTO l_oocq009 FROM fabh_t 
                   WHERE fabhent = g_enterprise AND fabhld = g_fabg_m.fabgld
                     AND fabhdocno = g_fabg_m.fabgdocno               
                     AND fabhseq = g_fabh_d_t.fabhseq
                  IF cl_null(l_oocq009) THEN
                  #150916--e
                     LET l_oocq009 = ''
                     SELECT oocq009 INTO l_oocq009 FROM oocq_t 
                      WHERE oocqent=g_enterprise AND oocq001='3902' AND oocq002=g_fabh_d[l_ac].fabh020
                  END IF   #150916 
                  UPDATE fabh_t SET fabh036 = l_oocq009
                   WHERE fabhent = g_enterprise 
                     AND fabhld  = g_fabg_m.fabgld 
                     AND fabhdocno = g_fabg_m.fabgdocno 
                     AND fabhseq = g_fabh_d[l_ac].fabhseq #項次 
                  CASE
                     WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = "fabh_t" 
                        LET g_errparam.code   = "std-00009" 
                        LET g_errparam.popup  = TRUE 
                        CALL cl_err()
                        CALL s_transaction_end('N','0')
                        CANCEL INSERT
                     WHEN SQLCA.sqlcode #其他錯誤
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = "fabh_t" 
                        LET g_errparam.code   = SQLCA.sqlcode 
                        LET g_errparam.popup  = TRUE 
                        CALL cl_err()                   
                        CALL s_transaction_end('N','0')
                        CANCEL INSERT
                  END CASE 
               END IF                  
               #20141219 add by chenying
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
 
               LET gs_keys[gs_keys.getLength()+1] = g_fabh_d_t.fabhseq
 
            
               #刪除同層單身
               IF NOT afat507_delete_b('fabh_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE afat507_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT afat507_key_delete_b(gs_keys,'fabh_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE afat507_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE afat507_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_fabh_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_fabh_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabhseq
            #add-point:BEFORE FIELD fabhseq name="input.b.page1.fabhseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabhseq
            
            #add-point:AFTER FIELD fabhseq name="input.a.page1.fabhseq"
            #此段落由子樣板a05產生
            IF  g_fabg_m.fabgld IS NOT NULL AND g_fabg_m.fabgdocno IS NOT NULL AND g_fabh_d[g_detail_idx].fabhseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_fabg_m.fabgld != g_fabgld_t OR g_fabg_m.fabgdocno != g_fabgdocno_t OR g_fabh_d[g_detail_idx].fabhseq != g_fabh_d_t.fabhseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM fabh_t WHERE "||"fabhent = '" ||g_enterprise|| "' AND "||"fabhld = '"||g_fabg_m.fabgld ||"' AND "|| "fabhdocno = '"||g_fabg_m.fabgdocno ||"' AND "|| "fabhseq = '"||g_fabh_d[g_detail_idx].fabhseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabhseq
            #add-point:ON CHANGE fabhseq name="input.g.page1.fabhseq"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh001
            
            #add-point:AFTER FIELD fabh001 name="input.a.page1.fabh001"
#            IF NOT cl_null(g_fabh_d[l_ac].fabh001) THEN 
##此段落由子樣板a19產生
#               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
#               INITIALIZE g_chkparam.* TO NULL
#               
#               #設定g_chkparam.*的參數
#               LET g_chkparam.arg1 = g_fabh_d[l_ac].fabh001
#
#                  
#               #呼叫檢查存在並帶值的library
#               IF cl_chk_exist("v_faah003") THEN
#                  #檢查成功時後續處理
#                  #LET  = g_chkparam.return1
#                  #DISPLAY BY NAME 
#
#               ELSE
#                  #檢查失敗時後續處理
#                  LET g_fabh_d[l_ac].fabh001 = g_fabh_d_t.fabh001                  
#                  DISPLAY BY NAME g_fabh_d[l_ac].fabh001 
#                  NEXT FIELD CURRENT
#               END IF
#            
#
#            END IF 
#            
#            IF NOT cl_null(g_fabh_d[l_ac].fabh002) AND NOT cl_null(g_fabh_d[l_ac].fabh001) THEN
#               LET l_n1 = 0             
#               CALL afat507_check_fabgld() RETURNING l_n1
#               IF l_n1 = 0 THEN 
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = 'afa-00104'
#                  LET g_errparam.extend = ''
#                  LET g_errparam.popup = TRUE
#                  CALL cl_err()
#             
#               END IF 
#               
#               #資產狀態為取得\出售\停用\被資本化時不可銷賬
#               LET l_n2 = 0
#               SELECT COUNT(*) INTO l_n2 FROM faah_t
#                WHERE faah003 = g_fabh_d[l_ac].fabh001
#                  AND faah004 = g_fabh_d[l_ac].fabh002
#                  AND faah001 = g_fabh_d[l_ac].fabh000
#                  AND faah015 IN ('0','5','6','10')
#               IF l_n2 >0 THEN 
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = 'afa-00195'
#                  LET g_errparam.extend = ''
#                  LET g_errparam.popup = TRUE
#                  CALL cl_err()
# 
#                  LET g_fabh_d[l_ac].fabh001 = g_fabh_d_t.fabh001
#                  NEXT FIELD fabh001
#               END IF 
#               
#              #當前銷賬單，卡片+財產編號+附號不可重複
#              LET l_n3 = 0
#              SELECT COUNT(*) INTO l_n3 FROM fabh_t
#               WHERE fabhent = g_enterprise
#                 AND fabhdocno = g_fabg_m.fabgdocno
#                 AND fabh001 = g_fabh_d[l_ac].fabh001 
#                 AND fabh002 = g_fabh_d[l_ac].fabh002
#                 AND fabh000 = g_fabh_d[l_ac].fabh000
#               IF l_n3 >= 1 AND (l_cmd = 'a' OR (l_cmd = 'u' AND (g_fabh_d[l_ac].fabh001 != g_fabh_d_t.fabh001 OR g_fabh_d[l_ac].fabh002 != g_fabh_d_t.fabh002 OR g_fabh_d[l_ac].fabh000 != g_fabh_d_t.fabh000 ))) THEN
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = 'afa-00194'
#                  LET g_errparam.extend = ''
#                  LET g_errparam.popup = TRUE
#                  CALL cl_err()
# 
#                  LET g_fabh_d[l_ac].fabh001 = g_fabh_d_t.fabh001
#                  NEXT FIELD fabh001                
#               END IF 
#
#               #當月已有折舊不可輸入
#               LET l_n4 = 0
#                SELECT COUNT(*) INTO l_n4 FROM faam_t
#                WHERE faam001 = g_fabh_d[l_ac].fabh001
#                  AND faam002 = g_fabh_d[l_ac].fabh002
#                  AND faam000 = g_fabh_d[l_ac].fabh000
#                  AND faament = g_enterprise
#                  AND faamld = g_fabg_m.fabgld                   
#                  AND faam005 = MONTH(g_fabg_m.fabgdocno)
#              IF l_n4 >= 1 THEN 
#                 INITIALIZE g_errparam TO NULL
#                 LET g_errparam.code = 'afa-00110'
#                 LET g_errparam.extend = ''
#                 LET g_errparam.popup = TRUE
#                 CALL cl_err()
#
#                 LET g_fabh_d[l_ac].fabh001 = g_fabh_d_t.fabh001
#                 NEXT FIELD fabh001  
#              END IF       
#               
#               
#               #獲取單位、數量、部門
#               CALL afat507_get_faah()
#               
#               #預設銷賬數量
#               #獲取成本、累計折舊、未折減額、已提列減值、預算編號、專案編號、wbs、客商編號
#               CALL afat507_get_faaj()
#               
#               #獲取本位幣
#               CALL afat507_get_faaj_1()
#               
# 
#            END IF
#

#            IF NOT cl_null(g_fabh_d[l_ac].fabh001) THEN
#               IF l_cmd = 'a' OR ( g_fabh_d[l_ac].fabh001 <> g_fabh_d_t.fabh001 OR cl_null(g_fabh_d_t.fabh001)) THEN
#               #此段落由子樣板a19產生
#                  #校驗代值
#                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
#                  INITIALIZE g_chkparam.* TO NULL
#                  
#                  #設定g_chkparam.*的參數
#                  LET g_chkparam.arg1 = g_fabh_d[l_ac].fabh001
#                  LET g_chkparam.arg2 = g_fabh_d[l_ac].fabh002
#                  LET g_chkparam.arg3 = g_fabh_d[l_ac].fabh000                     
#                  #呼叫檢查存在並帶值的library
#                  IF cl_chk_exist("v_faah003") THEN
#                     #檢查成功時後續處理
#                     #LET  = g_chkparam.return1
#                     #DISPLAY BY NAME
#                     #20141213 add by chenying   
#                     IF NOT s_afat503_fixed_chk(g_fabh_d[l_ac].fabh001,g_fabh_d[l_ac].fabh002,g_fabh_d[l_ac].fabh000,"afat507",g_fabg_m.fabgld,'',g_fabg_m.fabgdocdt) THEN
#                        LET g_fabh_d[l_ac].fabh001 = g_fabh_d_t.fabh001
#                        NEXT FIELD CURRENT 
#                     END IF
#                     #20141213 add by chenying
##                     CALL afat507_fabh001_chk()
##                     IF NOT cl_null(g_errno) THEN
##                        INITIALIZE g_errparam TO NULL
##                        LET g_errparam.code = g_errno
##                        LET g_errparam.extend = g_fabh_d[l_ac].fabh001
##                        LET g_errparam.popup = FALSE
##                        CALL cl_err()
##                        LET g_fabh_d[l_ac].fabh001=g_fabh_d_t.fabh001
##                        LET g_fabh_d[l_ac].fabh002=g_fabh_d_t.fabh002
##                        LET g_fabh_d[l_ac].fabh000=g_fabh_d_t.fabh000
##                        NEXT FIELD fabh001
##                     ELSE
#                       
##                     END IF
#                  ELSE
#                     #檢查失敗時後續處理
#                     LET g_fabh_d[l_ac].fabh001=g_fabh_d_t.fabh001
#                     LET g_fabh_d[l_ac].fabh002=g_fabh_d_t.fabh002
#                     LET g_fabh_d[l_ac].fabh000=g_fabh_d_t.fabh000
#                     NEXT FIELD CURRENT
#                  END IF
#                  CALL afat507_faid_chk() RETURNING l_success
#                  IF NOT l_success THEN
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#            END IF 

            IF NOT cl_null(g_fabh_d[l_ac].fabh001) THEN   #160824-00007#248 161208 by lori add
               IF g_fabh_d[l_ac].fabh001 <> g_fabh_d_o.fabh001 OR cl_null(g_fabh_d_o.fabh001) THEN   #160824-00007#248 161208 by lori add
                 #IF NOT cl_null(g_fabh_d[l_ac].fabh001) AND g_fabh_d[l_ac].fabh002 IS NOT NULL AND NOT cl_null(g_fabh_d[l_ac].fabh000) THEN   #160824-00007#248 161208 by lori mark
                  IF g_fabh_d[l_ac].fabh002 IS NOT NULL AND NOT cl_null(g_fabh_d[l_ac].fabh000) THEN   #160824-00007#248 161208 by lori add
                     INITIALIZE g_chkparam.* TO NULL
                     #設定g_chkparam.*的參數
                     LET g_chkparam.arg1 = g_fabh_d[l_ac].fabh001
                     LET g_chkparam.arg2 = g_fabh_d[l_ac].fabh002
                     LET g_chkparam.arg3 = g_fabh_d[l_ac].fabh000
                     #160318-00025#5--add--str
                     LET g_errshow = TRUE 
                     LET g_chkparam.err_str[1] = "afa-00264:sub-01313|afai100|",cl_get_progname("afai100",g_lang,"2"),"|:EXEPROGafai100"
                     #160318-00025#5--add--end
                     #呼叫檢查存在並帶值的library
                     IF NOT cl_chk_exist("v_faah003_3") THEN
                        #檢查失敗時後續處理
                       #160824-00007#248 161208 by lori mod---(S)
                       #LET g_fabh_d[l_ac].fabh001 = g_fabh_d_t.fabh001   
                       #LET g_fabh_d[l_ac].fabh002 = g_fabh_d_t.fabh002   
                       #LET g_fabh_d[l_ac].fabh000 = g_fabh_d_t.fabh000  
                        LET g_fabh_d[l_ac].fabh001 = g_fabh_d_o.fabh001   
                        LET g_fabh_d[l_ac].fabh002 = g_fabh_d_o.fabh002   
                        LET g_fabh_d[l_ac].fabh000 = g_fabh_d_o.fabh000  
                       #160824-00007#248 161208 by lori mod---(E)                        
                        NEXT FIELD CURRENT
                     #20141213 add by chenying      
                     ELSE
                        IF NOT s_afat503_fixed_chk(g_fabh_d[l_ac].fabh001,g_fabh_d[l_ac].fabh002,g_fabh_d[l_ac].fabh000,"afat506",g_fabg_m.fabgld,'',g_fabg_m.fabgdocdt) THEN
                          #160824-00007#248 161208 by lori mod---(S)
                          #LET g_fabh_d[l_ac].fabh001 = g_fabh_d_t.fabh001  
                           LET g_fabh_d[l_ac].fabh001 = g_fabh_d_o.fabh001 
                          #160824-00007#248 161208 by lori mod---(E)                            
                           NEXT FIELD CURRENT 
                        END IF
                     #20141213 add by chenying 
                  
                        #20141224 add by chening
                        #检查是否存在未审核异动单据
                        CALL cl_err_collect_init()
                        CALL s_afat503_conf_ins_tab_chk(g_fabg_m.fabgdocno,g_fabg_m.fabgld,g_fabh_d[l_ac].fabh001,g_fabh_d[l_ac].fabh002,g_fabh_d[l_ac].fabh000) RETURNING r_success
                        IF r_success = FALSE THEN
                          #160824-00007#248 161208 by lori mod---(S)
                          #LET g_fabh_d[l_ac].fabh001 = g_fabh_d_t.fabh001  
                           LET g_fabh_d[l_ac].fabh001 = g_fabh_d_o.fabh001 
                          #160824-00007#248 161208 by lori mod---(E)                            
                           CALL cl_err_collect_show() 
                           NEXT FIELD CURRENT 
                        ELSE
                           CALL cl_err_collect_init()  
                           CALL cl_err_collect_show()                   
                        END IF
                        #20141224 add by chening 
                        
                        CALL afat507_faid_chk() RETURNING l_success
                        IF NOT l_success THEN
                          #160824-00007#248 161208 by lori mod---(S)
                          #LET g_fabh_d[l_ac].fabh001 = g_fabh_d_t.fabh001  
                           LET g_fabh_d[l_ac].fabh001 = g_fabh_d_o.fabh001 
                          #160824-00007#248 161208 by lori mod---(E)                            
                           NEXT FIELD CURRENT
                        END IF      
                  
                        #20150608--add--str--lujh
                        IF NOT cl_null(g_fabh_d[l_ac].fabh001) AND g_fabh_d[l_ac].fabh002 IS NOT NULL AND NOT cl_null(g_fabh_d[l_ac].fabh000) THEN 
                           CALL s_afa_faan_chk(g_fabg_m.fabgdocdt,g_fabh_d[l_ac].fabh000,g_fabh_d[l_ac].fabh001,g_fabh_d[l_ac].fabh002,g_fabg_m.fabgld) 
                           RETURNING l_success
                           
                           IF l_success = FALSE THEN 
                              INITIALIZE g_errparam TO NULL 
                              LET g_errparam.extend = ''
                              LET g_errparam.code   = 'afa-01026'
                              LET g_errparam.popup  = TRUE 
                              CALL cl_err()
                             #160824-00007#248 161208 by lori mod---(S)
                             #LET g_fabh_d[l_ac].fabh001 = g_fabh_d_t.fabh001  
                              LET g_fabh_d[l_ac].fabh001 = g_fabh_d_o.fabh001 
                             #160824-00007#248 161208 by lori mod---(E)                            
                              NEXT FIELD CURRENT
                           END IF
                        END IF
                        #20150608--add--end--lujh
                     END IF
                  END IF
                  
                  #160824-00007#248 161208 by lori add---(S)
                  CALL afat507_get_faah()
                  CALL afat507_get_faah025_faah026_desc()   #161115-00003#1--add
                  
                  #預設銷賬數量
                  #獲取成本、累計折舊、未折減額、已提列減值、預算編號、專案編號、wbs、客商編號
                  CALL afat507_get_faaj()
                  
                  #獲取本位幣
                  CALL afat507_get_faaj_1()                
                  #160824-00007#248 161208 by lori add---(E)
               END IF   #160824-00007#248 161208 by lori add   
            END IF      #160824-00007#248 161208 by lori add
            
            #160824-00007#248 161208 by lori mark---(S)   
            #IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_fabh_d[l_ac].fabh001 != g_fabh_d_t.fabh001 OR g_fabh_d[l_ac].fabh002 != g_fabh_d_t.fabh002 OR g_fabh_d[l_ac].fabh000 != g_fabh_d_t.fabh000)) THEN
            #   CALL afat507_get_faah()
            #   #161115-00003#1--add--s--
            #   CALL afat507_get_faah025_faah026_desc()
            #   #161115-00003#1--add--e--
            #   #預設銷賬數量
            #   #獲取成本、累計折舊、未折減額、已提列減值、預算編號、專案編號、wbs、客商編號
            #   CALL afat507_get_faaj()
            #   
            #   #獲取本位幣
            #   CALL afat507_get_faaj_1() 
            #END IF 
            #160824-00007#248 161208 by lori mark---(S)
            
            LET g_fabh_d_o.fabh001 = g_fabh_d[l_ac].fabh001   #160824-00007#248 161208 by lori add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh001
            #add-point:BEFORE FIELD fabh001 name="input.b.page1.fabh001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabh001
            #add-point:ON CHANGE fabh001 name="input.g.page1.fabh001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh002
            
            #add-point:AFTER FIELD fabh002 name="input.a.page1.fabh002"
            
#               IF NOT cl_null(g_fabh_d[l_ac].fabh001) THEN
#                  LET g_fabh_d[l_ac].fabh000 = ' '
#                  CALL afat502_faid_def()
#                  DISPLAY g_fabh_d[l_ac].fabh000 TO s_detail1[l_ac].fabh000

#                 #若不是開窗，直接輸入欄位時，需帶出當前停用單中未使用的資料
#                 LET l_n6 = 1
#                 LET l_n5 = 0
#		          
#                 SELECT COUNT(*) INTO l_n5 FROM faah_t    #符合條件的筆數
#                  WHERE faahent = g_enterprise
#                    AND faah004 = g_fabh_d[l_ac].fabh002
#                 LET l_sql = " SELECT faah001,faah003,faah004 FROM faah_t ",
#                             "  WHERE faahent = '",g_enterprise,"'",
#                             "    AND faah003 = '",g_fabh_d[l_ac].fabh001,"'",
#                             "    AND faah004 = '",g_fabh_d[l_ac].fabh002,"'",
#                             "    AND faah015 NOT IN ('0','5','6','8','10') ",
#                             "    AND faahstus = 'Y' ",
#                             "  ORDER BY faah001,faah003,faah004 "
#                 PREPARE afat507_pb7 FROM l_sql
#                 DECLARE afat507_cs7 CURSOR FOR afat507_pb7
#                 FOREACH afat507_cs7 INTO l_fabh000,l_fabh001,l_fabh002
#		          
#                   IF SQLCA.sqlcode THEN
#                      INITIALIZE g_errparam TO NULL
#                      LET g_errparam.code = SQLCA.sqlcode
#                      LET g_errparam.extend = "afat507_cs7"
#                      LET g_errparam.popup = TRUE
#                      CALL cl_err()
#               
#                      EXIT FOREACH
#                   END IF
#		          
#                   LET l_n4 = 0
#                   SELECT COUNT(*) INTO l_n4 FROM fabh_t
#                    WHERE fabhent = g_enterprise
#                      AND fabhdocno = g_fabg_m.fabgdocno
#                      AND fabh001 = l_fabh001
#                      AND fabh002 = l_fabh002
#                      AND fabh000 = l_fabh000
#                   IF l_n4 >=1 THEN
#                      LET l_n6 = l_n6 + 1  #存在重複資料時，繼續下一筆
#                      CONTINUE FOREACH
#                   ELSE
#                      LET g_fabh_d[l_ac].fabh000 = l_fabh000
#                      LET g_fabh_d[l_ac].fabh001 = l_fabh001
#                      LET g_fabh_d[l_ac].fabh002 = l_fabh002
#                      EXIT FOREACH
#                   END IF
#               END FOREACH 
#            END IF
            IF cl_null(g_fabh_d[l_ac].fabh002) THEN LET g_fabh_d[l_ac].fabh002=' ' END IF
            
            IF g_fabh_d[l_ac].fabh002 <> g_fabh_d_o.fabh002 OR g_fabh_d_o.fabh002 IS NULL THEN   #160824-00007#248 161208 by lori add
               IF NOT cl_null(g_fabh_d[l_ac].fabh001) AND NOT cl_null(g_fabh_d[l_ac].fabh000) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_fabh_d[l_ac].fabh001
                  LET g_chkparam.arg2 = g_fabh_d[l_ac].fabh002
                  LET g_chkparam.arg3 = g_fabh_d[l_ac].fabh000
                  #160318-00025#5--add--str
                  LET g_errshow = TRUE 
                  LET g_chkparam.err_str[1] = "afa-00264:sub-01313|afai100|",cl_get_progname("afai100",g_lang,"2"),"|:EXEPROGafai100"
                  #160318-00025#5--add--end
                  IF NOT cl_chk_exist("v_faah003_3") THEN
                     #檢查失敗時後續處理
                     #160824-00007#248 161208 by lori mod---(S)
                     #LET g_fabh_d[l_ac].fabh001 = g_fabh_d_t.fabh001   
                     #LET g_fabh_d[l_ac].fabh002 = g_fabh_d_t.fabh002   
                     #LET g_fabh_d[l_ac].fabh000 = g_fabh_d_t.fabh000  
                      LET g_fabh_d[l_ac].fabh001 = g_fabh_d_o.fabh001   
                      LET g_fabh_d[l_ac].fabh002 = g_fabh_d_o.fabh002   
                      LET g_fabh_d[l_ac].fabh000 = g_fabh_d_o.fabh000  
                     #160824-00007#248 161208 by lori mod---(E)                        
                      NEXT FIELD CURRENT
                  #20141213 add by chenying      
                  ELSE
                     IF NOT s_afat503_fixed_chk(g_fabh_d[l_ac].fabh001,g_fabh_d[l_ac].fabh002,g_fabh_d[l_ac].fabh000,"afat506",g_fabg_m.fabgld,'',g_fabg_m.fabgdocdt) THEN
                       #160824-00007#248 161208 by lori mod---(S)
                       #LET g_fabh_d[l_ac].fabh002 = g_fabh_d_t.fabh002   
                        LET g_fabh_d[l_ac].fabh002 = g_fabh_d_o.fabh002 
                       #160824-00007#248 161208 by lori mod---(E)                        
                        NEXT FIELD CURRENT 
                     END IF
                  #20141213 add by chenying   
               
                     #20141224 add by chening
                     #检查是否存在未审核异动单据
                     CALL cl_err_collect_init()  
                     CALL s_afat503_conf_ins_tab_chk(g_fabg_m.fabgdocno,g_fabg_m.fabgld,g_fabh_d[l_ac].fabh001,g_fabh_d[l_ac].fabh002,g_fabh_d[l_ac].fabh000) RETURNING r_success
                     IF r_success = FALSE THEN
                       #160824-00007#248 161208 by lori mod---(S)
                       #LET g_fabh_d[l_ac].fabh002 = g_fabh_d_t.fabh002   
                        LET g_fabh_d[l_ac].fabh002 = g_fabh_d_o.fabh002 
                       #160824-00007#248 161208 by lori mod---(E)                        
                        CALL cl_err_collect_show() 
                        NEXT FIELD CURRENT 
                     ELSE
                        CALL cl_err_collect_init()  
                        CALL cl_err_collect_show()                   
                     END IF
                     #20141224 add by chening 
                     
                     CALL afat507_faid_chk() RETURNING l_success
                     IF NOT l_success THEN
                       #160824-00007#248 161208 by lori mod---(S)
                       #LET g_fabh_d[l_ac].fabh002 = g_fabh_d_t.fabh002   
                        LET g_fabh_d[l_ac].fabh002 = g_fabh_d_o.fabh002 
                       #160824-00007#248 161208 by lori mod---(E)                        
                        NEXT FIELD CURRENT
                     END IF     
               
                     #20150608--add--str--lujh
                     IF NOT cl_null(g_fabh_d[l_ac].fabh001) AND g_fabh_d[l_ac].fabh002 IS NOT NULL AND NOT cl_null(g_fabh_d[l_ac].fabh000) THEN 
                        CALL s_afa_faan_chk(g_fabg_m.fabgdocdt,g_fabh_d[l_ac].fabh000,g_fabh_d[l_ac].fabh001,g_fabh_d[l_ac].fabh002,g_fabg_m.fabgld) 
                        RETURNING l_success
                        
                        IF l_success = FALSE THEN 
                           INITIALIZE g_errparam TO NULL 
                           LET g_errparam.extend = ''
                           LET g_errparam.code   = 'afa-01026'
                           LET g_errparam.popup  = TRUE 
                           CALL cl_err()
                          #160824-00007#248 161208 by lori mod---(S)
                          #LET g_fabh_d[l_ac].fabh002 = g_fabh_d_t.fabh002   
                           LET g_fabh_d[l_ac].fabh002 = g_fabh_d_o.fabh002 
                          #160824-00007#248 161208 by lori mod---(E)                        
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                     #20150608--add--end--lujh
                  END IF
               END IF
               
               #160824-00007#248 161208 by lori add---(S)
               CALL afat507_get_faah()
               CALL afat507_get_faah025_faah026_desc()   #161115-00003#1--add
               
               #預設銷賬數量
               #獲取成本、累計折舊、未折減額、已提列減值、預算編號、專案編號、wbs、客商編號
               CALL afat507_get_faaj()
               
               #獲取本位幣
               CALL afat507_get_faaj_1()                
               #160824-00007#248 161208 by lori add---(E)
            END IF   #160824-00007#248 161208 by lori add   
            
            #160824-00007#248 161208 by lori mark---(S)
            #IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_fabh_d[l_ac].fabh001 != g_fabh_d_t.fabh001 OR g_fabh_d[l_ac].fabh002 != g_fabh_d_t.fabh002 OR g_fabh_d[l_ac].fabh000 != g_fabh_d_t.fabh000)) THEN
            #   CALL afat507_get_faah()
            #   #161115-00003#1--add--s--
            #   CALL afat507_get_faah025_faah026_desc()
            #   #161115-00003#1--add--e--
            #   #預設銷賬數量
            #   #獲取成本、累計折舊、未折減額、已提列減值、預算編號、專案編號、wbs、客商編號
            #   CALL afat507_get_faaj()
            #   
            #   #獲取本位幣
            #   CALL afat507_get_faaj_1() 
            #END IF 
            #160824-00007#248 161208 by lori mark---(E)
            
            LET g_fabh_d_o.fabh002  = g_fabh_d[l_ac].fabh002   #160824-00007#248 161208 by lori add           
            
            
#            CALL afat507_fabh001_chk()
#            IF NOT cl_null(g_errno) THEN
#               INITIALIZE g_errparam TO NULL
#               LET g_errparam.code = g_errno
#               LET g_errparam.extend = g_fabh_d[l_ac].fabh001
#               LET g_errparam.popup = FALSE
#               CALL cl_err()
#               LET g_fabh_d[l_ac].fabh001=g_fabh_d_t.fabh001
#               LET g_fabh_d[l_ac].fabh002=g_fabh_d_t.fabh002
#               LET g_fabh_d[l_ac].fabh000=g_fabh_d_t.fabh000
#               NEXT FIELD fabh002
#            ELSE
#               CALL afat507_get_faah()
#                     #預設銷賬數量
#                     #獲取成本、累計折舊、未折減額、已提列減值、預算編號、專案編號、wbs、客商編號
#               CALL afat507_get_faaj()
#                        
#                     #獲取本位幣
#               CALL afat507_get_faaj_1()                        
##            END IF
#               
#            IF NOT cl_null(g_fabh_d[l_ac].fabh001) AND NOT cl_null(g_fabh_d[l_ac].fabh000) THEN
#               LET l_n1 = 0             
#               CALL afat507_check_fabgld() RETURNING l_n1
#               IF l_n1 = 0 THEN 
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = 'afa-00104'
#                  LET g_errparam.extend = ''
#                  LET g_errparam.popup = TRUE
#                  CALL cl_err()
#                  NEXT FIELD CURRENT  
#               END IF 
               
#               #資產狀態為取得\出售\停用\被資本化時不可銷賬
#               LET l_n2 = 0
#               SELECT COUNT(*) INTO l_n2 FROM faah_t
#                WHERE faah003 = g_fabh_d[l_ac].fabh001
#                  AND faah004 = g_fabh_d[l_ac].fabh002
#                  AND faah001 = g_fabh_d[l_ac].fabh000
#                  AND faah015 IN ('0','5','6','8','10')
#               IF l_n2 >0 THEN 
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = 'afa-00195'
#                  LET g_errparam.extend = ''
#                  LET g_errparam.popup = TRUE
#                  CALL cl_err()
# 
#                  LET g_fabh_d[l_ac].fabh002 = g_fabh_d_t.fabh002
#                  NEXT FIELD fabh002
#               END IF 
#               
#               #當前銷賬單，卡片+財產編號+附號不可重複
#               LET l_n3 = 0
#               SELECT COUNT(*) INTO l_n3 FROM fabh_t
#                WHERE fabhent = g_enterprise
#                  AND fabhdocno = g_fabg_m.fabgdocno
#                  AND fabh001 = g_fabh_d[l_ac].fabh001 
#                  AND fabh002 = g_fabh_d[l_ac].fabh002
#                  AND fabh000 = g_fabh_d[l_ac].fabh000
#               IF l_n3 >= 1 AND (l_cmd = 'a' OR (l_cmd = 'u' AND (g_fabh_d[l_ac].fabh001 != g_fabh_d_t.fabh001 OR g_fabh_d[l_ac].fabh002 != g_fabh_d_t.fabh002 OR g_fabh_d[l_ac].fabh000 != g_fabh_d_t.fabh000 ))) THEN
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = 'afa-00194'
#                  LET g_errparam.extend = ''
#                  LET g_errparam.popup = TRUE
#                  CALL cl_err()
# 
#                  LET g_fabh_d[l_ac].fabh002 = g_fabh_d_t.fabh002
#                  NEXT FIELD fabh002                
#               END IF  
#               
#               #當月已有折舊不可輸入
#               LET l_n4 = 0
#                SELECT COUNT(*) INTO l_n4 FROM faam_t
#                WHERE faam001 = g_fabh_d[l_ac].fabh001
#                  AND faam002 = g_fabh_d[l_ac].fabh002
#                  AND faam000 = g_fabh_d[l_ac].fabh000
#                  AND faament = g_enterprise
#                  AND faamld = g_fabg_m.fabgld                   
#                  AND faam005 = MONTH(g_fabg_m.fabgdocno)
#              IF l_n4 >= 1 THEN 
#                 INITIALIZE g_errparam TO NULL
#                 LET g_errparam.code = 'afa-00110'
#                 LET g_errparam.extend = ''
#                 LET g_errparam.popup = TRUE
#                 CALL cl_err()
#
#                 LET g_fabh_d[l_ac].fabh002 = g_fabh_d_t.fabh002
#                 NEXT FIELD fabh002  
#              END IF              
#              CALL afat507_faid_chk() RETURNING l_success
#              IF NOT l_success THEN
#                 NEXT FIELD CURRENT
#              END IF
#               
#               #獲取單位、數量、部門
#               CALL afat507_get_faah()
#               
#               #預設銷賬數量
#               #獲取成本、累計折舊、未折減額、已提列減值、預算編號、專案編號、wbs、客商編號
#               CALL afat507_get_faaj()
#               
#               CALL afat507_get_faaj_1()
#            END IF  
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh002
            #add-point:BEFORE FIELD fabh002 name="input.b.page1.fabh002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabh002
            #add-point:ON CHANGE fabh002 name="input.g.page1.fabh002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh000
            
            #add-point:AFTER FIELD fabh000 name="input.a.page1.fabh000"
#            IF (l_cmd = 'a' AND NOT cl_null(g_fabh_d[l_ac].fabh000) AND NOT cl_null(g_fabh_d[l_ac].fabh001)) 
#               OR (l_cmd = 'u' AND (g_fabh_d[l_ac].fabh000 != g_fabh_d_t.fabh000)) THEN
#                  LET g_fabh_d[l_ac].fabh000 = ' '
#                  CALL afat502_faid_def()
#                  DISPLAY g_fabh_d[l_ac].fabh000 TO s_detail1[l_ac].fabh000

#                 #若不是開窗，直接輸入欄位時，需帶出當前停用單中未使用的資料
#                 LET l_n6 = 1
#                 LET l_n5 = 0
#		          
#                 SELECT COUNT(*) INTO l_n5 FROM faah_t    #符合條件的筆數
#                  WHERE faahent = g_enterprise
#                    AND faah004 = g_fabh_d[l_ac].fabh000
#                 LET l_sql = " SELECT faah001,faah003,faah004 FROM faah_t ",
#                             "  WHERE faahent = '",g_enterprise,"'",
#                             "    AND faah001 = '",g_fabh_d[l_ac].fabh000,"'",
#                             "    AND faah003 = '",g_fabh_d[l_ac].fabh001,"'",
#                             "    AND faah015 NOT IN ('0','5','6','8','10') ",
#                             "    AND faahstus = 'Y' ",
#                             "  ORDER BY faah001,faah003,faah004 "
#                 PREPARE afat507_pb6 FROM l_sql
#                 DECLARE afat507_cs6 CURSOR FOR afat507_pb6
#                 FOREACH afat507_cs6 INTO l_fabh000,l_fabh001,l_fabh002
#		          
#                   IF SQLCA.sqlcode THEN
#                      INITIALIZE g_errparam TO NULL
#                      LET g_errparam.code = SQLCA.sqlcode
#                      LET g_errparam.extend = "afat507_cs6"
#                      LET g_errparam.popup = TRUE
#                      CALL cl_err()
#               
#                      EXIT FOREACH
#                   END IF
#		          
#                   LET l_n4 = 0
#                   SELECT COUNT(*) INTO l_n4 FROM fabh_t
#                    WHERE fabhent = g_enterprise
#                      AND fabhdocno = g_fabg_m.fabgdocno
#                      AND fabh001 = l_fabh001
#                      AND fabh002 = l_fabh002
#                      AND fabh000 = l_fabh000
#                   IF l_n4 >=1 THEN
#                      LET l_n6 = l_n6 + 1  #存在重複資料時，繼續下一筆
#                      CONTINUE FOREACH
#                   ELSE
#                      LET g_fabh_d[l_ac].fabh000 = l_fabh000
#                      LET g_fabh_d[l_ac].fabh001 = l_fabh001
#                      LET g_fabh_d[l_ac].fabh002 = l_fabh002
#                      EXIT FOREACH
#                   END IF
#               END FOREACH 
#            END IF
            IF g_fabh_d[l_ac].fabh000 <> g_fabh_d_o.fabh000 OR cl_null(g_fabh_d_o.fabh000) THEN   #160824-00007#248 161208 by lori add
               IF NOT cl_null(g_fabh_d[l_ac].fabh000) AND NOT cl_null(g_fabh_d[l_ac].fabh001) AND g_fabh_d[l_ac].fabh002 IS NOT NULL THEN 
                  INITIALIZE g_chkparam.* TO NULL
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_fabh_d[l_ac].fabh001
                  LET g_chkparam.arg2 = g_fabh_d[l_ac].fabh002
                  LET g_chkparam.arg3 = g_fabh_d[l_ac].fabh000
                  #160318-00025#5--add--str
                  LET g_errshow = TRUE 
                  LET g_chkparam.err_str[1] = "afa-00264:sub-01313|afai100|",cl_get_progname("afai100",g_lang,"2"),"|:EXEPROGafai100"
                  #160318-00025#5--add--end
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_faah003_3") THEN
                     #檢查失敗時後續處理
                     #160824-00007#248 161208 by lori mod---(S)
                     #LET g_fabh_d[l_ac].fabh001 = g_fabh_d_t.fabh001   
                     #LET g_fabh_d[l_ac].fabh002 = g_fabh_d_t.fabh002   
                     #LET g_fabh_d[l_ac].fabh000 = g_fabh_d_t.fabh000  
                      LET g_fabh_d[l_ac].fabh001 = g_fabh_d_o.fabh001   
                      LET g_fabh_d[l_ac].fabh002 = g_fabh_d_o.fabh002   
                      LET g_fabh_d[l_ac].fabh000 = g_fabh_d_o.fabh000  
                     #160824-00007#248 161208 by lori mod---(E)                        
                     NEXT FIELD CURRENT
                  #20141213 add by chenying      
                  ELSE
                     IF NOT s_afat503_fixed_chk(g_fabh_d[l_ac].fabh001,g_fabh_d[l_ac].fabh002,g_fabh_d[l_ac].fabh000,"afat506",g_fabg_m.fabgld,'',g_fabg_m.fabgdocdt) THEN
                       #160824-00007#248 161208 by lori mod---(S)
                       #LET g_fabh_d[l_ac].fabh000 = g_fabh_d_t.fabh000   
                        LET g_fabh_d[l_ac].fabh000 = g_fabh_d_o.fabh000  
                       #160824-00007#248 161208 by lori mod---(E)                        
                        NEXT FIELD CURRENT 
                     END IF
                  #20141213 add by chenying 
               
                     #20141224 add by chening
                     #检查是否存在未审核异动单据
                     CALL cl_err_collect_init() 
                     CALL s_afat503_conf_ins_tab_chk(g_fabg_m.fabgdocno,g_fabg_m.fabgld,g_fabh_d[l_ac].fabh001,g_fabh_d[l_ac].fabh002,g_fabh_d[l_ac].fabh000) RETURNING r_success
                     IF r_success = FALSE THEN
                       #160824-00007#248 161208 by lori mod---(S)
                       #LET g_fabh_d[l_ac].fabh000 = g_fabh_d_t.fabh000   
                        LET g_fabh_d[l_ac].fabh000 = g_fabh_d_o.fabh000  
                       #160824-00007#248 161208 by lori mod---(E)                        
                        CALL cl_err_collect_show() 
                        NEXT FIELD CURRENT
                     ELSE
                        CALL cl_err_collect_init()  
                        CALL cl_err_collect_show()                   
                     END IF
                     #20141224 add by chening 
                     
                     CALL afat507_faid_chk() RETURNING l_success
                     IF NOT l_success THEN
                       #160824-00007#248 161208 by lori mod---(S)
                       #LET g_fabh_d[l_ac].fabh000 = g_fabh_d_t.fabh000   
                        LET g_fabh_d[l_ac].fabh000 = g_fabh_d_o.fabh000  
                       #160824-00007#248 161208 by lori mod---(E)                        
                        NEXT FIELD CURRENT
                     END IF  
               
                     #20150608--add--str--lujh
                     IF NOT cl_null(g_fabh_d[l_ac].fabh001) AND g_fabh_d[l_ac].fabh002 IS NOT NULL AND NOT cl_null(g_fabh_d[l_ac].fabh000) THEN 
                        CALL s_afa_faan_chk(g_fabg_m.fabgdocdt,g_fabh_d[l_ac].fabh000,g_fabh_d[l_ac].fabh001,g_fabh_d[l_ac].fabh002,g_fabg_m.fabgld) 
                        RETURNING l_success
                        
                        IF l_success = FALSE THEN 
                           INITIALIZE g_errparam TO NULL 
                           LET g_errparam.extend = ''
                           LET g_errparam.code   = 'afa-01026'
                           LET g_errparam.popup  = TRUE 
                           CALL cl_err()
                          #160824-00007#248 161208 by lori mod---(S)
                          #LET g_fabh_d[l_ac].fabh000 = g_fabh_d_t.fabh000   
                           LET g_fabh_d[l_ac].fabh000 = g_fabh_d_o.fabh000  
                          #160824-00007#248 161208 by lori mod---(E)                        
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                     #20150608--add--end--lujh
                  END IF
               END IF
               
               #160824-00007#248 161208 by lori add---(S)
               CALL afat507_get_faah()
               CALL afat507_get_faah025_faah026_desc()   #161115-00003#1--add
               
               #預設銷賬數量
               #獲取成本、累計折舊、未折減額、已提列減值、預算編號、專案編號、wbs、客商編號
               CALL afat507_get_faaj()
               
               #獲取本位幣
               CALL afat507_get_faaj_1()                
               #160824-00007#248 161208 by lori add---(E)
            END IF    #160824-00007#248 161208 by lori add

            #160824-00007#248 161208 by lori mark---(S)
            #IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_fabh_d[l_ac].fabh001 != g_fabh_d_t.fabh001 OR g_fabh_d[l_ac].fabh002 != g_fabh_d_t.fabh002 OR g_fabh_d[l_ac].fabh000 != g_fabh_d_t.fabh000)) THEN
            #   CALL afat507_get_faah()
            #   #161115-00003#1--add--s--
            #   CALL afat507_get_faah025_faah026_desc()
            #   #161115-00003#1--add--e--
            #   #預設銷賬數量
            #   #獲取成本、累計折舊、未折減額、已提列減值、預算編號、專案編號、wbs、客商編號
            #   CALL afat507_get_faaj()
            #   
            #   #獲取本位幣
            #   CALL afat507_get_faaj_1() 
            #END IF 
            #160824-00007#248 161208 by lori mark---(E)
            
            LET g_fabh_d_o.fabh000 = g_fabh_d[l_ac].fabh000   #160824-00007#248 161208 by lori add

#            IF NOT cl_null(g_fabh_d[l_ac].fabh000) AND NOT cl_null(g_fabh_d[l_ac].fabh001) THEN
#               LET l_n1 = 0             
#               CALL afat507_check_fabgld() RETURNING l_n1
#               IF l_n1 = 0 THEN 
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = 'afa-00104'
#                  LET g_errparam.extend = ''
#                  LET g_errparam.popup = TRUE
#                  CALL cl_err()
#                
#               END IF 
               
#               #資產狀態為取得\出售\停用\被資本化時不可銷賬
#               LET l_n2 = 0
#               SELECT COUNT(*) INTO l_n2 FROM faah_t
#                WHERE faah003 = g_fabh_d[l_ac].fabh001
#                  AND faah004 = g_fabh_d[l_ac].fabh002
#                  AND faah001 = g_fabh_d[l_ac].fabh000
#                  AND faah015 IN ('0','5','6','8','10')
#               IF l_n2 >0 THEN 
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = 'afa-00195'
#                  LET g_errparam.extend = ''
#                  LET g_errparam.popup = TRUE
#                  CALL cl_err()
# 
#                  LET g_fabh_d[l_ac].fabh000 = g_fabh_d_t.fabh000
#                  NEXT FIELD fabh000
#               END IF 
               
#               #當前銷賬單，卡片+財產編號+附號不可重複
#               LET l_n3 = 0
#               SELECT COUNT(*) INTO l_n3 FROM fabh_t
#                WHERE fabhent = g_enterprise
#                  AND fabhdocno = g_fabg_m.fabgdocno
#                  AND fabh001 = g_fabh_d[l_ac].fabh001 
#                  AND fabh002 = g_fabh_d[l_ac].fabh002
#                  AND fabh000 = g_fabh_d[l_ac].fabh000
#               IF l_n3 >= 1 AND (l_cmd = 'a' OR (l_cmd = 'u' AND (g_fabh_d[l_ac].fabh001 != g_fabh_d_t.fabh001 OR g_fabh_d[l_ac].fabh002 != g_fabh_d_t.fabh002 OR g_fabh_d[l_ac].fabh000 != g_fabh_d_t.fabh000 ))) THEN
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = 'afa-00194'
#                  LET g_errparam.extend = ''
#                  LET g_errparam.popup = TRUE
#                  CALL cl_err()
# 
#                  LET g_fabh_d[l_ac].fabh000 = g_fabh_d_t.fabh000
#                  NEXT FIELD fabh000                
#               END IF  
               
#               #當月已有折舊不可輸入
#               LET l_n4 = 0
#                SELECT COUNT(*) INTO l_n4 FROM faam_t
#                WHERE faam001 = g_fabh_d[l_ac].fabh001
#                  AND faam002 = g_fabh_d[l_ac].fabh002
#                  AND faam000 = g_fabh_d[l_ac].fabh000
#                  AND faament = g_enterprise
#                  AND faamld = g_fabg_m.fabgld                   
#                  AND faam005 = MONTH(g_fabg_m.fabgdocno)
#              IF l_n4 >= 1 THEN 
#                 INITIALIZE g_errparam TO NULL
#                 LET g_errparam.code = 'afa-00110'
#                 LET g_errparam.extend = ''
#                 LET g_errparam.popup = TRUE
#                 CALL cl_err()
#
#                 LET g_fabh_d[l_ac].fabh000 = g_fabh_d_t.fabh000
#                 NEXT FIELD fabh000  
#              END IF       
#               CALL afat507_faid_chk() RETURNING l_success
#               IF NOT l_success THEN
#                  NEXT FIELD CURRENT
#               END IF
#               #獲取單位、數量、部門
#               CALL afat507_get_faah()
#               
#               #預設銷賬數量
#               #獲取成本、累計折舊、未折減額、已提列減值、預算編號、專案編號、wbs、客商編號
#               CALL afat507_get_faaj()
#               
#               CALL afat507_get_faaj_1()
#            END IF 
#          END IF            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh000
            #add-point:BEFORE FIELD fabh000 name="input.b.page1.fabh000"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabh000
            #add-point:ON CHANGE fabh000 name="input.g.page1.fabh000"
            
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
         BEFORE FIELD fabh005
            #add-point:BEFORE FIELD fabh005 name="input.b.page1.fabh005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh005
            
            #add-point:AFTER FIELD fabh005 name="input.a.page1.fabh005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabh005
            #add-point:ON CHANGE fabh005 name="input.g.page1.fabh005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh006
            #add-point:BEFORE FIELD fabh006 name="input.b.page1.fabh006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh006
            
            #add-point:AFTER FIELD fabh006 name="input.a.page1.fabh006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabh006
            #add-point:ON CHANGE fabh006 name="input.g.page1.fabh006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah025
            #add-point:BEFORE FIELD faah025 name="input.b.page1.faah025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah025
            
            #add-point:AFTER FIELD faah025 name="input.a.page1.faah025"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah025
            #add-point:ON CHANGE faah025 name="input.g.page1.faah025"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah026
            #add-point:BEFORE FIELD faah026 name="input.b.page1.faah026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah026
            
            #add-point:AFTER FIELD faah026 name="input.a.page1.faah026"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah026
            #add-point:ON CHANGE faah026 name="input.g.page1.faah026"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh007
            #add-point:BEFORE FIELD fabh007 name="input.b.page1.fabh007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh007
            
            #add-point:AFTER FIELD fabh007 name="input.a.page1.fabh007"
            IF NOT cl_null(g_fabh_d[l_ac].fabh007) THEN 
              #IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_fabh_d[l_ac].fabh007!= g_fabh_d_t.fabh007 OR g_fabh_d_t.fabh007 IS NULL )) THEN   #160824-00007#248 161208 by lori mark
               IF g_fabh_d[l_ac].fabh007!= g_fabh_d_o.fabh007 OR cl_null(g_fabh_d_o.fabh007) THEN   #160824-00007#248 161208 by lori add
                  IF NOT cl_ap_chk_Range(g_fabh_d[l_ac].fabh007,"0.000000","1","","","azz-00079",1) THEN
                    #160824-00007#248 161208 by lori mod---(S)
                    #LET g_fabh_d[l_ac].fabh007 = g_fabh_d_t.fabh007  
                     LET g_fabh_d[l_ac].fabh007 = g_fabh_d_o.fabh007  
                    #160824-00007#248 161208 by lori mod---(E)                     
                     NEXT FIELD fabh007
                  END IF
                  
                  SELECT faaj033 INTO l_faaj033  
                    FROM faaj_t
                   WHERE faajent = g_enterprise
                     AND faaj001 = g_fabh_d[l_ac].fabh001
                     AND faaj002 = g_fabh_d[l_ac].fabh002
                  LET l_fabh007 = g_fabh_d[l_ac].fabh006 - l_faaj033
                  IF g_fabh_d[l_ac].fabh007 > l_fabh007 THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'afa-00196'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                    #160824-00007#248 161208 by lori mod---(S)
                    #LET g_fabh_d[l_ac].fabh007 = g_fabh_d_t.fabh007  
                     LET g_fabh_d[l_ac].fabh007 = g_fabh_d_o.fabh007  
                    #160824-00007#248 161208 by lori mod---(E)                     
                     NEXT FIELD fabh007          
#                  ELSE
#                     IF g_fabh_d[l_ac].fabh007 != l_fabh007 THEN
#                        CALL afat507_get_amt(g_fabh_d[l_ac].fabh006,g_fabh_d[l_ac].fabh007)
#                     END IF                     
                  END IF  
                  CALL afat507_get_amt(g_fabh_d[l_ac].fabh006,g_fabh_d[l_ac].fabh007)                  
               END IF
            END IF
            
            LET g_fabh_d_o.fabh007 = g_fabh_d[l_ac].fabh007   #160824-00007#248 161208 by lori add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabh007
            #add-point:ON CHANGE fabh007 name="input.g.page1.fabh007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh015
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_fabh_d[l_ac].fabh015,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD fabh015
            END IF 
 
 
 
            #add-point:AFTER FIELD fabh015 name="input.a.page1.fabh015"
            IF NOT cl_null(g_fabh_d[l_ac].fabh015) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh015
            #add-point:BEFORE FIELD fabh015 name="input.b.page1.fabh015"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabh015
            #add-point:ON CHANGE fabh015 name="input.g.page1.fabh015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh008
            #add-point:BEFORE FIELD fabh008 name="input.b.page1.fabh008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh008
            
            #add-point:AFTER FIELD fabh008 name="input.a.page1.fabh008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabh008
            #add-point:ON CHANGE fabh008 name="input.g.page1.fabh008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh011
            #add-point:BEFORE FIELD fabh011 name="input.b.page1.fabh011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh011
            
            #add-point:AFTER FIELD fabh011 name="input.a.page1.fabh011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabh011
            #add-point:ON CHANGE fabh011 name="input.g.page1.fabh011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh004
            #add-point:BEFORE FIELD fabh004 name="input.b.page1.fabh004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh004
            
            #add-point:AFTER FIELD fabh004 name="input.a.page1.fabh004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabh004
            #add-point:ON CHANGE fabh004 name="input.g.page1.fabh004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh017
            #add-point:BEFORE FIELD fabh017 name="input.b.page1.fabh017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh017
            
            #add-point:AFTER FIELD fabh017 name="input.a.page1.fabh017"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabh017
            #add-point:ON CHANGE fabh017 name="input.g.page1.fabh017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh073
            #add-point:BEFORE FIELD fabh073 name="input.b.page1.fabh073"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh073
            
            #add-point:AFTER FIELD fabh073 name="input.a.page1.fabh073"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabh073
            #add-point:ON CHANGE fabh073 name="input.g.page1.fabh073"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh020
            
            #add-point:AFTER FIELD fabh020 name="input.a.page1.fabh020"
            IF NOT cl_null(g_fabh_d[l_ac].fabh020) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fabh_d[l_ac].fabh020

                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_oocq002_3902") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                 SELECT oocq019 INTO l_oocq019 FROM oocq_t 
                  WHERE oocqent=g_enterprise AND oocq001='3902' AND oocq002=g_fabh_d[l_ac].fabh020
                  IF l_oocq019<>'21' THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "afa-00193"
                     LET g_errparam.extend = g_fabh_d[l_ac].fabh020
                     LET g_errparam.popup = FALSE
                     CALL cl_err()
                     
                     LET g_fabh_d[l_ac].fabh020 = g_fabh_d_t.fabh020
                     NEXT FIELD fabh020
                  END IF   
               ELSE
                  #檢查失敗時後續處理
                  LET g_fabh_d[l_ac].fabh020 = g_fabh_d_t.fabh020
                  CALL afat507_get_fabh020_desc()
                  DISPLAY BY NAME g_fabh_d[l_ac].fabh020,g_fabh_d[l_ac].fabh020_desc 
                  NEXT FIELD CURRENT
               END IF

            END IF 
            
            CALL afat507_get_fabh020_desc()
             

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh020
            #add-point:BEFORE FIELD fabh020 name="input.b.page1.fabh020"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabh020
            #add-point:ON CHANGE fabh020 name="input.g.page1.fabh020"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh003
            #add-point:BEFORE FIELD fabh003 name="input.b.page1.fabh003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh003
            
            #add-point:AFTER FIELD fabh003 name="input.a.page1.fabh003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabh003
            #add-point:ON CHANGE fabh003 name="input.g.page1.fabh003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh023
            #add-point:BEFORE FIELD fabh023 name="input.b.page1.fabh023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh023
            
            #add-point:AFTER FIELD fabh023 name="input.a.page1.fabh023"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabh023
            #add-point:ON CHANGE fabh023 name="input.g.page1.fabh023"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh024
            #add-point:BEFORE FIELD fabh024 name="input.b.page1.fabh024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh024
            
            #add-point:AFTER FIELD fabh024 name="input.a.page1.fabh024"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabh024
            #add-point:ON CHANGE fabh024 name="input.g.page1.fabh024"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh025
            
            #add-point:AFTER FIELD fabh025 name="input.a.page1.fabh025"
            IF NOT cl_null(g_fabh_d[l_ac].fabh025) THEN 
               IF g_fabh_d[l_ac].fabh025 <> g_fabh_d_o.fabh025 OR cl_null(g_fabh_d_o.fabh025) THEN   #160824-00007#248 161208 by lori add
                  #  150916-00015#1 BEGIN    快捷带出类似科目编号     ADD BY XZG201511201
                   
                  LET l_sql = " "
                  IF  s_aglt310_getlike_lc_subject(g_fabg_m.fabgld,g_fabh_d[l_ac].fabh025,l_sql) THEN
                     INITIALIZE g_qryparam.* TO NULL
                     SELECT glaa004 INTO l_glaa004
                      FROM glaa_t
                     WHERE glaaent = g_enterprise
                       AND glaald = g_fabg_m.fabgld
                    LET g_qryparam.state = 'i'
                    LET g_qryparam.reqry = 'FALSE'
                    LET g_qryparam.default1 = g_fabh_d[l_ac].fabh025
                    
                    LET g_qryparam.arg1 = l_glaa004
                    LET g_qryparam.arg2 = g_fabh_d[l_ac].fabh025
                    LET g_qryparam.arg3 = g_fabg_m.fabgld
                    LET g_qryparam.arg4 = "1 "
                    CALL q_glac002_6()
                    LET g_fabh_d[l_ac].fabh025 = g_qryparam.return1
                     DISPLAY g_fabh_d[l_ac].fabh025 TO fabh025  
                  END IF
                  IF NOT s_aglt310_lc_subject(g_fabg_m.fabgld,g_fabh_d[l_ac].fabh025,'N') THEN
                       LET g_fabh_d[l_ac].fabh025 = g_fabh_d_o.fabh025   #160824-00007#248 161208 by lori add
                       NEXT FIELD CURRENT
                  END IF
                  #  150916-00015#1 END
                  #此段落由子樣板a19產生
                  #校驗代值
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_fabh_d[l_ac].fabh025
                  LET g_chkparam.arg2 = '參數2'
                  #160318-00025#5--add--str
                  LET g_errshow = TRUE 
                  LET g_chkparam.err_str[1] = "agl-00012:sub-01302|agli020|",cl_get_progname("agli020",g_lang,"2"),"|:EXEPROGagli020"
                  #160318-00025#5--add--end  
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist_and_ref_val("v_glac002_3") THEN
                     #檢查成功時後續處理
                     #LET  = g_chkparam.return1
                     #DISPLAY BY NAME 
                  ELSE
                     #檢查失敗時後續處理
                     LET g_fabh_d[l_ac].fabh025 = g_fabh_d_o.fabh025   #160824-00007#248 161208 by lori add
                     NEXT FIELD CURRENT
                  END IF
               END IF   #160824-00007#248 161208 by lori add
            END IF 

            LET g_fabh_d_o.fabh025 = g_fabh_d[l_ac].fabh025   #160824-00007#248 161208 by lori add                       
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh025
            #add-point:BEFORE FIELD fabh025 name="input.b.page1.fabh025"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabh025
            #add-point:ON CHANGE fabh025 name="input.g.page1.fabh025"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.fabhseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabhseq
            #add-point:ON ACTION controlp INFIELD fabhseq name="input.c.page1.fabhseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fabh001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh001
            #add-point:ON ACTION controlp INFIELD fabh001 name="input.c.page1.fabh001"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabh_d[l_ac].fabh001             #給予default值
            LET g_qryparam.default2 = g_fabh_d[l_ac].fabh002       #g_fabh_d[l_ac].faah003 #财产编号
            LET g_qryparam.default3 = g_fabh_d[l_ac].fabh000       #g_fabh_d[l_ac].faah004 #附号
            
#            IF NOT cl_null(g_fabh_d[l_ac].fabh002) AND NOT cl_null(g_fabh_d[l_ac].fabh000) THEN
#               LET g_qryparam.where = " faah001 = '",g_fabh_d[l_ac].fabh000,"' AND faah004 = '",g_fabh_d[l_ac].fabh002,"' AND faah015 NOT IN ('0','5','6','10')"            
#            END IF
#            IF cl_null(g_fabh_d[l_ac].fabh002) AND NOT cl_null(g_fabh_d[l_ac].fabh000) THEN
#               LET g_qryparam.where = " faah001 = '",g_fabh_d[l_ac].fabh000,"' AND faah015 NOT IN  ('0','5','6','10')"            
#            END IF
#            IF NOT cl_null(g_fabh_d[l_ac].fabh002) AND cl_null(g_fabh_d[l_ac].fabh000) THEN
#               LET g_qryparam.where = " faah004 = '",g_fabh_d[l_ac].fabh002,"' AND faah015 NOT IN  ('0','5','6','10')"            
#            END IF
#            IF cl_null(g_fabh_d[l_ac].fabh002) AND cl_null(g_fabh_d[l_ac].fabh000) THEN
#               LET g_qryparam.where = " faah015 NOT IN  ('0','5','6','10')"
#            END IF
             SELECT glaacomp INTO l_glaacomp FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_fabg_m.fabgld
             #已抵押的不可销账和报废  
             LET g_qryparam.where = " faah015 NOT IN  ('0','5','6','8','10') AND faah037 NOT IN('3','4') "
#                                   " AND faah032 IN (SELECT ooef017 FROM ooef_t WHERE ooefent = '",g_enterprise,"' AND ooef001 = '",l_glaacomp,"')"    #161111-00049#13 MARK xul
   

             #161111-00049#13--ADD--S--			  
		       LET g_qryparam.where = g_qryparam.where ," AND faah032 IN (SELECT glaacomp FROM glaa_t WHERE glaaent = ",g_enterprise," AND glaald = '",g_fabg_m.fabgld,"')" 			  
			    #161111-00049#13--ADD--E--
            #給予arg
     
            CALL q_faah003_3()                                #呼叫開窗

            LET g_fabh_d[l_ac].fabh001 = g_qryparam.return1              #將開窗取得的值回傳到變數
            LET g_fabh_d[l_ac].fabh002 = g_qryparam.return2 #财产编号
            LET g_fabh_d[l_ac].fabh000 = g_qryparam.return3 #附号

            DISPLAY g_fabh_d[l_ac].fabh000 TO fabh000              #顯示到畫面上
            DISPLAY g_fabh_d[l_ac].fabh001 TO fabh001 #财产编号
            DISPLAY g_fabh_d[l_ac].fabh002 TO fabh002 #附号

            NEXT FIELD fabh001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.fabh002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh002
            #add-point:ON ACTION controlp INFIELD fabh002 name="input.c.page1.fabh002"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabh_d[l_ac].fabh001             #給予default值
            LET g_qryparam.default2 = g_fabh_d[l_ac].fabh002 #g_fabh_d[l_ac].faah003 #财产编号
            LET g_qryparam.default3 = g_fabh_d[l_ac].fabh000 #g_fabh_d[l_ac].faah004 #附号

            IF NOT cl_null(g_fabh_d[l_ac].fabh001) AND NOT cl_null(g_fabh_d[l_ac].fabh000) THEN
               LET g_qryparam.where = " faah001 = '",g_fabh_d[l_ac].fabh000,"' AND faah003 = '",g_fabh_d[l_ac].fabh001,"' AND faah015 NOT IN   ('0','5','6','8','10')"            
            END IF
            IF cl_null(g_fabh_d[l_ac].fabh001) AND NOT cl_null(g_fabh_d[l_ac].fabh000) THEN
               LET g_qryparam.where = " faah001 = '",g_fabh_d[l_ac].fabh000,"' AND faah015 NOT IN  ('0','5','6','8','10')"            
            END IF
            IF NOT cl_null(g_fabh_d[l_ac].fabh001) AND cl_null(g_fabh_d[l_ac].fabh000) THEN
               LET g_qryparam.where = " faah003 = '",g_fabh_d[l_ac].fabh001,"' AND faah015 NOT IN  ('0','5','6','8','10')"            
            END IF
            IF cl_null(g_fabh_d[l_ac].fabh001) AND cl_null(g_fabh_d[l_ac].fabh000) THEN
               LET g_qryparam.where = " faah015 NOT IN  ('0','5','6','8','10')"
            END IF
            #161111-00049#13--MARK--S--
            #給予arg
#            SELECT glaacomp INTO l_glaacomp FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_fabg_m.fabgld
#            LET g_qryparam.where = g_qryparam.where CLIPPED,
#                                   " AND faah032 IN (SELECT ooef017 FROM ooef_t WHERE ooefent = '",g_enterprise,"' AND ooef001 = '",l_glaacomp,"')"
            #161111-00049#13--MARK--E--
            #161111-00049#13--ADD--S-- 
		      LET g_qryparam.where = g_qryparam.where ," AND faah032 IN (SELECT glaacomp FROM glaa_t WHERE glaaent = ",g_enterprise," AND glaald = '",g_fabg_m.fabgld,"')" 			  
			   #161111-00049#13--ADD--E--                       
            CALL q_faah003_3()                                #呼叫開窗

            LET g_fabh_d[l_ac].fabh001 = g_qryparam.return1              #將開窗取得的值回傳到變數
            LET g_fabh_d[l_ac].fabh002 = g_qryparam.return2 #财产编号
            LET g_fabh_d[l_ac].fabh000 = g_qryparam.return3 #附号

            DISPLAY g_fabh_d[l_ac].fabh000 TO fabh000              #顯示到畫面上
            DISPLAY g_fabh_d[l_ac].fabh001 TO fabh001 #财产编号
            DISPLAY g_fabh_d[l_ac].fabh002 TO fabh002 #附号

            NEXT FIELD fabh002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.fabh000
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh000
            #add-point:ON ACTION controlp INFIELD fabh000 name="input.c.page1.fabh000"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            IF NOT cl_null(g_fabh_d[l_ac].fabh002) AND NOT cl_null(g_fabh_d[l_ac].fabh001) THEN
               LET g_qryparam.where = " faah003 = '",g_fabh_d[l_ac].fabh001,"' AND faah004 = '",g_fabh_d[l_ac].fabh002,"' AND faah015 NOT IN ('0','5','6','8','10')"            
            END IF
            IF cl_null(g_fabh_d[l_ac].fabh002) AND NOT cl_null(g_fabh_d[l_ac].fabh001) THEN
               LET g_qryparam.where = " faah003 = '",g_fabh_d[l_ac].fabh001,"' AND faah015 NOT IN  ('0','5','6','8','10')"            
            END IF
            IF NOT cl_null(g_fabh_d[l_ac].fabh002) AND cl_null(g_fabh_d[l_ac].fabh001) THEN
               LET g_qryparam.where = " faah004 = '",g_fabh_d[l_ac].fabh002,"' AND faah015 NOT IN  ('0','5','6','8','10')"            
            END IF
            IF cl_null(g_fabh_d[l_ac].fabh002) AND cl_null(g_fabh_d[l_ac].fabh001) THEN
               LET g_qryparam.where = " faah015 NOT IN  ('0','5','6','8','10')"
            END IF

            LET g_qryparam.default1 = g_fabh_d[l_ac].fabh001             #給予default值
            LET g_qryparam.default2 = g_fabh_d[l_ac].fabh002 
            LET g_qryparam.default3 = g_fabh_d[l_ac].fabh000 
            #161111-00049#13--MARK--S--
            #給予arg
#            SELECT glaacomp INTO l_glaacomp FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_fabg_m.fabgld
#            LET g_qryparam.where = g_qryparam.where CLIPPED,
#                                   " AND faah032 IN (SELECT ooef017 FROM ooef_t WHERE ooefent = '",g_enterprise,"' AND ooef001 = '",l_glaacomp,"')"
            #161111-00049#13--MARK--E--                       
            #161111-00049#13--ADD--S-- 
		      LET g_qryparam.where = g_qryparam.where ," AND faah032 IN (SELECT glaacomp FROM glaa_t WHERE glaaent = ",g_enterprise," AND glaald = '",g_fabg_m.fabgld,"')" 			  
			   #161111-00049#13--ADD--E--                       
            CALL q_faah003_3()                                #呼叫開窗

            LET g_fabh_d[l_ac].fabh000 = g_qryparam.return3              #將開窗取得的值回傳到變數
            LET g_fabh_d[l_ac].fabh001 = g_qryparam.return1 
            LET g_fabh_d[l_ac].fabh002 = g_qryparam.return2  

            DISPLAY g_fabh_d[l_ac].fabh000 TO fabh000              #顯示到畫面上
            DISPLAY g_fabh_d[l_ac].fabh001 TO fabh001 
            DISPLAY g_fabh_d[l_ac].fabh002 TO fabh002 

            NEXT FIELD fabh000                          #返回原欄位


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
 
 
         #Ctrlp:input.c.page1.fabh005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh005
            #add-point:ON ACTION controlp INFIELD fabh005 name="input.c.page1.fabh005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fabh006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh006
            #add-point:ON ACTION controlp INFIELD fabh006 name="input.c.page1.fabh006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.faah025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah025
            #add-point:ON ACTION controlp INFIELD faah025 name="input.c.page1.faah025"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.faah026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah026
            #add-point:ON ACTION controlp INFIELD faah026 name="input.c.page1.faah026"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fabh007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh007
            #add-point:ON ACTION controlp INFIELD fabh007 name="input.c.page1.fabh007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fabh015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh015
            #add-point:ON ACTION controlp INFIELD fabh015 name="input.c.page1.fabh015"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fabh008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh008
            #add-point:ON ACTION controlp INFIELD fabh008 name="input.c.page1.fabh008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fabh011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh011
            #add-point:ON ACTION controlp INFIELD fabh011 name="input.c.page1.fabh011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fabh004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh004
            #add-point:ON ACTION controlp INFIELD fabh004 name="input.c.page1.fabh004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fabh017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh017
            #add-point:ON ACTION controlp INFIELD fabh017 name="input.c.page1.fabh017"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fabh073
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh073
            #add-point:ON ACTION controlp INFIELD fabh073 name="input.c.page1.fabh073"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fabh020
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh020
            #add-point:ON ACTION controlp INFIELD fabh020 name="input.c.page1.fabh020"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabh_d[l_ac].fabh020             #給予default值
            LET g_qryparam.where = " oocq019 = '21' "
            #給予arg

            CALL q_oocq002_18()                                #呼叫開窗


            LET g_fabh_d[l_ac].fabh020 = g_qryparam.return1              #將開窗取得的值回傳到變數


            CALL afat507_get_fabh020_desc()
            DISPLAY g_fabh_d[l_ac].fabh020 TO fabh020              #顯示到畫面上
            DISPLAY g_fabh_d[l_ac].fabh020_desc TO fabh020_desc

            LET g_qryparam.where = ""
            NEXT FIELD fabh020                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.fabh003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh003
            #add-point:ON ACTION controlp INFIELD fabh003 name="input.c.page1.fabh003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fabh023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh023
            #add-point:ON ACTION controlp INFIELD fabh023 name="input.c.page1.fabh023"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fabh024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh024
            #add-point:ON ACTION controlp INFIELD fabh024 name="input.c.page1.fabh024"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fabh025
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh025
            #add-point:ON ACTION controlp INFIELD fabh025 name="input.c.page1.fabh025"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabh_d[l_ac].fabh025             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #
            LET g_qryparam.where = "glac001 = '",g_glaa.glaa004,"' AND  glac003 <>'1' " , #glac001(會計科目參照表)/glac003(科目類型)
                                    " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 ",
                                   "AND gladld='",g_fabg_m.fabgld,"' AND gladent='",g_enterprise,"'",
                                   " AND gladstus = 'Y' )"
            
            CALL aglt310_04()                                #呼叫開窗

            LET g_fabh_d[l_ac].fabh025 = g_qryparam.return1  
                        

            DISPLAY g_fabh_d[l_ac].fabh025 TO fabh025              #

            NEXT FIELD fabh025                          #返回原欄位


            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_fabh_d[l_ac].* = g_fabh_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE afat507_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_fabh_d[l_ac].fabhseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_fabh_d[l_ac].* = g_fabh_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL afat507_fabh_t_mask_restore('restore_mask_o')
      
               UPDATE fabh_t SET (fabhld,fabhdocno,fabhseq,fabh001,fabh002,fabh000,fabh005,fabh006,fabh007, 
                   fabh015,fabh008,fabh011,fabh004,fabh017,fabh073,fabh020,fabh003,fabh023,fabh024,fabh025, 
                   fabh100,fabh101,fabh102,fabh104,fabh108,fabh109,fabh111,fabh150,fabh151,fabh152,fabh154, 
                   fabh158,fabh159,fabh161) = (g_fabg_m.fabgld,g_fabg_m.fabgdocno,g_fabh_d[l_ac].fabhseq, 
                   g_fabh_d[l_ac].fabh001,g_fabh_d[l_ac].fabh002,g_fabh_d[l_ac].fabh000,g_fabh_d[l_ac].fabh005, 
                   g_fabh_d[l_ac].fabh006,g_fabh_d[l_ac].fabh007,g_fabh_d[l_ac].fabh015,g_fabh_d[l_ac].fabh008, 
                   g_fabh_d[l_ac].fabh011,g_fabh_d[l_ac].fabh004,g_fabh_d[l_ac].fabh017,g_fabh_d[l_ac].fabh073, 
                   g_fabh_d[l_ac].fabh020,g_fabh_d[l_ac].fabh003,g_fabh_d[l_ac].fabh023,g_fabh_d[l_ac].fabh024, 
                   g_fabh_d[l_ac].fabh025,g_fabh3_d[l_ac].fabh100,g_fabh3_d[l_ac].fabh101,g_fabh3_d[l_ac].fabh102, 
                   g_fabh3_d[l_ac].fabh104,g_fabh3_d[l_ac].fabh108,g_fabh3_d[l_ac].fabh109,g_fabh3_d[l_ac].fabh111, 
                   g_fabh3_d[l_ac].fabh150,g_fabh3_d[l_ac].fabh151,g_fabh3_d[l_ac].fabh152,g_fabh3_d[l_ac].fabh154, 
                   g_fabh3_d[l_ac].fabh158,g_fabh3_d[l_ac].fabh159,g_fabh3_d[l_ac].fabh161)
                WHERE fabhent = g_enterprise AND fabhld = g_fabg_m.fabgld 
                  AND fabhdocno = g_fabg_m.fabgdocno 
 
                  AND fabhseq = g_fabh_d_t.fabhseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_fabh_d[l_ac].* = g_fabh_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fabh_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_fabh_d[l_ac].* = g_fabh_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fabh_t:",SQLERRMESSAGE 
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
               LET gs_keys[3] = g_fabh_d[g_detail_idx].fabhseq
               LET gs_keys_bak[3] = g_fabh_d_t.fabhseq
               CALL afat507_update_b('fabh_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL afat507_fabh_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_fabh_d[g_detail_idx].fabhseq = g_fabh_d_t.fabhseq 
 
                  ) THEN
                  LET gs_keys[01] = g_fabg_m.fabgld
                  LET gs_keys[gs_keys.getLength()+1] = g_fabg_m.fabgdocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_fabh_d_t.fabhseq
 
                  CALL afat507_key_update_b(gs_keys,'fabh_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_fabg_m),util.JSON.stringify(g_fabh_d_t)
               LET g_log2 = util.JSON.stringify(g_fabg_m),util.JSON.stringify(g_fabh_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               IF g_fabh_d[l_ac].fabh001 <> g_fabh_d_t.fabh001 OR g_fabh_d[l_ac].fabh002 <> g_fabh_d_t.fabh002
                  OR g_fabh_d[l_ac].fabh000 <> g_fabh_d_t.fabh000 OR g_fabh_d[l_ac].fabhseq <> g_fabh_d_t.fabhseq THEN 

                  DELETE FROM fabi_t
                   WHERE fabient = g_enterprise AND fabidocno = g_fabg_m.fabgdocno 
                     AND fabi000 = g_fabg_m.fabg005 AND fabiseq = g_fabh_d_t.fabhseq
                  
                  
                  SELECT COUNT(*) INTO l_n FROM faai_t 
                   WHERE faaient = g_enterprise AND faai001 = g_fabh_d[l_ac].fabh000
                     AND faai002 = g_fabh_d[l_ac].fabh001 AND faai003 = g_fabh_d[l_ac].fabh002
                  IF l_n > 0 THEN 
                     CALL afat440_01(l_cmd,g_fabh_d[l_ac].fabhseq,g_fabh_d[l_ac].fabh001,g_fabh_d[l_ac].fabh002,g_fabh_d[l_ac].fabh000,g_fabg_m.fabg005,g_fabg_m.fabgdocno,'')
                  END IF              
               END IF   
               
               #20141219 add by chenying
               #150916--s
               #有維護摘要就不取設定的摘要
               LET l_oocq009 = ''
               SELECT fabh036 INTO l_oocq009 FROM fabh_t 
                WHERE fabhent = g_enterprise AND fabhld = g_fabg_m.fabgld
                  AND fabhdocno = g_fabg_m.fabgdocno               
                  AND fabhseq = g_fabh_d_t.fabhseq
               IF cl_null(l_oocq009) THEN
               #150916--e
               #预设afai090摘要
                  LET l_oocq009 = ''
                  SELECT oocq009 INTO l_oocq009 FROM oocq_t 
                   WHERE oocqent=g_enterprise AND oocq001='3902' AND oocq002=g_fabh_d[l_ac].fabh020
               END IF   #150916 
               UPDATE fabh_t SET fabh036 = l_oocq009
                WHERE fabhent = g_enterprise 
                  AND fabhld  = g_fabg_m.fabgld 
                  AND fabhdocno = g_fabg_m.fabgdocno 
                  AND fabhseq = g_fabh_d_t.fabhseq #項次 
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fabh_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     LET g_fabh_d[l_ac].* = g_fabh_d_t.*
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fabh_t" 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()                   
                     CALL s_transaction_end('N','0')
                     LET g_fabh_d[l_ac].* = g_fabh_d_t.* 
               END CASE                     
               #20141219 add by chenying                
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL afat507_unlock_b("fabh_t","'1'")
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            #add-point:單身after_row2 name="input.body.after_row2"
            
            #end add-point
              
         AFTER INPUT
            #add-point:input段after input  name="input.body.after_input"
            LET g_fabgld=g_fabg_m.fabgld
            LET g_fabgdocno=g_fabg_m.fabgdocno
            CALL afat503_01_b_fill()
            #end add-point 
    
         ON ACTION controlo    
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_fabh_d[li_reproduce_target].* = g_fabh_d[li_reproduce].*
               LET g_fabh3_d[li_reproduce_target].* = g_fabh3_d[li_reproduce].*
 
               LET g_fabh_d[li_reproduce_target].fabhseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_fabh_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_fabh_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
      INPUT ARRAY g_fabh3_d FROM s_detail3.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = FALSE, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_2)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body3.before_input2"
            
            #end add-point
            
            CALL afat507_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue(""))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_fabh3_d.getLength()
            #add-point:資料輸入前 name="input.body3.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_fabh3_d[l_ac].* TO NULL 
            INITIALIZE g_fabh3_d_t.* TO NULL 
            INITIALIZE g_fabh3_d_o.* TO NULL 
            #公用欄位給值(單身2)
            
            #自定義預設值(單身2)
                  LET g_fabh3_d[l_ac].fabh111 = "0"
      LET g_fabh3_d[l_ac].fabh161 = "0"
 
            #add-point:modify段before備份 name="input.body3.insert.before_bak"
            
            #end add-point
            LET g_fabh3_d_t.* = g_fabh3_d[l_ac].*     #新輸入資料
            LET g_fabh3_d_o.* = g_fabh3_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL afat507_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body3.insert.after_set_entry_b"
            
            #end add-point
            CALL afat507_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_fabh_d[li_reproduce_target].* = g_fabh_d[li_reproduce].*
               LET g_fabh3_d[li_reproduce_target].* = g_fabh3_d[li_reproduce].*
 
               LET g_fabh3_d[li_reproduce_target].fabhseq = NULL
            END IF
            
 
 
            #add-point:modify段before insert name="input.body3.before_insert"
            
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
            OPEN afat507_cl USING g_enterprise,g_fabg_m.fabgld,g_fabg_m.fabgdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN afat507_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE afat507_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_fabh3_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_fabh3_d[l_ac].fabhseq IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_fabh3_d_t.* = g_fabh3_d[l_ac].*  #BACKUP
               LET g_fabh3_d_o.* = g_fabh3_d[l_ac].*  #BACKUP
               CALL afat507_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body3.after_set_entry_b"
               
               #end add-point  
               CALL afat507_set_no_entry_b(l_cmd)
               IF NOT afat507_lock_b("fabh_t","'2'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH afat507_bcl INTO g_fabh_d[l_ac].fabhseq,g_fabh_d[l_ac].fabh001,g_fabh_d[l_ac].fabh002, 
                      g_fabh_d[l_ac].fabh000,g_fabh_d[l_ac].fabh005,g_fabh_d[l_ac].fabh006,g_fabh_d[l_ac].fabh007, 
                      g_fabh_d[l_ac].fabh015,g_fabh_d[l_ac].fabh008,g_fabh_d[l_ac].fabh011,g_fabh_d[l_ac].fabh004, 
                      g_fabh_d[l_ac].fabh017,g_fabh_d[l_ac].fabh073,g_fabh_d[l_ac].fabh020,g_fabh_d[l_ac].fabh003, 
                      g_fabh_d[l_ac].fabh023,g_fabh_d[l_ac].fabh024,g_fabh_d[l_ac].fabh025,g_fabh3_d[l_ac].fabhseq, 
                      g_fabh3_d[l_ac].fabh100,g_fabh3_d[l_ac].fabh101,g_fabh3_d[l_ac].fabh102,g_fabh3_d[l_ac].fabh104, 
                      g_fabh3_d[l_ac].fabh108,g_fabh3_d[l_ac].fabh109,g_fabh3_d[l_ac].fabh111,g_fabh3_d[l_ac].fabh150, 
                      g_fabh3_d[l_ac].fabh151,g_fabh3_d[l_ac].fabh152,g_fabh3_d[l_ac].fabh154,g_fabh3_d[l_ac].fabh158, 
                      g_fabh3_d[l_ac].fabh159,g_fabh3_d[l_ac].fabh161
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_fabh3_d_mask_o[l_ac].* =  g_fabh3_d[l_ac].*
                  CALL afat507_fabh_t_mask()
                  LET g_fabh3_d_mask_n[l_ac].* =  g_fabh3_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL afat507_show()
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
               
               #add-point:單身2刪除前 name="input.body3.b_delete"
               
               #end add-point    
                  
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_fabg_m.fabgld
               LET gs_keys[gs_keys.getLength()+1] = g_fabg_m.fabgdocno
               LET gs_keys[gs_keys.getLength()+1] = g_fabh3_d_t.fabhseq
            
               #刪除同層單身
               IF NOT afat507_delete_b('fabh_t',gs_keys,"'2'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE afat507_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT afat507_key_delete_b(gs_keys,'fabh_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE afat507_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
 
               
               #add-point:單身2刪除中 name="input.body3.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE afat507_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身2刪除後 name="input.body3.a_delete"
               
               #end add-point
               LET l_count = g_fabh_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body3.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_fabh3_d.getLength() + 1) THEN
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
            SELECT COUNT(1) INTO l_count FROM fabh_t 
             WHERE fabhent = g_enterprise AND fabhld = g_fabg_m.fabgld
               AND fabhdocno = g_fabg_m.fabgdocno
               AND fabhseq = g_fabh3_d[l_ac].fabhseq
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前 name="input.body3.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fabg_m.fabgld
               LET gs_keys[2] = g_fabg_m.fabgdocno
               LET gs_keys[3] = g_fabh3_d[g_detail_idx].fabhseq
               CALL afat507_insert_b('fabh_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2 name="input.body3.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_fabh_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "fabh_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL afat507_b_fill()
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
               LET g_fabh3_d[l_ac].* = g_fabh3_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE afat507_bcl
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
               LET g_fabh3_d[l_ac].* = g_fabh3_d_t.*
            ELSE
               #add-point:單身page2修改前 name="input.body3.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身2)
               
               
               #將遮罩欄位還原
               CALL afat507_fabh_t_mask_restore('restore_mask_o')
                              
               UPDATE fabh_t SET (fabhld,fabhdocno,fabhseq,fabh001,fabh002,fabh000,fabh005,fabh006,fabh007, 
                   fabh015,fabh008,fabh011,fabh004,fabh017,fabh073,fabh020,fabh003,fabh023,fabh024,fabh025, 
                   fabh100,fabh101,fabh102,fabh104,fabh108,fabh109,fabh111,fabh150,fabh151,fabh152,fabh154, 
                   fabh158,fabh159,fabh161) = (g_fabg_m.fabgld,g_fabg_m.fabgdocno,g_fabh_d[l_ac].fabhseq, 
                   g_fabh_d[l_ac].fabh001,g_fabh_d[l_ac].fabh002,g_fabh_d[l_ac].fabh000,g_fabh_d[l_ac].fabh005, 
                   g_fabh_d[l_ac].fabh006,g_fabh_d[l_ac].fabh007,g_fabh_d[l_ac].fabh015,g_fabh_d[l_ac].fabh008, 
                   g_fabh_d[l_ac].fabh011,g_fabh_d[l_ac].fabh004,g_fabh_d[l_ac].fabh017,g_fabh_d[l_ac].fabh073, 
                   g_fabh_d[l_ac].fabh020,g_fabh_d[l_ac].fabh003,g_fabh_d[l_ac].fabh023,g_fabh_d[l_ac].fabh024, 
                   g_fabh_d[l_ac].fabh025,g_fabh3_d[l_ac].fabh100,g_fabh3_d[l_ac].fabh101,g_fabh3_d[l_ac].fabh102, 
                   g_fabh3_d[l_ac].fabh104,g_fabh3_d[l_ac].fabh108,g_fabh3_d[l_ac].fabh109,g_fabh3_d[l_ac].fabh111, 
                   g_fabh3_d[l_ac].fabh150,g_fabh3_d[l_ac].fabh151,g_fabh3_d[l_ac].fabh152,g_fabh3_d[l_ac].fabh154, 
                   g_fabh3_d[l_ac].fabh158,g_fabh3_d[l_ac].fabh159,g_fabh3_d[l_ac].fabh161) #自訂欄位頁簽 
 
                WHERE fabhent = g_enterprise AND fabhld = g_fabg_m.fabgld
                  AND fabhdocno = g_fabg_m.fabgdocno
                  AND fabhseq = g_fabh3_d_t.fabhseq #項次 
                  
               #add-point:單身page2修改中 name="input.body3.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_fabh3_d[l_ac].* = g_fabh3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fabh_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_fabh3_d[l_ac].* = g_fabh3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fabh_t:",SQLERRMESSAGE 
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
               LET gs_keys[3] = g_fabh3_d[g_detail_idx].fabhseq
               LET gs_keys_bak[3] = g_fabh3_d_t.fabhseq
               CALL afat507_update_b('fabh_t',gs_keys,gs_keys_bak,"'2'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL afat507_fabh_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_fabh3_d[g_detail_idx].fabhseq = g_fabh3_d_t.fabhseq 
                  ) THEN
                  LET gs_keys[01] = g_fabg_m.fabgld
                  LET gs_keys[gs_keys.getLength()+1] = g_fabg_m.fabgdocno
                  LET gs_keys[gs_keys.getLength()+1] = g_fabh3_d_t.fabhseq
                  CALL afat507_key_update_b(gs_keys,'fabh_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_fabg_m),util.JSON.stringify(g_fabh3_d_t)
               LET g_log2 = util.JSON.stringify(g_fabg_m),util.JSON.stringify(g_fabh3_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page2修改後 name="input.body3.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh100
            #add-point:BEFORE FIELD fabh100 name="input.b.page3.fabh100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh100
            
            #add-point:AFTER FIELD fabh100 name="input.a.page3.fabh100"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabh100
            #add-point:ON CHANGE fabh100 name="input.g.page3.fabh100"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh101
            #add-point:BEFORE FIELD fabh101 name="input.b.page3.fabh101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh101
            
            #add-point:AFTER FIELD fabh101 name="input.a.page3.fabh101"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabh101
            #add-point:ON CHANGE fabh101 name="input.g.page3.fabh101"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh102
            #add-point:BEFORE FIELD fabh102 name="input.b.page3.fabh102"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh102
            
            #add-point:AFTER FIELD fabh102 name="input.a.page3.fabh102"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabh102
            #add-point:ON CHANGE fabh102 name="input.g.page3.fabh102"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh104
            #add-point:BEFORE FIELD fabh104 name="input.b.page3.fabh104"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh104
            
            #add-point:AFTER FIELD fabh104 name="input.a.page3.fabh104"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabh104
            #add-point:ON CHANGE fabh104 name="input.g.page3.fabh104"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh108
            #add-point:BEFORE FIELD fabh108 name="input.b.page3.fabh108"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh108
            
            #add-point:AFTER FIELD fabh108 name="input.a.page3.fabh108"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabh108
            #add-point:ON CHANGE fabh108 name="input.g.page3.fabh108"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh109
            #add-point:BEFORE FIELD fabh109 name="input.b.page3.fabh109"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh109
            
            #add-point:AFTER FIELD fabh109 name="input.a.page3.fabh109"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabh109
            #add-point:ON CHANGE fabh109 name="input.g.page3.fabh109"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh111
            #add-point:BEFORE FIELD fabh111 name="input.b.page3.fabh111"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh111
            
            #add-point:AFTER FIELD fabh111 name="input.a.page3.fabh111"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabh111
            #add-point:ON CHANGE fabh111 name="input.g.page3.fabh111"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh150
            #add-point:BEFORE FIELD fabh150 name="input.b.page3.fabh150"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh150
            
            #add-point:AFTER FIELD fabh150 name="input.a.page3.fabh150"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabh150
            #add-point:ON CHANGE fabh150 name="input.g.page3.fabh150"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh151
            #add-point:BEFORE FIELD fabh151 name="input.b.page3.fabh151"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh151
            
            #add-point:AFTER FIELD fabh151 name="input.a.page3.fabh151"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabh151
            #add-point:ON CHANGE fabh151 name="input.g.page3.fabh151"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh152
            #add-point:BEFORE FIELD fabh152 name="input.b.page3.fabh152"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh152
            
            #add-point:AFTER FIELD fabh152 name="input.a.page3.fabh152"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabh152
            #add-point:ON CHANGE fabh152 name="input.g.page3.fabh152"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh154
            #add-point:BEFORE FIELD fabh154 name="input.b.page3.fabh154"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh154
            
            #add-point:AFTER FIELD fabh154 name="input.a.page3.fabh154"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabh154
            #add-point:ON CHANGE fabh154 name="input.g.page3.fabh154"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh158
            #add-point:BEFORE FIELD fabh158 name="input.b.page3.fabh158"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh158
            
            #add-point:AFTER FIELD fabh158 name="input.a.page3.fabh158"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabh158
            #add-point:ON CHANGE fabh158 name="input.g.page3.fabh158"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh159
            #add-point:BEFORE FIELD fabh159 name="input.b.page3.fabh159"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh159
            
            #add-point:AFTER FIELD fabh159 name="input.a.page3.fabh159"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabh159
            #add-point:ON CHANGE fabh159 name="input.g.page3.fabh159"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabh161
            #add-point:BEFORE FIELD fabh161 name="input.b.page3.fabh161"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabh161
            
            #add-point:AFTER FIELD fabh161 name="input.a.page3.fabh161"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabh161
            #add-point:ON CHANGE fabh161 name="input.g.page3.fabh161"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page3.fabh100
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh100
            #add-point:ON ACTION controlp INFIELD fabh100 name="input.c.page3.fabh100"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.fabh101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh101
            #add-point:ON ACTION controlp INFIELD fabh101 name="input.c.page3.fabh101"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.fabh102
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh102
            #add-point:ON ACTION controlp INFIELD fabh102 name="input.c.page3.fabh102"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.fabh104
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh104
            #add-point:ON ACTION controlp INFIELD fabh104 name="input.c.page3.fabh104"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.fabh108
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh108
            #add-point:ON ACTION controlp INFIELD fabh108 name="input.c.page3.fabh108"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.fabh109
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh109
            #add-point:ON ACTION controlp INFIELD fabh109 name="input.c.page3.fabh109"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.fabh111
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh111
            #add-point:ON ACTION controlp INFIELD fabh111 name="input.c.page3.fabh111"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.fabh150
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh150
            #add-point:ON ACTION controlp INFIELD fabh150 name="input.c.page3.fabh150"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.fabh151
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh151
            #add-point:ON ACTION controlp INFIELD fabh151 name="input.c.page3.fabh151"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.fabh152
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh152
            #add-point:ON ACTION controlp INFIELD fabh152 name="input.c.page3.fabh152"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.fabh154
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh154
            #add-point:ON ACTION controlp INFIELD fabh154 name="input.c.page3.fabh154"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.fabh158
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh158
            #add-point:ON ACTION controlp INFIELD fabh158 name="input.c.page3.fabh158"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.fabh159
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh159
            #add-point:ON ACTION controlp INFIELD fabh159 name="input.c.page3.fabh159"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.fabh161
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabh161
            #add-point:ON ACTION controlp INFIELD fabh161 name="input.c.page3.fabh161"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page2 after_row name="input.body3.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_fabh3_d[l_ac].* = g_fabh3_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE afat507_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL afat507_unlock_b("fabh_t","'2'")
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
               LET g_fabh_d[li_reproduce_target].* = g_fabh_d[li_reproduce].*
               LET g_fabh3_d[li_reproduce_target].* = g_fabh3_d[li_reproduce].*
 
               LET g_fabh3_d[li_reproduce_target].fabhseq = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_fabh3_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_fabh3_d.getLength()+1
            END IF
            
      END INPUT
 
      
 
 
 
 
{</section>}
 
{<section id="afat507.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      SUBDIALOG afa_afat503_01.afat503_01_input
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
         IF p_cmd <> 'a' AND g_aw="s_detail1_afat503_01" THEN
            NEXT FIELD fabh021
         END IF
         
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1','2',"))      
         CALL DIALOG.setCurrentRow("s_detail3",g_idx_group.getValue(""))
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            NEXT FIELD fabgsite   #160426-00014#33 add lujh
            #end add-point  
            NEXT FIELD fabgld
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD fabhseq
               WHEN "s_detail3"
                  NEXT FIELD fabhseq_2
 
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
   #20150104 add by chenying
   IF g_glaa.glaa121 = 'Y' AND INT_FLAG = 0 THEN 
      #150916--s
      CALL s_aooi200_fin_get_slip(g_fabg_m.fabgdocno) RETURNING g_sub_success,l_ooba002
      CALL s_fin_get_doc_para(g_fabg_m.fabgld,'',l_ooba002,'D-FIN-0030') RETURNING l_str1  
      IF cl_null(l_str1) THEN LET l_str1 = 'Y' END IF    
      IF l_str1 = 'Y' THEN               
      #150916--e   
         CALL s_transaction_begin()
         CALL cl_err_collect_init()
         
         CALL s_pre_voucher_ins('FA','F50',g_fabg_m.fabgld,g_fabg_m.fabgdocno,g_fabg_m.fabgdocdt,'21') RETURNING l_success
         
         IF l_success THEN
            CALL cl_err_collect_init()  
            CALL cl_err_collect_show()       
            CALL s_transaction_end('Y','1')
         ELSE
            CALL cl_err_collect_show()
            CALL s_transaction_end('N','1')  
         END IF
      END IF   #150916
   END IF
   #20150104 add by chenying
   
   #151125-00006#3----s
 IF INT_FLAG = FALSE THEN
   CALL s_aooi200_fin_get_slip(g_fabg_m.fabgdocno) RETURNING l_success,l_ooba002
   CALL s_fin_orga_get_comp_ld(g_fabg_m.fabgsite) RETURNING g_sub_success,g_errno,l_fabgcomp,l_ld
   CALL s_fin_get_doc_para(g_fabg_m.fabgld,l_fabgcomp,l_ooba002,'D-FIN-0031') RETURNING l_dfin0031
   CALL s_fin_get_doc_para(g_fabg_m.fabgld,l_fabgcomp,l_ooba002,'D-FIN-0032') RETURNING l_dfin0032
   IF NOT cl_null(l_dfin0031) AND l_dfin0031 MATCHES '[Yy]' THEN 
      IF cl_ask_confirm('aap-00403') THEN
         CALL s_transaction_begin()
         CALL s_afat503_immediately_conf(g_fabg_m.fabgdocno,l_fabgcomp,g_fabg_m.fabgld,g_fabg_m.fabgdocdt,g_prog) RETURNING l_success
         IF l_success THEN 
            CALL s_transaction_end('Y','0')
         ELSE
            CALL s_transaction_end('N','0')
            CALL cl_err_collect_show()
         END IF
      END IF 
   END IF
 END IF
   #151125-00006#3----e
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="afat507.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION afat507_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
#   IF g_fabg_m.fabgstus = 'X' THEN
#      CALL cl_set_act_visible("delete", FALSE)
#   END IF
#   IF g_fabg_m.fabgstus = 'Y' THEN
#      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
#   END IF 
#   IF g_fabg_m.fabgstus = 'N' THEN   
#      CALL cl_set_act_visible("modify,delete,modify_detail", TRUE)
#   END IF
   IF  g_fabg_m.fabgstus<>'N' THEN
      CALL cl_set_act_visible("modify,delete", FALSE)
   ELSE
      CALL cl_set_act_visible("modify,delete", TRUE)
   END IF   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL afat507_b_fill() #單身填充
      CALL afat507_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL afat507_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fabg_m.fabgsite
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_fabg_m.fabgsite_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fabg_m.fabgsite_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fabg_m.fabg002
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_fabg_m.fabg002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fabg_m.fabg002_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fabg_m.fabg001
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_fabg_m.fabg001_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fabg_m.fabg001_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fabg_m.fabg003
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_fabg_m.fabg003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fabg_m.fabg003_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fabg_m.fabgld
            CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_fabg_m.fabgld_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fabg_m.fabgld_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fabg_m.fabgownid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_fabg_m.fabgownid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fabg_m.fabgownid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fabg_m.fabgowndp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_fabg_m.fabgowndp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fabg_m.fabgowndp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fabg_m.fabgcrtid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_fabg_m.fabgcrtid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fabg_m.fabgcrtid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fabg_m.fabgcrtdp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_fabg_m.fabgcrtdp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fabg_m.fabgcrtdp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fabg_m.fabgmodid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_fabg_m.fabgmodid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fabg_m.fabgmodid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fabg_m.fabgcnfid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_fabg_m.fabgcnfid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fabg_m.fabgcnfid_desc

   #end add-point
   
   #遮罩相關處理
   LET g_fabg_m_mask_o.* =  g_fabg_m.*
   CALL afat507_fabg_t_mask()
   LET g_fabg_m_mask_n.* =  g_fabg_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_fabg_m.fabgsite,g_fabg_m.fabgsite_desc,g_fabg_m.fabg002,g_fabg_m.fabg002_desc,g_fabg_m.fabg001, 
       g_fabg_m.fabg001_desc,g_fabg_m.fabg003,g_fabg_m.fabg003_desc,g_fabg_m.fabgld,g_fabg_m.fabgld_desc, 
       g_fabg_m.fabg004,g_fabg_m.fabg005,g_fabg_m.fabg008,g_fabg_m.fabgdocno,g_fabg_m.fabg009,g_fabg_m.fabgdocdt, 
       g_fabg_m.fabgstus,g_fabg_m.fabgownid,g_fabg_m.fabgownid_desc,g_fabg_m.fabgowndp,g_fabg_m.fabgowndp_desc, 
       g_fabg_m.fabgcrtid,g_fabg_m.fabgcrtid_desc,g_fabg_m.fabgcrtdp,g_fabg_m.fabgcrtdp_desc,g_fabg_m.fabgcrtdt, 
       g_fabg_m.fabgmodid,g_fabg_m.fabgmodid_desc,g_fabg_m.fabgmoddt,g_fabg_m.fabgcnfid,g_fabg_m.fabgcnfid_desc, 
       g_fabg_m.fabgcnfdt
   
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
   FOR l_ac = 1 TO g_fabh_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
            CALL afat507_visible()
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fabh_d[l_ac].fabh020
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='3904' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_fabh_d[l_ac].fabh020_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fabh_d[l_ac].fabh020_desc

      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_fabh3_d.getLength()
      #add-point:show段單身reference name="show.body3.reference"

#   INITIALIZE g_ref_fields TO NULL 
#   LET g_ref_fields[1] = g_fabg_m.fabgld
#   LET g_ref_fields[2] = g_fabg_m.fabgdocno
#   LET g_ref_fields[3] = g_fabh_d[l_ac].fabhseq
#   CALL ap_ref_array2(g_ref_fields," SELECT faaj104,faaj154,faaj104,faaj154 FROM faaj_t WHERE faajent = '"||g_enterprise||"' AND ","") RETURNING g_rtn_fields 
#   LET g_fabh3_d[l_ac].faaj104 = g_rtn_fields[1] 
#   LET g_fabh3_d[l_ac].faaj154 = g_rtn_fields[2] 
#   LET g_fabh3_d[l_ac].faaj104 = g_rtn_fields[3] 
#   LET g_fabh3_d[l_ac].faaj154 = g_rtn_fields[4] 
#   DISPLAY BY NAME g_fabh3_d[l_ac].faaj104,g_fabh3_d[l_ac].faaj154,g_fabh3_d[l_ac].faaj104,g_fabh3_d[l_ac].faaj154
      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL afat507_detail_show()
 
   #add-point:show段之後 name="show.after"
   #20150104 add by chenying
   #161215-00044#1---modify----begin-----------------
   #SELECT * INTO g_glaa.* 
   SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,
          glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,glaa011,
          glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,glaa023,
          glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,glaa113,glaa120,glaa121,
          glaa122,glaa027,glaa130,glaa131,glaa132,glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,
          glaa140,glaa123,glaa124,glaa028 INTO g_glaa.* 
   #161215-00044#1---modify----end--------------- 
   FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald = g_fabg_m.fabgld
 
   IF g_glaa.glaa121 = 'Y' THEN
      CALL cl_set_toolbaritem_visible('open_pre',TRUE)
   ELSE
      CALL cl_set_toolbaritem_visible('open_pre',FALSE)
   END IF
   #20150104 add by chenying
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="afat507.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION afat507_detail_show()
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
 
{<section id="afat507.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION afat507_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE fabg_t.fabgld 
   DEFINE l_oldno     LIKE fabg_t.fabgld 
   DEFINE l_newno02     LIKE fabg_t.fabgdocno 
   DEFINE l_oldno02     LIKE fabg_t.fabgdocno 
 
   DEFINE l_master    RECORD LIKE fabg_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE fabh_t.* #此變數樣板目前無使用
 
 
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
   LET g_fabg_m.fabgstus = "N"
   CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
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
 
   
   CALL afat507_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_fabg_m.* TO NULL
      INITIALIZE g_fabh_d TO NULL
      INITIALIZE g_fabh3_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL afat507_show()
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
   CALL afat507_set_act_visible()   
   CALL afat507_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_fabgld_t = g_fabg_m.fabgld
   LET g_fabgdocno_t = g_fabg_m.fabgdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " fabgent = " ||g_enterprise|| " AND",
                      " fabgld = '", g_fabg_m.fabgld, "' "
                      ," AND fabgdocno = '", g_fabg_m.fabgdocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL afat507_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL afat507_idx_chk()
   
   LET g_data_owner = g_fabg_m.fabgownid      
   LET g_data_dept  = g_fabg_m.fabgowndp
   
   #功能已完成,通報訊息中心
   CALL afat507_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="afat507.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION afat507_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE fabh_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE afat507_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM fabh_t
    WHERE fabhent = g_enterprise AND fabhld = g_fabgld_t
     AND fabhdocno = g_fabgdocno_t
 
    INTO TEMP afat507_detail
 
   #將key修正為調整後   
   UPDATE afat507_detail 
      #更新key欄位
      SET fabhld = g_fabg_m.fabgld
          , fabhdocno = g_fabg_m.fabgdocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO fabh_t SELECT * FROM afat507_detail
   
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
   DROP TABLE afat507_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_fabgld_t = g_fabg_m.fabgld
   LET g_fabgdocno_t = g_fabg_m.fabgdocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="afat507.delete" >}
#+ 資料刪除
PRIVATE FUNCTION afat507_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point     
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   DEFINE l_success    LIKE type_t.num5
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
 
   OPEN afat507_cl USING g_enterprise,g_fabg_m.fabgld,g_fabg_m.fabgdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN afat507_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE afat507_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE afat507_master_referesh USING g_fabg_m.fabgld,g_fabg_m.fabgdocno INTO g_fabg_m.fabgsite,g_fabg_m.fabg002, 
       g_fabg_m.fabg001,g_fabg_m.fabg003,g_fabg_m.fabgld,g_fabg_m.fabg004,g_fabg_m.fabg005,g_fabg_m.fabg008, 
       g_fabg_m.fabgdocno,g_fabg_m.fabg009,g_fabg_m.fabgdocdt,g_fabg_m.fabgstus,g_fabg_m.fabgownid,g_fabg_m.fabgowndp, 
       g_fabg_m.fabgcrtid,g_fabg_m.fabgcrtdp,g_fabg_m.fabgcrtdt,g_fabg_m.fabgmodid,g_fabg_m.fabgmoddt, 
       g_fabg_m.fabgcnfid,g_fabg_m.fabgcnfdt,g_fabg_m.fabgsite_desc,g_fabg_m.fabg002_desc,g_fabg_m.fabg001_desc, 
       g_fabg_m.fabg003_desc,g_fabg_m.fabgld_desc,g_fabg_m.fabgownid_desc,g_fabg_m.fabgowndp_desc,g_fabg_m.fabgcrtid_desc, 
       g_fabg_m.fabgcrtdp_desc,g_fabg_m.fabgmodid_desc,g_fabg_m.fabgcnfid_desc
   
   
   #檢查是否允許此動作
   IF NOT afat507_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_fabg_m_mask_o.* =  g_fabg_m.*
   CALL afat507_fabg_t_mask()
   LET g_fabg_m_mask_n.* =  g_fabg_m.*
   
   CALL afat507_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   #151231-00005#4--add--str--lujh
   IF NOT cl_null(g_fabg_m.fabgdocdt) THEN 
      IF NOT s_afa_date_chk(g_fabg_m.fabgld,'',g_fabg_m.fabgdocdt) THEN 
         CLOSE afat507_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF 
   END IF 
   #151231-00005#4--add--end--lujh
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL afat507_set_pk_array()
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
      
      DELETE FROM fabh_t
       WHERE fabhent = g_enterprise AND fabhld = g_fabg_m.fabgld
         AND fabhdocno = g_fabg_m.fabgdocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "fabh_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      #20150104 add by chenying
      IF g_glaa.glaa121 = 'Y' THEN
         CALL s_pre_voucher_del('FA','F50',g_fabg_m.fabgld,g_fabg_m.fabgdocno) RETURNING l_success
         
         IF l_success = FALSE THEN 
            CALL s_transaction_end('N','0')
            RETURN
         END IF
      END IF
      #20150104 add by chenying
      #end add-point
      
            
                                                               
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_fabg_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE afat507_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_fabh_d.clear() 
      CALL g_fabh3_d.clear()       
 
     
      CALL afat507_ui_browser_refresh()  
      #CALL afat507_ui_headershow()  
      #CALL afat507_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL afat507_browser_fill("")
         CALL afat507_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE afat507_cl
 
   #功能已完成,通報訊息中心
   CALL afat507_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="afat507.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION afat507_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
 
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_fabh_d.clear()
   CALL g_fabh3_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF afat507_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT fabhseq,fabh001,fabh002,fabh000,fabh005,fabh006,fabh007,fabh015, 
             fabh008,fabh011,fabh004,fabh017,fabh073,fabh020,fabh003,fabh023,fabh024,fabh025,fabhseq, 
             fabh100,fabh101,fabh102,fabh104,fabh108,fabh109,fabh111,fabh150,fabh151,fabh152,fabh154, 
             fabh158,fabh159,fabh161 ,t1.oocql004 FROM fabh_t",   
                     " INNER JOIN fabg_t ON fabgent = " ||g_enterprise|| " AND fabgld = fabhld ",
                     " AND fabgdocno = fabhdocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN oocql_t t1 ON t1.oocqlent="||g_enterprise||" AND t1.oocql001='3904' AND t1.oocql002=fabh020 AND t1.oocql003='"||g_dlang||"' ",
 
                     " WHERE fabhent=? AND fabhld=? AND fabhdocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         #161115-00003#1--add--s-- xul
         LET g_sql = "SELECT  DISTINCT fabhseq,fabh001,fabh002,fabh000,fabh005,fabh006,fabh007,fabh015, 
             fabh008,fabh011,fabh004,fabh017,fabh073,fabh020,fabh003,fabh023,fabh024,fabh025,fabhseq, 
             fabh100,fabh101,fabh102,fabh104,fabh108,fabh109,fabh111,fabh150,fabh151,fabh152,fabh154, 
             fabh158,fabh159,fabh161 ,t1.oocql004 FROM fabh_t",   
                     " INNER JOIN fabg_t ON fabgent = " ||g_enterprise|| " AND fabgld = fabhld ",
                     " AND fabgdocno = fabhdocno ",
 
                     #"",
                     
                     " LEFT JOIN faah_t ON fabhent = faahent AND fabh000 =faah001 AND fabh001 = faah003 AND fabh002 = faah004 ",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN oocql_t t1 ON t1.oocqlent="||g_enterprise||" AND t1.oocql001='3904' AND t1.oocql002=fabh020 AND t1.oocql003='"||g_dlang||"' ",
 
                     " WHERE fabhent=? AND fabhld=? AND fabhdocno=?"
         #161115-00003#1--add--e-- xul           
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY fabh_t.fabhseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
          
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE afat507_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR afat507_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_fabg_m.fabgld,g_fabg_m.fabgdocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_fabg_m.fabgld,g_fabg_m.fabgdocno INTO g_fabh_d[l_ac].fabhseq, 
          g_fabh_d[l_ac].fabh001,g_fabh_d[l_ac].fabh002,g_fabh_d[l_ac].fabh000,g_fabh_d[l_ac].fabh005, 
          g_fabh_d[l_ac].fabh006,g_fabh_d[l_ac].fabh007,g_fabh_d[l_ac].fabh015,g_fabh_d[l_ac].fabh008, 
          g_fabh_d[l_ac].fabh011,g_fabh_d[l_ac].fabh004,g_fabh_d[l_ac].fabh017,g_fabh_d[l_ac].fabh073, 
          g_fabh_d[l_ac].fabh020,g_fabh_d[l_ac].fabh003,g_fabh_d[l_ac].fabh023,g_fabh_d[l_ac].fabh024, 
          g_fabh_d[l_ac].fabh025,g_fabh3_d[l_ac].fabhseq,g_fabh3_d[l_ac].fabh100,g_fabh3_d[l_ac].fabh101, 
          g_fabh3_d[l_ac].fabh102,g_fabh3_d[l_ac].fabh104,g_fabh3_d[l_ac].fabh108,g_fabh3_d[l_ac].fabh109, 
          g_fabh3_d[l_ac].fabh111,g_fabh3_d[l_ac].fabh150,g_fabh3_d[l_ac].fabh151,g_fabh3_d[l_ac].fabh152, 
          g_fabh3_d[l_ac].fabh154,g_fabh3_d[l_ac].fabh158,g_fabh3_d[l_ac].fabh159,g_fabh3_d[l_ac].fabh161, 
          g_fabh_d[l_ac].fabh020_desc   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill.fill"
         SELECT faah012,faah013  #160426-00014#23 add faah013
           INTO g_fabh_d[l_ac].faah012,g_fabh_d[l_ac].faah013 #160426-00014#23 add g_fabh_d[l_ac].faah013  
           FROM faah_t
          WHERE faahent = g_enterprise
            AND faah001 = g_fabh_d[l_ac].fabh000
            AND faah003 = g_fabh_d[l_ac].fabh001
            AND faah004 = g_fabh_d[l_ac].fabh002
            
         #161115-00003#1--add--s--
         CALL afat507_get_faah025_faah026_desc()
         #161115-00003#1--add--e--
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
   CALL afat503_01_b_fill()
   #end add-point
   
   CALL g_fabh_d.deleteElement(g_fabh_d.getLength())
   CALL g_fabh3_d.deleteElement(g_fabh3_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE afat507_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_fabh_d.getLength()
      LET g_fabh_d_mask_o[l_ac].* =  g_fabh_d[l_ac].*
      CALL afat507_fabh_t_mask()
      LET g_fabh_d_mask_n[l_ac].* =  g_fabh_d[l_ac].*
   END FOR
   
   LET g_fabh3_d_mask_o.* =  g_fabh3_d.*
   FOR l_ac = 1 TO g_fabh3_d.getLength()
      LET g_fabh3_d_mask_o[l_ac].* =  g_fabh3_d[l_ac].*
      CALL afat507_fabh_t_mask()
      LET g_fabh3_d_mask_n[l_ac].* =  g_fabh3_d[l_ac].*
   END FOR
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="afat507.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION afat507_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM fabh_t
       WHERE fabhent = g_enterprise AND
         fabhld = ps_keys_bak[1] AND fabhdocno = ps_keys_bak[2] AND fabhseq = ps_keys_bak[3]
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
         CALL g_fabh_d.deleteElement(li_idx) 
      END IF 
      IF ps_page <> "'2'" THEN 
         CALL g_fabh3_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="afat507.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION afat507_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO fabh_t
                  (fabhent,
                   fabhld,fabhdocno,
                   fabhseq
                   ,fabh001,fabh002,fabh000,fabh005,fabh006,fabh007,fabh015,fabh008,fabh011,fabh004,fabh017,fabh073,fabh020,fabh003,fabh023,fabh024,fabh025,fabh100,fabh101,fabh102,fabh104,fabh108,fabh109,fabh111,fabh150,fabh151,fabh152,fabh154,fabh158,fabh159,fabh161) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_fabh_d[g_detail_idx].fabh001,g_fabh_d[g_detail_idx].fabh002,g_fabh_d[g_detail_idx].fabh000, 
                       g_fabh_d[g_detail_idx].fabh005,g_fabh_d[g_detail_idx].fabh006,g_fabh_d[g_detail_idx].fabh007, 
                       g_fabh_d[g_detail_idx].fabh015,g_fabh_d[g_detail_idx].fabh008,g_fabh_d[g_detail_idx].fabh011, 
                       g_fabh_d[g_detail_idx].fabh004,g_fabh_d[g_detail_idx].fabh017,g_fabh_d[g_detail_idx].fabh073, 
                       g_fabh_d[g_detail_idx].fabh020,g_fabh_d[g_detail_idx].fabh003,g_fabh_d[g_detail_idx].fabh023, 
                       g_fabh_d[g_detail_idx].fabh024,g_fabh_d[g_detail_idx].fabh025,g_fabh3_d[g_detail_idx].fabh100, 
                       g_fabh3_d[g_detail_idx].fabh101,g_fabh3_d[g_detail_idx].fabh102,g_fabh3_d[g_detail_idx].fabh104, 
                       g_fabh3_d[g_detail_idx].fabh108,g_fabh3_d[g_detail_idx].fabh109,g_fabh3_d[g_detail_idx].fabh111, 
                       g_fabh3_d[g_detail_idx].fabh150,g_fabh3_d[g_detail_idx].fabh151,g_fabh3_d[g_detail_idx].fabh152, 
                       g_fabh3_d[g_detail_idx].fabh154,g_fabh3_d[g_detail_idx].fabh158,g_fabh3_d[g_detail_idx].fabh159, 
                       g_fabh3_d[g_detail_idx].fabh161)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      CALL afat507_upd_fabh()
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "fabh_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_fabh_d.insertElement(li_idx) 
      END IF 
      IF ps_page <> "'2'" THEN 
         CALL g_fabh3_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="afat507.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION afat507_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "fabh_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL afat507_fabh_t_mask_restore('restore_mask_o')
               
      UPDATE fabh_t 
         SET (fabhld,fabhdocno,
              fabhseq
              ,fabh001,fabh002,fabh000,fabh005,fabh006,fabh007,fabh015,fabh008,fabh011,fabh004,fabh017,fabh073,fabh020,fabh003,fabh023,fabh024,fabh025,fabh100,fabh101,fabh102,fabh104,fabh108,fabh109,fabh111,fabh150,fabh151,fabh152,fabh154,fabh158,fabh159,fabh161) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_fabh_d[g_detail_idx].fabh001,g_fabh_d[g_detail_idx].fabh002,g_fabh_d[g_detail_idx].fabh000, 
                  g_fabh_d[g_detail_idx].fabh005,g_fabh_d[g_detail_idx].fabh006,g_fabh_d[g_detail_idx].fabh007, 
                  g_fabh_d[g_detail_idx].fabh015,g_fabh_d[g_detail_idx].fabh008,g_fabh_d[g_detail_idx].fabh011, 
                  g_fabh_d[g_detail_idx].fabh004,g_fabh_d[g_detail_idx].fabh017,g_fabh_d[g_detail_idx].fabh073, 
                  g_fabh_d[g_detail_idx].fabh020,g_fabh_d[g_detail_idx].fabh003,g_fabh_d[g_detail_idx].fabh023, 
                  g_fabh_d[g_detail_idx].fabh024,g_fabh_d[g_detail_idx].fabh025,g_fabh3_d[g_detail_idx].fabh100, 
                  g_fabh3_d[g_detail_idx].fabh101,g_fabh3_d[g_detail_idx].fabh102,g_fabh3_d[g_detail_idx].fabh104, 
                  g_fabh3_d[g_detail_idx].fabh108,g_fabh3_d[g_detail_idx].fabh109,g_fabh3_d[g_detail_idx].fabh111, 
                  g_fabh3_d[g_detail_idx].fabh150,g_fabh3_d[g_detail_idx].fabh151,g_fabh3_d[g_detail_idx].fabh152, 
                  g_fabh3_d[g_detail_idx].fabh154,g_fabh3_d[g_detail_idx].fabh158,g_fabh3_d[g_detail_idx].fabh159, 
                  g_fabh3_d[g_detail_idx].fabh161) 
         WHERE fabhent = g_enterprise AND fabhld = ps_keys_bak[1] AND fabhdocno = ps_keys_bak[2] AND fabhseq = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "fabh_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "fabh_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL afat507_fabh_t_mask_restore('restore_mask_n')
               
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
 
{<section id="afat507.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION afat507_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="afat507.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION afat507_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="afat507.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION afat507_lock_b(ps_table,ps_page)
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
   #CALL afat507_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1','2',"
   #僅鎖定自身table
   LET ls_group = "fabh_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN afat507_bcl USING g_enterprise,
                                       g_fabg_m.fabgld,g_fabg_m.fabgdocno,g_fabh_d[g_detail_idx].fabhseq  
                                               
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "afat507_bcl:",SQLERRMESSAGE 
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
 
{<section id="afat507.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION afat507_unlock_b(ps_table,ps_page)
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
      CLOSE afat507_bcl
   END IF
   
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="afat507.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION afat507_set_entry(p_cmd)
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
 
{<section id="afat507.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION afat507_set_no_entry(p_cmd)
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
 
{<section id="afat507.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION afat507_set_entry_b(p_cmd)
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
 
{<section id="afat507.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION afat507_set_no_entry_b(p_cmd)
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
 
{<section id="afat507.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION afat507_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   CALL cl_set_act_visible("modify,delete,insert,modify_detail", TRUE)
   IF g_fabg_m.fabgstus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="afat507.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION afat507_set_act_no_visible()
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
 
{<section id="afat507.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION afat507_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="afat507.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION afat507_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="afat507.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION afat507_default_search()
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
               WHEN la_wc[li_idx].tableid = "fabh_t" 
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
 
{<section id="afat507.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION afat507_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE  lc_state_t  LIKE type_t.chr5
   DEFINE  l_fabgcnfdt DATETIME YEAR TO SECOND
   DEFINE  l_success   LIKE type_t.chr1
   DEFINE  l_wc        STRING
   #20150608--add--str--lujh
   DEFINE  l_gzzd005   LIKE gzzd_t.gzzd005
   DEFINE  l_colname   STRING
   DEFINE  l_comment   STRING
   #20150608--add--end--lujh
   
   #151125-00006#3-s
   DEFINE l_dfin0032    LIKE type_t.chr1
   DEFINE l_ooba002     LIKE ooba_t.ooba002
   DEFINE l_fabgcomp    LIKE fabg_t.fabgcomp
   DEFINE l_ld          LIKE fabg_t.fabgld
   #151125-00006#3-e

   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   LET lc_state_t = 'flag'  
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
   
   OPEN afat507_cl USING g_enterprise,g_fabg_m.fabgld,g_fabg_m.fabgdocno
   IF STATUS THEN
      CLOSE afat507_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN afat507_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE afat507_master_referesh USING g_fabg_m.fabgld,g_fabg_m.fabgdocno INTO g_fabg_m.fabgsite,g_fabg_m.fabg002, 
       g_fabg_m.fabg001,g_fabg_m.fabg003,g_fabg_m.fabgld,g_fabg_m.fabg004,g_fabg_m.fabg005,g_fabg_m.fabg008, 
       g_fabg_m.fabgdocno,g_fabg_m.fabg009,g_fabg_m.fabgdocdt,g_fabg_m.fabgstus,g_fabg_m.fabgownid,g_fabg_m.fabgowndp, 
       g_fabg_m.fabgcrtid,g_fabg_m.fabgcrtdp,g_fabg_m.fabgcrtdt,g_fabg_m.fabgmodid,g_fabg_m.fabgmoddt, 
       g_fabg_m.fabgcnfid,g_fabg_m.fabgcnfdt,g_fabg_m.fabgsite_desc,g_fabg_m.fabg002_desc,g_fabg_m.fabg001_desc, 
       g_fabg_m.fabg003_desc,g_fabg_m.fabgld_desc,g_fabg_m.fabgownid_desc,g_fabg_m.fabgowndp_desc,g_fabg_m.fabgcrtid_desc, 
       g_fabg_m.fabgcrtdp_desc,g_fabg_m.fabgmodid_desc,g_fabg_m.fabgcnfid_desc
   
 
   #檢查是否允許此動作
   IF NOT afat507_action_chk() THEN
      CLOSE afat507_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_fabg_m.fabgsite,g_fabg_m.fabgsite_desc,g_fabg_m.fabg002,g_fabg_m.fabg002_desc,g_fabg_m.fabg001, 
       g_fabg_m.fabg001_desc,g_fabg_m.fabg003,g_fabg_m.fabg003_desc,g_fabg_m.fabgld,g_fabg_m.fabgld_desc, 
       g_fabg_m.fabg004,g_fabg_m.fabg005,g_fabg_m.fabg008,g_fabg_m.fabgdocno,g_fabg_m.fabg009,g_fabg_m.fabgdocdt, 
       g_fabg_m.fabgstus,g_fabg_m.fabgownid,g_fabg_m.fabgownid_desc,g_fabg_m.fabgowndp,g_fabg_m.fabgowndp_desc, 
       g_fabg_m.fabgcrtid,g_fabg_m.fabgcrtid_desc,g_fabg_m.fabgcrtdp,g_fabg_m.fabgcrtdp_desc,g_fabg_m.fabgcrtdt, 
       g_fabg_m.fabgmodid,g_fabg_m.fabgmodid_desc,g_fabg_m.fabgmoddt,g_fabg_m.fabgcnfid,g_fabg_m.fabgcnfid_desc, 
       g_fabg_m.fabgcnfdt
 
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
   #151231-00005#4--add--str--lujh
   IF NOT cl_null(g_fabg_m.fabgdocdt) THEN 
      IF NOT s_afa_date_chk(g_fabg_m.fabgld,'',g_fabg_m.fabgdocdt) THEN 
         CLOSE afat507_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF 
   END IF 
   #151231-00005#4--add--end--lujh
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
            CALL cl_set_act_visible("unconfirmed,invalid,confirmed,hold",FALSE) #141208-00022#1 add
            CALL s_transaction_end('N','0')   #160812-00017#6 20160822 add by beckxie
            RETURN

         WHEN "Y"   #已確認
            CALL cl_set_act_visible("unconfirmed,posted,hold",TRUE)  #141208-00022#1 mark  #160616-00005#3 remark
            #CALL cl_set_act_visible("invalid,confirmed,hold",FALSE)   #141208-00022#1 add #160616-00005#3 mark  
      

         WHEN "S"   #已過帳
            CALL cl_set_act_visible("unposted",TRUE)

         WHEN "A"   #已核准
            CALL cl_set_act_visible("confirmed ",TRUE)

         WHEN "R"   #已拒絕
#141208-00022#1 mod--str--         
#            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
#            CALL cl_set_act_visible("invalid,confirmed",TRUE)
#
#            IF cl_bpm_chk() THEN
#               CALL cl_set_act_visible("signing",TRUE)
#               CALL cl_set_act_visible("confirmed",FALSE)
#            END IF
            #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed",FALSE)
#141208-00022#1 mod--end--            

         WHEN "D"   #抽單
#141208-00022#1 mod--str--           
#            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
#            CALL cl_set_act_visible("invalid,confirmed",TRUE)
#
#            IF cl_bpm_chk() THEN
#               CALL cl_set_act_visible("signing",TRUE)
#               CALL cl_set_act_visible("confirmed",FALSE)
#            END IF

            #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed,hold",FALSE)
#141208-00022#1 mod--end--  
         WHEN "W"   #送簽中
            CALL cl_set_act_visible("withdraw",TRUE)
            ##只能顯示抽單;其餘應用功能皆隱藏
            CALL cl_set_act_visible("unconfirmed,invalid,confirmed,hold",FALSE) #141208-00022#1 add            

         WHEN "H"  #留置
            CALL cl_set_act_visible("unhold",TRUE)

#         WHEN "UH" #取消留置
#         WHEN "Z"  #扣帳還原

      END CASE
      
        
      LET l_success=TRUE
      CALL s_transaction_begin()
      CALL cl_err_collect_init()
      #end add-point
      
      #應用 a36 樣板自動產生(Version:5)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT afat507_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE afat507_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT afat507_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE afat507_cl
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
            #20150608--add--str--lujh
            CALL s_azzi902_get_gzzd('afap100',"lbl_faah001") RETURNING l_colname,l_comment  #卡片编号
            LET g_coll_title[1] = l_colname
            CALL s_azzi902_get_gzzd('afap100',"lbl_faah003") RETURNING l_colname,l_comment  #财产编号
            LET g_coll_title[2] = l_colname
            CALL s_azzi902_get_gzzd('afap100',"lbl_faah004") RETURNING l_colname,l_comment  #符号
            LET g_coll_title[3] = l_colname
            
            CALL s_afa_p_faan_chk(g_fabg_m.fabgld,g_fabg_m.fabgdocno,g_fabg_m.fabgdocdt,'fabh_t','fabh000','fabh001','fabh002') RETURNING l_success
            IF l_success = FALSE THEN 
               CALL s_transaction_end('N','0')   #160812-00017#6 20160822 add by beckxie
               CALL cl_err_collect_show()
               RETURN 
            END IF
            #20150608--add--end--lujh
            
            CALL s_afat503_unconf_chk_fabg(g_fabg_m.fabgld,g_fabg_m.fabgdocno) RETURNING l_success
            IF l_success = TRUE THEN
               CALL s_afat503_unconf_upd_fabg(g_fabg_m.fabgld,g_fabg_m.fabgdocno) RETURNING l_success 
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
            #20150608--add--str--lujh
            CALL s_azzi902_get_gzzd('afap100',"lbl_faah001") RETURNING l_colname,l_comment  #卡片编号
            LET g_coll_title[1] = l_colname
            CALL s_azzi902_get_gzzd('afap100',"lbl_faah003") RETURNING l_colname,l_comment  #财产编号
            LET g_coll_title[2] = l_colname
            CALL s_azzi902_get_gzzd('afap100',"lbl_faah004") RETURNING l_colname,l_comment  #符号
            LET g_coll_title[3] = l_colname
            
            CALL s_afa_p_faan_chk(g_fabg_m.fabgld,g_fabg_m.fabgdocno,g_fabg_m.fabgdocdt,'fabh_t','fabh000','fabh001','fabh002') RETURNING l_success
            IF l_success = FALSE THEN 
               CALL s_transaction_end('N','0')   #160812-00017#6 20160822 add by beckxie
               CALL cl_err_collect_show()
               RETURN 
            END IF
            #20150608--add--end--lujh
            
            CALL s_afat503_conf_chk_fabg(g_fabg_m.fabgld,g_fabg_m.fabgdocno) RETURNING l_success
            IF l_success = TRUE THEN
               CALL s_afat503_conf_upd_fabg(g_fabg_m.fabgld,g_fabg_m.fabgdocno) RETURNING l_success 
            END IF 
            #end add-point
         END IF
         EXIT MENU
      ON ACTION unposted
         IF cl_auth_chk_act("unposted") THEN
            LET lc_state = "Z"
            #add-point:action控制 name="statechange.unposted"
            LET lc_state = "Y"  #20141218 add by chenying 
            #20150608--add--str--lujh
            CALL s_azzi902_get_gzzd('afap100',"lbl_faah001") RETURNING l_colname,l_comment  #卡片编号
            LET g_coll_title[1] = l_colname
            CALL s_azzi902_get_gzzd('afap100',"lbl_faah003") RETURNING l_colname,l_comment  #财产编号
            LET g_coll_title[2] = l_colname
            CALL s_azzi902_get_gzzd('afap100',"lbl_faah004") RETURNING l_colname,l_comment  #符号
            LET g_coll_title[3] = l_colname
            
            CALL s_afa_p_faan_chk(g_fabg_m.fabgld,g_fabg_m.fabgdocno,g_fabg_m.fabgdocdt,'fabh_t','fabh000','fabh001','fabh002') RETURNING l_success
            IF l_success = FALSE THEN 
               CALL s_transaction_end('N','0')   #160812-00017#6 20160822 add by beckxie
               CALL cl_err_collect_show()
               RETURN 
            END IF
            #20150608--add--end--lujh
            
            CALL s_afat503_unpost_chk_fabg(g_fabg_m.fabgld,g_fabg_m.fabgdocno) RETURNING l_success
            IF l_success = TRUE THEN
               CALL s_afat503_unpost_upd_fabg(g_fabg_m.fabgld,g_fabg_m.fabgdocno) RETURNING l_success
            END IF
            #end add-point
         END IF
         EXIT MENU
      ON ACTION posted
         IF cl_auth_chk_act("posted") THEN
            LET lc_state = "S"
            #add-point:action控制 name="statechange.posted"
            #20150608--add--str--lujh
            CALL s_azzi902_get_gzzd('afap100',"lbl_faah001") RETURNING l_colname,l_comment  #卡片编号
            LET g_coll_title[1] = l_colname
            CALL s_azzi902_get_gzzd('afap100',"lbl_faah003") RETURNING l_colname,l_comment  #财产编号
            LET g_coll_title[2] = l_colname
            CALL s_azzi902_get_gzzd('afap100',"lbl_faah004") RETURNING l_colname,l_comment  #符号
            LET g_coll_title[3] = l_colname
            
            CALL s_afa_p_faan_chk(g_fabg_m.fabgld,g_fabg_m.fabgdocno,g_fabg_m.fabgdocdt,'fabh_t','fabh000','fabh001','fabh002') RETURNING l_success
            IF l_success = FALSE THEN 
               CALL s_transaction_end('N','0')   #160812-00017#6 20160822 add by beckxie
               CALL cl_err_collect_show()
               RETURN 
            END IF
            #20150608--add--end--lujh
            
            CALL s_afat503_post_chk_fabg(g_fabg_m.fabgld,g_fabg_m.fabgdocno) RETURNING l_success
            IF l_success = TRUE THEN
               CALL s_afat503_post_upd_fabg(g_fabg_m.fabgld,g_fabg_m.fabgdocno) RETURNING l_success 
            END IF 
            #end add-point
         END IF
         EXIT MENU
      ON ACTION invalid
         IF cl_auth_chk_act("invalid") THEN
            LET lc_state = "X"
            #add-point:action控制 name="statechange.invalid"
            #20150608--add--str--lujh
            CALL s_azzi902_get_gzzd('afap100',"lbl_faah001") RETURNING l_colname,l_comment  #卡片编号
            LET g_coll_title[1] = l_colname
            CALL s_azzi902_get_gzzd('afap100',"lbl_faah003") RETURNING l_colname,l_comment  #财产编号
            LET g_coll_title[2] = l_colname
            CALL s_azzi902_get_gzzd('afap100',"lbl_faah004") RETURNING l_colname,l_comment  #符号
            LET g_coll_title[3] = l_colname
            
            CALL s_afa_p_faan_chk(g_fabg_m.fabgld,g_fabg_m.fabgdocno,g_fabg_m.fabgdocdt,'fabh_t','fabh000','fabh001','fabh002') RETURNING l_success
            IF l_success = FALSE THEN 
               CALL s_transaction_end('N','0')   #160812-00017#6 20160822 add by beckxie
               CALL cl_err_collect_show()
               RETURN 
            END IF
            #20150608--add--end--lujh
            
            CALL s_afat503_void_chk_fabg(g_fabg_m.fabgld,g_fabg_m.fabgdocno) RETURNING l_success
            IF l_success = TRUE THEN
               #151125-00001#1 add start ------------------
               IF NOT cl_ask_confirm('aim-00109') THEN
                  CALL s_transaction_end('N','0')   #160812-00017#6 20160822 add by beckxie
                  RETURN
               ELSE
               #151125-00001#1 add end   ------------------
                  CALL s_afat503_void_upd_fabg(g_fabg_m.fabgld,g_fabg_m.fabgdocno) RETURNING l_success
               END IF   #151125-00001#1 add                  
            END IF 
            #end add-point
         END IF
         EXIT MENU
 
      #add-point:stus控制 name="statechange.more_control"
#      ON ACTION undeduct
#         LET lc_state = "Y"
#         CALL s_afat503_unpost_chk_fabg(g_fabg_m.fabgld,g_fabg_m.fabgdocno) RETURNING l_success
#         IF l_success = TRUE THEN
#            CALL s_afat503_unpost_upd_fabg(g_fabg_m.fabgld,g_fabg_m.fabgdocno) RETURNING l_success
#         END IF 
#         
#         EXIT MENU 
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
      CLOSE afat507_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   #20150104 add by chenying
   IF l_success = TRUE THEN   
      IF g_glaa.glaa121 = 'Y' THEN 
         LET l_wc = "glgadocno = '",g_fabg_m.fabgdocno,"'"
         CALL s_pre_voucher_upd('FA','F50',g_fabg_m.fabgld,lc_state,'','',l_wc) RETURNING l_success
      END IF
   END IF   
   #20150104 add by chenying    
   IF l_success = FALSE  THEN
      CALL cl_err_collect_show() 
      CALL s_transaction_end('N','0') 
      RETURN    
   ELSE
      CALL cl_err_collect_init()  
      CALL cl_err_collect_show()    
      CALL s_transaction_end('Y','0')    
   END IF

#   #151125-00006#3--s
#   IF lc_state = 'S' THEN 
#      CALL s_aooi200_fin_get_slip(g_fabg_m.fabgdocno) RETURNING l_success,l_ooba002
#      CALL s_fin_orga_get_comp_ld(g_fabg_m.fabgsite) RETURNING g_sub_success,g_errno,l_fabgcomp,l_ld
#      CALL s_fin_get_doc_para(g_fabg_m.fabgld,l_fabgcomp,l_ooba002,'D-FIN-0032') RETURNING l_dfin0032
#      IF NOT cl_null(l_dfin0032) AND l_dfin0032 MATCHES '[Yy]' THEN 
#         IF cl_ask_confirm('axr-00888') THEN              
#            CALL s_afat503_fabg_immediately_gen(g_fabg_m.fabgld,g_fabg_m.fabgdocno,g_fabg_m.fabgstus,g_fabg_m.fabg005,g_fabg_m.fabg008)
#            CALL afat507_ui_headershow()
#         END IF 
#      END IF 
#   END IF
#   #151125-00006#3--e
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
      EXECUTE afat507_master_referesh USING g_fabg_m.fabgld,g_fabg_m.fabgdocno INTO g_fabg_m.fabgsite, 
          g_fabg_m.fabg002,g_fabg_m.fabg001,g_fabg_m.fabg003,g_fabg_m.fabgld,g_fabg_m.fabg004,g_fabg_m.fabg005, 
          g_fabg_m.fabg008,g_fabg_m.fabgdocno,g_fabg_m.fabg009,g_fabg_m.fabgdocdt,g_fabg_m.fabgstus, 
          g_fabg_m.fabgownid,g_fabg_m.fabgowndp,g_fabg_m.fabgcrtid,g_fabg_m.fabgcrtdp,g_fabg_m.fabgcrtdt, 
          g_fabg_m.fabgmodid,g_fabg_m.fabgmoddt,g_fabg_m.fabgcnfid,g_fabg_m.fabgcnfdt,g_fabg_m.fabgsite_desc, 
          g_fabg_m.fabg002_desc,g_fabg_m.fabg001_desc,g_fabg_m.fabg003_desc,g_fabg_m.fabgld_desc,g_fabg_m.fabgownid_desc, 
          g_fabg_m.fabgowndp_desc,g_fabg_m.fabgcrtid_desc,g_fabg_m.fabgcrtdp_desc,g_fabg_m.fabgmodid_desc, 
          g_fabg_m.fabgcnfid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_fabg_m.fabgsite,g_fabg_m.fabgsite_desc,g_fabg_m.fabg002,g_fabg_m.fabg002_desc, 
          g_fabg_m.fabg001,g_fabg_m.fabg001_desc,g_fabg_m.fabg003,g_fabg_m.fabg003_desc,g_fabg_m.fabgld, 
          g_fabg_m.fabgld_desc,g_fabg_m.fabg004,g_fabg_m.fabg005,g_fabg_m.fabg008,g_fabg_m.fabgdocno, 
          g_fabg_m.fabg009,g_fabg_m.fabgdocdt,g_fabg_m.fabgstus,g_fabg_m.fabgownid,g_fabg_m.fabgownid_desc, 
          g_fabg_m.fabgowndp,g_fabg_m.fabgowndp_desc,g_fabg_m.fabgcrtid,g_fabg_m.fabgcrtid_desc,g_fabg_m.fabgcrtdp, 
          g_fabg_m.fabgcrtdp_desc,g_fabg_m.fabgcrtdt,g_fabg_m.fabgmodid,g_fabg_m.fabgmodid_desc,g_fabg_m.fabgmoddt, 
          g_fabg_m.fabgcnfid,g_fabg_m.fabgcnfid_desc,g_fabg_m.fabgcnfdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   #151125-00006#3--s
   IF lc_state = 'S' THEN 
      CALL s_aooi200_fin_get_slip(g_fabg_m.fabgdocno) RETURNING l_success,l_ooba002
      CALL s_fin_orga_get_comp_ld(g_fabg_m.fabgsite) RETURNING g_sub_success,g_errno,l_fabgcomp,l_ld
      CALL s_fin_get_doc_para(g_fabg_m.fabgld,l_fabgcomp,l_ooba002,'D-FIN-0032') RETURNING l_dfin0032
      IF NOT cl_null(l_dfin0032) AND l_dfin0032 MATCHES '[Yy]' THEN 
         IF cl_ask_confirm('axr-00888') THEN              
            CALL s_afat503_fabg_immediately_gen(g_fabg_m.fabgld,g_fabg_m.fabgdocno,g_fabg_m.fabgstus,g_fabg_m.fabg005,g_fabg_m.fabg008)
            CALL afat507_ui_headershow()
         END IF 
      END IF 
   END IF
   #151125-00006#3--e
   #end add-point  
 
   CLOSE afat507_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL afat507_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="afat507.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION afat507_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_fabh_d.getLength() THEN
         LET g_detail_idx = g_fabh_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_fabh_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_fabh_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx > g_fabh3_d.getLength() THEN
         LET g_detail_idx = g_fabh3_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_fabh3_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_fabh3_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="afat507.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION afat507_b_fill2(pi_idx)
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
   
   CALL afat507_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="afat507.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION afat507_fill_chk(ps_idx)
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
 
{<section id="afat507.status_show" >}
PRIVATE FUNCTION afat507_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="afat507.mask_functions" >}
&include "erp/afa/afat507_mask.4gl"
 
{</section>}
 
{<section id="afat507.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION afat507_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
 
 
   CALL afat507_show()
   CALL afat507_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   IF NOT s_afat503_conf_chk_fabg(g_fabg_m.fabgld,g_fabg_m.fabgdocno) THEN
      RETURN
   END IF   
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_fabg_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_fabh_d))
   CALL cl_bpm_set_detail_data("s_detail3", util.JSONArray.fromFGL(g_fabh3_d))
 
 
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
   #CALL afat507_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL afat507_ui_headershow()
   CALL afat507_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION afat507_draw_out()
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
   CALL afat507_ui_headershow()  
   CALL afat507_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="afat507.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION afat507_set_pk_array()
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
 
{<section id="afat507.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="afat507.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION afat507_msgcentre_notify(lc_state)
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
   CALL afat507_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_fabg_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="afat507.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION afat507_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#10  2016/08/25 By 07900   --add--s--
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
        CALL afat507_set_act_visible()
        CALL afat507_set_act_no_visible()
        CALL afat507_show()
        RETURN FALSE
     END IF
   END IF
   
   #160818-00017#10  2016/08/25 By 07900   --add--s--   
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="afat507.other_function" readonly="Y" >}
################################################################################
# Descriptions...: 獲取資產中心說明
# Memo...........:
# Usage..........: CALL s_afat507_get_fabgsite_desc()
# Input parameter:  
# Return code....:  
# Date & Author..: 2014/3/21 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION afat507_get_fabgsite_desc()
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fabg_m.fabgsite
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_fabg_m.fabgsite_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fabg_m.fabgsite_desc
END FUNCTION
################################################################################
# Descriptions...: 獲取賬務人員說明
# Memo...........:
# Usage..........: CALL afat507_get_fabg001_desc
# Input parameter:  
# Return code....:  
# Date & Author..: 2014/3/21 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION afat507_get_fabg001_desc()
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fabg_m.fabg001
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_fabg_m.fabg001_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fabg_m.fabg001_desc
END FUNCTION
################################################################################
# Descriptions...: 獲取帳套說明
# Memo...........:
# Usage..........: CALL afat507_get_fabgld_desc()
# Input parameter:  
# Return code....:  
# Date & Author..: 2014/3/21 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION afat507_get_fabgld_desc()
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fabg_m.fabgld
            CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_fabg_m.fabgld_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fabg_m.fabgld_desc
END FUNCTION
################################################################################
# Descriptions...: 獲取申請人員名稱
# Memo...........:
# Usage..........: CALL afat507_get_fabg002_desc()
# Input parameter:  
# Return code....:  
# Date & Author..: 2014/3/21 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION afat507_get_fabg002_desc()
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fabg_m.fabg002
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_fabg_m.fabg002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fabg_m.fabg002_desc
END FUNCTION
################################################################################
# Descriptions...: 獲取申請部門名稱
# Memo...........:
# Usage..........: CALL afat507_get_fabg003_desc()
# Input parameter:  
# Return code....:  
# Date & Author..: 2014/3/21 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION afat507_get_fabg003_desc()
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fabg_m.fabg003
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_fabg_m.fabg003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fabg_m.fabg003_desc
END FUNCTION
################################################################################
# Descriptions...: 獲取單位、數量 
# Memo...........:
# Usage..........: CALL afat507_get_faah()
# Input parameter:  
# Return code....:  
# Date & Author..: 2014/3/23 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION afat507_get_faah()
   DEFINE l_faah018  LIKE faah_t.faah018
   DEFINE l_faaj033  LIKE faaj_t.faaj033

   SELECT faah017,faah018,faah015,faah012,faah013  #160426-00014#23 add faah013 
     INTO g_fabh_d[l_ac].fabh005,l_faah018,g_fabh_d[l_ac].fabh003,g_fabh_d[l_ac].faah012,g_fabh_d[l_ac].faah013 #160426-00014#23 add g_fabh_d[l_ac].faah013 
     FROM faah_t
    WHERE faahent = g_enterprise
      AND faah001 = g_fabh_d[l_ac].fabh000
      AND faah003 = g_fabh_d[l_ac].fabh001
      AND faah004 = g_fabh_d[l_ac].fabh002
      
   SELECT faaj023,faaj024,faaj026,faaj033  
     INTO g_fabh_d[l_ac].fabh024,g_fabh_d[l_ac].fabh023,g_fabh_d[l_ac].fabh025,l_faaj033         
     FROM faaj_t
    WHERE faajent=g_enterprise 
      AND faajld=g_fabg_m.fabgld
      AND faaj001=g_fabh_d[l_ac].fabh001 
      AND faaj002=g_fabh_d[l_ac].fabh002
      AND faaj037=g_fabh_d[l_ac].fabh000  
    
   IF NOT cl_null(l_faah018) AND NOT cl_null(l_faah018) THEN
      LET g_fabh_d[l_ac].fabh006 = l_faah018 - l_faaj033
   ELSE
      LET g_fabh_d[l_ac].fabh006 = 0 
   END IF   
   DISPLAY BY NAME g_fabh_d[l_ac].fabh005,g_fabh_d[l_ac].fabh006,g_fabh_d[l_ac].fabh003,
                   g_fabh_d[l_ac].fabh024,g_fabh_d[l_ac].fabh023,g_fabh_d[l_ac].fabh025   
   
   #160824-00007#248 161208 by lori add---(S)
   LET g_fabh_d_o.fabh005 = g_fabh_d[l_ac].fabh005 
   LET g_fabh_d_o.fabh003 = g_fabh_d[l_ac].fabh003 
   LET g_fabh_d_o.faah012 = g_fabh_d[l_ac].faah012 
   LET g_fabh_d_o.faah013 = g_fabh_d[l_ac].faah013 
   LET g_fabh_d_o.fabh024 = g_fabh_d[l_ac].fabh024 
   LET g_fabh_d_o.fabh023 = g_fabh_d[l_ac].fabh023 
   LET g_fabh_d_o.fabh025 = g_fabh_d[l_ac].fabh025 
   LET g_fabh_d_o.fabh006 = g_fabh_d[l_ac].fabh006 
   #160824-00007#248 161208 by lori add---(E)   
END FUNCTION
################################################################################
# Descriptions...: 預設銷賬數量\獲取成本、累計折舊、未折減額、已提列減值 
# Memo...........:
# Usage..........: CALLafat507_get_faaj()
# Input parameter: afat507_get_faaj()
# Return code....: afat507_get_faaj()
# Date & Author..: 2014/3/23 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION afat507_get_faaj()
   DEFINE l_faaj033 LIKE faaj_t.faaj033
   DEFINE l_faaj035 LIKE faaj_t.faaj035
   DEFINE l_faaj016 LIKE faaj_t.faaj016
   DEFINE l_faaj017 LIKE faaj_t.faaj017
   DEFINE l_faaj034 LIKE faaj_t.faaj034
   DEFINE l_faaj021 LIKE faaj_t.faaj021
   DEFINE l_faaj027 LIKE faaj_t.faaj027
   DEFINE l_faaj032 LIKE faaj_t.faaj032   #160331-00003#2
   DEFINE l_faaj018 LIKE faaj_t.faaj018   #160331-00003#2
   DEFINE l_faah018 LIKE faah_t.faah018   #160331-00003#2

                                                                  
 #  SELECT faaj033,faaj016,faaj034,faaj017,faaj035,faaj021,faaj027                                  #160331-00003#2  mark
 #    INTO l_faaj033,l_faaj016,l_faaj034,l_faaj017,l_faaj035,l_faaj021,l_faaj027                    #160331-00003#2  mark
   SELECT faaj033,faaj016,faaj034,faaj017,faaj035,faaj021,faaj027,faaj032,faaj018                   #160331-00003#2  add
     INTO l_faaj033,l_faaj016,l_faaj034,l_faaj017,l_faaj035,l_faaj021,l_faaj027,l_faaj032,l_faaj018 #160331-00003#2  add
     FROM faaj_t
    WHERE faajent = g_enterprise
      AND faajld = g_fabg_m.fabgld 
      AND faaj001 = g_fabh_d[l_ac].fabh001
      AND faaj002 = g_fabh_d[l_ac].fabh002
   #160331-00003#2  add -str
   SELECT faah018 INTO l_faah018 FROM faah_t
    WHERE faahent = g_enterprise 
      AND faah001 = g_fabh_d[l_ac].fabh000
      AND faah003 = g_fabh_d[l_ac].fabh001
      AND faah004 = g_fabh_d[l_ac].fabh002
   #160331-00003#2  add -end  
   #預設銷賬數量
   LET g_fabh_d[l_ac].fabh007 = g_fabh_d[l_ac].fabh006 - l_faaj033   
 
   #成本
   LET g_fabh_d[l_ac].fabh008 = l_faaj016 - l_faaj034
   IF cl_null(g_fabh_d[l_ac].fabh008) THEN 
      LET g_fabh_d[l_ac].fabh008 = 0
   END IF
   
   #累折
   LET g_fabh_d[l_ac].fabh011 = l_faaj017 - l_faaj035
   IF cl_null(g_fabh_d[l_ac].fabh011) THEN 
      LET g_fabh_d[l_ac].fabh011 = 0
   END IF
   
   #未折減額
   LET g_fabh_d[l_ac].fabh004 = g_fabh_d[l_ac].fabh008 - g_fabh_d[l_ac].fabh011
   IF cl_null(g_fabh_d[l_ac].fabh004) THEN 
      LET g_fabh_d[l_ac].fabh004 = 0
   END IF
   
   #已提列減值準備
   LET g_fabh_d[l_ac].fabh017 = l_faaj021 - l_faaj027
   IF cl_null(g_fabh_d[l_ac].fabh017) THEN 
      LET g_fabh_d[l_ac].fabh017 = 0
   END IF
   #160331-00003#2  add -str
   LET g_fabh_d[l_ac].fabh073 =  (l_faaj018 - l_faaj032)/(l_faah018 - l_faaj033 )* g_fabh_d[l_ac].fabh007
    IF cl_null(g_fabh_d[l_ac].fabh073) THEN 
      LET g_fabh_d[l_ac].fabh073 = 0
   END IF
   #160331-00003#2  add -end
  
   #160824-00007#248 161208 by lori add---(S)
   LET g_fabh_d_o.fabh007 = g_fabh_d[l_ac].fabh007
   LET g_fabh_d_o.fabh008 = g_fabh_d[l_ac].fabh008
   LET g_fabh_d_o.fabh011 = g_fabh_d[l_ac].fabh011
   LET g_fabh_d_o.fabh004 = g_fabh_d[l_ac].fabh004
   LET g_fabh_d_o.fabh017 = g_fabh_d[l_ac].fabh017
   LET g_fabh_d_o.fabh073 = g_fabh_d[l_ac].fabh073    
   #160824-00007#248 161208 by lori add---(E)
END FUNCTION
################################################################################
# Descriptions...: 獲取異動原因說明
# Memo...........:
# Usage..........: CALL afat507_get_fabh020_desc()
# Input parameter:  
# Return code....:  
# Date & Author..: 2014/3/23 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION afat507_get_fabh020_desc()
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fabh_d[l_ac].fabh020
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='3904' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_fabh_d[l_ac].fabh020_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fabh_d[l_ac].fabh020_desc
END FUNCTION
################################################################################
# Descriptions...: 獲取多本位幣明細
# Memo...........:
# Usage..........: CALL afat507_get_faaj_1()
# Input parameter:  
# Return code....:  
# Date & Author..: 2014/3/23 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION afat507_get_faaj_1()
   DEFINE l_glaa001 LIKE glaa_t.glaa001
   DEFINE l_glaa019 LIKE glaa_t.glaa019
   DEFINE l_glaa018 LIKE glaa_t.glaa018
   DEFINE l_glaa022 LIKE glaa_t.glaa022
   DEFINE l_glaa015 LIKE glaa_t.glaa015
   DEFINE l_glaa016 LIKE glaa_t.glaa016
   DEFINE l_glaa020 LIKE glaa_t.glaa020
   DEFINE l_rate2   LIKE fabd_t.fabd009 
   DEFINE l_rate3   LIKE fabd_t.fabd009 

   LET g_fabh3_d[l_ac].fabhseq = g_fabh_d[l_ac].fabhseq
   DISPLAY BY NAME g_fabh3_d[l_ac].fabhseq
   
   #本位幣二 幣別、匯率
   IF g_glaa.glaa015 = 'Y' THEN
 
      CALL s_aooi160_get_exrate('2',g_fabg_m.fabgld,g_today,g_glaa.glaa001,
                                   #目的幣別                 #匯類類型
                                   g_glaa.glaa016,0,g_glaa.glaa018)
         RETURNING l_rate2  
      
      LET g_fabh3_d[l_ac].fabh100 = g_glaa.glaa016 
      LET g_fabh3_d[l_ac].fabh101 = g_fabh_d[l_ac].fabh007 * l_rate2
      LET g_fabh3_d[l_ac].fabh102 = g_fabh_d[l_ac].fabh008 * l_rate2
      LET g_fabh3_d[l_ac].fabh104 = g_fabh_d[l_ac].fabh011 * l_rate2      
      LET g_fabh3_d[l_ac].fabh108 = g_fabh_d[l_ac].fabh004 * l_rate2 
      LET g_fabh3_d[l_ac].fabh109 = g_fabh_d[l_ac].fabh017 * l_rate2 
      LET g_fabh3_d[l_ac].fabh111 = g_fabh_d[l_ac].fabh073 * l_rate2 #160331-00003#2      

      DISPLAY BY NAME g_fabh3_d[l_ac].fabh100
      DISPLAY BY NAME g_fabh3_d[l_ac].fabh101
      DISPLAY BY NAME g_fabh3_d[l_ac].fabh102
      DISPLAY BY NAME g_fabh3_d[l_ac].fabh104
      DISPLAY BY NAME g_fabh3_d[l_ac].fabh108
      DISPLAY BY NAME g_fabh3_d[l_ac].fabh109
      DISPLAY BY NAME g_fabh3_d[l_ac].fabh111                        #160331-00003#2      
   END IF
   
   #本位幣三 幣別、匯率
   IF g_glaa.glaa019 = 'Y' THEN

      CALL s_aooi160_get_exrate('2',g_fabg_m.fabgld,g_today,g_glaa.glaa001,
                                   #目的幣別                 #匯類類型
                                   g_glaa.glaa020,0,g_glaa.glaa022)
         RETURNING l_rate3   

      LET g_fabh3_d[l_ac].fabh150 = g_glaa.glaa020 
      LET g_fabh3_d[l_ac].fabh151 = g_fabh_d[l_ac].fabh007 * l_rate3
      LET g_fabh3_d[l_ac].fabh152 = g_fabh_d[l_ac].fabh008 * l_rate3
      LET g_fabh3_d[l_ac].fabh154 = g_fabh_d[l_ac].fabh011 * l_rate3      
      LET g_fabh3_d[l_ac].fabh158 = g_fabh_d[l_ac].fabh004 * l_rate3 
      LET g_fabh3_d[l_ac].fabh159 = g_fabh_d[l_ac].fabh017 * l_rate3 
      LET g_fabh3_d[l_ac].fabh161 = g_fabh_d[l_ac].fabh073 * l_rate3 #160331-00003#2
      
      DISPLAY BY NAME g_fabh3_d[l_ac].fabh150
      DISPLAY BY NAME g_fabh3_d[l_ac].fabh151
      DISPLAY BY NAME g_fabh3_d[l_ac].fabh152
      DISPLAY BY NAME g_fabh3_d[l_ac].fabh154
      DISPLAY BY NAME g_fabh3_d[l_ac].fabh158
      DISPLAY BY NAME g_fabh3_d[l_ac].fabh159
      DISPLAY BY NAME g_fabh3_d[l_ac].fabh161    #160331-00003#2      
   END IF 
   
   #160824-00007#248 161208 by lori add---(S)
   LET g_fabh3_d_o.fabh100 = g_fabh3_d[l_ac].fabh100 
   LET g_fabh3_d_o.fabh101 = g_fabh3_d[l_ac].fabh101 
   LET g_fabh3_d_o.fabh102 = g_fabh3_d[l_ac].fabh102 
   LET g_fabh3_d_o.fabh104 = g_fabh3_d[l_ac].fabh104 
   LET g_fabh3_d_o.fabh108 = g_fabh3_d[l_ac].fabh108 
   LET g_fabh3_d_o.fabh109 = g_fabh3_d[l_ac].fabh109 
   LET g_fabh3_d_o.fabh111 = g_fabh3_d[l_ac].fabh111 
   LET g_fabh3_d_o.fabh150 = g_fabh3_d[l_ac].fabh150 
   LET g_fabh3_d_o.fabh151 = g_fabh3_d[l_ac].fabh151 
   LET g_fabh3_d_o.fabh152 = g_fabh3_d[l_ac].fabh152 
   LET g_fabh3_d_o.fabh154 = g_fabh3_d[l_ac].fabh154 
   LET g_fabh3_d_o.fabh158 = g_fabh3_d[l_ac].fabh158 
   LET g_fabh3_d_o.fabh159 = g_fabh3_d[l_ac].fabh159 
   LET g_fabh3_d_o.fabh161 = g_fabh3_d[l_ac].fabh161 
   #160824-00007#248 161208 by lori add---(E)
END FUNCTION
################################################################################
# Descriptions...: 檢查財編附號卡片是否在此帳套中
# Memo...........:
# Usage..........: CALL afat507_check_fabgld()
# Input parameter:  
# Return code....:  
# Date & Author..: 2014/3/23 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION afat507_check_fabgld()
DEFINE l_n1  LIKE type_t.num5

  SELECT COUNT(*) INTO l_n1 FROM faaj_t
   WHERE faajent = g_enterprise
    AND faaj001 = g_fabh_d[l_ac].fabh001
    AND faaj002 = g_fabh_d[l_ac].fabh002
    AND faajld = g_fabg_m.fabgld
    
  RETURN l_n1  
                  
END FUNCTION
################################################################################
# Descriptions...: 多本位幣顯示與否
# Memo...........:
# Usage..........: CALL afat507_visible() 
# Input parameter:  
# Return code....: 
# Date & Author..: 2014/3/23 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION afat507_visible()
 
   IF g_glaa.glaa015 = 'N' AND g_glaa.glaa019 = 'N' THEN 
      CALL cl_set_comp_visible("page_4",FALSE)
   ELSE
      CALL cl_set_comp_visible("page_4",TRUE)   
   END IF   
   #本位幣二   
   IF g_glaa.glaa015 = 'Y' THEN
      CALL cl_set_comp_visible("fabh100,fabh101,fabh102,fabh104,fabh108,fabh109",TRUE)
   ELSE
      CALL cl_set_comp_visible("fabh100,fabh101,fabh102,fabh104,fabh108,fabh109",FALSE)   
   END IF
   #本位幣三
   IF g_glaa.glaa019 = 'Y' THEN 
      CALL cl_set_comp_visible("fabh150,fabh151,fabh152,fabh154,fabh158,fabh159",TRUE)
   ELSE
      CALL cl_set_comp_visible("fabh150,fabh151,fabh152,fabh154,fabh158,fabh159",FALSE)   
   END IF
END FUNCTION
################################################################################
# Descriptions...: 確認
# Memo...........:
# Usage..........: CALL afat507_confirm()
# Input parameter:  
# Return code....:  
# Date & Author..: 2014/3/23 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION afat507_confirm()
DEFINE r_success  LIKE type_t.chr1  
DEFINE l_ooab002  LIKE ooab_t.ooab002
DEFINE l_cnt      LIKE type_t.num5
DEFINE l_n1       LIKE type_t.num5
DEFINE l_fabh000  LIKE fabh_t.fabh000
DEFINE l_fabh001  LIKE fabh_t.fabh001
DEFINE l_fabh002  LIKE fabh_t.fabh002
   LET g_errno = ""
   LET r_success = 'Y'
   
   #狀態碼=N,才可進行審核動作
    IF g_fabg_m.fabgstus='Y' THEN
       LET r_success = 'N'
       LET g_errno = 'afa-00024'
       RETURN r_success
    END IF
    
     SELECT ooab002 INTO l_ooab002 FROM ooab_t
     WHERE ooabent = g_enterprise
       AND ooab001 = 'S-FIN-9003'
       AND ooabsite = g_site 
    #單據日期不能小於關賬日期
    #S-FIN-9003   
    IF g_fabg_m.fabgdocdt < l_ooab002 THEN 
       LET r_success = 'N'
       LET g_errno = 'afa-00060'
       RETURN r_success
    END IF
    
    #申請日期不能小於關賬日期
    IF g_fabg_m.fabg004 < l_ooab002 THEN 
       LET r_success = 'N'
       LET g_errno = 'afa-00108'
       RETURN r_success
    END IF
    
    #檢查當月是否有折舊
    LET l_n1= 0
    LET g_sql = "SELECT fabh001,fabh002,fabh003 FROM fabh_t ",
                " WHERE fabhdocno = '",g_fabg_m.fabgdocno,"' "
    PREPARE afat507_pb1 FROM g_sql
    DECLARE afat507_cs1 CURSOR FOR afat507_pb1     
    FOREACH afat507_cs1 INTO l_fabh001,l_fabh002,l_fabh000               
     IF SQLCA.sqlcode THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = SQLCA.sqlcode
        LET g_errparam.extend = "afat507_cs1"
        LET g_errparam.popup = TRUE
        CALL cl_err()

        LET r_success = 'N'
        RETURN r_success
     END IF 
     SELECT COUNT(*) INTO l_n1 FROM faam_t
      WHERE faam001 = l_fabh001
        AND faam002 = l_fabh002
        AND faam000 = l_fabh000
        AND faament = g_enterprise
        AND faamld = g_fabg_m.fabgld                   
        AND faam005 = MONTH(g_fabg_m.fabgdocno)
     IF l_n1 >= 1 THEN 
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = 'afa-00111'
        LET g_errparam.extend = ''
        LET g_errparam.popup = TRUE
        CALL cl_err()

        LET r_success = 'N'
        RETURN r_success
        EXIT FOREACH         
     END IF     
    END FOREACH     

  RETURN r_success  
END FUNCTION
################################################################################
# Descriptions...: 取消確認
# Memo...........:
# Usage..........: CALL afat507_unconfirm()
# Input parameter:  
# Return code....: 
# Date & Author..: 2014/3/23 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION afat507_unconfirm()
DEFINE  r_success             LIKE type_t.chr1  
DEFINE l_ooab002  LIKE ooab_t.ooab002  
DEFINE l_n1       LIKE type_t.num5
DEFINE l_fabh000  LIKE fabh_t.fabh000
DEFINE l_fabh001  LIKE fabh_t.fabh001
DEFINE l_fabh002  LIKE fabh_t.fabh002
   LET g_errno = ""
   LET r_success = 'Y'
   
   #狀態碼=Y,才可進行取消確認動作
   IF g_fabg_m.fabgstus = 'N' THEN
      LET g_errno = 'afa-00026'
      LET r_success = 'N'
      RETURN r_success
   END IF
   
   SELECT ooab002 INTO l_ooab002 FROM ooab_t
     WHERE ooabent = g_enterprise
       AND ooab001 = 'S-FIN-9003'
       AND ooabsite = g_site 
   #单据日期在關賬日期之前不可取消確認
   #S-FIN-9003
   IF g_fabg_m.fabgdocdt < l_ooab002 THEN 
      LET r_success = 'N'
      LET g_errno = 'afa-00061'
      RETURN r_success
   END IF
   
   #申請日期在關賬日期之前不可取消確認
   IF g_fabg_m.fabg004 < l_ooab002 THEN 
      LET r_success = 'N'
      LET g_errno = 'afa-00109'
      RETURN r_success
   END IF
   
   #檢查當月是否有折舊
    LET l_n1= 0
    LET g_sql = "SELECT fabh001,fabh002,fabh003 FROM fabh_t ",
                " WHERE fabhdocno = '",g_fabg_m.fabgdocno,"' "
    PREPARE afat507_pb1_1 FROM g_sql
    DECLARE afat507_cs1_1 CURSOR FOR afat507_pb1_1     
    FOREACH afat507_cs1_1 INTO l_fabh001,l_fabh002,l_fabh000               
     IF SQLCA.sqlcode THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = SQLCA.sqlcode
        LET g_errparam.extend = "afat507_cs1"
        LET g_errparam.popup = TRUE
        CALL cl_err()

        LET r_success = 'N'
        RETURN r_success
     END IF 
     SELECT COUNT(*) INTO l_n1 FROM faam_t
      WHERE faam001 = l_fabh001
        AND faam002 = l_fabh002
        AND faam000 = l_fabh000
        AND faament = g_enterprise
        AND faamld = g_fabg_m.fabgld                   
        AND faam005 = MONTH(g_fabg_m.fabgdocno)
     IF l_n1 >= 1 THEN 
        LET g_errno = 'afa-00111'
        LET r_success = 'N'
        RETURN r_success
        EXIT FOREACH         
     END IF     
    END FOREACH 

    
   
   RETURN r_success
END FUNCTION
################################################################################
# Descriptions...: 更新資產狀態
# Memo...........:
# Usage..........: CALL afat507_upd_faah()
# Input parameter:  
# Return code....:  
# Date & Author..: 2014/3/24 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION afat507_upd_faah()
DEFINE l_faaj033   LIKE faaj_t.faaj033
DEFINE l_qty       LIKE faaj_t.faaj033
DEFINE l_fabh000   LIKE fabh_t.fabh000
DEFINE l_fabh001   LIKE fabh_t.fabh001
DEFINE l_fabh002   LIKE fabh_t.fabh002
DEFINE l_fabh006   LIKE fabh_t.fabh006
DEFINE l_fabh007   LIKE fabh_t.fabh007
DEFINE r_success   LIKE type_t.chr1
DEFINE r_success1  LIKE type_t.chr1

    LET r_success = 'Y'
    LET r_success1 = 'X'
    LET g_sql = "SELECT fabh001,fabh002,fabh000,fabh006,fabh007 ",
                "  FROM fabh_t ",
                " WHERE fabhent = '",g_enterprise,"'",
                "   AND fabh001 = '",g_fabh_d[l_ac].fabh001,"'",
                "   AND fabh002 = '",g_fabh_d[l_ac].fabh002,"'",
                "   AND fabh000 = '",g_fabh_d[l_ac].fabh000,"'"
    PREPARE afat507_pb2 FROM g_sql
    DECLARE afat507_cs2 CURSOR FOR afat507_pb2     
    FOREACH afat507_cs2 INTO l_fabh001,l_fabh002,l_fabh000,l_fabh006,l_fabh007
        IF SQLCA.sqlcode THEN
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code = SQLCA.sqlcode
           LET g_errparam.extend = "afat507_cs2"
           LET g_errparam.popup = TRUE
           CALL cl_err()

           LET r_success = 'N'
           RETURN r_success,r_success1
        END IF 
        
    SELECT faaj033 INTO l_faaj033 FROM faaj_t
     WHERE faajent = g_enterprise
       AND faaj001 = g_fabh_d[l_ac].fabh001
       AND faaj002 = g_fabh_d[l_ac].fabh002
       AND faajld = g_fabg_m.fabgld 
    #全部報廢完成   
    IF l_fabh007 = l_fabh006 - l_faaj033 THEN
       LET r_success1 = 'Y'
       UPDATE faah_t SET faah015 = '6'
                       WHERE faahent = g_enterprise
                         AND faah003 = l_fabh001
                         AND faah004 = l_fabh002
                         AND faah001 = l_fabh000 
           IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = SQLCA.sqlcode
             LET g_errparam.extend = "faah_upd"
             LET g_errparam.popup = TRUE
             CALL cl_err()

             LET r_success = 'N'
             LET r_success1 = 'N'
             RETURN r_success,r_success1
           END IF                              
    END IF
   END FOREACH 
   RETURN r_success,r_success1
END FUNCTION
################################################################################
# Descriptions...: 還原資產狀態
# Memo...........:
# Usage..........: CALL afat507_reupd_faah())
# Input parameter:   
# Return code....:  
# Date & Author..: 2014/3/24 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION afat507_reupd_faah()
DEFINE l_faaj033   LIKE faaj_t.faaj033
DEFINE l_qty       LIKE faaj_t.faaj033
DEFINE l_fabh000   LIKE fabh_t.fabh000
DEFINE l_fabh001   LIKE fabh_t.fabh001
DEFINE l_fabh002   LIKE fabh_t.fabh002
DEFINE l_fabh006   LIKE fabh_t.fabh006
DEFINE l_fabh007   LIKE fabh_t.fabh007
DEFINE l_faah015   LIKE faah_t.faah015
DEFINE r_success   LIKE type_t.chr1
DEFINE r_success1  LIKE type_t.chr1
LET r_success = 'Y'
LET r_success1 = 'X'
    LET g_sql = "SELECT fabh001,fabh002,fabh000,fabh006,fabh007 ",
                "  FROM fabh_t ",
                " WHERE fabhent = '",g_enterprise,"'",
                "   AND fabh001 = '",g_fabh_d[l_ac].fabh001,"'",
                "   AND fabh002 = '",g_fabh_d[l_ac].fabh002,"'",
                "   AND fabh000 = '",g_fabh_d[l_ac].fabh000,"'"
    PREPARE afat507_pb3 FROM g_sql
    DECLARE afat507_cs3 CURSOR FOR afat507_pb3     
    FOREACH afat507_cs3 INTO l_fabh001,l_fabh002,l_fabh000,l_fabh006,l_fabh007
        IF SQLCA.sqlcode THEN
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code = SQLCA.sqlcode
           LET g_errparam.extend = "afat507_cs3"
           LET g_errparam.popup = TRUE
           CALL cl_err()

           LET r_success = 'N'
           RETURN r_success,r_success1
        END IF 
        
    SELECT faah015 INTO l_faah015 FROM faah_t
     WHERE faahent = g_enterprise
       AND faah001 = g_fabh_d[l_ac].fabh000
       AND faah003 = g_fabh_d[l_ac].fabh001
       AND faah004 = g_fabh_d[l_ac].fabh002
     
    #全部報廢完成還原成折舊中   
    IF l_faah015 = '6' THEN
       LET r_success1 = 'Y'
       UPDATE faah_t SET faah015 = '2'
                       WHERE faahent = g_enterprise
                         AND faah003 = l_fabh001
                         AND faah004 = l_fabh002
                         AND faah001 = l_fabh000 
                         AND faah015 = '6'
           IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = SQLCA.sqlcode
             LET g_errparam.extend = "faah_reupd"
             LET g_errparam.popup = TRUE
             CALL cl_err()

             LET r_success = 'N'
             LET r_success1 = 'N'
             RETURN r_success,r_success1
           END IF                              
    END IF
   END FOREACH 
   RETURN r_success,r_success1
END FUNCTION
################################################################################
# Descriptions...: 更新faaj資料
# Memo...........:
# Usage..........: CALL afat507_upd_faaj()
# Input parameter:  
# Return code....:  
# Date & Author..: 2014/3/24 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION afat507_upd_faaj()
DEFINE l_faaj033  LIKE faaj_t.faaj033
DEFINE l_qty       LIKE faaj_t.faaj033
DEFINE l_fabh000   LIKE fabh_t.fabh000
DEFINE l_fabh001   LIKE fabh_t.fabh001
DEFINE l_fabh002   LIKE fabh_t.fabh002
DEFINE l_fabh006   LIKE fabh_t.fabh006
DEFINE l_fabh007   LIKE fabh_t.fabh007
DEFINE l_fabh008   LIKE fabh_t.fabh008
DEFINE l_fabh011   LIKE fabh_t.fabh011
DEFINE l_fabh017   LIKE fabh_t.fabh017
DEFINE l_fabh004   LIKE fabh_t.fabh004
DEFINE l_faaj019   LIKE faaj_t.faaj019
DEFINE l_faaj018   LIKE faaj_t.faaj018
DEFINE l_faaj032   LIKE faaj_t.faaj032
DEFINE r_success   LIKE type_t.chr1
DEFINE l_c         LIKE faaj_t.faaj032
DEFINE l_faaj028   LIKE faaj_t.faaj028
DEFINE l_faaj027   LIKE faaj_t.faaj027
DEFINE l_faaj034   LIKE faaj_t.faaj034
DEFINE l_faaj035   LIKE faaj_t.faaj035


    LET r_success = 'Y'
    LET g_sql = "SELECT fabh001,fabh002,fabh000,fabh006,fabh007,fabh008,fabh011,fabh017,fabh004 ",
                "  FROM fabh_t ",
                " WHERE fabhent = '",g_enterprise,"'",
                "   AND fabh001 = '",g_fabh_d[l_ac].fabh001,"'",
                "   AND fabh002 = '",g_fabh_d[l_ac].fabh002,"'",
                "   AND fabh000 = '",g_fabh_d[l_ac].fabh000,"'"
    PREPARE afat507_pb4 FROM g_sql
    DECLARE afat507_cs4 CURSOR FOR afat507_pb4     
    FOREACH afat507_cs4 INTO l_fabh001,l_fabh002,l_fabh000,l_fabh006,l_fabh007,l_fabh008,l_fabh011,l_fabh017,l_fabh004
        IF SQLCA.sqlcode THEN
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code = SQLCA.sqlcode
           LET g_errparam.extend = "afat507_cs4"
           LET g_errparam.popup = TRUE
           CALL cl_err()

           LET r_success = 'N'
           RETURN r_success
        END IF 
        
        #faaj預留殘值、faaj銷賬數量、faaj本期累折、faaj本期銷賬累折
        SELECT faaj019,faaj033,faaj018,faaj032 
          INTO l_faaj019,l_faaj033,l_faaj018,l_faaj032
          FROM faaj_t
         WHERE faajent = g_enterprise
           AND faajld = g_fabg_m.fabgld
           AND faaj001 = g_fabh_d[l_ac].fabh001
           AND faaj002 = g_fabh_d[l_ac].fabh002
        #預留殘值
        IF l_fabh007 = l_fabh006 - l_faaj033 THEN
           LET l_faaj019 = 0
        ELSE
           #每個可預留的預留殘值               #剩餘未銷賬的數量  
           LET l_faaj019 = (l_faaj019/(l_fabh006-l_faaj033))*(l_fabh006-l_faaj033-l_fabh007)          
                       
        END IF
        
        
        #本期銷賬累折
        IF l_fabh007 > 0  THEN
           
            LET l_c = ((l_faaj018 - l_faaj032)/(l_fabh006 - l_faaj033))*l_fabh007
        ELSE
           LET l_c= 0
        END IF
        #銷賬數量
        LET l_faaj033 = l_faaj033 - l_fabh007
        #銷賬成本
        LET l_faaj034 = l_faaj034 - l_fabh008
        #銷賬累折
        LET l_faaj035 = l_faaj035 - l_fabh011
        #銷賬減值
        LET l_faaj027 = l_faaj027 - l_fabh017
        #本期銷賬累折
        LET l_faaj032 = l_faaj032 - l_c
        #未折減額
        LET l_faaj028 = l_faaj028 - l_fabh004 
        UPDATE faaj_t SET faaj033 = l_faaj033,
                          faaj034 = l_faaj034,
                          faaj035 = l_faaj035,
                          faaj027 = l_faaj027,
                          faaj032 = l_faaj032,
                          faaj028 = l_faaj028,
                          faaj019 = l_faaj019                          
                    WHERE faajent = g_enterprise
                      AND faajld = g_fabg_m.fabgld
                      AND faaj001 = g_fabh_d[l_ac].fabh001
                      AND faaj002 = g_fabh_d[l_ac].fabh002                         
        IF SQLCA.sqlcode THEN
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code = SQLCA.sqlcode
           LET g_errparam.extend = "faaj_upd2"
           LET g_errparam.popup = TRUE
           CALL cl_err()

           LET r_success = 'N'
           RETURN r_success
        END IF
    END FOREACH
    RETURN r_success    
END FUNCTION
################################################################################
# Descriptions...: 更新faaj還原
# Memo...........:
# Usage..........: CALL afat507_reupd_faaj()
# Input parameter:  
# Return code....:  
# Date & Author..: 2014/3/24 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION afat507_reupd_faaj()
DEFINE l_faaj033   LIKE faaj_t.faaj033
DEFINE l_qty       LIKE faaj_t.faaj033
DEFINE l_fabh000   LIKE fabh_t.fabh000
DEFINE l_fabh001   LIKE fabh_t.fabh001
DEFINE l_fabh002   LIKE fabh_t.fabh002
DEFINE l_fabh006   LIKE fabh_t.fabh006
DEFINE l_fabh007   LIKE fabh_t.fabh007
DEFINE l_fabh008   LIKE fabh_t.fabh008
DEFINE l_fabh011   LIKE fabh_t.fabh011
DEFINE l_fabh017   LIKE fabh_t.fabh017
DEFINE l_fabh004   LIKE fabh_t.fabh004
DEFINE l_faaj019   LIKE faaj_t.faaj019
DEFINE l_faaj018   LIKE faaj_t.faaj018
DEFINE l_faaj032   LIKE faaj_t.faaj032
DEFINE r_success   LIKE type_t.chr1
DEFINE l_c         LIKE faaj_t.faaj032
DEFINE l_faaj028   LIKE faaj_t.faaj028
DEFINE l_faaj027   LIKE faaj_t.faaj027
DEFINE l_faaj034   LIKE faaj_t.faaj034
DEFINE l_faaj035   LIKE faaj_t.faaj035


    LET r_success = 'Y'
    LET g_sql = "SELECT fabh001,fabh002,fabh000,fabh006,fabh007,fabh008,fabh011,fabh017,fabh004 ",
                "  FROM fabh_t ",
                " WHERE fabhent = '",g_enterprise,"'",
                "   AND fabh001 = '",g_fabh_d[l_ac].fabh001,"'",
                "   AND fabh002 = '",g_fabh_d[l_ac].fabh002,"'",
                "   AND fabh000 = '",g_fabh_d[l_ac].fabh000,"'"
    PREPARE afat507_pb5 FROM g_sql
    DECLARE afat507_cs5 CURSOR FOR afat507_pb5     
    FOREACH afat507_cs5 INTO l_fabh001,l_fabh002,l_fabh000,l_fabh006,l_fabh007,l_fabh008,l_fabh011,l_fabh017,l_fabh004
        IF SQLCA.sqlcode THEN
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code = SQLCA.sqlcode
           LET g_errparam.extend = "afat507_cs4"
           LET g_errparam.popup = TRUE
           CALL cl_err()

           LET r_success = 'N'
           RETURN r_success
        END IF 
        
        #faaj預留殘值、faaj銷賬數量、faaj本期累折、faaj本期銷賬累折
        SELECT faaj019,faaj033,faaj018,faaj032 
          INTO l_faaj019,l_faaj033,l_faaj018,l_faaj032
          FROM faaj_t
         WHERE faajent = g_enterprise
           AND faajld = g_fabg_m.fabgld
           AND faaj001 = g_fabh_d[l_ac].fabh001
           AND faaj002 = g_fabh_d[l_ac].fabh002
        #預留殘值
        IF l_fabh007 = l_fabh006 - l_faaj033 THEN
           LET l_faaj019 = 0
        ELSE   
                          #每個可預留的預留殘值               #還原未銷賬的數量  
           LET l_faaj019 = (l_faaj019/(l_fabh006-l_faaj033))*(l_fabh006-l_faaj033+l_fabh007)            
        END IF
        
        
        #本期銷賬累折
        IF l_fabh007 > 0  THEN
           LET l_c = ((l_faaj018 - l_faaj032)/(l_fabh006 - l_faaj033))*(l_faaj033+l_fabh007)
        ELSE
           LET l_c= 0
        END IF
        #銷賬數量
        LET l_faaj033 = l_faaj033 + l_fabh007
        #銷賬成本
        LET l_faaj034 = l_faaj034 + l_fabh008
        #銷賬累折
        LET l_faaj035 = l_faaj035 + l_fabh011
        #銷賬減值
        LET l_faaj027 = l_faaj027 + l_fabh017
        #本期銷賬累折
        LET l_faaj032 = l_faaj032 + l_c
        #未折減額
        LET l_faaj028 = l_faaj028 - l_fabh004 
        UPDATE faaj_t SET faaj033 = l_faaj033,
                          faaj034 = l_faaj034,
                          faaj035 = l_faaj035,
                          faaj027 = l_faaj027,
                          faaj032 = l_faaj032,
                          faaj028 = l_faaj028,
                          faaj019 = l_faaj019                          
                    WHERE faajent = g_enterprise
                      AND faajld = g_fabg_m.fabgld
                      AND faaj001 = g_fabh_d[l_ac].fabh001
                      AND faaj002 = g_fabh_d[l_ac].fabh002                         
        IF SQLCA.sqlcode THEN
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code = SQLCA.sqlcode
           LET g_errparam.extend = "faaj_upd"
           LET g_errparam.popup = TRUE
           CALL cl_err()

           LET r_success = 'N'
           RETURN r_success
        END IF
    END FOREACH 
    RETURN r_success    
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL afat507_default()
# Input parameter:  
# Date & Author..: 2014/8/8 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION afat507_default()
DEFINE l_success LIKE type_t.chr1
DEFINE l_fabgcomp LIKE fabg_t.fabgcomp

      LET g_fabg_m.fabgstus = "N"
      LET g_fabg_m.fabg001 = g_user
      LET g_fabg_m.fabg002 = g_user
#      LET g_fabg_m.fabg003 = g_dept   #mark by yangxf
      #add by yangxf ----
      SELECT ooag003 INTO g_fabg_m.fabg003
        FROM ooag_t
       WHERE ooagent = g_enterprise
         AND ooag001 = g_fabg_m.fabg002
      CALL afat507_get_fabg003_desc()
      #add by yangxf ---
      CALL afat507_get_fabg001_desc()
      CALL afat507_get_fabg002_desc()
      CALL afat507_get_fabg003_desc()
      
      DISPLAY BY NAME g_fabg_m.fabg001,g_fabg_m.fabg001_desc,
                      g_fabg_m.fabg002,g_fabg_m.fabg002_desc,
                      g_fabg_m.fabg003,g_fabg_m.fabg003_desc                      
      
      LET g_fabg_m.fabgdocdt = g_today
      LET g_fabg_m.fabg004 = g_today

#20141106
#      SELECT faab002 INTO g_fabg_m.fabgsite FROM faab_t,ooag_t
#       WHERE faab004 = ooag004 AND faabent = ooagent
#         AND ooag001 = g_user AND ooagent = g_enterprise
#         AND faab007 = 'Y' AND faab001= '4'
#       
#      
#     SELECT DISTINCT glaald INTO g_fabg_m.fabgld 
#       FROM glaa_t,ooef_t,ooag_t
#      WHERE ooag004 = ooef001 AND ooagent = ooefent AND glaacomp = ooef017 AND ooefent = glaaent AND glaa014 = 'Y'
#        AND ooag001 = g_user AND glaaent = g_enterprise
#     DISPLAY BY NAME g_fabg_m.fabgld,g_fabg_m.fabgsite
#20141106
     CALL s_afat503_default(g_bookno) RETURNING l_success,g_fabg_m.fabgsite,g_fabg_m.fabgld,l_fabgcomp #20141106
     IF NOT cl_null(g_fabg_m.fabgsite) THEN
        IF NOT s_afat502_site_user_chk(g_fabg_m.fabgsite,g_fabg_m.fabg001) THEN 
           LET g_fabg_m.fabg001 = NULL
        END IF 
     END IF
     CALL afat507_get_fabgsite_desc()
     CALL afat507_get_fabgld_desc() 

     #161215-00044#1---modify----begin-----------------
     #SELECT * INTO g_glaa.* 
     SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,
            glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,glaa011,
            glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,glaa023,
            glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,glaa113,glaa120,glaa121,
            glaa122,glaa027,glaa130,glaa131,glaa132,glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,
            glaa140,glaa123,glaa124,glaa028 INTO g_glaa.* 
     #161215-00044#1---modify----end---------------
     FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_fabg_m.fabgld
END FUNCTION

################################################################################
# Descriptions...:  
# Memo...........:
# Usage..........: CALL afat507_fabh001_chk()
# Input parameter:  
# Date & Author..: 2014/9/2 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION afat507_fabh001_chk()
   DEFINE l_cnt       LIKE type_t.num5
   DEFINE l_faah015   LIKE faah_t.faah015
   DEFINE l_faah037   LIKE faah_t.faah037   
   DEFINE l_fabh000   LIKE fabh_t.fabh000
   DEFINE l_fabh001   LIKE fabh_t.fabh001
   DEFINE l_fabh002   LIKE fabh_t.fabh002
   DEFINE l_flag      LIKE type_t.num5
   DEFINE l_sql       STRING
   
   LET g_errno=""
   IF NOT cl_null(g_fabh_d[l_ac].fabh001) 
      AND NOT cl_null(g_fabh_d[l_ac].fabh000) THEN 
      
      #卡片+财编+附號需存在於faah_t固定資產基礎資料檔中   
      SELECT faah015,faah037 INTO l_faah015,l_faah037 FROM faah_t
       WHERE faahent = g_enterprise
         AND faah003 = g_fabh_d[l_ac].fabh001
         AND faah004 = g_fabh_d[l_ac].fabh002 
         AND faah001 = g_fabh_d[l_ac].fabh000
         
      IF SQLCA.SQLCODE = 100 THEN 
         LET g_errno= 'afa-00076'
      END IF 
      #財產狀態不可為0：取得、5：出售、6：销账、10：被資本化
      IF l_faah015='0' OR l_faah015='5' OR l_faah015='10' OR l_faah015='8' OR l_faah015='6' THEN
         LET g_errno='afa-00198'
      END IF
      
      #資產已抵押的，不可銷賬或報廢
      IF l_faah037 = '3' OR l_faah037 = '4' THEN
         LET g_errno = 'afa-00203'
      END IF
      
      #當前重估單，卡片+財產編號+附號不可重複
      LET l_cnt = 0
      SELECT COUNT(*) INTO l_cnt FROM fabh_t
       WHERE fabhent = g_enterprise
         AND fabhdocno = g_fabg_m.fabgdocno
         AND fabh001 = g_fabh_d[l_ac].fabh001 
         AND fabh002 = g_fabh_d[l_ac].fabh002
         AND fabh000 = g_fabh_d[l_ac].fabh000
         AND fabhseq <> g_fabh_d[l_ac].fabhseq
      IF l_cnt>0 THEN
         LET g_errno= 'afa-00200'
      END IF 
   END IF  
   
#   #若不是開窗，直接輸入欄位時，需默認帶出相應的卡片+附號
#   #當前报废單中未使用的資料                  
#   IF  NOT cl_null(g_fabh_d[l_ac].fabh001) THEN 
#      LET l_sql = " SELECT faah001,faah003,faah004 FROM faah_t,faaj_t ",
#                  "  WHERE faahent = faajent AND faah000 = faaj000 ",
#                  "    AND faah001 = faaj037 AND faah003 = faaj001 ",
#                  "    AND faah004 = faaj002 AND faajld='",g_fabg_m.fabgld,"' ",
#                  "    AND faahent = '",g_enterprise,"'",
#                  "    AND faah003 = '",g_fabh_d[l_ac].fabh001,"'", 
#                   "   AND faaj002 = '",g_fabh_d[l_ac].fabh002,"' ",
#                  "    AND faah015 NOT IN ('0','5','6','10') ",
#                  "  ORDER BY faah001,faah003,faah004 "
#      PREPARE afat503_pb4 FROM l_sql
#      DECLARE afat503_cs4 CURSOR FOR afat503_pb4
#      LET l_flag=FALSE #記錄是否抓取到合適資料  
#      
#      FOREACH afat503_cs4 INTO l_fabh000,l_fabh001,l_fabh002 
#         IF SQLCA.sqlcode THEN
#            LET g_errno=SQLCA.sqlcode
#            EXIT FOREACH
#         END IF             
#         LET l_cnt = 0
#         SELECT COUNT(*) INTO l_cnt FROM fabh_t 
#          WHERE fabhent = g_enterprise
#            AND fabhld  = g_fabg_m.fabgld
#            AND fabhdocno = g_fabg_m.fabgdocno
#            AND fabh001 = l_fabh001 
#            AND fabh002 = l_fabh002
#            AND fabh000 = l_fabh000
#            AND fabhseq <>g_fabh_d[l_ac].fabhseq
#         IF l_cnt>0 THEN 
#            CONTINUE FOREACH
#         ELSE 
#            LET l_flag=TRUE
#            LET g_fabh_d[l_ac].fabh000 = l_fabh000
#            LET g_fabh_d[l_ac].fabh002 = l_fabh002
#            EXIT FOREACH
#         END IF 
#      END FOREACH  
#      IF l_flag=FALSE THEN  #排除輸入的不符合條件的資料
#         LET g_errno = 'afa-00199'
#      END IF    
#   END IF  
END FUNCTION

################################################################################
# Descriptions...:  
# Memo...........:
# Usage..........: CALL afat507_get_amt(p_fabh006,p_fabh007)
# Input parameter:  
# Date & Author..: 2014/9/2 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION afat507_get_amt(p_fabh006,p_fabh007)
   DEFINE p_fabh006              LIKE fabh_t.fabh006
   DEFINE p_fabh007              LIKE fabh_t.fabh007
   DEFINE l_faah005              LIKE faah_t.faah005
   DEFINE l_faaj020              LIKE faaj_t.faaj020
   DEFINE l_faaj021              LIKE faaj_t.faaj021   
   DEFINE l_faaj034              LIKE faaj_t.faaj034
   DEFINE l_faaj017              LIKE faaj_t.faaj017
   DEFINE l_faaj016              LIKE faaj_t.faaj016   
   DEFINE l_faaj035              LIKE faaj_t.faaj035
   DEFINE l_faaj033              LIKE faaj_t.faaj033   
   DEFINE l_faaj027              LIKE faaj_t.faaj027
   DEFINE l_faaj018              LIKE faaj_t.faaj018
   DEFINE l_faaj032              LIKE faaj_t.faaj032
   DEFINE l_faaj028              LIKE faaj_t.faaj028
   DEFINE l_faaj117              LIKE faaj_t.faaj117
   DEFINE l_faaj113              LIKE faaj_t.faaj113
   DEFINE l_faaj104              LIKE faaj_t.faaj104
   DEFINE l_faaj114              LIKE faaj_t.faaj114
   DEFINE l_faaj112              LIKE faaj_t.faaj112
   DEFINE l_faaj110              LIKE faaj_t.faaj110
   DEFINE l_faaj111              LIKE faaj_t.faaj111
   DEFINE l_faaj115              LIKE faaj_t.faaj115
   DEFINE l_faaj108              LIKE faaj_t.faaj108
   DEFINE l_faaj167              LIKE faaj_t.faaj167
   DEFINE l_faaj163              LIKE faaj_t.faaj163
   DEFINE l_faaj154              LIKE faaj_t.faaj154
   DEFINE l_faaj164              LIKE faaj_t.faaj164
   DEFINE l_faaj162              LIKE faaj_t.faaj162
   DEFINE l_faaj160              LIKE faaj_t.faaj160
   DEFINE l_faaj161              LIKE faaj_t.faaj161
   DEFINE l_faaj165              LIKE faaj_t.faaj165
   DEFINE l_faaj158              LIKE faaj_t.faaj158
   DEFINE l_faaj102              LIKE faaj_t.faaj102
   DEFINE l_faaj152              LIKE faaj_t.faaj152   
   DEFINE l_faah018              LIKE faah_t.faah018 #160331-00003#2  add 
   DEFINE l_faaj019              LIKE faaj_t.faaj019 #160905-00037#1 add 
   
   SELECT faah005 INTO l_faah005
     FROM faah_t
    WHERE faahent=g_enterprise AND faah001=g_fabh_d[l_ac].fabh003
      AND faah003=g_fabh_d[l_ac].fabh001 AND faah004=g_fabh_d[l_ac].fabh002
      
   SELECT faaj016,faaj020,faaj034,faaj017,faaj035,faaj021,
          faaj027,faaj018,faaj032,faaj028,
          faaj102,faaj103,faaj117,faaj113,faaj104,faaj114,faaj112,
          faaj110,faaj111,faaj115,faaj108,
          faaj152,faaj153,faaj167,faaj163,faaj154,faaj164,faaj162,
          faaj160,faaj161,faaj165,faaj158,faaj033,
          faaj019 #160905-00037#1 add
     INTO l_faaj016,l_faaj020,l_faaj034,l_faaj017,l_faaj035,l_faaj021,
          l_faaj027,l_faaj018,l_faaj032,l_faaj028,
          l_faaj102,g_fabh3_d[l_ac].fabh102,l_faaj117,l_faaj113,l_faaj104,l_faaj114,l_faaj112,
          l_faaj110,l_faaj111,l_faaj115,l_faaj108,
          l_faaj152,g_fabh3_d[l_ac].fabh152,l_faaj167,l_faaj163,l_faaj154,l_faaj164,l_faaj162,
          l_faaj160,l_faaj161,l_faaj165,l_faaj158,l_faaj033,
          l_faaj019 #160905-00037#1 add
     FROM faaj_t
    WHERE faajent=g_enterprise AND faajld=g_fabg_m.fabgld
      AND faaj001=g_fabh_d[l_ac].fabh001 AND faaj002=g_fabh_d[l_ac].fabh002
      AND faaj037=g_fabh_d[l_ac].fabh000
   #160331-00003#2  add -str
   SELECT faah018 INTO l_faah018 FROM faah_t
    WHERE faahent = g_enterprise 
      AND faah001 = g_fabh_d[l_ac].fabh000
      AND faah003 = g_fabh_d[l_ac].fabh001
      AND faah004 = g_fabh_d[l_ac].fabh002
   #160331-00003#2  add -end         
   IF cl_null(l_faaj016) THEN LET l_faaj016=0 END IF #成本
   IF cl_null(l_faaj020) THEN LET l_faaj020=0 END IF   #调整成本
   IF cl_null(l_faaj034) THEN LET l_faaj034=0 END IF   #处置成本
   IF cl_null(l_faaj017) THEN LET l_faaj017=0 END IF   #累折
   IF cl_null(l_faaj035) THEN LET l_faaj035=0 END IF   #处置累折
   IF cl_null(l_faaj021) THEN LET l_faaj021=0 END IF #已提列減值準備
   IF cl_null(l_faaj027) THEN LET l_faaj027=0 END IF   #處置減值準備
   IF cl_null(l_faaj018) THEN LET l_faaj018=0 END IF   #本年累折
   IF cl_null(l_faaj032) THEN LET l_faaj032=0 END IF   #本年处置折舊
   IF cl_null(l_faaj028) THEN LET l_faaj028=0 END IF   #未折減額
   IF cl_null(l_faaj019) THEN LET l_faaj019=0 END IF #160905-00037#1 add
   IF cl_null(l_faaj033) THEN LET l_faaj033=0 END IF #160905-00037#1 add
   
   #160304-00002#1--mark--str--lujh
   ##成本=(本幣成本 + 調整成本 -处置成本)/(數量-处置數量) * 單據报废量
   #LET g_fabh_d[l_ac].fabh008=(l_faaj016 + l_faaj020 - l_faaj034) / (p_fabh006 - l_faaj033) *p_fabh007
   #
   ##累折=(累折 - 处置累折) / (數量-处置數量) * 單據报废量
   #LET g_fabh_d[l_ac].fabh011=(l_faaj017 - l_faaj035) / (p_fabh006 - l_faaj033) *p_fabh007
   #
   ##处置減值準備= (已提列減值準備 - 处置減值準備) / （數量-處置數量） * 單據报废量
   #LET g_fabh_d[l_ac].fabh017=(l_faaj021 - l_faaj027) / (p_fabh006 - l_faaj033) *p_fabh007
   #160304-00002#1--mark--end--lujh
   
   #160304-00002#1--add--str--lujh
   #成本=(本幣成本-处置成本)*(单身处置數量/数量)
   LET g_fabh_d[l_ac].fabh008=(l_faaj016 - l_faaj034) * (p_fabh007/p_fabh006)
   
   #累折=(累折 - 处置累折)*(单身处置數量/数量)
   LET g_fabh_d[l_ac].fabh011=(l_faaj017 - l_faaj035) * (p_fabh007/p_fabh006)
   
   #处置減值準備= (已提列減值準備 - 处置減值準備)*(单身处置數量/数量)
   LET g_fabh_d[l_ac].fabh017=(l_faaj021 - l_faaj027) * (p_fabh007/p_fabh006)
   #160304-00002#1--add--end--lujh
   #160331-00003#2  add -str
   #处置本年累折
   LET g_fabh_d[l_ac].fabh073= (l_faaj018 - l_faaj032)/(l_faah018 - l_faaj033 )* g_fabh_d[l_ac].fabh007
   #160331-00003#2  add -end    
   
   #160905-00037# add s---
   #预留残值
   #IF (faah数量 - faaj处置数量-单身档销帐数量)=0 THEN 预留残值 =0
   IF l_faah018 - l_faaj033 - g_fabh_d[l_ac].fabh007 = 0 THEN 
      LET g_fabh_d[l_ac].fabh015 = 0
   ELSE
      #预留残值 =(faaj预留残值/(faah数量 - faaj处置数量)*(数量-(faaj的处置数量+此次单身的销账数量))
      LET g_fabh_d[l_ac].fabh015 = l_faaj019/(l_faah018 - l_faaj033)*(g_fabh_d[l_ac].fabh006-(l_faaj033+g_fabh_d[l_ac].fabh007))
   END IF 
   #160905-00037#1 add e---     
   
#   #本年处置折舊=(本年累折-本年处置折舊)/(數量-处置數量)*报废量
#   LET g_fabh_d[l_ac].fabh021=(l_faaj018 - l_faaj032) / p_fabh006 *p_fabh007
#   
#   #未折減額=（未折減額/（faah總 數量-faaj处置数量) * 报废量
#   LET g_fabh_d[l_ac].fabh004 =l_faaj028 / p_fabh006 *p_fabh007
#   

    #未折減額 = 單身成本-單身折舊
    LET g_fabh_d[l_ac].fabh004 = g_fabh_d[l_ac].fabh008 - g_fabh_d[l_ac].fabh011
      #本位币二
   IF g_glaa.glaa015='Y' THEN
      LET g_fabh3_d[l_ac].fabh102 = g_fabh_d[l_ac].fabh008 * l_faaj102
      LET g_fabh3_d[l_ac].fabh104 = g_fabh_d[l_ac].fabh011 * l_faaj102
      LET g_fabh3_d[l_ac].fabh108 = g_fabh_d[l_ac].fabh004 * l_faaj102
      LET g_fabh3_d[l_ac].fabh109 = g_fabh_d[l_ac].fabh017 * l_faaj102  
      LET g_fabh3_d[l_ac].fabh111 = g_fabh_d[l_ac].fabh073 * l_faaj102  #160331-00003#2           
   END IF
   
   #本位三
   IF g_glaa.glaa019='Y' THEN
      LET g_fabh3_d[l_ac].fabh152 = g_fabh_d[l_ac].fabh008 * l_faaj152
      LET g_fabh3_d[l_ac].fabh154 = g_fabh_d[l_ac].fabh011 * l_faaj152
      LET g_fabh3_d[l_ac].fabh158 = g_fabh_d[l_ac].fabh004 * l_faaj152
      LET g_fabh3_d[l_ac].fabh159 = g_fabh_d[l_ac].fabh017 * l_faaj152  
      LET g_fabh3_d[l_ac].fabh161 = g_fabh_d[l_ac].fabh073 * l_faaj152  #160331-00003#2       
   END IF
   
   DISPLAY BY NAME g_fabh_d[l_ac].fabh008,g_fabh_d[l_ac].fabh011,g_fabh_d[l_ac].fabh017, 
                   g_fabh_d[l_ac].fabh004, 
                   g_fabh3_d[l_ac].fabh102,g_fabh3_d[l_ac].fabh152,
                   g_fabh3_d[l_ac].fabh104,g_fabh3_d[l_ac].fabh154,
                   g_fabh3_d[l_ac].fabh108,g_fabh3_d[l_ac].fabh158,
                   g_fabh3_d[l_ac].fabh109,g_fabh3_d[l_ac].fabh159,
                   g_fabh3_d[l_ac].fabh111,g_fabh3_d[l_ac].fabh161 #160331-00003#2                    
                 
   #160824-00007#248 161208 by lori add---(S)
   LET g_fabh_d_o.fabh008 = g_fabh_d[l_ac].fabh008
   LET g_fabh_d_o.fabh011 = g_fabh_d[l_ac].fabh011
   LET g_fabh_d_o.fabh017 = g_fabh_d[l_ac].fabh017
   LET g_fabh_d_o.fabh073 = g_fabh_d[l_ac].fabh073
   LET g_fabh_d_o.fabh015 = g_fabh_d[l_ac].fabh015
   LET g_fabh_d_o.fabh004 = g_fabh_d[l_ac].fabh004
   LET g_fabh3_d_o.fabh102 = g_fabh3_d[l_ac].fabh102
   LET g_fabh3_d_o.fabh104 = g_fabh3_d[l_ac].fabh104
   LET g_fabh3_d_o.fabh108 = g_fabh3_d[l_ac].fabh108
   LET g_fabh3_d_o.fabh109 = g_fabh3_d[l_ac].fabh109
   LET g_fabh3_d_o.fabh111 = g_fabh3_d[l_ac].fabh111 
   LET g_fabh3_d_o.fabh152 = g_fabh3_d[l_ac].fabh152
   LET g_fabh3_d_o.fabh154 = g_fabh3_d[l_ac].fabh154
   LET g_fabh3_d_o.fabh158 = g_fabh3_d[l_ac].fabh158
   LET g_fabh3_d_o.fabh159 = g_fabh3_d[l_ac].fabh159
   LET g_fabh3_d_o.fabh161 = g_fabh3_d[l_ac].fabh161   
   #160824-00007#248 161208 by lori add---(E)   
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
PRIVATE FUNCTION afat507_upd_fabh()
DEFINE l_fabhseq       LIKE fabh_t.fabhseq
DEFINE l_fabh021       LIKE fabh_t.fabh021
DEFINE l_fabh036       LIKE fabh_t.fabh026
DEFINE l_fabh026       LIKE fabh_t.fabh026
DEFINE l_fabh027       LIKE fabh_t.fabh027
DEFINE l_fabh028       LIKE fabh_t.fabh028
DEFINE l_fabh029       LIKE fabh_t.fabh029
DEFINE l_fabh030       LIKE fabh_t.fabh030
DEFINE l_fabh031       LIKE fabh_t.fabh031
DEFINE l_fabh032       LIKE fabh_t.fabh032
DEFINE l_fabh033       LIKE fabh_t.fabh033
DEFINE l_fabh034       LIKE fabh_t.fabh034
DEFINE l_fabh035       LIKE fabh_t.fabh035
DEFINE l_faal004       LIKE faal_t.faal004
DEFINE l_ooab002       LIKE ooab_t.ooab002
DEFINE l_glaacomp      LIKE glaa_t.glaacomp

   LET g_forupd_sql = "SELECT '',faajsite,faaj039,faaj040,faaj041,faaj042,
                       faaj043,faaj044,faaj047,faaj045,faaj046
                        FROM faaj_t  
                       WHERE faaj001=? AND faaj002=? AND faaj037=? 
                         AND faajent=? AND faajld=? FOR UPDATE"
           
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE afat507_fabh_bcl CURSOR FROM g_forupd_sql
   
   OPEN afat507_fabh_bcl USING g_fabh_d[g_detail_idx].fabh001,g_fabh_d[g_detail_idx].fabh002,g_fabh_d[g_detail_idx].fabh000,
                               g_enterprise,g_fabg_m.fabgld
   
   FETCH afat507_fabh_bcl INTO l_fabh036,l_fabh026,l_fabh027,l_fabh028,l_fabh029,
                               l_fabh030,l_fabh031,l_fabh032,l_fabh033,l_fabh034,l_fabh035
   CLOSE afat507_fabh_bcl

#   SELECT faal004 INTO l_faal004 FROM faal_t
#    WHERE faalent = g_enterprise AND faalld = g_fabg_m.fabgld
#      AND faal001 = ( SELECT faah006 FROM faah_t WHERE faahent = g_enterprise 
#      AND faah003 = g_fabh_d[g_detail_idx].fabh001 AND faah004 = g_fabh_d[g_detail_idx].fabh002
#      AND faah001 = g_fabh_d[g_detail_idx].fabh000)
   SELECT glaacomp INTO l_glaacomp FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_fabg_m.fabgld
   CALL cl_get_para(g_enterprise,l_glaacomp,'S-FIN-9017') RETURNING l_ooab002   
   
   IF l_ooab002 = 'Y' THEN
      SELECT glab005 INTO l_fabh021 FROM glab_t
       WHERE glabent = g_enterprise AND glabld = g_fabg_m.fabgld
         AND glab001 = '90' AND glab002 = '25'
         AND glab003 = '9902_12' 
   ELSE
      SELECT glab005 INTO l_fabh021 FROM glab_t
       WHERE glabent = g_enterprise AND glabld = g_fabg_m.fabgld
         AND glab001 = '90' AND glab002 = '21'
         AND glab003 = '9902_03' 
   END IF
   
   UPDATE fabh_t SET (fabh021, 
       fabh036,fabh026,fabh027,fabh028,fabh029,fabh030,fabh031,fabh032,fabh033,fabh034,fabh035 
       ) = (l_fabh021, 
       l_fabh036,l_fabh026,l_fabh027,l_fabh028, 
       l_fabh029,l_fabh030,l_fabh031,l_fabh032, 
       l_fabh033,l_fabh034,l_fabh035 
       ) #自訂欄位頁簽 

    WHERE fabhent = g_enterprise AND fabhld = g_fabg_m.fabgld
      AND fabhdocno = g_fabg_m.fabgdocno
      AND fabhseq = g_fabh_d[g_detail_idx].fabhseq #項次 
END FUNCTION

################################################################################
# Descriptions...: 描述说明
################################################################################
PRIVATE FUNCTION afat507_change_to_sql(p_wc)
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
PUBLIC FUNCTION afat507_faid_chk()
 DEFINE l_faah015         LIKE faah_t.faah015
   DEFINE l_n1              LIKE type_t.num5 
   DEFINE r_success         LIKE type_t.num5
   DEFINE l_n               LIKE type_t.num5
   ########################################add by huangtao
   DEFINE l_faah006         LIKE faah_t.faah006 
   DEFINE l_faah032         LIKE faah_t.faah032 
   DEFINE l_ooef017         LIKE ooef_t.ooef017 
   DEFINE l_faal003         LIKE faal_t.faal003 
   DEFINE l_year            LIKE type_t.num5
   DEFINE l_month           LIKE type_t.num5
   #########################################add by huangtao
   LET r_success = TRUE

#   #無財編、卡片編號則不需要做檢查，無附號則便是類型為'1.主件'所以不需要考慮附號值否有
#   IF cl_null(g_fabh_d[l_ac].fabh001) THEN RETURN r_success END IF
#
#   ###########################add by huangtao
#   IF g_fabh_d[l_ac].fabh002 IS NULL THEN RETURN r_success END IF
#   #若卡片不为空。检查财编，附号，卡片是否存在afai100
#   IF NOT cl_null(g_fabh_d[l_ac].fabh000) THEN
#   ###########################add by huangtao
#      LET l_n = 0
#      SELECT COUNT(*) INTO l_n
#        FROM faaj_t
#       WHERE faajent = g_enterprise
#         AND faaj037 = g_fabh_d[l_ac].fabh000
#         AND faaj001 = g_fabh_d[l_ac].fabh001
#         AND faaj002 = g_fabh_d[l_ac].fabh002
#      
#      IF l_n = 0 THEN 
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.code = 'afa-00178'
#         LET g_errparam.extend = ''
#         LET g_errparam.popup = TRUE
#         CALL cl_err()
#      
#         LET g_fabh_d[l_ac].fabh001 = g_fabh_d_t.fabh001
#         LET g_fabh_d[l_ac].fabh002 = g_fabh_d_t.fabh002
#         LET g_fabh_d[l_ac].fabh000 = g_fabh_d_t.fabh000
#         LET r_success = FALSE
#         RETURN r_success
#      END IF
#   ############################add by huangtao
#   #卡片为空,根据财编，附号带出预设卡片
#   ELSE
#      SELECT faah001 INTO g_fabh_d[l_ac].fabh000 FROM faah_t
#       WHERE faahent = g_enterprise AND faah003 = g_fabh_d[l_ac].fabh001  AND faah004 = g_fabh_d[l_ac].fabh002 
#   
#   END IF   
#   ############################add by huangtao
#   
#
#   SELECT faah006,faah015,faah032 INTO l_faah006,l_faah015,l_faah032 FROM faah_t
#    WHERE faahent = g_enterprise
#      AND faah003 = g_fabh_d[l_ac].fabh001
#      AND faah004 = g_fabh_d[l_ac].fabh002 
#      AND faah001 = g_fabh_d[l_ac].fabh000
#   #財產狀態不可為0：取得、5：出售、6：銷賬、10：被資本化
#   IF l_faah015='0' OR l_faah015='5' OR l_faah015='6' OR l_faah015='8' OR l_faah015='10' THEN
#      INITIALIZE g_errparam TO NULL
#      LET g_errparam.code = 'afa-00135'
#      LET g_errparam.extend = ''
#      LET g_errparam.popup = TRUE
#      CALL cl_err()
#
#      LET g_fabh_d[l_ac].fabh001 = g_fabh_d_t.fabh001
#      LET g_fabh_d[l_ac].fabh002 = g_fabh_d_t.fabh002
#      LET g_fabh_d[l_ac].fabh000 = g_fabh_d_t.fabh000
#      LET r_success = FALSE
#      RETURN r_success
#   END IF 

   #當前折畢再單，卡片+財產編號+附號不可重複
   LET l_n1 = 0
   SELECT COUNT(*) INTO l_n1 FROM fabh_t
    WHERE fabhent = g_enterprise
      AND fabhdocno = g_fabg_m.fabgdocno
      AND fabh001 = g_fabh_d[l_ac].fabh001 
      AND fabh002 = g_fabh_d[l_ac].fabh002
      AND fabh000 = g_fabh_d[l_ac].fabh000
      AND fabhseq <> g_fabh_d[l_ac].fabhseq
   IF l_n1 > 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'afa-00066'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET g_fabh_d[l_ac].fabh001 = g_fabh_d_t.fabh001
      LET g_fabh_d[l_ac].fabh002 = g_fabh_d_t.fabh002
      LET g_fabh_d[l_ac].fabh000 = g_fabh_d_t.fabh000
      LET r_success = FALSE
      RETURN r_success
   END IF
##################################add by huangtao
##mark by yangxf
#   IF NOT s_afat502_site_comp_chk(g_fabg_m.fabgsite,l_faah032) THEN 
#      LET r_success = FALSE
#      RETURN r_success
#   END IF 
##   #根据财编，附号 检查是否和单头资产中心帐套同一法人
##   SELECT ooef017 INTO l_ooef017 FROM ooef_t
##    WHERE ooefent = g_enterprise AND ooef001 =g_fabg_m.fabgsite
##   
##   IF l_ooef017 <> l_faah032 THEN
##      INITIALIZE g_errparam TO NULL
##      LET g_errparam.code = 'axr-00122'      #过单
##      LET g_errparam.extend = ''
##      LET g_errparam.popup = TRUE
##      CALL cl_err()
##      RETURN FALSE
##   END IF
##mark by yangxf
##检查是否存在afai021 不存在报错，存在的话，检查是否先计提折旧
#   SELECT faal003 INTO l_faal003 FROM faal_t 
#    WHERE faalent = g_enterprise AND faalld = g_fabg_m.fabgld AND faal001 = l_faah006
#
#   IF STATUS =100 OR cl_null(l_faal003) THEN
#      INITIALIZE g_errparam TO NULL
#      LET g_errparam.code = 'afa-00183'      #过单
#      LET g_errparam.extend = ''
#      LET g_errparam.popup = TRUE
#      CALL cl_err()
#      RETURN FALSE
#   ELSE
#      LET l_year = YEAR(g_today)
#      LET l_month = MONTH(g_today)
#      IF l_faal003 = 'Y' THEN   
#         SELECT COUNT(*) INTO l_n FROM faam_t
#           WHERE faament = g_enterprise AND faamld = g_fabg_m.fabgld
#             AND faam000 = g_fabh_d[l_ac].fabh000 AND faam001 = g_fabh_d[l_ac].fabh001 AND faam002= g_fabh_d[l_ac].fabh002
#             AND faam004 = l_year AND faam005 = l_month
#          IF l_n = 0 THEN
#             INITIALIZE g_errparam TO NULL
#             LET g_errparam.code = 'afa-00280'
#             LET g_errparam.extend = ''
#             LET g_errparam.popup = TRUE
#             CALL cl_err()
#             RETURN FALSE
#          END IF
#      END IF
#   END IF
#
#
##################################add by huangtao

   RETURN r_success

END FUNCTION

################################################################################
# Descriptions...: 取得保管人员,保管部门及其说明
# Memo...........: #161115-00003#1 
# Date & Author..: 2016/11/18 By xul
# Modify.........:
################################################################################
PRIVATE FUNCTION afat507_get_faah025_faah026_desc()
   DEFINE l_faah025_desc  LIKE type_t.chr80
   DEFINE l_faah026_desc  LIKE type_t.chr80

     SELECT DISTINCT faah025,faah026 
       INTO g_fabh_d[l_ac].faah025,g_fabh_d[l_ac].faah026
       FROM faah_t
      WHERE faahent = g_enterprise
        AND faah001 = g_fabh_d[l_ac].fabh000
        AND faah003 = g_fabh_d[l_ac].fabh001
        AND faah004 = g_fabh_d[l_ac].fabh002
    #保管人员说明
     SELECT ooag011 INTO l_faah025_desc   
       FROM ooag_t
      WHERE ooagent = g_enterprise AND ooag001 = g_fabh_d[l_ac].faah025
    #保管部门说明
     SELECT ooefl003 INTO l_faah026_desc
       FROM ooefl_t
      WHERE ooeflent = g_enterprise AND ooefl002 = g_dlang 
        AND ooefl001 = g_fabh_d[l_ac].faah026
      
      LET g_fabh_d[l_ac].faah025 = g_fabh_d[l_ac].faah025," ",l_faah025_desc 
      LET g_fabh_d[l_ac].faah026 = g_fabh_d[l_ac].faah026," ",l_faah026_desc 
END FUNCTION

 
{</section>}
 
