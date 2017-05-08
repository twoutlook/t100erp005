/* 
================================================================================
檔案代號:dzvw_t
檔案名稱:组件维度分类表(版次归1)
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table dzvw_t
(
dzvw001       number(5,0)      ,/* 维度编号 */
dzvw002       varchar2(10)      ,/* 分类编号 */
dzvw003       varchar2(40)      ,/* 组件 */
dzvwownid       varchar2(10)      ,/* 资料所有者 */
dzvwowndp       varchar2(10)      ,/* 资料所有部门 */
dzvwcrtid       varchar2(10)      ,/* 资料建立者 */
dzvwcrtdp       varchar2(10)      ,/* 资料建立部门 */
dzvwcrtdt       date      ,/* 资料创建日 */
dzvwmodid       varchar2(10)      ,/* 资料修改者 */
dzvwmoddt       date      ,/* 最近修改日 */
dzvwcnfid       varchar2(10)      ,/* 资料确认者 */
dzvwcnfdt       date      ,/* 数据确认日 */
dzvw004       varchar2(15)      ,/* 识别码版次 */
dzvw005       varchar2(1)      ,/* 使用标示 */
dzvwstus       varchar2(10)      ,/* 状态码 */
dzvw006       varchar2(40)      /* 客户代号 */
);
alter table dzvw_t add constraint dzvw_pk primary key (dzvw001,dzvw002,dzvw003,dzvw004,dzvw005) enable validate;


grant select on dzvw_t to tiptop;
grant update on dzvw_t to tiptop;
grant delete on dzvw_t to tiptop;
grant insert on dzvw_t to tiptop;

exit;
