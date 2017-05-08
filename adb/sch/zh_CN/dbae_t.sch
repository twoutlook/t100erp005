/* 
================================================================================
檔案代號:dbae_t
檔案名稱:裝載點基本資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table dbae_t
(
dbaeent       number(5)      ,/* 企業編號 */
dbae001       varchar2(10)      ,/* 裝載點編號 */
dbae002       varchar2(20)      ,/* 聯絡對象識別碼 */
dbaeownid       varchar2(20)      ,/* 資料所有者 */
dbaeowndp       varchar2(10)      ,/* 資料所屬部門 */
dbaecrtid       varchar2(20)      ,/* 資料建立者 */
dbaecrtdp       varchar2(10)      ,/* 資料建立部門 */
dbaecrtdt       timestamp(0)      ,/* 資料創建日 */
dbaemodid       varchar2(20)      ,/* 資料修改者 */
dbaemoddt       timestamp(0)      ,/* 最近修改日 */
dbaestus       varchar2(10)      ,/* 狀態碼 */
dbaeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
dbaeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
dbaeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
dbaeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
dbaeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
dbaeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
dbaeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
dbaeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
dbaeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
dbaeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
dbaeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
dbaeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
dbaeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
dbaeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
dbaeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
dbaeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
dbaeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
dbaeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
dbaeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
dbaeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
dbaeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
dbaeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
dbaeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
dbaeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
dbaeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
dbaeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
dbaeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
dbaeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
dbaeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
dbaeud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table dbae_t add constraint dbae_pk primary key (dbaeent,dbae001) enable validate;

create unique index dbae_pk on dbae_t (dbaeent,dbae001);

grant select on dbae_t to tiptop;
grant update on dbae_t to tiptop;
grant delete on dbae_t to tiptop;
grant insert on dbae_t to tiptop;

exit;
