/* 
================================================================================
檔案代號:gcar_t
檔案名稱:券種基本資料檔-發行面額設定
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table gcar_t
(
gcarent       number(5)      ,/* 企業編號 */
gcar001       varchar2(10)      ,/* 券種編碼 */
gcar002       varchar2(10)      ,/* 券面額編號 */
gcar003       varchar2(40)      ,/* 券對應商品編號 */
gcar004       varchar2(256)      ,/* 產品特徵 */
gcar005       number(20,6)      ,/* 券單位金額 */
gcarstus       varchar2(1)      ,/* 有效 */
gcarud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gcarud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gcarud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gcarud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gcarud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gcarud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gcarud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gcarud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gcarud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gcarud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gcarud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gcarud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gcarud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gcarud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gcarud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gcarud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gcarud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gcarud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gcarud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gcarud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gcarud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gcarud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gcarud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gcarud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gcarud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gcarud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gcarud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gcarud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gcarud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gcarud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table gcar_t add constraint gcar_pk primary key (gcarent,gcar001,gcar002) enable validate;

create unique index gcar_pk on gcar_t (gcarent,gcar001,gcar002);

grant select on gcar_t to tiptop;
grant update on gcar_t to tiptop;
grant delete on gcar_t to tiptop;
grant insert on gcar_t to tiptop;

exit;
