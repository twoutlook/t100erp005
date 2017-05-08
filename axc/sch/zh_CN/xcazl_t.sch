/* 
================================================================================
檔案代號:xcazl_t
檔案名稱:成本類型計算參數多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table xcazl_t
(
xcazlent       number(5)      ,/* 企業編號 */
xcazlld       varchar2(5)      ,/* 帳套編號 */
xcazl001       varchar2(10)      ,/* 成本類型 */
xcazl002       varchar2(6)      ,/* 語言別 */
xcazl003       varchar2(500)      ,/* 說明 */
xcazl004       varchar2(10)      /* 助記碼 */
);
alter table xcazl_t add constraint xcazl_pk primary key (xcazlent,xcazlld,xcazl001,xcazl002) enable validate;

create unique index xcazl_pk on xcazl_t (xcazlent,xcazlld,xcazl001,xcazl002);

grant select on xcazl_t to tiptop;
grant update on xcazl_t to tiptop;
grant delete on xcazl_t to tiptop;
grant insert on xcazl_t to tiptop;

exit;
