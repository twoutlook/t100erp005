/* 
================================================================================
檔案代號:indj_t
檔案名稱:配送单身明细档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table indj_t
(
indjent       number(5)      ,/* 企业编号 */
indjsite       varchar2(10)      ,/* 营运据点 */
indjunit       varchar2(10)      ,/* 应用组织 */
indjdocno       varchar2(20)      ,/* 单据编号 */
indjseq       number(10,0)      ,/* 项次 */
indj001       varchar2(20)      ,/* 来源要货单号 */
indj002       number(10,0)      ,/* 来源要货项次 */
indj003       varchar2(10)      ,/* 要货组织 */
indj004       varchar2(40)      ,/* 商品编号 */
indj005       varchar2(256)      ,/* 产品特征 */
indj006       varchar2(10)      ,/* 要货包装单位 */
indj007       number(20,6)      ,/* 要货包装数量 */
indj008       varchar2(10)      ,/* 库存单位 */
indj009       number(20,6)      ,/* 要货数量 */
indj010       number(20,6)      ,/* 此次分配数量 */
indj011       number(20,6)      ,/* 未分配数量 */
indj012       varchar2(10)      ,/* 发货库位 */
indj013       varchar2(10)      ,/* 发货储位 */
indj014       varchar2(30)      ,/* 发货批号 */
indj015       varchar2(10)      ,/* 收货库位 */
indj016       varchar2(10)      ,/* 收货储位 */
indj017       varchar2(30)      ,/* 收货批号 */
indj018       varchar2(1)      ,/* 多库储批发货 */
indjud001       varchar2(40)      ,/* 自定义字段(文本)001 */
indjud002       varchar2(40)      ,/* 自定义字段(文本)002 */
indjud003       varchar2(40)      ,/* 自定义字段(文本)003 */
indjud004       varchar2(40)      ,/* 自定义字段(文本)004 */
indjud005       varchar2(40)      ,/* 自定义字段(文本)005 */
indjud006       varchar2(40)      ,/* 自定义字段(文本)006 */
indjud007       varchar2(40)      ,/* 自定义字段(文本)007 */
indjud008       varchar2(40)      ,/* 自定义字段(文本)008 */
indjud009       varchar2(40)      ,/* 自定义字段(文本)009 */
indjud010       varchar2(40)      ,/* 自定义字段(文本)010 */
indjud011       number(20,6)      ,/* 自定义字段(数字)011 */
indjud012       number(20,6)      ,/* 自定义字段(数字)012 */
indjud013       number(20,6)      ,/* 自定义字段(数字)013 */
indjud014       number(20,6)      ,/* 自定义字段(数字)014 */
indjud015       number(20,6)      ,/* 自定义字段(数字)015 */
indjud016       number(20,6)      ,/* 自定义字段(数字)016 */
indjud017       number(20,6)      ,/* 自定义字段(数字)017 */
indjud018       number(20,6)      ,/* 自定义字段(数字)018 */
indjud019       number(20,6)      ,/* 自定义字段(数字)019 */
indjud020       number(20,6)      ,/* 自定义字段(数字)020 */
indjud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
indjud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
indjud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
indjud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
indjud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
indjud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
indjud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
indjud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
indjud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
indjud030       timestamp(0)      ,/* 自定义字段(日期时间)030 */
indj019       varchar2(30)      ,/* 库存管理特征 */
indj020       varchar2(10)      ,/* 需求对象 */
indj021       varchar2(10)      ,/* 抛单状态 */
indj022       number(20,6)      ,/* 已装箱量 */
indj023       varchar2(10)      /* 结束码 */
);
alter table indj_t add constraint indj_pk primary key (indjent,indjdocno,indjseq) enable validate;

create unique index indj_pk on indj_t (indjent,indjdocno,indjseq);

grant select on indj_t to tiptop;
grant update on indj_t to tiptop;
grant delete on indj_t to tiptop;
grant insert on indj_t to tiptop;

exit;
