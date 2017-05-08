/* 
================================================================================
檔案代號:pcall_t
檔案名稱:POS款別基本資料多語言表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:Y
============.========================.==========================================
 */
create table pcall_t
(
pcallent       number(5)      ,/* 企業編號 */
pcallsite       varchar2(10)      ,/* 營運據點 */
pcall001       varchar2(10)      ,/* POS款別 */
pcall002       varchar2(6)      ,/* 語言別 */
pcall003       varchar2(500)      ,/* 顯示說明 */
pcall004       varchar2(500)      ,/* 打印說明 */
pcall005       varchar2(10)      /* 助記碼 */
);
alter table pcall_t add constraint pcall_pk primary key (pcallent,pcallsite,pcall001,pcall002) enable validate;

create unique index pcall_pk on pcall_t (pcallent,pcallsite,pcall001,pcall002);

grant select on pcall_t to tiptop;
grant update on pcall_t to tiptop;
grant delete on pcall_t to tiptop;
grant insert on pcall_t to tiptop;

exit;
