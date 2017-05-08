/* 
================================================================================
檔案代號:stfj_t
檔案名稱:專櫃合同结算帐期檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stfj_t
(
stfjent       number(5)      ,/* 企業編號 */
stfjsite       varchar2(10)      ,/* 營運據點 */
stfjunit       varchar2(10)      ,/* 應用組織 */
stfjseq       number(10,0)      ,/* 帳期 */
stfj001       varchar2(20)      ,/* 合同編號 */
stfj002       date      ,/* 起始日期 */
stfj003       date      ,/* 截止日期 */
stfj004       date      ,/* 結算日期 */
stfj005       varchar2(1)      ,/* 結算否 */
stfj006       varchar2(20)      /* 結算單號 */
);
alter table stfj_t add constraint stfj_pk primary key (stfjent,stfjseq,stfj001) enable validate;

create unique index stfj_pk on stfj_t (stfjent,stfjseq,stfj001);

grant select on stfj_t to tiptop;
grant update on stfj_t to tiptop;
grant delete on stfj_t to tiptop;
grant insert on stfj_t to tiptop;

exit;
