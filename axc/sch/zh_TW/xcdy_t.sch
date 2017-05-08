/* 
================================================================================
檔案代號:xcdy_t
檔案名稱:每月工单人工制费工艺成本次要素档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table xcdy_t
(
xcdyent       number(5)      ,/* 企业代码 */
xcdyld       varchar2(5)      ,/* 帐别 */
xcdycomp       varchar2(10)      ,/* 法人组织 */
xcdy001       varchar2(10)      ,/* 成本计算类型 */
xcdy002       number(5,0)      ,/* 年度 */
xcdy003       number(5,0)      ,/* 期别 */
xcdy004       varchar2(10)      ,/* 成本中心 */
xcdy005       varchar2(10)      ,/* 费用分类(成本次要素) */
xcdy006       varchar2(20)      ,/* 工单编号 */
xcdy007       varchar2(1)      ,/* 分摊方式 */
xcdy008       varchar2(10)      ,/* 作业编号 */
xcdy009       varchar2(10)      ,/* 作业序 */
xcdy100       number(20,6)      ,/* 工单分摊数 */
xcdy101       number(20,6)      ,/* 单位成本(本位币一) */
xcdy111       number(20,6)      ,/* 单位成本(本位币二) */
xcdy121       number(20,6)      ,/* 单位成本(本位币三) */
xcdy202       number(20,6)      ,/* 分摊金额(本位币一) */
xcdy212       number(20,6)      ,/* 分摊金额(本位币二) */
xcdy222       number(20,6)      /* 分摊金额(本位币三) */
);
alter table xcdy_t add constraint xcdy_pk primary key (xcdyent,xcdyld,xcdy001,xcdy002,xcdy003,xcdy004,xcdy005,xcdy006,xcdy007,xcdy008,xcdy009) enable validate;

create unique index xcdy_pk on xcdy_t (xcdyent,xcdyld,xcdy001,xcdy002,xcdy003,xcdy004,xcdy005,xcdy006,xcdy007,xcdy008,xcdy009);

grant select on xcdy_t to tiptop;
grant update on xcdy_t to tiptop;
grant delete on xcdy_t to tiptop;
grant insert on xcdy_t to tiptop;

exit;
