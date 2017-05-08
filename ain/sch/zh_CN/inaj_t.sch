/* 
================================================================================
檔案代號:inaj_t
檔案名稱:库存交易明细档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table inaj_t
(
inajent       number(5)      ,/* 企业编号 */
inajsite       varchar2(10)      ,/* 营运据点 */
inaj001       varchar2(20)      ,/* 单据编号 */
inaj002       number(10,0)      ,/* 项次 */
inaj003       number(10,0)      ,/* 项序 */
inaj004       number(5,0)      ,/* 出入库码 */
inaj005       varchar2(40)      ,/* 料件编号 */
inaj006       varchar2(256)      ,/* 产品特征 */
inaj007       varchar2(30)      ,/* 库存管理特征 */
inaj008       varchar2(10)      ,/* 库位编号 */
inaj009       varchar2(10)      ,/* 储位编号 */
inaj010       varchar2(30)      ,/* 批号 */
inaj011       number(20,6)      ,/* 交易数量 */
inaj012       varchar2(10)      ,/* 交易单位 */
inaj013       number(20,6)      ,/* 交易单位与库存单位换算率 */
inaj014       number(20,6)      ,/* 交易单位与料件基本单位换算率 */
inaj015       varchar2(20)      ,/* 异动单据性质 */
inaj016       varchar2(10)      ,/* 理由码 */
inaj017       varchar2(10)      ,/* 异动部门编号 */
inaj018       varchar2(10)      ,/* 异动供应商/客户编号 */
inaj019       varchar2(255)      ,/* 备注 */
inaj020       varchar2(40)      ,/* 工单单号 */
inaj021       varchar2(20)      ,/* 多角序号 */
inaj022       date      ,/* 单据扣账日期 */
inaj023       date      ,/* 实际运行扣账日期 */
inaj024       varchar2(8)      ,/* 数据生成时间 */
inaj025       varchar2(20)      ,/* 异动数据生成者 */
inaj026       varchar2(10)      ,/* 参考单位 */
inaj027       number(20,6)      ,/* 参考数量 */
inaj028       varchar2(40)      ,/* 成本料号 */
inaj036       varchar2(10)      ,/* 库存异动类型 */
inaj029       number(20,6)      ,/* 交易单位与成本单位换算率 */
inaj030       varchar2(10)      ,/* VMI交易结算否 */
inaj031       varchar2(20)      ,/* VMI对应入库/仓退单号 */
inaj032       number(10,0)      ,/* VMI对应入库/仓退项次 */
inaj033       varchar2(20)      ,/* VMI对应杂发/杂收单号 */
inaj034       number(10,0)      ,/* VMI对应杂发/杂收项次 */
inaj035       varchar2(20)      ,/* 异动作业编号 */
inaj037       varchar2(10)      ,/* 成本中心 */
inaj038       varchar2(20)      ,/* 项目编号 */
inaj039       varchar2(30)      ,/* WBS编号 */
inaj040       varchar2(10)      ,/* 重复性生产-计划编号 */
inaj041       varchar2(40)      ,/* 重复性生产-生产料号 */
inaj042       varchar2(30)      ,/* 重复性生产-生产料号BOM特性 */
inaj043       varchar2(256)      ,/* 重复性生产-生产料号产品特征 */
inaj044       varchar2(20)      ,/* 来源单号 */
inaj200       varchar2(1)      ,/* 内部结算否 */
inaj201       varchar2(10)      ,/* 业务类型 */
inaj202       varchar2(10)      ,/* 内部交易类型 */
inaj203       varchar2(10)      ,/* 币种 */
inaj204       varchar2(10)      ,/* 税种 */
inaj205       number(20,6)      ,/* 内部结算税前金额 */
inaj206       number(20,6)      ,/* 内部结算含税金额 */
inaj207       varchar2(10)      ,/* 交易所属法人 */
inaj208       varchar2(10)      ,/* 内部交易对象组织 */
inaj209       varchar2(10)      ,/* 内部交易对象法人 */
inajud001       varchar2(40)      ,/* 自定义字段(文本)001 */
inajud002       varchar2(40)      ,/* 自定义字段(文本)002 */
inajud003       varchar2(40)      ,/* 自定义字段(文本)003 */
inajud004       varchar2(40)      ,/* 自定义字段(文本)004 */
inajud005       varchar2(40)      ,/* 自定义字段(文本)005 */
inajud006       varchar2(40)      ,/* 自定义字段(文本)006 */
inajud007       varchar2(40)      ,/* 自定义字段(文本)007 */
inajud008       varchar2(40)      ,/* 自定义字段(文本)008 */
inajud009       varchar2(40)      ,/* 自定义字段(文本)009 */
inajud010       varchar2(40)      ,/* 自定义字段(文本)010 */
inajud011       number(20,6)      ,/* 自定义字段(数字)011 */
inajud012       number(20,6)      ,/* 自定义字段(数字)012 */
inajud013       number(20,6)      ,/* 自定义字段(数字)013 */
inajud014       number(20,6)      ,/* 自定义字段(数字)014 */
inajud015       number(20,6)      ,/* 自定义字段(数字)015 */
inajud016       number(20,6)      ,/* 自定义字段(数字)016 */
inajud017       number(20,6)      ,/* 自定义字段(数字)017 */
inajud018       number(20,6)      ,/* 自定义字段(数字)018 */
inajud019       number(20,6)      ,/* 自定义字段(数字)019 */
inajud020       number(20,6)      ,/* 自定义字段(数字)020 */
inajud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
inajud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
inajud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
inajud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
inajud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
inajud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
inajud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
inajud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
inajud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
inajud030       timestamp(0)      ,/* 自定义字段(日期时间)030 */
inaj045       varchar2(10)      ,/* 异动时库存单位 */
inaj046       number(20,6)      ,/* 交易单位与库存单位换算分子 */
inaj047       number(20,6)      ,/* 交易单位与库存单位换算分母 */
inaj048       number(20,6)      ,/* 交易单位与料件基本单位换算分子 */
inaj049       number(20,6)      ,/* 交易单位与料件基本单位换算分母 */
inaj050       number(20,6)      ,/* 交易单位与成本单位换算分子 */
inaj051       number(20,6)      ,/* 交易单位与成本单位换算分母 */
inaj210       number(20,6)      ,/* 单据单价 */
inaj211       varchar2(10)      /* 品类 */
);
alter table inaj_t add constraint inaj_pk primary key (inajent,inajsite,inaj001,inaj002,inaj003,inaj004) enable validate;

create  index inaj_n01 on inaj_t (inajent,inajsite,inaj005,inaj015,inaj023);
create  index inaj_n02 on inaj_t (inajent,inaj020,inaj022);
create  index inaj_n03 on inaj_t (inajent,inaj020,inaj022,inaj036);
create  index inaj_n04 on inaj_t (inaj004,inaj005,inaj006,inaj007,inaj008,inaj009,inaj022,inaj045);
create unique index inaj_pk on inaj_t (inajent,inajsite,inaj001,inaj002,inaj003,inaj004);

grant select on inaj_t to tiptop;
grant update on inaj_t to tiptop;
grant delete on inaj_t to tiptop;
grant insert on inaj_t to tiptop;

exit;
