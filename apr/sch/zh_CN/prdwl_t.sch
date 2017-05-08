/* 
================================================================================
檔案代號:prdwl_t
檔案名稱:促銷規則清單資料多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:Y
============.========================.==========================================
 */
create table prdwl_t
(
prdwlent       number(5)      ,/* 企業編號 */
prdwlsite       varchar2(10)      ,/* 營運據點 */
prdwl001       varchar2(20)      ,/* 規則編號 */
prdwl002       varchar2(6)      ,/* 語言別 */
prdwl003       varchar2(500)      ,/* 說明 */
prdwl004       varchar2(10)      /* 助記碼 */
);
alter table prdwl_t add constraint prdwl_pk primary key (prdwlent,prdwlsite,prdwl001,prdwl002) enable validate;

create unique index prdwl_pk on prdwl_t (prdwlent,prdwlsite,prdwl001,prdwl002);

grant select on prdwl_t to tiptop;
grant update on prdwl_t to tiptop;
grant delete on prdwl_t to tiptop;
grant insert on prdwl_t to tiptop;

exit;
