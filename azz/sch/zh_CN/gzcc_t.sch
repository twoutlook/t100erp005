/* 
================================================================================
檔案代號:gzcc_t
檔案名稱:狀態碼分類
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table gzcc_t
(
gzcc001       varchar2(15)      ,/* Table編號 */
gzcc002       varchar2(20)      ,/* 狀態碼欄位 */
gzcc003       number(10,0)      ,/* 系統分類碼 */
gzcc004       varchar2(10)      ,/* 系統分類值 */
gzcc005       varchar2(1)      ,/* 客製 */
gzcc006       number(5,0)      ,/* 顯示順序 */
gzccstus       varchar2(10)      ,/* 狀態碼 */
gzccownid       varchar2(20)      ,/* 資料所有者 */
gzccowndp       varchar2(10)      ,/* 資料所屬部門 */
gzcccrtid       varchar2(20)      ,/* 資料建立者 */
gzcccrtdp       varchar2(10)      ,/* 資料建立部門 */
gzcccrtdt       timestamp(0)      ,/* 資料創建日 */
gzccmodid       varchar2(20)      ,/* 資料修改者 */
gzccmoddt       timestamp(0)      /* 最近修改日 */
);
alter table gzcc_t add constraint gzcc_pk primary key (gzcc001,gzcc004) enable validate;

create unique index gzcc_pk on gzcc_t (gzcc001,gzcc004);

grant select on gzcc_t to tiptop;
grant update on gzcc_t to tiptop;
grant delete on gzcc_t to tiptop;
grant insert on gzcc_t to tiptop;

exit;
