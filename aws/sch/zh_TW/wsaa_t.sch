/* 
================================================================================
檔案代號:wsaa_t
檔案名稱:BPM数据档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table wsaa_t
(
wsaa001       varchar2(10)      ,/* 单据性质 */
wsaa002       varchar2(100)      ,/* 默认签核模版 */
wsaa003       varchar2(4)      ,/* 模块编号 */
wsaa004       varchar2(40)      ,/* 表单关系人字段 */
wsaa005       varchar2(40)      ,/* 交易对象字段 */
wsaa006       varchar2(15)      ,/* 对应前关关卡表格 */
wsaa007       varchar2(40)      ,/* 审核应用元件编号 */
wsaa008       varchar2(15)      ,/* 本关关卡对应表格 */
wsaa009       varchar2(40)      ,/* 单别参照单据性质 */
wsaaownid       varchar2(20)      ,/* 资料所有者 */
wsaaowndp       varchar2(10)      ,/* 资料所有部门 */
wsaacrtid       varchar2(20)      ,/* 资料录入者 */
wsaacrtdp       varchar2(10)      ,/* 资料录入部门 */
wsaacrtdt       timestamp(0)      ,/* 资料创建日 */
wsaamodid       varchar2(20)      ,/* 资料更改者 */
wsaamoddt       timestamp(0)      ,/* 最近更改日 */
wsaa010       varchar2(20)      ,/* 作业编号 */
wsaa011       varchar2(1)      ,/* 启用签核 */
wsaa012       varchar2(40)      ,/* 表单关系人部门字段 */
wsaa013       varchar2(40)      ,/* 填表人字段 */
wsaa014       varchar2(40)      ,/* 填表人部门字段 */
wsaa015       varchar2(40)      ,/* 交易前元件编号 */
wsaa016       varchar2(40)      ,/* 交易后元件编号 */
wsaa017       varchar2(40)      /* 更新状态后元件编号 */
);
alter table wsaa_t add constraint wsaa_pk primary key (wsaa001) enable validate;

create unique index wsaa_pk on wsaa_t (wsaa001);

grant select on wsaa_t to tiptop;
grant update on wsaa_t to tiptop;
grant delete on wsaa_t to tiptop;
grant insert on wsaa_t to tiptop;

exit;
