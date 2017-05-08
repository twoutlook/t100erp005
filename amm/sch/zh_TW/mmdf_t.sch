/* 
================================================================================
檔案代號:mmdf_t
檔案名稱:收卡規則單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table mmdf_t
(
mmdfent       number(5)      ,/* 企業編號 */
mmdf001       varchar2(30)      ,/* 活動規則編號 */
mmdf002       varchar2(10)      ,/* 卡種編號 */
mmdf003       varchar2(10)      ,/* 規則類型 */
mmdf004       varchar2(40)      ,/* 規則編碼 */
mmdfstus       varchar2(1)      ,/* 資料有效 */
mmdfud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mmdfud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mmdfud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mmdfud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mmdfud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mmdfud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mmdfud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mmdfud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mmdfud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mmdfud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mmdfud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mmdfud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mmdfud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mmdfud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mmdfud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mmdfud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mmdfud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mmdfud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mmdfud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mmdfud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mmdfud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mmdfud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mmdfud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mmdfud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mmdfud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mmdfud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mmdfud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mmdfud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mmdfud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mmdfud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mmdf_t add constraint mmdf_pk primary key (mmdfent,mmdf001,mmdf003,mmdf004) enable validate;

create unique index mmdf_pk on mmdf_t (mmdfent,mmdf001,mmdf003,mmdf004);

grant select on mmdf_t to tiptop;
grant update on mmdf_t to tiptop;
grant delete on mmdf_t to tiptop;
grant insert on mmdf_t to tiptop;

exit;
