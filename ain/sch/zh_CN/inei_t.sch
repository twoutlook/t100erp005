/* 
================================================================================
檔案代號:inei_t
檔案名稱:盤點多庫儲批明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table inei_t
(
ineient       number(5)      ,/* 企業編號 */
ineisite       varchar2(10)      ,/* 營運據點 */
ineidocno       varchar2(20)      ,/* 出貨單號 */
ineiseq       number(10,0)      ,/* 項次 */
ineiseq1       number(10,0)      ,/* 項序 */
inei001       varchar2(40)      ,/* 料件編號 */
inei002       varchar2(256)      ,/* 產品特徵 */
inei003       varchar2(10)      ,/* NO USE */
inei004       varchar2(10)      ,/* NO USE */
inei005       varchar2(10)      ,/* 限定庫位 */
inei006       varchar2(10)      ,/* 限定儲位 */
inei007       varchar2(30)      ,/* 限定批號 */
inei008       varchar2(10)      ,/* 單位 */
inei009       number(20,6)      ,/* 出貨數量 */
inei010       varchar2(30)      ,/* 庫存管理特徵 */
ineiud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
ineiud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
ineiud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
ineiud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
ineiud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
ineiud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
ineiud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
ineiud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
ineiud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
ineiud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
ineiud011       number(20,6)      ,/* 自定義欄位(數字)011 */
ineiud012       number(20,6)      ,/* 自定義欄位(數字)012 */
ineiud013       number(20,6)      ,/* 自定義欄位(數字)013 */
ineiud014       number(20,6)      ,/* 自定義欄位(數字)014 */
ineiud015       number(20,6)      ,/* 自定義欄位(數字)015 */
ineiud016       number(20,6)      ,/* 自定義欄位(數字)016 */
ineiud017       number(20,6)      ,/* 自定義欄位(數字)017 */
ineiud018       number(20,6)      ,/* 自定義欄位(數字)018 */
ineiud019       number(20,6)      ,/* 自定義欄位(數字)019 */
ineiud020       number(20,6)      ,/* 自定義欄位(數字)020 */
ineiud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
ineiud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
ineiud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
ineiud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
ineiud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
ineiud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
ineiud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
ineiud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
ineiud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
ineiud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
inei011       number(20,6)      ,/* 成本價 */
inei012       number(20,6)      ,/* 差異金額 */
ineiunit       varchar2(10)      /* 制定組織 */
);
alter table inei_t add constraint inei_pk primary key (ineient,ineidocno,ineiseq,ineiseq1) enable validate;

create unique index inei_pk on inei_t (ineient,ineidocno,ineiseq,ineiseq1);

grant select on inei_t to tiptop;
grant update on inei_t to tiptop;
grant delete on inei_t to tiptop;
grant insert on inei_t to tiptop;

exit;
