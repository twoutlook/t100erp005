/* 
================================================================================
檔案代號:dzcc_t
檔案名稱:開窗顯現設定表格
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzcc_t
(
dzccstus       varchar2(10)      ,/* 狀態碼 */
dzcc001       varchar2(20)      ,/* 開窗識別碼 */
dzcc002       number(10,0)      ,/* 顯現順序 */
dzcc003       varchar2(15)      ,/* 欄位代號 */
dzcc004       varchar2(20)      ,/* 顯示控件 */
dzcc005       varchar2(1)      ,/* 是否回傳 */
dzcc006       varchar2(10)      ,/* 資料大小寫 */
dzcc007       varchar2(1)      ,/* no use */
dzccownid       varchar2(20)      ,/* 資料所有者 */
dzccowndp       varchar2(10)      ,/* 資料所屬部門 */
dzcccrtid       varchar2(20)      ,/* 資料建立者 */
dzcccrtdp       varchar2(10)      ,/* 資料建立部門 */
dzcccrtdt       timestamp(0)      ,/* 資料創建日 */
dzccmodid       varchar2(20)      ,/* 資料修改者 */
dzccmoddt       timestamp(0)      ,/* 最近修改日 */
dzcc008       varchar2(15)      ,/* 對應表格別名 */
dzcc009       varchar2(1)      ,/* 客製 */
dzcc010       varchar2(40)      /* 顯示格式 */
);
alter table dzcc_t add constraint dzcc_pk primary key (dzcc001,dzcc002,dzcc009) enable validate;

create unique index dzcc_pk on dzcc_t (dzcc001,dzcc002,dzcc009);

grant select on dzcc_t to tiptop;
grant update on dzcc_t to tiptop;
grant delete on dzcc_t to tiptop;
grant insert on dzcc_t to tiptop;

exit;
