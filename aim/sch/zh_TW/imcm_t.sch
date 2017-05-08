/* 
================================================================================
檔案代號:imcm_t
檔案名稱:料件主分群國際認證編號檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table imcm_t
(
imcment       number(5)      ,/* 企業編號 */
imcm001       varchar2(10)      ,/* 主分群碼 */
imcm002       varchar2(10)      ,/* 認證類型 */
imcm003       varchar2(40)      ,/* 認證編號 */
imcm004       varchar2(255)      ,/* 補充說明 */
imcm005       varchar2(255)      ,/* 認證單位 */
imcm006       date      ,/* 認證日期 */
imcmud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
imcmud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
imcmud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
imcmud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
imcmud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
imcmud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
imcmud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
imcmud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
imcmud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
imcmud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
imcmud011       number(20,6)      ,/* 自定義欄位(數字)011 */
imcmud012       number(20,6)      ,/* 自定義欄位(數字)012 */
imcmud013       number(20,6)      ,/* 自定義欄位(數字)013 */
imcmud014       number(20,6)      ,/* 自定義欄位(數字)014 */
imcmud015       number(20,6)      ,/* 自定義欄位(數字)015 */
imcmud016       number(20,6)      ,/* 自定義欄位(數字)016 */
imcmud017       number(20,6)      ,/* 自定義欄位(數字)017 */
imcmud018       number(20,6)      ,/* 自定義欄位(數字)018 */
imcmud019       number(20,6)      ,/* 自定義欄位(數字)019 */
imcmud020       number(20,6)      ,/* 自定義欄位(數字)020 */
imcmud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
imcmud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
imcmud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
imcmud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
imcmud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
imcmud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
imcmud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
imcmud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
imcmud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
imcmud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table imcm_t add constraint imcm_pk primary key (imcment,imcm001,imcm002) enable validate;

create  index imcm_01 on imcm_t (imcm003);
create unique index imcm_pk on imcm_t (imcment,imcm001,imcm002);

grant select on imcm_t to tiptop;
grant update on imcm_t to tiptop;
grant delete on imcm_t to tiptop;
grant insert on imcm_t to tiptop;

exit;
