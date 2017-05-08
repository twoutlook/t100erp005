/* 
================================================================================
檔案代號:bcbb_t
檔案名稱:条码规则明细档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table bcbb_t
(
bcbbent       number(5)      ,/* 企业代码 */
bcbbseq       number(10,0)      ,/* 项次 */
bcbb001       varchar2(10)      ,/* 编码规则编号 */
bcbb002       varchar2(10)      ,/* 节点型态 */
bcbb003       varchar2(40)      ,/* 节点值 */
bcbb004       number(5,0)      ,/* 节点长度 */
bcbb005       varchar2(1)      ,/* 批號否 */
bcbbud001       varchar2(40)      ,/* 自定义字段(文本)001 */
bcbbud002       varchar2(40)      ,/* 自定义字段(文本)002 */
bcbbud003       varchar2(40)      ,/* 自定义字段(文本)003 */
bcbbud004       varchar2(40)      ,/* 自定义字段(文本)004 */
bcbbud005       varchar2(40)      ,/* 自定义字段(文本)005 */
bcbbud006       varchar2(40)      ,/* 自定义字段(文本)006 */
bcbbud007       varchar2(40)      ,/* 自定义字段(文本)007 */
bcbbud008       varchar2(40)      ,/* 自定义字段(文本)008 */
bcbbud009       varchar2(40)      ,/* 自定义字段(文本)009 */
bcbbud010       varchar2(40)      ,/* 自定义字段(文本)010 */
bcbbud011       number(20,6)      ,/* 自定义字段(数字)011 */
bcbbud012       number(20,6)      ,/* 自定义字段(数字)012 */
bcbbud013       number(20,6)      ,/* 自定义字段(数字)013 */
bcbbud014       number(20,6)      ,/* 自定义字段(数字)014 */
bcbbud015       number(20,6)      ,/* 自定义字段(数字)015 */
bcbbud016       number(20,6)      ,/* 自定义字段(数字)016 */
bcbbud017       number(20,6)      ,/* 自定义字段(数字)017 */
bcbbud018       number(20,6)      ,/* 自定义字段(数字)018 */
bcbbud019       number(20,6)      ,/* 自定义字段(数字)019 */
bcbbud020       number(20,6)      ,/* 自定义字段(数字)020 */
bcbbud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
bcbbud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
bcbbud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
bcbbud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
bcbbud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
bcbbud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
bcbbud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
bcbbud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
bcbbud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
bcbbud030       timestamp(0)      /* 自定义字段(日期时间)030 */
);
alter table bcbb_t add constraint bcbb_pk primary key (bcbbent,bcbbseq,bcbb001) enable validate;

create unique index bcbb_pk on bcbb_t (bcbbent,bcbbseq,bcbb001);

grant select on bcbb_t to tiptop;
grant update on bcbb_t to tiptop;
grant delete on bcbb_t to tiptop;
grant insert on bcbb_t to tiptop;

exit;
