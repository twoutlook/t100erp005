/* 
================================================================================
檔案代號:stagl_t
檔案名稱:自營合約模板主檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table stagl_t
(
staglent       number(5)      ,/* 企業編號 */
stagl001       varchar2(10)      ,/* 模板編號 */
stagl002       varchar2(6)      ,/* 語言別 */
stagl003       varchar2(500)      ,/* 說明 */
stagl004       varchar2(10)      /* 助記碼 */
);
alter table stagl_t add constraint stagl_pk primary key (staglent,stagl001,stagl002) enable validate;

create unique index stagl_pk on stagl_t (staglent,stagl001,stagl002);

grant select on stagl_t to tiptop;
grant update on stagl_t to tiptop;
grant delete on stagl_t to tiptop;
grant insert on stagl_t to tiptop;

exit;
