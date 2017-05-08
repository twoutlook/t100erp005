/* 
================================================================================
檔案代號:indp_t
檔案名稱:商品實際庫存調整表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table indp_t
(
indpent       number(5)      ,/* 企業編號 */
indpsite       varchar2(10)      ,/* 營運組織 */
indpunit       varchar2(10)      ,/* 應用組織 */
indpdocno       varchar2(20)      ,/* 單據編號 */
indpdocdt       date      ,/* 單據日期 */
indp001       varchar2(10)      ,/* 管理品類 */
indp002       varchar2(20)      ,/* 調整人員 */
indp003       varchar2(10)      ,/* 調整部門 */
indpstus       varchar2(10)      ,/* 狀態 */
indpownid       varchar2(20)      ,/* 資料所有者 */
indpowndp       varchar2(10)      ,/* 資料所屬部門 */
indpcrtid       varchar2(20)      ,/* 資料建立者 */
indpcrtdp       varchar2(10)      ,/* 資料建立部門 */
indpcrtdt       timestamp(0)      ,/* 資料創建日 */
indpmodid       varchar2(20)      ,/* 資料修改者 */
indpmoddt       timestamp(0)      ,/* 最近修改日 */
indpcnfid       varchar2(20)      ,/* 資料確認者 */
indpcnfdt       timestamp(0)      ,/* 資料確認日 */
indppstid       varchar2(20)      ,/* 資料過帳者 */
indppstdt       timestamp(0)      /* 資料過帳日 */
);
alter table indp_t add constraint indp_pk primary key (indpent,indpdocno) enable validate;

create unique index indp_pk on indp_t (indpent,indpdocno);

grant select on indp_t to tiptop;
grant update on indp_t to tiptop;
grant delete on indp_t to tiptop;
grant insert on indp_t to tiptop;

exit;
