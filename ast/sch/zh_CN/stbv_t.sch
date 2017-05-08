/* 
================================================================================
檔案代號:stbv_t
檔案名稱:專櫃費用單導入資料暫存檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table stbv_t
(
stbvent       number(5)      ,/* 企業代碼 */
stbvsite       varchar2(10)      ,/* 營運據點 */
stbvdocdt       date      ,/* 單據日期 */
stbv001       varchar2(20)      ,/* 來源單號 */
stbv002       varchar2(10)      ,/* 專櫃編號 */
stbv003       varchar2(10)      ,/* 費用編號 */
stbv004       date      ,/* 起始日期 */
stbv005       date      ,/* 截止日期 */
stbv006       number(20,6)      ,/* 費用金額 */
stbv007       varchar2(255)      /* 備註 */
);


grant select on stbv_t to tiptop;
grant update on stbv_t to tiptop;
grant delete on stbv_t to tiptop;
grant insert on stbv_t to tiptop;

exit;
