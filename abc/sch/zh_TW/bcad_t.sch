/* 
================================================================================
檔案代號:bcad_t
檔案名稱:条码信息变更明细档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table bcad_t
(
bcadent       number(5)      ,/* 企业编号 */
bcadsite       varchar2(10)      ,/* 营运据点 */
bcaddocno       varchar2(20)      ,/* 调整单号 */
bcadseq       number(10,0)      ,/* 项次 */
bcad000       number(5,0)      ,/* 版次 */
bcad001       varchar2(255)      ,/* 条码编号 */
bcad002       varchar2(10)      ,/* 库位 */
bcad003       varchar2(10)      ,/* 储位 */
bcad004       varchar2(30)      ,/* 批号 */
bcad005       varchar2(30)      ,/* 制造批号 */
bcad006       varchar2(30)      ,/* 制造序号 */
bcad007       number(20,6)      ,/* 库存数量 */
bcadud001       varchar2(40)      ,/* 自定义字段(文本)001 */
bcadud002       varchar2(40)      ,/* 自定义字段(文本)002 */
bcadud003       varchar2(40)      ,/* 自定义字段(文本)003 */
bcadud004       varchar2(40)      ,/* 自定义字段(文本)004 */
bcadud005       varchar2(40)      ,/* 自定义字段(文本)005 */
bcadud006       varchar2(40)      ,/* 自定义字段(文本)006 */
bcadud007       varchar2(40)      ,/* 自定义字段(文本)007 */
bcadud008       varchar2(40)      ,/* 自定义字段(文本)008 */
bcadud009       varchar2(40)      ,/* 自定义字段(文本)009 */
bcadud010       varchar2(40)      ,/* 自定义字段(文本)010 */
bcadud011       number(20,6)      ,/* 自定义字段(数字)011 */
bcadud012       number(20,6)      ,/* 自定义字段(数字)012 */
bcadud013       number(20,6)      ,/* 自定义字段(数字)013 */
bcadud014       number(20,6)      ,/* 自定义字段(数字)014 */
bcadud015       number(20,6)      ,/* 自定义字段(数字)015 */
bcadud016       number(20,6)      ,/* 自定义字段(数字)016 */
bcadud017       number(20,6)      ,/* 自定义字段(数字)017 */
bcadud018       number(20,6)      ,/* 自定义字段(数字)018 */
bcadud019       number(20,6)      ,/* 自定义字段(数字)019 */
bcadud020       number(20,6)      ,/* 自定义字段(数字)020 */
bcadud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
bcadud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
bcadud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
bcadud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
bcadud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
bcadud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
bcadud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
bcadud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
bcadud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
bcadud030       timestamp(0)      ,/* 自定义字段(日期时间)030 */
bcad008       varchar2(30)      ,/* 库存管理特征 */
bcad009       varchar2(20)      ,/* 来源作业 */
bcad010       varchar2(20)      ,/* 来源单号 */
bcad011       number(10,0)      ,/* 来源项次 */
bcad012       number(10,0)      ,/* 来源项序 */
bcad013       number(10,0)      ,/* 来源分批序 */
bcad014       number(20,6)      /* 箱装数 */
);
alter table bcad_t add constraint bcad_pk primary key (bcadent,bcaddocno,bcadseq) enable validate;

create unique index bcad_pk on bcad_t (bcadent,bcaddocno,bcadseq);

grant select on bcad_t to tiptop;
grant update on bcad_t to tiptop;
grant delete on bcad_t to tiptop;
grant insert on bcad_t to tiptop;

exit;
