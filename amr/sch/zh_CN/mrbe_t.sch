/* 
================================================================================
檔案代號:mrbe_t
檔案名稱:資源適用產品檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table mrbe_t
(
mrbeent       number(5)      ,/* 企業編號 */
mrbesite       varchar2(10)      ,/* 營運據點 */
mrbe001       varchar2(20)      ,/* 資源編號 */
mrbe002       varchar2(40)      ,/* 適用料號 */
mrbeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mrbeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mrbeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mrbeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mrbeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mrbeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mrbeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mrbeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mrbeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mrbeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mrbeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mrbeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mrbeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mrbeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mrbeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mrbeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mrbeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mrbeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mrbeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mrbeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mrbeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mrbeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mrbeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mrbeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mrbeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mrbeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mrbeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mrbeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mrbeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mrbeud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mrbe_t add constraint mrbe_pk primary key (mrbeent,mrbesite,mrbe001,mrbe002) enable validate;

create unique index mrbe_pk on mrbe_t (mrbeent,mrbesite,mrbe001,mrbe002);

grant select on mrbe_t to tiptop;
grant update on mrbe_t to tiptop;
grant delete on mrbe_t to tiptop;
grant insert on mrbe_t to tiptop;

exit;
