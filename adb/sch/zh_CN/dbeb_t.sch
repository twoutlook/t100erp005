/* 
================================================================================
檔案代號:dbeb_t
檔案名稱:配送預排路線單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:Y
============.========================.==========================================
 */
create table dbeb_t
(
dbebent       number(5)      ,/* 企業編號 */
dbebsite       varchar2(10)      ,/* 營運據點 */
dbebunit       varchar2(10)      ,/* 應用組織 */
dbebdocno       varchar2(20)      ,/* 單據編號 */
dbeb001       varchar2(10)      ,/* 路線編號 */
dbeb002       varchar2(10)      ,/* 裝載點 */
dbeb003       number(20,6)      ,/* 計劃承載容積 */
dbeb004       number(20,6)      ,/* 預排承載容積 */
dbeb005       varchar2(10)      ,/* 承載容積單位 */
dbeb006       number(20,6)      ,/* 計劃承載重量 */
dbeb007       number(20,6)      ,/* 預排承載重量 */
dbeb008       varchar2(10)      ,/* 承載重量單位 */
dbebud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
dbebud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
dbebud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
dbebud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
dbebud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
dbebud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
dbebud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
dbebud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
dbebud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
dbebud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
dbebud011       number(20,6)      ,/* 自定義欄位(數字)011 */
dbebud012       number(20,6)      ,/* 自定義欄位(數字)012 */
dbebud013       number(20,6)      ,/* 自定義欄位(數字)013 */
dbebud014       number(20,6)      ,/* 自定義欄位(數字)014 */
dbebud015       number(20,6)      ,/* 自定義欄位(數字)015 */
dbebud016       number(20,6)      ,/* 自定義欄位(數字)016 */
dbebud017       number(20,6)      ,/* 自定義欄位(數字)017 */
dbebud018       number(20,6)      ,/* 自定義欄位(數字)018 */
dbebud019       number(20,6)      ,/* 自定義欄位(數字)019 */
dbebud020       number(20,6)      ,/* 自定義欄位(數字)020 */
dbebud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
dbebud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
dbebud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
dbebud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
dbebud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
dbebud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
dbebud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
dbebud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
dbebud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
dbebud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table dbeb_t add constraint dbeb_pk primary key (dbebent,dbebdocno,dbeb001) enable validate;

create unique index dbeb_pk on dbeb_t (dbebent,dbebdocno,dbeb001);

grant select on dbeb_t to tiptop;
grant update on dbeb_t to tiptop;
grant delete on dbeb_t to tiptop;
grant insert on dbeb_t to tiptop;

exit;
