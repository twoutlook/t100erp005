/* 
================================================================================
檔案代號:rtik_t
檔案名稱:銷售交易特殊條碼明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table rtik_t
(
rtikent       number(5)      ,/* 企業編號 */
rtiksite       varchar2(10)      ,/* 營運據點 */
rtikunit       varchar2(10)      ,/* 應用組織 */
rtikorg       varchar2(10)      ,/* 帳務組織 */
rtikdocno       varchar2(20)      ,/* 單據編號 */
rtikseq       number(10,0)      ,/* 項次 */
rtik001       varchar2(20)      ,/* 來源單號 */
rtik002       number(10,0)      ,/* 來源單號項次 */
rtik003       varchar2(40)      ,/* 商品條碼 */
rtik004       varchar2(40)      ,/* 商品編號 */
rtik005       varchar2(256)      ,/* 特徵碼 */
rtik006       varchar2(10)      ,/* 稅別編號 */
rtik007       varchar2(1)      ,/* 銷售開立發票 */
rtik008       number(20,6)      ,/* 標準售價 */
rtik009       number(20,6)      ,/* 促銷售價 */
rtik010       number(20,6)      ,/* 交易售價 */
rtik011       number(20,6)      ,/* 成本售價 */
rtik012       number(20,6)      ,/* 銷售數量 */
rtik013       varchar2(10)      ,/* 銷售單位 */
rtik014       number(20,6)      ,/* 折價金額 */
rtik015       number(20,6)      ,/* 應收金額 */
rtik016       number(20,6)      ,/* 未稅金額 */
rtik017       number(20,6)      ,/* 成本金額 */
rtik018       varchar2(10)      ,/* 理由碼 */
rtik019       varchar2(10)      ,/* 庫區 */
rtik020       varchar2(10)      ,/* 儲位 */
rtik021       varchar2(30)      ,/* 批號 */
rtik022       varchar2(20)      ,/* 專櫃編號 */
rtik023       number(15,3)      /* 分攤積點 */
);
alter table rtik_t add constraint rtik_pk primary key (rtikent,rtikdocno,rtikseq) enable validate;

create unique index rtik_pk on rtik_t (rtikent,rtikdocno,rtikseq);

grant select on rtik_t to tiptop;
grant update on rtik_t to tiptop;
grant delete on rtik_t to tiptop;
grant insert on rtik_t to tiptop;

exit;
