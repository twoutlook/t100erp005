/* 
================================================================================
檔案代號:bgcbl_t
檔案名稱:銷售模擬因子組織影響力設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table bgcbl_t
(
bgcblent       number(5)      ,/* 企業編號 */
bgcbl001       varchar2(10)      ,/* 預算編號 */
bgcbl002       varchar2(10)      ,/* 預算組織 */
bgcbl003       varchar2(10)      ,/* 產品分類碼 */
bgcbl004       varchar2(10)      ,/* 影響因子編號 */
bgcbl005       number(5,0)      ,/* 預算期別 */
bgcbl006       varchar2(6)      ,/* 語言別 */
bgcbl007       varchar2(500)      ,/* 說明 */
bgcbl008       varchar2(10)      /* 助記碼 */
);
alter table bgcbl_t add constraint bgcbl_pk primary key (bgcblent,bgcbl001,bgcbl002,bgcbl003,bgcbl004,bgcbl005,bgcbl006) enable validate;

create unique index bgcbl_pk on bgcbl_t (bgcblent,bgcbl001,bgcbl002,bgcbl003,bgcbl004,bgcbl005,bgcbl006);

grant select on bgcbl_t to tiptop;
grant update on bgcbl_t to tiptop;
grant delete on bgcbl_t to tiptop;
grant insert on bgcbl_t to tiptop;

exit;
