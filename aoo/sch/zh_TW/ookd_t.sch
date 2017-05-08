/* 
================================================================================
檔案代號:ookd_t
檔案名稱:異常管理人員權限檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table ookd_t
(
ookdent       number(5)      ,/*   */
ookd001       varchar2(10)      ,/* 人員編號 */
ookd002       varchar2(10)      ,/* 檢核編號 */
ookdud001       varchar2(40)      ,/*   */
ookdud002       varchar2(40)      ,/*   */
ookdud003       varchar2(40)      ,/*   */
ookdud004       varchar2(40)      ,/*   */
ookdud005       varchar2(40)      ,/*   */
ookdud006       varchar2(40)      ,/*   */
ookdud007       varchar2(40)      ,/*   */
ookdud008       varchar2(40)      ,/*   */
ookdud009       varchar2(40)      ,/*   */
ookdud010       varchar2(40)      ,/*   */
ookdud011       number(20,6)      ,/*   */
ookdud012       number(20,6)      ,/*   */
ookdud013       number(20,6)      ,/*   */
ookdud014       number(20,6)      ,/*   */
ookdud015       number(20,6)      ,/*   */
ookdud016       number(20,6)      ,/*   */
ookdud017       number(20,6)      ,/*   */
ookdud018       number(20,6)      ,/*   */
ookdud019       number(20,6)      ,/*   */
ookdud020       number(20,6)      ,/*   */
ookdud021       timestamp(0)      ,/*   */
ookdud022       timestamp(0)      ,/*   */
ookdud023       timestamp(0)      ,/*   */
ookdud024       timestamp(0)      ,/*   */
ookdud025       timestamp(0)      ,/*   */
ookdud026       timestamp(0)      ,/*   */
ookdud027       timestamp(0)      ,/*   */
ookdud028       timestamp(0)      ,/*   */
ookdud029       timestamp(0)      ,/*   */
ookdud030       timestamp(0)      /*   */
);
alter table ookd_t add constraint ookd_pk primary key (ookdent,ookd001,ookd002) enable validate;

create unique index ookd_pk on ookd_t (ookdent,ookd001,ookd002);

grant select on ookd_t to tiptop;
grant update on ookd_t to tiptop;
grant delete on ookd_t to tiptop;
grant insert on ookd_t to tiptop;

exit;
