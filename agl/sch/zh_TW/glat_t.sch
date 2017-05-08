/* 
================================================================================
檔案代號:glat_t
檔案名稱:分錄底稿月結檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table glat_t
(
glatent       number(5)      ,/* 企業代碼 */
glatcomp       varchar2(10)      ,/* 法人 */
glatld       varchar2(5)      ,/* 帳別 */
glat001       number(5,0)      ,/* 年度 */
glat002       number(5,0)      ,/* 期別 */
glat003       varchar2(10)      ,/* 來源模組 */
glat004       varchar2(1000)      ,/* 組合要素(key) */
glat005       varchar2(10)      ,/* 帳款對象 */
glat006       varchar2(10)      ,/* 收款對象 */
glatorga       varchar2(10)      ,/* 來源組織 */
glat007       varchar2(24)      ,/* 科目 */
glat011       varchar2(10)      ,/* 部門 */
glat012       varchar2(10)      ,/* 責任中心 */
glat013       varchar2(10)      ,/* 區域 */
glat014       varchar2(10)      ,/* 客群 */
glat015       varchar2(10)      ,/* 產品類別 */
glat016       varchar2(20)      ,/* 人員 */
glat017       varchar2(20)      ,/* 專案代號 */
glat018       varchar2(30)      ,/* WBS編號 */
glat020       varchar2(10)      ,/* 經營方式 */
glat021       varchar2(10)      ,/* 渠道 */
glat022       varchar2(10)      ,/* 品牌 */
glat023       varchar2(30)      ,/* 自由核算項一 */
glat024       varchar2(30)      ,/* 自由核算項二 */
glat025       varchar2(30)      ,/* 自由核算項三 */
glat026       varchar2(30)      ,/* 自由核算項四 */
glat027       varchar2(30)      ,/* 自由核算項五 */
glat028       varchar2(30)      ,/* 自由核算項六 */
glat029       varchar2(30)      ,/* 自由核算項七 */
glat030       varchar2(30)      ,/* 自由核算項八 */
glat031       varchar2(30)      ,/* 自由核算項九 */
glat032       varchar2(30)      ,/* 自由核算項十 */
glat100       varchar2(10)      ,/* 幣別 */
glat103       number(20,6)      ,/* 原幣借方金額	 */
glat104       number(20,6)      ,/* 原幣貸方金額	 */
glat113       number(20,6)      ,/* 本幣借方金額	 */
glat114       number(20,6)      ,/* 本幣貸方金額	 */
glat123       number(20,10)      ,/* 本位幣二借方金額	 */
glat124       number(20,6)      ,/* 本位幣二貸方金額	 */
glat133       number(20,6)      ,/* 本位幣三借方金額 */
glat134       number(20,6)      ,/* 本位幣三貸方金額	 */
glatud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
glatud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
glatud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
glatud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
glatud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
glatud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
glatud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
glatud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
glatud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
glatud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
glatud011       number(20,6)      ,/* 自定義欄位(數字)011 */
glatud012       number(20,6)      ,/* 自定義欄位(數字)012 */
glatud013       number(20,6)      ,/* 自定義欄位(數字)013 */
glatud014       number(20,6)      ,/* 自定義欄位(數字)014 */
glatud015       number(20,6)      ,/* 自定義欄位(數字)015 */
glatud016       number(20,6)      ,/* 自定義欄位(數字)016 */
glatud017       number(20,6)      ,/* 自定義欄位(數字)017 */
glatud018       number(20,6)      ,/* 自定義欄位(數字)018 */
glatud019       number(20,6)      ,/* 自定義欄位(數字)019 */
glatud020       number(20,6)      ,/* 自定義欄位(數字)020 */
glatud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
glatud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
glatud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
glatud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
glatud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
glatud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
glatud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
glatud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
glatud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
glatud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table glat_t add constraint glat_pk primary key (glatent,glatld,glat001,glat002,glat003,glat004,glat007) enable validate;

create unique index glat_pk on glat_t (glatent,glatld,glat001,glat002,glat003,glat004,glat007);

grant select on glat_t to tiptop;
grant update on glat_t to tiptop;
grant delete on glat_t to tiptop;
grant insert on glat_t to tiptop;

exit;
