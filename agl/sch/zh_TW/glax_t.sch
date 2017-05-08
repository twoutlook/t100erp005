/* 
================================================================================
檔案代號:glax_t
檔案名稱:傳票項次立帳異動檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table glax_t
(
glaxent       number(5)      ,/* 企業編號 */
glaxownid       varchar2(20)      ,/* 資料所有者 */
glaxowndp       varchar2(10)      ,/* 資料所屬部門 */
glaxcrtid       varchar2(20)      ,/* 資料建立者 */
glaxcrtdp       varchar2(10)      ,/* 資料建立部門 */
glaxcrtdt       timestamp(0)      ,/* 資料創建日 */
glaxmodid       varchar2(20)      ,/* 資料修改者 */
glaxmoddt       timestamp(0)      ,/* 最近修改日 */
glaxcnfid       varchar2(20)      ,/* 資料確認者 */
glaxcnfdt       timestamp(0)      ,/* 資料確認日 */
glaxstus       varchar2(10)      ,/* 狀態碼 */
glaxld       varchar2(5)      ,/* 帳套 */
glaxcomp       varchar2(10)      ,/* 法人 */
glaxdocno       varchar2(20)      ,/* 單號 */
glaxseq       number(10,0)      ,/* 項次 */
glaxdocdt       date      ,/* 單據日期 */
glax001       varchar2(255)      ,/* 摘要 */
glax002       varchar2(24)      ,/* 科目編號 */
glax003       number(20,6)      ,/* 本幣立帳金額 */
glax005       varchar2(10)      ,/* 交易幣別 */
glax006       number(20,10)      ,/* 匯率 */
glax007       varchar2(10)      ,/* 計價單位 */
glax008       number(20,6)      ,/* 立帳數量 */
glax009       number(20,6)      ,/* 單價 */
glax010       number(20,6)      ,/* 原幣立帳金額 */
glax011       varchar2(20)      ,/* 票據號碼 */
glax012       date      ,/* 票據日期 */
glax013       varchar2(20)      ,/* 申請人 */
glax014       varchar2(30)      ,/* 銀行帳號 */
glax015       varchar2(10)      ,/* 結算方式 */
glax016       varchar2(10)      ,/* 收支專案 */
glax017       varchar2(10)      ,/* 營運據點 */
glax018       varchar2(10)      ,/* 部門 */
glax019       varchar2(10)      ,/* 利潤/成本中心 */
glax020       varchar2(10)      ,/* 區域 */
glax021       varchar2(10)      ,/* 收付款客商 */
glax022       varchar2(10)      ,/* 帳款客商 */
glax023       varchar2(10)      ,/* 客群 */
glax024       varchar2(10)      ,/* 產品類別 */
glax025       varchar2(20)      ,/* 人員 */
glax026       varchar2(10)      ,/* no use */
glax027       varchar2(20)      ,/* 專案編號 */
glax028       varchar2(30)      ,/* WBS */
glax029       varchar2(30)      ,/* 自由核算項一 */
glax030       varchar2(30)      ,/* 自由核算項二 */
glax031       varchar2(30)      ,/* 自由核算項三 */
glax032       varchar2(30)      ,/* 自由核算項四 */
glax033       varchar2(30)      ,/* 自由核算項五 */
glax034       varchar2(30)      ,/* 自由核算項六 */
glax035       varchar2(30)      ,/* 自由核算項七 */
glax036       varchar2(30)      ,/* 自由核算項八 */
glax037       varchar2(30)      ,/* 自由核算項九 */
glax038       varchar2(30)      ,/* 自由核算項十 */
glax041       number(20,6)      ,/* 本幣預沖金額 */
glax042       number(20,6)      ,/* 本幣已沖金額 */
glax043       number(20,6)      ,/* 預沖數量 */
glax044       number(20,6)      ,/* 已沖數量 */
glax045       number(20,6)      ,/* 原幣預沖金額 */
glax046       number(20,6)      ,/* 原幣已沖金額 */
glax047       varchar2(1)      ,/* 資料來源 */
glax048       varchar2(20)      ,/* 原始憑證號碼 */
glax049       number(5,0)      ,/* 會計年度 */
glax050       number(5,0)      ,/* 會計期別 */
glax051       number(20,10)      ,/* 匯率(本位幣二) */
glax052       number(20,6)      ,/* 立帳金額(本位幣二) */
glax053       number(20,6)      ,/* 預沖金額(本位幣二) */
glax054       number(20,6)      ,/* 已沖金額(本位幣二) */
glax055       number(20,10)      ,/* 匯率(本位幣三) */
glax056       number(20,6)      ,/* 立帳金額(本位幣三) */
glax057       number(20,6)      ,/* 預沖金額(本位幣三) */
glax058       number(20,6)      ,/* 已沖金額(本位幣三) */
glax061       varchar2(10)      ,/* 經營方式 */
glax062       varchar2(10)      ,/* 通路 */
glax063       varchar2(10)      ,/* 品牌 */
glaxud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
glaxud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
glaxud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
glaxud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
glaxud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
glaxud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
glaxud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
glaxud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
glaxud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
glaxud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
glaxud011       number(20,6)      ,/* 自定義欄位(數字)011 */
glaxud012       number(20,6)      ,/* 自定義欄位(數字)012 */
glaxud013       number(20,6)      ,/* 自定義欄位(數字)013 */
glaxud014       number(20,6)      ,/* 自定義欄位(數字)014 */
glaxud015       number(20,6)      ,/* 自定義欄位(數字)015 */
glaxud016       number(20,6)      ,/* 自定義欄位(數字)016 */
glaxud017       number(20,6)      ,/* 自定義欄位(數字)017 */
glaxud018       number(20,6)      ,/* 自定義欄位(數字)018 */
glaxud019       number(20,6)      ,/* 自定義欄位(數字)019 */
glaxud020       number(20,6)      ,/* 自定義欄位(數字)020 */
glaxud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
glaxud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
glaxud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
glaxud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
glaxud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
glaxud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
glaxud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
glaxud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
glaxud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
glaxud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table glax_t add constraint glax_pk primary key (glaxent,glaxld,glaxdocno,glaxseq) enable validate;

create unique index glax_pk on glax_t (glaxent,glaxld,glaxdocno,glaxseq);

grant select on glax_t to tiptop;
grant update on glax_t to tiptop;
grant delete on glax_t to tiptop;
grant insert on glax_t to tiptop;

exit;
