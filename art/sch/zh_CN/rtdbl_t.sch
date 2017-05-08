/* 
================================================================================
檔案代號:rtdbl_t
檔案名稱:供應商生命週期表多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table rtdbl_t
(
rtdblent       number(5)      ,/* 企業編號 */
rtdbl001       varchar2(10)      ,/* 生命週期編號 */
rtdbl002       varchar2(6)      ,/* 語言別 */
rtdbl003       varchar2(500)      ,/* 說明 */
rtdbl004       varchar2(10)      /* 助記碼 */
);
alter table rtdbl_t add constraint rtdbl_pk primary key (rtdblent,rtdbl001,rtdbl002) enable validate;

create unique index rtdbl_pk on rtdbl_t (rtdblent,rtdbl001,rtdbl002);

grant select on rtdbl_t to tiptop;
grant update on rtdbl_t to tiptop;
grant delete on rtdbl_t to tiptop;
grant insert on rtdbl_t to tiptop;

exit;
