/* 
================================================================================
檔案代號:star_t
檔案名稱:採購協議主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table star_t
(
starent       number(5)      ,/* 企業編號 */
starunit       varchar2(10)      ,/* 應用組織 */
star001       varchar2(20)      ,/* 協議編號 */
star002       varchar2(10)      ,/* 協議版本 */
star003       varchar2(10)      ,/* 供應商 */
star004       varchar2(20)      ,/* 合約編號 */
star005       varchar2(10)      ,/* 經營方式 */
star006       varchar2(10)      ,/* 結算方式 */
star007       varchar2(10)      ,/* 簽訂法人 */
star008       varchar2(10)      ,/* 採購中心 */
starstus       varchar2(10)      ,/* 狀態碼 */
starownid       varchar2(20)      ,/* 資料所有者 */
starowndp       varchar2(10)      ,/* 資料所有部門 */
starcrtid       varchar2(20)      ,/* 資料建立者 */
starcrtdp       varchar2(10)      ,/* 資料建立部門 */
starcrtdt       timestamp(0)      ,/* 資料創建日 */
starmodid       varchar2(20)      ,/* 資料修改者 */
starmoddt       timestamp(0)      ,/* 最近修改日 */
starcnfid       varchar2(20)      ,/* 資料確認者 */
starcnfdt       timestamp(0)      ,/* 資料確認日 */
starud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
starud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
starud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
starud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
starud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
starud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
starud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
starud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
starud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
starud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
starud011       number(20,6)      ,/* 自定義欄位(數字)011 */
starud012       number(20,6)      ,/* 自定義欄位(數字)012 */
starud013       number(20,6)      ,/* 自定義欄位(數字)013 */
starud014       number(20,6)      ,/* 自定義欄位(數字)014 */
starud015       number(20,6)      ,/* 自定義欄位(數字)015 */
starud016       number(20,6)      ,/* 自定義欄位(數字)016 */
starud017       number(20,6)      ,/* 自定義欄位(數字)017 */
starud018       number(20,6)      ,/* 自定義欄位(數字)018 */
starud019       number(20,6)      ,/* 自定義欄位(數字)019 */
starud020       number(20,6)      ,/* 自定義欄位(數字)020 */
starud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
starud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
starud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
starud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
starud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
starud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
starud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
starud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
starud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
starud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
starsite       varchar2(10)      ,/* 營運據點 */
star009       varchar2(20)      ,/* 原合約編號 */
star010       varchar2(10)      /* 採購方式 */
);
alter table star_t add constraint star_pk primary key (starent,star001,starsite) enable validate;

create unique index star_pk on star_t (starent,star001,starsite);

grant select on star_t to tiptop;
grant update on star_t to tiptop;
grant delete on star_t to tiptop;
grant insert on star_t to tiptop;

exit;
