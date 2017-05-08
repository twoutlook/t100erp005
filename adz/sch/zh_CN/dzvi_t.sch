/* 
================================================================================
檔案代號:dzvi_t
檔案名稱:字段参考设计表(版次归1)
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table dzvi_t
(
dzvistus       varchar2(10)      ,/* no use */
dzvi001       varchar2(20)      ,/* 规格编号 */
dzvi002       varchar2(60)      ,/* 控件编号 */
dzvi003       varchar2(15)      ,/* 识别码版次 */
dzvi004       varchar2(1)      ,/* 使用标示 */
dzvi005       varchar2(60)      ,/* 依附控件编号 */
dzvi007       varchar2(80)      ,/* 对应传值设置 */
dzvi008       varchar2(15)      ,/* 资料参考Table */
dzvi009       varchar2(80)      ,/* 资料参考FK */
dzvi010       varchar2(20)      ,/* 资料参考语系 */
dzvi011       varchar2(20)      ,/* 资料参考回传 */
dzviownid       varchar2(10)      ,/* 资料所有者 */
dzviowndp       varchar2(10)      ,/* 资料所有部门 */
dzvicrtid       varchar2(10)      ,/* 资料建立者 */
dzvicrtdp       varchar2(10)      ,/* 资料建立部门 */
dzvicrtdt       date      ,/* 资料创建日 */
dzvimodid       varchar2(10)      ,/* 资料修改者 */
dzvimoddt       date      ,/* 最近修改日 */
dzvi012       varchar2(40)      /* 客户代号 */
);
alter table dzvi_t add constraint dzvi_pk primary key (dzvi001,dzvi002,dzvi003,dzvi004) enable validate;


grant select on dzvi_t to tiptop;
grant update on dzvi_t to tiptop;
grant delete on dzvi_t to tiptop;
grant insert on dzvi_t to tiptop;

exit;
