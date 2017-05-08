/* 
================================================================================
檔案代號:bgal_t
檔案名稱:预算项目维护档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table bgal_t
(
bgalent       number(5)      ,/* 企业编号 */
bgalownid       varchar2(20)      ,/* 资料所有者 */
bgalowndp       varchar2(10)      ,/* 资料所有部门 */
bgalcrtid       varchar2(20)      ,/* 资料录入者 */
bgalcrtdp       varchar2(10)      ,/* 资料录入部门 */
bgalcrtdt       timestamp(0)      ,/* 资料创建日 */
bgalmodid       varchar2(20)      ,/* 资料更改者 */
bgalmoddt       timestamp(0)      ,/* 最近更改日 */
bgalstus       varchar2(10)      ,/* 状态码 */
bgal001       varchar2(10)      ,/* 预算编号 */
bgal002       varchar2(10)      ,/* 预算组织 */
bgal003       varchar2(24)      ,/* 可用预算细项 */
bgal004       varchar2(1)      ,/* 预算期别 */
bgal005       varchar2(1)      ,/* 部门 */
bgal006       varchar2(1)      ,/* 利润/成本中心 */
bgal007       varchar2(1)      ,/* 区域 */
bgal008       varchar2(1)      ,/* 交易客商 */
bgal009       varchar2(1)      ,/* 收款客商 */
bgal010       varchar2(1)      ,/* 客群 */
bgal011       varchar2(1)      ,/* 产品类别 */
bgal012       varchar2(1)      ,/* 人员 */
bgal013       varchar2(1)      ,/* 项目编号 */
bgal014       varchar2(1)      ,/* WBS */
bgal015       varchar2(1)      ,/* 自由核算项一 */
bgal016       varchar2(1)      ,/* 自由核算项二 */
bgal017       varchar2(1)      ,/* 自由核算项三 */
bgal018       varchar2(1)      ,/* 自由核算项四 */
bgal019       varchar2(1)      ,/* 自由核算项五 */
bgal020       varchar2(1)      ,/* 自由核算项六 */
bgal021       varchar2(1)      ,/* 自由核算项七 */
bgal022       varchar2(1)      ,/* 自由核算项八 */
bgal023       varchar2(1)      ,/* 自由核算项九 */
bgal024       varchar2(1)      ,/* 自由核算项十 */
bgalud001       varchar2(40)      ,/* 自定义字段(文本)001 */
bgalud002       varchar2(40)      ,/* 自定义字段(文本)002 */
bgalud003       varchar2(40)      ,/* 自定义字段(文本)003 */
bgalud004       varchar2(40)      ,/* 自定义字段(文本)004 */
bgalud005       varchar2(40)      ,/* 自定义字段(文本)005 */
bgalud006       varchar2(40)      ,/* 自定义字段(文本)006 */
bgalud007       varchar2(40)      ,/* 自定义字段(文本)007 */
bgalud008       varchar2(40)      ,/* 自定义字段(文本)008 */
bgalud009       varchar2(40)      ,/* 自定义字段(文本)009 */
bgalud010       varchar2(40)      ,/* 自定义字段(文本)010 */
bgalud011       number(20,6)      ,/* 自定义字段(数字)011 */
bgalud012       number(20,6)      ,/* 自定义字段(数字)012 */
bgalud013       number(20,6)      ,/* 自定义字段(数字)013 */
bgalud014       number(20,6)      ,/* 自定义字段(数字)014 */
bgalud015       number(20,6)      ,/* 自定义字段(数字)015 */
bgalud016       number(20,6)      ,/* 自定义字段(数字)016 */
bgalud017       number(20,6)      ,/* 自定义字段(数字)017 */
bgalud018       number(20,6)      ,/* 自定义字段(数字)018 */
bgalud019       number(20,6)      ,/* 自定义字段(数字)019 */
bgalud020       number(20,6)      ,/* 自定义字段(数字)020 */
bgalud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
bgalud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
bgalud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
bgalud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
bgalud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
bgalud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
bgalud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
bgalud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
bgalud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
bgalud030       timestamp(0)      ,/* 自定义字段(日期时间)030 */
bgal025       varchar2(1)      ,/* 经营方式 */
bgal026       varchar2(1)      ,/* 渠道 */
bgal027       varchar2(1)      /* 品牌 */
);
alter table bgal_t add constraint bgal_pk primary key (bgalent,bgal001,bgal002,bgal003) enable validate;

create unique index bgal_pk on bgal_t (bgalent,bgal001,bgal002,bgal003);

grant select on bgal_t to tiptop;
grant update on bgal_t to tiptop;
grant delete on bgal_t to tiptop;
grant insert on bgal_t to tiptop;

exit;
