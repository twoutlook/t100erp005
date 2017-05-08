/* 
================================================================================
檔案代號:ooee_t
檔案名稱:組織類型職能檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table ooee_t
(
ooeeent       number(5)      ,/* 企業編號 */
ooee001       varchar2(10)      ,/* 組織編號 */
ooee002       varchar2(10)      ,/* 類別 */
ooee003       varchar2(10)      ,/* 類型膱能編號 */
ooeeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
ooeeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
ooeeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
ooeeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
ooeeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
ooeeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
ooeeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
ooeeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
ooeeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
ooeeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
ooeeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
ooeeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
ooeeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
ooeeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
ooeeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
ooeeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
ooeeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
ooeeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
ooeeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
ooeeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
ooeeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
ooeeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
ooeeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
ooeeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
ooeeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
ooeeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
ooeeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
ooeeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
ooeeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
ooeeud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table ooee_t add constraint ooee_pk primary key (ooeeent,ooee001,ooee002,ooee003) enable validate;

create unique index ooee_pk on ooee_t (ooeeent,ooee001,ooee002,ooee003);

grant select on ooee_t to tiptop;
grant update on ooee_t to tiptop;
grant delete on ooee_t to tiptop;
grant insert on ooee_t to tiptop;

exit;
