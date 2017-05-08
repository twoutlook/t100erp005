/* 
================================================================================
檔案代號:bgak_t
檔案名稱:预算权限档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table bgak_t
(
bgakent       number(5)      ,/* 企业编号 */
bgakownid       varchar2(20)      ,/* 资料所有者 */
bgakowndp       varchar2(10)      ,/* 资料所有部门 */
bgakcrtid       varchar2(20)      ,/* 资料录入者 */
bgakcrtdp       varchar2(10)      ,/* 资料录入部门 */
bgakcrtdt       timestamp(0)      ,/* 资料创建日 */
bgakmodid       varchar2(20)      ,/* 资料更改者 */
bgakmoddt       timestamp(0)      ,/* 最近更改日 */
bgakstus       varchar2(10)      ,/* 状态码 */
bgak001       number(5,0)      ,/* 预算年度 */
bgak002       varchar2(10)      ,/* 预算管理组织 */
bgak003       varchar2(20)      ,/* 组织成员 */
bgak004       varchar2(10)      ,/* 可操作预算模块 */
bgak005       varchar2(20)      ,/* 可操作模块 */
bgak006       varchar2(24)      ,/* 可编制预算细项 */
bgakud001       varchar2(40)      ,/* 自定义字段(文本)001 */
bgakud002       varchar2(40)      ,/* 自定义字段(文本)002 */
bgakud003       varchar2(40)      ,/* 自定义字段(文本)003 */
bgakud004       varchar2(40)      ,/* 自定义字段(文本)004 */
bgakud005       varchar2(40)      ,/* 自定义字段(文本)005 */
bgakud006       varchar2(40)      ,/* 自定义字段(文本)006 */
bgakud007       varchar2(40)      ,/* 自定义字段(文本)007 */
bgakud008       varchar2(40)      ,/* 自定义字段(文本)008 */
bgakud009       varchar2(40)      ,/* 自定义字段(文本)009 */
bgakud010       varchar2(40)      ,/* 自定义字段(文本)010 */
bgakud011       number(20,6)      ,/* 自定义字段(数字)011 */
bgakud012       number(20,6)      ,/* 自定义字段(数字)012 */
bgakud013       number(20,6)      ,/* 自定义字段(数字)013 */
bgakud014       number(20,6)      ,/* 自定义字段(数字)014 */
bgakud015       number(20,6)      ,/* 自定义字段(数字)015 */
bgakud016       number(20,6)      ,/* 自定义字段(数字)016 */
bgakud017       number(20,6)      ,/* 自定义字段(数字)017 */
bgakud018       number(20,6)      ,/* 自定义字段(数字)018 */
bgakud019       number(20,6)      ,/* 自定义字段(数字)019 */
bgakud020       number(20,6)      ,/* 自定义字段(数字)020 */
bgakud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
bgakud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
bgakud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
bgakud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
bgakud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
bgakud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
bgakud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
bgakud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
bgakud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
bgakud030       timestamp(0)      /* 自定义字段(日期时间)030 */
);
alter table bgak_t add constraint bgak_pk primary key (bgakent,bgak001,bgak002,bgak003,bgak004,bgak006) enable validate;

create unique index bgak_pk on bgak_t (bgakent,bgak001,bgak002,bgak003,bgak004,bgak006);

grant select on bgak_t to tiptop;
grant update on bgak_t to tiptop;
grant delete on bgak_t to tiptop;
grant insert on bgak_t to tiptop;

exit;
