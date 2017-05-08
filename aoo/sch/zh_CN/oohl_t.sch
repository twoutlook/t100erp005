/* 
================================================================================
檔案代號:oohl_t
檔案名稱:控制組據點庫位檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table oohl_t
(
oohlent       number(5)      ,/* 企業編號 */
oohl001       varchar2(10)      ,/* 控制組編號 */
oohl002       varchar2(10)      ,/* 營運據點 */
oohl003       varchar2(10)      ,/* 庫位編號 */
oohl004       date      ,/* 生效日期 */
oohl005       date      ,/* 失效日期 */
oohlud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
oohlud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
oohlud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
oohlud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
oohlud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
oohlud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
oohlud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
oohlud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
oohlud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
oohlud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
oohlud011       number(20,6)      ,/* 自定義欄位(數字)011 */
oohlud012       number(20,6)      ,/* 自定義欄位(數字)012 */
oohlud013       number(20,6)      ,/* 自定義欄位(數字)013 */
oohlud014       number(20,6)      ,/* 自定義欄位(數字)014 */
oohlud015       number(20,6)      ,/* 自定義欄位(數字)015 */
oohlud016       number(20,6)      ,/* 自定義欄位(數字)016 */
oohlud017       number(20,6)      ,/* 自定義欄位(數字)017 */
oohlud018       number(20,6)      ,/* 自定義欄位(數字)018 */
oohlud019       number(20,6)      ,/* 自定義欄位(數字)019 */
oohlud020       number(20,6)      ,/* 自定義欄位(數字)020 */
oohlud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
oohlud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
oohlud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
oohlud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
oohlud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
oohlud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
oohlud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
oohlud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
oohlud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
oohlud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table oohl_t add constraint oohl_pk primary key (oohlent,oohl001,oohl002,oohl003) enable validate;

create  index oohl_01 on oohl_t (oohl004);
create  index oohl_02 on oohl_t (oohl005);
create unique index oohl_pk on oohl_t (oohlent,oohl001,oohl002,oohl003);

grant select on oohl_t to tiptop;
grant update on oohl_t to tiptop;
grant delete on oohl_t to tiptop;
grant insert on oohl_t to tiptop;

exit;
