/* 
================================================================================
檔案代號:sfzz_t
檔案名稱:中間TABLE,用於批次處理
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table sfzz_t
(
sfzzent       number(5)      ,/* 企業編號 */
sfzzsite       varchar2(10)      ,/* 營運據點 */
sfzzdocno       varchar2(20)      ,/* 單號 */
sfzz001       varchar2(1)      ,/* INPUT */
sfzz002       varchar2(1)      ,/* INPUT */
sfzz003       varchar2(1)      ,/* INPUT */
sfzz004       varchar2(1)      ,/* INPUT */
sfzz005       varchar2(1)      ,/* INPUT */
sfzz006       varchar2(1)      ,/* INPUT */
sfzz007       varchar2(1)      ,/* INPUT */
sfzz008       varchar2(1)      ,/* INPUT */
sfzz009       varchar2(1)      ,/* INPUT */
sfzz010       varchar2(1)      ,/* INPUT */
sfzzud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
sfzzud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
sfzzud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
sfzzud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
sfzzud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
sfzzud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
sfzzud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
sfzzud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
sfzzud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
sfzzud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
sfzzud011       number(20,6)      ,/* 自定義欄位(數字)011 */
sfzzud012       number(20,6)      ,/* 自定義欄位(數字)012 */
sfzzud013       number(20,6)      ,/* 自定義欄位(數字)013 */
sfzzud014       number(20,6)      ,/* 自定義欄位(數字)014 */
sfzzud015       number(20,6)      ,/* 自定義欄位(數字)015 */
sfzzud016       number(20,6)      ,/* 自定義欄位(數字)016 */
sfzzud017       number(20,6)      ,/* 自定義欄位(數字)017 */
sfzzud018       number(20,6)      ,/* 自定義欄位(數字)018 */
sfzzud019       number(20,6)      ,/* 自定義欄位(數字)019 */
sfzzud020       number(20,6)      ,/* 自定義欄位(數字)020 */
sfzzud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
sfzzud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
sfzzud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
sfzzud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
sfzzud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
sfzzud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
sfzzud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
sfzzud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
sfzzud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
sfzzud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table sfzz_t add constraint sfzz_pk primary key (sfzzent,sfzzdocno) enable validate;

create unique index sfzz_pk on sfzz_t (sfzzent,sfzzdocno);

grant select on sfzz_t to tiptop;
grant update on sfzz_t to tiptop;
grant delete on sfzz_t to tiptop;
grant insert on sfzz_t to tiptop;

exit;
