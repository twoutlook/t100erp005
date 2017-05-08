/* 
================================================================================
檔案代號:imcn_t
檔案名稱:料件主分群特徵檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table imcn_t
(
imcnent       number(5)      ,/* 企業編號 */
imcn001       varchar2(10)      ,/* 主分群碼 */
imcn002       varchar2(10)      ,/* 特徵類型 */
imcn003       varchar2(30)      ,/* 特徵值 */
imcnud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
imcnud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
imcnud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
imcnud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
imcnud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
imcnud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
imcnud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
imcnud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
imcnud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
imcnud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
imcnud011       number(20,6)      ,/* 自定義欄位(數字)011 */
imcnud012       number(20,6)      ,/* 自定義欄位(數字)012 */
imcnud013       number(20,6)      ,/* 自定義欄位(數字)013 */
imcnud014       number(20,6)      ,/* 自定義欄位(數字)014 */
imcnud015       number(20,6)      ,/* 自定義欄位(數字)015 */
imcnud016       number(20,6)      ,/* 自定義欄位(數字)016 */
imcnud017       number(20,6)      ,/* 自定義欄位(數字)017 */
imcnud018       number(20,6)      ,/* 自定義欄位(數字)018 */
imcnud019       number(20,6)      ,/* 自定義欄位(數字)019 */
imcnud020       number(20,6)      ,/* 自定義欄位(數字)020 */
imcnud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
imcnud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
imcnud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
imcnud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
imcnud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
imcnud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
imcnud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
imcnud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
imcnud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
imcnud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table imcn_t add constraint imcn_pk primary key (imcnent,imcn001,imcn002) enable validate;

create unique index imcn_pk on imcn_t (imcnent,imcn001,imcn002);

grant select on imcn_t to tiptop;
grant update on imcn_t to tiptop;
grant delete on imcn_t to tiptop;
grant insert on imcn_t to tiptop;

exit;
