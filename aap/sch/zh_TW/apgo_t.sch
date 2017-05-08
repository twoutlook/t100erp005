/* 
================================================================================
檔案代號:apgo_t
檔案名稱:到貨發票明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table apgo_t
(
apgoent       number(5)      ,/* 企業代碼 */
apgocomp       varchar2(10)      ,/* 法人 */
apgodocno       varchar2(20)      ,/* 單號 */
apgoseq       number(10,0)      ,/* 項次 */
apgo001       varchar2(10)      ,/* 開發票人 */
apgo002       varchar2(2)      ,/* 發票類型 */
apgo003       varchar2(1)      ,/* 電子發票否 */
apgo004       varchar2(20)      ,/* 發票代碼 */
apgo005       varchar2(20)      ,/* 發票號碼 */
apgo006       date      ,/* 發票日期 */
apgo007       varchar2(10)      ,/* 稅別 */
apgo008       varchar2(1)      ,/* 含稅否 */
apgo009       number(5,2)      ,/* 稅率 */
apgo010       varchar2(255)      ,/* 銷貨方名稱 */
apgo011       varchar2(20)      ,/* 開票人統編 */
apgo012       varchar2(1)      ,/* 可扣抵代碼 */
apgo100       varchar2(10)      ,/* 幣別 */
apgo101       number(20,10)      ,/* 匯率 */
apgo103       number(20,6)      ,/* 發票原幣未稅金額 */
apgo104       number(20,6)      ,/* 發票原幣稅額 */
apgo105       number(20,6)      ,/* 發票原幣含稅金額 */
apgo113       number(20,6)      ,/* 發票本幣未稅金額 */
apgo114       number(20,6)      ,/* 發票本幣稅額 */
apgo115       number(20,6)      ,/* 發票本幣含稅金額 */
apgoud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
apgoud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
apgoud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
apgoud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
apgoud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
apgoud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
apgoud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
apgoud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
apgoud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
apgoud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
apgoud011       number(20,6)      ,/* 自定義欄位(數字)011 */
apgoud012       number(20,6)      ,/* 自定義欄位(數字)012 */
apgoud013       number(20,6)      ,/* 自定義欄位(數字)013 */
apgoud014       number(20,6)      ,/* 自定義欄位(數字)014 */
apgoud015       number(20,6)      ,/* 自定義欄位(數字)015 */
apgoud016       number(20,6)      ,/* 自定義欄位(數字)016 */
apgoud017       number(20,6)      ,/* 自定義欄位(數字)017 */
apgoud018       number(20,6)      ,/* 自定義欄位(數字)018 */
apgoud019       number(20,6)      ,/* 自定義欄位(數字)019 */
apgoud020       number(20,6)      ,/* 自定義欄位(數字)020 */
apgoud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
apgoud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
apgoud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
apgoud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
apgoud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
apgoud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
apgoud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
apgoud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
apgoud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
apgoud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table apgo_t add constraint apgo_pk primary key (apgoent,apgocomp,apgodocno,apgoseq) enable validate;

create unique index apgo_pk on apgo_t (apgoent,apgocomp,apgodocno,apgoseq);

grant select on apgo_t to tiptop;
grant update on apgo_t to tiptop;
grant delete on apgo_t to tiptop;
grant insert on apgo_t to tiptop;

exit;
