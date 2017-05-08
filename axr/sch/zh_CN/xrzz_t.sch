/* 
================================================================================
檔案代號:xrzz_t
檔案名稱:科目核算預覽查詢_Demo
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table xrzz_t
(
xrzzent       number(5)      ,/* 企業編號 */
xrzzcomp       varchar2(10)      ,/* 法人 */
xrzzdocno       varchar2(20)      ,/* 單號 */
xrzzseq       number(10,0)      ,/* 項次 */
xrzzlegl       varchar2(10)      ,/* 核算組織 */
xrzz001       varchar2(24)      ,/* 科目編號 */
xrzz002       varchar2(10)      ,/* 產品類別 */
xrzz003       varchar2(10)      ,/* 業務部門 */
xrzz004       varchar2(10)      ,/* 責任中心 */
xrzz006       varchar2(20)      ,/* 專案代號 */
xrzz008       number(20,6)      ,/* 交易原幣金額 */
xrzz009       number(20,6)      ,/* 本幣未稅金額 */
xrzz007       varchar2(30)      ,/* WBS編號 */
xrzz005       varchar2(10)      ,/* 區域 */
xrzzud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xrzzud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xrzzud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xrzzud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xrzzud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xrzzud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xrzzud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xrzzud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xrzzud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xrzzud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xrzzud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xrzzud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xrzzud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xrzzud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xrzzud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xrzzud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xrzzud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xrzzud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xrzzud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xrzzud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xrzzud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xrzzud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xrzzud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xrzzud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xrzzud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xrzzud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xrzzud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xrzzud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xrzzud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xrzzud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xrzz_t add constraint xrzz_pk primary key (xrzzent,xrzzdocno,xrzzseq) enable validate;

create unique index xrzz_pk on xrzz_t (xrzzent,xrzzdocno,xrzzseq);

grant select on xrzz_t to tiptop;
grant update on xrzz_t to tiptop;
grant delete on xrzz_t to tiptop;
grant insert on xrzz_t to tiptop;

exit;
