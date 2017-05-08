/* 
================================================================================
檔案代號:dbaa_t
檔案名稱:銷售區域層級資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table dbaa_t
(
dbaaent       number(5)      ,/* 企業編號 */
dbaa001       varchar2(10)      ,/* 地區編號 */
dbaa002       varchar2(10)      ,/* 層級類型 */
dbaa003       varchar2(10)      ,/* 上級地區編號 */
dbaa004       varchar2(10)      ,/* 上層層級類型 */
dbaastus       varchar2(10)      ,/* 有效碼 */
dbaaownid       varchar2(20)      ,/* 資料所有者 */
dbaaowndp       varchar2(10)      ,/* 資料所屬部門 */
dbaacrtid       varchar2(20)      ,/* 資料建立者 */
dbaacrtdp       varchar2(10)      ,/* 資料建立部門 */
dbaacrtdt       timestamp(0)      ,/* 資料創建日 */
dbaamodid       varchar2(20)      ,/* 資料修改者 */
dbaamoddt       timestamp(0)      ,/* 資料修改日 */
dbaaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
dbaaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
dbaaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
dbaaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
dbaaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
dbaaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
dbaaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
dbaaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
dbaaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
dbaaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
dbaaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
dbaaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
dbaaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
dbaaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
dbaaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
dbaaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
dbaaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
dbaaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
dbaaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
dbaaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
dbaaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
dbaaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
dbaaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
dbaaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
dbaaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
dbaaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
dbaaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
dbaaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
dbaaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
dbaaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table dbaa_t add constraint dbaa_pk primary key (dbaaent,dbaa001) enable validate;

create unique index dbaa_pk on dbaa_t (dbaaent,dbaa001);

grant select on dbaa_t to tiptop;
grant update on dbaa_t to tiptop;
grant delete on dbaa_t to tiptop;
grant insert on dbaa_t to tiptop;

exit;
