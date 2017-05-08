/* 
================================================================================
檔案代號:sffd_t
檔案名稱:報工單不良原因檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table sffd_t
(
sffdent       number(5)      ,/* 企業編號 */
sffdsite       varchar2(10)      ,/* 營運據點 */
sffddocno       varchar2(20)      ,/* 報工單號 */
sffdseq       number(10,0)      ,/* 項次 */
sffdseq1       number(10,0)      ,/* 項序 */
sffd001       varchar2(10)      ,/* 異常項目 */
sffd002       number(20,6)      ,/* 數量 */
sffd003       varchar2(255)      ,/* 備註 */
sffdud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
sffdud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
sffdud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
sffdud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
sffdud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
sffdud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
sffdud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
sffdud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
sffdud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
sffdud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
sffdud011       number(20,6)      ,/* 自定義欄位(數字)011 */
sffdud012       number(20,6)      ,/* 自定義欄位(數字)012 */
sffdud013       number(20,6)      ,/* 自定義欄位(數字)013 */
sffdud014       number(20,6)      ,/* 自定義欄位(數字)014 */
sffdud015       number(20,6)      ,/* 自定義欄位(數字)015 */
sffdud016       number(20,6)      ,/* 自定義欄位(數字)016 */
sffdud017       number(20,6)      ,/* 自定義欄位(數字)017 */
sffdud018       number(20,6)      ,/* 自定義欄位(數字)018 */
sffdud019       number(20,6)      ,/* 自定義欄位(數字)019 */
sffdud020       number(20,6)      ,/* 自定義欄位(數字)020 */
sffdud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
sffdud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
sffdud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
sffdud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
sffdud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
sffdud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
sffdud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
sffdud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
sffdud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
sffdud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table sffd_t add constraint sffd_pk primary key (sffdent,sffddocno,sffdseq,sffdseq1,sffd001) enable validate;

create unique index sffd_pk on sffd_t (sffdent,sffddocno,sffdseq,sffdseq1,sffd001);

grant select on sffd_t to tiptop;
grant update on sffd_t to tiptop;
grant delete on sffd_t to tiptop;
grant insert on sffd_t to tiptop;

exit;
