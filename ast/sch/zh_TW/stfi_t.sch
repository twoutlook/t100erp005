/* 
================================================================================
檔案代號:stfi_t
檔案名稱:專櫃合同优惠条件资料档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stfi_t
(
stfient       number(5)      ,/* 企業編號 */
stfiunit       varchar2(10)      ,/* 應用組織 */
stfiacti       varchar2(1)      ,/* 資料有效 */
stfisite       varchar2(10)      ,/* 營運據點 */
stfiseq       number(10,0)      ,/* 項次 */
stfi001       varchar2(20)      ,/* 合同編號 */
stfi002       varchar2(10)      ,/* 優惠類型 */
stfi003       varchar2(10)      ,/* 費用編碼 */
stfi004       number(20,6)      ,/* 優惠金額 */
stfi005       date      ,/* 優惠開始日期 */
stfi006       date      ,/* 優惠截止日期 */
stfi007       varchar2(20)      ,/* 優惠單號 */
stfi008       number(10,0)      ,/* 優惠項次 */
stfi009       varchar2(255)      ,/* 備註 */
stfi010       varchar2(10)      ,/* 優惠原因 */
stfi011       varchar2(20)      ,/* 費用編號 */
stfi012       number(10,0)      /* 費用項次 */
);
alter table stfi_t add constraint stfi_pk primary key (stfient,stfiseq,stfi001) enable validate;

create unique index stfi_pk on stfi_t (stfient,stfiseq,stfi001);

grant select on stfi_t to tiptop;
grant update on stfi_t to tiptop;
grant delete on stfi_t to tiptop;
grant insert on stfi_t to tiptop;

exit;
