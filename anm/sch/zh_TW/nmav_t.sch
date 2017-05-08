/* 
================================================================================
檔案代號:nmav_t
檔案名稱:網銀支付默認類型檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table nmav_t
(
nmavent       number(5)      ,/* 企業編碼 */
nmav001       varchar2(15)      ,/* 網銀編碼 */
nmav002       varchar2(1)      ,/* 本地他行 */
nmav003       varchar2(1)      ,/* 對公對私 */
nmav004       varchar2(10)      ,/* 提交類型 */
nmav005       varchar2(10)      ,/* 更新類型 */
nmavstus       varchar2(1)      ,/* 有效碼 */
nmavownid       varchar2(20)      ,/* 資料所有者 */
nmavowndp       varchar2(10)      ,/* 資料所屬部門 */
nmavcrtid       varchar2(20)      ,/* 資料建立者 */
nmavcrtdp       varchar2(10)      ,/* 資料建立部門 */
nmavcrtdt       timestamp(0)      ,/* 資料創建日 */
nmavmodid       varchar2(20)      ,/* 資料修改者 */
nmavmoddt       timestamp(0)      /* 最近修改日 */
);
alter table nmav_t add constraint nmav_pk primary key (nmavent,nmav001,nmav002,nmav003) enable validate;

create unique index nmav_pk on nmav_t (nmavent,nmav001,nmav002,nmav003);

grant select on nmav_t to tiptop;
grant update on nmav_t to tiptop;
grant delete on nmav_t to tiptop;
grant insert on nmav_t to tiptop;

exit;
