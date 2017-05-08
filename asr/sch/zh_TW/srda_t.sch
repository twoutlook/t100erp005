/* 
================================================================================
檔案代號:srda_t
檔案名稱:重複性生產當期在制狀況單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table srda_t
(
srdaent       number(5)      ,/* 企業代碼 */
srdasite       varchar2(10)      ,/* 營運據點 */
srda000       number(5,0)      ,/* 年度 */
srda001       number(5,0)      ,/* 期別 */
srda002       varchar2(10)      ,/* 生產計劃 */
srda003       varchar2(40)      ,/* 料件編號 */
srda004       varchar2(30)      ,/* BOM特性 */
srda005       varchar2(256)      ,/* 料件特征 */
srda006       number(20,6)      ,/* 本期剩餘套數 */
srdaownid       varchar2(20)      ,/* 資料所有者 */
srdaowndp       varchar2(10)      ,/* 資料所屬部門 */
srdacrtid       varchar2(20)      ,/* 資料建立者 */
srdacrtdp       varchar2(10)      ,/* 資料建立部門 */
srdacrtdt       timestamp(0)      ,/* 資料創建日 */
srdamodid       varchar2(20)      ,/* 資料修改者 */
srdamoddt       timestamp(0)      ,/* 最近修改日 */
srdacnfid       varchar2(20)      ,/* 資料確認者 */
srdacnfdt       timestamp(0)      ,/* 資料確認日 */
srdapstid       varchar2(20)      ,/* 資料過帳者 */
srdapstdt       timestamp(0)      ,/* 資料過帳日 */
srdastus       varchar2(10)      /* 狀態碼 */
);
alter table srda_t add constraint srda_pk primary key (srdaent,srdasite,srda000,srda001,srda002,srda003,srda004,srda005) enable validate;

create unique index srda_pk on srda_t (srdaent,srdasite,srda000,srda001,srda002,srda003,srda004,srda005);

grant select on srda_t to tiptop;
grant update on srda_t to tiptop;
grant delete on srda_t to tiptop;
grant insert on srda_t to tiptop;

exit;
