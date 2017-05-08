/* 
================================================================================
檔案代號:mmbn_t
檔案名稱:会员卡续期异动单身档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table mmbn_t
(
mmbnent       number(5)      ,/* 企业编号 */
mmbnsite       varchar2(10)      ,/* 营运据点 */
mmbnunit       varchar2(10)      ,/* 应用组织 */
mmbndocno       varchar2(20)      ,/* 单号 */
mmbnseq       number(10,0)      ,/* 项次 */
mmbn001       varchar2(30)      ,/* 会员卡号 */
mmbn002       varchar2(30)      ,/* 会员编号 */
mmbn003       date      ,/* 原有效期 */
mmbn004       date      ,/* 新有效期 */
mmbn005       varchar2(10)      ,/* 理由码 */
mmbn006       varchar2(10)      ,/* NO USE */
mmbnud001       varchar2(40)      ,/* 自定义字段(文本)001 */
mmbnud002       varchar2(40)      ,/* 自定义字段(文本)002 */
mmbnud003       varchar2(40)      ,/* 自定义字段(文本)003 */
mmbnud004       varchar2(40)      ,/* 自定义字段(文本)004 */
mmbnud005       varchar2(40)      ,/* 自定义字段(文本)005 */
mmbnud006       varchar2(40)      ,/* 自定义字段(文本)006 */
mmbnud007       varchar2(40)      ,/* 自定义字段(文本)007 */
mmbnud008       varchar2(40)      ,/* 自定义字段(文本)008 */
mmbnud009       varchar2(40)      ,/* 自定义字段(文本)009 */
mmbnud010       varchar2(40)      ,/* 自定义字段(文本)010 */
mmbnud011       number(20,6)      ,/* 自定义字段(数字)011 */
mmbnud012       number(20,6)      ,/* 自定义字段(数字)012 */
mmbnud013       number(20,6)      ,/* 自定义字段(数字)013 */
mmbnud014       number(20,6)      ,/* 自定义字段(数字)014 */
mmbnud015       number(20,6)      ,/* 自定义字段(数字)015 */
mmbnud016       number(20,6)      ,/* 自定义字段(数字)016 */
mmbnud017       number(20,6)      ,/* 自定义字段(数字)017 */
mmbnud018       number(20,6)      ,/* 自定义字段(数字)018 */
mmbnud019       number(20,6)      ,/* 自定义字段(数字)019 */
mmbnud020       number(20,6)      ,/* 自定义字段(数字)020 */
mmbnud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
mmbnud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
mmbnud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
mmbnud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
mmbnud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
mmbnud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
mmbnud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
mmbnud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
mmbnud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
mmbnud030       timestamp(0)      /* 自定义字段(日期时间)030 */
);
alter table mmbn_t add constraint mmbn_pk primary key (mmbnent,mmbndocno,mmbnseq) enable validate;

create  index mmbn_n1 on mmbn_t (mmbn001,mmbnent);
create unique index mmbn_pk on mmbn_t (mmbnent,mmbndocno,mmbnseq);

grant select on mmbn_t to tiptop;
grant update on mmbn_t to tiptop;
grant delete on mmbn_t to tiptop;
grant insert on mmbn_t to tiptop;

exit;
