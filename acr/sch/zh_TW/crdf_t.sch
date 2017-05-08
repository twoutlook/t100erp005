/* 
================================================================================
檔案代號:crdf_t
檔案名稱:精選會員異動紀錄檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table crdf_t
(
crdfent       number(5)      ,/* 企業編號 */
crdf001       varchar2(30)      ,/* 會員編號 */
crdf002       timestamp(0)      ,/* 異動日期 */
crdf003       varchar2(20)      ,/* 異動人員 */
crdf004       varchar2(10)      ,/* 異動屬性 */
crdf005       varchar2(10)      ,/* 異動屬性值 */
crdf006       varchar2(500)      ,/* INPUT條件 */
crdf007       varchar2(500)      /* QBE條件 */
);
alter table crdf_t add constraint crdf_pk primary key (crdfent,crdf001,crdf002) enable validate;

create unique index crdf_pk on crdf_t (crdfent,crdf001,crdf002);

grant select on crdf_t to tiptop;
grant update on crdf_t to tiptop;
grant delete on crdf_t to tiptop;
grant insert on crdf_t to tiptop;

exit;
