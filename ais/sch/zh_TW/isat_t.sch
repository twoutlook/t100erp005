/* 
================================================================================
檔案代號:isat_t
檔案名稱:發票歷程檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table isat_t
(
isatent       number(5)      ,/* 企業編碼 */
isatcomp       varchar2(10)      ,/* 法人 */
isatdocno       varchar2(20)      ,/* 開票單號 */
isatseq       number(10,0)      ,/* 發票歷程項次 */
isat001       varchar2(2)      ,/* 發票類型 */
isat002       varchar2(1)      ,/* 電子發票否 */
isat003       varchar2(20)      ,/* 發票代碼 */
isat004       varchar2(20)      ,/* 發票號碼 */
isat005       varchar2(10)      ,/* 發票聯別 */
isat006       varchar2(10)      ,/* 發票防偽隨機碼 */
isat007       date      ,/* 發票日期 */
isat008       timestamp(5)      ,/* 發票時間 */
isat009       varchar2(255)      ,/* 發票客戶全名 */
isat010       varchar2(20)      ,/* 購貨方稅務編號 */
isat011       varchar2(4000)      ,/* 購貨方地址 */
isat012       varchar2(20)      ,/* 銷方稅務編號 */
isat013       varchar2(20)      ,/* POS單號 */
isat014       varchar2(10)      ,/* 發票異動狀態 */
isat015       varchar2(10)      ,/* 異動理由碼 */
isat016       varchar2(255)      ,/* 異動備註 */
isat017       date      ,/* 異動日期 */
isat018       varchar2(8)      ,/* 異動時間 */
isat019       varchar2(20)      ,/* 異動人員 */
isat020       varchar2(80)      ,/* 專案作廢核准文號 */
isat021       number(5,0)      ,/* 列印次數 */
isat022       varchar2(1)      ,/* 課稅別 */
isat023       number(20,6)      ,/* 稅率 */
isat024       varchar2(10)      ,/* 檢查碼 */
isat100       varchar2(10)      ,/* 幣別 */
isat101       number(20,10)      ,/* 匯率 */
isat103       number(20,6)      ,/* 發票原幣未稅金額 */
isat104       number(20,6)      ,/* 發票原幣稅額 */
isat105       number(20,6)      ,/* 發票原幣含稅金額 */
isat106       number(20,6)      ,/* 已折讓本幣未稅金額 */
isat107       number(20,6)      ,/* 已折讓本幣稅額 */
isat113       number(20,6)      ,/* 發票本幣未稅金額 */
isat114       number(20,6)      ,/* 發票本幣稅額 */
isat115       number(20,6)      ,/* 發票本幣含稅金額 */
isat201       number(20,6)      ,/* 帳款應稅金額 */
isat202       number(20,6)      ,/* 帳款零稅金額 */
isat203       number(20,6)      ,/* 帳款免稅金額 */
isat204       varchar2(10)      ,/* 愛心碼 */
isat205       varchar2(10)      ,/* 載具類別號碼 */
isat206       varchar2(80)      ,/* 載具顯碼 ID */
isat207       varchar2(80)      ,/* 載具隱碼 ID */
isat208       varchar2(1)      ,/* 電子發票匯出狀態 */
isat209       varchar2(255)      ,/* 電子發票匯出序號 */
isatud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
isatud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
isatud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
isatud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
isatud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
isatud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
isatud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
isatud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
isatud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
isatud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
isatud011       number(20,6)      ,/* 自定義欄位(數字)011 */
isatud012       number(20,6)      ,/* 自定義欄位(數字)012 */
isatud013       number(20,6)      ,/* 自定義欄位(數字)013 */
isatud014       number(20,6)      ,/* 自定義欄位(數字)014 */
isatud015       number(20,6)      ,/* 自定義欄位(數字)015 */
isatud016       number(20,6)      ,/* 自定義欄位(數字)016 */
isatud017       number(20,6)      ,/* 自定義欄位(數字)017 */
isatud018       number(20,6)      ,/* 自定義欄位(數字)018 */
isatud019       number(20,6)      ,/* 自定義欄位(數字)019 */
isatud020       number(20,6)      ,/* 自定義欄位(數字)020 */
isatud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
isatud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
isatud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
isatud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
isatud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
isatud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
isatud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
isatud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
isatud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
isatud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
isatsite       varchar2(10)      ,/* 營運據點 */
isatdocdt       date      ,/* 單據日期 */
isat025       varchar2(10)      ,/* 發票最終狀態 */
isat026       varchar2(1)      ,/* 電子發票類型 */
isat027       date      ,/* 原發票日期 */
isat028       varchar2(10)      ,/* 稅別 */
isat029       varchar2(1)      ,/* 含稅否 */
isat108       number(20,6)      ,/* 留抵原幣稅額 */
isat118       number(20,6)      /* 留抵本幣稅額 */
);
alter table isat_t add constraint isat_pk primary key (isatent,isatcomp,isatseq,isat003,isat004) enable validate;

create  index isat_n1 on isat_t (isatent,isatcomp,isat003,isat004,isat014);
create unique index isat_pk on isat_t (isatent,isatcomp,isatseq,isat003,isat004);

grant select on isat_t to tiptop;
grant update on isat_t to tiptop;
grant delete on isat_t to tiptop;
grant insert on isat_t to tiptop;

exit;
