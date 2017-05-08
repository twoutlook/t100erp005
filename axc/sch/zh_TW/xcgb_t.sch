/* 
================================================================================
檔案代號:xcgb_t
檔案名稱:期初在制明细数量成本开帐档（项次+项序）
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table xcgb_t
(
xcgbent       number(5)      ,/* 企业编号 */
xcgbld       varchar2(5)      ,/* 账套 */
xcgbcomp       varchar2(10)      ,/* 法人组织 */
xcgb001       varchar2(1)      ,/* 账套本位币顺序 */
xcgb002       varchar2(30)      ,/* 成本域 */
xcgb003       varchar2(10)      ,/* 成本计算类型 */
xcgb004       number(5,0)      ,/* 年度 */
xcgb005       number(5,0)      ,/* 期别 */
xcgb006       varchar2(20)      ,/* 工单编号 */
xcgb007       varchar2(40)      ,/* 元件编号 */
xcgb008       varchar2(256)      ,/* 特性 */
xcgb009       varchar2(30)      ,/* 批号 */
xcgb010       number(5,0)      ,/* 项次 */
xcgb011       number(5,0)      ,/* 项序 */
xcgb101       number(20,6)      /* 当月期末数量 */
);
alter table xcgb_t add constraint xcgb_pk primary key (xcgbent,xcgbld,xcgb001,xcgb002,xcgb003,xcgb004,xcgb005,xcgb006,xcgb007,xcgb008,xcgb009,xcgb010,xcgb011) enable validate;

create unique index xcgb_pk on xcgb_t (xcgbent,xcgbld,xcgb001,xcgb002,xcgb003,xcgb004,xcgb005,xcgb006,xcgb007,xcgb008,xcgb009,xcgb010,xcgb011);

grant select on xcgb_t to tiptop;
grant update on xcgb_t to tiptop;
grant delete on xcgb_t to tiptop;
grant insert on xcgb_t to tiptop;

exit;
