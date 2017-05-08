/* 
================================================================================
檔案代號:bmlb_t
檔案名稱:FAS組合群組檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table bmlb_t
(
bmlbent       number(5)      ,/* 企業編號 */
bmlb001       varchar2(40)      ,/* 範本主件料號 */
bmlb002       varchar2(30)      ,/* 特性 */
bmlb003       varchar2(10)      ,/* FAS群組 */
bmlb004       number(5,0)      ,/* 順序 */
bmlb005       varchar2(1)      ,/* 允許多選 */
bmlb006       number(15,3)      ,/* 數量下限 */
bmlb007       number(15,3)      ,/* 數量上限 */
bmlb008       varchar2(10)      ,/* 帶入主件產品特徴 */
bmlbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bmlbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bmlbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bmlbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bmlbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bmlbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bmlbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bmlbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bmlbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bmlbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bmlbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bmlbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bmlbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bmlbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bmlbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bmlbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bmlbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bmlbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bmlbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bmlbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bmlbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bmlbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bmlbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bmlbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bmlbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bmlbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bmlbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bmlbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bmlbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bmlbud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bmlb_t add constraint bmlb_pk primary key (bmlbent,bmlb001,bmlb002,bmlb003) enable validate;

create unique index bmlb_pk on bmlb_t (bmlbent,bmlb001,bmlb002,bmlb003);

grant select on bmlb_t to tiptop;
grant update on bmlb_t to tiptop;
grant delete on bmlb_t to tiptop;
grant insert on bmlb_t to tiptop;

exit;
