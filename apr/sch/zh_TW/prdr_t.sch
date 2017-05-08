/* 
================================================================================
檔案代號:prdr_t
檔案名稱:促銷規則商品範圍檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table prdr_t
(
prdrent       number(5)      ,/* 企業編號 */
prdrunit       varchar2(10)      ,/* 應用組織 */
prdrsite       varchar2(10)      ,/* 營運據點 */
prdr001       varchar2(20)      ,/* 規則編號 */
prdr002       number(10,0)      ,/* 組別 */
prdr003       varchar2(10)      ,/* 屬性 */
prdr004       varchar2(40)      ,/* 屬性代碼 */
prdr005       varchar2(40)      ,/* 商品條碼 */
prdr006       varchar2(10)      ,/* 單位 */
prdr007       number(20,6)      ,/* 成本價 */
prdr008       number(20,6)      ,/* 目標數量 */
prdr009       number(20,6)      ,/* 目標金額 */
prdr010       number(10,0)      ,/* 條件組別 */
prdrstus       varchar2(10)      ,/* 有效否 */
prdrud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
prdrud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
prdrud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
prdrud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
prdrud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
prdrud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
prdrud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
prdrud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
prdrud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
prdrud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
prdrud011       number(20,6)      ,/* 自定義欄位(數字)011 */
prdrud012       number(20,6)      ,/* 自定義欄位(數字)012 */
prdrud013       number(20,6)      ,/* 自定義欄位(數字)013 */
prdrud014       number(20,6)      ,/* 自定義欄位(數字)014 */
prdrud015       number(20,6)      ,/* 自定義欄位(數字)015 */
prdrud016       number(20,6)      ,/* 自定義欄位(數字)016 */
prdrud017       number(20,6)      ,/* 自定義欄位(數字)017 */
prdrud018       number(20,6)      ,/* 自定義欄位(數字)018 */
prdrud019       number(20,6)      ,/* 自定義欄位(數字)019 */
prdrud020       number(20,6)      ,/* 自定義欄位(數字)020 */
prdrud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
prdrud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
prdrud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
prdrud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
prdrud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
prdrud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
prdrud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
prdrud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
prdrud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
prdrud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
prdr011       varchar2(10)      /* 方向 */
);
alter table prdr_t add constraint prdr_pk primary key (prdrent,prdr001,prdr002,prdr003,prdr004) enable validate;

create unique index prdr_pk on prdr_t (prdrent,prdr001,prdr002,prdr003,prdr004);

grant select on prdr_t to tiptop;
grant update on prdr_t to tiptop;
grant delete on prdr_t to tiptop;
grant insert on prdr_t to tiptop;

exit;
