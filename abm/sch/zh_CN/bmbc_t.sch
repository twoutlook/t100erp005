/* 
================================================================================
檔案代號:bmbc_t
檔案名稱:產品結構插件位置檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table bmbc_t
(
bmbcent       number(5)      ,/* 企業編號 */
bmbcsite       varchar2(10)      ,/* 營運據點 */
bmbc001       varchar2(40)      ,/* 主件料號 */
bmbc002       varchar2(30)      ,/* 特性代碼 */
bmbc003       varchar2(40)      ,/* 元件料號 */
bmbc004       varchar2(10)      ,/* 部位編號 */
bmbc005       timestamp(0)      ,/* 生效日期時間 */
bmbc007       varchar2(10)      ,/* 作業編號 */
bmbc008       varchar2(10)      ,/* 製程段號 */
bmbc009       number(10,0)      ,/* 項次 */
bmbc010       varchar2(10)      ,/* 插件位置 */
bmbc011       number(20,6)      ,/* 數量 */
bmbcud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bmbcud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bmbcud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bmbcud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bmbcud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bmbcud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bmbcud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bmbcud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bmbcud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bmbcud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bmbcud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bmbcud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bmbcud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bmbcud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bmbcud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bmbcud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bmbcud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bmbcud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bmbcud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bmbcud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bmbcud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bmbcud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bmbcud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bmbcud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bmbcud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bmbcud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bmbcud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bmbcud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bmbcud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bmbcud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bmbc_t add constraint bmbc_pk primary key (bmbcent,bmbcsite,bmbc001,bmbc002,bmbc003,bmbc004,bmbc005,bmbc007,bmbc008,bmbc009) enable validate;

create unique index bmbc_pk on bmbc_t (bmbcent,bmbcsite,bmbc001,bmbc002,bmbc003,bmbc004,bmbc005,bmbc007,bmbc008,bmbc009);

grant select on bmbc_t to tiptop;
grant update on bmbc_t to tiptop;
grant delete on bmbc_t to tiptop;
grant insert on bmbc_t to tiptop;

exit;
