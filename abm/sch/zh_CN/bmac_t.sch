/* 
================================================================================
檔案代號:bmac_t
檔案名稱:產品結構副產品檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table bmac_t
(
bmacent       number(5)      ,/* 企業編號 */
bmacsite       varchar2(10)      ,/* 營運據點 */
bmac001       varchar2(40)      ,/* 主件料號 */
bmac002       varchar2(30)      ,/* 特性 */
bmac003       varchar2(40)      ,/* 副產品料號 */
bmac004       varchar2(10)      ,/* 單位 */
bmac005       number(20,6)      ,/* 數量 */
bmac006       number(20,6)      ,/* 主件底數 */
bmac007       date      ,/* 生效日期 */
bmac008       date      ,/* 失效日期 */
bmacud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bmacud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bmacud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bmacud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bmacud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bmacud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bmacud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bmacud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bmacud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bmacud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bmacud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bmacud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bmacud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bmacud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bmacud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bmacud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bmacud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bmacud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bmacud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bmacud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bmacud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bmacud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bmacud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bmacud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bmacud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bmacud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bmacud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bmacud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bmacud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bmacud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bmac_t add constraint bmac_pk primary key (bmacent,bmacsite,bmac001,bmac002,bmac003) enable validate;

create  index bmac_01 on bmac_t (bmac001,bmac002,bmac003);
create unique index bmac_pk on bmac_t (bmacent,bmacsite,bmac001,bmac002,bmac003);

grant select on bmac_t to tiptop;
grant update on bmac_t to tiptop;
grant delete on bmac_t to tiptop;
grant insert on bmac_t to tiptop;

exit;
