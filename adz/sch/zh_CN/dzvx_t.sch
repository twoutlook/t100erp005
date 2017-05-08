/* 
================================================================================
檔案代號:dzvx_t
檔案名稱:组件规格设计表(版次归1)
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table dzvx_t
(
dzvx001       varchar2(40)      ,/* 组件代号 */
dzvx002       varchar2(15)      ,/* 识别码版次 */
dzvx003       varchar2(60)      ,/* 使用标示 */
dzvx099       clob      ,/* 规格描述 */
dzvxownid       varchar2(10)      ,/* 资料所有者 */
dzvxowndp       varchar2(10)      ,/* 资料所有部门 */
dzvxcrtid       varchar2(10)      ,/* 资料建立者 */
dzvxcrtdp       varchar2(10)      ,/* 资料建立部门 */
dzvxcrtdt       date      ,/* 资料创建日 */
dzvxmodid       varchar2(10)      ,/* 资料修改者 */
dzvxmoddt       date      ,/* 最近修改日 */
dzvxstus       varchar2(10)      ,/* 状态码 */
dzvx004       varchar2(40)      /* 客户代号 */
);
alter table dzvx_t add constraint dzvx_pk primary key (dzvx001,dzvx002,dzvx003) enable validate;


grant select on dzvx_t to tiptop;
grant update on dzvx_t to tiptop;
grant delete on dzvx_t to tiptop;
grant insert on dzvx_t to tiptop;

exit;
