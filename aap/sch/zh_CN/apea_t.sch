/* 
================================================================================
檔案代號:apea_t
檔案名稱:付款申請主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table apea_t
(
apeaent       number(5)      ,/* 企業編號 */
apeacomp       varchar2(10)      ,/* 代付法人(集團) */
apeald       varchar2(5)      ,/* 帳套 */
apeadocno       varchar2(20)      ,/* 請款單號 */
apeadocdt       date      ,/* 單據日期 */
apeasite       varchar2(10)      ,/* 資金中心 */
apea001       varchar2(10)      ,/* 請款單性質 */
apea003       varchar2(20)      ,/* 帳務人員 */
apea005       varchar2(10)      ,/* 付款對象 */
apea006       varchar2(20)      ,/* 一次性交易識別碼 */
apea007       varchar2(10)      ,/* 產生方式 */
apea008       varchar2(20)      ,/* 來源參考單號 */
apea009       varchar2(10)      ,/* 沖帳批序號 */
apea010       varchar2(20)      ,/* 集團代付批號 */
apea011       varchar2(1)      ,/* 差異處理 */
apea013       varchar2(1)      ,/* 已付款註記 */
apea014       varchar2(20)      ,/* 拋轉傳票號碼 */
apea015       varchar2(10)      ,/* 作廢理由碼 */
apea016       number(10,0)      ,/* 列印次數 */
apea017       varchar2(500)      ,/* MEMO備註 */
apea018       varchar2(10)      ,/* 付款(攤銷)理由碼 */
apea022       varchar2(1)      ,/* 集團代付款否 */
apea023       varchar2(20)      ,/* 付款核銷者 */
apea024       date      ,/* 付款核銷日期 */
apeaownid       varchar2(20)      ,/* 資料所有者 */
apeaowndp       varchar2(10)      ,/* 資料所屬部門 */
apeacrtid       varchar2(20)      ,/* 資料建立者 */
apeacrtdp       varchar2(10)      ,/* 資料建立部門 */
apeacrtdt       timestamp(0)      ,/* 資料創建日 */
apeamodid       varchar2(20)      ,/* 資料修改者 */
apeamoddt       timestamp(0)      ,/* 最近修改日 */
apeacnfid       varchar2(20)      ,/* 資料確認者 */
apeacnfdt       timestamp(0)      ,/* 資料確認日 */
apeapstid       varchar2(20)      ,/* 資料過帳者 */
apeapstdt       timestamp(0)      ,/* 資料過帳日 */
apeastus       varchar2(10)      ,/* 狀態碼 */
apeaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
apeaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
apeaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
apeaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
apeaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
apeaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
apeaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
apeaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
apeaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
apeaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
apeaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
apeaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
apeaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
apeaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
apeaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
apeaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
apeaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
apeaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
apeaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
apeaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
apeaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
apeaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
apeaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
apeaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
apeaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
apeaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
apeaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
apeaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
apeaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
apeaud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
apea019       number(5,0)      ,/* 請款年度 */
apea020       number(5,0)      /* 請款月份 */
);
alter table apea_t add constraint apea_pk primary key (apeaent,apeadocno) enable validate;

create unique index apea_pk on apea_t (apeaent,apeadocno);

grant select on apea_t to tiptop;
grant update on apea_t to tiptop;
grant delete on apea_t to tiptop;
grant insert on apea_t to tiptop;

exit;
