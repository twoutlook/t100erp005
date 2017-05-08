/* 
================================================================================
檔案代號:apga_t
檔案名稱:信用狀申請單主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table apga_t
(
apgaent       number(5)      ,/* 企業代碼 */
apgaownid       varchar2(20)      ,/* 資料所有者 */
apgaowndp       varchar2(10)      ,/* 資料所屬部門 */
apgacrtid       varchar2(20)      ,/* 資料建立者 */
apgacrtdp       varchar2(10)      ,/* 資料建立部門 */
apgacrtdt       timestamp(0)      ,/* 資料創建日 */
apgamodid       varchar2(20)      ,/* 資料修改者 */
apgamoddt       timestamp(0)      ,/* 最近修改日 */
apgacnfid       varchar2(20)      ,/* 資料確認者 */
apgacnfdt       timestamp(0)      ,/* 資料確認日 */
apgapstid       varchar2(20)      ,/* 資料過帳者 */
apgapstdt       timestamp(0)      ,/* 資料過帳日 */
apgastus       varchar2(10)      ,/* 狀態碼 */
apgacomp       varchar2(10)      ,/* 法人 */
apgadocno       varchar2(20)      ,/* 申請單號 */
apgadocdt       date      ,/* 申請日期 */
apga001       varchar2(20)      ,/* L/C NO */
apga002       number(10,0)      ,/* 版次 */
apga003       date      ,/* 開狀日期 */
apga004       varchar2(10)      ,/* 廠商(受益人) */
apga005       varchar2(20)      ,/* 業務人員 */
apga006       varchar2(10)      ,/* 付款類型 */
apga007       varchar2(15)      ,/* 開狀銀行 */
apga008       varchar2(10)      ,/* 信用狀類別 */
apga009       varchar2(1)      ,/* 保兌信用狀否 */
apga010       date      ,/* 信用狀有效日期 */
apga011       varchar2(20)      ,/* 許可證號 */
apga012       date      ,/* 承兌日期 */
apga013       varchar2(10)      ,/* 保兌費用支付方 */
apga014       varchar2(1)      ,/* 可否分批交運 */
apga015       number(20,6)      ,/* 自備款比率 */
apga016       number(10,6)      ,/* 融資利率 */
apga017       number(5,0)      ,/* 融資天數 */
apga018       varchar2(20)      ,/* 融資合約編號 */
apga019       date      ,/* 最後裝運日 */
apga020       varchar2(10)      ,/* 運送方式 */
apga021       varchar2(255)      ,/* 裝載港/機場 */
apga022       varchar2(255)      ,/* 卸載港/機場 */
apga023       date      ,/* E.T.D */
apga024       date      ,/* E.T.A */
apga025       varchar2(255)      ,/* 備註 */
apga026       varchar2(1)      ,/* 開狀時支付自備款 */
apga027       varchar2(20)      ,/* 自備款應付憑單號 */
apga028       varchar2(20)      ,/* 開狀費用應付憑單號 */
apga029       varchar2(1)      ,/* 結案否 */
apga030       varchar2(15)      ,/* 通知銀行 */
apga031       varchar2(20)      ,/* 保證金待抵單號 */
apga100       varchar2(10)      ,/* 幣別 */
apga101       number(20,10)      ,/* 開狀匯率 */
apga103       number(20,6)      ,/* 開狀原幣金額 */
apga104       number(20,6)      ,/* 自備款原幣金額 */
apga105       number(20,6)      ,/* 融資原幣金額 */
apga106       number(20,6)      ,/* 到單原幣金額 */
apga107       number(20,6)      ,/* 到貨原幣金額 */
apga108       number(20,6)      ,/* 保證金原幣金額 */
apga113       number(20,6)      ,/* 開狀本幣金額 */
apga114       number(20,6)      ,/* 自備款本幣金額 */
apga115       number(20,6)      ,/* 融資本幣金額 */
apgaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
apgaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
apgaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
apgaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
apgaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
apgaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
apgaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
apgaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
apgaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
apgaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
apgaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
apgaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
apgaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
apgaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
apgaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
apgaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
apgaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
apgaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
apgaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
apgaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
apgaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
apgaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
apgaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
apgaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
apgaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
apgaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
apgaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
apgaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
apgaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
apgaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table apga_t add constraint apga_pk primary key (apgaent,apgacomp,apgadocno) enable validate;

create unique index apga_pk on apga_t (apgaent,apgacomp,apgadocno);

grant select on apga_t to tiptop;
grant update on apga_t to tiptop;
grant delete on apga_t to tiptop;
grant insert on apga_t to tiptop;

exit;
