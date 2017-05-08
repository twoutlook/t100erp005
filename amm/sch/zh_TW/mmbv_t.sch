/* 
================================================================================
檔案代號:mmbv_t
檔案名稱:卡積點除外規則單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table mmbv_t
(
mmbvent       number(5)      ,/* 企業編號 */
mmbv001       varchar2(30)      ,/* 活動規則編號 */
mmbv002       varchar2(10)      ,/* 卡種編號 */
mmbv003       varchar2(10)      ,/* 規則類型 */
mmbv004       varchar2(40)      ,/* 規則編碼 */
mmbvstus       varchar2(1)      ,/* 資料有效 */
mmbvud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mmbvud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mmbvud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mmbvud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mmbvud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mmbvud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mmbvud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mmbvud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mmbvud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mmbvud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mmbvud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mmbvud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mmbvud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mmbvud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mmbvud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mmbvud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mmbvud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mmbvud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mmbvud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mmbvud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mmbvud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mmbvud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mmbvud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mmbvud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mmbvud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mmbvud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mmbvud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mmbvud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mmbvud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mmbvud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mmbv_t add constraint mmbv_pk primary key (mmbvent,mmbv001,mmbv003,mmbv004) enable validate;

create unique index mmbv_pk on mmbv_t (mmbvent,mmbv001,mmbv003,mmbv004);

grant select on mmbv_t to tiptop;
grant update on mmbv_t to tiptop;
grant delete on mmbv_t to tiptop;
grant insert on mmbv_t to tiptop;

exit;
