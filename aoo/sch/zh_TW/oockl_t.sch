/* 
================================================================================
檔案代號:oockl_t
檔案名稱:縣市多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table oockl_t
(
oocklent       number(5)      ,/* 企業編號 */
oockl001       varchar2(10)      ,/* 所在國家 */
oockl002       varchar2(10)      ,/* 州省編號 */
oockl003       varchar2(10)      ,/* 縣市編號 */
oockl004       varchar2(6)      ,/* 語言別 */
oockl005       varchar2(500)      ,/* 說明 */
oockl006       varchar2(10)      /* 助記碼 */
);
alter table oockl_t add constraint oockl_pk primary key (oocklent,oockl001,oockl002,oockl003,oockl004) enable validate;

create  index oockl_01 on oockl_t (oockl006);
create unique index oockl_pk on oockl_t (oocklent,oockl001,oockl002,oockl003,oockl004);

grant select on oockl_t to tiptop;
grant update on oockl_t to tiptop;
grant delete on oockl_t to tiptop;
grant insert on oockl_t to tiptop;

exit;
