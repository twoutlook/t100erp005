/* 
================================================================================
檔案代號:pmem_t
檔案名稱:收貨送貨預約單身明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pmem_t
(
pmement       number(5)      ,/* 企業編號 */
pmemsite       varchar2(10)      ,/* 營運據點 */
pmemunit       varchar2(10)      ,/* 應用組織 */
pmemdocno       varchar2(20)      ,/* 單據編號 */
pmemseq       number(10,0)      ,/* 項次 */
pmem000       varchar2(10)      ,/* 單據類型 */
pmem001       varchar2(20)      ,/* 採購出貨單據編號 */
pmem002       number(10,0)      ,/* 採購出貨單據項次 */
pmem003       number(10,0)      ,/* 採購出貨單據項序 */
pmem004       number(10,0)      ,/* 分批序 */
pmem005       varchar2(10)      ,/* 子件特性 */
pmem006       varchar2(40)      ,/* 商品條碼 */
pmem007       varchar2(40)      ,/* 料件編號 */
pmem008       varchar2(256)      ,/* 產品特徵 */
pmem009       varchar2(10)      ,/* 收貨/送貨包裝單位 */
pmem010       number(20,6)      ,/* 預約收貨/送貨包裝數量 */
pmem011       varchar2(10)      ,/* 收貨/送貨單位 */
pmem012       number(20,6)      ,/* 預約收貨/送貨數量 */
pmem013       number(20,6)      ,/* 實際收貨/送貨數量 */
pmem014       varchar2(10)      ,/* 限定庫位 */
pmem015       varchar2(10)      ,/* 限定儲位 */
pmem016       varchar2(30)      ,/* 限定批號 */
pmem017       varchar2(10)      ,/* 採購組織 */
pmem018       varchar2(10)      ,/* 採購中心 */
pmem019       varchar2(10)      ,/* 要貨組織 */
pmem020       varchar2(255)      ,/* 備註 */
pmem021       varchar2(10)      ,/* 銷售組織 */
pmemud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmemud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmemud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmemud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmemud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmemud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmemud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmemud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmemud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmemud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmemud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmemud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmemud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmemud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmemud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmemud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmemud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmemud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmemud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmemud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmemud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmemud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmemud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmemud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmemud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmemud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmemud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmemud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmemud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmemud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
pmem022       varchar2(30)      /* 庫存管理特徵 */
);
alter table pmem_t add constraint pmem_pk primary key (pmement,pmemdocno,pmemseq) enable validate;

create  index pmem_n on pmem_t (pmement,pmem001,pmem002,pmem003,pmem004);
create unique index pmem_pk on pmem_t (pmement,pmemdocno,pmemseq);

grant select on pmem_t to tiptop;
grant update on pmem_t to tiptop;
grant delete on pmem_t to tiptop;
grant insert on pmem_t to tiptop;

exit;
