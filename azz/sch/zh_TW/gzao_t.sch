/* 
================================================================================
檔案代號:gzao_t
檔案名稱:开账设置条件给值档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table gzao_t
(
gzao001       varchar2(15)      ,/* 作业编号 */
gzao002       varchar2(10)      ,/* 格式编号 */
gzao003       varchar2(15)      ,/* 表格编号 */
gzao004       varchar2(20)      ,/* 字段编号 */
gzao005       number(10,0)      ,/* 顺序 */
gzao006       varchar2(500)      ,/* 满足条件 */
gzao007       varchar2(500)      ,/* 给值 */
gzao008       varchar2(255)      /* 备注 */
);
alter table gzao_t add constraint gzao_pk primary key (gzao001,gzao002,gzao003,gzao004,gzao005) enable validate;

create unique index gzao_pk on gzao_t (gzao001,gzao002,gzao003,gzao004,gzao005);

grant select on gzao_t to tiptop;
grant update on gzao_t to tiptop;
grant delete on gzao_t to tiptop;
grant insert on gzao_t to tiptop;

exit;
