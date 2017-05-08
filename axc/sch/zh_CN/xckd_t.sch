/* 
================================================================================
檔案代號:xckd_t
檔案名稱:本期品类成本统计档(流通)
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table xckd_t
(
xckdent       number(5)      ,/* 企业编号 */
xckdsite       varchar2(10)      ,/* 营运据点 */
xckdcomp       varchar2(10)      ,/* 法人 */
xckdld       varchar2(5)      ,/* 账套 */
xckd001       varchar2(1)      ,/* 账套本位币种顺序 */
xckd002       varchar2(10)      ,/* 成本域 */
xckd003       varchar2(10)      ,/* 成本计算类型 */
xckd004       number(5,0)      ,/* 年度 */
xckd005       number(5,0)      ,/* 期别 */
xckd006       number(5,0)      ,/* 出入库码 */
xckd007       varchar2(10)      ,/* 单据类型 */
xckd008       date      ,/* 单据日期 */
xckd009       varchar2(10)      ,/* 仓库编号 */
xckd010       varchar2(10)      ,/* 储位编号 */
xckd011       varchar2(10)      ,/* 异动类型 */
xckd012       varchar2(10)      ,/* 原因码 */
xckd013       varchar2(10)      ,/* 经营类别 */
xckd014       varchar2(10)      ,/* 品类 */
xckd015       varchar2(10)      ,/* xccc类型 */
xckd016       number(20,6)      ,/* 本期异动数量 */
xckd017       number(20,6)      ,/* 本期异动金额 */
xckd018       number(20,6)      ,/* 本期异动金额-材料 */
xckd019       varchar2(1)      ,/* 立账否 */
xckd020       varchar2(10)      ,/* 成本中心 */
xckd021       varchar2(10)      ,/* 部门 */
xckd022       varchar2(1)      ,/* 立账否2 */
xckdud001       varchar2(40)      ,/* 自定义字段(文本)001 */
xckdud002       varchar2(40)      ,/* 自定义字段(文本)002 */
xckdud003       varchar2(40)      ,/* 自定义字段(文本)003 */
xckdud004       varchar2(40)      ,/* 自定义字段(文本)004 */
xckdud005       varchar2(40)      ,/* 自定义字段(文本)005 */
xckdud006       varchar2(40)      ,/* 自定义字段(文本)006 */
xckdud007       varchar2(40)      ,/* 自定义字段(文本)007 */
xckdud008       varchar2(40)      ,/* 自定义字段(文本)008 */
xckdud009       varchar2(40)      ,/* 自定义字段(文本)009 */
xckdud010       varchar2(40)      ,/* 自定义字段(文本)010 */
xckdud011       number(20,6)      ,/* 自定义字段(数字)011 */
xckdud012       number(20,6)      ,/* 自定义字段(数字)012 */
xckdud013       number(20,6)      ,/* 自定义字段(数字)013 */
xckdud014       number(20,6)      ,/* 自定义字段(数字)014 */
xckdud015       number(20,6)      ,/* 自定义字段(数字)015 */
xckdud016       number(20,6)      ,/* 自定义字段(数字)016 */
xckdud017       number(20,6)      ,/* 自定义字段(数字)017 */
xckdud018       number(20,6)      ,/* 自定义字段(数字)018 */
xckdud019       number(20,6)      ,/* 自定义字段(数字)019 */
xckdud020       number(20,6)      ,/* 自定义字段(数字)020 */
xckdud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
xckdud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
xckdud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
xckdud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
xckdud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
xckdud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
xckdud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
xckdud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
xckdud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
xckdud030       timestamp(0)      /* 自定义字段(日期时间)030 */
);
alter table xckd_t add constraint xckd_pk primary key (xckdent,xckdld,xckd001,xckd002,xckd003,xckd004,xckd005,xckd008,xckd009,xckd010,xckd011,xckd014,xckd015) enable validate;

create unique index xckd_pk on xckd_t (xckdent,xckdld,xckd001,xckd002,xckd003,xckd004,xckd005,xckd008,xckd009,xckd010,xckd011,xckd014,xckd015);

grant select on xckd_t to tiptop;
grant update on xckd_t to tiptop;
grant delete on xckd_t to tiptop;
grant insert on xckd_t to tiptop;

exit;
