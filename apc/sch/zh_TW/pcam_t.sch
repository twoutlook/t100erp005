/* 
================================================================================
檔案代號:pcam_t
檔案名稱:Service日志记录档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pcam_t
(
pcament       number(5)      ,/* 企业编号 */
pcamsite       varchar2(10)      ,/* 营运组织 */
pcam001       varchar2(40)      ,/* 请求ID */
pcam002       varchar2(10)      ,/* 单据类型 */
pcam003       varchar2(40)      ,/* 服务名 */
pcam004       date      ,/* 请求日期 */
pcam005       varchar2(8)      ,/* 请求时间 */
pcam006       varchar2(10)      ,/* 请求类型 */
pcam007       varchar2(20)      ,/* 请求单号 */
pcam008       varchar2(30)      ,/* 用户名卡号券号 */
pcam009       varchar2(40)      ,/* 更新前数据 */
pcam010       varchar2(40)      ,/* 更新后数据 */
pcam011       number(20,6)      ,/* 本次异动 */
pcam012       varchar2(10)      ,/* 收银机号 */
pcam013       number(20,6)      ,/* 本次消费金额 */
pcam014       varchar2(10)      ,/* 状态 */
pcamud001       varchar2(40)      ,/* 自定义字段(文本)001 */
pcamud002       varchar2(40)      ,/* 自定义字段(文本)002 */
pcamud003       varchar2(40)      ,/* 自定义字段(文本)003 */
pcamud004       varchar2(40)      ,/* 自定义字段(文本)004 */
pcamud005       varchar2(40)      ,/* 自定义字段(文本)005 */
pcamud006       varchar2(40)      ,/* 自定义字段(文本)006 */
pcamud007       varchar2(40)      ,/* 自定义字段(文本)007 */
pcamud008       varchar2(40)      ,/* 自定义字段(文本)008 */
pcamud009       varchar2(40)      ,/* 自定义字段(文本)009 */
pcamud010       varchar2(40)      ,/* 自定义字段(文本)010 */
pcamud011       number(20,6)      ,/* 自定义字段(数字)011 */
pcamud012       number(20,6)      ,/* 自定义字段(数字)012 */
pcamud013       number(20,6)      ,/* 自定义字段(数字)013 */
pcamud014       number(20,6)      ,/* 自定义字段(数字)014 */
pcamud015       number(20,6)      ,/* 自定义字段(数字)015 */
pcamud016       number(20,6)      ,/* 自定义字段(数字)016 */
pcamud017       number(20,6)      ,/* 自定义字段(数字)017 */
pcamud018       number(20,6)      ,/* 自定义字段(数字)018 */
pcamud019       number(20,6)      ,/* 自定义字段(数字)019 */
pcamud020       number(20,6)      ,/* 自定义字段(数字)020 */
pcamud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
pcamud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
pcamud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
pcamud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
pcamud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
pcamud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
pcamud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
pcamud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
pcamud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
pcamud030       timestamp(0)      ,/* 自定义字段(日期时间)030 */
pcam015       varchar2(40)      ,/* 处理ID */
pcam016       varchar2(10)      ,/* SID */
pcam017       varchar2(10)      ,/* Serial */
pcam018       varchar2(10)      /* 数据库Instance号码 */
);
alter table pcam_t add constraint pcam_pk primary key (pcament,pcam001,pcam015) enable validate;

create unique index pcam_pk on pcam_t (pcament,pcam001,pcam015);

grant select on pcam_t to tiptop;
grant update on pcam_t to tiptop;
grant delete on pcam_t to tiptop;
grant insert on pcam_t to tiptop;

exit;
