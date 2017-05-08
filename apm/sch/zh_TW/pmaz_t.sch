/* 
================================================================================
檔案代號:pmaz_t
檔案名稱:經銷商儲運能力檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pmaz_t
(
pmazent       number(5)      ,/* 企業編號 */
pmaz001       varchar2(10)      ,/* 交易對象編號 */
pmaz002       varchar2(10)      ,/* 車輛類別 */
pmaz003       number(10,0)      ,/* 數量 */
pmazud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmazud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmazud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmazud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmazud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmazud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmazud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmazud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmazud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmazud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmazud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmazud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmazud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmazud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmazud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmazud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmazud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmazud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmazud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmazud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmazud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmazud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmazud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmazud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmazud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmazud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmazud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmazud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmazud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmazud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pmaz_t add constraint pmaz_pk primary key (pmazent,pmaz001,pmaz002) enable validate;

create unique index pmaz_pk on pmaz_t (pmazent,pmaz001,pmaz002);

grant select on pmaz_t to tiptop;
grant update on pmaz_t to tiptop;
grant delete on pmaz_t to tiptop;
grant insert on pmaz_t to tiptop;

exit;
