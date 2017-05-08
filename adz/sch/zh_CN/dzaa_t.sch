/* 
================================================================================
檔案代號:dzaa_t
檔案名稱:規格與內容版本對應表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzaa_t
(
dzaastus       varchar2(10)      ,/* 狀態碼 */
dzaa001       varchar2(20)      ,/* 規格編號 */
dzaa002       number(10)      ,/* 規格版次 */
dzaa003       varchar2(60)      ,/* 識別碼 */
dzaa004       number(10)      ,/* 識別碼版次 */
dzaa005       varchar2(10)      ,/* 識別碼類型 */
dzaa006       varchar2(1)      ,/* 使用標示 */
dzaaownid       varchar2(20)      ,/* 資料所有者 */
dzaaowndp       varchar2(10)      ,/* 資料所屬部門 */
dzaacrtid       varchar2(20)      ,/* 資料建立者 */
dzaacrtdp       varchar2(10)      ,/* 資料建立部門 */
dzaacrtdt       timestamp(0)      ,/* 資料創建日 */
dzaamodid       varchar2(20)      ,/* 資料修改者 */
dzaamoddt       timestamp(0)      ,/* 最近修改日 */
dzaa007       varchar2(1)      ,/* 規格引用否 */
dzaa008       varchar2(20)      ,/* 產品版本 */
dzaa009       varchar2(1)      ,/* 客製 */
dzaa010       varchar2(40)      /* 客戶代號 */
);
alter table dzaa_t add constraint dzaa_pk primary key (dzaa001,dzaa002,dzaa003,dzaa009) enable validate;

create unique index dzaa_pk on dzaa_t (dzaa001,dzaa002,dzaa003,dzaa009);

grant select on dzaa_t to tiptop;
grant update on dzaa_t to tiptop;
grant delete on dzaa_t to tiptop;
grant insert on dzaa_t to tiptop;

exit;
