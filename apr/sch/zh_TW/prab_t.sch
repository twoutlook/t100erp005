/* 
================================================================================
檔案代號:prab_t
檔案名稱:促銷策略-疊加基本資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table prab_t
(
prabent       number(5)      ,/* 企業編號 */
prabunit       varchar2(10)      ,/* 應用組織 */
prab001       varchar2(10)      ,/* 促銷類型 */
prab002       varchar2(10)      ,/* 疊加促銷類型 */
prabstus       varchar2(10)      ,/* 狀態碼 */
prab000       varchar2(10)      /* 疊加類型 */
);
alter table prab_t add constraint prab_pk primary key (prabent,prab001,prab002) enable validate;

create unique index prab_pk on prab_t (prabent,prab001,prab002);

grant select on prab_t to tiptop;
grant update on prab_t to tiptop;
grant delete on prab_t to tiptop;
grant insert on prab_t to tiptop;

exit;
