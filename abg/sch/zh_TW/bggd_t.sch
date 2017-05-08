/* 
================================================================================
檔案代號:bggd_t
檔案名稱:标准工资基本档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table bggd_t
(
bggdent       number(5)      ,/* 企业编号 */
bggd001       varchar2(10)      ,/* 预算编号 */
bggd002       varchar2(10)      ,/* 预算组织 */
bggd003       varchar2(10)      ,/* 工资方案 */
bggd004       varchar2(10)      ,/* 工资项目 */
bggd005       varchar2(10)      ,/* 用工属性 */
bggd006       varchar2(10)      ,/* 支付周期 */
bggd007       varchar2(10)      ,/* 职级 */
bggd008       varchar2(10)      ,/* 职等 */
bggd009       varchar2(10)      ,/* 支付币种 */
bggd010       number(20,6)      ,/* 标准工资 */
bggdownid       varchar2(20)      ,/* 资料所有者 */
bggdowndp       varchar2(10)      ,/* 资料所有部门 */
bggdcrtid       varchar2(20)      ,/* 资料录入者 */
bggdcrtdp       varchar2(10)      ,/* 资料录入部门 */
bggdcrtdt       timestamp(0)      ,/* 资料创建日 */
bggdmodid       varchar2(20)      ,/* 资料更改者 */
bggdmoddt       timestamp(0)      ,/* 最近更改日 */
bggdstus       varchar2(10)      ,/* 状态码 */
bggdud001       varchar2(40)      ,/* 自定义字段(文本)001 */
bggdud002       varchar2(40)      ,/* 自定义字段(文本)002 */
bggdud003       varchar2(40)      ,/* 自定义字段(文本)003 */
bggdud004       varchar2(40)      ,/* 自定义字段(文本)004 */
bggdud005       varchar2(40)      ,/* 自定义字段(文本)005 */
bggdud006       varchar2(40)      ,/* 自定义字段(文本)006 */
bggdud007       varchar2(40)      ,/* 自定义字段(文本)007 */
bggdud008       varchar2(40)      ,/* 自定义字段(文本)008 */
bggdud009       varchar2(40)      ,/* 自定义字段(文本)009 */
bggdud010       varchar2(40)      ,/* 自定义字段(文本)010 */
bggdud011       number(20,6)      ,/* 自定义字段(数字)011 */
bggdud012       number(20,6)      ,/* 自定义字段(数字)012 */
bggdud013       number(20,6)      ,/* 自定义字段(数字)013 */
bggdud014       number(20,6)      ,/* 自定义字段(数字)014 */
bggdud015       number(20,6)      ,/* 自定义字段(数字)015 */
bggdud016       number(20,6)      ,/* 自定义字段(数字)016 */
bggdud017       number(20,6)      ,/* 自定义字段(数字)017 */
bggdud018       number(20,6)      ,/* 自定义字段(数字)018 */
bggdud019       number(20,6)      ,/* 自定义字段(数字)019 */
bggdud020       number(20,6)      ,/* 自定义字段(数字)020 */
bggdud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
bggdud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
bggdud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
bggdud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
bggdud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
bggdud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
bggdud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
bggdud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
bggdud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
bggdud030       timestamp(0)      /* 自定义字段(日期时间)030 */
);
alter table bggd_t add constraint bggd_pk primary key (bggdent,bggd001,bggd002,bggd003,bggd004,bggd005,bggd007,bggd008) enable validate;

create unique index bggd_pk on bggd_t (bggdent,bggd001,bggd002,bggd003,bggd004,bggd005,bggd007,bggd008);

grant select on bggd_t to tiptop;
grant update on bggd_t to tiptop;
grant delete on bggd_t to tiptop;
grant insert on bggd_t to tiptop;

exit;
