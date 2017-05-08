/* 
================================================================================
檔案代號:dzdj_t
檔案名稱:模板程序代碼表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzdj_t
(
dzdj001       varchar2(40)      ,/* 範本編號 */
dzdj002       varchar2(80)      ,/* 範本說明 */
dzdj003       varchar2(2000)      ,/* 範本代碼 */
dzdj004       varchar2(2000)      ,/* 其他代碼1 */
dzdj005       varchar2(2000)      ,/* 其他代碼2 */
dzdj006       varchar2(1)      ,/* 設計器預設顯示此範本按鈕否 */
dzdj007       varchar2(10)      ,/* 助記碼 */
dzdj008       varchar2(1)      ,/* 分類 */
dzdj009       varchar2(1)      ,/* 預留欄位2 */
dzdj010       varchar2(1)      ,/* 預留欄位3 */
dzdj011       varchar2(10)      ,/* 預留欄位4 */
dzdj012       varchar2(10)      ,/* 預留欄位5 */
dzdjstus       varchar2(10)      ,/* 狀態碼 */
dzdjownid       varchar2(20)      ,/* 資料所有者 */
dzdjowndp       varchar2(10)      ,/* 資料所屬部門 */
dzdjcrtid       varchar2(20)      ,/* 資料建立者 */
dzdjcrtdp       varchar2(10)      ,/* 資料建立部門 */
dzdjcrtdt       timestamp(0)      ,/* 資料創建日 */
dzdjmodid       varchar2(20)      ,/* 資料修改者 */
dzdjmoddt       timestamp(0)      ,/* 最近修改日 */
dzdjcnfid       varchar2(20)      ,/* 資料確認者 */
dzdjcnfdt       timestamp(0)      /* 資料確認日 */
);
alter table dzdj_t add constraint dzdj_pk primary key (dzdj001) enable validate;

create unique index dzdj_pk on dzdj_t (dzdj001);

grant select on dzdj_t to tiptop;
grant update on dzdj_t to tiptop;
grant delete on dzdj_t to tiptop;
grant insert on dzdj_t to tiptop;

exit;
