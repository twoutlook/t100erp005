/* 
================================================================================
檔案代號:stbz_t
檔案名稱:自營費用單匯入資料暫存表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table stbz_t
(
stbzent       number(5)      ,/* 企業代碼 */
stbzsite       varchar2(10)      ,/* 營運據點 */
stbzdocdt       date      ,/* 單據日期 */
stbz001       varchar2(20)      ,/* 來源單號 */
stbz002       varchar2(20)      ,/* 合同編號 */
stbz003       varchar2(10)      ,/* 費用編號 */
stbz004       date      ,/* 起始日期 */
stbz005       date      ,/* 截止日期 */
stbz006       number(20,6)      ,/* 費用金額 */
stbz007       varchar2(255)      ,/* 備註 */
stbz008       varchar2(10)      /* 供應商編號 */
);


grant select on stbz_t to tiptop;
grant update on stbz_t to tiptop;
grant delete on stbz_t to tiptop;
grant insert on stbz_t to tiptop;

exit;
