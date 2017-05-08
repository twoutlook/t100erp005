/* 
================================================================================
檔案代號:decb_t
檔案名稱:会员门店日结档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:Y
============.========================.==========================================
 */
create table decb_t
(
decbent       number(5)      ,/* 企业编号 */
decbsite       varchar2(10)      ,/* 营运据点 */
decb001       varchar2(10)      ,/* 层级类型 */
decb002       date      ,/* 统计日期 */
decb003       number(5,0)      ,/* 会计周 */
decb004       number(5,0)      ,/* 会计期 */
decb005       varchar2(30)      ,/* 会员编号 */
decb006       varchar2(10)      ,/* 会员等级 */
decb007       number(20,6)      ,/* 销售数量 */
decb008       number(20,6)      ,/* 销售成本 */
decb009       number(20,6)      ,/* 进价金额 */
decb010       number(20,6)      ,/* 原价金额 */
decb011       number(20,6)      ,/* 税前金额 */
decb012       number(20,6)      ,/* 应收金额 */
decb013       number(20,6)      ,/* 毛利 */
decb014       number(20,6)      ,/* 毛利率 */
decb015       number(22,2)      ,/* 会员积分 */
decb016       number(20,6)      ,/* 客单数 */
decb017       number(20,6)      ,/* 退货金额 */
decb018       number(20,6)      ,/* 退货单据数 */
decb019       number(20,6)      ,/* 客单价 */
decb020       varchar2(30)      ,/* 会员卡号 */
decb021       number(20,6)      ,/* 会员折扣金额 */
decb022       number(20,6)      /* 打折金额 */
);
alter table decb_t add constraint decb_pk primary key (decbent,decbsite,decb002,decb005,decb006,decb020) enable validate;

create unique index decb_pk on decb_t (decbent,decbsite,decb002,decb005,decb006,decb020);

grant select on decb_t to tiptop;
grant update on decb_t to tiptop;
grant delete on decb_t to tiptop;
grant insert on decb_t to tiptop;

exit;
