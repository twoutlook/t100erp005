/* 
================================================================================
檔案代號:icae_t
檔案名稱:多角贸易财务数据档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table icae_t
(
icaeent       number(5)      ,/* 企业编号 */
icaesite       varchar2(10)      ,/* 营运据点 */
icae001       varchar2(10)      ,/* 流程编号 */
icae002       number(5,0)      ,/* 站别 */
icae003       varchar2(5)      ,/* 应收单别 */
icae004       varchar2(5)      ,/* 应付单别 */
icae005       varchar2(10)      ,/* 责任中心 */
icae007       varchar2(5)      ,/* 应收折让单别 */
icae008       varchar2(5)      ,/* 应付折让单别 */
icae009       varchar2(10)      ,/* 收款条件 */
icae010       varchar2(10)      ,/* 付款条件 */
icae011       varchar2(10)      ,/* 订单税种 */
icae012       varchar2(10)      ,/* 采购税种 */
icae013       varchar2(10)      ,/* 订单交易条件 */
icae014       varchar2(10)      ,/* 订单发票类型 */
icae015       varchar2(10)      ,/* 采购单交易条件 */
icae016       varchar2(10)      ,/* 账务中心 */
icae017       varchar2(10)      ,/* 部门 */
icae018       varchar2(10)      ,/* 应收账款类别 */
icae019       varchar2(10)      ,/* 发票开立方式 */
icaeud001       varchar2(40)      ,/* 自定义字段(文本)001 */
icaeud002       varchar2(40)      ,/* 自定义字段(文本)002 */
icaeud003       varchar2(40)      ,/* 自定义字段(文本)003 */
icaeud004       varchar2(40)      ,/* 自定义字段(文本)004 */
icaeud005       varchar2(40)      ,/* 自定义字段(文本)005 */
icaeud006       varchar2(40)      ,/* 自定义字段(文本)006 */
icaeud007       varchar2(40)      ,/* 自定义字段(文本)007 */
icaeud008       varchar2(40)      ,/* 自定义字段(文本)008 */
icaeud009       varchar2(40)      ,/* 自定义字段(文本)009 */
icaeud010       varchar2(40)      ,/* 自定义字段(文本)010 */
icaeud011       number(20,6)      ,/* 自定义字段(数字)011 */
icaeud012       number(20,6)      ,/* 自定义字段(数字)012 */
icaeud013       number(20,6)      ,/* 自定义字段(数字)013 */
icaeud014       number(20,6)      ,/* 自定义字段(数字)014 */
icaeud015       number(20,6)      ,/* 自定义字段(数字)015 */
icaeud016       number(20,6)      ,/* 自定义字段(数字)016 */
icaeud017       number(20,6)      ,/* 自定义字段(数字)017 */
icaeud018       number(20,6)      ,/* 自定义字段(数字)018 */
icaeud019       number(20,6)      ,/* 自定义字段(数字)019 */
icaeud020       number(20,6)      ,/* 自定义字段(数字)020 */
icaeud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
icaeud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
icaeud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
icaeud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
icaeud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
icaeud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
icaeud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
icaeud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
icaeud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
icaeud030       timestamp(0)      ,/* 自定义字段(日期时间)030 */
icae020       varchar2(10)      ,/* 应付账款类别 */
icae021       varchar2(10)      /* 采购发票类型 */
);
alter table icae_t add constraint icae_pk primary key (icaeent,icae001,icae002) enable validate;

create unique index icae_pk on icae_t (icaeent,icae001,icae002);

grant select on icae_t to tiptop;
grant update on icae_t to tiptop;
grant delete on icae_t to tiptop;
grant insert on icae_t to tiptop;

exit;
