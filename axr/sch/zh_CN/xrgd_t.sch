/* 
================================================================================
檔案代號:xrgd_t
檔案名稱:销售信用状变更单主档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table xrgd_t
(
xrgdent       number(5)      ,/* 企业编号 */
xrgdownid       varchar2(20)      ,/* 资料所有者 */
xrgdowndp       varchar2(10)      ,/* 资料所有部门 */
xrgdcrtid       varchar2(20)      ,/* 资料录入者 */
xrgdcrtdp       varchar2(10)      ,/* 资料录入部门 */
xrgdcrtdt       timestamp(0)      ,/* 资料创建日 */
xrgdmodid       varchar2(20)      ,/* 资料更改者 */
xrgdmoddt       timestamp(0)      ,/* 最近更改日 */
xrgdcnfid       varchar2(20)      ,/* 资料审核者 */
xrgdcnfdt       timestamp(0)      ,/* 数据审核日 */
xrgdpstid       varchar2(20)      ,/* 资料过账者 */
xrgdpstdt       timestamp(0)      ,/* 资料过账日 */
xrgdstus       varchar2(10)      ,/* 状态码 */
xrgdcomp       varchar2(10)      ,/* 法人 */
xrgddocno       varchar2(20)      ,/* 收状单号 */
xrgddocdt       date      ,/* 收状日期 */
xrgd001       varchar2(20)      ,/* L/C No. */
xrgd002       number(10,0)      ,/* 版次 */
xrgd003       date      ,/* 开状日期 */
xrgd004       varchar2(10)      ,/* 客户编号 */
xrgd005       varchar2(20)      ,/* 业务人员 */
xrgd006       varchar2(10)      ,/* 收款类型 */
xrgd007       varchar2(10)      ,/* 信用状类别 */
xrgd008       varchar2(15)      ,/* 开状银行 */
xrgd009       varchar2(15)      ,/* 通知银行 */
xrgd010       varchar2(1)      ,/* 保兑信用状否 */
xrgd011       date      ,/* 信用状有效日期 */
xrgd012       date      ,/* 呈兑日期 */
xrgd013       varchar2(10)      ,/* 保兑费用支付方 */
xrgd014       varchar2(1)      ,/* 可否分批交运 */
xrgd015       date      ,/* 最后装运日 */
xrgd016       varchar2(10)      ,/* 运送方式 */
xrgd017       varchar2(255)      ,/* 装载港/机场 */
xrgd018       varchar2(255)      ,/* 卸载港/机场 */
xrgd019       date      ,/* E.T.D */
xrgd020       date      ,/* E.T.A */
xrgd021       varchar2(255)      ,/* 备注 */
xrgd022       varchar2(15)      ,/* 押汇银行 */
xrgd023       varchar2(20)      ,/* 许可证号 */
xrgd024       varchar2(20)      ,/* 费用应付凭单 */
xrgd025       varchar2(1)      ,/* 结案否 */
xrgd100       varchar2(10)      ,/* 币种 */
xrgd101       number(20,10)      ,/* 收状汇率 */
xrgd103       number(20,6)      ,/* 收状原币金额 */
xrgd104       number(20,6)      ,/* 押汇原币金额 */
xrgd113       number(20,6)      ,/* 收状本币金额 */
xrgd900       number(10,0)      ,/* 变更序 */
xrgdud001       varchar2(40)      ,/* 自定义字段(文本)001 */
xrgdud002       varchar2(40)      ,/* 自定义字段(文本)002 */
xrgdud003       varchar2(40)      ,/* 自定义字段(文本)003 */
xrgdud004       varchar2(40)      ,/* 自定义字段(文本)004 */
xrgdud005       varchar2(40)      ,/* 自定义字段(文本)005 */
xrgdud006       varchar2(40)      ,/* 自定义字段(文本)006 */
xrgdud007       varchar2(40)      ,/* 自定义字段(文本)007 */
xrgdud008       varchar2(40)      ,/* 自定义字段(文本)008 */
xrgdud009       varchar2(40)      ,/* 自定义字段(文本)009 */
xrgdud010       varchar2(40)      ,/* 自定义字段(文本)010 */
xrgdud011       number(20,6)      ,/* 自定义字段(数字)011 */
xrgdud012       number(20,6)      ,/* 自定义字段(数字)012 */
xrgdud013       number(20,6)      ,/* 自定义字段(数字)013 */
xrgdud014       number(20,6)      ,/* 自定义字段(数字)014 */
xrgdud015       number(20,6)      ,/* 自定义字段(数字)015 */
xrgdud016       number(20,6)      ,/* 自定义字段(数字)016 */
xrgdud017       number(20,6)      ,/* 自定义字段(数字)017 */
xrgdud018       number(20,6)      ,/* 自定义字段(数字)018 */
xrgdud019       number(20,6)      ,/* 自定义字段(数字)019 */
xrgdud020       number(20,6)      ,/* 自定义字段(数字)020 */
xrgdud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
xrgdud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
xrgdud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
xrgdud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
xrgdud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
xrgdud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
xrgdud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
xrgdud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
xrgdud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
xrgdud030       timestamp(0)      /* 自定义字段(日期时间)030 */
);
alter table xrgd_t add constraint xrgd_pk primary key (xrgdent,xrgdcomp,xrgddocno,xrgd900) enable validate;

create unique index xrgd_pk on xrgd_t (xrgdent,xrgdcomp,xrgddocno,xrgd900);

grant select on xrgd_t to tiptop;
grant update on xrgd_t to tiptop;
grant delete on xrgd_t to tiptop;
grant insert on xrgd_t to tiptop;

exit;
