/* 
================================================================================
檔案代號:bgbj_t
檔案名稱:预算期初数据档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table bgbj_t
(
bgbjent       number(5)      ,/* 企业编号 */
bgbjseq       number(10,0)      ,/* 项次 */
bgbj001       varchar2(10)      ,/* 预算编号 */
bgbj002       varchar2(10)      ,/* 预算组织 */
bgbj003       varchar2(24)      ,/* 预算细项 */
bgbj004       varchar2(255)      ,/* 摘要 */
bgbj005       varchar2(10)      ,/* 部门 */
bgbj006       varchar2(10)      ,/* 成本利润中心 */
bgbj007       varchar2(10)      ,/* 区域 */
bgbj008       varchar2(10)      ,/* 交易客商 */
bgbj009       varchar2(10)      ,/* 收款客商 */
bgbj010       varchar2(10)      ,/* 客群 */
bgbj011       varchar2(10)      ,/* 产品类别 */
bgbj012       varchar2(20)      ,/* 人员 */
bgbj013       varchar2(20)      ,/* 项目编号 */
bgbj014       varchar2(30)      ,/* WBS */
bgbj015       varchar2(10)      ,/* 经营方式 */
bgbj016       varchar2(10)      ,/* 渠道 */
bgbj017       varchar2(10)      ,/* 品牌 */
bgbj018       varchar2(30)      ,/* 自由核算项一 */
bgbj019       varchar2(30)      ,/* 自由核算项二 */
bgbj020       varchar2(30)      ,/* 自由核算项三 */
bgbj021       varchar2(30)      ,/* 自由核算项四 */
bgbj022       varchar2(30)      ,/* 自由核算项五 */
bgbj023       varchar2(30)      ,/* 自由核算项六 */
bgbj024       varchar2(30)      ,/* 自由核算项七 */
bgbj025       varchar2(30)      ,/* 自由核算项八 */
bgbj026       varchar2(30)      ,/* 自由核算项九 */
bgbj027       varchar2(30)      ,/* 自由核算项十 */
bgbj028       varchar2(10)      ,/* 交易币种 */
bgbj029       number(20,6)      ,/* 税前单价 */
bgbj030       number(20,6)      ,/* 交易数量 */
bgbj031       number(20,10)      ,/* 汇率 */
bgbj032       number(20,6)      ,/* 原币金额 */
bgbj033       number(20,6)      ,/* 本币金额 */
bgbjownid       varchar2(20)      ,/* 资料所有者 */
bgbjowndp       varchar2(10)      ,/* 资料所有部门 */
bgbjcrtid       varchar2(20)      ,/* 资料录入者 */
bgbjcrtdp       varchar2(10)      ,/* 资料录入部门 */
bgbjcrtdt       timestamp(0)      ,/* 资料创建日 */
bgbjmodid       varchar2(20)      ,/* 资料更改者 */
bgbjmoddt       timestamp(0)      ,/* 最近更改日 */
bgbjcnfid       varchar2(20)      ,/* 资料审核者 */
bgbjcnfdt       timestamp(0)      ,/* 数据审核日 */
bgbjpstid       varchar2(20)      ,/* 资料过账者 */
bgbjpstdt       timestamp(0)      ,/* 资料过账日 */
bgbjstus       varchar2(10)      ,/* 状态码 */
bgbjud001       varchar2(40)      ,/* 自定义字段(文本)001 */
bgbjud002       varchar2(40)      ,/* 自定义字段(文本)002 */
bgbjud003       varchar2(40)      ,/* 自定义字段(文本)003 */
bgbjud004       varchar2(40)      ,/* 自定义字段(文本)004 */
bgbjud005       varchar2(40)      ,/* 自定义字段(文本)005 */
bgbjud006       varchar2(40)      ,/* 自定义字段(文本)006 */
bgbjud007       varchar2(40)      ,/* 自定义字段(文本)007 */
bgbjud008       varchar2(40)      ,/* 自定义字段(文本)008 */
bgbjud009       varchar2(40)      ,/* 自定义字段(文本)009 */
bgbjud010       varchar2(40)      ,/* 自定义字段(文本)010 */
bgbjud011       number(20,6)      ,/* 自定义字段(数字)011 */
bgbjud012       number(20,6)      ,/* 自定义字段(数字)012 */
bgbjud013       number(20,6)      ,/* 自定义字段(数字)013 */
bgbjud014       number(20,6)      ,/* 自定义字段(数字)014 */
bgbjud015       number(20,6)      ,/* 自定义字段(数字)015 */
bgbjud016       number(20,6)      ,/* 自定义字段(数字)016 */
bgbjud017       number(20,6)      ,/* 自定义字段(数字)017 */
bgbjud018       number(20,6)      ,/* 自定义字段(数字)018 */
bgbjud019       number(20,6)      ,/* 自定义字段(数字)019 */
bgbjud020       number(20,6)      ,/* 自定义字段(数字)020 */
bgbjud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
bgbjud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
bgbjud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
bgbjud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
bgbjud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
bgbjud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
bgbjud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
bgbjud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
bgbjud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
bgbjud030       timestamp(0)      /* 自定义字段(日期时间)030 */
);
alter table bgbj_t add constraint bgbj_pk primary key (bgbjent,bgbjseq,bgbj001,bgbj002,bgbj003) enable validate;

create unique index bgbj_pk on bgbj_t (bgbjent,bgbjseq,bgbj001,bgbj002,bgbj003);

grant select on bgbj_t to tiptop;
grant update on bgbj_t to tiptop;
grant delete on bgbj_t to tiptop;
grant insert on bgbj_t to tiptop;

exit;
