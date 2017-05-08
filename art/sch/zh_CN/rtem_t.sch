/* 
================================================================================
檔案代號:rtem_t
檔案名稱:商戶商品對照表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table rtem_t
(
rtement       number(5)      ,/* 企業編號 */
rtemsite       varchar2(10)      ,/* 營運據點 */
rtem001       varchar2(20)      ,/* 鋪位編號 */
rtem002       varchar2(10)      ,/* 商戶編號 */
rtem003       varchar2(40)      ,/* 商品編號 */
rtem004       varchar2(10)      ,/* 商品屬性一 */
rtem005       varchar2(10)      ,/* 商品屬性二 */
rtem006       varchar2(10)      ,/* 商品屬性三 */
rtem007       varchar2(10)      ,/* 商品屬性四 */
rtem008       varchar2(10)      ,/* 商品屬性五 */
rtem009       varchar2(10)      ,/* 商品屬性六 */
rtem010       varchar2(10)      ,/* 商品屬性七 */
rtem011       varchar2(10)      ,/* 商品屬性八 */
rtem012       varchar2(10)      ,/* 商品屬性九 */
rtem013       varchar2(10)      ,/* 商品屬性十 */
rtemstus       varchar2(10)      ,/* 狀態碼 */
rtemud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rtemud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rtemud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rtemud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rtemud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rtemud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rtemud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rtemud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rtemud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rtemud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rtemud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rtemud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rtemud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rtemud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rtemud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rtemud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rtemud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rtemud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rtemud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rtemud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rtemud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rtemud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rtemud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rtemud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rtemud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rtemud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rtemud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rtemud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rtemud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rtemud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table rtem_t add constraint rtem_pk primary key (rtement,rtemsite,rtem001,rtem002,rtem003) enable validate;

create unique index rtem_pk on rtem_t (rtement,rtemsite,rtem001,rtem002,rtem003);

grant select on rtem_t to tiptop;
grant update on rtem_t to tiptop;
grant delete on rtem_t to tiptop;
grant insert on rtem_t to tiptop;

exit;
