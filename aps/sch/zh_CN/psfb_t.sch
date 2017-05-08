/* 
================================================================================
檔案代號:psfb_t
檔案名稱:集團MRP版本單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table psfb_t
(
psfbent       number(5)      ,/* 企業編號 */
psfb001       varchar2(10)      ,/* 集團MRP版本 */
psfb002       number(10,0)      ,/* 順序 */
psfb003       varchar2(10)      ,/* 營運據點 */
psfb004       varchar2(10)      ,/* APS版本 */
psfbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
psfbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
psfbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
psfbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
psfbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
psfbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
psfbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
psfbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
psfbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
psfbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
psfbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
psfbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
psfbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
psfbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
psfbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
psfbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
psfbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
psfbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
psfbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
psfbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
psfbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
psfbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
psfbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
psfbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
psfbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
psfbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
psfbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
psfbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
psfbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
psfbud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table psfb_t add constraint psfb_pk primary key (psfbent,psfb001,psfb002) enable validate;

create unique index psfb_pk on psfb_t (psfbent,psfb001,psfb002);

grant select on psfb_t to tiptop;
grant update on psfb_t to tiptop;
grant delete on psfb_t to tiptop;
grant insert on psfb_t to tiptop;

exit;
