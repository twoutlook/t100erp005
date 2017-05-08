/* 
================================================================================
檔案代號:xrahs_t
檔案名稱:帳務組織結構檔提速檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:V
多語系檔案:N
============.========================.==========================================
 */
create table xrahs_t
(
xrahsent       number(5)      ,/* 企業編號 */
xrahs001       varchar2(1)      ,/* 組織類型 */
xrahs002       varchar2(10)      ,/* 帳務中心 */
xrahs003       number(5,0)      ,/* 版本 */
xrahs004       varchar2(10)      ,/* 組織編號 */
xrahs005       varchar2(40)      ,/* 提速值 */
xrahs006       number(5,0)      /* 階層 */
);
alter table xrahs_t add constraint xrahs_pk primary key (xrahsent,xrahs001,xrahs002,xrahs003,xrahs004,xrahs005) enable validate;

create unique index xrahs_pk on xrahs_t (xrahsent,xrahs001,xrahs002,xrahs003,xrahs004,xrahs005);

grant select on xrahs_t to tiptop;
grant update on xrahs_t to tiptop;
grant delete on xrahs_t to tiptop;
grant insert on xrahs_t to tiptop;

exit;
