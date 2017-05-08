/* 
================================================================================
檔案代號:indd_t
檔案名稱:调拨单单身明细档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table indd_t
(
inddent       number(5)      ,/* 企业编号 */
inddsite       varchar2(10)      ,/* 营运据点 */
inddunit       varchar2(10)      ,/* 应用组织 */
indddocno       varchar2(20)      ,/* 调拨单号 */
inddseq       number(10,0)      ,/* 项次 */
indd001       number(10,0)      ,/* 来源项次 */
indd002       varchar2(40)      ,/* 商品编号 */
indd003       varchar2(40)      ,/* 商品条码 */
indd004       varchar2(256)      ,/* 产品特征 */
indd005       varchar2(10)      ,/* 经营方式 */
indd006       varchar2(10)      ,/* 库存单位 */
indd007       varchar2(10)      ,/* 包装单位 */
indd008       number(20,6)      ,/* 件装数 */
indd009       number(20,6)      ,/* 预调拨量 */
indd020       number(20,6)      ,/* 拨出件数 */
indd021       number(20,6)      ,/* 拨出数量 */
indd022       varchar2(10)      ,/* 拨出库位 */
indd023       varchar2(10)      ,/* 拨出储位 */
indd024       varchar2(30)      ,/* 拨出批号 */
indd030       number(20,6)      ,/* 拨入件数 */
indd031       number(20,6)      ,/* 拨入数量 */
indd032       varchar2(10)      ,/* 拨入库位 */
indd033       varchar2(10)      ,/* 拨入储位 */
indd034       varchar2(30)      ,/* 拨入批号 */
indd040       varchar2(1)      ,/* 结案否 */
indd101       varchar2(20)      ,/* 来源单号 */
indd102       varchar2(30)      ,/* 库存管理特征 */
indd103       number(20,6)      ,/* 拨出申请量 */
indd104       varchar2(10)      ,/* 参考单位 */
indd105       number(20,6)      ,/* 拨出申请参考数量 */
indd106       number(20,6)      ,/* 拨出合格参考数量 */
indd107       number(20,6)      ,/* 拨入申请数量 */
indd108       number(20,6)      ,/* 拨入申请参考数量 */
indd109       number(20,6)      ,/* 拨入合格参考数量 */
indd110       number(20,6)      ,/* 差异量 */
indd111       varchar2(10)      ,/* 差异原因 */
indd112       varchar2(10)      ,/* 差异已调整量 */
indd151       varchar2(10)      ,/* 调拨理由 */
indd152       varchar2(255)      ,/* 备注 */
inddud001       varchar2(40)      ,/* 自定义字段(文本)001 */
inddud002       varchar2(40)      ,/* 自定义字段(文本)002 */
inddud003       varchar2(40)      ,/* 自定义字段(文本)003 */
inddud004       varchar2(40)      ,/* 自定义字段(文本)004 */
inddud005       varchar2(40)      ,/* 自定义字段(文本)005 */
inddud006       varchar2(40)      ,/* 自定义字段(文本)006 */
inddud007       varchar2(40)      ,/* 自定义字段(文本)007 */
inddud008       varchar2(40)      ,/* 自定义字段(文本)008 */
inddud009       varchar2(40)      ,/* 自定义字段(文本)009 */
inddud010       varchar2(40)      ,/* 自定义字段(文本)010 */
inddud011       number(20,6)      ,/* 自定义字段(数字)011 */
inddud012       number(20,6)      ,/* 自定义字段(数字)012 */
inddud013       number(20,6)      ,/* 自定义字段(数字)013 */
inddud014       number(20,6)      ,/* 自定义字段(数字)014 */
inddud015       number(20,6)      ,/* 自定义字段(数字)015 */
inddud016       number(20,6)      ,/* 自定义字段(数字)016 */
inddud017       number(20,6)      ,/* 自定义字段(数字)017 */
inddud018       number(20,6)      ,/* 自定义字段(数字)018 */
inddud019       number(20,6)      ,/* 自定义字段(数字)019 */
inddud020       number(20,6)      ,/* 自定义字段(数字)020 */
inddud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
inddud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
inddud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
inddud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
inddud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
inddud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
inddud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
inddud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
inddud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
inddud030       timestamp(0)      ,/* 自定义字段(日期时间)030 */
indd041       varchar2(10)      ,/* 拨入单位 */
indd042       varchar2(20)      ,/* 项目编号 */
indd043       varchar2(30)      ,/* WBS */
indd044       varchar2(30)      ,/* 活动编号 */
indd010       varchar2(1)      ,/* 多库储否 */
indd025       number(20,6)      ,/* 拨出组织库存数量 */
indd035       number(20,6)      ,/* 拨入组织库存数量 */
indd045       number(20,6)      ,/* 预估单价 */
indd046       number(20,6)      ,/* 预估金额 */
indd047       varchar2(20)      ,/* 来源需求单号 */
indd048       number(10,0)      ,/* 来源需求项次 */
indd049       varchar2(20)      ,/* 装箱单号 */
indd050       number(10,0)      /* 装箱项次 */
);
alter table indd_t add constraint indd_pk primary key (inddent,indddocno,inddseq) enable validate;

create unique index indd_pk on indd_t (inddent,indddocno,inddseq);

grant select on indd_t to tiptop;
grant update on indd_t to tiptop;
grant delete on indd_t to tiptop;
grant insert on indd_t to tiptop;

exit;
