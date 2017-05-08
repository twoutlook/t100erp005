/* 
================================================================================
檔案代號:xmoa_t
檔案名稱:銷售分類檔oab_file(janet test)
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table xmoa_t
(
xmoa001       varchar2(10)      ,/* 銷售分類碼 */
xmoa002       varchar2(80)      ,/* 分類名稱 */
xmoaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmoaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmoaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmoaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmoaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmoaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmoaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmoaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmoaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmoaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmoaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmoaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmoaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmoaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmoaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmoaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmoaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmoaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmoaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmoaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmoaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmoaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmoaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmoaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmoaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmoaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmoaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmoaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmoaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmoaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xmoa_t add constraint xmoa_pk primary key (xmoa001) enable validate;

create unique index xmoa_pk on xmoa_t (xmoa001);

grant select on xmoa_t to tiptop;
grant update on xmoa_t to tiptop;
grant delete on xmoa_t to tiptop;
grant insert on xmoa_t to tiptop;

exit;
