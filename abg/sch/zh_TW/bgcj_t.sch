/* 
================================================================================
檔案代號:bgcj_t
檔案名稱:销售预算主档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table bgcj_t
(
bgcjent       number(5)      ,/* 企业编号 */
bgcj001       varchar2(10)      ,/* 来源作业 */
bgcj002       varchar2(10)      ,/* 预算编号 */
bgcj003       varchar2(10)      ,/* 版本 */
bgcj004       varchar2(10)      ,/* 管理组织 */
bgcj005       varchar2(10)      ,/* 销售来源 */
bgcj006       varchar2(10)      ,/* 数据类型 */
bgcj007       varchar2(10)      ,/* 预算组织 */
bgcj008       number(5,0)      ,/* 预算期别 */
bgcj009       varchar2(40)      ,/* 预算料件 */
bgcj010       varchar2(1000)      ,/* 组合KEY */
bgcjseq       number(10,0)      ,/* 项次 */
bgcj011       varchar2(10)      ,/* 预算样表 */
bgcj012       varchar2(20)      ,/* 人员 */
bgcj013       varchar2(10)      ,/* 部门 */
bgcj014       varchar2(10)      ,/* 成本利润中心 */
bgcj015       varchar2(10)      ,/* 区域 */
bgcj016       varchar2(10)      ,/* 收付款客商 */
bgcj017       varchar2(10)      ,/* 账款客商 */
bgcj018       varchar2(10)      ,/* 客群 */
bgcj019       varchar2(10)      ,/* 产品类别 */
bgcj020       varchar2(20)      ,/* 项目编号 */
bgcj021       varchar2(30)      ,/* WBS */
bgcj022       varchar2(10)      ,/* 经营方式 */
bgcj023       varchar2(10)      ,/* 渠道 */
bgcj024       varchar2(10)      ,/* 品牌 */
bgcj025       varchar2(30)      ,/* 自由核算项一 */
bgcj026       varchar2(30)      ,/* 自由核算项二 */
bgcj027       varchar2(30)      ,/* 自由核算项三 */
bgcj028       varchar2(30)      ,/* 自由核算项四 */
bgcj029       varchar2(30)      ,/* 自由核算项五 */
bgcj030       varchar2(30)      ,/* 自由核算项六 */
bgcj031       varchar2(30)      ,/* 自由核算项七 */
bgcj032       varchar2(30)      ,/* 自由核算项八 */
bgcj033       varchar2(30)      ,/* 自由核算项九 */
bgcj034       varchar2(30)      ,/* 自由核算项十 */
bgcj035       varchar2(10)      ,/* 税种 */
bgcj036       varchar2(1)      ,/* 含税否 */
bgcj037       varchar2(10)      ,/* 销售单位 */
bgcj038       number(20,6)      ,/* 交易数量 */
bgcj039       number(20,6)      ,/* 单价 */
bgcj040       number(20,6)      ,/* 原币销售金额 */
bgcj041       number(20,6)      ,/* 本层调整数量 */
bgcj042       number(20,6)      ,/* 本层调整单价 */
bgcj043       number(20,6)      ,/* 上层调整数量 */
bgcj044       number(20,6)      ,/* 上层调整单价 */
bgcj045       number(20,6)      ,/* 核准数量 */
bgcj046       number(20,6)      ,/* 核准单价 */
bgcj047       varchar2(10)      ,/* 上层组织 */
bgcj048       varchar2(20)      ,/* 凭证单号 */
bgcj049       varchar2(24)      ,/* 预算细项 */
bgcj050       varchar2(10)      ,/* 编制起点 */
bgcj051       varchar2(1)      ,/* 生产预算抛转否 */
bgcj052       varchar2(10)      ,/* 内部采购组织 */
bgcj053       varchar2(24)      ,/* 内部采购预算细项 */
bgcj100       varchar2(10)      ,/* 交易币种 */
bgcj101       number(20,10)      ,/* 汇率 */
bgcj102       number(20,6)      ,/* 核准原币销售金额 */
bgcj103       number(20,6)      ,/* 核准原币税前金额 */
bgcj104       number(20,6)      ,/* 核准原币税额 */
bgcj105       number(20,6)      ,/* 核准原币含税金额 */
bgcjownid       varchar2(20)      ,/* 资料所有者 */
bgcjowndp       varchar2(10)      ,/* 资料所有部门 */
bgcjcrtid       varchar2(20)      ,/* 资料录入者 */
bgcjcrtdp       varchar2(10)      ,/* 资料录入部门 */
bgcjcrtdt       timestamp(0)      ,/* 资料创建日 */
bgcjmodid       varchar2(20)      ,/* 资料更改者 */
bgcjmoddt       timestamp(0)      ,/* 最近更改日 */
bgcjcnfid       varchar2(20)      ,/* 资料审核者 */
bgcjcnfdt       timestamp(0)      ,/* 数据审核日 */
bgcjstus       varchar2(10)      ,/* 状态码 */
bgcjud001       varchar2(40)      ,/* 自定义字段(文本)001 */
bgcjud002       varchar2(40)      ,/* 自定义字段(文本)002 */
bgcjud003       varchar2(40)      ,/* 自定义字段(文本)003 */
bgcjud004       varchar2(40)      ,/* 自定义字段(文本)004 */
bgcjud005       varchar2(40)      ,/* 自定义字段(文本)005 */
bgcjud006       varchar2(40)      ,/* 自定义字段(文本)006 */
bgcjud007       varchar2(40)      ,/* 自定义字段(文本)007 */
bgcjud008       varchar2(40)      ,/* 自定义字段(文本)008 */
bgcjud009       varchar2(40)      ,/* 自定义字段(文本)009 */
bgcjud010       varchar2(40)      ,/* 自定义字段(文本)010 */
bgcjud011       number(20,6)      ,/* 自定义字段(数字)011 */
bgcjud012       number(20,6)      ,/* 自定义字段(数字)012 */
bgcjud013       number(20,6)      ,/* 自定义字段(数字)013 */
bgcjud014       number(20,6)      ,/* 自定义字段(数字)014 */
bgcjud015       number(20,6)      ,/* 自定义字段(数字)015 */
bgcjud016       number(20,6)      ,/* 自定义字段(数字)016 */
bgcjud017       number(20,6)      ,/* 自定义字段(数字)017 */
bgcjud018       number(20,6)      ,/* 自定义字段(数字)018 */
bgcjud019       number(20,6)      ,/* 自定义字段(数字)019 */
bgcjud020       number(20,6)      ,/* 自定义字段(数字)020 */
bgcjud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
bgcjud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
bgcjud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
bgcjud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
bgcjud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
bgcjud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
bgcjud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
bgcjud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
bgcjud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
bgcjud030       timestamp(0)      /* 自定义字段(日期时间)030 */
);
alter table bgcj_t add constraint bgcj_pk primary key (bgcjent,bgcj001,bgcj002,bgcj003,bgcj004,bgcj005,bgcj006,bgcj007,bgcj008,bgcj009,bgcj010,bgcjseq) enable validate;

create unique index bgcj_pk on bgcj_t (bgcjent,bgcj001,bgcj002,bgcj003,bgcj004,bgcj005,bgcj006,bgcj007,bgcj008,bgcj009,bgcj010,bgcjseq);

grant select on bgcj_t to tiptop;
grant update on bgcj_t to tiptop;
grant delete on bgcj_t to tiptop;
grant insert on bgcj_t to tiptop;

exit;
