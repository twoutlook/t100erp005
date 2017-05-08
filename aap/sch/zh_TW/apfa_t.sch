/* 
================================================================================
檔案代號:apfa_t
檔案名稱:集團代付款主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table apfa_t
(
apfaent       number(5)      ,/* 企業編號 */
apfasite       varchar2(10)      ,/* 帳務中心 */
apfadocdt       date      ,/* 單據日期 */
apfadocno       varchar2(20)      ,/* 代付款(核銷)單號 */
apfald       varchar2(5)      ,/* 帳套 */
apfacomp       varchar2(10)      ,/* 代付法人(集團) */
apfa001       varchar2(10)      ,/* 集團代付款單性質 */
apfa003       varchar2(20)      ,/* 帳務人員 */
apfa004       varchar2(10)      ,/* 帳款核銷對象 */
apfa005       varchar2(10)      ,/* 付款對象 */
apfa006       varchar2(20)      ,/* 一次性交易識別碼 */
apfa007       varchar2(10)      ,/* 產生方式 */
apfa008       varchar2(20)      ,/* 來源參考單號 */
apfa009       varchar2(10)      ,/* 沖帳批序號 */
apfa010       varchar2(20)      ,/* 集團代付批號 */
apfa011       varchar2(1)      ,/* 差異處理 */
apfa012       varchar2(10)      ,/* 退款類型 */
apfa013       varchar2(1)      ,/* 產生傳票否 */
apfa014       varchar2(20)      ,/* 拋轉傳票號碼 */
apfa015       varchar2(10)      ,/* 作廢理由碼 */
apfa016       number(10,0)      ,/* 列印次數 */
apfa017       varchar2(500)      ,/* MEMO備註 */
apfa018       varchar2(10)      ,/* 付款(攤銷)理由碼 */
apfa019       varchar2(10)      ,/* 攤銷目的方式 */
apfa020       varchar2(10)      ,/* 分攤金額方式 */
apfa021       varchar2(10)      ,/* 目的成本要素 */
apfa022       varchar2(1)      ,/* 集團代付款否 */
apfa113       number(20,6)      ,/* 應核銷本幣金額 */
apfa123       number(20,6)      ,/* 應核銷本幣二金額 */
apfa133       number(20,6)      ,/* 應核銷本幣三金額 */
apfaownid       varchar2(20)      ,/* 資料所有者 */
apfaowndp       varchar2(10)      ,/* 資料所屬部門 */
apfacrtid       varchar2(20)      ,/* 資料建立者 */
apfacrtdp       varchar2(10)      ,/* 資料建立部門 */
apfacrtdt       timestamp(0)      ,/* 資料創建日 */
apfamodid       varchar2(20)      ,/* 資料修改者 */
apfamoddt       timestamp(0)      ,/* 最近修改日 */
apfacnfid       varchar2(20)      ,/* 資料確認者 */
apfacnfdt       timestamp(0)      ,/* 資料確認日 */
apfapstid       varchar2(20)      ,/* 資料過帳者 */
apfapstdt       timestamp(0)      ,/* 資料過帳日 */
apfastus       varchar2(10)      ,/* 狀態碼 */
apfaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
apfaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
apfaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
apfaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
apfaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
apfaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
apfaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
apfaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
apfaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
apfaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
apfaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
apfaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
apfaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
apfaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
apfaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
apfaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
apfaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
apfaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
apfaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
apfaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
apfaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
apfaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
apfaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
apfaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
apfaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
apfaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
apfaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
apfaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
apfaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
apfaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table apfa_t add constraint apfa_pk primary key (apfaent,apfadocno) enable validate;

create unique index apfa_pk on apfa_t (apfaent,apfadocno);

grant select on apfa_t to tiptop;
grant update on apfa_t to tiptop;
grant delete on apfa_t to tiptop;
grant insert on apfa_t to tiptop;

exit;
