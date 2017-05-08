/* 
================================================================================
檔案代號:apbb_t
檔案名稱:进项发票对账主档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:Y
============.========================.==========================================
 */
create table apbb_t
(
apbbent       number(5)      ,/* 企业编号 */
apbbownid       varchar2(20)      ,/* 资料所有者 */
apbbowndp       varchar2(10)      ,/* 资料所有部门 */
apbbcrtid       varchar2(20)      ,/* 资料录入者 */
apbbcrtdp       varchar2(10)      ,/* 资料录入部门 */
apbbcrtdt       timestamp(0)      ,/* 资料创建日 */
apbbmodid       varchar2(20)      ,/* 资料更改者 */
apbbmoddt       timestamp(0)      ,/* 最近更改日 */
apbbcnfid       varchar2(20)      ,/* 资料审核者 */
apbbcnfdt       timestamp(0)      ,/* 数据审核日 */
apbbstus       varchar2(10)      ,/* 状态码 */
apbbcomp       varchar2(10)      ,/* 法人 */
apbbdocno       varchar2(20)      ,/* 对账单号码 */
apbbseq       number(10,0)      ,/* 项次 */
apbbdocdt       date      ,/* 单据日期 */
apbb001       varchar2(10)      ,/* 发票来源 */
apbb002       varchar2(10)      ,/* 开发票人 */
apbb004       varchar2(10)      ,/* 账务中心(业务组织) */
apbb006       varchar2(10)      ,/* 业务部门(登录部门) */
apbb008       varchar2(2)      ,/* 发票类型 */
apbb009       varchar2(20)      ,/* 销方发票编号 */
apbb010       varchar2(20)      ,/* 发票号码 */
apbb011       date      ,/* 发票日期 */
apbb012       varchar2(10)      ,/* 税种 */
apbb0121       varchar2(1)      ,/* 含税否 */
apbb013       number(5,2)      ,/* 税率 */
apbb014       varchar2(10)      ,/* 币种 */
apbb015       number(20,10)      ,/* 汇率 */
apbb016       varchar2(255)      ,/* 购货方名称 */
apbb017       varchar2(20)      ,/* 购货方税务编号 */
apbb018       varchar2(4000)      ,/* 购货方地址 */
apbb019       varchar2(20)      ,/* 购货方电话 */
apbb020       varchar2(255)      ,/* 购货方开户银行 */
apbb021       varchar2(30)      ,/* 购货方账户编码 */
apbb022       varchar2(10)      ,/* 销方银行账户编码 */
apbb023       number(20,6)      ,/* 发票原币税前金额 */
apbb024       number(20,6)      ,/* 发票原币税额 */
apbb025       number(20,6)      ,/* 发票原币含税金额 */
apbb026       number(20,6)      ,/* 发票本币税前金额 */
apbb027       number(20,6)      ,/* 发票本币税额 */
apbb028       number(20,6)      ,/* 发票本币含税金额 */
apbb029       varchar2(255)      ,/* 销货方名称 */
apbb030       varchar2(20)      ,/* 税务编号 */
apbb031       varchar2(4000)      ,/* 销货方地址 */
apbb032       varchar2(20)      ,/* 销货方电话 */
apbb033       varchar2(80)      ,/* 销货方开户银行 */
apbb034       varchar2(30)      ,/* 销货方帐号 */
apbb035       number(20,6)      ,/* 申报数量 */
apbb036       varchar2(10)      ,/* 异动状态 */
apbb037       varchar2(1)      ,/* 可扣抵编号 */
apbb038       varchar2(10)      ,/* 作废(注销)理由码 */
apbb039       date      ,/* 作废日期 */
apbb040       varchar2(8)      ,/* 作废时间 */
apbb041       varchar2(20)      ,/* 作废人员 */
apbb042       varchar2(80)      ,/* 项目作废核准文号 */
apbb043       varchar2(1)      ,/* 通关方式注记 */
apbb044       number(5,0)      ,/* 打印次数 */
apbb045       varchar2(20)      ,/* 支付工具卡号1 */
apbb046       varchar2(20)      ,/* 支付工具卡号2 */
apbb047       varchar2(20)      ,/* 支付工具卡号3 */
apbb048       varchar2(10)      ,/* 通关注记 */
apbb049       varchar2(255)      ,/* 备注说明 */
apbb050       varchar2(1)      ,/* 发票性质 */
apbb051       varchar2(20)      ,/* 采购人员 */
apbb052       varchar2(10)      ,/* 采购部门 */
apbb053       varchar2(20)      ,/* 登录日期 */
apbb054       varchar2(10)      ,/* 付款条件 */
apbb107       number(20,6)      ,/* 发票原币已折金额 */
apbb108       number(20,6)      ,/* 发票原币已折税额 */
apbb117       number(20,6)      ,/* 发票本币已折金额 */
apbb118       number(20,6)      ,/* 发票本币已折税额 */
apbb200       varchar2(1)      ,/* 电子发票否 */
apbb201       varchar2(10)      ,/* 爱心码 */
apbb202       varchar2(10)      ,/* 载具类别号码 */
apbb203       varchar2(80)      ,/* 载具显码 ID */
apbb204       varchar2(80)      ,/* 载具隐码 ID */
apbb205       varchar2(1)      ,/* 电子发票导出状态 */
apbb206       varchar2(20)      ,/* 电子发票导出序号 */
apbb207       varchar2(10)      ,/* 电子发票领取方式 */
apbb208       number(5,0)      ,/* 申报年度 */
apbb209       number(5,0)      ,/* 申报月份 */
apbb210       varchar2(10)      ,/* 申报据点 */
apbbud001       varchar2(40)      ,/* 自定义字段(文本)001 */
apbbud002       varchar2(40)      ,/* 自定义字段(文本)002 */
apbbud003       varchar2(40)      ,/* 自定义字段(文本)003 */
apbbud004       varchar2(40)      ,/* 自定义字段(文本)004 */
apbbud005       varchar2(40)      ,/* 自定义字段(文本)005 */
apbbud006       varchar2(40)      ,/* 自定义字段(文本)006 */
apbbud007       varchar2(40)      ,/* 自定义字段(文本)007 */
apbbud008       varchar2(40)      ,/* 自定义字段(文本)008 */
apbbud009       varchar2(40)      ,/* 自定义字段(文本)009 */
apbbud010       varchar2(40)      ,/* 自定义字段(文本)010 */
apbbud011       number(20,6)      ,/* 自定义字段(数字)011 */
apbbud012       number(20,6)      ,/* 自定义字段(数字)012 */
apbbud013       number(20,6)      ,/* 自定义字段(数字)013 */
apbbud014       number(20,6)      ,/* 自定义字段(数字)014 */
apbbud015       number(20,6)      ,/* 自定义字段(数字)015 */
apbbud016       number(20,6)      ,/* 自定义字段(数字)016 */
apbbud017       number(20,6)      ,/* 自定义字段(数字)017 */
apbbud018       number(20,6)      ,/* 自定义字段(数字)018 */
apbbud019       number(20,6)      ,/* 自定义字段(数字)019 */
apbbud020       number(20,6)      ,/* 自定义字段(数字)020 */
apbbud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
apbbud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
apbbud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
apbbud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
apbbud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
apbbud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
apbbud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
apbbud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
apbbud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
apbbud030       timestamp(0)      ,/* 自定义字段(日期时间)030 */
apbb055       date      ,/* 付款到期日 */
apbb056       varchar2(1)      ,/* for流通 */
apbb057       varchar2(20)      ,/* 应付单号 */
apbb058       varchar2(10)      ,/* 经营方式 */
apbb003       varchar2(1)      ,/* 对账来源 */
apbb059       varchar2(20)      /* 一次性对象识别码 */
);
alter table apbb_t add constraint apbb_pk primary key (apbbent,apbbdocno) enable validate;

create  index apbb_01 on apbb_t (apbb008,apbb009,apbb010);
create  index apbb_02 on apbb_t (apbbdocno,apbbseq);
create  index apbb_03 on apbb_t (apbb008,apbb010,apbb009,apbb002);
create unique index apbb_pk on apbb_t (apbbent,apbbdocno);

grant select on apbb_t to tiptop;
grant update on apbb_t to tiptop;
grant delete on apbb_t to tiptop;
grant insert on apbb_t to tiptop;

exit;
