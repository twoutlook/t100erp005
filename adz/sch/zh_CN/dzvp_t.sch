/* 
================================================================================
檔案代號:dzvp_t
檔案名稱:section标准数据档(版次归1)
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table dzvp_t
(
dzvpstus       varchar2(10)      ,/* 状态码 */
dzvp001       varchar2(20)      ,/* 代码编号 */
dzvp002       varchar2(15)      ,/* 代码版次 */
dzvp003       varchar2(60)      ,/* section编号 */
dzvp004       varchar2(15)      ,/* section版次 */
dzvp005       varchar2(1)      ,/* 使用标示 */
dzvpownid       varchar2(10)      ,/* 资料所有者 */
dzvpowndp       varchar2(10)      ,/* 资料所有部门 */
dzvpcrtid       varchar2(10)      ,/* 资料建立者 */
dzvpcrtdp       varchar2(10)      ,/* 资料建立部门 */
dzvpcrtdt       date      ,/* 资料创建日 */
dzvpmodid       varchar2(10)      ,/* 资料修改者 */
dzvpmoddt       date      ,/* 最近修改日 */
dzvp006       varchar2(20)      ,/* 产品版本 */
dzvp007       varchar2(1)      ,/* 客制标示 */
dzvp008       varchar2(40)      /* 客户代号 */
);
alter table dzvp_t add constraint dzvp_pk primary key (dzvp001,dzvp002,dzvp003,dzvp007) enable validate;


grant select on dzvp_t to tiptop;
grant update on dzvp_t to tiptop;
grant delete on dzvp_t to tiptop;
grant insert on dzvp_t to tiptop;

exit;
