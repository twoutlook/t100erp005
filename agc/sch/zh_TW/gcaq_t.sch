/* 
================================================================================
檔案代號:gcaq_t
檔案名稱:券種基本資料申請檔-提貨商品設定
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table gcaq_t
(
gcaqent       number(5)      ,/* 企業編號 */
gcaqsite       varchar2(10)      ,/* 營運據點 */
gcaqunit       varchar2(10)      ,/* 應用組織 */
gcaqdocno       varchar2(20)      ,/* 單據編號 */
gcaq000       varchar2(10)      ,/* 申請種類 */
gcaq001       varchar2(10)      ,/* 券種編碼 */
gcaqseq       number(10,0)      ,/* 項次 */
gcaq002       varchar2(10)      ,/* 券面額編號 */
gcaq003       varchar2(40)      ,/* 提貨商品編號 */
gcaq004       varchar2(256)      ,/* 產品特徵 */
gcaq005       number(20,6)      ,/* 提貨數量 */
gcaq006       varchar2(10)      ,/* 提貨商品類型 */
gcaq007       number(20,6)      ,/* 換貨加價 */
gcaq008       number(20,6)      ,/* 券單位金額 */
gcaq009       number(20,6)      ,/* 換貨允許價差% */
gcaqacti       varchar2(1)      ,/* 有效 */
gcaqud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gcaqud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gcaqud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gcaqud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gcaqud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gcaqud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gcaqud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gcaqud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gcaqud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gcaqud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gcaqud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gcaqud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gcaqud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gcaqud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gcaqud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gcaqud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gcaqud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gcaqud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gcaqud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gcaqud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gcaqud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gcaqud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gcaqud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gcaqud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gcaqud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gcaqud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gcaqud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gcaqud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gcaqud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gcaqud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table gcaq_t add constraint gcaq_pk primary key (gcaqent,gcaqdocno,gcaq001,gcaqseq) enable validate;

create unique index gcaq_pk on gcaq_t (gcaqent,gcaqdocno,gcaq001,gcaqseq);

grant select on gcaq_t to tiptop;
grant update on gcaq_t to tiptop;
grant delete on gcaq_t to tiptop;
grant insert on gcaq_t to tiptop;

exit;
