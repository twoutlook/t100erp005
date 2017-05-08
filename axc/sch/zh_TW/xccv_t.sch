/* 
================================================================================
檔案代號:xccv_t
檔案名稱:在制元件製程成本期初開帳檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table xccv_t
(
xccvent       number(5)      ,/* 企業編號 */
xccvcomp       varchar2(10)      ,/* 法人組織 */
xccvld       varchar2(5)      ,/* 帳套 */
xccv001       varchar2(1)      ,/* 帳套本位幣順序 */
xccv002       varchar2(30)      ,/* 成本域 */
xccv003       varchar2(10)      ,/* 成本計算類型 */
xccv004       number(5,0)      ,/* 年度 */
xccv005       number(5,0)      ,/* 期別 */
xccv006       varchar2(20)      ,/* 工單編號/在制代號 */
xccv007       varchar2(10)      ,/* 作業編號 */
xccv008       varchar2(10)      ,/* 作業序 */
xccv009       varchar2(40)      ,/* 料號 */
xccv010       varchar2(256)      ,/* 特性 */
xccv011       varchar2(30)      ,/* 批號 */
xccv020       varchar2(10)      ,/* 核算幣別 */
xccv101       number(20,6)      ,/* 期末結存數量 */
xccv102       number(20,6)      ,/* 期末結存金額 */
xccv102a       number(20,6)      ,/* 期末結存金額-材料 */
xccv102b       number(20,6)      ,/* 期末結存金額-人工 */
xccv102c       number(20,6)      ,/* 期末結存金額-加工 */
xccv102d       number(20,6)      ,/* 期末結存金額-制費一 */
xccv102e       number(20,6)      ,/* 期末結存金額-制費二 */
xccv102f       number(20,6)      ,/* 期末結存金額-制費三 */
xccv102g       number(20,6)      ,/* 期末結存金額-制費四 */
xccv102h       number(20,6)      /* 期末結存金額-制費五 */
);
alter table xccv_t add constraint xccv_pk primary key (xccvent,xccvld,xccv001,xccv002,xccv003,xccv004,xccv005,xccv006,xccv007,xccv008,xccv009,xccv010,xccv011) enable validate;

create unique index xccv_pk on xccv_t (xccvent,xccvld,xccv001,xccv002,xccv003,xccv004,xccv005,xccv006,xccv007,xccv008,xccv009,xccv010,xccv011);

grant select on xccv_t to tiptop;
grant update on xccv_t to tiptop;
grant delete on xccv_t to tiptop;
grant insert on xccv_t to tiptop;

exit;
