/* 
================================================================================
檔案代號:pmce_t
檔案名稱:供應商評核定性項目設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pmce_t
(
pmceent       number(5)      ,/* 企業編號 */
pmce001       varchar2(10)      ,/* 評核期別 */
pmce002       varchar2(10)      ,/* 評核品類 */
pmce003       varchar2(10)      ,/* 評核項目 */
pmce004       varchar2(10)      ,/* 評分部門 */
pmce005       number(20,6)      ,/* 權重 */
pmceud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmceud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmceud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmceud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmceud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmceud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmceud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmceud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmceud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmceud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmceud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmceud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmceud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmceud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmceud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmceud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmceud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmceud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmceud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmceud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmceud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmceud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmceud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmceud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmceud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmceud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmceud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmceud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmceud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmceud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pmce_t add constraint pmce_pk primary key (pmceent,pmce001,pmce002,pmce003) enable validate;

create unique index pmce_pk on pmce_t (pmceent,pmce001,pmce002,pmce003);

grant select on pmce_t to tiptop;
grant update on pmce_t to tiptop;
grant delete on pmce_t to tiptop;
grant insert on pmce_t to tiptop;

exit;
