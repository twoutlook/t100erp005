/* 
================================================================================
檔案代號:gztb_t
檔案名稱: 
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table gztb_t
(
gztb001       varchar2(15)      ,/* 表格編號 */
gztb002       varchar2(20)      ,/* 欄位編號 */
gztb003       varchar2(4)      ,/* 資料欄位屬性 */
gztb004       varchar2(80)      /* 值域說明 */
);
alter table gztb_t add constraint gztb_pk primary key (gztb001,gztb002) enable validate;

create unique index gztb_01 on gztb_t (gztb002);

grant select on gztb_t to tiptop;
grant update on gztb_t to tiptop;
grant delete on gztb_t to tiptop;
grant insert on gztb_t to tiptop;

exit;
