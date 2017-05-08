/* 
================================================================================
檔案代號:gzdfl_t
檔案名稱:子画面名称表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table gzdfl_t
(
gzdfl001       varchar2(20)      ,/* 规格编号 */
gzdfl002       varchar2(6)      ,/* 语言别 */
gzdfl003       varchar2(500)      ,/* 子画面文件名称 */
gzdfl004       varchar2(1)      /* 客制 */
);
alter table gzdfl_t add constraint gzdfl_pk primary key (gzdfl001,gzdfl002) enable validate;

create unique index gzdfl_pk on gzdfl_t (gzdfl001,gzdfl002);

grant select on gzdfl_t to tiptop;
grant update on gzdfl_t to tiptop;
grant delete on gzdfl_t to tiptop;
grant insert on gzdfl_t to tiptop;

exit;
