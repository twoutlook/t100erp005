/* 
================================================================================
檔案代號:debn_t
檔案名稱:门店商品日统计日结档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table debn_t
(
debnent       number(5)      ,/* 企业编号 */
debnsite       varchar2(10)      ,/* 营运据点 */
debn001       varchar2(10)      ,/* 层级类型 */
debn002       date      ,/* 统计日期 */
debn003       number(5,0)      ,/* 会计周 */
debn004       number(5,0)      ,/* 会计期 */
debn005       varchar2(40)      ,/* 商品编号 */
debn006       varchar2(10)      ,/* 销售单位 */
debn007       number(20,6)      ,/* 日均销量 */
debn008       number(20,6)      ,/* 促销日均销量 */
debn009       varchar2(10)      ,/* 库存单位 */
debn010       number(20,6)      ,/* 成本仓数量 */
debn011       number(20,6)      ,/* 非成本仓数量 */
debn012       number(20,6)      ,/* 可用数量 */
debn013       number(20,6)      ,/* 不可用数量 */
debn014       number(20,6)      ,/* 库存总量 */
debn015       number(20,6)      ,/* 库存总额 */
debn016       varchar2(256)      ,/* 产品特征 */
debn017       varchar2(30)      ,/* 库存管理特征 */
debn018       varchar2(10)      /* 库位 */
);
alter table debn_t add constraint debn_pk primary key (debnent,debnsite,debn002,debn005,debn009,debn016,debn017,debn018) enable validate;

create unique index debn_pk on debn_t (debnent,debnsite,debn002,debn005,debn009,debn016,debn017,debn018);

grant select on debn_t to tiptop;
grant update on debn_t to tiptop;
grant delete on debn_t to tiptop;
grant insert on debn_t to tiptop;

exit;
