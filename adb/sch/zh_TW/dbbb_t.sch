/* 
================================================================================
檔案代號:dbbb_t
檔案名稱:產品組組合標準基本資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table dbbb_t
(
dbbbent       number(5)      ,/* 企業編號 */
dbbb001       varchar2(10)      ,/* 產品組編號 */
dbbb002       varchar2(10)      ,/* 組合標準 */
dbbb003       varchar2(10)      ,/* 組合條件編號 */
dbbbownid       varchar2(20)      ,/* 資料所有者 */
dbbbowndp       varchar2(10)      ,/* 資料所屬部門 */
dbbbcrtid       varchar2(20)      ,/* 資料建立者 */
dbbbcrtdp       varchar2(10)      ,/* 資料建立部門 */
dbbbcrtdt       timestamp(0)      ,/* 資料創建日 */
dbbbmodid       varchar2(20)      ,/* 資料修改者 */
dbbbmoddt       timestamp(0)      ,/* 最近修改日 */
dbbbstus       varchar2(10)      ,/* 狀態碼 */
dbbbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
dbbbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
dbbbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
dbbbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
dbbbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
dbbbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
dbbbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
dbbbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
dbbbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
dbbbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
dbbbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
dbbbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
dbbbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
dbbbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
dbbbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
dbbbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
dbbbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
dbbbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
dbbbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
dbbbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
dbbbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
dbbbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
dbbbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
dbbbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
dbbbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
dbbbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
dbbbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
dbbbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
dbbbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
dbbbud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table dbbb_t add constraint dbbb_pk primary key (dbbbent,dbbb001,dbbb003) enable validate;

create unique index dbbb_pk on dbbb_t (dbbbent,dbbb001,dbbb003);

grant select on dbbb_t to tiptop;
grant update on dbbb_t to tiptop;
grant delete on dbbb_t to tiptop;
grant insert on dbbb_t to tiptop;

exit;
