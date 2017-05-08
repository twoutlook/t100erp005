/* 
================================================================================
檔案代號:crde_t
檔案名稱:會員ABC分類評估記錄檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table crde_t
(
crdeent       number(5)      ,/* 企業編號 */
crde001       varchar2(30)      ,/* 會員編號 */
crde002       number(5,0)      ,/* 年度 */
crde003       number(5,0)      ,/* 期別 */
crde004       varchar2(40)      ,/* 會員等級 */
crde005       number(20,6)      ,/* 金額 */
crde006       number(10,0)      ,/* 金額排名 */
crde007       varchar2(10)      ,/* ABC分類 */
crde008       timestamp(0)      ,/* 評估日期 */
crde009       varchar2(20)      ,/* 評估人員 */
crde010       varchar2(40)      ,/* 備用一 */
crde011       varchar2(40)      ,/* 備用二 */
crde012       varchar2(40)      /* 備用三 */
);
alter table crde_t add constraint crde_pk primary key (crdeent,crde001,crde002,crde003) enable validate;

create unique index crde_pk on crde_t (crdeent,crde001,crde002,crde003);

grant select on crde_t to tiptop;
grant update on crde_t to tiptop;
grant delete on crde_t to tiptop;
grant insert on crde_t to tiptop;

exit;
