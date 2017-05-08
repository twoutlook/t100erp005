/* 
================================================================================
檔案代號:sted_t
檔案名稱:專櫃合同庫區會員促銷申请設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table sted_t
(
stedent       number(5)      ,/* 企業編號 */
stedsite       varchar2(10)      ,/* 營運據點 */
stedunit       varchar2(10)      ,/* 應用組織 */
steddocno       varchar2(20)      ,/* 單據編號 */
stedseq       number(10,0)      ,/* 項次 */
stedseq1       number(10,0)      ,/* 項次1 */
sted001       varchar2(20)      ,/* 合同編號 */
sted002       varchar2(10)      ,/* 方案編號 */
sted003       varchar2(10)      ,/* 庫區編號 */
sted004       varchar2(10)      ,/* 會員等級 */
sted005       number(22,2)      ,/* 積點規則 */
sted006       number(20,6)      ,/* 折扣率 */
sted007       number(20,6)      ,/* 折扣分攤比例 */
sted008       number(20,6)      ,/* 會員折扣可參與折率 */
sted009       number(22,2)      /* 特價積分 */
);
alter table sted_t add constraint sted_pk primary key (stedent,steddocno,stedseq,stedseq1) enable validate;

create unique index sted_pk on sted_t (stedent,steddocno,stedseq,stedseq1);

grant select on sted_t to tiptop;
grant update on sted_t to tiptop;
grant delete on sted_t to tiptop;
grant insert on sted_t to tiptop;

exit;
