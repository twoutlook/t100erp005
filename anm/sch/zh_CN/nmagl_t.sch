/* 
================================================================================
檔案代號:nmagl_t
檔案名稱:銀行帳戶類型設置檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table nmagl_t
(
nmaglent       number(5)      ,/* 企業編號 */
nmagl001       varchar2(10)      ,/* 帳戶類型編碼 */
nmagl002       varchar2(6)      ,/* 語言別 */
nmagl003       varchar2(500)      /* 說明 */
);
alter table nmagl_t add constraint nmagl_pk primary key (nmaglent,nmagl001,nmagl002) enable validate;

create unique index nmagl_pk on nmagl_t (nmaglent,nmagl001,nmagl002);

grant select on nmagl_t to tiptop;
grant update on nmagl_t to tiptop;
grant delete on nmagl_t to tiptop;
grant insert on nmagl_t to tiptop;

exit;
