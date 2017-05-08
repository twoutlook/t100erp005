/* 
================================================================================
檔案代號:gzyal_t
檔案名稱:職能角色定義表多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table gzyal_t
(
gzyalent       number(5)      ,/* 企業編號 */
gzyal001       varchar2(10)      ,/* 職能角色編號 */
gzyal002       varchar2(6)      ,/* 語言別 */
gzyal003       varchar2(500)      ,/* 說明 */
gzyal004       varchar2(10)      /* 助記碼 */
);
alter table gzyal_t add constraint gzyal_pk primary key (gzyalent,gzyal001,gzyal002) enable validate;

create unique index gzyal_pk on gzyal_t (gzyalent,gzyal001,gzyal002);

grant select on gzyal_t to tiptop;
grant update on gzyal_t to tiptop;
grant delete on gzyal_t to tiptop;
grant insert on gzyal_t to tiptop;

exit;
