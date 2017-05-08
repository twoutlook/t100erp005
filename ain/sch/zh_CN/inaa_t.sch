/* 
================================================================================
檔案代號:inaa_t
檔案名稱:庫位基本資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table inaa_t
(
inaaent       number(5)      ,/* 企業編號 */
inaasite       varchar2(10)      ,/* 營運據點 */
inaaunit       varchar2(10)      ,/* 應用組織 */
inaa001       varchar2(10)      ,/* 庫位編號 */
inaa002       varchar2(500)      ,/* 庫位名稱 */
inaa003       varchar2(10)      ,/* 助記碼 */
inaa004       varchar2(20)      ,/* 連絡對象識別碼 */
inaa005       varchar2(10)      ,/* 成本中心 */
inaa006       number(5,0)      ,/* 揀料優先順序 */
inaa007       varchar2(1)      ,/* 儲位控管 */
inaa008       varchar2(1)      ,/* 庫存可用否 */
inaa009       varchar2(1)      ,/* MRP可用否 */
inaa010       varchar2(1)      ,/* 成本庫否 */
inaa011       varchar2(1)      ,/* 與WMS整合否 */
inaa012       varchar2(1)      ,/* 自動倉儲整合否 */
inaa013       varchar2(256)      ,/* Tag二進位碼 */
inaa014       varchar2(1)      ,/* 允許負庫存否 */
inaa015       varchar2(1)      ,/* 保稅否 */
inaa016       varchar2(1)      ,/* 待報廢庫否 */
inaa017       varchar2(1)      ,/* 存貨凍結否 */
inaa018       varchar2(10)      ,/* 結算庫位 */
inaa101       varchar2(10)      ,/* 庫位類別 */
inaa102       varchar2(10)      ,/* 庫區類別 */
inaa103       varchar2(10)      ,/* 銷售類別 */
inaa104       varchar2(10)      ,/* 收入類別 */
inaa105       varchar2(10)      ,/* 業態 */
inaa106       varchar2(10)      ,/* 品類 */
inaa110       varchar2(10)      ,/* 收銀方式 */
inaa111       varchar2(10)      ,/* 商品管理方式 */
inaa120       varchar2(10)      ,/* 專櫃編號 */
inaa121       varchar2(10)      ,/* 場地 */
inaa122       varchar2(10)      ,/* 區域 */
inaa123       varchar2(10)      ,/* 樓層 */
inaa124       varchar2(10)      ,/* 樓棟 */
inaa130       date      ,/* 啟用日期 */
inaastus       varchar2(10)      ,/* 狀態碼 */
inaaownid       varchar2(20)      ,/* 資料所有者 */
inaaowndp       varchar2(10)      ,/* 資料所屬部門 */
inaacrtid       varchar2(20)      ,/* 資料建立者 */
inaacrtdp       varchar2(10)      ,/* 資料建立部門 */
inaacrtdt       timestamp(0)      ,/* 資料創建日 */
inaamodid       varchar2(20)      ,/* 資料修改者 */
inaamoddt       timestamp(0)      ,/* 最近修改日 */
inaa131       varchar2(10)      ,/* 管理方式 */
inaa132       varchar2(1)      ,/* 參與自動補貨 */
inaa133       varchar2(1)      ,/* 參與上下限計算 */
inaa134       varchar2(10)      ,/* 專櫃類型 */
inaa135       varchar2(10)      ,/* 庫區用途分類 */
inaa136       varchar2(1)      ,/* 是否為默認庫區 */
inaa137       varchar2(1)      ,/* 接贈卡否 */
inaa138       varchar2(1)      ,/* 接贈券否 */
inaa139       varchar2(1)      ,/* 接禮券否 */
inaa140       varchar2(10)      ,/* 庫區特殊屬性 */
inaastamp       timestamp(5)      ,/* 下傳時間戳 */
inaaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
inaaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
inaaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
inaaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
inaaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
inaaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
inaaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
inaaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
inaaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
inaaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
inaaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
inaaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
inaaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
inaaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
inaaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
inaaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
inaaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
inaaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
inaaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
inaaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
inaaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
inaaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
inaaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
inaaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
inaaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
inaaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
inaaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
inaaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
inaaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
inaaud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
inaa141       varchar2(10)      ,/* 對應常規庫區 */
inaa142       number(5,0)      /* 優先級 */
);
alter table inaa_t add constraint inaa_pk primary key (inaaent,inaasite,inaa001) enable validate;

create  index inaa_01 on inaa_t (inaa013);
create unique index inaa_pk on inaa_t (inaaent,inaasite,inaa001);

grant select on inaa_t to tiptop;
grant update on inaa_t to tiptop;
grant delete on inaa_t to tiptop;
grant insert on inaa_t to tiptop;

exit;
