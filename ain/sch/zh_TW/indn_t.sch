/* 
================================================================================
檔案代號:indn_t
檔案名稱:退貨申請單單身明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table indn_t
(
indnent       number(5)      ,/* 企業代碼 */
indnsite       varchar2(10)      ,/* 營運據點 */
indnunit       varchar2(10)      ,/* 應用組織 */
indndocno       varchar2(20)      ,/* 單號 */
indnseq       number(10,0)      ,/* 項次 */
indn001       varchar2(40)      ,/* 商品編號 */
indn002       varchar2(40)      ,/* 商品主條碼 */
indn003       varchar2(256)      ,/* 產品特徵 */
indn004       varchar2(10)      ,/* 庫區 */
indn005       varchar2(10)      ,/* 儲位 */
indn006       varchar2(30)      ,/* 批號 */
indn007       varchar2(10)      ,/* 退貨單位 */
indn008       varchar2(10)      ,/* 包裝單位 */
indn009       number(20,6)      ,/* 件裝數 */
indn010       number(20,6)      ,/* 申請包裝數量 */
indn011       number(20,6)      ,/* 申請退貨數量 */
indn012       number(20,6)      ,/* 核准包裝數量 */
indn013       number(20,6)      ,/* 核准退貨數量 */
indn014       number(20,6)      ,/* 未核准包裝數量 */
indn015       number(20,6)      ,/* 未核准退貨數量 */
indn016       number(20,6)      ,/* 退貨數量 */
indn017       number(20,6)      ,/* 退貨包裝數量 */
indn018       varchar2(10)      ,/* 採購類型 */
indn019       varchar2(10)      ,/* 配送中心 */
indn020       varchar2(10)      ,/* 供應商 */
indn021       varchar2(10)      ,/* 理由碼 */
indn022       varchar2(10)      ,/* 已轉退貨單 */
indn023       varchar2(20)      ,/* 退貨單號 */
indn024       number(10,0)      ,/* 退貨項次 */
indn025       varchar2(20)      ,/* 收貨單號 */
indn026       number(10,0)      ,/* 收貨項次 */
indn027       varchar2(255)      ,/* 備註 */
indn028       varchar2(30)      ,/* 庫存管理特徵 */
indnud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
indnud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
indnud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
indnud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
indnud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
indnud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
indnud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
indnud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
indnud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
indnud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
indnud011       number(20,6)      ,/* 自定義欄位(數字)011 */
indnud012       number(20,6)      ,/* 自定義欄位(數字)012 */
indnud013       number(20,6)      ,/* 自定義欄位(數字)013 */
indnud014       number(20,6)      ,/* 自定義欄位(數字)014 */
indnud015       number(20,6)      ,/* 自定義欄位(數字)015 */
indnud016       number(20,6)      ,/* 自定義欄位(數字)016 */
indnud017       number(20,6)      ,/* 自定義欄位(數字)017 */
indnud018       number(20,6)      ,/* 自定義欄位(數字)018 */
indnud019       number(20,6)      ,/* 自定義欄位(數字)019 */
indnud020       number(20,6)      ,/* 自定義欄位(數字)020 */
indnud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
indnud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
indnud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
indnud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
indnud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
indnud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
indnud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
indnud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
indnud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
indnud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table indn_t add constraint indn_pk primary key (indnent,indndocno,indnseq) enable validate;

create unique index indn_pk on indn_t (indnent,indndocno,indnseq);

grant select on indn_t to tiptop;
grant update on indn_t to tiptop;
grant delete on indn_t to tiptop;
grant insert on indn_t to tiptop;

exit;
