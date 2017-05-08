/* 
================================================================================
檔案代號:glaj_t
檔案名稱:自由核算項資料多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table glaj_t
(
glajent       number(5)      ,/* 企業編號 */
glaj001       varchar2(5)      ,/* 會計科目參照表號 */
glaj002       varchar2(24)      ,/* 會計科目編號 */
glaj003       number(5,0)      ,/* 自由核算項1~10 */
glaj004       varchar2(30)      ,/* 自由核算項值 */
glaj005       varchar2(6)      ,/* 語言別 */
glaj006       varchar2(80)      ,/* 說明 */
glaj007       varchar2(10)      /* 助記碼 */
);
alter table glaj_t add constraint glaj_pk primary key (glajent,glaj001,glaj002,glaj003,glaj004,glaj005) enable validate;

create unique index glaj_pk on glaj_t (glajent,glaj001,glaj002,glaj003,glaj004,glaj005);

grant select on glaj_t to tiptop;
grant update on glaj_t to tiptop;
grant delete on glaj_t to tiptop;
grant insert on glaj_t to tiptop;

exit;
