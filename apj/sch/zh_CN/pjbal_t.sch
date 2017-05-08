/* 
================================================================================
檔案代號:pjbal_t
檔案名稱:專案資料單頭檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table pjbal_t
(
pjbalent       number(5)      ,/* 企業編號 */
pjbal001       varchar2(20)      ,/* 專案編號 */
pjbal002       varchar2(6)      ,/* 語言別 */
pjbal003       varchar2(500)      ,/* 說明 */
pjbal004       varchar2(10)      /* 助記碼 */
);
alter table pjbal_t add constraint pjbal_pk primary key (pjbalent,pjbal001,pjbal002) enable validate;

create  index pjbal_01 on pjbal_t (pjbal004);
create unique index pjbal_pk on pjbal_t (pjbalent,pjbal001,pjbal002);

grant select on pjbal_t to tiptop;
grant update on pjbal_t to tiptop;
grant delete on pjbal_t to tiptop;
grant insert on pjbal_t to tiptop;

exit;
