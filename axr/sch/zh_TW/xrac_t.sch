/* 
================================================================================
檔案代號:xrac_t
檔案名稱:多帳期設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table xrac_t
(
xracent       number(5)      ,/* 企業編號 */
xrac001       number(5)      ,/* 應用分類 */
xrac002       varchar2(10)      ,/* 多帳期編號 */
xrac003       number(5,0)      ,/* 帳期 */
xrac004       number(5,0)      ,/* 間隔（季） */
xrac005       number(5,0)      ,/* 間隔（月） */
xrac006       number(5,0)      ,/* 間隔（日） */
xrac007       varchar2(10)      ,/* 款別類型 */
xrac008       number(20,6)      ,/* 分期比率 */
xracud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xracud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xracud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xracud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xracud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xracud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xracud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xracud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xracud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xracud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xracud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xracud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xracud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xracud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xracud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xracud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xracud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xracud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xracud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xracud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xracud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xracud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xracud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xracud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xracud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xracud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xracud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xracud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xracud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xracud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xrac_t add constraint xrac_pk primary key (xracent,xrac001,xrac002,xrac003) enable validate;

create unique index xrac_pk on xrac_t (xracent,xrac001,xrac002,xrac003);

grant select on xrac_t to tiptop;
grant update on xrac_t to tiptop;
grant delete on xrac_t to tiptop;
grant insert on xrac_t to tiptop;

exit;
