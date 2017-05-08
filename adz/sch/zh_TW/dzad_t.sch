/* 
================================================================================
檔案代號:dzad_t
檔案名稱:Action規格設計表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzad_t
(
dzadstus       varchar2(10)      ,/* no use */
dzad001       varchar2(20)      ,/* 規格編號 */
dzad002       varchar2(60)      ,/* Action識別碼 */
dzad003       number(10)      ,/* 識別碼版次 */
dzad099       clob      ,/* 規格內容 */
dzad005       varchar2(1)      ,/* 使用標示 */
dzad006       varchar2(80)      ,/* 觸發時機 */
dzad007       varchar2(40)      ,/* 產生標準程式 */
dzadownid       varchar2(20)      ,/* 資料所有者 */
dzadowndp       varchar2(10)      ,/* 資料所屬部門 */
dzadcrtid       varchar2(20)      ,/* 資料建立者 */
dzadcrtdp       varchar2(10)      ,/* 資料建立部門 */
dzadcrtdt       timestamp(0)      ,/* 資料創建日 */
dzadmodid       varchar2(20)      ,/* 資料修改者 */
dzadmoddt       timestamp(0)      ,/* 最近修改日 */
dzad008       varchar2(40)      /* 客戶代號 */
);
alter table dzad_t add constraint dzad_pk primary key (dzad001,dzad002,dzad003,dzad005) enable validate;

create unique index dzad_pk on dzad_t (dzad001,dzad002,dzad003,dzad005);

grant select on dzad_t to tiptop;
grant update on dzad_t to tiptop;
grant delete on dzad_t to tiptop;
grant insert on dzad_t to tiptop;

exit;
