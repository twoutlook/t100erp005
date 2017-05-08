/* 
================================================================================
檔案代號:pjbnl_t
檔案名稱:專案資料變更單頭檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table pjbnl_t
(
pjbnlent       number(5)      ,/* 企業編號 */
pjbnl001       varchar2(20)      ,/* 專案編號 */
pjbnl900       number(10,0)      ,/* 變更序 */
pjbnl002       varchar2(6)      ,/* 語言別 */
pjbnl003       varchar2(500)      ,/* 說明 */
pjbnl004       varchar2(10)      ,/* 助記碼 */
pjbnl901       varchar2(1)      /* 變更類型 */
);
alter table pjbnl_t add constraint pjbnl_pk primary key (pjbnlent,pjbnl001,pjbnl900,pjbnl002) enable validate;

create unique index pjbnl_pk on pjbnl_t (pjbnlent,pjbnl001,pjbnl900,pjbnl002);

grant select on pjbnl_t to tiptop;
grant update on pjbnl_t to tiptop;
grant delete on pjbnl_t to tiptop;
grant insert on pjbnl_t to tiptop;

exit;
