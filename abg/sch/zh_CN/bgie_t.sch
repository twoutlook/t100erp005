/* 
================================================================================
檔案代號:bgie_t
檔案名稱:往来项目预算档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table bgie_t
(
bgieent       number(5)      ,/* 企业编号 */
bgiedocno       varchar2(20)      ,/* 预算凭证编号 */
bgieseq       number(10,0)      ,/* 项次 */
bgie001       varchar2(10)      ,/* 预算编号 */
bgie002       varchar2(10)      ,/* 预算版本 */
bgie003       varchar2(10)      ,/* 预算组织 */
bgie004       varchar2(24)      ,/* 预算细项 */
bgie005       number(5,0)      ,/* 预算期别 */
bgie006       varchar2(1000)      ,/* 组合KEY */
bgie007       varchar2(20)      ,/* 人员 */
bgie008       varchar2(10)      ,/* 部门 */
bgie009       varchar2(10)      ,/* 成本利润中心 */
bgie010       varchar2(10)      ,/* 区域 */
bgie011       varchar2(10)      ,/* 收付款客商 */
bgie012       varchar2(10)      ,/* 账款客商 */
bgie013       varchar2(10)      ,/* 客群 */
bgie014       varchar2(10)      ,/* 产品类别 */
bgie015       varchar2(20)      ,/* 项目编号 */
bgie016       varchar2(30)      ,/* WBS */
bgie017       varchar2(10)      ,/* 经营方式 */
bgie018       varchar2(10)      ,/* 渠道 */
bgie019       varchar2(10)      ,/* 品牌 */
bgie020       varchar2(30)      ,/* 自由核算项一 */
bgie021       varchar2(30)      ,/* 自由核算项二 */
bgie022       varchar2(30)      ,/* 自由核算项三 */
bgie023       varchar2(30)      ,/* 自由核算项四 */
bgie024       varchar2(30)      ,/* 自由核算项五 */
bgie025       varchar2(30)      ,/* 自由核算项六 */
bgie026       varchar2(30)      ,/* 自由核算项七 */
bgie027       varchar2(30)      ,/* 自由核算项八 */
bgie028       varchar2(30)      ,/* 自由核算项九 */
bgie029       varchar2(30)      ,/* 自由核算项十 */
bgie030       varchar2(1)      ,/* 转资金否 */
bgie031       date      ,/* 账款日期 */
bgie032       date      ,/* 现金收支日期 */
bgie033       varchar2(10)      ,/* 往来类型 */
bgie034       varchar2(10)      ,/* 借贷别 */
bgie035       varchar2(10)      ,/* 上层组织 */
bgie100       varchar2(10)      ,/* 交易币种 */
bgie101       number(20,10)      ,/* 汇率 */
bgie103       number(20,6)      ,/* 预算币种交易金额 */
bgie104       number(20,6)      ,/* 原币交易金额 */
bgieud001       varchar2(40)      ,/* 自定义字段(文本)001 */
bgieud002       varchar2(40)      ,/* 自定义字段(文本)002 */
bgieud003       varchar2(40)      ,/* 自定义字段(文本)003 */
bgieud004       varchar2(40)      ,/* 自定义字段(文本)004 */
bgieud005       varchar2(40)      ,/* 自定义字段(文本)005 */
bgieud006       varchar2(40)      ,/* 自定义字段(文本)006 */
bgieud007       varchar2(40)      ,/* 自定义字段(文本)007 */
bgieud008       varchar2(40)      ,/* 自定义字段(文本)008 */
bgieud009       varchar2(40)      ,/* 自定义字段(文本)009 */
bgieud010       varchar2(40)      ,/* 自定义字段(文本)010 */
bgieud011       number(20,6)      ,/* 自定义字段(数字)011 */
bgieud012       number(20,6)      ,/* 自定义字段(数字)012 */
bgieud013       number(20,6)      ,/* 自定义字段(数字)013 */
bgieud014       number(20,6)      ,/* 自定义字段(数字)014 */
bgieud015       number(20,6)      ,/* 自定义字段(数字)015 */
bgieud016       number(20,6)      ,/* 自定义字段(数字)016 */
bgieud017       number(20,6)      ,/* 自定义字段(数字)017 */
bgieud018       number(20,6)      ,/* 自定义字段(数字)018 */
bgieud019       number(20,6)      ,/* 自定义字段(数字)019 */
bgieud020       number(20,6)      ,/* 自定义字段(数字)020 */
bgieud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
bgieud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
bgieud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
bgieud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
bgieud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
bgieud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
bgieud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
bgieud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
bgieud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
bgieud030       timestamp(0)      /* 自定义字段(日期时间)030 */
);
alter table bgie_t add constraint bgie_pk primary key (bgieent,bgiedocno,bgieseq) enable validate;

create unique index bgie_pk on bgie_t (bgieent,bgiedocno,bgieseq);

grant select on bgie_t to tiptop;
grant update on bgie_t to tiptop;
grant delete on bgie_t to tiptop;
grant insert on bgie_t to tiptop;

exit;
