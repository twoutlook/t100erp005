/* 
================================================================================
檔案代號:oocgl_t
檔案名稱:國家地區多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:Y
============.========================.==========================================
 */
create table oocgl_t
(
oocglent       number(5)      ,/* 企業編號 */
oocgl001       varchar2(10)      ,/* 國家地區編號 */
oocgl002       varchar2(6)      ,/* 語言別 */
oocgl003       varchar2(500)      ,/* 說明 */
oocgl004       varchar2(10)      /* 助記碼 */
);
alter table oocgl_t add constraint oocgl_pk primary key (oocglent,oocgl001,oocgl002) enable validate;

create  index oocgl_01 on oocgl_t (oocgl004);
create unique index oocgl_pk on oocgl_t (oocglent,oocgl001,oocgl002);

grant select on oocgl_t to tiptop;
grant update on oocgl_t to tiptop;
grant delete on oocgl_t to tiptop;
grant insert on oocgl_t to tiptop;

exit;
