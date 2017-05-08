/* 
================================================================================
檔案代號:sfgc_t
檔案名稱:工單當站報判定明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table sfgc_t
(
sfgcent       number(5)      ,/* 企業編號 */
sfgcsite       varchar2(10)      ,/* 營運據點 */
sfgcdocno       varchar2(20)      ,/* 單據編號 */
sfgcseq       number(10,0)      ,/* 項次 */
sfgc001       varchar2(10)      ,/* 異常原因 */
sfgc002       varchar2(10)      ,/* 判定處理方式 */
sfgc003       number(20,6)      ,/* 數量 */
sfgc004       varchar2(10)      ,/* 責任歸屬 */
sfgc005       varchar2(10)      ,/* 責任單位 */
sfgc006       varchar2(255)      ,/* 備註 */
sfgcud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
sfgcud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
sfgcud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
sfgcud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
sfgcud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
sfgcud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
sfgcud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
sfgcud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
sfgcud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
sfgcud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
sfgcud011       number(20,6)      ,/* 自定義欄位(數字)011 */
sfgcud012       number(20,6)      ,/* 自定義欄位(數字)012 */
sfgcud013       number(20,6)      ,/* 自定義欄位(數字)013 */
sfgcud014       number(20,6)      ,/* 自定義欄位(數字)014 */
sfgcud015       number(20,6)      ,/* 自定義欄位(數字)015 */
sfgcud016       number(20,6)      ,/* 自定義欄位(數字)016 */
sfgcud017       number(20,6)      ,/* 自定義欄位(數字)017 */
sfgcud018       number(20,6)      ,/* 自定義欄位(數字)018 */
sfgcud019       number(20,6)      ,/* 自定義欄位(數字)019 */
sfgcud020       number(20,6)      ,/* 自定義欄位(數字)020 */
sfgcud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
sfgcud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
sfgcud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
sfgcud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
sfgcud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
sfgcud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
sfgcud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
sfgcud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
sfgcud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
sfgcud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table sfgc_t add constraint sfgc_pk primary key (sfgcent,sfgcdocno,sfgcseq) enable validate;

create unique index sfgc_pk on sfgc_t (sfgcent,sfgcdocno,sfgcseq);

grant select on sfgc_t to tiptop;
grant update on sfgc_t to tiptop;
grant delete on sfgc_t to tiptop;
grant insert on sfgc_t to tiptop;

exit;
