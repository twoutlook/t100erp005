/* 
================================================================================
檔案代號:gzwa_t
檔案名稱:library註冊主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table gzwa_t
(
gzwa001       varchar2(20)      ,/* 4gl程式編號 */
gzwa002       varchar2(40)      ,/* 函式編號 */
gzwa003       varchar2(1)      ,/* 客製 */
gzwa004       varchar2(1)      ,/* 內部函式區別碼 */
gzwa005       varchar2(20)      ,/* 現行版本 */
gzwa006       varchar2(500)      ,/* 函式目的 */
gzwa007       varchar2(500)      ,/* 其他說明 */
gzwaownid       varchar2(20)      ,/* 資料所有者 */
gzwaowndp       varchar2(10)      ,/* 資料所屬部門 */
gzwacrtid       varchar2(20)      ,/* 資料建立者 */
gzwacrtdp       varchar2(10)      ,/* 資料建立部門 */
gzwacrtdt       timestamp(0)      ,/* 資料創建日 */
gzwamodid       varchar2(20)      ,/* 資料修改者 */
gzwamoddt       timestamp(0)      ,/* 最近修改日 */
gzwaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gzwaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gzwaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gzwaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gzwaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gzwaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gzwaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gzwaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gzwaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gzwaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gzwaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gzwaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gzwaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gzwaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gzwaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gzwaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gzwaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gzwaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gzwaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gzwaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gzwaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gzwaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gzwaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gzwaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gzwaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gzwaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gzwaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gzwaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gzwaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gzwaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table gzwa_t add constraint gzwa_pk primary key (gzwa001,gzwa002) enable validate;

create unique index gzwa_pk on gzwa_t (gzwa001,gzwa002);

grant select on gzwa_t to tiptop;
grant update on gzwa_t to tiptop;
grant delete on gzwa_t to tiptop;
grant insert on gzwa_t to tiptop;

exit;
