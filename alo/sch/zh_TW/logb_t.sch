/* 
================================================================================
檔案代號:logb_t
檔案名稱:使用者觸發動作時間記錄表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table logb_t
(
logb001       varchar2(20)      ,/* 使用者編號 */
logb002       varchar2(20)      ,/* 作業編號 */
logb003       varchar2(20)      ,/* 資料庫編號 */
logb004       varchar2(20)      ,/* 主機位址 */
logb005       varchar2(80)      ,/* 作業進程編號 */
logb006       varchar2(80)      ,/* 功能編號 */
logb007       timestamp(0)      ,/* 啟動時間 */
logb008       varchar2(1)      ,/* 成功或失敗狀態 */
logb009       varchar2(10)      ,/* Fraction(5) */
logbent       number(5)      ,/* 企業編號 */
logbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
logbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
logbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
logbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
logbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
logbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
logbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
logbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
logbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
logbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
logbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
logbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
logbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
logbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
logbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
logbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
logbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
logbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
logbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
logbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
logbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
logbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
logbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
logbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
logbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
logbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
logbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
logbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
logbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
logbud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);


grant select on logb_t to tiptop;
grant update on logb_t to tiptop;
grant delete on logb_t to tiptop;
grant insert on logb_t to tiptop;

exit;
