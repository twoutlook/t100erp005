/* 
================================================================================
檔案代號:prdal_t
檔案名稱:促銷規則申請單頭資料多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:Y
============.========================.==========================================
 */
create table prdal_t
(
prdalent       number(5)      ,/* 企業編號 */
prdaldocno       varchar2(20)      ,/* 申請單號 */
prdal001       varchar2(6)      ,/* 語言別 */
prdal002       varchar2(500)      ,/* 說明 */
prdal003       varchar2(10)      /* 助記碼 */
);
alter table prdal_t add constraint prdal_pk primary key (prdalent,prdaldocno,prdal001) enable validate;

create unique index prdal_pk on prdal_t (prdalent,prdaldocno,prdal001);

grant select on prdal_t to tiptop;
grant update on prdal_t to tiptop;
grant delete on prdal_t to tiptop;
grant insert on prdal_t to tiptop;

exit;
