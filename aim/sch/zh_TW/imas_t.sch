/* 
================================================================================
檔案代號:imas_t
檔案名稱:料件库存特征选项档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table imas_t
(
imasent       number(5)      ,/* 企业编号 */
imas001       varchar2(40)      ,/* 料件编号 */
imas002       varchar2(10)      ,/* 特征类型 */
imas003       varchar2(30)      ,/* 特征值(起) */
imas004       varchar2(30)      ,/* 特征值(讫) */
imasud001       varchar2(40)      ,/* 自定义字段(文本)001 */
imasud002       varchar2(40)      ,/* 自定义字段(文本)002 */
imasud003       varchar2(40)      ,/* 自定义字段(文本)003 */
imasud004       varchar2(40)      ,/* 自定义字段(文本)004 */
imasud005       varchar2(40)      ,/* 自定义字段(文本)005 */
imasud006       varchar2(40)      ,/* 自定义字段(文本)006 */
imasud007       varchar2(40)      ,/* 自定义字段(文本)007 */
imasud008       varchar2(40)      ,/* 自定义字段(文本)008 */
imasud009       varchar2(40)      ,/* 自定义字段(文本)009 */
imasud010       varchar2(40)      ,/* 自定义字段(文本)010 */
imasud011       number(20,6)      ,/* 自定义字段(数字)011 */
imasud012       number(20,6)      ,/* 自定义字段(数字)012 */
imasud013       number(20,6)      ,/* 自定义字段(数字)013 */
imasud014       number(20,6)      ,/* 自定义字段(数字)014 */
imasud015       number(20,6)      ,/* 自定义字段(数字)015 */
imasud016       number(20,6)      ,/* 自定义字段(数字)016 */
imasud017       number(20,6)      ,/* 自定义字段(数字)017 */
imasud018       number(20,6)      ,/* 自定义字段(数字)018 */
imasud019       number(20,6)      ,/* 自定义字段(数字)019 */
imasud020       number(20,6)      ,/* 自定义字段(数字)020 */
imasud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
imasud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
imasud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
imasud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
imasud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
imasud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
imasud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
imasud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
imasud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
imasud030       timestamp(0)      /* 自定义字段(日期时间)030 */
);
alter table imas_t add constraint imas_pk primary key (imasent,imas001,imas002,imas003) enable validate;

create unique index imas_pk on imas_t (imasent,imas001,imas002,imas003);

grant select on imas_t to tiptop;
grant update on imas_t to tiptop;
grant delete on imas_t to tiptop;
grant insert on imas_t to tiptop;

exit;
