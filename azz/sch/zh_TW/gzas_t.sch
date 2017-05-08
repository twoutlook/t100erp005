/* 
================================================================================
檔案代號:gzas_t
檔案名稱:异常管理检核设置档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table gzas_t
(
gzasent       number(5)      ,/* 企业编号 */
gzas001       varchar2(10)      ,/* 上层目录编号 */
gzas002       varchar2(10)      ,/* 目录编号 */
gzas003       number(5,0)      ,/* 显示顺序 */
gzas004       varchar2(1)      ,/* 节点形态 */
gzas005       varchar2(1)      ,/* 客制 */
gzasownid       varchar2(20)      ,/* 资料所有者 */
gzasowndp       varchar2(10)      ,/* 资料所有部门 */
gzascrtid       varchar2(20)      ,/* 资料建立者 */
gzascrtdp       varchar2(10)      ,/* 资料建立部门 */
gzascrtdt       timestamp(0)      ,/* 资料创建日 */
gzasmodid       varchar2(20)      ,/* 资料修改者 */
gzasmoddt       timestamp(0)      ,/* 最近修改日 */
gzasud001       varchar2(40)      ,/* 自定义字段(文字)001 */
gzasud002       varchar2(40)      ,/* 自定义字段(文字)002 */
gzasud003       varchar2(40)      ,/* 自定义字段(文字)003 */
gzasud004       varchar2(40)      ,/* 自定义字段(文字)004 */
gzasud005       varchar2(40)      ,/* 自定义字段(文字)005 */
gzasud006       varchar2(40)      ,/* 自定义字段(文字)006 */
gzasud007       varchar2(40)      ,/* 自定义字段(文字)007 */
gzasud008       varchar2(40)      ,/* 自定义字段(文字)008 */
gzasud009       varchar2(40)      ,/* 自定义字段(文字)009 */
gzasud010       varchar2(40)      ,/* 自定义字段(文字)010 */
gzasud011       number(20,6)      ,/* 自定义字段(数字)011 */
gzasud012       number(20,6)      ,/* 自定义字段(数字)012 */
gzasud013       number(20,6)      ,/* 自定义字段(数字)013 */
gzasud014       number(20,6)      ,/* 自定义字段(数字)014 */
gzasud015       number(20,6)      ,/* 自定义字段(数字)015 */
gzasud016       number(20,6)      ,/* 自定义字段(数字)016 */
gzasud017       number(20,6)      ,/* 自定义字段(数字)017 */
gzasud018       number(20,6)      ,/* 自定义字段(数字)018 */
gzasud019       number(20,6)      ,/* 自定义字段(数字)019 */
gzasud020       number(20,6)      ,/* 自定义字段(数字)020 */
gzasud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
gzasud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
gzasud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
gzasud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
gzasud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
gzasud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
gzasud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
gzasud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
gzasud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
gzasud030       timestamp(0)      /* 自定义字段(日期时间)030 */
);
alter table gzas_t add constraint gzas_pk primary key (gzasent,gzas001,gzas002) enable validate;

create unique index gzas_pk on gzas_t (gzasent,gzas001,gzas002);

grant select on gzas_t to tiptop;
grant update on gzas_t to tiptop;
grant delete on gzas_t to tiptop;
grant insert on gzas_t to tiptop;

exit;
