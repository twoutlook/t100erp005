/* 
================================================================================
檔案代號:mmdn_t
檔案名稱:会员晋级商品范围设置档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table mmdn_t
(
mmdnent       number(5)      ,/* 企业编号 */
mmdn001       varchar2(10)      ,/* 方向 */
mmdn002       varchar2(10)      ,/* 属性 */
mmdn003       varchar2(40)      ,/* 属性编号 */
mmdnstus       varchar2(10)      ,/* 状态码 */
mmdnownid       varchar2(20)      ,/* 资料所有者 */
mmdnowndp       varchar2(10)      ,/* 资料所有部门 */
mmdncrtid       varchar2(20)      ,/* 资料录入者 */
mmdncrtdp       varchar2(10)      ,/* 资料录入部门 */
mmdncrtdt       timestamp(0)      ,/* 资料创建日 */
mmdnmodid       varchar2(20)      ,/* 资料更改者 */
mmdnmoddt       timestamp(0)      ,/* 最近更改日 */
mmdnud001       varchar2(40)      ,/* 自定义字段(文本)001 */
mmdnud002       varchar2(40)      ,/* 自定义字段(文本)002 */
mmdnud003       varchar2(40)      ,/* 自定义字段(文本)003 */
mmdnud004       varchar2(40)      ,/* 自定义字段(文本)004 */
mmdnud005       varchar2(40)      ,/* 自定义字段(文本)005 */
mmdnud006       varchar2(40)      ,/* 自定义字段(文本)006 */
mmdnud007       varchar2(40)      ,/* 自定义字段(文本)007 */
mmdnud008       varchar2(40)      ,/* 自定义字段(文本)008 */
mmdnud009       varchar2(40)      ,/* 自定义字段(文本)009 */
mmdnud010       varchar2(40)      ,/* 自定义字段(文本)010 */
mmdnud011       number(20,6)      ,/* 自定义字段(数字)011 */
mmdnud012       number(20,6)      ,/* 自定义字段(数字)012 */
mmdnud013       number(20,6)      ,/* 自定义字段(数字)013 */
mmdnud014       number(20,6)      ,/* 自定义字段(数字)014 */
mmdnud015       number(20,6)      ,/* 自定义字段(数字)015 */
mmdnud016       number(20,6)      ,/* 自定义字段(数字)016 */
mmdnud017       number(20,6)      ,/* 自定义字段(数字)017 */
mmdnud018       number(20,6)      ,/* 自定义字段(数字)018 */
mmdnud019       number(20,6)      ,/* 自定义字段(数字)019 */
mmdnud020       number(20,6)      ,/* 自定义字段(数字)020 */
mmdnud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
mmdnud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
mmdnud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
mmdnud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
mmdnud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
mmdnud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
mmdnud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
mmdnud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
mmdnud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
mmdnud030       timestamp(0)      /* 自定义字段(日期时间)030 */
);
alter table mmdn_t add constraint mmdn_pk primary key (mmdnent,mmdn001,mmdn002,mmdn003) enable validate;

create unique index mmdn_pk on mmdn_t (mmdnent,mmdn001,mmdn002,mmdn003);

grant select on mmdn_t to tiptop;
grant update on mmdn_t to tiptop;
grant delete on mmdn_t to tiptop;
grant insert on mmdn_t to tiptop;

exit;
