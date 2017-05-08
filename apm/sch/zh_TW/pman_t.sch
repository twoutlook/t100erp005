/* 
================================================================================
檔案代號:pman_t
檔案名稱:採購取價方式單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pman_t
(
pmanent       number(5)      ,/* 企業編號 */
pman001       varchar2(10)      ,/* 取價方式編號 */
pman002       number(5,0)      ,/* 取價順序 */
pman003       varchar2(10)      ,/* 取價來源 */
pman004       number(5,0)      ,/* 計算月數 */
pman005       varchar2(20)      ,/* 彈性價格對應作業 */
pmanud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmanud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmanud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmanud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmanud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmanud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmanud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmanud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmanud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmanud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmanud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmanud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmanud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmanud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmanud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmanud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmanud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmanud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmanud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmanud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmanud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmanud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmanud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmanud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmanud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmanud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmanud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmanud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmanud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmanud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pman_t add constraint pman_pk primary key (pmanent,pman001,pman002) enable validate;

create unique index pman_pk on pman_t (pmanent,pman001,pman002);

grant select on pman_t to tiptop;
grant update on pman_t to tiptop;
grant delete on pman_t to tiptop;
grant insert on pman_t to tiptop;

exit;
