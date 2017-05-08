/* 
================================================================================
檔案代號:prdll_t
檔案名稱:促銷規則單頭資料檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:Y
============.========================.==========================================
 */
create table prdll_t
(
prdllent       number(5)      ,/* 企業編號 */
prdllsite       varchar2(10)      ,/* 營運據點 */
prdll001       varchar2(20)      ,/* 規則編號 */
prdll002       varchar2(6)      ,/* 語言別 */
prdll003       varchar2(500)      ,/* 說明 */
prdll004       varchar2(10)      /* 助記碼 */
);
alter table prdll_t add constraint prdll_pk primary key (prdllent,prdll001,prdll002) enable validate;

create unique index prdll_pk on prdll_t (prdllent,prdll001,prdll002);

grant select on prdll_t to tiptop;
grant update on prdll_t to tiptop;
grant delete on prdll_t to tiptop;
grant insert on prdll_t to tiptop;

exit;
