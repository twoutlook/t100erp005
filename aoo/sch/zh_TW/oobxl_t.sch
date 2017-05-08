/* 
================================================================================
檔案代號:oobxl_t
檔案名稱:單據別設定檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table oobxl_t
(
oobxlent       number(5)      ,/* 企業編號 */
oobxl001       varchar2(5)      ,/* 單據別 */
oobxl002       varchar2(6)      ,/* 語言別 */
oobxl003       varchar2(500)      ,/* 說明 */
oobxl004       varchar2(10)      /* 助記碼 */
);
alter table oobxl_t add constraint oobxl_pk primary key (oobxlent,oobxl001,oobxl002) enable validate;

create unique index oobxl_pk on oobxl_t (oobxlent,oobxl001,oobxl002);

grant select on oobxl_t to tiptop;
grant update on oobxl_t to tiptop;
grant delete on oobxl_t to tiptop;
grant insert on oobxl_t to tiptop;

exit;
