/* 
================================================================================
檔案代號:psor_t
檔案名稱:存货配置结果档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:H
多語系檔案:N
============.========================.==========================================
 */
create table psor_t
(
psorent       number(5)      ,/* 企业编号 */
psorsite       varchar2(10)      ,/* 营运据点 */
psor001       varchar2(10)      ,/* APS版本 */
psor002       varchar2(20)      ,/* 运行日期时间 */
psor003       varchar2(500)      ,/* 品号 */
psor004       number(20,6)      ,/* 供给数量 */
psor005       number(20,6)      ,/* 需求数量 */
psor006       number(5,0)      ,/* 采购件 */
psor007       varchar2(40)      ,/* 配给的对象 */
psor008       varchar2(10)      ,/* 库别 */
psor009       number(5,0)      ,/* 锁定供需 */
psor010       number(5,0)      ,/* 订单需求 */
psor011       varchar2(10)      ,/* 儲位 */
psor012       number(10,0)      ,/* 配置顺序 */
psor013       varchar2(40)      ,/* 品号 */
psor014       varchar2(256)      ,/* 品号特征码 */
psor015       varchar2(40)      ,/* 原始需求品号 */
psor016       varchar2(40)      ,/* 需求(主料)品号 */
psor017       varchar2(256)      ,/* 需求品号特征码 */
psor018       number(5,0)      ,/* 取替代型态 */
psor019       varchar2(20)      ,/* 唯一码 */
psor020       number(20,6)      ,/* 供应套数 */
psor021       varchar2(40)      ,/* 最上阶订单号 */
psor022       number(10,0)      ,/* 领料序 */
psor023       varchar2(30)      /* 批号 */
);
alter table psor_t add constraint psor_pk primary key (psorent,psorsite,psor001,psor002,psor012) enable validate;

create unique index psor_pk on psor_t (psorent,psorsite,psor001,psor002,psor012);

grant select on psor_t to tiptop;
grant update on psor_t to tiptop;
grant delete on psor_t to tiptop;
grant insert on psor_t to tiptop;

exit;
