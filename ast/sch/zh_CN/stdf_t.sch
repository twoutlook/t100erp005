/* 
================================================================================
檔案代號:stdf_t
檔案名稱:內部結算匯總資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table stdf_t
(
stdfent       number(5)      ,/* 企業編號 */
stdf001       varchar2(10)      ,/* 結算中心 */
stdf002       number(10,0)      ,/* 結算會計期 */
stdf003       varchar2(10)      ,/* 業務類型 */
stdf004       varchar2(10)      ,/* 內部交易類型 */
stdf005       date      ,/* 單據日期 */
stdf006       varchar2(20)      ,/* 單據編號 */
stdf007       number(10,0)      ,/* 項次 */
stdf008       varchar2(40)      ,/* 產品編號 */
stdf009       varchar2(40)      ,/* 產品條碼 */
stdf010       varchar2(256)      ,/* 產品特徵 */
stdf011       varchar2(10)      ,/* 單位 */
stdf012       number(20,6)      ,/* 數量 */
stdf013       varchar2(10)      ,/* 費用編號 */
stdf014       varchar2(10)      ,/* 幣別 */
stdf015       varchar2(10)      ,/* 稅別 */
stdf016       number(20,6)      ,/* 單價 */
stdf017       number(5,0)      ,/* 方向 */
stdf018       number(20,6)      ,/* 未稅金額 */
stdf019       number(20,6)      ,/* 含稅金額 */
stdf020       varchar2(10)      ,/* 需求組織 */
stdf021       varchar2(10)      ,/* 需求法人 */
stdf022       varchar2(10)      ,/* 需求倉庫(入) */
stdf023       varchar2(10)      ,/* 供貨組織 */
stdf024       varchar2(10)      ,/* 供貨法人 */
stdf025       varchar2(10)      ,/* 供貨倉庫(出） */
stdf026       varchar2(10)      ,/* 配送組織 */
stdf027       varchar2(10)      ,/* 配送法人 */
stdf028       varchar2(10)      ,/* 流程代碼 */
stdfstus       varchar2(10)      ,/* 結算狀態 */
stdfud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
stdfud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
stdfud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
stdfud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
stdfud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
stdfud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
stdfud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
stdfud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
stdfud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
stdfud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
stdfud011       number(20,6)      ,/* 自定義欄位(數字)011 */
stdfud012       number(20,6)      ,/* 自定義欄位(數字)012 */
stdfud013       number(20,6)      ,/* 自定義欄位(數字)013 */
stdfud014       number(20,6)      ,/* 自定義欄位(數字)014 */
stdfud015       number(20,6)      ,/* 自定義欄位(數字)015 */
stdfud016       number(20,6)      ,/* 自定義欄位(數字)016 */
stdfud017       number(20,6)      ,/* 自定義欄位(數字)017 */
stdfud018       number(20,6)      ,/* 自定義欄位(數字)018 */
stdfud019       number(20,6)      ,/* 自定義欄位(數字)019 */
stdfud020       number(20,6)      ,/* 自定義欄位(數字)020 */
stdfud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
stdfud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
stdfud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
stdfud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
stdfud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
stdfud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
stdfud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
stdfud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
stdfud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
stdfud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
stdf029       number(20,6)      ,/* 未結算金額 */
stdf030       number(20,6)      ,/* 已結算金額 */
stdf031       number(20,6)      ,/* 未校驗金額 */
stdf032       number(20,6)      ,/* 已校驗金額 */
stdf033       number(20,6)      ,/* 未立帳金額 */
stdf034       number(20,6)      ,/* 已立帳金額 */
stdf035       varchar2(10)      ,/* 單據來源 */
stdf036       varchar2(10)      ,/* 處理狀態 */
stdf037       number(10,0)      ,/* 項序 */
stdf038       number(5,0)      ,/* 出入庫碼 */
stdfsite       varchar2(10)      ,/* 營運據點 */
stdf039       varchar2(10)      ,/* 交易所屬法人 */
stdf040       varchar2(10)      ,/* 內部交易對象組織 */
stdf041       varchar2(10)      /* 內部交易對象法人 */
);
alter table stdf_t add constraint stdf_pk primary key (stdfent,stdf006,stdf007,stdf037,stdf038,stdfsite) enable validate;

create unique index stdf_pk on stdf_t (stdfent,stdf006,stdf007,stdf037,stdf038,stdfsite);

grant select on stdf_t to tiptop;
grant update on stdf_t to tiptop;
grant delete on stdf_t to tiptop;
grant insert on stdf_t to tiptop;

exit;
