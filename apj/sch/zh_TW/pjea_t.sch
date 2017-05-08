/* 
================================================================================
檔案代號:pjea_t
檔案名稱:项目费用分摊科目设置作业
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table pjea_t
(
pjeaent       number(5)      ,/* 企业编号 */
pjeald       varchar2(5)      ,/* 帐套编号 */
pjea002       number(5,0)      ,/* 年度 */
pjea003       number(5,0)      ,/* 期别 */
pjea004       varchar2(20)      ,/* 项目编号 */
pjea005       varchar2(24)      ,/* 科目编号 */
pjea006       varchar2(10)      ,/* 部门编号 */
pjea009       number(15,3)      ,/* 分摊权数 */
pjeaownid       varchar2(20)      ,/* 资料所有者 */
pjeaowndp       varchar2(10)      ,/* 资料所属部门 */
pjeacrtid       varchar2(20)      ,/* 资料录入者 */
pjeacrtdp       varchar2(10)      ,/* 资料录入部门 */
pjeacrtdt       timestamp(0)      ,/* 资料创建日 */
pjeamodid       varchar2(20)      ,/* 资料更改者 */
pjeamoddt       timestamp(0)      ,/* 最近更改日 */
pjeastus       varchar2(10)      ,/* 状态码 */
pjeaud001       varchar2(40)      ,/* 自定义字段(文本)001 */
pjeaud002       varchar2(40)      ,/* 自定义字段(文本)002 */
pjeaud003       varchar2(40)      ,/* 自定义字段(文本)003 */
pjeaud004       varchar2(40)      ,/* 自定义字段(文本)004 */
pjeaud005       varchar2(40)      ,/* 自定义字段(文本)005 */
pjeaud006       varchar2(40)      ,/* 自定义字段(文本)006 */
pjeaud007       varchar2(40)      ,/* 自定义字段(文本)007 */
pjeaud008       varchar2(40)      ,/* 自定义字段(文本)008 */
pjeaud009       varchar2(40)      ,/* 自定义字段(文本)009 */
pjeaud010       varchar2(40)      ,/* 自定义字段(文本)010 */
pjeaud011       number(20,6)      ,/* 自定义字段(数字)011 */
pjeaud012       number(20,6)      ,/* 自定义字段(数字)012 */
pjeaud013       number(20,6)      ,/* 自定义字段(数字)013 */
pjeaud014       number(20,6)      ,/* 自定义字段(数字)014 */
pjeaud015       number(20,6)      ,/* 自定义字段(数字)015 */
pjeaud016       number(20,6)      ,/* 自定义字段(数字)016 */
pjeaud017       number(20,6)      ,/* 自定义字段(数字)017 */
pjeaud018       number(20,6)      ,/* 自定义字段(数字)018 */
pjeaud019       number(20,6)      ,/* 自定义字段(数字)019 */
pjeaud020       number(20,6)      ,/* 自定义字段(数字)020 */
pjeaud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
pjeaud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
pjeaud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
pjeaud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
pjeaud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
pjeaud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
pjeaud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
pjeaud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
pjeaud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
pjeaud030       timestamp(0)      /* 自定义字段(日期时间)030 */
);
alter table pjea_t add constraint pjea_pk primary key (pjeaent,pjeald,pjea002,pjea003,pjea004,pjea005,pjea006) enable validate;

create unique index pjea_pk on pjea_t (pjeaent,pjeald,pjea002,pjea003,pjea004,pjea005,pjea006);

grant select on pjea_t to tiptop;
grant update on pjea_t to tiptop;
grant delete on pjea_t to tiptop;
grant insert on pjea_t to tiptop;

exit;
