/* 
================================================================================
檔案代號:gzwj_t
檔案名稱:问题反映附件
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table gzwj_t
(
gzwj001       varchar2(20)      ,/* 问题编号 */
gzwj002       number(5,0)      ,/* 附件编号 */
gzwj003       blob      ,/* 附件 */
gzwj004       varchar2(255)      ,/* 附件文件名 */
gzwj005       varchar2(10)      ,/* 附件扩展名 */
gzwj006       varchar2(1)      ,/* 来源类型 */
gzwjud001       varchar2(40)      ,/* 自定义字段(文本)001 */
gzwjud002       varchar2(40)      ,/* 自定义字段(文本)002 */
gzwjud003       varchar2(40)      ,/* 自定义字段(文本)003 */
gzwjud004       varchar2(40)      ,/* 自定义字段(文本)004 */
gzwjud005       varchar2(40)      ,/* 自定义字段(文本)005 */
gzwjud006       varchar2(40)      ,/* 自定义字段(文本)006 */
gzwjud007       varchar2(40)      ,/* 自定义字段(文本)007 */
gzwjud008       varchar2(40)      ,/* 自定义字段(文本)008 */
gzwjud009       varchar2(40)      ,/* 自定义字段(文本)009 */
gzwjud010       varchar2(40)      ,/* 自定义字段(文本)010 */
gzwjud011       number(20,6)      ,/* 自定义字段(数字)011 */
gzwjud012       number(20,6)      ,/* 自定义字段(数字)012 */
gzwjud013       number(20,6)      ,/* 自定义字段(数字)013 */
gzwjud014       number(20,6)      ,/* 自定义字段(数字)014 */
gzwjud015       number(20,6)      ,/* 自定义字段(数字)015 */
gzwjud016       number(20,6)      ,/* 自定义字段(数字)016 */
gzwjud017       number(20,6)      ,/* 自定义字段(数字)017 */
gzwjud018       number(20,6)      ,/* 自定义字段(数字)018 */
gzwjud019       number(20,6)      ,/* 自定义字段(数字)019 */
gzwjud020       number(20,6)      ,/* 自定义字段(数字)020 */
gzwjud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
gzwjud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
gzwjud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
gzwjud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
gzwjud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
gzwjud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
gzwjud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
gzwjud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
gzwjud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
gzwjud030       timestamp(0)      ,/* 自定义字段(日期时间)030 */
gzwj007       number(5)      ,/* 企业编号 */
gzwj008       varchar2(1)      ,/* 同步 */
gzwjownid       varchar2(20)      ,/* 资料所有者 */
gzwjowndp       varchar2(10)      ,/* 资料所有部门 */
gzwjcrtid       varchar2(20)      ,/* 资料录入者 */
gzwjcrtdp       varchar2(10)      ,/* 资料录入部门 */
gzwjcrtdt       timestamp(0)      ,/* 资料创建日 */
gzwjmodid       varchar2(20)      ,/* 资料更改者 */
gzwjmoddt       timestamp(0)      /* 最近更改日 */
);
alter table gzwj_t add constraint gzwj_pk primary key (gzwj001,gzwj002) enable validate;

create unique index gzwj_pk on gzwj_t (gzwj001,gzwj002);

grant select on gzwj_t to tiptop;
grant update on gzwj_t to tiptop;
grant delete on gzwj_t to tiptop;
grant insert on gzwj_t to tiptop;

exit;
