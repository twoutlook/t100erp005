/* 
================================================================================
檔案代號:xmdm_t
檔案名稱:出貨/簽收/銷退單多庫儲批出貨明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table xmdm_t
(
xmdment       number(5)      ,/* 企業編號 */
xmdmsite       varchar2(10)      ,/* 營運據點 */
xmdmdocno       varchar2(20)      ,/* 出貨單號 */
xmdmseq       number(10,0)      ,/* 項次 */
xmdmseq1       number(10,0)      ,/* 項序 */
xmdm001       varchar2(40)      ,/* 料件編號 */
xmdm002       varchar2(256)      ,/* 產品特徵 */
xmdm003       varchar2(10)      ,/* 作業編號 */
xmdm004       varchar2(10)      ,/* 作業序 */
xmdm005       varchar2(10)      ,/* 限定庫位 */
xmdm006       varchar2(10)      ,/* 限定儲位 */
xmdm007       varchar2(30)      ,/* 限定批號 */
xmdm008       varchar2(10)      ,/* 單位 */
xmdm009       number(20,6)      ,/* 出貨數量 */
xmdm010       varchar2(10)      ,/* 參考單位 */
xmdm011       number(20,6)      ,/* 參考數量 */
xmdm012       number(20,6)      ,/* 已簽收數量 */
xmdm013       number(20,6)      ,/* 已簽退數量 */
xmdm014       number(20,6)      ,/* 已銷退數量 */
xmdm031       number(20,6)      ,/* 簽退數量 */
xmdm032       number(20,6)      ,/* 簽退參考數量 */
xmdm033       varchar2(30)      ,/* 庫存管理特徵 */
xmdmud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmdmud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmdmud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmdmud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmdmud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmdmud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmdmud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmdmud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmdmud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmdmud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmdmud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmdmud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmdmud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmdmud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmdmud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmdmud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmdmud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmdmud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmdmud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmdmud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmdmud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmdmud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmdmud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmdmud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmdmud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmdmud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmdmud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmdmud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmdmud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmdmud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xmdm_t add constraint xmdm_pk primary key (xmdment,xmdmdocno,xmdmseq,xmdmseq1) enable validate;

create unique index xmdm_pk on xmdm_t (xmdment,xmdmdocno,xmdmseq,xmdmseq1);

grant select on xmdm_t to tiptop;
grant update on xmdm_t to tiptop;
grant delete on xmdm_t to tiptop;
grant insert on xmdm_t to tiptop;

exit;
