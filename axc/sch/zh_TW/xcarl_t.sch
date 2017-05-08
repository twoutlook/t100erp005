/* 
================================================================================
檔案代號:xcarl_t
檔案名稱:標準成本分類多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:Y
============.========================.==========================================
 */
create table xcarl_t
(
xcarlent       number(5)      ,/* 企業編號 */
xcarlld       varchar2(5)      ,/* 帳別編號 */
xcarl001       varchar2(10)      ,/* 科目大類 */
xcarl002       varchar2(6)      ,/* 語言別 */
xcarl003       varchar2(500)      ,/* 標準成本分類說明 */
xcarl004       varchar2(10)      /* 助記碼 */
);
alter table xcarl_t add constraint xcarl_pk primary key (xcarlent,xcarlld,xcarl001,xcarl002) enable validate;

create unique index xcarl_pk on xcarl_t (xcarlent,xcarlld,xcarl001,xcarl002);

grant select on xcarl_t to tiptop;
grant update on xcarl_t to tiptop;
grant delete on xcarl_t to tiptop;
grant insert on xcarl_t to tiptop;

exit;
