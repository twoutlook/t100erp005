/* 
================================================================================
檔案代號:gzsy_t
檔案名稱:單據別參數單據性質表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table gzsy_t
(
gzsy001       varchar2(15)      ,/* 表格編號 */
gzsy002       varchar2(10)      ,/* 參數編號 */
gzsy003       varchar2(4)      ,/* 模組別 */
gzsy004       varchar2(20)      ,/* 關聯單據性質 */
gzsy005       varchar2(1)      ,/* 已拋轉 */
gzsyud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gzsyud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gzsyud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gzsyud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gzsyud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gzsyud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gzsyud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gzsyud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gzsyud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gzsyud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gzsyud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gzsyud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gzsyud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gzsyud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gzsyud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gzsyud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gzsyud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gzsyud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gzsyud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gzsyud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gzsyud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gzsyud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gzsyud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gzsyud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gzsyud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gzsyud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gzsyud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gzsyud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gzsyud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gzsyud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table gzsy_t add constraint gzsy_pk primary key (gzsy001,gzsy002,gzsy004) enable validate;

create unique index gzsy_pk on gzsy_t (gzsy001,gzsy002,gzsy004);

grant select on gzsy_t to tiptop;
grant update on gzsy_t to tiptop;
grant delete on gzsy_t to tiptop;
grant insert on gzsy_t to tiptop;

exit;
