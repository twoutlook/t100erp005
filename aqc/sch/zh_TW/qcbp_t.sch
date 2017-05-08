/* 
================================================================================
檔案代號:qcbp_t
檔案名稱:待验清单单身档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table qcbp_t
(
qcbpent       number(5)      ,/* 企业编号 */
qcbpsite       varchar2(10)      ,/* 营运据点 */
qcbp001       varchar2(10)      ,/* 检验类型 */
qcbp002       varchar2(20)      ,/* 来源单号 */
qcbp003       number(10,0)      ,/* 来源项次 */
qcbp004       number(10,0)      ,/* RUNCARD */
qcbp005       number(10,0)      ,/* 行序 */
qcbp006       varchar2(10)      ,/* 检验项目 */
qcbp007       varchar2(40)      ,/* 检验位置 */
qcbp008       varchar2(10)      ,/* 缺点等级 */
qcbp009       number(7,3)      ,/* AQL */
qcbp010       number(20,6)      ,/* 允收数 */
qcbp011       number(20,6)      ,/* 拒绝数 */
qcbp012       number(5,3)      ,/* K法标准值 */
qcbp013       number(5,3)      ,/* F法标准值 */
qcbp014       number(20,6)      ,/* 抽验量 */
qcbp015       number(15,3)      ,/* 规范上限 */
qcbp016       number(15,3)      ,/* 检验上限 */
qcbp017       number(15,3)      ,/* 检验标准值 */
qcbp018       number(15,3)      ,/* 检验下限 */
qcbp019       number(15,3)      ,/* 规范下限 */
qcbp020       varchar2(10)      ,/* 计量单位 */
qcbp021       varchar2(255)      ,/* 检验规格说明 */
qcbp022       varchar2(10)      ,/* 抽样计划 */
qcbpud001       varchar2(40)      ,/* 自定义字段(文本)001 */
qcbpud002       varchar2(40)      ,/* 自定义字段(文本)002 */
qcbpud003       varchar2(40)      ,/* 自定义字段(文本)003 */
qcbpud004       varchar2(40)      ,/* 自定义字段(文本)004 */
qcbpud005       varchar2(40)      ,/* 自定义字段(文本)005 */
qcbpud006       varchar2(40)      ,/* 自定义字段(文本)006 */
qcbpud007       varchar2(40)      ,/* 自定义字段(文本)007 */
qcbpud008       varchar2(40)      ,/* 自定义字段(文本)008 */
qcbpud009       varchar2(40)      ,/* 自定义字段(文本)009 */
qcbpud010       varchar2(40)      ,/* 自定义字段(文本)010 */
qcbpud011       number(20,6)      ,/* 自定义字段(数字)011 */
qcbpud012       number(20,6)      ,/* 自定义字段(数字)012 */
qcbpud013       number(20,6)      ,/* 自定义字段(数字)013 */
qcbpud014       number(20,6)      ,/* 自定义字段(数字)014 */
qcbpud015       number(20,6)      ,/* 自定义字段(数字)015 */
qcbpud016       number(20,6)      ,/* 自定义字段(数字)016 */
qcbpud017       number(20,6)      ,/* 自定义字段(数字)017 */
qcbpud018       number(20,6)      ,/* 自定义字段(数字)018 */
qcbpud019       number(20,6)      ,/* 自定义字段(数字)019 */
qcbpud020       number(20,6)      ,/* 自定义字段(数字)020 */
qcbpud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
qcbpud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
qcbpud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
qcbpud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
qcbpud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
qcbpud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
qcbpud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
qcbpud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
qcbpud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
qcbpud030       timestamp(0)      /* 自定义字段(日期时间)030 */
);
alter table qcbp_t add constraint qcbp_pk primary key (qcbpent,qcbpsite,qcbp001,qcbp002,qcbp003,qcbp004,qcbp005) enable validate;

create unique index qcbp_pk on qcbp_t (qcbpent,qcbpsite,qcbp001,qcbp002,qcbp003,qcbp004,qcbp005);

grant select on qcbp_t to tiptop;
grant update on qcbp_t to tiptop;
grant delete on qcbp_t to tiptop;
grant insert on qcbp_t to tiptop;

exit;
