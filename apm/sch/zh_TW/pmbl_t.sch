/* 
================================================================================
檔案代號:pmbl_t
檔案名稱:供應商評核公式供應商分類範圍檔(製造)
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pmbl_t
(
pmblent       number(5)      ,/* 企業編號 */
pmblsite       varchar2(10)      ,/* 營運據點 */
pmbl001       varchar2(10)      ,/* 公式編號 */
pmbl002       varchar2(10)      ,/* 供應商分類 */
pmblud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmblud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmblud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmblud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmblud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmblud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmblud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmblud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmblud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmblud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmblud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmblud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmblud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmblud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmblud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmblud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmblud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmblud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmblud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmblud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmblud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmblud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmblud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmblud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmblud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmblud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmblud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmblud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmblud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmblud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pmbl_t add constraint pmbl_pk primary key (pmblent,pmblsite,pmbl001,pmbl002) enable validate;

create unique index pmbl_pk on pmbl_t (pmblent,pmblsite,pmbl001,pmbl002);

grant select on pmbl_t to tiptop;
grant update on pmbl_t to tiptop;
grant delete on pmbl_t to tiptop;
grant insert on pmbl_t to tiptop;

exit;
