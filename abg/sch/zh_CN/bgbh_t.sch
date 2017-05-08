/* 
================================================================================
檔案代號:bgbh_t
檔案名稱:年度预算单头档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table bgbh_t
(
bgbhent       number(5)      ,/* 企业编号 */
bgbhownid       varchar2(20)      ,/* 资料所有者 */
bgbhowndp       varchar2(10)      ,/* 资料所有部门 */
bgbhcrtid       varchar2(20)      ,/* 资料录入者 */
bgbhcrtdp       varchar2(10)      ,/* 资料录入部门 */
bgbhcrtdt       timestamp(0)      ,/* 资料创建日 */
bgbhmodid       varchar2(20)      ,/* 资料更改者 */
bgbhmoddt       timestamp(0)      ,/* 最近更改日 */
bgbhcnfid       varchar2(20)      ,/* 资料审核者 */
bgbhcnfdt       timestamp(0)      ,/* 数据审核日 */
bgbhstus       varchar2(10)      ,/* 状态码 */
bgbh001       varchar2(10)      ,/* 预算编号 */
bgbh002       varchar2(10)      ,/* 预算版本 */
bgbh003       varchar2(10)      ,/* 预算组织 */
bgbh004       varchar2(24)      ,/* 预算细项 */
bgbh005       varchar2(10)      ,/* 预算币种 */
bgbh006       varchar2(1)      ,/* 数据源 */
bgbh007       varchar2(10)      ,/* 预算样表 */
bgbhud001       varchar2(40)      ,/* 自定义字段(文本)001 */
bgbhud002       varchar2(40)      ,/* 自定义字段(文本)002 */
bgbhud003       varchar2(40)      ,/* 自定义字段(文本)003 */
bgbhud004       varchar2(40)      ,/* 自定义字段(文本)004 */
bgbhud005       varchar2(40)      ,/* 自定义字段(文本)005 */
bgbhud006       varchar2(40)      ,/* 自定义字段(文本)006 */
bgbhud007       varchar2(40)      ,/* 自定义字段(文本)007 */
bgbhud008       varchar2(40)      ,/* 自定义字段(文本)008 */
bgbhud009       varchar2(40)      ,/* 自定义字段(文本)009 */
bgbhud010       varchar2(40)      ,/* 自定义字段(文本)010 */
bgbhud011       number(20,6)      ,/* 自定义字段(数字)011 */
bgbhud012       number(20,6)      ,/* 自定义字段(数字)012 */
bgbhud013       number(20,6)      ,/* 自定义字段(数字)013 */
bgbhud014       number(20,6)      ,/* 自定义字段(数字)014 */
bgbhud015       number(20,6)      ,/* 自定义字段(数字)015 */
bgbhud016       number(20,6)      ,/* 自定义字段(数字)016 */
bgbhud017       number(20,6)      ,/* 自定义字段(数字)017 */
bgbhud018       number(20,6)      ,/* 自定义字段(数字)018 */
bgbhud019       number(20,6)      ,/* 自定义字段(数字)019 */
bgbhud020       number(20,6)      ,/* 自定义字段(数字)020 */
bgbhud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
bgbhud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
bgbhud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
bgbhud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
bgbhud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
bgbhud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
bgbhud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
bgbhud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
bgbhud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
bgbhud030       timestamp(0)      /* 自定义字段(日期时间)030 */
);
alter table bgbh_t add constraint bgbh_pk primary key (bgbhent,bgbh001,bgbh002,bgbh003,bgbh004,bgbh006) enable validate;

create unique index bgbh_pk on bgbh_t (bgbhent,bgbh001,bgbh002,bgbh003,bgbh004,bgbh006);

grant select on bgbh_t to tiptop;
grant update on bgbh_t to tiptop;
grant delete on bgbh_t to tiptop;
grant insert on bgbh_t to tiptop;

exit;
