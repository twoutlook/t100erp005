/* 
================================================================================
檔案代號:xcdr_t
檔案名稱:工時費用成本次要素統計維護檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table xcdr_t
(
xcdrent       number(5)      ,/* 企業代碼 */
xcdrcomp       varchar2(10)      ,/* 法人 */
xcdrld       varchar2(5)      ,/* 帳別 */
xcdr001       varchar2(10)      ,/* 成本計算類型 */
xcdr002       number(5,0)      ,/* 年度 */
xcdr003       number(5,0)      ,/* 期別 */
xcdr004       varchar2(10)      ,/* 成本中心 */
xcdr005       varchar2(10)      ,/* 費用分類(成本次要素) */
xcdr006       varchar2(1)      ,/* 分攤方式 */
xcdr010       varchar2(1)      ,/* 制費類別 */
xcdr011       varchar2(24)      ,/* 會計科目 */
xcdr020       number(20,6)      ,/* 分攤基礎指標總數 */
xcdr021       number(20,6)      ,/* 標準產能 */
xcdr101       number(20,6)      ,/* 費用總額(本位幣一) */
xcdr102       number(20,6)      ,/* 固定費用(本位幣一) */
xcdr103       number(20,6)      ,/* 分攤金額(本位幣一) */
xcdr104       number(20,6)      ,/* 閒置費用(本位幣一) */
xcdr105       number(20,6)      ,/* 單位成本(本位幣一) */
xcdr111       number(20,6)      ,/* 費用總額(本位幣二) */
xcdr112       number(20,6)      ,/* 固定費用(本位幣二) */
xcdr113       number(20,6)      ,/* 分攤金額(本位幣二) */
xcdr114       number(20,6)      ,/* 閒置費用(本位幣二) */
xcdr115       number(20,6)      ,/* 單位成本(本位幣二) */
xcdr121       number(20,6)      ,/* 費用總額(本位幣三) */
xcdr122       number(20,6)      ,/* 固定費用(本位幣三) */
xcdr123       number(20,6)      ,/* 分攤金額(本位幣三) */
xcdr124       number(20,6)      ,/* 閒置費用(本位幣三) */
xcdr125       number(20,6)      ,/* 單位成本(本位幣三) */
xcdrud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xcdrud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xcdrud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xcdrud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xcdrud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xcdrud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xcdrud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xcdrud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xcdrud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xcdrud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xcdrud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xcdrud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xcdrud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xcdrud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xcdrud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xcdrud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xcdrud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xcdrud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xcdrud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xcdrud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xcdrud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xcdrud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xcdrud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xcdrud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xcdrud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xcdrud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xcdrud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xcdrud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xcdrud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xcdrud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xcdr_t add constraint xcdr_pk primary key (xcdrent,xcdrld,xcdr001,xcdr002,xcdr003,xcdr004,xcdr005,xcdr006) enable validate;

create unique index xcdr_pk on xcdr_t (xcdrent,xcdrld,xcdr001,xcdr002,xcdr003,xcdr004,xcdr005,xcdr006);

grant select on xcdr_t to tiptop;
grant update on xcdr_t to tiptop;
grant delete on xcdr_t to tiptop;
grant insert on xcdr_t to tiptop;

exit;
