/* 
================================================================================
檔案代號:stfd_t
檔案名稱:專櫃合同庫區會員促銷設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stfd_t
(
stfdent       number(5)      ,/* 企業編號 */
stfdsite       varchar2(10)      ,/* 營運據點 */
stfdunit       varchar2(10)      ,/* 應用組織 */
stfd001       varchar2(20)      ,/* 合同編號 */
stfdseq       number(10,0)      ,/* 項次 */
stfdseq1       number(10,0)      ,/* 項次1 */
stfd002       varchar2(10)      ,/* 方案編號 */
stfd003       varchar2(10)      ,/* 庫區編號 */
stfd004       varchar2(10)      ,/* 會員等級 */
stfd005       number(22,2)      ,/* 積點規則 */
stfd006       number(20,6)      ,/* 折扣率 */
stfd007       number(20,6)      ,/* 折扣分攤比例 */
stfd008       number(20,6)      ,/* 會員折扣可參與折率 */
stfd009       number(22,2)      /* 特價積分 */
);
alter table stfd_t add constraint stfd_pk primary key (stfdent,stfd001,stfdseq,stfdseq1) enable validate;

create unique index stfd_pk on stfd_t (stfdent,stfd001,stfdseq,stfdseq1);

grant select on stfd_t to tiptop;
grant update on stfd_t to tiptop;
grant delete on stfd_t to tiptop;
grant insert on stfd_t to tiptop;

exit;
