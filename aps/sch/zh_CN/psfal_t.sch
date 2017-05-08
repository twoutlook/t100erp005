/* 
================================================================================
檔案代號:psfal_t
檔案名稱:集團MRP版本單頭檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table psfal_t
(
psfalent       number(5)      ,/* 企業編號 */
psfal001       varchar2(10)      ,/* 集團MRP版本 */
psfal002       varchar2(6)      ,/* 語言別 */
psfal003       varchar2(500)      ,/* 說明 */
psfal004       varchar2(10)      /* 助記碼 */
);
alter table psfal_t add constraint psfal_pk primary key (psfalent,psfal001,psfal002) enable validate;

create unique index psfal_pk on psfal_t (psfalent,psfal001,psfal002);

grant select on psfal_t to tiptop;
grant update on psfal_t to tiptop;
grant delete on psfal_t to tiptop;
grant insert on psfal_t to tiptop;

exit;
