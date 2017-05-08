/* 
================================================================================
檔案代號:nmck_t
檔案名稱:应付汇款主档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table nmck_t
(
nmckent       number(5)      ,/* 企业编号 */
nmckcomp       varchar2(10)      ,/* 法人 */
nmckdocno       varchar2(20)      ,/* 单据号码 */
nmckdocdt       date      ,/* 单据日期 */
nmcksite       varchar2(10)      ,/* 资金中心 */
nmck001       varchar2(10)      ,/* 来源类型 */
nmck002       varchar2(10)      ,/* 款别编号 */
nmck003       varchar2(20)      ,/* 账务人员 */
nmck004       varchar2(10)      ,/* 交易账户编码 */
nmck005       varchar2(10)      ,/* 付款对象 */
nmck006       varchar2(20)      ,/* 一次性交易对象识别码 */
nmck007       varchar2(1)      ,/* 生成方式 */
nmck008       varchar2(1)      ,/* 手续费负担者 */
nmck009       varchar2(10)      ,/* 存提码 */
nmck010       varchar2(10)      ,/* 现金变动码 */
nmck011       date      ,/* 到期日 */
nmck012       date      ,/* 实际汇款日 */
nmck013       varchar2(15)      ,/* 导入银行 */
nmck014       varchar2(30)      ,/* 导入帐号 */
nmck015       varchar2(255)      ,/* 导入户名 */
nmck016       varchar2(80)      ,/* 通知受汇人 EMAIL */
nmck017       varchar2(40)      ,/* iban no */
nmck018       varchar2(15)      ,/* swift code */
nmck019       varchar2(20)      ,/* 账务单号 */
nmck020       varchar2(20)      ,/* 次账一账务单号 */
nmck021       varchar2(20)      ,/* 次账二账务单号 */
nmck022       varchar2(20)      ,/* 经办人 */
nmck023       varchar2(10)      ,/* 款别分类 */
nmck024       varchar2(10)      ,/* 支票簿号 */
nmck025       varchar2(20)      ,/* 票据号码 */
nmck026       varchar2(10)      ,/* 票况 */
nmck027       varchar2(1)      ,/* 禁止背书转让 */
nmck028       number(20,6)      ,/* 票据保证金百分比 */
nmck029       number(20,6)      ,/* 票据保证金金额 */
nmck030       number(5,0)      ,/* 计息利率条件 */
nmck031       number(10,6)      ,/* 计息利率 */
nmck032       varchar2(15)      ,/* 承兑银行编号 */
nmck033       varchar2(24)      ,/* 对方会科 */
nmck034       varchar2(1)      ,/* 寄领方式 */
nmck035       date      ,/* 寄领日期 */
nmck036       varchar2(20)      ,/* 重立账单号 */
nmck100       varchar2(10)      ,/* 币种 */
nmck101       number(20,10)      ,/* 汇率 */
nmck103       number(20,6)      ,/* 原币金额 */
nmck113       number(20,6)      ,/* 本币金额 */
nmck114       number(20,6)      ,/* 重评后本币金额 */
nmck121       number(20,10)      ,/* 本位币二汇率 */
nmck124       number(20,6)      ,/* 重评后本位币二金额 */
nmck123       number(20,6)      ,/* 本位币二金额 */
nmck131       number(20,10)      ,/* 本位币三汇率 */
nmck133       number(20,6)      ,/* 本位币三金额 */
nmck134       number(20,6)      ,/* 重评后本位币三金额 */
nmckstus       varchar2(1)      ,/* 状态码 */
nmckownid       varchar2(20)      ,/* 资料所有者 */
nmckowndp       varchar2(10)      ,/* 资料所有部门 */
nmckcrtid       varchar2(20)      ,/* 资料录入者 */
nmckcrtdp       varchar2(10)      ,/* 资料录入部门 */
nmckcrtdt       timestamp(0)      ,/* 资料创建日 */
nmckmodid       varchar2(20)      ,/* 资料更改者 */
nmckmoddt       timestamp(0)      ,/* 最近更改日 */
nmckcnfid       varchar2(20)      ,/* 资料审核者 */
nmckcnfdt       timestamp(0)      ,/* 数据审核日 */
nmckud001       varchar2(40)      ,/* 自定义字段(文本)001 */
nmckud002       varchar2(40)      ,/* 自定义字段(文本)002 */
nmckud003       varchar2(40)      ,/* 自定义字段(文本)003 */
nmckud004       varchar2(40)      ,/* 自定义字段(文本)004 */
nmckud005       varchar2(40)      ,/* 自定义字段(文本)005 */
nmckud006       varchar2(40)      ,/* 自定义字段(文本)006 */
nmckud007       varchar2(40)      ,/* 自定义字段(文本)007 */
nmckud008       varchar2(40)      ,/* 自定义字段(文本)008 */
nmckud009       varchar2(40)      ,/* 自定义字段(文本)009 */
nmckud010       varchar2(40)      ,/* 自定义字段(文本)010 */
nmckud011       number(20,6)      ,/* 自定义字段(数字)011 */
nmckud012       number(20,6)      ,/* 自定义字段(数字)012 */
nmckud013       number(20,6)      ,/* 自定义字段(数字)013 */
nmckud014       number(20,6)      ,/* 自定义字段(数字)014 */
nmckud015       number(20,6)      ,/* 自定义字段(数字)015 */
nmckud016       number(20,6)      ,/* 自定义字段(数字)016 */
nmckud017       number(20,6)      ,/* 自定义字段(数字)017 */
nmckud018       number(20,6)      ,/* 自定义字段(数字)018 */
nmckud019       number(20,6)      ,/* 自定义字段(数字)019 */
nmckud020       number(20,6)      ,/* 自定义字段(数字)020 */
nmckud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
nmckud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
nmckud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
nmckud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
nmckud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
nmckud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
nmckud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
nmckud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
nmckud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
nmckud030       timestamp(0)      ,/* 自定义字段(日期时间)030 */
nmck037       varchar2(1)      ,/* 本行他行 */
nmck038       varchar2(1)      ,/* 同城异城 */
nmck039       varchar2(1)      ,/* 对公对私 */
nmck040       varchar2(40)      ,/* 省份 */
nmck041       varchar2(40)      ,/* 城市 */
nmck042       varchar2(80)      ,/* 附言 */
nmck043       varchar2(1)      ,/* 暂付否 */
nmck044       varchar2(10)      ,/* 保证金账户 */
nmck045       varchar2(10)      ,/* 保证金来源账户 */
nmck046       varchar2(10)      ,/* 保证金币种 */
nmck047       varchar2(10)      ,/* 存提码（入） */
nmck048       varchar2(10)      ,/* 存提码（出） */
nmck049       varchar2(10)      ,/* 现金变动码（入） */
nmck050       varchar2(10)      ,/* 现金变动码（出） */
nmck051       varchar2(20)      ,/* 保证金划拨单号 */
nmck052       varchar2(10)      /* 汇出性质理由码 */
);
alter table nmck_t add constraint nmck_pk primary key (nmckent,nmckcomp,nmckdocno) enable validate;

create unique index nmck_pk on nmck_t (nmckent,nmckcomp,nmckdocno);

grant select on nmck_t to tiptop;
grant update on nmck_t to tiptop;
grant delete on nmck_t to tiptop;
grant insert on nmck_t to tiptop;

exit;
