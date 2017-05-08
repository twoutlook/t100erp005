/* 
================================================================================
檔案代號:bmkc_t
檔案名稱:ECR申請單現存資料影響檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table bmkc_t
(
bmkcent       number(5)      ,/* 企業編號 */
bmkcsite       varchar2(10)      ,/* 營運據點 */
bmkcdocno       varchar2(20)      ,/* 申請單號 */
bmkcseq       number(10,0)      ,/* 項次 */
bmkc001       varchar2(10)      ,/* 影響類型 */
bmkc002       varchar2(10)      ,/* 建議處理方式 */
bmkc003       number(20,6)      ,/* 預估影響金額 */
bmkc004       varchar2(80)      ,/* 說明 */
bmkcud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bmkcud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bmkcud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bmkcud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bmkcud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bmkcud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bmkcud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bmkcud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bmkcud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bmkcud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bmkcud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bmkcud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bmkcud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bmkcud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bmkcud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bmkcud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bmkcud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bmkcud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bmkcud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bmkcud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bmkcud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bmkcud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bmkcud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bmkcud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bmkcud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bmkcud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bmkcud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bmkcud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bmkcud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bmkcud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bmkc_t add constraint bmkc_pk primary key (bmkcent,bmkcdocno,bmkcseq) enable validate;

create unique index bmkc_pk on bmkc_t (bmkcent,bmkcdocno,bmkcseq);

grant select on bmkc_t to tiptop;
grant update on bmkc_t to tiptop;
grant delete on bmkc_t to tiptop;
grant insert on bmkc_t to tiptop;

exit;
