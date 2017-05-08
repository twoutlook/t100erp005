/* 
================================================================================
檔案代號:rtkgl_t
檔案名稱:自動補貨補貨建議量公式多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:Y
============.========================.==========================================
 */
create table rtkgl_t
(
rtkglent       number(5)      ,/* 企業編號 */
rtkgl001       varchar2(10)      ,/* 公式編號 */
rtkgl002       varchar2(6)      ,/* 語言別 */
rtkgl003       varchar2(500)      ,/* 說明 */
rtkgl004       varchar2(10)      /* 助記碼 */
);
alter table rtkgl_t add constraint rtkgl_pk primary key (rtkglent,rtkgl001,rtkgl002) enable validate;

create unique index rtkgl_pk on rtkgl_t (rtkglent,rtkgl001,rtkgl002);

grant select on rtkgl_t to tiptop;
grant update on rtkgl_t to tiptop;
grant delete on rtkgl_t to tiptop;
grant insert on rtkgl_t to tiptop;

exit;
