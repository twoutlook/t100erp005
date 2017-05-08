/* 
================================================================================
檔案代號:bggb_t
檔案名稱:工资方案数据档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table bggb_t
(
bggbent       number(5)      ,/* 企业编号 */
bggb001       varchar2(10)      ,/* 工资方案 */
bggb002       varchar2(10)      ,/* 工资项目 */
bggb003       varchar2(10)      ,/* 工资来源 */
bggb004       varchar2(256)      ,/* 计算公式 */
bggbstus       varchar2(10)      ,/* 状态码 */
bggbownid       varchar2(20)      ,/* 资料所有者 */
bggbowndp       varchar2(10)      ,/* 资料所有部门 */
bggbcrtid       varchar2(20)      ,/* 资料录入者 */
bggbcrtdp       varchar2(10)      ,/* 资料录入部门 */
bggbcrtdt       timestamp(0)      ,/* 资料创建日 */
bggbmodid       varchar2(20)      ,/* 资料更改者 */
bggbmoddt       timestamp(0)      ,/* 最近更改日 */
bggbud001       varchar2(40)      ,/* 自定义字段(文本)001 */
bggbud002       varchar2(40)      ,/* 自定义字段(文本)002 */
bggbud003       varchar2(40)      ,/* 自定义字段(文本)003 */
bggbud004       varchar2(40)      ,/* 自定义字段(文本)004 */
bggbud005       varchar2(40)      ,/* 自定义字段(文本)005 */
bggbud006       varchar2(40)      ,/* 自定义字段(文本)006 */
bggbud007       varchar2(40)      ,/* 自定义字段(文本)007 */
bggbud008       varchar2(40)      ,/* 自定义字段(文本)008 */
bggbud009       varchar2(40)      ,/* 自定义字段(文本)009 */
bggbud010       varchar2(40)      ,/* 自定义字段(文本)010 */
bggbud011       number(20,6)      ,/* 自定义字段(数字)011 */
bggbud012       number(20,6)      ,/* 自定义字段(数字)012 */
bggbud013       number(20,6)      ,/* 自定义字段(数字)013 */
bggbud014       number(20,6)      ,/* 自定义字段(数字)014 */
bggbud015       number(20,6)      ,/* 自定义字段(数字)015 */
bggbud016       number(20,6)      ,/* 自定义字段(数字)016 */
bggbud017       number(20,6)      ,/* 自定义字段(数字)017 */
bggbud018       number(20,6)      ,/* 自定义字段(数字)018 */
bggbud019       number(20,6)      ,/* 自定义字段(数字)019 */
bggbud020       number(20,6)      ,/* 自定义字段(数字)020 */
bggbud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
bggbud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
bggbud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
bggbud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
bggbud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
bggbud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
bggbud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
bggbud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
bggbud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
bggbud030       timestamp(0)      ,/* 自定义字段(日期时间)030 */
bggbseq       number(10,0)      /* 序号 */
);
alter table bggb_t add constraint bggb_pk primary key (bggbent,bggb001,bggb002) enable validate;

create unique index bggb_pk on bggb_t (bggbent,bggb001,bggb002);

grant select on bggb_t to tiptop;
grant update on bggb_t to tiptop;
grant delete on bggb_t to tiptop;
grant insert on bggb_t to tiptop;

exit;
