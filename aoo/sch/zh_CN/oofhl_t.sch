/* 
================================================================================
檔案代號:oofhl_t
檔案名稱:自動編碼可選項多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table oofhl_t
(
oofhlent       number(5)      ,/* 企業編號 */
oofhl001       varchar2(10)      ,/* 編碼分類 */
oofhl002       varchar2(10)      ,/* 節點編號 */
oofhl003       varchar2(10)      ,/* 選項值 */
oofhl004       varchar2(6)      ,/* 語言別 */
oofhl005       varchar2(500)      ,/* 說明 */
oofhl006       varchar2(10)      /* 助記碼 */
);
alter table oofhl_t add constraint oofhl_pk primary key (oofhlent,oofhl001,oofhl002,oofhl003,oofhl004) enable validate;

create  index oofhl_01 on oofhl_t (oofhl006);
create unique index oofhl_pk on oofhl_t (oofhlent,oofhl001,oofhl002,oofhl003,oofhl004);

grant select on oofhl_t to tiptop;
grant update on oofhl_t to tiptop;
grant delete on oofhl_t to tiptop;
grant insert on oofhl_t to tiptop;

exit;
