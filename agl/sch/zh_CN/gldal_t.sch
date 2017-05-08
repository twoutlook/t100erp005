/* 
================================================================================
檔案代號:gldal_t
檔案名稱:個體公司基本資料檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table gldal_t
(
gldalent       number(5)      ,/* 企業代碼 */
gldal001       varchar2(10)      ,/* 公司編號 */
gldal002       varchar2(6)      ,/* 語言別 */
gldal003       varchar2(500)      ,/* 說明 */
gldal004       varchar2(10)      /* 助記碼 */
);
alter table gldal_t add constraint gldal_pk primary key (gldalent,gldal001,gldal002) enable validate;

create unique index gldal_pk on gldal_t (gldalent,gldal001,gldal002);

grant select on gldal_t to tiptop;
grant update on gldal_t to tiptop;
grant delete on gldal_t to tiptop;
grant insert on gldal_t to tiptop;

exit;
