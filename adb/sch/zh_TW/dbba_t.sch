/* 
================================================================================
檔案代號:dbba_t
檔案名稱:產品組基本資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table dbba_t
(
dbbaent       number(5)      ,/* 企業編號 */
dbba001       varchar2(10)      ,/* 產品組編號 */
dbba002       varchar2(10)      ,/* 組合標準 */
dbbaownid       varchar2(20)      ,/* 資料所有者 */
dbbaowndp       varchar2(10)      ,/* 資料所屬部門 */
dbbacrtid       varchar2(20)      ,/* 資料建立者 */
dbbacrtdp       varchar2(10)      ,/* 資料建立部門 */
dbbacrtdt       timestamp(0)      ,/* 資料創建日 */
dbbamodid       varchar2(20)      ,/* 資料修改者 */
dbbamoddt       timestamp(0)      ,/* 最近修改日 */
dbbastus       varchar2(10)      ,/* 狀態碼 */
dbbaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
dbbaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
dbbaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
dbbaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
dbbaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
dbbaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
dbbaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
dbbaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
dbbaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
dbbaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
dbbaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
dbbaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
dbbaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
dbbaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
dbbaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
dbbaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
dbbaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
dbbaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
dbbaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
dbbaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
dbbaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
dbbaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
dbbaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
dbbaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
dbbaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
dbbaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
dbbaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
dbbaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
dbbaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
dbbaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table dbba_t add constraint dbba_pk primary key (dbbaent,dbba001) enable validate;

create unique index dbba_pk on dbba_t (dbbaent,dbba001);

grant select on dbba_t to tiptop;
grant update on dbba_t to tiptop;
grant delete on dbba_t to tiptop;
grant insert on dbba_t to tiptop;

exit;
