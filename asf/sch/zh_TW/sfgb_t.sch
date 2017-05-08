/* 
================================================================================
檔案代號:sfgb_t
檔案名稱:工單當站報廢異常原因檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table sfgb_t
(
sfgbent       number(5)      ,/* 企業編號 */
sfgbsite       varchar2(10)      ,/* 營運據點 */
sfgbdocno       varchar2(20)      ,/* 單據編號 */
sfgbseq       number(10,0)      ,/* 項次 */
sfgb001       varchar2(10)      ,/* 異常原因 */
sfgb002       number(20,6)      ,/* 數量 */
sfgb003       varchar2(255)      ,/* 備註 */
sfgbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
sfgbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
sfgbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
sfgbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
sfgbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
sfgbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
sfgbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
sfgbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
sfgbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
sfgbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
sfgbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
sfgbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
sfgbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
sfgbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
sfgbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
sfgbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
sfgbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
sfgbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
sfgbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
sfgbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
sfgbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
sfgbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
sfgbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
sfgbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
sfgbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
sfgbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
sfgbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
sfgbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
sfgbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
sfgbud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table sfgb_t add constraint sfgb_pk primary key (sfgbent,sfgbdocno,sfgbseq) enable validate;

create unique index sfgb_pk on sfgb_t (sfgbent,sfgbdocno,sfgbseq);

grant select on sfgb_t to tiptop;
grant update on sfgb_t to tiptop;
grant delete on sfgb_t to tiptop;
grant insert on sfgb_t to tiptop;

exit;
