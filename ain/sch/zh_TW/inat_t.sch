/* 
================================================================================
檔案代號:inat_t
檔案名稱:料件庫存期間/月統計檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table inat_t
(
inatent       number(5)      ,/* 企業編號 */
inatsite       varchar2(10)      ,/* 營運據點 */
inat001       varchar2(40)      ,/* 料件編號 */
inat002       varchar2(256)      ,/* 產品特徵 */
inat003       varchar2(30)      ,/* 庫存管理特徵 */
inat004       varchar2(10)      ,/* 庫位編號 */
inat005       varchar2(10)      ,/* 儲位編號 */
inat006       varchar2(30)      ,/* 批號 */
inat007       varchar2(10)      ,/* 庫存單位 */
inat008       number(5,0)      ,/* 年度 */
inat009       number(5,0)      ,/* 期別 */
inat010       number(20,6)      ,/* 本期入庫統計量 */
inat011       number(20,6)      ,/* 本期銷貨統計量 */
inat012       number(20,6)      ,/* 本期領用統計量 */
inat013       number(20,6)      ,/* 本期轉撥統計量 */
inat014       number(20,6)      ,/* 本期調整統計量 */
inat015       number(20,6)      ,/* 期末數量 */
inat016       number(20,6)      ,/* 參考單位-本期入庫統計量 */
inat017       number(20,6)      ,/* 參考單位-本期銷貨統計量 */
inat018       number(20,6)      ,/* 參考單位-本期領用統計量 */
inat019       number(20,6)      ,/* 參考單位-本期轉撥統計量 */
inat020       number(20,6)      ,/* 參考單位-本期調整統計量 */
inat021       number(20,6)      ,/* 參考單位-期末數量 */
inat022       varchar2(256)      /* Tag二進位碼 */
);
alter table inat_t add constraint inat_pk primary key (inatent,inatsite,inat001,inat002,inat003,inat004,inat005,inat006,inat007,inat008,inat009) enable validate;

create unique index inat_pk on inat_t (inatent,inatsite,inat001,inat002,inat003,inat004,inat005,inat006,inat007,inat008,inat009);

grant select on inat_t to tiptop;
grant update on inat_t to tiptop;
grant delete on inat_t to tiptop;
grant insert on inat_t to tiptop;

exit;
