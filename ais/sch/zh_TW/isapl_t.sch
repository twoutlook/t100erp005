/* 
================================================================================
檔案代號:isapl_t
檔案名稱:媒體申報格式檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table isapl_t
(
isaplent       number(5)      ,/* 企業編號 */
isapl001       varchar2(10)      ,/* 交易稅區 */
isapl002       varchar2(10)      ,/* 媒體申報格式 */
isapl003       varchar2(6)      ,/* 語言別 */
isapl004       varchar2(500)      ,/* 說明 */
isapl005       varchar2(10)      /* 助記碼 */
);
alter table isapl_t add constraint isapl_pk primary key (isaplent,isapl001,isapl002,isapl003) enable validate;

create unique index isapl_pk on isapl_t (isaplent,isapl001,isapl002,isapl003);

grant select on isapl_t to tiptop;
grant update on isapl_t to tiptop;
grant delete on isapl_t to tiptop;
grant insert on isapl_t to tiptop;

exit;
