/* 
================================================================================
檔案代號:gzzk_t
檔案名稱:程式應用參陣列設定表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table gzzk_t
(
gzzk001       varchar2(20)      ,/* 程式編號 */
gzzk002       number(5,0)      ,/* 應用參數組編號 */
gzzk003       varchar2(500)      ,/* 應用參數組說明 */
gzzk004       varchar2(255)      ,/* 應用參數組資料 */
gzzkud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gzzkud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gzzkud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gzzkud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gzzkud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gzzkud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gzzkud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gzzkud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gzzkud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gzzkud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gzzkud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gzzkud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gzzkud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gzzkud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gzzkud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gzzkud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gzzkud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gzzkud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gzzkud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gzzkud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gzzkud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gzzkud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gzzkud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gzzkud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gzzkud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gzzkud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gzzkud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gzzkud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gzzkud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gzzkud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table gzzk_t add constraint gzzk_pk primary key (gzzk001,gzzk002) enable validate;

create unique index gzzk_pk on gzzk_t (gzzk001,gzzk002);

grant select on gzzk_t to tiptop;
grant update on gzzk_t to tiptop;
grant delete on gzzk_t to tiptop;
grant insert on gzzk_t to tiptop;

exit;
