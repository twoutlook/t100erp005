#該程式未解開Section, 採用最新樣板產出!
{<section id="aglt310.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0036(2017-01-10 10:41:12), PR版次:0036(2017-02-17 16:33:34)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 001669
#+ Filename...: aglt310
#+ Description: 轉帳傳票維護作業
#+ Creator....: 02298(2013-08-13 14:39:09)
#+ Modifier...: 01531 -SD/PR- 08729
 
{</section>}
 
{<section id="aglt310.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#150429-00010#14  2015/05/21 BY Reanna   增加刪除時回寫傳票號碼=NULL
#150907           2015/09/07 BY Reanna   增加AC類型刪除時回寫傳票號碼=NULL
#150827-00036#7   2015/09/15 BY 02291    添加“是否是子系统科目”字段，如果打勾后在总账凭证输入时不能选该类科目
#150827-00036#11  2015/09/25 BY 01727    aglt*所有凭证在新增时,需要增加自动补号功能
#150814-00006#3   2015/10/27 BY 02599    根據借貸方向預設現金變動碼值
#151013-00016#6   2015/10/28 BY RayHuang glbc_t新增狀態碼
#150703-00021#24  2015/11/13 BY Hans     增加預算控管
#150827-00036#14  2015/11/16 BY 03599    修改现金变动码分摊方式
#151117-00009#1   2015/11/18 BY 02599    当有账套时，科目检查改为检查是否存在于glad_t中
#151124-00022#2   2015/11/25 BY Hans     作廢時增加提示
#151125-00001#2   2015/11/30 BY catmoon  修正151124-00022#2，作廢動作移出
#151201-00004#1   2015/12/02 BY 02599    單頭增加來源單號字段，用於顯示來源單據編號，并提供串查，當有多個來源單據時顯示MULTI
#151204-00001#1   2015/12/04 BY 02599    aglt410审计调整凭证不检查是否大于关帐日期
#151204-00010#1   2015/12/06 BY 02599    增加来源类型为glap007=NM glap008=N50(anmt822)的凭证删除时，回写来源单据中凭证编号为NULL
#151130-00015#2   2015/12/21 BY taozf    判断 是否可以更改單據日期 設定開放單據日期修改
#151008-00009#4   2016/01/29 BY Jessy    增加axrt470刪除時回寫傳票號碼=NULL
#160122-00001#34  2016/02/26 BY 07673    添加交易账户编号用户权限控管,当没有权限时，用户不能看到交易账户编号，用“*”显示，当有权限时，才可以看到具体交易账户编号。
#160318-00012#1   2016/03/18 BY yangtt   增加afmt145/afmt175/afmt185类型删除时回写凭证编号=NULL,凭证日期=NULL
#140702-00001#19  2016/03/21 BY 01727    刪除傳票時回寫融資重評价作業
#160321-00016#30  2016/03/25 BY Jessy    修正azzi920重複定義之錯誤訊息
#160318-00005#17  2016/03/29 BY 07675    將重複內容的錯誤訊息置換為公用錯誤訊息
#160415-00025#1   2016/04/25 BY 02599    调用cl_set_comp_entry函数时，要设置的栏位不可以折行，否则折行导致不能设置成功
#160519-00029#1   2016/05/17 BY Dido     直接指定傳票編號時進入單身不用再重新給號
#160509-00005#1   2016/06/03 BY 02599    BUG修正，科目开窗排除子系统科目
#160517-00001#3   2016/06/06 BY 02599    当为aglt410程序时，科目可以使用子系统科目
#160509-00004#59  2016/06/15 BY 02599    录入时显示制表信息
#160308-00010#25  2016/06/20 BY Jessica  1.需先按抽單/拒絕才能修改/刪除
#                                        2.R已拒絕 或 D抽單，按[修改][刪除]時報錯: 單據不為確認狀態不可进行異動
#160509-00004#103 2016/07/10 BY 02114    加入单据别参数是否凭证红冲的功能
#160705-00033#1   2016/07/13 BY 02599    aglt340原凭证编号检查是否已回转时，排除已作废单据
#160805-00022#1   2016/08/05 BY 02599    1.aglt310来源类型增加SCC为ZT帐套抛转;2.画面增加'来源账套''来源传票单号'栏位，分别记录aglp560的来源帐套和来源传票编号
#160818-00017#14  2016/08/25 BY 08172    修改删除时重新检查状态
#160518-00075#27  2016/08/25 BY 02114    AGL,作業開啟時,只依azzi850可執行作業否管制，不卡帳套權限，會造成作業無法執行。 查詢及維護時才檢核帳權限。
#160830-00011#1   2016/09/01 By 07900    18主机6区ENT=99 抛转总账传票，总账单别是无效的GLL，可以选择aooi199作业中无效的总账单别GLL，
#                                        系统有提示无效但是还是成功产生出传票编号是GLL的传票单据资料 参考应收单号CNJ-R12-160800000001
#160729-00009#4   2016/09/06 By 07900    整单操作里的按钮【生成EXCEL范本】【导入EXCEL数据】拿掉。
#160902-00030#1   2016/09/08 By 00768    自动生成的借贷方单身，摘要应该要能编辑
#                                        如果单身没维护值，单身不做新增
#160913-00017#1   2016/09/23 By 07900    AGL模组调整交易客商开窗
#161009-00002#1   2016/10/09 By 02599    复制操作时，取消复制操作后显示空白
#160918-00006#2   2016/10/10 By 02599    抓取汇率时根据账套汇率来源(glaa028:1.日汇率,2.月汇率)抓取汇率
#161021-00037#3   2016/10/24 By 06821    組織類型與職能開窗調整
#161111-00049#4   2016/11/12 By 01531    调整问题6(用到agli130摘要设置的作业如aglt310）
#161003-00014#15  2016/11/15 By Hans     非科目預算時修改預算控管方式
#161128-00061#1   2016/11/29 by 02481    标准程式定义采用宣告模式,弃用.*写法
#161128-00054#1   2016/12/01 By 01531    通过anmt820抛转到aglt350的凭证，在aglt350删除后，未更新删除anmt820的单头【凭证编号】栏位
#161130-00019#1   2016/12/02 By 07900    汇率应不可为0
#161205-00025#4   2016/12/07 By 02599    程式优化
#160824-00007#252 2016/12/20 By 08171    新舊值調整
#170103-00019#1   2017/01/04 By 02599    1.复制时，如果有细项立冲科目，不允许复制，提示讯息；2.点‘细项冲账’时，不启用细项冲账要提示讯息
#                                        3.作废操作时，同步还原细项冲账金额；4.审核检查时改用s_aglt310中的元件
#161107-00028#1   2017/01/10 By 01531    【整单操作】下增加功能钮【开账资料EXCEL导出/导入】，点击后串到azzp660。
#161104-00046#11  2017/01/12 By 08729    單別預設值;資料依照單別user dept權限過濾單號
#170113-00042#1   2017/01/17 By 02599    1.新增glax时将glax061 glax062 glax063 插入,2.当更新glax抓不到资料时，走新增glax
#170116-00016#2   2017/01/18 By 06821    不管是否異動資料,離開該行則檢核如符合條件則寫入glax
#170117-00064#1   2017/01/22 By 02599    1.複製功能, 開放有立沖帳科目者, 複製時, 立帳科目的glax一併產生,沖帳科目者不處理glay 
#                                        2.aglt350中凭证来源是前段抛砖时，删除时同步回写对应凭证编号为NULL
#170116-00074#5   2017/01/23 By Hans     確認檢查:若傳票來源類型為'GL' 且單別參數控制預算=Y 則走檢查預算額度功能, 其他單據則不檢核預算功能
#170214-00033#1   2017/02/14 By 02599    aglt310 產生細項立沖及審核時檢核有無立沖資訊,  都排除AC應計、RA應計調整 類型
#170111-00005#1   2017/02/17 By 08729    科目做了核算项【项目管理】【WBS】管理，检核时统一用提示讯息。
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
GLOBALS "../../cfg/top_finance.inc"
#end add-point
 
#單頭 type 宣告
PRIVATE type type_g_glap_m        RECORD
       glapld LIKE glap_t.glapld, 
   glapld_desc LIKE type_t.chr80, 
   glapcomp LIKE glap_t.glapcomp, 
   glapcomp_desc LIKE type_t.chr80, 
   glaa001_desc LIKE type_t.chr500, 
   glaa016 LIKE glaa_t.glaa016, 
   glaa020 LIKE glaa_t.glaa020, 
   glap001 LIKE glap_t.glap001, 
   glapdocno LIKE glap_t.glapdocno, 
   glapdocdt LIKE glap_t.glapdocdt, 
   glap002 LIKE glap_t.glap002, 
   glap004 LIKE glap_t.glap004, 
   glap007 LIKE glap_t.glap007, 
   glap008 LIKE glap_t.glap008, 
   glap010 LIKE glap_t.glap010, 
   glap011 LIKE glap_t.glap011, 
   glap006 LIKE glap_t.glap006, 
   glap006_desc LIKE type_t.chr80, 
   glap015 LIKE glap_t.glap015, 
   glap013 LIKE glap_t.glap013, 
   glap009 LIKE glap_t.glap009, 
   sdocno LIKE type_t.chr20, 
   glap016 LIKE glap_t.glap016, 
   glap016_desc LIKE type_t.chr80, 
   glap017 LIKE glap_t.glap017, 
   glap012 LIKE glap_t.glap012, 
   glap014 LIKE glap_t.glap014, 
   glapstus LIKE glap_t.glapstus, 
   glapownid LIKE glap_t.glapownid, 
   glapownid_desc LIKE type_t.chr80, 
   glapcrtdp LIKE glap_t.glapcrtdp, 
   glapcrtdp_desc LIKE type_t.chr80, 
   glapowndp LIKE glap_t.glapowndp, 
   glapowndp_desc LIKE type_t.chr80, 
   glapcrtdt LIKE glap_t.glapcrtdt, 
   glapcrtid LIKE glap_t.glapcrtid, 
   glapcrtid_desc LIKE type_t.chr80, 
   glapmodid LIKE glap_t.glapmodid, 
   glapmodid_desc LIKE type_t.chr80, 
   glapmoddt LIKE glap_t.glapmoddt, 
   glapcnfid LIKE glap_t.glapcnfid, 
   glapcnfid_desc LIKE type_t.chr80, 
   glapcnfdt LIKE glap_t.glapcnfdt, 
   glappstid LIKE glap_t.glappstid, 
   glappstid_desc LIKE type_t.chr80, 
   glappstdt LIKE glap_t.glappstdt, 
   glaq017 LIKE glaq_t.glaq017, 
   glaq017_desc LIKE type_t.chr80, 
   glaq018 LIKE glaq_t.glaq018, 
   glaq018_desc LIKE type_t.chr80, 
   glaq019 LIKE glaq_t.glaq019, 
   glaq019_desc LIKE type_t.chr80, 
   glaq020 LIKE glaq_t.glaq020, 
   glaq020_desc LIKE type_t.chr80, 
   glaq021 LIKE glaq_t.glaq021, 
   glaq021_desc LIKE type_t.chr80, 
   glaq022 LIKE glaq_t.glaq022, 
   glaq022_desc LIKE type_t.chr80, 
   glaq023 LIKE glaq_t.glaq023, 
   glaq023_desc LIKE type_t.chr80, 
   glaq024 LIKE glaq_t.glaq024, 
   glaq024_desc LIKE type_t.chr80, 
   glbc004 LIKE glbc_t.glbc004, 
   glbc004_desc LIKE type_t.chr80, 
   glaq051 LIKE glaq_t.glaq051, 
   glaq052 LIKE glaq_t.glaq052, 
   glaq052_desc LIKE type_t.chr80, 
   glaq053 LIKE glaq_t.glaq053, 
   glaq053_desc LIKE type_t.chr80, 
   glaq025 LIKE glaq_t.glaq025, 
   glaq025_desc LIKE type_t.chr80, 
   glaq027 LIKE glaq_t.glaq027, 
   glaq027_desc LIKE type_t.chr80, 
   glaq028 LIKE glaq_t.glaq028, 
   glaq028_desc LIKE type_t.chr80, 
   glaq029 LIKE glaq_t.glaq029, 
   glaq029_desc LIKE type_t.chr80, 
   glaq030 LIKE glaq_t.glaq030, 
   glaq030_desc LIKE type_t.chr80, 
   glaq031 LIKE glaq_t.glaq031, 
   glaq031_desc LIKE type_t.chr80, 
   glaq032 LIKE glaq_t.glaq032, 
   glaq032_desc LIKE type_t.chr80, 
   glaq033 LIKE glaq_t.glaq033, 
   glaq033_desc LIKE type_t.chr80, 
   glaq034 LIKE glaq_t.glaq034, 
   glaq034_desc LIKE type_t.chr80, 
   glaq035 LIKE glaq_t.glaq035, 
   glaq035_desc LIKE type_t.chr80, 
   glaq036 LIKE glaq_t.glaq036, 
   glaq036_desc LIKE type_t.chr80, 
   glaq037 LIKE glaq_t.glaq037, 
   glaq037_desc LIKE type_t.chr80, 
   glaq038 LIKE glaq_t.glaq038, 
   glaq038_desc LIKE type_t.chr80, 
   glaq005_1 LIKE type_t.chr10, 
   glaq006_1 LIKE type_t.num26_10, 
   glaq010_1 LIKE type_t.num20_6, 
   glaq007 LIKE glaq_t.glaq007, 
   glaq008 LIKE glaq_t.glaq008, 
   glaq009 LIKE glaq_t.glaq009, 
   glaq011 LIKE glaq_t.glaq011, 
   glaq012 LIKE glaq_t.glaq012, 
   glaq013 LIKE glaq_t.glaq013, 
   glaq013_desc LIKE type_t.chr80, 
   glaq014 LIKE glaq_t.glaq014, 
   glaq015 LIKE glaq_t.glaq015, 
   glaq015_desc LIKE type_t.chr80, 
   glaq016 LIKE glaq_t.glaq016, 
   glaq016_desc LIKE type_t.chr80, 
   conf LIKE type_t.chr80, 
   post LIKE type_t.chr80, 
   creat LIKE type_t.chr80
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_glaq_d        RECORD
       glaqseq LIKE glaq_t.glaqseq, 
   glaqcomp LIKE glaq_t.glaqcomp, 
   glaq001 LIKE glaq_t.glaq001, 
   glaq002 LIKE glaq_t.glaq002, 
   lc_subject LIKE type_t.chr500, 
   glaq005 LIKE glaq_t.glaq005, 
   glaq006 LIKE glaq_t.glaq006, 
   glaq010 LIKE glaq_t.glaq010, 
   glaq003 LIKE glaq_t.glaq003, 
   glaq004 LIKE glaq_t.glaq004, 
   edit1 LIKE type_t.chr500, 
   glaq039 LIKE glaq_t.glaq039, 
   glaq040 LIKE glaq_t.glaq040, 
   glaq041 LIKE glaq_t.glaq041, 
   amt2 LIKE type_t.num20_6, 
   glaq042 LIKE glaq_t.glaq042, 
   glaq043 LIKE glaq_t.glaq043, 
   glaq044 LIKE glaq_t.glaq044, 
   amt3 LIKE type_t.num20_6
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_glapld LIKE glap_t.glapld,
      b_glap002 LIKE glap_t.glap002,
      b_glap004 LIKE glap_t.glap004,
      b_glapdocno LIKE glap_t.glapdocno,
      b_glapdocdt LIKE glap_t.glapdocdt,
      b_glap007 LIKE glap_t.glap007,
      b_glap008 LIKE glap_t.glap008
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
#当前用户归属的营运据点预设的行事历参照表号,办公行事历对应类别
DEFINE g_ooef004    LIKE ooef_t.ooef004
DEFINE g_ooef008    LIKE ooef_t.ooef008
DEFINE g_ooef010    LIKE ooef_t.ooef010
#依据当前账别，抓取账别所归属的法人，使用币别，汇率参照表号，会计科目参照表号，关账日期
DEFINE g_glaacomp    LIKE glaa_t.glaacomp
DEFINE g_glaa001     LIKE glaa_t.glaa001
DEFINE g_glaa002     LIKE glaa_t.glaa002
DEFINE g_glaa003     LIKE glaa_t.glaa003
DEFINE g_glaa004     LIKE glaa_t.glaa004
DEFINE g_glaa005     LIKE glaa_t.glaa005
DEFINE g_glaa013     LIKE glaa_t.glaa013
DEFINE g_glaa015     LIKE glaa_t.glaa015
DEFINE g_glaa016     LIKE glaa_t.glaa016
DEFINE g_glaa017     LIKE glaa_t.glaa017
DEFINE g_glaa018     LIKE glaa_t.glaa018
DEFINE g_glaa019     LIKE glaa_t.glaa019
DEFINE g_glaa020     LIKE glaa_t.glaa020
DEFINE g_glaa021     LIKE glaa_t.glaa021
DEFINE g_glaa022     LIKE glaa_t.glaa022
DEFINE g_glaa024     LIKE glaa_t.glaa024
DEFINE g_glaa025     LIKE glaa_t.glaa025
DEFINE g_glaa026     LIKE glaa_t.glaa026
DEFINE g_glaa028     LIKE glaa_t.glaa028 #160918-00006#2 add
DEFINE g_ooaj004_o   LIKE ooaj_t.ooaj004
DEFINE g_ooaj004     LIKE ooaj_t.ooaj004
DEFINE g_ooaj004_2   LIKE ooaj_t.ooaj004
DEFINE g_ooaj004_3   LIKE ooaj_t.ooaj004
DEFINE g_glaa121     LIKE glaa_t.glaa121 #子模組啟用分錄底稿
DEFINE g_glaa122     LIKE glaa_t.glaa122 #总账可维护资金异动明细
#不同作业调用此作业时传入的参数
DEFINE g_glap001_p   LIKE glap_t.glap001
DEFINE g_glapdocno_p LIKE glap_t.glapdocno 
DEFINE g_glapld_p    LIKE glap_t.glapld
#依据传入的不同参数，单据别性质给不同的值
DEFINE g_oobx003     LIKE oobx_t.oobx003   #单据性质 
#帐别
DEFINE g_glapld      LIKE glap_t.glapld
DEFINE g_bookno      LIKE glap_t.glapld
#查询条件备份
DEFINE g_wc1         STRING 
#自由核算项
DEFINE g_glaq029     LIKE glaq_t.glaq029
DEFINE g_glaq030     LIKE glaq_t.glaq030
DEFINE g_glaq031     LIKE glaq_t.glaq031
DEFINE g_glaq032     LIKE glaq_t.glaq032
DEFINE g_glaq033     LIKE glaq_t.glaq033
DEFINE g_glaq034     LIKE glaq_t.glaq034
DEFINE g_glaq035     LIKE glaq_t.glaq035
DEFINE g_glaq036     LIKE glaq_t.glaq036
DEFINE g_glaq037     LIKE glaq_t.glaq037
DEFINE g_glaq038     LIKE glaq_t.glaq038
#科目
DEFINE g_glaq002_desc    LIKE glaq_t.glaq002
DEFINE g_wc2_table2      STRING 
#摘要
DEFINE g_msg             LIKE type_t.chr80


type type_g_glaq_r       RECORD
       glaq017           LIKE glaq_t.glaq017,
       glaq018           LIKE glaq_t.glaq018,
       glaq019           LIKE glaq_t.glaq019,
       glaq020           LIKE glaq_t.glaq020,
       glaq021           LIKE glaq_t.glaq021,
       glaq022           LIKE glaq_t.glaq022,
       glaq023           LIKE glaq_t.glaq023, 
       glaq024           LIKE glaq_t.glaq024, 
       glaq051           LIKE glaq_t.glaq051, 
       glaq052           LIKE glaq_t.glaq052,
       glaq053           LIKE glaq_t.glaq053,
       glaq025           LIKE glaq_t.glaq025,
       glaq027           LIKE glaq_t.glaq027,
       glaq028           LIKE glaq_t.glaq028, 
       glaq029           LIKE glaq_t.glaq029, 
       glaq030           LIKE glaq_t.glaq030, 
       glaq031           LIKE glaq_t.glaq031, 
       glaq032           LIKE glaq_t.glaq032, 
       glaq033           LIKE glaq_t.glaq033, 
       glaq034           LIKE glaq_t.glaq034, 
       glaq035           LIKE glaq_t.glaq035, 
       glaq036           LIKE glaq_t.glaq036, 
       glaq037           LIKE glaq_t.glaq037, 
       glaq038           LIKE glaq_t.glaq038,
       glbc004           LIKE glbc_t.glbc004
       END RECORD
DEFINE g_glaq_r          type_g_glaq_r
#記錄現收現支單頭科目核算項
DEFINE g_glaq_s          type_g_glaq_r
#自由核算項
DEFINE g_glad0171        LIKE glad_t.glad0171
DEFINE g_glad0181        LIKE glad_t.glad0181
DEFINE g_glad0191        LIKE glad_t.glad0191
DEFINE g_glad0201        LIKE glad_t.glad0201
DEFINE g_glad0211        LIKE glad_t.glad0211
DEFINE g_glad0221        LIKE glad_t.glad0221
DEFINE g_glad0231        LIKE glad_t.glad0231
DEFINE g_glad0241        LIKE glad_t.glad0241
DEFINE g_glad0251        LIKE glad_t.glad0251
DEFINE g_glad0261        LIKE glad_t.glad0261
DEFINE g_wc_glbc         STRING               #現金變動碼

DEFINE g_flag_input      LIKE type_t.num5

DEFINE  g_tran  RECORD             #150703-00021#24  ---s---
            act       LIKE type_t.chr10,   #[1].chr 動作
            site      LIKE ooef_t.ooef001, #[2].chr 預算組織
            dat       LIKE type_t.dat,     #[3].dat 日期
            bgae001   LIKE bgae_t.bgae001 #[4].chr 預算項目
END RECORD                        
DEFINE g_dfin5002     LIKE type_t.chr1
DEFINE g_ap_slip      LIKE glap_t.glapdocno
DEFINE g_sql_bank     STRING     #160122-00001#34   
#150703-00021#24   ---e---
#161205-00025#4--add--str--
#多語言SQL
DEFINE g_get_sql   RECORD
       glaq017     STRING,  #营运据点
       glaq018     STRING,  #部门
       glaq019     STRING,  #责任中心
       glaq020     STRING,  #区域
       glaq021     STRING,  #收付款客商
       glaq022     STRING,  #账款客商
       glaq023     STRING,  #客群
       glaq024     STRING,  #产品类别
       glaq025     STRING,  #人员
       glaq027     STRING,  #专案编号
       glaq028     STRING,  #WBS
       glaq051     STRING,  #经营方式
       glaq052     STRING,  #渠道
       glaq053     STRING   #品牌  
                   END RECORD   
#161205-00025#4--add--end
DEFINE g_user_dept_wc      STRING      #161104-00046#11
DEFINE g_user_dept_wc_q    STRING      #161104-00046#11
DEFINE g_user_slip_wc      STRING      #161104-00046#11
#end add-point
       
#模組變數(Module Variables)
DEFINE g_glap_m          type_g_glap_m
DEFINE g_glap_m_t        type_g_glap_m
DEFINE g_glap_m_o        type_g_glap_m
DEFINE g_glap_m_mask_o   type_g_glap_m #轉換遮罩前資料
DEFINE g_glap_m_mask_n   type_g_glap_m #轉換遮罩後資料
 
   DEFINE g_glapld_t LIKE glap_t.glapld
DEFINE g_glapdocno_t LIKE glap_t.glapdocno
 
 
DEFINE g_glaq_d          DYNAMIC ARRAY OF type_g_glaq_d
DEFINE g_glaq_d_t        type_g_glaq_d
DEFINE g_glaq_d_o        type_g_glaq_d
DEFINE g_glaq_d_mask_o   DYNAMIC ARRAY OF type_g_glaq_d #轉換遮罩前資料
DEFINE g_glaq_d_mask_n   DYNAMIC ARRAY OF type_g_glaq_d #轉換遮罩後資料
 
 
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
 
{<section id="aglt310.main" >}
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
   CALL cl_ap_init("agl","")
 
   #add-point:作業初始化 name="main.init"
   LET g_glap001_p = g_argv[1]
   LET g_glapld_p = g_argv[02]
   LET g_glapdocno_p = g_argv[03]
   #161104-00046#11-----s
   #建立與單頭array相同的temptable
   CALL s_aooi200def_create('','g_glap_m','','','','','','')RETURNING g_sub_success
   
   #單別控制組
   LET g_user_dept_wc = ''
   CALL s_fin_get_user_dept_control('glapcomp','','glapent','glapdocno') RETURNING g_user_dept_wc
   #開窗使用
   LET g_user_dept_wc_q = g_user_dept_wc
   
   CALL s_control_get_docno_sql(g_user,g_dept) RETURNING g_sub_success,g_user_slip_wc  
   #161104-00046#11-----e
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
            
   #end add-point
   LET g_forupd_sql = " SELECT glapld,'',glapcomp,'','','','',glap001,glapdocno,glapdocdt,glap002,glap004, 
       glap007,glap008,glap010,glap011,glap006,'',glap015,glap013,glap009,'',glap016,'',glap017,glap012, 
       glap014,glapstus,glapownid,'',glapcrtdp,'',glapowndp,'',glapcrtdt,glapcrtid,'',glapmodid,'',glapmoddt, 
       glapcnfid,'',glapcnfdt,glappstid,'',glappstdt,'','','','','','','','','','','','','','','','', 
       '','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','', 
       '','','','','','','','','','','','','','','','','','','',''", 
                      " FROM glap_t",
                      " WHERE glapent= ? AND glapld=? AND glapdocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
            
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aglt310_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.glapld,t0.glapcomp,t0.glap001,t0.glapdocno,t0.glapdocdt,t0.glap002, 
       t0.glap004,t0.glap007,t0.glap008,t0.glap010,t0.glap011,t0.glap006,t0.glap015,t0.glap013,t0.glap009, 
       t0.glap016,t0.glap017,t0.glap012,t0.glap014,t0.glapstus,t0.glapownid,t0.glapcrtdp,t0.glapowndp, 
       t0.glapcrtdt,t0.glapcrtid,t0.glapmodid,t0.glapmoddt,t0.glapcnfid,t0.glapcnfdt,t0.glappstid,t0.glappstdt, 
       t1.glaal002 ,t2.ooefl003 ,t3.glaal002 ,t4.ooag011 ,t5.ooefl003 ,t6.ooefl003 ,t7.ooag011 ,t8.ooag011 , 
       t9.ooag011 ,t10.ooag011",
               " FROM glap_t t0",
                              " LEFT JOIN glaal_t t1 ON t1.glaalent="||g_enterprise||" AND t1.glaalld=t0.glapld AND t1.glaal001='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.glapcomp AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN glaal_t t3 ON t3.glaalent="||g_enterprise||" AND t3.glaalld=t0.glap016 AND t3.glaal001='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=t0.glapownid  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.glapcrtdp AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent="||g_enterprise||" AND t6.ooefl001=t0.glapowndp AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=t0.glapcrtid  ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=t0.glapmodid  ",
               " LEFT JOIN ooag_t t9 ON t9.ooagent="||g_enterprise||" AND t9.ooag001=t0.glapcnfid  ",
               " LEFT JOIN ooag_t t10 ON t10.ooagent="||g_enterprise||" AND t10.ooag001=t0.glappstid  ",
 
               " WHERE t0.glapent = " ||g_enterprise|| " AND t0.glapld = ? AND t0.glapdocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aglt310_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
                        
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aglt310 WITH FORM cl_ap_formpath("agl",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aglt310_init()   
 
      #進入選單 Menu (="N")
      CALL aglt310_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
                        
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aglt310
      
   END IF 
   
   CLOSE aglt310_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
            
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aglt310.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aglt310_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point    
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success      LIKE type_t.num5
   DEFINE l_pass         LIKE type_t.num5
   DEFINE l_glaq013_desc STRING #161205-00025#4 add
   DEFINE l_glaq015_desc STRING #161205-00025#4 add
   DEFINE l_glaq016_desc STRING #161205-00025#4 add
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
      CALL cl_set_combo_scc_part('glapstus','13','N,Y,S,A,D,R,W,X')
 
      CALL cl_set_combo_scc('glap007','8007') 
   CALL cl_set_combo_scc('glap008','8035') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('glaq051','6013')
   CALL cl_set_combo_scc('glap008','8035')
   CALL cl_set_toolbaritem_visible("excel_load",FALSE)  #160729-00009#4 add
   CALL cl_set_toolbaritem_visible("excel_example",FALSE)  #160729-00009#4 add
   #######################################
   #依据当前传入的参数，处理画面栏位的显示 
   #只有当运行aglt320,aglt330时，支出科目才需要显示
   IF g_glap001_p <>'2' AND g_glap001_p<>'3' THEN
      CALL cl_set_comp_visible('glap006,glap006_desc',FALSE)
   END IF 
   #只有运行aglt340时，原传票编号才需要显示
   IF g_glap001_p <>'4' THEN
      CALL cl_set_comp_visible('glap015',FALSE)
   END IF 
  #运行aglt320时，借方金额隐藏
  IF g_glap001_p ='2'  THEN
#      CALL cl_set_comp_visible('glaq003',FALSE)
     CALL cl_set_comp_entry('glaq003',FALSE)
   END IF 
  #运行aglt330时，贷方金额隐藏 
  IF g_glap001_p ='3'  THEN
#      CALL cl_set_comp_visible('glaq004',FALSE)
     CALL cl_set_comp_entry('glaq004',FALSE)
  END IF 
  # #运行aglt340时，複製功能隱藏
  IF g_glap001_p ='4' THEN
      CALL cl_set_act_visible("reproduce", FALSE)
   END IF  
#######################################
#依据开启的不同的作业，单据别性质给不同的值
   IF g_glap001_p = '1' THEN
      LET g_oobx003 = 'aglt310'    
      #單頭資料來源='GL'時,右邊帳款類型為noentry
      CALL cl_set_comp_entry('glap008',FALSE)
   END IF 
   IF g_glap001_p = '2' THEN
      LET g_oobx003 = 'aglt320'
   END IF 
   IF g_glap001_p = '3' THEN
      LET g_oobx003 = 'aglt330'
   END IF 
   IF g_glap001_p = '4' THEN
      LET g_oobx003 = 'aglt340'
   END IF 
   IF g_glap001_p = '5' THEN
      LET g_oobx003 = 'aglt350'
   END IF 
   IF g_glap001_p = '6' THEN
      LET g_oobx003 = 'aglt410'
   END IF 
#######################################
   LET g_glaald=''
   IF NOT cl_null(g_glapld_p) THEN
      CALL s_ld_chk_authorization(g_user,g_glapld_p) RETURNING l_pass
      IF l_pass = TRUE THEN
         LET g_glaald=g_glapld_p
      END IF
   END IF
   #依据登陆的site，抓取单别参照表号，行事历参照表号,辦公行事曆對應類別   
   SELECT ooef004,ooef008,ooef010 INTO g_ooef004,g_ooef008,g_ooef010 FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site
   #获取账别
   IF cl_null(g_glaald) THEN
      CALL s_ld_bookno()  RETURNING l_success,g_glapld
      IF l_success = FALSE THEN
         RETURN 
      END IF 
      #160518-00075#27--mark--str--lujh
      #CALL s_ld_chk_authorization(g_user,g_glapld) RETURNING l_pass
      #IF l_pass = FALSE THEN
      #   INITIALIZE g_errparam TO NULL
      #   LET g_errparam.code = 'agl-00164'
      #   LET g_errparam.extend = g_glapld
      #   LET g_errparam.popup = TRUE
      #   CALL cl_err()
      #
      #   RETURN
      #END IF
      #160518-00075#27--mark--end--lujh
      LET g_glaald=g_glapld
   ELSE
      LET g_glapld=g_glaald
   END IF      
   #依据对应的主账套编码，抓取对应法人，币别，汇率参照编号，会计科目参照编号,关账日期
   CALL aglt310_glapld_desc(g_glapld)
#######################################################
   #开出程式交易币别，汇率，原币金额隐藏
   #CALL cl_set_comp_visible('glaq005,glaq006,glaq010',FALSE)
   CALL cl_set_combo_scc('b_glap007','8007') 
   #CALL cl_set_combo_scc('glaq015','8310')    #151223-00004#1 mark lujh  
   CALL s_fin_continue_no_tmp()                #150827-00036#11
   CALL cl_set_comp_visible('cont_no',FALSE)   #150827-00036#11
   
   #160122-00001#34 --add--str--
   LET g_sql_bank=NULL
   CALL s_anmi120_get_bank_account_sql(g_user,g_dept) RETURNING g_sub_success,g_sql_bank
   #160122-00001#34 --add--end

   #161205-00025#4--add--str--
   #核算项说明组成SQL
   #营运据点
   CALL s_fin_get_department_sql('ta3','glaqent','glaq017') RETURNING g_get_sql.glaq017
   #部門
   CALL s_fin_get_department_sql('ta4','glaqent','glaq018') RETURNING g_get_sql.glaq018
   #利润成本中心
   CALL s_fin_get_department_sql('ta5','glaqent','glaq019') RETURNING g_get_sql.glaq019
   #区域
   CALL s_fin_get_acc_sql('ta6','glaqent','287','glaq020') RETURNING g_get_sql.glaq020
   #收付款客商
   CALL s_fin_get_trading_partner_abbr_sql('ta7','glaqent','glaq021') RETURNING g_get_sql.glaq021
   #账款客商
   CALL s_fin_get_trading_partner_abbr_sql('ta8','glaqent','glaq022') RETURNING g_get_sql.glaq022
   #客群
   CALL s_fin_get_acc_sql('ta9','glaqent','281','glaq023') RETURNING g_get_sql.glaq023
   #产品类别
   CALL s_fin_get_rtaxl003_sql('ta10','glaqent','glaq024') RETURNING g_get_sql.glaq024
   #人员
   CALL s_fin_get_person_sql('ta11','glaqent','glaq025') RETURNING g_get_sql.glaq025
   #专案
   CALL s_fin_get_project_sql('ta12','glaqent','glaq027') RETURNING g_get_sql.glaq027
   #WBS
   CALL s_fin_get_wbs_sql('ta13','glaqent','glaq027','glaq028') RETURNING g_get_sql.glaq028
   #经营方式
   LET g_get_sql.glaq051 = "(SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001='6013' AND gzcbl002=glaq051 AND gzcbl003='"||g_dlang||"')"
   #渠道
   CALL s_fin_get_oojdl003_sql('ta14','glaqent','glaq052') RETURNING g_get_sql.glaq052
   #品牌
   CALL s_fin_get_acc_sql('ta15','glaqent','2002','glaq053') RETURNING g_get_sql.glaq053
   
   #抓取核算项资料
   LET g_sql="SELECT glaq017,glaq018,glaq019,glaq020,glaq021,glaq022,",
             "       glaq023,glaq024,glaq051,glaq052,glaq053,glaq025,glaq027,glaq028,",
             "       glaq029,glaq030,glaq031,glaq032,glaq033,",
             "       glaq034,glaq035,glaq036,glaq037,glaq038,glacl004,",
             g_get_sql.glaq017,",",g_get_sql.glaq018,",",g_get_sql.glaq019,",",g_get_sql.glaq020,",",
             g_get_sql.glaq021,",",g_get_sql.glaq022,",",g_get_sql.glaq023,",",g_get_sql.glaq024,",",
             g_get_sql.glaq025,",",g_get_sql.glaq027,",",g_get_sql.glaq028,",",g_get_sql.glaq051,",",
             g_get_sql.glaq052,",",g_get_sql.glaq053,",",
             "       glad0171,glad0181,glad0191,glad0201,glad0211,",
             "       glad0221,glad0231,glad0241,glad0251,glad0261",
             "  FROM glaq_t",
             "  LEFT JOIN glacl_t ON glaclent=glaqent AND glacl001=? AND glacl002=glaq002 AND glacl003='",g_dlang,"'",
             "  LEFT JOIN glad_t ON gladent=glaqent AND gladld=glaqld AND glad001=glaq002 ",
             " WHERE glaqent =", g_enterprise,
             "   AND glaqld = ?",
             "   AND glaqdocno = ?",
             "   AND glaqseq = ?" 
   PREPARE aglt310_sel_hsx_pr FROM g_sql
   
   #画面底部核算项及业务资讯资料刷新
   LET l_glaq013_desc="(SELECT ooag011 FROM ooag_t WHERE ooagent = ",g_enterprise," AND ooag001 = glaq013)"
   LET l_glaq015_desc="(SELECT ooial003 FROM ooial_t WHERE ooialent=",g_enterprise," AND ooial001=glaq015 AND ooial002='",g_dlang,"')"
   LET l_glaq016_desc="(SELECT nmajl003 FROM nmajl_t WHERE nmajlent=",g_enterprise," AND nmajl001=glaq016 AND nmajl002='",g_dlang,"')"
   LET g_sql="SELECT glaq005,glaq006,glaq007,glaq008,glaq009,glaq010,",
             "       glaq011,glaq012,glaq013,glaq014,glaq015,glaq016,",
             "       glaq017,glaq018,glaq019,glaq020,glaq021,glaq022,",
             "       glaq023,glaq024,glaq051,glaq052,glaq053,glaq025,glaq027,glaq028,",
             "       glaq029,glaq030,glaq031,glaq032,glaq033,",
             "       glaq034,glaq035,glaq036,glaq037,glaq038,",
             g_get_sql.glaq017,",",g_get_sql.glaq018,",",g_get_sql.glaq019,",",g_get_sql.glaq020,",",
             g_get_sql.glaq021,",",g_get_sql.glaq022,",",g_get_sql.glaq023,",",g_get_sql.glaq024,",",
             g_get_sql.glaq025,",",g_get_sql.glaq027,",",g_get_sql.glaq028,",",g_get_sql.glaq051,",",
             g_get_sql.glaq052,",",g_get_sql.glaq053,",",l_glaq013_desc,",",l_glaq015_desc,",",l_glaq016_desc,",",
             "       glad0171,glad0181,glad0191,glad0201,glad0211,",
             "       glad0221,glad0231,glad0241,glad0251,glad0261",
             "  FROM glaq_t",
             "  LEFT JOIN glad_t ON gladent=glaqent AND gladld=glaqld AND glad001=glaq002 ",
             " WHERE glaqent =", g_enterprise,
             "   AND glaqld = ?",
             "   AND glaqdocno = ?",
             "   AND glaqseq = ?" 
   PREPARE aglt310_sel_refresh_pr FROM g_sql
   
   #现金变动码
   LET g_sql="SELECT COUNT(1) FROM glbc_t",
             " WHERE glbcent = ",g_enterprise,
             "   AND glbcld = ?",
             "   AND glbcdocno = ?",
             "   AND glbcseq = ?",
             "   AND glbc001 = ?",
             "   AND glbc002 = ?",
             "   AND glbc010 = '1'"
   PREPARE aglt310_cnt_glbc004_pr FROM g_sql
   LET g_sql="SELECT glbc004,nmail004 ", 
             "  FROM glbc_t",
             "  LEFT JOIN nmail_t ON nmailent=",g_enterprise," AND nmail001=? AND nmail002=glbc004 AND nmail003='",g_dlang,"'",
             " WHERE glbcent = ",g_enterprise,
             "   AND glbcld = ?",
             "   AND glbcdocno = ?",
             "   AND glbcseq = ?",
             "   AND glbc001 = ?",
             "   AND glbc002 = ?",
             "   AND glbc010 = '1'"
   PREPARE aglt310_sel_glbc004_pr FROM g_sql
         
   #科目说明
   LET g_sql="SELECT glacl004  FROM glacl_t",
             " WHERE glaclent = ",g_enterprise,
             "   AND glacl001 = ?",
             "   AND glacl002 = ?",
             "   AND glacl003 = '",g_dlang,"'"  
   PREPARE aglt310_sel_glacl004_pr FROM g_sql
   #自由核算項设置
   LET g_sql="SELECT glad0171,glad0181,glad0191,glad0201,glad0211,",
             "       glad0221,glad0231,glad0241,glad0251,glad0261",
             "  FROM glad_t",
             " WHERE gladent=",g_enterprise,
             "   AND gladld=? AND glad001=?"
   PREPARE aglt310_sel_glad_pr FROM g_sql
   #161205-00025#4--add--end
   #end add-point
   
   #初始化搜尋條件
   CALL aglt310_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="aglt310.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION aglt310_ui_dialog()
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
   DEFINE l_success    LIKE type_t.num5
   DEFINE l_errno      LIKE type_t.chr10  
   DEFINE l_glaq002    LIKE glaq_t.glaq002
   DEFINE l_cnt        LIKE type_t.num5
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
            CALL aglt310_insert()
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
         INITIALIZE g_glap_m.* TO NULL
         CALL g_glaq_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL aglt310_init()
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
               
               CALL aglt310_fetch('') # reload data
               LET l_ac = 1
               CALL aglt310_ui_detailshow() #Setting the current row 
         
               CALL aglt310_idx_chk()
               #NEXT FIELD glaqseq
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_glaq_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aglt310_idx_chk()
               #確定當下選擇的筆數
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[1] = l_ac
               CALL g_idx_group.addAttribute("'1',",l_ac)
               
               #add-point:page1, before row動作 name="ui_dialog.page1.before_row"
               CALL aglt310_b_detail()
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
               CALL aglt310_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
                                                            
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
                                                
            #end add-point
               
         END DISPLAY
        
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
                                    
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
      
         BEFORE DIALOG
            #先填充browser資料
            CALL aglt310_browser_fill("")
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
               CALL aglt310_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL aglt310_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL aglt310_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            IF g_glap001_p MATCHES '[123]' THEN 
               CALL cl_set_act_visible('offset',TRUE)
            ELSE
               CALL cl_set_act_visible('offset',FALSE)  
            END IF
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL aglt310_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL aglt310_set_act_visible()   
            CALL aglt310_set_act_no_visible()
            IF NOT (g_glap_m.glapld IS NULL
              OR g_glap_m.glapdocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " glapent = " ||g_enterprise|| " AND",
                                  " glapld = '", g_glap_m.glapld, "' "
                                  ," AND glapdocno = '", g_glap_m.glapdocno, "' "
 
               #填到對應位置
               CALL aglt310_browser_fill("")
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
                     WHEN la_wc[li_idx].tableid = "glap_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "glaq_t" 
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
               CALL aglt310_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                     WHEN la_wc[li_idx].tableid = "glap_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "glaq_t" 
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
                  CALL aglt310_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL aglt310_fetch("F")
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
               CALL aglt310_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL aglt310_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aglt310_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL aglt310_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aglt310_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL aglt310_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aglt310_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL aglt310_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aglt310_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL aglt310_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aglt310_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_glaq_d)
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
               NEXT FIELD glaqseq
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
         ON ACTION addi_summary
            LET g_action_choice="addi_summary"
            IF cl_auth_chk_act("addi_summary") THEN
               
               #add-point:ON ACTION addi_summary name="menu.addi_summary"
               IF g_glap_m.glapld IS NULL OR g_glap_m.glapdocno IS NULL THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "std-00003"
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
               ELSE
                  IF l_ac<=0 OR cl_null(g_glaq_d[l_ac].glaqseq) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = '-400'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                  
                  ELSE
                     INITIALIZE la_param.* TO NULL
                     LET la_param.prog = 'agli090'
                     LET la_param.param[1] = g_glap_m.glapld
                     LET la_param.param[2] = g_glap_m.glap001
                     LET la_param.param[3] = g_glap_m.glapdocno
                     LET la_param.param[4] = g_glaq_d[l_ac].glaqseq          
                     LET ls_js = util.JSON.stringify( la_param )
                     CALL cl_cmdrun(ls_js)
#                     LET l_cmd="agli090 '",g_glap_m.glapld,"' '",g_glap_m.glap001,"' '",g_glap_m.glapdocno,"' ",g_glaq_d[l_ac].glaqseq
#                     CALL cl_cmdrun(l_cmd)
                    # CALL cl_cmdrun("agli090 '"||g_glap_m.glapld||"' '"||g_glap_m.glap001||"' '"||g_glap_m.glapdocno||"' '"||g_glaq_d[l_ac].glaqseq||"'") 
                  END IF
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL aglt310_modify()
               #add-point:ON ACTION modify name="menu.modify"
               #160818-00017#14 -s by 08172
               CALL aglt310_set_act_visible()   
               CALL aglt310_set_act_no_visible()
               #160818-00017#14 -e by 08172                                            
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL aglt310_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               #160818-00017#14 -s by 08172
               CALL aglt310_set_act_visible()   
               CALL aglt310_set_act_no_visible()
               #160818-00017#14 -e by 08172                                              
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION undeduct
            LET g_action_choice="undeduct"
            IF cl_auth_chk_act("undeduct") THEN
               
               #add-point:ON ACTION undeduct name="menu.undeduct"
                                                            
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION bus_cons
            LET g_action_choice="bus_cons"
            IF cl_auth_chk_act("bus_cons") THEN
               
               #add-point:ON ACTION bus_cons name="menu.bus_cons"
               CALL aglt310_bus_cons()
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL aglt310_delete()
               #add-point:ON ACTION delete name="menu.delete"
               #160818-00017#14 -s by 08172
               CALL aglt310_set_act_visible()   
               CALL aglt310_set_act_no_visible()
               #160818-00017#14 -e by 08172                                              
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aglt310_insert()
               #add-point:ON ACTION insert name="menu.insert"
                                                            
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION offset
            LET g_action_choice="offset"
            IF cl_auth_chk_act("offset") THEN
               
               #add-point:ON ACTION offset name="menu.offset"
               #當aglt310、aglt320、aglt330時判斷是否進行細項立沖
               CALL s_transaction_begin()          
               CALL aglt310_offset() RETURNING l_success
               IF l_success=FALSE THEN
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
#               IF NOT cl_null(g_glap_m.glapld) AND NOT cl_null(g_glap_m.glapdocno) THEN
#                  INITIALIZE la_param.* TO NULL
#                  LET la_param.prog = 'aglr310'
#                  LET la_param.param[1] = 'Y'    #背景作业
#                  LET la_param.param[2] = g_glap_m.glapld #帐套
#                  LET la_param.param[3] = g_glap_m.glapdocno #单号
#                  LET la_param.param[4] = '1' #报表样式
#                  LET ls_js = util.JSON.stringify( la_param )
#                  CALL cl_cmdrun(ls_js)
#               END IF
               IF cl_null(g_glap_m.glapld) OR  cl_null(g_glap_m.glapdocno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ""
                  LET g_errparam.code   = "std-00003"
                  LET g_errparam.popup  = FALSE
                  CALL cl_err()
                  EXIT DIALOG
               END IF
               LET g_rep_wc=" glapent=",g_enterprise," AND glapld='",g_glap_m.glapld,"' AND glapdocno='",g_glap_m.glapdocno,"'"
               #END add-point
               &include "erp/agl/aglt310_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               EXIT DIALOG   #2015/10/21 add by 02599
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
#               IF NOT cl_null(g_glap_m.glapld) AND NOT cl_null(g_glap_m.glapdocno) THEN
#                  INITIALIZE la_param.* TO NULL
#                  LET la_param.prog = 'aglr310'
#                  LET la_param.param[1] = 'Y'    #背景作业
#                  LET la_param.param[2] = g_glap_m.glapld #帐套
#                  LET la_param.param[3] = g_glap_m.glapdocno #单号
#                  LET la_param.param[4] = '1' #报表样式
#                  LET ls_js = util.JSON.stringify( la_param )
#                  CALL cl_cmdrun(ls_js)
#               END IF
               IF cl_null(g_glap_m.glapld) OR  cl_null(g_glap_m.glapdocno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ""
                  LET g_errparam.code   = "std-00003"
                  LET g_errparam.popup  = FALSE
                  CALL cl_err()
                  EXIT DIALOG
               END IF
               LET g_rep_wc=" glapent=",g_enterprise," AND glapld='",g_glap_m.glapld,"' AND glapdocno='",g_glap_m.glapdocno,"'"
               #END add-point
               &include "erp/agl/aglt310_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL aglt310_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
                                                            
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aglt310_query()
               #add-point:ON ACTION query name="menu.query"
                                                            
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION cashflow
            LET g_action_choice="cashflow"
            IF cl_auth_chk_act("cashflow") THEN
               
               #add-point:ON ACTION cashflow name="menu.cashflow"
               IF g_glap001_p MATCHES '[12345]' THEN
                  CALL aglt310_cashflow()
               ELSE
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "agl-00280"
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION excel_load
            LET g_action_choice="excel_load"
            IF cl_auth_chk_act("excel_load") THEN
               
               #add-point:ON ACTION excel_load name="menu.excel_load"
               LET g_etlparam[1].para_id = "g_lang"
               LET g_etlparam[1].type = "string"
               LET g_etlparam[1].value = g_lang

               LET la_param.prog = 'awsp200'
               LET la_param.param[1] = g_prog
               LET la_param.param[2] = "excel_load"
               LET la_param.param[3] = util.JSON.stringify(g_etlparam)

               LET ls_js = util.JSON.stringify( la_param )
               CALL cl_cmdrun_wait(ls_js)
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aglt310_07
            LET g_action_choice="open_aglt310_07"
            IF cl_auth_chk_act("open_aglt310_07") THEN
               
               #add-point:ON ACTION open_aglt310_07 name="menu.open_aglt310_07"
               #151201-00004#1--mod--str--
#               CALL aglt310_07(g_glap_m.glapld,g_glap_m.glapdocno) 
               CALL aglt310_07(g_glap_m.glapld,g_glap_m.glapdocno,0) RETURNING g_glap_m.sdocno
               #151201-00004#1--mod--end
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION exchange_ld
            LET g_action_choice="exchange_ld"
            IF cl_auth_chk_act("exchange_ld") THEN
               
               #add-point:ON ACTION exchange_ld name="menu.exchange_ld"
                                                                          
               CALL aglt310_01(g_glap_m.glapld) RETURNING g_bookno
               LET g_glaald = g_bookno
               LET g_glapld = g_bookno
               #依据对应的主账套编码，抓取对应法人，币别，汇率参照编号，会计科目参照编号,关账日期
               CALL aglt310_glapld_desc(g_glapld)
                
                IF cl_null(g_wc) THEN
                   LET g_wc = '1=1'
                END IF 
                LET g_wc1 = ' 1=1'
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION excel_example
            LET g_action_choice="excel_example"
            IF cl_auth_chk_act("excel_example") THEN
               
               #add-point:ON ACTION excel_example name="menu.excel_example"
               LET g_etlparam[1].para_id = "g_lang"
               LET g_etlparam[1].type = "string"
               LET g_etlparam[1].value = g_lang

               LET la_param.prog = 'awsp200'
               LET la_param.param[1] = g_prog
               LET la_param.param[2] = "excel_example"
               LET la_param.param[3] = util.JSON.stringify(g_etlparam)

               LET ls_js = util.JSON.stringify( la_param )
               CALL cl_cmdrun_wait(ls_js)
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION fix_acc
            LET g_action_choice="fix_acc"
            IF cl_auth_chk_act("fix_acc") THEN
               
               #add-point:ON ACTION fix_acc name="menu.fix_acc"
               CALL aglt310_fix_acc()
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_azzp660
            LET g_action_choice="open_azzp660"
            IF cl_auth_chk_act("open_azzp660") THEN
               
               #add-point:ON ACTION open_azzp660 name="menu.open_azzp660"
               #161107-00028#1 add s--
               LET la_param.prog = "azzp660"
               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun_wait(ls_js)
               #161107-00028#1 add e--
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_sdocno
            LET g_action_choice="prog_sdocno"
            IF cl_auth_chk_act("prog_sdocno") THEN
               
               #add-point:ON ACTION prog_sdocno name="menu.prog_sdocno"
               #151201-00004#1--add--str--
               IF NOT cl_null(g_glap_m.sdocno) THEN
                  #串查來源單據
                  CALL aglt310_07(g_glap_m.glapld,g_glap_m.glapdocno,0) RETURNING g_glap_m.sdocno
               END IF
               #151201-00004#1--mod--end
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_glaq025
            LET g_action_choice="prog_glaq025"
            IF cl_auth_chk_act("prog_glaq025") THEN
               
               #add-point:ON ACTION prog_glaq025 name="menu.prog_glaq025"
               IF NOT cl_null(g_glap_m.glaq025) THEN
                  CALL cl_user_contact("aooi130", "ooag_t", "ooag002", "ooag001",g_glap_m.glaq025)
               END IF
               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL aglt310_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aglt310_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aglt310_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_glap_m.glapdocdt)
 
 
 
         
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
 
{<section id="aglt310.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION aglt310_browser_fill(ps_page_action)
   #add-point:browser_fill段define(客製用) name="browser_fill.define_customerization"
   
   #end add-point  
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
            
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
#   LET g_wc = '1=1'
   IF cl_null(g_wc1) THEN LET g_wc1 = ' 1=1' END IF 
   LET g_wc = g_wc," AND ",g_wc1," AND glap001 = '",g_glap001_p,"' AND glapld = '",g_glapld,"'"
#   IF NOT cl_null(g_glapdocno_p) THEN
#      LET g_wc = g_wc," AND glapdocno = '",g_glapdocno_p,"'"
#   END IF 
   
   LET l_wc  = g_wc.trim()  
   IF cl_null(l_wc) THEN  #p_wc 查詢條件
      RETURN
   END IF
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT glapld,glapdocno ",
                      " FROM glap_t ",
                      " ",
                      " LEFT JOIN glaq_t ON glaqent = glapent AND glapld = glaqld AND glapdocno = glaqdocno ", "  ",
                      #add-point:browser_fill段sql(glaq_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
 
                      " ", 
                      " ", 
 
 
                      " WHERE glapent = " ||g_enterprise|| " AND glaqent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("glap_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT glapld,glapdocno ",
                      " FROM glap_t ", 
                      "  ",
                      "  ",
                      " WHERE glapent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("glap_t")
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
      INITIALIZE g_glap_m.* TO NULL
      CALL g_glaq_d.clear()        
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.glapld,t0.glap002,t0.glap004,t0.glapdocno,t0.glapdocdt,t0.glap007,t0.glap008 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.glapstus,t0.glapld,t0.glap002,t0.glap004,t0.glapdocno,t0.glapdocdt, 
          t0.glap007,t0.glap008 ",
                  " FROM glap_t t0",
                  "  ",
                  "  LEFT JOIN glaq_t ON glaqent = glapent AND glapld = glaqld AND glapdocno = glaqdocno ", "  ", 
                  #add-point:browser_fill段sql(glaq_t1) name="browser_fill.join.glaq_t1"
                  
                  #end add-point
 
 
                  " ", 
 
 
                  
                  " WHERE t0.glapent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("glap_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.glapstus,t0.glapld,t0.glap002,t0.glap004,t0.glapdocno,t0.glapdocdt, 
          t0.glap007,t0.glap008 ",
                  " FROM glap_t t0",
                  "  ",
                  
                  " WHERE t0.glapent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("glap_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
     
   LET l_sql = g_sql
   #end add-point
   LET g_sql = g_sql, " ORDER BY glapld,glapdocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   LET g_sql = l_sql, " ORDER BY glapld,glap002,glap004,glapdocno ",g_order
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"glap_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
            
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_glapld,g_browser[g_cnt].b_glap002, 
          g_browser[g_cnt].b_glap004,g_browser[g_cnt].b_glapdocno,g_browser[g_cnt].b_glapdocdt,g_browser[g_cnt].b_glap007, 
          g_browser[g_cnt].b_glap008
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
         CALL aglt310_browser_mask()
      
               #應用 a24 樣板自動產生(Version:3)
      #browser顯示圖片
      CASE g_browser[g_cnt].b_statepic
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/unconfirmed.png"
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/confirmed.png"
         WHEN "S"
            LET g_browser[g_cnt].b_statepic = "stus/16/posted.png"
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
   
   IF cl_null(g_browser[g_cnt].b_glapld) THEN
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
   #160729-00009#4  --add--s--
   #若無資料則關閉相關功能
   #共用的action都拿掉
   IF g_browser_cnt = 0 THEN     
         CALL cl_set_act_visible('excel_load,excel_example',FALSE)
   END IF   
   #160729-00009#4  --add--e--
   #end add-point   
 
END FUNCTION
 
{</section>}
 
{<section id="aglt310.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION aglt310_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
            
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_glap_m.glapld = g_browser[g_current_idx].b_glapld   
   LET g_glap_m.glapdocno = g_browser[g_current_idx].b_glapdocno   
 
   EXECUTE aglt310_master_referesh USING g_glap_m.glapld,g_glap_m.glapdocno INTO g_glap_m.glapld,g_glap_m.glapcomp, 
       g_glap_m.glap001,g_glap_m.glapdocno,g_glap_m.glapdocdt,g_glap_m.glap002,g_glap_m.glap004,g_glap_m.glap007, 
       g_glap_m.glap008,g_glap_m.glap010,g_glap_m.glap011,g_glap_m.glap006,g_glap_m.glap015,g_glap_m.glap013, 
       g_glap_m.glap009,g_glap_m.glap016,g_glap_m.glap017,g_glap_m.glap012,g_glap_m.glap014,g_glap_m.glapstus, 
       g_glap_m.glapownid,g_glap_m.glapcrtdp,g_glap_m.glapowndp,g_glap_m.glapcrtdt,g_glap_m.glapcrtid, 
       g_glap_m.glapmodid,g_glap_m.glapmoddt,g_glap_m.glapcnfid,g_glap_m.glapcnfdt,g_glap_m.glappstid, 
       g_glap_m.glappstdt,g_glap_m.glapld_desc,g_glap_m.glapcomp_desc,g_glap_m.glap016_desc,g_glap_m.glapownid_desc, 
       g_glap_m.glapcrtdp_desc,g_glap_m.glapowndp_desc,g_glap_m.glapcrtid_desc,g_glap_m.glapmodid_desc, 
       g_glap_m.glapcnfid_desc,g_glap_m.glappstid_desc
   
   CALL aglt310_glap_t_mask()
   CALL aglt310_show()
      
END FUNCTION
 
{</section>}
 
{<section id="aglt310.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION aglt310_ui_detailshow()
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
 
{<section id="aglt310.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION aglt310_ui_browser_refresh()
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
      IF g_browser[l_i].b_glapld = g_glap_m.glapld 
         AND g_browser[l_i].b_glapdocno = g_glap_m.glapdocno 
 
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
 
{<section id="aglt310.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION aglt310_construct()
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
               DEFINE l_num          LIKE type_t.num5
   DEFINE l_num1         LIKE type_t.num5
   DEFINE l_wc           STRING 
   #end add-point    
   
   #add-point:Function前置處理  name="cs.pre_function"
   
   #end add-point
    
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_glap_m.* TO NULL
   CALL g_glaq_d.clear()        
 
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前 name="cs.before_construct"
   INITIALIZE g_wc_frozen TO NULL
   INITIALIZE g_wc1 TO NULL
   INITIALIZE g_wc_glbc TO NULL
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON glapld,glap001,glapdocno,glapdocdt,glap002,glap004,glap007,glap008,glap010, 
          glap011,glap006,glap006_desc,glap015,glap013,glap009,glap016,glap017,glap012,glap014,glapstus, 
          glapownid,glapcrtdp,glapowndp,glapcrtdt,glapcrtid,glapmodid,glapmoddt,glapcnfid,glapcnfdt, 
          glappstid,glappstdt,glaq017_desc,glaq018_desc,glaq019_desc,glaq020_desc,glaq021_desc,glaq022_desc, 
          glaq023_desc,glaq024_desc,glbc004_desc,glaq052_desc,glaq053_desc,glaq028_desc,glaq029_desc, 
          glaq030_desc,glaq031_desc,glaq032_desc,glaq033_desc,glaq034_desc,glaq035_desc,glaq036_desc, 
          glaq037_desc,glaq038_desc,glaq015_desc,glaq016_desc,conf,creat
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            DISPLAY g_glapld TO glapld              #帐别
            DISPLAY g_glaacomp TO glapcomp          #法人 
            DISPLAY g_glaa001 TO glaa001_desc       #币别
            DISPLAY g_glaa016 TO glaa016       #币别二
            DISPLAY g_glaa020 TO glaa020       #币别三
#            CALL cl_set_comp_visible("glaq005,glaq006,glaq010",FALSE)
           
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<glapcrtdt>>----
         AFTER FIELD glapcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<glapmoddt>>----
         AFTER FIELD glapmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<glapcnfdt>>----
         AFTER FIELD glapcnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<glappstdt>>----
         AFTER FIELD glappstdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.glapld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glapld
            #add-point:ON ACTION controlp INFIELD glapld name="construct.c.glapld"
                                                            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_glapld()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glapld  #顯示到畫面上

            NEXT FIELD glapld                     #返回原欄位
       
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glapld
            #add-point:BEFORE FIELD glapld name="construct.b.glapld"
                                                            NEXT FIELD glapdocno
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glapld
            
            #add-point:AFTER FIELD glapld name="construct.a.glapld"
                                                
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glap001
            #add-point:BEFORE FIELD glap001 name="construct.b.glap001"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glap001
            
            #add-point:AFTER FIELD glap001 name="construct.a.glap001"
                                                
            #END add-point
            
 
 
         #Ctrlp:construct.c.glap001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glap001
            #add-point:ON ACTION controlp INFIELD glap001 name="construct.c.glap001"
                                                
            #END add-point
 
 
         #Ctrlp:construct.c.glapdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glapdocno
            #add-point:ON ACTION controlp INFIELD glapdocno name="construct.c.glapdocno"
                                                            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "glapld = '",g_glapld,"'"   #账套
            #161104-00046#11-----s
            #單別權限控管
            IF NOT cl_null(g_user_dept_wc_q) AND NOT g_user_dept_wc_q = ' 1=1'  THEN
               LET g_qryparam.where = g_qryparam.where, " AND ",g_user_dept_wc_q CLIPPED
            END IF
            #161104-00046#11-----e
            CALL q_glapdocno()                                #呼叫開窗
            LET g_qryparam.where =""                          #呼叫開窗
            DISPLAY g_qryparam.return1 TO glapdocno  #顯示到畫面上

            NEXT FIELD glapdocno                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glapdocno
            #add-point:BEFORE FIELD glapdocno name="construct.b.glapdocno"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glapdocno
            
            #add-point:AFTER FIELD glapdocno name="construct.a.glapdocno"
                                                
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glapdocdt
            #add-point:BEFORE FIELD glapdocdt name="construct.b.glapdocdt"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glapdocdt
            
            #add-point:AFTER FIELD glapdocdt name="construct.a.glapdocdt"
                                                
            #END add-point
            
 
 
         #Ctrlp:construct.c.glapdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glapdocdt
            #add-point:ON ACTION controlp INFIELD glapdocdt name="construct.c.glapdocdt"
                                                
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glap002
            #add-point:BEFORE FIELD glap002 name="construct.b.glap002"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glap002
            
            #add-point:AFTER FIELD glap002 name="construct.a.glap002"
                                                
            #END add-point
            
 
 
         #Ctrlp:construct.c.glap002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glap002
            #add-point:ON ACTION controlp INFIELD glap002 name="construct.c.glap002"
                                                
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glap004
            #add-point:BEFORE FIELD glap004 name="construct.b.glap004"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glap004
            
            #add-point:AFTER FIELD glap004 name="construct.a.glap004"
                                                
            #END add-point
            
 
 
         #Ctrlp:construct.c.glap004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glap004
            #add-point:ON ACTION controlp INFIELD glap004 name="construct.c.glap004"
                                                
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glap007
            #add-point:BEFORE FIELD glap007 name="construct.b.glap007"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glap007
            
            #add-point:AFTER FIELD glap007 name="construct.a.glap007"
                                                
            #END add-point
            
 
 
         #Ctrlp:construct.c.glap007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glap007
            #add-point:ON ACTION controlp INFIELD glap007 name="construct.c.glap007"
                                                
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glap008
            #add-point:BEFORE FIELD glap008 name="construct.b.glap008"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glap008
            
            #add-point:AFTER FIELD glap008 name="construct.a.glap008"
                                                
            #END add-point
            
 
 
         #Ctrlp:construct.c.glap008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glap008
            #add-point:ON ACTION controlp INFIELD glap008 name="construct.c.glap008"
                                                
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glap010
            #add-point:BEFORE FIELD glap010 name="construct.b.glap010"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glap010
            
            #add-point:AFTER FIELD glap010 name="construct.a.glap010"
                                                
            #END add-point
            
 
 
         #Ctrlp:construct.c.glap010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glap010
            #add-point:ON ACTION controlp INFIELD glap010 name="construct.c.glap010"
                                                
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glap011
            #add-point:BEFORE FIELD glap011 name="construct.b.glap011"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glap011
            
            #add-point:AFTER FIELD glap011 name="construct.a.glap011"
                                                
            #END add-point
            
 
 
         #Ctrlp:construct.c.glap011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glap011
            #add-point:ON ACTION controlp INFIELD glap011 name="construct.c.glap011"
                                                
            #END add-point
 
 
         #Ctrlp:construct.c.glap006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glap006
            #add-point:ON ACTION controlp INFIELD glap006 name="construct.c.glap006"
                                                            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE            
            #CALL q_glac()                           #呼叫開窗
            LET g_qryparam.where = "glac001 = '",g_glaa004,"' AND  glac003 <>'1' AND glac006 = '1'",
                                   #151117-00009#1--add--str--
                                   " AND glac002 IN (SELECT glad001 FROM glad_t ",
                                   "                  WHERE gladent=",g_enterprise," AND gladld='",g_glapld,"'",
                                   "                    AND glad035='N' AND gladstus='Y' )"
                                   #151117-00009#1--add--end
            CALL aglt310_04()
            DISPLAY g_qryparam.return1 TO glap006  #顯示到畫面上
            LET g_qryparam.where = ""
            NEXT FIELD glap006                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glap006
            #add-point:BEFORE FIELD glap006 name="construct.b.glap006"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glap006
            
            #add-point:AFTER FIELD glap006 name="construct.a.glap006"
                                                
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glap006_desc
            #add-point:BEFORE FIELD glap006_desc name="construct.b.glap006_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glap006_desc
            
            #add-point:AFTER FIELD glap006_desc name="construct.a.glap006_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glap006_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glap006_desc
            #add-point:ON ACTION controlp INFIELD glap006_desc name="construct.c.glap006_desc"
            
            #END add-point
 
 
         #Ctrlp:construct.c.glap015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glap015
            #add-point:ON ACTION controlp INFIELD glap015 name="construct.c.glap015"
                                                            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "glapld = '",g_glapld,"'"   #账套
            CALL q_glapdocno()                                #呼叫開窗
            LET g_qryparam.where =""                          #呼叫開窗
            DISPLAY g_qryparam.return1 TO glap015  #顯示到畫面上

            NEXT FIELD glap015                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glap015
            #add-point:BEFORE FIELD glap015 name="construct.b.glap015"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glap015
            
            #add-point:AFTER FIELD glap015 name="construct.a.glap015"
                                                
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glap013
            #add-point:BEFORE FIELD glap013 name="construct.b.glap013"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glap013
            
            #add-point:AFTER FIELD glap013 name="construct.a.glap013"
                                                
            #END add-point
            
 
 
         #Ctrlp:construct.c.glap013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glap013
            #add-point:ON ACTION controlp INFIELD glap013 name="construct.c.glap013"
                                                
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glap009
            #add-point:BEFORE FIELD glap009 name="construct.b.glap009"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glap009
            
            #add-point:AFTER FIELD glap009 name="construct.a.glap009"
                                                
            #END add-point
            
 
 
         #Ctrlp:construct.c.glap009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glap009
            #add-point:ON ACTION controlp INFIELD glap009 name="construct.c.glap009"
                                                
            #END add-point
 
 
         #Ctrlp:construct.c.glap016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glap016
            #add-point:ON ACTION controlp INFIELD glap016 name="construct.c.glap016"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_user #160805-00022#1 add
            LET g_qryparam.arg2 = g_dept #160805-00022#1 add
            CALL q_authorised_ld()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glap016  #顯示到畫面上
            NEXT FIELD glap016                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glap016
            #add-point:BEFORE FIELD glap016 name="construct.b.glap016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glap016
            
            #add-point:AFTER FIELD glap016 name="construct.a.glap016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glap017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glap017
            #add-point:ON ACTION controlp INFIELD glap017 name="construct.c.glap017"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_glap017()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glap017  #顯示到畫面上
            NEXT FIELD glap017                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glap017
            #add-point:BEFORE FIELD glap017 name="construct.b.glap017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glap017
            
            #add-point:AFTER FIELD glap017 name="construct.a.glap017"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glap012
            #add-point:BEFORE FIELD glap012 name="construct.b.glap012"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glap012
            
            #add-point:AFTER FIELD glap012 name="construct.a.glap012"
                                                
            #END add-point
            
 
 
         #Ctrlp:construct.c.glap012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glap012
            #add-point:ON ACTION controlp INFIELD glap012 name="construct.c.glap012"
                                                
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glap014
            #add-point:BEFORE FIELD glap014 name="construct.b.glap014"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glap014
            
            #add-point:AFTER FIELD glap014 name="construct.a.glap014"
                                                
            #END add-point
            
 
 
         #Ctrlp:construct.c.glap014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glap014
            #add-point:ON ACTION controlp INFIELD glap014 name="construct.c.glap014"
                                                
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glapstus
            #add-point:BEFORE FIELD glapstus name="construct.b.glapstus"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glapstus
            
            #add-point:AFTER FIELD glapstus name="construct.a.glapstus"
                                                
            #END add-point
            
 
 
         #Ctrlp:construct.c.glapstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glapstus
            #add-point:ON ACTION controlp INFIELD glapstus name="construct.c.glapstus"
                                                
            #END add-point
 
 
         #Ctrlp:construct.c.glapownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glapownid
            #add-point:ON ACTION controlp INFIELD glapownid name="construct.c.glapownid"
                                                            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glapownid  #顯示到畫面上

            NEXT FIELD glapownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glapownid
            #add-point:BEFORE FIELD glapownid name="construct.b.glapownid"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glapownid
            
            #add-point:AFTER FIELD glapownid name="construct.a.glapownid"
                                                
            #END add-point
            
 
 
         #Ctrlp:construct.c.glapcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glapcrtdp
            #add-point:ON ACTION controlp INFIELD glapcrtdp name="construct.c.glapcrtdp"
                                                            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glapcrtdp  #顯示到畫面上

            NEXT FIELD glapcrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glapcrtdp
            #add-point:BEFORE FIELD glapcrtdp name="construct.b.glapcrtdp"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glapcrtdp
            
            #add-point:AFTER FIELD glapcrtdp name="construct.a.glapcrtdp"
                                                
            #END add-point
            
 
 
         #Ctrlp:construct.c.glapowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glapowndp
            #add-point:ON ACTION controlp INFIELD glapowndp name="construct.c.glapowndp"
                                                            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glapowndp  #顯示到畫面上

            NEXT FIELD glapowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glapowndp
            #add-point:BEFORE FIELD glapowndp name="construct.b.glapowndp"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glapowndp
            
            #add-point:AFTER FIELD glapowndp name="construct.a.glapowndp"
                                                
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glapcrtdt
            #add-point:BEFORE FIELD glapcrtdt name="construct.b.glapcrtdt"
                                                
            #END add-point
 
 
         #Ctrlp:construct.c.glapcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glapcrtid
            #add-point:ON ACTION controlp INFIELD glapcrtid name="construct.c.glapcrtid"
                                                            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glapcrtid  #顯示到畫面上

            NEXT FIELD glapcrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glapcrtid
            #add-point:BEFORE FIELD glapcrtid name="construct.b.glapcrtid"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glapcrtid
            
            #add-point:AFTER FIELD glapcrtid name="construct.a.glapcrtid"
                                                
            #END add-point
            
 
 
         #Ctrlp:construct.c.glapmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glapmodid
            #add-point:ON ACTION controlp INFIELD glapmodid name="construct.c.glapmodid"
                                                            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glapmodid  #顯示到畫面上

            NEXT FIELD glapmodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glapmodid
            #add-point:BEFORE FIELD glapmodid name="construct.b.glapmodid"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glapmodid
            
            #add-point:AFTER FIELD glapmodid name="construct.a.glapmodid"
                                                
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glapmoddt
            #add-point:BEFORE FIELD glapmoddt name="construct.b.glapmoddt"
                                                
            #END add-point
 
 
         #Ctrlp:construct.c.glapcnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glapcnfid
            #add-point:ON ACTION controlp INFIELD glapcnfid name="construct.c.glapcnfid"
                                                            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glapcnfid  #顯示到畫面上

            NEXT FIELD glapcnfid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glapcnfid
            #add-point:BEFORE FIELD glapcnfid name="construct.b.glapcnfid"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glapcnfid
            
            #add-point:AFTER FIELD glapcnfid name="construct.a.glapcnfid"
                                                
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glapcnfdt
            #add-point:BEFORE FIELD glapcnfdt name="construct.b.glapcnfdt"
                                                
            #END add-point
 
 
         #Ctrlp:construct.c.glappstid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glappstid
            #add-point:ON ACTION controlp INFIELD glappstid name="construct.c.glappstid"
                                                            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glappstid  #顯示到畫面上

            NEXT FIELD glappstid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glappstid
            #add-point:BEFORE FIELD glappstid name="construct.b.glappstid"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glappstid
            
            #add-point:AFTER FIELD glappstid name="construct.a.glappstid"
                                                
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glappstdt
            #add-point:BEFORE FIELD glappstdt name="construct.b.glappstdt"
                                                
            #END add-point
 
 
         #Ctrlp:construct.c.glaq017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq017
            #add-point:ON ACTION controlp INFIELD glaq017 name="construct.c.glaq017"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			   LET g_qryparam.where =" ooef201 = 'Y'" #161021-00037#3 add
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaq017  #顯示到畫面上

            NEXT FIELD glaq017                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq017
            #add-point:BEFORE FIELD glaq017 name="construct.b.glaq017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq017
            
            #add-point:AFTER FIELD glaq017 name="construct.a.glaq017"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq017_desc
            #add-point:BEFORE FIELD glaq017_desc name="construct.b.glaq017_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq017_desc
            
            #add-point:AFTER FIELD glaq017_desc name="construct.a.glaq017_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaq017_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq017_desc
            #add-point:ON ACTION controlp INFIELD glaq017_desc name="construct.c.glaq017_desc"
            
            #END add-point
 
 
         #Ctrlp:construct.c.glaq018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq018
            #add-point:ON ACTION controlp INFIELD glaq018 name="construct.c.glaq018"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaq018  #顯示到畫面上

            NEXT FIELD glaq018                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq018
            #add-point:BEFORE FIELD glaq018 name="construct.b.glaq018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq018
            
            #add-point:AFTER FIELD glaq018 name="construct.a.glaq018"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq018_desc
            #add-point:BEFORE FIELD glaq018_desc name="construct.b.glaq018_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq018_desc
            
            #add-point:AFTER FIELD glaq018_desc name="construct.a.glaq018_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaq018_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq018_desc
            #add-point:ON ACTION controlp INFIELD glaq018_desc name="construct.c.glaq018_desc"
            
            #END add-point
 
 
         #Ctrlp:construct.c.glaq019
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq019
            #add-point:ON ACTION controlp INFIELD glaq019 name="construct.c.glaq019"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaq019  #顯示到畫面上

            NEXT FIELD glaq019                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq019
            #add-point:BEFORE FIELD glaq019 name="construct.b.glaq019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq019
            
            #add-point:AFTER FIELD glaq019 name="construct.a.glaq019"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq019_desc
            #add-point:BEFORE FIELD glaq019_desc name="construct.b.glaq019_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq019_desc
            
            #add-point:AFTER FIELD glaq019_desc name="construct.a.glaq019_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaq019_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq019_desc
            #add-point:ON ACTION controlp INFIELD glaq019_desc name="construct.c.glaq019_desc"
            
            #END add-point
 
 
         #Ctrlp:construct.c.glaq020
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq020
            #add-point:ON ACTION controlp INFIELD glaq020 name="construct.c.glaq020"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			   LET g_qryparam.arg1='287'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaq020  #顯示到畫面上

            NEXT FIELD glaq020                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq020
            #add-point:BEFORE FIELD glaq020 name="construct.b.glaq020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq020
            
            #add-point:AFTER FIELD glaq020 name="construct.a.glaq020"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq020_desc
            #add-point:BEFORE FIELD glaq020_desc name="construct.b.glaq020_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq020_desc
            
            #add-point:AFTER FIELD glaq020_desc name="construct.a.glaq020_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaq020_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq020_desc
            #add-point:ON ACTION controlp INFIELD glaq020_desc name="construct.c.glaq020_desc"
            
            #END add-point
 
 
         #Ctrlp:construct.c.glaq021
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq021
            #add-point:ON ACTION controlp INFIELD glaq021 name="construct.c.glaq021"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
           #CALL q_pmaa001()    #160913-00017#4  mark               #呼叫開窗
          CALL q_pmaa001_25() #160913-00017#4  add 
            DISPLAY g_qryparam.return1 TO glaq021  #顯示到畫面上

            NEXT FIELD glaq021                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq021
            #add-point:BEFORE FIELD glaq021 name="construct.b.glaq021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq021
            
            #add-point:AFTER FIELD glaq021 name="construct.a.glaq021"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq021_desc
            #add-point:BEFORE FIELD glaq021_desc name="construct.b.glaq021_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq021_desc
            
            #add-point:AFTER FIELD glaq021_desc name="construct.a.glaq021_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaq021_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq021_desc
            #add-point:ON ACTION controlp INFIELD glaq021_desc name="construct.c.glaq021_desc"
            
            #END add-point
 
 
         #Ctrlp:construct.c.glaq022
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq022
            #add-point:ON ACTION controlp INFIELD glaq022 name="construct.c.glaq022"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
           #CALL q_pmaa001()    #160913-00017#4  mark               #呼叫開窗
          CALL q_pmaa001_25() #160913-00017#4  add 
            DISPLAY g_qryparam.return1 TO glaq022  #顯示到畫面上

            NEXT FIELD glaq022                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq022
            #add-point:BEFORE FIELD glaq022 name="construct.b.glaq022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq022
            
            #add-point:AFTER FIELD glaq022 name="construct.a.glaq022"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq022_desc
            #add-point:BEFORE FIELD glaq022_desc name="construct.b.glaq022_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq022_desc
            
            #add-point:AFTER FIELD glaq022_desc name="construct.a.glaq022_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaq022_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq022_desc
            #add-point:ON ACTION controlp INFIELD glaq022_desc name="construct.c.glaq022_desc"
            
            #END add-point
 
 
         #Ctrlp:construct.c.glaq023
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq023
            #add-point:ON ACTION controlp INFIELD glaq023 name="construct.c.glaq023"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			   LET g_qryparam.arg1='281'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaq023  #顯示到畫面上

            NEXT FIELD glaq023                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq023
            #add-point:BEFORE FIELD glaq023 name="construct.b.glaq023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq023
            
            #add-point:AFTER FIELD glaq023 name="construct.a.glaq023"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq023_desc
            #add-point:BEFORE FIELD glaq023_desc name="construct.b.glaq023_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq023_desc
            
            #add-point:AFTER FIELD glaq023_desc name="construct.a.glaq023_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaq023_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq023_desc
            #add-point:ON ACTION controlp INFIELD glaq023_desc name="construct.c.glaq023_desc"
            
            #END add-point
 
 
         #Ctrlp:construct.c.glaq024
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq024
            #add-point:ON ACTION controlp INFIELD glaq024 name="construct.c.glaq024"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_rtax001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaq024  #顯示到畫面上

            NEXT FIELD glaq024                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq024
            #add-point:BEFORE FIELD glaq024 name="construct.b.glaq024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq024
            
            #add-point:AFTER FIELD glaq024 name="construct.a.glaq024"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq024_desc
            #add-point:BEFORE FIELD glaq024_desc name="construct.b.glaq024_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq024_desc
            
            #add-point:AFTER FIELD glaq024_desc name="construct.a.glaq024_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaq024_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq024_desc
            #add-point:ON ACTION controlp INFIELD glaq024_desc name="construct.c.glaq024_desc"
            
            #END add-point
 
 
         #Ctrlp:construct.c.glbc004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glbc004
            #add-point:ON ACTION controlp INFIELD glbc004 name="construct.c.glbc004"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where="nmai001='",g_glaa005,"'"
            CALL q_nmai002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glbc004  #顯示到畫面上
            NEXT FIELD glbc004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glbc004
            #add-point:BEFORE FIELD glbc004 name="construct.b.glbc004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glbc004
            
            #add-point:AFTER FIELD glbc004 name="construct.a.glbc004"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glbc004_desc
            #add-point:BEFORE FIELD glbc004_desc name="construct.b.glbc004_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glbc004_desc
            
            #add-point:AFTER FIELD glbc004_desc name="construct.a.glbc004_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glbc004_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glbc004_desc
            #add-point:ON ACTION controlp INFIELD glbc004_desc name="construct.c.glbc004_desc"
            
            #END add-point
 
 
         #Ctrlp:construct.c.glaq052
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq052
            #add-point:ON ACTION controlp INFIELD glaq052 name="construct.c.glaq052"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_oojd001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaq052  #顯示到畫面上

            NEXT FIELD glaq052                     #返回原欄位

            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq052
            #add-point:BEFORE FIELD glaq052 name="construct.b.glaq052"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq052
            
            #add-point:AFTER FIELD glaq052 name="construct.a.glaq052"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq052_desc
            #add-point:BEFORE FIELD glaq052_desc name="construct.b.glaq052_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq052_desc
            
            #add-point:AFTER FIELD glaq052_desc name="construct.a.glaq052_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaq052_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq052_desc
            #add-point:ON ACTION controlp INFIELD glaq052_desc name="construct.c.glaq052_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq053
            #add-point:BEFORE FIELD glaq053 name="construct.b.glaq053"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq053
            
            #add-point:AFTER FIELD glaq053 name="construct.a.glaq053"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaq053
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq053
            #add-point:ON ACTION controlp INFIELD glaq053 name="construct.c.glaq053"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.arg1='2002'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaq053  #顯示到畫面上

            NEXT FIELD glaq053                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq053_desc
            #add-point:BEFORE FIELD glaq053_desc name="construct.b.glaq053_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq053_desc
            
            #add-point:AFTER FIELD glaq053_desc name="construct.a.glaq053_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaq053_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq053_desc
            #add-point:ON ACTION controlp INFIELD glaq053_desc name="construct.c.glaq053_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq028
            #add-point:BEFORE FIELD glaq028 name="construct.b.glaq028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq028
            
            #add-point:AFTER FIELD glaq028 name="construct.a.glaq028"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaq028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq028
            #add-point:ON ACTION controlp INFIELD glaq028 name="construct.c.glaq028"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq028_desc
            #add-point:BEFORE FIELD glaq028_desc name="construct.b.glaq028_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq028_desc
            
            #add-point:AFTER FIELD glaq028_desc name="construct.a.glaq028_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaq028_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq028_desc
            #add-point:ON ACTION controlp INFIELD glaq028_desc name="construct.c.glaq028_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq029
            #add-point:BEFORE FIELD glaq029 name="construct.b.glaq029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq029
            
            #add-point:AFTER FIELD glaq029 name="construct.a.glaq029"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaq029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq029
            #add-point:ON ACTION controlp INFIELD glaq029 name="construct.c.glaq029"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq029_desc
            #add-point:BEFORE FIELD glaq029_desc name="construct.b.glaq029_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq029_desc
            
            #add-point:AFTER FIELD glaq029_desc name="construct.a.glaq029_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaq029_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq029_desc
            #add-point:ON ACTION controlp INFIELD glaq029_desc name="construct.c.glaq029_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq030
            #add-point:BEFORE FIELD glaq030 name="construct.b.glaq030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq030
            
            #add-point:AFTER FIELD glaq030 name="construct.a.glaq030"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaq030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq030
            #add-point:ON ACTION controlp INFIELD glaq030 name="construct.c.glaq030"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq030_desc
            #add-point:BEFORE FIELD glaq030_desc name="construct.b.glaq030_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq030_desc
            
            #add-point:AFTER FIELD glaq030_desc name="construct.a.glaq030_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaq030_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq030_desc
            #add-point:ON ACTION controlp INFIELD glaq030_desc name="construct.c.glaq030_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq031
            #add-point:BEFORE FIELD glaq031 name="construct.b.glaq031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq031
            
            #add-point:AFTER FIELD glaq031 name="construct.a.glaq031"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaq031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq031
            #add-point:ON ACTION controlp INFIELD glaq031 name="construct.c.glaq031"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq031_desc
            #add-point:BEFORE FIELD glaq031_desc name="construct.b.glaq031_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq031_desc
            
            #add-point:AFTER FIELD glaq031_desc name="construct.a.glaq031_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaq031_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq031_desc
            #add-point:ON ACTION controlp INFIELD glaq031_desc name="construct.c.glaq031_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq032
            #add-point:BEFORE FIELD glaq032 name="construct.b.glaq032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq032
            
            #add-point:AFTER FIELD glaq032 name="construct.a.glaq032"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaq032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq032
            #add-point:ON ACTION controlp INFIELD glaq032 name="construct.c.glaq032"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq032_desc
            #add-point:BEFORE FIELD glaq032_desc name="construct.b.glaq032_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq032_desc
            
            #add-point:AFTER FIELD glaq032_desc name="construct.a.glaq032_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaq032_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq032_desc
            #add-point:ON ACTION controlp INFIELD glaq032_desc name="construct.c.glaq032_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq033
            #add-point:BEFORE FIELD glaq033 name="construct.b.glaq033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq033
            
            #add-point:AFTER FIELD glaq033 name="construct.a.glaq033"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaq033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq033
            #add-point:ON ACTION controlp INFIELD glaq033 name="construct.c.glaq033"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq033_desc
            #add-point:BEFORE FIELD glaq033_desc name="construct.b.glaq033_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq033_desc
            
            #add-point:AFTER FIELD glaq033_desc name="construct.a.glaq033_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaq033_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq033_desc
            #add-point:ON ACTION controlp INFIELD glaq033_desc name="construct.c.glaq033_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq034
            #add-point:BEFORE FIELD glaq034 name="construct.b.glaq034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq034
            
            #add-point:AFTER FIELD glaq034 name="construct.a.glaq034"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaq034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq034
            #add-point:ON ACTION controlp INFIELD glaq034 name="construct.c.glaq034"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq034_desc
            #add-point:BEFORE FIELD glaq034_desc name="construct.b.glaq034_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq034_desc
            
            #add-point:AFTER FIELD glaq034_desc name="construct.a.glaq034_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaq034_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq034_desc
            #add-point:ON ACTION controlp INFIELD glaq034_desc name="construct.c.glaq034_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq035
            #add-point:BEFORE FIELD glaq035 name="construct.b.glaq035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq035
            
            #add-point:AFTER FIELD glaq035 name="construct.a.glaq035"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaq035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq035
            #add-point:ON ACTION controlp INFIELD glaq035 name="construct.c.glaq035"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq035_desc
            #add-point:BEFORE FIELD glaq035_desc name="construct.b.glaq035_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq035_desc
            
            #add-point:AFTER FIELD glaq035_desc name="construct.a.glaq035_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaq035_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq035_desc
            #add-point:ON ACTION controlp INFIELD glaq035_desc name="construct.c.glaq035_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq036
            #add-point:BEFORE FIELD glaq036 name="construct.b.glaq036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq036
            
            #add-point:AFTER FIELD glaq036 name="construct.a.glaq036"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaq036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq036
            #add-point:ON ACTION controlp INFIELD glaq036 name="construct.c.glaq036"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq036_desc
            #add-point:BEFORE FIELD glaq036_desc name="construct.b.glaq036_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq036_desc
            
            #add-point:AFTER FIELD glaq036_desc name="construct.a.glaq036_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaq036_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq036_desc
            #add-point:ON ACTION controlp INFIELD glaq036_desc name="construct.c.glaq036_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq037
            #add-point:BEFORE FIELD glaq037 name="construct.b.glaq037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq037
            
            #add-point:AFTER FIELD glaq037 name="construct.a.glaq037"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaq037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq037
            #add-point:ON ACTION controlp INFIELD glaq037 name="construct.c.glaq037"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq037_desc
            #add-point:BEFORE FIELD glaq037_desc name="construct.b.glaq037_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq037_desc
            
            #add-point:AFTER FIELD glaq037_desc name="construct.a.glaq037_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaq037_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq037_desc
            #add-point:ON ACTION controlp INFIELD glaq037_desc name="construct.c.glaq037_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq038
            #add-point:BEFORE FIELD glaq038 name="construct.b.glaq038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq038
            
            #add-point:AFTER FIELD glaq038 name="construct.a.glaq038"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaq038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq038
            #add-point:ON ACTION controlp INFIELD glaq038 name="construct.c.glaq038"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq038_desc
            #add-point:BEFORE FIELD glaq038_desc name="construct.b.glaq038_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq038_desc
            
            #add-point:AFTER FIELD glaq038_desc name="construct.a.glaq038_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaq038_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq038_desc
            #add-point:ON ACTION controlp INFIELD glaq038_desc name="construct.c.glaq038_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq015
            #add-point:BEFORE FIELD glaq015 name="construct.b.glaq015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq015
            
            #add-point:AFTER FIELD glaq015 name="construct.a.glaq015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaq015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq015
            #add-point:ON ACTION controlp INFIELD glaq015 name="construct.c.glaq015"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq015_desc
            #add-point:BEFORE FIELD glaq015_desc name="construct.b.glaq015_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq015_desc
            
            #add-point:AFTER FIELD glaq015_desc name="construct.a.glaq015_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaq015_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq015_desc
            #add-point:ON ACTION controlp INFIELD glaq015_desc name="construct.c.glaq015_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq016
            #add-point:BEFORE FIELD glaq016 name="construct.b.glaq016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq016
            
            #add-point:AFTER FIELD glaq016 name="construct.a.glaq016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaq016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq016
            #add-point:ON ACTION controlp INFIELD glaq016 name="construct.c.glaq016"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq016_desc
            #add-point:BEFORE FIELD glaq016_desc name="construct.b.glaq016_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq016_desc
            
            #add-point:AFTER FIELD glaq016_desc name="construct.a.glaq016_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaq016_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq016_desc
            #add-point:ON ACTION controlp INFIELD glaq016_desc name="construct.c.glaq016_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD conf
            #add-point:BEFORE FIELD conf name="construct.b.conf"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD conf
            
            #add-point:AFTER FIELD conf name="construct.a.conf"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.conf
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD conf
            #add-point:ON ACTION controlp INFIELD conf name="construct.c.conf"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD creat
            #add-point:BEFORE FIELD creat name="construct.b.creat"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD creat
            
            #add-point:AFTER FIELD creat name="construct.a.creat"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.creat
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD creat
            #add-point:ON ACTION controlp INFIELD creat name="construct.c.creat"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON glaqseq,glaqcomp,glaq001,glaq002,lc_subject,glaq005,glaq006,glaq010, 
          glaq003,glaq004,glaq039,amt2,glaq042,amt3
           FROM s_detail1[1].glaqseq,s_detail1[1].glaqcomp,s_detail1[1].glaq001,s_detail1[1].glaq002, 
               s_detail1[1].lc_subject,s_detail1[1].glaq005,s_detail1[1].glaq006,s_detail1[1].glaq010, 
               s_detail1[1].glaq003,s_detail1[1].glaq004,s_detail1[1].glaq039,s_detail1[1].amt2,s_detail1[1].glaq042, 
               s_detail1[1].amt3
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
                                                
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaqseq
            #add-point:BEFORE FIELD glaqseq name="construct.b.page1.glaqseq"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaqseq
            
            #add-point:AFTER FIELD glaqseq name="construct.a.page1.glaqseq"
                                                
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glaqseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaqseq
            #add-point:ON ACTION controlp INFIELD glaqseq name="construct.c.page1.glaqseq"
                                                
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaqcomp
            #add-point:BEFORE FIELD glaqcomp name="construct.b.page1.glaqcomp"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaqcomp
            
            #add-point:AFTER FIELD glaqcomp name="construct.a.page1.glaqcomp"
                                                
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glaqcomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaqcomp
            #add-point:ON ACTION controlp INFIELD glaqcomp name="construct.c.page1.glaqcomp"
                                                
            #END add-point
 
 
         #Ctrlp:construct.c.page1.glaq001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq001
            #add-point:ON ACTION controlp INFIELD glaq001 name="construct.c.page1.glaq001"
                                                #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = "c"
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "( oocq004 = '",g_glaacomp,"' OR oocq004 IS NULL )" #161111-00049#4 add
            CALL q_oocq002_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaq001  #顯示到畫面上
            LET g_qryparam.where = ""
            NEXT FIELD glaq001                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq001
            #add-point:BEFORE FIELD glaq001 name="construct.b.page1.glaq001"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq001
            
            #add-point:AFTER FIELD glaq001 name="construct.a.page1.glaq001"
                                                            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glaq002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq002
            #add-point:ON ACTION controlp INFIELD glaq002 name="construct.c.page1.glaq002"
                                                            #此段落由子樣板a08產生
            #開窗c段
            
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
           #CALL q_glac()                           #呼叫開窗
            IF g_glap001_p <> '6' THEN #160517-00001#3
            LET g_qryparam.where = "glac001 = '",g_glaa004,"' AND  glac003 <>'1' AND glac006 = '1'",
                                   #151117-00009#1--add--str--
                                   " AND glac002 IN (SELECT glad001 FROM glad_t ",
                                   "                  WHERE gladent=",g_enterprise," AND gladld='",g_glapld,"'",
                                   "                    AND glad035='N' AND gladstus='Y' )"
                                   #151117-00009#1--add--end
            #160517-00001#3--add--str--
            ELSE
               LET g_qryparam.where = "glac001 = '",g_glaa004,"' AND  glac003 <>'1' AND glac006 = '1' ",
                                      " AND glac002 IN (SELECT glad001 FROM glad_t ",
                                      "                  WHERE gladent = '",g_enterprise,"' AND gladld ='",g_glapld,"'",
                                      "                    AND gladstus = 'Y' )"
            END IF
            #160517-00001#3--add--end
            CALL aglt310_04()
            DISPLAY g_qryparam.return1 TO glaq002  #顯示到畫面上
            LET g_qryparam.where = ""
            NEXT FIELD glaq002                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq002
            #add-point:BEFORE FIELD glaq002 name="construct.b.page1.glaq002"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq002
            
            #add-point:AFTER FIELD glaq002 name="construct.a.page1.glaq002"
                                                
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.lc_subject
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD lc_subject
            #add-point:ON ACTION controlp INFIELD lc_subject name="construct.c.page1.lc_subject"
                                                             #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
           #LET g_qryparam.where = "glac001 = '",g_glaa004,"' AND  glac003 <>'1' AND glac006 = '1' "  #150827-00036#7 mark
            IF g_glap001_p <> '6' THEN #160517-00001#3
            LET g_qryparam.where = "glac001 = '",g_glaa004,"' AND  glac003 <>'1' AND glac006 = '1' ",
                                   #150827-00036#7--add--str--
                                   " AND glac002 IN (SELECT glad001 FROM glad_t ",
                                   "                  WHERE gladent = '",g_enterprise,"' AND gladld ='",g_glapld,"'",
                                   "                    AND glad035 = 'N' AND gladstus = 'Y' )"  
                                   #150827-00036#7--add--end
            #160517-00001#3--add--str--
            ELSE
               LET g_qryparam.where = "glac001 = '",g_glaa004,"' AND  glac003 <>'1' AND glac006 = '1' ",
                                      " AND glac002 IN (SELECT glad001 FROM glad_t ",
                                      "                  WHERE gladent = '",g_enterprise,"' AND gladld ='",g_glapld,"'",
                                      "                    AND gladstus = 'Y' )"
            END IF
            #160517-00001#3--add--end
            CALL aglt310_04()
            DISPLAY g_qryparam.return1 TO lc_subject  #顯示到畫面上
            LET g_qryparam.where = ""
            NEXT FIELD lc_subject                    #返回原欄位

            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD lc_subject
            #add-point:BEFORE FIELD lc_subject name="construct.b.page1.lc_subject"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD lc_subject
            
            #add-point:AFTER FIELD lc_subject name="construct.a.page1.lc_subject"
                                                
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq005
            #add-point:BEFORE FIELD glaq005 name="construct.b.page1.glaq005"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq005
            
            #add-point:AFTER FIELD glaq005 name="construct.a.page1.glaq005"
                                                
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glaq005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq005
            #add-point:ON ACTION controlp INFIELD glaq005 name="construct.c.page1.glaq005"
                                                            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaq005  #顯示到畫面上

            NEXT FIELD glaq005                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq006
            #add-point:BEFORE FIELD glaq006 name="construct.b.page1.glaq006"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq006
            
            #add-point:AFTER FIELD glaq006 name="construct.a.page1.glaq006"
                                                
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glaq006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq006
            #add-point:ON ACTION controlp INFIELD glaq006 name="construct.c.page1.glaq006"
                                                
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq010
            #add-point:BEFORE FIELD glaq010 name="construct.b.page1.glaq010"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq010
            
            #add-point:AFTER FIELD glaq010 name="construct.a.page1.glaq010"
                                                
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glaq010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq010
            #add-point:ON ACTION controlp INFIELD glaq010 name="construct.c.page1.glaq010"
                                                
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq003
            #add-point:BEFORE FIELD glaq003 name="construct.b.page1.glaq003"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq003
            
            #add-point:AFTER FIELD glaq003 name="construct.a.page1.glaq003"
                                                
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glaq003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq003
            #add-point:ON ACTION controlp INFIELD glaq003 name="construct.c.page1.glaq003"
                                                
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq004
            #add-point:BEFORE FIELD glaq004 name="construct.b.page1.glaq004"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq004
            
            #add-point:AFTER FIELD glaq004 name="construct.a.page1.glaq004"
                                                
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glaq004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq004
            #add-point:ON ACTION controlp INFIELD glaq004 name="construct.c.page1.glaq004"
                                                
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq039
            #add-point:BEFORE FIELD glaq039 name="construct.b.page1.glaq039"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq039
            
            #add-point:AFTER FIELD glaq039 name="construct.a.page1.glaq039"
                                                
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glaq039
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq039
            #add-point:ON ACTION controlp INFIELD glaq039 name="construct.c.page1.glaq039"
                                                
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD amt2
            #add-point:BEFORE FIELD amt2 name="construct.b.page1.amt2"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD amt2
            
            #add-point:AFTER FIELD amt2 name="construct.a.page1.amt2"
                                                
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.amt2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD amt2
            #add-point:ON ACTION controlp INFIELD amt2 name="construct.c.page1.amt2"
                                                
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq042
            #add-point:BEFORE FIELD glaq042 name="construct.b.page1.glaq042"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq042
            
            #add-point:AFTER FIELD glaq042 name="construct.a.page1.glaq042"
                                                
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.glaq042
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq042
            #add-point:ON ACTION controlp INFIELD glaq042 name="construct.c.page1.glaq042"
                                                
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD amt3
            #add-point:BEFORE FIELD amt3 name="construct.b.page1.amt3"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD amt3
            
            #add-point:AFTER FIELD amt3 name="construct.a.page1.amt3"
                                                
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.amt3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD amt3
            #add-point:ON ACTION controlp INFIELD amt3 name="construct.c.page1.amt3"
                                                
            #END add-point
 
 
   
       
      END CONSTRUCT
      
 
      
 
      
      #add-point:cs段add_cs(本段內只能出現新的CONSTRUCT指令) name="cs.add_cs"
                              
      CONSTRUCT BY NAME g_wc_frozen ON glaq005_1,glaq006_1,glaq007,glaq008,glaq009,glaq010_1,
                                       glaq011,glaq012,glaq013,glaq014,glaq015,glaq016,
                                       glaq017,glaq018,glaq019,glaq020,glaq021,glaq022,
                                       glaq023,glaq024,glaq051,glaq052,glaq053,glaq025,
                                       glaq027,glaq028,glaq029,glaq030,glaq031,glaq032,
                                       glaq033,glaq034,glaq035,glaq036,glaq037,glaq038
        BEFORE CONSTRUCT
            CALL cl_qbe_init()
                       
        #幣別
        ON ACTION controlp INFIELD glaq005_1
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaq005_1  #顯示到畫面上

            NEXT FIELD glaq005_1                     #返回原欄位
            
         #計價單位
         ON ACTION controlp INFIELD glaq007
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaq007  #顯示到畫面上

            NEXT FIELD glaq007                    #返回原欄位 

         #申請人
         ON ACTION controlp INFIELD glaq013
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaq013  #顯示到畫面上
            NEXT FIELD glaq013                    #返回原欄位 
            
         #151223-00004#1--add--str--lujh
         #銀行賬號
         ON ACTION controlp INFIELD glaq014
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #160122-00001#34 add -str
            LET g_qryparam.where = " nmas002 IN (",g_sql_bank,")"
            #160122-00001#34 add -end
            CALL q_nmaa005()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaq014      #顯示到畫面上
            NEXT FIELD glaq014                         #返回原欄位 
            
         #款別編碼
         ON ACTION controlp INFIELD glaq015
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooia001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaq015      #顯示到畫面上
            NEXT FIELD glaq015                         #返回原欄位 
            
         #存提碼
         ON ACTION controlp INFIELD glaq016
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_nmaj001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaq016      #顯示到畫面上
            NEXT FIELD glaq016                         #返回原欄位 
         #151223-00004#1--add--str--lujh
            
         #營運據點
         
         ON ACTION controlp INFIELD glaq017
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where =" ooef201 = 'Y'" #161021-00037#3 add
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaq017  #顯示到畫面上
            NEXT FIELD glaq017                    #返回原欄位 
         #部門
          ON ACTION controlp INFIELD glaq018
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "ooegstus='Y'"
            CALL q_ooeg001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaq018  #顯示到畫面上
            NEXT FIELD glaq018                    #返回原欄位 
         #利潤/成本中心
          ON ACTION controlp INFIELD glaq019
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "ooegstus='Y' AND ooeg003 IN ('1','2','3')"
            CALL q_ooeg001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaq019      #顯示到畫面上
            NEXT FIELD glaq019                         #返回原欄位 
          #区域        
          ON ACTION controlp INFIELD glaq020
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_287()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaq020      #顯示到畫面上
            NEXT FIELD glaq020                         #返回原欄位    
          #交易客商
          ON ACTION controlp INFIELD glaq021
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
           #CALL q_pmaa001()    #160913-00017#4  mark               #呼叫開窗
          CALL q_pmaa001_25() #160913-00017#4  add 
            DISPLAY g_qryparam.return1 TO glaq021      #顯示到畫面上
            NEXT FIELD glaq021                         #返回原欄位               
           #帳款客戶
          ON ACTION controlp INFIELD glaq022
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            #CALL q_pmaa001()    #160913-00017#4  mark               #呼叫開窗
          CALL q_pmaa001_25() #160913-00017#4  add 
            DISPLAY g_qryparam.return1 TO glaq022      #顯示到畫面上
            NEXT FIELD glaq022                         #返回原欄位   
            
          #客群      
          ON ACTION controlp INFIELD glaq023
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            CALL q_oocq002_281()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaq023      #顯示到畫面上
            NEXT FIELD glaq023                         #返回原欄位  
            
           #產品類別
          ON ACTION controlp INFIELD glaq024
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            CALL q_rtax001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaq024      #顯示到畫面上
            NEXT FIELD glaq024                         #返回原欄位   
            
           #人員
          ON ACTION controlp INFIELD glaq025
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            CALL q_ooag001_8()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaq025      #顯示到畫面上
            NEXT FIELD glaq025                         #返回原欄位   
            
#         #預算編號
#          ON ACTION controlp INFIELD glaq026
#            #開窗c段
#            INITIALIZE g_qryparam.* TO NULL
#            LET g_qryparam.state = 'c'
#            LET g_qryparam.reqry = FALSE
#            CALL q_bgaa001()                           #呼叫開窗
#            DISPLAY g_qryparam.return1 TO glaq026      #顯示到畫面上
#            NEXT FIELD glaq026                         #返回原欄位  
           #渠道
          ON ACTION controlp INFIELD glaq052
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            LET g_qryparam.where = " oojdstus='Y' " 
            CALL q_oojd001_2()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaq052      #顯示到畫面上
            NEXT FIELD glaq052                         #返回原欄位 
          
          #品牌
          ON ACTION controlp INFIELD glaq053
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            CALL q_oocq002_2002()                            #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaq053      #顯示到畫面上
            NEXT FIELD glaq053                         #返回原欄位 
            
          #专案
          ON ACTION controlp INFIELD glaq027
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            CALL q_pjba001()                          #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaq027     #顯示到畫面上
            NEXT FIELD glaq027
            
          #WBS
          ON ACTION controlp INFIELD glaq028
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            LET g_qryparam.where = "pjbb012='1' "
            CALL q_pjbb002()                          #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaq028     #顯示到畫面上
            NEXT FIELD glaq028
            
         ON ACTION controlp INFIELD glaq029
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            CALL q_glaf002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaq029      #顯示到畫面上
            NEXT FIELD glaq029                         #返回原欄位  
        
        ON ACTION controlp INFIELD glaq030
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            CALL q_glaf002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaq030      #顯示到畫面上
            NEXT FIELD glaq030                         #返回原欄位
            
         ON ACTION controlp INFIELD glaq031
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            CALL q_glaf002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaq031      #顯示到畫面上
            NEXT FIELD glaq031                         #返回原欄位
            
        ON ACTION controlp INFIELD glaq032
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            CALL q_glaf002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaq032      #顯示到畫面上
            NEXT FIELD glaq032                         #返回原欄位
            
         ON ACTION controlp INFIELD glaq033
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            CALL q_glaf002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaq033      #顯示到畫面上
            NEXT FIELD glaq033                         #返回原欄位
            
        ON ACTION controlp INFIELD glaq034
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            CALL q_glaf002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaq034      #顯示到畫面上
            NEXT FIELD glaq034                         #返回原欄位
           
         ON ACTION controlp INFIELD glaq035
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            CALL q_glaf002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaq035      #顯示到畫面上
            NEXT FIELD glaq035                         #返回原欄位
            
         ON ACTION controlp INFIELD glaq036
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            CALL q_glaf002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaq036      #顯示到畫面上
            NEXT FIELD glaq036                         #返回原欄位
         
         ON ACTION controlp INFIELD glaq037
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            CALL q_glaf002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaq037      #顯示到畫面上
            NEXT FIELD glaq037                         #返回原欄位
         
         ON ACTION controlp INFIELD glaq038
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            CALL q_glaf002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaq038      #顯示到畫面上
            NEXT FIELD glaq038                         #返回原欄位
      END CONSTRUCT                                       
      
      CONSTRUCT BY NAME g_wc_glbc ON glbc004
         BEFORE CONSTRUCT
            CALL cl_qbe_init()
         #現金變動碼
         ON ACTION controlp INFIELD glbc004
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where="nmai001='",g_glaa005,"'"
            CALL q_nmai002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glbc004  #顯示到畫面上
            NEXT FIELD glbc004                     #返回原欄位
            
      END CONSTRUCT
      #end add-point
 
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:cs段b_dialog name="cs.b_dialog"
         LET g_glaq_d[1].glaqseq = ""
         DISPLAY ARRAY g_glaq_d TO s_detail1.*
            BEFORE DISPLAY
               EXIT DISPLAY
         END DISPLAY

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
                  WHEN la_wc[li_idx].tableid = "glap_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "glaq_t" 
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
               #单头条件备份
   LET g_wc1 = g_wc        
  
   #单身
   IF NOT cl_null(g_wc2) AND g_wc2 <>" 1=1" THEN
      LET g_wc2 = cl_replace_str(g_wc2,"lc_subject","glaq002")
      LET g_wc2_table1 = g_wc2
   END IF 
   
   #冻结单身
   IF NOT cl_null(g_wc_frozen) AND g_wc_frozen <>' 1=1' THEN
      LET g_wc_frozen = cl_replace_str(g_wc_frozen,"_1","")
      LET g_wc2  = g_wc2 CLIPPED,' AND ',g_wc_frozen
      LET g_wc2_table1 = g_wc2
   END IF 
   
   #現金變動碼
   IF NOT cl_null(g_wc_glbc) AND g_wc_glbc <>' 1=1' THEN
      LET g_wc2  = g_wc2 CLIPPED,
                   " AND glapdocno IN ( SELECT DISTINCT glbcdocno FROM glbc_t ",
                   "                    WHERE glbcent=",g_enterprise," AND glbcld='",g_glapld,"'",
                   "                      AND glbc010='1' AND ",g_wc_glbc,")"
   END IF
   
   #161104-00046#11-----s
   IF cl_null(g_user_dept_wc)THEN
      LET g_user_dept_wc = ' 1=1'
   END IF
   IF g_user_dept_wc <>  " 1=1" THEN
      LET g_wc = g_wc ," AND ", g_user_dept_wc CLIPPED
   END IF   
   #161104-00046#11-----e
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aglt310.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION aglt310_filter()
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
      CONSTRUCT g_wc_filter ON glapld,glap002,glap004,glapdocno,glapdocdt,glap007,glap008
                          FROM s_browse[1].b_glapld,s_browse[1].b_glap002,s_browse[1].b_glap004,s_browse[1].b_glapdocno, 
                              s_browse[1].b_glapdocdt,s_browse[1].b_glap007,s_browse[1].b_glap008
 
         BEFORE CONSTRUCT
               DISPLAY aglt310_filter_parser('glapld') TO s_browse[1].b_glapld
            DISPLAY aglt310_filter_parser('glap002') TO s_browse[1].b_glap002
            DISPLAY aglt310_filter_parser('glap004') TO s_browse[1].b_glap004
            DISPLAY aglt310_filter_parser('glapdocno') TO s_browse[1].b_glapdocno
            DISPLAY aglt310_filter_parser('glapdocdt') TO s_browse[1].b_glapdocdt
            DISPLAY aglt310_filter_parser('glap007') TO s_browse[1].b_glap007
            DISPLAY aglt310_filter_parser('glap008') TO s_browse[1].b_glap008
      
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
 
      CALL aglt310_filter_show('glapld')
   CALL aglt310_filter_show('glap002')
   CALL aglt310_filter_show('glap004')
   CALL aglt310_filter_show('glapdocno')
   CALL aglt310_filter_show('glapdocdt')
   CALL aglt310_filter_show('glap007')
   CALL aglt310_filter_show('glap008')
 
END FUNCTION
 
{</section>}
 
{<section id="aglt310.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION aglt310_filter_parser(ps_field)
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
 
{<section id="aglt310.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION aglt310_filter_show(ps_field)
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
   LET ls_condition = aglt310_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aglt310.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION aglt310_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point   
   DEFINE ls_wc STRING
   #add-point:query段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   DEFINE l_pass        LIKE type_t.num5      #160518-00075#27 add lujh       
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
   CALL g_glaq_d.clear()
 
   
   #add-point:query段other name="query.other"
   #160518-00075#27--add--str--lujh
   CALL s_ld_chk_authorization(g_user,g_glapld) RETURNING l_pass
   IF l_pass = FALSE THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'agl-00164'
      LET g_errparam.extend = g_glapld
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN         
   END IF    
   #160518-00075#27--add--end--lujh   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL aglt310_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL aglt310_browser_fill("")
      CALL aglt310_fetch("")
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
      CALL aglt310_filter_show('glapld')
   CALL aglt310_filter_show('glap002')
   CALL aglt310_filter_show('glap004')
   CALL aglt310_filter_show('glapdocno')
   CALL aglt310_filter_show('glapdocdt')
   CALL aglt310_filter_show('glap007')
   CALL aglt310_filter_show('glap008')
   CALL aglt310_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL aglt310_fetch("F") 
      #顯示單身筆數
      CALL aglt310_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aglt310.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION aglt310_fetch(p_flag)
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
   
   LET g_glap_m.glapld = g_browser[g_current_idx].b_glapld
   LET g_glap_m.glapdocno = g_browser[g_current_idx].b_glapdocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE aglt310_master_referesh USING g_glap_m.glapld,g_glap_m.glapdocno INTO g_glap_m.glapld,g_glap_m.glapcomp, 
       g_glap_m.glap001,g_glap_m.glapdocno,g_glap_m.glapdocdt,g_glap_m.glap002,g_glap_m.glap004,g_glap_m.glap007, 
       g_glap_m.glap008,g_glap_m.glap010,g_glap_m.glap011,g_glap_m.glap006,g_glap_m.glap015,g_glap_m.glap013, 
       g_glap_m.glap009,g_glap_m.glap016,g_glap_m.glap017,g_glap_m.glap012,g_glap_m.glap014,g_glap_m.glapstus, 
       g_glap_m.glapownid,g_glap_m.glapcrtdp,g_glap_m.glapowndp,g_glap_m.glapcrtdt,g_glap_m.glapcrtid, 
       g_glap_m.glapmodid,g_glap_m.glapmoddt,g_glap_m.glapcnfid,g_glap_m.glapcnfdt,g_glap_m.glappstid, 
       g_glap_m.glappstdt,g_glap_m.glapld_desc,g_glap_m.glapcomp_desc,g_glap_m.glap016_desc,g_glap_m.glapownid_desc, 
       g_glap_m.glapcrtdp_desc,g_glap_m.glapowndp_desc,g_glap_m.glapcrtid_desc,g_glap_m.glapmodid_desc, 
       g_glap_m.glapcnfid_desc,g_glap_m.glappstid_desc
   
   #遮罩相關處理
   LET g_glap_m_mask_o.* =  g_glap_m.*
   CALL aglt310_glap_t_mask()
   LET g_glap_m_mask_n.* =  g_glap_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aglt310_set_act_visible()   
   CALL aglt310_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   #160308-00010#25-S
   IF g_glap_m.glapstus NOT MATCHES '[NDR]' THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF
   #160308-00010#25-E            
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   CALL aglt310_frozen_clear(0)
   #end add-point
   
   #保存單頭舊值
   LET g_glap_m_t.* = g_glap_m.*
   LET g_glap_m_o.* = g_glap_m.*
   
   LET g_data_owner = g_glap_m.glapownid      
   LET g_data_dept  = g_glap_m.glapowndp
   
   #重新顯示   
   CALL aglt310_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="aglt310.insert" >}
#+ 資料新增
PRIVATE FUNCTION aglt310_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
               DEFINE l_cnt           LIKE type_t.num5
   DEFINE l_pass          LIKE type_t.num5
   DEFINE l_flag          LIKE type_t.chr1
   DEFINE l_errno         LIKE type_t.chr100
   DEFINE l_glav002       LIKE glav_t.glav002
   DEFINE l_glav005       LIKE glav_t.glav005
   DEFINE l_sdate_s       LIKE glav_t.glav004
   DEFINE l_sdate_e       LIKE glav_t.glav004
   DEFINE l_glav006       LIKE glav_t.glav006
   DEFINE l_pdate_s       LIKE glav_t.glav004
   DEFINE l_pdate_e       LIKE glav_t.glav004
   DEFINE l_glav007       LIKE glav_t.glav007
   DEFINE l_wdate_s       LIKE glav_t.glav004
   DEFINE l_wdate_e       LIKE glav_t.glav004
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_glaq_d.clear()   
 
 
   INITIALIZE g_glap_m.* TO NULL             #DEFAULT 設定
   
   LET g_glapld_t = NULL
   LET g_glapdocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   CALL cl_set_comp_visible("grid_20",FALSE) #160805-00022#1 add
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_glap_m.glapownid = g_user
      LET g_glap_m.glapowndp = g_dept
      LET g_glap_m.glapcrtid = g_user
      LET g_glap_m.glapcrtdp = g_dept 
      LET g_glap_m.glapcrtdt = cl_get_current()
      LET g_glap_m.glapmodid = g_user
      LET g_glap_m.glapmoddt = cl_get_current()
      LET g_glap_m.glapstus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_glap_m.glap010 = "0"
      LET g_glap_m.glap011 = "0"
      LET g_glap_m.glap013 = "0"
      LET g_glap_m.glap014 = "N"
      LET g_glap_m.glapstus = "N"
      LET g_glap_m.glaq008 = "0"
      LET g_glap_m.glaq009 = "0"
 
  
      #add-point:單頭預設值 name="insert.default"
      CALL cl_set_comp_visible("glaq005,glaq006,glaq010",FALSE)
      INITIALIZE g_glap_m_t.* LIKE glap_t.*             #DEFAULT 設定
      CALL s_ld_chk_authorization(g_user,g_glapld) RETURNING l_pass
      IF l_pass = FALSE THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'agl-00164'
         LET g_errparam.extend = g_glapld
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN         
      END IF
      LET g_glap_m.glapld = g_glapld              #账别
      CALL aglt310_glapld_desc(g_glap_m.glapld)   #帐别说明
      LET g_glap_m.glaa001_desc = g_glaa001       #使用币别
      DISPLAY BY NAME g_glap_m.glapld,g_glap_m.glapld_desc,g_glap_m.glapcomp,g_glap_m.glapcomp_desc,
                      g_glap_m.glaa001_desc,g_glap_m.glaa016,g_glap_m.glaa020      
      LET g_glap_m.glap001 = g_glap001_p   #账款性质
      IF g_glap001_p = '1' THEN
         LET g_glap_m.glap007 = 'GL'          #来源码
      END IF  
      IF g_glap001_p = '2' THEN
         LET g_glap_m.glap007 = 'CR'          #来源码
      END IF    
       IF g_glap001_p = '3' THEN
         LET g_glap_m.glap007 = 'CD'          #来源码
      END IF    
      IF g_glap001_p = '4' THEN
         LET g_glap_m.glap007 = 'RV'          #来源码
      END IF 
      IF g_glap001_p = '5' THEN
         LET g_glap_m.glap007 = 'AC'          #来源码
      END IF 
      IF g_glap001_p = '6' THEN
         LET g_glap_m.glap007 = 'AD'          #来源码
      END IF                
      LET g_glap_m.glap010 = 0             #借方总金额
      LET g_glap_m.glap011 = 0             #贷方总金额
      LET g_glap_m.glapstus = 'N'          #状态码
      LET g_glap_m.glapdocdt = g_today     #传票日期
      LET g_glap_m.glap012 = 0             #打印次数 #2015/9/18 add
      #抓取年度期别
#      SELECT oogc015,oogc006 INTO g_glap_m.glap002,g_glap_m.glap004 FROM oogc_t
#       WHERE oogcent = g_enterprise
#         AND oogc001 = g_ooef008
#         AND oogc002 = g_ooef010
#         AND oogc003 = g_glap_m.glapdocdt
       CALL s_get_accdate(g_glaa003,g_glap_m.glapdocdt,'','')
       RETURNING l_flag,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
                 l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e
       LET g_glap_m.glap002 = l_glav002
       LET g_glap_m.glap004 = l_glav006
       
      CALL cl_set_comp_entry('glapdocdt',TRUE)
      #初始化图片
      CALL gfrm_curr.setElementImage("statechange", "stus/32/open.png") 

      #160509-00004#59--add--str--
      #人员、部门说明
      LET g_glap_m.glapownid_desc = s_desc_get_person_desc(g_glap_m.glapownid)
      LET g_glap_m.glapowndp_desc = s_desc_get_department_desc(g_glap_m.glapowndp)
      LET g_glap_m.glapcrtid_desc = g_glap_m.glapownid_desc
      LET g_glap_m.glapcrtdp_desc = g_glap_m.glapowndp_desc 
      LET g_glap_m.glapmodid_desc = g_glap_m.glapownid_desc
      LET g_glap_m.creat = g_glap_m.glapownid_desc
      #160509-00004#59--add--end
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_glap_m_t.* = g_glap_m.*
      LET g_glap_m_o.* = g_glap_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_glap_m.glapstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "S"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/posted.png")
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
 
 
 
    
      CALL aglt310_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      #运行aglt340,单身填充后，如果是单头没有insert,点了取消后,删除单身
      IF INT_FLAG THEN
         IF g_glap001_p = '4' THEN
            SELECT COUNT(1) INTO l_cnt FROM glap_t #161205-00025#4 mod '*'-->1
             WHERE glapent = g_enterprise
               AND glapld = g_glap_m.glapld
               AND glapdocno = g_glap_m.glapdocno
            IF l_cnt = 0 THEN    
               DELETE FROM glaq_t WHERE glaqent = g_enterprise
                                    AND glaqld = g_glap_m.glapld
                                    AND glaqdocno = g_glap_m.glapdocno
               #删除现金变动码
               DELETE FROM glbc_t
               WHERE glbcent=g_enterprise AND glbcld=g_glap_m.glapld AND glbcdocno=g_glap_m.glapdocno AND glbc010='1'
            END IF                        
         END IF                       
      END IF 
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
         INITIALIZE g_glap_m.* TO NULL
         INITIALIZE g_glaq_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL aglt310_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_glaq_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aglt310_set_act_visible()   
   CALL aglt310_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_glapld_t = g_glap_m.glapld
   LET g_glapdocno_t = g_glap_m.glapdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " glapent = " ||g_enterprise|| " AND",
                      " glapld = '", g_glap_m.glapld, "' "
                      ," AND glapdocno = '", g_glap_m.glapdocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aglt310_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE aglt310_cl
   
   CALL aglt310_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE aglt310_master_referesh USING g_glap_m.glapld,g_glap_m.glapdocno INTO g_glap_m.glapld,g_glap_m.glapcomp, 
       g_glap_m.glap001,g_glap_m.glapdocno,g_glap_m.glapdocdt,g_glap_m.glap002,g_glap_m.glap004,g_glap_m.glap007, 
       g_glap_m.glap008,g_glap_m.glap010,g_glap_m.glap011,g_glap_m.glap006,g_glap_m.glap015,g_glap_m.glap013, 
       g_glap_m.glap009,g_glap_m.glap016,g_glap_m.glap017,g_glap_m.glap012,g_glap_m.glap014,g_glap_m.glapstus, 
       g_glap_m.glapownid,g_glap_m.glapcrtdp,g_glap_m.glapowndp,g_glap_m.glapcrtdt,g_glap_m.glapcrtid, 
       g_glap_m.glapmodid,g_glap_m.glapmoddt,g_glap_m.glapcnfid,g_glap_m.glapcnfdt,g_glap_m.glappstid, 
       g_glap_m.glappstdt,g_glap_m.glapld_desc,g_glap_m.glapcomp_desc,g_glap_m.glap016_desc,g_glap_m.glapownid_desc, 
       g_glap_m.glapcrtdp_desc,g_glap_m.glapowndp_desc,g_glap_m.glapcrtid_desc,g_glap_m.glapmodid_desc, 
       g_glap_m.glapcnfid_desc,g_glap_m.glappstid_desc
   
   
   #遮罩相關處理
   LET g_glap_m_mask_o.* =  g_glap_m.*
   CALL aglt310_glap_t_mask()
   LET g_glap_m_mask_n.* =  g_glap_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_glap_m.glapld,g_glap_m.glapld_desc,g_glap_m.glapcomp,g_glap_m.glapcomp_desc,g_glap_m.glaa001_desc, 
       g_glap_m.glaa016,g_glap_m.glaa020,g_glap_m.glap001,g_glap_m.glapdocno,g_glap_m.glapdocdt,g_glap_m.glap002, 
       g_glap_m.glap004,g_glap_m.glap007,g_glap_m.glap008,g_glap_m.glap010,g_glap_m.glap011,g_glap_m.glap006, 
       g_glap_m.glap006_desc,g_glap_m.glap015,g_glap_m.glap013,g_glap_m.glap009,g_glap_m.sdocno,g_glap_m.glap016, 
       g_glap_m.glap016_desc,g_glap_m.glap017,g_glap_m.glap012,g_glap_m.glap014,g_glap_m.glapstus,g_glap_m.glapownid, 
       g_glap_m.glapownid_desc,g_glap_m.glapcrtdp,g_glap_m.glapcrtdp_desc,g_glap_m.glapowndp,g_glap_m.glapowndp_desc, 
       g_glap_m.glapcrtdt,g_glap_m.glapcrtid,g_glap_m.glapcrtid_desc,g_glap_m.glapmodid,g_glap_m.glapmodid_desc, 
       g_glap_m.glapmoddt,g_glap_m.glapcnfid,g_glap_m.glapcnfid_desc,g_glap_m.glapcnfdt,g_glap_m.glappstid, 
       g_glap_m.glappstid_desc,g_glap_m.glappstdt,g_glap_m.glaq017,g_glap_m.glaq017_desc,g_glap_m.glaq018, 
       g_glap_m.glaq018_desc,g_glap_m.glaq019,g_glap_m.glaq019_desc,g_glap_m.glaq020,g_glap_m.glaq020_desc, 
       g_glap_m.glaq021,g_glap_m.glaq021_desc,g_glap_m.glaq022,g_glap_m.glaq022_desc,g_glap_m.glaq023, 
       g_glap_m.glaq023_desc,g_glap_m.glaq024,g_glap_m.glaq024_desc,g_glap_m.glbc004,g_glap_m.glbc004_desc, 
       g_glap_m.glaq051,g_glap_m.glaq052,g_glap_m.glaq052_desc,g_glap_m.glaq053,g_glap_m.glaq053_desc, 
       g_glap_m.glaq025,g_glap_m.glaq025_desc,g_glap_m.glaq027,g_glap_m.glaq027_desc,g_glap_m.glaq028, 
       g_glap_m.glaq028_desc,g_glap_m.glaq029,g_glap_m.glaq029_desc,g_glap_m.glaq030,g_glap_m.glaq030_desc, 
       g_glap_m.glaq031,g_glap_m.glaq031_desc,g_glap_m.glaq032,g_glap_m.glaq032_desc,g_glap_m.glaq033, 
       g_glap_m.glaq033_desc,g_glap_m.glaq034,g_glap_m.glaq034_desc,g_glap_m.glaq035,g_glap_m.glaq035_desc, 
       g_glap_m.glaq036,g_glap_m.glaq036_desc,g_glap_m.glaq037,g_glap_m.glaq037_desc,g_glap_m.glaq038, 
       g_glap_m.glaq038_desc,g_glap_m.glaq005_1,g_glap_m.glaq006_1,g_glap_m.glaq010_1,g_glap_m.glaq007, 
       g_glap_m.glaq008,g_glap_m.glaq009,g_glap_m.glaq011,g_glap_m.glaq012,g_glap_m.glaq013,g_glap_m.glaq013_desc, 
       g_glap_m.glaq014,g_glap_m.glaq015,g_glap_m.glaq015_desc,g_glap_m.glaq016,g_glap_m.glaq016_desc, 
       g_glap_m.conf,g_glap_m.post,g_glap_m.creat
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_glap_m.glapownid      
   LET g_data_dept  = g_glap_m.glapowndp
   
   #功能已完成,通報訊息中心
   CALL aglt310_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="aglt310.modify" >}
#+ 資料修改
PRIVATE FUNCTION aglt310_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point    
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   DEFINE l_wc2_table1          STRING
 
 
   #add-point:modify段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   DEFINE l_pass      LIKE type_t.num5
   DEFINE l_success   LIKE type_t.num5
   #end add-point    
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   #保存單頭舊值
   LET g_glap_m_t.* = g_glap_m.*
   LET g_glap_m_o.* = g_glap_m.*
   
   IF g_glap_m.glapld IS NULL
   OR g_glap_m.glapdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_glapld_t = g_glap_m.glapld
   LET g_glapdocno_t = g_glap_m.glapdocno
 
   CALL s_transaction_begin()
   
   OPEN aglt310_cl USING g_enterprise,g_glap_m.glapld,g_glap_m.glapdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aglt310_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE aglt310_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aglt310_master_referesh USING g_glap_m.glapld,g_glap_m.glapdocno INTO g_glap_m.glapld,g_glap_m.glapcomp, 
       g_glap_m.glap001,g_glap_m.glapdocno,g_glap_m.glapdocdt,g_glap_m.glap002,g_glap_m.glap004,g_glap_m.glap007, 
       g_glap_m.glap008,g_glap_m.glap010,g_glap_m.glap011,g_glap_m.glap006,g_glap_m.glap015,g_glap_m.glap013, 
       g_glap_m.glap009,g_glap_m.glap016,g_glap_m.glap017,g_glap_m.glap012,g_glap_m.glap014,g_glap_m.glapstus, 
       g_glap_m.glapownid,g_glap_m.glapcrtdp,g_glap_m.glapowndp,g_glap_m.glapcrtdt,g_glap_m.glapcrtid, 
       g_glap_m.glapmodid,g_glap_m.glapmoddt,g_glap_m.glapcnfid,g_glap_m.glapcnfdt,g_glap_m.glappstid, 
       g_glap_m.glappstdt,g_glap_m.glapld_desc,g_glap_m.glapcomp_desc,g_glap_m.glap016_desc,g_glap_m.glapownid_desc, 
       g_glap_m.glapcrtdp_desc,g_glap_m.glapowndp_desc,g_glap_m.glapcrtid_desc,g_glap_m.glapmodid_desc, 
       g_glap_m.glapcnfid_desc,g_glap_m.glappstid_desc
   
   #檢查是否允許此動作
   IF NOT aglt310_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_glap_m_mask_o.* =  g_glap_m.*
   CALL aglt310_glap_t_mask()
   LET g_glap_m_mask_n.* =  g_glap_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
 
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
 
   
   CALL aglt310_show()
   #add-point:modify段show之後 name="modify.after_show"
   #160308-00010#25-S
   #IF g_glap_m.glapstus <> 'N' THEN          
   #   INITIALIZE g_errparam TO NULL
   #   LET g_errparam.code = 'agl-00313'
   #   LET g_errparam.extend = g_glap_m.glapld
   #   LET g_errparam.popup = TRUE
   #   CALL cl_err()
   #   CLOSE aglt310_cl
   #   CALL s_transaction_end('N','0')
   #   RETURN
   #END IF
   #160308-00010#25-E
   IF g_glap001_p <> '6' THEN   #151204-00001#1 add
      #檢查當單據日期小於等於關帳日期時，不可異動單據
      CALL s_fin_date_close_chk(g_glap_m.glapld,'','AGL',g_glap_m.glapdocdt) RETURNING l_success
      IF l_success = FALSE THEN
         CLOSE aglt310_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
   END IF  #151204-00001#1 add
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
 
    
   WHILE TRUE
      LET g_glapld_t = g_glap_m.glapld
      LET g_glapdocno_t = g_glap_m.glapdocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_glap_m.glapmodid = g_user 
LET g_glap_m.glapmoddt = cl_get_current()
LET g_glap_m.glapmodid_desc = cl_get_username(g_glap_m.glapmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      #160308-00010#25-S
      IF g_glap_m.glapstus MATCHES '[DR]' THEN 
         LET g_glap_m.glapstus = "N"
      END IF
      #160308-00010#25-E
      
      CALL s_ld_chk_authorization(g_user,g_glap_m.glapld) RETURNING l_pass
      IF l_pass = FALSE THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'agl-00164'
         LET g_errparam.extend = g_glap_m.glapld
         LET g_errparam.popup = TRUE
         CALL cl_err()
         CLOSE aglt310_cl
         CALL s_transaction_end('N','0')
         RETURN         
      END IF
      
      IF (g_glap001_p = '1' AND g_glap_m.glap007 <> 'GL' ) OR
         (g_glap001_p = '1' AND g_glap_m.glap007 <> 'ZT' ) OR #160805-00022#1 add 账套复制传票
         (g_glap001_p = '1' AND g_glap_m.glap007 = 'GL' AND g_glap_m.glap008 = 'TH') OR
         (g_glap001_p = '2' AND g_glap_m.glap007 <> 'CR' ) OR
         (g_glap001_p = '3' AND g_glap_m.glap007 <> 'CD' ) OR
         (g_glap001_p = '4' AND g_glap_m.glap007 <> 'RV' ) OR
         (g_glap001_p = '5' AND g_glap_m.glap007 <> 'AC' ) OR
         (g_glap001_p = '6' AND g_glap_m.glap007 <> 'AD' ) THEN
         #160415-00025#1--mod--str--
#         CALL cl_set_comp_entry("glapdocdt,glap014,lc_subject,glaq005,glaq006,glaq010,glaq003,
#                                    glaq004,glaq039,amt2,glaq042,amt3",FALSE)
         CALL cl_set_comp_entry("glapdocdt,glap014,lc_subject,glaq005,glaq006,glaq010,glaq003,glaq004,glaq039,amt2,glaq042,amt3",FALSE)
         #160415-00025#1--mod--end
      ELSE
         #160415-00025#1--mod--str--
#         CALL cl_set_comp_entry("glapdocdt,glap014,lc_subject,glaq005,glaq006,glaq010,glaq003,
#                                    glaq004,glaq039,amt2,glaq042,amt3",TRUE)
         CALL cl_set_comp_entry("glapdocdt,glap014,lc_subject,glaq005,glaq006,glaq010,glaq003,glaq004,glaq039,amt2,glaq042,amt3",TRUE)
         #160415-00025#1--mod--end
      END IF
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL aglt310_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
                                    
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE glap_t SET (glapmodid,glapmoddt) = (g_glap_m.glapmodid,g_glap_m.glapmoddt)
          WHERE glapent = g_enterprise AND glapld = g_glapld_t
            AND glapdocno = g_glapdocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_glap_m.* = g_glap_m_t.*
            CALL aglt310_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_glap_m.glapld != g_glap_m_t.glapld
      OR g_glap_m.glapdocno != g_glap_m_t.glapdocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
                                    
         #end add-point
         
         #更新單身key值
         UPDATE glaq_t SET glaqld = g_glap_m.glapld
                                       ,glaqdocno = g_glap_m.glapdocno
 
          WHERE glaqent = g_enterprise AND glaqld = g_glap_m_t.glapld
            AND glaqdocno = g_glap_m_t.glapdocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
                                    
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "glaq_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "glaq_t:",SQLERRMESSAGE 
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
   CALL aglt310_set_act_visible()   
   CALL aglt310_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " glapent = " ||g_enterprise|| " AND",
                      " glapld = '", g_glap_m.glapld, "' "
                      ," AND glapdocno = '", g_glap_m.glapdocno, "' "
 
   #填到對應位置
   CALL aglt310_browser_fill("")
 
   CLOSE aglt310_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aglt310_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="aglt310.input" >}
#+ 資料輸入
PRIVATE FUNCTION aglt310_input(p_cmd)
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
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_glac008       LIKE glac_t.glac008     #科目余额形态
   DEFINE l_glaq002_desc  LIKE glacl_t.glacl004   #科目名称
   DEFINE l_glaq002       STRING                  #整合科目显示相关资料
   DEFINE l_sum1          LIKE glap_t.glap010
   DEFINE l_sum2          LIKE glap_t.glap011
   DEFINE l_sum3          LIKE glap_t.glap010
   DEFINE l_sum4          LIKE glap_t.glap011
   DEFINE l_glaq003_bak   LIKE glaq_t.glaq003
   DEFINE l_glaq004_bak   LIKE glaq_t.glaq004
   DEFINE l_pass          LIKE type_t.num5
   DEFINE l_glaq017       LIKE glaq_t.glaq017
   DEFINE l_glad003       LIKE glad_t.glad003
   DEFINE l_glad004       LIKE glad_t.glad004
   DEFINE l_flag          LIKE type_t.num5  #標示是否細項沖帳
   DEFINE l_flag1         LIKE type_t.chr1
   DEFINE l_errno         LIKE type_t.chr100
   DEFINE l_glav002       LIKE glav_t.glav002
   DEFINE l_glav005       LIKE glav_t.glav005
   DEFINE l_sdate_s       LIKE glav_t.glav004
   DEFINE l_sdate_e       LIKE glav_t.glav004
   DEFINE l_glav006       LIKE glav_t.glav006
   DEFINE l_pdate_s       LIKE glav_t.glav004
   DEFINE l_pdate_e       LIKE glav_t.glav004
   DEFINE l_glav007       LIKE glav_t.glav007
   DEFINE l_wdate_s       LIKE glav_t.glav004
   DEFINE l_wdate_e       LIKE glav_t.glav004
   DEFINE l_amt1          LIKE glaq_t.glaq003
   DEFINE l_amt2          LIKE glaq_t.glaq003
   DEFINE l_amt3          LIKE glaq_t.glaq003
   DEFINE l_amt4          LIKE glaq_t.glaq003
   DEFINE l_sum5          LIKE glaq_t.glaq043
   DEFINE l_sum6          LIKE glaq_t.glaq044
   DEFINE l_red           LIKE type_t.chr10
   DEFINE l_slip          STRING
   DEFINE l_str           STRING
   DEFINE l_glac016       LIKE glac_t.glac016
   DEFINE l_glaq039       LIKE glaq_t.glaq039
   DEFINE l_glaq042       LIKE glaq_t.glaq042
   DEFINE l_sql           STRING
   DEFINE l_glac002       LIKE type_t.chr500
   DEFINE l_glbc004       LIKE glbc_t.glbc004
   DEFINE l_glad034       LIKE glad_t.glad034
   DEFINE l_errcode       STRING
   DEFINE l_glapdocno     LIKE glap_t.glapdocno
   DEFINE l_glaa100       LIKE glaa_t.glaa100
   DEFINE l_glaa024       LIKE glaa_t.glaa024
   DEFINE l_flag2         LIKE type_t.chr1
   DEFINE ls_js           STRING
   DEFINE l_glaa004       LIKE glaa_t.glaa004  #150916-00015#1 -add
   DEFINE l_flag3         LIKE type_t.num5     #161104-00046#11 單別預設值用
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
   DISPLAY BY NAME g_glap_m.glapld,g_glap_m.glapld_desc,g_glap_m.glapcomp,g_glap_m.glapcomp_desc,g_glap_m.glaa001_desc, 
       g_glap_m.glaa016,g_glap_m.glaa020,g_glap_m.glap001,g_glap_m.glapdocno,g_glap_m.glapdocdt,g_glap_m.glap002, 
       g_glap_m.glap004,g_glap_m.glap007,g_glap_m.glap008,g_glap_m.glap010,g_glap_m.glap011,g_glap_m.glap006, 
       g_glap_m.glap006_desc,g_glap_m.glap015,g_glap_m.glap013,g_glap_m.glap009,g_glap_m.sdocno,g_glap_m.glap016, 
       g_glap_m.glap016_desc,g_glap_m.glap017,g_glap_m.glap012,g_glap_m.glap014,g_glap_m.glapstus,g_glap_m.glapownid, 
       g_glap_m.glapownid_desc,g_glap_m.glapcrtdp,g_glap_m.glapcrtdp_desc,g_glap_m.glapowndp,g_glap_m.glapowndp_desc, 
       g_glap_m.glapcrtdt,g_glap_m.glapcrtid,g_glap_m.glapcrtid_desc,g_glap_m.glapmodid,g_glap_m.glapmodid_desc, 
       g_glap_m.glapmoddt,g_glap_m.glapcnfid,g_glap_m.glapcnfid_desc,g_glap_m.glapcnfdt,g_glap_m.glappstid, 
       g_glap_m.glappstid_desc,g_glap_m.glappstdt,g_glap_m.glaq017,g_glap_m.glaq017_desc,g_glap_m.glaq018, 
       g_glap_m.glaq018_desc,g_glap_m.glaq019,g_glap_m.glaq019_desc,g_glap_m.glaq020,g_glap_m.glaq020_desc, 
       g_glap_m.glaq021,g_glap_m.glaq021_desc,g_glap_m.glaq022,g_glap_m.glaq022_desc,g_glap_m.glaq023, 
       g_glap_m.glaq023_desc,g_glap_m.glaq024,g_glap_m.glaq024_desc,g_glap_m.glbc004,g_glap_m.glbc004_desc, 
       g_glap_m.glaq051,g_glap_m.glaq052,g_glap_m.glaq052_desc,g_glap_m.glaq053,g_glap_m.glaq053_desc, 
       g_glap_m.glaq025,g_glap_m.glaq025_desc,g_glap_m.glaq027,g_glap_m.glaq027_desc,g_glap_m.glaq028, 
       g_glap_m.glaq028_desc,g_glap_m.glaq029,g_glap_m.glaq029_desc,g_glap_m.glaq030,g_glap_m.glaq030_desc, 
       g_glap_m.glaq031,g_glap_m.glaq031_desc,g_glap_m.glaq032,g_glap_m.glaq032_desc,g_glap_m.glaq033, 
       g_glap_m.glaq033_desc,g_glap_m.glaq034,g_glap_m.glaq034_desc,g_glap_m.glaq035,g_glap_m.glaq035_desc, 
       g_glap_m.glaq036,g_glap_m.glaq036_desc,g_glap_m.glaq037,g_glap_m.glaq037_desc,g_glap_m.glaq038, 
       g_glap_m.glaq038_desc,g_glap_m.glaq005_1,g_glap_m.glaq006_1,g_glap_m.glaq010_1,g_glap_m.glaq007, 
       g_glap_m.glaq008,g_glap_m.glaq009,g_glap_m.glaq011,g_glap_m.glaq012,g_glap_m.glaq013,g_glap_m.glaq013_desc, 
       g_glap_m.glaq014,g_glap_m.glaq015,g_glap_m.glaq015_desc,g_glap_m.glaq016,g_glap_m.glaq016_desc, 
       g_glap_m.conf,g_glap_m.post,g_glap_m.creat
   
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
   LET g_forupd_sql = "SELECT glaqseq,glaqcomp,glaq001,glaq002,glaq005,glaq006,glaq010,glaq003,glaq004, 
       glaq039,glaq040,glaq041,glaq042,glaq043,glaq044 FROM glaq_t WHERE glaqent=? AND glaqld=? AND  
       glaqdocno=? AND glaqseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
            
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aglt310_bcl CURSOR FROM g_forupd_sql
   
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
  #150827-00036#11 Add  ---(S)---
   LET l_sql = " SELECT docno FROM s_fin_tmp_conti_no WHERE isuse = 'N' ORDER BY docno"
   PREPARE continue_no_pb1 FROM l_sql
   DECLARE continue_no_cs1 CURSOR WITH HOLD FOR continue_no_pb1

   LET l_sql = " SELECT docno FROM s_fin_tmp_conti_no WHERE sel = 'Y' ORDER BY docno"
   PREPARE continue_no_pb2 FROM l_sql
   DECLARE continue_no_cs2 CURSOR WITH HOLD FOR continue_no_pb2
  #150827-00036#11 Add  ---(E)---

   IF l_cmd_t ='r' THEN
      IF g_glap001_p = '1' THEN
         LET g_glap_m.glap007 = 'GL'          #来源码
      END IF  
      IF g_glap001_p = '2' THEN
         LET g_glap_m.glap007 = 'CR'          #来源码
      END IF    
       IF g_glap001_p = '3' THEN
         LET g_glap_m.glap007 = 'CD'          #来源码
      END IF    
      IF g_glap001_p = '4' THEN
         LET g_glap_m.glap007 = 'RV'          #来源码
      END IF 
      IF g_glap001_p = '5' THEN
         LET g_glap_m.glap007 = 'AC'          #来源码
      END IF 
      IF g_glap001_p = '6' THEN
         LET g_glap_m.glap007 = 'AD'          #来源码
      END IF
      LET g_glap_m.glap008 = ''
   END IF         
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL aglt310_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
               
   #end add-point
   CALL aglt310_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_glap_m.glapld,g_glap_m.glap001,g_glap_m.glapdocno,g_glap_m.glapdocdt,g_glap_m.glap002, 
       g_glap_m.glap004,g_glap_m.glap007,g_glap_m.glap008,g_glap_m.glap010,g_glap_m.glap011,g_glap_m.glap006, 
       g_glap_m.glap015,g_glap_m.glap013,g_glap_m.glap009,g_glap_m.sdocno,g_glap_m.glap016,g_glap_m.glap017, 
       g_glap_m.glap012,g_glap_m.glap014,g_glap_m.glapstus
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
               #===========================================================
   #回传传票单身不可以新增，不可以删除 
   LET l_allow_insert =''
   LET l_allow_delete = ''
   #當為以下傳票时，才允许单身新增删除
   IF (g_glap_m.glap007 = 'GL' AND (g_glap_m.glap008 <> 'TH' OR cl_null(g_glap_m.glap008))) 
      OR g_glap_m.glap007 = 'ZT'  #160805-00022#1 add 账套复制传票  
      OR g_glap_m.glap007 = 'CR'  OR g_glap_m.glap007 = 'CD'  
      OR g_glap_m.glap007 = 'AC'  OR g_glap_m.glap007 = 'AD'  THEN
      LET l_allow_insert = cl_auth_detail_input("insert")
      LET l_allow_delete = cl_auth_detail_input("delete")
   END IF
   #===========================================================
   DISPLAY BY NAME g_glap_m.glapld_desc,g_glap_m.glapcomp_desc
   CALL cl_set_comp_entry("glapld,glapcomp,glaa001_desc,glap002,glap004,glapstus,glap007,glap009,glap012",FALSE)
   #复制时，状态给N 
   IF l_cmd_t = 'r' THEN
      LET g_glap_m.glapstus = "N"         
   END IF
   LET l_flag=TRUE 
   LET l_errcode=''
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="aglt310.input.head" >}
      #單頭段
      INPUT BY NAME g_glap_m.glapld,g_glap_m.glap001,g_glap_m.glapdocno,g_glap_m.glapdocdt,g_glap_m.glap002, 
          g_glap_m.glap004,g_glap_m.glap007,g_glap_m.glap008,g_glap_m.glap010,g_glap_m.glap011,g_glap_m.glap006, 
          g_glap_m.glap015,g_glap_m.glap013,g_glap_m.glap009,g_glap_m.sdocno,g_glap_m.glap016,g_glap_m.glap017, 
          g_glap_m.glap012,g_glap_m.glap014,g_glap_m.glapstus 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION cont_no
            LET g_action_choice="cont_no"
            IF cl_auth_chk_act("cont_no") THEN
               
               #add-point:ON ACTION cont_no name="input.master_input.cont_no"
              #150827-00036#11 Add  ---(S)---
               IF cl_null(g_glap_m.glapld)  THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aap-00332'
                  LET g_errparam.extend = s_fin_get_colname('','glapld')
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CONTINUE DIALOG
               END IF
               IF cl_null(g_glap_m.glapdocno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aap-00332'
                  LET g_errparam.extend = s_fin_get_colname('','glapdocno')
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CONTINUE DIALOG
               END IF
               IF cl_null(g_glap_m.glapdocdt) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aap-00331'
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CONTINUE DIALOG
               END IF

               CALL s_fin_continue_no_input(g_glap_m.glapld,'',g_glap_m.glapdocno,g_glap_m.glapdocdt,'3')

               LET l_glapdocno = ''
               FOREACH continue_no_cs2 INTO l_glapdocno
                  LET l_cnt = 0
                  #檢查是否號碼已被使用
                  SELECT COUNT(1) INTO l_cnt #161205-00025#4 mod 'count(*)'-->'COUNT(1)'
                    FROM glap_t
                   WHERE glapent = g_enterprise AND glapld = g_glap_m.glapld
                    AND glapdocno=l_glapdocno
                  IF l_cnt = 0 THEN
                     EXIT FOREACH
                  ELSE
                     LET l_glapdocno = ''
                  END IF
               END FOREACH
               IF NOT cl_null(l_glapdocno) THEN
                  LET g_glap_m.glapdocno = l_glapdocno
                  DISPLAY BY NAME g_glap_m.glapdocno
               END IF
              #150827-00036#11 Add  ---(E)---
               #END add-point
            END IF
 
 
 
 
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN aglt310_cl USING g_enterprise,g_glap_m.glapld,g_glap_m.glapdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aglt310_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aglt310_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL aglt310_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            
            IF g_glap001_p='2' OR g_glap001_p='3' THEN 
               #核算项
               INITIALIZE g_glaq_s.* TO NULL
               IF p_cmd = 'u' THEN
                  SELECT glaq017,glaq018,glaq019,glaq020,glaq021,glaq022,
                         glaq023,glaq024,glaq051,glaq052,glaq053,glaq025,glaq027,glaq028,
                         glaq029,glaq030,glaq031,glaq032,glaq033,glaq034,glaq035,glaq036,glaq037,glaq038
                    INTO g_glaq_s.glaq017,g_glaq_s.glaq018,g_glaq_s.glaq019,g_glaq_s.glaq020,g_glaq_s.glaq021,
                         g_glaq_s.glaq022,g_glaq_s.glaq023,g_glaq_s.glaq024,g_glaq_s.glaq051,g_glaq_s.glaq052,
                         g_glaq_s.glaq053,g_glaq_s.glaq025,g_glaq_s.glaq027,g_glaq_s.glaq028,g_glaq_s.glaq029,
                         g_glaq_s.glaq030,g_glaq_s.glaq031,g_glaq_s.glaq032,g_glaq_s.glaq033,g_glaq_s.glaq034,
                         g_glaq_s.glaq035,g_glaq_s.glaq036,g_glaq_s.glaq037,g_glaq_s.glaq038
                    FROM glaq_t
                   WHERE glaqent = g_enterprise
                     AND glaqld = g_glap_m.glapld
                     AND glaqdocno = g_glap_m.glapdocno
                     AND glaqseq = g_glaq_d[l_ac].glaqseq
                  #現金變動碼
                  LET g_glaq_s.glbc004=''
                  LET l_cnt=0
                  SELECT COUNT(1) INTO l_cnt FROM glbc_t #161205-00025#4 mod '*'-->1
                   WHERE glbcent=g_enterprise AND glbcld = g_glap_m.glapld
                     AND glbcdocno = g_glap_m.glapdocno
                     AND glbcseq = g_glaq_d[l_ac].glaqseq
                     AND glbc001 = g_glap_m.glap002 
                     AND glbc002 = g_glap_m.glap004
                  IF l_cnt=1 THEN
                     SELECT glbc004 INTO g_glaq_s.glbc004 FROM glbc_t
                      WHERE glbcent = g_enterprise AND glbcld = g_glap_m.glapld
                        AND glbcdocno = g_glap_m.glapdocno
                        AND glbcseq = g_glaq_d[l_ac].glaqseq
                        AND glbc001 = g_glap_m.glap002 
                        AND glbc002 = g_glap_m.glap004
                  ELSE
                     LET g_glaq_s.glbc004=' '
                  END IF
               END IF
            END IF

           #150827-00036#11 Add  ---(S)---
            SELECT glaa100 INTO l_glaa100 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_glap_m.glapld

             IF l_glaa100 = 'Y' THEN
               CALL cl_set_comp_visible('cont_no',FALSE)
             ELSE
               CALL cl_set_comp_visible('cont_no',TRUE)
             END IF  
           #150827-00036#11 Add  ---(E)---
            #end add-point
            CALL aglt310_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glapld
            
            #add-point:AFTER FIELD glapld name="input.a.glapld"
                                                            

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glapld
            #add-point:BEFORE FIELD glapld name="input.b.glapld"
                                                
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glapld
            #add-point:ON CHANGE glapld name="input.g.glapld"
                                                
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glap001
            #add-point:BEFORE FIELD glap001 name="input.b.glap001"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glap001
            
            #add-point:AFTER FIELD glap001 name="input.a.glap001"
                                                
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glap001
            #add-point:ON CHANGE glap001 name="input.g.glap001"
                                                
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glapdocno
            #add-point:BEFORE FIELD glapdocno name="input.b.glapdocno"
                                                           
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glapdocno
            
            #add-point:AFTER FIELD glapdocno name="input.a.glapdocno"
            IF NOT cl_null(g_glap_m.glapdocno) THEN
               IF  NOT cl_null(g_glap_m.glapld) AND NOT cl_null(g_glap_m.glapdocno) THEN 
                   IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_glap_m.glapld != g_glap_m_t.glapld  OR g_glap_m.glapdocno != g_glap_m_t.glapdocno )) THEN 
                      IF NOT ap_chk_notDup(g_glap_m.glapdocno,"SELECT COUNT(1) FROM glap_t WHERE "||"glapent = '" ||g_enterprise|| "' AND "||"glapld = '"||g_glap_m.glapld ||"' AND "|| "glapdocno = '"||g_glap_m.glapdocno ||"'",'std-00004',0) THEN  #161205-00025#4 mod '*'-->1
                         LET g_glap_m.glapdocno = ''
                         NEXT FIELD CURRENT
                      END IF
                   END IF
                END IF
#               CALL aglt310_glapdocno_chk(g_glap_m.glapdocno)
#               IF NOT cl_null(g_errno) THEN
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = g_errno
#                  LET g_errparam.extend = g_glap_m.glapdocno
#                  LET g_errparam.popup = TRUE
#                  CALL cl_err()
#
#                  LET g_glap_m.glapdocno = ''
#                  NEXT FIELD glapdocno
               CALL s_aooi200_fin_chk_docno(g_glap_m.glapld,'','',g_glap_m.glapdocno,g_glap_m.glapdocdt,g_prog)
               RETURNING l_success
               IF NOT l_success THEN
                  LET g_glap_m.glapdocno = ''
                  NEXT FIELD CURRENT
               ELSE
                  #获取收支科目
                  IF g_glap001_p MATCHES'[23]' THEN
                     IF p_cmd = 'a' THEN
                        CALL s_fin_get_doc_para(g_glap_m.glapld,g_glap_m.glapcomp,g_glap_m.glapdocno,'D-FIN-1003') 
                        RETURNING g_glap_m.glap006
                        CALL aglt310_glap006_desc(g_glap_m.glap006) RETURNING g_glap_m.glap006_desc
                        DISPLAY BY NAME g_glap_m.glap006,g_glap_m.glap006_desc
                     END IF   
                  END IF    
               END IF
               #161104-00046#11-----s
               CALL s_control_chk_doc('1',g_glap_m.glapdocno,'4',g_user,g_dept,'','') RETURNING g_sub_success,l_flag3
               IF g_sub_success AND l_flag3 THEN             
               ELSE
                  LET g_glap_m.glapdocno = g_glap_m_o.glapdocno 
                  NEXT FIELD CURRENT                  
               END IF
               CALL s_aooi200_fin_get_slip(g_glap_m.glapdocno) RETURNING g_sub_success,l_slip
               #刪除單別預設temptable
               DELETE FROM s_aooi200def1
               #以目前畫面資訊新增temp資料   #請勿調整.*
               INSERT INTO s_aooi200def1 VALUES(g_glap_m.*)
               #依單別預設取用資訊
               CALL s_aooi200def_get('','',g_glap_m.glapcomp,'2',l_slip,'','',g_glap_m.glapld)
               #依單別預設值TEMP內容 給予到畫面上   #請勿調整.*
               SELECT * INTO g_glap_m.* FROM s_aooi200def1
               #161104-00046#11-----e  
            END IF
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glapdocno
            #add-point:ON CHANGE glapdocno name="input.g.glapdocno"
                                                
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glapdocdt
            #add-point:BEFORE FIELD glapdocdt name="input.b.glapdocdt"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glapdocdt
            
            #add-point:AFTER FIELD glapdocdt name="input.a.glapdocdt"
            IF NOT cl_null(g_glap_m.glapdocdt) THEN
               IF g_glap001_p <> '6' THEN   #151204-00001#1 add 排除aglt410日期檢核
               IF g_glap_m.glapdocdt <= g_glaa013 THEN   
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00160'
                  LET g_errparam.extend = g_glap_m.glapdocdt
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_glap_m.glapdocdt = ''
                  LET g_glap_m.glap002 = ''
                  LET g_glap_m.glap004 = ''
                  DISPLAY BY NAME g_glap_m.glap002,g_glap_m.glap004
                  NEXT FIELD glapdocdt
               END IF 
               END IF  #151204-00001#1 add 
               #抓取年度期别
#               SELECT oogc015,oogc006 INTO g_glap_m.glap002,g_glap_m.glap004 FROM oogc_t
#                WHERE oogcent = g_enterprise
#                  AND oogc001 = g_ooef008
#                  AND oogc002 = g_ooef010
#                  AND oogc003 = g_glap_m.glapdocdt
               CALL s_get_accdate(g_glaa003,g_glap_m.glapdocdt,'','')
               RETURNING l_flag1,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
                         l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e
               LET g_glap_m.glap002 = l_glav002
               LET g_glap_m.glap004 = l_glav006
               IF l_flag1='N' THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  NEXT FIELD glapdocdt
               END IF
               
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glapdocdt
            #add-point:ON CHANGE glapdocdt name="input.g.glapdocdt"
                                                
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glap002
            #add-point:BEFORE FIELD glap002 name="input.b.glap002"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glap002
            
            #add-point:AFTER FIELD glap002 name="input.a.glap002"
                                                
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glap002
            #add-point:ON CHANGE glap002 name="input.g.glap002"
                                                
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glap004
            #add-point:BEFORE FIELD glap004 name="input.b.glap004"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glap004
            
            #add-point:AFTER FIELD glap004 name="input.a.glap004"
                                                
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glap004
            #add-point:ON CHANGE glap004 name="input.g.glap004"
                                                
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glap007
            #add-point:BEFORE FIELD glap007 name="input.b.glap007"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glap007
            
            #add-point:AFTER FIELD glap007 name="input.a.glap007"
                                                
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glap007
            #add-point:ON CHANGE glap007 name="input.g.glap007"
                                                
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glap008
            #add-point:BEFORE FIELD glap008 name="input.b.glap008"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glap008
            
            #add-point:AFTER FIELD glap008 name="input.a.glap008"
                                                
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glap008
            #add-point:ON CHANGE glap008 name="input.g.glap008"
                                                
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glap010
            #add-point:BEFORE FIELD glap010 name="input.b.glap010"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glap010
            
            #add-point:AFTER FIELD glap010 name="input.a.glap010"
                                                
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glap010
            #add-point:ON CHANGE glap010 name="input.g.glap010"
                                                
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glap011
            #add-point:BEFORE FIELD glap011 name="input.b.glap011"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glap011
            
            #add-point:AFTER FIELD glap011 name="input.a.glap011"
                                                
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glap011
            #add-point:ON CHANGE glap011 name="input.g.glap011"
                                                
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glap006
            
            #add-point:AFTER FIELD glap006 name="input.a.glap006"
            DISPLAY '' TO glap006_desc
            IF NOT cl_null(g_glap_m.glap006) THEN
               #151117-00009#1--add--str--
               #科目存在性，有效性，非统治科目，账户科目属性检查
               CALL s_voucher_glaq002_chk(g_glap_m.glapld,g_glap_m.glap006)
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_glap_m.glap006
                  #160321-00016#30 --s add
                  LET g_errparam.replace[1] = 'agli030'
                  LET g_errparam.replace[2] = cl_get_progname('agli030',g_lang,"2")
                  LET g_errparam.exeprog = 'agli030'
                  #160321-00016#30 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_glap_m.glap006 = g_glap_m_t.glap006
                  CALL aglt310_glap006_desc(g_glap_m.glap006) RETURNING g_glap_m.glap006_desc
                  DISPLAY BY NAME g_glap_m.glap006_desc
                  NEXT FIELD glap006                  
               END IF
               #151117-00009#1--add--end
               #科目为非子系统科目
               CALL aglt310_glap006_chk(g_glap_m.glap006)
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_glap_m.glap006
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_glap_m.glap006 = g_glap_m_t.glap006
                  CALL aglt310_glap006_desc(g_glap_m.glap006) RETURNING g_glap_m.glap006_desc
                  DISPLAY BY NAME g_glap_m.glap006_desc
                  NEXT FIELD glap006                  
               END IF
               #150814-00006#3--add--str--
               #用于判断现金变动码要取的借贷方向
               LET l_flag2=''
               #借方
               IF g_glap001_p = '2' THEN
                  LET l_flag2='d'
               END IF
               #贷方
               IF g_glap001_p = '3' THEN
                  LET l_flag2='c'
               END IF
               #150814-00006#3--add--end
               #150814-00006#3 add ''-->l_flag2
               CALL aglt310_02(l_flag2,g_glap_m.glapld,'',g_glap_m.glapdocdt,g_glap_m.glap006,'','aglt310',g_glaq_s.*) 
               RETURNING g_glaq_s.glaq017,g_glaq_s.glaq018,g_glaq_s.glaq019,g_glaq_s.glaq020,g_glaq_s.glaq021,g_glaq_s.glaq022,
                         g_glaq_s.glaq023,g_glaq_s.glaq024,g_glaq_s.glaq051,g_glaq_s.glaq052,g_glaq_s.glaq053,g_glaq_s.glaq025,
                         g_glaq_s.glaq027,g_glaq_s.glaq028,g_glaq_s.glaq029,g_glaq_s.glaq030,g_glaq_s.glaq031,g_glaq_s.glaq032,
                         g_glaq_s.glaq033,g_glaq_s.glaq034,g_glaq_s.glaq035,g_glaq_s.glaq036,g_glaq_s.glaq037,g_glaq_s.glaq038,
                         g_glaq_s.glbc004
            END IF 
            CALL aglt310_glap006_desc(g_glap_m.glap006) RETURNING g_glap_m.glap006_desc
            DISPLAY BY NAME g_glap_m.glap006_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glap006
            #add-point:BEFORE FIELD glap006 name="input.b.glap006"
                                                
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glap006
            #add-point:ON CHANGE glap006 name="input.g.glap006"
                                                
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glap015
            #add-point:BEFORE FIELD glap015 name="input.b.glap015"
            #修改状态时，原传票编号不为空，如果单身存在资料则不可修改
            CALL aglt310_set_no_entry(p_cmd)
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glap015
            
            #add-point:AFTER FIELD glap015 name="input.a.glap015"
            IF NOT cl_null(g_glap_m.glap015) THEN
               CALL aglt310_glap015_chk(g_glap_m.glap015)
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_glap_m.glap015
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD glap015
               END IF 
               #如果已经回传则不可再次回传
               SELECT COUNT(1) INTO l_count FROM glap_t #161205-00025#4 mod 'count(*)'-->'COUNT(1)'
                WHERE glapent = g_enterprise
                  AND glapld = g_glap_m.glapld
                  AND glap015 = g_glap_m.glap015
                  AND glapstus <> 'X' #160705-00033#1 add
               IF l_count >0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00031'
                  LET g_errparam.extend = g_glap_m.glap015
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_glap_m.glap015 = ''
                  NEXT FIELD glap015
               END IF 
#               #新增到单身             
#               CALL aglt310_glap015_ins() RETURNING l_success
#               IF l_success = FALSE THEN
#                  NEXT FIELD glap015
#               ELSE
#                  SELECT SUM(glaq003),SUM(glaq004) INTO g_glap_m.glap010,g_glap_m.glap011 
#                    FROM glaq_t
#                   WHERE glaqent = g_enterprise
#                     AND glaqld = g_glap_m.glapld
#                     AND glaqdocno = g_glap_m.glapdocno                     
#               END IF
#               CALL aglt310_b_fill() 
                              
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glap015
            #add-point:ON CHANGE glap015 name="input.g.glap015"
                                                
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glap013
            #add-point:BEFORE FIELD glap013 name="input.b.glap013"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glap013
            
            #add-point:AFTER FIELD glap013 name="input.a.glap013"
                                                            IF NOT cl_null(g_glap_m.glap013) THEN
               IF g_glap_m.glap013 < 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aim-00009'
                  LET g_errparam.extend = g_glap_m.glap013
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  IF NOT cl_null(g_glap_m_t.glap013) THEN
                     LET g_glap_m.glap013 = g_glap_m_t.glap013
                  ELSE
                      LET g_glap_m.glap013 = 0                 
                  END IF 
               END IF  
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glap013
            #add-point:ON CHANGE glap013 name="input.g.glap013"
                                                
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glap009
            #add-point:BEFORE FIELD glap009 name="input.b.glap009"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glap009
            
            #add-point:AFTER FIELD glap009 name="input.a.glap009"
                                                
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glap009
            #add-point:ON CHANGE glap009 name="input.g.glap009"
                                                
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sdocno
            #add-point:BEFORE FIELD sdocno name="input.b.sdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sdocno
            
            #add-point:AFTER FIELD sdocno name="input.a.sdocno"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sdocno
            #add-point:ON CHANGE sdocno name="input.g.sdocno"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glap016
            
            #add-point:AFTER FIELD glap016 name="input.a.glap016"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_glap_m.glap016
            CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_glap_m.glap016_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_glap_m.glap016_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glap016
            #add-point:BEFORE FIELD glap016 name="input.b.glap016"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glap016
            #add-point:ON CHANGE glap016 name="input.g.glap016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glap017
            #add-point:BEFORE FIELD glap017 name="input.b.glap017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glap017
            
            #add-point:AFTER FIELD glap017 name="input.a.glap017"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glap017
            #add-point:ON CHANGE glap017 name="input.g.glap017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glap012
            #add-point:BEFORE FIELD glap012 name="input.b.glap012"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glap012
            
            #add-point:AFTER FIELD glap012 name="input.a.glap012"
                                                
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glap012
            #add-point:ON CHANGE glap012 name="input.g.glap012"
                                                
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glap014
            #add-point:BEFORE FIELD glap014 name="input.b.glap014"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glap014
            
            #add-point:AFTER FIELD glap014 name="input.a.glap014"
                                                
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glap014
            #add-point:ON CHANGE glap014 name="input.g.glap014"
            IF g_glap_m.glap014 = 'Y' THEN
               CALL cl_set_comp_visible('glaq005,glaq006,glaq010',TRUE)
               #运行aglt340时，单身除摘要外，均不可维护
               IF g_glap001_p = '4' THEN
                  CALL cl_set_comp_entry('glaq005,glaq006,glaq010',FALSE)
               END IF 
            ELSE
               CALL cl_set_comp_visible('glaq005,glaq006,glaq010',FALSE)
            END IF
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glapstus
            #add-point:BEFORE FIELD glapstus name="input.b.glapstus"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glapstus
            
            #add-point:AFTER FIELD glapstus name="input.a.glapstus"
                                                
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glapstus
            #add-point:ON CHANGE glapstus name="input.g.glapstus"
                                                
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.glapld
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glapld
            #add-point:ON ACTION controlp INFIELD glapld name="input.c.glapld"
                                                
            #END add-point
 
 
         #Ctrlp:input.c.glap001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glap001
            #add-point:ON ACTION controlp INFIELD glap001 name="input.c.glap001"
                                                
            #END add-point
 
 
         #Ctrlp:input.c.glapdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glapdocno
            #add-point:ON ACTION controlp INFIELD glapdocno name="input.c.glapdocno"
                                                #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glap_m.glapdocno             #給予default值

            #給予arg
#            LET g_qryparam.where = "ooba001 = '",g_ooef004,"' AND oobx002 = 'AGL' AND oobx003 = '",g_oobx003,"' "
#            CALL q_ooba002_4()                                #呼叫開窗
            
            LET g_qryparam.arg1 = g_glaa024
            LET g_qryparam.arg2 = g_oobx003
            #161104-00046#11-----s
            IF NOT cl_null(g_user_slip_wc)THEN
               LET g_qryparam.where = g_user_slip_wc
            END IF
            #161104-00046#11-----e
            CALL q_ooba002_1()
            
            LET g_glap_m.glapdocno = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_glap_m.glapdocno TO glapdocno              #顯示到畫面上
            LET g_qryparam.where = ""
            NEXT FIELD glapdocno                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.glapdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glapdocdt
            #add-point:ON ACTION controlp INFIELD glapdocdt name="input.c.glapdocdt"
                                                
            #END add-point
 
 
         #Ctrlp:input.c.glap002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glap002
            #add-point:ON ACTION controlp INFIELD glap002 name="input.c.glap002"
                                                
            #END add-point
 
 
         #Ctrlp:input.c.glap004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glap004
            #add-point:ON ACTION controlp INFIELD glap004 name="input.c.glap004"
                                                
            #END add-point
 
 
         #Ctrlp:input.c.glap007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glap007
            #add-point:ON ACTION controlp INFIELD glap007 name="input.c.glap007"
                                                
            #END add-point
 
 
         #Ctrlp:input.c.glap008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glap008
            #add-point:ON ACTION controlp INFIELD glap008 name="input.c.glap008"
                                                
            #END add-point
 
 
         #Ctrlp:input.c.glap010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glap010
            #add-point:ON ACTION controlp INFIELD glap010 name="input.c.glap010"
                                                
            #END add-point
 
 
         #Ctrlp:input.c.glap011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glap011
            #add-point:ON ACTION controlp INFIELD glap011 name="input.c.glap011"
                                                
            #END add-point
 
 
         #Ctrlp:input.c.glap006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glap006
            #add-point:ON ACTION controlp INFIELD glap006 name="input.c.glap006"
                                                #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glap_m.glap006             #給予default值

            #給予arg
            LET g_qryparam.where = "glac001 = '",g_glaa004,"' AND  glac003 <>'1' AND glac006 = '1'",
                                   #151117-00009#1--add--str--
                                   " AND glac002 IN (SELECT glad001 FROM glad_t ",
                                   "                  WHERE gladent=",g_enterprise," AND gladld='",g_glap_m.glapld,"'",
                                   "                    AND glad035='N' AND gladstus='Y' )"
                                   #151117-00009#1--add--end
            CALL aglt310_04()                                #呼叫開窗

            LET g_glap_m.glap006 = g_qryparam.return1              #將開窗取得的值回傳到變數
            CALL aglt310_glap006_desc(g_glap_m.glap006) RETURNING  g_glap_m.glap006_desc
            DISPLAY g_glap_m.glap006_desc TO glap006_desc
            DISPLAY g_glap_m.glap006 TO glap006              #顯示到畫面上
            LET g_qryparam.where = ""
            NEXT FIELD glap006                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.glap015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glap015
            #add-point:ON ACTION controlp INFIELD glap015 name="input.c.glap015"
                                                #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'
            LET g_qryparam.default1 = g_glap_m.glap015             #給予default值

            #給予arg 
            LET g_qryparam.where = "glapld = '",g_glapld,"'"   #账套
            CALL q_glapdocno()                                #呼叫開窗
            LET g_qryparam.where =""
            LET g_glap_m.glap015 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_glap_m.glap015 TO glap015              #顯示到畫面上

            NEXT FIELD glap015                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.glap013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glap013
            #add-point:ON ACTION controlp INFIELD glap013 name="input.c.glap013"
                                                
            #END add-point
 
 
         #Ctrlp:input.c.glap009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glap009
            #add-point:ON ACTION controlp INFIELD glap009 name="input.c.glap009"
                                                
            #END add-point
 
 
         #Ctrlp:input.c.sdocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sdocno
            #add-point:ON ACTION controlp INFIELD sdocno name="input.c.sdocno"
            
            #END add-point
 
 
         #Ctrlp:input.c.glap016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glap016
            #add-point:ON ACTION controlp INFIELD glap016 name="input.c.glap016"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_glap_m.glap016             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_user #s  #160805-00022#1 add
            LET g_qryparam.arg2 = g_dept #s  #160805-00022#1 add
             
            CALL q_authorised_ld()                                #呼叫開窗
 
            LET g_glap_m.glap016 = g_qryparam.return1              

            DISPLAY g_glap_m.glap016 TO glap016              #

            NEXT FIELD glap016                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.glap017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glap017
            #add-point:ON ACTION controlp INFIELD glap017 name="input.c.glap017"
            
            #END add-point
 
 
         #Ctrlp:input.c.glap012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glap012
            #add-point:ON ACTION controlp INFIELD glap012 name="input.c.glap012"
                                                
            #END add-point
 
 
         #Ctrlp:input.c.glap014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glap014
            #add-point:ON ACTION controlp INFIELD glap014 name="input.c.glap014"
                                                
            #END add-point
 
 
         #Ctrlp:input.c.glapstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glapstus
            #add-point:ON ACTION controlp INFIELD glapstus name="input.c.glapstus"
                                                
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_glap_m.glapld,g_glap_m.glapdocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
              ##150827-00036#11 Mod  ---(S)---
               SELECT glaa024,glaa100 INTO l_glaa024,l_glaa100 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_glap_m.glapld
               IF l_glaa100 = 'Y' THEN
                  LET l_str = g_glap_m.glapdocno   #160519-00029#1
                  IF l_str.getlength() <> cl_get_para(g_enterprise,'','E-COM-0005') THEN  #160519-00029#1
                     DELETE FROM s_fin_tmp_conti_no
                     CALL s_fin_continue_no_ins(g_glap_m.glapld,l_glaa024,g_glap_m.glapdocno,g_glap_m.glapdocdt,'3') RETURNING g_sub_success,g_errno
                  END IF    #160519-00029#1
               END IF

               SELECT COUNT(1) INTO l_cnt FROM s_fin_tmp_conti_no WHERE isuse = 'N' #161205-00025#4 mod 'count(*)'-->'COUNT(1)'
               IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF

               IF l_cnt > 0 THEN
                  FOREACH continue_no_cs1 INTO l_glapdocno
                     UPDATE s_fin_tmp_conti_no
                        SET isuse = 'Y'
                      WHERE docno = l_glapdocno
                     #檢查是否號碼已被使用
                     SELECT COUNT(1) INTO l_cnt #161205-00025#4 mod 'count(*)'-->'COUNT(1)'
                       FROM glap_t
                      WHERE glapent = g_enterprise AND glapld = g_glap_m.glapld
                       AND glapdocno=l_glapdocno
                     IF l_cnt = 0 THEN
                        EXIT FOREACH
                     END IF
                  END FOREACH
                  #假設整個單號都已被取用還是透過s_aooi200_fin_gen_docno取單號
                  IF l_cnt > 0 THEN
                     CALL s_aooi200_fin_gen_docno(g_glap_m.glapld,g_glaa024,g_glaa003,g_glap_m.glapdocno,g_glap_m.glapdocdt,  g_prog)
                     RETURNING l_success,g_glap_m.glapdocno
                  ELSE
                     LET g_glap_m.glapdocno = l_glapdocno
                  END IF
               ELSE
                  CALL s_aooi200_fin_gen_docno(g_glap_m.glapld,g_glaa024,g_glaa003,g_glap_m.glapdocno,g_glap_m.glapdocdt,  g_prog)
                  RETURNING l_success,g_glap_m.glapdocno
               END IF

              #CALL s_aooi200_fin_gen_docno(g_glap_m.glapld,g_glaa024,g_glaa003,g_glap_m.glapdocno,g_glap_m.glapdocdt,  g_prog)
              #RETURNING l_success,g_glap_m.glapdocno
              ##150827-00036#11 Mod  ---(E)---

               CALL s_aooi200_fin_gen_docno(g_glap_m.glapld,g_glaa024,g_glaa003,g_glap_m.glapdocno,g_glap_m.glapdocdt,  g_prog)
               RETURNING l_success,g_glap_m.glapdocno
               #160830-00011#1   2016/09/01 By 07900 --mark--s--
#               IF l_success  = FALSE  THEN
#                  RETURN
#               END IF  
               #160830-00011#1   2016/09/01 By 07900 --mark--e--
              #160830-00011#1   2016/09/01 By 07900 --add--s-- 
               IF l_success  = FALSE  THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apm-00003'
                  LET g_errparam.extend = g_glap_m.glapdocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()                
                  NEXT FIELD glapdocno
               END IF
               #160830-00011#1   2016/09/01 By 07900 --add--e-- 
               CALL cl_set_comp_entry('glapdocno,glapdocdt',FALSE)               
               DISPLAY BY NAME g_glap_m.glapdocno   
               IF g_glap001_p = '4' THEN
                  #新增到单身             
                  CALL aglt310_glap015_ins() RETURNING l_success
                  IF l_success = FALSE THEN
                     NEXT FIELD glap015
                  ELSE
                     SELECT SUM(glaq003),SUM(glaq004) INTO g_glap_m.glap010,g_glap_m.glap011 
                       FROM glaq_t
                      WHERE glaqent = g_enterprise
                        AND glaqld = g_glap_m.glapld
                        AND glaqdocno = g_glap_m.glapdocno                     
                  END IF
               END IF
               #end add-point
               
               INSERT INTO glap_t (glapent,glapld,glapcomp,glap001,glapdocno,glapdocdt,glap002,glap004, 
                   glap007,glap008,glap010,glap011,glap006,glap015,glap013,glap009,glap016,glap017,glap012, 
                   glap014,glapstus,glapownid,glapcrtdp,glapowndp,glapcrtdt,glapcrtid,glapmodid,glapmoddt, 
                   glapcnfid,glapcnfdt,glappstid,glappstdt)
               VALUES (g_enterprise,g_glap_m.glapld,g_glap_m.glapcomp,g_glap_m.glap001,g_glap_m.glapdocno, 
                   g_glap_m.glapdocdt,g_glap_m.glap002,g_glap_m.glap004,g_glap_m.glap007,g_glap_m.glap008, 
                   g_glap_m.glap010,g_glap_m.glap011,g_glap_m.glap006,g_glap_m.glap015,g_glap_m.glap013, 
                   g_glap_m.glap009,g_glap_m.glap016,g_glap_m.glap017,g_glap_m.glap012,g_glap_m.glap014, 
                   g_glap_m.glapstus,g_glap_m.glapownid,g_glap_m.glapcrtdp,g_glap_m.glapowndp,g_glap_m.glapcrtdt, 
                   g_glap_m.glapcrtid,g_glap_m.glapmodid,g_glap_m.glapmoddt,g_glap_m.glapcnfid,g_glap_m.glapcnfdt, 
                   g_glap_m.glappstid,g_glap_m.glappstdt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_glap_m:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭新增中 name="input.head.m_insert"
               IF g_glap001_p <> '4' THEN
                  #当新增时清空该凭证下的所以现金变动码资料
                  DELETE FROM glbc_t
                   WHERE glbcent = g_enterprise AND glbc010 = '1'
                     AND glbcld = g_glap_m.glapld AND glbcdocno = g_glap_m.glapdocno 
               END IF   
               IF g_glap001_p = '4' THEN
                  CALL aglt310_b_fill()
               END IF               
               #end add-point
               
               
               
               
               #add-point:單頭新增後 name="input.head.a_insert"
                                                            
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL aglt310_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL aglt310_b_fill()
                  CALL aglt310_b_fill2('0')
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
               CALL aglt310_glap_t_mask_restore('restore_mask_o')
               
               UPDATE glap_t SET (glapld,glapcomp,glap001,glapdocno,glapdocdt,glap002,glap004,glap007, 
                   glap008,glap010,glap011,glap006,glap015,glap013,glap009,glap016,glap017,glap012,glap014, 
                   glapstus,glapownid,glapcrtdp,glapowndp,glapcrtdt,glapcrtid,glapmodid,glapmoddt,glapcnfid, 
                   glapcnfdt,glappstid,glappstdt) = (g_glap_m.glapld,g_glap_m.glapcomp,g_glap_m.glap001, 
                   g_glap_m.glapdocno,g_glap_m.glapdocdt,g_glap_m.glap002,g_glap_m.glap004,g_glap_m.glap007, 
                   g_glap_m.glap008,g_glap_m.glap010,g_glap_m.glap011,g_glap_m.glap006,g_glap_m.glap015, 
                   g_glap_m.glap013,g_glap_m.glap009,g_glap_m.glap016,g_glap_m.glap017,g_glap_m.glap012, 
                   g_glap_m.glap014,g_glap_m.glapstus,g_glap_m.glapownid,g_glap_m.glapcrtdp,g_glap_m.glapowndp, 
                   g_glap_m.glapcrtdt,g_glap_m.glapcrtid,g_glap_m.glapmodid,g_glap_m.glapmoddt,g_glap_m.glapcnfid, 
                   g_glap_m.glapcnfdt,g_glap_m.glappstid,g_glap_m.glappstdt)
                WHERE glapent = g_enterprise AND glapld = g_glapld_t
                  AND glapdocno = g_glapdocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "glap_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               #修改状态时，当外币凭证从Y变成N时同步更新单子币别资料
               IF g_glap_m.glap014 <> g_glap_m_t.glap014 AND g_glap_m.glap014 THEN
                  IF g_glaa015='Y' THEN
                     #日汇率
                     IF g_glaa028 = '1' THEN #160918-00006#2 add
                     CALL s_aooi160_get_exrate('2',g_glap_m.glapld,g_glap_m.glapdocdt,g_glaa001,g_glaa016,0,g_glaa018)
                     RETURNING  l_glaq039
                     #160918-00006#2--add--str--
                     ELSE
                        #月汇率
                        CALL s_aooi160_get_exrate_avg('2',g_glap_m.glapld,g_glap_m.glapdocdt,g_glaa001,g_glaa016,0,g_glaa018)
                        RETURNING l_success,g_errno,l_glaq039
                     END IF
                     #160918-00006#2--add--end
                  END IF
                  IF g_glaa019='Y' THEN
                     #日汇率
                     IF g_glaa028 = '1' THEN #160918-00006#2 add
                     CALL s_aooi160_get_exrate('2',g_glap_m.glapld,g_glap_m.glapdocdt,g_glaa001,g_glaa020,0,g_glaa022) 
                     RETURNING  l_glaq042
                     #160918-00006#2--add--str--
                     ELSE
                        #月汇率
                        CALL s_aooi160_get_exrate_avg('2',g_glap_m.glapld,g_glap_m.glapdocdt,g_glaa001,g_glaa020,0,g_glaa022) 
                        RETURNING l_success,g_errno,l_glaq042
                     END IF
                     #160918-00006#2--add--end
                  END IF
                  #更新原币、汇率、本位币二汇率、本位币三汇率
                  UPDATE glaq_t SET glaq005 = g_glaa001,
                                    glaq006 = 1,
                                    glaq039 = l_glaq039,
                                    glaq042 = l_glaq042
                  WHERE glaqent=g_enterprise AND glaqld=g_glap_m.glapld AND glaqdocno=g_glap_m.glapdocno
                  #更新原币金额、本位币二、本位币三金额
                  UPDATE glaq_t SET glaq010 = glaq003,
                                    glaq040 = l_glaq039 * glaq003,
                                    glaq043 = l_glaq042 * glaq010
                  WHERE glaqent=g_enterprise AND glaqld=g_glap_m.glapld 
                    AND glaqdocno=g_glap_m.glapdocno AND glaq003<>0
                  UPDATE glaq_t SET glaq010 = glaq004,
                                    glaq041 = l_glaq039 * glaq004,
                                    glaq044 = l_glaq042 * glaq004
                  WHERE glaqent=g_enterprise AND glaqld=g_glap_m.glapld 
                    AND glaqdocno=g_glap_m.glapdocno AND glaq004<>0
               END IF
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL aglt310_glap_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_glap_m_t)
               LET g_log2 = util.JSON.stringify(g_glap_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
                                                            
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_glapld_t = g_glap_m.glapld
            LET g_glapdocno_t = g_glap_m.glapdocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="aglt310.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_glaq_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION bus_cons
            LET g_action_choice="bus_cons"
            IF cl_auth_chk_act("bus_cons") THEN
               
               #add-point:ON ACTION bus_cons name="input.detail_input.page1.bus_cons"
               CALL aglt310_bus_cons()
               #END add-point
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION fix_acc
            LET g_action_choice="fix_acc"
            IF cl_auth_chk_act("fix_acc") THEN
               
               #add-point:ON ACTION fix_acc name="input.detail_input.page1.fix_acc"
               CALL aglt310_fix_acc()
               #END add-point
            END IF
 
 
 
 
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_glaq_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aglt310_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_glaq_d.getLength()
            #add-point:資料輸入前 name="input.d.before_input"
            CALL s_aooi200_fin_get_slip(g_glap_m.glapdocno) RETURNING l_success,l_slip
            IF l_success = FALSE THEN
               RETURN
            ELSE
               #獲取單據別對應參數：紅字傳票否
               CALL s_fin_get_doc_para(g_glap_m.glapld,g_glap_m.glapcomp,l_slip,'D-FIN-1002') RETURNING l_red  
            END IF 
            LET g_flag_input = TRUE #标示在input录入状态            
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
            OPEN aglt310_cl USING g_enterprise,g_glap_m.glapld,g_glap_m.glapdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aglt310_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aglt310_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_glaq_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_glaq_d[l_ac].glaqseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_glaq_d_t.* = g_glaq_d[l_ac].*  #BACKUP
               LET g_glaq_d_o.* = g_glaq_d[l_ac].*  #BACKUP
               CALL aglt310_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
                                                            
               #end add-point  
               CALL aglt310_set_no_entry_b(l_cmd)
               IF NOT aglt310_lock_b("glaq_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aglt310_bcl INTO g_glaq_d[l_ac].glaqseq,g_glaq_d[l_ac].glaqcomp,g_glaq_d[l_ac].glaq001, 
                      g_glaq_d[l_ac].glaq002,g_glaq_d[l_ac].glaq005,g_glaq_d[l_ac].glaq006,g_glaq_d[l_ac].glaq010, 
                      g_glaq_d[l_ac].glaq003,g_glaq_d[l_ac].glaq004,g_glaq_d[l_ac].glaq039,g_glaq_d[l_ac].glaq040, 
                      g_glaq_d[l_ac].glaq041,g_glaq_d[l_ac].glaq042,g_glaq_d[l_ac].glaq043,g_glaq_d[l_ac].glaq044 
 
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_glaq_d_t.glaqseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_glaq_d_mask_o[l_ac].* =  g_glaq_d[l_ac].*
                  CALL aglt310_glaq_t_mask()
                  LET g_glaq_d_mask_n[l_ac].* =  g_glaq_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aglt310_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
#            IF g_glap001_p='2' OR g_glap001_p='3' THEN
#               SELECT glaq017,glaq018,glaq019,glaq020,glaq021,glaq022,glaq023,
#                      glaq024,glaq025,glaq027,glaq028,glaq051,glaq052,glaq053
#                 INTO g_glaq_s.glaq017,g_glaq_s.glaq018,g_glaq_s.glaq019,g_glaq_s.glaq020,g_glaq_s.glaq021,
#                      g_glaq_s.glaq022,g_glaq_s.glaq023,g_glaq_s.glaq024,g_glaq_s.glaq025,g_glaq_s.glaq027,
#                      g_glaq_s.glaq028,g_glaq_s.glaq051,g_glaq_s.glaq052,g_glaq_s.glaq053
#                 FROM glaq_t
#                WHERE glaqent=g_enterprise AND glaqld=g_glap_m.glapld 
#                  AND glaqdocno=g_glap_m.glapdocno AND glaqseq=0
#            END IF
            #160902-00030#1 mark --s
            #IF g_glap001_p='2' AND g_glaq_d[l_ac].glaqseq=0 THEN
            #   INITIALIZE g_errparam TO NULL
            #   LET g_errparam.code = 'agl-00233'
            #   LET g_errparam.extend = ''
            #   LET g_errparam.popup = TRUE
            #   CALL cl_err()
            #
            #   EXIT DIALOG
            #END IF
            #IF g_glap001_p='3' AND g_glaq_d[l_ac].glaqseq=0 THEN
            #   INITIALIZE g_errparam TO NULL
            #   LET g_errparam.code = 'agl-00234'
            #   LET g_errparam.extend = ''
            #   LET g_errparam.popup = TRUE
            #   CALL cl_err()
            #
            #   EXIT DIALOG
            #END IF
            #160902-00030#1 mark --e
            CALL aglt310_set_entry_b(l_cmd)
            CALL aglt310_set_no_entry_b(l_cmd)
            CALL aglt310_b_detail()
            LET g_glaq_d[l_ac].amt2=g_glaq_d[l_ac].glaq040+g_glaq_d[l_ac].glaq041
            LET g_glaq_d[l_ac].amt3=g_glaq_d[l_ac].glaq043+g_glaq_d[l_ac].glaq044
            IF l_cmd='a' THEN
               LET l_insert = TRUE
            END IF
            #取原幣的金额小數位數
            IF NOT cl_null(g_glaq_d[l_ac].glaq005) THEN
               CALL s_curr_sel_ooaj004(g_glaa026,g_glaq_d[l_ac].glaq005) RETURNING g_ooaj004_o
            END IF
            #核算项
            INITIALIZE g_glaq_r.* TO NULL
            SELECT glaq017,glaq018,glaq019,glaq020,glaq021,glaq022,
                   glaq023,glaq024,glaq051,glaq052,glaq053,glaq025,glaq027,glaq028,
                   glaq029,glaq030,glaq031,glaq032,glaq033,glaq034,glaq035,glaq036,glaq037,glaq038
              INTO g_glaq_r.glaq017,g_glaq_r.glaq018,g_glaq_r.glaq019,g_glaq_r.glaq020,g_glaq_r.glaq021,
                   g_glaq_r.glaq022,g_glaq_r.glaq023,g_glaq_r.glaq024,g_glaq_r.glaq051,g_glaq_r.glaq052,
                   g_glaq_r.glaq053,g_glaq_r.glaq025,g_glaq_r.glaq027,g_glaq_r.glaq028,g_glaq_r.glaq029,
                   g_glaq_r.glaq030,g_glaq_r.glaq031,g_glaq_r.glaq032,g_glaq_r.glaq033,g_glaq_r.glaq034,
                   g_glaq_r.glaq035,g_glaq_r.glaq036,g_glaq_r.glaq037,g_glaq_r.glaq038
              FROM glaq_t
             WHERE glaqent = g_enterprise
               AND glaqld = g_glap_m.glapld
               AND glaqdocno = g_glap_m.glapdocno
               AND glaqseq = g_glaq_d[l_ac].glaqseq
            #現金變動碼
            LET g_glaq_r.glbc004=''
            LET l_cnt=0
            SELECT COUNT(1) INTO l_cnt FROM glbc_t #161205-00025#4 mod '*'-->1
             WHERE glbcent = g_enterprise AND glbcld = g_glap_m.glapld
               AND glbcdocno = g_glap_m.glapdocno
               AND glbcseq = g_glaq_d[l_ac].glaqseq
               AND glbc001 = g_glap_m.glap002 
               AND glbc002 = g_glap_m.glap004
            IF l_cnt = 1 THEN
               SELECT glbc004 INTO g_glaq_r.glbc004 FROM glbc_t
                WHERE glbcent = g_enterprise AND glbcld = g_glap_m.glapld
                  AND glbcdocno = g_glap_m.glapdocno
                  AND glbcseq = g_glaq_d[l_ac].glaqseq
                  AND glbc001 = g_glap_m.glap002 
                  AND glbc002 = g_glap_m.glap004
            ELSE
               LET g_glaq_r.glbc004=' '
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
            INITIALIZE g_glaq_d[l_ac].* TO NULL 
            INITIALIZE g_glaq_d_t.* TO NULL 
            INITIALIZE g_glaq_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
            
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            
            #end add-point
            LET g_glaq_d_t.* = g_glaq_d[l_ac].*     #新輸入資料
            LET g_glaq_d_o.* = g_glaq_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aglt310_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            LET g_glaq_d[l_ac].glaq003 = 0
            LET g_glaq_d[l_ac].glaq004 = 0
            LET g_glaq_d[l_ac].glaq005 = g_glaa001
            LET g_glaq_d[l_ac].glaq006 = 1
            LET g_glaq_d[l_ac].glaq039 = 0
            LET g_glaq_d[l_ac].glaq040 = 0
            LET g_glaq_d[l_ac].glaq041 = 0
            LET g_glaq_d[l_ac].glaq042 = 0
            LET g_glaq_d[l_ac].glaq043 = 0
            LET g_glaq_d[l_ac].glaq044 = 0   
            
            IF g_glaa015='Y' THEN
               #日汇率
               IF g_glaa028 = '1' THEN #160918-00006#2 add
               CALL s_aooi160_get_exrate('2',g_glap_m.glapld,g_glap_m.glapdocdt,g_glaa001,g_glaa016,0,g_glaa018)
               RETURNING  g_glaq_d[l_ac].glaq039
               #160918-00006#2--add--str--
               ELSE
                  #月汇率
                  CALL s_aooi160_get_exrate_avg('2',g_glap_m.glapld,g_glap_m.glapdocdt,g_glaa001,g_glaa016,0,g_glaa018)
                  RETURNING l_success,g_errno,g_glaq_d[l_ac].glaq039
               END IF
               #160918-00006#2--add--end
            END IF
            IF g_glaa019='Y' THEN
               #日汇率
               IF g_glaa028 = '1' THEN #160918-00006#2 add
               CALL s_aooi160_get_exrate('2',g_glap_m.glapld,g_glap_m.glapdocdt,g_glaa001,g_glaa020,0,g_glaa022) 
               RETURNING  g_glaq_d[l_ac].glaq042
               #160918-00006#2--add--str--
               ELSE
                  #月汇率
                  CALL s_aooi160_get_exrate_avg('2',g_glap_m.glapld,g_glap_m.glapdocdt,g_glaa001,g_glaa020,0,g_glaa022) 
                  RETURNING l_success,g_errno,g_glaq_d[l_ac].glaq042
               END IF
               #160918-00006#2--add--end
            END IF
            
            #原币小数取位
            LET g_ooaj004_o=g_ooaj004
            #核算项
            INITIALIZE g_glaq_r.* TO NULL
            IF lb_reproduce THEN
               SELECT glaq017,glaq018,glaq019,glaq020,glaq021,glaq022,
                      glaq023,glaq024,glaq051,glaq052,glaq053,glaq025,glaq027,glaq028,
                      glaq029,glaq030,glaq031,glaq032,glaq033,glaq034,glaq035,glaq036,glaq037,glaq038
                 INTO g_glaq_r.glaq017,g_glaq_r.glaq018,g_glaq_r.glaq019,g_glaq_r.glaq020,g_glaq_r.glaq021,
                      g_glaq_r.glaq022,g_glaq_r.glaq023,g_glaq_r.glaq024,g_glaq_r.glaq051,g_glaq_r.glaq052,
                      g_glaq_r.glaq053,g_glaq_r.glaq025,g_glaq_r.glaq027,g_glaq_r.glaq028,g_glaq_r.glaq029,
                      g_glaq_r.glaq030,g_glaq_r.glaq031,g_glaq_r.glaq032,g_glaq_r.glaq033,g_glaq_r.glaq034,
                      g_glaq_r.glaq035,g_glaq_r.glaq036,g_glaq_r.glaq037,g_glaq_r.glaq038
                 FROM glaq_t
                WHERE glaqent = g_enterprise
                  AND glaqld = g_glap_m.glapld
                  AND glaqdocno = g_glap_m.glapdocno
                  AND glaqseq = g_glaq_d[li_reproduce].glaqseq
               #現金變動碼
               LET g_glaq_r.glbc004=''
               LET l_cnt=0
               SELECT COUNT(1) INTO l_cnt FROM glbc_t #161205-00025#4 mod '*'-->1
                WHERE glbcent = g_enterprise AND glbcld = g_glap_m.glapld
                  AND glbcdocno = g_glap_m.glapdocno
                  AND glbcseq = g_glaq_d[li_reproduce].glaqseq
                  AND glbc001 = g_glap_m.glap002 
                  AND glbc002 = g_glap_m.glap004
               IF l_cnt=1 THEN
                  SELECT glbc004 INTO g_glaq_r.glbc004 FROM glbc_t
                   WHERE glbcent = g_enterprise AND glbcld = g_glap_m.glapld
                     AND glbcdocno = g_glap_m.glapdocno
                     AND glbcseq = g_glaq_d[li_reproduce].glaqseq
                     AND glbc001 = g_glap_m.glap002 
                     AND glbc002 = g_glap_m.glap004
               ELSE
                  LET g_glaq_r.glbc004=' '
               END IF
            END IF
            #end add-point
            CALL aglt310_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_glaq_d[li_reproduce_target].* = g_glaq_d[li_reproduce].*
 
               LET g_glaq_d[li_reproduce_target].glaqseq = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
            #项次
            IF g_glaq_d[l_ac].glaqseq IS NULL OR g_glaq_d[l_ac].glaqseq = 0 THEN
               SELECT MAX(glaqseq)+1
                 INTO g_glaq_d[l_ac].glaqseq
                 FROM glaq_t
                WHERE glaqent = g_enterprise
                  AND glaqld = g_glap_m.glapld
                  AND glaqdocno = g_glap_m.glapdocno
               IF g_glaq_d[l_ac].glaqseq IS NULL THEN
                  LET g_glaq_d[l_ac].glaqseq = 1
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
            SELECT COUNT(1) INTO l_count FROM glaq_t 
             WHERE glaqent = g_enterprise AND glaqld = g_glap_m.glapld
               AND glaqdocno = g_glap_m.glapdocno
 
               AND glaqseq = g_glaq_d[l_ac].glaqseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               IF cl_null(g_glaq_d[l_ac].glaq003) THEN LET g_glaq_d[l_ac].glaq003 = 0 END IF
               IF cl_null(g_glaq_d[l_ac].glaq004) THEN LET g_glaq_d[l_ac].glaq004 = 0 END IF
               
               #当程式运行为aglt320时
               IF g_glap001_p = '2' THEN
                  LET g_glaq_d[l_ac].glaq003 = 0
               END IF 
               #当程式运行为aglt330时
               IF g_glap001_p = '3' THEN
                  LET g_glaq_d[l_ac].glaq004 = 0
               END IF
               IF g_glaq_d[l_ac].glaq003<>0 THEN
                  LET g_glaq_d[l_ac].glaq040=g_glaq_d[l_ac].amt2
                  LET g_glaq_d[l_ac].glaq041=0
                  LET g_glaq_d[l_ac].glaq043=g_glaq_d[l_ac].amt3
                  LET g_glaq_d[l_ac].glaq044=0
               ELSE
                  LET g_glaq_d[l_ac].glaq040=0
                  LET g_glaq_d[l_ac].glaq041=g_glaq_d[l_ac].amt2
                  LET g_glaq_d[l_ac].glaq043=0
                  LET g_glaq_d[l_ac].glaq044=g_glaq_d[l_ac].amt3
               END IF
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_glap_m.glapld
               LET gs_keys[2] = g_glap_m.glapdocno
               LET gs_keys[3] = g_glaq_d[g_detail_idx].glaqseq
               CALL aglt310_insert_b('glaq_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
                                                                            #業務諮詢新增
               LET g_glap_m.glaq007 = ''  LET g_glap_m.glaq008=''  LET g_glap_m.glaq009=''
               LET g_glap_m.glaq011 = ''  LET g_glap_m.glaq012=''  LET g_glap_m.glaq013='' 
               LET g_glap_m.glaq014 = ''  LET g_glap_m.glaq015=''  LET g_glap_m.glaq016=''
               CALL aglt310_bus_cons_open_chk(g_glaq_d[l_ac].glaq002) RETURNING l_cnt
               IF l_cnt >0  THEN
                 CALL aglt310_05('a',g_glap_m.glapld,g_glap_m.glapdocno,g_glap_m.glapdocdt,g_glaq_d[l_ac].glaq002,g_glaq_d[l_ac].glaqseq) 
                 RETURNING g_glap_m.glaq007,g_glap_m.glaq008,g_glap_m.glaq009,
                           g_glap_m.glaq011,g_glap_m.glaq012,g_glap_m.glaq013,g_glap_m.glaq014,g_glap_m.glaq015,g_glap_m.glaq016
                END IF            
               #將離開科目欄位后的业务咨询/核算项 insert進DB
               CALL aglt310_update_forzen() RETURNING l_success 
               IF l_success = FALSE THEN
                  CALL s_transaction_end('N','0')                    
                  CANCEL INSERT
               END IF                              
               #161003-00014#15 ---s---          
               #檢查是否適用預算科目 
               CALL s_aooi200_fin_get_slip(g_glap_m.glapdocno) RETURNING g_sub_success,g_ap_slip
               CALL s_fin_get_doc_para(g_glap_m.glapld,g_glap_m.glapcomp,g_ap_slip,'D-FIN-5002') RETURNING g_dfin5002 
               IF g_glap_m.glap007 = 'GL' THEN #170116-00074#5 add
                  IF g_dfin5002 = 'Y' AND cl_null(g_glap_m.glap008)THEN                    
                     CALL s_aapp330_bgbd_upd(g_glap_m.glapdocno,g_glap_m.glapld,g_glaq_d[l_ac].glaqseq,'','1') RETURNING g_sub_success,g_errno
                     IF NOT g_sub_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = g_glaq_d[g_detail_idx].glaq002
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        CALL s_transaction_end('N','0') 
                        CANCEL INSERT                     
                     END IF         
                     
                     #預算額度是否超過
                     CALL s_aapp330_bgbd_upd(g_glap_m.glapdocno,g_glap_m.glapld,g_glaq_d[l_ac].glaqseq,'','2') RETURNING g_sub_success,g_errno
                     IF NOT g_sub_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = g_glaq_d[g_detail_idx].glaq002
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        CALL s_transaction_end('N','0')
                        CANCEL INSERT                    
                     END IF                
                     #新增預算滾動檔         
                     CALL s_aapp330_bgbd_upd(g_glap_m.glapdocno,g_glap_m.glapld,g_glaq_d[l_ac].glaqseq,'I','3') RETURNING g_sub_success,g_errno
                     IF NOT g_sub_success THEN
                         INITIALIZE g_errparam TO NULL
                         LET g_errparam.code = g_errno
                         LET g_errparam.extend = g_glaq_d[g_detail_idx].glaq002
                         LET g_errparam.popup = TRUE
                         CALL cl_err()
                         CALL s_transaction_end('N','0') 
                         CANCEL INSERT
                      END IF                                                             
                  END IF        
               END IF #170116-00074#5 add                   
                 #161003-00014#15  ---e---   

               #维护现金变动码
               CALL aglt310_ins_upd_glbc() RETURNING l_success 
               IF l_success = FALSE THEN
                  CALL s_transaction_end('N','0')                    
                  CANCEL INSERT
               END IF
           
               #當aglt310、aglt320、aglt330時,判斷是否進行細項立帳
               IF g_glap001_p MATCHES '[123]' THEN
                  CALL aglt310_insert_glax() RETURNING l_success 
                  IF l_success=FALSE THEN
                     CALL s_transaction_end('N','0')                    
                     CANCEL INSERT
                  END IF
               END IF
               
               
               #刷新科目显示
               CALL aglt310_subject()
               
               #當aglt310、aglt320、aglt330時判斷是否進行細項立沖
               IF g_glap001_p MATCHES '[123]' THEN            
                  CALL aglt310_offset() RETURNING l_flag
               ELSE
                  LET l_flag=TRUE #標示是否細項沖帳               
               END IF
               IF l_flag=FALSE THEN
                  CALL s_transaction_end('N','0')
                  CANCEL INSERT
               END IF
#            END IF
#            IF (l_count > 0 AND l_flag=TRUE) OR l_count=0 THEN   #當細存在項沖抵時
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_glaq_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "glaq_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aglt310_b_fill()
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
               CALL s_ld_chk_authorization(g_user,g_glap_m.glapld) RETURNING l_pass
               IF l_pass = FALSE THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00164'
                  LET g_errparam.extend = g_glap_m.glapld
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CANCEL DELETE        
               END IF
               #end add-point 
               
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_glap_m.glapld
               LET gs_keys[gs_keys.getLength()+1] = g_glap_m.glapdocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_glaq_d_t.glaqseq
 
            
               #刪除同層單身
               IF NOT aglt310_delete_b('glaq_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aglt310_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aglt310_key_delete_b(gs_keys,'glaq_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aglt310_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               #170113-00042#1--add--str--
               IF g_glap001_p MATCHES '[123]' THEN
                  CALL aglt310_get_glad(g_glap_m.glapld,g_glaq_d_t.glaq002) RETURNING l_glad003,l_glad004
                  #刪除相關科目細項立沖帳資料   
                  IF l_glad003='Y' THEN  
                     CALL aglt310_delete_glax(g_glap_m.glapld,g_glap_m.glapdocno,g_glaq_d_t.glaqseq) RETURNING l_success
                     IF l_success=FALSE THEN
                        CALL s_transaction_end('N','0')
                        CANCEL DELETE 
                     END IF
                     CALL aglt310_delete_glay(g_glap_m.glapld,g_glap_m.glapdocno,g_glaq_d_t.glaqseq) RETURNING l_success
                     IF l_success=FALSE THEN
                        CALL s_transaction_end('N','0')
                        CANCEL DELETE
                     END IF
                  END IF            
               END IF
               #删除现金变动码资料
               SELECT COUNT(1) INTO l_cnt FROM glbc_t #161205-00025#4 mod '*'-->1
                WHERE glbcent=g_enterprise AND glbcld=g_glap_m.glapld
                  AND glbcdocno=g_glap_m.glapdocno AND glbcseq=g_glaq_d_t.glaqseq
               IF l_cnt >0 THEN
                  DELETE FROM glbc_t
                   WHERE glbcent=g_enterprise AND glbcld=g_glap_m.glapld
                     AND glbcdocno=g_glap_m.glapdocno AND glbcseq=g_glaq_d_t.glaqseq
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "delete glbc_t" 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                     CALL s_transaction_end('N','0')
                     CANCEL DELETE
                  END IF
               END IF
               #170113-00042#1--add--end
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE aglt310_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
#170113-00042#1--mark--str--
#移至删除单身中的add point中，将更新资料放在事务中
#               IF g_glap001_p MATCHES '[123]' THEN
#                  CALL aglt310_get_glad(g_glap_m.glapld,g_glaq_d_t.glaq002) RETURNING l_glad003,l_glad004
#                  #刪除相關科目細項立沖帳資料   
#                  IF l_glad003='Y' THEN  
#                     CALL aglt310_delete_glax(g_glap_m.glapld,g_glap_m.glapdocno,g_glaq_d_t.glaqseq) RETURNING l_success
#                     IF l_success=FALSE THEN
#                        CALL s_transaction_end('N','0')
#                        CANCEL DELETE 
#                     END IF
#                     CALL aglt310_delete_glay(g_glap_m.glapld,g_glap_m.glapdocno,g_glaq_d_t.glaqseq) RETURNING l_success
#                     IF l_success=FALSE THEN
#                        CALL s_transaction_end('N','0')
#                        CANCEL DELETE
#                     END IF
#                  END IF            
#               END IF
#               #删除现金变动码资料
#               SELECT COUNT(1) INTO l_cnt FROM glbc_t #161205-00025#4 mod '*'-->1
#                WHERE glbcent=g_enterprise AND glbcld=g_glap_m.glapld
#                  AND glbcdocno=g_glap_m.glapdocno AND glbcseq=g_glaq_d_t.glaqseq
#               IF l_cnt >0 THEN
#                  DELETE FROM glbc_t
#                   WHERE glbcent=g_enterprise AND glbcld=g_glap_m.glapld
#                     AND glbcdocno=g_glap_m.glapdocno AND glbcseq=g_glaq_d_t.glaqseq
#                  IF SQLCA.sqlcode THEN
#                     INITIALIZE g_errparam TO NULL 
#                     LET g_errparam.extend = "delete glbc_t" 
#                     LET g_errparam.code   = SQLCA.sqlcode 
#                     LET g_errparam.popup  = TRUE 
#                     CALL cl_err()
#                     
#                     CALL s_transaction_end('N','0')
#                     CANCEL DELETE
#                  END IF
#               END IF
#170113-00042#1--mark--end
               #end add-point
               LET l_count = g_glaq_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               #删除一行记录后，重新抓取下一笔记录的核算项资料
               IF NOT cl_null(g_glaq_d[l_ac+1].glaqseq) THEN
                  INITIALIZE g_glaq_r.* TO NULL
                  SELECT glaq017,glaq018,glaq019,glaq020,glaq021,glaq022,
                         glaq023,glaq024,glaq051,glaq052,glaq053,glaq025,glaq027,glaq028,
                         glaq029,glaq030,glaq031,glaq032,glaq033,glaq034,glaq035,glaq036,glaq037,glaq038
                    INTO g_glaq_r.glaq017,g_glaq_r.glaq018,g_glaq_r.glaq019,g_glaq_r.glaq020,g_glaq_r.glaq021,
                         g_glaq_r.glaq022,g_glaq_r.glaq023,g_glaq_r.glaq024,g_glaq_r.glaq051,g_glaq_r.glaq052,
                         g_glaq_r.glaq053,g_glaq_r.glaq025,g_glaq_r.glaq027,g_glaq_r.glaq028,g_glaq_r.glaq029,
                         g_glaq_r.glaq030,g_glaq_r.glaq031,g_glaq_r.glaq032,g_glaq_r.glaq033,g_glaq_r.glaq034,
                         g_glaq_r.glaq035,g_glaq_r.glaq036,g_glaq_r.glaq037,g_glaq_r.glaq038
                    FROM glaq_t
                   WHERE glaqent = g_enterprise
                     AND glaqld = g_glap_m.glapld
                     AND glaqdocno = g_glap_m.glapdocno
                     AND glaqseq = g_glaq_d[l_ac+1].glaqseq
                  #現金變動碼
                  LET g_glaq_r.glbc004=''
                  LET l_cnt=0
                  SELECT COUNT(1) INTO l_cnt FROM glbc_t #161205-00025#4 mod '*'-->1
                   WHERE glbcent = g_enterprise AND glbcld = g_glap_m.glapld
                     AND glbcdocno = g_glap_m.glapdocno
                     AND glbcseq = g_glaq_d[l_ac+1].glaqseq
                     AND glbc001 = g_glap_m.glap002 
                     AND glbc002 = g_glap_m.glap004
                  IF l_cnt = 1 THEN
                     SELECT glbc004 INTO g_glaq_r.glbc004 FROM glbc_t
                      WHERE glbcent = g_enterprise AND glbcld = g_glap_m.glapld
                        AND glbcdocno = g_glap_m.glapdocno
                        AND glbcseq = g_glaq_d[l_ac+1].glaqseq
                        AND glbc001 = g_glap_m.glap002 
                        AND glbc002 = g_glap_m.glap004
                  ELSE
                     LET g_glaq_r.glbc004=' '
                  END IF
               END IF
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_glaq_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaqseq
            #add-point:BEFORE FIELD glaqseq name="input.b.page1.glaqseq"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaqseq
            
            #add-point:AFTER FIELD glaqseq name="input.a.page1.glaqseq"
                                                            #此段落由子樣板a05產生
            IF  NOT cl_null(g_glap_m.glapdocno) AND NOT cl_null(g_glap_m.glapld) AND NOT cl_null(g_glaq_d[l_ac].glaqseq) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_glap_m.glapdocno != g_glapdocno_t OR g_glap_m.glapld != g_glapld_t OR g_glaq_d[l_ac].glaqseq != g_glaq_d_t.glaqseq))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(1) FROM glaq_t WHERE "||"glaqent = '" ||g_enterprise|| "' AND "||"glaqdocno = '"||g_glap_m.glapdocno ||"' AND "|| "glaqld = '"||g_glap_m.glapld ||"' AND "|| "glaqseq = '"||g_glaq_d[l_ac].glaqseq ||"'",'std-00004',0) THEN #161205-00025#4 mod '*'-->1 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaqseq
            #add-point:ON CHANGE glaqseq name="input.g.page1.glaqseq"
                                                
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaqcomp
            #add-point:BEFORE FIELD glaqcomp name="input.b.page1.glaqcomp"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaqcomp
            
            #add-point:AFTER FIELD glaqcomp name="input.a.page1.glaqcomp"
                                                
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaqcomp
            #add-point:ON CHANGE glaqcomp name="input.g.page1.glaqcomp"
                                                
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq001
            #add-point:BEFORE FIELD glaq001 name="input.b.page1.glaq001"
            IF l_ac>1 THEN
               IF cl_null(g_glaq_d[l_ac].glaq001) THEN
                  LET g_glaq_d[l_ac].glaq001= g_glaq_d[l_ac-1].glaq001
               END IF
            END IF                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq001
            
            #add-point:AFTER FIELD glaq001 name="input.a.page1.glaq001"
            DISPLAY BY NAME g_glaq_d[l_ac].glaq001
            IF NOT cl_null(g_glaq_d[l_ac].glaq001) THEN
               IF l_ac>1 THEN
                  IF g_glaq_d[l_ac].glaq001='..' OR g_glaq_d[l_ac].glaq001='。。' THEN
                     LET g_glaq_d[l_ac].glaq001= g_glaq_d[l_ac-1].glaq001
                     DISPLAY BY NAME g_glaq_d[l_ac].glaq001 
                  END IF
               END IF
               LET g_msg = g_glaq_d[l_ac].glaq001
               IF g_msg[1,1] = '.' THEN
                  LET g_msg = g_msg[2,10]
                  SELECT oocql004 INTO g_glaq_d[l_ac].glaq001 FROM oocql_t
                   WHERE oocqlent = g_enterprise
                     AND oocql001 = '3005'
                     AND oocql002 = g_msg
                     AND oocql003 = g_dlang
                  DISPLAY BY NAME g_glaq_d[l_ac].glaq001                
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq001
            #add-point:ON CHANGE glaq001 name="input.g.page1.glaq001"
                                               
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq002
            #add-point:BEFORE FIELD glaq002 name="input.b.page1.glaq002"
                                                            #修改时,并且是非开窗获得值，则重新抓值
                   
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq002
            
            #add-point:AFTER FIELD glaq002 name="input.a.page1.glaq002"
                                                            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq002
            #add-point:ON CHANGE glaq002 name="input.g.page1.glaq002"
                                                
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD lc_subject
            #add-point:BEFORE FIELD lc_subject name="input.b.page1.lc_subject"
            LET g_glaq_d[l_ac].lc_subject = g_glaq_d[l_ac].glaq002                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD lc_subject
            
            #add-point:AFTER FIELD lc_subject name="input.a.page1.lc_subject"
#            #快捷带出相类似的科目编号
#            IF NOT cl_null(g_glaq_d[l_ac].lc_subject) THEN              
#               IF l_cmd = 'a' OR (l_cmd = 'u' AND g_glaq_d[l_ac].lc_subject <> g_glaq_d_t.glaq002) THEN  
#                  LET l_cnt = 0
#                  #151117-00009#1--mod--str--
##                  LET l_sql = "SELECT COUNT(*) FROM glac_t ",
##                              " WHERE glacent=",g_enterprise," AND glac001 = '",g_glaa004,"'",
##                              "   AND glac002 LIKE '%",g_glaq_d[l_ac].lc_subject,"%'",
##                              "   AND  glac003 <>'1' AND glac006 = '1' AND glacstus = 'Y' ",
##                              "   AND glac035 = 'N' "   #150827-00036#7 add
#                  LET l_sql = "SELECT COUNT(*) FROM glac_t,glad_t ",
#                              " WHERE glacent=gladent AND glac002=glad001",
#                              "   AND glacent=",g_enterprise," AND glac001 = '",g_glaa004,"'",
#                              "   AND glac002 LIKE '%",g_glaq_d[l_ac].lc_subject,"%'",
#                              "   AND glac003 <>'1' AND glac006 = '1' AND glacstus = 'Y' ",
#                              "   AND gladld='",g_glap_m.glapld,"'",
#                              "   AND glad035 = 'N' AND gladstus='Y' "   
#                  #151117-00009#1--mod--end
#                  PREPARE sel_glac_cnt_pr FROM l_sql
#                  EXECUTE sel_glac_cnt_pr INTO l_cnt
#                  IF l_cnt > 1 THEN
#                     INITIALIZE g_qryparam.* TO NULL
#                     LET g_qryparam.state = 'i'
#                     LET g_qryparam.reqry = FALSE
#                     LET g_qryparam.default1 = g_glaq_d[l_ac].lc_subject  #給予default值
#                     #給予arg
#                     LET g_qryparam.where = "glac001 = '",g_glaa004,"' AND  glac003 <>'1' AND glac006 = '1'",
##                                            " AND glac035 = 'N' ",  #150827-00036#7 add  #151117-00009#1 mark
#                                            " AND glac002 LIKE '%",g_glaq_d[l_ac].lc_subject,"%' ",
#                                            #151117-00009#1--add--str--
#                                            " AND glac002 IN (SELECT glad001 FROM glad_t ",
#                                            "                  WHERE gladent=",g_enterprise," AND gladld='",g_glap_m.glapld,"'",
#                                            "                    AND glad035='N' AND gladstus='Y' )"
#                                            #151117-00009#1--add--end
#                     CALL q_glac002_3()
#                     LET g_glaq_d[l_ac].lc_subject = g_qryparam.return1              #將開窗取得的值回傳到變數
#                     DISPLAY g_glaq_d[l_ac].lc_subject TO lc_subject                  
#                  END IF
#               END IF
#            END IF
             #检查
             IF NOT cl_null(g_glaq_d[l_ac].lc_subject) THEN
               # 开窗模糊查询 150916-00015#1 --add                      
               IF s_aglt310_getlike_lc_subject(g_glap_m.glapld,g_glaq_d[l_ac].lc_subject,"")  THEN            
                  
                  SELECT glaa004 INTO l_glaa004
                    FROM glaa_t
                   WHERE glaaent = g_enterprise
                     AND glaald  = g_glap_m.glapld
                  
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
                  LET g_qryparam.reqry = 'FALSE'
                  LET g_qryparam.default1 = g_glaq_d[l_ac].lc_subject
                                
                  LET g_qryparam.arg1 = l_glaa004
                  LET g_qryparam.arg2 = g_glaq_d[l_ac].lc_subject
                  LET g_qryparam.arg3 = g_glap_m.glapld
                  LET g_qryparam.arg4 = " 1"
                  #160509-00005#1--add--str--
                  #排除子系统科目
                  IF g_glap001_p <> '6' THEN #160517-00001#3 add 
                  LET g_qryparam.where =" glac002 NOT IN (SELECT glad001 FROM glad_t ",
                                        "                 WHERE gladent=",g_enterprise,
                                        "                   AND gladld='",g_glap_m.glapld,"'",
                                        "                   AND glad035='Y' AND gladstus='Y'",
                                        "                 )"
                  END IF #160517-00001#3 add 
                  #160509-00005#1--add--end
                  CALL q_glac002_6()
                  LET  g_glaq_d[l_ac].lc_subject = g_qryparam.return1
                  DISPLAY g_glaq_d[l_ac].lc_subject TO lc_subject                     
               END IF
               # 150916-00015#1 --end
               #IF l_cmd = 'a' OR (l_cmd = 'u' AND g_glaq_d[l_ac].lc_subject <> g_glaq_d_t.glaq002) THEN #160824-00007#252 161220 By 08171 mark
               IF cl_null(g_glaq_d_o.glaq002) OR g_glaq_d[l_ac].lc_subject != g_glaq_d_o.glaq002 THEN  #160824-00007#252 161220 By 08171 add
                  #151117-00009#1--add--str--
                  #科目存在性，有效性，非统治科目，账户科目属性检查
                  CALL s_voucher_glaq002_chk(g_glap_m.glapld,g_glaq_d[l_ac].lc_subject)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_glaq_d[l_ac].lc_subject
                     #160321-00016#30 --s add
                     LET g_errparam.replace[1] = 'agli030'
                     LET g_errparam.replace[2] = cl_get_progname('agli030',g_lang,"2")
                     LET g_errparam.exeprog = 'agli030'
                     #160321-00016#30 --e add
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                  
                    #LET g_glaq_d[l_ac].lc_subject = g_glaq_d_t.glaq002 #160824-00007#252 161220 By 08171 mark
                     LET g_glaq_d[l_ac].lc_subject = g_glaq_d_o.glaq002 #160824-00007#252 161220 By 08171 add
                     NEXT FIELD lc_subject                  
                  END IF 
                  #151117-00009#1--add--end
                  #科目为非子系统科目
                  IF g_glap001_p <> '6' THEN  #160517-00001#3 add #aglt420可以使用子系统科目 
                  CALL aglt310_glap006_chk(g_glaq_d[l_ac].lc_subject)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_glaq_d[l_ac].lc_subject
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                  
                    #LET g_glaq_d[l_ac].lc_subject = g_glaq_d_t.glaq002 #160824-00007#252 161220 By 08171 mark
                     LET g_glaq_d[l_ac].lc_subject = g_glaq_d_o.glaq002 #160824-00007#252 161220 By 08171 add
                     NEXT FIELD lc_subject                  
                  END IF 
                  END IF #160517-00001#3 add
                  LET g_glaq_d[l_ac].glaq002 =g_glaq_d[l_ac].lc_subject   
                  
                  #150814-00006#3--add--str--
                  #用于判断现金变动码要取的借贷方向
                  LET l_flag2=''
                  #借方
                  IF g_glaq_d[l_ac].glaq003 <> '0' THEN
                     LET l_flag2='d'
                  END IF
                  #贷方
                  IF g_glaq_d[l_ac].glaq004 <> '0' THEN
                     LET l_flag2='c'
                  END IF
                  #150814-00006#3--add--end 
                  #核算项及现金变动码
                  #150814-00006#3 add ''-->l_flag2
                  #160824-00007#252 161220 By 08171 --s add
                  LET g_glaq_r.glaq017 = ''
                  LET g_glaq_r.glaq018 = ''
                  LET g_glaq_r.glaq019 = ''
                  LET g_glaq_r.glaq020 = ''
                  LET g_glaq_r.glaq021 = ''
                  LET g_glaq_r.glaq022 = ''
                  LET g_glaq_r.glaq023 = ''
                  LET g_glaq_r.glaq024 = ''
                  LET g_glaq_r.glaq051 = ''
                  LET g_glaq_r.glaq052 = ''
                  LET g_glaq_r.glaq053 = ''
                  LET g_glaq_r.glaq025 = ''
                  LET g_glaq_r.glaq027 = ''
                  LET g_glaq_r.glaq028 = ''
                  LET g_glaq_r.glaq029 = ''
                  LET g_glaq_r.glaq030 = ''
                  LET g_glaq_r.glaq031 = ''
                  LET g_glaq_r.glaq032 = ''
                  LET g_glaq_r.glaq033 = ''
                  LET g_glaq_r.glaq034 = ''
                  LET g_glaq_r.glaq035 = ''
                  LET g_glaq_r.glaq036 = ''
                  LET g_glaq_r.glaq037 = ''
                  LET g_glaq_r.glaq038 = ''
                  LET g_glaq_r.glbc004 = ''
                  #160824-00007#252 161220 By 08171 --e add
                  CALL aglt310_02(l_flag2,g_glap_m.glapld,'',g_glap_m.glapdocdt,g_glaq_d[l_ac].lc_subject,'','aglt310',g_glaq_r.*) 
                  RETURNING g_glaq_r.glaq017,g_glaq_r.glaq018,g_glaq_r.glaq019,g_glaq_r.glaq020,g_glaq_r.glaq021,g_glaq_r.glaq022,
                            g_glaq_r.glaq023,g_glaq_r.glaq024,g_glaq_r.glaq051,g_glaq_r.glaq052,g_glaq_r.glaq053,g_glaq_r.glaq025,
                            g_glaq_r.glaq027,g_glaq_r.glaq028,g_glaq_r.glaq029,g_glaq_r.glaq030,g_glaq_r.glaq031,g_glaq_r.glaq032,
                            g_glaq_r.glaq033,g_glaq_r.glaq034,g_glaq_r.glaq035,g_glaq_r.glaq036,g_glaq_r.glaq037,g_glaq_r.glaq038,
                            g_glaq_r.glbc004
                  LET g_glap_m.glaq017 = g_glaq_r.glaq017
                  LET g_glap_m.glaq018 = g_glaq_r.glaq018
                  LET g_glap_m.glaq019 = g_glaq_r.glaq019
                  LET g_glap_m.glaq020 = g_glaq_r.glaq020
                  LET g_glap_m.glaq021 = g_glaq_r.glaq021
                  LET g_glap_m.glaq022 = g_glaq_r.glaq022
                  LET g_glap_m.glaq023 = g_glaq_r.glaq023
                  LET g_glap_m.glaq024 = g_glaq_r.glaq024
                  LET g_glap_m.glaq051 = g_glaq_r.glaq051
                  LET g_glap_m.glaq052 = g_glaq_r.glaq052
                  LET g_glap_m.glaq053 = g_glaq_r.glaq053
                  LET g_glap_m.glaq025 = g_glaq_r.glaq025
                  LET g_glap_m.glaq027 = g_glaq_r.glaq027
                  LET g_glap_m.glaq028 = g_glaq_r.glaq028
                  LET g_glap_m.glaq029 = g_glaq_r.glaq029
                  LET g_glap_m.glaq030 = g_glaq_r.glaq030
                  LET g_glap_m.glaq031 = g_glaq_r.glaq031
                  LET g_glap_m.glaq032 = g_glaq_r.glaq032
                  LET g_glap_m.glaq033 = g_glaq_r.glaq033
                  LET g_glap_m.glaq034 = g_glaq_r.glaq034
                  LET g_glap_m.glaq035 = g_glaq_r.glaq035
                  LET g_glap_m.glaq036 = g_glaq_r.glaq036
                  LET g_glap_m.glaq037 = g_glaq_r.glaq037
                  LET g_glap_m.glaq038 = g_glaq_r.glaq038
                  LET g_glap_m.glbc004 = g_glaq_r.glbc004
               END IF
               #科目(核算項編號)+名称+核算项组合
               #160824-00007#252 161220 By 08171 --s add
               LET l_glaq002 = ''
               LET l_str     = ''
               #160824-00007#252 161220 By 08171 --e add
               CALL aglt310_glaq002() RETURNING l_glaq002,l_str
               LET g_glaq_d[l_ac].lc_subject = g_glaq_d[l_ac].glaq002,l_str,'\n',l_glaq002
               DISPLAY BY NAME g_glaq_d[l_ac].lc_subject
            END IF 
            
            #判斷科目做多幣別管理否
            IF g_glap_m.glap014 = 'Y' THEN
               LET l_glad034=''
               SELECT glad034 INTO l_glad034 FROM glad_t 
                WHERE gladent=g_enterprise AND gladld=g_glap_m.glapld AND glad001=g_glaq_d[l_ac].glaq002
               IF l_glad034 = 'N' THEN
                  #160824-00007#252 161220 By 08171 --s add
                  LET g_glaq_d[l_ac].glaq005 = ''
                  LET g_glaq_d[l_ac].glaq006 = ''
                  #160824-00007#252 161220 By 08171 --e add
                  LET g_glaq_d[l_ac].glaq005=g_glaa001
                  LET g_glaq_d[l_ac].glaq006=1
                  IF g_glaq_d[l_ac].glaq003 <>0 THEN
                     LET g_glaq_d[l_ac].glaq003=g_glaq_d[l_ac].glaq010
                  ELSE
                     LET g_glaq_d[l_ac].glaq004=g_glaq_d[l_ac].glaq010
                  END IF
                  NEXT FIELD glaq005
               END IF
            END IF
            
            #借贷金额都为0，跳到借方栏位
            IF g_glaq_d[l_ac].glaq003 = 0  AND g_glaq_d[l_ac].glaq004 = 0  THEN
               IF g_glap_m.glap014 = 'Y' THEN
                  NEXT FIELD glaq005
               END IF 
               IF g_glap001_p = '2' THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = 'agl-00084'
                   LET g_errparam.extend = ''
                   LET g_errparam.popup = FALSE
                   CALL cl_err()
                   LET l_errcode='agl-00084'
                   NEXT FIELD glaq004
               ELSE
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = 'agl-00084'
                   LET g_errparam.extend = ''
                   LET g_errparam.popup = FALSE
                   CALL cl_err()
                   LET l_errcode='agl-00084'
                   NEXT FIELD glaq003               
               END IF                                  
            END IF 
            LET g_glaq_d_o.* = g_glaq_d[l_ac].* #160824-00007#252 161220 By 08171 add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE lc_subject
            #add-point:ON CHANGE lc_subject name="input.g.page1.lc_subject"
                                                
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq005
            #add-point:BEFORE FIELD glaq005 name="input.b.page1.glaq005"
            #判斷科目做多幣別管理否
            IF g_glap_m.glap014 = 'Y' THEN
               LET l_glad034=''
               SELECT glad034 INTO l_glad034 FROM glad_t 
                WHERE gladent=g_enterprise AND gladld=g_glap_m.glapld AND glad001=g_glaq_d[l_ac].glaq002
               IF l_glad034 = 'N' THEN
                  LET g_glaq_d[l_ac].glaq005=g_glaa001
                  LET g_glaq_d[l_ac].glaq006=1
                  IF g_glaq_d[l_ac].glaq003 <>0 THEN
                     LET g_glaq_d[l_ac].glaq003=g_glaq_d[l_ac].glaq010
                  ELSE
                     LET g_glaq_d[l_ac].glaq004=g_glaq_d[l_ac].glaq010
                  END IF
               END IF
            END IF                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq005
            
            #add-point:AFTER FIELD glaq005 name="input.a.page1.glaq005"
            DISPLAY BY NAME g_glaq_d[l_ac].glaq005
            IF NOT cl_null(g_glaq_d[l_ac].glaq005) THEN
               #IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_glaq_d[l_ac].glaq005 <> g_glaq_d_t.glaq005 OR cl_null(g_glaq_d_t.glaq005)))THEN #160824-00007#252 161220 By 08171 mark
               IF g_glaq_d[l_ac].glaq005 != g_glaq_d_o.glaq005 OR cl_null(g_glaq_d_o.glaq005) THEN #160824-00007#252 161220 By 08171 add
                  CALL aglt310_glaq005_chk(g_glaq_d[l_ac].glaq005) 
                  IF NOT cl_null(g_errno) THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_glaq_d[l_ac].glaq005
                     #160318-00005#17  --add--str
                     LET g_errparam.replace[1] ='aooi140'
                     LET g_errparam.replace[2] = cl_get_progname('aooi140',g_lang,"2")
                     LET g_errparam.exeprog    ='aooi140'
                     #160318-00005#17 --add--end
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                  
                    #LET g_glaq_d[l_ac].glaq005 = g_glaq_d_t.glaq005 #160824-00007#252 161220 By 08171 mark
                     LET g_glaq_d[l_ac].glaq005 = g_glaq_d_o.glaq005 #160824-00007#252 161220 By 08171 add
                     NEXT FIELD glaq005
                  END IF
                  IF g_glap_m.glap014 = 'Y' THEN
                     LET l_glad034=''
                     SELECT glad034 INTO l_glad034 FROM glad_t 
                      WHERE gladent=g_enterprise AND gladld=g_glap_m.glapld AND glad001=g_glaq_d[l_ac].glaq002
                     IF l_glad034 = 'N' AND g_glaq_d[l_ac].glaq005 <> g_glaa001 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'agl-00316'
                        LET g_errparam.extend = g_glaq_d[l_ac].glaq005
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                       #LET g_glaq_d[l_ac].glaq005 = g_glaq_d_t.glaq005 #160824-00007#252 161220 By 08171 mark
                        LET g_glaq_d[l_ac].glaq005 = g_glaq_d_o.glaq005 #160824-00007#252 161220 By 08171 add
                        NEXT FIELD glaq005
                     END IF
                  END IF 
                  #錄入幣別與當前預設的幣別相同，匯率就是1 
                  #本位幣一匯率
                  #日汇率
                  LET g_glaq_d[l_ac].glaq006 = 0 #160824-00007#252 161220 By 08171 add
                  IF g_glaa028 = '1' THEN #160918-00006#2 add  
                  CALL s_aooi160_get_exrate('2',g_glap_m.glapld,g_glap_m.glapdocdt,g_glaq_d[l_ac].glaq005,g_glaa001,0,g_glaa025)
                  RETURNING  g_glaq_d[l_ac].glaq006
                  #160918-00006#2--add--str--
                  ELSE
                     #月汇率
                     CALL s_aooi160_get_exrate_avg('2',g_glap_m.glapld,g_glap_m.glapdocdt,g_glaq_d[l_ac].glaq005,g_glaa001,0,g_glaa025)
                     RETURNING l_success,g_errno,g_glaq_d[l_ac].glaq006
                  END IF
                  #160918-00006#2--add--end
                  
                  #取原幣的金额小數位數
                  CALL s_curr_sel_ooaj004(g_glaa026,g_glaq_d[l_ac].glaq005) RETURNING g_ooaj004_o
                  #本位幣二匯率
                  IF g_glaa015='Y' THEN
                     LET g_glaq_d[l_ac].glaq039 = 0 #160824-00007#252 161220 By 08171 add
                     IF g_glaa017='1' THEN #依交易原幣轉換
                        #日汇率
                        IF g_glaa028 = '1' THEN #160918-00006#2 add
                        CALL s_aooi160_get_exrate('2',g_glap_m.glapld,g_glap_m.glapdocdt,g_glaq_d[l_ac].glaq005,g_glaa016,0,g_glaa018)
                        RETURNING  g_glaq_d[l_ac].glaq039
                        #160918-00006#2--add--str--
                        ELSE
                           #月汇率
                           CALL s_aooi160_get_exrate_avg('2',g_glap_m.glapld,g_glap_m.glapdocdt,g_glaq_d[l_ac].glaq005,g_glaa016,0,g_glaa018)
                           RETURNING l_success,g_errno,g_glaq_d[l_ac].glaq039
                        END IF
                        #160918-00006#2--add--end
                     ELSE #依帳簿幣別
                        #日汇率
                        IF g_glaa028 = '1' THEN #160918-00006#2 add
                        CALL s_aooi160_get_exrate('2',g_glap_m.glapld,g_glap_m.glapdocdt,g_glaa001,g_glaa016,0,g_glaa018)
                        RETURNING  g_glaq_d[l_ac].glaq039
                        #160918-00006#2--add--str--
                        ELSE
                           #月汇率
                           CALL s_aooi160_get_exrate_avg('2',g_glap_m.glapld,g_glap_m.glapdocdt,g_glaa001,g_glaa016,0,g_glaa018)
                           RETURNING l_success,g_errno,g_glaq_d[l_ac].glaq039
                        END IF
                        #160918-00006#2--add--end
                     END IF
                  END IF 
                  #本位幣三匯率
                  IF g_glaa019='Y' THEN
                     LET g_glaq_d[l_ac].glaq042 = 0 #160824-00007#252 161220 By 08171 add
                     IF g_glaa021='1' THEN
                        #日汇率
                        IF g_glaa028 = '1' THEN #160918-00006#2 add
                        CALL s_aooi160_get_exrate('2',g_glap_m.glapld,g_glap_m.glapdocdt,g_glaq_d[l_ac].glaq005,g_glaa020,0,g_glaa022) 
                        RETURNING  g_glaq_d[l_ac].glaq042
                        #160918-00006#2--add--str--
                        ELSE
                           #月汇率
                           CALL s_aooi160_get_exrate_avg('2',g_glap_m.glapld,g_glap_m.glapdocdt,g_glaq_d[l_ac].glaq005,g_glaa020,0,g_glaa022)
                           RETURNING l_success,g_errno,g_glaq_d[l_ac].glaq042
                        END IF
                        #160918-00006#2--add--end
                     ELSE
                        #日汇率
                        IF g_glaa028 = '1' THEN #160918-00006#2 add
                        CALL s_aooi160_get_exrate('2',g_glap_m.glapld,g_glap_m.glapdocdt,g_glaa001,g_glaa020,0,g_glaa022) 
                        RETURNING  g_glaq_d[l_ac].glaq042
                        #160918-00006#2--add--str--
                        ELSE
                           #月汇率
                           CALL s_aooi160_get_exrate_avg('2',g_glap_m.glapld,g_glap_m.glapdocdt,g_glaa001,g_glaa020,0,g_glaa022)
                           RETURNING l_success,g_errno,g_glaq_d[l_ac].glaq042
                        END IF
                        #160918-00006#2--add--end
                     END IF
                  END IF 
                  #當幣別變化后判斷匯率是否改變，若發生改變重新計算金額
                  IF cl_null(g_glaq_d_t.glaq006) OR g_glaq_d[l_ac].glaq006 <> g_glaq_d_t.glaq006 THEN
                     IF g_glaq_d[l_ac].glaq003 <> 0 THEN #借方
                        LET g_glaq_d[l_ac].glaq003 = g_glaq_d[l_ac].glaq006 *g_glaq_d[l_ac].glaq010
                     ELSE #贷方
                        LET g_glaq_d[l_ac].glaq004 = g_glaq_d[l_ac].glaq006 *g_glaq_d[l_ac].glaq010
                     END IF
                      #金額(本位幣二)
                      IF g_glaa015='Y' THEN
                         IF g_glaa017='1' THEN
                            LET g_glaq_d[l_ac].amt2=g_glaq_d[l_ac].glaq010*g_glaq_d[l_ac].glaq039
                         ELSE
                            IF g_glaq_d[l_ac].glaq003 <> 0 THEN
                               LET g_glaq_d[l_ac].amt2=g_glaq_d[l_ac].glaq003*g_glaq_d[l_ac].glaq039
                            ELSE
                               LET g_glaq_d[l_ac].amt2=g_glaq_d[l_ac].glaq004*g_glaq_d[l_ac].glaq039
                            END IF
                         END IF
                         CALL s_num_round('1',g_glaq_d[l_ac].amt2,g_ooaj004_2) RETURNING g_glaq_d[l_ac].amt2
                      END IF
                      #金額(本位幣三)
                      IF g_glaa019='Y' THEN
                         IF g_glaa021='1' THEN
                            LET g_glaq_d[l_ac].amt3=g_glaq_d[l_ac].glaq010*g_glaq_d[l_ac].glaq042
                         ELSE
                            IF g_glaq_d[l_ac].glaq003 <> 0 THEN
                               LET g_glaq_d[l_ac].amt3=g_glaq_d[l_ac].glaq003*g_glaq_d[l_ac].glaq042
                            ELSE
                               LET g_glaq_d[l_ac].amt3=g_glaq_d[l_ac].glaq004*g_glaq_d[l_ac].glaq042
                            END IF
                         END IF
                         CALL s_num_round('1',g_glaq_d[l_ac].amt3,g_ooaj004_3) RETURNING g_glaq_d[l_ac].amt3
                      END IF
                      IF g_glaq_d[l_ac].glaq003 <> 0 THEN
                         CALL s_num_round('1',g_glaq_d[l_ac].glaq003,g_ooaj004) RETURNING g_glaq_d[l_ac].glaq003
                      ELSE
                         CALL s_num_round('1',g_glaq_d[l_ac].glaq004,g_ooaj004) RETURNING g_glaq_d[l_ac].glaq004
                      END IF
                      CALL s_num_round('1',g_glaq_d[l_ac].glaq010,g_ooaj004_o) RETURNING g_glaq_d[l_ac].glaq010
                  END IF
               END IF
            END IF
            #LET g_glap_m.glaq005_1 = g_glaq_d[l_ac].glaq005 
            #LET g_glap_m.glaq006_1 = g_glaq_d[l_ac].glaq006  
            LET g_glaq_d_o.* = g_glaq_d[l_ac].* #160824-00007#252 161220 By 08171 add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq005
            #add-point:ON CHANGE glaq005 name="input.g.page1.glaq005"
                                                
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq006
            #add-point:BEFORE FIELD glaq006 name="input.b.page1.glaq006"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq006
            
            #add-point:AFTER FIELD glaq006 name="input.a.page1.glaq006"
            DISPLAY BY NAME g_glaq_d[l_ac].glaq006
            IF NOT cl_null(g_glaq_d[l_ac].glaq006) THEN
               #IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_glaq_d[l_ac].glaq006 <> g_glaq_d_t.glaq006 OR cl_null(g_glaq_d_t.glaq006)))THEN  #160824-00007#252 161220 By 08171 mark
               IF g_glaq_d[l_ac].glaq006 != g_glaq_d_o.glaq006 OR cl_null(g_glaq_d_o.glaq006) THEN  #160824-00007#252 161220 By 08171 add
                  IF g_glaq_d[l_ac].glaq006 <=0 THEN    #161130-00019#1 mod  g_glaq_d[l_ac].glaq006 <0 ->  g_glaq_d[l_ac].glaq006 <=0
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'asf-00155'  #161130-00019#1 mod  aim-00009 -> asf-00155
                     LET g_errparam.extend = g_glaq_d[l_ac].glaq006
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                  
                    #LET g_glaq_d[l_ac].glaq006 = g_glaq_d_t.glaq006 #160824-00007#252 161220 By 08171 mark
                     LET g_glaq_d[l_ac].glaq006 = g_glaq_d_o.glaq006 #160824-00007#252 161220 By 08171 add
                     NEXT FIELD glaq006
                  END IF
                  
                  IF g_glaq_d[l_ac].glaq005 = g_glaa001 AND g_glaq_d[l_ac].glaq006 <> 1 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'agl-00327'
                     LET g_errparam.extend = g_glaq_d[l_ac].glaq006
                     LET g_errparam.popup = FALSE
                     CALL cl_err()
                  
                     LET g_glaq_d[l_ac].glaq006 = 1
                     NEXT FIELD glaq006
                  END IF
                              
                  LET l_glac008 = ''
                  SELECT glac008 INTO l_glac008 FROM glac_t
                   WHERE glacent = g_enterprise
                     AND glac001 = g_glaa004     #会计科目参照表号
                     AND glac002 = g_glaq_d[l_ac].glaq002
                   IF (l_cmd = 'a' AND (l_glac008 = '1' OR cl_null(l_glac008))) OR g_glaq_d[l_ac].glaq003 <> 0 THEN    #借
                      LET g_glaq_d[l_ac].glaq003 = g_glaq_d[l_ac].glaq006 *g_glaq_d[l_ac].glaq010 
                      #金額(本位幣二)
                      IF g_glaa015='Y' THEN
                         IF g_glaa017='1' THEN
                            LET g_glaq_d[l_ac].amt2=g_glaq_d[l_ac].glaq010*g_glaq_d[l_ac].glaq039
                         ELSE
                            LET g_glaq_d[l_ac].amt2=g_glaq_d[l_ac].glaq003*g_glaq_d[l_ac].glaq039
                         END IF
                         CALL s_num_round('1',g_glaq_d[l_ac].amt2,g_ooaj004_2) RETURNING g_glaq_d[l_ac].amt2
                      END IF
                      #金額(本位幣三)
                      IF g_glaa019='Y' THEN
                         IF g_glaa021='1' THEN
                            LET g_glaq_d[l_ac].amt3=g_glaq_d[l_ac].glaq010*g_glaq_d[l_ac].glaq042
                         ELSE
                            LET g_glaq_d[l_ac].amt3=g_glaq_d[l_ac].glaq003*g_glaq_d[l_ac].glaq042
                         END IF
                         CALL s_num_round('1',g_glaq_d[l_ac].amt3,g_ooaj004_3) RETURNING g_glaq_d[l_ac].amt3
                      END IF
                      CALL s_num_round('1',g_glaq_d[l_ac].glaq003,g_ooaj004) RETURNING g_glaq_d[l_ac].glaq003
                      IF g_glap001_p = '2' THEN #現收傳票，單身顯示貸方
                         LET g_glaq_d[l_ac].glaq004 = g_glaq_d[l_ac].glaq003
                         LET g_glaq_d[l_ac].glaq003 = 0
                      END IF
                   END IF
                   IF (l_cmd='a' AND l_glac008 = '2') OR g_glaq_d[l_ac].glaq004 <> 0  THEN    #贷
                      LET g_glaq_d[l_ac].glaq004 = g_glaq_d[l_ac].glaq006 * g_glaq_d[l_ac].glaq010
                      #金額(本位幣二)
                      IF g_glaa015='Y' THEN
                         IF g_glaa017='1' THEN
                            LET g_glaq_d[l_ac].amt2=g_glaq_d[l_ac].glaq010*g_glaq_d[l_ac].glaq039
                         ELSE
                            LET g_glaq_d[l_ac].amt2=g_glaq_d[l_ac].glaq003*g_glaq_d[l_ac].glaq039
                         END IF
                         CALL s_num_round('1',g_glaq_d[l_ac].amt2,g_ooaj004_2) RETURNING g_glaq_d[l_ac].amt2
                      END IF
                      #金額(本位幣三)
                      IF g_glaa019='Y' THEN
                         IF g_glaa021='1' THEN
                            LET g_glaq_d[l_ac].amt3=g_glaq_d[l_ac].glaq010*g_glaq_d[l_ac].glaq042
                         ELSE
                            LET g_glaq_d[l_ac].amt3=g_glaq_d[l_ac].glaq003*g_glaq_d[l_ac].glaq042
                         END IF
                         CALL s_num_round('1',g_glaq_d[l_ac].amt3,g_ooaj004_3) RETURNING g_glaq_d[l_ac].amt3
                      END IF
                      CALL s_num_round('1',g_glaq_d[l_ac].glaq004,g_ooaj004) RETURNING g_glaq_d[l_ac].glaq004
                      IF g_glap001_p = '3' THEN #現支傳票，單身顯示借方
                         LET g_glaq_d[l_ac].glaq003 = g_glaq_d[l_ac].glaq004
                         LET g_glaq_d[l_ac].glaq004 = 0
                      END IF
                   END IF
                   CALL s_num_round('1',g_glaq_d[l_ac].glaq010,g_ooaj004_o) RETURNING g_glaq_d[l_ac].glaq010
                   
               END IF     
            END IF          
            LET g_glaq_d_o.* = g_glaq_d[l_ac].* #160824-00007#252 161220 By 08171 add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq006
            #add-point:ON CHANGE glaq006 name="input.g.page1.glaq006"
                                                
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq010
            #add-point:BEFORE FIELD glaq010 name="input.b.page1.glaq010"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq010
            
            #add-point:AFTER FIELD glaq010 name="input.a.page1.glaq010"
            DISPLAY BY NAME g_glaq_d[l_ac].glaq010
            IF NOT cl_null(g_glaq_d[l_ac].glaq010) THEN
               #當傳票單別為紅字傳票時，金額可以輸入負數
               IF l_red = 'N' THEN 
                  IF g_glaq_d[l_ac].glaq010 < 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aim-00009'
                     LET g_errparam.extend = g_glaq_d[l_ac].glaq010
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                    #LET g_glaq_d[l_ac].glaq010 = g_glaq_d_t.glaq010 #160824-00007#252 161220 By 08171 mark
                     LET g_glaq_d[l_ac].glaq010 = g_glaq_d_o.glaq010 #160824-00007#252 161220 By 08171 add
                     NEXT FIELD glaq010
                  END IF   
               END IF
               #IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_glaq_d[l_ac].glaq010 <> g_glaq_d_t.glaq010 OR cl_null(g_glaq_d_t.glaq010)))THEN #160824-00007#252 161220 By 08171 mark
               IF g_glaq_d[l_ac].glaq010 != g_glaq_d_o.glaq010 OR cl_null(g_glaq_d_o.glaq010) THEN  #160824-00007#252 161220 By 08171 add
                  LET l_glac008 = ''
                  SELECT glac008 INTO l_glac008 FROM glac_t
                   WHERE glacent = g_enterprise
                     AND glac001 = g_glaa004     #会计科目参照表号
                     AND glac002 = g_glaq_d[l_ac].glaq002
                    
                  IF (l_cmd = 'a'  AND (l_glac008 = '1' OR cl_null(l_glac008))) OR g_glaq_d[l_ac].glaq003 <> 0 THEN    #借
                     LET g_glaq_d[l_ac].glaq003 = g_glaq_d[l_ac].glaq006 *g_glaq_d[l_ac].glaq010
                    #IF cl_null(g_glaq_d[l_ac].glaq003) THEN LET g_glaq_d[l_ac].glaq003 = 0 END IF
                     #金額(本位幣二)
                     IF g_glaa015='Y' THEN
                        IF g_glaa017='1' THEN
                           LET g_glaq_d[l_ac].amt2=g_glaq_d[l_ac].glaq010*g_glaq_d[l_ac].glaq039
                        ELSE
                           LET g_glaq_d[l_ac].amt2=g_glaq_d[l_ac].glaq003*g_glaq_d[l_ac].glaq039
                        END IF
                        CALL s_num_round('1',g_glaq_d[l_ac].amt2,g_ooaj004_2) RETURNING g_glaq_d[l_ac].amt2
                     END IF
                     #金額(本位幣三)
                     IF g_glaa019='Y' THEN
                        IF g_glaa021='1' THEN
                           LET g_glaq_d[l_ac].amt3=g_glaq_d[l_ac].glaq010*g_glaq_d[l_ac].glaq042
                        ELSE
                           LET g_glaq_d[l_ac].amt3=g_glaq_d[l_ac].glaq003*g_glaq_d[l_ac].glaq042
                        END IF
                        CALL s_num_round('1',g_glaq_d[l_ac].amt3,g_ooaj004_3) RETURNING g_glaq_d[l_ac].amt3
                     END IF
                     CALL s_num_round('1',g_glaq_d[l_ac].glaq003,g_ooaj004) RETURNING g_glaq_d[l_ac].glaq003
                     IF g_glap001_p = '2' THEN #現收傳票，單身顯示貸方
                        LET g_glaq_d[l_ac].glaq004 = g_glaq_d[l_ac].glaq003
                        LET g_glaq_d[l_ac].glaq003 = 0
                     END IF
                  END IF
                  IF (l_cmd = 'a' AND l_glac008 = '2') OR g_glaq_d[l_ac].glaq004 <> 0 THEN    #贷
                     LET g_glaq_d[l_ac].glaq004 = g_glaq_d[l_ac].glaq006 * g_glaq_d[l_ac].glaq010
                    #IF cl_null(g_glaq_d[l_ac].glaq003) THEN LET g_glaq_d[l_ac].glaq003 = 0 END IF
                     #金額(本位幣二)
                     IF g_glaa015='Y' THEN
                        IF g_glaa017='1' THEN
                           LET g_glaq_d[l_ac].amt2=g_glaq_d[l_ac].glaq010*g_glaq_d[l_ac].glaq039
                        ELSE
                           LET g_glaq_d[l_ac].amt2=g_glaq_d[l_ac].glaq003*g_glaq_d[l_ac].glaq039
                        END IF
                        CALL s_num_round('1',g_glaq_d[l_ac].amt2,g_ooaj004_2) RETURNING g_glaq_d[l_ac].amt2
                     END IF
                     #金額(本位幣三)
                     IF g_glaa019='Y' THEN
                        IF g_glaa021='1' THEN
                           LET g_glaq_d[l_ac].amt3=g_glaq_d[l_ac].glaq010*g_glaq_d[l_ac].glaq042
                        ELSE
                           LET g_glaq_d[l_ac].amt3=g_glaq_d[l_ac].glaq003*g_glaq_d[l_ac].glaq042
                        END IF
                        CALL s_num_round('1',g_glaq_d[l_ac].amt3,g_ooaj004_3) RETURNING g_glaq_d[l_ac].amt3
                     END IF
                     CALL s_num_round('1',g_glaq_d[l_ac].glaq004,g_ooaj004) RETURNING g_glaq_d[l_ac].glaq004
                     IF g_glap001_p = '3' THEN #現支傳票，單身顯示借方
                        LET g_glaq_d[l_ac].glaq003 = g_glaq_d[l_ac].glaq004
                        LET g_glaq_d[l_ac].glaq004 = 0
                     END IF
                  END IF 
               END IF  
               CALL s_num_round('1',g_glaq_d[l_ac].glaq010,g_ooaj004_o) RETURNING g_glaq_d[l_ac].glaq010               
            END IF
            LET g_glap_m.glaq010_1 = g_glaq_d[l_ac].glaq010 
            LET g_glaq_d_o.* = g_glaq_d[l_ac].* #160824-00007#252 161220 By 08171 add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq010
            #add-point:ON CHANGE glaq010 name="input.g.page1.glaq010"
                                                
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq003
            #add-point:BEFORE FIELD glaq003 name="input.b.page1.glaq003"
            #150827-00036#6--add--str--
            #每录入一行时预设借方金额=贷余=SUM(贷)-SUM(借)使每一次借贷金额平的
            CALL aglt310_default_amt('1')
            #150827-00036#6--add--end
            #备份借方金额
            LET l_glaq003_bak = g_glaq_d[l_ac].glaq003 
            IF (g_glaq_d[l_ac].glaq003 <> 0  OR g_glaq_d[l_ac].glaq004 <> 0) AND l_errcode = 'agl-00084' THEN
               ERROR ""
               LET l_errcode=''
            END IF
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq003
            
            #add-point:AFTER FIELD glaq003 name="input.a.page1.glaq003"
            DISPLAY BY NAME g_glaq_d[l_ac].glaq003
            #當傳票單別為紅字傳票時，金額可以輸入負數
            IF l_red = 'N' THEN 
               IF g_glaq_d[l_ac].glaq003 < 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aim-00009'
                  LET g_errparam.extend = g_glaq_d[l_ac].glaq003
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_glaq_d[l_ac].glaq003 = g_glaq_d_t.glaq003
                  NEXT FIELD glaq003
               END IF   
            END IF
            
            IF l_cmd = 'a' OR (l_cmd = 'u' AND 
               ( (g_glaq_d[l_ac].glaq003 <> g_glaq_d_t.glaq003) OR 
                 (NOT cl_null(g_glaq_d[l_ac].glaq003) AND cl_null(g_glaq_d_t.glaq003)) OR 
                 (cl_null(g_glaq_d[l_ac].glaq003) AND NOT cl_null(g_glaq_d_t.glaq003))
               )) THEN
               #外幣憑證勾選時, 若預設正常型態的金額後, 此筆希望在反項,
               IF g_glap_m.glap014 = 'Y' THEN
                  IF g_glaq_d[l_ac].glaq003 =0 OR cl_null(g_glaq_d[l_ac].glaq003) THEN
                     IF l_glaq003_bak<>g_glaq_d[l_ac].glaq003 THEN
                        LET g_glaq_d[l_ac].glaq004 = l_glaq003_bak
                        DISPLAY BY NAME g_glaq_d[l_ac].glaq004
                     END IF
                  END IF                    
               END IF 
               
               IF cl_null(g_glaq_d[l_ac].glaq003) THEN
                  LET g_glaq_d[l_ac].glaq003 = 0
               END IF
               
               #轉帳傳票，應計傳票，審計調整傳票时，借贷为0处理
               IF g_glap001_p MATCHES '[156]' THEN 
                  IF g_glaq_d[l_ac].glaq003 = 0  AND g_glaq_d[l_ac].glaq004=0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'agl-00084'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = FALSE
                     CALL cl_err()
                     LET l_errcode='agl-00084'
#                     NEXT FIELD glaq004
                  END IF
               END IF 
               #現支傳票传票时，借方金额不可为0 
               IF g_glap001_p = '3' THEN
                  IF g_glaq_d[l_ac].glaq003 = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'agl-00084'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = FALSE
                     CALL cl_err()
                     LET l_errcode='agl-00084'
#                     NEXT FIELD glaq003
                  END IF
               END IF 
            
               #如果借贷都有值的话，停在改栏位
               IF g_glaq_d[l_ac].glaq003 <> 0  AND g_glaq_d[l_ac].glaq004<>0 THEN  
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00048'
                  LET g_errparam.extend = g_glaq_d[l_ac].glaq003
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
               
                  NEXT FIELD glaq003
               END IF 
               IF g_glaq_d[l_ac].glaq003<>0 THEN
#                  LET g_glaq_d[l_ac].glaq010=g_glaq_d[l_ac].glaq003/g_glaq_d[l_ac].glaq006
                  #当没有勾选外币时原币金额=本币金额
                  IF g_glap_m.glap014 <> 'Y' OR g_glaq_d[l_ac].glaq005 = g_glaa001 THEN 
                     LET g_glaq_d[l_ac].glaq010 = g_glaq_d[l_ac].glaq003
                  END IF
                  LET g_glaq_d[l_ac].glaq006 = g_glaq_d[l_ac].glaq003/g_glaq_d[l_ac].glaq010
                  #金額(本位幣二)
                  IF g_glaa015='Y' THEN
                     IF g_glaa017='1' THEN
                        LET g_glaq_d[l_ac].amt2=g_glaq_d[l_ac].glaq010*g_glaq_d[l_ac].glaq039
                     ELSE
                        LET g_glaq_d[l_ac].amt2=g_glaq_d[l_ac].glaq003*g_glaq_d[l_ac].glaq039
                     END IF
                     CALL s_num_round('1',g_glaq_d[l_ac].amt2,g_ooaj004_2) RETURNING g_glaq_d[l_ac].amt2
                  END IF
                  #金額(本位幣三)
                  IF g_glaa019='Y' THEN
                     IF g_glaa021='1' THEN
                        LET g_glaq_d[l_ac].amt3=g_glaq_d[l_ac].glaq010*g_glaq_d[l_ac].glaq042
                     ELSE
                        LET g_glaq_d[l_ac].amt3=g_glaq_d[l_ac].glaq003*g_glaq_d[l_ac].glaq042
                     END IF
                     CALL s_num_round('1',g_glaq_d[l_ac].amt3,g_ooaj004_3) RETURNING g_glaq_d[l_ac].amt3
                  END IF
                  CALL s_num_round('1',g_glaq_d[l_ac].glaq003,g_ooaj004) RETURNING g_glaq_d[l_ac].glaq003
                  CALL s_num_round('1',g_glaq_d[l_ac].glaq010,g_ooaj004_o) RETURNING g_glaq_d[l_ac].glaq010
               END IF
               CALL aglt310_set_entry_b('')
               CALL aglt310_set_no_entry_b('')
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq003
            #add-point:ON CHANGE glaq003 name="input.g.page1.glaq003"
            IF g_glaq_d[l_ac].glaq003=0 OR cl_null(g_glaq_d[l_ac].glaq003) AND g_glap001_p<>'3' THEN
               CALL cl_set_comp_entry('glaq004',TRUE)
            ELSE
               CALL cl_set_comp_entry('glaq004',FALSE)            
            END IF 
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq004
            #add-point:BEFORE FIELD glaq004 name="input.b.page1.glaq004"
            #150827-00036#6--add--str--
            #每录入一行时预设贷方金额=借余=SUM(借)-SUM(贷)使每一次借贷金额平的
            CALL aglt310_default_amt('2')
            #150827-00036#6--add--end
            LET l_glaq004_bak = g_glaq_d[l_ac].glaq004
            IF (g_glaq_d[l_ac].glaq003 <> 0  OR g_glaq_d[l_ac].glaq004 <> 0) AND l_errcode = 'agl-00084' THEN
               ERROR ""
               LET l_errcode=''
            END IF
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq004
            
            #add-point:AFTER FIELD glaq004 name="input.a.page1.glaq004"
            DISPLAY BY NAME g_glaq_d[l_ac].glaq004
            #當傳票單別為紅字傳票時，金額可以輸入負數
            IF l_red = 'N' THEN 
               IF g_glaq_d[l_ac].glaq004 < 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aim-00009'
                  LET g_errparam.extend = g_glaq_d[l_ac].glaq004
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_glaq_d[l_ac].glaq004 = g_glaq_d_t.glaq004
                  NEXT FIELD glaq004
               END IF   
            END IF
            
            IF l_cmd = 'a' OR (l_cmd = 'u' AND 
               ( (g_glaq_d[l_ac].glaq004 <> g_glaq_d_t.glaq004) OR
                 (NOT cl_null(g_glaq_d[l_ac].glaq004) AND cl_null(g_glaq_d_t.glaq004)) OR
                 (cl_null(g_glaq_d[l_ac].glaq004) AND NOT cl_null(g_glaq_d_t.glaq004))
               )) THEN
               IF g_glap_m.glap014 = 'Y' THEN
                  IF g_glaq_d[l_ac].glaq004 =0 OR cl_null(g_glaq_d[l_ac].glaq004) THEN
                     IF l_glaq004_bak<>g_glaq_d[l_ac].glaq004 THEN
                        LET g_glaq_d[l_ac].glaq003 = l_glaq004_bak
                        DISPLAY BY NAME g_glaq_d[l_ac].glaq003
                     END IF
                  END IF                    
               END IF 
             
               IF cl_null(g_glaq_d[l_ac].glaq004) THEN
                  LET g_glaq_d[l_ac].glaq004 = 0
               END IF
               
               #轉帳傳票，應計傳票，審計調整时，借贷为0处理
               IF g_glap001_p MATCHES '[156]' THEN 
                  IF g_glaq_d[l_ac].glaq003 = 0  AND g_glaq_d[l_ac].glaq004=0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'agl-00084'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = FALSE
                     CALL cl_err()
                     LET l_errcode='agl-00084'
#                     NEXT FIELD glaq003
                  END IF
               END IF 
               #現收傳票传票时，借方金额不可为0 
               IF g_glap001_p = '2' THEN
                  IF g_glaq_d[l_ac].glaq004 = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'agl-00084'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = FALSE
                     CALL cl_err()
                     LET l_errcode='agl-00084'
#                     NEXT FIELD glaq004
                  END IF
               END IF
               
               #如果借贷都有值的话，停在改栏位
               IF g_glaq_d[l_ac].glaq003 <> 0  AND g_glaq_d[l_ac].glaq004<>0 THEN  
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00048'
                  LET g_errparam.extend = g_glaq_d[l_ac].glaq004
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
               
                  NEXT FIELD glaq004
               END IF 
               IF g_glaq_d[l_ac].glaq004<>0 THEN
#                  LET g_glaq_d[l_ac].glaq010=g_glaq_d[l_ac].glaq004/g_glaq_d[l_ac].glaq006
                  #当没有勾选外币时原币金额=本币金额
                  IF g_glap_m.glap014 <> 'Y' OR g_glaq_d[l_ac].glaq005 = g_glaa001 THEN 
                     LET g_glaq_d[l_ac].glaq010 = g_glaq_d[l_ac].glaq004
                  END IF
                  LET g_glaq_d[l_ac].glaq006=g_glaq_d[l_ac].glaq004/g_glaq_d[l_ac].glaq010
                  #金額(本位幣二)
                  IF g_glaa015='Y' THEN
                     IF g_glaa017='1' THEN
                        LET g_glaq_d[l_ac].amt2=g_glaq_d[l_ac].glaq010*g_glaq_d[l_ac].glaq039
                     ELSE
                        LET g_glaq_d[l_ac].amt2=g_glaq_d[l_ac].glaq004*g_glaq_d[l_ac].glaq039
                     END IF
                     CALL s_num_round('1',g_glaq_d[l_ac].amt2,g_ooaj004_2) RETURNING g_glaq_d[l_ac].amt2
                  END IF
                  #金額(本位幣三)
                  IF g_glaa019='Y' THEN
                     IF g_glaa021='1' THEN
                        LET g_glaq_d[l_ac].amt3=g_glaq_d[l_ac].glaq010*g_glaq_d[l_ac].glaq042
                     ELSE
                        LET g_glaq_d[l_ac].amt3=g_glaq_d[l_ac].glaq004*g_glaq_d[l_ac].glaq042
                     END IF
                     CALL s_num_round('1',g_glaq_d[l_ac].amt3,g_ooaj004_3) RETURNING g_glaq_d[l_ac].amt3
                  END IF
                  CALL s_num_round('1',g_glaq_d[l_ac].glaq004,g_ooaj004) RETURNING g_glaq_d[l_ac].glaq004
                  CALL s_num_round('1',g_glaq_d[l_ac].glaq010,g_ooaj004_o) RETURNING g_glaq_d[l_ac].glaq010
                  CALL aglt310_set_entry_b('')
                  CALL aglt310_set_no_entry_b('')
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq004
            #add-point:ON CHANGE glaq004 name="input.g.page1.glaq004"
            IF g_glaq_d[l_ac].glaq004=0 OR cl_null(g_glaq_d[l_ac].glaq004) AND g_glap001_p<>'2' THEN
               CALL cl_set_comp_entry('glaq003',TRUE)
            ELSE
               CALL cl_set_comp_entry('glaq003',FALSE)            
            END IF  
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq039
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_glaq_d[l_ac].glaq039,"0","1","","","azz-00079",1) THEN
               NEXT FIELD glaq039
            END IF 
 
 
 
            #add-point:AFTER FIELD glaq039 name="input.a.page1.glaq039"
            IF NOT cl_null(g_glaq_d[l_ac].glaq039) THEN
               #161130-00019#1--add--s--
               IF g_glaq_d[l_ac].glaq039 <=0 THEN    
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'asf-00155'  
                  LET g_errparam.extend = g_glaq_d[l_ac].glaq039
                  LET g_errparam.popup = TRUE
                  CALL cl_err()              
                 #LET g_glaq_d[l_ac].glaq039 = g_glaq_d_t.glaq039 #160824-00007#252 161220 By 08171 mark
                  LET g_glaq_d[l_ac].glaq039 = g_glaq_d_o.glaq039 #160824-00007#252 161220 By 08171 add
                  NEXT FIELD glaq039                
               END IF               
               #161130-00019#1--add--e--
               #借方金額(本位幣二)
               IF g_glaa017='1' THEN            
                  LET g_glaq_d[l_ac].amt2=g_glaq_d[l_ac].glaq010*g_glaq_d[l_ac].glaq039
               ELSE
                  IF g_glaq_d[l_ac].glaq003<>0 THEN
                     LET g_glaq_d[l_ac].amt2=g_glaq_d[l_ac].glaq003*g_glaq_d[l_ac].glaq039
                  ELSE
                     LET g_glaq_d[l_ac].amt2=g_glaq_d[l_ac].glaq004*g_glaq_d[l_ac].glaq039
                  END IF
               END IF
               CALL s_num_round('1',g_glaq_d[l_ac].amt2,g_ooaj004_2) RETURNING g_glaq_d[l_ac].amt2
            END IF 
            LET g_glaq_d_o.* = g_glaq_d[l_ac].* #160824-00007#252 161220 By 08171 add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq039
            #add-point:BEFORE FIELD glaq039 name="input.b.page1.glaq039"
                                                
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq039
            #add-point:ON CHANGE glaq039 name="input.g.page1.glaq039"
                                                
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD amt2
            #add-point:BEFORE FIELD amt2 name="input.b.page1.amt2"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD amt2
            
            #add-point:AFTER FIELD amt2 name="input.a.page1.amt2"
            DISPLAY BY NAME g_glaq_d[l_ac].amt2
            IF NOT cl_null(g_glaq_d[l_ac].amt2) THEN 
               #當傳票單別為紅字傳票時，金額可以輸入負數
               IF l_red = 'N' THEN 
                  IF g_glaq_d[l_ac].amt2 < 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aim-00009'
                     LET g_errparam.extend = g_glaq_d[l_ac].amt2
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_glaq_d[l_ac].amt2 = g_glaq_d_t.amt2
                     NEXT FIELD amt2
                  END IF   
               END IF
               CALL s_num_round('1',g_glaq_d[l_ac].amt2,g_ooaj004_2) RETURNING g_glaq_d[l_ac].amt2
            END IF 
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE amt2
            #add-point:ON CHANGE amt2 name="input.g.page1.amt2"
                                                
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaq042
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_glaq_d[l_ac].glaq042,"0","1","","","azz-00079",1) THEN
               NEXT FIELD glaq042
            END IF 
 
 
 
            #add-point:AFTER FIELD glaq042 name="input.a.page1.glaq042"
            IF NOT cl_null(g_glaq_d[l_ac].glaq042) THEN
               #161130-00019#1--add--s--
               IF g_glaq_d[l_ac].glaq042 <=0 THEN    
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'asf-00155'  
                  LET g_errparam.extend = g_glaq_d[l_ac].glaq042
                  LET g_errparam.popup = TRUE
                  CALL cl_err()              
                 #LET g_glaq_d[l_ac].glaq042 = g_glaq_d_t.glaq042 #160824-00007#252 161220 By 08171 mark
                  LET g_glaq_d[l_ac].glaq042 = g_glaq_d_o.glaq042 #160824-00007#252 161220 By 08171 add
                  NEXT FIELD glaq042                
               END IF               
               #161130-00019#1--add--e--
               #借方金額(本位幣三)
               IF g_glaa021='1' THEN            
                  LET g_glaq_d[l_ac].amt3=g_glaq_d[l_ac].glaq010*g_glaq_d[l_ac].glaq042
               ELSE
                  IF g_glaq_d[l_ac].glaq003<>0 THEN
                     LET g_glaq_d[l_ac].amt3=g_glaq_d[l_ac].glaq003*g_glaq_d[l_ac].glaq042
                  ELSE
                     LET g_glaq_d[l_ac].amt3=g_glaq_d[l_ac].glaq004*g_glaq_d[l_ac].glaq042
                  END IF
               END IF
               CALL s_num_round('1',g_glaq_d[l_ac].amt3,g_ooaj004_3) RETURNING g_glaq_d[l_ac].amt3
            END IF 
            LET g_glaq_d_o.* = g_glaq_d[l_ac].* #160824-00007#252 161220 By 08171 add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaq042
            #add-point:BEFORE FIELD glaq042 name="input.b.page1.glaq042"
                                                
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaq042
            #add-point:ON CHANGE glaq042 name="input.g.page1.glaq042"
                                                
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD amt3
            #add-point:BEFORE FIELD amt3 name="input.b.page1.amt3"
                                                
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD amt3
            
            #add-point:AFTER FIELD amt3 name="input.a.page1.amt3"
            DISPLAY BY NAME g_glaq_d[l_ac].amt3
            IF NOT cl_null(g_glaq_d[l_ac].amt3) THEN
               #當傳票單別為紅字傳票時，金額可以輸入負數
               IF l_red = 'N' THEN 
                  IF g_glaq_d[l_ac].amt3< 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aim-00009'
                     LET g_errparam.extend = g_glaq_d[l_ac].amt3
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_glaq_d[l_ac].amt3 = g_glaq_d_t.amt3
                     NEXT FIELD amt3
                  END IF   
               END IF
               CALL s_num_round('1',g_glaq_d[l_ac].amt3,g_ooaj004_3) RETURNING g_glaq_d[l_ac].amt3
            END IF 

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE amt3
            #add-point:ON CHANGE amt3 name="input.g.page1.amt3"
                                                
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.glaqseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaqseq
            #add-point:ON ACTION controlp INFIELD glaqseq name="input.c.page1.glaqseq"
                                                
            #END add-point
 
 
         #Ctrlp:input.c.page1.glaqcomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaqcomp
            #add-point:ON ACTION controlp INFIELD glaqcomp name="input.c.page1.glaqcomp"
                                                
            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq001
            #add-point:ON ACTION controlp INFIELD glaq001 name="input.c.page1.glaq001"
                                                #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glaq_d[l_ac].glaq001             #給予default值 
            LET g_qryparam.where = " ( oocq004 = '",g_glap_m.glapcomp,"' OR oocq004 IS NULL) " #161111-00049#4 add
            #給予arg
            CALL q_oocq002_2()                                #呼叫開窗

            LET g_glaq_d[l_ac].glaq001 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_glaq_d[l_ac].glaq001 TO glaq001              #顯示到畫面上

            NEXT FIELD glaq001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq002
            #add-point:ON ACTION controlp INFIELD glaq002 name="input.c.page1.glaq002"
                                                #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glaq_d[l_ac].glaq002             #給予default值

            #給予arg
            IF g_glap001_p <>'6' THEN #160517-00001#3 add
            LET g_qryparam.where = "glac001 = '",g_glaa004,"' AND  glac003 <>'1' AND glac006 = '1'",
                                   #151117-00009#1--add--str--
                                   " AND glac002 IN (SELECT glad001 FROM glad_t ",
                                   "                  WHERE gladent=",g_enterprise," AND gladld='",g_glap_m.glapld,"'",
                                   "                    AND glad035='N' AND gladstus='Y' )"
                                   #151117-00009#1--add--end
            #160517-00001#3--add--str--
            ELSE
               LET g_qryparam.where = "glac001 = '",g_glaa004,"' AND  glac003 <>'1' AND glac006 = '1'",
                                      " AND glac002 IN (SELECT glad001 FROM glad_t ",
                                      "                  WHERE gladent=",g_enterprise," AND gladld='",g_glap_m.glapld,"'",
                                      "                    AND gladstus='Y' )"
            END IF
            #160517-00001#3--add--end
            CALL aglt310_04()                                #呼叫開窗

            LET g_glaq_d[l_ac].glaq002 = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_glaq_d[l_ac].glaq002 TO glaq002              #顯示到畫面上
            LET g_qryparam.where = ""
            NEXT FIELD glaq002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.lc_subject
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD lc_subject
            #add-point:ON ACTION controlp INFIELD lc_subject name="input.c.page1.lc_subject"
                                                             #add-point:ON ACTION controlp INFIELD glaq002
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'
            LET g_qryparam.default1 = g_glaq_d[l_ac].lc_subject             #給予default值

            #給予arg
           #LET g_qryparam.where = "glac001 = '",g_glaa004,"' AND  glac003 <>'1' AND glac006 = '1' " #150827-00036#7 mark
            IF g_glap001_p <>'6' THEN #160517-00001#3 add
            LET g_qryparam.where = "glac001 = '",g_glaa004,"' AND  glac003 <>'1' AND glac006 = '1' ",
                                   #150827-00036#7--add--str--
                                   " AND glac002 IN (SELECT glad001 FROM glad_t ",
                                   "                  WHERE gladent = '",g_enterprise,"' AND gladld ='",g_glap_m.glapld,"'",
                                   "                    AND glad035 = 'N' AND gladstus = 'Y' )"  
                                   #150827-00036#7--add--end
            #160517-00001#3--add--str--
            ELSE
               LET g_qryparam.where = "glac001 = '",g_glaa004,"' AND  glac003 <>'1' AND glac006 = '1'",
                                      " AND glac002 IN (SELECT glad001 FROM glad_t ",
                                      "                  WHERE gladent=",g_enterprise," AND gladld='",g_glap_m.glapld,"'",
                                      "                    AND gladstus='Y' )"
            END IF
            #160517-00001#3--add--end
            CALL aglt310_04()                                #呼叫開窗

            LET g_glaq_d[l_ac].lc_subject = g_qryparam.return1              #將開窗取得的值回傳到變數
            LET g_glaq_d[l_ac].glaq002 = g_qryparam.return1
            DISPLAY g_glaq_d[l_ac].lc_subject TO lc_subject              #顯示到畫面上
            LET g_qryparam.where = ""
            NEXT FIELD lc_subject                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq005
            #add-point:ON ACTION controlp INFIELD glaq005 name="input.c.page1.glaq005"
                                                #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'
            LET g_qryparam.default1 = g_glaq_d[l_ac].glaq005             #給予default值

            #給予arg

            CALL q_ooai001()                                #呼叫開窗

            LET g_glaq_d[l_ac].glaq005 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_glaq_d[l_ac].glaq005 TO glaq005              #顯示到畫面上

            NEXT FIELD glaq005                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq006
            #add-point:ON ACTION controlp INFIELD glaq006 name="input.c.page1.glaq006"
                                                
            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq010
            #add-point:ON ACTION controlp INFIELD glaq010 name="input.c.page1.glaq010"
                                                
            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq003
            #add-point:ON ACTION controlp INFIELD glaq003 name="input.c.page1.glaq003"
                                                
            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq004
            #add-point:ON ACTION controlp INFIELD glaq004 name="input.c.page1.glaq004"
                                                
            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq039
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq039
            #add-point:ON ACTION controlp INFIELD glaq039 name="input.c.page1.glaq039"
                                                
            #END add-point
 
 
         #Ctrlp:input.c.page1.amt2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD amt2
            #add-point:ON ACTION controlp INFIELD amt2 name="input.c.page1.amt2"
                                                
            #END add-point
 
 
         #Ctrlp:input.c.page1.glaq042
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaq042
            #add-point:ON ACTION controlp INFIELD glaq042 name="input.c.page1.glaq042"
                                                
            #END add-point
 
 
         #Ctrlp:input.c.page1.amt3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD amt3
            #add-point:ON ACTION controlp INFIELD amt3 name="input.c.page1.amt3"
                                                
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_glaq_d[l_ac].* = g_glaq_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aglt310_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_glaq_d[l_ac].glaqseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_glaq_d[l_ac].* = g_glaq_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               #150703-00021#24 ---s---
               IF s_transaction_chk("N",0) THEN
                  CALL s_transaction_begin()
               END IF
               #150703-00021#24 ---e---  
               #借贷金额都为0，跳到借方栏位
               IF g_glaq_d[l_ac].glaq003 = 0  AND g_glaq_d[l_ac].glaq004 = 0  THEN
                  IF g_glap_m.glap014 = 'Y' THEN
                     NEXT FIELD glaq005
                  END IF 
                  IF g_glap001_p = '2' THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = 'agl-00084'
                      LET g_errparam.extend = ''
                      LET g_errparam.popup = FALSE
                      CALL cl_err()
                      LET l_errcode='agl-00084'
                      NEXT FIELD glaq004
                  ELSE
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = 'agl-00084'
                      LET g_errparam.extend = ''
                      LET g_errparam.popup = FALSE
                      CALL cl_err()
                      LET l_errcode='agl-00084'
                      NEXT FIELD glaq003               
                  END IF                                  
               END IF 
               CALL s_ld_chk_authorization(g_user,g_glap_m.glapld) RETURNING l_pass
               IF l_pass = FALSE THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00164'
                  LET g_errparam.extend = g_glap_m.glapld
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_glaq_d[l_ac].* = g_glaq_d_t.*
                  CLOSE aglt310_bcl
                  CALL s_transaction_end('N','0')
                  EXIT DIALOG          
               END IF
              
               #金额为空的话，给0   
               IF cl_null(g_glaq_d[l_ac].glaq003) THEN
                  LET g_glaq_d[l_ac].glaq003 = 0
               END IF 
                IF cl_null(g_glaq_d[l_ac].glaq004) THEN
                  LET g_glaq_d[l_ac].glaq004 = 0
               END IF
               IF g_glaq_d[l_ac].glaq003<>0 THEN
                  LET g_glaq_d[l_ac].glaq040=g_glaq_d[l_ac].amt2
                  LET g_glaq_d[l_ac].glaq041=0
                  LET g_glaq_d[l_ac].glaq043=g_glaq_d[l_ac].amt3
                  LET g_glaq_d[l_ac].glaq044=0
               ELSE
                  LET g_glaq_d[l_ac].glaq040=0
                  LET g_glaq_d[l_ac].glaq041=g_glaq_d[l_ac].amt2
                  LET g_glaq_d[l_ac].glaq043=0
                  LET g_glaq_d[l_ac].glaq044=g_glaq_d[l_ac].amt3
               END IF
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL aglt310_glaq_t_mask_restore('restore_mask_o')
      
               UPDATE glaq_t SET (glaqld,glaqdocno,glaqseq,glaqcomp,glaq001,glaq002,glaq005,glaq006, 
                   glaq010,glaq003,glaq004,glaq039,glaq040,glaq041,glaq042,glaq043,glaq044) = (g_glap_m.glapld, 
                   g_glap_m.glapdocno,g_glaq_d[l_ac].glaqseq,g_glaq_d[l_ac].glaqcomp,g_glaq_d[l_ac].glaq001, 
                   g_glaq_d[l_ac].glaq002,g_glaq_d[l_ac].glaq005,g_glaq_d[l_ac].glaq006,g_glaq_d[l_ac].glaq010, 
                   g_glaq_d[l_ac].glaq003,g_glaq_d[l_ac].glaq004,g_glaq_d[l_ac].glaq039,g_glaq_d[l_ac].glaq040, 
                   g_glaq_d[l_ac].glaq041,g_glaq_d[l_ac].glaq042,g_glaq_d[l_ac].glaq043,g_glaq_d[l_ac].glaq044) 
 
                WHERE glaqent = g_enterprise AND glaqld = g_glap_m.glapld 
                  AND glaqdocno = g_glap_m.glapdocno 
 
                  AND glaqseq = g_glaq_d_t.glaqseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
                                                            
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_glaq_d[l_ac].* = g_glaq_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "glaq_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_glaq_d[l_ac].* = g_glaq_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "glaq_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_glap_m.glapld
               LET gs_keys_bak[1] = g_glapld_t
               LET gs_keys[2] = g_glap_m.glapdocno
               LET gs_keys_bak[2] = g_glapdocno_t
               LET gs_keys[3] = g_glaq_d[g_detail_idx].glaqseq
               LET gs_keys_bak[3] = g_glaq_d_t.glaqseq
               CALL aglt310_update_b('glaq_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL aglt310_glaq_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_glaq_d[g_detail_idx].glaqseq = g_glaq_d_t.glaqseq 
 
                  ) THEN
                  LET gs_keys[01] = g_glap_m.glapld
                  LET gs_keys[gs_keys.getLength()+1] = g_glap_m.glapdocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_glaq_d_t.glaqseq
 
                  CALL aglt310_key_update_b(gs_keys,'glaq_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_glap_m),util.JSON.stringify(g_glaq_d_t)
               LET g_log2 = util.JSON.stringify(g_glap_m),util.JSON.stringify(g_glaq_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
#               #將離開科目欄位后的业务咨询/固定核算项 insert進DB
#               CALL aglt310_update_forzen() RETURNING l_success
#               IF l_success = FALSE THEN
#                  CALL s_transaction_end('N','0')
#               END IF
               #更新成功后異動相關的細項立沖賬資料
               IF g_glap001_p MATCHES '[123]' AND SQLCA.sqlcode=0 AND SQLCA.sqlerrd[3]>0 THEN
                  CALL aglt310_update_glax_and_glay()
               END IF
               
               #150703-00021#24 ---s--- 修改bgbd_t                             
               #檢查是否適用預算科目 
               CALL s_aooi200_fin_get_slip(g_glap_m.glapdocno) RETURNING g_sub_success,g_ap_slip
               CALL s_fin_get_doc_para(g_glap_m.glapld,g_glap_m.glapcomp,g_ap_slip,'D-FIN-5002') RETURNING g_dfin5002
               #IF g_dfin5002 = 'Y' AND g_glap_m.glap008 = 'P10' THEN #161003-00014#15
               IF g_glap_m.glap007 = 'GL' THEN #170116-00074#5 add
                  IF g_dfin5002 = 'Y' AND cl_null(g_glap_m.glap008) THEN #161003-00014#15
                     CALL s_aapp330_bgbd_upd(g_glap_m.glapdocno,g_glap_m.glapld,g_glaq_d[g_detail_idx].glaqseq,'','1') RETURNING g_sub_success,g_errno
                     IF NOT g_sub_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = g_glaq_d[g_detail_idx].glaq002
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        CALL s_transaction_end('N','0')
                        NEXT FIELD CURRENT
                     END IF  
                     
                     #刪除舊的bgbd_t/釋放額度
                     DELETE FROM bgbd_t 
                      WHERE bgbdent = g_enterprise
                        AND bgbd037 = g_glap_m.glapdocno
                        AND bgbd038 = g_glaq_d_t.glaqseq
                     #預算額度是否超過
                     CALL s_aapp330_bgbd_upd(g_glap_m.glapdocno,g_glap_m.glapld,g_glaq_d[g_detail_idx].glaqseq,'','2') RETURNING g_sub_success,g_errno
                     IF NOT g_sub_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = g_glaq_d[g_detail_idx].glaq002
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        CALL s_transaction_end('N','0')
                        NEXT FIELD CURRENT
                     END IF  
                    
                       #新增預算滾動檔
                     CALL s_aapp330_bgbd_upd(g_glap_m.glapdocno,g_glap_m.glapld,g_glaq_d[g_detail_idx].glaqseq,'I','3') RETURNING g_sub_success,g_errno
                     IF NOT g_sub_success THEN
                         INITIALIZE g_errparam TO NULL
                         LET g_errparam.code = g_errno
                         LET g_errparam.extend = g_glaq_d[g_detail_idx].glaq002
                         LET g_errparam.popup = TRUE
                         CALL cl_err()
                         CALL s_transaction_end('N','0')
                         NEXT FIELD CURRENT
                      END IF                                                             
                  END IF    
               END IF #170116-00074#5 add                  
               #150703-00021#24 ---e---    
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            #更新現金變動碼資料
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            #將離開科目欄位后的业务咨询/固定核算项 insert進DB
            CALL aglt310_update_forzen() RETURNING l_success
            IF l_success = FALSE THEN
               CALL s_transaction_end('N','0')
            END IF

            #维护现金变动码
            CALL aglt310_ins_upd_glbc() RETURNING l_success 
            IF l_success = FALSE THEN
               CALL s_transaction_end('N','0')                    
            END IF
           
            #170116-00016#2 --s add
            IF g_glap001_p MATCHES '[123]' THEN
               LET l_glad003 = ''
               LET l_glad004  = ''
               CALL aglt310_get_glad(g_glap_m.glapld,g_glaq_d[l_ac].glaq002) RETURNING l_glad003,l_glad004       
               IF l_glad003='Y' THEN
                  IF (l_glad004='1' AND g_glaq_d[l_ac].glaq003>0 ) OR
                     (l_glad004='2' AND g_glaq_d[l_ac].glaq004>0 ) THEN
                     LET l_cnt = 0
                     SELECT COUNT(1) INTO l_cnt FROM glax_t
                      WHERE glaxent = g_enterprise AND glaxld = g_glap_m.glapld 
                        AND glaxdocno = g_glap_m.glapdocno AND glaxseq = g_glaq_d[l_ac].glaqseq
                     IF l_cnt = 0 THEN
                        CALL aglt310_insert_glax() RETURNING l_success
                     END IF
                  END IF
               END IF
            END IF     
            #170116-00016#2 --s add             
           
#            CALL aglt310_b_fill()
            CALL aglt310_b_detail()
            #end add-point
            CALL aglt310_unlock_b("glaq_t","'1'")
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            #add-point:單身after_row2 name="input.body.after_row2"
            IF cl_null(g_glaq_d[l_ac].glaqseq) AND l_ac > 1 THEN
               LET l_ac=l_ac - 1
               CALL g_glaq_d.deleteElement(l_ac+1)
            END IF
            
            #151223-00004#1--add--str--lujh
            CALL s_voucher_glac016_get(g_glaa004,g_glaq_d[l_ac].glaq002) RETURNING l_glac016

#            IF g_glap_m.glap007 = 'GL' AND l_glac016 = 'Y'  AND g_glaa122 = 'Y'  THEN  #160805-00022#1 mark
            IF (g_glap_m.glap007 = 'GL'OR g_glap_m.glap007 = 'ZT') AND l_glac016 = 'Y'  AND g_glaa122 = 'Y'  THEN #160805-00022#1 add 账套复制传票
               IF cl_null(g_glap_m.glaq014) OR cl_null(g_glap_m.glaq015) OR cl_null(g_glap_m.glaq016) THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00417'
                  LET g_errparam.extend = g_glaq_d[l_ac].glaq002
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD glaq001
               END IF
            END IF
            #151223-00004#1--add--end--lujh
            #end add-point
              
         AFTER INPUT
            #add-point:input段after input  name="input.body.after_input"
            CALL aglt310_subject_fix_chk()
            #end add-point 
    
         ON ACTION controlo    
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_glaq_d[li_reproduce_target].* = g_glaq_d[li_reproduce].*
 
               LET g_glaq_d[li_reproduce_target].glaqseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_glaq_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_glaq_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
 
 
 
 
{</section>}
 
{<section id="aglt310.input.other" >}
      
      #add-point:自定義input name="input.more_input"
#      ON ACTION CONTROLB
#         CALL aglt310_fix_acc()       
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
                                             IF p_cmd = 'a' THEN
            NEXT FIELD glapdocno
         END IF
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1',"))      
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            
            #end add-point  
            NEXT FIELD glapld
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD glaqseq
 
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
   LET g_flag_input = FALSE #标示不在input录入状态  
   #當取消操作時同步回滾細項沖帳沖帳
#   IF INT_FLAG AND l_flag=FALSE THEN
   IF INT_FLAG THEN
      CALL s_transaction_end('N','0')
   END IF 
   
   #161009-00002#1--add--str--
   #如果单头取消，则不需执行下面检核操作
   SELECT COUNT(1) INTO l_cnt #161205-00025#4 mod '*'-->1
    FROM glap_t
   WHERE glapent = g_enterprise
     AND glapld = g_glap_m.glapld
     AND glapdocno = g_glap_m.glapdocno
     AND glap001 = g_glap_m.glap001
   IF l_cnt = 0 THEN
      RETURN
   END IF 
   #161009-00002#1--add--end

   #现收现支时插入一笔项次为0，科目为单头科目，金额为金额汇总的资料
   IF g_glap001_p = '2' OR g_glap001_p = '3' THEN
      CALL aglt310_glap001_2(g_glap001_p)
   ELSE
      CALL aglt310_glap001_1(g_glap001_p)
   END IF
   
   CALL aglt310_cashflow() #150827-00036#14 unmark

   #单身存盘及确认时应判断, 营运组织核算项若为核算组织(ooef204='Y'),则本张凭证以该组织角度来看应借贷平衡
   CALL cl_err_collect_init() 
   LET l_success = TRUE
#   LET g_sql = " SELECT DISTINCT glaq017 FROM glaq_t ", #161205-00025#4 mark
   #161205-00025#4--add--str--
   LET g_sql = " SELECT glaq017,SUM(glaq003),SUM(glaq004),SUM(glaq040),SUM(glaq041),SUM(glaq043),SUM(glaq044)",
               "   FROM glaq_t ",
   #161205-00025#4--add--end
               "  WHERE glaqent = ",g_enterprise,"",
               "    AND glaqld = '",g_glap_m.glapld,"'",
               "    AND glaqdocno = '",g_glap_m.glapdocno,"'",
               "    AND glaq017 IN (SELECT ooef001 FROM ooef_t WHERE ooefent = ",g_enterprise," AND ooef204 = 'Y')"  
              ,"  GROUP BY glaq017 " #161205-00025#4 add
   PREPARE aglt310_glaq017_pre  FROM g_sql
   DECLARE aglt310_glaq017_cs CURSOR FOR aglt310_glaq017_pre
   FOREACH aglt310_glaq017_cs INTO l_glaq017
                                  ,l_sum1,l_sum2,l_sum3,l_sum4,l_sum5,l_sum6 #161205-00025#4 add
       IF SQLCA.SQLCODE THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = sqlca.sqlcode
          LET g_errparam.extend = ''
          LET g_errparam.popup = FALSE
          CALL cl_err()

          EXIT FOREACH
       END IF
#161205-00025#4--mark--str--
#       LET l_sum1 = 0 
#       LET l_sum2 = 0
#       SELECT SUM(glaq003),SUM(glaq004),SUM(glaq040),SUM(glaq041),SUM(glaq043),SUM(glaq044)
#         INTO l_sum1,l_sum2,l_sum3,l_sum4,l_sum5,l_sum6
#         FROM glaq_t
#        WHERE glaqent = g_enterprise
#          AND glaqld = g_glap_m.glapld
#          AND glaqdocno = g_glap_m.glapdocno 
#          AND glaq017 = l_glaq017
#161205-00025#4--mark--end
       IF l_sum1<>l_sum2 THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = 'agl-00166'
          LET g_errparam.extend = l_glaq017
          LET g_errparam.popup = TRUE
          CALL cl_err()
          LET l_success = FALSE
       END IF
       IF g_glaa015='Y' AND l_sum3<>l_sum4 THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = 'agl-00225'
          LET g_errparam.extend = l_glaq017
          LET g_errparam.popup = TRUE
          CALL cl_err()
          LET l_success = FALSE
       END IF
       IF g_glaa019='Y' AND l_sum5<>l_sum6 THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = 'agl-00226'
          LET g_errparam.extend = l_glaq017
          LET g_errparam.popup = TRUE
          CALL cl_err()
          LET l_success = FALSE
       END IF
   END FOREACH
   IF l_success = FALSE THEN
      CALL cl_err_collect_show()
      CALL aglt310_input('u')
   ELSE
      CALL cl_err_collect_init()
      CALL cl_err_collect_show()
   END IF
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="aglt310.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION aglt310_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   DEFINE l_glaq002    LIKE type_t.chr300
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   #外币凭证否勾选，单身显示币别，汇率，原币金额
   IF g_glap_m.glap014 = 'Y' THEN
      CALL cl_set_comp_visible('glaq005,glaq006,glaq010',TRUE)
   ELSE
      CALL cl_set_comp_visible('glaq005,glaq006,glaq010',FALSE) 
   END IF
   #如果状态不为开立，则删除修改按钮灰掉
   #160308-00010#25-S
   #IF g_glap_m.glapstus <>'N' THEN
   #   CALL cl_set_act_visible('modify,modify_detail,delete',FALSE)
   #ELSE
   #   CALL cl_set_act_visible('modify,modify_detail,delete',TRUE)  
   #END IF
   #160308-00010#25-E
   CALL aglt310_glapld_desc(g_glap_m.glapld)
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL aglt310_b_fill() #單身填充
      CALL aglt310_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL aglt310_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
                        

#            #营运据点
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_glap_m.glaq017
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_glap_m.glaq017_desc =  g_rtn_fields[1] 
#            DISPLAY BY NAME g_glap_m.glaq017_desc
#            #部门
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_glap_m.glaq018
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_glap_m.glaq018_desc =  g_rtn_fields[1]
#            DISPLAY BY NAME g_glap_m.glaq018_desc
#            #成本利润中心
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_glap_m.glaq019
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_glap_m.glaq019_desc =  g_rtn_fields[1]
#            DISPLAY BY NAME g_glap_m.glaq019_desc
#            #区域 
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = '287'
#            LET g_ref_fields[2] = g_glap_m.glaq020
#            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=? AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_glap_m.glaq020_desc =  g_rtn_fields[1]
#            DISPLAY BY NAME g_glap_m.glaq020_desc 
#
#            #交易客商
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_glap_m.glaq021
#            CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_glap_m.glaq021_desc = g_rtn_fields[1]
#            DISPLAY BY NAME g_glap_m.glaq021_desc
#            #帐款客商
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_glap_m.glaq022
#            CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_glap_m.glaq022_desc = g_rtn_fields[1]
#            DISPLAY BY NAME g_glap_m.glaq022_desc
#            #客群
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = '281'
#            LET g_ref_fields[2] = g_glap_m.glaq023
#            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=? AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_glap_m.glaq023_desc =  g_rtn_fields[1]
#            DISPLAY BY NAME g_glap_m.glaq023_desc 
#            
#            #产品分类
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_glap_m.glaq024
#            CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_glap_m.glaq024_desc = g_rtn_fields[1]
#            DISPLAY BY NAME g_glap_m.glaq024_desc
#            
#            #人员
#            LET g_glap_m.glaq025_desc = ''
#            CALL aglt310_glaq013_desc(g_glap_m.glaq025) RETURNING g_glap_m.glaq025_desc
#            DISPLAY BY NAME g_glap_m.glaq025_desc
#            
#            #预算编号
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_glap_m.glaq026
#            CALL ap_ref_array2(g_ref_fields,"SELECT bgaal003 FROM bgaal_t WHERE bgaalent='"||g_enterprise||"' AND bgaal001=? AND bgaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_glap_m.glaq026_desc = g_rtn_fields[1]
#            DISPLAY BY NAME g_glap_m.glaq026_desc
   LET g_glap_m.post = g_glap_m.glappstid_desc
   LET g_glap_m.conf = g_glap_m.glapcnfid_desc
   LET g_glap_m.creat = g_glap_m.glapcrtid_desc
   #160805-00022#1--add--str--
   IF g_glap_m.glap007='ZT' THEN
      CALL cl_set_comp_visible("grid_20",TRUE)
   ELSE
      CALL cl_set_comp_visible("grid_20",FALSE)
   END IF
   #160805-00022#1--add--end
   #end add-point
   
   #遮罩相關處理
   LET g_glap_m_mask_o.* =  g_glap_m.*
   CALL aglt310_glap_t_mask()
   LET g_glap_m_mask_n.* =  g_glap_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_glap_m.glapld,g_glap_m.glapld_desc,g_glap_m.glapcomp,g_glap_m.glapcomp_desc,g_glap_m.glaa001_desc, 
       g_glap_m.glaa016,g_glap_m.glaa020,g_glap_m.glap001,g_glap_m.glapdocno,g_glap_m.glapdocdt,g_glap_m.glap002, 
       g_glap_m.glap004,g_glap_m.glap007,g_glap_m.glap008,g_glap_m.glap010,g_glap_m.glap011,g_glap_m.glap006, 
       g_glap_m.glap006_desc,g_glap_m.glap015,g_glap_m.glap013,g_glap_m.glap009,g_glap_m.sdocno,g_glap_m.glap016, 
       g_glap_m.glap016_desc,g_glap_m.glap017,g_glap_m.glap012,g_glap_m.glap014,g_glap_m.glapstus,g_glap_m.glapownid, 
       g_glap_m.glapownid_desc,g_glap_m.glapcrtdp,g_glap_m.glapcrtdp_desc,g_glap_m.glapowndp,g_glap_m.glapowndp_desc, 
       g_glap_m.glapcrtdt,g_glap_m.glapcrtid,g_glap_m.glapcrtid_desc,g_glap_m.glapmodid,g_glap_m.glapmodid_desc, 
       g_glap_m.glapmoddt,g_glap_m.glapcnfid,g_glap_m.glapcnfid_desc,g_glap_m.glapcnfdt,g_glap_m.glappstid, 
       g_glap_m.glappstid_desc,g_glap_m.glappstdt,g_glap_m.glaq017,g_glap_m.glaq017_desc,g_glap_m.glaq018, 
       g_glap_m.glaq018_desc,g_glap_m.glaq019,g_glap_m.glaq019_desc,g_glap_m.glaq020,g_glap_m.glaq020_desc, 
       g_glap_m.glaq021,g_glap_m.glaq021_desc,g_glap_m.glaq022,g_glap_m.glaq022_desc,g_glap_m.glaq023, 
       g_glap_m.glaq023_desc,g_glap_m.glaq024,g_glap_m.glaq024_desc,g_glap_m.glbc004,g_glap_m.glbc004_desc, 
       g_glap_m.glaq051,g_glap_m.glaq052,g_glap_m.glaq052_desc,g_glap_m.glaq053,g_glap_m.glaq053_desc, 
       g_glap_m.glaq025,g_glap_m.glaq025_desc,g_glap_m.glaq027,g_glap_m.glaq027_desc,g_glap_m.glaq028, 
       g_glap_m.glaq028_desc,g_glap_m.glaq029,g_glap_m.glaq029_desc,g_glap_m.glaq030,g_glap_m.glaq030_desc, 
       g_glap_m.glaq031,g_glap_m.glaq031_desc,g_glap_m.glaq032,g_glap_m.glaq032_desc,g_glap_m.glaq033, 
       g_glap_m.glaq033_desc,g_glap_m.glaq034,g_glap_m.glaq034_desc,g_glap_m.glaq035,g_glap_m.glaq035_desc, 
       g_glap_m.glaq036,g_glap_m.glaq036_desc,g_glap_m.glaq037,g_glap_m.glaq037_desc,g_glap_m.glaq038, 
       g_glap_m.glaq038_desc,g_glap_m.glaq005_1,g_glap_m.glaq006_1,g_glap_m.glaq010_1,g_glap_m.glaq007, 
       g_glap_m.glaq008,g_glap_m.glaq009,g_glap_m.glaq011,g_glap_m.glaq012,g_glap_m.glaq013,g_glap_m.glaq013_desc, 
       g_glap_m.glaq014,g_glap_m.glaq015,g_glap_m.glaq015_desc,g_glap_m.glaq016,g_glap_m.glaq016_desc, 
       g_glap_m.conf,g_glap_m.post,g_glap_m.creat
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_glap_m.glapstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "S"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/posted.png")
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
   FOR l_ac = 1 TO g_glaq_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      #抓取原来的核算项来组合科目栏位
#      CALL aglt310_subject() #161205-00025#4 mark
      #end add-point
   END FOR
   
 
   
    
   
   #add-point:show段other name="show.other"
            
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL aglt310_detail_show()
 
   #add-point:show段之後 name="show.after"
   #151201-00004#1--add--str--
   #顯示來源單號
   CALL aglt310_07(g_glap_m.glapld,g_glap_m.glapdocno,1) RETURNING g_glap_m.sdocno
   DISPLAY BY NAME g_glap_m.sdocno
   #151201-00004#1--mod--end
   
   #重新抓取单身冻结部分显示
   IF cl_null(g_detail_idx) THEN 
      LET g_detail_idx=1
   END IF      
   CALL aglt310_b_detail()
   IF (g_glap_m.glap007 = 'GL' AND (g_glap_m.glap008 <> 'TH' OR cl_null(g_glap_m.glap008)))  
      OR g_glap_m.glap007 = 'ZT'  #160805-00022#1 add
      OR g_glap_m.glap007 = 'CR'  OR g_glap_m.glap007 = 'CD'  
      OR g_glap_m.glap007 = 'AC'  OR g_glap_m.glap007 = 'AD'  THEN
      CALL cl_set_toolbaritem_visible('open_aglt310_07',FALSE)
   ELSE
      CALL cl_set_toolbaritem_visible('open_aglt310_07',TRUE)
   END IF   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aglt310.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION aglt310_detail_show()
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
 
{<section id="aglt310.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION aglt310_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE glap_t.glapld 
   DEFINE l_oldno     LIKE glap_t.glapld 
   DEFINE l_newno02     LIKE glap_t.glapdocno 
   DEFINE l_oldno02     LIKE glap_t.glapdocno 
 
   DEFINE l_master    RECORD LIKE glap_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE glaq_t.* #此變數樣板目前無使用
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_date      LIKE glap_t.glapdocdt
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
   
   IF g_glap_m.glapld IS NULL
   OR g_glap_m.glapdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_glapld_t = g_glap_m.glapld
   LET g_glapdocno_t = g_glap_m.glapdocno
 
    
   LET g_glap_m.glapld = ""
   LET g_glap_m.glapdocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_glap_m.glapownid = g_user
      LET g_glap_m.glapowndp = g_dept
      LET g_glap_m.glapcrtid = g_user
      LET g_glap_m.glapcrtdp = g_dept 
      LET g_glap_m.glapcrtdt = cl_get_current()
      LET g_glap_m.glapmodid = g_user
      LET g_glap_m.glapmoddt = cl_get_current()
      LET g_glap_m.glapstus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
#170117-00064#1--mark--str--
#   #170103-00019#1--add--str--
#   #复制时，如果有细项立冲科目，不允许复制，提示讯息
#   LET l_cnt = 0
#   SELECT COUNT(1) INTO l_cnt 
#     FROM glaq_t 
#     LEFT JOIN glad_t ON gladent=glaqent AND gladld=glaqld AND glad001=glaq002
#    WHERE glaqent=g_enterprise 
#      AND glaqld=g_glapld_t
#      AND glaqdocno=g_glapdocno_t
#      AND glad003='Y'
#   IF l_cnt > 0 THEN   
#      INITIALIZE g_errparam TO NULL
#      LET g_errparam.code = 'agl-00538'
#      LET g_errparam.extend = ''
#      LET g_errparam.popup = TRUE
#      CALL cl_err()
#      CALL s_transaction_end('N','0')
#      RETURN
#   END IF
#   #170103-00019#1--add--end
#170117-00064#1--mark--end      
   LET g_glap_m.glapld = g_glaald         
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_glap_m.glapstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "S"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/posted.png")
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
      LET g_glap_m.glapld_desc = ''
   DISPLAY BY NAME g_glap_m.glapld_desc
 
   
   CALL aglt310_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_glap_m.* TO NULL
      INITIALIZE g_glaq_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      LET g_glap_m.glapld = g_glaald #161009-00002#1 add
      #end add-point
      CALL aglt310_show()
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
   CALL aglt310_set_act_visible()   
   CALL aglt310_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_glapld_t = g_glap_m.glapld
   LET g_glapdocno_t = g_glap_m.glapdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " glapent = " ||g_enterprise|| " AND",
                      " glapld = '", g_glap_m.glapld, "' "
                      ," AND glapdocno = '", g_glap_m.glapdocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aglt310_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
            
   #end add-point
   
   CALL aglt310_idx_chk()
   
   LET g_data_owner = g_glap_m.glapownid      
   LET g_data_dept  = g_glap_m.glapowndp
   
   #功能已完成,通報訊息中心
   CALL aglt310_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="aglt310.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION aglt310_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE glaq_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
            
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE aglt310_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
            
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM glaq_t
    WHERE glaqent = g_enterprise AND glaqld = g_glapld_t
     AND glaqdocno = g_glapdocno_t
 
    INTO TEMP aglt310_detail
 
   #將key修正為調整後   
   UPDATE aglt310_detail 
      #更新key欄位
      SET glaqld = g_glap_m.glapld
          , glaqdocno = g_glap_m.glapdocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO glaq_t SELECT * FROM aglt310_detail
   
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
   DROP TABLE aglt310_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   #CREATE TEMP TABLE
   LET ls_sql = "CREATE GLOBAL TEMPORARY TABLE aglt310_detail AS ",
                "SELECT * FROM glbc_t "
   PREPARE repro_tbl_glbc FROM ls_sql
   EXECUTE repro_tbl_glbc
   FREE repro_tbl_glbc
                
   #將符合條件的資料丟入TEMP TABLE
   INSERT INTO aglt310_detail SELECT * FROM glbc_t 
                                         WHERE glbcent = g_enterprise AND glbcld = g_glapld_t
                                         AND glbcdocno = g_glapdocno_t AND glbc010 = '1' #GL總帳
   
   #將key修正為調整後   
   UPDATE aglt310_detail 
      #更新key欄位
      SET glbcld = g_glap_m.glapld,
          glbcdocno = g_glap_m.glapdocno,
          glbc001 = g_glap_m.glap002,
          glbc002 = g_glap_m.glap004
  
   #將資料塞回原table   
   INSERT INTO glbc_t SELECT * FROM aglt310_detail
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "reproduce glbc_t" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   #刪除TEMP TABLE
   DROP TABLE aglt310_detail
   
   #170117-00064#1--add--str--
   #复制glax_t
   #CREATE TEMP TABLE
   LET ls_sql = "CREATE GLOBAL TEMPORARY TABLE aglt310_detail AS ",
                "SELECT * FROM glax_t "
   PREPARE repro_tbl_glax FROM ls_sql
   EXECUTE repro_tbl_glax
   FREE repro_tbl_glax
                
   #將符合條件的資料丟入TEMP TABLE
   INSERT INTO aglt310_detail SELECT * FROM glax_t 
                              WHERE glaxent = g_enterprise AND glaxld = g_glapld_t
                              AND glaxdocno = g_glapdocno_t 
   
   #將key修正為調整後   
   UPDATE aglt310_detail 
      #更新key欄位
      SET glaxld = g_glap_m.glapld,
          glaxcomp = g_glap_m.glapcomp,
          glaxdocno = g_glap_m.glapdocno,
          glaxdocdt = g_glap_m.glapdocdt,
          glax041 = 0,
          glax042 = 0,
          glax043 = 0,
          glax044 = 0,
          glax045 = 0,
          glax046 = 0,
          glax047 = 1,
          glax048 = g_glap_m.glap015,
          glax049 = g_glap_m.glap002,
          glax050 = g_glap_m.glap004,          
          glax053 = 0,
          glax054 = 0,
          glax057 = 0,
          glax058 = 0,
          glaxstus = 'N'
  
   #將資料塞回原table   
   INSERT INTO glax_t SELECT * FROM aglt310_detail
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "reproduce glax_t" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   #刪除TEMP TABLE
   DROP TABLE aglt310_detail
   #170117-00064#1--add--end
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_glapld_t = g_glap_m.glapld
   LET g_glapdocno_t = g_glap_m.glapdocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="aglt310.delete" >}
#+ 資料刪除
PRIVATE FUNCTION aglt310_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point     
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   DEFINE l_pass           LIKE type_t.num5
   DEFINE l_sql            STRING
   DEFINE l_glaqseq        LIKE glaq_t.glaqseq
   DEFINE l_glaq002        LIKE glaq_t.glaq002
   DEFINE l_glad003        LIKE glad_t.glad003
   DEFINE l_glad004        LIKE glad_t.glad004
   DEFINE l_success        LIKE type_t.num5
   DEFINE l_apcadocno      LIKE apca_t.apcadocno #150703-00021#24
   #end add-point     
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   IF g_glap_m.glapld IS NULL
   OR g_glap_m.glapdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN aglt310_cl USING g_enterprise,g_glap_m.glapld,g_glap_m.glapdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aglt310_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE aglt310_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aglt310_master_referesh USING g_glap_m.glapld,g_glap_m.glapdocno INTO g_glap_m.glapld,g_glap_m.glapcomp, 
       g_glap_m.glap001,g_glap_m.glapdocno,g_glap_m.glapdocdt,g_glap_m.glap002,g_glap_m.glap004,g_glap_m.glap007, 
       g_glap_m.glap008,g_glap_m.glap010,g_glap_m.glap011,g_glap_m.glap006,g_glap_m.glap015,g_glap_m.glap013, 
       g_glap_m.glap009,g_glap_m.glap016,g_glap_m.glap017,g_glap_m.glap012,g_glap_m.glap014,g_glap_m.glapstus, 
       g_glap_m.glapownid,g_glap_m.glapcrtdp,g_glap_m.glapowndp,g_glap_m.glapcrtdt,g_glap_m.glapcrtid, 
       g_glap_m.glapmodid,g_glap_m.glapmoddt,g_glap_m.glapcnfid,g_glap_m.glapcnfdt,g_glap_m.glappstid, 
       g_glap_m.glappstdt,g_glap_m.glapld_desc,g_glap_m.glapcomp_desc,g_glap_m.glap016_desc,g_glap_m.glapownid_desc, 
       g_glap_m.glapcrtdp_desc,g_glap_m.glapowndp_desc,g_glap_m.glapcrtid_desc,g_glap_m.glapmodid_desc, 
       g_glap_m.glapcnfid_desc,g_glap_m.glappstid_desc
   
   
   #檢查是否允許此動作
   IF NOT aglt310_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_glap_m_mask_o.* =  g_glap_m.*
   CALL aglt310_glap_t_mask()
   LET g_glap_m_mask_n.* =  g_glap_m.*
   
   CALL aglt310_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   #160308-00010#25-S
   #IF g_glap_m.glapstus <> 'N' THEN 
   #   INITIALIZE g_errparam TO NULL
   #   LET g_errparam.code = 'agl-00313'
   #   LET g_errparam.extend = g_glap_m.glapld
   #   LET g_errparam.popup = TRUE
   #   CALL cl_err()
   #   CLOSE aglt310_cl
   #   CALL s_transaction_end('N','0')
   #   RETURN
   #END IF
   #160308-00010#25-E
   
   IF g_glap001_p <> '6' THEN   #151204-00001#1 add
      #檢查當單據日期小於等於關帳日期時，不可異動單據
      CALL s_fin_date_close_chk(g_glap_m.glapld,'','AGL',g_glap_m.glapdocdt) RETURNING l_success
      IF l_success = FALSE THEN
         CLOSE aglt310_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
   END IF  #151204-00001#1 add
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      CALL s_ld_chk_authorization(g_user,g_glap_m.glapld) RETURNING l_pass
      IF l_pass = FALSE THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'agl-00164'
         LET g_errparam.extend = g_glap_m.glapld
         LET g_errparam.popup = TRUE
         CALL cl_err()
         CLOSE aglt310_cl
         CALL s_transaction_end('N','0')
         RETURN         
      END IF
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aglt310_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
 
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_glapld_t = g_glap_m.glapld
      LET g_glapdocno_t = g_glap_m.glapdocno
 
 
      DELETE FROM glap_t
       WHERE glapent = g_enterprise AND glapld = g_glap_m.glapld
         AND glapdocno = g_glap_m.glapdocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
                              AND glap001 = g_glap001_p
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_glap_m.glapld,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      IF NOT s_aooi200_fin_del_docno(g_glap_m.glapld,g_glap_m.glapdocno,g_glap_m.glapdocdt) THEN
         CALL s_transaction_end('N','0')
         CLOSE aglt310_cl
         RETURN
      END IF   
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
      IF g_glap001_p MATCHES '[123]' THEN
         LET l_sql="SELECT glaqseq,glaq002 FROM glaq_t ",
                   " WHERE glaqent=",g_enterprise," AND glaqld='",g_glap_m.glapld,"'",
                   "   AND glaqdocno='",g_glap_m.glapdocno,"'"
         PREPARE aglt310_del_pr FROM l_sql
         DECLARE aglt310_del_cs CURSOR FOR aglt310_del_pr
         FOREACH aglt310_del_cs INTO l_glaqseq,l_glaq002
            CALL aglt310_get_glad(g_glap_m.glapld,l_glaq002) RETURNING l_glad003,l_glad004
            #刪除相關科目細項立沖帳資料   
            IF l_glad003='Y' THEN  
               CALL aglt310_delete_glax(g_glap_m.glapld,g_glap_m.glapdocno,l_glaqseq) RETURNING l_success
               IF l_success=FALSE THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aglt310_cl
                  RETURN 
               END IF
               CALL aglt310_delete_glay(g_glap_m.glapld,g_glap_m.glapdocno,l_glaqseq) RETURNING l_success
               IF l_success=FALSE THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aglt310_cl
                  RETURN
               END IF
            END IF 
         END FOREACH         
      END IF      

      #161128-00054#1 add s---
      IF g_glap001_p MATCHES '[5]' THEN
         #清空anmt820憑證單號
         CALL aglt310_upd_nmde(g_glap_m.glapld,g_glap_m.glap002,g_glap_m.glap004) RETURNING l_success
         IF l_success=FALSE THEN
            CALL s_transaction_end('N','0')
            CLOSE aglt310_cl
            RETURN
         END IF         
      END IF
      #161128-00054#1 add e---      
      #end add-point
      
      DELETE FROM glaq_t
       WHERE glaqent = g_enterprise AND glaqld = g_glap_m.glapld
         AND glaqdocno = g_glap_m.glapdocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
                
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "glaq_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      #删除现金变动码资料
      DELETE FROM glbc_t
      WHERE glbcent=g_enterprise AND glbcld=g_glap_m.glapld AND glbcdocno=g_glap_m.glapdocno
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "delete glbc_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         CALL s_transaction_end('N','0')
         CLOSE aglt310_cl
         RETURN
      END IF 
      #150703-00021#24   ---s--- 刪除 預算滾動檔
      #檢查是否適用預算科目 
      CALL s_aooi200_fin_get_slip(g_glap_m.glapdocno) RETURNING g_sub_success,g_ap_slip
      CALL s_fin_get_doc_para(g_glap_m.glapld,g_glap_m.glapcomp,g_ap_slip,'D-FIN-5002') RETURNING g_dfin5002
      #IF g_dfin5002 = 'Y' AND g_glap_m.glap008 = 'P10' THEN #161003-00014#15
      IF g_dfin5002 = 'Y' THEN #161003-00014#15
         DELETE FROM bgbd_t
          WHERE bgbdent = g_enterprise
            AND bgbd037 = g_glap_m.glapdocno
            
         LET g_sql = " SELECT apcadocno FROM apca_t WHERE apcaent = '",g_enterprise,"'      ",
                     "    AND apcald = '",g_glap_m.glapld,"' AND apca038 = '",g_glap_m.glapdocno,"' "
         PREPARE apcadocno_prep01 FROM g_sql
         DECLARE apcadocno_curs01 CURSOR FOR apcadocno_prep01
         FOREACH apcadocno_curs01 INTO l_apcadocno
         #轉出回寫
            CALL s_aapt300_bgbd_upd(l_apcadocno,g_glap_m.glapld,'','UD','3') RETURNING g_sub_success,g_errno
         END FOREACH
      END IF
      #150703-00021#24   ---e---      
      #會寫前段資料傳票編號為‘ ’
      LET l_success=TRUE
      CALL aglt310_update_ap_ar() RETURNING l_success
      IF l_success=FALSE THEN
         CALL s_transaction_end('N','0')
         CLOSE aglt310_cl
         RETURN
      END IF          
     
      #end add-point
      
            
                                                               
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_glap_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE aglt310_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_glaq_d.clear() 
 
     
      CALL aglt310_ui_browser_refresh()  
      #CALL aglt310_ui_headershow()  
      #CALL aglt310_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL aglt310_browser_fill("")
         CALL aglt310_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE aglt310_cl
 
   #功能已完成,通報訊息中心
   CALL aglt310_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="aglt310.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aglt310_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_glaq002   LIKE type_t.chr300
   DEFINE l_cnt       LIKE type_t.num10
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_glaq_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
#   IF cl_null(g_wc2_table1) THEN 
#      LET g_wc2_table1 = "glaqseq<>0"
#   ELSE
#      LET g_wc2_table1 = g_wc2_table1, " AND glaqseq<>0"
#   END IF 
   #end add-point
   
   #判斷是否填充
   IF aglt310_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT glaqseq,glaqcomp,glaq001,glaq002,glaq005,glaq006,glaq010,glaq003, 
             glaq004,glaq039,glaq040,glaq041,glaq042,glaq043,glaq044  FROM glaq_t",   
                     " INNER JOIN glap_t ON glapent = " ||g_enterprise|| " AND glapld = glaqld ",
                     " AND glapdocno = glaqdocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                     
                     " WHERE glaqent=? AND glaqld=? AND glaqdocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
              
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY glaq_t.glaqseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
                          
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aglt310_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR aglt310_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_glap_m.glapld,g_glap_m.glapdocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_glap_m.glapld,g_glap_m.glapdocno INTO g_glaq_d[l_ac].glaqseq, 
          g_glaq_d[l_ac].glaqcomp,g_glaq_d[l_ac].glaq001,g_glaq_d[l_ac].glaq002,g_glaq_d[l_ac].glaq005, 
          g_glaq_d[l_ac].glaq006,g_glaq_d[l_ac].glaq010,g_glaq_d[l_ac].glaq003,g_glaq_d[l_ac].glaq004, 
          g_glaq_d[l_ac].glaq039,g_glaq_d[l_ac].glaq040,g_glaq_d[l_ac].glaq041,g_glaq_d[l_ac].glaq042, 
          g_glaq_d[l_ac].glaq043,g_glaq_d[l_ac].glaq044   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill.fill"
                                       
         #科目+名称+核算项组合
         CALL aglt310_subject()
         #显示的时候，如果金额为0，则显示空白
         IF g_glaq_d[l_ac].glaq003 = 0 THEN
            LET g_glaq_d[l_ac].glaq003 = ''
            LET g_glaq_d[l_ac].amt2=g_glaq_d[l_ac].glaq041
            LET g_glaq_d[l_ac].amt3=g_glaq_d[l_ac].glaq044
         END IF
         
         IF g_glaq_d[l_ac].glaq004 = 0 THEN
            LET g_glaq_d[l_ac].glaq004 = ''
            LET g_glaq_d[l_ac].amt2=g_glaq_d[l_ac].glaq040
            LET g_glaq_d[l_ac].amt3=g_glaq_d[l_ac].glaq043 
         END IF
         
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
   LET l_cnt = g_glaq_d.getLength() - 1
   IF g_cnt > l_cnt THEN
      LET g_cnt= l_cnt
   END IF
   LET g_detail_idx = g_cnt
   DISPLAY g_cnt TO FORMONLY.idx 
   DISPLAY l_cnt TO FORMONLY.cnt
   #end add-point
   
   CALL g_glaq_d.deleteElement(g_glaq_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE aglt310_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_glaq_d.getLength()
      LET g_glaq_d_mask_o[l_ac].* =  g_glaq_d[l_ac].*
      CALL aglt310_glaq_t_mask()
      LET g_glaq_d_mask_n[l_ac].* =  g_glaq_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="aglt310.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION aglt310_delete_b(ps_table,ps_keys_bak,ps_page)
   #add-point:delete_b段define(客製用) name="delete_b.define_customerization"
   
   #end add-point     
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE li_idx      LIKE type_t.num10
   #add-point:delete_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete_b.define"
               DEFINE l_glad003   LIKE glad_t.glad003
   DEFINE l_glad004   LIKE glad_t.glad004
   DEFINE l_success   LIKE type_t.num5
   #end add-point     
   
   #add-point:Function前置處理  name="delete_b.pre_function"
   
   #end add-point
   
   LET g_update = TRUE  
   
   #判斷是否是同一群組的table
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete"
      #161003-00014#15---s---
      CALL s_aooi200_fin_get_slip(g_glap_m.glapdocno) RETURNING g_sub_success,g_ap_slip                     #160902-00034#1 
      CALL s_fin_get_doc_para(g_glap_m.glapld,g_glap_m.glapcomp,g_ap_slip,'D-FIN-5002') RETURNING g_dfin5002#160902-00034#1 
      IF g_dfin5002 = 'Y' AND cl_null(g_glap_m.glap008)THEN  #160902-00034#1                     
         #單身刪除/刪除bgbd_t
         CALL s_aapp330_bgbd_upd(ps_keys_bak[2],ps_keys_bak[1],ps_keys_bak[3],'D','3') RETURNING g_sub_success,g_errno
         IF NOT g_sub_success THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = ps_keys_bak[2]
            LET g_errparam.code   = g_errno 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            RETURN FALSE
         END IF
      END IF 
   
      #IF g_glap_m.glap008 = 'P10' THEN
      #   CALL s_aapp330_bgbd_upd(ps_keys_bak[2],ps_keys_bak[1],ps_keys_bak[3],'D','3') RETURNING g_sub_success,g_errno
      #   IF NOT g_sub_success THEN
      #       INITIALIZE g_errparam TO NULL
      #       LET g_errparam.code = g_errno
      #       LET g_errparam.extend = ps_keys_bak[2]
      #       LET g_errparam.popup = TRUE
      #       CALL cl_err()
      #       RETURN FALSE
      #   END IF  
      #END IF  
      #161003-00014#15---e---      
      #end add-point    
      DELETE FROM glaq_t
       WHERE glaqent = g_enterprise AND
         glaqld = ps_keys_bak[1] AND glaqdocno = ps_keys_bak[2] AND glaqseq = ps_keys_bak[3]
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
         CALL g_glaq_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
            
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aglt310.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION aglt310_insert_b(ps_table,ps_keys,ps_page)
   #add-point:insert_b段define(客製用) name="insert_b.define_customerization"
   
   #end add-point     
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE ls_page     STRING
   DEFINE li_idx      LIKE type_t.num10
   #add-point:insert_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert_b.define"
   DEFINE ls_js       STRING
   #end add-point     
   
   #add-point:Function前置處理  name="insert_b.pre_function"
   
   #end add-point
   
   LET g_update = TRUE  
   
   #判斷是否是同一群組的table
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert"
                              LET g_glaq_d[l_ac].glaqcomp = g_glap_m.glapcomp
#      #當外幣憑證沒打勾時,此三個欄位應以帳簿幣別/1/單身借或貸方金額存入
#      IF g_glap_m.glap014 = 'N' THEN
#         LET g_glaq_d[l_ac].glaq005 = g_glaa001
#         LET g_glaq_d[l_ac].glaq006 = 1
#         IF g_glaq_d[l_ac].glaq003<>0 THEN
#            LET g_glaq_d[l_ac].glaq010 = g_glaq_d[l_ac].glaq003
#         ELSE
#            LET g_glaq_d[l_ac].glaq010 = g_glaq_d[l_ac].glaq004	        
#         END IF 
#      END IF
      #end add-point 
      INSERT INTO glaq_t
                  (glaqent,
                   glaqld,glaqdocno,
                   glaqseq
                   ,glaqcomp,glaq001,glaq002,glaq005,glaq006,glaq010,glaq003,glaq004,glaq039,glaq040,glaq041,glaq042,glaq043,glaq044) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_glaq_d[g_detail_idx].glaqcomp,g_glaq_d[g_detail_idx].glaq001,g_glaq_d[g_detail_idx].glaq002, 
                       g_glaq_d[g_detail_idx].glaq005,g_glaq_d[g_detail_idx].glaq006,g_glaq_d[g_detail_idx].glaq010, 
                       g_glaq_d[g_detail_idx].glaq003,g_glaq_d[g_detail_idx].glaq004,g_glaq_d[g_detail_idx].glaq039, 
                       g_glaq_d[g_detail_idx].glaq040,g_glaq_d[g_detail_idx].glaq041,g_glaq_d[g_detail_idx].glaq042, 
                       g_glaq_d[g_detail_idx].glaq043,g_glaq_d[g_detail_idx].glaq044)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
                        
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "glaq_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_glaq_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      #161003-00014#15---s---
      #檢查是否適用預算科目 
      #CALL s_aooi200_fin_get_slip(g_glap_m.glapdocno) RETURNING g_sub_success,g_ap_slip
      #CALL s_fin_get_doc_para(g_glap_m.glapld,g_glap_m.glapcomp,g_ap_slip,'D-FIN-5002') RETURNING g_dfin5002
      #IF g_dfin5002 = 'Y' AND g_glap_m.glap008 = 'P10' THEN #160902-00034#1 
      #   CALL s_aapp330_bgbd_upd(g_glap_m.glapdocno,g_glap_m.glapld,g_glaq_d[g_detail_idx].glaqseq,'','1') RETURNING g_sub_success,g_errno
      #   IF NOT g_sub_success THEN
      #      INITIALIZE g_errparam TO NULL
      #      LET g_errparam.code = g_errno
      #      LET g_errparam.extend = g_glaq_d[g_detail_idx].glaq002
      #      LET g_errparam.popup = TRUE
      #      CALL cl_err()
      #      CALL s_transaction_end('N','0')
      #      RETURN
      #   END IF         
      #   
      #   #預算額度是否超過
      #   CALL s_aapp330_bgbd_upd(g_glap_m.glapdocno,g_glap_m.glapld,g_glaq_d[g_detail_idx].glaqseq,'','2') RETURNING g_sub_success,g_errno
      #   IF NOT g_sub_success THEN
      #      INITIALIZE g_errparam TO NULL
      #      LET g_errparam.code = g_errno
      #      LET g_errparam.extend = g_glaq_d[g_detail_idx].glaq002
      #      LET g_errparam.popup = TRUE
      #      CALL cl_err()
      #      CALL s_transaction_end('N','0') 
      #      RETURN
      #   END IF                
      #   #新增預算滾動檔         
      #   CALL s_aapp330_bgbd_upd(g_glap_m.glapdocno,g_glap_m.glapld,g_glaq_d[g_detail_idx].glaqseq,'I','3') RETURNING g_sub_success,g_errno
      #   IF NOT g_sub_success THEN
      #       INITIALIZE g_errparam TO NULL
      #       LET g_errparam.code = g_errno
      #       LET g_errparam.extend = g_glaq_d[g_detail_idx].glaq002
      #       LET g_errparam.popup = TRUE
      #       CALL cl_err()
      #       CALL s_transaction_end('N','0')
      #       RETURN
      #    END IF                                                             
      #END IF            
      #161003-00014#15 ---e---   
      
      #end add-point 
   END IF
   
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
            
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="aglt310.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION aglt310_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
               DEFINE l_glad003   LIKE glad_t.glad003
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "glaq_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
                        
      #end add-point 
      
      #將遮罩欄位還原
      CALL aglt310_glaq_t_mask_restore('restore_mask_o')
               
      UPDATE glaq_t 
         SET (glaqld,glaqdocno,
              glaqseq
              ,glaqcomp,glaq001,glaq002,glaq005,glaq006,glaq010,glaq003,glaq004,glaq039,glaq040,glaq041,glaq042,glaq043,glaq044) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_glaq_d[g_detail_idx].glaqcomp,g_glaq_d[g_detail_idx].glaq001,g_glaq_d[g_detail_idx].glaq002, 
                  g_glaq_d[g_detail_idx].glaq005,g_glaq_d[g_detail_idx].glaq006,g_glaq_d[g_detail_idx].glaq010, 
                  g_glaq_d[g_detail_idx].glaq003,g_glaq_d[g_detail_idx].glaq004,g_glaq_d[g_detail_idx].glaq039, 
                  g_glaq_d[g_detail_idx].glaq040,g_glaq_d[g_detail_idx].glaq041,g_glaq_d[g_detail_idx].glaq042, 
                  g_glaq_d[g_detail_idx].glaq043,g_glaq_d[g_detail_idx].glaq044) 
         WHERE glaqent = g_enterprise AND glaqld = ps_keys_bak[1] AND glaqdocno = ps_keys_bak[2] AND glaqseq = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update"
                        
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "glaq_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "glaq_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aglt310_glaq_t_mask_restore('restore_mask_n')
               
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
 
{<section id="aglt310.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION aglt310_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="aglt310.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION aglt310_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="aglt310.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION aglt310_lock_b(ps_table,ps_page)
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
   #CALL aglt310_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "glaq_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN aglt310_bcl USING g_enterprise,
                                       g_glap_m.glapld,g_glap_m.glapdocno,g_glaq_d[g_detail_idx].glaqseq  
                                               
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aglt310_bcl:",SQLERRMESSAGE 
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
 
{<section id="aglt310.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION aglt310_unlock_b(ps_table,ps_page)
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
      CLOSE aglt310_bcl
   END IF
   
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
            
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="aglt310.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION aglt310_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
            
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("glapdocno,glapld",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("glapld,glapdocno",TRUE)
      CALL cl_set_comp_entry("glapdocdt",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      CALL cl_set_comp_entry("glapdocdt",TRUE)     
      CALL cl_set_comp_entry("glapld",FALSE)         #160518-00075#27 add lujh      
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aglt310.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION aglt310_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
               DEFINE l_glaq002    	LIKE glaq_t.glaq002
   DEFINE l_cnt         LIKE type_t.num5
   DEFINE l_dfin0033  LIKE type_t.chr1  #151130-00015#2
   DEFINE l_success   LIKE type_t.chr1  #151130-00015#2
   DEFINE l_slip      LIKE type_t.chr80  #151130-00015#2 
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("glapld,glapdocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
 
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("glapdocno,glapld",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("glapdocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   #修改状态时，原传票编号不为空，如果单身存在资料则不可修改
   IF g_glap001_p ='4' THEN
      IF NOT cl_null(g_glap_m.glap015) THEN
         SELECT COUNT(1) INTO l_cnt FROM  glap_t #161205-00025#4 mod 'count(*)'-->'COUNT(1)'
          WHERE glapent = g_enterprise
            AND glapld = g_glap_m.glapld
            AND glapdocno = g_glap_m.glapdocno
         IF l_cnt > 0 THEN
            CALL cl_set_comp_entry("glap015",FALSE)
         ELSE
            CALL cl_set_comp_entry("glap015",TRUE)         
         END IF 
      ELSE
         IF p_cmd='a' THEN
            CALL cl_set_comp_entry("glap015",TRUE)
         END IF
      END IF
   END IF
   
   #151130-00015#2  -add -str
   IF NOT cl_null(g_glap_m.glapdocno) THEN  
      #获取单别
      CALL s_aooi200_fin_get_slip(g_glap_m.glapdocno) RETURNING l_success,l_slip
      #取得單別設置的"是否直接審核"參數
      CALL s_fin_get_doc_para(g_glap_m.glapld,g_glap_m.glapcomp,l_slip,'D-FIN-0033') RETURNING l_dfin0033
      #160415-00025#1--mod--str--
#      IF l_dfin0033 = "Y" THEN
      IF l_dfin0033 = "Y"  AND 
         ((g_glap001_p = '1' AND g_glap_m.glap007 = 'GL' AND g_glap_m.glap008 IS NULL) OR
          (g_glap001_p = '1' AND g_glap_m.glap007 = 'ZT' ) OR #160805-00022#1 add
          (g_glap001_p = '2' AND g_glap_m.glap007 = 'CR' ) OR
          (g_glap001_p = '3' AND g_glap_m.glap007 = 'CD' ) OR
          (g_glap001_p = '4' AND g_glap_m.glap007 = 'RV' ) OR
          (g_glap001_p = '5' AND g_glap_m.glap007 = 'AC' ) OR
          (g_glap001_p = '6' AND g_glap_m.glap007 = 'AD' ))
      THEN 
      #160415-00025#1--mod--end
         CALL cl_set_comp_entry("glapdocdt",TRUE)   
      END IF          
   END IF 
   #151130-00015#2  -end -str
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aglt310.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION aglt310_set_entry_b(p_cmd)
   #add-point:set_entry_b段define(客製用) name="set_entry_b.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   IF (g_glap_m.glap007 = 'GL' AND (g_glap_m.glap008 <> 'TH' OR cl_null(g_glap_m.glap008)) ) OR g_glap_m.glap007 = 'CR'  OR g_glap_m.glap007 = 'CD'  OR
      g_glap_m.glap007 = 'ZT'  OR  #160805-00022#1 add
      g_glap_m.glap007 = 'RV'  OR g_glap_m.glap007 = 'AC'  OR g_glap_m.glap007 = 'AD' THEN
      IF g_glap001_p<>'4'  THEN
         CALL cl_set_comp_entry('lc_subject,glaq005,glaq006,glaq010,glaq003,glaq004,glaq039,amt2,glaq042,amt3',TRUE)  
      END IF 
      
      IF g_glaq_d[l_ac].glaq004=0 AND g_glaq_d[l_ac].glaq003=0 THEN
          CALL cl_set_comp_entry('glaq003,glaq004',TRUE)  
      END IF 
       
      IF g_glaq_d[l_ac].glaq003 = 0  AND g_glaq_d[l_ac].glaq004 <> 0 THEN
         CALL cl_set_comp_entry('glaq004',TRUE)  
      END IF 
      IF g_glaq_d[l_ac].glaq003 <>0 AND g_glaq_d[l_ac].glaq004 = 0 THEN
         CALL cl_set_comp_entry('glaq003',TRUE)  
      END IF 
      
      #160902-00030#1 add--s
      IF g_glap001_p='2' OR g_glap001_p ='3' THEN
         CALL cl_set_comp_entry('glaq001,lc_subject,glaq003,glaq004',TRUE) 
      END IF
      #160902-00030#1 add--e
      
      IF g_glap001_p ='2'  THEN
         CALL cl_set_comp_entry('glaq003',FALSE)
      END IF
      IF g_glap001_p ='3'  THEN
         CALL cl_set_comp_entry('glaq004',FALSE)
      END IF
   END IF
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
 
{<section id="aglt310.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION aglt310_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define(客製用) name="set_no_entry_b.define_customerization"
   
   #end add-point    
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   IF (g_glap_m.glap007 = 'GL' AND (g_glap_m.glap008 <> 'TH' OR cl_null(g_glap_m.glap008)) )  OR g_glap_m.glap007 = 'CR'  OR g_glap_m.glap007 = 'CD'  OR
      g_glap_m.glap007 = 'ZT'  OR  #160805-00022#1 add
      g_glap_m.glap007 = 'RV'  OR g_glap_m.glap007 = 'AC'  OR g_glap_m.glap007 = 'AD'  THEN
      IF g_glap001_p ='4'  THEN
         CALL cl_set_comp_entry('lc_subject,glaq005,glaq006,glaq010,glaq003,glaq004,glaq039,amt2,glaq042,amt3',FALSE)
      END IF 
      
      #160902-00030#1 add--s 只能修改摘要
      IF g_glaq_d[l_ac].glaqseq=0 AND (g_glap001_p='2' OR g_glap001_p ='3') THEN
         CALL cl_set_comp_entry('lc_subject,glaq003,glaq004',FALSE) 
      END IF
      #160902-00030#1 add--e
      
      IF g_glaq_d[l_ac].glaq003 = 0  AND g_glaq_d[l_ac].glaq004 <> 0 THEN
         CALL cl_set_comp_entry('glaq003',FALSE)  
      END IF 
      IF g_glaq_d[l_ac].glaq004 = 0  AND g_glaq_d[l_ac].glaq003 <> 0 THEN
         CALL cl_set_comp_entry('glaq004',FALSE)  
      END IF 
   END IF
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
 
{<section id="aglt310.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION aglt310_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
 
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aglt310.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION aglt310_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   IF g_glap_m.glapstus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改 mod by zhujing 2015-5-29
      CALL cl_set_act_visible('modify,modify_detail,delete',FALSE)
   END IF
   #160729-00009#4  --add--s--
   #共用的action都拿掉
   CALL cl_set_act_visible('excel_load,excel_example',FALSE)
   #160729-00009#4  --add--e--
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aglt310.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION aglt310_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
 
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aglt310.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION aglt310_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aglt310.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aglt310_default_search()
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
      LET ls_wc = ls_wc, " glapld = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " glapdocno = '", g_argv[02], "' AND "
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
               WHEN la_wc[li_idx].tableid = "glap_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "glaq_t" 
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
   LET g_wc = ''
   IF NOT cl_null(g_argv[1]) THEN
      LET ls_wc = "glap001 = '", g_argv[1], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " glapld = '", g_argv[02], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " glapdocno = '", g_argv[03], "' AND "
   END IF
 
   IF NOT cl_null(ls_wc) AND NOT cl_null(g_argv[02]) THEN
      LET g_wc = ls_wc.subString(1,ls_wc.getLength()-5)
      LET g_default = TRUE
   ELSE
      #若無外部參數則預設為1=2
      LET g_default = FALSE
      #預設查詢條件
      LET g_wc = cl_qbe_get_default_qryplan()
      IF cl_null(g_wc) THEN
         LET g_wc = " 1=2"
      END IF
   END IF
   LET g_wc1=g_wc
   #end add-point  
 
   IF g_wc.getIndexOf(" 1=2", 1) THEN
      LET g_default = TRUE
   END IF
 
 
END FUNCTION
 
{</section>}
 
{<section id="aglt310.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION aglt310_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_success    LIKE type_t.num5
   DEFINE l_success1   LIKE type_t.num5
   DEFINE l_success2   LIKE type_t.num5
   DEFINE l_errno      LIKE type_t.chr80   
   
   #写入日志文件
   DEFINE l_ch         base.Channel
   DEFINE l_logFile    STRING
   DEFINE l_path       STRING
   DEFINE l_str        STRING
   DEFINE l_log_flag   LIKE type_t.chr20
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   #顯示最新的資料
#   CALL aglt310_ui_headershow() #161205-00025#4 mark
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_glap_m.glapld IS NULL
      OR g_glap_m.glapdocno IS NULL
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN aglt310_cl USING g_enterprise,g_glap_m.glapld,g_glap_m.glapdocno
   IF STATUS THEN
      CLOSE aglt310_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aglt310_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE aglt310_master_referesh USING g_glap_m.glapld,g_glap_m.glapdocno INTO g_glap_m.glapld,g_glap_m.glapcomp, 
       g_glap_m.glap001,g_glap_m.glapdocno,g_glap_m.glapdocdt,g_glap_m.glap002,g_glap_m.glap004,g_glap_m.glap007, 
       g_glap_m.glap008,g_glap_m.glap010,g_glap_m.glap011,g_glap_m.glap006,g_glap_m.glap015,g_glap_m.glap013, 
       g_glap_m.glap009,g_glap_m.glap016,g_glap_m.glap017,g_glap_m.glap012,g_glap_m.glap014,g_glap_m.glapstus, 
       g_glap_m.glapownid,g_glap_m.glapcrtdp,g_glap_m.glapowndp,g_glap_m.glapcrtdt,g_glap_m.glapcrtid, 
       g_glap_m.glapmodid,g_glap_m.glapmoddt,g_glap_m.glapcnfid,g_glap_m.glapcnfdt,g_glap_m.glappstid, 
       g_glap_m.glappstdt,g_glap_m.glapld_desc,g_glap_m.glapcomp_desc,g_glap_m.glap016_desc,g_glap_m.glapownid_desc, 
       g_glap_m.glapcrtdp_desc,g_glap_m.glapowndp_desc,g_glap_m.glapcrtid_desc,g_glap_m.glapmodid_desc, 
       g_glap_m.glapcnfid_desc,g_glap_m.glappstid_desc
   
 
   #檢查是否允許此動作
   IF NOT aglt310_action_chk() THEN
      CLOSE aglt310_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_glap_m.glapld,g_glap_m.glapld_desc,g_glap_m.glapcomp,g_glap_m.glapcomp_desc,g_glap_m.glaa001_desc, 
       g_glap_m.glaa016,g_glap_m.glaa020,g_glap_m.glap001,g_glap_m.glapdocno,g_glap_m.glapdocdt,g_glap_m.glap002, 
       g_glap_m.glap004,g_glap_m.glap007,g_glap_m.glap008,g_glap_m.glap010,g_glap_m.glap011,g_glap_m.glap006, 
       g_glap_m.glap006_desc,g_glap_m.glap015,g_glap_m.glap013,g_glap_m.glap009,g_glap_m.sdocno,g_glap_m.glap016, 
       g_glap_m.glap016_desc,g_glap_m.glap017,g_glap_m.glap012,g_glap_m.glap014,g_glap_m.glapstus,g_glap_m.glapownid, 
       g_glap_m.glapownid_desc,g_glap_m.glapcrtdp,g_glap_m.glapcrtdp_desc,g_glap_m.glapowndp,g_glap_m.glapowndp_desc, 
       g_glap_m.glapcrtdt,g_glap_m.glapcrtid,g_glap_m.glapcrtid_desc,g_glap_m.glapmodid,g_glap_m.glapmodid_desc, 
       g_glap_m.glapmoddt,g_glap_m.glapcnfid,g_glap_m.glapcnfid_desc,g_glap_m.glapcnfdt,g_glap_m.glappstid, 
       g_glap_m.glappstid_desc,g_glap_m.glappstdt,g_glap_m.glaq017,g_glap_m.glaq017_desc,g_glap_m.glaq018, 
       g_glap_m.glaq018_desc,g_glap_m.glaq019,g_glap_m.glaq019_desc,g_glap_m.glaq020,g_glap_m.glaq020_desc, 
       g_glap_m.glaq021,g_glap_m.glaq021_desc,g_glap_m.glaq022,g_glap_m.glaq022_desc,g_glap_m.glaq023, 
       g_glap_m.glaq023_desc,g_glap_m.glaq024,g_glap_m.glaq024_desc,g_glap_m.glbc004,g_glap_m.glbc004_desc, 
       g_glap_m.glaq051,g_glap_m.glaq052,g_glap_m.glaq052_desc,g_glap_m.glaq053,g_glap_m.glaq053_desc, 
       g_glap_m.glaq025,g_glap_m.glaq025_desc,g_glap_m.glaq027,g_glap_m.glaq027_desc,g_glap_m.glaq028, 
       g_glap_m.glaq028_desc,g_glap_m.glaq029,g_glap_m.glaq029_desc,g_glap_m.glaq030,g_glap_m.glaq030_desc, 
       g_glap_m.glaq031,g_glap_m.glaq031_desc,g_glap_m.glaq032,g_glap_m.glaq032_desc,g_glap_m.glaq033, 
       g_glap_m.glaq033_desc,g_glap_m.glaq034,g_glap_m.glaq034_desc,g_glap_m.glaq035,g_glap_m.glaq035_desc, 
       g_glap_m.glaq036,g_glap_m.glaq036_desc,g_glap_m.glaq037,g_glap_m.glaq037_desc,g_glap_m.glaq038, 
       g_glap_m.glaq038_desc,g_glap_m.glaq005_1,g_glap_m.glaq006_1,g_glap_m.glaq010_1,g_glap_m.glaq007, 
       g_glap_m.glaq008,g_glap_m.glaq009,g_glap_m.glaq011,g_glap_m.glaq012,g_glap_m.glaq013,g_glap_m.glaq013_desc, 
       g_glap_m.glaq014,g_glap_m.glaq015,g_glap_m.glaq015_desc,g_glap_m.glaq016,g_glap_m.glaq016_desc, 
       g_glap_m.conf,g_glap_m.post,g_glap_m.creat
 
   CASE g_glap_m.glapstus
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
      WHEN "S"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/posted.png")
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
   IF g_glap_m.glapstus = 'X' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'anm-00044'
      LET g_errparam.extend = g_glap_m.glapdocno
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CLOSE aglt310_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   IF g_glap001_p <> '6' THEN   #151204-00001#1 add
      #檢查當單據日期小於等於關帳日期時，不可異動單據
      CALL s_fin_date_close_chk(g_glap_m.glapld,'','AGL',g_glap_m.glapdocdt) RETURNING l_success
      IF l_success = FALSE THEN
         CLOSE aglt310_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
   END IF  #151204-00001#1 add
   #end add-point
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_glap_m.glapstus
            
            WHEN "N"
               HIDE OPTION "unconfirmed"
            WHEN "Y"
               HIDE OPTION "confirmed"
            WHEN "S"
               HIDE OPTION "posted"
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
#     CALL cl_set_act_visible("confirmed,unconfirmed,posted,undeduct,invalid",FALSE)
#      CASE g_glap_m.glapstus
#         WHEN "N"
#            CALL cl_set_act_visible("confirmed,invalid",TRUE)   
#         WHEN "Y"
#            CALL cl_set_act_visible("unconfirmed,posted",TRUE)
#         WHEN "S"
#            CALL cl_set_act_visible("undeduct",TRUE)
#         WHEN "X"
#            RETURN
#      END CASE
      #zhujing mod 2015-6-16-------（S）
      CALL cl_set_act_visible("signing,withdraw",FALSE) #xujing add
      CALL cl_set_act_visible("unconfirmed,invalid,confirmed,posted,undeduct",TRUE) #xujing add
      CASE g_glap_m.glapstus

         WHEN "Y"
            CALL cl_set_act_visible("invalid,confirmed,undeduct",FALSE)

         WHEN "S"
            CALL cl_set_act_visible("unconfirmed,invalid,confirmed,posted",FALSE)
         WHEN "N"
            CALL cl_set_act_visible("unconfirmed,posted,undeduct",FALSE)
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            IF cl_bpm_chk() THEN
               CALL cl_set_act_visible("signing",TRUE)
               CALL cl_set_act_visible("confirmed",FALSE)
            END IF
         #已核准只能顯示確認;其餘應用功能皆隱藏
         WHEN "A"
            CALL cl_set_act_visible("confirmed ",TRUE)
            CALL cl_set_act_visible("unconfirmed,invalid,posted,undeduct",FALSE)
         #保留修改的功能(如作廢)，隱藏其他應用功能
         WHEN "R"
            CALL cl_set_act_visible("confirmed,unconfirmed,posted,undeduct",FALSE)
         WHEN "D"
            CALL cl_set_act_visible("confirmed,unconfirmed,posted,undeduct",FALSE)
         #送簽中只能顯示抽單;其餘應用功能皆隱藏
         WHEN "W"
            CALL cl_set_act_visible("withdraw",TRUE)
            CALL cl_set_act_visible("unconfirmed,invalid,confirmed,posted,undeduct",FALSE)
      END CASE
      #zhujing mod 2015-6-16-------（E）
      LET l_success=TRUE 

      LET l_log_flag = ""
      #end add-point
      
      #應用 a36 樣板自動產生(Version:5)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT aglt310_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE aglt310_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT aglt310_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE aglt310_cl
            RETURN
         END IF
 
 
 
	  
      ON ACTION unconfirmed
         IF cl_auth_chk_act("unconfirmed") THEN
            LET lc_state = "N"
            #add-point:action控制 name="statechange.unconfirmed"
            CALL cl_err_collect_init()
            CALL s_voucher_unconf_chk(g_glap_m.glapld,g_glap_m.glapdocno) RETURNING l_success
            IF l_success = TRUE THEN
               CALL s_voucher_unconf_upd(g_glap_m.glapld,g_glap_m.glapdocno) RETURNING l_success
               #當aglt310、aglt320、aglt330時，更新細項立沖帳資料
               IF g_glap001_p MATCHES'[123]' AND l_success=TRUE THEN
#                  CALL aglt310_unconf_upd_glax_glay(g_glap_m.glapld,g_glap_m.glapdocno) RETURNING l_success1  #170103-00019#1 mark
                  CALL s_aglt310_unconf_upd_glax_glay(g_glap_m.glapld,g_glap_m.glapdocno) RETURNING l_success1 #170103-00019#1 add
                  LET l_success=l_success1
               END IF
            END IF 
            
            #判断执行结果，当失败时，回滚数据库
            IF l_success = FALSE  THEN
               CALL cl_err_collect_show()
               CALL s_transaction_end('N','0')
               CLOSE aglt310_cl
               RETURN
            END IF
            #end add-point
         END IF
         EXIT MENU
      ON ACTION confirmed
         IF cl_auth_chk_act("confirmed") THEN
            LET lc_state = "Y"
            #add-point:action控制 name="statechange.confirmed"
            CALL cl_err_collect_init()
            CALL s_voucher_conf_chk(g_glap_m.glapld,g_glap_m.glapdocno) RETURNING l_success
            #當aglt310、aglt320、aglt330時，判斷是否進行細項里沖帳，并進行檢查
            IF g_glap001_p MATCHES'[123]' AND g_glap_m.glap007<>'AC' AND g_glap_m.glap007<>'RA' THEN #170214-00033#1 add glap007<>(AC,RA)
#               CALL aglt310_glax_and_glay_chk(g_glap_m.glapld,g_glap_m.glapdocno) RETURNING l_success1  #170103-00019#1 mark
               CALL s_aglt310_glax_and_glay_chk(g_glap_m.glapld,g_glap_m.glapdocno) RETURNING l_success1 #170103-00019#1 add
               IF l_success = TRUE THEN
                  LET l_success=l_success1
               END IF
            END IF
            
            IF l_success = TRUE THEN
               CALL s_voucher_conf_upd(g_glap_m.glapld,g_glap_m.glapdocno) RETURNING l_success
               #當aglt310、aglt320、aglt330時，更新細項立沖帳資料
               IF g_glap001_p MATCHES'[123]' AND l_success=TRUE 
                  AND g_glap_m.glap007<>'AC' AND g_glap_m.glap007<>'RA' #170214-00033#1 add glap007<>(AC,RA)
               THEN
#                  CALL aglt310_conf_upd_glax_glay(g_glap_m.glapld,g_glap_m.glapdocno) RETURNING l_success1  #170103-00019#1 mark
                  CALL s_aglt310_conf_upd_glax_glay(g_glap_m.glapld,g_glap_m.glapdocno) RETURNING l_success1 #170103-00019#1 add
                  LET l_success=l_success1
               END IF
            END IF   
            
            #判断执行结果，当失败时，回滚数据库
            IF l_success = FALSE  THEN
               CALL cl_err_collect_show()
               CALL s_transaction_end('N','0')
               CLOSE aglt310_cl
               RETURN
            END IF
            #end add-point
         END IF
         EXIT MENU
      ON ACTION posted
         IF cl_auth_chk_act("posted") THEN
            LET lc_state = "S"
            #add-point:action控制 name="statechange.posted"
            CALL cl_err_collect_init()
            
            #写入日志文件
            LET l_log_flag = "post"
            #先讀取$ERP, 若無則採用程序写死的路径
            LET l_path = FGL_GETENV("ERP")
            IF cl_null(l_path) THEN
               LET l_path = "/u1/t10dev/erp"
            END IF
            LET l_path = l_path,"/agl/4gl/log/"
#            #将log文件放在temp目录下
#            LET l_path = FGL_GETENV("TEMPDIR"),"/"
            LET l_logFile = l_path,g_today USING "YYYYMMDD","_",g_glap_m.glapdocno,".log"
            LET l_ch = base.Channel.create()
            CALL l_ch.setDelimiter(NULL)
            CALL l_ch.openFile(l_logFile, "a")
            LET l_str = "#--------------------------- (", CURRENT YEAR TO SECOND,"'",g_glap_m.glapdocno,"'", "post Start) ---------------------------#\n"
            CALL l_ch.write(l_str)
            CALL s_voucher_post_chk(g_glap_m.glapld,g_glap_m.glapdocno) RETURNING l_success
            LET l_str = "write glar_t result:",l_success,"\n"
            CALL l_ch.write(l_str)
            IF l_success = TRUE THEN
               CALL s_voucher_post_upd(g_glap_m.glapld,g_glap_m.glapdocno) RETURNING l_success
               LET l_str = "write glap_t result:",l_success,"\n"
               CALL l_ch.write(l_str)
            END IF     
            
            #判断执行结果，当失败时，回滚数据库
            IF l_success = FALSE  THEN
               CALL cl_err_collect_show()
               CALL s_transaction_end('N','0') 
               #过账操作结束，写入操作结果，关闭日志文件
               LET l_str="过账失败，数据库回滚","\n"
               CALL l_ch.write(l_str)
               LET l_str = "操作结束单据状态：lc_state=",lc_state,"\n",
                           "                g_glap_m.glapstus=",g_glap_m.glapstus,"\n"
               CALL l_ch.write(l_str)
               LET l_str = "#--------------------------- (", CURRENT YEAR TO SECOND,"'",g_glap_m.glapdocno,"'", "post End) -----------------------------#\n"
               CALL l_ch.write(l_str)
               CALL l_ch.close()
               CLOSE aglt310_cl
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
            CALL cl_err_collect_init()
            #151125-00001#2 --- mark start ---
            #CALL s_voucher_void_chk(g_glap_m.glapld,g_glap_m.glapdocno) RETURNING l_success
            ##當aglt310、aglt320、aglt330時，檢查細項立沖帳資料
            #IF g_glap001_p MATCHES'[123]' THEN
            #   CALL s_voucher_void_chk_glax(g_glap_m.glapld,g_glap_m.glapdocno) RETURNING l_success1
            #   CALL s_voucher_void_chk_glay(g_glap_m.glapld,g_glap_m.glapdocno) RETURNING l_success2
            #   IF l_success1=FALSE OR l_success2=FALSE THEN
            #      LET l_success=FALSE
            #   END IF
            #END IF
            #IF l_success = TRUE THEN
            #   CALL s_voucher_void_upd(g_glap_m.glapld,g_glap_m.glapdocno) RETURNING l_success
            #   #當aglt310、aglt320、aglt330時，更新細項立沖帳資料
            #   IF g_glap001_p MATCHES'[123]'  THEN
            #      CALL s_voucher_void_upd_glax(g_glap_m.glapld,g_glap_m.glapdocno) RETURNING l_success1
            #      CALL s_voucher_void_upd_glay(g_glap_m.glapld,g_glap_m.glapdocno) RETURNING l_success2
            #      IF l_success1=FALSE OR l_success2=FALSE THEN
            #         LET l_success=FALSE
            #      END IF 
            #   END IF
            #END IF 
            #IF l_success = TRUE THEN
            #   #會寫前段資料傳票編號為‘ ’
            #   CALL aglt310_update_ap_ar() RETURNING l_success
            #END IF
            #
            ##判断执行结果，当失败时，回滚数据库
            #IF l_success = FALSE  THEN
            #   CALL cl_err_collect_show()
            #   CALL s_transaction_end('N','0')
            #   CLOSE aglt310_cl
            #   RETURN
            #END IF
            #151125-00001#2 --- mark end   ---
            #end add-point
         END IF
         EXIT MENU
 
      #add-point:stus控制 name="statechange.more_control"
      ON ACTION undeduct
         IF cl_auth_chk_act("undeduct") THEN
            LET lc_state = "Y"
            CALL cl_err_collect_init()
            
            #写入日志文件
            LET l_log_flag = "unpost"
            #先讀取$ERP, 若無則採用程序写死的路径
            LET l_path = FGL_GETENV("ERP")
            IF cl_null(l_path) THEN
               LET l_path = "/u1/t10dev/erp"
            END IF
            LET l_path = l_path,"/agl/4gl/log/"
#            #将log文件放在temp目录下
#            LET l_path = FGL_GETENV("TEMPDIR"),"/"
            LET l_logFile = l_path,g_today USING "YYYYMMDD","_",g_glap_m.glapdocno,".log"
            LET l_ch = base.Channel.create()
            CALL l_ch.setDelimiter(NULL)
            CALL l_ch.openFile(l_logFile, "a")
            LET l_str = "#--------------------------- (", CURRENT YEAR TO SECOND,"'",g_glap_m.glapdocno,"'", "unpost Start) -------------------------#\n"
            CALL l_ch.write(l_str)
            CALL s_voucher_unpost_chk(g_glap_m.glapld,g_glap_m.glapdocno) RETURNING l_success
            LET l_str = "write glar_t result:",l_success,"\n"
            CALL l_ch.write(l_str)
            IF l_success = TRUE THEN
               CALL s_voucher_unpost_upd(g_glap_m.glapld,g_glap_m.glapdocno) RETURNING l_success
               LET l_str = "write glap_t result:",l_success,"\n"
               CALL l_ch.write(l_str)
            END IF 
            
            #判断执行结果，当失败时，回滚数据库
            IF l_success = FALSE  THEN
               CALL cl_err_collect_show()
               CALL s_transaction_end('N','0') 
               #过账操作结束，写入操作结果，关闭日志文件
               LET l_str="过账还原失败，数据库回滚","\n"
               CALL l_ch.write(l_str)
               LET l_str = "操作结束单据状态：lc_state=",lc_state,"\n",
                           "                g_glap_m.glapstus=",g_glap_m.glapstus,"\n"
               CALL l_ch.write(l_str)
               LET l_str = "#--------------------------- (", CURRENT YEAR TO SECOND,"'",g_glap_m.glapdocno,"'", "unpost End) ---------------------------#\n"
               CALL l_ch.write(l_str)
               CALL l_ch.close()
               CLOSE aglt310_cl
               RETURN
            END IF 
         END IF
         EXIT MENU                  
      #end add-point
      
   END MENU
   
   #確認被選取的狀態碼在清單中
   IF (lc_state <> "N" 
      AND lc_state <> "Y"
      AND lc_state <> "S"
      AND lc_state <> "A"
      AND lc_state <> "D"
      AND lc_state <> "R"
      AND lc_state <> "W"
      AND lc_state <> "X"
      ) OR 
      g_glap_m.glapstus = lc_state OR cl_null(lc_state) THEN
      CLOSE aglt310_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
#   IF l_success = FALSE  THEN
#      CALL cl_err_collect_show()
#      CALL s_transaction_end('N','0') 
#      RETURN   
#   ELSE
   #151124-00022#2 ---s---
   IF lc_state = 'X' THEN
      #詢問
      IF NOT cl_ask_confirm('aim-00109') THEN   #是否執作廢?
         CALL s_transaction_end('N','0')        #150401-00001#13
         RETURN
      END IF
      #151125-00001#2 --- add start ---
      CALL s_voucher_void_chk(g_glap_m.glapld,g_glap_m.glapdocno) RETURNING l_success
      #當aglt310、aglt320、aglt330時，檢查細項立沖帳資料
      IF g_glap001_p MATCHES'[123]' THEN
         CALL s_voucher_void_chk_glax(g_glap_m.glapld,g_glap_m.glapdocno) RETURNING l_success1
         CALL s_voucher_void_chk_glay(g_glap_m.glapld,g_glap_m.glapdocno) RETURNING l_success2
         IF l_success1=FALSE OR l_success2=FALSE THEN
            LET l_success=FALSE
         END IF
      END IF
      IF l_success = TRUE THEN
         CALL s_voucher_void_upd(g_glap_m.glapld,g_glap_m.glapdocno) RETURNING l_success
         #當aglt310、aglt320、aglt330時，更新細項立沖帳資料
         IF g_glap001_p MATCHES'[123]'  THEN
            #170103-00019#1--mod--str--
#            CALL s_voucher_void_upd_glax(g_glap_m.glapld,g_glap_m.glapdocno) RETURNING l_success1
#            CALL s_voucher_void_upd_glay(g_glap_m.glapld,g_glap_m.glapdocno) RETURNING l_success2
#            IF l_success1=FALSE OR l_success2=FALSE THEN
#               LET l_success=FALSE
#            END IF 
            #作废相关的细项立冲账资料
            LET l_success1 = TRUE
            CALL s_pre_voucher_delete_glax(g_glap_m.glapld,g_glap_m.glapdocno,'','Y') RETURNING l_success1
            IF l_success1 = FALSE THEN
               LET l_success=FALSE
            END IF
            #170103-00019#1--mod--end
         END IF
      END IF 
      IF l_success = TRUE THEN
         #會寫前段資料傳票編號為‘ ’
         CALL aglt310_update_ap_ar() RETURNING l_success
      END IF
      
      #判断执行结果，当失败时，回滚数据库
      IF l_success = FALSE  THEN
         CALL cl_err_collect_show()
         CALL s_transaction_end('N','0')
         CLOSE aglt310_cl
         RETURN
      END IF
      #151125-00001#2 --- add end   ---
   END IF
   #151124-00022#2 ---e---
   IF l_success = TRUE  THEN
      CALL s_transaction_end('Y','0') 
      CALL cl_err_collect_init()
      CALL cl_err_collect_show()  
      #过账操作结束，写入操作结果
      IF l_log_flag = "post" THEN
         LET l_str="过账成功，数据库提交数据","\n"
         CALL l_ch.write(l_str)
      END IF
      IF l_log_flag = "unpost" THEN
         LET l_str="过账还原成功，数据库提交数据","\n"
         CALL l_ch.write(l_str)
      END IF
   END IF          
  
   #end add-point
   
   LET g_glap_m.glapmodid = g_user
   LET g_glap_m.glapmoddt = cl_get_current()
   LET g_glap_m.glapstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE glap_t 
      SET (glapstus,glapmodid,glapmoddt) 
        = (g_glap_m.glapstus,g_glap_m.glapmodid,g_glap_m.glapmoddt)     
    WHERE glapent = g_enterprise AND glapld = g_glap_m.glapld
      AND glapdocno = g_glap_m.glapdocno
    
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
         WHEN "S"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/posted.png")
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
      EXECUTE aglt310_master_referesh USING g_glap_m.glapld,g_glap_m.glapdocno INTO g_glap_m.glapld, 
          g_glap_m.glapcomp,g_glap_m.glap001,g_glap_m.glapdocno,g_glap_m.glapdocdt,g_glap_m.glap002, 
          g_glap_m.glap004,g_glap_m.glap007,g_glap_m.glap008,g_glap_m.glap010,g_glap_m.glap011,g_glap_m.glap006, 
          g_glap_m.glap015,g_glap_m.glap013,g_glap_m.glap009,g_glap_m.glap016,g_glap_m.glap017,g_glap_m.glap012, 
          g_glap_m.glap014,g_glap_m.glapstus,g_glap_m.glapownid,g_glap_m.glapcrtdp,g_glap_m.glapowndp, 
          g_glap_m.glapcrtdt,g_glap_m.glapcrtid,g_glap_m.glapmodid,g_glap_m.glapmoddt,g_glap_m.glapcnfid, 
          g_glap_m.glapcnfdt,g_glap_m.glappstid,g_glap_m.glappstdt,g_glap_m.glapld_desc,g_glap_m.glapcomp_desc, 
          g_glap_m.glap016_desc,g_glap_m.glapownid_desc,g_glap_m.glapcrtdp_desc,g_glap_m.glapowndp_desc, 
          g_glap_m.glapcrtid_desc,g_glap_m.glapmodid_desc,g_glap_m.glapcnfid_desc,g_glap_m.glappstid_desc 
 
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_glap_m.glapld,g_glap_m.glapld_desc,g_glap_m.glapcomp,g_glap_m.glapcomp_desc, 
          g_glap_m.glaa001_desc,g_glap_m.glaa016,g_glap_m.glaa020,g_glap_m.glap001,g_glap_m.glapdocno, 
          g_glap_m.glapdocdt,g_glap_m.glap002,g_glap_m.glap004,g_glap_m.glap007,g_glap_m.glap008,g_glap_m.glap010, 
          g_glap_m.glap011,g_glap_m.glap006,g_glap_m.glap006_desc,g_glap_m.glap015,g_glap_m.glap013, 
          g_glap_m.glap009,g_glap_m.sdocno,g_glap_m.glap016,g_glap_m.glap016_desc,g_glap_m.glap017,g_glap_m.glap012, 
          g_glap_m.glap014,g_glap_m.glapstus,g_glap_m.glapownid,g_glap_m.glapownid_desc,g_glap_m.glapcrtdp, 
          g_glap_m.glapcrtdp_desc,g_glap_m.glapowndp,g_glap_m.glapowndp_desc,g_glap_m.glapcrtdt,g_glap_m.glapcrtid, 
          g_glap_m.glapcrtid_desc,g_glap_m.glapmodid,g_glap_m.glapmodid_desc,g_glap_m.glapmoddt,g_glap_m.glapcnfid, 
          g_glap_m.glapcnfid_desc,g_glap_m.glapcnfdt,g_glap_m.glappstid,g_glap_m.glappstid_desc,g_glap_m.glappstdt, 
          g_glap_m.glaq017,g_glap_m.glaq017_desc,g_glap_m.glaq018,g_glap_m.glaq018_desc,g_glap_m.glaq019, 
          g_glap_m.glaq019_desc,g_glap_m.glaq020,g_glap_m.glaq020_desc,g_glap_m.glaq021,g_glap_m.glaq021_desc, 
          g_glap_m.glaq022,g_glap_m.glaq022_desc,g_glap_m.glaq023,g_glap_m.glaq023_desc,g_glap_m.glaq024, 
          g_glap_m.glaq024_desc,g_glap_m.glbc004,g_glap_m.glbc004_desc,g_glap_m.glaq051,g_glap_m.glaq052, 
          g_glap_m.glaq052_desc,g_glap_m.glaq053,g_glap_m.glaq053_desc,g_glap_m.glaq025,g_glap_m.glaq025_desc, 
          g_glap_m.glaq027,g_glap_m.glaq027_desc,g_glap_m.glaq028,g_glap_m.glaq028_desc,g_glap_m.glaq029, 
          g_glap_m.glaq029_desc,g_glap_m.glaq030,g_glap_m.glaq030_desc,g_glap_m.glaq031,g_glap_m.glaq031_desc, 
          g_glap_m.glaq032,g_glap_m.glaq032_desc,g_glap_m.glaq033,g_glap_m.glaq033_desc,g_glap_m.glaq034, 
          g_glap_m.glaq034_desc,g_glap_m.glaq035,g_glap_m.glaq035_desc,g_glap_m.glaq036,g_glap_m.glaq036_desc, 
          g_glap_m.glaq037,g_glap_m.glaq037_desc,g_glap_m.glaq038,g_glap_m.glaq038_desc,g_glap_m.glaq005_1, 
          g_glap_m.glaq006_1,g_glap_m.glaq010_1,g_glap_m.glaq007,g_glap_m.glaq008,g_glap_m.glaq009,g_glap_m.glaq011, 
          g_glap_m.glaq012,g_glap_m.glaq013,g_glap_m.glaq013_desc,g_glap_m.glaq014,g_glap_m.glaq015, 
          g_glap_m.glaq015_desc,g_glap_m.glaq016,g_glap_m.glaq016_desc,g_glap_m.conf,g_glap_m.post,g_glap_m.creat 
 
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   IF l_log_flag = "post" THEN
      LET l_str = "当过账结束后，架构产生的更新glap状态操作：","\n",
                  "SQLCA.sqlcode = ",SQLCA.sqlcode,"\n",
                  "SQLCA.sqlerrd[3] = ",SQLCA.sqlerrd[3],"\n"
      CALL l_ch.write(l_str)
      LET l_str = "操作结束单据状态：lc_state=",lc_state,"\n",
                  "                g_glap_m.glapstus=",g_glap_m.glapstus,"\n"
      CALL l_ch.write(l_str)
      LET l_str = "#--------------------------- (", CURRENT YEAR TO SECOND,"'",g_glap_m.glapdocno,"'", "post End) -----------------------------#\n"
      CALL l_ch.write(l_str)
      CALL l_ch.close()
   END IF
   IF l_log_flag = "unpost" THEN
      LET l_str = "当过账还原结束后，架构产生的更新glap状态操作：","\n",
                  "SQLCA.sqlcode = ",SQLCA.sqlcode,"\n",
                  "SQLCA.sqlerrd[3] = ",SQLCA.sqlerrd[3],"\n"
      CALL l_ch.write(l_str)
      LET l_str = "操作结束单据状态：lc_state=",lc_state,"\n",
                  "                g_glap_m.glapstus=",g_glap_m.glapstus,"\n"
      CALL l_ch.write(l_str)
      LET l_str = "#--------------------------- (", CURRENT YEAR TO SECOND,"'",g_glap_m.glapdocno,"'", "unpost End) ---------------------------#\n"
      CALL l_ch.write(l_str)
      CALL l_ch.close()
   END IF
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   LET g_glap_m.post = g_glap_m.glappstid_desc
   LET g_glap_m.conf = g_glap_m.glapcnfid_desc
   LET g_glap_m.creat = g_glap_m.glapcrtid_desc
   DISPLAY BY NAME g_glap_m.conf,g_glap_m.post,g_glap_m.creat 
   #end add-point  
 
   CLOSE aglt310_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aglt310_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aglt310.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION aglt310_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
            
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_glaq_d.getLength() THEN
         LET g_detail_idx = g_glaq_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_glaq_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_glaq_d.getLength() TO FORMONLY.cnt
   END IF
   
 
   
   #add-point:idx_chk段other name="idx_chk.other"
            
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aglt310.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aglt310_b_fill2(pi_idx)
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
   
   CALL aglt310_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="aglt310.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION aglt310_fill_chk(ps_idx)
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
 
{<section id="aglt310.status_show" >}
PRIVATE FUNCTION aglt310_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aglt310.mask_functions" >}
&include "erp/agl/aglt310_mask.4gl"
 
{</section>}
 
{<section id="aglt310.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION aglt310_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   DEFINE l_success    LIKE type_t.num5
   DEFINE l_success1   LIKE type_t.num5
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
 
 
   CALL aglt310_show()
   CALL aglt310_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
 
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_glap_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_glaq_d))
 
 
   # cl_bpm_cli() 裡有包含以前的aws_condition()=>送簽資料檢核和更新單據狀況碼為'W'
   # cl_bpm_cli() 傳入參數:無  ;  回傳值: 0 開單失敗; 1 開單成功
 
   #add-point: 提交前的ADP name="send.before_cli"
   #確認前檢核段 zhujing add 2015-5-27(S)
   CALL cl_err_collect_init()
   CALL s_voucher_conf_chk(g_glap_m.glapld,g_glap_m.glapdocno) RETURNING l_success
   #當aglt310、aglt320、aglt330時，判斷是否進行細項里沖帳，并進行檢查
   IF g_glap001_p MATCHES'[123]' THEN
      CALL aglt310_glax_and_glay_chk(g_glap_m.glapld,g_glap_m.glapdocno) RETURNING l_success1
      IF l_success = TRUE THEN
         LET l_success=l_success1
      END IF
   END IF
   CALL cl_err_collect_show()
   IF l_success = FALSE THEN
      CLOSE aglt310_cl
      CALL s_transaction_end('N','0')
      RETURN FALSE
   END IF
   # zhujing add 2015-5-27(E)
   #end add-point
 
   #開單失敗
   IF NOT cl_bpm_cli() THEN 
      RETURN FALSE
   END IF
 
   #add-point: 提交後的ADP name="send.after_send"
   
   #end add-point
 
   #此段落不需要刪除資料,但是否需要refresh圖片樣式???
   #CALL aglt310_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL aglt310_ui_headershow()
   CALL aglt310_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION aglt310_draw_out()
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
   CALL aglt310_ui_headershow()  
   CALL aglt310_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="aglt310.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION aglt310_set_pk_array()
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
   LET g_pk_array[1].values = g_glap_m.glapld
   LET g_pk_array[1].column = 'glapld'
   LET g_pk_array[2].values = g_glap_m.glapdocno
   LET g_pk_array[2].column = 'glapdocno'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aglt310.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="aglt310.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION aglt310_msgcentre_notify(lc_state)
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
   CALL aglt310_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_glap_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aglt310.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION aglt310_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#14 -s by 08172
   SELECT glapstus  INTO g_glap_m.glapstus
     FROM glap_t
    WHERE glapent = g_enterprise
      AND glapld = g_glap_m.glapld
      AND glapdocno = g_glap_m.glapdocno
   LET g_errno = ''
   IF (g_action_choice="modify" OR g_action_choice="modify_detail" OR g_action_choice="delete")  THEN
     CASE g_glap_m.glapstus
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
        LET g_errparam.extend = g_glap_m.glapdocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL aglt310_show()
        RETURN FALSE
     END IF
   END IF
   #160818-00017#14 -e by 08172
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aglt310.other_function" readonly="Y" >}
#+自由核算项维护
PRIVATE FUNCTION aglt310_free_account()
   DEFINE  l_success   LIKE type_t.num5
   DEFINE  l_cnt       LIKE type_t.num5
   DEFINE l_today      DATETIME YEAR TO SECOND  
   
   LET l_success = TRUE
    
    UPDATE glaq_t SET glaq029 = g_glaq029,
                      glaq030 = g_glaq030,
                      glaq031 = g_glaq031,
                      glaq032 = g_glaq032,
                      glaq033 = g_glaq033,
                      glaq034 = g_glaq034,
                      glaq035 = g_glaq035,
                      glaq036 = g_glaq036,
                      glaq037 = g_glaq037,
                      glaq038 = g_glaq038
           
    WHERE glaqent = g_enterprise
      AND glaqld = g_glap_m.glapld
      AND glaqdocno = g_glap_m.glapdocno
      AND glaqseq =   g_glaq_d[g_detail_idx].glaqseq

    IF SQLCA.SQLCODE THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = sqlca.sqlcode
       LET g_errparam.extend = 'update_b1'
       LET g_errparam.popup = TRUE
       CALL cl_err()
 
       LET l_success = FALSE
    ELSE
       #當aglt310、aglt320、aglt330時判斷是否進行細項立沖,如果是同步細項立帳異動檔glax_t
       IF g_glap001_p MATCHES '[123]' AND l_success=TRUE THEN 
          SELECT COUNT(1) INTO l_cnt FROM glax_t #161205-00025#4 mod '*'-->1
           WHERE glaxent=g_enterprise AND glaxld=g_glap_m.glapld
             AND glaxdocno=g_glap_m.glapdocno
             AND glaxseq=g_glaq_d[g_detail_idx].glaqseq
           IF l_cnt>0 THEN
              LET l_today = cl_get_current()
              UPDATE glax_t
                 SET glax029=g_glaq029,
                     glax030=g_glaq030,
                     glax031=g_glaq031,
                     glax032=g_glaq032,
                     glax033=g_glaq033,
                     glax034=g_glaq034,
                     glax035=g_glaq035,
                     glax036=g_glaq036,
                     glax037=g_glaq037,
                     glax038=g_glaq038,
                     glaxmodid=g_user,
                     glaxmoddt=l_today
               WHERE glaxent=g_enterprise AND glaxld=g_glap_m.glapld
                 AND glaxdocno=g_glap_m.glapdocno
                 AND glaxseq=g_glaq_d[g_detail_idx].glaqseq
              IF SQLCA.SQLCODE THEN
                 INITIALIZE g_errparam TO NULL
       LET g_errparam.code = sqlca.sqlcode
       LET g_errparam.extend = 'update_b1'
       LET g_errparam.popup = TRUE
       CALL cl_err()
 
                 LET l_success = FALSE
              END IF 
           END IF
       END IF        
    END IF 
    RETURN l_success
END FUNCTION
##點擊單身資料顯示其業務資訊，核算項信息
PRIVATE FUNCTION aglt310_b_detail()
   DEFINE l_cnt         LIKE type_t.num5
   DEFINE l_glaq014     LIKE glaq_t.glaq014
   
   IF g_detail_idx <=0 THEN
      RETURN
   END IF
#161205-00025#4--add--str--
   EXECUTE aglt310_sel_refresh_pr 
     USING g_glap_m.glapld,g_glap_m.glapdocno,g_glaq_d[g_detail_idx].glaqseq
      INTO g_glap_m.glaq005_1,g_glap_m.glaq006_1,g_glap_m.glaq007,g_glap_m.glaq008,g_glap_m.glaq009,g_glap_m.glaq010_1,
           g_glap_m.glaq011,g_glap_m.glaq012,g_glap_m.glaq013,g_glap_m.glaq014,g_glap_m.glaq015,g_glap_m.glaq016,
           g_glap_m.glaq017,g_glap_m.glaq018,g_glap_m.glaq019,g_glap_m.glaq020,g_glap_m.glaq021,g_glap_m.glaq022,
           g_glap_m.glaq023,g_glap_m.glaq024,g_glap_m.glaq051,g_glap_m.glaq052,g_glap_m.glaq053,
           g_glap_m.glaq025,g_glap_m.glaq027,g_glap_m.glaq028,
           g_glap_m.glaq029,g_glap_m.glaq030,g_glap_m.glaq031,g_glap_m.glaq032,g_glap_m.glaq033,
           g_glap_m.glaq034,g_glap_m.glaq035,g_glap_m.glaq036,g_glap_m.glaq037,g_glap_m.glaq038,
           g_glap_m.glaq017_desc,g_glap_m.glaq018_desc,g_glap_m.glaq019_desc,
           g_glap_m.glaq020_desc,g_glap_m.glaq021_desc,g_glap_m.glaq022_desc,g_glap_m.glaq023_desc,
           g_glap_m.glaq024_desc,g_glap_m.glaq025_desc,g_glap_m.glaq027_desc,g_glap_m.glaq028_desc,
           g_glap_m.glaq052_desc,g_glap_m.glaq053_desc,g_glap_m.glaq013_desc,g_glap_m.glaq015_desc,g_glap_m.glaq016_desc,
           g_glad0171,g_glad0181,g_glad0191,g_glad0201,g_glad0211,
           g_glad0221,g_glad0231,g_glad0241,g_glad0251,g_glad0261
#161205-00025#4--add--end
#161205-00025#4--mark--str--   
#   SELECT glaq005,glaq006,glaq007,glaq008,glaq009,glaq010,
#          glaq011,glaq012,glaq013,glaq014,glaq015,glaq016,
#          glaq017,glaq018,glaq019,glaq020,glaq021,glaq022,
#          glaq023,glaq024,glaq051,glaq052,glaq053,glaq025,glaq027,glaq028,
#          glaq029,glaq030,glaq031,glaq032,glaq033,glaq034,
#          glaq035,glaq036,glaq037,glaq038
#     INTO g_glap_m.glaq005_1,g_glap_m.glaq006_1,g_glap_m.glaq007,g_glap_m.glaq008,g_glap_m.glaq009,g_glap_m.glaq010_1,
#          g_glap_m.glaq011,g_glap_m.glaq012,g_glap_m.glaq013,g_glap_m.glaq014,g_glap_m.glaq015,g_glap_m.glaq016,
#          g_glap_m.glaq017,g_glap_m.glaq018,g_glap_m.glaq019,g_glap_m.glaq020,g_glap_m.glaq021,g_glap_m.glaq022,
#          g_glap_m.glaq023,g_glap_m.glaq024,g_glap_m.glaq051,g_glap_m.glaq052,g_glap_m.glaq053,
#          g_glap_m.glaq025,g_glap_m.glaq027,g_glap_m.glaq028,
#          g_glap_m.glaq029,g_glap_m.glaq030,g_glap_m.glaq031,g_glap_m.glaq032,g_glap_m.glaq033,
#          g_glap_m.glaq034,g_glap_m.glaq035,g_glap_m.glaq036,g_glap_m.glaq037,g_glap_m.glaq038
#     FROM glaq_t
#    WHERE glaqent = g_enterprise
#      AND glaqld = g_glap_m.glapld
#      AND glaqdocno = g_glap_m.glapdocno
#      AND glaqseq = g_glaq_d[g_detail_idx].glaqseq

#   #抓取說明
#   CALL aglt310_glaq013_desc(g_glap_m.glaq013) RETURNING g_glap_m.glaq013_desc
#   DISPLAY BY NAME g_glap_m.glaq013_desc     
#   CALL aglt310_ooef001_desc(g_glap_m.glaq017) RETURNING g_glap_m.glaq017_desc
#   DISPLAY BY NAME g_glap_m.glaq017_desc
#   CALL aglt310_ooef001_desc(g_glap_m.glaq018) RETURNING g_glap_m.glaq018_desc
#   DISPLAY BY NAME g_glap_m.glaq018_desc
#   CALL aglt310_ooef001_desc(g_glap_m.glaq019) RETURNING g_glap_m.glaq019_desc
#   DISPLAY BY NAME g_glap_m.glaq019_desc 
#    CALL aglt310_glaq020_desc('287',g_glap_m.glaq020) RETURNING g_glap_m.glaq020_desc
#   DISPLAY BY NAME g_glap_m.glaq020_desc     
#   CALL aglt310_glaq021_desc(g_glap_m.glaq021) RETURNING g_glap_m.glaq021_desc
#   DISPLAY BY NAME g_glap_m.glaq021_desc     
#   CALL aglt310_glaq021_desc(g_glap_m.glaq022) RETURNING g_glap_m.glaq022_desc
#   DISPLAY BY NAME g_glap_m.glaq022_desc
#   CALL aglt310_glaq020_desc('281',g_glap_m.glaq023) RETURNING g_glap_m.glaq023_desc
#   DISPLAY BY NAME g_glap_m.glaq023_desc          
#   CALL aglt310_glaq024_desc(g_glap_m.glaq024) RETURNING g_glap_m.glaq024_desc
#   DISPLAY BY NAME g_glap_m.glaq024_desc       
#   CALL aglt310_glaq013_desc(g_glap_m.glaq025) RETURNING g_glap_m.glaq025_desc
#   DISPLAY BY NAME g_glap_m.glaq025_desc 
##   CALL aglt310_glaq026_desc(g_glap_m.glaq026) RETURNING g_glap_m.glaq026_desc
##   DISPLAY BY NAME g_glap_m.glaq026_desc       
#   CALL aglt310_glaq052_desc(g_glap_m.glaq052) RETURNING g_glap_m.glaq052_desc
#   DISPLAY BY NAME g_glap_m.glaq052_desc
#   CALL aglt310_glaq020_desc('2002',g_glap_m.glaq053) RETURNING g_glap_m.glaq053_desc
#   DISPLAY BY NAME g_glap_m.glaq053_desc
#   CALL s_desc_get_project_desc(g_glap_m.glaq027) RETURNING g_glap_m.glaq027_desc
#   DISPLAY BY NAME g_glap_m.glaq027_desc
#   CALL s_desc_get_wbs_desc(g_glap_m.glaq027,g_glap_m.glaq028) RETURNING g_glap_m.glaq028_desc
#   DISPLAY BY NAME g_glap_m.glaq028_desc
#   
#   #151223-00004#1--add--str--lujh
#   CALL aglt310_glaq015_desc()
#   CALL aglt310_glaq016_desc()
#   #151223-00004#1--add--end--lujh
#
#   SELECT glad0171,glad0181,glad0191,glad0201,glad0211,
#          glad0221,glad0231,glad0241,glad0251,glad0261
#     INTO g_glad0171,g_glad0181,g_glad0191,g_glad0201,g_glad0211,
#          g_glad0221,g_glad0231,g_glad0241,g_glad0251,g_glad0261
#     FROM glad_t
#    WHERE gladent=g_enterprise AND gladld=g_glap_m.glapld AND glad001=g_glaq_d[g_detail_idx].glaq002
#161205-00025#4--mark--end

   #自由核算項說明
   CALL s_voucher_free_account_desc(g_glad0171,g_glap_m.glaq029) RETURNING g_glap_m.glaq029_desc
   DISPLAY BY NAME g_glap_m.glaq029_desc
   CALL s_voucher_free_account_desc(g_glad0181,g_glap_m.glaq030) RETURNING g_glap_m.glaq030_desc
   DISPLAY BY NAME g_glap_m.glaq030_desc
   CALL s_voucher_free_account_desc(g_glad0191,g_glap_m.glaq031) RETURNING g_glap_m.glaq031_desc
   DISPLAY BY NAME g_glap_m.glaq031_desc
   CALL s_voucher_free_account_desc(g_glad0201,g_glap_m.glaq032) RETURNING g_glap_m.glaq032_desc
   DISPLAY BY NAME g_glap_m.glaq032_desc
   CALL s_voucher_free_account_desc(g_glad0211,g_glap_m.glaq033) RETURNING g_glap_m.glaq033_desc
   DISPLAY BY NAME g_glap_m.glaq033_desc
   CALL s_voucher_free_account_desc(g_glad0221,g_glap_m.glaq034) RETURNING g_glap_m.glaq034_desc
   DISPLAY BY NAME g_glap_m.glaq034_desc
   CALL s_voucher_free_account_desc(g_glad0231,g_glap_m.glaq035) RETURNING g_glap_m.glaq035_desc
   DISPLAY BY NAME g_glap_m.glaq035_desc
   CALL s_voucher_free_account_desc(g_glad0241,g_glap_m.glaq036) RETURNING g_glap_m.glaq036_desc
   DISPLAY BY NAME g_glap_m.glaq036_desc
   CALL s_voucher_free_account_desc(g_glad0251,g_glap_m.glaq037) RETURNING g_glap_m.glaq037_desc
   DISPLAY BY NAME g_glap_m.glaq037_desc
   CALL s_voucher_free_account_desc(g_glad0261,g_glap_m.glaq038) RETURNING g_glap_m.glaq038_desc
   DISPLAY BY NAME g_glap_m.glaq038_desc
   
   #現金變動碼
   LET g_glap_m.glbc004=''
   LET g_glap_m.glbc004_desc=''
   LET l_cnt=0
#161205-00025#4--mark--str--
#   SELECT COUNT(*) INTO l_cnt FROM glbc_t
#    WHERE glbcent = g_enterprise AND glbcld = g_glap_m.glapld
#      AND glbcdocno = g_glap_m.glapdocno
#      AND glbcseq = g_glaq_d[g_detail_idx].glaqseq
#      AND glbc001 = g_glap_m.glap002 
#      AND glbc002 = g_glap_m.glap004
#161205-00025#4--mark--end
   #161205-00025#4--add--str--
   EXECUTE aglt310_cnt_glbc004_pr 
     USING g_glap_m.glapld,g_glap_m.glapdocno,g_glaq_d[g_detail_idx].glaqseq,g_glap_m.glap002,g_glap_m.glap004
      INTO l_cnt
   #161205-00025#4--add--end
   IF l_cnt=1 THEN
#161205-00025#4--mark--str--
#      SELECT glbc004 INTO g_glap_m.glbc004 FROM glbc_t
#       WHERE glbcent = g_enterprise AND glbcld = g_glap_m.glapld
#         AND glbcdocno = g_glap_m.glapdocno
#         AND glbcseq = g_glaq_d[g_detail_idx].glaqseq
#         AND glbc001 = g_glap_m.glap002 
#         AND glbc002 = g_glap_m.glap004
#      IF NOT cl_null(g_glap_m.glbc004) THEN
#         CALL s_desc_get_nmail004_desc(g_glaa005,g_glap_m.glbc004)  RETURNING g_glap_m.glbc004_desc
#      END IF
#161205-00025#4--mark--end
      #161205-00025#4--add--str--
      EXECUTE aglt310_sel_glbc004_pr 
        USING g_glaa005,g_glap_m.glapld,g_glap_m.glapdocno,g_glaq_d[g_detail_idx].glaqseq,g_glap_m.glap002,g_glap_m.glap004
         INTO g_glap_m.glbc004,g_glap_m.glbc004_desc
      #161205-00025#4--add--end
   END IF
   DISPLAY BY NAME g_glap_m.glbc004_desc
   
   DISPLAY BY NAME 
          g_glap_m.glaq005_1,g_glap_m.glaq006_1,g_glap_m.glaq007,g_glap_m.glaq008,g_glap_m.glaq009,g_glap_m.glaq010_1,
          g_glap_m.glaq011,g_glap_m.glaq012,g_glap_m.glaq013,g_glap_m.glaq014,g_glap_m.glaq015,g_glap_m.glaq016,
          g_glap_m.glaq017,g_glap_m.glaq018,g_glap_m.glaq019,g_glap_m.glaq020,g_glap_m.glaq021,g_glap_m.glaq022,
          g_glap_m.glaq023,g_glap_m.glaq024,g_glap_m.glaq051,g_glap_m.glaq052,g_glap_m.glaq053,
          g_glap_m.glaq025,g_glap_m.glaq027,g_glap_m.glaq028,g_glap_m.glbc004,
          g_glap_m.glaq029,g_glap_m.glaq030,g_glap_m.glaq031,g_glap_m.glaq032,g_glap_m.glaq033,
          g_glap_m.glaq034,g_glap_m.glaq035,g_glap_m.glaq036,g_glap_m.glaq037,g_glap_m.glaq038
          #161205-00025#4--add--str--
         ,g_glap_m.glaq017_desc,g_glap_m.glaq018_desc,g_glap_m.glaq019_desc,
          g_glap_m.glaq020_desc,g_glap_m.glaq021_desc,g_glap_m.glaq022_desc,g_glap_m.glaq023_desc,
          g_glap_m.glaq024_desc,g_glap_m.glaq025_desc,g_glap_m.glaq027_desc,g_glap_m.glaq028_desc,
          g_glap_m.glaq052_desc,g_glap_m.glaq053_desc,g_glap_m.glaq013_desc,g_glap_m.glaq015_desc,g_glap_m.glaq016_desc
          #161205-00025#4--add--end
   #160122-00001#34 add -str
   LET l_glaq014 = g_glap_m.glaq014
   CALL aglt310_get_lc_glaq014(g_glap_m.glaq014) RETURNING g_glap_m.glaq014
   DISPLAY BY NAME g_glap_m.glaq014
   LET g_glap_m.glaq014 = l_glaq014
   #160122-00001#34 add -end

END FUNCTION
#+ 更新業務諮詢核算項資料
PRIVATE FUNCTION aglt310_update_forzen()
    DEFINE  l_success   LIKE type_t.num5
    DEFINE  l_cnt       LIKE type_t.num5
    
    LET l_success = TRUE
    #数量，单价，金额不可为空
    IF cl_null(g_glap_m.glaq008) THEN  LET g_glap_m.glaq008 = 0 END IF 
    IF cl_null(g_glap_m.glaq009) THEN  LET g_glap_m.glaq009 = 0 END IF 
    #设置未启用核算项等于空格
    CALL aglt310_glaq002_open_chk(g_glaq_d[l_ac].glaq002)
    UPDATE glaq_t SET glaq007 = g_glap_m.glaq007,
                      glaq008 = g_glap_m.glaq008,
                      glaq009 = g_glap_m.glaq009,
                      glaq011 = g_glap_m.glaq011,
                      glaq012 = g_glap_m.glaq012,
                      glaq013 = g_glap_m.glaq013,
                      glaq014 = g_glap_m.glaq014,
                      glaq015 = g_glap_m.glaq015,
                      glaq016 = g_glap_m.glaq016,
                      glaq017 = g_glaq_r.glaq017,
                      glaq018 = g_glaq_r.glaq018,
                      glaq019 = g_glaq_r.glaq019,
                      glaq020 = g_glaq_r.glaq020,
                      glaq021 = g_glaq_r.glaq021,
                      glaq022 = g_glaq_r.glaq022,
                      glaq023 = g_glaq_r.glaq023,
                      glaq024 = g_glaq_r.glaq024,
                      glaq051 = g_glaq_r.glaq051,
                      glaq052 = g_glaq_r.glaq052,
                      glaq053 = g_glaq_r.glaq053,
                      glaq025 = g_glaq_r.glaq025,
                      glaq027 = g_glaq_r.glaq027,
                      glaq028 = g_glaq_r.glaq028,
                      glaq029 = g_glaq_r.glaq029,
                      glaq030 = g_glaq_r.glaq030,
                      glaq031 = g_glaq_r.glaq031,
                      glaq032 = g_glaq_r.glaq032,
                      glaq033 = g_glaq_r.glaq033,
                      glaq034 = g_glaq_r.glaq034,
                      glaq035 = g_glaq_r.glaq035,
                      glaq036 = g_glaq_r.glaq036,
                      glaq037 = g_glaq_r.glaq037,
                      glaq038 = g_glaq_r.glaq038
    WHERE glaqent = g_enterprise
      AND glaqld = g_glap_m.glapld
      AND glaqdocno = g_glap_m.glapdocno
      AND glaqseq =   g_glaq_d[l_ac].glaqseq

    IF SQLCA.SQLCODE THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = sqlca.sqlcode
       LET g_errparam.extend = 'upd glaq_t'
       LET g_errparam.popup = TRUE
       CALL cl_err()
 
       LET l_success = FALSE
    ELSE
       #當aglt310、aglt320、aglt330時判斷是否進行細項立沖,如果是同步細項立帳異動檔glax_t
       IF g_glap001_p MATCHES '[123]' AND l_success=TRUE THEN 
          SELECT COUNT(1) INTO l_cnt FROM glax_t #161205-00025#4 mod '*'-->1
           WHERE glaxent=g_enterprise AND glaxld=g_glap_m.glapld
             AND glaxdocno=g_glap_m.glapdocno
             AND glaxseq=g_glaq_d[l_ac].glaqseq
          IF l_cnt>0 THEN
             UPDATE glax_t 
                SET glax007 = g_glap_m.glaq007,
                    glax008 = g_glap_m.glaq008,
                    glax009 = g_glap_m.glaq009,
                    glax011 = g_glap_m.glaq011,
                    glax012 = g_glap_m.glaq012,
                    glax013 = g_glap_m.glaq013,
                    glax014 = g_glap_m.glaq014,
                    glax015 = g_glap_m.glaq015,
                    glax016 = g_glap_m.glaq016,
                    glax017 = g_glaq_r.glaq017,
                    glax018 = g_glaq_r.glaq018,
                    glax019 = g_glaq_r.glaq019,
                    glax020 = g_glaq_r.glaq020,
                    glax021 = g_glaq_r.glaq021,
                    glax022 = g_glaq_r.glaq022,
                    glax023 = g_glaq_r.glaq023,
                    glax024 = g_glaq_r.glaq024,
                    glax061 = g_glaq_r.glaq051,
                    glax062 = g_glaq_r.glaq052,
                    glax063 = g_glaq_r.glaq053,
                    glax025 = g_glaq_r.glaq025,
                    glax027 = g_glaq_r.glaq027,
                    glax028 = g_glaq_r.glaq028,
                    glax029 = g_glaq_r.glaq029,
                    glax030 = g_glaq_r.glaq030,
                    glax031 = g_glaq_r.glaq031,
                    glax032 = g_glaq_r.glaq032,
                    glax033 = g_glaq_r.glaq033,
                    glax034 = g_glaq_r.glaq034,
                    glax035 = g_glaq_r.glaq035,
                    glax036 = g_glaq_r.glaq036,
                    glax037 = g_glaq_r.glaq037,
                    glax038 = g_glaq_r.glaq038
              WHERE glaxent = g_enterprise
                AND glaxld = g_glap_m.glapld
                AND glaxdocno = g_glap_m.glapdocno
                AND glaxseq =   g_glaq_d[l_ac].glaqseq

             IF SQLCA.SQLCODE THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = sqlca.sqlcode
                LET g_errparam.extend = 'update glax_t'
                LET g_errparam.popup = TRUE
                CALL cl_err()
                LET l_success = FALSE
             END IF 
          END IF
       END IF
    END IF 
    RETURN l_success
END FUNCTION
#+ 營運據點/部門/利潤成本中心
PRIVATE FUNCTION aglt310_ooef001_desc(p_ooef001)
   DEFINE p_ooef001     LIKE ooef_t.ooef001
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] =p_ooef001
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   RETURN g_rtn_fields[1]
END FUNCTION
#+ 原传票编号检查
PRIVATE FUNCTION aglt310_glap015_chk(p_glap015)
   DEFINE p_glap015     LIKE glap_t.glap015
   DEFINE l_glapstus    LIKE glap_t.glapstus
   
   LET g_errno= ''
   #检查存在性，而且为已过账的资料
   SELECT glapstus INTO l_glapstus  FROM glap_t
    WHERE glapent = g_enterprise
      AND glapld = g_glap_m.glapld
      AND glapdocno = p_glap015
     
   CASE 
      WHEN SQLCA.SQLCODE = 100    LET g_errno ='agl-00018'
      WHEN l_glapstus <>'S'       LET g_errno ='agl-00017'
   END CASE     
END FUNCTION
#科目说明
PRIVATE FUNCTION aglt310_glap006_desc(p_glap006)
   DEFINE p_glap006    LIKE glap_t.glap006
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_glap006
   CALL ap_ref_array2(g_ref_fields,"SELECT glacl004 FROM glacl_t WHERE glaclent='"||g_enterprise||"' AND glacl001 = '"||g_glaa004||"' AND glacl002 = ? AND glacl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   RETURN  g_rtn_fields[1]
END FUNCTION
#由原传票编号带出单身资料
PRIVATE FUNCTION aglt310_glap015_ins()
   DEFINE l_sql      STRING 
   DEFINE r_success  LIKE type_t.num5
   DEFINE l_cnt      LIKE type_t.num5
   #160509-00004#103--add--str--lujh
   DEFINE l_red      LIKE type_t.chr10   
   DEFINE l_slip     STRING              
   DEFINE l_success  LIKE type_t.num5
   #160509-00004#103--add--end--lujh
   
   LET r_success = TRUE
   
   #160509-00004#103--add--str--lujh
   CALL s_aooi200_fin_get_slip(g_glap_m.glapdocno) RETURNING l_success,l_slip  
   CALL s_fin_get_doc_para(g_glap_m.glapld,g_glap_m.glapcomp,l_slip,'D-FIN-1002') RETURNING l_red
   #160509-00004#103--add--end--lujh   
   
   #依据原传票编号带出单身，只是借贷互置
   LET l_sql = " INSERT INTO glaq_t(glaqent,glaqcomp,glaqld,glaqdocno,glaqseq,glaq001,glaq002,glaq003, ",
               " glaq004,glaq005,glaq006,glaq007,glaq008,glaq009,glaq010,glaq011,glaq012,glaq013 ,",
               " glaq014,glaq015,glaq016,glaq017,glaq018,glaq019,glaq020,glaq021,glaq022,glaq023, ",
               " glaq024,glaq025,glaq027,glaq028,glaq029,glaq030,glaq031,glaq032,glaq033, ",
               " glaq051,glaq052,glaq053,",
               " glaq034,glaq035,glaq036,glaq037,glaq038,glaq039,glaq040,glaq041,glaq042,glaq043,glaq044 )",
               "  SELECT '",g_enterprise,"','",g_glap_m.glapcomp,"','",g_glap_m.glapld,"','",g_glap_m.glapdocno,"',glaqseq,glaq001,glaq002,",
               "         CASE WHEN '",l_red,"' = 'Y' THEN glaq003*-1 ELSE glaq004 END, ",     #160509-00004#103 add lujh
               "         CASE WHEN '",l_red,"' = 'Y' THEN glaq004*-1 ELSE glaq003 END, ",     #160509-00004#103 add lujh
               " glaq005,glaq006,glaq007,glaq008,glaq009,glaq010,glaq011,glaq012,glaq013 ,",
               " glaq014,glaq015,glaq016,glaq017,glaq018,glaq019,glaq020,glaq021,glaq022,glaq023, ",
               " glaq024,glaq025,glaq027,glaq028,glaq029,glaq030,glaq031,glaq032,glaq033, ",
               " glaq051,glaq052,glaq053,",
               " glaq034,glaq035,glaq036,glaq037,glaq038,glaq039,glaq041,glaq040,glaq042,glaq044,glaq043 ", 
               "  FROM glaq_t ",
               "   WHERE glaqent = '",g_enterprise,"'",
               "     AND glaqld = '",g_glap_m.glapld,"'",
               "     AND glaqdocno = '",g_glap_m.glap015,"'"
  
   PREPARE aglt310_glap015_pr  FROM l_sql
   EXECUTE aglt310_glap015_pr  
             
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'Insert glaq_t error!'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
   END IF

   #同步产生现金变动码资料
   SELECT COUNT(1) INTO l_cnt FROM glbc_t #161205-00025#4 mod '*'-->1
    WHERE glbcent= g_enterprise AND glbc010 = '1'
     AND glbcld = g_glap_m.glapld AND glbcdocno = g_glap_m.glap015
   IF l_cnt > 0 THEN
      LET l_sql = "INSERT INTO glbc_t(",
                  " glbcent,glbcld,glbccomp,glbcdocno,",
                  " glbcseq,glbcseq1,glbc001,glbc002,",
                  " glbc003,",
                  " glbc004,glbc005,glbc006,glbc007,",
                  " glbc008,glbc009,glbc010,glbc011,glbc012,glbc013,glbc014,",
                  " glbc015 )",                                                #151013-00016#6 add glbc015
                  " SELECT ",g_enterprise,",'",g_glap_m.glapld,"','",g_glap_m.glapcomp,"','",g_glap_m.glapdocno,"',",
                  "        glbcseq,glbcseq1,",g_glap_m.glap002,",",g_glap_m.glap004,",",
                  "        CASE WHEN glbc003='1' THEN '2' ELSE '1' END CASE,",   
                  "        glbc004,glbc005,glbc006,glbc007,",
                  #"        glbc008,glbc009,glbc010,glbc011,glbc012,glbc013,glbc014",g_glap_m.glapstus," ", #151013-00016#6 add glapstus  #160509-00004#103 mark lujh
                  "        glbc008,glbc009,glbc010,glbc011,glbc012,glbc013,glbc014, '",g_glap_m.glapstus,"' ",   #160509-00004#103 add lujh
                  "   FROM glbc_t ",
                  "  WHERE glbcent = ",g_enterprise," AND glbc010 = '1'",
                  "    AND glbcld = '",g_glap_m.glapld,"'",
                  "    AND glbcdocno = '",g_glap_m.glap015,"'"
      PREPARE aglt310_ins_glbc_pr  FROM l_sql
      EXECUTE aglt310_ins_glbc_pr  
                
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'Insert glbc_t error!'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
      END IF
   END IF
   
   RETURN r_success
END FUNCTION
#+转账传票，回传传票，应计传票更新单头金额档
PRIVATE FUNCTION aglt310_glap001_1(p_glap001)
    DEFINE p_glap001   LIKE glap_t.glap001
    DEFINE l_glap010   LIKE glap_t.glap010
    DEFINE l_glap011   LIKE glap_t.glap011
    DEFINE l_cnt       LIKE type_t.num5
    
    #如果单头取消，则不需执行更新操作
     SELECT COUNT(1) INTO l_cnt #161205-00025#4 mod '*'-->1
      FROM glap_t
     WHERE glapent = g_enterprise
       AND glapld = g_glap_m.glapld
       AND glapdocno = g_glap_m.glapdocno
       AND glap001 = p_glap001
     IF l_cnt = 0 THEN
        RETURN
     END IF 

    #开始执行操作
    CALL s_transaction_begin()   
    SELECT SUM(glaq003),SUM(glaq004) INTO l_glap010,l_glap011
      FROM glaq_t,glap_t
     WHERE glapent = glaqent
       AND glapld = glaqld
       AND glapdocno = glaqdocno
       AND glaqent = g_enterprise
       AND glaqld = g_glap_m.glapld
       AND glaqdocno = g_glap_m.glapdocno
       AND glap001 = p_glap001
     
     #回传传票时，借贷互置，否则正常  
     IF p_glap001 = '4' THEN
        LET g_glap_m.glap010 = l_glap011
        LET g_glap_m.glap011 = l_glap010
     ELSE
        LET g_glap_m.glap010 = l_glap010
        LET g_glap_m.glap011 = l_glap011     
     END IF 
     
      UPDATE glap_t SET glap010 = g_glap_m.glap010,
                        glap011 = g_glap_m.glap011
      WHERE glapent = g_enterprise
         AND glapld = g_glap_m.glapld
         AND glapdocno = g_glap_m.glapdocno
         AND glap001 = g_glap001_p
   
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = sqlca.sqlcode
         LET g_errparam.extend = 'UPD'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         CALL s_transaction_end('N','0')
      ELSE
         CALL s_transaction_end('Y','0')      
      END IF 
END FUNCTION
#科目检查
PRIVATE FUNCTION aglt310_glap006_chk(p_glap006)
   DEFINE p_glap006    LIKE glap_t.glap006
#   DEFINE l_glacstus   LIKE glac_t.glacstus  #151117-00009#1 mark
#   DEFINE l_glac003    LIKE glac_t.glac003   #151117-00009#1 mark
#   DEFINE l_glac006    LIKE glac_t.glac006   #151117-00009#1 mark
   DEFINE l_glad035    LIKE glad_t.glad035    #150827-00036#7 add
   
   LET g_errno = ''
#151117-00009#1--mark--str--
#   SELECT glacstus,glac003,glac006 INTO l_glacstus,l_glac003,l_glac006 FROM glac_t  
#    WHERE glacent = g_enterprise
#      AND glac001 = g_glaa004  #会计科目参照表号
#      AND glac002 = p_glap006
#151117-00009#1--mark--end
      
   #150827-00036#7---add--str   
   SELECT glad035 INTO l_glad035 FROM glad_t 
    WHERE gladent = g_enterprise
      AND gladld = g_glap_m.glapld  
      AND glad001 = p_glap006    
   #150827-00036#7---add--end
 
   CASE
#151117-00009#1--mark--str--
#      WHEN SQLCA.SQLCODE = 100   LET g_errno = 'agl-00011'
#      WHEN l_glacstus = 'N'      LET g_errno = 'sub-01302' #'agl-00012'   #160318-00005#17 mod 
#      WHEN SQLCA.SQLCODE = 100   LET g_errno = 'ais-00045'
#      WHEN l_gladstus = 'N'      LET g_errno = 'ais-00046'
#      WHEN l_glac003 = '1'       LET g_errno = 'agl-00013'  #必须为非统治类科目
#      WHEN l_glac006 <>'1'       LET g_errno = 'agl-00030'  #须为账户性质 
#151117-00009#1--mark--end
      WHEN l_glad035 = 'Y'       LET g_errno = 'agl-00358'  #必須為非子系統科目  #150827-00036#7 add      
   END CASE   
END FUNCTION
#+现收现支
PRIVATE FUNCTION aglt310_glap001_2(p_glap001)
   DEFINE p_glap001     LIKE glap_t.glap001
   DEFINE l_glaq003     LIKE glaq_t.glaq003
   DEFINE l_glaq004     LIKE glaq_t.glaq004
   DEFINE l_glaq040     LIKE glaq_t.glaq040
   DEFINE l_glaq041     LIKE glaq_t.glaq041
   DEFINE l_glaq043     LIKE glaq_t.glaq043
   DEFINE l_glaq044     LIKE glaq_t.glaq044
   DEFINE l_glap010     LIKE glap_t.glap010
   DEFINE l_glap011     LIKE glap_t.glap011
   DEFINE l_cnt         LIKE type_t.num5
   DEFINE l_glaq039     LIKE glaq_t.glaq039
   DEFINE l_glaq042     LIKE glaq_t.glaq042
   DEFINE l_glaq010     LIKE glaq_t.glaq010
   DEFINE l_glad003     LIKE glad_t.glad003
   DEFINE l_glad004     LIKE glad_t.glad004
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_glac016     LIKE glac_t.glac016
   DEFINE l_glbc003     LIKE glbc_t.glbc003
   DEFINE l_glbc012     LIKE glbc_t.glbc012
   DEFINE l_glbc014     LIKE glbc_t.glbc014
   DEFINE l_glaq001     LIKE glaq_t.glaq001 #160902-00030#1 add
   
   #如果取消单头资料，则单身不做新增
   SELECT COUNT(1) INTO l_cnt FROM glap_t #161205-00025#4 mod '*'-->1
    WHERE glapent = g_enterprise
      AND glapld = g_glap_m.glapld
      AND glapdocno = g_glap_m.glapdocno
      AND glap001 = p_glap001
   IF l_cnt = 0 THEN
      RETURN 
   END IF 
   
   #160902-00030#1 add--s
   #如果单身没维护值，单身不做新增
   SELECT COUNT(1) INTO l_cnt FROM glaq_t #161205-00025#4 mod '*'-->1
    WHERE glaqent = g_enterprise
      AND glaqld = g_glap_m.glapld
      AND glaqdocno = g_glap_m.glapdocno
   IF l_cnt = 0 THEN
      RETURN 
   END IF
   #160902-00030#1 add--e
   
   #执行开始
   CALL s_transaction_begin()
   #现收现支传票时，单身新增一笔借方资料科目是單頭指定, 金額總合是直接等於單身加总，项次为0   
   SELECT COUNT(1) INTO l_cnt FROM glaq_t,glap_t #161205-00025#4 mod '*'-->1
    WHERE glapent = glaqent
      AND glapld = glaqld
      AND glapdocno = glaqdocno 
      AND glaqent = g_enterprise
      AND glaqld = g_glap_m.glapld
      AND glaqdocno = g_glap_m.glapdocno
      AND glap001 = p_glap001
      AND glaqseq = 0 
   #资料存在先删除      
   IF l_cnt >0 THEN
   
      #160902-00030#1 add--s
      #备份备注
      SELECT UNIQUE glaq001 INTO l_glaq001 FROM glaq_t
       WHERE glaqent = g_enterprise
         AND glaqld = g_glap_m.glapld
         AND glaqdocno = g_glap_m.glapdocno
         AND glaqseq = 0
      #160902-00030#1 add--e
      
      DELETE FROM glaq_t 
       WHERE glaqent = g_enterprise
         AND glaqld = g_glap_m.glapld
         AND glaqdocno = g_glap_m.glapdocno
         AND glaqseq = 0
      #删除对应现金变动码
      DELETE FROM glbc_t
       WHERE glbcent=g_enterprise AND glbcld=g_glap_m.glapld 
         AND glbcdocno=g_glap_m.glapdocno AND glbcseq = 0
         
      CALL aglt310_get_glad(g_glap_m.glapld,g_glap_m.glap006) RETURNING l_glad003,l_glad004
      #刪除相關科目細項立沖帳資料   
      IF l_glad003='Y' THEN  
         CALL aglt310_delete_glax(g_glap_m.glapld,g_glap_m.glapdocno,0) RETURNING l_success
         CALL aglt310_delete_glay(g_glap_m.glapld,g_glap_m.glapdocno,0) RETURNING l_success
      END IF   
   END IF 
   #aglt320现收--增加一笔项次为0的借方金额，金额为单身贷方金额汇总
   #aglt330现支--增加一笔项次为0的贷方金额，金额为单身借方金额汇总   
   SELECT SUM(glaq003),SUM(glaq004),SUM(glaq040),SUM(glaq041),SUM(glaq043),SUM(glaq044)
     INTO l_glaq003,l_glaq004,l_glaq040,l_glaq041,l_glaq043,l_glaq044
     FROM glaq_t
    WHERE glaqent = g_enterprise
      AND glaqld = g_glap_m.glapld
      AND glaqdocno = g_glap_m.glapdocno  
   
   IF p_glap001 = '2' THEN
      LET l_glap010 = l_glaq004
      LET l_glap011 = l_glaq004
   ELSE
      LET l_glap010 = l_glaq003
      LET l_glap011 = l_glaq003   
   END IF 
   #原幣
   LET l_glaq010=l_glaq003+l_glaq004
   #匯率
   LET l_glaq039=(l_glaq040+l_glaq041)/(l_glaq003+l_glaq004)
   LET l_glaq042=(l_glaq043+l_glaq044)/(l_glaq003+l_glaq004)
   
   INSERT INTO glaq_t(glaqent,glaqld,glaqcomp,glaqdocno,glaqseq,glaq001,glaq002,glaq003,glaq004,   #Mod 160902-00030#1 add glaq001
                      glaq005,glaq006,glaq010,glaq039,glaq040,glaq041,glaq042,glaq043,glaq044,
                      glaq017,glaq018,glaq019,glaq020,glaq021,glaq022,glaq023,glaq024,
                      glaq051,glaq052,glaq053,glaq025,glaq027,glaq028,glaq029,glaq030,
                      glaq031,glaq032,glaq033,glaq034,glaq035,glaq036,glaq037,glaq038)
    VALUES (g_enterprise,g_glap_m.glapld,g_glap_m.glapcomp,g_glap_m.glapdocno,0,l_glaq001,g_glap_m.glap006,    #Mod 160902-00030#1 add l_glaq001
            l_glaq004,l_glaq003,g_glaa001,1,l_glaq010,l_glaq039,l_glaq041,l_glaq040,l_glaq042,l_glaq044,l_glaq043,
            g_glaq_s.glaq017,g_glaq_s.glaq018,g_glaq_s.glaq019,g_glaq_s.glaq020,g_glaq_s.glaq021,
            g_glaq_s.glaq022,g_glaq_s.glaq023,g_glaq_s.glaq024,g_glaq_s.glaq051,g_glaq_s.glaq052,
            g_glaq_s.glaq053,g_glaq_s.glaq025,g_glaq_s.glaq027,g_glaq_s.glaq028,g_glaq_s.glaq029,
            g_glaq_s.glaq030,g_glaq_s.glaq031,g_glaq_s.glaq032,g_glaq_s.glaq033,g_glaq_s.glaq034,
            g_glaq_s.glaq035,g_glaq_s.glaq036,g_glaq_s.glaq037,g_glaq_s.glaq038)
      
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.extend = 'INS glaqseq=0'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      CALL s_transaction_end('N','0')
   ELSE
      UPDATE glap_t set glap010 = l_glap010,
                        glap011 = l_glap011
                  WHERE glapent = g_enterprise
                    AND glap001 = p_glap001
                    AND glapld  = g_glap_m.glapld
                    AND glapdocno = g_glap_m.glapdocno 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.extend = 'UPDATE'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         CALL s_transaction_end('N','0')
      ELSE   
         #更新現金變動碼資料
         LET l_success = TRUE
         SELECT glac016 INTO l_glac016 FROM glac_t
          WHERE glacent=g_enterprise AND glac001=g_glaa004 AND glac002=g_glap_m.glap006
         IF l_glac016 = 'Y' THEN
            #插入一筆現金變動碼
            IF p_glap001 = '2' THEN
               LET l_glbc003 = '1' #借
            ELSE
               LET l_glbc003 = '2' #贷
            END IF
            LET l_glbc012 = l_glaq041 + l_glaq040 #本幣二金額
            LET l_glbc014 = l_glaq044 + l_glaq043 #本幣三金額
            INSERT INTO glbc_t(glbcent,glbcld,glbccomp,glbcdocno,glbcseq,glbcseq1,
                               glbc001,glbc002,glbc003,glbc004,
                               glbc006,glbc007,glbc008,glbc009,glbc010,
                               glbc011,glbc012,glbc013,glbc014,glbc015)  #151013-00016#6 add glbc015
            VALUES(g_enterprise,g_glap_m.glapld,g_glap_m.glapcomp,g_glap_m.glapdocno,0,1,
                   g_glap_m.glap002,g_glap_m.glap004,l_glbc003,g_glaq_s.glbc004,
                   g_glaa001,1,l_glaq010,l_glaq010,'1',
                   l_glaq039,l_glbc012,l_glaq042,l_glbc014,g_glap_m.glapstus)  #151013-00016#6 add g_glap_m.glapstus
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = sqlca.sqlcode
               LET g_errparam.extend = 'insert glbc_t'
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET l_success=FALSE
            END IF
         END IF
         IF l_success = FALSE THEN
            CALL s_transaction_end('N','0')
         ELSE
            CALL s_transaction_end('Y','0')
         END IF
         CALL aglt310_b_fill()
      END IF          
   END IF                
END FUNCTION
#+ 客商说明
PRIVATE FUNCTION aglt310_glaq021_desc(p_glaq021)
   DEFINE p_glaq021    LIKE pmaa_t.pmaa001

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_glaq021
   CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   RETURN  g_rtn_fields[1]
END FUNCTION
#+人員說明
PRIVATE FUNCTION aglt310_glaq013_desc(p_glaq013)
    DEFINE l_ooag011        LIKE ooag_t.ooag011
    DEFINE p_glaq013        LIKE glaq_t.glaq013

    LET l_ooag011 = ''
    SELECT ooag011 INTO l_ooag011 FROM ooag_t
     WHERE ooagent = g_enterprise AND ooag001 = p_glaq013
    RETURN l_ooag011
END FUNCTION
#+ 预算编号说明
PRIVATE FUNCTION aglt310_glaq026_desc(p_glaq026)
    DEFINE p_glaq026      LIKE glaq_t.glaq026
   
    INITIALIZE g_ref_fields TO NULL
    LET g_ref_fields[1] = p_glaq026
    CALL ap_ref_array2(g_ref_fields,"SELECT bgaal003 FROM bgaal_t WHERE bgaalent='"||g_enterprise||"' AND bgaal001=? AND bgaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   RETURN g_rtn_fields[1]

END FUNCTION
#+ 产品分类说明
PRIVATE FUNCTION aglt310_glaq024_desc(p_glaq024)
    DEFINE p_glaq024   LIKE glaq_t.glaq024
    
    INITIALIZE g_ref_fields TO NULL
    LET g_ref_fields[1] = p_glaq024
    CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
    RETURN g_rtn_fields[1]
END FUNCTION
#账别说明
PRIVATE FUNCTION aglt310_glapld_desc(p_glapld)
   DEFINE  p_glapld    LIKE glap_t.glapld
   DEFINE  l_cnt       LIKE type_t.num5
   
    INITIALIZE g_ref_fields TO NULL
    LET g_ref_fields[1] = p_glapld 
    CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
    LET g_glap_m.glapld_desc=g_rtn_fields[1]
    #依据对应的主账套编码，抓取对应法人，币别，汇率参照编号，会计科目参照编号,关账日期
   SELECT glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa013,
          glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,
          glaa021,glaa022,glaa024,glaa025,glaa026,glaa121,glaa122
         ,glaa028 #160918-00006#2 add
     INTO g_glaacomp,g_glaa001,g_glaa002,g_glaa003,g_glaa004,g_glaa005,g_glaa013,
          g_glaa015,g_glaa016,g_glaa017,g_glaa018,g_glaa019,g_glaa020,
          g_glaa021,g_glaa022,g_glaa024,g_glaa025,g_glaa026,g_glaa121,g_glaa122
         ,g_glaa028 #160918-00006#2 add
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald = p_glapld 
   LET g_glap_m.glapcomp = g_glaacomp
   LET g_glap_m.glaa001_desc = g_glaa001
   LET g_glap_m.glaa016 = g_glaa016
   LET g_glap_m.glaa020 = g_glaa020
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_glaacomp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_glap_m.glapcomp_desc= g_rtn_fields[1]
   
   #取本幣的金额小數位數
   CALL s_curr_sel_ooaj004(g_glaa026,g_glaa001) RETURNING g_ooaj004
   IF g_glaa015 = 'Y' THEN
      CALL cl_set_comp_visible("glaa016,glaq039,amt2",TRUE)
      #取本位幣二的金额小數位數
      CALL s_curr_sel_ooaj004(g_glaa026,g_glaa016) RETURNING g_ooaj004_2
   ELSE                                    
      CALL cl_set_comp_visible("glaa016,glaq039,amt2",FALSE)
   END IF                                  
                                           
   IF g_glaa019 = 'Y' THEN                 
      CALL cl_set_comp_visible("glaa020,glaq042,amt3",TRUE)
      #取本位幣三的金额小數位數
      CALL s_curr_sel_ooaj004(g_glaa026,g_glaa020) RETURNING g_ooaj004_3
   ELSE                                    
      CALL cl_set_comp_visible("glaa020,glaq042,amt3",FALSE)
   END IF
   
   #150827-00036#8--add--str--
   #当账套下所有科目都没用启用数量金额式，隐藏计价单位、数量、单价栏位
   LET l_cnt = 0
   SELECT COUNT(1) INTO l_cnt FROM glad_t #161205-00025#4 mod '*'-->1
    WHERE gladent = g_enterprise
      AND gladld = g_glap_m.glapld
      AND glad005 ='Y'
   IF l_cnt = 0 THEN
      CALL cl_set_comp_visible('Grid_gen14',FALSE) 
   ELSE
      CALL cl_set_comp_visible('Grid_gen14',TRUE)
   END IF
   #150827-00036#8--add--end
END FUNCTION
#单据别检查
PRIVATE FUNCTION aglt310_glapdocno_chk(p_glapdocno)
   DEFINE p_glapdocno      LIKE glap_t.glapdocno
   DEFINE l_oobastus       LIKE ooba_t.oobastus
   
   LET g_errno = '' 
   SELECT oobastus INTO l_oobastus 
     FROM ooba_t LEFT OUTER JOIN oobx_t ON (oobaent=oobxent AND ooba002=oobx001)
    WHERE oobaent = g_enterprise
      AND ooba001 = g_glaa024      #单据别参照表号
      AND ooba002 = p_glapdocno    #单据别
      AND oobx002 = 'AGL'          #模组 
      AND oobx003 = g_oobx003      #单据性质
   CASE
      WHEN SQLCA.SQLCODE =100  LET g_errno = 'aim-00056'
      WHEN l_oobastus = 'N'    LET g_errno = 'sub-01302'  #160318-00005#17 mod  'aim-00057'
   END CASE
END FUNCTION
#+币别检查
PRIVATE FUNCTION aglt310_glaq005_chk(p_glaq005)
    DEFINE l_ooaistus   LIKE ooai_t.ooaistus
    DEFINE p_glaq005    LIKE glaq_t.glaq005
     
     LET g_errno = ''
     SELECT ooaistus INTO l_ooaistus FROM ooai_t
      WHERE ooaient = g_enterprise
        AND ooai001 = p_glaq005
     CASE  
        WHEN SQLCA.sqlcode = 100   LET g_errno = 'aoo-00028'
        WHEN l_ooaistus = 'N'      LET g_errno =  'sub-01302'  #160318-00005#17 mod #'aoo-00011'
     END CASE
END FUNCTION
#+组合科目，名称以及核算项，显示到科目栏位
PRIVATE FUNCTION aglt310_glaq002()
   DEFINE l_glaq002_desc      LIKE glacl_t.glacl004
   DEFINE r_glaq002           STRING
   DEFINE r_str               STRING
   DEFINE l_desc              STRING
   
    #抓取科目名称
   LET l_glaq002_desc = ''
   #161205-00025#4--mod--str--
#   SELECT glacl004 INTO l_glaq002_desc FROM glacl_t
#    WHERE glaclent = g_enterprise
#      AND glacl001 = g_glaa004
#      AND glacl002 = g_glaq_d[l_ac].glaq002
#      AND glacl003 = g_dlang  
   EXECUTE aglt310_sel_glacl004_pr USING g_glaa004,g_glaq_d[l_ac].glaq002
                                   INTO l_glaq002_desc
   #自由核算項
#   SELECT glad0171,glad0181,glad0191,glad0201,glad0211,
#          glad0221,glad0231,glad0241,glad0251,glad0261
#     INTO g_glad0171,g_glad0181,g_glad0191,g_glad0201,g_glad0211,
#          g_glad0221,g_glad0231,g_glad0241,g_glad0251,g_glad0261
#     FROM glad_t
#    WHERE gladent=g_enterprise AND gladld=g_glap_m.glapld AND glad001=g_glaq_d[l_ac].glaq002
   EXECUTE aglt310_sel_glad_pr USING g_glap_m.glapld,g_glaq_d[l_ac].glaq002
                               INTO g_glad0171,g_glad0181,g_glad0191,g_glad0201,g_glad0211,
                                    g_glad0221,g_glad0231,g_glad0241,g_glad0251,g_glad0261
   #161205-00025#4--mod--end
   
   #组合名称以及核算项
   LET r_glaq002 = ''
   LET r_str = ''
#   #營運據點
#   IF NOT cl_null(g_glap_m.glaq017) THEN
#      CALL aglt310_ooef001_desc(g_glap_m.glaq017) RETURNING g_glap_m.glaq017_desc
#      LET r_glaq002 = g_glap_m.glaq017_desc    
#      LET r_str=g_glap_m.glaq017    
#   END IF
   #部门
   IF NOT cl_null(g_glap_m.glaq018) THEN
      CALL aglt310_ooef001_desc(g_glap_m.glaq018) RETURNING g_glap_m.glaq018_desc
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',g_glap_m.glaq018_desc
      ELSE
         LET r_glaq002 = g_glap_m.glaq018_desc
      END IF
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',g_glap_m.glaq018
      ELSE
         LET r_str=g_glap_m.glaq018
      END IF    
   END IF 
   #成本利润中心
   IF NOT cl_null(g_glap_m.glaq019) THEN
      CALL aglt310_ooef001_desc(g_glap_m.glaq019) RETURNING g_glap_m.glaq019_desc
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',g_glap_m.glaq019_desc
      ELSE
         LET r_glaq002 = g_glap_m.glaq019_desc
      END IF
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',g_glap_m.glaq019
      ELSE
         LET r_str=g_glap_m.glaq019
      END IF
   END IF 
   
   #区域
   IF NOT cl_null(g_glap_m.glaq020) THEN 
      CALL aglt310_glaq020_desc('287',g_glap_m.glaq020) RETURNING g_glap_m.glaq020_desc   
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',g_glap_m.glaq020_desc
      ELSE
         LET r_glaq002 = g_glap_m.glaq020_desc
      END IF
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',g_glap_m.glaq020
      ELSE
         LET r_str=g_glap_m.glaq020
      END IF      
   END IF 
   #交易客商
   IF NOT cl_null(g_glap_m.glaq021) THEN
      CALL aglt310_glaq021_desc(g_glap_m.glaq021) RETURNING g_glap_m.glaq021_desc
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',g_glap_m.glaq021_desc
      ELSE
         LET r_glaq002 = g_glap_m.glaq021_desc
      END IF 
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',g_glap_m.glaq021
      ELSE
         LET r_str=g_glap_m.glaq021
      END IF      
   END IF 
   #帐款客商
   IF NOT cl_null(g_glap_m.glaq022) THEN
      CALL aglt310_glaq021_desc(g_glap_m.glaq022) RETURNING g_glap_m.glaq022_desc
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',g_glap_m.glaq022_desc
      ELSE
         LET r_glaq002 = g_glap_m.glaq022_desc
      END IF
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',g_glap_m.glaq022
      ELSE
         LET r_str=g_glap_m.glaq022
      END IF      
   END IF 
   #客群
   IF NOT cl_null(g_glap_m.glaq023) THEN
      CALL aglt310_glaq020_desc('281',g_glap_m.glaq023) RETURNING g_glap_m.glaq023_desc
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',g_glap_m.glaq023_desc
      ELSE
         LET r_glaq002 = g_glap_m.glaq023_desc
      END IF
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',g_glap_m.glaq023
      ELSE
         LET r_str=g_glap_m.glaq023
      END IF      
   END IF 
   
   #产品分类
   IF NOT cl_null(g_glap_m.glaq024) THEN
      CALL aglt310_glaq024_desc(g_glap_m.glaq024) RETURNING g_glap_m.glaq024_desc
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',g_glap_m.glaq024_desc
      ELSE
         LET r_glaq002 = g_glap_m.glaq024_desc
      END IF
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',g_glap_m.glaq024
      ELSE
         LET r_str=g_glap_m.glaq024
      END IF      
   END IF 
   
   #經營方式
   IF NOT cl_null(g_glap_m.glaq051) THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = '6013'
      LET g_ref_fields[2] = g_glap_m.glaq051
      CALL ap_ref_array2(g_ref_fields,"SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001=? AND gzcbl002=? AND gzcbl003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET l_desc = g_rtn_fields[1]
      
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',l_desc
      ELSE
         LET r_glaq002 = l_desc
      END IF
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',g_glap_m.glaq051
      ELSE
         LET r_str=g_glap_m.glaq051
      END IF      
   END IF 
   
   #渠道
   IF NOT cl_null(g_glap_m.glaq052) THEN
       CALL aglt310_glaq052_desc(g_glap_m.glaq052) RETURNING g_glap_m.glaq052_desc
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',g_glap_m.glaq052_desc
      ELSE
         LET r_glaq002 = g_glap_m.glaq052_desc
      END IF
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',g_glap_m.glaq052
      ELSE
         LET r_str=g_glap_m.glaq052
      END IF      
   END IF 
   
   #品牌
   IF NOT cl_null(g_glap_m.glaq053) THEN
      CALL aglt310_glaq020_desc('2002',g_glap_m.glaq053) RETURNING g_glap_m.glaq053_desc
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',g_glap_m.glaq053_desc
      ELSE
         LET r_glaq002 = g_glap_m.glaq053_desc
      END IF
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',g_glap_m.glaq053
      ELSE
         LET r_str=g_glap_m.glaq053
      END IF      
   END IF 
   
   #人员
   IF NOT cl_null(g_glap_m.glaq025) THEN
       CALL aglt310_glaq013_desc(g_glap_m.glaq025) RETURNING g_glap_m.glaq025_desc
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',g_glap_m.glaq025_desc
      ELSE
         LET r_glaq002 = g_glap_m.glaq025_desc
      END IF
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',g_glap_m.glaq025
      ELSE
         LET r_str=g_glap_m.glaq025
      END IF      
   END IF 
#   #预算编号
#   IF NOT cl_null(g_glap_m.glaq026) THEN
#       CALL aglt310_glaq026_desc(g_glap_m.glaq026) RETURNING g_glap_m.glaq026_desc
#      IF NOT cl_null(r_glaq002) THEN
#         LET r_glaq002 = r_glaq002 ,'-',g_glap_m.glaq026_desc
#      ELSE
#         LET r_glaq002 = g_glap_m.glaq026_desc
#      END IF
#      IF NOT cl_null(r_str) THEN
#         LET r_str=r_str,'-',g_glap_m.glaq026
#      ELSE
#         LET r_str=g_glap_m.glaq026
#      END IF      
#   END IF 
   #专案编号
   IF NOT cl_null(g_glap_m.glaq027) THEN
      CALL s_desc_get_project_desc(g_glap_m.glaq027) RETURNING g_glap_m.glaq027_desc
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',g_glap_m.glaq027_desc
      ELSE
         LET r_glaq002 = g_glap_m.glaq027_desc
      END IF
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',g_glap_m.glaq027
      ELSE
         LET r_str=g_glap_m.glaq027
      END IF      
   END IF 
   #WBS
   IF NOT cl_null(g_glap_m.glaq028) THEN
      CALL s_desc_get_wbs_desc(g_glap_m.glaq027,g_glap_m.glaq028) RETURNING g_glap_m.glaq028_desc
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',g_glap_m.glaq028_desc
      ELSE
         LET r_glaq002 = g_glap_m.glaq028_desc
      END IF
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',g_glap_m.glaq028
      ELSE
         LET r_str=g_glap_m.glaq028
      END IF      
   END IF 
   
   #自由核算項一
   IF NOT cl_null(g_glap_m.glaq029) THEN
       CALL s_voucher_free_account_desc(g_glad0171,g_glap_m.glaq029) RETURNING g_glap_m.glaq029_desc
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',g_glap_m.glaq029_desc
      ELSE
         LET r_glaq002 = g_glap_m.glaq029_desc
      END IF
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',g_glap_m.glaq029
      ELSE
         LET r_str=g_glap_m.glaq029
      END IF      
   END IF 
   
   #自由核算項二
   IF NOT cl_null(g_glap_m.glaq030) THEN
       CALL s_voucher_free_account_desc(g_glad0181,g_glap_m.glaq030) RETURNING g_glap_m.glaq030_desc
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',g_glap_m.glaq030_desc
      ELSE
         LET r_glaq002 = g_glap_m.glaq030_desc
      END IF
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',g_glap_m.glaq030
      ELSE
         LET r_str=g_glap_m.glaq030
      END IF      
   END IF
   
   #自由核算項三
   IF NOT cl_null(g_glap_m.glaq031) THEN
       CALL s_voucher_free_account_desc(g_glad0191,g_glap_m.glaq031) RETURNING g_glap_m.glaq031_desc
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',g_glap_m.glaq031_desc
      ELSE
         LET r_glaq002 = g_glap_m.glaq031_desc
      END IF
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',g_glap_m.glaq031
      ELSE
         LET r_str=g_glap_m.glaq031
      END IF      
   END IF
   
   #自由核算項四
   IF NOT cl_null(g_glap_m.glaq032) THEN
       CALL s_voucher_free_account_desc(g_glad0201,g_glap_m.glaq032) RETURNING g_glap_m.glaq032_desc
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',g_glap_m.glaq032_desc
      ELSE
         LET r_glaq002 = g_glap_m.glaq032_desc
      END IF
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',g_glap_m.glaq032
      ELSE
         LET r_str=g_glap_m.glaq032
      END IF      
   END IF
   
   #自由核算項五
   IF NOT cl_null(g_glap_m.glaq033) THEN
       CALL s_voucher_free_account_desc(g_glad0211,g_glap_m.glaq033) RETURNING g_glap_m.glaq033_desc
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',g_glap_m.glaq033_desc
      ELSE
         LET r_glaq002 = g_glap_m.glaq033_desc
      END IF
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',g_glap_m.glaq033
      ELSE
         LET r_str=g_glap_m.glaq033
      END IF      
   END IF
   
   #自由核算項六
   IF NOT cl_null(g_glap_m.glaq034) THEN
       CALL s_voucher_free_account_desc(g_glad0221,g_glap_m.glaq034) RETURNING g_glap_m.glaq034_desc
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',g_glap_m.glaq034_desc
      ELSE
         LET r_glaq002 = g_glap_m.glaq034_desc
      END IF
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',g_glap_m.glaq034
      ELSE
         LET r_str=g_glap_m.glaq034
      END IF      
   END IF
   
   #自由核算項七
   IF NOT cl_null(g_glap_m.glaq035) THEN
       CALL s_voucher_free_account_desc(g_glad0231,g_glap_m.glaq035) RETURNING g_glap_m.glaq035_desc
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',g_glap_m.glaq035_desc
      ELSE
         LET r_glaq002 = g_glap_m.glaq035_desc
      END IF
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',g_glap_m.glaq035
      ELSE
         LET r_str=g_glap_m.glaq035
      END IF      
   END IF
   
   #自由核算項八
   IF NOT cl_null(g_glap_m.glaq036) THEN
       CALL s_voucher_free_account_desc(g_glad0241,g_glap_m.glaq036) RETURNING g_glap_m.glaq036_desc
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',g_glap_m.glaq036_desc
      ELSE
         LET r_glaq002 = g_glap_m.glaq036_desc
      END IF
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',g_glap_m.glaq036
      ELSE
         LET r_str=g_glap_m.glaq036
      END IF      
   END IF
   
   #自由核算項九
   IF NOT cl_null(g_glap_m.glaq037) THEN
      CALL s_voucher_free_account_desc(g_glad0251,g_glap_m.glaq037) RETURNING g_glap_m.glaq037_desc
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',g_glap_m.glaq037_desc
      ELSE
         LET r_glaq002 = g_glap_m.glaq037_desc
      END IF
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',g_glap_m.glaq037
      ELSE
         LET r_str=g_glap_m.glaq037
      END IF      
   END IF
   
   #自由核算項十
   IF NOT cl_null(g_glap_m.glaq038) THEN
      CALL s_voucher_free_account_desc(g_glad0261,g_glap_m.glaq038) RETURNING g_glap_m.glaq038_desc
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',g_glap_m.glaq038_desc
      ELSE
         LET r_glaq002 = g_glap_m.glaq038_desc
      END IF
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',g_glap_m.glaq038
      ELSE
         LET r_str=g_glap_m.glaq038
      END IF      
   END IF
   
   #現金變動碼
   IF NOT cl_null(g_glap_m.glbc004) THEN
      CALL s_desc_get_nmail004_desc(g_glaa005,g_glap_m.glbc004) RETURNING g_glap_m.glbc004_desc
      IF NOT cl_null(r_glaq002) THEN
         LET r_glaq002 = r_glaq002 ,'-',g_glap_m.glbc004_desc
      ELSE
         LET r_glaq002 = g_glap_m.glbc004_desc
      END IF
      IF NOT cl_null(r_str) THEN
         LET r_str=r_str,'-',g_glap_m.glbc004
      ELSE
         LET r_str=g_glap_m.glbc004
      END IF
   END IF
   
   #组合科目名称以及核算项
   LET r_glaq002 = l_glaq002_desc,'\n',
                   r_glaq002
   IF NOT cl_null(r_str) THEN
      LET r_str="(",r_str,")"
   END IF                
   RETURN r_glaq002,r_str            

END FUNCTION
#检查该科目是否启用固定个核算项
PRIVATE FUNCTION aglt310_glaq002_open_chk(p_glaq002)
   DEFINE p_glaq002     LIKE glaq_t.glaq002
   DEFINE r_cnt         LIKE type_t.num5
   #记录隐藏栏位标示
   DEFINE l_flag1         LIKE type_t.num5
   #科目核算项
   DEFINE l_glad005       LIKE glad_t.glad005
   DEFINE l_glad007       LIKE glad_t.glad007
   DEFINE l_glad008       LIKE glad_t.glad008
   DEFINE l_glad009       LIKE glad_t.glad009
   DEFINE l_glad010       LIKE glad_t.glad010
   DEFINE l_glad027       LIKE glad_t.glad027
   DEFINE l_glad011       LIKE glad_t.glad011
   DEFINE l_glad012       LIKE glad_t.glad012
   DEFINE l_glad013       LIKE glad_t.glad013
   DEFINE l_glad015       LIKE glad_t.glad015
   DEFINE l_glad016       LIKE glad_t.glad016
   DEFINE l_glad031       LIKE glad_t.glad031
   DEFINE l_glad032       LIKE glad_t.glad032
   DEFINE l_glad033       LIKE glad_t.glad033
   #是否做自由科目核算项管理
   DEFINE l_glad017       LIKE glad_t.glad017
   DEFINE l_glad018       LIKE glad_t.glad018
   DEFINE l_glad019       LIKE glad_t.glad019
   DEFINE l_glad020       LIKE glad_t.glad020
   DEFINE l_glad021       LIKE glad_t.glad021
   DEFINE l_glad022       LIKE glad_t.glad022
   DEFINE l_glad023       LIKE glad_t.glad023
   DEFINE l_glad024       LIKE glad_t.glad024
   DEFINE l_glad025       LIKE glad_t.glad025
   DEFINE l_glad026       LIKE glad_t.glad026
   
   LET l_flag1 = 0
   CALL s_voucher_fix_acc_open_chk(g_glap_m.glapld,p_glaq002)
   RETURNING l_glad007,l_glad008,l_glad009,l_glad010,l_glad027,
             l_glad011,l_glad012,l_glad013,l_glad015,l_glad016,
             l_glad031,l_glad032,l_glad033
   #自由核算项开启
   SELECT glad017,glad018,glad019,glad020,glad021,glad022,
          glad023,glad024,glad025,glad026
    INTO  l_glad017,l_glad018,l_glad019,l_glad020,l_glad021,l_glad022,
          l_glad023,l_glad024,l_glad025,l_glad026
    FROM  glad_t
    WHERE gladent = g_enterprise
      AND gladld = g_glap_m.glapld
      AND glad001 = p_glaq002
   #該科目做部門管理
   IF l_glad007 <> 'Y' OR l_glad007 IS NULL THEN
      LET g_glaq_r.glaq018 = ' ' 
   END IF 
   #該科目做利潤成本管理時
   IF l_glad008 <> 'Y' OR l_glad008 IS NULL THEN
      LET g_glaq_r.glaq019 = ' '      
   END IF 
   #該科目做區域管理時
   IF l_glad009 <> 'Y' OR l_glad009 IS NULL THEN
      LET g_glaq_r.glaq020 = ' '
   END IF 
   #該科目做客商管理
   IF l_glad010 <> 'Y' OR l_glad010 IS NULL THEN
      LET g_glaq_r.glaq021 = ' '
   END IF 
   #該科目做账款客商管理時
   IF l_glad027 <> 'Y' OR l_glad027 IS NULL THEN
      LET g_glaq_r.glaq022 = ' '
   END IF 
   #該科目做客群管理時
   IF l_glad011 <> 'Y' OR l_glad011 IS NULL THEN
      LET g_glaq_r.glaq023 = ' '      
   END IF 
   #該科目做產品分類管理時，
   IF l_glad012 <> 'Y' OR l_glad012 IS NULL THEN
      LET g_glaq_r.glaq024 = ' '    
   END IF 
   #該科目做经营方式管理時，
   IF l_glad031 <> 'Y' OR l_glad031 IS NULL THEN
      LET g_glaq_r.glaq051 = ' '   
   END IF
   #該科目做渠道管理時，
   IF l_glad032 <> 'Y' OR l_glad032 IS NULL THEN
      LET g_glaq_r.glaq052 = ' '    
   END IF
   #該科目做品牌管理時，
   IF l_glad033 <> 'Y' OR l_glad033 IS NULL THEN
      LET g_glaq_r.glaq053 = ' '    
   END IF
   #該科目做人員管理時，
   IF l_glad013 <> 'Y' OR l_glad013 IS NULL THEN
      LET g_glaq_r.glaq025 = ' '        
   END IF 
   #該科目做專案管理時，
   IF l_glad015 <> 'Y' OR l_glad015 IS NULL THEN
      LET g_glaq_r.glaq027 = ' '         
   END IF 
   #該科目做WBS管理時，
   IF l_glad016 <> 'Y' OR l_glad016 IS NULL THEN
      LET g_glaq_r.glaq028 = ' '   
   END IF 
   #核算项一
   IF l_glad017 <> 'Y' OR l_glad017 IS NULL THEN
      LET g_glaq_r.glaq029 = ' '   
   END IF 
   #核算项二
   IF l_glad018 <> 'Y' OR l_glad018 IS NULL THEN
      LET g_glaq_r.glaq030 = ' '   
   END IF
   #核算项三
   IF l_glad019 <> 'Y' OR l_glad019 IS NULL THEN
      LET g_glaq_r.glaq031 = ' '   
   END IF
   #核算项四
   IF l_glad020 <> 'Y' OR l_glad020 IS NULL THEN
      LET g_glaq_r.glaq032 = ' '   
   END IF
   #核算项五
   IF l_glad021 <> 'Y' OR l_glad021 IS NULL THEN
      LET g_glaq_r.glaq033 = ' '   
   END IF
   #核算项四六
   IF l_glad022 <> 'Y' OR l_glad022 IS NULL THEN
      LET g_glaq_r.glaq034 = ' '   
   END IF
   #核算项七
   IF l_glad023 <> 'Y' OR l_glad023 IS NULL THEN
      LET g_glaq_r.glaq035 = ' '   
   END IF
   #核算项八
   IF l_glad024 <> 'Y' OR l_glad024 IS NULL THEN
      LET g_glaq_r.glaq036 = ' '   
   END IF
   #核算项九
   IF l_glad025 <> 'Y' OR l_glad025 IS NULL THEN
      LET g_glaq_r.glaq037 = ' '   
   END IF
   #核算项十
   IF l_glad026 <> 'Y' OR l_glad026 IS NULL THEN
      LET g_glaq_r.glaq038 = ' '   
   END IF
END FUNCTION
#+ 固定核算项维护
PRIVATE FUNCTION aglt310_fix_acc()
   DEFINE l_glaq002  LIKE glaq_t.glaq002
   DEFINE l_success  LIKE type_t.num5
   DEFINE l_cnt      LIKE type_t.num5
   DEFINE l_glaq_o   type_g_glaq_r
   DEFINE l_flag2    LIKE type_t.chr1
   
    #开立状态资料才可进行此操作
    IF g_glap_m.glapstus  ='N' THEN
       #单身无资料不需开出画面
       IF g_detail_idx =0 OR cl_null(g_detail_idx) THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = -400
          LET g_errparam.extend = ''
          LET g_errparam.popup = FALSE
          CALL cl_err()

          RETURN
       END IF 
       IF g_glap001_p <> '6' THEN   #151204-00001#1 add
          #檢查當單據日期小於等於關帳日期時，不可異動單據
          CALL s_fin_date_close_chk(g_glap_m.glapld,'','AGL',g_glap_m.glapdocdt) RETURNING l_success
          IF l_success = FALSE THEN
             RETURN
          END IF
       END IF  #151204-00001#1 add
       
       #抓取科目
       LET l_glaq002 = ''
       SELECT glaq002 INTO l_glaq002 FROM glaq_t 
        WHERE glaqent = g_enterprise
          AND glaqld = g_glap_m.glapld
          AND glaqdocno = g_glap_m.glapdocno
          AND glaqseq = g_glaq_d[g_detail_idx].glaqseq 
          
       #核算项
       INITIALIZE g_glaq_r.* TO NULL
       SELECT glaq017,glaq018,glaq019,glaq020,glaq021,glaq022,
              glaq023,glaq024,glaq051,glaq052,glaq053,glaq025,glaq027,glaq028,
              glaq029,glaq030,glaq031,glaq032,glaq033,glaq034,glaq035,glaq036,glaq037,glaq038
         INTO g_glaq_r.glaq017,g_glaq_r.glaq018,g_glaq_r.glaq019,g_glaq_r.glaq020,g_glaq_r.glaq021,
              g_glaq_r.glaq022,g_glaq_r.glaq023,g_glaq_r.glaq024,g_glaq_r.glaq051,g_glaq_r.glaq052,
              g_glaq_r.glaq053,g_glaq_r.glaq025,g_glaq_r.glaq027,g_glaq_r.glaq028,g_glaq_r.glaq029,
              g_glaq_r.glaq030,g_glaq_r.glaq031,g_glaq_r.glaq032,g_glaq_r.glaq033,g_glaq_r.glaq034,
              g_glaq_r.glaq035,g_glaq_r.glaq036,g_glaq_r.glaq037,g_glaq_r.glaq038
         FROM glaq_t
        WHERE glaqent = g_enterprise
          AND glaqld = g_glap_m.glapld
          AND glaqdocno = g_glap_m.glapdocno
          AND glaqseq = g_glaq_d[g_detail_idx].glaqseq
       #現金變動碼
       LET g_glaq_r.glbc004=''
       LET l_cnt=0
       SELECT COUNT(1) INTO l_cnt FROM glbc_t #161205-00025#4 mod '*'-->1
        WHERE glbcent = g_enterprise AND glbcld = g_glap_m.glapld
          AND glbcdocno = g_glap_m.glapdocno
          AND glbcseq = g_glaq_d[g_detail_idx].glaqseq
          AND glbc001 = g_glap_m.glap002 
          AND glbc002 = g_glap_m.glap004
       IF l_cnt=1 THEN
          SELECT glbc004 INTO g_glaq_r.glbc004 FROM glbc_t
           WHERE glbcent = g_enterprise AND glbcld = g_glap_m.glapld
             AND glbcdocno = g_glap_m.glapdocno
             AND glbcseq = g_glaq_d[g_detail_idx].glaqseq
             AND glbc001 = g_glap_m.glap002 
             AND glbc002 = g_glap_m.glap004
       ELSE
          LET g_glaq_r.glbc004=' '
       END IF
       #150814-00006#3--add--str--
       #用于判断现金变动码要取的借贷方向
       LET l_flag2=''
       #借方
       IF g_glaq_d[g_detail_idx].glaq003 <> '0' THEN
          LET l_flag2='d'
       END IF
       #贷方
       IF g_glaq_d[g_detail_idx].glaq004 <> '0' THEN
          LET l_flag2='c'
       END IF
       #150814-00006#3--add--end 
       #保留旧值
       LET l_glaq_o.* = g_glaq_r.*    
       CALL s_transaction_begin()
       LET l_success = TRUE
       #150814-00006#3 add ''-->l_flag2       
       CALL aglt310_02(l_flag2,g_glap_m.glapld,'',g_glap_m.glapdocdt,l_glaq002,'','aglt310',g_glaq_r.*) 
       RETURNING g_glaq_r.glaq017,g_glaq_r.glaq018,g_glaq_r.glaq019,g_glaq_r.glaq020,g_glaq_r.glaq021,g_glaq_r.glaq022,
                 g_glaq_r.glaq023,g_glaq_r.glaq024,g_glaq_r.glaq051,g_glaq_r.glaq052,g_glaq_r.glaq053,g_glaq_r.glaq025,
                 g_glaq_r.glaq027,g_glaq_r.glaq028,g_glaq_r.glaq029,g_glaq_r.glaq030,g_glaq_r.glaq031,g_glaq_r.glaq032,
                 g_glaq_r.glaq033,g_glaq_r.glaq034,g_glaq_r.glaq035,g_glaq_r.glaq036,g_glaq_r.glaq037,g_glaq_r.glaq038,
                 g_glaq_r.glbc004
       
       #將離開科目欄位后的固定核算项   
       CALL aglt310_update_forzen()  RETURNING l_success
       IF l_success = FALSE THEN
          CALL s_transaction_end('N','0')                    
       END IF
       
       #维护现金变动码
       CALL aglt310_ins_upd_glbc() RETURNING l_success 
       IF l_success = FALSE THEN
          CALL s_transaction_end('N','0')                    
       END IF
          
       IF l_success = TRUE THEN 
          UPDATE glap_t SET glapmodid = g_user,
                            glapmoddt = g_today
                      WHERE glapent = g_enterprise
                        And glapld = g_glap_m.glapld
                        AND glapdocno = g_glap_m.glapdocno                                
          CALL s_transaction_end('Y','0') 
       ELSE
          CALL s_transaction_end('N','0')   
       END IF
       #标示在input录入状态 
       IF  g_flag_input <> TRUE    THEN       
          #重新顯示科目
          CALL aglt310_subject()
       END IF       
       #重新抓取单身冻结部分显示               
       CALL aglt310_b_detail()
       
       #當aglt310、aglt320、aglt330時判斷是否進行細項立沖
       IF g_glap001_p MATCHES '[123]' AND l_success=TRUE THEN
          SELECT COUNT(1) INTO l_cnt FROM glay_t #161205-00025#4 mod '*'-->1
           WHERE glayent=g_enterprise AND glayld=g_glap_m.glapld
             AND glaydocno=g_glap_m.glapdocno AND glayseq=g_glaq_d[l_ac].glaqseq
          IF l_cnt=0 OR (l_cnt>0 AND(
                 l_glaq_o.glaq017<>g_glaq_r.glaq017 OR 
                 l_glaq_o.glaq018<>g_glaq_r.glaq018 OR
                 l_glaq_o.glaq019<>g_glaq_r.glaq019 OR
                 l_glaq_o.glaq020<>g_glaq_r.glaq020 OR
                 l_glaq_o.glaq021<>g_glaq_r.glaq021 OR
                 l_glaq_o.glaq022<>g_glaq_r.glaq022 OR
                 l_glaq_o.glaq023<>g_glaq_r.glaq023 OR
                 l_glaq_o.glaq024<>g_glaq_r.glaq024 OR
                 l_glaq_o.glaq051<>g_glaq_r.glaq051 OR
                 l_glaq_o.glaq052<>g_glaq_r.glaq052 OR
                 l_glaq_o.glaq053<>g_glaq_r.glaq053 OR
                 l_glaq_o.glaq025<>g_glaq_r.glaq025 OR
                 l_glaq_o.glaq027<>g_glaq_r.glaq027 OR
                 l_glaq_o.glaq028<>g_glaq_r.glaq028 OR
                 l_glaq_o.glaq029<>g_glaq_r.glaq029 OR
                 l_glaq_o.glaq030<>g_glaq_r.glaq030 OR
                 l_glaq_o.glaq031<>g_glaq_r.glaq031 OR
                 l_glaq_o.glaq032<>g_glaq_r.glaq032 OR
                 l_glaq_o.glaq033<>g_glaq_r.glaq033 OR
                 l_glaq_o.glaq034<>g_glaq_r.glaq034 OR
                 l_glaq_o.glaq035<>g_glaq_r.glaq035 OR
                 l_glaq_o.glaq036<>g_glaq_r.glaq036 OR
                 l_glaq_o.glaq037<>g_glaq_r.glaq037 OR
                 l_glaq_o.glaq038<>g_glaq_r.glaq038
                 ))
          THEN
             CALL s_transaction_begin()
             CALL aglt310_delete_glay(g_glap_m.glapld,g_glap_m.glapdocno,g_glaq_d[l_ac].glaqseq) RETURNING l_success
             IF l_success=TRUE THEN
                CALL aglt310_offset() RETURNING l_success
             END IF
             IF l_success = TRUE THEN
                CALL s_transaction_end('Y','0') 
             ELSE
                CALL s_transaction_end('N','0')   
             END IF
          END IF
       END IF
    ELSE
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = 'agl-00052'
       LET g_errparam.extend = 'mod fix_account'
       LET g_errparam.popup = TRUE
       CALL cl_err()

    END IF  
END FUNCTION
#业务咨询维护
PRIVATE FUNCTION aglt310_bus_cons()
    DEFINE l_glaq002  LIKE glaq_t.glaq002
    DEFINE l_success  LIKE type_t.num5
    DEFINE l_cnt      LIKE type_t.num5
    
    #开立状态资料才可进行此操作
    IF g_glap_m.glapstus  ='N' THEN
       #单身无资料不需开出画面
       IF g_detail_idx =0 OR cl_null(g_detail_idx) THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = -400
          LET g_errparam.extend = ''
          LET g_errparam.popup = FALSE
          CALL cl_err()

          RETURN
       END IF 
       IF g_glap001_p <> '6' THEN   #151204-00001#1 add
          #檢查當單據日期小於等於關帳日期時，不可異動單據
          CALL s_fin_date_close_chk(g_glap_m.glapld,'','AGL',g_glap_m.glapdocdt) RETURNING l_success
          IF l_success = FALSE THEN
             RETURN
          END IF
       END IF  #151204-00001#1 add
       #清空业务资讯/核算项的值
       CALL aglt310_frozen_clear(2)
       #业务资讯核算项维护
       #抓取科目
       LET l_glaq002 = ''
       SELECT glaq002 INTO l_glaq002 FROM glaq_t 
        WHERE glaqent = g_enterprise
          AND glaqld = g_glap_m.glapld
          AND glaqdocno = g_glap_m.glapdocno
          AND glaqseq = g_glaq_d[g_detail_idx].glaqseq
       CALL aglt310_bus_cons_open_chk(l_glaq002) RETURNING l_cnt
       IF l_cnt >0 THEN       
          CALL aglt310_05('u',g_glap_m.glapld,g_glap_m.glapdocno,g_glap_m.glapdocdt,l_glaq002,g_glaq_d[g_detail_idx].glaqseq) 
          RETURNING g_glap_m.glaq007,g_glap_m.glaq008,g_glap_m.glaq009,
                    g_glap_m.glaq011,g_glap_m.glaq012,g_glap_m.glaq013,g_glap_m.glaq014,g_glap_m.glaq015,g_glap_m.glaq016
          #更新数据库
          CALL s_transaction_begin()
          CALL aglt310_update_forzen()  RETURNING l_success
          
          IF l_success = TRUE THEN 
             UPDATE glap_t SET glapmodid = g_user,
                               glapmoddt = g_today
                         WHERE glapent = g_enterprise
                           And glapld = g_glap_m.glapld
                           AND glapdocno = g_glap_m.glapdocno                                
             CALL s_transaction_end('Y','0') 
          ELSE
             CALL s_transaction_end('N','0')   
          END IF          
          #重新抓取单身冻结部分显示               
          CALL aglt310_b_detail() 
       ELSE
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = 'agl-00109'
          LET g_errparam.extend = l_glaq002
          LET g_errparam.popup = TRUE
          CALL cl_err()
       
       END IF    
    ELSE           
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = 'agl-00052'
       LET g_errparam.extend = 'mod bus_cons'
       LET g_errparam.popup = TRUE
       CALL cl_err()

    END IF  
END FUNCTION
#自由核算项维护
PRIVATE FUNCTION aglt310_main_free_acc()
    DEFINE l_glaq002     LIKE glaq_t.glaq002
    DEFINE l_success     LIKE type_t.num5
    DEFINE l_cnt         LIKE type_t.num5
    DEFINE l_glaq029     LIKE glaq_t.glaq029
    DEFINE l_glaq030     LIKE glaq_t.glaq030
    DEFINE l_glaq031     LIKE glaq_t.glaq031
    DEFINE l_glaq032     LIKE glaq_t.glaq032
    DEFINE l_glaq033     LIKE glaq_t.glaq033
    DEFINE l_glaq034     LIKE glaq_t.glaq034
    DEFINE l_glaq035     LIKE glaq_t.glaq035
    DEFINE l_glaq036     LIKE glaq_t.glaq036
    DEFINE l_glaq037     LIKE glaq_t.glaq037
    DEFINE l_glaq038     LIKE glaq_t.glaq038 
    DEFINE l_glad003     LIKE glad_t.glad003
    DEFINE l_glad004     LIKE glad_t.glad004
    
    #开立状态才可进行进行维护
    IF g_glap_m.glapstus = 'N' THEN
       #单身无资料不需开出画面
       IF g_detail_idx =0 OR cl_null(g_detail_idx) THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = -400
          LET g_errparam.extend = ''
          LET g_errparam.popup = FALSE
          CALL cl_err()

          RETURN
       END IF 
       #初始化自由核算项
       LET g_glaq029 = ''  LET g_glaq030 = '' LET g_glaq031 = '' LET g_glaq032=''  LET g_glaq033=''
       LET g_glaq034 = ''  LET g_glaq035 = '' LET g_glaq036 = '' LET g_glaq037=''  LET g_glaq038=''
       #抓取科目
       LET l_glaq002 = ''
       SELECT glaq002 INTO l_glaq002 FROM glaq_t 
        WHERE glaqent = g_enterprise
          AND glaqld = g_glap_m.glapld
          AND glaqdocno = g_glap_m.glapdocno
          AND glaqseq = g_glaq_d[g_detail_idx].glaqseq  
       #检查该科目是否启用自由核算项，如果未启用则不开启子画面
       CALL aglt310_free_acc_open_chk(l_glaq002) RETURNING l_cnt
       IF l_cnt >0  THEN       
          #自由核算项维护   
#          CALL aglt310_03(g_glap_m.glapld,g_glap_m.glapdocno,g_glaq_d[g_detail_idx].glaqseq,l_glaq002,"aglt310",'','','')
#          RETURNING g_glaq029,g_glaq030,g_glaq031,g_glaq032,g_glaq033,
#                    g_glaq034,g_glaq035,g_glaq036,g_glaq037,g_glaq038
           #更新数据库
          CALL s_transaction_begin()
          LET l_success=TRUE
          SELECT glaq029,glaq030,glaq031,glaq032,glaq033,
                 glaq034,glaq035,glaq036,glaq037,glaq038
            INTO l_glaq029,l_glaq030,l_glaq031,l_glaq032,l_glaq033,
                 l_glaq034,l_glaq035,l_glaq036,l_glaq037,l_glaq038
            FROM glaq_t
           WHERE glaqent = g_enterprise
             AND glaqld = g_glap_m.glapld
             AND glaqdocno = g_glap_m.glapdocno
             AND glaqseq = g_glaq_d[g_detail_idx].glaqseq 
             
          CALL aglt310_free_account()  RETURNING l_success
          
          IF l_success = TRUE THEN 
             UPDATE glap_t SET glapmodid = g_user,
                               glapmoddt = g_today
                         WHERE glapent = g_enterprise
                           And glapld = g_glap_m.glapld
                           AND glapdocno = g_glap_m.glapdocno                                
             CALL s_transaction_end('Y','0') 
          ELSE
             CALL s_transaction_end('N','0')   
          END IF
          #當aglt310、aglt320、aglt330時判斷是否進行細項立沖
          IF g_glap001_p MATCHES '[123]' AND l_success = TRUE THEN
             SELECT COUNT(1) INTO l_cnt FROM glay_t #161205-00025#4 mod '*'-->1
              WHERE glayent=g_enterprise AND glayld=g_glap_m.glapld
                AND glaydocno=g_glap_m.glapdocno AND glayseq=g_glaq_d[l_ac].glaqseq
             IF (g_glaq029<>l_glaq029 OR
                g_glaq030<>l_glaq030 OR
                g_glaq031<>l_glaq031 OR
                g_glaq032<>l_glaq032 OR
                g_glaq033<>l_glaq033 OR
                g_glaq034<>l_glaq034 OR
                g_glaq035<>l_glaq035 OR
                g_glaq036<>l_glaq036 OR
                g_glaq037<>l_glaq037 OR
                g_glaq038<>l_glaq038 AND l_cnt>0) OR l_cnt=0
             THEN
                CALL s_transaction_begin()
                CALL aglt310_delete_glay(g_glap_m.glapld,g_glap_m.glapdocno,g_glaq_d[l_ac].glaqseq) RETURNING l_success
                IF l_success=TRUE THEN
                   CALL aglt310_offset() RETURNING l_success
                END IF
                IF l_success = TRUE THEN
                   CALL s_transaction_end('Y','0') 
                ELSE
                   CALL s_transaction_end('N','0')   
                END IF
             END IF
          END IF
       ELSE
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = 'agl-00106'
          LET g_errparam.extend = l_glaq002
          LET g_errparam.popup = TRUE
          CALL cl_err()
       
       END IF   
    ELSE 
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = 'agl-00052'
       LET g_errparam.extend = 'free account'
       LET g_errparam.popup = TRUE
       CALL cl_err()

    END IF 
END FUNCTION
#开启自由核算项检查，如果该科目未启用自由核算项则不开启维护视窗
PRIVATE FUNCTION aglt310_free_acc_open_chk(p_glaq002)
   DEFINE p_glaq002     LIKE glaq_t.glaq002
   DEFINE r_flag        LIKE type_t.num5
   #是否做自由科目核算项管理A
   DEFINE l_glad017     LIKE glad_t.glad017
   DEFINE l_glad018     LIKE glad_t.glad018
   DEFINE l_glad019     LIKE glad_t.glad019
   DEFINE l_glad020     LIKE glad_t.glad020
   DEFINE l_glad021     LIKE glad_t.glad021
   DEFINE l_glad022     LIKE glad_t.glad022
   DEFINE l_glad023     LIKE glad_t.glad023
   DEFINE l_glad024     LIKE glad_t.glad024
   DEFINE l_glad025     LIKE glad_t.glad025
   DEFINE l_glad026     LIKE glad_t.glad026
   
   #总体说明：若启用该核算项管理则对应控制方式为2.必须输入不检查，3.必须输入必检查，则栏位不可空白，为1时可以空白，否则栏位不可进去
   SELECT glad017,glad018,glad019,glad020,glad021,glad022,glad023,glad024,
          glad025,glad026
     INTO l_glad017,l_glad018,l_glad019,l_glad020,l_glad021,
          l_glad022,l_glad023,l_glad024,l_glad025,l_glad026
    FROM  glad_t
    WHERE gladent = g_enterprise
      AND gladld =  g_glap_m.glapld
      AND glad001 = p_glaq002

   LET r_flag = 0 
   #啟用自由核算項一
   IF l_glad017 = 'Y'  THEN
      LET r_flag = r_flag+1   
   END IF

   #啟用自由核算項二
   IF l_glad018 = 'Y'  THEN
      LET r_flag = r_flag+1   
   END IF

   #啟用自由核算項三
   IF l_glad019 = 'Y'  THEN
      LET r_flag = r_flag+1   
   END IF

   #啟用自由核算項四
   IF l_glad020 = 'Y'  THEN
      LET r_flag = r_flag+1   
   END IF

   #啟用自由核算項五
   IF l_glad021 = 'Y'  THEN
      LET r_flag = r_flag+1   
   END IF
   
   #啟用自由核算項六
   IF l_glad022 = 'Y'  THEN
      LET r_flag = r_flag+1   
   END IF

   #啟用自由核算項七
   IF l_glad023 = 'Y'  THEN
      LET r_flag = r_flag+1   
   END IF

   #啟用自由核算項八
   IF l_glad024 = 'Y'  THEN
      LET r_flag = r_flag+1   
   END IF

   #啟用自由核算項九
   IF l_glad025 = 'Y'  THEN
      LET r_flag = r_flag+1   
   END IF

   #啟用自由核算項十
   IF l_glad026 = 'Y'  THEN
      LET r_flag = r_flag+1   
   END IF
   
   RETURN r_flag
END FUNCTION
#检查该科目对应的业务咨询是有启用相应核算项，如若没有则不开启窗口
PRIVATE FUNCTION aglt310_bus_cons_open_chk(p_glaq002)
   DEFINE p_glaq002    LIKE glaq_t.glaq002
   DEFINE l_glac016    LIKE glac_t.glac016
   DEFINE l_glad005    LIKE glad_t.glad005
   DEFINE r_flag       LIKE type_t.num5
   
   LET r_flag = 0
   #依據是否啟用數量金額式
   SELECT glad005 INTO l_glad005 FROM glad_t
   WHERE gladent = g_enterprise
     AND gladld = g_glap_m.glapld
     AND glad001 =p_glaq002
   IF l_glad005 = 'Y' THEN
      LET r_flag = r_flag + 1
   END IF 
   #判断是否为现金科目
   SELECT glac016 INTO l_glac016 FROM glac_t
    WHERE glacent = g_enterprise
      AND glac001 = g_glaa004
      AND glac002 =p_glaq002 
   #当科目为现金科目，且总账可以维护资金异动明细
   IF l_glac016 = 'Y'  AND g_glaa122 = 'Y' THEN  #150827-00036#6 add "g_glaa122 = 'Y'"
      LET r_flag = r_flag + 1 
   END IF 
   
   RETURN r_flag
END FUNCTION
#区域客群带值
PRIVATE FUNCTION aglt310_glaq020_desc(p_oocql001,p_oocql002)
    DEFINE p_oocql001     LIKE oocql_t.oocql001
    DEFINE p_oocql002     LIKE oocql_t.oocql002
    
    INITIALIZE g_ref_fields TO NULL
    LET g_ref_fields[1] = p_oocql001
    LET g_ref_fields[2] = p_oocql002
    CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=? AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
    RETURN g_rtn_fields[1] 
END FUNCTION
#+ 重组科目显示
PRIVATE FUNCTION aglt310_subject()
   DEFINE l_glaq002    STRING	  
   DEFINE l_str        STRING
   DEFINE l_cnt        LIKE type_t.num5
   DEFINE l_glaq002_desc      LIKE glacl_t.glacl004 #161205-00025#4 add
   DEFINE l_glaq051_desc      LIKE gzcbl_t.gzcbl004 #161205-00025#4 add
   
   #科目(核算項編號)+名称+核算项组合
   CALL aglt310_frozen_clear(1)   
#161205-00025#4--mark--str--      
#   SELECT glaq017,glaq018,glaq019,glaq020,glaq021,glaq022,
#          glaq023,glaq024,glaq051,glaq052,glaq053,glaq025,glaq027,glaq028,
#          glaq029,glaq030,glaq031,glaq032,glaq033,
#          glaq034,glaq035,glaq036,glaq037,glaq038
#     INTO g_glap_m.glaq017,g_glap_m.glaq018,g_glap_m.glaq019,g_glap_m.glaq020,g_glap_m.glaq021,g_glap_m.glaq022,
#          g_glap_m.glaq023,g_glap_m.glaq024,g_glap_m.glaq051,g_glap_m.glaq052,g_glap_m.glaq053,
#          g_glap_m.glaq025,g_glap_m.glaq027,g_glap_m.glaq028,
#          g_glap_m.glaq029,g_glap_m.glaq030,g_glap_m.glaq031,g_glap_m.glaq032,g_glap_m.glaq033,
#          g_glap_m.glaq034,g_glap_m.glaq035,g_glap_m.glaq036,g_glap_m.glaq037,g_glap_m.glaq038
#     FROM glaq_t
#    WHERE glaqent = g_enterprise
#      AND glaqld = g_glap_m.glapld
#      AND glaqdocno = g_glap_m.glapdocno
#      AND glaqseq = g_glaq_d[l_ac].glaqseq 
#161205-00025#4--mark--end
#161205-00025#4--add--str--
   #抓取科目名称、核算项及核算项说明
   LET l_glaq002_desc = ''
   LET l_glaq051_desc = ''
   EXECUTE aglt310_sel_hsx_pr 
     USING g_glaa004,g_glap_m.glapld,g_glap_m.glapdocno,g_glaq_d[l_ac].glaqseq
      INTO g_glap_m.glaq017,g_glap_m.glaq018,g_glap_m.glaq019,g_glap_m.glaq020,g_glap_m.glaq021,g_glap_m.glaq022,
           g_glap_m.glaq023,g_glap_m.glaq024,g_glap_m.glaq051,g_glap_m.glaq052,g_glap_m.glaq053,
           g_glap_m.glaq025,g_glap_m.glaq027,g_glap_m.glaq028,
           g_glap_m.glaq029,g_glap_m.glaq030,g_glap_m.glaq031,g_glap_m.glaq032,g_glap_m.glaq033,
           g_glap_m.glaq034,g_glap_m.glaq035,g_glap_m.glaq036,g_glap_m.glaq037,g_glap_m.glaq038,
           l_glaq002_desc,g_glap_m.glaq017_desc,g_glap_m.glaq018_desc,g_glap_m.glaq019_desc,
           g_glap_m.glaq020_desc,g_glap_m.glaq021_desc,g_glap_m.glaq022_desc,g_glap_m.glaq023_desc,
           g_glap_m.glaq024_desc,g_glap_m.glaq025_desc,g_glap_m.glaq027_desc,g_glap_m.glaq028_desc,
           l_glaq051_desc,g_glap_m.glaq052_desc,g_glap_m.glaq053_desc,
           g_glad0171,g_glad0181,g_glad0191,g_glad0201,g_glad0211,
           g_glad0221,g_glad0231,g_glad0241,g_glad0251,g_glad0261
#161205-00025#4--add--end

   #現金變動碼
   LET g_glap_m.glbc004=''
   LET l_cnt=0 
#161205-00025#4--mod--str--
#   SELECT COUNT(*) INTO l_cnt FROM glbc_t
#    WHERE glbcent = g_enterprise AND glbcld = g_glap_m.glapld
#      AND glbcdocno = g_glap_m.glapdocno
#      AND glbcseq = g_glaq_d[l_ac].glaqseq
#      AND glbc001 = g_glap_m.glap002 
#      AND glbc002 = g_glap_m.glap004
   EXECUTE aglt310_cnt_glbc004_pr 
     USING g_glap_m.glapld,g_glap_m.glapdocno,g_glaq_d[l_ac].glaqseq,g_glap_m.glap002,g_glap_m.glap004
      INTO l_cnt
   IF l_cnt=1 THEN
#      SELECT glbc004 INTO g_glap_m.glbc004 FROM glbc_t
#       WHERE glbcent = g_enterprise AND glbcld = g_glap_m.glapld
#         AND glbcdocno = g_glap_m.glapdocno
#         AND glbcseq = g_glaq_d[l_ac].glaqseq
#         AND glbc001 = g_glap_m.glap002 
#         AND glbc002 = g_glap_m.glap004
      EXECUTE aglt310_sel_glbc004_pr 
        USING g_glaa005,g_glap_m.glapld,g_glap_m.glapdocno,g_glaq_d[l_ac].glaqseq,g_glap_m.glap002,g_glap_m.glap004
         INTO g_glap_m.glbc004,g_glap_m.glbc004_desc
   END IF
#161205-00025#4--mod--end   

   #组合科目，科目名称，以及各核算项
#   CALL aglt310_glaq002() RETURNING l_glaq002,l_str #161205-00025#4 mark
   
   #161205-00025#4--add--str--
   #组合名称以及核算项
   LET l_glaq002 = ''
   LET l_str = ''
   #部门
   IF NOT cl_null(g_glap_m.glaq018) THEN
      IF NOT cl_null(l_glaq002) THEN
         LET l_glaq002 = l_glaq002 ,'-',g_glap_m.glaq018_desc
      ELSE
         LET l_glaq002 = g_glap_m.glaq018_desc
      END IF
      IF NOT cl_null(l_str) THEN
         LET l_str=l_str,'-',g_glap_m.glaq018
      ELSE
         LET l_str=g_glap_m.glaq018
      END IF    
   END IF 
   #成本利润中心
   IF NOT cl_null(g_glap_m.glaq019) THEN
      IF NOT cl_null(l_glaq002) THEN
         LET l_glaq002 = l_glaq002 ,'-',g_glap_m.glaq019_desc
      ELSE
         LET l_glaq002 = g_glap_m.glaq019_desc
      END IF
      IF NOT cl_null(l_str) THEN
         LET l_str=l_str,'-',g_glap_m.glaq019
      ELSE
         LET l_str=g_glap_m.glaq019
      END IF
   END IF 
   
   #区域
   IF NOT cl_null(g_glap_m.glaq020) THEN    
      IF NOT cl_null(l_glaq002) THEN
         LET l_glaq002 = l_glaq002 ,'-',g_glap_m.glaq020_desc
      ELSE
         LET l_glaq002 = g_glap_m.glaq020_desc
      END IF
      IF NOT cl_null(l_str) THEN
         LET l_str=l_str,'-',g_glap_m.glaq020
      ELSE
         LET l_str=g_glap_m.glaq020
      END IF      
   END IF 
   #交易客商
   IF NOT cl_null(g_glap_m.glaq021) THEN
      IF NOT cl_null(l_glaq002) THEN
         LET l_glaq002 = l_glaq002 ,'-',g_glap_m.glaq021_desc
      ELSE
         LET l_glaq002 = g_glap_m.glaq021_desc
      END IF 
      IF NOT cl_null(l_str) THEN
         LET l_str=l_str,'-',g_glap_m.glaq021
      ELSE
         LET l_str=g_glap_m.glaq021
      END IF      
   END IF 
   #账款客商
   IF NOT cl_null(g_glap_m.glaq022) THEN
      IF NOT cl_null(l_glaq002) THEN
         LET l_glaq002 = l_glaq002 ,'-',g_glap_m.glaq022_desc
      ELSE
         LET l_glaq002 = g_glap_m.glaq022_desc
      END IF
      IF NOT cl_null(l_str) THEN
         LET l_str=l_str,'-',g_glap_m.glaq022
      ELSE
         LET l_str=g_glap_m.glaq022
      END IF      
   END IF 
   #客群
   IF NOT cl_null(g_glap_m.glaq023) THEN
      IF NOT cl_null(l_glaq002) THEN
         LET l_glaq002 = l_glaq002 ,'-',g_glap_m.glaq023_desc
      ELSE
         LET l_glaq002 = g_glap_m.glaq023_desc
      END IF
      IF NOT cl_null(l_str) THEN
         LET l_str=l_str,'-',g_glap_m.glaq023
      ELSE
         LET l_str=g_glap_m.glaq023
      END IF      
   END IF 
   
   #产品分类
   IF NOT cl_null(g_glap_m.glaq024) THEN
      IF NOT cl_null(l_glaq002) THEN
         LET l_glaq002 = l_glaq002 ,'-',g_glap_m.glaq024_desc
      ELSE
         LET l_glaq002 = g_glap_m.glaq024_desc
      END IF
      IF NOT cl_null(l_str) THEN
         LET l_str=l_str,'-',g_glap_m.glaq024
      ELSE
         LET l_str=g_glap_m.glaq024
      END IF      
   END IF 
   
   #經營方式
   IF NOT cl_null(g_glap_m.glaq051) THEN
      IF NOT cl_null(l_glaq002) THEN
         LET l_glaq002 = l_glaq002 ,'-',l_glaq051_desc
      ELSE
         LET l_glaq002 = l_glaq051_desc
      END IF
      IF NOT cl_null(l_str) THEN
         LET l_str=l_str,'-',g_glap_m.glaq051
      ELSE
         LET l_str=g_glap_m.glaq051
      END IF      
   END IF 
   
   #渠道
   IF NOT cl_null(g_glap_m.glaq052) THEN
      IF NOT cl_null(l_glaq002) THEN
         LET l_glaq002 = l_glaq002 ,'-',g_glap_m.glaq052_desc
      ELSE
         LET l_glaq002 = g_glap_m.glaq052_desc
      END IF
      IF NOT cl_null(l_str) THEN
         LET l_str=l_str,'-',g_glap_m.glaq052
      ELSE
         LET l_str=g_glap_m.glaq052
      END IF      
   END IF 
   
   #品牌
   IF NOT cl_null(g_glap_m.glaq053) THEN
      IF NOT cl_null(l_glaq002) THEN
         LET l_glaq002 = l_glaq002 ,'-',g_glap_m.glaq053_desc
      ELSE
         LET l_glaq002 = g_glap_m.glaq053_desc
      END IF
      IF NOT cl_null(l_str) THEN
         LET l_str=l_str,'-',g_glap_m.glaq053
      ELSE
         LET l_str=g_glap_m.glaq053
      END IF      
   END IF 
   
   #人员
   IF NOT cl_null(g_glap_m.glaq025) THEN
      IF NOT cl_null(l_glaq002) THEN
         LET l_glaq002 = l_glaq002 ,'-',g_glap_m.glaq025_desc
      ELSE
         LET l_glaq002 = g_glap_m.glaq025_desc
      END IF
      IF NOT cl_null(l_str) THEN
         LET l_str=l_str,'-',g_glap_m.glaq025
      ELSE
         LET l_str=g_glap_m.glaq025
      END IF      
   END IF 
   #专案编号
   IF NOT cl_null(g_glap_m.glaq027) THEN
      IF NOT cl_null(l_glaq002) THEN
         LET l_glaq002 = l_glaq002 ,'-',g_glap_m.glaq027_desc
      ELSE
         LET l_glaq002 = g_glap_m.glaq027_desc
      END IF
      IF NOT cl_null(l_str) THEN
         LET l_str=l_str,'-',g_glap_m.glaq027
      ELSE
         LET l_str=g_glap_m.glaq027
      END IF      
   END IF 
   #WBS
   IF NOT cl_null(g_glap_m.glaq028) THEN
      IF NOT cl_null(l_glaq002) THEN
         LET l_glaq002 = l_glaq002 ,'-',g_glap_m.glaq028_desc
      ELSE
         LET l_glaq002 = g_glap_m.glaq028_desc
      END IF
      IF NOT cl_null(l_str) THEN
         LET l_str=l_str,'-',g_glap_m.glaq028
      ELSE
         LET l_str=g_glap_m.glaq028
      END IF      
   END IF 
   
   #自由核算項一
   IF NOT cl_null(g_glap_m.glaq029) THEN
       CALL s_voucher_free_account_desc(g_glad0171,g_glap_m.glaq029) RETURNING g_glap_m.glaq029_desc
      IF NOT cl_null(l_glaq002) THEN
         LET l_glaq002 = l_glaq002 ,'-',g_glap_m.glaq029_desc
      ELSE
         LET l_glaq002 = g_glap_m.glaq029_desc
      END IF
      IF NOT cl_null(l_str) THEN
         LET l_str=l_str,'-',g_glap_m.glaq029
      ELSE
         LET l_str=g_glap_m.glaq029
      END IF      
   END IF 
   
   #自由核算項二
   IF NOT cl_null(g_glap_m.glaq030) THEN
       CALL s_voucher_free_account_desc(g_glad0181,g_glap_m.glaq030) RETURNING g_glap_m.glaq030_desc
      IF NOT cl_null(l_glaq002) THEN
         LET l_glaq002 = l_glaq002 ,'-',g_glap_m.glaq030_desc
      ELSE
         LET l_glaq002 = g_glap_m.glaq030_desc
      END IF
      IF NOT cl_null(l_str) THEN
         LET l_str=l_str,'-',g_glap_m.glaq030
      ELSE
         LET l_str=g_glap_m.glaq030
      END IF      
   END IF
   
   #自由核算項三
   IF NOT cl_null(g_glap_m.glaq031) THEN
       CALL s_voucher_free_account_desc(g_glad0191,g_glap_m.glaq031) RETURNING g_glap_m.glaq031_desc
      IF NOT cl_null(l_glaq002) THEN
         LET l_glaq002 = l_glaq002 ,'-',g_glap_m.glaq031_desc
      ELSE
         LET l_glaq002 = g_glap_m.glaq031_desc
      END IF
      IF NOT cl_null(l_str) THEN
         LET l_str=l_str,'-',g_glap_m.glaq031
      ELSE
         LET l_str=g_glap_m.glaq031
      END IF      
   END IF
   
   #自由核算項四
   IF NOT cl_null(g_glap_m.glaq032) THEN
       CALL s_voucher_free_account_desc(g_glad0201,g_glap_m.glaq032) RETURNING g_glap_m.glaq032_desc
      IF NOT cl_null(l_glaq002) THEN
         LET l_glaq002 = l_glaq002 ,'-',g_glap_m.glaq032_desc
      ELSE
         LET l_glaq002 = g_glap_m.glaq032_desc
      END IF
      IF NOT cl_null(l_str) THEN
         LET l_str=l_str,'-',g_glap_m.glaq032
      ELSE
         LET l_str=g_glap_m.glaq032
      END IF      
   END IF
   
   #自由核算項五
   IF NOT cl_null(g_glap_m.glaq033) THEN
       CALL s_voucher_free_account_desc(g_glad0211,g_glap_m.glaq033) RETURNING g_glap_m.glaq033_desc
      IF NOT cl_null(l_glaq002) THEN
         LET l_glaq002 = l_glaq002 ,'-',g_glap_m.glaq033_desc
      ELSE
         LET l_glaq002 = g_glap_m.glaq033_desc
      END IF
      IF NOT cl_null(l_str) THEN
         LET l_str=l_str,'-',g_glap_m.glaq033
      ELSE
         LET l_str=g_glap_m.glaq033
      END IF      
   END IF
   
   #自由核算項六
   IF NOT cl_null(g_glap_m.glaq034) THEN
       CALL s_voucher_free_account_desc(g_glad0221,g_glap_m.glaq034) RETURNING g_glap_m.glaq034_desc
      IF NOT cl_null(l_glaq002) THEN
         LET l_glaq002 = l_glaq002 ,'-',g_glap_m.glaq034_desc
      ELSE
         LET l_glaq002 = g_glap_m.glaq034_desc
      END IF
      IF NOT cl_null(l_str) THEN
         LET l_str=l_str,'-',g_glap_m.glaq034
      ELSE
         LET l_str=g_glap_m.glaq034
      END IF      
   END IF
   
   #自由核算項七
   IF NOT cl_null(g_glap_m.glaq035) THEN
       CALL s_voucher_free_account_desc(g_glad0231,g_glap_m.glaq035) RETURNING g_glap_m.glaq035_desc
      IF NOT cl_null(l_glaq002) THEN
         LET l_glaq002 = l_glaq002 ,'-',g_glap_m.glaq035_desc
      ELSE
         LET l_glaq002 = g_glap_m.glaq035_desc
      END IF
      IF NOT cl_null(l_str) THEN
         LET l_str=l_str,'-',g_glap_m.glaq035
      ELSE
         LET l_str=g_glap_m.glaq035
      END IF      
   END IF
   
   #自由核算項八
   IF NOT cl_null(g_glap_m.glaq036) THEN
       CALL s_voucher_free_account_desc(g_glad0241,g_glap_m.glaq036) RETURNING g_glap_m.glaq036_desc
      IF NOT cl_null(l_glaq002) THEN
         LET l_glaq002 = l_glaq002 ,'-',g_glap_m.glaq036_desc
      ELSE
         LET l_glaq002 = g_glap_m.glaq036_desc
      END IF
      IF NOT cl_null(l_str) THEN
         LET l_str=l_str,'-',g_glap_m.glaq036
      ELSE
         LET l_str=g_glap_m.glaq036
      END IF      
   END IF
   
   #自由核算項九
   IF NOT cl_null(g_glap_m.glaq037) THEN
      CALL s_voucher_free_account_desc(g_glad0251,g_glap_m.glaq037) RETURNING g_glap_m.glaq037_desc
      IF NOT cl_null(l_glaq002) THEN
         LET l_glaq002 = l_glaq002 ,'-',g_glap_m.glaq037_desc
      ELSE
         LET l_glaq002 = g_glap_m.glaq037_desc
      END IF
      IF NOT cl_null(l_str) THEN
         LET l_str=l_str,'-',g_glap_m.glaq037
      ELSE
         LET l_str=g_glap_m.glaq037
      END IF      
   END IF
   
   #自由核算項十
   IF NOT cl_null(g_glap_m.glaq038) THEN
      CALL s_voucher_free_account_desc(g_glad0261,g_glap_m.glaq038) RETURNING g_glap_m.glaq038_desc
      IF NOT cl_null(l_glaq002) THEN
         LET l_glaq002 = l_glaq002 ,'-',g_glap_m.glaq038_desc
      ELSE
         LET l_glaq002 = g_glap_m.glaq038_desc
      END IF
      IF NOT cl_null(l_str) THEN
         LET l_str=l_str,'-',g_glap_m.glaq038
      ELSE
         LET l_str=g_glap_m.glaq038
      END IF      
   END IF
   
   #現金變動碼
   IF NOT cl_null(g_glap_m.glbc004) THEN
      IF NOT cl_null(l_glaq002) THEN
         LET l_glaq002 = l_glaq002 ,'-',g_glap_m.glbc004_desc
      ELSE
         LET l_glaq002 = g_glap_m.glbc004_desc
      END IF
      IF NOT cl_null(l_str) THEN
         LET l_str=l_str,'-',g_glap_m.glbc004
      ELSE
         LET l_str=g_glap_m.glbc004
      END IF
   END IF
   
   #组合科目名称以及核算项
   LET l_glaq002 = l_glaq002_desc,'\n',
                   l_glaq002
   IF NOT cl_null(l_str) THEN
      LET l_str="(",l_str,")"
   END IF
   #161205-00025#4--add--end
   
   LET g_glaq_d[l_ac].lc_subject = g_glaq_d[l_ac].glaq002,l_str,'\n',l_glaq002
END FUNCTION
################################################################################
# Descriptions...: 描述说明
# Memo...........: 輸入一筆細項立賬資料glax_t
# Usage..........: CALL aglt310_insert_glax()
# Date & Author..: 14/02/08 By wangrr
# Modify.........:
################################################################################
PRIVATE FUNCTION aglt310_insert_glax()
   #161128-00061#1----modify------begin-----------
   #DEFINE l_glax           RECORD LIKE glax_t.*
   DEFINE l_glax RECORD  #傳票項次立帳異動檔
       glaxent LIKE glax_t.glaxent, #企業編號
       glaxownid LIKE glax_t.glaxownid, #資料所有者
       glaxowndp LIKE glax_t.glaxowndp, #資料所屬部門
       glaxcrtid LIKE glax_t.glaxcrtid, #資料建立者
       glaxcrtdp LIKE glax_t.glaxcrtdp, #資料建立部門
       glaxcrtdt LIKE glax_t.glaxcrtdt, #資料創建日
       glaxmodid LIKE glax_t.glaxmodid, #資料修改者
       glaxmoddt LIKE glax_t.glaxmoddt, #最近修改日
       glaxcnfid LIKE glax_t.glaxcnfid, #資料確認者
       glaxcnfdt LIKE glax_t.glaxcnfdt, #資料確認日
       glaxstus LIKE glax_t.glaxstus, #狀態碼
       glaxld LIKE glax_t.glaxld, #帳套
       glaxcomp LIKE glax_t.glaxcomp, #法人
       glaxdocno LIKE glax_t.glaxdocno, #單號
       glaxseq LIKE glax_t.glaxseq, #項次
       glaxdocdt LIKE glax_t.glaxdocdt, #單據日期
       glax001 LIKE glax_t.glax001, #摘要
       glax002 LIKE glax_t.glax002, #科目編號
       glax003 LIKE glax_t.glax003, #本幣立帳金額
       glax005 LIKE glax_t.glax005, #交易幣別
       glax006 LIKE glax_t.glax006, #匯率
       glax007 LIKE glax_t.glax007, #計價單位
       glax008 LIKE glax_t.glax008, #立帳數量
       glax009 LIKE glax_t.glax009, #單價
       glax010 LIKE glax_t.glax010, #原幣立帳金額
       glax011 LIKE glax_t.glax011, #票據號碼
       glax012 LIKE glax_t.glax012, #票據日期
       glax013 LIKE glax_t.glax013, #申請人
       glax014 LIKE glax_t.glax014, #銀行帳號
       glax015 LIKE glax_t.glax015, #結算方式
       glax016 LIKE glax_t.glax016, #收支專案
       glax017 LIKE glax_t.glax017, #營運據點
       glax018 LIKE glax_t.glax018, #部門
       glax019 LIKE glax_t.glax019, #利潤/成本中心
       glax020 LIKE glax_t.glax020, #區域
       glax021 LIKE glax_t.glax021, #收付款客商
       glax022 LIKE glax_t.glax022, #帳款客商
       glax023 LIKE glax_t.glax023, #客群
       glax024 LIKE glax_t.glax024, #產品類別
       glax025 LIKE glax_t.glax025, #人員
       glax026 LIKE glax_t.glax026, #no use
       glax027 LIKE glax_t.glax027, #專案編號
       glax028 LIKE glax_t.glax028, #WBS
       glax029 LIKE glax_t.glax029, #自由核算項一
       glax030 LIKE glax_t.glax030, #自由核算項二
       glax031 LIKE glax_t.glax031, #自由核算項三
       glax032 LIKE glax_t.glax032, #自由核算項四
       glax033 LIKE glax_t.glax033, #自由核算項五
       glax034 LIKE glax_t.glax034, #自由核算項六
       glax035 LIKE glax_t.glax035, #自由核算項七
       glax036 LIKE glax_t.glax036, #自由核算項八
       glax037 LIKE glax_t.glax037, #自由核算項九
       glax038 LIKE glax_t.glax038, #自由核算項十
       glax041 LIKE glax_t.glax041, #本幣預沖金額
       glax042 LIKE glax_t.glax042, #本幣已沖金額
       glax043 LIKE glax_t.glax043, #預沖數量
       glax044 LIKE glax_t.glax044, #已沖數量
       glax045 LIKE glax_t.glax045, #原幣預沖金額
       glax046 LIKE glax_t.glax046, #原幣已沖金額
       glax047 LIKE glax_t.glax047, #資料來源
       glax048 LIKE glax_t.glax048, #原始憑證號碼
       glax049 LIKE glax_t.glax049, #會計年度
       glax050 LIKE glax_t.glax050, #會計期別
       glax051 LIKE glax_t.glax051, #匯率(本位幣二)
       glax052 LIKE glax_t.glax052, #立帳金額(本位幣二)
       glax053 LIKE glax_t.glax053, #預沖金額(本位幣二)
       glax054 LIKE glax_t.glax054, #已沖金額(本位幣二)
       glax055 LIKE glax_t.glax055, #匯率(本位幣三)
       glax056 LIKE glax_t.glax056, #立帳金額(本位幣三)
       glax057 LIKE glax_t.glax057, #預沖金額(本位幣三)
       glax058 LIKE glax_t.glax058, #已沖金額(本位幣三)
       glax061 LIKE glax_t.glax061, #經營方式
       glax062 LIKE glax_t.glax062, #渠道
       glax063 LIKE glax_t.glax063  #品牌
       END RECORD

   #161128-00061#1----modify------end-----------
   DEFINE l_glad003        LIKE glad_t.glad003
   DEFINE l_glad004        LIKE glad_t.glad004
   DEFINE l_success        LIKE type_t.num5
    
   LET l_success = TRUE
   CALL aglt310_get_glad(g_glap_m.glapld,g_glaq_d[l_ac].glaq002) RETURNING l_glad003,l_glad004
   IF l_glad003 <>'Y' OR cl_null(l_glad003) THEN
      RETURN l_success
   END IF
   #當科目細項立帳在借方，但此時是沖帳時不執行操作
   IF l_glad004='1' AND g_glaq_d[l_ac].glaq003=0 THEN
      RETURN l_success
   END IF
   #當科目細項立帳在貸方，但此時是沖帳時不執行操作
   IF l_glad004='2' AND g_glaq_d[l_ac].glaq004=0 THEN
      RETURN l_success
   END IF
   LET l_glax.glaxent=g_enterprise
   LET l_glax.glaxld=g_glap_m.glapld
   LET l_glax.glaxcomp=g_glap_m.glapcomp
   LET l_glax.glaxdocno=g_glap_m.glapdocno
   LET l_glax.glaxseq=g_glaq_d[l_ac].glaqseq
   LET l_glax.glaxdocdt=g_glap_m.glapdocdt
   LET l_glax.glax001=g_glaq_d[l_ac].glaq001
   LET l_glax.glax002=g_glaq_d[l_ac].glaq002
   LET l_glax.glax051=g_glaq_d[l_ac].glaq039
   LET l_glax.glax052=0
   LET l_glax.glax055=g_glaq_d[l_ac].glaq042
   LET l_glax.glax056=0
   IF l_glad004='1' THEN 
      LET l_glax.glax003=g_glaq_d[l_ac].glaq003     #立賬借方
      IF g_glaa015='Y' THEN
         LET l_glax.glax052=g_glaq_d[l_ac].glaq040  #立賬金額(本位幣二)
      END IF
      IF g_glaa019='Y' THEN
         LET l_glax.glax056=g_glaq_d[l_ac].glaq043  #立賬金額(本位幣三)
      END IF
   ELSE
      LET l_glax.glax003=g_glaq_d[l_ac].glaq004     #立賬貸方
      IF g_glaa015='Y' THEN
         LET l_glax.glax052=g_glaq_d[l_ac].glaq041  #立賬金額(本位幣二)
      END IF
      IF g_glaa019='Y' THEN
         LET l_glax.glax056=g_glaq_d[l_ac].glaq044  #立賬金額(本位幣三)
      END IF
   END IF
   LET l_glax.glax005=g_glaq_d[l_ac].glaq005     #幣別
   LET l_glax.glax006=g_glaq_d[l_ac].glaq006     #匯率
   LET l_glax.glax007=g_glap_m.glaq007           #計價單位
   LET l_glax.glax008=g_glap_m.glaq008           #數量
   LET l_glax.glax009=g_glap_m.glaq009           #單價
   LET l_glax.glax010=g_glaq_d[l_ac].glaq010     #原幣金額
   
   LET l_glax.glax011=g_glap_m.glaq011
   LET l_glax.glax012=g_glap_m.glaq012
   LET l_glax.glax013=g_glap_m.glaq013
   LET l_glax.glax014=g_glap_m.glaq014
   LET l_glax.glax015=g_glap_m.glaq015
   LET l_glax.glax016=g_glap_m.glaq016
   #固定核算项
   LET l_glax.glax017=g_glaq_r.glaq017
   LET l_glax.glax018=g_glaq_r.glaq018
   LET l_glax.glax019=g_glaq_r.glaq019
   LET l_glax.glax020=g_glaq_r.glaq020
   LET l_glax.glax021=g_glaq_r.glaq021
   LET l_glax.glax022=g_glaq_r.glaq022
   LET l_glax.glax023=g_glaq_r.glaq023
   LET l_glax.glax024=g_glaq_r.glaq024
   LET l_glax.glax061=g_glaq_r.glaq051
   LET l_glax.glax062=g_glaq_r.glaq052
   LET l_glax.glax063=g_glaq_r.glaq053
   LET l_glax.glax025=g_glaq_r.glaq025
   LET l_glax.glax027=g_glaq_r.glaq027
   LET l_glax.glax028=g_glaq_r.glaq028
   #自由核算項
   LET l_glax.glax029=g_glaq_r.glaq029
   LET l_glax.glax030=g_glaq_r.glaq030
   LET l_glax.glax031=g_glaq_r.glaq031
   LET l_glax.glax032=g_glaq_r.glaq032
   LET l_glax.glax033=g_glaq_r.glaq033
   LET l_glax.glax034=g_glaq_r.glaq034
   LET l_glax.glax035=g_glaq_r.glaq035
   LET l_glax.glax036=g_glaq_r.glaq036
   LET l_glax.glax037=g_glaq_r.glaq037
   LET l_glax.glax038=g_glaq_r.glaq038
   
   LET l_glax.glax041=0    #本幣預沖金額
   LET l_glax.glax042=0    #本幣已沖金額
   LET l_glax.glax043=0    #預沖數量
   LET l_glax.glax044=0    #已沖數量
   LET l_glax.glax045=0    #原幣預沖金額
   LET l_glax.glax046=0    #原幣已沖金額
   LET l_glax.glax047='1'  #資料來源 1:傳票輸入時產生
   LET l_glax.glax048=g_glap_m.glap015 #原始憑證編號
   LET l_glax.glax049=g_glap_m.glap002 #會計年度
   LET l_glax.glax050=g_glap_m.glap004 #會計期別
   LET l_glax.glax053=0    #本幣預沖金額(本位幣二)
   LET l_glax.glax054=0    #本幣已沖金額(本位幣二)
   LET l_glax.glax057=0    #本幣預沖金額(本位幣三)
   LET l_glax.glax058=0    #本幣已沖金額(本位幣三)
   
   
   LET l_glax.glaxstus='N' 
   LET l_glax.glaxownid=g_user
   LET l_glax.glaxowndp=g_dept
   LET l_glax.glaxcrtid=g_user
   LET l_glax.glaxcrtdp=g_dept
   LET l_glax.glaxcrtdt=cl_get_current()
   
   INSERT INTO glax_t (
   glaxent,glaxld,glaxcomp,glaxdocno,glaxseq,glaxdocdt,
   glax001,glax002,glax003,glax005,glax006,glax007,glax008,glax009,glax010,
   glax011,glax012,glax013,glax014,glax015,glax016,glax017,glax018,glax019,glax020,
   glax021,glax022,glax023,glax024,glax025,glax027,glax028,glax029,glax030,
   glax031,glax032,glax033,glax034,glax035,glax036,glax037,glax038,
   glax041,glax042,glax043,glax044,glax045,glax046,glax047,glax048,glax049,glax050,
   glax051,glax052,glax053,glax054,glax055,glax056,glax057,glax058,
   glax061,glax062,glax063,  #170113-00042#1 add
   glaxstus,glaxownid,glaxowndp,glaxcrtid,glaxcrtdp,glaxcrtdt
   )
   VALUES(
   l_glax.glaxent,l_glax.glaxld,l_glax.glaxcomp,l_glax.glaxdocno,
   l_glax.glaxseq,l_glax.glaxdocdt,
   l_glax.glax001,l_glax.glax002,l_glax.glax003,l_glax.glax005,
   l_glax.glax006,l_glax.glax007,l_glax.glax008,l_glax.glax009,l_glax.glax010,
   l_glax.glax011,l_glax.glax012,l_glax.glax013,l_glax.glax014,l_glax.glax015,
   l_glax.glax016,l_glax.glax017,l_glax.glax018,l_glax.glax019,l_glax.glax020,
   l_glax.glax021,l_glax.glax022,l_glax.glax023,l_glax.glax024,l_glax.glax025,
   l_glax.glax027,l_glax.glax028,l_glax.glax029,l_glax.glax030,
   l_glax.glax031,l_glax.glax032,l_glax.glax033,l_glax.glax034,l_glax.glax035,
   l_glax.glax036,l_glax.glax037,l_glax.glax038,
   l_glax.glax041,l_glax.glax042,l_glax.glax043,l_glax.glax044,l_glax.glax045,
   l_glax.glax046,l_glax.glax047,l_glax.glax048,l_glax.glax049,l_glax.glax050,
   l_glax.glax051,l_glax.glax052,l_glax.glax053,l_glax.glax054,l_glax.glax055,
   l_glax.glax056,l_glax.glax057,l_glax.glax058,
   l_glax.glax061,l_glax.glax062,l_glax.glax063,  #170113-00042#1 add
   l_glax.glaxstus,l_glax.glaxownid,l_glax.glaxowndp,l_glax.glaxcrtid,
   l_glax.glaxcrtdp,l_glax.glaxcrtdt
   )
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = sqlca.sqlcode
      LET g_errparam.extend = 'insert glax_t'
      LET g_errparam.popup = TRUE
      CALL cl_err()
 
      LET l_success = FALSE
   END IF 
   RETURN l_success
END FUNCTION
################################################################################
# Descriptions...: 描述说明
# Memo...........: 判斷是否進行細項立沖
# Usage..........: CALL aglt310_offset()
# Date & Author..: 14/02/07 By wangrr
# Modify.........:
################################################################################
PRIVATE FUNCTION aglt310_offset()
   DEFINE l_glad003        LIKE glad_t.glad003
   DEFINE l_glad004        LIKE glad_t.glad004 
   DEFINE l_glaq003_s      LIKE glaq_t.glaq003
   DEFINE l_glaq004_s      LIKE glaq_t.glaq004
   DEFINE r_success        LIKE type_t.num5
   DEFINE l_cnt            LIKE type_t.num5
   DEFINE l_success        LIKE type_t.num5
   
   LET r_success=TRUE
   IF g_glap_m.glapld IS NULL OR g_glap_m.glapdocno IS NULL THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()

      RETURN r_success
   END IF
   IF g_glap_m.glapstus<>'N' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "amm-00058"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()

      RETURN r_success
   END IF
   #单身无资料不需开出画面
   IF l_ac =0 OR cl_null(l_ac) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = -400
      LET g_errparam.extend = ''
      LET g_errparam.popup = FALSE
      CALL cl_err()
    
      RETURN r_success
   END IF 
   
   CALL aglt310_get_glad(g_glap_m.glapld,g_glaq_d[l_ac].glaq002) RETURNING l_glad003,l_glad004
   IF l_glad003 <>'Y' OR cl_null(l_glad003) THEN
      #170103-00019#1--add--str--
      #当点选明细操作中的细项冲账时，不用冲抵时提示
      IF g_action_choice="offset" THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'agl-00536'
         LET g_errparam.extend = ''
         LET g_errparam.popup = FALSE
         CALL cl_err()
         LET SQLCA.sqlcode = 0
      END IF
      #170103-00019#1--add--end
      RETURN r_success
   END IF
   IF g_glap001_p <> '6' THEN   #151204-00001#1 add
      #檢查當單據日期小於等於關帳日期時，不可異動單據
      CALL s_fin_date_close_chk(g_glap_m.glapld,'','AGL',g_glap_m.glapdocdt) RETURNING l_success
      IF l_success = FALSE THEN
         RETURN r_success
      END IF
   END IF  #151204-00001#1 add
#   SELECT SUM(glaq003),SUM(glaq004) INTO l_glaq003_s,l_glaq004_s
#     FROM glaq_t
#    WHERE glaqent = g_enterprise
#      AND glaqld = g_glap_m.glapld
#      AND glaqdocno = g_glap_m.glapdocno
#      AND glaqseq<>g_glaq_d[l_ac].glaqseq
#   IF cl_null(l_glaq003_s) THEN LET l_glaq003_s=0 END IF
#   IF cl_null(l_glaq004_s) THEN LET l_glaq004_s=0 END IF
#   
#   IF (l_glaq003_s>l_glaq004_s AND l_glad004='1') OR
#      (l_glaq003_s<l_glaq004_s AND l_glad004='2')
#   THEN
   #当前科目为细项冲帐时，查询可匹配的细项立帐资料
   IF (g_glaq_d[l_ac].glaq003>0 AND l_glad004='2') OR
      (g_glaq_d[l_ac].glaq004>0 AND l_glad004='1') 
   THEN
      CALL aglt310_06(g_glap_m.glapld,g_glaq_d[l_ac].glaq002,g_glap_m.glapdocno,g_glaq_d[l_ac].glaqseq)
      RETURNING r_success
   #170103-00019#1--add--str--
   ELSE
      #当点选明细操作中的细项冲账时，不用冲抵时提示
      IF g_action_choice="offset" THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'agl-00536'
         LET g_errparam.extend = ''
         LET g_errparam.popup = FALSE
         CALL cl_err()
         LET SQLCA.sqlcode = 0
      END IF
   #170103-00019#1--add--end
   END IF
   RETURN r_success
END FUNCTION
################################################################################
# Descriptions...: 描述说明
# Memo...........: 刪除傳票項次立帳異動資料
# Usage..........: CALL aglt310_delete_glax(p_glaxld,p_glaxdocno,p_glaxseq)
# Input parameter: p_glaxld      帳套
#                : p_glaxdocno   傳票單號
#                : p_glaxseq     項次
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 14/02/08 By wangrr
# Modify.........:
################################################################################
PRIVATE FUNCTION aglt310_delete_glax(p_glaxld,p_glaxdocno,p_glaxseq)
   DEFINE p_glaxld      LIKE glax_t.glaxld
   DEFINE p_glaxdocno   LIKE glax_t.glaxdocno
   DEFINE p_glaxseq     LIKE glax_t.glaxseq
   DEFINE l_cnt         LIKE type_t.num5
   DEFINE l_success     LIKE type_t.num5
   
   LET l_success=TRUE
   LET l_cnt=0
   SELECT COUNT(1) INTO l_cnt FROM glax_t #161205-00025#4 mod '*'-->1
    WHERE glaxent=g_enterprise  AND glaxld=p_glaxld
      AND glaxdocno=p_glaxdocno AND glaxseq=p_glaxseq
   IF l_cnt>0 THEN
      DELETE FROM glax_t
       WHERE glaxent=g_enterprise  AND glaxld=p_glaxld
         AND glaxdocno=p_glaxdocno AND glaxseq=p_glaxseq
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "del glax_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

         LET l_success=FALSE
      END IF
   END IF
   RETURN l_success         
END FUNCTION
################################################################################
# Descriptions...: 描述说明
# Memo...........: 刪除傳票項次沖帳異動資料
# Usage..........: CALL aglt310_delete_glay(p_glayld,p_glaydocno,p_glayseq)
# Input parameter: p_glayld      帳套
#                : p_glaydocno   傳票單號、
#                : p_glayseq     項次
# Date & Author..: 14/02/08 By wangrr
# Modify.........:
################################################################################
PRIVATE FUNCTION aglt310_delete_glay(p_glayld,p_glaydocno,p_glayseq)
   DEFINE p_glayld      LIKE glay_t.glayld
   DEFINE p_glaydocno   LIKE glay_t.glaydocno
   DEFINE p_glayseq     LIKE glay_t.glayseq
   DEFINE l_cnt         LIKE type_t.num5
   DEFINE l_success     LIKE type_t.num5
   
   LET l_success=TRUE
   LET l_cnt=0
   SELECT COUNT(1) INTO l_cnt FROM glay_t #161205-00025#4 mod '*'-->1
    WHERE glayent=g_enterprise  AND glayld=p_glayld
      AND glaydocno=p_glaydocno AND glayseq=p_glayseq
   IF l_cnt>0 THEN
      #再刪除細項沖帳資料前更新相對應的細項立帳資料
      CALL aglt310_update_glax(p_glayld,p_glaydocno,p_glayseq) RETURNING l_success
      IF l_success=TRUE THEN
         DELETE FROM glay_t
          WHERE glayent=g_enterprise  AND glayld=p_glayld
            AND glaydocno=p_glaydocno AND glayseq=p_glayseq
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "del glax_t"
            LET g_errparam.popup = FALSE
            CALL cl_err()

            LET l_success=FALSE
         END IF
      END IF
   END IF
   RETURN l_success
END FUNCTION
################################################################################
# Descriptions...: 描述说明
# Memo...........: 更新細項立沖賬資料
# Usage..........: CALL aglt310_update_glax_and_glay()
# Date & Author..: 14/02/08 By wangrr
# Modify.........:
################################################################################
PRIVATE FUNCTION aglt310_update_glax_and_glay()
   DEFINE l_glad003_o           LIKE glad_t.glad003
   DEFINE l_glad004_o           LIKE glad_t.glad004 
   DEFINE l_glad003             LIKE glad_t.glad003
   DEFINE l_glad004             LIKE glad_t.glad004
   DEFINE l_flag                LIKE type_t.chr2
   DEFINE l_sum                 LIKE glaq_t.glaq003
   DEFINE l_sum1                LIKE glaq_t.glaq003
   DEFINE l_success             LIKE type_t.num5
   DEFINE l_success1            LIKE type_t.num5
   DEFINE l_cnt                 LIKE type_t.num5
   
   #異動前科目
   CALL aglt310_get_glad(g_glap_m.glapld,g_glaq_d_t.glaq002) RETURNING l_glad003_o,l_glad004_o
   #異動后科目   
   CALL aglt310_get_glad(g_glap_m.glapld,g_glaq_d[l_ac].glaq002) RETURNING l_glad003,l_glad004 
   
   LET l_flag='r'
   IF g_glaq_d_t.glaq002<>g_glaq_d[l_ac].glaq002 THEN
      IF l_glad003_o='N' AND l_glad003='Y' THEN
         IF (l_glad004='1' AND g_glaq_d[l_ac].glaq003>0) OR
            (l_glad004='2' AND g_glaq_d[l_ac].glaq004>0) THEN
            LET l_flag='ix'    #新增一筆立帳資料glax_t
         ELSE
            IF (l_glad004='1' AND g_glaq_d[l_ac].glaq004>0) OR
               (l_glad004='2' AND g_glaq_d[l_ac].glaq003>0) THEN
               LET l_flag='iy'    #新增一筆沖帳資料glay_t
            END IF
         END IF 
      END IF
      IF l_glad003_o='N' AND l_glad003='N' THEN
         LET l_flag='r'
      END IF 
      IF l_glad003_o='Y' AND l_glad003='Y' THEN
         #修改后細項立帳
         IF (l_glad004='1' AND g_glaq_d[l_ac].glaq003>0) OR
            (l_glad004='2' AND g_glaq_d[l_ac].glaq004>0) THEN
            IF (l_glad004_o='1' AND g_glaq_d_t.glaq003>0) OR
               (l_glad004_o='2' AND g_glaq_d_t.glaq004>0) THEN
               LET l_flag='ux' #更新立帳glax_t
            ELSE
               LET l_flag='xy' #新增一筆立帳資料glax_t，同時刪除相關沖帳資料glay_t
            END IF
         #修改后細項沖帳
         ELSE
            IF (l_glad004_o='1' AND g_glaq_d_t.glaq003>0) OR
               (l_glad004_o='2' AND g_glaq_d_t.glaq004>0) THEN
               LET l_flag='yx' #新增一筆沖帳資料glay_t，刪除相關立帳資料glax_t
            ELSE
               LET l_flag='uy' #更新沖帳glay_t
            END IF
         END IF
      END IF
      IF l_glad003_o='Y' AND l_glad003='N' THEN
         LET l_flag='d'
      END IF
   ELSE  
      IF l_glad003='Y' THEN
         IF (l_glad004='1' AND g_glaq_d[l_ac].glaq003>0 ) OR
            (l_glad004='2' AND g_glaq_d[l_ac].glaq004>0 ) THEN
            LET l_flag='ux'   #更新立帳glax_t
         ELSE
            IF (l_glad004='1' AND g_glaq_d_t.glaq003>0 AND g_glaq_d[l_ac].glaq003=0) OR
               (l_glad004='2' AND g_glaq_d_t.glaq004>0 AND g_glaq_d[l_ac].glaq004=0 ) THEN
               LET l_flag='yx' #删除立帐glax_t
            ELSE
               LET l_flag='uy'   #更新立帳glay_t
            END IF
         END IF
      ELSE
         LET l_flag='r'
      END IF
   END IF
   
   LET l_success=TRUE
   LET l_success1=TRUE
   CASE 
      WHEN l_flag='r'
         RETURN
      WHEN l_flag='ix' 
         CALL aglt310_insert_glax()  RETURNING l_success            
      WHEN l_flag='d'
         CALL aglt310_delete_glax(g_glap_m.glapld,g_glap_m.glapdocno,g_glaq_d[l_ac].glaqseq) RETURNING l_success
         CALL aglt310_delete_glay(g_glap_m.glapld,g_glap_m.glapdocno,g_glaq_d[l_ac].glaqseq) RETURNING l_success1 
      WHEN l_flag='yx'
         CALL aglt310_delete_glax(g_glap_m.glapld,g_glap_m.glapdocno,g_glaq_d[l_ac].glaqseq) RETURNING l_success
         CALL aglt310_06(g_glap_m.glapld,g_glaq_d[l_ac].glaq002,g_glap_m.glapdocno,g_glaq_d[l_ac].glaqseq) 
         RETURNING l_success1
      WHEN l_flag='ux'
         #本幣立帳金額
         IF g_glaq_d[g_detail_idx].glaq003>0 THEN
            LET l_sum=g_glaq_d[g_detail_idx].glaq003
         ELSE
            LET l_sum=g_glaq_d[g_detail_idx].glaq004
         END IF
         #170113-00042#1--add--str--
         #当没有glax_t资料时，新增glax，有资料，更新glax
         LET l_cnt = 0
         SELECT COUNT(1) INTO l_cnt FROM glax_t
          WHERE glaxent = g_enterprise AND glaxld = g_glap_m.glapld
            AND glaxdocno = g_glap_m.glapdocno AND glaxseq = g_glaq_d[l_ac].glaqseq
         IF l_cnt = 0 THEN
            CALL aglt310_insert_glax() RETURNING l_success
         ELSE
         #170113-00042#1--add--end
            UPDATE glax_t 
               SET (glax001,glax002,glax003,glax005,glax006,glax010,glax051,glax052,glax055,glax056) 
                 = 
                   (g_glaq_d[l_ac].glaq001,g_glaq_d[l_ac].glaq002,l_sum,
                    g_glaq_d[l_ac].glaq005,g_glaq_d[l_ac].glaq006,g_glaq_d[l_ac].glaq010,
                    g_glaq_d[l_ac].glaq039,g_glaq_d[l_ac].amt2,g_glaq_d[l_ac].glaq042,g_glaq_d[l_ac].amt3
                   ) 
             WHERE glaxent = g_enterprise AND glaxld = g_glap_m.glapld 
               AND glaxdocno = g_glap_m.glapdocno AND glaxseq = g_glaq_d[l_ac].glaqseq
            CASE
               WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "std-00009"
                  LET g_errparam.extend = "glax_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
            
                  LET l_success=FALSE
               WHEN SQLCA.sqlcode #其他錯誤
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "glax_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
            
                  LET l_success=FALSE
            END CASE
         END IF #170113-00042#1 add
      WHEN l_flag='uy'
#         SELECT COUNT(*) INTO l_cnt FROM glay_t
#         WHERE glayent=g_enterprise AND glayld=g_glap_m.glapld
#           AND glaydocno=g_glap_m.glapdocno
#           AND glayseq=g_glaq_d[l_ac].glaqseq
#         IF l_cnt>0 THEN
#            #本幣沖帳金額
#            IF g_glaq_d[g_detail_idx].glaq003>0 THEN
#               LET l_sum=g_glaq_d[g_detail_idx].glaq003
#            ELSE
#               LET l_sum=g_glaq_d[g_detail_idx].glaq004
#            END IF
#            #該立帳傳票可沖抵金額
#            SELECT glax003-glax041-glax042 INTO l_sum1 
#              FROM glax_t 
#             WHERE glaxent=g_enterprise AND glaxld=g_glap_m.glapld
#               AND glaxdocno||glaxseq=(SELECT glay041||glay042
#                                         FROM glay_t
#                                        WHERE glayent=g_enterprise 
#                                          AND glayld=g_glap_m.glapld
#                                          AND glaydocno=g_glap_m.glapdocno
#                                          AND glayseq=g_glaq_d[l_ac].glaqseq)
#            IF cl_null(l_sum1) THEN LET l_sum1=0 END IF
#            IF l_sum>l_sum1 THEN
#               CALL cl_err('','agl-00202',1)
#               CALL s_transaction_end('N','0')
#               RETURN
#            END IF
#            UPDATE glay_t 
#               SET (glay001,glay002,glay003,glay005,glay006,glay010,glay051,glay052,glay053,glay054) 
#                 = 
#                   (g_glaq_d[l_ac].glaq001,g_glaq_d[l_ac].glaq002,l_sum,
#                    g_glaq_d[l_ac].glaq005,g_glaq_d[l_ac].glaq006,g_glaq_d[l_ac].glaq010,
#                    g_glaq_d[l_ac].glaq039,g_glaq_d[l_ac].amt2,g_glaq_d[l_ac].glaq042,g_glaq_d[l_ac].amt3
#                   ) 
#             WHERE glayent = g_enterprise AND glayld = g_glap_m.glapld 
#               AND glaydocno = g_glap_m.glapdocno AND glayseq = g_glaq_d[l_ac].glaqseq
#            CASE
#               WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
#                  CALL cl_err("glay_t","std-00009",1)
#                  LET l_success=FALSE
#               WHEN SQLCA.sqlcode #其他錯誤
#                  CALL cl_err("glay_t",SQLCA.sqlcode,1)  
#                  LET l_success=FALSE
#            END CASE
#         END IF
         CALL aglt310_delete_glay(g_glap_m.glapld,g_glap_m.glapdocno,g_glaq_d[l_ac].glaqseq) RETURNING l_success
         CALL aglt310_06(g_glap_m.glapld,g_glaq_d[l_ac].glaq002,g_glap_m.glapdocno,g_glaq_d[l_ac].glaqseq) 
         RETURNING l_success1
      WHEN l_flag='xy'
         CALL aglt310_insert_glax() RETURNING l_success
         CALL aglt310_delete_glay(g_glap_m.glapld,g_glap_m.glapdocno,g_glaq_d[l_ac].glaqseq) RETURNING l_success1
   END CASE
   
   IF l_success=FALSE OR l_success1=FALSE THEN
      CALL s_transaction_end('N','0')
   END IF  
END FUNCTION
################################################################################
# Descriptions...: 描述说明
# Memo...........: 檢查細項立沖帳資料是否正確
# Usage..........: CALL aglt310_glax_and_glay_chk(p_glapld,p_glapdocno)
#                  RETURNING l_success
# Input parameter: p_glapld      帳套
#                : p_glapdocno   傳票編號
# Return code....: l_success     是否有錯誤
# Date & Author..: 14/02/10 By wangrr
# Modify.........:
################################################################################
PRIVATE FUNCTION aglt310_glax_and_glay_chk(p_glapld,p_glapdocno)
   DEFINE p_glapld           LIKE glap_t.glapld
   DEFINE p_glapdocno        LIKE glap_t.glapdocno
   DEFINE l_glaqseq          LIKE glaq_t.glaqseq
   DEFINE l_glaq002          LIKE glaq_t.glaq002
   DEFINE l_glaq010          LIKE glaq_t.glaq010
   DEFINE l_glaq003          LIKE glaq_t.glaq003
   DEFINE l_glaq004          LIKE glaq_t.glaq004
   DEFINE r_success          LIKE type_t.num5
   DEFINE l_cnt              LIKE type_t.num5
   DEFINE l_sum              LIKE glay_t.glay003
   DEFINE l_sum1             LIKE glay_t.glay003
   DEFINE l_flag             LIKE type_t.chr1
   DEFINE l_glad003          LIKE glad_t.glad003
   DEFINE l_glad004          LIKE glad_t.glad004
   
   LET g_sql = "SELECT UNIQUE glaqseq,glaq002,glaq010,glaq003,glaq004,glad003,glad004 FROM glaq_t", #161205-00025#4 add glad003,glad004  
               " INNER JOIN glap_t ON glapld = glaqld AND glapent = glaqent ", #170214-00033#1 add ENT
               " AND glapdocno = glaqdocno ",               
               " LEFT JOIN glad_t ON gladent=glaqent AND gladld=glaqld AND glad001=glaq002 ", #161205-00025#4 add
               " WHERE glaqent='",g_enterprise,"' ",
               "   AND glaqld='",p_glapld,"' ",
               "   AND glaqdocno='",p_glapdocno,"' ",
               "   AND glad003 = 'Y' ", #161205-00025#4 add
               " ORDER BY glaq_t.glaqseq"
   PREPARE t310_chk_pr1 FROM g_sql
   DECLARE t310_chk_cur1 CURSOR FOR t310_chk_pr1
   
   LET r_success=TRUE
   FOREACH t310_chk_cur1 INTO l_glaqseq,l_glaq002,l_glaq010,l_glaq003,l_glaq004
                             ,l_glad003,l_glad004  #161205-00025#4 add
      IF SQLCA.sqlcode THEN
#         CALL cl_errmsg('foreach',p_glapdocno,'',sqlca.sqlcode,1)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = p_glapdocno
         LET g_errparam.code   = sqlca.sqlcode
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOREACH
      END IF
#      CALL aglt310_get_glad(p_glapld,l_glaq002) RETURNING l_glad003,l_glad004 #161205-00025#4 mark
      LET l_flag=''
      IF l_glad003='Y' THEN
         IF l_glad004='1' THEN #借方立帳
            IF l_glaq003>0 THEN #細項立帳
               LET l_flag='x' 
            END IF
            IF l_glaq004>0 THEN #細項沖帳
               LET l_flag='y'
               LET l_sum1=l_glaq004 #沖帳金額
            END IF
         ELSE #貸方立賬
            IF l_glaq003>0 THEN #細項沖帳
               LET l_flag='y'
               LET l_sum1=l_glaq003 #沖帳金額
            END IF
            IF l_glaq004>0 THEN #細項立帳
               LET l_flag='x'
            END IF
         END IF
      END IF
      CASE
         WHEN l_flag='x'  #檢查細項立帳資料是否產生
            SELECT COUNT(1) INTO l_cnt FROM glax_t #161205-00025#4 mod '*'-->1
             WHERE glaxent=g_enterprise AND glaxld=p_glapld
               AND glaxdocno=p_glapdocno AND glaxseq=l_glaqseq
               AND glax002=l_glaq002
            IF l_cnt=0 THEN
#               CALL cl_errmsg(l_glaqseq,p_glapdocno,'','agl-00205',1)
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = p_glapdocno
               LET g_errparam.code   = 'agl-00205'
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET r_success = FALSE
            END IF
         WHEN l_flag='y'  #檢查細項沖帳資料是否產生，且產生的總金額是否等於單身金額
            SELECT COUNT(1) INTO l_cnt FROM glay_t #161205-00025#4 mod '*'-->1
             WHERE glayent=g_enterprise AND glayld=p_glapld
               AND glaydocno=p_glapdocno AND glayseq=l_glaqseq
            IF l_cnt>0 THEN           
               #細項沖帳金額
               SELECT SUM(glay003) INTO l_sum FROM glay_t
                WHERE glayent=g_enterprise AND glayld=p_glapld
                  AND glaydocno=p_glapdocno AND glayseq=l_glaqseq
               IF l_sum<>l_sum1 THEN
#                  CALL cl_errmsg(l_glaqseq,p_glapdocno,'','agl-00207',1)
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = p_glapdocno
                  LET g_errparam.code   = 'agl-00207'
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET r_success = FALSE
               END IF
            END IF
      END CASE
   END FOREACH
   RETURN r_success
END FUNCTION
################################################################################
# Descriptions...: 描述说明
# Memo...........: 更新細項立沖帳資料
# Usage..........: CALL aglt310_conf_upd_glax_glay(p_glapld,p_glapdocno)
#                  RETURNING r_success
# Input parameter: p_glapld      帳套
#                : p_glapdocno   傳票編號
# Return code....: r_success     更新結果
# Date & Author..: 14/02/10 By wangrr
# Modify.........:
################################################################################
PRIVATE FUNCTION aglt310_conf_upd_glax_glay(p_glapld,p_glapdocno)
   DEFINE p_glapld           LIKE glap_t.glapld
   DEFINE p_glapdocno        LIKE glap_t.glapdocno
   DEFINE l_glaqseq          LIKE glaq_t.glaqseq
   DEFINE l_glaq002          LIKE glaq_t.glaq002
   DEFINE l_glaq003          LIKE glaq_t.glaq003
   DEFINE l_glaq004          LIKE glaq_t.glaq004
   DEFINE r_success          LIKE type_t.num5
   DEFINE l_flag             LIKE type_t.chr2
   DEFINE l_glay003          LIKE glay_t.glay003
   DEFINE l_glay005          LIKE glay_T.glay005
   DEFINE l_glay008          LIKE glay_t.glay008
   DEFINE l_glay010          LIKE glay_t.glay010
   DEFINE l_glay041          LIKE glay_t.glay041
   DEFINE l_glay042          LIKE glay_t.glay042
   DEFINE l_glay052          LIKE glay_t.glay052
   DEFINE l_glay054          LIKE glay_t.glay054
   DEFINE l_glad003          LIKE glad_t.glad003
   DEFINE l_glad004          LIKE glad_t.glad004
   DEFINE l_glax005          LIKE glax_t.glax005
   DEFINE l_glax006          LIKE glax_t.glax006
   DEFINE l_ooaj004_o        LIKE ooaj_t.ooaj004
   DEFINE l_today            DATETIME YEAR TO SECOND  
   DEFINE l_sql              STRING
   
   LET g_sql = "SELECT UNIQUE glaqseq,glaq002,glaq003,glaq004,glad003,glad004 FROM glaq_t", #161205-00025#4 add glad003,glad004 
               " INNER JOIN glap_t ON glapld = glaqld AND glapent = glaqent ", #170214-00033#1 add ENT
               " AND glapdocno = glaqdocno ",
               " LEFT JOIN glad_t ON gladent=glaqent AND gladld=glaqld AND glad001=glaq002 ", #161205-00025#4 add
               " WHERE glaqent='",g_enterprise,"' ",
               "   AND glaqld='",p_glapld,"' ",
               "   AND glaqdocno='",p_glapdocno,"' ",
               "   AND glad003 = 'Y' ", #161205-00025#4 add
               " ORDER BY glaq_t.glaqseq"
   PREPARE aglt310_glaq_pr1 FROM g_sql
   DECLARE aglt310_glaq_cs1 CURSOR FOR aglt310_glaq_pr1
   
   LET r_success=TRUE
   FOREACH aglt310_glaq_cs1 INTO l_glaqseq,l_glaq002,l_glaq003,l_glaq004
                                ,l_glad003,l_glad004  #161205-00025#4 add
      IF SQLCA.sqlcode THEN
#         CALL cl_errmsg('foreach',p_glapdocno,'',sqlca.sqlcode,1)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = p_glapdocno
         LET g_errparam.code   = sqlca.sqlcode
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOREACH
      END IF
#      CALL aglt310_get_glad(p_glapld,l_glaq002) RETURNING l_glad003,l_glad004 #161205-00025#4 mark
      LET l_flag=''
      IF l_glad003='Y' THEN
         IF l_glad004='1' THEN #借方立帳
            IF l_glaq003>0 THEN #細項立帳
               LET l_flag='ux'  #更新glax_t為審核狀態
            END IF
            IF l_glaq004>0 THEN #細項沖帳
               LET l_flag='xy'  #更新glax_t已沖帳金額以及glay_t狀態為審核
            END IF
         ELSE #貸方立賬
            IF l_glaq003>0 THEN #細項沖帳
               LET l_flag='xy'
            END IF
            IF l_glaq004>0 THEN #細項立帳
               LET l_flag='ux'
            END IF
         END IF
      END IF
      LET l_today = cl_get_current()
      CASE
         WHEN l_flag='ux'   #更新glax_t為已審核狀態
            UPDATE glax_t
               SET glaxstus='Y',
                   glaxcnfid=g_user,
                   glaxcnfdt=l_today
             WHERE glaxent=g_enterprise AND glaxld=p_glapld
               AND glaxdocno=p_glapdocno AND glaxseq=l_glaqseq
               AND glax002=l_glaq002
            IF SQLCA.sqlcode THEN
#               CALL cl_errmsg('upd glax_t','','',SQLCA.sqlcode,1)
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = 'upd glax_t'
               LET g_errparam.code   = SQLCA.sqlcode
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET r_success = FALSE
            END IF
         WHEN l_flag='xy'   #更新glax_t已沖帳金額以及沖帳異動glay_t為已審核狀態
            LET l_sql="SELECT glay003,glay005,glay008,glay010,glay041,glay042,glay052,glay054",
                      "  FROM glay_t",
                      " WHERE glayent=",g_enterprise," AND glayld='",p_glapld,"'",
                      "   AND glaydocno='",p_glapdocno,"' AND glayseq=",l_glaqseq
            PREPARE aglt310_conf_glax_pr FROM l_sql
            DECLARE aglt310_conf_glax_cs CURSOR FOR aglt310_conf_glax_pr
            
            FOREACH aglt310_conf_glax_cs INTO l_glay003,l_glay005,l_glay008,l_glay010,l_glay041,l_glay042,l_glay052,l_glay054
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode 
                  LET g_errparam.extend = 'FOREACH'
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  LET r_success=FALSE
                  EXIT FOREACH
               END IF
               IF cl_null(l_glay003) THEN LET l_glay003=0 END IF
               IF cl_null(l_glay008) THEN LET l_glay008=0 END IF
               IF cl_null(l_glay010) THEN LET l_glay010=0 END IF
               IF cl_null(l_glay052) THEN LET l_glay052=0 END IF
               IF cl_null(l_glay054) THEN LET l_glay054=0 END IF
               
               #當立帳幣別與沖帳幣別不同時，通過本幣金額換算原幣金額   
               SELECT glax005,glax006 INTO l_glax005,l_glax006 FROM glax_t
                WHERE glaxent=g_enterprise AND glaxld=p_glapld
                  AND glaxdocno=l_glay041
                  AND glaxseq=l_glay042
               IF l_glay005<>l_glax005 THEN
                  LET l_glay010=l_glay003/l_glax006
                  #取原幣的金额小數位數
                  CALL s_curr_sel_ooaj004(g_glaa026,l_glax005) RETURNING l_ooaj004_o 
                  CALL s_num_round('1',l_glay010,l_ooaj004_o) RETURNING l_glay010
               END IF
               
               UPDATE glax_t
                  SET glax041=glax041-l_glay003,
                      glax042=glax042+l_glay003,
                      glax043=glax043-l_glay008,
                      glax044=glax044+l_glay008,
                      glax045=glax045-l_glay010,
                      glax046=glax046+l_glay010,
                      glax053=glax053-l_glay052,
                      glax054=glax054+l_glay052,
                      glax057=glax057-l_glay054,
                      glax058=glax058+l_glay054
                WHERE glaxent=g_enterprise AND glaxld=p_glapld
                  AND glaxdocno=l_glay041 AND glaxseq=l_glay042
                
               IF SQLCA.sqlcode THEN
#                  CALL cl_errmsg('upd glax_t','','',SQLCA.sqlcode,1)
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = 'upd glax_t'
                  LET g_errparam.code   = SQLCA.sqlcode
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET r_success = FALSE
               END IF
            END FOREACH
            UPDATE glay_t
               SET glaystus='Y',
                   glaycnfid=g_user,
                   glaycnfdt=l_today
             WHERE glayent=g_enterprise AND glayld=p_glapld
               AND glaydocno=p_glapdocno AND glayseq=l_glaqseq
               AND glay002=l_glaq002
            IF SQLCA.sqlcode  THEN
#               CALL cl_errmsg('upd glay_t','','',SQLCA.sqlcode,1)
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = 'upd glay_t'
               LET g_errparam.code   = SQLCA.sqlcode
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET r_success = FALSE
            END IF
      END CASE
   END FOREACH
   RETURN r_success
END FUNCTION
################################################################################
# Descriptions...: 描述说明
# Memo...........: 取消審核時更新細項立沖帳資料
# Usage..........: CALL aglt310_unconf_upd_glax_glay(p_glapld,p_glapdocno)
#                  RETURNING r_success
# Input parameter: p_glapld      帳套
#                : p_glapdocno   傳票編號
# Return code....: r_success     更新是否成功
# Date & Author..: 14/02/10 By wangrr
# Modify.........:
################################################################################
PRIVATE FUNCTION aglt310_unconf_upd_glax_glay(p_glapld,p_glapdocno)
   DEFINE p_glapld           LIKE glap_t.glapld
   DEFINE p_glapdocno        LIKE glap_t.glapdocno
   DEFINE l_glaqseq          LIKE glaq_t.glaqseq
   DEFINE l_glaq002          LIKE glaq_t.glaq002
   DEFINE l_glaq003          LIKE glaq_t.glaq003
   DEFINE l_glaq004          LIKE glaq_t.glaq004
   DEFINE r_success          LIKE type_t.num5
   DEFINE l_flag             LIKE type_t.chr2
   DEFINE l_glay003          LIKE glay_t.glay003
   DEFINE l_glay005          LIKE glay_t.glay005
   DEFINE l_glay008          LIKE glay_t.glay008
   DEFINE l_glay010          LIKE glay_t.glay010
   DEFINE l_glay041          LIKE glay_t.glay041
   DEFINE l_glay042          LIKE glay_t.glay042
   DEFINE l_glay052          LIKE glay_t.glay052
   DEFINE l_glay054          LIKE glay_t.glay054
   DEFINE l_glad003          LIKE glad_t.glad003
   DEFINE l_glad004          LIKE glad_t.glad004
   DEFINE l_glax005          LIKE glax_t.glax005
   DEFINE l_glax006          LIKE glax_t.glax006
   DEFINE l_ooaj004_o        LIKE ooaj_t.ooaj004
   DEFINE l_sql              STRING
   
   LET g_sql = "SELECT UNIQUE glaqseq,glaq002,glaq003,glaq004,glad003,glad004 FROM glaq_t", #161205-00025#4 add glad003,glad004
               " INNER JOIN glap_t ON glapld = glaqld AND glapent = glaqent ", #170214-00033#1 add ENT
               " AND glapdocno = glaqdocno ",
               " LEFT JOIN glad_t ON gladent=glaqent AND gladld=glaqld AND glad001=glaq002 ", #161205-00025#4 add
               " WHERE glaqent='",g_enterprise,"' ",
               "   AND glaqld='",p_glapld,"' ",
               "   AND glaqdocno='",p_glapdocno,"' ",
               "   AND glad003 = 'Y' ", #161205-00025#4 add
               " ORDER BY glaq_t.glaqseq"
   PREPARE aglt310_glaq_pr2 FROM g_sql
   DECLARE aglt310_glaq_cs2 CURSOR FOR aglt310_glaq_pr2
   
   LET r_success=TRUE
   FOREACH aglt310_glaq_cs2 INTO l_glaqseq,l_glaq002,l_glaq003,l_glaq004
                                ,l_glad003,l_glad004  #161205-00025#4 add
      IF SQLCA.sqlcode THEN
#         CALL cl_errmsg('foreach',p_glapdocno,'',sqlca.sqlcode,1)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = p_glapdocno
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOREACH
      END IF
#      CALL aglt310_get_glad(p_glapld,l_glaq002) RETURNING l_glad003,l_glad004 #161205-00025#4 mark
      LET l_flag=''
      IF l_glad003='Y' THEN
         IF l_glad004='1' THEN #借方立帳
            IF l_glaq003>0 THEN #細項立帳
               LET l_flag='ux'  #更新glax_t為審核狀態
            END IF
            IF l_glaq004>0 THEN #細項沖帳
               LET l_flag='xy'  #更新glax_t已沖帳金額以及glay_t狀態為審核
            END IF
         ELSE #貸方立賬
            IF l_glaq003>0 THEN #細項沖帳
               LET l_flag='xy'
            END IF
            IF l_glaq004>0 THEN #細項立帳
               LET l_flag='ux'
            END IF
         END IF
      END IF
      CASE
         WHEN l_flag='ux'   #更新glax_t為未審核狀態
            UPDATE glax_t
               SET glaxstus='N',
                   glaxcnfid='',
                   glaxcnfdt=''
             WHERE glaxent=g_enterprise AND glaxld=p_glapld
               AND glaxdocno=p_glapdocno AND glaxseq=l_glaqseq
               AND glax002=l_glaq002
            IF SQLCA.sqlcode THEN
#               CALL cl_errmsg('upd glax_t','','',SQLCA.sqlcode,1)
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = 'upd glax_t'
               LET g_errparam.code   = SQLCA.sqlcode
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET r_success = FALSE
            END IF
         WHEN l_flag='xy'    #更新glax_t已沖帳金額以及沖帳異動glay_t為未審核狀態
            LET l_sql="SELECT glay003,glay005,glay008,glay010,glay041,glay042,glay052,glay054",
                      "  FROM glay_t",
                      " WHERE glayent=",g_enterprise," AND glayld='",p_glapld,"'",
                      "   AND glaydocno='",p_glapdocno,"' AND glayseq=",l_glaqseq
            PREPARE aglt310_unconf_glax_pr FROM l_sql
            DECLARE aglt310_unconf_glax_cs CURSOR FOR aglt310_unconf_glax_pr
            
            FOREACH aglt310_unconf_glax_cs INTO l_glay003,l_glay005,l_glay008,l_glay010,l_glay041,l_glay042,l_glay052,l_glay054
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode 
                  LET g_errparam.extend = 'FOREACH'
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  LET r_success=FALSE
                  EXIT FOREACH
               END IF
               IF cl_null(l_glay003) THEN LET l_glay003=0 END IF
               IF cl_null(l_glay008) THEN LET l_glay008=0 END IF
               IF cl_null(l_glay010) THEN LET l_glay010=0 END IF
               IF cl_null(l_glay052) THEN LET l_glay052=0 END IF
               IF cl_null(l_glay054) THEN LET l_glay054=0 END IF
            
               #當立帳幣別與沖帳幣別不同時，通過本幣金額換算原幣金額   
               SELECT glax005,glax006 INTO l_glax005,l_glax006 FROM glax_t
                WHERE glaxent=g_enterprise AND glaxld=p_glapld
                  AND glaxdocno=l_glay041
                  AND glaxseq=l_glay042
               IF l_glay005<>l_glax005 THEN
                  LET l_glay010=l_glay003/l_glax006
                  #取原幣的金额小數位數
                  CALL s_curr_sel_ooaj004(g_glaa026,l_glax005) RETURNING l_ooaj004_o 
                  CALL s_num_round('1',l_glay010,l_ooaj004_o) RETURNING l_glay010
               END IF
               
               UPDATE glax_t
                  SET glax041=glax041+l_glay003,
                      glax042=glax042-l_glay003,
                      glax043=glax043+l_glay008,
                      glax044=glax044-l_glay008,
                      glax045=glax045+l_glay010,
                      glax046=glax046-l_glay010,
                      glax053=glax053+l_glay052,
                      glax054=glax054-l_glay052,
                      glax057=glax057+l_glay054,
                      glax058=glax058-l_glay054
                WHERE glaxent=g_enterprise AND glaxld=p_glapld
                  AND glaxdocno=l_glay041 AND glaxseq=l_glay042
               
               IF SQLCA.sqlcode THEN
#                  CALL cl_errmsg('upd glax_t','','',SQLCA.sqlcode,1)
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = 'upd glax_t'
                  LET g_errparam.code   = SQLCA.sqlcode
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET r_success = FALSE
               END IF
            END FOREACH
            
            UPDATE glay_t
               SET glaystus='N',
                   glaycnfid='',
                   glaycnfdt=''
             WHERE glayent=g_enterprise AND glayld=p_glapld
               AND glaydocno=p_glapdocno AND glayseq=l_glaqseq
               AND glay002=l_glaq002
            IF SQLCA.sqlcode  THEN
#               CALL cl_errmsg('upd glay_t','','',SQLCA.sqlcode,1)
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = 'upd glay_t'
               LET g_errparam.code   = SQLCA.sqlcode
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET r_success = FALSE
            END IF
      END CASE
   END FOREACH
   RETURN r_success
END FUNCTION
################################################################################
# Descriptions...: 描述说明
# Memo...........: 查詢細項立帳否，立帳方
# Usage..........: CALL aglt310_get_glad(p_gladld,p_glad001)
#                  RETURNING r_glad003,r_glad004
# Input parameter: p_gladld   帳套
#                : p_glad001  科目
# Return code....: r_glad003  細項立帳否
#                : r_glad004  立帳方
# Date & Author..: 14/02/13 By wangrr
# Modify.........:
################################################################################
PRIVATE FUNCTION aglt310_get_glad(p_gladld,p_glad001)
   DEFINE p_gladld    LIKE glad_t.gladld
   DEFINE p_glad001   LIKE glad_t.glad001
   DEFINE r_glad003   LIKE glad_t.glad003
   DEFINE r_glad004   LIKE glad_t.glad004
   
   SELECT glad003,glad004 INTO r_glad003,r_glad004
     FROM glad_t
    WHERE gladent=g_enterprise AND gladld=p_gladld
      AND glad001=p_glad001
   LET SQLCA.sqlcode=0
   RETURN r_glad003,r_glad004
END FUNCTION
################################################################################
# Descriptions...: 清空固定核算項/業務訊息
# Memo...........:
# Usage..........: CALL aglt310_frozen_clear(p_type)
# Input parameter: p_type   要清空那個頁簽
#                : 0：清空固定核算項和業務訊息
#                : 1：清空固定核算項
#                : 2：清空業務訊息
# Date & Author..: 14/02/19 By wangrr
# Modify.........:
################################################################################
PRIVATE FUNCTION aglt310_frozen_clear(p_type)
   DEFINE p_type   LIKE type_t.num5
  
   #清空固定核算項
   IF p_type=0 OR p_type=1 THEN
      LET g_glap_m.glaq017 = ''
      LET g_glap_m.glaq017_desc = ''
      LET g_glap_m.glaq018 = ''
      LET g_glap_m.glaq018_desc = ''
      LET g_glap_m.glaq019 = ''
      LET g_glap_m.glaq019_desc = ''
      LET g_glap_m.glaq020 = ''
      LET g_glap_m.glaq020_desc = ''
      LET g_glap_m.glaq021 = ''
      LET g_glap_m.glaq021_desc = ''
      LET g_glap_m.glaq022 = ''
      LET g_glap_m.glaq022_desc = ''
      LET g_glap_m.glaq023 = ''
      LET g_glap_m.glaq023_desc = ''
      LET g_glap_m.glaq024 = ''
      LET g_glap_m.glaq024_desc = ''
      LET g_glap_m.glbc004 = ''
      LET g_glap_m.glbc004_desc = ''
      LET g_glap_m.glaq051 = ''
      LET g_glap_m.glaq052 = ''
      LET g_glap_m.glaq052_desc = ''
      LET g_glap_m.glaq053 = ''
      LET g_glap_m.glaq053_desc = ''
      LET g_glap_m.glaq025 = ''
      LET g_glap_m.glaq025_desc = ''
#      LET g_glap_m.glaq026 = ''
#      LET g_glap_m.glaq026_desc = ''
      LET g_glap_m.glaq027 = ''
      LET g_glap_m.glaq027_desc = ''
      LET g_glap_m.glaq028 = ''
      LET g_glap_m.glaq028_desc = ''
      LET g_glap_m.glaq029 = ''
      LET g_glap_m.glaq029_desc = ''
      LET g_glap_m.glaq030 = ''
      LET g_glap_m.glaq030_desc = ''
      LET g_glap_m.glaq031 = ''
      LET g_glap_m.glaq031_desc = ''
      LET g_glap_m.glaq032 = ''
      LET g_glap_m.glaq032_desc = ''
      LET g_glap_m.glaq033 = ''
      LET g_glap_m.glaq033_desc = ''
      LET g_glap_m.glaq034 = ''
      LET g_glap_m.glaq034_desc = ''
      LET g_glap_m.glaq035 = ''
      LET g_glap_m.glaq035_desc = ''
      LET g_glap_m.glaq036 = ''
      LET g_glap_m.glaq036_desc = ''
      LET g_glap_m.glaq037 = ''
      LET g_glap_m.glaq037_desc = ''
      LET g_glap_m.glaq038 = ''
      LET g_glap_m.glaq038_desc = ''
   END IF
   #清空業務訊息
   IF p_type=0 OR p_type=2 THEN
      LET g_glap_m.glaq005_1 = ''
      LET g_glap_m.glaq006_1 = ''
      LET g_glap_m.glaq007 = ''
      LET g_glap_m.glaq008 = ''
      LET g_glap_m.glaq009 = ''
      LET g_glap_m.glaq010_1 = ''
      LET g_glap_m.glaq011 = ''
      LET g_glap_m.glaq012 = ''
      LET g_glap_m.glaq013 = ''
      LET g_glap_m.glaq013_desc = ''
      LET g_glap_m.glaq014 = ''
      LET g_glap_m.glaq015 = ''
      LET g_glap_m.glaq016 = ''
   END IF
END FUNCTION
################################################################################
# Descriptions...: 刪除細項沖帳資料后更新對應細項立帳預沖金額
# Memo...........:
# Usage..........: CALL aglt310_update_glax(p_glayld,p_glaydocno,p_glayseq)
#                  RETURNING r_success
# Input parameter: p_glayld      帳套
#                : p_glaydocno   帳款編號
#                : p_glayseq     項次
# Return code....: r_success     更新成功否
# Date & Author..: 14/02/19 By wangrr
# Modify.........:
################################################################################
PRIVATE FUNCTION aglt310_update_glax(p_glayld,p_glaydocno,p_glayseq)
   DEFINE p_glayld        LIKE glay_t.glayld
   DEFINE p_glaydocno     LIKE glay_t.glaydocno
   DEFINE p_glayseq       LIKE glay_t.glayseq
   DEFINE l_glay003       LIKE glay_t.glay003
   DEFINE l_glay005       LIKE glay_t.glay005
   DEFINE l_glay008       LIKE glay_t.glay008
   DEFINE l_glay010       LIKE glay_t.glay010
   DEFINE l_glay041       LIKE glay_t.glay041
   DEFINE l_glay042       LIKE glay_t.glay042
   DEFINE l_glay052       LIKE glay_t.glay052
   DEFINE l_glay054       LIKE glay_t.glay054
   DEFINE l_glax005       LIKE glax_t.glax005
   DEFINE l_glax006       LIKE glax_t.glax006
   DEFINE l_ooaj004_o     LIKE ooaj_t.ooaj004
   DEFINE r_success       LIKE type_t.num5
   DEFINE l_sql           STRING
   
   LET l_sql="SELECT glay003,glay005,glay008,glay010,glay041,glay042,glay052,glay054 FROM glay_t ",
             " WHERE glayent='",g_enterprise,"' ",
             "   AND glayld='",p_glayld,"' ",
             "   AND glaydocno='",p_glaydocno,"' "
   IF NOT cl_null(p_glayseq) THEN 
      LET l_sql=l_sql," AND glayseq=",p_glayseq
   END IF
   
   PREPARE aglt310_sel_glay_pr1 FROM l_sql
   DECLARE aglt310_sel_glay_cs1 CURSOR FOR aglt310_sel_glay_pr1
   LET r_success=TRUE
   
   FOREACH aglt310_sel_glay_cs1 INTO l_glay003,l_glay005,l_glay008,l_glay010,l_glay041,l_glay042,l_glay052,l_glay054 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode 
         LET g_errparam.extend = 'FOREACH'
         LET g_errparam.popup = FALSE
         CALL cl_err()

         LET r_success=FALSE
         EXIT FOREACH
      END IF
      
      #當立帳幣別與沖帳幣別不同時，通過本幣金額換算原幣金額   
      SELECT glax005,glax006 INTO l_glax005,l_glax006 FROM glax_t
       WHERE glaxent=g_enterprise AND glaxld=p_glayld
         AND glaxdocno=l_glay041
         AND glaxseq=l_glay042
      IF l_glay005<>l_glax005 THEN
         LET l_glay010=l_glay003/l_glax006
         #取原幣的金额小數位數
         CALL s_curr_sel_ooaj004(g_glaa026,l_glax005) RETURNING l_ooaj004_o 
         CALL s_num_round('1',l_glay010,l_ooaj004_o) RETURNING l_glay010
      END IF
      
      UPDATE glax_t 
         SET glax041=glax041-l_glay003,
             glax043=glax043-l_glay008,
             glax045=glax045-l_glay010,
             glax053=glax053-l_glay052,
             glax057=glax057-l_glay054
       WHERE glaxent=g_enterprise AND glaxld=p_glayld
         AND glaxdocno=l_glay041
         AND glaxseq=l_glay042
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            LET r_success=FALSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "std-00009"
            LET g_errparam.extend = l_glay041
            LET g_errparam.popup = FALSE
            CALL cl_err()

         WHEN SQLCA.sqlcode #其他錯誤
            LET r_success=FALSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = l_glay041
            LET g_errparam.popup = FALSE
            CALL cl_err()

         OTHERWISE
      END CASE
   END FOREACH
   RETURN r_success
END FUNCTION
################################################################################
# Descriptions...: 設置現金變動碼
# Memo...........:
# Usage..........: CALL aglt310_cashflow()
# Date & Author..: 2014/02/28 By wangrr
# Modify.........:
################################################################################
PRIVATE FUNCTION aglt310_cashflow()
   DEFINE l_sum      LIKE glaq_t.glaq003
   DEFINE l_type     LIKE type_t.chr1
   DEFINE l_success  LIKE type_t.num5
   DEFINE l_sum1     LIKE glaq_t.glaq003
   DEFINE l_sum2     LIKE glaq_t.glaq003
   DEFINE l_sum3     LIKE glaq_t.glaq003
   DEFINE l_sum4     LIKE glaq_t.glaq003
   DEFINE l_amt1     LIKE glaq_t.glaq003
   DEFINE l_amt2     LIKE glaq_t.glaq003
   DEFINE l_amt3     LIKE glaq_t.glaq003
   DEFINE l_amt4     LIKE glaq_t.glaq003
   DEFINE l_cnt      LIKE type_t.num5
   
   IF g_glap_m.glapld IS NULL
   OR g_glap_m.glapdocno IS NULL 
   THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()

      RETURN
   END IF
   CALL cl_err_collect_init()
   LET l_success = TRUE
   SELECT glap010,glap011,SUM(glaq003),SUM(glaq004),
          SUM(glaq040),SUM(glaq041),SUM(glaq043),SUM(glaq044)
     INTO l_sum1,l_sum2,l_sum3,l_sum4,
          l_amt1,l_amt2,l_amt3,l_amt4
     FROM glaq_t,glap_t
    WHERE glapent = glaqent
      AND glapld = glaqld
      AND glapdocno = glaqdocno
      AND glaqent = g_enterprise
      AND glaqld = g_glap_m.glapld
      AND glaqdocno = g_glap_m.glapdocno
      GROUP BY glap010,glap011
   IF cl_null(l_sum1) THEN LET l_sum1=0 END IF
   IF cl_null(l_sum2) THEN LET l_sum2=0 END IF
   IF cl_null(l_sum3) THEN LET l_sum3=0 END IF
   IF cl_null(l_sum4) THEN LET l_sum4=0 END IF
   IF cl_null(l_amt1) THEN LET l_amt1=0 END IF
   IF cl_null(l_amt2) THEN LET l_amt2=0 END IF
   IF cl_null(l_amt3) THEN LET l_amt3=0 END IF
   IF cl_null(l_amt4) THEN LET l_amt4=0 END IF
   
   IF l_sum1<>l_sum2 OR l_sum1 <> l_sum3 OR l_sum2 <> l_sum4 THEN
#      CALL cl_errmsg('','',l_sum1,'agl-00050',1)
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = l_sum1
      LET g_errparam.code   = 'agl-00050'
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET l_success = FALSE      
   END IF 
   IF g_glaa015='Y' AND l_amt1<>l_amt2 THEN
#      CALL cl_errmsg('','',l_amt1,'agl-00217',1)
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = l_amt1
      LET g_errparam.code   = 'agl-00217'
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET l_success = FALSE
   END IF
   IF g_glaa019='Y' AND l_amt3<>l_amt4 THEN
#      CALL cl_errmsg('','',l_amt3,'agl-00218',1)
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = l_amt3
      LET g_errparam.code   = 'agl-00218'
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET l_success = FALSE
   END IF
   CALL cl_err_collect_show()
   IF l_success = FALSE THEN
      RETURN
   END IF
#   LET l_sum=0
#   SELECT SUM(glaq003)-SUM(glaq004) INTO l_sum
#     FROM glaq_t LEFT OUTER JOIN glac_t ON (glaqent=glacent AND glaq002=glac002 AND glac001=g_glaa004) 
#    WHERE glaqent=g_enterprise  AND glaqld=g_glap_m.glapld
#      AND glaqdocno=g_glap_m.glapdocno AND glac016='Y'
#   IF cl_null(l_sum) THEN LET l_sum=0 END IF
#   IF l_sum<>0 THEN
#      #結餘在借方出入借貸別為借方‘1’，反之傳入貸方‘2’
#      IF l_sum>0 THEN
#         LET l_type='1' #借余
#      ELSE
#         LET l_type='2' #貸余
#      END IF

   LET l_cnt=0
   SELECT COUNT(1) INTO l_cnt #161205-00025#4 mod '*'-->1
     FROM glaq_t LEFT OUTER JOIN glac_t ON (glaqent=glacent AND glaq002=glac002 AND glac001=g_glaa004) 
    WHERE glaqent=g_enterprise  AND glaqld=g_glap_m.glapld
      AND glaqdocno=g_glap_m.glapdocno AND glac016='Y'
   IF l_cnt > 0 THEN
                      #帳別            #傳票編號          #年度            #期別    
      CALL s_cashflow(g_glap_m.glapld,g_glap_m.glapdocno,g_glap_m.glap002,g_glap_m.glap004)
   ELSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "agl-00280"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()
   END IF
END FUNCTION

################################################################################
# Descriptions...: 會寫前段應收應付單傳票單號為空
# Memo...........:
# Usage..........: CALL aglt310_update_ap_ar()
# Modify.........:
################################################################################
PRIVATE FUNCTION aglt310_update_ap_ar()
   
   CASE g_glap_m.glap007 
      #150907 add ------
      #因為AC類型無法辦別是屬於AR還AP還AFM，所以另外寫一群
      WHEN 'AC'
         IF g_glap_m.glap008 = 'R40' THEN    #重評價axrt920
            UPDATE xreg_t SET xreg005 = NULL
             WHERE xregent = g_enterprise AND xregld = g_glap_m.glapld
               AND xreg005 = g_glap_m.glapdocno
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = "upd xreg_t"
               LET g_errparam.code   = SQLCA.sqlcode
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               RETURN FALSE
            END IF
         END IF
         
         IF g_glap_m.glap008 = 'P40' THEN    #aapt920重評價
            UPDATE xreg_t SET xreg005 = NULL
             WHERE xregent = g_enterprise AND xregld = g_glap_m.glapld
               AND xreg005 = g_glap_m.glapdocno
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = "upd xreg_t"
               LET g_errparam.code   = SQLCA.sqlcode
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               RETURN FALSE
            END IF
         END IF
         
         IF g_glap_m.glap008 = 'M10' THEN   #重評價 afmt570
            UPDATE fmna_t SET fmna005 = NULL
             WHERE fmnaent = g_enterprise AND fmna001 = g_glap_m.glapld
               AND fmna005 = g_glap_m.glapdocno
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = "fmna_t"
               LET g_errparam.code   = SQLCA.sqlcode
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               RETURN FALSE
            END IF
         END IF
      #150907 add end---
      #170113-00042#1--add--str--
         #anmt820=N40 银行调汇
         IF g_glap_m.glap008 = 'N40' THEN
            UPDATE nmde_t SET nmde017 = NULL
             WHERE nmdeent = g_enterprise AND nmdeld = g_glap_m.glapld 
               AND nmde017 = g_glap_m.glapdocno 
            
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "upd nmde_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               
               RETURN FALSE
            END IF
         END IF
      #170113-00042#1--add--end--
      #170117-00064#1--add--str--
         #anmt821=N45 应收票据调汇       #anmt822=N50 应付票据调汇
         IF g_glap_m.glap008 = 'N45' OR g_glap_m.glap008 = 'N50' THEN 
             UPDATE xreg_t SET xreg005 = NULL
             WHERE xregent = g_enterprise AND xregld = g_glap_m.glapld 
               AND xreg005 = g_glap_m.glapdocno 
            
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "upd xreg_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               
               RETURN FALSE
            END IF
         END IF
         
         #aapt940帳齡及壞帳提列
         IF g_glap_m.glap008 = 'P60' THEN    
            UPDATE xrej_t SET xrej005 = NULL
             WHERE xrejent = g_enterprise AND xrejld = g_glap_m.glapld 
               AND xrej005 = g_glap_m.glapdocno 
            
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "upd xrej_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               
               RETURN FALSE
            END IF
         END IF 
         
         #投資期末計量 afmt555
         IF g_glap_m.glap008 = 'M30' THEN
            UPDATE fmmq_t SET fmmq004 = NULL
             WHERE fmmqent = g_enterprise AND fmmq001 = g_glap_m.glapld
               AND fmmq004 = g_glap_m.glapdocno
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = "fmmq_t"
               LET g_errparam.code   = SQLCA.sqlcode
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               RETURN FALSE
            END IF
         END IF
         
         #融資期末計量 afmt190
         IF g_glap_m.glap008 = 'M19' THEN
            UPDATE fmdf_t SET fmdf003 = NULL
             WHERE fmdfent = g_enterprise AND fmdfld = g_glap_m.glapld
               AND fmdf003 = g_glap_m.glapdocno
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = "fmdf_t"
               LET g_errparam.code   = SQLCA.sqlcode
               LET g_errparam.popup  = TRUE
               CALL cl_err()
            
               RETURN FALSE
            END IF
         END IF
      #170117-00064#1--add--end
      WHEN 'AR'
         IF g_glap_m.glap008 = 'R10' THEN    #應收立帳axrt300
            UPDATE xrcb_t SET xrcb025 = NULL,xrcb026 = NULL 
             WHERE xrcbent = g_enterprise AND xrcbld  = g_glap_m.glapld   
               AND xrcb025 = g_glap_m.glapdocno
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "upd xrcb_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               RETURN FALSE
            END IF    
         
            UPDATE xrca_t SET xrca038 = NULL
             WHERE xrcaent = g_enterprise AND xrcald = g_glap_m.glapld
               AND xrca038 = g_glap_m.glapdocno
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "upd xrca_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               RETURN FALSE
            END IF
         END IF
         
         IF g_glap_m.glap008 = 'R20' THEN    #應收立帳axrt400
            UPDATE xrce_t SET xrce029 = NULL,xrce030 = NULL 
             WHERE xrceent = g_enterprise AND xrceld  = g_glap_m.glapld    
               AND xrce029 = g_glap_m.glapdocno
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "upd xrce_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               RETURN FALSE
            END IF
            
            UPDATE xrda_t SET xrda014 = NULL
             WHERE xrdaent = g_enterprise AND xrdald = g_glap_m.glapld 
               AND xrda014 = g_glap_m.glapdocno
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "upd xrda_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               RETURN FALSE
            END IF 
         END IF
         
         IF g_glap_m.glap008 = 'R40' THEN    #重評價axrt920
            UPDATE xreg_t SET xreg005 = NULL
             WHERE xregent = g_enterprise AND xregld = g_glap_m.glapld 
               AND xreg005 = g_glap_m.glapdocno
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "upd xreg_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               RETURN FALSE
            END IF
         END IF
         
         IF g_glap_m.glap008 = 'R50' OR g_glap_m.glap008 = 'R51' THEN    #暫估沖回axrt930/應收暫估重立axrt931
            UPDATE xrem_t SET xrem005 = NULL
             WHERE xrement = g_enterprise AND xremld = g_glap_m.glapld 
               AND xrem005 = g_glap_m.glapdocno
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "upd xrem_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               RETURN FALSE
            END IF
         END IF
         
         IF g_glap_m.glap008 = 'R60' THEN    #帳齡及壞帳提列axrt940
            UPDATE xrej_t SET xrej005 = NULL
             WHERE xrejent = g_enterprise AND xrejld = g_glap_m.glapld 
               AND xrej005 = g_glap_m.glapdocno
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "upd xrej_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               
               RETURN FALSE
            END IF
         END IF 
         
         #151008-00009#4 --s add
         #增加 axrt470段落
         IF g_glap_m.glap008 = 'R70' THEN
            UPDATE xrep_t SET xrep004 = NULL
             WHERE xrepent = g_enterprise AND xrepld = g_glap_m.glapld
               AND xrep004 = g_glap_m.glapdocno
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = "xrep_t"
               LET g_errparam.code   = SQLCA.sqlcode
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               RETURN FALSE
            END IF
         END IF
         #151008-00009#4 --e add
      
      WHEN 'AP'
         IF g_glap_m.glap008 = 'P10' THEN    #aapt300應付立帳
            UPDATE apcb_t SET apcb025 = NULL,apcb026 = NULL 
             WHERE apcbent = g_enterprise AND apcbld = g_glap_m.glapld   
               AND apcb025 = g_glap_m.glapdocno  
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "upd apcb_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               
               RETURN FALSE
            END IF 
            
            UPDATE apce_t SET apce029 = NULL,apce030 = NULL 
             WHERE apceent = g_enterprise AND apceld  = g_glap_m.glapld   
               AND apce029 = g_glap_m.glapdocno 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "upd apce_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               
               RETURN FALSE
            END IF 
            
            UPDATE apca_t SET apca038 = NULL
             WHERE apcaent = g_enterprise AND apcald = g_glap_m.glapld 
               AND apca038 = g_glap_m.glapdocno 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "upd apca_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               
               RETURN FALSE
            END IF
         END IF
      
         IF g_glap_m.glap008 = 'P20' OR g_glap_m.glap008 = 'P30' THEN    #aapt400請款單、aapt420核銷單、aapt430費用分攤單
            UPDATE apce_t SET apce029 = NULL,apce030 = NULL 
             WHERE apceent = g_enterprise AND apceld  = g_glap_m.glapld    
               AND apce029 = g_glap_m.glapdocno
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "upd apce_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               
               RETURN FALSE
            END IF
            
            UPDATE apda_t SET apda014 = NULL
             WHERE apdaent = g_enterprise AND apdald = g_glap_m.glapld
               AND apda014 = g_glap_m.glapdocno 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "upd apce_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               
               RETURN FALSE
            END IF 
         END IF
         
         IF g_glap_m.glap008 = 'P40' THEN    #aapt920重評價
            UPDATE xreg_t SET xreg005 = NULL
             WHERE xregent = g_enterprise AND xregld = g_glap_m.glapld 
               AND xreg005 = g_glap_m.glapdocno 
            
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "upd xreg_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               
               RETURN FALSE
            END IF
         END IF  
         
         IF g_glap_m.glap008 = 'P50' OR g_glap_m.glap008 = 'P51' THEN    #aapt930/aapt931暫估沖回
            UPDATE xrem_t SET xrem005 = NULL
             WHERE xrement = g_enterprise AND xremld = g_glap_m.glapld 
               AND xrem005 = g_glap_m.glapdocno 
            
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "upd xrem_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               
               RETURN FALSE
            END IF
         END IF
         
         IF g_glap_m.glap008 = 'P60' THEN    #aapt940帳齡及壞帳提列
            UPDATE xrej_t SET xrej005 = NULL
             WHERE xrejent = g_enterprise AND xrejld = g_glap_m.glapld 
               AND xrej005 = g_glap_m.glapdocno 
            
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "upd xrej_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               
               RETURN FALSE
            END IF
         END IF 
         
      WHEN 'NM'
         #anmt311=N10 资金存提
         #anmt470=N20 应付票据
         #anmt530=N30 应收票据
         IF g_glap_m.glap008 = 'N10' OR g_glap_m.glap008 = 'N20' OR g_glap_m.glap008 = 'N30' THEN
            UPDATE nmbs_t SET nmbs003 = NULL,nmbs004=NULL
             WHERE nmbsent = g_enterprise AND nmbsld = g_glap_m.glapld 
               AND nmbs003 = g_glap_m.glapdocno 
            
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "upd nmbs_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               
               RETURN FALSE
            END IF
         END IF
         #anmt820=N40 银行调汇
         IF g_glap_m.glap008 = 'N40' THEN
            UPDATE nmde_t SET nmde017 = NULL
             WHERE nmdeent = g_enterprise AND nmdeld = g_glap_m.glapld 
               AND nmde017 = g_glap_m.glapdocno 
            
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "upd nmde_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               
               RETURN FALSE
            END IF
         END IF
         #anmt821=N45 应收票据调汇       #anmt822=N50 应付票据调汇
         IF g_glap_m.glap008 = 'N45' OR g_glap_m.glap008 = 'N50' THEN #151204-00010#1 add ‘N50’
             UPDATE xreg_t SET xreg005 = NULL
             WHERE xregent = g_enterprise AND xregld = g_glap_m.glapld 
               AND xreg005 = g_glap_m.glapdocno 
            
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "upd xreg_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               
               RETURN FALSE
            END IF
         END IF
         
      WHEN 'FA'
         #afat509=F30
         #afat500=F10
         #afat504=F40
         #afat506=F50
         #afat503=F50
         #afat502=F50
         #afat507=F50
            
         UPDATE fabg_t SET fabg008 = NULL,fabg009=NULL
          WHERE fabgent = g_enterprise AND fabgld = g_glap_m.glapld
            AND fabg008 = g_glap_m.glapdocno 
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "fabh_t" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            
            RETURN FALSE
         END IF                    
      WHEN 'XC'
         UPDATE xcea_t SET xcea101 = NULL,xcea102=NULL
          WHERE xceaent = g_enterprise AND xceald = g_glap_m.glapld
            AND xcea101 = g_glap_m.glapdocno
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = "xcea_t"
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()

            RETURN FALSE
         END IF
      WHEN 'GL'
         IF g_glap_m.glap008 = 'TH' THEN
            UPDATE glce_t SET glce005 = NULL
             WHERE glceent = g_enterprise AND glceld = g_glap_m.glapld
               AND glce005 = g_glap_m.glapdocno
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = "glce_t"
               LET g_errparam.code   = SQLCA.sqlcode
               LET g_errparam.popup  = TRUE
               CALL cl_err()
            
               RETURN FALSE
            END IF
         END IF
      
      #150429-00010#14 add ------
      WHEN 'FM'
         #重評價 afmt570
         IF g_glap_m.glap008 = 'M10' THEN
            UPDATE fmna_t SET fmna005 = NULL
             WHERE fmnaent = g_enterprise AND fmna001 = g_glap_m.glapld
               AND fmna005 = g_glap_m.glapdocno
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = "fmna_t"
               LET g_errparam.code   = SQLCA.sqlcode
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               RETURN FALSE
            END IF
         END IF
         #投資購買 afmt535
         IF g_glap_m.glap008 = 'M20' THEN
            UPDATE fmml_t SET fmml007 = NULL
             WHERE fmmlent = g_enterprise AND fmml003 = g_glap_m.glapld
               AND fmml007 = g_glap_m.glapdocno
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = "fmml_t"
               LET g_errparam.code   = SQLCA.sqlcode
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               RETURN FALSE
            END IF
         END IF
         #投資期末計量 afmt555
         IF g_glap_m.glap008 = 'M30' THEN
            UPDATE fmmq_t SET fmmq004 = NULL
             WHERE fmmqent = g_enterprise AND fmmq001 = g_glap_m.glapld
               AND fmmq004 = g_glap_m.glapdocno
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = "fmmq_t"
               LET g_errparam.code   = SQLCA.sqlcode
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               RETURN FALSE
            END IF
         END IF
         #投資計提收益 afmt565
         IF g_glap_m.glap008 = 'M40' THEN
            UPDATE fmmu_t SET fmmu004 = NULL
             WHERE fmmuent = g_enterprise AND fmmu001 = g_glap_m.glapld
               AND fmmu004 = g_glap_m.glapdocno
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = "fmmu_t"
               LET g_errparam.code   = SQLCA.sqlcode
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               RETURN FALSE
            END IF
         END IF
         #投資收息 afmt585
         IF g_glap_m.glap008 = 'M50' THEN
            UPDATE fmmw_t SET fmmw004 = NULL
             WHERE fmmwent = g_enterprise AND fmmw001 = g_glap_m.glapld
               AND fmmw004 = g_glap_m.glapdocno
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = "fmmw_t"
               LET g_errparam.code   = SQLCA.sqlcode
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               RETURN FALSE
            END IF
         END IF
         #投資平倉 afmt595
         IF g_glap_m.glap008 = 'M60' THEN
            UPDATE fmne_t SET fmne004 = NULL
             WHERE fmneent = g_enterprise AND fmne001 = g_glap_m.glapld
               AND fmne004= g_glap_m.glapdocno
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = "fmne_t"
               LET g_errparam.code   = SQLCA.sqlcode
               LET g_errparam.popup  = TRUE
               CALL cl_err()
            
               RETURN FALSE
            END IF
         END IF
      #150429-00010#14 add end---
      #160318-00012#1 add str---
         #afmt145/afmt175/afmt185
         IF g_glap_m.glap008 = 'M14' OR g_glap_m.glap008 = 'M17' OR g_glap_m.glap008 = 'M18' THEN
            UPDATE fmct_t SET fmct002 = NULL,
                              fmct003 = NULL
             WHERE fmctent = g_enterprise AND fmctld = g_glap_m.glapld
               AND fmct002 = g_glap_m.glapdocno
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = "fmct_t"
               LET g_errparam.code   = SQLCA.sqlcode
               LET g_errparam.popup  = TRUE
               CALL cl_err()
            
               RETURN FALSE
            END IF
         END IF
      #160318-00012#1 add end---
      #140702-00001#19 Add  ---(S)---
         IF g_glap_m.glap008 = 'M19' THEN
            UPDATE fmdf_t SET fmdf003 = NULL
             WHERE fmdfent = g_enterprise AND fmdfld = g_glap_m.glapld
               AND fmdf003 = g_glap_m.glapdocno
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = "fmdf_t"
               LET g_errparam.code   = SQLCA.sqlcode
               LET g_errparam.popup  = TRUE
               CALL cl_err()
            
               RETURN FALSE
            END IF
         END IF
      #140702-00001#19 Add  ---(E)---
   END CASE
   #當子模組啟用分錄底稿時，更新分錄底稿中的傳票編號
   IF g_glaa121 = 'Y' THEN
      UPDATE glga_t SET glga007 = NULL,glga008 = NULL
       WHERE glgaent = g_enterprise AND glgald = g_glap_m.glapld
         AND glga007 = g_glap_m.glapdocno AND glga008 = g_glap_m.glapdocdt
   END IF
   RETURN TRUE 
END FUNCTION

################################################################################
# Descriptions...: 抓取渠道說明
# Memo...........:
# Usage..........: CALL aglt310_glaq052_desc(p_glaq052)
#                  RETURNING r_desc
# Input parameter: p_glaq052      渠道編號
# Date & Author..: 2014/10/11 By wangrr
# Modify.........:
################################################################################
PRIVATE FUNCTION aglt310_glaq052_desc(p_glaq052)
   DEFINE p_glaq052    LIKE glaq_t.glaq052

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_glaq052
   CALL ap_ref_array2(g_ref_fields,"SELECT oojdl004 FROM oojdl_t WHERE oojdlent='"||g_enterprise||"' AND oojdl001=? AND oojdl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   RETURN  g_rtn_fields[1]
END FUNCTION

################################################################################
# Descriptions...: 檢查科目核算項錄入正確否
# Memo...........:
# Usage..........: CALL aglt310_subject_fix_chk()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION aglt310_subject_fix_chk()
  #161128-00061#1----modify------begin-----------
  #DEFINE l_glaq          RECORD LIKE glaq_t.*
   DEFINE l_glaq RECORD  #傳票憑證單身檔
       glaqent LIKE glaq_t.glaqent, #企業編號
       glaqcomp LIKE glaq_t.glaqcomp, #法人
       glaqld LIKE glaq_t.glaqld, #帳套
       glaqdocno LIKE glaq_t.glaqdocno, #單號
       glaqseq LIKE glaq_t.glaqseq, #項次
       glaq001 LIKE glaq_t.glaq001, #摘要
       glaq002 LIKE glaq_t.glaq002, #科目編號
       glaq003 LIKE glaq_t.glaq003, #借方金額
       glaq004 LIKE glaq_t.glaq004, #貸方金額
       glaq005 LIKE glaq_t.glaq005, #交易幣別
       glaq006 LIKE glaq_t.glaq006, #匯率
       glaq007 LIKE glaq_t.glaq007, #計價單位
       glaq008 LIKE glaq_t.glaq008, #數量
       glaq009 LIKE glaq_t.glaq009, #單價
       glaq010 LIKE glaq_t.glaq010, #原幣金額
       glaq011 LIKE glaq_t.glaq011, #票據編碼
       glaq012 LIKE glaq_t.glaq012, #票據日期
       glaq013 LIKE glaq_t.glaq013, #申請人
       glaq014 LIKE glaq_t.glaq014, #銀行帳號
       glaq015 LIKE glaq_t.glaq015, #款別編號
       glaq016 LIKE glaq_t.glaq016, #收支專案
       glaq017 LIKE glaq_t.glaq017, #營運據點
       glaq018 LIKE glaq_t.glaq018, #部門
       glaq019 LIKE glaq_t.glaq019, #利潤/成本中心
       glaq020 LIKE glaq_t.glaq020, #區域
       glaq021 LIKE glaq_t.glaq021, #收付款客商
       glaq022 LIKE glaq_t.glaq022, #帳款客戶
       glaq023 LIKE glaq_t.glaq023, #客群
       glaq024 LIKE glaq_t.glaq024, #產品類別
       glaq025 LIKE glaq_t.glaq025, #人員
       glaq026 LIKE glaq_t.glaq026, #no use
       glaq027 LIKE glaq_t.glaq027, #專案編號
       glaq028 LIKE glaq_t.glaq028, #WBS
       glaq029 LIKE glaq_t.glaq029, #自由核算項一
       glaq030 LIKE glaq_t.glaq030, #自由核算項二
       glaq031 LIKE glaq_t.glaq031, #自由核算項三
       glaq032 LIKE glaq_t.glaq032, #自由核算項四
       glaq033 LIKE glaq_t.glaq033, #自由核算項五
       glaq034 LIKE glaq_t.glaq034, #自由核算項六
       glaq035 LIKE glaq_t.glaq035, #自由核算項七
       glaq036 LIKE glaq_t.glaq036, #自由核算項八
       glaq037 LIKE glaq_t.glaq037, #自由核算項九
       glaq038 LIKE glaq_t.glaq038, #自由核算項十
       glaq039 LIKE glaq_t.glaq039, #匯率(本位幣二)
       glaq040 LIKE glaq_t.glaq040, #借方金額(本位幣二)
       glaq041 LIKE glaq_t.glaq041, #貸方金額(本位幣二)
       glaq042 LIKE glaq_t.glaq042, #匯率(本位幣三)
       glaq043 LIKE glaq_t.glaq043, #借方金額(本位幣三)
       glaq044 LIKE glaq_t.glaq044, #貸方金額(本位幣三)
       glaq051 LIKE glaq_t.glaq051, #經營方式
       glaq052 LIKE glaq_t.glaq052, #渠道
       glaq053 LIKE glaq_t.glaq053  #品牌
        END RECORD 
  #161128-00061#1----modify------begin-----------
   DEFINE l_glaqseq       LIKE glaq_t.glaqseq     #項次
   DEFINE l_glaq002       LIKE glaq_t.glaq002     #单身科目
   DEFINE l_glaq003       LIKE glaq_t.glaq003
   DEFINE l_glaq004       LIKE glaq_t.glaq004
   DEFINE l_sql           STRING
   DEFINE l_msg           STRING
   DEFINE l_msg1          STRING
   DEFINE l_errmsg        STRING
   DEFINE l_success       LIKE type_t.num5
   DEFINE r_success       LIKE type_t.num5
   #固定核算项（agli030）
   DEFINE l_glad007       LIKE glad_t.glad007     #部門管理否
   DEFINE l_glad008       LIKE glad_t.glad008     #利潤成本中心管理
   DEFINE l_glad009       LIKE glad_t.glad009     #區域管理
   DEFINE l_glad010       LIKE glad_t.glad010     #交易客商管理
   DEFINE l_glad027       LIKE glad_t.glad027     #账款客商管理
   DEFINE l_glad011       LIKE glad_t.glad011     #客群管理否
   DEFINE l_glad012       LIKE glad_t.glad012     #產品類別
   DEFINE l_glad013       LIKE glad_t.glad013     #人員
   DEFINE l_glad015       LIKE glad_t.glad015     #专案管理否
   DEFINE l_glad016       LIKE glad_t.glad016     #wbs管理
   DEFINE l_glad031       LIKE glad_t.glad031     #經營方式管理否
   DEFINE l_glad032       LIKE glad_t.glad032     #渠道管理否
   DEFINE l_glad033       LIKE glad_t.glad033     #品牌管理否
   #是否做自由科目核算项管理
   DEFINE l_glad017       LIKE glad_t.glad017
   DEFINE l_glad0171      LIKE glad_t.glad0171 
   DEFINE l_glad0172      LIKE glad_t.glad0172 
   DEFINE l_glad018       LIKE glad_t.glad018
   DEFINE l_glad0181      LIKE glad_t.glad0181
   DEFINE l_glad0182      LIKE glad_t.glad0182
   DEFINE l_glad019       LIKE glad_t.glad019
   DEFINE l_glad0191      LIKE glad_t.glad0191
   DEFINE l_glad0192      LIKE glad_t.glad0192
   DEFINE l_glad020       LIKE glad_t.glad020
   DEFINE l_glad0201      LIKE glad_t.glad0201
   DEFINE l_glad0202      LIKE glad_t.glad0202
   DEFINE l_glad021       LIKE glad_t.glad021
   DEFINE l_glad0211      LIKE glad_t.glad0211
   DEFINE l_glad0212      LIKE glad_t.glad0212
   DEFINE l_glad022       LIKE glad_t.glad022
   DEFINE l_glad0221      LIKE glad_t.glad0221
   DEFINE l_glad0222      LIKE glad_t.glad0222
   DEFINE l_glad023       LIKE glad_t.glad023
   DEFINE l_glad0231      LIKE glad_t.glad0231
   DEFINE l_glad0232      LIKE glad_t.glad0232
   DEFINE l_glad024       LIKE glad_t.glad024
   DEFINE l_glad0241      LIKE glad_t.glad0241
   DEFINE l_glad0242      LIKE glad_t.glad0242
   DEFINE l_glad025       LIKE glad_t.glad025
   DEFINE l_glad0251      LIKE glad_t.glad0251
   DEFINE l_glad0252      LIKE glad_t.glad0252
   DEFINE l_glad026       LIKE glad_t.glad026
   DEFINE l_glad0261      LIKE glad_t.glad0261
   DEFINE l_glad0262      LIKE glad_t.glad0262
   DEFINE l_errno         LIKE type_t.chr10
   DEFINE l_desc          LIKE type_t.chr80     #接受s_get_orga返回值
   DEFINE l_date          LIKE ooed_t.ooed006   #接受s_get_orga返回值
   DEFINE l_glaq002_o     LIKE glaq_t.glaq002   #161205-00025#4 add
   DEFINE l_glaq005_o     LIKE glaq_t.glaq005   #161205-00025#4 add
   DEFINE l_glaq017_o     LIKE glaq_t.glaq017   #161205-00025#4 add
   
   #单身錄入完檢查
   #業務信息頁籤的欄位,若有輸入值,應檢查其對應基本資料的合理性
   #固定核算項及自由核算的欄位,應檢查若科目有啟用該核算項時,其對應基本資料的合理性 
   CALL cl_err_collect_init()
   LET l_success=TRUE 
   LET l_glaq002 = ''
   LET l_sql = " SELECT glaqseq,glaq002,glaq003,glaq004,",
               "        glaq005,glaq006,glaq007,glaq008,glaq009,glaq010,",
               "        glaq011,glaq012,glaq013,glaq014,glaq015,glaq016,",
               "        glaq017,glaq018,glaq019,glaq020,glaq021,glaq022,",
               "        glaq023,glaq024,glaq025,glaq027,glaq028,",
               "        glaq029,glaq030,glaq031,glaq032,glaq033,glaq034,",
               "        glaq035,glaq036,glaq037,glaq038,glaq051,glaq052,glaq053 ",
               #161205-00025#4--add--str--
               "       ,glad007,glad008,glad009,glad010,glad027,glad011,",
               "        glad012,glad013,glad015,glad016,glad031,glad032,glad033, ", 
               "        glad017,glad0171,glad0172,glad018,glad0181,glad0182,glad019,glad0191,glad0192,",
               "        glad020,glad0201,glad0202,glad021,glad0211,glad0212,glad022,glad0221,glad0222,",
               "        glad023,glad0231,glad0232,glad024,glad0241,glad0242,glad025,glad0251,glad0252,",
               "        glad026,glad0261,glad0262",
               #161205-00025#4--add--end
               "  FROM glaq_t ",
               "  LEFT JOIN glad_t ON gladent=glaqent AND gladld=glaqld AND glad001=glaq002 ", #161205-00025#4 add
               " WHERE glaqent = '",g_enterprise,"'",
               "   AND glaqld = '",g_glap_m.glapld,"'",
               "   AND glaqdocno = '",g_glap_m.glapdocno,"'"
              ," ORDER BY glaq002,glaq005,glaq017 " #161205-00025#4 add
   PREPARE s_voucher_pre1 FROM l_sql
   DECLARE s_voucher_cur1 CURSOR FOR s_voucher_pre1
   
   LET l_glaq002_o = '' #161205-00025#4 add
   LET l_glaq005_o = '' #161205-00025#4 add
   LET l_glaq017_o = '' #161205-00025#4 add
   
   FOREACH s_voucher_cur1 INTO l_glaqseq,l_glaq002,l_glaq003,l_glaq004,
                               l_glaq.glaq005,l_glaq.glaq006,l_glaq.glaq007,l_glaq.glaq008,l_glaq.glaq009,l_glaq.glaq010,
                               l_glaq.glaq011,l_glaq.glaq012,l_glaq.glaq013,l_glaq.glaq014,l_glaq.glaq015,l_glaq.glaq016,
                               l_glaq.glaq017,l_glaq.glaq018,l_glaq.glaq019,l_glaq.glaq020,l_glaq.glaq021,l_glaq.glaq022,
                               l_glaq.glaq023,l_glaq.glaq024,l_glaq.glaq025,l_glaq.glaq027,l_glaq.glaq028,
                               l_glaq.glaq029,l_glaq.glaq030,l_glaq.glaq031,l_glaq.glaq032,l_glaq.glaq033,l_glaq.glaq034,
                               l_glaq.glaq035,l_glaq.glaq036,l_glaq.glaq037,l_glaq.glaq038,
                               l_glaq.glaq051,l_glaq.glaq052,l_glaq.glaq053   
                               #161205-00025#4--add--str--
                              ,l_glad007,l_glad008,l_glad009,l_glad010,l_glad027,l_glad011,
                               l_glad012,l_glad013,l_glad015,l_glad016,l_glad031,l_glad032,l_glad033,
                               l_glad017,l_glad0171,l_glad0172,l_glad018,l_glad0181,l_glad0182,l_glad019,l_glad0191,l_glad0192,
                               l_glad020,l_glad0201,l_glad0202,l_glad021,l_glad0211,l_glad0212,l_glad022,l_glad0221,l_glad0222,
                               l_glad023,l_glad0231,l_glad0232,l_glad024,l_glad0241,l_glad0242,l_glad025,l_glad0251,l_glad0252,
                               l_glad026,l_glad0261,l_glad0262
                               #161205-00025#4--add--end 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = 'foreach:'
          LET g_errparam.popup = TRUE
          CALL cl_err()
          LET l_success=FALSE
          EXIT FOREACH
       END IF
       #组合报错信息
       LET l_msg = g_glap_m.glapdocno||'/'||l_glaqseq
       LET l_msg1 = g_glap_m.glapdocno||'/'||l_glaqseq||'/'||l_glaq002
       #科目
       IF NOT cl_null(l_glaq002) THEN
          IF cl_null(l_glaq002_o) OR l_glaq002_o <> l_glaq002 THEN #161205-00025#4 add
             CALL s_voucher_glaq002_chk(g_glap_m.glapld,l_glaq002)
             IF NOT cl_null(g_errno) THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.extend = l_msg1
                LET g_errparam.code   = g_errno
                #160321-00016#30 --s add
                LET g_errparam.replace[1] = 'agli030'
                LET g_errparam.replace[2] = cl_get_progname('agli030',g_lang,"2")
                LET g_errparam.exeprog = 'agli030'
                #160321-00016#30 --e add
                LET g_errparam.popup  = TRUE 
                CALL cl_err()
                LET l_success = FALSE
             END IF 
             LET l_glaq002_o = l_glaq002 #161205-00025#4 add 
          END IF #161205-00025#4 add    
       END IF
       #金額
       IF cl_null(l_glaq003) THEN LET l_glaq003 = 0 END IF
       IF cl_null(l_glaq004) THEN LET l_glaq004 = 0 END IF
       IF l_glaq003 = 0 AND l_glaq004 = 0 THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = 'agl-00084'
          LET g_errparam.extend = l_msg
          LET g_errparam.popup = FALSE
          CALL cl_err()
          LET l_success = FALSE
       END IF
       #============================       
       #业务咨询检查
       #============================
       #币种
       IF NOT cl_null(l_glaq.glaq005) THEN 
          IF cl_null(l_glaq005_o) OR l_glaq005_o <> l_glaq.glaq005 THEN #161205-00025#4 add
             CALL aglt310_glaq005_chk(l_glaq.glaq005)
             IF NOT cl_null(g_errno) THEN
                LET l_errmsg = l_msg||'/'||l_glaq.glaq005
                INITIALIZE g_errparam TO NULL
                LET g_errparam.extend = l_errmsg
                LET g_errparam.code   = g_errno
                #160318-00005#17  --add--str
                LET g_errparam.replace[1] ='aooi140'
                LET g_errparam.replace[2] = cl_get_progname('aooi140',g_lang,"2")
                LET g_errparam.exeprog    ='aooi140'
                #160318-00005#17 --add--end
                LET g_errparam.popup  = TRUE 
                CALL cl_err()
                LET l_success = FALSE
             END IF 
             LET l_glaq005_o = l_glaq.glaq005 #161205-00025#4 add 
          END IF #161205-00025#4 add
       END IF 
       #汇率
        IF NOT cl_null(l_glaq.glaq006) THEN 
           IF l_glaq.glaq006 <= 0 THEN             #161130-00019#1 mod  l_glaq.glaq006 <0 ->  l_glaq.glaq006 <= 0
             LET l_errmsg = l_msg||'/'||l_glaq.glaq006
             INITIALIZE g_errparam TO NULL
             LET g_errparam.extend = l_errmsg
             LET g_errparam.code   = 'asf-00155'   #161130-00019#1 mod  aim-00009 -> asf-00155
             LET g_errparam.popup  = TRUE 
             CALL cl_err()
             LET l_success = FALSE
          END IF 
        END IF 
       
       #计价单位
       IF NOT cl_null(l_glaq.glaq007) THEN 
          CALL aglt310_glaq007_chk(l_glaq.glaq007)
          IF NOT cl_null(g_errno) THEN
             LET l_errmsg = l_msg||'/'||l_glaq.glaq007
             INITIALIZE g_errparam TO NULL
             LET g_errparam.extend = l_errmsg
             LET g_errparam.code   = g_errno
             #160318-00005#17  --add--str
             LET g_errparam.replace[1] ='aooi250'
             LET g_errparam.replace[2] = cl_get_progname('aooi250',g_lang,"2")
             LET g_errparam.exeprog    ='aooi250'
             #160318-00005#17 --add--end
             LET g_errparam.popup  = TRUE 
             CALL cl_err()
             LET l_success = FALSE
          END IF 
       END IF 
       
       #数量
       IF NOT cl_null(l_glaq.glaq008) THEN
           IF l_glaq.glaq008 < 0 THEN
             LET l_errmsg = l_msg||'/'||l_glaq.glaq008
             INITIALIZE g_errparam TO NULL
             LET g_errparam.extend = l_errmsg
             LET g_errparam.code   = 'aim-00009'
             LET g_errparam.popup  = TRUE 
             CALL cl_err()
             LET l_success = FALSE
          END IF 
       END IF 
       #单价
       IF NOT cl_null(l_glaq.glaq009) THEN
          IF l_glaq.glaq009 < 0 THEN
             LET l_errmsg = l_msg||'/'||l_glaq.glaq009
             INITIALIZE g_errparam TO NULL
             LET g_errparam.extend = l_errmsg
             LET g_errparam.code   = 'aim-00009'
             LET g_errparam.popup  = TRUE 
             CALL cl_err()
             LET l_success = FALSE
          END IF 
        END IF 
        
       #申请人
       IF NOT cl_null(l_glaq.glaq013) THEN 
          CALL s_voucher_glaq013_chk(l_glaq.glaq013)
          IF NOT cl_null(g_errno) THEN
             LET l_errmsg = l_msg||'/'||l_glaq.glaq013
             INITIALIZE g_errparam TO NULL
             LET g_errparam.extend = l_errmsg
             LET g_errparam.code   = g_errno
             #160321-00016#30 --s add
             LET g_errparam.replace[1] = 'aooi130'
             LET g_errparam.replace[2] = cl_get_progname('aooi130',g_lang,"2")
             LET g_errparam.exeprog = 'aooi130'
             #160321-00016#30 --e add
             LET g_errparam.popup  = TRUE 
             CALL cl_err()
             LET l_success = FALSE
          END IF 
       END IF
       #营运据点检查   
       IF NOT cl_null(l_glaq.glaq017) THEN
          IF cl_null(l_glaq017_o) OR l_glaq017_o <> l_glaq.glaq017 THEN #161205-00025#4 add
             CALL s_voucher_glaq017_chk(l_glaq.glaq017)
             IF NOT cl_null(g_errno) THEN
                LET l_errmsg = l_msg||'/'||l_glaq.glaq017
                INITIALIZE g_errparam TO NULL
                LET g_errparam.extend = l_errmsg
                LET g_errparam.code   = g_errno
                #160321-00016#30 --s add
                LET g_errparam.replace[1] = 'aooi100'
                LET g_errparam.replace[2] = cl_get_progname('aooi100',g_lang,"2")
                LET g_errparam.exeprog = 'aooi100'
                #160321-00016#30 --e add
                LET g_errparam.popup  = TRUE 
                CALL cl_err()
                LET l_success = FALSE
             END IF
             LET l_glaq017_o = l_glaq.glaq017 #161205-00025#4 add
          END IF #161205-00025#4 add
       ELSE
          LET l_success = FALSE
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = l_msg1
          LET g_errparam.code   = 'agl-00291'
          LET g_errparam.popup  = TRUE 
          CALL cl_err()
       END IF
       ################################################################################################
       #依據帳別，科目編號，判斷該科目是否启用
       #部門管理， 利潤成本中心管理，區域管理，交易客商管理，客群管理，產品類別，人員，預算，專案，wbs管理，账款客商管理，自由核算项1~10
#161205-00025#4--mark--str--
#       #1.清空核算项管理值
#       LET l_glad007 = ''  LET l_glad008 = ''  LET l_glad009 = ''  LET l_glad010 = ''  LET l_glad027 = ''   LET l_glad011 = ''
#       LET l_glad012 = ''  LET l_glad013 = ''  LET l_glad015 = ''  LET l_glad016 = ''  LET l_glad031 = ''   LET l_glad032 = ''  LET l_glad033 = ''   
#       LET l_glad017 = ''  LET l_glad0171 =''  LET l_glad0172 = '' LET l_glad018 = ''  LET l_glad0181 = ''  LET l_glad0182 = ''   
#       LET l_glad019 = ''  LET l_glad0191 =''  LET l_glad0192 = '' LET l_glad020 = ''  LET l_glad0201 = ''  LET l_glad0202 = ''
#       LET l_glad021 = ''  LET l_glad0211 =''  LET l_glad0212 = '' LET l_glad022 = ''  LET l_glad0221 = ''  LET l_glad0222 = ''
#       LET l_glad023 = ''  LET l_glad0231 =''  LET l_glad0232 = '' LET l_glad024 = ''  LET l_glad0241 = ''  LET l_glad0242 = ''
#       LET l_glad025 = ''  LET l_glad0251 =''  LET l_glad0252 = '' LET l_glad026 = ''  LET l_glad0261 = ''  LET l_glad0262 = ''
#       #2.重新依账套，科目抓取核算项管理值(细部核算项)
#       CALL s_voucher_fix_acc_open_chk(g_glap_m.glapld,l_glaq002)
#       RETURNING l_glad007,l_glad008,l_glad009,l_glad010,l_glad027,l_glad011,l_glad012,l_glad013,l_glad015,l_glad016,l_glad031,l_glad032,l_glad033
#       
#       #自由核算项
#       SELECT glad017,glad0171,glad0172,glad018,glad0181,glad0182,glad019,glad0191,glad0192,
#              glad020,glad0201,glad0202,glad021,glad0211,glad0212,glad022,glad0221,glad0222,
#              glad023,glad0231,glad0232,glad024,glad0241,glad0242,glad025,glad0251,glad0252,
#              glad026,glad0261,glad0262              
#         INTO l_glad017,l_glad0171,l_glad0172,l_glad018,l_glad0181,l_glad0182,l_glad019,l_glad0191,l_glad0192,
#              l_glad020,l_glad0201,l_glad0202,l_glad021,l_glad0211,l_glad0212,l_glad022,l_glad0221,l_glad0222,
#              l_glad023,l_glad0231,l_glad0232,l_glad024,l_glad0241,l_glad0242,l_glad025,l_glad0251,l_glad0252,
#              l_glad026,l_glad0261,l_glad0262
#         FROM glad_t
#        WHERE gladent = g_enterprise
#          AND gladld = p_glapld
#          AND glad001 =l_glaq002
#161205-00025#4--mark--end

       #======================================
       #固定核算项检查
       #如果启用改固定核算项勾选，则对该核算项的值进行检查
       #======================================  
       #該科目做部門管理時，部門不可空白  
       IF l_glad007 = 'Y' THEN
          IF cl_null(l_glaq.glaq018) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.extend = l_msg1
             LET g_errparam.code   = "agl-00043"
             LET g_errparam.popup  = TRUE 
             CALL cl_err()
             LET l_success = FALSE
          ELSE
             #部门检查          
             CALL s_department_chk(l_glaq.glaq018,g_glap_m.glapdocdt) RETURNING r_success
             IF r_success = FALSE THEN
#                LET l_errmsg = l_msg||'/'||l_glaq.glaq018
#                INITIALIZE g_errparam TO NULL
#                LET g_errparam.extend = l_errmsg
#                LET g_errparam.code   = g_errno
#                LET g_errparam.popup  = TRUE 
#                CALL cl_err()
                LET l_success = FALSE
             END IF
          END IF          
       END IF
      
       #該科目做利潤成本管理時，利潤成本不可空白  
       IF l_glad008 = 'Y'  THEN
          IF cl_null(l_glaq.glaq019) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.extend = l_msg1
             LET g_errparam.code   = "agl-00044"
             LET g_errparam.popup  = TRUE 
             CALL cl_err()
             LET l_success = FALSE
          ELSE
             #利润成本中心检查         
             CALL s_voucher_glaq019_chk(l_glaq.glaq019,g_glap_m.glapdocdt)
             IF NOT cl_null(g_errno) THEN
                LET l_errmsg = l_msg||'/'||l_glaq.glaq019
                INITIALIZE g_errparam TO NULL
                LET g_errparam.extend = l_errmsg
                LET g_errparam.code   = g_errno
                #160321-00016#30 --s add
                LET g_errparam.replace[1] = 'aooi125'
                LET g_errparam.replace[2] = cl_get_progname('aooi125',g_lang,"2")
                LET g_errparam.exeprog = 'aooi125'
                #160321-00016#30 --e add
                LET g_errparam.popup  = TRUE 
                CALL cl_err()
                LET l_success = FALSE
             END IF
          END IF           
       END IF 
       
       #該科目做區域管理時，區域不可空白  
       IF l_glad009 = 'Y'  THEN
          IF cl_null(l_glaq.glaq020) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.extend = l_msg1
             LET g_errparam.code   = "agl-00045"
             LET g_errparam.popup  = TRUE 
             CALL cl_err()
             LET l_success = FALSE
          ELSE 
             #区域检查
             CALL s_azzi650_chk_exist('287',l_glaq.glaq020) RETURNING r_success
             IF r_success = FALSE THEN
#                LET l_errmsg = l_msg||'/'||l_glaq.glaq020
#                INITIALIZE g_errparam TO NULL
#                LET g_errparam.extend = l_errmsg
#                LET g_errparam.code   = g_errno
#                LET g_errparam.popup  = TRUE 
#                CALL cl_err()
                LET l_success = FALSE
             END IF 
          END IF
       END IF 
       
       #該科目做交易客商管理時，客商不可空白  
       IF l_glad010 = 'Y'  THEN
          IF cl_null(l_glaq.glaq021) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.extend = l_msg1
             LET g_errparam.code   = "agl-00046"
             LET g_errparam.popup  = TRUE 
             CALL cl_err()
             LET l_success = FALSE
          ELSE
             #客商检查
             CALL s_voucher_glaq021_chk(l_glaq.glaq021)
             IF NOT cl_null(g_errno) THEN
                LET l_errmsg = l_msg||'/'||l_glaq.glaq021
                INITIALIZE g_errparam TO NULL
                LET g_errparam.extend = l_errmsg
                LET g_errparam.code   = g_errno
                #160321-00016#30 --s add
                LET g_errparam.replace[1] = 'apmm100'
                LET g_errparam.replace[2] = cl_get_progname('apmm100',g_lang,"2")
                LET g_errparam.exeprog = 'apmm100'
                #160321-00016#30 --e add
                LET g_errparam.popup  = TRUE 
                CALL cl_err()
                LET l_success = FALSE
             END IF
          END IF
       END IF 
       
       #該科目做账款客商管理時，客商不可空白
       IF l_glad027 = 'Y'  THEN
          IF cl_null(l_glaq.glaq022) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.extend = l_msg1
             LET g_errparam.code   = "axr-00215"
             LET g_errparam.popup  = TRUE 
             CALL cl_err()
             LET l_success = FALSE
          ELSE
             #客商检查
             CALL s_voucher_glaq021_chk(l_glaq.glaq022)
             IF NOT cl_null(g_errno) THEN
                LET l_errmsg = l_msg||'/'||l_glaq.glaq022
                INITIALIZE g_errparam TO NULL
                LET g_errparam.extend = l_errmsg
                LET g_errparam.code   = g_errno
                #160321-00016#30 --s add
                LET g_errparam.replace[1] = 'apmm100'
                LET g_errparam.replace[2] = cl_get_progname('apmm100',g_lang,"2")
                LET g_errparam.exeprog = 'apmm100'
                #160321-00016#30 --e add
                LET g_errparam.popup  = TRUE 
                CALL cl_err()
                LET l_success = FALSE
             END IF
          END IF
       END IF 
       
       #該科目做客群管理時，客群不可空白  
       IF l_glad011 = 'Y'  THEN
          IF cl_null(l_glaq.glaq023) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.extend = l_msg1
             LET g_errparam.code   = "agl-00047"
             LET g_errparam.popup  = TRUE 
             CALL cl_err()
             LET l_success = FALSE
          ELSE
             #客群检查
             CALL s_azzi650_chk_exist('281',l_glaq.glaq023) RETURNING r_success
             IF r_success = FALSE THEN
#                LET l_errmsg = l_msg||'/'||l_glaq.glaq023
#                INITIALIZE g_errparam TO NULL
#                LET g_errparam.extend = l_errmsg
#                LET g_errparam.code   = g_errno
#                LET g_errparam.popup  = TRUE 
#                CALL cl_err()
                LET l_success = FALSE
             END IF 
          END IF
       END IF 
       
       #該科目做產品分類管理時，不可空白  
       IF l_glad012 = 'Y'  THEN
          IF cl_null(l_glaq.glaq024) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.extend = l_msg1
             LET g_errparam.code   = "agl-00068"
             LET g_errparam.popup  = TRUE 
             CALL cl_err()
             LET l_success = FALSE
          ELSE
             #产品分类检查 
             CALL s_voucher_glaq024_chk(l_glaq.glaq024)
             IF NOT cl_null(g_errno) THEN
                LET l_errmsg = l_msg||'/'||l_glaq.glaq024
                INITIALIZE g_errparam TO NULL
                LET g_errparam.extend = l_errmsg
                LET g_errparam.code   = g_errno
                #160321-00016#30 --s add
                LET g_errparam.replace[1] = 'arti202'
                LET g_errparam.replace[2] = cl_get_progname('arti202',g_lang,"2")
                LET g_errparam.exeprog = 'arti202'
                #160321-00016#30 --e add 
                LET g_errparam.popup  = TRUE 
                CALL cl_err()
                LET l_success = FALSE
             END IF 
          END IF
       END IF 
       
       #該科目做經營方式管理時，不可空白  
       IF l_glad031 = 'Y'  THEN
          IF cl_null(l_glaq.glaq051) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.extend = l_msg1
             LET g_errparam.code   = "agl-00286"
             LET g_errparam.popup  = TRUE 
             CALL cl_err()
             LET l_success = FALSE
          ELSE
             #經營方式检查
             CALL s_voucher_glaq051_chk(l_glaq.glaq051)
             IF NOT cl_null(g_errno) THEN
                LET l_errmsg = l_msg||'/'||l_glaq.glaq051
                INITIALIZE g_errparam TO NULL
                LET g_errparam.extend = l_errmsg
                LET g_errparam.code   = g_errno
                LET g_errparam.popup  = TRUE 
                CALL cl_err()
                LET l_success = FALSE
             END IF  
          END IF
       END IF
       
       #該科目做渠道管理時，不可空白  
       IF l_glad032 = 'Y'  THEN
          IF cl_null(l_glaq.glaq052) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.extend = l_msg1
             LET g_errparam.code   = "agl-00287"
             LET g_errparam.popup  = TRUE 
             CALL cl_err()
             LET l_success = FALSE
          ELSE
             #渠道检查
             CALL s_voucher_glaq052_chk(l_glaq.glaq052)
             IF NOT cl_null(g_errno) THEN
                LET l_errmsg = l_msg||'/'||l_glaq.glaq052
                INITIALIZE g_errparam TO NULL
                LET g_errparam.extend = l_errmsg
                LET g_errparam.code   = g_errno
                LET g_errparam.popup  = TRUE 
                CALL cl_err()
                LET l_success = FALSE
             END IF 
          END IF
       END IF
       
       #該科目做品牌管理時，不可空白  
       IF l_glad033 = 'Y'  THEN
          IF cl_null(l_glaq.glaq053) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.extend = l_msg1
             LET g_errparam.code   = "agl-00288"
             LET g_errparam.popup  = TRUE 
             CALL cl_err()
             LET l_success = FALSE
          ELSE
             #品牌检查
             CALL s_azzi650_chk_exist('2002',l_glaq.glaq053) RETURNING r_success
             IF r_success = FALSE THEN
#                LET l_errmsg = l_msg||'/'||l_glaq.glaq053
#                INITIALIZE g_errparam TO NULL
#                LET g_errparam.extend = l_errmsg
#                LET g_errparam.code   = g_errno
#                LET g_errparam.popup  = TRUE 
#                CALL cl_err()
                LET l_success = FALSE
             END IF  
          END IF
       END IF
       
       #該科目做人員管理時，不可空白  
       IF l_glad013 = 'Y'  THEN
          IF cl_null(l_glaq.glaq025) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.extend = l_msg1
             LET g_errparam.code   = "agl-00069"
             LET g_errparam.popup  = TRUE 
             CALL cl_err()
             LET l_success = FALSE
          ELSE
             #人员检查
             CALL s_employee_chk(l_glaq.glaq025) RETURNING r_success
             IF r_success = FALSE THEN
#                LET l_errmsg = l_msg||'/'||l_glaq.glaq025
#                INITIALIZE g_errparam TO NULL
#                LET g_errparam.extend = l_errmsg
#                LET g_errparam.code   = g_errno
#                LET g_errparam.popup  = TRUE 
#                CALL cl_err()
                LET l_success = FALSE
             END IF 
          END IF
       END IF 
       
       
       #該科目做專案管理時，不可空白  
       IF l_glad015 = 'Y'  THEN
          IF cl_null(l_glaq.glaq027) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.extend = l_msg1
             #LET g_errparam.code   = "agl-00071" #170111-00005#1 mark
             LET g_errparam.code   = "agl-00541"  #170111-00005#1 add
             LET g_errparam.popup  = TRUE 
             CALL cl_err()
             #LET l_success = FALSE               #170111-00005#1 mark
          ELSE
             CALL s_aap_project_chk(l_glaq.glaq027) RETURNING r_success,g_errno
             IF r_success = FALSE THEN
                LET l_errmsg = l_msg||'/'||l_glaq.glaq027
                INITIALIZE g_errparam TO NULL
                LET g_errparam.extend = l_errmsg
                LET g_errparam.code   = g_errno
                #160321-00016#30 --s add
                LET g_errparam.replace[1] = 'apjm200'
                LET g_errparam.replace[2] = cl_get_progname('apjm200',g_lang,"2")
                LET g_errparam.exeprog = 'apjm200'
                #160321-00016#30 --e add
                LET g_errparam.popup  = TRUE 
                CALL cl_err()
                LET l_success = FALSE             
             END IF
          END IF 
       END IF 
       
       #該科目做WBS管理時，不可空白  
       IF l_glad016 = 'Y'  THEN
          IF cl_null(l_glaq.glaq028) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.extend = l_msg1
             #LET g_errparam.code   = "agl-00072" #170111-00005#1 mark
             LET g_errparam.code   = "agl-00542"  #170111-00005#1 add
             LET g_errparam.popup  = TRUE 
             CALL cl_err()
             #LET l_success = FALSE               #170111-00005#1 mark
          ELSE
             CALL s_voucher_glaq028_chk(l_glaq.glaq027,l_glaq.glaq028) 
             IF NOT cl_null(g_errno) THEN
                LET l_errmsg = l_msg||'/'||l_glaq.glaq028
                INITIALIZE g_errparam TO NULL
                LET g_errparam.extend = l_errmsg
                LET g_errparam.code   = g_errno
                LET g_errparam.popup  = TRUE 
                CALL cl_err()
                LET l_success = FALSE            
             END IF
          END IF 
       END IF
       #===================================================
       #自由核算项检查
       #如果启用该核算项勾选，并且控制方式不为1：允许空白，则对核算项的值进行检查
       #===================================================
       #核算项一
       IF l_glad017 = 'Y' THEN
          IF l_glad0172<>'1' THEN
             IF cl_null(l_glaq.glaq029) THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.extend = l_msg1
                LET g_errparam.code   = "agl-00074"
                LET g_errparam.popup  = TRUE 
                CALL cl_err()
                LET l_success = FALSE
             END IF
          END IF
          IF NOT cl_null(l_glaq.glaq029) THEN           
             CALL s_voucher_free_account_chk(l_glad0171,l_glaq.glaq029,l_glad0172) RETURNING l_errno
             IF NOT cl_null(l_errno) THEN
                LET l_errmsg = l_msg||'/'||l_glaq.glaq029
                INITIALIZE g_errparam TO NULL
                LET g_errparam.extend = l_errmsg
                LET g_errparam.code   = l_errno
                #160321-00016#30 --s add
                LET g_errparam.replace[1] = 'agli041'
                LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                LET g_errparam.exeprog = 'agli041'
                #160321-00016#30 --e add
                LET g_errparam.popup  = TRUE 
                CALL cl_err()
                LET l_success = FALSE
             END IF 
           END IF   
       END IF 
       #核算项二
       IF l_glad018 = 'Y'  THEN
          IF l_glad0182 <>'1' THEN 
             IF cl_null(l_glaq.glaq030) THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.extend = l_msg1
                LET g_errparam.code   = "agl-00075"
                LET g_errparam.popup  = TRUE 
                CALL cl_err()
                LET l_success = FALSE
             END IF
          END IF          
          IF NOT cl_null(l_glaq.glaq030) THEN          
             CALL s_voucher_free_account_chk(l_glad0181,l_glaq.glaq030,l_glad0182) RETURNING l_errno
             IF NOT cl_null(l_errno) THEN
                LET l_errmsg = l_msg||'/'||l_glaq.glaq030
                INITIALIZE g_errparam TO NULL
                LET g_errparam.extend = l_errmsg
                LET g_errparam.code   = l_errno
                #160321-00016#30 --s add
                LET g_errparam.replace[1] = 'agli041'
                LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                LET g_errparam.exeprog = 'agli041'
                #160321-00016#30 --e add
                LET g_errparam.popup  = TRUE 
                CALL cl_err()
                LET l_success = FALSE
             END IF 
          END IF    
       END IF
       #核算项三
       IF l_glad019 = 'Y'  THEN
          IF l_glad0192 <>'1'  THEN 
             IF cl_null(l_glaq.glaq031) THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.extend = l_msg1
                LET g_errparam.code   = "agl-00076"
                LET g_errparam.popup  = TRUE 
                CALL cl_err()
                LET l_success = FALSE
             END IF
          END IF             
          IF NOT cl_null(l_glaq.glaq031) THEN        
             CALL s_voucher_free_account_chk(l_glad0191,l_glaq.glaq031,l_glad0192) RETURNING l_errno
             IF NOT cl_null(l_errno) THEN
                LET l_errmsg = l_msg||'/'||l_glaq.glaq031
                INITIALIZE g_errparam TO NULL
                LET g_errparam.extend = l_errmsg
                LET g_errparam.code   = l_errno
                #160321-00016#30 --s add
                LET g_errparam.replace[1] = 'agli041'
                LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                LET g_errparam.exeprog = 'agli041'
                #160321-00016#30 --e add
                LET g_errparam.popup  = TRUE 
                CALL cl_err()
                LET l_success = FALSE
             END IF 
          END IF    
       END IF 
       #核算项四
       IF l_glad020 = 'Y' THEN
          IF l_glad0202 <>'1' THEN
             IF cl_null(l_glaq.glaq032) THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.extend = l_msg1
                LET g_errparam.code   = "agl-00077"
                LET g_errparam.popup  = TRUE 
                CALL cl_err()
                LET l_success = FALSE
             END IF   
          END IF
          IF NOT cl_null(l_glaq.glaq032) THEN
             CALL s_voucher_free_account_chk(l_glad0201,l_glaq.glaq032,l_glad0202) RETURNING l_errno
             IF NOT cl_null(l_errno) THEN
                LET l_errmsg = l_msg||'/'||l_glaq.glaq032
                INITIALIZE g_errparam TO NULL
                LET g_errparam.extend = l_errmsg
                LET g_errparam.code   = l_errno
                #160321-00016#30 --s add
                LET g_errparam.replace[1] = 'agli041'
                LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                LET g_errparam.exeprog = 'agli041'
                #160321-00016#30 --e add
                LET g_errparam.popup  = TRUE 
                CALL cl_err()
                LET l_success = FALSE
             END IF 
          END IF    
       END IF
       #核算项五
       IF l_glad021 = 'Y'  THEN
          IF l_glad0212 <>'1' THEN
             IF cl_null(l_glaq.glaq033) THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.extend = l_msg1
                LET g_errparam.code   = "agl-00078"
                LET g_errparam.popup  = TRUE 
                CALL cl_err()
                LET l_success = FALSE
             END IF
          END IF
          IF NOT cl_null(l_glaq.glaq033) THEN
             CALL s_voucher_free_account_chk(l_glad0211,l_glaq.glaq033,l_glad0212) RETURNING l_errno
             IF NOT cl_null(l_errno) THEN
                LET l_errmsg = l_msg||'/'||l_glaq.glaq033
                INITIALIZE g_errparam TO NULL
                LET g_errparam.extend = l_errmsg
                LET g_errparam.code   = l_errno
                #160321-00016#30 --s add
                LET g_errparam.replace[1] = 'agli041'
                LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                LET g_errparam.exeprog = 'agli041'
                #160321-00016#30 --e add
                LET g_errparam.popup  = TRUE 
                CALL cl_err()
                LET l_success = FALSE
             END IF 
          END IF    
       END IF 
        #核算项六
       IF l_glad022 = 'Y'  THEN
          IF l_glad0222 <>'1' THEN
             IF cl_null(l_glaq.glaq034) THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.extend = l_msg1
                LET g_errparam.code   = "agl-00079"
                LET g_errparam.popup  = TRUE 
                CALL cl_err()
                LET l_success = FALSE
             END IF
          END IF 
          IF NOT cl_null(l_glaq.glaq034) THEN          
             CALL s_voucher_free_account_chk(l_glad0221,l_glaq.glaq034,l_glad0222) RETURNING l_errno
             IF NOT cl_null(l_errno) THEN
                LET l_errmsg = l_msg||'/'||l_glaq.glaq034
                INITIALIZE g_errparam TO NULL
                LET g_errparam.extend = l_errmsg
                LET g_errparam.code   = l_errno
                #160321-00016#30 --s add
                LET g_errparam.replace[1] = 'agli041'
                LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                LET g_errparam.exeprog = 'agli041'
                #160321-00016#30 --e add
                LET g_errparam.popup  = TRUE 
                CALL cl_err()
                LET l_success = FALSE
             END IF
          END IF           
       END IF 
       #核算项七
       IF l_glad023 = 'Y'  THEN
          IF l_glad0232 <>'1' THEN 
             IF cl_null(l_glaq.glaq035) THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.extend = l_msg1
                LET g_errparam.code   = "agl-00080"
                LET g_errparam.popup  = TRUE 
                CALL cl_err()
                LET l_success = FALSE
             END IF
          END IF  
          IF NOT cl_null(l_glaq.glaq035) THEN          
             CALL s_voucher_free_account_chk(l_glad0231,l_glaq.glaq035,l_glad0232) RETURNING l_errno
             IF NOT cl_null(l_errno) THEN
                LET l_errmsg = l_msg||'/'||l_glaq.glaq035
                INITIALIZE g_errparam TO NULL
                LET g_errparam.extend = l_errmsg
                LET g_errparam.code   = l_errno
                #160321-00016#30 --s add
                LET g_errparam.replace[1] = 'agli041'
                LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                LET g_errparam.exeprog = 'agli041'
                #160321-00016#30 --e add
                LET g_errparam.popup  = TRUE 
                CALL cl_err()
                LET l_success = FALSE
             END IF
          END IF           
       END IF
       #核算项八
       IF l_glad024 = 'Y'  THEN
          IF l_glad0242 <>'1' THEN 
             IF cl_null(l_glaq.glaq036) THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.extend = l_msg1
                LET g_errparam.code   = "agl-00081"
                LET g_errparam.popup  = TRUE 
                CALL cl_err()
                LET l_success = FALSE
             END IF 
          END IF
          IF NOT cl_null(l_glaq.glaq036) THEN         
             CALL s_voucher_free_account_chk(l_glad0241,l_glaq.glaq036,l_glad0242) RETURNING l_errno
             IF NOT cl_null(l_errno) THEN
                LET l_errmsg = l_msg||'/'||l_glaq.glaq036
                INITIALIZE g_errparam TO NULL
                LET g_errparam.extend = l_errmsg
                LET g_errparam.code   = l_errno
                #160321-00016#30 --s add
                LET g_errparam.replace[1] = 'agli041'
                LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                LET g_errparam.exeprog = 'agli041'
                #160321-00016#30 --e add
                LET g_errparam.popup  = TRUE 
                CALL cl_err()
                LET l_success = FALSE
             END IF 
          END IF 
       END IF 
       #核算项九
       IF l_glad025 = 'Y'  THEN
          IF l_glad0252 <>'1' THEN
             IF cl_null(l_glaq.glaq037) THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.extend = l_msg1
                LET g_errparam.code   = "agl-00082"
                LET g_errparam.popup  = TRUE 
                CALL cl_err()
                LET l_success = FALSE
             END IF 
          END IF
          IF NOT cl_null(l_glaq.glaq037) THEN          
             CALL s_voucher_free_account_chk(l_glad0251,l_glaq.glaq037,l_glad0252) RETURNING l_errno
             IF NOT cl_null(l_errno) THEN
                LET l_errmsg = l_msg||'/'||l_glaq.glaq037
                INITIALIZE g_errparam TO NULL
                LET g_errparam.extend = l_errmsg
                LET g_errparam.code   = l_errno
                #160321-00016#30 --s add
                LET g_errparam.replace[1] = 'agli041'
                LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                LET g_errparam.exeprog = 'agli041'
                #160321-00016#30 --e add
                LET g_errparam.popup  = TRUE 
                CALL cl_err()
                LET l_success = FALSE
             END IF
          END IF           
       END IF        
       #核算项十
       IF l_glad026 = 'Y'  THEN
          IF l_glad0262 <>'1' THEN
             IF cl_null(l_glaq.glaq038) THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.extend = l_msg1
                LET g_errparam.code   = "agl-00083"
                LET g_errparam.popup  = TRUE 
                CALL cl_err()
                LET l_success = FALSE
             END IF  
          END IF
          IF NOT cl_null(l_glaq.glaq038) THEN        
             CALL s_voucher_free_account_chk(l_glad0261,l_glaq.glaq038,l_glad0262) RETURNING l_errno
             IF NOT cl_null(l_errno) THEN
                LET l_errmsg = l_msg||'/'||l_glaq.glaq038
                INITIALIZE g_errparam TO NULL
                LET g_errparam.extend = l_errmsg
                LET g_errparam.code   = l_errno
                #160321-00016#30 --s add
                LET g_errparam.replace[1] = 'agli041'
                LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                LET g_errparam.exeprog = 'agli041'
                #160321-00016#30 --e add
                LET g_errparam.popup  = TRUE 
                CALL cl_err()
                LET l_success = FALSE
             END IF 
          END IF 
       END IF         
   END FOREACH
   CALL cl_err_collect_show()
   
END FUNCTION

################################################################################
# Descriptions...: 單位檢查
# Memo...........:
# Usage..........: CALL aglt310_glaq007_chk(p_glaq007)
# Modify.........:
################################################################################
PRIVATE FUNCTION aglt310_glaq007_chk(p_glaq007)
   DEFINE p_glaq007     LIKE glaq_t.glaq007
   DEFINE l_oocastus    LIKE ooca_t.oocastus
   
   LET g_errno = ''
   SELECT oocastus INTO l_oocastus FROM ooca_t
    WHERE oocaent = g_enterprise
      AND ooca001 = p_glaq007
    
    CASE  
        WHEN SQLCA.sqlcode = 100   LET g_errno = 'aim-00004'
        WHEN l_oocastus = 'N'      LET g_errno = 'sub-01302'  #160318-00005#17 mod #'aim-00005'
     END CASE
END FUNCTION

################################################################################
# Descriptions...: 插入現金變動碼資料
# Memo...........:
# Usage..........: CALL aglt310_insert_glbc()
#                  RETURNING r_success
# Modify.........:
################################################################################
PRIVATE FUNCTION aglt310_insert_glbc()
   #161128-00061#1----modify------begin-----------
   #DEFINE l_glbc         RECORD LIKE glbc_t.*
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
       glbc005 LIKE glbc_t.glbc005, #關係人
       glbc006 LIKE glbc_t.glbc006, #交易幣別
       glbc007 LIKE glbc_t.glbc007, #匯率
       glbc008 LIKE glbc_t.glbc008, #原幣金額
       glbc009 LIKE glbc_t.glbc009, #本幣金額
       glbc010 LIKE glbc_t.glbc010, #資料來源
       glbc011 LIKE glbc_t.glbc011, #匯率(本位幣二)
       glbc012 LIKE glbc_t.glbc012, #金額(本位幣二)
       glbc013 LIKE glbc_t.glbc013, #匯率(本位幣三)
       glbc014 LIKE glbc_t.glbc014, #金額(本位幣三)
       glbc015 LIKE glbc_t.glbc015  #狀態碼
       END RECORD

   #161128-00061#1----modify------end-----------
   DEFINE r_success      LIKE type_t.num5

   LET r_success=TRUE
   INITIALIZE l_glbc.* TO NULL
   LET l_glbc.glbcent=g_enterprise
   LET l_glbc.glbcld=g_glap_m.glapld
   LET l_glbc.glbccomp=g_glap_m.glapcomp
   LET l_glbc.glbcdocno=g_glap_m.glapdocno
   LET l_glbc.glbcseq=g_glaq_d[l_ac].glaqseq
   #序號
   SELECT MAX(glbcseq1)+1 INTO l_glbc.glbcseq1 FROM glbc_t
    WHERE glbcent=g_enterprise AND glbcld=g_glap_m.glapld
      AND glbcdocno=g_glap_m.glapdocno AND glbcseq=l_glbc.glbcseq
   IF cl_null(l_glbc.glbcseq1) THEN LET l_glbc.glbcseq1=1 END IF
   LET l_glbc.glbc001=g_glap_m.glap002
   LET l_glbc.glbc002=g_glap_m.glap004
   IF NOT cl_null(g_glaq_d[l_ac].glaq003) AND g_glaq_d[l_ac].glaq003 <> 0  THEN
      LET l_glbc.glbc003='1' #借
      #本幣金額
      LET l_glbc.glbc009=g_glaq_d[l_ac].glaq003
      LET l_glbc.glbc012=g_glaq_d[l_ac].glaq040
      LET l_glbc.glbc014=g_glaq_d[l_ac].glaq043
   ELSE
      LET l_glbc.glbc003='2' #貸
      LET l_glbc.glbc009=g_glaq_d[l_ac].glaq004
      LET l_glbc.glbc012=g_glaq_d[l_ac].glaq041
      LET l_glbc.glbc014=g_glaq_d[l_ac].glaq044
   END IF
   LET l_glbc.glbc004=g_glaq_r.glbc004 #現金變動碼
   LET l_glbc.glbc006=g_glaq_d[l_ac].glaq005
   LET l_glbc.glbc007=g_glaq_d[l_ac].glaq006
   LET l_glbc.glbc008=g_glaq_d[l_ac].glaq010 #原幣金額   
   LET l_glbc.glbc010='1'   #1.總帳模組
   LET l_glbc.glbc011=g_glaq_d[l_ac].glaq039
   LET l_glbc.glbc013=g_glaq_d[l_ac].glaq042
   LET l_glbc.glbc015=g_glap_m.glapstus      #151013-00016#6 
   
   INSERT INTO glbc_t(glbcent,glbcld,glbccomp,glbcdocno,glbcseq,glbcseq1,glbc001,glbc002,
                      glbc003,glbc004,glbc005,glbc006,glbc007,glbc008,glbc009,glbc010,
                      glbc011,glbc012,glbc013,glbc014,glbc015)  #151013-00016#6 add glbc015
   VALUES(l_glbc.glbcent,l_glbc.glbcld,l_glbc.glbccomp,l_glbc.glbcdocno,l_glbc.glbcseq,
          l_glbc.glbcseq1,l_glbc.glbc001,l_glbc.glbc002,l_glbc.glbc003,l_glbc.glbc004,
          l_glbc.glbc005,l_glbc.glbc006,l_glbc.glbc007,l_glbc.glbc008,l_glbc.glbc009,
          l_glbc.glbc010,l_glbc.glbc011,l_glbc.glbc012,l_glbc.glbc013,l_glbc.glbc014,l_glbc.glbc015)#151013-00016#6 add glbc015
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = sqlca.sqlcode
      LET g_errparam.extend = 'insert glbc_t'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success=FALSE
   END IF
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 新增修改现金变动码glbc_t
# Memo...........:
# Usage..........: CALL aglt310_ins_upd_glbc()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/2/4 By wangrr
# Modify.........:
################################################################################
PRIVATE FUNCTION aglt310_ins_upd_glbc()
   DEFINE  l_success   LIKE type_t.num5
   DEFINE  l_cnt       LIKE type_t.num5
   DEFINE  l_glac016   LIKE glac_t.glac016
   DEFINE  l_glbc009   LIKE glbc_t.glbc009
   DEFINE  l_glbc012   LIKE glbc_t.glbc012
   DEFINE  l_glbc014   LIKE glbc_t.glbc014
   DEFINE  l_glbc003   LIKE glbc_t.glbc003
   
   LET l_success = TRUE
   
   
   #更新現金變動碼資料
   SELECT glac016 INTO l_glac016 FROM glac_t
    WHERE glacent=g_enterprise AND glac001=g_glaa004 AND glac002=g_glaq_d[l_ac].glaq002
   IF l_glac016 = 'Y' THEN
      LET l_cnt=0
      SELECT COUNT(1) INTO l_cnt FROM glbc_t #161205-00025#4 mod '*'-->1
       WHERE glbcent=g_enterprise 
         AND glbcld=g_glap_m.glapld 
         AND glbcdocno=g_glap_m.glapdocno
         AND glbcseq=g_glaq_d[l_ac].glaqseq 
         AND glbc001=g_glap_m.glap002 
         AND glbc002=g_glap_m.glap004
      #150827-00036#14--mod--str--
      IF l_cnt = 0 THEN
         #当维护现金变动码时不更新glbc_t
         IF NOT cl_null(g_glaq_r.glbc004) THEN
            #插入一筆現金變動碼
            CALL aglt310_insert_glbc() RETURNING l_success 
         END IF
      ELSE
         #当只有一笔现金变动码资料时
         IF l_cnt = 1 THEN
            #当把值改成空格，删除glbc_t中该笔项次对应的资料
            IF cl_null(g_glaq_r.glbc004) THEN
               DELETE FROM glbc_t
                WHERE glbcent=g_enterprise 
                  AND glbcld=g_glap_m.glapld 
                  AND glbcdocno=g_glap_m.glapdocno
                  AND glbcseq=g_glaq_d[l_ac].glaqseq 
                  AND glbc001=g_glap_m.glap002 
                  AND glbc002=g_glap_m.glap004
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = sqlca.sqlcode
                  LET g_errparam.extend = 'delete glbc_t'
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET l_success = FALSE
               END IF
            ELSE
               #更新現金變動碼
               IF NOT cl_null(g_glaq_d[l_ac].glaq003) AND g_glaq_d[l_ac].glaq003 <> 0 THEN
                  LET l_glbc003 = '1'
                  LET l_glbc009 = g_glaq_d[l_ac].glaq003
                  LET l_glbc012 = g_glaq_d[l_ac].glaq040
                  LET l_glbc014 = g_glaq_d[l_ac].glaq043
               ELSE
                  LET l_glbc003 = '2'
                  LET l_glbc009 = g_glaq_d[l_ac].glaq004
                  LET l_glbc012 = g_glaq_d[l_ac].glaq041
                  LET l_glbc014 = g_glaq_d[l_ac].glaq044
               END IF
               UPDATE glbc_t SET glbc003=l_glbc003,  #借贷别
                                 glbc004=g_glaq_r.glbc004,
                                 glbc006=g_glaq_d[l_ac].glaq005,
                                 glbc007=g_glaq_d[l_ac].glaq006,
                                 glbc008=g_glaq_d[l_ac].glaq010, #原幣金額
                                 glbc009=l_glbc009, #本幣金額
                                 glbc011=g_glaq_d[l_ac].glaq039,
                                 glbc012=l_glbc012,
                                 glbc013=g_glaq_d[l_ac].glaq042,
                                 glbc014=l_glbc014
                WHERE glbcent=g_enterprise 
                  AND glbcld=g_glap_m.glapld 
                  AND glbcdocno=g_glap_m.glapdocno
                  AND glbcseq=g_glaq_d[l_ac].glaqseq 
                  AND glbc001=g_glap_m.glap002 
                  AND glbc002=g_glap_m.glap004
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = sqlca.sqlcode
                  LET g_errparam.extend = 'update glbc_t'
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET l_success = FALSE
               END IF
            END IF   
         ELSE
#            #当现金变动码由空格变成有值时，删除原有资料，重新插入一笔
#            IF NOT cl_null(g_glaq_r.glbc004) THEN
#               DELETE FROM glbc_t
#                WHERE glbcent=g_enterprise 
#                  AND glbcld=g_glap_m.glapld 
#                  AND glbcdocno=g_glap_m.glapdocno
#                  AND glbcseq=g_glaq_d[l_ac].glaqseq 
#                  AND glbc001=g_glap_m.glap002 
#                  AND glbc002=g_glap_m.glap004
#               IF SQLCA.SQLCODE THEN
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = sqlca.sqlcode
#                  LET g_errparam.extend = 'delete glbc_t'
#                  LET g_errparam.popup = TRUE
#                  CALL cl_err()
#                  LET l_success = FALSE
#               END IF
#               IF l_success = TRUE THEN
#                  #插入一筆現金變動碼
#                  CALL aglt310_insert_glbc() RETURNING l_success 
#               END IF
#            END IF

            #当没值变有值时，更新现金变动码，金额处理待定
            IF NOT cl_null(g_glaq_r.glbc004) THEN
               UPDATE glbc_t SET glbc004=g_glaq_r.glbc004
                WHERE glbcent=g_enterprise 
                  AND glbcld=g_glap_m.glapld 
                  AND glbcdocno=g_glap_m.glapdocno
                  AND glbcseq=g_glaq_d[l_ac].glaqseq 
                  AND glbc001=g_glap_m.glap002 
                  AND glbc002=g_glap_m.glap004
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = sqlca.sqlcode
                  LET g_errparam.extend = 'update glbc_t'
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET l_success = FALSE
               END IF
            END IF
         END IF
#150827-00036#14--mod--end
      END IF
   ELSE
      #非现金类科目，当存在现金变动码时删除对应的科目
      LET l_cnt=0
      SELECT COUNT(1) INTO l_cnt FROM glbc_t #161205-00025#4 mod '*'-->1
       WHERE glbcent=g_enterprise 
         AND glbcld=g_glap_m.glapld 
         AND glbcdocno=g_glap_m.glapdocno
         AND glbcseq=g_glaq_d[l_ac].glaqseq 
         AND glbc001=g_glap_m.glap002 
         AND glbc002=g_glap_m.glap004
      IF l_cnt > 0 THEN
         #删除一筆現金變動碼
         DELETE FROM glbc_t
          WHERE glbcent=g_enterprise 
            AND glbcld=g_glap_m.glapld 
            AND glbcdocno=g_glap_m.glapdocno
            AND glbcseq=g_glaq_d[l_ac].glaqseq 
            AND glbc001=g_glap_m.glap002 
            AND glbc002=g_glap_m.glap004
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = sqlca.sqlcode
            LET g_errparam.extend = 'delete glbc_t'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET l_success = FALSE
         END IF
      END IF          
   END IF
   RETURN l_success
END FUNCTION

################################################################################
# Descriptions...: 录入金额式预设借贷方金额，使每一次录入时借贷平
# Memo...........: 
# Usage..........: CALL aglt310_default_amt(p_type)
#                  RETURNING 回传参数
# Input parameter: p_type  1：预设借方金额，2：预设贷方金额
# Return code....: 
# Date & Author..: 2015/09/09 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglt310_default_amt(p_type)
   DEFINE p_type          LIKE type_t.chr1
   DEFINE l_amt1          LIKE glaq_t.glaq003
   DEFINE l_amt2          LIKE glaq_t.glaq003
   DEFINE l_amt3          LIKE glaq_t.glaq003
   
   IF (cl_null(g_glaq_d[l_ac].glaq003) OR g_glaq_d[l_ac].glaq003 =0 ) AND 
      (cl_null(g_glaq_d[l_ac].glaq004) OR g_glaq_d[l_ac].glaq004 =0 ) THEN
      SELECT SUM(glaq003-glaq004),SUM(glaq040-glaq041),SUM(glaq043-glaq044) 
        INTO l_amt1,l_amt2,l_amt3
        FROM glaq_t
       WHERE glaqent=g_enterprise AND glaqld=g_glap_m.glapld 
         AND glaqdocno=g_glap_m.glapdocno AND glaqseq<>g_glaq_d[l_ac].glaqseq
      IF cl_null(l_amt1) THEN LET l_amt1 = 0 END IF
      IF cl_null(l_amt2) THEN LET l_amt2 = 0 END IF
      IF cl_null(l_amt3) THEN LET l_amt3 = 0 END IF
   
      #录入借方金额栏位
      IF p_type = '1' THEN
         #贷余：预设借方金额
         IF l_amt1 < 0 THEN
            LET g_glaq_d[l_ac].glaq003 = l_amt1 * (-1)
            LET g_glaq_d[l_ac].glaq040 = l_amt2 * (-1)
            LET g_glaq_d[l_ac].glaq043 = l_amt3 * (-1)
         END IF
      #录入贷方金额栏位
      ELSE
         #借余，预设贷方金额
         IF l_amt1 > 0 THEN
            LET g_glaq_d[l_ac].glaq004 = l_amt1
            LET g_glaq_d[l_ac].glaq041 = l_amt2
            LET g_glaq_d[l_ac].glaq044 = l_amt3
         END IF
      END IF
   END IF
END FUNCTION
# 款別編碼說明
#151223-00004#1 add lujh
PRIVATE FUNCTION aglt310_glaq015_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_glap_m.glaq015
   CALL ap_ref_array2(g_ref_fields,"SELECT ooial003 FROM ooial_t WHERE ooialent='"||g_enterprise||"' AND ooial001=? AND ooial002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_glap_m.glaq015_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_glap_m.glaq015_desc
END FUNCTION
# 存提碼說明
#151223-00004#1 add lujh
PRIVATE FUNCTION aglt310_glaq016_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_glap_m.glaq016
   CALL ap_ref_array2(g_ref_fields,"SELECT nmajl003 FROM nmajl_t WHERE nmajlent='"||g_enterprise||"' AND nmajl001=? AND nmajl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_glap_m.glaq016_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_glap_m.glaq016_desc
END FUNCTION
################################################################################
# Descriptions...: 获取显示给用户看到的交易账户型态
# Memo...........: #160122-00001#34
# Usage..........: CALL aglt310_get_lc_glaq014(p_glaq014)
#                  RETURNING lc_glaq014
# Input parameter: p_glaq014  交易账户编号
# Return code....: lc_glaq014 返回现在在画面中的交易账户编号
# Date & Author..: 2016/03/07 By 07673
# Modify.........:
################################################################################
PRIVATE FUNCTION aglt310_get_lc_glaq014(p_glaq014)
   DEFINE p_glaq014   LIKE glaq_t.glaq014
   DEFINE l_cnt       LIKE type_t.num5
   DEFINE l_cnt2      LIKE type_t.num5 
   DEFINE l_glaq014   LIKE glaq_t.glaq014
   #判断当前用户是否有权限查看该交易账户，如果没有权限不可看到交易账户编号，用“*”显示
   LET  l_glaq014 = p_glaq014
      IF NOT cl_null(p_glaq014) THEN 
         LET l_cnt = 0 
         SELECT COUNT(1) INTO l_cnt #161205-00025#4 mod '*'-->1
           FROM nmaa_t,nmas_t 
          WHERE nmasent = g_enterprise AND nmasent = nmaaent AND nmas001 = nmaa001 
            AND nmas002 IN (SELECT nmll001 FROM nmll_t WHERE nmllent = g_enterprise AND nmll002 = g_user AND nmllstus='Y') 
            AND nmas001 IN (SELECT nmaa001 FROM nmaa_t WHERE nmaaent = g_enterprise AND nmaa005 = p_glaq014 AND nmaastus='Y')
         LET l_cnt2 = 0 
         SELECT COUNT(1) INTO l_cnt2 #161205-00025#4 mod '*'-->1
           FROM nmaa_t,nmas_t 
          WHERE nmasent = g_enterprise AND nmasent = nmaaent AND nmas001 = nmaa001 
            AND nmas002 IN (SELECT nmlm001 FROM nmlm_t WHERE nmlment = g_enterprise AND nmlm002 = g_dept AND nmlmstus='Y') 
            AND nmas001 IN (SELECT nmaa001 FROM nmaa_t WHERE nmaaent = g_enterprise AND nmaa005 = p_glaq014 AND nmaastus='Y')   
         IF l_cnt = 0 AND l_cnt2 = 0 THEN 
            LET p_glaq014 = "********"
          END IF 
      END IF
   RETURN p_glaq014 
END FUNCTION

################################################################################
# Descriptions...: 刪除憑證后，anmt820憑證號清除
# Memo...........:
# Usage..........: CALL aglt310_upd_nmde(p_glapld,p_glap002,p_glap004)
# Date & Author..: 2016/12/01 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION aglt310_upd_nmde(p_glapld,p_glap002,p_glap004)
   DEFINE p_glapld      LIKE glap_t.glapld
   DEFINE p_glap002     LIKE glap_t.glap002
   DEFINE p_glap004     LIKE glap_t.glap004
   DEFINE l_cnt         LIKE type_t.num5
   DEFINE l_success     LIKE type_t.num5
   
   LET l_success=TRUE
   LET l_cnt=0
   SELECT COUNT(1) INTO l_cnt FROM nmde_t #161205-00025#4 mod '*'-->1
    WHERE nmdeent=g_enterprise  AND nmdeld=p_glapld
      AND nmde001=p_glap002 AND nmde002=p_glap004
   IF l_cnt>0 THEN
      UPDATE nmde_t SET nmde017 = ''
         WHERE nmdeent = g_enterprise
           AND nmdeld = p_glapld
           AND nmde001 = p_glap002
           AND nmde002 = p_glap004
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "upd glap_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
       
         LET l_success=FALSE
      END IF
   END IF
   RETURN l_success
END FUNCTION

 
{</section>}
 
