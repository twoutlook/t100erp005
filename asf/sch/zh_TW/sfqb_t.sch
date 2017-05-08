/* 
================================================================================
檔案代號:sfqb_t
檔案名稱:PBI單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table sfqb_t
(
sfqbent       number(5)      ,/* 企業代碼 */
sfqbsite       varchar2(10)      ,/* 營運據點 */
sfqbdocno       varchar2(20)      ,/* PBI單號 */
sfqb001       varchar2(20)      ,/* 工單單號 */
sfqbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
sfqbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
sfqbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
sfqbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
sfqbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
sfqbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
sfqbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
sfqbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
sfqbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
sfqbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
sfqbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
sfqbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
sfqbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
sfqbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
sfqbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
sfqbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
sfqbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
sfqbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
sfqbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
sfqbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
sfqbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
sfqbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
sfqbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
sfqbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
sfqbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
sfqbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
sfqbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
sfqbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
sfqbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
sfqbud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table sfqb_t add constraint sfqb_pk primary key (sfqbent,sfqbdocno,sfqb001) enable validate;

create unique index sfqb_pk on sfqb_t (sfqbent,sfqbdocno,sfqb001);

grant select on sfqb_t to tiptop;
grant update on sfqb_t to tiptop;
grant delete on sfqb_t to tiptop;
grant insert on sfqb_t to tiptop;

exit;
