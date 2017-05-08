/* 
================================================================================
檔案代號:pmbx_t
檔案名稱:交易對象准入-經銷商經營品牌
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pmbx_t
(
pmbxent       number(5)      ,/* 企業編號 */
pmbxdocno       varchar2(20)      ,/* 單據編號 */
pmbx001       varchar2(10)      ,/* 交易對象編號 */
pmbx002       varchar2(10)      ,/* 商品品類 */
pmbx003       varchar2(10)      ,/* 商品品牌 */
pmbxacti       varchar2(1)      ,/* 資料有效碼 */
pmbxud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmbxud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmbxud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmbxud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmbxud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmbxud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmbxud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmbxud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmbxud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmbxud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmbxud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmbxud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmbxud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmbxud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmbxud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmbxud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmbxud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmbxud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmbxud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmbxud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmbxud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmbxud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmbxud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmbxud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmbxud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmbxud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmbxud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmbxud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmbxud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmbxud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pmbx_t add constraint pmbx_pk primary key (pmbxent,pmbxdocno,pmbx002,pmbx003) enable validate;

create unique index pmbx_pk on pmbx_t (pmbxent,pmbxdocno,pmbx002,pmbx003);

grant select on pmbx_t to tiptop;
grant update on pmbx_t to tiptop;
grant delete on pmbx_t to tiptop;
grant insert on pmbx_t to tiptop;

exit;
