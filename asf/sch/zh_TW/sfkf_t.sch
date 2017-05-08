/* 
================================================================================
檔案代號:sfkf_t
檔案名稱:工單變更單產品序號檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table sfkf_t
(
sfkfent       number(5)      ,/* 企業編號 */
sfkfsite       varchar2(10)      ,/* 營運據點 */
sfkfdocno       varchar2(20)      ,/* 工單單號 */
sfkfseq       number(10,0)      ,/* 項次 */
sfkf001       varchar2(30)      ,/* 產品序號 */
sfkf900       number(10,0)      ,/* 變更序 */
sfkf901       varchar2(1)      ,/* 變更類型 */
sfkf902       date      ,/* 變更日期 */
sfkf905       varchar2(10)      ,/* 變更理由 */
sfkf906       varchar2(255)      ,/* 變更備註 */
sfkfud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
sfkfud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
sfkfud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
sfkfud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
sfkfud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
sfkfud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
sfkfud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
sfkfud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
sfkfud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
sfkfud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
sfkfud011       number(20,6)      ,/* 自定義欄位(數字)011 */
sfkfud012       number(20,6)      ,/* 自定義欄位(數字)012 */
sfkfud013       number(20,6)      ,/* 自定義欄位(數字)013 */
sfkfud014       number(20,6)      ,/* 自定義欄位(數字)014 */
sfkfud015       number(20,6)      ,/* 自定義欄位(數字)015 */
sfkfud016       number(20,6)      ,/* 自定義欄位(數字)016 */
sfkfud017       number(20,6)      ,/* 自定義欄位(數字)017 */
sfkfud018       number(20,6)      ,/* 自定義欄位(數字)018 */
sfkfud019       number(20,6)      ,/* 自定義欄位(數字)019 */
sfkfud020       number(20,6)      ,/* 自定義欄位(數字)020 */
sfkfud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
sfkfud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
sfkfud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
sfkfud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
sfkfud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
sfkfud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
sfkfud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
sfkfud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
sfkfud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
sfkfud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table sfkf_t add constraint sfkf_pk primary key (sfkfent,sfkfdocno,sfkfseq,sfkf900) enable validate;

create unique index sfkf_pk on sfkf_t (sfkfent,sfkfdocno,sfkfseq,sfkf900);

grant select on sfkf_t to tiptop;
grant update on sfkf_t to tiptop;
grant delete on sfkf_t to tiptop;
grant insert on sfkf_t to tiptop;

exit;
