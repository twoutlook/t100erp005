/* 
================================================================================
檔案代號:logv_t
檔案名稱:ETL匯入記錄檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table logv_t
(
logvent       number(5)      ,/* 企業代號 */
logv001       varchar2(20)      ,/* 作業代號 */
logv002       timestamp(0)      ,/* 匯入時間 */
logv003       varchar2(20)      ,/* 匯入者 */
logv004       varchar2(255)      ,/* 匯入檔案名稱 */
logv005       varchar2(255)      ,/* ETL JOB名稱 */
logv006       varchar2(1)      ,/* 處理方式 */
logv007       varchar2(10)      ,/* 處理狀況 */
logv008       varchar2(255)      ,/* 互動訊息 */
logv009       varchar2(255)      ,/* ETL JOB 執行記錄網址 */
logv010       varchar2(40)      ,/* request id */
logvud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
logvud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
logvud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
logvud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
logvud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
logvud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
logvud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
logvud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
logvud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
logvud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
logvud011       number(20,6)      ,/* 自定義欄位(數字)011 */
logvud012       number(20,6)      ,/* 自定義欄位(數字)012 */
logvud013       number(20,6)      ,/* 自定義欄位(數字)013 */
logvud014       number(20,6)      ,/* 自定義欄位(數字)014 */
logvud015       number(20,6)      ,/* 自定義欄位(數字)015 */
logvud016       number(20,6)      ,/* 自定義欄位(數字)016 */
logvud017       number(20,6)      ,/* 自定義欄位(數字)017 */
logvud018       number(20,6)      ,/* 自定義欄位(數字)018 */
logvud019       number(20,6)      ,/* 自定義欄位(數字)019 */
logvud020       number(20,6)      ,/* 自定義欄位(數字)020 */
logvud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
logvud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
logvud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
logvud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
logvud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
logvud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
logvud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
logvud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
logvud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
logvud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table logv_t add constraint logv_pk primary key (logvent,logv001,logv002) enable validate;

create unique index logv_pk on logv_t (logvent,logv001,logv002);

grant select on logv_t to tiptop;
grant update on logv_t to tiptop;
grant delete on logv_t to tiptop;
grant insert on logv_t to tiptop;

exit;
