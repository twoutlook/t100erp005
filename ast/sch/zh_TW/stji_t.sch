/* 
================================================================================
檔案代號:stji_t
檔案名稱:招商租賃合約定義帳期單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stji_t
(
stjient       number(5)      ,/* 企業編號 */
stjisite       varchar2(10)      ,/* 營運組織 */
stjiunit       varchar2(10)      ,/* 制定組織 */
stjiseq       number(10,0)      ,/* 項次 */
stji001       varchar2(20)      ,/* 合約編號 */
stji002       varchar2(10)      ,/* 費用編號 */
stji003       varchar2(10)      ,/* 結算方式 */
stji004       number(5,0)      ,/* 岀帳期 */
stji005       number(5,0)      ,/* 岀帳日 */
stji006       varchar2(10)      ,/* 核算制度 */
stji007       varchar2(1)      ,/* 納入結算單否 */
stji008       varchar2(1)      ,/* 票扣否 */
stji009       varchar2(1)      ,/* 類型 */
stji010       varchar2(10)      /* 稅別 */
);
alter table stji_t add constraint stji_pk primary key (stjient,stjiseq,stji001) enable validate;

create unique index stji_pk on stji_t (stjient,stjiseq,stji001);

grant select on stji_t to tiptop;
grant update on stji_t to tiptop;
grant delete on stji_t to tiptop;
grant insert on stji_t to tiptop;

exit;
