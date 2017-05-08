/* 
================================================================================
檔案代號:pmbn_t
檔案名稱:供應商評核公式定性評核項目檔(製造)
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table pmbn_t
(
pmbnent       number(5)      ,/* 企業編號 */
pmbnsite       varchar2(10)      ,/* 營運據點 */
pmbn001       varchar2(10)      ,/* 公式編號 */
pmbn002       varchar2(10)      ,/* 項目編號 */
pmbn003       number(20,6)      ,/* 權重 */
pmbnud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmbnud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmbnud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmbnud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmbnud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmbnud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmbnud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmbnud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmbnud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmbnud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmbnud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmbnud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmbnud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmbnud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmbnud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmbnud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmbnud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmbnud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmbnud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmbnud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmbnud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmbnud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmbnud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmbnud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmbnud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmbnud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmbnud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmbnud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmbnud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmbnud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pmbn_t add constraint pmbn_pk primary key (pmbnent,pmbnsite,pmbn001,pmbn002) enable validate;

create unique index pmbn_pk on pmbn_t (pmbnent,pmbnsite,pmbn001,pmbn002);

grant select on pmbn_t to tiptop;
grant update on pmbn_t to tiptop;
grant delete on pmbn_t to tiptop;
grant insert on pmbn_t to tiptop;

exit;
