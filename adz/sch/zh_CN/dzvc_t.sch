/* 
================================================================================
檔案代號:dzvc_t
檔案名稱:字段规格设计表(版次归1)
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table dzvc_t
(
dzvcstus       varchar2(10)      ,/* no use */
dzvc001       varchar2(20)      ,/* 规格编号 */
dzvc002       varchar2(20)      ,/* 栏位编号 */
dzvc003       varchar2(60)      ,/* 控件名称 */
dzvc004       varchar2(15)      ,/* 识别码版次 */
dzvc005       varchar2(15)      ,/* Table编号 */
dzvc006       varchar2(4)      ,/* 栏位属性 */
dzvc007       varchar2(20)      ,/* 栏位型态 */
dzvc008       varchar2(1)      ,/* 必要字段 */
dzvc009       varchar2(20)      ,/* 编辑时开窗 */
dzvc010       varchar2(20)      ,/* 查询时开窗 */
dzvc011       varchar2(500)      ,/* 校验带值设置 */
dzvc012       varchar2(1)      ,/* 使用标示 */
dzvc013       varchar2(40)      ,/* 客户代号 */
dzvc014       varchar2(100)      ,/* 预设值 */
dzvc015       varchar2(80)      ,/* 最大值 */
dzvc016       varchar2(80)      ,/* 最小值 */
dzvc017       varchar2(1)      ,/* 是否可编辑 */
dzvc018       varchar2(1)      ,/* 是否可查询 */
dzvc019       varchar2(40)      ,/* 显现控件 */
dzvc099       clob      ,/* 规格内容 */
dzvc020       varchar2(40)      ,/* no use */
dzvc021       varchar2(15)      ,/* no use */
dzvcownid       varchar2(10)      ,/* 资料所有者 */
dzvcowndp       varchar2(10)      ,/* 资料所有部门 */
dzvccrtid       varchar2(10)      ,/* 资料建立者 */
dzvccrtdp       varchar2(10)      ,/* 资料建立部门 */
dzvccrtdt       date      ,/* 资料创建日 */
dzvcmodid       varchar2(10)      ,/* 资料修改者 */
dzvcmoddt       date      /* 最近修改日 */
);
alter table dzvc_t add constraint dzvc_pk primary key (dzvc001,dzvc003,dzvc004,dzvc012) enable validate;


grant select on dzvc_t to tiptop;
grant update on dzvc_t to tiptop;
grant delete on dzvc_t to tiptop;
grant insert on dzvc_t to tiptop;

exit;
