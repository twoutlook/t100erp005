/* 
================================================================================
檔案代號:bgao_t
檔案名稱:项目科目对应档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table bgao_t
(
bgaoent       number(5)      ,/* 企业编号 */
bgao001       varchar2(5)      ,/* 预算细项参照表号 */
bgao002       varchar2(5)      ,/* 会计科目参照表编号 */
bgao003       varchar2(24)      ,/* 会计科目编号 */
bgao004       varchar2(24)      ,/* 预算细项编号 */
bgaostus       varchar2(10)      ,/* 状态码 */
bgaocrtid       varchar2(20)      ,/* 资料录入者 */
bgaocrtdt       timestamp(0)      ,/* 资料创建日 */
bgaomodid       varchar2(20)      ,/* 资料更改者 */
bgaomoddt       timestamp(0)      ,/* 最近更改日 */
bgaoownid       varchar2(20)      ,/* 资料所有者 */
bgaoowndp       varchar2(10)      ,/* 资料所有部门 */
bgaocrtdp       varchar2(10)      ,/* 资料录入部门 */
bgaoud001       varchar2(40)      ,/* 自定义字段(文本)001 */
bgaoud002       varchar2(40)      ,/* 自定义字段(文本)002 */
bgaoud003       varchar2(40)      ,/* 自定义字段(文本)003 */
bgaoud004       varchar2(40)      ,/* 自定义字段(文本)004 */
bgaoud005       varchar2(40)      ,/* 自定义字段(文本)005 */
bgaoud006       varchar2(40)      ,/* 自定义字段(文本)006 */
bgaoud007       varchar2(40)      ,/* 自定义字段(文本)007 */
bgaoud008       varchar2(40)      ,/* 自定义字段(文本)008 */
bgaoud009       varchar2(40)      ,/* 自定义字段(文本)009 */
bgaoud010       varchar2(40)      ,/* 自定义字段(文本)010 */
bgaoud011       number(20,6)      ,/* 自定义字段(数字)011 */
bgaoud012       number(20,6)      ,/* 自定义字段(数字)012 */
bgaoud013       number(20,6)      ,/* 自定义字段(数字)013 */
bgaoud014       number(20,6)      ,/* 自定义字段(数字)014 */
bgaoud015       number(20,6)      ,/* 自定义字段(数字)015 */
bgaoud016       number(20,6)      ,/* 自定义字段(数字)016 */
bgaoud017       number(20,6)      ,/* 自定义字段(数字)017 */
bgaoud018       number(20,6)      ,/* 自定义字段(数字)018 */
bgaoud019       number(20,6)      ,/* 自定义字段(数字)019 */
bgaoud020       number(20,6)      ,/* 自定义字段(数字)020 */
bgaoud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
bgaoud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
bgaoud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
bgaoud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
bgaoud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
bgaoud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
bgaoud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
bgaoud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
bgaoud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
bgaoud030       timestamp(0)      ,/* 自定义字段(日期时间)030 */
bgao006       number(5,0)      /* 参照表号类型 */
);
alter table bgao_t add constraint bgao_pk primary key (bgaoent,bgao001,bgao002,bgao003) enable validate;

create unique index bgao_pk on bgao_t (bgaoent,bgao001,bgao002,bgao003);

grant select on bgao_t to tiptop;
grant update on bgao_t to tiptop;
grant delete on bgao_t to tiptop;
grant insert on bgao_t to tiptop;

exit;
