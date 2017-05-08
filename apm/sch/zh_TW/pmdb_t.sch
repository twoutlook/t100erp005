/* 
================================================================================
檔案代號:pmdb_t
檔案名稱:请购单明细档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pmdb_t
(
pmdbent       number(5)      ,/* 企业编号 */
pmdbsite       varchar2(10)      ,/* 营运据点 */
pmdbdocno       varchar2(20)      ,/* 请购单号 */
pmdbseq       number(10,0)      ,/* 项次 */
pmdb001       varchar2(20)      ,/* 来源单号 */
pmdb002       number(10,0)      ,/* 来源项次 */
pmdb003       number(10,0)      ,/* 来源项序 */
pmdb004       varchar2(40)      ,/* 料件编号 */
pmdb005       varchar2(256)      ,/* 产品特征 */
pmdb006       number(20,6)      ,/* 需求数量 */
pmdb007       varchar2(10)      ,/* 单位 */
pmdb008       number(20,6)      ,/* 参考数量 */
pmdb009       varchar2(10)      ,/* 参考单位 */
pmdb010       number(20,6)      ,/* 计价数量 */
pmdb011       varchar2(10)      ,/* 计价单位 */
pmdb012       varchar2(40)      ,/* 包装容器 */
pmdb014       varchar2(10)      ,/* 供应商选择 */
pmdb015       varchar2(10)      ,/* 供应商编号 */
pmdb016       varchar2(10)      ,/* 付款条件 */
pmdb017       varchar2(10)      ,/* 交易条件 */
pmdb018       number(5,2)      ,/* 税率 */
pmdb019       number(20,6)      ,/* 参考单价 */
pmdb020       number(20,6)      ,/* 参考税前金额 */
pmdb021       number(20,6)      ,/* 参考含税金额 */
pmdb030       date      ,/* 需求日期 */
pmdb031       varchar2(10)      ,/* 理由码 */
pmdb032       varchar2(10)      ,/* 行状态 */
pmdb033       varchar2(10)      ,/* 紧急度 */
pmdb034       varchar2(20)      ,/* 项目编号 */
pmdb035       varchar2(30)      ,/* WBS */
pmdb036       varchar2(30)      ,/* 活动编号 */
pmdb037       varchar2(10)      ,/* 收货据点 */
pmdb038       varchar2(10)      ,/* 收货库位 */
pmdb039       varchar2(10)      ,/* 收货储位 */
pmdb040       number(20,6)      ,/* no use */
pmdb041       varchar2(1)      ,/* 允许部份交货 */
pmdb042       varchar2(1)      ,/* 允许提前交货 */
pmdb043       varchar2(1)      ,/* 保税 */
pmdb044       varchar2(1)      ,/* 纳入APS */
pmdb045       varchar2(1)      ,/* 交期冻结否 */
pmdb046       varchar2(10)      ,/* 费用部门 */
pmdb048       varchar2(10)      ,/* 收货时段 */
pmdb049       number(20,6)      ,/* 已转采购量 */
pmdb050       varchar2(255)      ,/* 备注 */
pmdb051       varchar2(10)      ,/* 结案/留置理由码 */
pmdb200       varchar2(40)      ,/* 商品条码 */
pmdb201       varchar2(10)      ,/* 包装单位 */
pmdb202       number(20,6)      ,/* 件装数 */
pmdb203       varchar2(10)      ,/* 配送中心 */
pmdb204       varchar2(10)      ,/* 配送仓库 */
pmdb205       varchar2(10)      ,/* 采购中心 */
pmdb206       varchar2(20)      ,/* 采购员 */
pmdb207       varchar2(10)      ,/* 采购方式 */
pmdb208       varchar2(10)      ,/* 经营方式 */
pmdb209       varchar2(10)      ,/* 结算方式 */
pmdb210       date      ,/* 促销开始日 */
pmdb211       date      ,/* 促销结束日 */
pmdb212       number(20,6)      ,/* 要货件数 */
pmdb250       number(20,6)      ,/* 合理库存 */
pmdb251       number(20,6)      ,/* 最高库存 */
pmdb252       number(20,6)      ,/* 现有库存 */
pmdb253       number(20,6)      ,/* 入库在途量 */
pmdb254       number(20,6)      ,/* 前一周销量 */
pmdb255       number(20,6)      ,/* 前二周销量 */
pmdb256       number(20,6)      ,/* 前三周销量 */
pmdb257       number(20,6)      ,/* 前四周销量 */
pmdb258       number(20,6)      ,/* 要货在途量 */
pmdb259       number(20,6)      ,/* 周平均销量 */
pmdb900       number(20,6)      ,/* 保留字段str */
pmdb999       number(20,6)      ,/* 保留字段end */
pmdbud001       varchar2(40)      ,/* 自定义字段(文本)001 */
pmdbud002       varchar2(40)      ,/* 自定义字段(文本)002 */
pmdbud003       varchar2(40)      ,/* 自定义字段(文本)003 */
pmdbud004       varchar2(40)      ,/* 自定义字段(文本)004 */
pmdbud005       varchar2(40)      ,/* 自定义字段(文本)005 */
pmdbud006       varchar2(40)      ,/* 自定义字段(文本)006 */
pmdbud007       varchar2(40)      ,/* 自定义字段(文本)007 */
pmdbud008       varchar2(40)      ,/* 自定义字段(文本)008 */
pmdbud009       varchar2(40)      ,/* 自定义字段(文本)009 */
pmdbud010       varchar2(40)      ,/* 自定义字段(文本)010 */
pmdbud011       number(20,6)      ,/* 自定义字段(数字)011 */
pmdbud012       number(20,6)      ,/* 自定义字段(数字)012 */
pmdbud013       number(20,6)      ,/* 自定义字段(数字)013 */
pmdbud014       number(20,6)      ,/* 自定义字段(数字)014 */
pmdbud015       number(20,6)      ,/* 自定义字段(数字)015 */
pmdbud016       number(20,6)      ,/* 自定义字段(数字)016 */
pmdbud017       number(20,6)      ,/* 自定义字段(数字)017 */
pmdbud018       number(20,6)      ,/* 自定义字段(数字)018 */
pmdbud019       number(20,6)      ,/* 自定义字段(数字)019 */
pmdbud020       number(20,6)      ,/* 自定义字段(数字)020 */
pmdbud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
pmdbud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
pmdbud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
pmdbud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
pmdbud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
pmdbud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
pmdbud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
pmdbud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
pmdbud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
pmdbud030       timestamp(0)      ,/* 自定义字段(日期时间)030 */
pmdb260       varchar2(10)      ,/* 收货部门 */
pmdb052       number(10,0)      ,/* 来源分批序 */
pmdb227       varchar2(80)      ,/* 补货规格说明 */
pmdb053       varchar2(10)      ,/* 预算细项 */
pmdb213       number(20,6)      ,/* 参考进价 */
pmdb054       varchar2(30)      ,/* 库存管理特征 */
pmdb214       varchar2(8)      ,/* 需求时间 */
pmdb261       number(20,6)      /* 门店要货量 */
);
alter table pmdb_t add constraint pmdb_pk primary key (pmdbent,pmdbdocno,pmdbseq) enable validate;

create unique index pmdb_pk on pmdb_t (pmdbent,pmdbdocno,pmdbseq);

grant select on pmdb_t to tiptop;
grant update on pmdb_t to tiptop;
grant delete on pmdb_t to tiptop;
grant insert on pmdb_t to tiptop;

exit;
