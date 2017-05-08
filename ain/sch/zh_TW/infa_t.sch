/* 
================================================================================
檔案代號:infa_t
檔案名稱:貨架編號申請檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table infa_t
(
infaent       number(5)      ,/* 企業編號 */
infasite       varchar2(10)      ,/* 營運據點 */
infaunit       varchar2(10)      ,/* 應用組織 */
infadocno       varchar2(20)      ,/* 單據編號 */
infadocdt       date      ,/* 單據日期 */
infa001       varchar2(10)      ,/* 申請類型 */
infa002       varchar2(10)      ,/* 貨架類型 */
infa003       varchar2(20)      ,/* 申請人員 */
infa004       varchar2(10)      ,/* 申請部門 */
infaownid       varchar2(20)      ,/* 資料所有者 */
infaowndp       varchar2(10)      ,/* 資料所有部門 */
infacrtid       varchar2(20)      ,/* 資料建立者 */
infacrtdp       varchar2(10)      ,/* 資料建立部門 */
infacrtdt       timestamp(0)      ,/* 資料創建日 */
infamodid       varchar2(20)      ,/* 資料修改者 */
infamoddt       timestamp(0)      ,/* 最近修改日 */
infacnfid       varchar2(20)      ,/* 資料確認者 */
infacnfdt       timestamp(0)      ,/* 資料確認日 */
infapstid       varchar2(20)      ,/* 資料過帳者 */
infapstdt       timestamp(0)      ,/* 資料過賬日 */
infastus       varchar2(10)      ,/* 狀態 */
infa005       varchar2(10)      /* 管理品類 */
);
alter table infa_t add constraint infa_pk primary key (infaent,infadocno) enable validate;

create unique index infa_pk on infa_t (infaent,infadocno);

grant select on infa_t to tiptop;
grant update on infa_t to tiptop;
grant delete on infa_t to tiptop;
grant insert on infa_t to tiptop;

exit;
