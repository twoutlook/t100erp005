/* 
================================================================================
檔案代號:dzvq_t
檔案名稱:section设计表(版次归1)
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table dzvq_t
(
dzvqstus       varchar2(10)      ,/* no use */
dzvq001       varchar2(20)      ,/* 代码编号 */
dzvq002       varchar2(60)      ,/* section编号 */
dzvq003       varchar2(15)      ,/* section版次 */
dzvq004       varchar2(1)      ,/* 使用标示 */
dzvq098       clob      ,/* section内容 */
dzvqownid       varchar2(10)      ,/* 资料所有者 */
dzvqowndp       varchar2(10)      ,/* 资料所有部门 */
dzvqcrtid       varchar2(10)      ,/* 资料建立者 */
dzvqcrtdp       varchar2(10)      ,/* 资料建立部门 */
dzvqcrtdt       date      ,/* 资料创建日 */
dzvqmodid       varchar2(10)      ,/* 资料修改者 */
dzvqmoddt       date      ,/* 最近修改日 */
dzvq005       varchar2(40)      /* 客户代号 */
);
alter table dzvq_t add constraint dzvq_pk primary key (dzvq001,dzvq002,dzvq003,dzvq004) enable validate;


grant select on dzvq_t to tiptop;
grant update on dzvq_t to tiptop;
grant delete on dzvq_t to tiptop;
grant insert on dzvq_t to tiptop;

exit;
