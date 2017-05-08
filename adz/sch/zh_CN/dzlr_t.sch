/* 
================================================================================
檔案代號:dzlr_t
檔案名稱:需求單(for客戶)
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzlr_t
(
dzlr001       varchar2(20)      ,/* 需求單號 */
dzlr002       varchar2(10)      ,/* 產品代號 */
dzlr003       varchar2(20)      ,/* 產品版本 */
dzlr004       varchar2(40)      ,/* 客戶代號 */
dzlr005       varchar2(5)      ,/* 階段 */
dzlr006       varchar2(5)      ,/* 前階 */
dzlr007       varchar2(20)      ,/* 作業代號 */
dzlr008       varchar2(20)      ,/* 發起人 */
dzlr009       varchar2(1000)      ,/* 需求摘要 */
dzlr010       date      ,/* 發起日 */
dzlr011       varchar2(20)      ,/* 承辦人 */
dzlr012       varchar2(1000)      ,/* 處理摘要 */
dzlr013       date      ,/* 預完日 */
dzlr014       date      ,/* 實完日 */
dzlr015       varchar2(2000)      /* 開發日誌 */
);
alter table dzlr_t add constraint dzlr_pk primary key (dzlr001,dzlr002,dzlr003) enable validate;

create unique index dzlr_pk on dzlr_t (dzlr001,dzlr002,dzlr003);

grant select on dzlr_t to tiptop;
grant update on dzlr_t to tiptop;
grant delete on dzlr_t to tiptop;
grant insert on dzlr_t to tiptop;

exit;
