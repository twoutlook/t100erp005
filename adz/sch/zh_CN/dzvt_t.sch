/* 
================================================================================
檔案代號:dzvt_t
檔案名稱:组件参数档(版次归1)
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table dzvt_t
(
dzvtstus       varchar2(10)      ,/* 状态码 */
dzvt001       varchar2(40)      ,/* 组件代号 */
dzvt002       varchar2(1)      ,/* 傳入/传出flag */
dzvt003       number(10,0)      ,/* 顺序 */
dzvt004       varchar2(500)      ,/* no use */
dzvt005       varchar2(40)      ,/* 参数 */
dzvt006       varchar2(15)      ,/* 识别码版次 */
dzvt007       varchar2(60)      ,/* 参数类型 */
dzvtownid       varchar2(10)      ,/* 资料所有者 */
dzvtowndp       varchar2(10)      ,/* 资料所有部门 */
dzvtcrtid       varchar2(10)      ,/* 资料建立者 */
dzvtcrtdp       varchar2(10)      ,/* 资料建立部门 */
dzvtcrtdt       date      ,/* 资料创建日 */
dzvtmodid       varchar2(10)      ,/* 资料修改者 */
dzvtmoddt       date      ,/* 最近修改日 */
dzvtcnfid       varchar2(10)      ,/* 资料确认者 */
dzvtcnfdt       date      ,/* 数据确认日 */
dzvt008       varchar2(1)      ,/* 使用标示 */
dzvt009       varchar2(40)      /* 客户代号 */
);
alter table dzvt_t add constraint dzvt_pk primary key (dzvt001,dzvt002,dzvt003,dzvt006,dzvt008) enable validate;


grant select on dzvt_t to tiptop;
grant update on dzvt_t to tiptop;
grant delete on dzvt_t to tiptop;
grant insert on dzvt_t to tiptop;

exit;
