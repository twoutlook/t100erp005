/* 
================================================================================
檔案代號:srdb_t
檔案名稱:重複性生產當期在制狀況單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table srdb_t
(
srdbent       number(5)      ,/* 企業代碼 */
srdbsite       varchar2(10)      ,/* 營運據點 */
srdbseq       number(10,0)      ,/* 項次 */
srdb000       number(5,0)      ,/* 年度 */
srdb001       number(5,0)      ,/* 期別 */
srdb002       varchar2(10)      ,/* 生產計劃 */
srdb003       varchar2(40)      ,/* 料件編號 */
srdb004       varchar2(30)      ,/* BOM特性 */
srdb005       varchar2(256)      ,/* 產品特征 */
srdb006       varchar2(40)      ,/* 元件料號 */
srdb007       varchar2(256)      ,/* 產品特征 */
srdb008       number(20,6)      ,/* 上期結存 */
srdb009       number(20,6)      ,/* 本期投入 */
srdb010       number(20,6)      ,/* 本期轉出 */
srdb011       number(20,6)      ,/* 調整后本期轉出 */
srdb012       number(20,6)      ,/* 本期結存 */
srdb013       number(20,6)      /* 調整后本期結存 */
);
alter table srdb_t add constraint srdb_pk primary key (srdbent,srdbsite,srdbseq,srdb000,srdb001,srdb002,srdb003,srdb004,srdb005) enable validate;

create unique index srdb_pk on srdb_t (srdbent,srdbsite,srdbseq,srdb000,srdb001,srdb002,srdb003,srdb004,srdb005);

grant select on srdb_t to tiptop;
grant update on srdb_t to tiptop;
grant delete on srdb_t to tiptop;
grant insert on srdb_t to tiptop;

exit;
