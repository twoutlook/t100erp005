/* 
================================================================================
檔案代號:oojdl_t
檔案名稱:渠道基本資料檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table oojdl_t
(
oojdlent       number(5)      ,/* 企業編號 */
oojdl001       varchar2(10)      ,/* 渠道編號 */
oojdl002       varchar2(6)      ,/* 語言別 */
oojdl003       varchar2(500)      ,/* 說明 */
oojdl004       varchar2(10)      /* 助記碼 */
);
alter table oojdl_t add constraint oojdl_pk primary key (oojdlent,oojdl001,oojdl002) enable validate;

create unique index oojdl_pk on oojdl_t (oojdlent,oojdl001,oojdl002);

grant select on oojdl_t to tiptop;
grant update on oojdl_t to tiptop;
grant delete on oojdl_t to tiptop;
grant insert on oojdl_t to tiptop;

exit;
