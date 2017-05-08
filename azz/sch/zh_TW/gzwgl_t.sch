/* 
================================================================================
檔案代號:gzwgl_t
檔案名稱:服務人員多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:Y
============.========================.==========================================
 */
create table gzwgl_t
(
gzwglent       number(5)      ,/* 企業代碼 */
gzwgl001       varchar2(10)      ,/* 營運據點 */
gzwgl002       varchar2(20)      ,/* 服務人員 */
gzwgl003       varchar2(6)      ,/* 語言別 */
gzwgl004       varchar2(80)      /* 服務類型說明 */
);
alter table gzwgl_t add constraint gzwgl_pk primary key (gzwglent,gzwgl001,gzwgl002,gzwgl003) enable validate;

create unique index gzwgl_pk on gzwgl_t (gzwglent,gzwgl001,gzwgl002,gzwgl003);

grant select on gzwgl_t to tiptop;
grant update on gzwgl_t to tiptop;
grant delete on gzwgl_t to tiptop;
grant insert on gzwgl_t to tiptop;

exit;
