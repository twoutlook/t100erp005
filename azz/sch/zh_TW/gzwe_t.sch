/* 
================================================================================
檔案代號:gzwe_t
檔案名稱:選單設定表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table gzwe_t
(
gzwe001       varchar2(20)      ,/* 上階目錄編號 */
gzwe002       varchar2(20)      ,/* 目錄編號 */
gzwe003       number(5,0)      ,/* 顯示順序 */
gzweownid       varchar2(20)      ,/* 資料所有者 */
gzweowndp       varchar2(10)      ,/* 資料所屬部門 */
gzwecrtid       varchar2(20)      ,/* 資料建立者 */
gzwecrtdp       varchar2(10)      ,/* 資料建立部門 */
gzwecrtdt       timestamp(0)      ,/* 資料創建日 */
gzwemodid       varchar2(20)      ,/* 資料修改者 */
gzwemoddt       timestamp(0)      ,/* 最近修改日 */
gzwestus       varchar2(10)      ,/* 狀態碼 */
gzwe004       varchar2(1)      ,/* 節點型態 */
gzweent       number(5)      /* 企業編號 */
);
alter table gzwe_t add constraint gzwe_pk primary key (gzwe001,gzwe002,gzweent) enable validate;

create unique index gzwe_pk on gzwe_t (gzwe001,gzwe002,gzweent);

grant select on gzwe_t to tiptop;
grant update on gzwe_t to tiptop;
grant delete on gzwe_t to tiptop;
grant insert on gzwe_t to tiptop;

exit;
