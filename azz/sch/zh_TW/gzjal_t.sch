/* 
================================================================================
檔案代號:gzjal_t
檔案名稱:服務名稱多語言記錄表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:Y
============.========================.==========================================
 */
create table gzjal_t
(
gzjal001       varchar2(40)      ,/* 服務規格編號 */
gzjal002       varchar2(6)      ,/* 語言別 */
gzjal003       varchar2(500)      ,/* 服務名稱 */
gzjal004       varchar2(10)      /* 助記碼 */
);
alter table gzjal_t add constraint gzjal_pk primary key (gzjal001,gzjal002) enable validate;

create unique index gzjal_pk on gzjal_t (gzjal001,gzjal002);

grant select on gzjal_t to tiptop;
grant update on gzjal_t to tiptop;
grant delete on gzjal_t to tiptop;
grant insert on gzjal_t to tiptop;

exit;
