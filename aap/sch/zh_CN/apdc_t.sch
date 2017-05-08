/* 
================================================================================
檔案代號:apdc_t
檔案名稱:費用分攤目的明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table apdc_t
(
apdcent       number(5)      ,/* 企業代碼 */
apdccomp       varchar2(10)      ,/* 法人 */
apdcsite       varchar2(10)      ,/* 帳務組織 */
apdcld       varchar2(5)      ,/* 帳別 */
apdcdocno       varchar2(20)      ,/* 攤銷單號 */
apdcseq       number(10,0)      ,/* 攤銷單項次 */
apdcorga       varchar2(10)      ,/* 來源歸屬組織 */
apdc001       varchar2(10)      ,/* 攤銷至目的方式 */
apdc002       varchar2(20)      ,/* 交易單號(入庫單) */
apdc003       number(10,0)      ,/* 交易單項次 */
apdc004       varchar2(40)      ,/* 產品編號 */
apdc005       varchar2(20)      ,/* 目的帳款單號 */
apdc006       number(10,0)      ,/* 目的帳款單項次 */
apdc007       varchar2(24)      ,/* 目的會計科目 */
apdc008       number(20,6)      ,/* 數量 */
apdc009       varchar2(10)      ,/* 分攤金額方式 */
apdc111       number(20,6)      ,/* 本幣分攤前單價 */
apdc113       number(20,6)      ,/* 本幣分攤前金額 */
apdc211       number(20,6)      ,/* 本幣分攤後單價 */
apdc213       number(20,6)      ,/* 本幣分攤後金額 */
apdc123       number(20,6)      ,/* 本位幣二分攤前金額 */
apdc223       number(20,6)      ,/* 本位幣二分攤後金額 */
apdc133       number(20,6)      ,/* 本位幣三分攤前金額 */
apdc233       number(20,6)      ,/* 本位幣三分攤後金額 */
apdc015       varchar2(1)      ,/* 沖銷加減項 */
apdc017       varchar2(20)      ,/* 業務人員 */
apdc018       varchar2(10)      ,/* 業務部門 */
apdc019       varchar2(10)      ,/* 責任中心 */
apdc020       varchar2(10)      ,/* 產品類別 */
apdc022       varchar2(20)      ,/* 專案代號 */
apdc023       varchar2(30)      ,/* WBS編號 */
apdc024       varchar2(10)      ,/* 區域 */
apdc025       varchar2(10)      ,/* 客戶分類 */
apdc026       varchar2(10)      ,/* 帳款對象 */
apdc027       varchar2(10)      ,/* 經營方式 */
apdc028       varchar2(10)      ,/* 渠道 */
apdc029       varchar2(10)      ,/* 品牌 */
apdc031       varchar2(30)      ,/* 自由核算項一 */
apdc032       varchar2(30)      ,/* 自由核算項二 */
apdc033       varchar2(30)      ,/* 自由核算項三 */
apdc034       varchar2(30)      ,/* 自由核算項四 */
apdc035       varchar2(30)      ,/* 自由核算項五 */
apdc036       varchar2(30)      ,/* 自由核算項六 */
apdc037       varchar2(30)      ,/* 自由核算項七 */
apdc038       varchar2(30)      ,/* 自由核算項八 */
apdc039       varchar2(30)      ,/* 自由核算項九 */
apdc040       varchar2(30)      ,/* 自由核算項十 */
apdc041       varchar2(255)      ,/* 摘要說明 */
apdcud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
apdcud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
apdcud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
apdcud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
apdcud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
apdcud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
apdcud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
apdcud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
apdcud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
apdcud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
apdcud011       number(20,6)      ,/* 自定義欄位(數字)011 */
apdcud012       number(20,6)      ,/* 自定義欄位(數字)012 */
apdcud013       number(20,6)      ,/* 自定義欄位(數字)013 */
apdcud014       number(20,6)      ,/* 自定義欄位(數字)014 */
apdcud015       number(20,6)      ,/* 自定義欄位(數字)015 */
apdcud016       number(20,6)      ,/* 自定義欄位(數字)016 */
apdcud017       number(20,6)      ,/* 自定義欄位(數字)017 */
apdcud018       number(20,6)      ,/* 自定義欄位(數字)018 */
apdcud019       number(20,6)      ,/* 自定義欄位(數字)019 */
apdcud020       number(20,6)      ,/* 自定義欄位(數字)020 */
apdcud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
apdcud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
apdcud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
apdcud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
apdcud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
apdcud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
apdcud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
apdcud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
apdcud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
apdcud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table apdc_t add constraint apdc_pk primary key (apdcent,apdcld,apdcdocno,apdcseq) enable validate;

create unique index apdc_pk on apdc_t (apdcent,apdcld,apdcdocno,apdcseq);

grant select on apdc_t to tiptop;
grant update on apdc_t to tiptop;
grant delete on apdc_t to tiptop;
grant insert on apdc_t to tiptop;

exit;
