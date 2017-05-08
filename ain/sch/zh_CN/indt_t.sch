/* 
================================================================================
檔案代號:indt_t
檔案名稱:批號進價更正單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table indt_t
(
indtent       number(5)      ,/* 企業編號 */
indtsite       varchar2(10)      ,/* 營運據點 */
indtunit       varchar2(10)      ,/* 應用組織 */
indtdocno       varchar2(20)      ,/* 單據編號 */
indtseq       number(10,0)      ,/* 項次 */
indt001       varchar2(30)      ,/* 批號 */
indt002       varchar2(10)      ,/* 庫區編號 */
indt003       varchar2(40)      ,/* 商品條碼 */
indt004       varchar2(40)      ,/* 商品編號 */
indt005       varchar2(256)      ,/* 產品特徵 */
indt006       number(20,6)      ,/* 批號原進價 */
indt007       number(20,6)      ,/* 批號新進價 */
indt008       varchar2(30)      ,/* 庫存管理特徵 */
indtud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
indtud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
indtud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
indtud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
indtud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
indtud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
indtud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
indtud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
indtud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
indtud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
indtud011       number(20,6)      ,/* 自定義欄位(數字)011 */
indtud012       number(20,6)      ,/* 自定義欄位(數字)012 */
indtud013       number(20,6)      ,/* 自定義欄位(數字)013 */
indtud014       number(20,6)      ,/* 自定義欄位(數字)014 */
indtud015       number(20,6)      ,/* 自定義欄位(數字)015 */
indtud016       number(20,6)      ,/* 自定義欄位(數字)016 */
indtud017       number(20,6)      ,/* 自定義欄位(數字)017 */
indtud018       number(20,6)      ,/* 自定義欄位(數字)018 */
indtud019       number(20,6)      ,/* 自定義欄位(數字)019 */
indtud020       number(20,6)      ,/* 自定義欄位(數字)020 */
indtud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
indtud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
indtud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
indtud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
indtud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
indtud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
indtud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
indtud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
indtud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
indtud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table indt_t add constraint indt_pk primary key (indtent,indtdocno,indtseq) enable validate;

create unique index indt_pk on indt_t (indtent,indtdocno,indtseq);

grant select on indt_t to tiptop;
grant update on indt_t to tiptop;
grant delete on indt_t to tiptop;
grant insert on indt_t to tiptop;

exit;
