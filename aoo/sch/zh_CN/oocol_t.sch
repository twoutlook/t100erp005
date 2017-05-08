/* 
================================================================================
檔案代號:oocol_t
檔案名稱:街道資料主檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table oocol_t
(
oocolent       number(5)      ,/* 企業代碼 */
oocol001       varchar2(10)      ,/* 國家地區編號 */
oocol002       varchar2(10)      ,/* 州省編號 */
oocol003       varchar2(10)      ,/* 縣市編號 */
oocol004       varchar2(10)      ,/* 行政地區編號 */
oocol005       varchar2(10)      ,/* 街道編號 */
oocol006       varchar2(6)      ,/* 語言別 */
oocol007       varchar2(500)      ,/* 說明 */
oocol008       varchar2(10)      /* 助記碼 */
);
alter table oocol_t add constraint oocol_pk primary key (oocolent,oocol001,oocol002,oocol003,oocol004,oocol005,oocol006) enable validate;

create unique index oocol_pk on oocol_t (oocolent,oocol001,oocol002,oocol003,oocol004,oocol005,oocol006);

grant select on oocol_t to tiptop;
grant update on oocol_t to tiptop;
grant delete on oocol_t to tiptop;
grant insert on oocol_t to tiptop;

exit;
