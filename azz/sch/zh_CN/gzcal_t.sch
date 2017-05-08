/* 
================================================================================
檔案代號:gzcal_t
檔案名稱:系统分类码多语言档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:Y
============.========================.==========================================
 */
create table gzcal_t
(
gzcal001       number(10,0)      ,/* 系统分类码 */
gzcal002       varchar2(6)      ,/* 语言别 */
gzcal003       varchar2(500)      ,/* 说明 */
gzcal004       varchar2(10)      ,/* 助记码 */
gzcal005       varchar2(1)      /* 客制 */
);
alter table gzcal_t add constraint gzcal_pk primary key (gzcal001,gzcal002) enable validate;

create  index gzcal_01 on gzcal_t (gzcal004);
create unique index gzcal_pk on gzcal_t (gzcal001,gzcal002);

grant select on gzcal_t to tiptop;
grant update on gzcal_t to tiptop;
grant delete on gzcal_t to tiptop;
grant insert on gzcal_t to tiptop;

exit;
