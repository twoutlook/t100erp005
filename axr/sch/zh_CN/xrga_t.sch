/* 
================================================================================
檔案代號:xrga_t
檔案名稱:销售信用状主档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table xrga_t
(
xrgaent       number(5)      ,/* 企业编号 */
xrgaownid       varchar2(20)      ,/* 资料所有者 */
xrgaowndp       varchar2(10)      ,/* 资料所有部门 */
xrgacrtid       varchar2(20)      ,/* 资料录入者 */
xrgacrtdp       varchar2(10)      ,/* 资料录入部门 */
xrgacrtdt       timestamp(0)      ,/* 资料创建日 */
xrgamodid       varchar2(20)      ,/* 资料更改者 */
xrgamoddt       timestamp(0)      ,/* 最近更改日 */
xrgacnfid       varchar2(20)      ,/* 资料审核者 */
xrgacnfdt       timestamp(0)      ,/* 数据审核日 */
xrgastus       varchar2(10)      ,/* 状态码 */
xrgacomp       varchar2(10)      ,/* 法人 */
xrgadocno       varchar2(20)      ,/* 收状单号 */
xrgadocdt       date      ,/* 收状日期 */
xrga001       varchar2(20)      ,/* L/C No. */
xrga002       number(10,0)      ,/* 版次 */
xrga003       date      ,/* 开状日期 */
xrga004       varchar2(10)      ,/* 客户编号 */
xrga005       varchar2(20)      ,/* 业务人员 */
xrga006       varchar2(10)      ,/* 收款类型 */
xrga007       varchar2(10)      ,/* 信用状类别 */
xrga008       varchar2(15)      ,/* 开状银行 */
xrga009       varchar2(15)      ,/* 通知银行 */
xrga010       varchar2(1)      ,/* 保兑信用状否 */
xrga011       date      ,/* 信用状有效日期 */
xrga012       date      ,/* 承兑日期 */
xrga013       varchar2(10)      ,/* 保兑费用支付方 */
xrga014       varchar2(1)      ,/* 可否分批交运 */
xrga015       date      ,/* 最后装运日 */
xrga016       varchar2(10)      ,/* 运送方式 */
xrga017       varchar2(255)      ,/* 装载港/机场 */
xrga018       varchar2(255)      ,/* 卸载港/机场 */
xrga019       date      ,/* E.T.D */
xrga020       date      ,/* E.T.A */
xrga021       varchar2(255)      ,/* 备注 */
xrga022       varchar2(15)      ,/* 押汇银行 */
xrga023       varchar2(20)      ,/* 许可证号 */
xrga024       varchar2(20)      ,/* 费用应付凭单 */
xrga025       varchar2(1)      ,/* 结案否 */
xrga100       varchar2(10)      ,/* 币种 */
xrga101       number(20,10)      ,/* 收状汇率 */
xrga103       number(20,6)      ,/* 收状原币金额 */
xrga104       number(20,6)      ,/* 押汇原币金额 */
xrga113       number(20,6)      ,/* 收状本币金额 */
xrgaud001       varchar2(40)      ,/* 自定义字段(文本)001 */
xrgaud002       varchar2(40)      ,/* 自定义字段(文本)002 */
xrgaud003       varchar2(40)      ,/* 自定义字段(文本)003 */
xrgaud004       varchar2(40)      ,/* 自定义字段(文本)004 */
xrgaud005       varchar2(40)      ,/* 自定义字段(文本)005 */
xrgaud006       varchar2(40)      ,/* 自定义字段(文本)006 */
xrgaud007       varchar2(40)      ,/* 自定义字段(文本)007 */
xrgaud008       varchar2(40)      ,/* 自定义字段(文本)008 */
xrgaud009       varchar2(40)      ,/* 自定义字段(文本)009 */
xrgaud010       varchar2(40)      ,/* 自定义字段(文本)010 */
xrgaud011       number(20,6)      ,/* 自定义字段(数字)011 */
xrgaud012       number(20,6)      ,/* 自定义字段(数字)012 */
xrgaud013       number(20,6)      ,/* 自定义字段(数字)013 */
xrgaud014       number(20,6)      ,/* 自定义字段(数字)014 */
xrgaud015       number(20,6)      ,/* 自定义字段(数字)015 */
xrgaud016       number(20,6)      ,/* 自定义字段(数字)016 */
xrgaud017       number(20,6)      ,/* 自定义字段(数字)017 */
xrgaud018       number(20,6)      ,/* 自定义字段(数字)018 */
xrgaud019       number(20,6)      ,/* 自定义字段(数字)019 */
xrgaud020       number(20,6)      ,/* 自定义字段(数字)020 */
xrgaud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
xrgaud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
xrgaud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
xrgaud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
xrgaud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
xrgaud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
xrgaud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
xrgaud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
xrgaud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
xrgaud030       timestamp(0)      ,/* 自定义字段(日期时间)030 */
xrga109       number(20,6)      /* 初开状金额 */
);
alter table xrga_t add constraint xrga_pk primary key (xrgaent,xrgacomp,xrgadocno) enable validate;

create unique index xrga_pk on xrga_t (xrgaent,xrgacomp,xrgadocno);

grant select on xrga_t to tiptop;
grant update on xrga_t to tiptop;
grant delete on xrga_t to tiptop;
grant insert on xrga_t to tiptop;

exit;
