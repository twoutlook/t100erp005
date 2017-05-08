/* 
================================================================================
檔案代號:dzdh_t
檔案名稱:元件維度分類表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzdh_t
(
dzdh001       number(5,0)      ,/* 維度編號 */
dzdh002       varchar2(10)      ,/* 分類編號 */
dzdh003       varchar2(40)      ,/* 元件 */
dzdhownid       varchar2(20)      ,/* 資料所有者 */
dzdhowndp       varchar2(10)      ,/* 資料所屬部門 */
dzdhcrtid       varchar2(20)      ,/* 資料建立者 */
dzdhcrtdp       varchar2(10)      ,/* 資料建立部門 */
dzdhcrtdt       timestamp(0)      ,/* 資料創建日 */
dzdhmodid       varchar2(20)      ,/* 資料修改者 */
dzdhmoddt       timestamp(0)      ,/* 最近修改日 */
dzdhcnfid       varchar2(20)      ,/* 資料確認者 */
dzdhcnfdt       timestamp(0)      ,/* 資料確認日 */
dzdh004       number(10)      ,/* 識別碼版次 */
dzdh005       varchar2(1)      ,/* 使用標示 */
dzdhstus       varchar2(10)      ,/* 狀態碼 */
dzdh006       varchar2(40)      /* 客戶代號 */
);
alter table dzdh_t add constraint dzdh_pk primary key (dzdh001,dzdh002,dzdh003,dzdh004,dzdh005) enable validate;

create unique index dzdh_pk on dzdh_t (dzdh001,dzdh002,dzdh003,dzdh004,dzdh005);

grant select on dzdh_t to tiptop;
grant update on dzdh_t to tiptop;
grant delete on dzdh_t to tiptop;
grant insert on dzdh_t to tiptop;

exit;
