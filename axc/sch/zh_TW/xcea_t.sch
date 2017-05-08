/* 
================================================================================
檔案代號:xcea_t
檔案名稱:工单发料成本凭证单头档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table xcea_t
(
xceaent       number(5)      ,/* 企业编号 */
xceacomp       varchar2(10)      ,/* 法人组织 */
xceald       varchar2(5)      ,/* 账套 */
xceadocno       varchar2(20)      ,/* 单据编号 */
xcea001       date      ,/* 单据日期 */
xcea002       varchar2(10)      ,/* 成本凭证类型 */
xcea003       varchar2(10)      ,/* 成本计算类型 */
xcea004       number(5,0)      ,/* 年度 */
xcea005       number(5,0)      ,/* 期别 */
xcea006       varchar2(20)      ,/* 账务人员 */
xcea007       varchar2(10)      ,/* 账务部门 */
xcea101       varchar2(20)      ,/* 凭证编号 */
xcea102       date      ,/* 凭证日期 */
xceaownid       varchar2(20)      ,/* 资料所有者 */
xceaowndp       varchar2(10)      ,/* 资料所有部门 */
xceacrtid       varchar2(20)      ,/* 资料录入者 */
xceacrtdp       varchar2(10)      ,/* 资料录入部门 */
xceacrtdt       timestamp(0)      ,/* 资料创建日 */
xceamodid       varchar2(20)      ,/* 资料更改者 */
xceamoddt       timestamp(0)      ,/* 最近更改日 */
xceacnfid       varchar2(20)      ,/* 资料审核者 */
xceacnfdt       timestamp(0)      ,/* 数据审核日 */
xceapstid       varchar2(20)      ,/* 资料过账者 */
xceapstdt       timestamp(0)      ,/* 资料过账日 */
xceastus       varchar2(10)      ,/* 状态码 */
xceaud001       varchar2(40)      ,/* 自定义字段(文本)001 */
xceaud002       varchar2(40)      ,/* 自定义字段(文本)002 */
xceaud003       varchar2(40)      ,/* 自定义字段(文本)003 */
xceaud004       varchar2(40)      ,/* 自定义字段(文本)004 */
xceaud005       varchar2(40)      ,/* 自定义字段(文本)005 */
xceaud006       varchar2(40)      ,/* 自定义字段(文本)006 */
xceaud007       varchar2(40)      ,/* 自定义字段(文本)007 */
xceaud008       varchar2(40)      ,/* 自定义字段(文本)008 */
xceaud009       varchar2(40)      ,/* 自定义字段(文本)009 */
xceaud010       varchar2(40)      ,/* 自定义字段(文本)010 */
xceaud011       number(20,6)      ,/* 自定义字段(数字)011 */
xceaud012       number(20,6)      ,/* 自定义字段(数字)012 */
xceaud013       number(20,6)      ,/* 自定义字段(数字)013 */
xceaud014       number(20,6)      ,/* 自定义字段(数字)014 */
xceaud015       number(20,6)      ,/* 自定义字段(数字)015 */
xceaud016       number(20,6)      ,/* 自定义字段(数字)016 */
xceaud017       number(20,6)      ,/* 自定义字段(数字)017 */
xceaud018       number(20,6)      ,/* 自定义字段(数字)018 */
xceaud019       number(20,6)      ,/* 自定义字段(数字)019 */
xceaud020       number(20,6)      ,/* 自定义字段(数字)020 */
xceaud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
xceaud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
xceaud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
xceaud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
xceaud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
xceaud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
xceaud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
xceaud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
xceaud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
xceaud030       timestamp(0)      ,/* 自定义字段(日期时间)030 */
xceasite       varchar2(10)      /* 营运据点 */
);
alter table xcea_t add constraint xcea_pk primary key (xceaent,xceald,xceadocno) enable validate;

create  index xcea_n on xcea_t (xceaent,xcea002);
create unique index xcea_pk on xcea_t (xceaent,xceald,xceadocno);

grant select on xcea_t to tiptop;
grant update on xcea_t to tiptop;
grant delete on xcea_t to tiptop;
grant insert on xcea_t to tiptop;

exit;
