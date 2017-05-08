/* 
================================================================================
檔案代號:rtdk_t
檔案名稱:供應商清場清退商品明細表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table rtdk_t
(
rtdkent       number(5)      ,/* 企業編號 */
rtdksite       varchar2(10)      ,/* 營運據點 */
rtdkunit       varchar2(10)      ,/* 應用組織 */
rtdkdocno       varchar2(20)      ,/* 單據編號 */
rtdkseq       number(10,0)      ,/* 項次 */
rtdk001       varchar2(40)      ,/* 商品編碼 */
rtdk002       varchar2(40)      ,/* 商品條碼 */
rtdk003       varchar2(256)      ,/* 商品特征 */
rtdk004       varchar2(10)      ,/* 成本單位 */
rtdk005       number(20,6)      ,/* 成本單價 */
rtdk006       number(20,6)      ,/* 庫存數量 */
rtdk007       number(20,6)      /* 庫存金額 */
);
alter table rtdk_t add constraint rtdk_pk primary key (rtdkent,rtdkdocno,rtdkseq) enable validate;

create unique index rtdk_pk on rtdk_t (rtdkent,rtdkdocno,rtdkseq);

grant select on rtdk_t to tiptop;
grant update on rtdk_t to tiptop;
grant delete on rtdk_t to tiptop;
grant insert on rtdk_t to tiptop;

exit;
