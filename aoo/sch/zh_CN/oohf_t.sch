/* 
================================================================================
檔案代號:oohf_t
檔案名稱:控制組廠商分類檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table oohf_t
(
oohfent       number(5)      ,/* 企業編號 */
oohf001       varchar2(10)      ,/* 控制組編號 */
oohf002       varchar2(10)      ,/* 廠商分類 */
oohf003       date      ,/* 生效日期 */
oohf004       date      ,/* 失效日期 */
oohfud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
oohfud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
oohfud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
oohfud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
oohfud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
oohfud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
oohfud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
oohfud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
oohfud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
oohfud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
oohfud011       number(20,6)      ,/* 自定義欄位(數字)011 */
oohfud012       number(20,6)      ,/* 自定義欄位(數字)012 */
oohfud013       number(20,6)      ,/* 自定義欄位(數字)013 */
oohfud014       number(20,6)      ,/* 自定義欄位(數字)014 */
oohfud015       number(20,6)      ,/* 自定義欄位(數字)015 */
oohfud016       number(20,6)      ,/* 自定義欄位(數字)016 */
oohfud017       number(20,6)      ,/* 自定義欄位(數字)017 */
oohfud018       number(20,6)      ,/* 自定義欄位(數字)018 */
oohfud019       number(20,6)      ,/* 自定義欄位(數字)019 */
oohfud020       number(20,6)      ,/* 自定義欄位(數字)020 */
oohfud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
oohfud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
oohfud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
oohfud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
oohfud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
oohfud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
oohfud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
oohfud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
oohfud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
oohfud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table oohf_t add constraint oohf_pk primary key (oohfent,oohf001,oohf002) enable validate;

create  index oohf_01 on oohf_t (oohf003);
create  index oohf_02 on oohf_t (oohf004);
create unique index oohf_pk on oohf_t (oohfent,oohf001,oohf002);

grant select on oohf_t to tiptop;
grant update on oohf_t to tiptop;
grant delete on oohf_t to tiptop;
grant insert on oohf_t to tiptop;

exit;
