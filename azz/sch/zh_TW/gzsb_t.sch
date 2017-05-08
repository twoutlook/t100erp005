/* 
================================================================================
檔案代號:gzsb_t
檔案名稱:企業層級系統參數
檔案目的: 
上游檔案:
下游檔案:
檔案類型:P
多語系檔案:N
============.========================.==========================================
 */
create table gzsb_t
(
gzsbent       number(5)      ,/* 企業編號 */
gzsb001       varchar2(10)      ,/* 參數編號 */
gzsb002       varchar2(80)      ,/* 參數資料 */
gzsbownid       varchar2(20)      ,/* 資料所有者 */
gzsbowndp       varchar2(10)      ,/* 資料所屬部門 */
gzsbcrtid       varchar2(20)      ,/* 資料建立者 */
gzsbcrtdp       varchar2(10)      ,/* 資料建立部門 */
gzsbcrtdt       timestamp(0)      ,/* 資料創建日 */
gzsbmodid       varchar2(20)      ,/* 資料修改者 */
gzsbmoddt       timestamp(0)      /* 最近修改日 */
);
alter table gzsb_t add constraint gzsb_pk primary key (gzsbent,gzsb001) enable validate;

create unique index gzsb_pk on gzsb_t (gzsbent,gzsb001);

grant select on gzsb_t to tiptop;
grant update on gzsb_t to tiptop;
grant delete on gzsb_t to tiptop;
grant insert on gzsb_t to tiptop;

exit;
