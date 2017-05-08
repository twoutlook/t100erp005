/* 
================================================================================
檔案代號:psfc_t
檔案名稱:集團MRP版本營運據點群組檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table psfc_t
(
psfcent       number(5)      ,/* 企業編號 */
psfc001       varchar2(10)      ,/* 集團MRP版本 */
psfc002       number(10,0)      ,/* 群組順序 */
psfc003       varchar2(80)      ,/* 說明 */
psfcud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
psfcud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
psfcud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
psfcud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
psfcud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
psfcud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
psfcud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
psfcud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
psfcud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
psfcud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
psfcud011       number(20,6)      ,/* 自定義欄位(數字)011 */
psfcud012       number(20,6)      ,/* 自定義欄位(數字)012 */
psfcud013       number(20,6)      ,/* 自定義欄位(數字)013 */
psfcud014       number(20,6)      ,/* 自定義欄位(數字)014 */
psfcud015       number(20,6)      ,/* 自定義欄位(數字)015 */
psfcud016       number(20,6)      ,/* 自定義欄位(數字)016 */
psfcud017       number(20,6)      ,/* 自定義欄位(數字)017 */
psfcud018       number(20,6)      ,/* 自定義欄位(數字)018 */
psfcud019       number(20,6)      ,/* 自定義欄位(數字)019 */
psfcud020       number(20,6)      ,/* 自定義欄位(數字)020 */
psfcud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
psfcud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
psfcud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
psfcud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
psfcud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
psfcud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
psfcud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
psfcud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
psfcud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
psfcud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table psfc_t add constraint psfc_pk primary key (psfcent,psfc001,psfc002) enable validate;

create unique index psfc_pk on psfc_t (psfcent,psfc001,psfc002);

grant select on psfc_t to tiptop;
grant update on psfc_t to tiptop;
grant delete on psfc_t to tiptop;
grant insert on psfc_t to tiptop;

exit;
