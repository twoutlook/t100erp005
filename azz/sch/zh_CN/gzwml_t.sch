/* 
================================================================================
檔案代號:gzwml_t
檔案名稱:公式/運算/條件名稱多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:Y
============.========================.==========================================
 */
create table gzwml_t
(
gzwml001       varchar2(40)      ,/* 運算代碼 */
gzwml002       varchar2(1)      ,/* 運算類型 */
gzwml003       varchar2(10)      ,/* 欄位屬性 */
gzwml004       varchar2(6)      ,/* 語言別 */
gzwml005       varchar2(500)      /* 運算說明 */
);
alter table gzwml_t add constraint gzwml_pk primary key (gzwml001,gzwml002,gzwml003,gzwml004) enable validate;

create unique index gzwml_pk on gzwml_t (gzwml001,gzwml002,gzwml003,gzwml004);

grant select on gzwml_t to tiptop;
grant update on gzwml_t to tiptop;
grant delete on gzwml_t to tiptop;
grant insert on gzwml_t to tiptop;

exit;
