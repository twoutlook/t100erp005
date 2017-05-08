/* 
================================================================================
檔案代號:glca_t
檔案名稱:帳套別重評價設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table glca_t
(
glcaent       number(5)      ,/* 企業編號 */
glcald       varchar2(5)      ,/* 帳套別編號 */
glca001       varchar2(10)      ,/* 子模組編號 */
glca002       varchar2(10)      ,/* 重評價處理模式 */
glca003       varchar2(10)      ,/* 重評價匯率 */
glca004       varchar2(1)      ,/* 扣抵項目減除否 */
glca005       varchar2(10)      ,/* 暫估款納入評價否 */
glca006       number(5,0)      ,/* 現行重評價年度 */
glca007       number(5,0)      ,/* 現行重評價月份 */
glcaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
glcaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
glcaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
glcaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
glcaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
glcaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
glcaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
glcaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
glcaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
glcaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
glcaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
glcaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
glcaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
glcaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
glcaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
glcaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
glcaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
glcaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
glcaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
glcaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
glcaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
glcaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
glcaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
glcaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
glcaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
glcaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
glcaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
glcaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
glcaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
glcaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table glca_t add constraint glca_pk primary key (glcaent,glcald,glca001) enable validate;

create unique index glca_pk on glca_t (glcaent,glcald,glca001);

grant select on glca_t to tiptop;
grant update on glca_t to tiptop;
grant delete on glca_t to tiptop;
grant insert on glca_t to tiptop;

exit;
