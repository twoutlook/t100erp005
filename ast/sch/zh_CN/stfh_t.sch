/* 
================================================================================
檔案代號:stfh_t
檔案名稱:專櫃合同特殊條款資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stfh_t
(
stfhent       number(5)      ,/* 企業編號 */
stfhunit       varchar2(10)      ,/* 應用組織 */
stfhacti       varchar2(1)      ,/* 資料有效 */
stfhsite       varchar2(10)      ,/* 營運據點 */
stfhseq       number(10,0)      ,/* 項次 */
stfh001       varchar2(20)      ,/* 合同編號 */
stfh002       varchar2(500)      ,/* 說明 */
stfh003       varchar2(255)      /* 備註 */
);
alter table stfh_t add constraint stfh_pk primary key (stfhent,stfhseq,stfh001) enable validate;

create unique index stfh_pk on stfh_t (stfhent,stfhseq,stfh001);

grant select on stfh_t to tiptop;
grant update on stfh_t to tiptop;
grant delete on stfh_t to tiptop;
grant insert on stfh_t to tiptop;

exit;
