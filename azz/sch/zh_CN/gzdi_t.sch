/* 
================================================================================
檔案代號:gzdi_t
檔案名稱:子程式及應用元件參數個數表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table gzdi_t
(
gzdi001       varchar2(80)      ,/* FUNCTION編號 */
gzdi002       number(5,0)      ,/* 傳入參數數量 */
gzdi003       varchar2(500)      ,/* 傳入參數清單 */
gzdiownid       varchar2(20)      ,/* 資料所有者 */
gzdiowndp       varchar2(10)      ,/* 資料所屬部門 */
gzdicrtid       varchar2(20)      ,/* 資料建立者 */
gzdicrtdp       varchar2(10)      ,/* 資料建立部門 */
gzdicrtdt       timestamp(0)      ,/* 資料創建日 */
gzdimodid       varchar2(20)      ,/* 資料修改者 */
gzdimoddt       timestamp(0)      ,/* 最近修改日 */
gzdistus       varchar2(10)      ,/* 狀態碼 */
gzdi004       varchar2(1)      /* 公開或私有 */
);
alter table gzdi_t add constraint gzdi_pk primary key (gzdi001) enable validate;

create unique index gzdi_pk on gzdi_t (gzdi001);

grant select on gzdi_t to tiptop;
grant update on gzdi_t to tiptop;
grant delete on gzdi_t to tiptop;
grant insert on gzdi_t to tiptop;

exit;
