/* 
================================================================================
檔案代號:steg_t
檔案名稱:專櫃合同場地申请資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table steg_t
(
stegent       number(5)      ,/* 企業編號 */
stegsite       varchar2(10)      ,/* 營運據點 */
stegunit       varchar2(10)      ,/* 應用組織 */
stegdocno       varchar2(20)      ,/* 單據編號 */
stegacti       varchar2(1)      ,/* 資料有效 */
stegseq       number(10,0)      ,/* 項次 */
steg001       varchar2(20)      ,/* 合同編號 */
steg002       varchar2(10)      ,/* 場地編號 */
steg003       varchar2(10)      ,/* 區域編號 */
steg004       number(20,6)      ,/* 建築面積 */
steg005       number(20,6)      /* 經營面積 */
);
alter table steg_t add constraint steg_pk primary key (stegent,stegdocno,stegseq) enable validate;

create unique index steg_pk on steg_t (stegent,stegdocno,stegseq);

grant select on steg_t to tiptop;
grant update on steg_t to tiptop;
grant delete on steg_t to tiptop;
grant insert on steg_t to tiptop;

exit;
