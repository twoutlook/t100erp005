/* 
================================================================================
檔案代號:gztdl_t
檔案名稱:欄位屬性定義檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table gztdl_t
(
gztdl001       varchar2(4)      ,/* 欄位屬性編號 */
gztdl002       varchar2(6)      ,/* 語言別 */
gztdl003       varchar2(500)      ,/* 欄位簡稱 */
gztdl004       varchar2(500)      ,/* 說明 */
gztdl005       varchar2(10)      /* 助記碼 */
);
alter table gztdl_t add constraint gztdl_pk primary key (gztdl001,gztdl002) enable validate;

create unique index gztdl_pk on gztdl_t (gztdl001,gztdl002);

grant select on gztdl_t to tiptop;
grant update on gztdl_t to tiptop;
grant delete on gztdl_t to tiptop;
grant insert on gztdl_t to tiptop;

exit;
