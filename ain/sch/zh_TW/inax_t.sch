/* 
================================================================================
檔案代號:inax_t
檔案名稱:库存在拣明细档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table inax_t
(
inaxent       number(5)      ,/* 企业代码 */
inax001       varchar2(10)      ,/* 计算项目 */
inax002       varchar2(1)      ,/* 计算加减项 */
inax003       timestamp(0)      ,/* 异动日期 */
inax004       varchar2(10)      ,/* 异动据点 */
inax005       varchar2(20)      ,/* 异动单号 */
inax006       number(10,0)      ,/* 异动项次 */
inax007       varchar2(10)      ,/* 需求据点 */
inax008       varchar2(20)      ,/* 需求单号 */
inax009       number(10,0)      ,/* 需求项次 */
inax010       varchar2(40)      ,/* 商品编号 */
inax011       varchar2(256)      ,/* 产品特征 */
inax012       varchar2(30)      ,/* 库存特征 */
inax013       varchar2(10)      ,/* 库存单位 */
inax014       number(20,6)      ,/* 数量 */
inax015       varchar2(10)      ,/* 在拣库位 */
inax016       varchar2(10)      ,/* 采购方式 */
inaxud001       varchar2(40)      ,/* 自定义字段(文本)001 */
inaxud002       varchar2(40)      ,/* 自定义字段(文本)002 */
inaxud003       varchar2(40)      ,/* 自定义字段(文本)003 */
inaxud004       varchar2(40)      ,/* 自定义字段(文本)004 */
inaxud005       varchar2(40)      ,/* 自定义字段(文本)005 */
inaxud006       varchar2(40)      ,/* 自定义字段(文本)006 */
inaxud007       varchar2(40)      ,/* 自定义字段(文本)007 */
inaxud008       varchar2(40)      ,/* 自定义字段(文本)008 */
inaxud009       varchar2(40)      ,/* 自定义字段(文本)009 */
inaxud010       varchar2(40)      ,/* 自定义字段(文本)010 */
inaxud011       number(20,6)      ,/* 自定义字段(数字)011 */
inaxud012       number(20,6)      ,/* 自定义字段(数字)012 */
inaxud013       number(20,6)      ,/* 自定义字段(数字)013 */
inaxud014       number(20,6)      ,/* 自定义字段(数字)014 */
inaxud015       number(20,6)      ,/* 自定义字段(数字)015 */
inaxud016       number(20,6)      ,/* 自定义字段(数字)016 */
inaxud017       number(20,6)      ,/* 自定义字段(数字)017 */
inaxud018       number(20,6)      ,/* 自定义字段(数字)018 */
inaxud019       number(20,6)      ,/* 自定义字段(数字)019 */
inaxud020       number(20,6)      ,/* 自定义字段(数字)020 */
inaxud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
inaxud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
inaxud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
inaxud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
inaxud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
inaxud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
inaxud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
inaxud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
inaxud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
inaxud030       timestamp(0)      ,/* 自定义字段(日期时间)030 */
inax017       varchar2(10)      /* 配送中心 */
);
alter table inax_t add constraint inax_pk primary key (inaxent,inax004,inax005,inax006) enable validate;

create unique index inax_pk on inax_t (inaxent,inax004,inax005,inax006);

grant select on inax_t to tiptop;
grant update on inax_t to tiptop;
grant delete on inax_t to tiptop;
grant insert on inax_t to tiptop;

exit;
