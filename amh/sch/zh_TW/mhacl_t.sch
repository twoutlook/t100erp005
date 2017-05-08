/* 
================================================================================
檔案代號:mhacl_t
檔案名稱:區域基本資料檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table mhacl_t
(
mhaclent       number(5)      ,/* 企業編號 */
mhacl001       varchar2(10)      ,/* 樓棟編號 */
mhacl002       varchar2(10)      ,/* 樓層編號 */
mhacl003       varchar2(10)      ,/* 區域編號 */
mhacl004       varchar2(6)      ,/* 語言別 */
mhacl005       varchar2(500)      ,/* 說明 */
mhacl006       varchar2(10)      /* 助記碼 */
);
alter table mhacl_t add constraint mhacl_pk primary key (mhaclent,mhacl001,mhacl002,mhacl003,mhacl004) enable validate;

create unique index mhacl_pk on mhacl_t (mhaclent,mhacl001,mhacl002,mhacl003,mhacl004);

grant select on mhacl_t to tiptop;
grant update on mhacl_t to tiptop;
grant delete on mhacl_t to tiptop;
grant insert on mhacl_t to tiptop;

exit;
