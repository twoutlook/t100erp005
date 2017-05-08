/* 
================================================================================
檔案代號:gldh_t
檔案名稱:非T100公司科目餘額暫存資料
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table gldh_t
(
gldhent       number(5)      ,/* 企業代碼 */
gldh001       varchar2(10)      ,/* 公司編號 */
gldh002       varchar2(5)      ,/* 帳別 */
gldh003       varchar2(24)      ,/* 科目編號 */
gldh004       varchar2(80)      ,/* 科目名稱 */
gldh005       number(5,0)      ,/* 年度 */
gldh006       number(5,0)      ,/* 期別 */
gldh007       varchar2(1000)      ,/* 組合要素(key) */
gldh008       varchar2(10)      ,/* 營運據點 */
gldh009       varchar2(10)      ,/* 部門 */
gldh010       varchar2(10)      ,/* 利潤/成本中心 */
gldh011       varchar2(10)      ,/* 區域 */
gldh012       varchar2(10)      ,/* 交易客商 */
gldh013       varchar2(10)      ,/* 帳款客商 */
gldh014       varchar2(10)      ,/* 客群 */
gldh015       varchar2(10)      ,/* 產品類別 */
gldh016       varchar2(10)      ,/* 經營方式 */
gldh017       varchar2(10)      ,/* 渠道 */
gldh018       varchar2(10)      ,/* 品牌 */
gldh019       varchar2(20)      ,/* 人員 */
gldh020       varchar2(20)      ,/* 專案編號 */
gldh021       varchar2(30)      ,/* WBS */
gldh022       number(10,0)      ,/* 借方筆數 */
gldh023       number(10,0)      ,/* 貸方筆數 */
gldh024       varchar2(10)      ,/* 幣別(記帳幣) */
gldh025       number(20,6)      ,/* 借方金額(記帳幣) */
gldh026       number(20,6)      ,/* 貸方金額(記帳幣) */
gldh027       varchar2(10)      ,/* 幣別(功能幣) */
gldh028       number(20,6)      ,/* 借方金額(功能幣) */
gldh029       number(20,6)      ,/* 貸方金額(功能幣) */
gldh030       varchar2(10)      ,/* 幣別(報告幣) */
gldh031       number(20,6)      ,/* 借方金額(報告幣) */
gldh032       number(20,6)      ,/* 貸方金額(報告幣) */
gldhud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gldhud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gldhud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gldhud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gldhud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gldhud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gldhud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gldhud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gldhud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gldhud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gldhud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gldhud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gldhud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gldhud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gldhud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gldhud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gldhud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gldhud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gldhud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gldhud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gldhud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gldhud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gldhud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gldhud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gldhud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gldhud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gldhud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gldhud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gldhud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gldhud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table gldh_t add constraint gldh_pk primary key (gldhent,gldh001,gldh002,gldh003,gldh005,gldh006,gldh007) enable validate;

create unique index gldh_pk on gldh_t (gldhent,gldh001,gldh002,gldh003,gldh005,gldh006,gldh007);

grant select on gldh_t to tiptop;
grant update on gldh_t to tiptop;
grant delete on gldh_t to tiptop;
grant insert on gldh_t to tiptop;

exit;
