/* 
================================================================================
檔案代號:imegl_t
檔案名稱:規則化規格設定資料檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table imegl_t
(
imeglent       number(5)      ,/* 企業編號 */
imegl001       varchar2(10)      ,/* 規格種類 */
imegl002       varchar2(10)      ,/* 節點編號 */
imegl003       varchar2(6)      ,/* 語言別 */
imegl004       varchar2(500)      ,/* 說明 */
imegl005       varchar2(10)      /* 助記碼 */
);
alter table imegl_t add constraint imegl_pk primary key (imeglent,imegl001,imegl002,imegl003) enable validate;

create unique index imegl_pk on imegl_t (imeglent,imegl001,imegl002,imegl003);

grant select on imegl_t to tiptop;
grant update on imegl_t to tiptop;
grant delete on imegl_t to tiptop;
grant insert on imegl_t to tiptop;

exit;
