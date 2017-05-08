/* 
================================================================================
檔案代號:bmab_t
檔案名稱:產品結構聯產品檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table bmab_t
(
bmabent       number(5)      ,/* 企業編號 */
bmabsite       varchar2(10)      ,/* 營運據點 */
bmab001       varchar2(40)      ,/* 主件料號 */
bmab002       varchar2(30)      ,/* 特性 */
bmab003       varchar2(40)      ,/* 聯產品料號 */
bmab004       number(20,6)      ,/* 預估比率 */
bmab005       date      ,/* 生效日期 */
bmab006       date      ,/* 失效日期 */
bmabud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bmabud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bmabud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bmabud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bmabud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bmabud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bmabud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bmabud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bmabud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bmabud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bmabud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bmabud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bmabud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bmabud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bmabud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bmabud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bmabud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bmabud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bmabud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bmabud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bmabud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bmabud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bmabud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bmabud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bmabud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bmabud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bmabud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bmabud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bmabud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bmabud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bmab_t add constraint bmab_pk primary key (bmabent,bmabsite,bmab001,bmab002,bmab003) enable validate;

create  index bmab_01 on bmab_t (bmab001,bmab002,bmab003);
create unique index bmab_pk on bmab_t (bmabent,bmabsite,bmab001,bmab002,bmab003);

grant select on bmab_t to tiptop;
grant update on bmab_t to tiptop;
grant delete on bmab_t to tiptop;
grant insert on bmab_t to tiptop;

exit;
