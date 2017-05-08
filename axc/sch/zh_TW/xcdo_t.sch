/* 
================================================================================
檔案代號:xcdo_t
檔案名稱:本期庫存成本要素成本調整檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table xcdo_t
(
xcdoent       number(5)      ,/* 企業編號 */
xcdold       varchar2(5)      ,/* 帳別 */
xcdocomp       varchar2(10)      ,/* 法人組織 */
xcdo001       varchar2(1)      ,/* 賬套本位幣順序 */
xcdo002       varchar2(30)      ,/* 成本域 */
xcdo003       varchar2(10)      ,/* 成本計算類型 */
xcdo004       number(5,0)      ,/* 年度 */
xcdo005       number(5,0)      ,/* 期別 */
xcdo006       varchar2(10)      ,/* 成本要素 */
xcdo007       varchar2(40)      ,/* 料件編號 */
xcdo008       varchar2(256)      ,/* 特性 */
xcdo009       varchar2(30)      ,/* 批號 */
xcdo010       varchar2(20)      ,/* 參考單號 */
xcdo011       varchar2(1)      ,/* 資料來源 */
xcdo012       varchar2(80)      ,/* 調整說明 */
xcdo102       number(20,6)      ,/* 當月調整金額 */
xcdoownid       varchar2(20)      ,/* 資料所有者 */
xcdoowndp       varchar2(10)      ,/* 資料所屬部門 */
xcdocrtid       varchar2(20)      ,/* 資料建立者 */
xcdocrtdp       varchar2(10)      ,/* 資料建立部門 */
xcdocrtdt       timestamp(0)      ,/* 資料創建日 */
xcdomodid       varchar2(20)      ,/* 資料修改者 */
xcdomoddt       timestamp(0)      ,/* 最近修改日 */
xcdocnfid       varchar2(20)      ,/* 資料確認者 */
xcdocnfdt       timestamp(0)      ,/* 資料確認日 */
xcdopstid       varchar2(20)      ,/* 資料過帳者 */
xcdopstdt       timestamp(0)      ,/* 資料過帳日 */
xcdostus       varchar2(10)      ,/* 狀態碼 */
xcdoud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xcdoud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xcdoud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xcdoud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xcdoud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xcdoud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xcdoud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xcdoud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xcdoud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xcdoud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xcdoud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xcdoud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xcdoud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xcdoud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xcdoud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xcdoud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xcdoud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xcdoud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xcdoud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xcdoud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xcdoud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xcdoud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xcdoud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xcdoud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xcdoud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xcdoud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xcdoud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xcdoud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xcdoud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xcdoud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xcdo_t add constraint xcdo_pk primary key (xcdoent,xcdold,xcdo001,xcdo002,xcdo003,xcdo004,xcdo005,xcdo006,xcdo007,xcdo008,xcdo009,xcdo010) enable validate;

create unique index xcdo_pk on xcdo_t (xcdoent,xcdold,xcdo001,xcdo002,xcdo003,xcdo004,xcdo005,xcdo006,xcdo007,xcdo008,xcdo009,xcdo010);

grant select on xcdo_t to tiptop;
grant update on xcdo_t to tiptop;
grant delete on xcdo_t to tiptop;
grant insert on xcdo_t to tiptop;

exit;
