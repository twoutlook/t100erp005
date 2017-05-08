/* 
================================================================================
檔案代號:deaz_t
檔案名稱:匯入銀行卡第三方卡對帳資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table deaz_t
(
deazent       number(5)      ,/* 企業編號 */
deazsite       varchar2(10)      ,/* 營運據點 */
deazdocno       varchar2(20)      ,/* 單據編號 */
deazseq       number(10,0)      ,/* 項次 */
deaz001       varchar2(30)      ,/* 款別類型對應憑証號(卡號) */
deaz002       date      ,/* 交易日期 */
deaz003       varchar2(8)      ,/* 交易時間 */
deaz004       number(20,6)      ,/* 交易金額 */
deaz005       varchar2(40)      ,/* 刷卡機編號 */
deaz006       varchar2(80)      ,/* 導入交易對象 */
deazud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
deazud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
deazud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
deazud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
deazud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
deazud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
deazud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
deazud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
deazud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
deazud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
deazud011       number(20,6)      ,/* 自定義欄位(數字)011 */
deazud012       number(20,6)      ,/* 自定義欄位(數字)012 */
deazud013       number(20,6)      ,/* 自定義欄位(數字)013 */
deazud014       number(20,6)      ,/* 自定義欄位(數字)014 */
deazud015       number(20,6)      ,/* 自定義欄位(數字)015 */
deazud016       number(20,6)      ,/* 自定義欄位(數字)016 */
deazud017       number(20,6)      ,/* 自定義欄位(數字)017 */
deazud018       number(20,6)      ,/* 自定義欄位(數字)018 */
deazud019       number(20,6)      ,/* 自定義欄位(數字)019 */
deazud020       number(20,6)      ,/* 自定義欄位(數字)020 */
deazud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
deazud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
deazud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
deazud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
deazud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
deazud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
deazud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
deazud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
deazud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
deazud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table deaz_t add constraint deaz_pk primary key (deazent,deazdocno,deazseq) enable validate;

create unique index deaz_pk on deaz_t (deazent,deazdocno,deazseq);

grant select on deaz_t to tiptop;
grant update on deaz_t to tiptop;
grant delete on deaz_t to tiptop;
grant insert on deaz_t to tiptop;

exit;
