/* 
================================================================================
檔案代號:glel_t
檔案名稱:合併現金流量表間接法本期損益期初開帳金額設定資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table glel_t
(
glelent       number(5)      ,/* 企業編號 */
glelld       varchar2(5)      ,/* 合併帳別 */
glel001       varchar2(10)      ,/* 上層公司 */
glel002       number(5,0)      ,/* 年度 */
glel003       number(5,0)      ,/* 期別 */
glel004       varchar2(10)      ,/* 幣別(記帳幣) */
glel005       number(20,6)      ,/* 期初借方金額(記帳幣) */
glel006       number(20,6)      ,/* 期初貸方金額(記帳幣) */
glel007       varchar2(10)      ,/* 幣別(功能幣) */
glel008       number(20,6)      ,/* 期初借方金額(功能幣) */
glel009       number(20,6)      ,/* 期初貸方金額(功能幣) */
glel010       varchar2(10)      ,/* 幣別(報告幣) */
glel011       number(20,6)      ,/* 期初借方金額(報告幣) */
glel012       number(20,6)      ,/* 期初貸方金額(報告幣) */
glelownid       varchar2(20)      ,/* 資料所有者 */
glelowndp       varchar2(10)      ,/* 資料所屬部門 */
glelcrtid       varchar2(20)      ,/* 資料建立者 */
glelcrtdp       varchar2(10)      ,/* 資料建立部門 */
glelcrtdt       timestamp(0)      ,/* 資料創建日 */
glelmodid       varchar2(20)      ,/* 資料修改者 */
glelmoddt       timestamp(0)      ,/* 最近修改日 */
glelstus       varchar2(10)      ,/* 狀態碼 */
glelud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
glelud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
glelud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
glelud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
glelud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
glelud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
glelud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
glelud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
glelud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
glelud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
glelud011       number(20,6)      ,/* 自定義欄位(數字)011 */
glelud012       number(20,6)      ,/* 自定義欄位(數字)012 */
glelud013       number(20,6)      ,/* 自定義欄位(數字)013 */
glelud014       number(20,6)      ,/* 自定義欄位(數字)014 */
glelud015       number(20,6)      ,/* 自定義欄位(數字)015 */
glelud016       number(20,6)      ,/* 自定義欄位(數字)016 */
glelud017       number(20,6)      ,/* 自定義欄位(數字)017 */
glelud018       number(20,6)      ,/* 自定義欄位(數字)018 */
glelud019       number(20,6)      ,/* 自定義欄位(數字)019 */
glelud020       number(20,6)      ,/* 自定義欄位(數字)020 */
glelud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
glelud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
glelud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
glelud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
glelud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
glelud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
glelud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
glelud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
glelud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
glelud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table glel_t add constraint glel_pk primary key (glelent,glelld,glel001,glel002,glel003) enable validate;

create unique index glel_pk on glel_t (glelent,glelld,glel001,glel002,glel003);

grant select on glel_t to tiptop;
grant update on glel_t to tiptop;
grant delete on glel_t to tiptop;
grant insert on glel_t to tiptop;

exit;
