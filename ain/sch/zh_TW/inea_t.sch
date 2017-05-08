/* 
================================================================================
檔案代號:inea_t
檔案名稱:盤點計劃資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table inea_t
(
ineaent       number(5)      ,/* 企業編號 */
ineaunit       varchar2(10)      ,/* 應用組織 */
ineasite       varchar2(10)      ,/* 營運據點 */
ineadocno       varchar2(20)      ,/* 盤點計劃 */
ineadocdt       date      ,/* 單據日期 */
inea001       varchar2(80)      ,/* 計劃說明 */
inea002       date      ,/* 盤點日期 */
inea003       varchar2(10)      ,/* 盤點類型 */
inea004       varchar2(10)      ,/* 漏盤處理方式 */
inea005       varchar2(1)      ,/* 限定盤點範圍 */
inea006       varchar2(20)      ,/* 計劃人員 */
inea007       varchar2(10)      ,/* 部門 */
inea008       varchar2(1)      ,/* 啟用盤點計劃 */
inea009       varchar2(1)      ,/* 啟用預盤單 */
inea010       varchar2(1)      ,/* 啟用庫存快照 */
inea011       varchar2(1)      ,/* 啟用初盤 */
inea012       varchar2(1)      ,/* 啟用複盤 */
inea013       varchar2(1)      ,/* 啟用抽盤 */
inea014       varchar2(1)      ,/* 啟用盈虧調整 */
inea015       varchar2(1)      ,/* 啟用盤點完成 */
inea016       varchar2(1)      ,/* 啟用盤點作廢 */
ineastus       varchar2(10)      ,/* 狀態 */
ineaownid       varchar2(20)      ,/* 資料所屬者 */
ineaowndp       varchar2(10)      ,/* 資料所有部門 */
ineacrtid       varchar2(20)      ,/* 資料建立者 */
ineacrtdp       varchar2(10)      ,/* 資料建立部門 */
ineacrtdt       timestamp(0)      ,/* 資料創建日 */
ineamodid       varchar2(20)      ,/* 資料修改者 */
ineamoddt       timestamp(0)      ,/* 最近修改日 */
ineacnfid       varchar2(20)      ,/* 資料確認者 */
ineacnfdt       timestamp(0)      ,/* 資料確認日 */
ineaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
ineaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
ineaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
ineaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
ineaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
ineaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
ineaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
ineaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
ineaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
ineaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
ineaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
ineaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
ineaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
ineaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
ineaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
ineaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
ineaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
ineaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
ineaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
ineaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
ineaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
ineaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
ineaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
ineaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
ineaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
ineaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
ineaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
ineaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
ineaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
ineaud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
inea017       varchar2(1)      ,/* 自營購銷 */
inea018       varchar2(1)      ,/* 扣率代銷 */
inea019       varchar2(1)      ,/* 聯營-開單專櫃 */
inea020       varchar2(1)      ,/* 租賃 */
inea021       varchar2(1)      ,/* 成本代銷 */
inea022       varchar2(1)      /* 全部 */
);
alter table inea_t add constraint inea_pk primary key (ineaent,ineadocno) enable validate;

create unique index inea_pk on inea_t (ineaent,ineadocno);

grant select on inea_t to tiptop;
grant update on inea_t to tiptop;
grant delete on inea_t to tiptop;
grant insert on inea_t to tiptop;

exit;
