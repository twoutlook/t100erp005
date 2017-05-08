/* 
================================================================================
檔案代號:dbab_t
檔案名稱:路線基本資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table dbab_t
(
dbabent       number(5)      ,/* 企業編號 */
dbab001       varchar2(10)      ,/* 路線編號 */
dbab002       varchar2(10)      ,/* 裝載點編號 */
dbab011       number(15,3)      ,/* 預估行駛時數(去程) */
dbab012       number(15,3)      ,/* 預估總時數(去程) */
dbab013       number(20,6)      ,/* 預估油費(去程) */
dbab014       number(20,6)      ,/* 預估過路費(去程) */
dbab015       number(20,6)      ,/* 預估總費用(去程) */
dbab021       number(15,3)      ,/* 預估行駛時數(回程) */
dbab022       number(15,3)      ,/* 預估總時數(回程) */
dbab023       number(20,6)      ,/* 預估油費(回程) */
dbab024       number(20,6)      ,/* 預估過路費(回程) */
dbab025       number(20,6)      ,/* 預估總費用(回程) */
dbab031       number(15,3)      ,/* 總預估行駛時數 */
dbab032       number(15,3)      ,/* 總預估時數 */
dbab035       number(20,6)      ,/* 總預估油費 */
dbab034       number(20,6)      ,/* 總預估過路費 */
dbab033       number(20,6)      ,/* 總預估費用 */
dbabownid       varchar2(20)      ,/* 資料所有者 */
dbabowndp       varchar2(10)      ,/* 資料所屬部門 */
dbabcrtid       varchar2(20)      ,/* 資料建立者 */
dbabcrtdp       varchar2(10)      ,/* 資料建立部門 */
dbabcrtdt       timestamp(0)      ,/* 資料創建日 */
dbabmodid       varchar2(20)      ,/* 資料修改者 */
dbabmoddt       timestamp(0)      ,/* 最近修改日 */
dbabstus       varchar2(10)      ,/* 狀態碼 */
dbabud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
dbabud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
dbabud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
dbabud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
dbabud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
dbabud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
dbabud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
dbabud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
dbabud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
dbabud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
dbabud011       number(20,6)      ,/* 自定義欄位(數字)011 */
dbabud012       number(20,6)      ,/* 自定義欄位(數字)012 */
dbabud013       number(20,6)      ,/* 自定義欄位(數字)013 */
dbabud014       number(20,6)      ,/* 自定義欄位(數字)014 */
dbabud015       number(20,6)      ,/* 自定義欄位(數字)015 */
dbabud016       number(20,6)      ,/* 自定義欄位(數字)016 */
dbabud017       number(20,6)      ,/* 自定義欄位(數字)017 */
dbabud018       number(20,6)      ,/* 自定義欄位(數字)018 */
dbabud019       number(20,6)      ,/* 自定義欄位(數字)019 */
dbabud020       number(20,6)      ,/* 自定義欄位(數字)020 */
dbabud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
dbabud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
dbabud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
dbabud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
dbabud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
dbabud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
dbabud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
dbabud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
dbabud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
dbabud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table dbab_t add constraint dbab_pk primary key (dbabent,dbab001) enable validate;

create unique index dbab_pk on dbab_t (dbabent,dbab001);

grant select on dbab_t to tiptop;
grant update on dbab_t to tiptop;
grant delete on dbab_t to tiptop;
grant insert on dbab_t to tiptop;

exit;
