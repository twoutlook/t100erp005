/* 
================================================================================
檔案代號:gzsa_t
檔案名稱:系統全域參數
檔案目的: 
上游檔案:
下游檔案:
檔案類型:P
多語系檔案:N
============.========================.==========================================
 */
create table gzsa_t
(
gzsa001       varchar2(10)      ,/* 參數編號 */
gzsa002       varchar2(80)      ,/* 參數資料 */
gzsaownid       varchar2(20)      ,/* 資料所有者 */
gzsaowndp       varchar2(10)      ,/* 資料所屬部門 */
gzsacrtid       varchar2(20)      ,/* 資料建立者 */
gzsacrtdp       varchar2(10)      ,/* 資料建立部門 */
gzsacrtdt       timestamp(0)      ,/* 資料創建日 */
gzsamodid       varchar2(20)      ,/* 資料修改者 */
gzsamoddt       timestamp(0)      /* 最近修改日 */
);
alter table gzsa_t add constraint gzsa_pk primary key (gzsa001) enable validate;

create unique index gzsa_pk on gzsa_t (gzsa001);

grant select on gzsa_t to tiptop;
grant update on gzsa_t to tiptop;
grant delete on gzsa_t to tiptop;
grant insert on gzsa_t to tiptop;

exit;
