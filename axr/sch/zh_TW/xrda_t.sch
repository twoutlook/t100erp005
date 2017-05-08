/* 
================================================================================
檔案代號:xrda_t
檔案名稱:收款核銷單單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table xrda_t
(
xrdaent       number(5)      ,/* 企业代码 */
xrdacomp       varchar2(10)      ,/* 所屬法人 */
xrdald       varchar2(5)      ,/* 帳套別 */
xrdadocno       varchar2(20)      ,/* 沖帳單號 */
xrdadocdt       date      ,/* 沖帳日期 */
xrdasite       varchar2(10)      ,/* 帳務組織 */
xrda001       varchar2(10)      ,/* 帳款單性質 */
xrda003       varchar2(20)      ,/* 帳務人員 */
xrda004       varchar2(10)      ,/* 帳款核銷客戶 */
xrda005       varchar2(10)      ,/* 收款客戶 */
xrda006       varchar2(20)      ,/* 一次性對象識別碼 */
xrda007       varchar2(1)      ,/* 產生方式 */
xrda008       varchar2(20)      ,/* 來源參考單號 */
xrda009       varchar2(20)      ,/* 沖帳批序號 */
xrda010       varchar2(20)      ,/* 集團代收付單號 */
xrda011       varchar2(1)      ,/* 差異處理 */
xrda012       varchar2(10)      ,/* 退款類型 */
xrda013       varchar2(1)      ,/* 分錄底稿是否可重新產生 */
xrda014       varchar2(20)      ,/* 拋轉傳票號碼 */
xrda015       varchar2(10)      ,/* 作廢理由碼 */
xrda016       number(10,0)      ,/* 列印次數 */
xrda017       varchar2(255)      ,/* MEMO備註 */
xrdastus       varchar2(1)      ,/* 確認否 */
xrdaownid       varchar2(20)      ,/* 資料所有者 */
xrdaowndp       varchar2(10)      ,/* 資料所屬部門 */
xrdacrtid       varchar2(20)      ,/* 資料建立者 */
xrdacrtdp       varchar2(10)      ,/* 資料建立部門 */
xrdacrtdt       timestamp(0)      ,/* 資料創建日 */
xrdamodid       varchar2(20)      ,/* 資料修改者 */
xrdamoddt       timestamp(0)      ,/* 最近修改日 */
xrdaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xrdaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xrdaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xrdaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xrdaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xrdaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xrdaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xrdaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xrdaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xrdaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xrdaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xrdaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xrdaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xrdaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xrdaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xrdaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xrdaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xrdaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xrdaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xrdaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xrdaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xrdaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xrdaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xrdaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xrdaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xrdaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xrdaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xrdaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xrdaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xrdaud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
xrda103       number(20,6)      ,/* 原幣借方金額合計 */
xrda104       number(20,6)      ,/* 原幣貸方金額合計 */
xrda113       number(20,6)      ,/* 本幣借方金額合計 */
xrda114       number(20,6)      ,/* 本幣貸方金額合計 */
xrda123       number(20,6)      ,/* 本位幣二借方金額合計 */
xrda124       number(20,6)      ,/* 本位幣二貸方金額合計 */
xrda133       number(20,6)      ,/* 本位幣三借方金額合計 */
xrda134       number(20,6)      ,/* 本位幣三貸方金額合計 */
xrdacnfid       varchar2(20)      ,/* 資料確認這 */
xrdacnfdt       timestamp(0)      ,/* 資料確認日 */
xrdapstid       varchar2(20)      ,/* 資料過帳者 */
xrdapstdt       timestamp(0)      ,/* 資料過帳日 */
xrda018       varchar2(10)      /* 來源類型(流通) */
);
alter table xrda_t add constraint xrda_pk primary key (xrdaent,xrdald,xrdadocno) enable validate;

create  index xrda_n1 on xrda_t (xrdaent,xrdald,xrda014);
create  index xrda_n2 on xrda_t (xrdaent,xrdald,xrda010,xrda009);
create unique index xrda_pk on xrda_t (xrdaent,xrdald,xrdadocno);

grant select on xrda_t to tiptop;
grant update on xrda_t to tiptop;
grant delete on xrda_t to tiptop;
grant insert on xrda_t to tiptop;

exit;
