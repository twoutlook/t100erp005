/* 
================================================================================
檔案代號:bgcb_t
檔案名稱:销售仿真因子组织影响力设置档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table bgcb_t
(
bgcbent       number(5)      ,/* 企业编号 */
bgcb001       varchar2(10)      ,/* 预算编号 */
bgcb002       varchar2(10)      ,/* 预算组织 */
bgcb003       varchar2(10)      ,/* 产品分类码 */
bgcb004       varchar2(10)      ,/* 影响因子编号 */
bgcb005       number(5,0)      ,/* 预算期别 */
bgcb006       number(20,6)      ,/* 影响程度 */
bgcb007       number(20,6)      ,/* 影响数量 */
bgcbstus       varchar2(10)      ,/* 状态码 */
bgcbownid       varchar2(20)      ,/* 资料所有者 */
bgcbowndp       varchar2(10)      ,/* 资料所有部门 */
bgcbcrtid       varchar2(20)      ,/* 资料录入者 */
bgcbcrtdp       varchar2(10)      ,/* 资料录入部门 */
bgcbcrtdt       timestamp(0)      ,/* 资料创建日 */
bgcbmodid       varchar2(20)      ,/* 资料更改者 */
bgcbmoddt       timestamp(0)      ,/* 最近更改日 */
bgcbud001       varchar2(40)      ,/* 自定义字段(文本)001 */
bgcbud002       varchar2(40)      ,/* 自定义字段(文本)002 */
bgcbud003       varchar2(40)      ,/* 自定义字段(文本)003 */
bgcbud004       varchar2(40)      ,/* 自定义字段(文本)004 */
bgcbud005       varchar2(40)      ,/* 自定义字段(文本)005 */
bgcbud006       varchar2(40)      ,/* 自定义字段(文本)006 */
bgcbud007       varchar2(40)      ,/* 自定义字段(文本)007 */
bgcbud008       varchar2(40)      ,/* 自定义字段(文本)008 */
bgcbud009       varchar2(40)      ,/* 自定义字段(文本)009 */
bgcbud010       varchar2(40)      ,/* 自定义字段(文本)010 */
bgcbud011       number(20,6)      ,/* 自定义字段(数字)011 */
bgcbud012       number(20,6)      ,/* 自定义字段(数字)012 */
bgcbud013       number(20,6)      ,/* 自定义字段(数字)013 */
bgcbud014       number(20,6)      ,/* 自定义字段(数字)014 */
bgcbud015       number(20,6)      ,/* 自定义字段(数字)015 */
bgcbud016       number(20,6)      ,/* 自定义字段(数字)016 */
bgcbud017       number(20,6)      ,/* 自定义字段(数字)017 */
bgcbud018       number(20,6)      ,/* 自定义字段(数字)018 */
bgcbud019       number(20,6)      ,/* 自定义字段(数字)019 */
bgcbud020       number(20,6)      ,/* 自定义字段(数字)020 */
bgcbud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
bgcbud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
bgcbud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
bgcbud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
bgcbud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
bgcbud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
bgcbud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
bgcbud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
bgcbud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
bgcbud030       timestamp(0)      ,/* 自定义字段(日期时间)030 */
bgcb008       varchar2(40)      ,/* 预算料件 */
bgcb009       varchar2(10)      ,/* 影响类型 */
bgcb010       varchar2(1)      /* 影响模块 */
);
alter table bgcb_t add constraint bgcb_pk primary key (bgcbent,bgcb001,bgcb002,bgcb003,bgcb004,bgcb005,bgcb009,bgcb010) enable validate;

create unique index bgcb_pk on bgcb_t (bgcbent,bgcb001,bgcb002,bgcb003,bgcb004,bgcb005,bgcb009,bgcb010);

grant select on bgcb_t to tiptop;
grant update on bgcb_t to tiptop;
grant delete on bgcb_t to tiptop;
grant insert on bgcb_t to tiptop;

exit;
