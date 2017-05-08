/* 
================================================================================
檔案代號:faadl_t
檔案名稱:固定資產次要類型檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table faadl_t
(
faadlent       number(5)      ,/* 企業編號 */
faadl001       varchar2(10)      ,/* 次要類型編號 */
faadl002       varchar2(6)      ,/* 語言別 */
faadl003       varchar2(500)      /* 說明 */
);
alter table faadl_t add constraint faadl_pk primary key (faadlent,faadl001,faadl002) enable validate;

create unique index faadl_pk on faadl_t (faadlent,faadl001,faadl002);

grant select on faadl_t to tiptop;
grant update on faadl_t to tiptop;
grant delete on faadl_t to tiptop;
grant insert on faadl_t to tiptop;

exit;
