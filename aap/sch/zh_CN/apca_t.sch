/* 
================================================================================
檔案代號:apca_t
檔案名稱:應付憑單單頭
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table apca_t
(
apcaent       number(5)      ,/* 企業編號 */
apcaownid       varchar2(20)      ,/* 資料所有者 */
apcaowndp       varchar2(10)      ,/* 資料所有部門 */
apcacrtid       varchar2(20)      ,/* 資料建立者 */
apcacrtdp       varchar2(10)      ,/* 資料建立部門 */
apcacrtdt       timestamp(0)      ,/* 資料創建日 */
apcamodid       varchar2(20)      ,/* 資料修改者 */
apcamoddt       timestamp(0)      ,/* 最近修改日 */
apcacnfid       varchar2(20)      ,/* 資料確認者 */
apcacnfdt       timestamp(0)      ,/* 資料確認日 */
apcapstid       varchar2(20)      ,/* 資料過帳者 */
apcapstdt       timestamp(0)      ,/* 資料過帳日 */
apcastus       varchar2(10)      ,/* 狀態碼 */
apcald       varchar2(5)      ,/* 帳別 */
apcacomp       varchar2(10)      ,/* 法人 */
apcadocno       varchar2(20)      ,/* 應付帳款單號碼 */
apcadocdt       date      ,/* 帳款日期 */
apcasite       varchar2(10)      ,/* 帳務中心 */
apca001       varchar2(10)      ,/* 帳款單性質 */
apca003       varchar2(20)      ,/* 帳務人員 */
apca004       varchar2(10)      ,/* 帳款對象編號 */
apca005       varchar2(10)      ,/* 付款對象 */
apca006       varchar2(10)      ,/* 供應商分類 */
apca007       varchar2(10)      ,/* 帳款類別 */
apca008       varchar2(10)      ,/* 付款條件編號 */
apca009       date      ,/* 應付款日/應扣抵日 */
apca010       date      ,/* 容許票據到期日 */
apca011       varchar2(10)      ,/* 稅別 */
apca012       number(5,2)      ,/* 稅率 */
apca013       varchar2(1)      ,/* 含稅否 */
apca014       varchar2(20)      ,/* 人員編號 */
apca015       varchar2(10)      ,/* 部門編號 */
apca016       varchar2(20)      ,/* 來源作業類型 */
apca017       varchar2(1)      ,/* 產生方式 */
apca018       varchar2(20)      ,/* 來源參考單號 */
apca019       varchar2(20)      ,/* 系統產生對應單號(待抵帳款-預付) */
apca020       varchar2(1)      ,/* 信用狀付款否 */
apca021       varchar2(20)      ,/* 商業發票號碼(IV no.) */
apca022       varchar2(20)      ,/* 進口報單號碼 */
apca025       varchar2(1)      ,/* 差異處理(發票與帳款差異) */
apca026       number(20,6)      ,/* 原幣未稅差異 */
apca027       number(20,6)      ,/* 原幣稅額差異 */
apca028       number(20,6)      ,/* 本幣未稅差異 */
apca029       number(20,6)      ,/* 本幣幣稅額差異 */
apca030       varchar2(24)      ,/* 差異科目 */
apca031       varchar2(20)      ,/* 產生之差異折讓單號 */
apca032       varchar2(2)      ,/* 發票類型 */
apca033       varchar2(10)      ,/* 專案編號 */
apca034       varchar2(10)      ,/* 責任中心 */
apca035       varchar2(24)      ,/* 應付(貸方)科目編號 */
apca036       varchar2(24)      ,/* 費用(借方)科目編號 */
apca037       varchar2(1)      ,/* 產生傳票否 */
apca038       varchar2(20)      ,/* 拋轉傳票號碼 */
apca039       number(10,0)      ,/* 會計檢核附件份數 */
apca040       varchar2(1)      ,/* 留置否 */
apca041       varchar2(10)      ,/* 留置理由碼 */
apca042       date      ,/* 留置設定日期 */
apca043       date      ,/* 留置解除日期 */
apca044       number(20,6)      ,/* 留置原幣金額 */
apca045       varchar2(255)      ,/* 留置說明 */
apca046       varchar2(1)      ,/* 關係人否 */
apca047       varchar2(20)      ,/* 多角序號 */
apca048       varchar2(20)      ,/* 集團代付/代付單號 */
apca049       varchar2(10)      ,/* 來源營運中心代碼 */
apca050       number(10,0)      ,/* 交易原始單據份數 */
apca051       varchar2(10)      ,/* 作廢理由碼 */
apca052       number(10,0)      ,/* 列印次數 */
apca053       varchar2(255)      ,/* 備註 */
apca054       varchar2(10)      ,/* 多帳期設定 */
apca055       varchar2(10)      ,/* 繳款優惠條件 */
apca056       varchar2(10)      ,/* 會計檢核附件狀態 */
apca057       varchar2(20)      ,/* 交易對象識別碼 */
apca058       varchar2(10)      ,/* 稅別交易類型 */
apca059       varchar2(10)      ,/* 預算編號 */
apca060       varchar2(1)      ,/* 發票開立方式 */
apca061       date      ,/* 預開發票基準日 */
apca062       varchar2(1)      ,/* 多角性質 */
apca063       varchar2(20)      ,/* 整帳批序號 */
apca064       number(10,0)      ,/* 訂金序次 */
apca065       varchar2(20)      ,/* 發票代碼 */
apca066       varchar2(20)      ,/* 發票號碼 */
apca100       varchar2(10)      ,/* 交易原幣別 */
apca101       number(20,10)      ,/* 原幣匯率 */
apca103       number(20,6)      ,/* 原幣未稅金額 */
apca104       number(20,6)      ,/* 原幣稅額 */
apca106       number(20,6)      ,/* 原幣應稅折抵合計金額 */
apca107       number(20,6)      ,/* NO USE */
apca108       number(20,6)      ,/* 原幣應付金額 */
apca113       number(20,6)      ,/* 本幣未稅金額 */
apca114       number(20,6)      ,/* 本幣稅額 */
apca116       number(20,6)      ,/* 本幣應稅折抵合計金額 */
apca117       number(20,6)      ,/* NO USE */
apca118       number(20,6)      ,/* 本幣應付金額 */
apca120       varchar2(10)      ,/* 本位幣二幣別 */
apca121       number(20,10)      ,/* 本位幣二匯率 */
apca123       number(20,6)      ,/* 本位幣二未稅金額 */
apca124       number(20,6)      ,/* 本位幣二稅額 */
apca126       number(20,6)      ,/* 本位幣二應稅折抵合計金額 */
apca127       number(20,6)      ,/* NO USE */
apca128       number(20,6)      ,/* 本位幣二應付金額 */
apca130       varchar2(10)      ,/* 本位幣三幣別 */
apca131       number(20,10)      ,/* 本位幣三匯率 */
apca133       number(20,6)      ,/* 本位幣三未稅金額 */
apca134       number(20,6)      ,/* 本位幣三稅額 */
apca136       number(20,6)      ,/* 本位幣三應稅折抵合計金額 */
apca137       number(20,6)      ,/* NO USE */
apca138       number(20,6)      ,/* 本位幣三應付金額 */
apcaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
apcaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
apcaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
apcaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
apcaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
apcaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
apcaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
apcaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
apcaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
apcaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
apcaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
apcaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
apcaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
apcaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
apcaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
apcaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
apcaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
apcaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
apcaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
apcaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
apcaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
apcaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
apcaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
apcaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
apcaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
apcaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
apcaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
apcaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
apcaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
apcaud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
apca067       varchar2(10)      ,/* 管理品類 */
apca068       varchar2(10)      ,/* 經營方式 */
apca069       number(20,6)      ,/* no use */
apca070       number(20,6)      ,/* no use */
apca071       number(20,6)      ,/* no use */
apca072       number(20,6)      /* no use */
);
alter table apca_t add constraint apca_pk primary key (apcaent,apcald,apcadocno) enable validate;

create  index apca_n1 on apca_t (apcaent,apcasite,apcald,apca009,apca010);
create  index apca_n2 on apca_t (apcaent,apcald,apca007,apca035,apca036,apca038);
create  index apca_n3 on apca_t (apcacomp,apcasite,apca004,apca018,apca019);
create unique index apca_pk on apca_t (apcaent,apcald,apcadocno);

grant select on apca_t to tiptop;
grant update on apca_t to tiptop;
grant delete on apca_t to tiptop;
grant insert on apca_t to tiptop;

exit;
