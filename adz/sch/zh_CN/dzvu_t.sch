/* 
================================================================================
檔案代號:dzvu_t
檔案名稱:组件关键词档(版次归1)
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table dzvu_t
(
dzvustus       varchar2(10)      ,/* 状态码 */
dzvu001       varchar2(40)      ,/* 组件代号 */
dzvu002       number(10,0)      ,/* 关键字序号 */
dzvu003       varchar2(15)      ,/* 识别码版次 */
dzvu004       varchar2(1)      ,/* 使用标示 */
dzvuownid       varchar2(10)      ,/* 资料所有者 */
dzvuowndp       varchar2(10)      ,/* 资料所有部门 */
dzvucrtid       varchar2(10)      ,/* 资料建立者 */
dzvucrtdp       varchar2(10)      ,/* 资料建立部门 */
dzvucrtdt       date      ,/* 资料创建日 */
dzvumodid       varchar2(10)      ,/* 资料修改者 */
dzvumoddt       date      ,/* 最近修改日 */
dzvucnfid       varchar2(10)      ,/* 资料确认者 */
dzvucnfdt       date      ,/* 数据确认日 */
dzvu005       varchar2(40)      /* 客户代号 */
);
alter table dzvu_t add constraint dzvu_pk primary key (dzvu001,dzvu002,dzvu003,dzvu004) enable validate;


grant select on dzvu_t to tiptop;
grant update on dzvu_t to tiptop;
grant delete on dzvu_t to tiptop;
grant insert on dzvu_t to tiptop;

exit;
