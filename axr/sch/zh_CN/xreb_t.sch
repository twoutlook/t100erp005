/* 
================================================================================
檔案代號:xreb_t
檔案名稱:重評價月結檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table xreb_t
(
xrebent       number(5)      ,/* 企業代碼 */
xrebcomp       varchar2(10)      ,/* 法人 */
xrebsite       varchar2(10)      ,/* 帳務中心 */
xrebld       varchar2(5)      ,/* 帳別 */
xreb001       number(5,0)      ,/* 年度 */
xreb002       number(5,0)      ,/* 期別 */
xreb003       varchar2(10)      ,/* 來源模組 */
xreb004       varchar2(10)      ,/* 帳款單性質 */
xreb005       varchar2(20)      ,/* 單據號碼 */
xreb006       number(10,0)      ,/* 項次 */
xreb007       number(5,0)      ,/* 分期帳款序 */
xreb008       date      ,/* 立帳日期 */
xreb009       varchar2(10)      ,/* 帳款對象 */
xreb010       varchar2(10)      ,/* 收款對象 */
xreb011       varchar2(10)      ,/* 部門 */
xreb012       varchar2(10)      ,/* 責任中心 */
xreb013       varchar2(10)      ,/* 區域 */
xreb014       varchar2(10)      ,/* 客群 */
xreb015       varchar2(10)      ,/* 產品類別 */
xreb016       varchar2(20)      ,/* 人員 */
xreb017       varchar2(20)      ,/* 專案代號 */
xreb018       varchar2(30)      ,/* WBS編號 */
xreb019       varchar2(24)      ,/* 應收科目 */
xreborga       varchar2(10)      ,/* 來源組織 */
xreb020       varchar2(10)      ,/* 經營方式 */
xreb021       varchar2(10)      ,/* 渠道 */
xreb022       varchar2(10)      ,/* 品牌 */
xreb023       varchar2(30)      ,/* 自由核算項一 */
xreb024       varchar2(30)      ,/* 自由核算項二 */
xreb025       varchar2(30)      ,/* 自由核算項三 */
xreb026       varchar2(30)      ,/* 自由核算項四 */
xreb027       varchar2(30)      ,/* 自由核算項五 */
xreb028       varchar2(30)      ,/* 自由核算項六 */
xreb029       varchar2(30)      ,/* 自由核算項七 */
xreb030       varchar2(30)      ,/* 自由核算項八 */
xreb031       varchar2(30)      ,/* 自由核算項九 */
xreb032       varchar2(30)      ,/* 自由核算項十 */
xreb033       varchar2(255)      ,/* 摘要 */
xreb034       varchar2(24)      ,/* 重評價會計科目 */
xreb100       varchar2(10)      ,/* 幣別 */
xreb101       number(20,10)      ,/* 重評價匯率 */
xreb102       number(20,10)      ,/* 上月重評匯率 */
xreb103       number(20,6)      ,/* 本期原幣未沖金額 */
xreb113       number(20,6)      ,/* 本期本幣未沖金額 */
xreb114       number(20,6)      ,/* 本期重評價後本幣金額 */
xreb115       number(20,6)      ,/* 本期匯差金額 */
xreb116       number(20,6)      ,/* 本幣累計匯差 */
xreb121       number(20,10)      ,/* 本位幣二重評價匯率 */
xreb122       number(20,10)      ,/* 本位幣二上月重估匯率 */
xreb123       number(20,6)      ,/* 本期本位幣二未沖金額 */
xreb124       number(20,6)      ,/* 本期本位幣二重評價後金額 */
xreb125       number(20,6)      ,/* 本期本位幣二匯差金額 */
xreb126       number(20,6)      ,/* 本位幣二累計匯差 */
xreb131       number(20,10)      ,/* 本位幣三重評價匯率 */
xreb132       number(20,10)      ,/* 本位幣三上月重估匯率 */
xreb133       number(20,6)      ,/* 本期本位幣三未沖金額 */
xreb134       number(20,6)      ,/* 本期本位幣三重評價後金額 */
xreb135       number(20,6)      ,/* 本期本位幣三匯差金額 */
xreb136       number(20,6)      ,/* 本位幣三累計匯差 */
xrebud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xrebud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xrebud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xrebud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xrebud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xrebud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xrebud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xrebud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xrebud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xrebud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xrebud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xrebud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xrebud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xrebud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xrebud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xrebud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xrebud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xrebud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xrebud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xrebud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xrebud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xrebud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xrebud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xrebud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xrebud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xrebud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xrebud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xrebud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xrebud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xrebud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xreb_t add constraint xreb_pk primary key (xrebent,xrebld,xreb001,xreb002,xreb003,xreb005,xreb006,xreb007) enable validate;

create unique index xreb_pk on xreb_t (xrebent,xrebld,xreb001,xreb002,xreb003,xreb005,xreb006,xreb007);

grant select on xreb_t to tiptop;
grant update on xreb_t to tiptop;
grant delete on xreb_t to tiptop;
grant insert on xreb_t to tiptop;

exit;
