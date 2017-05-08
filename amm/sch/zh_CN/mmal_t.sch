/* 
================================================================================
檔案代號:mmal_t
檔案名稱:卡效期延長規則申請檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table mmal_t
(
mmalent       number(5)      ,/* 企業編號 */
mmaldocno       varchar2(20)      ,/* 單據編號 */
mmal000       varchar2(10)      ,/* 申請類別 */
mmal001       varchar2(10)      ,/* 卡種編碼 */
mmal002       number(10,0)      ,/* 組別 */
mmal003       varchar2(10)      ,/* 效期延長 */
mmal004       number(20,6)      ,/* 規則下限 */
mmalacti       varchar2(1)      ,/* 資料有效碼 */
mmalud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mmalud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mmalud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mmalud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mmalud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mmalud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mmalud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mmalud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mmalud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mmalud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mmalud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mmalud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mmalud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mmalud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mmalud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mmalud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mmalud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mmalud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mmalud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mmalud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mmalud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mmalud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mmalud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mmalud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mmalud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mmalud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mmalud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mmalud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mmalud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mmalud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mmal_t add constraint mmal_pk primary key (mmalent,mmaldocno,mmal002,mmal003) enable validate;

create unique index mmal_pk on mmal_t (mmalent,mmaldocno,mmal002,mmal003);

grant select on mmal_t to tiptop;
grant update on mmal_t to tiptop;
grant delete on mmal_t to tiptop;
grant insert on mmal_t to tiptop;

exit;
