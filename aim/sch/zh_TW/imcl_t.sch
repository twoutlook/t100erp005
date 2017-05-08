/* 
================================================================================
檔案代號:imcl_t
檔案名稱:料件主分群標籤檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table imcl_t
(
imclent       number(5)      ,/* 企業編號 */
imcl001       varchar2(10)      ,/* 主分群碼 */
imcl002       varchar2(10)      ,/* 產品標籤 */
imclud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
imclud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
imclud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
imclud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
imclud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
imclud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
imclud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
imclud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
imclud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
imclud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
imclud011       number(20,6)      ,/* 自定義欄位(數字)011 */
imclud012       number(20,6)      ,/* 自定義欄位(數字)012 */
imclud013       number(20,6)      ,/* 自定義欄位(數字)013 */
imclud014       number(20,6)      ,/* 自定義欄位(數字)014 */
imclud015       number(20,6)      ,/* 自定義欄位(數字)015 */
imclud016       number(20,6)      ,/* 自定義欄位(數字)016 */
imclud017       number(20,6)      ,/* 自定義欄位(數字)017 */
imclud018       number(20,6)      ,/* 自定義欄位(數字)018 */
imclud019       number(20,6)      ,/* 自定義欄位(數字)019 */
imclud020       number(20,6)      ,/* 自定義欄位(數字)020 */
imclud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
imclud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
imclud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
imclud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
imclud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
imclud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
imclud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
imclud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
imclud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
imclud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table imcl_t add constraint imcl_pk primary key (imclent,imcl001,imcl002) enable validate;

create unique index imcl_pk on imcl_t (imclent,imcl001,imcl002);

grant select on imcl_t to tiptop;
grant update on imcl_t to tiptop;
grant delete on imcl_t to tiptop;
grant insert on imcl_t to tiptop;

exit;
