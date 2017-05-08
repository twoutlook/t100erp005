/* 
================================================================================
檔案代號:debv_t
檔案名稱:營運組織銷售月結檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table debv_t
(
debvent       number(5)      ,/* 企業編號 */
debvsite       varchar2(10)      ,/* 營運據點 */
debv001       varchar2(10)      ,/* 層級類型 */
debv002       number(5,0)      ,/* 統計年度 */
debv003       number(5,0)      ,/* 統計月份 */
debv012       number(20,6)      ,/* 銷售數量 */
debv013       number(20,6)      ,/* 銷售成本 */
debv014       number(20,6)      ,/* 進價金額 */
debv015       number(20,6)      ,/* 原價金額 */
debv016       number(20,6)      ,/* 未稅金額 */
debv017       number(20,6)      ,/* 應收金額 */
debv018       number(20,6)      ,/* 毛利 */
debv019       number(20,6)      ,/* 毛利率 */
debv020       number(20,6)      ,/* 客單數 */
debv025       number(20,6)      ,/* 退貨金額 */
debv026       number(20,6)      ,/* 退貨單據數 */
debv027       number(20,6)      ,/* 打折金額 */
debv028       number(20,6)      ,/* 變價金額 */
debv029       number(20,6)      ,/* 折扣金額 */
debv030       number(20,6)      ,/* 收銀差額 */
debv031       number(20,6)      ,/* 實收金額 */
debv032       number(20,6)      ,/* 抵扣券金額 */
debv033       number(20,6)      ,/* 會員折扣金額 */
debv034       number(20,6)      /* 客單價 */
);
alter table debv_t add constraint debv_pk primary key (debvent,debvsite,debv002,debv003) enable validate;

create unique index debv_pk on debv_t (debvent,debvsite,debv002,debv003);

grant select on debv_t to tiptop;
grant update on debv_t to tiptop;
grant delete on debv_t to tiptop;
grant insert on debv_t to tiptop;

exit;
