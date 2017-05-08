/* 
================================================================================
檔案代號:faar_t
檔案名稱:资产账套列管列账转换历程档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table faar_t
(
faarent       number(5)      ,/* 企业代码 */
faarld       varchar2(5)      ,/* 账套编号 */
faarsite       varchar2(10)      ,/* 营运据点 */
faar000       varchar2(10)      ,/* 转换批号 */
faar001       date      ,/* 转换日期 */
faar002       varchar2(20)      ,/* 财产编号 */
faar003       varchar2(10)      ,/* 卡片编号 */
faar004       varchar2(20)      ,/* 附号 */
faar005       varchar2(100)      ,/* 转换前 */
faar006       varchar2(100)      ,/* 转换后 */
faarud001       varchar2(40)      ,/* 自定义字段(文本)001 */
faarud002       varchar2(40)      ,/* 自定义字段(文本)002 */
faarud003       varchar2(40)      ,/* 自定义字段(文本)003 */
faarud004       varchar2(40)      ,/* 自定义字段(文本)004 */
faarud005       varchar2(40)      ,/* 自定义字段(文本)005 */
faarud006       varchar2(40)      ,/* 自定义字段(文本)006 */
faarud007       varchar2(40)      ,/* 自定义字段(文本)007 */
faarud008       varchar2(40)      ,/* 自定义字段(文本)008 */
faarud009       varchar2(40)      ,/* 自定义字段(文本)009 */
faarud010       varchar2(40)      ,/* 自定义字段(文本)010 */
faarud011       number(20,6)      ,/* 自定义字段(数字)011 */
faarud012       number(20,6)      ,/* 自定义字段(数字)012 */
faarud013       number(20,6)      ,/* 自定义字段(数字)013 */
faarud014       number(20,6)      ,/* 自定义字段(数字)014 */
faarud015       number(20,6)      ,/* 自定义字段(数字)015 */
faarud016       number(20,6)      ,/* 自定义字段(数字)016 */
faarud017       number(20,6)      ,/* 自定义字段(数字)017 */
faarud018       number(20,6)      ,/* 自定义字段(数字)018 */
faarud019       number(20,6)      ,/* 自定义字段(数字)019 */
faarud020       number(20,6)      ,/* 自定义字段(数字)020 */
faarud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
faarud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
faarud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
faarud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
faarud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
faarud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
faarud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
faarud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
faarud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
faarud030       timestamp(0)      /* 自定义字段(日期时间)030 */
);
alter table faar_t add constraint faar_pk primary key (faarent,faarld,faar000,faar001,faar002,faar003,faar004) enable validate;

create unique index faar_pk on faar_t (faarent,faarld,faar000,faar001,faar002,faar003,faar004);

grant select on faar_t to tiptop;
grant update on faar_t to tiptop;
grant delete on faar_t to tiptop;
grant insert on faar_t to tiptop;

exit;
