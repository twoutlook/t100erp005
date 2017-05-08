/* 
================================================================================
檔案代號:oobb_t
檔案名稱:單據別預設欄位檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table oobb_t
(
oobbent       number(5)      ,/* 企業編號 */
oobb001       varchar2(5)      ,/* 參照表號 */
oobb002       varchar2(5)      ,/* 單據別 */
oobb003       number(10,0)      ,/* 序號 */
oobb004       varchar2(20)      ,/* 欄位編號 */
oobb005       varchar2(100)      ,/* 預設值 */
oobb006       varchar2(255)      ,/* 預設值說明 */
oobb007       varchar2(1)      ,/* 可更改 */
oobb008       varchar2(255)      ,/* 備註 */
oobbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
oobbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
oobbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
oobbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
oobbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
oobbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
oobbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
oobbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
oobbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
oobbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
oobbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
oobbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
oobbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
oobbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
oobbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
oobbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
oobbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
oobbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
oobbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
oobbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
oobbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
oobbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
oobbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
oobbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
oobbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
oobbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
oobbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
oobbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
oobbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
oobbud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table oobb_t add constraint oobb_pk primary key (oobbent,oobb001,oobb002,oobb003) enable validate;

create  index oobb_01 on oobb_t (oobb004);
create unique index oobb_pk on oobb_t (oobbent,oobb001,oobb002,oobb003);

grant select on oobb_t to tiptop;
grant update on oobb_t to tiptop;
grant delete on oobb_t to tiptop;
grant insert on oobb_t to tiptop;

exit;
