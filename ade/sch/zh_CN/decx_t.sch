/* 
================================================================================
檔案代號:decx_t
檔案名稱:門店核銷供應商款別統計日結檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table decx_t
(
decxent       number(5)      ,/* 企業編號 */
decxsite       varchar2(10)      ,/* 營運組織 */
decx001       varchar2(10)      ,/* 層級類型 */
decx002       date      ,/* 統計日期 */
decx003       number(5,0)      ,/* 會計週 */
decx004       number(5,0)      ,/* 會計期 */
decx005       varchar2(10)      ,/* 供應商編號 */
decx006       varchar2(10)      ,/* 款別編號 */
decx007       varchar2(10)      ,/* 款別類型 */
decx008       number(20,6)      /* 實收金額 */
);
alter table decx_t add constraint decx_pk primary key (decxent,decxsite,decx002,decx005,decx006) enable validate;

create unique index decx_pk on decx_t (decxent,decxsite,decx002,decx005,decx006);

grant select on decx_t to tiptop;
grant update on decx_t to tiptop;
grant delete on decx_t to tiptop;
grant insert on decx_t to tiptop;

exit;
