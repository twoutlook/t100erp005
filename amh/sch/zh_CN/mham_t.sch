/* 
================================================================================
檔案代號:mham_t
檔案名稱:電器基本資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table mham_t
(
mhament       number(5)      ,/* 企業編號 */
mham001       varchar2(20)      ,/* 電器編號 */
mham002       varchar2(1)      ,/* 類型 */
mham003       number(20,6)      ,/* 功率(W) */
mham004       number(20,6)      ,/* 數量 */
mham005       varchar2(10)      ,/* 組織編號 */
mham006       varchar2(10)      ,/* 專櫃編號 */
mham007       varchar2(10)      ,/* 部門編號 */
mham008       number(20,6)      ,/* 計費係數 */
mham009       number(5,0)      ,/* 品類層級 */
mham010       varchar2(10)      ,/* 品類編號 */
mham011       varchar2(1)      ,/* 分攤原則 */
mham012       varchar2(1)      ,/* 產生費用單否 */
mham013       varchar2(255)      ,/* 備註 */
mhamownid       varchar2(20)      ,/* 資料所有者 */
mhamowndp       varchar2(10)      ,/* 資料所屬部門 */
mhamcrtid       varchar2(20)      ,/* 資料建立者 */
mhamcrtdp       varchar2(10)      ,/* 資料建立部門 */
mhamcrtdt       timestamp(0)      ,/* 資料創建日 */
mhammodid       varchar2(20)      ,/* 資料修改者 */
mhammoddt       timestamp(0)      ,/* 最近修改日 */
mhamcnfid       varchar2(20)      ,/* 資料確認者 */
mhamcnfdt       timestamp(0)      ,/* 資料確認日 */
mhamstus       varchar2(10)      /* 狀態碼 */
);
alter table mham_t add constraint mham_pk primary key (mhament,mham001) enable validate;

create unique index mham_pk on mham_t (mhament,mham001);

grant select on mham_t to tiptop;
grant update on mham_t to tiptop;
grant delete on mham_t to tiptop;
grant insert on mham_t to tiptop;

exit;
