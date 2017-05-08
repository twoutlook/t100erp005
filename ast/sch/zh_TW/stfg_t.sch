/* 
================================================================================
檔案代號:stfg_t
檔案名稱:專櫃合同場地資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stfg_t
(
stfgent       number(5)      ,/* 企業編號 */
stfgunit       varchar2(10)      ,/* 應用組織 */
stfgacti       varchar2(1)      ,/* 資料有效 */
stfgsite       varchar2(10)      ,/* 營運據點 */
stfgseq       number(10,0)      ,/* 項次 */
stfg001       varchar2(20)      ,/* 合同編號 */
stfg002       varchar2(10)      ,/* 場地編號 */
stfg003       varchar2(10)      ,/* 區域編號 */
stfg004       number(20,6)      ,/* 建築面積 */
stfg005       number(20,6)      /* 經營面積 */
);
alter table stfg_t add constraint stfg_pk primary key (stfgent,stfgseq,stfg001) enable validate;

create unique index stfg_pk on stfg_t (stfgent,stfgseq,stfg001);

grant select on stfg_t to tiptop;
grant update on stfg_t to tiptop;
grant delete on stfg_t to tiptop;
grant insert on stfg_t to tiptop;

exit;
