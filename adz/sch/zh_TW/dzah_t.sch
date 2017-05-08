/* 
================================================================================
檔案代號:dzah_t
檔案名稱:Action觸發時機設計表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table dzah_t
(
dzahstus       varchar2(10)      ,/* 狀態碼 */
dzah001       varchar2(20)      ,/* 規格編號 */
dzah002       varchar2(60)      ,/* Action識別碼 */
dzah003       varchar2(15)      ,/* 識別碼版次 */
dzah004       varchar2(1)      ,/* 識別碼使用標示 */
dzah005       varchar2(80)      ,/* 觸發時機 */
dzah006       varchar2(1)      ,/* 觸發時機使用標示 */
dzahownid       varchar2(10)      ,/* 資料所有者 */
dzahowndp       varchar2(10)      ,/* 資料所屬部門 */
dzahcrtid       varchar2(10)      ,/* 資料建立者 */
dzahcrtdp       varchar2(10)      ,/* 資料建立部門 */
dzahcrtdt       date      ,/* 資料創建日 */
dzahmodid       varchar2(10)      ,/* 資料修改者 */
dzahmoddt       date      /* 最近修改日 */
);
alter table dzah_t add constraint dzah_pk primary key (dzah001,dzah002,dzah003,dzah004,dzah005) enable validate;


grant select on dzah_t to tiptop;
grant update on dzah_t to tiptop;
grant delete on dzah_t to tiptop;
grant insert on dzah_t to tiptop;

exit;
