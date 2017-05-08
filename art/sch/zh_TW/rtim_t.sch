/* 
================================================================================
檔案代號:rtim_t
檔案名稱:零售訂單商品明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table rtim_t
(
rtiment       number(5)      ,/* 企業編號 */
rtimsite       varchar2(10)      ,/* 營運據點 */
rtimunit       varchar2(10)      ,/* 應用組織 */
rtimdocno       varchar2(20)      ,/* 單據編號 */
rtimorga       varchar2(10)      ,/* 賬務組織 */
rtimseq       number(10,0)      ,/* 項次 */
rtim003       varchar2(40)      ,/* 商品條碼 */
rtim004       varchar2(40)      ,/* 商品編號 */
rtim005       varchar2(256)      ,/* 特徵碼 */
rtim006       varchar2(10)      ,/* 稅別編號 */
rtim007       varchar2(1)      ,/* 銷售開立發票 */
rtim008       number(20,6)      ,/* 標準售價 */
rtim009       number(20,6)      ,/* 促銷售價 */
rtim010       number(20,6)      ,/* 交易售價 */
rtim011       number(20,6)      ,/* 成本售價 */
rtim012       number(20,6)      ,/* 銷售數量 */
rtim013       varchar2(10)      ,/* 銷售單位 */
rtim014       number(20,6)      ,/* 庫存數量 */
rtim015       varchar2(10)      ,/* 庫存單位 */
rtim016       number(20,6)      ,/* 銷售庫存單位換算率 */
rtim017       number(20,6)      ,/* 計價數量 */
rtim018       varchar2(10)      ,/* 計價單位 */
rtim019       number(20,6)      ,/* 銷售計價單位換算率 */
rtim020       number(20,6)      ,/* 折價金額 */
rtim021       number(20,6)      ,/* 應收金額 */
rtim022       number(20,6)      ,/* 未稅金額 */
rtim023       number(20,6)      ,/* 成本金額 */
rtim024       varchar2(10)      ,/* 理由碼 */
rtim025       varchar2(10)      ,/* 庫區 */
rtim026       varchar2(10)      ,/* 儲位 */
rtim027       varchar2(30)      ,/* 批號 */
rtim028       varchar2(20)      ,/* 專櫃編號 */
rtimud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rtimud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rtimud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rtimud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rtimud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rtimud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rtimud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rtimud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rtimud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rtimud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rtimud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rtimud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rtimud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rtimud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rtimud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rtimud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rtimud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rtimud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rtimud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rtimud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rtimud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rtimud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rtimud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rtimud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rtimud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rtimud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rtimud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rtimud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rtimud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rtimud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
rtim029       number(20,6)      /* 本幣應收金額 */
);
alter table rtim_t add constraint rtim_pk primary key (rtiment,rtimdocno,rtimseq) enable validate;

create unique index rtim_pk on rtim_t (rtiment,rtimdocno,rtimseq);

grant select on rtim_t to tiptop;
grant update on rtim_t to tiptop;
grant delete on rtim_t to tiptop;
grant insert on rtim_t to tiptop;

exit;
