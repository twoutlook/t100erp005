/* 
================================================================================
檔案代號:dzvs_t
檔案名稱:组件与元素版次对应表(版次归1)
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table dzvs_t
(
dzvs001       varchar2(40)      ,/* 组件代号 */
dzvs002       varchar2(15)      ,/* 组件版次 */
dzvs003       varchar2(60)      ,/* 识别码 */
dzvs004       varchar2(15)      ,/* 识别码版次 */
dzvs005       varchar2(1)      ,/* 使用标示 */
dzvs006       varchar2(40)      ,/* 客户代号 */
dzvsownid       varchar2(10)      ,/* 资料所有者 */
dzvsowndp       varchar2(10)      ,/* 资料所有部门 */
dzvscrtid       varchar2(10)      ,/* 资料建立者 */
dzvscrtdp       varchar2(10)      ,/* 资料建立部门 */
dzvscrtdt       date      ,/* 资料创建日 */
dzvsmodid       varchar2(10)      ,/* 资料修改者 */
dzvsmoddt       date      ,/* 最近修改日 */
dzvsstus       varchar2(10)      ,/* 状态码 */
dzvs007       varchar2(1)      /* 识别标示 */
);
alter table dzvs_t add constraint dzvs_pk primary key (dzvs001,dzvs002,dzvs003) enable validate;


grant select on dzvs_t to tiptop;
grant update on dzvs_t to tiptop;
grant delete on dzvs_t to tiptop;
grant insert on dzvs_t to tiptop;

exit;
