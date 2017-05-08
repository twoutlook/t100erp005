/* 
================================================================================
檔案代號:gzsv_t
檔案名稱:参数作业设置表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table gzsv_t
(
gzsv001       varchar2(20)      ,/* 设置作业名称 */
gzsv002       varchar2(80)      ,/* 分页编号 */
gzsv003       varchar2(80)      ,/* 分项编号 */
gzsv004       number(5,0)      ,/* 设置序号 */
gzsv005       varchar2(15)      ,/* 表格编号 */
gzsv006       varchar2(10)      ,/* 参数编号 */
gzsvownid       varchar2(20)      ,/* 资料所有者 */
gzsvowndp       varchar2(10)      ,/* 资料所有部门 */
gzsvcrtid       varchar2(20)      ,/* 资料录入者 */
gzsvcrtdp       varchar2(10)      ,/* 资料录入部门 */
gzsvcrtdt       timestamp(0)      ,/* 资料创建日 */
gzsvmodid       varchar2(20)      ,/* 资料更改者 */
gzsvmoddt       timestamp(0)      ,/* 最近更改日 */
gzsv007       varchar2(40)      ,/* 设置额外检查功能 */
gzsv008       varchar2(40)      ,/* 设置更改后追改功能 */
gzsv009       varchar2(1)      /* 客制调整 */
);
alter table gzsv_t add constraint gzsv_pk primary key (gzsv001,gzsv002,gzsv003,gzsv004) enable validate;

create unique index gzsv_pk on gzsv_t (gzsv001,gzsv002,gzsv003,gzsv004);

grant select on gzsv_t to tiptop;
grant update on gzsv_t to tiptop;
grant delete on gzsv_t to tiptop;
grant insert on gzsv_t to tiptop;

exit;
