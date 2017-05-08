/* 
================================================================================
檔案代號:xradl_t
檔案名稱:帳齡類型設定主檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table xradl_t
(
xradlent       number(5)      ,/* 企業編號 */
xradl001       varchar2(10)      ,/* 帳齡類型編號 */
xradl002       varchar2(6)      ,/* 語言別 */
xradl003       varchar2(500)      ,/* 說明 */
xradl004       varchar2(10)      /* 助記碼 */
);
alter table xradl_t add constraint xradl_pk primary key (xradlent,xradl001,xradl002) enable validate;

create unique index xradl_pk on xradl_t (xradlent,xradl001,xradl002);

grant select on xradl_t to tiptop;
grant update on xradl_t to tiptop;
grant delete on xradl_t to tiptop;
grant insert on xradl_t to tiptop;

exit;
