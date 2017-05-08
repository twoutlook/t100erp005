/* 
================================================================================
檔案代號:dbda_t
檔案名稱:客戶庫存異動單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:Y
============.========================.==========================================
 */
create table dbda_t
(
dbdaent       number(5)      ,/* 企業編號 */
dbdasite       varchar2(10)      ,/* 營運據點 */
dbdaunit       varchar2(10)      ,/* 應用組織 */
dbdadocno       varchar2(20)      ,/* 單據編號 */
dbdadocdt       date      ,/* 單據日期 */
dbda000       varchar2(1)      ,/* 庫存類別 */
dbda001       varchar2(10)      ,/* 客戶編號 */
dbda002       varchar2(10)      ,/* 收貨客戶 */
dbda003       date      ,/* 過帳日期 */
dbda004       varchar2(20)      ,/* 異動人員 */
dbda005       varchar2(10)      ,/* 異動部門 */
dbda006       varchar2(1)      ,/* 已轉正式銷售/銷退單否 */
dbdaownid       varchar2(20)      ,/* 資料所有者 */
dbdaowndp       varchar2(10)      ,/* 資料所屬部門 */
dbdacrtid       varchar2(20)      ,/* 資料建立者 */
dbdacrtdp       varchar2(10)      ,/* 資料建立部門 */
dbdacrtdt       timestamp(0)      ,/* 資料創建日 */
dbdamodid       varchar2(20)      ,/* 資料修改者 */
dbdamoddt       timestamp(0)      ,/* 最近修改日 */
dbdastus       varchar2(10)      ,/* 狀態碼 */
dbdacnfid       varchar2(20)      ,/* 資料確認者 */
dbdacnfdt       timestamp(0)      ,/* 資料確認日 */
dbdapstid       varchar2(20)      ,/* 資料過帳者 */
dbdapstdt       timestamp(0)      ,/* 資料過帳日 */
dbdaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
dbdaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
dbdaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
dbdaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
dbdaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
dbdaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
dbdaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
dbdaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
dbdaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
dbdaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
dbdaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
dbdaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
dbdaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
dbdaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
dbdaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
dbdaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
dbdaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
dbdaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
dbdaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
dbdaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
dbdaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
dbdaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
dbdaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
dbdaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
dbdaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
dbdaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
dbdaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
dbdaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
dbdaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
dbdaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table dbda_t add constraint dbda_pk primary key (dbdaent,dbdadocno) enable validate;

create unique index dbda_pk on dbda_t (dbdaent,dbdadocno);

grant select on dbda_t to tiptop;
grant update on dbda_t to tiptop;
grant delete on dbda_t to tiptop;
grant insert on dbda_t to tiptop;

exit;
