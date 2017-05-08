/* 
================================================================================
檔案代號:imbo_t
檔案名稱:料件申請料號使用單位檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table imbo_t
(
imboent       number(5)      ,/* 企業編號 */
imbodocno       varchar2(20)      ,/* 申請單號 */
imbo000       varchar2(10)      ,/* 申請類別 */
imbo001       varchar2(40)      ,/* 料件編號 */
imbo002       varchar2(10)      ,/* 可使用交易單位編號 */
imboud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
imboud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
imboud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
imboud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
imboud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
imboud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
imboud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
imboud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
imboud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
imboud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
imboud011       number(20,6)      ,/* 自定義欄位(數字)011 */
imboud012       number(20,6)      ,/* 自定義欄位(數字)012 */
imboud013       number(20,6)      ,/* 自定義欄位(數字)013 */
imboud014       number(20,6)      ,/* 自定義欄位(數字)014 */
imboud015       number(20,6)      ,/* 自定義欄位(數字)015 */
imboud016       number(20,6)      ,/* 自定義欄位(數字)016 */
imboud017       number(20,6)      ,/* 自定義欄位(數字)017 */
imboud018       number(20,6)      ,/* 自定義欄位(數字)018 */
imboud019       number(20,6)      ,/* 自定義欄位(數字)019 */
imboud020       number(20,6)      ,/* 自定義欄位(數字)020 */
imboud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
imboud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
imboud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
imboud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
imboud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
imboud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
imboud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
imboud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
imboud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
imboud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table imbo_t add constraint imbo_pk primary key (imboent,imbodocno,imbo002) enable validate;

create unique index imbo_pk on imbo_t (imboent,imbodocno,imbo002);

grant select on imbo_t to tiptop;
grant update on imbo_t to tiptop;
grant delete on imbo_t to tiptop;
grant insert on imbo_t to tiptop;

exit;
