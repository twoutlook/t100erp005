/* 
================================================================================
檔案代號:indk_t
檔案名稱:多库储批配送明细档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table indk_t
(
indkent       number(5)      ,/* 企业编号 */
indksite       varchar2(10)      ,/* 营运据点 */
indkunit       varchar2(10)      ,/* 应用组织 */
indkdocno       varchar2(20)      ,/* 单据编号 */
indkseq       number(10,0)      ,/* 项次 */
indkseq1       number(10,0)      ,/* 分批序 */
indk001       varchar2(40)      ,/* 商品编号 */
indk002       varchar2(256)      ,/* 产品特征 */
indk003       varchar2(10)      ,/* 分批要货包装单位 */
indk004       number(20,6)      ,/* 分批要货包装数量 */
indk005       varchar2(10)      ,/* 库存单位 */
indk006       number(20,6)      ,/* 分批要货数量 */
indk007       varchar2(10)      ,/* 发货组织 */
indk008       varchar2(10)      ,/* 发货库位 */
indk009       varchar2(10)      ,/* 发货储位 */
indk010       varchar2(30)      ,/* 发货批号 */
indk011       varchar2(10)      ,/* 收货组织 */
indk012       varchar2(10)      ,/* 收货库位 */
indk013       varchar2(10)      ,/* 收货储位 */
indk014       varchar2(30)      ,/* 收货批号 */
indk015       varchar2(30)      ,/* 库存管理特征 */
indkud001       varchar2(40)      ,/* 自定义字段(文本)001 */
indkud002       varchar2(40)      ,/* 自定义字段(文本)002 */
indkud003       varchar2(40)      ,/* 自定义字段(文本)003 */
indkud004       varchar2(40)      ,/* 自定义字段(文本)004 */
indkud005       varchar2(40)      ,/* 自定义字段(文本)005 */
indkud006       varchar2(40)      ,/* 自定义字段(文本)006 */
indkud007       varchar2(40)      ,/* 自定义字段(文本)007 */
indkud008       varchar2(40)      ,/* 自定义字段(文本)008 */
indkud009       varchar2(40)      ,/* 自定义字段(文本)009 */
indkud010       varchar2(40)      ,/* 自定义字段(文本)010 */
indkud011       number(20,6)      ,/* 自定义字段(数字)011 */
indkud012       number(20,6)      ,/* 自定义字段(数字)012 */
indkud013       number(20,6)      ,/* 自定义字段(数字)013 */
indkud014       number(20,6)      ,/* 自定义字段(数字)014 */
indkud015       number(20,6)      ,/* 自定义字段(数字)015 */
indkud016       number(20,6)      ,/* 自定义字段(数字)016 */
indkud017       number(20,6)      ,/* 自定义字段(数字)017 */
indkud018       number(20,6)      ,/* 自定义字段(数字)018 */
indkud019       number(20,6)      ,/* 自定义字段(数字)019 */
indkud020       number(20,6)      ,/* 自定义字段(数字)020 */
indkud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
indkud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
indkud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
indkud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
indkud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
indkud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
indkud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
indkud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
indkud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
indkud030       timestamp(0)      ,/* 自定义字段(日期时间)030 */
indk016       number(20,6)      /* 已装箱量 */
);
alter table indk_t add constraint indk_pk primary key (indkent,indkdocno,indkseq,indkseq1) enable validate;

create unique index indk_pk on indk_t (indkent,indkdocno,indkseq,indkseq1);

grant select on indk_t to tiptop;
grant update on indk_t to tiptop;
grant delete on indk_t to tiptop;
grant insert on indk_t to tiptop;

exit;
