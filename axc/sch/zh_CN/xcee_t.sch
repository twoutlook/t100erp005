/* 
================================================================================
檔案代號:xcee_t
檔案名稱:本期料件明细进出-差异转出入成本档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table xcee_t
(
xceeent       number(5)      ,/* 企业代码 */
xceesite       varchar2(10)      ,/* 营运据点 */
xceecomp       varchar2(10)      ,/* 法人 */
xceeld       varchar2(5)      ,/* 帐套 */
xcee001       varchar2(1)      ,/* 帳套本位幣順序 */
xcee002       varchar2(30)      ,/* 成本域 */
xcee003       varchar2(10)      ,/* 成本计算类型 */
xcee004       number(5,0)      ,/* 年度 */
xcee005       number(5,0)      ,/* 期别 */
xcee006       varchar2(20)      ,/* 参考单号 */
xcee007       number(10,0)      ,/* 项次 */
xcee008       number(5,0)      ,/* 项序 */
xcee009       number(5,0)      ,/* 出入库码 */
xcee010       varchar2(20)      ,/* 差异转入/出参考单号 */
xcee011       number(10,0)      ,/* 差异转入/出项次 */
xcee012       number(5,0)      ,/* 差异转入/出项序 */
xcee013       number(5,0)      ,/* 转出入库码 */
xcee401       number(20,6)      ,/* 差异数量 */
xcee402       number(20,6)      ,/* 差异金额 */
xcee402a       number(20,6)      ,/* 差异金额-材料 */
xcee402b       number(20,6)      ,/* 差异金额-人工 */
xcee402c       number(20,6)      ,/* 差异金额-加工费 */
xcee402d       number(20,6)      ,/* 差异金额-制费一 */
xcee402e       number(20,6)      ,/* 差异金额-制费二 */
xcee402f       number(20,6)      ,/* 差异金额-制费三 */
xcee402g       number(20,6)      ,/* 差异金额-制费四 */
xcee402h       number(20,6)      ,/* 差异金额-制费五 */
xceeud001       varchar2(40)      ,/* 自定义字段(文本)001 */
xceeud002       varchar2(40)      ,/* 自定义字段(文本)002 */
xceeud003       varchar2(40)      ,/* 自定义字段(文本)003 */
xceeud004       varchar2(40)      ,/* 自定义字段(文本)004 */
xceeud005       varchar2(40)      ,/* 自定义字段(文本)005 */
xceeud006       varchar2(40)      ,/* 自定义字段(文本)006 */
xceeud007       varchar2(40)      ,/* 自定义字段(文本)007 */
xceeud008       varchar2(40)      ,/* 自定义字段(文本)008 */
xceeud009       varchar2(40)      ,/* 自定义字段(文本)009 */
xceeud010       varchar2(40)      ,/* 自定义字段(文本)010 */
xceeud011       number(20,6)      ,/* 自定义字段(数字)011 */
xceeud012       number(20,6)      ,/* 自定义字段(数字)012 */
xceeud013       number(20,6)      ,/* 自定义字段(数字)013 */
xceeud014       number(20,6)      ,/* 自定义字段(数字)014 */
xceeud015       number(20,6)      ,/* 自定义字段(数字)015 */
xceeud016       number(20,6)      ,/* 自定义字段(数字)016 */
xceeud017       number(20,6)      ,/* 自定义字段(数字)017 */
xceeud018       number(20,6)      ,/* 自定义字段(数字)018 */
xceeud019       number(20,6)      ,/* 自定义字段(数字)019 */
xceeud020       number(20,6)      ,/* 自定义字段(数字)020 */
xceeud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
xceeud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
xceeud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
xceeud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
xceeud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
xceeud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
xceeud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
xceeud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
xceeud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
xceeud030       timestamp(0)      /* 自定义字段(日期时间)030 */
);
alter table xcee_t add constraint xcee_pk primary key (xceeent,xceeld,xcee001,xcee002,xcee003,xcee004,xcee005,xcee006,xcee007,xcee008,xcee009,xcee010,xcee011,xcee012,xcee013) enable validate;

create unique index xcee_pk on xcee_t (xceeent,xceeld,xcee001,xcee002,xcee003,xcee004,xcee005,xcee006,xcee007,xcee008,xcee009,xcee010,xcee011,xcee012,xcee013);

grant select on xcee_t to tiptop;
grant update on xcee_t to tiptop;
grant delete on xcee_t to tiptop;
grant insert on xcee_t to tiptop;

exit;
