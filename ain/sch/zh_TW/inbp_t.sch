/* 
================================================================================
檔案代號:inbp_t
檔案名稱:装箱单身档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table inbp_t
(
inbpent       number(5)      ,/* 企业编号 */
inbpsite       varchar2(10)      ,/* 营运据点 */
inbpdocno       varchar2(20)      ,/* 单据编号 */
inbpseq       number(10,0)      ,/* 项次 */
inbp001       varchar2(10)      ,/* 来源单据类型 */
inbp002       varchar2(20)      ,/* 来源单号 */
inbp003       number(10,0)      ,/* 来源项次 */
inbp004       varchar2(40)      ,/* 商品条码 */
inbp005       varchar2(40)      ,/* 商品编码 */
inbp006       varchar2(30)      ,/* 产品特征 */
inbp007       varchar2(10)      ,/* 单位 */
inbp008       number(20,6)      ,/* 数量 */
inbp009       number(20,6)      ,/* 已装箱量 */
inbp010       varchar2(10)      ,/* 需求类型 */
inbp011       varchar2(20)      ,/* 需求单号 */
inbp012       number(10,0)      ,/* 需求项次 */
inbpud001       varchar2(40)      ,/* 自定义字段(文本)001 */
inbpud002       varchar2(40)      ,/* 自定义字段(文本)002 */
inbpud003       varchar2(40)      ,/* 自定义字段(文本)003 */
inbpud004       varchar2(40)      ,/* 自定义字段(文本)004 */
inbpud005       varchar2(40)      ,/* 自定义字段(文本)005 */
inbpud006       varchar2(40)      ,/* 自定义字段(文本)006 */
inbpud007       varchar2(40)      ,/* 自定义字段(文本)007 */
inbpud008       varchar2(40)      ,/* 自定义字段(文本)008 */
inbpud009       varchar2(40)      ,/* 自定义字段(文本)009 */
inbpud010       varchar2(40)      ,/* 自定义字段(文本)010 */
inbpud011       number(20,6)      ,/* 自定义字段(数字)011 */
inbpud012       number(20,6)      ,/* 自定义字段(数字)012 */
inbpud013       number(20,6)      ,/* 自定义字段(数字)013 */
inbpud014       number(20,6)      ,/* 自定义字段(数字)014 */
inbpud015       number(20,6)      ,/* 自定义字段(数字)015 */
inbpud016       number(20,6)      ,/* 自定义字段(数字)016 */
inbpud017       number(20,6)      ,/* 自定义字段(数字)017 */
inbpud018       number(20,6)      ,/* 自定义字段(数字)018 */
inbpud019       number(20,6)      ,/* 自定义字段(数字)019 */
inbpud020       number(20,6)      ,/* 自定义字段(数字)020 */
inbpud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
inbpud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
inbpud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
inbpud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
inbpud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
inbpud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
inbpud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
inbpud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
inbpud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
inbpud030       timestamp(0)      /* 自定义字段(日期时间)030 */
);
alter table inbp_t add constraint inbp_pk primary key (inbpent,inbpdocno,inbpseq) enable validate;

create  index inbp_n01 on inbp_t (inbpent,inbp002);
create unique index inbp_pk on inbp_t (inbpent,inbpdocno,inbpseq);

grant select on inbp_t to tiptop;
grant update on inbp_t to tiptop;
grant delete on inbp_t to tiptop;
grant insert on inbp_t to tiptop;

exit;
