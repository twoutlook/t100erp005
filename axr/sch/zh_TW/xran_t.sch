/* 
================================================================================
檔案代號:xran_t
檔案名稱:會計科目應用帳套設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table xran_t
(
xranent       number(5)      ,/* 企業代碼 */
xran001       varchar2(10)      ,/* 科目參照表編號 */
xran002       varchar2(10)      ,/* 設定類型 */
xran003       varchar2(10)      ,/* 分類碼 */
xran004       varchar2(10)      ,/* 分類碼值 */
xranld       varchar2(5)      ,/* 帳別 */
xran005       varchar2(24)      ,/* 會計科目編號一 */
xran006       varchar2(24)      ,/* 會計科目編號二 */
xran007       varchar2(24)      ,/* 會計科目編號三 */
xran008       varchar2(24)      ,/* 會計科目編號四 */
xran009       varchar2(100)      /* 其他設定值 */
);
alter table xran_t add constraint xran_pk primary key (xran001,xran002,xran003,xran004,xranent,xranld) enable validate;

create  index xran_01 on xran_t (xran005);
create  index xran_02 on xran_t (xran006);
create  index xran_03 on xran_t (xran007);
create  index xran_04 on xran_t (xran008);

grant select on xran_t to tiptop;
grant update on xran_t to tiptop;
grant delete on xran_t to tiptop;
grant insert on xran_t to tiptop;

exit;
