/* 
================================================================================
檔案代號:rmda_t
檔案名稱:RMA覆出單單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table rmda_t
(
rmdaent       number(5)      ,/* 企業編號 */
rmdasite       varchar2(10)      ,/* 營運據點 */
rmdadocno       varchar2(20)      ,/* 覆出單號 */
rmdadocdt       date      ,/* 覆出日期 */
rmda001       date      ,/* 扣帳日期 */
rmda002       varchar2(20)      ,/* 業務人員 */
rmda003       varchar2(10)      ,/* 業務部門 */
rmda004       varchar2(20)      ,/* RMA單號 */
rmda005       varchar2(10)      ,/* 客戶編號 */
rmda006       varchar2(10)      ,/* 收貨客戶 */
rmda007       varchar2(10)      ,/* 帳款客戶 */
rmda008       varchar2(10)      ,/* 發票客戶 */
rmda009       varchar2(1)      ,/* 包裝單製作 */
rmda010       varchar2(1)      ,/* invoice製作 */
rmda011       varchar2(10)      ,/* 送貨地址 */
rmda012       varchar2(10)      ,/* 運輸方式 */
rmda013       varchar2(10)      ,/* 起運地 */
rmda014       varchar2(10)      ,/* 目的地 */
rmda015       varchar2(10)      ,/* 送貨供應商 */
rmda016       varchar2(20)      ,/* 航班/船班/車號 */
rmda017       date      ,/* 起運日期 */
rmda018       varchar2(30)      ,/* 嘜頭編號 */
rmda019       varchar2(1)      ,/* 運輸狀態 */
rmdaownid       varchar2(20)      ,/* 資料所有者 */
rmdaowndp       varchar2(10)      ,/* 資料所屬部門 */
rmdacrtid       varchar2(20)      ,/* 資料建立者 */
rmdacrtdp       varchar2(10)      ,/* 資料建立部門 */
rmdacrtdt       timestamp(0)      ,/* 資料創建日 */
rmdamodid       varchar2(20)      ,/* 資料修改者 */
rmdamoddt       timestamp(0)      ,/* 最近修改日 */
rmdastus       varchar2(10)      ,/* 狀態碼 */
rmdacnfid       varchar2(20)      ,/* 資料確認者 */
rmdacnfdt       timestamp(0)      ,/* 資料確認日 */
rmdapstid       varchar2(20)      ,/* 資料過帳者 */
rmdapstdt       timestamp(0)      /* 資料過帳日 */
);
alter table rmda_t add constraint rmda_pk primary key (rmdaent,rmdadocno) enable validate;

create unique index rmda_pk on rmda_t (rmdaent,rmdadocno);

grant select on rmda_t to tiptop;
grant update on rmda_t to tiptop;
grant delete on rmda_t to tiptop;
grant insert on rmda_t to tiptop;

exit;
