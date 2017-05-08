/* 
================================================================================
檔案代號:gzah_t
檔案名稱:單據程式列印的報表元件設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table gzah_t
(
gzah001       varchar2(20)      ,/* 單據程式 */
gzah002       varchar2(20)      ,/* 報表元件 */
gzah003       varchar2(500)      ,/* 報表元件參數 */
gzah004       varchar2(1)      ,/* 客製 */
gzahownid       varchar2(20)      ,/* 資料所有者 */
gzahowndp       varchar2(10)      ,/* 資料所屬部門 */
gzahcrtid       varchar2(20)      ,/* 資料建立者 */
gzahcrtdp       varchar2(10)      ,/* 資料建立部門 */
gzahcrtdt       timestamp(0)      ,/* 資料創建日 */
gzahmodid       varchar2(20)      ,/* 資料修改者 */
gzahmoddt       timestamp(0)      ,/* 最近修改日 */
gzahcnfid       varchar2(20)      ,/* 資料確認者 */
gzahcnfdt       timestamp(0)      ,/* 資料確認日 */
gzahstus       varchar2(10)      ,/* 狀態碼 */
gzah005       number(5,0)      ,/* 序號 */
gzah006       varchar2(20)      ,/* 單據作業 */
gzah007       varchar2(1)      ,/* 預設樣板 */
gzah008       varchar2(500)      /* 報表作業參數 */
);
alter table gzah_t add constraint gzah_pk primary key (gzah001,gzah005) enable validate;

create unique index gzah_pk on gzah_t (gzah001,gzah005);

grant select on gzah_t to tiptop;
grant update on gzah_t to tiptop;
grant delete on gzah_t to tiptop;
grant insert on gzah_t to tiptop;

exit;
