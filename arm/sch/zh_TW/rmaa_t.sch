/* 
================================================================================
檔案代號:rmaa_t
檔案名稱:RMA維護單單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table rmaa_t
(
rmaaent       number(5)      ,/* 企業編號 */
rmaasite       varchar2(10)      ,/* 營運據點 */
rmaadocno       varchar2(20)      ,/* 單據單號 */
rmaadocdt       date      ,/* 單據日期 */
rmaa001       varchar2(10)      ,/* 客戶編號 */
rmaa002       varchar2(20)      ,/* 業務人員 */
rmaa003       varchar2(10)      ,/* 業務部門 */
rmaa004       varchar2(20)      ,/* 客訴單號 */
rmaa005       varchar2(20)      ,/* 出貨單號 */
rmaa006       varchar2(20)      ,/* 訂單單號 */
rmaa007       varchar2(500)      ,/* 問題描述 */
rmaaownid       varchar2(20)      ,/* 資料所有者 */
rmaaowndp       varchar2(10)      ,/* 資料所屬部門 */
rmaacrtid       varchar2(20)      ,/* 資料建立者 */
rmaacrtdp       varchar2(10)      ,/* 資料建立部門 */
rmaacrtdt       timestamp(0)      ,/* 資料創建日 */
rmaamodid       varchar2(20)      ,/* 資料修改者 */
rmaamoddt       timestamp(0)      ,/* 最近修改日 */
rmaacnfid       varchar2(20)      ,/* 資料確認者 */
rmaacnfdt       timestamp(0)      ,/* 資料確認日 */
rmaastus       varchar2(10)      ,/* 狀態碼 */
rmaa008       date      ,/* 扣帳日期 */
rmaapstid       varchar2(20)      ,/* 資料過帳者 */
rmaapstdt       timestamp(0)      /* 資料過帳日 */
);
alter table rmaa_t add constraint rmaa_pk primary key (rmaaent,rmaadocno) enable validate;

create unique index rmaa_pk on rmaa_t (rmaaent,rmaadocno);

grant select on rmaa_t to tiptop;
grant update on rmaa_t to tiptop;
grant delete on rmaa_t to tiptop;
grant insert on rmaa_t to tiptop;

exit;
