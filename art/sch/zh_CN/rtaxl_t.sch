/* 
================================================================================
檔案代號:rtaxl_t
檔案名稱:品類基本資料檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:Y
============.========================.==========================================
 */
create table rtaxl_t
(
rtaxlent       number(5)      ,/* 企業編號 */
rtaxl001       varchar2(10)      ,/* 品類編號 */
rtaxl002       varchar2(6)      ,/* 語言別 */
rtaxl003       varchar2(500)      ,/* 說明 */
rtaxl004       varchar2(10)      /* 助記碼 */
);
alter table rtaxl_t add constraint rtaxl_pk primary key (rtaxlent,rtaxl001,rtaxl002) enable validate;

create  index rtaxl_01 on rtaxl_t (rtaxl004);
create unique index rtaxl_pk on rtaxl_t (rtaxlent,rtaxl001,rtaxl002);

grant select on rtaxl_t to tiptop;
grant update on rtaxl_t to tiptop;
grant delete on rtaxl_t to tiptop;
grant insert on rtaxl_t to tiptop;

exit;
