/* 
================================================================================
檔案代號:sfkb_t
檔案名稱:工單變更單來源檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table sfkb_t
(
sfkbent       number(5)      ,/* 企業編號 */
sfkbsite       varchar2(10)      ,/* 營運據點 */
sfkbdocno       varchar2(20)      ,/* 工單單號 */
sfkbseq       number(10,0)      ,/* 項次 */
sfkb001       varchar2(1)      ,/* 來源 */
sfkb002       varchar2(20)      ,/* 來源單號 */
sfkb003       number(10,0)      ,/* 來源項次 */
sfkb004       number(10,0)      ,/* 來源項序 */
sfkb005       number(5,0)      ,/* 分批序 */
sfkb006       number(5,0)      ,/* 分配優先序 */
sfkb007       number(20,6)      ,/* 本次轉開工單量 */
sfkb900       number(10,0)      ,/* 變更序 */
sfkb901       varchar2(1)      ,/* 變更類型 */
sfkb902       date      ,/* 變更日期 */
sfkb905       varchar2(10)      ,/* 變更理由 */
sfkb906       varchar2(255)      ,/* 變更備註 */
sfkbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
sfkbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
sfkbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
sfkbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
sfkbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
sfkbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
sfkbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
sfkbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
sfkbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
sfkbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
sfkbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
sfkbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
sfkbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
sfkbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
sfkbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
sfkbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
sfkbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
sfkbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
sfkbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
sfkbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
sfkbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
sfkbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
sfkbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
sfkbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
sfkbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
sfkbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
sfkbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
sfkbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
sfkbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
sfkbud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table sfkb_t add constraint sfkb_pk primary key (sfkbent,sfkbdocno,sfkbseq,sfkb900) enable validate;

create unique index sfkb_pk on sfkb_t (sfkbent,sfkbdocno,sfkbseq,sfkb900);

grant select on sfkb_t to tiptop;
grant update on sfkb_t to tiptop;
grant delete on sfkb_t to tiptop;
grant insert on sfkb_t to tiptop;

exit;
