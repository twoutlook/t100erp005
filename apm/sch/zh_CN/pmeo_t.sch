/* 
================================================================================
檔案代號:pmeo_t
檔案名稱:採購合約/核價結算來源單據明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pmeo_t
(
pmeoent       number(5)      ,/* 企業編號 */
pmeosite       varchar2(10)      ,/* 營運據點 */
pmeo000       varchar2(1)      ,/* 資料類型 */
pmeo001       varchar2(20)      ,/* 合約/核價單號 */
pmeo002       number(10,0)      ,/* 項次 */
pmeo003       varchar2(20)      ,/* 關聯單號 */
pmeo004       number(10,0)      ,/* 關聯項次 */
pmeo005       timestamp(0)      ,/* 結算日期 */
pmeo006       varchar2(40)      ,/* 料件編號 */
pmeo007       varchar2(256)      ,/* 產品特徵 */
pmeo008       number(20,6)      ,/* 交易數量 */
pmeo009       varchar2(10)      ,/* 交易單位 */
pmeo010       number(20,6)      ,/* 原始單價 */
pmeo011       number(20,6)      ,/* 原始未稅金額 */
pmeo012       number(20,6)      ,/* 原始含稅金額 */
pmeo013       number(20,6)      ,/* 原始稅額 */
pmeo014       number(20,6)      ,/* 建議調整後未稅金額 */
pmeo015       number(20,6)      ,/* 建議調整後含稅金額 */
pmeo016       number(20,6)      ,/* 建議調整後稅額 */
pmeo017       number(20,6)      ,/* 差異未稅金額 */
pmeo018       number(20,6)      ,/* 差異含稅金額 */
pmeo019       number(20,6)      ,/* 差異稅額 */
pmeo020       number(20,6)      ,/* 差異數量單價 */
pmeo021       number(20,6)      ,/* 差異數量 */
pmeo022       varchar2(20)      ,/* 來源單號 */
pmeo023       number(10,0)      ,/* 來源項次 */
pmeo024       varchar2(10)      ,/* 來源據點 */
pmeo025       varchar2(1)      ,/* 差異處理否 */
pmeo026       varchar2(10)      ,/* 差異處理方式 */
pmeo027       varchar2(20)      ,/* 差異處理單號 */
pmeo028       number(10,0)      ,/* 差異處理項次 */
pmeo029       number(20,6)      /* 建議調整單價 */
);
alter table pmeo_t add constraint pmeo_pk primary key (pmeoent,pmeo000,pmeo001,pmeo002,pmeo003,pmeo004,pmeo005) enable validate;

create unique index pmeo_pk on pmeo_t (pmeoent,pmeo000,pmeo001,pmeo002,pmeo003,pmeo004,pmeo005);

grant select on pmeo_t to tiptop;
grant update on pmeo_t to tiptop;
grant delete on pmeo_t to tiptop;
grant insert on pmeo_t to tiptop;

exit;
