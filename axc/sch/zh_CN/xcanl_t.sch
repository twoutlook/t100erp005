/* 
================================================================================
檔案代號:xcanl_t
檔案名稱:成本差異科目設定檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table xcanl_t
(
xcanlent       number(5)      ,/* 企業代碼 */
xcanlld       varchar2(5)      ,/* 帳別 */
xcanl001       varchar2(80)      ,/* 差異科目分類 */
xcanl002       varchar2(6)      ,/* 語言別 */
xcanl003       varchar2(500)      ,/* 說明 */
xcanl004       varchar2(10)      /* 助記碼 */
);
alter table xcanl_t add constraint xcanl_pk primary key (xcanlent,xcanlld,xcanl001,xcanl002) enable validate;

create unique index xcanl_pk on xcanl_t (xcanlent,xcanlld,xcanl001,xcanl002);

grant select on xcanl_t to tiptop;
grant update on xcanl_t to tiptop;
grant delete on xcanl_t to tiptop;
grant insert on xcanl_t to tiptop;

exit;
