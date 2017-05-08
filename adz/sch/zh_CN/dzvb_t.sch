/* 
================================================================================
檔案代號:dzvb_t
檔案名稱:规格整体设计表(版次归1)
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table dzvb_t
(
dzvbstus       varchar2(10)      ,/* no use */
dzvb001       varchar2(20)      ,/* 规格编号 */
dzvb002       varchar2(15)      ,/* 识别码版次 */
dzvb099       clob      ,/* 规格描述 */
dzvb003       varchar2(1)      ,/* 使用标示 */
dzvb004       varchar2(60)      ,/* 识别码 */
dzvb005       varchar2(40)      ,/* 客户代号 */
dzvb006       varchar2(15)      ,/* no use */
dzvbownid       varchar2(10)      ,/* 资料所有者 */
dzvbowndp       varchar2(10)      ,/* 资料所有部门 */
dzvbcrtid       varchar2(10)      ,/* 资料建立者 */
dzvbcrtdp       varchar2(10)      ,/* 资料建立部门 */
dzvbcrtdt       date      ,/* 资料创建日 */
dzvbmodid       varchar2(10)      ,/* 资料修改者 */
dzvbmoddt       date      /* 最近修改日 */
);
alter table dzvb_t add constraint dzvb_pk primary key (dzvb001,dzvb002,dzvb003,dzvb004) enable validate;


grant select on dzvb_t to tiptop;
grant update on dzvb_t to tiptop;
grant delete on dzvb_t to tiptop;
grant insert on dzvb_t to tiptop;

exit;
