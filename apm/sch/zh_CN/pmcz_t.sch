/* 
================================================================================
檔案代號:pmcz_t
檔案名稱:需求汇总档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table pmcz_t
(
pmczent       number(5)      ,/* 企业编号 */
pmczsite       varchar2(10)      ,/* 营运据点 */
pmcz001       varchar2(20)      ,/* 需求单号 */
pmcz002       number(10,0)      ,/* 项次 */
pmcz003       varchar2(40)      ,/* 商品主条码 */
pmcz004       varchar2(40)      ,/* 商品编号 */
pmcz005       varchar2(256)      ,/* 产品特征 */
pmcz006       varchar2(10)      ,/* 库存单位 */
pmcz007       varchar2(10)      ,/* 需求单位 */
pmcz008       number(20,6)      ,/* 需求数量 */
pmcz009       varchar2(10)      ,/* 包装单位 */
pmcz010       number(20,6)      ,/* 件装数 */
pmcz011       number(20,6)      ,/* 需求件数 */
pmcz020       date      ,/* 提出日期 */
pmcz021       varchar2(10)      ,/* 取货组织 */
pmcz022       varchar2(10)      ,/* 收货库位 */
pmcz023       varchar2(10)      ,/* 来源类型 */
pmcz024       varchar2(20)      ,/* 来源单号 */
pmcz025       number(10,0)      ,/* 来源项次 */
pmcz026       number(10,0)      ,/* 来源项序 */
pmcz027       date      ,/* 需求日期 */
pmcz028       varchar2(10)      ,/* 收货时段 */
pmcz030       varchar2(10)      ,/* 供应商编号 */
pmcz031       varchar2(10)      ,/* 经营方式 */
pmcz032       varchar2(10)      ,/* 采购类型 */
pmcz040       varchar2(10)      ,/* 采购中心 */
pmcz041       varchar2(20)      ,/* 采购员 */
pmcz042       varchar2(10)      ,/* 配送中心 */
pmcz043       varchar2(10)      ,/* 配送仓库 */
pmcz050       number(20,6)      ,/* 已分采购量 */
pmcz051       number(20,6)      ,/* 已分配送量 */
pmcz052       number(20,6)      ,/* 已分调拨量 */
pmcz060       varchar2(10)      ,/* 结案码 */
pmcz061       varchar2(10)      ,/* 分配状态 */
pmcz062       varchar2(10)      ,/* 需求对象 */
pmcz063       varchar2(10)      ,/* 需求对象类型 */
pmcz064       number(20,6)      ,/* 已装箱量 */
pmcz065       number(20,6)      /* 已出库量 */
);
alter table pmcz_t add constraint pmcz_pk primary key (pmczent,pmczsite,pmcz001,pmcz002) enable validate;

create  index pmcz_n01 on pmcz_t (pmczent,pmcz001,pmcz002,pmcz062,pmcz063);
create unique index pmcz_pk on pmcz_t (pmczent,pmczsite,pmcz001,pmcz002);

grant select on pmcz_t to tiptop;
grant update on pmcz_t to tiptop;
grant delete on pmcz_t to tiptop;
grant insert on pmcz_t to tiptop;

exit;
