/* 
================================================================================
檔案代號:apcb_t
檔案名稱:應付憑單單身
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table apcb_t
(
apcbent       number(5)      ,/* 企業編號 */
apcbld       varchar2(5)      ,/* 帳別 */
apcblegl       varchar2(10)      ,/* 核算組織 */
apcborga       varchar2(10)      ,/* 帳務歸屬組織(來源組織) */
apcbsite       varchar2(10)      ,/* 應付帳務組織 */
apcbdocno       varchar2(20)      ,/* 單號 */
apcbseq       number(10,0)      ,/* 項次 */
apcb001       varchar2(20)      ,/* 來源類型 */
apcb002       varchar2(20)      ,/* 來源業務單據號碼 */
apcb003       number(10,0)      ,/* 來源業務單據項次 */
apcb004       varchar2(40)      ,/* 產品編號 */
apcb005       varchar2(255)      ,/* 品名規格 */
apcb006       varchar2(10)      ,/* 單位 */
apcb007       number(20,6)      ,/* 計價數量 */
apcb008       varchar2(20)      ,/* 參考單據號碼 */
apcb009       number(10,0)      ,/* 參考單據項次 */
apcb010       varchar2(10)      ,/* 業務部門 */
apcb011       varchar2(10)      ,/* 責任中心 */
apcb012       varchar2(10)      ,/* 產品類別 */
apcb013       varchar2(1)      ,/* 搭贈 */
apcb014       varchar2(10)      ,/* 理由碼 */
apcb015       varchar2(20)      ,/* 專案代號 */
apcb016       varchar2(30)      ,/* WBS編號 */
apcb017       varchar2(10)      ,/* 預算項目 */
apcb018       varchar2(10)      ,/* 專櫃編號 */
apcb019       varchar2(1)      ,/* 開票性質 */
apcb020       varchar2(10)      ,/* 稅別 */
apcb021       varchar2(24)      ,/* 費用會計科目 */
apcb022       number(5,0)      ,/* 正負值 */
apcb023       varchar2(1)      ,/* 沖暫估單否 */
apcb024       varchar2(10)      ,/* 區域 */
apcb025       varchar2(20)      ,/* 傳票號碼 */
apcb026       number(10,0)      ,/* 傳票項次 */
apcb027       varchar2(20)      ,/* 發票代碼 */
apcb028       varchar2(20)      ,/* 發票號碼 */
apcb029       varchar2(24)      ,/* 應付帳款科目 */
apcb030       varchar2(10)      ,/* 付款條件 */
apcb032       number(10,0)      ,/* 訂金序次 */
apcb033       varchar2(40)      ,/* 經營方式 */
apcb034       varchar2(40)      ,/* 渠道 */
apcb035       varchar2(40)      ,/* 品牌 */
apcb036       varchar2(40)      ,/* 客群 */
apcb037       varchar2(30)      ,/* 自由核算項一 */
apcb038       varchar2(30)      ,/* 自由核算項二 */
apcb039       varchar2(30)      ,/* 自由核算項三 */
apcb040       varchar2(30)      ,/* 自由核算項四 */
apcb041       varchar2(30)      ,/* 自由核算項五 */
apcb042       varchar2(30)      ,/* 自由核算項六 */
apcb043       varchar2(30)      ,/* 自由核算項七 */
apcb044       varchar2(30)      ,/* 自由核算項八 */
apcb045       varchar2(30)      ,/* 自由核算項九 */
apcb046       varchar2(30)      ,/* 自由核算項十 */
apcb047       varchar2(255)      ,/* 摘要 */
apcb048       varchar2(20)      ,/* 來源訂購單號 */
apcb049       varchar2(20)      ,/* 開票單號 */
apcb050       number(10,0)      ,/* 開票項次 */
apcb051       varchar2(20)      ,/* 業務人員 */
apcb100       varchar2(10)      ,/* 交易原幣 */
apcb101       number(20,6)      ,/* 交易原幣單價 */
apcb102       number(20,10)      ,/* 原幣匯率 */
apcb103       number(20,6)      ,/* 交易原幣未稅金額 */
apcb104       number(20,6)      ,/* 交易原幣稅額 */
apcb105       number(20,6)      ,/* 交易原幣含稅金額 */
apcb106       number(20,6)      ,/* NO USE */
apcb107       number(20,6)      ,/* NO USE */
apcb108       number(20,6)      ,/* 交易原幣成本認列金額 */
apcb111       number(20,6)      ,/* 本幣單價 */
apcb113       number(20,6)      ,/* 本幣未稅金額 */
apcb114       number(20,6)      ,/* 本幣稅額 */
apcb115       number(20,6)      ,/* 本幣含稅金額 */
apcb116       number(20,6)      ,/* NO USE */
apcb117       number(20,6)      ,/* NO USE */
apcb118       number(20,6)      ,/* 本幣成本認列金額 */
apcb119       number(20,6)      ,/* 應開發票含稅金額 */
apcb121       number(20,10)      ,/* 本位幣二匯率 */
apcb123       number(20,6)      ,/* 本位幣二未稅金額 */
apcb124       number(20,6)      ,/* 本位幣二稅額 */
apcb125       number(20,6)      ,/* 本位幣二含稅金額 */
apcb126       number(20,6)      ,/* NO USE */
apcb127       number(20,6)      ,/* NO USE */
apcb128       number(20,6)      ,/* 本位幣二成本認列金額 */
apcb131       number(20,10)      ,/* 本位幣三匯率 */
apcb133       number(20,6)      ,/* 本位幣三未稅金額 */
apcb134       number(20,6)      ,/* 本位幣三稅額 */
apcb135       number(20,6)      ,/* 本位幣三含稅金額 */
apcb136       number(20,6)      ,/* NO USE */
apcb137       number(20,6)      ,/* NO USE */
apcb138       number(20,6)      ,/* 本位幣三成本認列金額 */
apcbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
apcbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
apcbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
apcbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
apcbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
apcbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
apcbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
apcbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
apcbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
apcbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
apcbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
apcbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
apcbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
apcbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
apcbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
apcbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
apcbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
apcbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
apcbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
apcbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
apcbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
apcbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
apcbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
apcbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
apcbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
apcbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
apcbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
apcbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
apcbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
apcbud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
apcb052       number(20,6)      ,/* 稅額 */
apcb053       number(20,6)      /* 含稅金額 */
);
alter table apcb_t add constraint apcb_pk primary key (apcbent,apcbld,apcbdocno,apcbseq) enable validate;

create  index apcb_n1 on apcb_t (apcbent,apcbld,apcborga,apcb001,apcb002,apcb003);
create  index apcb_n2 on apcb_t (apcbent,apcbld,apcb049,apcb050);
create  index apcb_n3 on apcb_t (apcbent,apcbld,apcb048,apcb008);
create unique index apcb_pk on apcb_t (apcbent,apcbld,apcbdocno,apcbseq);

grant select on apcb_t to tiptop;
grant update on apcb_t to tiptop;
grant delete on apcb_t to tiptop;
grant insert on apcb_t to tiptop;

exit;
