/* 
================================================================================
檔案代號:bgeg_t
檔案名稱:采购预算主档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table bgeg_t
(
bgegent       number(5)      ,/* 企业编号 */
bgeg001       varchar2(10)      ,/* 来源作业 */
bgeg002       varchar2(10)      ,/* 预算编号 */
bgeg003       varchar2(10)      ,/* 版本 */
bgeg004       varchar2(10)      ,/* 管理组织 */
bgeg005       varchar2(10)      ,/* 采购来源 */
bgeg006       varchar2(10)      ,/* 数据类型 */
bgeg007       varchar2(10)      ,/* 预算组织 */
bgeg008       number(5,0)      ,/* 预算期别 */
bgeg009       varchar2(40)      ,/* 预算料件 */
bgeg010       varchar2(1000)      ,/* 组合KEY */
bgegseq       number(10,0)      ,/* 项次 */
bgeg011       varchar2(10)      ,/* 预算样表 */
bgeg012       varchar2(20)      ,/* 人员 */
bgeg013       varchar2(10)      ,/* 部门 */
bgeg014       varchar2(10)      ,/* 成本利润中心 */
bgeg015       varchar2(10)      ,/* 区域 */
bgeg016       varchar2(10)      ,/* 供应商编号 */
bgeg017       varchar2(10)      ,/* 付款对象 */
bgeg018       varchar2(10)      ,/* 客群 */
bgeg019       varchar2(10)      ,/* 产品类别 */
bgeg020       varchar2(20)      ,/* 项目编号 */
bgeg021       varchar2(30)      ,/* WBS */
bgeg022       varchar2(10)      ,/* 经营方式 */
bgeg023       varchar2(10)      ,/* 渠道 */
bgeg024       varchar2(10)      ,/* 品牌 */
bgeg025       varchar2(30)      ,/* 自由核算项一 */
bgeg026       varchar2(30)      ,/* 自由核算项二 */
bgeg027       varchar2(30)      ,/* 自由核算项三 */
bgeg028       varchar2(30)      ,/* 自由核算项四 */
bgeg029       varchar2(30)      ,/* 自由核算项五 */
bgeg030       varchar2(30)      ,/* 自由核算项六 */
bgeg031       varchar2(30)      ,/* 自由核算项七 */
bgeg032       varchar2(30)      ,/* 自由核算项八 */
bgeg033       varchar2(30)      ,/* 自由核算项九 */
bgeg034       varchar2(30)      ,/* 自由核算项十 */
bgeg035       varchar2(10)      ,/* 税种 */
bgeg036       varchar2(1)      ,/* 含税否 */
bgeg037       varchar2(10)      ,/* 采购单位 */
bgeg038       number(20,6)      ,/* 交易数量 */
bgeg039       number(20,6)      ,/* 单价 */
bgeg040       number(20,6)      ,/* 原币采购金额 */
bgeg041       number(20,6)      ,/* 本层调整数量 */
bgeg042       number(20,6)      ,/* 本层调整单价 */
bgeg043       number(20,6)      ,/* 上层调整数量 */
bgeg044       number(20,6)      ,/* 上层调整单价 */
bgeg045       number(20,6)      ,/* 核准数量 */
bgeg046       number(20,6)      ,/* 核准单价 */
bgeg047       varchar2(10)      ,/* 上层组织 */
bgeg048       varchar2(20)      ,/* 凭证单号 */
bgeg049       varchar2(24)      ,/* 预算细项 */
bgeg050       varchar2(10)      ,/* 编制起点 */
bgeg051       varchar2(1)      ,/* 内部采购单抛转否 */
bgeg100       varchar2(10)      ,/* 交易币种 */
bgeg101       number(20,10)      ,/* 汇率 */
bgeg102       number(20,6)      ,/* 核准原币采购金额 */
bgeg103       number(20,6)      ,/* 核准原币税前金额 */
bgeg104       number(20,6)      ,/* 核准原币税额 */
bgeg105       number(20,6)      ,/* 核准原币含税金额 */
bgegstus       varchar2(10)      ,/* 状态码 */
bgegownid       varchar2(20)      ,/* 资料所有者 */
bgegowndp       varchar2(10)      ,/* 资料所有部门 */
bgegcrtid       varchar2(20)      ,/* 资料录入者 */
bgegcrtdp       varchar2(10)      ,/* 资料录入部门 */
bgegcrtdt       timestamp(0)      ,/* 资料创建日 */
bgegmodid       varchar2(20)      ,/* 资料更改者 */
bgegmoddt       timestamp(0)      ,/* 最近更改日 */
bgegcnfid       varchar2(20)      ,/* 资料审核者 */
bgegcnfdt       timestamp(0)      ,/* 数据审核日 */
bgegud001       varchar2(40)      ,/* 自定义字段(文本)001 */
bgegud002       varchar2(40)      ,/* 自定义字段(文本)002 */
bgegud003       varchar2(40)      ,/* 自定义字段(文本)003 */
bgegud004       varchar2(40)      ,/* 自定义字段(文本)004 */
bgegud005       varchar2(40)      ,/* 自定义字段(文本)005 */
bgegud006       varchar2(40)      ,/* 自定义字段(文本)006 */
bgegud007       varchar2(40)      ,/* 自定义字段(文本)007 */
bgegud008       varchar2(40)      ,/* 自定义字段(文本)008 */
bgegud009       varchar2(40)      ,/* 自定义字段(文本)009 */
bgegud010       varchar2(40)      ,/* 自定义字段(文本)010 */
bgegud011       number(20,6)      ,/* 自定义字段(数字)011 */
bgegud012       number(20,6)      ,/* 自定义字段(数字)012 */
bgegud013       number(20,6)      ,/* 自定义字段(数字)013 */
bgegud014       number(20,6)      ,/* 自定义字段(数字)014 */
bgegud015       number(20,6)      ,/* 自定义字段(数字)015 */
bgegud016       number(20,6)      ,/* 自定义字段(数字)016 */
bgegud017       number(20,6)      ,/* 自定义字段(数字)017 */
bgegud018       number(20,6)      ,/* 自定义字段(数字)018 */
bgegud019       number(20,6)      ,/* 自定义字段(数字)019 */
bgegud020       number(20,6)      ,/* 自定义字段(数字)020 */
bgegud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
bgegud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
bgegud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
bgegud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
bgegud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
bgegud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
bgegud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
bgegud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
bgegud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
bgegud030       timestamp(0)      /* 自定义字段(日期时间)030 */
);
alter table bgeg_t add constraint bgeg_pk primary key (bgegent,bgeg001,bgeg002,bgeg003,bgeg004,bgeg005,bgeg006,bgeg007,bgeg008,bgeg009,bgeg010,bgegseq) enable validate;

create unique index bgeg_pk on bgeg_t (bgegent,bgeg001,bgeg002,bgeg003,bgeg004,bgeg005,bgeg006,bgeg007,bgeg008,bgeg009,bgeg010,bgegseq);

grant select on bgeg_t to tiptop;
grant update on bgeg_t to tiptop;
grant delete on bgeg_t to tiptop;
grant insert on bgeg_t to tiptop;

exit;
