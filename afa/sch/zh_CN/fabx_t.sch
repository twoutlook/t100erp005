/* 
================================================================================
檔案代號:fabx_t
檔案名稱:调拨单头档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table fabx_t
(
fabxent       number(5)      ,/* 企业代码 */
fabxownid       varchar2(20)      ,/* 资料所有者 */
fabxowndp       varchar2(10)      ,/* 资料所有部门 */
fabxcrtid       varchar2(20)      ,/* 资料录入者 */
fabxcrtdp       varchar2(10)      ,/* 资料录入部门 */
fabxcrtdt       timestamp(0)      ,/* 资料创建日 */
fabxmodid       varchar2(20)      ,/* 资料更改者 */
fabxmoddt       timestamp(0)      ,/* 最近更改日 */
fabxcnfid       varchar2(20)      ,/* 资料审核者 */
fabxcnfdt       timestamp(0)      ,/* 数据审核日 */
fabxpstid       varchar2(20)      ,/* 资料过账者 */
fabxpstdt       timestamp(0)      ,/* 资料过账日 */
fabxstus       varchar2(10)      ,/* 状态码 */
fabxdocno       varchar2(20)      ,/* 单号 */
fabxdocdt       date      ,/* 单据日期 */
fabxsite       varchar2(10)      ,/* 资产中心 */
fabxcomp       varchar2(10)      ,/* 法人 */
fabx001       number(10)      ,/* 单据性质 */
fabx002       varchar2(20)      ,/* 账务人员 */
fabx003       varchar2(10)      ,/* 拨出所有组织 */
fabx004       varchar2(10)      ,/* 拨出核算组织 */
fabx005       varchar2(10)      ,/* 拨出管理组织 */
fabx006       varchar2(10)      ,/* 拨入所有组织 */
fabx007       varchar2(10)      ,/* 拨入核算组织 */
fabx008       varchar2(10)      ,/* 拨入管理组织 */
fabx009       varchar2(1)      ,/* 在途 */
fabx010       varchar2(10)      ,/* 调拨流水号 */
fabx011       varchar2(20)      ,/* 账务单号 */
fabx012       date      ,/* 账务日期 */
fabxud001       varchar2(40)      ,/* 自定义字段(文本)001 */
fabxud002       varchar2(40)      ,/* 自定义字段(文本)002 */
fabxud003       varchar2(40)      ,/* 自定义字段(文本)003 */
fabxud004       varchar2(40)      ,/* 自定义字段(文本)004 */
fabxud005       varchar2(40)      ,/* 自定义字段(文本)005 */
fabxud006       varchar2(40)      ,/* 自定义字段(文本)006 */
fabxud007       varchar2(40)      ,/* 自定义字段(文本)007 */
fabxud008       varchar2(40)      ,/* 自定义字段(文本)008 */
fabxud009       varchar2(40)      ,/* 自定义字段(文本)009 */
fabxud010       varchar2(40)      ,/* 自定义字段(文本)010 */
fabxud011       number(20,6)      ,/* 自定义字段(数字)011 */
fabxud012       number(20,6)      ,/* 自定义字段(数字)012 */
fabxud013       number(20,6)      ,/* 自定义字段(数字)013 */
fabxud014       number(20,6)      ,/* 自定义字段(数字)014 */
fabxud015       number(20,6)      ,/* 自定义字段(数字)015 */
fabxud016       number(20,6)      ,/* 自定义字段(数字)016 */
fabxud017       number(20,6)      ,/* 自定义字段(数字)017 */
fabxud018       number(20,6)      ,/* 自定义字段(数字)018 */
fabxud019       number(20,6)      ,/* 自定义字段(数字)019 */
fabxud020       number(20,6)      ,/* 自定义字段(数字)020 */
fabxud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
fabxud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
fabxud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
fabxud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
fabxud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
fabxud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
fabxud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
fabxud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
fabxud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
fabxud030       timestamp(0)      /* 自定义字段(日期时间)030 */
);
alter table fabx_t add constraint fabx_pk primary key (fabxent,fabxdocno) enable validate;

create unique index fabx_pk on fabx_t (fabxent,fabxdocno);

grant select on fabx_t to tiptop;
grant update on fabx_t to tiptop;
grant delete on fabx_t to tiptop;
grant insert on fabx_t to tiptop;

exit;
