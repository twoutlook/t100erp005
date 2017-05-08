/* 
================================================================================
檔案代號:qcbo_t
檔案名稱:待验清单单头档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table qcbo_t
(
qcboent       number(5)      ,/* 企业编号 */
qcbosite       varchar2(10)      ,/* 营运据点 */
qcbo001       varchar2(10)      ,/* 检验类型 */
qcbo002       varchar2(20)      ,/* 来源单号 */
qcbo003       number(10,0)      ,/* 来源项次 */
qcbo004       number(10,0)      ,/* RUNCARD */
qcbo005       varchar2(20)      ,/* 参考单号 */
qcbo006       number(10,0)      ,/* 参考单项次 */
qcbo007       varchar2(10)      ,/* 交易对象编号 */
qcbo008       varchar2(10)      ,/* 作业编号 */
qcbo009       number(10,0)      ,/* 加工序 */
qcbo010       number(20,6)      ,/* 来源数量 */
qcbo011       varchar2(10)      ,/* 单位 */
qcbo012       varchar2(40)      ,/* 料件编号 */
qcbo013       varchar2(10)      ,/* 版本 */
qcbo014       varchar2(256)      ,/* 产品特征 */
qcbo015       varchar2(10)      ,/* 品管分群 */
qcbo016       varchar2(10)      ,/* 检验程度 */
qcbo017       varchar2(10)      ,/* 检验级数 */
qcbo018       varchar2(20)      ,/* 承认文号 */
qcbo019       varchar2(10)      ,/* 类型分类 */
qcbo020       varchar2(20)      ,/* 当前检验人员 */
qcbo021       date      ,/* 开始检验日期 */
qcbo022       varchar2(8)      ,/* 开始检验时间 */
qcbo023       varchar2(10)      ,/* 紧急度 */
qcbo024       varchar2(20)      ,/* 检验项目识别码 */
qcboud001       varchar2(40)      ,/* 自定义字段(文本)001 */
qcboud002       varchar2(40)      ,/* 自定义字段(文本)002 */
qcboud003       varchar2(40)      ,/* 自定义字段(文本)003 */
qcboud004       varchar2(40)      ,/* 自定义字段(文本)004 */
qcboud005       varchar2(40)      ,/* 自定义字段(文本)005 */
qcboud006       varchar2(40)      ,/* 自定义字段(文本)006 */
qcboud007       varchar2(40)      ,/* 自定义字段(文本)007 */
qcboud008       varchar2(40)      ,/* 自定义字段(文本)008 */
qcboud009       varchar2(40)      ,/* 自定义字段(文本)009 */
qcboud010       varchar2(40)      ,/* 自定义字段(文本)010 */
qcboud011       number(20,6)      ,/* 自定义字段(数字)011 */
qcboud012       number(20,6)      ,/* 自定义字段(数字)012 */
qcboud013       number(20,6)      ,/* 自定义字段(数字)013 */
qcboud014       number(20,6)      ,/* 自定义字段(数字)014 */
qcboud015       number(20,6)      ,/* 自定义字段(数字)015 */
qcboud016       number(20,6)      ,/* 自定义字段(数字)016 */
qcboud017       number(20,6)      ,/* 自定义字段(数字)017 */
qcboud018       number(20,6)      ,/* 自定义字段(数字)018 */
qcboud019       number(20,6)      ,/* 自定义字段(数字)019 */
qcboud020       number(20,6)      ,/* 自定义字段(数字)020 */
qcboud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
qcboud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
qcboud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
qcboud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
qcboud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
qcboud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
qcboud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
qcboud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
qcboud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
qcboud030       timestamp(0)      /* 自定义字段(日期时间)030 */
);
alter table qcbo_t add constraint qcbo_pk primary key (qcboent,qcbosite,qcbo001,qcbo002,qcbo003,qcbo004) enable validate;

create unique index qcbo_pk on qcbo_t (qcboent,qcbosite,qcbo001,qcbo002,qcbo003,qcbo004);

grant select on qcbo_t to tiptop;
grant update on qcbo_t to tiptop;
grant delete on qcbo_t to tiptop;
grant insert on qcbo_t to tiptop;

exit;
