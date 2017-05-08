/* 
================================================================================
檔案代號:mmdh_t
檔案名稱:收卡金額限定明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table mmdh_t
(
mmdhent       number(5)      ,/* 企業編號 */
mmdhunit       varchar2(10)      ,/* 應用組織 */
mmdhsite       varchar2(10)      ,/* 營運組織 */
mmdh001       varchar2(30)      ,/* 活動規則編號 */
mmdh002       varchar2(10)      ,/* 卡種 */
mmdh003       number(10,0)      ,/* 序號 */
mmdh004       number(20,6)      ,/* 達成金額 */
mmdh005       number(20,6)      ,/* 單位金額 */
mmdh006       number(20,6)      ,/* 單位收款金額 */
mmdh007       number(20,6)      ,/* 收卡金額上限 */
mmdhacti       varchar2(1)      /* 資料有效 */
);
alter table mmdh_t add constraint mmdh_pk primary key (mmdhent,mmdh001,mmdh003) enable validate;

create unique index mmdh_pk on mmdh_t (mmdhent,mmdh001,mmdh003);

grant select on mmdh_t to tiptop;
grant update on mmdh_t to tiptop;
grant delete on mmdh_t to tiptop;
grant insert on mmdh_t to tiptop;

exit;
