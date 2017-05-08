/* 
================================================================================
檔案代號:staal_t
檔案名稱:結算方式基本資料檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table staal_t
(
staalent       number(5)      ,/* 企業編號 */
staal001       varchar2(10)      ,/* 結算方式編號 */
staal002       varchar2(6)      ,/* 語言別 */
staal003       varchar2(500)      ,/* 說明 */
staal004       varchar2(10)      /* 助記碼 */
);
alter table staal_t add constraint staal_pk primary key (staalent,staal001,staal002) enable validate;

create  index staal_01 on staal_t (staal004);
create unique index staal_pk on staal_t (staalent,staal001,staal002);

grant select on staal_t to tiptop;
grant update on staal_t to tiptop;
grant delete on staal_t to tiptop;
grant insert on staal_t to tiptop;

exit;
