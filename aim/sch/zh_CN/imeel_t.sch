/* 
================================================================================
檔案代號:imeel_t
檔案名稱:規則化品名種類多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table imeel_t
(
imeelent       number(5)      ,/* 企業編號 */
imeel001       varchar2(10)      ,/* 品名種類 */
imeel002       varchar2(10)      ,/* 節點編號 */
imeel003       varchar2(6)      ,/* 語言別 */
imeel004       varchar2(500)      ,/* 說明 */
imeel005       varchar2(10)      /* 助記碼 */
);
alter table imeel_t add constraint imeel_pk primary key (imeelent,imeel001,imeel002,imeel003) enable validate;

create  index imeel_01 on imeel_t (imeel005);
create unique index imeel_pk on imeel_t (imeelent,imeel001,imeel002,imeel003);

grant select on imeel_t to tiptop;
grant update on imeel_t to tiptop;
grant delete on imeel_t to tiptop;
grant insert on imeel_t to tiptop;

exit;
