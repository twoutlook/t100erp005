/* 
================================================================================
檔案代號:psfd_t
檔案名稱:集團MRP版本營運據點群組明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table psfd_t
(
psfdent       number(5)      ,/* 企業編號 */
psfd001       varchar2(10)      ,/* 集團MRP版本 */
psfd002       number(10,0)      ,/* 群組順序 */
psfd003       number(10,0)      ,/* 營運據點順序 */
psfd004       varchar2(10)      ,/* 營運據點 */
psfdud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
psfdud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
psfdud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
psfdud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
psfdud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
psfdud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
psfdud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
psfdud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
psfdud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
psfdud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
psfdud011       number(20,6)      ,/* 自定義欄位(數字)011 */
psfdud012       number(20,6)      ,/* 自定義欄位(數字)012 */
psfdud013       number(20,6)      ,/* 自定義欄位(數字)013 */
psfdud014       number(20,6)      ,/* 自定義欄位(數字)014 */
psfdud015       number(20,6)      ,/* 自定義欄位(數字)015 */
psfdud016       number(20,6)      ,/* 自定義欄位(數字)016 */
psfdud017       number(20,6)      ,/* 自定義欄位(數字)017 */
psfdud018       number(20,6)      ,/* 自定義欄位(數字)018 */
psfdud019       number(20,6)      ,/* 自定義欄位(數字)019 */
psfdud020       number(20,6)      ,/* 自定義欄位(數字)020 */
psfdud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
psfdud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
psfdud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
psfdud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
psfdud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
psfdud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
psfdud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
psfdud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
psfdud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
psfdud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table psfd_t add constraint psfd_pk primary key (psfdent,psfd001,psfd002,psfd003) enable validate;

create unique index psfd_pk on psfd_t (psfdent,psfd001,psfd002,psfd003);

grant select on psfd_t to tiptop;
grant update on psfd_t to tiptop;
grant delete on psfd_t to tiptop;
grant insert on psfd_t to tiptop;

exit;
