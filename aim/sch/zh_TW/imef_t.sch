/* 
================================================================================
檔案代號:imef_t
檔案名稱:規則化品名節點檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table imef_t
(
imefent       number(5)      ,/* 企業編號 */
imef001       varchar2(10)      ,/* 品名種類 */
imef002       varchar2(10)      ,/* 節點編號 */
imef003       varchar2(40)      ,/* 選項值 */
imefud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
imefud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
imefud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
imefud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
imefud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
imefud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
imefud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
imefud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
imefud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
imefud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
imefud011       number(20,6)      ,/* 自定義欄位(數字)011 */
imefud012       number(20,6)      ,/* 自定義欄位(數字)012 */
imefud013       number(20,6)      ,/* 自定義欄位(數字)013 */
imefud014       number(20,6)      ,/* 自定義欄位(數字)014 */
imefud015       number(20,6)      ,/* 自定義欄位(數字)015 */
imefud016       number(20,6)      ,/* 自定義欄位(數字)016 */
imefud017       number(20,6)      ,/* 自定義欄位(數字)017 */
imefud018       number(20,6)      ,/* 自定義欄位(數字)018 */
imefud019       number(20,6)      ,/* 自定義欄位(數字)019 */
imefud020       number(20,6)      ,/* 自定義欄位(數字)020 */
imefud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
imefud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
imefud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
imefud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
imefud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
imefud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
imefud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
imefud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
imefud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
imefud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table imef_t add constraint imef_pk primary key (imefent,imef001,imef002,imef003) enable validate;

create unique index imef_pk on imef_t (imefent,imef001,imef002,imef003);

grant select on imef_t to tiptop;
grant update on imef_t to tiptop;
grant delete on imef_t to tiptop;
grant insert on imef_t to tiptop;

exit;
