/* 
================================================================================
檔案代號:inpq_t
檔案名稱:存貨週轉率期間統計檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table inpq_t
(
inpqent       number(5)      ,/* 企業編號 */
inpqsite       varchar2(10)      ,/* 營運據點 */
inpq000       varchar2(1)      ,/* 計算類別 */
inpq001       varchar2(40)      ,/* 存貨編號 */
inpq002       number(5,0)      ,/* 目前年度 */
inpq003       number(5,0)      ,/* 目前期別 */
inpq004       varchar2(1)      ,/* 計算區間 */
inpq005       varchar2(10)      ,/* 版本 */
inpq006       varchar2(10)      ,/* 計算原則編號 */
inpq007       number(20,6)      ,/* 存貨週轉率 */
inpq008       number(15,3)      ,/* 存貨周轉天數 */
inpq009       number(20,6)      ,/* 銷貨成本 */
inpq010       number(20,6)      ,/* 平均存貨 */
inpq011       number(20,6)      /* 在製金額 */
);
alter table inpq_t add constraint inpq_pk primary key (inpqent,inpqsite,inpq001,inpq002,inpq003,inpq005) enable validate;

create unique index inpq_pk on inpq_t (inpqent,inpqsite,inpq001,inpq002,inpq003,inpq005);

grant select on inpq_t to tiptop;
grant update on inpq_t to tiptop;
grant delete on inpq_t to tiptop;
grant insert on inpq_t to tiptop;

exit;
