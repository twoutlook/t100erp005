/* 
================================================================================
檔案代號:gzpc_t
檔案名稱:排程實際執行依時紀錄表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table gzpc_t
(
gzpcent       number(5)      ,/* 企業編號 */
gzpc000       varchar2(40)      ,/* 排程執行序號 */
gzpc001       varchar2(40)      ,/* 排程編號 */
gzpc002       timestamp(0)      ,/* 排程執行時間 */
gzpc003       varchar2(1)      ,/* 排程執行模式 */
gzpc004       varchar2(1)      ,/* 排程執行狀況 */
gzpc005       varchar2(80)      ,/* 超過預估時間通知郵件位置 */
gzpc006       timestamp(0)      ,/* 執行結束時間 */
gzpcud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gzpcud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gzpcud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gzpcud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gzpcud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gzpcud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gzpcud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gzpcud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gzpcud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gzpcud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gzpcud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gzpcud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gzpcud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gzpcud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gzpcud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gzpcud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gzpcud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gzpcud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gzpcud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gzpcud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gzpcud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gzpcud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gzpcud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gzpcud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gzpcud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gzpcud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gzpcud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gzpcud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gzpcud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gzpcud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
gzpc007       number(5,0)      /* 預估最長執行時間(分鐘) */
);
alter table gzpc_t add constraint gzpc_pk primary key (gzpcent,gzpc000) enable validate;

create unique index gzpc_pk on gzpc_t (gzpcent,gzpc000);

grant select on gzpc_t to tiptop;
grant update on gzpc_t to tiptop;
grant delete on gzpc_t to tiptop;
grant insert on gzpc_t to tiptop;

exit;
