/* 
================================================================================
檔案代號:nmbr_t
檔案名稱:內部資金還款明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table nmbr_t
(
nmbrent       number(5)      ,/* 企業編碼 */
nmbrdocno       varchar2(20)      ,/* 還款單號 */
nmbrseq       number(10,0)      ,/* 序號 */
nmbr001       varchar2(10)      ,/* 資金中心 */
nmbr002       varchar2(10)      ,/* 還款組織 */
nmbr003       varchar2(10)      ,/* 還款內部帳戶代碼 */
nmbr004       varchar2(10)      ,/* 受款組織 */
nmbr005       varchar2(10)      ,/* 受款內部帳戶代碼 */
nmbr006       varchar2(10)      ,/* 幣別 */
nmbr007       number(20,6)      /* 還款金額 */
);
alter table nmbr_t add constraint nmbr_pk primary key (nmbrent,nmbrdocno,nmbrseq) enable validate;

create unique index nmbr_pk on nmbr_t (nmbrent,nmbrdocno,nmbrseq);

grant select on nmbr_t to tiptop;
grant update on nmbr_t to tiptop;
grant delete on nmbr_t to tiptop;
grant insert on nmbr_t to tiptop;

exit;
