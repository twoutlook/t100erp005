/* 
================================================================================
檔案代號:inbb_t
檔案名稱:雜項庫存異動申請明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table inbb_t
(
inbbent       number(5)      ,/* 企業編號 */
inbbsite       varchar2(10)      ,/* 營運據點 */
inbbdocno       varchar2(20)      ,/* 單據編號 */
inbbseq       number(10,0)      ,/* 項次 */
inbb001       varchar2(40)      ,/* 料件編號 */
inbb002       varchar2(256)      ,/* 產品特徵 */
inbb003       varchar2(30)      ,/* 庫存管理特徵 */
inbb004       varchar2(40)      ,/* 包裝容器編號 */
inbb007       varchar2(10)      ,/* 庫位 */
inbb008       varchar2(10)      ,/* 限定儲位 */
inbb009       varchar2(30)      ,/* 限定批號 */
inbb010       varchar2(10)      ,/* 交易單位 */
inbb011       number(20,6)      ,/* 申請數量 */
inbb012       number(20,6)      ,/* 實際異動數量 */
inbb013       varchar2(10)      ,/* 參考單位 */
inbb014       number(20,6)      ,/* 參考單位申請數量 */
inbb015       number(20,6)      ,/* 參考單位實際數量 */
inbb016       varchar2(10)      ,/* 理由碼 */
inbb017       varchar2(20)      ,/* 來源單號 */
inbb018       varchar2(1)      ,/* 檢驗否 */
inbb019       number(20,6)      ,/* 檢驗合格量 */
inbb020       varchar2(255)      ,/* 單據備註 */
inbb021       varchar2(255)      ,/* 存貨備註 */
inbb022       date      ,/* 有效日期 */
inbbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
inbbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
inbbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
inbbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
inbbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
inbbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
inbbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
inbbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
inbbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
inbbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
inbbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
inbbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
inbbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
inbbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
inbbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
inbbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
inbbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
inbbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
inbbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
inbbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
inbbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
inbbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
inbbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
inbbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
inbbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
inbbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
inbbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
inbbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
inbbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
inbbud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
inbb200       varchar2(40)      ,/* 商品條碼 */
inbb201       varchar2(10)      ,/* 包裝單位 */
inbb202       number(20,6)      ,/* 申請包裝數量 */
inbb203       number(20,6)      ,/* 實際包裝數量 */
inbbunit       varchar2(10)      ,/* 應用組織 */
inbb204       date      ,/* 製造日期 */
inbb023       varchar2(20)      ,/* 專案編號 */
inbb024       varchar2(30)      ,/* WBS */
inbb025       varchar2(30)      ,/* 活動編號 */
inbb205       number(20,6)      ,/* 領用/退回單價 */
inbb206       number(20,6)      ,/* 領用/退回金額 */
inbb207       number(20,6)      ,/* 成本單價 */
inbb208       number(20,6)      ,/* 成本金額 */
inbb209       varchar2(10)      ,/* 費用編號 */
inbb210       number(20,6)      ,/* 進價 */
inbb211       number(10,0)      ,/* 來源單據項次 */
inbb212       number(10,0)      ,/* 來源單據項序 */
inbb213       varchar2(40)      ,/* 轉入商品條碼 */
inbb214       varchar2(40)      ,/* 轉入商品編號 */
inbb215       varchar2(256)      ,/* 轉入產品特徵 */
inbb216       varchar2(10)      ,/* 轉入單位 */
inbb217       number(20,6)      ,/* 轉入數量 */
inbb218       varchar2(10)      ,/* 轉入包裝單位 */
inbb219       number(20,6)      ,/* 轉入包裝數量 */
inbb220       varchar2(10)      ,/* 轉入庫位 */
inbb221       varchar2(10)      ,/* 轉入儲位 */
inbb222       varchar2(30)      ,/* 轉入批號 */
inbb223       number(20,6)      ,/* 轉入進價 */
inbb224       varchar2(10)      ,/* 計價單位 */
inbb225       number(20,6)      /* 計價數量 */
);
alter table inbb_t add constraint inbb_pk primary key (inbbent,inbbdocno,inbbseq) enable validate;

create unique index inbb_pk on inbb_t (inbbent,inbbdocno,inbbseq);

grant select on inbb_t to tiptop;
grant update on inbb_t to tiptop;
grant delete on inbb_t to tiptop;
grant insert on inbb_t to tiptop;

exit;
