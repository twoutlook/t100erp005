/* 
================================================================================
檔案代號:fmba_t
檔案名稱:NO USE
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table fmba_t
(
fmbaent       number(5)      ,/* 企業編號 */
fmba001       varchar2(10)      ,/* 帳務中心 */
fmba002       varchar2(10)      ,/* 計提利息帳務編號 */
fmba003       varchar2(5)      ,/* 帳別 */
fmba004       varchar2(10)      ,/* 歸屬法人組織 */
fmba005       number(5,0)      ,/* 年度 */
fmba006       number(5,0)      ,/* 期別 */
fmba007       varchar2(20)      ,/* 憑證編號 */
fmbastus       varchar2(10)      ,/* 狀態碼 */
fmbaownid       varchar2(20)      ,/* 資料所有者 */
fmbaowndp       varchar2(10)      ,/* 資料所屬部門 */
fmbacrtid       varchar2(20)      ,/* 資料建立者 */
fmbacrtdp       varchar2(10)      ,/* 資料建立部門 */
fmbacrtdt       timestamp(0)      ,/* 資料創建日 */
fmbamodid       varchar2(20)      ,/* 資料修改者 */
fmbamoddt       timestamp(0)      ,/* 最近修改日 */
fmbacnfid       varchar2(20)      ,/* 資料確認者 */
fmbacnfdt       timestamp(0)      /* 資料確認日 */
);
alter table fmba_t add constraint fmba_pk primary key (fmbaent,fmba002) enable validate;

create unique index fmba_pk on fmba_t (fmbaent,fmba002);

grant select on fmba_t to tiptop;
grant update on fmba_t to tiptop;
grant delete on fmba_t to tiptop;
grant insert on fmba_t to tiptop;

exit;
