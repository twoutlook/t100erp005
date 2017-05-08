/* 
================================================================================
檔案代號:xreo_t
檔案名稱:遞延收入月結檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table xreo_t
(
xreoent       number(5)      ,/* 企業代碼 */
xreocomp       varchar2(10)      ,/* 法人 */
xreosite       varchar2(10)      ,/* 帳務中心 */
xreold       varchar2(5)      ,/* 帳套 */
xreo001       number(5,0)      ,/* 年度 */
xreo002       number(5,0)      ,/* 期別 */
xreodocno       varchar2(20)      ,/* 單據號碼 */
xreoseq       number(10,0)      ,/* 項次 */
xreoorga       varchar2(10)      ,/* 來源組織 */
xreo003       varchar2(10)      ,/* 異動類型 */
xreo004       varchar2(20)      ,/* 交易單號 */
xreo005       number(10,0)      ,/* 交易單項次 */
xreo006       varchar2(20)      ,/* 帳款單號 */
xreo007       date      ,/* 立帳日期 */
xreo008       varchar2(10)      ,/* 攤銷類型 */
xreo009       varchar2(24)      ,/* 遞延科目 */
xreo011       varchar2(20)      ,/* 參考單號 */
xreo012       number(10,0)      ,/* 參考項次 */
xreo013       number(5,0)      ,/* 已攤銷期別 */
xreo016       varchar2(10)      ,/* 帳款對象 */
xreo017       varchar2(10)      ,/* 收款對象 */
xreo018       varchar2(10)      ,/* 部門 */
xreo019       varchar2(10)      ,/* 責任中心 */
xreo020       varchar2(10)      ,/* 區域 */
xreo021       varchar2(10)      ,/* 客群 */
xreo022       varchar2(10)      ,/* 產品類別 */
xreo023       varchar2(20)      ,/* 人員 */
xreo024       varchar2(20)      ,/* 專案代號 */
xreo025       varchar2(30)      ,/* WBS編號 */
xreo026       varchar2(10)      ,/* 經營方式 */
xreo027       varchar2(10)      ,/* 渠道 */
xreo028       varchar2(10)      ,/* 品牌 */
xreo029       varchar2(30)      ,/* 自由核算項一 */
xreo030       varchar2(30)      ,/* 自由核算項二 */
xreo031       varchar2(30)      ,/* 自由核算項三 */
xreo032       varchar2(30)      ,/* 自由核算項四 */
xreo033       varchar2(30)      ,/* 自由核算項五 */
xreo034       varchar2(30)      ,/* 自由核算項六 */
xreo035       varchar2(30)      ,/* 自由核算項七 */
xreo036       varchar2(30)      ,/* 自由核算項八 */
xreo037       varchar2(30)      ,/* 自由核算項九 */
xreo038       varchar2(30)      ,/* 自由核算項十 */
xreo039       varchar2(255)      ,/* 摘要 */
xreo040       varchar2(40)      ,/* 產品代號 */
xreo041       number(20,6)      ,/* 遞延認列交易原幣金額 */
xreo042       number(20,6)      ,/* 遞延認列交易本幣金額 */
xreo043       number(20,6)      ,/* 遞延認列交易本幣二金額 */
xreo044       number(20,6)      ,/* 遞延認列交易本幣三金額 */
xreo045       varchar2(10)      ,/* 銷售分群 */
xreo100       varchar2(10)      ,/* 交易原幣幣別 */
xreo101       number(20,10)      ,/* 匯率 */
xreo102       number(20,10)      ,/* 重評價匯率 */
xreo103       number(20,6)      ,/* 未沖轉原幣金額 */
xreo113       number(20,6)      ,/* 未沖轉本幣金額 */
xreo114       number(20,6)      ,/* 重評價本幣未沖金額 */
xreo121       number(20,10)      ,/* 本位幣二匯率 */
xreo122       number(20,10)      ,/* 重評價匯率二 */
xreo123       number(20,6)      ,/* 未沖轉本位幣二金額 */
xreo124       number(20,6)      ,/* 重評價本幣二未沖金額 */
xreo131       number(20,10)      ,/* 本位幣三匯率 */
xreo132       number(20,10)      ,/* 重評價匯率三 */
xreo133       number(20,6)      ,/* 未沖轉本位幣三金額 */
xreo134       number(20,6)      ,/* 重評價本幣三未沖金額 */
xreoud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xreoud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xreoud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xreoud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xreoud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xreoud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xreoud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xreoud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xreoud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xreoud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xreoud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xreoud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xreoud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xreoud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xreoud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xreoud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xreoud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xreoud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xreoud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xreoud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xreoud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xreoud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xreoud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xreoud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xreoud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xreoud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xreoud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xreoud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xreoud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xreoud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xreo_t add constraint xreo_pk primary key (xreoent,xreold,xreo001,xreo002,xreodocno,xreoseq) enable validate;

create unique index xreo_pk on xreo_t (xreoent,xreold,xreo001,xreo002,xreodocno,xreoseq);

grant select on xreo_t to tiptop;
grant update on xreo_t to tiptop;
grant delete on xreo_t to tiptop;
grant insert on xreo_t to tiptop;

exit;
