/* 
================================================================================
檔案代號:xrcg_t
檔案名稱:收款条件变更申请纪录档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table xrcg_t
(
xrcgent       number(5)      ,/* 企业编码 */
xrcgownid       varchar2(20)      ,/* 资料所有者 */
xrcgowndp       varchar2(10)      ,/* 资料所有部门 */
xrcgcrtid       varchar2(20)      ,/* 资料录入者 */
xrcgcrtdp       varchar2(10)      ,/* 资料录入部门 */
xrcgcrtdt       timestamp(0)      ,/* 资料创建日 */
xrcgmodid       varchar2(20)      ,/* 资料更改者 */
xrcgmoddt       timestamp(0)      ,/* 最近更改日 */
xrcgcnfid       varchar2(20)      ,/* 资料审核者 */
xrcgcnfdt       timestamp(0)      ,/* 数据审核日 */
xrcgpstid       varchar2(20)      ,/* 资料过账者 */
xrcgpstdt       timestamp(0)      ,/* 资料过账日 */
xrcgstus       varchar2(1)      ,/* 状态码 */
xrcgcomp       varchar2(10)      ,/* 法人 */
xrcgld       varchar2(5)      ,/* 账套 */
xrcgsite       varchar2(10)      ,/* 营运据点 */
xrcgdocno       varchar2(20)      ,/* 申请编号 */
xrcgdocdt       date      ,/* 单据日期 */
xrcgseq       number(10,0)      ,/* 项次 */
xrcglegl       varchar2(10)      ,/* 核算组织 */
xrcg001       varchar2(10)      ,/* 账款对象 */
xrcg002       varchar2(20)      ,/* 应收单号 */
xrcg003       number(10,0)      ,/* 多账期项次 */
xrcg004       varchar2(10)      ,/* 原收款条件 */
xrcg005       varchar2(10)      ,/* 收款条件 */
xrcg006       date      ,/* 原应收款日 */
xrcg007       date      ,/* 应收款日 */
xrcg008       date      ,/* 原票据到期日 */
xrcg009       date      ,/* 票据到期日 */
xrcg010       varchar2(20)      ,/* 运行人员 */
xrcgud001       varchar2(40)      ,/* 自定义字段(文本)001 */
xrcgud002       varchar2(40)      ,/* 自定义字段(文本)002 */
xrcgud003       varchar2(40)      ,/* 自定义字段(文本)003 */
xrcgud004       varchar2(40)      ,/* 自定义字段(文本)004 */
xrcgud005       varchar2(40)      ,/* 自定义字段(文本)005 */
xrcgud006       varchar2(40)      ,/* 自定义字段(文本)006 */
xrcgud007       varchar2(40)      ,/* 自定义字段(文本)007 */
xrcgud008       varchar2(40)      ,/* 自定义字段(文本)008 */
xrcgud009       varchar2(40)      ,/* 自定义字段(文本)009 */
xrcgud010       varchar2(40)      ,/* 自定义字段(文本)010 */
xrcgud011       number(20,6)      ,/* 自定义字段(数字)011 */
xrcgud012       number(20,6)      ,/* 自定义字段(数字)012 */
xrcgud013       number(20,6)      ,/* 自定义字段(数字)013 */
xrcgud014       number(20,6)      ,/* 自定义字段(数字)014 */
xrcgud015       number(20,6)      ,/* 自定义字段(数字)015 */
xrcgud016       number(20,6)      ,/* 自定义字段(数字)016 */
xrcgud017       number(20,6)      ,/* 自定义字段(数字)017 */
xrcgud018       number(20,6)      ,/* 自定义字段(数字)018 */
xrcgud019       number(20,6)      ,/* 自定义字段(数字)019 */
xrcgud020       number(20,6)      ,/* 自定义字段(数字)020 */
xrcgud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
xrcgud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
xrcgud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
xrcgud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
xrcgud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
xrcgud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
xrcgud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
xrcgud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
xrcgud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
xrcgud030       timestamp(0)      /* 自定义字段(日期时间)030 */
);
alter table xrcg_t add constraint xrcg_pk primary key (xrcgent,xrcgld,xrcgdocno,xrcgseq) enable validate;

create unique index xrcg_pk on xrcg_t (xrcgent,xrcgld,xrcgdocno,xrcgseq);

grant select on xrcg_t to tiptop;
grant update on xrcg_t to tiptop;
grant delete on xrcg_t to tiptop;
grant insert on xrcg_t to tiptop;

exit;
