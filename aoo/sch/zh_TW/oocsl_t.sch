/* 
================================================================================
檔案代號:oocsl_t
檔案名稱:國際標準單位檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table oocsl_t
(
oocslent       number(5)      ,/* 企業編號 */
oocsl001       varchar2(10)      ,/* ISO單位代碼 */
oocsl002       varchar2(6)      ,/* 語言別 */
oocsl003       varchar2(500)      ,/* 說明 */
oocsl004       varchar2(10)      /* 助記碼 */
);
alter table oocsl_t add constraint oocsl_pk primary key (oocslent,oocsl001,oocsl002) enable validate;

create unique index oocsl_pk on oocsl_t (oocslent,oocsl001,oocsl002);

grant select on oocsl_t to tiptop;
grant update on oocsl_t to tiptop;
grant delete on oocsl_t to tiptop;
grant insert on oocsl_t to tiptop;

exit;
