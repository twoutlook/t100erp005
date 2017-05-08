/* 
================================================================================
檔案代號:gzahl_t
檔案名稱:单据程序打印的报表元件说明档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:Y
============.========================.==========================================
 */
create table gzahl_t
(
gzahl001       varchar2(20)      ,/* 单据程序 */
gzahl002       number(5,0)      ,/* 序号 */
gzahl003       varchar2(6)      ,/* 语言别 */
gzahl004       varchar2(80)      ,/* 报表说明 */
gzahl005       varchar2(10)      ,/* 助记码 */
gzahl006       varchar2(1)      /* 客制 */
);
alter table gzahl_t add constraint gzahl_pk primary key (gzahl001,gzahl002,gzahl003) enable validate;

create unique index gzahl_pk on gzahl_t (gzahl001,gzahl002,gzahl003);

grant select on gzahl_t to tiptop;
grant update on gzahl_t to tiptop;
grant delete on gzahl_t to tiptop;
grant insert on gzahl_t to tiptop;

exit;
