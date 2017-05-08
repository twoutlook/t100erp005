/* 
================================================================================
檔案代號:prbu_t
檔案名稱:電子秤格式定義值轉換明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table prbu_t
(
prbuent       number(5)      ,/* 企業代碼 */
prbu001       varchar2(10)      ,/* 電子秤編號 */
prbu002       number(10,0)      ,/* 導出順序號 */
prbu003       number(10,0)      ,/* 值序號 */
prbu004       varchar2(100)      ,/* 來源值 */
prbu005       varchar2(100)      ,/* 目標值 */
prbuud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
prbuud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
prbuud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
prbuud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
prbuud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
prbuud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
prbuud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
prbuud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
prbuud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
prbuud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
prbuud011       number(20,6)      ,/* 自定義欄位(數字)011 */
prbuud012       number(20,6)      ,/* 自定義欄位(數字)012 */
prbuud013       number(20,6)      ,/* 自定義欄位(數字)013 */
prbuud014       number(20,6)      ,/* 自定義欄位(數字)014 */
prbuud015       number(20,6)      ,/* 自定義欄位(數字)015 */
prbuud016       number(20,6)      ,/* 自定義欄位(數字)016 */
prbuud017       number(20,6)      ,/* 自定義欄位(數字)017 */
prbuud018       number(20,6)      ,/* 自定義欄位(數字)018 */
prbuud019       number(20,6)      ,/* 自定義欄位(數字)019 */
prbuud020       number(20,6)      ,/* 自定義欄位(數字)020 */
prbuud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
prbuud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
prbuud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
prbuud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
prbuud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
prbuud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
prbuud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
prbuud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
prbuud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
prbuud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table prbu_t add constraint prbu_pk primary key (prbuent,prbu001,prbu002,prbu003) enable validate;

create unique index prbu_pk on prbu_t (prbuent,prbu001,prbu002,prbu003);

grant select on prbu_t to tiptop;
grant update on prbu_t to tiptop;
grant delete on prbu_t to tiptop;
grant insert on prbu_t to tiptop;

exit;
