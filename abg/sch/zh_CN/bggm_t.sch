/* 
================================================================================
檔案代號:bggm_t
檔案名稱:人工预算主档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table bggm_t
(
bggment       number(5)      ,/* 企业编号 */
bggm001       varchar2(10)      ,/* 来源作业 */
bggm002       varchar2(10)      ,/* 预算编号 */
bggm003       varchar2(10)      ,/* 版本 */
bggm004       varchar2(10)      ,/* 人工来源 */
bggm005       varchar2(10)      ,/* 数据源 */
bggm006       varchar2(10)      ,/* 预算组织 */
bggm007       number(5,0)      ,/* 期别 */
bggm008       varchar2(10)      ,/* 管理组织 */
bggm009       varchar2(10)      ,/* 预算样表 */
bggm010       varchar2(20)      ,/* 凭单单号 */
bggmstus       varchar2(10)      ,/* 状态码 */
bggmownid       varchar2(20)      ,/* 资料所有者 */
bggmowndp       varchar2(10)      ,/* 资料所有部门 */
bggmcrtid       varchar2(20)      ,/* 资料录入者 */
bggmcrtdp       varchar2(10)      ,/* 资料录入部门 */
bggmcrtdt       timestamp(0)      ,/* 资料创建日 */
bggmmodid       varchar2(20)      ,/* 资料更改者 */
bggmmoddt       timestamp(0)      ,/* 最近更改日 */
bggmcnfid       varchar2(20)      ,/* 资料审核者 */
bggmcnfdt       timestamp(0)      ,/* 数据审核日 */
bggmud001       varchar2(40)      ,/* 自定义字段(文本)001 */
bggmud002       varchar2(40)      ,/* 自定义字段(文本)002 */
bggmud003       varchar2(40)      ,/* 自定义字段(文本)003 */
bggmud004       varchar2(40)      ,/* 自定义字段(文本)004 */
bggmud005       varchar2(40)      ,/* 自定义字段(文本)005 */
bggmud006       varchar2(40)      ,/* 自定义字段(文本)006 */
bggmud007       varchar2(40)      ,/* 自定义字段(文本)007 */
bggmud008       varchar2(40)      ,/* 自定义字段(文本)008 */
bggmud009       varchar2(40)      ,/* 自定义字段(文本)009 */
bggmud010       varchar2(40)      ,/* 自定义字段(文本)010 */
bggmud011       number(20,6)      ,/* 自定义字段(数字)011 */
bggmud012       number(20,6)      ,/* 自定义字段(数字)012 */
bggmud013       number(20,6)      ,/* 自定义字段(数字)013 */
bggmud014       number(20,6)      ,/* 自定义字段(数字)014 */
bggmud015       number(20,6)      ,/* 自定义字段(数字)015 */
bggmud016       number(20,6)      ,/* 自定义字段(数字)016 */
bggmud017       number(20,6)      ,/* 自定义字段(数字)017 */
bggmud018       number(20,6)      ,/* 自定义字段(数字)018 */
bggmud019       number(20,6)      ,/* 自定义字段(数字)019 */
bggmud020       number(20,6)      ,/* 自定义字段(数字)020 */
bggmud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
bggmud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
bggmud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
bggmud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
bggmud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
bggmud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
bggmud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
bggmud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
bggmud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
bggmud030       timestamp(0)      /* 自定义字段(日期时间)030 */
);
alter table bggm_t add constraint bggm_pk primary key (bggment,bggm001,bggm002,bggm003,bggm004,bggm005,bggm006,bggm007) enable validate;

create unique index bggm_pk on bggm_t (bggment,bggm001,bggm002,bggm003,bggm004,bggm005,bggm006,bggm007);

grant select on bggm_t to tiptop;
grant update on bggm_t to tiptop;
grant delete on bggm_t to tiptop;
grant insert on bggm_t to tiptop;

exit;
