/* 
================================================================================
檔案代號:ooag_t
檔案名稱:员工数据档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table ooag_t
(
ooagstus       varchar2(10)      ,/* 状态码 */
ooagent       number(5)      ,/* 企业编号 */
ooag001       varchar2(20)      ,/* 员工编号 */
ooag002       varchar2(20)      ,/* 联络对象识别码 */
ooag003       varchar2(10)      ,/* 归属部门 */
ooag004       varchar2(10)      ,/* 归属营运据点 */
ooag005       varchar2(10)      ,/* 职称 */
ooag006       varchar2(15)      ,/* 银行行号/邮局局号 */
ooag007       varchar2(30)      ,/* 帐号 */
ooagownid       varchar2(20)      ,/* 资料所有者 */
ooagowndp       varchar2(10)      ,/* 资料所有部门 */
ooagcrtid       varchar2(20)      ,/* 资料录入者 */
ooagcrtdp       varchar2(10)      ,/* 资料录入部门 */
ooagcrtdt       timestamp(0)      ,/* 资料创建日 */
ooagmodid       varchar2(20)      ,/* 资料更改者 */
ooagmoddt       timestamp(0)      ,/* 最近更改日 */
ooag008       varchar2(80)      ,/* 姓氏 */
ooag009       varchar2(80)      ,/* 中间名 */
ooag010       varchar2(80)      ,/* 名字 */
ooag011       varchar2(255)      ,/* 全名 */
ooag012       varchar2(80)      ,/* 参考名 */
ooag013       varchar2(80)      ,/* 暱称 */
ooag014       varchar2(10)      ,/* 助记码 */
ooagud001       varchar2(40)      ,/* 自定义字段(文本)001 */
ooagud002       varchar2(40)      ,/* 自定义字段(文本)002 */
ooagud003       varchar2(40)      ,/* 自定义字段(文本)003 */
ooagud004       varchar2(40)      ,/* 自定义字段(文本)004 */
ooagud005       varchar2(40)      ,/* 自定义字段(文本)005 */
ooagud006       varchar2(40)      ,/* 自定义字段(文本)006 */
ooagud007       varchar2(40)      ,/* 自定义字段(文本)007 */
ooagud008       varchar2(40)      ,/* 自定义字段(文本)008 */
ooagud009       varchar2(40)      ,/* 自定义字段(文本)009 */
ooagud010       varchar2(40)      ,/* 自定义字段(文本)010 */
ooagud011       number(20,6)      ,/* 自定义字段(数字)011 */
ooagud012       number(20,6)      ,/* 自定义字段(数字)012 */
ooagud013       number(20,6)      ,/* 自定义字段(数字)013 */
ooagud014       number(20,6)      ,/* 自定义字段(数字)014 */
ooagud015       number(20,6)      ,/* 自定义字段(数字)015 */
ooagud016       number(20,6)      ,/* 自定义字段(数字)016 */
ooagud017       number(20,6)      ,/* 自定义字段(数字)017 */
ooagud018       number(20,6)      ,/* 自定义字段(数字)018 */
ooagud019       number(20,6)      ,/* 自定义字段(数字)019 */
ooagud020       number(20,6)      ,/* 自定义字段(数字)020 */
ooagud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
ooagud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
ooagud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
ooagud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
ooagud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
ooagud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
ooagud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
ooagud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
ooagud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
ooagud030       timestamp(0)      ,/* 自定义字段(日期时间)030 */
ooag015       varchar2(10)      ,/* 员工核决层级 */
ooag016       varchar2(1)      ,/* 是否启用代理人机制 */
ooag017       varchar2(20)      ,/* 代理人员工编号 */
ooag018       varchar2(20)      /* 直属主管员工编号 */
);
alter table ooag_t add constraint ooag_pk primary key (ooagent,ooag001) enable validate;

create  index ooag_01 on ooag_t (ooag002);
create  index ooag_02 on ooag_t (ooag003);
create  index ooag_03 on ooag_t (ooag004);
create unique index ooag_pk on ooag_t (ooagent,ooag001);

grant select on ooag_t to tiptop;
grant update on ooag_t to tiptop;
grant delete on ooag_t to tiptop;
grant insert on ooag_t to tiptop;

exit;
