/* 
================================================================================
檔案代號:rtab_t
檔案名稱:店群門店資料明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table rtab_t
(
rtabent       number(5)      ,/* 企業編號 */
rtab001       varchar2(10)      ,/* 店群編號 */
rtab002       varchar2(10)      ,/* 門店編號 */
rtabud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rtabud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rtabud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rtabud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rtabud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rtabud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rtabud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rtabud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rtabud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rtabud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rtabud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rtabud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rtabud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rtabud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rtabud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rtabud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rtabud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rtabud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rtabud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rtabud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rtabud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rtabud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rtabud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rtabud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rtabud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rtabud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rtabud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rtabud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rtabud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rtabud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table rtab_t add constraint rtab_pk primary key (rtabent,rtab001,rtab002) enable validate;

create  index rtab_01 on rtab_t (rtab002);
create unique index rtab_pk on rtab_t (rtabent,rtab001,rtab002);

grant select on rtab_t to tiptop;
grant update on rtab_t to tiptop;
grant delete on rtab_t to tiptop;
grant insert on rtab_t to tiptop;

exit;
