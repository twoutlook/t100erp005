/* 
================================================================================
檔案代號:ooeal_t
檔案名稱:組織基本資料檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table ooeal_t
(
ooealent       number(5)      ,/* 企業編號 */
ooeal001       varchar2(10)      ,/* 組織編號 */
ooeal002       varchar2(6)      ,/* 語言別 */
ooeal003       varchar2(500)      ,/* 說明(簡稱) */
ooeal004       varchar2(500)      ,/* 說明(對內全稱) */
ooeal005       varchar2(500)      ,/* 說明(對外全稱) */
ooeal006       varchar2(10)      /* 助記碼 */
);
alter table ooeal_t add constraint ooeal_pk primary key (ooealent,ooeal001,ooeal002) enable validate;

create  index ooeal_01 on ooeal_t (ooeal005);
create unique index ooeal_pk on ooeal_t (ooealent,ooeal001,ooeal002);

grant select on ooeal_t to tiptop;
grant update on ooeal_t to tiptop;
grant delete on ooeal_t to tiptop;
grant insert on ooeal_t to tiptop;

exit;
