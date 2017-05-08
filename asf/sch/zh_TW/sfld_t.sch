/* 
================================================================================
檔案代號:sfld_t
檔案名稱:工單挪料記錄明細單身檔（目的）
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table sfld_t
(
sfldent       number(5)      ,/* 企業編號 */
sfldsite       varchar2(10)      ,/* 營運據點 */
sflddocno       varchar2(20)      ,/* 挪料序號 */
sfldseq       number(10,0)      ,/* 項次 */
sfldseq1       number(10,0)      ,/* 項序 */
sfld001       varchar2(20)      ,/* 工單單號 */
sfld002       number(10,0)      ,/* 工單項次 */
sfld003       number(10,0)      ,/* 工單項序 */
sfld004       varchar2(40)      ,/* 發料料號 */
sfld005       number(20,6)      ,/* 標準QPA分子 */
sfld006       number(20,6)      ,/* 標準QPA分母 */
sfld007       number(20,6)      ,/* 應發數量 */
sfld008       number(20,6)      ,/* 已發數量 */
sfld009       number(20,6)      ,/* 撥入數量 */
sfldud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
sfldud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
sfldud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
sfldud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
sfldud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
sfldud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
sfldud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
sfldud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
sfldud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
sfldud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
sfldud011       number(20,6)      ,/* 自定義欄位(數字)011 */
sfldud012       number(20,6)      ,/* 自定義欄位(數字)012 */
sfldud013       number(20,6)      ,/* 自定義欄位(數字)013 */
sfldud014       number(20,6)      ,/* 自定義欄位(數字)014 */
sfldud015       number(20,6)      ,/* 自定義欄位(數字)015 */
sfldud016       number(20,6)      ,/* 自定義欄位(數字)016 */
sfldud017       number(20,6)      ,/* 自定義欄位(數字)017 */
sfldud018       number(20,6)      ,/* 自定義欄位(數字)018 */
sfldud019       number(20,6)      ,/* 自定義欄位(數字)019 */
sfldud020       number(20,6)      ,/* 自定義欄位(數字)020 */
sfldud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
sfldud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
sfldud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
sfldud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
sfldud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
sfldud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
sfldud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
sfldud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
sfldud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
sfldud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table sfld_t add constraint sfld_pk primary key (sfldent,sfldsite,sflddocno,sfldseq,sfldseq1) enable validate;

create unique index sfld_pk on sfld_t (sfldent,sfldsite,sflddocno,sfldseq,sfldseq1);

grant select on sfld_t to tiptop;
grant update on sfld_t to tiptop;
grant delete on sfld_t to tiptop;
grant insert on sfld_t to tiptop;

exit;
