/* 
================================================================================
檔案代號:pcar_t
檔案名稱:POS日結主表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table pcar_t
(
pcarent       number(5)      ,/* 企業編號 */
pcarsite       varchar2(10)      ,/* 營運組織 */
pcar001       date      ,/* 日結日期 */
pcar002       number(10,0)      ,/* 銷售總筆數 */
pcar003       number(20,6)      ,/* 銷售總金額 */
pcarstus       varchar2(10)      ,/* 狀態 */
pcarud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pcarud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pcarud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pcarud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pcarud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pcarud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pcarud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pcarud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pcarud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pcarud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pcarud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pcarud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pcarud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pcarud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pcarud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pcarud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pcarud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pcarud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pcarud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pcarud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pcarud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pcarud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pcarud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pcarud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pcarud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pcarud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pcarud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pcarud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pcarud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pcarud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pcar_t add constraint pcar_pk primary key (pcarent,pcarsite,pcar001) enable validate;

create unique index pcar_pk on pcar_t (pcarent,pcarsite,pcar001);

grant select on pcar_t to tiptop;
grant update on pcar_t to tiptop;
grant delete on pcar_t to tiptop;
grant insert on pcar_t to tiptop;

exit;
