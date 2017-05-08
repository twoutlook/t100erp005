/* 
================================================================================
檔案代號:faca_t
檔案名稱:调拨账务单身档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table faca_t
(
facaent       number(5)      ,/* 企业代码 */
facald       varchar2(5)      ,/* 账套 */
facadocno       varchar2(20)      ,/* 单号 */
facaseq       number(10,0)      ,/* 项次 */
faca001       varchar2(20)      ,/* 来源单号 */
faca002       number(10,0)      ,/* 来源项次 */
faca003       varchar2(20)      ,/* 财产编号 */
faca004       varchar2(20)      ,/* 附号 */
faca005       varchar2(10)      ,/* 卡片编号 */
faca006       varchar2(10)      ,/* 单位 */
faca007       number(20,6)      ,/* 单价 */
faca008       number(20,6)      ,/* 调拨数量 */
faca009       number(20,6)      ,/* 调拨成本 */
faca010       varchar2(10)      ,/* 税种 */
faca011       number(20,6)      ,/* 原币税前金额 */
faca012       number(20,6)      ,/* 原币税额 */
faca013       number(20,6)      ,/* 原币应收金额 */
faca014       number(20,6)      ,/* 本币税前金额 */
faca015       number(20,6)      ,/* 本币税额 */
faca016       number(20,6)      ,/* 本币应收金额 */
faca017       number(5,2)      ,/* 税率 */
faca018       number(20,6)      ,/* 处置损益 */
faca019       varchar2(24)      ,/* 异动科目 */
faca020       varchar2(24)      ,/* 累折科目 */
faca021       varchar2(24)      ,/* 减值准备科目 */
faca022       varchar2(24)      ,/* 资产科目 */
faca023       varchar2(24)      ,/* 应收/付账款科目 */
faca024       varchar2(24)      ,/* 税额科目 */
faca025       varchar2(10)      ,/* 营运据点 */
faca026       varchar2(10)      ,/* 部门 */
faca027       varchar2(10)      ,/* 利润/成本中心 */
faca028       varchar2(10)      ,/* 区域 */
faca029       varchar2(10)      ,/* 交易客商 */
faca030       varchar2(10)      ,/* 账款客商 */
faca031       varchar2(10)      ,/* 客群 */
faca032       varchar2(20)      ,/* 人员 */
faca033       varchar2(20)      ,/* 项目编号 */
faca034       varchar2(30)      ,/* WBS */
faca035       varchar2(20)      ,/* 账款编号 */
faca036       varchar2(40)      ,/* 摘要 */
faca037       varchar2(20)      ,/* 应收/付账款单号 */
faca038       varchar2(10)      ,/* 本位币二币种 */
faca039       number(20,10)      ,/* 本位币二汇率 */
faca040       number(20,6)      ,/* 本位币二税前金额 */
faca041       number(20,6)      ,/* 本位币二税额 */
faca042       number(20,6)      ,/* 本位币二应收金额 */
faca043       number(20,6)      ,/* 本位币二调拨成本 */
faca044       number(20,6)      ,/* 本位币二处置损益 */
faca045       varchar2(10)      ,/* 本位币三币种 */
faca046       number(20,10)      ,/* 本位币三汇率 */
faca047       number(20,6)      ,/* 本位币三税前金额 */
faca048       number(20,6)      ,/* 本位币三税额 */
faca049       number(20,6)      ,/* 本位币三应收金额 */
faca050       number(20,6)      ,/* 本位币三调拨成本 */
faca051       number(20,6)      ,/* 本位币三处置损益 */
faca052       varchar2(40)      ,/* 经营方式 */
faca053       varchar2(40)      ,/* 渠道 */
faca054       varchar2(40)      ,/* 品牌 */
faca055       varchar2(30)      ,/* 自由核算项一 */
faca056       varchar2(30)      ,/* 自由核算项二 */
faca057       varchar2(30)      ,/* 自由核算项三 */
faca058       varchar2(30)      ,/* 自由核算项四 */
faca059       varchar2(30)      ,/* 自由核算项五 */
faca060       varchar2(30)      ,/* 自由核算项六 */
faca061       varchar2(30)      ,/* 自由核算项七 */
faca062       varchar2(30)      ,/* 自由核算项八 */
faca063       varchar2(30)      ,/* 自由核算项九 */
faca064       varchar2(30)      ,/* 自由核算项十 */
faca065       varchar2(10)      ,/* 产品类别 */
facaud001       varchar2(40)      ,/* 自定义字段(文本)001 */
facaud002       varchar2(40)      ,/* 自定义字段(文本)002 */
facaud003       varchar2(40)      ,/* 自定义字段(文本)003 */
facaud004       varchar2(40)      ,/* 自定义字段(文本)004 */
facaud005       varchar2(40)      ,/* 自定义字段(文本)005 */
facaud006       varchar2(40)      ,/* 自定义字段(文本)006 */
facaud007       varchar2(40)      ,/* 自定义字段(文本)007 */
facaud008       varchar2(40)      ,/* 自定义字段(文本)008 */
facaud009       varchar2(40)      ,/* 自定义字段(文本)009 */
facaud010       varchar2(40)      ,/* 自定义字段(文本)010 */
facaud011       number(20,6)      ,/* 自定义字段(数字)011 */
facaud012       number(20,6)      ,/* 自定义字段(数字)012 */
facaud013       number(20,6)      ,/* 自定义字段(数字)013 */
facaud014       number(20,6)      ,/* 自定义字段(数字)014 */
facaud015       number(20,6)      ,/* 自定义字段(数字)015 */
facaud016       number(20,6)      ,/* 自定义字段(数字)016 */
facaud017       number(20,6)      ,/* 自定义字段(数字)017 */
facaud018       number(20,6)      ,/* 自定义字段(数字)018 */
facaud019       number(20,6)      ,/* 自定义字段(数字)019 */
facaud020       number(20,6)      ,/* 自定义字段(数字)020 */
facaud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
facaud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
facaud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
facaud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
facaud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
facaud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
facaud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
facaud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
facaud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
facaud030       timestamp(0)      /* 自定义字段(日期时间)030 */
);
alter table faca_t add constraint faca_pk primary key (facaent,facald,facadocno,facaseq) enable validate;

create unique index faca_pk on faca_t (facaent,facald,facadocno,facaseq);

grant select on faca_t to tiptop;
grant update on faca_t to tiptop;
grant delete on faca_t to tiptop;
grant insert on faca_t to tiptop;

exit;
