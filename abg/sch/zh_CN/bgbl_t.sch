/* 
================================================================================
檔案代號:bgbl_t
檔案名稱:预算挪用单身档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table bgbl_t
(
bgblent       number(5)      ,/* 企业编号 */
bgbldocno       varchar2(20)      ,/* 单号 */
bgblseq       number(10,0)      ,/* 项次 */
bgbl001       varchar2(1)      ,/* 来源目的 */
bgbl002       varchar2(24)      ,/* 预算细项 */
bgbl003       number(5,0)      ,/* 预算期别 */
bgbl004       number(5,0)      ,/* 滚动期别 */
bgbl005       varchar2(10)      ,/* 部门 */
bgbl006       varchar2(10)      ,/* 成本利润中心 */
bgbl007       varchar2(10)      ,/* 区域 */
bgbl008       varchar2(10)      ,/* 交易客商 */
bgbl009       varchar2(10)      ,/* 收款客商 */
bgbl010       varchar2(10)      ,/* 客群 */
bgbl011       varchar2(10)      ,/* 产品类别 */
bgbl012       varchar2(20)      ,/* 人员 */
bgbl013       varchar2(20)      ,/* 项目编号 */
bgbl014       varchar2(30)      ,/* WBS */
bgbl015       varchar2(10)      ,/* 经营方式 */
bgbl016       varchar2(10)      ,/* 渠道 */
bgbl017       varchar2(10)      ,/* 品牌 */
bgbl018       varchar2(30)      ,/* 自由核算项一 */
bgbl019       varchar2(30)      ,/* 自由核算项二 */
bgbl020       varchar2(30)      ,/* 自由核算项三 */
bgbl021       varchar2(30)      ,/* 自由核算项四 */
bgbl022       varchar2(30)      ,/* 自由核算项五 */
bgbl023       varchar2(30)      ,/* 自由核算项六 */
bgbl024       varchar2(30)      ,/* 自由核算项七 */
bgbl025       varchar2(30)      ,/* 自由核算项八 */
bgbl026       varchar2(30)      ,/* 自由核算项九 */
bgbl027       varchar2(30)      ,/* 自由核算项十 */
bgbl028       number(20,6)      ,/* 金额 */
bgblud001       varchar2(40)      ,/* 自定义字段(文本)001 */
bgblud002       varchar2(40)      ,/* 自定义字段(文本)002 */
bgblud003       varchar2(40)      ,/* 自定义字段(文本)003 */
bgblud004       varchar2(40)      ,/* 自定义字段(文本)004 */
bgblud005       varchar2(40)      ,/* 自定义字段(文本)005 */
bgblud006       varchar2(40)      ,/* 自定义字段(文本)006 */
bgblud007       varchar2(40)      ,/* 自定义字段(文本)007 */
bgblud008       varchar2(40)      ,/* 自定义字段(文本)008 */
bgblud009       varchar2(40)      ,/* 自定义字段(文本)009 */
bgblud010       varchar2(40)      ,/* 自定义字段(文本)010 */
bgblud011       number(20,6)      ,/* 自定义字段(数字)011 */
bgblud012       number(20,6)      ,/* 自定义字段(数字)012 */
bgblud013       number(20,6)      ,/* 自定义字段(数字)013 */
bgblud014       number(20,6)      ,/* 自定义字段(数字)014 */
bgblud015       number(20,6)      ,/* 自定义字段(数字)015 */
bgblud016       number(20,6)      ,/* 自定义字段(数字)016 */
bgblud017       number(20,6)      ,/* 自定义字段(数字)017 */
bgblud018       number(20,6)      ,/* 自定义字段(数字)018 */
bgblud019       number(20,6)      ,/* 自定义字段(数字)019 */
bgblud020       number(20,6)      ,/* 自定义字段(数字)020 */
bgblud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
bgblud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
bgblud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
bgblud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
bgblud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
bgblud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
bgblud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
bgblud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
bgblud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
bgblud030       timestamp(0)      /* 自定义字段(日期时间)030 */
);
alter table bgbl_t add constraint bgbl_pk primary key (bgblent,bgbldocno,bgblseq,bgbl001) enable validate;

create unique index bgbl_pk on bgbl_t (bgblent,bgbldocno,bgblseq,bgbl001);

grant select on bgbl_t to tiptop;
grant update on bgbl_t to tiptop;
grant delete on bgbl_t to tiptop;
grant insert on bgbl_t to tiptop;

exit;
