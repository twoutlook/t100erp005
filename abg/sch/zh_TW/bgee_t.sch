/* 
================================================================================
檔案代號:bgee_t
檔案名稱:采购预算价格档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table bgee_t
(
bgeeent       number(5)      ,/* 企业代码 */
bgee001       varchar2(10)      ,/* 预算编号 */
bgee002       varchar2(10)      ,/* 预算组织 */
bgee003       varchar2(40)      ,/* 预算料号 */
bgee004       varchar2(10)      ,/* 供应商 */
bgee005       varchar2(10)      ,/* 采购单位 */
bgee006       varchar2(10)      ,/* 采购币种 */
bgee007       varchar2(10)      ,/* 税种 */
bgee008       varchar2(1)      ,/* 含税否 */
bgee009       number(20,6)      ,/* 采购单价 */
bgee010       varchar2(40)      ,/* 对应料件 */
bgee011       varchar2(1)      ,/* 参考单价来源 */
bgeestus       varchar2(10)      ,/* 状态码 */
bgeeownid       varchar2(20)      ,/* 资料所有者 */
bgeeowndp       varchar2(10)      ,/* 资料所有部门 */
bgeecrtid       varchar2(20)      ,/* 资料录入者 */
bgeecrtdp       varchar2(10)      ,/* 资料录入部门 */
bgeecrtdt       timestamp(0)      ,/* 资料创建日 */
bgeemodid       varchar2(20)      ,/* 资料更改者 */
bgeemoddt       timestamp(0)      ,/* 最近更改日 */
bgeeud001       varchar2(40)      ,/* 自定义字段(文本)001 */
bgeeud002       varchar2(40)      ,/* 自定义字段(文本)002 */
bgeeud003       varchar2(40)      ,/* 自定义字段(文本)003 */
bgeeud004       varchar2(40)      ,/* 自定义字段(文本)004 */
bgeeud005       varchar2(40)      ,/* 自定义字段(文本)005 */
bgeeud006       varchar2(40)      ,/* 自定义字段(文本)006 */
bgeeud007       varchar2(40)      ,/* 自定义字段(文本)007 */
bgeeud008       varchar2(40)      ,/* 自定义字段(文本)008 */
bgeeud009       varchar2(40)      ,/* 自定义字段(文本)009 */
bgeeud010       varchar2(40)      ,/* 自定义字段(文本)010 */
bgeeud011       number(20,6)      ,/* 自定义字段(数字)011 */
bgeeud012       number(20,6)      ,/* 自定义字段(数字)012 */
bgeeud013       number(20,6)      ,/* 自定义字段(数字)013 */
bgeeud014       number(20,6)      ,/* 自定义字段(数字)014 */
bgeeud015       number(20,6)      ,/* 自定义字段(数字)015 */
bgeeud016       number(20,6)      ,/* 自定义字段(数字)016 */
bgeeud017       number(20,6)      ,/* 自定义字段(数字)017 */
bgeeud018       number(20,6)      ,/* 自定义字段(数字)018 */
bgeeud019       number(20,6)      ,/* 自定义字段(数字)019 */
bgeeud020       number(20,6)      ,/* 自定义字段(数字)020 */
bgeeud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
bgeeud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
bgeeud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
bgeeud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
bgeeud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
bgeeud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
bgeeud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
bgeeud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
bgeeud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
bgeeud030       timestamp(0)      ,/* 自定义字段(日期时间)030 */
bgee012       varchar2(10)      ,/* 产品分类 */
bgee013       varchar2(10)      ,/* 计价方式 */
bgee014       number(20,6)      /* 计价比率 */
);
alter table bgee_t add constraint bgee_pk primary key (bgeeent,bgee001,bgee002,bgee003,bgee004,bgee005,bgee012) enable validate;

create unique index bgee_pk on bgee_t (bgeeent,bgee001,bgee002,bgee003,bgee004,bgee005,bgee012);

grant select on bgee_t to tiptop;
grant update on bgee_t to tiptop;
grant delete on bgee_t to tiptop;
grant insert on bgee_t to tiptop;

exit;
