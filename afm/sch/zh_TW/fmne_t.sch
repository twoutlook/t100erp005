/* 
================================================================================
檔案代號:fmne_t
檔案名稱:平仓出售账务单头档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table fmne_t
(
fmneent       number(5)      ,/* 企业编号 */
fmneownid       varchar2(20)      ,/* 资料所有者 */
fmneowndp       varchar2(10)      ,/* 资料所有部门 */
fmnecrtid       varchar2(20)      ,/* 资料录入者 */
fmnecrtdp       varchar2(10)      ,/* 资料录入部门 */
fmnecrtdt       timestamp(0)      ,/* 资料创建日 */
fmnemodid       varchar2(20)      ,/* 资料更改者 */
fmnemoddt       timestamp(0)      ,/* 最近更改日 */
fmnecnfid       varchar2(20)      ,/* 资料审核者 */
fmnecnfdt       timestamp(0)      ,/* 数据审核日 */
fmnepstid       varchar2(20)      ,/* 资料过账者 */
fmnepstdt       timestamp(0)      ,/* 资料过账日 */
fmnestus       varchar2(10)      ,/* 状态码 */
fmnedocno       varchar2(20)      ,/* 单号 */
fmnecomp       varchar2(10)      ,/* 法人 */
fmnesite       varchar2(10)      ,/* 账务中心 */
fmnedocdt       date      ,/* 单据日期 */
fmne001       varchar2(5)      ,/* 账套 */
fmne002       number(5,0)      ,/* 年度 */
fmne003       number(5,0)      ,/* 期别 */
fmne004       varchar2(20)      ,/* 凭证号码 */
fmne005       varchar2(20)      ,/* 账务人员 */
fmneud001       varchar2(40)      ,/* 自定义字段(文本)001 */
fmneud002       varchar2(40)      ,/* 自定义字段(文本)002 */
fmneud003       varchar2(40)      ,/* 自定义字段(文本)003 */
fmneud004       varchar2(40)      ,/* 自定义字段(文本)004 */
fmneud005       varchar2(40)      ,/* 自定义字段(文本)005 */
fmneud006       varchar2(40)      ,/* 自定义字段(文本)006 */
fmneud007       varchar2(40)      ,/* 自定义字段(文本)007 */
fmneud008       varchar2(40)      ,/* 自定义字段(文本)008 */
fmneud009       varchar2(40)      ,/* 自定义字段(文本)009 */
fmneud010       varchar2(40)      ,/* 自定义字段(文本)010 */
fmneud011       number(20,6)      ,/* 自定义字段(数字)011 */
fmneud012       number(20,6)      ,/* 自定义字段(数字)012 */
fmneud013       number(20,6)      ,/* 自定义字段(数字)013 */
fmneud014       number(20,6)      ,/* 自定义字段(数字)014 */
fmneud015       number(20,6)      ,/* 自定义字段(数字)015 */
fmneud016       number(20,6)      ,/* 自定义字段(数字)016 */
fmneud017       number(20,6)      ,/* 自定义字段(数字)017 */
fmneud018       number(20,6)      ,/* 自定义字段(数字)018 */
fmneud019       number(20,6)      ,/* 自定义字段(数字)019 */
fmneud020       number(20,6)      ,/* 自定义字段(数字)020 */
fmneud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
fmneud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
fmneud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
fmneud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
fmneud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
fmneud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
fmneud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
fmneud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
fmneud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
fmneud030       timestamp(0)      /* 自定义字段(日期时间)030 */
);
alter table fmne_t add constraint fmne_pk primary key (fmneent,fmnedocno) enable validate;

create unique index fmne_pk on fmne_t (fmneent,fmnedocno);

grant select on fmne_t to tiptop;
grant update on fmne_t to tiptop;
grant delete on fmne_t to tiptop;
grant insert on fmne_t to tiptop;

exit;
