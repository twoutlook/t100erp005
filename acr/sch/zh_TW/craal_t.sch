/* 
================================================================================
檔案代號:craal_t
檔案名稱:潛在客戶資料檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:Y
============.========================.==========================================
 */
create table craal_t
(
craalent       number(5)      ,/* 企業編號 */
craal001       varchar2(10)      ,/* 潛在客戶編號 */
craal002       varchar2(6)      ,/* 語言別 */
craal003       varchar2(255)      ,/* 潛在客戶全名 */
craal004       varchar2(80)      ,/* 潛在客戶簡稱 */
craal005       varchar2(10)      /* 助記碼 */
);
alter table craal_t add constraint craal_pk primary key (craalent,craal001,craal002) enable validate;

create unique index craal_pk on craal_t (craalent,craal001,craal002);

grant select on craal_t to tiptop;
grant update on craal_t to tiptop;
grant delete on craal_t to tiptop;
grant insert on craal_t to tiptop;

exit;
