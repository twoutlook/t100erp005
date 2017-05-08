/* 
================================================================================
檔案代號:dzva_t
檔案名稱:规格与内容版次对应表(版次归1)
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table dzva_t
(
dzvastus       varchar2(10)      ,/* 状态码 */
dzva001       varchar2(20)      ,/* 规格编号 */
dzva002       varchar2(15)      ,/* 规格版次 */
dzva003       varchar2(60)      ,/* 识别码 */
dzva004       varchar2(15)      ,/* 识别码版次 */
dzva005       varchar2(10)      ,/* 识别码类型 */
dzva006       varchar2(1)      ,/* 使用标示 */
dzvaownid       varchar2(10)      ,/* 资料所有者 */
dzvaowndp       varchar2(10)      ,/* 资料所有部门 */
dzvacrtid       varchar2(10)      ,/* 资料建立者 */
dzvacrtdp       varchar2(10)      ,/* 资料建立部门 */
dzvacrtdt       date      ,/* 资料创建日 */
dzvamodid       varchar2(10)      ,/* 资料修改者 */
dzvamoddt       date      ,/* 最近修改日 */
dzva007       varchar2(1)      ,/* 规格引用否 */
dzva008       varchar2(20)      ,/* 产品版本 */
dzva009       varchar2(1)      ,/* 客制标示 */
dzva010       varchar2(40)      /* 客户代号 */
);
alter table dzva_t add constraint dzva_pk primary key (dzva001,dzva002,dzva003,dzva009) enable validate;


grant select on dzva_t to tiptop;
grant update on dzva_t to tiptop;
grant delete on dzva_t to tiptop;
grant insert on dzva_t to tiptop;

exit;
