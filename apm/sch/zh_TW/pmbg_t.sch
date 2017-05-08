/* 
================================================================================
檔案代號:pmbg_t
檔案名稱:交易對象准入-證照檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pmbg_t
(
pmbgent       number(5)      ,/* 企業編號 */
pmbgdocno       varchar2(20)      ,/* 單號 */
pmbg001       varchar2(10)      ,/* 交易對象編號 */
pmbg002       varchar2(10)      ,/* 證照類型 */
pmbg003       varchar2(40)      ,/* 證照編號 */
pmbg004       varchar2(255)      ,/* 證照名稱 */
pmbg005       varchar2(10)      ,/* 經營品類 */
pmbg006       varchar2(40)      ,/* 商品編號 */
pmbg007       date      ,/* 生效日期 */
pmbg008       date      ,/* 失效日期 */
pmbg009       varchar2(10)      ,/* 證照提供組織 */
pmbgacti       varchar2(1)      ,/* 資料有效碼 */
pmbgud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmbgud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmbgud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmbgud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmbgud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmbgud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmbgud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmbgud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmbgud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmbgud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmbgud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmbgud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmbgud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmbgud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmbgud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmbgud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmbgud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmbgud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmbgud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmbgud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmbgud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmbgud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmbgud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmbgud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmbgud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmbgud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmbgud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmbgud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmbgud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmbgud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pmbg_t add constraint pmbg_pk primary key (pmbgent,pmbgdocno,pmbg002,pmbg003) enable validate;

create unique index pmbg_pk on pmbg_t (pmbgent,pmbgdocno,pmbg002,pmbg003);

grant select on pmbg_t to tiptop;
grant update on pmbg_t to tiptop;
grant delete on pmbg_t to tiptop;
grant insert on pmbg_t to tiptop;

exit;
