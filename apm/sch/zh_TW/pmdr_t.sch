/* 
================================================================================
檔案代號:pmdr_t
檔案名稱:供應商庫存開賬excel導入中轉檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table pmdr_t
(
pmdrent       number(5)      ,/* 企業代碼 */
pmdrdocno       varchar2(20)      ,/* 單號 */
pmdrsite       varchar2(10)      ,/* 營運據點 */
pmdrdocdt       date      ,/* 單據日期 */
pmdr001       varchar2(10)      ,/* 供應商編號 */
pmdr002       varchar2(40)      ,/* 商品編號 */
pmdr003       varchar2(10)      ,/* 稅別 */
pmdr004       varchar2(10)      ,/* 庫區編號 */
pmdr005       varchar2(10)      ,/* 儲位 */
pmdr006       varchar2(30)      ,/* 批號 */
pmdr007       number(20,6)      ,/* 數量 */
pmdr008       number(20,6)      ,/* 成本價 */
pmdr009       number(20,6)      ,/* 金額 */
pmdr010       number(20,6)      ,/* 售價 */
pmdr011       varchar2(1)      /* 已寫入 */
);


grant select on pmdr_t to tiptop;
grant update on pmdr_t to tiptop;
grant delete on pmdr_t to tiptop;
grant insert on pmdr_t to tiptop;

exit;
