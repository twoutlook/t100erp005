/* 
================================================================================
檔案代號:craa_t
檔案名稱:潛在客戶資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table craa_t
(
craaent       number(5)      ,/* 企業編號 */
craaunit       varchar2(10)      ,/* 應用組織 */
craa001       varchar2(10)      ,/* 潛客編號 */
craa003       varchar2(20)      ,/* 統一編號 */
craa004       date      ,/* 創業日 */
craa005       varchar2(80)      ,/* 負責人 */
craa006       varchar2(20)      ,/* 身份證號 */
craa007       number(20,6)      ,/* 資本額 */
craa008       varchar2(10)      ,/* 資本額計算幣別 */
craa009       number(20,6)      ,/* 年營業額 */
craa010       varchar2(10)      ,/* 年營業額計算幣別 */
craa011       number(10,0)      ,/* 員工人數 */
craa012       varchar2(255)      ,/* 營業項目 */
craa013       varchar2(20)      ,/* 聯絡對象識別碼 */
craa014       varchar2(10)      ,/* 客戶來源 */
craa015       varchar2(10)      ,/* 客戶分類 */
craa016       varchar2(10)      ,/* 客戶等級 */
craa017       varchar2(10)      ,/* 區域編號 */
craa018       varchar2(10)      ,/* 省區編號 */
craa019       varchar2(10)      ,/* 縣市編號 */
craa020       varchar2(10)      ,/* 地區編號 */
craa021       varchar2(20)      ,/* 業務人員 */
craa022       date      ,/* 指派日期 */
craa023       date      ,/* 接觸日期 */
craa024       date      ,/* 追蹤日期 */
craa025       date      ,/* 預計簽約日期 */
craa026       number(20,6)      ,/* 預估成交金額 */
craa027       varchar2(10)      ,/* 預估交金額計算幣別 */
craa028       number(20,6)      ,/* 成交機率 */
craa029       varchar2(10)      ,/* 正式客戶編號 */
craa030       date      ,/* 結案日期 */
craa031       varchar2(10)      ,/* 成交競爭廠商編號 */
craa032       varchar2(10)      ,/* 潛客狀態 */
craa033       date      ,/* 轉正式客戶日期 */
craastus       varchar2(10)      ,/* 資料狀態碼 */
craaownid       varchar2(20)      ,/* 資料所有者 */
craaowndp       varchar2(10)      ,/* 資料所屬部門 */
craacrtid       varchar2(20)      ,/* 資料建立者 */
craacrtdp       varchar2(10)      ,/* 資料建立部門 */
craacrtdt       timestamp(0)      ,/* 資料創建日 */
craamodid       varchar2(20)      ,/* 資料修改者 */
craamoddt       timestamp(0)      ,/* 最近修改日 */
craacnfid       varchar2(20)      ,/* 資料確認者 */
craacnfdt       timestamp(0)      ,/* 資料確認日 */
craaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
craaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
craaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
craaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
craaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
craaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
craaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
craaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
craaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
craaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
craaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
craaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
craaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
craaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
craaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
craaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
craaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
craaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
craaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
craaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
craaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
craaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
craaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
craaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
craaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
craaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
craaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
craaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
craaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
craaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table craa_t add constraint craa_pk primary key (craaent,craa001) enable validate;

create unique index craa_pk on craa_t (craaent,craa001);

grant select on craa_t to tiptop;
grant update on craa_t to tiptop;
grant delete on craa_t to tiptop;
grant insert on craa_t to tiptop;

exit;
