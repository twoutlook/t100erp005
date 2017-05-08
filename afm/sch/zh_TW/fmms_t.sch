/* 
================================================================================
檔案代號:fmms_t
檔案名稱:计提投资收益维护作业单头档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table fmms_t
(
fmmsent       number(5)      ,/* 企业编号 */
fmmsownid       varchar2(20)      ,/* 资料所有者 */
fmmsowndp       varchar2(10)      ,/* 资料所有部门 */
fmmscrtid       varchar2(20)      ,/* 资料录入者 */
fmmscrtdp       varchar2(10)      ,/* 资料录入部门 */
fmmscrtdt       timestamp(0)      ,/* 资料创建日 */
fmmsmodid       varchar2(20)      ,/* 资料更改者 */
fmmsmoddt       timestamp(0)      ,/* 最近更改日 */
fmmscnfid       varchar2(20)      ,/* 资料审核者 */
fmmscnfdt       timestamp(0)      ,/* 数据审核日 */
fmmspstid       varchar2(20)      ,/* 资料过账者 */
fmmspstdt       timestamp(0)      ,/* 资料过账日 */
fmmsstus       varchar2(10)      ,/* 状态码 */
fmmscomp       varchar2(10)      ,/* 法人 */
fmmsdocno       varchar2(20)      ,/* 计息单号 */
fmms001       number(5,0)      ,/* 年度 */
fmms002       number(5,0)      ,/* 期别 */
fmmsud001       varchar2(40)      ,/* 自定义字段(文本)001 */
fmmsud002       varchar2(40)      ,/* 自定义字段(文本)002 */
fmmsud003       varchar2(40)      ,/* 自定义字段(文本)003 */
fmmsud004       varchar2(40)      ,/* 自定义字段(文本)004 */
fmmsud005       varchar2(40)      ,/* 自定义字段(文本)005 */
fmmsud006       varchar2(40)      ,/* 自定义字段(文本)006 */
fmmsud007       varchar2(40)      ,/* 自定义字段(文本)007 */
fmmsud008       varchar2(40)      ,/* 自定义字段(文本)008 */
fmmsud009       varchar2(40)      ,/* 自定义字段(文本)009 */
fmmsud010       varchar2(40)      ,/* 自定义字段(文本)010 */
fmmsud011       number(20,6)      ,/* 自定义字段(数字)011 */
fmmsud012       number(20,6)      ,/* 自定义字段(数字)012 */
fmmsud013       number(20,6)      ,/* 自定义字段(数字)013 */
fmmsud014       number(20,6)      ,/* 自定义字段(数字)014 */
fmmsud015       number(20,6)      ,/* 自定义字段(数字)015 */
fmmsud016       number(20,6)      ,/* 自定义字段(数字)016 */
fmmsud017       number(20,6)      ,/* 自定义字段(数字)017 */
fmmsud018       number(20,6)      ,/* 自定义字段(数字)018 */
fmmsud019       number(20,6)      ,/* 自定义字段(数字)019 */
fmmsud020       number(20,6)      ,/* 自定义字段(数字)020 */
fmmsud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
fmmsud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
fmmsud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
fmmsud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
fmmsud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
fmmsud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
fmmsud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
fmmsud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
fmmsud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
fmmsud030       timestamp(0)      /* 自定义字段(日期时间)030 */
);
alter table fmms_t add constraint fmms_pk primary key (fmmsent,fmmsdocno) enable validate;

create unique index fmms_pk on fmms_t (fmmsent,fmmsdocno);

grant select on fmms_t to tiptop;
grant update on fmms_t to tiptop;
grant delete on fmms_t to tiptop;
grant insert on fmms_t to tiptop;

exit;
