/* 
================================================================================
檔案代號:ecbd_t
檔案名稱:料件製程用料底稿損耗率檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table ecbd_t
(
ecbdent       number(5)      ,/* 企業編號 */
ecbdsite       varchar2(10)      ,/* 營運據點 */
ecbd001       varchar2(40)      ,/* 製程料號 */
ecbd002       varchar2(10)      ,/* 製程編號 */
ecbd003       number(10,0)      ,/* 製程項次 */
ecbd004       number(10,0)      ,/* 項次 */
ecbd005       number(20,6)      ,/* 起始數量 */
ecbd006       number(20,6)      ,/* 截止數量 */
ecbd007       number(20,6)      ,/* 變動損耗率 */
ecbd008       number(20,6)      ,/* 固定損耗量 */
ecbdud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
ecbdud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
ecbdud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
ecbdud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
ecbdud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
ecbdud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
ecbdud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
ecbdud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
ecbdud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
ecbdud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
ecbdud011       number(20,6)      ,/* 自定義欄位(數字)011 */
ecbdud012       number(20,6)      ,/* 自定義欄位(數字)012 */
ecbdud013       number(20,6)      ,/* 自定義欄位(數字)013 */
ecbdud014       number(20,6)      ,/* 自定義欄位(數字)014 */
ecbdud015       number(20,6)      ,/* 自定義欄位(數字)015 */
ecbdud016       number(20,6)      ,/* 自定義欄位(數字)016 */
ecbdud017       number(20,6)      ,/* 自定義欄位(數字)017 */
ecbdud018       number(20,6)      ,/* 自定義欄位(數字)018 */
ecbdud019       number(20,6)      ,/* 自定義欄位(數字)019 */
ecbdud020       number(20,6)      ,/* 自定義欄位(數字)020 */
ecbdud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
ecbdud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
ecbdud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
ecbdud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
ecbdud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
ecbdud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
ecbdud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
ecbdud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
ecbdud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
ecbdud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table ecbd_t add constraint ecbd_pk primary key (ecbdent,ecbdsite,ecbd001,ecbd002,ecbd003,ecbd004,ecbd005) enable validate;

create unique index ecbd_pk on ecbd_t (ecbdent,ecbdsite,ecbd001,ecbd002,ecbd003,ecbd004,ecbd005);

grant select on ecbd_t to tiptop;
grant update on ecbd_t to tiptop;
grant delete on ecbd_t to tiptop;
grant insert on ecbd_t to tiptop;

exit;
