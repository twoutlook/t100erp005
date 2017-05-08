/* 
================================================================================
檔案代號:gzar_t
檔案名稱:异常管理节点维护档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table gzar_t
(
gzarent       number(5)      ,/* 企业编号 */
gzar001       varchar2(10)      ,/* 节点编号 */
gzar002       varchar2(10)      ,/* 模块 */
gzar003       varchar2(20)      ,/* 检核来源报表 */
gzar004       varchar2(4000)      ,/* 异常条件 */
gzar005       varchar2(4000)      ,/* 警告条件 */
gzar006       varchar2(1)      ,/* 客制 */
gzarownid       varchar2(20)      ,/* 资料所有者 */
gzarowndp       varchar2(10)      ,/* 资料所有部门 */
gzarcrtid       varchar2(20)      ,/* 资料录入者 */
gzarcrtdp       varchar2(10)      ,/* 资料录入部门 */
gzarcrtdt       timestamp(0)      ,/* 资料创建日 */
gzarmodid       varchar2(20)      ,/* 资料更改者 */
gzarmoddt       timestamp(0)      ,/* 最近更改日 */
gzarstus       varchar2(10)      ,/* 状态码 */
gzarud001       varchar2(40)      ,/* 自定义字段(文本)001 */
gzarud002       varchar2(40)      ,/* 自定义字段(文本)002 */
gzarud003       varchar2(40)      ,/* 自定义字段(文本)003 */
gzarud004       varchar2(40)      ,/* 自定义字段(文本)004 */
gzarud005       varchar2(40)      ,/* 自定义字段(文本)005 */
gzarud006       varchar2(40)      ,/* 自定义字段(文本)006 */
gzarud007       varchar2(40)      ,/* 自定义字段(文本)007 */
gzarud008       varchar2(40)      ,/* 自定义字段(文本)008 */
gzarud009       varchar2(40)      ,/* 自定义字段(文本)009 */
gzarud010       varchar2(40)      ,/* 自定义字段(文本)010 */
gzarud011       number(20,6)      ,/* 自定义字段(数字)011 */
gzarud012       number(20,6)      ,/* 自定义字段(数字)012 */
gzarud013       number(20,6)      ,/* 自定义字段(数字)013 */
gzarud014       number(20,6)      ,/* 自定义字段(数字)014 */
gzarud015       number(20,6)      ,/* 自定义字段(数字)015 */
gzarud016       number(20,6)      ,/* 自定义字段(数字)016 */
gzarud017       number(20,6)      ,/* 自定义字段(数字)017 */
gzarud018       number(20,6)      ,/* 自定义字段(数字)018 */
gzarud019       number(20,6)      ,/* 自定义字段(数字)019 */
gzarud020       number(20,6)      ,/* 自定义字段(数字)020 */
gzarud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
gzarud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
gzarud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
gzarud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
gzarud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
gzarud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
gzarud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
gzarud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
gzarud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
gzarud030       timestamp(0)      /* 自定义字段(日期时间)030 */
);
alter table gzar_t add constraint gzar_pk primary key (gzarent,gzar001) enable validate;

create unique index gzar_pk on gzar_t (gzarent,gzar001);

grant select on gzar_t to tiptop;
grant update on gzar_t to tiptop;
grant delete on gzar_t to tiptop;
grant insert on gzar_t to tiptop;

exit;
