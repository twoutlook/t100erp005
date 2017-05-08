/* 
================================================================================
檔案代號:dzak_t
檔案名稱:欄位助記碼設計表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzak_t
(
dzakstus       varchar2(10)      ,/* no use */
dzak001       varchar2(20)      ,/* 規格編號 */
dzak002       varchar2(60)      ,/* 控件編號 */
dzak003       number(10)      ,/* 識別碼版次 */
dzak004       varchar2(1)      ,/* 使用標示 */
dzak005       varchar2(255)      ,/* 其他條件 */
dzak007       varchar2(80)      ,/* 助記碼搜尋欄位 */
dzak008       varchar2(15)      ,/* 助記碼Table */
dzak009       varchar2(20)      ,/* 助記碼欄位 */
dzak010       varchar2(20)      ,/* 助記碼語系 */
dzak011       varchar2(255)      ,/* 回傳對應控件 */
dzakownid       varchar2(20)      ,/* 資料所有者 */
dzakowndp       varchar2(10)      ,/* 資料所屬部門 */
dzakcrtid       varchar2(20)      ,/* 資料建立者 */
dzakcrtdp       varchar2(10)      ,/* 資料建立部門 */
dzakcrtdt       timestamp(0)      ,/* 資料創建日 */
dzakmodid       varchar2(20)      ,/* 資料修改者 */
dzakmoddt       timestamp(0)      ,/* 最近修改日 */
dzak012       varchar2(40)      /* 客戶代號 */
);
alter table dzak_t add constraint dzak_pk primary key (dzak001,dzak002,dzak003,dzak004) enable validate;

create unique index dzak_pk on dzak_t (dzak001,dzak002,dzak003,dzak004);

grant select on dzak_t to tiptop;
grant update on dzak_t to tiptop;
grant delete on dzak_t to tiptop;
grant insert on dzak_t to tiptop;

exit;
