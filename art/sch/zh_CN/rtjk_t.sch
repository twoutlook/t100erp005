/* 
================================================================================
檔案代號:rtjk_t
檔案名稱:銷售整合特殊條碼明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table rtjk_t
(
rtjkent       number(5)      ,/* 企業編號 */
rtjksite       varchar2(10)      ,/* 營運據點 */
rtjkunit       varchar2(10)      ,/* 應用組織 */
rtjkorg       varchar2(10)      ,/* 帳務組織 */
rtjkdocno       varchar2(20)      ,/* 單據編號 */
rtjkseq       number(10,0)      ,/* 項次 */
rtjk001       varchar2(20)      ,/* 來源單號 */
rtjk002       number(10,0)      ,/* 來源單號項次 */
rtjk003       varchar2(40)      ,/* 商品條碼 */
rtjk004       varchar2(40)      ,/* 商品編號 */
rtjk005       varchar2(256)      ,/* 特徵碼 */
rtjk006       varchar2(10)      ,/* 稅別編號 */
rtjk007       varchar2(1)      ,/* 銷售開立發票 */
rtjk008       number(20,6)      ,/* 標準售價 */
rtjk009       number(20,6)      ,/* 促銷售價 */
rtjk010       number(20,6)      ,/* 交易售價 */
rtjk011       number(20,6)      ,/* 成本售價 */
rtjk012       number(20,6)      ,/* 銷售數量 */
rtjk013       varchar2(10)      ,/* 銷售單位 */
rtjk014       number(20,6)      ,/* 折價金額 */
rtjk015       number(20,6)      ,/* 應收金額 */
rtjk016       number(20,6)      ,/* 未稅金額 */
rtjk017       number(20,6)      ,/* 成本金額 */
rtjk018       varchar2(10)      ,/* 理由碼 */
rtjk019       varchar2(10)      ,/* 庫區 */
rtjk020       varchar2(10)      ,/* 儲位 */
rtjk021       varchar2(30)      ,/* 批號 */
rtjk022       varchar2(20)      ,/* 專櫃編號 */
rtjk023       number(15,3)      /* 分攤積點 */
);
alter table rtjk_t add constraint rtjk_pk primary key (rtjkent,rtjkdocno,rtjkseq) enable validate;

create unique index rtjk_pk on rtjk_t (rtjkent,rtjkdocno,rtjkseq);

grant select on rtjk_t to tiptop;
grant update on rtjk_t to tiptop;
grant delete on rtjk_t to tiptop;
grant insert on rtjk_t to tiptop;

exit;
