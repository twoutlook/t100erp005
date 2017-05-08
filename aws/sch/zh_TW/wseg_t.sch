/* 
================================================================================
檔案代號:wseg_t
檔案名稱:中臺企業編碼權限設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table wseg_t
(
wseg001       number(5)      ,/* 企業編號 */
wseg002       varchar2(1)      /* 下放否 */
);
alter table wseg_t add constraint wseg_pk primary key (wseg001) enable validate;

create unique index wseg_pk on wseg_t (wseg001);

grant select on wseg_t to tiptop;
grant update on wseg_t to tiptop;
grant delete on wseg_t to tiptop;
grant insert on wseg_t to tiptop;

exit;
