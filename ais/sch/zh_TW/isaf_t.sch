/* 
================================================================================
檔案代號:isaf_t
檔案名稱:销项发票主档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table isaf_t
(
isafent       number(5)      ,/* 企业编码 */
isafsite       varchar2(10)      ,/* 账务组织 */
isafcomp       varchar2(10)      ,/* 法人 */
isafdocno       varchar2(20)      ,/* 开票单号 */
isafdocdt       date      ,/* 录入日期 */
isaf001       varchar2(1)      ,/* 发票来源 */
isaf002       varchar2(10)      ,/* 发票客户 */
isaf003       varchar2(10)      ,/* 账款客户 */
isaf004       varchar2(10)      ,/* 业务组织 */
isaf005       varchar2(20)      ,/* 开票人员 */
isaf006       varchar2(10)      ,/* 开票部门 */
isaf007       date      ,/* 扣账日期 */
isaf008       varchar2(2)      ,/* 发票类型 */
isaf009       varchar2(1)      ,/* 电子发票否 */
isaf010       varchar2(20)      ,/* 发票代码 */
isaf011       varchar2(20)      ,/* 发票号码 */
isaf012       varchar2(10)      ,/* 发票检查码 */
isaf013       varchar2(10)      ,/* 发票防伪随机码 */
isaf014       date      ,/* 发票日期 */
isaf015       varchar2(8)      ,/* 发票时间 */
isaf016       varchar2(10)      ,/* 税种 */
isaf017       varchar2(1)      ,/* 含税否 */
isaf018       number(5,2)      ,/* 税率 */
isaf019       varchar2(10)      ,/* 申报格式 */
isaf020       varchar2(20)      ,/* 发票号码迄号 */
isaf021       varchar2(255)      ,/* 购货方名称 */
isaf022       varchar2(20)      ,/* 购货方税务编号 */
isaf023       varchar2(4000)      ,/* 购货方地址 */
isaf024       varchar2(20)      ,/* 购货方电话 */
isaf025       varchar2(255)      ,/* 购货方开户银行 */
isaf026       varchar2(30)      ,/* 购货方账户编码 */
isaf027       varchar2(255)      ,/* 销货方名称 */
isaf028       varchar2(20)      ,/* 销方税务编号 */
isaf029       varchar2(4000)      ,/* 销货方地址 */
isaf030       varchar2(20)      ,/* 销货方电话 */
isaf031       varchar2(255)      ,/* 销货方开户银行 */
isaf032       varchar2(30)      ,/* 销货方帐号 */
isaf033       varchar2(10)      ,/* POS机号 */
isaf034       varchar2(20)      ,/* POS单号 */
isaf035       varchar2(20)      ,/* 应收单号 */
isaf036       varchar2(10)      ,/* 发票异动状态 */
isaf037       varchar2(10)      ,/* 异动理由码 */
isaf038       varchar2(255)      ,/* 异动备注 */
isaf039       date      ,/* 异动日期 */
isaf040       varchar2(8)      ,/* 异动时间 */
isaf041       varchar2(20)      ,/* 异动人员 */
isaf042       varchar2(80)      ,/* 项目作废核准文号 */
isaf043       varchar2(1)      ,/* 通关方式注记 */
isaf044       number(5,0)      ,/* 打印次数 */
isaf045       varchar2(20)      ,/* 支付工具卡号1 */
isaf046       varchar2(20)      ,/* 支付工具卡号2 */
isaf047       varchar2(20)      ,/* 支付工具卡号3 */
isaf048       varchar2(20)      ,/* 辅助账二应收单号 */
isaf049       varchar2(20)      ,/* 辅助账三应收单号 */
isaf050       varchar2(1)      ,/* 生成方式 */
isaf051       varchar2(10)      ,/* 发票簿号 */
isaf052       varchar2(10)      ,/* 发票簿号对应的营运据点 */
isaf053       varchar2(10)      ,/* 发票联数 */
isaf054       varchar2(1)      ,/* 课税种 */
isaf055       varchar2(10)      ,/* 收款客户 */
isaf056       number(5,0)      ,/* 发票性质 */
isaf057       varchar2(20)      ,/* 业务人员 */
isaf058       varchar2(10)      ,/* 收款条件 */
isaf100       varchar2(10)      ,/* 币种 */
isaf101       number(20,10)      ,/* 汇率 */
isaf103       number(20,6)      ,/* 发票原币税前金额 */
isaf104       number(20,6)      ,/* 发票原币税额 */
isaf105       number(20,6)      ,/* 发票原币含税金额 */
isaf106       number(20,6)      ,/* 发票原币留抵税额 */
isaf107       number(20,6)      ,/* 发票原币已折金额 */
isaf108       number(20,6)      ,/* 发票原币已折税额 */
isaf113       number(20,6)      ,/* 发票本币税前金额 */
isaf114       number(20,6)      ,/* 发票本币税额 */
isaf115       number(20,6)      ,/* 发票本币含税金额 */
isaf116       number(20,6)      ,/* 发票本币留抵税额 */
isaf117       number(20,6)      ,/* 发票本币已折金额 */
isaf118       number(20,6)      ,/* 发票本币已折税额 */
isaf119       number(20,6)      ,/* 账款应税金额 */
isaf120       number(20,6)      ,/* 账款零税金额 */
isaf121       number(20,6)      ,/* 账款免税金额 */
isaf122       number(20,6)      ,/* 礼券已开发票金额 */
isaf123       number(20,6)      ,/* 礼券已开发票税额 */
isaf124       number(20,6)      ,/* 已开发票留抵税额 */
isaf201       varchar2(10)      ,/* 爱心码 */
isaf202       varchar2(10)      ,/* 载具类别号码 */
isaf203       varchar2(80)      ,/* 载具显码 ID */
isaf204       varchar2(80)      ,/* 载具隐码 ID */
isaf205       varchar2(1)      ,/* 电子发票导出状态 */
isaf206       varchar2(20)      ,/* 电子发票导出序号 */
isaf207       varchar2(10)      ,/* 电子发票领取方式 */
isaf208       number(5,0)      ,/* 申报年度 */
isaf209       number(5,0)      ,/* 申报月份 */
isaf210       varchar2(10)      ,/* 申报据点 */
isafstus       varchar2(1)      ,/* 状态码 */
isafownid       varchar2(20)      ,/* 资料所有者 */
isafowndp       varchar2(10)      ,/* 资料所有部门 */
isafcrtid       varchar2(20)      ,/* 资料录入者 */
isafcrtdp       varchar2(10)      ,/* 资料录入部门 */
isafcrtdt       timestamp(0)      ,/* 资料创建日 */
isafmodid       varchar2(20)      ,/* 资料更改者 */
isafmoddt       timestamp(0)      ,/* 最近更改日 */
isafcnfid       varchar2(20)      ,/* 资料审核者 */
isafcnfdt       timestamp(0)      ,/* 数据审核日 */
isafud001       varchar2(40)      ,/* 自定义字段(文本)001 */
isafud002       varchar2(40)      ,/* 自定义字段(文本)002 */
isafud003       varchar2(40)      ,/* 自定义字段(文本)003 */
isafud004       varchar2(40)      ,/* 自定义字段(文本)004 */
isafud005       varchar2(40)      ,/* 自定义字段(文本)005 */
isafud006       varchar2(40)      ,/* 自定义字段(文本)006 */
isafud007       varchar2(40)      ,/* 自定义字段(文本)007 */
isafud008       varchar2(40)      ,/* 自定义字段(文本)008 */
isafud009       varchar2(40)      ,/* 自定义字段(文本)009 */
isafud010       varchar2(40)      ,/* 自定义字段(文本)010 */
isafud011       number(20,6)      ,/* 自定义字段(数字)011 */
isafud012       number(20,6)      ,/* 自定义字段(数字)012 */
isafud013       number(20,6)      ,/* 自定义字段(数字)013 */
isafud014       number(20,6)      ,/* 自定义字段(数字)014 */
isafud015       number(20,6)      ,/* 自定义字段(数字)015 */
isafud016       number(20,6)      ,/* 自定义字段(数字)016 */
isafud017       number(20,6)      ,/* 自定义字段(数字)017 */
isafud018       number(20,6)      ,/* 自定义字段(数字)018 */
isafud019       number(20,6)      ,/* 自定义字段(数字)019 */
isafud020       number(20,6)      ,/* 自定义字段(数字)020 */
isafud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
isafud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
isafud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
isafud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
isafud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
isafud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
isafud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
isafud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
isafud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
isafud030       timestamp(0)      ,/* 自定义字段(日期时间)030 */
isaf059       varchar2(10)      ,/* 适用零税率规定 */
isaf060       varchar2(10)      ,/* 通关方式 */
isaf061       varchar2(40)      ,/* 非经海关证明文档名称 */
isaf062       varchar2(20)      ,/* 非经海关证明文档号码 */
isaf063       varchar2(10)      ,/* 经由海关出口报单类别 */
isaf064       varchar2(40)      ,/* 出口报单号码 */
isaf065       date      ,/* 输出或结汇日期 */
isaf066       varchar2(20)      ,/* 商业发票号码(IV no.) */
isaf067       varchar2(20)      /* 一次性交易对象 */
);
alter table isaf_t add constraint isaf_pk primary key (isafent,isafcomp,isafdocno) enable validate;

create  index ifaf_03 on isaf_t (isaf035,isaf002);
create  index isaf_01 on isaf_t (isafent,isaf011,isaf010,isaf008,isaf002);
create  index isaf_02 on isaf_t (isaf205,isaf009);
create  index isaf_04 on isaf_t (isafent,isaf210,isaf209,isaf208);
create unique index isaf_pk on isaf_t (isafent,isafcomp,isafdocno);

grant select on isaf_t to tiptop;
grant update on isaf_t to tiptop;
grant delete on isaf_t to tiptop;
grant insert on isaf_t to tiptop;

exit;
