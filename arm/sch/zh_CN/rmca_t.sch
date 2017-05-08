/* 
================================================================================
檔案代號:rmca_t
檔案名稱:RMA判別單單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table rmca_t
(
rmcaent       number(5)      ,/* 企業編號 */
rmcasite       varchar2(10)      ,/* 營運據點 */
rmcadocno       varchar2(20)      ,/* 判別單號 */
rmcadocdt       date      ,/* 判別日期 */
rmca001       varchar2(20)      ,/* RMA單號 */
rmca002       varchar2(10)      ,/* 客戶編號 */
rmca003       varchar2(20)      ,/* 判別人員 */
rmca004       varchar2(10)      ,/* 判別部門 */
rmcaownid       varchar2(20)      ,/* 資料所有者 */
rmcaowndp       varchar2(10)      ,/* 資料所屬部門 */
rmcacrtid       varchar2(20)      ,/* 資料建立者 */
rmcacrtdp       varchar2(10)      ,/* 資料建立部門 */
rmcacrtdt       timestamp(0)      ,/* 資料創建日 */
rmcamodid       varchar2(20)      ,/* 資料修改者 */
rmcamoddt       timestamp(0)      ,/* 最近修改日 */
rmcacnfid       varchar2(20)      ,/* 資料確認者 */
rmcacnfdt       timestamp(0)      ,/* 資料確認日 */
rmcapstid       varchar2(20)      ,/* 資料過帳者 */
rmcapstdt       timestamp(0)      ,/* 資料過帳日 */
rmcastus       varchar2(10)      /* 狀態碼 */
);
alter table rmca_t add constraint rmca_pk primary key (rmcaent,rmcadocno) enable validate;

create unique index rmca_pk on rmca_t (rmcaent,rmcadocno);

grant select on rmca_t to tiptop;
grant update on rmca_t to tiptop;
grant delete on rmca_t to tiptop;
grant insert on rmca_t to tiptop;

exit;
