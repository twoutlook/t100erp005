/* 
================================================================================
檔案代號:stfc_t
檔案名稱:專櫃合同庫區費用設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stfc_t
(
stfcent       number(5)      ,/* 企業編號 */
stfcunit       varchar2(10)      ,/* 應用組織 */
stfcsite       varchar2(10)      ,/* 營運據點 */
stfc001       varchar2(20)      ,/* 合同編號 */
stfcseq       number(10,0)      ,/* 項次 */
stfc002       varchar2(10)      ,/* 庫區編號 */
stfc003       varchar2(500)      ,/* 庫區名稱 */
stfc004       varchar2(10)      ,/* 經營小類 */
stfc005       varchar2(10)      ,/* 經營品牌 */
stfc006       varchar2(10)      ,/* 進項稅 */
stfc007       varchar2(10)      ,/* 銷項稅 */
stfc008       number(5,2)      ,/* 消費稅率 */
stfc009       varchar2(10)      ,/* 費用編號 */
stfc010       varchar2(10)      ,/* 會計期間 */
stfc011       varchar2(10)      ,/* 價款類別 */
stfc012       varchar2(10)      ,/* 計算類型 */
stfc013       varchar2(10)      ,/* 費用週期 */
stfc014       varchar2(10)      ,/* 費用週期方式 */
stfc015       varchar2(10)      ,/* 條件基準 */
stfc016       varchar2(10)      ,/* 計算基準 */
stfc017       number(20,6)      ,/* 費用淨額 */
stfc018       number(20,6)      ,/* 費用比率 */
stfc019       date      ,/* 生效日期 */
stfc020       date      ,/* 失效日期 */
stfc021       date      ,/* 下次計算日 */
stfc022       date      ,/* 下次費用開始日 */
stfc023       date      ,/* 下次費用截止日 */
stfc024       varchar2(10)      ,/* 庫區用途分類 */
stfc025       varchar2(10)      ,/* 對應常規庫區編號 */
stfc026       varchar2(1)      ,/* 納入結算單否 */
stfc027       varchar2(1)      ,/* 票扣否 */
stfcacti       varchar2(1)      /* 有效 */
);
alter table stfc_t add constraint stfc_pk primary key (stfcent,stfc001,stfcseq) enable validate;

create unique index stfc_pk on stfc_t (stfcent,stfc001,stfcseq);

grant select on stfc_t to tiptop;
grant update on stfc_t to tiptop;
grant delete on stfc_t to tiptop;
grant insert on stfc_t to tiptop;

exit;
