/* 
================================================================================
檔案代號:gzja_t
檔案名稱:集成服务注册数据表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table gzja_t
(
gzjaownid       varchar2(20)      ,/* 资料所有者 */
gzjaowndp       varchar2(10)      ,/* 资料所有部门 */
gzjacrtid       varchar2(20)      ,/* 资料录入者 */
gzjacrtdp       varchar2(10)      ,/* 资料录入部门 */
gzjacrtdt       timestamp(0)      ,/* 资料创建日 */
gzjamodid       varchar2(20)      ,/* 资料更改者 */
gzjamoddt       timestamp(0)      ,/* 最近更改日 */
gzjastus       varchar2(10)      ,/* 状态码 */
gzja001       varchar2(40)      ,/* 服务规格编号 */
gzja002       varchar2(4)      ,/* 归属模块 */
gzja003       varchar2(1)      ,/* 特别开发属性 */
gzja004       varchar2(40)      ,/* WS服务名称 */
gzja005       varchar2(1)      ,/* 客制 */
gzja006       varchar2(80)      ,/* 归属行业别 */
gzja007       varchar2(10)      ,/* 数据流向 */
gzja008       varchar2(10)      ,/* 服务类别 */
gzja009       varchar2(10)      ,/* 服务版本 */
gzja010       varchar2(1)      ,/* 启动数据库运行计划的LOG */
gzja011       varchar2(1)      ,/* 信息内容格式 */
gzja012       varchar2(1)      /* 集成方案 */
);
alter table gzja_t add constraint gzja_pk primary key (gzja001) enable validate;

create unique index gzja_pk on gzja_t (gzja001);

grant select on gzja_t to tiptop;
grant update on gzja_t to tiptop;
grant delete on gzja_t to tiptop;
grant insert on gzja_t to tiptop;

exit;
