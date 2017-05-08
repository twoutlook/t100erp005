/* 
================================================================================
檔案代號:stfm_t
檔案名稱:合同異動明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table stfm_t
(
stfment       number(5)      ,/* 企業代碼 */
stfmsite       varchar2(10)      ,/* 營運據點 */
stfmunit       varchar2(10)      ,/* 應用執行組織物件 */
stfmdocno       varchar2(20)      ,/* 單號 */
stfm001       varchar2(20)      ,/* 合同編號 */
stfm002       varchar2(10)      ,/* 專櫃編號 */
stfm003       varchar2(10)      ,/* 供應商編號 */
stfm004       date      /* 執行日期 */
);
alter table stfm_t add constraint stfm_pk primary key (stfment,stfmdocno) enable validate;

create unique index stfm_pk on stfm_t (stfment,stfmdocno);

grant select on stfm_t to tiptop;
grant update on stfm_t to tiptop;
grant delete on stfm_t to tiptop;
grant insert on stfm_t to tiptop;

exit;
