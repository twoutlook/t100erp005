/* 
================================================================================
檔案代號:stay_t
檔案名稱:自營合約申請單自定義範圍設定表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stay_t
(
stayent       number(5)      ,/* 企業編號 */
staydocno       varchar2(20)      ,/* 單據編號 */
stayseq1       number(10,0)      ,/* 項次 */
stayseq2       number(10,0)      ,/* 項次2 */
stay001       varchar2(20)      ,/* 合同編號 */
stay002       varchar2(10)      ,/* 範圍類型 */
stay003       varchar2(10)      ,/* 屬性類型 */
stay004       varchar2(40)      ,/* 類型編號 */
stay005       varchar2(10)      /* 方向 */
);
alter table stay_t add constraint stay_pk primary key (stayent,staydocno,stayseq1,stayseq2) enable validate;

create unique index stay_pk on stay_t (stayent,staydocno,stayseq1,stayseq2);

grant select on stay_t to tiptop;
grant update on stay_t to tiptop;
grant delete on stay_t to tiptop;
grant insert on stay_t to tiptop;

exit;
