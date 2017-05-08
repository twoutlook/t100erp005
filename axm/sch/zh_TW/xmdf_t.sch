/* 
================================================================================
檔案代號:xmdf_t
檔案名稱:訂單多交期匯總檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table xmdf_t
(
xmdfent       number(5)      ,/* 企業編號 */
xmdfsite       varchar2(10)      ,/* 營運據點 */
xmdfdocno       varchar2(20)      ,/* 訂單單號 */
xmdfseq       number(10,0)      ,/* 訂單項次 */
xmdfseq2       number(10,0)      ,/* 分批序 */
xmdf002       number(20,6)      ,/* 分批數量 */
xmdf003       date      ,/* 約定交貨日期 */
xmdf004       date      ,/* 預計簽收日 */
xmdf005       varchar2(10)      ,/* 出貨時段 */
xmdf006       varchar2(1)      ,/* MRP凍結否 */
xmdf007       varchar2(10)      ,/* 交期類型 */
xmdf200       varchar2(10)      ,/* 庫區/庫位 */
xmdf201       varchar2(10)      ,/* 儲位 */
xmdf202       varchar2(30)      ,/* 批號 */
xmdfunit       varchar2(10)      ,/* 發貨組織 */
xmdfud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmdfud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmdfud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmdfud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmdfud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmdfud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmdfud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmdfud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmdfud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmdfud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmdfud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmdfud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmdfud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmdfud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmdfud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmdfud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmdfud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmdfud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmdfud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmdfud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmdfud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmdfud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmdfud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmdfud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmdfud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmdfud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmdfud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmdfud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmdfud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmdfud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
xmdf203       varchar2(30)      /* 庫存管理特徵 */
);
alter table xmdf_t add constraint xmdf_pk primary key (xmdfent,xmdfdocno,xmdfseq,xmdfseq2) enable validate;

create unique index xmdf_pk on xmdf_t (xmdfent,xmdfdocno,xmdfseq,xmdfseq2);

grant select on xmdf_t to tiptop;
grant update on xmdf_t to tiptop;
grant delete on xmdf_t to tiptop;
grant insert on xmdf_t to tiptop;

exit;
