/* 
================================================================================
檔案代號:sfhb_t
檔案名稱:工單當站下線入庫申請檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table sfhb_t
(
sfhbent       number(5)      ,/* 企業編號 */
sfhbsite       varchar2(10)      ,/* 營運據點 */
sfhbdocno       varchar2(20)      ,/* 單號 */
sfhbseq       number(10,0)      ,/* 項次 */
sfhb001       varchar2(40)      ,/* 料件編號 */
sfhb002       varchar2(256)      ,/* 產品特徵 */
sfhb003       varchar2(10)      ,/* 庫位 */
sfhb004       varchar2(10)      ,/* 儲位 */
sfhb005       varchar2(30)      ,/* 批號 */
sfhb006       varchar2(30)      ,/* 庫存管理特徵 */
sfhb007       varchar2(10)      ,/* 單位 */
sfhb008       number(20,6)      ,/* 數量 */
sfhb009       varchar2(10)      ,/* 參考單位 */
sfhb010       number(20,6)      ,/* 參考數量 */
sfhb011       date      ,/* 生效日期 */
sfhb012       varchar2(4000)      ,/* 存貨備註 */
sfhbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
sfhbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
sfhbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
sfhbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
sfhbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
sfhbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
sfhbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
sfhbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
sfhbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
sfhbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
sfhbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
sfhbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
sfhbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
sfhbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
sfhbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
sfhbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
sfhbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
sfhbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
sfhbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
sfhbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
sfhbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
sfhbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
sfhbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
sfhbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
sfhbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
sfhbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
sfhbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
sfhbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
sfhbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
sfhbud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table sfhb_t add constraint sfhb_pk primary key (sfhbent,sfhbdocno,sfhbseq) enable validate;

create unique index sfhb_pk on sfhb_t (sfhbent,sfhbdocno,sfhbseq);

grant select on sfhb_t to tiptop;
grant update on sfhb_t to tiptop;
grant delete on sfhb_t to tiptop;
grant insert on sfhb_t to tiptop;

exit;
