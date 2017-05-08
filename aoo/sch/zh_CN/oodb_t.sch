/* 
================================================================================
檔案代號:oodb_t
檔案名稱:税种基本数据档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table oodb_t
(
oodbent       number(5)      ,/* 企业编号 */
oodbownid       varchar2(20)      ,/* 资料所有者 */
oodbowndp       varchar2(10)      ,/* 资料所有部门 */
oodbcrtid       varchar2(20)      ,/* 资料录入者 */
oodbcrtdp       varchar2(10)      ,/* 资料录入部门 */
oodbcrtdt       timestamp(0)      ,/* 资料创建日 */
oodbmodid       varchar2(20)      ,/* 资料更改者 */
oodbmoddt       timestamp(0)      ,/* 最近更改日 */
oodbstus       varchar2(10)      ,/* 状态码 */
oodb001       varchar2(10)      ,/* 交易税区 */
oodb002       varchar2(10)      ,/* 税种编号 */
oodb003       varchar2(10)      ,/* 税种性质 */
oodb004       varchar2(1)      ,/* 课税原则 */
oodb005       varchar2(1)      ,/* 含税否 */
oodb006       number(5,2)      ,/* 税率 */
oodb007       varchar2(10)      ,/* 公式编号 */
oodb008       varchar2(1)      ,/* 课税种 */
oodb009       varchar2(1)      ,/* 下传POS否 */
oodb010       varchar2(1)      ,/* 下传POS状态 */
oodb011       varchar2(1)      ,/* 税种应用 */
oodb012       varchar2(1)      ,/* 并增值税打印发票 */
oodb013       number(20,6)      ,/* 固定税额 */
oodbud001       varchar2(40)      ,/* 自定义字段(文本)001 */
oodbud002       varchar2(40)      ,/* 自定义字段(文本)002 */
oodbud003       varchar2(40)      ,/* 自定义字段(文本)003 */
oodbud004       varchar2(40)      ,/* 自定义字段(文本)004 */
oodbud005       varchar2(40)      ,/* 自定义字段(文本)005 */
oodbud006       varchar2(40)      ,/* 自定义字段(文本)006 */
oodbud007       varchar2(40)      ,/* 自定义字段(文本)007 */
oodbud008       varchar2(40)      ,/* 自定义字段(文本)008 */
oodbud009       varchar2(40)      ,/* 自定义字段(文本)009 */
oodbud010       varchar2(40)      ,/* 自定义字段(文本)010 */
oodbud011       number(20,6)      ,/* 自定义字段(数字)011 */
oodbud012       number(20,6)      ,/* 自定义字段(数字)012 */
oodbud013       number(20,6)      ,/* 自定义字段(数字)013 */
oodbud014       number(20,6)      ,/* 自定义字段(数字)014 */
oodbud015       number(20,6)      ,/* 自定义字段(数字)015 */
oodbud016       number(20,6)      ,/* 自定义字段(数字)016 */
oodbud017       number(20,6)      ,/* 自定义字段(数字)017 */
oodbud018       number(20,6)      ,/* 自定义字段(数字)018 */
oodbud019       number(20,6)      ,/* 自定义字段(数字)019 */
oodbud020       number(20,6)      ,/* 自定义字段(数字)020 */
oodbud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
oodbud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
oodbud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
oodbud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
oodbud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
oodbud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
oodbud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
oodbud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
oodbud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
oodbud030       timestamp(0)      /* 自定义字段(日期时间)030 */
);
alter table oodb_t add constraint oodb_pk primary key (oodbent,oodb001,oodb002) enable validate;

create unique index oodb_pk on oodb_t (oodbent,oodb001,oodb002);

grant select on oodb_t to tiptop;
grant update on oodb_t to tiptop;
grant delete on oodb_t to tiptop;
grant insert on oodb_t to tiptop;

exit;
