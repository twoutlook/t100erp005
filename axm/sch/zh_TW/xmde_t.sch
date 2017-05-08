/* 
================================================================================
檔案代號:xmde_t
檔案名稱:銷售合約/核價結算來源單據明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table xmde_t
(
xmdeent       number(5)      ,/* 企業編號 */
xmdesite       varchar2(10)      ,/* 營運據點 */
xmde000       varchar2(1)      ,/* 資料類型 */
xmde001       varchar2(20)      ,/* 合約/核價單號 */
xmde002       number(10,0)      ,/* 項次 */
xmde003       varchar2(20)      ,/* 關聯單號 */
xmde004       number(10,0)      ,/* 關聯項次 */
xmde005       timestamp(0)      ,/* 結算日期 */
xmde006       varchar2(40)      ,/* 料件編號 */
xmde007       varchar2(256)      ,/* 產品特徵 */
xmde008       number(20,6)      ,/* 交易數量 */
xmde009       varchar2(10)      ,/* 交易單位 */
xmde010       number(20,6)      ,/* 原始單價 */
xmde011       number(20,6)      ,/* 原始未稅金額 */
xmde012       number(20,6)      ,/* 原始含稅金額 */
xmde013       number(20,6)      ,/* 原始稅額 */
xmde014       number(20,6)      ,/* 建議調整後未稅金額 */
xmde015       number(20,6)      ,/* 建議調整後含稅金額 */
xmde016       number(20,6)      ,/* 建議調整後稅額 */
xmde017       number(20,6)      ,/* 差異未稅金額 */
xmde018       number(20,6)      ,/* 差異含稅金額 */
xmde019       number(20,6)      ,/* 差異稅額 */
xmde020       number(20,6)      ,/* 差異數量 */
xmde021       number(20,6)      ,/* 差異數量的單價 */
xmde022       varchar2(20)      ,/* 來源單號 */
xmde023       number(10,0)      ,/* 來源項次 */
xmde024       varchar2(10)      ,/* 來源據點 */
xmde025       varchar2(1)      ,/* 差異處理否 */
xmde026       varchar2(10)      ,/* 差異處理方式 */
xmde027       varchar2(20)      ,/* 差異處理單號 */
xmde028       number(10,0)      ,/* 差異處理項次 */
xmdeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmdeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmdeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmdeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmdeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmdeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmdeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmdeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmdeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmdeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmdeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmdeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmdeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmdeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmdeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmdeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmdeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmdeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmdeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmdeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmdeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmdeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmdeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmdeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmdeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmdeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmdeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmdeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmdeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmdeud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
xmde029       number(20,6)      /* 建議調整後單價 */
);
alter table xmde_t add constraint xmde_pk primary key (xmdeent,xmde000,xmde001,xmde002,xmde003,xmde004,xmde005) enable validate;

create unique index xmde_pk on xmde_t (xmdeent,xmde000,xmde001,xmde002,xmde003,xmde004,xmde005);

grant select on xmde_t to tiptop;
grant update on xmde_t to tiptop;
grant delete on xmde_t to tiptop;
grant insert on xmde_t to tiptop;

exit;
