/* 
================================================================================
檔案代號:dbec_t
檔案名稱:配送預排車次單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:Y
============.========================.==========================================
 */
create table dbec_t
(
dbecent       number(5)      ,/* 企業編號 */
dbecsite       varchar2(10)      ,/* 營運據點 */
dbecunit       varchar2(10)      ,/* 應用組織 */
dbecdocno       varchar2(20)      ,/* 單據編號 */
dbec001       varchar2(10)      ,/* 路線編號 */
dbec002       varchar2(40)      ,/* 車次 */
dbec003       varchar2(20)      ,/* 車輛編號 */
dbec004       varchar2(20)      ,/* 車牌號碼 */
dbec005       number(20,6)      ,/* 承載容積 */
dbec006       varchar2(10)      ,/* 承載容積單位 */
dbec007       number(20,6)      ,/* 承載重量 */
dbec008       varchar2(10)      ,/* 承載重量單位 */
dbec009       varchar2(8)      ,/* 備貨時間 */
dbec010       varchar2(8)      ,/* 到達時間 */
dbec011       varchar2(8)      ,/* 裝車時間 */
dbec012       varchar2(8)      ,/* 發車時間 */
dbec013       varchar2(8)      ,/* 回程時間 */
dbec014       varchar2(40)      ,/* 合併車次 */
dbec015       varchar2(255)      ,/* 備註 */
dbecud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
dbecud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
dbecud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
dbecud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
dbecud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
dbecud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
dbecud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
dbecud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
dbecud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
dbecud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
dbecud011       number(20,6)      ,/* 自定義欄位(數字)011 */
dbecud012       number(20,6)      ,/* 自定義欄位(數字)012 */
dbecud013       number(20,6)      ,/* 自定義欄位(數字)013 */
dbecud014       number(20,6)      ,/* 自定義欄位(數字)014 */
dbecud015       number(20,6)      ,/* 自定義欄位(數字)015 */
dbecud016       number(20,6)      ,/* 自定義欄位(數字)016 */
dbecud017       number(20,6)      ,/* 自定義欄位(數字)017 */
dbecud018       number(20,6)      ,/* 自定義欄位(數字)018 */
dbecud019       number(20,6)      ,/* 自定義欄位(數字)019 */
dbecud020       number(20,6)      ,/* 自定義欄位(數字)020 */
dbecud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
dbecud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
dbecud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
dbecud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
dbecud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
dbecud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
dbecud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
dbecud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
dbecud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
dbecud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table dbec_t add constraint dbec_pk primary key (dbecent,dbecdocno,dbec001,dbec002) enable validate;

create unique index dbec_pk on dbec_t (dbecent,dbecdocno,dbec001,dbec002);

grant select on dbec_t to tiptop;
grant update on dbec_t to tiptop;
grant delete on dbec_t to tiptop;
grant insert on dbec_t to tiptop;

exit;
