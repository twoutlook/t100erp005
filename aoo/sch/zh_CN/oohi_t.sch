/* 
================================================================================
檔案代號:oohi_t
檔案名稱:控制組產品檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table oohi_t
(
oohient       number(5)      ,/* 企業編號 */
oohi001       varchar2(10)      ,/* 控制組編號 */
oohi002       varchar2(40)      ,/* 產品編號 */
oohi003       date      ,/* 生效日期 */
oohi004       date      ,/* 失效日期 */
oohiud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
oohiud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
oohiud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
oohiud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
oohiud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
oohiud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
oohiud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
oohiud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
oohiud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
oohiud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
oohiud011       number(20,6)      ,/* 自定義欄位(數字)011 */
oohiud012       number(20,6)      ,/* 自定義欄位(數字)012 */
oohiud013       number(20,6)      ,/* 自定義欄位(數字)013 */
oohiud014       number(20,6)      ,/* 自定義欄位(數字)014 */
oohiud015       number(20,6)      ,/* 自定義欄位(數字)015 */
oohiud016       number(20,6)      ,/* 自定義欄位(數字)016 */
oohiud017       number(20,6)      ,/* 自定義欄位(數字)017 */
oohiud018       number(20,6)      ,/* 自定義欄位(數字)018 */
oohiud019       number(20,6)      ,/* 自定義欄位(數字)019 */
oohiud020       number(20,6)      ,/* 自定義欄位(數字)020 */
oohiud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
oohiud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
oohiud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
oohiud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
oohiud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
oohiud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
oohiud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
oohiud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
oohiud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
oohiud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table oohi_t add constraint oohi_pk primary key (oohient,oohi001,oohi002) enable validate;

create  index oohi_01 on oohi_t (oohi003);
create  index oohi_02 on oohi_t (oohi004);
create unique index oohi_pk on oohi_t (oohient,oohi001,oohi002);

grant select on oohi_t to tiptop;
grant update on oohi_t to tiptop;
grant delete on oohi_t to tiptop;
grant insert on oohi_t to tiptop;

exit;
