/* 
================================================================================
檔案代號:xmeg_t
檔案名稱:订单变更单身明细档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table xmeg_t
(
xmegent       number(5)      ,/* 企业编号 */
xmegsite       varchar2(10)      ,/* 营运据点 */
xmegdocno       varchar2(20)      ,/* 采购单号 */
xmegseq       number(10,0)      ,/* 项次 */
xmeg001       varchar2(40)      ,/* 料件编号 */
xmeg002       varchar2(256)      ,/* 产品特征 */
xmeg003       varchar2(40)      ,/* 包装容器 */
xmeg004       varchar2(10)      ,/* 作业编号 */
xmeg005       varchar2(10)      ,/* 工艺序 */
xmeg006       varchar2(10)      ,/* 销售单位 */
xmeg007       number(20,6)      ,/* 销售数量 */
xmeg008       varchar2(10)      ,/* 参考单位 */
xmeg009       number(20,6)      ,/* 参考数量 */
xmeg010       varchar2(10)      ,/* 计价单位 */
xmeg011       number(20,6)      ,/* 计价数量 */
xmeg012       date      ,/* 约定交货日 */
xmeg013       date      ,/* 预定签收日 */
xmeg015       number(20,6)      ,/* 单价 */
xmeg016       varchar2(10)      ,/* 税种 */
xmeg017       number(5,2)      ,/* 税率 */
xmeg019       varchar2(10)      ,/* 子件特性 */
xmeg020       varchar2(10)      ,/* 急料 */
xmeg021       varchar2(1)      ,/* 保税 */
xmeg022       varchar2(1)      ,/* 部分交货 */
xmegunit       varchar2(10)      ,/* 出货据点 */
xmegorga       varchar2(10)      ,/* 收款据点 */
xmeg023       varchar2(10)      ,/* 收货客户 */
xmeg024       varchar2(1)      ,/* 多交期 */
xmeg025       varchar2(10)      ,/* 收货地址编号 */
xmeg026       varchar2(10)      ,/* 账款地址编号 */
xmeg027       varchar2(40)      ,/* 客户料号 */
xmeg028       varchar2(10)      ,/* 限定库位 */
xmeg029       varchar2(10)      ,/* 限定储位 */
xmeg030       varchar2(30)      ,/* 限定批号 */
xmeg031       varchar2(10)      ,/* 运输方式 */
xmeg032       varchar2(10)      ,/* 取货模式 */
xmeg033       number(20,6)      ,/* 备品率 */
xmeg034       number(20,6)      ,/* 可超交率 */
xmeg035       varchar2(10)      ,/* 价格核决 */
xmeg036       varchar2(20)      ,/* 项目编号 */
xmeg037       varchar2(30)      ,/* WBS编号 */
xmeg038       varchar2(30)      ,/* 活动编号 */
xmeg039       varchar2(10)      ,/* 费用原因 */
xmeg040       varchar2(10)      ,/* 取价来源 */
xmeg041       varchar2(20)      ,/* 价格参考单号 */
xmeg042       number(10,0)      ,/* 价格参考项次 */
xmeg043       number(20,6)      ,/* 取出价格 */
xmeg044       number(20,6)      ,/* 价差比 */
xmeg045       varchar2(10)      ,/* 状态码 */
xmeg046       number(20,6)      ,/* 税前金额 */
xmeg047       number(20,6)      ,/* 含税金额 */
xmeg048       number(20,6)      ,/* 税额 */
xmeg049       varchar2(10)      ,/* 理由码 */
xmeg050       varchar2(255)      ,/* 备注 */
xmeg051       number(10,0)      ,/* 客户订单项次 */
xmeg052       varchar2(1)      ,/* 检验否 */
xmeg053       varchar2(10)      ,/* 结案理由码 */
xmeg900       number(10,0)      ,/* 变更序 */
xmeg901       varchar2(1)      ,/* 变更类型 */
xmeg902       varchar2(10)      ,/* 变更理由 */
xmeg903       varchar2(255)      ,/* 变更备注 */
xmegud001       varchar2(40)      ,/* 自定义字段(文本)001 */
xmegud002       varchar2(40)      ,/* 自定义字段(文本)002 */
xmegud003       varchar2(40)      ,/* 自定义字段(文本)003 */
xmegud004       varchar2(40)      ,/* 自定义字段(文本)004 */
xmegud005       varchar2(40)      ,/* 自定义字段(文本)005 */
xmegud006       varchar2(40)      ,/* 自定义字段(文本)006 */
xmegud007       varchar2(40)      ,/* 自定义字段(文本)007 */
xmegud008       varchar2(40)      ,/* 自定义字段(文本)008 */
xmegud009       varchar2(40)      ,/* 自定义字段(文本)009 */
xmegud010       varchar2(40)      ,/* 自定义字段(文本)010 */
xmegud011       number(20,6)      ,/* 自定义字段(数字)011 */
xmegud012       number(20,6)      ,/* 自定义字段(数字)012 */
xmegud013       number(20,6)      ,/* 自定义字段(数字)013 */
xmegud014       number(20,6)      ,/* 自定义字段(数字)014 */
xmegud015       number(20,6)      ,/* 自定义字段(数字)015 */
xmegud016       number(20,6)      ,/* 自定义字段(数字)016 */
xmegud017       number(20,6)      ,/* 自定义字段(数字)017 */
xmegud018       number(20,6)      ,/* 自定义字段(数字)018 */
xmegud019       number(20,6)      ,/* 自定义字段(数字)019 */
xmegud020       number(20,6)      ,/* 自定义字段(数字)020 */
xmegud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
xmegud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
xmegud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
xmegud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
xmegud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
xmegud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
xmegud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
xmegud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
xmegud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
xmegud030       timestamp(0)      ,/* 自定义字段(日期时间)030 */
xmeg054       date      ,/* BOM有效日期 */
xmeg055       varchar2(20)      ,/* 来源单号 */
xmeg056       number(10,0)      ,/* 来源项次 */
xmeg057       varchar2(30)      ,/* 库存管理特征 */
xmeg058       number(20,6)      ,/* 还量数量 */
xmeg059       number(20,6)      ,/* 还量参考数量 */
xmeg060       number(20,6)      ,/* 还价数量 */
xmeg061       number(20,6)      ,/* 还价参考数量 */
xmeg062       varchar2(30)      /* BOM特性 */
);
alter table xmeg_t add constraint xmeg_pk primary key (xmegent,xmegdocno,xmegseq,xmeg900) enable validate;

create unique index xmeg_pk on xmeg_t (xmegent,xmegdocno,xmegseq,xmeg900);

grant select on xmeg_t to tiptop;
grant update on xmeg_t to tiptop;
grant delete on xmeg_t to tiptop;
grant insert on xmeg_t to tiptop;

exit;
