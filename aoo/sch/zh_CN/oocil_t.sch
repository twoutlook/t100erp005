/* 
================================================================================
檔案代號:oocil_t
檔案名稱:州省檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table oocil_t
(
oocilent       number(5)      ,/* 企業編號 */
oocil001       varchar2(10)      ,/* 所在國家 */
oocil002       varchar2(10)      ,/* 州省編號 */
oocil003       varchar2(6)      ,/* 語言別 */
oocil004       varchar2(500)      ,/* 說明 */
oocil005       varchar2(10)      ,/* 助記碼 */
oocil006       varchar2(10)      /* 簡稱 */
);
alter table oocil_t add constraint oocil_pk primary key (oocilent,oocil001,oocil002,oocil003) enable validate;

create  index oocil_01 on oocil_t (oocil005);
create unique index oocil_pk on oocil_t (oocilent,oocil001,oocil002,oocil003);

grant select on oocil_t to tiptop;
grant update on oocil_t to tiptop;
grant delete on oocil_t to tiptop;
grant insert on oocil_t to tiptop;

exit;
