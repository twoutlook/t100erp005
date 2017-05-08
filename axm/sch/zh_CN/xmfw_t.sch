/* 
================================================================================
檔案代號:xmfw_t
檔案名稱:订单变更附属零件明细档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table xmfw_t
(
xmfwent       number(5)      ,/* 企业编号 */
xmfwsite       varchar2(10)      ,/* 营运据点 */
xmfwdocno       varchar2(20)      ,/* 订单单号 */
xmfwseq       number(10,0)      ,/* 项次 */
xmfwseq1       number(10,0)      ,/* 项序 */
xmfw001       varchar2(40)      ,/* 附属零件料号 */
xmfw002       varchar2(40)      ,/* 主件料号 */
xmfw003       varchar2(10)      ,/* 部位编号 */
xmfw004       varchar2(10)      ,/* 作业编号 */
xmfw005       varchar2(10)      ,/* 作业序 */
xmfw006       number(20,6)      ,/* 组成用量 */
xmfw007       number(20,6)      ,/* 主件底数 */
xmfw008       varchar2(10)      ,/* 单位 */
xmfw009       number(20,6)      ,/* 需求数量 */
xmfw010       number(20,6)      ,/* 标准组成用量 */
xmfw011       number(20,6)      ,/* 标准主件底数 */
xmfw012       varchar2(10)      ,/* 子件特性 */
xmfw900       number(10,0)      ,/* 变更序 */
xmfw901       varchar2(1)      ,/* 变更类型 */
xmfw902       varchar2(10)      ,/* 变更理由 */
xmfw903       varchar2(255)      ,/* 变更备注 */
xmfwud001       varchar2(40)      ,/* 自定义字段(文本)001 */
xmfwud002       varchar2(40)      ,/* 自定义字段(文本)002 */
xmfwud003       varchar2(40)      ,/* 自定义字段(文本)003 */
xmfwud004       varchar2(40)      ,/* 自定义字段(文本)004 */
xmfwud005       varchar2(40)      ,/* 自定义字段(文本)005 */
xmfwud006       varchar2(40)      ,/* 自定义字段(文本)006 */
xmfwud007       varchar2(40)      ,/* 自定义字段(文本)007 */
xmfwud008       varchar2(40)      ,/* 自定义字段(文本)008 */
xmfwud009       varchar2(40)      ,/* 自定义字段(文本)009 */
xmfwud010       varchar2(40)      ,/* 自定义字段(文本)010 */
xmfwud011       number(20,6)      ,/* 自定义字段(数字)011 */
xmfwud012       number(20,6)      ,/* 自定义字段(数字)012 */
xmfwud013       number(20,6)      ,/* 自定义字段(数字)013 */
xmfwud014       number(20,6)      ,/* 自定义字段(数字)014 */
xmfwud015       number(20,6)      ,/* 自定义字段(数字)015 */
xmfwud016       number(20,6)      ,/* 自定义字段(数字)016 */
xmfwud017       number(20,6)      ,/* 自定义字段(数字)017 */
xmfwud018       number(20,6)      ,/* 自定义字段(数字)018 */
xmfwud019       number(20,6)      ,/* 自定义字段(数字)019 */
xmfwud020       number(20,6)      ,/* 自定义字段(数字)020 */
xmfwud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
xmfwud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
xmfwud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
xmfwud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
xmfwud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
xmfwud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
xmfwud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
xmfwud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
xmfwud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
xmfwud030       timestamp(0)      /* 自定义字段(日期时间)030 */
);
alter table xmfw_t add constraint xmfw_pk primary key (xmfwent,xmfwdocno,xmfwseq,xmfwseq1,xmfw900) enable validate;

create unique index xmfw_pk on xmfw_t (xmfwent,xmfwdocno,xmfwseq,xmfwseq1,xmfw900);

grant select on xmfw_t to tiptop;
grant update on xmfw_t to tiptop;
grant delete on xmfw_t to tiptop;
grant insert on xmfw_t to tiptop;

exit;
