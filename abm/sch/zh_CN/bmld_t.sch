/* 
================================================================================
檔案代號:bmld_t
檔案名稱:FAS組合限制檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table bmld_t
(
bmldent       number(5)      ,/* 企業編號 */
bmld001       varchar2(40)      ,/* 範本主件料號 */
bmld002       varchar2(30)      ,/* 特性 */
bmld003       varchar2(10)      ,/* FAS群組 */
bmld004       varchar2(40)      ,/* 元件料號 */
bmld005       varchar2(10)      ,/* 受限FAS群組 */
bmld006       varchar2(40)      ,/* 受限元件料號 */
bmldud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bmldud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bmldud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bmldud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bmldud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bmldud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bmldud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bmldud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bmldud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bmldud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bmldud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bmldud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bmldud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bmldud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bmldud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bmldud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bmldud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bmldud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bmldud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bmldud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bmldud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bmldud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bmldud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bmldud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bmldud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bmldud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bmldud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bmldud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bmldud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bmldud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bmld_t add constraint bmld_pk primary key (bmldent,bmld001,bmld002,bmld003,bmld004,bmld005,bmld006) enable validate;

create unique index bmld_pk on bmld_t (bmldent,bmld001,bmld002,bmld003,bmld004,bmld005,bmld006);

grant select on bmld_t to tiptop;
grant update on bmld_t to tiptop;
grant delete on bmld_t to tiptop;
grant insert on bmld_t to tiptop;

exit;
