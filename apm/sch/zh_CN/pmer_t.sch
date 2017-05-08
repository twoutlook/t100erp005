/* 
================================================================================
檔案代號:pmer_t
檔案名稱:要貨模板基本資料身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pmer_t
(
pmerent       number(5)      ,/* 企業編號 */
pmerunit       varchar2(10)      ,/* 應用組織 */
pmer001       varchar2(10)      ,/* 要貨模板編號 */
pmerseq       number(10,0)      ,/* 項次 */
pmer002       varchar2(40)      ,/* 商品條碼 */
pmer003       varchar2(40)      ,/* 商品編號 */
pmer004       varchar2(10)      ,/* 要貨包裝單位 */
pmer005       number(20,6)      ,/* 要貨包裝數量 */
pmer006       varchar2(10)      ,/* 要貨單位 */
pmer007       number(20,6)      ,/* 要貨數量 */
pmerstus       varchar2(10)      ,/* 狀態碼 */
pmerud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmerud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmerud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmerud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmerud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmerud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmerud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmerud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmerud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmerud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmerud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmerud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmerud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmerud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmerud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmerud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmerud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmerud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmerud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmerud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmerud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmerud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmerud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmerud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmerud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmerud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmerud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmerud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmerud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmerud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pmer_t add constraint pmer_pk primary key (pmerent,pmer001,pmerseq) enable validate;

create unique index pmer_pk on pmer_t (pmerent,pmer001,pmerseq);

grant select on pmer_t to tiptop;
grant update on pmer_t to tiptop;
grant delete on pmer_t to tiptop;
grant insert on pmer_t to tiptop;

exit;
