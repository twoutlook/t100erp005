/* 
================================================================================
檔案代號:ookc_t
檔案名稱:異常管理職能角色權限檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table ookc_t
(
ookcent       number(5)      ,/*   */
ookc001       varchar2(10)      ,/* 職能角色編號 */
ookc002       varchar2(10)      ,/* 檢核編號 */
ookcud001       varchar2(40)      ,/*   */
ookcud002       varchar2(40)      ,/*   */
ookcud003       varchar2(40)      ,/*   */
ookcud004       varchar2(40)      ,/*   */
ookcud005       varchar2(40)      ,/*   */
ookcud006       varchar2(40)      ,/*   */
ookcud007       varchar2(40)      ,/*   */
ookcud008       varchar2(40)      ,/*   */
ookcud009       varchar2(40)      ,/*   */
ookcud010       varchar2(40)      ,/*   */
ookcud011       number(20,6)      ,/*   */
ookcud012       number(20,6)      ,/*   */
ookcud013       number(20,6)      ,/*   */
ookcud014       number(20,6)      ,/*   */
ookcud015       number(20,6)      ,/*   */
ookcud016       number(20,6)      ,/*   */
ookcud017       number(20,6)      ,/*   */
ookcud018       number(20,6)      ,/*   */
ookcud019       number(20,6)      ,/*   */
ookcud020       number(20,6)      ,/*   */
ookcud021       timestamp(0)      ,/*   */
ookcud022       timestamp(0)      ,/*   */
ookcud023       timestamp(0)      ,/*   */
ookcud024       timestamp(0)      ,/*   */
ookcud025       timestamp(0)      ,/*   */
ookcud026       timestamp(0)      ,/*   */
ookcud027       timestamp(0)      ,/*   */
ookcud028       timestamp(0)      ,/*   */
ookcud029       timestamp(0)      ,/*   */
ookcud030       timestamp(0)      /*   */
);
alter table ookc_t add constraint ookc_pk primary key (ookcent,ookc001,ookc002) enable validate;

create unique index ookc_pk on ookc_t (ookcent,ookc001,ookc002);

grant select on ookc_t to tiptop;
grant update on ookc_t to tiptop;
grant delete on ookc_t to tiptop;
grant insert on ookc_t to tiptop;

exit;
