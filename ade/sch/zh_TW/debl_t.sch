/* 
================================================================================
檔案代號:debl_t
檔案名稱:門店部門會員消費統計日結檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:Y
============.========================.==========================================
 */
create table debl_t
(
deblent       number(5)      ,/* 企業編號 */
deblsite       varchar2(10)      ,/* 營運據點 */
debl001       varchar2(10)      ,/* 層級類型 */
debl002       date      ,/* 統計日期 */
debl003       number(5,0)      ,/* 會計週 */
debl004       number(5,0)      ,/* 會計期 */
debl005       varchar2(10)      ,/* 部門編號 */
debl006       varchar2(10)      ,/* 會員卡種 */
debl007       varchar2(10)      ,/* 會員等級 */
debl008       number(20,6)      ,/* 銷售數量 */
debl009       number(20,6)      ,/* 銷售成本 */
debl010       number(20,6)      ,/* 進價金額 */
debl011       number(20,6)      ,/* 原價金額 */
debl012       number(20,6)      ,/* 未稅金額 */
debl013       number(20,6)      ,/* 應收金額 */
debl014       number(20,6)      ,/* 毛利 */
debl015       number(20,6)      ,/* 毛利率 */
debl016       number(22,2)      ,/* 會員積分 */
debl017       number(20,6)      ,/* 客單數 */
debl018       number(20,6)      ,/* 抵扣券金額 */
debl019       number(20,6)      ,/* 會員折扣金額 */
debl020       number(20,6)      /* 實收金額 */
);
alter table debl_t add constraint debl_pk primary key (deblent,deblsite,debl002,debl005,debl006,debl007) enable validate;

create unique index debl_pk on debl_t (deblent,deblsite,debl002,debl005,debl006,debl007);

grant select on debl_t to tiptop;
grant update on debl_t to tiptop;
grant delete on debl_t to tiptop;
grant insert on debl_t to tiptop;

exit;
