/* 
================================================================================
檔案代號:sfkc_t
檔案名稱:工單變更單聯產品檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table sfkc_t
(
sfkcent       number(5)      ,/* 企業編號 */
sfkcsite       varchar2(10)      ,/* 營運據點 */
sfkcdocno       varchar2(20)      ,/* 工單單號 */
sfkcseq       number(10,0)      ,/* 項次 */
sfkc001       varchar2(40)      ,/* 料件編號 */
sfkc002       varchar2(1)      ,/* 類型 */
sfkc003       number(20,6)      ,/* 預計產出量 */
sfkc004       varchar2(10)      ,/* 單位 */
sfkc005       number(20,6)      ,/* 實際產出數量 */
sfkc900       number(10,0)      ,/* 變更序 */
sfkc901       varchar2(1)      ,/* 變更類型 */
sfkc902       date      ,/* 變更日期 */
sfkc006       varchar2(256)      ,/* 產品特征 */
sfkc904       varchar2(10)      ,/* 變更理由 */
sfkc905       varchar2(255)      ,/* 變更備註 */
sfkcud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
sfkcud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
sfkcud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
sfkcud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
sfkcud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
sfkcud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
sfkcud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
sfkcud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
sfkcud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
sfkcud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
sfkcud011       number(20,6)      ,/* 自定義欄位(數字)011 */
sfkcud012       number(20,6)      ,/* 自定義欄位(數字)012 */
sfkcud013       number(20,6)      ,/* 自定義欄位(數字)013 */
sfkcud014       number(20,6)      ,/* 自定義欄位(數字)014 */
sfkcud015       number(20,6)      ,/* 自定義欄位(數字)015 */
sfkcud016       number(20,6)      ,/* 自定義欄位(數字)016 */
sfkcud017       number(20,6)      ,/* 自定義欄位(數字)017 */
sfkcud018       number(20,6)      ,/* 自定義欄位(數字)018 */
sfkcud019       number(20,6)      ,/* 自定義欄位(數字)019 */
sfkcud020       number(20,6)      ,/* 自定義欄位(數字)020 */
sfkcud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
sfkcud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
sfkcud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
sfkcud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
sfkcud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
sfkcud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
sfkcud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
sfkcud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
sfkcud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
sfkcud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
sfkc007       varchar2(1)      /* 保稅否 */
);
alter table sfkc_t add constraint sfkc_pk primary key (sfkcent,sfkcdocno,sfkcseq,sfkc900) enable validate;

create unique index sfkc_pk on sfkc_t (sfkcent,sfkcdocno,sfkcseq,sfkc900);

grant select on sfkc_t to tiptop;
grant update on sfkc_t to tiptop;
grant delete on sfkc_t to tiptop;
grant insert on sfkc_t to tiptop;

exit;
