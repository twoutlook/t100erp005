/* 
================================================================================
檔案代號:bgda_t
檔案名稱:预算产品结构主档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table bgda_t
(
bgdaent       number(5)      ,/* 企业编号 */
bgdaownid       varchar2(20)      ,/* 资料所有者 */
bgdaowndp       varchar2(10)      ,/* 资料所有部门 */
bgdacrtid       varchar2(20)      ,/* 资料录入者 */
bgdacrtdp       varchar2(10)      ,/* 资料录入部门 */
bgdacrtdt       timestamp(0)      ,/* 资料创建日 */
bgdamodid       varchar2(20)      ,/* 资料更改者 */
bgdamoddt       timestamp(0)      ,/* 最近更改日 */
bgdacnfid       varchar2(20)      ,/* 资料审核者 */
bgdacnfdt       timestamp(0)      ,/* 数据审核日 */
bgdastus       varchar2(10)      ,/* 状态码 */
bgda001       varchar2(10)      ,/* 预算组织 */
bgda002       varchar2(40)      ,/* 预算主件料号 */
bgda003       date      ,/* 生效日期 */
bgda004       varchar2(10)      ,/* 主件生产单位 */
bgda005       date      ,/* 失效日期 */
bgda006       varchar2(40)      ,/* 参考主件 */
bgda007       varchar2(10)      ,/* 参考据点 */
bgda008       varchar2(10)      ,/* 参考来源 */
bgda009       varchar2(10)      ,/* 参考预算编号 */
bgdaud001       varchar2(40)      ,/* 自定义字段(文本)001 */
bgdaud002       varchar2(40)      ,/* 自定义字段(文本)002 */
bgdaud003       varchar2(40)      ,/* 自定义字段(文本)003 */
bgdaud004       varchar2(40)      ,/* 自定义字段(文本)004 */
bgdaud005       varchar2(40)      ,/* 自定义字段(文本)005 */
bgdaud006       varchar2(40)      ,/* 自定义字段(文本)006 */
bgdaud007       varchar2(40)      ,/* 自定义字段(文本)007 */
bgdaud008       varchar2(40)      ,/* 自定义字段(文本)008 */
bgdaud009       varchar2(40)      ,/* 自定义字段(文本)009 */
bgdaud010       varchar2(40)      ,/* 自定义字段(文本)010 */
bgdaud011       number(20,6)      ,/* 自定义字段(数字)011 */
bgdaud012       number(20,6)      ,/* 自定义字段(数字)012 */
bgdaud013       number(20,6)      ,/* 自定义字段(数字)013 */
bgdaud014       number(20,6)      ,/* 自定义字段(数字)014 */
bgdaud015       number(20,6)      ,/* 自定义字段(数字)015 */
bgdaud016       number(20,6)      ,/* 自定义字段(数字)016 */
bgdaud017       number(20,6)      ,/* 自定义字段(数字)017 */
bgdaud018       number(20,6)      ,/* 自定义字段(数字)018 */
bgdaud019       number(20,6)      ,/* 自定义字段(数字)019 */
bgdaud020       number(20,6)      ,/* 自定义字段(数字)020 */
bgdaud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
bgdaud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
bgdaud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
bgdaud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
bgdaud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
bgdaud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
bgdaud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
bgdaud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
bgdaud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
bgdaud030       timestamp(0)      /* 自定义字段(日期时间)030 */
);
alter table bgda_t add constraint bgda_pk primary key (bgdaent,bgda001,bgda002,bgda003) enable validate;

create unique index bgda_pk on bgda_t (bgdaent,bgda001,bgda002,bgda003);

grant select on bgda_t to tiptop;
grant update on bgda_t to tiptop;
grant delete on bgda_t to tiptop;
grant insert on bgda_t to tiptop;

exit;
