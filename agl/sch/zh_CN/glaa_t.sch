/* 
================================================================================
檔案代號:glaa_t
檔案名稱:账别数据档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table glaa_t
(
glaaent       number(5)      ,/* 企业编号 */
glaaownid       varchar2(20)      ,/* 资料所有者 */
glaaowndp       varchar2(10)      ,/* 资料所有部门 */
glaacrtid       varchar2(20)      ,/* 资料录入者 */
glaacrtdp       varchar2(10)      ,/* 资料录入部门 */
glaacrtdt       timestamp(0)      ,/* 资料创建日 */
glaamodid       varchar2(20)      ,/* 资料更改者 */
glaamoddt       timestamp(0)      ,/* 最近更改日 */
glaastus       varchar2(10)      ,/* 状态码 */
glaald       varchar2(5)      ,/* 账套编号 */
glaacomp       varchar2(10)      ,/* 归属法人 */
glaa001       varchar2(10)      ,/* 使用币种 */
glaa002       varchar2(5)      ,/* 汇率参照表号 */
glaa003       varchar2(5)      ,/* 会计周期参照表号 */
glaa004       varchar2(5)      ,/* 会计科目参照表号 */
glaa005       varchar2(10)      ,/* 现金变动参照表号 */
glaa006       varchar2(1)      ,/* 月结方式 */
glaa007       varchar2(1)      ,/* 年结方式 */
glaa008       varchar2(1)      ,/* 平行记账否 */
glaa009       varchar2(1)      ,/* 凭证登录方式 */
glaa010       number(5,0)      ,/* 现行年度 */
glaa011       number(5,0)      ,/* 现行期别 */
glaa012       date      ,/* 最后过账日期 */
glaa013       date      ,/* 关账日期 */
glaa014       varchar2(1)      ,/* 主账套 */
glaa015       varchar2(1)      ,/* 启用本位币二 */
glaa016       varchar2(10)      ,/* 本位币二 */
glaa017       varchar2(1)      ,/* 本位币二换算基准 */
glaa018       varchar2(10)      ,/* 本位币二汇率采用 */
glaa019       varchar2(1)      ,/* 启用本位币三 */
glaa020       varchar2(10)      ,/* 本位币三 */
glaa021       varchar2(1)      ,/* 本位币三换算基准 */
glaa022       varchar2(10)      ,/* 本位币三汇率采用 */
glaa023       varchar2(1)      ,/* 次账套账务生成时机 */
glaa024       varchar2(5)      ,/* 单据别参照表号 */
glaa025       varchar2(10)      ,/* 本位币一汇率采用 */
glaa026       varchar2(5)      ,/* 币种参照表号 */
glaa100       varchar2(1)      ,/* 凭证录入时自动按缺号生成 */
glaa101       varchar2(1)      ,/* 凭证总号录入时机 */
glaa102       varchar2(1)      ,/* 凭证成立时,借贷不平衡的处理方式 */
glaa103       varchar2(1)      ,/* 未打印的凭证可否进行过账 */
glaa111       varchar2(5)      ,/* 应计调整单别 */
glaa112       varchar2(5)      ,/* 期末结转单别 */
glaa113       varchar2(5)      ,/* 年底结转单别 */
glaa120       varchar2(10)      ,/* 成本计算类型 */
glaa121       varchar2(1)      ,/* 子模块启用分录底稿 */
glaa122       varchar2(1)      ,/* 总账可维护资金异动明细 */
glaa027       varchar2(5)      ,/* 单据据点编号 */
glaa130       varchar2(1)      ,/* 合并账套否 */
glaa131       varchar2(1)      ,/* 分层合并 */
glaa132       varchar2(1)      ,/* 平均汇率计算方式 */
glaa133       varchar2(1)      ,/* 非T100公司导入余额类型 */
glaa134       varchar2(10)      ,/* 合并科目转换依据异动码设置值 */
glaa135       varchar2(5)      ,/* 现流表间接法群组参照表号 */
glaa136       varchar2(1)      ,/* 应收账款核销限定己立账凭证 */
glaa137       varchar2(1)      ,/* 应付账款核销限定已立账凭证 */
glaa138       varchar2(1)      ,/* 合并报表编制期别 */
glaa139       varchar2(1)      ,/* 递延收入(负债)管理生成否 */
glaa140       varchar2(1)      ,/* 无原出货单的递延负债减项者,是否仍立递延收入管理? */
glaa123       varchar2(1)      ,/* 应收帐款核销可维护资金异动明细 */
glaa124       varchar2(1)      ,/* 应付帐款核销可维护资金异动明细 */
glaa028       varchar2(1)      /* 汇率来源 */
);
alter table glaa_t add constraint glaa_pk primary key (glaaent,glaald) enable validate;

create unique index glaa_pk on glaa_t (glaaent,glaald);

grant select on glaa_t to tiptop;
grant update on glaa_t to tiptop;
grant delete on glaa_t to tiptop;
grant insert on glaa_t to tiptop;

exit;
