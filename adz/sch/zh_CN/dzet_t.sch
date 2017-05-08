/* 
================================================================================
檔案代號:dzet_t
檔案名稱:助記碼設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzet_t
(
dzet001       varchar2(15)      ,/* Table代號 */
dzet002       varchar2(20)      ,/* 對應欄位 */
dzet003       varchar2(15)      ,/* 助記碼Table */
dzet004       varchar2(80)      ,/* 助記碼搜尋欄位 */
dzet005       varchar2(20)      ,/* 助記碼欄位 */
dzet006       varchar2(20)      ,/* 助記碼語系 */
dzet007       varchar2(255)      ,/* 其他條件 */
dzetownid       varchar2(20)      ,/* 資料所有者 */
dzetowndp       varchar2(10)      ,/* 資料所屬部門 */
dzetcrtid       varchar2(20)      ,/* 資料建立者 */
dzetcrtdp       varchar2(10)      ,/* 資料建立部門 */
dzetcrtdt       timestamp(0)      ,/* 資料創建日 */
dzetmodid       varchar2(20)      ,/* 資料修改者 */
dzetmoddt       timestamp(0)      ,/* 最近修改日 */
dzetstus       varchar2(10)      /* 狀態碼 */
);
alter table dzet_t add constraint dzet_pk primary key (dzet001,dzet002) enable validate;

create unique index dzet_pk on dzet_t (dzet001,dzet002);

grant select on dzet_t to tiptop;
grant update on dzet_t to tiptop;
grant delete on dzet_t to tiptop;
grant insert on dzet_t to tiptop;

exit;
