/* 
================================================================================
檔案代號:gcafl_t
檔案名稱:券種基本資料檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table gcafl_t
(
gcaflent       number(5)      ,/* 企業編號 */
gcafl001       varchar2(10)      ,/* 券種編號 */
gcafl002       varchar2(6)      ,/* 語言別 */
gcafl003       varchar2(500)      ,/* 說明 */
gcafl004       varchar2(10)      /* 助記碼 */
);
alter table gcafl_t add constraint gcafl_pk primary key (gcaflent,gcafl001,gcafl002) enable validate;

create unique index gcafl_pk on gcafl_t (gcaflent,gcafl001,gcafl002);

grant select on gcafl_t to tiptop;
grant update on gcafl_t to tiptop;
grant delete on gcafl_t to tiptop;
grant insert on gcafl_t to tiptop;

exit;
