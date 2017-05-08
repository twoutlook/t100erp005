/* 
================================================================================
檔案代號:preal_t
檔案名稱:促銷談判條件單頭資料表多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table preal_t
(
prealent       number(5)      ,/* 企業編號 */
prealdocno       varchar2(20)      ,/* 促銷談判單號 */
preal001       varchar2(6)      ,/* 語言別 */
preal002       varchar2(500)      ,/* 說明 */
preal003       varchar2(10)      /* 助記碼 */
);
alter table preal_t add constraint preal_pk primary key (prealent,prealdocno,preal001) enable validate;

create unique index preal_pk on preal_t (prealent,prealdocno,preal001);

grant select on preal_t to tiptop;
grant update on preal_t to tiptop;
grant delete on preal_t to tiptop;
grant insert on preal_t to tiptop;

exit;
