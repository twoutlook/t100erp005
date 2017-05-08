/* 
================================================================================
檔案代號:sfdf_t
檔案名稱:發退料倉儲批匯總檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:Y
============.========================.==========================================
 */
create table sfdf_t
(
sfdfent       number(5)      ,/* 企業編號 */
sfdfsite       varchar2(10)      ,/* 營運據點 */
sfdfdocno       varchar2(20)      ,/* 發退料單號 */
sfdfseq       number(10,0)      ,/* 項次 */
sfdfseq1       number(10,0)      ,/* 項序 */
sfdf001       varchar2(40)      ,/* 發退料料號 */
sfdf002       number(20,6)      ,/* 替代率 */
sfdf003       varchar2(10)      ,/* 庫位 */
sfdf004       varchar2(10)      ,/* 儲位 */
sfdf005       varchar2(30)      ,/* 批號 */
sfdf006       varchar2(10)      ,/* 單位 */
sfdf007       number(20,6)      ,/* 數量 */
sfdf008       varchar2(10)      ,/* 參考單位 */
sfdf009       number(20,6)      ,/* 參考單位數量 */
sfdf010       varchar2(30)      ,/* 庫存管理特徵 */
sfdf011       varchar2(40)      ,/* 包裝容器 */
sfdf012       number(5,0)      ,/* 正負 */
sfdf013       varchar2(256)      ,/* 產品特徵 */
sfdfud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
sfdfud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
sfdfud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
sfdfud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
sfdfud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
sfdfud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
sfdfud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
sfdfud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
sfdfud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
sfdfud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
sfdfud011       number(20,6)      ,/* 自定義欄位(數字)011 */
sfdfud012       number(20,6)      ,/* 自定義欄位(數字)012 */
sfdfud013       number(20,6)      ,/* 自定義欄位(數字)013 */
sfdfud014       number(20,6)      ,/* 自定義欄位(數字)014 */
sfdfud015       number(20,6)      ,/* 自定義欄位(數字)015 */
sfdfud016       number(20,6)      ,/* 自定義欄位(數字)016 */
sfdfud017       number(20,6)      ,/* 自定義欄位(數字)017 */
sfdfud018       number(20,6)      ,/* 自定義欄位(數字)018 */
sfdfud019       number(20,6)      ,/* 自定義欄位(數字)019 */
sfdfud020       number(20,6)      ,/* 自定義欄位(數字)020 */
sfdfud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
sfdfud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
sfdfud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
sfdfud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
sfdfud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
sfdfud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
sfdfud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
sfdfud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
sfdfud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
sfdfud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table sfdf_t add constraint sfdf_pk primary key (sfdfent,sfdfdocno,sfdfseq,sfdfseq1) enable validate;

create unique index sfdf_pk on sfdf_t (sfdfent,sfdfdocno,sfdfseq,sfdfseq1);

grant select on sfdf_t to tiptop;
grant update on sfdf_t to tiptop;
grant delete on sfdf_t to tiptop;
grant insert on sfdf_t to tiptop;

exit;
