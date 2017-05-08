/* 
================================================================================
檔案代號:xram_t
檔案名稱:會計科目應用設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table xram_t
(
xrament       number(5)      ,/* 企業代碼 */
xramownid       varchar2(10)      ,/* 資料所有者 */
xramowndp       varchar2(10)      ,/* 資料所屬部門 */
xramcrtid       varchar2(10)      ,/* 資料建立者 */
xramcrtdp       varchar2(10)      ,/* 資料建立部門 */
xramcrtdt       date      ,/* 資料創建日 */
xrammodid       varchar2(10)      ,/* 資料修改者 */
xrammoddt       date      ,/* 最近修改日 */
xramstus       varchar2(10)      ,/* 狀態碼 */
xram001       varchar2(10)      ,/* 科目參照表編號 */
xram002       varchar2(10)      ,/* 設定類型 */
xram003       varchar2(10)      ,/* 分類碼 */
xram004       varchar2(10)      ,/* 分類碼值 */
xram005       varchar2(24)      ,/* 會計科目編號一 */
xram006       varchar2(24)      ,/* 會計科目編號二 */
xram007       varchar2(24)      ,/* 會計科目編號三 */
xram008       varchar2(24)      ,/* 會計科目編號四 */
xram009       varchar2(100)      /* 其他設定值 */
);
alter table xram_t add constraint xram_pk primary key (xram001,xram002,xram003,xram004,xrament) enable validate;

create  index xram_01 on xram_t (xram005);
create  index xram_02 on xram_t (xram006);
create  index xram_03 on xram_t (xram007);
create  index xram_04 on xram_t (xram008);

grant select on xram_t to tiptop;
grant update on xram_t to tiptop;
grant delete on xram_t to tiptop;
grant insert on xram_t to tiptop;

exit;
