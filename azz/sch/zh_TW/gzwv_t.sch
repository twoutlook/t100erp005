/* 
================================================================================
檔案代號:gzwv_t
檔案名稱:Genero 指令說明
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table gzwv_t
(
gzwv001       varchar2(40)      ,/* genero 指令 */
gzwv002       varchar2(6)      ,/* 語言別 */
gzwv003       varchar2(20)      ,/* 其他欄位 */
gzwv004       varchar2(500)      /* 說明 */
);
alter table gzwv_t add constraint gzwv_pk primary key (gzwv001,gzwv002) enable validate;

create unique index gzwv_pk on gzwv_t (gzwv001,gzwv002);

grant select on gzwv_t to tiptop;
grant update on gzwv_t to tiptop;
grant delete on gzwv_t to tiptop;
grant insert on gzwv_t to tiptop;

exit;
