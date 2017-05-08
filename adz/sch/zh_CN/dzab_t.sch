/* 
================================================================================
檔案代號:dzab_t
檔案名稱:規格整體設計表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzab_t
(
dzabstus       varchar2(10)      ,/* no use */
dzab001       varchar2(20)      ,/* 規格編號 */
dzab002       number(10)      ,/* 識別碼版次 */
dzab099       clob      ,/* 規格描述 */
dzab003       varchar2(1)      ,/* 使用標示 */
dzab004       varchar2(60)      ,/* 識別碼 */
dzab005       varchar2(40)      ,/* 客戶代號 */
dzab006       varchar2(15)      ,/* no use */
dzabownid       varchar2(20)      ,/* 資料所有者 */
dzabowndp       varchar2(10)      ,/* 資料所屬部門 */
dzabcrtid       varchar2(20)      ,/* 資料建立者 */
dzabcrtdp       varchar2(10)      ,/* 資料建立部門 */
dzabcrtdt       timestamp(0)      ,/* 資料創建日 */
dzabmodid       varchar2(20)      ,/* 資料修改者 */
dzabmoddt       timestamp(0)      /* 最近修改日 */
);
alter table dzab_t add constraint dzab_pk primary key (dzab001,dzab002,dzab003,dzab004) enable validate;

create unique index dzab_pk on dzab_t (dzab001,dzab002,dzab003,dzab004);

grant select on dzab_t to tiptop;
grant update on dzab_t to tiptop;
grant delete on dzab_t to tiptop;
grant insert on dzab_t to tiptop;

exit;
