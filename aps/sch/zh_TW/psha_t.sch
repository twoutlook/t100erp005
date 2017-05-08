/* 
================================================================================
檔案代號:psha_t
檔案名稱:交期回覆模擬單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:H
多語系檔案:N
============.========================.==========================================
 */
create table psha_t
(
pshaent       number(5)      ,/* 企業編號 */
pshasite       varchar2(10)      ,/* 營運據點 */
psha001       varchar2(10)      ,/* ATP編號 */
psha002       varchar2(20)      ,/* 訂單單號 */
psha003       varchar2(40)      /* sessionkey */
);
alter table psha_t add constraint psha_pk primary key (pshaent,pshasite,psha001) enable validate;

create unique index psha_pk on psha_t (pshaent,pshasite,psha001);

grant select on psha_t to tiptop;
grant update on psha_t to tiptop;
grant delete on psha_t to tiptop;
grant insert on psha_t to tiptop;

exit;
