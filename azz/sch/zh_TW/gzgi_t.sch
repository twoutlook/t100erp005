/* 
================================================================================
檔案代號:gzgi_t
檔案名稱:紙張格式基本資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table gzgi_t
(
gzgi001       varchar2(100)      ,/* 紙張格式名稱 */
gzgi002       varchar2(1)      ,/* 客製 */
gzgi003       varchar2(100)      ,/* 紙張格式說明 */
gzgi004       number(15,3)      ,/* 紙張寬度 */
gzgi005       number(15,3)      ,/* 紙張高度 */
gzgi006       varchar2(1)      ,/* 紙張單位 */
gzgi007       varchar2(1)      /* 指定列印方向 */
);
alter table gzgi_t add constraint gzgi_pk primary key (gzgi001,gzgi002) enable validate;

create unique index gzgi_pk on gzgi_t (gzgi001,gzgi002);

grant select on gzgi_t to tiptop;
grant update on gzgi_t to tiptop;
grant delete on gzgi_t to tiptop;
grant insert on gzgi_t to tiptop;

exit;
