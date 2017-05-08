/* 
================================================================================
檔案代號:bxfa_t
檔案名稱:保稅料件月統計檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table bxfa_t
(
bxfaent       number(5)      ,/* 企業代碼 */
bxfasite       varchar2(10)      ,/* 營運據點 */
bxfa001       varchar2(40)      ,/* 料件編號 */
bxfa002       varchar2(10)      ,/* 庫位編號 */
bxfa003       number(5,0)      ,/* 年度 */
bxfa004       number(5,0)      ,/* 期別 */
bxfa005       number(20,6)      ,/* 本期入庫總量 */
bxfa006       number(20,6)      ,/* 本期出庫總量 */
bxfa007       number(20,6)      ,/* 期末數量 */
bxfa008       number(20,6)      ,/* 本期保稅進貨數 */
bxfa009       number(20,6)      ,/* 本期非保稅進貨數 */
bxfa010       number(20,6)      ,/* 本期內銷數量 */
bxfa011       number(20,6)      ,/* 本期內銷折合原料數量 */
bxfa012       number(20,6)      ,/* 本期結存非保稅數量 */
bxfa021       number(20,6)      ,/* 本期廠內生產領用數量(原料帳) */
bxfa022       number(20,6)      ,/* 本期廠外加工領用數量(原料帳) */
bxfa023       number(20,6)      ,/* 本期外運領用數量(原料帳) */
bxfa024       number(20,6)      ,/* 本期其他領用數量(原料帳) */
bxfa025       number(20,6)      ,/* 本期退料數量(原料帳) */
bxfa026       number(20,6)      ,/* 本期出口數量(原料帳) */
bxfa027       number(20,6)      ,/* 本期報廢數量(原料帳) */
bxfa028       number(20,6)      ,/* 本期出口數量(成品帳) */
bxfa029       number(20,6)      ,/* 本期成品存倉數(轉運用成品帳) */
bxfa030       number(20,6)      ,/* 本期成品出倉數(轉運用成品帳) */
bxfa031       number(20,6)      ,/* 本期其化成品出倉數(轉運用成品帳) */
bxfaownid       varchar2(20)      ,/* 資料所有者 */
bxfaowndp       varchar2(10)      ,/* 資料所屬部門 */
bxfacrtid       varchar2(20)      ,/* 資料建立者 */
bxfacrtdp       varchar2(10)      ,/* 資料建立部門 */
bxfacrtdt       timestamp(0)      ,/* 資料創建日 */
bxfamodid       varchar2(20)      ,/* 資料修改者 */
bxfamoddt       timestamp(0)      ,/* 最近修改日 */
bxfastus       varchar2(10)      ,/* 狀態碼 */
bxfaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bxfaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bxfaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bxfaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bxfaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bxfaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bxfaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bxfaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bxfaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bxfaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bxfaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bxfaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bxfaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bxfaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bxfaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bxfaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bxfaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bxfaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bxfaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bxfaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bxfaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bxfaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bxfaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bxfaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bxfaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bxfaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bxfaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bxfaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bxfaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bxfaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bxfa_t add constraint bxfa_pk primary key (bxfaent,bxfasite,bxfa001,bxfa002,bxfa003,bxfa004) enable validate;

create unique index bxfa_pk on bxfa_t (bxfaent,bxfasite,bxfa001,bxfa002,bxfa003,bxfa004);

grant select on bxfa_t to tiptop;
grant update on bxfa_t to tiptop;
grant delete on bxfa_t to tiptop;
grant insert on bxfa_t to tiptop;

exit;
