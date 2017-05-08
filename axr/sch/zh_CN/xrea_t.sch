/* 
================================================================================
檔案代號:xrea_t
檔案名稱:往來帳科目月結檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table xrea_t
(
xreaent       number(5)      ,/* 企業代碼 */
xreacomp       varchar2(10)      ,/* 法人 */
xreasite       varchar2(10)      ,/* 帳務組織 */
xreald       varchar2(5)      ,/* 帳別 */
xrea001       number(5,0)      ,/* 年度 */
xrea002       number(5,0)      ,/* 期別 */
xrea003       varchar2(10)      ,/* 來源模組 */
xrea004       varchar2(10)      ,/* 帳款單性質 */
xrea005       varchar2(20)      ,/* 單據號碼 */
xrea006       number(10,0)      ,/* 項次 */
xrea007       number(5,0)      ,/* 分期帳款序 */
xrea008       date      ,/* 立帳日期 */
xrea009       varchar2(10)      ,/* 帳款對象 */
xrea010       varchar2(10)      ,/* 收款對象 */
xrea011       varchar2(10)      ,/* 部門 */
xrea012       varchar2(10)      ,/* 責任中心 */
xrea013       varchar2(10)      ,/* 區域 */
xrea014       varchar2(10)      ,/* 客群 */
xrea015       varchar2(10)      ,/* 產品類別 */
xrea016       varchar2(20)      ,/* 人員 */
xrea017       varchar2(20)      ,/* 專案代號 */
xrea018       varchar2(30)      ,/* WBS編號 */
xrea019       varchar2(24)      ,/* 應收付科目 */
xreaorga       varchar2(10)      ,/* 來源組織 */
xrea020       varchar2(10)      ,/* 經營方式 */
xrea021       varchar2(10)      ,/* 渠道 */
xrea022       varchar2(10)      ,/* 品牌 */
xrea023       varchar2(10)      ,/* 自由核算項一 */
xrea024       varchar2(10)      ,/* 自由核算項二 */
xrea025       varchar2(10)      ,/* 自由核算項三 */
xrea026       varchar2(10)      ,/* 自由核算項四 */
xrea027       varchar2(10)      ,/* 自由核算項五 */
xrea028       varchar2(10)      ,/* 自由核算項六 */
xrea029       varchar2(10)      ,/* 自由核算項七 */
xrea030       varchar2(10)      ,/* 自由核算項八 */
xrea031       varchar2(10)      ,/* 自由核算項九 */
xrea032       varchar2(10)      ,/* 自由核算項十 */
xrea033       varchar2(255)      ,/* 摘要 */
xrea034       date      ,/* 發票日期 */
xrea035       date      ,/* 出貨單據日期 */
xrea036       date      ,/* 交易認定日期 */
xrea037       date      ,/* 出入庫扣帳日期 */
xrea038       date      ,/* 應收款日 */
xrea039       varchar2(10)      ,/* 信評等級 */
xrea040       varchar2(10)      ,/* 稅別 */
xrea041       number(20,6)      ,/* 稅率 */
xrea042       varchar2(24)      ,/* No Use */
xrea043       varchar2(24)      ,/* No Use */
xrea100       varchar2(10)      ,/* 幣別 */
xrea101       number(20,10)      ,/* 交易匯率 */
xrea102       number(20,10)      ,/* 重評匯率 */
xrea103       number(20,6)      ,/* 原幣未沖含稅金額 */
xrea104       number(20,6)      ,/* 原幣暫估未沖未稅金額 */
xrea105       number(20,6)      ,/* 原幣暫估未沖稅額 */
xrea106       number(20,6)      ,/* 原幣暫估未沖含稅金額 */
xrea113       number(20,6)      ,/* 本幣未沖含稅金額 */
xrea114       number(20,6)      ,/* 本幣暫估未沖未稅金額 */
xrea115       number(20,6)      ,/* 本幣暫估未沖稅額 */
xrea116       number(20,6)      ,/* 本幣暫估未沖含稅金額 */
xrea122       number(20,10)      ,/* 本位幣二重評匯率 */
xrea123       number(20,6)      ,/* 本位幣二未沖含稅金額 */
xrea132       number(20,10)      ,/* 本位幣三重評匯率 */
xrea133       number(20,6)      ,/* 本位幣三未沖含稅金額 */
xreaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xreaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xreaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xreaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xreaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xreaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xreaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xreaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xreaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xreaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xreaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xreaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xreaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xreaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xreaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xreaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xreaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xreaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xreaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xreaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xreaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xreaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xreaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xreaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xreaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xreaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xreaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xreaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xreaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xreaud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
xrea044       varchar2(20)      ,/* 發票號碼 */
xrea045       varchar2(10)      /* 交易條件 */
);
alter table xrea_t add constraint xrea_pk primary key (xreaent,xreald,xrea001,xrea002,xrea003,xrea004,xrea005,xrea006,xrea007) enable validate;

create  index xrea_02 on xrea_t (xreacomp,xrea001,xrea002,xrea003,xrea004);
create unique index xrea_pk on xrea_t (xreaent,xreald,xrea001,xrea002,xrea003,xrea004,xrea005,xrea006,xrea007);

grant select on xrea_t to tiptop;
grant update on xrea_t to tiptop;
grant delete on xrea_t to tiptop;
grant insert on xrea_t to tiptop;

exit;
