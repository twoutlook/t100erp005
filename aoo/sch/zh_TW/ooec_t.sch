/* 
================================================================================
檔案代號:ooec_t
檔案名稱:組織結構調整計劃暫存檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table ooec_t
(
ooecent       number(5)      ,/* 企業編號 */
ooec001       varchar2(10)      ,/* 組織類型 */
ooec002       varchar2(10)      ,/* 最上層組織 */
ooec003       varchar2(10)      ,/* 版本 */
ooec004       varchar2(10)      ,/* 組織編號 */
ooec005       varchar2(10)      ,/* 上級組織編號 */
ooec006       date      ,/* 生效日期 */
ooec007       date      ,/* 失效日期 */
ooec008       varchar2(10)      ,/* 申請編號 */
ooecud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
ooecud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
ooecud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
ooecud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
ooecud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
ooecud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
ooecud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
ooecud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
ooecud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
ooecud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
ooecud011       number(20,6)      ,/* 自定義欄位(數字)011 */
ooecud012       number(20,6)      ,/* 自定義欄位(數字)012 */
ooecud013       number(20,6)      ,/* 自定義欄位(數字)013 */
ooecud014       number(20,6)      ,/* 自定義欄位(數字)014 */
ooecud015       number(20,6)      ,/* 自定義欄位(數字)015 */
ooecud016       number(20,6)      ,/* 自定義欄位(數字)016 */
ooecud017       number(20,6)      ,/* 自定義欄位(數字)017 */
ooecud018       number(20,6)      ,/* 自定義欄位(數字)018 */
ooecud019       number(20,6)      ,/* 自定義欄位(數字)019 */
ooecud020       number(20,6)      ,/* 自定義欄位(數字)020 */
ooecud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
ooecud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
ooecud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
ooecud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
ooecud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
ooecud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
ooecud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
ooecud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
ooecud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
ooecud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table ooec_t add constraint ooec_pk primary key (ooecent,ooec001,ooec002,ooec003,ooec004,ooec005,ooec008) enable validate;

create unique index ooec_pk on ooec_t (ooecent,ooec001,ooec002,ooec003,ooec004,ooec005,ooec008);

grant select on ooec_t to tiptop;
grant update on ooec_t to tiptop;
grant delete on ooec_t to tiptop;
grant insert on ooec_t to tiptop;

exit;
