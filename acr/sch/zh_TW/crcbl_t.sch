/* 
================================================================================
檔案代號:crcbl_t
檔案名稱:客戶調查問卷資料檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table crcbl_t
(
crcblent       number(5)      ,/* 企業編號 */
crcbl001       varchar2(10)      ,/* 調查問卷編號 */
crcbl002       varchar2(6)      ,/* 語言別 */
crcbl003       varchar2(500)      ,/* 說明 */
crcbl004       varchar2(10)      /* 助記碼 */
);
alter table crcbl_t add constraint crcbl_pk primary key (crcblent,crcbl001,crcbl002) enable validate;

create unique index crcbl_pk on crcbl_t (crcblent,crcbl001,crcbl002);

grant select on crcbl_t to tiptop;
grant update on crcbl_t to tiptop;
grant delete on crcbl_t to tiptop;
grant insert on crcbl_t to tiptop;

exit;
