/* 
================================================================================
檔案代號:fmbc_t
檔案名稱:融資費用攤銷檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table fmbc_t
(
fmbcent       number(5)      ,/* 企業編號 */
fmbc001       varchar2(10)      ,/* 融資組織 */
fmbc002       varchar2(10)      ,/* 融資合同編號 */
fmbc003       number(10,0)      ,/* 融資合同項次 */
fmbc004       varchar2(10)      ,/* 到帳單號 */
fmbc005       number(5,0)      ,/* 年度 */
fmbc006       number(5,0)      ,/* 期別 */
fmbc007       varchar2(1)      ,/* 費用類型 */
fmbc008       varchar2(10)      ,/* 幣別 */
fmbc009       number(20,6)      ,/* 費用總額 */
fmbc010       number(20,6)      ,/* 本期攤銷金額 */
fmbc011       varchar2(10)      /* 費用項次 */
);
alter table fmbc_t add constraint fmbc_pk primary key (fmbcent,fmbc002,fmbc003,fmbc005,fmbc006,fmbc011) enable validate;

create unique index fmbc_pk on fmbc_t (fmbcent,fmbc002,fmbc003,fmbc005,fmbc006,fmbc011);

grant select on fmbc_t to tiptop;
grant update on fmbc_t to tiptop;
grant delete on fmbc_t to tiptop;
grant insert on fmbc_t to tiptop;

exit;
