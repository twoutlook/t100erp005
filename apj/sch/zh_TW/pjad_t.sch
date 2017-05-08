/* 
================================================================================
檔案代號:pjad_t
檔案名稱:專案報價單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pjad_t
(
pjadent       number(5)      ,/* 企業編號 */
pjad001       varchar2(20)      ,/* 專案編號 */
pjad002       number(10,0)      ,/* 報價版本 */
pjad003       varchar2(10)      ,/* WBS類型 */
pjad004       varchar2(255)      ,/* 備註 */
pjadud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pjadud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pjadud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pjadud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pjadud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pjadud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pjadud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pjadud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pjadud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pjadud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pjadud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pjadud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pjadud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pjadud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pjadud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pjadud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pjadud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pjadud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pjadud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pjadud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pjadud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pjadud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pjadud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pjadud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pjadud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pjadud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pjadud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pjadud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pjadud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pjadud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pjad_t add constraint pjad_pk primary key (pjadent,pjad001,pjad002,pjad003) enable validate;

create unique index pjad_pk on pjad_t (pjadent,pjad001,pjad002,pjad003);

grant select on pjad_t to tiptop;
grant update on pjad_t to tiptop;
grant delete on pjad_t to tiptop;
grant insert on pjad_t to tiptop;

exit;
