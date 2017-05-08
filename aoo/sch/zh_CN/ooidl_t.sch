/* 
================================================================================
檔案代號:ooidl_t
檔案名稱:繳款優惠條件設定檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table ooidl_t
(
ooidlent       number(5)      ,/* 企業編號 */
ooidl001       varchar2(10)      ,/* 優惠條件編號 */
ooidl002       varchar2(6)      ,/* 語言別 */
ooidl003       varchar2(500)      ,/* 說明 */
ooidl004       varchar2(10)      /* 助記碼 */
);
alter table ooidl_t add constraint ooidl_pk primary key (ooidlent,ooidl001,ooidl002) enable validate;

create unique index ooidl_pk on ooidl_t (ooidlent,ooidl001,ooidl002);

grant select on ooidl_t to tiptop;
grant update on ooidl_t to tiptop;
grant delete on ooidl_t to tiptop;
grant insert on ooidl_t to tiptop;

exit;
