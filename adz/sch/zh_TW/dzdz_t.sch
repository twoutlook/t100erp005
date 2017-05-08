/* 
================================================================================
檔案代號:dzdz_t
檔案名稱:樣板及版本更新基本資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzdz_t
(
dzdz001       varchar2(20)      ,/* 樣板編號 */
dzdz002       number(10)      ,/* 樣板版本 */
dzdz003       clob      ,/* 樣板實體內容 */
dzdz004       varchar2(80)      ,/* 樣板MD5 */
dzdz005       varchar2(500)      ,/* 樣板更新說明 */
dzdz006       varchar2(500)      ,/* 版差修改方法 */
dzdz007       timestamp(0)      ,/* 上傳更新時間 */
dzdz008       varchar2(20)      ,/* 上傳更新帳號 */
dzdz009       number(10,0)      ,/* 關聯主要需求單 */
dzdz010       number(10)      /* 適用產生器版本 */
);
alter table dzdz_t add constraint dzdz_pk primary key (dzdz001,dzdz002) enable validate;

create unique index dzdz_pk on dzdz_t (dzdz001,dzdz002);

grant select on dzdz_t to tiptop;
grant update on dzdz_t to tiptop;
grant delete on dzdz_t to tiptop;
grant insert on dzdz_t to tiptop;

exit;
