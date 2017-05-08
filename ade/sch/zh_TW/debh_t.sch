/* 
================================================================================
檔案代號:debh_t
檔案名稱:門店專櫃會員消費統計日結檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:Y
============.========================.==========================================
 */
create table debh_t
(
debhent       number(5)      ,/* 企業編號 */
debhsite       varchar2(10)      ,/* 營運據點 */
debh001       varchar2(10)      ,/* 層級類別 */
debh002       date      ,/* 統計日期 */
debh003       number(5,0)      ,/* 會計週 */
debh004       number(5,0)      ,/* 會計期 */
debh005       varchar2(20)      ,/* 專櫃編號 */
debh006       varchar2(10)      ,/* 品類編號 */
debh007       varchar2(10)      ,/* 稅別編號 */
debh008       varchar2(10)      ,/* 會員卡種 */
debh009       varchar2(10)      ,/* 會員等級 */
debh010       number(20,6)      ,/* 銷售數量 */
debh011       number(20,6)      ,/* 銷售成本 */
debh012       number(20,6)      ,/* 進價金額 */
debh013       number(20,6)      ,/* 原價金額 */
debh014       number(20,6)      ,/* 未稅金額 */
debh015       number(20,6)      ,/* 應收金額 */
debh016       number(20,6)      ,/* 毛利 */
debh017       number(20,6)      ,/* 毛利率 */
debh018       number(22,2)      ,/* 會員積分 */
debh019       number(20,6)      ,/* 客單數 */
debh020       number(20,6)      ,/* 抵扣券金額 */
debh021       number(20,6)      ,/* 會員折扣金額 */
debh022       number(20,6)      /* 實收金額 */
);
alter table debh_t add constraint debh_pk primary key (debhent,debhsite,debh002,debh005,debh006,debh007,debh008,debh009) enable validate;

create unique index debh_pk on debh_t (debhent,debhsite,debh002,debh005,debh006,debh007,debh008,debh009);

grant select on debh_t to tiptop;
grant update on debh_t to tiptop;
grant delete on debh_t to tiptop;
grant insert on debh_t to tiptop;

exit;
