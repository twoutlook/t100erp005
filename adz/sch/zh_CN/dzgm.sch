/* 
================================================================================
檔案代號:dzgm
檔案名稱:报表组件与内容版次对应表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table dzgm
(
dzgm001       varchar2(20)      ,/* 报表组件代号 */
dzgm002       varchar2(15)      ,/* 版次 */
dzgm003       varchar2(60)      ,/* 识别码 */
dzgm004       varchar2(15)      ,/* 识别码版次 */
dzgm005       varchar2(10)      ,/* 识别码类型 */
dzgm006       varchar2(1)      ,/* 使用标示 */
dzgm007       varchar2(1)      ,/* 内容引用否 */
dzgm008       varchar2(20)      ,/* ERP版本 */
dzgmownid       varchar2(10)      ,/* 资料所有者 */
dzgmowndp       varchar2(10)      ,/* 资料所有部门 */
dzgmcrtid       varchar2(10)      ,/* 资料建立者 */
dzgmcrtdp       varchar2(10)      ,/* 资料建立部门 */
dzgmcrtdt       date      ,/* 资料创建日 */
dzgmmodid       varchar2(10)      ,/* 资料修改者 */
dzgmmoddt       date      ,/* 最近修改日 */
dzgmstus       varchar2(10)      /* 状态码 */
);
alter table dzgm add constraint dzgm_pk primary key (dzgm001,dzgm002,dzgm003) enable validate;


grant select on dzgm to tiptop;
grant update on dzgm to tiptop;
grant delete on dzgm to tiptop;
grant insert on dzgm to tiptop;

exit;
