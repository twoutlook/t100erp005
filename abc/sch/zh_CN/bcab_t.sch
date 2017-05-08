/* 
================================================================================
檔案代號:bcab_t
檔案名稱:条码信息明细档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table bcab_t
(
bcabent       number(5)      ,/* 企业编号 */
bcabsite       varchar2(10)      ,/* 营运据点 */
bcabseq       number(10,0)      ,/* 项次 */
bcab000       number(5,0)      ,/* 版次 */
bcab001       varchar2(255)      ,/* 条码编号 */
bcab002       varchar2(10)      ,/* 库位 */
bcab003       varchar2(10)      ,/* 储位 */
bcab004       varchar2(30)      ,/* 批号 */
bcab005       varchar2(30)      ,/* 制造批号 */
bcab006       varchar2(30)      ,/* 制造序号 */
bcab007       number(20,6)      ,/* 库存数量 */
bcabud001       varchar2(40)      ,/* 自定义字段(文本)001 */
bcabud002       varchar2(40)      ,/* 自定义字段(文本)002 */
bcabud003       varchar2(40)      ,/* 自定义字段(文本)003 */
bcabud004       varchar2(40)      ,/* 自定义字段(文本)004 */
bcabud005       varchar2(40)      ,/* 自定义字段(文本)005 */
bcabud006       varchar2(40)      ,/* 自定义字段(文本)006 */
bcabud007       varchar2(40)      ,/* 自定义字段(文本)007 */
bcabud008       varchar2(40)      ,/* 自定义字段(文本)008 */
bcabud009       varchar2(40)      ,/* 自定义字段(文本)009 */
bcabud010       varchar2(40)      ,/* 自定义字段(文本)010 */
bcabud011       number(20,6)      ,/* 自定义字段(数字)011 */
bcabud012       number(20,6)      ,/* 自定义字段(数字)012 */
bcabud013       number(20,6)      ,/* 自定义字段(数字)013 */
bcabud014       number(20,6)      ,/* 自定义字段(数字)014 */
bcabud015       number(20,6)      ,/* 自定义字段(数字)015 */
bcabud016       number(20,6)      ,/* 自定义字段(数字)016 */
bcabud017       number(20,6)      ,/* 自定义字段(数字)017 */
bcabud018       number(20,6)      ,/* 自定义字段(数字)018 */
bcabud019       number(20,6)      ,/* 自定义字段(数字)019 */
bcabud020       number(20,6)      ,/* 自定义字段(数字)020 */
bcabud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
bcabud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
bcabud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
bcabud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
bcabud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
bcabud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
bcabud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
bcabud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
bcabud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
bcabud030       timestamp(0)      ,/* 自定义字段(日期时间)030 */
bcab008       varchar2(30)      ,/* 库存管理特征 */
bcab009       varchar2(10)      ,/* 库存单位 */
bcab010       date      /* 第一次入库日期 */
);
alter table bcab_t add constraint bcab_pk primary key (bcabent,bcabsite,bcab000,bcab001,bcab002,bcab003,bcab004,bcab008,bcab009) enable validate;

create unique index bcab_pk on bcab_t (bcabent,bcabsite,bcab000,bcab001,bcab002,bcab003,bcab004,bcab008,bcab009);

grant select on bcab_t to tiptop;
grant update on bcab_t to tiptop;
grant delete on bcab_t to tiptop;
grant insert on bcab_t to tiptop;

exit;
