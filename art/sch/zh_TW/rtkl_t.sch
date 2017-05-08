/* 
================================================================================
檔案代號:rtkl_t
檔案名稱:自動補貨補貨模型品類日驅勢參數明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table rtkl_t
(
rtklent       number(5)      ,/* 企業編號 */
rtklunit       varchar2(10)      ,/* 應用組織 */
rtkl001       varchar2(10)      ,/* 補貨模型編號 */
rtkl002       varchar2(10)      ,/* 品類編號 */
rtkl101       number(15,3)      ,/* 日趨勢參數(週一) */
rtkl102       number(15,3)      ,/* 日趨勢參數(週二) */
rtkl103       number(15,3)      ,/* 日趨勢參數(週三) */
rtkl104       number(15,3)      ,/* 日趨勢參數(週四) */
rtkl105       number(15,3)      ,/* 日趨勢參數(週五) */
rtkl106       number(15,3)      ,/* 日趨勢參數(週六) */
rtkl107       number(15,3)      ,/* 日趨勢參數(週日) */
rtklud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rtklud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rtklud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rtklud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rtklud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rtklud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rtklud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rtklud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rtklud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rtklud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rtklud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rtklud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rtklud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rtklud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rtklud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rtklud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rtklud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rtklud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rtklud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rtklud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rtklud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rtklud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rtklud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rtklud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rtklud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rtklud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rtklud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rtklud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rtklud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rtklud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table rtkl_t add constraint rtkl_pk primary key (rtklent,rtkl001,rtkl002) enable validate;

create unique index rtkl_pk on rtkl_t (rtklent,rtkl001,rtkl002);

grant select on rtkl_t to tiptop;
grant update on rtkl_t to tiptop;
grant delete on rtkl_t to tiptop;
grant insert on rtkl_t to tiptop;

exit;
