/* 
================================================================================
檔案代號:gzdd_t
檔案名稱:多AP主機編號對照表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table gzdd_t
(
gzddownid       varchar2(20)      ,/* 資料所有者 */
gzddowndp       varchar2(10)      ,/* 資料所屬部門 */
gzddcrtid       varchar2(20)      ,/* 資料建立者 */
gzddcrtdp       varchar2(10)      ,/* 資料建立部門 */
gzddcrtdt       timestamp(0)      ,/* 資料創建日 */
gzddmodid       varchar2(20)      ,/* 資料修改者 */
gzddmoddt       timestamp(0)      ,/* 最近修改日 */
gzddstus       varchar2(10)      ,/* 狀態碼 */
gzdd001       varchar2(1)      ,/* AP主機編號 */
gzdd002       varchar2(20)      ,/* AP主機hostname */
gzdd003       varchar2(1)      /* 接受排程執行 */
);
alter table gzdd_t add constraint gzdd_pk primary key (gzdd001) enable validate;

create unique index gzdd_pk on gzdd_t (gzdd001);

grant select on gzdd_t to tiptop;
grant update on gzdd_t to tiptop;
grant delete on gzdd_t to tiptop;
grant insert on gzdd_t to tiptop;

exit;
