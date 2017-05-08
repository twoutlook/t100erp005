/* 
================================================================================
檔案代號:dzaf_t
檔案名稱:版本樹
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzaf_t
(
dzaf001       varchar2(20)      ,/* 建構代號 */
dzaf002       number(10)      ,/* 建構版號 */
dzaf003       number(10)      ,/* 規格版號 */
dzaf004       number(10)      ,/* 代碼版號 */
dzaf005       varchar2(10)      ,/* 建構類型 */
dzaf006       varchar2(10)      ,/* 模組 */
dzaf007       varchar2(10)      ,/* 產品代號 */
dzaf008       varchar2(10)      ,/* 產品版本 */
dzaf009       varchar2(40)      ,/* 客戶代號 */
dzaf010       varchar2(1)      /* 識別標示 */
);
alter table dzaf_t add constraint dzaf_pk primary key (dzaf001,dzaf002,dzaf005,dzaf010) enable validate;

create unique index dzaf_pk on dzaf_t (dzaf001,dzaf002,dzaf005,dzaf010);

grant select on dzaf_t to tiptop;
grant update on dzaf_t to tiptop;
grant delete on dzaf_t to tiptop;
grant insert on dzaf_t to tiptop;

exit;
