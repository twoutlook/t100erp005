/* 
================================================================================
檔案代號:mhadl_t
檔案名稱:場地基本資料檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table mhadl_t
(
mhadlent       number(5)      ,/* 企業編號 */
mhadl001       varchar2(10)      ,/* 樓棟編號 */
mhadl002       varchar2(10)      ,/* 樓層編號 */
mhadl003       varchar2(10)      ,/* 區域編號 */
mhadl004       varchar2(10)      ,/* 場地編號 */
mhadl005       varchar2(6)      ,/* 語言別 */
mhadl006       varchar2(500)      ,/* 說明 */
mhadl007       varchar2(10)      /* 助記碼 */
);
alter table mhadl_t add constraint mhadl_pk primary key (mhadlent,mhadl001,mhadl002,mhadl003,mhadl004,mhadl005) enable validate;

create unique index mhadl_pk on mhadl_t (mhadlent,mhadl001,mhadl002,mhadl003,mhadl004,mhadl005);

grant select on mhadl_t to tiptop;
grant update on mhadl_t to tiptop;
grant delete on mhadl_t to tiptop;
grant insert on mhadl_t to tiptop;

exit;
