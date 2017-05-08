/* 
================================================================================
檔案代號:bggo_t
檔案名稱:人工费用预算明细档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table bggo_t
(
bggoent       number(5)      ,/* 企业编号 */
bggo001       varchar2(10)      ,/* 来源作业 */
bggo002       varchar2(10)      ,/* 预算编号 */
bggo003       varchar2(10)      ,/* 版本 */
bggo004       varchar2(10)      ,/* 管理组织 */
bggo005       varchar2(10)      ,/* 人工来源 */
bggo006       varchar2(10)      ,/* 数据源 */
bggo007       varchar2(10)      ,/* 预算组织 */
bggo008       number(5,0)      ,/* 期别 */
bggoseq       number(10,0)      ,/* 项次 */
bggoseq2       number(10,0)      ,/* 项序 */
bggo009       varchar2(10)      ,/* 工资项目 */
bggo010       varchar2(1000)      ,/* 组合 key */
bggo011       varchar2(10)      ,/* 预算样表 */
bggo012       varchar2(20)      ,/* 人员 */
bggo013       varchar2(10)      ,/* 部门 */
bggo014       varchar2(10)      ,/* 成本利润中心 */
bggo015       varchar2(10)      ,/* 区域 */
bggo016       varchar2(10)      ,/* 收付款供应商 */
bggo017       varchar2(10)      ,/* 账款客商 */
bggo018       varchar2(10)      ,/* 客群 */
bggo019       varchar2(10)      ,/* 产品类别 */
bggo020       varchar2(20)      ,/* 项目编号 */
bggo021       varchar2(30)      ,/* WBS */
bggo022       varchar2(10)      ,/* 经营方式 */
bggo023       varchar2(10)      ,/* 渠道 */
bggo024       varchar2(10)      ,/* 品牌 */
bggo025       varchar2(30)      ,/* 自由核算项一 */
bggo026       varchar2(30)      ,/* 自由核算项二 */
bggo027       varchar2(30)      ,/* 自由核算项三 */
bggo028       varchar2(30)      ,/* 自由核算项四 */
bggo029       varchar2(30)      ,/* 自由核算项五 */
bggo030       varchar2(30)      ,/* 自由核算项六 */
bggo031       varchar2(30)      ,/* 自由核算项七 */
bggo032       varchar2(30)      ,/* 自由核算项八 */
bggo033       varchar2(30)      ,/* 自由核算项九 */
bggo034       varchar2(30)      ,/* 自由核算项十 */
bggo035       number(10,0)      ,/* 用工人数 */
bggo036       number(20,6)      ,/* 薪资基准 */
bggo037       varchar2(10)      ,/* 上层组织 */
bggo038       varchar2(20)      ,/* 凭证单号 */
bggo039       varchar2(24)      ,/* 借方预算细项 */
bggo040       varchar2(24)      ,/* 贷方预算细项 */
bggo041       varchar2(10)      ,/* 工资方案 */
bggo042       varchar2(10)      ,/* 职级 */
bggo043       varchar2(10)      ,/* 职等 */
bggo044       varchar2(10)      ,/* 用工属性 */
bggo100       varchar2(10)      ,/* 币种 */
bggo101       number(20,10)      ,/* 汇率 */
bggo103       number(20,6)      ,/* 预算金额 */
bggo104       number(20,6)      ,/* 本层调整金额 */
bggo105       number(20,6)      ,/* 上层调整金额 */
bggo106       number(20,6)      ,/* 核准金额 */
bggostus       varchar2(10)      ,/* 状态码 */
bggoud001       varchar2(40)      ,/* 自定义字段(文本)001 */
bggoud002       varchar2(40)      ,/* 自定义字段(文本)002 */
bggoud003       varchar2(40)      ,/* 自定义字段(文本)003 */
bggoud004       varchar2(40)      ,/* 自定义字段(文本)004 */
bggoud005       varchar2(40)      ,/* 自定义字段(文本)005 */
bggoud006       varchar2(40)      ,/* 自定义字段(文本)006 */
bggoud007       varchar2(40)      ,/* 自定义字段(文本)007 */
bggoud008       varchar2(40)      ,/* 自定义字段(文本)008 */
bggoud009       varchar2(40)      ,/* 自定义字段(文本)009 */
bggoud010       varchar2(40)      ,/* 自定义字段(文本)010 */
bggoud011       number(20,6)      ,/* 自定义字段(数字)011 */
bggoud012       number(20,6)      ,/* 自定义字段(数字)012 */
bggoud013       number(20,6)      ,/* 自定义字段(数字)013 */
bggoud014       number(20,6)      ,/* 自定义字段(数字)014 */
bggoud015       number(20,6)      ,/* 自定义字段(数字)015 */
bggoud016       number(20,6)      ,/* 自定义字段(数字)016 */
bggoud017       number(20,6)      ,/* 自定义字段(数字)017 */
bggoud018       number(20,6)      ,/* 自定义字段(数字)018 */
bggoud019       number(20,6)      ,/* 自定义字段(数字)019 */
bggoud020       number(20,6)      ,/* 自定义字段(数字)020 */
bggoud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
bggoud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
bggoud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
bggoud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
bggoud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
bggoud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
bggoud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
bggoud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
bggoud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
bggoud030       timestamp(0)      /* 自定义字段(日期时间)030 */
);
alter table bggo_t add constraint bggo_pk primary key (bggoent,bggo001,bggo002,bggo003,bggo005,bggo006,bggo007,bggo008,bggoseq,bggoseq2) enable validate;

create unique index bggo_pk on bggo_t (bggoent,bggo001,bggo002,bggo003,bggo005,bggo006,bggo007,bggo008,bggoseq,bggoseq2);

grant select on bggo_t to tiptop;
grant update on bggo_t to tiptop;
grant delete on bggo_t to tiptop;
grant insert on bggo_t to tiptop;

exit;
