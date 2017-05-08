/* 
================================================================================
檔案代號:glcb_t
檔案名稱:帳套別壞帳準備設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table glcb_t
(
glcbent       number(5)      ,/* 企業編號 */
glcbld       varchar2(5)      ,/* 帳套別編號 */
glcb001       varchar2(10)      ,/* 子模組編號 */
glcb002       varchar2(10)      ,/* 壞帳準備提列方式 */
glcb003       varchar2(10)      ,/* 帳齡類型 */
glcb004       number(20,6)      ,/* 提列限額額比率 */
glcb005       number(5,0)      ,/* 現行重評價年度 */
glcb006       number(5,0)      ,/* 現行重評價月份 */
glcb007       varchar2(1)      ,/* 暫估類帳款納入分析否 */
glcb008       varchar2(10)      ,/* 待抵及帳款減項扣除 */
glcbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
glcbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
glcbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
glcbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
glcbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
glcbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
glcbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
glcbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
glcbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
glcbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
glcbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
glcbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
glcbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
glcbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
glcbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
glcbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
glcbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
glcbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
glcbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
glcbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
glcbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
glcbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
glcbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
glcbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
glcbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
glcbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
glcbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
glcbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
glcbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
glcbud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table glcb_t add constraint glcb_pk primary key (glcbent,glcbld,glcb001) enable validate;

create unique index glcb_pk on glcb_t (glcbent,glcbld,glcb001);

grant select on glcb_t to tiptop;
grant update on glcb_t to tiptop;
grant delete on glcb_t to tiptop;
grant insert on glcb_t to tiptop;

exit;
