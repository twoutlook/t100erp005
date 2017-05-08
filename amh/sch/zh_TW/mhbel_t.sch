/* 
================================================================================
檔案代號:mhbel_t
檔案名稱:鋪位資料主檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table mhbel_t
(
mhbelent       number(5)      ,/* 企業編號 */
mhbel001       varchar2(20)      ,/* 鋪位編號 */
mhbel002       varchar2(6)      ,/* 語言別 */
mhbel003       varchar2(500)      ,/* 說明 */
mhbel004       varchar2(10)      /* 助記碼 */
);
alter table mhbel_t add constraint mhbel_pk primary key (mhbelent,mhbel001,mhbel002) enable validate;

create unique index mhbel_pk on mhbel_t (mhbelent,mhbel001,mhbel002);

grant select on mhbel_t to tiptop;
grant update on mhbel_t to tiptop;
grant delete on mhbel_t to tiptop;
grant insert on mhbel_t to tiptop;

exit;
