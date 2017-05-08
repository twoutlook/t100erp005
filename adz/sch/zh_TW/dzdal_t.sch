/* 
================================================================================
檔案代號:dzdal_t
檔案名稱:dzda_t元件基本檔的多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table dzdal_t
(
dzdal001       varchar2(40)      ,/* 元件代號 */
dzdal002       varchar2(6)      ,/* 語言別 */
dzdal003       varchar2(500)      ,/* 說明 */
dzdal004       varchar2(10)      /* 助記碼 */
);
alter table dzdal_t add constraint dzdal_pk primary key (dzdal001,dzdal002) enable validate;


grant select on dzdal_t to tiptop;
grant update on dzdal_t to tiptop;
grant delete on dzdal_t to tiptop;
grant insert on dzdal_t to tiptop;

exit;
