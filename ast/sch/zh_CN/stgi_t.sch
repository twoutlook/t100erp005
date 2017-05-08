/* 
================================================================================
檔案代號:stgi_t
檔案名稱:專櫃成本調整單單身明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stgi_t
(
stgient       number(5)      ,/* 企業編號 */
stgisite       varchar2(10)      ,/* 營運組織 */
stgiunit       varchar2(10)      ,/* 應用組織 */
stgidocno       varchar2(20)      ,/* 單據編號 */
stgiseq       number(10,0)      ,/* 項次 */
stgi001       varchar2(40)      ,/* 商品編號 */
stgi002       varchar2(10)      ,/* 庫區編號 */
stgi003       varchar2(10)      ,/* 專櫃編號 */
stgi004       varchar2(10)      ,/* 供應商編號 */
stgi005       date      ,/* 調整日期 */
stgi006       varchar2(10)      ,/* 費用編號 */
stgi007       number(20,6)      ,/* 銷售數量 */
stgi008       number(20,6)      ,/* 原價金額 */
stgi009       number(20,6)      ,/* 實收金額 */
stgi010       number(20,6)      ,/* 成本金額 */
stgi011       number(20,6)      ,/* 標準費率 */
stgi012       number(20,6)      ,/* 執行費率 */
stgi013       number(20,6)      ,/* 調整費率 */
stgi014       number(20,6)      ,/* 調整金額 */
stgiud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
stgiud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
stgiud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
stgiud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
stgiud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
stgiud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
stgiud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
stgiud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
stgiud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
stgiud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
stgiud011       number(20,6)      ,/* 自定義欄位(數字)011 */
stgiud012       number(20,6)      ,/* 自定義欄位(數字)012 */
stgiud013       number(20,6)      ,/* 自定義欄位(數字)013 */
stgiud014       number(20,6)      ,/* 自定義欄位(數字)014 */
stgiud015       number(20,6)      ,/* 自定義欄位(數字)015 */
stgiud016       number(20,6)      ,/* 自定義欄位(數字)016 */
stgiud017       number(20,6)      ,/* 自定義欄位(數字)017 */
stgiud018       number(20,6)      ,/* 自定義欄位(數字)018 */
stgiud019       number(20,6)      ,/* 自定義欄位(數字)019 */
stgiud020       number(20,6)      ,/* 自定義欄位(數字)020 */
stgiud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
stgiud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
stgiud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
stgiud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
stgiud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
stgiud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
stgiud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
stgiud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
stgiud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
stgiud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
stgi015       number(20,6)      /* 實際執行費率 */
);
alter table stgi_t add constraint stgi_pk primary key (stgient,stgidocno,stgiseq) enable validate;

create unique index stgi_pk on stgi_t (stgient,stgidocno,stgiseq);

grant select on stgi_t to tiptop;
grant update on stgi_t to tiptop;
grant delete on stgi_t to tiptop;
grant insert on stgi_t to tiptop;

exit;
