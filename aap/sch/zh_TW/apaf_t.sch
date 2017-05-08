/* 
================================================================================
檔案代號:apaf_t
檔案名稱:集團代收付基本設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table apaf_t
(
apafent       number(5)      ,/* 企業代碼 */
apafstus       varchar2(10)      ,/* 資料有效碼 */
apaf001       varchar2(10)      ,/* 代收付類型 */
apaf002       varchar2(10)      ,/* 代收付組織內部帳戶 */
apaf003       varchar2(10)      ,/* 收付組織沖銷單別 */
apaf004       varchar2(10)      ,/* 待抵單別(對歸屬組織) */
apaf005       varchar2(10)      ,/* 收付組織銀行存提碼 */
apaf006       varchar2(10)      ,/* 收付組織現金變動碼 */
apaf011       varchar2(10)      ,/* 帳務歸屬組織 */
apaf012       varchar2(10)      ,/* 歸屬組織內部帳戶 */
apaf013       varchar2(10)      ,/* 歸屬組織沖銷單別 */
apaf014       varchar2(10)      ,/* 歸屬組織立帳單別 */
apaf015       varchar2(10)      ,/* 歸屬組織銀行存提碼 */
apaf016       varchar2(10)      ,/* 歸屬組織現金變動碼 */
apaf017       varchar2(10)      ,/* 歸屬組織帳款類別 */
apaf018       varchar2(10)      ,/* 歸屬組織收付款條件 */
apaf019       varchar2(10)      ,/* 稅別 */
apaf020       varchar2(10)      ,/* 理由碼 */
apaf021       varchar2(10)      ,/* 歸屬組織待抵單別 */
apafownid       varchar2(20)      ,/* 資料所有者 */
apafowndp       varchar2(10)      ,/* 資料所屬部門 */
apafcrtid       varchar2(20)      ,/* 資料建立者 */
apafcrtdp       varchar2(10)      ,/* 資料建立部門 */
apafcrtdt       timestamp(0)      ,/* 資料創建日 */
apafmodid       varchar2(20)      ,/* 資料修改者 */
apafmoddt       timestamp(0)      ,/* 最近修改日 */
apafud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
apafud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
apafud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
apafud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
apafud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
apafud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
apafud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
apafud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
apafud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
apafud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
apafud011       number(20,6)      ,/* 自定義欄位(數字)011 */
apafud012       number(20,6)      ,/* 自定義欄位(數字)012 */
apafud013       number(20,6)      ,/* 自定義欄位(數字)013 */
apafud014       number(20,6)      ,/* 自定義欄位(數字)014 */
apafud015       number(20,6)      ,/* 自定義欄位(數字)015 */
apafud016       number(20,6)      ,/* 自定義欄位(數字)016 */
apafud017       number(20,6)      ,/* 自定義欄位(數字)017 */
apafud018       number(20,6)      ,/* 自定義欄位(數字)018 */
apafud019       number(20,6)      ,/* 自定義欄位(數字)019 */
apafud020       number(20,6)      ,/* 自定義欄位(數字)020 */
apafud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
apafud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
apafud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
apafud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
apafud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
apafud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
apafud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
apafud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
apafud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
apafud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table apaf_t add constraint apaf_pk primary key (apafent,apaf001,apaf011) enable validate;

create unique index apaf_pk on apaf_t (apafent,apaf001,apaf011);

grant select on apaf_t to tiptop;
grant update on apaf_t to tiptop;
grant delete on apaf_t to tiptop;
grant insert on apaf_t to tiptop;

exit;
