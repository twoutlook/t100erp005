/* 
================================================================================
檔案代號:sfnc_t
檔案名稱:異常工時申報影響工作站檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table sfnc_t
(
sfncent       number(5)      ,/* 企業編號 */
sfncsite       varchar2(10)      ,/* 營運據點 */
sfncdocno       varchar2(20)      ,/* 申報單號 */
sfncseq       number(10,0)      ,/* 項次 */
sfncseq1       number(10,0)      ,/* 項序 */
sfnc000       varchar2(10)      ,/* 工作站 */
sfncud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
sfncud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
sfncud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
sfncud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
sfncud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
sfncud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
sfncud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
sfncud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
sfncud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
sfncud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
sfncud011       number(20,6)      ,/* 自定義欄位(數字)011 */
sfncud012       number(20,6)      ,/* 自定義欄位(數字)012 */
sfncud013       number(20,6)      ,/* 自定義欄位(數字)013 */
sfncud014       number(20,6)      ,/* 自定義欄位(數字)014 */
sfncud015       number(20,6)      ,/* 自定義欄位(數字)015 */
sfncud016       number(20,6)      ,/* 自定義欄位(數字)016 */
sfncud017       number(20,6)      ,/* 自定義欄位(數字)017 */
sfncud018       number(20,6)      ,/* 自定義欄位(數字)018 */
sfncud019       number(20,6)      ,/* 自定義欄位(數字)019 */
sfncud020       number(20,6)      ,/* 自定義欄位(數字)020 */
sfncud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
sfncud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
sfncud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
sfncud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
sfncud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
sfncud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
sfncud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
sfncud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
sfncud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
sfncud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table sfnc_t add constraint sfnc_pk primary key (sfncent,sfncsite,sfncdocno,sfncseq,sfncseq1) enable validate;


grant select on sfnc_t to tiptop;
grant update on sfnc_t to tiptop;
grant delete on sfnc_t to tiptop;
grant insert on sfnc_t to tiptop;

exit;
