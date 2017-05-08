/* 
================================================================================
檔案代號:apda_t
檔案名稱:付款核銷單單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table apda_t
(
apdaent       number(5)      ,/* 企業編號 */
apdacomp       varchar2(10)      ,/* 法人 */
apdald       varchar2(5)      ,/* 帳別 */
apdadocno       varchar2(20)      ,/* 單號 */
apdadocdt       date      ,/* 單據日期 */
apdasite       varchar2(10)      ,/* 帳務組織 */
apda001       varchar2(10)      ,/* 帳款單性質 */
apda002       varchar2(500)      ,/* NO USE */
apda003       varchar2(20)      ,/* 帳務人員 */
apda004       varchar2(10)      ,/* 帳款核銷對象 */
apda005       varchar2(10)      ,/* 付款對象 */
apda006       varchar2(20)      ,/* 一次性交易識別碼 */
apda007       varchar2(10)      ,/* 產生方式 */
apda008       varchar2(20)      ,/* 來源參考單號 */
apda009       varchar2(10)      ,/* 沖帳批序號 */
apda010       varchar2(20)      ,/* 集團代付付單號 */
apda011       varchar2(1)      ,/* 差異處理 */
apda012       varchar2(10)      ,/* 退款類型 */
apda013       varchar2(1)      ,/* 分錄底稿是否可重新產生 */
apda014       varchar2(20)      ,/* 拋轉傳票號碼 */
apda015       varchar2(10)      ,/* 作廢理由碼 */
apda016       number(10,0)      ,/* 列印次數 */
apda017       varchar2(500)      ,/* MEMO備註 */
apda018       varchar2(10)      ,/* 付款(攤銷)理由碼 */
apda019       varchar2(10)      ,/* 攤銷目的方式 */
apda020       varchar2(10)      ,/* 分攤金額方式 */
apda021       varchar2(10)      ,/* 目的成本要素 */
apda113       number(20,6)      ,/* 應核銷本幣金額 */
apda123       number(20,6)      ,/* 應核銷本幣二金額 */
apda133       number(20,6)      ,/* 應核銷本幣三金額 */
apdaownid       varchar2(20)      ,/* 資料所有者 */
apdaowndp       varchar2(10)      ,/* 資料所屬部門 */
apdacrtid       varchar2(20)      ,/* 資料建立者 */
apdacrtdp       varchar2(10)      ,/* 資料建立部門 */
apdacrtdt       timestamp(0)      ,/* 資料創建日 */
apdamodid       varchar2(20)      ,/* 資料修改者 */
apdamoddt       timestamp(0)      ,/* 最近修改日 */
apdacnfid       varchar2(20)      ,/* 資料確認者 */
apdacnfdt       timestamp(0)      ,/* 資料確認日 */
apdapstid       varchar2(20)      ,/* 資料過帳者 */
apdapstdt       timestamp(0)      ,/* 資料過帳日 */
apdastus       varchar2(10)      ,/* 狀態碼 */
apdaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
apdaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
apdaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
apdaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
apdaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
apdaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
apdaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
apdaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
apdaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
apdaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
apdaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
apdaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
apdaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
apdaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
apdaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
apdaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
apdaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
apdaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
apdaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
apdaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
apdaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
apdaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
apdaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
apdaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
apdaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
apdaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
apdaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
apdaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
apdaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
apdaud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
apda104       number(20,6)      ,/* 原幣借方金額合計 */
apda105       number(20,6)      ,/* 原幣貸方金額合計 */
apda114       number(20,6)      ,/* 本幣借方金額合計 */
apda115       number(20,6)      ,/* 本幣貸方金額合計 */
apda124       number(20,6)      ,/* 本位幣二借方金額合計 */
apda125       number(20,6)      ,/* 本位幣二貸方金額合計 */
apda134       number(20,6)      ,/* 本位幣三借方金額合計 */
apda135       number(20,6)      ,/* 本位幣三貸方金額合計 */
apda022       varchar2(10)      /* 經營方式 */
);
alter table apda_t add constraint apda_pk primary key (apdaent,apdald,apdadocno) enable validate;

create  index apda_n1 on apda_t (apdaent,apdald,apda014);
create  index apda_n2 on apda_t (apdaent,apdald,apda010,apda009);
create unique index apda_pk on apda_t (apdaent,apdald,apdadocno);

grant select on apda_t to tiptop;
grant update on apda_t to tiptop;
grant delete on apda_t to tiptop;
grant insert on apda_t to tiptop;

exit;
