/* 
================================================================================
檔案代號:decc_t
檔案名稱:会员日结档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:Y
============.========================.==========================================
 */
create table decc_t
(
deccent       number(5)      ,/* 企业编号 */
decc001       varchar2(30)      ,/* 会员编号 */
decc002       date      ,/* 统计日期 */
decc003       number(5,0)      ,/* 会计周 */
decc004       number(5,0)      ,/* 会计期 */
decc005       number(20,6)      ,/* 销售数量 */
decc006       number(20,6)      ,/* 销售成本 */
decc007       number(20,6)      ,/* 进价金额 */
decc008       number(20,6)      ,/* 原价金额 */
decc009       number(20,6)      ,/* 税前金额 */
decc010       number(20,6)      ,/* 应收金额 */
decc011       number(20,6)      ,/* 折扣金额 */
decc012       number(20,6)      ,/* 收银差额 */
decc013       number(20,6)      ,/* 实收金额 */
decc014       number(20,6)      ,/* 毛利 */
decc015       number(20,6)      ,/* 毛利率 */
decc016       number(20,6)      ,/* 客单数 */
decc017       number(20,6)      ,/* 退货金额 */
decc018       number(20,6)      ,/* 退货单据数 */
decc019       number(20,6)      ,/* 打折金额 */
decc020       number(20,6)      ,/* 变价金额 */
decc021       number(20,6)      ,/* 会员积分 */
decc022       number(20,6)      ,/* 客单价 */
decc023       varchar2(30)      ,/* 会员卡号 */
decc024       number(20,6)      /* 会员折扣金额 */
);
alter table decc_t add constraint decc_pk primary key (deccent,decc001,decc002,decc023) enable validate;

create unique index decc_pk on decc_t (deccent,decc001,decc002,decc023);

grant select on decc_t to tiptop;
grant update on decc_t to tiptop;
grant delete on decc_t to tiptop;
grant insert on decc_t to tiptop;

exit;
