/* 
================================================================================
檔案代號:imcj_t
檔案名稱:料件主分群成份與物質檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table imcj_t
(
imcjent       number(5)      ,/* 企業編號 */
imcj001       varchar2(10)      ,/* 主分群碼 */
imcj002       varchar2(10)      ,/* 類型 */
imcj003       varchar2(10)      ,/* 成份/物質 */
imcj004       number(20,6)      ,/* 含量 */
imcj005       varchar2(10)      ,/* 單位 */
imcj006       varchar2(10)      ,/* 管制類型 */
imcjud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
imcjud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
imcjud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
imcjud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
imcjud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
imcjud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
imcjud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
imcjud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
imcjud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
imcjud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
imcjud011       number(20,6)      ,/* 自定義欄位(數字)011 */
imcjud012       number(20,6)      ,/* 自定義欄位(數字)012 */
imcjud013       number(20,6)      ,/* 自定義欄位(數字)013 */
imcjud014       number(20,6)      ,/* 自定義欄位(數字)014 */
imcjud015       number(20,6)      ,/* 自定義欄位(數字)015 */
imcjud016       number(20,6)      ,/* 自定義欄位(數字)016 */
imcjud017       number(20,6)      ,/* 自定義欄位(數字)017 */
imcjud018       number(20,6)      ,/* 自定義欄位(數字)018 */
imcjud019       number(20,6)      ,/* 自定義欄位(數字)019 */
imcjud020       number(20,6)      ,/* 自定義欄位(數字)020 */
imcjud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
imcjud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
imcjud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
imcjud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
imcjud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
imcjud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
imcjud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
imcjud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
imcjud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
imcjud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table imcj_t add constraint imcj_pk primary key (imcjent,imcj001,imcj002,imcj003) enable validate;

create unique index imcj_pk on imcj_t (imcjent,imcj001,imcj002,imcj003);

grant select on imcj_t to tiptop;
grant update on imcj_t to tiptop;
grant delete on imcj_t to tiptop;
grant insert on imcj_t to tiptop;

exit;
