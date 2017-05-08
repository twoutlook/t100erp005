/* 
================================================================================
檔案代號:stas_t
檔案名稱:採購協議明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stas_t
(
stasent       number(5)      ,/* 企業編號 */
stas001       varchar2(20)      ,/* 協議編號 */
stas002       number(10,0)      ,/* 序號 */
stas003       varchar2(40)      ,/* 商品編號 */
stas004       varchar2(40)      ,/* 商品條碼 */
stas005       varchar2(10)      ,/* 包裝單位 */
stas006       number(15,3)      ,/* 件裝數 */
stas007       varchar2(10)      ,/* 配送方式 */
stas008       varchar2(10)      ,/* 採購單位 */
stas009       varchar2(20)      ,/* 採購員 */
stas010       number(20,6)      ,/* 進價 */
stas011       number(20,6)      ,/* 促銷進價 */
stas012       number(20,6)      ,/* 最小採購量 */
stas013       number(20,6)      ,/* 採購倍量 */
stas014       number(20,6)      ,/* 最小採購額 */
stas015       varchar2(1)      ,/* 是否保證毛利率 */
stas016       number(20,6)      ,/* 保證毛利率 */
stas017       varchar2(1)      ,/* 退廠標誌 */
stas018       date      ,/* 生效日期 */
stas019       date      ,/* 失效日期 */
stas020       varchar2(10)      ,/* 進項稅別 */
stas021       number(5,2)      ,/* No use */
stas022       varchar2(10)      ,/* 採購幣別 */
stas023       varchar2(10)      ,/* 採購計價單位 */
stas024       varchar2(1)      ,/* No use */
stasud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
stasud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
stasud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
stasud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
stasud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
stasud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
stasud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
stasud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
stasud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
stasud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
stasud011       number(20,6)      ,/* 自定義欄位(數字)011 */
stasud012       number(20,6)      ,/* 自定義欄位(數字)012 */
stasud013       number(20,6)      ,/* 自定義欄位(數字)013 */
stasud014       number(20,6)      ,/* 自定義欄位(數字)014 */
stasud015       number(20,6)      ,/* 自定義欄位(數字)015 */
stasud016       number(20,6)      ,/* 自定義欄位(數字)016 */
stasud017       number(20,6)      ,/* 自定義欄位(數字)017 */
stasud018       number(20,6)      ,/* 自定義欄位(數字)018 */
stasud019       number(20,6)      ,/* 自定義欄位(數字)019 */
stasud020       number(20,6)      ,/* 自定義欄位(數字)020 */
stasud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
stasud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
stasud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
stasud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
stasud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
stasud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
stasud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
stasud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
stasud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
stasud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
stas025       number(20,6)      ,/* 結算扣率 */
stassite       varchar2(10)      ,/* 營運據點 */
stas026       date      ,/* 促銷進價開始日 */
stas027       date      ,/* 促銷進價結束日 */
stas028       varchar2(10)      ,/* 商品生命週期 */
stas029       number(20,6)      ,/* 最近入庫進價 */
stas030       number(20,6)      /* 執行進價 */
);
alter table stas_t add constraint stas_pk primary key (stasent,stas001,stas002,stassite) enable validate;

create unique index stas_pk on stas_t (stasent,stas001,stas002,stassite);

grant select on stas_t to tiptop;
grant update on stas_t to tiptop;
grant delete on stas_t to tiptop;
grant insert on stas_t to tiptop;

exit;
