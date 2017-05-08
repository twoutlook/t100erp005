/* 
================================================================================
檔案代號:gcas_t
檔案名稱:券種基本資料檔-提貨商品設定
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table gcas_t
(
gcasent       number(5)      ,/* 企業編號 */
gcas001       varchar2(10)      ,/* 券種編碼 */
gcasseq       number(10,0)      ,/* 項次 */
gcas002       varchar2(10)      ,/* 券面額編號 */
gcas003       varchar2(40)      ,/* 提貨商品編號 */
gcas004       varchar2(256)      ,/* 產品特徵 */
gcas005       number(20,6)      ,/* 提貨數量 */
gcas006       varchar2(10)      ,/* 提貨商品類型 */
gcas007       number(20,6)      ,/* 換貨加價 */
gcas008       number(20,6)      ,/* 券單位金額 */
gcas009       number(20,6)      ,/* 換貨允許價差% */
gcasstus       varchar2(1)      ,/* 有效 */
gcasud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gcasud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gcasud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gcasud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gcasud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gcasud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gcasud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gcasud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gcasud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gcasud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gcasud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gcasud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gcasud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gcasud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gcasud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gcasud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gcasud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gcasud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gcasud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gcasud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gcasud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gcasud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gcasud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gcasud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gcasud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gcasud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gcasud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gcasud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gcasud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gcasud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table gcas_t add constraint gcas_pk primary key (gcasent,gcas001,gcasseq) enable validate;

create unique index gcas_pk on gcas_t (gcasent,gcas001,gcasseq);

grant select on gcas_t to tiptop;
grant update on gcas_t to tiptop;
grant delete on gcas_t to tiptop;
grant insert on gcas_t to tiptop;

exit;
