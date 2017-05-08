/* 
================================================================================
檔案代號:xcdg_t
檔案名稱:聯產品成本次要素期異動統計檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table xcdg_t
(
xcdgent       number(5)      ,/* 企業編號 */
xcdgcomp       varchar2(10)      ,/* 法人組織 */
xcdgld       varchar2(5)      ,/* 賬套 */
xcdg001       varchar2(1)      ,/* 賬套本位幣順序 */
xcdg002       varchar2(30)      ,/* 成本域 */
xcdg003       varchar2(10)      ,/* 成本計算類型 */
xcdg004       number(5,0)      ,/* 年度 */
xcdg005       number(5,0)      ,/* 期別 */
xcdg006       varchar2(20)      ,/* 工單編號/在制代號 */
xcdg007       varchar2(40)      ,/* 聯產品料號 */
xcdg008       varchar2(256)      ,/* 特性 */
xcdg009       varchar2(30)      ,/* 批號 */
xcdg010       varchar2(10)      ,/* 次要素 */
xcdg020       varchar2(10)      ,/* 核算幣別 */
xcdg101       number(20,6)      ,/* 上期結存數量 */
xcdg102       number(20,6)      ,/* 上期結存金額 */
xcdg301       number(20,6)      ,/* 本期轉出數量 */
xcdg302       number(20,6)      ,/* 本期轉出金額 */
xcdg901       number(20,6)      ,/* 期末結存數量 */
xcdg902       number(20,6)      ,/* 期末結存金額 */
xcdgtime       timestamp(0)      /* 最近成本計算時間 */
);
alter table xcdg_t add constraint xcdg_pk primary key (xcdgent,xcdgld,xcdg001,xcdg002,xcdg003,xcdg004,xcdg005,xcdg006,xcdg007,xcdg008,xcdg009,xcdg010) enable validate;

create unique index xcdg_pk on xcdg_t (xcdgent,xcdgld,xcdg001,xcdg002,xcdg003,xcdg004,xcdg005,xcdg006,xcdg007,xcdg008,xcdg009,xcdg010);

grant select on xcdg_t to tiptop;
grant update on xcdg_t to tiptop;
grant delete on xcdg_t to tiptop;
grant insert on xcdg_t to tiptop;

exit;
