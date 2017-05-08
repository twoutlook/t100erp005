/* 
================================================================================
檔案代號:oobn_t
檔案名稱:單據流程設定單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table oobn_t
(
oobnent       number(5)      ,/* 企業編號 */
oobn001       varchar2(10)      ,/* 流程編號 */
oobn002       varchar2(5)      ,/* 前置單別 */
oobn003       varchar2(5)      ,/* 後置單別 */
oobnud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
oobnud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
oobnud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
oobnud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
oobnud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
oobnud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
oobnud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
oobnud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
oobnud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
oobnud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
oobnud011       number(20,6)      ,/* 自定義欄位(數字)011 */
oobnud012       number(20,6)      ,/* 自定義欄位(數字)012 */
oobnud013       number(20,6)      ,/* 自定義欄位(數字)013 */
oobnud014       number(20,6)      ,/* 自定義欄位(數字)014 */
oobnud015       number(20,6)      ,/* 自定義欄位(數字)015 */
oobnud016       number(20,6)      ,/* 自定義欄位(數字)016 */
oobnud017       number(20,6)      ,/* 自定義欄位(數字)017 */
oobnud018       number(20,6)      ,/* 自定義欄位(數字)018 */
oobnud019       number(20,6)      ,/* 自定義欄位(數字)019 */
oobnud020       number(20,6)      ,/* 自定義欄位(數字)020 */
oobnud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
oobnud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
oobnud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
oobnud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
oobnud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
oobnud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
oobnud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
oobnud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
oobnud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
oobnud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table oobn_t add constraint oobn_pk primary key (oobnent,oobn001,oobn002,oobn003) enable validate;

create unique index oobn_pk on oobn_t (oobnent,oobn001,oobn002,oobn003);

grant select on oobn_t to tiptop;
grant update on oobn_t to tiptop;
grant delete on oobn_t to tiptop;
grant insert on oobn_t to tiptop;

exit;
