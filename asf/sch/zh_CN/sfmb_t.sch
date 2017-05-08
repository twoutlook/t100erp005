/* 
================================================================================
檔案代號:sfmb_t
檔案名稱:耗料盤存檔點單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table sfmb_t
(
sfmbent       number(5)      ,/* 企業編號 */
sfmbsite       varchar2(10)      ,/* 營運據點 */
sfmbdocno       varchar2(20)      ,/* 盤點單號 */
sfmbseq       number(10,0)      ,/* 項次 */
sfmb001       varchar2(40)      ,/* 料件編號 */
sfmb002       varchar2(256)      ,/* 產品特徵 */
sfmb003       varchar2(10)      ,/* 庫位 */
sfmb004       varchar2(10)      ,/* 儲位 */
sfmb005       varchar2(30)      ,/* 批號 */
sfmb006       varchar2(256)      ,/* 庫存特徵 */
sfmb007       varchar2(10)      ,/* 單位 */
sfmb008       number(20,6)      ,/* 帳面數量 */
sfmb009       number(20,6)      ,/* 盤點數量 */
sfmb010       varchar2(10)      ,/* 參考單位 */
sfmb011       number(20,6)      ,/* 參考帳面數量 */
sfmb012       number(20,6)      ,/* 參考盤點數量 */
sfmbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
sfmbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
sfmbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
sfmbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
sfmbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
sfmbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
sfmbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
sfmbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
sfmbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
sfmbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
sfmbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
sfmbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
sfmbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
sfmbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
sfmbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
sfmbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
sfmbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
sfmbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
sfmbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
sfmbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
sfmbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
sfmbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
sfmbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
sfmbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
sfmbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
sfmbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
sfmbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
sfmbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
sfmbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
sfmbud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table sfmb_t add constraint sfmb_pk primary key (sfmbent,sfmbdocno,sfmbseq) enable validate;

create unique index sfmb_pk on sfmb_t (sfmbent,sfmbdocno,sfmbseq);

grant select on sfmb_t to tiptop;
grant update on sfmb_t to tiptop;
grant delete on sfmb_t to tiptop;
grant insert on sfmb_t to tiptop;

exit;
