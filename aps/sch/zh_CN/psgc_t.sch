/* 
================================================================================
檔案代號:psgc_t
檔案名稱:集團MRP建議調撥明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table psgc_t
(
psgcent       number(5)      ,/* 企業編號 */
psgc001       varchar2(10)      ,/* 集團MRP版本 */
psgcseq       number(10,0)      ,/* 項次 */
psgc002       varchar2(40)      ,/* 料件編號 */
psgc003       varchar2(256)      ,/* 產品特徵 */
psgc004       date      ,/* 日期 */
psgc005       varchar2(10)      ,/* 撥出營運據點 */
psgc006       varchar2(10)      ,/* 撥入營運據點 */
psgc007       number(20,6)      ,/* 調撥數量 */
psgc008       varchar2(1)      ,/* 已轉單 */
psgcud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
psgcud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
psgcud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
psgcud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
psgcud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
psgcud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
psgcud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
psgcud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
psgcud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
psgcud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
psgcud011       number(20,6)      ,/* 自定義欄位(數字)011 */
psgcud012       number(20,6)      ,/* 自定義欄位(數字)012 */
psgcud013       number(20,6)      ,/* 自定義欄位(數字)013 */
psgcud014       number(20,6)      ,/* 自定義欄位(數字)014 */
psgcud015       number(20,6)      ,/* 自定義欄位(數字)015 */
psgcud016       number(20,6)      ,/* 自定義欄位(數字)016 */
psgcud017       number(20,6)      ,/* 自定義欄位(數字)017 */
psgcud018       number(20,6)      ,/* 自定義欄位(數字)018 */
psgcud019       number(20,6)      ,/* 自定義欄位(數字)019 */
psgcud020       number(20,6)      ,/* 自定義欄位(數字)020 */
psgcud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
psgcud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
psgcud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
psgcud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
psgcud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
psgcud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
psgcud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
psgcud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
psgcud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
psgcud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table psgc_t add constraint psgc_pk primary key (psgcent,psgc001,psgcseq) enable validate;

create unique index psgc_pk on psgc_t (psgcent,psgc001,psgcseq);

grant select on psgc_t to tiptop;
grant update on psgc_t to tiptop;
grant delete on psgc_t to tiptop;
grant insert on psgc_t to tiptop;

exit;
