/* 
================================================================================
檔案代號:dzfm_t
檔案名稱:畫面樣板結構檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzfm_t
(
dzfmstus       varchar2(10)      ,/* 狀態碼 */
dzfm001       varchar2(40)      ,/* 結構代號 */
dzfm002       varchar2(10)      ,/* (產品)版號 */
dzfm003       number(5,0)      ,/* 編號 */
dzfm004       varchar2(40)      ,/* 群組代碼 */
dzfm005       number(5,0)      ,/* 順序 */
dzfm006       varchar2(40)      ,/* 元件組代碼 */
dzfm007       varchar2(20)      ,/* 節點類型 */
dzfm008       varchar2(1)      ,/* 是否顯示於畫面結構 */
dzfm009       varchar2(1)      ,/* 包含元素類型 */
dzfm010       varchar2(1)      ,/* 直橫排列V/H */
dzfmownid       varchar2(20)      ,/* 資料所有者 */
dzfmowndp       varchar2(10)      ,/* 資料所屬部門 */
dzfmcrtid       varchar2(20)      ,/* 資料建立者 */
dzfmcrtdp       varchar2(10)      ,/* 資料建立部門 */
dzfmcrtdt       timestamp(0)      ,/* 資料創建日 */
dzfmmodid       varchar2(20)      ,/* 資料修改者 */
dzfmmoddt       timestamp(0)      /* 最近修改日 */
);
alter table dzfm_t add constraint dzfm_pk primary key (dzfm001,dzfm002,dzfm003) enable validate;

create unique index dzfm_pk on dzfm_t (dzfm001,dzfm002,dzfm003);

grant select on dzfm_t to tiptop;
grant update on dzfm_t to tiptop;
grant delete on dzfm_t to tiptop;
grant insert on dzfm_t to tiptop;

exit;
