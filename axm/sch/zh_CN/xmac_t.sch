/* 
================================================================================
檔案代號:xmac_t
檔案名稱:交易對象信用餘額檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table xmac_t
(
xmacent       number(5)      ,/* 企業編號 */
xmacsite       varchar2(10)      ,/* 營運據點 */
xmac001       varchar2(10)      ,/* 額度客戶 */
xmac002       varchar2(10)      ,/* 額度計算幣別 */
xmac003       number(20,6)      ,/* NO USE */
xmac004       number(20,6)      ,/* NO USE */
xmac011       number(20,6)      ,/* 訂單未出貨金額 */
xmac012       number(20,6)      ,/* 出通單金額 */
xmac013       number(20,6)      ,/* 出貨未開發票金額 */
xmac014       number(20,6)      ,/* 銷退折讓金額 */
xmac015       number(20,6)      ,/* 發票應收帳款 */
xmac016       number(20,6)      ,/* 未兌現應收票據 */
xmac017       number(20,6)      ,/* 應收帳款已沖帳金額 */
xmac018       number(20,6)      ,/* 已收款未沖銷 */
xmac019       number(20,6)      ,/* 待抵帳款金額 */
xmac041       number(20,6)      ,/* 採購未收貨金額 */
xmac042       number(20,6)      ,/* 收貨未入庫金額 */
xmac043       number(20,6)      ,/* 入庫未立應付金額 */
xmac044       number(20,6)      ,/* 倉退金額 */
xmac045       number(20,6)      ,/* 發票應付金額 */
xmac046       number(20,6)      ,/* 應付待抵金額 */
xmac047       number(20,6)      ,/* 已沖帳金額 */
xmac048       number(20,6)      /* 未兌現應付票據金額 */
);
alter table xmac_t add constraint xmac_pk primary key (xmacent,xmacsite,xmac001) enable validate;

create unique index xmac_pk on xmac_t (xmacent,xmacsite,xmac001);

grant select on xmac_t to tiptop;
grant update on xmac_t to tiptop;
grant delete on xmac_t to tiptop;
grant insert on xmac_t to tiptop;

exit;
