/* 
================================================================================
檔案代號:gzsz_t
檔案名稱:参数设置主表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table gzsz_t
(
gzszstus       varchar2(10)      ,/* 状态码 */
gzsz001       varchar2(15)      ,/* 表格编号 */
gzsz002       varchar2(10)      ,/* 参数编号 */
gzsz003       varchar2(80)      ,/* 录入限制数据型态 */
gzsz004       varchar2(20)      ,/* 设置作业名称 */
gzsz005       number(5,0)      ,/* 设置序号 */
gzsz006       varchar2(80)      ,/* 分页编号 */
gzsz007       varchar2(80)      ,/* 分项编号 */
gzsz008       varchar2(80)      ,/* 默认值 */
gzsz009       varchar2(500)      ,/* 值域范围 */
gzsz010       varchar2(10)      ,/* 层级 */
gzsz011       varchar2(10)      ,/* 领域(应用类型) */
gzsz012       varchar2(10)      ,/* 类别 */
gzszownid       varchar2(20)      ,/* 资料所有者 */
gzszowndp       varchar2(10)      ,/* 资料所有部门 */
gzszcrtid       varchar2(20)      ,/* 资料录入者 */
gzszcrtdp       varchar2(10)      ,/* 资料录入部门 */
gzszcrtdt       timestamp(0)      ,/* 资料创建日 */
gzszmodid       varchar2(20)      ,/* 资料更改者 */
gzszmoddt       timestamp(0)      ,/* 最近更改日 */
gzsz013       varchar2(20)      ,/* 校验 */
gzsz014       varchar2(20)      ,/* 开窗 */
gzsz015       varchar2(40)      ,/* 限定格式 */
gzsz016       number(10,0)      ,/* 值域范围说明(SCC) */
gzsz017       varchar2(10)      ,/* 取参数时发生异常的处理方法 */
gzsz018       varchar2(1)      /* 允许更改的频度 */
);
alter table gzsz_t add constraint gzsz_pk primary key (gzsz001,gzsz002) enable validate;

create  index gzsz_n on gzsz_t (gzsz002);
create unique index gzsz_pk on gzsz_t (gzsz001,gzsz002);

grant select on gzsz_t to tiptop;
grant update on gzsz_t to tiptop;
grant delete on gzsz_t to tiptop;
grant insert on gzsz_t to tiptop;

exit;
