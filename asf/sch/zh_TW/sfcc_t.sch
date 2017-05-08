/* 
================================================================================
檔案代號:sfcc_t
檔案名稱:工單製程上站作業資料
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table sfcc_t
(
sfccent       number(5)      ,/* 企業編號 */
sfccsite       varchar2(10)      ,/* 營運據點 */
sfccdocno       varchar2(20)      ,/* 單號 */
sfcc001       number(10,0)      ,/* RUN CARD */
sfcc002       number(10,0)      ,/* 項次 */
sfcc003       varchar2(10)      ,/* 上站作業 */
sfcc004       varchar2(10)      ,/* 上站作業序 */
sfccud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
sfccud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
sfccud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
sfccud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
sfccud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
sfccud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
sfccud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
sfccud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
sfccud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
sfccud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
sfccud011       number(20,6)      ,/* 自定義欄位(數字)011 */
sfccud012       number(20,6)      ,/* 自定義欄位(數字)012 */
sfccud013       number(20,6)      ,/* 自定義欄位(數字)013 */
sfccud014       number(20,6)      ,/* 自定義欄位(數字)014 */
sfccud015       number(20,6)      ,/* 自定義欄位(數字)015 */
sfccud016       number(20,6)      ,/* 自定義欄位(數字)016 */
sfccud017       number(20,6)      ,/* 自定義欄位(數字)017 */
sfccud018       number(20,6)      ,/* 自定義欄位(數字)018 */
sfccud019       number(20,6)      ,/* 自定義欄位(數字)019 */
sfccud020       number(20,6)      ,/* 自定義欄位(數字)020 */
sfccud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
sfccud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
sfccud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
sfccud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
sfccud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
sfccud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
sfccud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
sfccud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
sfccud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
sfccud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table sfcc_t add constraint sfcc_pk primary key (sfccent,sfccdocno,sfcc001,sfcc002,sfcc003,sfcc004) enable validate;

create unique index sfcc_pk on sfcc_t (sfccent,sfccdocno,sfcc001,sfcc002,sfcc003,sfcc004);

grant select on sfcc_t to tiptop;
grant update on sfcc_t to tiptop;
grant delete on sfcc_t to tiptop;
grant insert on sfcc_t to tiptop;

exit;
