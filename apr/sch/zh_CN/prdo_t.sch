/* 
================================================================================
檔案代號:prdo_t
檔案名稱:促銷規則時間資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table prdo_t
(
prdoent       number(5)      ,/* 企業編號 */
prdounit       varchar2(10)      ,/* 應用組織 */
prdosite       varchar2(10)      ,/* 營運據點 */
prdo001       varchar2(20)      ,/* 規則編號 */
prdo002       number(10,0)      ,/* 組別 */
prdo003       date      ,/* 開始日期 */
prdo004       date      ,/* 結束日期 */
prdo005       varchar2(8)      ,/* 開始時間 */
prdo006       varchar2(8)      ,/* 結束時間 */
prdo007       varchar2(10)      ,/* 固定日期 */
prdo008       varchar2(1)      ,/* 固定星期 */
prdostus       varchar2(10)      ,/* 有效否 */
prdoud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
prdoud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
prdoud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
prdoud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
prdoud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
prdoud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
prdoud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
prdoud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
prdoud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
prdoud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
prdoud011       number(20,6)      ,/* 自定義欄位(數字)011 */
prdoud012       number(20,6)      ,/* 自定義欄位(數字)012 */
prdoud013       number(20,6)      ,/* 自定義欄位(數字)013 */
prdoud014       number(20,6)      ,/* 自定義欄位(數字)014 */
prdoud015       number(20,6)      ,/* 自定義欄位(數字)015 */
prdoud016       number(20,6)      ,/* 自定義欄位(數字)016 */
prdoud017       number(20,6)      ,/* 自定義欄位(數字)017 */
prdoud018       number(20,6)      ,/* 自定義欄位(數字)018 */
prdoud019       number(20,6)      ,/* 自定義欄位(數字)019 */
prdoud020       number(20,6)      ,/* 自定義欄位(數字)020 */
prdoud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
prdoud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
prdoud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
prdoud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
prdoud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
prdoud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
prdoud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
prdoud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
prdoud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
prdoud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table prdo_t add constraint prdo_pk primary key (prdoent,prdo001,prdo002) enable validate;

create unique index prdo_pk on prdo_t (prdoent,prdo001,prdo002);

grant select on prdo_t to tiptop;
grant update on prdo_t to tiptop;
grant delete on prdo_t to tiptop;
grant insert on prdo_t to tiptop;

exit;
