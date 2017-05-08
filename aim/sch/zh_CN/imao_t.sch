/* 
================================================================================
檔案代號:imao_t
檔案名稱:料件使用單位檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table imao_t
(
imaoent       number(5)      ,/* 企業編號 */
imao001       varchar2(40)      ,/* 料件編號 */
imao002       varchar2(10)      ,/* 可用交易單位編號 */
imaoud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
imaoud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
imaoud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
imaoud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
imaoud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
imaoud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
imaoud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
imaoud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
imaoud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
imaoud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
imaoud011       number(20,6)      ,/* 自定義欄位(數字)011 */
imaoud012       number(20,6)      ,/* 自定義欄位(數字)012 */
imaoud013       number(20,6)      ,/* 自定義欄位(數字)013 */
imaoud014       number(20,6)      ,/* 自定義欄位(數字)014 */
imaoud015       number(20,6)      ,/* 自定義欄位(數字)015 */
imaoud016       number(20,6)      ,/* 自定義欄位(數字)016 */
imaoud017       number(20,6)      ,/* 自定義欄位(數字)017 */
imaoud018       number(20,6)      ,/* 自定義欄位(數字)018 */
imaoud019       number(20,6)      ,/* 自定義欄位(數字)019 */
imaoud020       number(20,6)      ,/* 自定義欄位(數字)020 */
imaoud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
imaoud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
imaoud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
imaoud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
imaoud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
imaoud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
imaoud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
imaoud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
imaoud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
imaoud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table imao_t add constraint imao_pk primary key (imaoent,imao001,imao002) enable validate;

create unique index imao_pk on imao_t (imaoent,imao001,imao002);

grant select on imao_t to tiptop;
grant update on imao_t to tiptop;
grant delete on imao_t to tiptop;
grant insert on imao_t to tiptop;

exit;
