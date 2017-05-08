/* 
================================================================================
檔案代號:glaq_t
檔案名稱:傳票憑證單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table glaq_t
(
glaqent       number(5)      ,/* 企業編號 */
glaqcomp       varchar2(10)      ,/* 法人 */
glaqld       varchar2(5)      ,/* 帳別 */
glaqdocno       varchar2(20)      ,/* 單號 */
glaqseq       number(10,0)      ,/* 項次 */
glaq001       varchar2(255)      ,/* 摘要 */
glaq002       varchar2(24)      ,/* 科目編號 */
glaq003       number(20,6)      ,/* 借方金額 */
glaq004       number(20,6)      ,/* 貸方金額 */
glaq005       varchar2(10)      ,/* 交易幣別 */
glaq006       number(20,10)      ,/* 匯率 */
glaq007       varchar2(10)      ,/* 計價單位 */
glaq008       number(20,6)      ,/* 數量 */
glaq009       number(20,6)      ,/* 單價 */
glaq010       number(20,6)      ,/* 原幣金額 */
glaq011       varchar2(20)      ,/* 票據編碼 */
glaq012       date      ,/* 票據日期 */
glaq013       varchar2(20)      ,/* 申請人 */
glaq014       varchar2(30)      ,/* 銀行帳號 */
glaq015       varchar2(10)      ,/* 款別編號 */
glaq016       varchar2(10)      ,/* 收支項目 */
glaq017       varchar2(10)      ,/* 營運據點 */
glaq018       varchar2(10)      ,/* 部門 */
glaq019       varchar2(10)      ,/* 利潤/成本中心 */
glaq020       varchar2(10)      ,/* 區域 */
glaq021       varchar2(10)      ,/* 交易客商 */
glaq022       varchar2(10)      ,/* 帳款客戶 */
glaq023       varchar2(10)      ,/* 客群 */
glaq024       varchar2(10)      ,/* 產品類別 */
glaq025       varchar2(20)      ,/* 人員 */
glaq026       varchar2(10)      ,/* no use */
glaq027       varchar2(20)      ,/* 專案編號 */
glaq028       varchar2(30)      ,/* WBS */
glaq029       varchar2(30)      ,/* 自由核算項一 */
glaq030       varchar2(30)      ,/* 自由核算項二 */
glaq031       varchar2(30)      ,/* 自由核算項三 */
glaq032       varchar2(30)      ,/* 自由核算項四 */
glaq033       varchar2(30)      ,/* 自由核算項五 */
glaq034       varchar2(30)      ,/* 自由核算項六 */
glaq035       varchar2(30)      ,/* 自由核算項七 */
glaq036       varchar2(30)      ,/* 自由核算項八 */
glaq037       varchar2(30)      ,/* 自由核算項九 */
glaq038       varchar2(30)      ,/* 自由核算項十 */
glaq039       number(20,10)      ,/* 匯率(本位幣二) */
glaq040       number(20,6)      ,/* 借方金額(本位幣二) */
glaq041       number(20,6)      ,/* 貸方金額(本位幣二) */
glaq042       number(20,10)      ,/* 匯率(本位幣三) */
glaq043       number(20,6)      ,/* 借方金額(本位幣三) */
glaq044       number(20,6)      ,/* 貸方金額(本位幣三) */
glaq051       varchar2(10)      ,/* 經營方式 */
glaq052       varchar2(10)      ,/* 渠道 */
glaq053       varchar2(10)      ,/* 品牌 */
glaqud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
glaqud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
glaqud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
glaqud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
glaqud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
glaqud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
glaqud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
glaqud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
glaqud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
glaqud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
glaqud011       number(20,6)      ,/* 自定義欄位(數字)011 */
glaqud012       number(20,6)      ,/* 自定義欄位(數字)012 */
glaqud013       number(20,6)      ,/* 自定義欄位(數字)013 */
glaqud014       number(20,6)      ,/* 自定義欄位(數字)014 */
glaqud015       number(20,6)      ,/* 自定義欄位(數字)015 */
glaqud016       number(20,6)      ,/* 自定義欄位(數字)016 */
glaqud017       number(20,6)      ,/* 自定義欄位(數字)017 */
glaqud018       number(20,6)      ,/* 自定義欄位(數字)018 */
glaqud019       number(20,6)      ,/* 自定義欄位(數字)019 */
glaqud020       number(20,6)      ,/* 自定義欄位(數字)020 */
glaqud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
glaqud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
glaqud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
glaqud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
glaqud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
glaqud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
glaqud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
glaqud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
glaqud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
glaqud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table glaq_t add constraint glaq_pk primary key (glaqent,glaqld,glaqdocno,glaqseq) enable validate;

create unique index glaq_pk on glaq_t (glaqent,glaqld,glaqdocno,glaqseq);

grant select on glaq_t to tiptop;
grant update on glaq_t to tiptop;
grant delete on glaq_t to tiptop;
grant insert on glaq_t to tiptop;

exit;
