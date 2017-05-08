/* 
================================================================================
檔案代號:isam_t
檔案名稱:進項發票主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table isam_t
(
isament       number(5)      ,/* 企業編號 */
isamownid       varchar2(20)      ,/* 資料所有者 */
isamowndp       varchar2(10)      ,/* 資料所屬部門 */
isamcrtid       varchar2(20)      ,/* 資料建立者 */
isamcrtdp       varchar2(10)      ,/* 資料建立部門 */
isamcrtdt       timestamp(0)      ,/* 資料創建日 */
isammodid       varchar2(20)      ,/* 資料修改者 */
isammoddt       timestamp(0)      ,/* 最近修改日 */
isamcnfid       varchar2(20)      ,/* 資料確認者 */
isamcnfdt       timestamp(0)      ,/* 資料確認日 */
isamstus       varchar2(10)      ,/* 狀態碼 */
isamcomp       varchar2(10)      ,/* 法人 */
isamdocno       varchar2(20)      ,/* 收票單號 */
isamseq       number(10,0)      ,/* 項次 */
isam001       varchar2(10)      ,/* 發票來源 */
isam002       varchar2(10)      ,/* 開發票人 */
isam004       varchar2(10)      ,/* 帳務中心(業務組織) */
isam006       varchar2(10)      ,/* 業務部門(登錄部門) */
isam008       varchar2(2)      ,/* 發票類型 */
isam009       varchar2(20)      ,/* 銷方發票代碼 */
isam010       varchar2(20)      ,/* 發票號碼 */
isam011       date      ,/* 發票日期 */
isam012       varchar2(10)      ,/* 稅別 */
isam0121       varchar2(1)      ,/* 含稅否 */
isam013       number(5,2)      ,/* 稅率 */
isam014       varchar2(10)      ,/* 幣別 */
isam015       number(20,10)      ,/* 匯率 */
isam016       varchar2(255)      ,/* 購貨方名稱 */
isam017       varchar2(20)      ,/* 購貨方稅務編號 */
isam018       varchar2(4000)      ,/* 購貨方地址 */
isam019       varchar2(20)      ,/* 購貨方電話 */
isam020       varchar2(255)      ,/* 購貨方開戶銀行 */
isam021       varchar2(30)      ,/* 購貨方帳戶編碼 */
isam022       varchar2(10)      ,/* 銷方銀行帳戶編碼 */
isam023       number(20,6)      ,/* 發票原幣未稅金額 */
isam024       number(20,6)      ,/* 發票原幣稅額 */
isam025       number(20,6)      ,/* 發票原幣含稅金額 */
isam026       number(20,6)      ,/* 發票本幣未稅金額 */
isam027       number(20,6)      ,/* 發票本幣稅額 */
isam028       number(20,6)      ,/* 發票本幣含稅金額 */
isam029       varchar2(255)      ,/* 銷貨方名稱 */
isam030       varchar2(20)      ,/* 稅務編號 */
isam031       varchar2(4000)      ,/* 銷貨方地址 */
isam032       varchar2(20)      ,/* 銷貨方電話 */
isam033       varchar2(80)      ,/* 銷貨方開戶銀行 */
isam034       varchar2(30)      ,/* 銷貨方帳號 */
isam035       number(20,6)      ,/* 申報數量 */
isam036       varchar2(10)      ,/* 異動狀態 */
isam037       varchar2(1)      ,/* 可扣抵編號 */
isam038       varchar2(10)      ,/* 作廢(註銷)理由碼 */
isam039       date      ,/* 作廢日期 */
isam040       varchar2(8)      ,/* 作廢時間 */
isam041       varchar2(20)      ,/* 作廢人員 */
isam042       varchar2(80)      ,/* 專案作廢核准文號 */
isam043       varchar2(1)      ,/* 通關方式註記 */
isam044       number(5,0)      ,/* 列印次數 */
isam045       varchar2(20)      ,/* 支付工具卡號1 */
isam046       varchar2(20)      ,/* 支付工具卡號2 */
isam047       varchar2(20)      ,/* 支付工具卡號3 */
isam048       varchar2(10)      ,/* 通關註記 */
isam049       varchar2(255)      ,/* 備註說明 */
isam050       varchar2(20)      ,/* 立帳單號 */
isam107       number(20,6)      ,/* 發票原幣已折金額 */
isam108       number(20,6)      ,/* 發票原幣已折稅額 */
isam117       number(20,6)      ,/* 發票本幣已折金額 */
isam118       number(20,6)      ,/* 發票本幣已折稅額 */
isam200       varchar2(1)      ,/* 電子發票否 */
isam201       varchar2(10)      ,/* 愛心碼 */
isam202       varchar2(10)      ,/* 載具類別號碼 */
isam203       varchar2(80)      ,/* 載具顯碼 ID */
isam204       varchar2(80)      ,/* 載具隱碼 ID */
isam205       varchar2(1)      ,/* 電子發票匯出狀態 */
isam206       varchar2(20)      ,/* 電子發票匯出序號 */
isam207       varchar2(10)      ,/* 電子發票領取方式 */
isam208       number(5,0)      ,/* 申報年度 */
isam209       number(5,0)      ,/* 申報月份 */
isam210       varchar2(10)      ,/* 申報據點 */
isamud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
isamud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
isamud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
isamud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
isamud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
isamud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
isamud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
isamud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
isamud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
isamud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
isamud011       number(20,6)      ,/* 自定義欄位(數字)011 */
isamud012       number(20,6)      ,/* 自定義欄位(數字)012 */
isamud013       number(20,6)      ,/* 自定義欄位(數字)013 */
isamud014       number(20,6)      ,/* 自定義欄位(數字)014 */
isamud015       number(20,6)      ,/* 自定義欄位(數字)015 */
isamud016       number(20,6)      ,/* 自定義欄位(數字)016 */
isamud017       number(20,6)      ,/* 自定義欄位(數字)017 */
isamud018       number(20,6)      ,/* 自定義欄位(數字)018 */
isamud019       number(20,6)      ,/* 自定義欄位(數字)019 */
isamud020       number(20,6)      ,/* 自定義欄位(數字)020 */
isamud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
isamud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
isamud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
isamud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
isamud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
isamud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
isamud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
isamud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
isamud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
isamud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
isam051       varchar2(1)      /* 認證否 */
);
alter table isam_t add constraint isam_pk primary key (isament,isamdocno,isamseq) enable validate;

create  index isam_01 on isam_t (isam008,isam009,isam010);
create  index isam_02 on isam_t (isamdocno,isamseq);
create  index isam_03 on isam_t (isam008,isam010,isam009,isam002);
create unique index isam_pk on isam_t (isament,isamdocno,isamseq);

grant select on isam_t to tiptop;
grant update on isam_t to tiptop;
grant delete on isam_t to tiptop;
grant insert on isam_t to tiptop;

exit;
