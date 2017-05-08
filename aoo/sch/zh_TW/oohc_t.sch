/* 
================================================================================
檔案代號:oohc_t
檔案名稱:控制組人員檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table oohc_t
(
oohcent       number(5)      ,/* 企業編號 */
oohc001       varchar2(10)      ,/* 控制組編號 */
oohc002       varchar2(20)      ,/* 人員編號 */
oohc003       date      ,/* 生效日期 */
oohc004       date      ,/* 失效日期 */
oohcud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
oohcud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
oohcud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
oohcud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
oohcud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
oohcud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
oohcud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
oohcud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
oohcud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
oohcud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
oohcud011       number(20,6)      ,/* 自定義欄位(數字)011 */
oohcud012       number(20,6)      ,/* 自定義欄位(數字)012 */
oohcud013       number(20,6)      ,/* 自定義欄位(數字)013 */
oohcud014       number(20,6)      ,/* 自定義欄位(數字)014 */
oohcud015       number(20,6)      ,/* 自定義欄位(數字)015 */
oohcud016       number(20,6)      ,/* 自定義欄位(數字)016 */
oohcud017       number(20,6)      ,/* 自定義欄位(數字)017 */
oohcud018       number(20,6)      ,/* 自定義欄位(數字)018 */
oohcud019       number(20,6)      ,/* 自定義欄位(數字)019 */
oohcud020       number(20,6)      ,/* 自定義欄位(數字)020 */
oohcud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
oohcud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
oohcud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
oohcud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
oohcud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
oohcud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
oohcud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
oohcud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
oohcud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
oohcud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table oohc_t add constraint oohc_pk primary key (oohcent,oohc001,oohc002) enable validate;

create  index oohc_01 on oohc_t (oohc003);
create  index oohc_02 on oohc_t (oohc004);
create unique index oohc_pk on oohc_t (oohcent,oohc001,oohc002);

grant select on oohc_t to tiptop;
grant update on oohc_t to tiptop;
grant delete on oohc_t to tiptop;
grant insert on oohc_t to tiptop;

exit;
