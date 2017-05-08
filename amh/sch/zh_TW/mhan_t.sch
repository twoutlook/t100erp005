/* 
================================================================================
檔案代號:mhan_t
檔案名稱:組織電話費設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table mhan_t
(
mhanent       number(5)      ,/* 企業編號 */
mhan001       varchar2(20)      ,/* 電話號碼 */
mhan002       varchar2(1)      ,/* 類型 */
mhan003       varchar2(10)      ,/* 組織編號 */
mhan004       varchar2(10)      ,/* 專櫃編號 */
mhan005       varchar2(10)      ,/* 部門編號 */
mhan006       number(5,0)      ,/* 品類層級 */
mhan007       varchar2(10)      ,/* 品類編號 */
mhan008       varchar2(1)      ,/* 是否收費 */
mhan009       varchar2(255)      ,/* 備註 */
mhanownid       varchar2(20)      ,/* 資料所有者 */
mhanowndp       varchar2(10)      ,/* 資料所屬部門 */
mhancrtid       varchar2(20)      ,/* 資料建立者 */
mhancrtdp       varchar2(10)      ,/* 資料建立部門 */
mhancrtdt       timestamp(0)      ,/* 資料創建日 */
mhanmodid       varchar2(20)      ,/* 資料修改者 */
mhanmoddt       timestamp(0)      ,/* 最近修改日 */
mhancnfid       varchar2(20)      ,/* 資料確認者 */
mhancnfdt       timestamp(0)      ,/* 資料確認日 */
mhanstus       varchar2(10)      /* 狀態碼 */
);
alter table mhan_t add constraint mhan_pk primary key (mhanent,mhan001) enable validate;

create unique index mhan_pk on mhan_t (mhanent,mhan001);

grant select on mhan_t to tiptop;
grant update on mhan_t to tiptop;
grant delete on mhan_t to tiptop;
grant insert on mhan_t to tiptop;

exit;
