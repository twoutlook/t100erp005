/* 
================================================================================
檔案代號:bxca_t
檔案名稱:保稅產品結構單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table bxca_t
(
bxcaent       number(5)      ,/* 企業代碼 */
bxcasite       varchar2(10)      ,/* 營運據點 */
bxca001       varchar2(40)      ,/* 主件料號 */
bxca002       timestamp(0)      ,/* 生效日期 */
bxca003       number(10,0)      ,/* 項次 */
bxca004       varchar2(40)      ,/* 元件料號 */
bxca005       timestamp(0)      ,/* 生效日期 */
bxca006       timestamp(0)      ,/* 失效日期 */
bxca007       number(20,6)      ,/* 實用數量 */
bxca008       number(20,6)      ,/* 損耗數量 */
bxca009       number(20,6)      ,/* 應用數量 */
bxca010       varchar2(1)      ,/* 有效否 */
bxcaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bxcaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bxcaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bxcaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bxcaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bxcaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bxcaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bxcaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bxcaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bxcaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bxcaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bxcaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bxcaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bxcaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bxcaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bxcaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bxcaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bxcaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bxcaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bxcaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bxcaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bxcaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bxcaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bxcaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bxcaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bxcaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bxcaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bxcaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bxcaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bxcaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bxca_t add constraint bxca_pk primary key (bxcaent,bxcasite,bxca001,bxca002,bxca004,bxca005) enable validate;

create unique index bxca_pk on bxca_t (bxcaent,bxcasite,bxca001,bxca002,bxca004,bxca005);

grant select on bxca_t to tiptop;
grant update on bxca_t to tiptop;
grant delete on bxca_t to tiptop;
grant insert on bxca_t to tiptop;

exit;
