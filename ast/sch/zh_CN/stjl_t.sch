/* 
================================================================================
檔案代號:stjl_t
檔案名稱:招商租賃合約單價收費專案單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stjl_t
(
stjlent       number(5)      ,/* 企業編號 */
stjlsite       varchar2(10)      ,/* 營運組織 */
stjlunit       varchar2(10)      ,/* 制定組織 */
stjlseq       number(10,0)      ,/* 項次 */
stjl001       varchar2(20)      ,/* 合約編號 */
stjl002       varchar2(10)      ,/* 費用類型 */
stjl003       varchar2(10)      ,/* 費用編號 */
stjl004       varchar2(1)      ,/* 納入結算單否 */
stjl005       varchar2(1)      ,/* 票扣否 */
stjl006       number(20,6)      ,/* 单价 */
stjl007       number(20,6)      ,/* 優惠度數 */
stjl008       number(20,6)      /* 優惠金額 */
);
alter table stjl_t add constraint stjl_pk primary key (stjlent,stjlseq,stjl001) enable validate;

create unique index stjl_pk on stjl_t (stjlent,stjlseq,stjl001);

grant select on stjl_t to tiptop;
grant update on stjl_t to tiptop;
grant delete on stjl_t to tiptop;
grant insert on stjl_t to tiptop;

exit;
