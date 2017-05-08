/* 
================================================================================
檔案代號:bggn_t
檔案名稱:人工预算明细
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table bggn_t
(
bggnent       number(5)      ,/* 企业编号 */
bggn001       varchar2(10)      ,/* 来源作业 */
bggn002       varchar2(10)      ,/* 预算编号 */
bggn003       varchar2(10)      ,/* 版本 */
bggn004       varchar2(10)      ,/* 人工来源 */
bggn005       varchar2(10)      ,/* 数据源 */
bggn006       varchar2(10)      ,/* 预算组织 */
bggn007       number(5,0)      ,/* 期别 */
bggnseq       number(10,0)      ,/* 项次 */
bggn008       varchar2(10)      ,/* 管理组织 */
bggn009       varchar2(10)      ,/* 预算样表 */
bggn010       varchar2(10)      ,/* 工资方案 */
bggn011       varchar2(10)      ,/* 职级 */
bggn012       varchar2(10)      ,/* 职等 */
bggn013       varchar2(10)      ,/* 用工属性 */
bggn014       varchar2(20)      ,/* 人员 */
bggn015       varchar2(10)      ,/* 部门 */
bggn016       varchar2(10)      ,/* 成本利润中心 */
bggn017       varchar2(10)      ,/* 区域 */
bggn018       varchar2(10)      ,/*   */
bggn019       varchar2(10)      ,/* 账款客商 */
bggn020       varchar2(10)      ,/* 客群 */
bggn021       varchar2(10)      ,/* 产品类别 */
bggn022       varchar2(20)      ,/* 项目编号 */
bggn023       varchar2(30)      ,/* WBS */
bggn024       varchar2(10)      ,/* 经营方式 */
bggn025       varchar2(10)      ,/* 渠道 */
bggn026       varchar2(10)      ,/* 品牌 */
bggn027       varchar2(30)      ,/* 自由核算项一 */
bggn028       varchar2(30)      ,/* 自由核算项二 */
bggn029       varchar2(30)      ,/* 自由核算项三 */
bggn030       varchar2(30)      ,/* 自由核算项四 */
bggn031       varchar2(30)      ,/* 自由核算项五 */
bggn032       varchar2(30)      ,/* 自由核算项六 */
bggn033       varchar2(30)      ,/* 自由核算项七 */
bggn034       varchar2(30)      ,/* 自由核算项八 */
bggn035       varchar2(30)      ,/* 自由核算项九 */
bggn036       varchar2(30)      ,/* 自由核算项十 */
bggn037       number(10,0)      ,/* 参考人数 */
bggn038       number(10,0)      ,/* 用工人数 */
bggnstus       varchar2(10)      ,/* 状态码 */
bggnud001       varchar2(40)      ,/* 自定义字段(文本)001 */
bggnud002       varchar2(40)      ,/* 自定义字段(文本)002 */
bggnud003       varchar2(40)      ,/* 自定义字段(文本)003 */
bggnud004       varchar2(40)      ,/* 自定义字段(文本)004 */
bggnud005       varchar2(40)      ,/* 自定义字段(文本)005 */
bggnud006       varchar2(40)      ,/* 自定义字段(文本)006 */
bggnud007       varchar2(40)      ,/* 自定义字段(文本)007 */
bggnud008       varchar2(40)      ,/* 自定义字段(文本)008 */
bggnud009       varchar2(40)      ,/* 自定义字段(文本)009 */
bggnud010       varchar2(40)      ,/* 自定义字段(文本)010 */
bggnud011       number(20,6)      ,/* 自定义字段(数字)011 */
bggnud012       number(20,6)      ,/* 自定义字段(数字)012 */
bggnud013       number(20,6)      ,/* 自定义字段(数字)013 */
bggnud014       number(20,6)      ,/* 自定义字段(数字)014 */
bggnud015       number(20,6)      ,/* 自定义字段(数字)015 */
bggnud016       number(20,6)      ,/* 自定义字段(数字)016 */
bggnud017       number(20,6)      ,/* 自定义字段(数字)017 */
bggnud018       number(20,6)      ,/* 自定义字段(数字)018 */
bggnud019       number(20,6)      ,/* 自定义字段(数字)019 */
bggnud020       number(20,6)      ,/* 自定义字段(数字)020 */
bggnud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
bggnud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
bggnud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
bggnud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
bggnud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
bggnud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
bggnud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
bggnud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
bggnud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
bggnud030       timestamp(0)      /* 自定义字段(日期时间)030 */
);
alter table bggn_t add constraint bggn_pk primary key (bggnent,bggn001,bggn002,bggn003,bggn004,bggn005,bggn006,bggn007,bggnseq) enable validate;

create unique index bggn_pk on bggn_t (bggnent,bggn001,bggn002,bggn003,bggn004,bggn005,bggn006,bggn007,bggnseq);

grant select on bggn_t to tiptop;
grant update on bggn_t to tiptop;
grant delete on bggn_t to tiptop;
grant insert on bggn_t to tiptop;

exit;
