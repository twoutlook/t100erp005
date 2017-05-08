/* 
================================================================================
檔案代號:prbw_t
檔案名稱:門店商品預調價清單檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table prbw_t
(
prbwent       number(5)      ,/* 企業代碼 */
prbwunit       varchar2(10)      ,/* 應用執行組織物件 */
prbwsite       varchar2(10)      ,/* 營運據點 */
prbwdocno       varchar2(20)      ,/* 單號 */
prbwseq       number(10,0)      ,/* 項次 */
prbw001       varchar2(40)      ,/* 商品編號 */
prbw002       varchar2(40)      ,/* 商品條碼 */
prbw003       varchar2(256)      ,/* 商品特徵 */
prbw004       varchar2(10)      ,/* PLU碼 */
prbw005       varchar2(10)      ,/* 採購計價單位 */
prbw006       number(20,6)      ,/* 整包件數 */
prbw007       number(5,0)      ,/* 價格因子 */
prbw008       varchar2(10)      ,/* 進項稅別 */
prbw009       number(20,6)      ,/* 進價 */
prbw010       varchar2(10)      ,/* 銷項稅別 */
prbw011       number(20,6)      ,/* 售價 */
prbw012       number(20,6)      ,/* 會員價1 */
prbw013       number(20,6)      ,/* 會員價2 */
prbw014       number(20,6)      ,/* 會員價3 */
prbw015       date      ,/* 進價開始日期 */
prbw016       date      ,/* 進價結束日期 */
prbw017       varchar2(8)      ,/* 開始時間 */
prbw018       varchar2(8)      ,/* 結束時間 */
prbw019       varchar2(10)      ,/* 銷售計價單位 */
prbw020       date      ,/* 售價開始日期 */
prbw021       date      /* 售價結束日期 */
);
alter table prbw_t add constraint prbw_pk primary key (prbwent,prbwdocno,prbwseq) enable validate;

create unique index prbw_pk on prbw_t (prbwent,prbwdocno,prbwseq);

grant select on prbw_t to tiptop;
grant update on prbw_t to tiptop;
grant delete on prbw_t to tiptop;
grant insert on prbw_t to tiptop;

exit;
