/* 
================================================================================
檔案代號:nmbb_t
檔案名稱:银存收支明细档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table nmbb_t
(
nmbbent       number(5)      ,/* 企业编号 */
nmbbcomp       varchar2(10)      ,/* 法人 */
nmbbdocno       varchar2(20)      ,/* 收支单号 */
nmbbseq       number(10,0)      ,/* 项次 */
nmbborga       varchar2(10)      ,/* 来源组织 */
nmbblegl       varchar2(10)      ,/* 核算组织 */
nmbb001       varchar2(1)      ,/* 异动别 */
nmbb002       varchar2(10)      ,/* 存提码 */
nmbb003       varchar2(10)      ,/* 交易账户编码 */
nmbb004       varchar2(10)      ,/* 币种 */
nmbb005       number(20,10)      ,/* 汇率 */
nmbb006       number(20,6)      ,/* 主账套原币金额 */
nmbb007       number(20,6)      ,/* 主账套本币金额 */
nmbb008       number(20,6)      ,/* 主账套已冲原币金额 */
nmbb009       number(20,6)      ,/* 主账套已冲本币金额 */
nmbb010       varchar2(10)      ,/* 现金变动码 */
nmbb011       varchar2(10)      ,/* 本位币二币种 */
nmbb012       number(20,10)      ,/* 本位币二汇率 */
nmbb013       number(20,6)      ,/* 本位币二金额 */
nmbb014       number(20,6)      ,/* 本位币二已冲金额 */
nmbb015       varchar2(10)      ,/* 本位币三币种 */
nmbb016       number(20,10)      ,/* 本位币三汇率 */
nmbb017       number(20,6)      ,/* 本位币三金额 */
nmbb018       number(20,6)      ,/* 本位币三已冲金额 */
nmbb019       varchar2(10)      ,/* 辅助账套一汇率 */
nmbb020       number(20,6)      ,/* 辅助账套一原币已冲 */
nmbb021       number(20,6)      ,/* 辅助账套一本币已冲 */
nmbb022       varchar2(10)      ,/* 辅助账套二汇率 */
nmbb023       number(20,6)      ,/* 辅助账套二原币已冲 */
nmbb024       number(20,6)      ,/* 辅助账套二本币已冲 */
nmbb025       varchar2(80)      ,/* 备注 */
nmbb026       varchar2(10)      ,/* 交易对象 */
nmbb027       varchar2(20)      ,/* 一次性交易对象识别码 */
nmbb028       varchar2(10)      ,/* 款别编码 */
nmbb029       varchar2(10)      ,/* 款别分类 */
nmbb030       varchar2(20)      ,/* 票据号码 */
nmbb031       date      ,/* 到期日 */
nmbb032       number(20,6)      ,/* 有价券数量 */
nmbb033       number(20,6)      ,/* 有价券面额 */
nmbb034       varchar2(20)      ,/* 有价券起始编号 */
nmbb035       varchar2(20)      ,/* 有价券结束编号 */
nmbb036       varchar2(15)      ,/* 刷卡银行 */
nmbb037       varchar2(30)      ,/* 信用卡卡号 */
nmbb038       number(20,6)      ,/* 手续费 */
nmbb039       varchar2(10)      ,/* 第三方代收机构 */
nmbb040       varchar2(1)      ,/* 背书转入 */
nmbb041       varchar2(255)      ,/* 发票人全名 */
nmbb042       varchar2(1)      ,/* 票况 */
nmbb043       varchar2(15)      ,/* 票据付款银行 */
nmbb044       varchar2(1)      ,/* 票面利率种类 */
nmbb045       number(10,6)      ,/* 票面利率百分比 */
nmbb046       varchar2(10)      ,/* 转付交易对象 */
nmbb047       number(5,0)      ,/* 票据流通期间 */
nmbb048       varchar2(1)      ,/* 贴现利率种类 */
nmbb049       number(10,6)      ,/* 贴现利率 */
nmbb050       number(5,0)      ,/* 贴现期间 */
nmbb051       number(20,6)      ,/* 贴现拨款原币金额 */
nmbb052       number(20,6)      ,/* 贴现拨款本币金额 */
nmbb053       varchar2(20)      ,/* 缴款人员 */
nmbb054       varchar2(10)      ,/* 缴款部门 */
nmbb055       varchar2(20)      ,/* POS缴款单号 */
nmbb056       number(20,10)      ,/* 入账汇率 */
nmbb057       number(20,6)      ,/* 入账原币金额 */
nmbb058       number(20,6)      ,/* 入账主账套本币金额 */
nmbb059       number(20,10)      ,/* 入账主账套本位币二汇率 */
nmbb060       number(20,6)      ,/* 入账主账套本位币二金额 */
nmbb061       number(20,10)      ,/* 入账主账套本位币三汇率 */
nmbb062       number(20,6)      ,/* 入账主账套本位币三金额 */
nmbb063       varchar2(24)      ,/* 对方会科 */
nmbb064       varchar2(1)      ,/* 差异处理状态 */
nmbb065       date      ,/* 开票日期 */
nmbb066       number(20,6)      ,/* 重评后本币金额 */
nmbb067       number(20,6)      ,/* 重评后本位币二金额 */
nmbb068       number(20,6)      ,/* 重评后本位币三金额 */
nmbb069       varchar2(1)      ,/* 质押否 */
nmbbud001       varchar2(40)      ,/* 自定义字段(文本)001 */
nmbbud002       varchar2(40)      ,/* 自定义字段(文本)002 */
nmbbud003       varchar2(40)      ,/* 自定义字段(文本)003 */
nmbbud004       varchar2(40)      ,/* 自定义字段(文本)004 */
nmbbud005       varchar2(40)      ,/* 自定义字段(文本)005 */
nmbbud006       varchar2(40)      ,/* 自定义字段(文本)006 */
nmbbud007       varchar2(40)      ,/* 自定义字段(文本)007 */
nmbbud008       varchar2(40)      ,/* 自定义字段(文本)008 */
nmbbud009       varchar2(40)      ,/* 自定义字段(文本)009 */
nmbbud010       varchar2(40)      ,/* 自定义字段(文本)010 */
nmbbud011       number(20,6)      ,/* 自定义字段(数字)011 */
nmbbud012       number(20,6)      ,/* 自定义字段(数字)012 */
nmbbud013       number(20,6)      ,/* 自定义字段(数字)013 */
nmbbud014       number(20,6)      ,/* 自定义字段(数字)014 */
nmbbud015       number(20,6)      ,/* 自定义字段(数字)015 */
nmbbud016       number(20,6)      ,/* 自定义字段(数字)016 */
nmbbud017       number(20,6)      ,/* 自定义字段(数字)017 */
nmbbud018       number(20,6)      ,/* 自定义字段(数字)018 */
nmbbud019       number(20,6)      ,/* 自定义字段(数字)019 */
nmbbud020       number(20,6)      ,/* 自定义字段(数字)020 */
nmbbud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
nmbbud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
nmbbud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
nmbbud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
nmbbud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
nmbbud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
nmbbud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
nmbbud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
nmbbud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
nmbbud030       timestamp(0)      ,/* 自定义字段(日期时间)030 */
nmbb070       varchar2(10)      ,/* 往来据点 */
nmbb071       varchar2(20)      ,/* 来源单号 */
nmbb072       number(10,0)      ,/* 项次 */
nmbb073       varchar2(30)      /* 开票帐号 */
);
alter table nmbb_t add constraint nmbb_pk primary key (nmbbent,nmbbcomp,nmbbdocno,nmbbseq) enable validate;

create unique index nmbb_pk on nmbb_t (nmbbent,nmbbcomp,nmbbdocno,nmbbseq);

grant select on nmbb_t to tiptop;
grant update on nmbb_t to tiptop;
grant delete on nmbb_t to tiptop;
grant insert on nmbb_t to tiptop;

exit;
