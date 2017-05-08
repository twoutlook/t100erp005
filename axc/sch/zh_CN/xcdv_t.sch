/* 
================================================================================
檔案代號:xcdv_t
檔案名稱:在制元件製程成本次要素期初開帳檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table xcdv_t
(
xcdvent       number(5)      ,/* 企業編號 */
xcdvcomp       varchar2(10)      ,/* 法人組織 */
xcdvld       varchar2(5)      ,/* 帳套 */
xcdv001       varchar2(1)      ,/* 帳套本位幣順序 */
xcdv002       varchar2(30)      ,/* 成本域 */
xcdv003       varchar2(10)      ,/* 成本計算類型 */
xcdv004       number(5,0)      ,/* 年度 */
xcdv005       number(5,0)      ,/* 期別 */
xcdv006       varchar2(20)      ,/* 工單編號/在制代號 */
xcdv007       varchar2(10)      ,/* 作業編號 */
xcdv008       varchar2(10)      ,/* 作業序 */
xcdv009       varchar2(40)      ,/* 料號 */
xcdv010       varchar2(256)      ,/* 特性 */
xcdv011       varchar2(30)      ,/* 批號 */
xcdv012       varchar2(10)      ,/* 次要素 */
xcdv020       varchar2(10)      ,/* 核算幣別 */
xcdv101       number(20,6)      ,/* 期末結存數量 */
xcdv102       number(20,6)      /* 期末結存金額 */
);
alter table xcdv_t add constraint xcdv_pk primary key (xcdvent,xcdvld,xcdv001,xcdv002,xcdv003,xcdv004,xcdv005,xcdv006,xcdv007,xcdv008,xcdv009,xcdv010,xcdv011,xcdv012) enable validate;

create unique index xcdv_pk on xcdv_t (xcdvent,xcdvld,xcdv001,xcdv002,xcdv003,xcdv004,xcdv005,xcdv006,xcdv007,xcdv008,xcdv009,xcdv010,xcdv011,xcdv012);

grant select on xcdv_t to tiptop;
grant update on xcdv_t to tiptop;
grant delete on xcdv_t to tiptop;
grant insert on xcdv_t to tiptop;

exit;
