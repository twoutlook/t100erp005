/* 
================================================================================
檔案代號:pcaal_t
檔案名稱:收銀機基本資料檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table pcaal_t
(
pcaalent       number(5)      ,/* 企業編號 */
pcaalsite       varchar2(10)      ,/* 營運據點 */
pcaal001       varchar2(10)      ,/* 收銀機編號 */
pcaal002       varchar2(6)      ,/* 語言別 */
pcaal003       varchar2(500)      ,/* 說明 */
pcaal004       varchar2(10)      /* 助記碼 */
);
alter table pcaal_t add constraint pcaal_pk primary key (pcaalent,pcaalsite,pcaal001,pcaal002) enable validate;

create unique index pcaal_pk on pcaal_t (pcaalent,pcaalsite,pcaal001,pcaal002);

grant select on pcaal_t to tiptop;
grant update on pcaal_t to tiptop;
grant delete on pcaal_t to tiptop;
grant insert on pcaal_t to tiptop;

exit;
