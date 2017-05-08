/* 
================================================================================
檔案代號:dzvm_t
檔案名稱:规格画面组件排除设置(版次归1)
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table dzvm_t
(
dzvm001       varchar2(20)      ,/* 规格名称 */
dzvm002       varchar2(40)      ,/* No Use */
dzvm003       varchar2(40)      ,/* 排除项目 */
dzvmownid       varchar2(10)      ,/* 资料所有者 */
dzvmowndp       varchar2(10)      ,/* 资料所有部门 */
dzvmcrtid       varchar2(10)      ,/* 资料建立者 */
dzvmcrtdp       varchar2(10)      ,/* 资料建立部门 */
dzvmcrtdt       date      ,/* 资料创建日 */
dzvmmodid       varchar2(10)      ,/* 资料修改者 */
dzvmmoddt       date      ,/* 最近修改日 */
dzvmstus       varchar2(10)      ,/* 状态码 */
dzvm004       varchar2(15)      ,/* 识别码版次 */
dzvm005       varchar2(1)      ,/* 识别码使用标示 */
dzvm006       varchar2(40)      /* 客户代号 */
);
alter table dzvm_t add constraint dzvm_pk primary key (dzvm001,dzvm003,dzvm004,dzvm005) enable validate;


grant select on dzvm_t to tiptop;
grant update on dzvm_t to tiptop;
grant delete on dzvm_t to tiptop;
grant insert on dzvm_t to tiptop;

exit;
