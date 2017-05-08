/* 
================================================================================
檔案代號:xrgb_t
檔案名稱:销售信用状明细档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table xrgb_t
(
xrgbent       number(5)      ,/*   */
xrgbcomp       varchar2(10)      ,/* 法人 */
xrgbdocno       varchar2(20)      ,/* 申请单号 */
xrgbseq       number(10,0)      ,/* 项次 */
xrgborga       varchar2(10)      ,/* 来源组织 */
xrgb001       varchar2(20)      ,/* 订单单号 */
xrgb002       number(10,0)      ,/* 订单项次 */
xrgb003       varchar2(40)      ,/* 产品编号 */
xrgb004       varchar2(255)      ,/* 品名规格 */
xrgb005       varchar2(10)      ,/* 单位 */
xrgb006       varchar2(10)      ,/* 税种 */
xrgb007       varchar2(1)      ,/* 含税否 */
xrgb008       number(20,6)      ,/* 订单数量 */
xrgb009       number(20,6)      ,/* 原币含税单价 */
xrgb010       number(20,6)      ,/* 已出货数量 */
xrgb105       number(20,6)      ,/* 原币含税金额 */
xrgb115       number(20,6)      ,/* 本币含税金额 */
xrgbud001       varchar2(40)      ,/* 自定义字段(文本)001 */
xrgbud002       varchar2(40)      ,/* 自定义字段(文本)002 */
xrgbud003       varchar2(40)      ,/* 自定义字段(文本)003 */
xrgbud004       varchar2(40)      ,/* 自定义字段(文本)004 */
xrgbud005       varchar2(40)      ,/* 自定义字段(文本)005 */
xrgbud006       varchar2(40)      ,/* 自定义字段(文本)006 */
xrgbud007       varchar2(40)      ,/* 自定义字段(文本)007 */
xrgbud008       varchar2(40)      ,/* 自定义字段(文本)008 */
xrgbud009       varchar2(40)      ,/* 自定义字段(文本)009 */
xrgbud010       varchar2(40)      ,/* 自定义字段(文本)010 */
xrgbud011       number(20,6)      ,/* 自定义字段(数字)011 */
xrgbud012       number(20,6)      ,/* 自定义字段(数字)012 */
xrgbud013       number(20,6)      ,/* 自定义字段(数字)013 */
xrgbud014       number(20,6)      ,/* 自定义字段(数字)014 */
xrgbud015       number(20,6)      ,/* 自定义字段(数字)015 */
xrgbud016       number(20,6)      ,/* 自定义字段(数字)016 */
xrgbud017       number(20,6)      ,/* 自定义字段(数字)017 */
xrgbud018       number(20,6)      ,/* 自定义字段(数字)018 */
xrgbud019       number(20,6)      ,/* 自定义字段(数字)019 */
xrgbud020       number(20,6)      ,/* 自定义字段(数字)020 */
xrgbud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
xrgbud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
xrgbud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
xrgbud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
xrgbud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
xrgbud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
xrgbud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
xrgbud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
xrgbud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
xrgbud030       timestamp(0)      ,/* 自定义字段(日期时间)030 */
xrgb100       varchar2(10)      ,/* 币种 */
xrgb101       number(20,10)      /* 汇率 */
);
alter table xrgb_t add constraint xrgb_pk primary key (xrgbent,xrgbcomp,xrgbdocno,xrgbseq) enable validate;

create unique index xrgb_pk on xrgb_t (xrgbent,xrgbcomp,xrgbdocno,xrgbseq);

grant select on xrgb_t to tiptop;
grant update on xrgb_t to tiptop;
grant delete on xrgb_t to tiptop;
grant insert on xrgb_t to tiptop;

exit;
