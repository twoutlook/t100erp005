/* 
================================================================================
檔案代號:bgbe_t
檔案名稱:预算追加档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table bgbe_t
(
bgbeent       number(5)      ,/* 企业编号 */
bgbedocdt       date      ,/* 单据日期 */
bgbedocno       varchar2(20)      ,/* 单号 */
bgbe001       varchar2(10)      ,/* 预算编号 */
bgbe002       varchar2(10)      ,/* 预算版本 */
bgbe003       varchar2(10)      ,/* 预算组织 */
bgbe004       varchar2(24)      ,/* 预算细项 */
bgbe005       varchar2(255)      ,/* 摘要 */
bgbe006       number(5,0)      ,/* 预算期别 */
bgbe007       varchar2(10)      ,/* 部门 */
bgbe008       varchar2(10)      ,/* 成本利润中心 */
bgbe009       varchar2(10)      ,/* 区域 */
bgbe010       varchar2(10)      ,/* 交易客商 */
bgbe011       varchar2(10)      ,/* 收款客商 */
bgbe012       varchar2(10)      ,/* 客群 */
bgbe013       varchar2(10)      ,/* 产品类别 */
bgbe014       varchar2(20)      ,/* 人员 */
bgbe015       varchar2(20)      ,/* 项目编号 */
bgbe016       varchar2(30)      ,/* WBS */
bgbe017       varchar2(10)      ,/* 经营方式 */
bgbe018       varchar2(10)      ,/* 渠道 */
bgbe019       varchar2(10)      ,/* 品牌 */
bgbe020       varchar2(30)      ,/* 自由核算项一 */
bgbe021       varchar2(30)      ,/* 自由核算项二 */
bgbe022       varchar2(30)      ,/* 自由核算项三 */
bgbe023       varchar2(30)      ,/* 自由核算项四 */
bgbe024       varchar2(30)      ,/* 自由核算项五 */
bgbe025       varchar2(30)      ,/* 自由核算项六 */
bgbe026       varchar2(30)      ,/* 自由核算项七 */
bgbe027       varchar2(30)      ,/* 自由核算项八 */
bgbe028       varchar2(30)      ,/* 自由核算项九 */
bgbe029       varchar2(30)      ,/* 自由核算项十 */
bgbe030       number(20,6)      ,/* 金额 */
bgbe031       number(5,0)      ,/* 滚动期别 */
bgbeownid       varchar2(20)      ,/* 资料所有者 */
bgbeowndp       varchar2(10)      ,/* 资料所有部门 */
bgbecrtid       varchar2(20)      ,/* 资料录入者 */
bgbecrtdp       varchar2(10)      ,/* 资料录入部门 */
bgbecrtdt       timestamp(0)      ,/* 资料创建日 */
bgbemodid       varchar2(20)      ,/* 资料更改者 */
bgbemoddt       timestamp(0)      ,/* 最近更改日 */
bgbecnfid       varchar2(20)      ,/* 资料审核者 */
bgbecnfdt       timestamp(0)      ,/* 数据审核日 */
bgbepstid       varchar2(20)      ,/* 资料过账者 */
bgbepstdt       timestamp(0)      ,/* 资料过账日 */
bgbestus       varchar2(10)      ,/* 状态码 */
bgbeud001       varchar2(40)      ,/* 自定义字段(文本)001 */
bgbeud002       varchar2(40)      ,/* 自定义字段(文本)002 */
bgbeud003       varchar2(40)      ,/* 自定义字段(文本)003 */
bgbeud004       varchar2(40)      ,/* 自定义字段(文本)004 */
bgbeud005       varchar2(40)      ,/* 自定义字段(文本)005 */
bgbeud006       varchar2(40)      ,/* 自定义字段(文本)006 */
bgbeud007       varchar2(40)      ,/* 自定义字段(文本)007 */
bgbeud008       varchar2(40)      ,/* 自定义字段(文本)008 */
bgbeud009       varchar2(40)      ,/* 自定义字段(文本)009 */
bgbeud010       varchar2(40)      ,/* 自定义字段(文本)010 */
bgbeud011       number(20,6)      ,/* 自定义字段(数字)011 */
bgbeud012       number(20,6)      ,/* 自定义字段(数字)012 */
bgbeud013       number(20,6)      ,/* 自定义字段(数字)013 */
bgbeud014       number(20,6)      ,/* 自定义字段(数字)014 */
bgbeud015       number(20,6)      ,/* 自定义字段(数字)015 */
bgbeud016       number(20,6)      ,/* 自定义字段(数字)016 */
bgbeud017       number(20,6)      ,/* 自定义字段(数字)017 */
bgbeud018       number(20,6)      ,/* 自定义字段(数字)018 */
bgbeud019       number(20,6)      ,/* 自定义字段(数字)019 */
bgbeud020       number(20,6)      ,/* 自定义字段(数字)020 */
bgbeud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
bgbeud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
bgbeud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
bgbeud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
bgbeud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
bgbeud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
bgbeud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
bgbeud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
bgbeud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
bgbeud030       timestamp(0)      /* 自定义字段(日期时间)030 */
);
alter table bgbe_t add constraint bgbe_pk primary key (bgbeent,bgbedocno) enable validate;

create unique index bgbe_pk on bgbe_t (bgbeent,bgbedocno);

grant select on bgbe_t to tiptop;
grant update on bgbe_t to tiptop;
grant delete on bgbe_t to tiptop;
grant insert on bgbe_t to tiptop;

exit;
