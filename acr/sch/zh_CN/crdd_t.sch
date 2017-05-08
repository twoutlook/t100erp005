/* 
================================================================================
檔案代號:crdd_t
檔案名稱:會員生命週期評估記錄檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table crdd_t
(
crddent       number(5)      ,/* 企業編號 */
crdd001       varchar2(30)      ,/* 會員編號 */
crdd002       number(5,0)      ,/* 年度 */
crdd003       number(5,0)      ,/* 期別 */
crdd004       varchar2(40)      ,/* 會員等級 */
crdd005       number(15,3)      ,/* 辦卡月數 */
crdd006       number(5,0)      ,/* 購物次數 */
crdd007       varchar2(10)      ,/* 生命週期編號 */
crdd008       timestamp(0)      ,/* 評估日期 */
crdd009       varchar2(20)      ,/* 評估人員 */
crdd010       varchar2(40)      ,/* 備用一 */
crdd011       varchar2(40)      ,/* 備用二 */
crdd012       varchar2(40)      /* 備用三 */
);
alter table crdd_t add constraint crdd_pk primary key (crddent,crdd001,crdd002,crdd003) enable validate;

create unique index crdd_pk on crdd_t (crddent,crdd001,crdd002,crdd003);

grant select on crdd_t to tiptop;
grant update on crdd_t to tiptop;
grant delete on crdd_t to tiptop;
grant insert on crdd_t to tiptop;

exit;
