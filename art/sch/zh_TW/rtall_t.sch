/* 
================================================================================
檔案代號:rtall_t
檔案名稱:門店資源信息資料當多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table rtall_t
(
rtallent       number(5)      ,/* 企業編號 */
rtall001       varchar2(10)      ,/* 資源編號 */
rtall002       varchar2(6)      ,/* 語言別 */
rtall003       varchar2(500)      ,/* 說明 */
rtall004       varchar2(10)      /* 助記碼 */
);
alter table rtall_t add constraint rtall_pk primary key (rtallent,rtall001,rtall002) enable validate;

create unique index rtall_pk on rtall_t (rtallent,rtall001,rtall002);

grant select on rtall_t to tiptop;
grant update on rtall_t to tiptop;
grant delete on rtall_t to tiptop;
grant insert on rtall_t to tiptop;

exit;
