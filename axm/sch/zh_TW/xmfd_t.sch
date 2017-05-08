/* 
================================================================================
檔案代號:xmfd_t
檔案名稱:销售报价单头档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table xmfd_t
(
xmfdent       number(5)      ,/* 企业编号 */
xmfdsite       varchar2(10)      ,/* 营运据点 */
xmfddocno       varchar2(20)      ,/* 报价单号 */
xmfddocdt       date      ,/* 报价日期 */
xmfd001       varchar2(20)      ,/* 业务人员 */
xmfd002       varchar2(10)      ,/* 业务部门 */
xmfd003       varchar2(10)      ,/* 客户编号 */
xmfd004       varchar2(10)      ,/* no use */
xmfd005       varchar2(20)      ,/* 估价单号 */
xmfd006       varchar2(20)      ,/* 客户单号 */
xmfd007       date      ,/* 报价有效日期 */
xmfd008       varchar2(10)      ,/* 生成方式 */
xmfd009       varchar2(20)      ,/* 范本编号 */
xmfd010       varchar2(10)      ,/* 币种 */
xmfd011       number(20,10)      ,/* 汇率 */
xmfd012       varchar2(10)      ,/* 税种 */
xmfd013       number(5,2)      ,/* 税率 */
xmfd014       varchar2(1)      ,/* 单价含税否 */
xmfd015       varchar2(10)      ,/* 交易条件 */
xmfd016       varchar2(10)      ,/* 收款条件 */
xmfd017       varchar2(10)      ,/* 取价方式 */
xmfd018       varchar2(10)      ,/* 销售渠道 */
xmfd019       varchar2(10)      ,/* 运送方式 */
xmfd020       varchar2(10)      ,/* 起运地 */
xmfd021       varchar2(10)      ,/* 目的地 */
xmfd022       varchar2(10)      ,/* 出货地址 */
xmfd023       varchar2(10)      ,/* 材积计算方式 */
xmfd024       number(20,6)      ,/* 预估销售金额 */
xmfd025       number(20,6)      ,/* 预估成本 */
xmfd026       number(20,6)      ,/* 预估销售费用 */
xmfd027       number(20,6)      ,/* 预估毛利率 */
xmfd028       number(20,6)      ,/* 预估利润率 */
xmfd029       varchar2(255)      ,/* 备注 */
xmfdownid       varchar2(20)      ,/* 资料所有者 */
xmfdowndp       varchar2(10)      ,/* 资料所有部门 */
xmfdcrtid       varchar2(20)      ,/* 资料录入者 */
xmfdcrtdp       varchar2(10)      ,/* 资料录入部门 */
xmfdcrtdt       timestamp(0)      ,/* 资料创建日 */
xmfdmodid       varchar2(20)      ,/* 资料更改者 */
xmfdmoddt       timestamp(0)      ,/* 资料更改日 */
xmfdcnfid       varchar2(20)      ,/* 资料审核者 */
xmfdcnfdt       timestamp(0)      ,/* 数据审核日 */
xmfdpstid       varchar2(20)      ,/* 资料过账者 */
xmfdpstdt       timestamp(0)      ,/* 资料过账日 */
xmfdstus       varchar2(10)      ,/* 状态码 */
xmfdud001       varchar2(40)      ,/* 自定义字段(文本)001 */
xmfdud002       varchar2(40)      ,/* 自定义字段(文本)002 */
xmfdud003       varchar2(40)      ,/* 自定义字段(文本)003 */
xmfdud004       varchar2(40)      ,/* 自定义字段(文本)004 */
xmfdud005       varchar2(40)      ,/* 自定义字段(文本)005 */
xmfdud006       varchar2(40)      ,/* 自定义字段(文本)006 */
xmfdud007       varchar2(40)      ,/* 自定义字段(文本)007 */
xmfdud008       varchar2(40)      ,/* 自定义字段(文本)008 */
xmfdud009       varchar2(40)      ,/* 自定义字段(文本)009 */
xmfdud010       varchar2(40)      ,/* 自定义字段(文本)010 */
xmfdud011       number(20,6)      ,/* 自定义字段(数字)011 */
xmfdud012       number(20,6)      ,/* 自定义字段(数字)012 */
xmfdud013       number(20,6)      ,/* 自定义字段(数字)013 */
xmfdud014       number(20,6)      ,/* 自定义字段(数字)014 */
xmfdud015       number(20,6)      ,/* 自定义字段(数字)015 */
xmfdud016       number(20,6)      ,/* 自定义字段(数字)016 */
xmfdud017       number(20,6)      ,/* 自定义字段(数字)017 */
xmfdud018       number(20,6)      ,/* 自定义字段(数字)018 */
xmfdud019       number(20,6)      ,/* 自定义字段(数字)019 */
xmfdud020       number(20,6)      ,/* 自定义字段(数字)020 */
xmfdud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
xmfdud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
xmfdud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
xmfdud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
xmfdud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
xmfdud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
xmfdud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
xmfdud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
xmfdud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
xmfdud030       timestamp(0)      ,/* 自定义字段(日期时间)030 */
xmfd030       varchar2(10)      ,/* 回复状态 */
xmfd031       date      ,/* 回复客户日期 */
xmfd032       varchar2(10)      ,/* 未转单原因码 */
xmfd033       varchar2(255)      ,/* 未转单原因说明 */
xmfd034       varchar2(20)      /* 一次性交易对象识别码 */
);
alter table xmfd_t add constraint xmfd_pk primary key (xmfdent,xmfddocno) enable validate;

create unique index xmfd_pk on xmfd_t (xmfdent,xmfddocno);

grant select on xmfd_t to tiptop;
grant update on xmfd_t to tiptop;
grant delete on xmfd_t to tiptop;
grant insert on xmfd_t to tiptop;

exit;
