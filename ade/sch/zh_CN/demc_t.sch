/* 
================================================================================
檔案代號:demc_t
檔案名稱:經銷商日結記錄檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table demc_t
(
demcent       number(5)      ,/* 企業編號 */
demcsite       varchar2(10)      ,/* 營運據點 */
demc001       date      ,/* 日結日期 */
demc002       varchar2(20)      ,/* 日結作業編號 */
demc003       number(5,0)      ,/* 日結執行次數 */
demc004       varchar2(20)      ,/* 最後異動人員 */
demc005       timestamp(0)      /* 最後異動日期 */
);
alter table demc_t add constraint demc_pk primary key (demcent,demcsite,demc001,demc002) enable validate;

create unique index demc_pk on demc_t (demcent,demcsite,demc001,demc002);

grant select on demc_t to tiptop;
grant update on demc_t to tiptop;
grant delete on demc_t to tiptop;
grant insert on demc_t to tiptop;

exit;
