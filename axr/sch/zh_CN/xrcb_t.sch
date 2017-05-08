/* 
================================================================================
檔案代號:xrcb_t
檔案名稱:應收憑單單身
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table xrcb_t
(
xrcbent       number(5)      ,/* 企業編號 */
xrcbld       varchar2(5)      ,/* 帳別 */
xrcbdocno       varchar2(20)      ,/* 單號 */
xrcbseq       number(10,0)      ,/* 項次 */
xrcbsite       varchar2(10)      ,/* 營運據點 */
xrcborga       varchar2(10)      ,/* 帳務來源SITE */
xrcb001       varchar2(20)      ,/* 來源類型 */
xrcb002       varchar2(20)      ,/* 來源業務單據號碼 */
xrcb003       number(10,0)      ,/* 來源業務單據項次 */
xrcb004       varchar2(40)      ,/* 產品編號 */
xrcb005       varchar2(255)      ,/* 品名規格 */
xrcb006       varchar2(10)      ,/* 單位 */
xrcb007       number(20,6)      ,/* 計價數量 */
xrcb008       varchar2(20)      ,/* 參考單據號碼 */
xrcb009       number(10,0)      ,/* 參考單號項次 */
xrcblegl       varchar2(10)      ,/* 核算組織 */
xrcb010       varchar2(10)      ,/* 業務部門 */
xrcb011       varchar2(10)      ,/* 責任中心 */
xrcb012       varchar2(10)      ,/* 產品類別 */
xrcb013       varchar2(1)      ,/* 發票帳否(搭贈/備品/樣品) */
xrcb014       varchar2(10)      ,/* 理由碼 */
xrcb015       varchar2(20)      ,/* 專案代號 */
xrcb016       varchar2(30)      ,/* WBS編號 */
xrcb017       varchar2(10)      ,/* 預算項目 */
xrcb018       varchar2(40)      ,/* 商戶編號 */
xrcb019       varchar2(1)      ,/* 開票性質 */
xrcb020       varchar2(10)      ,/* 稅別 */
xrcb021       varchar2(24)      ,/* 收入會計科目 */
xrcb022       number(5,0)      ,/* 正負值 */
xrcb023       varchar2(1)      ,/* 衝暫估單否 */
xrcb024       varchar2(10)      ,/* 區域 */
xrcb025       varchar2(20)      ,/* 傳票號碼 */
xrcb026       number(10,0)      ,/* 傳票項次 */
xrcb027       varchar2(20)      ,/* 發票代碼 */
xrcb028       varchar2(20)      ,/* 發票號碼 */
xrcb029       varchar2(24)      ,/* 應收帳款科目 */
xrcb030       number(20,6)      ,/* 已開發票數量 */
xrcb031       varchar2(10)      ,/* 收款條件編號 */
xrcb032       number(10,0)      ,/* 訂金序次 */
xrcb033       varchar2(40)      ,/* 經營方式 */
xrcb034       varchar2(40)      ,/* 渠道 */
xrcb035       varchar2(40)      ,/* 品牌 */
xrcb036       varchar2(40)      ,/* 客群 */
xrcb037       varchar2(30)      ,/* 自由核算項一 */
xrcb038       varchar2(30)      ,/* 自由核算項二 */
xrcb039       varchar2(30)      ,/* 自由核算項三 */
xrcb040       varchar2(30)      ,/* 自由核算項四 */
xrcb041       varchar2(30)      ,/* 自由核算項五 */
xrcb042       varchar2(30)      ,/* 自由核算項六 */
xrcb043       varchar2(30)      ,/* 自由核算項七 */
xrcb044       varchar2(30)      ,/* 自由核算項八 */
xrcb045       varchar2(30)      ,/* 自由核算項九 */
xrcb046       varchar2(30)      ,/* 自由核算項十 */
xrcb047       varchar2(255)      ,/* 摘要 */
xrcb048       varchar2(20)      ,/* 客戶訂購單號 */
xrcb049       varchar2(20)      ,/* 開票單號 */
xrcb050       number(10,0)      ,/* 開票項次 */
xrcb051       varchar2(20)      ,/* 業務人員 */
xrcb100       varchar2(10)      ,/* 交易原幣 */
xrcb101       number(20,6)      ,/* 交易原幣單價 */
xrcb102       number(20,10)      ,/* 交易匯率 */
xrcb103       number(20,6)      ,/* 交易原幣未稅金額 */
xrcb104       number(20,6)      ,/* 交易原幣稅額 */
xrcb105       number(20,6)      ,/* 交易原幣含稅金額 */
xrcb106       number(20,6)      ,/* 交易原幣調整差異金額 */
xrcb111       number(20,6)      ,/* 本幣單價 */
xrcb113       number(20,6)      ,/* 本幣未稅金額 */
xrcb114       number(20,6)      ,/* 本幣稅額 */
xrcb115       number(20,6)      ,/* 本幣含稅金額 */
xrcb116       number(20,6)      ,/* 本幣調整差異金額 */
xrcb117       number(20,6)      ,/* 已開發票金額(未稅) */
xrcb118       number(20,6)      ,/* 應開發票未稅金額 */
xrcb119       number(20,6)      ,/* 應開發票含稅金額 */
xrcb121       number(20,10)      ,/* 本位幣二匯率 */
xrcb123       number(20,6)      ,/* 本位幣二未稅金額 */
xrcb124       number(20,6)      ,/* 本位幣二稅額 */
xrcb125       number(20,6)      ,/* 本位幣二含稅金額 */
xrcb126       number(20,6)      ,/* 本位幣二調整差異金額 */
xrcb131       number(20,10)      ,/* 本位幣三匯率 */
xrcb133       number(20,6)      ,/* 本位幣三未稅金額 */
xrcb134       number(20,6)      ,/* 本位幣三稅額 */
xrcb135       number(20,6)      ,/* 本位幣三含稅金額 */
xrcb136       number(20,6)      ,/* 本位幣三調整差異金額 */
xrcbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xrcbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xrcbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xrcbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xrcbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xrcbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xrcbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xrcbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xrcbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xrcbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xrcbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xrcbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xrcbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xrcbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xrcbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xrcbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xrcbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xrcbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xrcbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xrcbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xrcbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xrcbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xrcbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xrcbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xrcbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xrcbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xrcbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xrcbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xrcbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xrcbud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xrcb_t add constraint xrcb_pk primary key (xrcbent,xrcbld,xrcbdocno,xrcbseq) enable validate;

create  index xrcb_01 on xrcb_t (xrcbsite,xrcb001,xrcb002,xrcb004,xrcb010,xrcb011,xrcb012,xrcb014,xrcb015,xrcborga);
create  index xrcb_n1 on xrcb_t (xrcbent,xrcbld,xrcborga,xrcb001,xrcb002,xrcb003);
create  index xrcb_n2 on xrcb_t (xrcbent,xrcbld,xrcb049,xrcb050);
create  index xrcb_n3 on xrcb_t (xrcbent,xrcbld,xrcb048,xrcb008);
create unique index xrcb_pk on xrcb_t (xrcbent,xrcbld,xrcbdocno,xrcbseq);

grant select on xrcb_t to tiptop;
grant update on xrcb_t to tiptop;
grant delete on xrcb_t to tiptop;
grant insert on xrcb_t to tiptop;

exit;
