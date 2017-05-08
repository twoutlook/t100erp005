/* 
================================================================================
檔案代號:apce_t
檔案名稱:應付沖帳明細
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table apce_t
(
apceent       number(5)      ,/* 企業編號 */
apcecomp       varchar2(10)      ,/* 法人 */
apcelegl       varchar2(10)      ,/* 核算組織 */
apcesite       varchar2(10)      ,/* 帳務組織 */
apceld       varchar2(5)      ,/* 帳別 */
apceorga       varchar2(10)      ,/* 帳務歸屬組織 */
apcedocno       varchar2(20)      ,/* 沖銷單單號 */
apceseq       number(10,0)      ,/* 項次 */
apce001       varchar2(10)      ,/* 來源作業 */
apce002       varchar2(20)      ,/* 沖銷類型 */
apce003       varchar2(20)      ,/* 沖銷帳款單單號 */
apce004       number(10,0)      ,/* 沖銷帳款單項次 */
apce005       number(10,0)      ,/* 分期帳款序 */
apce006       varchar2(10)      ,/* no use */
apce007       number(20,6)      ,/* no use */
apce008       varchar2(20)      ,/* 票據號碼/ 現金銀存帳戶 */
apce009       varchar2(1)      ,/* no use */
apce010       varchar2(255)      ,/* 摘要說明 */
apce011       varchar2(10)      ,/* 理由碼 */
apce012       varchar2(10)      ,/* 銀存存提碼 */
apce013       varchar2(10)      ,/* 現金異動碼 */
apce014       varchar2(20)      ,/* no use */
apce015       varchar2(1)      ,/* 沖銷加減項 */
apce016       varchar2(24)      ,/* 沖銷科目 */
apce017       varchar2(20)      ,/* 業務人員 */
apce018       varchar2(10)      ,/* 業務部門 */
apce019       varchar2(10)      ,/* 責任中心 */
apce020       varchar2(10)      ,/* 產品類別 */
apce021       varchar2(10)      ,/* no use */
apce022       varchar2(20)      ,/* 專案代號 */
apce023       varchar2(30)      ,/* WBS編號 */
apce024       varchar2(20)      ,/* 第二參考單號 */
apce025       number(10,0)      ,/* 第二參考單號項次 */
apce026       varchar2(10)      ,/* no use */
apce027       varchar2(1)      ,/* 應稅折抵否 */
apce028       varchar2(1)      ,/* 產生方式 */
apce029       varchar2(20)      ,/* 傳票號碼 */
apce030       number(10,0)      ,/* 傳票項次 */
apce031       date      ,/* 付款(票)到期日 */
apce032       date      ,/* 應付款日 */
apce033       varchar2(20)      ,/* no use */
apce034       date      ,/* no use */
apce035       varchar2(10)      ,/* 區域 */
apce036       varchar2(10)      ,/* 客戶分類 */
apce037       varchar2(10)      ,/* no use */
apce038       varchar2(10)      ,/* 帳款對象 */
apce039       varchar2(15)      ,/* no use */
apce040       varchar2(30)      ,/* no use */
apce041       varchar2(255)      ,/* no use */
apce042       varchar2(40)      ,/* no use */
apce043       varchar2(40)      ,/* no use */
apce044       varchar2(10)      ,/* 經營方式 */
apce045       varchar2(10)      ,/* 渠道 */
apce046       varchar2(10)      ,/* 品牌 */
apce047       varchar2(20)      ,/* 發票代碼 */
apce048       varchar2(20)      ,/* 發票號碼 */
apce049       varchar2(20)      ,/* 付款申請單號碼 */
apce050       number(10,0)      ,/* 付款申請單項次 */
apce051       varchar2(30)      ,/* 自由核算項一 */
apce052       varchar2(30)      ,/* 自由核算項二 */
apce053       varchar2(30)      ,/* 自由核算項三 */
apce054       varchar2(30)      ,/* 自由核算項四 */
apce055       varchar2(30)      ,/* 自由核算項五 */
apce056       varchar2(30)      ,/* 自由核算項六 */
apce057       varchar2(30)      ,/* 自由核算項七 */
apce058       varchar2(30)      ,/* 自由核算項八 */
apce059       varchar2(30)      ,/* 自由核算項九 */
apce060       varchar2(30)      ,/* 自由核算項十 */
apce100       varchar2(10)      ,/* 幣別 */
apce101       number(20,10)      ,/* 匯率 */
apce104       number(20,6)      ,/* 原幣應稅折抵稅額 */
apce109       number(20,6)      ,/* 原幣沖帳金額 */
apce114       number(20,6)      ,/* 本幣應稅折抵稅額 */
apce119       number(20,6)      ,/* 本幣沖帳金額 */
apce120       varchar2(10)      ,/* 本位幣二幣別 */
apce124       number(20,6)      ,/* 本位幣二應稅折抵稅額 */
apce121       number(20,10)      ,/* 本位幣二匯率 */
apce129       number(20,6)      ,/* 本位幣二沖帳金額 */
apce130       varchar2(10)      ,/* 本位幣三幣別 */
apce131       number(20,10)      ,/* 本位幣三匯率 */
apce134       number(20,6)      ,/* 本位幣三應稅折抵稅額 */
apce139       number(20,6)      ,/* 本位幣三沖帳金額 */
apceud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
apceud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
apceud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
apceud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
apceud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
apceud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
apceud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
apceud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
apceud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
apceud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
apceud011       number(20,6)      ,/* 自定義欄位(數字)011 */
apceud012       number(20,6)      ,/* 自定義欄位(數字)012 */
apceud013       number(20,6)      ,/* 自定義欄位(數字)013 */
apceud014       number(20,6)      ,/* 自定義欄位(數字)014 */
apceud015       number(20,6)      ,/* 自定義欄位(數字)015 */
apceud016       number(20,6)      ,/* 自定義欄位(數字)016 */
apceud017       number(20,6)      ,/* 自定義欄位(數字)017 */
apceud018       number(20,6)      ,/* 自定義欄位(數字)018 */
apceud019       number(20,6)      ,/* 自定義欄位(數字)019 */
apceud020       number(20,6)      ,/* 自定義欄位(數字)020 */
apceud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
apceud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
apceud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
apceud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
apceud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
apceud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
apceud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
apceud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
apceud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
apceud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table apce_t add constraint apce_pk primary key (apceent,apceld,apcedocno,apceseq) enable validate;

create  index apce_01 on apce_t (apce001,apce003,apce004,apce005);
create  index apce_02 on apce_t (apce002,apce006,apce008,apce009,apce031,apce032);
create  index apce_03 on apce_t (apce015,apce016);
create  index apce_04 on apce_t (apce024,apce025);
create  index apce_05 on apce_t (apce003,apce004,apce034);
create unique index apce_pk on apce_t (apceent,apceld,apcedocno,apceseq);

grant select on apce_t to tiptop;
grant update on apce_t to tiptop;
grant delete on apce_t to tiptop;
grant insert on apce_t to tiptop;

exit;
