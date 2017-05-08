/* 
================================================================================
檔案代號:imco_t
檔案名稱:料件主分群使用單位檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table imco_t
(
imcoent       number(5)      ,/* 企業編號 */
imco001       varchar2(10)      ,/* 主分群碼 */
imco002       varchar2(10)      ,/* 可使用交易單位編號 */
imcoud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
imcoud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
imcoud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
imcoud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
imcoud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
imcoud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
imcoud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
imcoud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
imcoud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
imcoud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
imcoud011       number(20,6)      ,/* 自定義欄位(數字)011 */
imcoud012       number(20,6)      ,/* 自定義欄位(數字)012 */
imcoud013       number(20,6)      ,/* 自定義欄位(數字)013 */
imcoud014       number(20,6)      ,/* 自定義欄位(數字)014 */
imcoud015       number(20,6)      ,/* 自定義欄位(數字)015 */
imcoud016       number(20,6)      ,/* 自定義欄位(數字)016 */
imcoud017       number(20,6)      ,/* 自定義欄位(數字)017 */
imcoud018       number(20,6)      ,/* 自定義欄位(數字)018 */
imcoud019       number(20,6)      ,/* 自定義欄位(數字)019 */
imcoud020       number(20,6)      ,/* 自定義欄位(數字)020 */
imcoud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
imcoud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
imcoud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
imcoud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
imcoud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
imcoud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
imcoud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
imcoud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
imcoud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
imcoud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table imco_t add constraint imco_pk primary key (imcoent,imco001,imco002) enable validate;

create unique index imco_pk on imco_t (imcoent,imco001,imco002);

grant select on imco_t to tiptop;
grant update on imco_t to tiptop;
grant delete on imco_t to tiptop;
grant insert on imco_t to tiptop;

exit;
