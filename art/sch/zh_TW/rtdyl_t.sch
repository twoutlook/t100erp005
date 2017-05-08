/* 
================================================================================
檔案代號:rtdyl_t
檔案名稱:標價籤模板資料表多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table rtdyl_t
(
rtdylent       number(5)      ,/* 企業編號 */
rtdyl001       varchar2(10)      ,/* 模板編號 */
rtdyl002       varchar2(6)      ,/* 語言別 */
rtdyl003       varchar2(500)      ,/* 說明 */
rtdyl004       varchar2(10)      /* 助記碼 */
);
alter table rtdyl_t add constraint rtdyl_pk primary key (rtdylent,rtdyl001,rtdyl002) enable validate;

create unique index rtdyl_pk on rtdyl_t (rtdylent,rtdyl001,rtdyl002);

grant select on rtdyl_t to tiptop;
grant update on rtdyl_t to tiptop;
grant delete on rtdyl_t to tiptop;
grant insert on rtdyl_t to tiptop;

exit;
