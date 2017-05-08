/* 
================================================================================
檔案代號:bmfe_t
檔案名稱:ECN副產品檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table bmfe_t
(
bmfeent       number(5)      ,/* 企業編號 */
bmfesite       varchar2(10)      ,/* 營運據點 */
bmfedocno       varchar2(20)      ,/* ECN單號 */
bmfe002       number(10,0)      ,/* 項次 */
bmfe003       varchar2(10)      ,/* 變更方式 */
bmfe004       varchar2(40)      ,/* 副產品料號 */
bmfe005       number(20,6)      ,/* 數量 */
bmfe006       number(20,6)      ,/* 主件底數 */
bmfe007       varchar2(10)      ,/* 單位 */
bmfe008       date      ,/* 生效日期 */
bmfe009       date      ,/* 失效日期 */
bmfeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bmfeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bmfeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bmfeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bmfeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bmfeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bmfeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bmfeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bmfeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bmfeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bmfeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bmfeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bmfeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bmfeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bmfeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bmfeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bmfeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bmfeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bmfeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bmfeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bmfeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bmfeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bmfeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bmfeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bmfeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bmfeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bmfeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bmfeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bmfeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bmfeud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bmfe_t add constraint bmfe_pk primary key (bmfeent,bmfesite,bmfedocno,bmfe002) enable validate;

create unique index bmfe_pk on bmfe_t (bmfeent,bmfesite,bmfedocno,bmfe002);

grant select on bmfe_t to tiptop;
grant update on bmfe_t to tiptop;
grant delete on bmfe_t to tiptop;
grant insert on bmfe_t to tiptop;

exit;
