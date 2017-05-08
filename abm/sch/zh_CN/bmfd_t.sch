/* 
================================================================================
檔案代號:bmfd_t
檔案名稱:ECN聯產品檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table bmfd_t
(
bmfdent       number(5)      ,/* 企業編號 */
bmfdsite       varchar2(10)      ,/* 營運據點 */
bmfddocno       varchar2(20)      ,/* ECN單號 */
bmfd002       number(10,0)      ,/* 項次 */
bmfd003       varchar2(10)      ,/* 變更方式 */
bmfd004       varchar2(40)      ,/* 聯產品料號 */
bmfd005       number(20,6)      ,/* 預估比率 */
bmfd006       date      ,/* 生效日期 */
bmfd007       date      ,/* 失效日期 */
bmfdud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bmfdud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bmfdud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bmfdud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bmfdud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bmfdud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bmfdud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bmfdud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bmfdud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bmfdud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bmfdud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bmfdud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bmfdud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bmfdud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bmfdud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bmfdud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bmfdud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bmfdud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bmfdud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bmfdud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bmfdud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bmfdud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bmfdud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bmfdud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bmfdud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bmfdud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bmfdud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bmfdud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bmfdud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bmfdud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bmfd_t add constraint bmfd_pk primary key (bmfdent,bmfdsite,bmfddocno,bmfd002) enable validate;

create unique index bmfd_pk on bmfd_t (bmfdent,bmfdsite,bmfddocno,bmfd002);

grant select on bmfd_t to tiptop;
grant update on bmfd_t to tiptop;
grant delete on bmfd_t to tiptop;
grant insert on bmfd_t to tiptop;

exit;
