/* 
================================================================================
檔案代號:oobl_t
檔案名稱:單據別對應作業代號檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table oobl_t
(
ooblent       number(5)      ,/* 企業編號 */
oobl001       varchar2(5)      ,/* 單據別 */
oobl002       varchar2(20)      ,/* 對應作業編號 */
ooblud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
ooblud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
ooblud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
ooblud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
ooblud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
ooblud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
ooblud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
ooblud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
ooblud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
ooblud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
ooblud011       number(20,6)      ,/* 自定義欄位(數字)011 */
ooblud012       number(20,6)      ,/* 自定義欄位(數字)012 */
ooblud013       number(20,6)      ,/* 自定義欄位(數字)013 */
ooblud014       number(20,6)      ,/* 自定義欄位(數字)014 */
ooblud015       number(20,6)      ,/* 自定義欄位(數字)015 */
ooblud016       number(20,6)      ,/* 自定義欄位(數字)016 */
ooblud017       number(20,6)      ,/* 自定義欄位(數字)017 */
ooblud018       number(20,6)      ,/* 自定義欄位(數字)018 */
ooblud019       number(20,6)      ,/* 自定義欄位(數字)019 */
ooblud020       number(20,6)      ,/* 自定義欄位(數字)020 */
ooblud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
ooblud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
ooblud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
ooblud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
ooblud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
ooblud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
ooblud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
ooblud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
ooblud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
ooblud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table oobl_t add constraint oobl_pk primary key (ooblent,oobl001,oobl002) enable validate;

create unique index oobl_pk on oobl_t (ooblent,oobl001,oobl002);

grant select on oobl_t to tiptop;
grant update on oobl_t to tiptop;
grant delete on oobl_t to tiptop;
grant insert on oobl_t to tiptop;

exit;
