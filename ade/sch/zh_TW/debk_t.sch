/* 
================================================================================
檔案代號:debk_t
檔案名稱:門店部門日結檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:Y
============.========================.==========================================
 */
create table debk_t
(
debkent       number(5)      ,/* 企業編號 */
debksite       varchar2(10)      ,/* 營運據點 */
debk001       varchar2(10)      ,/* 層級類型 */
debk002       date      ,/* 統計日期 */
debk003       number(5,0)      ,/* 會計週 */
debk004       number(5,0)      ,/* 會計期 */
debk005       varchar2(10)      ,/* 部門編號 */
debk006       number(20,6)      ,/* 銷售數量 */
debk007       number(20,6)      ,/* 銷售成本 */
debk008       number(20,6)      ,/* 進價金額 */
debk009       number(20,6)      ,/* 原價金額 */
debk010       number(20,6)      ,/* 未稅金額 */
debk011       number(20,6)      ,/* 應收金額 */
debk012       number(20,6)      ,/* 折扣金額 */
debk013       number(20,6)      ,/* 收銀差額 */
debk014       number(20,6)      ,/* 實收金額 */
debk015       number(20,6)      ,/* 毛利 */
debk016       number(20,6)      ,/* 毛利率 */
debk017       number(20,6)      ,/* 客單數 */
debk018       number(20,6)      ,/* 退貨金額 */
debk019       number(20,6)      ,/* 退貨單據數 */
debk020       number(20,6)      ,/* 打折金額 */
debk021       number(20,6)      ,/* 變價金額 */
debk022       number(20,6)      ,/* 抵扣券金額 */
debk023       number(20,6)      /* 會員折扣金額 */
);
alter table debk_t add constraint debk_pk primary key (debkent,debksite,debk002,debk005) enable validate;

create unique index debk_pk on debk_t (debkent,debksite,debk002,debk005);

grant select on debk_t to tiptop;
grant update on debk_t to tiptop;
grant delete on debk_t to tiptop;
grant insert on debk_t to tiptop;

exit;
