/* 
================================================================================
檔案代號:stjj_t
檔案名稱:招商租賃合約場地資訊單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stjj_t
(
stjjent       number(5)      ,/* 企業編號 */
stjjsite       varchar2(10)      ,/* 營運組織 */
stjjunit       varchar2(10)      ,/* 制定組織 */
stjjseq       number(10,0)      ,/* 項次 */
stjjacti       varchar2(1)      ,/* 有效否 */
stjj001       varchar2(20)      ,/* 合約編號 */
stjj002       varchar2(20)      ,/* 場地編號 */
stjj003       number(20,6)      ,/* 建築面積 */
stjj004       number(20,6)      ,/* 測量面積 */
stjj005       number(20,6)      ,/* 經營面積 */
stjj006       varchar2(10)      ,/* 樓棟編號 */
stjj007       varchar2(10)      ,/* 樓層編號 */
stjj008       varchar2(10)      ,/* 區域編號 */
stjj009       varchar2(10)      /* 合約版本 */
);
alter table stjj_t add constraint stjj_pk primary key (stjjent,stjjseq,stjj001) enable validate;

create unique index stjj_pk on stjj_t (stjjent,stjjseq,stjj001);

grant select on stjj_t to tiptop;
grant update on stjj_t to tiptop;
grant delete on stjj_t to tiptop;
grant insert on stjj_t to tiptop;

exit;
