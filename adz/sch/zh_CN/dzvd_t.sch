/* 
================================================================================
檔案代號:dzvd_t
檔案名稱:Action规格设计表(版次归1)
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table dzvd_t
(
dzvdstus       varchar2(10)      ,/* no use */
dzvd001       varchar2(20)      ,/* 规格编号 */
dzvd002       varchar2(60)      ,/* Action识别码 */
dzvd003       varchar2(15)      ,/* 识别码版次 */
dzvd099       clob      ,/* 规格内容 */
dzvd005       varchar2(1)      ,/* 使用标示 */
dzvd006       varchar2(80)      ,/* 触发时机 */
dzvd007       varchar2(40)      ,/* 产生标准程序 */
dzvdownid       varchar2(10)      ,/* 资料所有者 */
dzvdowndp       varchar2(10)      ,/* 资料所有部门 */
dzvdcrtid       varchar2(10)      ,/* 资料建立者 */
dzvdcrtdp       varchar2(10)      ,/* 资料建立部门 */
dzvdcrtdt       date      ,/* 资料创建日 */
dzvdmodid       varchar2(10)      ,/* 资料修改者 */
dzvdmoddt       date      ,/* 最近修改日 */
dzvd008       varchar2(40)      /* 客户代号 */
);
alter table dzvd_t add constraint dzvd_pk primary key (dzvd001,dzvd002,dzvd003,dzvd005) enable validate;


grant select on dzvd_t to tiptop;
grant update on dzvd_t to tiptop;
grant delete on dzvd_t to tiptop;
grant insert on dzvd_t to tiptop;

exit;
