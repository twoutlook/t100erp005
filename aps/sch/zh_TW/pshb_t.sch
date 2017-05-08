/* 
================================================================================
檔案代號:pshb_t
檔案名稱:交期回覆模擬單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:H
多語系檔案:N
============.========================.==========================================
 */
create table pshb_t
(
pshbent       number(5)      ,/* 企業編號 */
pshbsite       varchar2(10)      ,/* 營運據點 */
pshb001       varchar2(10)      ,/* ATP編號 */
pshbseq       number(10,0)      ,/* 項次 */
pshbseq1       number(10,0)      ,/* 項序 */
pshbseq2       number(10,0)      ,/* 分批序 */
pshb002       varchar2(40)      ,/* 料件編號 */
pshb003       varchar2(256)      ,/* 產品特徵 */
pshb004       varchar2(10)      ,/* 單位 */
pshb005       number(20,6)      ,/* 數量 */
pshb006       date      ,/* 預計交期 */
pshb007       varchar2(1)      /* 保稅否 */
);
alter table pshb_t add constraint pshb_pk primary key (pshbent,pshbsite,pshb001,pshbseq,pshbseq1,pshbseq2) enable validate;

create unique index pshb_pk on pshb_t (pshbent,pshbsite,pshb001,pshbseq,pshbseq1,pshbseq2);

grant select on pshb_t to tiptop;
grant update on pshb_t to tiptop;
grant delete on pshb_t to tiptop;
grant insert on pshb_t to tiptop;

exit;
