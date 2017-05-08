/* 
================================================================================
檔案代號:dzhc_t
檔案名稱:資料表索引檔簽出備份檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzhc_t
(
dzhc000       varchar2(40)      ,/* 簽出GUID */
dzhc001       varchar2(15)      ,/* Table代號 */
dzhc002       varchar2(20)      ,/* 索引代號 */
dzhc003       varchar2(20)      ,/* 索引形式 */
dzhc004       varchar2(500)      ,/* 索引欄位 */
dzhc005       varchar2(1)      ,/* 異動確認碼 */
dzhc006       varchar2(1)      ,/* 客制標示 */
dzhc007       varchar2(1)      ,/* 原始客制標示 */
dzhc008       varchar2(1)      ,/* 出貨標示 */
dzhcstus       varchar2(10)      ,/* 狀態碼 */
dzhcownid       varchar2(20)      ,/* 資料所有者 */
dzhcowndp       varchar2(10)      ,/* 資料所屬部門 */
dzhccrtid       varchar2(20)      ,/* 資料建立者 */
dzhccrtdp       varchar2(10)      ,/* 資料建立部門 */
dzhccrtdt       timestamp(0)      ,/* 資料創建日 */
dzhcmodid       varchar2(20)      ,/* 資料修改者 */
dzhcmoddt       timestamp(0)      ,/* 最近修改日 */
dzhccnfid       varchar2(20)      ,/* 資料確認者 */
dzhccnfdt       timestamp(0)      /* 資料確認日 */
);
alter table dzhc_t add constraint dzhc_pk primary key (dzhc000,dzhc001,dzhc002) enable validate;

create unique index dzhc_pk on dzhc_t (dzhc000,dzhc001,dzhc002);

grant select on dzhc_t to tiptop;
grant update on dzhc_t to tiptop;
grant delete on dzhc_t to tiptop;
grant insert on dzhc_t to tiptop;

exit;
