/* 
================================================================================
檔案代號:dzvv_t
檔案名稱:组件前置档(版次归1)
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table dzvv_t
(
dzvvstus       varchar2(10)      ,/* 状态码 */
dzvv001       varchar2(40)      ,/* 组件代号 */
dzvv002       number(10,0)      ,/* 序号 */
dzvv003       varchar2(15)      ,/* 识别码版次 */
dzvv004       varchar2(40)      ,/* 前置组件 */
dzvv005       varchar2(1)      ,/* 使用标示 */
dzvvownid       varchar2(10)      ,/* 资料所有者 */
dzvvowndp       varchar2(10)      ,/* 资料所有部门 */
dzvvcrtid       varchar2(10)      ,/* 资料建立者 */
dzvvcrtdp       varchar2(10)      ,/* 资料建立部门 */
dzvvcrtdt       date      ,/* 资料创建日 */
dzvvmodid       varchar2(10)      ,/* 资料修改者 */
dzvvmoddt       date      ,/* 最近修改日 */
dzvvcnfid       varchar2(10)      ,/* 资料确认者 */
dzvvcnfdt       date      ,/* 数据确认日 */
dzvv006       varchar2(40)      /* 客户代号 */
);
alter table dzvv_t add constraint dzvv_pk primary key (dzvv001,dzvv002,dzvv003,dzvv005) enable validate;


grant select on dzvv_t to tiptop;
grant update on dzvv_t to tiptop;
grant delete on dzvv_t to tiptop;
grant insert on dzvv_t to tiptop;

exit;
