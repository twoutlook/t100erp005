/* 
================================================================================
檔案代號:bggg_t
檔案名稱:用工需求明细档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table bggg_t
(
bgggent       number(5)      ,/* 企业编号 */
bggg001       varchar2(10)      ,/* 预算编号 */
bggg002       varchar2(10)      ,/* 预算组织 */
bggg003       varchar2(10)      ,/* 职级 */
bggg004       varchar2(10)      ,/* 职等 */
bggg005       varchar2(10)      ,/* 用工属性 */
bggg007       varchar2(10)      ,/* 部门 */
bggg008       varchar2(10)      ,/* 成本利润中心 */
bggg009       varchar2(10)      ,/* 区域 */
bggg010       varchar2(10)      ,/* 收付款客商 */
bggg011       varchar2(10)      ,/* 收款客商 */
bggg012       varchar2(10)      ,/* 客群 */
bggg013       varchar2(10)      ,/* 产品类别 */
bggg014       varchar2(20)      ,/* 人员 */
bggg015       varchar2(20)      ,/* 项目编号 */
bggg016       varchar2(30)      ,/* WBS */
bggg017       number(15,3)      ,/* 经营方式(NO USE) */
bggg018       number(15,3)      ,/* 渠道(NO USE) */
bggg019       varchar2(10)      ,/* 品牌 */
bggg020       number(10,0)      ,/* 用工人数 */
bggg021       varchar2(30)      ,/* 自由核算项一 */
bggg022       varchar2(30)      ,/* 自由核算项二 */
bggg023       varchar2(30)      ,/* 自由核算项三 */
bggg024       varchar2(30)      ,/* 自由核算项四 */
bggg025       varchar2(30)      ,/* 自由核算项五 */
bggg026       varchar2(30)      ,/* 自由核算项六 */
bggg027       varchar2(30)      ,/* 自由核算项七 */
bggg028       varchar2(30)      ,/* 自由核算项八 */
bggg029       varchar2(30)      ,/* 自由核算项九 */
bggg030       varchar2(30)      ,/* 自由核算项十 */
bggg031       varchar2(10)      ,/* 起始期别 */
bgggseq       number(10,0)      ,/* 项次 */
bgggseq1       number(10,0)      ,/* 项序 */
bgggud001       varchar2(40)      ,/* 自定义字段(文本)001 */
bgggud002       varchar2(40)      ,/* 自定义字段(文本)002 */
bgggud003       varchar2(40)      ,/* 自定义字段(文本)003 */
bgggud004       varchar2(40)      ,/* 自定义字段(文本)004 */
bgggud005       varchar2(40)      ,/* 自定义字段(文本)005 */
bgggud006       varchar2(40)      ,/* 自定义字段(文本)006 */
bgggud007       varchar2(40)      ,/* 自定义字段(文本)007 */
bgggud008       varchar2(40)      ,/* 自定义字段(文本)008 */
bgggud009       varchar2(40)      ,/* 自定义字段(文本)009 */
bgggud010       varchar2(40)      ,/* 自定义字段(文本)010 */
bgggud011       number(20,6)      ,/* 自定义字段(数字)011 */
bgggud012       number(20,6)      ,/* 自定义字段(数字)012 */
bgggud013       number(20,6)      ,/* 自定义字段(数字)013 */
bgggud014       number(20,6)      ,/* 自定义字段(数字)014 */
bgggud015       number(20,6)      ,/* 自定义字段(数字)015 */
bgggud016       number(20,6)      ,/* 自定义字段(数字)016 */
bgggud017       number(20,6)      ,/* 自定义字段(数字)017 */
bgggud018       number(20,6)      ,/* 自定义字段(数字)018 */
bgggud019       number(20,6)      ,/* 自定义字段(数字)019 */
bgggud020       number(20,6)      ,/* 自定义字段(数字)020 */
bgggud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
bgggud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
bgggud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
bgggud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
bgggud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
bgggud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
bgggud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
bgggud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
bgggud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
bgggud030       timestamp(0)      ,/* 自定义字段(日期时间)030 */
bggg032       number(5,0)      ,/* 终止期别 */
bggg033       varchar2(10)      ,/* 经营方式 */
bggg034       varchar2(10)      /* 渠道 */
);
alter table bggg_t add constraint bggg_pk primary key (bgggent,bggg001,bggg002,bggg031,bgggseq,bgggseq1,bggg032) enable validate;

create unique index bggg_pk on bggg_t (bgggent,bggg001,bggg002,bggg031,bgggseq,bgggseq1,bggg032);

grant select on bggg_t to tiptop;
grant update on bggg_t to tiptop;
grant delete on bggg_t to tiptop;
grant insert on bggg_t to tiptop;

exit;
