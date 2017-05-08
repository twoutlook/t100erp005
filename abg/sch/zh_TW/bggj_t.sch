/* 
================================================================================
檔案代號:bggj_t
檔案名稱:用工需求单身
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table bggj_t
(
bggjent       number(5)      ,/* 企业编号 */
bggj001       varchar2(10)      ,/* 预算编号 */
bggj002       varchar2(10)      ,/* 预算组织 */
bggj003       number(5,0)      ,/* 预算起始期别 */
bggj004       number(5,0)      ,/* 预算终止期别 */
bggjseq       number(10,0)      ,/* 项次 */
bggj005       varchar2(10)      ,/* 职级 */
bggj006       varchar2(10)      ,/* 职等 */
bggj007       varchar2(10)      ,/* 用工属性 */
bggj008       number(10,0)      ,/* 用工人数 */
bggjud001       varchar2(40)      ,/* 自定义字段(文本)001 */
bggjud002       varchar2(40)      ,/* 自定义字段(文本)002 */
bggjud003       varchar2(40)      ,/* 自定义字段(文本)003 */
bggjud004       varchar2(40)      ,/* 自定义字段(文本)004 */
bggjud005       varchar2(40)      ,/* 自定义字段(文本)005 */
bggjud006       varchar2(40)      ,/* 自定义字段(文本)006 */
bggjud007       varchar2(40)      ,/* 自定义字段(文本)007 */
bggjud008       varchar2(40)      ,/* 自定义字段(文本)008 */
bggjud009       varchar2(40)      ,/* 自定义字段(文本)009 */
bggjud010       varchar2(40)      ,/* 自定义字段(文本)010 */
bggjud011       number(20,6)      ,/* 自定义字段(数字)011 */
bggjud012       number(20,6)      ,/* 自定义字段(数字)012 */
bggjud013       number(20,6)      ,/* 自定义字段(数字)013 */
bggjud014       number(20,6)      ,/* 自定义字段(数字)014 */
bggjud015       number(20,6)      ,/* 自定义字段(数字)015 */
bggjud016       number(20,6)      ,/* 自定义字段(数字)016 */
bggjud017       number(20,6)      ,/* 自定义字段(数字)017 */
bggjud018       number(20,6)      ,/* 自定义字段(数字)018 */
bggjud019       number(20,6)      ,/* 自定义字段(数字)019 */
bggjud020       number(20,6)      ,/* 自定义字段(数字)020 */
bggjud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
bggjud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
bggjud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
bggjud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
bggjud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
bggjud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
bggjud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
bggjud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
bggjud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
bggjud030       timestamp(0)      /* 自定义字段(日期时间)030 */
);
alter table bggj_t add constraint bggj_pk primary key (bggjent,bggj001,bggj002,bggj003,bggj004,bggjseq) enable validate;

create unique index bggj_pk on bggj_t (bggjent,bggj001,bggj002,bggj003,bggj004,bggjseq);

grant select on bggj_t to tiptop;
grant update on bggj_t to tiptop;
grant delete on bggj_t to tiptop;
grant insert on bggj_t to tiptop;

exit;
