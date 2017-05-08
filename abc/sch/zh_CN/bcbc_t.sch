/* 
================================================================================
檔案代號:bcbc_t
檔案名稱:条码自动编码最大流水号纪录档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table bcbc_t
(
bcbcent       number(5)      ,/* 企业代码 */
bcbc001       varchar2(10)      ,/* 编码规则编号 */
bcbc002       varchar2(255)      ,/* 流水号前编码 */
bcbc003       varchar2(255)      ,/* 流水号后编码 */
bcbc004       number(10,0)      ,/* 最大流水号 */
bcbcownid       varchar2(20)      ,/* 资料所有者 */
bcbcowndp       varchar2(10)      ,/* 资料所有部门 */
bcbccrtid       varchar2(20)      ,/* 资料录入者 */
bcbccrtdp       varchar2(10)      ,/* 资料录入部门 */
bcbccrtdt       timestamp(0)      ,/* 资料创建日 */
bcbcmodid       varchar2(20)      ,/* 资料更改者 */
bcbcmoddt       timestamp(0)      ,/* 最近更改日 */
bcbcstus       varchar2(10)      ,/* 状态码 */
bcbcud001       varchar2(40)      ,/* 自定义字段(文本)001 */
bcbcud002       varchar2(40)      ,/* 自定义字段(文本)002 */
bcbcud003       varchar2(40)      ,/* 自定义字段(文本)003 */
bcbcud004       varchar2(40)      ,/* 自定义字段(文本)004 */
bcbcud005       varchar2(40)      ,/* 自定义字段(文本)005 */
bcbcud006       varchar2(40)      ,/* 自定义字段(文本)006 */
bcbcud007       varchar2(40)      ,/* 自定义字段(文本)007 */
bcbcud008       varchar2(40)      ,/* 自定义字段(文本)008 */
bcbcud009       varchar2(40)      ,/* 自定义字段(文本)009 */
bcbcud010       varchar2(40)      ,/* 自定义字段(文本)010 */
bcbcud011       number(20,6)      ,/* 自定义字段(数字)011 */
bcbcud012       number(20,6)      ,/* 自定义字段(数字)012 */
bcbcud013       number(20,6)      ,/* 自定义字段(数字)013 */
bcbcud014       number(20,6)      ,/* 自定义字段(数字)014 */
bcbcud015       number(20,6)      ,/* 自定义字段(数字)015 */
bcbcud016       number(20,6)      ,/* 自定义字段(数字)016 */
bcbcud017       number(20,6)      ,/* 自定义字段(数字)017 */
bcbcud018       number(20,6)      ,/* 自定义字段(数字)018 */
bcbcud019       number(20,6)      ,/* 自定义字段(数字)019 */
bcbcud020       number(20,6)      ,/* 自定义字段(数字)020 */
bcbcud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
bcbcud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
bcbcud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
bcbcud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
bcbcud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
bcbcud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
bcbcud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
bcbcud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
bcbcud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
bcbcud030       timestamp(0)      /* 自定义字段(日期时间)030 */
);
alter table bcbc_t add constraint bcbc_pk primary key (bcbcent,bcbc001,bcbc002,bcbc003) enable validate;

create unique index bcbc_pk on bcbc_t (bcbcent,bcbc001,bcbc002,bcbc003);

grant select on bcbc_t to tiptop;
grant update on bcbc_t to tiptop;
grant delete on bcbc_t to tiptop;
grant insert on bcbc_t to tiptop;

exit;
