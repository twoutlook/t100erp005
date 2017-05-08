/* 
================================================================================
檔案代號:sfle_t
檔案名稱:工單挪料記錄明細單身檔（來源）
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table sfle_t
(
sfleent       number(5)      ,/* 企業編號 */
sflesite       varchar2(10)      ,/* 營運據點 */
sfledocno       varchar2(20)      ,/* 挪料序號 */
sfleseq       number(10,0)      ,/* 項次 */
sfleseq1       number(10,0)      ,/* 項序 */
sfle001       varchar2(20)      ,/* 工單單號 */
sfle002       number(10,0)      ,/* 工單項次 */
sfle003       number(10,0)      ,/* 工單項序 */
sfle004       varchar2(40)      ,/* 發料料號 */
sfle005       number(20,6)      ,/* 標準QPA分子 */
sfle006       number(20,6)      ,/* 標準QPA分母 */
sfle007       number(20,6)      ,/* 應發數量 */
sfle008       number(20,6)      ,/* 已發數量 */
sfle009       number(20,6)      ,/* 撥出數量 */
sfleud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
sfleud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
sfleud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
sfleud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
sfleud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
sfleud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
sfleud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
sfleud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
sfleud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
sfleud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
sfleud011       number(20,6)      ,/* 自定義欄位(數字)011 */
sfleud012       number(20,6)      ,/* 自定義欄位(數字)012 */
sfleud013       number(20,6)      ,/* 自定義欄位(數字)013 */
sfleud014       number(20,6)      ,/* 自定義欄位(數字)014 */
sfleud015       number(20,6)      ,/* 自定義欄位(數字)015 */
sfleud016       number(20,6)      ,/* 自定義欄位(數字)016 */
sfleud017       number(20,6)      ,/* 自定義欄位(數字)017 */
sfleud018       number(20,6)      ,/* 自定義欄位(數字)018 */
sfleud019       number(20,6)      ,/* 自定義欄位(數字)019 */
sfleud020       number(20,6)      ,/* 自定義欄位(數字)020 */
sfleud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
sfleud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
sfleud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
sfleud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
sfleud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
sfleud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
sfleud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
sfleud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
sfleud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
sfleud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table sfle_t add constraint sfle_pk primary key (sfleent,sflesite,sfledocno,sfleseq,sfleseq1) enable validate;

create unique index sfle_pk on sfle_t (sfleent,sflesite,sfledocno,sfleseq,sfleseq1);

grant select on sfle_t to tiptop;
grant update on sfle_t to tiptop;
grant delete on sfle_t to tiptop;
grant insert on sfle_t to tiptop;

exit;
