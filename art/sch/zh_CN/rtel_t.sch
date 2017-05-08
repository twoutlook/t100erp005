/* 
================================================================================
檔案代號:rtel_t
檔案名稱:商戶商品引進單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table rtel_t
(
rtelent       number(5)      ,/* 企業編號 */
rtelsite       varchar2(10)      ,/* 營運組織 */
rtelunit       varchar2(10)      ,/* 應用組織 */
rteldocno       varchar2(20)      ,/* 單據編號 */
rtelseq       number(10,0)      ,/* 項次 */
rtel001       varchar2(1)      ,/* 條碼分類 */
rtel002       varchar2(40)      ,/* 商品條碼 */
rtel003       varchar2(40)      ,/* 商品編號 */
rtel004       varchar2(10)      ,/* 銷售單位 */
rtel005       varchar2(10)      ,/* 產地 */
rtel006       varchar2(80)      ,/* 產地說明 */
rtel007       varchar2(10)      ,/* 產品品類 */
rtel008       varchar2(10)      ,/* 品牌 */
rtel009       varchar2(10)      ,/* 系列 */
rtel010       varchar2(10)      ,/* 類型 */
rtel011       varchar2(10)      ,/* 功能 */
rtel012       varchar2(80)      ,/* 成份 */
rtel013       number(20,6)      ,/* 進價 */
rtel014       number(20,6)      ,/* 售價 */
rtel015       number(20,6)      ,/* 會員價一 */
rtel016       number(20,6)      ,/* 會員價二 */
rtel017       number(20,6)      ,/* 會員價三 */
rtelacti       varchar2(1)      ,/* 資料有效碼 */
rtelud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rtelud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rtelud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rtelud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rtelud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rtelud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rtelud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rtelud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rtelud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rtelud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rtelud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rtelud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rtelud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rtelud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rtelud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rtelud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rtelud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rtelud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rtelud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rtelud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rtelud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rtelud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rtelud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rtelud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rtelud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rtelud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rtelud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rtelud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rtelud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rtelud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
rtel018       varchar2(80)      ,/* 輔材 */
rtel019       varchar2(10)      ,/* 庫區 */
rtel020       varchar2(80)      ,/* 等級 */
rtel021       varchar2(80)      ,/* 顏色 */
rtel022       varchar2(80)      ,/* 型號 */
rtel023       varchar2(10)      /* 條碼類型 */
);
alter table rtel_t add constraint rtel_pk primary key (rtelent,rteldocno,rtelseq) enable validate;

create unique index rtel_pk on rtel_t (rtelent,rteldocno,rtelseq);

grant select on rtel_t to tiptop;
grant update on rtel_t to tiptop;
grant delete on rtel_t to tiptop;
grant insert on rtel_t to tiptop;

exit;
