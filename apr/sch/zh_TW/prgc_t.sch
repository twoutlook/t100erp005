/* 
================================================================================
檔案代號:prgc_t
檔案名稱:補差明細表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table prgc_t
(
prgcent       number(5)      ,/* 企業代碼 */
prgcsite       varchar2(10)      ,/* 營運據點 */
prgcunit       varchar2(10)      ,/* 應用執行組織物件 */
prgcdocno       varchar2(20)      ,/* 單號 */
prgcseq       number(10,0)      ,/* 項次 */
prgcseq1       number(10,0)      ,/* 項次1 */
prgc001       varchar2(10)      ,/* 補差類型 */
prgc002       varchar2(40)      ,/* 商品編號 */
prgc003       varchar2(256)      ,/* 商品特徵 */
prgc004       varchar2(30)      ,/* 庫位管理特徵 */
prgc005       varchar2(10)      ,/* 庫區編號 */
prgc006       varchar2(10)      ,/* 儲位編號 */
prgc007       varchar2(30)      ,/* 批號 */
prgc008       varchar2(10)      ,/* 交易單位 */
prgc009       number(20,6)      ,/* 數量 */
prgc010       number(20,6)      ,/* 採購進價/日結成本價 */
prgc011       number(20,6)      ,/* 售價 */
prgc012       varchar2(20)      ,/* 來源單號 */
prgc013       number(10,0)      ,/* 來源項次 */
prgc014       date      /* 來源日期 */
);
alter table prgc_t add constraint prgc_pk primary key (prgcent,prgcdocno,prgcseq,prgcseq1) enable validate;

create unique index prgc_pk on prgc_t (prgcent,prgcdocno,prgcseq,prgcseq1);

grant select on prgc_t to tiptop;
grant update on prgc_t to tiptop;
grant delete on prgc_t to tiptop;
grant insert on prgc_t to tiptop;

exit;
