/* 
================================================================================
檔案代號:deae_t
檔案名稱:门店收银缴款出纳结账单身档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table deae_t
(
deaeent       number(5)      ,/* 企業編號 */
deaesite       varchar2(10)      ,/* 營運據點 */
deaedocno       varchar2(20)      ,/* 單號 */
deae001       varchar2(10)      ,/* 款別編號 */
deae002       varchar2(10)      ,/* 款別分類 */
deae003       number(20,6)      ,/* 總繳金額 */
deaeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
deaeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
deaeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
deaeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
deaeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
deaeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
deaeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
deaeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
deaeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
deaeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
deaeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
deaeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
deaeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
deaeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
deaeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
deaeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
deaeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
deaeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
deaeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
deaeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
deaeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
deaeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
deaeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
deaeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
deaeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
deaeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
deaeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
deaeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
deaeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
deaeud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
deae004       number(20,6)      ,/* 實收金額 */
deae005       number(20,6)      ,/* POS讀帳條(本地延遲上傳) */
deae006       number(20,6)      ,/* POS伺服器金額彙總 */
deae007       number(20,6)      /* 差異金額 */
);
alter table deae_t add constraint deae_pk primary key (deaeent,deaedocno,deae001) enable validate;

create unique index deae_pk on deae_t (deaeent,deaedocno,deae001);

grant select on deae_t to tiptop;
grant update on deae_t to tiptop;
grant delete on deae_t to tiptop;
grant insert on deae_t to tiptop;

exit;
