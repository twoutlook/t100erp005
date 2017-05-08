/* 
================================================================================
檔案代號:nmaal_t
檔案名稱:銀行資料多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table nmaal_t
(
nmaalent       number(5)      ,/* 企業編號 */
nmaal001       varchar2(24)      ,/* 帳戶編號哦 */
nmaal002       varchar2(6)      ,/* 語言別 */
nmaal003       varchar2(500)      /* 說明 */
);
alter table nmaal_t add constraint nmaal_pk primary key (nmaalent,nmaal001,nmaal002) enable validate;

create unique index nmaal_pk on nmaal_t (nmaalent,nmaal001,nmaal002);

grant select on nmaal_t to tiptop;
grant update on nmaal_t to tiptop;
grant delete on nmaal_t to tiptop;
grant insert on nmaal_t to tiptop;

exit;
