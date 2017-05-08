/* 
================================================================================
檔案代號:bggk_t
檔案名稱:用工需求主档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table bggk_t
(
bggkent       number(5)      ,/* 企业编号 */
bggk001       varchar2(10)      ,/* 预算编号 */
bggk002       varchar2(10)      ,/* 预算组织 */
bggk003       number(5,0)      ,/* 预算起始期别 */
bggk004       number(5,0)      ,/* 预算终止期别 */
bggk005       varchar2(10)      ,/* 工资方案 */
bggkstus       varchar2(10)      ,/* 状态码 */
bggkownid       varchar2(20)      ,/* 资料所有者 */
bggkowndp       varchar2(10)      ,/* 资料所有部门 */
bggkcrtid       varchar2(20)      ,/* 资料录入者 */
bggkcrtdp       varchar2(10)      ,/* 资料录入部门 */
bggkcrtdt       timestamp(0)      ,/* 资料创建日 */
bggkmodid       varchar2(20)      ,/* 资料更改者 */
bggkmoddt       timestamp(0)      ,/* 最近更改日 */
bggkcnfid       varchar2(20)      ,/* 资料审核者 */
bggkcnfdt       timestamp(0)      ,/* 数据审核日 */
bggkud001       varchar2(40)      ,/* 自定义字段(文本)001 */
bggkud002       varchar2(40)      ,/* 自定义字段(文本)002 */
bggkud003       varchar2(40)      ,/* 自定义字段(文本)003 */
bggkud004       varchar2(40)      ,/* 自定义字段(文本)004 */
bggkud005       varchar2(40)      ,/* 自定义字段(文本)005 */
bggkud006       varchar2(40)      ,/* 自定义字段(文本)006 */
bggkud007       varchar2(40)      ,/* 自定义字段(文本)007 */
bggkud008       varchar2(40)      ,/* 自定义字段(文本)008 */
bggkud009       varchar2(40)      ,/* 自定义字段(文本)009 */
bggkud010       varchar2(40)      ,/* 自定义字段(文本)010 */
bggkud011       number(20,6)      ,/* 自定义字段(数字)011 */
bggkud012       number(20,6)      ,/* 自定义字段(数字)012 */
bggkud013       number(20,6)      ,/* 自定义字段(数字)013 */
bggkud014       number(20,6)      ,/* 自定义字段(数字)014 */
bggkud015       number(20,6)      ,/* 自定义字段(数字)015 */
bggkud016       number(20,6)      ,/* 自定义字段(数字)016 */
bggkud017       number(20,6)      ,/* 自定义字段(数字)017 */
bggkud018       number(20,6)      ,/* 自定义字段(数字)018 */
bggkud019       number(20,6)      ,/* 自定义字段(数字)019 */
bggkud020       number(20,6)      ,/* 自定义字段(数字)020 */
bggkud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
bggkud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
bggkud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
bggkud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
bggkud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
bggkud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
bggkud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
bggkud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
bggkud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
bggkud030       timestamp(0)      /* 自定义字段(日期时间)030 */
);
alter table bggk_t add constraint bggk_pk primary key (bggkent,bggk001,bggk002,bggk003,bggk004) enable validate;

create unique index bggk_pk on bggk_t (bggkent,bggk001,bggk002,bggk003,bggk004);

grant select on bggk_t to tiptop;
grant update on bggk_t to tiptop;
grant delete on bggk_t to tiptop;
grant insert on bggk_t to tiptop;

exit;
