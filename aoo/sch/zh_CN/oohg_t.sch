/* 
================================================================================
檔案代號:oohg_t
檔案名稱:控制組廠商檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table oohg_t
(
oohgent       number(5)      ,/* 企業編號 */
oohg001       varchar2(10)      ,/* 控制組編號 */
oohg002       varchar2(10)      ,/* 廠商編號 */
oohg003       date      ,/* 生效日期 */
oohg004       date      ,/* 失效日期 */
oohgud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
oohgud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
oohgud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
oohgud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
oohgud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
oohgud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
oohgud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
oohgud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
oohgud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
oohgud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
oohgud011       number(20,6)      ,/* 自定義欄位(數字)011 */
oohgud012       number(20,6)      ,/* 自定義欄位(數字)012 */
oohgud013       number(20,6)      ,/* 自定義欄位(數字)013 */
oohgud014       number(20,6)      ,/* 自定義欄位(數字)014 */
oohgud015       number(20,6)      ,/* 自定義欄位(數字)015 */
oohgud016       number(20,6)      ,/* 自定義欄位(數字)016 */
oohgud017       number(20,6)      ,/* 自定義欄位(數字)017 */
oohgud018       number(20,6)      ,/* 自定義欄位(數字)018 */
oohgud019       number(20,6)      ,/* 自定義欄位(數字)019 */
oohgud020       number(20,6)      ,/* 自定義欄位(數字)020 */
oohgud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
oohgud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
oohgud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
oohgud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
oohgud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
oohgud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
oohgud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
oohgud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
oohgud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
oohgud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table oohg_t add constraint oohg_pk primary key (oohgent,oohg001,oohg002) enable validate;

create  index oohg_01 on oohg_t (oohg003);
create  index oohg_02 on oohg_t (oohg004);
create unique index oohg_pk on oohg_t (oohgent,oohg001,oohg002);

grant select on oohg_t to tiptop;
grant update on oohg_t to tiptop;
grant delete on oohg_t to tiptop;
grant insert on oohg_t to tiptop;

exit;
