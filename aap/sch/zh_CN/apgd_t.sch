/* 
================================================================================
檔案代號:apgd_t
檔案名稱:信用狀修改申請單主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table apgd_t
(
apgdent       number(5)      ,/* 企業編號 */
apgdownid       varchar2(20)      ,/* 資料所有者 */
apgdowndp       varchar2(10)      ,/* 資料所屬部門 */
apgdcrtid       varchar2(20)      ,/* 資料建立者 */
apgdcrtdp       varchar2(10)      ,/* 資料建立部門 */
apgdcrtdt       timestamp(0)      ,/* 資料創建日 */
apgdmodid       varchar2(20)      ,/* 資料修改者 */
apgdmoddt       timestamp(0)      ,/* 最近修改日 */
apgdcnfid       varchar2(20)      ,/* 資料確認者 */
apgdcnfdt       timestamp(0)      ,/* 資料確認日 */
apgdpstid       varchar2(20)      ,/* 資料過帳者 */
apgdpstdt       timestamp(0)      ,/* 資料過帳日 */
apgdstus       varchar2(10)      ,/* 狀態碼 */
apgdcomp       varchar2(10)      ,/* 法人 */
apgddocno       varchar2(20)      ,/* 變更單號 */
apgddocdt       date      ,/* 變更日期 */
apgd001       varchar2(20)      ,/* L/C NO */
apgd002       number(10,0)      ,/* 版次 */
apgd003       date      ,/* 開狀日期 */
apgd004       varchar2(10)      ,/* 受益人 */
apgd005       varchar2(20)      ,/* 業務人員 */
apgd006       varchar2(10)      ,/* 付款類別 */
apgd007       varchar2(15)      ,/* 開狀銀行 */
apgd008       varchar2(10)      ,/* 信用狀類別 */
apgd009       varchar2(1)      ,/* 保兌信用狀否 */
apgd010       date      ,/* 信用狀有效日期 */
apgd011       varchar2(20)      ,/* 許可證號 */
apgd012       date      ,/* 承兌日期 */
apgd013       varchar2(10)      ,/* 保兌費用支付方 */
apgd014       varchar2(1)      ,/* 可否分批交運 */
apgd015       number(20,6)      ,/* 自備款比率 */
apgd016       number(10,6)      ,/* 融資利率 */
apgd017       number(5,0)      ,/* 融資天數 */
apgd018       varchar2(20)      ,/* 融資合約編號 */
apgd019       date      ,/* 最後裝運日 */
apgd020       varchar2(10)      ,/* 運送方式 */
apgd021       varchar2(255)      ,/* 裝載港/機場 */
apgd022       varchar2(255)      ,/* 卸載港/機場 */
apgd023       date      ,/* E.T.D */
apgd024       date      ,/* E.T.A */
apgd025       varchar2(255)      ,/* 備註 */
apgd026       varchar2(1)      ,/* 開狀時支付自備款否 */
apgd027       varchar2(20)      ,/* 自備款差額轉待抵單 */
apgd028       varchar2(20)      ,/* 開狀費用應付憑單號 */
apgd029       varchar2(1)      ,/* 結案否 */
apgd030       varchar2(15)      ,/* 通知銀行 */
apgd100       varchar2(10)      ,/* 幣別 */
apgd101       number(20,10)      ,/* 開狀匯率 */
apgd103       number(20,6)      ,/* 開狀原幣金額 */
apgd104       number(20,6)      ,/* 自備款原幣金額 */
apgd108       number(20,6)      ,/* 保證金原幣金額 */
apgd105       number(20,6)      ,/* 融資原幣金額 */
apgd113       number(20,6)      ,/* 開狀本幣金額 */
apgd114       number(20,6)      ,/* 自備款本幣金額 */
apgd115       number(20,6)      ,/* 融資本幣金額 */
apgd900       number(10,0)      ,/* 變更序 */
apgdud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
apgdud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
apgdud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
apgdud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
apgdud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
apgdud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
apgdud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
apgdud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
apgdud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
apgdud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
apgdud011       number(20,6)      ,/* 自定義欄位(數字)011 */
apgdud012       number(20,6)      ,/* 自定義欄位(數字)012 */
apgdud013       number(20,6)      ,/* 自定義欄位(數字)013 */
apgdud014       number(20,6)      ,/* 自定義欄位(數字)014 */
apgdud015       number(20,6)      ,/* 自定義欄位(數字)015 */
apgdud016       number(20,6)      ,/* 自定義欄位(數字)016 */
apgdud017       number(20,6)      ,/* 自定義欄位(數字)017 */
apgdud018       number(20,6)      ,/* 自定義欄位(數字)018 */
apgdud019       number(20,6)      ,/* 自定義欄位(數字)019 */
apgdud020       number(20,6)      ,/* 自定義欄位(數字)020 */
apgdud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
apgdud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
apgdud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
apgdud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
apgdud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
apgdud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
apgdud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
apgdud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
apgdud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
apgdud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
apgd031       varchar2(20)      ,/* NO USE */
apgd102       number(20,6)      ,/* 預付款原幣金額 */
apgd109       number(20,6)      ,/* 初開狀原幣金額 */
apgd117       number(20,6)      ,/* 到貨本幣金額 */
apgd118       number(20,6)      ,/* 保證金本幣金額 */
apgd106       number(20,6)      ,/* 到單原幣金額 */
apgd107       number(20,6)      ,/* 到貨原幣金額 */
apgd032       varchar2(20)      ,/* 保證金待抵單號 */
apgd033       varchar2(20)      ,/* 預付款待抵單號 */
apgd034       varchar2(10)      ,/* 保證金存提碼 */
apgd035       varchar2(10)      ,/* 保證金現變碼 */
apgd036       varchar2(10)      ,/* 自備款存提碼 */
apgd037       varchar2(10)      ,/* 自備款現變碼 */
apgd038       varchar2(10)      ,/* 預付款存提碼 */
apgd039       varchar2(10)      ,/* 預付款現變碼 */
apgd040       varchar2(10)      ,/* 支付帳戶 */
apgd041       varchar2(1)      ,/* 多幣別採購單 */
apgd112       number(20,6)      /* 預付款本幣金額 */
);
alter table apgd_t add constraint apgd_pk primary key (apgdent,apgdcomp,apgddocno,apgd900) enable validate;

create unique index apgd_pk on apgd_t (apgdent,apgdcomp,apgddocno,apgd900);

grant select on apgd_t to tiptop;
grant update on apgd_t to tiptop;
grant delete on apgd_t to tiptop;
grant insert on apgd_t to tiptop;

exit;
