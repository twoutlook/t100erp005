/* 
================================================================================
檔案代號:bgfb_t
檔案名稱:费用预算主档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table bgfb_t
(
bgfbent       number(5)      ,/* 企业编号 */
bgfb001       varchar2(10)      ,/* 来源作业 */
bgfb002       varchar2(10)      ,/* 预算编号 */
bgfb003       varchar2(10)      ,/* 版本 */
bgfb004       varchar2(10)      ,/* 管理组织 */
bgfb005       varchar2(10)      ,/* 费用来源 */
bgfb006       varchar2(10)      ,/* 数据类型 */
bgfb007       varchar2(10)      ,/* 预算组织 */
bgfb008       number(5,0)      ,/* 预算期别 */
bgfb009       varchar2(40)      ,/* 预算细项 */
bgfb010       varchar2(1000)      ,/* 组合KEY */
bgfbseq       number(10,0)      ,/* 项次 */
bgfb011       varchar2(10)      ,/* 预算样表 */
bgfb012       varchar2(20)      ,/* 人员 */
bgfb013       varchar2(10)      ,/* 部门 */
bgfb014       varchar2(10)      ,/* 成本利润中心 */
bgfb015       varchar2(10)      ,/* 区域 */
bgfb016       varchar2(10)      ,/* 收付款客商 */
bgfb017       varchar2(10)      ,/* 账款客商 */
bgfb018       varchar2(10)      ,/* 客群 */
bgfb019       varchar2(10)      ,/* 产品类别 */
bgfb020       varchar2(20)      ,/* 项目编号 */
bgfb021       varchar2(30)      ,/* WBS */
bgfb022       varchar2(10)      ,/* 经营方式 */
bgfb023       varchar2(10)      ,/* 渠道 */
bgfb024       varchar2(10)      ,/* 品牌 */
bgfb025       varchar2(30)      ,/* 自由核算项一 */
bgfb026       varchar2(30)      ,/* 自由核算项二 */
bgfb027       varchar2(30)      ,/* 自由核算项三 */
bgfb028       varchar2(30)      ,/* 自由核算项四 */
bgfb029       varchar2(30)      ,/* 自由核算项五 */
bgfb030       varchar2(30)      ,/* 自由核算项六 */
bgfb031       varchar2(30)      ,/* 自由核算项七 */
bgfb032       varchar2(30)      ,/* 自由核算项八 */
bgfb033       varchar2(30)      ,/* 自由核算项九 */
bgfb034       varchar2(30)      ,/* 自由核算项十 */
bgfb035       varchar2(10)      ,/* 税种 */
bgfb036       varchar2(1)      ,/* 含税否 */
bgfb037       number(20,6)      ,/* 原币费用金额 */
bgfb038       number(20,6)      ,/* 本层调整金额 */
bgfb039       number(20,6)      ,/* 上层调整金额 */
bgfb047       varchar2(10)      ,/* 上层组织 */
bgfb048       varchar2(20)      ,/* 凭证单号 */
bgfb100       varchar2(10)      ,/* 交易币种 */
bgfb101       number(20,10)      ,/* 汇率 */
bgfb102       number(20,6)      ,/* 核准原币费用金额 */
bgfb103       number(20,6)      ,/* 核准原币税前金额 */
bgfb104       number(20,6)      ,/* 核准原币税额 */
bgfb105       number(20,6)      ,/* 核准原币含税金额 */
bgfbstus       varchar2(10)      ,/* 状态码 */
bgfbownid       varchar2(20)      ,/* 资料所有者 */
bgfbowndp       varchar2(10)      ,/* 资料所有部门 */
bgfbcrtid       varchar2(20)      ,/* 资料录入者 */
bgfbcrtdp       varchar2(10)      ,/* 资料录入部门 */
bgfbcrtdt       timestamp(0)      ,/* 资料创建日 */
bgfbmodid       varchar2(20)      ,/* 资料更改者 */
bgfbmoddt       timestamp(0)      ,/* 最近更改日 */
bgfbcnfid       varchar2(20)      ,/* 资料审核者 */
bgfbcnfdt       timestamp(0)      ,/* 数据审核日 */
bgfbud001       varchar2(40)      ,/* 自定义字段(文本)001 */
bgfbud002       varchar2(40)      ,/* 自定义字段(文本)002 */
bgfbud003       varchar2(40)      ,/* 自定义字段(文本)003 */
bgfbud004       varchar2(40)      ,/* 自定义字段(文本)004 */
bgfbud005       varchar2(40)      ,/* 自定义字段(文本)005 */
bgfbud006       varchar2(40)      ,/* 自定义字段(文本)006 */
bgfbud007       varchar2(40)      ,/* 自定义字段(文本)007 */
bgfbud008       varchar2(40)      ,/* 自定义字段(文本)008 */
bgfbud009       varchar2(40)      ,/* 自定义字段(文本)009 */
bgfbud010       varchar2(40)      ,/* 自定义字段(文本)010 */
bgfbud011       number(20,6)      ,/* 自定义字段(数字)011 */
bgfbud012       number(20,6)      ,/* 自定义字段(数字)012 */
bgfbud013       number(20,6)      ,/* 自定义字段(数字)013 */
bgfbud014       number(20,6)      ,/* 自定义字段(数字)014 */
bgfbud015       number(20,6)      ,/* 自定义字段(数字)015 */
bgfbud016       number(20,6)      ,/* 自定义字段(数字)016 */
bgfbud017       number(20,6)      ,/* 自定义字段(数字)017 */
bgfbud018       number(20,6)      ,/* 自定义字段(数字)018 */
bgfbud019       number(20,6)      ,/* 自定义字段(数字)019 */
bgfbud020       number(20,6)      ,/* 自定义字段(数字)020 */
bgfbud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
bgfbud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
bgfbud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
bgfbud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
bgfbud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
bgfbud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
bgfbud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
bgfbud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
bgfbud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
bgfbud030       timestamp(0)      /* 自定义字段(日期时间)030 */
);
alter table bgfb_t add constraint bgfb_pk primary key (bgfbent,bgfb001,bgfb002,bgfb003,bgfb004,bgfb005,bgfb006,bgfb007,bgfb008,bgfb009,bgfb010,bgfbseq) enable validate;

create unique index bgfb_pk on bgfb_t (bgfbent,bgfb001,bgfb002,bgfb003,bgfb004,bgfb005,bgfb006,bgfb007,bgfb008,bgfb009,bgfb010,bgfbseq);

grant select on bgfb_t to tiptop;
grant update on bgfb_t to tiptop;
grant delete on bgfb_t to tiptop;
grant insert on bgfb_t to tiptop;

exit;
