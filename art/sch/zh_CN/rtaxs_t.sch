/* 
================================================================================
檔案代號:rtaxs_t
檔案名稱:品類基本資料檔提速檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:V
多語系檔案:N
============.========================.==========================================
 */
create table rtaxs_t
(
rtaxsent       number(5)      ,/* 企業編號 */
rtaxs001       varchar2(10)      ,/* 品類編號 */
rtaxs002       varchar2(40)      ,/* 提速值 */
rtaxs003       number(5,0)      /* 階層 */
);
alter table rtaxs_t add constraint rtaxs_pk primary key (rtaxsent,rtaxs001,rtaxs002) enable validate;

create unique index rtaxs_pk on rtaxs_t (rtaxsent,rtaxs001,rtaxs002);

grant select on rtaxs_t to tiptop;
grant update on rtaxs_t to tiptop;
grant delete on rtaxs_t to tiptop;
grant insert on rtaxs_t to tiptop;

exit;
