/* 
================================================================================
檔案代號:debp_t
檔案名稱:門店會員消費統計日結檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:Y
============.========================.==========================================
 */
create table debp_t
(
debpent       number(5)      ,/* 企業編號 */
debpsite       varchar2(10)      ,/* 營運據點 */
debp001       varchar2(10)      ,/* 層級類型 */
debp002       date      ,/* 統計日期 */
debp003       number(5,0)      ,/* 會計週 */
debp004       number(5,0)      ,/* 會計期 */
debp005       varchar2(10)      ,/* 會員卡種 */
debp006       varchar2(10)      ,/* 會員等級 */
debp007       number(20,6)      ,/* 銷售數量 */
debp008       number(20,6)      ,/* 銷售成本 */
debp009       number(20,6)      ,/* 進價金額 */
debp010       number(20,6)      ,/* 原價金額 */
debp011       number(20,6)      ,/* 未稅金額 */
debp012       number(20,6)      ,/* 應收金額 */
debp013       number(20,6)      ,/* 毛利 */
debp014       number(20,6)      ,/* 毛利率 */
debp015       number(22,2)      ,/* 會員積分 */
debp016       number(20,6)      ,/* 客單數 */
debp017       number(20,6)      ,/* 抵扣券金額 */
debp018       number(20,6)      ,/* 會員折扣金額 */
debp019       number(20,6)      ,/* 實收金額 */
debp020       number(20,6)      /* 客單價 */
);
alter table debp_t add constraint debp_pk primary key (debpent,debpsite,debp002,debp005,debp006) enable validate;

create unique index debp_pk on debp_t (debpent,debpsite,debp002,debp005,debp006);

grant select on debp_t to tiptop;
grant update on debp_t to tiptop;
grant delete on debp_t to tiptop;
grant insert on debp_t to tiptop;

exit;
