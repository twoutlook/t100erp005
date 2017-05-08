/* 
================================================================================
檔案代號:prgb_t
檔案名稱:補差調整明細表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table prgb_t
(
prgbent       number(5)      ,/* 企業編號 */
prgbunit       varchar2(10)      ,/* 應用組織 */
prgbsite       varchar2(10)      ,/* 營運據點 */
prgbdocno       varchar2(20)      ,/* 單據編號 */
prgbseq       number(10,0)      ,/* 項次 */
prgb001       varchar2(10)      ,/* 補差類型 */
prgb002       varchar2(10)      ,/* 來源類型 */
prgb003       varchar2(20)      ,/* 來源單號 */
prgb004       number(10,0)      ,/* 來源項次 */
prgb005       varchar2(10)      ,/* 對象類型 */
prgb006       varchar2(10)      ,/* 供應商/經銷商 */
prgb007       varchar2(10)      ,/* 網點編號 */
prgb008       varchar2(40)      ,/* 商品編號 */
prgb009       varchar2(40)      ,/* 商品條碼 */
prgb010       varchar2(256)      ,/* 商品特征 */
prgb011       varchar2(10)      ,/* 幣別 */
prgb012       varchar2(10)      ,/* 稅別 */
prgb013       varchar2(10)      ,/* 單位編號 */
prgb014       number(20,6)      ,/* 數量 */
prgb015       number(20,6)      ,/* 原價格 */
prgb016       number(20,6)      ,/* 本次價格 */
prgb017       number(20,6)      ,/* 本次補差 */
prgb018       number(20,6)      ,/* 補差金額 */
prgb019       date      ,/* 起始日期 */
prgb020       date      ,/* 截止日期 */
prgb021       number(10,0)      ,/* 結算會計期 */
prgb022       varchar2(20)      ,/* 合同編號 */
prgb023       varchar2(10)      ,/* 經營方式 */
prgb024       varchar2(10)      ,/* 結算方式 */
prgb025       varchar2(10)      ,/* 結算類型 */
prgb026       varchar2(10)      ,/* 結算中心 */
prgb027       varchar2(30)      ,/* 促銷方案 */
prgb028       varchar2(10)      ,/* 銷售範圍 */
prgb029       varchar2(10)      ,/* 銷售組織 */
prgb030       varchar2(10)      ,/* 銷售渠道 */
prgb031       varchar2(10)      ,/* 產品組 */
prgb032       varchar2(10)      ,/* 辦事處 */
prgb033       varchar2(80)      ,/* 備註 */
prgb034       number(20,6)      ,/* 毛利率 */
prgb035       number(20,6)      /* 承擔比例% */
);
alter table prgb_t add constraint prgb_pk primary key (prgbent,prgbdocno,prgbseq) enable validate;

create unique index prgb_pk on prgb_t (prgbent,prgbdocno,prgbseq);

grant select on prgb_t to tiptop;
grant update on prgb_t to tiptop;
grant delete on prgb_t to tiptop;
grant insert on prgb_t to tiptop;

exit;
