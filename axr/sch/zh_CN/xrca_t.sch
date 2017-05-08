/* 
================================================================================
檔案代號:xrca_t
檔案名稱:应收凭单单头
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table xrca_t
(
xrcaent       number(5)      ,/* 企业编号 */
xrcaownid       varchar2(20)      ,/* 资料所有者 */
xrcaowndp       varchar2(10)      ,/* 资料所有部门 */
xrcacrtid       varchar2(20)      ,/* 资料录入者 */
xrcacrtdp       varchar2(10)      ,/* 资料录入部门 */
xrcacrtdt       timestamp(0)      ,/* 资料创建日 */
xrcamodid       varchar2(20)      ,/* 资料更改者 */
xrcamoddt       timestamp(0)      ,/* 最近更改日 */
xrcacnfid       varchar2(20)      ,/* 资料审核者 */
xrcacnfdt       timestamp(0)      ,/* 数据审核日 */
xrcapstid       varchar2(20)      ,/* 资料过账者 */
xrcapstdt       timestamp(0)      ,/* 资料过账日 */
xrcastus       varchar2(10)      ,/* 状态码 */
xrcacomp       varchar2(10)      ,/* 法人 */
xrcald       varchar2(5)      ,/* 账套 */
xrcadocno       varchar2(20)      ,/* 应收账款单号码 */
xrcadocdt       date      ,/* 账款日期 */
xrca001       varchar2(10)      ,/* 账款单性质 */
xrcasite       varchar2(10)      ,/* 账务中心 */
xrca003       varchar2(20)      ,/* 账务人员 */
xrca004       varchar2(10)      ,/* 账款客户编号 */
xrca005       varchar2(10)      ,/* 收款客户 */
xrca006       varchar2(10)      ,/* 客户分类 */
xrca007       varchar2(10)      ,/* 账款类别 */
xrca008       varchar2(10)      ,/* 收款条件编号 */
xrca009       date      ,/* 应收款日/应扣抵日 */
xrca010       date      ,/* 容许票据到期日 */
xrca011       varchar2(10)      ,/* 税种 */
xrca012       number(5,2)      ,/* 税率 */
xrca013       varchar2(1)      ,/* 含税否 */
xrca014       varchar2(20)      ,/* 人员编号 */
xrca015       varchar2(10)      ,/* 部门编号 */
xrca016       varchar2(20)      ,/* 来源作业类型 */
xrca017       varchar2(1)      ,/* 生成方式 */
xrca018       varchar2(20)      ,/* 来源参考单号 */
xrca019       varchar2(20)      ,/* 系统生成对应单号(待抵账款-预收) */
xrca020       varchar2(1)      ,/* 信用状申请流程否 */
xrca021       varchar2(20)      ,/* 商业发票号码(IV no.) */
xrca022       varchar2(20)      ,/* 出口报单号码 */
xrca023       varchar2(10)      ,/* 发票客户编号 */
xrca024       varchar2(20)      ,/* 发票客户税号 */
xrca025       varchar2(255)      ,/* 发票客户全名 */
xrca026       varchar2(4000)      ,/* 发票客户地址 */
xrca028       varchar2(10)      ,/* 发票类型 */
xrca029       number(20,10)      ,/* 发票汇率 */
xrca030       number(20,6)      ,/* 发票应开税前金额 */
xrca031       number(20,6)      ,/* 发票应开税额 */
xrca032       number(20,6)      ,/* 发票应开含税金额 */
xrca033       varchar2(20)      ,/* 项目编号 */
xrca034       varchar2(10)      ,/* 责任中心 */
xrca035       varchar2(24)      ,/* 应收(借方)科目编号 */
xrca036       varchar2(24)      ,/* 收入(贷方)科目编号 */
xrca037       varchar2(1)      ,/* 分录凭证生成否 */
xrca038       varchar2(20)      ,/* 抛转凭证号码 */
xrca039       number(10,0)      ,/* 会计检核附件份数 */
xrca040       varchar2(1)      ,/* 留置否 */
xrca041       varchar2(10)      ,/* 留置理由码 */
xrca042       date      ,/* 留置设置日期 */
xrca043       date      ,/* 留置解除日期 */
xrca044       number(20,6)      ,/* 留置原币金额 */
xrca045       varchar2(255)      ,/* 留置说明 */
xrca046       varchar2(1)      ,/* 关系人否 */
xrca047       varchar2(20)      ,/* 多角序号 */
xrca048       varchar2(20)      ,/* 集团代收/代付单号 */
xrca049       varchar2(10)      ,/* 来源营运中心编号 */
xrca050       number(10,0)      ,/* 交易原始单据份数 */
xrca051       varchar2(10)      ,/* 作废理由码 */
xrca052       number(10,0)      ,/* 打印次数 */
xrca053       varchar2(255)      ,/* 备注 */
xrca054       varchar2(10)      ,/* 多账期设置 */
xrca055       varchar2(10)      ,/* 缴款优惠条件 */
xrca056       varchar2(10)      ,/* 会计检核附件状态 */
xrca057       varchar2(20)      ,/* 交易对象识别码 */
xrca058       varchar2(10)      ,/* 销售分类 */
xrca059       varchar2(10)      ,/* 预算编号 */
xrca060       varchar2(1)      ,/* 发票开立原则 */
xrca061       date      ,/* 预计开立发票日期 */
xrca062       varchar2(1)      ,/* 多角性质 */
xrca063       varchar2(20)      ,/* 整账批序号 */
xrca064       number(10,0)      ,/* 订金序次 */
xrca065       varchar2(20)      ,/* 发票编号 */
xrca066       varchar2(20)      ,/* 发票号码 */
xrca100       varchar2(10)      ,/* 交易原币种 */
xrca101       number(20,10)      ,/* 原币汇率 */
xrca103       number(20,6)      ,/* 原币税前金额 */
xrca104       number(20,6)      ,/* 原币税额 */
xrca106       number(20,6)      ,/* 原币直接折抵合计金额 */
xrca107       number(20,6)      ,/* 原币直接冲账(调整)合计金额 */
xrca108       number(20,6)      ,/* 原币应收金额 */
xrca113       number(20,6)      ,/* 本币税前金额 */
xrca114       number(20,6)      ,/* 本币税额 */
xrca116       number(20,6)      ,/* 本币直接冲账(调整)合计金额 */
xrca117       number(20,6)      ,/* 本币直接冲账(调整)合计金额 */
xrca118       number(20,6)      ,/* 本币应收金额 */
xrca120       varchar2(10)      ,/* 本位币二币种 */
xrca121       number(20,10)      ,/* 本位币二汇率 */
xrca123       number(20,6)      ,/* 本位币二税前金额 */
xrca124       number(20,6)      ,/* 本位币二税额 */
xrca126       number(20,6)      ,/* 本位币二直接折抵合计金额 */
xrca127       number(20,6)      ,/* 本位币二直接冲账(调整)合计金额 */
xrca128       number(20,6)      ,/* 本位币二应收金额 */
xrca130       varchar2(10)      ,/* 本位币三币种 */
xrca131       number(20,10)      ,/* 本位币三汇率 */
xrca133       number(20,6)      ,/* 本位币三税前金额 */
xrca134       number(20,6)      ,/* 本位币三税额 */
xrca136       number(20,6)      ,/* 本位币三直接折抵合计金额 */
xrca137       number(20,6)      ,/* 本位币三直接冲账(调整)合计金额 */
xrca138       number(20,6)      ,/* 本位币三应收金额 */
xrcaud001       varchar2(40)      ,/* 自定义字段(文本)001 */
xrcaud002       varchar2(40)      ,/* 自定义字段(文本)002 */
xrcaud003       varchar2(40)      ,/* 自定义字段(文本)003 */
xrcaud004       varchar2(40)      ,/* 自定义字段(文本)004 */
xrcaud005       varchar2(40)      ,/* 自定义字段(文本)005 */
xrcaud006       varchar2(40)      ,/* 自定义字段(文本)006 */
xrcaud007       varchar2(40)      ,/* 自定义字段(文本)007 */
xrcaud008       varchar2(40)      ,/* 自定义字段(文本)008 */
xrcaud009       varchar2(40)      ,/* 自定义字段(文本)009 */
xrcaud010       varchar2(40)      ,/* 自定义字段(文本)010 */
xrcaud011       number(20,6)      ,/* 自定义字段(数字)011 */
xrcaud012       number(20,6)      ,/* 自定义字段(数字)012 */
xrcaud013       number(20,6)      ,/* 自定义字段(数字)013 */
xrcaud014       number(20,6)      ,/* 自定义字段(数字)014 */
xrcaud015       number(20,6)      ,/* 自定义字段(数字)015 */
xrcaud016       number(20,6)      ,/* 自定义字段(数字)016 */
xrcaud017       number(20,6)      ,/* 自定义字段(数字)017 */
xrcaud018       number(20,6)      ,/* 自定义字段(数字)018 */
xrcaud019       number(20,6)      ,/* 自定义字段(数字)019 */
xrcaud020       number(20,6)      ,/* 自定义字段(数字)020 */
xrcaud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
xrcaud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
xrcaud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
xrcaud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
xrcaud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
xrcaud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
xrcaud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
xrcaud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
xrcaud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
xrcaud030       timestamp(0)      /* 自定义字段(日期时间)030 */
);
alter table xrca_t add constraint xrca_pk primary key (xrcaent,xrcald,xrcadocno) enable validate;

create  index xrca_01 on xrca_t (xrcacomp,xrcasite,xrca004,xrca007,xrca015,xrca016,xrca019,xrca023,xrca033,xrca034);
create  index xrca_n1 on xrca_t (xrcaent,xrcasite,xrcald,xrca009,xrca010);
create  index xrca_n2 on xrca_t (xrcaent,xrcald,xrca007,xrca035,xrca036,xrca038);
create  index xrca_n3 on xrca_t (xrcacomp,xrcasite,xrca004,xrca018,xrca019);
create unique index xrca_pk on xrca_t (xrcaent,xrcald,xrcadocno);

grant select on xrca_t to tiptop;
grant update on xrca_t to tiptop;
grant delete on xrca_t to tiptop;
grant insert on xrca_t to tiptop;

exit;
