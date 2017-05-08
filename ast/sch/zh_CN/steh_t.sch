/* 
================================================================================
檔案代號:steh_t
檔案名稱:專櫃合同特殊條款申请資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table steh_t
(
stehent       number(5)      ,/* 企業編號 */
stehsite       varchar2(10)      ,/* 營運據點 */
stehunit       varchar2(10)      ,/* 應用組織 */
stehdocno       varchar2(20)      ,/* 單據編號 */
stehacti       varchar2(1)      ,/* 資料有效 */
stehseq       number(10,0)      ,/* 項次 */
steh001       varchar2(20)      ,/* 合同編號 */
steh002       varchar2(500)      ,/* 說明 */
steh003       varchar2(255)      /* 備註 */
);
alter table steh_t add constraint steh_pk primary key (stehent,stehdocno,stehseq) enable validate;

create unique index steh_pk on steh_t (stehent,stehdocno,stehseq);

grant select on steh_t to tiptop;
grant update on steh_t to tiptop;
grant delete on steh_t to tiptop;
grant insert on steh_t to tiptop;

exit;
