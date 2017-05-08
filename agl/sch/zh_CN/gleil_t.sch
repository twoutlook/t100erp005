/* 
================================================================================
檔案代號:gleil_t
檔案名稱:合併現金流量表現金變動碼資料檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table gleil_t
(
gleilent       number(5)      ,/* 企業編號 */
gleil001       varchar2(5)      ,/* 群組參照表碼 */
gleil002       varchar2(10)      ,/* 群組編號 */
gleil003       varchar2(6)      ,/* 語言別 */
gleil004       varchar2(500)      ,/* 說明 */
gleil005       varchar2(10)      /* 助記碼 */
);
alter table gleil_t add constraint gleil_pk primary key (gleilent,gleil001,gleil002,gleil003) enable validate;

create unique index gleil_pk on gleil_t (gleilent,gleil001,gleil002,gleil003);

grant select on gleil_t to tiptop;
grant update on gleil_t to tiptop;
grant delete on gleil_t to tiptop;
grant insert on gleil_t to tiptop;

exit;
