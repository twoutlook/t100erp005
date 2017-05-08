/* 
================================================================================
檔案代號:dedm_t
檔案名稱:門店部門會員消費統計月結檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table dedm_t
(
dedment       number(5)      ,/* 企業編號 */
dedmsite       varchar2(10)      ,/* 營運據點 */
dedm001       varchar2(10)      ,/* 層級類型 */
dedm005       varchar2(10)      ,/* 部門編號 */
dedm006       varchar2(10)      ,/* 會員卡種 */
dedm007       varchar2(10)      ,/* 會員等級 */
dedm008       number(20,6)      ,/* 銷售數量 */
dedm009       number(20,6)      ,/* 銷售成本 */
dedm010       number(20,6)      ,/* 進價金額 */
dedm011       number(20,6)      ,/* 原價金額 */
dedm012       number(20,6)      ,/* 未稅金額 */
dedm013       number(20,6)      ,/* 應收金額 */
dedm014       number(20,6)      ,/* 毛利 */
dedm015       number(20,6)      ,/* 毛利率 */
dedm016       number(22,2)      ,/* 會員積分 */
dedm017       number(20,6)      ,/* 客單數 */
dedm018       number(20,6)      ,/* 抵扣券金額 */
dedm019       number(20,6)      ,/* 會員折扣金額 */
dedm020       number(20,6)      ,/* 實收金額 */
dedm021       number(5,0)      ,/* 統計年度 */
dedm022       number(5,0)      /* 統計月份 */
);
alter table dedm_t add constraint dedm_pk primary key (dedment,dedmsite,dedm005,dedm006,dedm007,dedm021,dedm022) enable validate;

create unique index dedm_pk on dedm_t (dedment,dedmsite,dedm005,dedm006,dedm007,dedm021,dedm022);

grant select on dedm_t to tiptop;
grant update on dedm_t to tiptop;
grant delete on dedm_t to tiptop;
grant insert on dedm_t to tiptop;

exit;
