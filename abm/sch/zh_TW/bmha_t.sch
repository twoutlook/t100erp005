/* 
================================================================================
檔案代號:bmha_t
檔案名稱:料件承認模板承認內容資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table bmha_t
(
bmhaent       number(5)      ,/* 企業編號 */
bmha001       varchar2(10)      ,/* 模板代號 */
bmhaseq       number(10,0)      ,/* 項次 */
bmha002       varchar2(10)      ,/* 分類代碼 */
bmhaseq1       number(10,0)      ,/* 項次 */
bmha003       varchar2(80)      ,/* 承認內容 */
bmha004       varchar2(10)      ,/* 責任部門 */
bmha005       varchar2(1)      ,/* 須回覆否 */
bmhaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bmhaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bmhaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bmhaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bmhaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bmhaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bmhaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bmhaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bmhaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bmhaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bmhaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bmhaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bmhaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bmhaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bmhaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bmhaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bmhaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bmhaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bmhaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bmhaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bmhaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bmhaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bmhaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bmhaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bmhaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bmhaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bmhaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bmhaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bmhaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bmhaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bmha_t add constraint bmha_pk primary key (bmhaent,bmha001,bmhaseq,bmhaseq1) enable validate;

create unique index bmha_pk on bmha_t (bmhaent,bmha001,bmhaseq,bmhaseq1);

grant select on bmha_t to tiptop;
grant update on bmha_t to tiptop;
grant delete on bmha_t to tiptop;
grant insert on bmha_t to tiptop;

exit;
