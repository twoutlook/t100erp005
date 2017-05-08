/* 
================================================================================
檔案代號:nmbt_t
檔案名稱:帳務底稿明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table nmbt_t
(
nmbtent       number(5)      ,/* 企業編號 */
nmbtcomp       varchar2(10)      ,/* 法人 */
nmbtld       varchar2(5)      ,/* 帳別(套)編號 */
nmbtdocno       varchar2(20)      ,/* 帳務編號 */
nmbtseq       number(10,0)      ,/* 項次 */
nmbt001       varchar2(10)      ,/* 單據來源 */
nmbt002       varchar2(20)      ,/* 來源單號 */
nmbt003       number(10,0)      ,/* 來源單項次 */
nmbt011       varchar2(20)      ,/* 票據號碼 */
nmbt012       date      ,/* 票據日期 */
nmbt013       varchar2(20)      ,/* 申請人 */
nmbt014       varchar2(30)      ,/* 銀行帳號 */
nmbt015       varchar2(10)      ,/* 結算方式 */
nmbt016       varchar2(10)      ,/* 收支項目 */
nmbt017       varchar2(10)      ,/* 營運據點 */
nmbt018       varchar2(10)      ,/* 部門 */
nmbt019       varchar2(10)      ,/* 利潤/成本中心 */
nmbt020       varchar2(10)      ,/* 區域 */
nmbt021       varchar2(10)      ,/* 交易客商 */
nmbt022       varchar2(10)      ,/* 帳款客商 */
nmbt023       varchar2(10)      ,/* 客群 */
nmbt024       varchar2(10)      ,/* 產品類別 */
nmbt025       varchar2(20)      ,/* 人員 */
nmbt026       varchar2(10)      ,/* 預算編號 */
nmbt027       varchar2(20)      ,/* 專案編號 */
nmbt028       varchar2(30)      ,/* WBS */
nmbt029       varchar2(24)      ,/* 科目 */
nmbt030       varchar2(24)      ,/* 對方科目 */
nmbt031       varchar2(10)      ,/* 經營方式 */
nmbt032       varchar2(10)      ,/* 渠道 */
nmbt033       varchar2(10)      ,/* 品牌 */
nmbt034       varchar2(30)      ,/* 自由核算項一 */
nmbt035       varchar2(30)      ,/* 自由核算項二 */
nmbt036       varchar2(30)      ,/* 自由核算項三 */
nmbt037       varchar2(30)      ,/* 自由核算項四 */
nmbt038       varchar2(30)      ,/* 自由核算項五 */
nmbt039       varchar2(30)      ,/* 自由核算項六 */
nmbt040       varchar2(30)      ,/* 自由核算項七 */
nmbt041       varchar2(30)      ,/* 自由核算項八 */
nmbt042       varchar2(30)      ,/* 自由核算項九 */
nmbt043       varchar2(30)      ,/* 自由核算項十 */
nmbt100       varchar2(10)      ,/* 幣別 */
nmbt101       number(20,10)      ,/* 匯率 */
nmbt103       number(20,6)      ,/* 原幣金額 */
nmbt113       number(20,6)      ,/* 本幣金額 */
nmbt121       number(20,10)      ,/* 本位幣二匯率 */
nmbt123       number(20,6)      ,/* 本位幣二金額 */
nmbt131       number(20,10)      ,/* 本位幣三匯率 */
nmbt133       number(20,6)      ,/* 本位幣三金額 */
nmbtud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
nmbtud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
nmbtud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
nmbtud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
nmbtud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
nmbtud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
nmbtud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
nmbtud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
nmbtud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
nmbtud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
nmbtud011       number(20,6)      ,/* 自定義欄位(數字)011 */
nmbtud012       number(20,6)      ,/* 自定義欄位(數字)012 */
nmbtud013       number(20,6)      ,/* 自定義欄位(數字)013 */
nmbtud014       number(20,6)      ,/* 自定義欄位(數字)014 */
nmbtud015       number(20,6)      ,/* 自定義欄位(數字)015 */
nmbtud016       number(20,6)      ,/* 自定義欄位(數字)016 */
nmbtud017       number(20,6)      ,/* 自定義欄位(數字)017 */
nmbtud018       number(20,6)      ,/* 自定義欄位(數字)018 */
nmbtud019       number(20,6)      ,/* 自定義欄位(數字)019 */
nmbtud020       number(20,6)      ,/* 自定義欄位(數字)020 */
nmbtud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
nmbtud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
nmbtud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
nmbtud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
nmbtud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
nmbtud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
nmbtud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
nmbtud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
nmbtud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
nmbtud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
nmbt004       varchar2(10)      ,/* 異動別 */
nmbt114       number(20,6)      /* 開立金額 */
);
alter table nmbt_t add constraint nmbt_pk primary key (nmbtent,nmbtld,nmbtdocno,nmbtseq) enable validate;

create unique index nmbt_pk on nmbt_t (nmbtent,nmbtld,nmbtdocno,nmbtseq);

grant select on nmbt_t to tiptop;
grant update on nmbt_t to tiptop;
grant delete on nmbt_t to tiptop;
grant insert on nmbt_t to tiptop;

exit;
