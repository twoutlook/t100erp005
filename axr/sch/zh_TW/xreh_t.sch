/* 
================================================================================
檔案代號:xreh_t
檔案名稱:重評價帳務明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table xreh_t
(
xrehent       number(5)      ,/* 企業代碼 */
xrehdocno       varchar2(20)      ,/* 單據號碼 */
xrehld       varchar2(5)      ,/* 帳別 */
xrehseq       number(10,0)      ,/* 項次 */
xreh001       number(5,0)      ,/* 年度 */
xreh002       number(5,0)      ,/* 期別 */
xreh003       varchar2(10)      ,/* 來源模組 */
xreh004       varchar2(10)      ,/* 帳款單性質 */
xreh005       varchar2(20)      ,/* 單據號碼 */
xreh006       number(10,0)      ,/* 項次 */
xreh007       number(5,0)      ,/* 分期帳款序 */
xreh008       date      ,/* 立帳日期 */
xreh009       varchar2(10)      ,/* 帳款對象 */
xreh010       varchar2(10)      ,/* 收款對象 */
xreh011       varchar2(10)      ,/* 部門 */
xreh012       varchar2(10)      ,/* 責任中心 */
xreh013       varchar2(10)      ,/* 區域 */
xreh014       varchar2(10)      ,/* 客群 */
xreh015       varchar2(10)      ,/* 產品類別 */
xreh016       varchar2(20)      ,/* 人員 */
xreh017       varchar2(20)      ,/* 專案代號 */
xreh018       varchar2(30)      ,/* WBS編號 */
xreh019       varchar2(24)      ,/* 應收科目 */
xrehorga       varchar2(10)      ,/* 來源組織 */
xreh020       varchar2(10)      ,/* 經營方式 */
xreh021       varchar2(10)      ,/* 渠道 */
xreh022       varchar2(10)      ,/* 品牌 */
xreh023       varchar2(30)      ,/* 自由核算項一 */
xreh024       varchar2(30)      ,/* 自由核算項二 */
xreh025       varchar2(30)      ,/* 自由核算項三 */
xreh026       varchar2(30)      ,/* 自由核算項四 */
xreh027       varchar2(30)      ,/* 自由核算項五 */
xreh028       varchar2(30)      ,/* 自由核算項六 */
xreh029       varchar2(30)      ,/* 自由核算項七 */
xreh030       varchar2(30)      ,/* 自由核算項八 */
xreh031       varchar2(30)      ,/* 自由核算項九 */
xreh032       varchar2(30)      ,/* 自由核算項十 */
xreh033       varchar2(255)      ,/* 摘要 */
xreh034       varchar2(24)      ,/* 重評價會科 */
xreh100       varchar2(10)      ,/* 幣別 */
xreh101       number(20,10)      ,/* 重評價匯率 */
xreh102       number(20,10)      ,/* 上月重評匯率 */
xreh103       number(20,6)      ,/* 本期原幣未衝金額 */
xreh113       number(20,6)      ,/* 本期本幣未衝金額 */
xreh114       number(20,6)      ,/* 本期重評價後本幣金額 */
xreh115       number(20,6)      ,/* 本期匯差金額 */
xreh116       number(20,10)      ,/* 本幣累計匯差 */
xreh121       number(20,10)      ,/* 本位幣二重評價匯率 */
xreh122       number(20,6)      ,/* 本位幣二上月重估匯率 */
xreh123       number(20,6)      ,/* 本期本位幣二未衝金額 */
xreh124       number(20,6)      ,/* 本期本位幣二重評價後金額 */
xreh125       number(20,6)      ,/* 本期本位幣二匯差金額 */
xreh126       number(20,10)      ,/* 本位幣二累計匯差 */
xreh131       number(20,10)      ,/* 本位幣三重評價匯率 */
xreh132       number(20,6)      ,/* 本位幣三上月重估匯率 */
xreh133       number(20,6)      ,/* 本期本位幣三未衝金額 */
xreh134       number(20,6)      ,/* 本期本位幣三重評價後金額 */
xreh135       number(20,6)      ,/* 本期本位幣三匯差金額 */
xreh136       number(20,6)      ,/* 本位幣三累計匯差 */
xrehud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xrehud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xrehud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xrehud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xrehud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xrehud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xrehud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xrehud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xrehud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xrehud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xrehud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xrehud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xrehud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xrehud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xrehud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xrehud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xrehud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xrehud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xrehud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xrehud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xrehud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xrehud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xrehud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xrehud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xrehud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xrehud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xrehud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xrehud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xrehud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xrehud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xreh_t add constraint xreh_pk primary key (xrehent,xrehdocno,xrehld,xrehseq) enable validate;

create unique index xreh_pk on xreh_t (xrehent,xrehdocno,xrehld,xrehseq);

grant select on xreh_t to tiptop;
grant update on xreh_t to tiptop;
grant delete on xreh_t to tiptop;
grant insert on xreh_t to tiptop;

exit;
