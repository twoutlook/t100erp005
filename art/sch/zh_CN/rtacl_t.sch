/* 
================================================================================
檔案代號:rtacl_t
檔案名稱:品類策略主檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table rtacl_t
(
rtaclent       number(5)      ,/* 企業編號 */
rtacl001       varchar2(10)      ,/* 策略編號 */
rtacl002       varchar2(6)      ,/* 語言別 */
rtacl003       varchar2(500)      ,/* 說明 */
rtacl004       varchar2(10)      /* 助記碼 */
);
alter table rtacl_t add constraint rtacl_pk primary key (rtaclent,rtacl001,rtacl002) enable validate;

create  index rtacl_01 on rtacl_t (rtacl004);
create unique index rtacl_pk on rtacl_t (rtaclent,rtacl001,rtacl002);

grant select on rtacl_t to tiptop;
grant update on rtacl_t to tiptop;
grant delete on rtacl_t to tiptop;
grant insert on rtacl_t to tiptop;

exit;
