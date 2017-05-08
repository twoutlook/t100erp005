/* 
================================================================================
檔案代號:fmcz_t
檔案名稱:計提利息單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table fmcz_t
(
fmczent       number(5)      ,/* 企業編號 */
fmczdocno       varchar2(20)      ,/* 計息單號 */
fmczseq       number(10,0)      ,/* 項次 */
fmcz001       varchar2(10)      ,/* 融資組織 */
fmcz002       varchar2(20)      ,/* 融資合同 */
fmcz003       number(10,0)      ,/* 合同項次 */
fmcz004       varchar2(1)      ,/* 類別 */
fmcz005       varchar2(10)      ,/* 幣別 */
fmcz006       number(20,6)      ,/* 本金 */
fmcz007       number(20,6)      ,/* 未還利息 */
fmcz008       number(10,6)      ,/* 利率 */
fmcz009       number(20,6)      ,/* 利息金額/費用金額 */
fmcz010       number(20,10)      ,/* 匯率 */
fmcz011       number(20,6)      ,/* 本幣 */
fmcz012       number(20,10)      ,/* 匯率二 */
fmcz013       number(20,6)      ,/* 本幣二 */
fmcz014       number(20,10)      ,/* 匯率三 */
fmcz015       number(20,6)      ,/* 本幣三 */
fmcz016       varchar2(20)      ,/* 到帳單號 */
fmcz017       number(10,0)      ,/* 到帳單項次 */
fmcz018       number(10,0)      ,/* 費用單項序 */
fmcz019       number(20,6)      ,/* 已支付利息 */
fmcz020       number(20,6)      ,/* 已支付利息一 */
fmcz021       number(20,6)      ,/* 已支付利息二 */
fmcz022       number(20,6)      ,/* 已支付利息三 */
fmczud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
fmczud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
fmczud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
fmczud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
fmczud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
fmczud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
fmczud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
fmczud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
fmczud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
fmczud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
fmczud011       number(20,6)      ,/* 自定義欄位(數字)011 */
fmczud012       number(20,6)      ,/* 自定義欄位(數字)012 */
fmczud013       number(20,6)      ,/* 自定義欄位(數字)013 */
fmczud014       number(20,6)      ,/* 自定義欄位(數字)014 */
fmczud015       number(20,6)      ,/* 自定義欄位(數字)015 */
fmczud016       number(20,6)      ,/* 自定義欄位(數字)016 */
fmczud017       number(20,6)      ,/* 自定義欄位(數字)017 */
fmczud018       number(20,6)      ,/* 自定義欄位(數字)018 */
fmczud019       number(20,6)      ,/* 自定義欄位(數字)019 */
fmczud020       number(20,6)      ,/* 自定義欄位(數字)020 */
fmczud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
fmczud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
fmczud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
fmczud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
fmczud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
fmczud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
fmczud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
fmczud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
fmczud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
fmczud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
fmcz023       varchar2(255)      /* 摘要 */
);
alter table fmcz_t add constraint fmcz_pk primary key (fmczent,fmczdocno,fmczseq) enable validate;

create unique index fmcz_pk on fmcz_t (fmczent,fmczdocno,fmczseq);

grant select on fmcz_t to tiptop;
grant update on fmcz_t to tiptop;
grant delete on fmcz_t to tiptop;
grant insert on fmcz_t to tiptop;

exit;
