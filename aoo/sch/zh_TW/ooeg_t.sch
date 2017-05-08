/* 
================================================================================
檔案代號:ooeg_t
檔案名稱:部门数据档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table ooeg_t
(
ooegent       number(5)      ,/* 企业编号 */
ooegownid       varchar2(20)      ,/* 资料所有者 */
ooegowndp       varchar2(10)      ,/* 资料所有部门 */
ooegcrtid       varchar2(20)      ,/* 资料录入者 */
ooegcrtdp       varchar2(10)      ,/* 资料录入部门 */
ooegcrtdt       timestamp(0)      ,/* 资料创建日 */
ooegmodid       varchar2(20)      ,/* 资料更改者 */
ooegmoddt       timestamp(0)      ,/* 最近更改日 */
ooegstus       varchar2(10)      ,/* 状态码 */
ooeg001       varchar2(10)      ,/* 部门编号 */
ooeg002       varchar2(10)      ,/* 上层部门 */
ooeg003       varchar2(10)      ,/* 责任中心类型 */
ooeg004       varchar2(10)      ,/* 所属责任中心 */
ooeg005       varchar2(1)      ,/* 会计部门 */
ooeg006       date      ,/* 生效日期 */
ooeg007       date      ,/* 失效日期 */
ooeg008       varchar2(10)      ,/* 费用类别 */
ooeg009       varchar2(10)      ,/* 归属法人 */
ooeg010       varchar2(500)      ,/* 部门名称 */
ooegud001       varchar2(40)      ,/* 自定义字段(文本)001 */
ooegud002       varchar2(40)      ,/* 自定义字段(文本)002 */
ooegud003       varchar2(40)      ,/* 自定义字段(文本)003 */
ooegud004       varchar2(40)      ,/* 自定义字段(文本)004 */
ooegud005       varchar2(40)      ,/* 自定义字段(文本)005 */
ooegud006       varchar2(40)      ,/* 自定义字段(文本)006 */
ooegud007       varchar2(40)      ,/* 自定义字段(文本)007 */
ooegud008       varchar2(40)      ,/* 自定义字段(文本)008 */
ooegud009       varchar2(40)      ,/* 自定义字段(文本)009 */
ooegud010       varchar2(40)      ,/* 自定义字段(文本)010 */
ooegud011       number(20,6)      ,/* 自定义字段(数字)011 */
ooegud012       number(20,6)      ,/* 自定义字段(数字)012 */
ooegud013       number(20,6)      ,/* 自定义字段(数字)013 */
ooegud014       number(20,6)      ,/* 自定义字段(数字)014 */
ooegud015       number(20,6)      ,/* 自定义字段(数字)015 */
ooegud016       number(20,6)      ,/* 自定义字段(数字)016 */
ooegud017       number(20,6)      ,/* 自定义字段(数字)017 */
ooegud018       number(20,6)      ,/* 自定义字段(数字)018 */
ooegud019       number(20,6)      ,/* 自定义字段(数字)019 */
ooegud020       number(20,6)      ,/* 自定义字段(数字)020 */
ooegud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
ooegud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
ooegud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
ooegud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
ooegud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
ooegud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
ooegud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
ooegud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
ooegud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
ooegud030       timestamp(0)      ,/* 自定义字段(日期时间)030 */
ooeg011       varchar2(20)      ,/* 部门主管员工编号 */
ooeg012       varchar2(10)      /* 部门核决层级 */
);
alter table ooeg_t add constraint ooeg_pk primary key (ooegent,ooeg001) enable validate;

create unique index ooeg_pk on ooeg_t (ooegent,ooeg001);

grant select on ooeg_t to tiptop;
grant update on ooeg_t to tiptop;
grant delete on ooeg_t to tiptop;
grant insert on ooeg_t to tiptop;

exit;
