/* 
================================================================================
檔案代號:debt_t
檔案名稱:門店管理品類會員消費日結檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:Y
============.========================.==========================================
 */
create table debt_t
(
debtent       number(5)      ,/* 企業編號 */
debtsite       varchar2(10)      ,/* 營運據點 */
debt001       varchar2(10)      ,/* 層級類型 */
debt002       date      ,/* 統計日期 */
debt003       number(5,0)      ,/* 會計週 */
debt004       number(5,0)      ,/* 會計期 */
debt005       varchar2(10)      ,/* 品類編號 */
debt006       varchar2(20)      ,/* 品牌 */
debt007       varchar2(10)      ,/* 主供應商 */
debt008       varchar2(10)      ,/* 結算方式 */
debt009       varchar2(10)      ,/* 稅別編號 */
debt010       varchar2(10)      ,/* 會員卡種 */
debt011       varchar2(10)      ,/* 會員等級 */
debt012       number(20,6)      ,/* 銷售數量 */
debt013       number(20,6)      ,/* 銷售成本 */
debt014       number(20,6)      ,/* 進價金額 */
debt015       number(20,6)      ,/* 原價金額 */
debt016       number(20,6)      ,/* 未稅金額 */
debt017       number(20,6)      ,/* 應收金額 */
debt018       number(20,6)      ,/* 毛利 */
debt019       number(20,6)      ,/* 毛利率 */
debt020       number(22,2)      ,/* 會員積分 */
debt021       number(20,6)      ,/* 客單數 */
debt022       number(20,6)      ,/* 抵扣券金額 */
debt023       number(20,6)      ,/* 會員折扣金額 */
debt024       number(20,6)      ,/* 實收金額 */
debt025       number(20,6)      ,/* 客單價 */
debt026       varchar2(1)      /* 日結類型 */
);
alter table debt_t add constraint debt_pk primary key (debtent,debtsite,debt002,debt005,debt006,debt007,debt008,debt009,debt010,debt011,debt026) enable validate;

create unique index debt_pk on debt_t (debtent,debtsite,debt002,debt005,debt006,debt007,debt008,debt009,debt010,debt011,debt026);

grant select on debt_t to tiptop;
grant update on debt_t to tiptop;
grant delete on debt_t to tiptop;
grant insert on debt_t to tiptop;

exit;
