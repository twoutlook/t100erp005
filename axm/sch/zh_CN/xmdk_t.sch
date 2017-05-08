/* 
================================================================================
檔案代號:xmdk_t
檔案名稱:出货/签收/销退单单头档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table xmdk_t
(
xmdkent       number(5)      ,/* 企业编号 */
xmdksite       varchar2(10)      ,/* 营运据点 */
xmdkunit       varchar2(10)      ,/* 应用组织 */
xmdkdocno       varchar2(20)      ,/* 单据单号 */
xmdkdocdt       date      ,/* 单据日期 */
xmdk000       varchar2(10)      ,/* 单据性质 */
xmdk001       date      ,/* 扣账日期 */
xmdk002       varchar2(10)      ,/* 出货性质 */
xmdk003       varchar2(20)      ,/* 业务人员 */
xmdk004       varchar2(10)      ,/* 业务部门 */
xmdk005       varchar2(20)      ,/* 出通/出货单号 */
xmdk006       varchar2(20)      ,/* 订单单号 */
xmdk007       varchar2(10)      ,/* 订单客户 */
xmdk008       varchar2(10)      ,/* 收款客户 */
xmdk009       varchar2(10)      ,/* 收货客户 */
xmdk010       varchar2(10)      ,/* 收款条件 */
xmdk011       varchar2(10)      ,/* 交易条件 */
xmdk012       varchar2(10)      ,/* 税种 */
xmdk013       number(5,2)      ,/* 税率 */
xmdk014       varchar2(10)      ,/* 单价含税否 */
xmdk015       varchar2(2)      ,/* 发票类型 */
xmdk016       varchar2(10)      ,/* 币种 */
xmdk017       number(20,10)      ,/* 汇率 */
xmdk018       varchar2(10)      ,/* 取价方式 */
xmdk019       varchar2(10)      ,/* 优惠条件 */
xmdk020       varchar2(10)      ,/* 送货供应商 */
xmdk021       varchar2(10)      ,/* 送货地址 */
xmdk022       varchar2(10)      ,/* 运输方式 */
xmdk023       varchar2(10)      ,/* 交运起点 */
xmdk024       varchar2(10)      ,/* 交运终点 */
xmdk025       varchar2(20)      ,/* 航次/航班/车号 */
xmdk026       date      ,/* 起运日期 */
xmdk027       varchar2(30)      ,/* 唛头编号 */
xmdk028       varchar2(10)      ,/* 包装单制作 */
xmdk029       varchar2(10)      ,/* Invoice制作 */
xmdk030       varchar2(10)      ,/* 销售渠道 */
xmdk031       varchar2(10)      ,/* 销售分类 */
xmdk032       date      ,/* 结关日期 */
xmdk033       varchar2(10)      ,/* 额外品名规格 */
xmdk034       varchar2(10)      ,/* 留置原因 */
xmdk035       varchar2(20)      ,/* 多角序号 */
xmdk036       varchar2(20)      ,/* 集成单号 */
xmdk037       varchar2(20)      ,/* 发票号码 */
xmdk038       varchar2(10)      ,/* 运输状态 */
xmdk039       varchar2(10)      ,/* 在途成本库位 */
xmdk040       varchar2(10)      ,/* 在途非成本库位 */
xmdk041       varchar2(20)      ,/* 发票编号 */
xmdk042       varchar2(10)      ,/* 内外销 */
xmdk043       varchar2(10)      ,/* 汇率计算基准 */
xmdk044       varchar2(10)      ,/* 多角流程编号 */
xmdk045       varchar2(10)      ,/* 多角性质 */
xmdk051       number(20,6)      ,/* 总税前金额 */
xmdk052       number(20,6)      ,/* 总含税金额 */
xmdk053       number(20,6)      ,/* 总税额 */
xmdk054       varchar2(255)      ,/* 备注 */
xmdk055       date      ,/* 客户收货日 */
xmdk081       varchar2(20)      ,/* 对应的签收单号 */
xmdk082       varchar2(10)      ,/* 销退方式 */
xmdk083       varchar2(1)      ,/* 多角贸易已抛转 */
xmdk084       varchar2(10)      ,/* 折让证明单开立否 */
xmdk200       varchar2(10)      ,/* 调货经销商编号 */
xmdk201       varchar2(10)      ,/* 代送商编号 */
xmdk202       varchar2(10)      ,/* 发票客户 */
xmdk203       varchar2(30)      ,/* 促销方案编号 */
xmdk204       number(20,6)      ,/* 整单折扣 */
xmdk205       varchar2(10)      ,/* 送货站点编号 */
xmdk206       varchar2(10)      ,/* 运输路线编号 */
xmdk207       varchar2(10)      ,/* 销售组织 */
xmdk208       varchar2(20)      ,/* 调货出货单号 */
xmdk209       varchar2(10)      ,/* No Use */
xmdk210       varchar2(10)      ,/* No Use */
xmdk211       varchar2(10)      ,/* No Use */
xmdk212       varchar2(10)      ,/* No Use */
xmdk213       number(20,6)      ,/* 本币含税总金额 */
xmdk214       varchar2(1)      ,/* 收款完成否 */
xmdkownid       varchar2(20)      ,/* 资料所有者 */
xmdkowndp       varchar2(10)      ,/* 资料所有部门 */
xmdkcrtid       varchar2(20)      ,/* 资料录入者 */
xmdkcrtdp       varchar2(10)      ,/* 资料录入部门 */
xmdkcrtdt       timestamp(0)      ,/* 资料创建日 */
xmdkmodid       varchar2(20)      ,/* 资料更改者 */
xmdkmoddt       timestamp(0)      ,/* 最近更改日 */
xmdkcnfid       varchar2(20)      ,/* 资料审核者 */
xmdkcnfdt       timestamp(0)      ,/* 数据审核日 */
xmdkpstid       varchar2(20)      ,/* 资料过账者 */
xmdkpstdt       timestamp(0)      ,/* 资料过账日 */
xmdkstus       varchar2(10)      ,/* 状态码 */
xmdkud001       varchar2(40)      ,/* 自定义字段(文本)001 */
xmdkud002       varchar2(40)      ,/* 自定义字段(文本)002 */
xmdkud003       varchar2(40)      ,/* 自定义字段(文本)003 */
xmdkud004       varchar2(40)      ,/* 自定义字段(文本)004 */
xmdkud005       varchar2(40)      ,/* 自定义字段(文本)005 */
xmdkud006       varchar2(40)      ,/* 自定义字段(文本)006 */
xmdkud007       varchar2(40)      ,/* 自定义字段(文本)007 */
xmdkud008       varchar2(40)      ,/* 自定义字段(文本)008 */
xmdkud009       varchar2(40)      ,/* 自定义字段(文本)009 */
xmdkud010       varchar2(40)      ,/* 自定义字段(文本)010 */
xmdkud011       number(20,6)      ,/* 自定义字段(数字)011 */
xmdkud012       number(20,6)      ,/* 自定义字段(数字)012 */
xmdkud013       number(20,6)      ,/* 自定义字段(数字)013 */
xmdkud014       number(20,6)      ,/* 自定义字段(数字)014 */
xmdkud015       number(20,6)      ,/* 自定义字段(数字)015 */
xmdkud016       number(20,6)      ,/* 自定义字段(数字)016 */
xmdkud017       number(20,6)      ,/* 自定义字段(数字)017 */
xmdkud018       number(20,6)      ,/* 自定义字段(数字)018 */
xmdkud019       number(20,6)      ,/* 自定义字段(数字)019 */
xmdkud020       number(20,6)      ,/* 自定义字段(数字)020 */
xmdkud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
xmdkud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
xmdkud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
xmdkud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
xmdkud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
xmdkud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
xmdkud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
xmdkud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
xmdkud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
xmdkud030       timestamp(0)      ,/* 自定义字段(日期时间)030 */
xmdk085       varchar2(10)      ,/* 数据源(销退) */
xmdk086       varchar2(20)      ,/* 来源单号(销退) */
xmdk046       varchar2(10)      ,/* 集成来源 */
xmdk087       varchar2(1)      ,/* 出货走发票仓调拨 */
xmdk047       varchar2(20)      ,/* 一次性交易对象识别码 */
xmdk088       varchar2(10)      ,/* 来源类型 */
xmdk089       varchar2(20)      ,/* 来源单号 */
xmdk048       varchar2(20)      ,/* 进口报单 */
xmdk049       date      ,/* 进口日期 */
xmdk050       varchar2(10)      /* 保税异动原因编号 */
);
alter table xmdk_t add constraint xmdk_pk primary key (xmdkent,xmdkdocno) enable validate;

create unique index xmdk_pk on xmdk_t (xmdkent,xmdkdocno);

grant select on xmdk_t to tiptop;
grant update on xmdk_t to tiptop;
grant delete on xmdk_t to tiptop;
grant insert on xmdk_t to tiptop;

exit;
