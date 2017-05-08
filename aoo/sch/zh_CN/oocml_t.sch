/* 
================================================================================
檔案代號:oocml_t
檔案名稱:行政地區多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table oocml_t
(
oocmlent       number(5)      ,/* 企業編號 */
oocml001       varchar2(10)      ,/* 國家地區編號 */
oocml002       varchar2(10)      ,/* 州省編號 */
oocml003       varchar2(10)      ,/* 縣市編號 */
oocml004       varchar2(10)      ,/* 行政地區編號 */
oocml005       varchar2(6)      ,/* 語言別 */
oocml006       varchar2(500)      ,/* 說明 */
oocml007       varchar2(10)      /* 助記碼 */
);
alter table oocml_t add constraint oocml_pk primary key (oocmlent,oocml001,oocml002,oocml003,oocml004,oocml005) enable validate;

create  index oocml_01 on oocml_t (oocml007);
create unique index oocml_pk on oocml_t (oocmlent,oocml001,oocml002,oocml003,oocml004,oocml005);

grant select on oocml_t to tiptop;
grant update on oocml_t to tiptop;
grant delete on oocml_t to tiptop;
grant insert on oocml_t to tiptop;

exit;
