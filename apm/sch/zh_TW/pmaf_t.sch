/* 
================================================================================
檔案代號:pmaf_t
檔案名稱:交易对象往来银行档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pmaf_t
(
pmafent       number(5)      ,/* 企业编号 */
pmaf001       varchar2(10)      ,/* 交易对象编号 */
pmaf002       varchar2(15)      ,/* 银行编号 */
pmaf003       varchar2(30)      ,/* 银行账户 */
pmaf004       varchar2(255)      ,/* 账户名称 */
pmaf005       varchar2(15)      ,/* SWIFT CODE */
pmaf006       varchar2(255)      ,/* 备注 */
pmaf007       varchar2(40)      ,/* IBAN CODE */
pmaf008       varchar2(1)      ,/* 主要收款账户 */
pmaf009       varchar2(1)      ,/* 主要付款账户 */
pmafstus       varchar2(10)      ,/* 状态码 */
pmafud001       varchar2(40)      ,/* 自定义字段(文本)001 */
pmafud002       varchar2(40)      ,/* 自定义字段(文本)002 */
pmafud003       varchar2(40)      ,/* 自定义字段(文本)003 */
pmafud004       varchar2(40)      ,/* 自定义字段(文本)004 */
pmafud005       varchar2(40)      ,/* 自定义字段(文本)005 */
pmafud006       varchar2(40)      ,/* 自定义字段(文本)006 */
pmafud007       varchar2(40)      ,/* 自定义字段(文本)007 */
pmafud008       varchar2(40)      ,/* 自定义字段(文本)008 */
pmafud009       varchar2(40)      ,/* 自定义字段(文本)009 */
pmafud010       varchar2(40)      ,/* 自定义字段(文本)010 */
pmafud011       number(20,6)      ,/* 自定义字段(数字)011 */
pmafud012       number(20,6)      ,/* 自定义字段(数字)012 */
pmafud013       number(20,6)      ,/* 自定义字段(数字)013 */
pmafud014       number(20,6)      ,/* 自定义字段(数字)014 */
pmafud015       number(20,6)      ,/* 自定义字段(数字)015 */
pmafud016       number(20,6)      ,/* 自定义字段(数字)016 */
pmafud017       number(20,6)      ,/* 自定义字段(数字)017 */
pmafud018       number(20,6)      ,/* 自定义字段(数字)018 */
pmafud019       number(20,6)      ,/* 自定义字段(数字)019 */
pmafud020       number(20,6)      ,/* 自定义字段(数字)020 */
pmafud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
pmafud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
pmafud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
pmafud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
pmafud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
pmafud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
pmafud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
pmafud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
pmafud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
pmafud030       timestamp(0)      ,/* 自定义字段(日期时间)030 */
pmaf010       varchar2(1)      ,/* 對公否 */
pmaf011       varchar2(20)      /* 铺位编号 */
);
alter table pmaf_t add constraint pmaf_pk primary key (pmafent,pmaf001,pmaf002,pmaf003) enable validate;

create unique index pmaf_pk on pmaf_t (pmafent,pmaf001,pmaf002,pmaf003);

grant select on pmaf_t to tiptop;
grant update on pmaf_t to tiptop;
grant delete on pmaf_t to tiptop;
grant insert on pmaf_t to tiptop;

exit;
