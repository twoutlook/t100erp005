/* 
================================================================================
檔案代號:gcap_t
檔案名稱:券種基本資料申請檔-發行面額設定
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table gcap_t
(
gcapent       number(5)      ,/* 企業編號 */
gcapsite       varchar2(10)      ,/* 營運據點 */
gcapunit       varchar2(10)      ,/* 應用組織 */
gcapdocno       varchar2(20)      ,/* 單據編號 */
gcap000       varchar2(10)      ,/* 申請類別 */
gcap001       varchar2(10)      ,/* 券種編碼 */
gcap002       varchar2(10)      ,/* 券面額編號 */
gcap003       varchar2(40)      ,/* 券對應商品編號 */
gcap004       varchar2(256)      ,/* 產品特徵 */
gcap005       number(20,6)      ,/* 券單位金額 */
gcapacti       varchar2(1)      ,/* 有效 */
gcapud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gcapud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gcapud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gcapud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gcapud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gcapud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gcapud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gcapud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gcapud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gcapud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gcapud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gcapud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gcapud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gcapud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gcapud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gcapud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gcapud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gcapud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gcapud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gcapud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gcapud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gcapud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gcapud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gcapud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gcapud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gcapud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gcapud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gcapud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gcapud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gcapud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table gcap_t add constraint gcap_pk primary key (gcapent,gcapdocno,gcap001,gcap002) enable validate;

create unique index gcap_pk on gcap_t (gcapent,gcapdocno,gcap001,gcap002);

grant select on gcap_t to tiptop;
grant update on gcap_t to tiptop;
grant delete on gcap_t to tiptop;
grant insert on gcap_t to tiptop;

exit;
