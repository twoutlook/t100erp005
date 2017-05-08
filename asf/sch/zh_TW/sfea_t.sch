/* 
================================================================================
檔案代號:sfea_t
檔案名稱:完工入庫單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:Y
============.========================.==========================================
 */
create table sfea_t
(
sfeaent       number(5)      ,/* 企業編號 */
sfeasite       varchar2(10)      ,/* 營運據點 */
sfeadocno       varchar2(20)      ,/* 單號 */
sfeadocdt       date      ,/* 單據日期 */
sfea001       date      ,/* 過帳日期 */
sfea002       varchar2(20)      ,/* 申請人 */
sfea003       varchar2(10)      ,/* 部門 */
sfea004       varchar2(20)      ,/* PBI編號 */
sfea005       varchar2(20)      ,/* 倒扣領料單號 */
sfeaownid       varchar2(20)      ,/* 資料所有者 */
sfeaowndp       varchar2(10)      ,/* 資料所屬部門 */
sfeacrtid       varchar2(20)      ,/* 資料建立者 */
sfeacrtdp       varchar2(10)      ,/* 資料建立部門 */
sfeacrtdt       timestamp(0)      ,/* 資料創建日 */
sfeamodid       varchar2(20)      ,/* 資料修改者 */
sfeamoddt       timestamp(0)      ,/* 最近修改日 */
sfeacnfid       varchar2(20)      ,/* 資料確認者 */
sfeacnfdt       timestamp(0)      ,/* 資料確認日 */
sfeapstid       varchar2(20)      ,/* 資料過帳者 */
sfeapstdt       timestamp(0)      ,/* 資料過帳日 */
sfeastus       varchar2(10)      ,/* 狀態碼 */
sfea006       varchar2(10)      ,/* 生產計畫 */
sfeaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
sfeaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
sfeaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
sfeaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
sfeaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
sfeaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
sfeaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
sfeaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
sfeaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
sfeaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
sfeaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
sfeaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
sfeaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
sfeaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
sfeaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
sfeaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
sfeaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
sfeaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
sfeaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
sfeaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
sfeaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
sfeaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
sfeaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
sfeaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
sfeaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
sfeaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
sfeaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
sfeaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
sfeaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
sfeaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table sfea_t add constraint sfea_pk primary key (sfeaent,sfeadocno) enable validate;

create unique index sfea_pk on sfea_t (sfeaent,sfeadocno);

grant select on sfea_t to tiptop;
grant update on sfea_t to tiptop;
grant delete on sfea_t to tiptop;
grant insert on sfea_t to tiptop;

exit;
