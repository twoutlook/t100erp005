/* 
================================================================================
檔案代號:rtke_t
檔案名稱:自動補貨排除條件設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:Y
============.========================.==========================================
 */
create table rtke_t
(
rtkeent       number(5)      ,/* 企業編號 */
rtkeunit       varchar2(10)      ,/* 應用組織 */
rtke001       varchar2(1)      ,/* 資料類型 */
rtke002       varchar2(10)      ,/* 店群/門店編號 */
rtke003       varchar2(1)      ,/* 排除條件類型 */
rtke004       varchar2(40)      ,/* 排除條件編號 */
rtke005       varchar2(255)      ,/* 備註 */
rtkeownid       varchar2(20)      ,/* 資料所有者 */
rtkeowndp       varchar2(10)      ,/* 資料所屬部門 */
rtkecrtid       varchar2(20)      ,/* 資料建立者 */
rtkecrtdp       varchar2(10)      ,/* 資料建立部門 */
rtkecrtdt       timestamp(0)      ,/* 資料創建日 */
rtkemodid       varchar2(20)      ,/* 資料修改者 */
rtkemoddt       timestamp(0)      ,/* 最近修改日 */
rtkestus       varchar2(10)      ,/* 狀態碼 */
rtkeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rtkeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rtkeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rtkeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rtkeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rtkeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rtkeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rtkeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rtkeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rtkeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rtkeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rtkeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rtkeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rtkeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rtkeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rtkeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rtkeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rtkeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rtkeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rtkeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rtkeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rtkeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rtkeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rtkeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rtkeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rtkeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rtkeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rtkeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rtkeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rtkeud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table rtke_t add constraint rtke_pk primary key (rtkeent,rtke001,rtke002,rtke003,rtke004) enable validate;

create unique index rtke_pk on rtke_t (rtkeent,rtke001,rtke002,rtke003,rtke004);

grant select on rtke_t to tiptop;
grant update on rtke_t to tiptop;
grant delete on rtke_t to tiptop;
grant insert on rtke_t to tiptop;

exit;
