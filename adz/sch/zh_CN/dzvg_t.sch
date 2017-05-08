/* 
================================================================================
檔案代號:dzvg_t
檔案名稱:规格Table设置表(版次归1)
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table dzvg_t
(
dzvgstus       varchar2(10)      ,/* 状态码 */
dzvg001       varchar2(20)      ,/* 规格编号 */
dzvg002       varchar2(15)      ,/* Table编号 */
dzvg003       varchar2(15)      ,/* 识别码版次 */
dzvg004       varchar2(15)      ,/* 上层Table编号 */
dzvg005       varchar2(1)      ,/* 是否为主要Table */
dzvg006       varchar2(1)      ,/* 使用标示 */
dzvgownid       varchar2(10)      ,/* 资料所有者 */
dzvgowndp       varchar2(10)      ,/* 资料所有部门 */
dzvgcrtid       varchar2(10)      ,/* 资料建立者 */
dzvgcrtdp       varchar2(10)      ,/* 资料建立部门 */
dzvgcrtdt       date      ,/* 资料创建日 */
dzvgmodid       varchar2(10)      ,/* 资料修改者 */
dzvgmoddt       date      ,/* 最近修改日 */
dzvg007       varchar2(1)      ,/* 是否为单头 */
dzvg008       varchar2(500)      ,/* 主键设置 */
dzvg009       varchar2(500)      ,/* 键值设置 */
dzvg010       varchar2(500)      ,/* 外键设置 */
dzvg011       varchar2(40)      ,/* 客户代号 */
dzvg012       varchar2(1)      /* patch标示 */
);
alter table dzvg_t add constraint dzvg_pk primary key (dzvg001,dzvg002,dzvg003,dzvg006) enable validate;


grant select on dzvg_t to tiptop;
grant update on dzvg_t to tiptop;
grant delete on dzvg_t to tiptop;
grant insert on dzvg_t to tiptop;

exit;
