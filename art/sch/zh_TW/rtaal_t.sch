/* 
================================================================================
檔案代號:rtaal_t
檔案名稱:店群基本資料多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table rtaal_t
(
rtaalent       number(5)      ,/* 企業編號 */
rtaal001       varchar2(10)      ,/* 店群編號 */
rtaal002       varchar2(6)      ,/* 語言別 */
rtaal003       varchar2(500)      ,/* 說明 */
rtaal004       varchar2(10)      /* 助記碼 */
);
alter table rtaal_t add constraint rtaal_pk primary key (rtaalent,rtaal001,rtaal002) enable validate;

create unique index rtaal_pk on rtaal_t (rtaalent,rtaal001,rtaal002);

grant select on rtaal_t to tiptop;
grant update on rtaal_t to tiptop;
grant delete on rtaal_t to tiptop;
grant insert on rtaal_t to tiptop;

exit;
