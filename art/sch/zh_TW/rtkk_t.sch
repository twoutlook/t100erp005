/* 
================================================================================
檔案代號:rtkk_t
檔案名稱:自動補貨補貨模型品類週驅勢修正系數明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table rtkk_t
(
rtkkent       number(5)      ,/* 企業編號 */
rtkkunit       varchar2(10)      ,/* 應用組織 */
rtkk001       varchar2(10)      ,/* 補貨模型編號 */
rtkk002       number(15,3)      ,/* 起始值 */
rtkk003       number(15,3)      ,/* 結束值 */
rtkk004       number(20,6)      ,/* 校正系數 */
rtkkud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rtkkud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rtkkud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rtkkud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rtkkud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rtkkud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rtkkud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rtkkud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rtkkud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rtkkud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rtkkud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rtkkud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rtkkud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rtkkud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rtkkud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rtkkud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rtkkud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rtkkud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rtkkud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rtkkud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rtkkud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rtkkud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rtkkud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rtkkud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rtkkud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rtkkud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rtkkud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rtkkud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rtkkud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rtkkud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table rtkk_t add constraint rtkk_pk primary key (rtkkent,rtkk001,rtkk002,rtkk003) enable validate;

create unique index rtkk_pk on rtkk_t (rtkkent,rtkk001,rtkk002,rtkk003);

grant select on rtkk_t to tiptop;
grant update on rtkk_t to tiptop;
grant delete on rtkk_t to tiptop;
grant insert on rtkk_t to tiptop;

exit;
