/* 
================================================================================
檔案代號:pson_t
檔案名稱:訂單每日產出檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:H
多語系檔案:N
============.========================.==========================================
 */
create table pson_t
(
psonent       number(5)      ,/* 企業編號 */
psonsite       varchar2(10)      ,/* 營運據點 */
pson001       varchar2(10)      ,/* APS版本 */
pson002       varchar2(20)      ,/* 執行日期時間 */
pson003       varchar2(40)      ,/* 訂單編號 */
pson004       date      ,/* 產出日 */
pson005       number(20,6)      /* 產出數量 */
);
alter table pson_t add constraint pson_pk primary key (psonent,psonsite,pson001,pson002,pson003,pson004) enable validate;

create unique index pson_pk on pson_t (psonent,psonsite,pson001,pson002,pson003,pson004);

grant select on pson_t to tiptop;
grant update on pson_t to tiptop;
grant delete on pson_t to tiptop;
grant insert on pson_t to tiptop;

exit;
