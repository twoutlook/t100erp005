/* 
================================================================================
檔案代號:ookbs_t
檔案名稱: 
檔案目的: 
上游檔案:
下游檔案:
檔案類型:V
多語系檔案:N
============.========================.==========================================
 */
create table ookbs_t
(
ookbsent       number(5)      ,/* 企業編號 */
ookbs001       varchar2(10)      ,/* 上層目錄編號 */
ookbs002       varchar2(10)      ,/* 目錄編號 */
ookbs003       varchar2(40)      ,/* 提速值 */
ookbs004       number(5,0)      /* 階層 */
);
alter table ookbs_t add constraint ookbs_pk primary key (ookbsent,ookbs001,ookbs002,ookbs003) enable validate;

create unique index ookbs_pk on ookbs_t (ookbsent,ookbs001,ookbs002,ookbs003);

grant select on ookbs_t to tiptop;
grant update on ookbs_t to tiptop;
grant delete on ookbs_t to tiptop;
grant insert on ookbs_t to tiptop;

exit;
