/* 
================================================================================
檔案代號:sfjc_t
檔案名稱:工單下階料報廢明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table sfjc_t
(
sfjcent       number(5)      ,/* 企業編號 */
sfjcsite       varchar2(10)      ,/* 營運據點 */
sfjcdocno       varchar2(20)      ,/* 報廢單號 */
sfjcseq       number(10,0)      ,/* 項次 */
sfjcseq1       number(10,0)      ,/* 項序 */
sfjc001       varchar2(20)      ,/* 工單單號 */
sfjc002       number(10,0)      ,/* 工單項次 */
sfjc003       varchar2(40)      ,/* 料件編號 */
sfjc004       varchar2(256)      ,/* 產品特徵 */
sfjc005       varchar2(10)      ,/* 單位 */
sfjc006       number(20,6)      ,/* 報廢數量 */
sfjc007       varchar2(10)      ,/* 參考單位 */
sfjc008       number(20,6)      ,/* 參考數量 */
sfjc009       varchar2(10)      ,/* 理由碼 */
sfjc010       varchar2(10)      ,/* 預計處理方式 */
sfjc011       varchar2(10)      ,/* 庫位 */
sfjc012       varchar2(10)      ,/* 儲位 */
sfjc013       varchar2(30)      ,/* 批號 */
sfjc014       varchar2(30)      ,/* 庫存管理特徵 */
sfjc015       number(10,0)      ,/* 工單項序 */
sfjcud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
sfjcud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
sfjcud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
sfjcud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
sfjcud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
sfjcud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
sfjcud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
sfjcud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
sfjcud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
sfjcud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
sfjcud011       number(20,6)      ,/* 自定義欄位(數字)011 */
sfjcud012       number(20,6)      ,/* 自定義欄位(數字)012 */
sfjcud013       number(20,6)      ,/* 自定義欄位(數字)013 */
sfjcud014       number(20,6)      ,/* 自定義欄位(數字)014 */
sfjcud015       number(20,6)      ,/* 自定義欄位(數字)015 */
sfjcud016       number(20,6)      ,/* 自定義欄位(數字)016 */
sfjcud017       number(20,6)      ,/* 自定義欄位(數字)017 */
sfjcud018       number(20,6)      ,/* 自定義欄位(數字)018 */
sfjcud019       number(20,6)      ,/* 自定義欄位(數字)019 */
sfjcud020       number(20,6)      ,/* 自定義欄位(數字)020 */
sfjcud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
sfjcud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
sfjcud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
sfjcud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
sfjcud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
sfjcud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
sfjcud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
sfjcud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
sfjcud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
sfjcud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
sfjc016       varchar2(40)      ,/* 生產料號 */
sfjc017       varchar2(30)      ,/* BOM特性 */
sfjc018       varchar2(30)      ,/* 產品特徵 */
sfjc019       varchar2(10)      /* 生產計劃 */
);
alter table sfjc_t add constraint sfjc_pk primary key (sfjcent,sfjcdocno,sfjcseq,sfjcseq1) enable validate;

create unique index sfjc_pk on sfjc_t (sfjcent,sfjcdocno,sfjcseq,sfjcseq1);

grant select on sfjc_t to tiptop;
grant update on sfjc_t to tiptop;
grant delete on sfjc_t to tiptop;
grant insert on sfjc_t to tiptop;

exit;
