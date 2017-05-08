/* 
================================================================================
檔案代號:glcd_t
檔案名稱:總帳調匯科目範圍檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table glcd_t
(
glcdent       number(5)      ,/* 企業編碼 */
glcdld       varchar2(5)      ,/* 帳套編號 */
glcd001       varchar2(24)      ,/* 科目編號 */
glcdacti       varchar2(1)      ,/* 有效碼 */
glcdud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
glcdud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
glcdud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
glcdud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
glcdud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
glcdud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
glcdud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
glcdud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
glcdud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
glcdud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
glcdud011       number(20,6)      ,/* 自定義欄位(數字)011 */
glcdud012       number(20,6)      ,/* 自定義欄位(數字)012 */
glcdud013       number(20,6)      ,/* 自定義欄位(數字)013 */
glcdud014       number(20,6)      ,/* 自定義欄位(數字)014 */
glcdud015       number(20,6)      ,/* 自定義欄位(數字)015 */
glcdud016       number(20,6)      ,/* 自定義欄位(數字)016 */
glcdud017       number(20,6)      ,/* 自定義欄位(數字)017 */
glcdud018       number(20,6)      ,/* 自定義欄位(數字)018 */
glcdud019       number(20,6)      ,/* 自定義欄位(數字)019 */
glcdud020       number(20,6)      ,/* 自定義欄位(數字)020 */
glcdud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
glcdud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
glcdud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
glcdud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
glcdud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
glcdud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
glcdud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
glcdud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
glcdud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
glcdud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table glcd_t add constraint glcd_pk primary key (glcdent,glcdld,glcd001) enable validate;


grant select on glcd_t to tiptop;
grant update on glcd_t to tiptop;
grant delete on glcd_t to tiptop;
grant insert on glcd_t to tiptop;

exit;
