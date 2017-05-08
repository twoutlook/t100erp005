/* 
================================================================================
檔案代號:xmad_t
檔案名稱:NO USE
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table xmad_t
(
xmadent       number(5)      ,/* 企業編號 */
xmadsite       varchar2(10)      ,/* 營運據點 */
xmad001       varchar2(10)      ,/* 額度客戶 */
xmad002       number(5,0)      ,/* 年度 */
xmad003       number(5,0)      ,/* 期別 */
xmad004       varchar2(10)      ,/* 額度計算幣別 */
xmad005       number(20,6)      ,/* 信用額度 */
xmad006       number(20,6)      ,/* 信用餘額 */
xmad011       number(20,6)      ,/* 訂單未出貨金額 */
xmad012       number(20,6)      ,/* 出通單金額 */
xmad013       number(20,6)      ,/* 出貨未開發票金額 */
xmad014       number(20,6)      ,/* 銷退折讓金額 */
xmad015       number(20,6)      ,/* 發票應收帳款 */
xmad016       number(20,6)      ,/* 未兌現應收票據 */
xmad017       number(20,6)      ,/* 應收帳款已沖帳金額 */
xmad018       number(20,6)      ,/* 已收款未沖銷 */
xmad019       number(20,6)      ,/* 待抵帳款金額 */
xmad041       number(20,6)      ,/* 採購未收貨金額 */
xmad042       number(20,6)      ,/* 收貨未入庫金額 */
xmad043       number(20,6)      ,/* 入庫未立應付金額 */
xmad044       number(20,6)      ,/* 倉退金額 */
xmad045       number(20,6)      ,/* 發票應付金額 */
xmad046       number(20,6)      ,/* 應付待抵金額 */
xmad047       number(20,6)      ,/* 已沖帳金額 */
xmad048       number(20,6)      /* 未兌現應付票據金額 */
);
alter table xmad_t add constraint xmad_pk primary key (xmadent,xmadsite,xmad001,xmad002,xmad003) enable validate;

create unique index xmad_pk on xmad_t (xmadent,xmadsite,xmad001,xmad002,xmad003);

grant select on xmad_t to tiptop;
grant update on xmad_t to tiptop;
grant delete on xmad_t to tiptop;
grant insert on xmad_t to tiptop;

exit;
