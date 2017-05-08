/* 
================================================================================
檔案代號:oocql_t
檔案名稱:應用分類碼多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:Y
============.========================.==========================================
 */
create table oocql_t
(
oocqlent       number(5)      ,/* 企業編號 */
oocql001       number(5)      ,/* 應用分類 */
oocql002       varchar2(10)      ,/* 應用分類碼 */
oocql003       varchar2(6)      ,/* 語言別 */
oocql004       varchar2(500)      ,/* 說明 */
oocql005       varchar2(10)      /* 助記碼 */
);
alter table oocql_t add constraint oocql_pk primary key (oocqlent,oocql001,oocql002,oocql003) enable validate;

create  index oocql_01 on oocql_t (oocql005);
create unique index oocql_pk on oocql_t (oocqlent,oocql001,oocql002,oocql003);

grant select on oocql_t to tiptop;
grant update on oocql_t to tiptop;
grant delete on oocql_t to tiptop;
grant insert on oocql_t to tiptop;

exit;
