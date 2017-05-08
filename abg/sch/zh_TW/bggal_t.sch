/* 
================================================================================
檔案代號:bggal_t
檔案名稱:職級職等檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table bggal_t
(
bggalent       number(5)      ,/* 企業編號 */
bggal001       varchar2(10)      ,/* 崗位劃分標準 */
bggal002       varchar2(10)      ,/* 編號 */
bggal003       varchar2(6)      ,/* 語言別 */
bggal004       varchar2(500)      ,/* 說明 */
bggal005       varchar2(10)      /* 助記碼 */
);
alter table bggal_t add constraint bggal_pk primary key (bggalent,bggal001,bggal002,bggal003) enable validate;

create unique index bggal_pk on bggal_t (bggalent,bggal001,bggal002,bggal003);

grant select on bggal_t to tiptop;
grant update on bggal_t to tiptop;
grant delete on bggal_t to tiptop;
grant insert on bggal_t to tiptop;

exit;
