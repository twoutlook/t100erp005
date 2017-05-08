/* 
================================================================================
檔案代號:dzvr_t
檔案名稱:组件规格与组件版次对应表(版次归1)
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table dzvr_t
(
dzvr001       varchar2(20)      ,/* 组件规格代号 */
dzvr002       varchar2(15)      ,/* 规格版次 */
dzvr003       varchar2(40)      ,/* 组件代号 */
dzvr004       varchar2(15)      ,/* 组件版次 */
dzvr005       varchar2(20)      ,/* 产品版本 */
dzvrownid       varchar2(10)      ,/* 资料所有者 */
dzvrowndp       varchar2(10)      ,/* 资料所有部门 */
dzvrcrtid       varchar2(10)      ,/* 资料建立者 */
dzvrcrtdp       varchar2(10)      ,/* 资料建立部门 */
dzvrcrtdt       date      ,/* 资料创建日 */
dzvrmodid       varchar2(10)      ,/* 资料修改者 */
dzvrmoddt       date      ,/* 最近修改日 */
dzvrstus       varchar2(10)      ,/* 状态码 */
dzvr006       varchar2(1)      ,/* 客制标示 */
dzvr007       varchar2(40)      ,/* 客户代号 */
dzvr008       varchar2(1)      /* 使用标示 */
);
alter table dzvr_t add constraint dzvr_pk primary key (dzvr001,dzvr002,dzvr003,dzvr006) enable validate;


grant select on dzvr_t to tiptop;
grant update on dzvr_t to tiptop;
grant delete on dzvr_t to tiptop;
grant insert on dzvr_t to tiptop;

exit;
