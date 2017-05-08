/* 
================================================================================
檔案代號:gzcbl_t
檔案名稱:系统分类值多语言档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:Y
============.========================.==========================================
 */
create table gzcbl_t
(
gzcbl001       number(10,0)      ,/* 系统分类码 */
gzcbl002       varchar2(10)      ,/* 系统分类值 */
gzcbl003       varchar2(6)      ,/* 语言别 */
gzcbl004       varchar2(500)      ,/* 说明 */
gzcbl005       varchar2(10)      ,/* 注记码 */
gzcbl006       varchar2(255)      ,/* 应用说明 */
gzcbl007       varchar2(1)      /* 客制 */
);
alter table gzcbl_t add constraint gzcbl_pk primary key (gzcbl001,gzcbl002,gzcbl003) enable validate;

create  index gzcbl_01 on gzcbl_t (gzcbl005);
create unique index gzcbl_pk on gzcbl_t (gzcbl001,gzcbl002,gzcbl003);

grant select on gzcbl_t to tiptop;
grant update on gzcbl_t to tiptop;
grant delete on gzcbl_t to tiptop;
grant insert on gzcbl_t to tiptop;

exit;
