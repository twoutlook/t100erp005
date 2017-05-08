/* 
================================================================================
檔案代號:bmlc_t
檔案名稱:FAS組合元件檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table bmlc_t
(
bmlcent       number(5)      ,/* 企業編號 */
bmlc001       varchar2(40)      ,/* 範本主件料號 */
bmlc002       varchar2(30)      ,/* 特性 */
bmlc003       varchar2(10)      ,/* FAS群組 */
bmlc004       varchar2(40)      ,/* 元件料號 */
bmlc005       varchar2(40)      ,/* 料件編碼 */
bmlc006       varchar2(255)      ,/* 品名編碼 */
bmlc007       varchar2(255)      ,/* 規格編碼 */
bmlc008       varchar2(256)      ,/* 產品特徵 */
bmlcud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bmlcud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bmlcud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bmlcud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bmlcud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bmlcud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bmlcud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bmlcud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bmlcud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bmlcud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bmlcud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bmlcud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bmlcud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bmlcud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bmlcud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bmlcud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bmlcud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bmlcud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bmlcud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bmlcud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bmlcud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bmlcud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bmlcud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bmlcud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bmlcud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bmlcud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bmlcud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bmlcud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bmlcud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bmlcud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bmlc_t add constraint bmlc_pk primary key (bmlcent,bmlc001,bmlc002,bmlc003,bmlc004) enable validate;

create unique index bmlc_pk on bmlc_t (bmlcent,bmlc001,bmlc002,bmlc003,bmlc004);

grant select on bmlc_t to tiptop;
grant update on bmlc_t to tiptop;
grant delete on bmlc_t to tiptop;
grant insert on bmlc_t to tiptop;

exit;
