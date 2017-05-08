/* 
================================================================================
檔案代號:prem_t
檔案名稱:aprt310促銷談判條件申請檔excel匯入使用中間表2
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table prem_t
(
prement       number(5)      ,/* 企業代碼 */
premsite       varchar2(10)      ,/* 營運據點 */
prem1003       varchar2(30)      ,/* 促銷方案編號 */
prem2003       date      ,/* 開始日期 */
prem2004       date      ,/* 結束日期 */
prem1004       varchar2(10)      ,/* 促銷方式 */
prem1005       varchar2(10)      ,/* 換贈對象 */
prem1006       varchar2(10)      ,/* 換贈編號 */
prem3003       varchar2(10)      ,/* 庫區編號 */
prem30030       varchar2(500)      ,/* 庫區名稱 */
prem3004       varchar2(10)      ,/* 專櫃編號 */
prem30040       varchar2(500)      ,/* 專櫃名稱 */
prem4004       varchar2(10)      ,/* 類型 */
prem4006       number(20,6)      ,/* 起始金額 */
prem4005       number(20,6)      ,/* 截止金額 */
prem4007       number(20,6)      ,/* 執行扣率 */
prem1051       varchar2(10)      ,/* 主題分類 */
prem1052       varchar2(10)      /* 促銷類型 */
);


grant select on prem_t to tiptop;
grant update on prem_t to tiptop;
grant delete on prem_t to tiptop;
grant insert on prem_t to tiptop;

exit;
