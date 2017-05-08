/* 
================================================================================
檔案代號:fabg_t
檔案名稱:资产异动单头档(一账套)
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table fabg_t
(
fabgent       number(5)      ,/* 企业编号 */
fabgcomp       varchar2(10)      ,/* 法人 */
fabgld       varchar2(5)      ,/* 账套 */
fabgdocno       varchar2(20)      ,/* 来源单号 */
fabgdocdt       date      ,/* 单据日期 */
fabgsite       varchar2(10)      ,/* 资产中心 */
fabg001       varchar2(20)      ,/* 账务人员 */
fabg002       varchar2(20)      ,/* 申请人员 */
fabg003       varchar2(10)      ,/* 申请部门 */
fabg004       date      ,/* 申请日期 */
fabg005       number(10)      ,/* 异动类型 */
fabg006       varchar2(10)      ,/* 账款客户 */
fabg007       varchar2(10)      ,/* 收款客户 */
fabg008       varchar2(20)      ,/* 凭证号码 */
fabg009       date      ,/* 凭证日期 */
fabg010       varchar2(10)      ,/* 所有组织 */
fabg011       varchar2(20)      ,/* 生成应收账款编号 */
fabg012       varchar2(20)      ,/* 生成应付账款编号 */
fabg013       varchar2(10)      ,/* 税种 */
fabg014       number(5,2)      ,/* 税率 */
fabg015       varchar2(10)      ,/* 币种 */
fabg016       number(20,10)      ,/* 汇率 */
fabg017       varchar2(10)      ,/* 调拨流水码 */
fabg018       varchar2(10)      ,/* 核算组织 */
fabg019       varchar2(20)      ,/* 来源单号 */
fabgstus       varchar2(1)      ,/* 状态码 */
fabgownid       varchar2(20)      ,/* 资料所有者 */
fabgowndp       varchar2(10)      ,/* 资料所有部门 */
fabgcrtid       varchar2(20)      ,/* 资料录入者 */
fabgcrtdp       varchar2(10)      ,/* 资料录入部门 */
fabgcrtdt       timestamp(0)      ,/* 资料创建日 */
fabgmodid       varchar2(20)      ,/* 资料更改者 */
fabgmoddt       timestamp(0)      ,/* 最近更改日 */
fabgcnfid       varchar2(20)      ,/* 资料审核者 */
fabgcnfdt       timestamp(0)      ,/* 数据审核日 */
fabgpstid       varchar2(20)      ,/* 资料过账者 */
fabgpstdt       timestamp(0)      ,/* 资料过账日 */
fabgud001       varchar2(40)      ,/* 自定义字段(文本)001 */
fabgud002       varchar2(40)      ,/* 自定义字段(文本)002 */
fabgud003       varchar2(40)      ,/* 自定义字段(文本)003 */
fabgud004       varchar2(40)      ,/* 自定义字段(文本)004 */
fabgud005       varchar2(40)      ,/* 自定义字段(文本)005 */
fabgud006       varchar2(40)      ,/* 自定义字段(文本)006 */
fabgud007       varchar2(40)      ,/* 自定义字段(文本)007 */
fabgud008       varchar2(40)      ,/* 自定义字段(文本)008 */
fabgud009       varchar2(40)      ,/* 自定义字段(文本)009 */
fabgud010       varchar2(40)      ,/* 自定义字段(文本)010 */
fabgud011       number(20,6)      ,/* 自定义字段(数字)011 */
fabgud012       number(20,6)      ,/* 自定义字段(数字)012 */
fabgud013       number(20,6)      ,/* 自定义字段(数字)013 */
fabgud014       number(20,6)      ,/* 自定义字段(数字)014 */
fabgud015       number(20,6)      ,/* 自定义字段(数字)015 */
fabgud016       number(20,6)      ,/* 自定义字段(数字)016 */
fabgud017       number(20,6)      ,/* 自定义字段(数字)017 */
fabgud018       number(20,6)      ,/* 自定义字段(数字)018 */
fabgud019       number(20,6)      ,/* 自定义字段(数字)019 */
fabgud020       number(20,6)      ,/* 自定义字段(数字)020 */
fabgud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
fabgud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
fabgud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
fabgud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
fabgud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
fabgud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
fabgud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
fabgud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
fabgud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
fabgud030       timestamp(0)      ,/* 自定义字段(日期时间)030 */
fabg020       varchar2(1)      /* 资产性质 */
);
alter table fabg_t add constraint fabg_pk primary key (fabgent,fabgld,fabgdocno) enable validate;

create unique index fabg_pk on fabg_t (fabgent,fabgld,fabgdocno);

grant select on fabg_t to tiptop;
grant update on fabg_t to tiptop;
grant delete on fabg_t to tiptop;
grant insert on fabg_t to tiptop;

exit;
