/* 
================================================================================
檔案代號:dzvy_t
檔案名稱:记录应用组件规格设计文档中的测试记录(版次归1)
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table dzvy_t
(
dzvyownid       varchar2(10)      ,/* 资料所有者 */
dzvyowndp       varchar2(10)      ,/* 资料所有部门 */
dzvycrtid       varchar2(10)      ,/* 资料建立者 */
dzvycrtdp       varchar2(10)      ,/* 资料建立部门 */
dzvycrtdt       date      ,/* 资料创建日 */
dzvymodid       varchar2(10)      ,/* 资料修改者 */
dzvymoddt       date      ,/* 最近修改日 */
dzvycnfid       varchar2(10)      ,/* 资料确认者 */
dzvycnfdt       date      ,/* 数据确认日 */
dzvy001       varchar2(40)      ,/* 组件代号 */
dzvy002       number(10,0)      ,/* 项次 */
dzvy003       varchar2(500)      ,/* 情景说明 */
dzvy004       varchar2(500)      ,/* 传入值 */
dzvy005       varchar2(500)      ,/* 预计传出值 */
dzvy006       varchar2(1)      ,/* 正向负向检查 */
dzvy007       varchar2(10)      ,/* 输出的错误代号 */
dzvy008       varchar2(40)      ,/* 客户代号 */
dzvy009       varchar2(4000)      ,/* 备注 */
dzvy010       varchar2(15)      ,/* 识别码版次 */
dzvy011       varchar2(1)      ,/* 使用标示 */
dzvystus       varchar2(10)      /* 状态码 */
);
alter table dzvy_t add constraint dzvy_pk primary key (dzvy001,dzvy002,dzvy010,dzvy011) enable validate;


grant select on dzvy_t to tiptop;
grant update on dzvy_t to tiptop;
grant delete on dzvy_t to tiptop;
grant insert on dzvy_t to tiptop;

exit;
