/* 
================================================================================
檔案代號:decn_t
檔案名稱:門店部門週結檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table decn_t
(
decnent       number(5)      ,/* 企業編號 */
decnsite       varchar2(10)      ,/* 營運據點 */
decn001       varchar2(10)      ,/* 層級類型 */
decn005       varchar2(10)      ,/* 部門編號 */
decn006       number(20,6)      ,/* 銷售數量 */
decn007       number(20,6)      ,/* 銷售成本 */
decn008       number(20,6)      ,/* 進價金額 */
decn009       number(20,6)      ,/* 原價金額 */
decn010       number(20,6)      ,/* 未稅金額 */
decn011       number(20,6)      ,/* 應收金額 */
decn012       number(20,6)      ,/* 折扣金額 */
decn013       number(20,6)      ,/* 收銀差額 */
decn014       number(20,6)      ,/* 實收金額 */
decn015       number(20,6)      ,/* 毛利 */
decn016       number(20,6)      ,/* 毛利率 */
decn017       number(20,6)      ,/* 客單數 */
decn018       number(20,6)      ,/* 退貨金額 */
decn019       number(20,6)      ,/* 退貨單據數 */
decn020       number(20,6)      ,/* 打折金額 */
decn021       number(20,6)      ,/* 變價金額 */
decn022       number(20,6)      ,/* 抵扣券金額 */
decn023       number(20,6)      ,/* 會員折扣金額 */
decn024       number(10,0)      ,/* 統計年度月份 */
decn025       number(5,0)      /* 統計週期 */
);
alter table decn_t add constraint decn_pk primary key (decnent,decnsite,decn005,decn024,decn025) enable validate;

create unique index decn_pk on decn_t (decnent,decnsite,decn005,decn024,decn025);

grant select on decn_t to tiptop;
grant update on decn_t to tiptop;
grant delete on decn_t to tiptop;
grant insert on decn_t to tiptop;

exit;
