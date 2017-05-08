/* 
================================================================================
檔案代號:gzza_t
檔案名稱:程序数据表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table gzza_t
(
gzzastus       varchar2(10)      ,/* 状态码 */
gzza001       varchar2(20)      ,/* 程序编号 */
gzza002       varchar2(10)      ,/* 程序类别 */
gzza003       varchar2(4)      ,/* 归属模块 */
gzza004       varchar2(255)      ,/* 系统运行指令 */
gzza005       varchar2(1)      ,/* 单身显示笔数处理方法 */
gzza006       varchar2(1)      ,/* 可于更改时调整主要键值(PK)数据 */
gzza007       number(10,0)      ,/* 最大单身显示笔数 */
gzza008       varchar2(20)      ,/* 引用主程序编号 */
gzza009       varchar2(1)      ,/* 执行时生成SQL操作历程档 (在 $LOGDIR) */
gzza010       varchar2(1)      ,/* 将错误消息写入LOG */
gzza011       varchar2(1)      ,/* 客制 */
gzza012       varchar2(1)      ,/* 处理闲置连接方式 */
gzza013       varchar2(1)      ,/* 处理闲置连接关闭的作法 */
gzza014       number(5,0)      ,/* 闲置时间 (秒) */
gzza015       varchar2(80)      ,/* 归属行业别 */
gzza016       varchar2(1)      ,/* 程序可维护(特别开发属性) */
gzzaownid       varchar2(20)      ,/* 资料所有者 */
gzzaowndp       varchar2(10)      ,/* 资料所有部门 */
gzzacrtid       varchar2(20)      ,/* 资料录入者 */
gzzacrtdp       varchar2(10)      ,/* 资料录入部门 */
gzzacrtdt       timestamp(0)      ,/* 资料创建日 */
gzzamodid       varchar2(20)      ,/* 资料更改者 */
gzzamoddt       timestamp(0)      ,/* 最近更改日 */
gzza017       varchar2(1)      ,/* 单据日期控管方式 */
gzza018       varchar2(1)      ,/* 过账日期控管方式 */
gzza019       varchar2(20)      ,/* Q类作业上阶串查作业编号 */
gzza020       varchar2(80)      ,/* Q类作业上阶串查使用字段 */
gzza021       varchar2(1)      ,/* 允许运行环境 */
gzza022       varchar2(80)      ,/* 可不受闲置时间控管的营运据点 */
gzza023       varchar2(1)      ,/* 与POI串接 */
gzza024       number(5,0)      /* POI内存使用上限(1-80) */
);
alter table gzza_t add constraint gzza_pk primary key (gzza001) enable validate;

create unique index gzza_pk on gzza_t (gzza001);

grant select on gzza_t to tiptop;
grant update on gzza_t to tiptop;
grant delete on gzza_t to tiptop;
grant insert on gzza_t to tiptop;

exit;
