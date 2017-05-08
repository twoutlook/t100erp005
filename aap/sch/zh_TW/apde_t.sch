/* 
================================================================================
檔案代號:apde_t
檔案名稱:付款及差異處理明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table apde_t
(
apdeent       number(5)      ,/* 企業代碼 */
apdecomp       varchar2(10)      ,/* 法人 */
apdeld       varchar2(5)      ,/* 帳套 */
apdedocno       varchar2(20)      ,/* 沖銷單單號 */
apdeseq       number(10,0)      ,/* 項次 */
apdesite       varchar2(10)      ,/* 帳務中心 */
apdeorga       varchar2(10)      ,/* 帳務歸屬組織 */
apde001       varchar2(20)      ,/* 來源作業 */
apde002       varchar2(10)      ,/* 沖銷帳款類型 */
apde003       varchar2(20)      ,/* 已付款單號 */
apde004       number(10,0)      ,/* 沖銷單項次 */
apde006       varchar2(10)      ,/* 款別代碼 */
apde008       varchar2(20)      ,/* 帳戶/票券號碼 */
apde009       varchar2(1)      ,/* 已轉資料 */
apde010       varchar2(255)      ,/* 摘要說明 */
apde011       varchar2(10)      ,/* 銀行存提碼 */
apde012       varchar2(10)      ,/* 現金變動碼 */
apde013       varchar2(10)      ,/* 轉入客商碼 */
apde014       varchar2(20)      ,/* 轉入帳款單編號 */
apde015       varchar2(1)      ,/* 沖銷加減項 */
apde016       varchar2(24)      ,/* 沖銷會科 */
apde017       varchar2(20)      ,/* 業務人員 */
apde018       varchar2(10)      ,/* 業務部門 */
apde019       varchar2(10)      ,/* 責任中心 */
apde020       varchar2(10)      ,/* 產品類別 */
apde021       varchar2(10)      ,/* 票據類型 */
apde022       varchar2(20)      ,/* 專案編號 */
apde023       varchar2(30)      ,/* WBS編號 */
apde024       varchar2(20)      ,/* 票據號碼 */
apde028       varchar2(1)      ,/* 產生方式 */
apde029       varchar2(20)      ,/* 傳票號碼 */
apde030       number(10,0)      ,/* 傳票項次 */
apde032       date      ,/* 付款日 */
apde035       varchar2(10)      ,/* 區域 */
apde036       varchar2(10)      ,/* 客群 */
apde038       varchar2(10)      ,/* 對象 */
apde039       varchar2(15)      ,/* 受款銀行 */
apde040       varchar2(30)      ,/* 受款帳號 */
apde041       varchar2(255)      ,/* 受款人全名 */
apde042       varchar2(10)      ,/* 經營方式 */
apde043       varchar2(10)      ,/* 渠道 */
apde044       varchar2(10)      ,/* 品牌 */
apde045       varchar2(255)      ,/* 摘要 */
apde046       varchar2(20)      ,/* 付款申請單 */
apde047       number(10,0)      ,/* 付款申請單項次 */
apde051       varchar2(30)      ,/* 自由核算項一 */
apde052       varchar2(30)      ,/* 自由核算項二 */
apde053       varchar2(30)      ,/* 自由核算項三 */
apde054       varchar2(30)      ,/* 自由核算項四 */
apde055       varchar2(30)      ,/* 自由核算項五 */
apde056       varchar2(30)      ,/* 自由核算項六 */
apde057       varchar2(30)      ,/* 自由核算項七 */
apde058       varchar2(30)      ,/* 自由核算項八 */
apde059       varchar2(30)      ,/* 自由核算項九 */
apde060       varchar2(30)      ,/* 自由核算項十 */
apde100       varchar2(10)      ,/* 幣別 */
apde101       number(20,10)      ,/* 匯率 */
apde104       number(20,6)      ,/* 原幣應稅折抵稅額 */
apde109       number(20,6)      ,/* 原幣沖帳金額 */
apde119       number(20,6)      ,/* 本幣沖帳金額 */
apde120       varchar2(10)      ,/* 本位幣二幣別 */
apde121       number(20,10)      ,/* 本位幣二匯率 */
apde129       number(20,6)      ,/* 本位幣二沖帳金額 */
apde130       varchar2(10)      ,/* 本位幣三幣別 */
apde131       number(20,10)      ,/* 本位幣三匯率 */
apde139       number(20,6)      ,/* 本位幣三沖帳金額 */
apdeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
apdeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
apdeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
apdeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
apdeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
apdeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
apdeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
apdeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
apdeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
apdeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
apdeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
apdeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
apdeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
apdeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
apdeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
apdeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
apdeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
apdeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
apdeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
apdeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
apdeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
apdeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
apdeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
apdeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
apdeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
apdeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
apdeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
apdeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
apdeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
apdeud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table apde_t add constraint apde_pk primary key (apdeent,apdeld,apdedocno,apdeseq) enable validate;

create  index apde_n1 on apde_t (apdeent,apdeld,apde002,apde003,apde008,apde009);
create  index apde_n2 on apde_t (apdeent,apdeld,apde002,apde013,apde014,apde009);
create  index apde_n3 on apde_t (apdeent,apdeld,apde029,apde030,apde016);
create unique index apde_pk on apde_t (apdeent,apdeld,apdedocno,apdeseq);

grant select on apde_t to tiptop;
grant update on apde_t to tiptop;
grant delete on apde_t to tiptop;
grant insert on apde_t to tiptop;

exit;
