/* 
================================================================================
檔案代號:pmcp_t
檔案名稱:铺货单明细档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pmcp_t
(
pmcpent       number(5)      ,/* 企业编号 */
pmcpsite       varchar2(10)      ,/* 营运据点 */
pmcpunit       varchar2(10)      ,/* 应用组织 */
pmcpdocno       varchar2(20)      ,/* 铺货单号 */
pmcpseq       number(10,0)      ,/* 项次 */
pmcp001       varchar2(40)      ,/* 商品编号 */
pmcp002       varchar2(40)      ,/* 商品条码 */
pmcp003       varchar2(256)      ,/* 产品特征 */
pmcp004       number(20,6)      ,/* 铺货数量 */
pmcp005       varchar2(10)      ,/* 铺货单位 */
pmcp006       varchar2(10)      ,/* 铺货库位 */
pmcp007       date      ,/* 需求日期 */
pmcp008       varchar2(10)      ,/* 需求时段 */
pmcp009       varchar2(10)      ,/* 包装单位 */
pmcp010       number(20,6)      ,/* 件装数 */
pmcp011       number(20,6)      ,/* 铺货件数 */
pmcp012       varchar2(10)      ,/* 供应商编号 */
pmcp013       varchar2(10)      ,/* 采购类型 */
pmcp014       varchar2(255)      ,/* 备注 */
pmcpud001       varchar2(40)      ,/* 自定义字段(文本)001 */
pmcpud002       varchar2(40)      ,/* 自定义字段(文本)002 */
pmcpud003       varchar2(40)      ,/* 自定义字段(文本)003 */
pmcpud004       varchar2(40)      ,/* 自定义字段(文本)004 */
pmcpud005       varchar2(40)      ,/* 自定义字段(文本)005 */
pmcpud006       varchar2(40)      ,/* 自定义字段(文本)006 */
pmcpud007       varchar2(40)      ,/* 自定义字段(文本)007 */
pmcpud008       varchar2(40)      ,/* 自定义字段(文本)008 */
pmcpud009       varchar2(40)      ,/* 自定义字段(文本)009 */
pmcpud010       varchar2(40)      ,/* 自定义字段(文本)010 */
pmcpud011       number(20,6)      ,/* 自定义字段(数字)011 */
pmcpud012       number(20,6)      ,/* 自定义字段(数字)012 */
pmcpud013       number(20,6)      ,/* 自定义字段(数字)013 */
pmcpud014       number(20,6)      ,/* 自定义字段(数字)014 */
pmcpud015       number(20,6)      ,/* 自定义字段(数字)015 */
pmcpud016       number(20,6)      ,/* 自定义字段(数字)016 */
pmcpud017       number(20,6)      ,/* 自定义字段(数字)017 */
pmcpud018       number(20,6)      ,/* 自定义字段(数字)018 */
pmcpud019       number(20,6)      ,/* 自定义字段(数字)019 */
pmcpud020       number(20,6)      ,/* 自定义字段(数字)020 */
pmcpud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
pmcpud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
pmcpud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
pmcpud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
pmcpud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
pmcpud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
pmcpud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
pmcpud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
pmcpud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
pmcpud030       timestamp(0)      ,/* 自定义字段(日期时间)030 */
pmcp015       number(20,6)      ,/* 参考单价 */
pmcp016       varchar2(10)      /* 配送仓库 */
);
alter table pmcp_t add constraint pmcp_pk primary key (pmcpent,pmcpdocno,pmcpseq) enable validate;

create unique index pmcp_pk on pmcp_t (pmcpent,pmcpdocno,pmcpseq);

grant select on pmcp_t to tiptop;
grant update on pmcp_t to tiptop;
grant delete on pmcp_t to tiptop;
grant insert on pmcp_t to tiptop;

exit;
