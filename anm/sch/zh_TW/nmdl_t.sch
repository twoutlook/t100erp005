/* 
================================================================================
檔案代號:nmdl_t
檔案名稱:日記帳對帳記錄檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table nmdl_t
(
nmdlent       number(5)      ,/* 企業編號 */
nmdldocno       varchar2(20)      ,/* 對帳單號 */
nmdlseq       varchar2(20)      ,/* 項次 */
nmdl001       varchar2(20)      ,/* 對帳流水號 */
nmdl002       varchar2(20)      ,/* 日記帳單據號 */
nmdl003       number(10,0)      ,/* 日記帳項次 */
nmdl004       varchar2(1)      ,/* 對帳碼 */
nmdl005       varchar2(1)      ,/* 對帳方式 */
nmdl006       varchar2(1)      ,/* 借貸別 */
nmdl007       number(20,6)      /* 原幣金額 */
);
alter table nmdl_t add constraint nmdl_pk primary key (nmdlent,nmdldocno,nmdlseq) enable validate;

create unique index nmdl_pk on nmdl_t (nmdlent,nmdldocno,nmdlseq);

grant select on nmdl_t to tiptop;
grant update on nmdl_t to tiptop;
grant delete on nmdl_t to tiptop;
grant insert on nmdl_t to tiptop;

exit;
