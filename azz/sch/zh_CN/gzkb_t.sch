/* 
================================================================================
檔案代號:gzkb_t
檔案名稱:連絡對象
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table gzkb_t
(
gzkb001       varchar2(20)      ,/* 作業編號 */
gzkb002       varchar2(80)      ,/* 功能選項 */
gzkb003       varchar2(1)      ,/* 類型 */
gzkb004       varchar2(20)      ,/* 連絡對象 */
gzkb005       varchar2(80)      ,/* 說明 */
gzkb006       varchar2(1)      ,/* 通訊類型 */
gzkb007       varchar2(255)      ,/* 通訊內容 */
gzkb008       varchar2(1)      ,/* 關連層級通知 */
gzkb009       varchar2(1)      ,/* 通知條件 */
gzkb010       varchar2(10)      ,/* 條件內容 */
gzkb011       varchar2(1)      ,/* 報表郵件類別 */
gzkb012       varchar2(1)      ,/* 報表寄件格式 */
gzkb013       varchar2(1)      ,/* 設定類別 */
gzkbent       number(5)      /* 企業代碼 */
);
alter table gzkb_t add constraint gzkb_pk primary key (gzkb001,gzkb002,gzkb003,gzkb004,gzkb009,gzkb010,gzkb013,gzkbent) enable validate;

create unique index gzkb_pk on gzkb_t (gzkb001,gzkb002,gzkb003,gzkb004,gzkb009,gzkb010,gzkb013,gzkbent);

grant select on gzkb_t to tiptop;
grant update on gzkb_t to tiptop;
grant delete on gzkb_t to tiptop;
grant insert on gzkb_t to tiptop;

exit;
