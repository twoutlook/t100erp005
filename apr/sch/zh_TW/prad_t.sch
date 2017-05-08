/* 
================================================================================
檔案代號:prad_t
檔案名稱:取價策略單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table prad_t
(
pradent       number(5)      ,/* 企業編號 */
prad001       varchar2(10)      ,/* 價格編號 */
prad002       number(10,0)      ,/* 順序 */
prad003       varchar2(10)      ,/* 價格來源 */
prad004       varchar2(10)      ,/* 價格類型 */
pradud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pradud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pradud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pradud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pradud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pradud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pradud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pradud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pradud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pradud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pradud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pradud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pradud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pradud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pradud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pradud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pradud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pradud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pradud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pradud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pradud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pradud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pradud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pradud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pradud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pradud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pradud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pradud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pradud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pradud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table prad_t add constraint prad_pk primary key (pradent,prad001,prad002) enable validate;

create unique index prad_pk on prad_t (pradent,prad001,prad002);

grant select on prad_t to tiptop;
grant update on prad_t to tiptop;
grant delete on prad_t to tiptop;
grant insert on prad_t to tiptop;

exit;
