/* 
================================================================================
檔案代號:xcavl_t
檔案名稱:成本次要素分類檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table xcavl_t
(
xcavlent       number(5)      ,/* 企業編號 */
xcavl001       varchar2(10)      ,/* 成本次要素分類編號 */
xcavl002       varchar2(6)      ,/* 語言別 */
xcavl003       varchar2(500)      ,/* 說明 */
xcavl004       varchar2(10)      /* 助記碼 */
);
alter table xcavl_t add constraint xcavl_pk primary key (xcavlent,xcavl001,xcavl002) enable validate;

create unique index xcavl_pk on xcavl_t (xcavlent,xcavl001,xcavl002);

grant select on xcavl_t to tiptop;
grant update on xcavl_t to tiptop;
grant delete on xcavl_t to tiptop;
grant insert on xcavl_t to tiptop;

exit;
