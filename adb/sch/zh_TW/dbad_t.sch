/* 
================================================================================
檔案代號:dbad_t
檔案名稱:站點基本資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:Y
============.========================.==========================================
 */
create table dbad_t
(
dbadent       number(5)      ,/* 企業編號 */
dbad001       varchar2(10)      ,/* 站點編號 */
dbad002       varchar2(10)      ,/* 片區編號 */
dbad003       varchar2(20)      ,/* 聯絡對象識別碼 */
dbadownid       varchar2(20)      ,/* 資料所有者 */
dbadowndp       varchar2(10)      ,/* 資料所屬部門 */
dbadcrtid       varchar2(20)      ,/* 資料建立者 */
dbadcrtdp       varchar2(10)      ,/* 資料建立部門 */
dbadcrtdt       timestamp(0)      ,/* 資料創建日 */
dbadmodid       varchar2(20)      ,/* 資料修改者 */
dbadmoddt       timestamp(0)      ,/* 最近修改日 */
dbadstus       varchar2(10)      ,/* 狀態碼 */
dbadud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
dbadud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
dbadud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
dbadud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
dbadud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
dbadud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
dbadud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
dbadud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
dbadud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
dbadud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
dbadud011       number(20,6)      ,/* 自定義欄位(數字)011 */
dbadud012       number(20,6)      ,/* 自定義欄位(數字)012 */
dbadud013       number(20,6)      ,/* 自定義欄位(數字)013 */
dbadud014       number(20,6)      ,/* 自定義欄位(數字)014 */
dbadud015       number(20,6)      ,/* 自定義欄位(數字)015 */
dbadud016       number(20,6)      ,/* 自定義欄位(數字)016 */
dbadud017       number(20,6)      ,/* 自定義欄位(數字)017 */
dbadud018       number(20,6)      ,/* 自定義欄位(數字)018 */
dbadud019       number(20,6)      ,/* 自定義欄位(數字)019 */
dbadud020       number(20,6)      ,/* 自定義欄位(數字)020 */
dbadud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
dbadud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
dbadud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
dbadud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
dbadud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
dbadud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
dbadud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
dbadud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
dbadud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
dbadud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table dbad_t add constraint dbad_pk primary key (dbadent,dbad001) enable validate;

create unique index dbad_pk on dbad_t (dbadent,dbad001);

grant select on dbad_t to tiptop;
grant update on dbad_t to tiptop;
grant delete on dbad_t to tiptop;
grant insert on dbad_t to tiptop;

exit;
