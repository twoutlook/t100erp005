/* 
================================================================================
檔案代號:dedn_t
檔案名稱:門店部門款別統計月結檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table dedn_t
(
dednent       number(5)      ,/* 企業代碼 */
dednsite       varchar2(10)      ,/* 營運據點 */
dedn001       varchar2(10)      ,/* 層級類型 */
dedn005       varchar2(10)      ,/* 部門編號 */
dedn006       varchar2(10)      ,/* 款別編號 */
dedn007       varchar2(10)      ,/* 款別分類 */
dedn008       number(20,6)      ,/* 實收金額 */
dedn009       number(5,0)      ,/* 統計年度 */
dedn010       number(5,0)      /* 統計月份 */
);
alter table dedn_t add constraint dedn_pk primary key (dednent,dednsite,dedn005,dedn006,dedn009,dedn010) enable validate;

create unique index dedn_pk on dedn_t (dednent,dednsite,dedn005,dedn006,dedn009,dedn010);

grant select on dedn_t to tiptop;
grant update on dedn_t to tiptop;
grant delete on dedn_t to tiptop;
grant insert on dedn_t to tiptop;

exit;
