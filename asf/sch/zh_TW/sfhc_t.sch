/* 
================================================================================
檔案代號:sfhc_t
檔案名稱:工單當站下線入庫明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table sfhc_t
(
sfhcent       number(5)      ,/* 企業編號 */
sfhcsite       varchar2(10)      ,/* 營運據點 */
sfhcdocno       varchar2(20)      ,/* 單號 */
sfhcseq       number(10,0)      ,/* 項次 */
sfhcseq1       number(10,0)      ,/* 項序 */
sfhc001       varchar2(40)      ,/* 料件編號 */
sfhc002       varchar2(256)      ,/* 產品特徵 */
sfhc003       varchar2(10)      ,/* 庫位 */
sfhc004       varchar2(10)      ,/* 儲位 */
sfhc005       varchar2(30)      ,/* 批號 */
sfhc006       varchar2(30)      ,/* 庫存管理特徵 */
sfhc007       varchar2(10)      ,/* 單位 */
sfhc008       number(20,6)      ,/* 數量 */
sfhc009       varchar2(10)      ,/* 參考單位 */
sfhc010       number(20,6)      ,/* 參考數量 */
sfhc011       date      ,/* 生效日期 */
sfhc012       varchar2(4000)      ,/* 存貨備註 */
sfhcud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
sfhcud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
sfhcud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
sfhcud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
sfhcud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
sfhcud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
sfhcud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
sfhcud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
sfhcud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
sfhcud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
sfhcud011       number(20,6)      ,/* 自定義欄位(數字)011 */
sfhcud012       number(20,6)      ,/* 自定義欄位(數字)012 */
sfhcud013       number(20,6)      ,/* 自定義欄位(數字)013 */
sfhcud014       number(20,6)      ,/* 自定義欄位(數字)014 */
sfhcud015       number(20,6)      ,/* 自定義欄位(數字)015 */
sfhcud016       number(20,6)      ,/* 自定義欄位(數字)016 */
sfhcud017       number(20,6)      ,/* 自定義欄位(數字)017 */
sfhcud018       number(20,6)      ,/* 自定義欄位(數字)018 */
sfhcud019       number(20,6)      ,/* 自定義欄位(數字)019 */
sfhcud020       number(20,6)      ,/* 自定義欄位(數字)020 */
sfhcud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
sfhcud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
sfhcud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
sfhcud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
sfhcud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
sfhcud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
sfhcud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
sfhcud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
sfhcud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
sfhcud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table sfhc_t add constraint sfhc_pk primary key (sfhcent,sfhcdocno,sfhcseq,sfhcseq1) enable validate;

create unique index sfhc_pk on sfhc_t (sfhcent,sfhcdocno,sfhcseq,sfhcseq1);

grant select on sfhc_t to tiptop;
grant update on sfhc_t to tiptop;
grant delete on sfhc_t to tiptop;
grant insert on sfhc_t to tiptop;

exit;
