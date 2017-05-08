/* 
================================================================================
檔案代號:imam_t
檔案名稱:料件國際認證編號檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table imam_t
(
imament       number(5)      ,/* 企業編號 */
imam001       varchar2(40)      ,/* 料件編號 */
imam002       varchar2(10)      ,/* 認證類型 */
imam003       varchar2(40)      ,/* 認證編號 */
imam004       varchar2(255)      ,/* 補充說明 */
imam005       varchar2(255)      ,/* 認證單位 */
imam006       date      ,/* 認證日期 */
imamud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
imamud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
imamud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
imamud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
imamud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
imamud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
imamud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
imamud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
imamud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
imamud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
imamud011       number(20,6)      ,/* 自定義欄位(數字)011 */
imamud012       number(20,6)      ,/* 自定義欄位(數字)012 */
imamud013       number(20,6)      ,/* 自定義欄位(數字)013 */
imamud014       number(20,6)      ,/* 自定義欄位(數字)014 */
imamud015       number(20,6)      ,/* 自定義欄位(數字)015 */
imamud016       number(20,6)      ,/* 自定義欄位(數字)016 */
imamud017       number(20,6)      ,/* 自定義欄位(數字)017 */
imamud018       number(20,6)      ,/* 自定義欄位(數字)018 */
imamud019       number(20,6)      ,/* 自定義欄位(數字)019 */
imamud020       number(20,6)      ,/* 自定義欄位(數字)020 */
imamud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
imamud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
imamud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
imamud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
imamud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
imamud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
imamud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
imamud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
imamud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
imamud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table imam_t add constraint imam_pk primary key (imament,imam001,imam002) enable validate;

create  index imam_01 on imam_t (imam003);
create unique index imam_pk on imam_t (imament,imam001,imam002);

grant select on imam_t to tiptop;
grant update on imam_t to tiptop;
grant delete on imam_t to tiptop;
grant insert on imam_t to tiptop;

exit;
