/* 
================================================================================
檔案代號:mhaal_t
檔案名稱:樓棟基本資料檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table mhaal_t
(
mhaalent       number(5)      ,/* 企業編號 */
mhaal001       varchar2(10)      ,/* 樓棟編號 */
mhaal002       varchar2(6)      ,/* 語言別 */
mhaal003       varchar2(500)      ,/* 說明 */
mhaal004       varchar2(10)      /* 助記碼 */
);
alter table mhaal_t add constraint mhaal_pk primary key (mhaalent,mhaal001,mhaal002) enable validate;

create unique index mhaal_pk on mhaal_t (mhaalent,mhaal001,mhaal002);

grant select on mhaal_t to tiptop;
grant update on mhaal_t to tiptop;
grant delete on mhaal_t to tiptop;
grant insert on mhaal_t to tiptop;

exit;
