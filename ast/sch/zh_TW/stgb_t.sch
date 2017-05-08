/* 
================================================================================
檔案代號:stgb_t
檔案名稱:专柜每日销售成本明细档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table stgb_t
(
stgbent       number(5)      ,/* 企业编号 */
stgbsite       varchar2(10)      ,/* 营运组织 */
stgb001       date      ,/* 销售日期 */
stgb002       varchar2(20)      ,/* 专柜/铺位编号 */
stgb003       varchar2(10)      ,/* 供应商编号 */
stgb004       varchar2(10)      ,/* 费用编号 */
stgb005       number(20,6)      ,/* 直接实收金额 */
stgb006       number(20,6)      ,/* 间接实收金额 */
stgb007       number(20,6)      ,/* 实收金额 */
stgb008       number(15,3)      ,/* 费率 */
stgb009       number(20,6)      ,/* 费用金额 */
stgb010       varchar2(10)      ,/* 价款类型 */
stgb011       varchar2(1)      ,/* 已结转否 */
stgbunit       varchar2(10)      ,/* 应用组织 */
stgb012       varchar2(10)      ,/* 经营方式 */
stgb013       varchar2(20)      ,/* 合同编号 */
stgb014       number(20,6)      /* 储值折扣金额 */
);
alter table stgb_t add constraint stgb_pk primary key (stgbent,stgbsite,stgb001,stgb002,stgb004,stgb013) enable validate;

create unique index stgb_pk on stgb_t (stgbent,stgbsite,stgb001,stgb002,stgb004,stgb013);

grant select on stgb_t to tiptop;
grant update on stgb_t to tiptop;
grant delete on stgb_t to tiptop;
grant insert on stgb_t to tiptop;

exit;
