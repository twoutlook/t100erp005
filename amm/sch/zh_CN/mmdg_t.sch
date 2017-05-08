/* 
================================================================================
檔案代號:mmdg_t
檔案名稱:收卡金額限定申請明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table mmdg_t
(
mmdgent       number(5)      ,/* 企業編號 */
mmdgunit       varchar2(10)      ,/* 應用組織 */
mmdgsite       varchar2(10)      ,/* 營運組織 */
mmdgdocno       varchar2(20)      ,/* 單據編號 */
mmdg001       varchar2(30)      ,/* 活動規則編號 */
mmdg002       varchar2(10)      ,/* 卡種 */
mmdg003       number(10,0)      ,/* 序號 */
mmdg004       number(20,6)      ,/* 達成金額 */
mmdg005       number(20,6)      ,/* 單位金額 */
mmdg006       number(20,6)      ,/* 單位收款金額 */
mmdg007       number(20,6)      ,/* 收卡金額上限 */
mmdgacti       varchar2(1)      /* 資料有效 */
);
alter table mmdg_t add constraint mmdg_pk primary key (mmdgent,mmdgdocno,mmdg003) enable validate;

create unique index mmdg_pk on mmdg_t (mmdgent,mmdgdocno,mmdg003);

grant select on mmdg_t to tiptop;
grant update on mmdg_t to tiptop;
grant delete on mmdg_t to tiptop;
grant insert on mmdg_t to tiptop;

exit;
