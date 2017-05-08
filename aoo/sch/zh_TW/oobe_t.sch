/* 
================================================================================
檔案代號:oobe_t
檔案名稱:單據別庫存標籤限定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table oobe_t
(
oobeent       number(5)      ,/* 企業編號 */
oobe001       varchar2(5)      ,/* 參照表號 */
oobe002       varchar2(5)      ,/* 單據別 */
oobe003       varchar2(20)      ,/* 庫存標籤編號From */
oobe004       varchar2(20)      ,/* 庫存標籤編號To */
oobe005       varchar2(1)      ,/* 可用From */
oobe006       varchar2(1)      ,/* 可用To */
oobe007       varchar2(1)      ,/* MRP可用From */
oobe008       varchar2(1)      ,/* MRP可用To */
oobe009       varchar2(1)      ,/* 成本倉From */
oobe010       varchar2(1)      ,/* 成本倉To */
oobeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
oobeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
oobeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
oobeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
oobeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
oobeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
oobeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
oobeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
oobeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
oobeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
oobeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
oobeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
oobeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
oobeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
oobeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
oobeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
oobeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
oobeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
oobeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
oobeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
oobeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
oobeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
oobeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
oobeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
oobeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
oobeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
oobeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
oobeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
oobeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
oobeud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table oobe_t add constraint oobe_pk primary key (oobeent,oobe001,oobe002,oobe003,oobe004) enable validate;

create unique index oobe_pk on oobe_t (oobeent,oobe001,oobe002,oobe003,oobe004);

grant select on oobe_t to tiptop;
grant update on oobe_t to tiptop;
grant delete on oobe_t to tiptop;
grant insert on oobe_t to tiptop;

exit;
