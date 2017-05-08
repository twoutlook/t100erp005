/* 
================================================================================
檔案代號:dzff_t
檔案名稱:樹狀結構屬性設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzff_t
(
dzffstus       varchar2(10)      ,/* 狀態碼 */
dzff001       varchar2(20)      ,/* 程式代號 */
dzff002       number(10)      ,/* 識別碼版號 */
dzff003       varchar2(40)      ,/* 4fd tag name */
dzff004       number(5,0)      ,/* 編號 */
dzff005       varchar2(20)      ,/* 屬性(ex.描述desc,pid,id,type,提速檔speed,spid,sid,stype) */
dzff006       varchar2(15)      ,/* 資料表代碼 */
dzff007       varchar2(20)      ,/* 欄位代碼 */
dzff008       varchar2(1)      ,/* 使用標示 */
dzffownid       varchar2(20)      ,/* 資料所有者 */
dzffowndp       varchar2(10)      ,/* 資料所屬部門 */
dzffcrtid       varchar2(20)      ,/* 資料建立者 */
dzffcrtdp       varchar2(10)      ,/* 資料建立部門 */
dzffcrtdt       timestamp(0)      ,/* 資料創建日 */
dzffmodid       varchar2(20)      ,/* 資料修改者 */
dzffmoddt       timestamp(0)      ,/* 最近修改日 */
dzff009       varchar2(40)      /* 客戶代號 */
);
alter table dzff_t add constraint dzff_pk primary key (dzff001,dzff002,dzff003,dzff005,dzff008) enable validate;

create unique index dzff_pk on dzff_t (dzff001,dzff002,dzff003,dzff005,dzff008);

grant select on dzff_t to tiptop;
grant update on dzff_t to tiptop;
grant delete on dzff_t to tiptop;
grant insert on dzff_t to tiptop;

exit;
