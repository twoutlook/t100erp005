/* 
================================================================================
檔案代號:pmds_t
檔案名稱:收货/入库单头档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table pmds_t
(
pmdsent       number(5)      ,/* 企业编号 */
pmdssite       varchar2(10)      ,/* 营运据点 */
pmdsdocno       varchar2(20)      ,/* 单据单号 */
pmdsdocdt       date      ,/* 单据日期 */
pmds000       varchar2(10)      ,/* 单据性质 */
pmds001       date      ,/* 扣账日期 */
pmds002       varchar2(20)      ,/* 申请人员 */
pmds003       varchar2(10)      ,/* 申请部门 */
pmds006       varchar2(20)      ,/* 来源单号 */
pmds007       varchar2(10)      ,/* 采购供应商 */
pmds008       varchar2(10)      ,/* 账款供应商 */
pmds009       varchar2(10)      ,/* 送货供应商 */
pmds010       varchar2(40)      ,/* 供应商送货单号 */
pmds011       varchar2(10)      ,/* 采购性质 */
pmds012       varchar2(10)      ,/* 采购渠道 */
pmds013       varchar2(10)      ,/* 采购分类 */
pmds014       varchar2(10)      ,/* 多角性质 */
pmds021       varchar2(1)      ,/* LC进口 */
pmds022       date      ,/* 进口日期 */
pmds023       varchar2(20)      ,/* 进口报单 */
pmds024       varchar2(20)      ,/* 进口号码 */
pmds028       varchar2(20)      ,/* 一次性交易对象识别码 */
pmds031       varchar2(10)      ,/* 付款条件 */
pmds032       varchar2(10)      ,/* 交易条件 */
pmds033       varchar2(10)      ,/* 税种 */
pmds034       number(5,2)      ,/* 税率 */
pmds035       varchar2(1)      ,/* 单价含税否 */
pmds036       varchar2(10)      ,/* 交易类型 */
pmds037       varchar2(10)      ,/* 币种 */
pmds038       number(20,10)      ,/* 汇率 */
pmds039       varchar2(10)      ,/* 取价方式 */
pmds040       varchar2(10)      ,/* 付款优惠条件 */
pmds041       varchar2(20)      ,/* 多角序号 */
pmds042       varchar2(20)      ,/* 集成单号 */
pmds043       number(20,6)      ,/* 采购总税前金额 */
pmds044       number(20,6)      ,/* 采购总含税金额 */
pmds045       varchar2(255)      ,/* 备注 */
pmds046       number(20,6)      ,/* 采购总税额 */
pmds047       varchar2(1)      ,/* 多角贸易中断点 */
pmds048       varchar2(10)      ,/* 内外购 */
pmds049       varchar2(10)      ,/* 汇率计算基准 */
pmds050       varchar2(1)      ,/* 多角贸易已抛转 */
pmds051       varchar2(20)      ,/* 出货单号 */
pmds052       date      ,/* 供应商出货日 */
pmds053       varchar2(10)      ,/* 多角流程编号 */
pmds081       date      ,/* 取回日期 */
pmds100       varchar2(10)      ,/* 仓退方式 */
pmds101       date      ,/* 折让日期 */
pmds102       varchar2(20)      ,/* 折让原始发票 */
pmdsownid       varchar2(20)      ,/* 资料所有者 */
pmdsowndp       varchar2(10)      ,/* 资料所有部门 */
pmdscrtid       varchar2(20)      ,/* 资料录入者 */
pmdscrtdp       varchar2(10)      ,/* 资料录入部门 */
pmdscrtdt       timestamp(0)      ,/* 资料创建日 */
pmdsmodid       varchar2(20)      ,/* 资料更改者 */
pmdsmoddt       timestamp(0)      ,/* 最近更改日 */
pmdscnfid       varchar2(20)      ,/* 资料审核者 */
pmdscnfdt       timestamp(0)      ,/* 数据审核日 */
pmdspstid       varchar2(20)      ,/* 资料过账者 */
pmdspstdt       timestamp(0)      ,/* 资料过账日 */
pmdsstus       varchar2(10)      ,/* 状态码 */
pmdsud001       varchar2(40)      ,/* 自定义字段(文本)001 */
pmdsud002       varchar2(40)      ,/* 自定义字段(文本)002 */
pmdsud003       varchar2(40)      ,/* 自定义字段(文本)003 */
pmdsud004       varchar2(40)      ,/* 自定义字段(文本)004 */
pmdsud005       varchar2(40)      ,/* 自定义字段(文本)005 */
pmdsud006       varchar2(40)      ,/* 自定义字段(文本)006 */
pmdsud007       varchar2(40)      ,/* 自定义字段(文本)007 */
pmdsud008       varchar2(40)      ,/* 自定义字段(文本)008 */
pmdsud009       varchar2(40)      ,/* 自定义字段(文本)009 */
pmdsud010       varchar2(40)      ,/* 自定义字段(文本)010 */
pmdsud011       number(20,6)      ,/* 自定义字段(数字)011 */
pmdsud012       number(20,6)      ,/* 自定义字段(数字)012 */
pmdsud013       number(20,6)      ,/* 自定义字段(数字)013 */
pmdsud014       number(20,6)      ,/* 自定义字段(数字)014 */
pmdsud015       number(20,6)      ,/* 自定义字段(数字)015 */
pmdsud016       number(20,6)      ,/* 自定义字段(数字)016 */
pmdsud017       number(20,6)      ,/* 自定义字段(数字)017 */
pmdsud018       number(20,6)      ,/* 自定义字段(数字)018 */
pmdsud019       number(20,6)      ,/* 自定义字段(数字)019 */
pmdsud020       number(20,6)      ,/* 自定义字段(数字)020 */
pmdsud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
pmdsud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
pmdsud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
pmdsud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
pmdsud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
pmdsud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
pmdsud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
pmdsud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
pmdsud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
pmdsud030       timestamp(0)      ,/* 自定义字段(日期时间)030 */
pmds200       varchar2(20)      ,/* 收货预约单号 */
pmds054       varchar2(10)      ,/* 数据源 */
pmds055       varchar2(20)      ,/* 来源单号 */
pmds201       varchar2(20)      ,/* 来源单号 */
pmds202       varchar2(10)      ,/* 来源类型 */
pmdsunit       varchar2(10)      ,/* 应用运行组织对象 */
pmds056       varchar2(40)      ,/* No use */
pmds057       varchar2(10)      ,/* 集成来源 */
pmds058       varchar2(20)      ,/* 倒扣领料单号 */
pmds103       varchar2(10)      /* 折让证明单开立方式 */
);
alter table pmds_t add constraint pmds_pk primary key (pmdsent,pmdsdocno) enable validate;

create unique index pmds_pk on pmds_t (pmdsent,pmdsdocno);

grant select on pmds_t to tiptop;
grant update on pmds_t to tiptop;
grant delete on pmds_t to tiptop;
grant insert on pmds_t to tiptop;

exit;
