/* 
================================================================================
檔案代號:sfch_t
檔案名稱:RunCard合併記錄單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table sfch_t
(
sfchent       number(5)      ,/* 企業編號 */
sfchsite       varchar2(10)      ,/* 營運據點 */
sfchdocno       varchar2(20)      ,/* 工單單號 */
sfchseq       number(10,0)      ,/* 項次 */
sfch001       number(10,0)      ,/* 合併版本 */
sfch002       varchar2(10)      ,/* 作業編號 */
sfch003       varchar2(10)      ,/* 作業序 */
sfch004       number(10,0)      ,/* 原RunCard編號 */
sfch005       number(20,6)      ,/* 合併轉出數量 */
sfchud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
sfchud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
sfchud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
sfchud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
sfchud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
sfchud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
sfchud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
sfchud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
sfchud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
sfchud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
sfchud011       number(20,6)      ,/* 自定義欄位(數字)011 */
sfchud012       number(20,6)      ,/* 自定義欄位(數字)012 */
sfchud013       number(20,6)      ,/* 自定義欄位(數字)013 */
sfchud014       number(20,6)      ,/* 自定義欄位(數字)014 */
sfchud015       number(20,6)      ,/* 自定義欄位(數字)015 */
sfchud016       number(20,6)      ,/* 自定義欄位(數字)016 */
sfchud017       number(20,6)      ,/* 自定義欄位(數字)017 */
sfchud018       number(20,6)      ,/* 自定義欄位(數字)018 */
sfchud019       number(20,6)      ,/* 自定義欄位(數字)019 */
sfchud020       number(20,6)      ,/* 自定義欄位(數字)020 */
sfchud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
sfchud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
sfchud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
sfchud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
sfchud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
sfchud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
sfchud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
sfchud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
sfchud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
sfchud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table sfch_t add constraint sfch_pk primary key (sfchent,sfchdocno,sfchseq,sfch001) enable validate;

create unique index sfch_pk on sfch_t (sfchent,sfchdocno,sfchseq,sfch001);

grant select on sfch_t to tiptop;
grant update on sfch_t to tiptop;
grant delete on sfch_t to tiptop;
grant insert on sfch_t to tiptop;

exit;
