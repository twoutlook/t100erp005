/* 
================================================================================
檔案代號:apgb_t
檔案名稱:信用狀申請明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table apgb_t
(
apgbent       number(5)      ,/* 企業代碼 */
apgbcomp       varchar2(10)      ,/* 法人 */
apgbdocno       varchar2(20)      ,/* 申請單號 */
apgbseq       number(10,0)      ,/* 項次 */
apgborga       varchar2(10)      ,/* 來源組織 */
apgb001       varchar2(20)      ,/* 採購單號 */
apgb002       number(10,0)      ,/* 採購單號項次 */
apgb003       varchar2(40)      ,/* 產品編號 */
apgb004       varchar2(255)      ,/* 品名規格 */
apgb005       varchar2(10)      ,/* 單位 */
apgb006       varchar2(10)      ,/* 稅別 */
apgb007       varchar2(1)      ,/* 含稅否 */
apgb008       number(20,6)      ,/* 採購數量 */
apgb009       number(20,6)      ,/* 原幣含稅單價 */
apgb010       number(20,6)      ,/* 到貨數量 */
apgb011       number(20,6)      ,/* 在途數量 */
apgb105       number(20,6)      ,/* 原幣含稅金額 */
apgb115       number(20,6)      ,/* 本幣含稅金額 */
apgbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
apgbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
apgbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
apgbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
apgbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
apgbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
apgbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
apgbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
apgbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
apgbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
apgbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
apgbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
apgbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
apgbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
apgbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
apgbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
apgbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
apgbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
apgbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
apgbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
apgbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
apgbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
apgbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
apgbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
apgbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
apgbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
apgbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
apgbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
apgbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
apgbud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table apgb_t add constraint apgb_pk primary key (apgbent,apgbcomp,apgbdocno,apgbseq) enable validate;

create unique index apgb_pk on apgb_t (apgbent,apgbcomp,apgbdocno,apgbseq);

grant select on apgb_t to tiptop;
grant update on apgb_t to tiptop;
grant delete on apgb_t to tiptop;
grant insert on apgb_t to tiptop;

exit;
