/* 
================================================================================
檔案代號:nmabl_t
檔案名稱:銀行資料檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table nmabl_t
(
nmablent       number(5)      ,/* 企業編號 */
nmabl001       varchar2(15)      ,/* 銀行編號 */
nmabl002       varchar2(6)      ,/* 語言別 */
nmabl003       varchar2(500)      ,/* 簡稱 */
nmabl004       varchar2(500)      /* 全稱 */
);
alter table nmabl_t add constraint nmabl_pk primary key (nmablent,nmabl001,nmabl002) enable validate;

create unique index nmabl_pk on nmabl_t (nmablent,nmabl001,nmabl002);

grant select on nmabl_t to tiptop;
grant update on nmabl_t to tiptop;
grant delete on nmabl_t to tiptop;
grant insert on nmabl_t to tiptop;

exit;
