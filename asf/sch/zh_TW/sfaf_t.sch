/* 
================================================================================
檔案代號:sfaf_t
檔案名稱:工單產品序號檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table sfaf_t
(
sfafent       number(5)      ,/* 企業編號 */
sfafsite       varchar2(10)      ,/* 營運據點 */
sfafdocno       varchar2(20)      ,/* 單號 */
sfaf001       varchar2(30)      ,/* 產品序號 */
sfafseq       number(10,0)      ,/* 項次 */
sfafud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
sfafud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
sfafud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
sfafud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
sfafud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
sfafud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
sfafud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
sfafud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
sfafud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
sfafud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
sfafud011       number(20,6)      ,/* 自定義欄位(數字)011 */
sfafud012       number(20,6)      ,/* 自定義欄位(數字)012 */
sfafud013       number(20,6)      ,/* 自定義欄位(數字)013 */
sfafud014       number(20,6)      ,/* 自定義欄位(數字)014 */
sfafud015       number(20,6)      ,/* 自定義欄位(數字)015 */
sfafud016       number(20,6)      ,/* 自定義欄位(數字)016 */
sfafud017       number(20,6)      ,/* 自定義欄位(數字)017 */
sfafud018       number(20,6)      ,/* 自定義欄位(數字)018 */
sfafud019       number(20,6)      ,/* 自定義欄位(數字)019 */
sfafud020       number(20,6)      ,/* 自定義欄位(數字)020 */
sfafud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
sfafud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
sfafud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
sfafud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
sfafud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
sfafud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
sfafud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
sfafud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
sfafud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
sfafud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table sfaf_t add constraint sfaf_pk primary key (sfafent,sfafdocno,sfafseq) enable validate;

create unique index sfaf_pk on sfaf_t (sfafent,sfafdocno,sfafseq);

grant select on sfaf_t to tiptop;
grant update on sfaf_t to tiptop;
grant delete on sfaf_t to tiptop;
grant insert on sfaf_t to tiptop;

exit;
