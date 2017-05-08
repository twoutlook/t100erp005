/* 
================================================================================
檔案代號:dbac_t
檔案名稱:片區基本資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:Y
============.========================.==========================================
 */
create table dbac_t
(
dbacent       number(5)      ,/* 企業編號 */
dbac001       varchar2(10)      ,/* 片區編號 */
dbac002       varchar2(10)      ,/* 預設路線編號 */
dbacownid       varchar2(20)      ,/* 資料所有者 */
dbacowndp       varchar2(10)      ,/* 資料所屬部門 */
dbaccrtid       varchar2(20)      ,/* 資料建立者 */
dbaccrtdp       varchar2(10)      ,/* 資料建立部門 */
dbaccrtdt       timestamp(0)      ,/* 資料創建日 */
dbacmodid       varchar2(20)      ,/* 資料修改者 */
dbacmoddt       timestamp(0)      ,/* 最近修改日 */
dbacstus       varchar2(10)      ,/* 狀態碼 */
dbacud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
dbacud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
dbacud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
dbacud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
dbacud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
dbacud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
dbacud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
dbacud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
dbacud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
dbacud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
dbacud011       number(20,6)      ,/* 自定義欄位(數字)011 */
dbacud012       number(20,6)      ,/* 自定義欄位(數字)012 */
dbacud013       number(20,6)      ,/* 自定義欄位(數字)013 */
dbacud014       number(20,6)      ,/* 自定義欄位(數字)014 */
dbacud015       number(20,6)      ,/* 自定義欄位(數字)015 */
dbacud016       number(20,6)      ,/* 自定義欄位(數字)016 */
dbacud017       number(20,6)      ,/* 自定義欄位(數字)017 */
dbacud018       number(20,6)      ,/* 自定義欄位(數字)018 */
dbacud019       number(20,6)      ,/* 自定義欄位(數字)019 */
dbacud020       number(20,6)      ,/* 自定義欄位(數字)020 */
dbacud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
dbacud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
dbacud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
dbacud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
dbacud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
dbacud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
dbacud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
dbacud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
dbacud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
dbacud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table dbac_t add constraint dbac_pk primary key (dbacent,dbac001) enable validate;

create unique index dbac_pk on dbac_t (dbacent,dbac001);

grant select on dbac_t to tiptop;
grant update on dbac_t to tiptop;
grant delete on dbac_t to tiptop;
grant insert on dbac_t to tiptop;

exit;
