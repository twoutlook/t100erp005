/* 
================================================================================
檔案代號:stjm_t
檔案名稱:招商租賃合約帳期單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stjm_t
(
stjment       number(5)      ,/* 企業編號 */
stjmsite       varchar2(10)      ,/* 營運組織 */
stjmunit       varchar2(10)      ,/* 制定組織 */
stjmseq       number(10,0)      ,/* 項次 */
stjm001       varchar2(20)      ,/* 合約編號 */
stjm002       number(5,0)      ,/* 結算帳期 */
stjm003       varchar2(10)      ,/* 費用編號 */
stjm004       date      ,/* 岀帳日期 */
stjm005       date      ,/* 起始日期 */
stjm006       date      ,/* 截止日期 */
stjm007       number(20,6)      ,/* 標準費用 */
stjm008       number(20,6)      ,/* 優惠費用 */
stjm009       number(20,6)      ,/* 抹零金額 */
stjm010       number(20,6)      ,/* 終止費用 */
stjm011       number(20,6)      ,/* 實際應收 */
stjm012       number(20,6)      ,/* 已收金額 */
stjm013       number(20,6)      ,/* 未收金額 */
stjm014       number(20,6)      ,/* 清算金額 */
stjm015       varchar2(1)      ,/* 結案否 */
stjm016       varchar2(20)      ,/* 費用單號 */
stjm017       varchar2(10)      ,/* 合約版本 */
stjm018       varchar2(10)      ,/* 費用歸屬類型 */
stjm019       varchar2(10)      /* 費用歸屬組織 */
);
alter table stjm_t add constraint stjm_pk primary key (stjment,stjmseq,stjm001) enable validate;

create unique index stjm_pk on stjm_t (stjment,stjmseq,stjm001);

grant select on stjm_t to tiptop;
grant update on stjm_t to tiptop;
grant delete on stjm_t to tiptop;
grant insert on stjm_t to tiptop;

exit;
